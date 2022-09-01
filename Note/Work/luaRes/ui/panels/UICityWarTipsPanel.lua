---沙巴克左侧Tips面板
---@class UICityWarTipsPanel:UIBase
local UICityWarTipsPanel = {}

--region 局部变量定义
---沙巴克信息
UICityWarTipsPanel.mSabacInfo = nil

---活动是否开始
UICityWarTipsPanel.mIsWarBegin = false

---雕像击破时间
UICityWarTipsPanel.mStatueDestroyTime = nil

---占领沙巴克帮会id
UICityWarTipsPanel.mOccupyUnionId = 0
---占领沙巴克联盟Type
UICityWarTipsPanel.mOccupyLeagueType = 0

---雕像是否击破
UICityWarTipsPanel.mIsStatueDestroy = nil

---按钮特效显示
UICityWarTipsPanel.mIsEffectShow = false

---个人积分奖励UIItem字典
---@type table<CS.UnityEngine.GameObject, UIItem>
UICityWarTipsPanel.mPersonalRewardUnitDic = nil;

--endregion

--region 组件

function UICityWarTipsPanel:GetWindow_GameObject()
    if (UICityWarTipsPanel.mWindow_GameObject == nil) then
        UICityWarTipsPanel.mWindow_GameObject = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/window", "GameObject")
    end
    return UICityWarTipsPanel.mWindow_GameObject;
end

function UICityWarTipsPanel:GetView_GameObject()
    if (UICityWarTipsPanel.mView_GameObject == nil) then
        UICityWarTipsPanel.mView_GameObject = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view", "GameObject")
    end
    return UICityWarTipsPanel.mView_GameObject;
end

function UICityWarTipsPanel:GetRankBtn_GameObject()
    if (UICityWarTipsPanel.mRankBtn_GameObject == nil) then
        UICityWarTipsPanel.mRankBtn_GameObject = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/event/RankBtn", "GameObject")
    end
    return UICityWarTipsPanel.mRankBtn_GameObject;
end

---折叠按钮
function UICityWarTipsPanel.GetPopupButton_UISprite()
    if UICityWarTipsPanel.mPopupButton == nil then
        UICityWarTipsPanel.mPopupButton = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/event/PopupBtn", "UISprite")
    end
    return UICityWarTipsPanel.mPopupButton
end

---动画
function UICityWarTipsPanel.GetTween_TweenPosition()
    if UICityWarTipsPanel.mTween == nil then
        UICityWarTipsPanel.mTween = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root", "Top_TweenPosition")
    end
    return UICityWarTipsPanel.mTween
end

---当前占领帮会
function UICityWarTipsPanel:GetOccupyUnionLabel_UILabel()
    if UICityWarTipsPanel.mOccupyUnionLabel == nil then
        UICityWarTipsPanel.mOccupyUnionLabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/UnionName", "UILabel")
    end
    return UICityWarTipsPanel.mOccupyUnionLabel
end

---组队按钮
--function UICityWarTipsPanel.GetTeamButton_GameObject()
--    if UICityWarTipsPanel.mTeamButton == nil then
--        UICityWarTipsPanel .mTeamButton = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/event/btn_team", "GameObject")
--    end
--    return UICityWarTipsPanel.mTeamButton
--end

---泡点倍率
function UICityWarTipsPanel.GetMessageLabel_UILabel()
    if UICityWarTipsPanel.mMessageLabel == nil then
        UICityWarTipsPanel.mMessageLabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/Bumble", "UILabel")
    end
    return UICityWarTipsPanel.mMessageLabel
end

---累计经验
function UICityWarTipsPanel.GetExpLabel_UILabel()
    if UICityWarTipsPanel.mExpLabel == nil then
        UICityWarTipsPanel.mExpLabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/Exp", "UILabel")
    end
    return UICityWarTipsPanel.mExpLabel
end

---个人积分
function UICityWarTipsPanel.GetScore_UILabel()
    if (UICityWarTipsPanel.mScore_UILabel == nil) then
        UICityWarTipsPanel.mScore_UILabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/Score", "UILabel")
    end
    return UICityWarTipsPanel.mScore_UILabel;
end

