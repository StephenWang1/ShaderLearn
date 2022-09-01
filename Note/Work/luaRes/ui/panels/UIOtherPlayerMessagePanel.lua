---@class UIOtherPlayerMessagePanel
local UIOtherPlayerMessagePanel = {}
--region 初始化
function UIOtherPlayerMessagePanel:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
end

function UIOtherPlayerMessagePanel:InitComponent()
    self.closeBtn = self:GetCurComp("WidgetRoot/window/left_main/events/btn_close", "GameObject")
    self.dropDown = self:GetCurComp("WidgetRoot/view/Change/DropDown", "Top_UIDropDown")
    self.panelPoint = self:GetCurComp("WidgetRoot/view/GameObject", "GameObject")
    self.dropDown_UIPanel = self:GetCurComp("WidgetRoot/view/Change", "Top_UIPanel")
    self.drawerChoose = self:GetCurComp("WidgetRoot/view/Change/ChangeList", "Top_DrawerChoose")
end

function UIOtherPlayerMessagePanel:InitParams()
    self.panelTable = {}
    self.panelIsOpen = false
end

function UIOtherPlayerMessagePanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn).onClick = function()
        if uiStaticParameter.mUnionMemberOpenViewPerson then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Member)
        elseif uiStaticParameter.mUnionRedPackOpenViewPerson then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Info)
        end
        if uiStaticParameter.mUnionAccuseViewPerson then
            local data = {}
            data.subCustomData = {}
            data.subCustomData.isOpenAccusePanel = true
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Guild_Info, data)
        end
        uimanager:ClosePanel(self)
    end
end

---下拉列表点击打开面板
function UIOtherPlayerMessagePanel:DropDownOnClick(inputValue)
    ---隐藏当前打开界面
    local nowPanel = self:GetPanelByJumpId(self.otherPlayerBtnInfo.BtnOpenPanelJumpId)
    if nowPanel ~= nil and nowPanel.go ~= nil and CS.StaticUtility.IsNull(nowPanel.go) == false then
        nowPanel.go:SetActive(false)
    end

    ---打开替换界面
    self.chooseBtnIndex = inputValue.index
    self.otherPlayerBtnInfo = self.otherPlayerBtnList[self.chooseBtnIndex]
    self.customData = Utility.AnalysisOtherPlayerInfo(Utility.EnumToInt(self.otherPlayerBtnInfo.BtnType), Utility.EnumToInt(self.otherPlayerBtnInfo.BtnSubType))
    local cachePanel = self:GetPanelByJumpId(self.otherPlayerBtnInfo.BtnOpenPanelJumpId)
    if cachePanel == nil or cachePanel.go == nil or CS.StaticUtility.IsNull(cachePanel.go) == true then
        self:TransferPanel(self.otherPlayerBtnInfo.BtnOpenPanelJumpId)
    else
        if Utility.EnumToInt(self.otherPlayerBtnInfo.BtnType) == LuaEnumOtherPlayerBtnType.SERVANT then
            self:RefreshSpecialPanel(cachePanel)
        end
        cachePanel.go:SetActive(true)
    end

    ---打开关联界面
    self.linkPanelJumpId = self.otherPlayerBtnInfo.PanelLinkPanelJumpId
    if self.linkPanelJumpId ~= nil and self:IsOpenLinkPanel(self.linkPanelJumpId) == true then
        uiTransferManager:TransferToPanel(self.linkPanelJumpId)
    end
end
--endregion

--region 刷新
function UIOtherPlayerMessagePanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshPanel()
    self.panelIsOpen = true
end

---解析参数
---@param LuaEnumOtherPlayerBtnType commonData.btnType 选择按钮类型
---@param LuaEnumOtherPlayerBtnSubtype commonData.btnSubtype 选择按钮子类型
---@param Table commonData.commonData 创建面板额外参数
---@return 是否解析成功
function UIOtherPlayerMessagePanel:AnalysisParams(commonData)
    self.otherPlayerBtnList = CS.Cfg_Check_OtherManager.Instance:GetCheckOtherPlayerBtns()
    if self.otherPlayerBtnList == nil or self.otherPlayerBtnList.Count == 0 then
        return false
    end
    self.otherPlayerBtnNameList = CS.Cfg_Check_OtherManager.Instance:AnalysisNameListByOtehrPlayerBtnList(self.otherPlayerBtnList)
    self.chooseBtnIndex = 0
    if self.otherPlayerBtnNameList == nil or self.otherPlayerBtnNameList.Count == 0 then
        uimanager:ClosePanel(self)
        return false
    end
    if commonData ~= nil then
        if commonData.btnType ~= nil then
            self.chooseBtnIndex = ternary(commonData.btnType == nil, 0, CS.Cfg_Check_OtherManager.Instance:GetChooseIndexByBtnType(self.otherPlayerBtnList, commonData.btnType))
        end
        if commonData.btnSubtype ~= nil then
            self.chooseBtnIndex = ternary(commonData.btnSubtype == nil, 0, CS.Cfg_Check_OtherManager.Instance:GetChooseIndexByBtnSubtype(self.otherPlayerBtnList, commonData.btnSubtype))
        end
        self.customData = Utility.AnalysisOtherPlayerInfo(commonData.btnType, commonData.btnSubtype)
    end
    if self.chooseBtnIndex >= self.otherPlayerBtnList.Count then
        self.chooseBtnIndex = 0
        print("没有指定的按钮选项")
    else
        self.otherPlayerBtnInfo = self.otherPlayerBtnList[self.chooseBtnIndex]
    end
    return true
