---@type Utility
local Utility = Utility

--region 查询

---是否是宝物
---@param itemId number 物品id
---@return boolean 是否是宝物
function Utility:IsGem(itemId)
    if itemId == nil then
        return false
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil then
        return itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_chiyandeng or itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_hunyu or
                itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_baoshishoutao or itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_yuanlingmibao
    end
    return false
end

---是否是宝物附加物
---@param itemId number 物品id
---@return boolean 是否是宝物附加物
function Utility:IsGemAddition(itemId)
    if itemId == nil then
        return false
    end
    local furnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(itemId)
    --local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if furnaceTbl ~= nil then
        return true;
    end
    return false
end

---是否是宝物装备位
---@param equipIndex number
---@return boolean
function Utility:IsGemEquipIndex(equipIndex)
    if type(equipIndex) ~= 'number' then
        return false
    end
    return equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_LAMP) or
            equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE) or
            equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE) or
            equipIndex == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA)
end
--endregion

--region 对比
---宝物装备对比
---@param leftBagItemInfo bagV2.BagItemInfo
---@param rightBagItemInfo bagV2.BagItemInfo
---@return number 1(left > right) 0(left == right) -1(left < right) -2(出错)
function Utility:CompareGem(leftBagItemInfo, rightBagItemInfo)
    if leftBagItemInfo ~= nil and rightBagItemInfo ~= nil and self:IsGem(leftBagItemInfo.itemId) and clientTableManager.cfg_itemsManager:IsSameItem(leftBagItemInfo.itemId, rightBagItemInfo.itemId) then
        local leftItemTbl = leftBagItemInfo.ItemTABLE
        local rightItemTbl = rightBagItemInfo.ItemTABLE
        if leftItemTbl == nil then
            leftItemTbl = Utility.GetItemTblByBagItemInfo(leftBagItemInfo)
        end
        if rightItemTbl == nil then
            rightItemTbl = Utility.GetItemTblByBagItemInfo(rightBagItemInfo)
        end
        if leftItemTbl == nil or rightItemTbl == nil then
            return -2
        end
        if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_chiyandeng then
            return Utility.NumberCompare(leftItemTbl:GetCriticalDamage(), rightItemTbl:GetCriticalDamage())
        end
        if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_hunyu then
            local compareId = Utility.NumberCompare(leftItemTbl:GetPhyDefenceMax(), rightItemTbl:GetPhyDefenceMax())
            if compareId ~= 0 then
                compareId = Utility.NumberCompare(leftItemTbl:GetMagicDefenceMax(), rightItemTbl:GetMagicDefenceMax())
            end
            return compareId
        end
        if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_baoshishoutao then
            local compareId = Utility.NumberCompare(leftItemTbl:GetPhyAttackMin(), rightItemTbl:GetPhyAttackMin())
            if compareId ~= 0 then
                compareId = Utility.NumberCompare(leftItemTbl:GetMagicAttackMin(), rightItemTbl:GetMagicAttackMin())
            end
        end
        if leftItemTbl:GetSubType() == LuaEnumEquipSubType.Equip_yuanlingmibao then
            return Utility.NumberCompare(leftItemTbl:GetHpPercentage(), rightItemTbl:GetHpPercentage())
        end
    end
end
--endregion

--region 获取
---获取宝物附加物的buff表
---@param itemId number
---@return table<TABLE.cfg_buff>
function Utility:GetGemAdditionBufferList(itemId)
    if Utility:IsGemAddition(itemId) == false then
        return
    end
    return clientTableManager.cfg_itemsManager:GetBufferTblListByItemId(itemId)
end

---获取宝物表
---@param itemId number
---@return TABLE.cfg_godfurnace
function Utility:GetGemTbl(itemId)
    return clientTableManager.cfg_godfurnaceManager:TryGetValue(itemId)
end

---获取下一级的宝物道具id
---@param itemId number
---@return number
function Utility:GetNextGemItemId(itemId)
    local gemTbl = self:GetGemTbl(itemId)
    if gemTbl == nil then
        return 0
    end
    return gemTbl:GetNewid()
end

---获取宝物等级
---@param itemId number
---@return number
function Utility:GetGemLevel(itemId)
    if type(itemId) ~= 'number' then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil then
        return
    end
    return itemTbl:GetItemLevel()
end

---获取宝物附加物的buff描述内容
---@param itemId number
---@return string,string 标题，描述内容
function Utility:GetGemAdditionBufferDes(itemId)
    if Utility:IsGemAddition(itemId) == false then
        return
    end
    local itemTypeName = LuaGlobalTableDeal:GetGemTypeName(itemId)
    if CS.StaticUtility.IsNullOrEmpty(itemTypeName) then
        return
    end
    local gemTbl = self:GetGemTbl(itemId)
    if gemTbl == nil then
        return
    end
    local buffTblList = self:GetGemAdditionBufferList(itemId)
    if type(buffTblList) ~= 'table' or Utility.GetLuaTableCount(buffTblList) <= 0 then
        return
    end
    local titleDes = itemTypeName .. tostring(gemTbl:GetLv()) .. "级激活"
    local des = ""
    local buffCount = Utility.GetLuaTableCount(buffTblList)
    for k, v in pairs(buffTblList) do
        ---@type TABLE.cfg_buff
        local buffTbl = v
        if k == buffCount then
            des = des .. buffTbl:GetTipsTxt()
        else
            des = des .. buffTbl:GetTipsTxt() .. "\n"
        end
    end
    return titleDes, des
