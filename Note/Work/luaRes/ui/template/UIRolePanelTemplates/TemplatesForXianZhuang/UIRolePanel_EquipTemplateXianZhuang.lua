---@class UIRolePanel_EquipTemplateXianZhuang:UIRolePanel_EquipTemplate 仙装角色模板
local UIRolePanel_EquipTemplateXianZhuang = {}

setmetatable(UIRolePanel_EquipTemplateXianZhuang, luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplateXianZhuang:OnInit()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.XianZhuangChooseGridChange, function(msgId, bagItemInfo)
            self:SetItemShowChoose(bagItemInfo)
        end)
    end
end

function UIRolePanel_EquipTemplateXianZhuang:InitGrid(template, customData, avatarInfo)
    self:RunBaseFunction("InitGrid", template, customData, avatarInfo);
    self.lamp:SetActive(false);
    self.souljade:SetActive(false);
    self.jewel:SetActive(false);
    self.medal:SetActive(false);
    self.rawanima:SetActive(false);
    self.hufu:SetActive(false);
    self.seal:SetActive(false);
    self.maPai:SetActive(false);
    self.anqi:SetActive(false);

    self.helmet.transform.localPosition = CS.UnityEngine.Vector3(30, 113, 0);
    self.necklace.transform.localPosition = CS.UnityEngine.Vector3(30, 23, 0);
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateXianZhuang:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateBase
    local template = self.mGridToTemplate[go];
    if template:GetItemChooseState() == true then
        self:ShowItemInfo(template, false);
    else
        local tipsInfo = {};
        local bagItemInfo = template.bagItemInfo;
        if bagItemInfo ~= nil then
            local canSoulEquipSet = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():IsEquipCanInlay_XianZhuang(LuaEnumSoulEquipType.XianZhuang, bagItemInfo)
            if not canSoulEquipSet then
--[[                tipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 457
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo)]]
                Utility.ShowPopoTips(go, nil, 487)
                return
            end
        end
        luaEventManager.DoCallback(LuaCEvent.mRoleGridClicked_XianZhuang, template.bagItemInfo)
    end
end

---设置某格子选中显示
---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplateXianZhuang:SetItemShowChoose(bagItemInfo)

    if self.mCurrentChooseBagItemInfo ~= nil then
        self:SetItemChooseState(self.mCurrentChooseBagItemInfo, false)
    end
    self.mCurrentChooseBagItemInfo = bagItemInfo
    self:SetItemChooseState(self.mCurrentChooseBagItemInfo, true)
end

---设置单个模板选中状态
function UIRolePanel_EquipTemplateXianZhuang:SetItemChooseState(bagItemInfo, isChoose)
    if bagItemInfo == nil then
        return
    end
    ---@type UIRolePanel_GridTemplateXianZhuang
    local template = self.mEquipIndexToTemplate[bagItemInfo.index]
    if template then
        template:SetItemChoose(isChoose)
    end
end

return UIRolePanel_EquipTemplateXianZhuang