---@class UIActivityRankUnitFeatureBase 活动排行榜单元功能基类
local UIActivityRankUnitFeatureBase = {}

function UIActivityRankUnitFeatureBase:Show(target)
    if target == nil then
        return
    end
    ---@type table 目标即单元模板(UIActivityRankUnitTemplate)
    self.tbl = target
    ---@type ActivitySettleBaseVO 当前单元结算数据
    self.settleInfo = target.settleInfo
    self:BindUIMessage()
    self:RefreshUI()
end

function UIActivityRankUnitFeatureBase:BindUIMessage()
    if self:IsShowLike() then
        if self.tbl:GetLikeSprite() ~= nil then
            CS.UIEventListener.Get(self.tbl:GetLikeSprite().gameObject).LuaEventTable = self
            CS.UIEventListener.Get(self.tbl:GetLikeSprite().gameObject).OnClickLuaDelegate = self.OnLikeBtnClick
        end
    end
end

function UIActivityRankUnitFeatureBase:RefreshUI()
    self:SetUnitView()
    self:RefreshIntegral()
    self:RefreshLike()
    self:RefreshTitle()
    self:SetAllIcon()
    self:RefreshOtherView()
    self:SetUnitComponentPos()
    self:SetTweenPos()
    self.tbl.go:SetActive(true)
end

---设置单元视图
---@public
function UIActivityRankUnitFeatureBase:SetUnitView()
    if self.tbl:GetRankingValue() ~= nil then
        self.tbl:GetRankingValue().text = self.tbl.Line > 3 and tostring(self.tbl.Line) or ''
        self.tbl:GetRankingValue().gameObject:SetActive(self.tbl.Line > 3)
    end
    if self.tbl:GetRankingSprite() ~= nil then
        self.tbl:GetRankingSprite().spriteName = self.tbl.Line <= 3 and tostring(self.tbl.Line) or ''
        self.tbl:GetRankingSprite().gameObject:SetActive(self.tbl.Line <= 3)
    end
    if self.tbl:GetRankPlayerName() ~= nil then
        self.tbl:GetRankPlayerName().text = self:GetName()
        self.tbl:GetRankPlayerName().gameObject:SetActive(self:IsShowPlayerName())
    end
    if self.tbl:GetLikeSprite() ~= nil then
        self.tbl:GetLikeSprite().gameObject:SetActive(self:IsShowLike())
    end

    if self:IsShowTitle() and self.tbl:GetMvpSprite() ~= nil then
        self.tbl:GetMvpSprite().gameObject:SetActive(true)
    end
end

---设置单元位置
---@public
function UIActivityRankUnitFeatureBase:SetUnitComponentPos()
    if self.tbl:GetRankingValue() ~= nil then
        local origionPos = self.tbl:GetRankingValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Ranking)
        self.tbl:GetRankingValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankingSprite() ~= nil then
        local origionPos = self.tbl:GetRankingSprite().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Ranking)
        self.tbl:GetRankingSprite().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankPlayerName() ~= nil then
        local origionPos = self.tbl:GetRankPlayerName().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.PlayerName)
        self.tbl:GetRankPlayerName().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetLikeSprite() ~= nil then
        local origionPos = self.tbl:GetLikeSprite().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Like)
        self.tbl:GetLikeSprite().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self:IsShowTitle() and self.tbl:GetMvpSprite() ~= nil then
        local origionPos = self.tbl:GetMvpSprite().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Score)
        self.tbl:GetMvpSprite().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
end

function UIActivityRankUnitFeatureBase:SetTweenPos()
    if self.tbl:GetMvpTween() ~= nil then
        local origionTo = self.tbl:GetMvpTween().to
        local origionFrom = self.tbl:GetMvpTween().from
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Score)
        self.tbl:GetMvpTween().to = { x = posx, y = origionTo.y, 0 }
        self.tbl:GetMvpTween().from = { x = posx, y = origionFrom.y, 0 }
    end

    if self.tbl:GetLikeTween() ~= nil then
        local origionTo = self.tbl:GetLikeTween().to
        local origionFrom = self.tbl:GetLikeTween().from
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Like)
        local likeBtnOffset = self:GetLikeOffsetValue()
        self.tbl:GetLikeTween().to = { x = posx, y = origionTo.y, 0 }
        self.tbl:GetLikeTween().from = { x = posx, y = origionFrom.y, 0 }

        local likeType = self:GetLikeSprite(self.settleInfo)
        if likeType == LuaEnumActivityLikeType.NormalPraise or likeType == LuaEnumActivityLikeType.MutualPraise then
            self.tbl:GetLikeTween():PlayReverse()
        else
            self.tbl:GetLikeTween():PlayForward()
        end
    end
end