function UICityWarTipsPanel:GetOccupyUnionState_Text()
    if (UICityWarTipsPanel.mOccupyUnionState_Text == nil) then
        UICityWarTipsPanel.mOccupyUnionState_Text = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/OccupyUnion", "UILabel");
    end
    return UICityWarTipsPanel.mOccupyUnionState_Text;
end

---剩余时间
--function UICityWarTipsPanel:GetTimeLabel_UILabel()
--    if self.mTimeLabel == nil then
--        self.mTimeLabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/CountDown", "UILabel")
--    end
--    return self.mTimeLabel
--end

---@return UICountdownLabel 倒计时
--function UICityWarTipsPanel:GetTimeLabel_UICountdownLabel()
--    if self.mTimeCountLabel == nil then
--        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/Root/view/CountDown", "UICountdownLabel")
--    end
--    return self.mTimeCountLabel
--end

function UICityWarTipsPanel:GetUnionOccupyUITimer()
    if (self.mUnionOccupyUITimer == nil) then
        self.mUnionOccupyUITimer = self:GetCurComp("WidgetRoot/Root/view/UnionName", "UITimer")
    end
    return self.mUnionOccupyUITimer;
end

---@return UICountdownLabel 总倒计时（用于倒计时最后60s使用）
--function UICityWarTipsPanel:GetCountTotal()
--    if self.mCountTotalTime == nil then
--        self.mCountTotalTime = self:GetCurComp("WidgetRoot/CountTotal", "UICountdownLabel")
--    end
--    return self.mCountTotalTime
--end

---@return UICountdownLabel 最后60秒倒计时
--function UICityWarTipsPanel:GetCountFinal()
--    if self.mCountFinal == nil then
--        self.mCountFinal = self:GetCurComp("CountFinal", "UICountdownLabel")
--    end
--    return self.mCountFinal
--end

---@return UICountdownLabel 占领帮会剩余时间倒计时
function UICityWarTipsPanel:GetOccupyUnionLabel_UICountdownLabel()
    if self.mOccupyUnionCountLabel == nil then
        self.mOccupyUnionCountLabel = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/view/UnionName", "UICountdownLabel")
    end
    return self.mOccupyUnionCountLabel
end

---帮助按钮
function UICityWarTipsPanel.GetHelpButton_GameObject()
    if UICityWarTipsPanel.mHelpButton == nil then
        UICityWarTipsPanel.mHelpButton = UICityWarTipsPanel:GetCurComp("WidgetRoot/Root/event/btn_help", "GameObject")
    end
    return UICityWarTipsPanel.mHelpButton
end

---@return UICountdownLabel 击破雕像倒计时
--function UICityWarTipsPanel.GetDestroyTimeCount()
--    if UICityWarTipsPanel.mStatueDes == nil then
--        UICityWarTipsPanel.mStatueDes = UICityWarTipsPanel:GetCurComp("WidgetRoot/view/DestroyLabel", "UICountdownLabel")
--    end
--    return UICityWarTipsPanel.mStatueDes
--end

---@return UnityEngine.GameObject 按钮特效
function UICityWarTipsPanel:GetPopupEffect()
    if self.mPopupEffect == nil then
        self.mPopupEffect = self:GetCurComp("WidgetRoot/Root/event/PopupBtn/Effect", "GameObject")
    end
    return self.mPopupEffect
end

---沙巴克活动计时
function UICityWarTipsPanel:GetShaBaKTimer_UITimer()
    if self.mShaBaKTimer_UITimer == nil then
        self.mShaBaKTimer_UITimer = self:GetCurComp("WidgetRoot", "UITimer")
    end
    return self.mShaBaKTimer_UITimer;
end

---沙巴克活动结束倒计时
function UICityWarTipsPanel:GetShaBaKEndTimer_UITimer()
    if self.mShaBaKEndTimer_UITimer == nil then
        self.mShaBaKEndTimer_UITimer = self:GetCurComp("CountFinal", "UITimer")
    end
    return self.mShaBaKEndTimer_UITimer
end

function UICityWarTipsPanel:GetShBaKEndTimeSprite_GameObject()
    if self.mShBaKTimeSprite_GameObject == nil then
        self.mShBaKTimeSprite_GameObject = self:GetCurComp("CountFinal/Sprite", "GameObject")
    end
    return self.mShBaKTimeSprite_GameObject;
