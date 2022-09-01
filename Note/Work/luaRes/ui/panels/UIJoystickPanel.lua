-- 摇杆
local UIJoystickPanel = {}
--UI界面层级为Resident
UIJoystickPanel.PanelLayerType = CS.UILayerType.BasicPlane
UIJoystickPanel.DoubleStatu = false
--region components

function UIJoystickPanel:GetJoystick()
    if UIJoystickPanel.mJoystick == nil then
        UIJoystickPanel.mJoystick = UIJoystickPanel:GetCurComp("WidgetRoot/joystick", "GameObject")
    end
    return UIJoystickPanel.mJoystick
end
function UIJoystickPanel:GetHighLight()
    if UIJoystickPanel.mHighLight == nil then
        UIJoystickPanel.mHighLight = UIJoystickPanel:GetCurComp("WidgetRoot/joystick/highlight", "GameObject")
    end
    return UIJoystickPanel.mHighLight
end
function UIJoystickPanel:GetTouchZone()
    if UIJoystickPanel.zone == nil then
        UIJoystickPanel.zone = UIJoystickPanel:GetCurComp("WidgetRoot/zone", "GameObject")
    end
    return UIJoystickPanel.zone
end
function UIJoystickPanel:GetTouchObj()
    if UIJoystickPanel.touchObj == nil then
        UIJoystickPanel.touchObj = UIJoystickPanel:GetCurComp("WidgetRoot", "GameObject")
    end
    return UIJoystickPanel.touchObj
end
function UIJoystickPanel:GetTouch()
    if UIJoystickPanel.touch == nil then
        UIJoystickPanel.touch = UIJoystickPanel:GetCurComp("WidgetRoot/joystick/touch", "GameObject")
    end
    return UIJoystickPanel.touch
end
function UIJoystickPanel:GetTouchArea()
    if UIJoystickPanel.touchArea == nil then
        UIJoystickPanel.touchArea = UIJoystickPanel:GetCurComp("WidgetRoot/joystick/area", "UISprite")
    end
    return UIJoystickPanel.touchArea
end

--小遥杆

function UIJoystickPanel:GetSmallTouchZone()
    if UIJoystickPanel.samllTouchZone == nil then
        UIJoystickPanel.samllTouchZone = UIJoystickPanel:GetCurComp("WidgetRoot/smallZone", "GameObject")
    end
    return UIJoystickPanel.samllTouchZone
end

function UIJoystickPanel:GetSmallJoyStick()
    if UIJoystickPanel.mSmallJoystick == nil then
        UIJoystickPanel.mSmallJoystick = UIJoystickPanel:GetCurComp("WidgetRoot/joystick_small", "GameObject")
    end
    return UIJoystickPanel.mSmallJoystick
end

function UIJoystickPanel:GetSmallTouch()
    if UIJoystickPanel.smallTouch == nil then
        UIJoystickPanel.smallTouch = UIJoystickPanel:GetCurComp("WidgetRoot/joystick_small/touch", "GameObject")
    end
    return UIJoystickPanel.smallTouch
end

function UIJoystickPanel:GetSmallTouchArea()
    if UIJoystickPanel.smallTouchArea == nil then
        UIJoystickPanel.smallTouchArea = UIJoystickPanel:GetCurComp("WidgetRoot/joystick_small/area", "UISprite")
    end
    return UIJoystickPanel.smallTouchArea
end



--endregion

--region init
function UIJoystickPanel:Init()
    UIJoystickPanel:Initparameter()
    UIJoystickPanel:InitUI()
    UIJoystickPanel:SetAnchorOffset()

    UIJoystickPanel:BindUIMessage()
    UIJoystickPanel:BindNetMessage()
end

