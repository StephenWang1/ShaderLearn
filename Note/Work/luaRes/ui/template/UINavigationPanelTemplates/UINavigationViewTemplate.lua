---@class UINavigationViewTemplate:TemplateBase
local UINavigationViewTemplate = {};

UINavigationViewTemplate.mSelectMenuLayer = nil;

---显示状态  0:关闭 1:打开
UINavigationViewTemplate.mShowState = 0;

---关闭导航栏的方式 0:普通关闭, 1:界面关闭 , 2:事件命令关闭
UINavigationViewTemplate.mCloseState = 0;

UINavigationViewTemplate.mCurSelectData = nil;

---跳转目标
UINavigationViewTemplate.mGoToTargetData = nil;

UINavigationViewTemplate.mOpenPanelNames = {};

---关闭导航栏回调
UINavigationViewTemplate.mCloseShowCallBack = nil;

---打开回调
UINavigationViewTemplate.mOpenCallBack = nil;

UINavigationViewTemplate.mReOpenLevel = 80;

UINavigationViewTemplate.mOpenPanelParameters = {};

--region GameObject
---一级菜单物体
---@return UnityEngine.GameObject
function UINavigationViewTemplate:GetFirstMenu_GameObject()
    if (self.mFirstMenu_GameObject == nil) then
        self.mFirstMenu_GameObject = self:Get("Tag0", "GameObject");
    end
    return self.mFirstMenu_GameObject;
end

---二级菜单物体
---@return UnityEngine.GameObject
function UINavigationViewTemplate:GetSecondMenu_GameObject()
    if (self.mSecondMenu_GameObject == nil) then
        self.mSecondMenu_GameObject = self:Get("Tag1", "GameObject");
    end
    return self.mSecondMenu_GameObject;
end

---三级菜单物体
---@return UnityEngine.GameObject
function UINavigationViewTemplate:GetThirdMenu_GameObject()
    if (self.mThirdMenu_GameObject == nil) then
        self.mThirdMenu_GameObject = self:Get("Tag2", "GameObject");
    end
    return self.mThirdMenu_GameObject;
end

---打开导航按钮
---@return UnityEngine.GameObject
function UINavigationViewTemplate:GetBtnOpen_GameObject()
    if (self.mBtnOpen_GameObject == nil) then
        self.mBtnOpen_GameObject = self:Get("events/btn_open", "GameObject");
    end
    return self.mBtnOpen_GameObject;
end

