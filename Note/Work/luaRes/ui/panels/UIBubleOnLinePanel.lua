---@class UIBubleOnLinePanel:UIBase
local UIBubleOnLinePanel = {}

--region 局部变量
UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom = nil
UIBubleOnLinePanel.GetBubleBtn_TweenPositionto = nil
---Buble特效
UIBubleOnLinePanel.mBubleEffect = nil
---Buble池子特效
UIBubleOnLinePanel.mBublePoolEffect = nil
---Buble池子涨幅
UIBubleOnLinePanel.mBublePoolEffectNum = 0
---Bubble特效数目
UIBubleOnLinePanel.mBubleEffectCount = 0
---Bubble是否展开
UIBubleOnLinePanel.mBubbleTipsIsShow = false
UIBubleOnLinePanel.mainchatpanel = nil
---屏幕宽高
UIBubleOnLinePanel.mScreenWidth = CS.UnityEngine.Screen.width
UIBubleOnLinePanel.mScreenHeight = CS.UnityEngine.Screen.height
--endregion

--region 组件
function UIBubleOnLinePanel.GetBesizerPoint_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetBesizerPoint_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetBesizerPointup_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetBesizerPointup_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetBesizerPointcenter1_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetBesizerPointcenter1_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetBesizerPointcenter2_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetBesizerPointcenter2_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetBesizerPointdown_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetBesizerPointdown_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetOffLinePointLeft_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetOffLinePointLeft_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetOffLinePointCenter_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetOffLinePointCenter_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetOffLinePointRight_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetOffLinePointRight_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetOffLineEndPoint_GameObject()
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        return UIBubleOnLinePanel.mainchatpanel.GetOffLineEndPoint_GameObject()
    end
    return nil
end

function UIBubleOnLinePanel.GetBubleTime_UICountdownLabel()
    if (UIBubleOnLinePanel.mBubleTime == nil) then
        UIBubleOnLinePanel.mBubleTime = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/timeprogress", "UICountdownLabel")
    end
    return UIBubleOnLinePanel.mBubleTime
end

function UIBubleOnLinePanel.GetBubleTime_UILabel()
    if (UIBubleOnLinePanel.mBubleTimeLabel == nil) then
        UIBubleOnLinePanel.mBubleTimeLabel = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/timeprogress", "UILabel")
    end
    return UIBubleOnLinePanel.mBubleTimeLabel
end

function UIBubleOnLinePanel.GetBubleBtnBGBottom_GameObject()
    if (UIBubleOnLinePanel.mBubleBtnBGBottom == nil) then
        UIBubleOnLinePanel.mBubleBtnBGBottom = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bgkuang", "GameObject")
    end
    return UIBubleOnLinePanel.mBubleBtnBGBottom
end

function UIBubleOnLinePanel.GetBubleBtnBGBottom_UISprite()
    if (UIBubleOnLinePanel.mBubleBtnBGBottomUISprite == nil) then
        UIBubleOnLinePanel.mBubleBtnBGBottomUISprite = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bgkuang", "UISprite")
    end
    return UIBubleOnLinePanel.mBubleBtnBGBottomUISprite
end

function UIBubleOnLinePanel.GetBubleBtnBGBottom_TweenAlpha()
    if (UIBubleOnLinePanel.mBubleBtnBGBottomTweenAlpha == nil) then
        UIBubleOnLinePanel.mBubleBtnBGBottomTweenAlpha = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bgkuang", "TweenAlpha")
    end
    return UIBubleOnLinePanel.mBubleBtnBGBottomTweenAlpha
end

function UIBubleOnLinePanel.GetBubleBtnBG_GameObject()
    if (UIBubleOnLinePanel.mBubleBtnBG == nil) then
        UIBubleOnLinePanel.mBubleBtnBG = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/panel/paodian_tips", "GameObject")
    end
    return UIBubleOnLinePanel.mBubleBtnBG
end

function UIBubleOnLinePanel.GetBubletips_UILabel()
    if (UIBubleOnLinePanel.mBubletips == nil) then
        UIBubleOnLinePanel.mBubletips = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/panel/paodian_tips/tips_0", "UILabel")
    end
    return UIBubleOnLinePanel.mBubletips
end

function UIBubleOnLinePanel.GetBubletips_GameObject()
    if (UIBubleOnLinePanel.mBubletipsGo == nil) then
        UIBubleOnLinePanel.mBubletipsGo = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/panel/paodian_tips/tips_0", "GameObject")
    end
    return UIBubleOnLinePanel.mBubletipsGo
end

function UIBubleOnLinePanel.GetBubleBtnBG_TweenPosition()
    if (UIBubleOnLinePanel.mBubleBtnBGTweenPosition == nil) then
        UIBubleOnLinePanel.mBubleBtnBGTweenPosition = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/panel/paodian_tips", "TweenPosition")
    end
    return UIBubleOnLinePanel.mBubleBtnBGTweenPosition
end

function UIBubleOnLinePanel.GetBubleBtnBG_TweenAlpha()
    if (UIBubleOnLinePanel.mBubleBtnBGTweenAlpha == nil) then
        UIBubleOnLinePanel.mBubleBtnBGTweenAlpha = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/panel/paodian_tips", "TweenAlpha")
    end
    return UIBubleOnLinePanel.mBubleBtnBGTweenAlpha
end

--function UIBubleOnLinePanel.GetBubleBtn_GameObject()
--    if (UIBubleOnLinePanel.mBubleBtn == nil) then
--        UIBubleOnLinePanel.mBubleBtn = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top", "GameObject")
--    end
--    return UIBubleOnLinePanel.mBubleBtn
--end

function UIBubleOnLinePanel.GetBubleBtn_GameObject()
    if (UIBubleOnLinePanel.mBubleBtn == nil) then
        UIBubleOnLinePanel.mBubleBtn = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bg", "GameObject")
    end
    return UIBubleOnLinePanel.mBubleBtn
end

function UIBubleOnLinePanel.GetBubleBtn_Box()
    if (UIBubleOnLinePanel.mBubleBtnBox == nil) then
        UIBubleOnLinePanel.mBubleBtnBox = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bg", "BoxCollider")
    end
    return UIBubleOnLinePanel.mBubleBtnBox
end

function UIBubleOnLinePanel.GetBubleBtn_UISprite()
    if (UIBubleOnLinePanel.mBubleBtnSprite == nil) then
        UIBubleOnLinePanel.mBubleBtnSprite = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bg", "UISprite")
    end
    return UIBubleOnLinePanel.mBubleBtnSprite
end

function UIBubleOnLinePanel.GetBubleBtnRoot_Transform()
    if (UIBubleOnLinePanel.mBubleBtnRoot == nil) then
        UIBubleOnLinePanel.mBubleBtnRoot = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top", "Transform")
    end
    return UIBubleOnLinePanel.mBubleBtnRoot
end

function UIBubleOnLinePanel.GetBubleBtnBG_Transform()
    if (UIBubleOnLinePanel.mBubleBtnBG == nil) then
        UIBubleOnLinePanel.mBubleBtnBG = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bg", "Transform")
    end
    return UIBubleOnLinePanel.mBubleBtnBG
end

function UIBubleOnLinePanel.GetBubleBtn_TweenPosition()
    if (UIBubleOnLinePanel.mBubleBtnTweenPosition == nil) then
        UIBubleOnLinePanel.mBubleBtnTweenPosition = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top", "TweenPosition")
    end
    return UIBubleOnLinePanel.mBubleBtnTweenPosition
end

function UIBubleOnLinePanel.GetBubleBtn_TweenWidth()
    if (UIBubleOnLinePanel.mbgkuangWidth == nil) then
        UIBubleOnLinePanel.mbgkuangWidth = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/paodian_bgkuang", "TweenWidth")
    end
    return UIBubleOnLinePanel.mbgkuangWidth
end

function UIBubleOnLinePanel.GetExpTips_UILabel()
    if (UIBubleOnLinePanel.mExpTipsUILabel == nil) then
        UIBubleOnLinePanel.mExpTipsUILabel = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/ExpTips", "UILabel")
    end
    return UIBubleOnLinePanel.mExpTipsUILabel
end

function UIBubleOnLinePanel.GetExpTips_TweenPosition()
    if (UIBubleOnLinePanel.mExpTipsTweenPosition == nil) then
        UIBubleOnLinePanel.mExpTipsTweenPosition = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/ExpTips", "TweenPosition")
    end
    return UIBubleOnLinePanel.mExpTipsTweenPosition
end

function UIBubleOnLinePanel.GetExpTips_TweenTweenAlpha()
    if (UIBubleOnLinePanel.mExpTipsTweenTweenAlpha == nil) then
        UIBubleOnLinePanel.mExpTipsTweenTweenAlpha = UIBubleOnLinePanel:GetCurComp("WidgetRoot/paodian_top/ExpTips", "Top_TweenAlpha")
    end
    return UIBubleOnLinePanel.mExpTipsTweenTweenAlpha
end

function UIBubleOnLinePanel.GetMainChatPanel()
    if (UIBubleOnLinePanel.mainchatpanel == nil) then
        UIBubleOnLinePanel.mainchatpanel = uimanager:GetPanel("UIMainChatPanel")
    end
    return UIBubleOnLinePanel.mainchatpanel
end
--endregion

--region 初始化
function UIBubleOnLinePanel:Init()
    ---@type UnityEngine.GameObject
    UIBubleOnLinePanel.UIBubleOnLinePanel = self:GetCurComp("WidgetRoot", "GameObject")
    ---@type UnityEngine.GameObject
    UIBubleOnLinePanel.UIBubleEffectRoot = self:GetCurComp("WidgetRoot/paodian_top/EffectRoot", "GameObject")
    ---@type UnityEngine.GameObject
    UIBubleOnLinePanel.mainchatpanel = uimanager:GetPanel("UIMainChatPanel")
    if (UIBubleOnLinePanel.mainchatpanel ~= nil) then
        UIBubleOnLinePanel.UIExpSliderEndPoint = UIBubleOnLinePanel.mainchatpanel.UIExpSliderEndPoint
    end
    ---@type Top_UIGridContainer 闪烁提示
    UIBubleOnLinePanel.item_messageAlterGrid = mainchatpanel
    UIBubleOnLinePanel.SetOnFinished()
    UIBubleOnLinePanel.BindMessage()
    UIBubleOnLinePanel.BindUIEvents()
end

function UIBubleOnLinePanel:Show(data)
    UIBubleOnLinePanel.OnResBubbleOnlineExpMessage(nil, data, nil)
end

--function UIBubleOnLinePanel:HideSelf()
--    self.go:SetActive(false)
--    UIBubleOnLinePanel.HideBubblePanel()
--end

function UIBubleOnLinePanel.BindMessage()
    UIBubleOnLinePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBubbleOnlineExpMessage, UIBubleOnLinePanel.OnResBubbleOnlineExpMessage)
    UIBubleOnLinePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOverBubblePointMessage, UIBubleOnLinePanel.OnResOverBubblePointMessage)
    UIBubleOnLinePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_NormalClickEvent, UIBubleOnLinePanel.HideBubblePanel)
end

function UIBubleOnLinePanel.BindUIEvents()
    CS.UIEventListener.Get(UIBubleOnLinePanel.GetBubleBtn_GameObject()).onClick = UIBubleOnLinePanel.BubbleBtnOnClick
end
--endregion

