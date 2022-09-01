---主角使用经验丹行为
------@class LuaMainPlayerUseExpProp:luaobject
local LuaMainPlayerUseExpProp = {}

---@class ExpPropMultipleUseInfo
---@alias ItemID number
---@field exppropitemid ItemID 经验丹道具ID
---@field exchangelist table<number, ExpPropSingleUseInfo> 兑换列表

---@class ExpPropSingleUseInfo
---@field multiple number 兑换倍数
---@field gainExp number 兑换倍数x经验丹经验值
---@field coinitemid number 消耗的货币物品ID
---@field coincount number 消耗的货币数量
---@field showconditions table<number, number> 按钮展示条件(或关系)

---获取配置的经验丹多倍使用数据
---@return table<number, ExpPropMultipleUseInfo>
function LuaMainPlayerUseExpProp:GetExpPropMultipleInfoConfigList()
    if self.mExpPropMultipleInfoList == nil then
        ---@type table<number, ExpPropMultipleUseInfo>
        self.mExpPropMultipleInfoList = {}
        clientTableManager.cfg_exppropManager:ForPair(function(id, tbl)
            ---@type ExpPropMultipleUseInfo
            local multipleUseInfo = nil
            for i = 1, #self.mExpPropMultipleInfoList do
                if self.mExpPropMultipleInfoList[i].exppropitemid == tbl:GetItemId() then
                    multipleUseInfo = self.mExpPropMultipleInfoList[i]
                    break
                end
            end
            if multipleUseInfo == nil then
                multipleUseInfo = {}
                multipleUseInfo.exppropitemid = tbl:GetItemId()
                multipleUseInfo.exchangelist = {}
                table.insert(self.mExpPropMultipleInfoList, multipleUseInfo)
            end
            ---@type ExpPropSingleUseInfo
            local singleUseInfo = {}
            singleUseInfo.multiple = tbl:GetMultiple()
            local coinitemid = 0
            local coincount = 0
            local strs = string.Split(tbl:GetGoal(), '#')
            if #strs > 1 then
                coinitemid = tonumber(strs[1])
                coincount = tonumber(strs[2])
            end
            singleUseInfo.coinitemid = coinitemid
            singleUseInfo.coincount = coincount
            local gainExp = 0
            local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(tbl:GetItemId())
            if itemTbl ~= nil and itemTbl:GetUseParam() ~= nil and itemTbl:GetUseParam().list ~= nil and itemTbl:GetUseParam().list.Count > 0 then
                local singleExpAmount = itemTbl:GetUseParam().list[0]
                gainExp = singleExpAmount * tbl:GetMultiple()
            end
            singleUseInfo.gainExp = gainExp
            singleUseInfo.showconditions = {}
            local strs2 = string.Split(tbl:GetCondition(), '#')
            if #strs2 >= 1 then
                for i = 1, #strs2 do
                    table.insert(singleUseInfo.showconditions, tonumber(strs2[i]))
                end
            end
            table.insert(multipleUseInfo.exchangelist, singleUseInfo)
        end)
    end
    return self.mExpPropMultipleInfoList
end

function LuaMainPlayerUseExpProp:GetOwner()
    return self.mOwner
end

---@param owner PlayerDataManager
function LuaMainPlayerUseExpProp:Init(owner)
    self.mOwner = owner
end

---@class ExpPropUseInfo
---@field exppropitemid number 经验丹道具itemID
---@field expamount number 经验值
---@field usednumbertoday number 当天使用数量
---@field maxusenumber number 每天最大使用数量
---@field limitlevel number 使用限制等级
---获取经验丹的信息
---@param bagItem bagV2.BagItemInfo 背包物品数据
---@return ExpPropUseInfo
function LuaMainPlayerUseExpProp:GetExpPropInfo(bagItem)
    if bagItem == nil then
        return nil
    end
    local itemID = bagItem.itemId
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
    if itemTbl == nil or itemTbl:GetType() ~= 3 or itemTbl:GetSubType() ~= 4 then
        return nil
    end
    ---@type ExpPropUseInfo
    local tbl = {}
    local usedAmountToday, maxUseAmount = self:GetOwner():GetMainPlayerBagMgr():GetItemUseCountLimit(bagItem)
    tbl.usednumbertoday = usedAmountToday or 0
    tbl.maxusenumber = maxUseAmount or 0
    --print(itemID, usedAmountToday, maxUseAmount)
    tbl.exppropitemid = itemID
    if itemTbl:GetUseParam() ~= nil and itemTbl:GetUseParam().list ~= nil and itemTbl:GetUseParam().list.Count > 0 then
        tbl.expamount = itemTbl:GetUseParam().list[0]
    else
        tbl.expamount = 0
    end
    tbl.limitlevel = itemTbl:GetUseLimit()
    return tbl
end

---获取多倍使用经验的配置数据
---@return ExpPropMultipleUseInfo
function LuaMainPlayerUseExpProp:GetExpPropMultipleUseConfigInfo(itemID)
    local list = self:GetExpPropMultipleInfoConfigList()
    for i = 1, #list do
        if list[i].exppropitemid == itemID then
            return list[i]
        end
    end
    return nil
end

---是否需要打开UIExpItemPanel界面来选择使用经验丹的
---@param useItemRequest bagV2.UseItemRequest
---@return boolean 是否需要打开UIExpItemPanel界面
function LuaMainPlayerUseExpProp:IsNeedOpenExpItemPanel(useItemRequest)
    if useItemRequest == nil then
        return false
    end
    if useItemRequest.clientParam ~= nil and useItemRequest.clientParam ~= 0 then
        --clientParam不为0则表示已经处理过了,不进行判定
        return false
    end
    local bagItemLid = useItemRequest.itemId
    local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(bagItemLid)
    if bagItem == nil then
        return false
    end
    local multipleUseInfo = self:GetExpPropMultipleUseConfigInfo(bagItem.itemId)
    if multipleUseInfo == nil then
        return false
    end
    local expPropUseInfo = self:GetExpPropInfo(bagItem)
    if expPropUseInfo == nil then
        return false
    end
    return true
end

---请求多倍使用经验丹
---@param expPropLid number 经验丹的物品lid
---@param multiple number 兑换倍数
function LuaMainPlayerUseExpProp:RequestMultipleUseExpProp(expPropLid, multiple)
    if gameMgr:GetPlayerDataMgr() == nil or gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr() == nil then
        return
    end
    local bagItem = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(expPropLid)
    if bagItem == nil or bagItem.itemId == nil then
        return
    end

end

return LuaMainPlayerUseExpProp