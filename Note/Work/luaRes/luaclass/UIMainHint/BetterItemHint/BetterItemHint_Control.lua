local BetterItemHint_Control = {}
--region 通用数据
---延迟自动使用物品表
---@type table<table>
BetterItemHint_Control.DelayAutoUseItemListUpdateTable = {}

---@private
function BetterItemHint_Control:GetCSBagItemHint()
    return CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
end
--endregion

--region 自动穿装备
--region 对外方法
---@public
---尝试自动使用提示物品
---@return 是否成功触发自动使用
function BetterItemHint_Control:TryAutoUseHintItems(hintType)
    local autoUseHintItemTableInfo = self:GetHintAutoUseItemTableInfo(hintType)
    if autoUseHintItemTableInfo ~= nil and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(autoUseHintItemTableInfo.conditionTable) == true then
        self:AddDelayAutoUseHintType(hintType,function(hintType)
            self:UseHintItems(hintType)
            self:CleanDelayAutoUseItemData(hintType)
        end)
        return true
    end
    return false
end

---@public
---关闭指定类型的自动使用计时器
---@param 提示类型 hintType
---@param 是否触发延迟事件 triggerAction
function BetterItemHint_Control:CloseAutoUseHintItemsByHintType(hintType,triggerAction)
    self:RemoveDelayAutoUseItemListUpdate(hintType)
    if triggerAction == true then
        self:TriggerActionByHintType(hintType)
    end
    self:CleanDelayAutoUseItemData(hintType)
end

---@public
---关闭所有的自动使用计时器
---@param 是否触发延迟事件
function BetterItemHint_Control:CloseAllAutoUseHintItems(triggerAction)
    if self.DelayAutoUseItemListUpdateTable ~= nil then
        for k,v in pairs(self.DelayAutoUseItemListUpdateTable) do
            self:CloseAutoUseHintItemsByHintType(k,triggerAction)
        end
    end
end

---@public
---触发对应类型下的方法
function BetterItemHint_Control:TriggerActionByHintType(hintType)
    local delayData = self:GetDelayAutoUseItemData(hintType)
    if delayData ~= nil and delayData.action ~= nil then
        delayData.action(hintType)
    end
end

---@private
---使用提示物品列表
function BetterItemHint_Control:UseHintItems(hintType)
    if hintType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        self:BetterEquipAutoUse()
    end
end
--endregion

--region 获取
---@public
---获取提示自动使用物品表信息
function BetterItemHint_Control:GetHintAutoUseItemTableInfo(hintType)
    if self.hintAutoUseItemTableInfo_Table == nil then
        self:InitHintAutoUseItemTableInfo()
    end
    if self.hintAutoUseItemTableInfo_Table ~= nil and type(self.hintAutoUseItemTableInfo_Table) == 'table' then
        return self.hintAutoUseItemTableInfo_Table[hintType]
    end
    return nil
end
--endregion

--region 查询
function BetterItemHint_Control:IsHintEquip(itemId)
    if self.hintEquipItemIdTable ~= nil and #self.hintEquipItemIdTable > 0 then
        local isContains = Utility.IsContainsValue(self.hintEquipItemIdTable,itemId)
        if isContains == true then
            Utility.RemoveTableValue(self.hintEquipItemIdTable,itemId)
        end
        return isContains
    end
end
--endregion

--region 延迟使用计时器
---@private
---添加延迟自动使用物品
function BetterItemHint_Control:AddDelayAutoUseHintType(hintType,action)
    if self.DelayAutoUseItemListUpdateTable == nil then
        self.DelayAutoUseItemListUpdateTable = {}
    end
    self:RemoveDelayAutoUseItemListUpdate(hintType)
    local hintAutoUseItemTableInfo = self:GetHintAutoUseItemTableInfo(hintType)
    if hintAutoUseItemTableInfo ~= nil then
        local delayAutoUseItemListUpdate = CS.CSListUpdateMgr.Add(hintAutoUseItemTableInfo.autoUseTime,hintType,function(hintType)
            action(hintType)
        end)
        if delayAutoUseItemListUpdate ~= nil then
            local table = {}
            table.action = action
            table.delayAutoUseItemListUpdate = delayAutoUseItemListUpdate
            self.DelayAutoUseItemListUpdateTable[hintType] = table
        end
    end
end

---@private
---获取延迟自动使用物品的计时器
function BetterItemHint_Control:GetDelayAutoUseItemListUpdate(hintType)
    if self.DelayAutoUseItemListUpdateTable == nil or self.DelayAutoUseItemListUpdateTable[hintType] == nil then
        return nil
    end
    return self.DelayAutoUseItemListUpdateTable[hintType].delayAutoUseItemListUpdate
end

---@private
---获取延迟自动使用数据
function BetterItemHint_Control:GetDelayAutoUseItemData(hintType)
    if self.DelayAutoUseItemListUpdateTable == nil then
        return nil
    end
    return self.DelayAutoUseItemListUpdateTable[hintType]
end

