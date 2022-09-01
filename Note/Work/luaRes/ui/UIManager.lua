---保证uimanager只被加载一次
if uimanager then
    if CS.CSDebug.developerConsoleVisible then
        CS.CSDebug.LogError("UIManager 已被加载")
    end
    return uimanager
end

---@class UIManager
local UIManager = {}

local Utility = Utility

---@type table 已打开的UI界面
UIManager.UIGameObjects = {}
---@type table 正在加载中的UI界面
UIManager.UILoadingGameObject = {}
---@type table 正在加载中的UI界面的回调列表
UIManager.UILoadingCallbackDic = {}
---@type table 正在加载中的UI界面的显示参数
UIManager.UIShowingParamsDic = {}
---上次播放打开关闭UI音效时间
UIManager.LastPlayAudioTime = nil
---等待打开的面板字典
---@type table<string, {paramList:table<number,any>}>
UIManager.mWaitForOpenDic = {};
---等待关闭的界面面板
---@type table<UIBase,boolean>
UIManager.mWaitForCloseList = {}
---等待关闭的界面面板是否已经Dirty状态
---@type boolean
UIManager.mWaitForCloseListIsDirty = false
---当前帧
---@type number
UIManager.mCurrentFrame = 0
---最近一次关闭界面的帧
---@type table<string, number>
UIManager.LatestClosePanelFrame = {}

-----弱引用UI界面表,仅用于luaDebugTool调试
-----@type table<string,table>
UIManager.WeakUIPanels = {}
setmetatable(UIManager.WeakUIPanels, { __mode = 'v' })

---是否将要打开界面
---@param panelName string
---@return boolean
function UIManager:IsGoingToOpenPanel(panelName)
    if UIManager.UILoadingGameObject[panelName] ~= nil then
        return true
    end
    if UIManager.mWaitForOpenDic[panelName] ~= nil and UIManager.mWaitForOpenDic[panelName].paramList ~= nil then
        return #UIManager.mWaitForOpenDic[panelName].paramList > 0
    end
    return false
end

---初始化
function UIManager:Initialize()
    self.mCurrentFrame = CS.UnityEngine.Time.frameCount
    local luaUpdateBeh = CS.LuaUpdateBehaviour.Get(self:GetRoot().gameObject)
    luaUpdateBeh:SetLuaFunction(self, self.OnUpdate)
end

---UI的关闭逻辑
---@return UICloseLogic
function UIManager:GetUICloseLogic()
    if UIManager.mUICloseLogic == nil then
        UIManager.mUICloseLogic = require "luaRes.ui.logics.UICloseLogic"
    end
    return UIManager.mUICloseLogic
end

---UI的缓冲逻辑
---@return UICacheLogic
function UIManager:GetUICacheLogic()
    if UIManager.mUICacheLogic == nil then
        UIManager.mUICacheLogic = require "luaRes.ui.logics.UICacheLogic"
    end
    return UIManager.mUICacheLogic
end

---UI的隐藏逻辑
---@return UIHideLogic
function UIManager:GetUIHideLogic()
    if UIManager.mUIHideLogic == nil then
        UIManager.mUIHideLogic = require "luaRes.ui.logics.UIHideLogic"
    end
    return UIManager.mUIHideLogic
end

---获取一个UI通用的ClientEventHandler
---@return EventHandlerManager
function UIManager:GetClientEventHandler()
    if self.mClientEventHandler == nil then
        self.mClientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)--客户端事件
    end
    return self.mClientEventHandler
end

---转 #50
function UIManager:CreatePanel(panelName, action, ...)
    --print("CreatePanel", panelName)

    --region 检查界面是否打开
    local uiPanel = UIManager.UIGameObjects[panelName]

    if (uiPanel) then
        uiPanel:Show(...)
        if (action) then
            local res, error = pcall(action, uiPanel)
            if res == false then
                CS.UnityEngine.Debug.LogError(tostring(error))
            end
        end

        return
    end
    --endregion

    local panelParam = {};
    panelParam.panelName = panelName;
    panelParam.action = action;
    panelParam.params = { ... };
    if (UIManager.mWaitForOpenDic == nil) then
        UIManager.mWaitForOpenDic = {};
    end

    if (UIManager.mWaitForOpenDic[panelName] ~= nil) then
        --print("Insert to waitingList", panelName, CS.UnityEngine.Time.frameCount)
        table.insert(UIManager.mWaitForOpenDic[panelName].paramList, panelParam);
    else
        --print("Create and insert to waitingList", panelName, CS.UnityEngine.Time.frameCount)
        UIManager.mWaitForOpenDic[panelName] = {};
        UIManager.mWaitForOpenDic[panelName].paramList = {};
        table.insert(UIManager.mWaitForOpenDic[panelName].paramList, panelParam);
    end
    uiTransferManager:TryResetLastTransfer(panelName);
    UIManager:TryStartOpenPanel();
end

