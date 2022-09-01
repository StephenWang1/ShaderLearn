local UIRewardShowTipPanel = {}

UIRewardShowTipPanel.IsInitialLoad = true
--region 局部变量

UIRewardShowTipPanel.EnterCallBack = nil
UIRewardShowTipPanel.CloseCallBack = nil
UIRewardShowTipPanel.TweenEndCallBack = nil
UIRewardShowTipPanel.TweenTarget = nil
UIRewardShowTipPanel.TargetLevle = 150
UIRewardShowTipPanel.tweenType = 0
UIRewardShowTipPanel.data = nil
UIRewardShowTipPanel.isGet = false
UIRewardShowTipPanel.iEnumClosePanel = nil
UIRewardShowTipPanel.iEnumSpriteAniStartQuick = nil
UIRewardShowTipPanel.iEnumSpriteAniMid = nil
UIRewardShowTipPanel.iEnumSpriteAniEnd = nil
UIRewardShowTipPanel.SpriteGo = nil
--endregion

--region 初始化

function UIRewardShowTipPanel:Init()
    self:InitComponents()
    UIRewardShowTipPanel.BindUIEvents()
    UIRewardShowTipPanel.BindNetMessage()

end

--- 初始化组件
function UIRewardShowTipPanel:InitComponents()
    ---@type UnityEngine.GameObject 遮罩
    UIRewardShowTipPanel.mainBg = self:GetCurComp("WidgetRoot/RewardPanel/window/mainBg", "GameObject")
    ---@type UnityEngine.GameObject 领取按钮
    UIRewardShowTipPanel.btn_Get = self:GetCurComp("WidgetRoot/RewardPanel/event/btn_Get", "GameObject")
    ---@type UnityEngine.GameObject Icon
    UIRewardShowTipPanel.spr_animation = self:GetCurComp("WidgetRoot/spr_animation", "Top_UISpriteAnimation")
    ---@type UnityEngine.GameObject Icon
    UIRewardShowTipPanel.spr_animation1 = self:GetCurComp("WidgetRoot/TweenPosition1", "GameObject")
    ---@type UnityEngine.GameObject Icon
    UIRewardShowTipPanel.spr_animation2 = self:GetCurComp("WidgetRoot/TweenPosition2", "GameObject")
    ---@type UnityEngine.GameObject Icon
    UIRewardShowTipPanel.spr_animation3 = self:GetCurComp("WidgetRoot/TweenPosition3", "GameObject")
    ---@type UnityEngine.GameObject Icon
    UIRewardShowTipPanel.spr_Sprite = self:GetCurComp("WidgetRoot/spr_animation", "UISprite")
    ---@type Top_UISprite 标题文本
    UIRewardShowTipPanel.title = self:GetCurComp("WidgetRoot/RewardPanel/title", "Top_UISprite")
    ---@type Top_UISprite 内容文本
    UIRewardShowTipPanel.lb_decTips = self:GetCurComp("WidgetRoot/RewardPanel/lb_decTips", "Top_UISprite")
    ---@type UnityEngine.GameObject 待开启图片
    UIRewardShowTipPanel.Dis = self:GetCurComp("WidgetRoot/RewardPanel/event/Dis", "GameObject")
    ---@type Top_UILabel 待开启等级
    UIRewardShowTipPanel.disLabel = self:GetCurComp("WidgetRoot/RewardPanel/event/Dis/label", "Top_UILabel")
    ---@type UnityEngine.GameObject 信息面板
    UIRewardShowTipPanel.RewardPanel = self:GetCurComp("WidgetRoot/RewardPanel", "GameObject")
    ---@type UnityEngine.Transform  背景
    UIRewardShowTipPanel.mainBg = self:GetCurComp("WidgetRoot/RewardPanel/window/mainBg", "Transform")
    ---@type UnityEngine.GameObject 关闭按钮
    UIRewardShowTipPanel.btn_close = self:GetCurComp("WidgetRoot/RewardPanel/event/btn_close", "GameObject")
    ---@type Top_UILabel 倒计时文本
    UIRewardShowTipPanel.timeLabel = self:GetCurComp("WidgetRoot/Time", "Top_UILabel")
    UIRewardShowTipPanel.TweenTargetTransform = self:GetCurComp("WidgetRoot/targetTransform", "Transform")
