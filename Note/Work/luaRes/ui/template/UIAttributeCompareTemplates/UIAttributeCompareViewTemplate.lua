local UIAttributeCompareViewTemplate = {};

UIAttributeCompareViewTemplate.mCompareUnitDic = nil;

--region Components

function UIAttributeCompareViewTemplate:GetCompareGridContainer()
    if(self.mCompareGridContainer == nil) then
        self.mCompareGridContainer = self:Get("gridContainer", "UIGridContainer");
    end
    return self.mCompareGridContainer;
end

--endregion

--region Method
---@param customData table {{},.....}
function UIAttributeCompareViewTemplate:ShowAttributeCompare(customData, count)
    local gridContainer = self:GetCompareGridContainer();
    if(customData == nil) then
        gridContainer.MaxCount = 0;
    else
        gridContainer.MaxCount = count;
        local index = 0;
        for k,v in pairs(customData) do
            local gobj = gridContainer.controlList[index];
            if(self.mCompareUnitDic[index] == nil) then
                self.mCompareUnitDic[index] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIAttributeCompareUnitTemplate);
            end
            self.mCompareUnitDic[index]:ShowAttributeCompare(v);
            index = index + 1;
        end
    end
end

function UIAttributeCompareViewTemplate:Clear()
    self.mCompareGridContainer = nil;
    self.mCompareUnitDic = nil;
end

--endregion

function UIAttributeCompareViewTemplate:Init()
    self.mCompareUnitDic = {};
end

function UIAttributeCompareViewTemplate:OnDestroy()
    self:Clear();
end

return UIAttributeCompareViewTemplate;