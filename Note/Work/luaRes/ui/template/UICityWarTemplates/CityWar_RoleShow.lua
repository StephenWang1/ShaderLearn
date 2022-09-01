---@class CityWar_RoleShow
local CityWar_RoleShow = {}

function CityWar_RoleShow:Init()
    self:InitComponents()
end

function CityWar_RoleShow:GetObservationModel()
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    return self.ObservationModel
end

function CityWar_RoleShow:InitComponents()
    ---角色模型根节点
    ---@type UnityEngine.GameObject
    self.roleModel = self:Get("roleModel", "GameObject")
end

---@param data roleV2.ResPlayerBasicInfo 其他玩家信息
function CityWar_RoleShow:Show(data)
    if data then
        ---装备信息
        local info = data.roleExtraValues
        local BodyModel, HairModel, WeaponModel, FaceModel = 0, 0, 0, 0
        local res1, info1 = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.clothes)
        if res1 then
            BodyModel = tonumber(info1.model)
        end
        local res2, info2 = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.weapon)
        if res2 then
            WeaponModel = tonumber(info2.model)
        end
        local res3, info3 = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.helmet)
        if res3 then
            HairModel = tonumber(info3.model)
        end
        local res4, info4 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.face)
        if res4 then
            FaceModel = tonumber(info4.model)
        end
        local modelChangeRes = self:GetObservationModel():CreateRoleModel(CS.ESex.__CastFrom(data.sex), CS.ECareer.__CastFrom(data.career), BodyModel, WeaponModel, HairModel, FaceModel, nil, self.roleModel.transform)
        if modelChangeRes then
            self:GetObservationModel():SetPosition(CS.UnityEngine.Vector3(0, -158, -300))
            self:GetObservationModel():SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
            self:GetObservationModel():SetScaleSize(CS.UnityEngine.Vector3(130, 130, 130))
            self:GetObservationModel():SetDragRoot(self.roleModel)
        end
    end
end

return CityWar_RoleShow