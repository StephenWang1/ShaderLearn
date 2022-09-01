---白日门圣物活动界面
---@class UIBrmCrystalPanel:UIBase
local UIBrmCrystalPanel = {}

---圣物列表
---@return UIGridContainer
function UIBrmCrystalPanel:GetGrids()
    if self.mGrids == nil then
        self.mGrids = self:GetCurComp("WidgetRoot/view/MainView/Crystal/scroll/Grid", "UIGridContainer")
    end
    return self.mGrids
end

---活动时间文本
---@return UILabel
function UIBrmCrystalPanel:GetActivityTimeLabel()
    if self.mActivityTimeLabel == nil then
        self.mActivityTimeLabel = self:GetCurComp("WidgetRoot/view/MainView/Crystal/Time", "UILabel")
    end
    return self.mActivityTimeLabel
end

---采集次数文本
---@return UILabel
function UIBrmCrystalPanel:GetGatherCountLabel()
    if self.mGatherCountLabel == nil then
        self.mGatherCountLabel = self:GetCurComp("WidgetRoot/view/MainView/Crystal/Table/number", "UILabel")
    end
    return self.mGatherCountLabel
end

---体力消耗文本
---@return UILabel
function UIBrmCrystalPanel:GetCostCountLabel()
    if self.mCostCountLabel == nil then
        self.mCostCountLabel = self:GetCurComp("WidgetRoot/view/MainView/Crystal/Cost/number", "UILabel")
    end
    return self.mCostCountLabel
end

function UIBrmCrystalPanel:Init()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BaiRiMenActivityInOpenTimeStateChanged, function()
        self:RefreshUI()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BaiRiMenActivityDataReceived, function()
        self:RefreshUI()
    end)
end

function UIBrmCrystalPanel:Show()
    gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu():RequestServerData()
    self:RefreshUI()
end

function UIBrmCrystalPanel:RefreshUI()
    ---刷新活动时间
    self:RefreshActivityTimeLabel()
    ---刷新格子
    self:RefreshGrids()
    ---刷新采集次数
    --self:RefreshShengWuGatherCount()
    ---刷新当前体力
    self:RefreshShengWuStaminaCount()
    ---刷新消耗体力
    self:RefreshCostStaminaCount()
end

---刷新格子
---@private
function UIBrmCrystalPanel:RefreshGrids()
    local shengwuController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    local activityTbls = shengwuController:GetActivityTables()
    self:GetGrids().MaxCount = #activityTbls
    for i = 1, #activityTbls do
        local go = self:GetGrids().controlList[i - 1]
        local template = self:GetTemplateForCell(go)
        local tbl = activityTbls[i]
        local mapID, lastAmount = shengwuController:GetShengWuMapIDAndLastAmount(tbl:GetMonsterId())
        template:RefreshUI(tbl, mapID, lastAmount)
    end
end

---@return UIBrmCrystalTemplate_Cell
function UIBrmCrystalPanel:GetTemplateForCell(go)
    if go == nil or CS.StaticUtility.IsNull(go) then
        return nil
    end
    if self.mTemplatesForCell == nil then
        self.mTemplatesForCell = {}
    end
    if self.mTemplatesForCell[go] ~= nil then
        return self.mTemplatesForCell[go]
    else
        ---@type UIBrmCrystalTemplate_Cell
        local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBrmCrystalTemplate_Cell, self)
        self.mTemplatesForCell[go] = template
        if self.mCellClickCallBack == nil then
            self.mCellClickCallBack = function(goTemp, bairimenActivityTbl)
                self:OnCellButtonClicked(goTemp, bairimenActivityTbl)
            end
        end
        template:BindClickEvent(self.mCellClickCallBack)
        return template
    end
end

---刷新活动时间文本
---@private
function UIBrmCrystalPanel:RefreshActivityTimeLabel()
    local shengwuController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    if shengwuController:GetRepresentActivityTbl() == nil then
        return
    end
    local dailyActivityTimeID = shengwuController:GetRepresentActivityTbl():GetActivityId()
    local dailyActivityTimeTbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(dailyActivityTimeID)
    if dailyActivityTimeTbl == nil then
        return
    end
    local startTime = dailyActivityTimeTbl:GetStartTime()
    local overTime = dailyActivityTimeTbl:GetOverTime()
    self:GetActivityTimeLabel().text = Utility.CombineStringQuickly("每日 ",
            Utility.CombineStringQuickly(
                    self:GetNumberStrDouble(startTime / 60),
                    ":",
                    self:GetNumberStrDouble(startTime % 60)),
            "-",
            Utility.CombineStringQuickly(
                    self:GetNumberStrDouble(overTime / 60),
                    ":",
                    self:GetNumberStrDouble(overTime % 60)),
            "  刷新")
