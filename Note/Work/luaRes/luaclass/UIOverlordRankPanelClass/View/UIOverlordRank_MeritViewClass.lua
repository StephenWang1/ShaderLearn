---@class UIOverlordRank_MeritViewClass:UIOverlordRank_UnionViewClass 建功立业视图
local UIOverlordRank_MeritViewClass = {}
setmetatable(UIOverlordRank_MeritViewClass, luaclass.UIOverlordRank_UnionViewClass)

function UIOverlordRank_MeritViewClass:InitParam()
    self:RunBaseFunction("InitParam")
    self.curScrollViewPos = { x = -82, y = 160, z = 0 }
end

function UIOverlordRank_MeritViewClass:GetRankList()
    return self.rankInfo ~= nil and self.rankInfo.OverlordMeritList or nil
end

return UIOverlordRank_MeritViewClass