--[[本文件为工具自动生成,禁止手动修改]]
--appearance.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回修改称谓
---msgID: 121009
---@param msgID LuaEnumNetDef 消息ID
---@return appearanceV2.ResModifyTitle C#数据结构
function networkRespond.OnResModifyTitleMessageReceived(msgID)
    ---@type appearanceV2.ResModifyTitle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 121009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 121009 appearanceV2.ResModifyTitle 返回修改称谓")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.appearance ~= nil and  protobufMgr.DecodeTable.appearance.ResModifyTitle ~= nil then
        csData = protobufMgr.DecodeTable.appearance.ResModifyTitle(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回所有称谓
---msgID: 121010
---@param msgID LuaEnumNetDef 消息ID
---@return appearanceV2.ResGetHasAppellation C#数据结构
function networkRespond.OnResGetHasAppellationMessageReceived(msgID)
    ---@type appearanceV2.ResGetHasAppellation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 121010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 121010 appearanceV2.ResGetHasAppellation 返回所有称谓")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.appearance ~= nil and  protobufMgr.DecodeTable.appearance.ResGetHasAppellation ~= nil then
        csData = protobufMgr.DecodeTable.appearance.ResGetHasAppellation(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回正在使用称谓
---msgID: 121011
---@param msgID LuaEnumNetDef 消息ID
---@return appearanceV2.ResEnableAppellation C#数据结构
function networkRespond.OnResEnableAppellationMessageReceived(msgID)
    ---@type appearanceV2.ResEnableAppellation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 121011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 121011 appearanceV2.ResEnableAppellation 返回正在使用称谓")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.appearance ~= nil and  protobufMgr.DecodeTable.appearance.ResEnableAppellation ~= nil then
        csData = protobufMgr.DecodeTable.appearance.ResEnableAppellation(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---外观红点
---msgID: 121012
---@param msgID LuaEnumNetDef 消息ID
---@return appearanceV2.ResAppearanceRedPoint C#数据结构
function networkRespond.OnResAppearanceRedPointMessageReceived(msgID)
    ---@type appearanceV2.ResAppearanceRedPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 121012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 121012 appearanceV2.ResAppearanceRedPoint 外观红点")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAppearanceRedPointMessage", 121012, "ResAppearanceRedPoint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

