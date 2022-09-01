---@class UIBattleDreamlandLeftMainPanel:UIBase 梦境左侧面板
local UIBattleDreamlandLeftMainPanel = {}

--region 局部变量
UIBattleDreamlandLeftMainPanel.showTips_bool = true
UIBattleDreamlandLeftMainPanel.fireworkID = 6100001
UIBattleDreamlandLeftMainPanel.IEnumTimeChange = nil
UIBattleDreamlandLeftMainPanel.MagnificatValue = 1
UIBattleDreamlandLeftMainPanel.ienumWaitTime = 1
--endregion

--region 初始化

function UIBattleDreamlandLeftMainPanel:Init()
    self:InitComponents()
    UIBattleDreamlandLeftMainPanel.BindUIEvents()
    UIBattleDreamlandLeftMainPanel.BindNetMessage()
    UIBattleDreamlandLeftMainPanel.RefreshUI()
    UIBattleDreamlandLeftMainPanel.RefreshTime()
end

--- 初始化组件
function UIBattleDreamlandLeftMainPanel:InitComponents()
    ---@type Top_UILabel title
    UIBattleDreamlandLeftMainPanel.lb_name = self:GetCurComp("WidgetRoot/Tween/view/lb_name", "Top_UILabel")
    ---@type Top_UILabel 时间
    UIBattleDreamlandLeftMainPanel.time = self:GetCurComp("WidgetRoot/Tween/Slider/time", "Top_UILabel")
    ---@type Top_UISlider 时间进度
    UIBattleDreamlandLeftMainPanel.Slider = self:GetCurComp("WidgetRoot/Tween/Slider", "Top_UISlider")
    ---@type Top_UILabel 梦境剩余时间
    UIBattleDreamlandLeftMainPanel.lb_activetime = self:GetCurComp("WidgetRoot/Tween/view/lb_time/lb_activetime", "Top_UILabel")
    ---@type UnityEngine.GameObject 退出
    UIBattleDreamlandLeftMainPanel.btn_sure = self:GetCurComp("WidgetRoot/Tween/events/btn_sure", "GameObject")
    ---@type UnityEngine.GameObject 箭头
    UIBattleDreamlandLeftMainPanel.BtnHide = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject")
    ---@type UnityEngine.GameObject 帮助
    UIBattleDreamlandLeftMainPanel.btn_help = self:GetCurComp("WidgetRoot/Tween/events/btn_help", "Top_UISprite")
    ---@type Top_TweenAlpha 添加按钮闪烁
    UIBattleDreamlandLeftMainPanel.btn_addTween = self:GetCurComp("WidgetRoot/Tween/view/lb_time/lb_activetime/btn_add", "Top_TweenAlpha")
    ---@type Top_TweenAlpha 时间闪烁
    UIBattleDreamlandLeftMainPanel.timeTween = self:GetCurComp("WidgetRoot/Tween/Slider/time", "Top_TweenAlpha")
    ---@type Top_TweenAlpha 剩余时间闪烁
    UIBattleDreamlandLeftMainPanel.lb_activetimeTween = self:GetCurComp("WidgetRoot/Tween/view/lb_time/lb_activetime", "Top_TweenAlpha")
    ---@type Top_UILabel 倍率
    UIBattleDreamlandLeftMainPanel.double = self:GetCurComp("WidgetRoot/Tween/view/double", "Top_UILabel")
    ---@type Top_UILabel 属性加成
    UIBattleDreamlandLeftMainPanel.addAttackValue = self:GetCurComp("WidgetRoot/Tween/view/lb_addAttack/addAttackValue", "Top_UILabel")
    ---@type Top_TweenPosition
    UIBattleDreamlandLeftMainPanel.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")

end

function UIBattleDreamlandLeftMainPanel.BindUIEvents()
    --点击退出事件
    CS.UIEventListener.Get(UIBattleDreamlandLeftMainPanel.btn_sure).onClick = UIBattleDreamlandLeftMainPanel.OnClickbtn_sure
    --点击箭头事件
    CS.UIEventListener.Get(UIBattleDreamlandLeftMainPanel.BtnHide).onClick = UIBattleDreamlandLeftMainPanel.OnClickBtnHide
    --点击添加事件
    CS.UIEventListener.Get(UIBattleDreamlandLeftMainPanel.btn_addTween.gameObject).onClick = UIBattleDreamlandLeftMainPanel.OnClickbtn_add
    --点击帮助事件
    CS.UIEventListener.Get(UIBattleDreamlandLeftMainPanel.btn_help.gameObject).onClick = UIBattleDreamlandLeftMainPanel.OnClickbtn_help
end

function UIBattleDreamlandLeftMainPanel.BindNetMessage()
    UIBattleDreamlandLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResWolfDreamTimeMessage, UIBattleDreamlandLeftMainPanel.OnResWolfDreamTimeMessageCallBack)
    UIBattleDreamlandLeftMainPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateBasicInfoMessage, UIBattleDreamlandLeftMainPanel.OnResDuplicateBasicInfoMessageCallBack)
    UIBattleDreamlandLeftMainPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshCurXpSkillId, UIBattleDreamlandLeftMainPanel.OnRefreshCurXpSkillIdCallBack)
end
--endregion

--region 函数监听
--点击退出函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandLeftMainPanel.OnClickbtn_sure(go)
    Utility.ReqExitDuplicate()
    -- networkRequest.ReqExitDuplicate(0)
    -- uimanager:ClosePanel('UIBattleDreamlandLeftMainPanel')
end
--点击箭头函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandLeftMainPanel.OnClickBtnHide(go)

    UIBattleDreamlandLeftMainPanel.tween:SetOnFinished(UIBattleDreamlandLeftMainPanel.ClickHideBtnCallBack)
    if UIBattleDreamlandLeftMainPanel.showTips_bool then
        UIBattleDreamlandLeftMainPanel.tween:PlayForward()
        UIBattleDreamlandLeftMainPanel.showTips_bool = false
    else
        UIBattleDreamlandLeftMainPanel.tween:PlayReverse()
        UIBattleDreamlandLeftMainPanel.showTips_bool = true
    end
end
--点击添加函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandLeftMainPanel.OnClickbtn_add(go)
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIBattleDreamlandLeftMainPanel.fireworkID)
    if count == 0 then
        Utility.ShowItemGetWay(UIBattleDreamlandLeftMainPanel.fireworkID, go, LuaEnumWayGetPanelArrowDirType.Left);
    else
        UIBattleDreamlandLeftMainPanel.ShowDisposeOrePanel(count)
        --UIBattleDreamlandLeftMainPanel.ShowBattleTips()
    end
end

