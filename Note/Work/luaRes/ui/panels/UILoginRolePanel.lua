---登录选角界面
local UILoginRolePanel = {}

--region parameters
UILoginRolePanel.mNewSpineDic = {}
UILoginRolePanel.mNewSpineEffectDic = {}
UILoginRolePanel.mCurNewSpine = nil
UILoginRolePanel.mCurNewSpineEffect = nil
UILoginRolePanel.rolePath = ""
UILoginRolePanel.roleTexPath = ""
UILoginRolePanel.resPathList = {}
UILoginRolePanel.careerTexPath = ""
UILoginRolePanel.mCurType = CS.LoginOpenType.UIRoleList
UILoginRolePanel.time = 150
UILoginRolePanel.curRoleInfo = nil
UILoginRolePanel.mCurInfoCtrl = nil
UILoginRolePanel.selectSex = LuaEnumSex.Common
UILoginRolePanel.mSelectedCareer = LuaEnumCareer.Common
UILoginRolePanel.isEnteringGame = false
UILoginRolePanel.ipFromClient = ""
UILoginRolePanel.portFromClient = 0
UILoginRolePanel.curServerID = 0
UILoginRolePanel.isKuaFu = false
UILoginRolePanel.modelFileName = ""
UILoginRolePanel.effectFileName = ""
UILoginRolePanel.openMapID_AfterEnterScene = 0

--simulate update parameters
UILoginRolePanel.EnterFailTimeInterval1 = 5
UILoginRolePanel.EnterFailTimeInterval2 = 5
UILoginRolePanel.EnterFailCoroutine = nil

UILoginRolePanel.mInfoCtrlList = nil;

--region 位移动画相关
---职业模型字典
UILoginRolePanel.mObservation3DModelDic = {};

---默认职业对应的位置索引字典
UILoginRolePanel.mCareerIndexDic = {};

---索引对应位置的字典
UILoginRolePanel.mPositionDic = {};

---模型展示类字典
UILoginRolePanel.m3DModelTweenPosDic = {};

---当前处于屏幕中间的职业
UILoginRolePanel.mCurrentCareer = nil;
--endregion

--endregion
---特效id
local effectIds = {};
effectIds.chooseRoleEffectId = "700177";
effectIds[LuaEnumCareer.Warrior] = "700013";
effectIds[LuaEnumCareer.Master] = "700014";
effectIds[LuaEnumCareer.Taoist] = "700015";


--region components
function UILoginRolePanel.GetRoleNameUIInput()
    if UILoginRolePanel.mRoleName_UIInput == nil then
        UILoginRolePanel.mRoleName_UIInput = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/RightWidget/rolename", "UIInput")
    end
    return UILoginRolePanel.mRoleName_UIInput
end

function UILoginRolePanel.GetTX_Career_UITexture()
    if UILoginRolePanel.mTX_Career_UITexture == nil then
        UILoginRolePanel.mTX_Career_UITexture = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/RightWidget/tx_career", "UITexture")
    end
    return UILoginRolePanel.mTX_Career_UITexture
end

function UILoginRolePanel.GetCareerGrid_Transform()
    if UILoginRolePanel.mCareerGrid_Transform == nil then
        UILoginRolePanel.mCareerGrid_Transform = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/career", "Transform")
    end
    return UILoginRolePanel.mCareerGrid_Transform
end

function UILoginRolePanel.GetSexGrid_Transform()
    if UILoginRolePanel.mSexGrid_Transform == nil then
        UILoginRolePanel.mSexGrid_Transform = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex", "Transform")
    end
    return UILoginRolePanel.mSexGrid_Transform
end

function UILoginRolePanel.GetWoman_UIToggle()
    if UILoginRolePanel.mWoman_UIToggle == nil then
        UILoginRolePanel.mWoman_UIToggle = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/woman", "UIToggle")
    end
    return UILoginRolePanel.mWoman_UIToggle
end

function UILoginRolePanel.GetMan_UIToggle()
    if UILoginRolePanel.mMan_UIToggle == nil then
        UILoginRolePanel.mMan_UIToggle = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/man", "UIToggle")
    end
    return UILoginRolePanel.mMan_UIToggle
end

function UILoginRolePanel.GetTex_Role_UITexture()
    if UILoginRolePanel.mTex_Role_UITexture == nil then
        UILoginRolePanel.mTex_Role_UITexture = UILoginRolePanel:GetCurComp("WidgetRoot/window/roleSprite", "UITexture")
    end
    return UILoginRolePanel.mTex_Role_UITexture
end

function UILoginRolePanel.GetRoleEffect_UISprite()
    if UILoginRolePanel.mRoleEffect_UISprite == nil then
        UILoginRolePanel.mRoleEffect_UISprite = UILoginRolePanel:GetCurComp("WidgetRoot/window/roleSprite/roleeffect", "UISprite")
    end
    return UILoginRolePanel.mRoleEffect_UISprite
end

function UILoginRolePanel.Get3DModelRoot_Transform()
    if UILoginRolePanel.m3DModelRoot_Trans == nil then
        UILoginRolePanel.m3DModelRoot_Trans = UILoginRolePanel:GetCurComp("WidgetRoot/window/3DModelRoot", "Transform")
    end
    return UILoginRolePanel.m3DModelRoot_Trans
end

function UILoginRolePanel.GetRoleListGrid_Transform()
    if UILoginRolePanel.mRoleListGrid_Transform == nil then
        UILoginRolePanel.mRoleListGrid_Transform = UILoginRolePanel:GetCurComp("WidgetRoot/roleListView/grid", "Transform")
    end
    return UILoginRolePanel.mRoleListGrid_Transform
end

function UILoginRolePanel.GetCreateRoleView_GameObject()
    if UILoginRolePanel.mCreateRoleView_GameObject == nil then
        UILoginRolePanel.mCreateRoleView_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView", "GameObject")
    end
    return UILoginRolePanel.mCreateRoleView_GameObject
end

function UILoginRolePanel.GetRoleListView_GameObject()
    if UILoginRolePanel.mRoleListView_GameObject == nil then
        UILoginRolePanel.mRoleListView_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/roleListView", "GameObject")
    end
    return UILoginRolePanel.mRoleListView_GameObject
end

function UILoginRolePanel.GetWaiting_GameObject()
    if UILoginRolePanel.mWaiting_GameObject == nil then
        UILoginRolePanel.mWaiting_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/waiting", "GameObject")
    end
    return UILoginRolePanel.mWaiting_GameObject
end

function UILoginRolePanel.GetBtn_EnterGame_GameObject()
    if UILoginRolePanel.mBtn_EnterGame_GameObject == nil then
        UILoginRolePanel.mBtn_EnterGame_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/events/btn_enter", "GameObject")
    end
    return UILoginRolePanel.mBtn_EnterGame_GameObject
end

function UILoginRolePanel.GetBtn_BackLogin_GameObject()
    if UILoginRolePanel.mBtn_BackLogin_GameObject == nil then
        UILoginRolePanel.mBtn_BackLogin_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/events/btn_back", "GameObject")
    end
    return UILoginRolePanel.mBtn_BackLogin_GameObject
end

