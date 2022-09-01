---@class UIGuildBenefitsPanel_ActiveDetailsGridTemplate:TemplateBase 帮会贡献明细格子模板
local UIGuildBenefitsPanel_ActiveDetailsGridTemplate = {}

---@param  panel UIGuildBenefitsPanel
function UIGuildBenefitsPanel_ActiveDetailsGridTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitComponent()
end

function UIGuildBenefitsPanel_ActiveDetailsGridTemplate:InitComponent()
    ---@type UILabel
    ---单个任务贡献度
    self.mPerContribute_UILabel = self:Get("count", "UILabel")

    ---@type UILabel
    ---任务描述
    self.mActiveDes_UILabel = self:Get("info", "UILabel")

    ---@type UILabel
    ---进度
    self.mProgress_UILabel = self:Get("progress", "UILabel")

    ---@type UISprite
    ---背景图片
    self.mBg_UISprite = self:Get("di1", "UISprite")
end

---刷新贡献显示
function UIGuildBenefitsPanel_ActiveDetailsGridTemplate:Refresh(details, line)
    if details == nil then
        return
    end
    local activeInfo = self:GetUnionActiveInfo(details.id)

    local num = details.count
    if activeInfo then
        if not CS.StaticUtility.IsNull(self.mPerContribute_UILabel) then
            self.mPerContribute_UILabel.text = "+" .. activeInfo.active
        end
        if not CS.StaticUtility.IsNull(self.mActiveDes_UILabel) then
            self.mActiveDes_UILabel.text = activeInfo.des1
        end
        if not CS.StaticUtility.IsNull(self.mProgress_UILabel) then
            local maxNum = activeInfo.times
            local des = activeInfo.des2
            local show
            if maxNum and maxNum > 0 then
                show = string.format(des, num, maxNum)
            else
                show = string.format(des, num)
            end
            self.mProgress_UILabel.text = show
        end
    end
    if line then
        --[[        if not CS.StaticUtility.IsNull(self.mBg_UISprite) then
                      self.mBg_UISprite.color = (line % 2 == 0) and LuaEnumUnityColorType.Transparent or LuaEnumUnityColorType.Normal
                end]]
    end
end

---@return TABLE.CFG_UNION_ACTIVE 活动详情
function UIGuildBenefitsPanel_ActiveDetailsGridTemplate:GetUnionActiveInfo(activeId)
    if self.mRootPanel then
        return self.mRootPanel:GetUnionActiveInfo(activeId)
    end
end

return UIGuildBenefitsPanel_ActiveDetailsGridTemplate