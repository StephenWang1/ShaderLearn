---藏品回收背包
---@class UIBagMain_CollectionRecycle:UIBagMain_Normal
local UIBagMain_CollectionRecycle = {}

setmetatable(UIBagMain_CollectionRecycle, luaComponentTemplates.UIBagMainNormal)

--region 重写属性
function UIBagMain_CollectionRecycle:GetReversedExpandBagType()
    return LuaEnumBagType.Collection
end

function UIBagMain_CollectionRecycle:IsExpandBagPanel()
    return true
end

function UIBagMain_CollectionRecycle:IsUseServerOrder()
    return false
end

---禁用双击交互
---@return boolean
function UIBagMain_CollectionRecycle:IsItemDoubleClickedAvailable()
    return false
end

function UIBagMain_CollectionRecycle:GetExpandType()
    return LuaEnumBagPanelExpandType.Collection
end

function UIBagMain_CollectionRecycle:IsRecycleAvailable()
    return true
end
--endregion

--region 组件
---@return UIGridContainer
function UIBagMain_CollectionRecycle:GetRecycleOptionsGridContainer()
    if self.mRecycleOptionsGridContainer == nil then
        self.mRecycleOptionsGridContainer = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot_collection/view/recycle/ScrollView/RecycleOptions", "UIGridContainer")
    end
    return self.mRecycleOptionsGridContainer
end

---@return UIGridContainer
function UIBagMain_CollectionRecycle:GetRecycleEarningOptionGridContainer()
    if self.mRecycleEarningOptionGridContainer == nil then
        self.mRecycleEarningOptionGridContainer = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot_collection/view/recycle/view/RecycleEarning", "UIGridContainer")
    end
    return self.mRecycleEarningOptionGridContainer
end

---@return UnityEngine.GameObject
function UIBagMain_CollectionRecycle:GetRecycleButtonGo()
    if self.mRecycleButtonGo == nil then
        self.mRecycleButtonGo = self:GetBagPanel():GetCurComp("WidgetRoot/expandRoot_collection/view/recycle/events/Btn_Recycle", "GameObject")
    end
    return self.mRecycleButtonGo
end
--endregion

--region 属性
---当前选中的物品的lid列表
---@return table<number, boolean>
function UIBagMain_CollectionRecycle:GetSelectedBagItemList()
    if self.mSelectedBagItemList == nil then
        self.mSelectedBagItemList = {}
    end
    return self.mSelectedBagItemList
end

---设置背包物品选中状态
---@param bagItemLid number
---@param state boolean
---@param triggleRecycleEarningRefresh boolean
function UIBagMain_CollectionRecycle:SetBagItemSelected(bagItemLid, state, triggleRecycleEarningRefresh)
    self:GetSelectedBagItemList()[bagItemLid] = state == true
    if triggleRecycleEarningRefresh then
        self:RefreshRecycleEarning()
    end
end

---获取背包物品是否被选中了
---@param bagItemLid number
---@return boolean
function UIBagMain_CollectionRecycle:GetBagItemIsSelectedState(bagItemLid)
    return self:GetSelectedBagItemList()[bagItemLid] == true
end
--endregion

--region 刷新
function UIBagMain_CollectionRecycle:BeforeRefreshAllGrids()
    self:ClearUnExistBagItemLidsInSelectedList()
    self:RefreshRecycleOptions()
    self:SelectNewBagItemByRecycleOptions()
    self:RefreshRecycleEarning()
end

function UIBagMain_CollectionRecycle:RefreshRecycleOptions()
    local oldOptions = self.recycleOptions
    ---@type table<number, boolean>
    self.recycleOptions = {}
    for i = 1, #self:GetBagItemList() do
        local bagItemTemp = self:GetBagItemList()[i]
        local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemTemp)
        ---只处理藏品
        if itemTbl:GetType() == luaEnumItemType.Collection then
            self.recycleOptions[itemTbl:GetSubType()] = false
        end
    end
    ---重新读入之前设置的选项
    if oldOptions ~= nil then
        for i, v in pairs(self.recycleOptions) do
            self.recycleOptions[i] = oldOptions[i] == true
        end
    end
    ---刷新UI
    self:RefreshRecycleOptionUI()
end