---在lua中创建UI界面
---@param panelName string UI界面名
---@param action function 创建完毕回调
function UIManager:CreatePanelLogic(panelName, action, ...)
    if panelName == nil or UIManager:GetUICacheLogic():CheckBeforePanelOpened(panelName, action, ...) == false then
        return
    end
    --若界面正在被调用加载
    if UIManager.UILoadingGameObject[panelName] == true then
        --若界面已被加入加载队列,则替换界面加载回调和显示参数
        UIManager.UILoadingCallbackDic[panelName] = action
        UIManager.UIShowingParamsDic[panelName] = { ... }
        return
    end

    --检查界面是否已经打开
    local uiPanel = UIManager.UIGameObjects[panelName]

    if (uiPanel) then
        uiPanel:Show(...)
        if (action) then
            local res, error = pcall(action, uiPanel)
            if res == false then
                CS.UnityEngine.Debug.LogError(tostring(error))
            end
        end

        return
    end

    --若界面未被调用加载,则将界面名称加入正在加载队列中
    UIManager.UILoadingGameObject[panelName] = true
    UIManager.UILoadingCallbackDic[panelName] = action
    UIManager.UIShowingParamsDic[panelName] = { ... }

    local co = coroutine.create(UIManager.StartCreatePanel)
    assert(coroutine.resume(co, panelName))
end

---获取UI相机游戏物体
---@return UnityEngine.Transform 返回UI相机游戏物体
function UIManager.GetRoot()
    local root
    if root == nil then
        local uiroot = CS.UnityEngine.GameObject.Find("UI Root/Camera").transform
        if (uiroot or CS.StaticUtility.IsNull(uiroot) == false) then
            root = uiroot
        end
    end
    if root == nil then
        local uiroot = CS.UnityEngine.GameObject.FindObjectOfType(typeof(CS.UICamera))
        if (uiroot and CS.StaticUtility.IsNull(uiroot) == false) then
            root = uiroot
        end
    end
    return root
end

