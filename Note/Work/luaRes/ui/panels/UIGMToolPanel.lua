---GM工具面板
---@class UIGMToolPanel:UIBase
local UIGMToolPanel = {}

--region 局部变量
UIGMToolPanel.GMDirectiveDic = nil
UIGMToolPanel.GMDirectiveTemplates = {}
UIGMToolPanel.ItemList = {}
UIGMToolPanel.mCurChooseItem = nil
UIGMToolPanel.mLastChooseItem = nil
UIGMToolPanel.ItemTemplates = {}
UIGMToolPanel.BranchPanel = {}
--endregion

--region 组件
function UIGMToolPanel.GetDirectiveList_UIGridContainer()
    if (UIGMToolPanel.mDirectiveList == nil) then
        UIGMToolPanel.mDirectiveList = UIGMToolPanel:GetCurComp("view/GMDirective/GridList/Directive", "Top_UIGridContainer")
    end
    return UIGMToolPanel.mDirectiveList
end

function UIGMToolPanel.GetCloseBtn_GameObject()
    if (UIGMToolPanel.mCloseBtn == nil) then
        UIGMToolPanel.mCloseBtn = UIGMToolPanel:GetCurComp("events/tg_close", "GameObject")
    end
    return UIGMToolPanel.mCloseBtn
end

function UIGMToolPanel.GetGMDirective_Window()
    if (UIGMToolPanel.mGMDirective_Window == nil) then
        UIGMToolPanel.mGMDirective_Window = UIGMToolPanel:GetCurComp("view/GMDirective", "GameObject")
    end
    return UIGMToolPanel.mGMDirective_Window
end

function UIGMToolPanel.GetGMItemCreate_Window()
    if (UIGMToolPanel.mGMItemCreate_Window == nil) then
        UIGMToolPanel.mGMItemCreate_Window = UIGMToolPanel:GetCurComp("view/ItemCreate", "GameObject")
    end
    return UIGMToolPanel.mGMItemCreate_Window
end

function UIGMToolPanel.GetGMMonsterCreate_Window()
    if (UIGMToolPanel.mGMMonsterCreate_Window == nil) then
        UIGMToolPanel.mGMMonsterCreate_Window = UIGMToolPanel:GetCurComp("view/MonsterCreate", "GameObject")
    end
    return UIGMToolPanel.mGMMonsterCreate_Window
end

function UIGMToolPanel.GetModelPreview_Window()
    if (UIGMToolPanel.mModelPreview_Window == nil) then
        UIGMToolPanel.mModelPreview_Window = UIGMToolPanel:GetCurComp("view/ModelPreview", "GameObject")
    end
    return UIGMToolPanel.mModelPreview_Window
end

function UIGMToolPanel.GetGMHierarchyCreate_Window()
    if (UIGMToolPanel.mGMHierarchyCreate_Window == nil) then
        UIGMToolPanel.mGMHierarchyCreate_Window = UIGMToolPanel:GetCurComp("view/Hierarchy", "GameObject")
    end
    return UIGMToolPanel.mGMHierarchyCreate_Window
end