function UIJoystickPanel:Initparameter()

    --root
    UIJoystickPanel.pixelSizeAdjustment = CS.UIManager.Instance:GetUIRoot().pixelSizeAdjustment;

    --大摇杆
    UIJoystickPanel.zoneAreaCenter = CS.Utility_Lua.GetComponent(UIJoystickPanel:GetTouchZone(), "UIWidget").localCenter
    UIJoystickPanel.areaRadius = UIJoystickPanel:GetTouchArea().localSize.x / 2
    UIJoystickPanel.anchorOffset = CS.UnityEngine.Vector3.zero

    --小摇杆
    UIJoystickPanel.smallZoneAreaCenter = CS.Utility_Lua.GetComponent(UIJoystickPanel:GetSmallTouchZone(), "UIWidget").localCenter
    UIJoystickPanel.smallAreaRadius = UIJoystickPanel:GetSmallTouchArea().localSize.x / 2
    UIJoystickPanel.smallAnchorOffset = CS.UnityEngine.Vector3.zero

    --JoystickController
    UIJoystickPanel.UIJoystickController = UIJoystickPanel:GetTouchZone():AddComponent(typeof(CS.UIJoystickController))
    UIJoystickPanel.UIJoystickController.zoneAreaRadius = UIJoystickPanel.areaRadius;

    --config
    if CS.CSScene.MainPlayerInfo then
        UIJoystickPanel.DoubleStatu = CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.DoubleJoysticks)
    else
        UIJoystickPanel.DoubleStatu = false
    end

    --other
    UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
    UIJoystickPanel.isClickSmallTouch = false
    UIJoystickPanel.isClickTouch = false
    UIJoystickPanel.bigdefaultJoystickPos = UIJoystickPanel:GetJoystick().transform.localPosition
    UIJoystickPanel.smalldefaultJoystickPos = UIJoystickPanel:GetSmallJoyStick().transform.localPosition
end

function UIJoystickPanel:BindUIMessage()
    CS.UIEventListener.Get(UIJoystickPanel:GetTouchZone()).onPress = UIJoystickPanel.OnPressTouch
    CS.UIEventListener.Get(UIJoystickPanel:GetTouchZone()).onDrag = UIJoystickPanel.OnDragTouch

    CS.UIEventListener.Get(UIJoystickPanel:GetSmallTouchZone()).onPress = UIJoystickPanel.OnPressSmallTouch
    CS.UIEventListener.Get(UIJoystickPanel:GetSmallTouchZone()).onDrag = UIJoystickPanel.OnDragSmallTouch
end

function UIJoystickPanel:BindNetMessage()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.DoubleJoysticksStatuChange, UIJoystickPanel.SetSmallJoyStick)
end

--endregion

function UIJoystickPanel:GetTouchDeviation()
    return CS.UnityEngine.Vector3.zero;
    --if UIJoystickPanel.mTouchDeviation == nil then
    --    UIJoystickPanel.mTouchDeviation = CS.UnityEngine.Vector3((CS.CSGame.Sington.ContentSize.x - 1334) / 2, (CS.CSGame.Sington.ContentSize.y - 750) / 2, 0)
    --end
    --return UIJoystickPanel.mTouchDeviation
end

--region UI事件

---大摇杆的点击
--- @param state 鼠标状态
function UIJoystickPanel.OnPressTouch(go, state)
    UIJoystickPanel.isClickTouch = state
    UIJoystickPanel:RefreshJoyStick(state)
    if (state == true) then
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.JoyStick
    else
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.Idle
        CS.UIJoystickController.Singleton:StopMove();
    end
end

---大摇杆的拖动
function UIJoystickPanel.OnDragTouch(go, delta)
    if go ~= UIJoystickPanel:GetTouchZone() then
        return
    end
    if (CS.CSScene.Sington.MainPlayer.TouchMove ~= CS.ControlState.JoyStick) then
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)
        return ;
    end
    UIJoystickPanel.touchPos = UIJoystickPanel.touchPos + CS.UnityEngine.Vector3(delta.x, delta.y) * UIJoystickPanel.pixelSizeAdjustment
    UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)
