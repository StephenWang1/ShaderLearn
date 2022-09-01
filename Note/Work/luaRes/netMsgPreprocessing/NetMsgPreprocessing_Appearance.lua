--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--appearance.xml

--region ID:121009 ResModifyTitleMessage 返回修改称谓
---@param msgID LuaEnumNetDef 消息ID
---@param tblData appearanceV2.ResModifyTitle lua table类型消息数据
---@param csData appearanceV2.ResModifyTitle C# class类型消息数据
netMsgPreprocessing[121009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local info = CS.CSScene.GetAvatarInfo(csData.rid)
        if info and info.Appearance and info.Appearance.AppearanceData then
            info.Appearance.AppearanceData:SetCurAppellationInfo(csData)
        end
    end
end
--endregion

--region ID:121010 ResGetHasAppellationMessage 返回所有称谓
---@param msgID LuaEnumNetDef 消息ID
---@param tblData appearanceV2.ResGetHasAppellation lua table类型消息数据
---@param csData appearanceV2.ResGetHasAppellation C# class类型消息数据
netMsgPreprocessing[121010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Appearance ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil then
            CS.CSScene.MainPlayerInfo.Appearance.AppearanceData:RefreshAppellationList(csData)
        end
    end
end
--endregion

--region ID:121011 ResEnableAppellationMessage 返回正在使用称谓
---@param msgID LuaEnumNetDef 消息ID
---@param tblData appearanceV2.ResEnableAppellation lua table类型消息数据
---@param csData appearanceV2.ResEnableAppellation C# class类型消息数据
netMsgPreprocessing[121011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Appearance ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil then
            CS.CSScene.MainPlayerInfo.Appearance.AppearanceData:SetCurAppellationInfo(csData)
        end
    end
end
--endregion

--region ID:121012 ResAppearanceRedPointMessage 外观红点
---@param msgID LuaEnumNetDef 消息ID
---@param tblData appearanceV2.ResAppearanceRedPoint lua table类型消息数据
---@param csData appearanceV2.ResAppearanceRedPoint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[121012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetAppearanceInfo():AddAppearanceRedPoint(tblData)
    end
    ---使用外观时触发一次合成红点计算
    gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint(nil, nil, true)
end
--endregion
