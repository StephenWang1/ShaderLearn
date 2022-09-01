---@class UIDailyRechargePanel:UIBase
local UIDailyRechargePanel={}

--region组件
--奖励列表
function UIDailyRechargePanel:GetRewardItemList_UIGridContainer()
    if(UIDailyRechargePanel.mRewardItemList == nil) then
        UIDailyRechargePanel.mRewardItemList = UIDailyRechargePanel:GetCurComp("RewardItemList","Top_UIGridContainer")
    end
    return UIDailyRechargePanel.mRewardItemList
end
--左边最好奖励名字
function UIDailyRechargePanel.GetRewardName_UISprite()
    if (UIDailyRechargePanel.mRewardName == nil) then
        UIDailyRechargePanel.mRewardName = UIDailyRechargePanel:GetCurComp("bgs/name", "Top_UISprite")
    end
    return UIDailyRechargePanel.mRewardName
end
--充值金额滚动列表
function UIDailyRechargePanel.GetDayBtn_UIGridContainer()
    if (UIDailyRechargePanel.mDayBtnGrid == nil) then
        UIDailyRechargePanel.mDayBtnGrid = UIDailyRechargePanel:GetCurComp("Btn/btns", "Top_UIGridContainer")
    end
    return UIDailyRechargePanel.mDayBtnGrid
end
--领取/充值 按钮
function UIDailyRechargePanel.GetRechargeBtn_GameObject()
    if (UIDailyRechargePanel.mRechargeBtn == nil) then
        UIDailyRechargePanel.mRechargeBtn = UIDailyRechargePanel:GetCurComp("RechargeBtn", "GameObject")
    end
    return UIDailyRechargePanel.mRechargeBtn
end
--领取/充值 按钮字体背景
function UIDailyRechargePanel.GetRechargeBtn_UISprite()
    if (UIDailyRechargePanel.mRechargeBtnSprite == nil) then
        UIDailyRechargePanel.mRechargeBtnSprite = UIDailyRechargePanel:GetCurComp("RechargeBtn", "UISprite")
    end
    return UIDailyRechargePanel.mRechargeBtnSprite
end
--关闭面板按钮
function UIDailyRechargePanel.GetCloseBtn_GameObject()
    if (UIDailyRechargePanel.mCloseBtn == nil) then
        UIDailyRechargePanel.mCloseBtn = UIDailyRechargePanel:GetCurComp("CloseBtn", "GameObject")
    end
    return UIDailyRechargePanel.mCloseBtn
end

--endregion
--region init
function UIDailyRechargePanel:Init()
    self:BindEvent()
    self:BindMessage()
end

function UIDailyRechargePanel: BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick=UIDailyRechargePanel.onClick();
    CS.UIEventListener.Get(self:GetRechargeBtn_GameObject()).onClick= function()
        self:RechargeBtnClick()
    end
end

function UIDailyRechargePanel: BindMessage()
    UIDailyRechargePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendRechargeInfoMessage, UIDailyRechargePanel.RefreshReChargeResult)
end
--endregion

--region 客户端消息
function UIDailyRechargePanel.OnCloseClick()
    uimanager:ClosePanel("UIDailyRechargePanel")
end
function UIDailyRechargePanel:RechargeBtnClick()
    --打开首充面板
    Utility.TryShowFirstRechargePanel()
--[[    if (UIDailyRechargePanel.isCanGetReward) then
        UIDailyRechargePanel.ReqGetFirstRechargeReward(UIDailyRechargePanel.mCurIndex)
    else
        Utility.SetPayRechargePoint()
        if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedFirstRechargeGift(UIDailyRechargePanel.mCurIndex)) then
            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                networkRequest.ReqGM("@43 " .. tostring(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCurRechargeTable(UIDailyRechargePanel:GetShouldPayMoney()):GetId()))
            else
                local data = Utility:GetPayData(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCurRechargeTable(UIDailyRechargePanel:GetShouldPayMoney()))
                if (data ~= nil) then
                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                end
            end

        end
    end]]
end

--endregion
--region 网络回调
function UIDailyRechargePanel.RefreshReChargeResult(id, data)
    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
        UIDailyRechargePanel.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
    else
        if (CS.CSScene.MainPlayerInfo.RechargeInfo:IsCanReceiveTodayFirstRecharge()) then
            UIDailyRechargePanel.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel)
        else
            UIDailyRechargePanel.RefreshUI(CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel - 1)
        end
    end
