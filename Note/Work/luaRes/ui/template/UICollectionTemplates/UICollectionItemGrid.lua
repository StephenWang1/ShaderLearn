---@class UICollectionItemGrid:UIBagTypeGrid
local UICollectionItemGrid = {}

local UIEventListenerGetFunction = CS.UIEventListener.Get
local CSUICamera = CS.UICamera

setmetatable(UICollectionItemGrid, luaComponentTemplates.UIBagType_Grid)

UICollectionItemGrid.Components = {}
---背景
UICollectionItemGrid.Components.BackGround = "background"
---格子图标
UICollectionItemGrid.Components.Icon = "icon"
---第2个Icon
UICollectionItemGrid.Components.Icon2 = "icon2"
---锁标识
UICollectionItemGrid.Components.Lock = "lock"
---更好物品标识
UICollectionItemGrid.Components.Good = "good"
---强化标识
UICollectionItemGrid.Components.Strengthen = "strengthen"
---星星图片
UICollectionItemGrid.Components.Star = "star"
---数量文本
UICollectionItemGrid.Components.Count = "count"
---品质图片
UICollectionItemGrid.Components.Quality = "quality"
---小红点
UICollectionItemGrid.Components.RedPoint = "redpoint"
---红蒙版
UICollectionItemGrid.Components.RedMask = "redMask"
---选择框1
UICollectionItemGrid.Components.Check1 = "check"
---选择框2
UICollectionItemGrid.Components.Check2 = "check2"
---选中特效
UICollectionItemGrid.Components.ChosenEffect = "effect"
---选中特效2
UICollectionItemGrid.Components.ChosenEffect2 = "effect2"
---新物品标识
UICollectionItemGrid.Components.NewBagItem = "New"
---新物品特效
UICollectionItemGrid.Components.NewBagItemEffect = "NewEffect"
---回收特效
UICollectionItemGrid.Components.RecycleEffect = "RecycleEffect"
---血继标识
UICollectionItemGrid.Components.BloodLv = "BloodLv"
---血继标识文本
UICollectionItemGrid.Components.BloodLvLabel = "BloodLvLabel"
---绿色遮罩
UICollectionItemGrid.Components.GreenMask = "greenMask"

---获取交互层
---@return UICollectionTypeContainerInteraction
function UICollectionItemGrid:GetInteraction()
    return self.mInteraction
end

function UICollectionItemGrid:Refresh()
    self:RefreshWithInfo(self.mCoordX, self.mCoordY, self.mCollectionItem, self.mIsLocked)
end

function UICollectionItemGrid:Clear()
    for i, v in pairs(self.Components) do
        local tbl = self:GetCompTbl(v)
        if tbl then
            self:SetCompActive(v, false)
        end
    end
end

---使用藏品信息刷新格子
---@param coordX number 格子横坐标
---@param coordY number 格子纵坐标
---@param collectionItem LuaCollectionItem|nil 格子所归属的藏品信息
---@param isLocked boolean 是否是被锁住的格子
function UICollectionItemGrid:RefreshWithInfo(coordX, coordY, collectionItem, isLocked)
    self.mCollectionItem = collectionItem
    self.mIsLocked = isLocked
    self.mCoordX = coordX
    self.mCoordY = coordY
    self:BindInteractionEvents(true)
    self:Clear()
    if collectionItem ~= nil then
        ---藏品存在时隐藏背景和锁
        self:SetCompActive(self.Components.BackGround, false)
        self:SetCompActive(self.Components.Lock, false)
    else
        ---藏品不存在时显示背景
        self:SetCompActive(self.Components.BackGround, true)
        if isLocked then
            ---被锁住时显示锁
            self:SetCompActive(self.Components.Lock, true)
        else
            ---未被锁住时不显示锁
            self:SetCompActive(self.Components.Lock, false)
        end
    end
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if collectionPanel and collectionPanel:GetCollectionItemsController() ~= nil then
        collectionPanel:GetCollectionItemsController():RefreshSingleGrid(self, collectionItem)
    end
    self:ApplyAllPropertyChanges()
end

---绑定交互事件
---@private
---@param isBindEvent boolean 是否需要绑定事件
function UICollectionItemGrid:BindInteractionEvents(isBindEvent)
    if isBindEvent == self.mIsBindedEvents then
        return
    end
    self.mIsBindedEvents = isBindEvent
    if isBindEvent then
        UIEventListenerGetFunction(self.go).onClick = self.mOnClickFunc
        UIEventListenerGetFunction(self.go).onPress = self.mOnPressFunc
        UIEventListenerGetFunction(self.go).onDragStart = self.mOnDragStartFunc
        UIEventListenerGetFunction(self.go).onDrag = self.mOnDragFunc
        UIEventListenerGetFunction(self.go).onDragEnd = self.mOnDragEndFunc
    else
        ---单击和按下方法不注销
        UIEventListenerGetFunction(self.go).onClick = self.mOnClickFunc
        UIEventListenerGetFunction(self.go).onPress = self.mOnPressFunc
        UIEventListenerGetFunction(self.go).onDragStart = nil
        UIEventListenerGetFunction(self.go).onDrag = nil
        UIEventListenerGetFunction(self.go).onDragEnd = nil
    end
end

---格子点击事件
function UICollectionItemGrid:OnGridClicked()
    if self:GetInteraction() then
        if self.mCollectionItem then
            self:GetInteraction():OnGridClicked(self, self.mCollectionItem, self.mIsLocked)
        else
            self:GetInteraction():OnGridClicked(self, nil, self.mIsLocked)
        end
    end
end

---格子按住/释放事件
---@param isPressed boolean
function UICollectionItemGrid:OnGridPressed(isPressed)
    if self:GetInteraction() then
        if self.mCollectionItem then
            self:GetInteraction():OnGridPressed(self, self.mCollectionItem, isPressed, CSUICamera.currentTouch.pos)
        else
            self:GetInteraction():OnGridPressed(self, nil, isPressed, CSUICamera.currentTouch.pos)
        end
    end
end

---设置格子的是否可拖拽状态
---@public
---@param isDraggable boolean 是否可拖拽
function UICollectionItemGrid:SetGridToBeDraggable(isDraggable)
    if self:GetDragScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetDragScrollView()) == false then
        self:GetDragScrollView().enabled = isDraggable == false
    end
    ---@type UICollectionPanel
    local collectionPanel = self:GetRelyPanel()
    if self.mCollectionItem ~= nil and
            collectionPanel:GetCollectionItemsController() ~= nil and collectionPanel:GetCollectionItemsController():GetCenterPageTemplate() ~= nil then
        local pagePictureDrawer = collectionPanel:GetCollectionItemsController():GetCenterPageTemplate():GetPagePictureDrawer()
        ---令格子所对应的藏品的icon部分放大
        if pagePictureDrawer then
            local picTemplate = pagePictureDrawer:GetPictureDic()[self.mCollectionItem:GetCollectionLid()]
            if picTemplate then
                picTemplate:SetScaleTween(isDraggable)
            end
        end
    end
end

---格子开始被拖拽
function UICollectionItemGrid:OnStartBeingDragged()
    self.mIsBeingDragged = true
    ---拖拽开始
    if self.mCollectionItem ~= nil and self:GetInteraction() then
        self:GetInteraction():OnGridStartBeingDragged(self, self.mCollectionItem, CSUICamera.currentTouch.pos)
    end
end

---格子被拖拽中
function UICollectionItemGrid:OnBeingDragged(delta)
    ---拖拽过程中不应考虑物品数据和物品表数据是否存在的情况,因为拖拽过程和结束拖拽是在不同帧进行的,不能认为两个行为执行时数据相同
    if self:GetInteraction() then
        self:GetInteraction():OnGridBeingDragged(self, self.mCollectionItem, CSUICamera.currentTouch.pos)
    end
end

---格子结束拖拽
function UICollectionItemGrid:OnEndBeingDragged(isDestroyed)
    self.mIsBeingDragged = false
    ---结束拖拽触发时不应考虑物品数据和物品表数据是否存在的情况,因为开始拖拽和结束拖拽是在不同帧进行的,不能认为两个行为执行时数据相同
    if self:GetInteraction() then
        self:GetInteraction():OnGridEndBeingDragged(self, self.mCollectionItem, isDestroyed == true)
    end
end

return UICollectionItemGrid