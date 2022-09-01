---@class UILoginPanel:UIBase 登录界面
local UILoginPanel = {}

--region parameters
UILoginPanel.isStart = false

UILoginPanel.list = {}
UILoginPanel.mServerIndex = 0
UILoginPanel.mRecommendServerIndex = 0
UILoginPanel.www = nil

--coroutine parameters

UILoginPanel.IEnumLoadTableCoroutine = nil
UILoginPanel.linkCoroutine = nil
UILoginPanel.linkMaxTime = 15
UILoginPanel.IsPassUserAgreement = false
---服务器状态图片
UILoginPanel.StateSprite = {
    [LuaEnumServerState.NewServer] = "2",
    [LuaEnumServerState.Full] = "3",
}
--endregion

---@return HttpRequest
function UILoginPanel:HttpRequestInstance()
    if self.mHttpRequest == nil then
        self.mHttpRequest = CS.HttpRequest.Instance
    end
    return self.mHttpRequest
end

---推荐区服id
function UILoginPanel:GetRecommendServerID()
    if self.mRecommendServer == nil then
        self.mRecommendServer = self:HttpRequestInstance().ServerFile.RecommendServerId
    end
    return self.mRecommendServer
end

--region components
--function UILoginPanel.GetLogoUITexture()
--    if UILoginPanel.mLogo_UITexture == nil then
--        UILoginPanel.mLogo_UITexture = UILoginPanel:GetCurComp("WidgetRoot/logo", "UITexture")
--    end
--    return UILoginPanel.mLogo_UITexture
--end

---jiazai图加载
function UILoginPanel.GetJiazaiLoader()
    if UILoginPanel.mJiaZaiLoader == nil then
        UILoginPanel.mJiaZaiLoader = UILoginPanel:GetCurComp("WidgetRoot/jiazai", "PictureLoader")
    end
    return UILoginPanel.mJiaZaiLoader
end

---logo加载
function UILoginPanel.GetLogoLoader()
    if UILoginPanel.mLogoLoader == nil then
        UILoginPanel.mLogoLoader = UILoginPanel:GetCurComp("WidgetRoot/logo", "PictureLoader")
    end
    return UILoginPanel.mLogoLoader
end

function UILoginPanel.GetQiZiGameObject()
    if UILoginPanel.mQiZi_GO == nil then
        UILoginPanel.mQiZi_GO = UILoginPanel:GetCurComp("WidgetRoot/BlackBG/qizi", "GameObject")
    end
    return UILoginPanel.mQiZi_GO
end

function UILoginPanel.GetBGEffectGameObject()
    if UILoginPanel.mBGEffectGameObject == nil then
        UILoginPanel.mBGEffectGameObject = UILoginPanel:GetCurComp("WidgetRoot/BlackBG", "GameObject")
    end
    return UILoginPanel.mBGEffectGameObject
end

function UILoginPanel.GetLoginViewGameObject()
    if UILoginPanel.mLoginView_GO == nil then
        UILoginPanel.mLoginView_GO = UILoginPanel:GetCurComp("WidgetRoot/loginview", "GameObject")
    end
    return UILoginPanel.mLoginView_GO
end

function UILoginPanel.GetServerViewGameObject()
    if UILoginPanel.mServerView_GO == nil then
        UILoginPanel.mServerView_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview", "GameObject")
    end
    return UILoginPanel.mServerView_GO
end

function UILoginPanel.GetLBVersionUILabel()
    if UILoginPanel.mLBVersion_UILabel == nil then
        UILoginPanel.mLBVersion_UILabel = UILoginPanel:GetCurComp("WidgetRoot/lb_version", "UILabel")
    end
    return UILoginPanel.mLBVersion_UILabel
end

function UILoginPanel.GetInputUIInput()
    if UILoginPanel.mInput_UIInput == nil then
        UILoginPanel.mInput_UIInput = UILoginPanel:GetCurComp("WidgetRoot/loginview/inputname", "UIInput")
    end
    return UILoginPanel.mInput_UIInput
end

function UILoginPanel.GetLogoGameObject()
    if UILoginPanel.mLogo_GO == nil then
        UILoginPanel.mLogo_GO = UILoginPanel:GetCurComp("WidgetRoot/logo", "GameObject")
    end
    return UILoginPanel.mLogo_GO
end

function UILoginPanel.GetLoginButtonGameObject()
    if UILoginPanel.mLoginBtn_GO == nil then
        UILoginPanel.mLoginBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/loginview/btn_login", "GameObject")
    end
    return UILoginPanel.mLoginBtn_GO
end

function UILoginPanel.GetLoginplayerInfo_GameObject()
    if UILoginPanel.mplayerInfo_GameObject == nil then
        UILoginPanel.mplayerInfo_GameObject = UILoginPanel:GetCurComp("WidgetRoot/toggle_playerInfo", "GameObject")
    end
    return UILoginPanel.mplayerInfo_GameObject
end

function UILoginPanel.GetLoginplayerInfo_toggle()
    if UILoginPanel.mplayerInfo_toggle == nil then
        UILoginPanel.mplayerInfo_toggle = UILoginPanel:GetCurComp("WidgetRoot/toggle_playerInfo", "Top_UIToggle")
    end
    return UILoginPanel.mplayerInfo_toggle
end

function UILoginPanel.GetServerIPUILabel()
    if UILoginPanel.mServerIP_UILabel == nil then
        UILoginPanel.mServerIP_UILabel = UILoginPanel:GetCurComp("WidgetRoot/serverview/serverIp", "UILabel")
    end
    return UILoginPanel.mServerIP_UILabel
end

function UILoginPanel.GetEnterBtnGameGameObject()
    if UILoginPanel.mEnterGameBtn_GO == nil then
        UILoginPanel.mEnterGameBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview/btn_enter", "GameObject")
    end
    return UILoginPanel.mEnterGameBtn_GO
end

