---镶嵌面板
local UIMedalInlayPanel = {}

--region 局部变量
---顺序 1、2、3
UIMedalInlayPanel.curState = 1
---当前选中格子index
UIMedalInlayPanel.curSelectedGridIndex = 0
---原始单元模板
UIMedalInlayPanel.originUnit = nil
---消耗单元模板
UIMedalInlayPanel.aimUnit = nil
---融合成功模板
UIMedalInlayPanel.successUnit = nil
---默认装备位
UIMedalInlayPanel.equipIndex = Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL)

UIMedalInlayPanel.mainUnitEquipType = LuaEnumEquiptype.Medal
UIMedalInlayPanel.aimUnitEquipType = LuaEnumEquiptype.DoubleMedal

---消耗位物品id
UIMedalInlayPanel.aimUnitId = 9006001
--endregion
---勋章秘籍跳转id
UIMedalInlayPanel.secretJumpId = 10407009

--region 初始化

function UIMedalInlayPanel:Init()
    self:InitComponents()
    UIMedalInlayPanel.BindUIEvents()
    UIMedalInlayPanel.BindNetMessage()
    UIMedalInlayPanel.InitData()
    UIMedalInlayPanel.InitUI()
end

--- 初始化组件
function UIMedalInlayPanel:InitComponents()
    ---@type UnityEngine.GameObject 原始
    UIMedalInlayPanel.OriginEquip = self:GetCurComp("WidgetRoot/view/OriginEquip", "GameObject")
    ---@type UnityEngine.GameObject 消耗
    UIMedalInlayPanel.AimEquip = self:GetCurComp("WidgetRoot/view/AimEquip", "GameObject")
    ---@type UnityEngine.GameObject 成功
    UIMedalInlayPanel.SuccessEquip = self:GetCurComp("WidgetRoot/view/SuccessEquip", "GameObject")
    ---@type UnityEngine.GameObject 封印（镶嵌）按钮
    UIMedalInlayPanel.btn_inlay = self:GetCurComp("WidgetRoot/view/Finish/btn_inlay", "GameObject")
    ---@type UnityEngine.GameObject 帮助按钮
    UIMedalInlayPanel.btn_help = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIMedalInlayPanel.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---@type Top_UIToggle 角色
    UIMedalInlayPanel.btn_role = self:GetCurComp("WidgetRoot/events/btn_role", "GameObject")
    ---@type Top_UISprite 角色mark
    UIMedalInlayPanel.roleCheckmark = self:GetCurComp("WidgetRoot/events/btn_role/Checkmark", "Top_UISprite")
    ---@type Top_UIToggle 背包
    UIMedalInlayPanel.btn_bag = self:GetCurComp("WidgetRoot/events/btn_bag", "GameObject")
    ---@type Top_UISprite 背包mark
    UIMedalInlayPanel.bagCheckmark = self:GetCurComp("WidgetRoot/events/btn_bag/Checkmark", "Top_UISprite")
    ---@type Top_UIToggle 购买
    UIMedalInlayPanel.btn_buy = self:GetCurComp("WidgetRoot/events/btn_buy", "GameObject")
    ---@type Top_UISprite 购买mark
    UIMedalInlayPanel.buyCheckmark = self:GetCurComp("WidgetRoot/events/btn_buy/Checkmark", "Top_UISprite")
    ---@type Top_UISprite
    UIMedalInlayPanel.Mainicon = self:GetCurComp("WidgetRoot/view/Mainicon", "Top_UISprite")
    ---@type Top_UIGridContainer 主勋章属性显示
    UIMedalInlayPanel.arributelist = self:GetCurComp("WidgetRoot/view/Scroll View/arributelist", "Top_UIGridContainer")
    ---@type Top_UILabel 双倍勋章属性显示
    UIMedalInlayPanel.des = self:GetCurComp("WidgetRoot/view/des", "Top_UILabel")
    ---@type Top_UISprite 条件未满足提示
    UIMedalInlayPanel.unfinshText = self:GetCurComp("WidgetRoot/view/Unfinish/text", "Top_UISprite")
    ---@type UnityEngine.GameObject 获取按钮（条件未满足）
    UIMedalInlayPanel.btn_getitem = self:GetCurComp("WidgetRoot/view/Unfinish/btn_getitem", "GameObject")
    ---@type UnityEngine.GameObject
    UIMedalInlayPanel.btn_buyexpitem = self:GetCurComp("WidgetRoot/view/Unfinish/btn_buyexpitem", "GameObject")
    ---@type Top_UILabel 获取按钮文本（条件未满足）
    UIMedalInlayPanel.getItemBtnLabel = self:GetCurComp("WidgetRoot/view/Unfinish/btn_getitem/Label", "Top_UILabel")
    ---@type Top_UISprite 获取按钮Icon（条件未满足）
    UIMedalInlayPanel.getItemBtnIcon = self:GetCurComp("WidgetRoot/view/Unfinish/btn_getitem/icon", "Top_UISprite")
    ---@type UnityEngine.GameObject 满足条件
    UIMedalInlayPanel.Finish = self:GetCurComp("WidgetRoot/view/Finish", "GameObject")
    ---@type UnityEngine.GameObject 未满足条件
    UIMedalInlayPanel.Unfinish = self:GetCurComp("WidgetRoot/view/Unfinish", "GameObject")
