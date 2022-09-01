---个人求购列表模板
---@class UIAuctionPanel_SelfBuyingListTemplate
local UIAuctionPanel_SelfBuyingListTemplate = {}

function UIAuctionPanel_SelfBuyingListTemplate:Init(panel)
    ---@type UIAuctionPanel_SelfBuyingPanel
    self.mRootPanel = panel
    self:InitComponent()
    self:InitData()
end

function UIAuctionPanel_SelfBuyingListTemplate:InitComponent()
    self.gridContainer = self:Get("AuctionSellList", "UIGridContainer")
    ---@type UILoopScrollViewPlus
    self.grid_UILoopScrollViewPlus = self:Get("AuctionSellList", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject
    self.noSaleItem = self:Get("NoBuying", "GameObject")
end

function UIAuctionPanel_SelfBuyingListTemplate:InitData()
    self.mGridNum = 1
end

---@return number 上架最大数目
function UIAuctionPanel_SelfBuyingListTemplate:GetAuctionShelfMaxNum()
    if self.mAuctionMaxShelfNum == nil then
        self.mAuctionMaxShelfNum = CS.Cfg_VipTableManager.Instance:GetCurrentAuctionShelfNum(2)
    end
    return self.mAuctionMaxShelfNum
end

---刷新竞拍上架
function UIAuctionPanel_SelfBuyingListTemplate:RefreshGridShow()
    local info = CS.CSScene.MainPlayerInfo.AuctionInfo.AuctionBuyingShelfInfo
    local ShowInfo = self:GetShowSellInfo(info)
    if not CS.StaticUtility.IsNull(self.grid_UILoopScrollViewPlus) then
        -- self:RefreshBuyingShelfOne(ShowInfo)
        self:RefreshBuyingShelfTwo(ShowInfo)
    end
end

--region 第二版
--[[function UIAuctionPanel_SelfBuyingListTemplate:RefreshBuyingShelfTwo(ShowInfo)
    self.noSaleItem:SetActive(#ShowInfo == 0)
    if #ShowInfo == 0 then
        self.gridContainer.MaxCount = 0
    else
        --   local number = ternary(#ShowInfo >= self:GetAuctionShelfMaxNum(), #ShowInfo, #ShowInfo + 1)
        local number = #ShowInfo
        self.gridContainer.MaxCount = number
        for i = 0, self.gridContainer.controlList.Count - 1 do
            local go = self.gridContainer.controlList[i]
            local template = self:GetAuctionShelfTemplate(go)
            if template then
                template:RefreshUI(ShowInfo[i + 1])
            end
        end
    end
end]]

function UIAuctionPanel_SelfBuyingListTemplate:RefreshBuyingShelfTwo(ShowInfo)
    self.noSaleItem:SetActive(#ShowInfo == 0)

    self.grid_UILoopScrollViewPlus:Init(function(go, line)
        if line < #ShowInfo then
            local template = self:GetAuctionShelfTemplate(go)
            if template then
                template:RefreshUI(ShowInfo[line + 1])
            end
            return true
        else
            return false
        end
    end, nil)
end

--endregion


---@return UIAuctionPanel_SelfBuyingListGridTemplate 竞价上架模板
function UIAuctionPanel_SelfBuyingListTemplate:GetAuctionShelfTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_SelfBuyingListGridTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

---将字典转换成table
function UIAuctionPanel_SelfBuyingListTemplate:GetShowSellInfo(dic)
    local list = {}
    CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
        table.insert(list, v)
    end)
    return list
end

return UIAuctionPanel_SelfBuyingListTemplate