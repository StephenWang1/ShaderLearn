---@class LuaMainPlayer:LuaAvatar
local LuaMainPlayer = {}

setmetatable(LuaMainPlayer, luaclass.LuaAvatar)

--region 基础属性
---主角等级
function LuaMainPlayer:GetLevel()
    if self:GetCSAvatarInfo() ~= nil then
        return self:GetCSAvatarInfo().Level
    end
    return 0
end

---主角转生等级
function LuaMainPlayer:GetReinLv()
    return CS.CSScene.MainPlayerInfo.ReinLevel
end

---主角的职业
---@return LuaEnumCareer
function LuaMainPlayer:GetCareer()
    if self:GetCSAvatarInfo() ~= nil then
        return Utility.EnumToInt(self:GetCSAvatarInfo().Career)
    end
end

---获取avatar的ID
---@return number
function LuaMainPlayer:GetID()
    return CS.CSScene.MainPlayerInfo.ID
end
--endregion

---@type number
---升級特效需要播放的次數
LuaMainPlayer.mLevelUpEffectTimes = 0

---@type number
---上次升級特效播放的時間
LuaMainPlayer.mLastPlayLevelUpEffectTime = 0

---添加角色升級特效
function LuaMainPlayer:AddLevelUpEffectTime(time)
    self.mLevelUpEffectTimes = self.mLevelUpEffectTimes + time
end

function LuaMainPlayer:Update()
    if self:GetLuaAvatarHead() ~= nil then
        self:GetLuaAvatarHead():Update()
    end
    --self:RunBaseFunction("Update")
    ---角色升級播放特效
    if self.mLevelUpEffectTimes > 0 and CS.UnityEngine.Time.time - self.mLastPlayLevelUpEffectTime > 1 then
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo and mainPlayerInfo.HP <= 0 then
            self.mLevelUpEffectTimes = 0
            return
        end
        self.mLastPlayLevelUpEffectTime = CS.UnityEngine.Time.time
        local r = CS.CSResourceManager.Singleton:AddQueue("upgrade", CS.ResourceType.Effect, function(res)
            if (res == nil or CS.CSScene.IsLanuchMainPlayer == false or CS.CSScene.Sington.MainPlayer.CacheTransform == nil) then
                return ;
            end

            local effect = CS.CSScene.Sington.MainPlayer.Model.Effect.GoTrans;
            if (effect == nil) then
                return ;
            end

            local RoleUpdatePoolItem = res:GetPoolItem(CS.EPoolType.Normal, 0, 2);
            if (RoleUpdatePoolItem == nil or RoleUpdatePoolItem.go == nil) then
                return ;
            end

            RoleUpdatePoolItem.go:SetActive(false);
            RoleUpdatePoolItem.go.transform.parent = effect;
            RoleUpdatePoolItem.go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, -5);
            RoleUpdatePoolItem.go.transform.localScale = CS.UnityEngine.Vector3.one;
            RoleUpdatePoolItem.go:SetActive(true);
            self.mLevelUpEffectTimes = self.mLevelUpEffectTimes - 1
        end, CS.ResourceAssistType.UI);
        r.IsCanBeDelete = false;
    end
end

---获取远程主机信息（跨服相关数据信息）
---@return CS.CSRemoteHostInfo 远程主机信息
function LuaMainPlayer:GetMainPlayerRemoteHostInfo()
    if self:GetCSAvatar() ~= nil and self:GetCSAvatar().Info ~= nil then
        return self:GetCSAvatar().Info.RemoteHostInfo
    end
end

return LuaMainPlayer