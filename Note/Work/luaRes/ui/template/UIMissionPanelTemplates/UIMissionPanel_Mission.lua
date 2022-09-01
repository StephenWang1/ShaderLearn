local UIMissionPanel_Mission = {}

UIMissionPanel_Mission.List = CS.System.Collections.Generic["List`1[CSMission]"]()

---额外部分
---@return LeftMainMissionPart
function UIMissionPanel_Mission:GetExtraPart()
    if self.mExtraPart == nil then
        self.mExtraPart = luaclass.LeftMainMissionPart:New(uimanager:GetPanel("UIMissionPanel"))
    end
    return self.mExtraPart
end

function UIMissionPanel_Mission:Init()
    ---@type UnityEngine.GameObject
    local go = self.go
    ---@type Top_UIGridContainer
    UIMissionPanel_Mission.MissionList = CS.Utility_Lua.GetComponent(go, "UIGridContainer")
    UIMissionPanel_Mission.ClipShader = CS.Utility_Lua.GetComponent(go.transform, "Top_OptimizeClipShaderScript")
    UIMissionPanel_Mission.List:Clear()
    UIMissionPanel_Mission.MissionListTable = {}
    ---@type table<number,{isExtra:boolean,data:LeftMainMissionData|CSMission,previousIndex:number,sortIndex:number}>
    UIMissionPanel_Mission.AllMissions = {}
    UIMissionPanel_Mission.MissionListGameObject = {}
    UIMissionPanel_Mission.MissionDataInfoList = nil
    self.acticityTemplate = nil
end

function UIMissionPanel_Mission.MissionPanel()
    return UIMissionPanel_Mission.mMissionPanel
end

function UIMissionPanel_Mission:Show()
    UIMissionPanel_Mission.mMissionPanel = uimanager:GetPanel("UIMissionPanel")
    self:ShowMissions()
end

function UIMissionPanel_Mission:ShowMissions()
    ---@type UnityEngine.GameObject
    local go = UIMissionPanel_Mission.MissionList.gameObject
    if not go.activeSelf then
        return
    end
    UIMissionPanel_Mission.List = CS.CSMissionManager.Instance:GetMeetMission()
    self:SetMission(UIMissionPanel_Mission.List)
end

function UIMissionPanel_Mission:SetMission(data, isNeedRefreshScorll)
    --print("function UIMissionPanel_Mission:SetMission(data, isNeedRefreshScorll)", data, isNeedRefreshScorll)
    if data == nil then
        return
    end
    ---总列表
    ---@type table<number,{isExtra:boolean,data:LeftMainMissionData|CSMission,previousIndex:number,sortIndex:number}>
    UIMissionPanel_Mission.AllMissions = {}
    ---将extra部分加入到总列表中
    local extraPart = self:GetExtraPart()
    if extraPart then
        local missions = extraPart:GetMissions()
        for i = 1, #missions do
            local sortIndex = missions[i]:GetSortIndex()
            if sortIndex > LuaEnumLeftMainMissionSortIndex.None then
                table.insert(UIMissionPanel_Mission.AllMissions, {
                    isExtra = true,
                    data = missions[i],
                    previousIndex = i,
                    sortIndex = sortIndex
                })
            end
        end
    end
    ---原数据
    for i = 0, data.Count - 1 do
        local tbl = {}
        ---@type CSMission
        local csmission = data[i]
        tbl.previousIndex = i
        tbl.isExtra = false
        tbl.data = csmission
        tbl.sortIndex = self:GetMissionSortType(csmission) --csmission.SortType
        table.insert(UIMissionPanel_Mission.AllMissions, tbl)
    end

    ---排序
    table.sort(UIMissionPanel_Mission.AllMissions, function(left, right)
        if left.sortIndex > right.sortIndex then
            return true
        end
        return false
    end)
    ---刷新
    UIMissionPanel_Mission.MissionListTable = {}
    UIMissionPanel_Mission.MissionList.MaxCount = #UIMissionPanel_Mission.AllMissions
    for i = 0, UIMissionPanel_Mission.MissionList.MaxCount - 1 do
        local go = UIMissionPanel_Mission.MissionList.controlList[i]
        local dataTemp = UIMissionPanel_Mission.AllMissions[i + 1]
        local template = self:GetMissionTemplate(go)
        if dataTemp.isExtra then
            ---@type LeftMainMissionData
            local leftMissionData = dataTemp.data
            template:ResetUI()
            template.missionClipArea = UIMissionPanel_Mission.ClipShader
            leftMissionData:OnRefreshUI(template)
        else
            template:ResetUI()
            template:RefreshUI(dataTemp.data, UIMissionPanel_Mission, UIMissionPanel_Mission.ClipShader)
            UIMissionPanel_Mission.MissionListTable[dataTemp.previousIndex + 1] = template
        end
    end
    ---排版
    UIMissionPanel_Mission.SetPosition(isNeedRefreshScorll)
    self:RefreShMonsterTaskTip()
    if self.mMissionPanel ~= nil then
        self.mMissionPanel.SetDoTaskTipPosition()
    end
