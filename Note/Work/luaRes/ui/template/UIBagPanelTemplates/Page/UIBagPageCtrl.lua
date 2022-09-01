---背包页控制
---@class UIBagPageCtrl:TemplateBase
local UIBagPageCtrl = {}

local Utility = Utility

---返回本页的格子容器
---@private
---@return UIGridContainer
function UIBagPageCtrl:GetGridContainer()
    if self.mGridContainer == nil then
        self.mGridContainer = self:Get("UIGridItem", "UIGridContainer")
    end
    return self.mGridContainer
end

---@return UnityEngine.GameObject 加锁页
function UIBagPageCtrl:GetLockPage_GO()
    if self.mLockPage == nil then
        self.mLockPage = self:Get("Lock", "GameObject")
    end
    return self.mLockPage
end

---@return UnityEngine.GameObject 解锁按钮
function UIBagPageCtrl:GetUnlockBtn_GO()
    if self.mUnlockBtn == nil then
        self.mUnlockBtn = self:Get("Lock/Btn_Enter", "GameObject")
    end
    return self.mUnlockBtn
end

---@private
---返回格子背景
---@return UnityEngine.GameObject
function UIBagPageCtrl:GetGridBG()
    if self.mGridBG == nil then
        self.mGridBG = self:Get("UIGridItem/bg", "GameObject")
    end
    return self.mGridBG
end

---获取当前页索引(从0开始)
---@public
---@return number
function UIBagPageCtrl:GetCurrentPageIndex()
    if self.mPageIndex == nil then
        return -1
    end
    return self.mPageIndex
end

---获取本页所有背包物品及其格子
---@return table<number,UIBagGrid>
function UIBagPageCtrl:GetPageBagItems()
    if self.mPageBagItems == nil then
        self.mPageBagItems = {}
    end
    return self.mPageBagItems
end

---获取背包总格子数量
---@public
---@return number
function UIBagPageCtrl:GetBagMaxGridCount()
    if self.mBagMaxGridCount == nil then
        return 0
    end
    return self.mBagMaxGridCount
end

---当前页控制对应的背包界面
---@public
---@return UIBagPanel
function UIBagPageCtrl:GetBagPanel()
    return self.mBagPanel
end

---初始化
---@param bagPanel UIBagPanel
---@param gridCountPerPage number 一页的格子数量
function UIBagPageCtrl:Init(bagPanel, gridCountPerPage)
    self.mBagPanel = bagPanel
    self.mMaxGridCountPerPage = gridCountPerPage
    self:GetGridContainer().MaxCount = gridCountPerPage
    if CS.StaticUtility.IsNull(self:GetGridBG()) == false then
        self:GetGridBG():SetActive(true)
    end
    ---@type table<number,boolean> 格子是否为空的状态,格子索引(从0开始)-格子是否为空
    self.mGridEmptyStateTbl = {}
    ---@type Cfg_ItemsTableManager
    self.mItemTblMgr = CS.Cfg_ItemsTableManager.Instance
    for i = 0, gridCountPerPage - 1 do
        self.mGridEmptyStateTbl[i] = true
    end
    self.mGetGridPrefabFunction = function(compName)
        return self:GetBagPanel():GetGridComponentPrefab(compName)
    end
end

---刷新页
---@public
---@param bagItemList table<number,bagV2.BagItemInfo> 刷新时使用的物品列表(从1开始)
---@param pageIndex number 刷新时的页索引(从0开始)
---@param mBagMaxGridCount number 背包最大格子数量
function UIBagPageCtrl:RefreshPage(bagItemList, pageIndex, mBagMaxGridCount)
    Utility.ClearTable(self:GetPageBagItems())
    self.mPageIndex = pageIndex ~= nil and pageIndex or 0
    self.mBagMaxGridCount = mBagMaxGridCount ~= nil and mBagMaxGridCount or 0
    ---@type number 最小格子索引(从1开始)
    local minIndex = (self.mPageIndex) * self.mMaxGridCountPerPage + 1

    local isLockPage = minIndex > mBagMaxGridCount
    self:GetGridContainer().gameObject:SetActive(not isLockPage)
    if CS.StaticUtility.IsNull(self:GetLockPage_GO()) == false then
        self:GetLockPage_GO():SetActive(isLockPage)
    end
    if isLockPage and CS.StaticUtility.IsNull(self:GetUnlockBtn_GO()) == false then
        CS.UIEventListener.Get(self:GetUnlockBtn_GO()).onClick = function()
            uiTransferManager:TransferToPanel(LuaEnumTransferType.CommercePanel)
        end
        return
    end

    ---@type number 最大格子索引(从1开始)
    local maxIndex = (self.mPageIndex + 1) * self.mMaxGridCountPerPage
    ---格子列表
    local controlList = self:GetGridContainer().controlList
    ---将标识本页格子是否为空的集合置为true
    for i = 0, self.mMaxGridCountPerPage - 1 do
        self.mGridEmptyStateTbl[i] = true
    end
    if bagItemList then
        ---遍历物品列表,使用物品列表中的物品刷新格子,并将本页格子集合中格子对应的bool值置为false
        for i, v in pairs(bagItemList) do
            ---处在最小和最大索引范围内时,表明该背包物品属于该页的一部分
            if i >= minIndex and i <= maxIndex then
                local localIndex = i - minIndex
                local gridGO = controlList[localIndex]
                local itemTbl = self.mItemTblMgr:GetItems(v.itemId)
                local isLocked = i > self.mBagMaxGridCount
                self:RefreshGridWithBagItemInfo(gridGO, v, itemTbl, isLocked)
                self.mGridEmptyStateTbl[localIndex] = false
            end
        end
    end
    ---遍历索引集合,重置刷新本页格子集合中所有对应值为true的格子
    for i, v in pairs(self.mGridEmptyStateTbl) do
        if v == true then
            local gridGO = controlList[i]
            local isLocked = (i + self.mPageIndex * self.mMaxGridCountPerPage + 1) > self.mBagMaxGridCount
            self:RefreshGridWithBagItemInfo(gridGO, nil, nil, isLocked)
        end
    end
end

---使用背包物品刷新格子
---@private
---@param gridGO UnityEngine.GameObject
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
---@param isLocked boolean
function UIBagPageCtrl:RefreshGridWithBagItemInfo(gridGO, bagItemInfo, itemInfo, isLocked)
    if gridGO then
        local template = self:GetGridController(gridGO)
        if template then
            template:RefreshWithInfo(bagItemInfo, itemInfo, isLocked)
            if bagItemInfo then
                self:GetPageBagItems()[bagItemInfo.lid] = template
            end
        end
    end
end

---获取格子物品对应的控制器
---@private
---@return UIBagGrid
function UIBagPageCtrl:GetGridController(gridGO)
    if self.mGridCtrls == nil then
        self.mGridCtrls = {}
    end
    local temp = self.mGridCtrls[gridGO]
    if temp == nil then
        temp = templatemanager.GetNewTemplate(gridGO, luaComponentTemplates.UIBagGrid, self:GetBagPanel(), self:GetBagPanel():GetBagInteraction(), self.mGetGridPrefabFunction)
        self.mGridCtrls[gridGO] = temp
    end
    return temp
end

return UIBagPageCtrl