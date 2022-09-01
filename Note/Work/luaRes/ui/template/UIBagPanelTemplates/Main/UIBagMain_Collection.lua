---藏品背包
---@class UIBagMain_Collection:UIBagMain_Normal
local UIBagMain_Collection = {}

setmetatable(UIBagMain_Collection, luaComponentTemplates.UIBagMainNormal)

---[[********************************* 重写属性 ***************************************]]

function UIBagMain_Collection:IsItemDragAvailable()
    return true
end

function UIBagMain_Collection:IsUseServerOrder()
    return false
end

function UIBagMain_Collection:GetReversedExpandBagType()
    return LuaEnumBagType.CollectionRecycle
end

function UIBagMain_Collection:BagItemListSortFunction(leftItem, rightItem)
    ---将藏品排在前面,非藏品放在后面
    local leftType = leftItem.ItemTABLE.type
    local leftSubType = leftItem.ItemTABLE.subType
    local rightType = rightItem.ItemTABLE.type
    local rightSubType = rightItem.ItemTABLE.subType
    if leftType ~= rightType then
        if leftType == luaEnumItemType.Collection then
            return true
        end
        if rightType == luaEnumItemType.Collection then
            return false
        end
    else
        if leftType == luaEnumItemType.Collection then
            if leftSubType == rightSubType then
                return leftItem.index < rightItem.index
            end
            return leftSubType < rightSubType
        else
            return leftItem.index < rightItem.index
        end
    end
end

function UIBagMain_Collection:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type ~= luaEnumItemType.Collection then
        ---置灰非藏品
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

---[[********************************* 生命周期方法 ***************************************]]

function UIBagMain_Collection:OnInit()
    self:RunBaseFunction("OnInit")
end

function UIBagMain_Collection:OnEnable()
    self:RunBaseFunction("OnEnable")
    self:GetBagPanel():GetBagDraggedItem():BindExtraRefreshFunction(function(draggedItem, item)
        return self:RefreshDraggedItem(draggedItem, item)
    end)
end

function UIBagMain_Collection:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:GetBagPanel():GetBagDraggedItem():ClearExtraRefreshFunction()
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetBagDraggedItem() ~= nil then
        self:GetBagPanel():GetBagDraggedItem():ResetAtlas()
    end
    if self.mIsDragging then
        self.mIsDragging = false
        ---@type UICollectionPanel
        local collectionPanel = uimanager:GetPanel("UICollectionPanel")
        if collectionPanel ~= nil and collectionPanel:GetCollectionItemsController() ~= nil then
            collectionPanel:GetCollectionItemsController():SetDraggingCoveredCoords()
            collectionPanel:GetCollectionItemsController():SetCanDragEffectiveState(nil)
            collectionPanel:RefreshUI()
        end
    end
end

---[[********************************* 拖拽物品的刷新方法 ***************************************]]

---刷新被拖拽的物品
---@param draggedItem UIBagTypeDraggableItem
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean 是否中断执行之前的拖拽物品刷新逻辑
function UIBagMain_Collection:RefreshDraggedItem(draggedItem, bagItemInfo)
    if bagItemInfo == nil or bagItemInfo.itemId == nil then
        return false
    end
    if CS.StaticUtility.IsNull(draggedItem:GetIconSprite()) == false then
        local collectionTable = clientTableManager.cfg_collectionManager:TryGetValue(bagItemInfo.itemId)
        if collectionTable == nil then
            return false
        end
        ---@type UICollectionPanel
        local collectionPanel = uimanager:GetPanel("UICollectionPanel")
        if collectionPanel == nil then
            return false
        end
        draggedItem:GetIconSprite().atlas = collectionPanel:GetUIAtlas("UI_Collection")
        draggedItem:GetIconSprite().enabled = false
        draggedItem:GetIconSprite().enabled = true
        draggedItem:GetIconSprite().spriteName = collectionTable:GetBindingId()
        draggedItem:GetIconSprite():MakePixelPerfect()
        return true
    end
    return false
end

---[[********************************* 重写方法 ***************************************]]

function UIBagMain_Collection:IsGridCanBeDragged(bagGrid, bagItemInfo, itemTbl)
    return itemTbl.type == luaEnumItemType.Collection
end

function UIBagMain_Collection:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type == luaEnumItemType.Collection then
        self:RunBaseFunction("OnGridClicked", bagGrid, bagItemInfo, itemTbl)
    else
        ---啥都不干
        ---Utility.ShowPopoTips(bagGrid.go, "此面板不可操作", 290, "UIBagPanel")
    end
end

function UIBagMain_Collection:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type == luaEnumItemType.Collection then
        local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
        local bagItemInCarbinet = collectionInfo:GetCollectionItemByCollectionID(bagItemInfo.itemId)
        if bagItemInCarbinet ~= nil and collectionInfo:IsLeftBetterThanRight(bagItemInCarbinet:GetCollectionBagItem(), bagItemInfo) then
            ---如果藏品阁中有该物品且比当前物品更好,则二次弹窗确认
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, false)
            if result == false then
                Utility.ShowPopoTips(bagGrid.go, resultStr, 290, "UIBagPanel")
            else
                local wordTbl, tblExist
                tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(155)
                if tblExist and wordTbl then
                    Utility.ShowSecondConfirmPanel({ PromptWordId = 155, ComfireAucion = function()
                        collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
                    end })
                else
                    collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
                end
            end
        else
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
            if result == false then
                Utility.ShowPopoTips(bagGrid.go, resultStr, 290, "UIBagPanel")
            end
        end
    else
        Utility.ShowPopoTips(bagGrid.go, "此面板不可操作", 290, "UIBagPanel")
    end
