---主场景提示基类
---@class UIBasicHint:TemplateBase
local UIBasicHint = {}

---初始化
---@protected
---@param clientMsgHandler EventHandlerManager
---@param panel UIMainHintPanel
function UIBasicHint:Init(clientMsgHandler, panel)
    self.mClientMsgHandler = clientMsgHandler
    self.mMainHintPanel = panel
    self:ResetColliders()
    self:ResetTweenComponents()
    self:RegisterAllComponents()
    self:BindMessages()
    self:BindUIEvents()
    if self.mTweenComponents then
        local longestDurationTweener
        local duration = 0
        for i, v in pairs(self.mTweenComponents) do
            if v.duration > duration then
                duration = v.duration
                longestDurationTweener = v
            end
            break
        end
        if longestDurationTweener ~= nil then
            longestDurationTweener:AddOnFinished(function()
                if CS.UITweener.current ~= nil then
                    if CS.UITweener.current.tweenFactor == 0 then
                        self.mIsClosingAnimation = false
                        self.go:SetActive(false)
                        self:OnCloseFinished(true)
                    elseif CS.UITweener.current.tweenFactor == 1 then
                        self:OnOpenFinished()
                    end
                end
            end)
        end
    end
end

---获取客户端消息绑定器
---@return EventHandlerManager
function UIBasicHint:GetClientMessageHandlerManager()
    return self.mClientMsgHandler
end

---设置提示是否开启
---@protected
---@param isOn boolean
function UIBasicHint:SetIsOn(isOn)
    self.isOn = isOn
end

---获取提示是否开启
---@public
---@return boolean
function UIBasicHint:GetIsOn()
    return self.isOn == true
end

---正在播放关闭动画
---@return boolean
function UIBasicHint:GetIsPlayingCloseAnimation()
    return self.mIsClosingAnimation == true
end

---设置提示的位置
---@public
---@param localPosition UnityEngine.Vector3
function UIBasicHint:SetPosition(localPosition)
    if self.go then
        localPosition.x = math.ceil(localPosition.x)
        localPosition.y = math.ceil(localPosition.y)
        self.mTargetPosition = localPosition
        self.mIsBindInGameObject = false
        self:RefreshPosition()
    end
end

---设置绑定的物体
---@public
---@param go UnityEngine.GameObject
function UIBasicHint:SetBindedGameObject(go)
    if self.go then
        self.mBindedGameObject = go
        self.mIsBindInGameObject = true
        self:RefreshPosition()
    end
end

---刷新位置
---@public
function UIBasicHint:RefreshPosition()
    if self.go and CS.StaticUtility.IsNull(self.go) == false then
        if self.mIsBindInGameObject == false then
            if self.mTargetPosition then
                self.go.transform.localPosition = self.mTargetPosition
            end
        else
            if self.mBindedGameObject or CS.StaticUtility.IsNull(self.mBindedGameObject) == false then
                self.go.transform.position = self.mBindedGameObject.transform.position
            else
                self.mBindedGameObject = nil
            end
        end
    end
end

---触发
---@public
function UIBasicHint:Triggle()
    self:SetIsOn(true)
    self.go:SetActive(true)
    self:PlayOpenAnimation()
end

---关闭
---@public
---@param withAnimation boolean 是否伴随着动画关闭
function UIBasicHint:Close(withAnimation)
    if withAnimation then
        self.mIsClosingAnimation = true
        self:PlayCloseAnimation()
    else
        self:ResetToClosenState()
    end
    self:ReleaseData()
    self:SetIsOn(false)
    if withAnimation ~= true and self:GetIsPlayingCloseAnimation() then
        self.mIsClosingAnimation = false
        self:OnCloseFinished(false)
    end
end

---注册碰撞体
---@private
function UIBasicHint:ResetColliders()
    ---提示里面的碰撞体
    ---@protected
    ---@type table<number,UnityEngine.Collider>
    self.mColliders = {}
end