end

---刷新采集次数
---@private
function UIBrmCrystalPanel:RefreshShengWuGatherCount()
    local shengwuController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    local lastGatherCount = shengwuController:GetCurrentLastingShengWuGatherCount()
    local maxGatherCount = shengwuController:GetShengWuGatherMaxCount()
    if lastGatherCount == nil then
        self:GetGatherCountLabel().text = Utility.CombineStringQuickly("圣物采集次数  [dde6eb]", "-", "[-]/", maxGatherCount)
    else
        if lastGatherCount < 0 then
            lastGatherCount = 0
        end
        if lastGatherCount > 0 then
            self:GetGatherCountLabel().text = Utility.CombineStringQuickly("圣物采集次数  [00ff00]", lastGatherCount, "[-]/", maxGatherCount)
        else
            self:GetGatherCountLabel().text = Utility.CombineStringQuickly("圣物采集次数  [ff0000]", lastGatherCount, "[-]/", maxGatherCount)
        end
    end
end

---刷新当前体力
---@private
function UIBrmCrystalPanel:RefreshShengWuStaminaCount()
    local shengwuController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    local lastGatherCount = shengwuController:GetCurrentLastingShengWuStamina()
    local des = ""
    if type(lastGatherCount ) ~= 'number' or lastGatherCount < 0 then
        lastGatherCount = 0
    end
    if lastGatherCount == 0 then
        des = Utility.CombineStringQuickly("当前体力 ", luaEnumColorType.Red, lastGatherCount)
    else
        des = Utility.CombineStringQuickly("当前体力 ", luaEnumColorType.Green,lastGatherCount)
    end
    luaclass.UIRefresh:RefreshLabel(self:GetGatherCountLabel(),des)
end

---刷新消耗的体力
---@private
function UIBrmCrystalPanel:RefreshCostStaminaCount()
    local shengwuController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    if shengwuController == nil then
        return
    end
    local shengWuActivityTbl = shengwuController:GetRepresentActivityTbl()
    if shengWuActivityTbl == nil then
        return
    end
    luaclass.UIRefresh:RefreshLabel(self:GetCostCountLabel(),"体力消耗 " .. luaEnumColorType.Red .. tostring(shengWuActivityTbl:GetPhysicalstrength()))
end

---获取两位数字字符串
---@private
function UIBrmCrystalPanel:GetNumberStrDouble(num)
    num = math.floor(num)
    if num < 10 then
        return Utility.CombineStringQuickly('0', num)
    end
    return tostring(num)
end