---@return UIToggle
function UIGMToolPanel.GetGMDirective_UIToggle()
    if (UIGMToolPanel.mGMDirective_UIToggle == nil) then
        UIGMToolPanel.mGMDirective_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_GM", "Top_UIToggle")
    end
    return UIGMToolPanel.mGMDirective_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetGMCreateItem_UIToggle()
    if (UIGMToolPanel.mGMCreateItem_UIToggle == nil) then
        UIGMToolPanel.mGMCreateItem_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_Item", "Top_UIToggle")
    end
    return UIGMToolPanel.mGMCreateItem_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetGMCreateMonster_UIToggle()
    if (UIGMToolPanel.mGMCreateMonster_UIToggle == nil) then
        UIGMToolPanel.mGMCreateMonster_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_Monster", "Top_UIToggle")
    end
    return UIGMToolPanel.mGMCreateMonster_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetModelPreview_UIToggle()
    if (UIGMToolPanel.mModelPreview_UIToggle == nil) then
        UIGMToolPanel.mModelPreview_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_ModelPreview", "Top_UIToggle")
    end
    return UIGMToolPanel.mModelPreview_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetGMLogPanel_UIToggle()
    if (UIGMToolPanel.mGMLogPanel_UIToggle == nil) then
        UIGMToolPanel.mGMLogPanel_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_LogPanel", "Top_UIToggle")
    end
    return UIGMToolPanel.mGMLogPanel_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetGMAddGUI_UIToggle()
    if (UIGMToolPanel.mGMAddGUI_UIToggle == nil) then
        UIGMToolPanel.mGMAddGUI_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_GUI", "Top_UIToggle")
    end
    return UIGMToolPanel.mGMAddGUI_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetEventBindView_UIToggle()
    if (UIGMToolPanel.mEventBindView_UIToggle == nil) then
        UIGMToolPanel.mEventBindView_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_EventBindView", "Top_UIToggle")
    end
    return UIGMToolPanel.mEventBindView_UIToggle
end

---@return UIToggle
function UIGMToolPanel.GetLoadServerResources_UIToggle()
    if (UIGMToolPanel.mtg_LoadServerResources == nil) then
        UIGMToolPanel.mtg_LoadServerResources = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_LoadServerResources", "Top_UIToggle")
    end
    return UIGMToolPanel.mtg_LoadServerResources
end

---@return UISlider
function UIGMToolPanel.GetAlphaSlider_UISlider()
    if UIGMToolPanel.mAlphaSlider == nil then
        UIGMToolPanel.mAlphaSlider = UIGMToolPanel:GetCurComp("events/sld_Alpha", "UISlider")
    end
    return UIGMToolPanel.mAlphaSlider
end

---@return UIPanel
function UIGMToolPanel:GetGMUIPanel()
    if self.mGMUIPanel == nil then
        self.mGMUIPanel = CS.Utility_Lua.Get(self.go.transform, "", "UIPanel")
    end
    return self.mGMUIPanel
end

---模型控制页签
---@return UIToggle
function UIGMToolPanel.GetModelController_UIToggle()
    if (UIGMToolPanel.mModelController_UIToggle == nil) then
        UIGMToolPanel.mModelController_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_ModelCtrl", "Top_UIToggle")
    end
    return UIGMToolPanel.mModelController_UIToggle
end

function UIGMToolPanel.GetModelControllerGameObject()
    if UIGMToolPanel.mModelControllerGO == nil then
        UIGMToolPanel.mModelControllerGO = UIGMToolPanel:GetCurComp("view/ModelControl", "GameObject")
    end
    return UIGMToolPanel.mModelControllerGO
end

---模型控制页签
---@return UIToggle
function UIGMToolPanel.GetTool_UIToggle()
    if (UIGMToolPanel.mTool_UIToggle == nil) then
        UIGMToolPanel.mTool_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_ExtendTool", "Top_UIToggle")
    end
    return UIGMToolPanel.mTool_UIToggle
end

---背包物品lid页签
---@return UIToggle
function UIGMToolPanel.GetBagItemLid_UIToggle()
    if (UIGMToolPanel.mBagItemLid_UIToggle == nil) then
        UIGMToolPanel.mBagItemLid_UIToggle = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_BagItem", "Top_UIToggle")
    end
    return UIGMToolPanel.mBagItemLid_UIToggle
end
function UIGMToolPanel.GetToolGameObject()
    if UIGMToolPanel.mToolGo == nil then
        UIGMToolPanel.mToolGo = UIGMToolPanel:GetCurComp("view/ExtendTool", "GameObject")
    end
    return UIGMToolPanel.mToolGo
end

function UIGMToolPanel.GetBagItemGameObject()
    if UIGMToolPanel.mBagItemGameObjectGo == nil then
        UIGMToolPanel.mBagItemGameObjectGo = UIGMToolPanel:GetCurComp("view/BagItem", "GameObject")
    end
    return UIGMToolPanel.mBagItemGameObjectGo