end

function UIMissionPanel_Mission:GetMissionSortType(csmission)
    if csmission == nil then
        return 0
    end
    --Utility.EnumToInt(CS.ETaskV2_TaskState.HAS_ACCEPT)
    local completeIndex = 0
    if csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Monster) then
        if CS.CSMissionManager.Instance.IsMonsterTaskAccomplish then
            completeIndex = 3000
        end
    else
        if csmission.State == CS.ETaskV2_TaskState.HAS_COMPLETE then
            completeIndex = 3000
        end
    end
    if csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Common) then
        return LuaEnumLeftMainMissionSortIndex.MainTask + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Monster) then
        return LuaEnumLeftMainMissionSortIndex.MonsterTask + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Elite) then
        return LuaEnumLeftMainMissionSortIndex.EliteTask + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Boss) then
        return LuaEnumLeftMainMissionSortIndex.BossTask + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Acitvity) then
        return LuaEnumLeftMainMissionSortIndex.DailyTask + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.Reward) then
        return LuaEnumLeftMainMissionSortIndex.Reward + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.YanHua) then
        return LuaEnumLeftMainMissionSortIndex.YanHua + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.ShengYu) then
        return LuaEnumLeftMainMissionSortIndex.ShengYu + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.CrawlTower) then
        return LuaEnumLeftMainMissionSortIndex.CrawlTower + completeIndex
    elseif csmission.showType == Utility.EnumToInt(CS.ShowTaskType.PersonDartCar_Normal) then
        return completeIndex
    end
    return 0
end

---@param go UnityEngine.GameObject
---@param donotcreatenew boolean|nil
---@return UIMissionInfoTemplates
function UIMissionPanel_Mission:GetMissionTemplate(go, donotcreatenew)
    if go == nil or CS.StaticUtility.IsNull(go) then
        return nil
    end
    if UIMissionPanel_Mission.MissionListGameObject[go] == nil then
        if donotcreatenew then
            return nil
        end
        UIMissionPanel_Mission.MissionListGameObject[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMissionInfoTemplates)
    end
    return UIMissionPanel_Mission.MissionListGameObject[go]
end

---刷新怪物任务提示气泡
function UIMissionPanel_Mission:RefreShMonsterTaskTip()
    local MissionPanel = self.mMissionPanel
    if MissionPanel ~= nil and MissionPanel.doMonsterTaskTip ~= nil and MissionPanel.doMonsterTaskTip.gameObject ~= nil then
        local isshow = MissionPanel.doMonsterTaskTip.gameObject.activeInHierarchy
        MissionPanel.DoMonsteraskTipChange(0, isshow)
    end
end

---设置位置
function UIMissionPanel_Mission.SetPosition(isNeedRefreshScorll)
    local position_Y = 0;
    local offset = 2;
    local count = UIMissionPanel_Mission.MissionList.controlList.Count
    local forwardHeight = 0
    for i = 0, count - 1 do
        local go = UIMissionPanel_Mission.MissionList.controlList[i]
        local template = UIMissionPanel_Mission:GetMissionTemplate(go)
        if i == 0 then
            position_Y = go.transform.localPosition.y
        else
            position_Y = position_Y - forwardHeight - offset
        end
        forwardHeight = template.bg.height
        template:SetPosition(position_Y)
    end
    if isNeedRefreshScorll and UIMissionPanel_Mission.MissionPanel() ~= nil then
        UIMissionPanel_Mission.MissionPanel().ScrollViewRefresh()
    end
end

---刷新进度
---mission csmission
function UIMissionPanel_Mission:RefreshUI(mission, showType)
    if mission == nil then
        return
    end
    UIMissionPanel_Mission.List = CS.CSMissionManager.Instance:GetMeetMission()
    local data = UIMissionPanel_Mission.List
    if showType == nil then
        showType = LuaEnumShowTaskType.Common
    end

    for i = 0, data.Count - 1 do
        if data[i].showType == showType and data[i].taskId == mission.taskId and UIMissionPanel_Mission.MissionListTable[i + 1] ~= nil then
            UIMissionPanel_Mission.MissionListTable[i + 1]:RefreshUI(mission, UIMissionPanel_Mission)
        end
    end
end

function UIMissionPanel_Mission:RefreshUIWithType(mission, showType)
    --print("RefreshUIWithType")
    if showType == nil then
        return
    end
    for i, v in pairs(UIMissionPanel_Mission.MissionListTable) do
        if v.showType == showType then
            v:RefreshUI(mission, UIMissionPanel_Mission)
            return
        end
    end
end

function UIMissionPanel_Mission:RefreshUI_OnlyShowType(showType)
    UIMissionPanel_Mission.List = CS.CSMissionManager.Instance:GetMeetMission()
    local data = UIMissionPanel_Mission.List
    for i = 0, data.Count - 1 do
        if data[i].showType == showType and UIMissionPanel_Mission.MissionListTable[i + 1] ~= nil then
            UIMissionPanel_Mission.MissionListTable[i + 1]:RefreshUI(data[i], UIMissionPanel_Mission)
        end
    end
end

---刷新其他类型进度
function UIMissionPanel_Mission:RefreshOtherTypeUI(taskShowInfo, type)
    local data = CS.CSMissionManager.Instance:GetMeetMission()
    for i = 0, data.Count - 1 do
        if #UIMissionPanel_Mission.MissionListTable > i then
            if data[i].showType == type then
                data[i].taskShowInfo = taskShowInfo
                UIMissionPanel_Mission.MissionListTable[i + 1]:RefreshUI(data[i], UIMissionPanel_Mission)
            end
        end
    end
    if #UIMissionPanel_Mission.MissionListTable >= 2 then
        UIMissionPanel_Mission.SetPosition()
    end
end

---自动任务
function UIMissionPanel_Mission:DoAutoMission()
    for k, v in pairs(UIMissionPanel_Mission.MissionListTable) do
        if v ~= nil and v.isAcitivity == nil and v.mMission ~= nil and v.showType == LuaEnumShowTaskType.Common and v.mMission.tbl_tasks ~= nil and v.mMission.tbl_tasks.type == LuaEnumTaskType.MainTask then
            v:OnMissionClick()
            return
        end
    end
    if CS.CSMissionManager.Instance.ChangeTaskID == 0 then
        if UIMissionPanel_Mission.MissionListTable[1] ~= nil and UIMissionPanel_Mission.MissionListTable[1].showType == LuaEnumShowTaskType.Common then
            UIMissionPanel_Mission.MissionListTable[1]:OnMissionClick()
        end

    else
        CS.CSMissionManager.Instance:AutoMission(CS.CSMissionManager.Instance.ChangeTaskID);
    end

    -- CS.CSMissionManager.Instance:AutoMission(CS.CSMissionManager.Instance.ChangeTaskID);
end

---设置进行中特效
function UIMissionPanel_Mission:SetTaskEffects(isopen)
    for k, task in pairs(UIMissionPanel_Mission.MissionListTable) do
        if task ~= nil and task.isAcitivity == nil then
            task:SetEffects(isopen)
        end
    end
end
---设置完成特效
function UIMissionPanel_Mission:SetTaskCompleteEffects(CompletetaskID)
    for k, task in pairs(UIMissionPanel_Mission.MissionListTable) do
        if task ~= nil and task.isAcitivity == nil then
            task:LoadEffect(CompletetaskID)
        end
    end
end

---设置日常活跃特效
function UIMissionPanel_Mission:SetDailyTaskEffects(isopen)
    for k, task in pairs(UIMissionPanel_Mission.MissionListTable) do
        if task ~= nil and task.showType == LuaEnumShowTaskType.Acitvity then
            task:SetDailyEffects(isopen)
        end
    end
