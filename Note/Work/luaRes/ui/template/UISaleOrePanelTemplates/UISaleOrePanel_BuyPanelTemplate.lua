---@class UISaleOrePanel_BuyPanelTemplate 购买面板模板
local UISaleOrePanel_BuyPanelTemplate = {}

--region 初始化

function UISaleOrePanel_BuyPanelTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UISaleOrePanel_BuyPanelTemplate:InitParameters()
    ---每页条数
    self.countPerPage = 5
    ---每次获得页数
    self.needPageNumber = 3
    ---当前页签
    self.curPage = 1
    ---页签总数
    self.maxPage = 1
    ---储存三页的data
    ---@type table<number,table<npcStoreV2.NpcStoreItem>>
    self.data = {}
    ---储存预设对应模板
    self.templateDic = {}
    self.curTemp = nil
    ---pageIndex页内容显示回调
    self.refreshCenterPageViewCallBack = function(obj, pageIndex)
        self:OnCenterPageEnterView(obj, pageIndex)
    end
    ---中心页签数发生变化回调
    self.centerPageChangeCallBack = function(pageIndex)
        self:OnCenterPageIndexChanged(pageIndex)
    end
    --[[    self.sortFunc = function(a, b)
            return self:SortItemList(a, b)
        end]]
    self.isInitPage = true
end

function UISaleOrePanel_BuyPanelTemplate:InitComponents()
    ---@type Top_UIGridContainer
    self.nullObj = self:Get("nullObj", "GameObject")
    ---@type Top_UIGridContainer
    self.UIGrid = self:Get("Scroll View/UIGrid", "GameObject")
    ---@type UILoopScrollViewPlus 循环控制
    self.mLoopScrollViewPlus = self:Get("Scroll View/LoopScrollViewPlus", "UILoopScrollViewPlus")
end

---初始化模板
---@public
function UISaleOrePanel_BuyPanelTemplate:SetTemplate(customData)
    if customData then
        self.npcType = customData.type
    end

    networkRequest.ReqGetNpcStore(self.npcType, self.curPage, self.countPerPage, self.needPageNumber)
end

--endregion

--region Show

---刷新面板状态
---@public
function UISaleOrePanel_BuyPanelTemplate:SetOpenState(isOpen)
    self.go:SetActive(isOpen)
    if isOpen then
        if not self.isInitPage then
            networkRequest.ReqGetNpcStore(self.npcType, 1, self.countPerPage, self.needPageNumber)
            self.mLoopScrollViewPlus:ResetPage()
        end
    end
end

function UISaleOrePanel_BuyPanelTemplate:RefreshGrid(info)
    self:ParseData(info)
    if self.isInitPage then
        self.isInitPage = false
        self:InitLoopScrollView()
    else
        self.mLoopScrollViewPlus:RefreshCurrentPage()
    end
end

--region UILoopScrollViewPlus

function UISaleOrePanel_BuyPanelTemplate:InitLoopScrollView()
    self.mLoopScrollViewPlus:Init(function(go, line)
        return self:OnItemInitCallback(go, line)
    end, function(line)
        self:CheckRefreshData(line)
    end)
end

