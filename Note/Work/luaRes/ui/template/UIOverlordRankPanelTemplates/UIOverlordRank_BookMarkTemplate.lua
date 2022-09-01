---@class UIOverlordRank_BookMarkTemplate:UIContendRank_BookMarkTemplate 霸业标签
local UIOverlordRank_BookMarkTemplate = {}
setmetatable(UIOverlordRank_BookMarkTemplate, luaComponentTemplates.UIContendRank_BookMarkTemplate)

function UIOverlordRank_BookMarkTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
end

function UIOverlordRank_BookMarkTemplate:InitUI()
    if self.tblInfo ~= nil then
        self.Label.text = self.tblInfo.tabName
        self.checkMarkLabel.text = self.tblInfo.tabName
        self:SetRedPoint()
    end
end

function UIOverlordRank_BookMarkTemplate:GetTblInfo()
    _, self.tblInfo = CS.Cfg_OverlordTableManager.Instance.dic:TryGetValue(self.id)
end

function UIOverlordRank_BookMarkTemplate:SetRedPoint()
    if self.redPoint ~= nil then
        self.redPoint:RemoveRedPointKey()
        self.redPoint:AddRedPointKey(23000 + self.id)
    end
end

return UIOverlordRank_BookMarkTemplate