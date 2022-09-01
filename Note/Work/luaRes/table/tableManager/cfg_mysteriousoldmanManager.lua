---@class cfg_mysteriousoldmanManager:TableManager
local cfg_mysteriousoldmanManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_mysteriousoldman
function cfg_mysteriousoldmanManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_mysteriousoldman> 遍历方法
function cfg_mysteriousoldmanManager:ForPair(action)
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
function cfg_mysteriousoldmanManager:PostProcess()
    self:InitData()
end

---@return LuaMysteriousExchangeOldManInfo
function cfg_mysteriousoldmanManager:GetMysteriousServerMgr()
    return gameMgr:GetPlayerDataMgr():GetLuaMysteriousExchangeOldManInfo()
end

---根据组规整数据
---@return table<number,{id:number,index:number}>
function cfg_mysteriousoldmanManager:GetTblByGroupDic()
    if self.mTblDicByGroup == nil then
        self.mTblDicByGroup = {}
    end
    return self.mTblDicByGroup
end

function cfg_mysteriousoldmanManager:InitData()
    ---@type TABLE.cfg_mysteriousoldman 此定义无含义，仅为了智能提示
    local tbl
    for i, v in pairs(self.dic) do
        tbl = v
        if self:GetTblByGroupDic()[tbl:GetGroup()] == nil then
            self:GetTblByGroupDic()[tbl:GetGroup()] = {}
        end
        table.insert(self:GetTblByGroupDic()[tbl:GetGroup()], {
            id = tbl:GetId(),
            index = tbl:GetIndex()
        })
    end

    ---排序
    for i, v in pairs(self:GetTblByGroupDic()) do
        table.sort(v, function(l, r)
            if l == nil or r == nil then
                return false
            end
            return l.index < r.index
        end)
    end
end

---@param targetTbl table<number,TABLE.cfg_mysteriousoldman>
function cfg_mysteriousoldmanManager:GetCurShowData(targetTbl)
    local count = 0
    ---@type TABLE.cfg_mysteriousoldman
    local tbl, isBreak, isMeet, resultType = nil, false, false, 0
    for k, v in pairs(self:GetTblByGroupDic()) do
        count = #v
        isBreak = false
        for i = 1, count do
            if not isBreak then
                tbl = self:TryGetValue(v[i].id)
                if tbl then
                    isMeet, resultType = self:GetMeetViewCondition(tbl)
                    if isMeet or (i == count and resultType ~= 1) then
                        table.insert(targetTbl, tbl)
                        ---每组仅需要一个
                        isBreak = true
                    end
                end
            end
        end
    end

    table.sort(targetTbl, function(l, r)
        if l == nil or r == nil then
            return false
        end
        return l:GetGroup() < r:GetGroup()
    end)
end

---@param tbl TABLE.cfg_mysteriousoldman
---@return boolean
---@return number type 0:异常 1：显示为满足 2：数量为满足
function cfg_mysteriousoldmanManager:GetMeetViewCondition(tbl)
    if tbl == nil then
        return false, 0
    end
    ---判断显示条件
    if tbl:GetShowLevel() and #tbl:GetShowLevel().list > 0 then
        local count = #tbl:GetShowLevel().list
        local result
        for i = 1, count do
            result = Utility.IsMainPlayerMatchCondition(tbl:GetShowLevel().list[i])
            if result == nil or not result.success then
                return false, 1
            end
        end
    end

    ---是否还有兑换次数
    if self:GetRemainCountById(tbl:GetId(), tbl:GetExchangeNum()) > 0 then
        return true
    end

    return false, 2
end

---获得此id剩余兑换数量(此处只能循环遍历，无法根据id取得信息)
---@return number
function cfg_mysteriousoldmanManager:GetRemainCountById(id, targetCount)
    ---@type table<number, roleV2.MysteriousExchangInfo>
    local tbl = self:GetMysteriousServerMgr():GetLuaMysteriousExchangeOldManInfo().info
    local count = #tbl
    for i = 1, count do
        if id == tbl[i].changId then
            return targetCount - tbl[i].changeNum
        end
    end
    return targetCount
end

return cfg_mysteriousoldmanManager