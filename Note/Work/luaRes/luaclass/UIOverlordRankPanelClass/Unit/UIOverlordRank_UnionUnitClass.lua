---@class UIOverlordRank_UnionUnitClass:UIOverlordRank_BaseUnitClass       行会之争单元
local UIOverlordRank_UnionUnitClass = {}
setmetatable(UIOverlordRank_UnionUnitClass, luaclass.UIOverlordRank_BaseUnitClass)

function UIOverlordRank_UnionUnitClass:OnGetRewardBtnClick()
    networkRequest.ReqRewardUinonBattle(self.rankData.unionId)
end

function UIOverlordRank_UnionUnitClass:SetRankView()

    self:SetBgWidght(108)

    if self.unitTbl:GetRankingSprite() ~= nil then
        self.unitTbl:GetRankingSprite().spriteName = self.unitTbl.rankID > 3 and '' or (self.unitTbl.rankID)
        self.unitTbl:GetRankingSprite().gameObject:SetActive(self:IsShowRankSprite())
    end

    if self.unitTbl:GetUnionRank() ~= nil then
        self.unitTbl:GetUnionRank().text = '第' .. self.unitTbl.rankID .. '名'
        self.unitTbl:GetUnionRank().gameObject:SetActive(self:IsShowUnionRank())
    end
    if self.unitTbl:GetUnionName() ~= nil then
        self.unitTbl:GetUnionName().text = (self.rankData ~= nil and self.rankData.unionId ~= 0) and tostring(self.rankData.unionName) or '虚位以待'
        self.unitTbl:GetUnionName().gameObject:SetActive(self:IsShowUnionName())
    end

    if self.unitTbl:GetProsperity() ~= nil then
        self.unitTbl:GetProsperity().text = (self.rankData ~= nil and self.rankData.unionId ~= 0) and self:GetActiveValue() or ''
        self.unitTbl:GetProsperity().gameObject:SetActive(self:IsShowProsperity())
    end

    self:ShowRewardList()
    self:RefreshRewardState()
end

function UIOverlordRank_UnionUnitClass:TrySetPos()
    if self.unitTbl:GetRankingSprite() ~= nil then
        local origionPos = self.unitTbl:GetRankingSprite().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.RankSprite, true)
        self.unitTbl:GetRankingSprite().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetUnionRank() ~= nil then
        local origionPos = self.unitTbl:GetUnionRank().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.UnionRank, true)
        self.unitTbl:GetUnionRank().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetUnionName() ~= nil then
        local origionPos = self.unitTbl:GetUnionName().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.UnionName, true)
        self.unitTbl:GetUnionName().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetProsperity() ~= nil then
        local origionPos = self.unitTbl:GetProsperity().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.Prosperity, true)
        self.unitTbl:GetProsperity().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRewardGrid() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.UnionReward, true)
        self.unitTbl:GetRewardGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

---是否显示行会排行
function UIOverlordRank_UnionUnitClass:IsShowUnionRank()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionRank, self.unitTbl:GetUnionRank().gameObject)
    return true
end
---是否显示行会名称
function UIOverlordRank_UnionUnitClass:IsShowUnionName()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionName, self.unitTbl:GetUnionName().gameObject)
    return true
end
---是否显示繁荣度
function UIOverlordRank_UnionUnitClass:IsShowProsperity()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.Prosperity, self.unitTbl:GetProsperity().gameObject)
    return true
end

function UIOverlordRank_UnionUnitClass:IsShowRankSprite()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.RankSprite, self.unitTbl:GetRankingSprite().gameObject)
    return true
end

function UIOverlordRank_UnionUnitClass:IsShowGetRewardBtn()
    return self.rankData ~= nil and self.rankData.receiveType == 1
end

function UIOverlordRank_UnionUnitClass:IsShowReceivedReward()
    return self.rankData ~= nil and self.rankData.receiveType == 2
end

function UIOverlordRank_UnionUnitClass:GetActiveValue()
    return tostring(Utility.GetUnionActiveValue(self.unitTbl.rankID))
end

return UIOverlordRank_UnionUnitClass