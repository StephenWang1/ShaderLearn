---GM工具分面板-命令面板
---分为3块:
---1.快速命令(配表,直接发送表内的命令   可设置类型,进行收缩)
---2.指定命令(配表,根据表内格式,创建命令参数输入框   可设置类型,进行收缩)
---3.功能命令(程序根据各种功能需求单独增加的命令   可设置类型,进行收缩)
local UIGMPanel_Order = {}

--region 参数

--endregion

--region 组件

function UIGMPanel_Order:GetTg_QuickOrder()
    if self.mTg_QuickOrder == nil then
        self.mTg_QuickOrder = self:Get("Event/tg_QuickOrder", "GameObject")
    end
    return self.mTg_QuickOrder
end

function UIGMPanel_Order:GetTg_AssignOrder()
    if self.mTg_AssignOrder == nil then
        self.mTg_AssignOrder = self:Get("Event/tg_AssignOrder", "GameObject")
    end
    return self.mTg_AssignOrder
end

function UIGMPanel_Order:GetTg_FuncnOrder()
    if self.mGetTg_FuncnOrder == nil then
        self.mGetTg_FuncnOrder = self:Get("Event/tg_FuncOrder", "GameObject")
    end
    return self.mGetTg_FuncnOrder
end

function UIGMPanel_Order:GetTg_SceneInfo()
    if self.mGetTg_SceneInfo == nil then
        self.mGetTg_SceneInfo = self:Get("Event/tg_Info", "GameObject")
    end
    return self.mGetTg_SceneInfo
end

function UIGMPanel_Order:GetTg_UsePortAndIp()
    if self.mGetTg_UsePortAndIp == nil then
        self.mGetTg_UsePortAndIp = self:Get("Event/tg_Ip", "GameObject")
    end
    return self.mGetTg_UsePortAndIp
end

function UIGMPanel_Order:GetSceneInfoPanelTemplate()
    if self.mSceneInfoPanelTemplate == nil then
        self.mSceneInfoPanelTemplate = templatemanager.GetNewTemplate(self:GetSceneInfoPanel(), luaComponentTemplates.UIGMPanel_SceneInfo)
    end
    return self.mSceneInfoPanelTemplate
end
--endregion

--region 初始化
function UIGMPanel_Order:Init(panel)
    self:InitData()

    CS.UIEventListener.Get(self:GetTg_QuickOrder()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTg_QuickOrder()).OnClickLuaDelegate = self.OnClickTg_QuickOrder
    CS.UIEventListener.Get(self:GetTg_AssignOrder()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTg_AssignOrder()).OnClickLuaDelegate = self.OnClickTg_AssignOrder
    CS.UIEventListener.Get(self:GetTg_FuncnOrder()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTg_FuncnOrder()).OnClickLuaDelegate = self.OnClickTg_FuncOrder
    CS.UIEventListener.Get(self:GetTg_SceneInfo()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTg_SceneInfo()).OnClickLuaDelegate = self.OnClickTg_SceneInfo
    CS.UIEventListener.Get(self:GetTg_UsePortAndIp()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetTg_UsePortAndIp()).OnClickLuaDelegate = self.OnClickTg_UsePortAndIp

    self.mSceneInfoPanelTemplate = templatemanager.GetNewTemplate(self:GetSceneInfoPanel(), luaComponentTemplates.UIGMPanel_SceneInfo)

    ---@type UIGMPanel_PortInfo
    self.mPortAndIpPanelTemplate = templatemanager.GetNewTemplate(self:GetPortAndIpPanel(),luaComponentTemplates.UIGMPanel_PortInfo)
    self:InitFunctionEvent()
    self:ToggleQuickOrderPanel(true)
end

function UIGMPanel_Order:OnClickTg_QuickOrder()
    self:ToggleQuickOrderPanel(true)
    self:ToggleAssignOrderPanel(false)
    self:ToggleFunctionOrderPanel(false)
    self:OnToggleSwitch_SceneInfo(false)
    self:OnToggleSwitch_UsePort(false)
end

function UIGMPanel_Order:OnClickTg_AssignOrder()
    self:ToggleQuickOrderPanel(false)
    self:ToggleAssignOrderPanel(true)
    self:ToggleFunctionOrderPanel(false)
    self:OnToggleSwitch_SceneInfo(false)
    self:OnToggleSwitch_UsePort(false)
end

