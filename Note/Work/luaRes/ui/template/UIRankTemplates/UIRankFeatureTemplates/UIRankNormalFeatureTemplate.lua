---@class UIRankNormalFeatureTemplate:UIRankFeatureBaseTemplate 常规排行榜功能
local UIRankNormalFeatureTemplate = {}

setmetatable(UIRankNormalFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

--region overrid

function UIRankNormalFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankCareer() ~= nil then
        self.unitTbl:GetRankCareer().text = self:GetCurCareer()
        self.unitTbl:GetRankCareer().gameObject:SetActive(self:IsShowRankCareer())
    end

    if self.unitTbl:GetRankLevel() ~= nil then
        self.unitTbl:GetRankLevel().text = self.rankData.level
        self.unitTbl:GetRankLevel().gameObject:SetActive(self:IsShowRankLevel())
    end
end

function UIRankNormalFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankCareer() ~= nil then
        local origionPos = self.unitTbl:GetRankCareer().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.career)
        self.unitTbl:GetRankCareer().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end

    if self.unitTbl:GetRankLevel() ~= nil then
        local origionPos = self.unitTbl:GetRankLevel().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId,LuaRankComponentSystem.level)
        self.unitTbl:GetRankLevel().transform.localPosition = CS.UnityEngine.Vector3(posx,origionPos.y,0)
    end
end

--是否显示职业
function UIRankNormalFeatureTemplate:IsShowRankCareer()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.career, self.unitTbl:GetRankCareer().gameObject)
    return true
end

--是否显示等级
function UIRankNormalFeatureTemplate:IsShowRankLevel()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.level, self.unitTbl:GetRankLevel().gameObject)
    return true
end
--endregion

--region ondestroy

function UIRankNormalFeatureTemplate:onDestroy()

end

--endregion

return UIRankNormalFeatureTemplate