end

---获取宝物镶嵌物的装备位
---@param itemId number 宝物镶嵌物itemId
---@return number 装备位
function Utility:GetGemInlayItemEquipIndex(itemId)
    if self:IsGemAddition(itemId) then
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
        if itemTbl then
            if itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_chiyandengxin then
                return Utility.EnumToInt(CS.EEquipIndex.POS_LAMP)
            elseif itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_shengmingjingpo then
                return Utility.EnumToInt(CS.EEquipIndex.POS_SOULJADE)
            elseif itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_gem then
                return Utility.EnumToInt(CS.EEquipIndex.POS_GEMGLOVE)
            elseif itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_jingongzhiyuan or itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_shouhuzhiyuan then
                return Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA)
            end
        end
    end
end

---@public 获取当前级宝物特殊属性显示信息
---@return number,boolean 宝物ID, 是否激活
function Utility:GetCurSpecialFurnaceState(curFurnaceId, type)
    local beginId;
    local furnaceIds;
    if (type == LuaEnumFurnaceOpenType.ChyanLamp) then
        furnaceIds = LuaGlobalTableDeal:GetLightComponentIds();
        beginId = LuaEnumCoinType.LampFragment;
    elseif (type == LuaEnumFurnaceOpenType.SoulBead) then
        furnaceIds = LuaGlobalTableDeal:GetSoulJadeComponentIds();
        beginId = LuaEnumCoinType.EssenceOfLifeFragment;
    elseif (type == LuaEnumFurnaceOpenType.Gem) then
        furnaceIds = LuaGlobalTableDeal:GetGemComponentIds();
        beginId = LuaEnumCoinType.GemFragment;
    end
    ---@type TABLE.cfg_godfurnace
    local curFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(curFurnaceId);
    if (curFurnaceTbl ~= nil) then
        if (curFurnaceId ~= beginId) then
            if (furnaceIds ~= nil and curFurnaceId ~= nil) then
                local tempFurnaceId;
                for k, v in pairs(furnaceIds) do
                    ---@type TABLE.cfg_godfurnace
                    local furnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(v);
                    if (curFurnaceTbl ~= nil and furnaceTbl ~= nil) then
                        if (curFurnaceTbl:GetLv() <= furnaceTbl:GetLv()) then
                            if (k == 1) then
                                ---@type TABLE.cfg_godfurnace
                                local beginFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(beginId);
                                if (beginFurnaceTbl ~= nil) then
                                    return beginFurnaceTbl:GetNewid(), true;
                                end
                            elseif (tempFurnaceId ~= nil) then
                                ---@type TABLE.cfg_godfurnace
                                local tempFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(tempFurnaceId);
                                if (tempFurnaceTbl ~= nil) then
                                    return tempFurnaceTbl:GetNewid(), true;
                                end
                            end
                        end
                    end
                    tempFurnaceId = v;
                end
            end
        end
        return curFurnaceTbl:GetNewid(), false;
    end
    return 0, false;
end

---@public 获取下一级宝物特殊属性显示信息
---@return number,boolean 宝物ID, 是否激活
function Utility:GetNextSpecialFurnaceState(curFurnaceId, type)
    local beginId;
    local furnaceIds;
    if (type == LuaEnumFurnaceOpenType.ChyanLamp) then
        furnaceIds = LuaGlobalTableDeal:GetLightComponentIds();
        beginId = LuaEnumCoinType.LampFragment;
    elseif (type == LuaEnumFurnaceOpenType.SoulBead) then
        furnaceIds = LuaGlobalTableDeal:GetSoulJadeComponentIds();
        beginId = LuaEnumCoinType.EssenceOfLifeFragment;
    elseif (type == LuaEnumFurnaceOpenType.Gem) then
        furnaceIds = LuaGlobalTableDeal:GetGemComponentIds();
        beginId = LuaEnumCoinType.GemFragment;
    end
    ---@type TABLE.cfg_godfurnace
    local curFurnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(curFurnaceId);
    if (curFurnaceTbl ~= nil) then
        if (curFurnaceId ~= beginId) then
            if (furnaceIds ~= nil and curFurnaceId ~= nil) then
                for k, v in pairs(furnaceIds) do
                    ---@type TABLE.cfg_godfurnace
                    local furnaceTbl = clientTableManager.cfg_godfurnaceManager:TryGetValue(v);
                    if (curFurnaceTbl ~= nil and furnaceTbl ~= nil) then
                        if (curFurnaceTbl:GetLv() <= furnaceTbl:GetLv()) then
                            return furnaceTbl:GetNewid(), false;
                        end
                    end
                end
            end
        end
        return curFurnaceTbl:GetNewid(), false;
    end
    return 0, false;
end

--endregion