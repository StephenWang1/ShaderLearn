---@class UIBettingDialog:UIBase
local UIBettingDialog = {};

local this = nil;

UIBettingDialog.mOddsA = 0;
UIBettingDialog.mOddsB = 0;
UIBettingDialog.mMaxBetNum = 200;
UIBettingDialog.mPlayerData = nil;
UIBettingDialog.mState = nil;

--region Components

function UIBettingDialog:GetBtnAdd_GameObject()
    if (this.mBtnAdd_GameObject == nil) then
        this.mBtnAdd_GameObject = this:GetCurComp("WidgetRoot/root/view/betCount/add", "GameObject");
    end
    return this.mBtnAdd_GameObject;
end

function UIBettingDialog:GetBtnReduce_GameObject()
    if (this.mBtnReduce_GameObject == nil) then
        this.mBtnReduce_GameObject = this:GetCurComp("WidgetRoot/root/view/betCount/reduce", "GameObject")
    end
    return this.mBtnReduce_GameObject;
end

function UIBettingDialog:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/root/event/CloseBtn", "GameObject");
    end
    return this.mBtnClose_GameObject;
end

--function UIBettingDialog:GetBtnCancel_GameObject()
--    if(this.mBtnCancel_GameObject == nil) then
--        this.mBtnCancel_GameObject = this:GetCurComp("WidgetRoot/root/view/LeftBtn","GameObject");
--    end
--    return this.mBtnCancel_GameObject;
--end

function UIBettingDialog:GetBtnBet_GameObject()
    if (this.mBtnBet_GameObject == nil) then
        this.mBtnBet_GameObject = this:GetCurComp("WidgetRoot/root/view/RightBtn", "GameObject")
    end
    return this.mBtnBet_GameObject;
end

function UIBettingDialog:GetBetsNum_Text()
    if (this.mBetsNum_Text == nil) then
        this.mBetsNum_Text = this:GetCurComp("WidgetRoot/root/view/betCount/count", "UILabel");
    end
    return this.mBetsNum_Text;
end

function UIBettingDialog:GetBetsCoinNum_Text()
    if (this.mBetsCoinNum_Text == nil) then
        this.mBetsCoinNum_Text = this:GetCurComp("WidgetRoot/root/view/betLableGroup/bettingQuota/Sprite/Label", "UILabel")
    end
    return this.mBetsCoinNum_Text;
end

function UIBettingDialog:GetPlayerName_Text()
    if (this.mPlayerName_Text == nil) then
        this.mPlayerName_Text = this:GetCurComp("WidgetRoot/root/view/UIPlayer/name", "UILabel")
    end
    return this.mPlayerName_Text;
end

function UIBettingDialog:GetCurrentOdds_Text()
    if (this.mCurrentOdds_Text == nil) then
        this.mCurrentOdds_Text = this:GetCurComp("WidgetRoot/root/view/betLableGroup/currentOdds/Label", "UILabel");
    end
    return this.mCurrentOdds_Text;
end

function UIBettingDialog:GetMineCoinNum_Text()
    if (this.mMineCoinNum_Text == nil) then
        this.mMineCoinNum_Text = this:GetCurComp("WidgetRoot/root/view/minegold", "UILabel");
    end
    return this.mMineCoinNum_Text;
end

function UIBettingDialog:GetPlayerIcon_UISprite()
    if (this.mPlayerIcon_UISprite == nil) then
        this.mPlayerIcon_UISprite = this:GetCurComp("WidgetRoot/root/view/UIPlayer/icon", "UISprite");
    end
    return this.mPlayerIcon_UISprite;
end

function UIBettingDialog:GetCoinType_UISprite()
    if (this.mCoinType_UISprite == nil) then
        this.mCoinType_UISprite = this:GetCurComp("WidgetRoot/root/view/betLableGroup/bettingQuota/Sprite", "UISprite");
    end
    return this.mCoinType_UISprite;
end

function UIBettingDialog:GetMineCoinType_UISprite()
    if (this.mMineCoinType_UISprite == nil) then
        this.mMineCoinType_UISprite = this:GetCurComp("WidgetRoot/root/view/minegold/Sprite", "UISprite");
    end
    return this.mMineCoinType_UISprite;
end

function UIBettingDialog:GetBackGround_UISprite()
    if (this.mBackGround_UISprite == nil) then
        this.mBackGround_UISprite = this:GetCurComp("WidgetRoot/root/window/bg", "UISprite");
    end
    return this.mBackGround_UISprite;
end

--function UIBettingDialog:GetSlider_UISlider()
--    if(this.mSlider == nil) then
--        this.mSlider = this:GetCurComp("WidgetRoot/root/view/Slider","UISlider");
--    end
--    return this.mSlider;
--end

