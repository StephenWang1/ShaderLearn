local UIRolePanel_EquipTemplateOtherPlayer = {}
setmetatable(UIRolePanel_EquipTemplateOtherPlayer, luaComponentTemplates.UIRolePanel_EquipTemplate)

---重写获取显示装备信息
---@param equipIndex XLua.Cast.Int32 装备位index
function UIRolePanel_EquipTemplateOtherPlayer:GetEquipInfo(equipIndex)
    if self.customData and self.customData.equipInfo and self.customData.equipInfo[equipIndex] then
        return self.customData.equipInfo[equipIndex]
    end
    return nil
end

---重写额外装备列表
function UIRolePanel_EquipTemplateOtherPlayer:GetExtraEquipList(equipIndex)
    local extraEquipList = {};
    if (self.customData.ExtraEquipList ~= nil) then
        local length = self.customData.ExtraEquipList.Count - 1
        for k = 0, length do
            local v = self.customData.ExtraEquipList[k]
            if (equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LAMP) and v.type == LuaEnumEquiptype.LightComponent) then
                table.insert(extraEquipList, v.itemId);
            elseif (equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE) and v.type == LuaEnumEquiptype.ShengMingJingPo) then
                table.insert(extraEquipList, v.itemId);
            elseif (equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA) and (v.type == LuaEnumEquiptype.Jingongzhiyuan or v.type == LuaEnumEquiptype.Shouhuzhiyuan)) then
                table.insert(extraEquipList, v.itemId);
            elseif (equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE) and v.type == LuaEnumEquiptype.Gem) then
                table.insert(extraEquipList, v.itemId);
            end
        end
    end
    return extraEquipList;
end

---点击装备
function UIRolePanel_EquipTemplateOtherPlayer:OnItemClicked(go)
    local template = self.mGridToTemplate[go]
    if template then
        if luaEventManager.HasCallback(LuaCEvent.Role_EquipGridClicked) then
            luaEventManager.DoCallback(LuaCEvent.Role_EquipGridClicked, template)
        else
            if template.bagItemInfo then
                local curBagItemInfo = ternary(template.itemInfo ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:IsMarryRing(template.itemInfo), self.customData.marryInfo, template.bagItemInfo)
                local curItemInfo = template.itemInfo
                if CS.CSScene.MainPlayerInfo.OtherPlayerInfo == nil then
                    return
                end
                uiStaticParameter.UIItemInfoManager:CreatePanel({
                    bagItemInfo = curBagItemInfo,
                    itemInfo = curItemInfo,
                    career = Utility.EnumToInt(self.customData.avatarInfo.Career),
                    extraEquipIdTable = self:GetExtraEquipList(template.equipIndex), showAssistPanel = true,
                    showMoreAssistData = true,
                    showAction = true,
                    roleId = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo.roleId,
                    itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL
                })
            elseif (template.mExtraEquipDic ~= nil) then
                for k, v in pairs(template.mExtraEquipDic) do
                    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
                    if (isFindItem) then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTable, career = Utility.EnumToInt(self.customData.avatarInfo.Career), itemInfoSource = luaEnumItemInfoSource.UIOTHERROLEPANEL })
                        break ;
                    end
                end
            else
                if template.canEquip and template.equipIndex and template.canEquip.lid then
                    networkRequest.ReqPutOnTheEquip(template.equipIndex, template.canEquip.lid)
                end
            end
        end
    end
end

---刷新帮会名
function UIRolePanel_EquipTemplateOtherPlayer:RefreshUnionName()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.OtherPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo ~= nil and not CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo.unionName) then
        local otherPlayerInfo = self:GetPlayerInfo().OtherPlayerInfo.OtherRoleInfo
        local unionName = otherPlayerInfo.unionName
        local unionPos = otherPlayerInfo.unionPos
        local pos = otherPlayerInfo.isChairman
        if pos == 1 then
            unionPos = 19
        end
        local UnionPosName = uiStaticParameter.PosStringList[unionPos]
        self.roleoffice.text = unionName .. " " .. UnionPosName
    else
        self.roleoffice.text = ""
    end
end

---@return CSMainPlayerInfo 玩家信息
function UIRolePanel_EquipTemplateOtherPlayer:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

return UIRolePanel_EquipTemplateOtherPlayer