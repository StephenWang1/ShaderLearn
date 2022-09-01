---@class UIBerserkPowerPanel : UIBase 狂暴之力面板
local UIBerserkPowerPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIBerserkPowerPanel:Init()
    self:InitComponents()
    UIBerserkPowerPanel.InitParameters()
    UIBerserkPowerPanel.BindUIEvents()
    UIBerserkPowerPanel.BindNetEvents()
    networkRequest.ReqRageState()
end

---@param desId number   描述ID
function UIBerserkPowerPanel:Show(desId)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.BerserkPower
    UIBerserkPowerPanel.desId = desId
    UIBerserkPowerPanel.InitView()
end

--- 初始化变量
function UIBerserkPowerPanel.InitParameters()
    UIBerserkPowerPanel.desId = 0
    UIBerserkPowerPanel.curState = 0
    UIBerserkPowerPanel.strFormat = '携带%s[-][878787](不含绑定钻石和奖励钻石)'
end

--- 初始化组件
function UIBerserkPowerPanel:InitComponents()
    ---@type Top_UILabel 地图名称
    UIBerserkPowerPanel.title = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel")
    ---@type Top_UILabel 描述
    UIBerserkPowerPanel.detail = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel")
    ---@type Top_UILabel 激活效果描述
    UIBerserkPowerPanel.conditionDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/AttrDes", "Top_UILabel")
    ---@type UnityEngine.GameObject 进入活动按钮
    UIBerserkPowerPanel.enterBtn = self:GetCurComp("WidgetRoot/activeBtn", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIBerserkPowerPanel.closeBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 帮助按钮
    UIBerserkPowerPanel.helpBtn = self:GetCurComp("WidgetRoot/btn_help", "GameObject")
    ---@type Top_UILabel 激活条件
    UIBerserkPowerPanel.activeConditon = self:GetCurComp("WidgetRoot/introduce/lb_activeConditon", "Top_UILabel")
    ---@type Top_UILabel 按钮文本
    UIBerserkPowerPanel.enterBtnlabel = self:GetCurComp("WidgetRoot/activeBtn/Label", "Top_UILabel")
    ---@type Top_UISprite 按钮底图
    UIBerserkPowerPanel.enterBtnBg = self:GetCurComp("WidgetRoot/activeBtn/Background", "Top_UISprite")
    ---@type UnityEngine.GameObject 按钮特效
    UIBerserkPowerPanel.enterBtnEffect = self:GetCurComp("WidgetRoot/activeBtn/effect", "GameObject")

end

function UIBerserkPowerPanel.BindUIEvents()
    CS.UIEventListener.Get(UIBerserkPowerPanel.enterBtn).onClick = UIBerserkPowerPanel.OnClickEnterBtnBtn
    CS.UIEventListener.Get(UIBerserkPowerPanel.closeBtn).onClick = UIBerserkPowerPanel.OnClickCloseBtnBtn
    CS.UIEventListener.Get(UIBerserkPowerPanel.helpBtn).onClick = UIBerserkPowerPanel.OnClickhelpBtn
end

function UIBerserkPowerPanel.BindNetEvents()
    UIBerserkPowerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRageStateMessage, UIBerserkPowerPanel.OnResRageStateCallBack)
end
--endregion

--region 函数监听

function UIBerserkPowerPanel.OnClickEnterBtnBtn(go)
    if UIBerserkPowerPanel.curState == LuaEnumRageStateType.NotMeetCondtionAndActivated then
        return
    end
    if UIBerserkPowerPanel.curState == LuaEnumRageStateType.NotMeetCondtionAndNotActivated then
        ---显示气泡
        --Utility.ShowPopoTips(go, nil, 454, "UIBerserkPowerPanel")
        ---跳转充值界面
        if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
            uimanager:CreatePanel("UIRechargeFirstTips");
        else
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Recharge);
        end
        return
    end

    local paramType = UIBerserkPowerPanel.curState == LuaEnumRageStateType.MeetCondtionAndActivated and 2 or 1
    ---TODO 判断状态发送狂暴之力
    networkRequest.ReqActivateOrCancelRage(paramType)
end

function UIBerserkPowerPanel.OnClickCloseBtnBtn()
    uimanager:ClosePanel("UIBerserkPowerPanel")
end

---点击帮助按钮
function UIBerserkPowerPanel.OnClickhelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(205)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--endregion

--region 网络消息处理

function UIBerserkPowerPanel.OnResRageStateCallBack(id, tblData)
    if tblData then
        UIBerserkPowerPanel.curState = tblData.state
        UIBerserkPowerPanel.RefreshBtnState()
    end
end

--endregion

--region View

function UIBerserkPowerPanel.InitView()
    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(UIBerserkPowerPanel.desId)
    if isFind then
        local showInfo = string.Split(desInfo.value, '#')
        if #showInfo > 0 then
            UIBerserkPowerPanel.detail.text = string.gsub(showInfo[1], '\\n', '\n')
        end
        if #showInfo > 1 then
            UIBerserkPowerPanel.conditionDes.text = string.gsub(showInfo[2], '\\n', '\n')
        end
    end

    ---判断condition
    local conditionId = LuaGlobalTableDeal.GetRageConditionID()
    local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(conditionId)
    if conditionTbl then
        local isMeetCondition = Utility.IsMainPlayerMatchCondition(conditionId).success
        local color = isMeetCondition and luaEnumColorType.Green3 or luaEnumColorType.Red
        UIBerserkPowerPanel.activeConditon.text = string.format(UIBerserkPowerPanel.strFormat, color .. conditionTbl:GetTxt())
    end
end

function UIBerserkPowerPanel.RefreshBtnState()
    UIBerserkPowerPanel.enterBtnlabel.text = UIBerserkPowerPanel.curState == LuaEnumRageStateType.MeetCondtionAndActivated and luaEnumColorType.Red3 .. "取消激活" or
            UIBerserkPowerPanel.curState == LuaEnumRageStateType.NotMeetCondtionAndActivated and luaEnumColorType.Gray .. "已失效" or luaEnumColorType.Red3 .. '激活'
    UIBerserkPowerPanel.enterBtnBg.color = UIBerserkPowerPanel.curState ~= LuaEnumRageStateType.NotMeetCondtionAndActivated and
            LuaEnumUnityColorType.White or LuaEnumUnityColorType.Gray
    UIBerserkPowerPanel.enterBtnEffect:SetActive(UIBerserkPowerPanel.curState == LuaEnumRageStateType.MeetCondtionAndNotActivated)
end


--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIBerserkPowerPanel