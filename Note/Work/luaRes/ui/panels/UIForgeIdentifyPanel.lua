---@class UIForgeIdentifyPanel:UIBase 切割功能
local UIForgeIdentifyPanel = {}

--region 组件
---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/Btn_Close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnRole_GameObject()
    if (self.mGetBtnRole_GameObject == nil) then
        self.mGetBtnRole_GameObject = self:GetCurComp("WidgetRoot/events/btn_role", "GameObject");
    end
    return self.mGetBtnRole_GameObject;
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnBag_GameObject()
    if (self.mGetBtnBag_GameObject == nil) then
        self.mGetBtnBag_GameObject = self:GetCurComp("WidgetRoot/events/btn_bag", "GameObject");
    end
    return self.mGetBtnBag_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnDetail_GameObject()
    if (self.mBtnDetail_GameObject == nil) then
        self.mBtnDetail_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Attribute/template1/btn_details", "GameObject");
    end
    return self.mBtnDetail_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBtnUpgrade_GameObject()
    if (self.mBtnUpgrade_GameObject == nil) then
        self.mBtnUpgrade_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade", "GameObject");
    end
    return self.mBtnUpgrade_GameObject;
end

---@return UILabel
function UIForgeIdentifyPanel:GetBtnUpgrade_Label()
    if (self.mGetBtnUpgrade_Label == nil) then
        self.mGetBtnUpgrade_Label = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Btn_Upgrade/Label", "UILabel");
    end
    return self.mGetBtnUpgrade_Label;
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetRoleBg_GameObject()
    if (self.mGetRoleBg_GameObject == nil) then
        self.mGetRoleBg_GameObject = self:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "GameObject");
    end
    return self.mGetRoleBg_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetBagBg_GameObject()
    if (self.mGetBagBg_GameObject == nil) then
        self.mGetBagBg_GameObject = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject");
    end
    return self.mGetBagBg_GameObject;
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetEquip_GameObject()
    if (self.mGetEquip_GameObject == nil) then
        self.mGetEquip_GameObject = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "GameObject");
    end
    return self.mGetEquip_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetNoEquip_GameObject()
    if (self.mGetNoEquip_GameObject == nil) then
        self.mGetNoEquip_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/NoEquipment", "GameObject");
    end
    return self.mGetNoEquip_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetAttr_GameObject()
    if (self.mGetAttr_GameObject == nil) then
        self.mGetAttr_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Attribute", "GameObject");
    end
    return self.mGetAttr_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetCost_GameObject()
    if (self.mGetCost_GameObject == nil) then
        self.mGetCost_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/cost", "GameObject");
    end
    return self.mGetCost_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetSlider_GameObject()
    if (self.mGetSlider_GameObject == nil) then
        self.mGetSlider_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Slider", "GameObject");
    end
    return self.mGetSlider_GameObject
end

---@return UILabel
function UIForgeIdentifyPanel:GetForgeIdentifyName_Text()
    if (self.mForgeIdentifyName_Text == nil) then
        self.mForgeIdentifyName_Text = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/name", "UILabel");
    end
    return self.mForgeIdentifyName_Text
end

---@return UILabel
function UIForgeIdentifyPanel:GetFAttributeDes_Text()
    if (self.mGetFAttributeDes_Text == nil) then
        self.mGetFAttributeDes_Text = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Attribute/template1/Attribute/AttributeValue", "UILabel");
    end
    return self.mGetFAttributeDes_Text
end

---@return UILabel
function UIForgeIdentifyPanel:GetFAttributeName_Text()
    if (self.mGetFAttributeName_Text == nil) then
        self.mGetFAttributeName_Text = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Attribute/template2/Attribute/AttributeValue", "UILabel");
    end
    return self.mGetFAttributeName_Text
end

---@return UILabel
function UIForgeIdentifyPanel:GetForgeIdentifyCost_Text()
    if (self.mGetForgeIdentifyCost_Text == nil) then
        self.mGetForgeIdentifyCost_Text = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/cost/num", "UILabel");
    end
    return self.mGetForgeIdentifyCost_Text
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetForgeIdentifyCost_GameObject()
    if (self.mGetForgeIdentifyCost_GameObject == nil) then
        self.mGetForgeIdentifyCost_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/cost", "GameObject");
    end
    return self.mGetForgeIdentifyCost_GameObject
end

---@return UISprite
function UIForgeIdentifyPanel:GetForgeIdentifyIcon()
    if (self.mGetForgeIdentifyIcon == nil) then
        self.mGetForgeIdentifyIcon = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/cost/icon", "UISprite");
    end
    return self.mGetForgeIdentifyIcon
end

---@return UISprite
function UIForgeIdentifyPanel:GetItemIcon()
    if (self.mGetItemIcon == nil) then
        self.mGetItemIcon = self:GetCurComp("WidgetRoot/UIMainPanel/Background/thirdItem/icon", "UISprite");
    end
    return self.mGetItemIcon
end

---@return TweenFillAmount
function UIForgeIdentifyPanel:GetFillAmount_TweenScale()
    if (self.mGetFillAmount_TweenScale == nil) then
        self.mGetFillAmount_TweenScale = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/Slider/Foreground", "TweenFillAmount");
    end
    return self.mGetFillAmount_TweenScale
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetLock_GameObject()
    if (self.mGetLock_GameObject == nil) then
        self.mGetLock_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Background/thirdItem/Lock", "GameObject");
    end
    return self.mGetLock_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetItemIcon_GameObject()
    if (self.mGetItemIcon_GameObject == nil) then
        self.mGetItemIcon_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Background/thirdItem/icon", "GameObject");
    end
    return self.mGetItemIcon_GameObject
end

---@return UnityEngine.GameObject
function UIForgeIdentifyPanel:GetIcon_GameObject()
    if (self.mGetIcon_GameObject == nil) then
        self.mGetIcon_GameObject = self:GetCurComp("WidgetRoot/UIMainPanel/Background/thirdItem", "GameObject");
    end
    return self.mGetIcon_GameObject
end

---@return UIGridContainer
function UIForgeIdentifyPanel:GetGridContainer()
    if (self.mGetGridContainer == nil) then
        self.mGetGridContainer = self:GetCurComp("WidgetRoot/UIMainPanel/MainEquipPanel/ScrollView_Identify/Grid", "UIGridContainer")
    end
    return self.mGetGridContainer
end
--endregion

--region 初始化
function UIForgeIdentifyPanel:Init()
    self:BindUIEvents()
    self:BindMessage()
    self:InitEvents()
    self.isCycle = false
    self:GetBtnUpgrade_Label().text = "鉴定"
    self.sellectItemID = 1
    gameMgr:GetPlayerDataMgr():GetLuaForgeIdentifyMgr():SetRedPointShow(false)

end

function UIForgeIdentifyPanel:Show(custondata)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuthenticateDiamondNotEnough
    if custondata.bagItemInfo ~= nil then
        if custondata.bagItemInfo.index ~= 0 then
            self:ShowRole()
            self:ForGeIdentifyShow(custondata.bagItemInfo)
        elseif custondata.bagItemInfo.index == 0 and custondata.bagItemInfo.type ~= 2 then
            self:ShowBag()
            self:ForGeIdentifyShow(custondata.bagItemInfo)
        end
        self:ShowRole()
        self:GetAutoChooseBagItemInfo()
    else
        self:ShowRole()
        self:GetAutoChooseBagItemInfo()
    end
    self:ForGeIdentifyUpdate(true)
    self:BtnCost()
end

function UIForgeIdentifyPanel:ShowRole()
    uimanager:ClosePanel("UIBagPanel")
    self:GetRoleBg_GameObject():SetActive(true)
    self:GetBagBg_GameObject():SetActive(false)
    local roleData = {}
    roleData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateJianDing
    roleData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateJianDing
    uimanager:CreatePanel("UIRolePanel", function(panel)
        if (not CS.StaticUtility.IsNull(self.go)) then
            panel.leftArrow:SetActive(false)
            panel:ShowCloseButton(false);
            panel:SetSLToggle(false)
        end
    end, roleData)
end

function UIForgeIdentifyPanel:ShowBag()
    uimanager:ClosePanel("UIRolePanel")
    self:GetRoleBg_GameObject():SetActive(false)
    self:GetBagBg_GameObject():SetActive(true)
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.JianDing });
end

function UIForgeIdentifyPanel:BindUIEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.JianDingClick, function(id, data)
        self:ForGeIdentifyShow(data)
        self:BtnCost()
        self:ForGeIdentifyUpdate(true)
        self.sellectItemID = 1
    end)
end
function UIForgeIdentifyPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAppraisaResultMessage, UIForgeIdentifyPanel.OnResAppraisaResultMessageReceived)
end

