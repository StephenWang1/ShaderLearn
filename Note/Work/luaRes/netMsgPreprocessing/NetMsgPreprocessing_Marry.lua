--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--marry.xml

--region ID:114003 ResMatchmakerPanelMessage 弹出誓言面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResMatchmakerPanel lua table类型消息数据
---@param csData marryV2.ResMatchmakerPanel C# class类型消息数据
netMsgPreprocessing[114003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        uimanager:CreatePanel("UIMarryOathPanel", nil, csData)
    end
end
--endregion

--region ID:114005 ResMatchmakerMessage 返回确认的誓言
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResMatchmaker lua table类型消息数据
---@param csData marryV2.ResMatchmaker C# class类型消息数据
netMsgPreprocessing[114005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:114008 ResInterruptMarryMessage 返回中断结婚
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[114008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:ClosePanel('UIMarryOathPanel')
end
--endregion

--region ID:114011 ResDivorceMessage 弹出离婚确认解除
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResDivorce lua table类型消息数据
---@param csData marryV2.ResDivorce C# class类型消息数据
netMsgPreprocessing[114011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and csData.spouse then
        if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MarryInfo == nil then
            return
        end
        local marryInfo = CS.CSScene.MainPlayerInfo.MarryInfo
        local brakeDivorce = function()
            networkRequest.ReqInterruptDivorce()
            if isOpenLog then
                luaDebug.Log("  关闭   ==== 》 UIPromptPanel" .. debug.traceback())
            end
            uimanager:ClosePanel('UIPromptPanel')
        end
        local temp = {}
        temp.IsClose = false
        temp.CancelCallBack = brakeDivorce
        temp.CloseCallBack = brakeDivorce
        temp.TimeEndCallBack = brakeDivorce
        temp.Time = marryInfo.DivorceWaitTime
        temp.CallBack = function(panel)
            networkRequest.ReqImplementDivorce(2)
            if panel then
                --将确定取消隐藏,显示叉号
                panel.GetLeftButton_GameObject():SetActive(false)
                panel.GetRightButton_GameObject():SetActive(false)
                panel.GetCloseButton_GameObject():SetActive(true)
            end
        end
        ---@param countDown UICountdownLabel
        temp.TimeCallBack = function(countDown)
            countDown:StartCountBySecond(nil, 7, marryInfo.DivorceWaitTime / 1000, luaEnumColorType.TimeCountRed, "后操作无效[-]", nil, function()
                countDown.gameObject:SetActive(false)
            end)
        end
        if csData.type == 0 then
            --申请
            local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(34)
            if isFind then
                temp.Content = string.gsub(string.format(info.des, csData.spouse.name), '\\n', '\n')
                temp.LeftDescription = info.leftButton
                temp.RightDescription = info.rightButton
                temp.ID = 34
                uimanager:CreatePanel("UIPromptPanel", nil, temp)
            end
        elseif csData.type == 1 then
            --被申请
            local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(35)
            if isFind then
                temp.Content = string.gsub(string.format(info.des, csData.spouse.name), '\\n', '\n')
                temp.LeftDescription = info.leftButton
                temp.RightDescription = info.rightButton
                temp.ID = 35
                uimanager:CreatePanel("UIPromptPanel", nil, temp)
            end
        end
    end
end
--endregion

--region ID:114012 ResConfirmDivorceMessage 对方超过7天未上线，免费强制离婚确认面板，和收费强制离婚确认面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResConfirmDivorce lua table类型消息数据
---@param csData marryV2.ResConfirmDivorce C# class类型消息数据
netMsgPreprocessing[114012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MarryInfo == nil then
            return
        end
        local marryInfo = CS.CSScene.MainPlayerInfo.MarryInfo
        local temp = {}
        if csData.confirmDivorceType == 0 then
            --免费强制
            local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(37)
            if isFind then
                temp.Content = string.gsub(info.des, '\\n', '\n')
                temp.LeftDescription = info.leftButton
                temp.RightDescription = info.rightButton
                temp.ID = 37
                temp.CallBack = function()
                    networkRequest.ReqImplementDivorce(0)
                end
                uimanager:CreatePanel("UIPromptPanel", nil, temp)
            end
        elseif csData.confirmDivorceType == 1 then
            --收费强制
            temp.IsClose = false
            local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(36)
            if isFind then

                local isFill, type, count, itemID = CS.Cfg_ConditionManager.Instance:IsMatchConditionOfIDAndReturInfo(marryInfo.RemarriageConditionId)
                isFind, __ = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemID)
                if not isFind then
                    return
                end
                temp.Content = string.gsub(info.des, '\\n', '\n')
                temp.CenterDescription = info.leftButton
                temp.IsShowCloseBtn = true
                temp.IsShowGoldLabel = true
                temp.GoldIcon = __.icon
                temp.GoldCount = count
                temp.ID = 36
                temp.CallBack = function(panel)
                    local nowCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(marryInfo.DivorceNeedItemID)
                    --判断收费
                    isFill = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionOfID(marryInfo.RemarriageConditionId)
                    if not isFill then
                        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(125)
                        if isfind and panel then
                            local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemID)
                            local TipsInfo = {}
                            TipsInfo[LuaEnumTipConfigType.Parent] = panel.GetCenterButton_GameObject().transform
                            TipsInfo[LuaEnumTipConfigType.ConfigID] = 125
                            TipsInfo[LuaEnumTipConfigType.Describe] = string.format(data.content, itemName)
                            uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
                        end
                        return
                    end
                    networkRequest.ReqImplementDivorce(1)
                    if isOpenLog then
                        luaDebug.Log("  关闭   ==== 》 UIPromptPanel" .. debug.traceback())
                    end
                    uimanager:ClosePanel('UIPromptPanel')
                end
                uimanager:CreatePanel("UIPromptPanel", nil, temp)
            end
        end
    end
end
--endregion

--region ID:114014 ResOnlineDivorceConditionMessage 在线离婚条件不足消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResOnlineDivorceCondition lua table类型消息数据
---@param csData marryV2.ResOnlineDivorceCondition C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[114014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:114016 ResInterruptDivorceMessage 返回中断离婚
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[114016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if isOpenLog then
        luaDebug.Log("  关闭   ==== 》 UIPromptPanel" .. debug.traceback())
    end
    uimanager:ClosePanel('UIPromptPanel')
end
--endregion

--region ID:114017 ResChangeMarryMessage 结婚改变消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResChangeMarry lua table类型消息数据
---@param csData marryV2.ResChangeMarry C# class类型消息数据
netMsgPreprocessing[114017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MarryInfo == nil then
            return
        end
        if csData.type == 0 then
            uimanager:ClosePanel('UIMarryOathPanel')
            uimanager:ClosePanel('UIReMarryPanel')
            Utility.ShowScreenEffect('700106')
        else
            if isOpenLog then
                luaDebug.Log("  关闭   ==== 》 UIPromptPanel" .. debug.traceback())
            end
            uimanager:ClosePanel('UIPromptPanel')
            --Utility.ShowScreenEffect('700106')
        end
        CS.CSScene.MainPlayerInfo.MarryInfo:SetLoverInfo(csData)
    end
end
--endregion

--region ID:114018 ResGetSpouseMessage 获取当前对象信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResGetSpouse lua table类型消息数据
---@param csData marryV2.ResGetSpouse C# class类型消息数据
netMsgPreprocessing[114018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.MarryInfo == nil then
            return
        end
        CS.CSScene.MainPlayerInfo.MarryInfo:SetLoverInfo(csData)
    end
end
--endregion

--region ID:114020 ReqLackRingsMessage 缺少戒指消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResLackRings lua table类型消息数据
---@param csData marryV2.ResLackRings C# class类型消息数据
netMsgPreprocessing[114020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local name = CS.Cfg_ItemsTableManager.Instance:GetItemName(csData.itemId)
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(38)
        if isFind and name then
            local temp = {}
            temp.CallBack = function()
                networkRequest.ReqConfirmRegretMarriage()
            end
            temp.CancelCallBack = function()
                networkRequest.ReqInterruptRegretMarriage()
            end
            temp.Content = string.gsub(string.format(info.des, name), '\\n', '\n')
            temp.LeftDescription = info.leftButton
            temp.RightDescription = info.rightButton
            temp.ID = 38
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end

end
--endregion

--region ID:114023 ResInterruptRegretMarriageMessage 返回中断悔婚
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[114023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if isOpenLog then
        luaDebug.Log("  关闭   ==== 》 UIPromptPanel" .. debug.traceback())
    end
    uimanager:ClosePanel('UIPromptPanel')
end
--endregion

--region ID:114024 ResPlayerMarriageInformationMessage 查看玩家婚姻信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResPlayerMarriageInformation lua table类型消息数据
---@param csData marryV2.ResPlayerMarriageInformation C# class类型消息数据
netMsgPreprocessing[114024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.MarryInfo:UpdatePlayerMarryInfo(csData)
end
--endregion

--region ID:114025 ResUpdateRingMessage 返回升级婚戒
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResUpdateRing lua table类型消息数据
---@param csData marryV2.ResUpdateRing C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[114025] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:114027 ResSeeOathMessage 返回誓言
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResSeeOath lua table类型消息数据
---@param csData marryV2.ResSeeOath C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[114027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:114030 ResSeeLetteringMessage 返回刻字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResSeeLettering lua table类型消息数据
---@param csData marryV2.ResSeeLettering C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[114030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:114038 ResSeeOthersMarriageInfoMessage 查看其他玩家婚姻信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData marryV2.ResSeeOthersMarriageInfo lua table类型消息数据
---@param csData marryV2.ResSeeOthersMarriageInfo C# class类型消息数据
netMsgPreprocessing[114038] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.OtherPlayerInfo:RefreshOtherMarryMsg(csData)
end
--endregion
