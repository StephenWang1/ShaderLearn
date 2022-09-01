---@class UIExternalTeleportPanel : UIBase 传送员
local UIExternalTeleportPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIExternalTeleportPanel:Init()
    self:InitComponents()
    UIExternalTeleportPanel.InitParameters()
    UIExternalTeleportPanel.BindUIEvents()
end

---@param deliverId number  传送ID
---@param desId number   描述ID
function UIExternalTeleportPanel:Show(deliverId, desId)
    UIExternalTeleportPanel.deliverId = deliverId
    UIExternalTeleportPanel.desId = desId
    UIExternalTeleportPanel.InitView()
    UIExternalTeleportPanel.RefreshDeliverCondition()
end

--- 初始化变量
function UIExternalTeleportPanel.InitParameters()
    UIExternalTeleportPanel.deliverId = 0
    UIExternalTeleportPanel.desId = 0
end

--- 初始化组件
function UIExternalTeleportPanel:InitComponents()
    ---@type Top_UILabel 地图名称
    UIExternalTeleportPanel.title = self:GetCurComp("WidgetRoot/window/title", "Top_UILabel")
    ---@type Top_UILabel 地图描述
    UIExternalTeleportPanel.mapDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/details", "Top_UILabel")
    ---@type Top_UILabel 掉落描述
    UIExternalTeleportPanel.conditionDes = self:GetCurComp("WidgetRoot/introduce/labelGroup/levelDes", "Top_UILabel")
    ---@type UnityEngine.GameObject 进入活动按钮
    UIExternalTeleportPanel.enterBtn = self:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIExternalTeleportPanel.closeBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    ---@type Top_UILabel 进入限制
    UIExternalTeleportPanel.num = self:GetCurComp("WidgetRoot/cost/num", "Top_UILabel")
    ---@type UnityEngine.GameObject 转生跳转按钮
    UIExternalTeleportPanel.jumpBtn = self:GetCurComp("WidgetRoot/JumpBtn", "GameObject")
end

function UIExternalTeleportPanel.BindUIEvents()
    CS.UIEventListener.Get(UIExternalTeleportPanel.enterBtn).onClick = UIExternalTeleportPanel.OnClickEnterBtnBtn
    CS.UIEventListener.Get(UIExternalTeleportPanel.closeBtn).onClick = UIExternalTeleportPanel.OnClickCloseBtnBtn
    CS.UIEventListener.Get(UIExternalTeleportPanel.jumpBtn).onClick = UIExternalTeleportPanel.OnClickJumpBtn
end
--endregion

--region 函数监听

function UIExternalTeleportPanel.OnClickEnterBtnBtn()
    ---判断传送限制
    if not clientTableManager.cfg_deliverManager:CheckMainPlayerCanDeliverMap(UIExternalTeleportPanel.deliverId) then
        ---跳转发送消息
        Utility.ShowPopoTips(UIExternalTeleportPanel.enterBtn, nil, 476, 'UIExternalTeleportPanel')
        return
    end

    ---判断物品消耗
    local isMeet, itemID = CS.Cfg_DeliverTableManager.Instance:CheckMainPlayerHaveEnoughConsumables(UIExternalTeleportPanel.deliverId)
    if isMeet then
        networkRequest.ReqDeliverByConfig(UIExternalTeleportPanel.deliverId)
        uimanager:ClosePanel("UIExternalTeleportPanel")
    else
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
        if itemInfo == nil then
            return
        end
        local des = clientTableManager.cfg_promptwordManager:GetSecondConfirmContent(96, itemInfo:GetName())
        local jumpId = clientTableManager.cfg_deliverManager:GetJumpIdByItemId(UIExternalTeleportPanel.deliverId, itemID)
        Utility.ShowSecondConfirmPanel({ PromptWordId = 96, des = des, ComfireAucion = function()
            if type(jumpId) == 'number' then
                uiTransferManager:TransferToPanel(jumpId)
            end
        end })
    end
end

function UIExternalTeleportPanel.OnClickCloseBtnBtn()
    uimanager:ClosePanel("UIExternalTeleportPanel")
end

function UIExternalTeleportPanel.OnClickJumpBtn()
    uimanager:CreatePanel("UIRolePanelTagPanel", nil, { type = LuaEnumLeftTagType.UIRoleTurnGrowPanel })
end
--endregion

--region 网络消息处理

--endregion

--region View

function UIExternalTeleportPanel.InitView()
    local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(UIExternalTeleportPanel.deliverId)
    if deliverTbl then
        UIExternalTeleportPanel.title.text = deliverTbl:GetShowName() == nil and "" or deliverTbl:GetShowName()
    end

    local isFind, desInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(UIExternalTeleportPanel.desId)
    if isFind then
        local showInfo = string.Split(desInfo.value, '#')
        if #showInfo > 0 then
            UIExternalTeleportPanel.mapDes.text = string.gsub(showInfo[1], '\\n', '\n')
        end
        if #showInfo > 1 then
            UIExternalTeleportPanel.conditionDes.text = string.gsub(showInfo[2], '\\n', '\n')
        end
    end
    UIExternalTeleportPanel.num.text = clientTableManager.cfg_deliverManager:GetDeliverConditionStr(UIExternalTeleportPanel.deliverId)
end

---刷新传送条件
function UIExternalTeleportPanel.RefreshDeliverCondition()
    ---@type table<number,<number,DeliverCondition>>
    local conditionParams = clientTableManager.cfg_deliverManager:GetDeliverConditionInfo(UIExternalTeleportPanel.deliverId)
    UIExternalTeleportPanel:CloseShowBtn()
    if conditionParams then
        local count, secondCount = #conditionParams, 0
        for i1 = 1, count do
            secondCount = #conditionParams[i1]
            for i2 = 1, secondCount do
                UIExternalTeleportPanel:RefreshShowBtn(conditionParams[i1][i2])
            end
        end
    end
end

---刷新显示按钮
---@param conditionParams DeliverCondition
function UIExternalTeleportPanel:RefreshShowBtn(conditionParams)
    if conditionParams == nil or conditionParams.conditionTbl == nil then
        return
    end
    if conditionParams.isMeet == false and conditionParams.conditionTbl:GetConditionType() == LuaEnumConditionKeyType.GreatReincarnationLevel or conditionParams.conditionTbl:GetConditionType() == LuaEnumConditionKeyType.LessReincarnationLevel then
        luaclass.UIRefresh:RefreshActive(UIExternalTeleportPanel.jumpBtn, true)
    end
end

function UIExternalTeleportPanel:CloseShowBtn()
    luaclass.UIRefresh:RefreshActive(UIExternalTeleportPanel.jumpBtn, false)
end
--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIExternalTeleportPanel