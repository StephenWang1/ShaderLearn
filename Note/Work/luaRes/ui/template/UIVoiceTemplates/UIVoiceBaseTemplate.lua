---@class UIVoiceBaseTemplate:TemplateBase 语言模板
local UIVoiceBaseTemplate = {}

--setmetatable(UIVoiceBaseTemplate,luaComponentTemplates.UIVoice_Mgr)
UIVoiceBaseTemplate.receiveVoice = false
--region BaseMethods
---@param ownerPanel UIBase
function UIVoiceBaseTemplate:Init(panel, ownerPanel)
    self.panel = panel
    self.mOwnerPanel = ownerPanel
    self:InitParams()
    if uiStaticParameter.voiceMgr then
        self:ChangeRecordState(uiStaticParameter.voiceMgr.recordState, uiStaticParameter.voiceMgr.recordSource)
    end
end

function UIVoiceBaseTemplate:OnEnable()
    self:BindEvent()
end

function UIVoiceBaseTemplate:OnDisable()
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_RecordComplete, self.recordComplete)
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.RecordStateChange, self. recordStateChangeFunc)
    end
end

---获取面板的客户端消息Handler
---@return EventHandlerManager
function UIVoiceBaseTemplate:GetClientEventHandler()
    if self == nil then
        return
    end
    if self.mClient == nil then
        self.mClient = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)--客户端事件
    end
    return self.mClient
end
--endregion

--region Init
function UIVoiceBaseTemplate:InitParams()
    self.recordState = LuaEnumRecordState.Null
    self.btn_voice = self:Get("btn_voice", "GameObject")
    self.voicestate = self:Get("panel/voicestate", "GameObject")
    self.voicestateReturn = self:Get("panel/voicestate/Return", "GameObject")
    self.voiceLoading_GameObject = self:Get("panel/voicestate/voice", "GameObject")
    self.voiceLoading = self:Get("panel/voicestate/voice/Start", "TweenFillAmount")
    self.voiceLabel = self:Get("panel/voicestate/Label", "UILabel")

    self.btn_Mic = self:Get("btn_Mic", "UISprite")
    self.btn_Speaker_now = self:Get("btn_Speaker_now", "GameObject")
    self.btn_Speaker = self:Get("btn_Speaker", "UISprite")
    self.btn_realtimevoice = self:Get("btn_realtimevoice", "GameObject")
    self.usetime = 0
    local cameras = CS.UnityEngine.Camera.allCameras
    for i = 0, cameras.Length - 1 do
        if cameras[i].gameObject.layer == 5 then
            self.uiCamera = cameras[i]
        end
    end
    self.timerCoroutine = nil
end

function UIVoiceBaseTemplate:BindEvent()
    CS.UIEventListener.Get(self.btn_voice).onPress = function(go, state)
        if (self.panel ~= nil) then
            if uiStaticParameter.UIChatPanel_SelectIndex == 3 then
                self.panel:ShowTips(self.btn_voice, 315)
                return
            elseif uiStaticParameter.UIChatPanel_SelectIndex == 5 then
                if (self.panel == uimanager:GetPanel("UIChatPanel") and self.panel.mSelectPrivateFriend == nil) then
                    self.panel:ShowTips(self.btn_voice, 318)
                    return
                end
            end
            if (self.panel:ChatLimit(self.btn_voice) == false) then
                return
            end
        end

        if self.recordIsOpen == false then
            if state == true then
                if self.recordSource == LuaEnumControlRecordStateSource.BuDouKai then
                    CS.Utility.ShowTips("参赛选手不可发言")
                end
            end
            return
        end
        self:onPress(go, state)
    end
    CS.UIEventListener.Get(self.btn_voice).onDrag = function(go)
        if self.recordIsOpen == false then
            return
        end
        self:Drag(go)
    end
    ---麦克风点击
    if (self.btn_Mic ~= nil) then
        CS.UIEventListener.Get(self.btn_Mic.gameObject).onClick = function(go)
            self:MicBtnClick(go)
        end
    end
    ---麦克风说话点击
    if (self.btn_Speaker_now ~= nil) then
        CS.UIEventListener.Get(self.btn_Speaker_now.gameObject).onClick = function(go)
            self:MicBtnTalkClick(go)
        end
    end
    ---扬声器点击
    if (self.btn_Speaker ~= nil) then
        CS.UIEventListener.Get(self.btn_Speaker.gameObject).onClick = function(go)
            self:SpeakerBtnClick(go)
        end
    end

    if (self.btn_realtimevoice ~= nil) then
        CS.UIEventListener.Get(self.btn_realtimevoice).onPress = function(go, state)
            self:SendVoiceBtnOnPress(go, state)
        end
    end

    self.recordComplete = function(msgId, url, time)
        self:RecordIsComplete(url, time)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RecordComplete, self.recordComplete)
    self.recordStateChangeFunc = function(eventId, state, source)
        self:ChangeRecordState(state, source)
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RecordStateChange, self.recordStateChangeFunc)
    end
