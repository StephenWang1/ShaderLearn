---@class UIAgainRefinePanel:UIBase 洗炼界面
local UIAgainRefinePanel = {}

local IsNullFunc = CS.StaticUtility.IsNull

---@type bagV2.BagItemInfo 当前选中道具信息
UIAgainRefinePanel.mCurrentChooseBagItemInfo = nil

--region 组件
--region 页签
---@return UnityEngine.GameObject 魂装按钮
function UIAgainRefinePanel:GetSoulBtn_Go()
    if self.mSoulBtnBtn == nil then
        self.mSoulBtnBtn = self:GetCurComp("WidgetRoot/events/btn_role", "GameObject")
    end
    return self.mSoulBtnBtn
end

---@return UISprite 魂装按钮图片
function UIAgainRefinePanel:GetSoulBtn_UISprite()
    if self.mSoulBtnSP == nil then
        self.mSoulBtnSP = self:GetCurComp("WidgetRoot/events/btn_role/icon", "UISprite")
    end
    return self.mSoulBtnSP
end

---@return UnityEngine.GameObject 魂装界面按钮选中
function UIAgainRefinePanel:GetSoulBtnChoose_Go()
    if self.mSoulChoose == nil then
        self.mSoulChoose = self:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "GameObject")
    end
    return self.mSoulChoose
end

---@return UnityEngine.GameObject 背包界面按钮
function UIAgainRefinePanel:GetBagBtn_Go()
    if self.mBagBtn == nil then
        self.mBagBtn = self:GetCurComp("WidgetRoot/events/btn_bag", "GameObject")
    end
    return self.mBagBtn
end

---@return UISprite 背包界面按钮图片
function UIAgainRefinePanel:GetBagBtn_UISprite()
    if self.mBagBtnSP == nil then
        self.mBagBtnSP = self:GetCurComp("WidgetRoot/events/btn_bag/icon", "UISprite")
    end
    return self.mBagBtnSP
end

---@return UnityEngine.GameObject 背包界面按钮选中
function UIAgainRefinePanel:GetBagBtnChoose_Go()
    if self.mBagBtnChoose == nil then
        self.mBagBtnChoose = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject")
    end
    return self.mBagBtnChoose
end
--endregion

---@return UnityEngine.GameObject 关闭界面按钮
function UIAgainRefinePanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 帮助按钮
function UIAgainRefinePanel:GetHelpBtn_Go()
    if self.mHelpBtn == nil then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    end
    return self.mHelpBtn
end

---@return UISprite 魂装图
function UIAgainRefinePanel:GetSoulIcon_UISprite()
    if self.mSoulSp == nil then
        self.mSoulSp = self:GetCurComp("WidgetRoot/view/ItemIcon", "UISprite")
    end
    return self.mSoulSp
end

---@return UILabel 魂装描述
function UIAgainRefinePanel:GetSoulDes_UILabel()
    if self.mSoulDesLb == nil then
        self.mSoulDesLb = self:GetCurComp("WidgetRoot/view/Attarribute/name", "UILabel")
    end
    return self.mSoulDesLb
end

---@return UILabel
function UIAgainRefinePanel:GetSoulDes2_UILabel()
    if self.mSoulDes2Lb == nil then
        self.mSoulDes2Lb = self:GetCurComp("WidgetRoot/view/Attarribute/attr", "UILabel")
    end
    return self.mSoulDes2Lb
end

---@return UISprite
function UIAgainRefinePanel:GetCostIcon_UISprite()
    if self.mCostIcon == nil then
        self.mCostIcon = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/money", "UISprite")
    end
    return self.mCostIcon
end

