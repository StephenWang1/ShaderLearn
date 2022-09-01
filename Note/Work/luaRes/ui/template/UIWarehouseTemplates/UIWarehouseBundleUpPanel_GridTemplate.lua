---@class UIWarehouseBundleUpPanel_GridTemplate 仓库打捆格子模板
local UIWarehouseBundleUpPanel_GridTemplate = {}

function UIWarehouseBundleUpPanel_GridTemplate:Init()
    self:InitData()
    self:InitComponent()
end

function UIWarehouseBundleUpPanel_GridTemplate:InitData()
    self.id = nil
    self.itemId = nil
    self.itemInfo = nil
    self.costInfo = nil
end

function UIWarehouseBundleUpPanel_GridTemplate:InitComponent()
    self.bgLine_UISprite = self:Get("bkline/line1", "UISprite")
    self.Icon_UISprite = self:Get("Iteminfo/Icon", "UISprite")
    self.Name_UILabel = self:Get("Iteminfo/name", "UILabel")
    self.itemCount_UILabel = self:Get("Iteminfo/count", "UILabel")
    self.CostRoot1_GameObject = self:Get("payment1", "GameObject")
    self.CostIcon_UISprite = self:Get("payment1/icon1", "UISprite")
    self.CostNum_UILabel = self:Get("payment1/number1", "UILabel")
    self.CostRoot2_GameObject = self:Get("payment2", "GameObject")
    self.CostIcon2_UISprite = self:Get("payment2/icon2", "UISprite")
    self.CostNum2_UILabel = self:Get("payment2/number2", "UILabel")
    self.ExchangeBtn_GameObject = self:Get("exchange_btn", "GameObject")
    self.ExchangeBtn_Label = self:Get("exchange_btn/words", "UILabel")
    self.ExchangeBtn_UISprite = self:Get("exchange_btn", "UISprite")
end

function UIWarehouseBundleUpPanel_GridTemplate:RefreshItem(id, isShowBg)
    if id == nil then
        return
    end
    self.id = id
    local res2, bindItemInfo = CS.Cfg_BindItemTableManager.Instance.dic:TryGetValue(id)
    if res2 == false then
        return
    end
    self.itemId = bindItemInfo.target
    self.paymentShown = bindItemInfo.payment
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.itemId)
    if res then
        self.itemInfo = itemInfo
        local color = ternary(isShowBg, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
        self.bgLine_UISprite.color = color
        self.Icon_UISprite.spriteName = itemInfo.icon
        self.Name_UILabel.text = itemInfo.name
        CS.UIEventListener.Get(self.ExchangeBtn_GameObject).LuaEventTable = self
        CS.UIEventListener.Get(self.ExchangeBtn_GameObject).OnClickLuaDelegate = self.OnExchangeButtonClicked
    end
    if res2 then

        self.costInfo = bindItemInfo.itemId
        local costList = self.costInfo.list
        self.CostRoot2_GameObject:SetActive(false)
        for i = 0, costList.Count - 1 do
            if i == 0 then
                self:SetCostIcon(self.CostIcon_UISprite, self.CostNum_UILabel, costList[i])
            end
        end
        if (self.paymentShown ~= nil) then
            self.CostRoot2_GameObject:SetActive(true)
            local paymentShown = self.paymentShown.list
            for i = 0, paymentShown.Count - 1 do
                if i == 0 then
                    self:SetCostIcon(self.CostIcon2_UISprite, self.CostNum2_UILabel, paymentShown[i])
                end
            end
        end

        self.itemCount_UILabel.text = ternary(bindItemInfo.itemNo and bindItemInfo.itemNo ~= 0, bindItemInfo.itemNo, "")
    end
    self:SetExchangeButton()
end

---设置捆绑按钮颜色
function UIWarehouseBundleUpPanel_GridTemplate:SetExchangeButton()
    local num = self:CanExchangeNum()
    local isUnavailable = num <= 0
    if isUnavailable == false and self:IsEnoughSpaceInBag(1) == false then
        isUnavailable = true
    end
    local btnColor = ternary(isUnavailable, LuaEnumUnityColorType.Gray, LuaEnumUnityColorType.White)
    self.ExchangeBtn_UISprite.color = btnColor
    if isUnavailable then
        self.ExchangeBtn_Label.text = "[878787]打捆[-]"
    else
        self.ExchangeBtn_Label.text = "[C3F4FF]打捆[-]"
    end
end

---设置消耗ICon
function UIWarehouseBundleUpPanel_GridTemplate:SetCostIcon(iconGo, numGo, info)
    if iconGo and numGo and info then
        local res, ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.list[0])
        if res then
            iconGo.spriteName = ItemInfo.icon
            numGo.text = "x" .. info.list[1]
        end
    end
