---@class ConfigDartCar:luaobject 配置的飙车数据类
local ConfigDartCar = {}

--region 数据
---@type boolean 解析状态
ConfigDartCar.analysisState = nil
---@type TABLE.cfg_yabiao 押镖表
ConfigDartCar.YaBiaoConfigTbl = nil
---@type TABLE.cfg_bairimen_activity 白日门活动表
ConfigDartCar.BaiRiMenActivityTbl = nil
---@type TABLE.cfg_monsters 怪物表
ConfigDartCar.MonsterTbl = nil
--endregion

--region 解析数据
---解析配置的镖车数据
---@param id number 押镖表id
function ConfigDartCar:AnalysisConfigDartCarData(id)
    self.YaBiaoConfigTbl = clientTableManager.cfg_yabiaoManager:TryGetValue(id)
    if self.YaBiaoConfigTbl == nil then
        self.analysisState = false
        return
    end
    self.BaiRiMenActivityTbl = clientTableManager.cfg_bairimen_activityManager:TryGetValue(self.YaBiaoConfigTbl:GetBairimenId())
    self.MonsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(self.YaBiaoConfigTbl:GetMid())
end
--endregion

--region 查询
---查询数据解析状态
---@return boolean
function ConfigDartCar:CheckAnalysisState()
    return self.analysisState
end

---查询主角是否可以购买镖车
---@return boolean 是否可以购买镖车
function ConfigDartCar:CheckMainPlayerCanBuyDartCar()
    local costList = clientTableManager.cfg_yabiaoManager:GetBaiRiMenCostList(self.YaBiaoConfigTbl:GetId())
    if costList == nil or Utility.GetLuaTableCount(costList) <= 0 then
        return true
    end
    for k,v in pairs(costList) do
        if v ~= nil and v.itemId ~= nil and v.count ~= nil then
            local bagItemCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(v.itemId)
            if bagItemCount < v.count then
                return false
            end
        end
    end
    return true
end
--endregion

--region 获取
---获取白日门镖车信息
---@return TABLE.cfg_bairimen_activity
function ConfigDartCar:GetBaiRiMenTbl()
    return self.BaiRiMenActivityTbl
end

---获取押镖表信息
---@return TABLE.cfg_yabiao
function ConfigDartCar:GetYaBiaoConfTbl()
    return self.YaBiaoConfigTbl
end
--endregion

return ConfigDartCar