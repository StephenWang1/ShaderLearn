local UIRechargeFirstTips = {}

--region 局部变量
UIRechargeFirstTips.mCurIndex = 0
UIRechargeFirstTips.GridDic = {}
UIRechargeFirstTips.isCanGetReward = false

function UIRechargeFirstTips:GetShouldPayMoney()
    local surpluscount = math.floor(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCostByIndex(self.mCurIndex + 1) -
            UIRechargeFirstTips:GetResSendRechargeInfo().firstRechargeRmb)
    return surpluscount > 0 and surpluscount or 0
end
--endregion

--region 组件
function UIRechargeFirstTips.GetModelRoot_Transform()
    if (UIRechargeFirstTips.mView == nil) then
        UIRechargeFirstTips.mView = UIRechargeFirstTips:GetCurComp("WeaponEffecShow", "Transform")
    end
    return UIRechargeFirstTips.mView
end

function UIRechargeFirstTips.GetModel_ObservationModel()
    if (UIRechargeFirstTips.mModel == nil) then
        UIRechargeFirstTips.mModel = CS.ObservationModel()
    end
    return UIRechargeFirstTips.mModel
end

function UIRechargeFirstTips.GetWeaponEffecShow_Transform()
    if (UIRechargeFirstTips.mWeaponEffecShow == nil) then
        UIRechargeFirstTips.mWeaponEffecShow = UIRechargeFirstTips:GetCurComp("WeaponEffecShow", "Transform")
    end
    return UIRechargeFirstTips.mWeaponEffecShow
end

function UIRechargeFirstTips.GetCloseBtn_GameObject()
    if (UIRechargeFirstTips.mCloseBtn == nil) then
        UIRechargeFirstTips.mCloseBtn = UIRechargeFirstTips:GetCurComp("CloseBtn", "GameObject")
    end
    return UIRechargeFirstTips.mCloseBtn
end

function UIRechargeFirstTips.GetRechargeBtn_GameObject()
    if (UIRechargeFirstTips.mRechargeBtn == nil) then
        UIRechargeFirstTips.mRechargeBtn = UIRechargeFirstTips:GetCurComp("RechargeBtn", "GameObject")
    end
    return UIRechargeFirstTips.mRechargeBtn
end

function UIRechargeFirstTips.GetRechargeBtn_UISprite()
    if (UIRechargeFirstTips.mRechargeBtnSprite == nil) then
        UIRechargeFirstTips.mRechargeBtnSprite = UIRechargeFirstTips:GetCurComp("RechargeBtn", "UISprite")
    end
    return UIRechargeFirstTips.mRechargeBtnSprite
end

function UIRechargeFirstTips.GetRechargeBtnLabel_GameObject()
    if (UIRechargeFirstTips.mRechargeBtnLabelGo == nil) then
        UIRechargeFirstTips.mRechargeBtnLabelGo = UIRechargeFirstTips:GetCurComp("RechargeBtn/label", "GameObject")
    end
    return UIRechargeFirstTips.mRechargeBtnLabelGo
end

function UIRechargeFirstTips:GetRechargeBtnEffect_Go()
    if (self.mRechargeBtnUIEffectLoad == nil) then
        self.mRechargeBtnUIEffectLoad = self:GetCurComp("RechargeBtn/buttonEffect", "GameObject")
    end
    return self.mRechargeBtnUIEffectLoad
end

function UIRechargeFirstTips.GetRewardItemList_UIGridContainer()
    if (UIRechargeFirstTips.mRewardItemList == nil) then
        UIRechargeFirstTips.mRewardItemList = UIRechargeFirstTips:GetCurComp("RewardItemList", "Top_UIGridContainer")
    end
    return UIRechargeFirstTips.mRewardItemList
end

function UIRechargeFirstTips.GetDayBtn_UIGridContainer()
    if (UIRechargeFirstTips.mDayBtnGrid == nil) then
        UIRechargeFirstTips.mDayBtnGrid = UIRechargeFirstTips:GetCurComp("Btn/btns", "Top_UIGridContainer")
    end
    return UIRechargeFirstTips.mDayBtnGrid
end

function UIRechargeFirstTips.GetRewardName_UISprite()
    if (UIRechargeFirstTips.mRewardName == nil) then
        UIRechargeFirstTips.mRewardName = UIRechargeFirstTips:GetCurComp("bgs/name", "Top_UISprite")
    end
    return UIRechargeFirstTips.mRewardName
end