function UIManager.StartCreatePanel(panelName)
    local beginTime = 0;
    if (isOpenLog) then
        CS.UnityEngine.Debug.Log("尝试加载:" .. panelName);
        CS.UIManager.Instance:StartCollectOpenPanel(panelName);

        CS.UIManager.Instance:StartCollectUIABLoadData(panelName);
    end

    if isUnityEditor then
        beginTime = CS.UnityEngine.Time.time;
    end
    local root = UIManager.GetRoot()
    local isOpenedSuccessfully = false
    local go
    -- if panelName ~= 'UIServerListPanel' and panelName ~= 'UIGMToolPanel' then
    go = CS.CSResourceManager.Singleton:loadUIPanelSync(panelName, root)
    --等待资源加载完毕
    while go == nil or CS.StaticUtility.IsNull(go) == true do
        yield_return(0)
        --若该界面已从加载队列中清除,则不实例化该界面
        if UIManager.UILoadingGameObject[panelName] == nil then
            return
        end
        go = CS.CSResourceManager.Singleton:loadUIPanelSync(panelName, root)
    end
    -- else
    --     go = CS.CSResourceManager.Singleton:loadUIPanel(panelName, root)
    --     --等待资源加载完毕
    --     while go == nil or CS.StaticUtility.IsNull(go) == true do
    --         yield_return(0)
    --         --若该界面已从加载队列中清除,则不实例化该界面
    --         if UIManager.UILoadingGameObject[panelName] == nil then
    --             return
    --         end
    --         go = CS.CSResourceManager.Singleton:loadUIPanel(panelName, root)
    --     end
    -- end

    if (isOpenLog) then
        CS.UnityEngine.Debug.Log("加载成功:" .. panelName);
        CS.UIManager.Instance:EndCollectUIABLoadData(panelName, go);
    end

    --print("UIManager.UILoadingGameObject[panelName]", UIManager.UILoadingGameObject[panelName], CS.UnityEngine.Time.frameCount)

    if (CS.StaticUtility.IsNull(go) == false) then
        --若该界面已从加载队列中清除,则不实例化该界面,并删掉之前拷贝的GameObject
        if UIManager.UILoadingGameObject[panelName] == nil then
            CS.UnityEngine.GameObject.Destroy(go)
            return
        end
        go.name = panelName
        local luaBehav = nil
        if (isOpenLog) then
            CS.UIManager.Instance:StartCollectUIInitLuaBehaviour(panelName);
            luaBehav = Utility.InitLuaBehaviour(go, panelName)
            CS.UIManager.Instance:EndCollectUIInitLuaBehaviour(panelName, go);
        else
            luaBehav = Utility.InitLuaBehaviour(go, panelName)
        end

        ---此处现将luabehaviour组件置为不使能,因为后面还有1~2帧的延迟后才进入初始化流程
        luaBehav.enabled = false
        yield_return(0)
        --若该界面已从加载队列中清除,则不实例化该界面,并删掉之前拷贝的GameObject
        if UIManager.UILoadingGameObject[panelName] == nil then
            CS.UnityEngine.GameObject.Destroy(go)
            return
        end
        if (luaBehav and CS.StaticUtility.IsNull(luaBehav) == false) then
            local uiPanel = luaBehav.chunkTable
            UIManager.UIGameObjects[panelName] = uiPanel
            if (uiPanel) then
                --没有模板则继承uibase,有模板则在UIPanelConfig查看
                if getmetatable(uiPanel) == nil then
                    setmetatable(uiPanel, uibase)
                end
                --正在初始化
                uiPanel.IsInitializing = true
                --设置界面的GameObject
                uiPanel.go = go
                --设置界面名
                uiPanel._PanelName = panelName
                --if luaDebugTool ~= nil then
                --    UIManager.WeakUIPanels[panelName] = uiPanel
                --    luaDebugTool.RecordTable(luaDebugTool.TableType.PanelInstance, uiPanel)
                --end
                --设置层级,播放打开音效
                local panelLayer = uiPanel:Get_PanelLayerType()
                ---是否使用界面层级缓存
                local isForce = false;
                local params = UIManager.UIShowingParamsDic[panelName];
                if(params ~= nil) then
                    for k,v in pairs(params) do
                        if(type(v) == 'table' and v.PanelLayerType ~= nil) then
                            panelLayer = v.PanelLayerType;
                            isForce = true;
                        end
                    end
                end
                uiPanel.PanelLayerType = CS.UILayerMgr.Instance:SetLayer(go, panelLayer, isForce);

                local goIsActive = go.activeSelf
                local isNeedActiveDuringInitialize = uiPanel.IsNeedActiveDuringInitialize
                if goIsActive == true and (CS.StaticUtility.IsNull(go) == false) then
                    go:SetActive(false)
                end
                --打开界面后检查哪些界面需要关闭逻辑
                UIManager:GetUICloseLogic():CheckAfterPanelOpened(uiPanel)
                --打开界面后检查哪些界面需要隐藏逻辑
                UIManager:GetUIHideLogic():CheckAfterPanelOpened(uiPanel)
                --若该界面已从加载队列中清除,则不实例化该界面,并删掉之前拷贝的GameObject
                if true then
                    --yield_return(0)
                    local isGODestroyed = CS.StaticUtility.IsNull(go)
                    if UIManager.UILoadingGameObject[panelName] == nil or isGODestroyed then
                        if isGODestroyed == false then
                            CS.UnityEngine.GameObject.Destroy(go)
                        end
                        return
                    end
                end
                luaBehav.enabled = true
                --yield_return(0)
                --yield_return(0)
                --UIManager.UIGameObjects[panelName] = luaBehav.chunkTable
                if isNeedActiveDuringInitialize == true and CS.StaticUtility.IsNull(go) == false then
                    go:SetActive(true)
                end
                --判断uiPanel，防止打开此界面后马上关闭，导致uiPanel为nil
                if (uiPanel and CS.StaticUtility.IsNull(go) == false) then
                    --设置界面的GameObject
                    uiPanel.go = go
                    --设置界面名
                    uiPanel._PanelName = panelName
                    try {
                        main = function()
                            if (isOpenLog) then
                                CS.UIManager.Instance:StartCollectUIInit(panelName);
                                uiPanel:Init()
                                CS.UIManager.Instance:EndCollectUIInit(panelName, go);
                                if uiPanel.IsNeedActiveDuringInitialize == false then
                                    --yield_return(0)
                                end

                                CS.UIManager.Instance:StartCollectUIShowData(panelName);
                                if (UIManager.UIShowingParamsDic[panelName] == nil) then
                                    uiPanel:Show();
                                else
                                    uiPanel:Show(table.unpack(UIManager.UIShowingParamsDic[panelName]))
                                end
                                CS.UIManager.Instance:EndCollectUIShowData(panelName, go);
                            else
                                uiPanel:Init()
                                if uiPanel.IsNeedActiveDuringInitialize == false then
                                    --yield_return(0)
                                end
                                if (UIManager.UIShowingParamsDic[panelName] == nil) then
                                    uiPanel:Show();
                                else
                                    uiPanel:Show(table.unpack(UIManager.UIShowingParamsDic[panelName]))
                                end
                            end
                            uiPanel._PanelState = LuaEnumUIState.Normal;
                        end,
                        catch = function(errors)
                            CS.UnityEngine.Debug.LogError("catch : [" .. panelName .. "] " .. errors)
                        end
                    }
                    isOpenedSuccessfully = true;
                    uiPanel.IsInitializing = false
                    local action = UIManager.UILoadingCallbackDic[panelName]
                    if (action) then
                        local res, error = pcall(action, uiPanel)
                        if res == false then
                            CS.UnityEngine.Debug.LogError(tostring(error))
                        end
                    end
                else
                    uimanager.UIGameObjects[panelName] = nil
                end
                if isNeedActiveDuringInitialize == false then
                    --yield_return(0)
                    if CS.StaticUtility.IsNull(go) == false then
                        go:SetActive(true)
                    end
                end
                if CS.StaticUtility.IsNull(go) == false then
                    uiPanel.IsHiden = go.activeInHierarchy == false
                else
                    uiPanel.IsHiden = true
                end
                --若界面中定义了客户端事件分发,则在0.1s后调用其发送OpenPanel客户端事件
                --yield_return(0.1)
                if isOpenedSuccessfully and UIManager.UIGameObjects[panelName] and uiPanel ~= nil then
                    UIManager:GetClientEventHandler():SendEvent(CS.CEvent.OpenPanel, panelName)
                    --region 打开界面遮罩
                    --UIManager:TryOpenPanelMask(uiPanel);
                    --endregion

                    --region 音效
                    UIManager:PlayOpenUIAudio(uiPanel)
                    --endregion

                    CS.UIManager.Instance:AddOpenedXLuaPanelDic(panelName);
                end
            end
        end
    end

    --从调用中队列和加载回调字典中移除panelName
    UIManager:ClearUIPanelOpenRequest(panelName)
    --if isUnityEditor then
    if isOpenLog then
        CS.UIManager.Instance:EndCollectOpenPanel(panelName, go);
        luaDebug.Log("打开UI时间=" .. panelName .. " " .. (CS.UnityEngine.Time.time - beginTime) .. " " .. CS.UnityEngine.Time.frameCount);
    end
    --end
