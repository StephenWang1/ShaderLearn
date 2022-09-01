---@class UIMainHint_BetterBagItem_HighLv:UIMainHint_BetterBagItem
local UIMainHint_BetterBagItem_HighLv = {}
setmetatable(UIMainHint_BetterBagItem_HighLv, luaComponentTemplates.UIMainHint_BetterBagItem)

--[[******************************************* 组件 *******************************************]]
---关闭按钮
---@return UnityEngine.GameObject
function UIMainHint_BetterBagItem_HighLv:GetCloseButton_GameObject()
    if self.mCloseButton_GO == nil then
        self.mCloseButton_GO = self:Get("tipPanel/btn_close", "GameObject")
    end
    return self.mCloseButton_GO
end

---提示内容文本
---@return UILabel
function UIMainHint_BetterBagItem_HighLv:GetTipContent_UILabel()
    if self.mTipContent_UILabel == nil then
        self.mTipContent_UILabel = self:Get("tipPanel/content", "UILabel")
    end
    return self.mTipContent_UILabel
end

--[[******************************************* 重写子类 *******************************************]]
function UIMainHint_BetterBagItem_HighLv:RegisterAllComponents()
    self:RegisterSingleCollider("tipPanel/content")
    self:RegisterSingleCollider("tipPanel/btn_close")
    self:RegisterSingleTweenComponent("tipPanel")
end

function UIMainHint_BetterBagItem_HighLv:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:Close(true)
    end
    CS.UIEventListener.Get(self:GetTipContent_UILabel().gameObject).onClick = function()
        self:OnUseButtonClicked()
    end
end

---从缓存队列中获取提示
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
---@param hintReason LuaEnumBetterItemHintReason 提示触发来源
---@return boolean,bagV2.BagItemInfo
function UIMainHint_BetterBagItem_HighLv:GetHintFromCacheQueue(hintType,hintReason)
    local bagItemInfo
    local bagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    local curHintType = hintType
    if bagItemHint then
        if curHintType ~= LuaEnumMainHint_BetterBagItemType.None then
            local type = luaclass.BetterItemHint_Data:GetHintStateType(curHintType);
            if (type ~= LuaEnumBetterItemHintStateType.NONE) then
                bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBagItemInfoByReason(curHintType,hintReason)
                if bagItemInfo == nil then
                    bagItemInfo = bagItemHint:GetFirstItemInHintList(curHintType)
                end
            end
        else
            local hintTypeList = CS.Cfg_GlobalTableManager.Instance:GetDefinedHintTypeList()
            if hintTypeList ~= nil and hintTypeList.Count ~= nil and hintTypeList.Count > 0 then
                local length = hintTypeList.Count - 1
                for k = 0, length do
                    curHintType = hintTypeList[k]
                    local type = luaclass.BetterItemHint_Data:GetHintStateType(curHintType)
                    if (type == LuaEnumBetterItemHintStateType.TextHint) then
                        bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():GetBagItemInfoByReason(curHintType)
                        if bagItemInfo == nil then
                            bagItemInfo = bagItemHint:GetFirstItemInHintList(curHintType)
                        end
                        if bagItemInfo ~= nil then
                            break
                        end
                    end
                end
            end
        end
    end
    if bagItemInfo ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemData(bagItemInfo.lid) == nil then
        bagItemInfo = nil
    end
    if bagItemInfo == nil then
        curHintType = hintType
    end
    return curHintType, (bagItemInfo ~= nil), bagItemInfo
end

---对应类型是否需要显示
function UIMainHint_BetterBagItem_HighLv:NeedShowBetterBagItem(betterBagItemType)
    return true
end

---检测提示是否显示子类型物品
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return boolean
function UIMainHint_BetterBagItem_HighLv:CheckHintShowSubtypeItem(hintType)
    return false
end

---检查是否需要关闭提示
---@param hintType LuaEnumMainHint_BetterBagItemType
---@return boolean
function UIMainHint_BetterBagItem_HighLv:CheckNeedCloseHint(hintType)
    return true