function UIRechargeFirstTips.GetRewardIcon_UIEffectLoad()
    if (UIRechargeFirstTips.mRewardIcon == nil) then
        UIRechargeFirstTips.mRewardIcon = UIRechargeFirstTips:GetCurComp("text1", "CSUIEffectLoad")
    end
    return UIRechargeFirstTips.mRewardIcon
end

function UIRechargeFirstTips.GetRewardTips_UILabel()
    if (UIRechargeFirstTips.mRewardTips == nil) then
        UIRechargeFirstTips.mRewardTips = UIRechargeFirstTips:GetCurComp("text3", "UILabel")
    end
    return UIRechargeFirstTips.mRewardTips
end

function UIRechargeFirstTips:GetResSendRechargeInfo()
    return gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetResSendRechargeInfo()
end
--endregion

--region 初始化
function UIRechargeFirstTips:Init()
    self:BindUIEvents()
    self.BindMessage()
end

function UIRechargeFirstTips:Show(customData)
    if (customData ~= nil) then
        self.customData = customData
    end
    local sloganpanel = uimanager:GetPanel("UIRechargeFirstSloganTipsPanel")
    if (sloganpanel ~= nil and sloganpanel.mPushType == LuaEnumFirstRechargePushType.FirstRechargePush) then
        if (sloganpanel.mNewPushTime ~= 0) then
            sloganpanel.mPushType = LuaEnumFirstRechargePushType.NewServerPush
            sloganpanel:Show(LuaEnumFirstRechargePushType.NewServerPush, sloganpanel.mNewPushTime)
        else
            local UIRechargeFirstSloganTipsPanel = uimanager:GetPanel("UIRechargeFirstSloganTipsPanel")
            if UIRechargeFirstSloganTipsPanel ~= nil then
                UIRechargeFirstSloganTipsPanel:HidePanel()
            end
        end
    end
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.FirstRecharge
    networkRequest.ReqGetRechargeInfo()
    UIRechargeFirstTips.RefreshDayGrid()
    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
        UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
    else
        if (CS.CSScene.MainPlayerInfo.RechargeInfo:IsCanReceiveTodayFirstRecharge()) then
            UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
        else
            UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel - 1)
        end
    end
end

function UIRechargeFirstTips:BindUIEvents()
    CS.UIEventListener.Get(UIRechargeFirstTips.GetCloseBtn_GameObject()).onClick = UIRechargeFirstTips.CloseBtnOnClick
    CS.UIEventListener.Get(UIRechargeFirstTips.GetRechargeBtn_GameObject()).onClick = function()
        self:RechargeResultBtnClick();
    end
end

function UIRechargeFirstTips.BindMessage()
    UIRechargeFirstTips:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendRechargeInfoMessage, UIRechargeFirstTips.RefreshReChargeResult)
end
--endregion

--region 客户端消息
function UIRechargeFirstTips.CloseBtnOnClick()
    uimanager:ClosePanel("UIRechargeFirstTips")
end

function UIRechargeFirstTips:RechargeBtnClick()
    if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
        if (self.customData ~= nil and self.customData.PanelLayerType ~= nil) then
            --uimanager:CreatePanel("UIRechargePanel", nil, { PanelLayerType = self.customData.PanelLayerType });
            uimanager:CreatePanel("UIRechargeMainPanel", nil, { PanelLayerType = self.customData.PanelLayerType, type = LuaEnumRechargeMainBookMarkType.Recharge })
        else
            --uimanager:CreatePanel("UIRechargePanel");
            uimanager:CreatePanel("UIRechargeMainPanel", nil, LuaEnumRechargeMainBookMarkType.Recharge)
        end
    end
end

---支付按钮
function UIRechargeFirstTips.RechargeResultBtnClick(go)
    if (UIRechargeFirstTips.isCanGetReward) then
        networkRequest.ReqGetFirstRechargeReward(UIRechargeFirstTips.mCurIndex)
    else
        Utility.SetPayRechargePoint()
        if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedFirstRechargeGift(UIRechargeFirstTips.mCurIndex)) then
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqGM("@43 " .. tostring(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCurRechargeTable(UIRechargeFirstTips:GetShouldPayMoney()):GetId()))
            else
                local data = Utility:GetPayData(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCurRechargeTable(UIRechargeFirstTips:GetShouldPayMoney()))
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end

        end
    end
end

function UIRechargeFirstTips.OnCheckItemClicked(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local itemTemp = UIRechargeFirstTips.GridDic[go]
        if itemTemp ~= nil and itemTemp.ItemInfo ~= nil then
            --打开物品信息界面
            local itemId = itemTemp.ItemInfo.id
            local isFakeItemId = CS.Cfg_GlobalTableManager.Instance:IsFakeItemId(itemId)
            local bagItemInfo = nil
            if isFakeItemId == true then
                bagItemInfo = CS.Cfg_ItemsFakeTipsTableManager.Instance:GetFakeBagItemInfoByItemId(itemId)
            end
            if bagItemInfo ~= nil then
                uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = false })
            else
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTemp.ItemInfo, showRight = false })
            end
        end
    end
