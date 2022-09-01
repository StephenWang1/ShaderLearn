--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--collect.xml

--region ID:111102 ResPutCollectionItemMessage 藏品上架响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData collect.PutCollectionItemMsg lua table类型消息数据
---@param csData collect.PutCollectionItemMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111102] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetCollectionInfo():ResPutCollectionItem(tblData)
    end
end
--endregion

--region ID:111104 ResRemoveCollectionItemMessage 藏品下架响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData collect.RemoveCollectionItemMsg lua table类型消息数据
---@param csData collect.RemoveCollectionItemMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111104] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetCollectionInfo():ResRemoveCollectionItem(tblData)
    end
end
--endregion

--region ID:111106 ResSwapCollectionItemMessage 藏品交换位置响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData collect.CabinetInfo lua table类型消息数据
---@param csData collect.CabinetInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111106] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetCollectionInfo():ResSwapCollectionItem(tblData)
    end
end
--endregion

--region ID:111108 ResCallbackCollectionMessage 藏品回收响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData collect.CallbackCollectionMsg lua table类型消息数据
---@param csData collect.CallbackCollectionMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111108] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    print("收到藏品回收响应")
    if gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetCollectionInfo():ResCallbackCollection(tblData)
    end
end
--endregion

--region ID:111109 ResCabinetMessage 收藏柜信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData collect.CabinetInfo lua table类型消息数据
---@param csData collect.CabinetInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[111109] = function(msgID, tblData, csData)
    if tblData == nil then
        return
    end
    if gameMgr:GetPlayerDataMgr() ~= nil then

        local exp = tblData.exp - gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCabinetExp()
        if exp > 0 then
            ---弹出提示
            local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(1000046)
            if itemTbl and itemTbl:GetIcon() then

                local panel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
                if panel then
                    panel.SendMiddleTopTips("[fffab3]获得了[-]", itemTbl:GetIcon(), '收藏值' .. tostring(exp))
                    panel.SendTips(LuaEnumTextTipsType.LeftBottomTips, Utility.CombineStringQuickly("[fffab3]获取[-] [a4cef6]收藏值*", tostring(exp)))
                else
                    uimanager:CreatePanel("UIAllTextTipsContainerPanel", function()
                        panel.SendMiddleTopTips("[fffab3]获得了[-]", itemTbl:GetIcon(), '收藏值' .. tostring(exp))
                        panel.SendTips(LuaEnumTextTipsType.LeftBottomTips, Utility.CombineStringQuickly("[fffab3]获取[-] [a4cef6]收藏值*", tostring(exp)))
                    end)
                end
            end
        end

        gameMgr:GetPlayerDataMgr():GetCollectionInfo():RefreshCabinetInfo(tblData)
    end


end
--endregion
