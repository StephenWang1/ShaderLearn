---@class UISpyPanel 间谍tips
local UISpyPanel = {}

--region 局部变量
UISpyPanel.mScreenWidth = CS.UnityEngine.Screen.width
UISpyPanel.mScreenHeight = CS.UnityEngine.Screen.height
UISpyPanel.topTweenPosFrom = nil
UISpyPanel.topTweenPosTo = nil
UISpyPanel.tipsShow = true
UISpyPanel.refreshTime = nil
--endregion

--region 初始化

function UISpyPanel:Init()
    self:InitComponents()
    UISpyPanel.BindUIEvents()
    UISpyPanel.InitUI()
    UISpyPanel.SetOnFinished()
end

--- 初始化组件
function UISpyPanel:InitComponents()
    ---@type Top_TweenPosition
    UISpyPanel.paodianTopTweenPos = self:GetCurComp("WidgetRoot/paodian_top", "Top_TweenPosition")
    ---@type Top_TweenAlpha
    UISpyPanel.bgkuangtweemAlpha = self:GetCurComp("WidgetRoot/paodian_top/bgkuang", "Top_TweenAlpha")
    ---@type Top_TweenWidth
    UISpyPanel.bgkuangSprite = self:GetCurComp("WidgetRoot/paodian_top/bgkuang", "Top_UISprite")
    ---@type Top_TweenWidth
    UISpyPanel.bgkuangtweemWidth = self:GetCurComp("WidgetRoot/paodian_top/bgkuang", "Top_TweenWidth")
    ---@type Top_TweenPosition
    UISpyPanel.tipsTweenPos = self:GetCurComp("WidgetRoot/paodian_top/panel/tips", "Top_TweenPosition")
    ---@type Top_TweenAlpha
    UISpyPanel.tipsTweenAlpha = self:GetCurComp("WidgetRoot/paodian_top/panel/tips", "Top_TweenAlpha")
    ---@type Top_UILabel 公会文本
    UISpyPanel.tipsLabel = self:GetCurComp("WidgetRoot/paodian_top/panel/tips/tips_0/tips_0_1", "Top_UILabel")
    ---@type Top_UILabel 时间文本
    UISpyPanel.time = self:GetCurComp("WidgetRoot/paodian_top/time", "Top_UILabel")
    ---@type UnityEngine.GameObject
    UISpyPanel.bg = self:GetCurComp("WidgetRoot/paodian_top/bg", "GameObject")
    ---@type UnityEngine.GameObject
    UISpyPanel.bgSprite = self:GetCurComp("WidgetRoot/paodian_top/bg", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UISpyPanel.bgCollider = self:GetCurComp("WidgetRoot/paodian_top/bg", "BoxCollider")
end

function UISpyPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UISpyPanel.bg).onClick = UISpyPanel.OnClickbg
    UISpyPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_NormalClickEvent, UISpyPanel.HideBubblePanel)
end

--endregion

--region 函数监听

--点击函数
---@param go UnityEngine.GameObject
function UISpyPanel.OnClickbg(go)
    UISpyPanel.StartTween()
end

--endregion

--region UI

function UISpyPanel.InitUI()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.mSpyInfo ~= nil then
        UISpyPanel.tipsLabel.text = CS.CSScene.MainPlayerInfo.mSpyInfo.unionName .. '公会'
        UISpyPanel.refreshTime = StartCoroutine(UISpyPanel.IRefreshTime, CS.CSScene.MainPlayerInfo.mSpyInfo.remainTime)
    end

end

function UISpyPanel.HideBubblePanel()
    if UISpyPanel.tipsShow and UISpyPanel.bgCollider.enabled then
        UISpyPanel.StartTween()
    end
end--endregion

--region otherFunction

function UISpyPanel.IRefreshTime(time)
    local isRefresh = true
    local targetTime = time/1000
    local decimal
    targetTime, decimal = math.modf(targetTime)
    while isRefresh do
        if targetTime <= 0 then
            isRefresh = false
            targetTime = 0
            uimanager:ClosePanel('UISpyPanel')
        end
        UISpyPanel.time.text = targetTime
        targetTime = targetTime - 1
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

--region 动画

