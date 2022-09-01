---@class UIContendRank_UnitNormalFeatureClass:UIContendRank_UnitFeatureClass 夺榜等级榜
local UIContendRank_UnitNormalFeatureClass = {}

setmetatable(UIContendRank_UnitNormalFeatureClass, luaclass.UIContendRank_UnitFeatureClass)

function UIContendRank_UnitNormalFeatureClass:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetNormalText() ~= nil then
        local unitStr = CS.Cfg_ContendRankTableManager.Instance:GetComponentUnitStr(self.unitTbl.rankConfigId, LuaRankComponentSystem.normalStr, self.unitTbl.isMain)
        self.unitTbl:GetNormalText().text = self.rankData ~= nil and tostring(self.rankData.param) .. unitStr or ""
        self.unitTbl:GetNormalText().gameObject:SetActive(self:IsShowNormal())
        self.unitTbl:GetRankDealIngot().gameObject:SetActive(false)
    end
end

function UIContendRank_UnitNormalFeatureClass:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetNormalText() ~= nil then
        local origionPos = self.unitTbl:GetNormalText().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.normalStr, self.unitTbl.isMain)
        self.unitTbl:GetNormalText().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--是否显示通用param赋值文本
function UIContendRank_UnitNormalFeatureClass:IsShowNormal()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.normalStr, self.unitTbl:GetNormalText().gameObject)
    return true
end

return UIContendRank_UnitNormalFeatureClass