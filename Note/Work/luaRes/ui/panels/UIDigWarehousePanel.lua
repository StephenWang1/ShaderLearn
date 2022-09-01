--- 地宫秘宝挖宝仓库
--- Created by Olivier.
--- DateTime: 2021/3/4 17:02
---
---@class UIDigWarehousePanel:UIBase
local UIDigWarehousePanel = {}
UIDigWarehousePanel.PlayerBagInfo = CS.CSScene.MainPlayerInfo.BagInfo

function UIDigWarehousePanel:InitComponents()
    self.ScrollView_GameObject = self:GetCurComp('BagArea/TreasureBox/ScrollView', 'GameObject')
    self.ScrollView = self:GetCurComp('BagArea/TreasureBox/ScrollView', 'UIScrollView')
    self.UIGrid = self:GetCurComp('BagArea/TreasureBox/ScrollView/UIGrid', 'Top_UICenterOnChild')
    self.onePanel = self:GetCurComp('BagArea/TreasureBox/ScrollView/UIGrid/1', 'GameObject')
    self.twoPanel = self:GetCurComp('BagArea/TreasureBox/ScrollView/UIGrid/2', 'GameObject')
    self.oneUIGridItem = self:GetCurComp('BagArea/TreasureBox/ScrollView/UIGrid/1/UIGridItem', 'Top_UIGridContainer')
    self.twoUIGridItem = self:GetCurComp('BagArea/TreasureBox/ScrollView/UIGrid/2/UIGridItem', 'Top_UIGridContainer')
    self.Warehouse_UIPanel = CS.Utility_Lua.GetComponent(self.go, "Top_UIPanel")
    self.CloseBtn = self:GetCurComp('events/CloseBtn', 'GameObject')
    ---使用经验丹
    self.useExpBtn = self:GetCurComp('events/useExpBtn', 'GameObject')
    ---一键回收
    self.recycleBtn = self:GetCurComp('events/recycleBtn', 'GameObject')
    ---一键提取
    self.extractBtn = self:GetCurComp('events/extractBtn', 'GameObject')
    ---下方点列表
    self.downDotgrid = self:GetCurComp('BagArea/DownDot/grid', 'Top_UIGridContainer')
    UIDigWarehousePanel.Self = self
end

function UIDigWarehousePanel:InitOther()
    ---每页总宽度
    self.MaxWide = 670
    ---当前页
    self.NowTab = 0
    ---当前面板页签
    self.NowPanelTab = 0
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
        self:RefreshWarehouseList(self.NowTab)
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDigTreasureWareHouseMessage, self.OnCommonShowTips)
end

function UIDigWarehousePanel:Init()
    self:InitComponents()
    self:InitOther()
    UIDigWarehousePanel.Self:UpdateDownDotgrid()
end

function UIDigWarehousePanel:Show()
    networkRequest.ReqOpenDigTreasureWareHouse()
end

--region    下方页签
---自动居中
function UIDigWarehousePanel:OnRefreshPage(obj)
    local centeredObject = UIDigWarehousePanel.Self.UIGrid.centeredObject
    if centeredObject == nil then
        return
    end
    UIDigWarehousePanel.Self.NowTab = math.modf(centeredObject.transform.localPosition.x / UIDigWarehousePanel.Self.MaxWide)
    UIDigWarehousePanel.Self:UpdateDownDotgrid()
end

---更新下方页签
function UIDigWarehousePanel:UpdateDownDotgrid()
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
--endregion

---刷新奖品箱列表
function UIDigWarehousePanel:RefreshWarehouseList(NowTab)
    --if self.NowPanelTab == NowTab then
    --    return
    --end
    if NowTab == nil then
        NowTab = self.NowPanelTab
    end
    self.NowPanelTab = NowTab
    if NowTab <= 0 then
        NowTab = 0
    end
    local WarehouseDic = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetData()
    if WarehouseDic == nil then
        return
    end
    local  oneData = WarehouseDic[NowTab]
    local  twoData = WarehouseDic[NowTab+1]
    if oneData == nil or twoData == nil then
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
function UIDigWarehousePanel:UpdateItem(UIGridItem, data)
    UIGridItem.MaxCount = #data
    for index = 1, #data do
        local item = UIGridItem.controlList[index - 1].gameObject
        if self.BoxList[item] == nil then
            CS.UIEventListener.Get(item).onDragStart = self.onDragStart
            CS.UIEventListener.Get(item).onDrag = self.onDragItem
            CS.UIEventListener.Get(item).onDragEnd = self.onDragEnd
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UITreasurePanel_Item)
            template:IsShowTipsBtn(true)
            self.BoxList[item] = template
        end
        if data[index] ~= nil and data[index].bagItemInfo ~= nil then
            self.BoxList[item]:RefreshUI(data[index].bagItemInfo.itemId, data[index].bagItemInfo)
        else
            self.BoxList[item]:RefreshUI(nil)
        end
    end
end

---拖动时更新道具列表
function UIDigWarehousePanel:UpdateItemFlyAnim(UIGridItem, data)
    if UIGridItem == nil then
        return
    end
    UIGridItem.MaxCount = #data
    for index = 1, #data do
        local item = UIGridItem.controlList[index - 1].gameObject
        if data[index] ~= nil then
            if self.BoxList ~= nil and self.BoxList[item] ~= nil then
                self.BoxList[item]:SetFlyAnim()
            end
        end
    end
end

