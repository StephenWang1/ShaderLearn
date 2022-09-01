--[[本文件为工具自动生成,禁止手动修改]]
local zhenfaV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable zhenfaV2.ZhenfaInfo
---@type zhenfaV2.ZhenfaInfo
zhenfaV2_adj.metatable_ZhenfaInfo = {
    _ClassName = "zhenfaV2.ZhenfaInfo",
}
zhenfaV2_adj.metatable_ZhenfaInfo.__index = zhenfaV2_adj.metatable_ZhenfaInfo
--endregion

---@param tbl zhenfaV2.ZhenfaInfo 待调整的table数据
function zhenfaV2_adj.AdjustZhenfaInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, zhenfaV2_adj.metatable_ZhenfaInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.exp == nil then
        tbl.expSpecified = false
        tbl.exp = 0
    else
        tbl.expSpecified = true
    end
end

--region metatable zhenfaV2.ResZhenfaInfo
---@type zhenfaV2.ResZhenfaInfo
zhenfaV2_adj.metatable_ResZhenfaInfo = {
    _ClassName = "zhenfaV2.ResZhenfaInfo",
}
zhenfaV2_adj.metatable_ResZhenfaInfo.__index = zhenfaV2_adj.metatable_ResZhenfaInfo
--endregion

---@param tbl zhenfaV2.ResZhenfaInfo 待调整的table数据
function zhenfaV2_adj.AdjustResZhenfaInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, zhenfaV2_adj.metatable_ResZhenfaInfo)
    if tbl.zhenfaInfo == nil then
        tbl.zhenfaInfoSpecified = false
        tbl.zhenfaInfo = nil
    else
        if tbl.zhenfaInfoSpecified == nil then 
            tbl.zhenfaInfoSpecified = true
            if zhenfaV2_adj.AdjustZhenfaInfo ~= nil then
                zhenfaV2_adj.AdjustZhenfaInfo(tbl.zhenfaInfo)
            end
        end
    end
end

return zhenfaV2_adj