end

function UIRewardShowTipPanel.BindUIEvents()
    --点击事件
    CS.UIEventListener.Get(UIRewardShowTipPanel.mainBg.gameObject).onClick = UIRewardShowTipPanel.OnCloseBtnClick
    CS.UIEventListener.Get(UIRewardShowTipPanel.btn_close).onClick = UIRewardShowTipPanel.OnCloseBtnClick
    --点击事件
    CS.UIEventListener.Get(UIRewardShowTipPanel.btn_Get).onClick = UIRewardShowTipPanel.OnGetBtnClick
end

function UIRewardShowTipPanel.BindNetMessage()
    --监听客户端升级事件
    UIRewardShowTipPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLevelPacksInfoMessage, UIRewardShowTipPanel.OnResLevelPacksInfoMessageCallBack)
end

function UIRewardShowTipPanel.OnResLevelPacksInfoMessageCallBack(id, data)
    if data and not UIRewardShowTipPanel.isShieldNetEVent then
        UIRewardShowTipPanel.data.IsGet = data.isDraw
    end
end

---显示弹窗界面
---在调用uimanager:CreatePanel("UIRewardShowTipPanel", table)时传入data,不要单独调用
---@param data table
---{
---@field data.id               number id
---@field data.Content          string tips内容
---@field data.ItemIcon         string 物品Icon
---@field data.TargetLv         string 目标等级
---@field data.IsOpenClick      boolean 按钮是否开启
---@field data.IsGet            boolean 是否能获取
---@field data.waitTime         number  等待时间
---@field data.tweenType        number  飞入类型
---@field data.TweenTarget      UnityEngine.Transform 动画移动目标
---@field data.EnterCallBack    function 确认回调
---@field data.CloseCallBack    function 关闭回调
---@field data.TweenEndCallBack function 动画结束回调
---@field data.isShieldNetEVent boolean  是否屏蔽服务器消息
---}
function UIRewardShowTipPanel:Show(data)
    if data then
        UIRewardShowTipPanel.data = data
        UIRewardShowTipPanel.isShieldNetEVent = data.isShieldNetEVent ~= nil and data.isShieldNetEVent
        UIRewardShowTipPanel.SetPanel()
    end
end

--endregion

--region UI事件监听

function UIRewardShowTipPanel.OnGetBtnClick(go)
    if UIRewardShowTipPanel.data == nil then
        return
    end
    -- 处理按钮等额外消失
    if UIRewardShowTipPanel.iEnumClosePanel ~= nil then
        StopCoroutine(UIRewardShowTipPanel.iEnumClosePanel)
        UIRewardShowTipPanel.iEnumClosePanel = nil
    end
    if (UIRewardShowTipPanel.iEnumSpriteAniStart ~= nil) then
        StopCoroutine(UIRewardShowTipPanel.iEnumSpriteAniStart)
    end
    --特殊类型特殊操作
    if UIRewardShowTipPanel.data.TweenTarget == nil or UIRewardShowTipPanel.data.tweenType == LuaEnumFlyPos.None then
        if UIRewardShowTipPanel.EnterCallBack ~= nil then
            UIRewardShowTipPanel.EnterCallBack()
        end
        uimanager:ClosePanel('UIRewardShowTipPanel')
        return
    end

    UIRewardShowTipPanel.iEnumSpriteAniStartQuick = StartCoroutine(UIRewardShowTipPanel.IenumSpriteAnimationStartQuick, UIRewardShowTipPanel.SpriteGo)
    UIRewardShowTipPanel.lb_decTips.gameObject:SetActive(false)
    UIRewardShowTipPanel.title.gameObject:SetActive(false)
    UIRewardShowTipPanel.btn_close:SetActive(false)
    UIRewardShowTipPanel.timeLabel.gameObject:SetActive(false)
    CS.UIEventListener.Get(UIRewardShowTipPanel.mainBg.gameObject).onClick = nil
    ---判断左上幻兽面板是否处于缩放状态
end

function UIRewardShowTipPanel.OnCloseBtnClick(go)
    if UIRewardShowTipPanel.data.IsGet and not UIRewardShowTipPanel.data.IsOpenClick then
        UIRewardShowTipPanel.OnGetBtnClick()
        return
    end
    Utility.ShowUnionPushPrompt()
    uimanager:ClosePanel('UIRewardShowTipPanel')
