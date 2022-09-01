---@class ItemRecycleEarning:luaobject 单个背包物品回收收益数据
local ItemRecycleEarning = {}

---@class RecycleEarning 回收收益
---@field itemId number 收益物品Id
---@field baseNumber number 基础单个收益数量
---@field curNumber number 实际单个收益数量
---@field recycleAdditionList table<RecycleAddition> 收益加成列表
---@field EarningMultiples number 收益倍数（比如背包物品，则倍数是背包物品的叠加数量）
---@field curTotalNumber number 实际总收益

---@class RecycleAddition 收益加成
---@field additionType LuaEnumRecycleAdditionType 收益加成类型
---@field addValue number 加成量
---@field des string 收益加成描述内容

---@type number 道具Id
ItemRecycleEarning.itemId = nil
---@type TABLE.cfg_items 道具表
ItemRecycleEarning.itemTbl = nil
---@type table<RecycleEarning> 回收收益列表
ItemRecycleEarning.RecycleBaseEarningList = nil
---@type bagV2.BagItemInfo 背包数据
ItemRecycleEarning.bagItemInfo = nil

--region 通用解析
---通过bagItemInfo解析回收收益
---@param bagItemInfo bagV2.BagItemInfo
function ItemRecycleEarning:AnalysisRecycleEarningByBagItemInfo(bagItemInfo)
    if bagItemInfo ~= nil then
        local analysisState = self:AnalysisRecycleEarning(bagItemInfo.itemId)
        if analysisState == true and type(self.RecycleBaseEarningList) == 'table' and Utility.GetLuaTableCount(self.RecycleBaseEarningList) > 0 then
            for k,v in pairs(self.RecycleBaseEarningList) do
                ---@type RecycleEarning
                local recycleEarning = v
                recycleEarning.EarningMultiples = bagItemInfo.count
                if recycleEarning.EarningMultiples <= 0 then
                    recycleEarning.EarningMultiples = 1
                end
                recycleEarning.curTotalNumber = recycleEarning.EarningMultiples * recycleEarning.curNumber
            end
            return true
        end
    end
    return false
end

---解析回收收益
---@param itemId number
---@return boolean 解析状态
function ItemRecycleEarning:AnalysisRecycleEarning(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    self.itemId = itemId
    self.itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.itemId)
    if self.itemTbl == nil then
        return false
    end
    local haveEarning,recycleEarningDic = CS.Cfg_ItemsTableManager.Instance:TryGetFixedRecycleEarning(self.itemId)
    if haveEarning == false or recycleEarningDic == nil or recycleEarningDic.Count <= 0 then
        return false
    end
    self.RecycleBaseEarningList = self:AnalysisRecycleEarningDic(recycleEarningDic)
    if type(self.RecycleBaseEarningList) ~= 'table' or Utility.GetLuaTableCount(self.RecycleBaseEarningList) <= 0 then
        return false
    end
    return true
end
--endregion

---解析回收收益字典
---@param recycleEarningDic System.Collections.Generic.Dictionary2System.UInt32System.Int32
---@return table<RecycleEarning>
function ItemRecycleEarning:AnalysisRecycleEarningDic(recycleEarningDic)
    ---@type table<number,number>
    local recycleEarningTable = Utility.CSDicChangeTable(recycleEarningDic)
    local curRecycleEarningTable = {}
    for k,v in pairs(recycleEarningTable) do
        ---@type RecycleEarning 回收收益
        local recycleEarning = {}
        local itemId = k
        local count = v
        recycleEarning.itemId = itemId
        recycleEarning.baseNumber = count
        recycleEarning.recycleAdditionList = self:GetRecycleAdditionTable(itemId)
        recycleEarning.curNumber = self:GetCurRecycleEarning(recycleEarning.baseNumber,recycleEarning.recycleAdditionList)
        recycleEarning.EarningMultiples = 1
        recycleEarning.curTotalNumber = recycleEarning.EarningMultiples * recycleEarning.curNumber
        table.insert(curRecycleEarningTable,recycleEarning)
    end
    return curRecycleEarningTable