end

function UIMedalInlayPanel.BindUIEvents()
    --点击封印事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_inlay).onClick = UIMedalInlayPanel.OnClickbtn_inlay
    --点击帮助事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_help).onClick = UIMedalInlayPanel.OnClickbtn_help
    --点击关闭事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_close).onClick = UIMedalInlayPanel.OnClickbtn_close
    --点击角色事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_role).onClick = UIMedalInlayPanel.OnClickbtn_role
    --点击背包事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_bag).onClick = UIMedalInlayPanel.OnClickbtn_bag
    --点击买卖事件
    -- CS.UIEventListener.Get(UIMedalInlayPanel.btn_buy).onClick = UIMedalInlayPanel.OnClickbtn_buy
    --点击获取勋章事件
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_getitem).onClick = UIMedalInlayPanel.OnClickGetItemBtn
    CS.UIEventListener.Get(UIMedalInlayPanel.btn_buyexpitem).onClick = UIMedalInlayPanel.OnClickGetItemBtn
end

function UIMedalInlayPanel.BindNetMessage()
    UIMedalInlayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, UIMedalInlayPanel.OnRoleItemClicked)
    UIMedalInlayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_GridSingleClicked, UIMedalInlayPanel.OnGridItemClicked)
    UIMedalInlayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIMedalInlayPanel.OnMainBagClicked)
    UIMedalInlayPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MedalInlay_Select, UIMedalInlayPanel.OnMedalInlaySelectClicked)
    UIMedalInlayPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, UIMedalInlayPanel.OnResCommonMessage)
    UIMedalInlayPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIMedalInlayPanel.ChangeEquip)
end