---关闭导航按钮
---@return UnityEngine.GameObject
function UINavigationViewTemplate:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:Get("events/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

--endregion

--region Tween
---一级菜单位置Tween动画
---@return TweenPosition
function UINavigationViewTemplate:GetFirstMenu_TweenPosition()
    if (self.mFirstMenu_TweenPosition == nil) then
        self.mFirstMenu_TweenPosition = self:Get("Tag0", "TweenPosition");
    end
    return self.mFirstMenu_TweenPosition;
end

---一级菜单透明度Tween动画
---@return TweenAlpha
function UINavigationViewTemplate:GetFirstMenu_TweenAlpha()
    if (self.mFirstMenu_TweenAlpha == nil) then
        self.mFirstMenu_TweenAlpha = self:Get("Tag0", "TweenAlpha");
    end
    return self.mFirstMenu_TweenAlpha;
end

---二级菜单位置Tween动画
---@return TweenPosition
function UINavigationViewTemplate:GetSecondMenu_TweenPosition()
    if (self.mSecondMenu_TweenPosition == nil) then
        self.mSecondMenu_TweenPosition = self:Get("Tag1", "TweenPosition");
    end
    return self.mSecondMenu_TweenPosition;
end

---二级菜单透明度Tween动画
---@return TweenAlpha
function UINavigationViewTemplate:GetSecondMenu_TweenAlpha()
    if (self.mSecondMenu_TweenAlpha == nil) then
        self.mSecondMenu_TweenAlpha = self:Get("Tag1", "TweenAlpha");
    end
    return self.mSecondMenu_TweenAlpha;
end

---三级菜单位置Tween动画
---@return TweenPosition
function UINavigationViewTemplate:GetThirdMenu_TweenPosition()
    if (self.mThirdMenu_TweenPosition == nil) then
        self.mThirdMenu_TweenPosition = self:Get("Tag2", "TweenPosition");
    end
    return self.mThirdMenu_TweenPosition;
end

---三级菜单透明度Tween动画
---@return TweenAlpha
function UINavigationViewTemplate:GetThirdMenu_TweenAlpha()
    if (self.mThirdMenu_TweenAlpha == nil) then
        self.mThirdMenu_TweenAlpha = self:Get("Tag2", "TweenAlpha");
    end
    return self.mThirdMenu_TweenAlpha;
end

function UINavigationViewTemplate:GetRedPointComponent()
    if (self.mRedPointComponent == nil) then
        self.mRedPointComponent = self:Get("events/btn_open/redpoint", "UIRedPoint")
    end
    return self.mRedPointComponent;
end

--endregion

--region 模板
---一级菜单模板
---@return UINavigationFirstMenuViewTemplate
function UINavigationViewTemplate:GetFirstMenuViewTemplate()
    if (self.mFirstMenuViewTemplate == nil) then
        self.mFirstMenuViewTemplate = templatemanager.GetNewTemplate(self:GetFirstMenu_GameObject(), luaComponentTemplates.UINavigationFirstMenuViewTemplate);
    end
    return self.mFirstMenuViewTemplate;
end

---二级菜单模板
---@return UINavigationSecondMenuViewTemplate
function UINavigationViewTemplate:GetSecondMenuViewTemplate()
    if (self.mSecondMenuViewTemplate == nil) then
        self.mSecondMenuViewTemplate = templatemanager.GetNewTemplate(self:GetSecondMenu_GameObject(), luaComponentTemplates.UINavigationSecondMenuViewTemplate);
    end
    return self.mSecondMenuViewTemplate;
end

---三级菜单模板
---@return UINavigationThirdMenuViewTemplate
function UINavigationViewTemplate:GetThirdMenuViewTemplate()
    if (self.mThirdMenuViewTemplate == nil) then
        self.mThirdMenuViewTemplate = templatemanager.GetNewTemplate(self:GetThirdMenu_GameObject(), luaComponentTemplates.UINavigationThirdMenuViewTemplate);
    end
    return self.mThirdMenuViewTemplate;
end
--endregion

---客户端事件分发
---@return EventHandlerManager
function UINavigationViewTemplate:GetClientEventHandler()
    if (self.mClientHandler == nil) then
        self.mClientHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    end
    return self.mClientHandler;
end
--region Method

--region Public
---初始化
---@param CloseCallBack 关闭回调
---@param OpenPanelCallBack 导航栏打开一个界面回调
---@param ReOpenFirstMenuCallBack 关闭之后重新开启一级菜单回调
function UINavigationViewTemplate:Initialize(OpenCallBack, CloseCallBack, firstMenuFadeInCallBack)
    self.mOpenPanelNames = {};
    self.mOpenCallBack = OpenCallBack;
    self.mCloseShowCallBack = CloseCallBack;
    self.mFirstMenuFadeInCallBack = firstMenuFadeInCallBack;
    local isFind, tableValue = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20250);
    self.mReOpenLevel = isFind and tonumber(tableValue.value) or 80;

    self.mFirstMenuFadeInIsEnd = true;
    self.mFirstMenuFadeOutIsEnd = true;
    self.mSecondMenuFadeInIsEnd = true;
    self.mSecondMenuFadeOutIsEnd = true;
    self.mThirdMenuFadeInIsEnd = true;
    self.mThirdMenuFadeOutIsEnd = true;

    self.mFirstMenuFadeInAllIsEnd = true;
    self.mSecondMenuFadeInAllIsEnd = true;
    self.mThirdMenuFadeInAllIsEnd = true;
end

function UINavigationViewTemplate:GetButtonByNavId(navId)
    local isGetValue, tableValue = CS.Cfg_NavigationTableManager.Instance:TryGetValue(navId);
    if (isGetValue) then
        if (tableValue.layer == LuaEnumNavMenusLayer.First) then
            return self:GetFirstMenuViewTemplate():GetButtonByNavId(navId)
        elseif (tableValue.layer == LuaEnumNavMenusLayer.Second) then
            return self:GetSecondMenuViewTemplate():GetButtonByNavId(navId)
        elseif (tableValue.layer == LuaEnumNavMenusLayer.Third) then
            return self:GetThirdMenuViewTemplate():GetButtonByNavId(navId)
        end
    end
    return nil;
end

---入口方法
function UINavigationViewTemplate:EnterNavigation()
    self:GetFirstMenuViewTemplate():Initialize();
    self:ShowLayer(LuaEnumNavMenusLayer.First);
end

