local UIRechargeMemberTipsPanel = {}

function UIRechargeMemberTipsPanel:InitComponents()
    UIRechargeMemberTipsPanel.Bg = self:GetCurComp('WidgetRoot/Tip/Bg', 'UISprite')
    UIRechargeMemberTipsPanel.mainGrid = self:GetCurComp('WidgetRoot/Tip/Info/Grid', 'UIGridContainer')

    UIRechargeMemberTipsPanel.childObj = self:GetCurComp('WidgetRoot/Tip1', 'GameObject')
    UIRechargeMemberTipsPanel.childGrid = self:GetCurComp('WidgetRoot/Tip1/Info/Grid', 'UIGridContainer')
    UIRechargeMemberTipsPanel.childBg = self:GetCurComp('WidgetRoot/Tip1/Bg', 'UISprite')

    UIRechargeMemberTipsPanel.blackbox = self:GetCurComp('WidgetRoot/blackbox', 'GameObject')
end

function UIRechargeMemberTipsPanel:InitOther()
    CS.UIEventListener.Get(UIRechargeMemberTipsPanel.blackbox).onClick = self.onClickblackbox
end

function UIRechargeMemberTipsPanel:Init()
    self:InitComponents()
    self:InitOther()
end

---@param data table<number,number> --List<cfg_task_jumpID>
function UIRechargeMemberTipsPanel:Show(data, Basetransform)
    if Basetransform ~= nil then
        UIRechargeMemberTipsPanel.offsY = Basetransform.localPosition.y
        UIRechargeMemberTipsPanel.offsPositionX = Basetransform.position.x
        UIRechargeMemberTipsPanel.offsPositionY = Basetransform.position.y
    end
    UIRechargeMemberTipsPanel.go.transform.position = Basetransform.position
    local posX = UIRechargeMemberTipsPanel.go.transform.localPosition.x
    local posY = UIRechargeMemberTipsPanel.go.transform.localPosition.y
    UIRechargeMemberTipsPanel.go.transform.localPosition = CS.UnityEngine.Vector3(posX + 160, posY - 27, 1);
    UIRechargeMemberTipsPanel.childObj.gameObject:SetActive(false)
    UIRechargeMemberTipsPanel.SetGrid(data, UIRechargeMemberTipsPanel.mainGrid, self.onMainMenuClick)
    UIRechargeMemberTipsPanel.AdaptiveBg(UIRechargeMemberTipsPanel.Bg, UIRechargeMemberTipsPanel.mainGrid, 6)
end

---设置菜单列表
function UIRechargeMemberTipsPanel.SetGrid(data, Grid, onMenuClick)
    if data == nil then
        return
    end
    Grid.MaxCount = data.Count
    if data.Count == 0 then
        uimanager:ClosePanel('UIRechargeMemberTipsPanel')
    end
    local maxIndex = data.Count
    for i = 0, maxIndex - 1 do
        local item = Grid.controlList[i].gameObject
        local Label = CS.Utility_Lua.GetComponent(item.transform:Find("Label"), "UILabel")
        local sprite = CS.Utility_Lua.GetComponent(item.transform:Find("Sprite"), "UISprite")
        if sprite ~= nil then
            sprite.spriteName = "MissionOperation_btn1"
        end
        if Label ~= nil then
            Label.text = "[849ea4]" .. data[i].title
        end
        CS.UIEventListener.Get(item).onClick = function()
            onMenuClick(data[i], item)
        end

    end
end