function UIMedalInlayPanel.InitData()
    UIMedalInlayPanel.des.text = ''
    ---镶嵌位
    UIMedalInlayPanel.originUnit = templatemanager.GetNewTemplate(UIMedalInlayPanel.OriginEquip, luaComponentTemplates.UIMosaicUnitTemplate)
    local temp = {}
    temp.index = 1
    temp.subType = UIMedalInlayPanel.mainUnitEquipType
    temp.replaceCallBack = function(subType, index)
        UIMedalInlayPanel.curSelectedGridIndex = index
        UIMedalInlayPanel.ChangeChoseTemplateState()
        UIMedalInlayPanel.AddCallBack(UIMedalInlayPanel.mainUnitEquipType)
        --UIMedalInlayPanel.RefrshSuccessInfo(nil)
    end
    temp.addCallBack = function(go)
        UIMedalInlayPanel.curSelectedGridIndex = temp.index
        UIMedalInlayPanel.curState = UIMedalInlayPanel.CheckLeftState(UIMedalInlayPanel.mainUnitEquipType)
        if UIMedalInlayPanel.curState ~= 3 then
            UIMedalInlayPanel.ChangeToggleState()
            UIMedalInlayPanel.SetAddBagItemInfo(UIMedalInlayPanel.mainUnitEquipType, UIMedalInlayPanel.curState)
        else
            Utility.ShowPopoTips(go.transform, nil, 182)
        end
    end
    temp.iconCallBack = function(bagItemInfo, index)
        UIMedalInlayPanel.curSelectedGridIndex = index
        UIMedalInlayPanel.ChangeChoseTemplateState()
        if bagItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = false })
        end
        if UIMedalInlayPanel.originUnit.isEquip then
            if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfRolePanel) then
                luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfRolePanel, bagItemInfo.index)
            end
        else
            if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfBag) then
                luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfBag, bagItemInfo)
            end
        end
    end
    UIMedalInlayPanel.originUnit:SetTemplate(temp)

    ---成功位
    temp = {}
    temp.iconCallBack = function(bagItemInfo, index)
        UIMedalInlayPanel.curSelectedGridIndex = index
        UIMedalInlayPanel.ChangeChoseTemplateState()
        if bagItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo , showRight = false})
        end
    end
    UIMedalInlayPanel.successUnit = templatemanager.GetNewTemplate(UIMedalInlayPanel.SuccessEquip, luaComponentTemplates.UIMosaicUnitTemplate)
    UIMedalInlayPanel.successUnit:SetTemplate(temp)
    UIMedalInlayPanel.SuccessEquip:SetActive(false)

    ---消耗位
    UIMedalInlayPanel.aimUnit = templatemanager.GetNewTemplate(UIMedalInlayPanel.AimEquip, luaComponentTemplates.UIConsumableUnitTemplate)
    temp = {}
    temp.index = 2
    temp.commodityID = UIMedalInlayPanel.aimUnitId
    temp.normalItemID = 2230101
    temp.subType = UIMedalInlayPanel.aimUnitEquipType
    temp.iconCallBack = function(bagItemInfo, index)
        UIMedalInlayPanel.curSelectedGridIndex = index
        UIMedalInlayPanel.ChangeChoseTemplateState()
        if bagItemInfo ~= nil then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo , showRight = false})
            if UIMedalInlayPanel.aimUnit.isEquip then
                if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfRolePanel) then
                    luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfRolePanel, bagItemInfo.index)
                end
            else
                if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfBag) then
                    luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfBag, bagItemInfo)
                end
            end
        end
    end
    temp.addCallBack = function(go)
        UIMedalInlayPanel.curSelectedGridIndex = temp.index
        UIMedalInlayPanel.curState = UIMedalInlayPanel.CheckLeftState(UIMedalInlayPanel.aimUnitEquipType)
        if UIMedalInlayPanel.curState ~= 3 then
            UIMedalInlayPanel.ChangeToggleState()
            UIMedalInlayPanel.SetAddBagItemInfo(UIMedalInlayPanel.aimUnitEquipType, UIMedalInlayPanel.curState)
        else
            Utility.ShowPopoTips(go.transform, nil, 186)
        end
    end
    temp.replaceCallBack = function(commodityID, index)
        --商品id
        UIMedalInlayPanel.curSelectedGridIndex = index
        UIMedalInlayPanel.ChangeChoseTemplateState()
        UIMedalInlayPanel.AddCallBack(UIMedalInlayPanel.aimUnitEquipType)
        -- UIMedalInlayPanel.RefrshSuccessInfo(nil)
        --UIMedalInlayPanel.ShowBuyPanel(commodityID)
        --if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfBag) then
        --    luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfBag, nil)
        --end
    end
    UIMedalInlayPanel.aimUnit:SetTemplate(temp)

    local isFind, info = CS.Cfg_SecretBookTableManager.Instance.dic:TryGetValue(UIMedalInlayPanel.secretJumpId)
    if isFind then
        UIMedalInlayPanel.SecreBookKeyward = info.keyWord
    end

end

--endregion

--region 函数监听

--点击封印函数
---@param go UnityEngine.GameObject
function UIMedalInlayPanel.OnClickbtn_inlay(go)
    UIMedalInlayPanel.HideAllChose()
    if UIMedalInlayPanel.originUnit.isEquip and UIMedalInlayPanel.originUnit.equipIndex == nil then
        UIMedalInlayPanel.ShowBubbleTips(go.transform, 136)
        return
    end
    if not UIMedalInlayPanel.originUnit.isEquip and UIMedalInlayPanel.originUnit.lid == nil then
        UIMedalInlayPanel.ShowBubbleTips(go.transform, 136)
        return
    end
    if UIMedalInlayPanel.aimUnit.lid == nil then
        Utility.ShowPopoTips(go.transform, nil, 136)
        return
    end
    local origionOwnId = UIMedalInlayPanel.originUnit.isEquip and UIMedalInlayPanel.originUnit.equipIndex or UIMedalInlayPanel.originUnit.lid
    local aimOwnId = UIMedalInlayPanel.aimUnit.isEquip and UIMedalInlayPanel.aimUnit.equipIndex or UIMedalInlayPanel.aimUnit.lid
    networkRequest.ReqInlayMedal(origionOwnId, aimOwnId, 0)
