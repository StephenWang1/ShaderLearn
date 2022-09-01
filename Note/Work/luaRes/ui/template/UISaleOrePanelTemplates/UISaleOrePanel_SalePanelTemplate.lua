---@class UISaleOrePanel_SalePanelTemplate 出售面板模板
local UISaleOrePanel_SalePanelTemplate = {}

--region 初始化

function UISaleOrePanel_SalePanelTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UISaleOrePanel_SalePanelTemplate:InitParameters()
    self.TemplateDic = {}
    self.curTemp = nil
    self.taskInfo = nil
    self.npcType = 0
    self.comList = {}
    self.sortFunc = function(a, b)
        return self:SortItemList(a, b)
    end
end

function UISaleOrePanel_SalePanelTemplate:InitComponents()
    ---@type Top_UIGridContainer
    self.Templates = self:Get("Scroll View/Templates", "Top_UIGridContainer")
end

function UISaleOrePanel_SalePanelTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
end

---初始化模板
---@public
function UISaleOrePanel_SalePanelTemplate:SetTemplate(customData)
    if customData then
        self.taskInfo = customData.taskInfo
        self.npcType = customData.type
        networkRequest.ReqGetNpcStoreSellList(customData.type)
    end
end

--endregion

--region UI

---刷新任务信息
---@public
function UISaleOrePanel_SalePanelTemplate:RefreshTaskMessage(info)
    self.taskInfo = info
end

---刷新面板状态
---@public
function UISaleOrePanel_SalePanelTemplate:SetOpenState(isOpen)
    self.go:SetActive(isOpen)
end

---刷新买卖列表
---@public
function UISaleOrePanel_SalePanelTemplate:RefreshGrid(info)
    self:SelectItemList(info.npcStoreGrids)
    self.Templates.MaxCount = #self.comList
    for i = 1, #self.comList do
        local v = self.comList[i]
        local go = self.Templates.controlList[i - 1].gameObject
        ---@type UISaleOrePanel_UnitTemplate
        local temp = self.TemplateDic[go] ~= nil and self.TemplateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UISaleOrePanel_UnitTemplate)
        local infotemp = {}
        infotemp.index = i
        infotemp.itemId = 0
        --出售
        infotemp.tradType = 2
        if v.npcStoreItem.item ~= nil then
            infotemp.itemId = v.npcStoreItem.item.itemId
        else
            local isFind, info = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(v.npcStoreItem.npcShopId)
            if isFind then
                infotemp.itemId = info.itemId
            end
        end
        --改为背包中的count
        infotemp.stockNum = v.count
        infotemp.comId = v.npcStoreItem.npcShopId
        infotemp.bagItemInfo = v.npcStoreItem.item
        infotemp.price = v.npcStoreItem.priceCount
        infotemp.priceItemid = v.npcStoreItem.priceItemId
        infotemp.callBack = function(go)
            local tempInfo = {}
            tempInfo.info = v
            tempInfo.go = go
            if v.npcStoreItem.item ~= nil then
                tempInfo.lid = v.npcStoreItem.item.lid
            end
            tempInfo.itemId = v.npcStoreItem.item.itemId
            tempInfo.maxCount = temp.maxCount
            self.curTemp = tempInfo
            self:OnCilckUnitCallBack()
        end
        temp:SetTemplat(infotemp)
        if self.TemplateDic[go] == nil then
            self.TemplateDic[go] = temp
        end
    end
end

---点击单元回调
---@private
function UISaleOrePanel_SalePanelTemplate:OnCilckUnitCallBack()
    if self.curTemp == nil then
        return
    end
    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.curTemp.itemId)
    if itemCount == 0 then
        Utility.ShowPopoTips(self.curTemp.go, nil, 62)
        return
    end
    if self.curTemp.maxCount <= 0 then
        Utility.ShowPopoTips(self.curTemp.go, nil, 42)
        return
    end
    self:ShowShopTips()
end

