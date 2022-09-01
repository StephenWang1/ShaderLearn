---灵兽装备面板（合成状态下）
---@class UIServantPanel_Base_Synthesis:UIServantPanel_Base
local UIServantPanel_Base_Synthesis = {}
setmetatable(UIServantPanel_Base_Synthesis, luaComponentTemplates.UIServantPanel_Base)

UIServantPanel_Base_Synthesis.mCurrentChooseTemplate = nil

---@return bagV2.BagItemInfo
function UIServantPanel_Base_Synthesis:GetSynthesisMainBagItemInfo()
    local synthesisPanel = uimanager:GetPanel("UISynthesisPanel");
    if (synthesisPanel ~= nil) then
        local mainBagItemInfo = synthesisPanel:GetSynthesisViewTemplate():GetSynthesisMainBagItemInfo();
        if (mainBagItemInfo ~= nil) then
            return mainBagItemInfo;
        end
    end
end

function UIServantPanel_Base_Synthesis:Init(panel)
    self:RunBaseFunction("Init", panel)
    self.ServantPanel:ShowOtherButton(false)
    self:GetAllBtn_GameObject():SetActive(false)
    self:GetEquipHelp_GameObject():SetActive(false)
    UIServantPanel_Base_Synthesis.mCurrentChooseTemplate = nil
end

function UIServantPanel_Base_Synthesis:InitComponents()
    self:RunBaseFunction("InitComponents")
    self.mIndexToEquipTemp[1] = templatemanager.GetNewTemplate(self:GetNeckEquip_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[2] = templatemanager.GetNewTemplate(self:GetLeftRing_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[12] = templatemanager.GetNewTemplate(self:GetRightRing_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[3] = templatemanager.GetNewTemplate(self:GetLeftCuff_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[13] = templatemanager.GetNewTemplate(self:GetRightCuff_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[4] = templatemanager.GetNewTemplate(self:GetBelt_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[5] = templatemanager.GetNewTemplate(self:GetShoes_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToEquipTemp[6] = templatemanager.GetNewTemplate(self:GetMagicWeapon_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)

    self.mIndexToBodyTemp[1] = templatemanager.GetNewTemplate(self:GetBrain_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToBodyTemp[2] = templatemanager.GetNewTemplate(self:GetHeart_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToBodyTemp[3] = templatemanager.GetNewTemplate(self:GetBone_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
    self.mIndexToBodyTemp[4] = templatemanager.GetNewTemplate(self:GetBlood_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate_Synthesis, self.ServantPanel)
end

function UIServantPanel_Base_Synthesis:OnClickEquip(go)
    local template = self.mGridToTemplate[go]
    if template then
        local bagItemInfo = template.BagItemInfo
        if bagItemInfo and bagItemInfo.ItemTABLE then
            local canSynthesis = clientTableManager.cfg_synthesisManager:IsCanSynthesis(bagItemInfo.itemId)
            if canSynthesis then
                luaEventManager.DoCallback(LuaCEvent.Servant_OnEquipSynthesisClick, bagItemInfo);
                if self.mCurrentChooseTemplate then
                    self:ChooseUnit(self.mCurrentChooseTemplate, false);
                end
                self:ChooseUnit(template, true);
            else
                Utility.ShowPopoTips(go, "该装备无法合成", 329, "UIServantPanel")
            end
        end
    end
end

---灵兽切换刷新选中
function UIServantPanel_Base_Synthesis:RefreshServant(servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    self:RunBaseFunction("RefreshServant", servantInfo, panelOpenType, bagItemInfo, isMainPlayerServant)
    self.ServantPanel:GetBtnShowAttribute():SetActive(false);
    self.ServantPanel:ShowOtherButton(false);
end

function UIServantPanel_Base_Synthesis:RefreshGridTemp(temp, index, equipInfo, grid, servantType)
    if (equipInfo == nil) or grid:IsNull() then
        return
    end
    --红点
    local redPoint = grid.transform:Find("RedPoint").gameObject
    redPoint:SetActive(false)
    --加号
    local add = grid.transform:Find("add").gameObject
    add:SetActive(false)
    --刷新装备信息
    CS.UIEventListener.Get(grid).LuaEventTable = self
    self.mGridToTemplate[grid] = temp
    local res, dicInfo = equipInfo:TryGetValue(index)
    if res then
        --该位置有装备
        --self.lidToTemplate[dicInfo.lid] = temp
        local canSynthesis = clientTableManager.cfg_synthesisManager:IsCanSynthesis(dicInfo.itemId)
        temp:RefreshEquip(dicInfo, canSynthesis and LuaEnumServantEquipShowColorType.Normal or LuaEnumServantEquipShowColorType.Gray);
        CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickEquip
        local isChoose = self:GetSynthesisMainBagItemInfo() ~= nil and self:GetSynthesisMainBagItemInfo().lid == dicInfo.lid;
        self:ChooseUnit(temp, isChoose)
    else
        --该位置没有装备
        temp:ResetEquip()
        self:ChooseUnit(temp, false)
    end
end

---刷新Item选中状态
function UIServantPanel_Base_Synthesis:ChooseUnit(targetUnit, isChoose)
    targetUnit:SetItemChoose(isChoose);
    if isChoose then
        self.mCurrentChooseTemplate = targetUnit
    end
end

return UIServantPanel_Base_Synthesis