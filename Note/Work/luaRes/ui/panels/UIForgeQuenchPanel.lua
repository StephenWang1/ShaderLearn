---@class UIForgeQuenchPanel:UIBase 淬炼面板
local UIForgeQuenchPanel = {}

---@return LuaForgeQuenchDataManager
function UIForgeQuenchPanel.GetForgeQuenchMgr()
    if UIForgeQuenchPanel.mForgeQuenchMgr == nil then
        UIForgeQuenchPanel.mForgeQuenchMgr = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr()
    end
    return UIForgeQuenchPanel.mForgeQuenchMgr
end

function UIForgeQuenchPanel.GetForgeQuenchAllDataDic()
    if UIForgeQuenchPanel.mForgeQuenchAllDataDic == nil and UIForgeQuenchPanel.GetForgeQuenchMgr() ~= nil then
        UIForgeQuenchPanel.mForgeQuenchAllDataDic = UIForgeQuenchPanel.GetForgeQuenchMgr():GetAllForgeQuenchItemByIdDic()
    end
    return UIForgeQuenchPanel.mForgeQuenchAllDataDic
end

--region 初始化

function UIForgeQuenchPanel:Init()
    self:InitComponents()
    UIForgeQuenchPanel.InitParameters()
    UIForgeQuenchPanel.BindUIEvents()
    UIForgeQuenchPanel.BindNetMessage()
end

--- 初始化变量
function UIForgeQuenchPanel.InitParameters()
    ---@type bagV2.BagItemInfo
    UIForgeQuenchPanel.curBagItemInfo = nil
    UIForgeQuenchPanel.curForgeQuenchId = 0
    ---@type number 当前页签类型 1：列表 2：人物 3：背包
    UIForgeQuenchPanel.curPageType = 0
    ---@type LuaForgeQuenchItemData
    UIForgeQuenchPanel.forgeQuenchData = nil
    ---@type table<UnityEngine.GameObject,UIForgeQuenchPanel_MaterialTemplate>
    UIForgeQuenchPanel.MaterialGoAndTemplateDic = {}
    ---@type table<UnityEngine.GameObject,UIForgeQuenchPanel_OutputTemplate>
    UIForgeQuenchPanel.OutputGoAndTemplateDic = {}
    ---@type UIForgeQuenchPanel_MaterialTemplate
    UIForgeQuenchPanel.curMainMaterialTemplate = nil

    UIForgeQuenchPanel.posTbl = {
        [1] = { x = -1, y = -3, z = 0 },
        [2] = { x = -15, y = -7, z = 0 }
    }
end