---@return UILabel
function UIAgainRefinePanel:GetCostNum_UILabel()
    if self.mCostNumLb == nil then
        self.mCostNumLb = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/goldNum", "UILabel")
    end
    return self.mCostNumLb
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetCostAdd_GO()
    if self.mCostAddGo == nil then
        self.mCostAddGo = self:GetCurComp("WidgetRoot/view/BtnRoot/gold/Add", "GameObject")
    end
    return self.mCostAddGo
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetRefineBtn_GO()
    if self.mRefineGo == nil then
        self.mRefineGo = self:GetCurComp("WidgetRoot/view/BtnRoot/btn_refine", "GameObject")
    end
    return self.mRefineGo
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetNothing_Go()
    if self.mNothingGO == nil then
        self.mNothingGO = self:GetCurComp("WidgetRoot/view/NoRefine", "GameObject")
    end
    return self.mNothingGO
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetBtnRoot_Go()
    if self.mBtnRootGO == nil then
        self.mBtnRootGO = self:GetCurComp("WidgetRoot/view/BtnRoot", "GameObject")
    end
    return self.mBtnRootGO
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetAtr_Go()
    if self.mAtrGO == nil then
        self.mAtrGO = self:GetCurComp("WidgetRoot/view/text", "GameObject")
    end
    return self.mAtrGO
end

---@return UnityEngine.GameObject
function UIAgainRefinePanel:GetEffect_Go()
    if self.mEffectGO == nil then
        self.mEffectGO = self:GetCurComp("WidgetRoot/view/ItemIcon/effect", "GameObject")
    end
    return self.mEffectGO
end
--endregion

--region 初始化
function UIAgainRefinePanel:Init()
    self:BindEvents()
    self:BindMessage()
    self:RefreshCost()
    self:RefreshCoinSprite()
    self:ChooseBagItemInfo(nil)
end

---@class AgainRefinePanelData
---@field mType LuaEnumAgainRefineType 打开界面类型
---@field mChooseSoulEquip bagV2.BagItemInfo 需要选中道具信息

---@param AgainRefinePanelData AgainRefinePanelData
function UIAgainRefinePanel:Show(AgainRefinePanelData)
    local openType = LuaEnumAgainRefineType.Soul
    if AgainRefinePanelData then
        if AgainRefinePanelData.mType then
            openType = AgainRefinePanelData.mType
        end
    end
    self:SwitchPanel(openType)

    if AgainRefinePanelData.mChooseSoulEquip then
        self.mNeedChooseSoul = AgainRefinePanelData.mChooseSoulEquip
    else
        self.mNeedChooseSoul = self:GetRoleEquip()
    end
end

function UIAgainRefinePanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetHelpBtn_Go()).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(188)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end

    CS.UIEventListener.Get(self:GetSoulBtn_Go()).onClick = function(go)
        self:SwitchPanel(LuaEnumAgainRefineType.Soul)
    end

    CS.UIEventListener.Get(self:GetBagBtn_Go()).onClick = function(go)
        self:SwitchPanel(LuaEnumAgainRefineType.Bag)
    end

    CS.UIEventListener.Get(self:GetRefineBtn_GO()).onClick = function(go)
        self:OnBtnClicked(go)
    end
end

function UIAgainRefinePanel:BindMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RolePanelClickedSoulEquip, function(msgId, soulInfo)
        self:ChooseBagItemInfo(soulInfo)
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, function(msgId, luaBagItemInfo)
        self:ChooseBagItemInfo(luaBagItemInfo)
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshCost()
    end)

    ---@param tblData equipV2.ResRefinResult
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRefinResultMessage, function(msgId, tblData)
        if tblData == nil then
            return
        end
        --local newEquip =

        if self.mCurrentChooseBagItemInfo then
            if self.mCurrentPanelType == LuaEnumAgainRefineType.Soul then
                local equipIndex = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetEquipIndexBySetSoulEquip(self.mCurrentChooseBagItemInfo.lid)
                local newBagItem = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetSoulEquipToEquipIndex(equipIndex)
                self:ChooseBagItemInfo(newBagItem, true)
            else
                local luaBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(self.mCurrentChooseBagItemInfo.lid)
                self:ChooseBagItemInfo(luaBagItemInfo, true)
            end
        end
        self:GetEffect_Go():SetActive(false)
        self:GetEffect_Go():SetActive(true)
    end)
end
--endregion

--region 切换界面
---@param type LuaEnumAgainRefineType
function UIAgainRefinePanel:SwitchPanel(type)
    self:SetPanelChooseState(type)
    self:SetToggleState(type)
    if type == LuaEnumAgainRefineType.Soul then
        self:SwitchToSoulPanel()
    elseif type == LuaEnumAgainRefineType.Bag then
        self:SwitchToBagPanel()
    end
    self.mCurrentPanelType = type
