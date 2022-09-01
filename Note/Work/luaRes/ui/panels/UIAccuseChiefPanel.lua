---弹劾会长界面
---@class UIAccuseChiefPanel:UIBase
local UIAccuseChiefPanel = {}

local Utility = Utility

--region 局部变量定义
UIAccuseChiefPanel.mVote = nil
UIAccuseChiefPanel.mVoteWidth = nil
---弹劾时间
UIAccuseChiefPanel.mTime = nil
---倒计时协程
UIAccuseChiefPanel.mTimeCountCoroutine = nil
--endregion

--region属性
---@return  TABLE.CFG_DESCRIPTION 描述信息
function UIAccuseChiefPanel:GetDesInfo()
    if self.mDesInfo == nil then
        ___, self.mDesInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(4)
    end
    return self.mDesInfo
end

---@return CSUnionInfoV2 帮会信息
function UIAccuseChiefPanel:GetUnionInfo()
    if self.mUnionInfo == nil then
        if self:GetPlayerInfo() then
            self.mUnionInfo = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mUnionInfo
end

---@return CSMainPlayerInfo 玩家信息
function UIAccuseChiefPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSBagInfoV2 背包信息
function UIAccuseChiefPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetPlayerInfo() then
        self.mBagInfoV2 = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return boolean 投票是否需要花费
function UIAccuseChiefPanel:GetIsVoteNeedMoney()
    return self:GetUnionInfo().UnionInfo.unionInfo.isPayImeach
end
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UIAccuseChiefPanel:GetCloseButton_GameObject()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return self.mCloseButton
end

---@return UnityEngine.GameObject 提示Tips
function UIAccuseChiefPanel:GetDescriptionButton_GameObject()
    if self.mDescriptionButton == nil then
        self.mDescriptionButton = self:GetCurComp("WidgetRoot/event/btn_description", "GameObject")
    end
    return self.mDescriptionButton
end

---@return UISprite 会长头像
function UIAccuseChiefPanel:GetLeaderHeadIcon_UISprite()
    if self.mLeaderIcon == nil then
        self.mLeaderIcon = self:GetCurComp("WidgetRoot/view/player", "UISprite")
    end
    return self.mLeaderIcon
end

---@return UILabel 会长等级
function UIAccuseChiefPanel:GetLeaderLevel_UILabel()
    if self.mLeaderLevel == nil then
        self.mLeaderLevel = self:GetCurComp("WidgetRoot/view/lb_level", "UILabel")
    end
    return self.mLeaderLevel
end

---@return UILabel 会长名字
function UIAccuseChiefPanel:GetLeaderName_UILabel()
    if self.mLeaderName == nil then
        self.mLeaderName = self:GetCurComp("WidgetRoot/view/lb_name", "UILabel")
    end
    return self.mLeaderName
end

---@return UICountdownLabel 结算倒计时
function UIAccuseChiefPanel:GetTimeCountLabel_UICountdownLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/view/lb_time", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---@return UnityEngine.GameObject 投票按钮root
function UIAccuseChiefPanel:GetVoteGameObject_GameObject()
    if self.mVoteRoot == nil then
        self.mVoteRoot = self:GetCurComp("WidgetRoot/event/hvnt_vote", "GameObject")
    end
    return self.mVoteRoot
end

---@return UISprite 同意图片
function UIAccuseChiefPanel:GetAgreeGraphic_UISprite()
    if self.mAgreeGraphic == nil then
        self.mAgreeGraphic = self:GetCurComp("WidgetRoot/view/agree/sp_agree_graphic", "UISprite")
    end
    return self.mAgreeGraphic
end

---@return UILabel 同意人数
function UIAccuseChiefPanel:GetAgreeCount_UILabel()
    if self.mAgreeCount == nil then
        self.mAgreeCount = self:GetCurComp("WidgetRoot/view/agree/lb_agree_count", "UILabel")
    end
    return self.mAgreeCount
end

---@return UISprite 不同意图片
function UIAccuseChiefPanel:GetDisagreeGraphic_UISprite()
    if self.mDisagreeGraphic == nil then
        self.mDisagreeGraphic = self:GetCurComp("WidgetRoot/view/disagree/sp_disagree_graphic", "UISprite")
    end
    return self.mDisagreeGraphic
