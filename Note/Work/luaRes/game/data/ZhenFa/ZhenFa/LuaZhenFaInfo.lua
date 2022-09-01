---@class LuaZhenFaInfo:luaobject 阵法信息类
local LuaZhenFaInfo = {}

--region 数据
---@type boolean 是否是最新的数据
LuaZhenFaInfo.IsNewData = nil
---@private
---@type TABLE.cfg_zhenfa 阵法表数据
LuaZhenFaInfo.ZhenFaTable = nil
---@private
---@type number 阵法当前经验值
LuaZhenFaInfo.ZhenFaExp = nil
---@type TABLE.cfg_items
LuaZhenFaInfo.LuaFaZhenItemInfo = nil
---@type TABLE.CFG_ITEMS
LuaZhenFaInfo.CSFaZhenItemInfo = nil
--endregion

--region 数据刷新
---刷新阵法数据
---@param tblData zhenfaV2.ResZhenfaInfo 阵法信息数据
function LuaZhenFaInfo:RefreshZhenFaInfo(tblData)
    if type(tblData) ~= 'table' or (tblData.zhenfaInfo == nil and tblData.zhenfa == nil) then
        self.IsNewData = false
        return
    end
    ---@type zhenfaV2.ZhenfaInfo
    local serverZhenFaInfo = tblData.zhenfaInfo
    if serverZhenFaInfo == nil then
        serverZhenFaInfo = tblData.zhenfa
    end
    local zhenFaTblId = serverZhenFaInfo.id
    self.ZhenFaTable = clientTableManager.cfg_zhenfaManager:TryGetValue(zhenFaTblId)
    self.ZhenFaExp = serverZhenFaInfo.exp
    self.IsNewData = true
    self.LuaFaZhenItemInfo = nil
    self.CSFaZhenItemInfo = nil
    if self.ZhenFaTable ~= nil then
        local itemId = self.ZhenFaTable:GetItemId()
        if type(itemId) == 'number' then
            self.LuaFaZhenItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
            local csFaZhenItemInfoIsFind,csFaZhenItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
            self.CSFaZhenItemInfo = csFaZhenItemInfo
        end
    end
end
--endregion

--region 获取
---获取当前阵法表
---@return TABLE.cfg_zhenfa
function LuaZhenFaInfo:GetZhenFaTable()
    if self.ZhenFaTable == nil then
        self.ZhenFaTable = clientTableManager.cfg_zhenfaManager:TryGetValue(1)
    end
    return self.ZhenFaTable
end

---获取阵法等级
---@return number
function LuaZhenFaInfo:GetZhenFaLevel()
    local zhenFaTbl = self:GetZhenFaTable()
    if zhenFaTbl ~= nil then
        return zhenFaTbl:GetLevel()
    end
    return 0
end

---获取下一个阵法表
---@return TABLE.cfg_zhenfa
function LuaZhenFaInfo:GetNextZhenFaTable()
    local nextZhenFaTable
    nextZhenFaTable = clientTableManager.cfg_zhenfaManager:TryGetValue(self:GetZhenFaTable().id + 1)
    return nextZhenFaTable
end

---获取阵法当前经验值
---@return number
function LuaZhenFaInfo:GetZhenFaExp()
    if self.ZhenFaExp == nil then
        self.ZhenFaExp = 0
    end
    return self.ZhenFaExp
end

---获取以解锁的装备位列表
---@return table<LuaEnumPlayerEquipIndex>
function LuaZhenFaInfo:GetUnLockedEquipIndex()
    if self:GetZhenFaTable() == nil then
        return
    end
    return clientTableManager.cfg_zhenfaManager:GetUnLockedEquipIndex(self:GetZhenFaTable():GetId())
end


---获取法阵特效名字
---@return table<FaZhenEffectInfo>
function LuaZhenFaInfo:GetFaZhenEffectName()
    local fazhenTbl = self:GetZhenFaTable()
    if fazhenTbl == nil then
        return
    end
    return clientTableManager.cfg_zhenfaManager:GetFaZhenEffectInfoList(fazhenTbl:GetId())
end

---获取法阵道具信息
---@return TABLE.CFG_ITEMS
function LuaZhenFaInfo:GetFaZhenItemInfo()
    return self.CSFaZhenItemInfo
end
--endregion

return LuaZhenFaInfo