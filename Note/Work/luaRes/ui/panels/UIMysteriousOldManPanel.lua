---@class UIMysteriousOldManPanel:UIBase
local UIMysteriousOldManPanel = {}

--region 组件
function UIMysteriousOldManPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

function UIMysteriousOldManPanel:GetCostBtn_GameObject()
    if (self.mCostBtn == nil) then
        self.mCostBtn = self:GetCurComp("WidgetRoot/events/ExchangeBtn", "GameObject")
    end
    return self.mCostBtn
end

function UIMysteriousOldManPanel:GetCost_GameObject()
    if (self.mCostGo == nil) then
        self.mCostGo = self:GetCurComp("WidgetRoot/events/cost", "GameObject")
    end
    return self.mCostGo
end

function UIMysteriousOldManPanel:GetAddItemBtn_GameObject()
    if (self.mAddItemBtn == nil) then
        self.mAddItemBtn = self:GetCurComp("WidgetRoot/events/cost/add", "GameObject")
    end
    return self.mAddItemBtn
end

function UIMysteriousOldManPanel:GetExchange_LoopScrollView()
    if (self.mExchangeScrollview == nil) then
        self.mExchangeScrollview = self:GetCurComp("WidgetRoot/view/introduce/labelGroup/ScrollView/loop", "UILoopScrollViewPlus")
    end
    return self.mExchangeScrollview
end

function UIMysteriousOldManPanel:GetMysteriousTable()
    if (self.mChooseExchangeId ~= nil) then
        self.MysteriousTable = clientTableManager.cfg_mysteriousoldmanManager:TryGetValue(self.mChooseExchangeId)
        if (self.MysteriousTable == nil) then
            self.MysteriousTable = clientTableManager.cfg_mysteriousoldmanManager:TryGetValue(1)
        end
        return self.MysteriousTable
    end
end

function UIMysteriousOldManPanel:GetCostIcon_UISprite()
    if (self.mCostIcon == nil) then
        self.mCostIcon = self:GetCurComp("WidgetRoot/events/cost/icon", "Top_UISprite")
    end
    return self.mCostIcon
end

function UIMysteriousOldManPanel:GetCostIcon_GameObject()
    if (self.mCostIconGo == nil) then
        self.mCostIconGo = self:GetCurComp("WidgetRoot/events/cost/icon", "GameObject")
    end
    return self.mCostIconGo
end

function UIMysteriousOldManPanel:GetCostNum_UILabel()
    if (self.mCostNum == nil) then
        self.mCostNum = self:GetCurComp("WidgetRoot/events/cost/num", "Top_UILabel")
    end
    return self.mCostNum
end

---@return roleV2.ResMysteriousExchange
function UIMysteriousOldManPanel:GetMysteriousServerData()
    return gameMgr:GetPlayerDataMgr():GetLuaMysteriousExchangeOldManInfo():GetLuaMysteriousExchangeOldManInfo()
end
--endregion

--region 初始化

function UIMysteriousOldManPanel:Init()
    self.mChooseExchangeId = 1
    self.mChooseExchangedata = nil
    self.line = 0
    self.Initialized = false
    self:BindMessage()
    self:BindUIEvents()
end

function UIMysteriousOldManPanel:Show()
    self:RefreshUIPanel()
end

function UIMysteriousOldManPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function(go)
        self:CloseBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetAddItemBtn_GameObject()).onClick = function(go)
        self:AddBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetCostIcon_GameObject()).onClick = function(go)
        self:CostIconOnClick(go)
    end
    CS.UIEventListener.Get(self:GetCostBtn_GameObject()).onClick = function(go)
        self:ExchangeBtnOnClick(go)
    end
end

function UIMysteriousOldManPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCost(self.mChooseExchangedata)
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMysteriousExchangeMessage, function()
        self:RefreshUIPanel()
    end)
end

--endregion

--region 客户端事件
function UIMysteriousOldManPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UIMysteriousOldManPanel")
end

function UIMysteriousOldManPanel:ExchangeBtnOnClick(go)
    for i = 1, #self:GetMysteriousServerData().info do
        if (self:GetMysteriousServerData().info[i].changId == self.mChooseExchangeId) then
            --说明之前兑换过这个档位的材料
            if (self:GetMysteriousServerData().info[i].changeNum == self.mChooseExchangedata:GetExchangeNum()) then
                --兑换次数已满
                Utility.ShowTips(go, 492)
                return
            else
                --兑换次数未满，需查看材料是否足够
                local conditionId = self.mChooseExchangedata:GetCostItem().list[1]
                local result = Utility.IsMainPlayerMatchCondition(conditionId)
                if result and result.mReplaceMatData then
                    self:GetCost_GameObject():SetActive(true)
                    local itemCount = result.mReplaceMatData.playerHasTotal
                    if (itemCount < result.mReplaceMatData.num) then
                        Utility.ShowTips(go, 493)
                    else
                        networkRequest.ReqMysteriousExchange(self.mChooseExchangeId)
                    end
                    return
                end
            end
        end
    end
    --说明之前未换过这个档位的材料
    local conditionId = self.mChooseExchangedata:GetCostItem().list[1]
    local result = Utility.IsMainPlayerMatchCondition(conditionId)
    if result and result.mReplaceMatData then
        self:GetCost_GameObject():SetActive(true)
        local itemCount = result.mReplaceMatData.playerHasTotal
        if (itemCount < result.mReplaceMatData.num) then
            Utility.ShowTips(go, 493)
        else
            networkRequest.ReqMysteriousExchange(self.mChooseExchangeId)
        end
        return
    end
end