--region 泡点
--region 在线泡点
--开始泡点
function UIBubleOnLinePanel.OnResBubbleOnlineExpMessage(uiEvtID, data, csdata)
    if (UIBubleOnLinePanel.GetMainChatPanel() ~= nil) then
        UIBubleOnLinePanel.GetMainChatPanel().BubleTime = data.bubbleTime
    end
    UIBubleOnLinePanel.mBublePoolEffectNum = 1 - (data.bubbleTime / data.totalTime)
    --UIBubleOnLinePanel.GetExpTips_UILabel().text = "+" .. tostring(data.exp)
    --UIBubleOnLinePanel:GetBubleTime_UICountdownLabel():StartCountDown(500, 4, data.endTime, "" .. "", "[-]", nil, nil)
    UIBubleOnLinePanel.GetExpTips_TweenPosition():ResetToBeginning()
    UIBubleOnLinePanel.GetExpTips_TweenTweenAlpha():ResetToBeginning()
    UIBubleOnLinePanel.GetExpTips_TweenPosition():PlayForward()
    UIBubleOnLinePanel.GetExpTips_TweenTweenAlpha():PlayForward()
    UIBubleOnLinePanel.GetBubleTime_UILabel().text = tostring(math.floor((1 - (data.bubbleTime / data.totalTime)) * 100 + 1)) .. "%"
    --09FF00FF
    --[[
        UIBubleOnLinePanel.GetBubletips_UILabel().text = "安全区每分钟获得[a6caff]" .. tostring(data.exp) .. "经验[-] [77ff77]" ..
                tostring(data.servantExp) .. "灵兽经验[-]\n离线每分钟获得[a6caff]" ..
                tostring(math.ceil(data.exp * CS.Cfg_GlobalTableManager.Instance.OffLineRoleExpratio)) .. "经验[-] [77ff77]" .. tostring(math.ceil(data.servantExp * CS.Cfg_GlobalTableManager.Instance.OffLineServantExpratio)) .. "灵兽经验[-]"
    ]]

    UIBubleOnLinePanel.GetBubletips_UILabel().text = "安全区每分钟获得[a6caff]" .. tostring(data.exp) .. "经验[-]\n离线每分钟获得[a6caff]" .. tostring(math.ceil(data.exp * CS.Cfg_GlobalTableManager.Instance.OffLineRoleExpratio)) .. "经验[-] [77ff77]"

    if (UIBubleOnLinePanel.mBubleEffect == nil) then
        UIBubleOnLinePanel.RefreshEffect("700083", UIBubleOnLinePanel.UIBubleEffectRoot.transform, CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, UIBubleOnLinePanel.BubbleOnlineEffectLoadCallback)
    else
        UIBubleOnLinePanel.BubbleOnlineEffectLoadCallback(UIBubleOnLinePanel.UIBubleEffectRoot.transform, UIBubleOnLinePanel.mBubleEffect)
    end
    if (UIBubleOnLinePanel.mBublePoolEffect == nil) then
        UIBubleOnLinePanel.RefreshEffect("700084", UIBubleOnLinePanel.GetBubleBtnBG_Transform(), CS.UnityEngine.Vector3.zero, CS.UnityEngine.Vector3.one, UIBubleOnLinePanel.PaoDianPoolEffectLoadCallback)
    else
        UIBubleOnLinePanel.ShowPaoDianPoolEffect(UIBubleOnLinePanel.mBublePoolEffectNum)
    end

    --region tips
    --local dataTipsData = {}
    --dataTipsData.dialogType = LuaEnumDialogTipsShapeType.NoArrow
    --dataTipsData.contents = "经验  +" .. tostring(data.exp)
    --dataTipsData.highLightContent = nil
    --if UIBubleOnLinePanel.mDialogTips then
    --    UIBubleOnLinePanel.mDialogTips:Hide()
    --    UIBubleOnLinePanel.mDialogTips = nil
    --end
    --dataTipsData.time = 1
    --uimanager:CreatePanel("UIDialogTipsContainerPanel", function(dialogTipsContainer)
    --    if UIBubleOnLinePanel then
    --        UIBubleOnLinePanel.mDialogTips = dialogTipsContainer.CreateDialogTips(dataTipsData)
    --        UIBubleOnLinePanel.SetTipsPostion(UIBubleOnLinePanel.mDialogTips)
    --    end
    --end)
    --endregion
