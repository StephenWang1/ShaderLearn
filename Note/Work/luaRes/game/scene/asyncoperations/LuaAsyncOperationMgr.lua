---Lua异步操作管理类
---@class LuaAsyncOperationMgr:luaobject
local LuaAsyncOperationMgr = {}

---Lua操作类型
---@class LuaAsyncOperationType
LuaAsyncOperationType = {
    ---示例
    Example = 1,
    ---前往地图某点开启自动战斗
    GoMapPosAndAutoFight = 2,
    ---行会复仇追踪
    UnionRevenge = 3,
}

---注册所有相关的操作
---@private
function LuaAsyncOperationMgr:RegisterAllRelatedOperations()
    ---@type table<LuaAsyncOperationType,LuaAsyncOperationBase>
    self.mOperationTypes = {}
    self.mOperationTypes[LuaAsyncOperationType.Example] = luaclass.LuaAsyncOperation_Example
    self.mOperationTypes[LuaAsyncOperationType.GoMapPosAndAutoFight] = luaclass.LuaAsyncOperation_GoMapAndAutoFight
    self.mOperationTypes[LuaAsyncOperationType.UnionRevenge] = luaclass.LuaAsyncOperation_UnionRevenge
end

---转换结束码至int
---@type function
local mTransferFinishCodeEnumToIntFunction = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt

---是否开启
---@private
LuaAsyncOperationMgr.mIsOn = false
---是否有操作正在执行
---@return boolean
function LuaAsyncOperationMgr:GetIsOn()
    return self.mIsOn == true
end

---获取Lua中的工具类
---@return LuaAsyncOperationUtility
function LuaAsyncOperationMgr:GetLuaUtility()
    if self.mLuaUtility == nil then
        self.mLuaUtility = luaclass.LuaAsyncOperationUtility:New()
    end
    return self.mLuaUtility
end

---获取C#中的工具类
---@return MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil
function LuaAsyncOperationMgr:GetCSharpUtility()
    if self.mCSharpUtility == nil then
        self.mCSharpUtility = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil
    end
    return self.mCSharpUtility
end

---根据异步操作类型获取一个异步操作对象或者nil
---@private
---@param operationType LuaAsyncOperationType
---@return LuaAsyncOperationBase|nil
function LuaAsyncOperationMgr:GetLuaAsyncOperationByAsyncOperationName(operationType)
    if operationType == nil then
        return nil
    end
    if self.mAllOperations == nil then
        ---@type table<LuaAsyncOperationType,LuaAsyncOperationBase>
        self.mAllOperations = {}
    end
    local tbl = self.mAllOperations[operationType]
    if tbl ~= nil then
        return tbl
    else
        local classTbl = self.mOperationTypes[operationType]
        if classTbl then
            tbl = classTbl:New(self)
            tbl.mAsyncOperationType = operationType
            self.mAllOperations[operationType] = tbl
            return tbl
        else
            return nil
        end
    end
end

---获取当前的异步操作
---@return LuaAsyncOperationBase|nil
function LuaAsyncOperationMgr:GetCurrentLuaAsyncOperation()
    return self.mCurrentLuaAsyncOperation
end

---获取C#中的Lua异步操作
---@private
---@return LuaAsyncOperations
function LuaAsyncOperationMgr:GetCSLuaAsyncOperation()
    if self.mCSLuaAsyncOperation == nil then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.LuaAsyncOperation ~= nil then
            self.mCSLuaAsyncOperation = CS.CSScene.MainPlayerInfo.AsyncOperationController.LuaAsyncOperation
        end
    end
    return self.mCSLuaAsyncOperation
end

---初始化
---@private
function LuaAsyncOperationMgr:Init()
    self:RegisterAllRelatedOperations()
    ---将自身注册到C#中的异步操作类中
    self:GetCSLuaAsyncOperation():InitializeLuaOperationTable(self)
end

---开始Lua的异步操作
---@public
---@param luaOperationType LuaAsyncOperationType Lua异步操作类型
---@vararg any 输入参数
---@return boolean 是否开启成功
function LuaAsyncOperationMgr:TryStartOperation(luaOperationType, ...)
    if self:GetCSLuaAsyncOperation() == nil then
        return
    end
    self.mIsStartInLua = true
    self.mOperationCache = { ... }
    local res = self:GetCSLuaAsyncOperation():DoLuaOperation(luaOperationType)
    self.mIsStartInLua = false
    self.mOperationCache = nil
    return mTransferFinishCodeEnumToIntFunction(res) >= 0
