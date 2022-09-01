---更好的背包物品主界面提示
---@class UIMainHint_BetterBagItem:UIBasicHint
local UIMainHint_BetterBagItem = {}

setmetatable(UIMainHint_BetterBagItem, luaComponentTemplates.UIBasicHint)

---前一次提示的更好背包物品的类型
---@type LuaEnumMainHint_BetterBagItemType
UIMainHint_BetterBagItem.mPreviousBetterBagItemType = nil
---当前更好背包物品的类型
---@type LuaEnumMainHint_BetterBagItemType
UIMainHint_BetterBagItem.mCurrentBetterBagItemType = nil
---类型缓冲
---@type table<LuaEnumMainHint_BetterBagItemType,number>
UIMainHint_BetterBagItem.mTypeCache = nil

function UIMainHint_BetterBagItem:Init(clientMsgHandler, panel)
    self.mTypeCache = {}
    self:RunBaseFunction("Init", clientMsgHandler, panel)
end

--[[******************************************* 组件 *******************************************]]
---主Icon
---@return UISprite
function UIMainHint_BetterBagItem:GetMainIcon_UISprite()
    if self.mMainIcon_Equip == nil then
        self.mMainIcon_Equip = self:Get("BetterBagItem/view/equip/icon", "UISprite")
    end
    return self.mMainIcon_Equip
end

---操作名
---@return UILabel
function UIMainHint_BetterBagItem:GetOperationName_UILabel()
    if self.mMainName_UILabel == nil then
        self.mMainName_UILabel = self:Get("BetterBagItem/view/mName", "UILabel")
    end
    return self.mMainName_UILabel
end

---目标名
---@return UILabel
function UIMainHint_BetterBagItem:GetTargetName_UILabel()
    if self.mSubName_UILabel == nil then
        self.mSubName_UILabel = self:Get("BetterBagItem/view/mName2", "UILabel")
    end
    return self.mSubName_UILabel
end

---强化等级文字
---@return UILabel
function UIMainHint_BetterBagItem:GetStrengthen_UILabel()
    if self.mStrength_UILabel == nil then
        self.mStrength_UILabel = self:Get("BetterBagItem/view/equip/strengthen", "UILabel")
    end
    return self.mStrength_UILabel
end

---数量文字
---@return UILabel
function UIMainHint_BetterBagItem:GetCount_UILabel()
    if self.mCount_UILabel == nil then
        self.mCount_UILabel = self:Get("BetterBagItem/view/equip/count", "UILabel")
    end
    return self.mCount_UILabel
end

---使用按钮文字
---@return UILabel
function UIMainHint_BetterBagItem:GetUseButtonLabel_UILabel()
    if self.mUseButtonLabel_UILabel == nil then
        self.mUseButtonLabel_UILabel = self:Get("BetterBagItem/event/btn_use/Label", "UILabel")
    end
    return self.mUseButtonLabel_UILabel
end

---是否有更好装备提示的游戏物体
---@return UnityEngine.GameObject
function UIMainHint_BetterBagItem:GetIsBetterEquipSign_GameObject()
    if self.mIsBetterEquipSign_GameObject == nil then
        self.mIsBetterEquipSign_GameObject = self:Get("BetterBagItem/view/equip/betterSign", "GameObject")
    end
    return self.mIsBetterEquipSign_GameObject
end

---关闭按钮
---@return UnityEngine.GameObject
function UIMainHint_BetterBagItem:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:Get("BetterBagItem/event/btn_close", "GameObject")
    end
    return self.mCloseButtonGO
end

---使用按钮
---@return UnityEngine.GameObject
function UIMainHint_BetterBagItem:GetUseButtonGO()
    if self.mUseButtonGO == nil then
        self.mUseButtonGO = self:Get("BetterBagItem/event/btn_use", "GameObject")
    end
    return self.mUseButtonGO
end

---相同物品显示颜色（极品**）
---@return UnityEngine.GameObject
function UIMainHint_BetterBagItem:GetSameItemColor()
    if self.mSameItemColor == nil then
        self.mSameItemColor = CS.Cfg_GlobalTableManager.Instance:GetSameItemTextColor()
    end
    return self.mSameItemColor
end

--[[******************************************* 重写子类 *******************************************]]
function UIMainHint_BetterBagItem:RefreshData(data)
    local inputBetterBagItemType,inputHintReason = self:GetAnalysisParams(data)
    local betterBagItemType, isHintAvailable, bagItemInfo = self:GetHintFromCacheQueue(inputBetterBagItemType,inputHintReason)
    betterBagItemType, isHintAvailable, bagItemInfo = self:TryGetOtherHintItem(betterBagItemType, isHintAvailable, bagItemInfo)
    ---对于配置了cd时间的物品推送cd判断
    if isHintAvailable == false or (self:HaveTimePushItem(betterBagItemType) == false and self.isOpen == false) then
        self:Close(false)
    else
        --print("更好物品提示类型：" .. tostring(betterBagItemType))
        --if bagItemInfo ~= nil then
        --    print("更好物品提示ItemId：" .. tostring(bagItemInfo.itemId))
        --end
        local lastItemId = 0;
        if (self.mBagItemInfo ~= nil) then
            lastItemId = self.mBagItemInfo.lid
        end
        if self.mCurrentBetterBagItemType then
            ---缓存需要显示物品信息（高于之前的则存储当前显示物品数据，否则存储新提示物品数据）
            if self.mTypeCache == nil then
                self.mTypeCache = {}
            end
            ---灵兽相关的物品需要互相互顶
            local isNeedReplace = self.mCurrentBetterBagItemType <= betterBagItemType or (self:IsServantRelated(self.mCurrentBetterBagItemType, betterBagItemType))
            local saveBagItemInfo = ternary(isNeedReplace, self.mBagItemInfo, bagItemInfo)
            local saveBetterBagItemType = ternary(isNeedReplace, self.mCurrentBetterBagItemType, betterBagItemType)
            if self.mBagItemInfo ~= nil then
                self.mTypeCache[saveBetterBagItemType] = saveBagItemInfo.itemId
            end
            ---当前的类型优先级高于之前的优先级,则替换之,否则不替换
            if isNeedReplace then
                local forward = self.mCurrentBetterBagItemType
                self.mCurrentBetterBagItemType = betterBagItemType
                self.mBagItemInfo = bagItemInfo
                self.mTypeCache[self.mCurrentBetterBagItemType] = nil
                self.mPreviousBetterBagItemType = self.mCurrentBetterBagItemType
            end
        else
            local forward = self.mCurrentBetterBagItemType
            self.mCurrentBetterBagItemType = betterBagItemType
            self.mBagItemInfo = bagItemInfo
            self.mTypeCache[self.mCurrentBetterBagItemType] = nil
            self.mPreviousBetterBagItemType = self.mCurrentBetterBagItemType
        end
        if (self.mBagItemInfo ~= nil and lastItemId ~= self.mBagItemInfo.lid) then
            luaclass.BetterItemHint_Control:TryAutoUseHintItems(self.mCurrentBetterBagItemType)
        end
        self.lastBetterBagItemType = self.mCurrentBetterBagItemType
        self.canReshow = true
        self:CreateUpdate()
        self:RefreshPanel()
        self:InitAutoClickHintParams()
    end
