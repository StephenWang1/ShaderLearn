---@class UIDoctorPanel:UIBase 名医
local UIDoctorPanel = {}

--region 局部变量
UIDoctorPanel.item1Info = nil;
UIDoctorPanel.item2Info = nil;
--endregion

--region 属性
function UIDoctorPanel.GetCloseBtn_GameObject()
    if (UIDoctorPanel.mCloseBtn == nil) then
        UIDoctorPanel.mCloseBtn = UIDoctorPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIDoctorPanel.mCloseBtn
end

function UIDoctorPanel.GetDetails_UILabel()
    if (UIDoctorPanel.mDetails == nil) then
        UIDoctorPanel.mDetails = UIDoctorPanel:GetCurComp("WidgetRoot/introduce/labelGroup/details", "UILabel")
    end
    return UIDoctorPanel.mDetails
end

function UIDoctorPanel.GetPay1_UILabel()
    if (UIDoctorPanel.mPay1 == nil) then
        UIDoctorPanel.mPay1 = UIDoctorPanel:GetCurComp("WidgetRoot/introduce/labelGroup/pay1/gold1", "UILabel")
    end
    return UIDoctorPanel.mPay1
end

function UIDoctorPanel.GetPay1_GameObject()
    if (UIDoctorPanel.mPay1Go == nil) then
        UIDoctorPanel.mPay1Go = UIDoctorPanel:GetCurComp("WidgetRoot/introduce/labelGroup/pay1/icon", "GameObject")
    end
    return UIDoctorPanel.mPay1Go
end

function UIDoctorPanel.GetPay2_UILabel()
    if (UIDoctorPanel.mPay2 == nil) then
        UIDoctorPanel.mPay2 = UIDoctorPanel:GetCurComp("WidgetRoot/introduce/labelGroup/pay2/gold2", "UILabel")
    end
    return UIDoctorPanel.mPay2
end

function UIDoctorPanel.GetPay2_GameObject()
    if (UIDoctorPanel.mPay2Go == nil) then
        UIDoctorPanel.mPay2Go = UIDoctorPanel:GetCurComp("WidgetRoot/introduce/labelGroup/pay2/icon", "GameObject")
    end
    return UIDoctorPanel.mPay2Go
end

function UIDoctorPanel.GetEnterBtn1_UILabel()
    if (UIDoctorPanel.mEnterBtn1 == nil) then
        UIDoctorPanel.mEnterBtn1 = UIDoctorPanel:GetCurComp("WidgetRoot/EnterBtn1", "GameObject")
    end
    return UIDoctorPanel.mEnterBtn1
end

function UIDoctorPanel.GetEnterBtn2_UILabel()
    if (UIDoctorPanel.mEnterBtn2 == nil) then
        UIDoctorPanel.mEnterBtn2 = UIDoctorPanel:GetCurComp("WidgetRoot/EnterBtn2", "GameObject")
    end
    return UIDoctorPanel.mEnterBtn2
end
--endregion

--region 初始化
function UIDoctorPanel:Init()
    self:InitData()
    self:BindUIEvent()
    self:BindUIMessage()
    self:AddCollider()
end

function UIDoctorPanel:Show()
    local isFind, condition = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20550)
    if (isFind) then
        local isFind, needLevel = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(tonumber(condition.value))
        if (isFind and needLevel.conditionParam.list[0] > CS.CSScene.MainPlayerInfo.Level) then
            uimanager:ClosePanel("UIDoctorPanel")
        end
    end
end

function UIDoctorPanel:InitData()
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(90)
    if isFind then
        UIDoctorPanel.GetDetails_UILabel().text = itemInfo.value
    end
    __, UIDoctorPanel.item1Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType1)
    __, UIDoctorPanel.item2Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType2)
    UIDoctorPanel.GetPay1_UILabel().text = tostring(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayNum1) .. CS.Cfg_ItemsTableManager.Instance:GetItemName(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType1)
    UIDoctorPanel.GetPay2_UILabel().text = tostring(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayNum2) .. CS.Cfg_ItemsTableManager.Instance:GetItemName(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType2)
end

