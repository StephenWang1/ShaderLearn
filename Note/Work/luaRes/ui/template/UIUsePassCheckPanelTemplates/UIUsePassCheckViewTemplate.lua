local UIUsePassCheckViewTemplate = {};

UIUsePassCheckViewTemplate.mItemTable = nil;

UIUsePassCheckViewTemplate.mUnitDic = nil;

--region Components

function UIUsePassCheckViewTemplate:GetGridContainer()
    if(self.mGridContainer == nil) then
        self.mGridContainer = self:Get("events/gridContainer", "UIGridContainer");
    end
    return self.mGridContainer;
end

--endregion

--region Method

--region Public

function UIUsePassCheckViewTemplate:UpdateView(itemTable)
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    if(itemTable ~= nil) then
        self.mItemTable = itemTable;
        local mapIds = {};
        local mapNpcIds = {};
        for i = 0,  self.mItemTable.useParam.list.Count - 1 do
            if(i % 2 == 0) then
                table.insert(mapIds, self.mItemTable.useParam.list[i]);
            else
                table.insert(mapNpcIds, self.mItemTable.useParam.list[i]);
            end
        end

        local gridContainer = self:GetGridContainer();
        gridContainer.MaxCount = #mapIds;
        local index = 0;
        for k,v in pairs(mapIds) do
            local gobj = gridContainer.controlList[index];
            if(self.mUnitDic[index] == nil) then
                self.mUnitDic[index] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIUsePassCheckUnitTemplate);
            end
            self.mUnitDic[index]:UpdateUnit(v, mapNpcIds[k]);
            index = index + 1;
        end
    end
end

--endregion

--region Private

function UIUsePassCheckViewTemplate:Clear()
    self.mGridContainer = nil;
    self.mUnitDic = nil;
end

--endregion

--endregion

return UIUsePassCheckViewTemplate;