end

---小遥杆的点击
function UIJoystickPanel.OnPressSmallTouch(go, state)
    UIJoystickPanel.isClickSmallTouch = state
    UIJoystickPanel:RefreshSmallJoyStick(state)
    if (state == true) then
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.JoyStick
    else
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.Idle
        CS.UIJoystickController.Singleton:StopMove();
    end
end

---小遥杆的拖动
function UIJoystickPanel.OnDragSmallTouch(go, delta)
    if go ~= UIJoystickPanel:GetSmallTouchZone() then
        return
    end

    if (CS.CSScene.Sington.MainPlayer.TouchMove ~= CS.ControlState.JoyStick) then
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)
        return ;
    end
    UIJoystickPanel.touchPos = UIJoystickPanel.touchPos + CS.UnityEngine.Vector3(delta.x, delta.y) * UIJoystickPanel.pixelSizeAdjustment
    UIJoystickPanel:SetSmallTouchPos(UIJoystickPanel.touchPos)
    --CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.JoyStick;
end

--endregion

--region 客户端事件监听

---根据双摇杆设置 设置小遥杆的状态
function UIJoystickPanel.SetSmallJoyStick(id, statu)
    UIJoystickPanel.DoubleStatu = statu
    UIJoystickPanel:GetSmallJoyStick().gameObject:SetActive(statu)
    UIJoystickPanel:GetSmallTouchZone().gameObject:SetActive(statu)
end
--endregion

--region UI

function UIJoystickPanel:InitUI()
    UIJoystickPanel:GetHighLight():SetActive(false)
    CS.Utility_Lua.GetComponent(UIJoystickPanel:GetJoystick().transform, "UIWidget").alpha = 0.4
    CS.Utility_Lua.GetComponent(UIJoystickPanel:GetSmallJoyStick().transform, "UIWidget").alpha = 0.4
    UIJoystickPanel:GetSmallJoyStick().gameObject:SetActive(UIJoystickPanel.DoubleStatu)
    UIJoystickPanel:GetSmallTouchZone().gameObject:SetActive(UIJoystickPanel.DoubleStatu)
end

---刷新大摇杆
function UIJoystickPanel:RefreshJoyStick(state)
    ---有操作时先尝试进入自动暂停状态
    CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
    ---只要有操作，打断自动战斗状态
    CS.CSAutoFightMgr.Instance:Toggle(false)
    ---有操作时打断自动寻路
    CS.CSPathFinderManager.Instance:Reset(true, true)
    local pressPos;

    if (state) then
        UIJoystickPanel:SetAnchorOffset()
        local pos = Utility.GetTouchPoint()
        --luaDebug.Log("OnPressTouch pos :" .. tostring(pos))
        local v3 = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
        pressPos = CS.UICamera.currentCamera:ScreenToWorldPoint(v3)

        if UIJoystickPanel:GetFixJoyStickSet() == false then
            UIJoystickPanel:GetJoystick().transform.position = pressPos
            --设置遥杆z轴坐标
            local localPos = UIJoystickPanel:GetJoystick().transform.localPosition
            UIJoystickPanel:GetJoystick().transform.localPosition = CS.UnityEngine.Vector3(localPos.x, localPos.y, 0)
            UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        else
            local pos = v3 * UIJoystickPanel.pixelSizeAdjustment
            pos = pos - UIJoystickPanel.zoneAreaCenter
            pos = pos + UIJoystickPanel.anchorOffset
            pos = pos - UIJoystickPanel:GetTouchObj().transform.localPosition - UIJoystickPanel:GetTouchDeviation();
            if (pos.sqrMagnitude >= 1000) then
                UIJoystickPanel.touchPos = pos
            end
        end
    else
        UIJoystickPanel.UIJoystickController.AssignJoyMoveState = CS.EAssignJoyMoveState.None
        UIJoystickPanel:GetJoystick().transform.localPosition = UIJoystickPanel.bigdefaultJoystickPos
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
    end

    UIJoystickPanel:SetTouchPos(UIJoystickPanel.touchPos)

    UIJoystickPanel:GetHighLight():SetActive(state);
    CS.Utility_Lua.GetComponent(UIJoystickPanel:GetJoystick().transform, "UIWidget").alpha = state and 1 or 0.4

    if (CS.CSScene.IsLanuchMainPlayer and state and UIJoystickPanel:GetFixJoyStickSet()) then
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.JoyStick;
    end