---单元按钮点击事件
---@param go UnityEngine.GameObject
---@param bairimenActivityTbl TABLE.cfg_bairimen_activity
function UIBrmCrystalPanel:OnCellButtonClicked(go, bairimenActivityTbl)
    if go == nil or bairimenActivityTbl == nil then
        return
    end
    local shengwuActController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_ShengWu()
    local eventParams = bairimenActivityTbl:GetEventParameters()
    local confirmType, confirmParam, failType, failParam = self:ParseData(eventParams)
    --if true then
    if shengwuActController:IsActivityOpenedNow() then
        ---活动开启时
        if confirmType == 1 then
            ---副本寻找对应npc
            if confirmParam ~= nil then
                if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(
                        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(confirmParam))
                        >= 0 then
                    uimanager:ClosePanel("UIWhiteSunGatePanel")
                end
            end
        elseif confirmType == 2 then
            ---气泡id
            Utility.ShowPopoTips(go, nil, failParam, "UIBrmCrystalPanel")
        elseif confirmType == 3 then
            ---跳转界面
            if confirmParam then
                uiTransferManager:TransferToPanel(confirmParam)
            end
        elseif confirmType == 4 then
            ---直接传送
            if confirmParam ~= nil then
                local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(confirmParam)
                if deliverTbl then
                    local toMapID = deliverTbl:GetToMapId()
                    ---@type TABLE.CFG_MAP
                    local mapTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(toMapID)
                    if mapTbl then
                        local conditionList = mapTbl.conditionId
                        if conditionList ~= nil and conditionList.list.Count > 0 then
                            local res, failConditionID = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionListAndReturnReason(conditionList.list)
                            if res == false then
                                if failConditionID ~= 0 then
                                    ---@type TABLE.CFG_CONDITIONS
                                    local conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failConditionID)
                                    if conditionTbl then
                                        local conditionType = conditionTbl.conditionType
                                        if conditionType == 1 then
                                            Utility.ShowPopoTips(go, "等级不足", 290, "UIBrmCrystalPanel")
                                        elseif conditionType == 3 then
                                            Utility.ShowPopoTips(go, "转生不足", 290, "UIBrmCrystalPanel")
                                        end
                                    end
                                end
                                return
                            end
                        end
                        Utility.TryTransfer(confirmParam, false)
                        --networkRequest.ReqDeliverByConfig(confirmParam)
                        uimanager:ClosePanel("UIWhiteSunGatePanel")
                    end
                end
            end
        end
    else
        ---活动未开启时
        local shengwuMap, shengwuLastCount = shengwuActController:GetShengWuMapIDAndLastAmount(bairimenActivityTbl:GetMonsterId())
        if confirmType == 4 then
            ---直接传送的话,先判定地图是否可以进入,如果不能进入则弹气泡
            if confirmParam ~= nil then
                local deliverTbl = clientTableManager.cfg_deliverManager:TryGetValue(confirmParam)
                if deliverTbl then
                    local toMapID = deliverTbl:GetToMapId()
                    ---@type TABLE.CFG_MAP
                    local mapTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(toMapID)
                    if mapTbl then
                        local conditionList = mapTbl.conditionId
                        if conditionList ~= nil and conditionList.list.Count > 0 then
                            local res, failConditionID = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionListAndReturnReason(conditionList.list)
                            if res == false then
                                if failConditionID ~= 0 then
                                    ---@type TABLE.CFG_CONDITIONS
                                    local conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failConditionID)
                                    if conditionTbl then
                                        local conditionType = conditionTbl.conditionType
                                        if conditionType == 1 then
                                            Utility.ShowPopoTips(go, "等级不足", 290, "UIBrmCrystalPanel")
                                        elseif conditionType == 3 then
                                            Utility.ShowPopoTips(go, "转生不足", 290, "UIBrmCrystalPanel")
                                        end
                                    end
                                end
                                return
                            end
                        end
                    end
                end
            end
        end
        if shengwuLastCount > 0 then
            ---如果圣物数量不为0,则向服务器请求传送
            if confirmType == 4 then
                Utility.TryTransfer(confirmParam, false)
                --networkRequest.ReqDeliverByConfig(confirmParam)
                uimanager:ClosePanel("UIWhiteSunGatePanel")
                return
            end
        else
            ---如果圣物数量为0,则弹出气泡活动未开启
            if failType == 2 and failParam ~= nil then
                Utility.ShowPopoTips(go, nil, failParam, "UIBrmCrystalPanel")
                return
            end
        end
    end
end

---解析数据
---@public
---@param eventParams string
---@return number, number, number|nil, number|nil
function UIBrmCrystalPanel:ParseData(eventParams)
    local confirmType, confirmData, failType, failData
    if eventParams ~= nil and eventParams ~= "" then
        local strs1 = string.Split(eventParams, '&')
        if strs1 ~= nil then
            local confirmParams = strs1[1]
            if confirmParams ~= nil then
                local strs1Strs1 = string.Split(confirmParams, '#')
                if #strs1Strs1 >= 1 then
                    confirmType = tonumber(strs1Strs1[1])
                end
                if #strs1Strs1 >= 2 then
                    confirmData = tonumber(strs1Strs1[2])
                end
                local failParams = strs1[2]
                local strs2Strs1 = string.Split(failParams, '#')
                if #strs2Strs1 >= 1 then
                    failType = tonumber(strs2Strs1[1])
                end
                if #strs2Strs1 >= 2 then
                    failData = tonumber(strs2Strs1[2])
                end
            end
        end
    end
    return confirmType, confirmData, failType, failData
end

return UIBrmCrystalPanel