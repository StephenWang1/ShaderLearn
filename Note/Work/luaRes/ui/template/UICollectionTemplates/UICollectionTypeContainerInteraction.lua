---@class UICollectionTypeContainerInteraction:UIBagTypeContainerInteraction
local UICollectionTypeContainerInteraction = {}

local LuaEnumGridInteractionType = LuaEnumGridInteractionType
local unityTime = CS.UnityEngine.Time

setmetatable(UICollectionTypeContainerInteraction, luaComponentTemplates.UIBagType_Interaction)

--region 属性
---获取当前交互的藏品物品
---@return LuaCollectionItem 当前交互的藏品物品
function UICollectionTypeContainerInteraction:GetCurrentInteractedCollectionItem()
    return self.mCollectionItem
end

---获取当前交互的格子是否被锁住了
---@return boolean
function UICollectionTypeContainerInteraction:GetIsCurrentInteractedGridLocked()
    return self.isLocked or false
end

---可拖拽物品
---@public
---@return UICollectionItemDraggableItem
function UICollectionTypeContainerInteraction:GetDraggableItem()
    return self.mDraggableItem
end

---获取长按的判断距离(重写)
---@public
---@return number
function UICollectionTypeContainerInteraction:GetLongPressJudgingDistance()
    return 10
end

---获取长按时间间隔(重写)
---@public
---@return number
function UICollectionTypeContainerInteraction:GetLongPressTimeInterval()
    return 0.15
end
--endregion

--region 交互事件
---格子被单击
---@public
---@param grid UICollectionItemGrid 被点击的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isLocked boolean 格子是否被锁住了
function UICollectionTypeContainerInteraction:OnGridClicked(grid, mCollectionItem, isLocked)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and mCollectionItem == nil then
        return
    end
    if self:GetIsLocked() then
        return
    end
    if self:IsBusy() or self.mIsLongPressActed then
        return
    end
    if self:IsDoubleClickedAvailable(grid, mCollectionItem) == false then
        ---当双击被禁用时,直接调用单击
        self.mCurrentGrid = grid
        self.mCollectionItem = mCollectionItem
        self.isLocked = isLocked
        self.mCurrentInteractionType = LuaEnumGridInteractionType.SingleClick
        self:DoInteraction_SingleClick(grid, mCollectionItem, isLocked)
        return
    end
    ---当点击到另一个格子时,重置
    if self:GetCurrentInteractedGrid() ~= nil and self:GetCurrentInteractedGrid() ~= grid then
        self.mLatestClickTime = 0
        self.mFarthestClickTime = 0
        self.mCurrentGrid = nil
        self.isLocked = false
        self.mCollectionItem = nil
        self.mCurrentBagItemTbl = nil
        self.mCurrentInteractionType = LuaEnumGridInteractionType.None
        self:UnlockSelf()
        return
    end
    self.mCurrentGrid = grid
    self.isLocked = isLocked
    self.mCollectionItem = mCollectionItem
    self.mCurrentInteractionType = LuaEnumGridInteractionType.SingleClick
    local currentTime = unityTime.time
    local timeDiff = currentTime - self.mLatestClickTime
    self.mLatestClickTime = currentTime
    if self.mFarthestClickTime == 0 then
        self.mFarthestClickTime = currentTime
    end
    if timeDiff < self:GetDoubleClickTimeInterval() then
        self:DoInteraction_DoubleClick(grid, mCollectionItem)
    end
end

---格子被按住/释放
---@public
---@param grid UICollectionItemGrid 被按住/释放的格子
---@param mCollectionItem LuaCollectionItem 被按住格子的藏品数据
---@param isPressed boolean 是否被按住
---@param position UnityEngine.Vector2 当前Mouse/Touch坐标
function UICollectionTypeContainerInteraction:OnGridPressed(grid, mCollectionItem, isPressed, position)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and mCollectionItem == nil then
        return
    end
    if self:GetIsLocked() then
        return
    end
    self.mPressedCount = self.mPressedCount + (isPressed == true and 1 or -1)
    if self:IsBusy() or (self:GetCurrentInteractedGrid() ~= grid and self:GetCurrentInteractedGrid() ~= nil) then
        return
    end
    if isPressed then
        self.mCurrentGrid = grid
        self.mCollectionItem = mCollectionItem
        self.mCurrentInteractionType = LuaEnumGridInteractionType.LongPress
        self.mLatestPressDownTime = unityTime.time
        self.mIsLongPressActed = false
        self.mLatestPressPosition = position
    else
        if self.mCurrentInteractionType == LuaEnumGridInteractionType.LongPress then
            if self:GetCurrentInteractedGrid() ~= nil then
                self:GetCurrentInteractedGrid():SetGridToBeDraggable(false)
            end
            self.mCurrentGrid = nil
            self.mCollectionItem = nil
            self.mCurrentInteractionType = LuaEnumGridInteractionType.None
            self.mLatestPressDownTime = 0
            self.mLatestPressPosition = nil
        end
    end