end

---表析构方法
---@private
---@param tbl UIBase
function UIManager.OnTableGCed(tbl)
    if tbl == nil then
        return
    end
    if tbl.OnDestruct then
        tbl:OnDestruct()
    end
    UIManager.ReleasePanelMemory(tbl)
end

---设定界面将被销毁
---@param panel UIBase
function UIManager.SetPanelToBeDestroyed(panel)
    if panel == nil then
        return
    end
    panel._PanelState = LuaEnumUIState.IsGoingToBeDestroyed
    for i, v in pairs(UIManager.mWaitForCloseList) do
        if i == panel then
            return
        end
    end
    UIManager.mWaitForCloseListIsDirty = true
    table.insert(UIManager.mWaitForCloseList, panel)
end

---@private
---释放界面table的内存
function UIManager.ReleasePanelMemory(panelTable)
    if panelTable == nil then
        return
    end
    --print("ReleasePanelMemory: " .. tostring(panelTable._PanelName))
    if panelTable ~= nil then
        for i, v in pairs(panelTable) do
            if i ~= "_PanelName" then
                panelTable[i] = nil
            end
        end
    end
end

---清理UI界面的打开请求
---@private
---@param panelName string 界面名
function UIManager:ClearUIPanelOpenRequest(panelName)
    --print("Clear open request", panelName, CS.UnityEngine.Time.frameCount)
    UIManager.UILoadingCallbackDic[panelName] = nil
    UIManager.UIShowingParamsDic[panelName] = nil
    UIManager.UILoadingGameObject[panelName] = nil
end

function UIManager:CreateSubPanel(panelName, parent, action)
    assert(coroutine.resume(coroutine.create(UIManager.StartCreateSubPanel), panelName, parent, action))
end

function UIManager.StartCreateSubPanel(panelName, parent, action)
    --print('StartCreateSubPanel', panelName, parent)
    local go = CS.CSResourceManager.Singleton:loadUIPanel(panelName, parent)
    if (go and action) then
        action(go)
    end
end

---转 #50
function UIManager:TryStartOpenPanel()
    if (UIManager.mCoroutineOpenPanel == nil) then
        UIManager.mCoroutineOpenPanel = StartCoroutine(UIManager.COpenPanel, UIManager)
    end
end

--region #50
---打开面板的指令协程
---(因现在界面打开初始化是同步执行(以前是异步所以不会有逻辑BUG),
---所以一些共存界面调用相同界面时候,
---在同一帧内会先执行打开逻辑,
---又因为界面互斥,把其他界面互斥掉了,
---而其他界面关闭的时候会执行关闭此界面打开过的界面
---这样会导致逻辑BUG导致应该打开的界面没有打开,
---现在对这个打开逻辑进行一个计算,
---如果同一帧内执行的界面打开和关闭逻辑进行合并,
---比如同一帧内过来一个打开界面的指令,那么就会对这个界面的打开指令数量加1,过来一个关闭命令就会对这个数量-1
---具体执行逻辑中,会对这个打开数量进行一个相应的操作,
---比如同一帧过来2个打开指令和一个关闭指令,增减之后就会执行一个打开指令)
function UIManager:COpenPanel()
    while (UIManager.mWaitForOpenDic ~= nil) do
        coroutine.yield(0);
        local panelName = nil
        for i, v in pairs(UIManager.mWaitForOpenDic) do
            if UIManager:IsNeedDelayOpen(panelName) == false then
                panelName = i
                break
            end
        end
        if panelName ~= nil then
            local panelParamsTemp = UIManager.mWaitForOpenDic[panelName]
            while UIManager.mWaitForOpenDic[panelName] ~= nil and UIManager.mWaitForOpenDic[panelName] == panelParamsTemp
                    and panelParamsTemp.paramList ~= nil and #panelParamsTemp.paramList > 0 do
                local paramTemp = panelParamsTemp.paramList[1]
                --print("Fetch one params", panelName, CS.UnityEngine.Time.frameCount)
                table.remove(panelParamsTemp.paramList, 1)
                try {
                    main = function()
                        --print("Create panel", panelName, paramTemp.panelName, CS.UnityEngine.Time.frameCount)
                        UIManager:CreatePanelLogic(paramTemp.panelName, paramTemp.action, table.unpack(paramTemp.params));
                    end,
                    catch = function(error)
                        CS.UnityEngine.Debug.LogError(error);
                    end
                }
                coroutine.yield(0);
            end
            --print("Finish Create", panelName, CS.UnityEngine.Time.frameCount)
            if UIManager.mWaitForOpenDic[panelName] == panelParamsTemp then
                ---如果队列中的界面打开数据与之前缓冲的一致,则认为该数据已经处理完毕,可以从队列中移除,否则认为期间进行了复杂的处理,如Create-Close-Create这样的操作,导致队列中当前的界面打开数据与刚才处理的不一致,不应当移除
                UIManager.mWaitForOpenDic[panelName] = nil
            end
        end
    end
    UIManager.mCoroutineOpenPanel = nil;
