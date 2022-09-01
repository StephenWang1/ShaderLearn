local UISkillConfigTemplate = {}
UISkillConfigTemplate.id = 0
function UISkillConfigTemplate:ID()
    return self.id
end
function UISkillConfigTemplate:SkillName_UILabel()
    if self.mSkillName ~= false then
        self.mSkillName = self:Get("skillName", "UILabel")
    end
    return self.mSkillName
end
function UISkillConfigTemplate:SkillIcon_UISprite()
    if self.mSkillIcon ~= false then
        self.mSkillIcon = self:Get("skillIcon", "UISprite")
    end
    return self.mSkillIcon
end
function UISkillConfigTemplate:BagItemIcon_UISprite()
    if self.mItemIcon ~= false then
        self.mItemIcon = self:Get("icon", "UISprite")
    end
    return self.mItemIcon
end



---刷新技能
function UISkillConfigTemplate:RefreshUI(id)
    self.id = id
    local tableInfo = CS.Cfg_SkillTableManager.Instance[id]
    self:SkillIcon_UISprite().spriteName = tableInfo.icon
    self:SkillName_UILabel().text = '[c4b88e]' .. tableInfo.name

end

---刷新道具
function  UISkillConfigTemplate:RefreshItemUI(id)
    self.id = id
    local tableInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(id)
    self:BagItemIcon_UISprite().spriteName = tableInfo.icon
end

return UISkillConfigTemplate