end

---@return UILabel 不同意人数
function UIAccuseChiefPanel:GetDisagreeCount_UILabel()
    if self.mDisagreeCount == nil then
        self.mDisagreeCount = self:GetCurComp("WidgetRoot/view/disagree/lb_disagree_count", "UILabel")
    end
    return self.mDisagreeCount
end

---@return UISprite 投票背景条长度
function UIAccuseChiefPanel:GetSliderBG_UISprite()
    if self.mSliderBG == nil then
        self.mSliderBG = self:GetCurComp("WidgetRoot/view/agree/sliderbg", "UISprite")
    end
    return self.mSliderBG
end

---@return UnityEngine.GameObject 同意按钮
function UIAccuseChiefPanel:GetAgreeBtn_GameObject()
    if self.mAgreeToggle == nil then
        self.mAgreeToggle = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_agree", "GameObject")
    end
    return self.mAgreeToggle
end

---@return UnityEngine.GameObject 不同意按钮
function UIAccuseChiefPanel:GetDisagreeBtn_GameObject()
    if self.mDisagreeToggle == nil then
        self.mDisagreeToggle = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_disagree", "GameObject")
    end
    return self.mDisagreeToggle
end

---@return UISprite 同意花费金币Icon
function UIAccuseChiefPanel:GetAgreeCost_UISprite()
    if self.mAgreeCostSp == nil then
        self.mAgreeCostSp = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_agree/YesCostgold/Sprite", "UISprite")
    end
    return self.mAgreeCostSp
end

---@return UILabel 同意划给金币数目
function UIAccuseChiefPanel:GetAgreeCost_UILabel()
    if self.mAgreeCostLb == nil then
        self.mAgreeCostLb = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_agree/YesCostgold", "UILabel")
    end
    return self.mAgreeCostLb
end

---@return UISprite 不同意花费金币Icon
function UIAccuseChiefPanel:GetDisagreeCost_UISprite()
    if self.mDisagreeCostSp == nil then
        self.mDisagreeCostSp = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_disagree/NoCostgold/Sprite", "UISprite")
    end
    return self.mDisagreeCostSp
end

---@return UILabel 不同意划给金币数目
function UIAccuseChiefPanel:GetDisagreeCost_UILabel()
    if self.mDisagreeCostLb == nil then
        self.mDisagreeCostLb = self:GetCurComp("WidgetRoot/event/hvnt_vote/btn_disagree/NoCostgold", "UILabel")
    end
    return self.mDisagreeCostLb
end

---@return UILabel 标题显示
function UIAccuseChiefPanel:GetTitleLabel_UILabel()
    if self.mShowTitle == nil then
        self.mShowTitle = self:GetCurComp("WidgetRoot/view/lb_name", "UILabel")
    end
    return self.mShowTitle
end

---@return UnityEngine.GameObject 个人同意
function UIAccuseChiefPanel:SelfAgree_Go()
    if self.mAgreeGo == nil then
        self.mAgreeGo = self:GetCurComp("WidgetRoot/view/agreeVote", "GameObject")
    end
    return self.mAgreeGo
end

---@return UnityEngine.GameObject 个人反对
function UIAccuseChiefPanel:SelfDisagree_Go()
    if self.mDisagreeGo == nil then
        self.mDisagreeGo = self:GetCurComp("WidgetRoot/view/disagreeVote", "GameObject")
    end
    return self.mDisagreeGo
end

--endregion

--region 初始化
function UIAccuseChiefPanel:Init()
    networkRequest.ReqImpeachmentInfo(true)
    self:BindMessage()
    self:BindEvents()
    self.mVoteWidth = self:GetSliderBG_UISprite().width
end

function UIAccuseChiefPanel:Show()

end

function UIAccuseChiefPanel:BindMessage()
    UIAccuseChiefPanel.OnResImpeachmentVoteMessageReceiveFunc = function()
        self:OnResImpeachmentVoteMessageReceived()
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResImpeachmentVoteMessage, UIAccuseChiefPanel.OnResImpeachmentVoteMessageReceiveFunc)
end

function UIAccuseChiefPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetDescriptionButton_GameObject()).onClick = function()
        self:OnHelpButtonClicked()
    end
    CS.UIEventListener.Get(self:GetAgreeBtn_GameObject()).onClick = function(go)
        self:OnAgreeBtnClicked(go)
    end
    CS.UIEventListener.Get(self:GetDisagreeBtn_GameObject()).onClick = function(go)
        self:OnDisAgreeBtnClicked(go)
    end
    CS.UIEventListener.Get(self:GetLeaderHeadIcon_UISprite().gameObject).onClick = function(go)
        self:ShowPresidentInformation(go)
    end
end
--endregion

--region UI事件
---收到投票信息刷新界面
function UIAccuseChiefPanel:OnResImpeachmentVoteMessageReceived()
    ---@type CSUnionInfoV2
    local info = CS.CSScene.MainPlayerInfo.UnionInfoV2
    ---@type unionV2.ResImpeachmentVote
    self.mVote = info.UnionImpeachment
    self.mTime = self:GetUnionInfo():GetFinishAccuseTime()
    if self.mVote ~= nil then
        --是否投票
        local IsVote = self.mVote.myVote ~= 0
        self:SelfAgree_Go():SetActive(self.mVote.myVote == 1)
        self:SelfDisagree_Go():SetActive(self.mVote.myVote == 2)
        self:GetVoteGameObject_GameObject():SetActive(not IsVote)
        --比例计算
        local agreeNum = self.mVote.agreeSum
        local disagreeNum = self.mVote.disagreeSum

        local agreeRate = 0.5
        local disagreeRate = 0.5
        local isMoreAgree = true

        if agreeNum > disagreeNum then
            agreeRate = math.floor((agreeNum / (agreeNum + disagreeNum)) * 100 + 0.5) * 0.01
            disagreeRate = 1 - agreeRate
        elseif agreeNum < disagreeNum then
            disagreeRate = math.floor((disagreeNum / (agreeNum + disagreeNum)) * 100 + 0.5) * 0.01
            agreeRate = 1 - disagreeRate
            isMoreAgree = false
        end

        local agreeRateShow = math.ceil(agreeRate * 100)
        local disagreeRateShow = math.ceil(disagreeRate * 100)
        self:GetAgreeGraphic_UISprite().fillAmount = agreeRate
        self:GetAgreeCount_UILabel().text = agreeRateShow .. "%"
        self:GetDisagreeCount_UILabel().text = disagreeRateShow .. "%"

        local show
        if isMoreAgree then
            show = agreeRateShow .. "%同意"
        else
            show = disagreeRateShow .. "%反对"
        end
        self:InitInfo(show)
    end
    --倒计时
    if self.mTime ~= nil then
        self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(true)
        self:GetTimeCountLabel_UICountdownLabel():StartCountBySecond(nil, 8, self.mTime, nil, "后弹劾结束", nil, function()
            self:GetTimeCountLabel_UICountdownLabel().gameObject:SetActive(false)
        end)
    end
end

---同意
function UIAccuseChiefPanel:OnAgreeBtnClicked(go)
    self:ReqVote(true, go)
end

---不同意
function UIAccuseChiefPanel:OnDisAgreeBtnClicked(go)
    self:ReqVote(false, go)
end

---判断投票货币是否足够
function UIAccuseChiefPanel:IsMoneyEnough()
    local playerHas = self:GetBagInfoV2():GetCoinAmount(self:GetVoteCost(0))
    return playerHas >= self:GetVoteCost(1)
end

---发起请求
function UIAccuseChiefPanel:ReqVote(isAgree, go)
    if self:GetIsVoteNeedMoney() then
        local customData = {}
        customData.ID = 72
        customData.CenterCostID = self:GetVoteCost(0)
        customData.CenterCostNum = self:GetVoteCost(1)
        customData.CenterCallBack = function(go)
            if self:GetUnionInfo() and self:GetUnionInfo():IsCanVoteAccuseChief() then
                if self:IsMoneyEnough() then
                    networkRequest.ReqImpeachmentVote(isAgree)
                    networkRequest.ReqImpeachmentInfo(true)
                    uimanager:ClosePanel("UIGuildAccusePromptPanel")
                else
                    Utility.ShowPopoTips(go, self:GetMoneyNotEnoughDes(), 155)
                end
            else
                Utility.ShowPopoTips(go, self:GetTimeNotEnoughDes(), 172)
            end
        end
        uimanager:CreatePanel("UIGuildAccusePromptPanel", nil, customData)
        return
    else
        networkRequest.ReqImpeachmentVote(isAgree)
        networkRequest.ReqImpeachmentInfo(true)
    end
