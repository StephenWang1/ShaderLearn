---
--- Created by Olivier.
--- DateTime: 2021/2/26 13:43
--- 灵魂任务数据处理

local luaSfLingHunMissionData = {}

function luaSfLingHunMissionData:Init()
    self.mes = nil
end

function luaSfLingHunMissionData:IsFunctionOpen()
    return self.mes ~= nil
end

function luaSfLingHunMissionData:GetNetMes(_msg)
    if _msg == nil then
        return
    end
    self.mes = { count = 0,taskState = {}}
    self.mes.count = _msg.completeCount
    for i = 1, #_msg.state do
        table.insert(self.mes.taskState,_msg.state[i])
    end
end

function luaSfLingHunMissionData:GetData()
    return self.mes
end


function luaSfLingHunMissionData:OnExitDestroy()
    self.mes = nil
end

return luaSfLingHunMissionData