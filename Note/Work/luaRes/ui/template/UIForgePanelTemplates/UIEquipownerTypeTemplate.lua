---装备拥有者类型
local UIEquipownerTypeTemplate = {}
--region 局部变量定义
---父类
UIEquipownerTypeTemplate.UIForgePanel = nil
---右界面类型
UIEquipownerTypeTemplate.RightType = nil
---右打开界面
UIEquipownerTypeTemplate.RightPanelName = nil
---右的界面
UIEquipownerTypeTemplate.RightPanel = nil
---右的界面Panel
UIEquipownerTypeTemplate.RightPanelUIPanel = nil
--endregion

function UIEquipownerTypeTemplate:Init()

end

function UIEquipownerTypeTemplate.Show(UIForgePanel)
    UIEquipownerTypeTemplate.UIForgePanel = UIForgePanel
end

function UIEquipownerTypeTemplate.RightSwitchState(forgePanelOpenType)
    if forgePanelOpenType == nil then
        UIEquipownerTypeTemplate.RightType = LuaEnumForgeOpenType.Strengthen
    else
        UIEquipownerTypeTemplate.RightType = forgePanelOpenType
    end
    local panelName
    if UIEquipownerTypeTemplate.RightType == LuaEnumForgeOpenType.Strengthen then
        panelName = "UIForgeStrengthenPanel"
    elseif UIEquipownerTypeTemplate.RightType == LuaEnumForgeOpenType.Element then
        panelName = "UIElementPanel"
    end
    UIEquipownerTypeTemplate.RightOpenPanel(panelName)
end

---打开界面
function UIEquipownerTypeTemplate.RightOpenPanel(panelName)
    if panelName ~= nil then
        UIEquipownerTypeTemplate.UIForgePanel:ClosePanel(UIEquipownerTypeTemplate.RightPanelName)
        UIEquipownerTypeTemplate.UIForgePanel:CreatePanel(panelName, function(panel)
            UIEquipownerTypeTemplate.RightPanelName = panelName
            UIEquipownerTypeTemplate.RightPanel = panel
            UIEquipownerTypeTemplate.UIForgePanel.FilterItemsInBagFunc = panel.FilterItemsInBag
            UIEquipownerTypeTemplate.SubPanelSetParent(UIEquipownerTypeTemplate.UIForgePanel.GetRight_GameObject())
        end)
    end
end

---点击刷新事件
function UIEquipownerTypeTemplate.RefreshClicked()

end

---子界面设置父类
function UIEquipownerTypeTemplate.SubPanelSetParent(Parent)
    UIEquipownerTypeTemplate.RightPanel.go.transform:SetParent(Parent.transform)
    if UIEquipownerTypeTemplate.RightPanelUIPanel==nil then
        UIEquipownerTypeTemplate.RightPanelUIPanel= CS.Utility_Lua.GetComponent(UIEquipownerTypeTemplate.RightPanel.go,"UIPanel")
    end
    UIEquipownerTypeTemplate.RightPanelUIPanel.depth = UIEquipownerTypeTemplate.UIForgePanel.GetForgePanel_UIPanel().depth
end

function UIEquipownerTypeTemplate.OnDestroy()
    UIEquipownerTypeTemplate.UIForgePanel = nil
    UIEquipownerTypeTemplate.RightType = nil
    UIEquipownerTypeTemplate.RightPanelName = nil
    UIEquipownerTypeTemplate.RightPanel = nil
end

return UIEquipownerTypeTemplate