function UILoginRolePanel.GetBtn_RandomName_GameObject()
    if UILoginRolePanel.mBtn_RandomName_GameObject == nil then
        UILoginRolePanel.mBtn_RandomName_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/RightWidget/btn_random", "GameObject")
    end
    return UILoginRolePanel.mBtn_RandomName_GameObject
end

function UILoginRolePanel.GetBtn_SelectSex_Man_GameObject()
    if UILoginRolePanel.mBtn_SelectSex_Man_GameObject == nil then
        UILoginRolePanel.mBtn_SelectSex_Man_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/man", "GameObject")
    end
    return UILoginRolePanel.mBtn_SelectSex_Man_GameObject
end

function UILoginRolePanel.GetBtn_SelectSex_Woman_GameObject()
    if UILoginRolePanel.mBtn_SelectSex_Woman_GameObject == nil then
        UILoginRolePanel.mBtn_SelectSex_Woman_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/woman", "GameObject")
    end
    return UILoginRolePanel.mBtn_SelectSex_Woman_GameObject
end

function UILoginRolePanel.GetBtn_delete_GameObject()
    if (UILoginRolePanel.mBtn_delete_GameObject == nil) then
        UILoginRolePanel.mBtn_delete_GameObject = UILoginRolePanel:GetCurComp("WidgetRoot/events/btn_delete", "GameObject")
    end
    return UILoginRolePanel.mBtn_delete_GameObject;
end

function UILoginRolePanel.GetBtn_EnterGame_Text()
    if UILoginRolePanel.mBtn_EnterGame_Text == nil then
        UILoginRolePanel.mBtn_EnterGame_Text = UILoginRolePanel:GetCurComp("WidgetRoot/events/btn_enter/Label", "UILabel")
    end
    return UILoginRolePanel.mBtn_EnterGame_Text
end

function UILoginRolePanel.GetSexMan_Text()
    if (UILoginRolePanel.mSexMan_Text == nil) then
        UILoginRolePanel.mSexMan_Text = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/man/name", "UILabel");
    end
    return UILoginRolePanel.mSexMan_Text;
end

function UILoginRolePanel.GetSexWoman_Text()
    if (UILoginRolePanel.mSexWoman_Text == nil) then
        UILoginRolePanel.mSexWoman_Text = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/sex/woman/name", "UILabel");
    end
    return UILoginRolePanel.mSexWoman_Text;
end

function UILoginRolePanel.GetSelectCareerSprite_UISprite()
    if UILoginRolePanel.mSelectCareerSprite_UISprite == nil then
        UILoginRolePanel.mSelectCareerSprite_UISprite = UILoginRolePanel:GetCurComp("WidgetRoot/createRoleView/RightWidget/careerSprite", "UISprite")
    end
    return UILoginRolePanel.mSelectCareerSprite_UISprite
end

function UILoginRolePanel.Get3DModelRootTweenPosition()
    if (UILoginRolePanel.m3DModelRootTweenPosition == nil) then
        if (UILoginRolePanel.CreateRoleCamera ~= nil) then
            UILoginRolePanel.m3DModelRootTweenPosition = CS.Utility_Lua.GetComponent(UILoginRolePanel.CreateRoleCamera, "TweenPosition");
            if (UILoginRolePanel.m3DModelRootTweenPosition == nil) then
                UILoginRolePanel.m3DModelRootTweenPosition = UILoginRolePanel.CreateRoleCamera:AddComponent(typeof(CS.TweenPosition));
                UILoginRolePanel.m3DModelRootTweenPosition.duration = 0.15;
            end
        end
    end
    return UILoginRolePanel.m3DModelRootTweenPosition;
end

function UILoginRolePanel:GetCameraAnimator()
    if (UILoginRolePanel.mGetCameraAnimator == nil and UILoginRolePanel.CreateRoleCamera ~= nil) then
        UILoginRolePanel.mGetCameraAnimator = CS.Utility_Lua.GetComponent(UILoginRolePanel.CreateRoleCamera.gameObject, "Animator");
    end
    return UILoginRolePanel.mGetCameraAnimator;
end


--endregion

--region init
---初始化,在uimanager.lua中被调用
function UILoginRolePanel:Init()
    UILoginRolePanel.InitScene();
    UILoginRolePanel.BindMessages()
    UILoginRolePanel.BindUIEvents()
    UILoginRolePanel.InitIndexAndPosition();
    UILoginRolePanel.PlayAudio()
    --强制关掉低血闪烁面板
    uimanager:ClosePanel('UISmallHpWarning')
    CS.CSGame.Sington.CurrentState:CloseAllLight();
    CS.CSNetwork.Instance:ReqHeartbeatMessage()
end

---初始化,在uimanager.lua中被调用
function UILoginRolePanel:Show()
    CS.UIWaiting.IsLoginRolePanel = true
    local getValueResult = false
    local tbl_sundry
    if getValueResult then
        getValueResult, UILoginRolePanel.time = CS.System.Int32.TryParse(tbl_sundry.effect_name)
        if getValueResult == false then
            UILoginRolePanel.time = 150
        end
    end
    if CS.UserManager.Instance.RoleCount <= 0 then
        UILoginRolePanel.mCurType = CS.LoginOpenType.UICreateRole
    else
        UILoginRolePanel.mCurType = CS.LoginOpenType.UIRoleList
    end
    UILoginRolePanel.ShowWithType(UILoginRolePanel.mCurType)

end

function UILoginRolePanel.InitIndexAndPosition()
    ---职业对应索引初始化(跟创角界面按钮顺序一致)
    UILoginRolePanel.mCareerIndexDic[LuaEnumCareer.Warrior] = 1;
    UILoginRolePanel.mCareerIndexDic[LuaEnumCareer.Master] = 2;
    UILoginRolePanel.mCareerIndexDic[LuaEnumCareer.Taoist] = 3;

    UILoginRolePanel.mPositionDic[1] = CS.UnityEngine.Vector3(0, 21, 1205);
    UILoginRolePanel.mPositionDic[2] = CS.UnityEngine.Vector3(2137, 21, 1205);
    UILoginRolePanel.mPositionDic[3] = CS.UnityEngine.Vector3(-2137, 21, 1205);
    ---索引对应坐标初始化
    --for k, v in pairs(UILoginRolePanel.mCareerIndexDic) do
    --    if(k == 1) then
    --
    --    end
    --    UILoginRolePanel.mPositionDic[v] = CS.UnityEngine.Vector3((v - 1) * 1000, -200, 1658);
    --end
end

function UILoginRolePanel.InitScene()
    ---如果到了登入角色界面,那么一定是返回登入了
    uiStaticParameter.firstEnterScene = true
    UILoginRolePanel.CreateRoleCamera = CS.CSGame.Sington.CurrentState.SceneCamera;
    if (UILoginRolePanel.CreateRoleCamera == nil) then
        CS.UnityEngine.Debug.LogError("登入场景没有挂载场景摄像机")
    else
        UILoginRolePanel.CreateRoleCamera.gameObject:SetActive(true);
    end
    --CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.MobileData, "10");
    --CS.CSResourceManager.Singleton:AddQueueCannotDelete("createcamera", CS.ResourceType.SceneUI, function(res)
    --    if UILoginRolePanel and UILoginRolePanel.go and CS.StaticUtility.IsNull(UILoginRolePanel.go) == false and res and res.MirrorObj then
    --        UILoginRolePanel.CreateRoleCamera = res:GetObjInst()
    --        if UILoginRolePanel.CreateRoleCamera then
    --            --UILoginRolePanel.CreateRoleCamera.transform.parent = UILoginRolePanel.go.transform;
    --            --UILoginRolePanel.CreateRoleCamera.transform.localPosition = CS.UnityEngine.Vector3(0, 423.25, 4325);
    --            --UILoginRolePanel.CreateRoleCamera.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 180, 0)
    --
    --            UILoginRolePanel.OnChooseRoleClick(UILoginRolePanel.GetRoleListGrid_Transform():GetChild(0).gameObject)
    --        end
    --    end
    --end
    --, CS.ResourceAssistType.UI)
