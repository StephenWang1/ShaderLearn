---@class UIActivityRankGoddessFeature:UIActivityRankUnitFeatureBase
local UIActivityRankGoddessFeature = {}
setmetatable(UIActivityRankGoddessFeature, luaclass.UIActivityRankUnitFeatureBase);

function UIActivityRankGoddessFeature:SetUnitView()
    self:RunBaseFunction("SetUnitView")
    if self.tbl:GetSecondValue() ~= nil then
        self.tbl:GetSecondValue().text = tostring(self.settleInfo.secondValue)
        self.tbl:GetSecondValue().gameObject:SetActive(true)
    end

    if self.tbl:GetThirdValue() ~= nil then
        self.tbl:GetThirdValue().text = tostring(self.settleInfo.thirdValue)
        self.tbl:GetThirdValue().gameObject:SetActive(true)
    end
    if self.tbl:GetItemGrid() ~= nil then
        self:RefreshRewardGrid()
        self.tbl:GetItemGrid().gameObject:SetActive(true)
    end
end
function UIActivityRankGoddessFeature:SetUnitComponentPos()
    self:RunBaseFunction("SetUnitComponentPos")
    if self.tbl:GetSecondValue() ~= nil then
        local origionPos = self.tbl:GetSecondValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Ingots)
        self.tbl:GetSecondValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end

    if self.tbl:GetThirdValue() ~= nil then
        local origionPos = self.tbl:GetThirdValue().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.KillPlayer)
        self.tbl:GetThirdValue().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
    if self.tbl:GetItemGrid() ~= nil then
        local origionPos = self.tbl:GetItemGrid().transform.localPosition
        local posx = self:GetComponentPosx(LuaEnumActivityRankComponentType.Reward)
        self.tbl:GetItemGrid().transform.localPosition = { x = posx, y = origionPos.y, z = 0 }
    end
end
--重写点击点赞图标
function UIActivityRankGoddessFeature:OnLikeBtnClick(go)
    if self.settleInfo == nil then
        return
    end
    networkRequest.ReqLike(235, self.settleInfo.rid, uiStaticParameter.CurGoddessActivityTime)
end

function UIActivityRankGoddessFeature:RefreshIntegral()
    --self:RunBaseFunction("RefreshIntegral")
    --if self.tbl.integral ~= nil and not CS.StaticUtility.IsNull(self.tbl.integral.gameObject) then
    --    --四舍五入 取值
    --    --local intergralNum = Utility.FloatRounding((target.settleInfo.integral / 1000), 1)
    --    --显示保留一位小数
    --    self.tbl.integral.text = string.format('%.1f', self.tbl.settleInfo.integral)
    --end
    if self.tbl:GetMvpNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetMvpNum().gameObject) then
        --四舍五入 取值
        --local intergralNum = Utility.FloatRounding((self.settleInfo.integral / 1000), 1)
        --显示保留一位小数
        self.tbl:GetMvpNum().text = string.format('%.1f', self.settleInfo.integral)
    end
end

---刷新奖励列表
function UIActivityRankGoddessFeature:RefreshRewardGrid()
    local info = self.settleInfo.ServerDateInfo.awardItems
    if info then
        self.tbl:GetItemGrid().MaxCount = info.Count
        for i = 0, info.Count - 1 do
            local go = self.tbl:GetItemGrid().controlList[i]
            if go then
                local template
                if self.mRewardGoAndTemDic == nil then
                    self.mRewardGoAndTemDic = {}
                end
                if self.mRewardGoAndTemDic[go] == nil then
                    ---@type UIItem
                    self.mRewardGoAndTemDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                end
                template = self.mRewardGoAndTemDic[go]
                local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info[i].ItemConfigId)
                if template ~= nil and itemInfoIsFind then
                    template:RefreshUIWithItemInfo(itemInfo, info[i].count)
                    template:RefreshOtherUI({ showItemInfo = itemInfo })
                end
            end
        end
    end
end

--function UIActivityRankGoddessFeature:GetFirstName(rank)
--    return '第' .. tostring(rank) .. '名'
--end
--
--function UIActivityRankGoddessFeature:GetSecondName()
--    if self.settleInfo == nil then
--        return ''
--    else
--        return tostring(self.settleInfo.secondValue) .. '元宝'
--    end
--end
--
--function UIActivityRankGoddessFeature:GetThirdName()
--    if self.settleInfo == nil then
--        return ''
--    else
--        return tostring(self.settleInfo.thirdValue) .. '人'
--    end
--end
-- --点击详情按钮回调
-- function UIActivityRankGoddessFeature:OnDetailsBtnClick(target, go)
--    print("点击详情按钮回调")
-- end

--点击点赞图标
function UIActivityRankGoddessFeature:OnLikeBtnClick(go)
    --发送服务器消息
    --请求点赞
    -- print(target.settleInfo,target.settleInfo.rid,target.settleInfo.secondValue)
    networkRequest.ReqLike(235, self.settleInfo.rid, CS.CSScene.MainPlayerInfo.ActivityInfo.rankTime)
end

--刷新点赞
function UIActivityRankGoddessFeature:RefreshLike()
    if self.tbl:GetLikeNum() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeNum().gameObject) then
        --local count = self.tbl.settleInfo.likeRoleList.Count

        local number, LikeType = CS.CSScene.MainPlayerInfo.ActivityInfo:LikeInfo(self.tbl.settleInfo.likeRoleList, self.tbl.settleInfo.rid)
        self.tbl:GetLikeNum().text = number
        self.tbl:GetLikeTween():PlayReverse()
        if self.tbl:GetLikeSprite() ~= nil and not CS.StaticUtility.IsNull(self.tbl:GetLikeSprite().gameObject) then
            self.tbl:GetLikeSprite().spriteName = self:GetLikeSprite(LikeType)
            self.tbl:GetLikeSprite().gameObject:SetActive(CS.CSScene.MainPlayerInfo.ActivityInfo.IsOpenGoddess)
        end
    end
end

--获得点赞图标
function UIActivityRankGoddessFeature:GetLikeSprite(LikeType)
    if LikeType == nil then
        return ''
    end

    if LikeType == 2 then
        return LuaEnumActivityLikeType.MutualPraise
    elseif LikeType == 1 then
        return LuaEnumActivityLikeType.NormalPraise
    else
        return LuaEnumActivityLikeType.HightPraise
    end
end

function UIActivityRankGoddessFeature:RefreshTitle()
    local isFind, name = CS.Cfg_GlobalTableManager.Instance.rankTitleIconNameDic:TryGetValue(1)
    if self.tbl.settleInfo.IsMvp == false then
        self.tbl:GetMvpSprite().spriteName = ""
        self.tbl:GetMvpBgSprite().spriteName = self:GetMvpBgSprite(self.tbl.isLeft, false)
        self.tbl:GetMvpTween():PlayForward()
    else
        self.tbl:GetMvpSprite().spriteName = name
        self.tbl:GetMvpBgSprite().spriteName = self:GetMvpBgSprite(self.tbl.isLeft, true)
        self.tbl:GetMvpTween():PlayReverse()
    end
end

---获取名字颜色
function UIActivityRankGoddessFeature:GetNameColor()
    return ""
end

return UIActivityRankGoddessFeature