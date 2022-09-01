---类背包容器交互层
---@class UIBagTypeContainerInteraction:TemplateBase
local UIBagTypeContainerInteraction = {}

local LuaEnumGridInteractionType = LuaEnumGridInteractionType
local unityTime = CS.UnityEngine.Time
local UnityEngineVector3 = CS.UnityEngine.Vector3

--region 字段
---全局锁,当某交互层处于交互过程中时,其他交互层不响应交互,此字段类似静态字段,各个交互层共享该字段
---@type UIBagTypeContainerInteraction|nil
UIBagTypeContainerInteraction.mLockObj = nil

---[[*******************************************单双击************************************************]]
---最近一次点击时间
---@type number
UIBagTypeContainerInteraction.mLatestClickTime = 0
---最远一次点击时间
---@type number
UIBagTypeContainerInteraction.mFarthestClickTime = 0
---[[*******************************************按下/抬起*********************************************]]
---按下的数量,用于标识被按下的格子数量,以便决定是否开始拖拽.此处容易出现bug,如果出现拖拽bug,应检查此功能是否运行正常
---@type number
UIBagTypeContainerInteraction.mPressedCount = 0
---[[*******************************************长按**************************************************]]
---最近一次长按的时间
---@type number
UIBagTypeContainerInteraction.mLatestPressDownTime = 0
---长按是否执行了
---@type boolean
UIBagTypeContainerInteraction.mIsLongPressActed = false
---最近一次长按按下的位置坐标
---@type UnityEngine.Vector2
UIBagTypeContainerInteraction.mLatestPressPosition = nil
---[[*******************************************拖拽**************************************************]]
---是否正在拖拽
UIBagTypeContainerInteraction.mIsDragging = false
---最近一次拖拽到的位置
UIBagTypeContainerInteraction.mLatestDragPosition = nil

---目标ScrollView是否处于运动中
UIBagTypeContainerInteraction.mIsMovingScrollView = false;
--endregion

--region 属性
---交互依赖的界面
---@public
---@return UIBagPanel
function UIBagTypeContainerInteraction:GetRelyPanel()
    return self.mRelyPanel
end

---可拖拽物品
---@public
---@return UIBagTypeDraggableItem
function UIBagTypeContainerInteraction:GetDraggableItem()
    return self.mDraggableItem
end

---获取依赖界面的UIScrollView组件
---@return UIScrollView
function UIBagTypeContainerInteraction:GetRelyPanelScrollView()
    return self.mRelyPanelScrollView
end

---交互是否正在忙
---@public
---@return boolean
function UIBagTypeContainerInteraction:IsBusy()
    ---当最近一次有效交互时间与当前时间小于交互时间间隔时,表示当前很忙不能响应操作
    if unityTime.time - self:GetLatestEffectiveInteractionTime() < self:GetInteractionTimeInterval() then
        return true
    end
    return false
end

---当前正在交互的格子
---@public
---@return UIBagTypeGrid
function UIBagTypeContainerInteraction:GetCurrentInteractedGrid()
    return self.mCurrentGrid
end

---当前正在交互的背包物品信息
---@public
---@return bagV2.BagItemInfo
function UIBagTypeContainerInteraction:GetCurrentInteractedBagItemInfo()
    return self.mCurrentBagItemInfo
end

---当前正在交互的背包物品表数据
---@public
---@return TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:GetCurrentInteractedBagItemTbl()
    return self.mCurrentBagItemTbl
end

---获取最近一次的有效交互时间
---@public
---@return number
function UIBagTypeContainerInteraction:GetLatestEffectiveInteractionTime()
    if self.mLatestEffectiveInteractionTime == nil then
        self.mLatestEffectiveInteractionTime = 0
    end
    return self.mLatestEffectiveInteractionTime
end

---当前交互类型
---@public
---@type LuaEnumGridInteractionType
function UIBagTypeContainerInteraction:GetCurrentInteractionType()
    if self.mCurrentInteractionType == nil then
        self.mCurrentInteractionType = LuaEnumGridInteractionType.None
    end
    return self.mCurrentInteractionType
end

