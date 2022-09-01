---@class LuaDebugTool
local LuaDebugTool = {}

---@class DebugTableType
LuaDebugTool.TableType = {
    ---模板
    Template = "Template",
    ---模板实例
    TemplateInstance = "TemplateInstance",
    ---界面实例
    PanelInstance = "PanelInstance",
    ---LuaClass
    LuaClass = "LuaClass",
    ---LuaClass实例
    LuaClassInstance = "LuaClassInstance",
}

---各个table类型的所有引用
---@private
---@type table<DebugTableType,table>
LuaDebugTool.WeakTableRecord = {}
---@private
---@type table
LuaDebugTool.WeakTableMetatable = { __mode = "kv" }

---已检查的引用
---@private
LuaDebugTool.CheckedRefer = {}

---指令接收
---@private
---@param id number
---@param params string
function LuaDebugTool.OrderReceiver(id, params)
    print("Order Received", id, params)
    if id == LuaDebugTool.TableType.PanelInstance then
        local uipanelTbl = uimanager.WeakUIPanels[params]
        if uipanelTbl ~= nil then
            print("界面table尚未释放", params)
            LuaDebugTool.PrintTableGetRefered(uipanelTbl)
        end
    end
end

if CS.StaticUtility.IsNull(CS.LuaReferenceFindTool.Instance) == false then
    CS.LuaReferenceFindTool.Instance:RegisterLuaOrderReceiveMethod(LuaDebugTool.OrderReceiver)
end

---记录table的引用(使用弱引用表存储,不影响GC)
---@public
---@param tableType DebugTableType 被记录的Table类型
---@param tbl table 被记录的table
function LuaDebugTool.RecordTable(tableType, tbl)
    local pool = LuaDebugTool.WeakTableRecord[tableType]
    if pool == nil then
        pool = {}
        setmetatable(pool, LuaDebugTool.WeakTableMetatable)
        LuaDebugTool.WeakTableRecord[tableType] = pool
    end
    table.insert(pool, tbl)
end

---查询table被哪些引用了
---@public
---@param tbl table
function LuaDebugTool.PrintTableGetRefered(tbl)
    if tbl == nil then
        return
    end
    LuaDebugTool.ResetCheckRefer()
    for i, v in pairs(_G) do
        if v == tbl then
            LuaDebugTool.PrintTableType(i, tbl)
        else
            LuaDebugTool.PrintTableGetReferedInTable(i, tbl, v, tostring(i))
        end
    end
    for tableType, pool in pairs(LuaDebugTool.WeakTableRecord) do
        for index, temp in pairs(pool) do
            if temp ~= tbl then
                LuaDebugTool.PrintTableGetReferedInTable(tableType, tbl, temp, tableType)
            end
        end
    end
    LuaDebugTool.ResetCheckRefer()
end

---@private
function LuaDebugTool.ResetCheckRefer()
    LuaDebugTool.CheckedRefer = {}
    setmetatable(LuaDebugTool.CheckedRefer, LuaDebugTool.WeakTableMetatable)
    LuaDebugTool.CheckedRefer.__index = LuaDebugTool.CheckedRefer
end

---在gTbl下查找打印出引用了tbl的对象的引用路径
---@private
function LuaDebugTool.PrintTableGetReferedInTable(tableType, tbl, gTbl, path)
    if gTbl == nil or type(gTbl) ~= "table" or LuaDebugTool.CheckedRefer[gTbl] == true then
        return
    end
    if gTbl == LuaDebugTool or gTbl == LuaDebugTool.WeakTableRecord or gTbl == uimanager.WeakUIPanels then
        return
    end
    if path == nil then
        path = ""
    end
    LuaDebugTool.CheckedRefer[gTbl] = true
    for i, v in pairs(gTbl) do
        if v == tbl then
            LuaDebugTool.PrintTableType(tableType, gTbl, path .. "-->" .. tostring(i))
        else
            local rawv = gTbl[i]
            if rawv ~= nil and type(rawv) == "table" then
                LuaDebugTool.PrintTableGetReferedInTable(tableType, tbl, rawv, path .. "-->" .. tostring(i))
            end
        end
    end
end

---打印table类型
---@private
---@param tableType DebugTableType
---@param tbl table
---@param path string
function LuaDebugTool.PrintTableType(tableType, tbl, path)
    if tbl == nil then
        return
    end
    if path == nil then
        path = ""
    end
    local name = tbl.chunkName
    if name == nil then
        name = tbl._PanelName
    end
    if name == nil then
        name = tbl.__className
    end
    if name == nil then
        name = tbl.name
    end
    if name == nil then
        name = "*"
    end
    print(tableType, "name:" .. name .. ":  " .. path)
end

return LuaDebugTool