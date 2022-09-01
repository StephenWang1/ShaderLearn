local UITreasurePanel_Warehouse = {}

function UITreasurePanel_Warehouse:InitComponents()
    self.ScrollView_GameObject = self:Get('BagArea/TreasureBox/ScrollView', 'GameObject')
    self.ScrollView = self:Get('BagArea/TreasureBox/ScrollView', 'UIScrollView')
    self.UIGrid = self:Get('BagArea/TreasureBox/ScrollView/UIGrid', 'Top_UICenterOnChild')
    self.onePanel = self:Get('BagArea/TreasureBox/ScrollView/UIGrid/1', 'GameObject')
    self.twoPanel = self:Get('BagArea/TreasureBox/ScrollView/UIGrid/2', 'GameObject')
    self.oneUIGridItem = self:Get('BagArea/TreasureBox/ScrollView/UIGrid/1/UIGridItem', 'Top_UIGridContainer')
    self.twoUIGridItem = self:Get('BagArea/TreasureBox/ScrollView/UIGrid/2/UIGridItem', 'Top_UIGridContainer')
    self.Warehouse_UIPanel = CS.Utility_Lua.GetComponent(self.go, "Top_UIPanel")
    self.CloseBtn = self:Get('events/CloseBtn', 'GameObject')
    ---使用经验丹
    self.useExpBtn = self:Get('events/useExpBtn', 'GameObject')
    ---一键回收
    self.recycleBtn = self:Get('events/recycleBtn', 'GameObject')
    ---一键提取
    self.extractBtn = self:Get('events/extractBtn', 'GameObject')
    ---下方点列表
    self.downDotgrid = self:Get('BagArea/DownDot/grid', 'Top_UIGridContainer')
    UITreasurePanel_Warehouse.Self = self
end
function UITreasurePanel_Warehouse:InitOther()
    ---每页总宽度
    self.MaxWide = 670
    ---当前页
    self.NowTab = 0
    ---当前面板页签
    self.NowPanelTab = -1
    ---页签小点列表
    self.TabDotLis = {}
    ---拖拽开始位置
    self.onDragStartPosition_X = 0
    ---拖拽方向
    self.onDragDirection = 0
    ---寻宝仓库格子列表
    self.BoxList = {}

    self.UIGrid.onCenter = self.OnRefreshPage

    CS.UIEventListener.Get(self.useExpBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.useExpBtn).OnClickLuaDelegate = self.OnClickUseExpBtn
    CS.UIEventListener.Get(self.recycleBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.recycleBtn).OnClickLuaDelegate = self.OnClickRecycleBtn
    CS.UIEventListener.Get(self.extractBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.extractBtn).OnClickLuaDelegate = self.OnClickExtractBtn
    CS.UIEventListener.Get(self.CloseBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.CloseBtn).OnClickLuaDelegate = self.OnClickClose

    self.OnCommonShowTips = function(id, data)
        print(data.type)
        if data.type ~= 6 then
            return
        end
        if data.data == 0 then
            local WarehouseDic = CS.CSScene.MainPlayerInfo.TreasureInfo.WarehouseDic
            local isfindone, oneData = CS.CSScene.MainPlayerInfo.TreasureInfo.WarehouseDic:TryGetValue(self.NowPanelTab)
            if self.NowPanelTab % 2 == 0 then
                self:UpdateItemFlyAnim(self.oneUIGridItem, oneData)
            else
                self:UpdateItemFlyAnim(self.twoUIGridItem, oneData)
            end
        end

        if data.data == 0 then
            return
        end
        local go = UITreasurePanel_Warehouse.Self.extractBtn
        if data.data == 4 then
            UITreasurePanel_Warehouse.ShowTips(go.transform, 132)
        else
            UITreasurePanel_Warehouse.ShowTips(go.transform, 131)
        end


    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, self.OnCommonShowTips)
end

function UITreasurePanel_Warehouse:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitComponents()
    self:InitOther()
    CS.CSScene.MainPlayerInfo.TreasureInfo:InitWarehouseDic()
    self:RefreshWarehouseList(self.NowTab)
    UITreasurePanel_Warehouse.Self:UpdateDownDotgrid()
end

function UITreasurePanel_Warehouse:RefreshUI()
    networkRequest.ReqTreasureStorehouse()
end

---自动居中
function UITreasurePanel_Warehouse:OnRefreshPage(obj)
    local centeredObject = UITreasurePanel_Warehouse.Self.UIGrid.centeredObject
    if centeredObject == nil then
        return
    end
    UITreasurePanel_Warehouse.Self.NowTab = math.modf(centeredObject.transform.localPosition.x / UITreasurePanel_Warehouse.Self.MaxWide)
    UITreasurePanel_Warehouse.Self:UpdateDownDotgrid()
end