---显示商店tips
---@private
function UISaleOrePanel_SalePanelTemplate:ShowShopTips()
    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.curTemp.itemId)
    local info = {}
    info.MaxNum = itemCount
    info.priceDate = self.curTemp.info
    info.BagItemInfo = self.curTemp.info.npcStoreItem.item
    info.Template = luaComponentTemplates.UISaleOrePanel_SaleItemTemplate
    info.BuyCallBack = function(go, num)
        networkRequest.ReqNpcStorePutOn(self.curTemp.itemId, num, self.npcType)
        uimanager:ClosePanel('UIAuctionItemPanel')
    end

    uimanager:CreatePanel("UIAuctionItemPanel", nil, info)

    --local info = {}
    --info.lid = 0
    --info.itemid = self.curTemp.itemId
    --info.price = self.curTemp.priceCount
    --info.priceSprite = self.curTemp.priceItemId
    --local remain = self.curTemp.maxCount
    ----实时获取最新数量
    --local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(info.itemid)
    ----记录当前类型的数量
    --local itemCountofType = itemCount
    ----选择最小的
    --remain = itemCountofType < remain and itemCountofType or remain
    --info.maxValue = remain
    --if self.taskInfo ~= nil and self.taskInfo.curFillValue ~= nil and self.taskInfo.fillMaxValue ~= nil then
    --    if self.taskInfo.taskID ~= self.npcType and info.itemid ~= self.taskInfo.taskID then
    --        --taskGoalParam
    --        info.minValue = 1
    --        info.curValue = itemCount < remain and itemCount or remain
    --    else
    --        if (self.taskInfo.taskID == self.npcType) then
    --            itemCountofType = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemtype(luaEnumItemType.Material, UISaleOrePanel.taskMessage.taskID)
    --        end
    --
    --        local difference = itemCountofType - self.taskInfo.fillMaxValue
    --        info.minValue = difference > 0 and 1 or 0
    --        info.curValue = difference > 0 and difference or 0
    --    end
    --else
    --    info.minValue = 1
    --    info.curValue = itemCount < remain and itemCount or remain
    --end
    --
    --info.rightBtnLabel = '出售'
    --info.rightBtnCallBack = function(panel)
    --    if panel then
    --        if panel.num > self.curTemp.maxCount then
    --            return
    --        end
    --        if panel.num > itemCount then
    --            -- panel.ShowTips(UISaleOrePanel.GetTipsDes()[2])
    --            return
    --        end
    --        networkRequest.ReqNpcStorePutOn(self.curTemp.itemId, panel.num,self.npcType)
    --    end
    --    uimanager:ClosePanel('UIDisposeOrePanel')
    --end
    --info.disposeaBtnCallBack = function(panel)
    --    if panel then
    --        if panel.num + 1 > itemCount then
    --            panel.ShowTips(self:GetTipsDes()[2])
    --            return
    --        end
    --        if panel.num + 1 > self.curTemp.maxCount then
    --            panel.ShowTips(self:GetTipsDes()[3])
    --            return
    --        end
    --        if self.taskInfo ~= nil and self.taskInfo.curFillValue ~= nil and self.taskInfo.fillMaxValue ~= nil and panel.num ~= nil then
    --            if self.taskInfo.taskID ~= self.npcType and info.itemid ~= self.taskInfo.taskID then
    --                return
    --            end
    --            local difference = itemCountofType - panel.num
    --            if difference < self.taskInfo.fillMaxValue then
    --                panel.ShowTips(self:GetTipsDes()[1])
    --                return
    --            end
    --        end
    --    end
    --end
    --uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end

--endregion


--region otherFunction

---获取tips信息
---@private
function UISaleOrePanel_SalePanelTemplate:GetTipsDes()
    if self.tips == nil then
        local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20386)
        if isFind then
            self.tips = string.Split(info.value, '#')
        end
    end
    return self.tips
end

function UISaleOrePanel_SalePanelTemplate:SelectItemList(list)
    self.comList = {}
    if list == nil or list.Count == 0 then
        return
    end
    for i = 0, list.Count - 1 do
        local aisFind, aInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(list[i].npcStoreItem.npcShopId)
        if aisFind then
            if aInfo.type ~= 2 and list[i].count ~= aInfo.num then
                table.insert(self.comList, list[i])
            end
        end
    end
    table.sort(self.comList, self.sortFunc)
end

---排序规则
function UISaleOrePanel_SalePanelTemplate:SortItemList(a, b)
    local aisFind, aInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(a.npcStoreItem.npcShopId)
    local bisFind, bInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(b.npcStoreItem.npcShopId)
    if aisFind and bisFind then
        return aInfo.index < bInfo.index
    end
    return false
end

--endregion


return UISaleOrePanel_SalePanelTemplate