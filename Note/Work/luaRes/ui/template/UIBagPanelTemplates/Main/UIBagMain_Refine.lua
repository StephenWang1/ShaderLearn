---@class UIBagMain_Refine:UIBagMain_Normal
local UIBagMain_Refine = {};

setmetatable(UIBagMain_Refine, luaComponentTemplates.UIBagMainNormal)

--region 重写属性
---是否使用服务器排序
function UIBagMain_Refine:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Refine:IsShowCloseButton()
    return false
end

---是都显示扩展按钮
function UIBagMain_Refine:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Refine:IsShowRecycleButton()
    return false
end

---是否可双击
function UIBagMain_Refine:IsItemDoubleClickedAvailable()
    return false
end

---是否可拖拽
function UIBagMain_Refine:IsItemDragAvailable()
    return true
end
--endregion

---@return bagV2.BagItemInfo
function UIBagMain_Refine:GetFirstChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetFirstChooseBagItemInfo();
    end
    return nil;
end

---@return bagV2.BagItemInfo
function UIBagMain_Refine:GetSecondChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetSecondChooseBagItemInfo();
    end
    return nil;
end

function UIBagMain_Refine:GetMainChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetMainChooseBagItemInfo();
    end
    return nil;
end

--region 重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Refine:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    local hasError = false;
    local tipsInfo = {};
    if bagGrid and bagItemInfo and itemTbl then
        local isChooseItem = (self:GetFirstChooseBagItemInfo() ~= nil and self:GetFirstChooseBagItemInfo().lid == bagItemInfo.lid) or self:GetSecondChooseBagItemInfo() ~= nil and self:GetSecondChooseBagItemInfo().lid == bagItemInfo.lid;
        if isChooseItem == true then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = false, showAssistPanel = true, career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career), showMoreAssistData = true, showTabBtns = true, showBind = true, showAction = true })
        end
        if (not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
            local isReplace = false;
            if (self:GetMainChooseBagItemInfo() ~= nil) then
                if (self:GetMainChooseBagItemInfo().lid ~= bagItemInfo.lid) then
                    local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
                    if (replaceItemId == 0) then
                        tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
                        tipsInfo[LuaEnumTipConfigType.ConfigID] = 329;
                        hasError = true;
                    elseif (replaceItemId ~= bagItemInfo.itemId) then
                        tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
                        tipsInfo[LuaEnumTipConfigType.ConfigID] = 329;
                        hasError = true;
                    end
                end
            else
                if (CS.Cfg_ItemsFloatTableManager.Instance:IsRefineReplaceItem(bagItemInfo.itemId)) then
                    tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
                    tipsInfo[LuaEnumTipConfigType.ConfigID] = 391;
                    hasError = true;
                end
            end
        else
            if (self:GetFirstChooseBagItemInfo() ~= nil) then
                if (self:GetFirstChooseBagItemInfo().itemId ~= bagItemInfo.itemId) then
                    tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
                    tipsInfo[LuaEnumTipConfigType.ConfigID] = 331;
                    hasError = true;
                end
            elseif (self:GetSecondChooseBagItemInfo() ~= nil and CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self:GetSecondChooseBagItemInfo().itemId)) then
                if (self:GetSecondChooseBagItemInfo().itemId ~= bagItemInfo.itemId) then
                    tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
                    tipsInfo[LuaEnumTipConfigType.ConfigID] = 331;
                    hasError = true;
                end
            end
        end

        if (hasError) then
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        else
            luaEventManager.DoCallback(LuaCEvent.Refine_OnBagItemClick, bagItemInfo);
            self:ReRefreshGrids()
        end
    end
end

---重新刷新背包物品（包含排序）
function UIBagMain_Refine:ReRefreshGrids()
    self.mIsBagInfoDirty = nil
    self:GetBagPanel():RefreshGrids()
end

--region 重写刷新格子方法
---刷新单个格子方法
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Refine:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)

    if (self:GetMainChooseBagItemInfo() ~= nil) then
        local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
        if (self:GetMainChooseBagItemInfo().itemId ~= bagItemInfo.itemId) then
            if (replaceItemId == 0) then
                self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
            elseif (replaceItemId ~= bagItemInfo.itemId) then
                self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
            end
        end
    else
        if not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId) then
            self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
        end
    end
    local isFirst = self:GetFirstChooseBagItemInfo() ~= nil and self:GetFirstChooseBagItemInfo().lid == bagItemInfo.lid;
    local isSecond = self:GetSecondChooseBagItemInfo() ~= nil and self:GetSecondChooseBagItemInfo().lid == bagItemInfo.lid;
    if (isFirst) then
        UIBagMain_Refine.mLastFirstChooseGrid = bagGrid;
    elseif (isSecond) then
        UIBagMain_Refine.mLastSecondChooseGrid = bagGrid;
    end
    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect2, isFirst or isSecond);
end
--endregion

--region 重写格子筛选方法
---背包筛选方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@return boolean
--function UIBagMain_Refine:BagItemFilterFunction(bagItemInfo, itemInfo)
--    return CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId);
--end
--endregion

