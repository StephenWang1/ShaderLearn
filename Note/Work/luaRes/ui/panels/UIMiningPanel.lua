---挖矿界面
---@class UIMiningPanel:UIBase
local UIMiningPanel = {}

--region局部变量定义
---体力图标
UIMiningPanel.mPowerIcon = {
    [LuaEnumMiningPowerType.Green] = "Mining_power1",
    [LuaEnumMiningPowerType.Blue] = "Mining_power2",
    [LuaEnumMiningPowerType.Yellow] = "Mining_power3",
    [LuaEnumMiningPowerType.Pink] = "Mining_power4",
    [LuaEnumMiningPowerType.Red] = "Mining_power5",
}

---体力描述
UIMiningPanel.mPowerState = {
    [LuaEnumMiningPowerType.Green] = "体力旺盛",
    [LuaEnumMiningPowerType.Blue] = "铿锵有力",
    [LuaEnumMiningPowerType.Yellow] = "有点疲惫",
    [LuaEnumMiningPowerType.Pink] = "非常疲惫",
    [LuaEnumMiningPowerType.Red] = "精疲力尽",
}

---@type table<number,number> 矿石Id 对应当前数目
UIMiningPanel.mItemIdToNum = nil

---挖矿模板
---@type table<UnityEngine.GameObject,UIMiningPanelGridTemplate>
UIMiningPanel.mGotoTemplate = nil

---当前是否在挖矿
UIMiningPanel.IsCurrentMining = false

---当前矿物总价值
UIMiningPanel.mCurrentTotalPrice = 0
--endregion

--region组件
---主要部分
function UIMiningPanel.GetMainPart()
    if UIMiningPanel.mainPart == nil then
        UIMiningPanel.mainPart = UIMiningPanel:GetCurComp("MainPart", "GameObject")
    end
    return UIMiningPanel.mainPart
end

---折叠部分
function UIMiningPanel.GetFoldPart()
    if UIMiningPanel.foldPart == nil then
        UIMiningPanel.foldPart = UIMiningPanel:GetCurComp("FoldPart", "GameObject")
    end
    return UIMiningPanel.foldPart
end

---采矿状态图标
function UIMiningPanel.GetMiningPowerIcon_UISprite()
    if UIMiningPanel.mMiningPowerIcon == nil then
        UIMiningPanel.mMiningPowerIcon = UIMiningPanel:GetCurComp("MainPart/Power", "UISprite")
    end
    return UIMiningPanel.mMiningPowerIcon
end

---@return UICountdownLabel 时间计时
function UIMiningPanel.GetTimeCount_UI()
    if UIMiningPanel.mTimeCount == nil then
        UIMiningPanel.mTimeCount = UIMiningPanel:GetCurComp("MainPart/MinedTime", "UICountdownLabel")
    end
    return UIMiningPanel.mTimeCount
end

---关闭按钮
function UIMiningPanel.GetCloseButton_GameObject()
    if UIMiningPanel.mCloseButton == nil then
        UIMiningPanel.mCloseButton = UIMiningPanel:GetCurComp("MainPart/CloseBtn", "GameObject")
    end
    return UIMiningPanel.mCloseButton
end

---折叠按钮
function UIMiningPanel.GetFoldPartButton_GameObject()
    if UIMiningPanel.mFoldButton == nil then
        UIMiningPanel.mFoldButton = UIMiningPanel:GetCurComp("FoldPart/Sprite", "GameObject")
    end
    return UIMiningPanel.mFoldButton
end

---@return UIGridContainer  矿种类Container
function UIMiningPanel.GetMineContainer_UIGridContainer()
    if UIMiningPanel.mMineContainer == nil then
        UIMiningPanel.mMineContainer = UIMiningPanel:GetCurComp("MainPart/ScrollView/OreList", "UIGridContainer")
    end
    return UIMiningPanel.mMineContainer
end

---矿物价值
function UIMiningPanel.GetWorth_UILabel()
    if UIMiningPanel.mWorthLabel == nil then
        UIMiningPanel.mWorthLabel = UIMiningPanel:GetCurComp("MainPart/OrdinaryOresWorth", "UILabel")
    end
    return UIMiningPanel.mWorthLabel
end

---挖矿体力描述
function UIMiningPanel.GetMinePowerDescription_UILabel()
    if UIMiningPanel.mPowerDes == nil then
        UIMiningPanel.mPowerDes = UIMiningPanel:GetCurComp("MainPart/MineState", "UILabel")
    end
    return UIMiningPanel.mPowerDes
