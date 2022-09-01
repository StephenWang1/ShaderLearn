--[[本文件为工具自动生成,禁止手动修改]]
local imprintV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable imprintV2.ResImprintInfo
---@type imprintV2.ResImprintInfo
imprintV2_adj.metatable_ResImprintInfo = {
    _ClassName = "imprintV2.ResImprintInfo",
}
imprintV2_adj.metatable_ResImprintInfo.__index = imprintV2_adj.metatable_ResImprintInfo
--endregion

---@param tbl imprintV2.ResImprintInfo 待调整的table数据
function imprintV2_adj.AdjustResImprintInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ResImprintInfo)
    if tbl.imprintInfoList == nil then
        tbl.imprintInfoList = {}
    else
        if imprintV2_adj.AdjustImprintInfo ~= nil then
            for i = 1, #tbl.imprintInfoList do
                imprintV2_adj.AdjustImprintInfo(tbl.imprintInfoList[i])
            end
        end
    end
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
end

--region metatable imprintV2.ImprintInfo
---@type imprintV2.ImprintInfo
imprintV2_adj.metatable_ImprintInfo = {
    _ClassName = "imprintV2.ImprintInfo",
}
imprintV2_adj.metatable_ImprintInfo.__index = imprintV2_adj.metatable_ImprintInfo
--endregion

---@param tbl imprintV2.ImprintInfo 待调整的table数据
function imprintV2_adj.AdjustImprintInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ImprintInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.isValid == nil then
        tbl.isValidSpecified = false
        tbl.isValid = false
    else
        tbl.isValidSpecified = true
    end
    if tbl.lid == nil then
        tbl.lidSpecified = false
        tbl.lid = 0
    else
        tbl.lidSpecified = true
    end
    if tbl.shuXing == nil then
        tbl.shuXingSpecified = false
        tbl.shuXing = 0
    else
        tbl.shuXingSpecified = true
    end
    if tbl.fuDong == nil then
        tbl.fuDongSpecified = false
        tbl.fuDong = 0
    else
        tbl.fuDongSpecified = true
    end
    if tbl.itemInfo == nil then
        tbl.itemInfoSpecified = false
        tbl.itemInfo = nil
    else
        if tbl.itemInfoSpecified == nil then 
            tbl.itemInfoSpecified = true
            if adjustTable.bag_adj ~= nil and adjustTable.bag_adj.AdjustBagItemInfo ~= nil then
                adjustTable.bag_adj.AdjustBagItemInfo(tbl.itemInfo)
            end
        end
    end
end

--region metatable imprintV2.ReqPutOnImprint
---@type imprintV2.ReqPutOnImprint
imprintV2_adj.metatable_ReqPutOnImprint = {
    _ClassName = "imprintV2.ReqPutOnImprint",
}
imprintV2_adj.metatable_ReqPutOnImprint.__index = imprintV2_adj.metatable_ReqPutOnImprint
--endregion

---@param tbl imprintV2.ReqPutOnImprint 待调整的table数据
function imprintV2_adj.AdjustReqPutOnImprint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ReqPutOnImprint)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.imprintId == nil then
        tbl.imprintIdSpecified = false
        tbl.imprintId = 0
    else
        tbl.imprintIdSpecified = true
    end
end

--region metatable imprintV2.ReqTakeOffImprint
---@type imprintV2.ReqTakeOffImprint
imprintV2_adj.metatable_ReqTakeOffImprint = {
    _ClassName = "imprintV2.ReqTakeOffImprint",
}
imprintV2_adj.metatable_ReqTakeOffImprint.__index = imprintV2_adj.metatable_ReqTakeOffImprint
--endregion

---@param tbl imprintV2.ReqTakeOffImprint 待调整的table数据
function imprintV2_adj.AdjustReqTakeOffImprint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ReqTakeOffImprint)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable imprintV2.ResPutOnImprint
---@type imprintV2.ResPutOnImprint
imprintV2_adj.metatable_ResPutOnImprint = {
    _ClassName = "imprintV2.ResPutOnImprint",
}
imprintV2_adj.metatable_ResPutOnImprint.__index = imprintV2_adj.metatable_ResPutOnImprint
--endregion

---@param tbl imprintV2.ResPutOnImprint 待调整的table数据
function imprintV2_adj.AdjustResPutOnImprint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ResPutOnImprint)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable imprintV2.ResTakeOffImprint
---@type imprintV2.ResTakeOffImprint
imprintV2_adj.metatable_ResTakeOffImprint = {
    _ClassName = "imprintV2.ResTakeOffImprint",
}
imprintV2_adj.metatable_ResTakeOffImprint.__index = imprintV2_adj.metatable_ResTakeOffImprint
--endregion

---@param tbl imprintV2.ResTakeOffImprint 待调整的table数据
function imprintV2_adj.AdjustResTakeOffImprint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, imprintV2_adj.metatable_ResTakeOffImprint)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

return imprintV2_adj