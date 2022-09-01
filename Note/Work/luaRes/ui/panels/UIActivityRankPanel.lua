---@class UIActivityRankPanel:UIBase
local UIActivityRankPanel = {}

--region 局部变量
--endregion

--region 初始化

function UIActivityRankPanel:Init()
    self:InitParameters()
end

--- 初始化变量
function UIActivityRankPanel:InitParameters()
    self.closeCallback = nil
    self.refreshCallBack = nil
    self.IenumRefreshTime = nil
    self.RankClass = nil
    self.waitTime = 30
    self.id = 0
end
---@param customData table
---{
---@field id number cfg_activity_leaderboardId or LuaEnuActivityRankID
---@field closeCallback function 关闭回调
---@field refreshCallBack function 刷新接口可空
---}
function UIActivityRankPanel:Show(customData)
    if customData and customData.id then
        if self.id ~= customData.id then
            if self.RankDemo ~= nil then
                self.RankDemo:Clear()
                self.RankDemo = nil
            end
            local RankClass = luaclass[uiStaticParameter.ActivityRankPanelViewClass[customData.id]]
            if RankClass == nil then
                RankClass = luaclass.UIActivityRankViewBase
            end
            self.RankDemo = RankClass:NewWithGO(self.go, self)
            self.id = customData.id
        end

        self.RankDemo:SetUI(customData.id)
        self.RankDemo:RefreshMyRank()

        self.closeCallback = customData.closeCallback
        self.refreshCallBack = customData.refreshCallBack

        if self.IenumRefreshTime ~= nil then
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        end
        if self.refreshCallBack ~= nil then
            self.IenumRefreshTime = StartCoroutine(self.IEnumUpdataTime, self)
        end
    end
end

function UIActivityRankPanel:RefreshMyRank(myRankId)
    if self.RankDemo ~= nil then
        self.RankDemo:RefreshMyRank(myRankId)
    end

end

function UIActivityRankPanel:RefreshAllRankMiddle()
    if self.RankDemo ~= nil then
        self.RankDemo:RefreshAllRankMiddle()
    end
end

--endregion


--region 网络消息处理

--endregion

--region otherFunc

function UIActivityRankPanel:IEnumUpdataTime()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self.waitTime))
    if self.refreshCallBack ~= nil then
        self.refreshCallBack()
    end
end

function UIActivityRankPanel:Clear()
    if self.closeCallback ~= nil then
        self.closeCallback()
    end
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if self.RankDemo ~= nil then
        self.RankDemo:Clear()
        self.RankDemo = nil
    end
    self:ReSetActivityRankTimeStamp()
end

--endregion

function UIActivityRankPanel:ReSetActivityRankTimeStamp()
    uiStaticParameter.CurDefendKingTimeStamp = 0

    uiStaticParameter.CurHUANJINGTimeStamp = 0

    uiStaticParameter.CurUnionDartCarActivityTime = 0

    uiStaticParameter.CurGoddessActivityTime = 0

    uiStaticParameter.CurBuDouKaiActivityTime = 0
end

--region ondestroy

function ondestroy()
    UIActivityRankPanel:Clear()
end

return UIActivityRankPanel