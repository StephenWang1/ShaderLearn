---@class GuildActivity_MagicCircle:GuildActivity_Base
local GuildActivity_MagicCircle = {}

setmetatable(GuildActivity_MagicCircle,luaComponentTemplates.GuildActivity_Base)

--region 初始化
function GuildActivity_MagicCircle:Init()
    self:RunBaseFunction("Init")
end

function GuildActivity_MagicCircle:InitParams()
    self:RunBaseFunction("InitParams")
    self.magicCircleInfo = CS.CSScene.MainPlayerInfo.MagicCircleInfo
end
--endregion

--region 刷新
function GuildActivity_MagicCircle:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel",commonData)
    self:RefreshPanelNoParams()
end

function GuildActivity_MagicCircle:RefreshPanelNoParams()
    self:RefreshLabel(self:GetNum_UILabel(),self.magicCircleInfo.ProgressText)
    self:RefreshLabel(self:GetBossPrompt_UILabel(),self.magicCircleInfo.BossShowText)
    self:RefreshActive(self:GetButtonEffect_GameObject(),self.magicCircleInfo.HaveMonster == true)
    self:RefreshActive(self:GetButton_GameObject(),true)
    self:RefreshActive(self:GetBg1_UISprite(),true)
end
--endregion

--region 点击事件
function GuildActivity_MagicCircle:EnterBtnOnClick(go)
    local mainPlayerCanEnter = self.magicCircleInfo:MainPlayerCanEnterMagicCircle()
    if mainPlayerCanEnter == 2 then
        Utility.ShowPopoTips(go,CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(300,CS.Cfg_GlobalTableManager.Instance:GetEnterMagicCircleLevel()),300)
    elseif mainPlayerCanEnter == 1 then
        Utility.ShowPopoTips(go,nil,302)
    elseif mainPlayerCanEnter == 0 then
        networkRequest.ReqEnterDuplicate(6001)
        uimanager:ClosePanel("UIGuildPanel")
    end
end

---背景点击事件
function GuildActivity_MagicCircle:Bg1BtnOnClick(go)
    local bagItemInfoList = CS.CSScene.MainPlayerInfo.MagicCircleInfo:GetAllMagicCircleMaterialInBag()
    if bagItemInfoList == nil or bagItemInfoList.Count == 0 then
        Utility.ShowPopoTips(go,nil,301)
        return
    end
    Utility.CreateItemUsePanel({bagItemInfoList = bagItemInfoList,singleUseBtnOnClick = function()
        if CS.StaticUtility.IsNull(self.go) == false then
            self:TryPlayEffect("700209",CS.UnityEngine.Vector3.zero,10)
        end
    end,moreUseBtnOnClick = function()
        if CS.StaticUtility.IsNull(self.go) == false then
            self:TryPlayEffect("700209",CS.UnityEngine.Vector3.zero,10)
        end
    end})
end

function GuildActivity_MagicCircle:OnDisable()
    self:TryHideEffect("700209")
end
--endregion
return GuildActivity_MagicCircle