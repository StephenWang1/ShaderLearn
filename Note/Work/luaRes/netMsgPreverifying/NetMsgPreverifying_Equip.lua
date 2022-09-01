--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--equip.xml

--region ID:13006 ReqPutOnTheEquipMessage 请求穿装备
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqPutOnTheEquip lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13006] = function(msgID, csData)
    --在此处填入预校验代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local res, bagItem = mainPlayerInfo.BagInfo.BagItems:TryGetValue(csData.equipId)
        if res then
            gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckServantNeedPushTransferItem(bagItem, csData.index)
        end
        return true
    end
end
--endregion

--region ID:13025 ReqPutOnSoulEquipMessage 请求镶嵌魂装
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqPutOnSoulEquip lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13025] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:13026 ReqPutOffSoulEquipMessage 请求卸下镶嵌魂装
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqPutOffSoulEquip lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13026] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:13028 ReqGetAllSoulInfoMessage 请求魂装镶嵌数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[13028] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:13032 ReqAppraisaEquipMessage 请求鉴定装备
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqAppraisaEquip lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13032] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:13036 ReqRecastMessage 配饰重铸
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqRecast lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13036] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:13039 ReqGrowthEquipMessage 成长兵鉴升级或突破
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.ReqGrowthEquip lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13039] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:13027 ResAllSoulEquipInfoMessage 返回魂装镶嵌数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData equipV2.AllSoulEquipInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[13027] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
