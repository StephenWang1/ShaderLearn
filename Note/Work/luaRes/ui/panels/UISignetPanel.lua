local UISignetPanel = {}

setmetatable(UISignetPanel, luaPanelModules.UIForgeRightPanelBase)

function UISignetPanel:InitComponents()
    ---当前选中部位
    UISignetPanel.itemTemplate = self:GetCurComp("WidgetRoot/view/itemTemplate", "GameObject")
    ---当前选中部位Box
    UISignetPanel.itemTemplateBox = self:GetCurComp("WidgetRoot/view/itemTemplate", "BoxCollider")
    ---当前选中部位名称
    UISignetPanel.itemTemplateName = self:GetCurComp("WidgetRoot/view/itemTemplate/name", "Top_UILabel")
    ---当前选中物品Icon
    UISignetPanel.ItemIcon = self:GetCurComp("WidgetRoot/view/itemTemplate/icon", "Top_UISprite")
    ---当前选中物品Icon
    UISignetPanel.Euqip_add = self:GetCurComp("WidgetRoot/view/itemTemplate/Euqip_add", "Top_UISprite")
    ---当前选中物品镶嵌印记Icon
    UISignetPanel.ItemSignetIcon = self:GetCurComp("WidgetRoot/view/itemTemplate/signetIcon", "Top_UISprite")
    ---当前选中物品镶嵌印记Icon移除
    UISignetPanel.ItemSignetIconRemove = self:GetCurComp("WidgetRoot/view/itemTemplate/signetIcon/remove", "GameObject")
    ---当前选中物品镶嵌印记加号
    UISignetPanel.Signet_add = self:GetCurComp("WidgetRoot/view/itemTemplate/Signet_add", "GameObject")

    ---背包印记
    UISignetPanel.stoneList = self:GetCurComp("WidgetRoot/view/stoneList/stone", "GameObject")
    ---背包印记Top_SpringPanel
    UISignetPanel.stoneListUIPanel = self:GetCurComp("WidgetRoot/view/stoneList/stone/stoneList", "UIPanel")
    ---背包印记Top_SpringPanel
    UISignetPanel.stoneListSpringPanel = self:GetCurComp("WidgetRoot/view/stoneList/stone/stoneList", "Top_SpringPanel")

    ---背包印记列表
    UISignetPanel.activityBtns = self:GetCurComp("WidgetRoot/view/stoneList/stone/stoneList/activityBtns", "Top_UIGridContainer")

    UISignetPanel.noSignet = self:GetCurComp("WidgetRoot/view/stoneList/NoSignet", "GameObject")

    UISignetPanel.noSignet_UISprite = self:GetCurComp("WidgetRoot/view/stoneList/NoSignet/Label", "Top_UISprite")

    UISignetPanel.noSignetGet_GameObject = self:GetCurComp("WidgetRoot/view/stoneList/NoSignet/Get", "GameObject")

    ---添加印记
    UISignetPanel.AddBtnTemplate = self:GetCurComp("WidgetRoot/view/AddBtnTemplate", "GameObject")
    ---添加印记没有可镶嵌物品
    UISignetPanel.AddBtnNoSignetTips = self:GetCurComp("WidgetRoot/view/AddBtnTemplate/NoSignetTips", "GameObject")
    ---添加印记锁
    UISignetPanel.AddBtnTemplateLock = self:GetCurComp("WidgetRoot/view/lock", "GameObject")
    ---当前镶嵌印记
    UISignetPanel.stoneTemplate = self:GetCurComp("WidgetRoot/view/stoneTemplate", "GameObject")
    ---当前镶嵌印记图标
    UISignetPanel.stoneTemplate_icon = self:GetCurComp("WidgetRoot/view/stoneTemplate/icon", "Top_UISprite")

    ---镶嵌按钮
    UISignetPanel.btn_use = self:GetCurComp("WidgetRoot/events/btn_use", "GameObject")
    ---镶嵌按钮文本
    UISignetPanel.btn_useLabel = self:GetCurComp("WidgetRoot/events/btn_use/Label", "Top_UILabel")
    ---卸下
    UISignetPanel.btn_unsnatch = self:GetCurComp("WidgetRoot/events/btn_unsnatch", "GameObject")

    ---印记描述GameObject
    UISignetPanel.stoneInfo = self:GetCurComp("WidgetRoot/view/stoneInfo", "GameObject")
    --箭头
    UISignetPanel.arrow = self:GetCurComp("WidgetRoot/view/stoneInfo/arrow", "GameObject")
    --更好的印记标记
    UISignetPanel.goodArrow = self:GetCurComp("WidgetRoot/view/stoneInfo/good", "GameObject")
    ---印记描述_印记名称
    UISignetPanel.stoneInfo_ElementType = self:GetCurComp("WidgetRoot/view/stoneInfo/ElementType", "Top_UILabel")
    ---印记描述_印记详细描述
    UISignetPanel.stoneInfo_AttackType = self:GetCurComp("WidgetRoot/view/stoneInfo/AttackType", "Top_UILabel")
    ---没有装备提示
    UISignetPanel.NoEquipTips = self:GetCurComp("WidgetRoot/view/NoEquipTips", "UILabel")
    ---冲突提示
    UISignetPanel.ClashTips = self:GetCurComp("WidgetRoot/view/stoneInfo/ClashTips", "GameObject")
    ---冲突提示2
    UISignetPanel.ClashTips2 = self:GetCurComp("WidgetRoot/view/stoneInfo/ClashTips2", "GameObject")
    ---系统说明按钮
    UISignetPanel.help_Btn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")

    --印记标题描
    UISignetPanel.headlineDes = self:GetCurComp("WidgetRoot/view/headlineDes", "GameObject")
    ---印记标题描述上
    UISignetPanel.headlineDesUp = self:GetCurComp("WidgetRoot/view/headlineDes/desUp", "Top_UILabel")
    ---印记标题描述下
    UISignetPanel.headlinedesDown = self:GetCurComp("WidgetRoot/view/headlineDes/desDown", "Top_UILabel")
    --没有可镶嵌装备提示
    UISignetPanel.NoEquipment = self:GetCurComp("WidgetRoot/view/NoEquipment", "GameObject")
    --没有可镶嵌装备提示Label
    UISignetPanel.NoEquipmentLabel = self:GetCurComp("WidgetRoot/view/NoEquipment/Label", "Top_UILabel")
    --没有可镶嵌装备提示
    UISignetPanel.NoEquipmentGet_GameObject = self:GetCurComp("WidgetRoot/view/NoEquipment/Get", "GameObject")


    --成功特效
    UISignetPanel.Successfuleffect = self:GetCurComp("WidgetRoot/view/Successfuleffect", "GameObject")