function UILoginPanel.GetChooseServerBtnGameObject()
    if UILoginPanel.mChooseServerBtn_GO == nil then
        UILoginPanel.mChooseServerBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview/btn_choose", "GameObject")
    end
    return UILoginPanel.mChooseServerBtn_GO
end

function UILoginPanel.GetXYBtnGameObject()
    if UILoginPanel.mXYBtn_GO == nil then
        UILoginPanel.mXYBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview/xy", "GameObject")
    end
    return UILoginPanel.mXYBtn_GO
end

function UILoginPanel.GetSwitchUserBtnGameObject()
    if UILoginPanel.mSwitchUserBtn_GO == nil then
        UILoginPanel.mSwitchUserBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview/switchuser", "GameObject")
    end
    return UILoginPanel.mSwitchUserBtn_GO
end

function UILoginPanel.GetRepairGameObject()
    if UILoginPanel.mrepair == nil then
        UILoginPanel.mrepair = UILoginPanel:GetCurComp("WidgetRoot/repair", "GameObject")
    end
    return UILoginPanel.mrepair
end

function UILoginPanel.GetNoticeBtnGameObject()
    if UILoginPanel.mNoticeBtn_GO == nil then
        UILoginPanel.mNoticeBtn_GO = UILoginPanel:GetCurComp("WidgetRoot/serverview/notice", "GameObject")
    end
    return UILoginPanel.mNoticeBtn_GO
end

---版号的label
function UILoginPanel.GetBanHao_UILabel()
    if UILoginPanel.mGetBanHao_UILabel == nil then
        UILoginPanel.mGetBanHao_UILabel = UILoginPanel:GetCurComp("WidgetRoot/Label", "UILabel")
    end
    return UILoginPanel.mGetBanHao_UILabel
end
--endregion

--region init
---初始化,在uimanager.lua中被调用
function UILoginPanel:Init()
    --CS.Top_FPS.Instance._IsShowFPS = false
    uimanager:ClosePanelInCS(typeof(CS.UIDownloading))
    --print("UILoginPanel:Init")
    --bind messages
    UILoginPanel.BindMessages()
    --bind uievents
    UILoginPanel.BindUIEvents()
    --deal with static resource 
    local csgamemanager = CS.CSGameManager.Instance
    csgamemanager:InitLoadQueue()
    csgamemanager:SaveStaticObj("ItemIcon")
    csgamemanager:SaveStaticObj("SOURCEHANSANSCN-NORMAL")
    csgamemanager:SaveStaticObj("msyh")

    --set ui state
    UILoginPanel.SetUIState()
    --initialize login mode
    UILoginPanel.InitLoginMode()
    CS.SDKManager.GameInterface:HotUpdateSchedule(100);

    self.enterGame = CS.CSListUpdateMgr.Add(500, nil, function()
        --if CS.CSResUpdateMgr.Instance ~= nil then
        --    CS.CSGame.Sington:EnterGame();
        --end
        CS.SDKManager.GameInterface:EnterUnity(0);
    end)
    --CS.UnityEngine.Application.OpenURL("www.baidu.com");
    CS.CSListUpdateMgr.Instance:Add(self.enterGame)

    --CS.SDKManager.GameInterface:EnterUnity(0);
    --强制关掉低血闪烁面板
    uimanager:ClosePanel('UISmallHpWarning')

    CS.GameDataSubmit.Instance:SendDataByInt(CS.EGameDataAction.MobileData, CS.ESendDataType.EnterLogin);
    --进行后台下载
    if (CS.CSVersionMgr.Instance.ServerVersion.BackdownVersion ~= "") then
        CS.SDKManager.GameInterface:ExcuteVoid("RunningIL2CPPBackdown#" .. tostring(CS.CSVersionMgr.Instance.ServerVersion.BackdownVersion));
    end
    CS.CSNetwork.Instance:Close();
    ----编辑器下,使用端口,不使用域名,有需要  手动调整
    --if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor then
    --    --CS.SDKManager.PlatformData.IsUseYM = false;
    --end
    UILoginPanel.LoadHot()
    if self:GetRepairGameObject() ~= nil then
        self:GetRepairGameObject().gameObject:SetActive(false)
    end
end

---初始化,在uimanager.lua中被调用
function UILoginPanel:Show()
    --文字提示面板，一直存在，不销毁
    uimanager:CreatePanel("UIAllTextTipsContainerPanel", nil)
    uimanager:CreatePanel("UIDownTipsContainerPanel", nil)
    UILoginPanel.GetLoginViewGameObject():SetActive(true)
    UILoginPanel.GetServerViewGameObject():SetActive(false)
    --UILoginPanel:Init()
    --play background music
    local csaudiomgr = CS.CSAudioMgr.Instance
    if csaudiomgr ~= nil then
        ---此面板和表格同时加载所以无法读表播放音乐
        CS.CSAudioMgr.Instance:Play(CS.EAudioType.BGM, "logplane", false, 0, 1, true)
    end
    --UILoginPanel.GetLogoUITexture().gameObject:SetActive(false);
    UILoginPanel.LoadLogo()
end

---绑定消息
function UILoginPanel.BindMessages()
    --bind messages
    UILoginPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ConnectSuccessMessage, UILoginPanel.OnLoginSucceed)
    UILoginPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ConnectFailedMessage, UILoginPanel.OnLoginFail)
    UILoginPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCreateRoleMessage, UILoginPanel.OnResCreateRoleMessage)
    UILoginPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLoginMessage, UILoginPanel.OnResLoginMessage)
    UILoginPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateLoginState, UILoginPanel.OnUpdateLoginState)
    UILoginPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateSelectedServer, UILoginPanel.OnUpdateSelectedServer)
    UILoginPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_LoginVersionChecked, UILoginPanel.OnLoginVersionChecked)
    UILoginPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ConnectNetwork, UILoginPanel.OnConnectNetwork)
end

---绑定UI事件
function UILoginPanel.BindUIEvents()
    --bind uievents
    local UIEventListener = CS.UIEventListener
    UIEventListener.Get(UILoginPanel.GetLoginButtonGameObject()).onClick = UILoginPanel.OnClickBtn_Login
    CS.EventDelegate.Add(UILoginPanel.GetLoginplayerInfo_toggle().onChange, function()
        UILoginPanel.IsPassUserAgreement = UILoginPanel.GetLoginplayerInfo_toggle().value
        CS.UnityEngine.PlayerPrefs.SetString("IsPassUserAgreement", tostring(UILoginPanel.GetLoginplayerInfo_toggle().value))
    end)
    UIEventListener.Get(UILoginPanel.GetEnterBtnGameGameObject()).onClick = UILoginPanel.OnClickBtn_EnterGame
    UIEventListener.Get(UILoginPanel.GetChooseServerBtnGameObject()).onClick = UILoginPanel.OnClickBtn_ChooseServer
    UIEventListener.Get(UILoginPanel.GetXYBtnGameObject()).onClick = UILoginPanel.OnClickBtn_XY
    UIEventListener.Get(UILoginPanel.GetNoticeBtnGameObject()).onClick = UILoginPanel.OnClickBtn_Notice
    UIEventListener.Get(UILoginPanel.GetSwitchUserBtnGameObject()).onClick = UILoginPanel.OnClickBtn_ChangeAccount
    UIEventListener.Get(UILoginPanel.GetRepairGameObject()).onClick = UILoginPanel.OnClickRepairGameObject
    UIEventListener.Get(UILoginPanel.GetLBVersionUILabel().gameObject).onClick = UILoginPanel.OnClickLBVersionUILabel
end

---设置UI状态
function UILoginPanel.SetUIState()
    if isOpenLog then
        print("设置UI状态")
    end

    --deal with ui interface
    local csversionmgr = CS.CSVersionMgr.Instance
    local sdkconstant = CS.SDKManager.PlatformData

    uimanager:ClosePanelInCS(typeof(CS.UIWaiting))
    --if UILoginPanel.GetLogoUITexture() ~= nil then
    --    UILoginPanel.GetLogoUITexture():MakePixelPerfect()
    --end

    if ((not CS.CSGame.Sington.isLoadLocalRes) and UILoginPanel.GetLBVersionUILabel()) then
        UILoginPanel.GetLBVersionUILabel().text = "V" .. csversionmgr.Version
    end

    if UILoginPanel.GetXYBtnGameObject() then
        UILoginPanel.GetXYBtnGameObject():SetActive(sdkconstant.PlatformName:upper():find("TANWAN") == nil)
    end

    if ((not UILoginPanel.GetXYBtnGameObject().activeSelf) and (UILoginPanel.GetSwitchUserBtnGameObject().actiactiveSelf)) then
        UILoginPanel.GetSwitchUserBtnGameObject().transform.localPosition = CS.UnityEngine.Vector3(529, 298, 0)
    end

    if ((sdkconstant:GetPlatformData() ~= nil) and (not sdkconstant:GetPlatformData().switchAccount)) then
        local tempTrans = UILoginPanel.go.transform:Find("switchuser")
        if tempTrans and CS.StaticUtility.IsNull(tempTrans) ~= false then
            tempTrans.gameObject:SetActive(false)
        end
    end
end

---1.登入第一步   初始化登录模式
function UILoginPanel.InitLoginMode()
    if isOpenLog then
        print("初始化登录模式")
    end

    UILoginPanel.GetInputUIInput().gameObject:SetActive(true)
    if CS.SDKManager.PlatformData ~= nil and CS.SDKManager.PlatformData:GetPlatformData() ~= nil and
            (CS.SDKManager.PlatformData:GetPlatformData().platformID == 5
                    or CS.SDKManager.PlatformData:GetPlatformData().platformID == 6)
    then
        UILoginPanel.GetLogoGameObject():SetActive(false)
    else
        UILoginPanel.GetLogoGameObject():SetActive(true)
    end

    if CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor or CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor then
        if UILoginPanel.GetInputUIInput() ~= nil then
            UILoginPanel.GetInputUIInput().gameObject:SetActive(true)
            UILoginPanel.GetInputUIInput().value = CS.UnityEngine.PlayerPrefs.GetString("userName")
        end
    else
        if UILoginPanel.GetInputUIInput() ~= nil then
            UILoginPanel.GetInputUIInput().gameObject:SetActive(false)
        end
        CS.SDKManager.GameInterface.OnAndroidLoginSuc = UILoginPanel.LoginSuccess
    end

end
--endregion

---2.账号登入界面--登录按钮点击事件
function UILoginPanel.OnClickBtn_Login(go)
    if (UILoginPanel.IsPassUserAgreement) then
        UILoginPanel.GetLoginplayerInfo_GameObject():SetActive(false)
        CS.CSNetwork.Instance.isStepParse = true
        --CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.MobileData, "7");
        if isOpenLog then
            print("账号登入界面--登录按钮点击事件")
        end
        if UILoginPanel == nil then
            return
        end

        if CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor or CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor then
            if (UILoginPanel.GetInputUIInput() ~= nil) then

                UILoginPanel.EditorLogin()
            end
        else
            --if (CS.AndroidSDKCallback.Instance:CheckLoginCahce()) then
            --    CS.AndroidSDKCallback.Instance:ClearLoginCache();
            --    return
            --end
            local lastlogindata = CS.SDKManager.GameInterface:ExcuteString("GetLastLoginData", "");
            if (not CS.StaticUtility.IsNullOrEmpty(lastlogindata)) then
                CS.SDKManager.GameInterface:ExcuteVoid("ClearLastLoginData", "");
                CS.AndroidSDKCallback.Instance:OnAndroidLoginSuccess(lastlogindata);
                return ;
            end

            CS.SDKManager.GameInterface:Login()
        end
    else
        --未勾选通过用户协议
    end
end

