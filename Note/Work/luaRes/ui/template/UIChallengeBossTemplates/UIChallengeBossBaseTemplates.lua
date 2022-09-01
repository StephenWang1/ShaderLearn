---@class UIChallengeBossBaseTemplates:TemplateBase boss模板基类
local UIChallengeBossBaseTemplates = {}

--region 组件
---@return UIScrollView
function UIChallengeBossBaseTemplates:GetBossKillUIScrollView()
    if self.mBossKillUIScrollView == nil then
        self.mBossKillUIScrollView = self:Get("BossSkill", "UIScrollView")
    end
    return self.mBossKillUIScrollView
end

---@return UIGridContainer
function UIChallengeBossBaseTemplates:GetBossKillUIGridContainer()
    if self.mBossKillUIGridContainer == nil then
        self.mBossKillUIGridContainer = self:Get("BossSkill/List", "UIGridContainer")
    end
    return self.mBossKillUIGridContainer
end

---@return UIGridContainer
function UIChallengeBossBaseTemplates:GetSelectMapGrid_UIGridContainer()
    if self.mSelectMapGrid_UIGridContainer == nil then
        self.mSelectMapGrid_UIGridContainer = self:Get("selectMapScroll/selectMap", "UIGridContainer")
    end
    return self.mSelectMapGrid_UIGridContainer
end

---@return UIScrollView
function UIChallengeBossBaseTemplates:GetSelectMap_UIScrollView()
    if self.mSelectMap_UIScrollView == nil then
        self.mSelectMap_UIScrollView = self:Get("selectMapScroll", "UIScrollView")
    end
    return self.mSelectMap_UIScrollView
end

---@return UIPanel
function UIChallengeBossBaseTemplates:GetSelectMap_UIPanel()
    if self.mSelectMap_UIPanel == nil then
        self.mSelectMap_UIPanel = self:Get("selectMapScroll", "UIPanel")
    end
    return self.mSelectMap_UIPanel
end

function UIChallengeBossBaseTemplates:GetSpringPanel()
    if self.mSpringPanel == nil then
        self.mSpringPanel = self:Get("selectMapScroll", "SpringPanel")
    end
    return self.mSpringPanel
end

---获取等级文本
---@return Top_UILabel
function UIChallengeBossBaseTemplates:GetLevel_UILabel()
    if self.mLevel_UILabel == nil then
        self.mLevel_UILabel = self:Get("lb_lv", "UILabel")
    end
    return self.mLevel_UILabel
end
--endregion

function UIChallengeBossBaseTemplates:InitComponents()
    ---模型跟节点
    self.ModelRoot = self:Get("modelScroll/Model", "GameObject")
    ---怪物名称
    self.name = self:Get("name", "UILabel")
    ---描述信息
    self.Deslb = self:Get("lb", "UILabel")
    ---选中高亮框
    self.choose = self:Get("choose", "GameObject")
    ---推荐标签
    self.recommend = self:Get("recommend", "GameObject")

    ---推荐标签
    --  self.OptimizeClipShaderScript = self:Get("modelScroll", "Top_OptimizeClipShaderScript")

    ---@type UnityEngine.GameObject  前往击杀按钮
    self.GoBtn_GameObject = self:Get("btn_go","GameObject")
    ---@type UnityEngine.GameObject 扫荡模块
    self.DoubleBtn_GameObject = self:Get("doubleBtn","GameObject")
end
function UIChallengeBossBaseTemplates:InitOther()
    self.Deslb.gameObject:SetActive(false)
    self.ObservationModel = nil
end

function UIChallengeBossBaseTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBossBaseTemplates:RefreshUI(data, ClipShader)
    self.OptimizeClipShaderScript = ClipShader
    self:InitData(data)
    self:ShowModel(self.bossTable, self.monsterTable, self.ModelRoot)
    self:ShowModelInfo(self.monsterTable)
    self:RefreshBossLevel()
end

