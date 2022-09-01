---藏品tips主界面
---@class UIItemInfoPanel_MainPart_Collection:UIItemInfoPanel_MainPart
local UIItemInfoPanel_MainPart_Collection = {}

setmetatable(UIItemInfoPanel_MainPart_Collection, luaComponentTemplates.UIItemInfoPanel_MainPart)

function UIItemInfoPanel_MainPart_Collection:GetOwnerCollectionInfo()
    if self.commonData == nil or self.commonData.roleId == nil or self.commonData.roleId == 0 then
        return nil
    end
    local roleId = self.commonData.roleId
    if roleId == CS.CSScene.MainPlayerInfo.ID then
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

function UIItemInfoPanel_MainPart_Collection:RefreshCenterArea()
    local collectionInfo = self:GetOwnerCollectionInfo()
    if self.commonData ~= nil and self.commonData.itemInfo ~= nil and self.commonData.itemInfo.type == luaEnumItemType.Collection then
        ---@type UIItemInfoPanel_Info_BaseAttribute_Collection
        local baseAttribute = self:CreateTemplateUnderArea(self:GetInfoTemplate_BaseAttribute_GO(),
                luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute_Collection, self:GetCenterContentTable_UITable())
        local isMainPlayer = self.commonData ~= nil and self.commonData.roleId == CS.CSScene.MainPlayerInfo.ID
        baseAttribute:RefreshWithInfo(self.commonData.bagItemInfo, self.commonData.itemInfo, collectionInfo, isMainPlayer)
        if collectionInfo ~= nil then
            local linkEffectList = clientTableManager.cfg_linkeffectManager:GetLinkEffectListByCollectionID(self.commonData.itemInfo.id)
            local activeLinkEffectList = collectionInfo:GetLinkEffectIDList()
            if linkEffectList ~= nil and activeLinkEffectList ~= nil and self.commonData.bagItemInfo ~= nil then
                if collectionInfo:GetCollectionDic()[self.commonData.bagItemInfo.lid] ~= nil then
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
end

return UIItemInfoPanel_MainPart_Collection