function UIDigWarehousePanel:SetWarehouseInfo()
    UIDigWarehousePanel.Self:RefreshWarehouseList(self.NowTab)
    if true then
        return
    end
    local Direction = 0
    local x = UIDigWarehousePanel.Self.ScrollView_GameObject.transform.localPosition.x
    if x - self.onDragStartPosition_X > 0 then
        Direction = 1
    else
        Direction = -1
    end
    if self.onDragDirection ~= Direction or true then
        if Direction == 1 then
            UIDigWarehousePanel.Self:RefreshWarehouseList(self.NowTab)
        else
            UIDigWarehousePanel.Self:RefreshWarehouseList(self.NowTab)
        end
        self.onDragDirection = Direction
    end
end

function UIDigWarehousePanel:onDragStart()
    UIDigWarehousePanel.Self.onDragDirection = 0
    UIDigWarehousePanel.Self.onDragStartPosition_X = UIDigWarehousePanel.Self.ScrollView_GameObject.transform.localPosition.x
end

---拖拽物体
function UIDigWarehousePanel:onDragItem(go)
    local referWide = UIDigWarehousePanel.Self.MaxWide
    local x = UIDigWarehousePanel.Self.ScrollView_GameObject.transform.localPosition.x
    local xNumber = math.modf(x / referWide)
    local oneVectir3 = UIDigWarehousePanel.Self.onePanel.transform.localPosition
    local twoVectir3 = UIDigWarehousePanel.Self.twoPanel.transform.localPosition
    if xNumber <= 0 and x >= -referWide * 11 then
        if xNumber % 2 == 0 then
            twoVectir3.x = math.abs(xNumber) * referWide + referWide
            oneVectir3.x = math.abs(xNumber) * referWide
            UIDigWarehousePanel.Self.NowTab = math.modf(oneVectir3.x / UIDigWarehousePanel.Self.MaxWide)
            UIDigWarehousePanel.Self:UpdateDownDotgrid()
        else
            oneVectir3.x = math.abs(xNumber) * referWide + referWide
            twoVectir3.x = math.abs(xNumber) * referWide
            UIDigWarehousePanel.Self.NowTab = math.modf(twoVectir3.x / UIDigWarehousePanel.Self.MaxWide)
            UIDigWarehousePanel.Self:UpdateDownDotgrid()
        end
    end

    UIDigWarehousePanel.Self.onePanel.transform.localPosition = oneVectir3
    UIDigWarehousePanel.Self.twoPanel.transform.localPosition = twoVectir3
    UIDigWarehousePanel.Self:SetWarehouseInfo()
end

function UIDigWarehousePanel:onDragEnd()
    UIDigWarehousePanel.Self:onDragItem()
    local changeposition = UIDigWarehousePanel.Self.ScrollView_GameObject.transform.localPosition.x - UIDigWarehousePanel.Self.onDragStartPosition_X
    if changeposition == 0 then
        UIDigWarehousePanel.Self.UIGrid.centerObj = nil
    elseif changeposition > 100 and changeposition < UIDigWarehousePanel.Self.MaxWide then
        UIDigWarehousePanel.Self.UIGrid.centerObj = UIDigWarehousePanel.SelectObj(UIDigWarehousePanel.Self.NowTab - 1, "right")
    elseif changeposition < -100 and changeposition > -UIDigWarehousePanel.Self.MaxWide then

        UIDigWarehousePanel.Self.UIGrid.centerObj = UIDigWarehousePanel.SelectObj(UIDigWarehousePanel.Self.NowTab + 1, "left")
    end
end

function UIDigWarehousePanel.SelectObj(xNumber, direction)
    -- if xNumber<0 or xNumber==12 then
    --     return nil
    -- end
    local oneposition = UIDigWarehousePanel.Self.onePanel.transform.localPosition
    local twoposition = UIDigWarehousePanel.Self.twoPanel.transform.localPosition
    if direction == "right" then
        if oneposition.x > twoposition.x then
            return UIDigWarehousePanel.Self.twoPanel
        else
            return UIDigWarehousePanel.Self.onePanel
        end
    elseif direction == "left" then
        if oneposition.x < twoposition.x then
            return UIDigWarehousePanel.Self.twoPanel
        else
            return UIDigWarehousePanel.Self.onePanel
        end
    end
    return nil
end

--region 点击事件
---使用经验丹
function UIDigWarehousePanel:OnClickUseExpBtn(go)
    networkRequest.ReqOneKeyOperation(1)
end
---一键回收
function UIDigWarehousePanel:OnClickRecycleBtn(go)
    local itemIds = {}
    local WarehouseDic = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetData()
    local MaxCount = #WarehouseDic - 1
    for i = 0, MaxCount do
        local tab = WarehouseDic[i]
        for j = 1, #tab do
            local info = tab[j].bagItemInfo
            if info ~= nil then
                local cItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(info)
                local result1 = UIDigWarehousePanel.PlayerBagInfo:IsRecommendRecycleItem(cItemInfo)
                local result2 = CS.Cfg_RecoverSetTableManager.Instance:SettingRecycle(cItemInfo, result1)
                if result2 then
                    table.insert(itemIds,cItemInfo.lid)
                end
            end
            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon)
        end
    end
    if #itemIds > 0 then
        networkRequest.ReqOneKeyCallBack(itemIds)
    else
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 130
        uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
    end
end
---一键提取
function UIDigWarehousePanel:OnClickExtractBtn()
    networkRequest.ReqOneKeyOperation(2)
end
---关闭面板
function UIDigWarehousePanel:OnClickClose()
    uimanager:ClosePanel("UIDigWarehousePanel")
end
function UIDigWarehousePanel.ShowTips(trans, id)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = trans
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel('UIBubbleTipsPanel', nil, TipsInfo)
end
--endregion

function UIDigWarehousePanel:OnDestroy()
    UIDigWarehousePanel.Self = nil
end

return UIDigWarehousePanel