function UIDoctorPanel:BindUIEvent()
    CS.UIEventListener.Get(UIDoctorPanel.GetCloseBtn_GameObject()).onClick = UIDoctorPanel.OnCloseBtnClick
    CS.UIEventListener.Get(UIDoctorPanel.GetEnterBtn1_UILabel()).onClick = UIDoctorPanel.OnEnterBtn1Click
    CS.UIEventListener.Get(UIDoctorPanel.GetEnterBtn2_UILabel()).onClick = UIDoctorPanel.OnEnterBtn2Click
    CS.UIEventListener.Get(UIDoctorPanel.GetPay1_GameObject()).onClick = UIDoctorPanel.Icon1onClick
    CS.UIEventListener.Get(UIDoctorPanel.GetPay2_GameObject()).onClick = UIDoctorPanel.Icon2onClick
end

function UIDoctorPanel:BindUIMessage()
    UIDoctorPanel.ResDoctorRecover = function(msgId, tblData, csData)
        self:OnResDoctorRecover(msgId, tblData, csData)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDoctorHealthMessage, UIDoctorPanel.ResDoctorRecover)
end

--endregion

--region 客户端事件
function UIDoctorPanel.OnCloseBtnClick()
    uimanager:ClosePanel("UIDoctorPanel")
end

function UIDoctorPanel.OnEnterBtn1Click(go)
    --[[
    ---@type CSMainPlayerInfo
    local mainplayerinfo = CS.CSScene.MainPlayerInfo
    if (mainplayerinfo.HP == mainplayerinfo.MaxHP and mainplayerinfo.MP == mainplayerinfo.MaxMP) then
        UIDoctorPanel.ShowTips(go, nil, 147)
        return
    end
    --]]

    if not UIDoctorPanel.CheckDoctorCD(go) then
        return
    end

    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local value = bagInfo:GetCoinAmount(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType1)
    --if isGetValue then
    if (value >= CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayNum1) then
        networkRequest.ReqDoctorRecover(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType1)
    else
        local str = CS.Cfg_ItemsTableManager.Instance:GetItemName(UIDoctorPanel.item1Info.id) .. "不足"
        UIDoctorPanel.ShowTips(go, str, 107)
    end
    --end
end

function UIDoctorPanel.OnEnterBtn2Click(go)
    --[[
    local mainplayerinfo = CS.CSScene.MainPlayerInfo

    if (mainplayerinfo.HP == mainplayerinfo.MaxHP and mainplayerinfo.MP == mainplayerinfo.MaxMP) then
       UIDoctorPanel.ShowTips(go, nil, 147)
       return
    end
    --]]

    if not UIDoctorPanel.CheckDoctorCD(go) then
        return
    end

    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local value = bagInfo:GetCoinAmount(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType2)
    --if isGetValue then
    if (value >= CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayNum2) then
        networkRequest.ReqDoctorRecover(CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType2)
    else
        local str = CS.Cfg_ItemsTableManager.Instance:GetItemName(UIDoctorPanel.item2Info.id) .. "不足"
        UIDoctorPanel.ShowTips(go, str, 107)
    end
    --end
end

function UIDoctorPanel.Icon1onClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000002) })
end

function UIDoctorPanel.Icon2onClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000004) })
end
---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIDoctorPanel.ShowTips(trans, str, id)
    local TipsInfo = {}
    if str ~= nil or str ~= '' then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIDoctorPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 服务器事件
---发送玩家状态
function UIDoctorPanel:OnResDoctorRecover(msgId, tblData, csData)
    if tblData then
        local go
        if tblData.moneyId == CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType1 then
            go = UIDoctorPanel.GetEnterBtn1_UILabel()
        elseif tblData.moneyId == CS.Cfg_GlobalTableManager.Instance.DoctorNeedPayType2 then
            go = UIDoctorPanel.GetEnterBtn2_UILabel()
        end
        if not CS.StaticUtility.IsNull(go) then
            if tblData.isHealth == 1 then
                UIDoctorPanel.ShowTips(go, nil, 147)
            end
        end
    end
end
--endregion

---检测神医cd
---@return boolean
function UIDoctorPanel.CheckDoctorCD(go)
    local remainTime = uiStaticParameter.mDoctorCD - CS.CSServerTime.Instance.TotalMillisecond
    remainTime = remainTime / 1000
    if remainTime > 0 then
        local tbl = clientTableManager.cfg_promptframeManager:TryGetValue(510)
        if tbl and  tbl:GetContent() then
            local str = string.format(tbl:GetContent(), string.format("%.0f", remainTime))
            Utility.ShowPopoTips(go, str, 510, "UIDoctorPanel")
        end
    end
    return remainTime <= 0
end

return UIDoctorPanel