function UINavigationViewTemplate:UpdateUnit()
    if (self.mGoToTargetData == nil) then
        self.mGoToTargetData = {};
    end
    self.mGoToTargetData[self.mCurSelectData.layer] = self.mCurSelectData;
    if (self.mCurSelectData ~= nil) then
        if (self.mCurSelectData.layer == LuaEnumNavMenusLayer.First) then
            self:GetFirstMenuViewTemplate():Initialize();
            self:OnFirstMenuFadeInFinished();
        elseif (self.mCurSelectData.layer == LuaEnumNavMenusLayer.Second) then
            local ownerList = CS.Cfg_NavigationTableManager.Instance:GetOwnerList(self.mCurSelectData.owner);
            if (ownerList ~= nil) then
                self:GetSecondMenuViewTemplate():Initialize(ownerList, self.mCurSelectData.owner);
            end
            self:OnSecondMenuFadeInFinished();
        elseif (self.mCurSelectData.layer == LuaEnumNavMenusLayer.Third) then
            local ownerList = CS.Cfg_NavigationTableManager.Instance:GetOwnerList(self.mCurSelectData.owner);
            if (ownerList ~= nil) then
                self:GetThirdMenuViewTemplate():Initialize(ownerList, self.mCurSelectData.owner);
            end
            self:OnThirdMenuFadeInFinished();
        end
    else
        self:GetFirstMenuViewTemplate():Initialize();
        self:OnFirstMenuFadeInFinished();
    end
end

---跳到id对应
--- @param customData
---customData.targetId
function UINavigationViewTemplate:Select(customData)
    if (self.mOpenPanelParameters == nil) then
        self.mOpenPanelParameters = {};
    end
    self.mOpenPanelParameters[customData.targetId] = customData;
    local targetId = customData.targetId;
    self.mGoToTargetData = {};
    local isGetValue, tableValue = CS.Cfg_NavigationTableManager.Instance:TryGetValue(targetId);
    if (isGetValue) then
        self.mGoToTargetData[tableValue.layer] = tableValue
        for i = 1, 5, 1 do
            tableValue = self:TryGetUpperLayerData(tableValue);
            if (tableValue == nil) then
                return ;
            end
            self.mGoToTargetData[tableValue.layer] = tableValue
        end
    end
end

function UINavigationViewTemplate:TryGetUpperLayerData(tableData)
    if (tableData.owner ~= nil and tableData.owner ~= 0) then
        local isFind, upperData = CS.Cfg_NavigationTableManager.Instance:TryGetValue(tableData.owner);
        if (isFind) then
            return upperData;
        end
    end
    return nil;
end

function UINavigationViewTemplate:CheckFirstMenuFadeInState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetFirstMenu_TweenPosition().duration + 0.1));
    if (not self.mFirstMenuFadeInIsEnd) then
        self:OnFirstMenuFadeInFinished();
    end
end

function UINavigationViewTemplate:CheckFirstMenuFadeOutState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetFirstMenu_TweenPosition().duration + 0.1));
    if (not self.mFirstMenuFadeOutIsEnd) then
        self.mFirstMenuFadeOutIsEnd = true;
        self:OnFirstMenuFadeOutFinished();
    end
end

function UINavigationViewTemplate:CheckSecondMenuFadeInState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetSecondMenu_TweenPosition().duration + 0.1));
    if (not self.mSecondMenuFadeInIsEnd) then
        self:OnSecondMenuFadeInFinished();
    end
end

function UINavigationViewTemplate:CheckSecondMenuFadeOutState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetSecondMenu_TweenPosition().duration + 0.1));
    if (not self.mSecondMenuFadeOutIsEnd) then
        self.mSecondMenuFadeOutIsEnd = true;
        self:OnSecondMenuFadeOutFinished();
    end
end

function UINavigationViewTemplate:CheckThirdMenuFadeInState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetThirdMenu_TweenPosition().duration + 0.1));
    if (not self.mThirdMenuFadeInIsEnd) then
        self.mThirdMenuFadeInIsEnd = true;
        self:OnThirdMenuFadeInFinished();
    end
end

function UINavigationViewTemplate:CheckThirdMenuFadeOutState()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self:GetThirdMenu_TweenPosition().duration + 0.1));
    if (not self.mThirdMenuFadeOutIsEnd) then
        self.mThirdMenuFadeOutIsEnd = true;
        self:OnThirdMenuFadeOutFinished();
    end
end

