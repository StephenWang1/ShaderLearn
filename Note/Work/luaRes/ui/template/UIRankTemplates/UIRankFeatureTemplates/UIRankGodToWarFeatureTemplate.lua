---@class UIRankGodToWarFeatureTemplate:UIRankNormalFeatureTemplate 战神榜
local UIRankGodToWarFeatureTemplate = {}

setmetatable(UIRankGodToWarFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankGodToWarFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankCareer() ~= nil then
        self.unitTbl:GetRankCareer().text = self:GetCurCareer()
        self.unitTbl:GetRankCareer().gameObject:SetActive(self:IsShowRankCareer())
    end

    if self.unitTbl:GetRankLevel() ~= nil then
        self.unitTbl:GetRankLevel().text = self.rankData.level
        self.unitTbl:GetRankLevel().gameObject:SetActive(self:IsShowRankLevel())
    end

    if self.unitTbl:GetRankPlayerKill() ~= nil then
        self.unitTbl:GetRankPlayerKill().text = tostring(self.rankData.param)
        self.unitTbl:GetRankPlayerKill().gameObject:SetActive(self:IsShowKillPlayerNum())
    end

--[[    if self.unitTbl:GetRankGuild() ~= nil then
        self.unitTbl:GetRankGuild().text = self.rankData.unionName
        self.unitTbl:GetRankGuild().gameObject:SetActive(self:IsShowUnionName())
    end]]

end

function UIRankGodToWarFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end

function UIRankGodToWarFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankPlayerKill() ~= nil then
        local origionPos = self.unitTbl:GetRankPlayerKill().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.KillPlayer)
        self.unitTbl:GetRankPlayerKill().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankCareer() ~= nil then
        local origionPos = self.unitTbl:GetRankCareer().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.career)
        self.unitTbl:GetRankCareer().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankLevel() ~= nil then
        local origionPos = self.unitTbl:GetRankLevel().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.level)
        self.unitTbl:GetRankLevel().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

--[[    if self.unitTbl:GetRankGuild() ~= nil then
        local origionPos = self.unitTbl:GetRankGuild().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.guild)
        self.unitTbl:GetRankGuild().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end]]

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

end

--region overrid

--是否显示职业3
function UIRankGodToWarFeatureTemplate:IsShowRankCareer()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.career, self.unitTbl:GetRankCareer().gameObject)
    return true
end

--是否显示等级4
function UIRankGodToWarFeatureTemplate:IsShowRankLevel()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.level, self.unitTbl:GetRankLevel().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankGodToWarFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end

--是否显示行会名14
--[[function UIRankGodToWarFeatureTemplate:IsShowUnionName()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.guild, self.unitTbl:GetRankGuild().gameObject)
    return true
end]]

--是否显示杀人数量16
function UIRankGodToWarFeatureTemplate:IsShowKillPlayerNum()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.KillPlayer, self.unitTbl:GetRankPlayerKill().gameObject)
    return true
end

--endregion

return UIRankGodToWarFeatureTemplate