end
--endregion

--region 切换语音类型
function UIVoiceBaseTemplate:SwitchVoice(voiceType)
    if voiceType == LuaEnumVoiceType.VoiceMessage then
        self:OpenVoiceMessage()
    elseif voiceType == LuaEnumVoiceType.RealTimeVoice then
        -- self:OpenRealTimeVoice(false)
    end
    uiStaticParameter.voiceMgr:SwitchSendVoice(false)
end

---设置私聊rolelid
function UIVoiceBaseTemplate:SetPrivateRoleId(privateRoleId, privateRoleName)
    self.privateRoleId = privateRoleId
    self.privateRoleName = privateRoleName
end

---切换语音消息类型
function UIVoiceBaseTemplate:SwitchVoiceType(type)
    if type == nil then
        self.voiceMessageType = LuaEnumVoiceMessageType.COMMON
        return
    end
    self.voiceMessageType = type
end

---开启语音消息
function UIVoiceBaseTemplate:OpenVoiceMessage()
    --CS.UnityEngine.Debug.LogError("开启语音消息")
    -- self.btn_voice:SetActive(true)
    -- if self.btn_listen ~= nil and self.btn_realtimevoice ~= nil then
    --     self.btn_listen.gameObject:SetActive(false)
    --     self.btn_realtimevoice:SetActive(false)
    -- end
    -- uiStaticParameter.voiceMgr:SwitchReceiveVoice(false)
end

-- ---开启实时语音
-- function UIVoiceBaseTemplate:OpenRealTimeVoice(openReceive)
--     --CS.UnityEngine.Debug.LogError("开启实时语音")
--     self.btn_voice:SetActive(false)
--     if (self.btn_listen ~= nil) then
--         self.btn_listen.gameObject:SetActive(true)
--     end
--     if (self.btn_realtimevoice ~= nil) then
--         self.btn_realtimevoice:SetActive(true)
--     end
--     if openReceive then
--         if self.btn_listen ~= nil then
--             self.btn_listen.spriteName = "btn_on"
--         end
--         self.receiveVoice = true
--     else
--         if self.btn_listen ~= nil then
--             self.btn_listen.spriteName = "btn_off"
--         end
--         self.receiveVoice = false
--     end
--     uiStaticParameter.voiceMgr:Logout()
--     uiStaticParameter.voiceMgr:SwitchReceiveVoice(self.receiveVoice)
-- end
function UIVoiceBaseTemplate:RefreshRealTimeVoiceBtnActive()
    -- local isshow = CS.SDKManager.VoiceSDKInterface.IsOpenRealTimeVoice;
    -- self.btn_Mic.gameObject:SetActive(isshow)
    -- if isshow == false then
    --     self.btn_Speaker_now.gameObject:SetActive(isshow)
    -- end

    -- self.btn_Speaker.gameObject:SetActive(isshow)


    -- if  CS.CSScene.MainPlayerInfo.UnionInfoV2.IsHvaVoicePermission == true then
    --     if CS.CSScene.MainPlayerInfo.UnionInfoV2.IsOpenVoice == true  then
    --         self.btn_Mic.spriteName = "Speak_Guild1"
    --     else
    --         self.btn_Mic.spriteName = "Speak_Guild2"
    --     end
    -- else
    --     self.btn_Mic.spriteName = "Speak_Guild3"
    -- end

    -- if CS.CSScene.MainPlayerInfo.UnionInfoV2.IsOpenLister  then
    --     self.btn_Speaker.spriteName = "Lister_Guild1"
    -- else
    --     self.btn_Speaker.spriteName = "Lister_Guild2"
    -- end
end



--endregion

