---@class UIBagMain_BloodSuit:UIBagMain_Normal
local UIBagMain_BloodSuit = {}

setmetatable(UIBagMain_BloodSuit, luaComponentTemplates.UIBagMainNormal)


--region 重写初始化方法
function UIBagMain_BloodSuit:OnInit()
    self:RunBaseFunction("OnInit")
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshBloodSuitBag, function()
        if self:IsOn() == false then
            return
        end
        self:SetBagInfoIsDirty()
        self:GetBagPanel():RefreshGrids()
    end)
end
--endregion


--region 重写属性
---不使用服务器排序
function UIBagMain_BloodSuit:IsUseServerOrder()
    return false
end
--endregion

--region 重写格子排序方法
function UIBagMain_BloodSuit:BagItemListSortFunction(LeftItem, RightItem)
    local leftIsBloodsuitItem = self:IsSelectBloodsuitItem(LeftItem.ItemTABLE)
    local rightIsBloodsuitItem = self:IsSelectBloodsuitItem(RightItem.ItemTABLE)
    if leftIsBloodsuitItem == rightIsBloodsuitItem and rightIsBloodsuitItem == true then
        return false
    end
    if leftIsBloodsuitItem == true then
        return true
    elseif rightIsBloodsuitItem == true then
        return false
    else
        return false
    end
end
--endregion

----region 重写格子筛选方法
--function UIBagMain_BloodSuit:BagItemFilterFunction(bagItemInfo, itemInfo)
--    local nowSelectType = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr().NowSelectSuit
--    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
--    if bloodsuitTbl == nil then
--        return false
--    end
--    if bloodsuitTbl:GetQualityLevel() == nowSelectType then
--        return true
--    end
--    return false
--end
----endregion

---刷新单个格子
function UIBagMain_BloodSuit:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if not self:IsSelectBloodsuitItem(itemTbl) then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    else
        if self:IsEmptyPlaceExistSuitableForBagItem(bagGrid, bagItemInfo, itemTbl) then
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
        end
    end
end

function UIBagMain_BloodSuit:RefreshBasicGridParams(bagGrid, bagItemInfo, itemTbl)
    ---刷新icon
    bagGrid:SetCompSpriteName(bagGrid.Components.Icon, itemTbl.icon)
    ---刷新物品数量/剩余使用次数
    local count = bagItemInfo.count
    if count <= 1 then
        count = bagItemInfo.leftUseNum
    end
    bagGrid:SetCompLabelContent(bagGrid.Components.Count, (count > 1) and tostring(count) or nil)
    ---刷新背包物品强化标记
    self:RefreshBagGridStrength(bagGrid, bagItemInfo, itemTbl)
    ---刷新聚灵珠的百分比
    self:RefreshJuLingZhuFillAmount(bagGrid, bagItemInfo, itemTbl)
    ---刷新血继套装标识
    self:RefreshBloodSuitSign(bagGrid, bagItemInfo, itemTbl)
end

---是否是血继装备
---@return boolean
function UIBagMain_BloodSuit:IsSelectBloodsuitItem(itemInfo)
    local nowSelectType = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr().NowSelectSuit
    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemInfo.id)
    if bloodsuitTbl == nil then
        return false
    end
    if bloodsuitTbl:GetQualityLevel() == nowSelectType then
        return true
    end
    return false
end

---血继界面中是否有空位置允许目标物品装备上
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemInfo TABLE.CFG_ITEMS
function UIBagMain_BloodSuit:IsEmptyPlaceExistSuitableForBagItem(bagGrid, bagItemInfo, itemInfo)
    if uimanager:GetPanel("UIRoleBloodSuitPanel") == nil then
        return false
    end
    local mainPlayerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    local nowSelectType = mainPlayerBloodSuitEquipMgr.NowSelectSuit
    if nowSelectType then
        local bloodSuitData = mainPlayerBloodSuitEquipMgr:GetSingleBloodSuitDic(nowSelectType)
        local bloodSuitSubType = uiStaticParameter.GetBloodSuitSubTypeByItemTable(itemInfo)
        if bloodSuitData then
            local emptyEquipIndex = nil
            for i, v in pairs(bloodSuitData) do
                local equipIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetEquipIndex(nowSelectType, i)
                ---考虑下格子的解锁状况
                if gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsEquipGridUnlocked(equipIndex)
                        and v.BagItemInfo == nil and bloodSuitSubType == uiStaticParameter.GetBloodSuitSubTypeBySuitItemType(i) then
                    emptyEquipIndex = i
                    break
                end
            end
            if emptyEquipIndex == nil then
                return
            end
            return mainPlayerBloodSuitEquipMgr:GetWearSameBloodsuit(itemInfo.id, nowSelectType) == nil
        end
    end
    return false
end

