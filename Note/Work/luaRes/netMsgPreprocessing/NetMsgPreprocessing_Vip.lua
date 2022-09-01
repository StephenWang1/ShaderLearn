--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--vip.xml

--region ID:28005 ResRoleVipInfoChangeMessage 通知玩家vip等级发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResRoleVipInfoChange lua table类型消息数据
---@param csData vipV2.ResRoleVipInfoChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.VipLevel = tblData.curLevel
    gameMgr:GetPlayerDataMgr():GetPlayerVipInfo():ChangePlayerVipData(tblData)
end
--endregion

--region ID:28006 ResRoleVipInfoMessage vip数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResRoleVipInfo lua table类型消息数据
---@param csData vipV2.ResRoleVipInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.VipLevel = tblData.level
    gameMgr:GetPlayerDataMgr():GetPlayerVipInfo():SetPlayerVipData(tblData)
end
--endregion

--region ID:28007 ResBuyVipRewardMessage vip领过的数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResBuyVipReward lua table类型消息数据
---@param csData vipV2.ResBuyVipReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:28008 ResFreeVipRewardMessage vip领过的数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResFreeVipReward lua table类型消息数据
---@param csData vipV2.ResFreeVipReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:28012 ResMonthCardPanelMessage 返回商会界面
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResCardPanel lua table类型消息数据
---@param csData vipV2.ResCardPanel C# class类型消息数据
netMsgPreprocessing[28012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.MonthCardInfo:UpdateCardPanelInfo(csData)
end
--endregion

--region ID:28013 ResMonthCardInfoMessage 返回月卡信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResCardInfo lua table类型消息数据
---@param csData vipV2.ResCardInfo C# class类型消息数据
netMsgPreprocessing[28013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSServerTime.IsInitServerTime == false then
        uiStaticParameter.monthCardInfo = csData
    else
        CS.CSScene.MainPlayerInfo.MonthCardInfo:UpdateMonthCardInfo(csData)
    end
end
--endregion

--region ID:28015 ResMonthCardChangeMessage 返回月卡改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResCardChange lua table类型消息数据
---@param csData vipV2.ResCardChange C# class类型消息数据
netMsgPreprocessing[28015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.MonthCardInfo:UpdateCardChange(csData)
    uiStaticParameter.startActive = tblData.isActive == 1
end
--endregion

--region ID:28017 ResCardDayRewardInfoMessage 返回月卡福利详情
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResCardDayRewardInfo lua table类型消息数据
---@param csData vipV2.ResCardDayRewardInfo C# class类型消息数据
netMsgPreprocessing[28017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.MonthCardInfo:UpdateDayReward(csData);
end
--endregion

--region ID:28018 ResUseMonthCardItemMessage 返回使用月卡道具
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[28018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:CreatePanel("UICommercePanel");
end
--endregion

--region ID:28019 ResRoleVip2InfoChangeMessage 通知玩家vip2等级发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResRoleVip2InfoChange lua table类型消息数据
---@param csData vipV2.ResRoleVip2InfoChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():ChangePlayerVip2Data(tblData)
end
--endregion

--region ID:28020 ResRoleVip2InfoMessage vip2数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.ResRoleVip2Info lua table类型消息数据
---@param csData vipV2.ResRoleVip2Info C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():SetPlayerVip2Data(tblData)
end
--endregion

--region ID:28022 ResVipMemberInfoMessage 返回超级会员数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData vipV2.VipMemberInfo lua table类型消息数据
---@param csData vipV2.VipMemberInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[28022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():SetPlayerMemberInfo(tblData)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.MemberPanelRewardRedPoint)
end
--endregion