---主菜单点击
---@param data TABLE.CFG_TASK_JUMP
function UIRechargeMemberTipsPanel.onMainMenuClick(data, go)
    if data == nil then
        return
    end
    UIRechargeMemberTipsPanel.SelectBtn(go, UIRechargeMemberTipsPanel.mainGrid)
    local datalist = CS.Cfg_TaskJumpTableManager.Instance:GteMainMenuList(data.ascription)
    UIRechargeMemberTipsPanel.childObj.gameObject:SetActive(datalist ~= nil)
    if datalist ~= nil then
        if go ~= nil then
            local pos = UIRechargeMemberTipsPanel.childObj.gameObject.transform.localPosition
            pos.y = go.transform.localPosition.y + 26
            UIRechargeMemberTipsPanel.childObj.gameObject.transform.localPosition = pos;
        end
    else
        UIRechargeMemberTipsPanel.ExecuteOperation(data)
    end
    UIRechargeMemberTipsPanel.SetGrid(datalist, UIRechargeMemberTipsPanel.childGrid,
            UIRechargeMemberTipsPanel.onChildMenuClick)
    UIRechargeMemberTipsPanel.AdaptiveBg(UIRechargeMemberTipsPanel.childBg, UIRechargeMemberTipsPanel.childGrid, 6)
end

---子菜单点击
---@param data TABLE.CFG_TASK_JUMP
---@param go UnityEngine.GameObject
function UIRechargeMemberTipsPanel.onChildMenuClick(data, go)
    UIRechargeMemberTipsPanel.SelectBtn(go, UIRechargeMemberTipsPanel.childGrid)
    UIRechargeMemberTipsPanel.ExecuteOperation(data)
end

---设置当前选中
function UIRechargeMemberTipsPanel.SelectBtn(go, Grid)
    local maxIndex = Grid.MaxCount
    for i = 0, maxIndex - 1 do
        local item = Grid.controlList[i].gameObject
        local spriteName = "MissionOperation_btn1"
        local labelColor = "[849ea4]"
        if item == go then
            spriteName = "MissionOperation_btn2"
            labelColor = "[fff0c2]"
        end
        local Label = CS.Utility_Lua.GetComponent(item.transform:Find("Label"), "UILabel")
        local sprite = CS.Utility_Lua.GetComponent(item.transform:Find("Sprite"), "UISprite")
        if Label ~= nil then
            Label.text = labelColor .. CS.Utility.FormattingString(Label.text)
        end
        if sprite ~= nil then
            sprite.spriteName = spriteName
        end
    end
end

---适配背景
function UIRechargeMemberTipsPanel.AdaptiveBg(Bg, GridContainer, extraCount)
    if Bg == nil then
        return
    end
    if GridContainer == nil then
        return
    end
    local Bgvalue = GridContainer.CellHeight * GridContainer.MaxCount + extraCount
    Bg.height = Bgvalue
end

---@param data TABLE.CFG_TASK_JUMP
function UIRechargeMemberTipsPanel.ExecuteOperation(data)
    if data == nil then
        return
    end
    local type = data.type

    if type == 1 then
        UIRechargeMemberTipsPanel.OpenPanel(data)
    elseif type == 2 then
        UIRechargeMemberTipsPanel.JumpOpenPanel(data)
    elseif type == 3 then
        UIRechargeMemberTipsPanel.OpenRewardPanel(data)
    elseif type == 4 then
        UIRechargeMemberTipsPanel.DoTask(data)
    elseif type == 5 then
        UIRechargeMemberTipsPanel.FindNPC(data)
    elseif type == 6 then
        UIRechargeMemberTipsPanel.TradeJump(data)
    elseif type == 7 then
        UIRechargeMemberTipsPanel.StoreJump(data)
    elseif type == 8 then
        UIRechargeMemberTipsPanel.JumpElite(data)
    elseif type == 9 then
        UIRechargeMemberTipsPanel.killMonster(data)
    elseif type == 10 then
        UIRechargeMemberTipsPanel.killBossMonster(data)
    elseif type == 11 then
        UIRechargeMemberTipsPanel.DoMonsterTask(data)
    end
    uimanager:ClosePanel('UIRechargeMemberTipsPanel')

end

--region 操作
---①普通打开界面
function UIRechargeMemberTipsPanel.OpenPanel(data)
    uimanager:CreatePanel(data.openPanel)
end

---②普通jump表跳转界面界面
function UIRechargeMemberTipsPanel.JumpOpenPanel(data)
    uiTransferManager:TransferToPanel(data.openPanel)
end

