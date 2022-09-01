local KuaFuStartHint = {}

--region 数据
--region 联服开始倒计时
---@param LianFuStartTime number 联服开始时间
KuaFuStartHint.LianFuStartTime = 0
---@param LianFuStartNoticeInfo table 当前提示的联服开始提示信息
KuaFuStartHint.LianFuStartNoticeInfo = nil
---@param RegisterHintTable table 注册提示表
KuaFuStartHint.RegisterHintTable = {}
--endregion

--region 数据清理
function KuaFuStartHint:ClearParams()
    self.LianFuStartTime = 0
    self.LianFuStartNoticeInfo = nil
    self.RegisterHintTable = {}
end

---清理所有以注册的时间
function KuaFuStartHint:RemoveAllTimeRespone()
    if self.RegisterHintTable ~= nil and type(self.RegisterHintTable) == 'table' and Utility.GetTableCount(self.RegisterHintTable) > 0 then
        for k,v in pairs(self.RegisterHintTable) do
            luaclass.LuaTimeMgr:RemoveTimeRespone(v)
        end
    end
end
--endregion
--endregion

--region 联服开始提示注册
---开启联服倒计时监测
---@param endTime number 联服开启时间
function KuaFuStartHint:StartLianFuCountDown(endTime)
    self:RemoveAllTimeRespone()
    self:ClearParams()
    self.LianFuStartTime = endTime
    --剩余时间判定
    local remainTime = self:GetLianFuStartRemainTime()
    if remainTime <= 0 then
        return
    end
    --配置提示数据
    local totalSecond = Utility.GetIntPart(remainTime * 0.001)
    local configHintTable = LuaGlobalTableDeal:GetLianFuStartNoticeTableByEndTime(self.LianFuStartTime)
    if configHintTable == nil or type(configHintTable) ~= 'table' or Utility.GetTableCount(configHintTable) <= 0 then
        return
    end
    --注册所有提示
    for k,v in pairs(configHintTable)do
        if v ~= nil then
            local hintEndTime = self.LianFuStartTime - v.remainNoticeTime * 1000
            local remainTime = hintEndTime - CS.CSScene.MainPlayerInfo.serverTime
            if remainTime > 0 then
                local hintId = LuaRegisterTimeFinishEvent.KuaFuStartCountDown * 1000 + v.type
                table.insert(self.RegisterHintTable,hintId)
                luaclass.LuaTimeMgr:RegisterTimeRespone(hintId,hintEndTime,function(configHintTable)
                    if clientTableManager.cfg_mapManager:IsOpenKuaFuMap(CS.CSScene.MainPlayerInfo.MapID) then
                        self:CheckLianFuStart(configHintTable)
                    end
                    luaclass.LuaTimeMgr:RemoveTimeRespone(LuaRegisterTimeFinishEvent.KuaFuStartCountDown * 1000 + configHintTable.type)
                end,v)
            end
        end
    end
end
--endregionw

--region 联服开启预告
---检测联服开始
function KuaFuStartHint:CheckLianFuStart(configHintTable)
    ---开始时间
    if self.LianFuStartTime == nil then
        return
    end
    ---开启跨服剩余时间
    local remainTime = self:GetLianFuStartRemainTime()
    if remainTime <= 0 then
        self:ClearParams()
        return
    end
    ---总剩余时间（秒）
    local totalSecond = Utility.GetIntPart(remainTime * 0.001)
    ---关闭上一个提示内容
    if self.LianFuStartNoticeInfo ~= nil then
        self:CloseLastNotice()
    end
    self.LianFuStartNoticeInfo = configHintTable
    if self.LianFuStartNoticeInfo.noticeType == luaEnumLianFuStartNoticeType.SecondConfirm then
        self:CreatLianFuCountDownSecondConfirm(totalSecond)
    elseif self.LianFuStartNoticeInfo.noticeType == luaEnumLianFuStartNoticeType.HeadCountDown then
        self:ShowLianFuCountDown(self.LianFuStartTime)
    end
end

--region 联服头顶倒计时
---连服头顶倒计时显示
---@param endTime number 结束时间
function KuaFuStartHint:ShowLianFuCountDown(endTime)
    local timeCountData = CS.AvatarBaseTimeCountData()
    timeCountData.avaterId = CS.CSScene.MainPlayerInfo.ID
    timeCountData.endTimeStamp = endTime
    timeCountData.startCountTimeDesc = "联服开启倒计时："
    timeCountData.timeFormat = CS.UICountdownLabel.CountDownFormat.Special4
    timeCountData.strColor = CS.UnityEngine.Color.yellow
    timeCountData.offsetVector = CS.UnityEngine.Vector2.up * 115
    timeCountData.timeEndCallBack = function()
        self:ClearLianFuCountDown()
    end
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_AddHeadSign, CS.UIHeadControllerBase.EHeadGoType.AvaterBaseTimeCount, timeCountData)
end

---清空气泡
function KuaFuStartHint:ClearLianFuCountDown()
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_RemoveHeadSigh, CS.UIHeadControllerBase.EHeadGoType.AvaterBaseTimeCount,CS.CSScene.MainPlayerInfo.ID)
end

---创建联服倒计时二次确认面板
---@param endTime number 结束时间(秒)
function KuaFuStartHint:CreatLianFuCountDownSecondConfirm(endTime)
    local minuteTime = Utility.GetMaxIntPart(endTime / 60)
    Utility.ShowSecondConfirmPanel({PromptWordId = self.LianFuStartNoticeInfo.params[1],placeHolderData = tostring(minuteTime)})
end

---关闭二次确认
function KuaFuStartHint:CloseSecondConfirm()
    uimanager:ClosePanel("UIPromptPanel")
end

---关闭上一个记录的提示
function KuaFuStartHint:CloseLastNotice()
    if self.LianFuStartNoticeInfo ~= nil then
        if self.LianFuStartNoticeInfo.noticeType == luaEnumLianFuStartNoticeType.SecondConfirm then
            self:CloseSecondConfirm()
        elseif self.LianFuStartNoticeInfo.noticeType == luaEnumLianFuStartNoticeType.HeadCountDown then
            self:ClearLianFuCountDown()
        end
        self.LianFuStartNoticeInfo = nil
    end
end
--endregion
--endregion

--region 获取
---获取连服剩余开始时间
---@return number 连服开始剩余时间
function KuaFuStartHint:GetLianFuStartRemainTime()
    if self.LianFuStartTime == nil or type(self.LianFuStartTime) ~= 'number' or CS.CSScene.MainPlayerInfo == nil then
        return 0
    end
    return self.LianFuStartTime - CS.CSScene.MainPlayerInfo.serverTime
end
--endregion
--endregion

---游戏场景退回到登录/选角界面时触发
function KuaFuStartHint:OnExitDestroy()
    self:RemoveAllTimeRespone()
    self:ClearParams()
end

return KuaFuStartHint