end

function UISignetPanel:InitOther()
    ---选择道具特效
    UISignetPanel.ItemEffect = nil
    ---背包印记列表
    UISignetPanel.BagSignetList = nil
    ---背包印记模板列表
    UISignetPanel.BagSignetTemplateList = {}
    ---当前选中的印记模板
    UISignetPanel.SelectSignet = nil
    ---imprintV2.ResImprintInfo 
    UISignetPanel.ImprintInfo = nil
    --当前选中格子
    UISignetPanel.NowSelectEquipIndex = -1
    --格子信息
    UISignetPanel.RolePanel_GridTemplateSignet = nil

    UISignetPanel.noSignetPosition = UISignetPanel.noSignet.transform.localPosition
    UISignetPanel.headlineDesPosition = UISignetPanel.headlineDes.transform.localPosition
    UISignetPanel.stoneInfoPosition = UISignetPanel.stoneInfo.transform.localPosition
    UISignetPanel.SpringPanellocalPosition = UISignetPanel.stoneListSpringPanel.transform.localPosition
    UISignetPanel.SpringPanellocalPositionY = UISignetPanel.stoneListSpringPanel.transform.localPosition.y
    --UISignetPanel.PanelSizeY=self.stoneListUIPanel:GetViewSize().y
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, UISignetPanel.RefreshUI)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPutOnImprintMessage, UISignetPanel.ResPutOnImprintMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPutOnImprintMessage, UISignetPanel.ResEffectShow)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTakeOffImprintMessage, UISignetPanel.ResPutOnImprintMessage)

    --点击物品
    CS.UIEventListener.Get(UISignetPanel.itemTemplate.gameObject).onClick = UISignetPanel.ShowItemInfoPanel
    --镶嵌
    CS.UIEventListener.Get(UISignetPanel.btn_use).onClick = UISignetPanel.ReqInlay
    --移除
    CS.UIEventListener.Get(UISignetPanel.ItemSignetIconRemove.gameObject).onClick = UISignetPanel.ReqDisboard
    --帮助
    CS.UIEventListener.Get(UISignetPanel.help_Btn).onClick = UISignetPanel.OnClickHelpBtn
    --获取高级装备
    CS.UIEventListener.Get(UISignetPanel.NoEquipmentGet_GameObject).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.UISecretBookPanel_GetEquip)
    end
    --获取印记
    CS.UIEventListener.Get(UISignetPanel.noSignetGet_GameObject).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.UISecretBookPanel_Signet)
    end
    --点击加号
    CS.UIEventListener.Get(UISignetPanel.Euqip_add.gameObject).onClick = function()
        UISignetPanel.ShowTips(UISignetPanel.Euqip_add.transform, 230)
    end
