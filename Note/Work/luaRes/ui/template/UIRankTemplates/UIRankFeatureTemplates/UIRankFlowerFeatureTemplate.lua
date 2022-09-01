---@class UIRankFlowerFeatureTemplate:UIRankFeatureBaseTemplate 花榜
local UIRankFlowerFeatureTemplate = {}

setmetatable(UIRankFlowerFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankFlowerFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankFlowerValue() ~= nil then
        self.unitTbl:GetRankFlowerValue().text = tostring(self.rankData.param)
        self.unitTbl:GetRankFlowerValue().gameObject:SetActive(self:IsShowFlowerValue())
    end
    if self.unitTbl:GetRankSex() ~= nil then
        self.unitTbl:GetRankSex().text = self:GetCurSex()
        self.unitTbl:GetRankSex().gameObject:SetActive(self:IsShowSex())
    end
end

function UIRankFlowerFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end
end

function UIRankFlowerFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankFlowerValue() ~= nil then
        local origionPos = self.unitTbl:GetRankFlowerValue().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.flower)
        self.unitTbl:GetRankFlowerValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankSex() ~= nil then
        local origionPos = self.unitTbl:GetRankSex().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.sex)
        self.unitTbl:GetRankSex().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--是否显示性别11
function UIRankFlowerFeatureTemplate:IsShowSex()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.sex, self.unitTbl:GetRankSex().gameObject)
    return true
end

--是否显示送花数12
function UIRankFlowerFeatureTemplate:IsShowFlowerValue()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.flower, self.unitTbl:GetRankFlowerValue().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankFlowerFeatureTemplate:IsShowBoxBtn()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.rewardBox, self.unitTbl:GetRankRewardBox().gameObject)
    return true
end

return UIRankFlowerFeatureTemplate