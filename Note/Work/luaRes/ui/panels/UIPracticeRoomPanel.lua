---@class UIPracticeRoomPanel:UIBase 练功房npc
local UIPracticeRoomPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIPracticeRoomPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@return UILabel 描述文本
function UIPracticeRoomPanel:GetDescription_UILabel()
    if self.mDesLb == nil then
        self.mDesLb = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "UILabel")
    end
    return self.mDesLb
end

---@return UILoopScrollViewPlus 房间列表
function UIPracticeRoomPanel:GetEnter_UILoopScrollViewPlus()
    if self.mEnterLoop == nil then
        self.mEnterLoop = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "UILoopScrollViewPlus")
    end
    return self.mEnterLoop
end

---@return UnityEngine.GameObject 帮助按钮
function UIPracticeRoomPanel:GetBtnHelp()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    end
    return self.mHelpBtn
end
--endregion

--region 初始化
function UIPracticeRoomPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

---@param mDupType number 副本类型
---@param mDesId  number 描述id
function UIPracticeRoomPanel:Show(mDupType, mDesId)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.PracticeRoom
    self.mDuplicateType = mDupType
    self.mDescriptionId = mDesId
    self.mAllDesData = {}
    self.tblData = clientTableManager.cfg_descriptionManager:TryGetValue(mDesId)
    for i = 1, #self.tblData:GetValueChange().list do
        local conData = clientTableManager.cfg_conditionsManager:TryGetValue(self.tblData:GetValueChange().list[i].list[1])
        table.insert(self.mAllDesData, conData:GetConditionParam().list[0])
    end
    networkRequest.ReqOpenKongFuHousePanel()
end

function UIPracticeRoomPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end

    --打开帮助界面
    CS.UIEventListener.Get(self:GetBtnHelp()).onClick = function()
        Utility.ShowHelpPanel({ id = 194 })
    end
end

function UIPracticeRoomPanel:BindMessage()
    ---@param tblInfo roleV2.ResKongFuHouseTimeLimit
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResKongFuHouseTimeLimitMessage, function(msgId, tblInfo)
        self.mMapIdToTime = {}
        for i = 1, #tblInfo.times do
            local time = tblInfo.times[i]
            local mapId, leaveTime = CS.Utility_Lua.DecodeHD(time, 32, 0x0ffffffff);
            if leaveTime < 0 then
                leaveTime = 0
            end
            if mapId and leaveTime and mapId > 0 and leaveTime >= 0 then
                self.mMapIdToTime[mapId] = math.ceil(leaveTime / 1000)
                self.mLeaveTimeShow = math.ceil(leaveTime / 1000)
            end
        end
        self:RefreshPanel()
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshPanel()
    end)
end

---@return number 剩余时间
function UIPracticeRoomPanel:GetMapStayTime(mapId)
    if self.mMapIdToTime then
        return self.mMapIdToTime[mapId]
    end
end
--endregion

--region 刷新界面
---刷新副本显示
function UIPracticeRoomPanel:RefreshPanel()
    local dupList = self:GetAllDuplicate()
    if dupList == nil then
        return
    end
    if CS.StaticUtility.IsNull(self:GetEnter_UILoopScrollViewPlus()) == false then
        self:GetEnter_UILoopScrollViewPlus():Init(function(go, line)
            if line < #dupList then
                self:RefreshSingleDuplicate(go, dupList[line + 1])
                return true
            else
                return false
            end
        end, nil)
    end
    self:RefreshDetails()
end

---@param data TABLE.cfg_practice_room
function UIPracticeRoomPanel:RefreshSingleDuplicate(go, data)
    if go == nil or data == nil then
        return
    end
    local lb = CS.Utility_Lua.Get(go.transform, "TitleName", "UILabel")
    ---@type UILabel
    local conditionLb = CS.Utility_Lua.Get(go.transform, "condition", "UILabel")
    ---@type UILabel
    local bgeffect = CS.Utility_Lua.Get(go.transform, "background/effect", "GameObject")
    lb.text = data:GetDes()

    local mapId = data:GetDupId()
    local hasData = data:GetDes2()
    conditionLb.gameObject:SetActive(hasData)
    ---@type number 遇到错误-1  条件满足0 练功点不足1 剩余时间不足2
    local state = 0
    local des
    if hasData then
        local time = self:GetMapStayTime(mapId)
        if time == nil then
            state, time, des = self:GetLianGongDianInfo(data)
        else
            if time <= 0 then
                state = 2
            end
        end
        conditionLb.text = string.format(data:GetDes2(), time)
    end
    local isShowEffect = Utility.IsNeedShowLianGongFangTaskEffect(data:GetId())
    bgeffect.gameObject:SetActive(isShowEffect)

    CS.UIEventListener.Get(go).onClick = function()
        if self:CanPlayerEnterDup(mapId, go) == false then
            return
        end

        if state == 1 then
            Utility.ShowPopoTips(go, des, 472)
        elseif state == 2 then
            Utility.ShowPopoTips(go, nil, 473)
        else
            local cost = data:GetExpUpCost()
            if cost and cost.list then
                for i = 1, #cost.list do
                    local allCost = cost.list[i].list
                    if allCost and #allCost >= 2 then
                        local itemId = allCost[1]
                        local num = allCost[2]
                        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
                        if itemTbl then
                            if itemTbl:GetType() == luaEnumItemType.Coin then
                                local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemId)
                                if playerHas < num then
                                    Utility.TryShowFirstRechargePanel()
                                    return
                                end
                            else
                                local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(itemId)
                                if playerHas < num then
                                    Utility.ShowPopoTips(go, itemTbl:GetName() .. "不足", 473)
                                    return
                                end
                            end
                        end
                    end
                end
            end
            Utility.TrySubmitTask("UIPracticeRoomPanel")
            Utility.ReqEnterDuplicate(mapId)
            self:ClosePanel()
        end
    end
