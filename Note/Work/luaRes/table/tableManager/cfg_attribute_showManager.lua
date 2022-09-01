---@class cfg_attribute_showManager:TableManager
local cfg_attribute_showManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_attribute_show
function cfg_attribute_showManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_attribute_show> 遍历方法
function cfg_attribute_showManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
            self:InitAttributeTypeAndTblDic(v)
        end
    end
end

--region 属性索引的数据结构
--region 数据
---@type table<LuaEnumAttributeType,TABLE.cfg_attribute_show>
cfg_attribute_showManager.AttributeTypeAndTblDic = nil

---@param tbl TABLE.cfg_attribute_show
function cfg_attribute_showManager:InitAttributeTypeAndTblDic(tbl)
    if self.AttributeTypeAndTblDic == nil then
        self.AttributeTypeAndTblDic = {}
    end
    self.AttributeTypeAndTblDic[tbl:GetType()] = tbl
end

---通过属性类型获取属性显示表
---@param attributeType LuaEnumAttributeType
---@retrun TABLE.cfg_attribute_show
function cfg_attribute_showManager:TryGetAttributeShowTblByAttributeType(attributeType)
    if self.AttributeTypeAndTblDic == nil then
        self:ForPair(function(k,v)
            self:InitAttributeTypeAndTblDic(v)
        end)
    end
    return self.AttributeTypeAndTblDic[attributeType]
end
--endregion
--endregion

---表格解析完毕后调用此方法
function cfg_attribute_showManager:PostProcess()
end

---获取属性列表文本描述内容
---@param attributeList table<fightV2.PlayerAttribute>
---@return string
function cfg_attribute_showManager:GetAttributeDes(attributeList)
    local attributeDesTable = self:GetAttributeListDesTable(attributeList)
    if type(attributeDesTable) ~= 'table' then
        return
    end
    local attributeDesTableCount = Utility.GetLuaTableCount(attributeDesTable)
    if attributeDesTableCount <= 0 then
        return
    end
    local des = ""
    local changeLine = "\n"
    for k = 1,attributeDesTableCount do
        ---@type AttributeDes
        local attributeDes = attributeDesTable[k]
        local attributeName = attributeDes.attributeName
        local attributeValueDes = attributeDes.attributeValueDes
        if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeValueDes) == false then
            local curAttributeDes = attributeName .. " " .. attributeValueDes
            if k == attributeDesTableCount then
                des = des .. curAttributeDes
            else
                des = des .. curAttributeDes .. changeLine
            end
        end
    end
    return des
end

---@class AttributeDes 属性描述类
---@field attributeName string 属性名
---@field attributeValueDes string 属性值描述内容
---@field attributeNextValueDes string 下一级属性描述内容

---获取属性列表描述内容
---@param attributeList table<fightV2.PlayerAttribute>
---@return table<AttributeDes>
function cfg_attribute_showManager:GetAttributeListDesTable(attributeList)
    if type(attributeList) ~= 'table' then
        return
    end
    local attributeDesTable = {}
    for k,v in pairs(attributeList) do
        local attributeType = v.type
        local attributeValue = v.num
        local attributeShowTbl = self:TryGetAttributeShowTblByAttributeType(attributeType)
        if attributeShowTbl ~= nil then
            local attributeName = attributeShowTbl:GetShow()
            local attributeValueDes = ""
            if attributeValue ~= 0 then
                attributeValueDes = self:GetAttributeValueDes(attributeShowTbl:GetValueType(),attributeValue)
            end
            if attributeShowTbl:GetRelationAttribute() ~= nil and attributeShowTbl:GetRelationAttribute().list ~= nil then
                local attributeValueTable = self:GetAttributeValueTable(attributeList,attributeShowTbl:GetRelationAttribute().list)
                attributeValueTable = Utility.TableFirstSetValue(attributeValueTable,attributeValue)
                local allAttributeIsZero = self:CheckAttributeValueTableAllIsZero(attributeValueTable)
                if allAttributeIsZero == false then
                    if type(attributeValueTable) == 'table' then
                        attributeValueDes = self:GetRelationAttributeListDes(attributeValueTable,attributeShowTbl:GetRelationType(),attributeShowTbl:GetValueType())
                    end
                end
            end
            if CS.StaticUtility.IsNullOrEmpty(attributeValueDes) == false then
                ---@type AttributeDes
                local attributeDes = {}
                attributeDes.attributeName = attributeName
                attributeDes.attributeValueDes = attributeValueDes
                table.insert(attributeDesTable,attributeDes)
            end
        end
    end
    return attributeDesTable
end

---获取关联属性后的数值显示内容
---@param attributeValueTable table<number>
---@param attributeRelationType LuaEnumRelationAttributeShowType
---@param attributeValueShowType LuaEnumAttributeValueShowType
function cfg_attribute_showManager:GetRelationAttributeListDes(attributeValueTable,attributeRelationType,attributeValueShowType)
    if type(attributeValueTable) ~= 'table' then
        return
    end
    local FenGeFu = " "
    if attributeRelationType == LuaEnumRelationAttributeShowType.Type1 then
        FenGeFu = " - "
    end
    local attributeValueDes = ""
    local attributeValueShowType = ternary(attributeValueShowType == nil,LuaEnumAttributeValueShowType.Normal,attributeValueShowType)
    local attributeTableCount = Utility.GetLuaTableCount(attributeValueTable)
    for k = 1,attributeTableCount do
        local attributeValue = attributeValueTable[k]
        local curAttributeValueDes = self:GetAttributeValueDes(attributeValueShowType,attributeValue)
        if CS.StaticUtility.IsNullOrEmpty(curAttributeValueDes) == false then
            if k == attributeTableCount then
                attributeValueDes = attributeValueDes .. curAttributeValueDes
            else
                attributeValueDes = attributeValueDes .. curAttributeValueDes .. FenGeFu
            end
        end
    end
    return attributeValueDes
end

---获取属性值列表
---@param attributeList table<fightV2.PlayerAttribute>
---@param attributeTypeList table<LuaEnumAttributeType>
---@return table<number>
function cfg_attribute_showManager:GetAttributeValueTable(attributeList,attributeTypeList)
    local attributeValueTable = {}
    if type(attributeList) ~= 'table' or type(attributeTypeList) ~= 'table' then
        return attributeValueTable
    end

    for k,v in pairs(attributeTypeList) do
        local attributeValue = self:GetAttributeValue(attributeList,v)
        if type(attributeValue) == 'number' then
            table.insert(attributeValueTable,attributeValue)
        end
    end
    return attributeValueTable
end

---获取属性值
---@param attributeList table<fightV2.PlayerAttribute>
---@param attributeType LuaEnumAttributeType
---@return number
function cfg_attribute_showManager:GetAttributeValue(attributeList,attributeType)
    if type(attributeList) ~= 'table' or type(attributeType) ~= 'number' then
        return
    end
    for k,v in pairs(attributeList) do
        local curAttributeType = v.type
        local curAttributeValue = v.num
        if attributeType == curAttributeType then
            return curAttributeValue
        end
    end
    return 0
end

---获取属性值
---@param luaEnumAttributeValueShowType LuaEnumAttributeValueShowType
---@param attributeValue number
---@retrun number
function cfg_attribute_showManager:GetAttributeShowValue(luaEnumAttributeValueShowType,attributeValue)
    if type(luaEnumAttributeValueShowType) ~= 'number' or type(attributeValue) ~= 'number' then
        return
    end
    if luaEnumAttributeValueShowType == LuaEnumAttributeValueShowType.Normal then
        return attributeValue
    elseif luaEnumAttributeValueShowType == LuaEnumAttributeValueShowType.AllGrades then
        return attributeValue / 10000
    elseif luaEnumAttributeValueShowType == LuaEnumAttributeValueShowType.Percent then
        return attributeValue / 100
    end
end

---获取属性值文本描述
---@param luaEnumAttributeValueShowType LuaEnumAttributeValueShowType
---@param attributeValue number
---@return string
function cfg_attribute_showManager:GetAttributeValueDes(luaEnumAttributeValueShowType,attributeValue)
    if type(luaEnumAttributeValueShowType) ~= 'number' or type(attributeValue) ~= 'number' then
        return
    end
    local value = self:GetAttributeShowValue(luaEnumAttributeValueShowType,attributeValue)
    local des = tostring(value)
    if luaEnumAttributeValueShowType == LuaEnumAttributeValueShowType.AllGrades or luaEnumAttributeValueShowType == LuaEnumAttributeValueShowType.Percent then
        des = des .. "%"
    end
    return des
end

---检测属性值列表是否都是0
---@param attributeTable table<number>
---@return boolean
function cfg_attribute_showManager:CheckAttributeValueTableAllIsZero(attributeTable)
    if type(attributeTable) ~= 'table' then
        return
    end
    for k,v in pairs(attributeTable) do
        if v ~= 0 then
            return false
        end
    end
    return true
end

return cfg_attribute_showManager