end

--endregion

--region UI

function UIRewardShowTipPanel.SetPanel()
    UIRewardShowTipPanel.SpriteGo = UIRewardShowTipPanel.spr_animation1
    UIRewardShowTipPanel.btn_Get:SetActive(false)
    --UIRewardShowTipPanel.spr_animation.gameObject:SetActive(true)
    if (UIRewardShowTipPanel.data.id == 1) then
        UIRewardShowTipPanel.spr_animation1:SetActive(true)
        UIRewardShowTipPanel.spr_animation2:SetActive(false)
        UIRewardShowTipPanel.spr_animation3:SetActive(false)
    elseif (UIRewardShowTipPanel.data.id == 2) then
        UIRewardShowTipPanel.SpriteGo = UIRewardShowTipPanel.spr_animation2
        UIRewardShowTipPanel.spr_animation1:SetActive(false)
        UIRewardShowTipPanel.spr_animation3:SetActive(false)
        UIRewardShowTipPanel.spr_animation2:SetActive(true)
    elseif (UIRewardShowTipPanel.data.id == 3) then
        UIRewardShowTipPanel.SpriteGo = UIRewardShowTipPanel.spr_animation3
        UIRewardShowTipPanel.spr_animation1:SetActive(false)
        UIRewardShowTipPanel.spr_animation2:SetActive(false)
        UIRewardShowTipPanel.spr_animation3:SetActive(true)
    end

    UIRewardShowTipPanel.RewardPanel:SetActive(true)
    --设置Icon
    --UIRewardShowTipPanel.spr_animation:GetComponent('UISprite').spriteName = UIRewardShowTipPanel.data.ItemIcon
    --设置标题
    UIRewardShowTipPanel.title.gameObject:SetActive(true)
    UIRewardShowTipPanel.title.spriteName = 'title' .. UIRewardShowTipPanel.data.id
    --设置内容文字
    --UIRewardShowTipPanel.lb_decTips.spriteName = UIRewardShowTipPanel.data.Content --'showTips' .. UIRewardShowTipPanel.data.id
    --设置目标等级
    UIRewardShowTipPanel.TargetLevle = tonumber(UIRewardShowTipPanel.data.TargetLv)
    --设置回调
    UIRewardShowTipPanel.EnterCallBack = UIRewardShowTipPanel.data.EnterCallBack
    UIRewardShowTipPanel.CloseCallBack = UIRewardShowTipPanel.data.CloseCallBack
    UIRewardShowTipPanel.TweenEndCallBack = UIRewardShowTipPanel.data.TweenEndCallBack
    UIRewardShowTipPanel.TweenTarget = UIRewardShowTipPanel.data.TweenTarget
    UIRewardShowTipPanel.tweenType = UIRewardShowTipPanel.data.tweenType
    --设置按钮
    UIRewardShowTipPanel.SetUiStatu()

end

---切换UI状态
function UIRewardShowTipPanel.SetUiStatu()
    UIRewardShowTipPanel.btn_Get:SetActive(UIRewardShowTipPanel.data.IsGet and UIRewardShowTipPanel.data.IsOpenClick)
    UIRewardShowTipPanel.Dis.gameObject:SetActive(false)
    UIRewardShowTipPanel.timeLabel.gameObject:SetActive(UIRewardShowTipPanel.data.IsGet and not UIRewardShowTipPanel.data.IsOpenClick)
    --设置内容文字
    UIRewardShowTipPanel.lb_decTips.spriteName = not UIRewardShowTipPanel.data.IsGet and 'showTips' .. UIRewardShowTipPanel.data.id or 'showTips' .. UIRewardShowTipPanel.data.id .. '_1'
    if not UIRewardShowTipPanel.data.IsGet then
        --local level = CS.CSScene.MainPlayerInfo.Level
        --local a, b = math.modf(UIRewardShowTipPanel.TargetLevle - level)
        --UIRewardShowTipPanel.Dis.transform:Find('label'):GetComponent('UILabel').text = UIRewardShowTipPanel.TargetLevle .. '级开启'
        UIRewardShowTipPanel.disLabel.text = UIRewardShowTipPanel.TargetLevle == nil and '' or tostring(UIRewardShowTipPanel.TargetLevle)
    else
        UIRewardShowTipPanel.StartRefreshTime()
    end
