---高级回收背包,收藏家NPC
---@class UIBagMain_HighRecycle:UIBagMain_Normal
local UIBagMain_HighRecycle = {}

setmetatable(UIBagMain_HighRecycle, luaComponentTemplates.UIBagMainNormal)

---高级回收预览列表
---@public
---@return table<number, bagV2.BagItemInfo>
function UIBagMain_HighRecycle:GetHighRecyclePreviewList()
    if self.mHighRecyclePreviewList == nil then
        self.mHighRecyclePreviewList = {}
    end
    return self.mHighRecyclePreviewList
end

---高级回收背包可以拖拽物品
function UIBagMain_HighRecycle:IsItemDragAvailable()
    return true
end

---高级回收背包不显示扩展按钮
function UIBagMain_HighRecycle:IsShowExpandButton()
    return false
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_HighRecycle:IsShowRecycleButton()
    return false
end

---不使用服务器顺序
function UIBagMain_HighRecycle:IsUseServerOrder()
    return false
end

---高级回收背包不显示整理按钮
function UIBagMain_HighRecycle:IsShowTrimButton()
    return false
end

---高级回收的背包不显示预览的物品
function UIBagMain_HighRecycle:BagItemFilterFunction(bagItemInfo, itemInfo)
    for i, v in pairs(self:GetHighRecyclePreviewList()) do
        if v == bagItemInfo then
            return false
        end
    end
    return true
end

---向预览列表中加入物品
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean|nil 列表是否已满,列表满时返回true
function UIBagMain_HighRecycle:AddItemToPreviewList(bagItemInfo)
    if bagItemInfo == nil then
        return
    end
    for i, v in pairs(self:GetHighRecyclePreviewList()) do
        if v == bagItemInfo then
            return
        end
    end
    if luaEventManager.HasCallback(LuaCEvent.HighRecycleAddItemInHighRecyclePanel) then
        table.insert(self:GetHighRecyclePreviewList(), bagItemInfo)
        luaEventManager.DoCallback(LuaCEvent.HighRecycleAddItemInHighRecyclePanel, bagItemInfo)
        self:SetBagInfoIsDirty()
        self:GetBagPanel():RefreshGrids()
        return false
    end
    return true
end

---从预览列表中移除物品
---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_HighRecycle:RemoveItemFromPreviewList(bagItemInfo)
    if bagItemInfo == nil then
        return
    end
    local isChanged = false
    for i, v in pairs(self:GetHighRecyclePreviewList()) do
        if v == bagItemInfo then
            isChanged = true
            break
        end
    end
    if isChanged then
        ---在自己监听的事件中移除
        luaEventManager.DoCallback(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, bagItemInfo)
        self:SetBagInfoIsDirty()
        self:GetBagPanel():RefreshGrids()
    end
end

function UIBagMain_HighRecycle:BeforeRefreshAllGrids()
    if self:GetHighRecyclePreviewList() ~= nil then
        ---刷新格子前,清除预览列表中不处于背包中的对象
        local bagItems = CS.CSScene.MainPlayerInfo.BagInfo.BagItems
        if bagItems ~= nil then
            local indexToBeRemoved = {}
            ---获取需要移除的预览列表中的对象
            for i = 1, #self:GetHighRecyclePreviewList() do
                local bagItemTemp = self:GetHighRecyclePreviewList()[i]
                if bagItemTemp ~= nil and bagItems:ContainsKey(bagItemTemp.lid) == false then
                    table.insert(indexToBeRemoved, i)
                end
            end
            if #indexToBeRemoved > 0 then
                ---排序下索引
                table.sort(indexToBeRemoved)
                for i = #indexToBeRemoved, 1, -1 do
                    ---从后往前移除列表中对应位置的元素
                    self:RemoveItemFromPreviewList(self:GetHighRecyclePreviewList()[indexToBeRemoved[i]])
                end
            end
        end
    end
end

---不可高级回收的置灰
function UIBagMain_HighRecycle:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    self:RunBaseFunction("RefreshSingleGrid", bagGrid, bagItemInfo, itemTbl)
    if self:IsItemAvailableForHighRecycle(itemTbl) == false then
        self:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    end
end

function UIBagMain_HighRecycle:OnInit()
    self:RunBaseFunction("OnInit")
    self.mOnRemoveItemInHighRecyclePanelReceive = function(eventID, bagItemInfo)
        self:OnRemoveItemInHighRecyclePanelReceive(bagItemInfo)
    end
    self.mHighRecycleReqSaleEventReceive = function(eventID, msgData)
        self:OnHighRecycleReqSaleEventReceive(msgData)
    end
    self.mOnClearHighRecyclePreviewItemReceived = function(eventID, bagItemInfo)
        self:OnClearPreviewItemsReceived()
    end
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleClearPreviewItems, self.mOnClearHighRecyclePreviewItemReceived)
end

function UIBagMain_HighRecycle:OnEnable()
    self:RunBaseFunction("OnEnable")
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, self.mOnRemoveItemInHighRecyclePanelReceive)
    self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.HighRecycleReqSaleEvent, self.mHighRecycleReqSaleEventReceive)
end

function UIBagMain_HighRecycle:OnDisable()
    self:RunBaseFunction("OnDisable")
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.HighRecycleRemoveItemInHighRecyclePanel, self.mOnRemoveItemInHighRecyclePanelReceive)
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.HighRecycleReqSaleEvent, self.mHighRecycleReqSaleEventReceive)
end