end

---设置tips位置
function UIBubleOnLinePanel.SetTipsPostion(panel)
    if panel == nil then
        return
    end
    local posY = -365
    local posX = 0

    local limitXMax = 610
    local limitXMin = -474
    --计算目标位置
    local curLevel = CS.CSScene.MainPlayerInfo.Level
    local curMaxExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(curLevel)
    local curExp = CS.CSScene.MainPlayerInfo.Exp
    --当前进度
    local curAmount = curExp / curMaxExp
    curAmount = Utility.GetPreciseDecimal(curAmount, 3)
    ----目标进度
    posX = -(CS.CSGame.Sington.ContentSize.x / 2) + (CS.CSGame.Sington.ContentSize.x * curAmount)
    posX = posX < limitXMin and limitXMin or posX > limitXMax and limitXMax or posX
    --判断界限 设置位置
    panel.go.transform.localPosition = CS.UnityEngine.Vector3(posX, posY, 3)
end

function UIBubleOnLinePanel.ShowPaoDianPoolEffect(materialsNum)
    if materialsNum == nil or materialsNum == 0 then
        return
    end
    local v2 = CS.UnityEngine.Vector2.zero
    -- 液体shader数值为从大到小 min数值为最大 液体数值为最小 max 数值为最小  液体数值为最大
    local min = 1
    local max = 0
    --TextureOffse 参数
    local str = ''
    local curEffectQueue = CS.Utility_Lua.GetComponent(UIBubleOnLinePanel.mBublePoolEffect.transform, "Top_CSEffectRenderQueue")
    for i = 0, curEffectQueue.matS.Length - 1 do
        if i ~= 4 and i ~= 6 and i ~= 7 and i ~= 8 then
            min = i == 3 and 0.49 or i == 5 and 0.9 or 0.5
            max = i == 3 and -0.01 or i == 5 and 0.55 or 0
            str = i == 3 and "_MainTex" or "_MaskTex"
            v2.y = min - (materialsNum * (min - max))
            curEffectQueue.matS[i]:SetTextureOffset(str, v2)
        end
    end
end

function UIBubleOnLinePanel.PaoDianPoolEffectLoadCallback(path, res)
    if (res ~= nil) then
        UIBubleOnLinePanel.mBublePoolEffect = res
        UIBubleOnLinePanel.ShowPaoDianPoolEffect(UIBubleOnLinePanel.mBublePoolEffectNum)
    end
end

function UIBubleOnLinePanel.BubbleOnlineEffectLoadCallback(path, res)
    if (res ~= nil) then
        UIBubleOnLinePanel.mBubleEffect = res
        UIBubleOnLinePanel.mBubleEffect:SetActive(true)
        local draw = CS.Utility_Lua.GetComponent(UIBubleOnLinePanel.mBubleEffect, "DrawBesizerLine")
        if (draw == nil) then
            draw = UIBubleOnLinePanel.mBubleEffect:AddComponent(typeof(CS.DrawBesizerLine))
        end
        draw = CS.Utility_Lua.SetBasePointCount(draw, 2)
        CS.Utility_Lua.SetBasePoint(draw, 0, UIBubleOnLinePanel.UIBubleEffectRoot)
        --draw.BasePoint[0] = UIBubleOnLinePanel.UIBubleEffectRoot
        --local r = math.random(1, 3)
        --if (r == 1) then
        --    draw.BasePoint[1] = UIBubleOnLinePanel.GetBesizerPointup_GameObject()
        --elseif (r == 2) then
        --if (UIBubleOnLinePanel.GetBesizerPointcenter1_GameObject() ~= nil) then
        --    draw.BasePoint[1] = UIBubleOnLinePanel.GetBesizerPointcenter1_GameObject()
        --end
        --if (UIBubleOnLinePanel.GetBesizerPointcenter2_GameObject() ~= nil) then
        --    draw.BasePoint[2] = UIBubleOnLinePanel.GetBesizerPointcenter2_GameObject()
        --end
        --elseif (r == 3) then
        --    draw.BasePoint[1] = UIBubleOnLinePanel.GetBesizerPointdown_GameObject()
        --end
        CS.Utility_Lua.SetBasePoint(draw, 1, UIBubleOnLinePanel.UIExpSliderEndPoint)
        --draw.BasePoint[1] = UIBubleOnLinePanel.UIExpSliderEndPoint
        draw.IsInit = true
        draw.CallBack = function()
            UIBubleOnLinePanel.mBubleEffect:SetActive(false)
            UIBubleOnLinePanel.mBubleEffect.transform.position = draw.BasePoint[0].transform.position
        end
        --UIBubleOnLinePanel.BubbleOnlineEffectPlayCallback
        UIBubleOnLinePanel.UIBubleOnLinePanel:SetActive(true)
    end
