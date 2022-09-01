---@class UIGuildelEctionsPanel_Vote:UIAuctionPanel_AuctionItemTemplateBase 帮会投票模板
local UIGuildelEctionsPanel_Vote = {}

UIGuildelEctionsPanel_Vote.mNameShow = {
    [0] = "额度",
    [1] = "拥有"
}

setmetatable(UIGuildelEctionsPanel_Vote, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

---刷新玩家拥有
function UIGuildelEctionsPanel_Vote:GetPlayerHas()
    if self.priceItemInfo then
        local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.priceItemInfo.id)
        return selfCost
    end
end

---@param data customData
---@alias customData{}
function UIGuildelEctionsPanel_Vote:Init(data)
    self:RunBaseFunction("Init", data)
    --价格
    self.price = data.VoteCost
    ---@type TABLE.CFG_ITEMS
    self.priceItemInfo = data.VoteItemInfo

    local playerCanBuy = 0
    local playerHas = self:GetPlayerHas()
    if playerHas then
        playerCanBuy = math.floor(playerHas / self.price)
    end
    self.mMaxNum = CS.Cfg_GlobalTableManager.Instance:VoteMaxNum()

    if self.mMaxNum == 0 then
        self.mMaxNum = 1
    end

    self.mMinNum = 1
    self.num = self.mMinNum
    --刷新
    self:SuitPanel()
    self:SetNum()
    self.bg_UISprite.spriteName = "arrow_bg"
end

function UIGuildelEctionsPanel_Vote:SetNum()
    self.num_UIInput.value = self.num
    self:RefreshPriceShow()
end

---刷新价格显示
function UIGuildelEctionsPanel_Vote:RefreshPriceShow()
    local cost = self.price * self.num
    self.mPriceLabel[0].text = cost
    local num = self:GetPlayerHas()
    local show = num
    if num == nil then
        show = 0
    end
    self.mPriceLabel[1].text = (cost < num and luaEnumColorType.White or luaEnumColorType.Red) .. num .. "[-]";
end

---刷新每行货币信息
---@param go UnityEngine.GameObject 每行货币
---@param i number 从0开始的行数
function UIGuildelEctionsPanel_Vote:RefreshLineCoin(go, i)
    local name = CS.Utility_Lua.Get(go.transform, "Label", "UILabel")
    local priceIcon = CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "gold", "UILabel")
    name.text = self.mNameShow[i]
    self.mPriceLabel[i] = priceLabel
    if self.priceItemInfo then
        priceIcon.spriteName = self.priceItemInfo.icon
    end
end

--region 用于重写
function UIGuildelEctionsPanel_Vote:IsNumLabelNeedSpace()
    return false
end

---@return boolean 是否显示标题
function UIGuildelEctionsPanel_Vote:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIGuildelEctionsPanel_Vote:ShowNum()
    return true
end

---@return number 价格行数
function UIGuildelEctionsPanel_Vote:ShowCoin()
    local lineNum = 2
    self.coin_UIGridContainer.MaxCount = lineNum
    self.mPriceLabel = {}
    for i = 0, lineNum - 1 do
        local go = self.coin_UIGridContainer.controlList[i]
        self:RefreshLineCoin(go, i)
    end
    return lineNum
end

---@return boolean 是否显示滑条
function UIGuildelEctionsPanel_Vote:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIGuildelEctionsPanel_Vote:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIGuildelEctionsPanel_Vote:ShowLabel()
    return false
end

---@return boolean 是否显示加号
function UIGuildelEctionsPanel_Vote:ShowAddBtn()
    return true
end

---@return boolean 是否显示减号
function UIGuildelEctionsPanel_Vote:ShowReduceBtn()
    return true
end

---点击上架按钮
function UIGuildelEctionsPanel_Vote:OnShelfClicked(go)
    if self.data and self.data.VoteLid and self.num and self.price then
        local cost = self.price * self.num
        local playerHas = self:GetPlayerHas()
        if cost > playerHas then
            Utility.ShowItemGetWay(self.priceItemInfo.id, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(100, 0));
            return
        end
        networkRequest.ReqElectionVote(self.data.VoteLid, self.num)
    end
end

---刷新标题
function UIGuildelEctionsPanel_Vote:RefreshTitle()
    self.centerBtn_UILabel.text = "投票"
end

function UIGuildelEctionsPanel_Vote:RefreshNumName()
    self.mNameTitle_UILabel.text = "数量"
end
--endregion

return UIGuildelEctionsPanel_Vote