---所有的文字提示消息容器面板
---@class UIDownTipsContainerPanel:UIBase
local UIDownTipsContainerPanel = { }
--region 层级
UIDownTipsContainerPanel.PanelLayerType = CS.UILayerType.AisstPlane

--endregion

--region 参数
UIDownTipsContainerPanel.SpriteBlank = "          "

function UIDownTipsContainerPanel.GetEffectRoot_GameObject()
    if (UIDownTipsContainerPanel.mEffectRoot == nil) then
        UIDownTipsContainerPanel.mEffectRoot = UIDownTipsContainerPanel:GetCurComp("EffectRoot", "GameObject")
    end
    return UIDownTipsContainerPanel.mEffectRoot
end

function UIDownTipsContainerPanel:GetGlobalManager()
    if self.globalManager == nil then
        self.globalManager = CS.Cfg_GlobalTableManager.Instance
    end
    return self.globalManager
end

function UIDownTipsContainerPanel:GetMainPlayer()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 初始化
function UIDownTipsContainerPanel:Init()
    UIDownTipsContainerPanel.InitComponents()
    UIDownTipsContainerPanel.InitOther()
    UIDownTipsContainerPanel.BindClientMsg()
    UIDownTipsContainerPanel.BindNetMsg()
end

---控件变量
function UIDownTipsContainerPanel.InitComponents()
    --中间提示GameObject
    UIDownTipsContainerPanel.mMiddleTips_GameObject = UIDownTipsContainerPanel:GetCurComp("Middle", "GameObject")
    --中上提示GameObject
    UIDownTipsContainerPanel.mMiddleTopTips_GameObject = UIDownTipsContainerPanel:GetCurComp("MiddleTop", "GameObject")
    --中下提示GameObject
    UIDownTipsContainerPanel.mCenterBottomTips_GameObject = UIDownTipsContainerPanel:GetCurComp("centerBottom", "GameObject")
end

---初始化
function UIDownTipsContainerPanel.InitOther()
    UIDownTipsContainerPanel.mMiddleTips = templatemanager.GetNewTemplate(UIDownTipsContainerPanel.mMiddleTips_GameObject, luaComponentTemplates.UITextTipsContainerTemplate)
    UIDownTipsContainerPanel.mMiddleTopTips = templatemanager.GetNewTemplate(UIDownTipsContainerPanel.mMiddleTopTips_GameObject, luaComponentTemplates.UITextTipsContainerTemplate)
    if UIDownTipsContainerPanel.mMiddleTips then
        UIDownTipsContainerPanel.mMiddleTips:Show(5, 35)
    end
    if UIDownTipsContainerPanel.mMiddleTopTips then
        UIDownTipsContainerPanel.mMiddleTopTips:Show(5, 35)
    end

    ----需要修理的装备
    UIDownTipsContainerPanel.mNeedRepairEquips = {}
    ----需要修理的耐久度界限值
    UIDownTipsContainerPanel.mNeedRepairValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()
end

---绑定服务器消息
function UIDownTipsContainerPanel.BindNetMsg()
    --穿戴装备提示
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResEquipChangeMessage, UIDownTipsContainerPanel.OnResEquipChangeMessage)
    --泡点提示
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResBubbleOnlineExpMessage, UIDownTipsContainerPanel.OnResBubbleOnlineExpMessage)
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResReceiveBubbleOfflineExpMessage, UIDownTipsContainerPanel.OnResBubbleOnlineExpMessage)
    --背包变化
    UIDownTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIDownTipsContainerPanel.OnResBagChangeMessage)
end

function UIDownTipsContainerPanel.BindClientMsg()
    UIDownTipsContainerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_UpAdaptive, UIDownTipsContainerPanel.OnUpAdaptiveClicked)
    UIDownTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2__MiddleTopTips, UIDownTipsContainerPanel.OnMiddleTopTips)
    UIDownTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_DownMiddleTips, UIDownTipsContainerPanel.OnDownMiddleTopTips)
    --更新目标任务
    UIDownTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIDownTipsContainerPanel.TaskProgressTips)
end
--endregion

--region 客户端消息
function UIDownTipsContainerPanel.OnMiddleTopTips(msgId, msg)
    UIDownTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTopTips, msg)
end

function UIDownTipsContainerPanel.OnDownMiddleTopTips(msgId, msg)
    UIDownTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTips, msg)
end

