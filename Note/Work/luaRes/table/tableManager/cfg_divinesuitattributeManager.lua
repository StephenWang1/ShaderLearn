---@class cfg_divinesuitattributeManager:TableManager
local cfg_divinesuitattributeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_divinesuitattribute
function cfg_divinesuitattributeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_divinesuitattribute> 遍历方法
function cfg_divinesuitattributeManager:ForPair(action)
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
function cfg_divinesuitattributeManager:PostProcess()
end

---模型的套装属性加载table{count 凑齐几件的时候暂时, divineSuitAttribute  加成数据 TABLE.cfg_divinesuitattribute}
---@param type number 传入divineSuit表格中的套装类型
---@param level number 传入divineSuit表格中的套装等级
---@param nowCount number 当前身上满足的装备数量
---@return table<number:激活所需数量, number:激活属性TABLE.cfg_divinesuitattribute的ID>
function cfg_divinesuitattributeManager.GetDivineSuitAddition(type, level, nowCount)
    return cfg_divinesuitattributeManager.GetDivineSuitAdditionByID(type * 1000 + level, nowCount)
end

---模型的套装属性加载table{count 凑齐几件的时候暂时, divineSuitAttribute  加成数据 TABLE.cfg_divinesuitattribute}
---@param id number 传入divineSuit表格中的id
---@param nowCount number 当前身上满足的装备数量
---@return table<number:激活所需数量, number:激活属性TABLE.cfg_divinesuitattribute的ID>
function cfg_divinesuitattributeManager.GetDivineSuitAdditionByID(id, nowCount)
    ---@type TABLE.cfg_divinesuit
    local suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(id)
    if (suitData == nil) then
        CS.UnityEngine.Debug.LogError("没有在divineSuit表格中找到:" .. tostring(id));
        return {}
    end
    local data = suitData:GetAttribute();

    local DefaultSuitAddition = {}
    if (data == nil or data.list == nil) then
        return DefaultSuitAddition
    end
    for i, v in pairs(data.list) do
        local itemData = v.list
        local count = itemData[1]
        --当前属性满足穿戴的时候  添加数据
        if (count < nowCount) then
            local divineSuitAttributeID = itemData[2]
            ---直接返回cfg_divinesuitattribute的ID,在详细的模板里面再去获取,避免多次查表
            DefaultSuitAddition[count] = divineSuitAttributeID
        end
    end
    return DefaultSuitAddition
end

return cfg_divinesuitattributeManager