local UIBandItemsSetPanel = {}

--region 局部变量定义
---兑换数量
UIBandItemsSetPanel.mExchangeNum = 1
---兑换道具ItemInfo
UIBandItemsSetPanel.mExchangeInfo = nil
---兑换ID
UIBandItemsSetPanel.mID = nil
---消耗道具1 数量
UIBandItemsSetPanel.mFirstCost = 0
---消耗道具2 数量
UIBandItemsSetPanel.mSecondCost = 0
---最大数量
UIBandItemsSetPanel.mMaxNum = 1
--endregion

--region 组件
---图标
---@return UISprite
function UIBandItemsSetPanel.GetIcon_UISprite()
    if UIBandItemsSetPanel.mIcon == nil then
        UIBandItemsSetPanel.mIcon = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/icon", "UISprite")
    end
    return UIBandItemsSetPanel.mIcon
end

---名字
function UIBandItemsSetPanel.GetName_UILabel()
    if UIBandItemsSetPanel.mNameLabel == nil then
        UIBandItemsSetPanel.mNameLabel = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/name", "UILabel")
    end
    return UIBandItemsSetPanel.mNameLabel
end

---Input
function UIBandItemsSetPanel.GetNumInput_UIInput()
    if UIBandItemsSetPanel.mNumInput == nil then
        UIBandItemsSetPanel.mNumInput = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/inputcount", "UIInput")
    end
    return UIBandItemsSetPanel.mNumInput
end

---增加
function UIBandItemsSetPanel.GetAddButton_GameObject()
    if UIBandItemsSetPanel.mAddButton == nil then
        UIBandItemsSetPanel.mAddButton = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/add", "GameObject")
    end
    return UIBandItemsSetPanel.mAddButton
end

---减少
function UIBandItemsSetPanel.GetReduceButton_GameObject()
    if UIBandItemsSetPanel.mReduceButton == nil then
        UIBandItemsSetPanel.mReduceButton = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/reduce", "GameObject")
    end
    return UIBandItemsSetPanel.mReduceButton
end

---取消按钮
function UIBandItemsSetPanel.GetCancelButton_GameObject()
    if UIBandItemsSetPanel.mCancelButton == nil then
        UIBandItemsSetPanel.mCancelButton = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UIBandItemsSetPanel.mCancelButton
end

---确认按钮
function UIBandItemsSetPanel.GetDisposeButton_GameObject()
    if UIBandItemsSetPanel.mDisposeButton == nil then
        UIBandItemsSetPanel.mDisposeButton = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/dispose", "GameObject")
    end
    return UIBandItemsSetPanel.mDisposeButton
end

---确认按钮图片
---@return UISprite
function UIBandItemsSetPanel.GetDisposeButtonSprite()
    if UIBandItemsSetPanel.mDisposeBtnSprite == nil then
        UIBandItemsSetPanel.mDisposeBtnSprite = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/dispose/Background", "UISprite")
    end
    return UIBandItemsSetPanel.mDisposeBtnSprite
end

---确认按钮文字
---@return UILabel
function UIBandItemsSetPanel.GetDisposeButtonLabel()
    if UIBandItemsSetPanel.mDisposeBtnLabel == nil then
        UIBandItemsSetPanel.mDisposeBtnLabel = UIBandItemsSetPanel:GetCurComp("WidgetRoot/events/dispose/Label", "UILabel")
    end
    return UIBandItemsSetPanel.mDisposeBtnLabel
end

---消耗道具1Icon
function UIBandItemsSetPanel.GetCostSprite1_UISprite()
    if UIBandItemsSetPanel.mCostSprite1 == nil then
        UIBandItemsSetPanel.mCostSprite1 = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemgold1/Sprite1", "UISprite")
    end
    return UIBandItemsSetPanel.mCostSprite1
end

---消耗道具2Icon
function UIBandItemsSetPanel.GetCostSprite2_UISprite()
    if UIBandItemsSetPanel.mCostSprite2 == nil then
        UIBandItemsSetPanel.mCostSprite2 = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemgold2/Sprite2", "UISprite")
    end
    return UIBandItemsSetPanel.mCostSprite2
end

---消耗道具1Num
function UIBandItemsSetPanel.GetCostLabel1_UILabel()
    if UIBandItemsSetPanel.mCostNum1 == nil then
        UIBandItemsSetPanel.mCostNum1 = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemgold1", "UILabel")
    end
    return UIBandItemsSetPanel.mCostNum1