function UIForgeIdentifyPanel:InitEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:BtnCost()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:ForGeIdentifyUpdate(false)
    end)
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local data = {}
        data.id = 229
        Utility.ShowHelpPanel(data)
    end
    CS.UIEventListener.Get(self:GetBtnRole_GameObject()).onClick = function()
        self:ShowRole()
    end
    CS.UIEventListener.Get(self:GetBtnBag_GameObject()).onClick = function()
        self:ShowBag()
    end
    CS.UIEventListener.Get(self:GetBtnDetail_GameObject()).onClick = function()
        if self.bagItemInfo ~= nil then
            uimanager:CreatePanel("UIForgeIdentifyTipsPanel", nil, self.bagItemInfo.itemId)
        end
    end
    CS.UIEventListener.Get(self:GetBtnUpgrade_GameObject()).onClick = function()
        if self.noEquip == true or self.noEquip == nil then
            CS.Utility.ShowTips("请选择一件装备鉴定")
            return
        end
        if self.IsUse == false or self.IsUse == nil then
            self.IsUse = true
            self:GetBtnUpgrade_Label().text = "取消鉴定"
            local state = gameMgr:GetPlayerDataMgr():GetLuaForgeIdentifyMgr():GetState()
            if tonumber(state) == 1 then
                self.attrType = 0
                self:JianDing()
            else
                self:OnCheck(self.sellectItemID)
            end
        elseif self.IsUse == true then
            self:RemoveCycle()
        end
    end
    CS.UIEventListener.Get(self:GetIcon_GameObject()).onClick = function()
        if self.bagItemInfo then
            uiStaticParameter.UIItemInfoManager:CreatePanel({bagItemInfo = self.bagItemInfo,showRight = false})
        end
    end
end
--endregion

--region 刷新界面
function UIForgeIdentifyPanel:Refresh()
    UIForgeIdentifyPanel:ForGeIdentifyUpdate(false)
    UIForgeIdentifyPanel:ForGeIdentifyShow(self.bagItemInfo)
end
--endregion

--region 服务器消息
function UIForgeIdentifyPanel.OnResAppraisaResultMessageReceived(id,data)
    UIForgeIdentifyPanel:OnServerRefresh(data)
    luaEventManager.DoCallback(LuaCEvent.RefreshCutDmg)
end
--endregion

--region 页面逻辑
---服务器回包刷新
function UIForgeIdentifyPanel:OnServerRefresh(data)
    self:ForGeIdentifyUpdate(false)
    self:RefreshAttr(data.appraisaEquip.appraisalQuality,data.appraisaEquip.appraisalAttr)
    self:ForGeIdentifyUpdate(false)
    self:BtnCost()
    self.bagItemInfo = data.appraisaEquip
    self.updateItem = CS.CSListUpdateMgr.Add(100, nil, function()
        if CS.StaticUtility.IsNull(self.go) == true then
            return
        end
        luaEventManager.DoCallback(LuaCEvent.RefreshCutDmg)
    end)
    if self:AutoUse() == true then
        self.IsUse = true
        self:JianDing()
    end
end
---鉴定二次确认弹窗
function UIForgeIdentifyPanel:OnCheck(type)
    if self.attrType > type + 1 and self.sellectItemID == type then
        local temp = {}
        temp.ID = 159
        temp.IsShowCloseBtn = false
        temp.CallBack = function()
            ---@type UIPromptPanel
            local panel=uimanager:GetPanel("UIPromptPanel")
            if panel~=nil then
                self.attrType = 0
                local isopen=panel:GetChooseState_UIToggle().value
                if isopen == true then
                    ---不再显示
                    networkRequest.ReqAppraisaTodaynOTip()
                end
            end
            uimanager:ClosePanel('UIPromptPanel')
            self:JianDing()
        end
        temp.CancelCallBack = function()
            ---@type UIPromptPanel
            self:GetBtnUpgrade_Label().text = "鉴定"
            self.IsUse = false
            local panel=uimanager:GetPanel("UIPromptPanel")
            if panel~=nil then
                local isopen=panel:GetChooseState_UIToggle().value
                if isopen == true then
                    ---不再显示
                    networkRequest.ReqAppraisaTodaynOTip()
                end
            end
            uimanager:ClosePanel('UIPromptPanel')

        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
        return
    else
        self:JianDing()
    end
end

