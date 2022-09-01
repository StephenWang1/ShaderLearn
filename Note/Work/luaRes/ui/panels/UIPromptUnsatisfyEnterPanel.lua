---@class UIPromptUnsatisfyEnterPanel:UIBase 门票tips
local UIPromptUnsatisfyEnterPanel = {}

--region 局部变量
UIPromptUnsatisfyEnterPanel.list = {}
UIPromptUnsatisfyEnterPanel.isBiQi = nil
--endregion

--region 初始化

function UIPromptUnsatisfyEnterPanel:Init()
    self:InitComponents()
    UIPromptUnsatisfyEnterPanel.parent.transform.localPosition = CS.UnityEngine.Vector3(10000, 0, 0)
    CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.Idle
    CS.UIJoystickController.Singleton:StopMove()
    UIPromptUnsatisfyEnterPanel.BindUIEvents()
    UIPromptUnsatisfyEnterPanel.BindNetMessage()
    UIPromptUnsatisfyEnterPanel.InitState()
    UIPromptUnsatisfyEnterPanel.InitData()
end

function UIPromptUnsatisfyEnterPanel:Show(customData)
    if customData then
        UIPromptUnsatisfyEnterPanel.data = customData
        UIPromptUnsatisfyEnterPanel.InitUI()
        if UIPromptUnsatisfyEnterPanel.mUpdateItem ~= nil then
            CS.CSListUpdateMgr.Instance:Remove(UIPromptUnsatisfyEnterPanel.mUpdateItem)
        end
        UIPromptUnsatisfyEnterPanel.mUpdateItem = CS.CSListUpdateMgr.Add(100, nil, function()
            if CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.go) then
                return
            end
            UIPromptUnsatisfyEnterPanel.parent.transform.localPosition = CS.UnityEngine.Vector3.zero
            UIPromptUnsatisfyEnterPanel.changeTabel:Reposition()
            UIPromptUnsatisfyEnterPanel.bottomTabel:Reposition()
        end, false)
    end
end

--- 初始化组件
function UIPromptUnsatisfyEnterPanel:InitComponents()
    ---@type UnityEngine.GameObject
    UIPromptUnsatisfyEnterPanel.parent = self:GetCurComp("WidgetRoot/parent", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIPromptUnsatisfyEnterPanel.close = self:GetCurComp("WidgetRoot/parent/events/close", "GameObject")
    ---@type Top_UIGridContainer
    UIPromptUnsatisfyEnterPanel.Grid = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom/change/Grid", "Top_UIGridContainer")
    ---@type Top_UITable
    UIPromptUnsatisfyEnterPanel.bottomTabel = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom", "Top_UITable")
    ---@type Top_UITable
    UIPromptUnsatisfyEnterPanel.changeTabel = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom/change", "Top_UITable")
    ---@type UnityEngine.GameObject 进入商会按钮
    UIPromptUnsatisfyEnterPanel.mStorageBtn = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom/change/btn_enter", "GameObject")
    ---@type UILabel 进入商会按钮文字
    UIPromptUnsatisfyEnterPanel.mStorageBtnLabel = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom/change/btn_enter/Label", "UILabel")
    ---@type Top_UILabel 条件不足提示
    UIPromptUnsatisfyEnterPanel.Content = self:GetCurComp("WidgetRoot/parent/view/ScorllView/Bottom/Content", "Top_UILabel")
    ---@type Top_UILabel title
    UIPromptUnsatisfyEnterPanel.title = self:GetCurComp("WidgetRoot/parent/view/Title", "Top_UILabel")
end

---设置文本内容
function UIPromptUnsatisfyEnterPanel.SetContent(contentStr)
    if contentStr == nil then
        contentStr = ""
    end
    if CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.Content) == false and type(contentStr) == "string" then
        UIPromptUnsatisfyEnterPanel.Content.text = string.gsub(contentStr, "\\n", "\n")
    end
end

function UIPromptUnsatisfyEnterPanel.BindUIEvents()
    --点击关闭按钮事件
    CS.UIEventListener.Get(UIPromptUnsatisfyEnterPanel.close).onClick = UIPromptUnsatisfyEnterPanel.OnClickclose
    --点击进入商会事件
    CS.UIEventListener.Get(UIPromptUnsatisfyEnterPanel.mStorageBtn).onClick = UIPromptUnsatisfyEnterPanel.OnStorageBtnClicked
end

function UIPromptUnsatisfyEnterPanel.BindNetMessage()
    UIPromptUnsatisfyEnterPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIPromptUnsatisfyEnterPanel.ChangeEquip)
    UIPromptUnsatisfyEnterPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIPromptUnsatisfyEnterPanel.MainPlayerBeginWalk)
    UIPromptUnsatisfyEnterPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_CellTypeChange, UIPromptUnsatisfyEnterPanel.MainPlayerBeginWalk)
end

function UIPromptUnsatisfyEnterPanel.InitState()
    local panel = uimanager:GetPanel("UIJoystickPanel")
    if panel then
        --CS.UIEventListener.Get(panel:GetSmallTouchZone()).onPress = nil
        --CS.UIEventListener.Get(panel:GetSmallTouchZone()).onDrag = nil
        --CS.UIEventListener.Get(panel:GetTouchZone()).onPress = nil
        --CS.UIEventListener.Get(panel:GetTouchZone()).onDrag = nil
        if panel.isClickTouch then
            panel:RefreshJoyStick(false)
        end
        if panel.isClickSmallTouch then
            panel:RefreshSmallJoyStick(false)
        end
    end
end

function UIPromptUnsatisfyEnterPanel.InitData()
    ---@return CSRechargeInfoV2
    UIPromptUnsatisfyEnterPanel.mRechargeInfo = CS.CSScene.MainPlayerInfo.RechargeInfo
end

--endregion

--region 函数监听

--点击关闭按钮函数
---@param go UnityEngine.GameObject
function UIPromptUnsatisfyEnterPanel.OnClickclose(go)
    uimanager:ClosePanel('UIPromptUnsatisfyEnterPanel')
end

function UIPromptUnsatisfyEnterPanel.OnclickCostAddCallBack(go, type, needId)
    Utility.ShowItemGetWay(needId, go, LuaEnumWayGetPanelArrowDirType.Left);
end

--region 仓库进入二层未加入商会
function UIPromptUnsatisfyEnterPanel.OnStorageBtnClicked(go)
    if UIPromptUnsatisfyEnterPanel.mRechargeInfo then
        --[[
        if UIPromptUnsatisfyEnterPanel.mRechargeInfo.isFirstRecharge or not UIPromptUnsatisfyEnterPanel.mRechargeInfo.IsGetFirstRechargeReward then
            uimanager:CreatePanel("UIRechargeFirstTips")
        else
            uimanager:CreatePanel("UICommercePanel")
        end
        --]]
        --uimanager:CreatePanel("UICommercePanel")
        local hasCommerce = false;
        if not UIPromptUnsatisfyEnterPanel.isBiQi then
            if CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedBiQiCommerce() then
                hasCommerce = true;
                uimanager:CreatePanel("UIShopPanel", nil, {
                    type = LuaEnumStoreType.Diamond,
                    chooseStore = { 2001001 }
                })
            end
        end

        if (not hasCommerce) then
            uimanager:CreatePanel("UICommercePanel")
        end
    end
    uimanager:ClosePanel('UIPromptUnsatisfyEnterPanel')
end

--endregion

--endregion

--region 网络消息处理

function UIPromptUnsatisfyEnterPanel.ChangeEquip()
    --UIPromptUnsatisfyEnterPanel.InitUI(UIPromptUnsatisfyEnterPanel.list)
    UIPromptUnsatisfyEnterPanel.RefreshConditionShow()
    if UIPromptUnsatisfyEnterPanel.mUpdateItem ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIPromptUnsatisfyEnterPanel.mUpdateItem)
    end
    UIPromptUnsatisfyEnterPanel.mUpdateItem = CS.CSListUpdateMgr.Add(100, nil, function()
        if CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.go) then
            return
        end
        UIPromptUnsatisfyEnterPanel.changeTabel:Reposition()
        UIPromptUnsatisfyEnterPanel.bottomTabel:Reposition()
    end, false)
