---@class UIShareRankServantFeatureTemplate:UIRankServantFeatureTemplate 联服灵兽榜
local UIShareRankServantFeatureTemplate = {}
setmetatable(UIShareRankServantFeatureTemplate, luaclass.UIRankServantFeatureTemplate)
function UIShareRankServantFeatureTemplate:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetRankName() ~= nil and self.rankData ~= nil then
        self.unitTbl.promptPoint = self.unitTbl:GetRankName()
        ---获取服务器大区前缀
        local LianFuPrefix = luaclass.RemoteHostDataClass:GetLianFuRankNameFormatByHostId(self.rankData.sid)
        self.unitTbl:GetRankName().text = LianFuPrefix..' '..self.rankData.name
        self.unitTbl:GetRankName().gameObject:SetActive(self:IsShowRankName())
    end
end
return UIShareRankServantFeatureTemplate