end

--endregion

---@private 新版积分
function UICityWarTipsPanel:GetNewScore_Text()
    if(self.mNewScore_Text == nil) then
        self.mNewScore_Text = self:GetCurComp("WidgetRoot/Root/view/mScore","UILabel")
    end
    return self.mNewScore_Text;
end
---@private 沙巴克奖励UI
function UICityWarTipsPanel:GetRewardGridContainer()
    if(self.mRewardGridContainer == nil) then
        self.mRewardGridContainer = self:GetCurComp("WidgetRoot/Root/view/gridContainer","UIGridContainer");
    end
    return self.mRewardGridContainer;
end

---@private 个人排行按钮
function UICityWarTipsPanel:GetPersonalRankBtnRankBtn_GameObject()
    if(self.mDetailsRankBtn_GameObject == nil) then
        self.mDetailsRankBtn_GameObject = self:GetCurComp("WidgetRoot/Root/event/PersonalRankBtn","GameObject")
    end
    return self.mDetailsRankBtn_GameObject;
end

--region属性
---活动信息
function UICityWarTipsPanel:GetDuplicateInfo()
    if self.mDuplicateInfo == nil then
        self.mDuplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    end
    return self.mDuplicateInfo
end

---获取泡点经验倍率显示
function UICityWarTipsPanel:GetBubbleExpRateInfo()
    if self.mMapIDToBubbleExp == nil then
        self.mMapIDToBubbleExp = CS.Cfg_GlobalTableManager.Instance:GetIntListListInfo(20109)
    end
    return self.mMapIDToBubbleExp
end

function UICityWarTipsPanel:GetShaBaKRankType()
    return CS.duplicateV2.SabacRankType.Kill;
end

--endregion

--region 初始化
function UICityWarTipsPanel:Init()
    self:BindEvents()
    self:BindMessage()
    self:InitPanel()
    --local unionOccupyTime = CS.Cfg_GlobalTableManager.Instance:GetUnionOccupyTime();
    self:GetShBaKEndTimeSprite_GameObject().gameObject:SetActive(false);
end

function UICityWarTipsPanel:Show()
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
    if (uiMainMenusPanel ~= nil) then
        uiMainMenusPanel.MoveUILvpackPanel(false);
    end
    self:SetData()
    self:UpdateShaBaKInfo();
    self:UpdateScore();
    self:TryUpdateEndTimePosition();
    --self.GetScore_UILabel().text = luaEnumColorType.Green.."0[-]";
end

function UICityWarTipsPanel:BindEvents()
    CS.UIEventListener.Get(UICityWarTipsPanel.GetPopupButton_UISprite().gameObject).onClick = function()
        self:OnPopupButtonClicked()
    end
    --CS.UIEventListener.Get(UICityWarTipsPanel.GetTeamButton_GameObject()).onClick = UICityWarTipsPanel.OnTeamButtonClicked

    CS.UIEventListener.Get(UICityWarTipsPanel.GetHelpButton_GameObject()).onClick = UICityWarTipsPanel.OnButtonClickHelp

    CS.UIEventListener.Get(UICityWarTipsPanel:GetRankBtn_GameObject()).onClick = function()
        --uimanager:CreatePanel("UICityWarRankingPanel");

        uimanager:ClosePanel("UIActivityManEnterPanel");
        uiStaticParameter.mIsCurrentShaBaK = true;
        uimanager:CreatePanel("UIActivityRankPanel", function()
            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        end, {
            id = LuaEnuActivityRankID.ShaBaK,
            refreshCallBack = function()
                networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
            end
        })
    end
    CS.UIEventListener.Get(UICityWarTipsPanel:GetPersonalRankBtnRankBtn_GameObject()).onClick = function()
        uimanager:CreatePanel("UICityWarRankRewardPanel");
    end;
end

function UICityWarTipsPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacInfoMessage, UICityWarTipsPanel.OnResSabacInfoMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFlagDieMessage, UICityWarTipsPanel.OnResFlagDieMessageMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSabacScoreInfoMessage, UICityWarTipsPanel.OnResSabacScoreInfoMessage)
    UICityWarTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerTitleRefresh, function()
        self:TryUpdateEndTimePosition();
    end)
end
--endregion

--region 服务器事件
---@param tblData duplicateV2.SabacInfo
function UICityWarTipsPanel.OnResSabacInfoMessageReceived(msgID, tblData)
    UICityWarTipsPanel:UpdateShaBaKInfo();
end

---雕像死亡消息f
function UICityWarTipsPanel.OnResFlagDieMessageMessageReceived()
    --print("收到雕像击破消息")
    --if not CS.StaticUtility.IsNull(UICityWarTipsPanel.GetDestroyTimeCount()) then
    --    print("显示雕像击破文字")
    --    UICityWarTipsPanel.GetDestroyTimeCount().gameObject:SetActive(true)
    --    UICityWarTipsPanel.GetDestroyTimeCount():StartCountBySecond(nil, 5, 3, nil, nil, nil, function()
    --        UICityWarTipsPanel.GetDestroyTimeCount().gameObject:SetActive(false)
    --        print("隐藏雕像击破文字")
    --    end)
    --end
    if not UICityWarTipsPanel.mIsStatueDestroy then
        UICityWarTipsPanel:RefreshStatueDieState(true)
    end
end

---刷新雕死亡状态
function UICityWarTipsPanel:RefreshStatueDieState(state)
    self.mIsStatueDestroy = state
    self:GetDuplicateInfo():RefreshStatueState(state)
end

function UICityWarTipsPanel:UpdateOccupyText()
    if (self:GetDuplicateInfo().ShaBakInfo ~= nil and self:GetDuplicateInfo().ShaBakInfo.flagDieTime ~= 0) then
        self:GetOccupyUnionState_Text().text = "占领皇宫"
        if (self:GetOccupyUnionLabel_UILabel().text == luaEnumColorType.Red .. "未打破[-]") then
            self:GetOccupyUnionLabel_UILabel().text = "无";
        end
    else
        self:GetOccupyUnionState_Text().text = "雕像状态"
        self:GetOccupyUnionLabel_UILabel().text = luaEnumColorType.Red .. "未打破[-]";
    end
end

