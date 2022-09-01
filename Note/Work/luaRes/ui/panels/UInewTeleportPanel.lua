---@class UInewTeleportPanel:UIBase
local UInewTeleportPanel = {}

--region 局部变量

---储存根据类型放置的deliverid
UInewTeleportPanel.DeliverIDDic = {}

---当前页签类型
UInewTeleportPanel.curPageType = 1

---当前页签类型
UInewTeleportPanel.curType = 1

---@type number 要闪烁的地图标志
UInewTeleportPanel.deliverId = 0

---@type table<number,DeliverMapUnit>
UInewTeleportPanel.curDeliverInfo = {}

---@type table<UnityEngine.GameObject,UIDeliverUnitTemplate>
UInewTeleportPanel.itemTemplateDic = {}

UInewTeleportPanel.deliverTemplateDic = {}

UInewTeleportPanel.isInitOne = true

--endregion

--region 初始化

function UInewTeleportPanel:Init()
    self:InitComponents()
    UInewTeleportPanel.BindUIEvents()
    UInewTeleportPanel.BindMessage()
    UInewTeleportPanel.InitData()
end

--- 初始化组件
function UInewTeleportPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UInewTeleportPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UILoopScrollViewPlus   传送地图Loop
    UInewTeleportPanel.SafeArea = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "UILoopScrollViewPlus")
    ---@type Top_UIGridContainer   传送页签Grid
    UInewTeleportPanel.DangerousArea = self:GetCurComp("WidgetRoot/DangerousArea", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UInewTeleportPanel.btn_block = self:GetCurComp("WidgetRoot/block", "GameObject")
end

function UInewTeleportPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UInewTeleportPanel.CloseBtn).onClick = UInewTeleportPanel.OnClickCloseBtn
    CS.UIEventListener.Get(UInewTeleportPanel.btn_block).onClick = UInewTeleportPanel.OnClickCloseBtn
end

function UInewTeleportPanel.BindMessage()
    ---自动任务
    UInewTeleportPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoDoMission, UInewTeleportPanel.AutoDoMission)

    --监听等级变化及转升等级变化 判断页签刷新面板
    UInewTeleportPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UInewTeleportPanel.OnUpdateLevelCallBack);
    UInewTeleportPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UInewTeleportPanel.MainPlayerBeginWalk)
end

function UInewTeleportPanel.InitData()
    local dic = CS.Cfg_DeliverTableManager.Instance:GetDeliverIDOfType()
    UInewTeleportPanel.DeliverIDDic = dic
end