end

---判断玩家是否可以进入副本
---@param dupId number 副本id
---@return boolean,string 是否满足条件,条件参数
function UIPracticeRoomPanel:CanPlayerEnterDup(dupId, go)
    ---@type TABLE.CFG_DUPLICATE
    local res, dupInfo = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(dupId)
    if res then
        local mapId = dupInfo.groupID
        if mapId then
            local mapInfo = clientTableManager.cfg_mapManager:TryGetValue(mapId)
            if mapInfo then
                local condition = mapInfo:GetConditionId()
                if condition and condition.list and condition.list.Count >= 1 then
                    local full = Utility.IsMainPlayerMatchCondition(condition.list[0])
                    if full.success == false and self:GetEnterDes() then
                        local str = string.format(self:GetEnterDes(), full.param)
                        Utility.ShowPopoTips(go, str, 477)
                    end
                    return full.success
                end
            end
        end
    end
    return false
end

---描述
function UIPracticeRoomPanel:GetEnterDes()
    if self.mDes == nil then
        local info = clientTableManager.cfg_promptframeManager:TryGetValue(477)
        if info then
            self.mDes = info:GetContent()
        end
    end
    return self.mDes
end

---获得练功点是否满足信息
---@return number,number,string 状态,剩余次数,描述
---@param data TABLE.cfg_practice_room
function UIPracticeRoomPanel:GetLianGongDianInfo(data)
    local des = ""
    local time = 0
    if data:GetExpUpCost() then
        local costList = data:GetExpUpCost().list
        if costList and #costList >= 1 and costList[1].list and #costList[1].list >= 2 then
            local costId = costList[1].list[1]
            local costNum = costList[1].list[2]
            time = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costId)
            if time < costNum then
                local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(costId)
                if itemInfo then
                    ---@type TABLE.CFG_PROMPTFRAME
                    local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(472)
                    if res then
                        des = string.format(desInfo.content, itemInfo:GetName())
                    end
                end
                return 1, time, des
            else
                return 0, time, des
            end
        end
    end
    return -1, time, des
end

---@return table<number,TABLE.cfg_practice_room> list类型副本数据
function UIPracticeRoomPanel:GetAllDuplicate()
    if self.mAllDuplicateInfo == nil then
        self.mAllDuplicateInfo = {}
        ---@param v TABLE.cfg_practice_room
        clientTableManager.cfg_practice_roomManager:ForPair(function(k, v)
            local condition = v:GetShowCondition()
            if condition and #condition.list > 0 then
                if self:IsMainPlayerMatchAllCondition(condition.list) then
                    table.insert(self.mAllDuplicateInfo, v)
                end
            else
                table.insert(self.mAllDuplicateInfo, v)
            end
        end)
    end
    return self.mAllDuplicateInfo
end

---@param list
function UIPracticeRoomPanel:IsMainPlayerMatchAllCondition(list)
    if list == nil then
        return false
    end
    for i = 1, #list do
        local condition = list[i]
        if Utility.IsMainPlayerMatchCondition(condition).success == false then
            return false
        end
    end
    return true
end
--endregion

--region 刷新界面描述
function UIPracticeRoomPanel:RefreshDetails()
    local lianGongDian = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(1000047)
    local res, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(self.mDescriptionId)
    if res then
        local desShow = string.gsub(desInfo.value, '\\n', '\n')
        if lianGongDian and self.mLeaveTimeShow then
            desShow = string.format(desShow, lianGongDian, self.mLeaveTimeShow)
        end
        self:GetDescription_UILabel().text = desShow
        if CS.CSScene.MainPlayerInfo.Level < self.mAllDesData[1] then
            return
        end
        local desID
        for i = 1, #self.mAllDesData do
            if CS.CSScene.MainPlayerInfo.Level >= self.mAllDesData[i] then
                desID = self.tblData:GetValueChange().list[i].list[2]
                local res, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(desID)
                if res then
                    local des2Show = string.gsub(desInfo.value, '\\n', '\n')
                    self:GetDescription_UILabel().text = string.format(des2Show, lianGongDian, self.mLeaveTimeShow)
                end
            end
        end
    end
end

function UIPracticeRoomPanel:GetConditionId()

end
--endregion

return UIPracticeRoomPanel