end

---绑定消息
function UILoginRolePanel.BindMessages()
    UILoginRolePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRandomNameMessage, UILoginRolePanel.OnReceiveRandomRoleNameMessage)
    UILoginRolePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEnterGameMessage, UILoginRolePanel.OnResEnterGameMessage)
    UILoginRolePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLoginMessage, UILoginRolePanel.OnResLoginMessage)

    UILoginRolePanel:GetClientEventHandler():AddEvent(CS.CEvent.StartClientReconnect, UILoginRolePanel.OnStartClientReconnectMsgReceived)
    UILoginRolePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateUnzipProgress, UILoginRolePanel.OnUpdateUnzipProgress)
end

---绑定UI事件
function UILoginRolePanel.BindUIEvents()
    local UIEventListener = CS.UIEventListener
    UIEventListener.Get(UILoginRolePanel.GetBtn_EnterGame_GameObject()).onClick = UILoginRolePanel.OnClickBtn_EnterGame
    UIEventListener.Get(UILoginRolePanel.GetBtn_BackLogin_GameObject()).onClick = UILoginRolePanel.OnClickBtn_BackLogin
    UIEventListener.Get(UILoginRolePanel.GetBtn_RandomName_GameObject()).onClick = UILoginRolePanel.OnClickBtn_RandomName
    UIEventListener.Get(UILoginRolePanel.GetBtn_SelectSex_Man_GameObject(), LuaEnumSex.Man).onClick = UILoginRolePanel.OnClickBtn_SelectedSex
    UIEventListener.Get(UILoginRolePanel.GetBtn_SelectSex_Woman_GameObject(), LuaEnumSex.WoMan).onClick = UILoginRolePanel.OnClickBtn_SelectedSex
    UIEventListener.Get(UILoginRolePanel:GetComp(UILoginRolePanel.GetCareerGrid_Transform(), "warrior", "GameObject"), LuaEnumCareer.Warrior).onClick = UILoginRolePanel.OnClickBtn_SelectCareer
    UIEventListener.Get(UILoginRolePanel:GetComp(UILoginRolePanel.GetCareerGrid_Transform(), "master", "GameObject"), LuaEnumCareer.Master).onClick = UILoginRolePanel.OnClickBtn_SelectCareer
    UIEventListener.Get(UILoginRolePanel:GetComp(UILoginRolePanel.GetCareerGrid_Transform(), "daoshi", "GameObject"), LuaEnumCareer.Taoist).onClick = UILoginRolePanel.OnClickBtn_SelectCareer
    --UIEventListener.Get(UILoginRolePanel:GetComp(UILoginRolePanel.GetCareerGrid_Transform(), "assassin", "GameObject"), LuaEnumCareer.Assassin).onClick = UILoginRolePanel.OnClickBtn_SelectCareer
    UIEventListener.Get(UILoginRolePanel.GetBtn_delete_GameObject()).onClick = function()
        if (UILoginRolePanel.curRoleInfo ~= nil) then
            UILoginRolePanel.OnRemoveRoleClick(UILoginRolePanel.curRoleInfo.roleId);
        end
    end
end
--endregion

--region message
---接收到随机角色名网络消息回调
function UILoginRolePanel.OnReceiveRandomRoleNameMessage(uiEvtID, data)
    if data == nil then
        return
    end
    if UILoginRolePanel.GetRoleNameUIInput() == nil or data == nil then
        return
    end
    UILoginRolePanel.GetRoleNameUIInput().value = data.roleName
end

---进入游戏网络消息回调
function UILoginRolePanel.OnResEnterGameMessage(uiEvtID, data)
    uimanager.CloseAllPanel()

    --CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.MobileData, "5");
end

---登录网络消息回调
function UILoginRolePanel.OnResLoginMessage(uiEvtID, data)
    --print("UILoginRolePanel.OnResLoginMessage")
    if data == nil then
        return
    end
    local loginMsg = protobufMgr.DecodeTable.user.ResLogin(data)
    CS.UserManager.Instance:InitRoleList(loginMsg)
    if CS.UserManager.Instance.RoleCount <= 0 then
        UILoginRolePanel.ShowWithType(CS.LoginOpenType.UICreateRole)
    else
        UILoginRolePanel.ShowWithType(CS.LoginOpenType.UIRoleList)
    end
end

---解压进度客户端消息
function UILoginRolePanel.OnUpdateUnzipProgress(uiEvtID, data)
    --print("OnUpdateUnzipProgress")
    if data == nil then
        if CS.CSDebug.developerConsoleVisible then
            CS.CSDebug.Log("UnZip parameter error")
        end
        return
    end
    local resourceUnzipedIndex = tostring(data)
    --print("resourceUnzipedIndex:  " .. resourceUnzipedIndex)
    if
    ((CS.CSGameState.RunPlatform == CS.ERunPlatform.Android and resourceUnzipedIndex == "1") or
            (CS.CSGameState.RunPlatform == CS.ERunPlatform.IOS and resourceUnzipedIndex == "2"))
    then
        CS.SDKUtility.unzipFinish = true
        if UILoginRolePanel.GetWaiting_GameObject().activeInHierarchy then
            UILoginRolePanel.GetWaiting_GameObject():SetActive(false)
            UILoginRolePanel.EnterGame()
        end
    end
end

function UILoginRolePanel.OnStartClientReconnectMsgReceived(uiEvtID, data)
    --local constant = CS.Constant
    --CS.NetV2.ReqLoginMessage_Extend(constant.UserID_Game, constant.platformid, constant.mSeverId, constant.GameServerSign, constant.time)
end
--endregion

--region uievents
---进入游戏按钮点击事件
function UILoginRolePanel.OnClickBtn_EnterGame(go)
    UILoginRolePanel.EnterGame()
end

---返回登录按钮点击事件
function UILoginRolePanel.OnClickBtn_BackLogin(go)
    --print("OnClickBtn_BackLogin")
    if UILoginRolePanel.mCurType == CS.LoginOpenType.UICreateRole and CS.UserManager.Instance.RoleCount > 0 then
        UILoginRolePanel.ShowWithType(CS.LoginOpenType.UIRoleList)
    else
        Utility.OnClickBtn_BackLogin()
    end
end

---随机角色名按钮点击事件
function UILoginRolePanel.OnClickBtn_RandomName(go)
    --print("OnClickBtn_RandomName")
    --print(UILoginRolePanel.selectSex)
    networkRequest.ReqRandomName(UILoginRolePanel.selectSex)
    --CS.NetV2.ReqRandomNameMessage(UILoginRolePanel.selectSex)