function UIGMPanel_Order:OnClickTg_FuncOrder()
    self:ToggleQuickOrderPanel(false)
    self:ToggleAssignOrderPanel(false)
    self:ToggleFunctionOrderPanel(true)
    self:OnToggleSwitch_SceneInfo(false)
    self:OnToggleSwitch_UsePort(false)
end

function UIGMPanel_Order:OnClickTg_SceneInfo()
    self:ToggleQuickOrderPanel(false)
    self:ToggleAssignOrderPanel(false)
    self:ToggleFunctionOrderPanel(false)
    self:OnToggleSwitch_SceneInfo(true)
    self:OnToggleSwitch_UsePort(false)
end

function UIGMPanel_Order:OnClickTg_UsePortAndIp()
    self:ToggleQuickOrderPanel(false)
    self:ToggleAssignOrderPanel(false)
    self:ToggleFunctionOrderPanel(false)
    self:OnToggleSwitch_SceneInfo(false)
    self:OnToggleSwitch_UsePort(true)
end

function UIGMPanel_Order:Show(pos)
    UIGMPanel_Order.IsInitQuickOrder = false
    UIGMPanel_Order.IsInitFunckOrder = false
    UIGMPanel_Order.IsInitAssignOrder = false
    self.go:SetActive(true)
    if self.mIsReshow == nil then
        self.mIsReshow = true
        self:ToggleQuickOrderPanel(true)
    end

    if self:GetTg_GMTransfer() then
        self:GetTg_GMTransfer():Set(uiStaticParameter.isOpenGMSend)
    end
    if self:GetTg_OpenHeadDebug() then
        if CS.Top_CSGame.Sington ~= nil then
            self:GetTg_OpenHeadDebug():Set(CS.Top_CSGame.Sington.IsShowDetailInHead)
        else
            self:GetTg_OpenHeadDebug():Set(false)
        end
    end
    if self:GetTg_ShowFPS() then
        self:GetTg_ShowFPS():Set(CS.FPSDisplayer.IsFPSDisplayOn)
    end

    if self:GetHotLogFrequencyInput() then
        self:GetHotLogFrequencyInput().text = CS.Resource.streamIntervalMaxIndex
    end
end

function UIGMPanel_Order:Hide()
    self.go:SetActive(false)
end

function UIGMPanel_Order:InitData()
    local path = CS.CSResource.GetPath("gmsetting.txt", CS.ResourceType.TableBytes, false)
    local lines = CS.FileUtility.ReadToEnd_Line(path)

    UIGMPanel_Order.GMOrderSettingData = {}
    for i = 1, lines.Count - 1 do
        local line = lines[i]
        self:AddOrder(line)
    end
end

function UIGMPanel_Order:AddOrder(data)
    local info = CS.Utility_Lua.Split(data, luaSplitType.jinghao)
    local type = tonumber(info[0])
    local subType = info[1]
    local id = tonumber(info[2])
    local parameter = CS.Utility_Lua.Split(info[3], luaSplitType.xiahuaxian)
    local orderFormat = info[4]

    if (UIGMPanel_Order.GMOrderSettingData[type] == nil) then
        self:AddOrderType(type)
    end

    if (UIGMPanel_Order.GMOrderSettingData[type].list[subType] == nil) then
        self:AddOrderGroup(type, subType)
    end

    self:AddOrderItem(type, subType, id, parameter, orderFormat)

end

function UIGMPanel_Order:AddOrderType(type)
    UIGMPanel_Order.GMOrderSettingData[type] = {}
    UIGMPanel_Order.GMOrderSettingData[type].Count = 0
    UIGMPanel_Order.GMOrderSettingData[type].list = {}
end

function UIGMPanel_Order:AddOrderGroup(type, subType)
    local orderTypeData = UIGMPanel_Order.GMOrderSettingData[type]
    orderTypeData.Count = orderTypeData.Count + 1
    orderTypeData.list[subType] = {}
    orderTypeData.list[subType].Count = 0
    orderTypeData.list[subType].Name = subType
    orderTypeData.list[subType].list = {}
end

function UIGMPanel_Order:AddOrderItem(type, subType, id, parameter, orderFormat)
    local orderGroup = UIGMPanel_Order.GMOrderSettingData[type].list[subType];
    orderGroup.Count = orderGroup.Count + 1
    orderGroup.list[id] = {}
    orderGroup.list[id].parameter = parameter
    orderGroup.list[id].orderFormat = orderFormat
end
--endregion