--- 初始化组件
function UIForgeQuenchPanel:InitComponents()
    ---@type Top_UILabel 当前淬炼物品名称
    UIForgeQuenchPanel.curName = self:GetCurComp("WidgetRoot/view/currentName", "Top_UILabel")
    ---@type Top_UISprite 消耗icon
    UIForgeQuenchPanel.costIcon = self:GetCurComp("WidgetRoot/view/cost/img", "Top_UISprite")
    ---@type Top_UILabel 消耗数量
    UIForgeQuenchPanel.costNum = self:GetCurComp("WidgetRoot/view/cost", "Top_UILabel")
    ---@type Top_UIGridContainer 材料列表
    UIForgeQuenchPanel.materialGrid = self:GetCurComp("WidgetRoot/view/ScrollView/materials", "Top_UIGridContainer")
    ---@type UILabel 淬炼说明
    UIForgeQuenchPanel.temperDes = self:GetCurComp("WidgetRoot/view/Label", "UILabel")
    ---@type Top_UISprite 展示图
    UIForgeQuenchPanel.showSprite = self:GetCurComp("WidgetRoot/view/text", "Top_UISprite")
    ---@type Top_UIGridContainer 淬炼列表
    UIForgeQuenchPanel.outputGrid = self:GetCurComp("WidgetRoot/view/Scroll_single/Grid", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 关闭按钮
    UIForgeQuenchPanel.closeBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---@type Top_UIToggle 人物按钮
    UIForgeQuenchPanel.roleToggle = self:GetCurComp("WidgetRoot/events/btn_role", "Top_UIToggle")
    ---@type Top_UIToggle 背包按钮
    UIForgeQuenchPanel.bagToggle = self:GetCurComp("WidgetRoot/events/btn_bag", "Top_UIToggle")
    ---@type Top_UIToggle 淬炼列表按钮
    UIForgeQuenchPanel.quenchListToggle = self:GetCurComp("WidgetRoot/events/btn_QuenchingList", "Top_UIToggle")
    ---@type UnityEngine.GameObject 淬炼按钮
    UIForgeQuenchPanel.forgeQuenchBtn = self:GetCurComp("WidgetRoot/events/btn_use", "GameObject")
    ---@type CSUIEffectLoad 特效
    UIForgeQuenchPanel.successEffect = self:GetCurComp("WidgetRoot/view/successEffectPanel/successEffect", "CSUIEffectLoad")

end

function UIForgeQuenchPanel.BindUIEvents()
    CS.UIEventListener.Get(UIForgeQuenchPanel.closeBtn).onClick = UIForgeQuenchPanel.OnClosseBtnClick
    CS.UIEventListener.Get(UIForgeQuenchPanel.bagToggle.gameObject).onClick = UIForgeQuenchPanel.OnBagBtnClick
    CS.UIEventListener.Get(UIForgeQuenchPanel.roleToggle.gameObject).onClick = UIForgeQuenchPanel.OnRoleBtnClick
    CS.UIEventListener.Get(UIForgeQuenchPanel.quenchListToggle.gameObject).onClick = UIForgeQuenchPanel.OnListBtnClick
    CS.UIEventListener.Get(UIForgeQuenchPanel.forgeQuenchBtn).onClick = UIForgeQuenchPanel.OnForgeQuenchBtnClick
end

function UIForgeQuenchPanel.BindNetMessage()
    UIForgeQuenchPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ForgeQuenchItemCheck, UIForgeQuenchPanel.OnForgeQuenchItemCheck)
    UIForgeQuenchPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ForgeQuenchStateChanged, UIForgeQuenchPanel.OnForgeQuenchStateChanged)
    UIForgeQuenchPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIForgeQuenchPanel.OnBagItemChanged)
    UIForgeQuenchPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCuiLianMessage, UIForgeQuenchPanel.OnResCuiLianMessage)
end

function UIForgeQuenchPanel:Show()
    UIForgeQuenchPanel.InitUI()
    UIForgeQuenchPanel.RefreshPageToggle(1)
end

--endregion

--region 函数监听

function UIForgeQuenchPanel.OnClosseBtnClick()
    uimanager:ClosePanel("UIForgeQuenchPanel")
end

function UIForgeQuenchPanel.OnListBtnClick()
    UIForgeQuenchPanel.RefreshPageToggle(1)
end

function UIForgeQuenchPanel.OnRoleBtnClick()
    UIForgeQuenchPanel.RefreshPageToggle(2)
end

function UIForgeQuenchPanel.OnBagBtnClick()
    UIForgeQuenchPanel.RefreshPageToggle(3)
end

function UIForgeQuenchPanel.OnForgeQuenchBtnClick(go)
    if UIForgeQuenchPanel.curBagItemInfo ~= nil and UIForgeQuenchPanel.forgeQuenchData:IsCanForgeQuench() then
        if (UIForgeQuenchPanel.CheckInsureState()) then
            gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():ShowInsurancePopup()
        else
            networkRequest.ReqCuiLian(UIForgeQuenchPanel.curForgeQuenchId, UIForgeQuenchPanel.curBagItemInfo.lid)
        end
    elseif UIForgeQuenchPanel.forgeQuenchData ~= nil then
        local reason = UIForgeQuenchPanel.forgeQuenchData:GetBeDefeateReason()
        if reason == 1 then
            Utility.ShowPopoTips(go, nil, 498, "UIForgeQuenchPanel")
        elseif reason == 2 then
            Utility.ShowPopoTips(go, nil, 497, "UIForgeQuenchPanel")
        end
    end
end

---@return boolean 是否已投保险
function UIForgeQuenchPanel.CheckInsureState()
    if (UIForgeQuenchPanel.MaterialGoAndTemplateDic == nil) then
        return false
    end
    for i, v in pairs(UIForgeQuenchPanel.MaterialGoAndTemplateDic) do
        if (v ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(v.bagItemInfo)) then
            return true
        end
    end
    return false
end
--endregion

--region 网络消息处理

---状态改变 ,修改按钮特效等等(暂留接口)
function UIForgeQuenchPanel.OnForgeQuenchStateChanged()

end

---淬炼物品点击事件
---@param data table
---@field data.id   number
---@field data.type LuaEnumForgeQuenchItemCheckReason
function UIForgeQuenchPanel.OnForgeQuenchItemCheck(msgId, data)
    if data == nil then
        return
    end
    local bagItemInfo = UIForgeQuenchPanel.GetForgeQuenchMgr():GetTargetBagItemInfo(data.type, data.itemId)
    if bagItemInfo == nil then
        UIForgeQuenchPanel.curForgeQuenchId = 0
        UIForgeQuenchPanel.curBagItemInfo = bagItemInfo
        UIForgeQuenchPanel.RefreshView()
    elseif bagItemInfo == UIForgeQuenchPanel.curBagItemInfo then
        return
    end

    UIForgeQuenchPanel.curBagItemInfo = bagItemInfo
    if data.type == LuaEnumForgeQuenchItemCheckReason.ForgeQuenchList then
        if UIForgeQuenchPanel.curForgeQuenchId ~= data.id then
            UIForgeQuenchPanel.curForgeQuenchId = data.id
            UIForgeQuenchPanel.RefreshView()
        end
    elseif data.type == LuaEnumForgeQuenchItemCheckReason.Bag or data.type == LuaEnumForgeQuenchItemCheckReason.Role then
        local forgeQuenchId = UIForgeQuenchPanel.GetForgeQuenchMgr():GetCuiLianIdByMaterialId(data.id)
        if forgeQuenchId ~= nil and UIForgeQuenchPanel.curForgeQuenchId ~= forgeQuenchId then
            UIForgeQuenchPanel.curForgeQuenchId = forgeQuenchId
            UIForgeQuenchPanel.RefreshView()
        end
    end

    UIForgeQuenchPanel:RefreshMainMaterialBagItemInfo()
end

---背包物品变化事件
function UIForgeQuenchPanel.OnBagItemChanged()
    UIForgeQuenchPanel.RefreshMaterialLabelView()
    UIForgeQuenchPanel.RefreshCostView()
end

---淬炼结果回调
function UIForgeQuenchPanel.OnResCuiLianMessage(msgId, tblData)
    if tblData == nil then
        return
    end
    local effectId = tblData.state == 1 and "700304" or "700303"
    UIForgeQuenchPanel.successEffect:ChangeEffect(effectId)
    if tblData.state == 1 then
        UIForgeQuenchPanel.curBagItemInfo = nil
        UIForgeQuenchPanel.curForgeQuenchId = 0
        UIForgeQuenchPanel.RefreshView()
    end
end

--endregion

--region UI

function UIForgeQuenchPanel.InitUI()
    UIForgeQuenchPanel.RefreshView()
end

function UIForgeQuenchPanel.RefreshView()
    UIForgeQuenchPanel.forgeQuenchData = UIForgeQuenchPanel.GetForgeQuenchAllDataDic()[UIForgeQuenchPanel.curForgeQuenchId]
    UIForgeQuenchPanel.RefreshMaterialView()
    UIForgeQuenchPanel.RefreshOutputItemView()
    UIForgeQuenchPanel.RefreshBtnView()
    UIForgeQuenchPanel.RefreshCostView()
    UIForgeQuenchPanel.RefreshOtherLabelView()
end

---刷新材料视图（文本单独刷新）
---@private
function UIForgeQuenchPanel.RefreshMaterialView()
    if UIForgeQuenchPanel.forgeQuenchData == nil or UIForgeQuenchPanel.forgeQuenchData:GetNeedMaterialInfo() == nil then
        UIForgeQuenchPanel.materialGrid.MaxCount = 0
        return
    end
    local table = UIForgeQuenchPanel.forgeQuenchData:GetNeedMaterialInfo()
    local count, initializedMain = #table, false
    UIForgeQuenchPanel.materialGrid.MaxCount = count
    for i = 1, count do
        local go = UIForgeQuenchPanel.materialGrid.controlList[i - 1]
        if go then
            local template
            if UIForgeQuenchPanel.MaterialGoAndTemplateDic[go] == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIForgeQuenchPanel_MaterialTemplate)
                UIForgeQuenchPanel.MaterialGoAndTemplateDic[go] = template
            else
                template = UIForgeQuenchPanel.MaterialGoAndTemplateDic[go]
            end
            template:SetTemplate({ materialInfo = table[i], forgeQuenchData = UIForgeQuenchPanel.forgeQuenchData })
            if not initializedMain then
                initializedMain = true
                UIForgeQuenchPanel.curMainMaterialTemplate = template
            end
        end
    end

end

---刷新材料数量
---@private
function UIForgeQuenchPanel.RefreshMaterialLabelView()
    for i, v in pairs(UIForgeQuenchPanel.MaterialGoAndTemplateDic) do
        v:RefreshLabelView()
    end
end

---刷新主材料数据
function UIForgeQuenchPanel.RefreshMainMaterialBagItemInfo()
    if UIForgeQuenchPanel.curMainMaterialTemplate ~= nil then
        UIForgeQuenchPanel.curMainMaterialTemplate:RefreshBagItemInfo(UIForgeQuenchPanel.curBagItemInfo)
    end
end

---刷新目标视图 (点击对比，绿色箭头)
---@private
function UIForgeQuenchPanel.RefreshOutputItemView()
    if UIForgeQuenchPanel.forgeQuenchData and UIForgeQuenchPanel.forgeQuenchData:GetForgeQuenchTbl() then
        ---@type TABLE.cfg_cuilian
        local cuilianTbl = UIForgeQuenchPanel.forgeQuenchData:GetForgeQuenchTbl()
        if cuilianTbl:GetOutputgoods() and cuilianTbl:GetOutputgoods().list then
            local tbl = cuilianTbl:GetOutputgoods().list
            local count = #tbl
            UIForgeQuenchPanel.outputGrid.MaxCount = count
            for i = 1, count do
                local go = UIForgeQuenchPanel.outputGrid.controlList[i - 1]
                if go then
                    local template
                    if UIForgeQuenchPanel.OutputGoAndTemplateDic[go] == nil then
                        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIForgeQuenchPanel_OutputTemplate)
                        UIForgeQuenchPanel.OutputGoAndTemplateDic[go] = template
                    else
                        template = UIForgeQuenchPanel.OutputGoAndTemplateDic[go]
                    end
                    template:SetTemplate({ itemId = tbl[i], equipIndex = UIForgeQuenchPanel.forgeQuenchData:GetEquipIndex() })
                end
            end
            local key = count > 1 and 2 or 1
            UIForgeQuenchPanel.outputGrid.transform.localPosition = UIForgeQuenchPanel.posTbl[key]
            return
        end
    else
        UIForgeQuenchPanel.outputGrid.MaxCount = 0
    end
