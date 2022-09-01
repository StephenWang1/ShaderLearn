---@class UIItemInfoPanel_AssistPart_Collection:UIItemInfoPanel_AssistPart
local UIItemInfoPanel_AssistPart_Collection = {}

setmetatable(UIItemInfoPanel_AssistPart_Collection, luaComponentTemplates.UIItemInfoPanel_AssistPart)

function UIItemInfoPanel_AssistPart_Collection:GetOwnerCollectionInfo()
    if self.commonData == nil then
        return
    end
    local roleId = self.commonData.roleId
    if roleId == nil then
        if self.commonData ~= nil and self.commonData.commonData ~= nil then
            roleId = self.commonData.commonData.roleId
        end
    end
    if roleId == nil or roleId == CS.CSScene.MainPlayerInfo.ID then
        if gameMgr:GetPlayerDataMgr() ~= nil then
            return gameMgr:GetPlayerDataMgr():GetCollectionInfo()
        else
            return nil
        end
    else
        if gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo ~= nil and gameMgr:GetOtherPlayerDataMgr().RoleToOtherInfo.roleId == roleId then
            return gameMgr:GetOtherPlayerDataMgr():GetCollectionInfo()
        end
        return nil
    end
end

---刷新中央区域
---@param commonData UIItemTipInfoCommonData 背包物品信息
function UIItemInfoPanel_AssistPart_Collection:RefreshCenterArea(commonData)
    if self.commonData == nil or self.commonData.bagItemInfo == nil then
        return
    end
    local collectionInfo = self:GetOwnerCollectionInfo()
    ---@type TABLE.CFG_ITEMS
    local itemInfoExist, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.commonData.bagItemInfo.itemId)
    self.commonData.itemInfo = itemInfo
    if self.commonData ~= nil and itemInfo ~= nil and itemInfo.type == luaEnumItemType.Collection then
        ---@type UIItemInfoPanel_Info_BaseAttribute_Collection
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(),
                luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute_Collection, self:GetCenterContentTable_UITable())
        local isMainPlayer = self.commonData ~= nil and self.commonData.roleId == CS.CSScene.MainPlayerInfo.ID
        baseAttribute:RefreshWithInfo(self.commonData.bagItemInfo, itemInfo, collectionInfo, isMainPlayer)
        if collectionInfo ~= nil then
            local linkEffectList = clientTableManager.cfg_linkeffectManager:GetLinkEffectListByCollectionID(itemInfo.id)
            local activeLinkEffectList = collectionInfo:GetLinkEffectIDList()
            if linkEffectList ~= nil and activeLinkEffectList ~= nil and collectionInfo:GetCollectionDic()[self.commonData.bagItemInfo.lid] ~= nil then
                local isFirst = true
                for i = 1, #linkEffectList do
                    local linkEffectTbl = linkEffectList[i]
                    local isLinkEffectActived = false
                    for j = 1, #activeLinkEffectList do
                        if linkEffectTbl:GetId() == activeLinkEffectList[j] then
                            isLinkEffectActived = true
                            break
                        end
                    end
                    if isLinkEffectActived then
                        if isFirst then
                            isFirst = false
                            ---@type UIItemInfoPanel_Info_PureSingleLine
                            local titleSingleLineText = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(),
                                    luaComponentTemplates.UIItemInfoPanel_Info_PureSingleLine, self:GetCenterContentTable_UITable())
                            titleSingleLineText:RefreshText("[73ddf7]连锁属性")
                        end
                        ---@type UIItemInfoPanel_Info_PureSingleLine
                        local singleLineText = self:CreateTemplateUnderArea(self:GetInfoTemplate_SingleLine_GO(),
                                luaComponentTemplates.UIItemInfoPanel_Info_PureSingleLine, self:GetCenterContentTable_UITable())
                        singleLineText:RefreshText("  " .. linkEffectTbl:GetDescription())
                    end
                end
            end
        end
    end
end

return UIItemInfoPanel_AssistPart_Collection