---@class UIAllTextTipsContainerPanel:UIBase 所有的文字提示消息容器面板
local UIAllTextTipsContainerPanel = { }
--region 层级
UIAllTextTipsContainerPanel.PanelLayerType = CS.UILayerType.ConnectPlane

--endregion

--region 参数
UIAllTextTipsContainerPanel.SpriteBlank = "          "

function UIAllTextTipsContainerPanel.GetEffectRoot_GameObject()
    if (UIAllTextTipsContainerPanel.mEffectRoot == nil) then
        UIAllTextTipsContainerPanel.mEffectRoot = UIAllTextTipsContainerPanel:GetCurComp("EffectRoot", "GameObject")
    end
    return UIAllTextTipsContainerPanel.mEffectRoot
end

function UIAllTextTipsContainerPanel:GetGlobalManager()
    if self.globalManager == nil then
        self.globalManager = CS.Cfg_GlobalTableManager.Instance
    end
    return self.globalManager
end

function UIAllTextTipsContainerPanel:GetMainPlayer()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 初始化
function UIAllTextTipsContainerPanel:Init()
    UIAllTextTipsContainerPanel.InitComponents()
    UIAllTextTipsContainerPanel.InitOther()
    UIAllTextTipsContainerPanel.BindNetMsg()
    UIAllTextTipsContainerPanel.BindClientMsg()
end

---控件变量
function UIAllTextTipsContainerPanel.InitComponents()
    --左下提示GameObject
    UIAllTextTipsContainerPanel.mLeftBottomTips_GameObject = UIAllTextTipsContainerPanel:GetCurComp("LeftDown", "GameObject")
    --右边提示GameObject
    UIAllTextTipsContainerPanel.mRightTips_GameObject = UIAllTextTipsContainerPanel:GetCurComp("Right", "GameObject")
    --中间提示GameObject
    UIAllTextTipsContainerPanel.mMiddleTips_GameObject = UIAllTextTipsContainerPanel:GetCurComp("Middle", "GameObject")
    --中上提示GameObject
    UIAllTextTipsContainerPanel.mMiddleTopTips_GameObject = UIAllTextTipsContainerPanel:GetCurComp("MiddleTop", "GameObject")
    --中下提示GameObject
    UIAllTextTipsContainerPanel.mCenterBottomTips_GameObject = UIAllTextTipsContainerPanel:GetCurComp("centerBottom", "GameObject")
    --中下提示Widget
    --UIAllTextTipsContainerPanel.mCenterBottomTips_Widget = UIAllTextTipsContainerPanel:GetCurComp("centerBottom", "Top_UIWidget")
end

---初始化
function UIAllTextTipsContainerPanel.InitOther()
    UIAllTextTipsContainerPanel.mMiddleTips = templatemanager.GetNewTemplate(UIAllTextTipsContainerPanel.mMiddleTips_GameObject, luaComponentTemplates.UITextTipsContainerTemplate)
    ---@type UITextTipsContainerTemplate
    UIAllTextTipsContainerPanel.mLeftBottomTips = templatemanager.GetNewTemplate(UIAllTextTipsContainerPanel.mLeftBottomTips_GameObject, luaComponentTemplates.UITextTipsContainerTemplate)
    ---@type UITextTipsContainerTemplate
    UIAllTextTipsContainerPanel.mMiddleTopTips = templatemanager.GetNewTemplate(UIAllTextTipsContainerPanel.mMiddleTopTips_GameObject, luaComponentTemplates.UITextTipsContainerTemplate)
    if UIAllTextTipsContainerPanel.mLeftBottomTips then
        UIAllTextTipsContainerPanel.mLeftBottomTips:Show(10, 24)
    end
    if UIAllTextTipsContainerPanel.mMiddleTips then
        UIAllTextTipsContainerPanel.mMiddleTips:Show(5, 35)
    end
    if UIAllTextTipsContainerPanel.mMiddleTopTips then
        UIAllTextTipsContainerPanel.mMiddleTopTips:Show(10, 35)
    end

    ----装备位变动表，0表示没有有准备，1表示有准备
    --UIAllTextTipsContainerPanel.mEquipIndexChange = {}
    ----需要修理的装备
    UIAllTextTipsContainerPanel.mNeedRepairEquips = {}
    ----需要修理的装备提示计时器
    --UIAllTextTipsContainerPanel.mShowRepairEquipTimer = 0
    ----需要修理的装备提示事件
    --UIAllTextTipsContainerPanel.mShowRepairEquipTime = 0
    ----需要修理的耐久度界限值
    UIAllTextTipsContainerPanel.mNeedRepairValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()

    -- UIAllTextTipsContainerPanel.originCenterBottomPos = UIAllTextTipsContainerPanel.mCenterBottomTips_GameObject.transform.localPosition
