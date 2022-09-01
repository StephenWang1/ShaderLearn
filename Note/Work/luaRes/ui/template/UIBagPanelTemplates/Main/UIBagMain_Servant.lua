---背包与灵兽界面组合时
---@class UIBagMainServant:UIBagMain_Normal
local UIBagMain_Servant = {}

setmetatable(UIBagMain_Servant, luaComponentTemplates.UIBagMainNormal)

---推荐的灵兽蛋的lid
---@type number
UIBagMain_Servant.mRecommendedServantEggLID = nil
---推荐的灵兽肉身装备脑的lid
---@type number
UIBagMain_Servant.mRecommendedServantBodyNaoEquipLID = nil
---推荐的灵兽肉身装备心的lid
---@type number
UIBagMain_Servant.mRecommendedServantBodyXinEquipLID = nil
---推荐的灵兽肉身装备骨的lid
---@type number
UIBagMain_Servant.mRecommendedServantBodyGuEquipLID = nil
---推荐的灵兽肉身装备血的lid
---@type number
UIBagMain_Servant.mRecommendedServantBodyXueEquipLID = nil
---推荐的灵兽装备的lid集合
---@type number
UIBagMain_Servant.mRecommendedServantEquipLIDs = nil
---是否是第一次打开
---@type boolean
UIBagMain_Servant.mIsFirstTimeForRefreshFocusItem = nil
---灵兽界面的类型
---@type 元灵界面类型
UIBagMain_Servant.mServantPanelType = nil
---灵兽界面灵兽位的类型
---@type luaEnumServantSeatType
UIBagMain_Servant.mServantPanelServantSeatType = nil

---背包提示
---@return CSBagItemHint
function UIBagMain_Servant:GetBagItemHint()
    if self.mBagItemHint == nil and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo ~= nil then
        self.mBagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    end
    return self.mBagItemHint
end

--region 重写初始化
function UIBagMain_Servant:OnInit()
    self:RunBaseFunction("OnInit")
    self.mFirstTime = true
    ---@type CSServantInfoV2
    self.mServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    self.mIsFirstTimeForRefreshFocusItem = true
    if self:GetBagPanel() ~= nil then
        self:GetBagPanel():GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantLevelUp, function()
            if self:IsOn() then
                self:SetBagInfoIsDirty()
                self:GetBagPanel():RefreshGrids()
            end
        end)
        self:GetBagPanel():GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantReinLevelUp, function()
            if self:IsOn() then
                self:SetBagInfoIsDirty()
                self:GetBagPanel():RefreshGrids()
            end
        end)
        self:GetBagPanel():GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(msgID, panelName)
            if self:IsOn() and self:GetBagPanel() ~= nil and panelName == "UIServantPanel" then
                if self:GetBagPanel():GetPanelOpenSourceType() == LuaEnumPanelOpenSourceType.ByServantPanel then
                    uimanager:ClosePanel("UIBagPanel")
                else
                    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal })
                end
            end
        end)
        self:GetBagPanel():GetClientEventHandler():AddEvent(CS.CEvent.OpenPanel, function(msgID, panelName)
            if self:IsOn() and self:GetBagPanel() ~= nil and panelName == "UIServantPanel" then
                self:SetBagInfoIsDirty()
                self:GetBagPanel():RefreshGrids()
            end
        end)
    end
end

function UIBagMain_Servant:OnEnable()
    self:RunBaseFunction("OnEnable")
    if self.mFirstTime then
        self.mFirstTime = nil
        return
    end
    if uimanager:GetPanel("UIServantPanel") == nil and uimanager:IsGoingToOpenPanel("UIServantPanel") == false then
        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal })
        return
    end
end
--endregion

--region 重写属性
---是否使用服务器排序
function UIBagMain_Servant:IsUseServerOrder()
    return false
end
--endregion

