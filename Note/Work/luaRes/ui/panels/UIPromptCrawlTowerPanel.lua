---@class UIPromptCrawlTowerPanel:UIBase
local UIPromptCrawlTowerPanel = {}

--region 组件
function UIPromptCrawlTowerPanel:GetTitle_UILabel()
    if (self.mTitle == nil) then
        self.mTitle = self:GetCurComp("view/Title", "Top_UILabel")
    end
    return self.mTitle
end

function UIPromptCrawlTowerPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("events/close", "GameObject")
    end
    return self.mCloseBtn
end

function UIPromptCrawlTowerPanel:GetEnterBtn_GameObject()
    if (self.mEnterBtn == nil) then
        self.mEnterBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    end
    return self.mEnterBtn
end

function UIPromptCrawlTowerPanel:GetAddBtn_GameObject()
    if (self.mAddBtn == nil) then
        self.mAddBtn = self:GetCurComp("view/CostItem/Item1/add", "GameObject")
    end
    return self.mAddBtn
end

function UIPromptCrawlTowerPanel:GetNeedItem_UIToggle()
    if (self.mNeedItemToggle == nil) then
        self.mNeedItemToggle = self:GetCurComp("view/CostItem/Item1", "Top_UIToggle")
    end
    return self.mNeedItemToggle
end

function UIPromptCrawlTowerPanel:GetNeedItemCount_UILabel()
    if (self.mNeedItemCount == nil) then
        self.mNeedItemCount = self:GetCurComp("view/CostItem/Item1/Label", "Top_UILabel")
    end
    return self.mNeedItemCount
end

function UIPromptCrawlTowerPanel:GetNeedDiamond_UIToggle()
    if (self.mNeedDiamondToggle == nil) then
        self.mNeedDiamondToggle = self:GetCurComp("view/CostItem/Item2", "Top_UIToggle")
    end
    return self.mNeedDiamondToggle
end

function UIPromptCrawlTowerPanel:GetNeedDiamondCount_UILabel()
    if (self.mNeedDiamondCount == nil) then
        self.mNeedDiamondCount = self:GetCurComp("view/CostItem/Item2/Label", "Top_UILabel")
    end
    return self.mNeedDiamondCount
end
--endregion

--region 初始化
function UIPromptCrawlTowerPanel:Init()
    self:BindUIEvents()
    self.costType = 1
    --self.OutPanel = false
end

function UIPromptCrawlTowerPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:CloseBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetEnterBtn_GameObject()).onClick = function(go)
        self:EnterBtnOnClick(go)
    end

    CS.UIEventListener.Get(self:GetAddBtn_GameObject()).onClick = function(go)
        self:AddBtnOnClick(go)
    end
end
--endregion

function UIPromptCrawlTowerPanel:Show(state)
    local towerdata = gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():GetPlayerTowerData()
    local data = clientTableManager.cfg_towerManager:TryGetValue(towerdata.level + 1)
    if (data ~= nil) then
        self.tblData = data
        local isfind, dupinfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(data:GetDuplicateId())
        if (isfind) then
            self.duplicateData = dupinfo
        end
        if (state ~= nil) then
            --self.OutPanel = true
            self:GetAddBtn_GameObject():SetActive(state)
        end
        self:RefreshUIPanel()
        self:RefreshCostType()
    end
end

--region 刷新面板
function UIPromptCrawlTowerPanel:RefreshCostType()
    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.duplicateData.requireItems.list[0].list[0])
    if (itemCount >= self.duplicateData.requireItems.list[0].list[1]) then
        self:GetNeedItem_UIToggle().value = true
        self:GetNeedDiamond_UIToggle().value = false
        self:GetNeedItem_UIToggle():SwitchSpriteState(true)
        self:GetNeedDiamond_UIToggle():SwitchSpriteState(false)
    else
        self:GetNeedItem_UIToggle().value = false
        self:GetNeedDiamond_UIToggle().value = true
        self:GetNeedItem_UIToggle():SwitchSpriteState(false)
        self:GetNeedDiamond_UIToggle():SwitchSpriteState(true)
    end
end

function UIPromptCrawlTowerPanel:RefreshUIPanel()
    self:GetTitle_UILabel().text = "闯天关" .. self.tblData.storey .. "层"
    local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.duplicateData.requireItems.list[0].list[0])
    self:GetNeedItemCount_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(itemCount, self.duplicateData.requireItems.list[0].list[1])
    local DiamondCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.duplicateData.requireItems2.list[0].list[0])
    self:GetNeedDiamondCount_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(DiamondCount, self.duplicateData.requireItems2.list[0].list[1])
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIPromptCrawlTowerPanel:ShowTips(trans, str, id)
    local TipsInfo = {}
    if str ~= nil or str ~= '' then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIDoctorPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 点击事件
function UIPromptCrawlTowerPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UIPromptCrawlTowerPanel")
end

function UIPromptCrawlTowerPanel:EnterBtnOnClick(go)
    if (self:GetNeedItem_UIToggle().value) then
        self.costType = 1
        local itemid = self.duplicateData.requireItems.list[0].list[0]
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemid)
        local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemid)
        if (itemCount < self.duplicateData.requireItems.list[0].list[1]) then
            local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(60)
            if (isfind) then
                self:ShowTips(go, string.format(data.content, itemInfo.name), 60)
                return
            end
        end
    elseif (self:GetNeedDiamond_UIToggle().value) then
        self.costType = 2
        local DiamondCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.duplicateData.requireItems2.list[0].list[0])
        if (DiamondCount < self.duplicateData.requireItems2.list[0].list[1]) then
            --if (self.OutPanel ~= nil and self.OutPanel) then
            --    self:ShowTips(go, nil, 60)
            --else
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.CrawlTower);
            --end
            return
        end
    end
    uimanager:ClosePanel("UICrawlTowerLeftMainPanel")
    uimanager:ClosePanel("UICrawlTowerResultPanel")
    networkRequest.ReqEnterDuplicate(self.tblData.duplicateId, self.costType)
    uimanager:ClosePanel("UICrawlTowerPanel")
    uimanager:ClosePanel("UIPromptCrawlTowerPanel")
    uimanager:ClosePanel("UICrawlTowerRewardPanel")
    uimanager:ClosePanel("UICrawlTowerRewardPanel")
end

function UIPromptCrawlTowerPanel:AddBtnOnClick(go)
    Utility.ShowItemGetWay(self.duplicateData.requireItems.list[0].list[0], go, LuaEnumWayGetPanelArrowDirType.Left);
end
--endregion

function ondestroy()

end

return UIPromptCrawlTowerPanel