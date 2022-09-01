---@class UIBonfirePanel:UIBase 篝火界面
local UIBonfirePanel = {}

UIBonfirePanel.mWineId = 8330001
UIBonfirePanel.mZhaoHuanLingId = 8060001

---@return CSMainPlayerInfo 玩家信息
function UIBonfirePanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2
function UIBonfirePanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return CSUnionInfoV2
function UIBonfirePanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mUnionInfoV2 = self:GetMainPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIBonfirePanel:GetCloseBtn_Go()
    if self.mCloseBtnGo == nil then
        self.mCloseBtnGo = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return self.mCloseBtnGo
end

---@return UILabel 经验文本
function UIBonfirePanel:GetExp_Lb()
    if self.mExpLb == nil then
        self.mExpLb = self:GetCurComp("WidgetRoot/value/ExpNum1", "UILabel")
    end
    return self.mExpLb
end

---@return UILabel
function UIBonfirePanel:GetUnionNum_Lb()
    if self.mUnionNumLb == nil then
        self.mUnionNumLb = self:GetCurComp("WidgetRoot/value/ExpNum2", "UILabel")
    end
    return self.mUnionNumLb
end

---@return UILabel 酒气加成
function UIBonfirePanel:GetWineRate_Lb()
    if self.mWineRateLb == nil then
        self.mWineRateLb = self:GetCurComp("WidgetRoot/value/ExpNum3", "UILabel")
    end
    return self.mWineRateLb
end

---@return UILabel 召唤令数目
function UIBonfirePanel:GetZhaoHuanLing_Lb()
    if self.mZhaoHuanLingLb == nil then
        self.mZhaoHuanLingLb = self:GetCurComp("WidgetRoot/value/ExpNum4", "UILabel")
    end
    return self.mZhaoHuanLingLb
end

---@return GameObject 经验狂欢加成文本
function UIBonfirePanel:GetExpActivity_Go()
    if self.mExpActivityGo == nil then
        self.mExpActivityGo = self:GetCurComp("WidgetRoot/title/ExpContent5", "GameObject")
    end
    return self.mExpActivityGo
end

---@return UILabel 经验狂欢加成数值
function UIBonfirePanel:GetExpActivityLb_Go()
    if self.mExpActivityLbGo == nil then
        self.mExpActivityLbGo = self:GetCurComp("WidgetRoot/value/ExpNum5", "GameObject")
    end
    return self.mExpActivityLbGo
end

---@return UILabel 经验狂欢加成
function UIBonfirePanel:GetExpActivity_Lb()
    if self.mExpActivityLb == nil then
        self.mExpActivityLb = self:GetCurComp("WidgetRoot/value/ExpNum5", "UILabel")
    end
    return self.mExpActivityLb
end

---@return UnityEngine.GameObject 酒气add
function UIBonfirePanel:GetWineAdd_GO()
    if self.mWineAddGo == nil then
        self.mWineAddGo = self:GetCurComp("WidgetRoot/value/ExpNum3/add", "GameObject")
    end
    return self.mWineAddGo
end

---@return UnityEngine.GameObject 召唤令add
function UIBonfirePanel:GetZhaoHuanLingAdd_GO()
    if self.mZhaoHuanLingAddGo == nil then
        self.mZhaoHuanLingAddGo = self:GetCurComp("WidgetRoot/value/ExpNum4/add", "GameObject")
    end
    return self.mZhaoHuanLingAddGo
end

---@return UnityEngine.GameObject 行会召唤
function UIBonfirePanel:GetZhaoHuan_Btn()
    if self.mZhaoHuanBtn == nil then
        self.mZhaoHuanBtn = self:GetCurComp("WidgetRoot/value/ExpNum4/btn_call", "GameObject")
    end
    return self.mZhaoHuanBtn
end

---@return UILabel 标题
function UIBonfirePanel:GetName_Lb()
    if self.mNameLb == nil then
        self.mNameLb = self:GetCurComp("WidgetRoot/OfflineTimeContent", "UILabel")
    end
    return self.mNameLb
end
--endregion

--region 初始化


function UIBonfirePanel:Init()
    self:BindEvents()
    self:BindMessage()
end