function UISaleOrePanel_BuyPanelTemplate:OnItemInitCallback(go, line)
    local lineData = self:GetLineData(line)
    if not CS.StaticUtility.IsNull(go) and lineData ~= nil then
        local temp = self.templateDic[go] ~= nil and self.templateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UISaleOrePanel_UnitTemplate)
        local infotemp = {}
        infotemp.index = line + 1
        infotemp.itemId = 0
        --购买
        infotemp.tradType = 1
        if lineData.npcStoreItem.item ~= nil then
            infotemp.itemId = lineData.npcStoreItem.item.itemId
        else
            local isFind, info = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(lineData.npcStoreItem.npcShopId)
            if isFind then
                infotemp.itemId = info.itemId
            end
        end
        infotemp.lid = lineData.npcStoreItem.item.lid
        infotemp.stockNum = lineData.count
        infotemp.comId = lineData.npcStoreItem.npcShopId
        infotemp.bagItemInfo = lineData.npcStoreItem.item
        infotemp.price = lineData.npcStoreItem.priceCount
        infotemp.priceItemid = lineData.npcStoreItem.priceItemId
        infotemp.callBack = function(go, table)
            local tempInfo = {}
            tempInfo.info = lineData
            tempInfo.go = go
            tempInfo.target = table.Icon
            if lineData.npcStoreItem.item ~= nil then
                tempInfo.lid = lineData.npcStoreItem.item.lid
            end
            tempInfo.itemId = lineData.npcStoreItem.item.itemId
            tempInfo.maxCount = temp.maxCount
            self.curTemp = tempInfo
            self:OnCilckUnitCallBack()
        end
        temp:SetTemplat(infotemp)
        if self.templateDic[go] == nil then
            self.templateDic[go] = temp
        end
        return true
    end
    return false
end

--endregion

--region otherFunction


--region 解析服务器数据

function UISaleOrePanel_BuyPanelTemplate:ParseData(info)
    if self.maxPage ~= info.totalPage then
        self.maxPage = info.totalPage
    end
    self.data = {}
    local page = info.page
    local npcStorList = {}
    if self.nullObj ~= nil and not CS.StaticUtility.IsNull(self.nullObj) then
        self.nullObj:SetActive(info.npcStoreGridList.npcStoreGrids.Count == 0)
    end
    if info.npcStoreGridList.npcStoreGrids.Count == 0 then
        return
    end
    -- info.npcStoreItemList.npcStoreItem:Sort(self.sortFunc)
    --table.sort(npcStorList, self.sortFunc)
    local length = info.npcStoreGridList.npcStoreGrids.Count - 1

    for i = 0, length do
        table.insert(npcStorList, info.npcStoreGridList.npcStoreGrids[i])
        if (i + 1) % self.countPerPage == 0 then
            self.data[page] = npcStorList
            npcStorList = {}
            page = page + 1
        elseif i == length then
            self.data[page] = npcStorList
        end
    end
end

---排序规则
function UISaleOrePanel_BuyPanelTemplate:SortItemList(a, b)
    local aisFind, aInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(a.npcShopId)
    local bisFind, bInfo = CS.Cfg_NpcShopManager.Instance.dic:TryGetValue(b.npcShopId)
    local result = 0
    if aisFind and bisFind then
        result = aInfo.index < bInfo.index and -1 or aInfo.index > bInfo.index and 1 or 0
    elseif a.item and b.item and a.item.ItemTABLE and b.item.ItemTABLE then
        result = a.item.ItemTABLE.recoverShopOrder < b.item.ItemTABLE.recoverShopOrder and -1 or a.item.ItemTABLE.recoverShopOrder > b.item.ItemTABLE.recoverShopOrder and 1 or 0
    end
    return result
end

--endregion

---点击购买回调
function UISaleOrePanel_BuyPanelTemplate:OnCilckUnitCallBack()
    if self.curTemp == nil then
        return
    end
    --判断买单个还是买多个
    local isOnlyBuyOne = CS.Cfg_GlobalTableManager.Instance:isOnlyBuyOneType(self.curTemp.itemId)
    self:ShowShopTips(isOnlyBuyOne)
end