---@param customData table (由c#寻路调用打开时为 {npcid,deliverId})
---@param deliverId number 闪烁标签
---@param taskID number 当前任务ID
function UInewTeleportPanel:Show(customData, deliverId, taskID)
    if deliverId and deliverId ~= nil and deliverId ~= 0 then
        UInewTeleportPanel.deliverId = deliverId
    elseif customData ~= nil and type(customData) ~= 'number' then
        UInewTeleportPanel.deliverId = customData[2]
    end

    UInewTeleportPanel.taskID = taskID == nil and 0 or taskID

    UInewTeleportPanel.CheckOpenPage()

    UInewTeleportPanel.InitUI()
end

--endregion

--region 函数监听
--点击关闭函数
---@param go UnityEngine.GameObject
function UInewTeleportPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel(UInewTeleportPanel)
end

--endregion

--region 消息处理

function UInewTeleportPanel:AutoDoMission()
    if UInewTeleportPanel.deliverId ~= 0 then
        networkRequest.ReqDeliverByConfig(UInewTeleportPanel.deliverId)
        CS.CSMissionManager.Instance:ConfigurationTaskTransmitters(UInewTeleportPanel.taskID);
        uimanager:ClosePanel(UInewTeleportPanel)
        UInewTeleportPanel.deliverId = 0;
    end
end

function UInewTeleportPanel.OnUpdateLevelCallBack()
    if UInewTeleportPanel.IsOpenReineMap() then
        UInewTeleportPanel.InitUI()
    end
    UInewTeleportPanel.RefreshDeliverGrid()
end

function UInewTeleportPanel.OnResRoleAttributeChangeMessage()
    --if UInewTeleportPanel.curPage == 3 then
    --    UInewTeleportPanel.ShowDeliverGrid()
    --end
end

function UInewTeleportPanel.MainPlayerBeginWalk()
    uimanager:ClosePanel(UInewTeleportPanel)
end

--endregion

--region UI

function UInewTeleportPanel.InitUI()
    UInewTeleportPanel.InitBookMark()
    UInewTeleportPanel.ParseData()
    UInewTeleportPanel.RefreshDeliverGrid()
end

---初始化页签
function UInewTeleportPanel.InitBookMark()
    local typeList = UInewTeleportPanel.GetDeliverTypeList()
    UInewTeleportPanel.DangerousArea.MaxCount = #typeList
    for i = 1, #typeList do
        local value = typeList[i]
        ---@type  table 文本#等级#转生#页签类型
        local values = string.Split(value, '#')
        local go = UInewTeleportPanel.DangerousArea.controlList[i - 1]
        if go == nil then
            return
        end
        local nameLabel = CS.Utility_Lua.GetComponent(go.transform:Find('TitleName'), "Top_UILabel")
        local toggle = CS.Utility_Lua.GetComponent(go.transform, "Top_UIToggle")
        local checkMark = toggle.transform:Find('checkMark').gameObject
        local color = luaEnumColorType.White
        if #values > 3 and tonumber(values[4]) == UInewTeleportPanel.curPageType then
            --设置当前的toggle页签
            toggle.enabled = true
            checkMark:SetActive(true)
            toggle.value = true
            UInewTeleportPanel.curType = tonumber(values[4])
        else
            --if tonumber(values[4]) == LuaEnumTeleportType.ReinMap and not UInewTeleportPanel.IsOpenReineMap() then
            --    checkMark:SetActive(false)
            --    toggle.enabled = false
            --    color = luaEnumColorType.Gray
            --end
        end
        nameLabel.text = color .. values[1]

        CS.UIEventListener.Get(go).onClick = function()
            --if tonumber(values[4]) == LuaEnumTeleportType.ReinMap and not UInewTeleportPanel.IsOpenReineMap() then
            --    Utility.ShowPopoTips(go.transform, nil, 176)
            --    return
            --end
            if UInewTeleportPanel.curPageType ~= i then
                UInewTeleportPanel.curPageType = i
                UInewTeleportPanel.curType = tonumber(values[4])
                UInewTeleportPanel.ParseData()
                UInewTeleportPanel.RefreshDeliverGrid()
            end
        end
    end
end

---刷新传送点
function UInewTeleportPanel.RefreshDeliverGrid()

    if UInewTeleportPanel.isInitOne then
        UInewTeleportPanel.isInitOne = false
        UInewTeleportPanel.SafeArea:Init(UInewTeleportPanel.DeliverTempCallBack, nil)
    else
        UInewTeleportPanel.SafeArea:ResetPage()
    end
end

function UInewTeleportPanel.DeliverTempCallBack(go, line)
    if go == nil or CS.StaticUtility.IsNull(go) or line + 1 > #UInewTeleportPanel.curDeliverInfo then
        return false
    end
    ---@type DeliverMapUnit
    local deliverData = UInewTeleportPanel.curDeliverInfo[line + 1]
    ---@type UIDeliverUnitTemplate
    local deliverTemplate = UInewTeleportPanel.itemTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIDeliverUnitTemplate) or UInewTeleportPanel.itemTemplateDic[go]
    local temp = {}
    temp.deliverUnitInfo = deliverData
    temp.isShowEffect = deliverData.deliverId == UInewTeleportPanel.deliverId
    temp.clickCallBack = function(go)
        if not deliverData.isDelive and go ~= nil and not CS.StaticUtility.IsNull(go) then
            ---此处不严谨!!!仅仅对等级和转生等级的条件进行了提示
            if deliverData.isReinCheck then
                Utility.ShowPopoTips(go.transform, nil, 175)
            else
                Utility.ShowPopoTips(go.transform, nil, 168)
            end
        else
            if deliverData.deliverId == UInewTeleportPanel.deliverId and UInewTeleportPanel.taskID ~= 0 then
                CS.CSMissionManager.Instance:ConfigurationTaskTransmitters(UInewTeleportPanel.taskID);
                UInewTeleportPanel.taskID = 0;
                networkRequest.ReqDeliverByReason(deliverData.deliverId, 43)
            elseif deliverData.type == LuaEnumTeleportType.SpecialMap and deliverData.npcInfo ~= nil then
                local transferResult = Utility.TryTransfer(deliverData.deliverId, false)
                --local openNpcInfo = string.Split(deliverData.npcInfo.openPanel, '#')
                --local panelName = openNpcInfo[1]
                --table.remove(openNpcInfo, 1)
                --CS.CSDeliverAndOpenPanelController.Instance:DestineOpenPanel(deliverData.deliverId, 2, panelName, table.unpack(openNpcInfo));
            else
                local transferResult = Utility.TryTransfer(deliverData.deliverId, false)
                if transferResult ~= nil and transferResult.resultType ~= CS.Enum_TransferResult.Success then
                    local costItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(transferResult.notEnoughItemId)
                    if costItemInfo == nil then
                        return
                    end
                    --Utility.ShowPopoTips(go.transform,costItemInfo:GetName() .. "不足",10)
                    return
                end
                --networkRequest.ReqDeliverByConfig(deliverData.deliverId)
            end
            uimanager:ClosePanel(UInewTeleportPanel)
        end
    end
    deliverTemplate:SetTemplate(temp)
    if UInewTeleportPanel.itemTemplateDic[go] == nil then
        UInewTeleportPanel.itemTemplateDic[go] = deliverTemplate
    end

    if UInewTeleportPanel.deliverTemplateDic[deliverData.deliverId] == nil then
        UInewTeleportPanel.deliverTemplateDic[deliverData.deliverId] = deliverTemplate
    end
    return true
