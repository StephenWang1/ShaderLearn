local UIRechargeDayFirstTips = {}

--region 局部变量
UIRechargeDayFirstTips.GridDic = {}
--endregion
--region 组件
function UIRechargeDayFirstTips.GetCloseBtn_GameObject()
    if (UIRechargeDayFirstTips.mCloseBtn == nil) then
        UIRechargeDayFirstTips.mCloseBtn = UIRechargeDayFirstTips:GetCurComp("btn_close", "GameObject")
    end
    return UIRechargeDayFirstTips.mCloseBtn
end

function UIRechargeDayFirstTips.GetRechargeBtn_GameObject()
    if (UIRechargeDayFirstTips.mRechargeBtn == nil) then
        UIRechargeDayFirstTips.mRechargeBtn = UIRechargeDayFirstTips:GetCurComp("btn_recharge", "GameObject")
    end
    return UIRechargeDayFirstTips.mRechargeBtn
end

function UIRechargeDayFirstTips.GetRechargeBtn_UISprite()
    if (UIRechargeDayFirstTips.mRechargeBtnUISprite == nil) then
        UIRechargeDayFirstTips.mRechargeBtnUISprite = UIRechargeDayFirstTips:GetCurComp("btn_recharge", "UISprite")
    end
    return UIRechargeDayFirstTips.mRechargeBtnUISprite
end

function UIRechargeDayFirstTips.GetNeedCost_UILabel()
    if (UIRechargeDayFirstTips.mNeedCost == nil) then
        UIRechargeDayFirstTips.mNeedCost = UIRechargeDayFirstTips:GetCurComp("bgs/costNumLabel", "UILabel")
    end
    return UIRechargeDayFirstTips.mNeedCost
end

function UIRechargeDayFirstTips.GetRewardItemList_UIGridContainer()
    if (UIRechargeDayFirstTips.mRewardItemList == nil) then
        UIRechargeDayFirstTips.mRewardItemList = UIRechargeDayFirstTips:GetCurComp("RewardItemList", "UIGridContainer")
    end
    return UIRechargeDayFirstTips.mRewardItemList
end
--endregion

--region 初始化
function UIRechargeDayFirstTips:Init()
    UIRechargeDayFirstTips.BindMessage()
    UIRechargeDayFirstTips.BindUIEvents()
end

function UIRechargeDayFirstTips:Show()
    networkRequest.ReqGetRechargeInfo()
end

function UIRechargeDayFirstTips.BindUIEvents()
    CS.UIEventListener.Get(UIRechargeDayFirstTips.GetRechargeBtn_GameObject()).onClick = UIRechargeDayFirstTips.RechargeBtnClick;
    CS.UIEventListener.Get(UIRechargeDayFirstTips.GetCloseBtn_GameObject()).onClick = UIRechargeDayFirstTips.CloseBtnOnClick
end

function UIRechargeDayFirstTips.BindMessage()
    UIRechargeDayFirstTips:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendRechargeInfoMessage, UIRechargeDayFirstTips.RefreshReChargeResult)
    UIRechargeDayFirstTips:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRechargeSuccessMessage, UIRechargeDayFirstTips.RefreshRecharge)
end
--endregion

--region 客户端消息处理
function UIRechargeDayFirstTips.CloseBtnOnClick()
    uimanager:ClosePanel("UIRechargeDayFirstTips")
end

function UIRechargeDayFirstTips.RechargeBtnClick()
    Utility.TryShowFirstRechargePanel()
end

function UIRechargeDayFirstTips.RechargeResultBtnClick()
    networkRequest.ReqGetDayRechargeReward();
    uimanager:ClosePanel("UIRechargeDayFirstTips")
end
function UIRechargeDayFirstTips.OnCheckItemClicked(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local itemTemp = UIRechargeDayFirstTips.GridDic[go]
        if itemTemp ~= nil and itemTemp.ItemInfo ~= nil and itemTemp.ItemInfo ~= nil then
            --打开物品信息界面
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = itemTemp.bagItemInfo })
        end
    end
end
--endregion

--region 网络消息处理
function UIRechargeDayFirstTips.RefreshUI(info)
    local itemlist = info.reward:Split('&')
    local count = #itemlist
    UIRechargeDayFirstTips.GetRewardItemList_UIGridContainer().MaxCount = count
    for i = 1, count do
        local item = itemlist[i]:Split('#')
        local bagItemInfo
        local bagFind, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(item[1])
        if (bagFind) then
            bagItemInfo = Info
        end
        if bagItemInfo ~= nil then
            local go = UIRechargeDayFirstTips.GetRewardItemList_UIGridContainer().controlList[i - 1]
            if (UIRechargeDayFirstTips.GridDic[go] == nil) then
                UIRechargeDayFirstTips.GridDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGridItem)
            end
            UIRechargeDayFirstTips.GridDic[go]:RefreshUIWithItemInfo(bagItemInfo, tonumber(item[2]))
            UIRechargeDayFirstTips.GridDic[go].bagItemInfo = bagItemInfo
            CS.UIEventListener.Get(go).onClick = UIRechargeDayFirstTips.OnCheckItemClicked
        end
    end
end

function UIRechargeDayFirstTips.RefreshReChargeResult(id, data)
    local info = CS.Cfg_Daily_PayTableManager.Instance:GetDailyPayInfo(data.dailyRechargeRewardTakenCount)
    if (info ~= nil) then
        UIRechargeDayFirstTips.RefreshUI(info)
        UIRechargeDayFirstTips.GetNeedCost_UILabel().text = data.totalRechargeCount >= info.money and "0" or tostring(data.totalRechargeCount - info.money)
        if (data.totalRechargeCount ~= nil and data.totalRechargeCount >= info.money) then
            UIRechargeDayFirstTips.GetRechargeBtn_UISprite().spriteName = "aj2"
            CS.UIEventListener.Get(UIRechargeDayFirstTips.GetRechargeBtn_GameObject()).onClick = UIRechargeDayFirstTips.RechargeResultBtnClick;
        else
            UIRechargeDayFirstTips.GetRechargeBtn_UISprite().spriteName = "aj1"
            CS.UIEventListener.Get(UIRechargeDayFirstTips.GetRechargeBtn_GameObject()).onClick = UIRechargeDayFirstTips.RechargeBtnClick;
        end
    else
        UIRechargeDayFirstTips.GetRewardItemList_UIGridContainer().gameObject:SetActive(false)
        UIRechargeDayFirstTips.GetRechargeBtn_GameObject():SetActive(false)
    end
end

function UIRechargeDayFirstTips.RefreshRecharge()
    networkRequest.ReqGetRechargeInfo()
end
--endregion
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSendRechargeInfoMessage, UIRechargeDayFirstTips.RefreshReChargeResult)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRechargeSuccessMessage, UIRechargeDayFirstTips.RefreshRecharge)
end

return UIRechargeDayFirstTips