end

---获取解析参数
---@param data table lua推送数据或c#推送数据
---@return LuaEnumMainHint_BetterBagItemType,LuaEnumBetterItemHintReason
function UIMainHint_BetterBagItem:GetAnalysisParams(data)
    if type(data) == 'table' then
        return data.betterBagItemType,data.hintReason
    else
        return data
    end
end

function UIMainHint_BetterBagItem:IsServantRelated(last, cur)
    if ((last == LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC
            or last == LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX
            or last == LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM
            or last == LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON
            or last == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC
            or last == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX
            or last == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON
            or last == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM
    )
            and (cur == LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC
            or cur == LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX
            or cur == LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM
            or cur == LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON
            or cur == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC
            or cur == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX
            or cur == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON
            or cur == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM
    )) then
        return true
    end

    return false
end

function UIMainHint_BetterBagItem:ReleaseData()
    self.mBagItemInfo = nil
    self.mCurrentBetterBagItemType = nil
end

function UIMainHint_BetterBagItem:RegisterAllComponents()
    self:RegisterSingleTweenComponent("BetterBagItem")
    self:RegisterSingleCollider("BetterBagItem/event/btn_use")
    self:RegisterSingleCollider("BetterBagItem/event/btn_close")
    self:RegisterSingleCollider("BetterBagItem/bg")
end

function UIMainHint_BetterBagItem:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:OnCloseBtnClickCallBack()
    end
    CS.UIEventListener.Get(self:GetUseButtonGO()).onClick = function()
        self:OnUseButtonClicked()
    end
end

function UIMainHint_BetterBagItem:OnReshown()
    if self.canReshow == false then
        return
    end
    local isReshowSelf = self:GetIsOn()
    ---背包中没有相应物品时不重新显示
    if isReshowSelf and self.mBagItemInfo and CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.BagInfo then
        local id = self.mBagItemInfo.lid
        if id then
            isReshowSelf = self:ItemCanReshow()
        end
    end
    ---重新显示对应类型下的缓存物品
    if type(self.lastBetterBagItemType) == 'number' then
        local isReshowSubtype = self:CheckHintShowSubtypeItem(self.lastBetterBagItemType)
        local lastItemHaveCacheItem = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(self.lastBetterBagItemType)
        if isReshowSubtype and lastItemHaveCacheItem ~= nil and lastItemHaveCacheItem.Count > 0 then
            CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RefreshHint(0,self.lastBetterBagItemType)
            return isReshowSubtype
        end
        self.lastBetterBagItemType = nil
    end
    ---不重新显示界面时,检测缓存池中是否有需要提示的物品,若有需要提示的物品,则关闭后重新显示
    if isReshowSelf == false and CS.CSScene.MainPlayerInfo then
        if self.mTypeCache then
            ---找到一个优先级最高的类型的物品
            local type, itemID = self:GetHintTypeCacheBestHint()
            ---若找到了一个缓存中优先级最高的物品,关闭自身并重新提示一遍
            if type then
                self.mTypeCache[type] = nil
                isReshowSelf = true
                self:Close(false)
                --print("type")
                --self:Triggle()
                --self:RefreshData(type)
                gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryHintItemByItemType(LuaEnumBetterItemHintReason.ReshowItem,type)
                CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RefreshHint(itemID, type)
            end
        end
    end
    return isReshowSelf
end

---获取提示缓存中优先级最高的提示对象
---@return LuaEnumMainHint_BetterBagItemType,number 提示类型，道具id
function UIMainHint_BetterBagItem:GetHintTypeCacheBestHint()
    local type, itemID
    ---找到一个优先级最高的类型的物品
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if mainPlayerInfo ~= nil and bagInfo ~= nil then
        for i, v in pairs(self.mTypeCache) do
            if i then
                if v and (bagInfo:IsContainByItemId(v) or (i == LuaEnumMainHint_BetterBagItemType.ServantEquipSynthesis and servantInfo:IsContainEquipByItemId(v) == true)) then
                    if type then
                        if type <= i then
                            type = i
                            itemID = v
                        end
                    else
                        type = i
                        itemID = v
                    end
                else
                    self.mTypeCache[i] = nil
                end
            end
        end
    end
    return type,itemID
end

---检测提示是否显示子类型物品
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return boolean
function UIMainHint_BetterBagItem:CheckHintShowSubtypeItem(hintType)
    if hintType == nil then
        return false
    end
    local needShowSubtypeItem = false
    if hintType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        local hintItemList = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(hintType)
        if hintItemList ~= nil and hintItemList.Count > 0 then
            needShowSubtypeItem = true
        end
    end
    return needShowSubtypeItem
end

function UIMainHint_BetterBagItem:ItemCanReshow()
    if self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipBox then
        local specialBoxKeyInfos = Utility.GetSpecialBoxKeyInfos()
        local mainPlayerBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
        for i, v in pairs(specialBoxKeyInfos) do
            local boxItemID = i
            local keyItemID = v.keyId
            local keyItemUseMinCount = v.keyNum
            if self.mBagItemInfo.itemId == boxItemID then
                local boxItemCount = mainPlayerBagInfo:GetItemCountByItemId(boxItemID)
                local keyItemCount = mainPlayerBagInfo:GetItemCountByItemId(keyItemID)
                local maxUseCountPerDay = Utility.GetSpecialBoxUseCountLimitPerDay(boxItemID)
                local res, useNum = mainPlayerBagInfo.ItemUseTime:TryGetValue(boxItemID)
                return (maxUseCountPerDay == 0 or useNum < maxUseCountPerDay) and boxItemCount > 0 and keyItemCount >= keyItemUseMinCount
            end
        end
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipSynthesis or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipRefine then
        local haveBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:ContainsKey(self.mBagItemInfo.lid)
        if haveBagItemInfo == false then
            haveBagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(self.mBagItemInfo.lid)
        end
        return haveBagItemInfo
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipSynthesis or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRefine then
        return CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(self.mBagItemInfo.lid)
    end
    return CS.CSScene.MainPlayerInfo.BagInfo.BagItems:ContainsKey(self.mBagItemInfo.lid)
end

function UIMainHint_BetterBagItem:TryReshowNextHint()
    local isReshowSelf = false
    ---不重新显示界面时,检测缓存池中是否有需要提示的物品,若有需要提示的物品,则关闭后重新显示
    if isReshowSelf == false and CS.CSScene.MainPlayerInfo then
        if self.mTypeCache then
            local type, itemID
            ---找到一个优先级最高的类型的物品
            local mainPlayerInfo = CS.CSScene.MainPlayerInfo
            local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
            if mainPlayerInfo ~= nil and bagInfo ~= nil then
                for i, v in pairs(self.mTypeCache) do
                    if i then
                        if v and bagInfo:IsContainByItemId(v) then
                            if type then
                                if type <= i then
                                    type = i
                                    itemID = v
                                end
                            else
                                type = i
                                itemID = v
                            end
                        else
                            self.mTypeCache[i] = nil
                        end
                    end
                end
            end
            ---若找到了一个缓存中优先级最高的物品,关闭自身并重新提示一遍
            if type then
                self.mTypeCache[type] = nil
                isReshowSelf = true
                self:Close(false)
                gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryHintItemByItemType(LuaEnumBetterItemHintReason.ReshowItem,type)
                CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RefreshHint(itemID,type)
            end
        end
    end
    if isReshowSelf == false then
        self:Close(false)
    end
    return isReshowSelf
end

--region 获取推送物品
---从缓存队列中获取提示
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
---@param hintReason LuaEnumBetterItemHintReason 提示触发来源
---@return boolean,bagV2.BagItemInfo
function UIMainHint_BetterBagItem:GetHintFromCacheQueue(hintType,hintReason)
    local bagItemInfo
    local bagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    if bagItemHint then
        local CSHintType = luaclass.BetterItemHint_Data:GetCSHintType(hintType)
        if CSHintType == nil then
            return hintType, (bagItemInfo ~= nil), bagItemInfo
        end
        if hintType ~= LuaEnumMainHint_BetterBagItemType.None then
            local hintShowType = luaclass.BetterItemHint_Data:GetHintStateType(hintType)
            if (hintShowType == LuaEnumBetterItemHintStateType.IconHint) then
                if type(hintType) == 'number' then
                    bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBagItemInfoByReason(hintType,hintReason)
                end
                if bagItemInfo == nil then
                    bagItemInfo = bagItemHint:GetFirstItemInHintList(CSHintType)
                end
                if hintType == LuaEnumMainHint_BetterBagItemType.EquipBox and bagItemInfo ~= nil then
                    local canUse = Utility.CanUseSpecialEquipBox(bagItemInfo.ItemTABLE)
                    if canUse == false then
                        bagItemInfo = nil
                    end
                end
            end
        else
            ---此处为当提示类型为none时,从推荐列表中推送所有可推送的物品
            for k, v in pairs(LuaEnumMainHint_BetterBagItemType) do
                local type = luaclass.BetterItemHint_Data:GetHintStateType(v)
                local hintBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBagItemInfoByReason(v)
                if hintBagItemInfo == nil then
                    hintBagItemInfo = bagItemHint:GetFirstItemInHintList(v)
                end
                if hintBagItemInfo ~= nil and self:NeedShowBetterBagItem(v) == true and type == LuaEnumBetterItemHintStateType.IconHint then
                    local isContinue = false;
                    if v == LuaEnumMainHint_BetterBagItemType.EquipBox then
                        local canUse = Utility.CanUseSpecialEquipBox(hintBagItemInfo.ItemTABLE)
                        if canUse == false then
                            bagItemInfo = nil
                            isContinue = true
                        end
                    end
                    if isContinue == false then
                        if v < hintType then
                            self.mTypeCache[v] = hintBagItemInfo.itemId
                        else
                            if bagItemInfo ~= nil then
                                self.mTypeCache[hintType] = bagItemInfo.itemId
                            end
                            bagItemInfo = hintBagItemInfo
                            hintType = v
                        end
                    end
                end
            end
            ---此处为当提示类型为none时,按照优先级顺序依次从高到低获取提示对应的推荐装备
            --hintType = LuaEnumMainHint_BetterBagItemType.BetterEquip
            --bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.BetterEquip)
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantRecommend_TC)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantRecommend_LX)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantRecommend_HM)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantRecommend_Common)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantEquipRecommend_TC)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantEquipRecommend_LX)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantEquipRecommend_HM)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_Common
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantEquipRecommend_Common)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantBodyRecommend_TC)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantBodyRecommend_LX)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantBodyRecommend_HM)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantBodyRecommend_Common)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.AvailableSkill
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.AvailableSkill)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.TreasureBox
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.TreasureBox)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.BetterSignet
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.BetterSignet)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.BetterElement
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.BetterElement)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.EquipRefine
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.EquipRefine)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.ServantExpBox
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.ServantExpBox)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.BetterBlendEquip
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.BetterBlendEquip)
            --end
            ----if bagItemInfo == nil then
            ----    hintType = LuaEnumMainHint_BetterBagItemType.TowerCardHint
            ----    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.TowerCardHint)
            ----end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.DeployProp
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.DeployProp)
            --end
            ----if bagItemInfo == nil then
            ----    hintType = LuaEnumMainHint_BetterBagItemType.UnionSummonToken
            ----    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.UnionSummonToken)
            ----end
            ----if bagItemInfo == nil then
            ----    hintType = LuaEnumMainHint_BetterBagItemType.UsefulServantFragment
            ----    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.UsefulServantFragment)
            ----end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.EquipBox
            --    bagItemInfo = bagItemHint:GetFirstItemInHintList(CS.CSBagItemHint.BagHintType.EquipBox)
            --end
            --if bagItemInfo == nil then
            --    hintType = LuaEnumMainHint_BetterBagItemType.None
            --end
        end
    end
    if bagItemInfo ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(bagItemInfo.lid) == nil then
        bagItemInfo = nil
    end
    return hintType, (bagItemInfo ~= nil), bagItemInfo
end
--endregion


function UIMainHint_BetterBagItem:TryGetOtherHintItem(betterBagItemType, isHintAvailable, bagItemInfo)
    local mBetterBagItemType, mIsHintAvailable, mBagItemInfo = betterBagItemType, isHintAvailable, bagItemInfo
    if isHintAvailable == false then
        local curHintType = Utility.GetIntPart(betterBagItemType * 0.01)
        ---按照数字顺序从高到低遍历提示类型
        ---@type table<number,{key:string,value:number}>
        local hintTypeTblTemp = {}
        for i, v in pairs(LuaEnumMainHint_BetterBagItemType) do
            table.insert(hintTypeTblTemp, { key = i, value = v })
        end
        table.sort(hintTypeTblTemp, function(a, b)
            if a.value > b.value then
                return true
            else
                return false
            end
        end)
        for i = 1, #hintTypeTblTemp do
            local v = hintTypeTblTemp[i].value
            local nowHintType = Utility.GetIntPart(v * 0.01)
            if curHintType == nowHintType and self:NeedShowBetterBagItem(v) == true then
                mBetterBagItemType, mIsHintAvailable, mBagItemInfo = self:GetHintFromCacheQueue(v)
                if mIsHintAvailable then
                    break
                end
            end
        end
    end
    return mBetterBagItemType, mIsHintAvailable, mBagItemInfo
end

---对应类型是否需要显示
function UIMainHint_BetterBagItem:NeedShowBetterBagItem(betterBagItemType)
    if betterBagItemType == LuaEnumMainHint_BetterBagItemType.TowerCardHint then
        return false
    end
    if betterBagItemType == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        return false
    end
    if betterBagItemType == LuaEnumMainHint_BetterBagItemType.UsefulServantFragment then
        return false
    end

    if betterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipMelting then
        return false
    end

    return true
end

