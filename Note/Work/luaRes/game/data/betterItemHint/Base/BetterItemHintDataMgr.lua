---@class BetterItemHintDataMgr:luaobject 更好物品提示数据管理(都是最新的数据)
local BetterItemHintDataMgr = {}

--region 数据
---@type table<LuaEnumMainHint_BetterBagItemType,BetterItemHintItemList_Base> 物品提示数据字典
BetterItemHintDataMgr.BetterItemHintDic = nil
---@tupe table<BetterItemBagItemChangePackage> 需要刷新的数据（物品变动数据）
BetterItemHintDataMgr.RefreshHintItemTable = nil
--endregion

--region 控制器
---@return BetterItemHintCacheQueue 推送缓存队列
function BetterItemHintDataMgr:GetItemHintCacheQueue()
    if self.betterItemHintCacheQueue == nil then
        self.betterItemHintCacheQueue = luaclass.BetterItemHintCacheQueue:New()
    end
    return self.betterItemHintCacheQueue
end
--endregion

--region 添加推送包
---@param tblData table 服务器数据
---@param hintPackageSource LuaEnumHintPackageSource
function BetterItemHintDataMgr:TryAddHintPackage(tblData,hintPackageSource)
    ---@type BetterItemBagItemChangePackage 更好物品数据变动包
    local betterItemDataPackage = luaclass.BetterItemBagItemChangePackage:New()
    if hintPackageSource == LuaEnumHintPackageSource.BagInfoMessage then
        betterItemDataPackage:AnalysisBagInfoMessage(tblData)
    elseif hintPackageSource == LuaEnumHintPackageSource.BagChangeMessage then
        betterItemDataPackage:AnalysisBagItemChange(tblData)
    end
    if betterItemDataPackage.AnalysisState == true then
        self:PushInItemHintClass(betterItemDataPackage)
    end
end
--endregion

--region 初始化
---注册物品提示数据类
function BetterItemHintDataMgr:RegisterItemHintClass()
    if self.BetterItemHintDic == nil then
        self.BetterItemHintDic = {}
        ---血继
        self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.BetterBloodEquip] = luaclass.BetterItemHintItemList_BloodEquip:New()
        ---策划配置的单物品推送
        self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.SingleItemHint] = luaclass.BetterItemHintItemList_SingleItem:New()
        ---宝箱
        --self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.EquipBox] = luaclass.BetterItemHintItemList_EquipBox:New()
        ---魂装镶嵌
        self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.SoulEquip] = luaclass.BetterItemHintItemList_SoulEquip:New();
        ---人物法宝
        self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.RoleMagicEquip] = luaclass.BetterItemHintItemList_RoleMagicEquip:New()
        ---时装外观
        self.BetterItemHintDic[LuaEnumMainHint_BetterBagItemType.Appearance] = luaclass.BetterItemHintItemList_Appearance:New()
    end
end
--endregion

--region 推送基础功能
---载入一个物品提示类
---@param tblData BetterItemBagItemChangePackage 物品变动客户端自定义数据包
function BetterItemHintDataMgr:PushInItemHintClass(tblData)
    self:RegisterItemHintClass()
    if tblData == nil or (tblData.AnalysisState == nil or tblData.AnalysisState == false) then
        return
    end
    if self.RefreshHintItemTable == nil then
        self.RefreshHintItemTable = {}
    end
    table.insert(self.RefreshHintItemTable,tblData)
end

function BetterItemHintDataMgr:Update()
    self:TryPushOutHintClass()
end

---尝试推出所有提示类型
function BetterItemHintDataMgr:TryPushOutHintClass()
    if self.RefreshHintItemTable ~= nil and type(self.RefreshHintItemTable) == 'table' and Utility.GetLuaTableCount(self.RefreshHintItemTable) > 0 then
        ---以刷新的推送的包
        local removeIndexTable = {}
        for k,v in pairs(self.RefreshHintItemTable) do
            ---@type BetterItemBagItemChangePackage 推送包
            local hintPackage = v
            if hintPackage ~= nil and hintPackage:CheckCanRefreshPackage() == true then
                ---通知所有的注册了更好物品类接收刷新包并刷新数据
                for betterBagItemType,betterItemHintClass in pairs(self.BetterItemHintDic) do
                    betterItemHintClass:RefreshItemList(hintPackage)
                    ---更好物品列表是否有数据变动
                    if betterItemHintClass:BetterItemHaveDataChange() == true then
                        ---数据产生变动通知
                        luaEventManager.DoCallback(LuaCEvent.BetterItemChange,{betterBagItemType = betterItemHintClass.ItemType})
                        ---推送通知
                        if hintPackage:CheckCanPushHint() then
                            self:TryHintItemByItemType(hintPackage.TriggerHintItemType,betterItemHintClass.ItemType)
                        end
                    end
                end
                table.insert(removeIndexTable,k)
            end
        end
        ---清理以推送的数据
        for k,v in pairs(removeIndexTable) do
            if self.RefreshHintItemTable[v] ~= nil then
                self.RefreshHintItemTable[v] = nil
            end
        end
    end
end
--endregion