end

--点击帮助函数
---@param go UnityEngine.GameObject
function UIMedalInlayPanel.OnClickbtn_help(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(93)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIMedalInlayPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIMedalInlayPanel')
end

function UIMedalInlayPanel.OnClickbtn_role(go)
    if UIMedalInlayPanel.curState == 1 then
        return
    end
    UIMedalInlayPanel.curState = 1
    UIMedalInlayPanel.ChangeToggleState()
end

function UIMedalInlayPanel.OnClickbtn_bag(go)
    if UIMedalInlayPanel.curState == 2 then
        return
    end
    UIMedalInlayPanel.curState = 2
    UIMedalInlayPanel.ChangeToggleState()
end

function UIMedalInlayPanel.OnClickbtn_buy(go)
    if UIMedalInlayPanel.curState == 3 then
        return
    end
    UIMedalInlayPanel.curState = 3
    UIMedalInlayPanel.ChangeToggleState()
end

---点击获取物品事件（勋章或双倍勋章）
function UIMedalInlayPanel.OnClickGetItemBtn(go)

    if UIMedalInlayPanel.originUnit.lid == nil or UIMedalInlayPanel.originUnit.lid == 0 then
        uimanager:CreatePanel("UISecretBookPanel", nil, UIMedalInlayPanel.SecreBookKeyward)
        return
    end

    if UIMedalInlayPanel.aimUnit.lid == nil or UIMedalInlayPanel.aimUnit.lid == 0 then
        UIMedalInlayPanel.ShowBuyPanel(UIMedalInlayPanel.aimUnitId)
        return
    end
end

--endregion

--region 消息处理

---点击角色格子
function UIMedalInlayPanel.OnRoleItemClicked(id, bagItemInfo)
    if bagItemInfo then
        if UIMedalInlayPanel.originUnit.subType == bagItemInfo.ItemTABLE.subType then
            UIMedalInlayPanel.RefreshOriginInfo(bagItemInfo, true)
        else
            UIMedalInlayPanel.RefreshAimInfo(bagItemInfo, true)
        end
    end
end

---点击背包格子
function UIMedalInlayPanel.OnGridItemClicked(id, bagItemInfo)
    if bagItemInfo then
        if UIMedalInlayPanel.originUnit.subType == bagItemInfo.ItemTABLE.subType then
            UIMedalInlayPanel.curSelectedGridIndex = 1
            UIMedalInlayPanel.RefreshOriginInfo(bagItemInfo)
        else
            UIMedalInlayPanel.curSelectedGridIndex = 2
            UIMedalInlayPanel.RefreshAimInfo(bagItemInfo)
        end
        UIMedalInlayPanel.ChangeChoseTemplateState()
    end
end

---镶嵌完毕
function UIMedalInlayPanel.OnResCommonMessage(id, tblData)
    if tblData.type ~= 7 then
        return
    end
    UIMedalInlayPanel.RefreshSuccessUI()
end

---主界面背包点击
function UIMedalInlayPanel.OnMainBagClicked()
    UIMedalInlayPanel.OnClickbtn_bag()
end

---背包发生变化（用于购买）
function UIMedalInlayPanel.ChangeEquip()
    if UIMedalInlayPanel.aimUnit.lid == nil or UIMedalInlayPanel.aimUnit.lid == 0 then
        --local type = UIMedalInlayPanel.RefreshLeftState(LuaEnumEquiptype.DoubleMedal)
        UIMedalInlayPanel.SetAddBagItemInfo(UIMedalInlayPanel.aimUnitEquipType, 2)
        --切换至背包
        if UIMedalInlayPanel.curSelectedGridIndex ~= 2 then
            UIMedalInlayPanel.curState = UIMedalInlayPanel.CheckLeftState(UIMedalInlayPanel.aimUnitEquipType)
            UIMedalInlayPanel.ChangeToggleState()
        end
    end
end

---刷新背包推荐
function UIMedalInlayPanel.OnMedalInlaySelectClicked(MsgID, bagItem)
    if bagItem then
        if UIMedalInlayPanel.originUnit.subType == bagItem.ItemTABLE.subType then
            UIMedalInlayPanel.curSelectedGridIndex = 1
        elseif UIMedalInlayPanel.aimUnit.subType == bagItem.ItemTABLE.subType then
            UIMedalInlayPanel.curSelectedGridIndex = 2
        end
        UIMedalInlayPanel.ChangeChoseTemplateState()
    end
end

--endregion

--region UI

function UIMedalInlayPanel.InitUI()
    -- UIMedalInlayPanel.arributelist.MaxCount = 0
    UIMedalInlayPanel.curState = UIMedalInlayPanel.CheckLeftState(UIMedalInlayPanel.mainUnitEquipType)
    UIMedalInlayPanel.curSelectedGridIndex = 1
    UIMedalInlayPanel.ChangeToggleState()
    UIMedalInlayPanel.SetAddBagItemInfo(UIMedalInlayPanel.mainUnitEquipType, UIMedalInlayPanel.curState)
    local type = UIMedalInlayPanel.CheckLeftState(UIMedalInlayPanel.aimUnitEquipType)
    UIMedalInlayPanel.SetAddBagItemInfo(UIMedalInlayPanel.aimUnitEquipType, type)
    UIMedalInlayPanel.RefreshUnfinishTip()
end

---切换功能组(打开左侧面板)
function UIMedalInlayPanel.ChangeToggleState()
    UIMedalInlayPanel.roleCheckmark.alpha = (UIMedalInlayPanel.curState == 1 or UIMedalInlayPanel.curState == 3) and 1 or 0.01
    UIMedalInlayPanel.bagCheckmark.alpha = UIMedalInlayPanel.curState == 2 and 1 or 0.01
    UIMedalInlayPanel.buyCheckmark.alpha = UIMedalInlayPanel.curState == 3 and 1 or 0.01
    if UIMedalInlayPanel.curState == 1 or UIMedalInlayPanel.curState == 3 then
        local customData = {}
        ---@type UIRolePanel_EquipTemplatesMosaic
        customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplatesMosaic;
        customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateMosaic;
        customData.isShowArrowBtn = false
        customData.isShowCloseBtn = false
        uimanager:ClosePanel('UIBagPanel')
        -- uimanager:ClosePanel('UISaleOrePanel')
        uimanager:CreatePanel("UIRolePanel", nil, customData);
    elseif UIMedalInlayPanel.curState == 2 then
        local info = nil
        if UIMedalInlayPanel.curSelectedGridIndex == 1 then
            if UIMedalInlayPanel.originUnit.bagInfo == nil then
                info = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipInfoByType(UIMedalInlayPanel.mainUnitEquipType)
            else
                info = UIMedalInlayPanel.originUnit.bagInfo
            end
        else
            if UIMedalInlayPanel.aimUnit.bagInfo == nil then
                info = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipInfoByType(UIMedalInlayPanel.aimUnitEquipType)
            else
                info = UIMedalInlayPanel.aimUnit.bagInfo
            end
        end
        uimanager:ClosePanel('UIRolePanel')
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Mosaic, focusedBagItemInfo = info, medalInlayBagInfo = info })
        -- uimanager:ClosePanel('UISaleOrePanel')
        --elseif UIMedalInlayPanel.curState == 3 then
        --    uimanager:ClosePanel('UIRolePanel')
        --    uimanager:ClosePanel('UIBagPanel')
        --    uimanager:CreatePanel('UISaleOrePanel', nil, { isHideCloseBtn = true, type = '6', isOpenBag = false, showID = 6, isHideSale = true, isClickShowBag = false })
    end
end

---切换选中状态
function UIMedalInlayPanel.ChangeChoseTemplateState()
    UIMedalInlayPanel.originUnit:RefreshChoseState(UIMedalInlayPanel.curSelectedGridIndex == 1)
    UIMedalInlayPanel.aimUnit:RefreshChoseState(UIMedalInlayPanel.curSelectedGridIndex == 2)
end

---隐藏所有选中状态
function UIMedalInlayPanel.HideAllChose()
    UIMedalInlayPanel.originUnit:RefreshChoseState(false)
    UIMedalInlayPanel.aimUnit:RefreshChoseState(false)
end

---刷新融合成功后镶嵌位显示
function UIMedalInlayPanel.RefreshSuccessUI()
    --region 显示镶嵌成功位
    if UIMedalInlayPanel.originUnit.isEquip then
        local bagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(UIMedalInlayPanel.equipIndex)
        if bagItemInfo ~= nil then
            UIMedalInlayPanel.RefrshSuccessInfo(bagItemInfo)
        end
    else
        local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(UIMedalInlayPanel.originUnit.lid)
        UIMedalInlayPanel.RefrshSuccessInfo(bagItemInfo)
    end

    --endregion

    --region清空消耗位
    UIMedalInlayPanel.des.text = ''
    UIMedalInlayPanel.aimUnit:ClearInfo()

    --endregion


    --region清空镶嵌位
    UIMedalInlayPanel.originUnit:ClearInfo()
   -- UIMedalInlayPanel.arributelist.MaxCount = 0
    --endregion