end

---刷新小遥杆
function UIJoystickPanel:RefreshSmallJoyStick(state)
    --只要有操作，打断自动战斗状态
    CS.CSAutoFightMgr.Instance:Toggle(false)
    CS.CSPathFinderManager.Instance:Reset(true, true)
    local pressPos;

    if (state) then
        UIJoystickPanel:SetAnchorOffset()
        local pos = Utility.GetTouchPoint()
        local v3 = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
        pressPos = CS.UICamera.currentCamera:ScreenToWorldPoint(v3)

        if UIJoystickPanel:GetFixJoyStickSet() == false then
            UIJoystickPanel:GetSmallJoyStick().transform.position = pressPos
            --设置遥杆z轴坐标
            local localPos = UIJoystickPanel:GetSmallJoyStick().transform.localPosition
            UIJoystickPanel:GetSmallJoyStick().transform.localPosition = CS.UnityEngine.Vector3(localPos.x, localPos.y, 0)
            UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero;
        else
            UIJoystickPanel.touchPos = v3 * UIJoystickPanel.pixelSizeAdjustment
            UIJoystickPanel.touchPos = UIJoystickPanel.touchPos - UIJoystickPanel.smallZoneAreaCenter
            UIJoystickPanel.touchPos = UIJoystickPanel.touchPos + UIJoystickPanel.smallAnchorOffset
            UIJoystickPanel.touchPos = UIJoystickPanel.touchPos - UIJoystickPanel:GetTouchObj().transform.localPosition - UIJoystickPanel:GetTouchDeviation();
        end
    else
        UIJoystickPanel.UIJoystickController.AssignJoyMoveState = CS.EAssignJoyMoveState.None
        UIJoystickPanel:GetSmallJoyStick().transform.localPosition = UIJoystickPanel.smalldefaultJoystickPos
        UIJoystickPanel.touchPos = CS.UnityEngine.Vector3.zero
    end

    UIJoystickPanel:SetSmallTouchPos(UIJoystickPanel.touchPos)
    CS.Utility_Lua.GetComponent(UIJoystickPanel:GetSmallJoyStick().transform, "UIWidget").alpha = state and 1 or 0.4
    if (CS.CSScene.IsLanuchMainPlayer and state and UIJoystickPanel:GetFixJoyStickSet()) then
        CS.CSScene.Sington.MainPlayer.TouchMove = CS.ControlState.JoyStick;
    end
end

--- 设置大摇杆Touch坐标
--- @param mouseLocalPos 当前鼠标基于摇杆基点的坐标
function UIJoystickPanel:SetTouchPos(mouseLocalPos)

    CS.CSTouchEvent.Instance:IsCanBreakAttack()

    if (mouseLocalPos.magnitude > UIJoystickPanel.areaRadius) then
        UIJoystickPanel:GetTouch().transform.localPosition = mouseLocalPos.normalized * UIJoystickPanel.areaRadius * UIJoystickPanel.pixelSizeAdjustment
    else
        UIJoystickPanel:GetTouch().transform.localPosition = mouseLocalPos
    end
    if (UIJoystickPanel.UIJoystickController ~= nil) then
        if UIJoystickPanel.DoubleStatu then
            UIJoystickPanel.UIJoystickController.AssignJoyMoveState = CS.EAssignJoyMoveState.Run
        else
            UIJoystickPanel.UIJoystickController.AssignJoyMoveState = CS.EAssignJoyMoveState.None
        end
        UIJoystickPanel.UIJoystickController.zoneAreaRadius = UIJoystickPanel.areaRadius;
        UIJoystickPanel.UIJoystickController.touchPos = mouseLocalPos;
    end

    local angle = CS.UnityEngine.Mathf.Atan2(mouseLocalPos.y, mouseLocalPos.x) * CS.UnityEngine.Mathf.Rad2Deg;
    UIJoystickPanel:GetHighLight().transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, angle);

end

--- 设置小摇杆Touch坐标
function UIJoystickPanel:SetSmallTouchPos(mouseLocalPos)
    if (mouseLocalPos.magnitude > UIJoystickPanel.smallAreaRadius) then
        UIJoystickPanel:GetSmallTouch().transform.localPosition = mouseLocalPos.normalized * UIJoystickPanel.smallAreaRadius * UIJoystickPanel.pixelSizeAdjustment
    else
        UIJoystickPanel:GetSmallTouch().transform.localPosition = mouseLocalPos
    end

    if (UIJoystickPanel.UIJoystickController ~= nil) then
        UIJoystickPanel.UIJoystickController.zoneAreaRadius = UIJoystickPanel.smallAreaRadius;
        UIJoystickPanel.UIJoystickController.AssignJoyMoveState = CS.EAssignJoyMoveState.Walk
        UIJoystickPanel.UIJoystickController.touchPos = mouseLocalPos;
    end

    local angle = CS.UnityEngine.Mathf.Atan2(mouseLocalPos.y, mouseLocalPos.x) * CS.UnityEngine.Mathf.Rad2Deg;
    UIJoystickPanel:GetHighLight().transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, angle);
end

--endregion


--region OtherFunc

---获取定向遥杆设置
function UIJoystickPanel:GetFixJoyStickSet()
    return CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.FixJoystick) or CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.DoubleJoysticks)
end

---获取双摇杆的配置
function UIJoystickPanel:GetDoubleJoyStickConfig()
    UIJoystickPanel.DoubleStatu = CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.DoubleJoysticks)
end

---获取遥杆与点击面的偏移量
function UIJoystickPanel:SetAnchorOffset()
    --region 大摇杆
    local zoneCenterPos = UIJoystickPanel:GetTouchZone().transform.localPosition + UIJoystickPanel.zoneAreaCenter
    --大遥杆中心点位置
    local joyStaticPos = UIJoystickPanel:GetJoystick().transform.localPosition
    --得到zone的中心点位置 （当前坐标+center）适用于锚点未在中心位置

    --获的大摇杆偏移量
    UIJoystickPanel.anchorOffset.x = math.floor(zoneCenterPos.x - joyStaticPos.x)
    UIJoystickPanel.anchorOffset.y = math.floor(zoneCenterPos.y - joyStaticPos.y)
    --endregion

    --region 小遥杆
    local smallZoneCenterPos = UIJoystickPanel:GetSmallTouchZone().transform.localPosition + UIJoystickPanel.smallZoneAreaCenter
    --小遥杆中心点位置
    local smalljoyStaticPos = UIJoystickPanel:GetSmallJoyStick().transform.localPosition
    --得到zone的中心点位置

    --获的小摇杆偏移量
    UIJoystickPanel.smallAnchorOffset.x = math.floor(smallZoneCenterPos.x - smalljoyStaticPos.x)
    UIJoystickPanel.smallAnchorOffset.y = math.floor(smallZoneCenterPos.y - smalljoyStaticPos.y)
    --endregion
end

function ondestroy()
    --luaEventManager.RemoveCallback(LuaCEvent.DoubleJoysticksStatuChange, UIJoystickPanel.SetSmallJoyStick)
end

--endregion

return UIJoystickPanel