end

---选择性别按钮点击事件
function UILoginRolePanel.OnClickBtn_SelectedSex(go)
    --print("OnClickBtn_SelectedSex")
    local sex = 0
    ___, sex = CS.System.Int32.TryParse(tostring(CS.UIEventListener.Get(go).parameter))
    if UILoginRolePanel.selectSex == sex then
        return
    end
    UILoginRolePanel:SetSelectSex(sex);
    UILoginRolePanel.Set3DModel(UILoginRolePanel.selectSex, UILoginRolePanel.mSelectedCareer)
end

---选择职业按钮点击事件
function UILoginRolePanel.OnClickBtn_SelectCareer(go)
    --print("OnClickBtn_SelectCareer")
    local career = CS.UIEventListener.Get(go).parameter
    if career == nil then
        return
    end
    if career == 0 then
        return
    end
    UILoginRolePanel.ChooseCareer(career);
end

function UILoginRolePanel.ChooseCareer(career)
    if (UILoginRolePanel.mSelectedCareer == career) then
        return
    end
    UILoginRolePanel.mSelectedCareer = career

    if UILoginRolePanel.GetCareerGrid_Transform() ~= nil then
        for i = 0, UILoginRolePanel.GetCareerGrid_Transform().childCount - 1 do
            local childTrans = UILoginRolePanel.GetCareerGrid_Transform():GetChild(i);
            if (childTrans ~= nil) then
                --region 职业选择不同状态
                if (UILoginRolePanel.mCareerToggleDic == nil) then
                    UILoginRolePanel.mCareerToggleDic = {};
                end

                if (UILoginRolePanel.mCareerNameTextDic == nil) then
                    UILoginRolePanel.mCareerNameTextDic = {};
                end

                if (UILoginRolePanel.mCareerIconSpriteDic == nil) then
                    UILoginRolePanel.mCareerIconSpriteDic = {};
                end
                ---职业按钮
                if (UILoginRolePanel.mCareerToggleDic[i] == nil) then
                    UILoginRolePanel.mCareerToggleDic[i] = CS.Utility_Lua.GetComponent(childTrans, "UIToggle");
                end
                ---职业名
                if (UILoginRolePanel.mCareerNameTextDic[i] == nil) then
                    local nameTrans = childTrans:Find("name");
                    if (nameTrans ~= nil) then
                        UILoginRolePanel.mCareerNameTextDic[i] = CS.Utility_Lua.GetComponent(nameTrans, "UILabel");
                    end
                end
                ---职业图标
                if (UILoginRolePanel.mCareerIconSpriteDic[i] == nil) then
                    local iconTrans = childTrans:Find("Background");
                    if (iconTrans ~= nil) then
                        UILoginRolePanel.mCareerIconSpriteDic[i] = CS.Utility_Lua.GetComponent(iconTrans, "UISprite");
                    end
                end

                local careerType = i + 1;
                local isSelected = careerType == UILoginRolePanel.mSelectedCareer;

                if (isSelected) then
                    local toggle = UILoginRolePanel.mCareerToggleDic[i];
                    if (toggle ~= nil) then
                        toggle.value = true;
                    end
                end

                local careerSprite = UILoginRolePanel.mCareerIconSpriteDic[i]
                if (careerSprite ~= nil) then
                    careerSprite.alpha = isSelected and 1 or 0.5;
                end

                local careerNameLabel = UILoginRolePanel.mCareerNameTextDic[i];
                if (careerNameLabel ~= nil) then
                    local colorStr = isSelected and luaEnumColorType.White or luaEnumColorType.Gray;
                    careerNameLabel.text = colorStr .. Utility.GetCareerName(careerType) .. "[-]";
                end
                --endregion
            end
        end
    end
    UILoginRolePanel.RefreshCareerIntroduceTex("career" .. tostring(career))
    UILoginRolePanel.Set3DModel(UILoginRolePanel.selectSex, UILoginRolePanel.mSelectedCareer)
    local spriteName = "";
    if (career == LuaEnumCareer.Warrior) then
        spriteName = "zhanshi"
    elseif (career == LuaEnumCareer.Master) then
        spriteName = "fashi"
    elseif (career == LuaEnumCareer.Taoist) then
        spriteName = "daoshi"
    end
    UILoginRolePanel.GetSelectCareerSprite_UISprite().spriteName = spriteName;
    --UILoginRolePanel.Get

    local target = UILoginRolePanel.GetCareerGrid_Transform():GetChild(UILoginRolePanel.mSelectedCareer - 1).gameObject;
    UILoginRolePanel.PlayChooseRoleEffect(target.transform.localPosition);
    UILoginRolePanel.PlayCareerEffect(career);
end

function UILoginRolePanel.SwitchLight(career)

    CS.CSGame.Sington.CurrentState:WaitSwitchLight(career, 0.4);

    --UILoginRolePanel.WarriorLoginLight = CS.CSGame.Sington.CurrentState.WarriorLoginLight;
    --if(UILoginRolePanel.WarriorLoginLight ~= nil) then
    --    UILoginRolePanel.WarriorLoginLight.gameObject:SetActive(career == LuaEnumCareer.Warrior);
    --end
    --UILoginRolePanel.MasterLoginLight = CS.CSGame.Sington.CurrentState.MasterLoginLight;
    --if(UILoginRolePanel.MasterLoginLight ~= nil) then
    --    UILoginRolePanel.MasterLoginLight.gameObject:SetActive(career == LuaEnumCareer.Master);
    --end
    --UILoginRolePanel.TaoistLoginLight = CS.CSGame.Sington.CurrentState.TaoistLoginLight;
    --if(UILoginRolePanel.TaoistLoginLight ~= nil) then
    --    UILoginRolePanel.TaoistLoginLight.gameObject:SetActive(career == LuaEnumCareer.Taoist);
    --end
end

---角色删除按钮点击事件
function UILoginRolePanel.OnRemoveRoleClick(roleId)
    --print("OnRemoveRoleClick")
    if roleId == nil then
        return
    end
    if roleId == 0 then
        CS.Utility.ShowTips("请选择需要删除的角色")
        return
    else
        local info = {}
        info.PromptWordId = 92
        info.ComfireAucion = function()
            networkRequest.ReqDelRole(roleId)
            local expanTable = {}
            expanTable["roleid"] = tostring(roleId)
            CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.QueryLogInName, "delete", expanTable);
        end
        Utility.ShowSecondConfirmPanel(info)

        --[[        uimanager:CreatePanel("UIPromptPanel", nil, {
                    --Title = "删除角色",
                    Content = "是否要删除角色",
                    CallBack = function()
                        networkRequest.ReqDelRole(roleId)
                        local expanTable = {}
                        expanTable["roleid"] = tostring(roleId)
                        CS.GameDataSubmit.Instance:SendData(CS.EGameDataAction.QueryLogInName, "delete", expanTable);
                    end
                })]]
    end
end

---角色选择按钮点击事件
function UILoginRolePanel.OnChooseRoleClick(obj)
    --print("OnChooseRoleClick")
    if obj == nil then
        return
    end

    if UILoginRolePanel.mCurInfoCtrl ~= nil then
        --UILoginRolePanel.mCurInfoCtrl.career.gameObject:SetActive(false)
        UILoginRolePanel.mCurInfoCtrl.mName_bg.gameObject:SetActive(false)
    end
    local data = CS.UIEventListener.Get(obj).parameter
    if data == UILoginRolePanel.curRoleInfo or data == nil then
        --做一次判重，避免重复点击
        return
    end
    UILoginRolePanel.curRoleInfo = data
    UILoginRolePanel.mCurInfoCtrl = CS.Utility_Lua.GetComponent(obj, "RoleInfoCtrl")
    UILoginRolePanel.mCurInfoCtrl.mName_bg.gameObject:SetActive(false)
    if (UILoginRolePanel.mInfoCtrlList ~= nil) then
        for k, v in pairs(UILoginRolePanel.mInfoCtrlList) do
            local data = nil;
            if (k < CS.UserManager.Instance:GetRoleList().Count) then
                data = CS.UserManager.Instance:GetRoleList()[k];
            end
            if (UILoginRolePanel.mCurInfoCtrl == v) then
                v.isChoose:SetActive(true);
                if (data ~= nil) then
                    v.mName.text = luaEnumColorType.White .. data.roleName .. "[-]";
                    v.mLevel.text = luaEnumColorType.White .. data.level .. "级[-]";
                    v.mName.color = LuaEnumUnityColorType.White
                    v.mLevel.color = LuaEnumUnityColorType.White
                    v.bg.color = LuaEnumUnityColorType.White
                end
            else
                v.isChoose:SetActive(false);
                if (data ~= nil) then
                    local color = CS.UnityEngine.Color(1, 1, 1, 140 / 255)
                    v.mName.text = luaEnumColorType.Gray .. data.roleName .. "[-]";
                    v.mLevel.text = luaEnumColorType.Gray .. data.level .. "级[-]";
                    v.mName.color = color
                    v.mLevel.color = color
                    v.bg.color = color
                end
            end
        end
    end
    --时装
    local weaponItemID = UILoginRolePanel.curRoleInfo.weapon
    local armorItemID = UILoginRolePanel.curRoleInfo.armor
    local helmetItemID = UILoginRolePanel.curRoleInfo.helmet
    local faceItemID = UILoginRolePanel.curRoleInfo.face
    local leftweapon = UILoginRolePanel.curRoleInfo.shield
    local douli = UILoginRolePanel.curRoleInfo.bambooHat
    if UILoginRolePanel.curRoleInfo.wearPosition and UILoginRolePanel.curRoleInfo.wearPosition.Count and UILoginRolePanel.curRoleInfo.wearPosition.Count > 0 then
        for i = 0, UILoginRolePanel.curRoleInfo.wearPosition.Count - 1 do
            local wearPosition = UILoginRolePanel.curRoleInfo.wearPosition[i]
            if wearPosition and wearPosition.index == LuaEnumAppearanceType.Weapon and wearPosition.id ~= 0 then
                weaponItemID = wearPosition.id
            end
            if wearPosition and wearPosition.index == LuaEnumAppearanceType.Clothes and wearPosition.id ~= 0 then
                armorItemID = wearPosition.id
            end
            if wearPosition and wearPosition.index == LuaEnumAppearanceType.Helmet and wearPosition.id ~= 0 then
                helmetItemID = wearPosition.id
            end
        end
    end
    UILoginRolePanel.Set3DModel(UILoginRolePanel.curRoleInfo.sex, UILoginRolePanel.curRoleInfo.career, weaponItemID, armorItemID, helmetItemID, faceItemID, douli, leftweapon, true)
end

---创建角色按钮点击事件
function UILoginRolePanel.OnCreateRoleClick(obj)
    --print("OnCreateRoleClick")
    UILoginRolePanel.ShowWithType(CS.LoginOpenType.UICreateRole)
end
--endregion

--region coroutines
---进入失败提示协程
function UILoginRolePanel.IEnumEnterFailTips(tips)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UILoginRolePanel.EnterFailTimeInterval1))
    if UILoginRolePanel.isKuaFu then
        CS.Utility.ShowRedTips(tips .. "，请过几分钟再试！")
    else
        CS.Utility.ShowRedTips(tips)
    end
    UILoginRolePanel.isEnteringGame = false
    if UILoginRolePanel.curRoleInfo ~= nil then
        local s
        if UILoginRolePanel.isKuaFu == true then
            s = "跨服"
        else
            s = "本服"
        end
        CS.UnityEngine.Debug.LogError(UILoginRolePanel.curRoleInfo.roleName .. " " .. tips .. " 登入不了服务器 " .. s .. " Server= "
                .. " ipFromClient = " .. tostring(UILoginRolePanel.ipFromClient) .. " portFromClient=" .. tostring(UILoginRolePanel.portFromClient) ..
                " curServerId=" .. tostring(UILoginRolePanel.curServerID) .. " Constant.mCurServer = " .. tostring(CS.Constant.mCurServer)
        )
        CS.Network.PrintString = ""
        CS.Network.PrintProperties(UILoginRolePanel.curRoleInfo, 1, CS.ELogToggleType.NormalLog, CS.ELogColorType.White, true
        )
        CS.Network.PrintString = s .. " " .. UILoginRolePanel.curRoleInfo.roleName .. " 登入不了服务器 " .. CS.Network.PrintString
        CS.UnityEngine.Debug.LogError(CS.Network.PrintString)
    end
    UILoginRolePanel.ReconnectGameServer()
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UILoginRolePanel.EnterFailTimeInterval2))
end
--endregion

--region methods
---根据输入的类型决定显示创角界面还是角色列表
---Type = UICreateRole  创角界面
---Type = UIRoleList    角色列表
function UILoginRolePanel.ShowWithType(showingType)
    --print("ShowWithType")
    UILoginRolePanel.mCurType = showingType
    local LoginOpenType = CS.LoginOpenType
    if showingType == LoginOpenType.UICreateRole then
        --创角界面
        if UILoginRolePanel.GetRoleListView_GameObject() ~= nil then
            UILoginRolePanel.GetRoleListView_GameObject():SetActive(false)
        end
        if UILoginRolePanel.GetCreateRoleView_GameObject() ~= nil then
            if UILoginRolePanel.GetCreateRoleView_GameObject().gameObject.activeSelf == false then
                UILoginRolePanel.GetCreateRoleView_GameObject():SetActive(true)
            end
            UILoginRolePanel.GetCreateRoleView_GameObject().transform.localPosition = CS.UnityEngine.Vector3.zero
            UILoginRolePanel.ShowRandomRoleInfo()
        end
        UILoginRolePanel.GetBtn_EnterGame_Text().text = "创建角色"
        UILoginRolePanel.GetBtn_delete_GameObject():SetActive(false);

        CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.EnterCreateRole);
    else
        if showingType == LoginOpenType.UIRoleList then
            UILoginRolePanel.mSelectedCareer = nil
            UILoginRolePanel:SetSelectSex(nil);
            --角色列表
            if UILoginRolePanel.GetCreateRoleView_GameObject() ~= nil then
                UILoginRolePanel.GetCreateRoleView_GameObject().transform.localPosition = CS.UnityEngine.Vector3(0, 10000, 0)
            end
            if UILoginRolePanel.GetRoleListView_GameObject() ~= nil then
                UILoginRolePanel.GetRoleListView_GameObject():SetActive(true)
                UILoginRolePanel.CreateRoleTemp(CS.UserManager.Instance:GetRoleList())
            end
            UILoginRolePanel.GetBtn_EnterGame_Text().text = "进入游戏"
            UILoginRolePanel.GetBtn_delete_GameObject():SetActive(true);
        end
    end
