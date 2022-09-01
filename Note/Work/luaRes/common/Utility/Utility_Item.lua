---@type Utility
local Utility = Utility

--region Material

---获得到指定道具材料的数据
---@return LuaMaterialData
function Utility.GetMaterialData(itemId)
    if (uiStaticParameter.AllItemMaterialData == nil) then
        uiStaticParameter.AllItemMaterialData = {}
    end
    if (uiStaticParameter.AllItemMaterialData[itemId] == nil) then
        uiStaticParameter.AllItemMaterialData[itemId] = luaclass.LuaMaterialData:New()
        ---@type LuaMaterialData
        local temp = uiStaticParameter.AllItemMaterialData[itemId];
        temp:GenerateData(itemId)
    end
    return uiStaticParameter.AllItemMaterialData[itemId]
end

---当指定材料发送数量变动的时候,进行调用,会遍历当前所有的材料数据,并判定变动的材料是否相关,然后进行重置
---@return LuaMaterialData
function Utility.UpdateMaterialData(itemId)
    if (uiStaticParameter.AllItemMaterialData == nil) then
        uiStaticParameter.AllItemMaterialData = {}
    end
    ---@param MaterialData LuaMaterialData
    for i, MaterialData in pairs(uiStaticParameter.AllItemMaterialData) do
        if (MaterialData:IsExitMaterial(itemId)) then
            MaterialData:Reset()
        end
    end
end

--endregion

---获取物品类型对应的字符串
---@param type  LuaEnumItemType
---@param subType number
---@return string
function Utility.GetItemType(type, subType)
    if type == luaEnumItemType.Drug then
        return "药品"
    elseif type == luaEnumItemType.Assist then
        return "道具"
    elseif type == luaEnumItemType.Equip then
        return "装备"
    elseif type == luaEnumItemType.Skill then
        if subType == 1 then
            return "心法"
        end
        return "技能书"
    elseif type == luaEnumItemType.Material then
        return "材料"
    elseif type == luaEnumItemType.Coin then
        return "资源"
    elseif type == luaEnumItemType.Element then
        return "元素"
    elseif type == luaEnumItemType.TreasureBox then
        return "宝箱"
    elseif type == luaEnumItemType.ServantFragment then
        return "精魄"
    elseif type == luaEnumItemType.Signet then
        return "印记"
    elseif type == luaEnumItemType.HunJi then
        return "魂继"
    elseif type == luaEnumItemType.Collection then
        return "收藏品"
    end
    return "其他"
end

--region 道具使用次数
---获取道具使用次数
---@param itemId number 道具id
---@return boolean,number 是否有道具使用信息/道具使用次数
function Utility.GetItemUseCount(itemId)
    if type(itemId) ~= 'number' then
        return false,0
    end
    local haveItemUseCount,itemUseCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseCount(itemId)
    return haveItemUseCount,itemUseCount
end

---道具使用次数是否超过使用上限
---@param itemId number 道具id
---@return boolean
function Utility.ItemUseCountOverLimit(itemId)
    local haveItemUseCount,itemUseCount = Utility.GetItemUseCount(itemId)
    if haveItemUseCount == false then
        return false
    end

    ---封号（封号天赋丹）
    local overLimit = Utility.PrefixAttributeUpItemUseLimit(itemId,itemUseCount)
    if overLimit == true then
        return overLimit
    end

    ---通用使用次数上限
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return false
    end
    local itemLimit = itemTbl:GetUseLimit()
    if itemLimit <= 0 then
        return false
    end
    return itemUseCount >= itemLimit
end

---封号属性提升道具使用限制
---@param itemId number 道具id
---@param itemUseCount number 当前使用次数
function Utility.PrefixAttributeUpItemUseLimit(itemId,itemUseCount)
    if type(itemUseCount) ~= 'number' then
        return false
    end
    if itemId == 5000765 then
        local prefixId = CS.CSScene.MainPlayerInfo.SealMarkId
        if type(prefixId) == 'number' then
            if prefixId <= 0 then
                return true
            else
                local prefix_TitleTbl = clientTableManager.cfg_prefix_titleManager:TryGetValue(prefixId)
                local maxUseCount = prefix_TitleTbl:GetAttributeItemShow()
                return itemUseCount >= maxUseCount
            end
        end
    end
    return false
end
--endregion