---3. 编辑器模式下,账号直接登入成功,
function UILoginPanel.EditorLogin()
    if isOpenLog then
        print("编辑器登录成功")
    end
    if CS.System.String.IsNullOrEmpty(UILoginPanel.GetInputUIInput().value) then
        return
    end
    CS.Constant.UserID_SDK = UILoginPanel.GetInputUIInput().value
    CS.Constant.UserID_Game = UILoginPanel.GetInputUIInput().value
    CS.UnityEngine.PlayerPrefs.SetString("userName", UILoginPanel.GetInputUIInput().value)
    uimanager:CreatePanelInCS(typeof(CS.UIWaiting), true, nil, true, function(panel)
        panel:Refresh(CS.EWaitingReason.RequestingServerListData)
    end)
    --]]
    UILoginPanel.RequestData()
end

---3. Android模式下登入成功后,从Android发送消息到unity AndroidSDKCallback脚本,然后通过CS.SDKManager.GameInterface.OnAndroidLoginSuc回调到这里
function UILoginPanel.LoginSuccess(data)
    if isOpenLog then
        print("Android模式下登入成功后,从Android发送消息到unity AndroidSDKCallback脚本,然后通过CS.SDKManager.GameInterface.OnAndroidLoginSuc回调到这里")
    end
    if data == nil then
        return
    end

    --CS.SDKManager.GameInterface.OnAndroidLoginSuc = nil
    CS.Constant.UserID_SDK = data.sdk_uid
    CS.Constant.LoginToken_SDK = data.sdk_token
    CS.Constant.time = data.time
    CS.Constant.LoginRequestJson = data.Extjson

    uimanager:CreatePanelInCS(typeof(CS.UIWaiting), true, nil, true, function(panel)
        panel:Refresh(CS.EWaitingReason.RequestingServerListData)
    end)
    --SDK登入完成后,直接去向服务器请求数据
    UILoginPanel.RequestDataAndroid()
end

---3. IOS模式下登入成功后(现在没有IOS  先不管他)
function UILoginPanel.OnIOSSDKLoginSuc(_LoginInfo)
    if isOpenLog then
        print("IOS模式下登入成功后(现在没有IOS  先不管他)")
    end
    --print("OnIOSSDKLoginSuc")
    local constant = CS.Constant
    constant.UserID_SDK = _LoginInfo.UserId
    constant.loginExt = _LoginInfo.Ext
    constant.isBindPhone = _LoginInfo.IsBindPhone
    constant.isWhitePaper = _LoginInfo.IsWhitePaper
    uimanager:CreatePanelInCS(typeof(CS.UIWaiting), true, nil, true, function(panel)
        panel:Refresh(CS.EWaitingReason.RequestingServerListData)
    end)

    UILoginPanel.RequestData()
end

---4. 账号登入成功后,请求服务器列表
function UILoginPanel.RequestData()
    --UILoginPanel.GetLogoGameObject():SetActive(true)
    if isOpenLog then
        print("请求服务器列表")
    end
    CS.AndroidSDKCallback.Instance:ClearLoginCache();
    CS.SDKManager.GameInterface:ExcuteVoid("ClearLastLoginData", "");
    CS.HttpRequest.Instance:RequestData()

    CS.GameDataSubmit.Instance:SendDataByInt(CS.EGameDataAction.MobileData, CS.ESendDataType.AccountLogin);
end

---5. 选择完服务器后,进入游戏按钮点击事件--设置进入的服务器端口,域名
function UILoginPanel.OnClickBtn_EnterGame(go)
    if isOpenLog then
        print("选择完服务器后,进入游戏按钮点击事件--设置进入的服务器端口,域名")
    end
    CS.CSVersionMgr.Instance:StartLoadServerConfigOnLogin();
end

function UILoginPanel.OnLoginVersionChecked()
    if CS.CSVersionMgr.Instance.ServerVersion.IsNewVersion then
        local data = {
            Title = "",
            Content = "当前游戏已更新至" .. CS.CSVersionMgr.Instance.ServerVersion.GameConfigVersion .. "\r\n请重启客户端",
            CenterDescription = "重启游戏",
            CallBack = function()
                CS.SDKManager.GameInterface:RestartApplication()
                -- networkRequest.ReqExitDuplicate(0)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, data)
        return
    end

    CS.GameDataSubmit.Instance:SendDataByInt(CS.EGameDataAction.MobileData, CS.ESendDataType.SelectServer);
    local constant = CS.Constant
    local httprequest = CS.HttpRequest.Instance
    if UILoginPanel.ServerItem ~= nil then
        constant.mSeverId = CS.UnityEngine.PlayerPrefs.GetInt(CS.HttpRequest.Instance.ServerFile.ServerIdKey)
        UILoginPanel.ServerItem = UILoginPanel.GetAddress(UILoginPanel.mServerIndex)
        if UILoginPanel.ServerItem.ServerName ~= nil then
            CS.Constant.mServerName = UILoginPanel.ServerItem.ServerName
        else
            CS.Constant.mServerName = ""
        end
        local IsIp = CS.CSServerFile.IsIPFormat(UILoginPanel.ServerItem.ip)
        if IsIp then
            constant.host = UILoginPanel.ServerItem.ip
        else
            constant.host = CS.Constant.GetDomainName(UILoginPanel.ServerItem.ip)
        end

        constant.gamePort = UILoginPanel.ServerItem.port + constant.AddValue

        if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor and CS.Top_CSGame.Sington._IsUsePortAndIP then
            constant.gamePort = CS.Top_CSGame.Sington.Port
            constant.host = CS.Top_CSGame.Sington.IP
        end
        local state = UILoginPanel.ServerItem.IsShow

        if UILoginPanel.ServerItem ~= nil and UILoginPanel.ServerItem.State == 4 and not CS.Constant.IsWhiteIp then
            uimanager:CreatePanel("UIOfficialNoticePanel")
            -- CS.Utility.ShowTips("服务器维护中!")
            return
        end

        if (state or CS.Constant.IsWhiteIp == true) then
            if CS.System.String.IsNullOrEmpty(constant.host) then
                return
            end
            uimanager:CreatePanelInCS(typeof(CS.UIWaiting), true, nil, true, function(panel)
                panel:Refresh(CS.EWaitingReason.ConnectingToServerInLogin)
            end)

            if CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                UILoginPanel.ConnectNetwork("连接失败1")
            elseif CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor then
                if CS.CSGame.Sington.IsOpenLoadLineServer then
                    CS.HttpRequest.Instance:RequestDataAndroid()
                else
                    UILoginPanel.ConnectNetwork("连接失败1")
                end
            else
                --CS.PlayerPrefs:SetString("userName", constant.UserID_Game)
                UILoginPanel.ConnectNetwork("连接失败 服务器链接超时")
                --UILoginPanel.RequestDataAndroid()
            end
        else
            if not CS.Constant.IsWhiteIp then
                uimanager:CreatePanel("UIOfficialNoticePanel")
            end
            -- CS.Utility.ShowTips("服务器维护中!")
        end
    end
end

---6.  请求安卓数据2次校验
function UILoginPanel.RequestDataAndroid()
    if isOpenLog then
        print("请求安卓数据2次校验")
    end
    local constant = CS.Constant
    constant.loginUrl = constant.platformLoginUrl
    constant.loginForm = CS.UnityEngine.WWWForm()

    constant.loginForm:AddField("username", constant.UserID_SDK)
    constant.loginForm:AddField("token", constant.LoginToken_SDK)
    constant.loginForm:AddField("extra", constant.LoginRequestJson)

    UILoginPanel.www = CS.UnityEngine.WWW(constant.loginUrl, constant.loginForm)
    UILoginPanel.isStart = true
    if CS.CSDebug.developerConsoleVisible then
        CS.CSDebug.LogError("登录数据： username" .. tostring(constant.UserID_SDK) .. "    token:" .. tostring(constant.LoginToken_SDK) .. "     extra:" .. tostring(constant.LoginRequestJson))
    end
end

---7. Update中每帧矫正服务器
function UILoginPanel.WaitCorrectServer()
    if UILoginPanel.isStart == false or UILoginPanel.www == nil or UILoginPanel.www.isDone == false then
        return
    end
    if UILoginPanel.www.error ~= nil then
        CS.UnityEngine.Debug.LogError("WaitCorrectServer Error " .. UILoginPanel.www.error);
        uimanager.ClosePanelInCS(typeof(CS.UIWaiting))
    else
        if isOpenLog then
            print("WaitCorrectServer")
        end
        if CS.CSDebug.developerConsoleVisible then
            CS.UnityEngine.Debug.LogWarning("================================================================" .. UILoginPanel.www.text)
        end
        local tempReq = CS.ServerCorectResponse.Parse(UILoginPanel.www.text)
        local constant = CS.Constant
        constant.UserID_Game = tempReq.loginName
        constant.GameServerSign = tempReq.sign
        constant.time = tempReq.time
        constant.LoginToken_Game = tempReq.token

        CS.UnityEngine.PlayerPrefs.SetString("userName", constant.UserID_Game)
        --校验完成后,请求服务器列表
        UILoginPanel.RequestData()
    end
    UILoginPanel.isStart = false
    UILoginPanel.www:Dispose()
    UILoginPanel.www = nil
end
--endregion

---8. 正式连接网络,一段时间后判定连接失败时显示连接失败提示
function UILoginPanel.ConnectNetwork(errorTip)
    if CS.ExtendTableLoader.IsCompletePreloading == false and CS.TableLoader.Instance.CurLoadProgress ~= 1 then
        if (UILoginPanel.IEnumLoadTableCoroutine ~= nil) then
            StopCoroutine(UILoginPanel.IEnumLoadTableCoroutine)
        end
        UILoginPanel.IEnumLoadTableCoroutine = StartCoroutine(UILoginPanel.IEnumLoadTableFunction, errorTip)
        return
    end
    if isOpenLog then
        print(CS.Constant.host)
        print(CS.Constant.gamePort)
    end
    if (CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor) and CS.Top_CSGame.Sington._IsUsePortAndIP then
        CS.Constant.gamePort = CS.Top_CSGame.Sington.Port
        CS.Constant.host = CS.Top_CSGame.Sington.IP
    end
    CS.CSNetwork.Instance:Connect(CS.Constant.host, CS.Constant.gamePort)
    --    CS.CSNetwork.Instance:Connect("47.103.64.190", 9130)
    StopCoroutine(UILoginPanel.linkCoroutine)
    UILoginPanel.linkCoroutine = StartCoroutine(UILoginPanel.IEnumLinkFailTips, errorTip)
end

function UILoginPanel.IEnumLoadTableFunction(tips)
    if (CS.TableLoader.Instance.CurLoadProgress ~= 1) then
        coroutine.yield(CS.NGUIAssist.waitForEndOfFrame)
    end
    UILoginPanel.ConnectNetwork(tips);
end

function UILoginPanel.OnConnectNetwork(id, data)
    UILoginPanel.ConnectNetwork("连接失败 服务器链接超时2")
end

function UILoginPanel.CreateInvitationCodeInterface(data)
    uiStaticParameter.inputInvitationCode = ''
    if (data == nil or data.flag == nil or data.flag ~= 1) then
        return
    end
    ---@param panel UIPromptInviteCodeInputPanel
    uimanager:CreatePanel("UIPromptInviteCodeInputPanel", nil)
end

