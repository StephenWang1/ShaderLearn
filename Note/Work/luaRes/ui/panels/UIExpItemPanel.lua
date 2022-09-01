---经验丹使用界面
---@class UIExpItemPanel:UIBase
local UIExpItemPanel = {}

--region 组件
---@return UnityEngine.GameObject
function UIExpItemPanel:GetCloseButtonGo()
    if self.mCloseButtonGo == nil then
        self.mCloseButtonGo = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseButtonGo
end

---道具名文本组件
---@return UILabel
function UIExpItemPanel:GetPropNameLabel()
    if self.mPropNameLabel == nil then
        self.mPropNameLabel = self:GetCurComp("WidgetRoot/view/name", "UILabel")
    end
    return self.mPropNameLabel
end

---道具ICON组件
---@return UISprite
function UIExpItemPanel:GetPropIconUISprite()
    if self.mPropIconUISprite == nil then
        self.mPropIconUISprite = self:GetCurComp("WidgetRoot/view/Icon", "UISprite")
    end
    return self.mPropIconUISprite
end

---道具数量文本组件
---@return UILabel
function UIExpItemPanel:GetPropCountUILabel()
    if self.mPropCountUILabel == nil then
        self.mPropCountUILabel = self:GetCurComp("WidgetRoot/view/count", "UILabel")
    end
    return self.mPropCountUILabel
end

---道具数量输入组件
---@return UIInput
function UIExpItemPanel:GetAmountInput()
    if self.mAmountInput == nil then
        self.mAmountInput = self:GetCurComp("WidgetRoot/view/Number/inputcount", "UIInput")
    end
    return self.mAmountInput
end

---@return UnityEngine.GameObject
function UIExpItemPanel:GetAmountAddButton()
    if self.mAmountAddButton == nil then
        self.mAmountAddButton = self:GetCurComp("WidgetRoot/view/Number/add", "GameObject")
    end
    return self.mAmountAddButton
end

---@return UnityEngine.GameObject
function UIExpItemPanel:GetAmountReduceButton()
    if self.mAmountReduceButton == nil then
        self.mAmountReduceButton = self:GetCurComp("WidgetRoot/view/Number/reduce", "GameObject")
    end
    return self.mAmountReduceButton
end

---@return UIGridContainer
function UIExpItemPanel:GetExchangeGridContainer()
    if self.mExchangeGridContainer == nil then
        self.mExchangeGridContainer = self:GetCurComp("WidgetRoot/view/ScrollView/Grid", "UIGridContainer")
    end
    return self.mExchangeGridContainer
end

---@return UILabel
function UIExpItemPanel:GetLastExchangeNumLabel()
    if self.mLastExchangeNumLabel == nil then
        self.mLastExchangeNumLabel = self:GetCurComp("WidgetRoot/view/lb_exchangeNum", "UILabel")
    end
    return self.mLastExchangeNumLabel
end
--endregion

--region 初始化
function UIExpItemPanel:Init()
    self:BindUIEvents()
    self:BindNetMessages()
end

function UIExpItemPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGo()).onClick = function()
        self:ClosePanel()
    end
    CS.EventDelegate.Add(self:GetAmountInput().onChange, function()
        if self.mIsEditingAmountValue then
            return
        end
        local mUseAmount = tonumber(self:GetAmountInput().value)
        if mUseAmount ~= nil then
            self.mUseAmount = mUseAmount
        end
        self:ClampUseAmountInSuitableRange()
    end)
    CS.UIEventListener.Get(self:GetAmountAddButton()).onClick = function()
        if self.mUseAmount == nil then
            self.mUseAmount = 0
        end
        self.mUseAmount = self.mUseAmount + 1
        self:ClampUseAmountInSuitableRange()
    end
    CS.UIEventListener.Get(self:GetAmountReduceButton()).onClick = function()
        if self.mUseAmount == nil then
            self.mUseAmount = 0
        end
        self.mUseAmount = self.mUseAmount - 1
        if self.mUseAmount < 0 then
            ---如果减少时减到了负数,那么切换到一个极大值
            self.mUseAmount = 10000000
        end
        self:ClampUseAmountInSuitableRange()
    end
    CS.UIEventListener.Get(self:GetPropIconUISprite().gameObject).onClick = function()
        if self.mBagItemLid == nil then
            return
        end
        local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mBagItemLid)
        if bagItem == nil then
            return
        end
        local itemID = bagItem.itemId
        local itemTblExist, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemID)
        if itemTbl == nil then
            return
        end
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItem, showRight = false })
    end
