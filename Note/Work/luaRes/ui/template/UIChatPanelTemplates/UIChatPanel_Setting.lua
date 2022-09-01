---@class UIChatPanel_Setting:UIConfigPanel_PartBasic
local UIChatPanel_Setting = {}
setmetatable(UIChatPanel_Setting, luaComponentTemplates.UIConfigPanel_PartBasic)

--region 初始化
function UIChatPanel_Setting:Init()
    self.Config = CS.CSScene.MainPlayerInfo.ConfigInfo
    self:InitComponent()
    self:BindEvents()
    self:InitDefaultState()
end

function UIChatPanel_Setting:InitComponent()
   self.voice_GameObject = self: Get("Root/Voice","Transform")
end

function UIChatPanel_Setting:BindEvents()
    self:SetToogle(self.voice_GameObject, "tg_world", CS.EConfigOption.AutoPlayerVoice_World)
    self:SetToogle(self.voice_GameObject, "tg_team", CS.EConfigOption.AutoPlayerVoice_Team)
    self:SetToogle(self.voice_GameObject, "tg_gang", CS.EConfigOption.AutoPlayerVoice_Union)
    self:SetToogle(self.voice_GameObject, "tg_private", CS.EConfigOption.AutoPlayerVoice_Private)
end

function UIChatPanel_Setting:InitDefaultState()
    self:GetToogle(self.voice_GameObject, "tg_world", CS.EConfigOption.AutoPlayerVoice_World)
    self:GetToogle(self.voice_GameObject, "tg_team", CS.EConfigOption.AutoPlayerVoice_Team)
    self:GetToogle(self.voice_GameObject, "tg_gang", CS.EConfigOption.AutoPlayerVoice_Union)
    self:GetToogle(self.voice_GameObject, "tg_private", CS.EConfigOption.AutoPlayerVoice_Private)
    self:InitRefresh()
end
--endregion

return UIChatPanel_Setting