---刷新特效
---@param effectName string 特效名
---@param parentGO UnityEngine.GameObject 特效生成的父物体
---@param localPosition UnityEngine.Vector3 特效位置
---@param localScale UnityEngine.Vector3 特效缩放
---@param isEffectShow boolean 显示还是隐藏这个特效
function UIMainHint_BetterBagItem:RefreshEffect(effectName, parentGO, localPosition, localScale, isEffectShow)
    if effectName == nil then
        return
    end
    if self.mEffects == nil then
        self.mEffects = {}
    end
    local effectGO = self.mEffects[effectName]
    if CS.StaticUtility.IsNull(effectGO) == false then
        effectGO:SetActive(false)
        effectGO:SetActive(isEffectShow == true)
    else
        CS.CSResourceManager.Instance:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj and self and CS.StaticUtility.IsNull(self.go) == false and self.mEffects[effectName] == nil then
                local go = res:GetObjInst()
                if go and CS.StaticUtility.IsNull(go) == false then
                    go.transform.parent = parentGO.transform
                    go.transform.localPosition = localPosition
                    go.transform.localScale = localScale
                    self.mEffects[effectName] = go
                end
            end
            if self.mEffects[effectName] ~= nil and CS.StaticUtility.IsNull(self.mEffects[effectName]) == false then
                self.mEffects[effectName]:SetActive(false)
                self.mEffects[effectName]:SetActive(isEffectShow)
            end
        end, CS.ResourceAssistType.UI)
    end
end

---当前时间是否可以推送物品
function UIMainHint_BetterBagItem:HaveTimePushItem(hintType)
    if self.HintTimeTable == nil then
        self.HintTimeTable = {}
    end
    local hintCdTime = CS.Cfg_GlobalTableManager.Instance:GetHintCdTime(hintType)
    if hintType ~= nil and hintCdTime ~= nil and hintCdTime > 0 then
        local nowTime = CS.CSScene.MainPlayerInfo.serverTime
        local hintEndTime = self.HintTimeTable[hintType]
        if hintEndTime == nil or nowTime >= hintEndTime then
            self.HintTimeTable[hintType] = nowTime + hintCdTime
            return true
        else
            return false
        end
    end
    return true