function UIBettingDialog:GetBetCount_UIInput()
    if (this.mBetCount_UIInput == nil) then
        this.mBetCount_UIInput = this:GetCurComp("WidgetRoot/root/view/betCount", "UIInput");
    end
    return this.mBetCount_UIInput;
end

function UIBettingDialog:GetArrowDialogViewComponent()
    if (this.mArrowDialogViewComponent == nil) then
        this.mArrowDialogViewComponent = CS.Utility_Lua.GetComponent(this:GetCurComp("WidgetRoot/root", "GameObject"), 'UIArrowDialogView');
    end
    return this.mArrowDialogViewComponent;
end

function UIBettingDialog:GetMinCount()
    return 1;
end

--endregion

--region Method

--region Public

function UIBettingDialog:UpdateUI()
    this:UpdateBetsNum();
    if (this.mPlayerData ~= nil) then
        --this:GetPlayerName_Text().text = this:GetDesWhitState().."第"..this.mPlayerData.no.."名";
        --this:GetPlayerIcon_UISprite().spriteName = Utility.GetPlayerHeadIconSpriteName(this.mPlayerData.sex, this.mPlayerData.career);
        --local currentOdds = 0;
        --if(this.mState == CS.BuDouKaiStage.FRISTREST) then
        --    currentOdds = this.mOddsA / 1000;
        --elseif(this.mState == CS.BuDouKaiStage.SCEONDREST) then
        --    currentOdds = this.mOddsB / 1000;
        --end
        --this:GetCurrentOdds_Text().gameObject:SetActive(currentOdds ~= 0);
        --this:GetCurrentOdds_Text().text = Utility.GetPreciseDecimal(currentOdds, 2);
    end
end

function UIBettingDialog:UpdateBetsNum()
    local coinsNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId());
    --if(not isFind) then
    --    coinsNum = 0;
    --end
    --local mMaxNum = math.floor(coinsNum / CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate());
    --local maxNum = this.mMaxBetNum > mMaxNum and mMaxNum or this.mMaxBetNum;
    local maxNum = this.mMaxBetNum;
    if (this:GetBetCount_UIInput().value == "") then
        this:GetBetCount_UIInput().value = this:GetMinCount();
    end
    local value = tonumber(this:GetBetCount_UIInput().value);
    value = value < this:GetMinCount() and this:GetMinCount() or value;
    value = value > maxNum and maxNum or value;
    this:GetBetCount_UIInput().value = value;

    local needCostNum = value * CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate();
    this:GetMineCoinNum_Text().text = (coinsNum >= needCostNum and luaEnumColorType.White or luaEnumColorType.Red) .. coinsNum .. "[-]";
    --this:GetBetCount_UIInput().value = math.floor(this:GetSlider_UISlider().value * maxNum );
    this:UpdateBetsCoinNum();
end

function UIBettingDialog:UpdateBetsCoinNum()
    if (this:GetBetCount_UIInput().value == "") then
        this:GetBetCount_UIInput().value = this:GetMinCount();
    end
    this:GetBetsCoinNum_Text().text = math.floor(tonumber(this:GetBetCount_UIInput().value)) * CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate();
end

function UIBettingDialog:UpdateCoinType()
    local coinId = CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId();
    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(coinId);
    if (isFind) then
        this:GetCoinType_UISprite().spriteName = itemTable.icon;
        this:GetMineCoinType_UISprite().spriteName = itemTable.icon;
    end
end

function UIBettingDialog:UpdateArrowComponent(arrowDirType, wordPosition, offset)
    this:GetArrowDialogViewComponent():UpdateView(arrowDirType, wordPosition, offset, this:GetBackGround_UISprite().height);
end

--endregion

--region Private

---获得下注状态, 0:无异常可下注, 1:下注已达上限, 2:货币不足
function UIBettingDialog:GetBetStateCode()
    if (this.mMaxBetNum <= 0) then
        return 1;
    else
        local mBetsNum = math.floor(tonumber(this:GetBetCount_UIInput().value));
        local coinId = CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId();
        local needCostNum = mBetsNum * CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate();
        local mCostNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(coinId);
        if (mCostNum < needCostNum) then
            return 2;
        end
    end
    return 0;
end

function UIBettingDialog:GetDesWhitState()
    if (this.mState ~= nil) then
        if (this.mState == CS.BuDouKaiStage.FRISTREST) then
            return "选拔赛";
        elseif (this.mState == CS.BuDouKaiStage.SCEONDREST) then
            return "晋级赛";
        end
    end
    return "选拔赛";