--region 依据高亮的物品刷新锁定的背包物品
---依据高亮的物品刷新锁定的背包物品
---@private
function UIBagMain_Servant:RefreshFocusedBagItem()
    local previousFocusedItem = self.mFocusedBagItem
    ---@type CSBagInfoV2
    local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo
    if previousFocusedItem == nil or self.mFocusedBagItem.ItemTABLE._ServantDesc._IsServantRelated == false then
        ---之前的锁定的物品为空或不为灵兽相关类型时,从高亮的物品中找一个锁定的物品
        self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantEggLID)
        if self.mFocusedBagItem == nil then
            self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyNaoEquipLID)
        end
        if self.mFocusedBagItem == nil then
            self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyXinEquipLID)
        end
        if self.mFocusedBagItem == nil then
            self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyGuEquipLID)
        end
        if self.mFocusedBagItem == nil then
            self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyXueEquipLID)
        end
        if self.mFocusedBagItem == nil and self.mRecommendedServantEquipLIDs ~= nil and self.mRecommendedServantEquipLIDs.Count > 0 then
            for i = 0, self.mRecommendedServantEquipLIDs.Count - 1 do
                if self.mFocusedBagItem == nil then
                    self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantEquipLIDs[i])
                else
                    break
                end
            end
        end
    else
        ---之前的锁定的物品不为空时,若为灵兽蛋类型,则锁定到高亮的灵兽蛋;若为灵兽装备类型,则锁定到高亮的同灵兽装备位的灵兽装备
        local desc = self.mFocusedBagItem.ItemTABLE._ServantDesc
        if desc._IsServantEgg and self.mRecommendedServantEggLID ~= nil then
            self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantEggLID)
        end
        if desc._IsServantBodyEquip then
            if desc._ServantBodyEquipPos == 1 then
                ---脑
                self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyNaoEquipLID)
            end
            if desc._ServantBodyEquipPos == 2 then
                ---心
                self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyXinEquipLID)
            end
            if desc._ServantBodyEquipPos == 3 then
                ---骨
                self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyGuEquipLID)
            end
            if desc._ServantBodyEquipPos == 4 then
                ---血
                self.mFocusedBagItem = bagItemInfo:GetBagItemBylId(self.mRecommendedServantBodyXueEquipLID)
            end
        end
    end
end
--endregion

--region 重写刷新格子方法
function UIBagMain_Servant:SetBagInfoIsDirty()
    self:RunBaseFunction("SetBagInfoIsDirty")
    self:ClearBagItemInfoCompareStates()
end

---刷新所有格子之前,获取推荐学习的技能书列表
function UIBagMain_Servant:BeforeRefreshAllGrids()
    self.mainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
    self.mainPlayerReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
    ---@type UIServantPanel
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    if servantPanel ~= nil and servantPanel.ServantIndex ~= nil then
        self.mServantPanelType = servantPanel.ServantNavType
        self.mServantPanelServantSeatType = servantPanel.ServantIndex + 1
        --local currentServantType = servantPanel:GetSelectHeadInfo():GetServantType()
        if self.mServantInfo ~= nil then
            ___, self.mCurrentServant = self.mServantInfo.Servants:TryGetValue(self.mServantPanelServantSeatType)
        else
            ---@type servantV2.ServantInfo
            self.mCurrentServant = nil
        end
        self:RefreshHintList()
    else
        self.mServantPanelType = nil
        self.mServantPanelServantSeatType = nil
        self.mRecommendedServantBodyXueEquipLID = nil
        self.mRecommendedServantBodyGuEquipLID = nil
        self.mRecommendedServantBodyXinEquipLID = nil
        self.mRecommendedServantBodyNaoEquipLID = nil
        self.mRecommendedServantEggLID = nil
    end
    if self.mIsFirstTimeForRefreshFocusItem then
        ---限制一下,仅在第一次刷新时刷新锁定的物品
        self.mIsFirstTimeForRefreshFocusItem = nil
        self:RefreshFocusedBagItem()
    end
end

---刷新单个格子方法
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Servant:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self:FilterLightBagItem(bagItemInfo, itemTbl) == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    else
        local lid = bagItemInfo.lid
        if lid ~= nil and (self.mRecommendedServantEggLID == lid
                or self.mRecommendedServantBodyNaoEquipLID == lid
                or self.mRecommendedServantBodyXinEquipLID == lid
                or self.mRecommendedServantBodyGuEquipLID == lid
                or self.mRecommendedServantBodyXueEquipLID == lid)
                or (self.mRecommendedServantEquipLIDs ~= nil and self.mRecommendedServantEquipLIDs:Contains(lid))
        then
            bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
        end
    end
end

