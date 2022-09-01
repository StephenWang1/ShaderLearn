---@class OperationDartCar:luaobject 正在运行的镖车数据类
local OperationDartCar = {}

--region 数据
---@type number 唯一id
OperationDartCar.Lid = nil
---@type boolean 解析状态
OperationDartCar.AnalysisState = false
---@tyoe LuaEnumDartCarState 镖车状态
OperationDartCar.DartCarState = nil
---@type LuaEnumPersonCarEndType 结束状态
OperationDartCar.EndType = nil
---@type ConfigDartCar 镖车配置类
OperationDartCar.ConfigDartCarClass = nil
---@type number 镖车当前血量
OperationDartCar.Hp = nil
---@type table 镖车位置数据
OperationDartCar.Position = nil
--endregion

--region 解析数据
---刷新正在运行的镖车数据
---@param tblData cartV2.ResFreightCarInfo lua table类型消息数据
function OperationDartCar:RefreshOperationDartCarData(tblData)
    if tblData == nil or tblData.carConfigId == nil then
        return
    end
    self.lid = tblData.lid
    self.ConfigDartCarClass = luaclass.ConfigDartCar:New()
    self.ConfigDartCarClass:AnalysisConfigDartCarData(tblData.yabiaoId)
    self.AnalysisState = true
    self.Hp = tblData.hp
    if self.Position == nil then
        self.Position = {}
    end
    self.Position.mapId = tblData.mapId
    self.Position.x = tblData.x
    self.Position.y = tblData.y
    self.Position.line = tblData.line
    luaEventManager.DoCallback(LuaCEvent.BaiRiMenDartCarDataChange, {dataChangeType = LuaEnumBaiRiMenDartCarDataChangeType.All,operationDartCar = self})
end

---刷新正在运行的镖车位置
---@param tblData cartV2.ResFreightCarPointChange lua table类型消息数据
function OperationDartCar:RefreshOperationPosition(tblData)
    if tblData == nil or tblData.lid == nil then
        return
    end
    self.Position = tblData
    luaEventManager.DoCallback(LuaCEvent.BaiRiMenDartCarDataChange, {dataChangeType = LuaEnumBaiRiMenDartCarDataChangeType.Position,operationDartCar = self})
end

---刷新正在运行的镖车血量
---@param tblData cartV2.ResFreightCarHpChange lua table类型消息数据
function OperationDartCar:RefreshOperationDartCarHp(tblData)
    if tblData == nil or tblData.lid == nil then
        return
    end
    self.Hp = tblData.hp
    luaEventManager.DoCallback(LuaCEvent.BaiRiMenDartCarDataChange, {dataChangeType = LuaEnumBaiRiMenDartCarDataChangeType.Hp,operationDartCar = self})
end
--endregion

--region 查询
---镖车是否正在运行
---@return boolean 是否正在运行
function OperationDartCar:DartCarIsOperation()
    return self.Hp ~= nil and self.Hp > 0 and self.AnalysisState ~= false
end

---是否是同配置id的镖车
---@param yaBiaoId number
---@return boolean 是否是同配置id
function OperationDartCar:IsSameConfigDartCar(yaBiaoId)
    if self.ConfigDartCarClass == nil or self.ConfigDartCarClass.YaBiaoConfigTbl == nil then
        return false
    end
    return self.ConfigDartCarClass.YaBiaoConfigTbl:GetId() == yaBiaoId
end
--endregion

--region 获取
---获取镖车名字
---@return string 镖车名字
function OperationDartCar:GetDartCarName()
    if self.ConfigDartCarClass ~= nil and self.ConfigDartCarClass.YaBiaoConfigTbl ~= nil then
        return self.ConfigDartCarClass.YaBiaoConfigTbl:GetName()
    end
end

---获取镖车当前血量
---@return number hp
function OperationDartCar:GetDartCarNowHp()
    return self.Hp
end

---获取镖车满血血量
function OperationDartCar:GetDartCarMaxHp()
    if self.ConfigDartCarClass ~= nil and self.ConfigDartCarClass.MonsterTbl ~= nil then
        return self.ConfigDartCarClass.MonsterTbl:GetMaxHp()
    end
    return 0
end

---获取镖车当前状态
---@return LuaEnumDartCarState 镖车状态
function OperationDartCar:GetDartCarState()
    return self.DartCarState
end

---获取镖车结束状态
---@return LuaEnumPersonCarEndType 镖车结束状态
function OperationDartCar:GetDartCarEndState()
    return self.LuaEnumPersonCarEndType
end

---获取镖车配置的数据类
---@return ConfigDartCar
function OperationDartCar:GetConfigDartCarClass()
    return self.ConfigDartCarClass
end
--endregion
return OperationDartCar