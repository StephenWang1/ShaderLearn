---Lua采集信息
---@class LuaGatherInfo:luaobject
local LuaGatherInfo = {}

function LuaGatherInfo:Init()
    --CS.CSGatherController.gatherExtraJudgment = function(avatar, gatherTbl)
    --    return self:GatherExtraJudgment(avatar, gatherTbl)
    --end
end

-----采集额外的判断
-----@private
-----@param avatar CSAvater
-----@param gatherTbl TABLE.CFG_GATHER
-----@return boolean 是否可以采集
--function LuaGatherInfo:GatherExtraJudgment(avatar, gatherTbl)
--    if avatar and gatherTbl then
--        if gatherTbl.gatherType == 2 then
--            ---boss尸体挖掘,如果是魔之Boss且当前魔之Boss的讨伐次数为0,则不可挖掘
--            local killNum = luaclass.MagicBossDataInfo.killNum
--            if killNum then
--                return killNum > 0
--            end
--        end
--        return true
--    end
--    return false
--end

--region 驯马信息
---@param tblData roleV2.ResRoleTame
function LuaGatherInfo:SaveTrainingHorseTime(tblData)
    self.mTrainingInfo = tblData
    luaEventManager.DoCallback(LuaCEvent.TrainingHorseTimeChange)
end

---@return roleV2.ResRoleTame 获取驯马数据
function LuaGatherInfo:GetTrainingHorseInfo()
    return self.mTrainingInfo
end
--endregion

function LuaGatherInfo:OnDestroy()
    --CS.CSGatherController.gatherExtraJudgment = nil
end

return LuaGatherInfo