UIGMPanel_Order.GMOrderSettingData = {}

--region 快捷命令面板
--region 组件
function UIGMPanel_Order:GetQuickOrderGridPanel()
    if self.mQuickOrderGridPanel == nil then
        self.mQuickOrderGridPanel = self:Get("QuickOrderGridPanel", "GameObject")
    end
    return self.mQuickOrderGridPanel
end

function UIGMPanel_Order:GetQuickOrderGridContainer()
    if self.mQuickOrderGridContainer == nil then
        self.mQuickOrderGridContainer = self:Get("QuickOrderGridPanel/OrderTable", "UIGridContainer")
    end
    return self.mQuickOrderGridContainer
end
function UIGMPanel_Order:GetQuickOrderGridTable()
    if self.mQuickOrderGridTable == nil then
        self.mQuickOrderGridTable = self:Get("QuickOrderGridPanel/OrderTable", "UITable")
    end
    return self.mQuickOrderGridTable
end
--endregion

UIGMPanel_Order.IsInitQuickOrder = false

--- 快捷命令面板的开关
function UIGMPanel_Order:ToggleQuickOrderPanel(open)
    if (open and UIGMPanel_Order.IsInitQuickOrder == false) then
        UIGMPanel_Order.IsInitQuickOrder = true
        self:InitQuickOrderPanel(self:GetQuickOrderGridContainer(), 1)
    end
    self:GetQuickOrderGridPanel():SetActive(open)
end

function UIGMPanel_Order:InitQuickOrderPanel(container, type)
    local data = UIGMPanel_Order.GMOrderSettingData[type]
    if data == nil then
        return
    end
    local count = data.Count
    container.MaxCount = tonumber(count)
    local index = 0
    for k, value in pairs(data.list) do
        self:InitGroupContainerItem(container.controlList[index], k, value)
        index = index + 1
    end
end

function UIGMPanel_Order:InitGroupContainerItem(containerObj, key, data)
    local OrderGroupName = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Control/Name"), "UILabel")
    local container = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Grid"), "UIGridContainer")

    local BtnOrderGroup = containerObj.transform:Find("Control/Name").gameObject
    local parameter = {}
    parameter.go = container.gameObject
    parameter.table = self:GetQuickOrderGridTable()
    CS.UIEventListener.Get(BtnOrderGroup).parameter = parameter
    CS.UIEventListener.Get(BtnOrderGroup).OnClickLuaDelegate = self.ToggleGroup

    OrderGroupName.text = key
    container.MaxCount = data.Count
    local index = 0
    for k, value in pairs(data.list) do
        self:InitOrderContainerItem(container.controlList[index], k, value)
        index = index + 1
    end
end

function UIGMPanel_Order:InitOrderContainerItem(containerObj, key, data)
    local OrderGroupName = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Label"), "UILabel")
    OrderGroupName.text = data.parameter[0]
    CS.UIEventListener.Get(containerObj).parameter = data.orderFormat
    CS.UIEventListener.Get(containerObj).OnClickLuaDelegate = self.OnClickOrder
end

function UIGMPanel_Order:OnClickOrder(go)
    local order = CS.UIEventListener.Get(go).parameter
    CS.CSInterfaceSingleton.NetReq:ReqGMMessage(order);
end

--endregion

function UIGMPanel_Order:ToggleGroup(go)
    local parameter = CS.UIEventListener.Get(go).parameter
    if (parameter.go.transform.localScale == CS.UnityEngine.Vector3.one) then
        parameter.go.transform.localScale = CS.UnityEngine.Vector3.zero
    else
        parameter.go.transform.localScale = CS.UnityEngine.Vector3.one
    end
    parameter.table:Reposition()
end

--region 指定命令面板
UIGMPanel_Order.IsInitAssignOrder = false

--region 组件
function UIGMPanel_Order:GetAssignOrderGridPanel()
    if self.mAssignOrderGridPanel == nil then
        self.mAssignOrderGridPanel = self:Get("AssignOrderGridPanel", "GameObject")
    end
    return self.mAssignOrderGridPanel
end

function UIGMPanel_Order:GetAssignOrderGridContainer()
    if self.mAssignOrderGridContainer == nil then
        self.mAssignOrderGridContainer = self:Get("AssignOrderGridPanel/OrderTable", "UIGridContainer")
    end
    return self.mAssignOrderGridContainer
end

