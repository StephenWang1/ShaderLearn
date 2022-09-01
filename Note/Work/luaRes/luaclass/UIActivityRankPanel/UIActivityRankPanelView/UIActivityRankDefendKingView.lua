---@class UIActivityRankDefendKingView:UIActivityRankViewBase
local UIActivityRankDefendKingView = {}
setmetatable(UIActivityRankDefendKingView, luaclass.UIActivityRankViewBase)

function UIActivityRankDefendKingView:InitParameters()
    self:RunBaseFunction('InitParameters')
    self.DefendkingRankNetMessage = function()
        self:RefreshAllRankMiddle()
        self:SetTitle()
        self:RefreshMyRank()
    end
    self.DefendLastRankMessage = function()
        self:RefreshAllRankMiddle()
        self:SetTitle()
        self:RefreshMyRank()
    end
    self.ResLikeMessageCallback = function(id, csdata)
        if csdata then
            if csdata.activityId == 237 then
                self:RefreshTempalte(csdata.rid)
                self:RefreshTempalte(csdata.trigger)
            end
        end
    end
end

function UIActivityRankDefendKingView:BindNetEvents()
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDefendKingRankMessage, self.DefendkingRankNetMessage)
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDefendLastRankMessage, self.DefendLastRankMessage)
end

--重写设置title
function UIActivityRankDefendKingView:SetTitle()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local defendRankState = CS.CSScene.MainPlayerInfo.ActivityInfo.defendRankState
    if defendRankState == 0 then
        return
    elseif defendRankState == 1 then
        self.title.text = self.tabelInfo.activityTitle
    elseif defendRankState == 2 then
        local title = string.Split(self.tabelInfo.title, '#')
        local UnionName = CS.CSScene.MainPlayerInfo.ActivityInfo.defendUnionName
        self.title.text = string.format(title[1], UnionName)
    elseif defendRankState == 3 then
        local title = string.Split(self.tabelInfo.title, '#')
        local defendKingOtherInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.defendKingOtherInfo
        if defendKingOtherInfo ~= nil then
            self.title.text = string.format(title[1], defendKingOtherInfo.lastFirstUnionName)
        end
    end
end

--重写刷新名次
function UIActivityRankDefendKingView:RefreshMyRank()
    local otherInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.defendKingOtherInfo
    if otherInfo == nil then
        return
    end
    if self.curFeatureId == LuaEnumActivityRankComponentType.Ranking then
        self.myNum.text = otherInfo.rankGrade == 0 and '未上榜' or tostring(otherInfo.rankGrade)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Score then
        self.myNum.text = otherInfo.rankGrade == 0 and '未上榜' or tostring(otherInfo.rankGrade)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.LowAssassin then
        self.myNum.text = otherInfo.rankSmall == 0 and '未上榜' or tostring(otherInfo.rankSmall)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.SeniorAssassin then
        self.myNum.text = otherInfo.rankBig == 0 and '未上榜' or tostring(otherInfo.rankBig)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.KillPlayer then
        self.myNum.text = otherInfo.rankKill == 0 and '未上榜' or tostring(otherInfo.rankKill)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Dead then
        self.myNum.text = otherInfo.rankDied == 0 and '未上榜' or tostring(otherInfo.rankDied)
    else
        self.myNum.text = ''
    end
end

--endregion

function UIActivityRankDefendKingView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResDefendKingRankMessage, self.DefendkingRankNetMessage)
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResDefendLastRankMessage, self.DefendLastRankMessage)
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
end

function UIActivityRankDefendKingView:Clear()
    self:RunBaseFunction('Clear')
    self.DefendkingRankNetMessage = nil
    self.DefendLastRankMessage = nil
    self.ResLikeMessageCallback = nil
end

return UIActivityRankDefendKingView