---更新下方页签
function UITreasurePanel_Warehouse:UpdateDownDotgrid()
    if #self.TabDotLis ~= 12 then
        self.downDotgrid.MaxCount = 12
        for index = 1, 12 do
            local item = self.downDotgrid.controlList[index - 1].gameObject
            local itemsprite = CS.Utility_Lua.GetComponent(item, "Top_UISprite")
            self.TabDotLis[index] = itemsprite
        end
    end
    for index = 1, #self.TabDotLis do
        local itemsprite = self.TabDotLis[index].transform:Find('2').gameObject
        itemsprite.gameObject:SetActive(index == self.NowTab + 1)
    end
end

---刷新奖品箱列表
function UITreasurePanel_Warehouse:RefreshWarehouseList(NowTab)
    if self.NowPanelTab == NowTab then
        return
    end
    if NowTab == nil then
        NowTab = self.NowPanelTab
    end
    self.NowPanelTab = NowTab
    if NowTab <= 0 then
        NowTab = 0
    end
    local WarehouseDic = CS.CSScene.MainPlayerInfo.TreasureInfo.WarehouseDic

    if WarehouseDic == nil then
        return
    end
    local isfindone, oneData = WarehouseDic:TryGetValue(NowTab)
    local isfindtwo, twoData = WarehouseDic:TryGetValue(NowTab + 1)
    if isfindone == false or isfindtwo == false then
        return
    end
    if NowTab % 2 == 0 then
        self:UpdateItem(self.oneUIGridItem, oneData)
        self:UpdateItem(self.twoUIGridItem, twoData)
    else
        self:UpdateItem(self.oneUIGridItem, twoData)
        self:UpdateItem(self.twoUIGridItem, oneData)
    end


end
---拖动时更新道具列表
function UITreasurePanel_Warehouse:UpdateItem(UIGridItem, data)
    UIGridItem.MaxCount = data.Count
    for index = 0, data.Count - 1 do
        local item = UIGridItem.controlList[index].gameObject
        if self.BoxList[item] == nil then
            CS.UIEventListener.Get(item).onDragStart = self.onDragStart
            CS.UIEventListener.Get(item).onDrag = self.onDragItem
            CS.UIEventListener.Get(item).onDragEnd = self.onDragEnd
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UITreasurePanel_Item)
            self.BoxList[item] = template
        end
        if data[index] ~= nil and data[index].BagItemInfo ~= nil then
            self.BoxList[item]:RefreshUI(data[index].BagItemInfo.itemId, data[index].BagItemInfo)
        else
            self.BoxList[item]:RefreshUI(nil)
        end
    end
end

---拖动时更新道具列表
function UITreasurePanel_Warehouse:UpdateItemFlyAnim(UIGridItem, data)
    if UIGridItem == nil then
        return
    end
    UIGridItem.MaxCount = data.Count
    for index = 0, data.Count - 1 do
        local item = UIGridItem.controlList[index].gameObject
        if data[index] ~= nil then
            if self.BoxList ~= nil and self.BoxList[item] ~= nil then
                self.BoxList[item]:SetFlyAnim()
            end
        end
    end
end

function UITreasurePanel_Warehouse:SetWarehouseInfo()
    UITreasurePanel_Warehouse.Self:RefreshWarehouseList(self.NowTab)
    if true then
        return
    end
    local Direction = 0
    local x = UITreasurePanel_Warehouse.Self.ScrollView_GameObject.transform.localPosition.x
    if x - self.onDragStartPosition_X > 0 then
        Direction = 1
    else
        Direction = -1
    end

    if self.onDragDirection ~= Direction or true then
        if Direction == 1 then
            UITreasurePanel_Warehouse.Self:RefreshWarehouseList(self.NowTab)
        else
            UITreasurePanel_Warehouse.Self:RefreshWarehouseList(self.NowTab)
        end
        self.onDragDirection = Direction
    end
end

function UITreasurePanel_Warehouse:onDragStart()
    UITreasurePanel_Warehouse.Self.onDragDirection = 0
    UITreasurePanel_Warehouse.Self.onDragStartPosition_X = UITreasurePanel_Warehouse.Self.ScrollView_GameObject.transform.localPosition.x
end

