local UIItemPageViewTemplate = {};

UIItemPageViewTemplate.mMaxPage = 3;

UIItemPageViewTemplate.mOnePageItemNum = 15;

function UIItemPageViewTemplate:Init(panel)
    self.mOwnerPanel = panel
end

--region Components

function UIItemPageViewTemplate:GetPageViewTemplate()
    if (self.mPageViewTemplate == nil) then
        self.mPageViewTemplate = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIPageViewTemplate, self.mOwnerPanel);
    end
    return self.mPageViewTemplate;
end

--endregion

--region Method

--region Public

function UIItemPageViewTemplate:UpdateToItemIdList(itemIdList)
    local itemIds = {};
    if (itemIdList ~= nil) then
        for i = 0, itemIdList.Count - 1 do
            table.insert(itemIds, itemIdList[i]);
        end
    end
    self:UpdateToItemIds(itemIds);
end

function UIItemPageViewTemplate:UpdateToItemViewVoList(itemViewVoList)
    local itemViewVos = {};
    if (itemViewVoList ~= nil) then
        for i = 0, itemViewVoList.Count - 1 do
            for i = 0, itemViewVos.Count - 1 do
                table.insert(itemViewVos, itemViewVoList[i]);
            end
        end
    end
    self:UpdateToItemViewVos(itemViewVos);
end

function UIItemPageViewTemplate:UpdateToItemIds(itemIds)
    local listData = SplitToList(itemIds, self.mOnePageItemNum);
    self:GetPageViewTemplate():Initialize(self.mOnePageItemNum, self.mMaxPage * self.mOnePageItemNum, listData, luaComponentTemplates.UIItemPageUnitTemplate);
end

function UIItemPageViewTemplate:UpdateToItemViewVos(itemViewVos)
    local listData = SplitToList(itemViewVos, self.mOnePageItemNum);
    self:GetPageViewTemplate():Initialize(self.mOnePageItemNum, self.mMaxPage * self.mOnePageItemNum, listData, luaComponentTemplates.UIItemPageUnitToItemViewVoTemplate);

end

--endregion

--region Private

--endregion

--endregion

return UIItemPageViewTemplate;