function UIBagMain_CollectionRecycle:SelectNewBagItemByRecycleOptions()
    if self.recycleOptions == nil then
        return
    end
    local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
    if collectionInfo == nil then
        return
    end
    for i = 1, #self:GetBagItemList() do
        local bagItemTemp = self:GetBagItemList()[i]
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemTemp.itemId)
        if itemTbl ~= nil and itemTbl:GetType() == luaEnumItemType.Collection then
            ---只处理藏品
            local subType = itemTbl:GetSubType()
            if subType and self:GetSelectedBagItemList()[bagItemTemp.lid] == nil
                    and collectionInfo:GetCollectionItemByCollectionID(bagItemTemp.itemId) ~= nil
                    and Utility.GetArrowType(bagItemTemp) ~= LuaEnumArrowType.GreenArrow
                    and self.recycleOptions[subType] == true then
                self:SetBagItemSelected(bagItemTemp.lid, true)
            end
        end
    end
end

function UIBagMain_CollectionRecycle:RefreshRecycleOptionUI()
    self:GetRecycleOptionsGridContainer().MaxCount = Utility.GetTableCount(self.recycleOptions)
    local index = 0
    for i, v in pairs(self.recycleOptions) do
        local go = self:GetRecycleOptionsGridContainer().controlList[index]
        local subType = i
        ---@type UILabel
        local optionNameLabel = self:GetCurComp(go, "", "UILabel")
        local listTemp = clientTableManager.cfg_linkeffectManager:GetLinkEffectListByLinkEffectSubType(i)
        if listTemp and #listTemp > 0 then
            optionNameLabel.text = listTemp[1]:GetTipName()
        end
        ---@type UnityEngine.GameObject
        local checkGo = self:GetCurComp(go, "check", "GameObject")
        checkGo:SetActive(v == true)
        CS.UIEventListener.Get(go).onClick = function(goTemp)
            self:OnRecycleOptionClicked(goTemp, subType, checkGo)
        end
        index = index + 1
    end
end

---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_CollectionRecycle:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    ---刷新最基础的格子参数
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type ~= luaEnumItemType.Collection then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    else
        bagGrid:SetCompActive(bagGrid.Components.Check1, true)
        if self:GetBagItemIsSelectedState(bagItemInfo.lid) then
            ---被选中时
            bagGrid:SetCompSpriteName(bagGrid.Components.Check1, "check")
            if Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.GreenArrow or Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.YellowArrow then
                bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
            end
        else
            bagGrid:SetCompSpriteName(bagGrid.Components.Check1, "")
        end
    end
end

function UIBagMain_CollectionRecycle:BagItemListSortFunction(leftItem, rightItem)
    ---将藏品排在前面,非藏品放在后面
    local leftType = leftItem.ItemTABLE.type
    local leftSubType = leftItem.ItemTABLE.subType
    local rightType = rightItem.ItemTABLE.type
    local rightSubType = rightItem.ItemTABLE.subType
    if leftType ~= rightType then
        if leftType == luaEnumItemType.Collection then
            return true
        end
        if rightType == luaEnumItemType.Collection then
            return false
        end
    else
        if leftType == luaEnumItemType.Collection then
            if leftSubType == rightSubType then
                return leftItem.index < rightItem.index
            end
            return leftSubType < rightSubType
        else
            return leftItem.index < rightItem.index
        end
    end
end

---以不触发任何事件的形式设置回收选项的状态
---@private
---@param subType number
---@param state boolean
function UIBagMain_CollectionRecycle:SetRecycleOptionStateRatherThanTriggleEvent(subType, state)
    if subType == nil then
        return
    end
    self.recycleOptions[subType] = state == true
    self:RefreshRecycleOptionUI()
end

---清除选中列表中不存在的背包物品
---@private
function UIBagMain_CollectionRecycle:ClearUnExistBagItemLidsInSelectedList()
    local bagInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    for i, v in pairs(self:GetSelectedBagItemList()) do
        if bagInfo:GetBagItemData(i) == nil then
            self:GetSelectedBagItemList()[i] = nil
        end
    end
end

