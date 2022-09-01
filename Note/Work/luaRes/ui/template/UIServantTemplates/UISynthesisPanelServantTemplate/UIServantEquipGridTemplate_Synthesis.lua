local UIServantEquipGridTemplate_Synthesis = {}

setmetatable(UIServantEquipGridTemplate_Synthesis,luaComponentTemplates.UIServantEquipGridTemplate)

function UIServantEquipGridTemplate_Synthesis:RefreshEquip(info, type)
    self:CallRedPoint()
    self:RunBaseFunction("RefreshEquip",info, type)
end

function UIServantEquipGridTemplate_Synthesis:RefreshOther()
    --self:BindRedPoint()
    self:CallRedPoint()
end

function UIServantEquipGridTemplate_Synthesis:BindRedPoint()
    local servantEquipIndex = CS.CSServantInfoV2.GetServantEquipIndexByBagItemInfo(self.BagItemInfo)
    if servantEquipIndex == nil or servantEquipIndex < 0 then
        return
    end
    self.redPointKey =  gameMgr:GetLuaRedPointManager():GetRedPointKey(LuaEnumRedPointType.Synthesis,servantEquipIndex)
    if self.redPointKey == nil then
        return
    end
    if CS.StaticUtility.IsNull(self:GetRedPoint_UIRedPoint()) then
        return
    end
    self:GetRedPoint_UIRedPoint():AddRedPointKey(self.redPointKey)
end

function UIServantEquipGridTemplate_Synthesis:SetItemChoose(isChoose)
    self:RunBaseFunction("SetItemChoose",isChoose)
    if isChoose and self.BagItemInfo ~= nil and self.BagItemInfo.ItemTABLE ~= nil then
        ---@type ServantSynthesisChooseItemCommonData
        local chooseItemData = {}
        chooseItemData.servantSeatType = self.mServantType
        chooseItemData.servantEquipIndexType = self.mEquipPosIndex
        gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetChooseItemInfoClass():SetServantSynthesisChooseItemInfo(chooseItemData)

        --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(self.BagItemInfo.ItemTABLE.id)
        --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(self.BagItemInfo.ItemTABLE.id)
        --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint)
    end
end

function UIServantEquipGridTemplate_Synthesis:CallRedPoint()
    if self.redPointKey ~= nil then
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint)
    end
end

return UIServantEquipGridTemplate_Synthesis