end
--[[******************************************* 根据子类型刷新面板 *******************************************]]
---刷新面板
---@protected
function UIMainHint_BetterBagItem_HighLv:RefreshPanel()
    local itemTbl
    if self.mBagItemInfo then
        ___, itemTbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
    end
    if self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.Undefined or self.mCurrentBetterBagItemType == LuaEnumMainHint_BetterBagItemType.None then
        self:RefreshWithNone(self.mBagItemInfo, itemTbl)
    else
        local hintLabel = CS.Cfg_GlobalTableManager.Instance:GetHintTextByHintType(self.mCurrentBetterBagItemType)
        if CS.StaticUtility.IsNullOrEmpty(hintLabel) == true then
            self:Close(false)
            return
        end
        self:GetTipContent_UILabel().text = hintLabel
    end
end

function UIMainHint_BetterBagItem_HighLv:TryGetOtherHintItem(betterBagItemType, isHintAvailable, bagItemInfo)
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
            local hintLabel = CS.Cfg_GlobalTableManager.Instance:GetHintTextByHintType(v)
            if (curHintType == nowHintType or betterBagItemType == LuaEnumMainHint_BetterBagItemType.None) and self:NeedShowBetterBagItem(v) == true and hintLabel ~= nil then
                mBetterBagItemType, mIsHintAvailable, mBagItemInfo = self:GetHintFromCacheQueue(v)
                if mIsHintAvailable then
                    break
                end
            end
        end
    end
    return mBetterBagItemType, mIsHintAvailable, mBagItemInfo
end

--[[******************************************* 根据子类型调整使用方法 *******************************************]]
---推荐灵兽被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem_HighLv:OnServantRecommendUsed(bagItemInfo, itemTbl, hintType)
    local huanShouInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantInfoByItemInfo(itemTbl)
    if huanShouInfo then
        local type = huanShouInfo.type
        if type == luaEnumServantType.COMMON then
            type = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetBodyLowServantIndex()
        end
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { type = LuaEnumServantPanelType.BasePanel, servantIndex = type - 1, openSourceType = LuaEnumPanelOpenSourceType.ByServantHintHighLv }, function(panel)
            if panel ~= nil then
                --print("OnServantRecommendUsed" .. bagItemInfo.ItemTABLE.name)
                uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant_HighLv, focusedBagItemInfo = bagItemInfo, hintType = hintType, openSourceType = LuaEnumPanelOpenSourceType.ByServantHint })
            end
        end)
    end
end

---推荐灵兽肉身被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem_HighLv:OnServantBodyRecommendUsed(bagItemInfo, itemTbl, hintType)
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
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { type = LuaEnumServantPanelType.BasePanel, servantIndex = mServantIndex - 1, openSourceType = LuaEnumPanelOpenSourceType.ByServantHintHighLv },
                function(panel)
                    if panel ~= nil then
                        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant_HighLv, focusedBagItemInfo = bagItemInfo, hintType = hintType, openSourceType = LuaEnumPanelOpenSourceType.ByServantHint })
                    end
                end);
    end
end

---更好的装备被使用事件
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 物品数据
---@param hintType LuaEnumMainHint_BetterBagItemType 提示类型
function UIMainHint_BetterBagItem_HighLv:OnBetterEquipUsed(bagItemInfo, itemTbl, hintType)
    local customData = { type = LuaEnumLeftTagType.UIRolePanel }
    uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, function(panel)
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Role, focusedBagItemInfo = bagItemInfo, openSourceType = LuaEnumPanelOpenSourceType.ByItemHint })
    end)
end

---空的情况刷新(清空界面)
---@protected
---@param bagItemInfo bagV2.BagItemInfo 背包物品
---@param itemTbl TABLE.CFG_ITEMS 背包物品的表格数据
function UIMainHint_BetterBagItem_HighLv:RefreshWithNone(bagItemInfo, itemTbl)
    self:GetTipContent_UILabel().text = itemTbl.name
end


--[[******************************************* 倒计时自动点击推送 *******************************************]]
---初始化自动点击提示参数
function UIMainHint_BetterBagItem_HighLv:InitAutoClickHintParams()
end
return UIMainHint_BetterBagItem_HighLv