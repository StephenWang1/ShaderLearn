---@class LuaForgeQuenchItemData:luaobject 淬炼数据对象
local LuaForgeQuenchItemData = {}

---淬炼表数据
---@return TABLE.cfg_cuilian
function LuaForgeQuenchItemData:GetForgeQuenchTbl()
    return self.mTemperTbl
end

---淬炼所需材料信息
---@return table<number,{itemID:number, count:number}>
function LuaForgeQuenchItemData:GetNeedMaterialInfo()
    if self.mNeedMaterialInfo == nil then
        self.mNeedMaterialInfo = {}
    end
    return self.mNeedMaterialInfo
end

---淬炼所需货币信息
---@return table<number,{itemID:number, count:number}>
function LuaForgeQuenchItemData:GetNeedCoinInfo()
    if self.mNeedCoinInfo == nil then
        self.mNeedCoinInfo = {}
    end
    return self.mNeedCoinInfo
end

---淬炼材料可替换的材料信息
---@return table<number,number>
function LuaForgeQuenchItemData:GetReplaceMaterialDic()
    if self.mReplaceMaterialDic == nil then
        self.mReplaceMaterialDic = {}
    end
    return self.mReplaceMaterialDic
end

---当前淬炼状态
---@return boolean
function LuaForgeQuenchItemData:IsCanForgeQuench()
    if self.mIsCanForgeQuench == nil then
        self.mIsCanForgeQuench = false
    end
    return self.mIsCanForgeQuench
end

---是否需要显示红点
---@return boolean
function LuaForgeQuenchItemData:IsNeedShowRedPoint()
    if LuaForgeQuenchItemData.mNeedShowRedPoint == nil then
        LuaForgeQuenchItemData.mNeedShowRedPoint = false
        if self:GetForgeQuenchTbl() ~= nil and self:GetForgeQuenchTbl():GetRedPoint() ~= nil then
            LuaForgeQuenchItemData.mNeedShowRedPoint = self:GetForgeQuenchTbl():GetRedPoint() == 1
        end
    end
    return LuaForgeQuenchItemData.mNeedShowRedPoint
end

---淬炼失败原因 1元宝不足 2材料不足
---@return number
function LuaForgeQuenchItemData:GetBeDefeateReason()
    if self.mBeDefeateReason == nil then
        self.mBeDefeateReason = 0
    end
    return self.mBeDefeateReason
end

---获取需要对比的装备位
---@return number
function LuaForgeQuenchItemData:GetEquipIndex()
    return self.equipIndex
end

function LuaForgeQuenchItemData:GetMainMaterialItemId()
    return self.mainMaterial
end

---@param tbl TABLE.cfg_cuilian
---@protected
function LuaForgeQuenchItemData:Init(tbl)
    self.mTemperTbl = tbl
    self:InitForgeQuenchData()
    self:RefreshTemperState()
end

function LuaForgeQuenchItemData:InitForgeQuenchData()
    local tbl = self:GetForgeQuenchTbl()
    if tbl == nil then
        return
    end
    self.mainMaterial = tbl:GetItemid()
    table.insert(self:GetNeedMaterialInfo(), { itemID = tbl:GetItemid(), count = 1 })
    self:ForeachItemIdIntList(tbl:GetItemid2(), tbl:GetNumber(), self:GetNeedMaterialInfo())
    self:ForeachItemIdIntList(tbl:GetCurrency(), {}, self:GetNeedCoinInfo(), 1)
    self:ForeachReplaceItemIdIntList(tbl:GetReplaceItemid(), tbl:GetItemid2(), self:GetReplaceMaterialDic())
end

---刷新淬炼状态
---@public
function LuaForgeQuenchItemData:RefreshTemperState()
    local curState = self:IsCanForgeQuenchFunc()
    if curState ~= self.mIsCanForgeQuench and self:GetForgeQuenchTbl() ~= nil then
        self.mIsCanForgeQuench = curState
        luaEventManager.DoCallback(LuaCEvent.ForgeQuenchStateChanged,
                {
                    id = self:GetForgeQuenchTbl():GetId(),
                    page = self:GetForgeQuenchTbl():GetTabType(),
                    state = curState
                })
    end
end

---@param targetIntList
---@param resultTbl
---@param numIntList
---@param type  other:正常遍历  1：取余
---@return table<number,{itemID:number,count:number}>
function LuaForgeQuenchItemData:ForeachItemIdIntList(targetIntList, numIntList, resultTbl, type)
    if targetIntList == nil or resultTbl == nil or numIntList == nil then
        return
    end
    if targetIntList.list == nil then
        return
    end
    local tbl = {}
    local count = #targetIntList.list
    for i = 1, count do
        if type == 1 and i % 2 ~= 0 and i + 1 <= count then
            tbl = {
                itemID = targetIntList.list[i],
                count = targetIntList.list[i + 1]
            }
        elseif numIntList.list ~= nil and numIntList.list[i] ~= nil then
            tbl = {
                itemID = targetIntList.list[i],
                count = numIntList.list[i]
            }
        end
        table.insert(resultTbl, tbl)
    end
end

