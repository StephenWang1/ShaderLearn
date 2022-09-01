---@class UIShareRankPrefixFeatureTemplate:UIRankPrefixFeatureTemplate 联服战勋排行榜
local UIShareRankPrefixFeatureTemplate = {}
setmetatable(UIShareRankPrefixFeatureTemplate, luaclass.UIRankPrefixFeatureTemplate)
function UIShareRankPrefixFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankName() ~= nil and self.rankData ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankName()
        ---获取服务器大区前缀
        local LianFuPrefix =  luaclass.RemoteHostDataClass:GetLianFuRankNameFormatByHostId(self.rankData.sid)
        self.unitTbl:GetRankName().text = LianFuPrefix..' '..self.rankData.name
        self.unitTbl:GetRankName().gameObject:SetActive(self:IsShowRankName())
    end
end
return UIShareRankPrefixFeatureTemplate