--region 格子排序方法
---@param LeftItem bagV2.BagItemInfo
---@param RightItem bagV2.BagItemInfo
function UIBagMain_Refine:BagItemListSortFunction(LeftItem, RightItem)
    local aValue = self:GetSortItemOrder(LeftItem)
    local bValue = self:GetSortItemOrder(RightItem)
    return aValue > bValue
end

---获取排序对象的顺序
---@param bagItemInfo bagV2.BagItemInfo
---@return number order
function UIBagMain_Refine:GetSortItemOrder(bagItemInfo)
    if bagItemInfo == nil then
        return -1
    end
    local haveChooseRefineItem = self:GetFirstChooseBagItemInfo() ~= nil or self:GetSecondChooseBagItemInfo() ~= nil
    if haveChooseRefineItem then
        local replaceItemId = 0
        if self:GetMainChooseBagItemInfo() ~= nil then
            replaceItemId = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId)
        end
        if self:GetFirstChooseBagItemInfo() ~= nil and bagItemInfo.lid == self:GetFirstChooseBagItemInfo().lid then
            return 5
        elseif self:GetSecondChooseBagItemInfo() ~= nil and bagItemInfo.lid == self:GetSecondChooseBagItemInfo().lid then
            return 4
        elseif (self:GetFirstChooseBagItemInfo() ~= nil and bagItemInfo.itemId == self:GetFirstChooseBagItemInfo().itemId) then
            return 3
        elseif (self:GetSecondChooseBagItemInfo() ~= nil and bagItemInfo.itemId == self:GetSecondChooseBagItemInfo().itemId) then
            return 2
        elseif replaceItemId == bagItemInfo.itemId then
            return 1
        end
    else
        local canRefine = CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)
        if canRefine then
            return 2 + bagItemInfo.itemId
        end
        local isRefineStone = gameMgr:GetPlayerDataMgr():GetMainPlayerRefineMgr():IsRefineStone(bagItemInfo.itemId)
        if isRefineStone then
            return 1
        end
    end
    return 0
end
--endregion


function UIBagMain_Refine:OnRefineChangeSecondItem(bagItem)
    if (bagItem ~= nil) then
        if (UIBagMain_Refine.mLastSecondChooseGrid ~= nil) then
            UIBagMain_Refine.mLastSecondChooseGrid:Refresh();
        end
        self:SwitchToPage(self:GetPageIndexOfBagItem(bagItem), false);
        local bagGrid = self:GetBagGridByBagItemlid(bagItem.lid);
        if (bagGrid ~= nil) then
            bagGrid:Refresh();
            --UIBagMain_Refine.mLastSecondChooseGrid = bagGrid;
        end
    end
end

function UIBagMain_Refine:OnRefineChangeFirstItem(bagItem)
    if (bagItem ~= nil) then
        if (UIBagMain_Refine.mLastFirstChooseGrid ~= nil) then
            UIBagMain_Refine.mLastFirstChooseGrid:Refresh();
        end
        self:SwitchToPage(self:GetPageIndexOfBagItem(bagItem), false);
        local bagGrid = self:GetBagGridByBagItemlid(bagItem.lid);
        if (bagGrid ~= nil) then
            bagGrid:Refresh();
            --UIBagMain_Refine.mLastFirstChooseGrid = bagGrid;
        end
    end
end

function UIBagMain_Refine:OnEnable()
    self:RunBaseFunction("OnEnable");
    self.CallOnClearFirstBagItem = function(msgId, msgData)
        --if (UIBagMain_Refine.mLastFirstChooseGrid ~= nil) then
        --    UIBagMain_Refine.mLastFirstChooseGrid:Refresh();
        --end
        --UIBagMain_Refine.mLastFirstChooseGrid = nil;
        self:ReRefreshGrids()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem);

    self.CallOnClearSecondBagItem = function(msgId, msgData)
        --if (UIBagMain_Refine.mLastSecondChooseGrid ~= nil) then
        --    UIBagMain_Refine.mLastSecondChooseGrid:Refresh();
        --end
        --UIBagMain_Refine.mLastSecondChooseGrid = nil;
        self:ReRefreshGrids()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem);

    self.CallOnFirstBagItemChange = function(msgId, msgData)
        self:OnRefineChangeFirstItem(self:GetFirstChooseBagItemInfo());
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange);

    self.CallOnSecondBagItemChange = function(msgId, msgData)
        self:OnRefineChangeSecondItem(self:GetSecondChooseBagItemInfo());
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange);

    if (self:GetFirstChooseBagItemInfo() ~= nil) then
        self:OnRefineChangeFirstItem(self:GetFirstChooseBagItemInfo());
    end
    if (self:GetSecondChooseBagItemInfo() ~= nil) then
        self:OnRefineChangeSecondItem(self:GetSecondChooseBagItemInfo())
    end
end

function UIBagMain_Refine:OnDisable()
    self:RunBaseFunction("OnDisable");
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearFirstBagItem, self.CallOnClearFirstBagItem);
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnClearSecondBagItem, self.CallOnClearSecondBagItem);
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnSecondBagItemChange, self.CallOnSecondBagItemChange);
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Refine_OnFirstBagItemChange, self.CallOnFirstBagItemChange);
end

return UIBagMain_Refine;