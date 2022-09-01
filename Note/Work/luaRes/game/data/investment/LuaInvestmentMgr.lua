---@class LuaInvestmentMgr 角色投资管理 调用示例 gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
local LuaInvestmentMgr = {}

---初始化
function LuaInvestmentMgr:Init()
    self:InitData()
end

---初始化数据
function LuaInvestmentMgr:InitData()
    ---投资期数字典
    local tableDic = clientTableManager.cfg_investManager:GetInvestTurmDic()
    if tableDic == nil then
        return
    end
    ---@type table<number,LuaInvestmentTurm> key  投资期数  value 同期数的所有数据
    self.TurmDic = {}
    for i, v in pairs(tableDic) do
        if self.TurmDic[i] == nil then
            self.TurmDic[i] = luaclass.LuaInvestmentTurm:New()
        end
        self.TurmDic[i]:InitTableData(v, i)
    end
end

---刷新所有数据
---@param data rechargeV2.ResInvestPlanData
function LuaInvestmentMgr:RefreshAllData(data)
    if data == nil or data.info == nil then
        return
    end
    if self.TurmDic == nil then
        return
    end
    self:RevertTurm()
    ---@type table<number, rechargeV2.ResInvestPlanInfo>
    local InvestPlanData = data.info
    for i, v in pairs(InvestPlanData) do
        if self.TurmDic[v.investPhase] ~= nil then
            self.TurmDic[v.investPhase]:RefreshData(true, v)
        end
    end
    self:RefreshOpenTurmList()
    self:UpdateRedData()
end

---刷新单个数据
---@param data rechargeV2.ResInvestPlanInfo
function LuaInvestmentMgr:RefreshSingleData(data)
    if data == nil then
        return
    end
    if self.TurmDic == nil then
        return
    end
    if self.TurmDic[data.investPhase] ~= nil then
        self.TurmDic[data.investPhase]:RefreshData(true, data)
    end
    self:RefreshOpenTurmList()
    self:UpdateRedData()
end

---还原投资期数开启数据
function LuaInvestmentMgr:RevertTurm()
    if self.TurmDic == nil then
        return
    end
    for i, v in pairs(self.TurmDic) do
        v:RefreshData(false)
    end
end

---得到单个期数
---@param Turm number
---@return LuaInvestmentTurm
function LuaInvestmentMgr:GetSingleInvestmentTurm(Turm)
    if self.TurmDic == nil or Turm == nil then
        return nil
    end
    return self.TurmDic[Turm]
end

---刷新开启的期数列表
function LuaInvestmentMgr:RefreshOpenTurmList()
    self.openDic = {}
    if self.TurmDic == nil then
        return nil
    end
    for i, v in pairs(self.TurmDic) do
        if v.IsOpenTurm == true then
            table.insert(self.openDic, v)
        end
    end
end

---得到首期数据
---@return LuaInvestmentTurm
function LuaInvestmentMgr:GetOneTurmDic()
    if self.openDic == nil or #self.openDic == 0 then
        return nil
    end
    return self.openDic[1]
end

---得到下一期数据
---@return LuaInvestmentTurm
function LuaInvestmentMgr:GetTwoTurmDic()
    if self.openDic == nil or #self.openDic == 0 then
        return nil
    end
    return self.openDic[2]
end

---更新红点数据
function LuaInvestmentMgr:UpdateRedData()
    self.IsOpenOneTurm = self:RefreshReceiveRedData(self:GetOneTurmDic())
    self.IsOpenTwoTurm = self:RefreshReceiveRedData(self:GetTwoTurmDic())
    self:CallRed()
end

---刷新可领取红点数据
---@param InvestmentTurm LuaInvestmentTurm
function LuaInvestmentMgr:RefreshReceiveRedData(InvestmentTurm)
    if InvestmentTurm == nil then
        return false
    end
    --if InvestmentTurm.isPurchased == 0 and InvestmentTurm.isStartSignRedData == nil then
    --    return true
    --end
    if InvestmentTurm.InvestmentItemDic ~= nil then
        for k, j in pairs(InvestmentTurm.InvestmentItemDic) do
            if j:IsCanReceive() then
                return true
            end
        end
    end
    return false
end

function LuaInvestmentMgr:CallRed()
    local Investment_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_All);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(Investment_All);
    local Investment_One = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_One);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(Investment_One);
    local Investment_Two = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Investment_Two);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(Investment_Two);
end

---是否显示指定红点
---@param type LuaRedPointName
function LuaInvestmentMgr:IsOpenRed(type)
    if type == LuaRedPointName.Investment_All then
        return self.IsOpenOneTurm or self.IsOpenTwoTurm
    elseif type == LuaRedPointName.Investment_One then
        return self.IsOpenOneTurm
    elseif type == LuaRedPointName.Investment_Two then
        return self.IsOpenTwoTurm
    end
    return false
end

---得到期数购买价格
---@param Turm number 期数
---@return number
function LuaInvestmentMgr:GetTurmBuyPrice(Turm)
    local TurmBuyPriceList = LuaGlobalTableDeal.GetInvestmentPriceList()
    if TurmBuyPriceList == nil then
        return 0
    end
    if TurmBuyPriceList[Turm] == nil then
        return 0
    end
    return TurmBuyPriceList[Turm]
end

return LuaInvestmentMgr