end

---播放音乐
function UILoginRolePanel.PlayAudio()
    if CS.CSAudioMgr.Instance ~= nil then
        local chooseCharactorId = CS.Cfg_GlobalTableManager.Instance.ChooseCharactorAudioId
        if chooseCharactorId and chooseCharactorId ~= -1 then
            CS.CSAudioMgr.Instance:Play(true, chooseCharactorId, 0, 1, true)
        end
    end
end

---随机一个创角信息
function UILoginRolePanel.ShowRandomRoleInfo()
    --print("ShowRandomRoleInfo")
    UILoginRolePanel.curRoleInfo = nil
    UILoginRolePanel:SetSelectSex(CS.Utility_Lua.UnityEngineRandom_Int32(1, 3));

    if UILoginRolePanel.GetSexGrid_Transform() ~= nil then
        CS.Utility_Lua.GetComponent(UILoginRolePanel.GetSexGrid_Transform():GetChild(UILoginRolePanel.selectSex - 1), "UIToggle").value = true
    end
    CS.NetV2.ReqRandomNameMessage(UILoginRolePanel.selectSex)
    UILoginRolePanel.ChooseCareer(CS.Utility_Lua.UnityEngineRandom_Int32(1, 4));
end

function UILoginRolePanel:SetSelectSex(sex)
    UILoginRolePanel.selectSex = sex;
    if (UILoginRolePanel.selectSex ~= nil) then
        if (UILoginRolePanel.selectSex == LuaEnumSex.Man) then
            UILoginRolePanel.GetSexMan_Text().text = luaEnumColorType.White .. "男[-]";
            UILoginRolePanel.GetSexWoman_Text().text = luaEnumColorType.Gray .. "女[-]";
        else
            UILoginRolePanel.GetSexMan_Text().text = luaEnumColorType.Gray .. "男[-]";
            UILoginRolePanel.GetSexWoman_Text().text = luaEnumColorType.White .. "女[-]";
        end
    end
end

---刷新职业介绍图片
function UILoginRolePanel.RefreshCareerIntroduceTex(careerTexPath)
    local resourceMgr = CS.CSResourceManager.Instance
    UILoginRolePanel.GetTX_Career_UITexture().gameObject:SetActive(false)
    if CS.System.String.IsNullOrEmpty(UILoginRolePanel.careerTexPath) ~= nil and resourceMgr ~= nil then
        resourceMgr:ForceDestroyResource(UILoginRolePanel.careerTexPath, false, true, true)
    end
    local res = resourceMgr:AddQueueCannotDelete(
            careerTexPath,
            CS.ResourceType.UIEffect,
            function(obj)
                if
                UILoginRolePanel == nil or UILoginRolePanel.go == nil or CS.StaticUtility.IsNull(UILoginRolePanel.go) or obj == nil or
                        obj.MirrorObj == nil
                then
                    return
                end
                local tex = obj.MirrorObj
                if tex ~= nil then
                    UILoginRolePanel.GetTX_Career_UITexture().gameObject:SetActive(true)
                    UILoginRolePanel.GetTX_Career_UITexture().mainTexture = tex
                    UILoginRolePanel.GetTX_Career_UITexture():MakePixelPerfect()
                end
            end,
            CS.ResourceAssistType.UI
    )
    UILoginRolePanel.careerTexPath = res.Path
end

---根据角色列表创建角色
function UILoginRolePanel.CreateRoleTemp(c_RoleList)
    --print("CreateRoleTemp")
    if UILoginRolePanel.GetRoleListGrid_Transform() == nil then
        return
    end
    --重新刷新置空当前选中
    UILoginRolePanel.mCurInfoCtrl = nil
    UILoginRolePanel.mInfoCtrlList = {};
    local count = UILoginRolePanel.GetRoleListGrid_Transform().childCount
    for i = 0, count - 1 do
        local temp = UILoginRolePanel.GetRoleListGrid_Transform():GetChild(i).gameObject
        local infoCtrl = CS.Utility_Lua.GetComponent(temp, "RoleInfoCtrl")
        if infoCtrl ~= nil then
            UILoginRolePanel.mInfoCtrlList[i] = infoCtrl;
            local hasPlayer = i < c_RoleList.Count and c_RoleList[i]
            --infoCtrl.career.gameObject:SetActive(not hasPlayer)
            if i < c_RoleList.Count and c_RoleList[i] ~= nil then
                local roledata = c_RoleList[i]
                infoCtrl.mName_bg.gameObject:SetActive(false)
                infoCtrl.mName.text = "[b6f1ff]" .. roledata.roleName
                infoCtrl.mLevel.text = tostring(roledata.level) .. "级"
                infoCtrl.AddRole:SetActive(false)
                infoCtrl.bg.spriteName = "headicon" .. roledata.sex .. roledata.career
                infoCtrl.bg:MakePixelPerfect()
                --CS.UIEventListener.Get(infoCtrl.isChoose, roledata.roleId).onClick = UILoginRolePanel.OnRemoveRoleClick
                CS.UIEventListener.Get(temp, roledata).onClick = UILoginRolePanel.OnChooseRoleClick
            else
                --没有角色,添加创建角色event
                infoCtrl.bg.spriteName = "wu"
                infoCtrl.bg:MakePixelPerfect()
                infoCtrl.mName_bg.gameObject:SetActive(false)
                infoCtrl.isChoose:SetActive(false)
                infoCtrl.mName.text = ""
                infoCtrl.mLevel.text = ""
                infoCtrl.AddRole:SetActive(true)
                CS.UIEventListener.Get(temp).onClick = UILoginRolePanel.OnCreateRoleClick
            end
        end
    end
    UILoginRolePanel.OnChooseRoleClick(UILoginRolePanel.GetRoleListGrid_Transform():GetChild(0).gameObject)
end

