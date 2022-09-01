---@class UIRankFistFeatureTemplate:UIRankFeatureBaseTemplate 拳榜
local UIRankFistFeatureTemplate = {}

setmetatable(UIRankFistFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankFistFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankFingerValue() ~= nil then
        self.unitTbl:GetRankFingerValue().text = tostring(self.rankData.param)
        self.unitTbl:GetRankFingerValue().gameObject:SetActive(self:IsShowFistValue())
    end
end

function UIRankFistFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox()~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end

--region overrid

function UIRankFistFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankFingerValue() ~= nil then
        local origionPos = self.unitTbl:GetRankFingerValue().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.finger)
        self.unitTbl:GetRankFingerValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--是否显示划拳积分6
function UIRankFistFeatureTemplate:IsShowFistValue()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.finger, self.unitTbl:GetRankFingerValue().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankFistFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return UIRankFistFeatureTemplate
end

--endregion


return UIRankFistFeatureTemplate