end

---创建角色面板
function UISignetPanel:CreateRolePanel()
    local commonData = { equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateSignet, equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateSignet, isShowCloseBtn = false, isShowArrowBtn = false }
    uimanager:CreatePanel("UIRolePanel", function(panel)
        panel:ShowCloseButton(false)
        panel:SetSLToggle(false)
        UISignetPanel.SelectEquipShow()
    end, commonData)
end

function UISignetPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function update()

    if (UISignetPanel.mDelayShowUIRolePanel ~= nil) then
        UISignetPanel.mDelayShowUIRolePanel = UISignetPanel.mDelayShowUIRolePanel - 1
        if UISignetPanel.mDelayShowUIRolePanel == 0 then
            UISignetPanel.mDelayShowUIRolePanel = nil
            ---@type UIRolePanel
            local rolePanel = uimanager:GetPanel("UIRolePanel")
            if rolePanel == nil then
                UISignetPanel:CreateRolePanel()
            else
                rolePanel:SetSLToggle(false)
            end
        end
    end
end

function UISignetPanel:Show(customData)
    if (customData ~= nil) then
        UISignetPanel.chooseEquipIndex = customData.chooseEquipIndex
        UISignetPanel.chooseSignetmBagItemInfo = customData.chooseSignetmBagItemInfo
    end
    UISignetPanel.SelectEquipShow()
    networkRequest.ReqImprintInfo()
    UISignetPanel.AddBtnTemplate.gameObject:SetActive(false);
    UISignetPanel.mDelayShowUIRolePanel = 2
    uimanager:ClosePanel("UIBagPanel");
    --UISignetPanel.Signet_add.gameObject:SetActive(false);
    --    UISignetPanel.NoEquipmentLabel.text='[ff0000]请选择一件'..CS.Cfg_GlobalTableManager.Instance.InlaySignetminLevel..'级以上装备'
end

function UISignetPanel.SelectEquipShow()
    local index = 0
    if UISignetPanel.chooseEquipIndex == nil or UISignetPanel.chooseEquipIndex == -1 then
        index = CS.CSScene.MainPlayerInfo.SignetV2:EquipSignetSelect();
    else
        index = UISignetPanel.chooseEquipIndex
    end
    luaEventManager.DoCallback(LuaCEvent.Signet_SelectEquipShow, index);
end

---刷新
function UISignetPanel:RefreshUI(item)

    if item == nil then
        return
    end
    if item.bagItemInfo == nil then
        return
    end
    UISignetPanel.RolePanel_GridTemplateSignet = item
    UISignetPanel.BagSignetList = CS.CSScene.MainPlayerInfo.SignetV2:GetBagSignetList(item.bagItemInfo.ItemTABLE, item.equipIndex)
    UISignetPanel.ImprintInfoDic = CS.CSScene.MainPlayerInfo.SignetV2.ImprintInfoDic
    UISignetPanel.NowIndexImprintInfo = UISignetPanel.GetNowIndexImprintInfo()
    if UISignetPanel.IsIndexMayInlay(item) then
        return
    end
    UISignetPanel.NoEquipment.gameObject:SetActive(false)
    UISignetPanel.ShowItemInfoPanel()
    -- UISignetPanel:RefresItemEffect(item)
    UISignetPanel.EquipInlaySignetRefresh()
    UISignetPanel.TopInfoRefresh()
    UISignetPanel.SignetListRefresh()
    UISignetPanel.RefreshBtnShowInfo(true)
    UISignetPanel.DefaultSelect()