--region  数据初始化
---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBossBaseTemplates:InitData(data)
    if data == nil then
        return
    end
    ---@type table<number,bossV2.FieldBossInfo> boss信息服务器原生数据
    self.fieldBossInfoList = data
    ---@type bossV2.FieldBossInfo boss信息服务器单个数据
    self.fieldBossInfo = nil
    ---@type TABLE.cfg_boss boss表
    self.bossTable = nil
    ---@type TABLE.cfg_monsters 怪物表
    self.monsterTable = nil
    ---@type table<number,bossTemp.MapBtnInfo> boss表列表
    self.mapBtnInfoList = {}
    ---@type table<TABLE.cfg_boss_skill_describe> boss技能信息表列表
    self.skillDesInfoTableList = {}
    for i, v in pairs(data) do

        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(v.bossId)
        if self.fieldBossInfo == nil then
            self.fieldBossInfo = v
            self.bossTable = bossInfo
            if bossInfo ~= nil then
                local id = tonumber(bossInfo:GetConfId())
                self.monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(id)
            end
        end
        ---@class bossTemp.MapBtnInfo
        local mapBtnInfo = {
            ---@type TABLE.cfg_boss
            Info = bossInfo,
            ---@type number
            number = v.count
        }
        table.insert(self.mapBtnInfoList, mapBtnInfo)
    end
    if self.monsterTable ~= nil and self.monsterTable:GetBossSkill() ~= nil and type(self.monsterTable:GetBossSkill().list) == 'table' then
        self.skillDesInfoTableList = clientTableManager.cfg_boss_skill_describeManager:GetSkillDesInfoList(self.monsterTable:GetBossSkill().list)
    end
    ---@type boolean boss是否可以扫荡
    self.bossCanClear = self.bossTable ~= nil and clientTableManager.cfg_bossManager:BossCanClear(self.bossTable:GetId())
end
--endregion

--region 展示Boss

---显示boss模型信息
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBossBaseTemplates:ShowModelInfo(monsterTable)
    if monsterTable == nil then
        return
    end
    local levelDes = monsterTable:GetLevel() .. "级 "
    local nameColor = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTable:GetType()))
    self.name.text = nameColor .. monsterTable:GetName()
end

---显示模型
---@param bossTable TABLE.cfg_boss
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBossBaseTemplates:ShowModel(bossTable, monsterTable, RootGO)
    if bossTable == nil or monsterTable == nil then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    --self.ObservationModel:ClearModel()
    self.ObservationModel.DefalutShaderType = 1
    self.ObservationModel:SetShowMotion(CS.CSMotion.Stand)
    self.ObservationModel:SetBindRenderQueue()
    self.ObservationModel:SetDragRoot(RootGO)
    local Scale = monsterTable:GetScale() * bossTable:GetModelScale() / 10000
    ---设置旋转
    self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(27, 132, -27))
    self.ObservationModel:ResetCurScale()
    ---设置缩放
    self.ObservationModel:SetScaleSizeforRatio(Scale)
    ---设置位置
    self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(bossTable:GetOffsetX(), bossTable:GetOffsetY(), 1500))
    ---创建模型
    self.ObservationModel:CreateModel(monsterTable:GetModel(), CS.EAvatarType.Monster, RootGO.transform, function()
        if self.OptimizeClipShaderScript ~= nil and self.ObservationModel ~= nil then
            self.OptimizeClipShaderScript:AddRenderList(self.ObservationModel.ModelRoot, true, false, true, false);
        end
    end)

end

--endregion

--region 刷新boss等级
function UIChallengeBossBaseTemplates:RefreshBossLevel()
    if self.monsterTable ~= nil then
        if type(self.monsterTable:GetReinLv()) == 'number' and self.monsterTable:GetReinLv() > 0 then
            luaclass.UIRefresh:RefreshLabel(self:GetLevel_UILabel(),tostring(self.monsterTable:GetReinLv()) .. "转")
        elseif type(self.monsterTable:GetLevel()) == 'number' and self.monsterTable:GetLevel() > 0 then
            luaclass.UIRefresh:RefreshLabel(self:GetLevel_UILabel(),tostring(self.monsterTable:GetLevel()) .. "级")
        end
    end
end
--endregion

