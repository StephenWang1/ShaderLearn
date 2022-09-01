---@class LuaSystemPreviewInfoMgr
local LuaSystemPreviewInfoMgr = {}

---@return table<number,systemPreviewInfo>
function LuaSystemPreviewInfoMgr:GetSystemPerviewTbl()
    if self.mSystemPerviewTbl == nil then
        self.mSystemPerviewTbl = {}
    end
    return self.mSystemPerviewTbl
end

---@param data roleV2.ResRoleSystemPreview
function LuaSystemPreviewInfoMgr:RefreshSystemPerviewTbl(data)
    self.mSystemPerviewTbl = {}
    if data == nil or data.info == nil or #data.info == 0 then
        return
    end
    ---@type TABLE.cfg_system_preview
    local systemTbl, systemId

    for i = 1, #data.info do
        systemId = data.info[i].id
        systemTbl = clientTableManager.cfg_system_previewManager:TryGetValue(systemId)
        if systemTbl then
            ---@class systemPreviewInfo
            local param = {}
            param.id = systemId
            ---@type TABLE.cfg_system_preview
            param.systemTblData = systemTbl
            ---@type LuaEnumGetAwardType
            param.rewardType = data.info[i].rewardType

            table.insert(self.mSystemPerviewTbl, param)
        end
    end
    table.sort(self.mSystemPerviewTbl, function(l, r)
        return self:SortTbl(l, r)
    end)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.SystemPreview)
end

---@param l systemPreviewInfo
---@param r systemPreviewInfo
function LuaSystemPreviewInfoMgr:SortTbl(l, r)

    if l == nil or r == nil then
        return false
    end

    if l.rewardType ~= r.rewardType then
        if l.rewardType == LuaEnumGetAwardType.Get or r.rewardType == LuaEnumGetAwardType.Get then
            return l.rewardType == 1
        end
        return l.rewardType < r.rewardType
    end

    if l.systemTblData and r.systemTblData and l.systemTblData:GetOrder() ~= nil and r.systemTblData:GetOrder() ~= nil then
        return l.systemTblData:GetOrder() < r.systemTblData:GetOrder()
    end

    return false
end

--region RedPoint

function LuaSystemPreviewInfoMgr:IsShowAllRedPoint()
    local tbl = self:GetSystemPerviewTbl()
    for i = 1, #tbl do
        if tbl[i].rewardType == LuaEnumGetAwardType.Get then
            return true
        end
    end
    return false
end

function LuaSystemPreviewInfoMgr:IsShowRedPointByTargetId(id)
    local tbl = self:GetSystemPerviewTbl()
    for i = 1, #tbl do
        if tbl[i].id == id then
            if tbl[i].rewardType == LuaEnumGetAwardType.Get then
                return true
            end
        end
    end
    return false
end
--endregion

return LuaSystemPreviewInfoMgr