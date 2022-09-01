--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--booth.xml

--region ID:123002 ResBoothMapsMessage 摊位地图响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.BoothMapsResponse lua table类型消息数据
---@param csData boothV2.BoothMapsResponse C# class类型消息数据
netMsgPreprocessing[123002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:ResMapIdList(csData)
    if uiStaticParameter.OpenAuctionStallPanelType == LuaEnumOpenAuctionStallPanelType.SelfStall then
        uiStaticParameter.OpenAuctionStallPanelType = nil
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_StallShelf)
    end
end
--endregion

--region ID:123004 ResCreateBoothMessage 创建摊位响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.BoothInfo lua table类型消息数据
---@param csData boothV2.BoothInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[123004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:123006 ResChangeBoothNameMessage 改变摊位名字响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[123006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:123008 ResCancelBoothMessage 取消摊位响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[123008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:ResSelfBoothInfo(csData)
end
--endregion

--region ID:123010 ResGetBoothItemsMessage 摊位的商品列表信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.BoothItemList lua table类型消息数据
---@param csData boothV2.BoothItemList C# class类型消息数据
netMsgPreprocessing[123010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        local items = ternary(tblData.items == nil,{},tblData.items)
        local uiStallPanel = uimanager:GetPanel("UIStallPanel")
        if uiStallPanel ~= nil and (items == nil or #items <= 0) then
            uimanager:ClosePanel("UIStallPanel")
        else
            local commonData = {
                boothInfo = uiStaticParameter.ClickBoothInfo,
                csData = csData,
                maxGirdNum = ternary(#items == 0,1,#items)
            }
            uimanager:CreatePanel("UIStallPanel",nil,commonData)
        end
    end
end
--endregion

--region ID:123012 ResGetShelfBoothInfoMessage 摊位信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.ResBoothInfo lua table类型消息数据
---@param csData boothV2.ResBoothInfo C# class类型消息数据
netMsgPreprocessing[123012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:ResSelfBoothInfo(csData)
end
--endregion

--region ID:123014 ResBoothBuyMessage 摊位购买响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[123014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    networkRequest.ReqGetBoothItems(uiStaticParameter.BoothLid)
    --networkRequest.ReqGetMoonBoothItems(uiStaticParameter.BoothLid)
end
--endregion

--region ID:123016 ResGetUpdateBoothPointMessage 得到更新的摊位坐标响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.BoothCoordinateIdMsg lua table类型消息数据
---@param csData boothV2.BoothCoordinateIdMsg C# class类型消息数据
netMsgPreprocessing[123016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:RefreshBoothPositionInfo(csData)
end
--endregion

--region ID:123018 ResUpdateBoothPointMessage 更新摊位坐标响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData boothV2.UpdateBoothPointResponse lua table类型消息数据
---@param csData boothV2.UpdateBoothPointResponse C# class类型消息数据
netMsgPreprocessing[123018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.AuctionInfo:RefreshBoothPositionChange(csData)
end
--endregion
