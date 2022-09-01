---物品信息界面
---@class 物品信息界面:UIBase
local UIItemInfoPanel = {}

setmetatable(UIItemInfoPanel, luaPanelModules.UIDialog)

UIItemInfoPanel.IsNeedActiveDuringInitialize = true

--region 参数
---外框最大高度
---@type number
UIItemInfoPanel.mFrameMaxHeight = 300
---外框最小高度
---@type number
UIItemInfoPanel.mFrameMinHeight = -300
---外框中间间隔
---@type number
UIItemInfoPanel.mFrameInterval = 2
--endregion

--region 组件
---背景面板克隆组件
function UIItemInfoPanel:GetPanelGridContainer()
    if self.mPanelGridContainer == nil then
        self.mPanelGridContainer = self:GetCurComp("WidgetRoot/GridContainer", "UIGridContainer")
    end
    return self.mPanelGridContainer
end

---背景图
function UIItemInfoPanel:GetBackground_UISprite()
    if self.mBackground_UISprite == nil and self.tipsPanelTable ~= nil and Utility.GetLuaTableCount(self.tipsPanelTable) > 0 then
        local panelTemplate = self.tipsPanelTable[#self.tipsPanelTable]
        if panelTemplate ~= nil then
            self.mBackground_UISprite = self:GetComp(panelTemplate.go.transform, "window/background", "UISprite")
        end
    end
    return self.mBackground_UISprite
end

---面板主节点
function UIItemInfoPanel:GetWidgetRoot_GameObject()
    if self.mWidgetRoot_GameObject == nil then
        self.mWidgetRoot_GameObject = self:GetCurComp("WidgetRoot", "GameObject")
    end
    return self.mWidgetRoot_GameObject
end

---获取背景图
function UIItemInfoPanel:GetBackGround_UISprite()
    return self:GetBackground_UISprite()
end
--endregion

--region 变量
---UI界面层级为Tips
UIItemInfoPanel.PanelLayerType = CS.UILayerType.TipsPlane
--endregion

--region 初始化
function UIItemInfoPanel:Init()
    self:BindUIEvents()
    self:InitParams()
    gameMgr:GetLuaTimeMgr():GetRemainTime(0)
    --local haveTimeCLock = luaclass.ActivityEndCountDownData:CheckHaveHintTimeClock(9)
    --local testTable = {}
    --testTable.moduleType = 9
    --testTable.endTime = CS.CSServerTime.Instance.TotalMillisecond + 60000
    --if haveTimeCLock == true then
    --    testTable.endTime = 0
    --end
    --luaclass.ActivityEndCountDownData:PushCountDown(LuaEnumCountDownEndType.DarkPalaceActivityEnd,testTable)
end

---显示物品信息界面
function UIItemInfoPanel:Show(commonData)
    if self.commonData ~= nil then
        return
    end
    if self:AnalysisData(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    if self.isCloseCollider ~= true then
        self:AddCollider()
    end
    self:RunBaseFunction("Show")
    self:PlayAudio(self.itemInfo)
    self:RefreshPanel()
    if self.refreshEndContinue ~= nil then
        StopCoroutine(self.refreshEndContinue)
        self.refreshEndContinue = nil
    end
    self.refreshEndContinue = StartCoroutine(function()
        coroutine.yield(0)
        self:AutoAdjust()
        if self.RefreshEndFunc ~= nil then
            self:RefreshEndFunc(self, self.endFuncParams)
        end
    end)
    self:RefreshOther()
end

---解析数据
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel:AnalysisData(commonData)
    if type(commonData) == 'table' then
        self.commonData = commonData
        self.bagItemInfo = commonData.bagItemInfo
        self.itemInfo = commonData.itemInfo
        self.showRight = commonData.showRight
        self.showAssistPanel = commonData.showAssistPanel
        self.mainPartTemplate = commonData.mainPartTemplate
        self.assistPartTemplate = commonData.assistPartTemplate
        self.assistPanelBagItemInfoTable = ternary(commonData.assistPanelBagItemInfoTable == nil or self.assistPartTemplate == nil, {}, commonData.assistPanelBagItemInfoTable)
        self.assistPanelItemInfoTable = ternary(commonData.assistPanelItemInfoTable == nil or self.assistPartTemplate == nil, {}, commonData.assistPanelItemInfoTable)
        self.isCloseCollider = commonData.isCloseCollider
        self.career = commonData.career
        self.rightUpButtonsModule = commonData.rightUpButtonsModule
        self.RefreshEndFunc = commonData.refreshEndFunc
        self.extraEquipIdTable = commonData.extraEquipIdTable
        self.assistPanelExtraEquipIdTable = commonData.assistPanelExtraEquipIdTable
        self.highLightBtnTable = commonData.highLightBtnTable
        self.itemInfoSource = commonData.itemInfoSource
        self.compareBagItemInfo = commonData.compareBagItemInfo
        self.compareItemInfo = commonData.compareItemInfo
        self.TabBagItemInfoTable = commonData.TabBagItemInfoTable
        self.TabItemInfoTable = commonData.TabItemInfoTable
        self.showTabBtns = commonData.showTabBtns
        self.endFuncParams = commonData.endFuncParams
        self.TabDefaultChoose = commonData.TabDefaultChoose
        self.btnIndex = 0
        if commonData.btnIndex == nil then
            if commonData.TabDefaultChoose ~= nil then
                self.btnIndex = commonData.TabDefaultChoose
            end
        else
            self.btnIndex = commonData.btnIndex
        end
        self.roleId = commonData.roleId
        self.showBind = commonData.showBind
        self.showAction = commonData.showAction
        self.getItemList = commonData.getItemList
        self.tipsOnClick = commonData.tipsOnClick
        self.defaultChooseTable = commonData.defaultChooseTable
        self.maxFrameHeight = commonData.maxFrameHeight
        self.ExhibitionPanelNeedLink = commonData.ExhibitionPanelNeedLink
        self.backgroundPos = commonData.backgroundPos

        local career = LuaEnumCareer.Common
        if CS.CSScene.MainPlayerInfo ~= nil then
            career = CS.CSScene.MainPlayerInfo.Career
        end

        self.mainPartCommonData = { commonData = commonData.commonData, bagItemInfo = self.bagItemInfo, itemInfo = self.itemInfo, showRight = self.showRight, compareBagItemInfo = self.compareBagItemInfo, compareItemInfo = self.compareItemInfo, career = self.career, rightUpButtonsModule = self.rightUpButtonsModule, extraEquipIdTable = self.extraEquipIdTable, highLightBtnTable = self.highLightBtnTable, itemInfoSource = self.itemInfoSource, roleId = self.roleId, showBind = self.showBind, btnIndex = self.btnIndex, showAction = self.showAction, getItemList = self.getItemList, tipsOnClick = self.tipsOnClick, defaultChooseTable = self.defaultChooseTable, maxFrameHeight = self.maxFrameHeight }
        self.assistPartCommonData = { commonData = commonData.commonData, bagItemInfo = nil, itemInfo = nil, career = career, extraEquipIdTable = self.assistPanelExtraEquipIdTable, itemInfoSource = self.itemInfoSource, showTabBtns = self.showTabBtns, showBind = self.showBind, btnIndex = self.btnIndex, showAction = self.showAction, getItemList = self.getItemList, tipsOnClick = self.tipsOnClick, defaultChooseTable = self.defaultChooseTable, maxFrameHeight = self.maxFrameHeight }
        return true
    end
    return false
end

--region 面板刷新
---刷新面板（全刷）
function UIItemInfoPanel:RefreshPanel()
    if self.itemInfo ~= nil and self.assistPanelBagItemInfoTable ~= nil then
        local PanelCount = #self.assistPanelBagItemInfoTable + 1
        self:GetPanelGridContainer().MaxCount = PanelCount
        for k = 0, PanelCount - 1 do
            local go = self:GetPanelGridContainer().controlList[k]
            local template = self.assistPartTemplate
            local commonData = Utility.CopyTable(self.assistPartCommonData)

            if k == PanelCount - 1 then
                template = self.mainPartTemplate
                commonData = self.mainPartCommonData
                commonData.isMainPartTemplate = true
            else
                ---添加副面板数据参数
                local assistIndex = k + 1
                if assistIndex >= 1 and assistIndex <= #self.assistPanelBagItemInfoTable then
                    commonData.bagItemInfo = self.assistPanelBagItemInfoTable[assistIndex]
                    commonData.itemInfo = self.assistPanelItemInfoTable[assistIndex]
                end
                ---左侧第一个面板可以有页签按钮
                if k == 0 then
                    commonData.TabBagItemInfoTable = self.TabBagItemInfoTable
                    commonData.TabItemInfoTable = self.TabItemInfoTable
                    commonData.TabDefaultChoose = self.TabDefaultChoose
                else
                    commonData.TabBagItemInfoTable = nil
                    commonData.TabItemInfoTable = nil
                    commonData.TabDefaultChoose = 0
                end
                commonData.isMainPartTemplate = false
            end

            ---查看是否有缓存模板
            local go_Template = self.tipsGoAndTemplateTable[go]
            if go_Template == nil then
                go_Template = templatemanager.GetNewTemplate(go, template, self:GetWidgetRoot_GameObject())
                go_Template:RefreshWithBagItemInfo(commonData)
                table.insert(self.tipsPanelTable, go_Template)
                self.tipsGoAndTemplateTable[go] = go_Template
            else
                self:RefreshSinglePanel(go, commonData)
            end
        end
    end
end

---面板数量相同刷新
function UIItemInfoPanel:SameCountRefresh()
    local PanelCount = #self.assistPanelBagItemInfoTable + 1
    local nowPanelCount = self:GetPanelGridContainer().MaxCount
    if PanelCount == nowPanelCount then
        if self.itemInfo ~= nil and self.assistPanelBagItemInfoTable ~= nil then
            for k = 0, PanelCount - 1 do
                local go = self:GetPanelGridContainer().controlList[k]
                local template = self.tipsGoAndTemplateTable[go]
                local isMainPanel = false
                local commonData = self.assistPartCommonData
                if k == PanelCount - 1 then
                    commonData = self.mainPartCommonData
                    commonData.isMainPartTemplate = true
                else
                    ---添加副面板数据参数
                    commonData.isMainPartTemplate = false
                    local assistIndex = k + 1
                    if assistIndex >= 1 and assistIndex <= #self.assistPanelBagItemInfoTable then
                        commonData.bagItemInfo = self.assistPanelBagItemInfoTable[assistIndex]
                        commonData.itemInfo = self.assistPanelItemInfoTable[assistIndex]
                    end
                end
                self:RefreshSinglePanel(go, commonData, isMainPanel)
            end
        end
    end
end

---刷新单个物品信息面板
---@param go UnityEngine.GameObject
---@param commonData table 通用参数
---@param isMainPanel boolean 是否是主面板
function UIItemInfoPanel:RefreshSinglePanel(go, commonData, isMainPanel)
    local template = self.tipsGoAndTemplateTable[go]
    if template ~= nil then
        --if isMainPanel == true then
        --    template:AmendCommonData(commonData)
        --    template:RefreshTemplate(LuaEnumItemInfoModuleType.BaseAttribute)
        --    template:RefreshTemplate(LuaEnumItemInfoModuleType.RightUpOperate)
        --else
        --    template:TabChangeRefreshPanel(commonData)
        --end
        template:TabChangeRefreshPanel(commonData)
    end
end

---主动刷新数据数据解析
function UIItemInfoPanel:AnalysisParams(commonData)
    local btnIndex = commonData.btnIndex
    local assistItemTable, assistItemInfoTable, compareBagitemInfo = uiStaticParameter.UIItemInfoManager:GetShowItemTable(commonData.index)
    if assistItemTable == nil or assistItemInfoTable == nil or compareBagitemInfo == nil then
        uimanager:ClosePanel(self)
        return
    end
    if Utility.GetTableCount(assistItemTable) ~= Utility.GetTableCount(self.assistPanelBagItemInfoTable) then
        self.refreshType = LuaEnumItemInfoPanelRefreshType.AllRefresh
    else
        self.refreshType = LuaEnumItemInfoPanelRefreshType.SamePanelNumRefresh
    end
    self.commonData.assistPanelBagItemInfoTable = assistItemTable
    self.commonData.assistPanelItemInfoTable = assistItemInfoTable
    self.commonData.btnIndex = btnIndex
    self.btnIndex = btnIndex
    self.commonData.compareBagItemInfo = compareBagitemInfo
    self.commonData.compareItemInfo = compareBagitemInfo.ItemTABLE
    self.commonData.TabDefaultChoose = btnIndex
end
--endregion


---面板下移自适应
function UIItemInfoPanel:AutoAdjust()
    if self.tipsPanelTable ~= nil and type(self.tipsPanelTable) == 'table' and #self.tipsPanelTable > 1 then
        local mainPanelOrigin_Y = self.tipsPanelTable[#self.tipsPanelTable]:FrameSize().y * 0.5
        local mainPanelOrigin_PosY = self.tipsPanelTable[#self.tipsPanelTable].go.transform.localPosition.y
        local length = #self.tipsPanelTable - 1
        for k = 1, length do
            local assistPanelTemplate = self.tipsPanelTable[k]
            if assistPanelTemplate.go ~= nil then
                local assistOriginPos = assistPanelTemplate.go.transform.localPosition
                local assistPanelOffset = mainPanelOrigin_Y - assistPanelTemplate:FrameSize().y * 0.5
                assistOriginPos.y = mainPanelOrigin_PosY + assistPanelOffset
                assistPanelTemplate.go.transform.localPosition = assistOriginPos
            end
        end
    end
end

--region 播放音效
--禁止界面播放默认音效
function UIItemInfoPanel:IsNeedPlayOpenAudio()
    return false
end
--播放自身音效
function UIItemInfoPanel:PlayAudio(itemInfo)
    if itemInfo ~= nil then
        CS.Cfg_ItemSoundTableManager.Instance:PlayItemSound(itemInfo, CS.ItemSoundType.Touch)
    end
end
--endregion

---绑定UI事件
function UIItemInfoPanel:BindUIEvents()
    self.tabChangeRefreshPanel = function(id, commonData)
        if self.tabClickRefresh ~= nil then
            StopCoroutine(self.tabClickRefresh)
            self.tabClickRefresh = nil
        end
        self:TabChangeRefreshPanels(id, commonData)
        self.tabClickRefresh = StartCoroutine(function()
            coroutine.yield(0)
            self:AutoAdjust()
        end)
    end
    self.mAddBlinkList = function(id, blink)
        self:AddBlinkList(id, blink)
    end
    self.mUseBlink = function()
        self:UseBlink()
    end
    self.mRemoveBlink = function(id, go)
        self:RemoveBlink(id, go)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ItemInfoPanel_UseBtnClickBlink, self.mUseBlink)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ItemInfoPanel_AddBlinkList, self.mAddBlinkList)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.TabChangeRefreshPanel, self.tabChangeRefreshPanel)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ItemInfoPanel_RemoveBlinkList, self.mRemoveBlink)