end

---刷新面板
function UIOtherPlayerMessagePanel:RefreshPanel()
    self:RefreshOtherPlayerBtnList()
    self:TransferPanel(self.otherPlayerBtnInfo.BtnOpenPanelJumpId)
end

---设置其他玩家按钮下拉列表
function UIOtherPlayerMessagePanel:RefreshOtherPlayerBtnList()
    if self.drawerChoose ~= nil and self.otherPlayerBtnList ~= nil and self.otherPlayerBtnInfo ~= nil then
        self.drawerChoose:SetChooseList(self.otherPlayerBtnList, self.otherPlayerBtnInfo, function(DrawChooseBtn)

            if self.panelIsOpen == true then
                self:DropDownOnClick(DrawChooseBtn)
            end
        end)
    end
end

---跳转到具体的面板
function UIOtherPlayerMessagePanel:TransferPanel(jumpId)
    uiTransferManager:TransferToPanel(jumpId, self.customData, function(panelName)
        local panel = uimanager:GetPanel(panelName)
        if self.panelTable ~= nil then
            panel.go.transform.parent = self.panelPoint.transform
            panel.go.transform.localPosition = CS.UnityEngine.Vector3.zero
            self.panelTable[panelName] = panel
            self:RefreshNowMaxLayer(panel)
        end
    end)
end
--endregion

--region 获取
function UIOtherPlayerMessagePanel:GetPanelByJumpId(jumpId)
    if self.panelTable ~= nil then
        local panelName = CS.Cfg_JumpUITableManager.Instance:GetJumpPanelName(jumpId)
        return self.panelTable[panelName]
    end
end
--endregion

--region 查询
---是否打开关联界面
function UIOtherPlayerMessagePanel:IsOpenLinkPanel(jumpId)
    if self.shieldPanelNameArray == nil then
        self.shieldPanelNameArray = CS.Cfg_GlobalTableManager.Instance:GetShieldPanelNameArray()
    end
    if self.shieldPanelNameArray ~= nil then
        local length = self.shieldPanelNameArray.Length - 1
        for k = 0, length do
            local curPanelName = self.shieldPanelNameArray[k]
            local curPanel = uimanager:GetPanel(curPanelName)
            if curPanel ~= nil then
                return true
            end
        end
    end
    return false
end
--endregion

--region 面板打开显示刷新处理
---刷新特殊面板
function UIOtherPlayerMessagePanel:RefreshSpecialPanel(panel)
    if Utility.EnumToInt(self.otherPlayerBtnInfo.BtnType) == LuaEnumOtherPlayerBtnType.SERVANT then
        if Utility.EnumToInt(self.otherPlayerBtnInfo.BtnSubType) == LuaEnumOtherPlayerBtnSubtype.SERVANT_HANMANG then
            panel:SwitchServantByIndex(luaEnumServantType.HM)
        elseif Utility.EnumToInt(self.otherPlayerBtnInfo.BtnSubType) == LuaEnumOtherPlayerBtnSubtype.SERVANT_LUOXING then
            panel:SwitchServantByIndex(luaEnumServantType.LX)
        elseif Utility.EnumToInt(self.otherPlayerBtnInfo.BtnSubType) == LuaEnumOtherPlayerBtnSubtype.SERVANT_TIANCHENG then
            panel:SwitchServantByIndex(luaEnumServantType.TC)
        end
    end
end
--endregion

--region 下拉列表层级刷新
---刷新当前最大层级
function UIOtherPlayerMessagePanel:RefreshNowMaxLayer(panel)
    if panel ~= nil and panel.go ~= nil then
        local isFind, depth = CS.Utility.GetMaxDepth(panel.go)
        self.maxDepth = depth
        self:RefreshDropDownLayerToMax()
    end
end

---将当前下拉列表层级调到目前最大
function UIOtherPlayerMessagePanel:RefreshDropDownLayerToMax()
    if self.dropDown_UIPanel ~= nil and self.maxDepth ~= nil then
        self.dropDown_UIPanel.depth = self.maxDepth + 1
    end
end
--endregion

--region OnDestroy
function UIOtherPlayerMessagePanel:OnDestroy()
    ---清理面板缓存
    if self.panelTable ~= nil and type(self.panelTable) == 'table' then
        for k, v in pairs(self.panelTable) do
            uimanager:ClosePanel(v)
        end
    end
    ---关闭面板后的回调操作
    local closePanelCallBack = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.CloseOtherPlayerPanelCallBack
    local CloseOtherPlayerPanelParams = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.CloseOtherPlayerPanelParams
    if closePanelCallBack ~= nil then
        closePanelCallBack(CloseOtherPlayerPanelParams)
    end
    ---关闭面板后事件发送
    if (luaEventManager.HasCallback(LuaCEvent.CloseOtherPlayerPanel)) then
        local commonData = {}
        commonData.OpenOtherPlayerPanelParams = CloseOtherPlayerPanelParams
        luaEventManager.DoCallback(LuaCEvent.CloseOtherPlayerPanel, commonData)
    end
    ---清理其他玩家信息数据
    CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ClearAllOtherPlayerInfo()
    uiStaticParameter.mUnionMemberOpenViewPerson = false
    uiStaticParameter.mUnionAccuseViewPerson = false
    uiStaticParameter.mUnionRedPackOpenViewPerson = false
end

function ondestroy()
    UIOtherPlayerMessagePanel:OnDestroy()
end
--endregion
return UIOtherPlayerMessagePanel