---@param type number 篝火表id
---@param lid number 篝火lid
function UIBonfirePanel:Show(lid, type)
    if lid and type then
        self.mFireType = type
        self.mLid = lid
        networkRequest.ReqBonfireInfo(lid)
        local data = clientTableManager.cfg_bonfireManager:TryGetValue(type)
        if data then
            self:GetName_Lb().text = data:GetName()
        end
    else
        self:ClosePanel()
        return
    end
end

function UIBonfirePanel:ReShowSelf()
    self:RunBaseFunction("ReShowSelf")
    if self.mLid then
        networkRequest.ReqBonfireInfo(self.mLid)
    end
end

function UIBonfirePanel:BindEvents()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBonfireInfoMessage, function(msgId, tblData)
        self:RefreshPanelShow(tblData)
    end)
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetWineAdd_GO()).onClick = function(go)
        self:OnAddWineClicked(go)
    end
    CS.UIEventListener.Get(self:GetZhaoHuanLingAdd_GO()).onClick = function(go)
        Utility.ShowItemGetWay(self.mZhaoHuanLingId, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
    end
    CS.UIEventListener.Get(self:GetZhaoHuan_Btn()).onClick = function(go)
        local lid = self:GetZhaoHuanLingLid()
        local UnionInfoV2 = self:GetUnionInfoV2()
        ---未加入帮会
        if (UnionInfoV2.UnionID == 0) then
            Utility.ShowPopoTips(go, nil, 82)
            return
        end
        ---职位不符
        if (UnionInfoV2.UnionInfo.unionInfo.leaderId ~= 0 and UnionInfoV2.UnionInfo.myPositionInfo < UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition) then
            local pos = uiStaticParameter.PosStringList[UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition]
            local str = pos .. "职位以上可使用"
            Utility.ShowPopoTips(go, str, 83)
            return
        end
        ---组队条件
        if luaclass.UnionDataInfo:TeamCanUseUnionSummonToken() == false then
            Utility.ShowPopoTips(go, nil, 355)
            return
        end

        --[[            ---玩家在60级之前，在所有地图，主角当前不在战斗状态需二次确认
                    if CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and CS.CSScene.MainPlayerInfo.InCombat == false then
                        Utility.ShowSecondConfirmPanel({ PromptWordId = 111, CancelCallBack = function()
                            networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.EServerMapObjectType.Null) })
                        end })
                        return
                    end]]


        networkRequest.ReqUseItem(1, lid, 0, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })

    end
end

function UIBonfirePanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshZhaoHuanLing()
    end)
end
--endregion