---获取双击时间间隔
---@public
---@return number
function UIBagTypeContainerInteraction:GetDoubleClickTimeInterval()
    return 0.2
end

---获取交互时间间隔
---@public
---@return number
function UIBagTypeContainerInteraction:GetInteractionTimeInterval()
    return 0.05
end

---获取长按的判断距离
---@public
---@return number
function UIBagTypeContainerInteraction:GetLongPressJudgingDistance()
    return 1
end

---获取长按时间间隔
---@public
---@return number
function UIBagTypeContainerInteraction:GetLongPressTimeInterval()
    return 0.35
end
--endregion

--region 初始化
---初始化
---@param relyPanel UIBase 交互所依赖的界面
---@param draggableItem UIBagTypeDraggableItem 可拖拽物品
---@param relyPanelScrollView UIScrollView 依赖界面的UIScrollView组件
function UIBagTypeContainerInteraction:Init(relyPanel, draggableItem, relyPanelScrollView)
    self.mRelyPanel = relyPanel
    self.mDraggableItem = draggableItem
    self.mRelyPanelScrollView = relyPanelScrollView

    if (relyPanelScrollView == nil) then
        return
    end

    if relyPanelScrollView.onDragStarted == nil then
        relyPanelScrollView.onDragStarted = function()
            self.mScrollViewOriginPosition = relyPanelScrollView.transform.localPosition;
        end
    else
        relyPanelScrollView.onDragStarted('+', function()
            self.mScrollViewOriginPosition = relyPanelScrollView.transform.localPosition;
        end)
    end

    relyPanelScrollView.onDragProgress = function()
        if self.mScrollViewOriginPosition == nil then
            return
        end
        local deviation = CS.UnityEngine.Vector3.Distance(self.mScrollViewOriginPosition, relyPanelScrollView.transform.localPosition);
        if (not self.mIsMovingScrollView) then
            if (deviation > 0.1) then
                self.mIsMovingScrollView = true;
            end
        end
    end

    relyPanelScrollView.onStoppedMoving = function()
        self.mIsMovingScrollView = false;
    end
end
--endregion

--region 事件
---背包类型变化事件
function UIBagTypeContainerInteraction:OnBagTypeChanged()
    if self.mIsDragging and self:GetCurrentInteractionType() == LuaEnumGridInteractionType.DragAfterLongPress then
        ---背包类型变化时,若处在拖拽状态,应当结束拖拽
        self:OnGridEndBeingDragged(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl())
    end
    self.mPressedCount = 0
    self:OnInteractionDone(LuaEnumGridInteractionType.None)
end

---交互执行完毕事件
---@param interactionType LuaEnumGridInteractionType 交互类型,为None表示需要重置或停止交互
function UIBagTypeContainerInteraction:OnInteractionDone(interactionType)
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

--region 交互事件
---格子被单击
---@public
---@param grid UIBagTypeGrid 被点击的格子
---@param bagItemInfo bagV2.BagItemInfo 被点击格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被点击物品表数据
function UIBagTypeContainerInteraction:OnGridClicked(grid, bagItemInfo, itemTbl)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and (bagItemInfo == nil or itemTbl == nil) then
        return
    end
    if self:GetIsLocked() then
        return
    end
    if self:IsBusy() or self.mIsLongPressActed then
        return
    end
    if self:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl) == false then
        ---当双击被禁用时,直接调用单击
        self.mCurrentGrid = grid
        self.mCurrentBagItemInfo = bagItemInfo
        self.mCurrentBagItemTbl = itemTbl
        self.mCurrentInteractionType = LuaEnumGridInteractionType.SingleClick
        self:DoInteraction_SingleClick(grid, bagItemInfo, itemTbl)
        return
    end
    ---当点击到另一个格子时,重置
    if self:GetCurrentInteractedGrid() ~= nil and self:GetCurrentInteractedGrid() ~= grid then
        self.mLatestClickTime = 0
        self.mFarthestClickTime = 0
        self.mCurrentGrid = nil
        self.mCurrentBagItemInfo = nil
        self.mCurrentBagItemTbl = nil
        self.mCurrentInteractionType = LuaEnumGridInteractionType.None
        self:UnlockSelf()
        return
    end
    self.mCurrentGrid = grid
    self.mCurrentBagItemInfo = bagItemInfo
    self.mCurrentBagItemTbl = itemTbl
    self.mCurrentInteractionType = LuaEnumGridInteractionType.SingleClick
    local currentTime = unityTime.time
    local timeDiff = currentTime - self.mLatestClickTime
    self.mLatestClickTime = currentTime
    if self.mFarthestClickTime == 0 then
        self.mFarthestClickTime = currentTime
    end
    if timeDiff < self:GetDoubleClickTimeInterval() then
        self:DoInteraction_DoubleClick(grid, bagItemInfo, itemTbl)
    end