end

---绑定服务器消息
function UIAllTextTipsContainerPanel.BindNetMsg()
    --经验变化
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerExpChangeMessage, UIAllTextTipsContainerPanel.OnResPlayerExpChangeMessage)
    --vip经验变化
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleVipInfoChangeMessage, UIAllTextTipsContainerPanel.OnResRoleVipInfoChangeMessage)
    --提示服务器
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPromptMessage, UIAllTextTipsContainerPanel.OnResPromptMessage)
    --使用技能书提示
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, UIAllTextTipsContainerPanel.OnResOneSkillChangeMessage)
    --使用灵兽蛋提示
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUseServantEggMessage, UIAllTextTipsContainerPanel.OnResUseServantEggMessage)
    --物品获取提示
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResItemTipsMessage, UIAllTextTipsContainerPanel.OnResItemTipsMessage)
    --穿戴装备提示
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEquipChangeMessage, UIAllTextTipsContainerPanel.OnResEquipChangeMessage)
end

---绑定客户端消息
function UIAllTextTipsContainerPanel.BindClientMsg()
    UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_LeftBottomTips, UIAllTextTipsContainerPanel.OnLeftBottomTips)
    UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MiddleTips, UIAllTextTipsContainerPanel.OnMiddleTips)
    -- UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2__MiddleTopTips, UIAllTextTipsContainerPanel.OnMiddleTopTips)
    --更新目标任务
    --UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.Task_GoalUpdate, UIAllTextTipsContainerPanel.TaskProgressTips)
    --向上自适应

    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_UpAdaptive, UIAllTextTipsContainerPanel.OnUpAdaptiveClicked)
    UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionScoreChange, UIAllTextTipsContainerPanel.OnMiddleTopTips)
    ---背包变化提示
    UIAllTextTipsContainerPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_HintMiddleTips, UIAllTextTipsContainerPanel.OnResBagChangeMessage)

    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.SendMiddleTopTips, UIAllTextTipsContainerPanel.OnSendMiddleTopClientMessageReceived)

    --狼烟梦境时间获得提示
    UIAllTextTipsContainerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshDreamlandRemainTimeChange, UIAllTextTipsContainerPanel.OnRefreshDreamlandRemainTime)
end

--endregion

--region 服务器消息
---玩家经验变化
function UIAllTextTipsContainerPanel.OnResPlayerExpChangeMessage(msgId, tblData, csData)
    local str = ""
    if tblData.addExp ~= nil and tblData.addExp ~= 0 then
        str = CS.Utility_Lua.CombineExpTipsStr(tblData.addExp, "经验")
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, str, 1000006)
    end
    if tblData.addInnerPowerExp ~= nil and tblData.addInnerPowerExp ~= 0 then
        str = CS.Utility_Lua.CombineExpTipsStr(tblData.addInnerPowerExp, "内功经验")
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, str)
    end
    if UIAllTextTipsContainerPanel.IsShowServantExp() then
        if tblData.addHsExp ~= nil and tblData.addHsExp ~= 0 then
            str = CS.Utility_Lua.CombineExpTipsStr(tblData.addHsExp, "灵兽经验")
            if tblData.logAction == 46008 then
                UIAllTextTipsContainerPanel.SendMiddleTopTips("灵兽经验", 1000021, tostring(tblData.addHsExp))
            else
                UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, str, 1000021)
            end
            --
        end
    end
    UIAllTextTipsContainerPanel:JvLingZhuUseTips(tblData)
end

---Vip经验变化
function UIAllTextTipsContainerPanel.OnResRoleVipInfoChangeMessage(msgId, tblData, csData)
    --local str = CS.Utility_Lua.CombineExpTipsStr(tblData.changeExp, "VIP经验")
    --UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, str)
end

---提示消息
function UIAllTextTipsContainerPanel.OnResPromptMessage(msgId, tblData, csData)
    if tblData == nil then
        return
    end
    if tblData.type == 3 then
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, tblData.msg)
    elseif tblData.type == 5 then
        if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor then
            if (CS.CSDebug.developerConsoleVisible) then
                CS.CSDebug.LogError(tblData.msg);
            end
        end
    elseif tblData.type == 6 then
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.DelayMiddleTips, tblData.msg)
    elseif tblData.type == 10 then
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTopTips, tblData.msg)
    else
        UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTips, tblData.msg)
    end
    --测试用,后续删除
    --if (CS.CSGame.Sington.IsDebugMainPlayerPos) then
    --    if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
    --        CS.CSGame.Sington:DebugLogTest(tblData.msg);
    --    end
    --end
end

---使用技能书
function UIAllTextTipsContainerPanel.OnResOneSkillChangeMessage(msgId, tblData, csData)
    local skillId = tblData.skillId
    local isFind, item = CS.Cfg_SkillTableManagerBase.Instance:TryGetValue(skillId)
    if isFind then
        --只要使用技能书就显示提示
        local UseSkillBookShildMissionIdList = CS.Cfg_GlobalTableManager.Instance:GetUseSkillBookShildMissionIdList()
        local isHaveMission = CS.CSMissionManager.Instance:IsHasAcceptMission(UseSkillBookShildMissionIdList)
        --只有学习才提示
        local isLearn = false;
        local isGetValue, skillBean = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDic:TryGetValue(skillId);
        if (isGetValue) then
            isLearn = skillBean.level == 1 and skillBean.exp == 0;
        end

        if not isHaveMission and isLearn then
            local itemName = item.name
            local useTextContent = CS.Cfg_GlobalTableManager.Instance:GetSkillUseTextContent()
            local iconName = CS.Cfg_GlobalTableManager.Instance:GetMissionTipsSkillIconName()
            if iconName ~= "" and useTextContent ~= "" then
                UIAllTextTipsContainerPanel.SendMiddleTopTips(useTextContent, iconName, itemName)
            end
        end
    end
end

---使用灵兽蛋
function UIAllTextTipsContainerPanel.OnResUseServantEggMessage(msgId, tblData, csData)
    UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTopTips, "[00ff00]召唤[-]", tblData.itemId, tblData.name)
end

---物品获取提示
function UIAllTextTipsContainerPanel.OnResItemTipsMessage(msgId, tblData, csData)
    if tblData ~= nil and tblData.tip ~= nil then
        for k, v in pairs(tblData.tip) do
            local itemTip = v
            local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemTip.itemId)
            local tipsInfo = CS.Cfg_GlobalTableManager.Instance:GetTipsInfoByItemId(itemTip.itemId)
            if itemInfoIsFind == true and itemTip.count > 0 and tipsInfo ~= nil then
                local firstStr = tipsInfo.Prefix
                local firstIconName = itemInfo.icon
                local secondStr = itemInfo.name
                if itemTip.count > 1 then
                    secondStr = itemInfo.name .. "  " .. itemTip.count
                end
                local secondIconName = CS.Cfg_GlobalTableManager.Instance:GetCriticalSpriteName(itemTip.multi)
                UIAllTextTipsContainerPanel.SendMiddleTopTips(firstStr, firstIconName, secondStr, secondIconName, true)
            end
        end
    end