function UIBonfirePanel:OnAddWineClicked(go)
    local playerHas = self:GetBagInfoV2():GetItemCountByItemId(self.mWineId)
    if playerHas > 0 then
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.mWineId)
        if itemInfo then
            local bagItemInfo = self:GetBagItemByItemId(self.mWineId)
            if bagItemInfo == nil then
                Utility.ShowItemGetWay(self.mWineId, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
                return
            end
            local res, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            if res then
                ---物品数量大于1时,根据批量使用的类型决定使用数量
                if itemInfo:GetBatchusage() == 1 then
                    ---若可批量使用则弹出数量窗口并选择数量
                    self.mBatchUseItemBagItemInfo = bagItemInfo
                    uimanager:CreatePanel("UIItemCountPanel", nil, { Title = "使 用", ItemInfo = itemTbl, CallBack = function(count)
                        self:OnBatchUseItemCallback(count)
                    end, BeginningCount = 1, MaxCount = bagItemInfo.count })
                elseif itemInfo:GetBatchusage() == 2 then
                    ---若批量使用类型为使用当前格子所有物品
                    networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
                else
                    ---不批量使用
                    networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
                end
            end
        end
    else
        Utility.ShowItemGetWay(self.mWineId, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
    end
end

---批量使用物品回调
---@private
function UIBonfirePanel:OnBatchUseItemCallback(count)
    if count and count > 0 and self.mBatchUseItemBagItemInfo then
        networkRequest.ReqUseItem(count, self.mBatchUseItemBagItemInfo.lid, 0)
        self.mBatchUseItemBagItemInfo = nil
    end
    self.mCurrentTime = CS.UnityEngine.Time.time
end

---根据itemId，获取背包中一个道具
function UIBonfirePanel:GetBagItemByItemId(itemId)
    if self:GetBagInfoV2() then
        local bagItems = self:GetBagInfoV2().BagItems
        for k, v in pairs(bagItems) do
            ---@type bagV2.BagItemInfo
            local bagItemInfo = v
            if bagItemInfo.itemId == itemId then
                return bagItemInfo
            end
        end
    end
end

---@param data mapV2.ResBonfireInfo
function UIBonfirePanel:RefreshPanelShow(data)
    local green = luaEnumColorType.Green
    local red = luaEnumColorType.Red
    local grey = luaEnumColorType.Gray
    self:GetExp_Lb().text = Utility.CombineStringQuickly(green, data.basicExp, "/s")
    local unionColor = data.unionCount > 0 and green or red
    local rate = self:GetCurrentUnionRate(data.unionCount)
    local num = Utility.CombineStringQuickly(unionColor, math.ceil(rate / 100), "%[-]")
    local person = Utility.CombineStringQuickly(grey, "(", data.unionCount, "人)")
    self:GetUnionNum_Lb().text = Utility.CombineStringQuickly(num, person)
    local rate = math.ceil(data.maotaiRate / 100)
    local wineColor = rate == 0 and red or green
    self:GetWineRate_Lb().text = wineColor .. rate .. "%"
    if (data.expCarnivalRate == 0) then
        self:GetExpActivity_Go():SetActive(false)
        self:GetExpActivityLb_Go():SetActive(false)
    else
        self:GetExpActivity_Go():SetActive(true)
        self:GetExpActivityLb_Go():SetActive(true)
        self:GetExpActivity_Lb().text = green .. math.ceil(data.expCarnivalRate / 100) .. "%"
    end
    self:GetWineAdd_GO():SetActive(rate <= 0)
    self:RefreshZhaoHuanLing()
end

---刷新召唤令
function UIBonfirePanel:RefreshZhaoHuanLing()
    local green = luaEnumColorType.Green
    local red = luaEnumColorType.Red
    local playerHas = self:GetBagInfoV2():GetItemCountByItemId(self.mZhaoHuanLingId)
    local zhaoHuanColor = playerHas > 0 and green or red
    self:GetZhaoHuanLingAdd_GO():SetActive(playerHas <= 0)
    self:GetZhaoHuan_Btn():SetActive(playerHas > 0)
    self:GetZhaoHuanLing_Lb().text = zhaoHuanColor .. playerHas .. "[-]/1"
end

function UIBonfirePanel:GetZhaoHuanLingLid()
    local bagItemInfo = self:GetBagItemByItemId(self.mZhaoHuanLingId)
    if bagItemInfo then
        return bagItemInfo.lid
    end
end

---获取当前行会人数加成
function UIBonfirePanel:GetCurrentUnionRate(unionNum)
    if self.mFireType then
        return self:GetTypeData(self.mFireType, unionNum)
    end
    return ""
end

function UIBonfirePanel:GetTypeData(type, unionNum)
    if self.mTypeToData == nil then
        self.mTypeToData = {}
    end
    local info = self.mTypeToData[type]
    if info == nil then
        local res, Data = CS.Cfg_BonfireTableManager.Instance.dic:TryGetValue(self.mFireType)
        if res then
            local add = Data.numberAdd
            info = add
            self.mTypeToData[type] = info
        end
    end
    if info then
        for i = 0, info.list.Count - 1 do
            local singleList = info.list[i].list
            if singleList and singleList.Count >= 3 then
                if unionNum >= singleList[0] and unionNum <= singleList[1] then
                    return singleList[2]
                end
            end
        end
    end
    return ""
end

---关闭界面
function UIBonfirePanel:TryClosePanel(lid)
    if self.mLid == lid then
        self:ClosePanel()
    end
end

function UIBonfirePanel:UpDateInfo()
    if self.mCurrentTime ~= nil and CS.UnityEngine.Time.time - self.mCurrentTime >= 1 then
        if self.mLid then
            networkRequest.ReqBonfireInfo(self.mLid)
        end
        self.mCurrentTime = nil
    end
end

function update()
    UIBonfirePanel:UpDateInfo()
end

return UIBonfirePanel