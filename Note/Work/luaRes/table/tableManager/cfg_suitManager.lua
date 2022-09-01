---@class cfg_suitManager:TableManager
local cfg_suitManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_suit
function cfg_suitManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_suit> 遍历方法
function cfg_suitManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_suitManager:PostProcess()
end

--region 套装（套装类型=》套装等级）
---@type table<LuaEnumSuitType,TABLE.cfg_suit> 套装字典
cfg_suitManager.SuitTypeDic = nil

--region 初始化
function cfg_suitManager:InitSuitTypeDic()
    if type(self.SuitTypeDic) == 'table' then
        return
    end
    self.SuitTypeDic = {}
    self:ForPair(function(id, tbl)
        ---@type TABLE.cfg_suit
        local suitTbl = tbl
        if self.SuitTypeDic[suitTbl:GetSuitId()] == nil then
            self.SuitTypeDic[suitTbl:GetSuitId()] = {}
        end
        table.insert(self.SuitTypeDic[suitTbl:GetSuitId()], suitTbl)
    end)
    if type(self.SuitTypeDic) ~= 'table' then
        return
    end
    for k, v in pairs(self.SuitTypeDic) do
        if type(v) == 'table' then
            self:SortSuitListByLevel(v)
        end
    end
end

---指定类型的套装列表通过等级进行排序
---@param suitList table<TABLE.cfg_suit>
function cfg_suitManager:SortSuitListByLevel(suitList)
    if type(suitList) ~= 'table' then
        return
    end
    table.sort(suitList, function(firstSuitTbl, secondSuitTbl)
        ---@type TABLE.cfg_suit
        local curFirstSuitTbl = firstSuitTbl
        ---@type TABLE.cfg_suit
        local curSecondSuitTbl = secondSuitTbl
        return curFirstSuitTbl:GetSuitLv() < curSecondSuitTbl:GetSuitLv()
    end)
end
--endregion

--region 获取
---通过套装类型获取套装列表
---@param suitType LuaEnumSuitType
---@return table<TABLE.cfg_suit>
function cfg_suitManager:GetSuitTblListBySuitType(suitType)
    if type(suitType) ~= 'number' then
        return
    end
    if type(self.SuitTypeDic) ~= 'table' then
        self:InitSuitTypeDic()
    end
    return self.SuitTypeDic[suitType]
end

---通过套装类型和套装等级获取套装表
---@param suitType LuaEnumSuitType
---@param suitLevel number
---@return TABLE.cfg_suit
function cfg_suitManager:GetSuitTblBySuitTypeAndLevel(suitType, suitLevel)
    if type(suitType) ~= 'number' or type(suitLevel) ~= 'number' then
        return
    end
    local suitList = self:GetSuitTblListBySuitType(suitType)
    if type(suitList) == 'table' then
        for k, v in pairs(suitList) do
            ---@type TABLE.cfg_suit
            local tbl = v
            if tbl:GetSuitLv() == suitLevel then
                return tbl
            end
        end
    end
end

---通过套装类型获取最低等级的套装表
---@return TABLE.cfg_suit
function cfg_suitManager:GetMinSuitTblBySuitType(suitType)
    if type(suitType) ~= 'number' then
        return
    end
    local suitList = self:GetSuitTblListBySuitType(suitType)
    if type(suitList) ~= 'table' or Utility.GetTableCount(suitList) <= 0 then
        return
    end
    return suitList[1]
end

---通过套装类型获取最低等级的套装表
---@param suitType LuaEnumSuitType
---@param suitLv number
---@return TABLE.cfg_suit
function cfg_suitManager:GetSuitTblBySuitTypeAndSuitLv(suitType, suitLv)

end

---获取套装包含等级的名字
---@param suitId number
---@return string
function cfg_suitManager:GetSuitName(suitId)
    local suitTbl = self:TryGetValue(suitId)
    if suitTbl == nil then
        return
    end
    return suitTbl:GetName()
end

---获取套装buff标签名
---@param suitId number
---@return string
function cfg_suitManager:GetSuitBuffTitleName(suitId)
    local suitTbl = self:TryGetValue(suitId)
    if suitTbl == nil then
        return
    end
    return suitTbl:GetAttributeName()
end