--region 推送触发
---尝试推送所有的物品类型
---@param hintReason LuaEnumBetterItemHintReason 推送来源类型
function BetterItemHintDataMgr:TryHintAllItem(hintReason)
    for k,v in pairs(LuaEnumMainHint_BetterBagItemType) do
        if v > 0 and self.BetterItemHintDic ~= nil and self.BetterItemHintDic[v] ~= nil then
            ---尝试刷新对应类型的物品列表
            self.BetterItemHintDic[v]:RefreshBetterItemListByReason(hintReason)
            ---是否有可推送物品
            if self.BetterItemHintDic[v]:HaveBetterItem() then
                local hintPanelType = luaclass.BetterItemHint_Data:GetHintStateType(v)
                ---检测推送配置
                if hintPanelType ~= nil and hintPanelType ~= LuaEnumBetterItemHintStateType.NONE then
                    self:TryHintItem(hintReason,hintPanelType,v)
                end
            end
        end
    end
end

---通过物品类型尝试推送物品
---@param hintReason LuaEnumBetterItemHintReason 推送来源类型
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType 推送物品类型
function BetterItemHintDataMgr:TryHintItemByItemType(hintReason,betterBagItemType)
    if hintReason == nil or betterBagItemType == nil or self.BetterItemHintDic == nil or self.BetterItemHintDic[betterBagItemType] == nil or self.BetterItemHintDic[betterBagItemType]:HaveBetterItem() == false then
        return
    end
    local hintPanelType = luaclass.BetterItemHint_Data:GetHintStateType(betterBagItemType)
    if hintPanelType ~= nil and hintPanelType ~= LuaEnumBetterItemHintStateType.NONE then
        self:TryHintItem(hintReason,hintPanelType,betterBagItemType)
    end
end

---尝试推送指定物品类型
---@param hintReason LuaEnumBetterItemHintReason 推送来源类型
---@param hintPanelType LuaEnumBetterItemHintStateType 推送面板类型
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType 推送物品类型
function BetterItemHintDataMgr:TryHintItem(hintReason,hintPanelType,betterBagItemType)
    if hintReason == nil or hintPanelType == nil or betterBagItemType == nil or self.BetterItemHintDic == nil or self.BetterItemHintDic[betterBagItemType] == nil then
        return
    end
    local betterItemListClass = self:GetBetterItemListClass(betterBagItemType)
    if betterItemListClass == nil or betterItemListClass:HaveBetterItem() == false or betterItemListClass:CanPushHintByReason(hintReason) == false then
        return
    end
    luaEventManager.DoCallback(LuaCEvent.Push_BetterItem,{hintReason = hintReason,hintPanelType = hintPanelType,betterBagItemType = betterBagItemType})
end
--endregion

--region 获取
---获取更好物品列表
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return BetterItemHintItemList_Base 更好物品列表类
function BetterItemHintDataMgr:GetBetterItemListClass(betterBagItemType)
    if betterBagItemType == nil or self.BetterItemHintDic == nil then
        return
    end
    return self.BetterItemHintDic[betterBagItemType]
end

---获取更好物品列表
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return table<bagV2.BagItemInfo> 更好物品列表类
function BetterItemHintDataMgr:GetBetterBagItemInfoList(betterBagItemType)
    local betterItemListClass = self:GetBetterItemListClass(betterBagItemType)
    if betterItemListClass ~= nil then
        return betterItemListClass:GetBagItemInfoList()
    end
end

---获取更好物品列表
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return table<bagV2.BagItemInfo> 更好物品列表类
function BetterItemHintDataMgr:GetBetterBagItemInfoLidList(betterBagItemType)
    local betterItemListClass = self:GetBetterItemListClass(betterBagItemType)
    if betterItemListClass ~= nil then
        return betterItemListClass:GetBagItemInfoLidList()
    end
end

---获取更好物品列表第一个物品类
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return BetterItemHintItem_Base 物品类
function BetterItemHintDataMgr:GetFirstItemClass(betterBagItemType)
    local betterItemListClass = self:GetBetterItemListClass(betterBagItemType)
    if betterItemListClass ~= nil then
        return betterItemListClass:GetFirstItemClass()
    end
end

---获取更好物品列表第一个背包物品
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return bagV2.BagItemInfo 背包物品数据
function BetterItemHintDataMgr:GetFirstBagItemInfo(betterBagItemType)
    local itemClass = self:GetFirstItemClass(betterBagItemType)
    if itemClass ~= nil then
        return itemClass.BagItemInfo
    end
end

---通过触发来源获取物品类
---@param hintReason LuaEnumBetterItemHintReason
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return BetterItemHintItem_Base
function BetterItemHintDataMgr:GetItemClassByHintReason(betterBagItemType,hintReason)
    local betterItemListClass = self:GetBetterItemListClass(betterBagItemType)
    local betterItemClass
    if betterItemListClass ~= nil and hintReason ~= nil then
        betterItemClass = betterItemListClass:GetItemClassByReason(hintReason)
    end
    if betterItemClass == nil then
        betterItemClass = self:GetFirstItemClass(betterBagItemType)
    end
    return betterItemClass
end

---通过触发来源获取一个背包物品
---@param hintReason LuaEnumBetterItemHintReason
---@param betterBagItemType LuaEnumMainHint_BetterBagItemType
---@return BetterItemHintItem_Base
function BetterItemHintDataMgr:GetBagItemInfoByReason(betterBagItemType,hintReason)
    local itemClass = self:GetItemClassByHintReason(betterBagItemType,hintReason)
    if itemClass ~= nil then
        return itemClass.BagItemInfo
    end
end
--endregion

return BetterItemHintDataMgr