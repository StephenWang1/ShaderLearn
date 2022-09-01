local ItemInfoPanelBase = {}

--region 数据
---@type ItemDataInfo 主面板物品数据
ItemInfoPanelBase.MainItemDataInfo = nil
---@type table<ItemDataInfo> 副面板物品数据表
ItemInfoPanelBase.AssistItemDataInfoTable = {}
---@type table<ItemDataInfo> 当前显示的副面板物品数据
ItemInfoPanelBase.ShowAssistItemDataInfoTable = {}
---@type LuaEnumItemInfoPanelPageType 当前页签选择的下标
ItemInfoPanelBase.ChooseIndex = nil
--endregion

--region 数据刷新
---刷新物品信息面板基础数据（当前显示的数据和需要显示的数据）
function ItemInfoPanelBase:RefreshItemDataInfo(mainItem, assistItemTable)

end

---刷新物品信息面板显示数据
function ItemInfoPanelBase:RefreshShowItemDataInfo()

end
--endregion

--region 数据清理
---清理数据
function ItemInfoPanelBase:ClearData()
    self.MainItemDataInfo = nil
    self.AssistItemDataInfoTable = {}
    self.ShowAssistItemDataInfoTable = {}
end

---游戏场景退回到登录/选角界面时触发
function ItemInfoPanelBase:OnExitDestroy()
    self:ClearData()
end
--endregion

--region 神力套装(暂时放在这里，之后放到ItemDataInfo)
--region 查询
--endregion

--region 获取
---获取神力套装装备类型描述内容
---@return string 描述内容
function ItemInfoPanelBase:GetDivineSuitEquipTypeDes(itemId)
    local divineSuitDataInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentListByItemId(itemId)
    if divineSuitDataInfo ~= nil then

    end
end
--endregion
--endregion
return ItemInfoPanelBase