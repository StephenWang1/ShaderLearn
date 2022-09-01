---@class TableManager
local TableManager = {}
TableManager.__index = TableManager

---添加表格数据
---@generic TKey, TValue
---@param key TKey
---@param value TValue
function TableManager:AddTables(key, value)
    if self.dic == nil then
        self.dic = {}
    end
    if key == nil then
        print("key == null value", value)
    else
        self.dic[key] = value
    end
end

---后置处理
function TableManager:PostProcess()
end

---表格加载完毕
---@param isLoadSucceed boolean  是否加载成功
function TableManager:LoadFinsh(isLoadSucceed)
    tableLoader.finshLoadNumber = tableLoader.finshLoadNumber + 1
    if tableLoader.NeedLoadNumber == tableLoader.finshLoadNumber then
        CS.TableLoader.Instance.IsLoadFinshLuaTable = true
    end
end

function TableManager:TryGetValue(key)
    return self.dic[key]
end

---表格数据加载△
---@param tableName string 表格名称
---@param tableStructure table 表格结构
function TableManager:OnLoad(tableName, tableStructure)
    tableLoader.NeedLoadNumber = tableLoader.NeedLoadNumber + 1
    self.tableName = tableName
    self.tableStructure = tableStructure
    local nameStr = string.lower(tableName) .. "_lua.bytes"
    local res = CS.CSResourceManager.Singleton:AddQueue(nameStr, CS.ResourceType.TableBytes, function(res)
        self:OnResourceLoaded(tableName, res)
    end, CS.ResourceAssistType.QueueDeal)
    res.IsCanBeDelete = false
end

---解析表格
---@param tableName string 表格名称
---@param res NewI_CSResourceWWW
function TableManager:OnResourceLoaded(tableName, res)
    local array = self:ReadOneDataConfig(tableName, res)
    if array ~= nil and array.rows ~= nil then
        for i = 1, #array.rows do
            local id = 0
            local table = {}
            if self.tableStructure ~= nil then
                setmetatable(table, self.tableStructure)
                table.__index = table
                table:Init(array.rows[i])
                id = table:UUID()
            else
                table = array.rows[i]
                id = array.rows[i].id
            end
            self:AddTables(id, table)
        end
        self:LoadFinsh(true)
        self:PostProcess()
    else
        self:LoadFinsh(false)
        CS.UnityEngine.Debug.LogError("Lua表格解析失败：" .. tostring(self.tableName))
    end
    if res ~= nil and CS.CSResourceManager.Singleton ~= nil then
        res.IsCanBeDelete = true
        res.MirroyBytes = nil
        CS.CSResourceManager.Singleton:DestroyResource(res.Path, false, true, false, false, false);
    end
end

---读取配置
---@param tableName string 表格名称
---@param res NewI_CSResourceWWW
function TableManager:ReadOneDataConfig(tableName, res)
    local Bytes = res.MirroyBytes
    if Bytes == nil then
        return nil
    end
    local nameStr = "TABLE." .. string.upper(tableName) .. "ARRAY"
    local decodedData = protobufMgr.Deserialize(nameStr, Bytes)
    return decodedData
end

return TableManager