---刷新提示列表
function UIBagMain_Servant:RefreshHintList()
    ---@type UIServantPanel
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    local isServantPushout = servantPanel:GetSelectHeadInfo().id ~= 0
    local typeInServantPanel = servantPanel:GetSelectHeadInfo():GetServantType()
    ---@type CSServantInfoV2
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if self:GetBagItemHint() ~= nil then

        --region 获取最佳的灵兽蛋
        ---@type bagV2.BagItemInfo
        local bestEggInBag = nil
        if CS.CSScene.MainPlayerInfo.Level <= CS.Cfg_GlobalTableManager.Instance:GetLingShouEggUseHintLvMax() then
            bestEggInBag = servantInfo:GetBestServantEggForServantType(typeInServantPanel)
        end
        if bestEggInBag ~= nil then
            self.mRecommendedServantEggLID = bestEggInBag.lid
        else
            self.mRecommendedServantEggLID = nil
        end
        --endregion

        --region 获取最佳的灵兽肉身装备
        if isServantPushout then
            ---灵兽界面的灵兽位有灵兽时,推荐灵兽肉身装备(如果有的话)
            ---@type bagV2.BagItemInfo
            local nao, xin, gu, xue
            if typeInServantPanel ~= nil then
                if CS.CSScene.MainPlayerInfo.Level <= CS.Cfg_GlobalTableManager.Instance:GetLingShouEggUseHintLvMax() then
                    nao, xin, gu, xue = servantInfo:GetBestBodyEquipForCurrentServant(typeInServantPanel)
                end
                if nao ~= nil then
                    self.mRecommendedServantBodyNaoEquipLID = nao.lid
                else
                    self.mRecommendedServantBodyNaoEquipLID = nil
                end
                if xin ~= nil then
                    self.mRecommendedServantBodyXinEquipLID = xin.lid
                else
                    self.mRecommendedServantBodyXinEquipLID = nil
                end
                if gu ~= nil then
                    self.mRecommendedServantBodyGuEquipLID = gu.lid
                else
                    self.mRecommendedServantBodyGuEquipLID = nil
                end
                if xue ~= nil then
                    self.mRecommendedServantBodyXueEquipLID = xue.lid
                else
                    self.mRecommendedServantBodyXueEquipLID = nil
                end
            else
                self.mRecommendedServantBodyNaoEquipLID = nil
                self.mRecommendedServantBodyXinEquipLID = nil
                self.mRecommendedServantBodyGuEquipLID = nil
                self.mRecommendedServantBodyXueEquipLID = nil
            end
        else
            ---灵兽界面的灵兽位没有灵兽时,不推荐灵兽肉身装备
            self.mRecommendedServantBodyNaoEquipLID = nil
            self.mRecommendedServantBodyXinEquipLID = nil
            self.mRecommendedServantBodyGuEquipLID = nil
            self.mRecommendedServantBodyXueEquipLID = nil
        end
        --endregion

        --region 获取最佳的灵兽装备
        self.mRecommendedServantEquipLIDs = {}
        local servantType = CS.ServantSpeciesType.None
        if typeInServantPanel == LuaEnumServantSpeciesType.First then
            servantType = CS.ServantSpeciesType.HM
        elseif typeInServantPanel == LuaEnumServantSpeciesType.Second then
            servantType = CS.ServantSpeciesType.LX
        elseif typeInServantPanel == LuaEnumServantSpeciesType.Third then
            servantType = CS.ServantSpeciesType.TC
        end
        ---此处实质上已经是一个C#的List<long>了
        self.mRecommendedServantEquipLIDs = CS.CSScene.MainPlayerInfo.BagInfo:FilterServantEquip(self.mRecommendedServantEquipLIDs, servantType)
        --endregion
    else
        ---清空所有推荐的ID
        self.mRecommendedServantEggLID = nil
        self.mRecommendedServantBodyNaoEquipLID = nil
        self.mRecommendedServantBodyXinEquipLID = nil
        self.mRecommendedServantBodyGuEquipLID = nil
        self.mRecommendedServantBodyXueEquipLID = nil
        self.mRecommendedServantEquipLIDs = nil
    end
end

