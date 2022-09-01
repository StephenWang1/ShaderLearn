--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--trade.xml

--region ID:104002 ResTradeMessage 返回交易请求
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tradeV2.ResTrade lua table类型消息数据
---@param csData tradeV2.ResTrade C# class类型消息数据
netMsgPreprocessing[104002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local data={}
    data.id=24
    data.clickCallBack = function()
        Utility.RemoveFlashPrompt(1,24)
        local TipData={}
        TipData.PromptWordId= 87
        TipData.des=CS.Cfg_PromptWordTableManager.Instance:GetShowContent(87,csData.name)
        --TipData.Time=  tblData.endTime-CS.CSServerTime.Instance.TotalMillisecond
        TipData.ComfireAucion=function() 
            networkRequest.ReqAgreeTrade(tblData.uid, 1)
        end
        TipData.CloseCallBack=function() 
            networkRequest.ReqAgreeTrade(tblData.uid, 0)
            uimanager:ClosePanel('UIPromptPanel')
        end
        Utility.ShowSecondConfirmPanel(TipData)
    end
    Utility.TryAddFlashPromp(data)
end
--endregion

--region ID:104007 ResTradeStateChangeMessage 返回交易状态变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tradeV2.ResTradeStateChange lua table类型消息数据
---@param csData tradeV2.ResTradeStateChange C# class类型消息数据
netMsgPreprocessing[104007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:104008 ResTradeStartMessage 交易开始
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tradeV2.TradeInfo lua table类型消息数据
---@param csData tradeV2.TradeInfo C# class类型消息数据
netMsgPreprocessing[104008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:CreatePanel("UIFaceToFaceDealPanel", function()
        uimanager:CreatePanel("UIBagPanel",nil, { type = LuaEnumBagType.Trade })
    end,csData)
   
   
end
--endregion

--region ID:104009 ResTradeUpdateMessage 交易变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tradeV2.TradeInfo lua table类型消息数据
---@param csData tradeV2.TradeInfo C# class类型消息数据
netMsgPreprocessing[104009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