end

---是否需要延迟打开
---@param panelName string
---@return boolean
function UIManager:IsNeedDelayOpen(panelName)
    if UIManager.mCurrentFrame ~= nil and UIManager.LatestClosePanelFrame ~= nil and UIManager.LatestClosePanelFrame[panelName] ~= nil then
        ---最近几帧内关闭过界面,则延迟再打开
        --print("IsNeedDelayOpen", panelName, UIManager.mCurrentFrame, UIManager.LatestClosePanelFrame[panelName], UIManager.mCurrentFrame - UIManager.LatestClosePanelFrame[panelName])
        return UIManager.mCurrentFrame - UIManager.LatestClosePanelFrame[panelName] <= 2
    end
    return false
end
--endregion

---转 #50
---@param panel UIBase|string
---@param isForceClose boolean|nil 是否强制关闭
function UIManager:ClosePanel(panel, isForceClose)
    local panelName = "";
    if type(panel) == "string" then
        panelName = panel;
    elseif type(panel) == "table" then
        panelName = panel._PanelName;
    end
    if (UIManager.mWaitForOpenDic ~= nil) then
        if isForceClose then
            UIManager.mWaitForOpenDic[panelName] = nil
        else
            local paramsDataTemp = UIManager.mWaitForOpenDic[panelName]
            if paramsDataTemp ~= nil and paramsDataTemp.paramList ~= nil then
                local count = #paramsDataTemp.paramList
                if count > 0 then
                    --print("ClosePanel  Remove", panelName, count, CS.UnityEngine.Time.frameCount)
                    table.remove(paramsDataTemp.paramList, count)
                end
                if (#paramsDataTemp.paramList == 0) then
                    --print("ClosePanel  Release", panelName, CS.UnityEngine.Time.frameCount)
                    UIManager.mWaitForOpenDic[panelName] = nil;
                end
            end
        end
    end

    UIManager:ClosePanelLogic(panel);
    UIManager:TryStartOpenPanel();
end

---关闭lua中的UI界面
---@overload fun(panelName:string)
---@param panel table 需要关闭的界面
function UIManager:ClosePanelLogic(panel)
    if panel then
        if type(panel) == "string" then

            UIManager:ClosePanelWithPanelName(panel)

            --region 界面遮罩
            --UIManager:TryClosePanelMask(UIManager:GetPanel(panel))
            --endregion

        elseif type(panel) == "table" then
            local isPanelExist = false
            for i, v in pairs(UIManager.UIGameObjects) do
                if v == panel then
                    isPanelExist = true
                    break
                end
            end
            if isPanelExist then
                UIManager:ClosePanelWithPanelName(panel._PanelName)
                UIManager:PlayCloseUIAudio(panel)
            end
            --region 界面遮罩
            --UIManager:TryClosePanelMask(panel)
            --endregion
        end
    end
end

---隐藏界面
---@param uipanel UIBase
function UIManager:HidePanel(uipanel)
    if uipanel and uipanel.go and CS.StaticUtility.IsNull(uipanel.go) == false then
        uipanel.IsHiden = true
        uipanel:HideSelf()
        UIManager:PlayCloseUIAudio(uipanel)

        if uipanel.IsHiden == true then
            --region 关闭界面遮罩
            --UIManager:TryClosePanelMask(uipanel)
            --endregion
            UIManager:GetUICacheLogic():CheckAfterPanelClosed(uipanel)
            --UIManager:GetUIHideLogic():CheckAfterPanelClosed(uipanel)
        end
    end
end

---再显示界面
---@param uipanel UIBase
function UIManager:ReShowPanel(uipanel)
    if uipanel and uipanel.go and CS.StaticUtility.IsNull(uipanel.go) == false then
        uipanel.IsHiden = false
        uipanel:ReShowSelf()

        self:PlayOpenUIAudio(uipanel)

        --region 打开界面遮罩
        if uipanel.IsHiden == false then
            --UIManager:TryOpenPanelMask(uipanel);
        end
        --endregion
    end
end

---@type string 关闭界面用的界面名缓存
UIManager.mPanelName_Temp = nil
---@type number 最近一次GC执行的帧
--UIManager.mLatestGCFrame = 0
---@type number 最小的GC帧间隔
--UIManager.mMinGCFrameInterval = 52

UIManager.mClosePanelTable = {
    main = function()
        local uiPanel = UIManager.UIGameObjects[UIManager.mPanelName_Temp];
        if (uiPanel and uiPanel.go)
        then
            --print("ClosePanel: " .. UIManager.mPanelName_Temp)
            UIManager.LatestClosePanelFrame[UIManager.mPanelName_Temp] = UIManager.mCurrentFrame
            CS.UIManager.Instance:RemoveOpenedXLuaPanelDic(UIManager.mPanelName_Temp);
            UIManager.ReleasePanel(uiPanel)
            if (CS.CSAudioMgr.Instance) then
                CS.CSAudioMgr.Instance:Play(true, 7)
            end
            CS.AssetBundles.AssetBundleManager.UnloadAssetBundle(UIManager.mPanelName_Temp);
            UIManager:GetUICloseLogic():CheckAfterPanelClosed(uiPanel)
            UIManager:GetUIHideLogic():CheckAfterPanelClosed(uiPanel)
            UIManager:GetUICacheLogic():CheckAfterPanelClosed(uiPanel)
            if uiPanel then
                UIManager:GetClientEventHandler():SendEvent(CS.CEvent.ClosePanel, uiPanel._PanelName)
            end
            luaEventManager.DoCallback(LuaCEvent.ClosePanel, uiPanel._PanelName)
            gameMgr:TriggleLuaGC()
            -----设定lua GC的最短间隔
            --local currentFrame = CS.UnityEngine.Time.frameCount
            --if currentFrame > UIManager.mMinGCFrameInterval + UIManager.mLatestGCFrame then
            --    UIManager.mLatestGCFrame = UIManager.mMinGCFrameInterval + currentFrame
            --    --luaDebug.Log("GC")
            --    collectgarbage("collect")
            --end
        end
    end,
    catch = function(errors)
        CS.UnityEngine.Debug.LogError("catch : [" .. UIManager.mPanelName_Temp .. "] " .. errors)
    end
}

---关闭lua中的UI界面
---@param panelName string 需要关闭的UI界面名
function UIManager:ClosePanelWithPanelName(panelName)
    --print("ClosePanel", panelName)
    UIManager.mPanelName_Temp = panelName
    UIManager:ClearUIPanelOpenRequest(panelName)
    UIManager:GetUICacheLogic():RemoveCachedPanel(panelName)
    try(UIManager.mClosePanelTable)
end

---获取lua中的UI界面
---@param panelName string 需要获取的UI界面名
---@return UIBase lua中创建的UI界面
function UIManager:GetPanel(panelName)
    if panelName then
        if UIManager.UIGameObjects then
            return UIManager.UIGameObjects[panelName]
        end
    end
    return nil
end

---释放面板
---由C#进行调用
---@param uiPanel UIBase 需要释放的界面
function UIManager.ReleasePanel(uiPanel)
    if uiPanel then
        uiPanel._PanelState = LuaEnumUIState.IsGoingToBeDestroyed
        if uiPanel.OnPanelReleased ~= nil then
            uiPanel:OnPanelReleased()
        end
        if uiPanel.ReleaseClientEventHandler ~= nil then
            uiPanel:ReleaseClientEventHandler()
        end
        if uiPanel.ReleaseSocketEventHandler ~= nil then
            uiPanel:ReleaseSocketEventHandler()
        end
        if uiPanel.ReleaseLuaEventHandler ~= nil then
            uiPanel:ReleaseLuaEventHandler()
        end
        local hasPanel = false
        for i, v in pairs(UIManager.UIGameObjects) do
            if v == uiPanel then
                hasPanel = true
            end
        end
        if hasPanel == false then
            return
        end
        if uiPanel.go and CS.StaticUtility.IsNull(uiPanel.go) == false then
            CS.UnityEngine.GameObject.Destroy(uiPanel.go)
        end
        uiPanel.Panel = nil
        if uiPanel._PanelName then
            UIManager.UIGameObjects[uiPanel._PanelName] = nil
        end
    end
end

function UIManager:CloseAllPanelChangeMap()
    --typeof(UIMainSceneManager),typeof(UIMainMenusPanel),
    --typeof(UILoading), typeof(UIChatPanel),
    --typeof(UIAttributeChangePanel),
    --typeof(UIEquipGoodHintPanel),
    --typeof(UILvPackPanel),
    --typeof(UIOpenModelPanel),
    --typeof(UIGuidePanel),
    --typeof(UI3v3MainPanel),
    --typeof(UICareerRoadPackPanel),
    --typeof(UIJigsawPanel),
    --typeof(UIMissionPanel)},
    local exceptList = {}
    table.insert(exceptList, "UILoading")
    table.insert(exceptList, "UIMainSceneManager")
    table.insert(exceptList, "UIMainMenusPanel")
    table.insert(exceptList, "UIRoleHeadPanel")
    table.insert(exceptList, "UIMainChatPanel")
    table.insert(exceptList, "UIMainSkillPanel")
    table.insert(exceptList, "UIMissionPanel")
    table.insert(exceptList, "UIDownTipsContainerPanel")
    table.insert(exceptList, "UIAllTextTipsContainerPanel")
    table.insert(exceptList, "UIGMToolPanel")
    table.insert(exceptList, "UIStrongerLeftMainPanel")
    UIManager:CloseAllPanel(exceptList)
