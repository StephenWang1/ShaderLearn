---@class UIContendRank_UnitLevelFeatureClass:UIContendRank_UnitFeatureClass 夺榜等级榜
local UIContendRank_UnitLevelFeatureClass = {}

setmetatable(UIContendRank_UnitLevelFeatureClass, luaclass.UIContendRank_UnitFeatureClass)

function UIContendRank_UnitLevelFeatureClass:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankLevel() ~= nil then
        local unitStr = CS.Cfg_ContendRankTableManager.Instance:GetComponentUnitStr(self.unitTbl.rankConfigId, LuaRankComponentSystem.level, self.unitTbl.isMain)
        self.unitTbl:GetRankLevel().text = self.rankData == nil and "" or tostring(self.rankData.level) .. unitStr
        self.unitTbl:GetRankLevel().gameObject:SetActive(self:IsShowRankLevel())
    end

end

function UIContendRank_UnitLevelFeatureClass:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankLevel() ~= nil then
        local origionPos = self.unitTbl:GetRankLevel().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.level, self.unitTbl.isMain)
        self.unitTbl:GetRankLevel().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end


--是否显示等级
function UIContendRank_UnitLevelFeatureClass:IsShowRankLevel()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.level, self.unitTbl:GetRankLevel().gameObject)
    return true
end

return UIContendRank_UnitLevelFeatureClass