function UIMysteriousOldManPanel:AddBtnOnClick(go)
    local result = Utility.IsMainPlayerMatchCondition(self:GetMysteriousTable():GetCostItem().list[1])
    if result and result.mReplaceMatData then
        local CostItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(result.mReplaceMatData.fullConditionItemId)
        Utility.ShowItemGetWay(CostItemInfo:GetId(), go, LuaEnumWayGetPanelArrowDirType.Left);
    end
end

function UIMysteriousOldManPanel:CostIconOnClick(go)
    local result = Utility.IsMainPlayerMatchCondition(self:GetMysteriousTable():GetCostItem().list[1])
    if result and result.mReplaceMatData then
        local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(result.mReplaceMatData.fullConditionItemId)
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end
end
--endregion

--region 服务器事件

--endregion

--region 界面刷新
function UIMysteriousOldManPanel:RefreshUIPanel()
    self:RefreshGridContainer()
end

function UIMysteriousOldManPanel:RefreshGridContainer()
    local tabledata = {}
    --[[    local infos = clientTableManager.cfg_mysteriousoldmanManager.dic
        for i = 1, #infos do
            local data = clientTableManager.cfg_mysteriousoldmanManager:TryGetValue(i)
            if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(data:GetShowLevel().list)) then
                table.insert(tabledata, data)
            end
        end]]
    clientTableManager.cfg_mysteriousoldmanManager:GetCurShowData(tabledata)
    self:GetExchange_LoopScrollView():Init(function(go, line)
        if line < #tabledata then
            ---@type TABLE.cfg_mysteriousoldman
            if (tabledata[line + 1] ~= nil) then
                ---@type TABLE.cfg_items
                self:RefreshSingleTemplate(tabledata[line + 1], go)

                ---choose初始化
                local chossSeGo = CS.Utility_Lua.Get(go.transform, "choose", "GameObject")
                if chossSeGo then
                    chossSeGo:SetActive(self.line == line)
                end

                ---动态变动（位置不变数据会变）
                if self.line == line and self.mChooseExchangeId ~= tabledata[line + 1]:GetId() then
                    self.mChooseExchangeId = tabledata[line + 1]:GetId()
                    self.mChooseExchangedata = tabledata[line + 1]
                end

                CS.UIEventListener.Get(go).onClick = function(go)
                    self.mChooseExchangeId = tabledata[line + 1]:GetId()
                    self.mChooseExchangedata = tabledata[line + 1]
                    self.line = line
                    if (self.mChooseBG ~= nil) then
                        self.mChooseBG:SetActive(false)
                    end
                    self.mChooseBG = CS.Utility_Lua.Get(go.transform, "choose", "GameObject")
                    self.mChooseBG:SetActive(true)
                    self:RefreshCost(tabledata[line + 1])
                end

                if not self.Initialized then
                    self.Initialized = true
                    self.mChooseExchangeId = tabledata[line + 1]:GetId()
                    self.mChooseExchangedata = tabledata[line + 1]
                    if (self.mChooseBG ~= nil) then
                        self.mChooseBG:SetActive(false)
                    end
                    self.mChooseBG = CS.Utility_Lua.Get(go.transform, "choose", "GameObject")
                    self.mChooseBG:SetActive(true)
                    self:RefreshCost(tabledata[line + 1])
                end
                return true
            else
                return false
            end
        else
            return false
        end
        return false
    end)
end

function UIMysteriousOldManPanel:RefreshSingleTemplate(data, go)
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data:GetGetItem().list[1])
    local icon = CS.Utility_Lua.GetComponent(go.transform:Find("Item/Item/icon"), "Top_UISprite")
    local name = CS.Utility_Lua.GetComponent(go.transform:Find("Label"), "Top_UILabel")
    local num = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "Top_UILabel")
    icon.spriteName = itemInfo.icon
    name.text = itemInfo.name

    CS.UIEventListener.Get(icon.gameObject).onClick = function(go)
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end

    local isfind = false
    for i = 1, #self:GetMysteriousServerData().info do
        if (data:GetId() == self:GetMysteriousServerData().info[i].changId) then
            isfind = true
            num.text = data:GetExchangeNum() - self:GetMysteriousServerData().info[i].changeNum == 0 and
                    "[878787]剩余兑换[-]  " .. "[e85038]" .. (data:GetExchangeNum() - self:GetMysteriousServerData().info[i].changeNum) .. "[-]" .. "/" .. tostring(data:GetExchangeNum())
                    or "[878787]剩余兑换[-]  " .. "[dde6eb]" .. (data:GetExchangeNum() - self:GetMysteriousServerData().info[i].changeNum) .. "[-]" .. "/" .. tostring(data:GetExchangeNum())
        end
    end
    if (isfind == false) then
        num.text = "[878787]剩余兑换[-]  " .. tostring(data:GetExchangeNum()) .. "/" .. tostring(data:GetExchangeNum())
    end
end

function UIMysteriousOldManPanel:RefreshCost(data)
    local conditionId = data:GetCostItem().list[1]
    local result = Utility.IsMainPlayerMatchCondition(conditionId)
    if result and result.mReplaceMatData then
        self:GetCost_GameObject():SetActive(true)
        local CostItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(result.mReplaceMatData.fullConditionItemId)
        self:GetCostIcon_UISprite().spriteName = CostItemInfo:GetIcon()
        local itemCount = result.mReplaceMatData.playerHasTotal
        local text = CS.Utility_Lua.SetProgressLabelColor(itemCount, result.mReplaceMatData.num)
        self:GetCostNum_UILabel().text = text
    end
end
--endregion

function ondestroy()

end

return UIMysteriousOldManPanel