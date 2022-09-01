---@class UIGuildListPanel_GirdTemplate:TemplateBase 帮会列表模板
local UIGuildListPanel_GirdTemplate = {}

function UIGuildListPanel_GirdTemplate:GetBagInfoV2()
    if self.GuildListPanel then
        return self.GuildListPanel:GetBagInfoV2()
    end
end

function UIGuildListPanel_GirdTemplate:GetUnionInfoV2()
    if self.GuildListPanel then
        return self.GuildListPanel:GetUnionInfoV2()
    end
end

function UIGuildListPanel_GirdTemplate:Init(panel, item)
    ---@type UIGuildListPanel
    self.GuildListPanel = panel
    self:InitComponent()
    self:BindEvent()
end

function UIGuildListPanel_GirdTemplate:InitComponent()
    ---@type UILabel
    ---排行文本
    self.rankLabel_UILabel = self:Get("lb_index", "UILabel")

    ---@type UILabel
    ---帮会名字
    self.unionName_UILabel = self:Get("lb_guild", "UILabel")

    ---@type UILabel
    ---帮会活跃
    self.active_UILabel = self:Get("lb_active", "UILabel")

    ---@type UISprite
    ---背景图片
    self.bg_UISprite = self:Get("bg", "UISprite")
end

function UIGuildListPanel_GirdTemplate:BindEvent()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.unionInfo then
            uimanager:CreatePanel("UIPromptGuildApplicationPanel", nil, self.unionInfo)
        end
    end
end

---@param data unionV2.UnionInfo
function UIGuildListPanel_GirdTemplate:RefreshItem(data, line)
    self.unionInfo = data
    if not CS.StaticUtility.IsNull(self.unionName_UILabel) then
        self.unionName_UILabel.text = data.unionName
    end

    if not CS.StaticUtility.IsNull(self.rankLabel_UILabel) then
        self.rankLabel_UILabel.text = data.rank
    end

    if not CS.StaticUtility.IsNull(self.active_UILabel) then
        local unionMember = data.unionNum
        local limitMember = CS.Cfg_GlobalTableManager.Instance:GetMemberLimit()
        local showInfo = unionMember
        if limitMember ~= 0 then
            local color = ternary(unionMember > limitMember, luaEnumColorType.Red1, "")
            showInfo = color .. unionMember .. "/" .. limitMember
        end
        self.active_UILabel.text = showInfo
    end

    --背景颜色设置
    if not CS.StaticUtility.IsNull(self.bg_UISprite) then
        local color = ternary(line % 2 == 0, LuaEnumUnityColorType.Transparent, LuaEnumUnityColorType.Normal)
        self. bg_UISprite.color = color
    end
end

return UIGuildListPanel_GirdTemplate