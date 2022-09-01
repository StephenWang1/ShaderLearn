local UIVoice_Mgr = {}
--region 数据
---下载列表(url)
--UIVoice_Mgr.downLoadList = CS.System.Collections.Generic["List`1[System.String]"]()
UIVoice_Mgr.downLoadList = {}
---下载完成列表（url -> filepath）
UIVoice_Mgr.playList = {}
--endregion

--region 登录和退出
---初始化
function UIVoice_Mgr:Init()
    CS.SDKManager.VoiceSDKInterface:Login(CS.CSScene.MainPlayerInfo.Name,self:GetUid(),"")
end

function UIVoice_Mgr:InitParams()
    self.recordState = true
    self.recordSource = LuaEnumControlRecordStateSource.NONE
end

---进入房间
function UIVoice_Mgr:Login(roomType)
   if roomType==nil then
       return 
   end
   -- CS.SDKManager.VoiceSDKInterface:RealTimeVoiceEnterRoom(roomType);
end

---退出房间
function UIVoice_Mgr:Logout()
  --  CS.SDKManager.VoiceSDKInterface:RealTimeLogOutRoom()
end
--endregion

--region 调用接口
--region 语音消息
--region 基础信息获取
---获取房间id
function UIVoice_Mgr:GetServerRoom()
    return uiStaticParameter.serverRoom
end
---获取uid
function UIVoice_Mgr:GetUid()
    return CS.PlayerInfo.Rid
end
--endregion

--region 录音
---开始录音
function UIVoice_Mgr:StartRecord(savePath,extend,channel,sendRoleLid,sendToName,luyinResponse,uploadResponse,playAudioResponse,reqSendVoice)
    if not self:isAllowPlayVoice() then
        return
    end
    CS.CSAudioMgr.Instance:EnableAudioMgr(false)
    CS.SDKManager.VoiceSDKInterface:StartRecord(savePath,extend,channel,sendRoleLid,sendToName,luyinResponse,uploadResponse,playAudioResponse,reqSendVoice)
end
---停止录音
function UIVoice_Mgr:StopRecord()
    CS.CSAudioMgr.Instance:EnableAudioMgr(true)
    CS.SDKManager.VoiceSDKInterface:StopRecord()
end
---暂停录音
function UIVoice_Mgr:PauseRecord()
    CS.SDKManager.VoiceSDKInterface:PauseRecording()
end
---恢复录音
function UIVoice_Mgr:ResumeRecord()
    CS.SDKManager.VoiceSDKInterface:ResumeRecording()
end
---取消录音
function UIVoice_Mgr:CancleRecord()
    CS.SDKManager.VoiceSDKInterface:CancelRecording()
end
--endregion

--region 播放
---播放录音
function UIVoice_Mgr:PlayAudio(url,response)
    if url ~= nil then
        CS.SDKManager.VoiceSDKInterface:PlayAudioByFilePath(url)
    end
end
--endregion

--region 翻译

--endregion

--region 数据
---获取语音时长
---@return 时间（毫秒）
function UIVoice_Mgr:GetVoiceFileDuration(filepath)
    return CS.SDKManager.VoiceSDKInterface:GetTimeByFilePath(filepath)
end

function UIVoice_Mgr:GetVoicePath()
    local path = CS.SDKManager.VoiceSDKInterface:GetFileDwonLoadPath()
    if path ~= nil then
        return path
    end
end
--endregion

--region 下载
---添加到下载列表
function UIVoice_Mgr:AddDownLoadList(resChat)
    local downLoadURL = self:GetUrlByResChat(resChat)
    if downLoadURL ~= nil then
        self.downLoadList[downLoadURL] = resChat
        --CS.UnityEngine.Debug.LogError("下载语音地址" .. downLoadURL)
        CS.SDKManager.VoiceSDKInterface:DownloadRecordedFile(downLoadURL,function(downLoadURL)
            --CS.UnityEngine.Debug.LogError("下载结束" .. downLoadURL)
            self:DownLoadComplete(downLoadURL)
        end)
    end
end

---下载完成
function UIVoice_Mgr:DownLoadComplete(downLoadURL)
    --CS.UnityEngine.Debug.LogError("发送语音消息" .. downLoadURL)
    if downLoadURL then
        --self.downLoadList.Remove(url)
        local resChat = self.downLoadList[downLoadURL]
        if self.playList[downLoadURL] == nil then
            self.playList[downLoadURL] = CS.SDKManager.VoiceSDKInterface:GetFileDownLoadPath(downLoadURL)
            self.uiMainChatPanel = uimanager:GetPanel("UIMainChatPanel")
            if self.uiMainChatPanel ~= nil then
                self.uiMainChatPanel.OriginEvent_SendChat(nil,resChat)
            end
        end
    end
end
--endregion
--endregion

--region 实时语音
---麦克风控制
function UIVoice_Mgr:SwitchSendVoice(openSendVoice,action)
   -- CS.SDKManager.VoiceSDKInterface:ChatMic(true,"")
   -- CS.SDKManager.VoiceSDKInterface:SwitchVoiceSpeakState(action,openSendVoice,openSendVoice)
end
---接收语音控制
function UIVoice_Mgr:SwitchReceiveVoice(openReceiveVoice,action)
  --  CS.SDKManager.VoiceSDKInterface:SetPausePlayRealAudio(false)
 --   CS.SDKManager.VoiceSDKInterface:SwitchVoiceListerState(action,openReceiveVoice,openReceiveVoice)
end
--endregion
--endregion

--region 语音播放条件
function UIVoice_Mgr:isAllowPlayVoice()
    return self.recordState == nil or self.recordState == true
end

---获取录音参数
function UIVoice_Mgr:GetRecordParams()
    return self.recordState,self.recordSource
end
--endregion

--region 录音开关控制
function UIVoice_Mgr:ChangeRecordState(state,source)
    self.recordState = state
    self.recordSource = source
    if self.recordState == false then
        if luaEventManager.HasCallback(LuaCEvent.RecordStateChange) then
            luaEventManager.DoCallback(LuaCEvent.RecordStateChange,self.recordState,self.recordSource )
        end
    end
end
--endregion

--region 退出登录
function UIVoice_Mgr:LogOutGame(action)
    self:Logout(function()
        CS.SDKManager.VoiceSDKInterface:LogoutGame()
        self:Destroy()
    end)
end
--endregion

--region update
function UIVoice_Mgr:Update()
    CS.SDKManager.VoiceSDKInterface:Update()
end
--endregion

--region destroy
function UIVoice_Mgr:Destroy()
end
--endregion

--region analysis
---通过 chatV2.ResChat 解析下载地址
function UIVoice_Mgr:GetUrlByResChat(resChat)
    local messageList = string.Split(resChat.message,'$')
    local downLoadURL = messageList[3]
    return downLoadURL
end
--endregion

--region 获取
---通过url获取文件地址
function UIVoice_Mgr:GetFilePathByUrl(url)
    if CS.StaticUtility.IsNullOrEmpty(url) == false then
        return CS.SDKManager.VoiceSDKInterface:GetFileDownLoadPath(url)
    end
end
--endregion
return UIVoice_Mgr