---点击帮助函数
---@param go UnityEngine.GameObject
function UIBattleDreamlandLeftMainPanel.OnClickbtn_help(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(84)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end
---点击隐藏箭头函数
function UIBattleDreamlandLeftMainPanel.ClickHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIBattleDreamlandLeftMainPanel.showTips_bool then
        v3.z = 180
    end
    UIBattleDreamlandLeftMainPanel.BtnHide.transform.localEulerAngles = v3
end

--endregion

--region 网络消息处理
--时间变化
function UIBattleDreamlandLeftMainPanel.OnResWolfDreamTimeMessageCallBack()
    UIBattleDreamlandLeftMainPanel.RefreshTime()
end
--层数改变
function UIBattleDreamlandLeftMainPanel.OnResDuplicateBasicInfoMessageCallBack()
    UIBattleDreamlandLeftMainPanel.RefreshUI()
end

function UIBattleDreamlandLeftMainPanel.OnRefreshCurXpSkillIdCallBack()
    UIBattleDreamlandLeftMainPanel.RefreshIenumWaitTime()
end

--endregion

--region UI

function UIBattleDreamlandLeftMainPanel.RefreshUI()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    --region 标题
    local id = CS.CSScene.MainPlayerInfo.DuplicateV2.CurDreamFloor
    local isFind, info = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        UIBattleDreamlandLeftMainPanel.lb_name.text = info.name
    end
    --endregion

    --region 梦境倍率
    UIBattleDreamlandLeftMainPanel.RefreshMagnificatInfo()
    --endregion

    --region 增伤
    local addAttackInfo = CS.Cfg_GlobalTableManager.Instance:GetLYMJAddAttackName(id)
    UIBattleDreamlandLeftMainPanel.addAttackValue.text = addAttackInfo
    --endregion

    ---刷新锚点
    UIBattleDreamlandLeftMainPanel.btn_help:UpdateAnchors()
end

function UIBattleDreamlandLeftMainPanel.RefreshTime()
    --luaDebug.Log("剩余时间 改变")
    if UIBattleDreamlandLeftMainPanel.IEnumTimeChange ~= nil then
        StopCoroutine(UIBattleDreamlandLeftMainPanel.IEnumTimeChange)
        UIBattleDreamlandLeftMainPanel.IEnumTimeChange = nil
    end
    UIBattleDreamlandLeftMainPanel.IEnumTimeChange = StartCoroutine(UIBattleDreamlandLeftMainPanel.IEnumRefreshTime)
end

---刷新梦境梦境倍率
---@private
function UIBattleDreamlandLeftMainPanel.RefreshMagnificatInfo()
    local id = CS.CSScene.MainPlayerInfo.DuplicateV2.CurDreamFloor
    local magStrInfo = CS.Cfg_GlobalTableManager.Instance:GetLangYanMengjingMagnificat(id)
    if magStrInfo ~= nil and magStrInfo ~= '' then
        local magStr = string.Split(magStrInfo, '#')
        if #magStr == 0 then
            return
        end

        ---更新梦境倍率
        UIBattleDreamlandLeftMainPanel.MagnificatValue = tonumber(magStr[1])

        ---更新显示（需求：当使用xp技能时，仅对数据做修改，界面不做修改）
        local color = ''
        if #magStr > 1 then
            color = magStr[2]
        end
        local MagnificatStr = UIBattleDreamlandLeftMainPanel.MagnificatValue == 1 and color .. "正常" or
                color .. UIBattleDreamlandLeftMainPanel.MagnificatValue .. '倍'
        UIBattleDreamlandLeftMainPanel.double.text = MagnificatStr

        UIBattleDreamlandLeftMainPanel.RefreshIenumWaitTime()
    end
end

--endregion

--region otherFunction

---更新协程等待时间
---@private
function UIBattleDreamlandLeftMainPanel.RefreshIenumWaitTime()
    --luaDebug.Log("更新协程等待时间 改变")
    local MagValue = UIBattleDreamlandLeftMainPanel.ParseMagnificatValue(UIBattleDreamlandLeftMainPanel.MagnificatValue)
    UIBattleDreamlandLeftMainPanel.ienumWaitTime = MagValue == 0 and 1 or 1 / MagValue
    --luaDebug.Log("IenumWait" .. UIBattleDreamlandLeftMainPanel.ienumWaitTime)
end

---梦境倍率特殊处理
---@private
function UIBattleDreamlandLeftMainPanel.ParseMagnificatValue(value)
    ---当前是否有xp技能持续
    local time = LuaGlobalTableDeal:LYMJTimeValueOfXpSkillIdDic()[uiStaticParameter.CurXpSkillId]
    if time ~= nil then
        value = value + time
    end

    --Utility.GetPreciseDecimal(value,value % 1 ~= 0 and 2 or 0)
    return value
end

---刷新剩余时间
function UIBattleDreamlandLeftMainPanel.IEnumRefreshTime()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local duplicateInfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    --已用
    local usedTime = duplicateInfo.UseTime
    --可用
    local uesrTime = duplicateInfo.MaxTime - usedTime
    local remainTime = duplicateInfo.RemainTime
    --local color = fill >= 1 and luaEnumColorType.Red or luaEnumColorType.Green
    local decimal, hour, minute, second
    --local str = ''
    local str2 = ''
    while true do
        if CS.CSScene.MainPlayerInfo.HP > 0 then
            if uesrTime <= 0 or remainTime <= 0 then
                networkRequest.ReqExitDuplicate(0)
                uimanager:ClosePanel('UIBattleDreamlandLeftMainPanel')
            end

            --region 时间进度
            -- local fill = uesrTime / duplicateInfo.MaxTime
            -- UIBattleDreamlandLeftMainPanel.Slider.value = fill
            --endregion

            --region 今日上限时间
            -- hour, minute, second = Utility.MillisecondToFormatTime(uesrTime)
            -- str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
            --UIBattleDreamlandLeftMainPanel.time.text = str
            --UIBattleDreamlandLeftMainPanel.timeTween.enabled = (uesrTime <= 60000)
            --endregion

            --region 可用时间
            hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
            hour, decimal = math.modf(hour)
            minute, decimal = math.modf(minute)
            second, decimal = math.modf(second)
            minute = hour * 60 + minute
            str2 = ''
            --str2 = hour == 0 and str2 or str2 .. hour .. '时'
            str2 = minute == 0 and str2 or str2 .. minute .. '分'
            str2 = second == 0 and str2 or str2 .. second .. '秒'
            -- str2 = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
            UIBattleDreamlandLeftMainPanel.lb_activetime.text = str2
            --endregion

            --region tween动画
            UIBattleDreamlandLeftMainPanel.lb_activetimeTween.enabled = (remainTime <= 60000)
            UIBattleDreamlandLeftMainPanel.btn_addTween.enabled = (remainTime <= 60000)

            if not UIBattleDreamlandLeftMainPanel.showTips_bool and (remainTime <= 60000) then
                UIBattleDreamlandLeftMainPanel.tween:SetOnFinished(UIBattleDreamlandLeftMainPanel.ClickHideBtnCallBack)
                UIBattleDreamlandLeftMainPanel.tween:PlayReverse()
                UIBattleDreamlandLeftMainPanel.showTips_bool = true
            end
            --endregion

            uesrTime = uesrTime - 1000
            remainTime = remainTime - 1000
            duplicateInfo.RemainTime = remainTime

            --luaDebug.Log("时间 ：" .. str2)
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(UIBattleDreamlandLeftMainPanel.ienumWaitTime))
    end