end

--endregion

--region 消息处理

function UIRewardShowTipPanel.OnLevleChangCallBack(id, oldLev, curLev)
    if curLev ~= 0 then
        --判断是否达到目标等级
        UIRewardShowTipPanel.data.IsGet = curLev >= UIRewardShowTipPanel.TargetLevle
        UIRewardShowTipPanel.SetUiStatu()
    end
end

--endregion

--region otherFunction

--region 动画

function UIRewardShowTipPanel.StartTween()
    ---有Tween动画时执行动画及动画回调，无执行点击领取回调
    --[[    if UIRewardShowTipPanel.TweenTarget ~= nil then

            UIRewardShowTipPanel.spr_animation.OnFinish = function()
                if (UIRewardShowTipPanel.data.id == 1) then
                    UIRewardShowTipPanel.spr_animation.namePrefix = "bluestart"
                elseif (UIRewardShowTipPanel.data.id == 2) then
                    UIRewardShowTipPanel.spr_animation.namePrefix = "yellowstart"
                elseif (UIRewardShowTipPanel.data.id == 3) then
                    UIRewardShowTipPanel.spr_animation.namePrefix = "greenstart"
                end
                UIRewardShowTipPanel.spr_animation:ResetToBeginning()
                UIRewardShowTipPanel.spr_animation:Play()
                UIRewardShowTipPanel.spr_animation.OnFinish = nil
                UIRewardShowTipPanel.spr_animation.OnFinish = function()
                    if (UIRewardShowTipPanel.data.id == 1) then
                        UIRewardShowTipPanel.spr_animation.namePrefix = "bluemid"
                    elseif (UIRewardShowTipPanel.data.id == 2) then
                        UIRewardShowTipPanel.spr_animation.namePrefix = "yellowmid"
                    elseif (UIRewardShowTipPanel.data.id == 3) then
                        UIRewardShowTipPanel.spr_animation.namePrefix = "greenmid"
                    end
                    UIRewardShowTipPanel.spr_animation:ResetToBeginning()
                    UIRewardShowTipPanel.spr_animation:Play()
                    UIRewardShowTipPanel.TweenScallCallBack()
                    UIRewardShowTipPanel.spr_animation.OnFinish = nil
                end
            end]]
    local tweenAlpha = CS.Utility_Lua.GetComponent(UIRewardShowTipPanel.mainBg, "TweenAlpha")
    --先进性缩小和渐变处理
    if tweenAlpha then
        --tweenScale:SetOnFinished(UIRewardShowTipPanel.TweenScallCallBack)

        tweenAlpha:PlayTween()
    end
    --[[    else
        点击回调
        if UIRewardShowTipPanel.EnterCallBack ~= nil then
            UIRewardShowTipPanel.EnterCallBack()
            uimanager:ClosePanel('UIRewardShowTipPanel')
        end
        end]]
end

function UIRewardShowTipPanel.TweenPosCallBack()
    if UIRewardShowTipPanel.TweenEndCallBack ~= nil then
        UIRewardShowTipPanel.TweenEndCallBack()
    end
    if UIRewardShowTipPanel.EnterCallBack ~= nil then
        UIRewardShowTipPanel.EnterCallBack()
    end
    --[[    if (UIRewardShowTipPanel.data.id == 1) then
            UIRewardShowTipPanel.spr_animation.namePrefix = "blueend"
        elseif (UIRewardShowTipPanel.data.id == 2) then
            UIRewardShowTipPanel.spr_animation.namePrefix = "yellowend"
        elseif (UIRewardShowTipPanel.data.id == 3) then
            UIRewardShowTipPanel.spr_animation.namePrefix = "greenend"
        end
        UIRewardShowTipPanel.spr_animation:ResetToBeginning()
        UIRewardShowTipPanel.spr_animation:Play()
        UIRewardShowTipPanel.spr_animation.OnFinish = function()]]
    uimanager:ClosePanel('UIRewardShowTipPanel')
    --UIRewardShowTipPanel.spr_animation.OnFinish = nil
end