end

---刷新货币消耗视图
---@private
function UIForgeQuenchPanel.RefreshCostView()
    if UIForgeQuenchPanel.forgeQuenchData == nil or UIForgeQuenchPanel.forgeQuenchData:GetNeedCoinInfo() == nil then
        if UIForgeQuenchPanel.costNum.gameObject.activeSelf then
            UIForgeQuenchPanel.costNum.gameObject:SetActive(false)
        end
        return
    end

    local coinTbl = UIForgeQuenchPanel.forgeQuenchData:GetNeedCoinInfo()
    if #coinTbl > 0 then
        local coinItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(coinTbl[1].itemID)
        local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(coinTbl[1].itemID)
        local color = curCount >= coinTbl[1].count and luaEnumColorType.Green or luaEnumColorType.Red
        UIForgeQuenchPanel.costIcon.spriteName = coinItemTbl:GetIcon()
        UIForgeQuenchPanel.costNum.text = color .. coinTbl[1].count .. '[-]'
    end

    if UIForgeQuenchPanel.costNum.gameObject.activeSelf ~= (#coinTbl > 0) then
        UIForgeQuenchPanel.costNum.gameObject:SetActive(#coinTbl > 0)
    end
end

---刷新按钮视图
---@private
function UIForgeQuenchPanel.RefreshBtnView()
    UIForgeQuenchPanel.forgeQuenchBtn:SetActive(UIForgeQuenchPanel.forgeQuenchData ~= nil)
end

---刷新其他文本视图
function UIForgeQuenchPanel.RefreshOtherLabelView()
    UIForgeQuenchPanel.showSprite.alpha = UIForgeQuenchPanel.forgeQuenchData ~= nil and 0.01 or 1
    if UIForgeQuenchPanel.forgeQuenchData and UIForgeQuenchPanel.forgeQuenchData:GetForgeQuenchTbl() then
        ---@type TABLE.cfg_cuilian
        local cuilianTbl = UIForgeQuenchPanel.forgeQuenchData:GetForgeQuenchTbl()
        UIForgeQuenchPanel.temperDes.text = cuilianTbl:GetDesc()
        local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(cuilianTbl:GetSyntheticgoods())
        if isFind then
            UIForgeQuenchPanel.curName.text = itemTbl.name
        end

    else
        UIForgeQuenchPanel.temperDes.text = ""
        UIForgeQuenchPanel.curName.text = ""
    end
end

--region 页签

function UIForgeQuenchPanel.RefreshPageToggle(type)
    if UIForgeQuenchPanel.curPageType == type then
        return
    end
    UIForgeQuenchPanel.quenchListToggle.value = type == 1
    UIForgeQuenchPanel.curPageType = type
    if UIForgeQuenchPanel.curPageType == 1 then
        ---列表
        uimanager:ClosePanel("UIBagPanel")
        uimanager:ClosePanel("UIRolePanel")
        uimanager:CreatePanel("UIForgeQuenchListPanel", nil)
    elseif UIForgeQuenchPanel.curPageType == 2 then
        ---角色
        uimanager:ClosePanel("UIBagPanel")
        uimanager:ClosePanel("UIForgeQuenchListPanel")
        uimanager:CreatePanel("UIRolePanel", nil,
                {
                    equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateForgeQuench,
                    equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateForgeQuench,
                    isShowArrowBtn = false,
                    isShowCloseBtn = false
                })
    elseif UIForgeQuenchPanel.curPageType == 3 then
        ---背包
        uimanager:ClosePanel("UIRolePanel")
        uimanager:ClosePanel("UIForgeQuenchListPanel")
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.ForgeQuench })
    end
end

--endregion

--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    uimanager:ClosePanel("UIBagPanel")
    uimanager:ClosePanel("UIRolePanel")
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIForgeQuenchListPanel")
end

--endregion

return UIForgeQuenchPanel