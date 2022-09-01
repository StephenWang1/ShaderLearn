local UIFastItemSettingViewTemplate = {};

UIFastItemSettingViewTemplate.mFastSettingUnitDic = {};

--region Components

---@type UIGridContainer
function UIFastItemSettingViewTemplate:GetItemListGridContainer()
    if(self.mItemListGridContainer == nil) then
        self.mItemListGridContainer = self:Get("ItemList", "UIGridContainer");
    end
    return self.mItemListGridContainer;
end

--endregion

--region Method

function UIFastItemSettingViewTemplate:ShowFastSettingView()
    self.mFastSettingUnitDic = {};
    local gridContainer = self:GetItemListGridContainer();
    gridContainer.MaxCount = 3;
    for k,v in pairs(gridContainer.controlList) do
        if(self.mFastSettingUnitDic[k] == nil) then
            self.mFastSettingUnitDic[k] = templatemanager.GetNewTemplate(v, luaComponentTemplates.UIFastItemSettingUnitTemplate);
        end
        self.mFastSettingUnitDic[k]:ShowUnit(k);
    end
end

function UIFastItemSettingViewTemplate:InitEvents()

end

function UIFastItemSettingViewTemplate:RemoveEvents()

end

--endregion

function UIFastItemSettingViewTemplate:Init()
    self:InitEvents();
end

function UIFastItemSettingViewTemplate:Show()

end

function UIFastItemSettingViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIFastItemSettingViewTemplate;