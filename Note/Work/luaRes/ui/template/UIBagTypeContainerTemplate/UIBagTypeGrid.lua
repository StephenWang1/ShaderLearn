---类背包格子
---@class UIBagTypeGrid:TemplateBase
local UIBagTypeGrid = {}

--region 临时变量
---承载GridComponentData类的注释,另充当临时变量
---@class GridComponentData table
---@field public go UnityEngine.GameObject
---@field public isActive boolean
---@field public realActiveState boolean
---@field public sprite UISprite
---@field public spriteName string
---@field public realSpriteName string
---@field public r number
---@field public realR number
---@field public g number
---@field public realG number
---@field public b number
---@field public realB number
---@field public a number
---@field public realA number
---@field public label UILabel
---@field public labelContent string
---@field public realLabelContent string
---@field public componentEnabled boolean
---@field public realComponentEnabled boolean
---@field public fillamount number
---@field public realFillAmount number

local CheckNullFunction = CS.StaticUtility.IsNull
local UIEventListenerGetFunction = CS.UIEventListener.Get
local emptyStr = ""
local CSUtility_Lua = CS.Utility_Lua
local CSUICamera = CS.UICamera
local CSColor = CS.UnityEngine.Color
--endregion

--region 数据
---格子组件列表
---@protected
---@type table<string,GridComponentData>
UIBagTypeGrid.mComps = nil
---格子当前对应的背包物品数据
---@protected
---@type bagV2.BagItemInfo
UIBagTypeGrid.mBagItemInfo = nil
---格子是否被锁住
---@protected
---@type boolean
UIBagTypeGrid.mIsLocked = false
---格子当前对应的物品表数据
---@protected
---@type TABLE.CFG_ITEMS
UIBagTypeGrid.mItemTbl = nil
---是否正在刷新过程中
---@protected
---@type boolean
UIBagTypeGrid.mIsRefreshing = false
---标识是否绑定了事件
---@protected
---@type boolean
UIBagTypeGrid.mIsBindedEvents = nil
--endregion

--region 组件
---格子所依赖的界面
---@return UIBase
function UIBagTypeGrid:GetRelyPanel()
    return self.mRelyPanel
end

---拖拽ScrollView组件
---@private
---@return UIDragScrollView
function UIBagTypeGrid:GetDragScrollView()
    if self.mDragScrollView == nil then
        self.mDragScrollView = self:Get(emptyStr, "UIDragScrollView")
    end
    return self.mDragScrollView
end

---缩放Tweener
---@return TweenScale
function UIBagTypeGrid:GetScaleTweener()
    if self.mScaleTweener == nil then
        self.mScaleTweener = self:Get(emptyStr, "TweenScale")
    end
    return self.mScaleTweener
end
--endregion

--region 属性
---是否被锁住,nil表示格子未被初始化过
---@public
---@return boolean|nil
function UIBagTypeGrid:IsLocked()
    return self.mIsLocked
end

---返回该格子当前对应的背包物品数据
---@return bagV2.BagItemInfo
function UIBagTypeGrid:GetBagItemInfo()
    return self.mBagItemInfo
end

---返回该格子当前对应的物品表数据
---@return TABLE.CFG_ITEMS
function UIBagTypeGrid:GetItemTable()
    return self.mItemTbl
end

---获取交互层
---@return UIBagTypeContainerInteraction
function UIBagTypeGrid:GetInteraction()
    return self.mInteraction
end

---是否是平铺的背景,若为平铺的背景,则不拷贝background
---@return boolean
function UIBagTypeGrid:IsTiledBG()
    return false
end

---得到获取预设的方法
---@return fun(compName:string):UnityEngine.GameObject
function UIBagTypeGrid:GetFetchPrefabFunction()
    return self.mPrefabFetchFunction
end
--endregion

--region 初始化
---初始化
---@private
---@param relyPanel UIBase 依赖界面
---@param interaction UIBagTypeContainerInteraction 交互层
---@param prefabFetchFunction fun(compName:string):UnityEngine.GameObject 获取预设方法
function UIBagTypeGrid:Init(relyPanel, interaction, prefabFetchFunction)
    self.mRelyPanel = relyPanel
    self.mInteraction = interaction
    self.mPrefabFetchFunction = prefabFetchFunction
    self.mOnClickFunc = function(go)
        self:OnGridClicked()
    end
    self.mOnDragStartFunc = function(go)
        self:OnStartBeingDragged()
    end
    self.mOnDragFunc = function(go, delta)
        self:OnBeingDragged(delta)
    end
    self.mOnDragEndFunc = function(go)
        self:OnEndBeingDragged()
    end
    self.mOnPressFunc = function(go, isPressed)
        self:OnGridPressed(isPressed)
    end
end
--endregion

--region 可重写属性/方法
---背包格子下的组件,新加的任何组件都需要在这里或子类的Components中加上,如有触发式特效,则需要在IsTriggleComponent方法中返回true才能使其SetActive(true)时重新播放特效
---@public
---@class GridComponents
UIBagTypeGrid.Components = {}
---背景
UIBagTypeGrid.Components.BackGround = "background"
---格子图标
UIBagTypeGrid.Components.Icon = "icon"
---第2个Icon
UIBagTypeGrid.Components.Icon2 = "icon2"
---锁标识
UIBagTypeGrid.Components.Lock = "lock"
---更好物品标识
UIBagTypeGrid.Components.Good = "good"
---强化标识
UIBagTypeGrid.Components.Strengthen = "strengthen"
---星星图片
UIBagTypeGrid.Components.Star = "star"
---数量文本
UIBagTypeGrid.Components.Count = "count"
---品质图片
UIBagTypeGrid.Components.Quality = "quality"
---小红点
UIBagTypeGrid.Components.RedPoint = "redpoint"
---红蒙版
UIBagTypeGrid.Components.RedMask = "redMask"
---选择框1
UIBagTypeGrid.Components.Check1 = "check"
---选择框2
UIBagTypeGrid.Components.Check2 = "check2"
---选中特效
UIBagTypeGrid.Components.ChosenEffect = "effect"
---选中特效2
UIBagTypeGrid.Components.ChosenEffect2 = "effect2"
---新物品标识
UIBagTypeGrid.Components.NewBagItem = "New"
---新物品特效
UIBagTypeGrid.Components.NewBagItemEffect = "NewEffect"
---回收特效
UIBagTypeGrid.Components.RecycleEffect = "RecycleEffect"
---血继标识
UIBagTypeGrid.Components.BloodLv = "BloodLv"
---血继标识文本
UIBagTypeGrid.Components.BloodLvLabel = "BloodLvLabel"
---保险标识
UIBagTypeGrid.Components.Insure = "Insure"


---刷新单个格子
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品数据
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表数据
function UIBagTypeGrid:RefreshSingleGrid(bagItemInfo, itemTbl)
    self:SetCompSpriteName(self.Components.Icon, itemTbl.icon)
    self:SetCompLabelContent(self.Components.Count, (bagItemInfo.count <= 1) and emptyStr or tostring(bagItemInfo.count))
end

---判断组件是否为触发类型的组件,若返回true,则设置组件为true时,需要先真正的关闭然后再打开
---@protected
---@param compName string
---@return boolean
function UIBagTypeGrid:IsTriggleComponent(compName)
    if compName == self.Components.NewBagItemEffect then
        return true
    end
    if compName == self.Components.RecycleEffect then
        return true
    end
    return false
end

---设置格子的是否可拖拽状态
---@public
---@param isDraggable boolean 是否可拖拽
function UIBagTypeGrid:SetGridToBeDraggable(isDraggable)
    if self:GetDragScrollView() ~= nil and CS.StaticUtility.IsNull(self:GetDragScrollView()) == false then
        self:GetDragScrollView().enabled = isDraggable == false
    end
    if self:GetScaleTweener() ~= nil and CS.StaticUtility.IsNull(self:GetScaleTweener()) == false then
        if isDraggable then
            self:GetScaleTweener():PlayForward()
        else
            self:GetScaleTweener():PlayReverse()
        end
    end
end
--endregion

--region 使能/不使能
function UIBagTypeGrid:OnDisable()
    if self.mIsBeingDragged then
        ---若正在被拖拽时关闭了,则调用结束拖拽
        self:OnEndBeingDragged(true)
    end
end
--endregion

--region 交互事件
---绑定交互事件
---@private
---@param isBindEvent boolean 是否需要绑定事件
function UIBagTypeGrid:BindInteractionEvents(isBindEvent)
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
function UIBagTypeGrid:OnGridClicked()
    if self:GetInteraction() then
        if self.mBagItemInfo and self.mItemTbl then
            self:GetInteraction():OnGridClicked(self, self.mBagItemInfo, self.mItemTbl)
        else
            self:GetInteraction():OnGridClicked(self, nil, nil)
        end
    end
end

---格子按住/释放事件
---@param isPressed boolean
function UIBagTypeGrid:OnGridPressed(isPressed)
    if self:GetInteraction() then
        if self.mBagItemInfo and self.mItemTbl then
            self:GetInteraction():OnGridPressed(self, self.mBagItemInfo, self.mItemTbl, isPressed, CSUICamera.currentTouch.pos)
        else
            self:GetInteraction():OnGridPressed(self, nil, nil, isPressed, CSUICamera.currentTouch.pos)
        end
    end
end

---格子开始被拖拽
function UIBagTypeGrid:OnStartBeingDragged()
    self.mIsBeingDragged = true
    ---拖拽开始
    if self.mBagItemInfo and self.mItemTbl and self:GetInteraction() then
        self:GetInteraction():OnGridStartBeingDragged(self, self.mBagItemInfo, self.mItemTbl, CSUICamera.currentTouch.pos)
    end
end

---格子被拖拽中
function UIBagTypeGrid:OnBeingDragged(delta)
    ---拖拽过程中不应考虑物品数据和物品表数据是否存在的情况,因为拖拽过程和结束拖拽是在不同帧进行的,不能认为两个行为执行时数据相同
    if self:GetInteraction() then
        self:GetInteraction():OnGridBeingDragged(self, self.mBagItemInfo, self.mItemTbl, CSUICamera.currentTouch.pos)
    end
end

---格子结束拖拽
function UIBagTypeGrid:OnEndBeingDragged(isDestroyed)
    self.mIsBeingDragged = false
    ---结束拖拽触发时不应考虑物品数据和物品表数据是否存在的情况,因为开始拖拽和结束拖拽是在不同帧进行的,不能认为两个行为执行时数据相同
    if self:GetInteraction() then
        self:GetInteraction():OnGridEndBeingDragged(self, self.mBagItemInfo, self.mItemTbl, isDestroyed == true)
    end
end
--endregion

--region 刷新
---执行格子刷新(使用前一次刷新时使用的背包物品数据)
---@public
function UIBagTypeGrid:Refresh()
    self:RefreshWithInfo(self.mBagItemInfo, self.mItemTbl, self.mIsLocked)
end

---刷新,若背包物品数据或表数据传入nil则表示传入空格子,若isLocked传入true则表示设置为被锁的格子
---@public
---@param bagItemInfo bagV2.BagItemInfo 背包物品数据
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表数据
---@param isLocked boolean 是否锁住了
function UIBagTypeGrid:RefreshWithInfo(bagItemInfo, itemTbl, isLocked)
    self.mIsRefreshing = true
    local isRemoveData = self.mBagItemInfo ~= nil and bagItemInfo == nil
    self.mBagItemInfo = bagItemInfo
    self.mItemTbl = itemTbl
    self.mIsLocked = isLocked
    self:BindInteractionEvents(bagItemInfo ~= nil and itemTbl ~= nil)
    if isLocked then
        self:Clear(true)
    else
        self:Clear(false)
        if self.mBagItemInfo and self.mItemTbl then
            self:RefreshSingleGrid(bagItemInfo, itemTbl)
        end
    end
    self:ApplyAllPropertyChanges()
    if isRemoveData and self.mIsBeingDragged then
        ---如果正在拖拽且数据被置空,则停止被拖拽事件
        self:OnEndBeingDragged(true)
    end
    self.mIsRefreshing = false
end

---应用所有属性的变化
---在lua层做一层对控件属性变化的缓冲,以减少lua和C#之间的交互次数
---@protected
function UIBagTypeGrid:ApplyAllPropertyChanges()
    if self.mComps then
        for i, v in pairs(self.mComps) do
            if v.isActive ~= v.realActiveState then
                v.realActiveState = v.isActive
                if CheckNullFunction(v.go) == false then
                    v.go:SetActive(v.realActiveState)
                end
            end
            if v.sprite then
                if v.spriteName ~= nil and v.spriteName ~= v.realSpriteName then
                    v.realSpriteName = v.spriteName
                    if CheckNullFunction(v.sprite) == false then
                        v.sprite.spriteName = v.realSpriteName ~= nil and v.realSpriteName or emptyStr
                        v.sprite:MakePixelPerfect()
                    end
                end
                if v.fillamount ~= nil and (v.realFillAmount == nil or (v.realFillAmount - v.fillamount < 0.0001)) then
                    v.realFillAmount = v.fillamount
                    if CheckNullFunction(v.sprite) == false then
                        v.sprite.fillAmount = v.fillamount
                    end
                end
            end
            if v.label then
                if v.labelContent ~= v.realLabelContent then
                    v.realLabelContent = v.labelContent
                    if CheckNullFunction(v.label) == false then
                        v.label.text = v.realLabelContent ~= nil and v.realLabelContent or emptyStr
                    end
                end
            end
            if (v.r ~= v.realR or v.g ~= v.realG or v.b ~= v.realB or v.a ~= v.realA) then
                v.realR = v.r
                v.realG = v.g
                v.realB = v.b
                v.realA = v.a
                if v.sprite and CheckNullFunction(v.sprite) == false then
                    v.sprite.color = CSColor(v.realR / 255, v.realG / 255, v.realB / 255, v.realA / 255)
                end
                if v.label and CheckNullFunction(v.label) == false then
                    v.label.color = CSColor(v.realR / 255, v.realG / 255, v.realB / 255, v.realA / 255)
                end
            end
            if v.componentEnabled ~= v.realComponentEnabled and (v.sprite ~= nil or v.label ~= nil) then
                v.realComponentEnabled = v.componentEnabled
                if v.sprite and CheckNullFunction(v.sprite) == false then
                    v.sprite.enabled = v.realComponentEnabled
                end
                if v.label and CheckNullFunction(v.label) == false then
                    v.label.enabled = v.realComponentEnabled
                end
            end
        end
    end
end

---播放抖动动画
---@protected
function UIBagTypeGrid:PlayShakeTween(compName)
    if self.shakeComponent == nil or CS.StaticUtility.IsNull(self.shakeComponent) == true then
        local comp = self:GetCompTbl(compName)
        self.shakeComponent = self:GetCurComp(comp.go, "", "Top_TweenShake")
    end
    if self.shakeComponent ~= nil then
        self.shakeComponent:PlayShake()
    end
end
--endregion

--region 清空
---清空,只保留背景(未锁格子)或背景+锁(锁住的格子)
---@overload fun()
---@protected
---@param isLocked boolean 是否锁住
function UIBagTypeGrid:Clear(isLocked)
    if isLocked == nil then
        isLocked = self.mIsLocked
    end
    if isLocked == nil then
        isLocked = false
    end
    if isLocked then
        for i, v in pairs(self.Components) do
            if v ~= self.Components.BackGround and v ~= self.Components.Lock then
                local tbl = self:GetCompTbl(v)
                if tbl then
                    self:SetCompActive(v, false)
                    if tbl.r ~= nil and tbl.realR ~= nil then
                        self:SetCompColor(v, 255, 255, 255, 255)
                    end
                end
            end
        end
        if self:IsTiledBG() == false then
            self:SetCompActive(self.Components.BackGround, true)
        end
        self:SetCompActive(self.Components.Lock, true)
    else
        for i, v in pairs(self.Components) do
            if v ~= self.Components.BackGround then
                local tbl = self:GetCompTbl(v)
                if tbl then
                    self:SetCompActive(v, false)
                    if tbl.r ~= nil and tbl.realR ~= nil then
                        self:SetCompColor(v, 255, 255, 255, 255)
                    end
                end
            end
        end
        if self:IsTiledBG() == false then
            self:SetCompActive(self.Components.BackGround, true)
        end
    end
end
--endregion

--region 读取/更改组件状态
---设置组件的显示隐藏
---@public
---@param compName string 组件名
---@param isActive boolean 组件的开关
function UIBagTypeGrid:SetCompActive(compName, isActive)
    local comp = self:GetCompTbl(compName)
    if comp then
        ---若组件列表中包含该物体,则设置该物体的开关.当组件为触发类型且需要设置组件为true时,先设置组件为false
        comp.isActive = (isActive == true)
        if comp.isActive and self:IsTriggleComponent(compName) then
            if CheckNullFunction(comp.go) == false then
                comp.realActiveState = false
                comp.go:SetActive(false)
            end
        end
        if self.mIsRefreshing == false then
            comp.realActiveState = comp.isActive
            if CheckNullFunction(comp.go) == false then
                comp.go:SetActive(comp.realActiveState)
            end
        end
    else
        ---若格子下的组件列表中没有该物体,则根据情况处理
        ---若需要设置开关为关,则不进行任何处理,因为该物体下面根本没有该组件;
        ---若需要设置开关为开,则拷贝一个物体到格子下,并开启该物体
        if isActive then
            comp = self:CopyComp(compName)
            if comp then
                comp.isActive = (isActive == true)
                if self.mIsRefreshing == false then
                    comp.realActiveState = comp.isActive
                    if CheckNullFunction(comp.go) == false then
                        comp.go:SetActive(comp.realActiveState)
                    end
                end
            end
        end
    end
end

---获取组件的显示隐藏状态
---@public
---@param compName string 组件名
function UIBagTypeGrid:GetCompActive(compName)
    local comp = self:GetCompTbl(compName)
    if comp then
        return comp.isActive
    end
    return false
end

---设置组件文本名
---@public
---@param compName string 组件名
---@param labelContent string 文本内容
function UIBagTypeGrid:SetCompLabelContent(compName, labelContent)
    if compName == nil then
        return
    end
    if labelContent == nil then
        labelContent = emptyStr
    end
    local labelTbl = self:GetCompTbl(compName, false)
    if labelTbl or (labelTbl == nil and labelContent ~= emptyStr) then
        if labelTbl == nil then
            labelTbl = self:GetCompTbl(compName, true)
        end
        if labelTbl and self:AttachCompToCompTbl(labelTbl, "label", "UILabel") then
            labelTbl.labelContent = labelContent
            if self.mIsRefreshing == false then
                labelTbl.realLabelContent = labelTbl.labelContent
                if CheckNullFunction(labelTbl.label) == false then
                    labelTbl.label.text = labelTbl.labelContent
                end
            end
            self:SetCompActive(compName, true)
        else
            if isOpenLog then
                luaDebug.LogError("设置组件文本失败 " .. compName .. "  " .. labelContent)
            end
        end
    end
end

---获取组件文本名
---@param compName string 组件名
---@return string
function UIBagTypeGrid:GetCompLabelContent(compName)
    local comp = self:GetCompTbl(compName)
    if comp then
        if comp.label then
            if comp.labelContent == nil then
                comp.realLabelContent = comp.label.text
                comp.labelContent = comp.realLabelContent
            end
            return comp.labelContent
        else
            return nil
        end
    end
    return nil
end

---设置组件图片名
---@public
---@param compName string 组件名
---@param spriteName string 图片名
function UIBagTypeGrid:SetCompSpriteName(compName, spriteName)
    if compName == nil then
        return
    end
    if spriteName == nil then
        spriteName = emptyStr
    end
    local spriteTbl = self:GetCompTbl(compName, false)
    if spriteTbl or (spriteTbl == nil and spriteName ~= emptyStr) then
        if spriteTbl == nil then
            spriteTbl = self:GetCompTbl(compName, true)
        end
        if spriteTbl and self:AttachCompToCompTbl(spriteTbl, "sprite", "UISprite") then
            self:SetCompEnabled(compName, spriteName ~= emptyStr)
            spriteTbl.spriteName = spriteName
            if self.mIsRefreshing == false then
                spriteTbl.realSpriteName = spriteTbl.spriteName
                if CheckNullFunction(spriteTbl.sprite) == false then
                    spriteTbl.sprite.spriteName = spriteName
                    spriteTbl.sprite:MakePixelPerfect()
                end
            end
            self:SetCompActive(compName, true)
        else
            if isOpenLog then
                luaDebug.LogError("设置组件图片失败 " .. compName .. "  " .. spriteName)
            end
        end
    end
end

---获取图标名
---@param compName string 组件名
---@return string
function UIBagTypeGrid:GetCompSpriteName(compName)
    local comp = self:GetCompTbl(compName)
    if comp then
        if comp.sprite then
            if comp.spriteName == nil then
                comp.realSpriteName = comp.sprite.spriteName
                comp.spriteName = comp.realSpriteName
            end
            return comp.spriteName
        else
            return nil
        end
    end
    return nil
end

---设置组件图片的百分比
---@public
---@param compName string 组件名
---@param fillAmount number 百分比
function UIBagTypeGrid:SetCompSpriteFillAmount(compName, fillAmount)
    if compName == nil or fillAmount == nil then
        return
    end
    local spriteTbl = self:GetCompTbl(compName, true)
    if spriteTbl and self:AttachCompToCompTbl(spriteTbl, "sprite", "UISprite") then
        spriteTbl.fillamount = fillAmount
        if self.mIsRefreshing == false then
            spriteTbl.realFillAmount = fillAmount
            if CheckNullFunction(spriteTbl.sprite) == false then
                spriteTbl.sprite.fillAmount = spriteTbl.realFillAmount
            end
        end
        self:SetCompActive(compName, true)
    end
end

---设置组件的启用状态,不负责拷贝组件
---@private
---@param compName string 组件名
---@param isEnabled boolean 组件是否要设置启用
function UIBagTypeGrid:SetCompEnabled(compName, isEnabled)
    local tbl = self:GetCompTbl(compName, false)
    tbl.componentEnabled = isEnabled
    if self.mIsRefreshing == false and (tbl.sprite ~= nil or tbl.label ~= nil) then
        if tbl.componentEnabled ~= tbl.realComponentEnabled then
            tbl.realComponentEnabled = tbl.componentEnabled
            if tbl.sprite then
                tbl.sprite.enabled = tbl.realComponentEnabled
            end
            if tbl.label then
                tbl.label.enabled = tbl.realComponentEnabled
            end
        end
    end
end

---设置组件颜色,仅负责设置颜色,不负责创建组件
---@param compName string 组件名
---@param r number 颜色R分量,nil则忽视,范围0~255
---@param g number 颜色G分量,nil则忽视,范围0~255
---@param b number 颜色B分量,nil则忽视,范围0~255
---@param a number 颜色A分量,nil则忽视,范围0~255
function UIBagTypeGrid:SetCompColor(compName, r, g, b, a)
    if compName == nil then
        return
    end
    local tbl = self:GetCompTbl(compName, false)
    if tbl then
        if tbl.sprite == nil or tbl.label == nil then
            if self:AttachCompToCompTbl(tbl, "sprite", "UISprite") == false then
                self:AttachCompToCompTbl(tbl, "label", "UILabel")
            end
        end
        if r then
            tbl.r = math.clamp(r, 0, 255)
        end
        if g then
            tbl.g = math.clamp(g, 0, 255)
        end
        if b then
            tbl.b = math.clamp(b, 0, 255)
        end
        if a then
            tbl.a = math.clamp(a, 0, 255)
        end
        if self.mIsRefreshing == false and (tbl.r ~= tbl.realR or tbl.g ~= tbl.realB or tbl.b ~= tbl.realB or tbl.a ~= tbl.realA) then
            if tbl.r == nil then
                tbl.r = 255
            end
            if tbl.g == nil then
                tbl.g = 255
            end
            if tbl.b == nil then
                tbl.b = 255
            end
            if tbl.a == nil then
                tbl.a = 255
            end
            tbl.realR = tbl.r
            tbl.realG = tbl.g
            tbl.realB = tbl.b
            tbl.realA = tbl.a
            if tbl.sprite then
                tbl.sprite.color = CSColor(tbl.realR, tbl.realG, tbl.realB, tbl.realA)
            end
            if tbl.label then
                tbl.label.color = CSColor(tbl.realR, tbl.realG, tbl.realB, tbl.realA)
            end
        end
    end
end

---获取组件颜色
---@return number r
---@return number g
---@return number b
---@return number a
function UIBagTypeGrid:GetCompColor(compName)
    local tbl = self:GetCompTbl(compName, false)
    if tbl then
        return tbl.r, tbl.g, tbl.b, tbl.a
    end
    return nil
end
--endregion

--region 组件物体拷贝/获取组件
---将组件附到组件表上
---@private
---@param compTbl GridComponentData
---@param keyName string
---@param componentName string
---@return boolean 是否附着成功
function UIBagTypeGrid:AttachCompToCompTbl(compTbl, keyName, componentName)
    if compTbl and keyName and componentName then
        if compTbl[keyName] ~= nil then
            return true
        end
        if CheckNullFunction(compTbl.go) == false then
            local comp = self:GetCurComp(compTbl.go, emptyStr, componentName)
            if CheckNullFunction(comp) == false then
                compTbl[keyName] = comp
                ---若之前设置了颜色,则将颜色应用到组件上
                local color = comp.color
                local colorRf = color.r
                local colorGf = color.g
                local colorBf = color.b
                local colorAf = color.a
                if color and colorRf ~= nil and colorGf ~= nil and colorBf ~= nil and colorAf ~= nil then
                    if compTbl.r == nil then
                        compTbl.realR = math.clamp(math.floor(colorRf * 255), 0, 255)
                        compTbl.r = compTbl.realR
                    end
                    if compTbl.g == nil then
                        compTbl.realG = math.clamp(math.floor(colorGf * 255), 0, 255)
                        compTbl.g = compTbl.realG
                    end
                    if compTbl.b == nil then
                        compTbl.realB = math.clamp(math.floor(colorBf * 255), 0, 255)
                        compTbl.b = compTbl.realB
                    end
                    if compTbl.a == nil then
                        compTbl.realA = math.clamp(math.floor(colorAf * 255), 0, 255)
                        compTbl.a = compTbl.realA
                    end
                end
                ---若之前设置了enabled属性,则将enabled属性应用到组件上
                if compTbl.realComponentEnabled ~= nil then
                    compTbl.componentEnabled = compTbl.realComponentEnabled
                    compTbl.enabled = compTbl.componentEnabled
                end
                return true
            end
        end
    end
    return false
end

---获取组件
---@private
---@overload fun(compName:string)
---@param compName string 组件名
---@param isCreateNewWhenEmpty boolean 是否创建新组件,默认不创建新组件
---@return GridComponentData
function UIBagTypeGrid:GetCompTbl(compName, isCreateNewWhenEmpty)
    if isCreateNewWhenEmpty ~= true and (compName == nil or self.mComps == nil) then
        return nil
    end
    if self.mComps == nil then
        self.mComps = {}
    end
    if isCreateNewWhenEmpty then
        local dataTemp = self.mComps[compName]
        if dataTemp == nil then
            dataTemp = self:CopyComp(compName)
            if dataTemp and CheckNullFunction(dataTemp.go) == false then
                dataTemp.go:SetActive(true)
            end
            return dataTemp
        else
            return dataTemp
        end
    else
        return self.mComps[compName]
    end
    return nil
end

---复制一个组件物体
---@private
---@param compName string
---@return GridComponentData
function UIBagTypeGrid:CopyComp(compName)
    if self.mComps == nil then
        self.mComps = {}
    end
    if self.mComps[compName] == nil and CheckNullFunction(self.go) == false and self:GetFetchPrefabFunction() ~= nil then
        local prefabGO = self:GetFetchPrefabFunction()(compName)
        if prefabGO ~= nil then
            local compGO = CSUtility_Lua.CopyGO(prefabGO, self.go.transform)
            if CheckNullFunction(compGO) == false then
                local trans = compGO.transform
                local pTrans = prefabGO.transform
                trans.localPosition = pTrans.localPosition
                trans.localScale = pTrans.localScale
                trans.localRotation = pTrans.localRotation
                ---@type GridComponentData
                local tbl = { go = compGO, isActive = compGO.activeSelf, realActiveState = compGO.activeSelf }
                self.mComps[compName] = tbl
                return tbl
            end
        end
    end
    return nil
end
--endregion

return UIBagTypeGrid