function UINavigationViewTemplate:PlayFirstMenuFadeIn()
    self.mFirstMenuFadeInIsEnd = false;
    self.mFirstMenuFadeInAllIsEnd = false;
    self:GetFirstMenu_TweenPosition():SetOnFinished(function()
        self:OnFirstMenuFadeInFinished();
    end);

    if (self.mFirstMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mFirstMenuFadeInCoroutine);
        self.mFirstMenuFadeInCoroutine = nil
    end
    self.mFirstMenuFadeInCoroutine = StartCoroutine(self.CheckFirstMenuFadeInState, self);

    local pos = self:GetFirstMenu_GameObject().transform.localPosition
    local originPosition = CS.UnityEngine.Vector3(0, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(-235, originPosition.y, originPosition.z);
    self:GetFirstMenu_TweenPosition().from = originPosition;
    self:GetFirstMenu_TweenPosition().to = endPosition;

    local originAlpha = 0;
    local endAlpha = 1;
    self:GetFirstMenu_TweenAlpha().from = originAlpha;
    self:GetFirstMenu_TweenAlpha().to = endAlpha;

    self:GetFirstMenu_TweenPosition():PlayTween();
    self:GetFirstMenu_TweenAlpha():PlayTween();
end

function UINavigationViewTemplate:PlayFirstMenuFadeOut()
    self.mFirstMenuFadeOutIsEnd = false;
    self:GetFirstMenu_TweenPosition():SetOnFinished(function()
        self.mFirstMenuFadeOutIsEnd = true;
        self:OnFirstMenuFadeOutFinished();
    end);

    if (self.mFirstMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mFirstMenuFadeOutCoroutine);
        self.mFirstMenuFadeOutCoroutine = nil
    end
    self.mFirstMenuFadeOutCoroutine = StartCoroutine(self.CheckFirstMenuFadeOutState, self);

    local pos = self:GetFirstMenu_GameObject().transform.localPosition
    local originPosition = CS.UnityEngine.Vector3(-235, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(0, originPosition.y, originPosition.z);
    self:GetFirstMenu_TweenPosition().from = originPosition;
    self:GetFirstMenu_TweenPosition().to = endPosition;

    local originAlpha = 1;
    local endAlpha = 0;
    self:GetFirstMenu_TweenAlpha().from = originAlpha;
    self:GetFirstMenu_TweenAlpha().to = endAlpha;

    self:GetFirstMenu_TweenPosition():PlayTween();
    self:GetFirstMenu_TweenAlpha():PlayTween();
end

function UINavigationViewTemplate:PlaySecondMenuFadeIn()
    self.mSecondMenuFadeInIsEnd = false;
    self.mSecondMenuFadeInAllIsEnd = false;
    self:GetSecondMenu_TweenPosition():SetOnFinished(function()
        self:OnSecondMenuFadeInFinished();
    end);

    if (self.mSecondMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mSecondMenuFadeInCoroutine);
        self.mSecondMenuFadeInCoroutine = nil
    end
    self.mSecondMenuFadeInCoroutine = StartCoroutine(self.CheckSecondMenuFadeInState, self);

    local pos = self:GetSecondMenu_GameObject().transform.localPosition;
    local originPosition = CS.UnityEngine.Vector3(0, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(-235, pos.y, pos.z);
    self:GetSecondMenu_TweenPosition().from = originPosition;
    self:GetSecondMenu_TweenPosition().to = endPosition;

    local originAlpha = 0;
    local endAlpha = 1;
    self:GetSecondMenu_TweenAlpha().from = originAlpha;
    self:GetSecondMenu_TweenAlpha().to = endAlpha;

    self:GetSecondMenu_TweenPosition():PlayTween();
    self:GetSecondMenu_TweenAlpha():PlayTween();
end

function UINavigationViewTemplate:PlaySecondMenuFadeOut()
    self.mSecondMenuFadeOutIsEnd = false;
    self:GetSecondMenu_TweenPosition():SetOnFinished(function()
        self.mSecondMenuFadeOutIsEnd = true;
        self:OnSecondMenuFadeOutFinished();
    end);

    if (self.mSecondMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mSecondMenuFadeOutCoroutine);
        self.mSecondMenuFadeOutCoroutine = nil
    end
    self.mSecondMenuFadeOutCoroutine = StartCoroutine(self.CheckSecondMenuFadeOutState, self);

    local pos = self:GetSecondMenu_GameObject().transform.localPosition;
    local originPosition = CS.UnityEngine.Vector3(-235, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(0, originPosition.y, originPosition.z);
    self:GetSecondMenu_TweenPosition().from = originPosition;
    self:GetSecondMenu_TweenPosition().to = endPosition;

    local originAlpha = 0;
    local endAlpha = 1;
    self:GetSecondMenu_TweenAlpha().from = originAlpha;
    self:GetSecondMenu_TweenAlpha().to = endAlpha;

    self:GetSecondMenu_TweenPosition():PlayTween();
    self:GetSecondMenu_TweenAlpha():PlayTween();
end

function UINavigationViewTemplate:PlayThirdMenuFadeIn()
    self.mThirdMenuFadeInIsEnd = false;
    self.mThirdMenuFadeInAllIsEnd = false;
    self:GetThirdMenu_TweenPosition():SetOnFinished(function()
        self.mThirdMenuFadeInIsEnd = true;
        self:OnThirdMenuFadeInFinished();
    end);

    if (self.mThirdMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mThirdMenuFadeInCoroutine);
        self.mThirdMenuFadeInCoroutine = nil
    end
    self.mThirdMenuFadeInCoroutine = StartCoroutine(self.CheckThirdMenuFadeInState, self);

    self:GetThirdMenu_GameObject():SetActive(true);
    local pos = self:GetSecondMenu_GameObject().transform.localPosition;
    local originPosition = CS.UnityEngine.Vector3(pos.x, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(-320, pos.y, pos.z);
    self:GetThirdMenu_TweenPosition().from = originPosition;
    self:GetThirdMenu_TweenPosition().to = endPosition;

    local originAlpha = 0;
    local endAlpha = 1;
    self:GetThirdMenu_TweenAlpha().from = originAlpha;
    self:GetThirdMenu_TweenAlpha().to = endAlpha;

    self:GetThirdMenu_TweenPosition():PlayTween();
    self:GetThirdMenu_TweenAlpha():PlayTween();
end

function UINavigationViewTemplate:PlayThirdMenuFadeOut()
    self.mThirdMenuFadeOutIsEnd = false;
    self:GetThirdMenu_TweenPosition():SetOnFinished(function()
        self.mThirdMenuFadeOutIsEnd = true;
        self:OnThirdMenuFadeOutFinished();
    end);

    if (self.mThirdMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mThirdMenuFadeOutCoroutine);
        self.mThirdMenuFadeOutCoroutine = nil
    end
    self.mThirdMenuFadeOutCoroutine = StartCoroutine(self.CheckThirdMenuFadeOutState, self);

    local pos = self:GetSecondMenu_GameObject().transform.localPosition;
    local originPosition = CS.UnityEngine.Vector3(-320, pos.y, pos.z);
    local endPosition = CS.UnityEngine.Vector3(-235, pos.y, pos.z);
    self:GetThirdMenu_TweenPosition().from = originPosition;
    self:GetThirdMenu_TweenPosition().to = endPosition;

    local originAlpha = 1;
    local endAlpha = 0;
    self:GetThirdMenu_TweenAlpha().from = originAlpha;
    self:GetThirdMenu_TweenAlpha().to = endAlpha;

    self:GetThirdMenu_TweenPosition():PlayTween();
    self:GetThirdMenu_TweenAlpha():PlayTween();
end
--endregion

--region Private

function UINavigationViewTemplate:ShowLayer(targetLayer)
    self.mShowState = 1;
    local lastLayer = self.mSelectMenuLayer;
    self.mSelectMenuLayer = targetLayer;
    if (lastLayer ~= nil) then
        if (targetLayer == lastLayer) then
            if (targetLayer == LuaEnumNavMenusLayer.First) then
                self:OnFirstMenuFadeInFinished();
            elseif (lastLayer == LuaEnumNavMenusLayer.Second) then
                self:OnSecondMenuFadeInFinished();
            elseif (lastLayer == LuaEnumNavMenusLayer.Third) then
                self:OnThirdMenuFadeInFinished();
            end
        elseif (targetLayer == LuaEnumNavMenusLayer.First) then
            if (lastLayer == LuaEnumNavMenusLayer.Second) then
                self:PlaySecondMenuFadeOut();
            elseif (lastLayer == LuaEnumNavMenusLayer.First) then
                self:OnFirstMenuFadeInFinished();
            end
        elseif (targetLayer == LuaEnumNavMenusLayer.Second) then
            if (lastLayer == LuaEnumNavMenusLayer.First) then
                self:PlayFirstMenuFadeOut();
            elseif (lastLayer == LuaEnumNavMenusLayer.Second) then
                self:OnSecondMenuFadeInFinished();
            end
        elseif (targetLayer == LuaEnumNavMenusLayer.Third) then
            if (lastLayer == LuaEnumNavMenusLayer.Second) then
                self:PlayThirdMenuFadeIn();
            elseif (lastLayer == LuaEnumNavMenusLayer.Third) then
                self:PlayThirdMenuFadeIn();
            end
        end
    else
        if (targetLayer == LuaEnumNavMenusLayer.First) then
            self:PlayFirstMenuFadeIn();
        else
            self:PlaySecondMenuFadeIn();
        end
    end
end

function UINavigationViewTemplate:CloseShow(closeState)
    if (not self:TryCloseOtherPanelInCache()) then
        return ;
    end
    if closeState == nil then
        closeState = 0;
    end
    self.mCloseState = closeState;
    self.mCurSelectData = nil;
    self.mShowState = 0;

    if (self.mSelectMenuLayer == LuaEnumNavMenusLayer.First) then
        self:PlayFirstMenuFadeOut();
    elseif (self.mSelectMenuLayer == LuaEnumNavMenusLayer.Second) then
        self:PlaySecondMenuFadeOut();
    elseif (self.mSelectMenuLayer == LuaEnumNavMenusLayer.Third) then
        self:PlayThirdMenuFadeOut();
    end
end

function UINavigationViewTemplate:RestParameter()
    self.mSelectMenuLayer = nil;
    ---显示状态  0:关闭 1:打开
    self.mShowState = 0;
    ---关闭导航栏的方式 0:关闭按钮, 1:界面关闭
    self.mCloseState = 0;
    self.mCurSelectData = nil;
    self.mGoToTargetData = nil;
end

function UINavigationViewTemplate:GetJumpLayerTargetId(layerType)
    local targetId = nil;
    if (self.mGoToTargetData ~= nil and self.mGoToTargetData[layerType] ~= nil) then
        targetId = self.mGoToTargetData[layerType].ID
        self.mGoToTargetData[layerType] = nil;
    end
    return targetId;
end

function UINavigationViewTemplate:OnEndFinished()
    self:RestParameter();
    if (self.mCloseShowCallBack ~= nil) then
        self.mCloseShowCallBack();
    end
end

function UINavigationViewTemplate:TryOpenPanel(tableData)
    local isSuccess = false;
    if tableData ~= nil then
        if (tableData.panels ~= nil and tableData.panels ~= "") then
            self:CreatePanels(tableData);
            isSuccess = true;
        end
    end
    return isSuccess;
end

function UINavigationViewTemplate:TryRemovePanelInCache(panelName)
    for k, v in pairs(self.mOpenPanelNames) do
        if (v == panelName) then
            table.remove(self.mOpenPanelNames, k);
            return true;
        end
    end
    return false;
end

function UINavigationViewTemplate:TryCloseOtherPanelInCache(panelName)
    for k1, v1 in pairs(self.mOpenPanelNames) do
        if (v1 ~= panelName) then
            --local panel = uimanager:GetPanel(v1);
            --if(panel ~= nil) then
            --    for k2,v2 in pairs(panel:GetRelationPanels()) do
            --        local relationPanel = uimanager:GetPanel(v2);
            --        if(relationPanel ~= nil) then
            --            if(relationPanel._PanelState == LuaEnumUIState.NotYetInitialized) then
            --                return false;
            --            end
            --        end
            --    end
            --    uimanager:ClosePanel(v1);
            --else
            --    return false;
            --end
            uimanager:ClosePanel(v1);
        end
    end
    return true;
end

function UINavigationViewTemplate:CreatePanels(tableData)
    if tableData == nil then
        return
    end
    self:GetBtnClose_GameObject():SetActive(false);
    local isFind, navTable = CS.Cfg_NavigationTableManager.Instance:TryGetValue(tableData.ID)
    if isFind then
        local hasPanel = false;
        local transferId = tonumber(navTable.panels);
        if (transferId ~= nil) then
            local isFind, transferTable = CS.Cfg_JumpUITableManager.Instance:TryGetValue(transferId);
            if (isFind) then
                local panelName = uiTransferManager:GetPanelName(transferTable);
                for k, v in pairs(self.mOpenPanelNames) do
                    if (v == panelName) then
                        hasPanel = true;
                        break ;
                    end
                end
                if (not hasPanel) then
                    table.insert(self.mOpenPanelNames, panelName);
                end
                self:TryCloseOtherPanelInCache(panelName);
                local customData = self.mOpenPanelParameters[tableData.ID];

                uiTransferManager:TransferCreatePanel(transferTable, customData, function(panelName)
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenPanelFinished, panelName);
                end);
                self.mOpenPanelParameters[tableData.ID] = nil;
            else
                if CS.CSDebug.developerConsoleVisible then
                    CS.CSDebug.LogError("系统跳转表没有配置此ID：" .. transferId)
                end
            end
        else
            if CS.CSDebug.developerConsoleVisible then
                CS.CSDebug.LogError("导航栏表panels参数异常：" .. navTable.panels);
            end
        end
    end
end

function UINavigationViewTemplate:InitEvents()
    self.CallOnClickNavigationButtonUnit = function(msgId, tableData)
        if (self.mShowState == 1) then
            self:OnClickNavigationButtonUnit(tableData);
        end
    end

    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnClickUnit, self.CallOnClickNavigationButtonUnit)
    end

    self.CallOnClosePanel = function(msgId, panelName)
        if (self:TryRemovePanelInCache(panelName)) then
            if (self.mCloseState ~= 2 and #self.mOpenPanelNames == 0) then
                self:CloseShow(0);
            end
        end
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, self.CallOnClosePanel);

    CS.UIEventListener.Get(self:GetBtnOpen_GameObject()).onClick = function()
        self:OnClickBtnOpen();
    end;
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        if (self.mFirstMenuFadeInAllIsEnd and self.mFirstMenuFadeOutIsEnd and
                self.mSecondMenuFadeInAllIsEnd and self.mSecondMenuFadeOutIsEnd and
                self.mThirdMenuFadeInAllIsEnd and self.mThirdMenuFadeOutIsEnd) then
            self:OnClickCloseBtn();
        end
    end;

end

---此处对红点进行追加，预设上也存在红点添加所以不能清理
function UINavigationViewTemplate:InitRedPoint()
    --因为有些红点需要判断主角是否满足条件, 所以此处添加要等主角信息初始化之后
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM));
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX));
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC));
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM_MagicWeapon));
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX_MagicWeapon));
    --self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC_MagicWeapon));
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Strength_All));
    local key = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey();
    self:GetRedPointComponent():AddRedPointKey(key);

    local BloodSuit_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_All);
    self:GetRedPointComponent():AddRedPointKey(BloodSuit_All)
    local ForgeGodPowerSmelt_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All)
    self:GetRedPointComponent():AddRedPointKey(ForgeGodPowerSmelt_All)
    local Equip_Proficient = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Equip_Proficient)
    self:GetRedPointComponent():AddRedPointKey(Equip_Proficient)
    local QiShuSkill = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.QiShuSkill)
    self:GetRedPointComponent():AddRedPointKey(QiShuSkill)
    local XianZhuangPush = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.XianZhuangPush)
    self:GetRedPointComponent():AddRedPointKey(XianZhuangPush)
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ZhenFa))
    local JianDingRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint)
    self:GetRedPointComponent():AddRedPointKey(JianDingRedPoint)
    local ForgeQuenchRedPoint = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetRedPointKey(nil, 1)
    self:GetRedPointComponent():AddRedPointKey(ForgeQuenchRedPoint)
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo))
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_YuPei))
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MiBao))
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi))
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin))
    self:GetRedPointComponent():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MianSha))
