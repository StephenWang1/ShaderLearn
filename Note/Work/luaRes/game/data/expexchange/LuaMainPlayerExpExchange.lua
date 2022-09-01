---主角经验兑换
---@class LuaMainPlayerExpExchange:luaobject
local LuaMainPlayerExpExchange = {}

--region 配置数据
---@class ExpExchangeCost
---@alias conditionID number
---@field gearIndex number 兑换档位序号
---@field itemCost {itemID:number, count:number} 兑换所需的道具数量
---@field coinCost {itemID:number, count:number} 兑换所需的货币数量
---@field expGain {itemID:number, count:number} 兑换得到的经验
---@field conditions table<number, conditionID> 显示条件列表
---经验兑换列表
---@return table<number, ExpExchangeCost>
function LuaMainPlayerExpExchange:GetExpExchangeCostList()
    if self.mExpExchangeCostList == nil then
        self.mExpExchangeCostList = {}
    end
    return self.mExpExchangeCostList
end

---获取最大经验值
---@return number
function LuaMainPlayerExpExchange:GetMaxExp()
    return self.mMaxExp or 0
end

---获取最大兑换次数
---@return number
function LuaMainPlayerExpExchange:GetMaxExchangeTimes()
    return self.mMaxExchangeTimes or 0
end

---获取系统开启等级
---@return number
function LuaMainPlayerExpExchange:GetSystemOpenLevel()
    return self.mSystemOpenLevel or 0
end
--endregion

--region 服务器数据
---获取当前的角色经验兑换服务器数据
---@return roleV2.ResRoleExpAccumulate
function LuaMainPlayerExpExchange:GetCurrentRoleExpExchangeData()
    if self.mRoleExpExchangeData == nil then
        self.mRoleExpExchangeData = {
            hasCount = 0,
            hasCountSpecified = true,
            hasExp = 0,
            hasExpSpecified = true,
        }
    end
    return self.mRoleExpExchangeData
end
--endregion

--region 属性
---@return PlayerDataManager
function LuaMainPlayerExpExchange:GetOwner()
    return self.mOwner
end

---系统是否开启
---@return boolean
function LuaMainPlayerExpExchange:IsSystemOpened()
    return CS.CSScene.MainPlayerInfo.Level >= self:GetSystemOpenLevel()
end
--endregion

--region 初始化
---初始化
---@param playerDataMgr PlayerDataManager
function LuaMainPlayerExpExchange:Init(playerDataMgr)
    self.mOwner = playerDataMgr
    self:InitializeStaticData()
    self:GetOwner():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleExpAccumulateMessage, function(msgID, tblData)
        ---@type roleV2.ResRoleExpAccumulate
        self.mRoleExpExchangeData = tblData
        --print("ResRoleExpAccumulateMessage", "hasExp", self.mRoleExpExchangeData.hasExp, "hasCount", self.mRoleExpExchangeData.hasCount)
        luaEventManager.DoCallback(LuaCEvent.Role_ExpExchangeDataChanged)
        self:RecalculateRedPoint()
    end)
    self:GetOwner():GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RecalculateRedPoint()
    end)
    self:GetOwner():GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RecalculateRedPoint()
    end)
    CS.CSUIRedPointManager:GetInstance():RegisterLuaCallRedPointFunction(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange), function()
        return self:IsExpExchangeRedPointNeedShow()
    end)
end

---初始化静态数据
---@private
function LuaMainPlayerExpExchange:InitializeStaticData()
    ---经验兑换配置
    local exchangeCostExist, exchangeCostStr = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23000)
    if exchangeCostExist and exchangeCostStr and exchangeCostStr.value ~= nil then
        local exchangeCosts = string.Split(exchangeCostStr.value, '&')
        for i = 1, #exchangeCosts do
            local array = string.Split(exchangeCosts[i], '#')
            local arrayLength = #array
            if arrayLength >= 4 then
                ---@type ExpExchangeCost
                local expExchangeCost = {}
                expExchangeCost.gearIndex = tonumber(array[1])
                local arrayTemp1 = string.Split(array[2], '-')
                expExchangeCost.itemCost = { itemID = tonumber(arrayTemp1[1]), count = tonumber(arrayTemp1[2]) }
                local arrayTemp2 = string.Split(array[3], '-')
                expExchangeCost.coinCost = { itemID = tonumber(arrayTemp2[1]), count = tonumber(arrayTemp2[2]) }
                local arrayTemp3 = string.Split(array[4], '-')
                expExchangeCost.expGain = { itemID = tonumber(arrayTemp3[1]), count = tonumber(arrayTemp3[2]) }
                expExchangeCost.conditions = {}
                if arrayLength > 4 then
                    for j = 4, arrayLength do
                        table.insert(expExchangeCost.conditions, tonumber(array[j]))
                    end
                end
                table.insert(self:GetExpExchangeCostList(), expExchangeCost)
            end
        end
    end
    table.sort(self:GetExpExchangeCostList(), function(left, right)
        return left.gearIndex < right.gearIndex
    end)
    ---经验池存储上限
    local tbl1Exist, tbl1 = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22998)
    if tbl1Exist and tbl1 and tbl1.value then
        local array2 = string.Split(tbl1.value, '#')
        if #array2 >= 2 then
            self.mMaxExp = tonumber(array2[3])
        else
            self.mMaxExp = 0
        end
    else
        self.mMaxExp = 0
    end
    ---最大兑换次数
    local tbl2Exist, tbl2 = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22999)
    if tbl2Exist and tbl2 and tbl2.value then
        self.mMaxExchangeTimes = tonumber(tbl2.value)
    else
        self.mMaxExchangeTimes = 0
    end
    ---开放等级
    local tbl3Exist, tbl3 = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23001)
    if tbl3Exist and tbl3 and tbl3.value then
        self.mSystemOpenLevel = tonumber(tbl3.value)
    else
        self.mSystemOpenLevel = 0
    end
