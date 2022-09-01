---@class UIRankPrefixFeatureTemplate:UIRankFeatureBaseTemplate 战勋榜排行榜功能
local UIRankPrefixFeatureTemplate = {}
setmetatable(UIRankPrefixFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

--region overrid

function UIRankPrefixFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankCareer() ~= nil then
        self.unitTbl:GetRankCareer().text = self:GetCurCareer()
        self.unitTbl:GetRankCareer().gameObject:SetActive(self:IsShowRankCareer())
    end

    if self.unitTbl:GetRankPrefix() ~= nil then
        self.unitTbl:GetRankPrefix().text = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(self.rankData.param, self.rankData.career)
        self.unitTbl:GetRankPrefix().gameObject:SetActive(self:IsShowPrefix())
    end

end

function UIRankPrefixFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankCareer() ~= nil then
        local origionPos = self.unitTbl:GetRankCareer().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.career)
        self.unitTbl:GetRankCareer().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end

    if self.unitTbl:GetRankPrefix() ~= nil then
        local origionPos = self.unitTbl:GetRankPrefix().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.prefix)
        self.unitTbl:GetRankPrefix().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end
end

--是否显示职业
function UIRankPrefixFeatureTemplate:IsShowRankCareer()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.career, self.unitTbl:GetRankCareer().gameObject)
    return true
end

--是否显示战勋
function UIRankPrefixFeatureTemplate:IsShowPrefix()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.prefix, self.unitTbl:GetRankPrefix().gameObject)
    return true
end
--endregion

return UIRankPrefixFeatureTemplate