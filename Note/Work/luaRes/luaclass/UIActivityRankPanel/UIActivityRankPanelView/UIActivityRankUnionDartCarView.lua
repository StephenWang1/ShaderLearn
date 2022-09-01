---@class UIActivityRankUnionDartCarView:UIActivityRankViewBase
local UIActivityRankUnionDartCarView = {}
setmetatable(UIActivityRankUnionDartCarView, luaclass.UIActivityRankViewBase)

function UIActivityRankUnionDartCarView:InitParameters()
    self:RunBaseFunction('InitParameters')
    self.DefendUnionDartCarRankNetMessage = function()
        self:RefreshAllRankMiddle()
        self:SetTitle()
        self:RefreshMyRank()
    end
    self.ResLikeMessageCallback = function(id, csdata)
        if csdata then
            if csdata.activityId == luaEnumActivityTypeByActivityTimeTable.DartCar then
                self:RefreshTempalte(csdata.rid)
                self:RefreshTempalte(csdata.trigger)
            end
        end
    end
end

function UIActivityRankUnionDartCarView:BindNetEvents()
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionCartRankMessage, self.DefendUnionDartCarRankNetMessage)
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
end

--重写设置title
function UIActivityRankUnionDartCarView:SetTitle()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local mainPlayerUnionDartCarInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.MainPlayerUnionDartCarInfo
    if mainPlayerUnionDartCarInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.ActivityInfo.ShowLikeRole == false then
        self.title.text = self.tabelInfo.activityTitle
    else
        local unionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo
        if unionInfo == nil or unionInfo.UnionID == 0 then
            self.title.text = self.tabelInfo.activityTitle
        else
            local combatStateText = ternary(CS.CSScene.MainPlayerInfo.ActivityInfo.UnionDartCarIsWin == true, "成功", "失败")
            local unionName = CS.CSScene.MainPlayerInfo.UIUnionName
            self.title.text = string.format(self.tabelInfo.title, unionName,combatStateText)
        end
    end
end

--重写刷新名次
function UIActivityRankUnionDartCarView:RefreshMyRank()
    local mainPlayerUnionDartCarInfo = CS.CSScene.MainPlayerInfo.ActivityInfo.MainPlayerUnionDartCarInfo
    if mainPlayerUnionDartCarInfo == nil then
        return
    end
    if self.curFeatureId == LuaEnumActivityRankComponentType.Ranking then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankGrade)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.PlayerName then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankGrade)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.DartDistance then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankDis)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.KillPlayer then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankKill)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Dead then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankDied)
    elseif self.curFeatureId == LuaEnumActivityRankComponentType.Score then
        self.myNum.text = mainPlayerUnionDartCarInfo.rankGrade == 0 and '未上榜' or tostring(mainPlayerUnionDartCarInfo.rankGrade)
    else
        self.myNum.text = ''
    end
end

--重写处理数据
function UIActivityRankUnionDartCarView:ParsData()
    -- 1：为左视图 2：为右视图
    self.data = {}
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    --拿到客户端数据的list
    local mainPlayerList = CS.CSScene.MainPlayerInfo.ActivityInfo:GetUnionDartCarList(self.curTopIndex, 1)
    if mainPlayerList ~= nil then
        self.data[1] = mainPlayerList
    end
    local otherList = CS.CSScene.MainPlayerInfo.ActivityInfo:GetUnionDartCarList(self.curTopIndex, 2)
    if otherList ~= nil then
        self.data[2] = otherList
    end
end

function UIActivityRankUnionDartCarView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResUnionCartRankMessage, self.DefendUnionDartCarRankNetMessage)
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.ResLikeMessageCallback)
end

function UIActivityRankUnionDartCarView:Clear()
    self:RunBaseFunction('Clear')
    self.DefendUnionDartCarRankNetMessage = nil
    self.ResLikeMessageCallback = nil
end
return UIActivityRankUnionDartCarView