end

---格子被按住/释放
---@public
---@param grid UIBagTypeGrid 被按住/释放的格子
---@param bagItemInfo bagV2.BagItemInfo 被按住/释放格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被按住/释放物品表数据
---@param isPressed boolean 是否被按住
---@param position UnityEngine.Vector2 当前Mouse/Touch坐标
function UIBagTypeContainerInteraction:OnGridPressed(grid, bagItemInfo, itemTbl, isPressed, position)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and (bagItemInfo == nil or itemTbl == nil) then
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
        self.mCurrentBagItemInfo = bagItemInfo
        self.mCurrentBagItemTbl = itemTbl
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
            self.mCurrentBagItemInfo = nil
            self.mCurrentBagItemTbl = nil
            self.mCurrentInteractionType = LuaEnumGridInteractionType.None
            self.mLatestPressDownTime = 0
            self.mLatestPressPosition = nil
        end
    end
end

---格子开始被拖拽
---@public
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param pos UnityEngine.Vector2 位置
function UIBagTypeContainerInteraction:OnGridStartBeingDragged(grid, bagItemInfo, itemTbl, pos)
    if grid == nil then
        return
    end
    if self:IsEmptyGridInteractionAvailable() == false and (bagItemInfo == nil or itemTbl == nil) then
        return
    end
    if self:GetIsLocked() or self:GetIsMovingScrollView() then
        return
    end
    if self:GetCurrentInteractionType() == LuaEnumGridInteractionType.LongPress and self.mIsDragging == false and (pos - self.mLatestPressPosition).magnitude > self:GetLongPressJudgingDistance() then
        ---长按时若有拖动且拖动的距离超过了长按判定距离,则判断为长按失效
        self:OnInteractionDone(LuaEnumGridInteractionType.None)
    end
    if self:IsDragAvailable(grid, bagItemInfo, itemTbl) == false or self.mIsDragging == false or self:GetCurrentInteractedGrid() ~= grid then
        return
    end
    pos = self:TransferScreenPosToWorldPosition(pos)
    self.mLatestDragPosition = pos
    self.mCurrentInteractionType = LuaEnumGridInteractionType.DragAfterLongPress
    self:DoInteraction_StartDragAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl(), pos)
end

---格子被拖拽中
---@public
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param pos UnityEngine.Vector2 位置
function UIBagTypeContainerInteraction:OnGridBeingDragged(grid, bagItemInfo, itemTbl, pos)
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
    self:DoInteraction_DraggingAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl(), self.mLatestDragPosition)
end

---格子结束拖拽
---@public
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param isDestroyed boolean 是否因格子被销毁触发的结束拖拽
function UIBagTypeContainerInteraction:OnGridEndBeingDragged(grid, bagItemInfo, itemTbl, isDestroyed)
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
    self:DoInteraction_EndDragAfterLongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl(), isDestroyed)
end

---交互层自身是否被锁起来
---@private
---@return boolean
function UIBagTypeContainerInteraction:GetIsLocked()
    if UIBagTypeContainerInteraction.mLockObj == nil then
        return false
    end
    return UIBagTypeContainerInteraction.mLockObj ~= self
end

function UIBagTypeContainerInteraction:GetIsMovingScrollView()
    return self.mIsMovingScrollView;
end

---以交互层自身锁住其他交互层,若返回false则说明锁住失败,其他交互层已提前锁住
---@private
---@return boolean
function UIBagTypeContainerInteraction:LockSelf()
    if self:GetIsLocked() then
        return false
    end
    UIBagTypeContainerInteraction.mLockObj = self
    return true