end

function UINavigationViewTemplate:RemoveEvents()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OnClickUnit, self.CallOnClickNavigationButtonUnit)
    end
    self:GetClientEventHandler():UnRegAll()

    --region 清除协程
    if (self.mFirstMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mFirstMenuFadeInCoroutine);
        self.mFirstMenuFadeInCoroutine = nil
    end
    if (self.mFirstMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mFirstMenuFadeOutCoroutine);
        self.mFirstMenuFadeOutCoroutine = nil
    end
    if (self.mSecondMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mSecondMenuFadeInCoroutine);
        self.mSecondMenuFadeInCoroutine = nil
    end
    if (self.mSecondMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mSecondMenuFadeOutCoroutine);
        self.mSecondMenuFadeOutCoroutine = nil
    end
    if (self.mThirdMenuFadeInCoroutine ~= nil) then
        StopCoroutine(self.mThirdMenuFadeInCoroutine);
        self.mThirdMenuFadeInCoroutine = nil
    end
    if (self.mThirdMenuFadeOutCoroutine ~= nil) then
        StopCoroutine(self.mThirdMenuFadeOutCoroutine);
        self.mThirdMenuFadeOutCoroutine = nil
    end
    --endregion
end

--endregion

--region CallFunction

function UINavigationViewTemplate:OnFirstMenuFadeInFinished()
    self.mFirstMenuFadeInIsEnd = true;
    if (self.mFirstMenuFadeInCallBack ~= nil) then
        self.mFirstMenuFadeInCallBack();
    end
    self:GetFirstMenuViewTemplate():OnFadeInFinished();

    local targetId = self:GetJumpLayerTargetId(LuaEnumNavMenusLayer.First);
    self:GetFirstMenuViewTemplate():PlayUnitListFadeIn(targetId, function()
        self.mFirstMenuFadeInAllIsEnd = true;
        self:GetBtnClose_GameObject():SetActive(true);
    end);