function UICityWarTipsPanel:UpdateShaBaKInfo()
    local shaBaKInfo = self:GetDuplicateInfo().ShaBakInfo;
    if shaBaKInfo ~= nil then

        self:UpdateOccupyText();
        ---刷新帮会信息
        local unionId = shaBaKInfo.unionId
        if shaBaKInfo.uniteType ~= 0 and shaBaKInfo.uniteType ~= nil then
            local isMineLeague = CS.CSScene.MainPlayerInfo.LeagueInfo.LeagueType == shaBaKInfo.uniteType;
            local tbl = clientTableManager.cfg_leagueManager:TryGetValue(shaBaKInfo.uniteType)
            if tbl and tbl:GetName() then
                UICityWarTipsPanel:GetOccupyUnionLabel_UILabel().text = (isMineLeague and luaEnumColorType.Blue2 or luaEnumColorType.Orange) .. tbl:GetName() .. "[-]";
            end

            if UICityWarTipsPanel.mOccupyLeagueType ~= shaBaKInfo.uniteType then
                UICityWarTipsPanel:GetUnionOccupyUITimer():StopTimer();
                if not UICityWarTipsPanel:GetDuplicateInfo().IsOpenShaBaKPanel then
                    UICityWarTipsPanel:SetEffectShow(true)
                end
                UICityWarTipsPanel.mOccupyLeagueType = shaBaKInfo.uniteType;
                UICityWarTipsPanel.mOccupyUnionId = 0

                UICityWarTipsPanel:GetDuplicateInfo():RefreshShabakLeagueType(shaBaKInfo.uniteType)
                UICityWarTipsPanel:GetDuplicateInfo():RefreshShabakUnionId(0)
            end
        elseif UICityWarTipsPanel.mOccupyUnionId ~= unionId then
            if shaBaKInfo.unionName ~= nil and shaBaKInfo.unionName ~= "" then
                local isMineUnion = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == unionId;
                UICityWarTipsPanel:GetOccupyUnionLabel_UILabel().text = (isMineUnion and luaEnumColorType.Blue2 or luaEnumColorType.Orange) .. shaBaKInfo.unionName .. "[-]";
                --UICityWarTipsPanel:GetOccupyUnionLabel_UILabel().text = luaEnumColorType.Green .. shaBaKInfo.unionName.."[-]";
                UICityWarTipsPanel:GetUnionOccupyUITimer():StopTimer();
            end

            UICityWarTipsPanel:GetDuplicateInfo():RefreshShabakUnionId(unionId)
            UICityWarTipsPanel:GetDuplicateInfo():RefreshShabakLeagueType(0)

            if not UICityWarTipsPanel:GetDuplicateInfo().IsOpenShaBaKPanel then
                UICityWarTipsPanel:SetEffectShow(true)
            end
            UICityWarTipsPanel.mOccupyUnionId = unionId;
            UICityWarTipsPanel.mOccupyLeagueType = 0
        end

        if (shaBaKInfo.flagDieTime == nil) then
            shaBaKInfo.flagDieTime = 0;
        end

        ---刷新雕像死亡状态
        local isStatueDestroy = shaBaKInfo.flagDieTime ~= 0
        if isStatueDestroy and UICityWarTipsPanel.mStatueDestroyTime == nil then
            UICityWarTipsPanel.mStatueDestroyTime = shaBaKInfo.flagDieTime
        end

        ---帮会占领生效时间(从雕像倒塌后开始算)
        local GetTargetTime = function()
            local unionOccupyTime = CS.Cfg_GlobalTableManager.Instance:GetUnionOccupyTime();
            local intervalTime = CS.CSServerTime.Instance.TotalMillisecond - shaBaKInfo.flagDieTime;
            local targetTime = (unionOccupyTime * 1000 - intervalTime);
            return targetTime;
        end

        local targetTime = GetTargetTime();
        if (isStatueDestroy) then
            if (targetTime > 0 and UICityWarTipsPanel:GetUnionOccupyUITimer().gameObject.activeSelf) then
                UICityWarTipsPanel:GetUnionOccupyUITimer():StartTimer(targetTime, function()
                    UICityWarTipsPanel:GetOccupyUnionLabel_UILabel().text = luaEnumColorType.White .. "无";
                    UICityWarTipsPanel.mOccupyUnionId = 0;
                    UICityWarTipsPanel.mOccupyLeagueType = 0;
                end, function()
                    return GetTargetTime()
                end);
            elseif (UICityWarTipsPanel.mOccupyUnionId == 0 and UICityWarTipsPanel.mOccupyLeagueType == 0) then
                UICityWarTipsPanel:GetOccupyUnionLabel_UILabel().text = luaEnumColorType.White .. "无";
            end
        end

        if UICityWarTipsPanel.mIsStatueDestroy ~= isStatueDestroy then
            UICityWarTipsPanel:RefreshStatueDieState(isStatueDestroy)
        end
        --if(tblData.yuanbao ~= nil) then
        --    UICityWarTipsPanel.GetExpLabel_UILabel().text = tblData.yuanbao --tblData.yuanbao.."/"..maxNum;
        --else
        --    UICityWarTipsPanel.GetExpLabel_UILabel().text = 0 --"0/"..maxNum;
        --end
        ---活动如果关闭就切回原来的界面
        if (not shaBaKInfo.isOpen) then
            local manMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
            if (manMenusPanel ~= nil) then
                local id = CS.CSScene:getMapID()
                manMenusPanel:OnResScene_OpenPanel(id);
            end
        end
    end
end

function UICityWarTipsPanel.OnResSabacScoreInfoMessage(msgId, msgData)
    UICityWarTipsPanel:UpdateScore();
end

---帮助按钮点击
function UICityWarTipsPanel.OnButtonClickHelp()
    local helpId = 86;
    local isFind, desTable = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(helpId)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, desTable)
    end
end