---③跳转礼包界面并框选
function UIRechargeMemberTipsPanel.OpenRewardPanel(data)
    local customData = {}
    customData.type = LuaEnumRechargeType.Reward
    local id = CS.Cfg_TaskJumpTableManager.Instance:GetReward(data)
    if id ~= -1 then
        customData.selectRewardID = id
    end
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.TaskOpenRechargePanel
    --uimanager:CreatePanel('UIRechargePanel', nil, customData)
    uimanager:CreatePanel("UIRechargeMainPanel", nil, LuaEnumRechargeMainBookMarkType.Recharge,customData)
end

---④做任务
function UIRechargeMemberTipsPanel.DoTask(data)

end

---⑤寻找NPC
function UIRechargeMemberTipsPanel.FindNPC(data)
    if data.openPanel == nil or data.openPanel == "" then
        return
    end
    if data.additional ~= "" and data.additional ~= nil then
        CS.Cfg_DeliverTableManager.Instance:TryTransferByDeliverId(tonumber(data.additional), function()
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(tonumber(data.openPanel))
        end, false);
        return
    end
    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(tonumber(data.openPanel))
end

---⑥交易行跳转
function UIRechargeMemberTipsPanel.TradeJump(data)
    ---@type AuctionPanelData
    local customData = {}
    customData.IsShowGuessLike = true
    customData.needSelectItemIdList = {
        tonumber(data.additional)
    }
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Trade, customData, nil);
end

---⑦商城跳转
function UIRechargeMemberTipsPanel.StoreJump(data)
    local customData = {}
    local isfind, store = CS.Cfg_StoreTableManager.Instance:TryGetValue(data.additional)
    if isfind then
        customData.type = store.sellId
    end
    customData.chooseStore = {};
    table.insert(customData.chooseStore, tonumber(data.additional));
    uiTransferManager:TransferToPanel(data.openPanel, customData)
end

---⑧精英任务跳转
function UIRechargeMemberTipsPanel.JumpElite(data)
    local csmission = CS.CSMissionManager.Instance:GetEliteTask()
    if csmission ~= nil and csmission.tbl_taskGoalS ~= nil and csmission.tbl_taskGoalS.Count ~= 0 then
        local uiMissionPanel = uimanager:GetPanel("UIMissionPanel")
        if uiMissionPanel ~= nil and uiMissionPanel.missionTemplate ~= nil then
            local task = uiMissionPanel.missionTemplate:SetTaskTemplates(LuaEnumShowTaskType.Elite)
            if task ~= nil then
                task:EliteOnClick()
            end
        end
    else
        local maintask = CS.CSMissionManager.Instance:GetMainTask()
        if maintask ~= nil then
            CS.CSMissionManager.Instance:FindTaskTarget(maintask)
        end
    end
end

function UIRechargeMemberTipsPanel.killBossMonster(data)
    Utility.OpenBossTaskPanel()
end

function UIRechargeMemberTipsPanel.DoMonsterTask(data)
    uimanager:CreatePanel(data.openPanel)
end

function UIRechargeMemberTipsPanel.killMonster(data)
    local mapIDList = _fSplit(data.additional, "#")
    local isTargetMap = false
    if mapIDList ~= nil then
        for k, v in pairs(mapIDList) do
            if tonumber(v) == CS.CSScene.getMapID() then
                isTargetMap = true
            end
        end
    end

    if isTargetMap then
        CS.CSAutoFightMgr.Instance:Toggle(true);
        CS.Utility.ShowTips("[ffe7be]已在目标地图[-]", 1.5, CS.ColorType.White)
    else
        networkRequest.ReqDeliverByReason(tonumber(data.openPanel), 41)
    end

end
--endregion

function UIRechargeMemberTipsPanel.onClickblackbox()
    uimanager:ClosePanel('UIRechargeMemberTipsPanel')
end

function UIRechargeMemberTipsPanel:RefreshUI()

end

function ondestroy()
    CS.CSMissionManager.Instance.IsUIOpenJumpTip = false;
end

return UIRechargeMemberTipsPanel