end

function UIPromptUnsatisfyEnterPanel.MainPlayerBeginWalk()
    if (CS.CSScene.Sington.MainPlayer.OldCell:isAttributes(CS.MapEditor.CellType.Transmit)) then
        return
    end
    uimanager:ClosePanel("UIPromptUnsatisfyEnterPanel")
end

--endregion

--region UI

function UIPromptUnsatisfyEnterPanel.InitUI()
    if UIPromptUnsatisfyEnterPanel.title then
        if UIPromptUnsatisfyEnterPanel.data.mapId then
            local mapName = CS.Cfg_MapTableManager.Instance:GetMapNameByMapId(UIPromptUnsatisfyEnterPanel.data.mapId)
            UIPromptUnsatisfyEnterPanel.title.text = mapName
        end
    end
    UIPromptUnsatisfyEnterPanel.RefreshConditionShow()
end

function UIPromptUnsatisfyEnterPanel.RefreshConditionShow()
    local list = UIPromptUnsatisfyEnterPanel.data.conditionList
    if list.Count == nil or list.Count == 0 then
        return
    end
    local conditionTypeList = CS.System.Collections.Generic["List`1[System.String]"]()
    local count = 0
    for i = 0, list.Count - 1 do
        if list[i].conditionId then
            local isFind, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(list[i].conditionId)
            if isFind then
                --商会特殊处理
                if info.conditionType == LuaEnumConditionKeyType.JoinStorage then
                    UIPromptUnsatisfyEnterPanel.RefreshStorageCondition()
                    return
                elseif info.conditionType == LuaEnumConditionKeyType.VIPLimit then
                    ---VIP限制特殊处理
                    count = 1
                    UIPromptUnsatisfyEnterPanel.Grid.MaxCount = count
                    local go = UIPromptUnsatisfyEnterPanel.Grid.controlList[0].gameObject
                    UIPromptUnsatisfyEnterPanel.RefreshVIPLimitCondition(go, info)
                    return
                elseif info.conditionType == LuaEnumConditionKeyType.ServerOpenPanel then
                    ---规避掉35类型的conditionType,该条件是服务器使用的
                else
                    count = count + 1
                    UIPromptUnsatisfyEnterPanel.Grid.MaxCount = count

                    local go = UIPromptUnsatisfyEnterPanel.Grid.controlList[i].gameObject
                    if go then
                        UIPromptUnsatisfyEnterPanel.SetCondiChild(go, info, list[i].isEnough == 1)
                    end
                    if list[i].isEnough == 0 then
                        conditionTypeList:Add(tostring(info.conditionType))
                    end
                end
            end
        end
    end

    if UIPromptUnsatisfyEnterPanel.Content ~= nil then
        local str = CS.Cfg_GlobalTableManager.Instance:GetTicketContent(conditionTypeList)
        UIPromptUnsatisfyEnterPanel.SetContent(str)
        --UIPromptUnsatisfyEnterPanel.Content.text = str
    end
end