---刷新泡点元宝显示
function UICityWarTipsPanel:RefreshBubbleExp()
    --local mapId = CS.CSScene:getMapID()
    --local magnification = self:GetBubbleExp(mapId)
    --UICityWarTipsPanel.GetMessageLabel_UILabel().text = magnification * 100 .. "%"
    local singleNum, maxNum = CS.Cfg_LevelTableManager.Instance:TryGetShaBakYuanBaoSingleAndMaxNum();
    if (CS.CSScene.MainPlayerInfo:IsInShaBakHuangGong()) then
        UICityWarTipsPanel.GetMessageLabel_UILabel().text = "每" .. luaEnumColorType.Green .. CS.Cfg_GlobalTableManager.Instance:GetShaBakYuanBoaInterval() .. "[-]秒获得" .. singleNum .. "元宝";
    else
        UICityWarTipsPanel.GetMessageLabel_UILabel().text = "-----";
    end

end

---获取泡点经验
function UICityWarTipsPanel:GetBubbleExp(mapId)
    local magnification = 0
    if mapId then
        ___, magnification = self:GetBubbleExpRateInfo():TryGetValue(mapId)
    end
    return magnification
end
--endregion

--region UI事件
---初始化界面
function UICityWarTipsPanel:InitPanel()
    --self:RefreshBubbleExp()
    self:UpdateTimer()
end

function UICityWarTipsPanel:UpdateScore()
    --local score = CS.CSScene.MainPlayerInfo.DuplicateV2:GetMyShaBaKScore();
    --local scoreStr = tostring(math.floor(score));
    --if (score > math.floor(score)) then
    --    local tempScore = math.floor(score * 10) / 10;
    --    scoreStr = string.format('%.1f', tempScore);
    --end
    --
    --local colorStr = score > 0 and luaEnumColorType.White or luaEnumColorType.White;
    --self.GetScore_UILabel().text = colorStr .. scoreStr .. "[-]";

    local score = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetShaBaKScore();
    local scoreStr = tostring(math.floor(score));
    if (score > math.floor(score)) then
        local tempScore = math.floor(score * 10) / 10;
        scoreStr = string.format('%.1f', tempScore);
    end
    local rewardTbl = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetCurrentShowRewardTbl()
    local nextScore = 200;
    if(rewardTbl ~= nil) then
        nextScore = rewardTbl:GetPoint();
    end
    local isEnough = score >= nextScore;
    local colorStr = isEnough and luaEnumColorType.White or luaEnumColorType.Red;
    self:GetNewScore_Text().text = colorStr .. scoreStr.."[-]/"..nextScore;

    self:UpdatePersonalReward(isEnough);
end

function UICityWarTipsPanel:UpdatePersonalReward(isEnough)
    if(self.mPersonalRewardUnitDic == nil) then
        self.mPersonalRewardUnitDic = {};
    end

    local rewardPointTbl = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetCurrentShowRewardTbl();
    local rewards = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetPersonalRewardItems(rewardPointTbl);
    local gridContainer = self:GetRewardGridContainer();
    gridContainer.MaxCount = #rewards;
    for k,v in pairs(rewards) do
        local gobj = gridContainer.controlList[k - 1];
        if(self.mPersonalRewardUnitDic[gobj] == nil) then
            self.mPersonalRewardUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIItem);
        end
        local geted = CS.Utility_Lua.GetComponent(gobj.transform:Find("geted"), "GameObject")
        geted:SetActive(isEnough);
        local itemId = v[1];
        local num = v[2];
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if(isFind) then
            self.mPersonalRewardUnitDic[gobj]:RefreshUIWithItemInfo(itemTable, num);
            CS.UIEventListener.Get(gobj).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, nil, showRight = false });
            end
        end
    end
end

