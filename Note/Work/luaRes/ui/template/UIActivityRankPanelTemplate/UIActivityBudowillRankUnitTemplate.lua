---@class UIActivityBudowillRankUnitTemplate:UIActivityRankUnit 武道会单元
local UIActivityBudowillRankUnitTemplate = {}

setmetatable(UIActivityBudowillRankUnitTemplate, luaComponentTemplates.UIActivityRankUnitTemplate)

function UIActivityBudowillRankUnitTemplate:InitComponents()

    self.killNum = self:Get("Tabel/firstValue", 'Top_UILabel')
    self.rankingSprite = self:Get("Tabel/rankingSprite", 'Top_UISprite')
    self.rankingValue = self:Get("Tabel/rankingValue", 'Top_UILabel')

    self.name = self:Get("name", 'Top_UILabel')
    self.Mvp = self:Get("Mvp", 'UISprite')
    self.integral = self:Get("Mvp/num", 'Top_UILabel')
    self.integralTween = self:Get("Mvp/num", 'TweenPosition')
    self.likeSprite = self:Get("dianZan", 'UISprite')
    self.likeNum = self:Get("dianZan/num", 'Top_UILabel')
    self.likeTween = self:Get("dianZan", 'TweenPosition')
    self.bg = self:Get('Background', 'Top_UISprite')
    self.titleBg = self:Get('Mvp/bg', 'Top_UISprite')
    self.itemGrid = self:Get('itemGrid', 'Top_UIGridContainer')
    self.MyBackground = self:Get('MyBackground', 'GameObject')
end

function UIActivityBudowillRankUnitTemplate:Clear()
    self:RunBaseFunction('Clear')
    self.itemGrid = nil
    self.rankingSprite= nil
    self.rankingValue = nil
end

return UIActivityBudowillRankUnitTemplate