end

---刷新主镶嵌位
function UIMedalInlayPanel.RefreshOriginInfo(bagItemInfo, isEquip)
    if bagItemInfo.lid == UIMedalInlayPanel.originUnit.lid then
        return
    end
    UIMedalInlayPanel.originUnit:SetInfo(bagItemInfo, isEquip)
    -- UIMedalInlayPanel.SetAttributeGrid(bagItemInfo)
    UIMedalInlayPanel.RefreshUnfinishTip()
    UIMedalInlayPanel.CreatShowBagItem()
end

---刷新消耗位
function UIMedalInlayPanel.RefreshAimInfo(bagItemInfo, isEquip)
    if bagItemInfo.lid == UIMedalInlayPanel.aimUnit.lid then
        return
    end
    UIMedalInlayPanel.curSelectedGridIndex = 2
    UIMedalInlayPanel.aimUnit:SetInfo(bagItemInfo, isEquip)

    UIMedalInlayPanel.RefreshUnfinishTip()
    UIMedalInlayPanel.CreatShowBagItem()
end

---刷新成功位(预览位)
function UIMedalInlayPanel.RefrshSuccessInfo(info)
    if info == nil and (UIMedalInlayPanel.successUnit.lid == 0 or UIMedalInlayPanel.successUnit.lid == nil) then
        UIMedalInlayPanel.successUnit:ClearInfo()
        UIMedalInlayPanel.SuccessEquip:SetActive(false)
        return
    end

    UIMedalInlayPanel.successUnit:SetInfo(info, true, true)
    UIMedalInlayPanel.SuccessEquip:SetActive(true)
end

---刷新镶嵌位的属性
function UIMedalInlayPanel.SetAttributeGrid(bagItemInfo)
    local attributes = UIMedalInlayPanel.GetAttribute(bagItemInfo)
    if attributes == nil then
        --UIMedalInlayPanel.arributelist.MaxCount = 0
        return
    end
    UIMedalInlayPanel.arributelist.MaxCount = #attributes
    local index = 0
    for i, v in pairs(attributes) do
        local go = UIMedalInlayPanel.arributelist.controlList[index]
        local nameLabel = CS.Utility_Lua.GetComponent(go.transform:Find('curarribute/title'), "Top_UILabel")
        local valueLabel = CS.Utility_Lua.GetComponent(go.transform:Find('curarribute/gongji'), "Top_UILabel")
        if nameLabel then
            nameLabel.text = v.name
        end
        if valueLabel then
            valueLabel.text = v.value
        end
        index = index + 1
    end
end

---刷新消耗位的描述
function UIMedalInlayPanel.SetDes(ItemInfo)
    UIMedalInlayPanel.des.text = string.gsub(ItemInfo.tips2, '\\n', '\n')
end

---刷新条件未满足时提示
function UIMedalInlayPanel.RefreshUnfinishTip()
    if UIMedalInlayPanel.originUnit.lid == nil or UIMedalInlayPanel.originUnit.lid == 0 then
        UIMedalInlayPanel.unfinshText.spriteName = 'MedalInlay_text1'
        UIMedalInlayPanel.btn_getitem:SetActive(true)
        UIMedalInlayPanel.btn_buyexpitem:SetActive(false)
        UIMedalInlayPanel.Finish:SetActive(false)
        UIMedalInlayPanel.Unfinish:SetActive(true)
        UIMedalInlayPanel.successUnit.lid = 0
        UIMedalInlayPanel.RefrshSuccessInfo(nil)
        return
    end
    if UIMedalInlayPanel.aimUnit.lid == nil or UIMedalInlayPanel.aimUnit.lid == 0 then
        UIMedalInlayPanel.btn_getitem:SetActive(false)
        UIMedalInlayPanel.btn_buyexpitem:SetActive(true)
        UIMedalInlayPanel.unfinshText.spriteName = 'MedalInlay_text2'

        UIMedalInlayPanel.Finish:SetActive(false)
        UIMedalInlayPanel.Unfinish:SetActive(true)
        UIMedalInlayPanel.successUnit.lid = 0
        UIMedalInlayPanel.RefrshSuccessInfo(nil)
        return
    end
    UIMedalInlayPanel.Finish:SetActive(true)
    UIMedalInlayPanel.Unfinish:SetActive(false)
