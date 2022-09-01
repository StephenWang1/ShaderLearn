---@class UIWhiteSunGatePanel:UIBase
local UIWhiteSunGatePanel = {}

--region 组件
---关闭按钮
---@return UnityEngine.GameObject
function UIWhiteSunGatePanel:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseButtonGO
end

---书签
---@return UILoopScrollViewPlus
function UIWhiteSunGatePanel:GetBookMarkScrollViewPlus()
    if self.mBookMarkScrollViewPlus == nil then
        self.mBookMarkScrollViewPlus = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "UILoopScrollViewPlus")
    end
    return self.mBookMarkScrollViewPlus
end
--endregion

--region 属性
---获取当前选中的书签类型
---@return LuaEnumBaiRiMenActivityType
function UIWhiteSunGatePanel:GetCurrentSelectedBookMarkType()
    return self.mSelectedBookMarkSubType
end
--endregion

--region 初始化
function UIWhiteSunGatePanel:Init()
    self:InitializeUIEvents()
end

---@param data {type:LuaEnumBaiRiMenActivityType}
function UIWhiteSunGatePanel:Show(data)
    local selectedBookMarkSubType
    --print("UIWhiteSunGatePanel Show Data:", data)
    if data ~= nil then
        if type(data) == 'number' then
            selectedBookMarkSubType = data
        elseif type(data) == 'table' then
            if data.type == nil then
                selectedBookMarkSubType = self:GetAvailableBookMark()
            else
                selectedBookMarkSubType = data.type
                if self:IsBookMarkOpened(selectedBookMarkSubType) == false then
                    selectedBookMarkSubType = self:GetAvailableBookMark()
                end
            end
        end
    else
        ---输入参数为空时,获取一个可用的书签
        selectedBookMarkSubType = self:GetAvailableBookMark()
    end
    if selectedBookMarkSubType == nil then
        ---没有可以选择的书签
        return
    end
    gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():RequestAllOpenedActivityServerData()
    self:RefreshBookMarksUI()
    self:SelectBookMark(selectedBookMarkSubType)
end

---初始化UI事件
---@private
function UIWhiteSunGatePanel:InitializeUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region 数据
---获取一个符合开启页签条件的白日门活动表的页签
---@return number bairimen_activity表的subtype
function UIWhiteSunGatePanel:GetAvailableBookMark()
    local actControllers = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
    for i = 1, #actControllers do
        if actControllers[i]:IsActivityShowToPlayer() then
            return actControllers[i]:GetRepresentActivityTbl():GetSubtype()
        end
    end
    return nil
end

---页签是否开启
---@param bookmarkSubType number
function UIWhiteSunGatePanel:IsBookMarkOpened(bookmarkSubType)
    local actControllers = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
    for i = 1, #actControllers do
        if actControllers[i]:GetRepresentActivityTbl():GetSubtype() == bookmarkSubType then
            if actControllers[i]:IsActivityShowToPlayer() then
                return true
            end
        end
    end
    return false
end
--endregion

--region 书签
---选择书签
---@public
---@param bookMarkSubtype LuaEnumBaiRiMenActivityType
---@return boolean, number|nil, number|nil 活动是否开启 导致未开启的conditionType 导致未开启的conditionID
function UIWhiteSunGatePanel:SelectBookMark(bookMarkSubtype)
    if self.mSelectedBookMarkSubType == bookMarkSubtype then
        ---重复选中
        return
    end
    local actController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActControllerBySubType(bookMarkSubtype)
    if actController == nil then
        return false
    end
    local isOpened, conditionType, conditionID = actController:IsActivityShowToPlayer()
    if isOpened then
        local template = self:GetBookMarkTemplateBySubType(self.mSelectedBookMarkSubType)
        if template then
            template:SetSelectedState(false)
        end
        self.mSelectedBookMarkSubType = bookMarkSubtype
        template = self:GetBookMarkTemplateBySubType(self.mSelectedBookMarkSubType)
        if template then
            template:SetSelectedState(true)
        end
        self:OnBookMarkSwitched(actController)
    end
    return isOpened, conditionType, conditionID
end