--region 语音消息功能
--region 播放状态
UIVoiceBaseTemplate.IsAllowUseVoice = false
UIVoiceBaseTemplate.onPressTime = 0
function UIVoiceBaseTemplate:onPress(go, state)
    if state then
        self.onPressTime = CS.CSServerTime.Instance.TotalMillisecond
        self.voiceMessageType = ternary(self.voiceMessageType ~= nil, self.voiceMessageType, LuaEnumVoiceMessageType.COMMON)
        if self:CheckUseCondition() then
            CS.ClientVoiceState.isCancelLuying = false
            self.recordChannel = self:GetChannelType()
            self.IsAllowUseVoice = true
            self.recordState = LuaEnumRecordState.Record
            self.privateRoleId = ternary(self:GetChannelType() == luaEnumChatChannelType.PRIVATE and self.privateRoleId ~= nil, self.privateRoleId, 0)
            self.privateRoleName = ternary(self:GetChannelType() == luaEnumChatChannelType.PRIVATE and self.privateRoleName ~= nil, self.privateRoleName, "")
            uiStaticParameter.voiceMgr:StartRecord(uiStaticParameter.voiceMgr:GetVoicePath(), "", self:GetChannelType(), self.privateRoleId, self.privateRoleName, nil, function(url)
            end, nil, self.voiceMessageType == LuaEnumVoiceMessageType.COMMON)
            self:SetVoiceState(true)
        else
            self.IsAllowUseVoice = false
        end
    else
        self:RecordEnd()
    end
end

---录音结束
function UIVoiceBaseTemplate:RecordEnd()
    if (self.IsAllowUseVoice == false) then
        return
    end
    self.IsAllowUseVoice = false
    local time = CS.CSServerTime.Instance.TotalMillisecond - self.onPressTime
    if self.recordState == LuaEnumRecordState.CallOff then
        uiStaticParameter.voiceMgr:CancleRecord()
    elseif time < 1000 then
        CS.Utility.ShowTips("录音时间过短");
        CS.ClientVoiceState.isCancelLuying = true
        uiStaticParameter.voiceMgr:CancleRecord()
    elseif self.recordState == LuaEnumRecordState.Record then
        self.recordState = LuaEnumRecordState.CallOff
        uiStaticParameter.voiceMgr:StopRecord()
        self.timerCoroutine = StartCoroutine(function(time)
            self:CalculateTime(time)
        end, 5)
    end
    self.voicestate.gameObject:SetActive(false)
end

function UIVoiceBaseTemplate:OnEnd()
    uiStaticParameter.voiceMgr:CancleRecord()
    self.voicestate.gameObject:SetActive(false)
end

function UIVoiceBaseTemplate:Drag()
    if self.IsAllowUseVoice then
        local mouseWorldPosition = self.uiCamera:ScreenToWorldPoint(CS.UnityEngine.Input.mousePosition)
        mouseWorldPosition.z = 0
        local btnPosition = self.btn_voice.transform.position
        btnPosition.z = 0
        local distance = CS.UnityEngine.Vector3.Distance(mouseWorldPosition, btnPosition)
        if distance <= 0.15 then
            if self.recordState == LuaEnumRecordState.Pause then
                self.recordState = LuaEnumRecordState.Record
                uiStaticParameter.voiceMgr:ResumeRecord()
                self:SetVoiceState(true)
            end
        else
            if self.recordState == LuaEnumRecordState.Record then
                self.recordState = LuaEnumRecordState.Pause
                uiStaticParameter.voiceMgr:PauseRecord()
                self:SetVoiceState(false)
            end
        end
    end
end

function UIVoiceBaseTemplate:SetVoiceState(state)
    self.voicestate.gameObject:SetActive(true)
    self.voiceLabel.gameObject:SetActive(true)
    if (state) then
        self.voicestateReturn.gameObject:SetActive(false)
        self.voiceLoading_GameObject:SetActive(true)
        self.voiceLabel.text = "正在录音..."
        self.voiceLoading.enabled = true
    else
        self.voicestateReturn.gameObject:SetActive(true)
        self.voiceLoading_GameObject:SetActive(false)
        self.voiceLabel.text = "取消录音..."
        self.voiceLoading.enabled = false
    end
end

---录音完成
function UIVoiceBaseTemplate:RecordIsComplete(url, time)
    if time ~= nil and time >= 58000 then
        if self.recordState == LuaEnumRecordState.CallOff then
            CS.Utility.ShowTips("录音时间过长");
        end
    end
    if CS.StaticUtility.IsNullOrEmpty(url) == false then
        self:TryAutoPlayVoice(CS.SDKManager.VoiceSDKInterface.filePath)
    end
    self:RecordEnd()