end

function UIManager:CloseAllPanelChangeScene()
    local exceptList = {}
    table.insert(exceptList, "UILoading")
    table.insert(exceptList, "UIDownTipsContainerPanel")
    table.insert(exceptList, "UIAllTextTipsContainerPanel")
    table.insert(exceptList, "UIGMToolPanel")
    UIManager:CloseAllPanel(exceptList)
end

---关闭所有UI界面
---@param exceptList table 赦免UI界面名列表
function UIManager:CloseAllPanel(exceptList)
    local isExceptListAvailable = true
    if exceptList == nil or type(exceptList) ~= "table" then
        isExceptListAvailable = false
    end
    --若不包含
    for k, v in pairs(UIManager.UIGameObjects) do
        if not (isExceptListAvailable and Utility.IsContainsValue(exceptList, k)) then
            --暂时
            if not (k == "UIAllTextTipsContainerPanel" or k == "UIGMToolPanel" or k == "UIDownTipsContainerPanel") then
                UIManager:ClosePanel(k)
            end
        end
    end
    UIManager:ClosePanel('UIDeadGrayPanel')
    UIManager:ClosePanel('UIDeadPanel')
    UIManager:ClosePanel('UISmallHpWarning')
end

---播放开启界面音效
---@param uiPanel UIBase
function UIManager:PlayOpenUIAudio(uiPanel)
    if uiPanel:IsNeedPlayOpenAudio() then
        if self.openUIAudioId == nil then
            self.openUIAudioId = CS.Cfg_GlobalTableManager.Instance.OpenUIAudioId
        end
        if self.openUIAudioId and self.openUIAudioId ~= -1 then
            self:PlayAudio(self.openUIAudioId)
        end
    end
