---@class UIShareRankNormalFeatureTemplate:UIRankNormalFeatureTemplate 联服等级榜攻击榜
local UIShareRankNormalFeatureTemplate = {}
setmetatable(UIShareRankNormalFeatureTemplate, luaclass.UIRankNormalFeatureTemplate)
function UIShareRankNormalFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankName() ~= nil and self.rankData ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankName()
        ---获取服务器大区前缀
        local LianFuPrefix = luaclass.RemoteHostDataClass:GetLianFuRankNameFormatByHostId(self.rankData.sid)
        self.unitTbl:GetRankName().text = LianFuPrefix..' '..self.rankData.name
        self.unitTbl:GetRankName().gameObject:SetActive(self:IsShowRankName())
    end
end

function UIShareRankNormalFeatureTemplate:OnTemplatBtnClick(target, go)
    if target.rankData == nil then
        return
    end
    ---@type UIRankPanel
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel then
        panel.OnHideReward(nil)
        panel.RefreshModelView(target.rid, target.rankData)
    end
end
return UIShareRankNormalFeatureTemplate