--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--npcstore.xml

--region ID:124002 ResNpcStoreMessage 返回NPC商店
---@param msgID LuaEnumNetDef 消息ID
---@param tblData npcstoreV2.ResNpcStoreInfo lua table类型消息数据
---@param csData npcstoreV2.ResNpcStoreInfo C# class类型消息数据
netMsgPreprocessing[124002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:124004 ResNpcStoreSellListMessage 返回NPC商店出售列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData npcstoreV2.NpcStoreGridList lua table类型消息数据
---@param csData npcstoreV2.NpcStoreGridList C# class类型消息数据
netMsgPreprocessing[124004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:124006 ResNpcStorePutOnMessage 返回NPC商店上架
---@param msgID LuaEnumNetDef 消息ID
---@param tblData npcstoreV2.ResPutOnNpcStoreItem lua table类型消息数据
---@param csData npcstoreV2.ResPutOnNpcStoreItem C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[124006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:124008 ResNpcStoreBuyMessage 返回NPC商店购买
---@param msgID LuaEnumNetDef 消息ID
---@param tblData npcstoreV2.ResBuyNpcStore lua table类型消息数据
---@param csData npcstoreV2.ResBuyNpcStore C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[124008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
