--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--rage.xml

--region ID:130002 ResRageTipMessage 狂暴之力弹窗
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[130002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---生成狂暴之力激活弹窗
    local temp = {}
    temp.ID = 158
    temp.CallBack = function()
        Utility.TryTransfer(1112)
        ---@type UIPromptPanel
        local panel=uimanager:GetPanel("UIPromptPanel")
        if panel~=nil then
            local isopen=panel:GetChooseState_UIToggle().value
            if isopen == true then
                ---狂暴之力弹窗今天不再提示
                networkRequest.ReqChangeRage()
            end
        end
        uimanager:ClosePanel('UIPromptPanel')
    end
    temp.CancelCallBack = function()
        ---@type UIPromptPanel
        local panel=uimanager:GetPanel("UIPromptPanel")
        if panel~=nil then
            local isopen=panel:GetChooseState_UIToggle().value
            if isopen == true then
                ---狂暴之力弹窗今天不再提示
                networkRequest.ReqChangeRage()
            end
        end
        uimanager:ClosePanel('UIPromptPanel')
    end
    temp.CloseCallBack = function()
        ---@type UIPromptPanel
        local panel=uimanager:GetPanel("UIPromptPanel")
        if panel~=nil then
            local isopen=panel:GetChooseState_UIToggle().value
            if isopen == true then
                ---狂暴之力弹窗今天不再提示
                networkRequest.ReqChangeRage()
            end
        end
        uimanager:ClosePanel('UIPromptPanel')
    end

    uimanager:CreatePanel("UIPromptPanel", nil, temp)
end
--endregion

--region ID:130005 ResRageStateMessage 狂暴之力状态响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rageV2.RageState lua table类型消息数据
---@param csData rageV2.RageState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[130005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