end

---播放关闭界面音效
---@param uiPanel UIBase
function UIManager:PlayCloseUIAudio(uiPanel)
    if uiPanel:IsNeedPlayCloseAudio() then
        if self.closeUIAudioId == nil then
            self.closeUIAudioId = CS.Cfg_GlobalTableManager.Instance.CloseUIAudioId
        end
        if self.closeUIAudioId and self.closeUIAudioId ~= -1 then
            self:PlayAudio(self.closeUIAudioId)
        end
    end
end

---播放音效
function UIManager:PlayAudio(audioID)
    ---0.8s内拒绝连续播放音效
    if self.playAudioTime == nil then
        self.playAudioTime = CS.Cfg_GlobalTableManager.Instance.PlayAudioTime
    end
    if self.playAudioTime == nil or self.playAudioTime == -1 then
        self.playAudioTime = 0.8
    end
    if self.LastPlayAudioTime then
        local nowTime = CS.UnityEngine.Time.time
        local desTime = nowTime - self.LastPlayAudioTime
        if desTime < self.playAudioTime then
            return
        end
    end
    self.LastPlayAudioTime = CS.UnityEngine.Time.time
    if CS.CSAudioMgr.Instance ~= nil then
        CS.CSAudioMgr.Instance:Play(true, audioID, 0, 1, false)
    end
end

---播放界面开关音效
---@param audioID number Sounds表ID
function UIManager:PlayAuid(audioID)
    if (CS.CSAudioMgr.Instance) then
        local isfind, sounds = CS.Cfg_SoundsTableManager.Instance:TryGetValue(audioID)
        if isfind then
            CS.CSAudioMgr.Instance:Play(CS.EAudioType.UI, false, sounds.sound);
        end
    end
end

---每帧执行
function UIManager:OnUpdate(timeInterval)
    self.mCurrentFrame = CS.UnityEngine.Time.frameCount
    self:GetUICacheLogic():OnUpdate(timeInterval)
    self:TryDealWaitForCloseList()
end

function UIManager:TryDealWaitForCloseList()
    if self.mWaitForCloseListIsDirty ~= true then
        return
    end
    self.mWaitForCloseListIsDirty = false
    for i, v in pairs(self.mWaitForCloseList) do
        self:ClosePanel(v, true)
    end
    self.mWaitForCloseList = {}
end

--[[******************************************************CS中的UI界面**************************************************]]
---在CS中用UIManager.Instance.CreatePanelByType创建界面
---@param panelType string type类型
---@param justPush boolean bool类型
---@param obj UnityEngine.Object Object类型
---@param isHasAudio boolean bool类型
---@param action function Action<UIBase>类型
function UIManager:CreatePanelInCS(panelType, justPush, obj, isHasAudio, action)
    CS.GenericsExtensionMethods.CreatePanel(panelType, justPush, obj, isHasAudio, action)
end

---获取CS中创建的UI界面
---@param panelType string 界面类型
---@return table CS中创建的UI界面,为CS的UIBase类型
function UIManager:GetPanelInCS(panelType)
    local panel
    panel = CS.GenericsExtensionMethods.GetPanel(panelType)
    return panel
end

---判断界面是否存在
---@return boolean 界面是否存在
function UIManager:IsPanelInCS(panelType)
    return CS.GenericsExtensionMethods.IsPanel(panelType)
end

---关闭CS中的界面
---界面必须继承UIBase
---@param panelType string
function UIManager:ClosePanelInCS(panelType)
    local panel = UIManager:GetPanelInCS(panelType)
    if (panel and CS.StaticUtility.IsNull(panel) == false) then
        panel:OnClickBox(nil)
    end
end