--商会门票类型处理
function UIPromptUnsatisfyEnterPanel.RefreshStorageCondition()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MonthCardInfo == nil then
        return
    end
    local contents
    UIPromptUnsatisfyEnterPanel.isBiQi, contents = CS.Cfg_GlobalTableManager.Instance:GetTicketOfStorage(UIPromptUnsatisfyEnterPanel.data.mapId)
    if contents.Length == 0 then
        return
    end
    local CardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo
    if UIPromptUnsatisfyEnterPanel.isBiQi then
        --比奇商会
        if CardInfo:IsJoinedMengZhongCommerce() then
            -- 已加入盟重商会
            if UIPromptUnsatisfyEnterPanel.mStorageBtn ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.mStorageBtn) then
                UIPromptUnsatisfyEnterPanel.mStorageBtn:SetActive(false)
            end
            if UIPromptUnsatisfyEnterPanel.Content ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.Content) then
                UIPromptUnsatisfyEnterPanel.SetContent(contents[2])
                --UIPromptUnsatisfyEnterPanel.Content.text = contents[2]
            end
            UIPromptUnsatisfyEnterPanel.mStorageBtn:SetActive(false)
        else
            -- 未加入盟重商会
            if UIPromptUnsatisfyEnterPanel.mStorageBtn ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.mStorageBtn) then
                UIPromptUnsatisfyEnterPanel.mStorageBtn:SetActive(true)
            end
            if UIPromptUnsatisfyEnterPanel.Content ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.Content) then
                UIPromptUnsatisfyEnterPanel.SetContent(contents[1])
                --UIPromptUnsatisfyEnterPanel.Content.text = contents[1]
            end
        end
    else
        --盟重商会
        if CardInfo:IsJoinedBiQiCommerce() then
            -- 已加入比奇商会
            if UIPromptUnsatisfyEnterPanel.mStorageBtn ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.mStorageBtn) then
                UIPromptUnsatisfyEnterPanel.mStorageBtn:SetActive(true)
            end
            if UIPromptUnsatisfyEnterPanel.Content ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.Content) then
                UIPromptUnsatisfyEnterPanel.SetContent(contents[2])
                --UIPromptUnsatisfyEnterPanel.Content.text = contents[2]
            end
        else
            -- 未加入比奇商会
            if UIPromptUnsatisfyEnterPanel.mStorageBtn ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.mStorageBtn) then
                UIPromptUnsatisfyEnterPanel.mStorageBtn:SetActive(true)
            end
            if UIPromptUnsatisfyEnterPanel.Content ~= nil and not CS.StaticUtility.IsNull(UIPromptUnsatisfyEnterPanel.Content) then
                UIPromptUnsatisfyEnterPanel.SetContent(contents[1])
                --UIPromptUnsatisfyEnterPanel.Content.text = contents[1]
            end
        end
        UIPromptUnsatisfyEnterPanel.mStorageBtnLabel.text = "加入盟重商会"
    end
end
function UIPromptUnsatisfyEnterPanel.RefreshVIPLimitCondition(go, duplicateTable)
    if (go == nil) then
        return
    end
    local des = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "UILabel")
    local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "UISprite")
    local addBtn = CS.Utility_Lua.GetComponent(go.transform:Find("add"), "GameObject")
    local desTween = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "Top_TweenPosition")

    if (icon ~= nil) then
        icon.gameObject:SetActive(false)
    end
    if (desTween ~= nil) then
        desTween.enabled = true
        desTween:PlayForward()
    end
    if (des ~= nil) then
        des.text = "[e85038]" .. duplicateTable.show
    end
    CS.UIEventListener.Get(addBtn).onClick = nil
    CS.UIEventListener.Get(addBtn).onClick = function(go)
        uimanager:CreatePanel("UIVipInfoPanel")
    end