function UIBagMain_HighRecycle:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    uimanager:ClosePanel("UIHighRecyclePanel")
end

function UIBagMain_HighRecycle:OnRemoveItemInHighRecyclePanelReceive(bagItemInfo)
    for i, v in pairs(self:GetHighRecyclePreviewList()) do
        if v == bagItemInfo then
            table.remove(self:GetHighRecyclePreviewList(), i)
            break
        end
    end
    self:SetBagInfoIsDirty()
    self:GetBagPanel():RefreshGrids()
end

---请求出售事件
---@param msgData table
function UIBagMain_HighRecycle:OnHighRecycleReqSaleEventReceive(msgData)
    local tableTemp = {}
    for i, v in pairs(msgData) do
        tableTemp[i] = v
    end
    uimanager:CreatePanel("UIExpBallEffectPanel", nil, tableTemp)
end

---清空预览物品
function UIBagMain_HighRecycle:OnClearPreviewItemsReceived()
    if #self:GetHighRecyclePreviewList() == 0 then
        return
    end
    Utility.ClearTable(self:GetHighRecyclePreviewList())
    self:SetBagInfoIsDirty()
    self:GetBagPanel():RefreshGrids()
end

---背包关闭按钮点击事件
---@return boolean
function UIBagMain_HighRecycle:OnBagCloseButtonClicked()
    --关闭背包时也关闭高级回收界面
    uimanager:ClosePanel("UIHighRecyclePanel")
    return true
end

---背包列表排序,可高级回收的放在前面,不可高级回收的放在后面
function UIBagMain_HighRecycle:BagItemListSortFunction(leftItem, rightItem)
    local leftIsAvailable = self:IsItemAvailableForHighRecycle(leftItem.ItemTABLE)
    local rightIsAvailable = self:IsItemAvailableForHighRecycle(rightItem.ItemTABLE)
    if leftIsAvailable and rightIsAvailable == false then
        return true
    elseif rightIsAvailable and leftIsAvailable == false then
        return false
    else
        if leftItem.bagIndex < rightItem.bagIndex then
            return true
        else
            return false
        end
    end
end

---格子单击事件
function UIBagMain_HighRecycle:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    if self:IsItemAvailableForHighRecycle(itemTbl) == false then
        Utility.ShowPopoTips(bagGrid.go, "此物品不可寄售", 290, "UIBagPanel")
    else
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            bagItemInfo = bagItemInfo,
            itemInfo = itemTbl,
            showRight = true,
            showBind = true,
            rightUpButtonsModule = luaComponentTemplates.UIHighRecyclePanel_PutInRightUpOperate,
        })
    end
end

---双击时存入高级回收的选中列表中
function UIBagMain_HighRecycle:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    if self:IsItemAvailableForHighRecycle(itemTbl) == false then
        Utility.ShowPopoTips(bagGrid.go, "此物品不可寄售", 290, "UIBagPanel")
    else
        if self:AddItemToPreviewList(bagItemInfo) then
            CS.Utility.ShowTips("寄售已满", 1.5, CS.ColorType.Yellow)
        end
    end
end

function UIBagMain_HighRecycle:IsGridCanBeDragged(bagGrid, bagItemInfo, itemTbl)
    if itemTbl then
        if self:IsItemAvailableForHighRecycle(itemTbl) == false then
            Utility.ShowPopoTips(bagGrid.go, "此物品不可寄售", 290, "UIBagPanel")
            return false
        else
            return true
        end
    else
        return true
    end
end

function UIBagMain_HighRecycle:OnGridEndBeingDragged(bagGrid, bagItemInfo, itemTbl, position, isDestroyed)
    if isDestroyed == false then
        local highRecyclePanel = uimanager:GetPanel("UIHighRecyclePanel")
        if highRecyclePanel and CS.StaticUtility.IsNull(highRecyclePanel.go) == false then
            local offsetX = highRecyclePanel.go.transform.position.x - position.x
            local offsetY = highRecyclePanel.go.transform.position.y - position.y
            if offsetX > -0.5 and offsetX < 0.5 and offsetY > -0.8 and offsetY < 0.8 then
                if self:IsItemAvailableForHighRecycle(itemTbl) == false then
                    Utility.ShowPopoTips(bagGrid.go, "此物品不可寄售", 290, "UIBagPanel")
                else
                    if self:AddItemToPreviewList(bagItemInfo) then
                        CS.Utility.ShowTips("寄售已满", 1.5, CS.ColorType.Yellow)
                    end
                end
            end
        end
    end
end

---物品是否可以高级回收
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_HighRecycle:IsItemAvailableForHighRecycle(itemTbl)
    if itemTbl == nil then
        return false
    end
    if self.mJudgeCache == nil then
        self.mJudgeCache = {}
    end
    if self.mJudgeCache[itemTbl] ~= nil then
        return self.mJudgeCache[itemTbl]
    end
    local res = false
    if itemTbl.highRecycle ~= nil and itemTbl.highRecycle.list.Count > 0 then
        res = true
    end
    self.mJudgeCache[itemTbl] = res
    return res
end

function UIBagMain_HighRecycle:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.HighRecycleClearPreviewItems, self.mOnClearHighRecyclePreviewItemReceived)
end

return UIBagMain_HighRecycle