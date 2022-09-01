---@class UIFaceToFaceDealPanel:UIBase
local UIFaceToFaceDealPanel = {}

function UIFaceToFaceDealPanel:InitComponents()
    ---别人交易状态
    UIFaceToFaceDealPanel.otherState = self:GetCurComp('WidgetRoot/view/otherState', 'UILabel')
    ---别人名字
    UIFaceToFaceDealPanel.otherName = self:GetCurComp('WidgetRoot/view/otherName', 'UILabel')
    ---别人交易Grid
    UIFaceToFaceDealPanel.otherGrid = self:GetCurComp('WidgetRoot/view/other/Grid', 'UIGridContainer')
    ---别人已锁定
    UIFaceToFaceDealPanel.otherLocked = self:GetCurComp('WidgetRoot/view/other/locked', 'GameObject')

    ---我的交易状态
    UIFaceToFaceDealPanel.myState = self:GetCurComp('WidgetRoot/view/myState', 'UILabel')
    ---我的交易Grid
    UIFaceToFaceDealPanel.myGrid = self:GetCurComp('WidgetRoot/view/my/Grid', 'UIGridContainer')
    ---我已锁定
    UIFaceToFaceDealPanel.myLocked = self:GetCurComp('WidgetRoot/view/my/locked', 'GameObject')

    ---锁定
    UIFaceToFaceDealPanel.lock = self:GetCurComp('WidgetRoot/event/Btn_operation', 'GameObject')
    ---锁定按钮文本
    UIFaceToFaceDealPanel.lockLabel = self:GetCurComp('WidgetRoot/event/Btn_operation/label', 'UILabel')
    ---等待确认
    UIFaceToFaceDealPanel.noOperationLabel = self:GetCurComp('WidgetRoot/event/noOperationLabel', 'GameObject')
    ---帮助
    UIFaceToFaceDealPanel.help = self:GetCurComp('WidgetRoot/event/help', 'GameObject')
    ---帮助
    UIFaceToFaceDealPanel.Close = self:GetCurComp('WidgetRoot/event/Btn_Close', 'GameObject')
end
function UIFaceToFaceDealPanel:InitOther()
    CS.UIEventListener.Get(UIFaceToFaceDealPanel.lock.gameObject).onClick = UIFaceToFaceDealPanel.OnclickLock
    CS.UIEventListener.Get(UIFaceToFaceDealPanel.help.gameObject).onClick = UIFaceToFaceDealPanel.OnClickHelp
    CS.UIEventListener.Get(UIFaceToFaceDealPanel.Close.gameObject).onClick = UIFaceToFaceDealPanel.OnClickClose

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTradeUpdateMessage, UIFaceToFaceDealPanel.RefreshUI)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTradeStateChangeMessage, UIFaceToFaceDealPanel.OnResTradeStateChangeMessage)
end

function UIFaceToFaceDealPanel:Init()
    self:InitComponents()
    self:InitOther()
    --uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Trade })
end

function UIFaceToFaceDealPanel:Show(data)
    ---是否达到交易上限
    UIFaceToFaceDealPanel.IsReachTraderLimit=false
    UIFaceToFaceDealPanel.myGrid.MaxCount = 10
    UIFaceToFaceDealPanel.otherGrid.MaxCount = 10
    UIFaceToFaceDealPanel.myGridList = {}
    UIFaceToFaceDealPanel.otherGridList = {}
    self.InitData(data)
    self.RefreshUI(0, nil, data)
end

---初始化数据
function UIFaceToFaceDealPanel.InitData(data)
    --basics Info
    UIFaceToFaceDealPanel.Parties = nil
    UIFaceToFaceDealPanel.otherTradeInfo = nil
    UIFaceToFaceDealPanel.myTradeInfo = nil

    if data == nil then
      --  print("UIFaceToFaceDealPanel Show Data==nil")
        return
    end
    UIFaceToFaceDealPanel.Parties = data.parties
    if data.parties == nil or data.parties.Count < 2 then
      --  print("UIFaceToFaceDealPanel.Parties==nil or  UIFaceToFaceDealPanel.Parties.Count<2 ")
        return
    end
    for i = 0, data.parties.Count - 1 do
        local v = data.parties[i]
        if v.roleId == CS.CSScene.MainPlayerInfo.ID then
            UIFaceToFaceDealPanel.myTradeInfo = v
        else
            UIFaceToFaceDealPanel.otherTradeInfo = v
        end
    end
end


function UIFaceToFaceDealPanel.RefreshUI(id, tbldata, data)
    UIFaceToFaceDealPanel.InitData(data)
    if UIFaceToFaceDealPanel.otherTradeInfo == nil or UIFaceToFaceDealPanel.myTradeInfo == nil then
        return
    end
    UIFaceToFaceDealPanel.otherState.text =  ""-- UIFaceToFaceDealPanel.otherTradeInfo.name
    UIFaceToFaceDealPanel.otherName.text = UIFaceToFaceDealPanel.GetPlayerStartDes(UIFaceToFaceDealPanel.otherTradeInfo)
    UIFaceToFaceDealPanel.myState.text = UIFaceToFaceDealPanel.GetPlayerStartDes(UIFaceToFaceDealPanel.myTradeInfo)
    local isOtherLock = UIFaceToFaceDealPanel.GetLockStart(UIFaceToFaceDealPanel.otherTradeInfo)
    local isMyLock = UIFaceToFaceDealPanel.GetLockStart(UIFaceToFaceDealPanel.myTradeInfo)
    UIFaceToFaceDealPanel.otherLocked.gameObject:SetActive(isOtherLock)
    UIFaceToFaceDealPanel.myLocked.gameObject:SetActive(isMyLock)
    UIFaceToFaceDealPanel.SetGrid(UIFaceToFaceDealPanel.otherTradeInfo, UIFaceToFaceDealPanel.otherGrid, UIFaceToFaceDealPanel.otherGridList, 2)
    UIFaceToFaceDealPanel.SetGrid(UIFaceToFaceDealPanel.myTradeInfo, UIFaceToFaceDealPanel.myGrid, UIFaceToFaceDealPanel.myGridList, 1)

    local LockLabel = UIFaceToFaceDealPanel.GetLockBtnLabel()
    local isShowLockBtn = LockLabel == "取消交易"
    UIFaceToFaceDealPanel.lock.gameObject:SetActive(not isShowLockBtn)
    UIFaceToFaceDealPanel.noOperationLabel.gameObject:SetActive(isShowLockBtn)
    UIFaceToFaceDealPanel.lockLabel.text = LockLabel
end

function UIFaceToFaceDealPanel.OnResTradeStateChangeMessage(id, data)
    if data ~= nil and data.state == 1 then --状态，1交易成功状态，2交易取消状态
        for i, v in pairs(UIFaceToFaceDealPanel.otherGridList) do
            v:PlayFlyAnim()
        end
    end
    UIFaceToFaceDealPanel.OnClickClose()
end

---设置交易格子
---data tradeV2.TradePartyInfo
function UIFaceToFaceDealPanel.SetGrid(data, Grid, GridDataList, index)
    if data == nil then
        return
    end
    if GridDataList == nil then
        GridDataList = {}
    end
    local treaderNumber=0
    for i = 0, 9 do
        local item = Grid.controlList[i].gameObject
        if GridDataList[item] == nil then
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIFaceToFaceDealTemplates_TrdaeItemInfo)
            GridDataList[item] = template
        end

        local bagItemInfo = nil
        local IsNotAvailable = false

        if data.items ~= nil and data.items.Count > i and data.items.Count ~= 0 then
            bagItemInfo = data.items[i]
            treaderNumber=treaderNumber+1
        end

        if data.maxCount ~= nil and data.maxCount < i + 1 then
            IsNotAvailable = true
        end
        local isLock= UIFaceToFaceDealPanel.GetLockStart(data)
        GridDataList[item]:RefreshUI(bagItemInfo, IsNotAvailable,index==1,isLock)
    end
    if index == 1 then
        UIFaceToFaceDealPanel.IsReachTraderLimit=treaderNumber>=data.maxCount  
        UIFaceToFaceDealPanel.myGridList = GridDataList
    elseif index == 2 then
        UIFaceToFaceDealPanel.otherGridList = GridDataList
      
    end

