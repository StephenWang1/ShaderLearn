---@class UIXianZhuangPanel:UIInlayPanelBase 仙装镶嵌
local UIXianZhuangPanel = {}

setmetatable(UIXianZhuangPanel, luaPanelModules.UIInlayPanelBase)

UIXianZhuangPanel.mSuitBelong = LuaEnumSoulEquipType.XianZhuang
UIXianZhuangPanel.mHelpId = 191

function UIXianZhuangPanel:Init()
    self:RunBaseFunction("Init")
    self:BindMessage()
end

function UIXianZhuangPanel:BindMessage()
    ---@param template UIRolePanel_GridTemplateBase
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mRoleGridClicked_XianZhuang, function(msgId, bagItemInfo)
        self:SetSelectEquip(bagItemInfo)
    end)
end

function UIXianZhuangPanel:ChangeCurrentChooseEquip(equipInfo)
    self:RunBaseFunction("ChangeCurrentChooseEquip", equipInfo)
    luaEventManager.DoCallback(LuaCEvent.XianZhuangChooseGridChange, equipInfo)
end

---@return RolePanelParam 角色界面参数
function UIXianZhuangPanel:GetRolePanelData()
    ---@type RolePanelParam
    local panelData = {}
    ---@type UIRolePanel_EquipTemplateXianZhuang
    panelData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateXianZhuang
    ---@type UIRolePanel_GridTemplateXianZhuang
    panelData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateXianZhuang
    return panelData
end