---刷新回收收益
---@public
function UIBagMain_CollectionRecycle:RefreshRecycleEarning()
    local bagItemList = self:GetBagItemList()
    local itemTblMgr = clientTableManager.cfg_itemsManager
    local earningItemCountDic = {}
    for i = 1, #bagItemList do
        local bagItemTemp = bagItemList[i]
        if self:GetBagItemIsSelectedState(bagItemTemp.lid) then
            local earning = itemTblMgr:GetRecycleFixEarning(bagItemTemp.itemId)
            if earning ~= nil then
                for itemID, amount in pairs(earning) do
                    if earningItemCountDic[itemID] ~= nil then
                        earningItemCountDic[itemID] = earningItemCountDic[itemID] + amount
                    else
                        earningItemCountDic[itemID] = amount
                    end
                end
            end
        end
    end
    self:GetRecycleEarningOptionGridContainer().MaxCount = Utility.GetTableCount(earningItemCountDic)
    local index = 0
    for itemID, amount in pairs(earningItemCountDic) do
        local go = self:GetRecycleEarningOptionGridContainer().controlList[index]
        ---@type UILabel
        local amountLabel = self:GetCurComp(go, "", "UILabel")
        ---@type UISprite
        local iconSprite = self:GetCurComp(go, "icon", "UISprite")
        amountLabel.text = tostring(amount)
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemID)
        iconSprite.spriteName = itemTbl:GetIcon()
        CS.UIEventListener.Get(go).onClick = function(goTemp)
            self:OnRecycleEarningGoClicked(goTemp, itemTbl)
        end
        index = index + 1
    end
end
--endregion

--region 初始化
function UIBagMain_CollectionRecycle:OnInit()
    self:RunBaseFunction("OnInit")
    CS.UIEventListener.Get(self:GetRecycleButtonGo()).onClick = function(go)
        self:OnRecycleButtonClicked(go)
    end
    self:GetBagPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRecycleEquipmentMessage, function()
        self:TriggleResRecycleEquipment()
    end)
end
--endregion

--region 网络事件
---触发回收成功事件
function UIBagMain_CollectionRecycle:TriggleResRecycleEquipment()
    if CS.StaticUtility.IsNull(self.go) or self.go.enabled == false then
        return
    end
    ---此处播放回收成功特效
    local effect = CS.UILocalScreenEffectLoader.Instance:CreateNewEffect()
    ---@type UICollectionPanel
    local collectionPanel = uimanager:GetPanel("UICollectionPanel")
    local position = self:GetBagPanel():GetScrollView().transform.parent.position
    if collectionPanel ~= nil then
        position = collectionPanel:GetLeftMainSwitchBtnGo().transform.position
        position.x = position.x + 0.05
        position.y = position.y + 0.3
    end
    effect:AddTimeLineData("700288", CS.UILayerType.TipsPlane, nil,
            { position = position, timePoint = 0 }, { position = position, timePoint = 5 })
    effect:Play()
end
--endregion

--region UI事件
---回收选项点击事件
---@private
---@param go UnityEngine.GameObject
---@param linkEffectSubType number
---@param checkGo UnityEngine.GameObject
function UIBagMain_CollectionRecycle:OnRecycleOptionClicked(go, linkEffectSubType, checkGo)
    local isChecked = self.recycleOptions[linkEffectSubType] == true
    isChecked = not isChecked
    self.recycleOptions[linkEffectSubType] = isChecked
    local collectionTblMgr = clientTableManager.cfg_collectionManager
    local linkEffectTblMgr = clientTableManager.cfg_linkeffectManager
    local Utility = Utility
    if isChecked then
        ---选项由false转true,将额外选中同类型非更好且已上架的的物品
        local bagItemList = self:GetBagItemList()
        for i = 1, #bagItemList do
            local bagItemTemp = bagItemList[i]
            local collectionTbl = collectionTblMgr:TryGetValue(bagItemTemp.itemId)
            local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemTemp)
            local collectionSubType = itemTbl:GetSubType()
            if collectionTbl ~= nil and collectionSubType == linkEffectSubType
                    and gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionItemByCollectionID(bagItemTemp.itemId) ~= nil then
                local arrowType = Utility.GetArrowType(bagItemTemp)
                if arrowType ~= LuaEnumArrowType.GreenArrow then
                    self:SetBagItemSelected(bagItemTemp.lid, true, false)
                end
            end
        end
    else
        ---选项由true转false,将取消选中所有同类型物品
        local bagItemList = self:GetBagItemList()
        for i = 1, #bagItemList do
            local bagItemTemp = bagItemList[i]
            local collectionTbl = collectionTblMgr:TryGetValue(bagItemTemp.itemId)
            local itemTbl = Utility.GetItemTblByBagItemInfo(bagItemTemp)
            local collectionSubType = itemTbl:GetSubType()
            if collectionTbl ~= nil and collectionSubType == linkEffectSubType then
                self:SetBagItemSelected(bagItemTemp.lid, false, false)
            end
        end
    end
    self:GetBagPanel():RefreshGrids()
    self:RefreshRecycleEarning()