end

---格子开始被拖拽
---@public
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被拖拽格子的藏品数据
---@param pos UnityEngine.Vector2 位置
function UICollectionTypeContainerInteraction:OnGridStartBeingDragged(grid, mCollectionItem, pos)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and mCollectionItem == nil then
        return
    end
    if self:GetIsLocked() or self:GetIsMovingScrollView() then
        return
    end
    if self:GetCurrentInteractionType() == LuaEnumGridInteractionType.LongPress and self.mIsDragging == false
            and (pos - self.mLatestPressPosition).magnitude > self:GetLongPressJudgingDistance() then
        ---长按时若有拖动且拖动的距离超过了长按判定距离,则判断为长按失效
        self:OnInteractionDone(LuaEnumGridInteractionType.None)
    end
    if self:IsDragAvailable(grid, mCollectionItem) == false or self.mIsDragging == false or self:GetCurrentInteractedGrid() ~= grid then
        return
    end
    pos = self:TransferScreenPosToWorldPosition(pos)
    self.mLatestDragPosition = pos
    self.mCurrentInteractionType = LuaEnumGridInteractionType.DragAfterLongPress
    self:DoInteraction_StartDragAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem(), pos)
end

---格子被拖拽中
---@public
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被拖拽格子的藏品数据
---@param pos UnityEngine.Vector2 位置
function UICollectionTypeContainerInteraction:OnGridBeingDragged(grid, mCollectionItem, pos)
    if grid == nil then
        return
    end
    if self:GetIsLocked() or self:GetIsMovingScrollView() then
        return
    end
    if self:GetCurrentInteractionType() ~= LuaEnumGridInteractionType.DragAfterLongPress or self.mIsDragging == false or self:GetCurrentInteractedGrid() ~= grid then
        return
    end
    pos = self:TransferScreenPosToWorldPosition(pos)
    self.mLatestDragPosition = pos
    self:DoInteraction_DraggingAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem(), self.mLatestDragPosition)
end

---格子结束拖拽
---@public
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被拖拽格子的藏品数据
---@param isDestroyed boolean 是否因格子被销毁触发的结束拖拽
function UICollectionTypeContainerInteraction:OnGridEndBeingDragged(grid, mCollectionItem, isDestroyed)
    if grid == nil then
        return
    end
    if self:GetIsLocked() or self:GetIsMovingScrollView() then
        return
    end
    if self:GetCurrentInteractionType() ~= LuaEnumGridInteractionType.DragAfterLongPress or self.mIsDragging == false or self:GetCurrentInteractedGrid() ~= grid then
        return
    end
    self.mIsDragging = false
    if self:GetCurrentInteractedGrid() ~= nil then
        self:GetCurrentInteractedGrid():SetGridToBeDraggable(false)
    end
    if isDestroyed then
        self.mPressedCount = self.mPressedCount - 1
        if self.mPressedCount < 0 then
            self.mPressedCount = 0
        end
    end
    self:DoInteraction_EndDragAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem(), isDestroyed)
end

---交互层自身是否被锁起来
---@private
---@return boolean
function UICollectionTypeContainerInteraction:GetIsLocked()
    if luaComponentTemplates.UIBagType_Interaction.mLockObj == nil then
        return false
    end
    return luaComponentTemplates.UIBagType_Interaction.mLockObj ~= self
end

function UICollectionTypeContainerInteraction:GetIsMovingScrollView()
    return self.mIsMovingScrollView;
end

---以交互层自身锁住其他交互层,若返回false则说明锁住失败,其他交互层已提前锁住
---@private
---@return boolean
function UICollectionTypeContainerInteraction:LockSelf()
    if self:GetIsLocked() then
        return false
    end
    luaComponentTemplates.UIBagType_Interaction.mLockObj = self
    return true
end