---获取单个类型和通用的推荐装备中最好的
---@private
---@param commonItem bagV2.BagItemInfo
---@param typeItem bagV2.BagItemInfo
---@return number,bagV2.BagItemInfo
function UIBagMain_Servant:GetBestRecommendedEquipWithTypeAndCommon(commonItem, typeItem)
    ---@type bagV2.BagItemInfo
    local selectedItem
    if commonItem == nil or typeItem == nil then
        if commonItem == nil then
            selectedItem = typeItem
        else
            selectedItem = commonItem
        end
    else
        local res = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsBetterBodyEquip(commonItem, typeItem)
        if res == true then
            selectedItem = commonItem
        else
            selectedItem = typeItem
        end
    end
    if selectedItem then
        return selectedItem.lid, selectedItem
    end
    return
end

---获取列表中推荐的灵兽脑，心，骨，血的物品
---@private
---@param list LuaEnumMainHint_BetterBagItemType
---@return bagV2.BagItemInfo,bagV2.BagItemInfo,bagV2.BagItemInfo,bagV2.BagItemInfo
function UIBagMain_Servant:GetServantBodyRecommendedEquipByBodyType(list)
    if list == nil or list.Count == nil or list.Count == 0 then
        return
    end
    local nao, xin, gu, xue
    local count = list.Count
    ---@type CSBagInfoV2
    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    ---@type CSServantInfoV2
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
    if bagInfo == nil or servantInfo == nil then
        return
    end
    for i = 0, count - 1 do
        local id = list[i]
        ---@type bagV2.BagItemInfo
        local bagItem = bagInfo:GetBagItemBylId(id)
        if bagItem ~= nil and bagItem.ItemTABLE ~= nil and bagItem.ItemTABLE.type == luaEnumItemType.Equip then
            local bodyIndex = servantInfo:GetServantBodyIndex(bagItem.ItemTABLE.subType)
            if bodyIndex ~= -1 then
                local bodyType = bodyIndex % 10
                if bodyType == 1 then
                    nao = bagItem
                elseif bodyType == 2 then
                    xin = bagItem
                elseif bodyType == 3 then
                    gu = bagItem
                elseif bodyType == 4 then
                    xue = bagItem
                end
            end
        end
    end
    return nao, xin, gu, xue
end

---获取提示列表中的第一个物品
---@private
---@param betterBagItemHintType LuaEnumMainHint_BetterBagItemType
---@return number,bagV2.BagItemInfo
function UIBagMain_Servant:GetFirstItemInHintList(betterBagItemHintType)
    local list = self:GetBagItemHint():GetHintList(betterBagItemHintType)
    local id = self:GetFirstItemOrNil(list)
    if id ~= nil then
        local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemBylId(id)
        if bagItem ~= nil then
            return id, bagItem
        else
            return nil, nil
        end
    else
        return nil, nil
    end
end

---@private
---获取列表中的第一个值,或nil
---@param list System.Collections.Generic.List1T
---@return number
function UIBagMain_Servant:GetFirstItemOrNil(list)
    if list then
        local count = list.Count
        if count ~= nil and count > 0 then
            return list[0]
        else
            return nil
        end
    else
        return nil
    end
end

---筛选出亮的物品(正常显示的物品,否则灰色显示该物品)
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Servant:FilterLightBagItem(bagItemInfo, itemTbl)
    local itemType = itemTbl.type
    local itemSubType = itemTbl.subType
    if itemType == luaEnumItemType.HunJi and (itemSubType == 0 or self.mServantPanelServantSeatType == itemSubType) then
        ---@type CSServantSeatData_MainPlayer
        local seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.mServantPanelServantSeatType)
        if seatData == nil then
            return true
        end
        return seatData:IsHunJiAvailableToForSeat(bagItemInfo)
    end
    if itemType == luaEnumItemType.Equip then
        if CS.CSServantInfoV2.IsRoleEquipAvailableForServant(itemSubType) then
            return gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(self.mServantPanelServantSeatType)
        end
    end

    local IsSameServantTypeWithServant = self:IsSameServantTypeWithServantPanel(bagItemInfo, itemTbl)
    local IsServantBagItemUseable = self:IsServantBagItemUseable(bagItemInfo, itemTbl)

    return IsSameServantTypeWithServant and IsServantBagItemUseable
end

