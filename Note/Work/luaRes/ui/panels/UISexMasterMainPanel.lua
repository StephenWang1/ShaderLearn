---@class UISexMasterMainPanel : UIBase 通用副本面板
local UISexMasterMainPanel = {}

--region  组件

function UISexMasterMainPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UISexMasterMainPanel:GetBtnGrid()
    if (self.mGetBtnGrid == nil) then
        self.mGetBtnGrid = self:GetCurComp("WidgetRoot/view/Btn/BtnList", "Top_UIGridContainer");
    end
    return self.mGetBtnGrid;
end

--endregion

--region 初始化

function UISexMasterMainPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UISexMasterMainPanel:Show()
    self:RefreshGrid()
end

--- 初始化组件

function UISexMasterMainPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UISexMasterMainPanel")
        uimanager:ClosePanel("UISexMasterPanel")
    end
end

function UISexMasterMainPanel:BindNetMessage()

end
--endregion

--region View

---刷新grid
function UISexMasterMainPanel:RefreshGrid()
    local tempList = {}
    table.insert(tempList,"变更性别")
    table.insert(tempList,"转换职业")
    self:GetBtnGrid().MaxCount = 2
    for i = 1, 2 do
        local go = self:GetBtnGrid().controlList[i - 1]
        if go == nil then
            return
        end
        local btnLabel = CS.Utility_Lua.GetComponent(go.transform:Find('label'), "Top_UILabel")
        if btnLabel then
            btnLabel.text = tempList[i]
        end
        CS.UIEventListener.Get(go).onClick = function()
            self:OnBtnClick(i)
        end

    end
end

---按钮点击事件
function UISexMasterMainPanel:OnBtnClick(index)
    uimanager:CreatePanel("UISexMasterPanel", nil, index)
end
--endregion


--region ondestroy

function ondestroy()

end

--endregion

return UISexMasterMainPanel