---获取buff描述内容
---@param suitId number
---@return string
function cfg_suitManager:GetBuffDes(suitId)
    local suitTbl = self:TryGetValue(suitId)
    if suitTbl == nil then
        return
    end
    local buffList = suitTbl:GetAttributeParam()
    if buffList == nil or buffList.list == nil or Utility.GetLuaTableCount(buffList.list) <= 0 then
        return
    end
    local des = ""
    local buffListCount = Utility.GetLuaTableCount(buffList.list)
    for k, v in pairs(buffList.list) do
        local buffId = v
        local buffDes = clientTableManager.cfg_buffManager:GetBuffDes(buffId)
        if CS.StaticUtility.IsNullOrEmpty(buffDes) == false then
            if k >= buffListCount then
                des = des .. buffDes
            else
                des = des .. buffDes .. "\n"
            end
        end
    end
    return des
end

---通过itemId获取套装表
---@param itemId number
---@return TABLE.cfg_suit
function cfg_suitManager:GetSuitTblByItemId(itemId)
    if itemId == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil or itemTbl:GetSuitBelong() == nil then
        return
    end
    local suitTbl = self:GetMinSuitTblBySuitType(itemTbl:GetSuitBelong())
    return suitTbl
end

---通过itemId获取套装类型
---@param itemId number
---@return LuaEnumSuitType
function cfg_suitManager:GetSuitTypeByItemId(itemId)
    local suitTbl = self:GetSuitTblByItemId(itemId)
    if suitTbl == nil then
        return
    end
    return suitTbl:GetSuitId()
end

---通过itemId获取套装名
---@param itemId number
---@return string
function cfg_suitManager:GetSuitNameByItemId(itemId)
    local suitTbl = self:GetSuitTblByItemId(itemId)
    if suitTbl == nil then
        return
    end
    return self:GetSuitName(suitTbl:GetId())
end

---通过ItemId获取套装buff标题名
---@param itemId number
---@return string
function cfg_suitManager:GetSuitBuffTitleNameByItemId(itemId)
    local suitTbl = self:GetSuitTblByItemId(itemId)
    if suitTbl == nil then
        return ""
    end
    return self:GetSuitBuffTitleName(suitTbl:GetId())
end

---通过itemId获取buff描述内容
function cfg_suitManager:GetSuitBuffDesByItemId(itemId)
    if itemId == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl == nil or itemTbl:GetSuitBelong() == nil then
        return
    end
    local suitTbl = self:GetMinSuitTblBySuitType(itemTbl:GetSuitBelong())
    if suitTbl == nil then
        return
    end
    return self:GetBuffDes(suitTbl:GetId())
end

---@class SuitPartsConfigParams 套装组件配置参数
---@field itemSubType number
---@field itemType number
---@field normalItemId number 默认的itemId

---获取套装组件配置
---@param suitType LuaEnumSuitType
---@return table<SuitPartsConfigParams>
function cfg_suitManager:GetSuitPartsConfigBySuitType(suitType)
    local suitTbl = self:GetMinSuitTblBySuitType(suitType)
    if type(suitTbl) ~= 'table' then
        return
    end
    return self:GetSuitPartsConfigBySuitId(suitTbl:GetId())
end

---通过套装等级和套装类型获取套装组件配置
---@param suitType LuaEnumSuitType
---@param suitLv number
---@return table<SuitPartsConfigParams>
function cfg_suitManager:GetSuitPartsConfigBySuitTypeAndLevel(suitType, suitLv)
    local suitTbl = self:GetSuitTblBySuitTypeAndLevel(suitType, suitLv)
    if type(suitTbl) ~= 'table' then
        return
    end
    return self:GetSuitPartsConfigBySuitId(suitTbl:GetId())
end

