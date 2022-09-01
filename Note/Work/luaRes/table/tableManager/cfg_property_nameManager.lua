---@class cfg_property_nameManager:TableManager
local cfg_property_nameManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_property_name
function cfg_property_nameManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_property_name> 遍历方法
function cfg_property_nameManager:ForPair(action)
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
function cfg_property_nameManager:PostProcess()
end

---获取属性显示颜色
---@param itemId number
---@param attributeId LuaEnumAttributeType
---@return string
function cfg_property_nameManager:GetAttributeColor(itemId,attributeId)
    local color = luaEnumColorType.White
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    local colorParamsList = self:GetColorParamsList(attributeId)
    if type(colorParamsList) == 'table' and #colorParamsList > 0 then
        for k,v in pairs(colorParamsList) do
            ---@type ColorParams
            local colorParams = v
            if itemTbl:GetType() == colorParams.type and itemTbl:GetSubType() == colorParams.subType then
                return colorParams.color
            end
        end
    end
    return color
end

---@class ColorParams
---@field type number 道具type
---@field subType number 道具subType
---@field color string 颜色

---获取颜色参数列表
---@param attributeId LuaEnumAttributeType
---@return table<ColorParams>
function cfg_property_nameManager:GetColorParamsList(attributeId)
    local propertyNameTbl = self:TryGetValue(attributeId)
    local colorList = {}
    if propertyNameTbl ~= nil and CS.StaticUtility.IsNullOrEmpty(propertyNameTbl:GetColor()) == false then
        local paramsList = string.Split(propertyNameTbl:GetColor(),'&')
        for k,v in pairs(paramsList) do
            local itemTypeAndColor = string.Split(v,'#')
            if type(itemTypeAndColor) == 'table' and #itemTypeAndColor > 2 then
                ---@type ColorParams
                local colorParams = {}
                colorParams.type = tonumber(itemTypeAndColor[1])
                colorParams.subType = tonumber(itemTypeAndColor[2])
                colorParams.color = itemTypeAndColor[3]
                table.insert(colorList,colorParams)
            end
        end
    end
    return colorList
end

return cfg_property_nameManager