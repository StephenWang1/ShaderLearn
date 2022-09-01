---@class cfg_guidebookManager:TableManager
local cfg_guidebookManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_guidebook
function cfg_guidebookManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_guidebook> 遍历方法
function cfg_guidebookManager:ForPair(action)
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
function cfg_guidebookManager:PostProcess()
end

---获取所有表数据
function cfg_guidebookManager:GetAllData()
    local mAllData = {}
    self:ForPair(function(k, v)
        ---@type TABLE.cfg_guidebook
        local tbl = v
        if self:CanShowTab(tbl:GetId()) then
            table.insert(mAllData, v)
        end
    end)
    mAllData = self:SortTable(mAllData)
    return mAllData
end

---@return boolean 是否可以显示页签
function cfg_guidebookManager:CanShowTab(id)
    local guideBookTbl = self:TryGetValue(id)
    if guideBookTbl ~= nil and guideBookTbl:GetConditionId() ~= nil and guideBookTbl:GetConditionId().list ~= nil then
        if id == 8 then
            if clientTableManager.cfg_vip_zunxiangManager:CanShowPlatformVipZunXiangPanel() == false then
                return false
            end
        end
        return Utility.IsMainPlayerMatchConditionList_AND(guideBookTbl:GetConditionId().list).success
    end
    return true
end

---@param curTable table<TABLE.cfg_guidebook>
---@return table<TABLE.cfg_guidebook>
function cfg_guidebookManager:SortTable(curTable)
    if type(curTable) == 'table' and Utility.GetLuaTableCount(curTable) > 0 then
        table.sort(curTable,function(guideTbl1,guideTbl2)
            ---@type TABLE.cfg_guidebook
            local curGuitbl1 = guideTbl1
            ---@type TABLE.cfg_guidebook
            local curGuitbl2 = guideTbl2
            return curGuitbl1:GetOrder() < curGuitbl2:GetOrder()
        end)
    end
    return curTable
end

return cfg_guidebookManager