end

---消耗道具2Num
function UIBandItemsSetPanel.GetCostLabel2_UILabel()
    if UIBandItemsSetPanel.mCostNum2 == nil then
        UIBandItemsSetPanel.mCostNum2 = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemgold2", "UILabel")
    end
    return UIBandItemsSetPanel.mCostNum2
end

---消耗道具2Root
function UIBandItemsSetPanel.mCost2Root_GameObject()
    if UIBandItemsSetPanel.mCostSprite2Root == nil then
        UIBandItemsSetPanel.mCostSprite2Root = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemgold2", "GameObject")
    end
    return UIBandItemsSetPanel.mCostSprite2Root
end

---道具Go
function UIBandItemsSetPanel.GetIcon_GameObject()
    if UIBandItemsSetPanel.mIconGo == nil then
        UIBandItemsSetPanel.mIconGo = UIBandItemsSetPanel:GetCurComp("WidgetRoot/view/itemdi", "GameObject")
    end
    return UIBandItemsSetPanel.mIconGo
end

--endregion

--region 初始化
function UIBandItemsSetPanel:Init()
    UIBandItemsSetPanel:AddCollider()
    UIBandItemsSetPanel.BindEvents()
end

function UIBandItemsSetPanel:Show(itemInfo, costInfo, limitNum, id)
    UIBandItemsSetPanel.InitPanel()
    if itemInfo and limitNum then
        UIBandItemsSetPanel.mExchangeInfo = itemInfo
        UIBandItemsSetPanel.mID = id
        UIBandItemsSetPanel.mMaxNum = limitNum
        UIBandItemsSetPanel.GetIcon_UISprite().spriteName = itemInfo.icon
        UIBandItemsSetPanel.GetName_UILabel().text = itemInfo.name
        if costInfo == nil then
            UIBandItemsSetPanel.GetCostLabel1_UILabel().gameObject:SetActive(false)
            UIBandItemsSetPanel.mCost2Root_GameObject():SetActive(false)
        else
            local costList = costInfo.list
            UIBandItemsSetPanel.mCost2Root_GameObject():SetActive(costList.Count ~= 1)
            for i = 0, costList.Count - 1 do
                if i == 0 then
                    UIBandItemsSetPanel.SetCostIcon(UIBandItemsSetPanel.GetCostSprite1_UISprite(), UIBandItemsSetPanel.GetCostLabel1_UILabel(), costList[i])
                    UIBandItemsSetPanel.mFirstCost = costList[i].list[1]
                elseif i == 1 then
                    UIBandItemsSetPanel.SetCostIcon(UIBandItemsSetPanel.GetCostSprite2_UISprite(), UIBandItemsSetPanel.GetCostLabel2_UILabel(), costList[i])
                    UIBandItemsSetPanel.mSecondCost = costList[i].list[1]
                end
            end
        end
    end
    UIBandItemsSetPanel.RefreshBtnUIState()
end

function UIBandItemsSetPanel.BindEvents()
    CS.UIEventListener.Get(UIBandItemsSetPanel.GetCancelButton_GameObject()).onClick = UIBandItemsSetPanel.OnCancelButtonClicked
    CS.UIEventListener.Get(UIBandItemsSetPanel.GetDisposeButton_GameObject()).onClick = UIBandItemsSetPanel.OnConfirmButtonClicked
    CS.UIEventListener.Get(UIBandItemsSetPanel.GetAddButton_GameObject()).onClick = UIBandItemsSetPanel.OnAddButtonClicked
    CS.UIEventListener.Get(UIBandItemsSetPanel.GetReduceButton_GameObject()).onClick = UIBandItemsSetPanel.OnReduceButtonClicked
    CS.UIEventListener.Get(UIBandItemsSetPanel.GetIcon_GameObject()).onClick = UIBandItemsSetPanel.OnItemClicked
    CS.EventDelegate.Add(UIBandItemsSetPanel.GetNumInput_UIInput().onChange, function()
        UIBandItemsSetPanel.InputValue(UIBandItemsSetPanel.GetNumInput_UIInput().value)
    end)
end

--endregion

--region UI事件

---设置消耗ICon
function UIBandItemsSetPanel.SetCostIcon(iconGo, numGo, info)
    if iconGo and numGo and info then
        local res, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.list[0])
        if res then
            iconGo.spriteName = ItemInfo.icon
            numGo.text = info.list[1]
        end
    end