end

---解锁自身
---@private
function UIBagTypeContainerInteraction:UnlockSelf()
    if UIBagTypeContainerInteraction.mLockObj == self then
        UIBagTypeContainerInteraction.mLockObj = nil
    end
end
--endregion

--region 刷新
---逐帧刷新
---@public
---@param time number
function UIBagTypeContainerInteraction:OnUpdate(time)

    if self.mCurrentInteractionType == LuaEnumGridInteractionType.SingleClick then
        if time - self.mFarthestClickTime > self:GetDoubleClickTimeInterval() then
            if self:GetIsLocked() then
                self:OnInteractionDone(LuaEnumGridInteractionType.None)
            else
                self:DoInteraction_SingleClick(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl())
            end
        end
    end
    if self.mCurrentInteractionType == LuaEnumGridInteractionType.LongPress then
        if time - self.mLatestPressDownTime > self:GetLongPressTimeInterval() then
            if self:GetIsLocked() then
                self:OnInteractionDone(LuaEnumGridInteractionType.None)
            else
                ---超过长按时间间隔时触发长按/开始拖拽
                if self:IsDragAvailable(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl()) then
                    ---当拖拽被启用时,且当前按下的格子数量为1时,长按开启拖拽
                    if self.mIsDragging == false and self.mPressedCount == 1 then
                        if self:GetCurrentInteractedGrid() ~= nil then
                            if self:IsDragAvailable(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl()) and not self:GetIsMovingScrollView() then
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
                    self:DoInteraction_LongPress(self:GetCurrentInteractedGrid(), self:GetCurrentInteractedBagItemInfo(), self:GetCurrentInteractedBagItemTbl())
                end
            end
        end
    end
end
--endregion

--region 执行交互
---执行单击交互
---@param grid UIBagTypeGrid 被单击的格子
---@param bagItemInfo bagV2.BagItemInfo 被单击格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被单击物品表数据
function UIBagTypeContainerInteraction:DoInteraction_SingleClick(grid, bagItemInfo, itemTbl)
    if self:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl) == false or self:LockSelf() == false then
        return
    end
    if self.mIsDragging ~= true then
        self:DoSingleClick(grid, bagItemInfo, itemTbl)
    end
    self:OnInteractionDone(LuaEnumGridInteractionType.SingleClick)
end

---执行双击交互
---@param grid UIBagTypeGrid 被双击的格子
---@param bagItemInfo bagV2.BagItemInfo 被双击格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被双击物品表数据
function UIBagTypeContainerInteraction:DoInteraction_DoubleClick(grid, bagItemInfo, itemTbl)
    if self:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl) == false or self:LockSelf() == false then
        return
    end
    self:DoDoubleClick(grid, bagItemInfo, itemTbl)
    self:OnInteractionDone(LuaEnumGridInteractionType.DoubleClick)
end

---执行长按交互
---@param grid UIBagTypeGrid 被长按的格子
---@param bagItemInfo bagV2.BagItemInfo 被长按格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被长按物品表数据
function UIBagTypeContainerInteraction:DoInteraction_LongPress(grid, bagItemInfo, itemTbl)
    if self:IsLongPressAvailable(grid, bagItemInfo, itemTbl) == false or self:LockSelf() == false then
        return
    end
    self:DoLongPress(grid, bagItemInfo, itemTbl)
    self:OnInteractionDone(LuaEnumGridInteractionType.LongPress)
end

---长时间按压后拖拽开始
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param position UnityEngine.Vector3 Mouse/Touch的世界坐标(z轴与UIBagPanel同值)
function UIBagTypeContainerInteraction:DoInteraction_StartDragAfterLongPress(grid, bagItemInfo, itemTbl, position)
    if self:IsDragAvailable(grid, bagItemInfo, itemTbl) == false or self:LockSelf() == false then
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():SetActive(true)
        self:GetDraggableItem():Refresh(bagItemInfo)
        self:GetDraggableItem():SetUIRootWorldPosition(position)
    end
    grid:Clear()
    ---开始拖拽时需要关闭ScrollView.
    if self:GetRelyPanelScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetRelyPanelScrollView()) == false then
        self:GetRelyPanelScrollView().enabled = false
    end
    self:DoStartDrag(grid, bagItemInfo, itemTbl, position)