function UIRewardShowTipPanel.TweenScallCallBack(go)
    local go = go
    local tweenPos = CS.Utility_Lua.GetComponent(go, "Top_TweenPosition")
    ----设置目标
    tweenPos.to = tweenPos.transform.parent:InverseTransformPoint(UIRewardShowTipPanel.data.TweenTarget.position)
    ----设置动画回调
    tweenPos:SetOnFinished(function()
        go.transform:Find("spr_animation3").gameObject:SetActive(false)
        UIRewardShowTipPanel.iEnumSpriteAniEnd = StartCoroutine(UIRewardShowTipPanel.IEnumSpriteAnimationEnd, go)
        if UIRewardShowTipPanel.TweenEndCallBack ~= nil then
            UIRewardShowTipPanel.TweenEndCallBack()
        end
        if UIRewardShowTipPanel.EnterCallBack ~= nil then
            UIRewardShowTipPanel.EnterCallBack()
        end
    end)
    tweenPos:PlayTween()
end

--endregion

function UIRewardShowTipPanel.StartRefreshTime()
    if not UIRewardShowTipPanel.data.IsOpenClick then
        if UIRewardShowTipPanel.iEnumClosePanel ~= nil then
            StopCoroutine(UIRewardShowTipPanel.iEnumClosePanel)
            UIRewardShowTipPanel.iEnumClosePanel = nil
        end
        UIRewardShowTipPanel.iEnumClosePanel = StartCoroutine(UIRewardShowTipPanel.IEnumClosePanel)
    end
end

function UIRewardShowTipPanel.IEnumClosePanel()
    local isShow = true
    local time = 3
    while isShow do
        if time <= 0 then
            isShow = false
            UIRewardShowTipPanel.timeLabel.text = '0'
            UIRewardShowTipPanel.OnCloseBtnClick()
        else
            UIRewardShowTipPanel.timeLabel.text = tostring(time)
        end
        time = time - 1
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIRewardShowTipPanel.IenumSpriteAnimationStartQuick(go)
    go.transform:Find("spr_animation1").gameObject:SetActive(false)
    go.transform:Find("spr_animation2").gameObject:SetActive(true)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.8))
    go.transform:Find("spr_animation2").gameObject:SetActive(false)
    UIRewardShowTipPanel.iEnumSpriteAniMid = StartCoroutine(UIRewardShowTipPanel.IEnumSpriteAnimationMid, go)
end

function UIRewardShowTipPanel.IEnumSpriteAnimationMid(go)
    go.transform:Find("spr_animation3").gameObject:SetActive(true)
    UIRewardShowTipPanel:StartTween()
    UIRewardShowTipPanel.TweenScallCallBack(go)
end

function UIRewardShowTipPanel.IEnumSpriteAnimationEnd(go)
    go.transform:Find("spr_animation4").gameObject:SetActive(true)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    go.transform:Find("spr_animation4").gameObject:SetActive(false)
    uimanager:ClosePanel('UIRewardShowTipPanel')
end
--endregion

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResLevelPacksInfoMessage, UIRewardShowTipPanel.OnResLevelPacksInfoMessageCallBack)
    if UIRewardShowTipPanel.iEnumClosePanel ~= nil then
        StopCoroutine(UIRewardShowTipPanel.iEnumClosePanel)
        UIRewardShowTipPanel.iEnumClosePanel = nil
    end

    if (UIRewardShowTipPanel.iEnumSpriteAniStartQuick ~= nil) then
        StopCoroutine(UIRewardShowTipPanel.iEnumSpriteAniStartQuick)
    end

    if (UIRewardShowTipPanel.iEnumSpriteAniMid ~= nil) then
        StopCoroutine(UIRewardShowTipPanel.iEnumSpriteAniMid)
    end
    if (UIRewardShowTipPanel.iEnumSpriteAniEnd ~= nil) then
        StopCoroutine(UIRewardShowTipPanel.iEnumSpriteAniEnd)
    end
    if UIRewardShowTipPanel.CloseCallBack ~= nil then
        UIRewardShowTipPanel.CloseCallBack()
    end
    --if UIRewardShowTipPanel.CloseCallBack ~= nil then
    --    UIRewardShowTipPanel.CloseCallBack()
    --end

end

return UIRewardShowTipPanel