---刷新书签UI
---@private
function UIWhiteSunGatePanel:RefreshBookMarksUI()
    self.mAllShowActControllers = nil
    if self.mOnItemInitCallBack == nil then
        self.mOnItemInitCallBack = function(go, line)
            return self:RefreshBookMark(go, line)
        end
        self:GetBookMarkScrollViewPlus():Init(self.mOnItemInitCallBack, nil)
    else
        self:GetBookMarkScrollViewPlus():RefreshCurrentPage()
    end
end

---刷新书签页
---@private
function UIWhiteSunGatePanel:RefreshBookMark(go, line)
    --   local actActivities = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
    local allShowActActivities = self:GetAllShowActControllers()
    if line < 0 or line >= #allShowActActivities then
        return false
    end
    local actActivity = allShowActActivities[line + 1]
    if actActivity == nil then
        return false
    end
    local template = self:GetBookMarkTemplate(go)
    local isSelected = actActivity:GetRepresentActivityTbl():GetSubtype() == self.mSelectedBookMarkSubType
    local isOpened = actActivity:IsActivityShowToPlayer()
    template:RefreshState(actActivity:GetRepresentActivityTbl(), isSelected, isOpened,actActivity)
    return true
end

---获得所有需要显示的页签
---@private
function UIWhiteSunGatePanel:GetAllShowActControllers()
    if self.mAllShowActControllers == nil then
        self.mAllShowActControllers = {}
        local actActivities = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetAllActControllers()
        for i = 1, #actActivities do
            ---@type BaiRiMenActControllerBase
            local actActivity = actActivities[i]
            if actActivity:IsActivityBookMarkOpen() then
                table.insert(self.mAllShowActControllers, actActivity)
            end
        end
    end
    return self.mAllShowActControllers
end

---获取书签页模板
---@private
---@return UIWhiteSunGatePanelBookMark
function UIWhiteSunGatePanel:GetBookMarkTemplate(go)
    if self.mBookMarkTemplates == nil then
        ---@type table<number, UIWhiteSunGatePanelBookMark>
        self.mBookMarkTemplates = {}
    end
    if self.mBookMarkTemplates[go] ~= nil then
        return self.mBookMarkTemplates[go]
    end
    ---@type UIWhiteSunGatePanelBookMark
    local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.WhiteSunGatePanelBookMark, self)
    self.mBookMarkTemplates[go] = template
    if self.mBookMarkClickedCallBack == nil then
        self.mBookMarkClickedCallBack = function(goTemp, bairimenActivityTbl)
            self:OnBookMarkClicked(goTemp, bairimenActivityTbl)
        end
    end
    template:RegisterClickCallBack(self.mBookMarkClickedCallBack)
    return template
end

---获取书签中类型与subType一致的书签模板
---@private
---@param subType
function UIWhiteSunGatePanel:GetBookMarkTemplateBySubType(subType)
    if self.mBookMarkTemplates == nil or subType == nil then
        return nil
    end
    for i, v in pairs(self.mBookMarkTemplates) do
        if v:GetBaiRiMenActivityTbl() ~= nil and v:GetBaiRiMenActivityTbl():GetSubtype() == subType then
            return v
        end
    end
    return nil
end
--endregion

--region UI事件
---书签点击事件
---@private
---@param go UnityEngine.GameObject
---@param bairimenActivityTbl TABLE.cfg_bairimen_activity
function UIWhiteSunGatePanel:OnBookMarkClicked(go, bairimenActivityTbl)
    if bairimenActivityTbl == nil then
        return
    end
    local isSelected, failConditionType, failConditionID = self:SelectBookMark(bairimenActivityTbl:GetSubtype())
    if isSelected == false and failConditionType ~= nil and failConditionID ~= nil then
        local failedConditionStr
        if failConditionType == 1 then
            ---等级不足
            failedConditionStr = "等级不足"
        elseif failConditionType == 3 then
            ---转生等级不足
            failedConditionStr = "转生等级不足"
        elseif failConditionType == 8 then
            ---开服天数不足
            ---@type TABLE.CFG_CONDITIONS
            local conditionTblExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failConditionID)
            if conditionTbl then
                failedConditionStr = Utility.CombineStringQuickly("开服第", conditionTbl.conditionParam.list[0], "天开启")
            end
        end
        if failConditionType then
            Utility.ShowPopoTips(go, failedConditionStr, 48, "UIWhiteSunGatePanel")
        end
    end
