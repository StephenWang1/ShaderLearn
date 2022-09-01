---@class UIShenQiPanel:UIInlayPanelBase 神器镶嵌
local UIShenQiPanel = {}

setmetatable(UIShenQiPanel, luaPanelModules.UIInlayPanelBase)

UIShenQiPanel.mSuitBelong = LuaEnumSoulEquipType.ShenQi
UIShenQiPanel.mHelpId = 192

function UIShenQiPanel:Init()
    self:RunBaseFunction("Init")
    self:BindMessage()
end

function UIShenQiPanel:BindMessage()
    ---@param template UIRolePanel_GridTemplateBase
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.mRoleGridClicked_ShenQi, function(msgId, bagItemInfo)
        self:SetSelectEquip(bagItemInfo)
    end)
end

function UIShenQiPanel:ChangeCurrentChooseEquip(equipInfo)
    self:RunBaseFunction("ChangeCurrentChooseEquip", equipInfo)
    luaEventManager.DoCallback(LuaCEvent.ShenQiChooseGridChange, equipInfo)
end

---@return RolePanelParam 角色界面参数
function UIShenQiPanel:GetRolePanelData()
    ---@type RolePanelParam
    local panelData = {}
    ---@type UIRolePanel_EquipTemplateShenQi
    panelData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateShenQi
    ---@type UIRolePanel_GridTemplateShenQi
    panelData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateShenQi
    return panelData
end

---自动选中角色道具
---@return bagV2.BagItemInfo
function UIShenQiPanel:GetAutoChooseBagItemInfo()
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if LuaPlayerEquipmentListData then
        local equipDic = LuaPlayerEquipmentListData.EquipmentDic
        local firstCanInlayEquip = nil
        for k, v in pairs(equipDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            if equipInfo.BagItemInfo then
                local canInlay = self:GetDataManager():IsEquipCanInlay_XianZhuang(self.mSuitBelong, equipInfo.BagItemInfo)
                if canInlay then
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

---获得背包中可装备列表
---@return table<number,bagV2.BagItemInfo>
function UIShenQiPanel:GetCanInlayItemList()
    return self:GetDataManager():GetBagAllCanInlay_XianZhuang(self.mSuitBelong, self:GetSelectEquip())
end

function UIShenQiPanel:ClosePanel()
    self:RunBaseFunction("ClosePanel")
    if self.mHasCloseRole ~= true then
        self:CloseAllPanel()
        self.mHasCloseRole = true
    end
end

---@param bagItemInfo bagV2.BagItemInfo 选中魂装信息
function UIShenQiPanel:RefreshSkillShow(bagItemInfo)
    local hasData = bagItemInfo ~= nil
    if not hasData then
        self:GetSoulEquipDes_Text().text = ""
        return
    end
    local luaItemInfo = self:CacheItemInfo(bagItemInfo.itemId)
    if luaItemInfo == nil then
        self:GetSoulEquipDes_Text().text = ""
        return
    end
    local effectId = luaItemInfo:GetExtraMonEffectInlay()
    self:GetSoulEquipDes_Text().text = ""
end

function ondestroy()
    if UIShenQiPanel.mHasCloseRole ~= true then
        UIShenQiPanel:CloseAllPanel()
    end
end

return UIShenQiPanel