---获取套装组件配置
---@param suitId number
---@return table<SuitPartsConfigParams>
function cfg_suitManager:GetSuitPartsConfigBySuitId(suitId)
    if suitId == nil then
        return
    end
    local suitTbl = self:TryGetValue(suitId)
    if suitTbl == nil or suitTbl:GetBelongSuit() == nil or suitTbl:GetBelongSuit().list == nil or type(suitTbl:GetBelongSuit().list) ~= 'table' then
        return
    end
    local suitPartsConfigTable = suitTbl:GetBelongSuit().list
    local suitPartsConfigParamsTable = {}
    for k, v in pairs(suitPartsConfigTable) do
        local params = v.list
        if type(params) == 'table' and Utility.GetLuaTableCount(params) > 1 then
            ---@type SuitPartsConfigParams
            local configParams = {}
            configParams.itemType = params[1]
            configParams.itemSubType = params[2]
            configParams.normalItemId = params[3]
            table.insert(suitPartsConfigParamsTable, configParams)
        end
    end
    return suitPartsConfigParamsTable
end

---检测道具是否是套装组件
---@param suitId number
---@param itemId number
---@return boolean
function cfg_suitManager:CheckItemIsSuitPart(suitId, itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil then
        return false
    end
    local suitPartsConfigParamsList = self:GetSuitPartsConfigBySuitId(suitId)
    if type(suitPartsConfigParamsList) ~= 'table' or Utility.GetTableCount(suitPartsConfigParamsList) <= 0 then
        return false
    end
    for k, v in pairs(suitPartsConfigParamsList) do
        ---@type SuitPartsConfigParams
        local suitPartConfigParams = v
        if itemInfo:GetType() == suitPartConfigParams.itemType and itemInfo:GetSubType() == suitPartConfigParams.itemSubType then
            return true
        end
    end
    return false
end

---检测道具列是否都是套装组件
---@param suitId number
---@param itemTblList table<TABLE.cfg_items>
---@return boolean
function cfg_suitManager:CheckItemsIsSuitPart(suitId, itemTblList)
    local suitPartsConfigParamsList = self:GetSuitPartsConfigBySuitId(suitId)
    if type(suitPartsConfigParamsList) ~= 'table' or Utility.GetTableCount(suitPartsConfigParamsList) <= 0 then
        return false
    end
    if type(itemTblList) ~= 'table' or Utility.GetTableCount(itemTblList) <= 0 then
        return false
    end
    for k, v in pairs(suitPartsConfigParamsList) do
        ---@type SuitPartsConfigParams
        local suitPartConfigParams = v
        local itemListHaveSuitPart = self:CheckItemListHaveTypeAndSubtype(itemTblList, suitPartConfigParams.itemType, suitPartConfigParams.itemSubType)
        if itemListHaveSuitPart == false then
            return false
        end
    end
    return true
end

---检测道具列表是否有指定的类型和子类型的道具
---@param itemTblList table<TABLE.cfg_items>
---@param type number
---@param subType number
---@return boolean
function cfg_suitManager:CheckItemListHaveTypeAndSubtype(itemTblList, itemType, itemSubType)
    if type(itemTblList) ~= 'table' or Utility.GetLuaTableCount(itemTblList) <= 0 or type(itemType) ~= 'number' or type(itemSubType) ~= 'number' then
        return false
    end
    for k, v in pairs(itemTblList) do
        ---@type TABLE.cfg_items
        local itemTbl = v
        if itemTbl:GetType() == itemType and itemTbl:GetSubType() == itemSubType then
            return true
        end
    end
    return false
end

---获取套装部件等级
---@param itemId number
---@return number
function cfg_suitManager:GetSuitPartLv(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil then
        return 0
    end
    return itemInfo:GetItemLevel()
end

---通过道具列表获取套装等级
---@param itemTblList table<TABLE.cfg_items>
---@return number
function cfg_suitManager:GetSuitLvByItemTblList(itemTblList)
    if type(itemTblList) ~= 'table' or Utility.GetLuaTableCount(itemTblList) <= 0 then
        return 0
    end
    local minLv = 99
    for k, v in pairs(itemTblList) do
        ---@type TABLE.cfg_items
        local itemTbl = v
        local itemLv = self:GetSuitPartLv(itemTbl:GetId())
        if itemLv > 0 and itemLv < minLv then
            minLv = itemLv
        end
    end
    return minLv
end

---获取超过指定等级的部件数量
---@param itemTblList table<TABLE.cfg_items>
---@param itemLv number
---@return number
function cfg_suitManager:GetExceedLvPartNum(itemTblList, itemLv)
    if type(itemTblList) ~= 'table' or Utility.GetLuaTableCount(itemTblList) <= 0 or type(itemLv) ~= 'number' then
        return 0
    end
    local partNum = 0
    for k, v in pairs(itemTblList) do
        ---@type TABLE.cfg_items
        local itemInfo = v
        if itemInfo:GetItemLevel() >= itemLv then
            partNum = partNum + 1
        end
    end
    return partNum
end

---@class CompleteSuitParams 集齐的套装参数
---@field suitTbl TABLE.cfg_suit 套装表
---@field completeSuit boolean 是否集齐套装
---@field completeSuitItemNum number 满足套装的道具数量

---获取集齐套装参数
---@param suitType LuaEnumSuitType
---@param itemList table<TABLE.cfg_items>
---@return table<CompleteSuitParams> 未集齐套装=>最低的套装表  集齐套装=>集齐的套装和下一级套装
function cfg_suitManager:GetCompleteSuitParams(suitType, itemList)
    ---同类型的套装的组件都一样
    local suitTbl = self:GetSuitTblBySuitTypeAndLevel(suitType, 1)
    if suitTbl == nil then
        return
    end
    ---道具列表道具最小的等级
    local itemListMinLv = self:GetSuitLvByItemTblList(itemList)
    ---检测是否集齐套装
    local isCompleteSuit = self:CheckItemsIsSuitPart(suitTbl:GetId(), itemList)
    if isCompleteSuit == false then
        itemListMinLv = 1
    end
    ---当前满足套装等级的部件数量
    local curPartNum = self:GetExceedLvPartNum(itemList, itemListMinLv)

    --数据统计
    ---@type table<CompleteSuitParams> 套装信息列表
    local suitInfoList = {}
    ---@type CompleteSuitParams 当前套装信息
    local curSuitCompleteInfo = {}
    curSuitCompleteInfo.completeSuit = isCompleteSuit
    curSuitCompleteInfo.suitTbl = self:GetSuitTblBySuitTypeAndLevel(suitType, itemListMinLv)
    curSuitCompleteInfo.completeSuitItemNum = curPartNum
    table.insert(suitInfoList, curSuitCompleteInfo)
    if isCompleteSuit then
        ---@type CompleteSuitParams
        local nextSuitCompleteInfo = {}
        local nextSuitLv = itemListMinLv + 1
        nextSuitCompleteInfo.completeSuit = false
        nextSuitCompleteInfo.suitTbl = self:GetSuitTblBySuitTypeAndLevel(suitType, nextSuitLv)
        nextSuitCompleteInfo.completeSuitItemNum = self:GetExceedLvPartNum(itemList, nextSuitLv)
        table.insert(suitInfoList, nextSuitCompleteInfo)
    end
    return suitInfoList
end

---获取套装效果在物品信息面板里的描述
---@param suitType LuaEnumSuitType
---@param itemList table<TABLE.cfg_items>
---@return string,string 标题，描述内容
function cfg_suitManager:GetCompleteSuitItemExtraAttributeDes(suitType, itemList)
    local completeSuitParamsList = self:GetCompleteSuitParams(suitType, itemList)
    if type(completeSuitParamsList) ~= 'table' or Utility.GetLuaTableCount(completeSuitParamsList) <= 0 then
        return
    end
    local title = "[73ddf7]" .. "套装效果"
    local des = ""
    for k, v in pairs(completeSuitParamsList) do
        ---@type CompleteSuitParams
        local completeSuitParams = v
        if completeSuitParams.suitTbl ~= nil then
            local suitDesColor = ternary(completeSuitParams.completeSuit, luaEnumColorType.Green3, luaEnumColorType.Gray)
            local suitEffectName = completeSuitParams.suitTbl:GetAttributeName()
            local suitNum = "(" .. completeSuitParams.completeSuitItemNum .. "/" .. completeSuitParams.suitTbl:GetNeedNum() .. ")"
            local buffDes = self:GetBuffDes(completeSuitParams.suitTbl:GetId())
            local curShowDes = suitDesColor .. suitEffectName .. suitNum .. "\n" .. buffDes .. "[-]"
            if CS.StaticUtility.IsNullOrEmpty(des) == false then
                des = des .. "\n"
            end
            des = des .. curShowDes
        end
    end
    return title, des
end
--endregion

--endregion

return cfg_suitManager