---@class UIActivityRankGoddlessView:UIActivityRankViewBase 女神赐福活动排行榜视图
local UIActivityRankGoddlessView = {};

setmetatable(UIActivityRankGoddlessView, luaclass.UIActivityRankViewBase);



function UIActivityRankGoddlessView:ParsData()
    self.data = {}
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    ---拿到客户端数据的list
    local settleList = CS.CSScene.MainPlayerInfo.ActivityInfo.GoddessList
    if settleList.Count == 0 then
        return
    end
    CS.CSScene.MainPlayerInfo.ActivityInfo:SortGoddessList(self.curIndex)
    if settleList ~= nil then
        self.data[1] = settleList
    end
end

function UIActivityRankGoddlessView:RefreshMyRank()
   --CS.CSScene.MainPlayerInfo.ActivityInfo:SortGoddessList()
   CS.CSScene.MainPlayerInfo.ActivityInfo:SortGoddessList(self.curIndex)
    local rank = CS.CSScene.MainPlayerInfo.ActivityInfo:GetMyRank()
    self.myNum.text = rank == 0 and "未上榜" or rank
end

--function UIActivityRankGoddlessView:BindUIEvents()
--    CS.UIEventListener.Get(self.closeBtn).onClick = function()
--        uimanager:ClosePanel('UIActivityPersonalRankPanel')
--    end
--end

--region 消息监听
function UIActivityRankGoddlessView:OnResLikeMessage(id, data)
    if data ~= nil then
        self:RefreshAllRankMiddle()
    end
end

---绑定消息监听
function UIActivityRankGoddlessView:BindNetEvents()
    self.OnResLikeMessageBack = function(id, data)
        self:OnResLikeMessage(id, data)
    end
    self.mPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLikeMessage, self.OnResLikeMessageBack)
end

---移除消息监听
function UIActivityRankGoddlessView:RemoveNetEvents()
    self.mPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResLikeMessage, self.OnResLikeMessageBack)
end

---是否显示敌方我方标签
function UIActivityRankGoddlessView:IsShowBookMark()
    return false
end

function UIActivityRankGoddlessView:Clear()
    self:RunBaseFunction('Clear')
    self.OnResLikeMessageBack = nil
end

return UIActivityRankGoddlessView;