---背包与进化界面组合时
---@class UIBagMain_Evolution:UIBagMain_Normal
local UIBagMain_Evolution = {}

setmetatable(UIBagMain_Evolution, luaComponentTemplates.UIBagMainNormal)

UIBagMain_Evolution.mLastChooseGrid = nil;

UIBagMain_Evolution.mLastChooseBagItemInfo = nil;

--region 重写属性
---是否使用服务器排序
function UIBagMain_Evolution:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Evolution:IsShowCloseButton()
    return false
end

---是都显示扩展按钮
function UIBagMain_Evolution:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Evolution:IsShowRecycleButton()
    return false
end

---是否可双击
function UIBagMain_Evolution:IsItemDoubleClickedAvailable()
    return true
end

---是否可拖拽
function UIBagMain_Evolution:IsItemDragAvailable()
    return true
end
--endregion

function UIBagMain_Evolution:OnEnable()
    self:RunBaseFunction("OnEnable");

    self.CallOnEvolutionSelectItem = function(msgId, msgData)
        if(msgData ~= nil) then
            if(self.mLastChooseGrid ~= nil) then
                self.mLastChooseGrid:SetCompActive(self.mLastChooseGrid.Components.ChosenEffect, false);
            end
            self:SwitchToPage(self:GetPageIndexOfBagItem(msgData), false);
            local bagGrid = self:GetBagGridByBagItemlid(msgData.lid);
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true);
            self.mLastChooseGrid = bagGrid;
            self.mLastChooseBagItemInfo = msgData;
        end
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnChangeItem, self.CallOnEvolutionSelectItem)
end

function UIBagMain_Evolution:OnDisable()
    self:RunBaseFunction("OnDisable");
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnChangeItem, self.CallOnEvolutionSelectItem);
end

--region 重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Evolution:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        luaEventManager.DoCallback(LuaCEvent.Evolution_OnBagGridClicked, bagItemInfo)
    end
end

--region 重写刷新格子方法
---刷新单个格子方法
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Evolution:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect,  self.mLastChooseBagItemInfo ~= nil and bagItemInfo.lid == self.mLastChooseBagItemInfo.lid);
end
--endregion

--region 重写格子筛选方法
---背包筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Evolution:BagItemFilterFunction(bagItemInfo, itemInfo)
    return CS.Cfg_EvolutionTableManager.Instance:CanEvolution(bagItemInfo.itemId);
end
--endregion

return UIBagMain_Evolution