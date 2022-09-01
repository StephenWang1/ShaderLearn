---@class UIRankKillMonsterFeatureTemplate:UIRankNormalFeatureTemplate 猎兽榜
local UIRankKillMonsterFeatureTemplate = {}

setmetatable(UIRankKillMonsterFeatureTemplate, luaclass.UIRankNormalFeatureTemplate)

function UIRankKillMonsterFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankBossKill() ~= nil then
        self.unitTbl:GetRankBossKill().text = tostring(self.rankData.param)
        self.unitTbl:GetRankBossKill().gameObject:SetActive(self:IsShowKillBossNum())
    end

    if self.unitTbl:GetRankCareer() ~= nil then
        self.unitTbl:GetRankCareer().text = self:GetCurCareer()
        self.unitTbl:GetRankCareer().gameObject:SetActive(self:IsShowRankCareer())
    end

    if self.unitTbl:GetRankLevel() ~= nil then
        self.unitTbl:GetRankLevel().text = self.rankData.level
        self.unitTbl:GetRankLevel().gameObject:SetActive(self:IsShowRankLevel())
    end
end

function UIRankKillMonsterFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox()~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end


function UIRankKillMonsterFeatureTemplate:TrySetPos()
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

    if self.unitTbl:GetRankBossKill() ~= nil then
        local origionPos = self.unitTbl:GetRankBossKill().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.killBoss)
        self.unitTbl:GetRankBossKill().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--region overrid

--是否显示职业3
function UIRankKillMonsterFeatureTemplate:IsShowRankCareer()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.career, self.unitTbl:GetRankCareer().gameObject)
    return true
end

--是否显示等级4
function UIRankKillMonsterFeatureTemplate:IsShowRankLevel()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.level, self.unitTbl:GetRankLevel().gameObject)
    return true
end

--是否显示boss击杀数15
function UIRankKillMonsterFeatureTemplate:IsShowKillBossNum()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.killBoss, self.unitTbl:GetRankBossKill().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankKillMonsterFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end

--endregion

return UIRankKillMonsterFeatureTemplate