end

---穿戴装备
function UIAllTextTipsContainerPanel.OnResEquipChangeMessage(msgId, tblData, csData)
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
            local inedx = infos[i].equipIndex;
            if (UIAllTextTipsContainerPanel.mEquipIndexChange ~= nil and UIAllTextTipsContainerPanel.mEquipIndexChange[inedx] ~= nil) then
                UIAllTextTipsContainerPanel.mEquipIndexChange[inedx] = 0
            end
            break
        end
        --获取最好的装备

        if UIAllTextTipsContainerPanel.IsShowEquipTipsByReason(tblData.reason) then
            local isFind, changeItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.itemId)
            if isFind then
                if (CS.CSScene.MainPlayerInfo.Level <= 70) then
                    UIAllTextTipsContainerPanel.SendMiddleTopTips("[00ff00]装备[-]", info.itemId, changeItem.name)
                end
            end
        end
    end
end

---背包变化
function UIAllTextTipsContainerPanel.OnResBagChangeMessage(msgId, csData)
    if csData ~= nil and csData.action ~= nil and (csData.itemList ~= nil or csData.coinList ~= nil) then
        local list = nil
        local bagChangeType = LuaEnumBagChangeType.NONE
        if csData.itemList ~= nil and csData.itemList.Count > 0 then
            bagChangeType = LuaEnumBagChangeType.ItemChange
            list = csData.itemList
            UIAllTextTipsContainerPanel:ShowBagItemChangeTips(list, bagChangeType, csData)
        end
        if csData.coinList ~= nil and csData.coinList.Count > 0 then
            bagChangeType = LuaEnumBagChangeType.CoinChange
            list = csData.coinList
            UIAllTextTipsContainerPanel:ShowBagItemChangeTips(list, bagChangeType, csData)
        end
    end
end

---显示背包道具变化提示
function UIAllTextTipsContainerPanel:ShowBagItemChangeTips(list, bagChangeType, csData)
    local globalTable = CS.Cfg_GlobalTableManager.Instance
    if list ~= nil and bagChangeType ~= LuaEnumBagChangeType.NONE then
        local length = list.Count - 1
        if length >= 0 then
            for k = 0, length do
                local bagItemInfo = list[k]
                local iconName = nil
                local itemTable = nil
                local tipsString = ""
                local count = 0
                if bagItemInfo ~= nil then
                    itemTable = bagItemInfo.ItemTABLE
                    if itemTable == nil then
                        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
                        if itemInfoIsFind then
                            itemTable = itemInfo
                        end
                    end
                end
                if itemTable ~= nil then
                    local globalCondition = globalTable:ShowItemTipsByActionAndItemId(csData.action, itemTable.id) == true
                    local addCondtion = UIAllTextTipsContainerPanel:IsItemNeedShowMiddleTopTips(csData)
                    if globalCondition or addCondtion then
                        if bagChangeType == LuaEnumBagChangeType.ItemChange then
                            local nowBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfoByLid(bagItemInfo.lid)
                            count = bagItemInfo.count
                            if nowBagItemInfo ~= nil then
                                count = bagItemInfo.count - nowBagItemInfo.count
                            end
                        elseif bagChangeType == LuaEnumBagChangeType.CoinChange then
                            local nowCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(bagItemInfo.itemId)
                            count = bagItemInfo.count - nowCount
                        end

                        if bagItemInfo ~= nil and itemTable ~= nil then
                            iconName = itemTable.icon
                            tipsString = globalTable:GetItemTextForamt(itemTable.name, count)
                        end
                        if (count == 1) then
                            UIAllTextTipsContainerPanel.SendMiddleTopTips(tipsString, iconName, itemTable.name)
                        else
                            UIAllTextTipsContainerPanel.SendMiddleTopTips(tipsString, iconName, itemTable.name .. tostring(count))
                        end
                    end
                end
            end
        end
    end
