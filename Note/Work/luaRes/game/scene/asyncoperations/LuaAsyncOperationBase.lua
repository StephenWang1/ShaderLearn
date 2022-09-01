---Lua异步操作基类
---@class LuaAsyncOperationBase:luaobject
local LuaAsyncOperationBase = {}

---操作是否已开启
---@type boolean
LuaAsyncOperationBase.mIsOn = false

---返回Lua异步操作管理器
---@return LuaAsyncOperationMgr
function LuaAsyncOperationBase:GetOwner()
    return self.mAsyncOperationMgr
end

---当前操作是否开启
---@return boolean
function LuaAsyncOperationBase:GetIsOn()
    return self.mIsOn == true
end

---获取异步操作类型
---@return LuaAsyncOperationType
function LuaAsyncOperationBase:GetAsyncOperationType()
    return self.mAsyncOperationType
end

---初始化,整个角色生命周期内只调用一次
---@param asyncOperationMgr LuaAsyncOperationMgr Lua异步操作管理器
function LuaAsyncOperationBase:Init(asyncOperationMgr)
    self.mAsyncOperationMgr = asyncOperationMgr
    self:OnInit()
end

---停下当前操作
---@protected
function LuaAsyncOperationBase:Stop()
    if self:GetIsOn() and self:GetOwner():GetCurrentLuaAsyncOperation() == self then
        self:GetOwner():StopCurrentOperation()
    end
end

--[[**********************************可重写方法*******************************************]]
---初始化,整个角色生命周期内只调用一次
---@protected
function LuaAsyncOperationBase:OnInit()

end

---尝试开始操作,若方法返回true则表明执行成功
---@protected
---@vararg any
---@return boolean
function LuaAsyncOperationBase:TryStartOperation(...)
    return true
end

---启用事件
---@protected
function LuaAsyncOperationBase:OnEnable()

end

---禁用事件
---@protected
function LuaAsyncOperationBase:OnDisable()

end

---C#中的LuaAsyncOperation在IsOn状态下每帧都执行
---@protected
function LuaAsyncOperationBase:OnUpdate()

end

---寻路状态变化事件
---@protected
---@param currentPathFindState boolean 当前的寻路状态
---@param sourceSystemType number 寻路源系统类型
---@param pathFindType number 寻路类型
function LuaAsyncOperationBase:OnAutoPathFindStateChanged(currentPathFindState, sourceSystemType, pathFindType)

end

---主角位置突变事件
---@protected
---@param positionChangeReason number 位置变化原因
---@param x number x坐标
---@param y number y坐标
---@param isChangeMap boolean 是否切换了地图
function LuaAsyncOperationBase:OnMainPlayerPositionSuddenlyChanged(positionChangeReason, x, y, isChangeMap)

end

---场景变化事件
---@protected
function LuaAsyncOperationBase:OnSceneChangedAction()

end

---销毁事件
---@protected
function LuaAsyncOperationBase:OnDestroy()

end

return LuaAsyncOperationBase