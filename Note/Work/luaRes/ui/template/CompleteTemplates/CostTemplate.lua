---@class CostTemplate:TemplateBase 花费模板
local CostTemplate = {}

--region 初始化
function CostTemplate:Init()
    self:InitComplete()
    self:BindEvents()
end

function CostTemplate:InitComplete()
    ---@type UISprite
    self.icon_UISprite = self:Get("icon", "UISprite")
    ---@type UILabel
    self.num_UILabel = self:Get("num", "UILabel")
    ---@type UnityEngine.GameObject
    self.add_GameObject = self:Get("add", "GameObject")
end

function CostTemplate:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.add_GameObject, function()
        self:OpenWayGetPanel()
    end)
    luaclass.UIRefresh:BindClickCallBack(self.icon_UISprite, function()
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.costItemInfo:GetId())
        if itemInfoIsFind then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
        end
    end)
end
--endregion

--region 事件
---打开获取途径面板
function CostTemplate:OpenWayGetPanel()
    if self.costItemInfo ~= nil and self.costItemInfo:GetWayGet() ~= nil then
        Utility.ShowItemGetWay(self.costItemInfo:GetId(), self.add_GameObject, LuaEnumWayGetPanelArrowDirType.Down)
    end
end
--endregion

---@class CostTemplateCommonData
---@field Cost Cost

--region 刷新
---刷新面板
---@param commonData CostTemplateCommonData
function CostTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        luaclass.UIRefresh:RefreshActive(self.go, false)
        return
    end
    self:RefreshIcon()
    self:RefreshNum()
end

---刷新面板，只刷新Icon和消耗的数量
---@param commonData CostTemplateCommonData
function CostTemplate:SimpleRefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        luaclass.UIRefresh:RefreshActive(self.go, false)
        return
    end
    self:RefreshIcon()
    self:RefreshCostNum()
end

---隐藏面板
function CostTemplate:HidePanel()
    luaclass.UIRefresh:RefreshSprite(self.icon_UISprite, '')
    luaclass.UIRefresh:RefreshLabel(self.num_UILabel, '')
end

---解析参数
---@param commonData CostTemplateCommonData
---@return boolean
function CostTemplate:AnalysisParams(commonData)
    if type(commonData) ~= 'table' or commonData.Cost == nil then
        return false
    end
    self.commonData = commonData
    self.Cost = commonData.Cost
    if type(self.Cost.costNum) ~= 'number' or self.Cost.costNum <= 0 then
        return false
    end
    if type(self.Cost.itemId) == 'number' then
        self.costItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.Cost.itemId)
    end
    return true
end

---刷新icon
function CostTemplate:RefreshIcon()
    if self.costItemInfo == nil then
        return
    end
    luaclass.UIRefresh:RefreshSprite(self.icon_UISprite, self.costItemInfo:GetIcon())
end

---刷新花费
function CostTemplate:RefreshNum()
    if self.costItemInfo == nil then
        return
    end
    local bagItemCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(self.costItemInfo:GetId())
    local showText = CS.Utility_Lua.SetProgressLabelColor(bagItemCount, self.Cost.costNum)
    luaclass.UIRefresh:RefreshLabel(self.num_UILabel, showText)
end

---刷新消耗花费
function CostTemplate:RefreshCostNum()
    luaclass.UIRefresh:RefreshLabel(self.num_UILabel, self.Cost.costNum)
end
--endregion

--region 查询
---查询花费是否足够
---@return boolean 花费是否足够
function CostTemplate:CostIsEnough()
    if self.Cost ~= nil and type(self.Cost.itemId) == 'number' and type(self.Cost.costNum) == 'number' then
        return gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():CheckBagHaveEnoughItem(self.Cost.itemId, self.Cost.costNum)
    end
    return true
end
--endregion

return CostTemplate