---显示时间
function UICityWarTipsPanel:UpdateTimer()

    local tryChangeMainMenusPanel = function()
        local mainMenusPanel = uimanager:GetPanel("UIMainMenusPanel");
        if (mainMenusPanel ~= nil) then
            mainMenusPanel:OnResScene_OpenPanel(CS.CSScene.MainPlayerInfo.MapID);
        end
        self:UpdateEndTimePosition();

        --if not Utility.IsSabacActivityChangeMissionPanel() then
        --    uiStaticParameter.mIsCurrentShaBaK = false;
        --    uimanager:CreatePanel("UIActivityRankThirdPanel", function()
        --        networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        --    end, {
        --        id = LuaEnuActivityRankID.ShaBaK,
        --        refreshCallBack = function()
        --            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(self:GetShaBaKRankType()), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        --        end
        --    })
        --end
    end

    --local calendarVo = CS.CSScene.MainPlayerInfo.DuplicateV2:GetTodayShaBaKCalendarVo()
    local activityItem = gameMgr:GetPlayerDataMgr():GetActivityMgr():GetCalendarActivity(LuaEnumDailyActivityType.ShaBaKe)
    local runningState = nil;
    ---@type LuaActivityItemSubInfo
    local activitySubItem = nil;
    if (activityItem ~= nil) then
        runningState, activitySubItem = activityItem:GetRunningState();
    end
    local isOpenShaBaK = Utility.IsOpenShaBaKe();
    if (isOpenShaBaK and activitySubItem ~= nil) then
        local GetTargetTime = function()
            local serverNowTimeStamp = math.floor(CS.CSServerTime.Instance.TotalMillisecond);
            local endTimeStamp = gameMgr:GetLuaTimeMgr():GetNowDayWeeHoursTime() + activitySubItem:GetOverTime() * 60 * 1000;
            return endTimeStamp - serverNowTimeStamp;
        end
        local intervalTime = GetTargetTime();
        self:GetShBaKEndTimeSprite_GameObject().gameObject:SetActive(false);
        if (intervalTime > 0) then
            self:GetShBaKEndTimeSprite_GameObject().gameObject:SetActive(true);
            self:GetShaBaKTimer_UITimer():StartTimer(intervalTime, function()
                self:GetShaBaKTimer_UITimer().mTimeText.text = "";
                tryChangeMainMenusPanel();
            end, function()
                return GetTargetTime();
            end);

            self:GetShaBaKEndTimer_UITimer():StartTimer(intervalTime,
                    function()
                        self:UpdateEndTimePosition();
                    end,
                    function()
                        self:GetShaBaKEndTimer_UITimer().mTimeText.text = "";
                        self:GetShBaKEndTimeSprite_GameObject().gameObject:SetActive(false);
                        tryChangeMainMenusPanel();
                    end,
                    function()
                        return GetTargetTime();
                    end);
        else
            tryChangeMainMenusPanel();
        end
    else
        tryChangeMainMenusPanel();
    end
end

function UICityWarTipsPanel:TryUpdateEndTimePosition()
    if (CS.CSScene.MainPlayerInfo.IAvater == nil or CS.CSScene.MainPlayerInfo.IAvater.Head == nil) then
        if (self.mCoroutineUpdateEndTimePosition ~= nil) then
            StopCoroutine(self.mCoroutineUpdateEndTimePosition);
            self.mCoroutineUpdateEndTimePosition = nil;
        end
        self.mCoroutineUpdateEndTimePosition = StartCoroutine(self.CUpdateEndTimePosition, self);
    else
        self:UpdateEndTimePosition();
    end
end

function UICityWarTipsPanel:UpdateEndTimePosition()
    local dx = 60;
    --if (self:GetShaBaKEndTimer_UITimer().TimeStamp < 10000) then
    --    dx = 64;
    --elseif (self:GetShaBaKEndTimer_UITimer().TimeStamp < 100000) then
    --    dx = 32;
    --end
    ---y方向放到220位置
    local pos = self:GetShaBaKEndTimer_UITimer().gameObject.transform.localPosition
    pos.y = 220
    self:GetShaBaKEndTimer_UITimer().gameObject.transform.localPosition = pos;
    ---x方向根据屏幕适配,从屏幕中央向右位移上面计算出来的像素值
    pos = self:GetShaBaKEndTimer_UITimer().gameObject.transform.position
    --print("self:GetShaBaKEndTimer_UITimer()", self:GetShaBaKEndTimer_UITimer())
    --print("dx", dx)
    pos.x = self:GetShaBaKEndTimer_UITimer().transform.parent:TransformVector(dx, 0, 0).x
    --CS.UnityEngine.Debug.Log("self:GetShaBaKEndTimer_UITimer().transform", self:GetShaBaKEndTimer_UITimer().transform)
    --print("pos.x", pos.x)
    --print(pos)
    self:GetShaBaKEndTimer_UITimer().gameObject.transform.position = pos
    --print("self:GetShaBaKEndTimer_UITimer().gameObject.transform", self:GetShaBaKEndTimer_UITimer().gameObject.transform.localPosition)