--region message
---9 服务器TCP链接成功,网络消息回调
function UILoginPanel.OnLoginSucceed(uiEvtID, data)
    if isOpenLog then
        print("服务器TCP链接成功,网络消息回调")
    end
    local constant = CS.Constant
    local isNullOrEmpty = CS.System.String.IsNullOrEmpty
    CS.UnityEngine.PlayerPrefs.SetInt(CS.HttpRequest.Instance.ServerFile.ServerIdKey, UILoginPanel.mServerIndex)
    --当前选中的服务器ID
    constant.mSeverId = UILoginPanel.mServerIndex
    if isNullOrEmpty(constant.UserID_Game) then
        CS.Utility.ShowTips("账号异常!!!")
        return
    end
    str = constant.UserID_Game
    if (CS.SDKManager.PlatformData:GetPlatformData() == nil) then
        CS.Utility.ShowTips("配置数据异常!!!")
    end

    if isOpenLog then
        print("constant.GameServerSign:" .. constant.GameServerSign)
        print("constant.time:" .. constant.time)
    end

    CS.NetV2.ReqLoginMessage_Extend(constant.UserID_Game, constant.platformid, constant.mSeverId, constant.GameServerSign, constant.time, "", 0, CS.CSServerFile.ClientRegionID)
    CS.HttpRequest.Instance:Stop()

    --登入成功了,开始进行一些预加载的资源
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_burndissolvetex", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_burnramp", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_burndissolvetex", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_maintex", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_stonedissolvetex", CS.ResourceType.Texture, null, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_stonetex", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
    CS.CSResourceManager.Instance:AddQueueCannotDelete("_stonetex2", CS.ResourceType.Texture, nil, CS.ResourceAssistType.Player);
end

---10.  登录成功,之前已经有角色了网络消息回调
function UILoginPanel.OnResLoginMessage(uiEvtID, data)
    if isOpenLog then
        print("登录成功,之前已经有角色了网络消息回调-请求角色列表")
    end
    --请求角色列表
    CS.UserManager.Instance:InitRoleList(protobufMgr.DecodeTable.user.ResLogin(data))
    UILoginPanel.OpenCamera();
    UILoginPanel.CloseLoginPanel()
    --uimanager:CreatePanel("UILoginRolePanel", nil)

    UILoginPanel.CreateUILoginRolePanelEvent = CS.ListUpdateItem(0, nil, function()
        uimanager:CreatePanel("UILoginRolePanel", nil)
    end, false)
    CS.CSListUpdateMgr.Instance:Add(UILoginPanel.CreateUILoginRolePanelEvent)

    CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.SelectServer);
end

---10. 登入成功,但是之前没有角色,需要去创建
function UILoginPanel.OnResCreateRoleMessage(uiEvtID, data)
    if isOpenLog then
        print("登录成功,但是之前没有角色,需要去创建")
    end
    CS.UserManager.Instance:Clear()
    UILoginPanel.OpenCamera();
    UILoginPanel.CloseLoginPanel()
    --uimanager:CreatePanel("UILoginRolePanel", nil)
    UILoginPanel.CreateUILoginRolePanelEvent = CS.ListUpdateItem(0, nil, function()
        uimanager:CreatePanel("UILoginRolePanel", nil)
    end, false)
    CS.CSListUpdateMgr.Instance:Add(UILoginPanel.CreateUILoginRolePanelEvent)
    CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.SelectServer);

    CS.GameDataSubmit.Instance:SendDataByInt(CS.EGameDataAction.MobileData, CS.ESendDataType.EnterCreateRole);
    UILoginPanel.CreateInvitationCodeInterface(data)
end

function UILoginPanel.OpenCamera()
    if (CS.CSGame.Sington == nil or CS.CSGame.Sington.CurrentState == nil) then
        return
    end
    CS.CSGame.Sington.CurrentState:CloseAllLight();
    if (CS.CSGame.Sington.CurrentState.SceneCamera == nil) then
        CS.UnityEngine.Debug.LogError("登入场景没有挂载场景摄像机")
    else
        CS.CSGame.Sington.CurrentState.SceneCamera.gameObject:SetActive(true);
    end
end

---10  登录失败网络消息回调
function UILoginPanel.OnLoginFail(uiEvtID, data)
    if isOpenLog then
        print("登录失败网络消息回调")
    end

    if UILoginPanel.go.activeInHierarchy then
        --CS.Utility.ShowCenterInfo("网络不可用,请稍后再重试!");
        uimanager:ClosePanelInCS(typeof(CS.UIWaiting))
    end
end

---刷新登录状态客户端事件回调
function UILoginPanel.OnUpdateLoginState(uiEvtID, data)
    if isOpenLog then
        print("刷新登录状态客户端事件回调")
    end
    --print("OnUpdateLoginState")
    local dataTable = tostring(data):Split(": ", true)
    local t = dataTable[2]
    --enum:
    --exception = 1
    --success = 2
    --update = 3
    if t ~= nil then
        if t == '2' then
            UILoginPanel.GetLoginViewGameObject():SetActive(false)
            UILoginPanel.GetServerViewGameObject():SetActive(true)
            UILoginPanel.SetDefaultServer()
            UILoginPanel.RefreshAddressInfo()
            --登入服务器成功,请求账号后台数据
            CS.HttpRequest.Instance.ServerFile:ReqBackGroundData()
        end
        if t ~= '3' then
            uimanager:ClosePanelInCS(typeof(CS.UIWaiting))
        end
    end
end

---刷新所选择的服务器事件回调
function UILoginPanel.OnUpdateSelectedServer(uiEvtID, ServerItemData)
    if isOpenLog then
        print("刷新所选择的服务器事件回调")
    end
    --print("OnUpdateSelectedServer")
    if ServerItemData == nil then
        return
    end
    UILoginPanel.list = ServerItemData
    UILoginPanel.mServerIndex = ServerItemData.ServerID
    UILoginPanel.RefreshAddressInfo()
end
--endregion

--region uievents

---选择服务器按钮点击事件
function UILoginPanel.OnClickBtn_ChooseServer(go)
    if isOpenLog then
        print("选择服务器按钮点击事件")
    end
    uimanager:CreatePanel('UIServerListPanel')
    UILoginPanel.ControlServerListRelevancePanel(false)
end

---协议按钮点击事件
function UILoginPanel.OnClickBtn_XY(go)
    uimanager:CreatePanel("UIAgreementPanel")
end

---公告按钮点击事件
function UILoginPanel.OnClickBtn_Notice(go)
    uimanager:CreatePanel("UIOfficialNoticePanel")
end