end

function UIGMToolPanel.GetTogClientRobot()
    if (UIGMToolPanel.mTogClientRobot == nil) then
        UIGMToolPanel.mTogClientRobot = UIGMToolPanel:GetCurComp("events/tgScrollView/tg_ClientRobot", "Top_UIToggle")
    end
    return UIGMToolPanel.mTogClientRobot
end

function UIGMToolPanel.GetViewClientRobot()
    if UIGMToolPanel.mViewClientRobot == nil then
        UIGMToolPanel.mViewClientRobot = UIGMToolPanel:GetCurComp("view/ClientRobotTool", "GameObject")
    end
    return UIGMToolPanel.mViewClientRobot
end

function UIGMToolPanel.GetEventStateViewGO()
    if UIGMToolPanel.mEventStateViewGO == nil then
        UIGMToolPanel.mEventStateViewGO = UIGMToolPanel:GetCurComp("view/EventStateView", "GameObject")
    end
    return UIGMToolPanel.mEventStateViewGO
end

function UIGMToolPanel.GetLoadServerResourcesGO()
    if UIGMToolPanel.mLoadServerResources == nil then
        UIGMToolPanel.mLoadServerResources = UIGMToolPanel:GetCurComp("view/LoadServerResources", "GameObject")
    end
    return UIGMToolPanel.mLoadServerResources
end

---模型控制
---
---模型控制
---@return UIGMModelControllerTemplate
function UIGMToolPanel.GetModelController()
    if UIGMToolPanel.mModelCtrlTemplate == nil then
        local mcGO = UIGMToolPanel:GetCurComp("view/ModelControl", "GameObject")
        if mcGO and mcGO:IsNull() == false then
            UIGMToolPanel.mModelCtrlTemplate = templatemanager.GetNewTemplate(mcGO, luaComponentTemplates.UIGMModelController)
        end
    end
    return UIGMToolPanel.mModelCtrlTemplate
end

---日志查看
---@return GM界面的日志查看
function UIGMToolPanel.GetLogViewer_GameObject()
    if UIGMToolPanel.mLogViewerGO == nil then
        UIGMToolPanel.mLogViewerGO = UIGMToolPanel:GetCurComp("view/LogViewer", "GameObject")
    end
    return UIGMToolPanel.mLogViewerGO
end

---折叠按钮
---@return UnityEngine.GameObject
function UIGMToolPanel.GetFoldingButton_GameObject()
    if UIGMToolPanel.mFoldingBtnGO == nil then
        UIGMToolPanel.mFoldingBtnGO = UIGMToolPanel:GetCurComp("events/btn_folding", "GameObject")
    end
    return UIGMToolPanel.mFoldingBtnGO
end

---折叠view缩放
---@return TweenScale
function UIGMToolPanel.GetFoldingViewTweenScale()
    if UIGMToolPanel.mFoldingViewTweenScale == nil then
        UIGMToolPanel.mFoldingViewTweenScale = UIGMToolPanel:GetCurComp("view", "TweenScale")
    end
    return UIGMToolPanel.mFoldingViewTweenScale
end

---折叠按钮旋转
---@return TweenRotation
function UIGMToolPanel.GetFoldingButtonTweenRotate()
    if UIGMToolPanel.mFoldingButtonTweenRotate == nil then
        UIGMToolPanel.mFoldingButtonTweenRotate = UIGMToolPanel:GetCurComp("events/btn_folding", "TweenRotation")
    end
    return UIGMToolPanel.mFoldingButtonTweenRotate
end

---第一个窗口tween
---@return TweenHeight
function UIGMToolPanel.GetWindowTweenHeight1()
    if UIGMToolPanel.mWindowTweenHeight1 == nil then
        UIGMToolPanel.mWindowTweenHeight1 = UIGMToolPanel:GetCurComp("window/BG", "TweenHeight")
    end
    return UIGMToolPanel.mWindowTweenHeight1
end