--region 重写关闭按钮显示
---是否显示关闭按钮
---@public
---@return boolean
function UIBagMain_BloodSuit:IsShowCloseButton()
    return true
end
--endregion

--region 重写扩展按钮显示
---@public
---@return boolean
function UIBagMain_BloodSuit:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_BloodSuit:IsShowRecycleButton()
    return false
end
--endregion

--region 重写销毁方法
function UIBagMain_BloodSuit:OnDestroy()
    self:RunBaseFunction("OnDestroy")
end
--endregion

--region 面板关闭
---面板关闭
---@public
function UIBagMain_BloodSuit:PanelClose(panelName)
    if panelName == "UIRoleBloodSuitPanel" then
        uimanager:ClosePanel("UIBagPanel")
    end
end
--endregion

--region  格子方法
---格子被单击
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMain_BloodSuit:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if bagItemInfo == nil then
        return
    end
    self:ShowItemInfo(bagItemInfo)
end

---格子被双击
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMain_BloodSuit:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    if bagItemInfo == nil or itemTbl == nil then
        return
    end
    local mainPlayerBloodSuitEquipMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
    local iscanUse, notUseIndex = mainPlayerBloodSuitEquipMgr:IsCanUseBloodSuit(itemTbl)
    if iscanUse == false then
        mainPlayerBloodSuitEquipMgr:NotUseTips(bagGrid.go, notUseIndex)
        return
    end
    local currentSelectedSuitType = mainPlayerBloodSuitEquipMgr.NowSelectSuit
    local currentSelectedEquipIndex = mainPlayerBloodSuitEquipMgr:GetNowSelectEquipIndex()
    local currentEquippedBloodSuit = mainPlayerBloodSuitEquipMgr:GetWearSameBloodsuit(itemTbl.id, currentSelectedSuitType)
    local targetEquipIndex = currentSelectedEquipIndex
    if currentEquippedBloodSuit ~= nil then
        ---重复穿戴了该装备
        if currentSelectedEquipIndex == currentEquippedBloodSuit.index then
            ---当前选中的装备就是同itemID装备,则进行替换,不进行处理
        else
            ---当前选中的装备不是同itemID装备,则提示并终止替换
            Utility.ShowPopoTips(bagGrid.go, "不可重复穿戴", 428)
            return
        end
    else
        ---未重复穿戴该装备,寻找一个空格,如果有空格则使用空格的装备位
        local allEquppedBloodSuits = mainPlayerBloodSuitEquipMgr:GetSingleBloodSuitDic(currentSelectedSuitType)
        local targetBloodSuitSubType = uiStaticParameter.GetBloodSuitSubTypeByItemTable(itemTbl)
        ---空装备位
        local emptyEquipIndex = nil
        if allEquppedBloodSuits then
            for i, v in pairs(allEquppedBloodSuits) do
                if v.BagItemInfo == nil and targetBloodSuitSubType == uiStaticParameter.GetBloodSuitSubTypeBySuitItemType(i) then
                    emptyEquipIndex = i
                    break
                end
            end
        end
        if emptyEquipIndex ~= nil then
            ---如果有空装备位,则将空装备位作为目标装备位并选中它
            targetEquipIndex = mainPlayerBloodSuitEquipMgr:GetEquipIndex(currentSelectedSuitType, emptyEquipIndex)
            ---@type UIRoleBloodSuitPanel
            local roleBloodSuitPanel = uimanager:GetPanel("UIRoleBloodSuitPanel")
            if roleBloodSuitPanel then
                ---让血继界面选中该装备位
                roleBloodSuitPanel:RefreshSelectIndex(emptyEquipIndex)
            end
        else
            ---如果没有空装备位,则保持当前选中的装备位
        end
    end
    networkRequest.ReqPutOnTheEquip(targetEquipIndex, bagItemInfo.lid)
end

---格子被长时间按下
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMain_BloodSuit:OnGridLongPressed(bagGrid, bagItemInfo, itemTbl)
    print('格子长时间按下')
end

--endregion

function UIBagMain_BloodSuit:ShowItemInfo(bagItemInfo)
    if bagItemInfo and bagItemInfo.ItemTABLE then
        if self:IsSelectBloodsuitItem(bagItemInfo.ItemTABLE) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({
                bagItemInfo = bagItemInfo,
                rightUpButtonsModule = luaComponentTemplates.UIRoleBloodSuit_BagRightUpOperate,
                itemType = LuaEnumItemInfoPanelItemType.BloodSuit,
                showRight = true }
            )
        else
            uiStaticParameter.UIItemInfoManager:CreatePanel({
                bagItemInfo = bagItemInfo,
                rightUpButtonsModule = luaComponentTemplates.UIRoleBloodSuit_BagRightUpOperate,
                showRight = false }
            )
        end
    end
end

return UIBagMain_BloodSuit