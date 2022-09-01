--[[本文件为工具自动生成,禁止手动修改]]
local tipV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable tipV2.PromptMsg
---@type tipV2.PromptMsg
tipV2_adj.metatable_PromptMsg = {
    _ClassName = "tipV2.PromptMsg",
}
tipV2_adj.metatable_PromptMsg.__index = tipV2_adj.metatable_PromptMsg
--endregion

---@param tbl tipV2.PromptMsg 待调整的table数据
function tipV2_adj.AdjustPromptMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tipV2_adj.metatable_PromptMsg)
end

--region metatable tipV2.ResUIBubbleMsg
---@type tipV2.ResUIBubbleMsg
tipV2_adj.metatable_ResUIBubbleMsg = {
    _ClassName = "tipV2.ResUIBubbleMsg",
}
tipV2_adj.metatable_ResUIBubbleMsg.__index = tipV2_adj.metatable_ResUIBubbleMsg
--endregion

---@param tbl tipV2.ResUIBubbleMsg 待调整的table数据
function tipV2_adj.AdjustResUIBubbleMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, tipV2_adj.metatable_ResUIBubbleMsg)
    if tbl.msg == nil then
        tbl.msgSpecified = false
        tbl.msg = ""
    else
        tbl.msgSpecified = true
    end
end

return tipV2_adj