---鉴定物品
function UIForgeIdentifyPanel:JianDing()
    if self:GetBtnUpgrade_GameObject() ~= nil then
        if self:SendJianDingCheck() then
            self:GetSlider_GameObject():SetActive(true)
            self:GetFillAmount_TweenScale():ResetToBeginning()
            self:GetFillAmount_TweenScale():PlayTween()
            self.updateItem = CS.CSListUpdateMgr.Add(500, nil, function()
                if CS.StaticUtility.IsNull(self.go) == true then
                    return
                end
                self:GetBtnUpgrade_Label().text = "鉴定"
                self:GetFillAmount_TweenScale():ResetToBeginning()
                self:GetSlider_GameObject():SetActive(false)
                self:SendJianDing()
                self.IsUse = false
            end)
        end
    end
end

-----循环使用
function UIForgeIdentifyPanel:AutoUse()
    if self.toggle == true and self.sellectItemID == 1 then
        self.isCycle = true
        return true
    else
        self.isUse = false
        self.isCycle = false
        return false
    end
end

---检查是否循环使用
function UIForgeIdentifyPanel:IsToggleOn(toggle)
    self.toggle = toggle
end

---自动选择物品
function UIForgeIdentifyPanel:GetAutoChooseBagItemInfo()
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    local tempItem
    if LuaPlayerEquipmentListData then
        local equipDic = LuaPlayerEquipmentListData.EquipmentDic
        for k, v in pairs(equipDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            if equipInfo.BagItemInfo then
                if self:GetJianDingTable(equipInfo.BagItemInfo) == true then
                    if tempItem == nil or tempItem.appraisalQuality > equipInfo.BagItemInfo.appraisalQuality then
                        tempItem = equipInfo.BagItemInfo
                    end
                end
            end
        end
        self:ForGeIdentifyShow(tempItem)
        self.curData = tempItem
        self.updateItem = CS.CSListUpdateMgr.Add(150, nil, function()
            luaEventManager.DoCallback(LuaCEvent.JiandingChoose, self.curData)
        end)
    end
    if self.curData == nil then
        self:GetNoEquip_GameObject():SetActive(true)
        self:GetForgeIdentifyName_Text().text = " "
        self:GetAttr_GameObject():SetActive(false)
        self:GetCost_GameObject():SetActive(false)
        self:GetSlider_GameObject():SetActive(false)
        self:GetItemIcon_GameObject():SetActive(false)
        self:GetLock_GameObject():SetActive(true)
        self.noEquip = true
    end
end

---发送鉴定请求
function UIForgeIdentifyPanel:SendJianDing()
    networkRequest.ReqAppraisaEquip(self.bagItemInfo.lid,self.sellectItemID,nil,self.bagItemInfo.index)
end

---查看是否可以发送鉴定请求
function UIForgeIdentifyPanel:SendJianDingCheck()
    local updateRequire = self:GetType()
    if updateRequire == nil then
        self.IsUse = false
        self:CannotJianDing()
        self.itemNum = false
        self:GetBtnUpgrade_Label().text = "鉴定"
        return false
    end
    local isHave = {}
    for i = 1, #updateRequire do
        local tempList = {}
        local costNeed = tonumber(updateRequire[i].need)
        local costId = tonumber(updateRequire[i].itemId)
        if costId == 1000002 or costId == 1000001 then
            tempList.item =costNeed <= gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costId)
        else
            tempList.item = costNeed <= gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(costId)
        end
        table.insert(isHave,tempList)
    end
    if self.sellectItemID ~= 3 then
        if isHave[1].item and isHave[2].item then
            self.itemNum = true
            return true
        else
            if isHave[1].item then
                if tonumber(updateRequire[2].itemId) == 1000001 then
                    Utility.TryShowFirstRechargePanel()
                elseif tonumber(updateRequire[2].itemId) == 1000002 then
                    Utility.ShowItemGetWay(tonumber(updateRequire[2].itemId), self.mBtnUpgrade_GameObject)
                end
            else
                self:CannotJianDing()
            end
            self.itemNum = false
            self:GetBtnUpgrade_Label().text = "鉴定"
            self.IsUse = false
            return false
        end
    elseif self.sellectItemID == 3 then
        if isHave[1].item then
            self.itemNum = true
            return true
        else
            self.IsUse = false
            self:CannotJianDing()
            self.itemNum = false
            self:GetBtnUpgrade_Label().text = "鉴定"
            return false
        end
    end
end

---鉴定失败
function UIForgeIdentifyPanel:CannotJianDing()
    CS.Utility.ShowTips("鉴定所需材料不足")
