---@class LuaInvestmentItem 角色投资Item
local LuaInvestmentItem = {}

---刷新数据
---@param se_Data rechargeV2.Reward
function LuaInvestmentItem:RefreshServerData(se_Data)
    if se_Data == nil then
        return
    end
    ---状态 1已领 0未领 2可领
    self.state = se_Data.state;
    self.TableID = 1;
end

---是否可用领取
function LuaInvestmentItem:IsCanReceive()
    if self.state == 2 then
        return true
    end
    return false
end

---刷新数据
---@param tabeldata TABLE.cfg_invest
function LuaInvestmentItem:RefreshTableData(tabeldata)
    self.mInvestmentTable = tabeldata
    if self.mInvestmentTable ~= nil then
        self.TableID = self.mInvestmentTable:GetId()
    end
end

---重置数据
function LuaInvestmentItem:RevertData()
    self.state = nil;
    self.TableID = nil;
end

---投资数据表
---@return TABLE.cfg_invest
function LuaInvestmentItem:GetInvestmentTable()
    if self.mInvestmentTable == nil then
        self.mInvestmentTable = clientTableManager.cfg_investManager:TryGetValue(self.TableID)
    end
    return self.mInvestmentTable
end

function LuaInvestmentItem:GetOrder()
    local order = 0
    if self:GetInvestmentTable() ~= nil then
        order = order + self:GetInvestmentTable():GetOrder()
    end
    if self.state == 1 and self:IsRelationTableReceived() then
        order = order + 1000
    end
    return order
end

---得到显示描述
function LuaInvestmentItem:GetShowDes()
    if self:GetInvestmentTable() == nil then
        return ""
    end
    local str = self:GetInvestmentTable():GetDescription()
    return string.CSFormat(str, tostring(self:GetInvestmentTable():GetRewardCondition()))
end

---得到奖励列表
---@return table<number,InvestmentRewardData>
function LuaInvestmentItem:GetRewardList()
    if self:GetInvestmentTable() == nil then
        return nil
    end
    local str = self:GetInvestmentTable():GetReward()
    if str == nil or str == "" then
        return nil
    end
    local RewardDataDic = {}
    local playerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local playerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local itemList = string.Split(str, "&")
    for i, v in pairs(itemList) do
        local tempList = string.Split(v, "#")
        if #tempList == 4 then
            local _itemID = tonumber(tempList[1])
            local _count = tonumber(tempList[2])
            local _career = tonumber(tempList[3])
            local _sex = tonumber(tempList[4])
            if (_career == 0 or _career == playerCareer) and (_sex == 0 or _sex == playerSex) then
                ---@class InvestmentRewardData
                local InvestmentRewardData = {
                    ---道具ID
                    itemID = _itemID,
                    ---数量
                    count = _count,
                    ---职业
                    career = _career,
                    ---性别
                    sex = _sex,
                }
                table.insert(RewardDataDic, InvestmentRewardData)
            end
        end
    end
    return RewardDataDic
end

---得到开启状态
function LuaInvestmentItem:GetActive()
    return self.Active
end

---设置关联Table
function LuaInvestmentItem:SetRelationTable(relationtable)
    ---@type LuaInvestmentItem
    self.relationtable = relationtable
end

---关联数据是否已经领取过
---@return boolean
function LuaInvestmentItem:IsRelationTableReceived()
    if self.relationtable == nil then
        return false
    end
    if self.relationtable.state == 1 then
        return true
    end
    return false
end

return LuaInvestmentItem
