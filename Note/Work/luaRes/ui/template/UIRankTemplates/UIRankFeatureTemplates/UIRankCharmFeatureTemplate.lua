---@class UIRankCharmFeatureTemplate:UIRankFeatureBaseTemplate 男神榜(女神榜)排行榜功能
local UIRankCharmFeatureTemplate = {}

setmetatable(UIRankCharmFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankCharmFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankCharmValue() ~= nil then
        self.unitTbl:GetRankCharmValue().text = tostring(self.rankData.param)
        self.unitTbl:GetRankCharmValue().gameObject:SetActive(self:IsShowCharmValue())
    end
end

function UIRankCharmFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox()~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end

--region overrid

function UIRankCharmFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankCharmValue() ~= nil then
        local origionPos = self.unitTbl:GetRankCharmValue().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.charm)
        self.unitTbl:GetRankCharmValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--region otherFunction

--是否需要显示宝箱按钮7
function UIRankCharmFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end

--是否显示魅力值8
function UIRankCharmFeatureTemplate:IsShowCharmValue()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.charm, self.unitTbl:GetRankCharmValue().gameObject)
    return true
end

--endregion

--region ondestroy

function UIRankCharmFeatureTemplate:onDestroy()

end

--endregion

return UIRankCharmFeatureTemplate