---@type Utility
local Utility = Utility

---交易额度是否开启
Utility.IsAuctionDiamondQuotaOpen = false

---获取道具竞价价格
---@param bidItem auctionV2.AuctionItemInfo
function Utility.GetBidPrice(bidItem, num)
    if Utility.GetAuctionPriceRate() == nil then
        return 0
    end

    local price = math.ceil((Utility.GetAuctionPriceRate() / 10000) * bidItem.price.count + bidItem.auctionItemLotInfo.bidPrice)
    if bidItem.auctionItemLotInfo.bidPrice == 0 then
        price = bidItem.price.count * num
    end
    if price > bidItem.auctionItemLotInfo.fixedPrice then
        price = bidItem.auctionItemLotInfo.fixedPrice
    end
    return price
end

---竞价倍率
function Utility.GetAuctionPriceRate()
    return CS.Cfg_GlobalTableManager.Instance:GetAuctionAuctionPriceRate()
end

--endregion

---货币是否足够
function Utility.IsCoinEnough(price, priceid)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return false
    end
    if priceid == LuaEnumCoinType.Diamond then
        local diamond = Utility.GetAuctionDiamondNum()
        return diamond >= price
    elseif priceid == LuaEnumCoinType.YuanBao then
        local yuanbao = mainPlayerInfo.BagInfo:GetAuctionIngotNum()
        return yuanbao >= price
    end
end

---@return string 获取缩略文本显示
---@param str string 原文本
---@param label UILabel 组件
function Utility.GetShortShowLabel(str)
    local length = CS.Utility_Lua.StringLength(str) - 3
    if length - 9 <= 7 then
        return str
    end
    local newStr = CS.Utility_Lua.StringSub(str, 0, 14)
    return newStr .. "..."
end

---@return number 获得绑定钻石数据
function Utility.GetBindDiamondNum()
    return Utility.GetAllDiamondNum() - Utility.GetAuctionDiamondNum()
end

---@return number 获得非绑定钻石额度
function Utility.GetAuctionDiamondNum()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return 0
    end
    local bagInfo = mainPlayerInfo.BagInfo
    if bagInfo == nil then
        return 0
    end
    return bagInfo:GetAuctionDiamondNum()
end

---@return number 获取总钻石数据
function Utility.GetAllDiamondNum()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return 0
    end
    local bagInfo = mainPlayerInfo.BagInfo
    if bagInfo == nil then
        return 0
    end
    return bagInfo.DiamondNum
end