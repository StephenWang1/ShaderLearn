---@class UIActivityRankShaBaKView:UIActivityRankViewBase 沙巴克排行榜
local UIActivityRankShaBaKView = {};

setmetatable(UIActivityRankShaBaKView, luaclass.UIActivityRankViewBase)

UIActivityRankShaBaKView.mRankValue = -1;

function UIActivityRankShaBaKView:GetShaBaKRankType()
    return CS.duplicateV2.SabacRankType.Kill;
end

function UIActivityRankShaBaKView:InitParameters()
    self:RunBaseFunction('InitParameters')
    self.OnResSabacRankInfoMessage = function()
        self:RefreshAllRankMiddle()
        self:SetTitle()
    end
    self.OnResLikeMessageCallback = function(msgId, msgData)
        if msgData then
            if msgData.activityId == 101 then
                self:RefreshTempalte(msgData.rid)
                self:RefreshTempalte(msgData.trigger)
            end
        end
    end
end

function UIActivityRankShaBaKView:BindNetEvents()
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacRankInfoMessage, self.OnResSabacRankInfoMessage)
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.OnResLikeMessageCallback)
end

--重写设置title
function UIActivityRankShaBaKView:SetTitle()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local shaBaKRankState = CS.CSScene.MainPlayerInfo.DuplicateV2:GetShaBaKRankState();
    if shaBaKRankState == 0 then
        if (CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo ~= nil) then
            local leagueId = CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo.uniteType
            ---判断是否为联服
            if leagueId ~= 0 then
                local leagueTbl = clientTableManager.cfg_leagueManager:TryGetValue(leagueId)
                if leagueTbl and leagueTbl:GetName() then
                    self.title.text = string.format(self.tabelInfo.title, leagueTbl:GetName());
                end
            elseif CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo.unionName ~= "" then
                self.title.text = string.format(self.tabelInfo.title, CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBakInfo.unionName);
            else
                self.title.text = self.tabelInfo.activityTitle
            end
        else
            self.title.text = self.tabelInfo.activityTitle
        end
    elseif shaBaKRankState == 1 then
        ---判断是否为联服
        local leagueId = CS.CSScene.MainPlayerInfo.DuplicateV2.sabacRecordLeagueId
        if leagueId ~= 0 then
            local leagueTbl = clientTableManager.cfg_leagueManager:TryGetValue(leagueId)
            if leagueTbl and leagueTbl:GetName() then
                self.title.text = string.format(self.tabelInfo.title, leagueTbl:GetName());
            end
        elseif (CS.CSScene.MainPlayerInfo.Data.sabacUnionName ~= "") then
            self.title.text = string.format(self.tabelInfo.title, CS.CSScene.MainPlayerInfo.Data.sabacUnionName);
        else
            self.title.text = self.tabelInfo.activityTitle
        end
    end
end

--重写刷新名次
function UIActivityRankShaBaKView:RefreshMyRank()
    if self.mRankValue <= 0 then
        self.myNum.text = "未上榜";
        return
    end
    self.myNum.text = self.mRankValue;
end

--endregion

--重写处理数据
function UIActivityRankShaBaKView:ParseData()
    self.data = {}
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    --拿到客户端数据的list
    local mainPlayerList, otherList, mRankValue = CS.CSScene.MainPlayerInfo.DuplicateV2:GetSortShaBaKRank(self.curFeatureId, self:GetShaBaKRankType());
    self.mRankValue = mRankValue;
    if mainPlayerList ~= nil then
        self.data[1] = Utility.ListChangeTable(mainPlayerList);
    end

    if otherList ~= nil then
        self.data[2] = Utility.ListChangeTable(otherList);
    end

    self:RefreshMyRank()
end

function UIActivityRankShaBaKView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResSabacRankInfoMessage, self.OnResSabacRankInfoMessage)
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.OnResLikeMessageCallback)
end

function UIActivityRankShaBaKView:Clear()
    self:RunBaseFunction('Clear')
    self.OnResSabacRankInfoMessage = nil
    self.OnResLikeMessageCallback = nil;
end

return UIActivityRankShaBaKView;