end

function UIBettingDialog:InitEvents()
    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIBettingDialog");
    end

    --CS.UIEventListener.Get(this:GetBtnCancel_GameObject()).onClick = function()
    --    uimanager:ClosePanel("UIBettingDialog");
    --end

    CS.UIEventListener.Get(this:GetBtnBet_GameObject()).onClick = function()
        if (this.mPlayerData ~= nil) then
            local stateCode = self:GetBetStateCode();
            local mBetsNum = math.floor(tonumber(this:GetBetCount_UIInput().value));
            if (stateCode == 1) then
                local TipsInfo = {}
                TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnBet_GameObject().transform;
                TipsInfo[LuaEnumTipConfigType.ConfigID] = 263
                TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIBettingDialog"
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
            elseif (stateCode == 2) then
                local TipsInfo = {}
                local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId());
                if (itemName == nil) then
                    itemName = "元宝";
                end
                TipsInfo[LuaEnumTipConfigType.Describe] = itemName .. "不足";
                TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnBet_GameObject().transform;
                TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
                return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
            else
                networkRequest.ReqDuboBet(self.mPlayerData.playerId, CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage == CS.BuDouKaiStage.SCEONDREST, mBetsNum);
                uimanager:ClosePanel("UIBettingDialog");
            end
            networkRequest.ReqMapCommon(3, nil, nil, this.mPlayerData.playerId);
        end
    end

    CS.UIEventListener.Get(this:GetBtnAdd_GameObject()).onClick = function()
        local value = tonumber(this:GetBetCount_UIInput().value);
        value = value + 1;
        this:GetBetCount_UIInput().value = value;
        this:UpdateBetsNum();
    end

    CS.UIEventListener.Get(this:GetBtnReduce_GameObject()).onClick = function()
        local value = tonumber(this:GetBetCount_UIInput().value);
        value = value - 1;
        local coinsNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId());
        local mMaxNum = math.floor(coinsNum / CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate());
        local maxNum = this.mMaxBetNum > mMaxNum and mMaxNum or this.mMaxBetNum;
        value = value < this:GetMinCount() and maxNum or value;
        this:GetBetCount_UIInput().value = value;
        this:UpdateBetsNum();
    end

    CS.EventDelegate.Add(this:GetBetCount_UIInput().onChange, function()
        local coinsNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(CS.Cfg_GlobalTableManager.Instance:GetWDHBetsCoinId());
        --if (not isFind) then
        --    coinsNum = 0;
        --end
        --local mMaxNum = math.floor(coinsNum / CS.Cfg_GlobalTableManager.Instance:GetWDHBetsExchangeRate());
        --local maxNum = this.mMaxBetNum > mMaxNum and mMaxNum or this.mMaxBetNum;
        local maxNum = this.mMaxBetNum;
        local num = this:GetBetCount_UIInput().value == "" and 0 or tonumber(this:GetBetCount_UIInput().value);
        num = num == nil and maxNum or num;
        num = num > maxNum and maxNum or num;
        num = num < 0 and 0 or num;
        this:GetBetCount_UIInput().value = num;
        this:UpdateBetsCoinNum();
    end);

    this.OnResCommonMessage = function(msgId, msgData)
        if (msgData ~= nil) then
            if (msgData.type == LuaEnumCommonMapMsgType.BUDOUKAI_ODDS) then
                this.mOddsA = msgData.data;
                this.mOddsB = msgData.data64;
                this.mMaxBetNum = CS.CSScene.MainPlayerInfo.BudowillInfo.MaxZhu;
                this:UpdateUI();
            end
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMapCommonMessage, this.OnResCommonMessage)
end
--endregion

--endregion

function UIBettingDialog:Init()
    this = self;
    this:InitEvents();
end

function UIBettingDialog:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.offset == nil) then
        customData.offset = CS.UnityEngine.Vector2.zero;
    end

    --local mainChatPanel = uimanager:GetPanel("UIMainChatPanel");
    --customData.target = mainChatPanel.btn_bag;
    if (customData.target ~= nil) then
        this:UpdateArrowComponent(LuaEnumWayGetPanelArrowDirType.Left, customData.target.transform.position, customData.offset);
    end

    this.mPlayerData = customData.playerData;
    this.mState = customData.state;
    this:UpdateUI();
    this:UpdateCoinType();
    this:GetBetCount_UIInput().value = this:GetMinCount();
    if (this.mPlayerData ~= nil) then
        networkRequest.ReqMapCommon(3, nil, nil, this.mPlayerData.playerId);
    end
end

return UIBettingDialog;