end

function UIExpItemPanel:BindNetMessages()
    self:GetClientEventHandler():AddEvent(CS.CEvent.Bag_UpdateBagCount, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if self.mBagItemLid ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mBagItemLid) == nil then
            ---如果当前物品从背包中消耗掉了,关闭界面
            self:ClosePanel()
            return
        end
        self:RefreshUI()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Common_ZeroEvent, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshUI()
    end)
end

function UIExpItemPanel:Show(bagItemLid)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.BuyExpElixir
    self.mBagItemLid = bagItemLid
    if self.mUseAmount == nil then
        ---默认值为最大值,给一个极大值,然后在RefreshUI流程中进行clamp
        --self.mUseAmount = 100000000
        ---默认值为1,给1,然后在RefreshUI流程中进行clamp
        self.mUseAmount = 1
    end
    self:RefreshUI()
end
--endregion

--region UI事件
---@param useInfo ExpPropSingleUseInfo
---@param go UnityEngine.GameObject
function UIExpItemPanel:OnExchangeButtonClicked(useInfo, go)
    if self.mBagItemLid == nil or self.mUseAmount == nil then
        return
    end
    ---今日次数已用完
    if gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing() ~= nil then
        local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mBagItemLid)
        if bagItem then
            local expUseInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing():GetExpPropInfo(bagItem)
            if expUseInfo then
                if expUseInfo.usednumbertoday >= expUseInfo.maxusenumber then
                    Utility.ShowPopoTips(go.transform, "今日次数已用完", 209)
                    return
                end
            end
        end
    end
    if self.mUseAmount == 0 then
        return
    end
    local needCoinItemID = useInfo.coinitemid
    local needCoinAmount = useInfo.coincount * self.mUseAmount
    local coinAmountInBag = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(needCoinItemID)
    if coinAmountInBag < needCoinAmount then
        local coinItem = clientTableManager.cfg_itemsManager:TryGetValue(needCoinItemID)
        if coinItem then
            if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(needCoinItemID)) then
                Utility.TryShowFirstRechargePanel()
                return
            end
            Utility.ShowItemGetWay(needCoinItemID, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(50, 0));
        end
    else
        networkRequest.ReqUseItem(self.mUseAmount, self.mBagItemLid, useInfo.multiple)
    end
end
--endregion

--region 刷新UI
---根据当前的mBagItemLid进行UI的刷新
---@public
function UIExpItemPanel:RefreshUI()
    if self.mBagItemLid and gameMgr:GetPlayerDataMgr() ~= nil then
        local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mBagItemLid)
        if bagItem == nil then
            self:ResetUI()
        else
            self:InternalRefreshUI(bagItem)
        end
    else
        self:ResetUI()
    end
end

---@private
---将使用次数限制在合理范围之内
function UIExpItemPanel:ClampUseAmountInSuitableRange()
    self.mIsEditingAmountValue = true
    local minUseAmount = 0
    local maxUseAmount = 0
    if self.mBagItemLid and gameMgr:GetPlayerDataMgr() ~= nil then
        local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mBagItemLid)
        if bagItem ~= nil then
            maxUseAmount = bagItem.count
            local expPropInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing():GetExpPropInfo(bagItem)
            if expPropInfo.maxusenumber > 0 then
                maxUseAmount = math.min(maxUseAmount, expPropInfo.maxusenumber - expPropInfo.usednumbertoday)
            end
        end
    end
    if self.mUseAmount == nil then
        self.mUseAmount = maxUseAmount
    else
        self.mUseAmount = math.clamp(self.mUseAmount, minUseAmount, maxUseAmount)
    end
    self:GetAmountInput().value = tostring(self.mUseAmount)
    self:RefreshExchangeListUI()
    self.mIsEditingAmountValue = false
end