end

--region 角色面板-提示处理
--背包长按事件
function UISignetPanel.Bag_GridHolden(item, item2)

end
---选中部位是否可镶嵌
function UISignetPanel.IsIndexMayInlay(item)
    local IsMayInlay = item.IsMayInlay
    if IsMayInlay == false then
        UISignetPanel.ShowTips(item.go.transform, 231)
        return true
    end
    return false
end

---显示道具信息面板
function UISignetPanel.ShowItemInfoPanel()
    local item = UISignetPanel.RolePanel_GridTemplateSignet
    if UISignetPanel.NowSelectEquipIndex == item.equipIndex then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = item.bagItemInfo, showRight = false })
    end
    UISignetPanel.NowSelectEquipIndex = item.equipIndex
end

---装备显示印记刷新
function UISignetPanel.EquipInlaySignetRefresh()
    UISignetPanel.RolePanel_GridTemplateSignet:GetYinJiIcon_UISprite().gameObject:SetActive(UISignetPanel.NowIndexImprintInfo ~= nil)
    if UISignetPanel.NowIndexImprintInfo ~= nil then
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(UISignetPanel.NowIndexImprintInfo.id);
        UISignetPanel.NowIndexImprintItemInfo = itemTable
        if isFind then
            UISignetPanel.RolePanel_GridTemplateSignet:GetYinJiIcon_UISprite().spriteName = itemTable.icon;
        end
    else
        UISignetPanel.NowIndexImprintItemInfo = nil
    end
end

