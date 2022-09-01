---@class LuaInvestmentTurm 角色投资期数
local LuaInvestmentTurm = {}

---是否是首次红点亮起
LuaInvestmentTurm.isStartSignRedData = nil
---初始化投资期数表格数据
---@param tabelList table<number,TABLE.cfg_invest>
function LuaInvestmentTurm:InitTableData(tabelList, turm)
    self.tabelList = tabelList
    if tabelList == nil then
        return nil
    end
    ---期数
    self.turm = turm
    ---@type table<number,table<number,LuaInvestmentItem>>
    self.TypeDic = {}
    ---@type table<number,LuaInvestmentItem> key 表格ID
    self.InvestmentItemDic = {}
    ---是否开启本次投资
    self.IsOpenTurm = false
    for i, v in pairs(self.tabelList) do
        if self.TypeDic[v:GetRewardType()] == nil then
            self.TypeDic[v:GetRewardType()] = {}
        end
        ---@type LuaInvestmentItem
        local investmentItem = luaclass.LuaInvestmentItem:New()
        investmentItem:RefreshTableData(v)
        table.insert(self.TypeDic[v:GetRewardType()], investmentItem)
        self.InvestmentItemDic[v:GetId()] = investmentItem
    end
    self:InitRelationInfo()
end

---初始化关联数据
function LuaInvestmentTurm:InitRelationInfo()
    if self.InvestmentItemDic == nil then
        return
    end
    for i, v in pairs(self.InvestmentItemDic) do
        if v:GetInvestmentTable() ~= nil then
            local relationTable = self.InvestmentItemDic[v:GetInvestmentTable():GetLink()]
            v:SetRelationTable(relationTable)
        end
    end
end

---刷新数据
---@param IsOpenTurm boolean
---@param se_investPlanInfo rechargeV2.ResInvestPlanInfo
function LuaInvestmentTurm:RefreshData(IsOpenTurm, se_investPlanInfo)
    self.IsOpenTurm = IsOpenTurm
    if IsOpenTurm == false or IsOpenTurm == nil then
        return
    end
    if se_investPlanInfo == nil or se_investPlanInfo.rewards == nil then
        return
    end
    if self.InvestmentItemDic == nil then
        return
    end
    ---@type table<number, rechargeV2.Reward>
    local se_rewards = se_investPlanInfo.rewards
    ---是否已购买 0非购买 1已购买
    self.isPurchased = se_investPlanInfo.isPurchased
    ---结束倒计时
    self.endTime = se_investPlanInfo.endTime
    for i, v in pairs(se_rewards) do
        if self.InvestmentItemDic[v.id] ~= nil then
            self.InvestmentItemDic[v.id]:RefreshServerData(v)
        end
    end
end

---得到单个类型的数据列表
function LuaInvestmentTurm:GetSingleTypeList(type)
    if self.TypeDic == nil or type == nil then
        return nil
    end
    if self.TypeDic[type] == nil then
        return nil
    end
    return self.TypeDic[type]
end

---类型列表排序
---@param tableList table<number,LuaInvestmentItem>
---@return table<number,LuaInvestmentItem>
function LuaInvestmentTurm:InvestmentItemListSort(tableList)
    if tableList == nil then
        return
    end
    table.sort(tableList, function(l, r)
        return l:GetOrder() < r:GetOrder()
    end)
    return tableList
end

---期数名字
---@return string
function LuaInvestmentTurm:GetTurmName()
    if self.InvestmentItemDic == nil then
        return ""
    end
    for i, v in pairs(self.InvestmentItemDic) do
        if v:GetInvestmentTable() ~= nil then
            return v:GetInvestmentTable():GetName()
        end
    end
    return ""

end

return LuaInvestmentTurm