function UIActivityRankUnitFeatureBase:RefreshOtherView ()
    if self.tbl.MyBackground ~= nil and not CS.StaticUtility.IsNull(self.tbl.MyBackground) then
        self.tbl.MyBackground:SetActive(self.settleInfo ~= nil and self.settleInfo.rid == CS.CSScene.MainPlayerInfo.ID)
    end
end

--刷新点赞
function UIActivityRankUnitFeatureBase:RefreshLike()

end

--刷新称号
function UIActivityRankUnitFeatureBase:RefreshTitle()

end

--刷新评分
function UIActivityRankUnitFeatureBase:RefreshIntegral()
    if self.tbl:GetMvpNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetMvpNum().gameObject) then
        --四舍五入 取值
        local intergralNum = Utility.FloatRounding((self.settleInfo.integral / 1000), 1)
        --显示保留一位小数
        self.tbl:GetMvpNum().text = string.format('%.1f', intergralNum)
    end
end

---尝试设置icon(后续借口)
---@public
function UIActivityRankUnitFeatureBase:SetAllIcon()

end

--region UI函数回调

--点击详情按钮回调
function UIActivityRankUnitFeatureBase:OnDetailsBtnClick()
    uimanager:CreatePanel("UIActivityInformationPanel", nil, { settleInfo = self.tbl.settleInfo, rankId = self.tbl.leaderboardID })
end
--点击点赞图标
function UIActivityRankUnitFeatureBase:OnLikeBtnClick(go)
    --发送服务器消息
end


--endregion

--region otherFunction

---获取组件位置信息
function UIActivityRankUnitFeatureBase:GetComponentPosx(type)
    local info = CS.Cfg_activity_leaderboardTableManager.Instance:GetSystemComponentInfo(self.tbl.leaderboardID, type)
    return info == nil and 0 or info.posx
end

--显示获得称号
function UIActivityRankUnitFeatureBase:GetRankTiTle()
    return self.tbl.settleInfo:GetTitle()
end

--获得点赞图标
function UIActivityRankUnitFeatureBase:GetLikeSprite(settleInfo)

end

function UIActivityRankUnitFeatureBase:GetColorEnum(type)
    return (self.curFeatureId ~= nil and self.curFeatureId == type) and luaEnumColorType.White or luaEnumColorType.Gray
end

--获取icon
function UIActivityRankUnitFeatureBase:GetIconSpriteName(index)
    return (self.tbl.icons ~= nil and #self.tbl.icons >= index) and self.tbl.icons[index] or ""
end

function UIActivityRankUnitFeatureBase:GetMvpBgSprite(isLeft, isHaveTitle)
    if isLeft then
        return isHaveTitle and "ActivityRank_ourside_flagbg" or "ActivityRank_ourside_scorebg"
    else
        return isHaveTitle and "ActivityRank_enemyside_flagbg" or "ActivityRank_enemyside_scorebg"
    end
    return ""
end

---获取显示的名字字符串
function UIActivityRankUnitFeatureBase:GetName()
    local str = ''
    if self.tbl and self.settleInfo then
        str = self:GetNameColor(self.tbl.isLeft)
        local isKuaFuOpen = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
        if isKuaFuOpen then
            local hostId = self.settleInfo.hostId
            if hostId ~= nil and hostId ~= 0 then
                ---获取服务器大区前缀
                local LianFuPrefix = luaclass.RemoteHostDataClass:GetLianFuRankNameFormatByHostId(hostId)
                str = str .. LianFuPrefix
            end
        end
        str = str .. self.settleInfo:GetName()
    end
    return str
end

---根据位置获得名字颜色
function UIActivityRankUnitFeatureBase:GetNameColor(isLeft)
    if isLeft then
        return '[2977eb]'
    else
        return '[ff8f5e]'
    end
end

--endregion

--region 组件显示控制

---是否显示点赞
function UIActivityRankUnitFeatureBase:IsShowLike()
    return true
end

---是否显示称号
function UIActivityRankUnitFeatureBase:IsShowTitle()
    return true
end

---是否需要显示战损列表
function UIActivityRankUnitFeatureBase:IsShowServantList()
    return false
end

---是否需要显示战损列表
function UIActivityRankUnitFeatureBase:IsShowPlayerName()
    return true
end

--endregion

--region ondestroy

function UIActivityRankUnitFeatureBase:OnDestruct()
    self.tbl = nil
    self.settleInfo = nil
end
--endregion

--region 自适应
---获取点赞按钮偏移值
---@return number
function UIActivityRankUnitFeatureBase:GetLikeOffsetValue()
    local likeType = self:GetLikeSprite(self.settleInfo)
    if likeType == LuaEnumActivityLikeType.NormalPraise or likeType == LuaEnumActivityLikeType.MutualPraise then
        return -8
    end
    return 0
end
--endregion

return UIActivityRankUnitFeatureBase