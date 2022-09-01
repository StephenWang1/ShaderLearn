---@class UIActivityRankBuDouKaiFeature:UIActivityRankUnitFeatureBase
local UIActivityRankBuDouKaiFeature = {}
setmetatable(UIActivityRankBuDouKaiFeature, luaclass.UIActivityRankUnitFeatureBase)

function UIActivityRankBuDouKaiFeature:SetUnitView()
    if self.settleInfo ~= nil then
        if self.tbl:GetRankingSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankingSprite() .gameObject) then
            self.tbl:GetRankingSprite().spriteName = self.tbl.Line > 3 and '' or tostring(self.tbl.Line)
            self.tbl:GetRankingSprite().gameObject:SetActive(true)
        end

        if self.tbl:GetRankingValue() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankingValue().gameObject) then
            self.tbl:GetRankingValue().text = self.tbl.Line < 4 and '' or tostring(self.tbl.Line)
            self.tbl:GetRankingValue().gameObject:SetActive(true)
        end

        if self.tbl:GetRankPlayerName() ~= nil then
            self.tbl:GetRankPlayerName().text = self.settleInfo:GetName()
            self.tbl:GetRankPlayerName().gameObject:SetActive(self:IsShowPlayerName())
        end

        if self.tbl:GetRankPlayerKill() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankPlayerKill().gameObject) then
            self.tbl:GetRankPlayerKill() .text = tostring(self.settleInfo.KillNum)
            self.tbl:GetRankPlayerKill().gameObject:SetActive(true)
        end

        if self.tbl:GetRankBetRate() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankBetRate().gameObject) then
            local str = tostring(Utility.GetPreciseDecimal(self.settleInfo.BuDouRankPlayerInfo.selectBetRate, 2)) .. '/' .. tostring(Utility.GetPreciseDecimal(self.settleInfo.BuDouRankPlayerInfo.finalBetRate, 2))
            self.tbl:GetRankBetRate() .text = str
            self.tbl:GetRankBetRate().gameObject:SetActive(true)
        end

        if self.tbl:GetRankBetAmount() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetRankBetAmount().gameObject) then
            local str = Utility.GetNumStr(self.settleInfo.BuDouRankPlayerInfo.selectBetAmount) .. '/' .. Utility.GetNumStr(self.settleInfo.BuDouRankPlayerInfo.finalBetAmount)
            self.tbl:GetRankBetAmount() .text = str
            self.tbl:GetRankBetAmount().gameObject:SetActive(true)
        end

        if self.tbl:GetItemGrid() ~= nil then
            self.tbl:GetItemGrid().MaxCount = self.settleInfo.RewardItems.Count
            local length = self.settleInfo.RewardItems.Count - 1
            for k = 0, length do
                local go = self.tbl:GetItemGrid().controlList[k]
                local rewardInfo = self.settleInfo.RewardItems[k]
                local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.ItemConfigId)
                if template ~= nil and itemInfoIsFind then
                    template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
                end
            end
            self.tbl:GetItemGrid().gameObject:SetActive(self:IsShowPlayerName())
        end
        self:RefreshRewardGrid(self.tbl)
    end
    self:RunBaseFunction("SetTemplate", self.tbl)
end

function UIActivityRankBuDouKaiFeature:RefreshAllIcon(target)

end

function UIActivityRankBuDouKaiFeature:RefreshRewardGrid(target)
    if target ~= nil and target.settleInfo ~= nil and target.settleInfo.RewardItems ~= nil then
        if target:GetItemGrid() ~= nil and not CS.StaticUtility.IsNull(target:GetItemGrid()) then
            target:GetItemGrid().MaxCount = target.settleInfo.RewardItems.Count
            target:GetItemGrid().gameObject:SetActive(true)
            for i = 0, target.settleInfo.RewardItems.Count - 1 do
                local go = target:GetItemGrid().controlList[i]
                local data = target.settleInfo.RewardItems[i]
                if go ~= nil then
                    local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
                    temp:RefreshUI(data.ItemConfigId, data.count)
                end
            end
        end
    end
end

--region 点赞刷新
--获得点赞图标
function UIActivityRankBuDouKaiFeature:GetLikeSprite(settleInfo)
    local showLikeRole = CS.CSScene.MainPlayerInfo.ActivityInfo.BuDouKaiShowLike
    if settleInfo == nil or showLikeRole == false then
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
function UIActivityRankBuDouKaiFeature:RefreshLike()
    local showLikeRole = CS.CSScene.MainPlayerInfo.ActivityInfo.BuDouKaiShowLike
    local praiseSpriteName = LuaEnumActivityLikeType.HidePraise
    --点赞图标
    if self.tbl:GetLikeSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeSprite().gameObject) then
        if showLikeRole == false then
            self.tbl:GetLikeSprite().spriteName = ""
        else
            praiseSpriteName = self:GetLikeSprite(self.settleInfo)
            self.tbl:GetLikeSprite().spriteName = praiseSpriteName
            self.tbl:GetLikeSprite().gameObject:SetActive(true)
        end
    end
    --if target.icon ~= nil and not CS.StaticUtility.IsNull(target.icon.gameObject) then
    --    target.icon.spriteName = target.settleInfo:GetHeadIcon()
    --end
    --评分
    if self.tbl:GetMvpNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetMvpNum().gameObject) then
        self.tbl:GetMvpNum().text = ""
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

--region 排版
function UIActivityRankBuDouKaiFeature:SetUnitComponentPos()
    self:RunBaseFunction("SetUnitComponentPos")
    if self.tbl:GetRankPlayerKill() ~= nil then
        local origionPos = self.tbl:GetRankPlayerKill().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.KillPlayer)
        self.tbl:GetRankPlayerKill().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetItemGrid() ~= nil then
        local origionPos = self.tbl:GetItemGrid().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Reward)
        self.tbl:GetItemGrid().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankBetRate() ~= nil then
        local origionPos = self.tbl:GetRankBetRate().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.BetRate)
        self.tbl:GetRankBetRate().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetRankBetAmount() ~= nil then
        local origionPos = self.tbl:GetRankBetAmount().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.BetAmount)
        self.tbl:GetRankBetAmount().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
end
--endregion

--刷新称号
function UIActivityRankBuDouKaiFeature:RefreshTitle(target)

end

---是否显示称号
function UIActivityRankBuDouKaiFeature:IsShowTitle()
    return false
end
--endregion

--region 排版
function UIActivityRankBuDouKaiFeature:SetUnitCompontentPos()
    self:RunBaseFunction("SetUnitCompontentPos")
end
--endregion

--region 点击回调
--点击详情按钮回调
--function UIActivityRankBuDouKaiFeature:OnDetailsBtnClick(target, go)
--
--end
--点击点赞图标
function UIActivityRankBuDouKaiFeature:OnLikeBtnClick(go)
    if self.tbl == nil or self.tbl .settleInfo == nil then
        return
    end
    networkRequest.ReqLike(luaEnumActivityTypeByActivityTimeTable.BuDouKai, self.settleInfo.rid, uiStaticParameter.CurBuDouKaiActivityTime)
end
--endregion

---获取名字颜色
function UIActivityRankBuDouKaiFeature:GetNameColor()
    return ""
end
return UIActivityRankBuDouKaiFeature