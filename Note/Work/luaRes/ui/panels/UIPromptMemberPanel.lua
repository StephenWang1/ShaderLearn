---@class UIPromptMemberPanel:UIBase
local UIPromptMemberPanel = {}

function UIPromptMemberPanel:Init()
    self:InitComponents()
    self:InitParams()
    self:BindUIEvents()
    self:BindNetMsg()
end

function UIPromptMemberPanel:InitComponents()
    ---@type Top_UILabel  标题
    self.title = self:GetCurComp("view/Title", "Top_UILabel")
    ---@type UIGridContainer  奖励列表
    self.rewardsGrid = self:GetCurComp("view/ScrollView/reward", "UIGridContainer")
    ---@type Top_UILabel  钻石数量
    self.itemGold = self:GetCurComp("view/itemgold/label", "Top_UILabel")
    ---@type Top_UILabel  购买按钮文本
    self.centerBtn_label = self:GetCurComp("events/CenterBtn/Label", "Top_UILabel")

    ---@type GameObject  购买按钮
    self.centerBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    ---@type GameObject  关闭按钮
    self.closeBtn = self:GetCurComp("events/close", "GameObject")

end

function UIPromptMemberPanel:InitParams()
    self.storeInfo = nil
    ---@type TABLE.CFG_STORE
    self.storeTable = nil
end

function UIPromptMemberPanel:BindUIEvents()
    CS.UIEventListener.Get(self.closeBtn).onClick = function(go)
        self:OnClickCloseBtn()
    end
    CS.UIEventListener.Get(self.centerBtn).onClick = function(go)
        self:OnClickCenterBtn()
    end

end

function UIPromptMemberPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResStoreInfoMessage, UIPromptMemberPanel.OnResResStoreInfoMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendStoreInfoChangeMessage, UIPromptMemberPanel.OnResSendStoreInfoChangeMessage)
end

function UIPromptMemberPanel:OnClickCloseBtn()
    uimanager:ClosePanel("UIPromptMemberPanel")
end

function UIPromptMemberPanel:OnClickCenterBtn()
    if self.storeInfo ~= nil and self.storeTable ~= nil then
        if not self:CanBuy() then
            return
        end
        ---货币不够跳转充值
        if CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.storeTable.moneyType) < self.storeInfo.price then
            ---是否首充过
            Utility.TryShowFirstRechargePanel()
            uimanager:ClosePanel("UIPromptMemberPanel")
        else
            networkRequest.ReqBuyItem(self.storeTable.id, 1, self.storeTable.itemId, 1, 0)
            uimanager:ClosePanel("UIPromptMemberPanel")
        end
    end
end

function UIPromptMemberPanel.OnResResStoreInfoMessage(msgID, msgData)
    UIPromptMemberPanel.storeInfo = msgData.storeInfo
    UIPromptMemberPanel:RefreshOther()
    UIPromptMemberPanel:RefreshRewardGrid()
end

function UIPromptMemberPanel.OnResSendStoreInfoChangeMessage(msgID, msgData)
    UIPromptMemberPanel.storeInfo = msgData.storeInfo
    UIPromptMemberPanel:RefreshOther()
    UIPromptMemberPanel:RefreshRewardGrid()
end

---@param storeId 商店id
---@param titleName 会员名字
function UIPromptMemberPanel:Show(titleName, storeId)
    if storeId == nil then
        return
    end
    networkRequest.ReqStoreInfo(storeId)
    self.title.text = string.format("花费钻石可购买%s", titleName)
    local isFind, storeTable = CS.Cfg_StoreTableManager.Instance:TryGetValue(storeId)
    if isFind then
        self.storeTable = storeTable
    end
end

function UIPromptMemberPanel:RefreshRewardGrid()
    if self.storeTable == nil then
        return
    end
    local rewardList = CS.Cfg_BoxTableManager.Instance:GetSemicolonReward(self.storeTable.itemId)
    self.rewardsGrid.MaxCount = rewardList.Count
    for i = 0, rewardList.Count - 1 do
        local go = self.rewardsGrid.controlList[i]
        local info = rewardList[i]
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.itemId)

        if isFind then
            icon.spriteName = itemInfo.icon
            CS.UIEventListener.Get(go).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
            end
        end
        if info.count and info.count > 1 then
            count.text = info.count
        else
            count.text = ""
        end
    end
end

function UIPromptMemberPanel:RefreshOther()
    if self.storeInfo ~= nil and self.storeTable ~= nil then
        ---已有钻石数量
        local coincount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.storeTable.moneyType)
        self.itemGold.text = (coincount < self.storeInfo.price and luaEnumColorType.Red or luaEnumColorType.Green) .. coincount .. "[-]/" .. self.storeInfo.price
        self.centerBtn_label.text = self:CanBuy() and "立即购买" or "已领取"
    end
end

---是否可购买
function UIPromptMemberPanel:CanBuy()
    local remainBuyCount = 0
    if (self.storeTable ~= nil and self.storeTable.singleLimit ~= nil) then

        local list = self.storeTable.singleLimit.list;
        local limitType

        if (list.Count > 0) then
            limitType = list[0]
        end

        if limitType == luaEnumShopLimitType.DayLimit then
            ---每日限购
            if (list.Count > 1) then
                remainBuyCount = list[1] - self.storeInfo.dayBuyNum
            end
        elseif limitType == luaEnumShopLimitType.LifeLimit then
            ---终身限购
            if (list.Count > 1) then
                remainBuyCount = list[1] - self.storeInfo.lifeBuyNum
            end
        end
    end
    return remainBuyCount > 0
end

return UIPromptMemberPanel