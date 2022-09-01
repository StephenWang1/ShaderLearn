---@class UIOtherRoleArtifactPanel:UIRoleArtifactPanel 其他玩家法宝面板
local UIOtherRoleArtifactPanel = {}

setmetatable(UIOtherRoleArtifactPanel,luaPanelModules.UIRoleArtifactPanel)

---绑定客户端事件
function UIOtherRoleArtifactPanel:BindClientEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        uimanager:ClosePanel(self)
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.OtherPlayerMagicEquipPageOnClick, function(id,commonData)
        if commonData == nil or commonData.pageConfigInfo == nil then
            return
        end
        ---@param LuaEnumMagicEquipSuitType
        local suitType = commonData.pageConfigInfo.type
        if suitType ~= nil then
            self.ChooseType = suitType
            self:RefreshItems(suitType)
        end
    end)
end

--region 重写
---获取显示的页签配置数据
---@return table 需要显示的页签配置数据
function UIOtherRoleArtifactPanel:GetPageParams()
    return LuaGlobalTableDeal:GetOtherPlayerCanShowPage()
end

---获取套装物品列表
---@param equipIndex number 装备位
---@return LuaMagicEquipDataItem 法宝装备信息类
function UIOtherRoleArtifactPanel:GetSuitItems(equipIndex)
    if equipIndex == nil then
        return nil
    end
    return gameMgr:GetOtherPlayerDataMgr():GetMagicEquipItemInfo(equipIndex)
end

---获取页签模板
function UIOtherRoleArtifactPanel:GetPageTemplate()
    return luaComponentTemplates.UIOtherRoleArtifactPanel_SinglePage
end

---获取物品信息刷新模板
function UIOtherRoleArtifactPanel:GetItemTemplate()
    return luaComponentTemplates.UIOtherRoleArtifactPanel_SingleItem
end
--endregion

return UIOtherRoleArtifactPanel