end

---出售按钮
function UIMiningPanel.GetSellMine_GameObject()
    if UIMiningPanel.mSellMineButton == nil then
        UIMiningPanel.mSellMineButton = UIMiningPanel:GetCurComp("MainPart/AutoSellOresBtn", "GameObject")
    end
    return UIMiningPanel.mSellMineButton
end

--endregion

--region 初始化
function UIMiningPanel:Init()
    UIMiningPanel.BindMessage()
    UIMiningPanel.BindEvents()
    UIMiningPanel.InitData()
end

function UIMiningPanel:Show()
    UIMiningPanel:ShowMainPart(true)
    CS.CSUIMaskManager:GetInstance():TryCloseMask("UIMainMenusPanel");
end

--初始化数据
function UIMiningPanel.InitData()
    UIMiningPanel.mGotoTemplate = {}
    UIMiningPanel.RefreshShowMine()
end

function UIMiningPanel.GetShowList()
    local list = {}
    UIMiningPanel.mItemIdToNum = CS.CSScene.MainPlayerInfo.BagInfo:GetMiningShowMineDic()
    for k, v in pairs(UIMiningPanel.mItemIdToNum) do
        local itemInfo = {}
        itemInfo.itemId = k
        itemInfo.itemNum = v
        table.insert(list, itemInfo)
    end
    return list
end

function UIMiningPanel.BindMessage()
    UIMiningPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIMiningPanel.OnPlayerChangeMap)
    UIMiningPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StrengthenMineNumChange, UIMiningPanel.RefreshShowMine)

    UIMiningPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResStartMiningMessage, UIMiningPanel.OnResStartMiningMessageReceived)
    UIMiningPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGatherMessage, UIMiningPanel.OnResGatherMessageReceived)
    UIMiningPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChangeSpiritMessage, UIMiningPanel.OnResChangeSpiritMessageReceived)
end

function UIMiningPanel.BindEvents()
    CS.UIEventListener.Get(UIMiningPanel.GetCloseButton_GameObject()).onClick = UIMiningPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIMiningPanel.GetFoldPartButton_GameObject()).onClick = UIMiningPanel.OnFoldButtonClicked
    CS.UIEventListener.Get(UIMiningPanel.GetSellMine_GameObject()).onClick = UIMiningPanel.OnSellButtonClicked
end
--endregion

--region 客户端事件
---玩家切换地图
function UIMiningPanel.OnPlayerChangeMap()
    local mapId = CS.CSScene.getMapID()
    if mapId ~= 2001 and mapId ~= 2002 and mapId ~= 2003 then
        uimanager:ClosePanel("UIMiningPanel")
    end
end
--endregion

--region 服务器事件
---开始挖矿消息
function UIMiningPanel.OnResStartMiningMessageReceived(msgId, tblData, csData)
    UIMiningPanel.RefreshPanelShow(tblData)
    UIMiningPanel.IsCurrentMining = true
end

---采集状态改变
function UIMiningPanel.OnResGatherMessageReceived(msgId, tblData, csData)
    if tblData then
        if tblData.state == 2 then
            UIMiningPanel.GetTimeCount_UI():StopCountDown()
            UIMiningPanel.IsCurrentMining = false
            UIMiningPanel.OnCloseButtonClicked()
        end
    end
end

---体力改变消息
function UIMiningPanel.OnResChangeSpiritMessageReceived(msgId, tblData, csData)
    if tblData and tblData.physical then
        UIMiningPanel.GetMiningPowerIcon_UISprite().spriteName = UIMiningPanel.mPowerIcon[tblData.physical]
        UIMiningPanel.GetMinePowerDescription_UILabel().text = UIMiningPanel.mPowerState[tblData.physical]
    end
end
--endregion