end

--endregion

--region鉴定界面显示
---@param bagItemInfo bagV2.BagItemInfo
function UIForgeIdentifyPanel:ForGeIdentifyShow(bagItemInfo)
    if bagItemInfo then
        self.bagItemInfo = bagItemInfo
        local itemData = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if itemData then
            self.noEquip = false
            self:GetBtnUpgrade_Label().text = "鉴定"
            self:GetItemIcon_GameObject():SetActive(true)
            self:GetAttr_GameObject():SetActive(true)
            self:GetCost_GameObject():SetActive(true)
            self:GetSlider_GameObject():SetActive(true)
            self:GetLock_GameObject():SetActive(false)
            self:GetNoEquip_GameObject():SetActive(false)
            self:GetForgeIdentifyName_Text().text = itemData:GetName()
            self:GetItemIcon().spriteName = itemData:GetIcon()
            self:GetSlider_GameObject():SetActive(false)
            self:RefreshAttr(bagItemInfo.appraisalQuality,bagItemInfo.appraisalAttr)
        end
    end
end

---刷新切割属性
function UIForgeIdentifyPanel:RefreshAttr(type,index)
    local attrValue = self:GetAttrTable(type,index)
    self.attrType = type
    self:GetFAttributeDes_Text().text = "["..attrValue.color.."]"..attrValue.des
    self:GetFAttributeName_Text().text = "["..attrValue.color.."]"..index
end

---获取鉴定键值
function UIForgeIdentifyPanel:GetAttrTable(type,index)
    local getTable = self:GetGlobalTable(23005)
    local getColor = self:GetGlobalTable(23006)
    local tableIndex = {}
    local attrInfo = string.Split(getTable.value,"&")
    for i = 1, #attrInfo do
        local attrIndex =  string.Split(attrInfo[i],"#")
        if tonumber(attrIndex[1]) == type then
            tableIndex.des = attrIndex[2]
        end
    end
    local colorInfo = string.Split(getColor.value,"&")
    for i = 1, #colorInfo do
        local colorIndex =  string.Split(colorInfo[i],"#")
        if tonumber(colorIndex[1]) == type then
            tableIndex.color = colorIndex[2]
            return tableIndex
        end
    end
end

---获取鉴定数据
function UIForgeIdentifyPanel:GetJianDingData()
    if self.bagItemInfo ~= nil then
        local singleData ={}
        ---普通鉴定
        local normalData=self:GetCountdataList(1)
        ---稀有鉴定
        local raData=self:GetCountdataList(2)
        ---完美鉴定
        local perData=self:GetCountdataList(3)
        if normalData == nil then
            return
        end
        table.insert(singleData,normalData)
        table.insert(singleData,raData)
        local showReq = tonumber(perData[1].need)
        local showHave = tonumber(perData[1].itemId)
        if showReq <= gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(showHave) then
            table.insert(singleData,perData)
        end
        ---鉴定描述
        local desc ={"普通鉴定","稀有鉴定","完美鉴定"}
        local dataList={}
        for i = 1, #singleData do
            local data={}
            data.itemId = singleData[i][1].itemId
            data.name=desc[i]
            data.id=i
            data.cost = singleData[i][1].count
            data.needShow = singleData[i][1].needShow
            table.insert(dataList,data)
        end
        return dataList
    end
end

---选择当前type
function UIForgeIdentifyPanel:ChooseItem(sellectItemID)
    self.sellectItemID = sellectItemID
    for i, v in pairs(self.TemplateList) do
        v:RefreShChoose(sellectItemID)
    end
    self:BtnCost()
end

---鉴定按钮
function UIForgeIdentifyPanel:BtnCost()
    if self.bagItemInfo ~= nil then
        local costId = self:GetType()
        if costId == nil then
            return
        end
        if self.sellectItemID ~= 3 then
            self:GetForgeIdentifyCost_GameObject():SetActive(true)
            local costNeed = tonumber(costId[2].need)
            local costItem = tonumber(costId[2].itemId)
            local costHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costItem)
            if costHave >= costNeed then
                self:GetForgeIdentifyCost_Text().text = "[00ff00]"..costHave.."[-]/"..costId[2].need
            else
                self:GetForgeIdentifyCost_Text().text = "[ff0000]"..costHave.."[-]/"..costId[2].need
            end
            self:GetForgeIdentifyIcon().spriteName = costId[2].itemId
        else
            self:GetForgeIdentifyCost_GameObject():SetActive(false)
        end
    end