---第二个窗口tween
---@return TweenHeight
function UIGMToolPanel.GetWindowTweenHeight2()
    if UIGMToolPanel.mWindowTweenHeight2 == nil then
        UIGMToolPanel.mWindowTweenHeight2 = UIGMToolPanel:GetCurComp("window/Sprite", "TweenHeight")
    end
    return UIGMToolPanel.mWindowTweenHeight2
end

---第三个窗口tween
---@return TweenHeight
function UIGMToolPanel.GetWindowTweenHeight3()
    if UIGMToolPanel.mWindowTweenHeight3 == nil then
        UIGMToolPanel.mWindowTweenHeight3 = UIGMToolPanel:GetCurComp("window/Texture", "TweenHeight")
    end
    return UIGMToolPanel.mWindowTweenHeight3
end

---窗口Sprite物体
---@return UnityEngine.GameObject
function UIGMToolPanel.GetWindowSpriteGO()
    if UIGMToolPanel.mWindowSpriteGO == nil then
        UIGMToolPanel.mWindowSpriteGO = UIGMToolPanel:GetCurComp("window/Sprite3", "GameObject")
    end
    return UIGMToolPanel.mWindowSpriteGO
end

---@return UnityEngine.GameObject
function UIGMToolPanel.GetDownBGGO()
    if UIGMToolPanel.mDownBGGO == nil then
        UIGMToolPanel.mDownBGGO = UIGMToolPanel:GetCurComp("events/DownBG", "GameObject")
    end
    return UIGMToolPanel.mDownBGGO
end
--endregion

--region 初始化
function UIGMToolPanel:Init()
    UIGMToolPanel:BindUIEvents()
    UIGMToolPanel:BindTemplate()
end

function UIGMToolPanel:Show(pageIndex)
    if CS.StaticUtility.IsNull(self.go) == false then
        self.go.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
    self:GetAlphaSlider_UISlider().value = 0.8
    UIGMToolPanel.GMDirectiveDic = CS.Cfg_GmDirectiveTableManager.Instance.dic
    UIGMToolPanel.RefreshDirective()
    local type
    if pageIndex ~= nil and Utility.IsContainsKey(UIGMToolPanel.BranchPanel, pageIndex) then
        type = pageIndex
    else
        type = LuaEnumGMPanelType.GMQuickOrder
    end
    for i, v in pairs(self.PageToggleDic) do
        v.value = (i == type)
    end
    self:SwitchBranchPanel(type)
end

function UIGMToolPanel:BindTemplate()
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMQuickOrder] = templatemanager.GetNewTemplate(UIGMToolPanel:GetGMDirective_Window(), luaComponentTemplates.UIGMPanel_Order, self)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMGenerate] = templatemanager.GetNewTemplate(UIGMToolPanel:GetGMItemCreate_Window(), luaComponentTemplates.UIGMPanel_Generate, self)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMMonster] = templatemanager.GetNewTemplate(UIGMToolPanel:GetGMMonsterCreate_Window(), luaComponentTemplates.UIGMPanel_Monster, self)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMModelExhibition] = templatemanager.GetNewTemplate(UIGMToolPanel:GetModelPreview_Window(), luaComponentTemplates.UIGMModelTemplates, self)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMHierarchy] = templatemanager.GetNewTemplate(UIGMToolPanel:GetGMHierarchyCreate_Window(), luaComponentTemplates.UIGMPanel_ComponentManager, self)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMLogViewer] = templatemanager.GetNewTemplate(UIGMToolPanel.GetLogViewer_GameObject(), luaComponentTemplates.UIGMPanelLogViewer)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.GMModelControl] = templatemanager.GetNewTemplate(UIGMToolPanel.GetModelControllerGameObject(), luaComponentTemplates.UIGMModelController)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.Tool] = templatemanager.GetNewTemplate(UIGMToolPanel.GetToolGameObject(), luaComponentTemplates.UIGMPanel_Tool)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.BagItemLid] = templatemanager.GetNewTemplate(UIGMToolPanel.GetBagItemGameObject(), luaComponentTemplates.UIGMPanel_BagItemLid)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.ClientRobot] = templatemanager.GetNewTemplate(UIGMToolPanel.GetViewClientRobot(), luaComponentTemplates.UIGMPanelLogView_ClientRobot)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.EventStateView] = templatemanager.GetNewTemplate(UIGMToolPanel.GetEventStateViewGO(), luaComponentTemplates.UIGMEventStateViewer)
    UIGMToolPanel.BranchPanel[LuaEnumGMPanelType.LoadServerResources] = templatemanager.GetNewTemplate(UIGMToolPanel.GetLoadServerResourcesGO(), luaComponentTemplates.UILoadServerResources)
  
    
