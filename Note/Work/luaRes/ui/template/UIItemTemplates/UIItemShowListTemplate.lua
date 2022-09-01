local UIItemShowListTemplate = {};

UIItemShowListTemplate.mUIItemDic = {};

--region Components
function UIItemShowListTemplate:GetItemList_UIGridContainer()
    if(self.mUIItemList_UIGridContainer == nil) then
        self.mUIItemList_UIGridContainer = CS.Utility_Lua.GetComponent(self.go,"UIGridContainer");
    end
    return self.mUIItemList_UIGridContainer;
end
--endregion

--region Method
---@param itemIdAndCountDic @table{ 物品ID:物品数量 }
---@param count number 数量
function UIItemShowListTemplate:ShowUIItemWithItemIds(itemIdAndCountDic, count)
    local gridContainer = self:GetItemList_UIGridContainer();
    gridContainer.MaxCount = count;
    local index = 0;
    for k,v in pairs(itemIdAndCountDic) do
        local isFind,itemData = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(k)
        if(isFind) then
            local unit = gridContainer.controlList[index];
            CS.UIEventListener.Get(unit).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemData})
            end
            self.mUIItemDic[k] = templatemanager.GetNewTemplate(unit, luaComponentTemplates.UIItem);
            self.mUIItemDic[k]:RefreshUIWithItemInfo(itemData, v);
            index = index + 1;
        end
    end
end

function UIItemShowListTemplate:GetCount()
    return self:GetItemList_UIGridContainer().MaxCount;
end

function UIItemShowListTemplate:Clear()
    self.mUIItemList_UIGridContainer = nil;
    self.mUIItemDic = nil;
end
--endregion

function UIItemShowListTemplate:Init()
    self.mUIItemDic = {};
end

function UIItemShowListTemplate:OnDestroy()
    self:Clear();
end

return UIItemShowListTemplate;