end

function UIBubleOnLinePanel.BubbleOnlineEffectPlayCallback(go)
    UIBubleOnLinePanel.mBubleEffectCount = UIBubleOnLinePanel.mBubleEffectCount + 1
    if (UIBubleOnLinePanel.mBubleEffectCount == 1) then
        go.BasePoint[1] = UIBubleOnLinePanel.GetBesizerPointcenter_GameObject()
        go.IsInit = true
    elseif (UIBubleOnLinePanel.mBubleEffectCount == 2) then
        go.BasePoint[1] = UIBubleOnLinePanel.GetBesizerPointdown_GameObject()
        go.IsInit = true
    else

        go.gameObject:SetActive(false)
        UIBubleOnLinePanel.mBubleEffectCount = 0
    end
end

--结束泡点
function UIBubleOnLinePanel.OnResOverBubblePointMessage(uiEvtID, data, csdata)
    uimanager:ClosePanel("UIBubleOnLinePanel")
end
--endregion

--endregion

--region 加载特效
function UIBubleOnLinePanel.RefreshEffect(effectName, parent, localPosition, localScale, callBack)
    local bagBtnEffectCallback = function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            if parent == nil or CS.StaticUtility.IsNull(parent) then
                return
            end
            res:ReleaseCallBack()
            local obj = res:GetObjInst()
            obj.transform.parent = parent
            obj.transform.localPosition = localPosition
            obj.transform.localScale = localScale
            if callBack ~= nil then
                callBack(res.Path, obj)
            end
        end
    end
    local csRes = CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.UI)
    if csRes.IsDone then
        bagBtnEffectCallback(csRes)
    else
        csRes.onLoaded:AddFrontCallBack(bagBtnEffectCallback)
    end
end
--endregion

--region 客户端事件处理
function UIBubleOnLinePanel.SetOnFinished()
    if (UIBubleOnLinePanel.GetBubleBtn_TweenPosition().onFinished.Count == 0) then
        UIBubleOnLinePanel.GetBubleBtn_TweenPosition():SetOnFinished(function()
            UIBubleOnLinePanel.GetBubleBtn_Box().enabled = true
            UIBubleOnLinePanel.GetBubleBtn_TweenPosition().to = UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom
            UIBubleOnLinePanel.GetBubleBtn_TweenPosition().from = UIBubleOnLinePanel.GetBubleBtn_TweenPositionto
            if (UIBubleOnLinePanel.mBubbleTipsIsShow) then
                UIBubleOnLinePanel.GetBubleBtnBG_TweenAlpha().duration = 0.5
                UIBubleOnLinePanel.GetBubleBtnBG_TweenAlpha():PlayForward()
                UIBubleOnLinePanel.GetBubleBtnBGBottom_TweenAlpha().duration = 0.5
                UIBubleOnLinePanel.GetBubleBtnBGBottom_TweenAlpha():PlayForward()
                UIBubleOnLinePanel.GetBubleBtnBG_TweenPosition():ResetToBeginning()
                UIBubleOnLinePanel.GetBubleBtnBG_TweenPosition():PlayForward()
            end
        end)
    end
