--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--store.xml

--region ID:16002 ResOpenStoreByIdMessage 返回商店商品列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResOpenStoreById lua table类型消息数据
---@param csData storeV2.ResOpenStoreById C# class类型消息数据
netMsgPreprocessing[16002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.StoreInfoV2:UpdateStoreData(csData)
end
--endregion

--region ID:16003 ResSendStoreInfoChangeMessage 发送商店单个商品变化信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResSendStoreInfoChange lua table类型消息数据
---@param csData storeV2.ResSendStoreInfoChange C# class类型消息数据
netMsgPreprocessing[16003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.StoreInfoV2:UpdateSingleStore(csData)
end
--endregion

--region ID:16015 ResStoreInfoMessage 返回一件商品信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResStoreInfo lua table类型消息数据
---@param csData storeV2.ResStoreInfo C# class类型消息数据
netMsgPreprocessing[16015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.StoreInfoV2:UpdateSingleStore(csData)
end
--endregion

--region ID:16017 ResSynthesisMessage 返回合成成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResSynthesis lua table类型消息数据
---@param csData storeV2.ResSynthesis C# class类型消息数据
netMsgPreprocessing[16017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if(CS.CSScene.MainPlayerInfo ~= nil and csData ~= nil and csData.item ~= nil) then
        if(tblData ~= nil and tblData.item ~= nil and tblData.combineCount ~= nil) then
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tblData.item.itemId);
            if(isFind) then
                local info = {}
                info.Str = "[f7f2e6]获得了"
                info.IconName = itemTable.icon
                local countStr = tblData.item.count > 1 and "  "..tblData.combineCount or "";
                info.secondLabel = csData.item.ItemFullName..countStr;
                luaEventManager.DoCallback(LuaCEvent.SendMiddleTopTips, info);
            end
        end
    end
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AutoChooseEquipIndex()
end
--endregion

--region ID:16018 ResBuyItemMessage 购买回调
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResBuyItem lua table类型消息数据
---@param csData storeV2.ResBuyItem C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[16018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:16020 ResMostResyclePanelMessage 高级回收面板下发
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResMostResyclePanel lua table类型消息数据
---@param csData storeV2.ResMostResyclePanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[16020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:16023 ResCombineRecordMessage 合成记录
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.CombineRecord lua table类型消息数据
---@param csData storeV2.CombineRecord C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[16023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetSynthesisMgr():UpdateSynthesisHistoryData(tblData);
end
--endregion

--region ID:16025 ResCuiLianMessage 淬炼返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData storeV2.ResCuiLian lua table类型消息数据
---@param csData storeV2.ResCuiLian C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[16025] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
