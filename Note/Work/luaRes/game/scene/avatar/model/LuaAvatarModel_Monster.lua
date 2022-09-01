---lua端场景中avatar的模型类
---@class LuaAvatarModel_Monster:LuaAvatarModel
local LuaAvatarModel_Monster = {}
---所有AvatarModel类继承与LuaAvatarModel
setmetatable(LuaAvatarModel_Monster, luaclass.LuaAvatarModel)

---模型构造初始化 这里是应该是需要针对一个类型去做处理,不能对某个模型进行处理
---@param csAvatar CSAvater
---@return boolean 是否继续C#模型初始
function LuaAvatarModel_Monster:OnAvatarStructInitEvent()
    local csAvatar = self:GetCSAvatar()
    if(csAvatar == nil) then
        return true
    end
    if csAvatar.MonsterTable == nil then
        return true
    end
    ---先放到这里,但是按逻辑来说有点问题,之后再优化,先处理线上版本问题
    local monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(csAvatar.MonsterTable.id)
    if monsterTable ~= nil and monsterTable:GetHalo() ~= nil then
        if csAvatar.Model ~= nil and csAvatar.Model.EffectPlayer ~= nil then
            local scale = monsterTable:GetHaloScale() == nil and 100 or monsterTable:GetHaloScale()
            scale = scale == 0 and 1 or scale / 100
            local objScale = CS.UnityEngine.Vector3(1 * scale, 1 * scale, 1 * scale)
            --脚下光圈
            csAvatar.Model.EffectPlayer:AddModelEffect(monsterTable:GetHalo(), CS.CSModelEffectPlayer.EffectAnchor.Bottom,
                    objScale, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, true)
        end
    end
    return true
end

---模型加载解析
---@param csAvatar CSAvater
---@return boolean 是否继续C#模型初始
function LuaAvatarModel_Monster:OnAvatarModelAnalysisEvent()
    if(self:GetCSModelLoad() == nil) then
        return true
    end
    if(self:GetCSAvatar().IsLoadModel2D == false) then
        self:GetCSModelLoad():LoadWeapon()
        self:GetCSModelLoad():LoadArmor()
        self:GetCSModelLoad():LoadHair()
    else
        self:GetCSModelLoad():TryLoadMonster2DModel()
    end

    self:GetCSModelLoad():ClearEffectSign();

    return false
end

function LuaAvatarModel_Monster:PrestrainDisModel()
    if(self:GetCSAvatar() == nil or self:GetCSAvatar().MonsterTbl == nil or self:GetCSAvatar().MonsterTbl.deathmodel == 0) then
        return
    end
    CS.CSResourceManager.Singleton:AddQueue(tostring(self:GetCSAvatar().MonsterTbl.deathmodel), CS.ResourceType.BodyModel, nil, CS.ResourceAssistType.Monster);
end

return LuaAvatarModel_Monster