end

---@return string 货币不足提示
function UIAccuseChiefPanel:GetMoneyNotEnoughDes()
    if self.mMoneyDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(155)
        if res and self:GetVoteCostItemInfo() then
            self.mMoneyDes = string.format(desInfo.content, self:GetVoteCostItemInfo().name)
        end
    end
    return self.mMoneyDes
end

---@return string 入会时间不足提示
function UIAccuseChiefPanel:GetTimeNotEnoughDes()
    if self.mTimeDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(172)
        if res then
            local time = CS.Cfg_GlobalTableManager.Instance:AccuseChiedVoteTime()
            if time ~= -1 then
                self.mTimeDes = string.format(desInfo.content, time)
            end
        end
    end
    return self.mTimeDes
end

---帮助界面
function UIAccuseChiefPanel:OnHelpButtonClicked()
    if self:GetDesInfo() then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, self:GetDesInfo())
    end
end

---初始化会长信息
---@param show string 结尾内容
function UIAccuseChiefPanel:InitInfo(show)
    if self:GetUnionInfo() then
        local leaderInfo = self:GetUnionInfo().LeaderUnionMemberInfo
        if leaderInfo then
            local leaderSex = leaderInfo.sex
            local leaderCareer = leaderInfo.career
            self:GetLeaderHeadIcon_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(leaderSex, leaderCareer)
            self:GetLeaderLevel_UILabel().text = leaderInfo.memberLevel
            self:GetLeaderName_UILabel().text = leaderInfo.memberName
            self:GetTitleLabel_UILabel().text = "[878787]对[dde6eb]" .. leaderInfo.memberName .. "[-]进行弹劾" .. show
        end
    end

    if self:GetIsVoteNeedMoney() then
        self:GetAgreeCost_UILabel().text = self:GetVoteCost(1)
        self:GetDisagreeCost_UILabel().text = self:GetVoteCost(1)
        if self:GetVoteCostItemInfo() then
            self:GetAgreeCost_UISprite().spriteName = self:GetVoteCostItemInfo().icon
            self:GetDisagreeCost_UISprite().spriteName = self:GetVoteCostItemInfo().icon
        end
    end
    -- self:GetAgreeCost_UILabel().gameObject:SetActive(self:GetIsVoteNeedMoney())
    --  self:GetDisagreeCost_UILabel().gameObject:SetActive(self:GetIsVoteNeedMoney())
end

---@return System.Array 获取投票花费
---@param type  number 货币id 0 / 货币数目 1
function UIAccuseChiefPanel:GetVoteCost(type)
    if self.mVoteCost == nil then
        self.mVoteCost = CS.Cfg_GlobalTableManager.Instance:AccuseChiefVoteCost()
    end
    if self.mVoteCost and self.mVoteCost.Length >= 2 then
        return self.mVoteCost[type]
    end
    return 0
end

---@return TABLE.CFG_ITEMS 获取投票道具信息
function UIAccuseChiefPanel:GetVoteCostItemInfo()
    if self.mCostItemInfo == nil then
        ___, self.mCostItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self:GetVoteCost(0))
    end
    return self.mCostItemInfo
end

---显示会长详细信息
function UIAccuseChiefPanel:ShowPresidentInformation(go)
    local leaderInfo = self:GetUnionInfo().LeaderUnionMemberInfo
    if leaderInfo then
        if not leaderInfo.online then
            return
        end
        local playerId = leaderInfo.roleId
        if self:GetPlayerInfo() then
            self:GetPlayerInfo().OtherPlayerInfo:ReqOtherPlayerMsg(playerId, LuaEnumOtherPlayerBtnType.ROLE, LuaEnumOtherPlayerBtnSubtype.OTHERROLE)
            uiStaticParameter.mUnionAccuseViewPerson = true
        end
    end
end
--endregion

return UIAccuseChiefPanel