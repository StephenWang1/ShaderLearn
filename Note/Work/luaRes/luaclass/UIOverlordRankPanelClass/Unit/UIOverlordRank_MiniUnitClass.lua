---@class UIOverlordRank_MiniUnitClass:UIOverlordRank_BaseUnitClass 迷你单元
local UIOverlordRank_MiniUnitClass = {}
setmetatable(UIOverlordRank_MiniUnitClass, luaclass.UIOverlordRank_BaseUnitClass)

function UIOverlordRank_MiniUnitClass:SetRankView()
    if self.unitTbl:GetPlayerRank() ~= nil then
        self.unitTbl:GetPlayerRank().text = self.unitTbl.rankID
        self.unitTbl:GetPlayerRank().gameObject:SetActive(self:IsShowPlayerRank())
    end

    if self.unitTbl:GetPlayerName() ~= nil then
        self.unitTbl:GetPlayerName().text = (self.rankData ~= nil and self.rankData.rid ~= 0) and tostring(self.rankData.name) or '暂无'
        self.unitTbl:GetPlayerName().gameObject:SetActive(self:IsShowPlayerName())
    end

    if self.unitTbl:GetContribution() ~= nil then
        self.unitTbl:GetContribution().text = (self.rankData ~= nil and self.rankData.rid ~= 0) and tostring(self.rankData.meritValue) or ''
        self.unitTbl:GetContribution().gameObject:SetActive(self:IsShowContribution())
    end

    self:ShowRewardList()
end

function UIOverlordRank_MiniUnitClass:ShowRewardList()
    self:RunBaseFunction("ShowRewardList")
    if self.unitTbl:GetRewardGrid() ~= nil then
        self.unitTbl:GetRewardGrid().transform.localScale = { x = 0.76, y = 0.76, z = 1 }
    end
end

function UIOverlordRank_MiniUnitClass:TrySetPos()

    if self.unitTbl:GetPlayerRank() ~= nil then
        local origionPos = self.unitTbl:GetPlayerRank().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(2, LuaEnumOverlordComponentType.PlayerRank, false)
        self.unitTbl:GetPlayerRank().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetPlayerName() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(2, LuaEnumOverlordComponentType.PlayerName, false)
        self.unitTbl:GetPlayerName().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetContribution() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(2, LuaEnumOverlordComponentType.Contribution, false)
        self.unitTbl:GetContribution().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRewardGrid() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(2, LuaEnumOverlordComponentType.UnionReward, false)
        self.unitTbl:GetRewardGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

function UIOverlordRank_MiniUnitClass:GetRewardList()
    if self.rankData ~= nil then
        return self.rankData.rewardList
    end
    return nil
end

---是否显示玩家排行
function UIOverlordRank_MiniUnitClass:IsShowPlayerRank()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionRank, self.unitTbl:GetUnionRank().gameObject)
    return true
end
---是否显示玩家姓名
function UIOverlordRank_MiniUnitClass:IsShowPlayerName()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.PlayerName, self.unitTbl:GetPlayerName().gameObject)
    return true
end
---是否显示贡献度
function UIOverlordRank_MiniUnitClass:IsShowContribution()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.Contribution, self.unitTbl:GetContribution().gameObject)
    return true
end

return UIOverlordRank_MiniUnitClass