end
function UIPromptUnsatisfyEnterPanel.SetCondiChild(go, conditionTabel, isEnough)
    local des = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "UILabel")
    local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "UISprite")
    local addBtn = CS.Utility_Lua.GetComponent(go.transform:Find("add"), "GameObject")
    local desTween = CS.Utility_Lua.GetComponent(go.transform:Find("num"), "Top_TweenPosition")
    CS.UIEventListener.Get(icon.gameObject).onClick = nil
    CS.UIEventListener.Get(addBtn).onClick = nil

    if conditionTabel.conditionType == LuaEnumConditionKeyType.UnionClassification or
            conditionTabel.conditionType == LuaEnumConditionKeyType.KillMapAllMonster or
            conditionTabel.conditionType == LuaEnumConditionKeyType.GreatOpenServerDay
    then
        local color = "[e85038]"
        if isEnough then
            color = '[00ff00]'
        end
        des.text = color .. conditionTabel.show
        local position = des.transform.localPosition
        position.x = 0
        des.transform.localPosition = position
        des.gameObject:SetActive(true)
        icon.gameObject:SetActive(false)
        addBtn.gameObject:SetActive(false)
        desTween.gameObject:SetActive(true)
        return
    end

    if conditionTabel.conditionType == LuaEnumConditionKeyType.Prefix then
        ---战勋
        local color = ""
        local prefixShow = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(conditionTabel.id)
        local res, prefixInfo = CS.Cfg_PrefixTableManager.Instance.dic:TryGetValue(conditionTabel.conditionParam)
        if res then
            color = "[" .. prefixInfo.color .. "]"
        end
        des.text = luaEnumColorType.Red .. "战勋等级[-]" .. color .. prefixShow
        CS.UIEventListener.Get(addBtn).onClick = nil
        CS.UIEventListener.Get(addBtn).onClick = function(go)
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix)
        end
        icon.gameObject:SetActive(false)
        addBtn.gameObject:SetActive(true)
        desTween.enabled = true
        desTween:PlayForward()
        return
    end

    local isFind, info = CS.Cfg_GlobalTableManager.Instance.showTicketOfCondiTypeDic:TryGetValue(tostring(conditionTabel.conditionType))
    if isFind and info.Length > 2 then
        if conditionTabel.conditionType == LuaEnumConditionKeyType.ResourceConsumable then
            if conditionTabel.conditionParam.list.Count > 1 then
                local needItemCount = conditionTabel.conditionParam.list[0]
                local needItemId = conditionTabel.conditionParam.list[1]
                local needItemIdTwo = 0
                if conditionTabel.conditionParam.list.Count > 2 then
                    needItemIdTwo = conditionTabel.conditionParam.list[2]
                end
                --设置icon
                isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(needItemId)
                if isFind then
                    icon.spriteName = info.icon
                    --设置文本显示
                    local count = UIPromptUnsatisfyEnterPanel:GetCoinOrItemCount(info.id)
                    count = UIPromptUnsatisfyEnterPanel:GetCoinOrItemCount(needItemIdTwo) + count
                    des.text = count < needItemCount and luaEnumColorType.Red .. tostring(count) .. '/' .. tostring(needItemCount) or luaEnumColorType.Green .. tostring(count) .. '[-]/' .. tostring(needItemCount)
                    CS.UIEventListener.Get(icon.gameObject).onClick = function(go)
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
                    end
                end
                --设置点击
                CS.UIEventListener.Get(addBtn).onClick = nil
                CS.UIEventListener.Get(addBtn).onClick = function(go)
                    UIPromptUnsatisfyEnterPanel.OnclickCostAddCallBack(go, conditionTabel.conditionType, needItemId)
                end
            end
        else
            if conditionTabel.conditionParam.list.Count >= 1 then
                local str = string.format(info[1], tostring(conditionTabel.conditionParam.list[0]))
                des.text = isEnough and luaEnumColorType.White .. str .. '[-]' or luaEnumColorType.Red .. str .. '[-]'
            end
        end
        icon.gameObject:SetActive(conditionTabel.conditionType == LuaEnumConditionKeyType.ResourceConsumable)
        addBtn.gameObject:SetActive(conditionTabel.conditionType == LuaEnumConditionKeyType.ResourceConsumable)
        if conditionTabel.conditionType ~= LuaEnumConditionKeyType.ResourceConsumable then
            desTween.enabled = true
            desTween:PlayForward()
        else
            desTween.enabled = true
            desTween:PlayReverse()
        end

    end
end

function UIPromptUnsatisfyEnterPanel:GetCoinOrItemCount(itemID)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return 0
    end
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(itemID)
    if count == 0 then
        count = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemID)
    end
    return count
end

--endregion

--region ondestroy

function ondestroy()
    --local panel = uimanager:GetPanel("UIJoystickPanel")
    --if panel then
    --    panel:BindUIMessage()
    --end
    if UIPromptUnsatisfyEnterPanel.mUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(UIPromptUnsatisfyEnterPanel.mUpdateItem)
    end
end

--endregion


return UIPromptUnsatisfyEnterPanel