---切换账户按钮点击事件
function UILoginPanel.OnClickBtn_ChangeAccount(go)
    if isOpenLog then
        print("切换账户按钮点击事件")
    end
    --print("ChangeAccount")
    uimanager:CloseAllPanel()

    --CS.HttpRequest.Instance:Stop();
    --CS.Constant.mSeverId = 0;
    --CS.CSNetwork.Instance:Close();
    --CS.CSGame.Sington:ClearBeforeLeaveGame()
    --
    ----CS.SDKManager.GameInterface:LogoutAccount()
    --
    --uimanager:CreatePanel("UILoginPanel", nil)
    if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
        clientMessageDeal.OnReturnLogin(false)
    else
        if (CS.SDKManager.GameInterface:GetCommonLibVersion() == 2) then
            clientMessageDeal.OnReturnLogin(false)
        else
            CS.SDKManager.GameInterface:ChangeAccount()
        end
    end

    --if (CS.SDKManager.PlatformData:GetPlatformData().submitData) then
    --    CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.QuitAcount)
    --end
end

function UILoginPanel.OnClickRepairGameObject()
    uimanager:CreatePanel("UIHotRepairPanel")
end

function UILoginPanel.OnClickLBVersionUILabel(go)
    if (CS.Constant.IsWhiteIp or CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor) then
        uimanager:CreatePanel("UIGMToolPanel")
    end
end
--endregion

--region update
---C#的Update中每帧执行
function update()
    UILoginPanel.WaitCorrectServer()
end


--region coroutine
---连接失败协程
function UILoginPanel.IEnumLinkFailTips(tips)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UILoginPanel.linkMaxTime))
    CS.Utility.ShowRedTips(tips)
    CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.ConnectServerFail)
    uimanager.ClosePanelInCS(typeof(CS.UIWaiting))
    if UILoginPanel.GetServerIPUILabel() ~= nil then
        CS.UnityEngine.Debug.LogError(CS.Constant.UserID_Game .. " " .. UILoginPanel.GetServerIPUILabel().text .. " " ..
                tips .. " 登入不了本服 Server= " .. " ipFromClient = " .. CS.Constant.host ..
                " portFromClient=" .. CS.Constant.gamePort)
    end
end
--endregion

--region methods


---设置默认选择服务器
function UILoginPanel.SetDefaultServer()
    --print("SetDefaultServer")
    local recommendobj = CS.HttpRequest.Instance.ServerFile.RecommendServerId
    --推荐服务器
    UILoginPanel.mRecommendServerIndex = tonumber(recommendobj)
    --上次登入服务器
    if CS.UnityEngine.PlayerPrefs.HasKey(CS.HttpRequest.Instance.ServerFile.ServerIdKey) then
        UILoginPanel.mServerIndex = CS.UnityEngine.PlayerPrefs.GetInt(CS.HttpRequest.Instance.ServerFile.ServerIdKey)
    end
    if isOpenLog then
        print("上次登录的服务器id", UILoginPanel.mServerIndex)
        print("推荐服务器id", UILoginPanel.mRecommendServerIndex)
    end
    --如果没有上次登入服务器,进入推荐服务器
    if UILoginPanel.mServerIndex <= 0 then
        UILoginPanel.mServerIndex = UILoginPanel.mRecommendServerIndex
    end
end

---刷新地址信息
function UILoginPanel.RefreshAddressInfo()
    --print("RefreshAddressInfo")
    UILoginPanel.ServerItem = UILoginPanel.GetAddress(UILoginPanel.mServerIndex)
    if UILoginPanel.ServerItem == nil or UILoginPanel.GetServerIPUILabel() == nil then
        return
    end
    local go = UILoginPanel.GetServerIPUILabel().gameObject

    local state = UILoginPanel.ServerItem.State
    CS.Utility_Lua.Get(go.transform, "Sprite", "UISprite").spriteName = CS.Utility.GetServerStateSpriteName(state)

    local isShowTex = state == LuaEnumServerState.NewServer-- or state == LuaEnumServerState.Full
    local isShowRecommend = UILoginPanel.ServerItem.ServerID == UILoginPanel:GetRecommendServerID()
    ---@type UISprite 新
    local tex = CS.Utility_Lua.Get(go.transform, "tex", "UISprite")
    tex.spriteName = UILoginPanel.StateSprite[state]
    tex.gameObject:SetActive(isShowTex and not isShowRecommend)
    ---@type UnityEngine.GameObject 推荐
    local recommend = CS.Utility_Lua.Get(go.transform, "recommend", "GameObject")
    recommend:SetActive(isShowRecommend)

    tex:ResetAnchors()
    UILoginPanel.GetServerIPUILabel().text = UILoginPanel.ServerItem.ServerName
    --CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.MobileData, "3");
end

---@return CSServerItem 获取服务器ID对应的服务器信息
function UILoginPanel.GetAddress(_id)
    return CS.HttpRequest.Instance.ServerFile:GetServerItem(_id);
end

---关闭登录界面
function UILoginPanel.CloseLoginPanel()
    -- uimanager:ClosePanelInCS(typeof(CS.UIServerListPanel))
    uimanager:ClosePanel('UIServerListPanel')
    uimanager:ClosePanelInCS(typeof(CS.UIWaiting))
    uimanager:ClosePanel("UILoginPanel")
    StopCoroutine(UILoginPanel.linkCoroutine)
end

---控制服务器列表关联面板
function UILoginPanel.ControlServerListRelevancePanel(state)
    UILoginPanel.GetEnterBtnGameGameObject():SetActive(state)
    UILoginPanel.GetServerIPUILabel().gameObject:SetActive(state)
    UILoginPanel.GetChooseServerBtnGameObject():SetActive(state)
end
--endregion

