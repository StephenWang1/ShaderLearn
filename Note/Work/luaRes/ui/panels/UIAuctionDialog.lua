---拍卖行Tips
---@class UIAuctionDialog:UIBase
local UIAuctionDialog = {}

--region组件
---Item
function UIAuctionDialog.GetUIItem_GameObject()
    if UIAuctionDialog.mUIItem == nil then
        UIAuctionDialog.mUIItem = UIAuctionDialog:GetCurComp("WidgetRoot/UIItem", "GameObject")
    end
    return UIAuctionDialog.mUIItem
end
---IconSprite
function UIAuctionDialog.GetIconSprite_UISprite()
    if UIAuctionDialog.mIconSprite == nil then
        UIAuctionDialog.mIconSprite = UIAuctionDialog:GetCurComp("WidgetRoot/UIItem/icon", "UISprite")
    end
    return UIAuctionDialog.mIconSprite
end
---item名字
function UIAuctionDialog.GetItemName_UILabel()
    if UIAuctionDialog.mItemName == nil then
        UIAuctionDialog.mItemName = UIAuctionDialog:GetCurComp("WidgetRoot/UIItem/name", "UILabel")
    end
    return UIAuctionDialog.mItemName
end
---数量
function UIAuctionDialog.GetItemNum_UIInput()
    if UIAuctionDialog.mItemCount == nil then
        UIAuctionDialog.mItemCount = UIAuctionDialog:GetCurComp("WidgetRoot/Count", "UIInput")
    end
    return UIAuctionDialog.mItemCount
end
---购买Root
function UIAuctionDialog.GetBuyRoot_GameObject()
    if UIAuctionDialog.mBuyRoot == nil then
        UIAuctionDialog.mBuyRoot = UIAuctionDialog:GetCurComp("WidgetRoot/Buy", "GameObject")
    end
    return UIAuctionDialog.mBuyRoot
end
---出售Root
function UIAuctionDialog.GetSellRoot_GameObject()
    if UIAuctionDialog.mSellRoot == nil then
        UIAuctionDialog.mSellRoot = UIAuctionDialog:GetCurComp("WidgetRoot/Sell", "GameObject")
    end
    return UIAuctionDialog.mSellRoot
end
---确定按钮
function UIAuctionDialog.GetDetermineButton_GameObject()
    if UIAuctionDialog.mDetermineButton == nil then
        UIAuctionDialog.mDetermineButton = UIAuctionDialog:GetCurComp("WidgetRoot/Sell/RightBtn", "GameObject")
    end
    return UIAuctionDialog.mDetermineButton
end
---右边按钮文字
function UIAuctionDialog.GetRightButton_UILabel()
    if UIAuctionDialog.mRightButtonLabel == nil then
        UIAuctionDialog.mRightButtonLabel = UIAuctionDialog:GetCurComp("WidgetRoot/Sell/RightBtn/Label", "UILabel")
    end
    return UIAuctionDialog.mRightButtonLabel
end
---左边按钮文字
function UIAuctionDialog.GetLeftButton_UILabel()
    if UIAuctionDialog.mLeftButtonLabel == nil then
        UIAuctionDialog.mLeftButtonLabel = UIAuctionDialog:GetCurComp("WidgetRoot/Sell/LeftBtn/Label", "UILabel")
    end
    return UIAuctionDialog.mLeftButtonLabel
end
---取消按钮
function UIAuctionDialog.GetCancelButton_GameObject()
    if UIAuctionDialog.mCancelButton == nil then
        UIAuctionDialog.mCancelButton = UIAuctionDialog:GetCurComp("WidgetRoot/Sell/LeftBtn", "GameObject")
    end
    return UIAuctionDialog.mCancelButton
end

---金币数目
function UIAuctionDialog.GetSellInputPrice_UIInput()
    if UIAuctionDialog.mSellInputPrice == nil then
        UIAuctionDialog.mSellInputPrice = UIAuctionDialog:GetCurComp("WidgetRoot/Price", "UIInput")
    end
    return UIAuctionDialog.mSellInputPrice
end
---添加数量按钮
function UIAuctionDialog.GetPlusButton_GameObject()
    if UIAuctionDialog.mPlusButton == nil then
        UIAuctionDialog.mPlusButton = UIAuctionDialog:GetCurComp("WidgetRoot/PlusBtn", "GameObject")
    end
    return UIAuctionDialog.mPlusButton
end
---减少数量按钮
function UIAuctionDialog.GetMinusButton_GameObject()
    if UIAuctionDialog.mMinusBtn == nil then
        UIAuctionDialog.mMinusBtn = UIAuctionDialog:GetCurComp("WidgetRoot/MinusBtn", "GameObject")
    end
    return UIAuctionDialog.mMinusBtn