end

---Lua异步操作需要执行的方法
---@private
---@param luaOperationType LuaAsyncOperationType Lua异步操作类型
---@return boolean 是否开启完毕
function LuaAsyncOperationMgr:TryStartOperationInternal(luaOperationType, parameters)
    local luaAsyncOperationBase = self:GetLuaAsyncOperationByAsyncOperationName(luaOperationType)
    if luaAsyncOperationBase then
        self.mCurrentLuaAsyncOperation = luaAsyncOperationBase
        local paramTbl
        if self.mIsStartInLua then
            paramTbl = self.mOperationCache
        else
            if parameters ~= nil then
                paramTbl = {}
                for i = 0, parameters.Length - 1 do
                    table.insert(paramTbl, parameters[i])
                end
            end
        end
        local res
        if paramTbl then
            res = luaAsyncOperationBase:TryStartOperation(table.unpack(paramTbl))
        else
            res = luaAsyncOperationBase:TryStartOperation()
        end
        if res == false then
            self.mCurrentLuaAsyncOperation = nil
        end
        return res
    else
        return false
    end
end

---停下当前的操作
---@public
function LuaAsyncOperationMgr:StopCurrentOperation()
    if self.mIsOn and self:GetCSLuaAsyncOperation() ~= nil then
        self:GetCSLuaAsyncOperation():StopOperation()
    end
end

--region C#事件回调
---C#中的LuaAsyncOperation在IsOn状态下每帧都执行
---@private
function LuaAsyncOperationMgr:OnUpdate()
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnUpdate()
    end
end

---寻路状态变化事件
---@private
---@param currentPathFindState boolean 当前的寻路状态
---@param sourceSystemType number 寻路源系统类型
---@param pathFindType number 寻路类型
function LuaAsyncOperationMgr:OnAutoPathFindStateChanged(currentPathFindState, sourceSystemType, pathFindType)
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnAutoPathFindStateChanged(currentPathFindState, sourceSystemType, pathFindType)
    end
end

---主角位置突变事件
---@private
---@param positionChangeReason number 位置变化原因
---@param x number x坐标
---@param y number y坐标
---@param isChangeMap boolean 是否切换了地图
function LuaAsyncOperationMgr:OnMainPlayerPositionSuddenlyChanged(positionChangeReason, x, y, isChangeMap)
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnMainPlayerPositionSuddenlyChanged(positionChangeReason, x, y, isChangeMap)
    end
end

---继续
---@private
---@param resumeReason number 继续原因
function LuaAsyncOperationMgr:OnResume(resumeReason)
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnResume(resumeReason)
    end
end

---中断
---@private
---@param suspendReason number 中断原因
function LuaAsyncOperationMgr:OnSuspend(suspendReason)
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnSuspend(suspendReason)
    end
end

---场景变化事件
---@private
function LuaAsyncOperationMgr:OnSceneChangedAction()
    if self:GetCurrentLuaAsyncOperation() ~= nil then
        self:GetCurrentLuaAsyncOperation():OnSceneChangedAction()
    end
end

---操作使能开启
---@private
function LuaAsyncOperationMgr:OnEnable()
    self.mIsOn = true
    if self.mCurrentLuaAsyncOperation ~= nil then
        self.mCurrentLuaAsyncOperation.mIsOn = true
        self.mCurrentLuaAsyncOperation:OnEnable()
    end
end

---操作使能关闭
---@private
function LuaAsyncOperationMgr:OnDisable()
    self.mIsOn = false
    if self.mCurrentLuaAsyncOperation ~= nil then
        local temp = self.mCurrentLuaAsyncOperation
        self.mCurrentLuaAsyncOperation = nil
        temp.mIsOn = false
        temp:OnDisable()
    end
end
--endregion

---销毁
---@private
function LuaAsyncOperationMgr:OnDestroy()
    if self.mCurrentLuaAsyncOperation ~= nil then
        ---关闭当前操作
        self.mCurrentLuaAsyncOperation.mIsOn = false
        self.mCurrentLuaAsyncOperation:OnDisable()
        self.mCurrentLuaAsyncOperation = nil
    end
    if self.mAllOperations then
        ---销毁所有的操作
        for i, v in pairs(self.mAllOperations) do
            v:OnDestroy()
            v.mAsyncOperationMgr = nil
        end
        self.mAllOperations = nil
    end
    self.mCSLuaAsyncOperation = nil
end

return LuaAsyncOperationMgr