end

--endregion

--region otherFunction
function UIMedalInlayPanel.AddCallBack(subType)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil or CS.CSScene.MainPlayerInfo.EquipInfo == nil then
        return
    end
    UIMedalInlayPanel.curState = UIMedalInlayPanel.CheckLeftState(subType)
    UIMedalInlayPanel.ChangeToggleState()
end

---寻找合适类型的物品并刷新模板
function UIMedalInlayPanel.SetAddBagItemInfo(subType, type)
    if type == 1 then
        local isFind, data = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(UIMedalInlayPanel.equipIndex)
        if isFind and subType == data.ItemTABLE.subType then
            if UIMedalInlayPanel.originUnit.subType == data.ItemTABLE.subType and UIMedalInlayPanel.originUnit.lid ~= data.lid then
                UIMedalInlayPanel.RefreshOriginInfo(data, true)
            elseif UIMedalInlayPanel.aimUnit.subType == data.ItemTABLE.subType and UIMedalInlayPanel.aimUnit.lid ~= data.lid then
                UIMedalInlayPanel.RefreshAimInfo(data, true)
            end
        end
    elseif type == 2 then
        --获取可装备的装备
        local data = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipByBag(subType)
        if data == nil or subType ~= data.ItemTABLE.subType then
            return
        end
        if UIMedalInlayPanel.originUnit.subType == data.ItemTABLE.subType and UIMedalInlayPanel.originUnit.lid ~= data.lid then
            UIMedalInlayPanel.RefreshOriginInfo(data, false)
        elseif UIMedalInlayPanel.aimUnit.subType == data.ItemTABLE.subType and UIMedalInlayPanel.aimUnit.lid ~= data.lid then
            UIMedalInlayPanel.RefreshAimInfo(data, false)
        end
        if luaEventManager.HasCallback(LuaCEvent.MedalInlay_SelectOfBag) then
            luaEventManager.DoCallback(LuaCEvent.MedalInlay_SelectOfBag, data)
        end
    end
end

---判断当前需要打开左侧面板类型状态
function UIMedalInlayPanel.CheckLeftState(subType)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.EquipInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return
    end
    --人物面板信息是否装备勋章 打开人物面板
    local itemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MEDAL))
    if itemInfo ~= nil then
        if itemInfo.ItemTABLE.subType == subType and itemInfo.lid ~= UIMedalInlayPanel.originUnit.lid then
            return 1
        end
    end
    --背包是否有可装备勋章 打开背包 (加是否可装备)
    local info = CS.CSScene.MainPlayerInfo.BagInfo:GetBestEquipByBag(subType)
    if info ~= nil then
        return 2
    end
    return 3
end

