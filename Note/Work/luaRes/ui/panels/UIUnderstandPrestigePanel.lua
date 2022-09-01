---了解声望界面
---@class UIUnderstandPrestigePanel:UIBase
local UIUnderstandPrestigePanel = {}

---关闭按钮
---@return UnityEngine.GameObject
function UIUnderstandPrestigePanel:GetCloseButtonGO()
    if self.mCloseButtonGO == nil then
        self.mCloseButtonGO = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseButtonGO
end

---声望文本
---@return UILabel
function UIUnderstandPrestigePanel:GetShengWangLabel()
    if self.mShengWangLabel == nil then
        self.mShengWangLabel = self:GetCurComp("WidgetRoot/panel/myPrestige/num", "UILabel")
    end
    return self.mShengWangLabel
end

---获取奖励的GridContainer
---@return UIGridContainer
function UIUnderstandPrestigePanel:GetAwardsGridContainer()
    if self.mAwardGridContainer == nil then
        self.mAwardGridContainer = self:GetCurComp("WidgetRoot/panel/rewards", "UIGridContainer")
    end
    return self.mAwardGridContainer
end

function UIUnderstandPrestigePanel:Init()
    self:InitializeData()
    self:BindUIEvents()
    self:BindEvents()
    self:Refresh()
end

function UIUnderstandPrestigePanel:InitializeData()
    ---@type table<number,number>
    self.mAward = {}
    ---@type TABLE.CFG_GLOBAL
    local tbl
    ___, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22403)
    if tbl ~= nil and tbl.value ~= "" then
        local strs = string.Split(tbl.value, "#")
        for i = 1, #strs do
            local temp = tonumber(strs[i])
            table.insert(self.mAward, temp)
        end
    end
end

function UIUnderstandPrestigePanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGO()).onClick = function()
        self:ClosePanel()
    end
end

function UIUnderstandPrestigePanel:BindEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshShengWang()
    end)
end

function UIUnderstandPrestigePanel:Refresh()
    self:RefreshShengWang()
    self:RefreshAwards()
end

---刷新声望值
---@private
---@param content any|nil
function UIUnderstandPrestigePanel:RefreshShengWang(content)
    ---刷新声望值
    if content == nil or CS.CSScene.MainPlayerInfo ~= nil then
        local shengWangValue = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.ShengWang);
        if CS.StaticUtility.IsNull(self:GetShengWangLabel()) == false then
            self:GetShengWangLabel().text = "[00ff00]" .. tostring(shengWangValue)
        end
    else
        if CS.StaticUtility.IsNull(self:GetShengWangLabel()) == false then
            self:GetShengWangLabel().text = "[00ff00]" .. tostring(content)
        end
    end
end

---刷新奖励
function UIUnderstandPrestigePanel:RefreshAwards()
    self:GetAwardsGridContainer().MaxCount = #self.mAward
    for i = 1, #self.mAward do
        local go = self:GetAwardsGridContainer().controlList[i - 1]
        self:InitializeAwardsGrid(go, self.mAward[i])
    end
end

---初始化奖励格子
---@param gridGO UnityEngine.GameObject
---@param itemID number
function UIUnderstandPrestigePanel:InitializeAwardsGrid(gridGO, itemID)
    if CS.StaticUtility.IsNull(gridGO) then
        return
    end
    ---@type TABLE.CFG_ITEMS
    local itemTable
    ___, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemID)
    if itemTable == nil then
        gridGO:SetActive(false)
        return
    end
    ---@type UISprite
    local iconSprite = self:GetComp(gridGO.transform, "icon", "UISprite")
    iconSprite.spriteName = itemTable.icon
    ---@type UILabel
    local countLabel = self:GetComp(gridGO.transform, "count", "UILabel")
    countLabel.text = ""
    CS.UIEventListener.Get(gridGO).onClick = function()
        self:OnAwardsGridClicked(itemTable)
    end
end

---奖励格子点击事件
---@param itemTable TABLE.CFG_ITEMS
function UIUnderstandPrestigePanel:OnAwardsGridClicked(itemTable)
    uiStaticParameter.UIItemInfoManager:CreatePanel({
        itemInfo = itemTable,
        showRight = false,
    })
end

return UIUnderstandPrestigePanel