---解锁自身
---@private
function UICollectionTypeContainerInteraction:UnlockSelf()
    if luaComponentTemplates.UIBagType_Interaction.mLockObj == self then
        luaComponentTemplates.UIBagType_Interaction.mLockObj = nil
    end
end
--endregion

--region 执行交互
---执行单击交互
---@param grid UICollectionItemGrid 被单击的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isLocked boolean 格子是否被锁住了
function UICollectionTypeContainerInteraction:DoInteraction_SingleClick(grid, mCollectionItem, isLocked)
    if self:IsSingleClickedAvailable(grid, mCollectionItem) == false or self:LockSelf() == false then
        return
    end
    if self.mIsDragging ~= true then
        self:DoSingleClick(grid, mCollectionItem, isLocked)
    end
    self:OnInteractionDone(LuaEnumGridInteractionType.SingleClick)
end

---执行双击交互
---@param grid UICollectionItemGrid 被双击的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionTypeContainerInteraction:DoInteraction_DoubleClick(grid, mCollectionItem)
    if self:IsDoubleClickedAvailable(grid, mCollectionItem) == false or self:LockSelf() == false then
        return
    end
    self:DoDoubleClick(grid, mCollectionItem)
    self:OnInteractionDone(LuaEnumGridInteractionType.DoubleClick)
end

---执行长按交互
---@param grid UICollectionItemGrid 被长按的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionTypeContainerInteraction:DoInteraction_LongPress(grid, mCollectionItem)
    if self:IsLongPressAvailable(grid, mCollectionItem) == false or self:LockSelf() == false then
        return
    end
    self:DoLongPress(grid, mCollectionItem)
    self:OnInteractionDone(LuaEnumGridInteractionType.LongPress)
end

---长时间按压后拖拽开始
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param position UnityEngine.Vector3 Mouse/Touch的世界坐标(z轴与UIBagPanel同值)
function UICollectionTypeContainerInteraction:DoInteraction_StartDragAfterLongPress(grid, mCollectionItem, position)
    if self:IsDragAvailable(grid, mCollectionItem) == false or self:LockSelf() == false then
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():SetActive(true)
        self:GetDraggableItem():Refresh(grid, mCollectionItem, position)
        self:GetDraggableItem():SetUIRootWorldPosition(position, true)
    end
    grid:Clear()
    ---开始拖拽时需要关闭ScrollView.
    if self:GetRelyPanelScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetRelyPanelScrollView()) == false then
        self:GetRelyPanelScrollView().enabled = false
    end
    self:DoStartDrag(grid, mCollectionItem, position)
end

---长时间按压后拖拽
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param position UnityEngine.Vector3 Mouse/Touch的世界坐标(z轴与UIBagPanel同值)
function UICollectionTypeContainerInteraction:DoInteraction_DraggingAfterLongPress(grid, mCollectionItem, position)
    if self:IsDragAvailable(grid, mCollectionItem) == false then
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():SetUIRootWorldPosition(position, false)
    end
    self:DoBeingDragged(grid, mCollectionItem, position)
end

---长时间按压后拖拽结束
---@param grid UICollectionItemGrid 被拖拽的格子
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isDestroyed boolean 是否因被销毁导致的格子拖拽结束
function UICollectionTypeContainerInteraction:DoInteraction_EndDragAfterLongPress(grid, mCollectionItem, isDestroyed)
    if self:IsDragAvailable(grid, mCollectionItem) == false then
        self:OnInteractionDone(LuaEnumGridInteractionType.DragAfterLongPress)
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():OnDragStopped()
    end
    grid:Refresh()
    ---结束拖拽时需要打开ScrollView
    if self:GetRelyPanelScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetRelyPanelScrollView()) == false then
        self:GetRelyPanelScrollView().enabled = true
    end
    local pos = self.mLatestDragPosition
    self.mLatestDragPosition = nil
    self:DoEndDrag(grid, mCollectionItem, pos, isDestroyed)
    self:OnInteractionDone(LuaEnumGridInteractionType.DragAfterLongPress)
end
--endregion

