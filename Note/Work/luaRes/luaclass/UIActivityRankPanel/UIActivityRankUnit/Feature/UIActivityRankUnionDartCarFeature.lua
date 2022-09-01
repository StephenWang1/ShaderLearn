---@class UIActivityRankUnionDartCarFeature:UIActivityRankUnitFeatureBase
local UIActivityRankUnionDartCarFeature = {}
setmetatable(UIActivityRankUnionDartCarFeature, luaclass.UIActivityRankUnitFeatureBase)

function UIActivityRankUnionDartCarFeature:SetUnitView()
    if self.tbl:GetRankingSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankingSprite() .gameObject) then
        self.tbl:GetRankingSprite().spriteName = self.tbl.Line > 3 and '' or tostring(self.tbl.Line)
        self.tbl:GetRankingSprite().gameObject:SetActive(true)
    end

    if self.tbl:GetRankingValue() ~= nil then
        self.tbl:GetRankingValue().text = self.tbl.Line > 3 and tostring(self.tbl.Line) or ''
        self.tbl:GetRankingValue().gameObject:SetActive(self.tbl.Line > 3)
    end
    if self.tbl:GetRankPlayerName() ~= nil then
        self.tbl:GetRankPlayerName().text = self.settleInfo:GetName()
        self.tbl:GetRankPlayerName().gameObject:SetActive(self:IsShowPlayerName())
    end
    if self.tbl:GetDartCarDistance() ~= nil then
        self.tbl:GetDartCarDistance().text = tostring(self.settleInfo.Distance) or ''
        self.tbl:GetDartCarDistance().gameObject:SetActive(true)
    end
    if self.tbl:GetRankPlayerKill() ~= nil then
        self.tbl:GetRankPlayerKill().text = tostring(self.settleInfo.KillNum) or ''
        self.tbl:GetRankPlayerKill().gameObject:SetActive(true)
    end
    if self.tbl:GetRankPlayerDead() ~= nil then
        self.tbl:GetRankPlayerDead().text = tostring(self.settleInfo.DiedNum) or ''
        self.tbl:GetRankPlayerDead().gameObject:SetActive(true)
    end

    if self.tbl:GetMvpNum() ~= nil then
        self.tbl:GetMvpNum().text = tostring(self.settleInfo.integral) or ''
    end
end

--重写刷新称号
function UIActivityRankUnionDartCarFeature:RefreshTitle()
    if self.tbl == nil or self.settleInfo == nil then
        return
    end
    if self.tbl:GetMvpSprite() == nil or CS.StaticUtility.IsNull(self.tbl:GetMvpSprite().gameObject) then
        return
    end
    local isFind, name = CS.Cfg_GlobalTableManager.Instance.rankTitleIconNameDic:TryGetValue(self.settleInfo.TitleType)
    if isFind then
        self.tbl:GetMvpSprite().spriteName = name
        self.tbl:GetMvpTween():PlayReverse()
    else
        self.tbl:GetMvpSprite().spriteName = ""
        self.tbl:GetMvpTween():PlayForward()
    end
    self.tbl:GetMvpSprite().gameObject:SetActive(true)
    self.tbl:GetMvpTween().gameObject:SetActive(true)
end

--region 排版
function UIActivityRankUnionDartCarFeature:SetUnitComponentPos()
    self:RunBaseFunction("SetUnitComponentPos")
    if self.tbl:GetDartCarDistance() ~= nil then
        local origionPos = self.tbl:GetDartCarDistance().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType. DartDistance)
        self.tbl:GetDartCarDistance().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankPlayerKill() ~= nil then
        local origionPos = self.tbl:GetRankPlayerKill().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.KillPlayer)
        self.tbl:GetRankPlayerKill().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankPlayerDead() ~= nil then
        local origionPos = self.tbl:GetRankPlayerDead().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Dead)
        self.tbl:GetRankPlayerDead().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetLikeSprite() ~= nil then
        local origionPos = self.tbl:GetLikeSprite().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Like)
        self.tbl:GetLikeSprite().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
end
--endregion

--region 点赞刷新
--获得点赞图标
function UIActivityRankUnionDartCarFeature:GetLikeSprite(settleInfo)
    if settleInfo == nil then
        return LuaEnumActivityLikeType.HidePraise
    else
        local PraiseType = Utility.EnumToInt(settleInfo:GetPraiseType())
        if PraiseType == LuaEnumPraiseType.TogetherPraise then
            return LuaEnumActivityLikeType.MutualPraise
        elseif PraiseType == LuaEnumPraiseType.HavePraise then
            return LuaEnumActivityLikeType.NormalPraise
        elseif PraiseType == LuaEnumPraiseType.NoPraise then
            return LuaEnumActivityLikeType.HightPraise
        end
    end
    return LuaEnumActivityLikeType.HidePraise
end

--刷新点赞
function UIActivityRankUnionDartCarFeature:RefreshLike()
    local showLikeRole = CS.CSScene.MainPlayerInfo.ActivityInfo.ShowLikeRole
    local praiseSpriteName = LuaEnumActivityLikeType.HidePraise
    --点赞图标
    if self.tbl:GetLikeSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeSprite().gameObject) then
        if showLikeRole == false then
            self.tbl:GetLikeSprite().spriteName = LuaEnumActivityLikeType.HidePraise
            self.tbl:GetLikeSprite().gameObject:SetActive(false)
        else
            praiseSpriteName = self:GetLikeSprite(self.settleInfo)
            self.tbl:GetLikeSprite().spriteName = praiseSpriteName
            self.tbl:GetLikeSprite().gameObject:SetActive(true)
        end
    end
    --点赞数量
    if self.tbl:GetLikeNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeNum().gameObject) then
        local count = self.settleInfo.likeRoleList.Count
        if showLikeRole == false then
            self.tbl:GetLikeNum().text = ""
        else
            if praiseSpriteName == LuaEnumActivityLikeType.HidePraise or praiseSpriteName == LuaEnumActivityLikeType.HightPraise then
                self.tbl:GetLikeNum().text = ''
            else
                self.tbl:GetLikeNum().text = tostring(count)
                self.tbl:GetLikeNum().gameObject:SetActive(true)
            end
        end
    end

end
--endregion

--重写点击点赞图标
function UIActivityRankUnionDartCarFeature:OnLikeBtnClick(go)
    if self.tbl == nil or self.settleInfo == nil then
        return
    end
    networkRequest.ReqLike(luaEnumActivityTypeByActivityTimeTable.DartCar, self.settleInfo.rid, uiStaticParameter.CurUnionDartCarActivityTime)
end

---获取名字颜色
function UIActivityRankUnionDartCarFeature:GetNameColor()
    return ""
end
return UIActivityRankUnionDartCarFeature