---@private
---@param bagItem bagV2.BagItemInfo
function UIExpItemPanel:InternalRefreshUI(bagItem)
    if bagItem == nil then
        self:ResetUI()
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItem.itemId)
    if itemTbl == nil then
        self:ResetUI()
        return
    end
    self:GetPropNameLabel().text = itemTbl:GetName()
    if (bagItem.count == nil or bagItem.count <= 1) then
        self:GetPropCountUILabel().text = ""
    else
        self:GetPropCountUILabel().text = tostring(bagItem.count)
    end
    self:GetPropIconUISprite().spriteName = itemTbl:GetIcon()
    self:ClampUseAmountInSuitableRange()
    local list = gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing():GetExpPropMultipleUseConfigInfo(bagItem.itemId)
    local expPropInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerExpPropUsing():GetExpPropInfo(bagItem)
    if expPropInfo == nil then
        self:GetLastExchangeNumLabel().text = ""
    else
        local lastCount = expPropInfo.maxusenumber - expPropInfo.usednumbertoday
        if lastCount == 0 then
            self:GetLastExchangeNumLabel().text = "[878787]剩余次数  [ff0000]" .. tostring(lastCount) .. "[dde6eb]/" .. tostring(expPropInfo.maxusenumber)
        else
            self:GetLastExchangeNumLabel().text = "[878787]剩余次数  [dde6eb]" .. tostring(lastCount) .. "[dde6eb]/" .. tostring(expPropInfo.maxusenumber)
        end
    end
    local conditionMgr = CS.Cfg_ConditionManager.Instance
    local availableList = {}
    for i = 1, #list.exchangelist do
        local useInfo = list.exchangelist[i]
        if useInfo.showconditions == nil or #useInfo.showconditions == 0 then
            table.insert(availableList, useInfo)
        else
            for j = 1, #useInfo.showconditions do
                if conditionMgr:IsMainPlayerMatchCondition(useInfo.showconditions[j]) then
                    table.insert(availableList, useInfo)
                    break
                end
            end
        end
    end
    self:GetExchangeGridContainer().MaxCount = #availableList
    for i = 1, #availableList do
        local go = self:GetExchangeGridContainer().controlList[i - 1]
        local expPropSingleUseInfo = availableList[i]
        local template = self:GetExchangeOptionTemplate(go)
        template:InitializeData(expPropSingleUseInfo, self.mUseAmount or 0)
    end
end

---@return UIExpItemExchangeOption
function UIExpItemPanel:GetExchangeOptionTemplate(go)
    if self.mOptions == nil then
        ---@type table<UnityEngine.GameObject, UIExpItemExchangeOption>
        self.mOptions = {}
    end
    local template = self.mOptions[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIExpItemExchangeOption, self)
        template:BindClickCallBack(function(info, btnGo)
            self:OnExchangeButtonClicked(info, btnGo)
        end)
        self.mOptions[go] = template
    end
    return template
end

---@private
---刷新兑换列表UI
function UIExpItemPanel:RefreshExchangeListUI()
    if self.mOptions == nil or self.mUseAmount == nil then
        return
    end
    for i, v in pairs(self.mOptions) do
        v:RefreshUI(self.mUseAmount)
    end
end

---获取数字的中文简写
---@public
---@param num number
---@param useDecimal boolean|nil
---@return string
function UIExpItemPanel:GetNumberChineseStr(num, useDecimal)
    if num < 10000 then
        return tostring(num)
    elseif num >= 10000 and num < 100000000 then
        return tostring(num)
        --if num % 10000 ~= 0 and useDecimal then
        --    return tostring(math.floor((num / 10000) * 10) / 10) .. "万"
        --else
        --    return tostring(math.floor(num / 10000)) .. "万"
        --end
    elseif num >= 100000000 then
        if num % 100000000 ~= 0 and useDecimal then
            return tostring(math.floor((num / 100000000) * 100) / 100) .. "亿"
        else
            return tostring(math.floor(num / 100000000)) .. "亿"
        end
    end
end

---重置UI
---@public
function UIExpItemPanel:ResetUI()
    self:GetPropIconUISprite().spriteName = ""
    self:GetPropCountUILabel().text = ""
    self:GetPropNameLabel().text = ""
    self:GetExchangeGridContainer().MaxCount = 0
    self:ClampUseAmountInSuitableRange()
    self:GetLastExchangeNumLabel().text = ""
end
--endregion

return UIExpItemPanel