end

function UINavigationViewTemplate:OnFirstMenuFadeOutFinished()
    self:GetBtnClose_GameObject():SetActive(true);
    if (self.mShowState == 0) then
        self:OnEndFinished();
    else
        if (self.mSelectMenuLayer == LuaEnumNavMenusLayer.First) then
            self:PlayFirstMenuFadeIn()
        elseif (self.mSelectMenuLayer == LuaEnumNavMenusLayer.Second) then
            self:PlaySecondMenuFadeIn();
        elseif (self.mSelectMenuLayer == LuaEnumNavMenusLayer.Third) then
            self:PlaySecondMenuFadeIn();
        else
            self:PlaySecondMenuFadeIn();
        end
    end

    self:GetFirstMenuViewTemplate():OnFadeOutFinished();
end

function UINavigationViewTemplate:OnSecondMenuFadeInFinished()
    self.mSecondMenuFadeInIsEnd = true;
    self:GetSecondMenuViewTemplate():OnFadeInFinished();

    local targetId = self:GetJumpLayerTargetId(LuaEnumNavMenusLayer.Second);
    self:GetSecondMenuViewTemplate():PlayUnitListFadeIn(targetId, function()
        self.mSecondMenuFadeInAllIsEnd = true;
        self:GetBtnClose_GameObject():SetActive(true);
    end);