---刷新道具选中特效
function UISignetPanel:RefresItemEffect(item)
    if item == nil then
        return
    end

    local parent = item.go.gameObject.transform:Find('background');
    if UISignetPanel.ItemEffect == nil then
        UISignetPanel.ItemEffect = item.go.gameObject.transform:Find('background/ItemEffect');
        if UISignetPanel.ItemEffect ~= nil then
            UISignetPanel.ItemEffect:SetActive(true)

            return
        end
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("800014", CS.ResourceType.UIEffect, function(res)
            if parent ~= nil then
                local poolItem = res:GetUIPoolItem()
                if poolItem ~= nil then
                    UISignetPanel.ItemEffect = poolItem.go
                end
                if UISignetPanel.ItemEffect then
                    if item.go ~= nil then
                        UISignetPanel.ItemEffect.transform.parent = item.go.gameObject.transform:Find('background');
                        UISignetPanel.ItemEffect.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
                        UISignetPanel.ItemEffect.transform.localScale = CS.UnityEngine.Vector3.one
                        UISignetPanel.ItemEffect:SetActive(true)
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        if UISignetPanel.ItemEffect == nil then
            UISignetPanel.ItemEffect = nil
            return
        end
        UISignetPanel.ItemEffect.transform.parent = item.go.gameObject.transform:Find('background');
        UISignetPanel.ItemEffect.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
        UISignetPanel.ItemEffect.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
        UISignetPanel.ItemEffect:SetActive(true)
    end
end

--endregion
--region 印记面板-顶部道具信息处理
function UISignetPanel.TopInfoRefresh()
    local item = UISignetPanel.RolePanel_GridTemplateSignet
    UISignetPanel.itemTemplate.gameObject:SetActive(true)
    local IsHava = item ~= nil and item.bagItemInfo ~= nil and item.bagItemInfo.ItemTABLE ~= nil
    if IsHava then
        UISignetPanel.ItemIcon.spriteName = item.bagItemInfo.ItemTABLE.icon
        UISignetPanel.itemTemplateName.text = item.bagItemInfo.ItemTABLE.name
    else
        UISignetPanel.itemTemplateName.text = ''
    end
    UISignetPanel.Euqip_add.gameObject:SetActive(not IsHava)
    if UISignetPanel.NowIndexImprintItemInfo ~= nil then
        UISignetPanel.ItemSignetIcon.spriteName = UISignetPanel.NowIndexImprintItemInfo.icon
    end
    UISignetPanel.ItemIcon.gameObject:SetActive(IsHava)
    UISignetPanel.ItemSignetIcon.gameObject:SetActive(UISignetPanel.NowIndexImprintItemInfo ~= nil)
    UISignetPanel.Signet_add.gameObject:SetActive(UISignetPanel.NowIndexImprintItemInfo == nil)

    local desup = ''
    local desDown = ''
    if UISignetPanel.NowIndexImprintItemInfo ~= nil then
        desup = UISignetPanel.NowIndexImprintItemInfo.name .. UISignetPanel.GetAdditionName(UISignetPanel.NowIndexImprintItemInfo)
        local fuDong = 0;
        if UISignetPanel.ImprintInfoDic ~= nil then
            local imp = UISignetPanel.ImprintInfoDic[item.bagItemInfo.index]
            if imp ~= nil then
                fuDong = imp.fuDong
            end
        end

        desDown = CS.Cfg_SignetTableManager.Instance:GetDescription(UISignetPanel.NowIndexImprintItemInfo.id, fuDong, false)
        UISignetPanel.NowInlaySignetValue, UISignetPanel.NowInlaySignetValueType = CS.Cfg_SignetTableManager.Instance:GetSignetValue(UISignetPanel.NowIndexImprintItemInfo.id, fuDong)
        UISignetPanel.stoneInfoPosition.x = -70
    else
        desup = ""
        UISignetPanel.stoneInfoPosition.x = -172
    end
    UISignetPanel.headlineDesUp.text = desup
    UISignetPanel.headlinedesDown.text = desDown
    UISignetPanel.arrow.gameObject:SetActive(UISignetPanel.NowIndexImprintItemInfo ~= nil)
    UISignetPanel.stoneInfo.transform.localPosition = UISignetPanel.stoneInfoPosition
end



--endregion
--region 印记面板-中部信息处理
--设置印记列表
function UISignetPanel.SignetListRefresh()
    UISignetPanel.stoneList:SetActive(true)
    UISignetPanel.headlineDesPosition.x = 0
    UISignetPanel.noSignetPosition.y = -125
    local des = ''
    if UISignetPanel.NowIndexImprintInfo == nil then
        --没有可镶嵌印记
        des = 'NoSignetTips'
        UISignetPanel.noSignet_UISprite.spriteName = des
    else
        --没有可替换印记
        des = 'NoSignetReplace'
        UISignetPanel.noSignetPosition.y = -227
    end
    UISignetPanel.noSignet_UISprite.gameObject:SetActive(UISignetPanel.NowIndexImprintInfo == nil)
    UISignetPanel.noSignet.transform.localPosition = UISignetPanel.noSignetPosition
    UISignetPanel.noSignet.gameObject:SetActive(UISignetPanel.BagSignetList.Count == 0)
    if UISignetPanel.BagSignetList.Count == 0 then
        if UISignetPanel.NowIndexImprintInfo == nil then
            UISignetPanel.headlineDesUp.text = ''
        else
            UISignetPanel.headlineDesPosition.x = 109
        end
        UISignetPanel.stoneList.gameObject:SetActive(false)
    end
    UISignetPanel.headlineDes.transform.localPosition = UISignetPanel.headlineDesPosition
    UISignetPanel.activityBtns.MaxCount = UISignetPanel.BagSignetList.Count
    for i = 0, UISignetPanel.BagSignetList.Count - 1 do
        local data = UISignetPanel.BagSignetList[i]
        local item = UISignetPanel.activityBtns.controlList[i].gameObject
        local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UISignetPanel_ItemTemplates)
        template:RefreshUI(data, UISignetPanel)
        UISignetPanel.BagSignetTemplateList[i] = template
    end
end

--endregion
--region 印记面板-底部信息处理
---刷新按钮显示信息
function UISignetPanel.RefreshBtnShowInfo(isshow)
    local isOpen = isshow and UISignetPanel.BagSignetList ~= nil and UISignetPanel.BagSignetList.Count ~= 0
    UISignetPanel.btn_use.gameObject:SetActive(isOpen)
    if isshow == false then

        return
    end
    local Des = ''
    if UISignetPanel.NowIndexImprintInfo ~= nil then
        Des = '更换'
    else
        Des = '镶嵌'
    end
    UISignetPanel.btn_useLabel.text = Des

end