end

function UIItemInfoPanel:InitParams()
    self.blinkList = {}
    ---面板template数据表，最后一个永远是主面板
    self.tipsPanelTable = {}
    ---go-->template
    self.tipsGoAndTemplateTable = {}
end

function UIItemInfoPanel:RefreshOther()
    self:RefreshGridContainerPos()
end

---刷新背景面板克隆组件位置
---@param pos UnityEngine.Vector3
function UIItemInfoPanel:RefreshGridContainerPos()
    if (self:GetPanelGridContainer() == nil or self.backgroundPos == nil or self.backgroundPos == CS.UnityEngine.Vector3.Zero) then
        return
    end
    self:GetPanelGridContainer().transform.localPosition = self.backgroundPos
    self.mFlickerCoroutine = StartCoroutine(function()
        self:RefreshOtherPanelPos()
    end)
end

---刷新其他和UIItemInfoPanel同时打开的面板位置
function UIItemInfoPanel:RefreshOtherPanelPos()
    if (self:GetBackGround_UISprite() == nil) then
        return
    end
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.1))
    local panel = uimanager:GetPanel('UISkillVideoPanel')
    if (panel ~= nil) then
        panel:RefreshPanelPos(self:GetBackGround_UISprite().localSize)
    end
end

--endregion

--region 面板刷新
function UIItemInfoPanel:TabChangeRefreshPanels(id, commonData)
    if self.btnIndex ~= nil and commonData ~= nil and commonData.btnIndex ~= nil and self.btnIndex ~= commonData.btnIndex then
        self:AnalysisParams(commonData)
        self:AnalysisData(self.commonData)
        if self.refreshType == nil then
            self.refreshType = LuaEnumItemInfoPanelRefreshType.SamePanelNumRefresh
        end
        if self.refreshType == LuaEnumItemInfoPanelRefreshType.SamePanelNumRefresh then
            self:SameCountRefresh()
        else
            self:RefreshPanel()
        end
    end