function UIGMPanel_Order:GetAssignOrderGridTable()
    if self.mAssignOrderGridTable == nil then
        self.mAssignOrderGridTable = self:Get("AssignOrderGridPanel/OrderTable", "UITable")
    end
    return self.mAssignOrderGridTable
end
--endregion
--- 指定命令面板的开关
function UIGMPanel_Order:ToggleAssignOrderPanel(open)
    self:GetAssignOrderGridPanel():SetActive(open)
    if (open and UIGMPanel_Order.IsInitAssignOrder == false) then
        UIGMPanel_Order.IsInitAssignOrder = true
        self:InitAssignOrderPanel(self:GetAssignOrderGridContainer(), 2)
    end
    self:GetAssignOrderGridTable():Reposition()
end

function UIGMPanel_Order:InitAssignOrderPanel(container, type)
    local data = UIGMPanel_Order.GMOrderSettingData[type]
    if (data == nil) then
        return
    end
    local count = data.Count
    container.MaxCount = tonumber(count)
    local index = 0
    for k, value in pairs(data.list) do
        self:InitAssignGroupContainerItem(container.controlList[index], k, value)
        index = index + 1
    end
end

function UIGMPanel_Order:InitAssignGroupContainerItem(containerObj, key, data)
    local OrderGroupName = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Control/Name"), "UILabel")
    local container = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Grid"), "UIGridContainer")

    local BtnOrderGroup = containerObj.transform:Find("Control/Name").gameObject
    local parameter = {}
    parameter.go = container.gameObject
    parameter.table = self:GetAssignOrderGridTable()
    CS.UIEventListener.Get(BtnOrderGroup).parameter = parameter
    CS.UIEventListener.Get(BtnOrderGroup).OnClickLuaDelegate = self.ToggleGroup

    OrderGroupName.text = key
    container.MaxCount = data.Count
    local index = 0
    for k, value in pairs(data.list) do
        self:InitAssignContainerItem(container.controlList[index], k, value)
        index = index + 1
    end
end

function UIGMPanel_Order:InitAssignContainerItem(containerObj, key, data)
    local orderName = CS.Utility_Lua.GetComponent(containerObj.transform:Find("Btn/Label"), "UILabel")
    orderName.text = data.parameter[0]
    local inputGrid = CS.Utility_Lua.GetComponent(containerObj.transform, "UIGridContainer")
    local inputTable = CS.Utility_Lua.GetComponent(containerObj.transform, "UITable")
    self:SetAssignInput(inputGrid, data.parameter)
    inputTable:Reposition()
    local btn = containerObj.transform:Find("Btn").gameObject

    local AssignBtnData = {}
    AssignBtnData.inputGrid = inputGrid
    AssignBtnData.orderFormat = data.orderFormat

    CS.UIEventListener.Get(btn).parameter = AssignBtnData
    CS.UIEventListener.Get(btn).OnClickLuaDelegate = self.OnClickAssignOrder
end

function UIGMPanel_Order:SetAssignInput(InputGrid, parameters)
    if (parameters.Length == 1) then
        return
    end
    InputGrid.MaxCount = parameters.Length - 1
    for i = 0, InputGrid.MaxCount - 1 do
        local obj = InputGrid.controlList[i]
        CS.Utility_Lua.GetComponent(obj.transform:Find("Label"), "UILabel").text = parameters[i + 1]
        i = i + 1
    end
end

function UIGMPanel_Order:OnClickAssignOrder(go)
    local AssignBtnData = CS.UIEventListener.Get(go).parameter
    local message = AssignBtnData.orderFormat
    if (AssignBtnData.inputGrid.MaxCount == 1) then
        local input0 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[0].transform:Find("input"), "UIInput")
        message = CS.System.String.Format(AssignBtnData.orderFormat, input0.value)
    elseif (AssignBtnData.inputGrid.MaxCount == 2) then
        local input0 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[0].transform:Find("input"), "UIInput")
        local input1 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[1].transform:Find("input"), "UIInput")
        message = CS.System.String.Format(AssignBtnData.orderFormat, input0.value, input1.value)
    elseif (AssignBtnData.inputGrid.MaxCount == 3) then
        local input0 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[0].transform:Find("input"), "UIInput")
        local input1 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[1].transform:Find("input"), "UIInput")
        local input2 = CS.Utility_Lua.GetComponent(AssignBtnData.inputGrid.controlList[2].transform:Find("input"), "UIInput")
        message = CS.System.String.Format(AssignBtnData.orderFormat, input0.value, input1.value, input2.value)
    end
    CS.CSInterfaceSingleton.NetReq:ReqGMMessage(message);