---获取勋章的基础属性
function UIMedalInlayPanel.GetAttribute(bagItemInfo)
    if bagItemInfo == nil then
        return nil
    end
    local itemInfo = bagItemInfo.ItemTABLE
    if itemInfo == nil then
        return nil
    end

    local isWarrior = CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior
    local isMaster = CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master
    local isTaoist = CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist

    local attributeTabel = {}
    --region镶嵌
    local isxq = (bagItemInfo.inlayInfoList ~= nil and bagItemInfo.inlayInfoList.Count ~= 0) and true or false
    local temp = {}
    temp.name = "镶嵌"
    temp.value = isxq and '已镶嵌' or '未镶嵌'
    table.insert(attributeTabel, temp)
    --endregion
    --region 物理防御属性
    if (itemInfo.phyDefenceMin > 0) or (itemInfo.phyDefenceMax > 0) then
        local minPhyDefence = itemInfo.phyDefenceMin
        local maxPhyDefence = itemInfo.phyDefenceMax
        local temp = {}
        temp.name = "防御"
        temp.value = tostring(minPhyDefence) .. ' - ' .. tostring(maxPhyDefence)
        table.insert(attributeTabel, temp)
    end
    --endregion

    --region 法术防御属性
    if (itemInfo.magicDefenceMin > 0) or (itemInfo.magicDefenceMax > 0) then
        local minMagicDefence = itemInfo.magicDefenceMin
        local maxMagicDefence = itemInfo.magicDefenceMax
        local temp = {}
        temp.name = "魔防"
        temp.value = tostring(minMagicDefence) .. ' - ' .. tostring(maxMagicDefence)
        table.insert(attributeTabel, temp)
    end
    --endregion

    --region 物理攻击属性
    if isWarrior and ((itemInfo.phyAttackMin > 0) or (itemInfo.phyAttackMax > 0)) then
        local minPhyAttack = itemInfo.phyAttackMin
        local maxPhyAttack = itemInfo.phyAttackMax
        local temp = {}
        temp.name = "攻击"
        temp.value = tostring(minPhyAttack) .. ' - ' .. tostring(maxPhyAttack)
        table.insert(attributeTabel, temp)
    end
    --endregion

    --region 魔法攻击属性
    if isMaster and ((itemInfo.magicAttackMin > 0) or (itemInfo.magicAttackMax > 0)) then
        local minMagicAttack = itemInfo.magicAttackMin
        local maxMagicAttack = itemInfo.magicAttackMax
        local temp = {}
        temp.name = Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax)
        temp.value = tostring(minMagicAttack) .. ' - ' .. tostring(maxMagicAttack)
        table.insert(attributeTabel, temp)
    end
    --endregion

    --region 道术攻击属性

    if isTaoist and ((itemInfo.taoAttackMin > 0) or (itemInfo.taoAttackMax > 0)) then
        local minTaoAttack = itemInfo.taoAttackMin
        local maxTaoAttack = itemInfo.taoAttackMax
        local temp = {}
        temp.name = "道术"
        temp.value = tostring(minTaoAttack) .. ' - ' .. tostring(maxTaoAttack)
        table.insert(attributeTabel, temp)
    end
    --endregion
    return attributeTabel
end

---显示购买页面
function UIMedalInlayPanel.ShowBuyPanel(commodityID)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.StoreInfoV2 == nil then
        return
    end
    local isFind, info = CS.Cfg_StoreTableManager.Instance.dic:TryGetValue(commodityID)
    if isFind then
        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(info, function()
            local storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(commodityID)
            if storeInfo and storeInfo.itemTable then
                uimanager:CreatePanel("UIDisposeItemPanel", nil, storeInfo);
            end
        end)
    end
end

---创建预览物品
function UIMedalInlayPanel.CreatShowBagItem()
    if UIMedalInlayPanel.originUnit.bagInfo == nil or UIMedalInlayPanel.aimUnit.bagInfo == nil then
        UIMedalInlayPanel.RefrshSuccessInfo(nil)
        return
    end
    local info = CS.CSScene.MainPlayerInfo.BagInfo:CloneBagItemInfo(UIMedalInlayPanel.originUnit.bagInfo)
    local inlayInfo = CS.bagV2.inlayInfo()
    inlayInfo.itemId = UIMedalInlayPanel.aimUnit.bagInfo.ItemTABLE.id
    inlayInfo.currentLasting = UIMedalInlayPanel.aimUnit.bagInfo.currentLasting
    inlayInfo.id = UIMedalInlayPanel.aimUnit.lid
    if info.inlayInfoList.Count == 0 then
        info.inlayInfoList:Add(inlayInfo)
    else
        info.inlayInfoList[0] = inlayInfo
    end
    info.index = 0
    --展示
    UIMedalInlayPanel.RefrshSuccessInfo(info)
end

--endregion

--region ondestroy

function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.Role_EquipGridClicked, UIMedalInlayPanel.OnRoleItemClicked)
    --luaEventManager.RemoveCallback(LuaCEvent.Bag_GridSingleClicked, UIMedalInlayPanel.OnGridItemClicked)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCommonMessage, UIMedalInlayPanel.OnResCommonMessage)
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, UIMedalInlayPanel.OnMainBagClicked)
    --luaEventManager.RemoveCallback(LuaCEvent.MedalInlay_Select, UIMedalInlayPanel.OnMedalInlaySelectClicked)
    uimanager:ClosePanel('UIRolePanel')
    uimanager:ClosePanel('UIBagPanel')
    --uimanager:ClosePanel('UISaleOrePanel')
end

--endregion

return UIMedalInlayPanel