end
--endregion

--region 字体闪烁
function UIItemInfoPanel:AddBlinkList(id, commonData)
    if commonData ~= nil and self.blinkList ~= nil and commonData.go ~= nil and commonData.blink ~= nil then
        self.blinkList[commonData.go] = commonData.blink
    end
end

---移除闪烁
function UIItemInfoPanel:RemoveBlink(id, go)
    if go ~= nil and self.blinkList ~= nil then
        self.blinkList[go] = nil
    end
end

---使用闪烁
function UIItemInfoPanel:UseBlink()
    if self.blinkList ~= nil then
        for k, v in pairs(self.blinkList) do
            if not CS.StaticUtility.IsNull(v) then
                v:PlayTween()
            end
        end
    end
end
--endregion
--endregion

function ondestroy()
    UIItemInfoPanel:OnDestroy()
end

function UIItemInfoPanel:OnDestroy()
    if self.refreshEndContinue ~= nil then
        StopCoroutine(self.refreshEndContinue)
        self.refreshEndContinue = nil
    end
    if self.tabClickRefresh ~= nil then
        StopCoroutine(self.tabClickRefresh)
        self.tabClickRefresh = nil
    end
    --luaEventManager.RemoveCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink, self.mUseBlink)
    --luaEventManager.RemoveCallback(LuaCEvent.ItemInfoPanel_AddBlinkList, self.mAddBlinkList)
    uimanager:ClosePanel("UIPetInfoPanel")
    luaEventManager.ClearCallback(LuaCEvent.TabChangeRefreshPanel)
    uiStaticParameter.UIItemInfoManager:ClearShowItemTable()
end
--endregion
return UIItemInfoPanel