---怪物类
---@class LuaMonster:LuaAvatar
local LuaMonster = {}

setmetatable(LuaMonster, luaclass.LuaAvatar)

--region Data

--region 魔之boss时限

---获取魔之boss时限
---@public
function LuaMonster:GetDemonBossEndTime()
    return self.DemonBossEndTime
end

---设置魔之boss时限
---@param time number
function LuaMonster:SetDemonBossEndTime(time)
    if time == self.DemonBossEndTime then
        return
    end
    self.DemonBossEndTime = time
    if self:GetLuaAvatarHead() ~= nil then
        self:GetLuaAvatarHead():ShowDemonBossBubble()
    end
end
--endregion

--endregion

---初始化Avatar数据,这个方法在每个上层上需要去重写
---@param data mapV2.RoundMonsterInfo
function LuaMonster:InitAvatarData(data)
    self.DemonBossEndTime = nil
    self.mID = data.lid
end

--region 销毁
---销毁
---@public
function LuaMonster:Destroy()
    self:RunBaseFunction('Destroy')
    self.DemonBossEndTime = nil
end

return LuaMonster