end
---减少金币数量按钮
function UIAuctionDialog.GetGoldMinus_GameObject()
    if UIAuctionDialog.mGoldMinus == nil then
        UIAuctionDialog.mGoldMinus = UIAuctionDialog:GetCurComp("WidgetRoot/MoneyMinusBtn", "GameObject")
    end
    return UIAuctionDialog.mGoldMinus
end
---增加金币数量按钮
function UIAuctionDialog.GetGoldPlus_GameObject()
    if UIAuctionDialog.mGoldPlus == nil then
        UIAuctionDialog.mGoldPlus = UIAuctionDialog:GetCurComp("WidgetRoot/MoneyPlusBtn", "GameObject")
    end
    return UIAuctionDialog.mGoldPlus
end
---购买按钮
function UIAuctionDialog.GetBuyButton_GameObject()
    if UIAuctionDialog.mBuyButton == nil then
        UIAuctionDialog.mBuyButton = UIAuctionDialog:GetCurComp("WidgetRoot/Buy/MiddleBtn", "GameObject")
    end
    return UIAuctionDialog.mBuyButton
end

function UIAuctionDialog.GetBoxCollider()
    if UIAuctionDialog.mGetBoxCollider == nil then
        UIAuctionDialog.mGetBoxCollider = CS.Utility_Lua.GetComponent(UIAuctionDialog.go, "BoxCollider")
    end
    return UIAuctionDialog.mGetBoxCollider
end

function UIAuctionDialog.GetSellInputPrice_icon()
    if UIAuctionDialog.mGetSellInputPrice_icon == nil then
        UIAuctionDialog.mGetSellInputPrice_icon = CS.Utility_Lua.GetComponent(UIAuctionDialog.GetSellInputPrice_UIInput().transform:Find("icon"), "UISprite")
    end
    return UIAuctionDialog.mGetSellInputPrice_icon
end

function UIAuctionDialog.GetItemNum_UIInputBoxCollider()
    if UIAuctionDialog.mGetItemNum_UIInputBoxCollider == nil then
        UIAuctionDialog.mGetItemNum_UIInputBoxCollider = CS.Utility_Lua.GetComponent(UIAuctionDialog.GetItemNum_UIInput().gameObject.transform, "BoxCollider")
    end
    return UIAuctionDialog.mGetItemNum_UIInputBoxCollider
end

function UIAuctionDialog.GetSellInputPrice_UIInputBoxCollider()
    if UIAuctionDialog.mGetSellInputPrice_UIInputBoxCollider == nil then
        UIAuctionDialog.mGetSellInputPrice_UIInputBoxCollider = CS.Utility_Lua.GetComponent(UIAuctionDialog.GetSellInputPrice_UIInput().gameObject.transform, "BoxCollider")
    end
    return UIAuctionDialog.mGetSellInputPrice_UIInputBoxCollider
end

function UIAuctionDialog.GetSellInputPrice_iconUISprite()
    if UIAuctionDialog.mGetSellInputPrice_iconUISprite == nil then
        UIAuctionDialog.mGetSellInputPrice_iconUISprite = CS.Utility_Lua.GetComponent(UIAuctionDialog.GetSellInputPrice_UIInput().transform:Find("icon"), "UISprite")
    end
    return UIAuctionDialog.mGetSellInputPrice_iconUISprite
end

---退出界面按钮
function UIAuctionDialog.GetCloseButton_GameObject()
    if UIAuctionDialog.mCloseButton == nil then
        UIAuctionDialog.mCloseButton = UIAuctionDialog:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return UIAuctionDialog.mCloseButton
end

---模板节点
function UIAuctionDialog:GetShowRoot_GameObject()
    if self.mShowRoot == nil then
        self.mShowRoot = self:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return self.mShowRoot
end


--endregion

--region 初始化
function UIAuctionDialog:Init()
    UIAuctionDialog:BindEvents()
end

---显示弹窗界面
---@param data table
---{
---@field data.BagItemInfo 界面显示信息（必须）
---@field data.Template 模板（必须）
---}
function UIAuctionDialog:Show(data)
    if data and data.Template then
        if data.Template then
            self:GetShowRoot_GameObject():SetActive(true)
            templatemanager.GetNewTemplate(self:GetShowRoot_GameObject(), data.Template, data, data.AuctionPanel)

        end
    else
        self:GetShowRoot_GameObject():SetActive(false)
    end
end

function UIAuctionDialog:BindEvents()
    CS.UIEventListener.Get(UIAuctionDialog.GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

return UIAuctionDialog