end
--endregion

--region 页签UI界面
---书签切换事件
---@private
---@param baiRiMenActController BaiRiMenActControllerBase
function UIWhiteSunGatePanel:OnBookMarkSwitched(baiRiMenActController)
    if baiRiMenActController == nil or baiRiMenActController:GetRepresentActivityTbl() == nil then
        return
    end
    ---打开当前选中的页签对应的界面
    local panelName = baiRiMenActController:GetRepresentActivityTbl():GetPrefabs()
    if panelName == self.mOpeningPanelName or panelName == self.mOpenedPanelName then
        ---如果该界面正在打开或者之前打开过,则不打开其他界面
        return
    end
    --print("self.mOpeningPanelName", self.mOpeningPanelName, "self.mOpenedPanelName", self.mOpenedPanelName)
    ---关掉之前正在打开的界面
    if self.mOpeningPanelName ~= nil then
        uimanager:ClosePanel(self.mOpeningPanelName)
        self.mOpeningPanelName = nil
    end
    ---隐藏当前已开启的界面
    if self.mOpenedPanelName ~= nil then
        local panelTemp = uimanager:GetPanel(self.mOpenedPanelName)
        if panelTemp then
            panelTemp:HideSelf()
        end
        self.mOpenedPanelName = nil
    end
    ---@type UIBase
    local panelTemp = uimanager:GetPanel(panelName)
    if panelTemp ~= nil then
        ---如果之前已经打开了,则重新显示该界面
        self.mOpenedPanelName = panelName
        panelTemp:ReShowSelf()
        panelTemp:Show()
    else
        ---如果之前没开过,则打开该界面并在界面打开完毕时记录刷新、记录已经打开和正在打开的界面名
        self.mOpeningPanelName = panelName
        if self.mPanelOpenedCallBack == nil then
            self.mPanelOpenedCallBack = function(uiPanel)
                self:OnPanelOpened(uiPanel)
            end
        end
        uimanager:CreatePanel(self.mOpeningPanelName, self.mPanelOpenedCallBack)
    end
end

---界面打开事件
---@param uiPanel UIBase
function UIWhiteSunGatePanel:OnPanelOpened(uiPanel)
    if uiPanel == nil then
        return
    end
    local panelNameTemp = uiPanel._PanelName
    if panelNameTemp == self.mOpeningPanelName then
        self.mOpenedPanelName = panelNameTemp
        self.mOpeningPanelName = nil
        self:RegisterOpenedPanelName(panelNameTemp)
    end
end

---注册打开过的界面名
---@private
---@param panelNameTemp
function UIWhiteSunGatePanel:RegisterOpenedPanelName(panelNameTemp)
    if self.mOpenedPanelNameList == nil then
        ---打开过的界面名列表
        ---@type table<number, string>
        self.mOpenedPanelNameList = {}
    end
    local isPanelInserted = false
    for i = 1, #self.mOpenedPanelNameList do
        if self.mOpenedPanelNameList[i] == panelNameTemp then
            isPanelInserted = true
            break
        end
    end
    if isPanelInserted == false then
        table.insert(self.mOpenedPanelNameList, panelNameTemp)
    end
end
--endregion

--region 销毁
function ondestroy()
    UIWhiteSunGatePanel:OnDestroy()
end

function UIWhiteSunGatePanel:OnDestroy()
    ---关闭所有相关界面
    if self.mOpenedPanelNameList ~= nil then
        for i = 1, #self.mOpenedPanelNameList do
            uimanager:ClosePanel(self.mOpenedPanelNameList[i])
        end
        self.mOpenedPanelNameList = nil
    end
    if self.mOpenedPanelName ~= nil then
        uimanager:ClosePanel(self.mOpenedPanelName)
        self.mOpenedPanelName = nil
    end
    if self.mOpeningPanelName ~= nil then
        uimanager:ClosePanel(self.mOpeningPanelName)
        self.mOpeningPanelName = nil
    end
end
--endregion

return UIWhiteSunGatePanel