end

function UINavigationViewTemplate:OnSecondMenuFadeOutFinished()
    --if(self.mSecondMenuTweenState == FadeAnimationState.Out) then
    --    return;
    --end
    --self.mSecondMenuTweenState = FadeAnimationState.Out;
    self:GetBtnClose_GameObject():SetActive(true);
    if (self.mShowState == 0) then
        if (self.mCloseState == 1) then
            ---回弹一级界面
            --local mLevel = CS.CSScene.MainPlayerInfo == nil and 0 or CS.CSScene.MainPlayerInfo.Level;
            --if (mLevel >= self.mReOpenLevel) then
            --    self:OnEndFinished();
            --else
            self:RestParameter();
            self:ShowLayer(LuaEnumNavMenusLayer.First);
            self:GetBtnOpen_GameObject():SetActive(false);
            self:GetBtnClose_GameObject():SetActive(true);
            --end
        else
            ---默认关闭不处理
            self:OnEndFinished();
        end
    end

    self:GetSecondMenuViewTemplate():OnFadeOutFinished();
end

function UINavigationViewTemplate:OnThirdMenuFadeInFinished()
    --if(self.mThirdMenuTweenState == FadeAnimationState.In) then
    --    return;
    --end
    --self.mThirdMenuTweenState = FadeAnimationState.In;
    self.mThirdMenuFadeInIsEnd = true;
    self:GetThirdMenuViewTemplate():OnFadeInFinished();

    local targetId = self:GetJumpLayerTargetId(LuaEnumNavMenusLayer.Third);
    self:GetThirdMenuViewTemplate():PlayUnitListFadeIn(targetId, function()
        self.mThirdMenuFadeInAllIsEnd = true;
    end);