end

---判断背包变化引起的货币/道具变动是否需要在中上位置显示tips
function UIAllTextTipsContainerPanel:IsItemNeedShowMiddleTopTips(csData)
    if csData and csData.action == LuaEnumBagChangeAction.Gather_TrainingHorse then
        return true
    end
    return false
end

--endregion

function UIAllTextTipsContainerPanel:JvLingZhuUseTips(tblData)
    if tblData ~= nil and tblData.logAction ~= nil and tblData.logAction == 2052 then
        --local itemId = CS.Cfg_GlobalTableManager.Instance:GetUseItemId()
        local useTextContent = CS.Cfg_GlobalTableManager.Instance:GeUseTextContent()
        local iconName = "1000006";
        --local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        --if itemInfoIsFind then
        --    iconName = itemInfo.icon
        --end
        if iconName ~= "" and useTextContent ~= "" then
            --local tipsString = useTextContent .. self.SpriteBlank .. "经验" .. tostring(tblData.addExp)
            UIAllTextTipsContainerPanel.SendMiddleTopTips(useTextContent, iconName, "经验" .. tostring(tblData.addExp))
        end
    end
end

---判断元灵是否上阵
function UIAllTextTipsContainerPanel.IsShowServantExp()
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        return mainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsAnyServantAtEnableState()
    end
    return false
end

--region 客户端消息
---左下角提示
function UIAllTextTipsContainerPanel.OnLeftBottomTips(msgId, msg)
    UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.LeftBottomTips, msg)
end

---中间提示
function UIAllTextTipsContainerPanel.OnMiddleTips(msgId, msg)
    UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTips, msg)
end

---中上提示
function UIAllTextTipsContainerPanel.OnMiddleTopTips(msgId, msg)
    UIAllTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTopTips, msg)
end

---提示正在进行的指定任务的进度
function UIAllTextTipsContainerPanel.TaskProgressTips(id, taskState, params)
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
                local info = UIAllTextTipsContainerPanel:GetInfo(tipsType, v.taskTips)
                if info == nil then
                    return
                end
                local tipsString1 = tipOpenAndTips[2] .. info.name
                local iconName = nil
                if tipOpenAndTips[1] == "1" then
                    iconName = info.icon
                    tipsString1 = tipOpenAndTips[2] .. UIAllTextTipsContainerPanel.SpriteBlank .. info.name
                end
                UIAllTextTipsContainerPanel.SendMiddleTopTips(tipOpenAndTips[2], iconName, info.name)
            end
        end
    end
end

---向上自适应（根据呼吸框显示）
function UIAllTextTipsContainerPanel.OnUpAdaptiveClicked(msgId, data)
    if data == nil or UIAllTextTipsContainerPanel.mCenterBottomTips_GameObject == nil then
        return
    end
    local pos = UIAllTextTipsContainerPanel.mCenterBottomTips_GameObject.transform.parent:InverseTransformPoint(data.pos)
    UIAllTextTipsContainerPanel.mCenterBottomTips_GameObject.transform.localPosition = CS.UnityEngine.Vector3(pos.x, pos.y + 250, 0)
end

---客户端消息发送中上提示
function UIAllTextTipsContainerPanel.OnSendMiddleTopClientMessageReceived(id, data)
    local str = nil
    local iconName = nil
    local secondLabel = ""
    if data.Str then
        str = data.Str
    end
    if data.IconName then
        iconName = data.IconName
    end
    if data.secondLabel then
        secondLabel = data.secondLabel
    end
    UIAllTextTipsContainerPanel.SendMiddleTopTips(str, iconName, secondLabel)
end

