---@class UIRolePanel_EquipTemplateRecast:UIRolePanel_EquipTemplate 重铸角色格子列表
local UIRolePanel_EquipTemplateRecast = {}

setmetatable(UIRolePanel_EquipTemplateRecast, luaComponentTemplates.UIRolePanel_EquipTemplate)

function UIRolePanel_EquipTemplateRecast:InitGrid(template, customData, avatarInfo)
    self:RunBaseFunction("InitGrid", template, customData, avatarInfo);
    self.seal:SetActive(false);
    self.maPai:SetActive(false);
    self.anqi:SetActive(false);

    self:ChooseDefaultEquipIndex()
end

function UIRolePanel_EquipTemplateRecast:ChooseDefaultEquipIndex()
    if uiStaticParameter.RecastChooseEquipIndex ~= nil then
        self:SetItemShowChooseByEquipIndex(uiStaticParameter.RecastChooseEquipIndex)
    end
end

---帧更新事件
function UIRolePanel_EquipTemplateRecast:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            if (self.mPressTarget ~= nil) then
                local template = self.mGridToTemplate[self.mPressTarget]
                self:ShowItemInfo(template, false);
                self.mIsLongPressShowItemInfo = true;
                self.mPressTarget = nil;
            end
            return ;
        end
    end
end

---重写角色格子点击事件
function UIRolePanel_EquipTemplateRecast:OnItemClicked(go)
    ---@type UIRolePanel_GridTemplateBase
    local template = self.mGridToTemplate[go];
    --if template:GetItemChooseState() == true then
    --    self:ShowItemInfo(template, false);
    --else
    --    local tipsInfo = {};
    --    local bagItemInfo = template.bagItemInfo;
    --    --if bagItemInfo ~= nil then
    --    --    local isRecastItem = gameMgr:GetPlayerDataMgr():GetRecastMgr():IsRecastItem(template.itemInfo.id)
    --    --    if not isRecastItem then
    --    --        Utility.ShowPopoTips(go, "不是重铸对象", 487)
    --    --        return
    --    --    end
    --    --end
    --    --self:SetItemShowChoose(template.bagItemInfo)
    --    --uiStaticParameter.RecastChooseEquipIndex = template.equipIndex
    --    luaEventManager.DoCallback(LuaCEvent.ReforgedRoleGridClick, template)
    --end
    if template ~= nil then
        self:ShowItemInfo(template, false);
    end
end

---设置某格子选中显示
---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplateRecast:SetItemShowChoose(bagItemInfo)
    if self.mCurrentChooseBagItemInfo ~= nil then
        self:SetItemChooseState(self.mCurrentChooseBagItemInfo, false)
    end
    self.mCurrentChooseBagItemInfo = bagItemInfo
    self:SetItemChooseState(self.mCurrentChooseBagItemInfo, true)
end

---设置装备位选中显示
---@param equipIndex LuaEquipmentItemType
function UIRolePanel_EquipTemplateRecast:SetItemShowChooseByEquipIndex(equipIndex)
    if self.mCurrentChooseEquipIndex ~= nil then
        self:SetItemChooseStateByEquipIndex(self.mCurrentChooseEquipIndex, false)
    end
    self.mCurrentChooseEquipIndex = equipIndex
    self:SetItemChooseStateByEquipIndex(self.mCurrentChooseEquipIndex, true)
end

---设置单个模板选中状态
---@param bagItemInfo bagV2.BagItemInfo
function UIRolePanel_EquipTemplateRecast:SetItemChooseState(bagItemInfo, isChoose)
    if bagItemInfo == nil then
        return
    end
    self:SetItemChooseStateByEquipIndex(bagItemInfo.index,isChoose)
end

---设置单个模板选中状态
function UIRolePanel_EquipTemplateRecast:SetItemChooseStateByEquipIndex(equipIndex, isChoose)
    if type(equipIndex) ~= 'number' or type(isChoose) ~= 'boolean' then
        return
    end
    local template = self.mEquipIndexToTemplate[equipIndex]
    if template then
        template:SetItemChoose(isChoose)
    end
end


return UIRolePanel_EquipTemplateRecast