---设置背包当前选中的印记
function UISignetPanel.SelectBagSignet(data)
    if data == nil then
        return
    end
    local imprintInfo = data.BagItemInfo.imprint
    for i = 0, #UISignetPanel.BagSignetTemplateList do
        if data == UISignetPanel.BagSignetTemplateList[i].data then
            UISignetPanel.SelectSignet = UISignetPanel.BagSignetTemplateList[i]
        end
        UISignetPanel.BagSignetTemplateList[i].choose:SetActive(data == UISignetPanel.BagSignetTemplateList[i].data)
    end
    -- local color = luaEnumColorType.White
    -- if UISignetPanel.SelectSignet ~= nil and UISignetPanel.SelectSignet.data.IsBetter then
    --     color = luaEnumColorType.Green
    -- end
    if UISignetPanel.SelectSignet.TABEL_Item ~= nil then
        UISignetPanel.stoneInfo_ElementType.text = UISignetPanel.SelectSignet.TABEL_Item.name .. UISignetPanel.GetAdditionName(UISignetPanel.SelectSignet.TABEL_Item)
        UISignetPanel.stoneInfo_AttackType.text = CS.Cfg_SignetTableManager.Instance:GetDescription(UISignetPanel.SelectSignet.TABEL_Item.id, imprintInfo, false)
        UISignetPanel.stoneInlaySignet, UISignetPanel.stoneInlaySignetType = CS.Cfg_SignetTableManager.Instance:GetSignetValue(UISignetPanel.SelectSignet.TABEL_Item.id, imprintInfo)
        local isshowarrowsGood = false

        --print(UISignetPanel.NowInlaySignetValueType,UISignetPanel.stoneInlaySignetType, UISignetPanel.NowInlaySignetValue, UISignetPanel.stoneInlaySignet)
        if UISignetPanel.NowInlaySignetValueType == UISignetPanel.stoneInlaySignetType and UISignetPanel.stoneInlaySignetType ~= 0 and UISignetPanel.stoneInlaySignetType ~= nil then
            if UISignetPanel.NowInlaySignetValue ~= 0 and UISignetPanel.NowInlaySignetValue ~= nil and UISignetPanel.stoneInlaySignet ~= 0 and UISignetPanel.stoneInlaySignet ~= nil and UISignetPanel.NowInlaySignetValue < UISignetPanel.stoneInlaySignet then
                isshowarrowsGood = true
            end
        end
        UISignetPanel.goodArrow.gameObject:SetActive(isshowarrowsGood)
        -- UISignetPanel.ClashTips.gameObject:SetActive(not UISignetPanel.SelectSignet.data.IsCanInlay)
        UISignetPanel.stoneInfo.gameObject:SetActive(true)
    end
end

function UISignetPanel.GetAdditionName(item)
    --[[    if item == nil then
            return ""
        end
        local UseParam = item.useParam
        local additionName = ""
        if UseParam ~= nil and UseParam.list ~= nil and UseParam.list.Count == 2 then
            local color = CS.Utility_Lua.GetItemColorByQuality(item.quality)
            return tostring(color)
            --.. "Lv" .. tostring(UseParam.list[1])
        else
            return ""
        end]]
    return ""
end

---默认选择
function UISignetPanel.DefaultSelect()
    if UISignetPanel.BagSignetList.Count == 0 then
        UISignetPanel.SelectSignet = nil
        UISignetPanel.stoneInfo.gameObject:SetActive(false)
    else
        local index = 0
        local SelectBagItemInfo = UISignetPanel.BagSignetList[0]
        if UISignetPanel.chooseSignetmBagItemInfo ~= nil then
            for i = 0, UISignetPanel.BagSignetList.Count - 1 do
                if UISignetPanel.BagSignetList[i] ~= nil and UISignetPanel.BagSignetList[i].BagItemInfo == UISignetPanel.chooseSignetmBagItemInfo then
                    SelectBagItemInfo = UISignetPanel.BagSignetList[i]
                    index = i + 1
                end
            end
        end
        if UISignetPanel.activityBtns ~= nil then
            local maxPerLine = UISignetPanel.activityBtns.MaxPerLine
            local cellHeight = UISignetPanel.activityBtns.CellHeight
            if index / maxPerLine > 2 then
                local relativeIndex = index - 2 * maxPerLine
                local Position = UISignetPanel.SpringPanellocalPosition
                Position.y = UISignetPanel.SpringPanellocalPositionY + math.ceil((relativeIndex / maxPerLine)) * cellHeight
                UISignetPanel.stoneListSpringPanel.target = Position
                UISignetPanel.stoneListSpringPanel.enabled = true;
            else
                local Position = UISignetPanel.SpringPanellocalPosition
                Position.y = UISignetPanel.SpringPanellocalPositionY
                UISignetPanel.stoneListSpringPanel.target = Position
                UISignetPanel.stoneListSpringPanel.enabled = true;
            end
        end
        UISignetPanel.SelectBagSignet(SelectBagItemInfo)
        UISignetPanel.chooseSignetmBagItemInfo = nil
    end