end

---初始化界面
function UIBandItemsSetPanel.InitPanel()
    UIBandItemsSetPanel.mExchangeNum = 1
    UIBandItemsSetPanel.GetNumInput_UIInput().value = UIBandItemsSetPanel.mExchangeNum
end

---输入字符
function UIBandItemsSetPanel.InputValue(value)
    local num = tonumber(value)
    if num then
        if num > UIBandItemsSetPanel.mMaxNum then
            num = UIBandItemsSetPanel.mMaxNum
        end
        UIBandItemsSetPanel.mExchangeNum = math.ceil(num)
    end
    UIBandItemsSetPanel.SetExchangeNum()
end

---取消
function UIBandItemsSetPanel.OnCancelButtonClicked()
    uimanager:ClosePanel("UIBandItemsSetPanel")
end

---确认
function UIBandItemsSetPanel.OnConfirmButtonClicked()
    if UIBandItemsSetPanel.IsEnoughSpaceInBag() == false then
        Utility.ShowPopoTips(UIBandItemsSetPanel.GetDisposeButton_GameObject(), nil, 281, "UIBandItemsSetPanel")
        return
    end
    if UIBandItemsSetPanel.mExchangeInfo and UIBandItemsSetPanel.mExchangeNum then
        networkRequest.ReqBuyResBundlitem(UIBandItemsSetPanel.mID, UIBandItemsSetPanel.mExchangeNum)
        luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = UIBandItemsSetPanel.mExchangeInfo.id, from = UIBandItemsSetPanel.GetIcon_UISprite().transform.position })
    end
    UIBandItemsSetPanel.OnCancelButtonClicked()
end

---点击增加按钮
function UIBandItemsSetPanel.OnAddButtonClicked()
    if UIBandItemsSetPanel.mExchangeNum + 1 <= UIBandItemsSetPanel.mMaxNum then
        UIBandItemsSetPanel.mExchangeNum = UIBandItemsSetPanel.mExchangeNum + 1
        UIBandItemsSetPanel.SetExchangeNum()
    end
end

---点击减少按钮
function UIBandItemsSetPanel.OnReduceButtonClicked()
    if UIBandItemsSetPanel.mExchangeNum - 1 > 0 then
        UIBandItemsSetPanel.mExchangeNum = UIBandItemsSetPanel.mExchangeNum - 1
        UIBandItemsSetPanel.SetExchangeNum()
    end
end

---设置兑换数量
function UIBandItemsSetPanel.SetExchangeNum()
    UIBandItemsSetPanel.GetNumInput_UIInput().value = UIBandItemsSetPanel.mExchangeNum
    UIBandItemsSetPanel.SetExchangeCost()
end

---设置兑换消耗道具数量
function UIBandItemsSetPanel.SetExchangeCost()
    UIBandItemsSetPanel.GetCostLabel1_UILabel().text = UIBandItemsSetPanel.mExchangeNum * UIBandItemsSetPanel.mFirstCost
    UIBandItemsSetPanel.GetCostLabel2_UILabel().text = UIBandItemsSetPanel.mExchangeNum * UIBandItemsSetPanel.mSecondCost
    UIBandItemsSetPanel.RefreshBtnUIState()
end

function UIBandItemsSetPanel.RefreshBtnUIState()
    local isEnough = UIBandItemsSetPanel.IsEnoughSpaceInBag()
    if isEnough then
        UIBandItemsSetPanel.GetDisposeButtonSprite().color = CS.UnityEngine.Color.white
        UIBandItemsSetPanel.GetDisposeButtonLabel().text = "[ffffff]确定[-]"
    else
        UIBandItemsSetPanel.GetDisposeButtonSprite().color = CS.UnityEngine.Color.black
        UIBandItemsSetPanel.GetDisposeButtonLabel().text = "[878787]确定[-]"
    end
end

---物品点击
function UIBandItemsSetPanel.OnItemClicked()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = UIBandItemsSetPanel.mExchangeInfo })
end

--endregion

---背包中是否有足够的空间
---@return boolean
function UIBandItemsSetPanel.IsEnoughSpaceInBag()
    local itemInfo = UIBandItemsSetPanel.mExchangeInfo
    if itemInfo == nil then
        return false
    end
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return false
    end
    return CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(itemInfo, UIBandItemsSetPanel.mExchangeNum)
end

return UIBandItemsSetPanel