end

---设置页签选中
---@param type LuaEnumBloodSuitSmeltType 选中类型
function UIAgainRefinePanel:SetToggleState(type)
    local isBag = type == LuaEnumAgainRefineType.Bag
    local isSoul = type == LuaEnumAgainRefineType.Soul
    self:GetSoulBtn_UISprite().spriteName = isSoul and "c2" or "u2"
    self:GetBagBtn_UISprite().spriteName = isBag and "c1" or "u1"
    self:GetBagBtnChoose_Go():SetActive(isBag)
    self:GetSoulBtnChoose_Go():SetActive(isSoul)
end

---设置界面显示状态
function UIAgainRefinePanel:SetPanelChooseState(type)
    if self.mBagPanel and type ~= LuaEnumAgainRefineType.Bag then
        uimanager:HidePanel(self.mBagPanel)
    end

    if self.mSoulPanel and type ~= LuaEnumAgainRefineType.Soul then
        uimanager:HidePanel(self.mSoulPanel)
    end
end

---添加打开界面
function UIAgainRefinePanel:TryAddOpenPanel(panelName)
    if self.mAllOpenPanel == nil then
        self.mAllOpenPanel = {}
    end
    table.insert(self.mAllOpenPanel, panelName)
end
--endregion

--region 魂装
---跳转魂装
function UIAgainRefinePanel:SwitchToSoulPanel()
    if self.mSoulPanel == nil or IsNullFunc(self.mSoulPanel.go) then
        local panelName = "UIRolePanel"
        ---@type RolePanelParam
        local data = {}
        ---@type UIRolePanel_EquipTemplate_AgainSoulEquip
        data.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplate_AgainSoulEquip
        data.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateSoulEquipSet
        uimanager:CreatePanel(panelName, function(panel)
            self.mSoulPanel = panel
            self:TryAddOpenPanel(panelName)
            self:AfterCreateSoulPanel()
        end, data)
    else
        uimanager:ReShowPanel(self.mSoulPanel)
        self:AfterCreateSoulPanel()
    end
end

---创建魂装完成回调
function UIAgainRefinePanel:AfterCreateSoulPanel()
    if self.mNeedChooseSoul then
        self:ChooseBagItemInfo(self.mNeedChooseSoul)
        self.mNeedChooseSoul = nil
    end
end
--endregion

--region 背包
---跳转背包
function UIAgainRefinePanel:SwitchToBagPanel()
    if self.mBagPanel == nil or IsNullFunc(self.mBagPanel.go) then
        local panelName = "UIBagPanel"
        local data = {}
        data.type = LuaEnumBagType.AgainRefine
        -- data.focusedBagItemInfo = self:GetBagNeedChooseItem()
        uimanager:CreatePanel(panelName, function(panel)
            self.mBagPanel = panel
            self:TryAddOpenPanel(panelName)
            self:AfterCreateBagPanel()
        end, data)
    else
        uimanager:ReShowPanel(self.mBagPanel)
        self:AfterCreateBagPanel()
    end
end

---创建背包完成回调
function UIAgainRefinePanel:AfterCreateBagPanel()
end

--endregion

--region 洗炼
---选中道具
---@param bagItemInfo bagV2.BagItemInfo 选中道具信息 魂装就是魂装BagItemInfo
---@param needRefresh boolean 强制刷新
function UIAgainRefinePanel:ChooseBagItemInfo(bagItemInfo, needRefresh)
    if needRefresh ~= true then
        if bagItemInfo == self.mCurrentChooseBagItemInfo and bagItemInfo ~= nil then
            return
        end
    end
    self.mCurrentChooseBagItemInfo = bagItemInfo
    luaEventManager.DoCallback(LuaCEvent.AgainSoulChangeChooseItem, bagItemInfo)
    self:RefreshChooseItem(bagItemInfo)
end