end

function UIGMToolPanel:BindUIEvents()
    CS.UIEventListener.Get(UIGMToolPanel.GetCloseBtn_GameObject()).onClick = UIGMToolPanel.mCloseBtnOnClick
    CS.UIEventListener.Get(UIGMToolPanel.GetFoldingButton_GameObject()).onClick = UIGMToolPanel.OnFoldingButtonClicked
    self:GetAlphaSlider_UISlider().value = self:GetGMUIPanel().alpha
    CS.EventDelegate.Add(UIGMToolPanel.GetAlphaSlider_UISlider().onChange, function()
        self:GetGMUIPanel().alpha = self:GetAlphaSlider_UISlider().value
    end)

    self.PageToggleDic = {}
    self:SetPageClickType(UIGMToolPanel.GetGMDirective_UIToggle(), LuaEnumGMPanelType.GMQuickOrder)
    self:SetPageClickType(UIGMToolPanel.GetGMCreateItem_UIToggle(), LuaEnumGMPanelType.GMGenerate)
    self:SetPageClickType(UIGMToolPanel.GetGMCreateMonster_UIToggle(), LuaEnumGMPanelType.GMMonster)
    self:SetPageClickType(UIGMToolPanel.GetModelPreview_UIToggle(), LuaEnumGMPanelType.GMModelExhibition)

    self:SetPageClickType(UIGMToolPanel.GetGMLogPanel_UIToggle(), LuaEnumGMPanelType.GMLogViewer)
    self:SetPageClickType(UIGMToolPanel.GetGMAddGUI_UIToggle(), LuaEnumGMPanelType.GMHierarchy)
    self:SetPageClickType(UIGMToolPanel.GetModelController_UIToggle(), LuaEnumGMPanelType.GMModelControl)
    self:SetPageClickType(UIGMToolPanel.GetTool_UIToggle(), LuaEnumGMPanelType.Tool)
    self:SetPageClickType(UIGMToolPanel.GetBagItemLid_UIToggle(), LuaEnumGMPanelType.BagItemLid)
    self:SetPageClickType(UIGMToolPanel.GetTogClientRobot(), LuaEnumGMPanelType.ClientRobot)
    self:SetPageClickType(UIGMToolPanel.GetEventBindView_UIToggle(), LuaEnumGMPanelType.EventStateView)
    self:SetPageClickType(UIGMToolPanel.GetLoadServerResources_UIToggle(), LuaEnumGMPanelType.LoadServerResources)
end

---@param toggle UIToggle
---@param pageType LuaEnumLogViewerLogType
function UIGMToolPanel:SetPageClickType(toggle, pageType)

    ---@type table LuaEnumLogViewerLogType,UIToggle
    self.PageToggleDic[pageType] = toggle
    CS.EventDelegate.Add(toggle.onChange, function()
        self.SwitchFold(false)
        if toggle.value then
            self:SwitchBranchPanel(pageType)
        end
    end)
end
--endregion

--region UI点击事件
function UIGMToolPanel.mCloseBtnOnClick()
    uimanager:ClosePanel("UIGMToolPanel")
end

function UIGMToolPanel.OnFoldingButtonClicked()
    UIGMToolPanel.SwitchFold(UIGMToolPanel.IsFolded() == false)
end
--endregion

--region 折叠
---@return boolean
function UIGMToolPanel.IsFolded()
    if UIGMToolPanel.mIsFolded then
        return UIGMToolPanel.mIsFolded == true
    end
    return false