end

---尝试自动播放语音
function UIVoiceBaseTemplate:TryAutoPlayVoice(filePath)
    --if self.recordChannel == self:GetChannelType() and CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(self:GetSettingKey()) == true then
    --    uiStaticParameter.voiceMgr:PlayAudio(filePath)
    --end
end

---设置自动播放语音状态
function UIVoiceBaseTemplate:SetAutoPlayVoiceState(state)
    CS.SDKManager.VoiceSDKInterface.openAutoPlayVoice = state
end
--endregion
--endregion

--region 实时语音功能
---麦克风开关
function UIVoiceBaseTemplate:MicBtnClick(go)
    -- if self.btn_Mic == nil then
    --     return
    -- end
    -- if not self:IsVoicePermission() then
    --     Utility.ShowPopoTips(self.btn_Mic.gameObject.transform, nil, 297)
    --     -- CS.Utility.ShowTips("请告知会长，为您开启自由麦特权")
    --     self.btn_Mic.spriteName = "Speak_Guild3"
    --     CS.SDKManager.VoiceSDKInterface.IsOpemMic = false
    --     return
    -- end
    -- CS.SDKManager.VoiceSDKInterface.IsOpemMic = not CS.SDKManager.VoiceSDKInterface.IsOpemMic
    -- local openNumber = 0
    -- if CS.SDKManager.VoiceSDKInterface.IsOpemMic then
    --     openNumber = 1;
    -- end
    -- networkRequest.ReqToggleVoiceOpen(openNumber)
    -- if CS.SDKManager.VoiceSDKInterface.IsOpemMic then
    --     self.btn_Mic.spriteName = "Speak_Guild1"
    --     Utility.ShowBlackPopoTips(self.btn_Mic.gameObject.transform, nil, 286)
    -- else
    --     self.btn_Mic.spriteName = "Speak_Guild2"
    --     Utility.ShowBlackPopoTips(self.btn_Mic.gameObject.transform, nil, 287)
    -- end
end

---麦克风说话
function UIVoiceBaseTemplate:MicBtnTalkClick(go)
    -- if self.btn_Mic == nil then
    --     return
    -- end
    -- CS.SDKManager.VoiceSDKInterface.IsOpemMic = not CS.SDKManager.VoiceSDKInterface.IsOpemMic
    -- local openNumber = 0
    -- if CS.SDKManager.VoiceSDKInterface.IsOpemMic then
    --     openNumber = 1;
    -- end
    -- networkRequest.ReqToggleVoiceOpen(openNumber)
    -- if CS.SDKManager.VoiceSDKInterface.IsOpemMic then
    --     self.btn_Mic.spriteName = "Speak_Guild1"
    --     Utility.ShowBlackPopoTips(self.btn_Mic.gameObject.transform, nil, 286)
    -- else
    --     self.btn_Mic.spriteName = "Speak_Guild2"
    --     Utility.ShowBlackPopoTips(self.btn_Mic.gameObject.transform, nil, 287)
    -- end
    -- self.btn_Mic.gameObject:SetActive(true)
    -- self.btn_Speaker_now.gameObject:SetActive(false)
end

---刷新实时语音播放状态
function UIVoiceBaseTemplate:RefereshRealTimeVoiceActive(data)
    -- local isHaveTalk = false
    -- if data == 5 then
    --     isHaveTalk = true
    -- elseif data == 6 then
    --     isHaveTalk = false
    -- end

    -- if CS.SDKManager.VoiceSDKInterface.IsOpemMic then
    --     self.btn_Mic.gameObject:SetActive(not isHaveTalk)
    --     self.btn_Speaker_now.gameObject:SetActive(isHaveTalk)
    -- else
    --     self.btn_Mic.gameObject:SetActive(true)
    --     self.btn_Speaker_now.gameObject:SetActive(false)
    -- end
end

--是否有语音权限
function UIVoiceBaseTemplate:IsVoicePermission()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2 == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.PlayerUnionMemberInfo == nil then
        return false
    end
    local palyerInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2.PlayerUnionMemberInfo
    if palyerInfo.canSendVoice == false then
        return false
    end
    return true