end

--endregion

--region otherFunction
--是否开启转生地图
function UInewTeleportPanel.IsOpenReineMap()
    local isFind, Info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20184)
    if isFind then
        isFind, Info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(Info.value)
        if isFind then
            return Info.conditionParam.list[0] <= CS.CSScene.MainPlayerInfo.ReinLevel
        end
    end
    return false
end

function UInewTeleportPanel.GetDeliverTypeList()
    local deliverTypeTbl = {}
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20177)
    if isFind then
        local tbl = string.Split(info.value, '&')
        for i = 1, #tbl do
            local mapTbl = string.Split(tbl[i], '#')
            if #mapTbl > 3 then
                local isMeetLevel = CS.CSScene.MainPlayerInfo.Level >= tonumber(mapTbl[2])
                local isMeetRein = CS.CSScene.MainPlayerInfo.ReinLevel >= tonumber(mapTbl[3])
                if isMeetRein and isMeetLevel then
                    table.insert(deliverTypeTbl, tbl[i])
                end
            end
        end
    end
    return deliverTypeTbl
end

---处理数据
function UInewTeleportPanel.ParseData()
    UInewTeleportPanel.curDeliverInfo = {}
    local idsIsFind, ids = UInewTeleportPanel.DeliverIDDic:TryGetValue(UInewTeleportPanel.curType)
    if not idsIsFind then
        return
    end
    if UInewTeleportPanel.curType == LuaEnumTeleportType.ClothesMap then
        --衣服专场
        local deliverList
        ___, deliverList = CS.Cfg_DeliverTableManager.Instance:GetDeliverIDOfType():TryGetValue(UInewTeleportPanel.curType)
        for i = 1, deliverList.Count do
            local deliverID = deliverList[i - 1]
            ---@type TABLE.CFG_DELIVER
            ---传送表数据
            local deliverTbl
            ___, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverID)
            ---@type number
            ---最低等级限制
            local level = 0
            local isDelive = true
            local isReinLevelCondition = false
            ---@type TABLE.CFG_CONDITIONS
            local conditionTbl
            local condition = deliverTbl.condition
            if deliverTbl.display ~= 0 then
                condition = deliverTbl.display
            end
            ___, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(condition)
            if conditionTbl ~= nil and conditionTbl.conditionParam.list.Count > 0 then
                level = conditionTbl.conditionParam.list[0]
                if conditionTbl.conditionType == 1 then
                    ---等级
                    isReinLevelCondition = false
                    isDelive = CS.CSScene.MainPlayerInfo.Level >= level
                elseif conditionTbl.conditionType == 3 then
                    ---转生等级
                    isReinLevelCondition = true
                    isDelive = CS.CSScene.MainPlayerInfo.ReinLevel >= level
                end
            end
            local npcTbl
            local mapNPCID = deliverTbl.toNpcId
            ---@type TABLE.CFG_MAP_NPC
            local mapNPCTable
            ___, mapNPCTable = CS.Cfg_MapNpcTableManager.Instance:TryGetValue(mapNPCID)
            if mapNPCTable ~= nil then
                ___, npcTbl = CS.Cfg_NpcTableManager.Instance:TryGetValue(mapNPCTable.npcid)
            end
            local isBelongToCurrentMainCity, costs = UInewTeleportPanel.AnalysisSpecialItem(deliverTbl)
            if isBelongToCurrentMainCity then
                table.insert(UInewTeleportPanel.curDeliverInfo,
                        {
                            deliverId = deliverID,
                            mapName = deliverTbl.showName,
                            level = level,
                            type = deliverTbl.buttonType,
                            isDelive = isDelive,
                            npcInfo = npcTbl,
                            isReinCheck = isReinLevelCondition,
                            deliverTable = deliverTbl
                        })
            end
        end
    else
        local itemInfoOfBoolDic = CS.Cfg_DeliverTableManager.Instance:GetMeetItemDicOfdeliverIDs(ids, UInewTeleportPanel.curType)

        if itemInfoOfBoolDic:ContainsKey(true) then
            ---@type DeliverMapUnit
            local meetDeliverInfos = itemInfoOfBoolDic[true]
            for i = 0, meetDeliverInfos.Count - 1 do
                local isBelong, costs = UInewTeleportPanel.AnalysisSpecialItem(meetDeliverInfos[i].deliverTable)
                if isBelong then
                    table.insert(UInewTeleportPanel.curDeliverInfo, meetDeliverInfos[i])
                end
            end
        end

        if itemInfoOfBoolDic:ContainsKey(false) then
            ---@type DeliverMapUnit
            local notMeetDeliverInfos = itemInfoOfBoolDic[false]
            for i = 0, notMeetDeliverInfos.Count - 1 do
                local isBelong, costs = UInewTeleportPanel.AnalysisSpecialItem(notMeetDeliverInfos[i].deliverTable)
                if isBelong then
                    table.insert(UInewTeleportPanel.curDeliverInfo, notMeetDeliverInfos[i])
                end
            end
        end
    end
    table.sort(UInewTeleportPanel.curDeliverInfo, function(left, right)
        ---可以传送的地图放在前边，不可传送的放在后边
        ---order小的放在前边，order大的放在后边
        ---id小的放在前边，id大的放在后边
        if left.isDelive == right.isDelive then
            if left.deliverTable.order > right.deliverTable.order then
                return false
            elseif left.deliverTable.order < right.deliverTable.order then
                return true
            else
                return left.deliverTable.id < right.deliverTable.id
            end
        else
            if left.isDelive then
                return true
            else
                return false
            end
        end
    end)
