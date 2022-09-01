---@class cfg_activity_currentManager:TableManager
local cfg_activity_currentManager = {}

cfg_activity_currentManager.GroupData = nil

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_activity_current
function cfg_activity_currentManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_activity_current> 遍历方法
function cfg_activity_currentManager:ForPair(action)
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
function cfg_activity_currentManager:PostProcess()
    if self.GroupData == nil then
        self.GroupData = {}
        self.GroupToBookMarkInfo = {}
        self:ForPair(function(k, v)
            local group = v.group
            if group then
                local groupData = self.GroupData[group]
                if groupData == nil then
                    groupData = {}
                    self.GroupData[group] = groupData
                end

                local bookMarkType = v.clientType
                ---@type CurrentActivityBookMarkType
                local bookMarkData = groupData[bookMarkType]
                if bookMarkData == nil then
                    bookMarkData = {}
                    bookMarkData.mBookMarkName = v.name
                    bookMarkData.mOrder = v.order
                    bookMarkData.mAllId = {}
                    bookMarkData.mClientType = v.clientType
                    bookMarkData.mOpenPanel = v.panel
                    groupData[bookMarkType] = bookMarkData
                end
                table.insert(bookMarkData.mAllId, k)
            end
        end)
    end
end

---@return table<number,CurrentActivityBookMarkType> 每一个组对应的数据，里面是页签的table
function cfg_activity_currentManager:GetGroupData(group)
    if group and self.GroupData then
        return self.GroupData[group]
    end
end

return cfg_activity_currentManager