--[[本文件为工具自动生成,禁止手动修改]]
local TABLE_adj = {}

---@class TABLE.Range
---class properties
---@field public range_type number
---@field public range_typeSpecified boolean
---@field public lhs number
---@field public lhsSpecified boolean
---@field public rhs number
---@field public rhsSpecified boolean
---function params
---@param tbl TABLE.Range 待调整的table数据
function TABLE_adj.AdjustRange(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.range_type == nil then
        tbl.range_typeSpecified = false
        tbl.range_type = ""
    else
        tbl.range_typeSpecified = true
    end
    if tbl.lhs == nil then
        tbl.lhsSpecified = false
        tbl.lhs = 0
    else
        tbl.lhsSpecified = true
    end
    if tbl.rhs == nil then
        tbl.rhsSpecified = false
        tbl.rhs = 0
    else
        tbl.rhsSpecified = true
    end
end

---@class TABLE.IntPair
---class properties
---@field public first number
---@field public firstSpecified boolean
---@field public second number
---@field public secondSpecified boolean
---function params
---@param tbl TABLE.IntPair 待调整的table数据
function TABLE_adj.AdjustIntPair(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.first == nil then
        tbl.firstSpecified = false
        tbl.first = 0
    else
        tbl.firstSpecified = true
    end
    if tbl.second == nil then
        tbl.secondSpecified = false
        tbl.second = 0
    else
        tbl.secondSpecified = true
    end
end

---@class TABLE.IntPairList
---class properties
---@field public list table<number, TABLE.IntPair>
---function params
---@param tbl TABLE.IntPairList 待调整的table数据
function TABLE_adj.AdjustIntPairList(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if TABLE_adj.AdjustIntPair ~= nil then
            for i = 1, #tbl.list do
                TABLE_adj.AdjustIntPair(tbl.list[i])
            end
        end
    end
end

---@class TABLE.IntPairList2
---class properties
---@field public list table<number, TABLE.IntPair>
---function params
---@param tbl TABLE.IntPairList2 待调整的table数据
function TABLE_adj.AdjustIntPairList2(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if TABLE_adj.AdjustIntPair ~= nil then
            for i = 1, #tbl.list do
                TABLE_adj.AdjustIntPair(tbl.list[i])
            end
        end
    end
end

---@class TABLE.IntList
---class properties
---@field public list table<number, number>
---function params
---@param tbl TABLE.IntList 待调整的table数据
function TABLE_adj.AdjustIntList(tbl)
    if (tbl == nil) then
        return
    end
end

---@class TABLE.StringList
---class properties
---@field public list table<number, string>
---function params
---@param tbl TABLE.StringList 待调整的table数据
function TABLE_adj.AdjustStringList(tbl)
    if (tbl == nil) then
        return
    end
end

---@class TABLE.IntListJingHao
---class properties
---@field public list table<number, number>
---function params
---@param tbl TABLE.IntListJingHao 待调整的table数据
function TABLE_adj.AdjustIntListJingHao(tbl)
    if (tbl == nil) then
        return
    end
end

---@class TABLE.IntListXiaHuaXian
---class properties
---@field public list table<number, number>
---function params
---@param tbl TABLE.IntListXiaHuaXian 待调整的table数据
function TABLE_adj.AdjustIntListXiaHuaXian(tbl)
    if (tbl == nil) then
        return
    end
end

---@class TABLE.IntListXiaHuaXianFenHao
---class properties
---@field public list table<number, TABLE.IntListXiaHuaXian>
---function params
---@param tbl TABLE.IntListXiaHuaXianFenHao 待调整的table数据
function TABLE_adj.AdjustIntListXiaHuaXianFenHao(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if TABLE_adj.AdjustIntListXiaHuaXian ~= nil then
            for i = 1, #tbl.list do
                TABLE_adj.AdjustIntListXiaHuaXian(tbl.list[i])
            end
        end
    end
end

---@class TABLE.IntListJingHaoMeiYuan
---class properties
---@field public list table<number, TABLE.IntListJingHao>
---function params
---@param tbl TABLE.IntListJingHaoMeiYuan 待调整的table数据
function TABLE_adj.AdjustIntListJingHaoMeiYuan(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if TABLE_adj.AdjustIntListJingHao ~= nil then
            for i = 1, #tbl.list do
                TABLE_adj.AdjustIntListJingHao(tbl.list[i])
            end
        end
    end
end

---@class TABLE.IntListList
---class properties
---@field public list table<number, TABLE.IntList>
---function params
---@param tbl TABLE.IntListList 待调整的table数据
function TABLE_adj.AdjustIntListList(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.list == nil then
        tbl.list = {}
    else
        if TABLE_adj.AdjustIntList ~= nil then
            for i = 1, #tbl.list do
                TABLE_adj.AdjustIntList(tbl.list[i])
            end
        end
    end
end

---@class TABLE.IntSpecXiaHuaJinHao
---class properties
---@field public value0 number
---@field public value0Specified boolean
---@field public list table<number, number>
---function params
---@param tbl TABLE.IntSpecXiaHuaJinHao 待调整的table数据
function TABLE_adj.AdjustIntSpecXiaHuaJinHao(tbl)
    if (tbl == nil) then
        return
    end
    if tbl.value0 == nil then
        tbl.value0Specified = false
        tbl.value0 = 0
    else
        tbl.value0Specified = true
    end
end

return TABLE_adj