--region UI事件
---刷新矿显示
function UIMiningPanel.RefreshShowMine()
    local List = UIMiningPanel.GetShowList()
    if CS.StaticUtility.IsNull(UIMiningPanel.GetMineContainer_UIGridContainer()) == false and List and #List > 0 then
        UIMiningPanel.mCurrentTotalPrice = 0
        UIMiningPanel.GetMineContainer_UIGridContainer().MaxCount = #List
        for i = 0, UIMiningPanel.GetMineContainer_UIGridContainer().controlList.Count - 1 do
            local gp = UIMiningPanel.GetMineContainer_UIGridContainer().controlList[i].transform
            local template = UIMiningPanel.mGotoTemplate[gp]
            if template == nil then
                template = templatemanager.GetNewTemplate(gp, luaComponentTemplates.UIMiningPanelGridTemplate, List[i + 1].itemId)
            end
            if template and template.RefreshInfo then
                template:RefreshInfo(List[i + 1].itemId, List[i + 1].itemNum)
                local price = CS.Cfg_ItemsTableManager.Instance:GetSellMinePrice(List[i + 1].itemId)
                local num = List[i + 1].itemNum
                UIMiningPanel.mCurrentTotalPrice = UIMiningPanel.mCurrentTotalPrice + price * num
            end
        end
    else
        UIMiningPanel.GetMineContainer_UIGridContainer().MaxCount = 0
        UIMiningPanel.mCurrentTotalPrice = 0
    end
    UIMiningPanel.ShowMiningPrice()
end

---设置主面板显示状态
function UIMiningPanel.ShowMainPart(isShow)
    UIMiningPanel.GetMainPart():SetActive(isShow)
    UIMiningPanel.GetFoldPart():SetActive(not isShow)
end

---关闭主面板
function UIMiningPanel.OnCloseButtonClicked()
    UIMiningPanel.ShowMainPart(false)
    UIMiningPanel.OpenAutoGather(false)
end

---关闭副面板
function UIMiningPanel.OnFoldButtonClicked()
    UIMiningPanel.ShowMainPart(true)
    if not UIMiningPanel.IsCurrentMining then
        UIMiningPanel.StartAutoMining()
    end
end

---点击出售按钮
function UIMiningPanel.OnSellButtonClicked()
    local recycleList = CS.CSScene.MainPlayerInfo.BagInfo.MiningNeedSellId
    if recycleList then
        networkRequest.ReqRecycleEquipment(recycleList, 0, nil)
    end
end

---刷新界面信息
---@param tblData.dayTime number 今天挖的累计时间
---@param tblData.physical number 体力状态
function UIMiningPanel.RefreshPanelShow(tblData)
    UIMiningPanel.GetTimeCount_UI():StartCountUp(nil, 5, tblData.dayTime, "累计挖矿时间:", nil)
    UIMiningPanel.GetMiningPowerIcon_UISprite().spriteName = UIMiningPanel.mPowerIcon[tblData.physical]
    UIMiningPanel.GetMinePowerDescription_UILabel().text = UIMiningPanel.mPowerState[tblData.physical]
end

---显示当前道具总价值
function UIMiningPanel.ShowMiningPrice()
    local currentPrice = ternary(UIMiningPanel.mCurrentTotalPrice == nil, 0, UIMiningPanel.mCurrentTotalPrice)
    UIMiningPanel.GetWorth_UILabel().text = "背包内矿物价值:" .. currentPrice
end

---开始自动挖矿
function UIMiningPanel.StartAutoMining()
    CS.CSAutoFightMgr.Instance.AutoGather.AutoGatherIDMask:Clear()
    local gatherId = CS.Cfg_GlobalTableManager.Instance:GetAutoGatherPoint()
    if gatherId and gatherId >= 0 then
        if not CS.CSAutoFightMgr.Instance.AutoGather.AutoGatherIDMask:TryGetValue(gatherId) then
            CS.CSAutoFightMgr.Instance.AutoGather.AutoGatherIDMask:Add(gatherId, true)
        end
    end
    UIMiningPanel.OpenAutoGather(true)
end

---开启自动挖矿
function UIMiningPanel.OpenAutoGather(isOpen)
    if CS.CSAutoFightMgr.Instance then
        if CS.CSAutoFightMgr.Instance.IsOn ~= isOpen then
            CS.CSAutoFightMgr.Instance.IsOn = isOpen
        end
        CS.CSAutoFightMgr.Instance.AutoGather:Toggle(isOpen)
    end
end

--endregion

function ondestroy()
    UIMiningPanel.OpenAutoGather(false)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResStartMiningMessage, UIMiningPanel.OnResStartMiningMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResGatherMessage, UIMiningPanel.OnResGatherMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResChangeSpiritMessage, UIMiningPanel.OnResChangeSpiritMessageReceived)
end

return UIMiningPanel