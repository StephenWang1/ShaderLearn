---@class UIInvestmentTemplate 投资模板
local UIInvestmentTemplate = {}

function UIInvestmentTemplate:InitComponents()
    ---奖品列表
    self.AwardGrid = self:Get("AwardScroll/AwardGrid", "Top_UIGridContainer")
    ---领取
    self.btn_get = self:Get("btn_get", "GameObject")
    ---已领取
    self.geted = self:Get("geted", "GameObject")
    ---未领取
    self.Notgeted = self:Get("Notgeted", "GameObject")
    ---描述
    self.des = self:Get("des", "UILabel")
    ---标题描述
    self.Title = self:Get("Title", "UILabel")
    ---标题描述
    ---@type UISprite
    self.TitleSprite = self:Get("Sprite", "UISprite")


end

function UIInvestmentTemplate:InitOther()
    CS.UIEventListener.Get(self.btn_get).onClick = function(go)
        self:OnClickedbtn_Investment()
    end
end

---刷新UI
---@param data LuaInvestmentItem
function UIInvestmentTemplate:RefreshUI(data)
    if data == nil then
        return
    end
    self.InvestmentItem = data
    self:RefreshDes()
    self:RefereAwardGrid()
    self:RefreshButtonState()
end

---刷新描述
function UIInvestmentTemplate:RefreshDes()
    if self.InvestmentItem == nil then
        return
    end
    if self.InvestmentItem:GetInvestmentTable() == nil then
        return
    end
    self.Title.text = self.InvestmentItem:GetInvestmentTable():GetDescription()
    self.Title.gameObject:SetActive(true)
    self.des.gameObject:SetActive(false)
    self.TitleSprite:DelayUpdateAnchors()
    --self.TitleSprite:MakePixelPerfect()

end
---刷新奖品列表
function UIInvestmentTemplate:RefereAwardGrid()
    if self.InvestmentItem == nil then
        return
    end
    ---@type  table<number,InvestmentRewardData>
    local RewardList = self.InvestmentItem:GetRewardList()
    if RewardList == nil then
        return
    end
    self.AwardGrid.MaxCount = #RewardList
    local index = 0
    for i, v in pairs(RewardList) do
        local go = self.AwardGrid.controlList[index]
        local count = CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel")
        local icon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")

        local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(v.itemID)
        local itemInfoIsFind, csitemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v.itemID)
        if itemTable ~= nil then
            icon.spriteName = itemTable:GetIcon()
        end
        if self.InvestmentItem ~= nil and self.InvestmentItem.state == 1 then
            icon.color = LuaEnumUnityColorType.Grey
        else
            icon.color = LuaEnumUnityColorType.White
        end
        local countdes = v.count
        if v.count <= 1 then
            countdes = ""
        end
        count.text = countdes
        CS.UIEventListener.Get(go.gameObject).onClick = function(go)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = csitemInfo, showRight = false })
        end
        index = index + 1
    end
end

---刷新按钮状态
function UIInvestmentTemplate:RefreshButtonState()
    if self.InvestmentItem == nil then
        return
    end

    local state = self.InvestmentItem.state  -- 1已领 0未领 2可领
    ---已领取
    self.geted.gameObject:SetActive(state == 1)
    ---可领取
    self.btn_get.gameObject:SetActive(state == 2)
    ---未领取
    self.Notgeted.gameObject:SetActive(state == 0 or state == nil)
end

---点击领取按钮
function UIInvestmentTemplate:OnClickedbtn_Investment()
    if self.InvestmentItem == nil or self.InvestmentItem:GetInvestmentTable() == nil then
        return
    end
    local id = self.InvestmentItem:GetInvestmentTable():GetId()
    networkRequest.ReqReceiveInvest(id)
end

---初始化数据
function UIInvestmentTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

return UIInvestmentTemplate