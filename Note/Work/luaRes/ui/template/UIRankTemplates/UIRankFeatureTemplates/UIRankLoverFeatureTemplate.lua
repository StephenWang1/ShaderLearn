---@class UIRankLoverFeatureTemplate:UIRankFeatureBaseTemplate 恩爱榜排行榜功能
local UIRankLoverFeatureTemplate = {}

setmetatable(UIRankLoverFeatureTemplate, luaclass.UIRankFeatureBaseTemplate)

function UIRankLoverFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")

    if self.unitTbl:GetRankLoverFirstName() ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankLoverFirstName()
        self.unitTbl:GetRankLoverFirstName().text = self.rankData.name
    end

    if self.unitTbl:GetRankLoverSecondName() ~= nil then
        self.unitTbl:GetRankLoverSecondName().text = self.unitTbl.wifeRankInfo.name
    end

    if self.unitTbl:GetRankLover() ~= nil then
        if self:IsShowLoverValue() then
            self.unitTbl:GetRankLover().gameObject:SetActive(true)
            self.unitTbl:SetActiveState(LuaRankComponentSystem.lover, self.unitTbl:GetRankLover().gameObject)
        end
    end

    if self.unitTbl:GetRankLoverFirstMothIcon() ~= nil and self.rankData ~= nil then
        --self.unitTbl:GetRankMothIcon().spriteName = (self.rankData.monthCard ~= nil and self.rankData.monthCard == 1) and 'Biqi' or 'MengZhong'
        self.unitTbl:GetRankLoverFirstMothIcon().spriteName = self:GetMothName(self.rankData.monthCard)
        self.unitTbl:GetRankLoverFirstMothIcon().gameObject:SetActive(self:IsShowRankNameMothIcon())
        self.unitTbl:GetRankLoverFirstMothIcon():DelayUpdateAnchors()
    end

    if self.unitTbl:GetRankLoverSecondMothIcon() ~= nil and self.rankData ~= nil then
        --self.unitTbl:GetRankMothIcon().spriteName = (self.rankData.monthCard ~= nil and self.rankData.monthCard == 1) and 'Biqi' or 'MengZhong'
        self.unitTbl:GetRankLoverSecondMothIcon().spriteName = self:GetMothName(self.unitTbl.wifeRankInfo.monthCard)
        self.unitTbl:GetRankLoverSecondMothIcon().gameObject:SetActive(self:IsShowRankNameMothIcon())
        self.unitTbl:GetRankLoverSecondMothIcon():DelayUpdateAnchors()
    end

    if self.unitTbl:GetRankIntimacyValue() ~= nil then
        self.unitTbl:GetRankIntimacyValue().text = tostring(self.rankData.param)
        self.unitTbl:GetRankIntimacyValue().gameObject:SetActive(self:IsShowIntimacy())
    end
end

function UIRankLoverFeatureTemplate:BindEvent()
    if self.unitTbl:GetRankRewardBox() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankRewardBox().gameObject).OnClickLuaDelegate = self.unitTbl.OnRewardboxBtnClick
    end

    if self.unitTbl:GetRankLoverSecondName() ~= nil then
        CS.UIEventListener.Get(self.unitTbl:GetRankLoverSecondName().gameObject).LuaEventTable = self.unitTbl
        CS.UIEventListener.Get(self.unitTbl:GetRankLoverSecondName().gameObject).OnClickLuaDelegate = self.unitTbl.OnWifeNameTwoClick
    end
end

function UIRankLoverFeatureTemplate:InitParam()
    self.bgSize = 832
    self.checkBgSize = 832
end

function UIRankLoverFeatureTemplate:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetRankLover() ~= nil then
        local origionPos = self.unitTbl:GetRankLover().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.lover)
        self.unitTbl:GetRankLover().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankIntimacyValue() ~= nil then
        local origionPos = self.unitTbl:GetRankIntimacyValue().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.intimacy)
        self.unitTbl:GetRankIntimacyValue().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end

    if self.unitTbl:GetRankRewardBox() ~= nil then
        local origionPos = self.unitTbl:GetRankRewardBox().transform.localPosition
        local posx = CS.Cfg_RankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.rewardBox)
        self.unitTbl:GetRankRewardBox().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

---点击回调
---@param target UIRankItemTemplate
function UIRankLoverFeatureTemplate:OnTemplatBtnClick(target, go)
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        if target.rankData.uid == CS.CSScene.MainPlayerInfo.ID then
            if target:GetRankName() ~= nil then
                Utility.ShowPopoTips(target:GetRankName().gameObject, nil, 308, "UIRankPanel")
            end
            return
        end

        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
            roleId = target.rid,
            roleName = target.rankData.name,
            roleSex = target.rankData.sex,
            roleCareer = target.rankData.career,
            hostId = target.rankData.sid,
        })
    end
end

--region overrid

--是否显示名字2
function UIRankLoverFeatureTemplate:IsShowRankName()
    return false
end

--是否需要显示夫妻信息9
function UIRankLoverFeatureTemplate:IsShowLoverValue()
    return true
end

--是否显示亲密度10
function UIRankLoverFeatureTemplate:IsShowIntimacy()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.intimacy, self.unitTbl:GetRankIntimacyValue().gameObject)
    return true
end

--是否需要显示宝箱按钮7
function UIRankLoverFeatureTemplate:IsShowBoxBtn()
    return true
end

function UIRankLoverFeatureTemplate:IsShowLoverFirstMothIcon()
    if self.rankData == nil or self.rankData.monthCard == nil then
        return false
    end
    return self.rankData.monthCard ~= 0
end

function UIRankLoverFeatureTemplate:IsShowLoverSecondtMothIcon()
    if self.unitTbl == nil or self.unitTbl.wifeRankInfo == nil then
        return false
    end
    return self.unitTbl.wifeRankInfo.monthCard ~= 0
end

--endregion

--region UI函数回调

function UIRankLoverFeatureTemplate:OnWifeNameTwoClick(target, go)
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        if target.wifeRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
            CS.Utility.ShowTips("[ff0000]不可查看自己[-]")
            return
        end
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, target.wifeRankInfo.uid)
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, target.wifeRankInfo.uid)
        end
    end
end

--endregion


--region otherFunction

function UIRankLoverFeatureTemplate:IsShowBoxBtn()
    return true
end

--是否需要显示夫妻标记信息
function UIRankLoverFeatureTemplate:IsShowLoverValue()
    return true
end

--是否显示自己标记
function UIRankLoverFeatureTemplate:IsShowMyMark()
    return (self.rid ~= nil and self.rid == CS.CSScene.MainPlayerInfo.ID) or (self.wifeId ~= nil and self.wifeId == CS.CSScene.MainPlayerInfo.ID)
end

--endregion

--region ondestroy

function UIRankLoverFeatureTemplate:onDestroy()
    self:RunBaseFunction("onDestroy")
    self.wifeId = nil
end

--endregion

return UIRankLoverFeatureTemplate