end
--endregion

--region 功能命令面板
function UIGMPanel_Order:GetFunctionOrderPanel()
    if self.mGetFunctionOrderPanel == nil then
        self.mGetFunctionOrderPanel = self:Get("FunctionOrderPanel", "GameObject")
    end
    return self.mGetFunctionOrderPanel
end

---@return UnityEngine.GameObject
function UIGMPanel_Order:GetSceneInfoPanel()
    if self.mSceneInfoPanel == nil then
        self.mSceneInfoPanel = self:Get("SceneInfoPanel", "GameObject")
    end
    return self.mSceneInfoPanel
end

---@return UnityEngine.GameObject
function UIGMPanel_Order:GetPortAndIpPanel()
    if self.mPortAndIpPanel == nil then
        self.mPortAndIpPanel = self:Get("PortAndIP", "GameObject")
    end
    return self.mPortAndIpPanel
end

function UIGMPanel_Order:GetTg_GMTransfer()
    if self.mGetTg_GMTransfer == nil then
        self.mGetTg_GMTransfer = self:Get("FunctionOrderPanel/Tg_GMTransfer", "UIToggle")
    end
    return self.mGetTg_GMTransfer
end

function UIGMPanel_Order:GetTg_OpenHeadDebug()
    if self.mTg_OpenHeadDebug == nil then
        self.mTg_OpenHeadDebug = self:Get("FunctionOrderPanel/Tg_OpenHeadDebug", "UIToggle")
    end
    return self.mTg_OpenHeadDebug
end

function UIGMPanel_Order:GetTg_ShowFPS()
    if self.mTg_ShowFPS == nil then
        self.mTg_ShowFPS = self:Get("FunctionOrderPanel/Tg_ShowFPS", "UIToggle")
    end
    return self.mTg_ShowFPS
end

function UIGMPanel_Order:GetTg_ShowGameHotSchedule()
    if self.mTg_ShowGameHotSchedule == nil then
        self.mTg_ShowGameHotSchedule = self:Get("FunctionOrderPanel/Tg_ShowGameHotSchedule", "UIToggle")
    end
    return self.mTg_ShowGameHotSchedule
end

function UIGMPanel_Order:GetTTg_PauseGameHot()
    if self.mTg_PauseGameHot == nil then
        self.mTg_PauseGameHot = self:Get("FunctionOrderPanel/Tg_PauseGameHot", "UIToggle")
    end
    return self.mTg_PauseGameHot
end

function UIGMPanel_Order:GetTg_TestFillMode()
    if self.mTg_TestFillMode == nil then
        self.mTg_TestFillMode = self:Get("FunctionOrderPanel/Tg_TestFillMode", "UIToggle")
    end
    return self.mTg_TestFillMode
end

function UIGMPanel_Order:GetHotLogFrequencyBtn()
    if self.mHotLogFrequencyBtn == nil then
        self.mHotLogFrequencyBtn = self:Get("FunctionOrderPanel/HotLogFrequency/Btn/Background", "GameObject")
    end
    return self.mHotLogFrequencyBtn
end

function UIGMPanel_Order:GetOtherStopBtn()
    if self.mOtherStop == nil then
        self.mOtherStop = self:Get("FunctionOrderPanel/OtherStop/Background", "GameObject")
    end
    return self.mOtherStop
end
function UIGMPanel_Order:GetOtherStopBtnLabel()
    if self.mOtherStopLabel == nil then
        self.mOtherStopLabel = self:Get("FunctionOrderPanel/OtherStop/OtherStopLabel", "Top_UILabel")
    end
    return self.mOtherStopLabel
end

function UIGMPanel_Order:GetHotLogFrequencyInput()
    if self.mHotLogFrequencyInput == nil then
        self.mHotLogFrequencyInput = self:Get("FunctionOrderPanel/HotLogFrequency/Input/input", "Top_UIInput")
    end
    return self.mHotLogFrequencyInput
end

UIGMPanel_Order.IsInitFunckOrder = false
function UIGMPanel_Order:ToggleFunctionOrderPanel(open)
    if (open and UIGMPanel_Order.IsInitFunckOrder == false) then
        UIGMPanel_Order.IsInitFunckOrder = true
    end
    self:GetFunctionOrderPanel():SetActive(open)
end

