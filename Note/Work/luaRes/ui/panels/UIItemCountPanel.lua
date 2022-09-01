---物品数量界面
---@class UIItemCountPanel 物品数量界面
local UIItemCountPanel = {}

setmetatable(UIItemCountPanel, luaPanelModules.UIDialog)

--region 变量
UIItemCountPanel.PanelLayerType = CS.UILayerType.TopPlane
--endregion

--region 组件
---标题文本
function UIItemCountPanel:GetTitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:GetCurComp("WidgetRoot/view/title", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---UI物品游戏物体
---@return GameObject
function UIItemCountPanel:GetUIItem_GameObject()
    if self.mUIItem_GO == nil then
        self.mUIItem_GO = self:GetCurComp("WidgetRoot/view/UIItem", "GameObject")
    end
    return self.mUIItem_GO
end

---UI物品
---@return UI物品
function UIItemCountPanel:GetUIItem_UIItem()
    if self.mUIItem_UIItem == nil then
        self.mUIItem_UIItem = templatemanager.GetNewTemplate(self:GetUIItem_GameObject(), luaComponentTemplates.UIItem)
    end
    return self.mUIItem_UIItem
end

---取消按钮
---@return UIButton
function UIItemCountPanel:GetCancelButton_GameObject()
    if self.mCancelButton_GO == nil then
        self.mCancelButton_GO = self:GetCurComp("WidgetRoot/view/btn_cancel", "GameObject")
    end
    return self.mCancelButton_GO
end

---取消按钮文字
---@return UILabel
function UIItemCountPanel:GetCancelLabel_UILabel()
    if self.mCancelLabel_UILabel == nil then
        self.mCancelLabel_UILabel = self:GetCurComp("WidgetRoot/view/btn_cancel/Label", "UILabel")
    end
    return self.mCancelLabel_UILabel
end

---确认按钮
---@return UIButton
function UIItemCountPanel:GetEnsureButton_GameObject()
    if self.mEnsureButton_GO == nil then
        self.mEnsureButton_GO = self:GetCurComp("WidgetRoot/view/btn_ensure", "GameObject")
    end
    return self.mEnsureButton_GO
end

---确认按钮文本
function UIItemCountPanel:GetEnsureLabel_UILabel()
    if self.mEnsureLabel_UILabel == nil then
        self.mEnsureLabel_UILabel = self:GetCurComp("WidgetRoot/view/btn_ensure/Label", "UILabel")
    end
    return self.mEnsureLabel_UILabel
end

---数量文本
---@return UILabel
function UIItemCountPanel:GetCountInput_UIInput()
    if self.mCountInput_UIInput == nil then
        self.mCountInput_UIInput = self:GetCurComp("WidgetRoot/view/inputcount", "UIInput")
    end
    return self.mCountInput_UIInput
end

---减少按钮
---@return UIButton
function UIItemCountPanel:GetReduce_GameObject()
    if self.mReduceBtn_GO == nil then
        self.mReduceBtn_GO = self:GetCurComp("WidgetRoot/view/reduce", "GameObject")
    end
    return self.mReduceBtn_GO
end

---增加按钮
---@return UIButton
function UIItemCountPanel:GetAdd_GameObject()
    if self.mAddBtn_GO == nil then
        self.mAddBtn_GO = self:GetCurComp("WidgetRoot/view/add", "GameObject")
    end
    return self.mAddBtn_GO
end
--endregion

function UIItemCountPanel:GetInputText_UIInput()
    if (self.mInputText_UIInput == nil) then
        self.mInputText_UIInput = self:GetCurComp("WidgetRoot/view/inputcount", "UIInput");
    end
    return self.mInputText_UIInput;
end

--region 初始化
function UIItemCountPanel:Init()
    self:BindUIEvents()
end

---显示物品数量界面
---在调用uimanager:CreatePanel("UIItemCountPanel", table)时传入data,不要单独调用
---@param data table
---{
---@field data.Title string 标题
---@field data.ItemInfo TABLE.CFG_ITEMS 物品信息
---@field data.CallBack function 确认回调
---@field data.CancelDescription string 取消按钮文字描述
---@field data.EnsureDescription string 确认按钮文字描述
---@field data.BeginningCount number 初始数量
---@field data.MaxCount number 最大数量
---@field data.MinCount number 最低数量
---@field data.titleName string 具体标题的名字
---@field data.ClickConfirmAutoClosePanel boolean 是否点击确认自动关闭面板
---@field data.NumChangeCallBack function 选择数量变化回调
---}
function UIItemCountPanel:Show(data)
    self:RunBaseFunction("Show")
    if data then
        --self:GetTitleLabel_UILabel().text = ternary(data.Title == nil, ternary(data.ItemInfo ~= nil,data.ItemInfo.name,""), data.Title)
        local titleName = ""
        if data.titleName ~= nil then
            titleName = data.titleName
        elseif data.ItemInfo ~= nil then
            titleName = data.ItemInfo.name
        end
        self:GetTitleLabel_UILabel().text = titleName
        self:GetUIItem_UIItem():RefreshUIWithItemInfo(ternary(data.ItemInfo == nil, nil, data.ItemInfo))
        self.mCallBack = data.CallBack
        self.mItemInfo = data.ItemInfo;
        self:GetCancelLabel_UILabel().text = ternary(data.CancelDescription == nil, "取消", data.CancelDescription)
        --self:GetEnsureLabel_UILabel().text = ternary(data.EnsureDescription == nil, "确认", data.EnsureDescription)
        self:GetEnsureLabel_UILabel().text = ternary(data.Title == nil, "确认",data.Title)
        self.mMaxCount = ternary(data.MaxCount == nil, 0, data.MaxCount)
        self.mMinCount = ternary(data.MinCount == nil, 0, data.MinCount)
        self.mCount = ternary(data.BeginningCount == nil, self.mMinCount, data.BeginningCount)
        self:GetCountInput_UIInput().text = tostring(self.mCount)
        self.ClickConfirmAutoClosePanel = ternary(data.ClickConfirmAutoClosePanel == nil,true,data.ClickConfirmAutoClosePanel)
        self.NumChangeCallBack = data.NumChangeCallBack
    end
end

function UIItemCountPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCancelButton_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetCancelButton_GameObject()).OnClickLuaDelegate = self.OnCancelButtonClicked
    CS.UIEventListener.Get(self:GetEnsureButton_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetEnsureButton_GameObject()).OnClickLuaDelegate = self.OnEnsureButtonClicked
    CS.UIEventListener.Get(self:GetAdd_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetAdd_GameObject()).OnClickLuaDelegate = self.OnAddButtonClicked
    CS.UIEventListener.Get(self:GetReduce_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetReduce_GameObject()).OnClickLuaDelegate = self.OnReduceButtonClicked
    CS.UIEventListener.Get(self:GetUIItem_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetUIItem_GameObject()).OnClickLuaDelegate = self.OnClickUIItem

    self.CallOnUIInputValueChanged = function()
        self:OnUIInputValueChanged();
    end
    CS.EventDelegate.Add(self:GetInputText_UIInput().onChange, self.CallOnUIInputValueChanged);