---灵兽物品是否可用
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Servant:IsServantBagItemUseable(bagItemInfo, itemTbl)
    if itemTbl.type == luaEnumItemType.Assist or itemTbl.subType == 8 then
        ---灵兽蛋的是否能使用根据等级判断
        if itemTbl and self.mainPlayerReinLevel and self.mainPlayerLevel then
            return clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemTbl.id) == LuaEnumUseItemParam.CanUse
            --return itemTbl.useLv <= self.mainPlayerLevel and itemTbl.reinLv <= self.mainPlayerReinLevel
        end
        return false
    end
    if itemTbl.type == luaEnumItemType.Equip and self.mCurrentServant ~= nil then
        return clientTableManager.cfg_itemsManager:CanUseItem(itemTbl.id, self.mCurrentServant.level, self.mCurrentServant.rein) == LuaEnumUseItemParam.CanUse
        --return itemTbl.useLv <= self.mCurrentServant.level and itemTbl.reinLv <= self.mCurrentServant.rein
    end
    if self.mServantPanelType == LuaEnumServantPanelType.HunJiPanel then
        return itemTbl.type == luaEnumItemType.HunJi
    end
    return self:GetServantReinOrLevelBagItem(itemTbl)
end

---是否与灵兽界面同为同类型灵兽物品
---@private
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean
function UIBagMain_Servant:IsSameServantTypeWithServantPanel(bagItemInfo, itemTbl)
    local res
    ___, ___, ___, ___, ___, ___, ___, res = self:GetBagItemInfoCompareState(bagItemInfo, itemTbl)
    return res
end
--endregion

--region 重写格子排序方法
function UIBagMain_Servant:BagItemListSortFunction(LeftItem, RightItem)
    local filter = self:SortItemInBag(LeftItem, RightItem)
    return self:SortItemInBag(LeftItem, RightItem)
end

---装备灵兽蛋排序
---@param LeftItem bagV2.BagItemInfo
---@param RightItem bagV2.BagItemInfo
function UIBagMain_Servant:SortItemInBag(LeftItem, RightItem)
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    if servantPanel == nil then
        return self:SortByServerIndex(LeftItem, RightItem)
    end
    local leftTbl = LeftItem.ItemTABLE
    local rightTbl = RightItem.ItemTABLE
    local isLeftGray = self:FilterLightBagItem(LeftItem, leftTbl)
    local isRightGray = self:FilterLightBagItem(RightItem, rightTbl)
    ---先将亮的区域和暗的区域分开
    if isLeftGray ~= isRightGray then
        return isLeftGray
    end
    local isLeftServantEgg, isLeftServantFragment, isLeftServantEquip, isLeftBodyServantEquip, isLeftServantRelatedBagItem, isLeftReinOrLevelItem, isLeftSameWithServantPanel = self:GetBagItemInfoCompareState(LeftItem, leftTbl)
    local isRightServantEgg, isRightServantFragment, isRightServantEquip, isRightBodyServantEquip, isRightServantRelatedBagItem, isRightReinOrLevelItem, isRightSameWithServantPanel = self:GetBagItemInfoCompareState(RightItem, rightTbl)
    if isLeftServantRelatedBagItem ~= isRightServantRelatedBagItem then
        ---若两者中只有一个物品是灵兽相关物品,则将灵兽相关物品放在前面
        return isLeftServantRelatedBagItem
    elseif isLeftServantRelatedBagItem then
        if (isLeftReinOrLevelItem ~= isRightReinOrLevelItem) then
            return isLeftReinOrLevelItem
        end
        if isLeftSameWithServantPanel ~= isRightSameWithServantPanel then
            return isLeftSameWithServantPanel
        end
        if isLeftServantEgg ~= isRightServantEgg then
            return isLeftServantEgg
        end
        if isLeftServantFragment ~= isRightServantFragment then
            return isLeftServantFragment
        end
        if isLeftServantEquip ~= isRightServantEquip then
            return isLeftServantEquip
        end
        if isLeftBodyServantEquip ~= isRightBodyServantEquip then
            return isLeftBodyServantEquip
        end
        if leftTbl.reinLv ~= rightTbl.reinLv then
            return leftTbl.reinLv > rightTbl.reinLv
        else
            return leftTbl.useLv > rightTbl.useLv
        end
    end
    return self:SortByServerIndex(LeftItem, RightItem)
end

---根据服务器顺序排序
---@param LeftItem bagV2.BagItemInfo
---@param RightItem bagV2.BagItemInfo
---@return boolean
function UIBagMain_Servant:SortByServerIndex(LeftItem, RightItem)
    if LeftItem ~= nil and RightItem ~= nil and LeftItem.bagIndex < RightItem.bagIndex then
        return true
    else
        return false
    end