--region 刷新
---逐帧刷新
---@private
---@param time number
function UICollectionTypeContainerInteraction:OnUpdate(time)

    if self.mCurrentInteractionType == LuaEnumGridInteractionType.SingleClick then
        if time - self.mFarthestClickTime > self:GetDoubleClickTimeInterval() then
            if self:GetIsLocked() then
                self:OnInteractionDone(LuaEnumGridInteractionType.None)
            else
                self:DoInteraction_SingleClick(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem(), self:GetIsLocked())
            end
        end
    end
    if self.mCurrentInteractionType == LuaEnumGridInteractionType.LongPress then
        if time - self.mLatestPressDownTime > self:GetLongPressTimeInterval() then
            if self:GetIsLocked() then
                self:OnInteractionDone(LuaEnumGridInteractionType.None)
            else
                ---超过长按时间间隔时触发长按/开始拖拽
                if self:IsDragAvailable(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem()) then
                    ---当拖拽被启用时,且当前按下的格子数量为1时,长按开启拖拽
                    if self.mIsDragging == false and self.mPressedCount == 1 then
                        if self:GetCurrentInteractedGrid() ~= nil then
                            if self:IsDragAvailable(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem()) and not self:GetIsMovingScrollView() then
                                ---当拖拽被启用时,设置各自的可拖拽状态
                                self:GetCurrentInteractedGrid():SetGridToBeDraggable(true)
                                self.mIsDragging = true
                            else
                                self.mCurrentGrid = nil
                            end
                        end
                    end
                else
                    ---当拖拽被禁用时,执行长按行为
                    self:DoInteraction_LongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedCollectionItem())
                end
            end
        end
    end
end
--endregion

--region 事件
---交互执行完毕事件
---@param interactionType LuaEnumGridInteractionType 交互类型,为None表示需要重置或停止交互
function UICollectionTypeContainerInteraction:OnInteractionDone(interactionType)
    self.mCollectionItem = nil
    self.isLocked = false

    self.mCurrentGrid = nil
    self.mCurrentBagItemInfo = nil
    self.mCurrentBagItemTbl = nil
    self.mCurrentInteractionType = LuaEnumGridInteractionType.None
    self.mLatestEffectiveInteractionTime = unityTime.time
    self.mLatestClickTime = 0
    self.mFarthestClickTime = 0
    self.mLatestPressDownTime = 0
    self.mIsDragging = false
    if interactionType == LuaEnumGridInteractionType.LongPress then
        self.mIsLongPressActed = true
    else
        self.mIsLongPressActed = false
    end
    self:UnlockSelf()
end
--endregion

--region 可重写属性/方法
---空格子是否可以交互
---@return boolean
function UICollectionTypeContainerInteraction:IsEmptyGridInteractionAvailable()
    return true
end

---单击是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction:IsSingleClickedAvailable(grid, mCollectionItem)
    return true
end

---双击是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction:IsDoubleClickedAvailable(grid, mCollectionItem)
    return false
end

---长按是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction:IsLongPressAvailable(grid, mCollectionItem)
    return true
end

---长按后拖拽是否可用
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@return boolean
function UICollectionTypeContainerInteraction:IsDragAvailable(grid, mCollectionItem)
    return true
end

---执行单击
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param isLocked boolean 是否是被锁住的格子
function UICollectionTypeContainerInteraction:DoSingleClick(grid, mCollectionItem, isLocked)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridSingleClick(grid, mCollectionItem, isLocked)
    end
end

---执行双击
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionTypeContainerInteraction:DoDoubleClick(grid, mCollectionItem)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridDoubleClick(grid, mCollectionItem)
    end
end

---执行长按
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
function UICollectionTypeContainerInteraction:DoLongPress(grid, mCollectionItem)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridLongPress(grid, mCollectionItem)
    end
end

---执行开始拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
function UICollectionTypeContainerInteraction:DoStartDrag(grid, mCollectionItem, pos)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridStartDrag(grid, mCollectionItem, pos)
    end
end

---执行正在被拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
function UICollectionTypeContainerInteraction:DoBeingDragged(grid, mCollectionItem, pos)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridBeingDragged(grid, mCollectionItem, pos)
    end
end

---执行结束拖拽
---@param grid UICollectionItemGrid
---@param mCollectionItem LuaCollectionItem 被点击格子的藏品数据
---@param pos UnityEngine.Vector3
---@param isDestroyed boolean 是否因销毁导致的结束拖拽
function UICollectionTypeContainerInteraction:DoEndDrag(grid, mCollectionItem, pos, isDestroyed)
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() then
        collectionPanel:GetCollectionItemsController():DoGridEndDrag(grid, mCollectionItem, pos)
    end
end
--endregion

return UICollectionTypeContainerInteraction