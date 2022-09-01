---@class LuaMonsterAttackMgr 怪物攻城类
local LuaMonsterAttackMgr = {}

function LuaMonsterAttackMgr:MonsterAttackData(data)
    if data == nil then
        return self.data
    end
    if data ~= nil then
        self.data = data
    end

end

return LuaMonsterAttackMgr