end
--endregion

--region 重写交互方法
function UIBagMain_Servant:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    if itemTbl and itemTbl.type == luaEnumItemType.HunJi then
        ---魂继装备被双击时
        if itemTbl.subType == 0 or self.mServantPanelServantSeatType == itemTbl.subType then
            self:DoOperateToBagItem(bagGrid, bagItemInfo, itemTbl)
        else
            self:ShowTipBubble(bagGrid.go, "与所选灵兽类型不符", 48)
        end
    else
        local isServantEgg, isServantFragment, isServantEquip, isServantMagicWeapon, isBodyServantEquip, isServantRelatedBagItem, isServantReinOrLevelBagItem, isSameWithServantPanel, isRoleEquipThatCanBeUsedByServant = self:GetBagItemInfoCompareWithWithServantPanel(bagItemInfo, itemTbl)
        local servantIndexIsUnLock = self.mServantInfo:ServantIndexIsOpen(uiStaticParameter.SelectedServantType)
        ---非魂继界面或魂继界面的非魂继装备
        if servantIndexIsUnLock == false then
            self:ShowTipBubble(bagGrid.go, nil, 250)
        elseif isServantRelatedBagItem == false then
            self:ShowTipBubble(bagGrid.go, "该面板不可进行此操作", 48)
        elseif isSameWithServantPanel == false then
            self:ShowTipBubble(bagGrid.go, "与所选灵兽类型不符", 48)
        else
            if isRoleEquipThatCanBeUsedByServant then
                ---角色装备如果不能用于灵兽身上,则不请求并弹出气泡
                ---@type CSServantSeatData_MainPlayer
                local mainPlayerServantSeatData = self.mServantInfo.MainPlayerServantData:GetServantSeatData(uiStaticParameter.SelectedServantType)
                if mainPlayerServantSeatData ~= nil then
                    local res = clientTableManager.cfg_itemsManager:CanUseItem(bagItemInfo.itemId, mainPlayerServantSeatData.Level, mainPlayerServantSeatData.ReinLevel)
                    if res == LuaEnumUseItemParam.UseReinLvNotEnough then
                        Utility.ShowPopoTips(bagGrid.go, "灵兽转生等级不足", 205, "UIBagPanel")
                        return
                    elseif res == LuaEnumUseItemParam.UseLvNotEnough then
                        Utility.ShowPopoTips(bagGrid.go, "灵兽等级不足", 205, "UIBagPanel")
                        return
                    end
                end
            end
            self:DoOperateToBagItem(bagGrid, bagItemInfo, itemTbl)
        end
    end
end
--endregion

--region 重写析构方法
function UIBagMain_Servant:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    if self:GetBagPanel() ~= nil and self:GetBagPanel():GetPanelOpenSourceType() == LuaEnumPanelOpenSourceType.ByServantHint then
        ---@type UIServantPanel
        local uiservantPanel = uimanager:GetPanel("UIServantPanel")
        if uiservantPanel ~= nil and uiservantPanel.ServantNavType ~= LuaEnumServantPanelType.LevelPanel then
            ---做一下特殊处理,如果是等级界面则不关闭灵兽界面,避免点击修炼按钮后同时关闭了灵兽界面
            uimanager:ClosePanel("UIServantPanel")
        end
    end
end
--endregion