end
--endregion

--region 刷新界面
function UIRechargeFirstTips:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRechargeFirstTips"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

function UIRechargeFirstTips.RefreshDayGrid()
    local list = CS.Cfg_GlobalTableManager.Instance.FirstRechargeBoxIDList
    UIRechargeFirstTips.GetDayBtn_UIGridContainer().MaxCount = list.Count
    for i = 0, list.Count - 1 do
        local go = UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList[i]
        CS.Utility_Lua.GetComponent(go.transform:Find("backGround"), "Top_UISprite").spriteName = "Firstrecharge_btn" .. tostring(i * 2 + 1)
        CS.Utility_Lua.GetComponent(go.transform:Find("check"), "Top_UISprite").spriteName = "Firstrecharge_btn" .. tostring(i * 2 + 2)
        CS.UIEventListener.Get(go).onClick = function()
            UIRechargeFirstTips.RefreshUI(i)
        end
    end
end

function UIRechargeFirstTips.RefreshUI(index)
    UIRechargeFirstTips.mCurIndex = index
    --UIRechargeFirstTips.RefreshModel()
    UIRechargeFirstTips.RefreshGridContainer(index)
end

function UIRechargeFirstTips.RefreshGridContainer(index)
    if (index == nil) then
        index = 0
    end
    for i = 0, UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList.Count - 1 do
        local go = UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList[i]
        CS.Utility_Lua.GetComponent(go.transform:Find("check"), "Top_UISprite").alpha = 0
    end
    if (index >= UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList.Count) then
        index = UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList.Count - 1
        UIRechargeFirstTips.mCurIndex = index
    end
    local go = UIRechargeFirstTips.GetDayBtn_UIGridContainer().controlList[index]
    CS.Utility_Lua.GetComponent(go.transform:Find("check"), "Top_UISprite").alpha = 1

    UIRechargeFirstTips.RefreshReceiveState()

    UIRechargeFirstTips.GetRechargeBtn_UISprite():MakePixelPerfect()

    local iscFind, itemc = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20932)
    local ColorList = nil
    if (iscFind) then
        local flist = nil
        flist = itemc.value:Split("&")
        ColorList = flist[index + 1]:Split("#")
    end
    local BoxID = CS.Cfg_GlobalTableManager.Instance.FirstRechargeBoxIDList[index]
    local itemlist = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(BoxID)
    local rewardname = "Firstrecharge_name_day" .. tostring(index + 1)
    if (index == 2) then
        rewardname = rewardname .. "_"
        if CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior then
            rewardname = rewardname .. "1"
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) then
            rewardname = rewardname .. "2"
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) then
            rewardname = rewardname .. "3"
        end
    end
    UIRechargeFirstTips.GetRewardName_UISprite().spriteName = rewardname
    UIRechargeFirstTips.GetRewardName_UISprite():MakePixelPerfect()

    UIRechargeFirstTips.GetRewardIcon_UIEffectLoad():ChangeEffect(CS.Cfg_GlobalTableManager.Instance.FirstRechargeRewardEffectIDList[index])
    -- index 获取当前档位数值 减去 已充值数额
    if (UIRechargeFirstTips:GetResSendRechargeInfo().firstRechargeRmb ~= nil) then
        UIRechargeFirstTips.GetRewardTips_UILabel().text = "[eaa83f]再充值 [fb2a1a]" .. tostring(UIRechargeFirstTips:GetShouldPayMoney()) .. "元[-] 即可领取奖励"
    end

    local count = itemlist.Count
    UIRechargeFirstTips.GetRewardItemList_UIGridContainer().MaxCount = count
    for i = 0, count - 1 do
        local bagItemInfo
        local bagFind, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemlist[i].itemId)
        if (bagFind) then
            bagItemInfo = Info
        end
        if bagItemInfo ~= nil then
            local go = UIRechargeFirstTips.GetRewardItemList_UIGridContainer().controlList[i]
            if (UIRechargeFirstTips.GridDic[go] == nil) then
                UIRechargeFirstTips.GridDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGridItem)
            end
            UIRechargeFirstTips.GridDic[go]:RefreshUIWithItemInfo(bagItemInfo, bagItemInfo.count)
            UIRechargeFirstTips.GridDic[go].bagItemInfo = bagItemInfo
            if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedFirstRechargeGift(UIRechargeFirstTips.mCurIndex) and ColorList ~= nil) then
                CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite").color = CS.UnityEngine.Color.white
                local effectlaod = CS.Utility_Lua.GetComponent(go.transform:Find("bg"), "CSUIEffectLoad")
                effectlaod.effectId = ColorList[i + 1]
                effectlaod:ChangeEffect(effectlaod.effectId)
            else
                CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite").color = CS.UnityEngine.Color.gray
                CS.Utility_Lua.GetComponent(go.transform:Find("bg"), "CSUIEffectLoad"):DestroyEffect()
            end
            CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel").text = itemlist[i].count > 1 and itemlist[i].count or ""
            CS.UIEventListener.Get(go).onClick = UIRechargeFirstTips.OnCheckItemClicked
        end
    end