--region boss技能
---显示boss技能
function UIChallengeBossBaseTemplates:ShowBossSkill()
    luaclass.UIRefresh:RefreshActive(self:GetBossKillUIScrollView(), true)
    luaclass.UIRefresh:RefreshGridContainer(self:GetBossKillUIGridContainer(), self.skillDesInfoTableList, function(grid, info)
        ---@type TABLE.cfg_boss_skill_describe
        local skillDesInfo = info
        ---@type UIBossSkillGridTemplate
        local template = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIBossSkillGridTemplate)
        if template ~= nil then
            ---@type BossSkillGridCommonData
            local bossSkillGridCommonData = {}
            bossSkillGridCommonData.bossSkillDesTable = skillDesInfo
            template:RefreshPanel(bossSkillGridCommonData)
        end
    end)
    CS.CSListUpdateMgr.Add(100, nil, function()
        luaclass.UIRefresh:UIScrollviewReposition(self:GetBossKillUIScrollView())
    end, false)
end
--endregion

--region 点击操作
function UIChallengeBossBaseTemplates:AllServantChangeState()
    for i = 1, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count do
        local info = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i - 1]
        if (info.servantId ~= 0 and info.state ~= LuaEnumServantStateType.Battle) then
            networkRequest.ReqServantChangeState(LuaEnumServantStateType.Battle, i)
        end
    end
end

---点击操作
function UIChallengeBossBaseTemplates:ClickOperation(bossTable, go)
    if bossTable == nil then
        return
    end
    local isMeetCondition = self:IsMeetCondition(bossTable)
    local EventParameDic = self:AnalysisEventParameters(bossTable)
    if EventParameDic == nil then
        return
    end
    local number = 1
    if isMeetCondition == false then
        number = 2
    end
    self:ConditionOperation(EventParameDic[number], go, bossTable)
    self:AllServantChangeState()
end

---解析条件类型参数
---@param bossTable TABLE.cfg_boss
---@return table<number,BossOperationParame>
function UIChallengeBossBaseTemplates:AnalysisEventParameters(bossTable)
    if bossTable == nil then
        return nil
    end
    local eventParameters = bossTable:GetEventParameters()
    if eventParameters == nil or eventParameters == "" then
        return nil
    end
    local temp1 = _fSplit(eventParameters, "&")
    local EventParameDic = {}
    local temp2 = _fSplit(tostring(temp1[1]), "#")
    ---@class BossOperationParame
    local Meet = {
        OperationType = tonumber(temp2[1]),
        OperationParame = tostring(temp2[2]),
    }
    EventParameDic[1] = Meet
    if #temp1 == 1 then
        return EventParameDic
    end

    local temp3 = _fSplit(tostring(temp1[2]), "#")
    local NotMeet = {
        OperationType = tonumber(temp3[1]),
        OperationParame = tostring(temp3[2]),
    }
    EventParameDic[2] = NotMeet
    return EventParameDic
end

---是否满足条件
function UIChallengeBossBaseTemplates:IsMeetCondition(bossTable)
    if bossTable == nil then
        return false
    end
    local isMeet = true
    if bossTable:GetLevel() ~= nil then
        for i = 0, bossTable:GetLevel().list.Count - 1 do
            local conditionID = bossTable:GetLevel().list[i]
            local luaConditionResult = Utility.IsMainPlayerMatchCondition(conditionID)
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false or (luaConditionResult ~= nil and luaConditionResult.success == false) then
                isMeet = false
                break
            end
        end
    end
    return isMeet
end

---条件操作
---@param BossOperationParame BossOperationParame
function UIChallengeBossBaseTemplates:ConditionOperation(BossOperationParame, go, bossTable)
    if BossOperationParame == nil then
        return
    end
    if BossOperationParame.OperationType == LuaEnumBossOperationType.FindTarget then
        self:FindTarget(BossOperationParame.OperationParame, bossTable, false)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.Bubble then
        self:Bubble(BossOperationParame.OperationParame, go)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.JumpPanel then
        self:JumpPanel(BossOperationParame.OperationParame, go)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.Deliver then
        self:Deliver(bossTable)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.FindTargetTeleporter then
        self:FindTarget(BossOperationParame.OperationParame, bossTable, true)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.GoToDeliverDirectly then
        self:GoForDeliverTarget(bossTable)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.EnterDuplicate then
        self:EnterDuplicate(BossOperationParame.OperationParame)
    end
