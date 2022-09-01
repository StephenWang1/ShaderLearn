--[[本文件为工具自动生成,禁止手动修改]]
--skill.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回角色技能数据
---msgID: 9002
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ResSkill C#数据结构
function networkRespond.OnResSkillMessageReceived(msgID)
    ---@type skillV2.ResSkill
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9002 skillV2.ResSkill 返回角色技能数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSkillMessage", 9002, "ResSkill", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.skill ~= nil and  protobufMgr.DecodeTable.skill.ResSkill ~= nil then
        csData = protobufMgr.DecodeTable.skill.ResSkill(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回单个技能变化数据
---msgID: 9005
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ResOneSkillChange C#数据结构
function networkRespond.OnResOneSkillChangeMessageReceived(msgID)
    ---@type skillV2.ResOneSkillChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9005 skillV2.ResOneSkillChange 返回单个技能变化数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.skill ~= nil and  protobufMgr.DecodeTable.skill.ResOneSkillChange ~= nil then
        csData = protobufMgr.DecodeTable.skill.ResOneSkillChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回多个技能变化数据
---msgID: 9006
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ResMultiSkillChange C#数据结构
function networkRespond.OnResMultiSkillChangeMessageReceived(msgID)
    ---@type skillV2.ResMultiSkillChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9006 skillV2.ResMultiSkillChange 返回多个技能变化数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMultiSkillChangeMessage", 9006, "ResMultiSkillChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---使用技能书
---msgID: 9007
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.SkillBean C#数据结构
function networkRespond.OnResSkillBookUseMessageReceived(msgID)
    ---@type skillV2.SkillBean
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9007 skillV2.SkillBean 使用技能书")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.skill ~= nil and  protobufMgr.DecodeTable.skill.SkillBean ~= nil then
        csData = protobufMgr.DecodeTable.skill.SkillBean(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---秘技面板
---msgID: 9010
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.SecretSkillInfo C#数据结构
function networkRespond.OnResSecretSkillInfoMessageReceived(msgID)
    ---@type skillV2.SecretSkillInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9010 skillV2.SecretSkillInfo 秘技面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.skill ~= nil and  protobufMgr.DecodeTable.skill.SecretSkillInfo ~= nil then
        csData = protobufMgr.DecodeTable.skill.SecretSkillInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---上下阵心法回调
---msgID: 9015
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ResSecretBack C#数据结构
function networkRespond.OnResSecretBackMessageReceived(msgID)
    ---@type skillV2.ResSecretBack
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9015 skillV2.ResSecretBack 上下阵心法回调")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.skill ~= nil and  protobufMgr.DecodeTable.skill.ResSecretBack ~= nil then
        csData = protobufMgr.DecodeTable.skill.ResSecretBack(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---切换心阵
---msgID: 9016
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ReqSwitchFormation C#数据结构
function networkRespond.OnResSwitchFormationMessageReceived(msgID)
    ---@type skillV2.ReqSwitchFormation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9016 skillV2.ReqSwitchFormation 切换心阵")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSwitchFormationMessage", 9016, "ReqSwitchFormation", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---xp 能量改变
---msgID: 9017
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.ResXpSkillEnergyChange C#数据结构
function networkRespond.OnResXpSkillEnergyChangeMessageReceived(msgID)
    ---@type skillV2.ResXpSkillEnergyChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9017 skillV2.ResXpSkillEnergyChange xp 能量改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResXpSkillEnergyChangeMessage", 9017, "ResXpSkillEnergyChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---全部的装备专精信息
---msgID: 9019
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.AllEquipProficientInfo C#数据结构
function networkRespond.OnResAllEquipProficientInfoMessageReceived(msgID)
    ---@type skillV2.AllEquipProficientInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9019 skillV2.AllEquipProficientInfo 全部的装备专精信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllEquipProficientInfoMessage", 9019, "AllEquipProficientInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---单个装备专精信息
---msgID: 9020
---@param msgID LuaEnumNetDef 消息ID
---@return skillV2.EquipProficientInfo C#数据结构
function networkRespond.OnResEquipProficientInfoMessageReceived(msgID)
    ---@type skillV2.EquipProficientInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 9020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 9020 skillV2.EquipProficientInfo 单个装备专精信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResEquipProficientInfoMessage", 9020, "EquipProficientInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

