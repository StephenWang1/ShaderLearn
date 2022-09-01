---一个Lua异步操作示例
---@class LuaAsyncOperation_Example:LuaAsyncOperationBase
local LuaAsyncOperation_Example = {}

setmetatable(LuaAsyncOperation_Example, luaclass.LuaAsyncOperationBase)

function LuaAsyncOperation_Example:TryStartOperation(...)
    --此处根据输入条件和当前条件决定是否开启了异步操作以及开始操作时执行的步骤
    --print("TryStartOperation")
    return true
end

function LuaAsyncOperation_Example:OnEnable()
    --此处执行开始异步操作的处理
    --print("OnEnable")
end

function LuaAsyncOperation_Example:OnUpdate()
    --此处执行每帧执行的处理
    --print("OnUpdate")
end

function LuaAsyncOperation_Example:OnDisable()
    --此处执行结束异步操作时的处理
    --print("OnDisable")
end

return LuaAsyncOperation_Example