---刷新界面显示
---@param bagItemInfo bagV2.BagItemInfo 选中道具信息
function UIAgainRefinePanel:RefreshChooseItem(bagItemInfo)
    local hasData = bagItemInfo ~= nil
    self:GetSoulIcon_UISprite().gameObject:SetActive(hasData)
    self:GetSoulDes2_UILabel().gameObject:SetActive(hasData)
    self:GetSoulDes_UILabel().gameObject:SetActive(hasData)
    self:GetNothing_Go():SetActive(not hasData)
    self:GetBtnRoot_Go():SetActive(hasData)
    self:GetAtr_Go():SetActive(hasData)
    if not hasData then
        return
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if luaItemInfo then
        self:GetSoulIcon_UISprite().spriteName = luaItemInfo:GetIcon()
    end
    ---魂装属性，Tips Copy过来的
    local height, lower = CS.Utility_Lua.DecodeHD(bagItemInfo.soulEffect, 32, 0x0ffffffff);
    if (lower ~= 0) then
        local signetTable = clientTableManager.cfg_signetManager:TryGetValue(lower)
        if (signetTable ~= nil) then
            self:GetSoulDes_UILabel().text = signetTable:GetSkillName()
            if (signetTable:GetParameter() ~= nil and signetTable:GetParameter().list.Count > 0) then
                self:GetSoulDes2_UILabel().text = luaEnumColorType.Purple .. string.CSFormat(signetTable:GetDescription(), signetTable:GetParameter().list[0]);
            end
        end
    end
end

function UIAgainRefinePanel:GetRoleEquip()
    local allEquip = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetAllBodySoulEquip()
    if allEquip then
        for k, v in pairs(allEquip) do
            local LuaSoulEquipVo = v
            local SoulEquip = LuaSoulEquipVo:GetSoulEquip()
            if SoulEquip ~= nil then
                return SoulEquip.bagItemInfo
            end
        end
    end
    return nil
end

--endregion

--region 刷新货币
function UIAgainRefinePanel:RefreshCost()
    if self.mCurrentChooseBagItemInfo == nil then

    end
    local itemId, itemNum = self:GetCostInfo()
    if itemId and itemNum then
        local playerHas = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemId)
        local color = playerHas >= itemNum and luaEnumColorType.Green or luaEnumColorType.Red
        self:GetCostNum_UILabel().text = color .. playerHas .. "[-]/" .. itemNum
        self.mCostEnough = playerHas >= itemNum
    end
end

function UIAgainRefinePanel:RefreshCoinSprite()
    local itemId, itemNum = self:GetCostInfo()
    if itemId and itemNum then
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        if res then
            self:GetCostIcon_UISprite().spriteName = itemInfo.icon
            CS.UIEventListener.Get(self:GetCostIcon_UISprite().gameObject).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
            end
        end
        CS.UIEventListener.Get(self:GetCostAdd_GO()).onClick = function()
            Utility.ShowItemGetWay(itemId, self:GetCostAdd_GO(), LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector2.zero)
        end
    end
end

---@return number,number 花费数据
function UIAgainRefinePanel:GetCostInfo()
    if self.mCostInfo == nil then
        self.mCostInfo = {}
        local info = LuaGlobalTableDeal.GetGlobalTabl(22832)
        if info then
            local strs = string.Split(info.value, '#')
            if #strs >= 2 then
                self.mCostInfo.itemId = tonumber(strs[1])
                self.mCostInfo.itemNum = tonumber(strs[2])
            end
        end
    end
    return self.mCostInfo.itemId, self.mCostInfo.itemNum
end

--endregion

--region 请求洗炼
function UIAgainRefinePanel:OnBtnClicked(go)
    if not self.mCostEnough then
        Utility.ShowPopoTips(go, nil, 462)
        return
    end
    if self.mCurrentChooseBagItemInfo then
        local type = self.mCurrentPanelType == LuaEnumAgainRefineType.Bag and 2 or 1
        networkRequest.ReqSoulEquipRefin(self.mCurrentChooseBagItemInfo.lid, type)
    end
end
--endregion

--region 销毁操作
function UIAgainRefinePanel:DestroyFunc()
    if self.mAllOpenPanel then
        for i = 1, #self.mAllOpenPanel do
            uimanager:ClosePanel(self.mAllOpenPanel[i])
        end
    end
end

function ondestroy()
    UIAgainRefinePanel:DestroyFunc()
end
--endregion

return UIAgainRefinePanel