end

---分析特殊数据
---@param deliverTable TABLE.CFG_DELIVER
---@return boolean, table<number,number>|nil 是否归属于当前主城(不归属于当前主城的不显示),传送花费(id, count)
function UInewTeleportPanel.AnalysisSpecialItem(deliverTable)
    if deliverTable == nil then
        return true
    end
    local currentMainCity = Utility.GetCurrentMainCity()
    if currentMainCity == LuaEnumMainCity.None then
        currentMainCity = Utility.GetRecentPassedMainCity()
    end
    local isBelongToCurrentMainCity = true
    local cost = {}
    local mainCity = Utility.IsMainCity(deliverTable.region)
    if mainCity ~= LuaEnumMainCity.None then
        ---字符串为主城名
        if mainCity ~= currentMainCity then
            isBelongToCurrentMainCity = false
        end
    else
        ---字符串为花费
        local costStrs = string.Split(deliverTable.item, "#")
        if #costStrs == 2 then
            local id = tonumber(costStrs[1])
            local count = tonumber(costStrs[2])
            cost[id] = count
        end
    end
    return isBelongToCurrentMainCity, cost
end

function UInewTeleportPanel.GetPageTypeOfDeliverId(deliverID)

    for i, v in pairs(UInewTeleportPanel.DeliverIDDic) do
        local length = v.Count - 1
        for i1 = 0, length do
            if v[i1] == deliverID then
                return i
            end
        end
    end
    return 1
end

---检测开启页签
function UInewTeleportPanel.CheckOpenPage()

    if UInewTeleportPanel.deliverId ~= 0 then
        UInewTeleportPanel.curPageType = UInewTeleportPanel.GetPageTypeOfDeliverId(UInewTeleportPanel.deliverId)
        return
    end
    UInewTeleportPanel.curPageType = LuaEnumTeleportType.levelMap
    --[[    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20177)
        if isFind then
            local level = CS.CSScene.MainPlayerInfo.Level
            local reinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
            local allBooks = string.Split(info.value, '&')
            for i = 1, #allBooks do
                local allInfo = allBooks[i]
                local infos = string.Split(allInfo, '#')
                if tonumber(infos[2]) <= level and tonumber(infos[3]) <= reinLevel then
                    UInewTeleportPanel.curPageType = tonumber(infos[4])
                end
            end
            if reinLevel > 0 then
                UInewTeleportPanel.curPageType = LuaEnumTeleportType.ReinMap
            else
                UInewTeleportPanel.curPageType = LuaEnumTeleportType.levelMap
            end
        end]]
end

--endregion

--region ondestroy
function UInewTeleportPanel:OnDestroy()
    UInewTeleportPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.Role_UpdateLevel_Delay, UInewTeleportPanel.OnUpdateLevelCallBack)
    UInewTeleportPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_TaskNpcDepartureView, UInewTeleportPanel.NpcDepartureView)
    if CS.CSObjectPoolMgr.Instance ~= nil then
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(UInewTeleportPanel.flickEffectPool)
    end

    --if CS.CSResourceManager.Instance ~= nil and self ~= nil then
    --    if UInewTeleportPanel.flickEffect_Path ~= nil or UInewTeleportPanel.flickEffect_Path ~= '' then
    --        CS.CSResourceManager.Instance:ForceDestroyResource(UInewTeleportPanel.flickEffect_Path)
    --    end
    --end

end
function ondestroy()
    UInewTeleportPanel:OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerAttributeChangeMessage, UInewTeleportPanel.OnResRoleAttributeChangeMessage)
end

--endregion

return UInewTeleportPanel