end
--[[******************************************* 根据子类型刷新面板 *******************************************]]
---刷新面板
---@protected
function UIMainHint_BetterBagItem:RefreshPanel()
    local itemTbl
    if self.mBagItemInfo then
        ___, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
    end
    if self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.Undefined then
        self:RefreshWithUndefined(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterBlendEquip then
        self:RefreshWithBetterBlendEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        self:RefreshWithUnionSummonTokenType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.TreasureBox then
        self:RefreshWithTreasureBoxType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterElement then
        self:RefreshWithBetterElementType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterSignet then
        self:RefreshWithBetterSignetType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        self:RefreshWithBetterEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON then
        self:RefreshWithServantRecommendedType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.UsefulServantFragment then
        self:RefreshWithUsefulServantFragmentType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.AvailableSkill then
        self:RefreshWithAvailableSkillType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON then
        self:RefreshWithServantBodyRecommendedType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.DeployProp then
        self:RefreshWithDeployPropType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantExpBox then
        self:RefreshWithServantExpBoxType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipRefine then
        self:RefreshWithRefineEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipBox then
        self:RefreshWithEquipBoxType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipSynthesis then
        self:RefreshWithSynthesisEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipSynthesis then
        self:RefreshWithSynthesisServantEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRefine then
        self:RefreshWithRefineEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterBloodEquip then
        self:RefreshWithBloodEquipType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipMelting then
        self:RefreshWithMeltingType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.SingleItemHint then
        self:RefreshSingleItemHintType(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM
            or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX
            or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC then
        self:RefreshWithServantEquipRecommendedType(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.SoulEquip then
        self:RefreshWithSoulEquip(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.RoleMagicEquip then
        self:RefreshWithRoleMagicEquip(self.mBagItemInfo, itemTbl)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.Appearance then
        self:RefreshWithAppearance(self.mBagItemInfo, itemTbl)
    else
        self:RefreshWithNone(self.mBagItemInfo, itemTbl)
    end
    self:RefreshEffect("800004", self:GetUseButtonGO(), CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3(1.3,1,1), self.mBagItemInfo ~= nil)
end

---空的情况刷新(清空界面)
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithNone(bagItemInfo, itemTbl)
    self:GetMainIcon_UISprite().spriteName = ""
    self:GetOperationName_UILabel().text = ""
    self:GetTargetName_UILabel().text = ""
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用未定义的类型刷新(仅显示基本情况)
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithUndefined(bagItemInfo, itemTbl)
    if bagItemInfo then
        self:GetOperationName_UILabel().text = ""
        if itemTbl then
            self:GetMainIcon_UISprite().spriteName = itemTbl.icon
            self:GetTargetName_UILabel().text = itemTbl.name
        else
            self:GetMainIcon_UISprite().spriteName = ""
            self:GetTargetName_UILabel().text = ""
        end
        self:GetStrengthen_UILabel().text = ""
        self:GetCount_UILabel().text = ""
        self:GetUseButtonLabel_UILabel().text = "使用"
        self:GetIsBetterEquipSign_GameObject():SetActive(false)
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetOperationName_UILabel().text = ""
        self:GetTargetName_UILabel().text = ""
        self:GetStrengthen_UILabel().text = ""
        self:GetCount_UILabel().text = ""
        self:GetUseButtonLabel_UILabel().text = "使用"
        self:GetIsBetterEquipSign_GameObject():SetActive(false)
    end
end

---使用元素类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithBetterElementType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可镶嵌"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即镶嵌"
    self:GetIsBetterEquipSign_GameObject():SetActive(true)
end

---使用行会召唤令类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithUnionSummonTokenType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可使用"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即召唤"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用宝箱类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithTreasureBoxType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "新宝箱"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用融合类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithBetterBlendEquipType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可融合"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即融合"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用炼化类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithRefineEquipType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可精炼"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即精炼"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用血继类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithBloodEquipType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可装备血继"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即装备"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用熔炼类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithMeltingType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可熔炼"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即熔炼"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用单物品推送刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshSingleItemHintType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可消耗"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用装备合成类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithSynthesisEquipType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可合成"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即合成"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用魂装镶嵌类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithSoulEquip(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可镶嵌"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即镶嵌"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---人物法宝类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithRoleMagicEquip(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可装备"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即装备"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---时装外观类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithAppearance(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可使用"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用合成类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithSynthesisServantEquipType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可合成"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即合成"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用装备宝箱类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithEquipBoxType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "[ffffff]可开启[-]"
    self:GetStrengthen_UILabel().text = ""
    local specialBoxTableInfo = CS.Cfg_GlobalTableManager.Instance:GetSpecialBoxTableInfoByBoxItemId(itemTbl.id)
    local count = 0
    if specialBoxTableInfo ~= nil and specialBoxTableInfo.canUseBoxNum ~= nil then
        count = specialBoxTableInfo.canUseBoxNum
    end
    self:GetCount_UILabel().text = count < 2 and "" or tostring(count)
    self:GetUseButtonLabel_UILabel().text = "[ffcda5]立即开启[-]"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用印记类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithBetterSignetType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可镶嵌"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即镶嵌"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用更好装备类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithBetterEquipType(bagItemInfo, itemTbl)
    ---获取身上对应装备位的装备
    local bagItemEquiped
    if itemTbl then
        if itemTbl.subType == LuaEnumEquiptype.Bracelet or itemTbl.subType == LuaEnumEquiptype.Ring then
            local equipList = CS.CSScene.MainPlayerInfo.EquipInfo:GetDoubleEquipIndexEquip(itemTbl.subType)
            if equipList.Count == 2 then
                bagItemEquiped = equipList[1]
            end
        else
            if CS.CSScene.MainPlayerInfo.EquipInfo:HasEquipWithType(itemTbl.subType) then
                bagItemEquiped = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(itemTbl.subType)
            end
        end
        ---根据当前装备位上的装备情况设置各组件状态
        if bagItemEquiped ~= nil then
            ---如果对应装备位上有装备,则进行一定的对比
            local bodyEquipItemInfoIsFind, bodyEquipItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemEquiped.itemId)
            if bodyEquipItemInfoIsFind then
                local attribute
                local playerInfo = CS.CSScene.MainPlayerInfo
                local playerCareer = ternary(playerInfo ~= nil, playerInfo.Career, CS.ECareer.Common)
                if self.mBagItemInfo.rateAttribute.Count > 0 then
                    attribute = self.mBagItemInfo.rateAttribute[0]
                    local length = self.mBagItemInfo.rateAttribute.Count - 1
                    for k = 0, length do
                        local v = self.mBagItemInfo.rateAttribute[k]
                        local attributeType = v.type
                        if playerCareer == CS.ECareer.Warrior then
                            if attributeType ~= LuaEnumAttributeType.MagicAttackMax and attributeType ~= LuaEnumAttributeType.TaoAttackMax then
                                attribute = v
                                break
                            end
                        elseif playerCareer == CS.ECareer.Master then
                            if attributeType ~= LuaEnumAttributeType.PhyAttackMax and attributeType ~= LuaEnumAttributeType.TaoAttackMax then
                                attribute = v
                                break
                            end
                        elseif playerCareer == CS.ECareer.Taoist then
                            if attributeType ~= LuaEnumAttributeType.PhyAttackMax and attributeType ~= LuaEnumAttributeType.MagicAttackMax then
                                attribute = v
                                break
                            end
                        end
                    end
                end
                if bodyEquipItemInfo.id == itemTbl.id and attribute ~= nil and attribute.num > 0 then
                    self:GetOperationName_UILabel().text = "极品装备"
                    if attribute.type == LuaEnumAttributeType.PhyDefenceMax then
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. "防御+" .. tostring(attribute.num)
                    elseif attribute.type == LuaEnumAttributeType.MagicDefenceMax then
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. "魔防+" .. tostring(attribute.num)
                    elseif attribute.type == LuaEnumAttributeType.PhyAttackMax then
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. "攻击+" .. tostring(attribute.num)
                    elseif attribute.type == LuaEnumAttributeType.MagicAttackMax then
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. "魔法+" .. tostring(attribute.num)
                    elseif attribute.type == LuaEnumAttributeType.TaoAttackMax then
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. "道术+" .. tostring(attribute.num)
                    else
                        local showInfo = "攻击"
                        if playerInfo then
                            showInfo = Utility.GetCareerAttackName(Utility.EnumToInt(playerInfo.Career))
                        end
                        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. showInfo .. "+" .. tostring(attribute.num)
                    end
                else
                    self:GetOperationName_UILabel().text = "可装备"
                    ---策划要求把差值改成名字，差值暂留
                    self:GetTargetName_UILabel().text = itemTbl.name
                end
            end
        else
            ---如果对应装备位上没有装备
            self:GetOperationName_UILabel().text = "可装备"
            ---策划要求把差值改成名字，差值暂留
            self:GetTargetName_UILabel().text = itemTbl.name
        end
        ---显示更好装备的标记
        self:GetIsBetterEquipSign_GameObject():SetActive(true)
        self:GetUseButtonLabel_UILabel().text = "立即装备"
        ---装备的强化数值
        if self.mBagItemInfo.intensify > 0 then
            self:GetStrengthen_UILabel().text = "+" .. tostring(self.mBagItemInfo.intensify)
        else
            self:GetStrengthen_UILabel().text = ""
        end
        ---icon和数量
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetCount_UILabel().text = ""
    else
        self:RefreshWithNone(bagItemInfo, itemTbl)
    end
end

---使用可用技能类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithAvailableSkillType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "新技能"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "学习"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用可用灵兽碎片类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithUsefulServantFragmentType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = CS.Utility_Lua.GetItemColorByQuality(itemTbl.quality) .. "灵兽"
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可合成"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即合成"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用推荐灵兽类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithServantRecommendedType(bagItemInfo, itemTbl)
    local isSameServant = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsGoingToReplaceSameServant(self.mBagItemInfo)
    if isSameServant then
        self:GetOperationName_UILabel().text = "极品灵兽"
        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipHintShowAttributeContentByBagItemInfo(bagItemInfo)
    else
        self:GetOperationName_UILabel().text = "可召唤"
        self:GetTargetName_UILabel().text = itemTbl.name
    end
    self:GetMainIcon_UISprite().spriteName = itemTbl.icon
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即召唤"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用推荐灵兽肉身刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithServantBodyRecommendedType(bagItemInfo, itemTbl)
    local isSameServant = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsSameServantEquipWithBodyServantEquip(bagItemInfo)
    if isSameServant then
        self:GetOperationName_UILabel().text = "极品装备"
        self:GetTargetName_UILabel().text = self:GetSameItemColor() .. CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantBodyAttributeShowContent(bagItemInfo)
    else
        self:GetOperationName_UILabel().text = "可装备"
        self:GetTargetName_UILabel().text = itemTbl.name
    end
    self:GetMainIcon_UISprite().spriteName = itemTbl.icon
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即装备"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用推荐灵兽装备刷新灵兽
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:RefreshWithServantEquipRecommendedType(bagItemInfo, itemTbl, hintType)
    local servantIndex = 1
    if hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM then
        ---寒芒
        servantIndex = 1
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX then
        ---落星
        servantIndex = 2
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC then
        ---天成
        servantIndex = 3
    end
    ---@type CSServantInfoV2
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    local recommendedEquipIndex = servantInfo:GetRecommendedEquipIndexForRoleEquip(itemTbl, servantIndex)
    ---推荐的装备位上已经装备的物品
    ---@type bagV2.BagItemInfo
    local equippedBagItem
    ___, equippedBagItem = servantInfo.ServantEquip:TryGetValue(recommendedEquipIndex)
    if equippedBagItem then
        if equippedBagItem.itemId ~= bagItemInfo.itemId then
            ---相同装备,显示极品装备
            self:GetOperationName_UILabel().text = "极品装备"
            self:GetTargetName_UILabel().text = self:GetServantEquipCompareString(bagItemInfo, equippedBagItem)
        else
            self:GetOperationName_UILabel().text = "可装备"
            self:GetTargetName_UILabel().text = itemTbl.name
        end
    else
        self:GetOperationName_UILabel().text = "可装备"
        self:GetTargetName_UILabel().text = itemTbl.name
    end
    self:GetMainIcon_UISprite().spriteName = itemTbl.icon
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即装备"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---获取灵兽装备对比字符串
---@private
---@param newBagItem bagV2.BagItemInfo
---@param equippedBagItem bagV2.BagItemInfo
---@return string
function UIMainHint_BetterBagItem:GetServantEquipCompareString(newBagItem, equippedBagItem)
    local attribute
    local playerInfo = CS.CSScene.MainPlayerInfo
    local playerCareer = ternary(playerInfo ~= nil, playerInfo.Career, CS.ECareer.Common)
    if newBagItem.rateAttribute.Count > 0 then
        attribute = newBagItem.rateAttribute[0]
        local length = newBagItem.rateAttribute.Count - 1
        for k = 0, length do
            local v = newBagItem.rateAttribute[k]
            local attributeType = v.type
            if playerCareer == CS.ECareer.Warrior then
                if attributeType ~= LuaEnumAttributeType.MagicAttackMax and attributeType ~= LuaEnumAttributeType.TaoAttackMax then
                    attribute = v
                    break
                end
            elseif playerCareer == CS.ECareer.Master then
                if attributeType ~= LuaEnumAttributeType.PhyAttackMax and attributeType ~= LuaEnumAttributeType.TaoAttackMax then
                    attribute = v
                    break
                end
            elseif playerCareer == CS.ECareer.Taoist then
                if attributeType ~= LuaEnumAttributeType.PhyAttackMax and attributeType ~= LuaEnumAttributeType.MagicAttackMax then
                    attribute = v
                    break
                end
            end
        end
    end
    if attribute == nil then
        return ""
    end
    if attribute.type == LuaEnumAttributeType.PhyDefenceMax then
        return self:GetSameItemColor() .. "防御+" .. tostring(attribute.num)
    elseif attribute.type == LuaEnumAttributeType.MagicDefenceMax then
        return self:GetSameItemColor() .. "魔防+" .. tostring(attribute.num)
    elseif attribute.type == LuaEnumAttributeType.PhyAttackMax then
        return self:GetSameItemColor() .. "攻击+" .. tostring(attribute.num)
    elseif attribute.type == LuaEnumAttributeType.MagicAttackMax then
        return self:GetSameItemColor() .. "魔法+" .. tostring(attribute.num)
    elseif attribute.type == LuaEnumAttributeType.TaoAttackMax then
        return self:GetSameItemColor() .. "道术+" .. tostring(attribute.num)
    else
        local showInfo = "攻击"
        if playerInfo then
            showInfo = Utility.GetCareerAttackName(Utility.EnumToInt(playerInfo.Career))
        end
        return self:GetSameItemColor() .. showInfo .. "+" .. tostring(attribute.num)
    end
end

---使用消耗道具类型刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithDeployPropType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可使用"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

---使用灵兽经验丹刷新
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem:RefreshWithServantExpBoxType(bagItemInfo, itemTbl)
    if itemTbl then
        self:GetMainIcon_UISprite().spriteName = itemTbl.icon
        self:GetTargetName_UILabel().text = itemTbl.name
    else
        self:GetMainIcon_UISprite().spriteName = ""
        self:GetTargetName_UILabel().text = ""
    end
    self:GetOperationName_UILabel().text = "可使用"
    self:GetStrengthen_UILabel().text = ""
    self:GetCount_UILabel().text = ""
    self:GetUseButtonLabel_UILabel().text = "立即使用"
    self:GetIsBetterEquipSign_GameObject():SetActive(false)
end

--[[******************************************* 根据子类型调整使用方法 *******************************************]]
---使用按钮点击事件
---@protected
function UIMainHint_BetterBagItem:OnUseButtonClicked()
    if self == nil then
        return
    end
    if self.mBagItemInfo == nil then
        self:Close(true)
        return
    end
    local itemTbl
    if self.mBagItemInfo then
        ___, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
    end
    self:ResetAutoClickHintParams()
    luaclass.BetterItemHint_Control:CloseAutoUseHintItemsByHintType(self.mCurrentBetterBagItemType)
    if self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        self:OnBetterEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterBlendEquip then
        self:OnBetterBlendEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        self:OnUnionSummonTokenEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.TreasureBox then
        self:OnTreasureBoxEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterElement then
        self:OnBetterElementEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterSignet then
        self:OnBetterSignetEquipUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.AvailableSkill then
        self:OnAvailableSkillUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON then
        self:OnServantRecommendUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.UsefulServantFragment then
        self:OnUsefulServantFragmentUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON then
        self:OnServantBodyRecommendUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.DeployProp then
        self:OnDeployPropUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.TowerCardHint then
        self:OnTowerCardHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantExpBox then
        self:OnServantExpBoxHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipRefine then
        self:OnRefineEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipBox then
        self:OnEquipBoxHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipSynthesis then
        self:OnSynthesisEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipSynthesis then
        self:OnSynthesisServantEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRefine then
        self:OnRefineServantEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.BetterBloodEquip then
        self:OnBloodEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.SingleItemHint then
        self:OnSingleItemHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipMelting then
        self:OnRefineMeltingHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM
            or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX
            or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC then
        self:OnServantEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.SoulEquip then
        self:OnSoulEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.RoleMagicEquip then
        self:OnRoleMagicEquipHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    elseif self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.Appearance then
        self:OnAppearanceHintUsed(self.mBagItemInfo, itemTbl, self.mCurrentBetterBagItemType)
    end
    if self:CheckHintShowSubtypeItem(self.mCurrentBetterBagItemType) == false and self:CheckNeedCloseHint(self.mCurrentBetterBagItemType) then
        self:Close(true)
    end
    if type(self:GetReshowHinType()) == 'number' then
        self.mCurrentBetterBagItemType = nil
        self:RefreshData(self:GetReshowHinType())
    end
end

---检查是否需要关闭提示
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return boolean
function UIMainHint_BetterBagItem:CheckNeedCloseHint(hintType)
    if hintType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        local hintList = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(hintType)
        if (hintList == nil or hintList.Count <= 0) and type(self.mTypeCache) == 'table' and Utility.GetTableCount(self.mTypeCache) > 0 then
            return false
        end
    end
    return true
end

---设置重新显示的提示类型
---@param hintType LuaEnumMainHint_BetterBagItemType
function UIMainHint_BetterBagItem:SetReshowHintType(hintType)
    self.reshowHintType = hintType
end

---获取重新显示的提示类型
---@return LuaEnumMainHint_BetterBagItemType
function UIMainHint_BetterBagItem:GetReshowHinType()
    return self.reshowHintType
end

---关闭按钮点击事件
---@protected
function UIMainHint_BetterBagItem:OnCloseBtnClickCallBack()
    if self.mPreviousBetterBagItemType == LuaEnumMainHint_BetterBagItemType.ServantEquipRefine then
        if (CS.CSScene.MainPlayerInfo ~= nil and self.mBagItemInfo ~= nil) then
            CS.CSScene.MainPlayerInfo.BagInfo:AddToNotServantRecommendList(self.mBagItemInfo.itemId);
        end
    elseif self.mPreviousBetterBagItemType == LuaEnumMainHint_BetterBagItemType.EquipRefine then
        if (CS.CSScene.MainPlayerInfo ~= nil and self.mBagItemInfo ~= nil) then
            CS.CSScene.MainPlayerInfo.BagInfo:AddToNotRecommendList(self.mBagItemInfo.itemId);
        end
    end
    self.canReshow = false
    self:Close(true)
    self:ResetAutoClickHintParams()
end

---更好的装备被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnBetterEquipUsed(bagItemInfo, itemTbl, hintType)
    CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RemoveHintItem(hintType,bagItemInfo.lid)
    local hintList = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(hintType)
    ---@type LuaEnumMainHint_BetterBagItemType
    local reshowHintType = nil
    if hintList ~= nil and hintList.Count > 0 then
        reshowHintType = hintType
    else
        reshowHintType = self:GetHintTypeCacheBestHint()
    end
    self:SetReshowHintType(reshowHintType)
    uiStaticParameter.PutOnEquipAutoOpenRolePanel = false
    CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(bagItemInfo)
end

---融合按钮点击事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnBetterBlendEquipUsed(bagItemInfo, itemTbl, hintType)
    uimanager:CreatePanel("UIBagPanel", function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = true, showAssistPanel = true, highLightBtnTable = { 20 } })
    end, { type = LuaEnumBagType.Normal, focusedBagItemInfo = bagItemInfo, openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

---宝箱按钮点击事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnTreasureBoxEquipUsed(bagItemInfo, itemTbl, hintType)
    local bagData = {}
    bagData.name = itemTbl.name
    bagData.bagItemInfo = bagItemInfo
    uimanager:CreatePanel("UITreasureBagPanel", function()
        networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
    end, bagData)
end

---行会召唤令按钮点击事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnUnionSummonTokenEquipUsed(bagItemInfo, itemTbl, hintType)
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.UnionSummonTokenHint, focusedBagItemInfo = bagItemInfo, openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

---元素镶嵌按钮点击事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnBetterElementEquipUsed(bagItemInfo, itemTbl, hintType)
    --uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.ElementHint, focusedBagItemInfo = bagItemInfo, openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
    local customData = { chooseEquipIndex = CS.CSScene.MainPlayerInfo.ElementInfo:GetDefaultChooseEquipIndex(itemTbl), chooseElementItemId = itemTbl.id }
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Element_Role, customData)
end

---印记镶嵌按钮点击事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnBetterSignetEquipUsed(bagItemInfo, itemTbl, hintType)
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Imprint_Role)
    -- uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.SignetHint, focusedBagItemInfo = bagItemInfo, openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

---快速使用技能书
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:QuickUseSkill(bagItemInfo, itemTbl, hintType)
    local hintList = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(hintType))
    CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:RemoveHintItems(hintType)
    ---@type LuaEnumMainHint_BetterBagItemType
    local reshowHintType = self:GetHintTypeCacheBestHint()
    self:SetReshowHintType(reshowHintType)
    if reshowHintType == nil then
        self:Close(false)
    end
    if type(hintList) == 'table' then
        for k,v in pairs(hintList) do
            networkRequest.ReqUseItem(1, v)
        end
    end