---@param targetIntList
---@param resultDic
---@param replaceIntList
---@return table<number,{itemID:number,count:number}>
function LuaForgeQuenchItemData:ForeachReplaceItemIdIntList(targetIntList, replaceIntList, resultDic)
    if targetIntList == nil or replaceIntList == nil or resultDic == nil then
        return
    end
    if targetIntList.list == nil or replaceIntList.list == nil then
        return
    end
    local count, key, value = #targetIntList.list, 0, 0
    for i = 1, count do
        if targetIntList.list[i] ~= nil then
            key = targetIntList.list[i]
            value = replaceIntList.list[i]
            table.insert(resultDic[key], value)
        end
    end
end

---判断可淬炼逻辑
---@return boolean
function LuaForgeQuenchItemData:IsCanForgeQuenchFunc()

    ---是否满足显示
    if not self:IsShow() then
        return false
    end

    --- 判断货币
    local count = #self:GetNeedCoinInfo()
    if count > 0 then
        for i = 1, count do
            local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self:GetNeedCoinInfo()[i].itemID)
            if curCount < self:GetNeedCoinInfo()[i].count then
                self.mBeDefeateReason = 1
                return false
            end
        end
    end

    --- 判断材料
    count = #self:GetNeedMaterialInfo()
    if count > 0 then
        for i = 1, count do
            ---当前材料是否满足
            if not self:IsMeetConditionByMaterialInfo(self:GetNeedMaterialInfo()[i]) then
                self.mBeDefeateReason = 2
                return false
            end
        end
    end

    return true
end

---材料是否符合条件
---@param info {itemID:number, count:number}
---@return boolean
function LuaForgeQuenchItemData:IsMeetConditionByMaterialInfo(info)

    if info == nil then
        return false
    end

    ---当前材料是否满足
    local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(info.itemID, nil, function(bagItemInfo)
        return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
    end)
    ---判断身上是否穿戴此材料
    local isWearing = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsWearingEquipByItemId(info.itemID, function(bagItemInfo)
        return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
    end)
    curCount = isWearing and curCount + 1 or curCount

    if curCount >= info.count then
        return true
    end

    ---当前材料不满足，查看是否有可替代物品
    local repliceItemId = self:GetReplaceMaterialDic()[info.itemID]
    if repliceItemId then
        local repliceCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(repliceItemId)
        if curCount + repliceCount >= info.count then
            return true
        end
    end

    return false
end

---是否显示到淬炼列表
---@return boolean
function LuaForgeQuenchItemData:IsShow()

    local tbl = self:GetForgeQuenchTbl()
    if tbl == nil then
        return false
    end

    ---判断是否满足condition
    if tbl:GetCondition() ~= nil then
        local result = Utility.IsMainPlayerMatchCondition_LuaAndCS(tbl:GetCondition())
        if result == nil or not result.success then
            return false
        end
    end
    ---判断是否需要检测身上物品

    if tbl:GetEquipItem() ~= nil and tbl:GetEquipItem().list ~= nil then
        local count = #tbl:GetEquipItem().list
        local equipItemId, equipIndexCount, medalBagItemInfo
        local forgeQuenchMgr, result = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr(), nil
        for i = 1, count do
            if i % 2 ~= 0 and i + 1 <= count then
                self.equipIndex = tbl:GetEquipItem().list[i]
                equipItemId = tbl:GetEquipItem().list[i + 1]
                result = forgeQuenchMgr:GetOtherEquipIndexDic()[self.equipIndex]
                if result and #result then
                    equipIndexCount = #result
                    for i = 1, equipIndexCount do
                        ---@type bagV2.BagItemInfo
                        medalBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(result[i])
                        if medalBagItemInfo ~= nil and medalBagItemInfo.ItemTABLE ~= nil and medalBagItemInfo.ItemTABLE.id == equipItemId then
                            return true
                        end
                    end
                else
                    ---@type bagV2.BagItemInfo
                    medalBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(self.equipIndex)
                    if medalBagItemInfo ~= nil and medalBagItemInfo.ItemTABLE ~= nil and medalBagItemInfo.ItemTABLE.id == equipItemId then
                        return true
                    end
                end
            end
        end
    end

    ---判断背包中是否含有此物品
    if tbl:GetBagItem() ~= nil and tbl:GetBagItem().list ~= nil then
        local count = #tbl:GetBagItem().list
        for i = 1, count do
            local curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(tbl:GetBagItem().list[i])
            if curCount == 0 then
                return false
            end
        end
    end
    return true
end

---获取淬炼材料当前的数量(根据淬炼规则)
---@return number
function LuaForgeQuenchItemData:GetForgeQuenchMaterialCurCount(itemId)
    if itemId == nil then
        return 0
    end

    local curCount, repliceCount = 0, 0
    ---当前材料是否满足
    curCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(itemId, nil, function(itemInfo)
        return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(itemInfo)
    end)
    ---判断身上是否穿戴此材料
    local wearingCount = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetWearingEquipCountByItemId(itemId, function(itemInfo)
        return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(itemInfo)
    end)
    curCount = curCount + wearingCount
    local repliceItemId = self:GetReplaceMaterialDic()[itemId]
    if repliceItemId then
        repliceCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndCurCoinMoneyCount(repliceItemId, nil, function(itemInfo)
            return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(itemInfo)
        end)
    end
    return curCount, repliceCount
end

return LuaForgeQuenchItemData