end

---设置得到指定模板
function UIMissionPanel_Mission:SetTaskTemplates(showType)
    for k, task in pairs(UIMissionPanel_Mission.MissionListTable) do
        if task ~= nil and task.showType == showType then
            return task
        end
    end
end

---设置主线任务跳转提示面板
function UIMissionPanel_Mission:SetMainTaskJumpPanel(isopen)
    for k, task in pairs(UIMissionPanel_Mission.MissionListTable) do
        if task ~= nil and task.showType == LuaEnumShowTaskType.Common then
            task:OpenGuidancePanel(isopen)
        end
    end
end

---设置单条个人押镖ui
function UIMissionPanel_Mission:RefreshSinglePersonDartCarUI(personDartCarInfo)
    if personDartCarInfo == nil or UIMissionPanel_Mission.MissionListTable == nil then
        return
    end
    for k, v in pairs(UIMissionPanel_Mission.MissionListTable) do
        if v.showType == LuaEnumTaskType.PersonDartCar_Normal and v.missionInfo.dataParameter ~= nil and v.missionInfo.dataParameter.CarLid == personDartCarInfo.CarLid then
            v:RefreshUI(CS.CSMissionManager.Instance:GetMissionByPersonDartCar(personDartCarInfo), UIMissionPanel_Mission)
            return
        end
    end
end

---得到指定类型任务位置
function UIMissionPanel_Mission:GetMissionTypePosition(showType, missionType)
    for k, v in pairs(UIMissionPanel_Mission.MissionListTable) do
        if v.showType == showType then
            if missionType == nil or (v.missionInfo ~= nil and v.missionInfo.tbl_tasks ~= nil and v.missionInfo.tbl_tasks.type == missionType) then
                return v.go.transform.localPosition.y
            end
        end
    end
end

--region 任务排序
function UIMissionPanel_Mission:SortMission(left, right)
    if left == nil then
        return 1
    end
    if right == nil then
        return -1
    end
    return left.SortType:CompareTo(right.SortType);