end

---得到状态描述
---data tradeV2.TradePartyInfo
function UIFaceToFaceDealPanel.GetPlayerStartDes(data)
    if data == nil then
        return ""
    end
    --是否是主角
    local isMainPlayer = data.roleId == CS.CSScene.MainPlayerInfo.ID
    --是否已锁定
    local isLock = data.locked == 1
    if isMainPlayer then
        if isLock then
            return "我 已锁定"
        else
            return "我的物品"
        end
    else
        if isLock then
            return  data.name.."已锁定"
        else
            return data.name .. "的物品"
        end
    end
end

---得到锁定状态
---data tradeV2.TradePartyInfo
function UIFaceToFaceDealPanel.GetLockStart(data)
    if data == nil then
        return false
    end
    local isLock = data.locked == 1
    return isLock
end

---得到确认状态
function UIFaceToFaceDealPanel.GetSubmitStart(data)
    if data == nil then
        return false
    end
    local issubmit = data.submit == 1
    return issubmit
end

---得到锁定按钮显示文本
function UIFaceToFaceDealPanel.GetLockBtnLabel()
    local operation = UIFaceToFaceDealPanel.GetDealType()
    if operation == 1 then
        return "锁定"
    elseif operation == 2 then
        return "取消锁定"
    elseif operation == 3 then
        return "确认交易"
    elseif    operation == 4 then
        return "取消交易"
    elseif    operation == 0 then
        return "未知问题"
    end

end

--region 点击事件
---点击锁定
function UIFaceToFaceDealPanel.OnclickLock()
    local operation = UIFaceToFaceDealPanel.GetDealType()
    networkRequest.ReqSetTradeProgress(operation)
end
---得到交易类型
-----锁定，1锁定，2取消锁定，3确认交易，4取消交易
function UIFaceToFaceDealPanel.GetDealType()
    local ismyLock = UIFaceToFaceDealPanel.GetLockStart(UIFaceToFaceDealPanel.myTradeInfo)
    local ismySubmit = UIFaceToFaceDealPanel.GetSubmitStart(UIFaceToFaceDealPanel.myTradeInfo)
    local isotherSubmit = UIFaceToFaceDealPanel.GetSubmitStart(UIFaceToFaceDealPanel.otherTradeInfo)
    local isotherLock = UIFaceToFaceDealPanel.GetLockStart(UIFaceToFaceDealPanel.otherTradeInfo)

    local operation = 0 --锁定，1锁定，2取消锁定，3确认交易，4取消交易
    if not ismySubmit and not isotherSubmit and not ismyLock then
        operation = 1
    elseif not ismySubmit and not isotherSubmit and ismyLock and not isotherLock then
        operation = 2
    elseif not ismySubmit and ismyLock and isotherLock then
        operation = 3
    elseif    ismySubmit and not isotherSubmit and ismyLock and isotherLock then
        operation = 4
    end
    --  print("我的锁定状态："..tostring(ismyLock),"我的 提交状态："..tostring( ismySubmit),"其他人锁定状态："..tostring(isotherLock),"其他人交易状态："..tostring(isotherSubmit),operation)
    return operation
end


---点击帮助
function UIFaceToFaceDealPanel.OnClickHelp()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(154)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---关闭面板
function UIFaceToFaceDealPanel.OnClickClose()
    networkRequest.ReqSetTradeProgress(4)
    uimanager:ClosePanel('UIFaceToFaceDealPanel')
    uimanager:ClosePanel('UIBagPanel')
end

--endregion

return UIFaceToFaceDealPanel