---狼烟梦境时间变化提示
function UIAllTextTipsContainerPanel.OnRefreshDreamlandRemainTime(id, data)
    if data == nil or data.oldTime == nil or data.newTime == nil then
        return
    end
    ---判断限制
    if uiStaticParameter.GetDreamlandTimeShowTipsCondition() == nil then
        return
    end

    if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(uiStaticParameter.GetDreamlandTimeShowTipsCondition()) then
        return
    end
    ---是否是添加了时间
    local short = data.newTime - data.oldTime
    if short <= 0 then
        return
    end
    local vo = CS.ShortTimeVO(short)

    if vo ~= nil and vo.Minute <= 0 then
        return
    end
    local str = '[fffab3]获得了[A4CEF6]梦境时间  %s%s[-] '
    local hour = vo.Hour ~= 0 and vo.Hour .. "小时" or ""
    local minute = vo.Minute .. '分'
    str = string.format(str, hour, minute)
    UIAllTextTipsContainerPanel.SendMiddleTopTips(str)
end

--endregion

--region 获取
function UIAllTextTipsContainerPanel:GetInfo(tipsType, itemid)
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
function UIAllTextTipsContainerPanel.SendTips(tipsType, tips, iconName, secondLabel, secondSpriteName)
    if tipsType == LuaEnumTextTipsType.MiddleTips then
        CS.Utility.TipMager:ShowTips(tips);
    elseif tipsType == LuaEnumTextTipsType.MiddleTopTips then
        UIAllTextTipsContainerPanel.mMiddleTopTips:AddTips({ tipsType = LuaEnumTextTipsType.MiddleTopTips, firstStr = tips, secondStr = secondLabel, secondSpriteName = secondSpriteName, itemId = tonumber(iconName) })
    elseif tipsType == LuaEnumTextTipsType.LeftBottomTips then
        UIAllTextTipsContainerPanel.mLeftBottomTips:AddTips({ tipsType = LuaEnumTextTipsType.LeftBottomTips, firstStr = tips, itemId = tonumber(iconName) })
    elseif tipsType == LuaEnumTextTipsType.DelayMiddleTips then
        CS.Utility.TipMager:ShowTips(tips);
    end
end

--region 显示tips(例如：装备了+icon+装备名)
---通过背包物品列表信息表显示tips
function UIAllTextTipsContainerPanel:ShowTipsByBagItemInfoTable(bagItemInfoTable, iconForwardText)
    if bagItemInfoTable ~= nil and type(bagItemInfoTable) == 'table' then
        for k, v in pairs(bagItemInfoTable) do
            self:ShowTipsByBagItemInfo(v, iconForwardText)
        end
    end
end

---通过背包物品信息显示tips
function UIAllTextTipsContainerPanel:ShowTipsByBagItemInfo(bagItemInfo, iconForwardText)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
    if itemInfoIsFind then
        self:ShowTipsByItemInfo(itemInfo, iconForwardText)
    end
end

---通过物品信息显示tips
function UIAllTextTipsContainerPanel:ShowTipsByItemInfo(itemInfo, iconForwardText)
    if itemInfo ~= nil and not CS.StaticUtility.IsNullOrEmpty(iconForwardText) then
        local str = iconForwardText .. self.SpriteBlank .. itemInfo.name
        local iconName = itemInfo.icon
        self.SendMiddleTopTips(iconForwardText, iconName, itemInfo.name)
    end
end

function UIAllTextTipsContainerPanel.SendMiddleTopTips(tips, iconName, secondLabel, secondSpriteName, needPlayTween)
    UIAllTextTipsContainerPanel.mMiddleTopTips:AddTips({ tipsType = LuaEnumTextTipsType.MiddleTopTips, firstStr = tips, secondStr = secondLabel, secondIconName = secondSpriteName, itemId = tonumber(iconName), canPlayTween = needPlayTween })
end
--endregion
--endregion

---根据变化原因判断是否显示装备tips
function UIAllTextTipsContainerPanel.IsShowEquipTipsByReason(reason)
    return reason ~= nil and reason ~= LuaEnumEquipChangeReason.REFINER and
            reason ~= LuaEnumEquipChangeReason.UP_STAR
end

return UIAllTextTipsContainerPanel