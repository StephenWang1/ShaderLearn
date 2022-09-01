---第二种提示弹窗
local UIPromptSecondPanel = {}
UIPromptSecondPanel.mCallBack = nil
--region 组件
---标题组件
function UIPromptSecondPanel.GetTitleLabel_UILabel()
    if UIPromptSecondPanel.mTitleLabel_UILabel == nil then
        UIPromptSecondPanel.mTitleLabel_UILabel = UIPromptSecondPanel:GetCurComp("WidgetRoot/window/Title", "UILabel")
    end
    return UIPromptSecondPanel.mTitleLabel_UILabel
end
---内容组件
function UIPromptSecondPanel.GetContentLabel_UILabel()
    if UIPromptSecondPanel.mContentLabel_UILabel == nil then
        UIPromptSecondPanel.mContentLabel_UILabel = UIPromptSecondPanel:GetCurComp("WidgetRoot/Label", "UILabel")
    end
    return UIPromptSecondPanel.mContentLabel_UILabel
end
---关闭按钮
function UIPromptSecondPanel.GetCloseButton_GameObject()
    if UIPromptSecondPanel.mCloseButton_GameObject == nil then
        UIPromptSecondPanel.mCloseButton_GameObject = UIPromptSecondPanel:GetCurComp("WidgetRoot/window/CloseBtn", "GameObject")
    end
    return UIPromptSecondPanel.mCloseButton_GameObject
end
---确认按钮
function UIPromptSecondPanel.GetConfirmButton_GameObject()
    if UIPromptSecondPanel.mConfirmButton_GameObject == nil then
        UIPromptSecondPanel.mConfirmButton_GameObject = UIPromptSecondPanel:GetCurComp("WidgetRoot/ConfirmBtn", "GameObject")
    end
    return UIPromptSecondPanel.mConfirmButton_GameObject
end
---按钮文字
function UIPromptSecondPanel.GetConfirmButtonLabel_UILabel()
    if UIPromptSecondPanel.mConfirmButtonLabel_UILabel == nil then
        UIPromptSecondPanel.mConfirmButtonLabel_UILabel = UIPromptSecondPanel:GetCurComp("WidgetRoot/ConfirmBtn/Label", "UILabel")
    end
    return UIPromptSecondPanel.mConfirmButtonLabel_UILabel
end
--endregion 组件
--region 初始化
function UIPromptSecondPanel:Init()
    UIPromptSecondPanel.BindUIEvents()
end
---绑定UI事件
function UIPromptSecondPanel.BindUIEvents()
    CS.UIEventListener.Get(UIPromptSecondPanel.GetCloseButton_GameObject()).onClick = function(go)
        if UIPromptSecondPanel.mCloseCallBack ~= nil then
            UIPromptSecondPanel.mCloseCallBack()
        end
        uimanager:ClosePanel("UIPromptSecondPanel")
    end
    CS.UIEventListener.Get(UIPromptSecondPanel.GetConfirmButton_GameObject()).onClick = function(go)
        if UIPromptSecondPanel.mEnterCallBack then
            UIPromptSecondPanel.mEnterCallBack()
            uimanager:ClosePanel("UIPromptSecondPanel")
        end
    end
end
--endregion 初始化
---显示弹窗界面
---在调用uimanager:CreatePanel("UIPromptPanel", table)时传入data,不要单独调用
---@param data table
---{
---@field data.Title string 标题
---@field data.Content string 内容
---@field data.EnterCallBack function 确认回调
---@field data.CloseCallBack function 关闭回调
---@field data.ButtonDescription string 按钮描述文字
---}
function UIPromptSecondPanel:Show(data)
    UIPromptSecondPanel:RunBaseFunction("Show")
    if data then
        --标题
        UIPromptSecondPanel.GetTitleLabel_UILabel().text = ternary(data.Title == nil, "", data.Title)
        --内容
        UIPromptSecondPanel.GetContentLabel_UILabel().text = ternary(data.Content == nil, "", data.Content)
        --按钮描述文字
        UIPromptSecondPanel.GetConfirmButtonLabel_UILabel().text = ternary(data.ButtonDescription == nil, "", data.ButtonDescription)
        --确认回调
        UIPromptSecondPanel.mEnterCallBack = data.EnterCallBack
        --关闭回调
        UIPromptSecondPanel.mCloseCallBack = data.CloseCallBack
    end
end
return UIPromptSecondPanel