end

---格子单击事件
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_CollectionRecycle:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if itemTbl == nil or itemTbl.type ~= luaEnumItemType.Collection then
        Utility.ShowPopoTips(bagGrid.go, "此面板不可操作", 290, "UIBagPanel")
        return
    end
    self:SetBagItemSelected(bagItemInfo.lid, self:GetBagItemIsSelectedState(bagItemInfo.lid) ~= true)
    local itemTblTemp = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    local subType = itemTblTemp:GetSubType()
    if subType ~= nil then
        if self:GetBagItemIsSelectedState(bagItemInfo.lid) then
            ---由未选中变为选中,应当设定该物品对应的选项开启
            self:SetRecycleOptionStateRatherThanTriggleEvent(subType, true)
        else
            ---由选中变为未选中,查询同类型藏品是否有被选中的,如果没有则取消选中该选项
            local bagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
            local isExist = false
            for lid, state in pairs(self:GetSelectedBagItemList()) do
                if state then
                    local bagItemData = bagMgr:GetBagItemData(lid)
                    local itemTblTemp2 = Utility.GetItemTblByBagItemInfo(bagItemData)
                    if bagItemData and itemTblTemp2:GetSubType() == subType then
                        isExist = true
                        break
                    end
                end
            end
            if isExist == false then
                self:SetRecycleOptionStateRatherThanTriggleEvent(subType, false)
            end
        end
    end
    bagGrid:Refresh()
    self:RefreshRecycleEarning()
end

---格子被长时间按下
---@protected
---@param bagGrid UIBagGrid 被拖拽的格子
---@param bagItemInfo bagV2.BagItemInfo 被拖拽格子的物品数据
---@param itemTbl TABLE.CFG_ITEMS 被拖拽物品表数据
function UIBagMain_CollectionRecycle:OnGridLongPressed(bagGrid, bagItemInfo, itemTbl)
    if itemTbl == nil or itemTbl.type ~= luaEnumItemType.Collection then
        Utility.ShowPopoTips(bagGrid.go, "此面板不可操作", 290, "UIBagPanel")
        return
    end
    if bagItemInfo then
        self:ShowItemInfo(bagItemInfo)
    end
end

---回收收益点击事件
---@param go UnityEngine.GameObject
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_CollectionRecycle:OnRecycleEarningGoClicked(go, itemTbl)
    if itemTbl == nil then
        return
    end
    local tblExist, tbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemTbl.id)
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        itemInfo = tbl,
    })
end

---回收按钮点击事件
---@param go UnityEngine.GameObject
function UIBagMain_CollectionRecycle:OnRecycleButtonClicked(go)
    ---向服务器请求回收这些藏品
    local collectionList = CS.System.Collections.Generic["List`1[System.Int64]"]()
    local bagInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    local isAnyBetterCollectionItem = false
    for i, v in pairs(self:GetSelectedBagItemList()) do
        if v then
            local bagItemInfo = bagInfo:GetBagItemData(i)
            if bagItemInfo and Utility.GetItemTblByBagItemInfo(bagItemInfo):GetType() == luaEnumItemType.Collection then
                collectionList:Add(bagItemInfo.lid)
                if isAnyBetterCollectionItem == false and Utility.GetArrowType(bagItemInfo) == LuaEnumArrowType.GreenArrow then
                    isAnyBetterCollectionItem = true
                end
            end
        end
    end
    if isAnyBetterCollectionItem then
        local wordTbl, tblExist
        tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(13)
        if tblExist and wordTbl then
            Utility.ShowSecondConfirmPanel({ PromptWordId = 13, ComfireAucion = function()
                networkRequest.ReqRecycleEquipment(collectionList, 0)
            end })
        else
            networkRequest.ReqRecycleEquipment(collectionList, 0)
        end
    else
        networkRequest.ReqRecycleEquipment(collectionList, 0)
    end
end
--endregion

return UIBagMain_CollectionRecycle