function UIGMPanel_Order:OnToggleSwitch_SceneInfo(open)
    self:GetSceneInfoPanel():SetActive(open)
end

function UIGMPanel_Order:OnToggleSwitch_UsePort(open)
    self:GetPortAndIpPanel():SetActive(open)
end

function UIGMPanel_Order:InitFunctionEvent()
    if self:GetTg_GMTransfer() then
        CS.EventDelegate.Add(self:GetTg_GMTransfer().onChange, function()
            self:OnClickTg_GMTransfer(self:GetTg_GMTransfer().value)
        end)
    end
    if self:GetTg_OpenHeadDebug() then
        CS.EventDelegate.Add(self:GetTg_OpenHeadDebug().onChange, function()
            if CS.Top_CSGame.Sington then
                CS.Top_CSGame.Sington.IsShowDetailInHead = self:GetTg_OpenHeadDebug().value
            end
        end)
    end
    if self:GetTg_ShowFPS() then
        CS.EventDelegate.Add(self:GetTg_ShowFPS().onChange, function()
            if CS.FPS.Instance ~= nil then
                if CS.FPS.Instance._IsShowFPS ~= nil then
                    CS.FPS.Instance._IsShowFPS = self:GetTg_ShowFPS().value
                else
                    CS.FPS.Instance.Displayer.enabled = self:GetTg_ShowFPS().value
                end
            end
        end)
    end

    if self:GetTg_ShowGameHotSchedule() then
        CS.EventDelegate.Add(self:GetTg_ShowGameHotSchedule().onChange, function()
            if CS.CSResUpdateMgr.Instance ~= nil then
                CS.CSResUpdateMgr.Instance.IsPermanentGameHotTip = self:GetTg_ShowGameHotSchedule().value
            end
        end)
    end

    if self:GetTTg_PauseGameHot() then
        CS.EventDelegate.Add(self:GetTTg_PauseGameHot().onChange, function()
            if CS.CSResUpdateMgr.Instance ~= nil then
                CS.CSResUpdateMgr.Instance.IsPauseGameHot = self:GetTTg_PauseGameHot().value
            end
        end)
    end

    if self:GetTg_TestFillMode() then
        CS.EventDelegate.Add(self:GetTg_TestFillMode().onChange, function()
            CS.CSGame.Sington.isTestFillMode = self:GetTg_TestFillMode().value
            if self:GetTg_TestFillMode().value then
                CS.CSGame.Sington.testFillMode = CS.UnityEngine.FilterMode.Bilinear
            else
                CS.CSGame.Sington.testFillMode = CS.UnityEngine.FilterMode.Point
            end
        end)
    end

    CS.UIEventListener.Get(self:GetHotLogFrequencyBtn().gameObject).onClick = function()
        -- CS.Resource.streamIntervalMaxIndex = tonumber(self:GetHotLogFrequencyInput().text)
        local number = tonumber(self:GetHotLogFrequencyInput().text)
        if number == 0 then
            CS.CSResUpdateMgr.IsOpenDownLoadLog1 = false
            CS.CSResUpdateMgr.IsOpenDownLoadLog2 = false
            CS.CSResUpdateMgr.IsOpenDownLoadLog3 = false
            CS.CSResUpdateMgr.isPrintThreadError = false
            CS.Resource.IsopenResourceLog1 = false
            CS.Resource.IsopenResourceLog2 = false
        elseif number == 1 then
            CS.CSResUpdateMgr.isPrintThreadError = true
            CS.CSResUpdateMgr.IsOpenDownLoadLog1 = true
            CS.CSResUpdateMgr.IsOpenDownLoadLog2 = true
            CS.CSResUpdateMgr.IsOpenDownLoadLog3 = true
            CS.Resource.IsopenResourceLog1 = true
            CS.Resource.IsopenResourceLog2 = true
        end
    end

    CS.UIEventListener.Get(self:GetOtherStopBtn().gameObject).onClick = function()
        CS.CSGame.Sington.isOtherStopMove = not CS.CSGame.Sington.isOtherStopMove
        self:GetOtherStopBtnLabel().text = '停止移动:' .. tostring(CS.CSGame.Sington.isOtherStopMove)
    end
end

function UIGMPanel_Order:OnClickTg_GMTransfer(value)
    uiStaticParameter.isOpenGMSend = value
end
--endregion

function UIGMPanel_Order:OnDestroy()
    UIGMPanel_Order.GMOrderSettingData = {}
end

return UIGMPanel_Order