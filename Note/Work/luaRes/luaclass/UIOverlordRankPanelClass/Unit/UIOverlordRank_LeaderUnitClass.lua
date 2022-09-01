---@class return UIOverlordRank_LeaderUnitClass: UIOverlordRank_BaseUnitClass 领袖之路单元
local UIOverlordRank_LeaderUnitClass = {}
setmetatable(UIOverlordRank_LeaderUnitClass, luaclass.UIOverlordRank_BaseUnitClass)

function UIOverlordRank_LeaderUnitClass:BindEvent()
    CS.UIEventListener.Get(self.unitTbl:GetCompetitionBtn()).LuaEventTable = self.unitTbl
    CS.UIEventListener.Get(self.unitTbl:GetCompetitionBtn()).OnClickLuaDelegate = nil
    CS.UIEventListener.Get(self.unitTbl:GetCompetitionBtn()).OnClickLuaDelegate = self.OnCompetitionBtnClick
end

function UIOverlordRank_LeaderUnitClass:SetRankView()

    self:SetBgWidght(98)

    if self.unitTbl:GetUnionPosition() ~= nil then
        local type = self.rankData ~= nil and self.rankData.subtype or 1
        self.unitTbl:GetUnionPosition().text = self:GetUnionPostionOfType(type)
        self.unitTbl:GetUnionPosition().gameObject:SetActive(self:IsShowUnionPosition())
    end

    if self.unitTbl:GetPlayerName() ~= nil then
        self.unitTbl:GetPlayerName().text = (self.rankData ~= nil and self.rankData.rid ~= 0) and tostring(self.rankData.name) or '暂无'
        --self:IsShowCompetitionBtn() and '前往竞选' or '暂无'
        self.unitTbl:GetPlayerName().gameObject:SetActive(self:IsShowPlayerName())
    end

    if self.unitTbl:GetContribution() ~= nil then
        self.unitTbl:GetContribution().text = (self.rankData ~= nil and self.rankData.rid ~= 0) and tostring(self.rankData.meritValue) or '暂无'
        self.unitTbl:GetContribution().gameObject:SetActive(self:IsShowContribution())
    end

    --if self:IsShowSecondPlayerName() and self.unitTbl:GetSecondPlayerName() ~= nil then
    --    self.unitTbl:GetSecondPlayerName().text = (self.rankData ~= nil and self.rankData.leader ~= nil and self.rankData.leader[1].rid ~= 0) and tostring(self.rankData.leader[1].name) or '暂无'
    --    self.unitTbl:GetSecondPlayerName().gameObject:SetActive(self:IsShowSecondPlayerName())
    --    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.SecondPlayerName, self.unitTbl:GetSecondPlayerName().gameObject)
    --end
    --
    --if self:IsShowSecondContribution() and self.unitTbl:GetSecondContribution() ~= nil then
    --    self.unitTbl:GetSecondContribution().text = (self.rankData ~= nil and self.rankData.leader ~= nil and self.rankData.leader[1].rid ~= 0) and tostring(self.rankData.leader[1].meritValue) or '暂无'
    --    self.unitTbl:GetSecondContribution().gameObject:SetActive(true)
    --    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.SecondContribution, self.unitTbl:GetSecondContribution().gameObject)
    --end

    if self.unitTbl:GetCompetitionBtn() ~= nil then
        self.unitTbl:GetCompetitionBtn().gameObject:SetActive(self:IsShowCompetitionBtn())
        self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.CompetitionBtn, self.unitTbl:GetCompetitionBtn())
    end

    self:ShowRewardList()
    self:RefreshRewardState()
end

function UIOverlordRank_LeaderUnitClass:TrySetPos()
    if self.unitTbl:GetUnionPosition() ~= nil then
        local origionPos = self.unitTbl:GetUnionPosition().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.UnionPosition, true)
        self.unitTbl:GetUnionPosition().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetPlayerName() ~= nil then
        local y = self:IsShowSecondPlayerName() and 17 or -3
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.PlayerName, true)
        self.unitTbl:GetPlayerName().transform.localPosition = CS.UnityEngine.Vector3(posx, y, 0)
    end

    if self.unitTbl:GetContribution() ~= nil then
        local y = self:IsShowSecondContribution() and 17 or -3
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.Contribution, true)
        self.unitTbl:GetContribution().transform.localPosition = CS.UnityEngine.Vector3(posx, y, 0)
    end

    --if self:IsShowSecondPlayerName() and self.unitTbl:GetSecondPlayerName() ~= nil then
    --    local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.PlayerName, true)
    --    self.unitTbl:GetSecondPlayerName().transform.localPosition = CS.UnityEngine.Vector3(posx, -19, 0)
    --end
    --
    --if self:IsShowSecondContribution() and self.unitTbl:GetSecondContribution() ~= nil then
    --    local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.Contribution, true)
    --    self.unitTbl:GetSecondContribution().transform.localPosition = CS.UnityEngine.Vector3(posx, -19, 0)
    --end

    if self.unitTbl:GetRewardGrid() ~= nil then
        local origionPos = self.unitTbl:GetRewardGrid().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.UnionReward, true)
        self.unitTbl:GetRewardGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetCompetitionBtn() ~= nil then
        local origionPos = self.unitTbl:GetCompetitionBtn().transform.localPosition
        local posx = CS.Cfg_OverlordTableManager.Instance:GetComponentPos(self.unitTbl.overlordRankId, LuaEnumOverlordComponentType.CompetitionBtn, true)
        self.unitTbl:GetCompetitionBtn().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

function UIOverlordRank_LeaderUnitClass:GetRewardList()
    if self.rankData ~= nil then
        return self.rankData.rewardList
    end
    return nil
end

--region 函数监听

---点击竞选按钮
function UIOverlordRank_LeaderUnitClass:OnCompetitionBtnClick()
    local data = {}
    data.subCustomData = {}
    data.subCustomData.isOpenAccusePanel = true
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Info, data)
end

---点击单元本身
function UIOverlordRank_LeaderUnitClass:OnTemplatBtnClick(target, go)
    if self.rankData ~= nil and self.rankData.rid ~= 0 then
        if self.rankData.rid == CS.CSScene.MainPlayerInfo.ID then
            if self.unitTbl:GetPlayerName() ~= nil then
                Utility.ShowPopoTips(self.unitTbl:GetPlayerName().gameObject, nil, 308, "UIOverlordRankPanel")
            end
            return
        end
        local panel = uimanager:GetPanel("UIOverlordRankPanel")
        if panel then
            panel.curRankTbl = target
        end
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.rankData.rid)
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.rankData.rid)
        end
    end
end

function UIOverlordRank_LeaderUnitClass:OnGetRewardBtnClick()
    networkRequest.ReqRewardLeaderGlory(self.rankData.id)
end

--endregion

--region CheckShow

---是否显示职位
function UIOverlordRank_LeaderUnitClass:IsShowUnionPosition()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.UnionPosition, self.unitTbl:GetUnionPosition().gameObject)
    return true
end
---是否显示玩家姓名
function UIOverlordRank_LeaderUnitClass:IsShowPlayerName()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.PlayerName, self.unitTbl:GetPlayerName().gameObject)
    return true
end
---是否显示贡献度
function UIOverlordRank_LeaderUnitClass:IsShowContribution()
    self.unitTbl:SetActiveState(LuaEnumOverlordComponentType.Contribution, self.unitTbl:GetContribution().gameObject)
    return true
end
---是否显示玩家姓名(特殊)
function UIOverlordRank_LeaderUnitClass:IsShowSecondPlayerName()
    return false
    --self.rankData ~= nil and self.rankData.leader ~= nil and self.rankData.leader.Count > 1 and self.rankData.leader[1].rid ~= 0
end
---是否显示贡献度 (特殊)
function UIOverlordRank_LeaderUnitClass:IsShowSecondContribution()
    return self:IsShowSecondPlayerName()
end

---是否显示奖励按钮
function UIOverlordRank_LeaderUnitClass:IsShowGetRewardBtn()
    if self.rankData ~= nil then
        --for i = 0, self.rankData.leader.Count - 1 do
        --    if self.rankData.leader[i].receiveType == 1 then
        --        return true
        --    end
        --end
        return self.rankData.receiveType == 1
    end
    return false
end

---是否显示已领取
function UIOverlordRank_LeaderUnitClass:IsShowReceivedReward()
    --if self.rankData ~= nil then
    --    --for i = 0, self.rankData.leader.Count - 1 do
    --    --    if self.rankData.leader[i].receiveType == 2 then
    --    --        return true
    --    --    end
    --    --end
    --    return self.rankData.receiveType == 2
    --end
    return false
end

---是否显示竞技按钮
function UIOverlordRank_LeaderUnitClass:IsShowCompetitionBtn()
    --首先无数据且 是第一位 且自己有帮会
    local isNotRankData = self.rankData == nil or self.rankData.rid == 0
    local isHaveUnion = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID ~= 0

    return self.unitTbl.rankID == 1 and isNotRankData and isHaveUnion
end

--endregion

--region Other
function UIOverlordRank_LeaderUnitClass:GetUnionPostionOfType(type)
    if type == 1 then
        return uiStaticParameter.PosStringListWithColor[LuaEnumGuildPosType.ActingPresident] .. '/会长'
    elseif type == 2 then
        return uiStaticParameter.PosStringListWithColor[LuaEnumGuildPosType.VicePresident]
    elseif type == 3 then
        return uiStaticParameter.PosStringListWithColor[LuaEnumGuildPosType.Elder]
    elseif type == 4 then
        return uiStaticParameter.PosStringListWithColor[LuaEnumGuildPosType.Owner]
    elseif type == 5 then
        return uiStaticParameter.PosStringListWithColor[LuaEnumGuildPosType.Elite]
    end
end
--endregion

return UIOverlordRank_LeaderUnitClass