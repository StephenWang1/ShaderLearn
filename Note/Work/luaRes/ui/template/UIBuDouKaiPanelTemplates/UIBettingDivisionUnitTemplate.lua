local UIBettingDivisionUnitTemplate = {};

--region Components

function UIBettingDivisionUnitTemplate:GetBetBtn_GameObject()
    if (self.mBetBtn_GameObject == nil) then
        self.mBetBtn_GameObject = self:Get("btn_bet", "GameObject");
    end
    return self.mBetBtn_GameObject;
end

function UIBettingDivisionUnitTemplate:GetRankValue_Text()
    if (self.mRankValue_Text == nil) then
        self.mRankValue_Text = self:Get("first/value", "UILabel")
    end
    return self.mRankValue_Text;
end

function UIBettingDivisionUnitTemplate:GetKillValue_Text()
    if (self.mKillValue_Text == nil) then
        self.mKillValue_Text = self:Get("second", "UILabel");
    end
    return self.mKillValue_Text;
end

function UIBettingDivisionUnitTemplate:GetOnLineTime_Text()
    if (self.mOnLineTime_Text == nil) then
        self.mOnLineTime_Text = self:Get("third", "UILabel");
    end
    return self.mOnLineTime_Text;
end

function UIBettingDivisionUnitTemplate:GetOddsValue_Text()
    if (self.mOddsValue_Text == nil) then
        self.mOddsValue_Text = self:Get("fourth", "UILabel");
    end
    return self.mOddsValue_Text;
end

function UIBettingDivisionUnitTemplate:GetStakeValue_Text()
    if (self.mStakeValue_Text == nil) then
        self.mStakeValue_Text = self:Get("fifth", "UILabel");
    end
    return self.mStakeValue_Text;
end

function UIBettingDivisionUnitTemplate:GetPlayerIcon_UISprite()
    if (self.mPlayerIcon_UISprite == nil) then
        self.mPlayerIcon_UISprite = self:Get("first", "UISprite")
    end
    return self.mPlayerIcon_UISprite;
end

function UIBettingDivisionUnitTemplate:GetCostIcon_UISprite()
    if (self.mCostIcon_UISprite == nil) then
        self.mCostIcon_UISprite = self:Get("costIcon", "UISprite")
    end
    return self.mCostIcon_UISprite;
end

--endregion

--region Method

--region Public

function UIBettingDivisionUnitTemplate:UpdateUnit(playerData)
    self.mPlayerData = playerData;
    self.mState = playerData.stage
    self:UpdateUI();
end

function UIBettingDivisionUnitTemplate:UpdateUI()
    if (self.mPlayerData ~= nil) then
        self:GetRankValue_Text().text = "第" .. self.mPlayerData.no .. "名";
        self:GetKillValue_Text().text = self.mPlayerData.killNum .. "杀";
        local timeSecond = math.floor(self.mPlayerData.onlineTime / 1000);
        local minute = math.floor(timeSecond / 60);
        local second = math.floor(timeSecond % 60);
        --self:GetOnLineTime_Text().text = (minute > 9 and tostring(minute) or "0"..minute)..":"..(second > 9 and tostring(second) or "0"..second);
        self:GetOnLineTime_Text().text = minute .. "分钟";
        self:GetOddsValue_Text().text = "赔率 " .. Utility.GetPreciseDecimal(self.mPlayerData.odds, 2);
        self:GetStakeValue_Text().text = self.mPlayerData.zhuNum * CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate();
        self:GetPlayerIcon_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(self.mPlayerData.sex, self.mPlayerData.career);
        self:GetBetBtn_GameObject():SetActive(self.mState == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage));

        if (self.mCoroutineDelayUpdateAnchors ~= nil) then
            StopCoroutine(self.mCoroutineDelayUpdateAnchors);
            self.mCoroutineDelayUpdateAnchors = nil;
        end
        self.mCoroutineDelayUpdateAnchors = StartCoroutine(self.CDelayUpdateAnchors, self);
    end
end

--endregion

--region Private

function UIBettingDivisionUnitTemplate:CDelayUpdateAnchors()
    coroutine.yield(0);
    self:GetCostIcon_UISprite():UpdateAnchors();
end

function UIBettingDivisionUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBetBtn_GameObject()).onClick = function()
        self.mIsBetBtnClicked = true;
        networkRequest.ReqMapCommon(3, nil, nil, self.mPlayerData.playerId);
    end
end

---尝试开启押注数量面板
function UIBettingDivisionUnitTemplate:TryOpenBettingDialogPanel()
    if (self.mIsBetBtnClicked) then
        self.mIsBetBtnClicked = false;
        if (CS.CSScene.MainPlayerInfo.BudowillInfo.MaxZhu <= 0) then
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBetBtn_GameObject().transform;
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 263
            TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIBettingDialog"
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        else
            uimanager:CreatePanel("UIBettingDialog", nil, { playerData = self.mPlayerData, state = self.mState, target = self:GetBetBtn_GameObject(), offset = CS.UnityEngine.Vector2(50, 0) });
        end
    end
end

function UIBettingDivisionUnitTemplate:RemoveEvents()
    if (self.mCoroutineDelayUpdateAnchors ~= nil) then
        StopCoroutine(self.mCoroutineDelayUpdateAnchors);
        self.mCoroutineDelayUpdateAnchors = nil;
    end

    --self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResMapCommonMessage, self.OnResCommonMessage)
end

--endregion

--endregion

function UIBettingDivisionUnitTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
end

--function UIBettingDivisionUnitTemplate:OnEnable()
--    self:InitEvents();
--end
--
--function UIBettingDivisionUnitTemplate:OnDisable()
--    self:RemoveEvents();
--end

function UIBettingDivisionUnitTemplate:Start()
    self:InitEvents();
end

function UIBettingDivisionUnitTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIBettingDivisionUnitTemplate;