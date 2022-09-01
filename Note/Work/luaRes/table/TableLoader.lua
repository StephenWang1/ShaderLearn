---@class TableLoader
local TableLoader = {}

---客户端表格管理
clientTableManager = {}
---
TableLoader.TableList = {}
---需要加载的表格数量
TableLoader.NeedLoadNumber = 0
---加载完毕的表格数量
TableLoader.finshLoadNumber = 0

function TableLoader:Init(protobufMgr)
    registerAllClientTable.RegisterPb(protobufMgr)
    registerAllClientTable.RequireTableManager()
    registerAllClientTable.RequireTable()
    TableLoader.SetAllLuaComponentMetaTable()
    registerAllClientTable.OnLoad()
end

function TableLoader.SetAllLuaComponentMetaTable()
    for k, v in pairs(clientTableManager) do
        if getmetatable(v) == nil then
            --设置模板的元表为模板
            setmetatable(v, tableManager)
        end
        v.__index = v
    end
end

return TableLoader