---注册单个碰撞体,物体上的所有碰撞体在关闭状态下会全部关闭,开启状态下全部开启
---@protected
---@param colliderPath string
function UIBasicHint:RegisterSingleCollider(colliderPath)
    ---@type UnityEngine.GameObject
    local go = self:Get(colliderPath, "GameObject")
    local colliders = go:GetComponents(typeof(CS.UnityEngine.Collider))
    if colliders then
        for i = 0, colliders.Length - 1 do
            local collider = colliders[i]
            if collider and CS.StaticUtility.IsNull(collider) == false then
                if Utility.IsContainsValue(self.mColliders, collider) == false then
                    table.insert(self.mColliders, collider)
                end
            end
        end
    end
end

---注册动画组件
---@private
function UIBasicHint:ResetTweenComponents()
    ---提示里面的变换组件
    ---@protected
    ---@type table<number,UITweener>
    self.mTweenComponents = {}
end

---注册单个动画组件,物体上的所有Tween组件在执行开启动画时会执行PlayForward方法,执行关闭动画时会执行PlayReverse方法
---@protected
---@param tweenComponentPath string
function UIBasicHint:RegisterSingleTweenComponent(tweenComponentPath)
    ---@type UnityEngine.GameObject
    local go = self:Get(tweenComponentPath, "GameObject")
    local tweens = go:GetComponents(typeof(CS.UITweener))
    if tweens then
        for i = 0, tweens.Length - 1 do
            local tweenComponent = tweens[i]
            if tweenComponent and CS.StaticUtility.IsNull(tweenComponent) == false then
                if Utility.IsContainsValue(self.mTweenComponents, tweenComponent) == false then
                    table.insert(self.mTweenComponents, tweenComponent)
                end
            end
        end
    end
end

---播放打开动画
---@protected
function UIBasicHint:PlayOpenAnimation()
    self:ChangeColliderState(true)
    if self.mTweenComponents then
        for i, c in pairs(self.mTweenComponents) do
            if c and CS.StaticUtility.IsNull(c) == false then
                c:PlayForward()
            end
        end
    end
end

---播放关闭动画
---@protected
function UIBasicHint:PlayCloseAnimation()
    self:ChangeColliderState(false)
    if self.mTweenComponents then
        for i, c in pairs(self.mTweenComponents) do
            if c and CS.StaticUtility.IsNull(c) == false then
                c:PlayReverse()
            end
        end
    end
end

---重置到关闭状态
---@protected
function UIBasicHint:ResetToClosenState()
    self:ChangeColliderState(false)
    if self.mTweenComponents then
        for i, c in pairs(self.mTweenComponents) do
            if c and CS.StaticUtility.IsNull(c) == false then
                c:PlayForward()
                c:ResetToBeginning()
                c.enabled = false
            end
        end
    end
    if CS.StaticUtility.IsNull(self.go) == false then
        self.go:SetActive(false)
    end
end

---切换碰撞体的状态
---@protected
---@param isColliderOn boolean 是否开启碰撞体
function UIBasicHint:ChangeColliderState(isColliderOn)
    if self.mColliders then
        for i, c in pairs(self.mColliders) do
            if c and CS.StaticUtility.IsNull(c) == false then
                c.enabled = isColliderOn
            end
        end
    end
end

--[[******************************************* 待子类重写 *******************************************]]
---刷新数据,真正的刷新界面写在这里
---@public
---@vararg any
function UIBasicHint:RefreshData(...)

end

---释放数据
---@protected
function UIBasicHint:ReleaseData()

end

---注册所有组件,包括Collider组件和TweenComponents组件,使用RegisterSingleCollider和RegisterSingleTweenComponent方法
---@protected
function UIBasicHint:RegisterAllComponents()

end

---绑定消息
---@protected
function UIBasicHint:BindMessages()

end

---绑定UI事件
---@protected
function UIBasicHint:BindUIEvents()

end

---开启动画播放完毕
---@protected
function UIBasicHint:OnOpenFinished()

end

---关闭动画播放完毕
---@param withAnimation boolean 是否播放了关闭动画
---@protected
function UIBasicHint:OnCloseFinished(withAnimation)

end

---重新显示
---@public
---@return boolean 表示是否允许重新显示,若返回false,则直接
function UIBasicHint:OnReshown()
    return self:GetIsOn()
end

return UIBasicHint