end

---获取当前选择页面
function UIForgeIdentifyPanel:GetType()
    if self.bagItemInfo ~= nil then
        local updateRequire = {}
        if self.sellectItemID == 1 then
            updateRequire = self:GetCountdataList(1)
        elseif self.sellectItemID == 2 then
            updateRequire = self:GetCountdataList(2)
        elseif self.sellectItemID == 3 then
            updateRequire = self:GetCountdataList(3)
        end
        return updateRequire
    end
end

---获取table内容
function UIForgeIdentifyPanel:GetCountdataList(id)
    local itemId
    local tableInfo = self:GetJianDingCostTable(self.bagItemInfo)
    if tableInfo == nil then
        return
    end
    if id == 1 then
        itemId = tableInfo:GetNormalConsume()
    elseif id == 2 then
        itemId = tableInfo:GetRareConsume()
    elseif id == 3 then
        itemId = tableInfo:GetPerfectConsume()
    end
    local numList = itemId
    if id ~= 3 then
        numList = string.Split(itemId, "&")
    end
    local countdataList={}
    for i = 1, #numList do
        local tempData={}
        local temp
        if id ~= 3 then
            temp = string.Split(numList[i], "#")
        else
            temp = string.Split(numList, "#")
        end
        local itemHave = tonumber(temp[1])
        local curHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemHave)
        tempData.itemId=temp[1]
        local curNeed = tonumber(temp[2])
        if curHave >= curNeed then
            tempData.count = "[00ff00]"..curHave.."[-]/"..temp[2]
        else
            tempData.needShow = true
            tempData.count = "[ff0000]"..curHave.."[-]/"..temp[2]
        end
        tempData.need = temp[2]
        table.insert(countdataList,tempData)
    end
    return countdataList
end

---升级材料界面（写死）
function UIForgeIdentifyPanel:ForGeIdentifyUpdate(boolean)
    if self.bagItemInfo ~= nil then
        local dataList = self:GetJianDingData()
        if dataList == nil then
            return
        end
        self:GetGridContainer().MaxCount = #dataList
        self.TemplateList = {}
        for i = 1, #dataList do
            local item = self:GetGridContainer().controlList[i - 1]
            if self.TemplateList[item] == nil then
                self.TemplateList[item] = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIForgeIdentifyTemplate)
            end
            self.TemplateList[item]:RefreshUI(dataList[i], self)
            if boolean == true then
                self.TemplateList[item]:RefreshChoose(dataList[i])
            end
        end
    end
end

---移除自动循环
function UIForgeIdentifyPanel:RemoveCycle()
    CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
    self:GetBtnUpgrade_Label().text = "鉴定"
    self:GetFillAmount_TweenScale():ResetToBeginning()
    self:GetSlider_GameObject():SetActive(false)
    self.IsUse = false
    self.updateItem=nil
end
--endregion

--region是否可鉴定
function UIForgeIdentifyPanel:GetJianDingTable(bagItemInfo)
    local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if Lua_jianDingTABLE:GetJianDing() == 1 then
        return true
    else
        return false
    end
end
--endregion

--region 获取鉴定消耗table

function UIForgeIdentifyPanel:GetJianDingCostTable(bagItemInfo)
    local Lua_jianDingCost = clientTableManager.cfg_jiandingManager:TryGetValue(bagItemInfo.itemId)
    return Lua_jianDingCost
end
--endregion

--region读取global表
function UIForgeIdentifyPanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    return Lua_GlobalTABLE
end
--endregion

function update()
    UIForgeIdentifyPanel:OnUpdate()
end

function UIForgeIdentifyPanel:OnUpdate()
    if self.isUse == false and self:AutoUse() == false and self.isCycle == true and self.sellectItemID == 1 then
        if self.updateItem~=nil then
            self:RemoveCycle()
        end
    end
    if self.attrType ~= nil then
        if self.attrType > 2 and self.sellectItemID == 1 then
            if self.updateItem~=nil then
                self:RemoveCycle()
            end
        end
    end
end

function UIForgeIdentifyPanel:OnDestroy()
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint))
end

function ondestroy()
    UIForgeIdentifyPanel:OnDestroy()
    uimanager:ClosePanel("UIBagPanel")
    uimanager:ClosePanel("UIRolePanel")
    if self.updateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.updateItem)
        self.updateItem = nil
    end
end
return UIForgeIdentifyPanel