function UISpyPanel.SetOnFinished()
    if UISpyPanel.paodianTopTweenPos.onFinished.Count == 0 then
        UISpyPanel.paodianTopTweenPos:SetOnFinished(UISpyPanel.TweenFinish)
    end
end

---设置tips状态（展开收回）
function UISpyPanel.StartTween()
    UISpyPanel.bgCollider.enabled = false
    if not UISpyPanel.tipsShow then
        UISpyPanel.SetTweenPosition()
        UISpyPanel.paodianTopTweenPos:ResetToBeginning()
        UISpyPanel.tipsLabel.gameObject:SetActive(true)
        UISpyPanel.paodianTopTweenPos:PlayForward()
        UISpyPanel.bgkuangtweemWidth:ResetToBeginning()
        UISpyPanel.bgkuangtweemWidth:PlayForward()
    else
        UISpyPanel.tipsLabel.gameObject:SetActive(false)
        UISpyPanel.tipsTweenAlpha.duration = 0.01
        UISpyPanel.bgkuangtweemAlpha.duration = 0.01
        UISpyPanel.paodianTopTweenPos:ResetToBeginning()
        UISpyPanel.paodianTopTweenPos:PlayForward()
        UISpyPanel.tipsTweenAlpha:PlayReverse()
        UISpyPanel.bgkuangtweemAlpha:PlayReverse()
        UISpyPanel.bgkuangSprite.width = 136
    end
    UISpyPanel.tipsShow = not UISpyPanel.tipsShow
end

function UISpyPanel.SetTweenPosition()
    local pos = UISpyPanel.paodianTopTweenPos.transform.localPosition
    if (pos.x <= 0) then
        if (pos.x - 133 > -UISpyPanel.mScreenWidth * 0.5 + UISpyPanel.bgSprite.width * 0.5) then
            UISpyPanel.topTweenPosFrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UISpyPanel.topTweenPosTo = CS.UnityEngine.Vector3(pos.x - 133, pos.y, 0)
        else
            UISpyPanel.topTweenPosFrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UISpyPanel.topTweenPosTo = CS.UnityEngine.Vector3(-UISpyPanel.mScreenWidth * 0.5 + UISpyPanel.bgSprite.width * 0.5, pos.y, 0)
        end
    else
        if (pos.x - 133 + UISpyPanel.bgkuangtweemWidth.to < UISpyPanel.mScreenWidth * 0.5 - UISpyPanel.bgSprite.width * 0.5) then
            UISpyPanel.topTweenPosFrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UISpyPanel.topTweenPosTo = CS.UnityEngine.Vector3(pos.x - 133, pos.y, 0)
        else
            UISpyPanel.topTweenPosFrom = CS.UnityEngine.Vector3(pos.x, pos.y, 0)
            UISpyPanel.topTweenPosTo = CS.UnityEngine.Vector3(pos.x - UISpyPanel.bgkuangtweemWidth.to + UISpyPanel.bgSprite.width * 0.5, pos.y, 0)
        end
    end

    UISpyPanel.paodianTopTweenPos.to = UISpyPanel.topTweenPosTo
    UISpyPanel.paodianTopTweenPos.from = UISpyPanel.topTweenPosFrom
end

---动画完成
function UISpyPanel.TweenFinish()
    UISpyPanel.bgCollider.enabled = true
    UISpyPanel.paodianTopTweenPos.to = UISpyPanel.topTweenPosFrom
    UISpyPanel.paodianTopTweenPos.from = UISpyPanel.topTweenPosTo
    if UISpyPanel.tipsShow then
        UISpyPanel.bgkuangtweemAlpha.duration = 0.5
        UISpyPanel.bgkuangtweemAlpha:PlayForward()
        UISpyPanel.tipsTweenAlpha.duration = 0.5
        UISpyPanel.tipsTweenAlpha:PlayForward()
        UISpyPanel.tipsTweenPos:ResetToBeginning()
        UISpyPanel.tipsTweenPos:PlayForward()
    end
end

--endregion

--endregion

--region ondestroy

function ondestroy()
    if UISpyPanel.refreshTime ~= nil then
        StopCoroutine(UISpyPanel.refreshTime)
        UISpyPanel.refreshTime = nil
    end
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UISpyPanel