---提示正在进行的指定任务的进度
function UIDownTipsContainerPanel.TaskProgressTips(id, taskState, params)
    if taskState == CS.ETaskV2_TaskState.HAS_ACCEPT then
        local goalsList = params.tipsGoals
        if goalsList == nil then
            return
        end
        local length = goalsList.Count - 1
        for k = 0, length do
            local v = goalsList[k]
            if v ~= nil and params.isNeedTips and v.taskTips ~= 0 then
                local tipsType = CS.Cfg_GlobalTableManager.Instance:GetTipsShowTypeByTaskGoalId(v.goalId)
                local curCount = v.curCount
                local maxCount = v.maxCount
                if tipsType == -1 then
                    return
                end
                local tipsTxtList = CS.Cfg_GlobalTableManager.Instance:GetTaskTxtList()
                if tipsTxtList.Count < tipsType then
                    return
                end
                local tipsList = tipsTxtList[tipsType]
                local tipOpenAndTips = string.Split(tipsList, '#')
                if #tipOpenAndTips < 2 then
                    return
                end
                local info = UIDownTipsContainerPanel:GetInfo(tipsType, v.taskTips)
                if info == nil then
                    return
                end
                local tipsString1 = tipOpenAndTips[2] .. info.name
                local iconName = nil
                if tipOpenAndTips[1] == "1" then
                    iconName = info.icon
                    tipsString1 = tipOpenAndTips[2] .. UIDownTipsContainerPanel.SpriteBlank .. info.name
                end
                UIDownTipsContainerPanel.SendMiddleTopTips(tipOpenAndTips[2], iconName, info.name)
            end
        end
    end
end
--endregion

--region 服务器消息

---穿戴装备
function UIDownTipsContainerPanel.OnResEquipChangeMessage(msgId, tblData, csData)
    if tblData == nil then
        return
    end
    local infos = tblData.equipChange
    if (infos == nil) then
        return ;
    end
    for i = 1, #infos do
        local info = infos[i].changeEquip
        if info ~= nil then
            --已经有装备了，不提示
            --if UIDownTipsContainerPanel.mEquipIndexChange[tostring(info.equipIndex)] ~= nil
            --        and UIDownTipsContainerPanel.mEquipIndexChange[tostring(info.equipIndex)] == 1 then
            --    break
            --end
            --UIDownTipsContainerPanel.mEquipIndexChange[tostring(info.equipIndex)] = 1
        else
            --脱装备不提示
            if infos[i] ~= nil and infos[i].equipIndex ~= nil and UIDownTipsContainerPanel.mEquipIndexChange ~= nil and type(UIDownTipsContainerPanel.mEquipIndexChange) == "table" then
                UIDownTipsContainerPanel.mEquipIndexChange[infos[i].equipIndex] = 0
            end
            break
        end
        --获取最好的装备

        local isFind, changeItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.itemId)
        if isFind then
            if (CS.CSScene.MainPlayerInfo.Level <= 70) then
                UIDownTipsContainerPanel.SendMiddleTopTips("[00ff00]装备[-]", info.itemId, changeItem.name)
            end
        end
    end
end

---泡点提示
function UIDownTipsContainerPanel.OnResBubbleOnlineExpMessage(msgID, tblData, csData)
    local IConId = "1000006"
    UIDownTipsContainerPanel.SendMiddleTopTips("获得了", IConId, "经验" .. tblData.exp)
end

---背包变化
function UIDownTipsContainerPanel.OnResBagChangeMessage(msgId, tblData)
    ---采集获得物品显示tips(挖到了)
    if tblData ~= nil and (tblData.action == LuaEnumBagChangeAction.Gather_Item or tblData.action == LuaEnumBagChangeAction.AUTOMATIC_COLLECT_DROP)
            and tblData.itemList ~= nil and #tblData.itemList > 0
            and UIDownTipsContainerPanel:GetMainPlayer().Level <= UIDownTipsContainerPanel:GetGlobalManager():GetGatherItemTipsShowLevel() then
        UIDownTipsContainerPanel:ShowTipsByBagItemInfoTable(tblData.itemList, UIDownTipsContainerPanel:GetGlobalManager():GetGatherTipsForwardText())
    end
    ---钓鱼（钓到了）
    if tblData ~= nil and tblData.action == LuaEnumBagChangeAction.Gather_FishingItem and tblData.itemList ~= nil and #tblData.itemList > 0 and UIDownTipsContainerPanel:GetMainPlayer().Level <= UIDownTipsContainerPanel:GetGlobalManager():GetGatherItemTipsShowLevel() then
        UIDownTipsContainerPanel:ShowTipsByBagItemInfoTable(tblData.itemList, "[fffab3]钓到了")
    end
    --[[    ---马牌（获得了）
        if tblData ~= nil and tblData.action == LuaEnumBagChangeAction.Gather_TrainingHorse and tblData.itemList ~= nil and #tblData.itemList > 0 and UIDownTipsContainerPanel:GetMainPlayer().Level <= UIDownTipsContainerPanel:GetGlobalManager():GetGatherItemTipsShowLevel() then
            UIDownTipsContainerPanel:ShowTipsByBagItemInfoTable(tblData.itemList, "[fffab3]获得了")
        end]]
