---@class GuildActivity_GuildForbiddenArea:GuildActivity_Base
local GuildActivity_GuildForbiddenArea = {}

setmetatable(GuildActivity_GuildForbiddenArea, luaComponentTemplates.GuildActivity_Base)

--region 刷新
function GuildActivity_GuildForbiddenArea:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
    self:RefreshPanelNoParams()
end

function GuildActivity_GuildForbiddenArea:RefreshPanelNoParams()
    self:RefreshLabel(self:GetNum_UILabel(), "")
    local luaTable = clientTableManager.cfg_union_activityManager:TryGetValue(self.activityInfo.UnionActivityTable.id)
    if luaTable then
        self:RefreshLabel(self:GetBossPrompt_UILabel(), luaTable:GetDes())
    end
    -- self:RefreshActive(self:GetButtonEffect_GameObject(), self.magicCircleInfo.HaveMonster == true)
    self:RefreshActive(self:GetButton_GameObject(), true)
    self:RefreshActive(self:GetBg1_UISprite(), false)

    local canEnter = self.activityInfo.isOpen and Utility.UnionDungeonEnterLimit()
    self:RefreshActive(self:GetButtonEffect_GameObject(), canEnter)

    if self.activityInfo.UnionActivityTable then
        self:RefreshLabel(self:GetButton_UILabel(), self.activityInfo.UnionActivityTable.buttonLabel)
    end
    if (self.activityInfo.isOpen) then
        self:GetBtnBG_UISprite().spriteName = "anniu1"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.764, 0.956, 1)
    else
        self:GetBtnBG_UISprite().spriteName = "anniu26"
        self:GetButton_UILabel().color = CS.UnityEngine.Color(0.447, 0.447, 0.447)
    end
end
--endregion

--region 点击事件
function GuildActivity_GuildForbiddenArea:EnterBtnOnClick(go)
    if self.activityInfo.isOpen then
        networkRequest.ReqEnterDuplicate(24001)
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
        CS.CSPathFinderManager.Instance:Reset()
        uimanager:ClosePanel("UIGuildPanel")
    else
        if not Utility.UnionDungeonEnterLimit() then
            Utility.ShowPopoTips(go, "等级不足", 301)
        else
            Utility.ShowPopoTips(go, "不在开启时间", 301)
        end
    end
end

function GuildActivity_GuildForbiddenArea:OnDisable()
    self:TryHideEffect("700209")
end

return GuildActivity_GuildForbiddenArea