end

---@param isFold boolean 折叠/不折叠状态
function UIGMToolPanel.SwitchFold(isFold)
    if UIGMToolPanel.mIsFolded ~= true then
        UIGMToolPanel.mIsFolded = false
    end
    if UIGMToolPanel.mIsFolded == isFold then
        return
    end
    UIGMToolPanel.mIsFolded = isFold == true
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetFoldingButtonTweenRotate()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetFoldingButtonTweenRotate():PlayForward()
        else
            UIGMToolPanel.GetFoldingButtonTweenRotate():PlayReverse()
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetFoldingViewTweenScale()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetFoldingViewTweenScale():PlayForward()
        else
            UIGMToolPanel.GetFoldingViewTweenScale():PlayReverse()
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetWindowTweenHeight1()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetWindowTweenHeight1():PlayForward()
        else
            UIGMToolPanel.GetWindowTweenHeight1():PlayReverse()
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetWindowTweenHeight2()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetWindowTweenHeight2():PlayForward()
        else
            UIGMToolPanel.GetWindowTweenHeight2():PlayReverse()
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetWindowTweenHeight3()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetWindowTweenHeight3():PlayForward()
        else
            UIGMToolPanel.GetWindowTweenHeight3():PlayReverse()
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetWindowSpriteGO()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetWindowSpriteGO():SetActive(false)
        else
            UIGMToolPanel.GetWindowSpriteGO():SetActive(true)
        end
    end
    if CS.StaticUtility.IsNull(UIGMToolPanel.GetDownBGGO()) == false then
        if UIGMToolPanel.mIsFolded then
            UIGMToolPanel.GetDownBGGO():SetActive(false)
        else
            UIGMToolPanel.GetDownBGGO():SetActive(true)
        end
    end
end
--endregion

--region 分界面
UIGMToolPanel.NavType = nil

function UIGMToolPanel:GetCurBranchPanel()
    if (self.NavType == nil) then
        return nil
    end
    return UIGMToolPanel.BranchPanel[self.NavType]
end

function UIGMToolPanel:SwitchBranchPanel(type)
    if (type == self.NavType) then
        return
    end

    if (self:GetCurBranchPanel() ~= nil and self:GetCurBranchPanel().Hide ~= nil) then
        self:GetCurBranchPanel():Hide()
    end

    self.NavType = type

    if (self:GetCurBranchPanel() ~= nil and self:GetCurBranchPanel().Show ~= nil) then
        self:GetCurBranchPanel():Show()
    end

end
--endregion

--region 刷新界面
---刷新GM指令
function UIGMToolPanel.RefreshDirective()
    if (UIGMToolPanel.GMDirectiveDic == nil) then
        return
    end
    UIGMToolPanel.GetDirectiveList_UIGridContainer().MaxCount = UIGMToolPanel.GMDirectiveDic.Count
    UIGMToolPanel.GMDirectiveDic:Begin()
    while UIGMToolPanel.GMDirectiveDic:Next() do
        local go = UIGMToolPanel.GetDirectiveList_UIGridContainer().controlList[UIGMToolPanel.GMDirectiveDic.Key - 1]
        UIGMToolPanel.GMDirectiveTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMDirectiveTemplate)
        UIGMToolPanel.GMDirectiveTemplates[go]:InitParameters(UIGMToolPanel.GMDirectiveDic.Value)
        UIGMToolPanel.GMDirectiveTemplates[go]:ReFreshUIPanel()
    end
    --for k, v in pairs(UIGMToolPanel.GMDirectiveDic) do
    --    local go = UIGMToolPanel.GetDirectiveList_UIGridContainer().controlList[k - 1]
    --    UIGMToolPanel.GMDirectiveTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGMDirectiveTemplate)
    --    UIGMToolPanel.GMDirectiveTemplates[go]:InitParameters(v)
    --    UIGMToolPanel.GMDirectiveTemplates[go]:ReFreshUIPanel()
    --end
end

--endregion

return UIGMToolPanel