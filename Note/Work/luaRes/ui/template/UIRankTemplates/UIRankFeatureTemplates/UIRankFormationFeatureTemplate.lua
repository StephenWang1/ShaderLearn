---@class UIRankFormationFeatureTemplate:UIRankFeatureBaseTemplate
local UIRankFormationFeatureTemplate = {}
setmetatable(UIRankFormationFeatureTemplate,luaclass.UIRankFeatureBaseTemplate)

--region overrid

function UIRankFormationFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankCareer() ~= nil then
        self.unitTbl:GetRankCareer().text = self:GetCurCareer()
        self.unitTbl:GetRankCareer().gameObject:SetActive(self:IsShowRankCareer())
    end

    if self.unitTbl:GetRankFormationLevle() ~= nil then
        self.unitTbl:GetRankFormationLevle().text = self.rankData.param
        self.unitTbl:GetRankFormationLevle().gameObject:SetActive(self:IsShowFormationLevle())
    end
end

function UIRankFormationFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankCareer() ~= nil then
        local origionPos = self.unitTbl:GetRankCareer().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.career)
        self.unitTbl:GetRankCareer().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end

    if self.unitTbl:GetRankFormationLevle() ~= nil then
        local origionPos = self.unitTbl:GetRankFormationLevle().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.formation)
        self.unitTbl:GetRankFormationLevle().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end
end

--是否显示职业
function UIRankFormationFeatureTemplate:IsShowRankCareer()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.career, self.unitTbl:GetRankCareer().gameObject)
    return true
end

--是否显示阵法等级
function UIRankFormationFeatureTemplate:IsShowFormationLevle()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.formation, self.unitTbl:GetRankFormationLevle().gameObject)
    return true
end
--endregion

return UIRankFormationFeatureTemplate