end

---寻找目标
function UIChallengeBossBaseTemplates:FindTarget(OperationParame, bossTable, isFindTeleporter)
    local res = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(bossTable:GetMapId(), bossTable:GetDeliverId(), isFindTeleporter, OperationParame))
    if res < 0 then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(bossTable:GetMapId(), bossTable:GetDeliverId(), isFindTeleporter, OperationParame))
            uimanager:ClosePanel("UIBossPanel")
        end)
        return
    end
    uimanager:ClosePanel("UIBossPanel")
end
---弹出气泡
function UIChallengeBossBaseTemplates:Bubble(OperationParame, go)
    Utility.ShowPopoTips(go.transform, nil, tonumber(OperationParame))
end
---跳转面板
function UIChallengeBossBaseTemplates:JumpPanel(OperationParame)
    uiTransferManager:TransferToPanel(tonumber(OperationParame))
    -- uimanager:ClosePanel("UIBossPanel")
end

---Deliver传送
function UIChallengeBossBaseTemplates:Deliver(bossTable)
    if bossTable == nil then
        return
    end
    --Utility.TryTransfer(tonumber(bossTable:GetDeliverId()))
    networkRequest.ReqDeliverByConfig(tonumber(bossTable:GetDeliverId()))
    uimanager:ClosePanel("UIBossPanel")
end

---前往deliveID对应的地图
---@param bossTable TABLE.cfg_boss
function UIChallengeBossBaseTemplates:GoForDeliverTarget(bossTable)
    if bossTable == nil then
        return
    end
    ---@type TABLE.CFG_DELIVER
    local deliverTbl
    ___, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(bossTable:GetDeliverId())
    if deliverTbl ~= nil then
        local res = CS.CSPathFinderManager.Instance:SetFixedDestination(
                deliverTbl.toMapId,
                { x = deliverTbl.x, y = deliverTbl.y },
                CS.EAutoPathFindSourceSystemType.Boss,
                CS.EAutoPathFindType.Boss_FightWithEliteBoss,
                2,
                deliverTbl.id
        )
        if res then
            uimanager:ClosePanel("UIBossPanel")
        end
    end
end

---寻找目标
function UIChallengeBossBaseTemplates:FindTargetTeleporter(bossTable)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(bossTable:GetMapId(), bossTable:GetDeliverId(), true)
    uimanager:ClosePanel("UIBossPanel")
end

---进入副本
function UIChallengeBossBaseTemplates:EnterDuplicate(OperationParame)
    if OperationParame == nil then
        return
    end
    networkRequest.ReqEnterDuplicate(tonumber(OperationParame))
    uimanager:ClosePanel("UIBossPanel")
end

--endregion

--region 刷新前往地图列表
---刷新地图信息
function UIChallengeBossBaseTemplates:RefreshMapGrid()
    --if  self:GetSpringPanel()~=nil then
    --    self:GetSpringPanel().target = CS.UnityEngine.Vector3(0,-130,0)
    --    self:GetSpringPanel().enabled = true
    --
    --end
    if CS.StaticUtility.IsNull(self:GetSelectMapGrid_UIGridContainer()) then
        return
    end
    if self.mapBtnInfoList == nil then
        return
    end
    self:SortMapGrid()
    self:GetSelectMapGrid_UIGridContainer().MaxCount = #self.mapBtnInfoList
    local index = 0
    for i, v in pairs(self.mapBtnInfoList) do
        local item = self:GetSelectMapGrid_UIGridContainer().controlList[index].gameObject
        local lab_name = CS.Utility_Lua.GetComponent(item.transform:Find("lab_name"), "UILabel")
        local lab_num = CS.Utility_Lua.GetComponent(item.transform:Find("lab_num"), "UILabel")
        local backGround = CS.Utility_Lua.GetComponent(item.transform:Find("backGround"), "UISprite")
        local mapNameList = _fSplit(v.Info:GetMapName(), "#")
        local name = ""
        local numberColor = ""
        local spriteName = ""
        local bossNum = v.number
        local mainPlayerCanMeet = self:IsMeetCondition(v.Info)
        if bossNum > 0 and mainPlayerCanMeet == true then
            ---有存活且可进入
            numberColor = "[00ff00]"
            spriteName = "bo1"
            name = tostring(mapNameList[1])
        elseif bossNum > 0 and mainPlayerCanMeet == false then
            ---有存货且不可进
            numberColor = "[00ff00]"
            spriteName = "bo1"
            name = tostring(mapNameList[3])
        elseif bossNum <= 0 then
            ---没有存活
            numberColor = "[878787]"
            spriteName = "bo2"
            name = tostring(mapNameList[2])
        end
        lab_name.text = name
        lab_num.text = numberColor .. v.number .. "只"
        backGround.spriteName = spriteName
        index = index + 1
        CS.UIEventListener.Get(item).LuaEventTable = self
        CS.UIEventListener.Get(item).OnClickLuaDelegate = function()
            self:ClickOperation(v.Info, item)
        end
    end

    self:SetMapGridPosition()
