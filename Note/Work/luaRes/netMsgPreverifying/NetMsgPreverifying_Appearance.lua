--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--appearance.xml

--region ID:121005 ReqEnableFashionMessage 请求起用这件时装
---@param msgID LuaEnumNetDef 消息ID
---@param csData appearanceV2.ReqEnableFashion lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[121005] = function(msgID, csData)
    --在此处填入预校验代码
    --对请求使用的时装的使用条件作校验
    ---@type TABLE.CFG_ITEMS
    local isTblExist, itemTbl
    isTblExist, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(csData.itemId)
    if isTblExist and itemTbl.appearanceId ~= 0 then
        local appearanceTbl
        isTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(itemTbl.appearanceId)
        if isTblExist then
            if appearanceTbl.condition > 0 then
                return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(appearanceTbl.condition)
            end
            return true
        end
    end
    return false
end
--endregion