end
--是否开启语音
function UIVoiceBaseTemplate:IsOpenVoice()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2 == nil or CS.CSScene.MainPlayerInfo.UnionInfoV2.PlayerUnionMemberInfo == nil then
        return false
    end
    local palyerInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2.PlayerUnionMemberInfo
    if palyerInfo.voiceOpen == false then
        return false
    end
    return true
end

---扬声器开关
function UIVoiceBaseTemplate:SpeakerBtnClick(go)
    --     if self.btn_Mic == nil then
    --         return
    --     end
    --    -- CS.SDKManager.VoiceSDKInterface.IsOpemSpeaker = not CS.SDKManager.VoiceSDKInterface.IsOpemSpeaker
    --     networkRequest.ReqToggleSpeaker()
    --     if CS.CSScene.MainPlayerInfo.UnionInfoV2.IsOpenLister then
    --         self.btn_Speaker.spriteName = "Lister_Guild2"
    --         Utility.ShowBlackPopoTips(self.btn_Speaker.gameObject.transform, nil, 289)
    --     else
    --         self.btn_Speaker.spriteName = "Lister_Guild1"
    --         Utility.ShowBlackPopoTips(self.btn_Speaker.gameObject.transform, nil, 288)
    --     end
end

function UIVoiceBaseTemplate:SendVoiceBtnOnPress(go, state)
    uiStaticParameter.voiceMgr:SwitchSendVoice(state)
end
--endregion

--region 限制条件
---使用条件
function UIVoiceBaseTemplate:CheckUseCondition()
    local level = CS.CSScene.MainPlayerInfo.Level
    if level <= CS.Cfg_GlobalTableManager.Instance:GetSendVoiceLevel() then
        CS.Utility.ShowTips("人物等级不足")
        return false
    end
    if self.usetime > 0 then
        CS.Utility.ShowTips("发送太过频繁，请稍后再试")
        return false
    end
    if self.voiceMessageType == LuaEnumVoiceMessageType.COMMON then
        if (self:GetChannelType() == luaEnumChatChannelType.SYSTEM) then
            CS.Utility.ShowTips("系统频道不可聊天");
            return false
        elseif (self:GetChannelType() == luaEnumChatChannelType.PRIVATE and (self.privateRoleId == nil or self.privateRoleId == 0)) then
            CS.Utility.ShowTips("无私聊对象");
            return false
        elseif self:GetChannelType() == luaEnumChatChannelType.UNION and CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionID == 0 then
            CS.Utility.ShowTips("没有行会");
            return false
        elseif self:GetChannelType() == luaEnumChatChannelType.TEAM and CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo == nil then
            CS.Utility.ShowTips("没有队伍");
            return false
        end
    end
    return true
end
--endregion

--region 语音间隔
---使用间隔
function UIVoiceBaseTemplate:CalculateTime(time)
    self.usetime = time
    while self.usetime > 0 do
        self.usetime = self.usetime - CS.UnityEngine.Time.deltaTime
        coroutine.yield(0)
    end
end
--endregion

--region 获取
---获取频道类型
function UIVoiceBaseTemplate:GetChannelType()
    if uiStaticParameter.UIChatPanel_SelectIndex == luaEnumChatChannelType.COMPREHENSIVE then
        --luaEnumChatChannelType.WORLD
        return uiStaticParameter.UIChatPanel_SelectIndex_Default
    end
    return uiStaticParameter.UIChatPanel_SelectIndex
end

---获取语音设置键值
function UIVoiceBaseTemplate:GetSettingKey()
    local channelType = self:GetChannelType()
    if channelType == luaEnumChatChannelType.WORLD then
        return CS.EConfigOption.AutoPlayerVoice_World
    elseif channelType == luaEnumChatChannelType.TEAM then
        return CS.EConfigOption.AutoPlayerVoice_Team
    elseif channelType == luaEnumChatChannelType.UNION then
        return CS.EConfigOption.AutoPlayerVoice_Union
    elseif channelType == luaEnumChatChannelType.PRIVATE then
        return CS.EConfigOption.AutoPlayerVoice_Private
    end
end
--endregion

--region 设置
function UIVoiceBaseTemplate:ChangeRecordState(state, source)
    self.recordIsOpen = state
    self.recordSource = source
    if state == false then
        self.recordState = LuaEnumRecordState.CallOff
        self:RecordEnd()
    end
end
--endregion
return UIVoiceBaseTemplate