---自动选中角色道具
---@return bagV2.BagItemInfo
function UIXianZhuangPanel:GetAutoChooseBagItemInfo()
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if LuaPlayerEquipmentListData then
        local equipDic = LuaPlayerEquipmentListData.EquipmentDic
        local firstCanInlayEquip = nil
        for k, v in pairs(equipDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            if equipInfo.BagItemInfo then
                local canInlay = self:GetDataManager():IsEquipCanInlay_XianZhuang(self.mSuitBelong, equipInfo.BagItemInfo)
                local noInlay = self:GetDataManager():GetSoulEquipClassToEquipIndex(self.mSuitBelong, equipInfo.BagItemInfo.index) == nil
                if canInlay and noInlay then
                    local bagItemList = self:GetDataManager():GetBagAllCanInlay_XianZhuang(self.mSuitBelong, equipInfo.BagItemInfo)
                    if firstCanInlayEquip == nil then
                        firstCanInlayEquip = equipInfo.BagItemInfo
                    end
                    if #bagItemList > 0 then
                        return equipInfo.BagItemInfo
                    end
                end
            end
        end
        return firstCanInlayEquip
    end
end

---根据材料获取对应装备位上的装备
---@return bagV2.BagItemInfo
---@param materialInfo bagV2.BagItemInfo
function UIXianZhuangPanel:GetAutoChooseBagItemInfoByMaterial(materialInfo)
    if materialInfo == nil then
        return
    end
    local luaItemInfo = self:CacheItemInfo(materialInfo.itemId)
    local indexes = Utility.GetEquipIndexesByLuaItemTbl(luaItemInfo)
    for i = 1, #indexes do
        local index = indexes[i]
        local playerEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(index)
        if playerEquip then
            return playerEquip
        end
    end
end

---获得背包中可装备列表
---@return table<number,bagV2.BagItemInfo>
function UIXianZhuangPanel:GetCanInlayItemList()
    return self:GetDataManager():GetBagAllCanInlay_XianZhuang(self.mSuitBelong, self:GetSelectEquip())
end

function UIXianZhuangPanel:ClosePanel()
    self:RunBaseFunction("ClosePanel")
    if self.mHasCloseRole ~= true then
        self:CloseAllPanel()
        self.mHasCloseRole = true
    end
end

---@param bagItemInfo bagV2.BagItemInfo 选中魂装信息
function UIXianZhuangPanel:RefreshSkillShow(bagItemInfo)
    local hasData = bagItemInfo ~= nil
    if not hasData then
        self:GetSoulEquipDes_Text().text = ""
        self:GetSoulName_Lb().text = ""
        return
    end
    local luaItemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if luaItemInfo == nil then
        self:GetSoulEquipDes_Text().text = ""
        self:GetSoulName_Lb().text = ""
        return
    end
    local effectId = luaItemInfo:GetExtraMonEffectInlay()
    if effectId then
        local effectInfo = clientTableManager.cfg_inlay_effectManager:TryGetValue(effectId)
        if effectInfo then
            local attr = clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeShow(effectInfo:GetExtraMonEffect(), self:GetDataManager():GetMainPlayerCareer())
            local buffDes = clientTableManager.cfg_inlay_effectManager:GetBuffesTipsDes(effectId)
            if (not Utility.IsNilOrEmptyString(buffDes)) then
                attr = attr .. (Utility.IsNilOrEmptyString(attr) and '' or '\n') .. buffDes
            end
            self:GetSoulEquipDes_Text().text = luaEnumColorType.Gray .. attr
            local tbl_item = Utility.GetItemTblByBagItemInfo(bagItemInfo)
            if (tbl_item ~= nil) then
                self:GetSoulName_Lb().text = tbl_item:GetName() --self:GetDataManager():GetAddSoulEquipName(bagItemInfo.itemId, self:GetSelectEquip().itemId, self:GetSelectEquip().index)
            end
        end
    end
end
function UIXianZhuangPanel:RefreshCurrentSoulEquipHole()
    self:GetSoulEquipHole_left():RefreshUI(self:GetHoleCustomData(1))
    self:GetSoulEquipHole_centre():RefreshUI(self:GetHoleCustomData(2))
    self:GetSoulEquipHole_right():RefreshUI(self:GetHoleCustomData(3))
end

function UIXianZhuangPanel:RefreshTheInlayPos()
    self.subIndex = self:GetFirstGridPosition()
end

function UIXianZhuangPanel:RefreshTheInlayGrid()
    if (self.lastInlayHole ~= nil) then
        self.lastInlayHole:ShowSelectedEffects(false)
    end
    if (self.subIndex == 1) then
        self:GetSoulEquipHole_left():ShowSelectedEffects(true)
        self.lastInlayHole = self:GetSoulEquipHole_left()
    elseif (self.subIndex == 2) then
        self:GetSoulEquipHole_centre():ShowSelectedEffects(true)
        self.lastInlayHole = self:GetSoulEquipHole_centre()
    elseif (self.subIndex == 3) then
        self:GetSoulEquipHole_right():ShowSelectedEffects(true)
        self.lastInlayHole = self:GetSoulEquipHole_right()
    end
end

function UIXianZhuangPanel:IsOpenHoleByBagItemChange()
    if (self:GetSelectEquip() == nil) then
        return false
    end
    for i = 1, gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr().holeCount do
        local equipHoleInfo = self:AcquireHorcruxOfTheHolePosition(i)
        if (equipHoleInfo == nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():CanTurnOnTheGrid(self.mSuitBelong, self:GetSelectEquip() ~= nil and self:GetSelectEquip().index or 0)) then
            return true
        end
    end
    return false
end

--region private
function UIXianZhuangPanel:GetHoleCustomData(pos)
    local data = {}
    data.index = self:GetSelectEquip() ~= nil and self:GetSelectEquip().index or 0
    data.subIndex = pos
    data.mSuitBelong = self.mSuitBelong
    data.equipHoleInfo = self:AcquireHorcruxOfTheHolePosition(pos)
    data.selectEquip = self:GetSelectEquip()
    ---@param pos number
    ---@param inlayHole UISoulEquipInlayHole
    data.func = function(pos, inlayHole)
        if (self.lastInlayHole ~= nil and inlayHole ~= nil and self.lastInlayHole.subIndex ~= inlayHole.subIndex) then
            self.lastInlayHole:ShowSelectedEffects(false)
        end
        if (inlayHole ~= nil) then
            inlayHole:ShowSelectedEffects(true)
        end
        self.subIndex = pos
        self.lastInlayHole = inlayHole
        --self:ChangeCurrentChooseSoulEquip()
        --self:RefreshCurrentSoulEquip()
    end
    return data
end

--endregion

--region 支持重写
---是否可以使用系统
---@return boolean
function UIXianZhuangPanel:CanUseSystem()
    return LuaGlobalTableDeal:XianZhuangInlaySystemIsOpen()
end
--endregion

function ondestroy()
    if UIXianZhuangPanel.mHasCloseRole ~= true then
        UIXianZhuangPanel:CloseAllPanel()
    end
end

return UIXianZhuangPanel