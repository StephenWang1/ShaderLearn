--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--fight.xml

--region ID:69009 ResInnerChangeMessage 内功发生变化（用于单独的通知内功，内功回复）
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fightV2.ResInnerChange lua table类型消息数据
---@param csData fightV2.ResInnerChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[69009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --if csData then
    --    if CS.CSScene.Sington ~= nil then
    --        local role = CS.CSScene.Sington:getAvatar(csData.lid)
    --        if role ~= nil then
    --            local baseInfo = role.BaseInfo
    --            if baseInfo ~= nil then
    --                baseInfo.InnerPower = csData.inner
    --            end
    --        end
    --    end
    --end
end
--endregion

--region ID:69015 ResLampCoreSeckillMessage 返回秒杀提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fightV2.ResLampCoreSeckill lua table类型消息数据
---@param csData fightV2.ResLampCoreSeckill C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[69015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local avatar = CS.CSScene.Sington:getAvatar(tblData.id)
        if avatar and avatar.Head then
            local showStr = 'm-' .. tostring(tblData.hp)
            avatar.Head:PlayText(showStr, CS.ThrowTextType.SpikeHurt)
        end
    end
end
--endregion

--[[
--region ID:69002 ResFightResultMessage 返回攻击
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fightV2.ResFightResult lua table类型消息数据
---@param csData fightV2.ResFightResult C# class类型消息数据
netMsgPreprocessing[69002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:69004 ResHpMpChangeMessage 血量蓝量发生变化（用于单独的通知血量，比如说buffer伤害等等）
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fightV2.ResHpMpChange lua table类型消息数据
---@param csData fightV2.ResHpMpChange C# class类型消息数据
netMsgPreprocessing[69004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
