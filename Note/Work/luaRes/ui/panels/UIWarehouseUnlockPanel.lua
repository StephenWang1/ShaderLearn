local UIWarehouseUnlockPanel = {}

--region 局部变量定义
---解锁消耗道具ID
UIWarehouseUnlockPanel.mItemId = nil

---解锁小号道具数量
UIWarehouseUnlockPanel.mItemCost = nil
--endregion

--region 组件
---解锁消耗道具图片
function UIWarehouseUnlockPanel.GetItemIcon_UISprite()
    if UIWarehouseUnlockPanel.mItemIcon == nil then
        UIWarehouseUnlockPanel.mItemIcon = UIWarehouseUnlockPanel:GetCurComp("WidgetRoot/view/image", "UISprite")
    end
    return UIWarehouseUnlockPanel.mItemIcon
end

---解锁消耗道具数目
function UIWarehouseUnlockPanel.GetItemNum_UILabel()
    if UIWarehouseUnlockPanel.mItemNum == nil then
        UIWarehouseUnlockPanel.mItemNum = UIWarehouseUnlockPanel:GetCurComp("WidgetRoot/view/Payment", "UILabel")
    end
    return UIWarehouseUnlockPanel.mItemNum
end

---关闭按钮
function UIWarehouseUnlockPanel.GetCloseButton_GameObject()
    if UIWarehouseUnlockPanel.mCloseButton == nil then
        UIWarehouseUnlockPanel.mCloseButton = UIWarehouseUnlockPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UIWarehouseUnlockPanel.mCloseButton
end

---确认按钮
function UIWarehouseUnlockPanel.GetConfirmButton_GameObject()
    if UIWarehouseUnlockPanel.mConfirmButton == nil then
        UIWarehouseUnlockPanel.mConfirmButton = UIWarehouseUnlockPanel:GetCurComp("WidgetRoot/events/Btn", "GameObject")
    end
    return UIWarehouseUnlockPanel.mConfirmButton
end

---取消按钮
--function UIWarehouseUnlockPanel.GetQuitButton_GameObject()
--    if UIWarehouseUnlockPanel.mQuitButton == nil then
--        UIWarehouseUnlockPanel.mQuitButton = UIWarehouseUnlockPanel:GetCurComp("WidgetRoot/events/LeftBtn", "GameObject")
--    end
--    return UIWarehouseUnlockPanel.mQuitButton
--end

--endregion

--region 初始化
function UIWarehouseUnlockPanel:Init()
    UIWarehouseUnlockPanel.BindEvents()
end

function UIWarehouseUnlockPanel:Show(unlockNum)
    self:ShowInfo(unlockNum)
end

function UIWarehouseUnlockPanel.BindEvents()
    CS.UIEventListener.Get(UIWarehouseUnlockPanel.GetCloseButton_GameObject()).onClick = UIWarehouseUnlockPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIWarehouseUnlockPanel.GetConfirmButton_GameObject()).onClick = UIWarehouseUnlockPanel.OnConfirmButtonClicked
    --CS.UIEventListener.Get(UIWarehouseUnlockPanel.GetQuitButton_GameObject()).onClick = UIWarehouseUnlockPanel.OnQuitButtonClicked
end

---@param unlockNum number 当前花费解锁格子数
function UIWarehouseUnlockPanel:ShowInfo(unlockNum)
    if unlockNum then
        local costInfo = self:GetUnlockCost(unlockNum)
        if costInfo then
            UIWarehouseUnlockPanel.GetItemNum_UILabel().text = costInfo.num
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(costInfo.itemId)
            if res then
                self.GetItemIcon_UISprite().spriteName = itemInfo.icon
            end
            UIWarehouseUnlockPanel.mItemId = costInfo.itemId
            UIWarehouseUnlockPanel.mItemCost = tonumber(costInfo.num)
        end
    end
end

---获得解锁仓库需要花费，如果其他地方要用请挪到LuaGlobalTableDeal中去
function UIWarehouseUnlockPanel:GetUnlockCost(unlockNum)
    if self.mCostInfo == nil then
        self.mCostInfo = {}
        local unlockData = LuaGlobalTableDeal.GetGlobalTabl(22619)
        if unlockData then
            local strs = string.Split(unlockData.value, '&')
            local gridNum = 0
            for i = 1, #strs do
                local singleData = string.Split(strs[i], '#')
                if #singleData >= 3 then
                    gridNum = gridNum + singleData[1]
                    local data = {}
                    data.gridNum = gridNum
                    data.itemId = singleData[2]
                    data.num = singleData[3]
                    table.insert(self.mCostInfo, data)
                end
            end
        end
    end
    if self.mCostInfo then
        for j = 1, #self.mCostInfo do
            local data = self.mCostInfo[j]
            if data.gridNum > unlockNum then
                return data
            end
        end
    end
end

--endregion

--region UI事件
---关闭按钮
function UIWarehouseUnlockPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIWarehouseUnlockPanel")
end

---取消按钮
--function UIWarehouseUnlockPanel.OnQuitButtonClicked()
--    UIWarehouseUnlockPanel.OnCloseButtonClicked()
--end

---确认按钮
function UIWarehouseUnlockPanel.OnConfirmButtonClicked()
    if UIWarehouseUnlockPanel.mItemId and UIWarehouseUnlockPanel.mItemCost then
        local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(UIWarehouseUnlockPanel.mItemId)
        -----钻石单独判定(搞这么多钻石真是搞死了)
        --[[if UIWarehouseUnlockPanel.mItemId == "1000001" then
            local temp1, temp2, temp3, temp4
            bagItemNum = bagItemNum + temp1
            bagItemNum = bagItemNum + temp2
            bagItemNum = bagItemNum + temp3
            bagItemNum = bagItemNum + temp4
        end
        --]]
        --if res then
        if bagItemNum < UIWarehouseUnlockPanel.mItemCost then
            CS.Utility.ShowTips("解锁道具不足")
            UIWarehouseUnlockPanel.OnCloseButtonClicked()
            return
        end
        --end
    end
    networkRequest.ReqAddStorageMaxCount()
    UIWarehouseUnlockPanel.OnCloseButtonClicked()
end
--endregion

return UIWarehouseUnlockPanel