---获取背包物品与灵兽界面对比得到的信息
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean,boolean,boolean,boolean,boolean,boolean,boolean,boolean,boolean 是否是灵兽蛋|是否是灵兽精魄|是否是生肖装备|是否是法宝|是否是肉身装备|灵力经验丹等|是否是灵兽相关物品|是否与灵兽界面当前选中类型一致|是否是灵兽可用的角色装备
function UIBagMain_Servant:GetBagItemInfoCompareWithWithServantPanel(bagItemInfo, itemTbl)
    if bagItemInfo == nil or itemTbl == nil then
        return false, false, false, false, false, false, false, false, false
    end
    local isServantEgg = itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 8
    local isServantFragment = itemTbl.type == luaEnumItemType.ServantFragment
    local isServantEquip = bagItemInfo.IsServantEquip --CS.CSServantInfoV2.IsServantJustEquip(itemTbl)
    local isBodyServantEquip = bagItemInfo.IsServantBodyEquip   --CS.CSServantInfoV2.IsServantBody(itemTbl)
    local isServantMagicWeapon = bagItemInfo.IsServantMagicWeapon
    local isServantReinOrLevelBagItem = self:GetServantReinOrLevelBagItem(itemTbl)
    local isRoleEquipThatServantCanEquip = CS.CSServantInfoV2.IsRoleEquipAvailableForServant(itemTbl)
    local isServantRelatedBagItem = (isServantEgg or isServantFragment or isServantEquip or isBodyServantEquip or isServantReinOrLevelBagItem or isServantMagicWeapon or isRoleEquipThatServantCanEquip) == true
    ---@type UIServantPanel
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    local isSameWithServantPanelType = false
    if servantPanel and servantPanel.ServantIndex then
        --灵兽可穿戴的人物装备
        if (itemTbl.type == luaEnumItemType.Equip and CS.CSServantInfoV2.IsServantRoleEquip(itemTbl.subType)) then
            isSameWithServantPanelType = true;
        else
            local typeInServantPanel = servantPanel.ServantIndex + 1
            local servantType = self.mServantInfo:GetEquipServantType(itemTbl)
            isSameWithServantPanelType = servantType > 0 and (typeInServantPanel == servantType or servantType == 4)
        end
    end
    if (isServantReinOrLevelBagItem) then
        return isServantEgg, isServantFragment, isServantEquip, isServantMagicWeapon, isBodyServantEquip, isServantRelatedBagItem, isServantReinOrLevelBagItem, true, isRoleEquipThatServantCanEquip
    end
    return isServantEgg, isServantFragment, isServantEquip, isServantMagicWeapon, isBodyServantEquip, isServantRelatedBagItem, isServantReinOrLevelBagItem, isSameWithServantPanelType, isRoleEquipThatServantCanEquip
end

---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Servant:GetServantReinOrLevelBagItem(itemTbl)
    if itemTbl.type == 5 and (itemTbl.subType == 6 or itemTbl.subType == 2) then
        ---灵兽资源宝箱或灵兽经验丹
        return true
    end
    return false
end

---面板打开事件
---@protected
---@param panelName string
function UIBagMain_Servant:OnPanelOpened(panelName)
    if panelName == "UIServantPanel" then
        self:RefreshGrids()
    end
end

--region 优化
---获取背包物品比较状态,仅仅用于刷新格子时减少与C#之间的交互次数,处理单击双击等交互时还是使用之前的方法
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean,boolean,boolean,boolean,boolean,boolean,boolean 是否是灵兽蛋|是否是灵兽精魄|是否是生肖装备|是否是肉身装备|灵力经验丹等|是否是灵兽相关物品|是否与灵兽界面当前选中类型一致
function UIBagMain_Servant:GetBagItemInfoCompareState(bagItemInfo, itemTbl)
    if self.mBagItemInfoCompareStates == nil then
        self.mBagItemInfoCompareStates = {}
    end
    if bagItemInfo == nil or itemTbl == nil then
        return false, false, false, false, false, false, false, false
    end
    local id = bagItemInfo.lid
    local compareState = self.mBagItemInfoCompareStates[id]
    if compareState == nil then
        compareState = {}
        compareState.a, compareState.b, compareState.c, compareState.d, compareState.e, compareState.f, compareState.g, compareState.h = self:GetBagItemInfoCompareWithWithServantPanel(bagItemInfo, itemTbl)
        self.mBagItemInfoCompareStates[id] = compareState
    elseif compareState.isDirty == true then
        compareState.isDirty = false
        compareState.a, compareState.b, compareState.c, compareState.d, compareState.e, compareState.f, compareState.g, compareState.h = self:GetBagItemInfoCompareWithWithServantPanel(bagItemInfo, itemTbl)
    end
    return compareState.a, compareState.b, compareState.c, compareState.d, compareState.e, compareState.f, compareState.g, compareState.h
end

---清空背包物品比较状态
---在刷新背包物品之前处理
function UIBagMain_Servant:ClearBagItemInfoCompareStates()
    if self.mBagItemInfoCompareStates ~= nil then
        for i, v in pairs(self.mBagItemInfoCompareStates) do
            v.isDirty = true
        end
    end
end
--endregion

return UIBagMain_Servant