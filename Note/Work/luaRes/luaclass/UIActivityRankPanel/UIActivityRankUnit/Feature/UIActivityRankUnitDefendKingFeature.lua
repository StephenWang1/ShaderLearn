---@class UIActivityRankUnitDefendKingFeature:UIActivityRankUnitFeatureBase
local UIActivityRankUnitDefendKingFeature = {}
setmetatable(UIActivityRankUnitDefendKingFeature, luaclass.UIActivityRankUnitFeatureBase)

function UIActivityRankUnitDefendKingFeature:SetUnitView()
    self:RunBaseFunction("SetUnitView")
    if self.tbl:GetFirstValue() ~= nil then
        self.tbl:GetFirstValue().text = tostring(self.settleInfo.firstValue)
        self.tbl:GetFirstValue().gameObject:SetActive(true)
    end

    if self.tbl:GetSecondValue() ~= nil then
        self.tbl:GetSecondValue().text = tostring(self.settleInfo.secondValue)
        self.tbl:GetSecondValue().gameObject:SetActive(true)
    end

    if self.tbl:GetThirdValue() ~= nil then
        self.tbl:GetThirdValue().text = tostring(self.settleInfo.thirdValue)
        self.tbl:GetThirdValue().gameObject:SetActive(true)
    end

    if self.tbl:GetFourthValue() ~= nil then
        self.tbl:GetFourthValue().text = tostring(self.settleInfo.fourthValue)
        self.tbl:GetFourthValue().gameObject:SetActive(true)
    end
end

function UIActivityRankUnitDefendKingFeature:SetUnitComponentPos()
    self:RunBaseFunction("SetUnitComponentPos")
    if self.tbl:GetFirstValue() ~= nil then
        local origionPos = self.tbl:GetFirstValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType. LowAssassin)
        self.tbl:GetFirstValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetSecondValue() ~= nil then
        local origionPos = self.tbl:GetSecondValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.SeniorAssassin)
        self.tbl:GetSecondValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetThirdValue() ~= nil then
        local origionPos = self.tbl:GetThirdValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.KillPlayer)
        self.tbl:GetThirdValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetFourthValue() ~= nil then
        local origionPos = self.tbl:GetFourthValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Dead)
        self.tbl:GetFourthValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
end

--??????????????????
function UIActivityRankUnitDefendKingFeature:RefreshTitle()
    if self.tbl == nil or self.settleInfo == nil then
        return
    end
    if self.tbl:GetMvpSprite() == nil or CS.StaticUtility.IsNull(self.tbl:GetMvpSprite().gameObject) then
        return
    end
    --MVP titleTyp ????????????
    local isFind, name = CS.Cfg_GlobalTableManager.Instance.rankTitleIconNameDic:TryGetValue(self.settleInfo.titleType)
    if isFind then
        self.tbl:GetMvpSprite().spriteName = name
        self.tbl:GetMvpBgSprite().spriteName = self:GetMvpBgSprite(self.tbl.isLeft, true)
        self.tbl:GetMvpTween():PlayReverse()
    else
        self.tbl:GetMvpSprite().spriteName = ""
        self.tbl:GetMvpBgSprite().spriteName = self:GetMvpBgSprite(self.tbl.isLeft, false)
        self.tbl:GetMvpTween():PlayForward()
    end
end

--??????????????????
function UIActivityRankUnitDefendKingFeature:RefreshLike()
    if not self:IsShowLike() then
        return
    end
    local defendRankState = CS.CSScene.MainPlayerInfo.ActivityInfo.defendRankState
    if self.tbl:GetLikeNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeNum()) then
        if defendRankState == 1 then
            self.tbl:GetLikeNum().text = ''
        else
            local count = self.settleInfo.likeRoleList.Count
            if count ~= 0 and self.settleInfo:IsLiked() then
                self.tbl:GetLikeNum().text = tostring(count)
                self.tbl:GetLikeTween():PlayReverse()
            else
                self.tbl:GetLikeNum().text = ""
                self.tbl:GetLikeTween():PlayForward()
            end
        end
    end
    if self.tbl:GetLikeSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeSprite().gameObject) then
        --????????????????????????
        if defendRankState == 1 then
            self.tbl:GetLikeSprite().spriteName = LuaEnumActivityLikeType.HidePraise
        else
            self.tbl:GetLikeSprite().spriteName = self:GetLikeSprite(self.settleInfo)
        end
    end
end

--????????????????????????
function UIActivityRankUnitDefendKingFeature:GetLikeSprite(settleInfo)

    if settleInfo == nil then
        return LuaEnumActivityLikeType.HidePraise
    else
        local defendRankState = CS.CSScene.MainPlayerInfo.ActivityInfo.defendRankState
        local info = CS.CSScene.MainPlayerInfo.ActivityInfo
        if info:IsDefendKingLikePlayer(settleInfo.rid) then
            --?????? ???????????????
            return LuaEnumActivityLikeType.MutualPraise
            --elseif settleInfo.rid == CS.CSScene.MainPlayerInfo.ID then
            --    --??????????????????
            --    return LuaEnumActivityLikeType.NormalPraise
        elseif settleInfo:IsLiked() then
            --???????????????  ???????????????
            return LuaEnumActivityLikeType.NormalPraise
        else
            -- ????????? ???????????????
            return LuaEnumActivityLikeType.HightPraise
        end
    end
end

--????????????????????????
function UIActivityRankUnitDefendKingFeature:OnLikeBtnClick(go)
    if self.settleInfo == nil then
        return
    end
    networkRequest.ReqLike(237, self.settleInfo.rid, uiStaticParameter.CurDefendKingTimeStamp)
end

function UIActivityRankUnitDefendKingFeature:IsShowLike()
    return CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo.defendRankState ~= 1 and self.settleInfo ~= nil
end

return UIActivityRankUnitDefendKingFeature