end
--endregion

--region 客户端消息


---向上自适应（根据呼吸框显示）
function UIDownTipsContainerPanel.OnUpAdaptiveClicked(msgId, data)
    if data == nil then
        return
    end
    local pos = UIDownTipsContainerPanel.mMiddleTips_GameObject.transform.parent:InverseTransformPoint(data.pos)
    UIDownTipsContainerPanel.mMiddleTips_GameObject.transform.localPosition = CS.UnityEngine.Vector3(pos.x, pos.y + 50, pos.z)
end

--endregion

--region 获取
function UIDownTipsContainerPanel:GetInfo(tipsType, itemid)
    if tipsType == LuaEnumMissionTipsType.Equip or tipsType == LuaEnumMissionTipsType.Pickup or tipsType == LuaEnumMissionTipsType.Digup or tipsType == LuaEnumMissionTipsType.Gain then
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemid)
        if itemInfoIsFind then
            return itemInfo
        end
    elseif tipsType == LuaEnumMissionTipsType.Skill then
        local skillInfoIsFind, skillInfo = CS.Cfg_SkillTableManager.Instance:TryGetValue(itemid)
        local skillInfo = {
            name = skillInfo.name,
            icon = CS.Cfg_GlobalTableManager.Instance:GetMissionTipsSkillIconName()
        }
        return skillInfo
    end
end
--endregion

--region 显示tips
---早期的tips
function UIDownTipsContainerPanel.SendTips(tipsType, tips, iconName)
    if tipsType == LuaEnumTextTipsType.LeftBottomTips then
        UIDownTipsContainerPanel.mLeftBottomTips:AddTips({ tipsType = LuaEnumTextTipsType.LeftBottomTips, firstStr = tips, itemId = tonumber(iconName) })
    elseif tipsType == LuaEnumTextTipsType.MiddleTips then
        UIDownTipsContainerPanel.mMiddleTips:AddTips({ tipsType = LuaEnumTextTipsType.MiddleTips, firstStr = tips, itemId = tonumber(iconName) })
    end
end

--region 显示tips(例如：装备了+icon+装备名)
---通过背包物品列表信息表显示tips
function UIDownTipsContainerPanel:ShowTipsByBagItemInfoTable(bagItemInfoTable, iconForwardText)
    if bagItemInfoTable ~= nil and type(bagItemInfoTable) == 'table' then
        for k, v in pairs(bagItemInfoTable) do
            self:ShowTipsByBagItemInfo(v, iconForwardText)
        end
    end
end

---通过背包物品信息显示tips
function UIDownTipsContainerPanel:ShowTipsByBagItemInfo(bagItemInfo, iconForwardText)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfoIsFind then
        self:ShowTipsByItemInfo(itemInfo, iconForwardText)
    end
end

---通过物品信息显示tips
function UIDownTipsContainerPanel:ShowTipsByItemInfo(itemInfo, iconForwardText)
    if itemInfo ~= nil and not CS.StaticUtility.IsNullOrEmpty(iconForwardText) then
        --local str = iconForwardText .. self.SpriteBlank .. itemInfo.name
        local iconName = itemInfo.icon
        self.SendMiddleTopTips(iconForwardText, iconName, itemInfo.name)
    end
end

function UIDownTipsContainerPanel.SendMiddleTopTips(tips, iconName, secondLabel, secondSpriteName)
    UIDownTipsContainerPanel.mMiddleTopTips:AddTips({ tipsType = LuaEnumTextTipsType.MiddleTopTips, firstStr = tips, secondStr = secondLabel, secondSpriteName = secondSpriteName, itemId = tonumber(iconName) })
end
--endregion
--endregion

return UIDownTipsContainerPanel