---@private
---移除延迟自动使用物品的计时器
function BetterItemHint_Control:RemoveDelayAutoUseItemListUpdate(hintType)
    if self.DelayAutoUseItemListUpdateTable ~= nil and self:GetDelayAutoUseItemListUpdate(hintType) ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self:GetDelayAutoUseItemListUpdate(hintType))
    end
end

---@private
---清理延迟使用物品计时器
function BetterItemHint_Control:CleanDelayAutoUseItemData(hintType)
    if self.DelayAutoUseItemListUpdateTable ~= nil and self.DelayAutoUseItemListUpdateTable[hintType] ~= nil then
        self.DelayAutoUseItemListUpdateTable[hintType] = nil
    end
end
--endregion

--region 数据
---@private
---初始化提示自动使用物品表信息
function BetterItemHint_Control:InitHintAutoUseItemTableInfo()
    if self.hintAutoUseItemTableInfo_Table == nil then
        self.hintAutoUseItemTableInfo_Table = {}
        local globalInfoIsFind,globalInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22488)
        if globalInfoIsFind then
            local autoUseItemTableInfo = string.Split(globalInfo.value,'&')
            if autoUseItemTableInfo ~= nil then
                for k,v in pairs(autoUseItemTableInfo) do
                    local singleTableInfo = string.Split(v,'#')
                    if singleTableInfo ~= nil and #singleTableInfo > 1 then
                        local dataTable = {}
                        dataTable.hintType = tonumber(singleTableInfo[1])
                        dataTable.autoUseTime = tonumber(singleTableInfo[2]) * 1000
                        local conditionTable = {}
                        if #singleTableInfo > 2 then
                            for j = 3,#singleTableInfo do
                                table.insert(conditionTable,tonumber(singleTableInfo[j]))
                            end
                        end
                        dataTable.conditionTable = conditionTable
                        self.hintAutoUseItemTableInfo_Table[dataTable.hintType] = dataTable
                    end
                end
            end
        end
    end
end
--endregion

--region 物品自动使用方法
---@private
---更好装备自动使用
function BetterItemHint_Control:BetterEquipAutoUse()
    local hintLidList = self:GetCSBagItemHint():GetHintList(LuaEnumMainHint_BetterBagItemType.BetterEquip)
    ---主要用于规避策划之前的70级前穿装备自动打开角色面板
    if self.hintEquipItemIdTable == nil then
        self.hintEquipItemIdTable = {}
    end
    if hintLidList ~= nil then
        local length = hintLidList.Count - 1
        for k = 0,length do
            local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(hintLidList[k])
            if bagItemInfo ~= nil then
                local equipIndex = self:GetEquipIndex(bagItemInfo)
                networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
                --CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(bagItemInfo)
                table.insert(self.hintEquipItemIdTable,bagItemInfo.itemId)
                ---尝试关闭推荐框
                local uiMainHintPanel = uimanager:GetPanel("UIMainHintPanel")
                if uiMainHintPanel ~= nil and uiMainHintPanel:IsHintExist(LuaEnumMainHintType.BetterBagItem) == true then
                    local betterPanelTemplate = uiMainHintPanel:GetTableTemplate(LuaEnumMainHintType.BetterBagItem)
                    if betterPanelTemplate ~= nil and betterPanelTemplate.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
                        betterPanelTemplate:TryReshowNextHint()
                    end
                end
            end
        end
    end
    self.equipIndexDoubleEquipTable = nil
end

---获取穿戴的装备位(双装备位特殊处理)
function BetterItemHint_Control:GetEquipIndex(bagItemInfo)
    local equipIndex = CS.CSScene.MainPlayerInfo.BagInfo:GetUseEquipIndex(bagItemInfo)
    if self.equipIndexDoubleEquipTable == nil then
        self.equipIndexDoubleEquipTable = {}
    end
    if bagItemInfo.ItemTABLE ~= nil then
        if bagItemInfo.ItemTABLE.subType == LuaEnumEquiptype.Ring then
            local ringIndex = self.equipIndexDoubleEquipTable[LuaEnumEquiptype.Ring]
            if ringIndex == nil then
                self.equipIndexDoubleEquipTable[LuaEnumEquiptype.Ring] = equipIndex
            else
                if ringIndex == 6 then
                    return 61
                else
                    return 6
                end
            end
        end
        if bagItemInfo.ItemTABLE.subType == LuaEnumEquiptype.Bracelet then
            local braceletIndex = self.equipIndexDoubleEquipTable[LuaEnumEquiptype.Bracelet]
            if braceletIndex == nil then
                self.equipIndexDoubleEquipTable[LuaEnumEquiptype.Bracelet] = equipIndex
            else
                if braceletIndex == 5 then
                    return 51
                else
                    return 5
                end
            end
        end
    end
    return equipIndex
end
--endregion
--endregion

--region 数据清理
---游戏场景退回到登录/选角界面时触发
function BetterItemHint_Control:OnExitDestroy()
    self.DelayAutoUseItemListUpdateTable = {}
end
--endregion
return BetterItemHint_Control