---拖拽物体
function UITreasurePanel_Warehouse:onDragItem(go)
    local referWide = UITreasurePanel_Warehouse.Self.MaxWide
    local x = UITreasurePanel_Warehouse.Self.ScrollView_GameObject.transform.localPosition.x
    local xNumber = math.modf(x / referWide)
    local oneVectir3 = UITreasurePanel_Warehouse.Self.onePanel.transform.localPosition
    local twoVectir3 = UITreasurePanel_Warehouse.Self.twoPanel.transform.localPosition
    if xNumber <= 0 and x >= -referWide * 11 then
        if xNumber % 2 == 0 then
            twoVectir3.x = math.abs(xNumber) * referWide + referWide
            oneVectir3.x = math.abs(xNumber) * referWide
            UITreasurePanel_Warehouse.Self.NowTab = math.modf(oneVectir3.x / UITreasurePanel_Warehouse.Self.MaxWide)
            UITreasurePanel_Warehouse.Self:UpdateDownDotgrid()
        else
            oneVectir3.x = math.abs(xNumber) * referWide + referWide
            twoVectir3.x = math.abs(xNumber) * referWide
            UITreasurePanel_Warehouse.Self.NowTab = math.modf(twoVectir3.x / UITreasurePanel_Warehouse.Self.MaxWide)
            UITreasurePanel_Warehouse.Self:UpdateDownDotgrid()
        end
    end

    UITreasurePanel_Warehouse.Self.onePanel.transform.localPosition = oneVectir3
    UITreasurePanel_Warehouse.Self.twoPanel.transform.localPosition = twoVectir3
    UITreasurePanel_Warehouse.Self:SetWarehouseInfo()
end

function UITreasurePanel_Warehouse:onDragEnd()
    UITreasurePanel_Warehouse.Self:onDragItem()
    local changeposition = UITreasurePanel_Warehouse.Self.ScrollView_GameObject.transform.localPosition.x - UITreasurePanel_Warehouse.Self.onDragStartPosition_X
    if changeposition == 0 then
        UITreasurePanel_Warehouse.Self.UIGrid.centerObj = nil
    elseif changeposition > 100 and changeposition < UITreasurePanel_Warehouse.Self.MaxWide then
        UITreasurePanel_Warehouse.Self.UIGrid.centerObj = UITreasurePanel_Warehouse.SelectObj(UITreasurePanel_Warehouse.Self.NowTab - 1, "right")
    elseif changeposition < -100 and changeposition > -UITreasurePanel_Warehouse.Self.MaxWide then

        UITreasurePanel_Warehouse.Self.UIGrid.centerObj = UITreasurePanel_Warehouse.SelectObj(UITreasurePanel_Warehouse.Self.NowTab + 1, "left")
    end
end

function UITreasurePanel_Warehouse.SelectObj(xNumber, direction)
    -- if xNumber<0 or xNumber==12 then
    --     return nil
    -- end
    local oneposition = UITreasurePanel_Warehouse.Self.onePanel.transform.localPosition
    local twoposition = UITreasurePanel_Warehouse.Self.twoPanel.transform.localPosition
    if direction == "right" then
        if oneposition.x > twoposition.x then
            return UITreasurePanel_Warehouse.Self.twoPanel
        else
            return UITreasurePanel_Warehouse.Self.onePanel
        end
    elseif direction == "left" then
        if oneposition.x < twoposition.x then
            return UITreasurePanel_Warehouse.Self.twoPanel
        else
            return UITreasurePanel_Warehouse.Self.onePanel
        end
    end
    return nil
end

--region 点击事件
---使用经验丹
function UITreasurePanel_Warehouse:OnClickUseExpBtn(go)
    CS.CSScene.MainPlayerInfo.TreasureInfo.IsNeedAllSort = true
    local experienceLidList = CS.CSScene.MainPlayerInfo.TreasureInfo:UseAllExperience()
    if experienceLidList.Count == 0 or experienceLidList == nil then
        UITreasurePanel_Warehouse.ShowTips(go.transform, 129)
    else
        networkRequest.ReqUseTreasureExp(experienceLidList)
    end
end
---一键回收
function UITreasurePanel_Warehouse:OnClickRecycleBtn(go)
    CS.CSScene.MainPlayerInfo.TreasureInfo.IsNeedAllSort = true
    local RecycleList = CS.CSScene.MainPlayerInfo.TreasureInfo:GetRecycleList()
    if RecycleList == nil or RecycleList.Count == 0 then
        UITreasurePanel_Warehouse.ShowTips(go.transform, 130)
    else
        networkRequest.ReqHuntCallBack(RecycleList)
    end
end
---一键提取
function UITreasurePanel_Warehouse:OnClickExtractBtn()
    CS.CSScene.MainPlayerInfo.TreasureInfo.IsNeedAllSort = true
    networkRequest.ReqGetWholeItem()
end
---关闭面板
function UITreasurePanel_Warehouse:OnClickClose()
    self.Warehouse_UIPanel.alpha = 0
end
function UITreasurePanel_Warehouse.ShowTips(trans, id)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans

    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end


--endregion

function UITreasurePanel_Warehouse:OnDestroy()
    UITreasurePanel_Warehouse.Self = nil
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCommonMessage, UITreasurePanel_Warehouse.OnCommonShowTips)
end

return UITreasurePanel_Warehouse