---@class UIActivityRankDreamLandMazeView:UIActivityRankViewBase
local UIActivityRankDreamLandMazeView = {}
setmetatable(UIActivityRankDreamLandMazeView, luaclass.UIActivityRankViewBase)

function UIActivityRankDreamLandMazeView:InitParameters()
    self:RunBaseFunction('InitParameters')
    self.DreamLandMazeRankNetMessage = function()
        self:RefreshAllRankMiddle()
        self:SetTitle()
        self:RefreshMyRank()
    end
    self.ResLikeMessageCallback = function(id, csdata)
        if csdata then
            if csdata.activityId == luaEnumActivityTypeByActivityTimeTable.DreamlandMaze then
                self:RefreshTempalte(csdata.rid)
                self:RefreshTempalte(csdata.trigger)
            end
        end
    end
end

function UIActivityRankDreamLandMazeView:BindNetEvents()
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerActivityDataRankMessage, self.DreamLandMazeRankNetMessage)
end

function UIActivityRankDreamLandMazeView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResPlayerActivityDataRankMessage, self.DreamLandMazeRankNetMessage)
end

--重写刷新名次
function UIActivityRankDreamLandMazeView:RefreshMyRank()
    CS.CSScene.MainPlayerInfo.ActivityInfo:SortDreamLandList(self.curFeatureId)
    local rank = CS.CSScene.MainPlayerInfo.ActivityInfo:GetMyRankInDreamLand()
    self.myNum.text = rank == 0 and "未上榜" or rank
end

function UIActivityRankDreamLandMazeView:Clear()
    self:RunBaseFunction('Clear')
    self.DreamLandMazeRankNetMessage = nil
    self.ResLikeMessageCallback = nil
end

return UIActivityRankDreamLandMazeView