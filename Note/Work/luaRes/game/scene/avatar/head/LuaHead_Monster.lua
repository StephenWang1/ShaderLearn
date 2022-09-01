---@class LuaHead_Monster:LuaHead_Avatar 怪物头顶
local LuaHead_Monster = {}
setmetatable(LuaHead_Monster, luaclass.LuaHead_Avatar)

function LuaHead_Monster:Init(luaAvatar)
    self:RunBaseFunction('Init', luaAvatar)
    self:ShowDemonBossBubble()
end


--region  魔之boss击杀时限和倒计时

---根据规则显示魔之boss头顶气泡
---@public
function LuaHead_Monster:ShowDemonBossBubble()
    if self:GetLuaAvatar() == nil then
        return
    end
    if self:GetLuaAvatar():GetDemonBossEndTime() == nil then
        return
    end
    self:ClearDemonBossTalk()
    if self:GetLuaAvatar():GetDemonBossEndTime() <= 0 then
        self:ShowDemonBossMonsterTalk()
    else
        self:ShowDemonBossTimeCount(self:GetLuaAvatar():GetDemonBossEndTime())
    end
end

---击杀时限显示
---@private
function LuaHead_Monster:ShowDemonBossMonsterTalk()
    local bubbleData = CS.Bubble1Data()
    bubbleData.avaterId = self:GetAvatarID()
    bubbleData.talk = CS.Cfg_GlobalTableManager.Instance:GetCountTimeDesc(5)
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_AddHeadSign, CS.UIHeadControllerBase.EHeadGoType.DemonBossBubble, bubbleData);
end

---倒计时显示
---@private
function LuaHead_Monster:ShowDemonBossTimeCount(time)
    --魔之boss 倒计时
    local timeCountData = CS.AvatarBaseTimeCountData()
    timeCountData.avaterId = self:GetAvatarID()
    timeCountData.endTimeStamp = time
    timeCountData.endCountTimeDesc = CS.Cfg_GlobalTableManager.Instance:GetCountTimeDesc(6)
    timeCountData.timeFormat = CS.UICountdownLabel.CountDownFormat.Special3
    timeCountData.timeEndCallBack = function()
        if self:GetLuaAvatar() == nil then
            return
        end
        self:GetLuaAvatar():SetDemonBossEndTime(0)
    end
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_AddHeadSign, CS.UIHeadControllerBase.EHeadGoType.DemonBossTimeCount, timeCountData)
end

---清空气泡
---@private
function LuaHead_Monster:ClearDemonBossTalk()
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_RemoveAllHeadSighByAvatarID, self:GetAvatarID())
end

--endregion

---死亡回调
---@public
function LuaHead_Monster:AvatarDeadCallBack()
    self:RunBaseFunction('AvatarDeadCallBack')
    self:ClearDemonBossTalk()
end

function LuaHead_Monster:Destroy()
    self:RunBaseFunction('Destroy')
    self:ClearDemonBossTalk()
end

return LuaHead_Monster