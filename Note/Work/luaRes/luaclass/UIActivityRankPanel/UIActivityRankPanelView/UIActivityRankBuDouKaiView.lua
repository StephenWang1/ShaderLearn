---@class UIActivityRankBuDouKaiView:UIActivityRankViewBase
local UIActivityRankBuDouKaiView = {}

setmetatable(UIActivityRankBuDouKaiView, luaclass.UIActivityRankViewBase)

function UIActivityRankBuDouKaiView:InitParameters()
    self:RunBaseFunction('InitParameters')
    self.ResLikeMessageCallback = function(id, csdata)
        if csdata then
            if csdata.activityId == luaEnumActivityTypeByActivityTimeTable.BuDouKai then
                self:RefreshTempalte(csdata.rid)
                self:RefreshTempalte(csdata.trigger)
            end
        end
    end
end

function UIActivityRankBuDouKaiView:BindNetEvents()
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
end

function UIActivityRankBuDouKaiView:ParsData()
    self.data = {}
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    ---拿到客户端数据的list
    local settleList = CS.CSScene.MainPlayerInfo.ActivityInfo:GetBuDouKaiList(self.curTopIndex)
    if settleList.Count == 0 then
        return
    end
    if settleList ~= nil then
        self.data[1] = settleList
    end
end

function UIActivityRankBuDouKaiView:IsShowBookMark()
    return false
end

---刷新名次
function UIActivityRankBuDouKaiView:RefreshMyRank()
    local mainPlayerBuDouKaiSettleInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.MainPlayerRankInfo
    if mainPlayerBuDouKaiSettleInfo == nil then
        self.myNum.text = '未上榜'
        return
    end
    local rankIndex = self:GetMainPlayerRank()
    if self.curFeatureId == LuaEnumActivityRankComponentType.Ranking then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and '未上榜' or tostring(mainPlayerBuDouKaiSettleInfo.rank)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.PlayerName then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and '未上榜' or tostring(mainPlayerBuDouKaiSettleInfo.rank)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.KillPlayer then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and rankIndex ~= nil and '未上榜' or tostring(rankIndex)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Dead then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and '未上榜' or tostring(mainPlayerBuDouKaiSettleInfo.rank)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Reward then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and '未上榜' or tostring(mainPlayerBuDouKaiSettleInfo.rank)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Like then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and '未上榜' or tostring(mainPlayerBuDouKaiSettleInfo.rank)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.BetRate then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and rankIndex ~= nil and '未上榜' or tostring(rankIndex)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.BetAmount then
        self.myNum.text = mainPlayerBuDouKaiSettleInfo.rank == 0 and rankIndex ~= nil and '未上榜' or tostring(rankIndex)
    else
        self.myNum.text = ''
    end
end

function UIActivityRankBuDouKaiView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
end

function UIActivityRankBuDouKaiView:Clear()
    self:RunBaseFunction('Clear')
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityInfo.BuDouKaiShowLike = false
    end
end

return UIActivityRankBuDouKaiView