end

---可用技能书被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnAvailableSkillUsed(bagItemInfo, itemTbl, hintType)
    local skillId = 0
    if (itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 0) then
        skillId = itemTbl.useParam.list[0];
    end
    local isGetValue, tblValue = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillId);
    if (isGetValue) then
        if (luaEventManager.HasCallback(LuaCEvent.Navigation_OpenWithId)) then
            if (tblValue.cls == 0 or tblValue.cls == 4) then
                uiTransferManager:TransferToPanel(LuaEnumTransferType.SkillDetails);
            elseif (tblValue.cls == 3) then
                uiTransferManager:TransferToPanel(LuaEnumTransferType.HeartSkill);
            end
        end
    end
end

---推荐灵兽被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnServantRecommendUsed(bagItemInfo, itemTbl, hintType)
    local huanShouInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantInfoByItemInfo(itemTbl)
    if huanShouInfo then
        local type = huanShouInfo.type
        if type == luaEnumServantType.COMMON then
            type = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBodyLowServantIndex()
        end
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { type = LuaEnumServantPanelType.BasePanel, servantIndex = type - 1, openSourceType = LuaEnumPanelOpenSourceType.ByServantHint })
    end
end

---推荐灵兽肉身被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnServantBodyRecommendUsed(bagItemInfo, itemTbl, hintType)
    local mServantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipSetvantType(itemTbl)
    if mServantIndex ~= -1 then
        if mServantIndex == 4 then
            ---若是一个通用肉身装备,则定位到最弱的灵兽位
            mServantIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantTypeOfWeakestBodyEquip(bagItemInfo)
            ---未找到对应的灵兽位
            if mServantIndex == 0 or mServantIndex == luaEnumServantType.COMMON then
                return
            end
        end
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { type = LuaEnumServantPanelType.BasePanel, servantIndex = mServantIndex - 1 },
                function(panel)
                    if panel ~= nil then
                        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant, focusedBagItemInfo = bagItemInfo, hintType = hintType, openSourceType = LuaEnumPanelOpenSourceType.ByServantHint })
                    end
                end);
    end