UILoginRolePanel.LastSelectCareer = 1
---根据职业和性别显示3D模型
function UILoginRolePanel.Set3DModel(sex, career, weapon, body, hair, face, douli, leftweapon, isPlayerList)

    if douli ~= 0 and douli ~= nil then
        hair = 0
    end
    if (UILoginRolePanel:GetCameraAnimator() ~= nil) then
        UILoginRolePanel:GetCameraAnimator():SetInteger("State", UILoginRolePanel.LastSelectCareer * 10 + career)
    end
    UILoginRolePanel.LastSelectCareer = career

    if (UILoginRolePanel.mObservation3DModelDic[career] == nil) then
        UILoginRolePanel.mObservation3DModelDic[career] = CS.ObservationModel();
    end
    UILoginRolePanel.mObservation3DModelDic[career]:ClearModel();
    if (isPlayerList ~= nil and isPlayerList == true) then
        UILoginRolePanel.mObservation3DModelDic[career]:SetShowMotion(CS.CSMotion.ShowStand)
        if not CS.StaticUtility.IsNull(UILoginRolePanel:Get3DModelRoot_Transform()) then
            UILoginRolePanel.mObservation3DModelDic[career]:CreateRoleModelByItem(
                    sex,
                    career,
                    body,
                    weapon,
                    hair,
                    face,
                    douli,
                    leftweapon, nil, UILoginRolePanel:Get3DModelRoot_Transform())
        end
    else
        if (career == 1) then
            UILoginRolePanel.mObservation3DModelDic[career]:SetShowMotion(CS.CSMotion.Show1)
        elseif (career == 2) then
            UILoginRolePanel.mObservation3DModelDic[career]:SetShowMotion(CS.CSMotion.Show2)
        elseif (career == 3) then
            UILoginRolePanel.mObservation3DModelDic[career]:SetShowMotion(CS.CSMotion.Show3)
        end
        UILoginRolePanel.mObservation3DModelDic[career]:CreateRoleModel(sex, career, UILoginRolePanel:Get3DModelRoot_Transform())
    end
    UILoginRolePanel.mObservation3DModelDic[career]:SetPosition(UILoginRolePanel.mPositionDic[UILoginRolePanel.mCareerIndexDic[career]]);
    UILoginRolePanel.mObservation3DModelDic[career]:SetRotation(CS.UnityEngine.Vector3(0, 0, 0))
    UILoginRolePanel.mObservation3DModelDic[career]:SetScaleSize(CS.UnityEngine.Vector3(375, 375, 375))
    UILoginRolePanel.mObservation3DModelDic[career]:SetDragRoot(UILoginRolePanel:Get3DModelRoot_Transform().gameObject)
    UILoginRolePanel.mObservation3DModelDic[career]:SetLayer(CS.EUnityLayer.CreateRole)

    UILoginRolePanel.SwitchLight(career)
end

function UILoginRolePanel.GetTweenPosByCareer(career)
    if (UILoginRolePanel.m3DModelTweenPosDic[career] == nil) then
        local gobj = UILoginRolePanel.mObservation3DModelDic[career]:GetModelRoot();
        if (gobj == nil) then
            return nil;
        end
        local tweenPos = CS.Utility_Lua.GetComponent(gobj, "TweenPosition");
        if (tweenPos == nil) then
            tweenPos = gobj:AddComponent(typeof(CS.TweenPosition));
        end
        UILoginRolePanel.m3DModelTweenPosDic[career] = tweenPos;
    end
    return UILoginRolePanel.m3DModelTweenPosDic[career];
end

---尝试进入游戏
function UILoginRolePanel.EnterGame()
    if CS.CSNetwork.Instance.IsConnect == false then
        CS.Utility.ShowRedTips("断开连接，请重新登入服务器")
        return
    end
    if UILoginRolePanel.mCurType == CS.LoginOpenType.UICreateRole then
        if CS.CSNetwork.Instance.IsConnect == false then
            CS.Utility.ShowTips("网络异常,请返回登录")
            return
        end
        CS.Constant.mCurServer = CS.LoginServerType.GameServer
        CS.NewEventProcess.IsNewRole = true
        networkRequest.ReqCreateRole(UILoginRolePanel.GetRoleNameUIInput().value, UILoginRolePanel.selectSex, UILoginRolePanel.mSelectedCareer, uiStaticParameter.inputInvitationCode)
        --CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.CreateRole);
    else
        --暂时没有跨服
        -- .--
        CS.Constant.mCurServer = CS.LoginServerType.GameServer
        --CS.Constant.RoleID_Game = UILoginRolePanel.curRoleInfo.roleId
        CS.NewEventProcess.IsNewRole = false
        CS.NetV2.ReqChooseRoleMessage(UILoginRolePanel.curRoleInfo.roleId)
        UILoginRolePanel.EnterGameTips("[ffe7be]正在进入游戏[-]", "进入游戏失败")
    end
end

---开启进入游戏提示
function UILoginRolePanel.EnterGameTips(tips, failTips)
    if UILoginRolePanel.isEnteringGame == false then
        CS.Utility.ShowTips(tips, 1.5, CS.ColorType.White)
        UILoginRolePanel.StartEnterFailTips(failTips)
        UILoginRolePanel.isEnteringGame = true
    end
end

---开启进入游戏失败的提示
function UILoginRolePanel.StartEnterFailTips(tips)
    StopCoroutine(UILoginRolePanel.EnterFailCoroutine)
    CS.CSGame.Sington:StopConnectServerFailTips()
    UILoginRolePanel.EnterFailCoroutine = StartCoroutine(UILoginRolePanel.IEnumEnterFailTips, tips)
end

---重新连接游戏服务器
function UILoginRolePanel.ReconnectGameServer()
    --print("ReconnectGameServer")
    if UILoginRolePanel.isKuaFu == true and UILoginRolePanel.curRoleInfo ~= nil and CS.CSNetwork.Instance ~= nil then
        if CS.CSNetwork.Instance.Host ~= CS.Constant.host or CS.CSNetwork.Instance.Post ~= CS.Constant.gamePort then
            if
            CS.Constant.mCurServer == CS.LoginServerType.ShareService or
                    CS.Constant.mCurServer == CS.LoginServerType.SldgService
            then
                CS.UnityEngine.Debug.LogError(
                        UILoginRolePanel.curRoleInfo.roleName ..
                                " 登入不了服务器重连进服务器  Server= " ..
                                " ipFromClient = " ..
                                UILoginRolePanel.ipFromClient ..
                                " portFromClient=" ..
                                UILoginRolePanel.portFromClient ..
                                " curServerId=" ..
                                tostring(UILoginRolePanel.curServerID) ..
                                " Constant.mCurServer = " .. tostring(CS.Constant.mCurServer)
                )
                uimanager.ClosePanelInCS(typeof(CS.UIWaiting))
                CS.CSNetwork.Instance:Connect(CS.Constant.host, CS.Constant.gamePort)
            end
        end
    end
end

---检查DLL版本
function UILoginRolePanel.CheckDllVersion()
    --print("CheckDllVersion")
    local csVersionMgr = CS.CSVersionMgr.Instance
    if csVersionMgr ~= nil then
        csVersionMgr:CheckDllVersion(
                function(needUpdate)
                    if needUpdate then
                        luaDebug.LogError("此处应弹窗显示需要更新dll")
                    else
                        UILoginRolePanel.EnterGame()
                    end
                end
        )
    end
end

---角色图片资源加载完毕回调
function UILoginRolePanel.OnLoadRoleTex(res)
    --print("OnLoadRoleTex")
    if
    UILoginRolePanel == nil or UILoginRolePanel.go == nil or CS.StaticUtility.IsNull(UILoginRolePanel.go) or res == nil or
            res.MirrorObj == nil or
            res.FileName ~= UILoginRolePanel.modelFileName
    then
        return
    end
    local go
    if Utility.IsContainsKey(UILoginRolePanel.mNewSpineDic, res.FileName) then
        go = UILoginRolePanel.mNewSpineDic[res.FileName]
    else
        go = res:GetObjInst()
        UILoginRolePanel.mNewSpineDic[res.FileName] = go
    end
    if go ~= nil then
        if go == UILoginRolePanel.mCurNewSpine then
            go:SetActive(true)
        else
            if UILoginRolePanel.mCurNewSpine ~= nil then
                UILoginRolePanel.mCurNewSpine:SetActive(false)
            end
            go:SetActive(true)
        end
        UILoginRolePanel.GetTex_Role_UITexture().gameObject:SetActive(true)
        UILoginRolePanel.GetTex_Role_UITexture().enabled = false
        go.transform.parent = UILoginRolePanel.GetTex_Role_UITexture().transform
        go.transform.localPosition = CS.UnityEngine.Vector3.zero
        go.transform.localScale = CS.UnityEngine.Vector3.one
        UILoginRolePanel.mCurNewSpine = go
    end
    UILoginRolePanel.LoadAttachEffect()