end

---地图信息排序
function UIChallengeBossBaseTemplates:SortMapGrid()
    if self.mapBtnInfoList == nil then
        return
    end
    table.sort(self.mapBtnInfoList, function(left, right)
        ---是否无数量
        local leftNumber = tonumber(left.number)
        local rightNumber = tonumber(right.number)
        if leftNumber ~= rightNumber and (leftNumber == 0 or rightNumber == 0) then
            return tonumber(left.number) > right.number
        end

        ---是否符合条件
        local leftIsMeetCondition = self:IsMeetCondition(left.Info)
        local rightIsMeetCondition = self:IsMeetCondition(right.Info)
        if leftIsMeetCondition ~= rightIsMeetCondition then
            return leftIsMeetCondition
        end

        ---根据order排序
        local aOrder = 0
        local bOrder = 0
        if left.Info ~= nil and right.Info ~= nil then
            aOrder = left.Info:GetOrder()
            aOrder = aOrder == nil and 0 or aOrder
            bOrder = right.Info:GetOrder()
            bOrder = bOrder == nil and 0 or bOrder
        end
        return aOrder < bOrder
        --return true
    end)
end

---是否是行会秘境副本
---@param bossInfo TABLE.cfg_boss
---@return boolean
function UIChallengeBossBaseTemplates:IsHangHuiMiJingDuplicate(bossInfo)
    if bossInfo and bossInfo:GetMapId() then
        ---@type TABLE.CFG_DUPLICATE
        local duplicateTblExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(bossInfo:GetMapId())
        if duplicateTbl and (duplicateTbl.type == 45 or duplicateTbl.type == 54) then
            return true
        end
    end
    return false
end

---处理行会秘境副本
---@param bossInfo TABLE.cfg_boss
---@param bossNum number
---@param isMeetCondition boolean
---@param mapNameList table<number, string>
---@return string, string, string numberColor, spriteName, name
function UIChallengeBossBaseTemplates:DealWithHangHuiMiJingDuplicate(bossInfo, bossNum, isMeetCondition, mapNameList)
    local numberColor, spriteName, name
    local unionBossRankNo = gameMgr:GetPlayerDataMgr():GetUnionInfo():GetUnionBossRankNo()
    ---@type TABLE.CFG_DUPLICATE
    local duplicateTblExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(bossInfo:GetMapId())
    if bossNum > 0 then
        numberColor = "[00ff00]"
        spriteName = "bo1"
    else
        numberColor = "[878787]"
        spriteName = "bo2"
    end
    local defaultName
    if bossNum > 0 and isMeetCondition == true then
        ---有存活且可进入
        defaultName = tostring(mapNameList[1])
    elseif bossNum > 0 and isMeetCondition == false then
        ---有存货且不可进
        defaultName = tostring(mapNameList[3])
    elseif bossNum <= 0 then
        ---没有存活
        defaultName = tostring(mapNameList[2])
    end
    --unionBossRankNo = 1
    local mijingDuplicateID = math.floor(bossInfo:GetMapId() / 100)
    if unionBossRankNo == -1 then
        ---没打过,使用之前的
        name = defaultName
    else
        if (unionBossRankNo == 0 or unionBossRankNo == nil
                or (unionBossRankNo == 1 and mijingDuplicateID ~= 230)
                or (unionBossRankNo == 2 and mijingDuplicateID ~= 231)
                or (unionBossRankNo == 3 and mijingDuplicateID ~= 232))
                == false then
            ---有权限进入
            name = defaultName
        else
            ---无权限进入
            if mijingDuplicateID == 230 then
                ---目标地图为第一行会
                if bossNum > 0 then
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [e85038]行会")
                else
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [727272]行会")
                end
            elseif mijingDuplicateID == 231 then
                ---目标地图为第二行会
                if bossNum > 0 then
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [e85038]行会")
                else
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [727272]行会")
                end
            elseif mijingDuplicateID == 232 then
                ---目标地图为第三行会
                if bossNum > 0 then
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [e85038]行会")
                else
                    name = Utility.CombineStringQuickly("[FFFFFF]", duplicateTbl.name, " [727272]行会")
                end
            else
                name = defaultName
            end
        end
    end
    return numberColor, spriteName, name