end
--endregion
--region ui刷新
function UIDailyRechargePanel.RefreshUI(index)
    UIDailyRechargePanel.mCurIndex = index
    UIDailyRechargePanel.RefreshGridContainer(index)
end

function UIDailyRechargePanel.RefreshGridContainer(index)
    if (index == nil) then
        index = 0
    end
    for i = 0, UIDailyRechargePanel.GetDayBtn_UIGridContainer().controlList.Count - 1 do
        local go = UIDailyRechargePanel.GetDayBtn_UIGridContainer().controlList[i]
        CS.Utility_Lua.GetComponent(go.transform:Find("check"), "Top_UISprite").alpha = 0
    end
    if (index >= UIDailyRechargePanel.GetDayBtn_UIGridContainer().controlList.Count) then
        index = UIDailyRechargePanel.GetDayBtn_UIGridContainer().controlList.Count - 1
        UIDailyRechargePanel.mCurIndex = index
    end
    local go = UIDailyRechargePanel.GetDayBtn_UIGridContainer().controlList[index]
    CS.Utility_Lua.GetComponent(go.transform:Find("check"), "Top_UISprite").alpha = 1

    UIDailyRechargePanel.RefreshReceiveState()

    UIDailyRechargePanel.GetRechargeBtn_UISprite():MakePixelPerfect()

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
    UIDailyRechargePanel.GetRewardName_UISprite().spriteName = rewardname
    UIDailyRechargePanel.GetRewardName_UISprite():MakePixelPerfect()

    UIDailyRechargePanel.GetRewardIcon_UIEffectLoad():ChangeEffect(CS.Cfg_GlobalTableManager.Instance.FirstRechargeRewardEffectIDList[index])
    -- index 获取当前档位数值 减去 已充值数额
    if (UIDailyRechargePanel:GetResSendRechargeInfo().firstRechargeRmb ~= nil) then
        UIDailyRechargePanel.GetRewardTips_UILabel().text = "[eaa83f]再充值 [fb2a1a]" .. tostring(UIDailyRechargePanel:GetShouldPayMoney()) .. "元[-] 即可领取奖励"
    end

    local count = itemlist.Count
    UIDailyRechargePanel.GetRewardItemList_UIGridContainer().MaxCount = count
    for i = 0, count - 1 do
        local bagItemInfo
        local bagFind, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemlist[i].itemId)
        if (bagFind) then
            bagItemInfo = Info
        end
        if bagItemInfo ~= nil then
            local go = UIDailyRechargePanel.GetRewardItemList_UIGridContainer().controlList[i]
            if (UIDailyRechargePanel.GridDic[go] == nil) then
                UIDailyRechargePanel.GridDic[go] = UIDailyRechargePanel.GetNewTemplate(go, luaComponentTemplates.UIGridItem)
            end
            UIDailyRechargePanel.GridDic[go]:RefreshUIWithItemInfo(bagItemInfo, bagItemInfo.count)
            UIDailyRechargePanel.GridDic[go].bagItemInfo = bagItemInfo
            if (not gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsRecivedFirstRechargeGift(UIDailyRechargePanel.mCurIndex) and ColorList ~= nil) then
                CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite").color = CS.UnityEngine.Color.white
                local effectlaod = CS.Utility_Lua.GetComponent(go.transform:Find("bg"), "CSUIEffectLoad")
                effectlaod.effectId = ColorList[i + 1]
                effectlaod:ChangeEffect(effectlaod.effectId)
            else
                CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite").color = CS.UnityEngine.Color.gray
                CS.Utility_Lua.GetComponent(go.transform:Find("bg"), "CSUIEffectLoad"):DestroyEffect()
            end
            CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel").text = itemlist[i].count > 1 and itemlist[i].count or ""
            CS.UIEventListener.Get(go).onClick = UIDailyRechargePanel.OnCheckItemClicked
        end
    end
end
--endregion

function UIDailyRechargePanel:GetShouldPayMoney()
    local surpluscount = math.floor(gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetFirstRechargeCostByIndex(self.mCurIndex + 1) -
            UIDailyRechargePanel:GetResSendRechargeInfo().firstRechargeRmb)
    return surpluscount > 0 and surpluscount or 0
end

function UIDailyRechargePanel:GetResSendRechargeInfo()
    return gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetResSendRechargeInfo()
end