---显示选择数量
function UISaleOrePanel_BuyPanelTemplate:ShowShopTips(isOnlyBuyOne)
    local conitsID = self.curTemp.info.npcStoreItem.priceItemId
    local price = self.curTemp.info.npcStoreItem.priceCount
    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(conitsID)
    local info = {}
    info.priceDate = self.curTemp.info
    info.BagItemInfo = self.curTemp.info.npcStoreItem.item
    info.isOnlyBuyOne = isOnlyBuyOne
    info.curNum = isOnlyBuyOne and 1 or self:GetCanBuyCount(conitsID)
    info.Template = luaComponentTemplates.UISaleOrePanel_BuyItemTemplate
    info.BuyCallBack = function(go, num)
        if num * price > CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(conitsID) then
            --Utility.ShowPopoTips(go, nil, 67, "UIAuctionItemPanel", { itemid = conitsID })
            local EntranceWay = nil
            --if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.NPCStore) then
            if (conitsID == 1000002) then
                --元宝
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.NPCStoreIngotNotEnough
                EntranceWay = LuaEnumRechargePointType.NPCStoreIngotNotEnoughToRewardGift
            elseif (conitsID == 1000004) then
                --金币
                EntranceWay = LuaEnumRechargePointType.NPCStoreGoldNotEnoughToRewardGift
            end
            --end

            Utility.ShowItemGetWay(conitsID, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0), nil, EntranceWay);
            return
        end
        networkRequest.ReqNpcStoreBuy(self.curTemp.info.id, self.curTemp.lid, self.npcType, num)
        if luaEventManager.HasCallback(LuaCEvent.Effect_FlyItemIcon) then
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.curTemp.info.id, from = self.curTemp.target.transform.position })
        end
        uimanager:ClosePanel('UIAuctionItemPanel')
    end

    uimanager:CreatePanel("UIAuctionItemPanel", nil, info)
end

---检测是否需要刷新数据
function UISaleOrePanel_BuyPanelTemplate:CheckRefreshData(line)
    --设置当前page
    self.curPage = math.floor(line / self.countPerPage) + 1
    --判断当前page 上层是否有储存数据
    if self.curPage ~= 1 and self.data[self.curPage - 1] == nil then
        networkRequest.ReqGetNpcStore(self.npcType, self.curPage - 1, self.countPerPage, self.needPageNumber)
        --判断当前page 下层是否有储存数据
    elseif self.curPage ~= self.maxPage and self.data[self.curPage + 1] == nil then
        networkRequest.ReqGetNpcStore(self.npcType, self.curPage - 1, self.countPerPage, self.needPageNumber)
    end
end

function UISaleOrePanel_BuyPanelTemplate:GetLineData(line)
    if self.data == nil then
        return
    end
    local page = math.floor(line / self.countPerPage) + 1
    local index = (line % self.countPerPage) + 1
    local pageData = self.data[page]
    if pageData and #pageData >= index then
        return pageData[index]
    end
end

function UISaleOrePanel_BuyPanelTemplate:GetTaskCount()

    local itemID = self.curTemp.info.npcStoreItem.item.itemId

    local taskMessage = CS.CSMissionManager.Instance:GetMissionByTaskTyp(Utility.EnumToInt(CS.TasksMainType.Everyday), self.npcType)
    if taskMessage ~= nil then
        local isFind, curCount, maxCount = taskMessage:GetTaskNeedItemNumber(itemID)
        return isFind and curCount < maxCount, maxCount - curCount
    end
    return false, 1
end

---根据任务初始化可买值
function UISaleOrePanel_BuyPanelTemplate:GetCanBuyCount(conitsID)
    if self.isOnlyBuyOne then
        return 1
    end
    local isNeedBuy, missionNeedCount = self:GetTaskCount()
    if isNeedBuy then
        local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(conitsID)
        local price = self.curTemp.info.npcStoreItem.priceCount
        local canBuyCount = math.floor(selfCost / price)
        local maxNum = self.curTemp.info.count
        local num = 1
        if maxNum >= missionNeedCount then
            --库存满足任务所需所有物品
            if missionNeedCount <= canBuyCount then
                --资金足够购买任务所需数量
                num = missionNeedCount
            else
                --资金不足购买任务所需数量
                num = canBuyCount
            end
        else
            --库存不满足任务所需
            if maxNum <= canBuyCount then
                --资金足够购买库存
                num = maxNum
            else
                --资金不足购买库存
                num = canBuyCount
            end
        end
        return num == 0 and 1 or num
    else
        return 1
    end
end

--endregion


return UISaleOrePanel_BuyPanelTemplate