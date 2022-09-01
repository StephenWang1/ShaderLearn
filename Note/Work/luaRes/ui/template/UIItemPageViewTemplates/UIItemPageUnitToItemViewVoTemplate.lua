local UIItemPageUnitToItemViewVoTemplate = {};

setmetatable(UIItemPageUnitToItemViewVoTemplate, luaComponentTemplates.UIItemPageUnitTemplate);

function UIItemPageUnitToItemViewVoTemplate:UpdateUnit(itemViewVos)
    if(self.mItemUnitDic == nil) then
        self.mItemUnitDic = {};
    end
    local gridContainer = self:GetUnitGridContainer();
    gridContainer.MaxCount =  luaComponentTemplates.UIItemPageViewTemplate.mOnePageItemNum;
    for i = 0, gridContainer.MaxCount - 1 do
        local gobj = gridContainer.controlList[i];
        if(self.mItemUnitDic[gobj] == nil) then
            self.mItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
        end
        self.mItemUnitDic[gobj]:ResetUI();
        CS.UIEventListener.Get(gobj).onClick = nil;
    end
    if(itemViewVos ~= nil) then
        local index = 0;
        for k,v in pairs(itemViewVos) do
            if(gridContainer.MaxCount > index) then
                local gobj = gridContainer.controlList[index];
                if(self.mItemUnitDic[gobj] == nil) then
                    self.mItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                self.mItemUnitDic[gobj]:RefreshUIWithItemInfo(v.itemTable, 1);
                CS.UIEventListener.Get(gobj).onClick = function()
                    if(v.type == 2) then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = v.bagItemInfo});
                    else
                        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = v.itemTable});
                    end
                end
            end
            index = index + 1;
        end
    end
end

return UIItemPageUnitToItemViewVoTemplate;