end

function UINavigationViewTemplate:OnThirdMenuFadeOutFinished()
    --if(self.mThirdMenuTweenState == FadeAnimationState.Out) then
    --    return;
    --end
    --self.mThirdMenuTweenState = FadeAnimationState.Out;
    if (self.mShowState == 0) then
        self:PlaySecondMenuFadeOut();
    end
    self:GetThirdMenu_GameObject():SetActive(false);
    self:GetThirdMenuViewTemplate():OnFadeOutFinished();
end

function UINavigationViewTemplate:OnClickNavigationButtonUnit(tableData)

    if (self:IsReturnButton(tableData.ID)) then
        return self:CloseShow(1);
    end

    if (self.mCurSelectData ~= nil) then
        if (self.mCurSelectData.ID == tableData.ID or CS.Cfg_NavigationTableManager.Instance:IsBelong(tableData.ID, self.mCurSelectData.ID)) then
            return ;
        end
    end
    self.mCurSelectData = tableData;
    local ownerList = nil;
    if (tableData.layer == LuaEnumNavMenusLayer.First) then
        ownerList = CS.Cfg_NavigationTableManager.Instance:GetOwnerList(tableData.ID);
        if (ownerList ~= nil) then
            self:GetSecondMenuViewTemplate():Initialize(ownerList, tableData.ID);
        end
    elseif (tableData.layer == LuaEnumNavMenusLayer.Second) then
        ownerList = CS.Cfg_NavigationTableManager.Instance:GetOwnerList(tableData.ID, tableData.ID);
        if (ownerList ~= nil) then
            self:GetThirdMenuViewTemplate():Initialize(ownerList, tableData.ID);
        end
    end
    local targetLayer = tableData.layer;
    if (ownerList ~= nil and ownerList.Count > 0) then
        targetLayer = ownerList[0].layer;
    end
    if (not self:TryOpenPanel(tableData)) then
        self:ShowLayer(targetLayer);
    else
        if (self.mSelectMenuLayer ~= nil and self.mSelectMenuLayer > targetLayer) then
            if (self.mSelectMenuLayer == LuaEnumNavMenusLayer.Third) then
                self:PlayThirdMenuFadeOut();
            end
        end
        self.mSelectMenuLayer = targetLayer;
    end
end

function UINavigationViewTemplate:OnClickBtnOpen()
    self:GetBtnOpen_GameObject():SetActive(false);
    self:GetBtnClose_GameObject():SetActive(true);

    self:EnterNavigation();

    if (self.mOpenCallBack ~= nil) then
        self.mOpenCallBack();
    end
end

function UINavigationViewTemplate:OnClickCloseBtn()
    self:CloseShow(0);
end

function UINavigationViewTemplate:IsReturnButton(id)
    if (id >= 37 and id <= 41) or id == 55 then
        return true;
    end
    return false;
end

--endregion

--endregion

function UINavigationViewTemplate:Init()
    ---@type UINavigationPanel
    self.mOwnerPanel = uimanager:GetPanel("UINavigationPanel")
    self:InitEvents();
end

function UINavigationViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UINavigationViewTemplate;