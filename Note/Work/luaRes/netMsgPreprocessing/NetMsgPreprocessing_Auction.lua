--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--auction.xml

--region ID:111002 ResGetAuctionItemsMessage 商品列表响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionItemList lua table类型消息数据
---@param csData auctionV2.AuctionItemList C# class类型消息数据
netMsgPreprocessing[111002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.UnionSmeltDataInfo:RefreshUnionSmeltWarehouseTable(tblData)
end
--endregion

--region ID:111004 ResGetAuctionShelfMessage 自己已上架商品列表响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionItemShelfList lua table类型消息数据
---@param csData auctionV2.AuctionItemShelfList C# class类型消息数据
netMsgPreprocessing[111004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            mainPlayerInfo.AuctionInfo:UpdateSellList(csData)
        end
    end
end
--endregion

--region ID:111006 ResAddToShelfMessage 上架响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AddToShelfResponse lua table类型消息数据
---@param csData auctionV2.AddToShelfResponse C# class类型消息数据
netMsgPreprocessing[111006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:UpdateAuctionInfo(csData)
end
--endregion

--region ID:111008 ResReAddToShelfMessage 重新上架响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionItemInfo lua table类型消息数据
---@param csData auctionV2.AuctionItemInfo C# class类型消息数据
netMsgPreprocessing[111008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:UpdateReAddAuctionInfo(csData)
end
--endregion

--region ID:111010 ResRemoveFromShelfMessage 下架响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.ItemMsg lua table类型消息数据
---@param csData auctionV2.ItemMsg C# class类型消息数据
netMsgPreprocessing[111010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:UpdateRemoveAuctionInfo(csData)
end
--endregion

--region ID:111012 ResBuyAuctionItemMessage 购买响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.ItemMsg lua table类型消息数据
---@param csData auctionV2.ItemMsg C# class类型消息数据
netMsgPreprocessing[111012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111015 ResAuctionSearchMessage 搜索响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.SearchAuctionItemResponse lua table类型消息数据
---@param csData auctionV2.SearchAuctionItemResponse C# class类型消息数据
netMsgPreprocessing[111015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111016 ResLoseMessage 购买失败响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.lose lua table类型消息数据
---@param csData auctionV2.lose C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111017 ResAddToShelfLoseMessage 上架失败响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.lose lua table类型消息数据
---@param csData auctionV2.lose C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111019 ResMarketPriceSectionMessage 拍卖品的价格区间响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.MarketPriceSection lua table类型消息数据
---@param csData auctionV2.MarketPriceSection C# class类型消息数据
netMsgPreprocessing[111019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111021 ResAuctionLotMessage 拍卖响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionItemInfo lua table类型消息数据
---@param csData auctionV2.AuctionItemInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111024 ResReleaseBuyProductsMessage 发布求购响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionItemInfo lua table类型消息数据
---@param csData auctionV2.AuctionItemInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111026 ResSubmitBuyProductsItemMessage 提交求购的物品响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.SubmitBuyProductsItemResponse lua table类型消息数据
---@param csData auctionV2.SubmitBuyProductsItemResponse C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111027 ResPushMessage 推送响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.pushResponse lua table类型消息数据
---@param csData auctionV2.pushResponse C# class类型消息数据
netMsgPreprocessing[111027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        ---@type UIMainChatPanel
        ---@type CSMainPlayerInfo
        local playerInfo = CS.CSScene.MainPlayerInfo
        if playerInfo then
            local flashData = {}
            local pushType = csData.PushType
            --是否是上架推送
            local playerBagInfo = playerInfo.BagInfo
            local isAddToShelfPush = pushType == Utility.EnumToInt(CS.auctionV2.PushType.PUTONPUSH)
            if isAddToShelfPush then
                playerBagInfo.PushDataLid = csData.item.lid
            else
                Utility.RemoveFlashPrompt(1, 10)
            end
            local id = ternary(isAddToShelfPush, 9, 10)
            flashData.id = id
            local customData = {}
            customData.mNormalPushData = csData
            customData.mPushType = LuaEnumAuctionPushType.GuessLikePush
            flashData.panelPriority = customData
            flashData.clickCallBack = function()
                Utility.RemoveFlashPrompt(1, id)
            end
            Utility.AddFlashPrompt(flashData)
        end
    end
end
--endregion

--region ID:111030 ResGuessYouLikeMessage 猜你喜欢响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.GuessYouLikeResponse lua table类型消息数据
---@param csData auctionV2.GuessYouLikeResponse C# class类型消息数据
netMsgPreprocessing[111030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111034 ResTradeRecordInfoMessage 交易记录响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.TeadeRecordRes lua table类型消息数据
---@param csData auctionV2.TeadeRecordRes C# class类型消息数据
netMsgPreprocessing[111034] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111036 ResReceiveTradeRecordMessage 领取交易记录响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.TradeRecordId lua table类型消息数据
---@param csData auctionV2.TradeRecordId C# class类型消息数据
netMsgPreprocessing[111036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:111037 ResTradeRecordRedPointMessage 交易记录红点提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.TradeRecordRedPoint lua table类型消息数据
---@param csData auctionV2.TradeRecordRedPoint C# class类型消息数据
netMsgPreprocessing[111037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end
    mainPlayerInfo.AuctionInfo.IsShowAuctionTransactionRecordRedPoint = tblData.redPoint == 1
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.AuctionAll)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.AuctionTransactionRecord)
end
--endregion

--region ID:111038 ResUnionSmeltGoodsChangeMessage 行会熔炼物品变动
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.UnionSmeltGoodsChange lua table类型消息数据
---@param csData auctionV2.UnionSmeltGoodsChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111038] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.UnionSmeltDataInfo:RefreshSeveralAuctionItem(tblData)
end
--endregion

--region ID:111041 ResAuctionPushMessage 新增购买推送
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.AuctionPush lua table类型消息数据
---@param csData auctionV2.AuctionPush C# class类型消息数据
netMsgPreprocessing[111041] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and tblData.pushType and tblData.pushType == 1 then
        Utility.RemoveFlashPrompt(1, 37)
        local id = 37
        local flashData = {}
        flashData.id = id
        flashData.clickCallBack = function()
            Utility.RemoveFlashPrompt(1, id)
            local customData = {}
            customData.id = 149
            customData.Callback = function()
                uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Union, nil, nil)
            end
            Utility.ShowPromptTipsPanel(customData)
        end
        Utility.AddFlashPrompt(flashData)
        return
    end
    local needReturn = csData.item == nil
    if needReturn then
        local str = "行会竞拍推送出现csData.item为空:"
        if tblData == nil then
            str = str .. "tblData为空,"
        else
            str = str .. "tblData不为空,"
            if tblData.pushType == nil then
                str = str .. "tblData.pushType为空"
            else
                str = str .. "tblData.pushType不为空,pushType:" .. tblData.pushType
            end
            if tblData.sign == nil then
                str = str .. "tblData.sign为空"
            else
                str = str .. "tblData.sign不为空,tblData.sign:" .. tblData.sign
            end
            if tblData.time == nil then
                str = str .. "tblData.time为空"
            else
                str = str .. "tblData.time不为空,tblData.time:", tblData.time
            end
        end
        CS.UnityEngine.Debug.LogError(str)
        return
    end
    if csData then
        Utility.RemoveFlashPrompt(1, 10)
        local id = 10
        local flashData = {}
        flashData.id = id
        local customData = {}
        customData.mNormalPushData = csData
        customData.mPushType = LuaEnumAuctionPushType.PlayerTradePush
        flashData.panelPriority = customData
        flashData.clickCallBack = function()
            Utility.RemoveFlashPrompt(1, id)
        end
        Utility.AddFlashPrompt(flashData)
    end
end
--endregion

--region ID:111044 ResQuickAuctionItemMessage 返回快捷购买道具
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.ResQuickAuctionItem lua table类型消息数据
---@param csData auctionV2.ResQuickAuctionItem C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111044] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--[[
--region ID:111032 ResOpenTradeBeforeMessage 打开交易行之前的响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.OpenTradeBeforeResponse lua table类型消息数据
---@param csData auctionV2.OpenTradeBeforeResponse C# class类型消息数据
netMsgPreprocessing[111032] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:111007 ResAgreeSwornMessage 重新上架请求
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.ReAddToShelfRequest lua table类型消息数据
---@param csData auctionV2.ReAddToShelfRequest C# class类型消息数据
netMsgPreprocessing[111007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:111009 ReqInterruptSwornMessage 下架请求
---@param msgID LuaEnumNetDef 消息ID
---@param tblData auctionV2.PutOffRequest lua table类型消息数据
---@param csData auctionV2.PutOffRequest C# class类型消息数据
netMsgPreprocessing[111009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
