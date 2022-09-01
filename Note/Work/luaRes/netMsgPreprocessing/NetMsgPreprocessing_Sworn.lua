--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--sworn.xml

--region ID:113002 ResHasSwornMessage 有结拜进行时返回正在结拜
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResHasSworn lua table类型消息数据
---@param csData swornV2.ResHasSworn C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[113002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:113003 ResSpecialEffectsMessage 特效开始消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResSpecialEffects lua table类型消息数据
---@param csData swornV2.ResSpecialEffects C# class类型消息数据
netMsgPreprocessing[113003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:113004 ResYourBrotherMessage 返回兄弟信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResYourBrother lua table类型消息数据
---@param csData swornV2.ResYourBrother C# class类型消息数据
netMsgPreprocessing[113004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ClearBrotherDic()
    local length = csData.brothers.Count - 1
    for i = 0, length do
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddBrotherDic(csData.brothers[i])
    end
end
--endregion

--region ID:113005 SendSwornInfoMessage 向队员发送结拜面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.SendSwornInfo lua table类型消息数据
---@param csData swornV2.SendSwornInfo C# class类型消息数据
netMsgPreprocessing[113005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2.LeaderID = csData.leaderId
    CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornRemainTime = csData.longTime
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ClearSwornDic()
    local length = csData.swornInfo.Count - 1
    for i = 0, length do
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddSwornDic(csData.swornInfo[i])
    end
    local panel = uimanager:GetPanel('UIBrothersSwornPanel')
    if panel then
        panel.StartRefreshTime()
    else
        uimanager:CreatePanel("UIBrothersSwornPanel")
    end
end
--endregion

--region ID:113007 ResAgreeSwornMessage 返回改变同意结义消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResAgreeSworn lua table类型消息数据
---@param csData swornV2.ResAgreeSworn C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[113007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:113009 ResInterruptSwornMessage 中断结义
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResInterruptSworn lua table类型消息数据
---@param csData swornV2.ResInterruptSworn C# class类型消息数据
netMsgPreprocessing[113009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2.LeaderID = 0
    CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornRemainTime = 0
    --CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornList:Clear()
end
--endregion

--region ID:113010 ResSwornSuccessMessage 结义是否成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResSwornSuccess lua table类型消息数据
---@param csData swornV2.ResSwornSuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[113010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:113015 ResAddBrotherMessage 成功结义后返回新添加的兄弟信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResAddBrother lua table类型消息数据
---@param csData swornV2.ResAddBrother C# class类型消息数据
netMsgPreprocessing[113015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2.SwornRemainTime = 0
    local length = csData.addBrothers.Count - 1
    for i = 0, length do
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddBrotherDic(csData.addBrothers[i])
    end
end
--endregion

--region ID:113016 ResRemoveBrotherMessage 移除的兄弟信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResRemoveBrother lua table类型消息数据
---@param csData swornV2.ResRemoveBrother C# class类型消息数据
netMsgPreprocessing[113016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2:RemoveBrotherDic(csData.removeBrothers)
end
--endregion

--region ID:113017 ResOneBrotherMessage 更新单个兄弟信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResOneBrother lua table类型消息数据
---@param csData swornV2.ResOneBrother C# class类型消息数据
netMsgPreprocessing[113017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ChangeBrotherDic(csData.theBrothers)
end
--endregion

--region ID:113019 ResBreakOffRelationsMessage 返回断义列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData swornV2.ResBreakOffRelations lua table类型消息数据
---@param csData swornV2.ResBreakOffRelations C# class类型消息数据
netMsgPreprocessing[113019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.FriendInfoV2:ChangeAssertionDic(csData)
end
--endregion
