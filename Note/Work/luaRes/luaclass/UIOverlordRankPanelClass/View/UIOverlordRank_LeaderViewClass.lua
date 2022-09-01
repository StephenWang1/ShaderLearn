---@class UIOverlordRank_LeaderViewClass:UIOverlordRank_UnionViewClass    领袖之路视图
local UIOverlordRank_LeaderViewClass = {}
setmetatable(UIOverlordRank_LeaderViewClass, luaclass.UIOverlordRank_UnionViewClass)

function UIOverlordRank_LeaderViewClass:RefreshView()
    --更新图片
    self.tbl.sprite.spriteName = self.overlordTbl.head
    local strs = string.Split(self.overlordTbl.des, '#')
    local str = ''
    --更新标语
    if CS.CSScene.MainPlayerInfo ~= nil then
        local unionId = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID
        if unionId == 0 then
            str = strs[2]
        else
            str = string.format(strs[1], CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionName)
        end
    end
    self.tbl.decs.text = str

end

function UIOverlordRank_LeaderViewClass:InitParam()
    self:RunBaseFunction("InitParam")
    self.curWight = 98
end

function UIOverlordRank_LeaderViewClass:GetRankList()
    return self.rankInfo ~= nil and self.rankInfo.OverlordLeaderList or nil
end

function UIOverlordRank_LeaderViewClass:RefreshRankView()
    self:RunBaseFunction("RefreshRankView")
    self:RankJump()
end

---跳转至主角行
function UIOverlordRank_LeaderViewClass:RankJump()
    if self.tbl.scrollViewSpring == nil then
        return
    end
    ----先移动
    local myIndex = self:GetReceiveRewardLine() - 4
    if myIndex > 0 then
        local v3 = self.tbl.rankGrid:GetJumpToLineV3(myIndex)
        self.tbl.scrollViewSpring.target = CS.UnityEngine.Vector3(v3.x, v3.y, v3.z)
        self.tbl.scrollViewSpring.enabled = true
    end
end

---获取可领奖行数
function UIOverlordRank_LeaderViewClass:GetReceiveRewardLine()
    if self.rankList ~= nil and CS.CSScene.MainPlayerInfo ~= nil then
        for i = 0, self.rankList.Count - 1 do
            if self.rankList[i].receiveType == 1 and self.rankList[i].rid == CS.CSScene.MainPlayerInfo.ID then
                return i + 1
            end
        end
    end
    return 0
end

return UIOverlordRank_LeaderViewClass