end

---角色特效资源加载完毕回调
function UILoginRolePanel.OnLoadRoleEffect(res)
    --print("OnLoadRoleEffect")
    if
    UILoginRolePanel == nil or UILoginRolePanel.go == nil or CS.StaticUtility.IsNull(UILoginRolePanel.go) or res == nil or
            res.MirrorObj == nil or
            res.FileName ~= UILoginRolePanel.effectFileName
    then
        return
    end
    if UILoginRolePanel.GetRoleEffect_UISprite() ~= nil then
        local go
        if Utility.IsContainsKey(UILoginRolePanel.mNewSpineEffectDic, res.FileName) then
            go = UILoginRolePanel.mNewSpineEffectDic[res.FileName]
        else
            go = res:GetObjInst()
            go:SetActive(false)
            UILoginRolePanel.mNewSpineEffectDic[res.FileName] = go
        end
        UILoginRolePanel.mCurNewSpineEffect = go
        UILoginRolePanel.LoadAttachEffect()
    end
end

---设置相关联的特效
function UILoginRolePanel.LoadAttachEffect()
    --print("LoadAttachEffect")
    if UILoginRolePanel.mCurNewSpineEffect ~= nil and UILoginRolePanel.mCurNewSpine ~= nil then
        if
        string.gsub(UILoginRolePanel.mCurNewSpineEffect.name, "spineeffect", "") ==
                string.gsub(UILoginRolePanel.mCurNewSpine.name, "spinerole", "")
        then
            local trans = UILoginRolePanel.mCurNewSpineEffect.transform
            local root = CS.Utility_Lua.GetComponent(UILoginRolePanel.mCurNewSpine.transform, "CSHandRoot")
            if root == nil then
                root = UILoginRolePanel.mCurNewSpine.gameObject:AddComponent(typeof(CS.CSHandRoot))
            end
            trans.parent = UILoginRolePanel.GetTex_Role_UITexture().transform
            trans.localPosition = CS.UnityEngine.Vector3.zero
            trans.localRotation = CS.UnityEngine.Quaternion.identity
            trans.localScale = CS.UnityEngine.Vector3.one
            trans.parent = root.root
            trans.localPosition = CS.UnityEngine.Vector3.zero
            UILoginRolePanel.mCurNewSpineEffect:SetActive(true)
        else
            if UILoginRolePanel.mCurNewSpineEffect ~= nil then
                UILoginRolePanel.mCurNewSpineEffect.gameObject:SetActive(false)
            end
        end
    end
end

function UILoginRolePanel.PlayChooseRoleEffect(pos)

    if (UILoginRolePanel.mChooseRoleEffect == nil) then
        if (UILoginRolePanel.IsLoadingChooseRoleEffect == true) then
            return
        end
        UILoginRolePanel.IsLoadingChooseRoleEffect = true;
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectIds.chooseRoleEffectId, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj and CS.StaticUtility.IsNull(UILoginRolePanel.go) == false then
                UILoginRolePanel.mChooseRoleEffect = res:GetObjInst()
                if UILoginRolePanel.mChooseRoleEffect and CS.StaticUtility.IsNull(UILoginRolePanel.GetCareerGrid_Transform()) == false then
                    UILoginRolePanel.mChooseRoleEffect.transform.parent = UILoginRolePanel.GetCareerGrid_Transform();
                    UILoginRolePanel.mChooseRoleEffect.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1);
                    UILoginRolePanel.mChooseRoleEffect.transform.localPosition = UILoginRolePanel.GetCareerGrid_Transform():GetChild(UILoginRolePanel.mSelectedCareer - 1).gameObject.transform.localPosition
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        UILoginRolePanel.mChooseRoleEffect:SetActive(false);
        UILoginRolePanel.mChooseRoleEffect:SetActive(true);
        UILoginRolePanel.mChooseRoleEffect.transform.localPosition = pos;
    end
end

function UILoginRolePanel.PlayCareerEffect(career)
    --if (UILoginRolePanel.mCareerEffects == nil) then
    --    UILoginRolePanel.mCareerEffects = {};
    --end
    --for k, v in pairs(UILoginRolePanel.mCareerEffects) do
    --    v:SetActive(false);
    --end
    --if (UILoginRolePanel.mCareerEffects[career] == nil) then
    --    CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectIds[career], CS.ResourceType.UIEffect, function(res)
    --        if res and res.MirrorObj then
    --            UILoginRolePanel.mCareerEffects[career] = res:GetObjInst()
    --            if UILoginRolePanel.mCareerEffects[career] then
    --                UILoginRolePanel.mCareerEffects[career].transform.parent = UILoginRolePanel.GetSelectCareerSprite_UISprite().transform;
    --                UILoginRolePanel.mCareerEffects[career].transform.localScale = CS.UnityEngine.Vector3(140, 140, 140);
    --                UILoginRolePanel.mCareerEffects[career].transform.localPosition = CS.UnityEngine.Vector3.zero;
    --            end
    --        end
    --    end
    --    , CS.ResourceAssistType.UI)
    --else
    --    UILoginRolePanel.mCareerEffects[career]:SetActive(true);
    --end
end

function UILoginRolePanel.DestroyAllEffect()
    for k, v in pairs(effectIds) do
        CS.CSResourceManager.Singleton:ForceDestroyResource(v);
    end
end
--endregion

--region destroy
function ondestroy()
    --print("ondestroy")
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResRandomNameMessage, UILoginRolePanel.OnReceiveRandomRoleNameMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResEnterGameMessage, UILoginRolePanel.OnResEnterGameMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLoginMessage, UILoginRolePanel.OnResLoginMessage)
    CS.UIWaiting.IsLoginRolePanel = false
    StopCoroutine(UILoginRolePanel.EnterFailCoroutine)
    if UILoginRolePanel.ReleaseClientEventHandler ~= nil then
        UILoginRolePanel:ReleaseClientEventHandler()
    end
    if UILoginRolePanel.ReleaseSocketEventHandler ~= nil then
        UILoginRolePanel:ReleaseSocketEventHandler()
    end

    for k, v in pairs(UILoginRolePanel.mObservation3DModelDic) do
        v:ClearModel();
    end
    UILoginRolePanel.mObservation3DModelDic = nil;

    UILoginRolePanel.DestroyAllEffect();

    if CS.CSAudioMgr.Instance then
        CS.CSAudioMgr.Instance:RemoveAllAudio()
    end
    if CS.StaticUtility.IsNull(CS.CSGame.Sington.CurrentState.SceneCamera) == false then
        CS.CSGame.Sington.CurrentState.SceneCamera.gameObject:SetActive(false)
    end
end
--endregion

return UILoginRolePanel