end

---获取回收收益加成列表
---@param itemId number 道具表id
---@return table<RecycleAddition> 回收收益加成列表
function ItemRecycleEarning:GetRecycleAdditionTable(itemId)
    local recycleAdditionTable = {}
    --会员收益
    local memberRecycleAddition = self:GetMemberRecycleAddition(itemId)
    if memberRecycleAddition ~= nil then
        table.insert(recycleAdditionTable,memberRecycleAddition)
    end
    --点金buff收益
    local dianJinBuffRecycleAddition = self:GetBuffRecycleAddition(itemId,10400001)
    if dianJinBuffRecycleAddition ~= nil then
        table.insert(recycleAdditionTable,dianJinBuffRecycleAddition)
    end
    return recycleAdditionTable
end

---获取具体的回收收益
---@param baseEarning number
---@param recycleAdditionTable table<RecycleAddition>
function ItemRecycleEarning:GetCurRecycleEarning(baseEarning,recycleAdditionTable)
    if type(baseEarning) ~= 'number' then
        return 0
    end
    if type(recycleAdditionTable) ~= 'table' or Utility.GetLuaTableCount(recycleAdditionTable) <= 0 then
        return baseEarning
    end
    local curEarning = baseEarning
    for k,v in pairs(recycleAdditionTable) do
        ---@type RecycleAddition
        local recycleAddtion = v
        curEarning = curEarning + baseEarning * recycleAddtion.addValue
    end
    return curEarning
end

--region 回收收益加成
---会员获取道具回收收益加成
---@param itemId number 道具表id
---@return RecycleAddition 回收收益
function ItemRecycleEarning:GetMemberRecycleAddition(itemId)
    local playerMemberTbl = gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():GetMemberTbl()
    if playerMemberTbl == nil then
        return
    end
    ---@type RecycleAddition
    local recycleAddition = {}
    local memberRecycleAddition = clientTableManager.cfg_memberManager:GetMemberRecycleAddition(playerMemberTbl:GetId(),itemId)
    if memberRecycleAddition == nil then
        return
    end
    recycleAddition.additionType = LuaEnumRecycleAdditionType.Member
    recycleAddition.addValue = memberRecycleAddition.addition
    recycleAddition.des = string.format(luaEnumColorType.Green .. "会员加成+%s%%",tostring(Utility.RemoveEndZero(recycleAddition.addValue * 100)))
    return recycleAddition
end

---buff回收加成
---@param itemId number 道具表id
---@param buffId number buff表id
---@return RecycleAddition 回收收益
function ItemRecycleEarning:GetBuffRecycleAddition(itemId,buffId)
    if type(itemId) ~= 'number' or type(buffId) ~= 'number' then
        return
    end
    ---@type boolean,CSBuffInfoItem
    local haveBuff,buffInfoClass = CS.CSScene.MainPlayerInfo.BuffInfo:IsHasBuffAndOutInfo(buffId)
    if haveBuff == false then
        return
    end
    ---@type TABLE.CFG_BUFF
    local buffTbl = buffInfoClass.tbl_buff
    if buffTbl == nil then
        return
    end
    local buffParams = buffTbl.parameter.list
    if buffParams == nil or buffParams.Count <= 0 or buffParams.Count % 2 > 0 then
        return
    end
    local length = buffParams.Count
    for k = 0,length - 1 do
        local remainder = k % 2
        if remainder == 0 then
            local curItemId = buffParams[k]
            local additionValue = buffParams[k + 1]
            if curItemId == itemId then
                ---@type RecycleAddition
                local recycleAddition = {}
                recycleAddition.additionType = LuaEnumRecycleAdditionType.Buff
                recycleAddition.addValue = additionValue / 10000
                recycleAddition.des = string.format(luaEnumColorType.Green .. buffTbl.name .. "+%s%%",tostring(Utility.RemoveEndZero(recycleAddition.addValue * 100)))
                return recycleAddition
            end
        end
    end
end
--endregion
return ItemRecycleEarning