local UIItemPageUnitTemplate = {};

setmetatable(UIItemPageUnitTemplate, luaComponentTemplates.UIPageUnitTemplate);

UIItemPageUnitTemplate.mItemUnitDic = nil;

--region Components

function UIItemPageUnitTemplate:GetUnitGridContainer()
    if(self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = CS.Utility_Lua.GetComponent(self.go,"UIGridContainer");
    end
    return self.mUnitGridContainer;
end

--endregion

--region Method

--region Public

function UIItemPageUnitTemplate:UpdateUnit(itemIds)
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
    if(itemIds ~= nil) then
        local index = 0;
        for k,v in pairs(itemIds) do
            if(gridContainer.MaxCount > index) then
                local gobj = gridContainer.controlList[index];
                if(self.mItemUnitDic[gobj] == nil) then
                    self.mItemUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
                end
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
                if(isFind) then
                    self.mItemUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, 1);
                    CS.UIEventListener.Get(gobj).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable})
                    end
                end
            else
                break;
            end
            index = index + 1;
        end
    end
end

--endregion

--endregion

return UIItemPageUnitTemplate;