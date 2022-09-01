---@class cfg_memberManager:TableManager
local cfg_memberManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_member
function cfg_memberManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_member> 遍历方法
function cfg_memberManager:ForPair(action)
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
function cfg_memberManager:PostProcess()
end

---@class MemberRecycleAddition 会员回收收益加成
---@field itemId number 道具id
---@field addition number 加成值

---获取回收收益加成列表
---@param id number 会员表id
---@return table<MemberRecycleAddition> 收益加成列表
function cfg_memberManager:GetMemberRecycleAdditionList(id)
    if type(id) ~= 'number' then
        return
    end
    local memberTbl = self:TryGetValue(id)
    if memberTbl == nil or memberTbl:GetRecAdd() == nil or memberTbl:GetRecAdd().list == nil or Utility.GetLuaTableCount(memberTbl:GetRecAdd().list) <= 0 then
        return
    end
    local memberRecycleAdditionList = {}
    for k,v in pairs(memberTbl:GetRecAdd().list) do
        local itemIdAndAddition = v.list
        if itemIdAndAddition ~= nil and Utility.GetLuaTableCount(itemIdAndAddition) > 1 then
            ---@type MemberRecycleAddition
            local memberRecycleAddition = {}
            memberRecycleAddition.itemId = itemIdAndAddition[1]
            memberRecycleAddition.addition = itemIdAndAddition[2] / 10000
            table.insert(memberRecycleAdditionList,memberRecycleAddition)
        end
    end
    return memberRecycleAdditionList
end

---获取回收收益指定道具的加成
---@param id number 会员表id
---@param itemId number 道具id
---@return MemberRecycleAddition
function cfg_memberManager:GetMemberRecycleAddition(id,itemId)
    if type(id) ~= 'number' or type(itemId) ~= 'number' then
        return
    end
    local recycleAdditionList = self:GetMemberRecycleAdditionList(id)
    if recycleAdditionList == nil then
        return
    end
    for k,v in pairs(recycleAdditionList) do
        ---@type MemberRecycleAddition
        local recycleAddition = v
        if recycleAddition.itemId == itemId then
            return recycleAddition
        end
    end
end

---获取会员最大等级
---@return number
function cfg_memberManager:GetMaxLevel()
    local maxLevel = 0
    if self.dic then
        for i, v in pairs(self.dic) do
            if v:GetId() > maxLevel then
                maxLevel = v:GetId()
            end
        end
    end
    return maxLevel
end

return cfg_memberManager