---关闭界面遮罩
function UIManager:TryClosePanelMask(uiPanel)

    --region 关闭界面遮罩
    --if (uiPanel.PanelLayerType == CS.UILayerType.WindowsPlane) then
    local transform = CS.UILayerMgr.Instance:GetLayerObj(CS.UILayerType.WindowsPlane);
    if CS.StaticUtility.IsNull(transform) then
        return
    end
    local childCount = transform.childCount;
    local count = childCount;
    if (childCount > 0) then
        for i = 0, childCount - 1, 1 do
            if (UIManager.UIGameObjects[transform:GetChild(i).name] == nil or not transform:GetChild(i).gameObject.activeSelf) then
                count = count - 1;
            end
        end
    end
    if (count == 0) then
        CS.CSUIMaskManager:GetInstance():TryCloseMask("UIMainMenusPanel");
    end
    --end

    --region 界面关闭刷新遮罩状态
    if (uiPanel ~= nil) then
        CS.CSUIMaskManager:GetInstance():UpdateMaskOnClosePanel(uiPanel._PanelName);
    end
    --endregion

    --endregion
end

---打开界面遮罩
function UIManager:TryOpenPanelMask(uiPanel)
    ---停用界面遮罩逻辑

    if (uiPanel == nil) then
        return ;
    end


    --region 打开界面遮罩
    if (uiPanel.PanelLayerType == CS.UILayerType.WindowsPlane) then
        CS.CSUIMaskManager:GetInstance():TryOpenMask("UIMainMenusPanel");
    end

    --region 界面打开刷新遮罩状态
    CS.CSUIMaskManager:GetInstance():UpdateMaskOnOpenPanel(uiPanel._PanelName);
    --endregion
    --endregion
end

---判断是否开启(cfg_conditions)
---@param conditionId number cfg_conditions id字段
function UIManager:IsOpenWithKey(conditionId)
    local isGetTable, conditionTable = CS.Cfg_ConditionManager.Instance:TryGetValue(conditionId);
    if isGetTable then
        local isOpen = true;
        local curValue = 0;
        local targetValue = 0;
        if (isGetTable) then
            isOpen, curValue, targetValue = self:IsMeetingConditions(conditionTable.conditionType, conditionTable.conditionParam.list[0]);
        end
        return isOpen, conditionTable.show, targetValue, curValue;
    end
end

function UIManager:IsMeetingConditions(conditionKeyType, targetValue)
    local isMeeting = true;
    local curValue = 0;
    if (conditionKeyType == LuaEnumConditionKeyType.GreatePlayerLevel) then
        curValue = CS.CSScene.MainPlayerInfo.Level;
        if (not (curValue >= targetValue)) then
            isMeeting = false;
        end
    elseif (conditionKeyType == LuaEnumConditionKeyType.LessPlayerLevel) then
        curValue = CS.CSScene.MainPlayerInfo.Level;
        if (not (curValue < targetValue)) then
            isMeeting = false;
        end
    elseif (conditionKeyType == LuaEnumConditionKeyType.GreatReincarnationLevel) then
        curValue = CS.CSScene.MainPlayerInfo.ReinLevel
        if (not (curValue >= targetValue)) then
            isMeeting = false;
        end
    elseif (conditionKeyType == LuaEnumConditionKeyType.LessReincarnationLevel) then
        curValue = CS.CSScene.MainPlayerInfo.ReinLevel;
        if (not (CS.CSScene.MainPlayerInfo.ReinLevel < targetValue)) then
            isMeeting = false;
        end
    elseif (conditionKeyType == LuaEnumConditionKeyType.FixedTimeSecond) then
        --local strs = string.Split(targetValueStr, "#");
        --local index = 0;
        --for k, v in pairs(strs) do
        --    targetValue[index] = tonumber(v);
        --    index = index + 1;
        --end
        --local now = os.time();
        --local now_date = os.date("*t", now);
        --local Today_Begin_Time = os.time { year = now_date.year, month = now_date.month, day = now_date.day, hour = 0, min = 0, sec = 0 };
        --local DifferenceValue = Today_Begin_Time - now;
        --if not (DifferenceValue >= targetValue[0] and DifferenceValue <= targetValue[1]) then
        --    isMeeting = false;
        --end
    elseif (conditionKeyType == LuaEnumConditionKeyType.NeedTimeMinutes) then
    elseif (conditionKeyType == LuaEnumConditionKeyType.NeedOfficialState) then
        if (gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo() == nil or gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable() == nil) then
            isMeeting = false
        else
            local level = gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():GetCurOfficialTable():GetId()
            if (level >= targetValue) then
                isMeeting = true
            else
                isMeeting = false
            end
        end
        --elseif(还有好多  用到再加)
    end
    return isMeeting, curValue, targetValue;
end

function UIManager:GetChildCountByUILayer(uiLayer)
    local transform = CS.UILayerMgr.Instance:GetLayerObj(uiLayer);
    local childCount = transform.childCount;
    local count = childCount;
    if (childCount > 0) then
        for i = 0, childCount - 1, 1 do
            if (UIManager.UIGameObjects[transform:GetChild(i).name] == nil or not transform:GetChild(i).gameObject.activeSelf) then
                count = count - 1;
            end
        end
    end
    return count
end

---判断是否满足开启条件 返回： 功能是否开启 未开启时是否需要隐藏
---@param id number 系统固定ID cfg_notice
function UIManager:IsCondition(id)
    if id == nil then
        return
    end
    local isOpen = CS.CSSystemController.Sington:CheckSystem(id)
    local isHide = CS.CSSystemController.Sington:ChecNeedkHide(id)
    return isOpen, isHide
end

return UIManager