--region LoadLogo
function UILoginPanel.LoadLogo()
    local gameName = "rxzg"
    local loadLogoName = "";
    local loadBgName = "";
    if CS.SDKManager.PlatformData:GetPlatformData() ~= nil then
        gameName = CS.SDKManager.PlatformData:GetPlatformData().gameName

        --判定是否使用游戏自身的logo以及背景   PS:APK会自己将更新界面的bg以及logo拷贝到apk_loading_bg上面
        if (CS.SDKManager.PlatformData:GetPlatformData().IsUseApkLoginBg) then
            loadBgName = "apk_loading_bg.jpg";
            UILoginPanel.GetBGEffectGameObject():SetActive(false)
        end
        if (CS.SDKManager.PlatformData:GetPlatformData().IsUseApkLoginLogo) then
            loadLogoName = "apk_logo.png";
        end
    end

    --region 加载版号描述（CS.Utility_Lua.LoadFinishText）
    local isPass = CS.UnityEngine.PlayerPrefs.GetString("IsPassUserAgreement")
    if (isPass ~= nil and isPass == "true") then
        UILoginPanel.IsPassUserAgreement = true
        UILoginPanel.GetLoginplayerInfo_toggle():Set(true)
    else
        local filePath = ''
        local fileName = 'PrivacyProtection.txt'

        if (isUnityEditor) then
            filePath = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath)
        else
            filePath = CS.CSStaticAssist.persistentDataPath
        end
        filePath = filePath .. CS.CSResource.GetModelTypePath(CS.ResourceType.Picture) .. fileName;
        local text = UILoginPanel.ReadFile(filePath)
        ---如果没有隐私协议或内容为空，则隐藏掉
        if (CS.System.String.IsNullOrEmpty(text)) then
            UILoginPanel.IsPassUserAgreement = true
            UILoginPanel.GetLoginplayerInfo_GameObject():SetActive(false)
        else
            UILoginPanel.GetLoginplayerInfo_GameObject():SetActive(true)
        end
    end


    --endregion

    ---加载logo
    local isLogoLoaded = false

    if ("XY" == CS.SDKManager.PlatformData.PlatformName) then
        UILoginPanel.GetLogoLoader():Load(loadLogoName, "nhyd.png")
    else
        UILoginPanel.GetLogoLoader():Load(loadLogoName, "logo.png")
    end

    local banhaoText=UILoginPanel.GetBanHaoDes()
    if (CS.System.String.IsNullOrEmpty(banhaoText))==false then
        UILoginPanel.GetBanHao_UILabel().text =banhaoText
    end

    ---回调绑定
    UILoginPanel.GetLogoLoader().loadedCallBack = function(name)
        isLogoLoaded = true
        if isLogoLoaded and isJiazaiLoaded then
            CS.CSGame.Sington:EnterGame();
        end
    end

    ---加载jiazai
    local isJiazaiLoaded = false
    UILoginPanel.GetJiazaiLoader():Load(loadBgName, "jiazai.jpg")

    ---回调绑定
    UILoginPanel.GetJiazaiLoader().loadedCallBack = function(name)
        isJiazaiLoaded = true
        if isLogoLoaded and isJiazaiLoaded then
            CS.CSGame.Sington:EnterGame();
        end
    end

    --CS.CSResourceManager.Singleton:AddQueueCannotDelete(logoName_Prefix .. gameName, CS.ResourceType.UIEffect, function(res)
    --    if res and res.MirrorObj and UILoginPanel.GetLogoUITexture() ~= nil then
    --        UILoginPanel.GetLogoUITexture().mainTexture = res.MirrorObj
    --        UILoginPanel.GetLogoUITexture():MakePixelPerfect();
    --        UILoginPanel.GetLogoUITexture().gameObject:SetActive(true);
    --    end
    --end
    --, CS.ResourceAssistType.ForceLoad)
end

function UILoginPanel.ReadFile(fileName)
    local f = io.open(fileName, 'r')
    if (f == nil) then
        CS.UnityEngine.Debug.Log("文件路径不存在:" .. tostring(fileName))
        return ""
    else
        local content = f:read('*all')
        f:close()
        return content
    end
end

--endregion

function UILoginPanel.LoadHot()
    if Utility.IsOpenFrontHotLoad == true then
        if CS.SDKManager.GameInterface ~= nil and CS.SDKManager.GameInterface:GetResUnzipProcess() == CS.ESDKResUnzipProcess.Finish then
            if CS.CSResUpdateMgr.Instance ~= nil then
                CS.CSResUpdateMgr.Instance:AddGamingDownloadUpdateResource();
            end
        end
    end
end

function UILoginPanel.GetBanHaoDes()
    local banhaoPath = "";
    local banhaoname = "banHao_" .. CS.SDKManager.PlatformData:GetPlatformData().HomePlatformID .. ".txt";
    if (isUnityEditor) then
        banhaoPath = CS.CSEditorPath.Get(CS.EEditorPath.LocalResourcesLoadPath)
    else
        banhaoPath = CS.CSStaticAssist.persistentDataPath..'/'
    end
    local nowbanhaoPath = banhaoPath .. CS.CSResource.GetModelTypePath(CS.ResourceType.Picture) .. banhaoname;
    local file = io.open(nowbanhaoPath, 'r')
    if file == nil then
        nowbanhaoPath = banhaoPath .. CS.CSResource.GetModelTypePath(CS.ResourceType.Picture) .. "banHao.txt";
    end
    local text = UILoginPanel.ReadFile(nowbanhaoPath)
    if file~=nil then
        io.close(file)
    end
    return text
end

--region destroy
function ondestroy()
    --print("ondestroy")
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ConnectSuccessMessage, UILoginPanel.OnLoginSucceed)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ConnectFailedMessage, UILoginPanel.OnLoginFail)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResCreateRoleMessage, UILoginPanel.OnResCreateRoleMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLoginMessage, UILoginPanel.OnResLoginMessage)
    StopCoroutine(UILoginPanel.linkCoroutine)
    if UILoginPanel.ReleaseClientEventHandler ~= nil then
        UILoginPanel:ReleaseClientEventHandler()
    end
    if UILoginPanel.ReleaseSocketEventHandler ~= nil then
        UILoginPanel:ReleaseSocketEventHandler()
    end
    if CS.CSAudioMgr.Instance then
        CS.CSAudioMgr.Instance:RemoveAllAudio()
    end
end
--endregion



return UILoginPanel