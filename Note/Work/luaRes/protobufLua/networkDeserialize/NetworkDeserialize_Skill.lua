--[[本文件为工具自动生成,禁止手动修改]]
--skill.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回角色技能数据
---msgID: 9002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSkillMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9002 skillV2.ResSkill 返回角色技能数据")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ResSkill", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustResSkill ~= nil then
        protoAdjust.skill_adj.AdjustResSkill(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回单个技能变化数据
---msgID: 9005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOneSkillChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9005 skillV2.ResOneSkillChange 返回单个技能变化数据")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ResOneSkillChange", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustResOneSkillChange ~= nil then
        protoAdjust.skill_adj.AdjustResOneSkillChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回多个技能变化数据
---msgID: 9006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMultiSkillChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9006 skillV2.ResMultiSkillChange 返回多个技能变化数据")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ResMultiSkillChange", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustResMultiSkillChange ~= nil then
        protoAdjust.skill_adj.AdjustResMultiSkillChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9006
    protobufMgr.mMsgDeserializedTblCache = res
end

---使用技能书
---msgID: 9007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSkillBookUseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9007 skillV2.SkillBean 使用技能书")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.SkillBean", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustSkillBean ~= nil then
        protoAdjust.skill_adj.AdjustSkillBean(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9007
    protobufMgr.mMsgDeserializedTblCache = res
end

---秘技面板
---msgID: 9010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSecretSkillInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9010 skillV2.SecretSkillInfo 秘技面板")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.SecretSkillInfo", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustSecretSkillInfo ~= nil then
        protoAdjust.skill_adj.AdjustSecretSkillInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9010
    protobufMgr.mMsgDeserializedTblCache = res
end

---上下阵心法回调
---msgID: 9015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSecretBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9015 skillV2.ResSecretBack 上下阵心法回调")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ResSecretBack", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustResSecretBack ~= nil then
        protoAdjust.skill_adj.AdjustResSecretBack(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9015
    protobufMgr.mMsgDeserializedTblCache = res
end

---切换心阵
---msgID: 9016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSwitchFormationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9016 skillV2.ReqSwitchFormation 切换心阵")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ReqSwitchFormation", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustReqSwitchFormation ~= nil then
        protoAdjust.skill_adj.AdjustReqSwitchFormation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9016
    protobufMgr.mMsgDeserializedTblCache = res
end

---xp 能量改变
---msgID: 9017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResXpSkillEnergyChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9017 skillV2.ResXpSkillEnergyChange xp 能量改变")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.ResXpSkillEnergyChange", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustResXpSkillEnergyChange ~= nil then
        protoAdjust.skill_adj.AdjustResXpSkillEnergyChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9017
    protobufMgr.mMsgDeserializedTblCache = res
end

---全部的装备专精信息
---msgID: 9019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllEquipProficientInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9019 skillV2.AllEquipProficientInfo 全部的装备专精信息")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.AllEquipProficientInfo", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustAllEquipProficientInfo ~= nil then
        protoAdjust.skill_adj.AdjustAllEquipProficientInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9019
    protobufMgr.mMsgDeserializedTblCache = res
end

---单个装备专精信息
---msgID: 9020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEquipProficientInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 9020 skillV2.EquipProficientInfo 单个装备专精信息")
        return nil
    end
    local res = protobufMgr.Deserialize("skillV2.EquipProficientInfo", buffer)
    if protoAdjust.skill_adj ~= nil and protoAdjust.skill_adj.AdjustEquipProficientInfo ~= nil then
        protoAdjust.skill_adj.AdjustEquipProficientInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 9020
    protobufMgr.mMsgDeserializedTblCache = res
end