end

---长时间按压后拖拽
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param position UnityEngine.Vector3 Mouse/Touch的世界坐标(z轴与UIBagPanel同值)
function UIBagTypeContainerInteraction:DoInteraction_DraggingAfterLongPress(grid, bagItemInfo, itemTbl, position)
    if self:IsDragAvailable(grid, bagItemInfo, itemTbl) == false then
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():SetUIRootWorldPosition(position)
    end
    self:DoBeingDragged(grid, bagItemInfo, itemTbl, position)
end

---长时间按压后拖拽结束
---@param grid UIBagTypeGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
---@param isDestroyed boolean 是否因被销毁导致的格子拖拽结束
function UIBagTypeContainerInteraction:DoInteraction_EndDragAfterLongPress(grid, bagItemInfo, itemTbl, isDestroyed)
    if self:IsDragAvailable(grid, bagItemInfo, itemTbl) == false then
        self:OnInteractionDone(LuaEnumGridInteractionType.DragAfterLongPress)
        return
    end
    if self:GetDraggableItem() then
        self:GetDraggableItem():SetActive(false)
    end
    grid:Refresh()
    ---结束拖拽时需要打开ScrollView
    if self:GetRelyPanelScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetRelyPanelScrollView()) == false then
        self:GetRelyPanelScrollView().enabled = true
    end
    local pos = self.mLatestDragPosition
    self.mLatestDragPosition = nil
    self:DoEndDrag(grid, bagItemInfo, itemTbl, pos, isDestroyed)
    self:OnInteractionDone(LuaEnumGridInteractionType.DragAfterLongPress)
end
--endregion

--region 工具
---将屏幕坐标转化为UIRoot的相对坐标(z轴与UIBagPanel同值)
---@private
---@param screenPosition UnityEngine.Vector2
---@return UnityEngine.Vector3
function UIBagTypeContainerInteraction:TransferScreenPosToWorldPosition(screenPosition)
    if self.mUIRoot == nil then
        self.mUIRoot = CS.UIManager.Instance:GetUIRoot()
    end
    if self.mUICamera == nil then
        self.mUICamera = CS.UICamera.currentCamera
    end
    local pos = self.mUICamera:ScreenToWorldPoint(UnityEngineVector3(screenPosition.x, screenPosition.y, 0))
    pos.z = self.go.transform.position.z
    return pos
end
--endregion

--region 可重写属性/方法
---空格子是否可以交互
---@return boolean
function UIBagTypeContainerInteraction:IsEmptyGridInteractionAvailable()
    return false
end

---单击是否可用
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagTypeContainerInteraction:IsSingleClickedAvailable(grid, bagItemInfo, itemTbl)
    return false
end

---双击是否可用
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagTypeContainerInteraction:IsDoubleClickedAvailable(grid, bagItemInfo, itemTbl)
    return false
end

---长按是否可用
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagTypeContainerInteraction:IsLongPressAvailable(grid, bagItemInfo, itemTbl)
    return false
end

---长按后拖拽是否可用
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagTypeContainerInteraction:IsDragAvailable(grid, bagItemInfo, itemTbl)
    return false
end

---执行单击
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoSingleClick(grid, bagItemInfo, itemTbl)

end

---执行双击
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoDoubleClick(grid, bagItemInfo, itemTbl)

end

---执行长按
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoLongPress(grid, bagItemInfo, itemTbl)

end

---执行开始拖拽
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoStartDrag(grid, bagItemInfo, itemTbl, pos)

end

---执行正在被拖拽
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoBeingDragged(grid, bagItemInfo, itemTbl, pos)

end

---执行结束拖拽
---@param grid UIBagTypeGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagTypeContainerInteraction:DoEndDrag(grid, bagItemInfo, itemTbl, pos, isDestroyed)

end
--endregion

--region 析构
function UIBagTypeContainerInteraction:OnDestroy()
    self:UnlockSelf()
end
--endregion

return UIBagTypeContainerInteraction