---@class UIMemberPageTemplate:TemplateBase 会员左侧页签模板
local UIMemberPageTemplate = {}

function UIMemberPageTemplate:Init(panel, data)
    self.panel = panel
    ---@type TABLE.cfg_member
    self.tblData = data
    self:InitComponent()
    self:BindUIEvents()
end

function UIMemberPageTemplate:InitComponent()
    self.backLabel = self:Get("background/Label", "Top_UILabel")
    self.checkLabel = self:Get("checkmark/Label", "Top_UILabel")
    self.redPoint = self:Get("redPoint", "GameObject")
    self.toggle = self:Get("", "Top_UIToggle")
end

function UIMemberPageTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self.panel.mCurChooseLevel = self.tblData:GetId()
        self.panel:ChooseMemberPageToRefresh()
    end
end

function UIMemberPageTemplate:RefreshUI()
    self.backLabel.text = self.tblData:GetName()
    self.checkLabel.text = self.tblData:GetName()

    local result = self.panel:GetLuaMemberInfo():GetPlayerMemberLevel() >= self.tblData.id and Utility.IsContainsValue(self.panel:GetLuaMemberInfo():GetPlayerMemberInfo().receivedLevelReward, self.tblData.id) == false
    self.redPoint:SetActive(result)
end

function UIMemberPageTemplate:SetDefeaultChoose()
    self.toggle:Set(true)
end

function ondestroy()

end

return UIMemberPageTemplate