end

---设置地图格子位置
function UIChallengeBossBaseTemplates:SetMapGridPosition()
    if CS.StaticUtility.IsNull(self:GetSelectMap_UIScrollView()) or CS.StaticUtility.IsNull(self:GetSelectMap_UIPanel()) then
        return
    end

    if #self.mapBtnInfoList >= 3 then
        self:GetSelectMap_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(0, -152+14, 0)
        self:GetSpringPanel().target = CS.UnityEngine.Vector3(0, -152+14, 0)

    else
        self:GetSelectMap_UIScrollView().transform.localPosition = CS.UnityEngine.Vector3(0, -152+14 - (3 - #self.mapBtnInfoList) * 53, 0)
        self:GetSpringPanel().target = CS.UnityEngine.Vector3(0, -152+14 - (3 - #self.mapBtnInfoList) * 53, 0)
    end
    self:GetSelectMap_UIPanel().clipOffset = CS.UnityEngine.Vector2(0, 0);

    self:GetSelectMap_UIScrollView():SetSoftnessValue(true, 3)
end
--endregion

--region 扫荡刷新
---刷新扫荡按钮
function UIChallengeBossBaseTemplates:RefreshClearBtn()
    local configShowClearBtn = LuaGlobalTableDeal:CanShowClearBtn()
    local showCearBtn = configShowClearBtn and self.bossCanClear
    luaclass.UIRefresh:RefreshActive(self.GoBtn_GameObject, showCearBtn == false)
    luaclass.UIRefresh:RefreshActive(self.DoubleBtn_GameObject,showCearBtn)
    if self.bossCanClear then
        local completeTemplate = templatemanager.GetNewTemplate(self.DoubleBtn_GameObject, luaComponentTemplates.CompleteTemplate)
        if completeTemplate ~= nil then
            ---@type CompleteTemplateCommonData
            local commonData = {}
            commonData.JoinBtnCallBack = function(go)
                if self.bossTable ~= nil then
                    self:ClickOperation(self.bossTable,go)
                end
            end
            commonData.ClearBtnCallBack = function()
                if self.bossTable ~= nil then
                    networkRequest.ReqUseMonsterCleanUpCoupons(LuaEnumClearType.PersonBoss, self.bossTable:GetId())
                end
            end
            if self.bossTable ~= nil then
                commonData.JointCost = LuaGlobalTableDeal.GetNeedItemAndCountByBossId_Cost(self.bossTable:GetId())
            end
            if self.bossTable ~= nil then
                commonData.ClearCost = clientTableManager.cfg_bossManager:GetBossClearCost(self.bossTable:GetId())
            end
            completeTemplate:RefreshPanel(commonData)
        end
    end
end
--endregion

---清理
function UIChallengeBossBaseTemplates:Clear()
    if self.ObservationModel ~= nil then
        self.ObservationModel:ClearModel()
    end
    self.ObservationModel = nil
end

function UIChallengeBossBaseTemplates:OnDisable()
    self:Clear()
end

function UIChallengeBossBaseTemplates:OnDestroy()
    self:Clear()
    --if self.ObservationModel ~= nil then
    --    self.ObservationModel.onExternalFinishCallBack = nil
    --end
end

return UIChallengeBossBaseTemplates