end

function UIWarehouseBundleUpPanel_GridTemplate:CheckPayNum()
    if (self.paymentShown ~= nil) then
        local paynum = self:CanExchangeNumByPay()
        if (paynum == 0) then
            self:ShowBubbleTips(479)
            return false
        end
    end
    return true
end
---点击兑换
function UIWarehouseBundleUpPanel_GridTemplate:OnExchangeButtonClicked()
    if self.itemInfo and self.costInfo then
        local num = self:CanExchangeNum()
        if self:IsEnoughSpaceInBag(1) then
            if num > 1 then
                if (self:CheckPayNum() == false) then
                    self:ShowBubbleTips(479)
                    return
                end
                uimanager:CreatePanel("UIBandItemsSetPanel", nil, self.itemInfo, self.paymentShown, num, self.id)
            elseif num <= 0 then
                self:ShowBubbleTips(59)
            elseif num == 1 then
                if (self:CheckPayNum() == false) then
                    self:ShowBubbleTips(479)
                    return
                end
                luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.itemId, from = self.Icon_UISprite.transform.position })
                networkRequest.ReqBuyResBundlitem(self.id, num)
            end
        else
            self:ShowBubbleTips(281)
        end
    end
end

---背包中是否有足够的空间
---@return boolean
function UIWarehouseBundleUpPanel_GridTemplate:IsEnoughSpaceInBag(num)
    local itemInfo = self.itemInfo
    if itemInfo == nil then
        return false
    end
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return false
    end
    return CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(itemInfo, num)
end

---当前可兑换道具数量（手续费）
function UIWarehouseBundleUpPanel_GridTemplate:CanExchangeNumByPay()
    local minNum = -1
    if self.paymentShown then
        local costList = self.paymentShown.list
        for i = 0, costList.Count - 1 do
            local itemID = costList[i].list[0]
            local itemNum = costList[i].list[1]
            local coinInfo
            coinInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemID)
            if coinInfo ~= 0 then
                local num = math.floor(coinInfo / itemNum)
                if minNum == -1 then
                    minNum = num
                else
                    if num < minNum then
                        minNum = num
                    end
                end
            else
                local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemID)
                if bagItemNum then
                    local num = math.floor(bagItemNum / itemNum)
                    if minNum == -1 then
                        minNum = num
                    else
                        if num < minNum then
                            minNum = num
                        end
                    end
                end
            end
        end
    end
    local finalNum = ternary(minNum == -1, 0, minNum)
    return finalNum
end

---当前可兑换道具数量
function UIWarehouseBundleUpPanel_GridTemplate:CanExchangeNum()
    local minNum = -1
    if self.costInfo then
        local costList = self.costInfo.list
        for i = 0, costList.Count - 1 do
            local itemID = costList[i].list[0]
            local itemNum = costList[i].list[1]
            local coinInfo
            ---元宝打捆时只能用表中配的元宝类型，此处屏蔽绑元
            if (itemID == LuaEnumCoinType.YuanBao) then
                coinInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetAuctionIngotNum()
            else
                coinInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemID)
            end
            if coinInfo ~= 0 then
                local num = math.floor(coinInfo / itemNum)
                if minNum == -1 then
                    minNum = num
                else
                    if num < minNum then
                        minNum = num
                    end
                end
            else
                local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemID)
                if bagItemNum then
                    local num = math.floor(bagItemNum / itemNum)
                    if minNum == -1 then
                        minNum = num
                    else
                        if num < minNum then
                            minNum = num
                        end
                    end
                end
            end
        end
    end
    local finalNum = ternary(minNum == -1, 0, minNum)
    return finalNum
end

---显示提示
function UIWarehouseBundleUpPanel_GridTemplate:ShowBubbleTips(id)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = self.ExchangeBtn_GameObject.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

return UIWarehouseBundleUpPanel_GridTemplate