end

---显示使用烟花tips
function UIBattleDreamlandLeftMainPanel.ShowBattleTips()
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20424)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = function()
            UIBattleDreamlandLeftMainPanel.TipsBtnCallBack()
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

---烟花tips点击回调
function UIBattleDreamlandLeftMainPanel.TipsBtnCallBack()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandLeftMainPanel.fireworkID)
    ----是否超出界限
    if CS.CSScene.MainPlayerInfo.DuplicateV2.IsOutOfBounds then
        local CallBack = function()
            networkRequest.ReqUseItem(1, itemInfo.lid, 0)
            uimanager:ClosePanel('UIPromptPanel')
        end
        UIBattleDreamlandLeftMainPanel.ShowBattleSecondTips(CallBack)
    else
        networkRequest.ReqUseItem(1, itemInfo.lid, 0)
        uimanager:ClosePanel('UIPromptPanel')
    end
end

---显示使用烟花面板
function UIBattleDreamlandLeftMainPanel.ShowDisposeOrePanel(count)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local duplicateinfo = CS.CSScene.MainPlayerInfo.DuplicateV2
    local info = {}
    info.itemid = UIBattleDreamlandLeftMainPanel.fireworkID
    info.price = 0
    info.maxValue = duplicateinfo:SelectFireworkCount(count)
    info.minValue = 1
    info.curValue = 1
    info.isDesprice = true
    info.IsShowItemTips = true
    info.rightBtnLabel = '使用'
    info.rightBtnCallBack = function(panel)
        if panel then
            if duplicateinfo:IsOutOfBoundsOfCount(panel.num) then
                local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandLeftMainPanel.fireworkID)
                local callback = function()
                    networkRequest.ReqUseItem(panel.num, itemInfo.lid, 0)
                    --Utility.ShowScreenEffect('700096')
                    uimanager:ClosePanel('UIPromptPanel')
                    uimanager:ClosePanel('UIDisposeOrePanel')
                end
                UIBattleDreamlandLeftMainPanel.ShowBattleSecondTips(callback)
                return
            end
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIBattleDreamlandLeftMainPanel.fireworkID)
            networkRequest.ReqUseItem(panel.num, itemInfo.lid, 0)
            -- Utility.ShowScreenEffect('700096')
            uimanager:ClosePanel('UIDisposeOrePanel')
        end
    end
    uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end

---时间溢出tips
function UIBattleDreamlandLeftMainPanel.ShowBattleSecondTips(callback)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20413)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        -- temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = callback
        local panel = uimanager:GetPanel('UIPromptPanel')
        if panel then
            panel:Show(temp)
        else
            uimanager:CreatePanel("UIPromptPanel", nil, temp)
        end
    end
end

--endregion

--region ondestroy

function ondestroy()
    if UIBattleDreamlandLeftMainPanel.IEnumTimeChange ~= nil then
        StopCoroutine(UIBattleDreamlandLeftMainPanel.IEnumTimeChange)
    end
    uimanager:ClosePanel('UIBattleDreamlandTransporterPanel')
end

--endregion

return UIBattleDreamlandLeftMainPanel