end

function UIBagMain_Collection:OnGridStartBeingDragged(bagGrid, bagItemInfo, itemTbl, position)
    self.mIsDragging = true
end

function UIBagMain_Collection:OnGridBeingDragged(bagGrid, bagItemInfo, itemTbl, position)
    ---@type UICollectionPanel
    local collectionPanel = uimanager:GetPanel("UICollectionPanel")
    if collectionPanel ~= nil and collectionPanel:GetCollectionItemsController() ~= nil
            and collectionPanel:GetCollectionItemsController():GetCenterPageTemplate() ~= nil
            and self:GetBagPanel() ~= nil
            and self:GetBagPanel():GetBagDraggedItem() ~= nil then
        local page = collectionPanel:GetCollectionItemsController():GetCenterPageTemplate()
        local widget = self:GetBagPanel():GetBagDraggedItem():GetIconSprite()
        if widget then
            local coveredGridList, coveredCenterGridList = page:CalculateWidgetCoveredGrids(widget)
            collectionPanel:GetCollectionItemsController():SetDraggingCoveredCoords(coveredGridList, coveredCenterGridList)
            ---设置被拖拽对象的颜色
            local isAnyCenterCoveredGridExist = false
            if coveredCenterGridList ~= nil and #coveredCenterGridList > 0 then
                for i = 1, #coveredCenterGridList do
                    local coordTemp = coveredCenterGridList[i]
                    if coordTemp.x >= 0 and coordTemp.x < luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine() and
                            coordTemp.y >= 0 and coordTemp.y < luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn() then
                        isAnyCenterCoveredGridExist = true
                    end
                end
            end
            if isAnyCenterCoveredGridExist == false then
                self:GetBagPanel():GetBagDraggedItem():SetIconColor(CS.UnityEngine.Color.white)
                collectionPanel:GetCollectionItemsController():SetCanDragEffectiveState(nil)
            else
                ---找到遮住的格子中的左上角坐标,优先行
                local x = 100000
                local y = 100000
                for i = 1, #coveredCenterGridList do
                    local coordTemp = coveredCenterGridList[i]
                    if coordTemp.x <= x and coordTemp.y <= y then
                        x = coordTemp.x
                        y = coordTemp.y
                    end
                end
                if x == 100000 or y == 100000 then
                    return
                end
                local result = collectionPanel:GetCollectionInfo():TryReqPutOnCollectionItem(bagItemInfo,
                        collectionPanel:GetCollectionItemsController():GetCenterPageIndex(), x, y, false)
                if result then
                    ---如果可以设置到该位置,设置icon为白色
                    self:GetBagPanel():GetBagDraggedItem():SetIconColor(CS.UnityEngine.Color.white)
                    collectionPanel:GetCollectionItemsController():SetCanDragEffectiveState(true)
                else
                    ---如果可以设置到该位置,设置icon为红色
                    self:GetBagPanel():GetBagDraggedItem():SetIconColor(CS.UnityEngine.Color.red)
                    collectionPanel:GetCollectionItemsController():SetCanDragEffectiveState(false)
                end
            end
            collectionPanel:GetCollectionItemsController():RefreshAllPages()
        end
    end
end

function UIBagMain_Collection:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)
    self.mIsDragging = false
    ---@type UICollectionPanel
    local collectionPanel = uimanager:GetPanel("UICollectionPanel")
    if collectionPanel ~= nil and collectionPanel:GetCollectionItemsController() ~= nil then
        local page = collectionPanel:GetCollectionItemsController():GetCenterPageTemplate()
        local widget = self:GetBagPanel():GetBagDraggedItem():GetIconSprite()
        if page ~= nil and widget ~= nil then
            local coveredGridList, coveredCenterGridList = page:CalculateWidgetCoveredGrids(widget)
            local isAnyCenterCoveredGridExist = false
            if coveredCenterGridList ~= nil and #coveredCenterGridList > 0 then
                for i = 1, #coveredCenterGridList do
                    local coordTemp = coveredCenterGridList[i]
                    if coordTemp.x >= 0 and coordTemp.x < luaclass.LuaCollectionInfo.GetCollectionGridCountPerLine() and
                            coordTemp.y >= 0 and coordTemp.y < luaclass.LuaCollectionInfo.GetCollectionGridCountPerColumn() then
                        isAnyCenterCoveredGridExist = true
                    end
                end
            end
            if isAnyCenterCoveredGridExist then
                collectionPanel:GetCollectionItemsController():TrySetDraggedBagItemInCoord(bagItemInfo, coveredCenterGridList)
            end
        end
        collectionPanel:GetCollectionItemsController():SetDraggingCoveredCoords()
        collectionPanel:GetCollectionItemsController():SetCanDragEffectiveState(nil)
        collectionPanel:RefreshUI()
    end
end

return UIBagMain_Collection