end
--endregion

--region UI事件
function UIItemCountPanel:OnClickUIItem()
    if (uimanager:GetPanel("UIItemInfoPanel") == nil) then
        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = self.mItemInfo})
    end
end

---取消按钮点击事件
function UIItemCountPanel:OnCancelButtonClicked()
    uimanager:ClosePanel("UIItemCountPanel")
end

---确认按钮点击事件
function UIItemCountPanel:OnEnsureButtonClicked(go)
    if self.mCallBack then
        self.mCallBack(self.mCount,go)
    end
    if self.ClickConfirmAutoClosePanel == true then
        uimanager:ClosePanel("UIItemCountPanel")
    end
end

function UIItemCountPanel:OnUIInputValueChanged()
    if (self.mMaxCount == nil) then
        return ;
    end
    if(self:GetInputText_UIInput().value ~= "") then
        local num = tonumber(self:GetInputText_UIInput().value);
        num = num == nil and 0 or num;
        num = num > self.mMaxCount and self.mMaxCount or num;
        num = num < self.mMinCount and self.mMinCount or num;
        self:GetInputText_UIInput().value = Utility.GetIntPart(num);
        self.mCount = num;
    else
        self.mCount = 0;
    end
    if self.NumChangeCallBack ~= nil then
        self.NumChangeCallBack(self.mCount)
    end
end
---增加按钮点击事件
function UIItemCountPanel:OnAddButtonClicked()
    self.mCount = self.mCount + 1
    if self.mCount > self.mMaxCount then
        self.mCount = self.mMaxCount
    end
    self:GetCountInput_UIInput().text = tostring(self.mCount)
    if self.NumChangeCallBack ~= nil then
        self.NumChangeCallBack(self.mCount)
    end
end

---减少按钮点击事件
function UIItemCountPanel:OnReduceButtonClicked()
    self.mCount = self.mCount - 1
    if self.mCount <= self.mMinCount then
        self.mCount = self.mMaxCount
    end
    self:GetCountInput_UIInput().text = tostring(self.mCount)
    if self.NumChangeCallBack ~= nil then
        self.NumChangeCallBack(self.mCount)
    end
end
--endregion

--region 设置
---设置标题名字
---@param titleName string 标题名
function UIItemCountPanel:SetTitleName(titleName)
    if type(titleName) == 'string' and CS.StaticUtility.IsNull(self:GetTitleLabel_UILabel()) == false then
        self:GetTitleLabel_UILabel().text = titleName
    end
end
--endregion
return UIItemCountPanel