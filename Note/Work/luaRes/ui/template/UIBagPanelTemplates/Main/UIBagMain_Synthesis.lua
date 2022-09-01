---背包与合成界面组合时
---@class UIBagMain_Synthesis:UIBagMain_Normal
local UIBagMain_Synthesis = {}

setmetatable(UIBagMain_Synthesis, luaComponentTemplates.UIBagMainNormal)

UIBagMain_Synthesis.mLastChooseGrid = nil;

--region 重写属性
---是否使用服务器排序
function UIBagMain_Synthesis:IsUseServerOrder()
    return false
end

---是否显示关闭按钮
function UIBagMain_Synthesis:IsShowCloseButton()
    return false
end

---是都显示扩展按钮
function UIBagMain_Synthesis:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Synthesis:IsShowRecycleButton()
    return false
end

---是否可双击
function UIBagMain_Synthesis:IsItemDoubleClickedAvailable()
    return true
end

---是否可拖拽
function UIBagMain_Synthesis:IsItemDragAvailable()
    return true
end
--endregion

function UIBagMain_Synthesis:GetMainChooseBagItemInfo()
    local synthesisPanel = uimanager:GetPanel("UISynthesisPanel");
    if (synthesisPanel ~= nil) then
        return synthesisPanel:GetSynthesisViewTemplate():GetSynthesisMainBagItemInfo();
    end
    return nil;
end

function UIBagMain_Synthesis:OnEnable()
    self:RunBaseFunction("OnEnable");

    self.CallOnSynthesisChangeItem = function(msgId, msgData)
        self:OnSynthesisChangeItem(msgData);
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Synthesis_OnChangeItem, self.CallOnSynthesisChangeItem);

    local synthesisPanel = uimanager:GetPanel("UISynthesisPanel");
    if (synthesisPanel ~= nil) then
        self:OnSynthesisChangeItem(synthesisPanel:GetSynthesisViewTemplate().mSelectBagItem);
    end
end

function UIBagMain_Synthesis:OnDisable()
    self:RunBaseFunction("OnDisable");
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Synthesis_OnChangeItem, self.CallOnSynthesisChangeItem);
end

---是否是屏蔽的材料(因为可合成物品太多,所以不能在背包中直接选中)
---@param itemID number
---@return boolean
function UIBagMain_Synthesis:IsIgnoreItem(itemID)
    if self.mIgnoreItemIDs == nil then
        self.mIgnoreItemIDs = {}
        local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22718)
        if tbl then
            local strs = string.Split(tbl.value, '#')
            for i = 1, #strs do
                local idTemp = tonumber(strs[i])
                table.insert(self.mIgnoreItemIDs, idTemp)
            end
        end
    end
    for i = 1, #self.mIgnoreItemIDs do
        if self.mIgnoreItemIDs[i] == itemID then
            return true
        end
    end
    return false
end

--region 重写方法
---单击
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Synthesis:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagGrid and bagItemInfo and itemTbl then
        local itemInfo = itemTbl;
        local itemID = itemInfo.id
        if self:IsIgnoreItem(itemID) then
            local tipsInfo = {};
            tipsInfo[LuaEnumTipConfigType.Parent] = bagGrid.go.transform;
            tipsInfo[LuaEnumTipConfigType.ConfigID] = 329
            tipsInfo[LuaEnumTipConfigType.Describe] = "不能当做主材料"
            return uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        end

        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnBagItemClicked, bagItemInfo);
    end
end

---双击点击时,尝试使用物品
function UIBagMain_Synthesis:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)

end
--endregion

--region 重写刷新格子方法
---刷新单个格子方法
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Synthesis:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)

    local canSynthesis = false;
    local itemInfo = itemTbl;
    local itemID = itemInfo.id
    if not self:IsIgnoreItem(itemID) then
        canSynthesis = clientTableManager.cfg_synthesisManager:IsCanSynthesis(bagItemInfo.itemId)
    end
    if not canSynthesis then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end

    local isChoose = self:GetMainChooseBagItemInfo() ~= nil and self:GetMainChooseBagItemInfo().lid == bagItemInfo.lid;
    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect2, isChoose);
    if (isChoose) then
        self.mLastChooseGrid = bagGrid;
    end
end
--endregion

--region 格子排序方法
function UIBagMain_Synthesis:BagItemListSortFunction(LeftItem, RightItem)
    if (LeftItem.itemId ~= RightItem.itemId) then
        local aValue = clientTableManager.cfg_synthesisManager:IsCanSynthesis(LeftItem.itemId) and 1 or 0;
        local bValue = clientTableManager.cfg_synthesisManager:IsCanSynthesis(RightItem.itemId) and 1 or 0;
        return aValue > bValue;
    else
        return LeftItem.bagIndex < RightItem.bagIndex;
    end
end
--endregion

function UIBagMain_Synthesis:OnSynthesisChangeItem(bagItem)
    if (bagItem ~= nil) then
        self:SwitchToPage(self:GetPageIndexOfBagItem(bagItem), false);
        local bagGrid = self:GetBagGridByBagItemlid(bagItem.lid);
        if (self.mLastChooseGrid ~= nil) then
            self.mLastChooseGrid:Refresh();
        end
        if (bagGrid ~= nil) then
            bagGrid:Refresh();
        end
    end
end

--endregion

return UIBagMain_Synthesis