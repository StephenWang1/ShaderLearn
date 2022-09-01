---@class LuaZhenFaManager:luaobject 阵法管理类
local LuaZhenFaManager = {}

--region 数据
---@return LuaZhenFaInfo
function LuaZhenFaManager:GetZhenFaInfo()
    if self.mZhenFaInfo == nil then
        self.mZhenFaInfo = luaclass.LuaZhenFaInfo:New()
    end
    return self.mZhenFaInfo
end

---@return LuaZhenFaEquipManager
function LuaZhenFaManager:GetZhenFaEquipManager()
    if self.mZhenFaEquipManager == nil then
        self.mZhenFaEquipManager = luaclass.LuaZhenFaEquipManager:New()
    end
    return self.mZhenFaEquipManager
end
--endregion

--region 数据刷新
---刷新阵法信息
---@param tblData zhenfaV2.ResZhenfaInfo 阵法信息数据
function LuaZhenFaManager:OnResZhenfaInfoMessage(tblData)
    self:GetZhenFaInfo():RefreshZhenFaInfo(tblData)
    self:GetZhenFaEquipManager():ZhenFaInfoChange()
end

---刷新所有装备信息
---@param tblData equipV2.ResAllEquip lua table类型消息数据
function LuaZhenFaManager:OnResAllEquipMessage(tblData)
    if type(tblData) ~= 'table' or type(tblData.equipList) ~= 'table' then
        return
    end
    self:GetZhenFaEquipManager():RefreshZhenFaEquipList(tblData.equipList)
end

---背包物品列表刷新装备信息
---@param bagItemInfoList table<bagV2.BagItemInfo>
function LuaZhenFaManager:RefreshAllEquipByBagItemInfoList(bagItemInfoList)
    self:GetZhenFaEquipManager():RefreshZhenFaEquipListByBagItemInfoList(bagItemInfoList)
end

---装备信息变更
---@param tblData equipV2.ResEquipChange lua table类型消息数据
function LuaZhenFaManager:OnResEquipChangeMessage(tblData)
    if type(tblData) ~= 'table' or type(tblData.equipChange) ~= 'table' then
        return
    end
    for k,v in pairs(tblData.equipChange) do
        self:GetZhenFaEquipManager():RefreshZhenFaEquip(v)
    end
end

function LuaZhenFaManager:CallRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ZhenFa))
end
--endregion

--region 查询
---是否显示红点
function LuaZhenFaManager:IsShowZhenFaRedPoint()
    local zhenFaTable = self:GetZhenFaInfo():GetZhenFaTable()
    if zhenFaTable.level >= 15 then
        return false
    end
    if zhenFaTable:GetCostMaterial() == nil then
        return false
    end

    local isEnoughMaterial = true
    local materialList = zhenFaTable:GetCostMaterial().list
    for i = 1, #materialList do
        local costMaterial = zhenFaTable:GetCostMaterial().list[i]
        local costItemId = costMaterial.list[1]
        local costNum = costMaterial.list[2]
        local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(costItemId)
        local ItemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(costItemId)
        local itemCountReplace = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(ItemInfo.linkItemId)
        itemCount = itemCount + itemCountReplace
        isEnoughMaterial = isEnoughMaterial and itemCount >= costNum
    end

    if zhenFaTable:GetCostCurrency() == nil then
        return isEnoughMaterial
    end

    local isEnoughCurrency = true
    local costCurrency = zhenFaTable:GetCostCurrency().list[1]
    local costCurrencyId = costCurrency.list[1]
    local costCurrencyNum = costCurrency.list[2]
    local coinsCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(costCurrencyId)
    isEnoughCurrency = coinsCount >= costCurrencyNum

    return isEnoughMaterial and isEnoughCurrency
end
--endregion

return LuaZhenFaManager