end

function UIRechargeFirstTips.RefreshModel()
    UIRechargeFirstTips.GetModel_ObservationModel():ClearModel()
    local isFind, item = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20930)
    local paramList = item.value:Split("#")
    local pos = CS.UnityEngine.Vector3(tonumber(paramList[2]), tonumber(paramList[3]), tonumber(paramList[4]))
    local rotation = CS.UnityEngine.Vector3(tonumber(paramList[5]), tonumber(paramList[6]), tonumber(paramList[7]))

    UIRechargeFirstTips.GetModel_ObservationModel():SetShowMotion(CS.CSMotion.ShowStand)
    UIRechargeFirstTips.GetModel_ObservationModel():SetPosition(pos)
    UIRechargeFirstTips.GetModel_ObservationModel():SetRotation(rotation)
    UIRechargeFirstTips.GetModel_ObservationModel():CreateModel(tonumber(paramList[1]), CS.EAvatarType.Monster, UIRechargeFirstTips.GetModelRoot_Transform(), function()
        UIRechargeFirstTips.GetModel_ObservationModel():SetScaleSizeforRatio(tonumber(paramList[8]))
    end)
    --UIRechargeFirstTips.GetModel_ObservationModel():SetPositionDeviation(servant.offsetX)
    UIRechargeFirstTips.GetModel_ObservationModel():SetBindRenderQueue()

    --UIRechargeFirstTips.GetModel_ObservationModel():SetDragRoot(UIRechargeFirstTips.GetModelRoot_Transform())
end

function UIRechargeFirstTips.RefreshReceiveState()
    ---如果累积充值额度大于当前档位，说明已解锁该档位，只需判断是否领取
    UIRechargeFirstTips:GetRechargeBtnEffect_Go():SetActive(false)
    if (UIRechargeFirstTips:GetResSendRechargeInfo().firstRechargeRmb >= gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCostByIndex(UIRechargeFirstTips.mCurIndex + 1)) then
        if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedFirstRechargeGift(UIRechargeFirstTips.mCurIndex)) then
            ---已领取
            UIRechargeFirstTips.GetRechargeBtn_UISprite().spriteName = "Receive"
            UIRechargeFirstTips.isCanGetReward = false
        else
            ---未领取
            UIRechargeFirstTips.GetRechargeBtn_UISprite().spriteName = "aj2"
            UIRechargeFirstTips.isCanGetReward = true
            UIRechargeFirstTips:GetRechargeBtnEffect_Go():SetActive(true)
        end
    else
        ---否则说明一定未解锁
        UIRechargeFirstTips.isCanGetReward = false
        UIRechargeFirstTips.GetRechargeBtn_UISprite().spriteName = "aj1"
    end
    UIRechargeFirstTips.GetRechargeBtn_UISprite():MakePixelPerfect()

end
--endregion

--region 网络消息处理
function UIRechargeFirstTips.RefreshReChargeResult(id, data)
    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
        UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
    else
        if (CS.CSScene.MainPlayerInfo.RechargeInfo:IsCanReceiveTodayFirstRecharge()) then
            UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
        else
            UIRechargeFirstTips.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel - 1)
        end
    end
    --if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge()) then
    --    if (CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel > UIRechargeFirstTips.mCurIndex) then
    --        UIRechargeFirstTips.GetRechargeBtn_UISprite().spriteName = "Receive"
    --    else
    --    end
    --    UIRechargeFirstTips.GetRechargeBtnLabel_GameObject():SetActive(false)
    --    UIRechargeFirstTips.GetRechargeBtn_UISprite():MakePixelPerfect()
    --end
end

--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSendRechargeInfoMessage, UIRechargeFirstTips.RefreshReChargeResult)
end

return UIRechargeFirstTips