end

function UIBubleOnLinePanel.BubbleBtnOnClick(go)
    UIBubleOnLinePanel.GetBubleBtn_Box().enabled = false
    if (not UIBubleOnLinePanel.mBubbleTipsIsShow) then
        UIBubleOnLinePanel.SetTweenPosition()
        UIBubleOnLinePanel.GetBubleBtn_TweenPosition():ResetToBeginning()
        UIBubleOnLinePanel.GetBubletips_GameObject():SetActive(true)
        UIBubleOnLinePanel.GetBubleBtn_TweenPosition():PlayForward()
        UIBubleOnLinePanel.GetBubleBtn_TweenWidth():ResetToBeginning()
        UIBubleOnLinePanel.GetBubleBtn_TweenWidth():PlayForward()
    else
        UIBubleOnLinePanel.GetBubletips_GameObject():SetActive(false)
        UIBubleOnLinePanel.GetBubleBtnBG_TweenAlpha().duration = 0.01
        UIBubleOnLinePanel.GetBubleBtnBGBottom_TweenAlpha().duration = 0.01
        UIBubleOnLinePanel.GetBubleBtn_TweenPosition():ResetToBeginning()
        UIBubleOnLinePanel.GetBubleBtn_TweenPosition():PlayForward()
        UIBubleOnLinePanel.GetBubleBtnBG_TweenAlpha():PlayReverse()
        UIBubleOnLinePanel.GetBubleBtnBGBottom_TweenAlpha():PlayReverse()
        UIBubleOnLinePanel.GetBubleBtnBGBottom_UISprite().width = 136
    end
    UIBubleOnLinePanel.mBubbleTipsIsShow = not UIBubleOnLinePanel.mBubbleTipsIsShow
end

function UIBubleOnLinePanel.SetTweenPosition()
    local pos = UIBubleOnLinePanel.GetBubleBtnRoot_Transform().localPosition
    if (pos.x <= 0) then
        if (pos.x - 144 > -UIBubleOnLinePanel.mScreenWidth * 0.5 + UIBubleOnLinePanel.GetBubleBtn_UISprite().width * 0.5) then
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionto = CS.UnityEngine.Vector3(pos.x - 144, pos.y, 0)
        else
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionto = CS.UnityEngine.Vector3(-UIBubleOnLinePanel.mScreenWidth * 0.5 + UIBubleOnLinePanel.GetBubleBtn_UISprite().width * 0.5, pos.y, 0)
        end
    else
        if (pos.x - 144 + UIBubleOnLinePanel.GetBubleBtn_TweenWidth().to < UIBubleOnLinePanel.mScreenWidth * 0.5 - UIBubleOnLinePanel.GetBubleBtn_UISprite().width * 0.5) then
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionto = CS.UnityEngine.Vector3(pos.x - 144, pos.y, 0)
        else
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UIBubleOnLinePanel.GetBubleBtn_TweenPositionto = CS.UnityEngine.Vector3(pos.x - UIBubleOnLinePanel.GetBubleBtn_TweenWidth().to + UIBubleOnLinePanel.GetBubleBtn_UISprite().width * 0.5, pos.y, 0)
        end
    end

    UIBubleOnLinePanel.GetBubleBtn_TweenPosition().to = UIBubleOnLinePanel.GetBubleBtn_TweenPositionto
    UIBubleOnLinePanel.GetBubleBtn_TweenPosition().from = UIBubleOnLinePanel.GetBubleBtn_TweenPositionfrom
end

function UIBubleOnLinePanel.HideBubblePanel()
    if (UIBubleOnLinePanel.mBubbleTipsIsShow and UIBubleOnLinePanel.GetBubleBtn_Box().enabled) then
        UIBubleOnLinePanel.BubbleBtnOnClick()
    end
end
--endregion

--region 服务器消息处理

--endregion

return UIBubleOnLinePanel