end

---可用灵兽碎片被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnUsefulServantFragmentUsed(bagItemInfo, itemTbl, hintType)
    local customData = {};
    customData.bagItemInfo = bagItemInfo;
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Synthesis_List, customData)
end

---消耗类道具使用事件
function UIMainHint_BetterBagItem:OnDeployPropUsed(bagItemInfo, itemTbl, hintType)
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                               chosenBagItemIDs = { bagItemInfo.lid },
                                               focusedBagItemInfo = bagItemInfo,
                                               openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

---塔罗牌提示使用事件
function UIMainHint_BetterBagItem:OnTowerCardHintUsed(bagItemInfo, itemTbl, hintType)
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                               chosenBagItemIDs = { bagItemInfo.lid },
                                               focusedBagItemInfo = bagItemInfo,
                                               openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

---灵兽经验丹提示使用事件
function UIMainHint_BetterBagItem:OnServantExpBoxHintUsed(bagItemInfo, itemTbl, hintType)
    local servantExpBoxLidList = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(LuaEnumMainHint_BetterBagItemType.ServantExpBox)
    if servantExpBoxLidList ~= nil then
        servantExpBoxLidList = Utility.ListChangeTable(servantExpBoxLidList)
    end
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                               chosenBagItemIDs = servantExpBoxLidList,
                                               focusedBagItemInfo = bagItemInfo,
                                               openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

function UIMainHint_BetterBagItem:OnRefineEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Refine, { bagItemInfo = bagItemInfo });
    end
end

function UIMainHint_BetterBagItem:OnSynthesisEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        uiTransferManager:TransferToSynthesisPanel(bagItemInfo);
    end
end

function UIMainHint_BetterBagItem:OnSoulEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        uiTransferManager:TransferToSoulEquipPanel(bagItemInfo);
    end
end

function UIMainHint_BetterBagItem:OnRoleMagicEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        local betterItemLidList = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBetterBagItemInfoLidList(LuaEnumMainHint_BetterBagItemType.RoleMagicEquip)
        if type(betterItemLidList) ~= 'table' or Utility.GetLuaTableCount(betterItemLidList) <= 0 then
            return
        end
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                                   chosenBagItemIDs = betterItemLidList,
                                                   focusedBagItemInfo = bagItemInfo,
                                                   openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
    end
end