end
--endregion
--region 任务排序（旧）
-- function UIMissionPanel_Mission:SortMission(missionList)
--     --按主线支线分
--     local missionType1, missionType2 = UIMissionPanel_Mission:SortMissionByType(missionList)
--     --筛选可买置于最后
--     local type2NotNeedbuy, type2Needbuy = UIMissionPanel_Mission:SortNeedBuy(missionType2)
--     --按完成度筛选
--     local type1Finish, type1Acceptable, type1Unfinished = UIMissionPanel_Mission:SortMissionByFinish(missionType1)
--     local type2Finish, type2Acceptable, type2Unfinished = UIMissionPanel_Mission:SortMissionByFinish(type2NotNeedbuy)
--     --按地图筛选
--     local type1FinishBelongMap, type1FinishNotBelongMap = UIMissionPanel_Mission:SortMissionByMapFinish(type1Finish)
--     local type1AcceptableBelongMap, type1AcceptableNotBelongMap = UIMissionPanel_Mission:SortMissionByMapAccept(type1Acceptable)
--     local type1UnfinishedBelongMap, type1UnfinishedNotBelongMap = UIMissionPanel_Mission:SortMissionByMapUnAccept(type1Unfinished)
--     local type2FinishBelongMap, type2FinishNotBelongMap = UIMissionPanel_Mission:SortMissionByMapFinish(type2Finish)
--     local type2AcceptableBelongMap, type2AcceptableNotBelongMap = UIMissionPanel_Mission:SortMissionByMapAccept(type2Acceptable)
--     local type2UnfinishedBelongMap, type2UnfinishedNotBelongMap = UIMissionPanel_Mission:SortMissionByMapUnAccept(type2Unfinished)
--     local FinalMissionList = UIMissionPanel_Mission:LinkTable(type1FinishBelongMap, type1FinishNotBelongMap, type1AcceptableBelongMap, type1AcceptableNotBelongMap, type1UnfinishedBelongMap, type1UnfinishedNotBelongMap, type2FinishBelongMap, type2FinishNotBelongMap, type2AcceptableBelongMap, type2AcceptableNotBelongMap, type2UnfinishedBelongMap, type2UnfinishedNotBelongMap, type2Needbuy)
--     --[[任务排序出问题时测试用
--      print("排序前" .. tostring(missionList.Count))
--      print("主线" .. tostring(#missionType1))
--      print("支线" .. tostring(#missionType2))
--      print("不可买" .. tostring(#type2NotNeedbuy))
--      print("可买" .. tostring(#type2Needbuy))
--      print("主线已完成" .. tostring(#type1Finish) .. "主线已接" .. tostring(#type1Acceptable) .. "主线未接" .. tostring(#type1Unfinished))
--      print("支线已完成" .. tostring(#type2Finish) .. "支线已接" .. tostring(#type2Acceptable) .. "支线未接" .. tostring(#type2Unfinished))
--      print("主线本地图已完成" .. tostring(#type1FinishBelongMap))
--      print("主线非本地图已完成" .. tostring(#type1FinishNotBelongMap))
--      print("主线本地图已接受" .. tostring(#type1AcceptableBelongMap))
--      print("主线非本地图已接受" .. tostring(#type1AcceptableNotBelongMap))
--      print("主线本地图未接受" .. tostring(#type1UnfinishedBelongMap))
--      print("主线非本地图未接受" .. tostring(#type1UnfinishedNotBelongMap))
--      print("支线本地图已完成" .. tostring(#type2FinishBelongMap))
--      print("支线非本地图已完成" .. tostring(#type2FinishNotBelongMap))
--      print("支线本地图已接受" .. tostring(#type2AcceptableBelongMap))
--      print("支线非本地图已接受" .. tostring(#type2AcceptableNotBelongMap))
--      print("支线本地图未接受" .. tostring(#type2UnfinishedBelongMap))
--      print("支线非本地图未接受" .. tostring(#type2UnfinishedNotBelongMap))
--      print("排序后" .. tostring(FinalMissionList.Count))
--      --]]
--     return FinalMissionList
-- end
-- ---挑出任务类型(主线/支线)
-- function UIMissionPanel_Mission:SortMissionByType(missionList)
--     local missionType1, missionType2 = {}, {}
--     for i = 0, missionList.Count - 1 do
--         local res, info = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(missionList[i].taskId)
--         if res then
--             if info.type == 1 then
--                 --      print(tostring(missionList[i]) .. "属于主线")
--                 table.insert(missionType1, missionList[i])
--             else
--                 table.insert(missionType2, missionList[i])
--                 --      print(tostring(missionList[i]) .. "不属于主线")
--             end
--         end
--     end
--     return missionType1, missionType2
-- end
-- function UIMissionPanel_Mission:SortNeedBuy(missionList)
--     local mapID = CS.CSScene:getMapID()
--     local missionMap1, missionMap2 = {}, {}
--     for i = 1, #missionList do
--         local IsNeedBuy = missionList[i].IsNeedBuy
--         if not IsNeedBuy or missionList[i].stateID == Utility.EnumToInt(CS.ETaskV2_TaskState.HAS_ACCEPT) or missionList[i].stateID == Utility.EnumToInt(CS.ETaskV2_TaskState.HAS_COMPLETE) then
--             table.insert(missionMap1, missionList[i])
--             --  print(tostring(missionList[i]) .. "不需要购买次数")
--         else
--             table.insert(missionMap2, missionList[i])
--             --   print(tostring(missionList[i]) .. "需要购买次数")
--         end
--     end
--     return missionMap1, missionMap2
-- end
-- ---挑出已接属于本地图的任务
-- function UIMissionPanel_Mission:SortMissionByMapAccept(missionList)
--     local mapID = CS.CSScene:getMapID()
--     local missionMap1, missionMap2 = {}, {}
--     for i = 1, #missionList do
--         local res, info = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(missionList[i].taskId)
--         if res then
--             if info.mapid == mapID then
--                 table.insert(missionMap1, missionList[i])
--             else
--                 table.insert(missionMap2, missionList[i])
--             end
--         end
--     end
--     return missionMap1, missionMap2
-- end
-- ---挑出未接属于本地图的任务
-- function UIMissionPanel_Mission:SortMissionByMapUnAccept(missionList)
--     local mapID = CS.CSScene:getMapID()
--     local missionMap1, missionMap2 = {}, {}
--     for i = 1, #missionList do
--         local res, info = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(missionList[i].taskId)
--         local isAdd = false
--         if res and info.fnpc then
--             local mapList = info.fnpc.list
--             for j = 0, mapList.Count - 1 do
--                 local res2, npcMapID = CS.Cfg_MapNpcTableManager.Instance.dic:TryGetValue(mapList[j])
--                 if res2 and npcMapID.mapid == mapID then
--                     table.insert(missionMap1, missionList[i])
--                     isAdd = true
--                     break
--                 end
--             end
--         end
--         if not isAdd then
--             table.insert(missionMap2, missionList[i])
--         end
--     end
--     return missionMap1, missionMap2
-- end
-- ---挑出完成属于本地图的任务
-- function UIMissionPanel_Mission:SortMissionByMapFinish(missionList)
--     local mapID = CS.CSScene:getMapID()
--     local missionMap1, missionMap2 = {}, {}
--     for i = 1, #missionList do
--         local res, info = CS.Cfg_TaskTableManager.Instance.dic:TryGetValue(missionList[i].taskId)
--         local isAdd = false
--         if res and info.tnpc then
--             local mapList = info.tnpc.list
--             if mapList then
--                 for j = 0, mapList.Count - 1 do
--                     local res2, npcMapID = CS.Cfg_MapNpcTableManager.Instance.dic:TryGetValue(mapList[j])
--                     if res2 and npcMapID.mapid == mapID then
--                         table.insert(missionMap1, missionList[i])
--                         isAdd = true
--                         break
--                     end
--                 end
--             end
--         end
--         if not isAdd then
--             table.insert(missionMap2, missionList[i])
--         end
--     end
--     return missionMap1, missionMap2
-- end
-- ---挑出已经完成的任务
-- function UIMissionPanel_Mission:SortMissionByFinish(missionList)
--     local missionFinish, missionAcceptable, missionUnfinished = {}, {}, {}
--     for i = 0, #missionList do
--         if missionList[i] ~= nil then
--             if missionList[i].stateID == Utility.EnumToInt(CS.ETaskV2_TaskState.HAS_ACCEPT) then
--                 --- 已接
--                 table.insert(missionAcceptable, missionList[i])
--             elseif missionList[i].stateID == Utility.EnumToInt(CS.ETaskV2_TaskState.HAS_COMPLETE) then
--                 ---完成
--                 table.insert(missionFinish, missionList[i])
--             else
--                 ---未接
--                 table.insert(missionUnfinished, missionList[i])
--             end
--         end
--     end
--     return missionFinish, missionAcceptable, missionUnfinished
-- end
-- ---将表合并
-- function UIMissionPanel_Mission:LinkTable(...)
--     local tables = { ... }
--     if not tables then
--         return {}
--     end
--     local list = CS.System.Collections.Generic["List`1[CSMission]"]()
--     for i = 1, #tables do
--         if tables[i] then
--             for k, v in pairs(tables[i]) do
--                 --  print(i)
--                 list:Add(v)
--             end
--         end
--     end
--     return list
-- end
--endregion
function UIMissionPanel_Mission:IsShowActivityTemplat()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20535)
    if isFind then
        --return tonumber(info.value) <= CS.CSScene.MainPlayerInfo.Level and not CS.CSScene.MainPlayerInfo.ActiveInfo:IsActiveFinished();
        return tonumber(info.value) <= CS.CSScene.MainPlayerInfo.Level;
    end
    return false
end

function UIMissionPanel_Mission:RefreshActive()
    if self.acticityTemplate ~= nil and self.acticityTemplate.isAcitivity == nil then
        self.acticityTemplate:RefreshAmount()
    end
end

function UIMissionPanel_Mission:OnDestroy()
    UIMissionPanel_Mission.MissionList = nil
    UIMissionPanel_Mission.ClipShader = nil
    UIMissionPanel_Mission.List:Clear()
    UIMissionPanel_Mission.MissionListTable = nil
    UIMissionPanel_Mission.AllMissions = nil
    UIMissionPanel_Mission.MissionListGameObject = nil
    UIMissionPanel_Mission.MissionDataInfoList = nil
    local extraPart = self.mExtraPart
    if extraPart then
        extraPart:Dispose()
        self.mExtraPart = nil
    end
end

return UIMissionPanel_Mission