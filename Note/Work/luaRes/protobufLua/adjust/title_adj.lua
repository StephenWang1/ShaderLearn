--[[本文件为工具自动生成,禁止手动修改]]
local titleV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable titleV2.TitleInfo
---@type titleV2.TitleInfo
titleV2_adj.metatable_TitleInfo = {
    _ClassName = "titleV2.TitleInfo",
}
titleV2_adj.metatable_TitleInfo.__index = titleV2_adj.metatable_TitleInfo
--endregion

---@param tbl titleV2.TitleInfo 待调整的table数据
function titleV2_adj.AdjustTitleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_TitleInfo)
    if tbl.getTime == nil then
        tbl.getTimeSpecified = false
        tbl.getTime = 0
    else
        tbl.getTimeSpecified = true
    end
end

--region metatable titleV2.ResRemoveTitle
---@type titleV2.ResRemoveTitle
titleV2_adj.metatable_ResRemoveTitle = {
    _ClassName = "titleV2.ResRemoveTitle",
}
titleV2_adj.metatable_ResRemoveTitle.__index = titleV2_adj.metatable_ResRemoveTitle
--endregion

---@param tbl titleV2.ResRemoveTitle 待调整的table数据
function titleV2_adj.AdjustResRemoveTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ResRemoveTitle)
end

--region metatable titleV2.ResTitleList
---@type titleV2.ResTitleList
titleV2_adj.metatable_ResTitleList = {
    _ClassName = "titleV2.ResTitleList",
}
titleV2_adj.metatable_ResTitleList.__index = titleV2_adj.metatable_ResTitleList
--endregion

---@param tbl titleV2.ResTitleList 待调整的table数据
function titleV2_adj.AdjustResTitleList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ResTitleList)
    if tbl.titleList == nil then
        tbl.titleList = {}
    else
        if titleV2_adj.AdjustTitleInfo ~= nil then
            for i = 1, #tbl.titleList do
                titleV2_adj.AdjustTitleInfo(tbl.titleList[i])
            end
        end
    end
end

--region metatable titleV2.ReqPutOnTitle
---@type titleV2.ReqPutOnTitle
titleV2_adj.metatable_ReqPutOnTitle = {
    _ClassName = "titleV2.ReqPutOnTitle",
}
titleV2_adj.metatable_ReqPutOnTitle.__index = titleV2_adj.metatable_ReqPutOnTitle
--endregion

---@param tbl titleV2.ReqPutOnTitle 待调整的table数据
function titleV2_adj.AdjustReqPutOnTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ReqPutOnTitle)
end

--region metatable titleV2.ResPutOnTitle
---@type titleV2.ResPutOnTitle
titleV2_adj.metatable_ResPutOnTitle = {
    _ClassName = "titleV2.ResPutOnTitle",
}
titleV2_adj.metatable_ResPutOnTitle.__index = titleV2_adj.metatable_ResPutOnTitle
--endregion

---@param tbl titleV2.ResPutOnTitle 待调整的table数据
function titleV2_adj.AdjustResPutOnTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ResPutOnTitle)
    if tbl.putOff == nil then
        tbl.putOffSpecified = false
        tbl.putOff = nil
    else
        if tbl.putOffSpecified == nil then 
            tbl.putOffSpecified = true
            if titleV2_adj.AdjustTitleInfo ~= nil then
                titleV2_adj.AdjustTitleInfo(tbl.putOff)
            end
        end
    end
end

--region metatable titleV2.ReqPutOffTitle
---@type titleV2.ReqPutOffTitle
titleV2_adj.metatable_ReqPutOffTitle = {
    _ClassName = "titleV2.ReqPutOffTitle",
}
titleV2_adj.metatable_ReqPutOffTitle.__index = titleV2_adj.metatable_ReqPutOffTitle
--endregion

---@param tbl titleV2.ReqPutOffTitle 待调整的table数据
function titleV2_adj.AdjustReqPutOffTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ReqPutOffTitle)
end

--region metatable titleV2.ResPutOffTitle
---@type titleV2.ResPutOffTitle
titleV2_adj.metatable_ResPutOffTitle = {
    _ClassName = "titleV2.ResPutOffTitle",
}
titleV2_adj.metatable_ResPutOffTitle.__index = titleV2_adj.metatable_ResPutOffTitle
--endregion

---@param tbl titleV2.ResPutOffTitle 待调整的table数据
function titleV2_adj.AdjustResPutOffTitle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, titleV2_adj.metatable_ResPutOffTitle)
end

return titleV2_adj