end

---CSHead没有加载出来的话就轮询等待加载完毕
function UICityWarTipsPanel:CUpdateEndTimePosition()
    while (CS.CSScene.MainPlayerInfo.IAvater == nil or CS.CSScene.MainPlayerInfo.IAvater.Head == nil) do
        coroutine.yield(0);
    end
    self:UpdateEndTimePosition();
end

---活动结束
--function UICityWarTipsPanel:ActivityOver()
--    self:GetCountFinal().gameObject:SetActive(false)
--end

---点击小箭头
function UICityWarTipsPanel:OnPopupButtonClicked()
    self:GetDuplicateInfo().IsOpenShaBaKPanel = not self:GetDuplicateInfo().IsOpenShaBaKPanel
    self:SetData()
    if self:GetDuplicateInfo().IsOpenShaBaKPanel and self.mIsEffectShow then
        self:SetEffectShow(false)
    end
end

---设置并存储数据
function UICityWarTipsPanel:SetData()
    if self:GetDuplicateInfo().IsOpenShaBaKPanel then
        UICityWarTipsPanel.GetPopupButton_UISprite().flip = CS.UIBasicSprite.Flip.Horizontally
        UICityWarTipsPanel.GetTween_TweenPosition():SetOnFinished(function()
            UICityWarTipsPanel:GetUnionOccupyUITimer().gameObject:SetActive(false);
            UICityWarTipsPanel:GetWindow_GameObject():SetActive(false);
            UICityWarTipsPanel:GetView_GameObject():SetActive(false);
            UICityWarTipsPanel.GetHelpButton_GameObject():SetActive(false);
        end);
        UICityWarTipsPanel.GetTween_TweenPosition():PlayForward()
    else
        UICityWarTipsPanel.GetPopupButton_UISprite().flip = CS.UIBasicSprite.Flip.Nothing
        UICityWarTipsPanel:GetWindow_GameObject():SetActive(true);
        UICityWarTipsPanel:GetView_GameObject():SetActive(true);
        UICityWarTipsPanel:GetUnionOccupyUITimer().gameObject:SetActive(true);
        UICityWarTipsPanel.GetHelpButton_GameObject():SetActive(true);
        UICityWarTipsPanel.GetTween_TweenPosition().onFinished:Clear();
        UICityWarTipsPanel.GetTween_TweenPosition():PlayReverse()
    end
    local isOpen = ternary(self:GetDuplicateInfo().IsOpenShaBaKPanel, 1, 0)
    local playerInfo = CS.CSScene.MainPlayerInfo
    if playerInfo then
        playerInfo.ConfigInfo:SetInt(CS.EConfigOption.ShabakPanelOpenState, isOpen)
        networkRequest.ReqSaveRoleSettings(playerInfo.ConfigInfo:GetRoleSettingList())
    end
end

---点击组队
function UICityWarTipsPanel.OnTeamButtonClicked()
    --uimanager:CreatePanel('UITeamPanel')
end

---点击帮助按钮
function UICityWarTipsPanel.OnHelpButtonClicked()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(81)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---设置按钮特效显示
function UICityWarTipsPanel:SetEffectShow(isShow)
    UICityWarTipsPanel.mIsEffectShow = isShow
    UICityWarTipsPanel:GetPopupEffect():SetActive(isShow)
end

--endregion

function update()
    ---每隔1s刷新一次,之前的逻辑未在合适的地方刷新!!!
    local time = CS.UnityEngine.Time.time
    if UICityWarTipsPanel.mUpdateTime == nil then
        UICityWarTipsPanel.mUpdateTime = time
    end
    if time >= UICityWarTipsPanel.mUpdateTime then
        UICityWarTipsPanel.mUpdateTime = time + 1
        UICityWarTipsPanel:UpdateEndTimePosition()
    end
end

--region onDestroy
function ondestroy()
    if (UICityWarTipsPanel.mCoroutineUpdateEndTimePosition ~= nil) then
        StopCoroutine(UICityWarTipsPanel.mCoroutineUpdateEndTimePosition);
        UICityWarTipsPanel.mCoroutineUpdateEndTimePosition = nil;
    end
end
--endregion

return UICityWarTipsPanel