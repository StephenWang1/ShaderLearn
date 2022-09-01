local MagicEquipPage = {}

--region 数据
---@type table<LuaEnumMagicEquipSuitType,boolean> 页签显示状态
MagicEquipPage.ServerPageState = nil
--endregion

--region 刷新
---刷新服务器页签状态
---@param tblData equipV2.UpdateGetedType lua table类型消息数据
function MagicEquipPage:RefreshServerPageState(tblData)
    self.ServerPageState = {}
    if tblData == nil or tblData.typed == nil or type(tblData.typed) ~= 'table' or Utility.GetTableCount(tblData.typed) <= 0 then
        return
    end
    for k,v in pairs(tblData.typed) do
        self.ServerPageState[v] = true
    end
end

---数据清理
function MagicEquipPage:ClearParams()
    self.ServerPageState = {}
end
--endregion

--region 查询
---查询套装类型页签显示状态
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@return boolean 显示状态
function MagicEquipPage:CheckSuitTypePageShowState(suitType)
    if suitType == nil then
        return false
    end
    --if self:IsDefaultShowPage(suitType) == true then
    --    return true
    --end
    if self.ServerPageState == nil or type(self.ServerPageState) ~= 'table' or self.ServerPageState[suitType] == nil then
        return false
    end
    return true
end

---是否是默认显示的页签
---@param suitType LuaEnumMagicEquipSuitType 套装类型
---@return boolean 显示状态
function MagicEquipPage:IsDefaultShowPage(suitType)
    if suitType == LuaEnumMagicEquipSuitType.ShengXiao then
        return true
    end
    return false
end
--endregion

---游戏场景退回到登录/选角界面时触发
function MagicEquipPage:OnExitDestroy()
    self:ClearParams()
end
return MagicEquipPage