function UIMainHint_BetterBagItem:OnAppearanceHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        local betterItemLidList = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBetterBagItemInfoLidList(LuaEnumMainHint_BetterBagItemType.Appearance)
        if type(betterItemLidList) ~= 'table' or Utility.GetLuaTableCount(betterItemLidList) <= 0 then
            return
        end
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                                   chosenBagItemIDs = betterItemLidList,
                                                   focusedBagItemInfo = bagItemInfo,
                                                   openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
    end
end

function UIMainHint_BetterBagItem:OnSynthesisServantEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        uiTransferManager:TransferToSynthesisPanel(bagItemInfo);
    end
end

function UIMainHint_BetterBagItem:OnEquipBoxHintUsed(bagItemInfo, itemTbl, hintType)
    if (bagItemInfo ~= nil) then
        uimanager:CreatePanel("UISpecialTreasureBagPanel", nil, { bagItemInfo = bagItemInfo })
    end
end

function UIMainHint_BetterBagItem:OnRefineServantEquipHintUsed(bagItemInfo, itemTbl, hintType)
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Refine, { type = LuaEnumRefineLeftPanelType.Servant, bagItemInfo = self.mBagItemInfo })
end

---血继使用点击
---@param bagItemInfo bagV2.BagItemInfo
function UIMainHint_BetterBagItem:OnBloodEquipHintUsed(bagItemInfo, itemTbl, hintType)
    if bagItemInfo == nil then
        return
    end
    local bloodSuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(bagItemInfo.itemId)
    if bloodSuitTbl == nil then
        return
    end
    uiTransferManager:TransferToEquipBloodPanel(bloodSuitTbl:GetQualityLevel())
end

---单物品推送提示使用点击
---@param bagItemInfo bagV2.BagItemInfo
function UIMainHint_BetterBagItem:OnSingleItemHintUsed(bagItemInfo, itemTbl, hintType)
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal,
                                               chosenBagItemIDs = { bagItemInfo.lid },
                                               focusedBagItemInfo = bagItemInfo,
                                               openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
end

function UIMainHint_BetterBagItem:OnRefineMeltingHintUsed(bagItemInfo, itemTbl, hintType)
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Smelt);
end

---灵兽装备提示使用事件
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem:OnServantEquipHintUsed(bagItemInfo, itemTbl, hintType)
    local servantIndex = 1
    local transferType = LuaEnumTransferType.Servant_Base_HM
    if hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM then
        ---寒芒
        servantIndex = 1
        transferType = LuaEnumTransferType.Servant_Base_HM
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX then
        ---落星
        servantIndex = 2
        transferType = LuaEnumTransferType.Servant_Base_LX
    elseif hintType == LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC then
        ---天成
        servantIndex = 3
        transferType = LuaEnumTransferType.Servant_Base_TC
    end
    uiTransferManager:TransferToPanel(transferType,
            {
                type = LuaEnumServantPanelType.BasePanel,
                servantIndex = servantIndex - 1,
                openSourceType = LuaEnumPanelOpenSourceType.ByServantHint
            },
            function()
                uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant })
            end)
end

--[[******************************************* 类重写 *******************************************]]
---开启动画播放完毕
---@protected
function UIMainHint_BetterBagItem:OnOpenFinished()
    self.isOpen = true
end

---关闭动画播放完毕
---@param withAnimation boolean 是否播放了关闭动画
---@protected
function UIMainHint_BetterBagItem:OnCloseFinished(withAnimation)
    luaclass.BetterItemHint_Control:CloseAllAutoUseHintItems()
    self.isOpen = false
end

function UIMainHint_BetterBagItem:OnDestroy()
    if self.update ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.update)
    end
    self.update = nil
end
--[[******************************************* update *******************************************]]
function UIMainHint_BetterBagItem:CreateUpdate()
    self.update = CS.CSListUpdateMgr.Add(200, nil, function()
        self:OnUpdate()
    end, true)
end

---不受界面enable影响的update
function UIMainHint_BetterBagItem:OnUpdate()
    if self.autoClickHintType == nil or self.autoClickHintEndTime == nil or self.autoClickHintType ~= self.mCurrentBetterBagItemType or self.mBagItemInfo ~= self.autoClickHintBagItemInfo then
        return
    end
    self:RefreshBtnName()
    self:TryAutoClickHint()
end

--[[******************************************* 倒计时自动点击推送 *******************************************]]
---初始化自动点击提示参数
function UIMainHint_BetterBagItem:InitAutoClickHintParams()
    local autoClickHintTotalTime = LuaGlobalTableDeal:GetBetterItemHintAutoClickHintTotalTime(self.mCurrentBetterBagItemType)
    if self.autoClickHintType == self.mCurrentBetterBagItemType and self.mBagItemInfo == self.autoClickHintBagItemInfo then
        return
    end
    if type(autoClickHintTotalTime) ~= 'number' then
        self:ResetAutoClickHintParams()
        return
    end
    self.autoClickHintType = self.mCurrentBetterBagItemType
    self.autoClickHintBagItemInfo = self.mBagItemInfo
    self.autoClickHintEndTime = CS.CSServerTime.Instance.TotalMillisecond + autoClickHintTotalTime * 1000
end

---重置自动点击推送参数
function UIMainHint_BetterBagItem:ResetAutoClickHintParams()
    self.autoClickHintType = nil
    self.autoClickHintBagItemInfo = nil
    self.autoClickHintEndTime = nil
end

---获取剩余时间
---@return number 秒
function UIMainHint_BetterBagItem:GetRemainTime()
    if type(self.autoClickHintEndTime) ~=  'number' then
        return
    end
    local remainTime = (self.autoClickHintEndTime - CS.CSServerTime.Instance.TotalMillisecond) / 1000
    if remainTime < 0 then
        remainTime = 0
    end
    return remainTime
end

---刷新按钮名字
function UIMainHint_BetterBagItem:RefreshBtnName()
    local remainTime = Utility.GetMaxIntPart(self:GetRemainTime())
    local btnName = self:GetHintBtnName(self.autoClickHintType)
    if CS.StaticUtility.IsNullOrEmpty(btnName) then
        return
    end
    local curShowBtnName = btnName .. "(" .. remainTime .. "S)"
    self:GetUseButtonLabel_UILabel().text = curShowBtnName
end

---尝试自动点击推送
function UIMainHint_BetterBagItem:TryAutoClickHint()
    local remainTime = self:GetRemainTime()
    if remainTime <= 0 then
        if self == nil then
            return
        end
        if self.mBagItemInfo == nil then
            self:Close(true)
            return
        end
        local itemTbl
        if self.mBagItemInfo then
            ___, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
        end
        self:ResetAutoClickHintParams()
        if self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.AvailableSkill then
            self:QuickUseSkill(self.mBagItemInfo,itemTbl,self.mCurrentBetterBagItemType)
        else
            self:OnUseButtonClicked()
        end
    end
end

---获取提示按钮名字
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return string 按钮名字
function UIMainHint_BetterBagItem:GetHintBtnName(hintType)
    if hintType == LuaEnumMainHint_BetterBagItemType.BetterEquip then
        return "立即装备"
    elseif hintType == LuaEnumMainHint_BetterBagItemType.AvailableSkill then
        return "学习"
    end
end
return UIMainHint_BetterBagItem