end
--endregion

--region 操作/判定方法
---请求兑换经验
---@param gear number 请求兑换的档位
---@alias errorlog string
---@return boolean, errorlog|nil
function LuaMainPlayerExpExchange:TryRequestExchangeExp(gear)
    if self:IsSystemOpened() == false then
        return false
    end
    local res, error = self:IsExchangeAvailable(gear)
    --print("TryRequestExchangeExp", gear, res, error)
    if res then
        networkRequest.ReqAddRoleExpByResources(gear)
    end
    return res, error
end

---兑换档位是否可兑换
---@param gear number 请求兑换的档位
---@alias errorlog string
---@return boolean, errorlog|nil
function LuaMainPlayerExpExchange:IsExchangeAvailable(gear)
    if gear == nil then
        return false
    end
    if self:IsSystemOpened() == false then
        return false
    end
    if self:GetCurrentRoleExpExchangeData() == nil then
        return false
    end
    if self:GetCurrentRoleExpExchangeData().hasCount <= 0 then
        return false, "兑换次数不足"
    end
    local list = self:GetExpExchangeCostList()
    for i = 1, #list do
        local temp = list[i]
        if temp.gearIndex == gear and temp.expGain ~= nil then
            if not self:IsExchangeGearShow(gear) then
                return false, "条件不满足"
            end
            if self:GetCurrentRoleExpExchangeData().hasExp < temp.expGain.count then
                return false, "经验值不足，无法兑换"
            end
            if temp.itemCost ~= nil and temp.itemCost.itemID ~= nil and temp.itemCost.count ~= nil and temp.itemCost.itemID > 0 then
                local itemCountInBag = self:GetOwner():GetMainPlayerBagMgr():GetItemCount(temp.itemCost.itemID)
                if itemCountInBag < temp.itemCost.count then
                    return false, "道具不足，无法兑换"
                end
            end
            if temp.coinCost ~= nil and temp.coinCost.itemID ~= nil and temp.coinCost.count ~= nil and temp.coinCost.itemID > 0 then
                local coinAmount = self:GetOwner():GetMainPlayerBagMgr():GetCoinAmount(temp.coinCost.itemID)
                if coinAmount < temp.coinCost.count then
                    return false, "货币不足，无法兑换"
                end
            end
            return true
        end
    end
    return false
end

---兑换档位是否显示
---@param gear number
---@return boolean
function LuaMainPlayerExpExchange:IsExchangeGearShow(gear)
    if gear == nil then
        return false
    end
    local list = self:GetExpExchangeCostList()
    local conditionMgr = CS.Cfg_ConditionManager.Instance
    for i = 1, #list do
        if list[i].gearIndex == gear then
            local conditionList = list[i].conditions
            if conditionList and #conditionList > 0 then
                for j = 1, #conditionList do
                    if not conditionMgr:IsMainPlayerMatchCondition(conditionList[j]) then
                        return false
                    end
                end
            end
            return true
        end
    end
    return false
end

function LuaMainPlayerExpExchange:RecalculateRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange), true)
end

---经验兑换红点是否需要显示
---@return boolean
function LuaMainPlayerExpExchange:IsExpExchangeRedPointNeedShow()
    if self:IsSystemOpened() == false then
        return false
    end
    for i = 1, #self:GetExpExchangeCostList() do
        if self:IsExchangeAvailable(self:GetExpExchangeCostList()[i].gearIndex) then
            return true
        end
    end
    return false
end
--endregion

--region update
function LuaMainPlayerExpExchange:OnUpdate()
    --if CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad1) then
    --    self:TryRequestExchangeExp(1)
    --elseif CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad2) then
    --    self:TryRequestExchangeExp(2)
    --elseif CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad3) then
    --    self:TryRequestExchangeExp(3)
    --elseif CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.Keypad4) then
    --    self:TryRequestExchangeExp(4)
    --end
end
--endregion

--region 析构
---销毁事件
---@public
function LuaMainPlayerExpExchange:OnDestroy()
    CS.CSUIRedPointManager:GetInstance():RemoveLuaCallRedPointFunctionByInt(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ExpExchange))
end
--endregion

return LuaMainPlayerExpExchange