end

---请求镶嵌
function UISignetPanel.ReqInlay()
    if UISignetPanel.SelectSignet ~= nil and UISignetPanel.SelectSignet.TABEL_Item ~= nil then
        if UISignetPanel.RolePanel_GridTemplateSignet ~= nil then
            if not UISignetPanel.SelectSignet.data.IsCanInlay then
                UISignetPanel.ShowTips(UISignetPanel.btn_use.transform, 26)
            else
                networkRequest.ReqPutOnImprint(UISignetPanel.RolePanel_GridTemplateSignet.equipIndex, UISignetPanel.SelectSignet.data.BagItemInfo.lid)
            end
        else
            CS.Utility.ShowTips('当前未选择镶嵌位置', 1.5, CS.ColorType.White)
        end
    else
        UISignetPanel.ShowTips(UISignetPanel.btn_use.transform, 25)
    end
end

---请求卸下
function UISignetPanel.ReqDisboard()
    if UISignetPanel.RolePanel_GridTemplateSignet ~= nil then
        networkRequest.ReqTakeOffImprint(UISignetPanel.RolePanel_GridTemplateSignet.equipIndex)
    end
end

---点击帮助按钮
function UISignetPanel.OnClickHelpBtn()
    local info
    local isFind = nil
    isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(33)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end
--endregion
--region公用方法
--提示信息
function UISignetPanel.ShowTips(trans, id, des)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    if des ~= nil then
        TipsInfo[LuaEnumTipConfigType.Describe] = des
    end
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UISignetPanel"
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end

function UISignetPanel.GetNowIndexImprintInfo()
    if UISignetPanel.RolePanel_GridTemplateSignet == nil then
        return nil
    end
    if UISignetPanel.RolePanel_GridTemplateSignet.bagItemInfo == nil then
        return nil
    end
    if UISignetPanel.ImprintInfoDic == nil then
        return nil
    end
    local isfind, ImprintInfo = UISignetPanel.ImprintInfoDic:TryGetValue(UISignetPanel.RolePanel_GridTemplateSignet.equipIndex)
    return ImprintInfo
end

function UISignetPanel.ResEffectShow()
    UISignetPanel.Successfuleffect.gameObject:SetActive(false)
    UISignetPanel.Successfuleffect.gameObject:SetActive(true)
end
--endregion
--region 服务器消息
---镶嵌成功返回消息
function UISignetPanel.ResPutOnImprintMessage()
    local item = UISignetPanel.RolePanel_GridTemplateSignet
    UISignetPanel.BagSignetList = CS.CSScene.MainPlayerInfo.SignetV2:GetBagSignetList(item.bagItemInfo.ItemTABLE, item.equipIndex)
    UISignetPanel.ImprintInfoDic = CS.CSScene.MainPlayerInfo.SignetV2.ImprintInfoDic
    UISignetPanel.NowIndexImprintInfo = UISignetPanel.GetNowIndexImprintInfo()

    UISignetPanel.SignetListRefresh()
    UISignetPanel.RefreshBtnShowInfo(true)
    UISignetPanel.EquipInlaySignetRefresh()
    UISignetPanel.TopInfoRefresh()
    UISignetPanel.DefaultSelect()


end

--endregion
function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.Role_EquipGridClicked, UISignetPanel.RefreshUI)

    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPutOnImprintMessage, UISignetPanel.ResPutOnImprintMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResTakeOffImprintMessage, UISignetPanel.ResPutOnImprintMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPutOnImprintMessage, UISignetPanel.ResEffectShow)
    -- if UISignetPanel.ItemEffect ~= nil then
    --     CS.UnityEngine.Object.Destroy(UISignetPanel.ItemEffect)
    -- end
end

return UISignetPanel