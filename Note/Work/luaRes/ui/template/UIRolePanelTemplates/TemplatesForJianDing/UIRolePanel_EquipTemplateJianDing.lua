---@class UIRolePanel_EquipTemplateJianDing:UIRolePanel_EquipTemplate --鉴定
local UIRolePanel_EquipTemplateJianDing ={}
setmetatable(UIRolePanel_EquipTemplateJianDing,luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplateJianDing:OnInit()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.JiandingChoose, function(msgId, bagItemInfo)
            self:SetItemShowChoose(bagItemInfo)
        end)
    end
end

function UIRolePanel_EquipTemplateJianDing:InitGrid(template, customData, avatarInfo)
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

function UIRolePanel_EquipTemplateJianDing:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template:GetItemChooseState() == true then
        self:ShowItemInfo(template, false);
    end
    if template and template.bagItemInfo then
        if self:GetJianDingTable(template.bagItemInfo) then
            luaEventManager.DoCallback(LuaCEvent.JianDingClick,template.bagItemInfo)
            self:SetItemShowChoose(template.bagItemInfo)
        else
            Utility.ShowPopoTips(go, nil, 495)
        end
    end
end

---设置某格子选中显示
--@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplateJianDing:SetItemShowChoose(bagItemInfo)

    if self.mCurrentChooseBagItemInfo ~= nil then
        self:SetItemChooseState(self.mCurrentChooseBagItemInfo, false)
    end
    self.mCurrentChooseBagItemInfo = bagItemInfo
    self:SetItemChooseState(self.mCurrentChooseBagItemInfo, true)
end

---设置单个模板选中状态
function UIRolePanel_EquipTemplateJianDing:SetItemChooseState(bagItemInfo, isChoose)
    if bagItemInfo == nil then
        return
    end
    ---@type UIRolePanel_GridTemplateXianZhuang
    local template = self.mEquipIndexToTemplate[bagItemInfo.index]
    if template then
        template:SetItemChoose(isChoose)
    end
end


function UIRolePanel_EquipTemplateJianDing:GetJianDingTable(bagItemInfo)
    local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if  Lua_jianDingTABLE:GetJianDing() == 1 then
        return true
    else
        return false
    end
end


return UIRolePanel_EquipTemplateJianDing