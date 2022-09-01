---内功界面
local UIRolePowerPanel = {}
--region 局部变量
---储存旧的进度
UIRolePowerPanel.mOldFillAmount = 0
---进度条速度
UIRolePowerPanel.mFillSpeed = 0.5
---进度条加载时间
UIRolePowerPanel.mFillAmountTime = 0
---
UIRolePowerPanel.mNewExp = 0
---当前内功等级
UIRolePowerPanel.curInnerLevel = 0
---当前经验值
UIRolePowerPanel.curExp = 0
---是否能够更新等级
UIRolePowerPanel.isRefreshLevel = true

---储存职业对应的的内功值
UIRolePowerPanel.mCareerPowerArray = {}
---储存内功说明
UIRolePowerPanel.mDescriptionArray = {}
---内功信息
UIRolePowerPanel.mInnerPowerinfo = nil
---内功升级协程
UIRolePowerPanel.InnerLevleChangeIenum = nil

--region 废弃
---进度条变化协程换缓存
UIRolePowerPanel.IEnumChangeProgressSlider = nil
---更新准备阶段
UIRolePowerPanel.IEnumWaitUpDataLv = nil
---加载完毕标识符
UIRolePowerPanel.mPrePareUpdataInnerExp = false
---内功特效路径
UIRolePowerPanel.mEffectPower_Path = ''
---用于单独插值经验
UIRolePowerPanel.mOldExp = 0
---按钮流光特效路径
UIRolePowerPanel.mBtnEffect_Path = ''
---人物发光特效路径
UIRolePowerPanel.mRoleEffect_Path = ''
---内功闪光特效路径
UIRolePowerPanel.mRolePowerEffect = ''
---是否加载按钮特效
UIRolePowerPanel.mHasLoadBtnEffect = false
---是否加载闪光特效
UIRolePowerPanel.mInnerPowerEffect = false
---是否加载池水特效
UIRolePowerPanel.mInnerWaterEffect = false
--endregion

---当前内功信息
UIRolePowerPanel.mCurInnerData = nil
UIRolePowerPanel.mCurInnercarrerArray = {}
---下级内功信息
UIRolePowerPanel.nextInnerData = nil
UIRolePowerPanel.mNextInnercarrerArray = {}

UIRolePowerPanel.fireEffect = nil
UIRolePowerPanel.fireEffect_Path = ''
UIRolePowerPanel.upEffect = nil
UIRolePowerPanel.upEffect_Path = ''
UIRolePowerPanel.btnEffect = nil
UIRolePowerPanel.btnEffect_Path = ''

UIRolePowerPanel.btnEffectStatu = false
--endregion

--region 组件 （废弃）

-----遮罩
-----
-----@type UnityEngine.GameObject
--function UIRolePowerPanel.GetBox()
--    if UIRolePowerPanel.mbox == nil then
--        UIRolePowerPanel.mbox = UIRolePowerPanel:GetCurComp("events/box", "GameObject")
--    end
--    return UIRolePowerPanel.mbox
--end
--
-----内功等级
--function UIRolePowerPanel.GetPowerLevel_UILabel()
--    if UIRolePowerPanel.mPowerLever == nil then
--        UIRolePowerPanel.mPowerLever = UIRolePowerPanel:GetCurComp('view/level/num', 'UILabel')
--    end
--    return UIRolePowerPanel.mPowerLever
--end
-----内功进度条
--function UIRolePowerPanel.GetSoulSlider_UISlider()
--    if UIRolePowerPanel.mSoulSlider == nil then
--        UIRolePowerPanel.mSoulSlider = UIRolePowerPanel:GetCurComp('view/soulslider', 'UISlider')
--    end
--    return UIRolePowerPanel.mSoulSlider
--end
--
-----内功进度条数值
--function UIRolePowerPanel.GetSouleSliderValue_UILabel()
--    if UIRolePowerPanel.mSouleSliderValue == nil then
--        UIRolePowerPanel.mSouleSliderValue = UIRolePowerPanel:GetCurComp('view/soulslider/soulvalue', 'UILabel')
--    end
--    return UIRolePowerPanel.mSouleSliderValue
--end
-----内功值
--function UIRolePowerPanel.GetPowerValue_UILabel()
--    if UIRolePowerPanel.mPowerValue == nil then
--        UIRolePowerPanel.mPowerValue = UIRolePowerPanel:GetCurComp('view/powervalue', 'UILabel')
--    end
--    return UIRolePowerPanel.mPowerValue
--end
-----减伤
--function UIRolePowerPanel.GetHurtValue_UILabel()
--    if UIRolePowerPanel.mHurtValue == nil then
--        UIRolePowerPanel.mHurtValue = UIRolePowerPanel:GetCurComp('view/hurtvalue', 'UILabel')
--    end
--    return UIRolePowerPanel.mHurtValue
--end
-------一键提升按钮
--function UIRolePowerPanel.GetPowerBtn_GameObject()
--    if UIRolePowerPanel.mPowerBtnGo == nil then
--        UIRolePowerPanel.mPowerBtnGo = UIRolePowerPanel:GetCurComp('events/btn_power', 'GameObject')
--    end
--    return UIRolePowerPanel.mPowerBtnGo
--end
---内功Tips
--function UIRolePowerPanel.GetPowerTips_Label()
--    if UIRolePowerPanel.mPowerTips == nil then
--        UIRolePowerPanel.mPowerTips = UIRolePowerPanel:GetCurComp('view/levelTips', 'UILabel')
--    end
--    return UIRolePowerPanel.mPowerTips
--end

---内功特效
--function UIRolePowerPanel.GetPowerEffect_UITexture()
--    if UIRolePowerPanel.mEffectPower == nil then
--        UIRolePowerPanel.mEffectPower = UIRolePowerPanel:GetCurComp('effect_power', 'UITexture')
--    end
--    return UIRolePowerPanel.mEffectPower
--end
--
---region Tween组件
---内功值
--function UIRolePowerPanel.GetPowerValue_Top_TweenScale()
--    if UIRolePowerPanel.mPowerTween == nil then
--        UIRolePowerPanel.mPowerTween = UIRolePowerPanel:GetCurComp('view/powervalue', 'Top_TweenScale')
--    end
--    return UIRolePowerPanel.mPowerTween
--end
---减伤
--function UIRolePowerPanel.GetHurtValue_Top_TweenScalel()
--    if UIRolePowerPanel.mHurtTween == nil then
--        UIRolePowerPanel.mHurtTween = UIRolePowerPanel:GetCurComp('view/hurtvalue', 'Top_TweenScale')
--    end
--    return UIRolePowerPanel.mHurtTween
--end
----endregion


--region 内功说明
---1
function UIRolePowerPanel.GetPowerCaption1_UILabel()
    if UIRolePowerPanel.mPowerCaption1 == nil then
        UIRolePowerPanel.mPowerCaption1 = UIRolePowerPanel:GetCurComp('window/Sprite5/Label', 'UILabel')
    end
    return UIRolePowerPanel.mPowerCaption1
end
---2
function UIRolePowerPanel.GetPowerCaption2_UILabel()
    if UIRolePowerPanel.mPowerCaption2 == nil then
        UIRolePowerPanel.mPowerCaption2 = UIRolePowerPanel:GetCurComp('window/Sprite6/Label', 'UILabel')
    end
    return UIRolePowerPanel.mPowerCaption2
end
---3
function UIRolePowerPanel.GetPowerCaption3_UILabel()
    if UIRolePowerPanel.mPowerCaption3 == nil then
        UIRolePowerPanel.mPowerCaption3 = UIRolePowerPanel:GetCurComp('window/Sprite7/Label', 'UILabel')
    end
    return UIRolePowerPanel.mPowerCaption3
end

--endregion

--endregion

--region 初始化
function UIRolePowerPanel:Init()
    networkRequest.ReqLookInnerPower()
    UIRolePowerPanel:InitComponents()
    UIRolePowerPanel.BindMessage()
    UIRolePowerPanel.BindUIEvents()
    UIRolePowerPanel.InitParameters()
    UIRolePowerPanel.InitEffect()
    -- UIRolePowerPanel.ReadDescriptionExcel()
end

--初始化组件
function UIRolePowerPanel:InitComponents()
    ---@type Top_UILabel 当前内功值
    UIRolePowerPanel.curAttribute01 = self:GetCurComp("WidgetRoot/view/curtAttributeLabels/attribute01", "Top_UILabel")
    ---@type Top_UILabel 当前免伤
    UIRolePowerPanel.curAttribute11 = self:GetCurComp("WidgetRoot/view/curtAttributeLabels/attribute11", "Top_UILabel")
    ---@type Top_UILabel 下级内功值
    UIRolePowerPanel.nextAttribute01 = self:GetCurComp("WidgetRoot/view/nextAttributeLabels/attribute01", "Top_UILabel")
    ---@type Top_UILabel 下级免伤
    UIRolePowerPanel.nextAttribute11 = self:GetCurComp("WidgetRoot/view/nextAttributeLabels/attribute11", "Top_UILabel")

    ---@type Top_UILabel 等级
    UIRolePowerPanel.turngrowlevel = self:GetCurComp("WidgetRoot/view/turngrowlevel", "Top_UILabel")

    ---@type CSFontBlink 下级内功值blink
    UIRolePowerPanel.nextAttribute01blink = self:GetCurComp("WidgetRoot/view/nextAttributeLabels/attribute01", "CSFontBlink")
    ---@type CSFontBlink 下级免伤blink
    UIRolePowerPanel.nextAttribute11blink = self:GetCurComp("WidgetRoot/view/nextAttributeLabels/attribute11", "CSFontBlink")

    ---@type Top_UILabel 升级条件
    UIRolePowerPanel.needPowerLabel = self:GetCurComp("WidgetRoot/view/nextCombat/label", "Top_UILabel")
    ---@type UnityEngine.GameObject 升级按钮
    UIRolePowerPanel.btn_up = self:GetCurComp("WidgetRoot/events/btn_up", "GameObject")
    ---@type UnityEngine.GameObject 帮助按钮
    UIRolePowerPanel.helpBtn = self:GetCurComp("WidgetRoot/events/helpBtn", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIRolePowerPanel.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---@type UnityEngine.GameObject 特效父物体
    UIRolePowerPanel.bg = self:GetCurComp("WidgetRoot/view/turngrowlevel/bg", "GameObject")
    ---@type UnityEngine.GameObject 升级特效父物体
    UIRolePowerPanel.Sprite = self:GetCurComp("WidgetRoot/view/turngrowlevel/Sprite", "GameObject")
    ---@type UnityEngine.GameObject 消耗物品icon
    UIRolePowerPanel.mCostItem_UISprite = self:GetCurComp("WidgetRoot/view/nextCombat/img", "UISprite");
    ---@type UnityEngine.Transform 按钮特效父节点
    UIRolePowerPanel.btnBackground = self:GetCurComp("WidgetRoot/events/btn_up/Background", "Transform")
end

function UIRolePowerPanel.InitParameters()
    UIRolePowerPanel.career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    UIRolePowerPanel.curInnerLevel = CS.CSScene.MainPlayerInfo.InnerLevle
    UIRolePowerPanel.curExp = CS.CSScene.MainPlayerInfo.InnerExp
end

function UIRolePowerPanel.BindMessage()
    UIRolePowerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSendInnerPowerInfoMessage, UIRolePowerPanel.InitInnerData)
    UIRolePowerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInnerPowerInfoChangeMessage, UIRolePowerPanel.OnResInnerPowerInfoChange)
    UIRolePowerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerExpChangeMessage, UIRolePowerPanel.OnReceiveUpLvInnerMessage)
end
function UIRolePowerPanel.BindUIEvents()
    --CS.UIEventListener.Get(UIRolePowerPanel.GetPowerBtn_GameObject()).onClick = UIRolePowerPanel.OnPowerBtnClick
    --点击遮罩事件
    -- CS.UIEventListener.Get(UIRolePowerPanel.GetBox()).onClick = UIRolePowerPanel.OnClickbox

    --点击升级事件
    CS.UIEventListener.Get(UIRolePowerPanel.btn_up).onClick = UIRolePowerPanel.OnClickbtn_up
    --点击帮助事件
    CS.UIEventListener.Get(UIRolePowerPanel.helpBtn).onClick = UIRolePowerPanel.OnClickhelpBtn
    --点击关闭事件
    CS.UIEventListener.Get(UIRolePowerPanel.CloseBtn).onClick = UIRolePowerPanel.OnClickCloseBtn
    --点击消耗物品
    CS.UIEventListener.Get(UIRolePowerPanel.mCostItem_UISprite.gameObject).onClick = function()
        local itemId = 1000008;
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind) then
            uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = itemTable})
        end
    end
end
--endregion



--region UI事件
--region （废弃）
----点击遮罩函数
-----@param go UnityEngine.GameObject
--function UIRolePowerPanel.OnClickbox(go)
--    uimanager:ClosePanel("UIRolePowerPanel")
--end
--
-----一键升级点击事件
--function UIRolePowerPanel.OnPowerBtnClick()
--    if UIRolePowerPanel.IsCanUpgradePower() then
--        networkRequest.ReqLevelUpInnerPower()
--        return
--    end
--    CS.Utility.ShowTips("内功经验不足", 1.5, CS.ColorType.Red)
--end
--endregion

---点击升级函数
---@param go UnityEngine.GameObject
function UIRolePowerPanel.OnClickbtn_up(go)
    if UIRolePowerPanel.IsCanUpgradePower() then
        networkRequest.ReqLevelUpInnerPower()
        return
    end
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 40
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

--点击帮助函数
---@param go UnityEngine.GameObject
function UIRolePowerPanel.OnClickhelpBtn(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(1)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIRolePowerPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel('UIRolePowerPanel')
end

--endregion


--region 服务器消息处理
---获取内功信息 初始化面板信息
function UIRolePowerPanel.InitInnerData(id, data)
    if data then
        UIRolePowerPanel.InitParameters()
        UIRolePowerPanel.RefreshInnerData(data.powerBeans.innerCfgId)
        UIRolePowerPanel.RefreshUI(data.powerBeans.innerExp)
        UIRolePowerPanel.RefreshValue()
        UIRolePowerPanel.ShowBtnEffect()
    end
end
---内功信息变化
function UIRolePowerPanel.OnResInnerPowerInfoChange(id, data)
    if data then
        if UIRolePowerPanel.isRefreshLevel then
            if UIRolePowerPanel.InnerLevleChangeIenum ~= nil then
                StopCoroutine(UIRolePowerPanel.InnerLevleChangeIenum)
                UIRolePowerPanel.InnerLevleChangeIenum = nil
            end
            UIRolePowerPanel.InnerLevleChangeIenum = StartCoroutine(UIRolePowerPanel.InnerLevleChange)
            UIRolePowerPanel.ShowBtnEffect()
        end

    end
    --local newLevel = data.changeBean.innerCfgId
    --local newExp = data.changeBean.innerExp
    --UIRolePowerPanel.IEnumWaitUpDataLv = StartCoroutine(UIRolePowerPanel.IEnumUpdataExpFillAmount, UIRolePowerPanel.mInnerPowerinfo.level, newExp, newLevel)

end
---经验变化信息 (单独用于打怪时内功经验变化)
function UIRolePowerPanel.OnReceiveUpLvInnerMessage(id, data)
    --池子改变 label改变
    if data then
        UIRolePowerPanel.RefreshUI(data.curInnerPowerExp)
        if UIRolePowerPanel.isRefreshLevel then
            UIRolePowerPanel.ShowBtnEffect()
        end
        --UIRolePowerPanel.RefreshValue()
    end
    --local newExp = data.curInnerPowerExp
    --UIRolePowerPanel.IEnumWaitUpDataLv = StartCoroutine(UIRolePowerPanel.IEnumUpdataExpFillAmount, UIRolePowerPanel.mInnerPowerinfo.level, newExp, UIRolePowerPanel.mInnerPowerinfo.level)
end
--endregion


--region UI

--region （废弃）

-----刷新内功信息面板
-----@param changeSize boolean 是否实现字体缩放效果
--function UIRolePowerPanel.RefreshInnerinfo(changeSize)
--    UIRolePowerPanel.ChangeLvLabel()
--    UIRolePowerPanel.ChangeHurtLabel(changeSize)
--    UIRolePowerPanel.ChangePowerValueLabel(changeSize)
--end
-----等级
--function UIRolePowerPanel.ChangeLvLabel()
--    UIRolePowerPanel.GetPowerLevel_UILabel().text = tostring(UIRolePowerPanel.mInnerPowerinfo.level)
--end
-----减伤
--function UIRolePowerPanel.ChangeHurtLabel(changeSize)
--    UIRolePowerPanel.GetHurtValue_UILabel().text = tostring(string.format("%d", UIRolePowerPanel.mInnerPowerinfo.mianshangShow / 100) .. "%")
--    if changeSize then
--        UIRolePowerPanel.GetHurtValue_Top_TweenScalel():PlayTween()
--    end
--end
-----内功值
--function UIRolePowerPanel.ChangePowerValueLabel(changeSize)
--    UIRolePowerPanel.GetPowerValue_UILabel().text = UIRolePowerPanel.GetPowerValueOfID()
--    if changeSize then
--        UIRolePowerPanel.GetPowerValue_Top_TweenScale():PlayTween()
--    end
--end
-----内功进度
--function UIRolePowerPanel.ChangeProgressSlider(fileAmount)
--    local mFileValue = fileAmount * UIRolePowerPanel.mInnerPowerinfo.exp
--    UIRolePowerPanel.mOldExp = mFileValue
--    UIRolePowerPanel. GetSouleSliderValue_UILabel().text = tostring(string.format("%0.0f", mFileValue) .. '/' .. UIRolePowerPanel.mInnerPowerinfo.exp)
--    UIRolePowerPanel.GetSoulSlider_UISlider().value = ternary(fileAmount > 1, 1, fileAmount)
--end
-----内功说明
--function UIRolePowerPanel.RefreshInnerCaption()
--    if #UIRolePowerPanel.mDescriptionArray == 0 then
--        return
--    end
--    UIRolePowerPanel.GetPowerCaption1_UILabel().text = UIRolePowerPanel.mDescriptionArray[1]
--    UIRolePowerPanel.GetPowerCaption2_UILabel().text = UIRolePowerPanel.mDescriptionArray[2]
--    UIRolePowerPanel.GetPowerCaption3_UILabel().text = UIRolePowerPanel.mDescriptionArray[3]
--end
--endregion

function UIRolePowerPanel.InnerLevleChange()

    UIRolePowerPanel.isRefreshLevel = false
    local realInnerLevel = CS.CSScene.MainPlayerInfo.InnerLevle
    while UIRolePowerPanel.curInnerLevel + 1 <= CS.CSScene.MainPlayerInfo.InnerLevle do
        UIRolePowerPanel.curInnerLevel = UIRolePowerPanel.curInnerLevel + 1
        UIRolePowerPanel.curExp = UIRolePowerPanel.curInnerLevel < realInnerLevel and UIRolePowerPanel.curExp - UIRolePowerPanel.mCurInnerData.exp or CS.CSScene.MainPlayerInfo.InnerExp

        UIRolePowerPanel.RefreshInnerData(UIRolePowerPanel.curInnerLevel)
        UIRolePowerPanel.PlaySucessEffect()
        UIRolePowerPanel.RefreshUI(UIRolePowerPanel.curExp)
        UIRolePowerPanel.RefreshValue()
        UIRolePowerPanel.ShowBlink()
        --播放特效
        realInnerLevel = CS.CSScene.MainPlayerInfo.InnerLevle

        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));
    end
    UIRolePowerPanel.isRefreshLevel = true
end

function UIRolePowerPanel.RefreshUI(exp)
    UIRolePowerPanel.curexp = exp == nil and tostring(CS.CSScene.MainPlayerInfo.InnerExp) or exp
    local max = UIRolePowerPanel.mCurInnerData == nil and 0 or UIRolePowerPanel.mCurInnerData.exp
    if UIRolePowerPanel.curexp >= max then
        UIRolePowerPanel.mCostItem_UISprite.color = CS.UnityEngine.Color.white
        UIRolePowerPanel.needPowerLabel.text = luaEnumColorType.Green .. tostring(UIRolePowerPanel.curexp) .. '[-] /' .. tostring(max)
    else
        UIRolePowerPanel.mCostItem_UISprite.color = CS.UnityEngine.Color.gray
        UIRolePowerPanel.needPowerLabel.text = luaEnumColorType.Red .. tostring(UIRolePowerPanel.curexp) .. '[-] /' .. tostring(max)
    end
    UIRolePowerPanel.turngrowlevel.text = tostring(UIRolePowerPanel.curInnerLevel) or '0'
    -- UIRolePowerPanel.needPowerLabel.text = UIRolePowerPanel.mCurInnerData == nil and UIRolePowerPanel.curexp .. ' /' .. 0 or UIRolePowerPanel.curexp .. '/' .. tostring(max)
end

function UIRolePowerPanel.RefreshValue()
    UIRolePowerPanel.curAttribute01.text = #UIRolePowerPanel.mCurInnercarrerArray == 0 and '暂无' or UIRolePowerPanel.mCurInnercarrerArray[UIRolePowerPanel.career] == nil and '暂无' or UIRolePowerPanel.mCurInnercarrerArray[UIRolePowerPanel.career]
    UIRolePowerPanel.nextAttribute01.text = #UIRolePowerPanel.mNextInnercarrerArray == 0 and '暂无' or UIRolePowerPanel.mNextInnercarrerArray[UIRolePowerPanel.career] == nil and '暂无' or UIRolePowerPanel.mNextInnercarrerArray[UIRolePowerPanel.career]
    UIRolePowerPanel.curAttribute11.text = UIRolePowerPanel.mCurInnerData == nil and '暂无' or tostring(string.format("%d", UIRolePowerPanel.mCurInnerData.mianshangShow / 100) .. "%")
    UIRolePowerPanel.nextAttribute11.text = UIRolePowerPanel.nextInnerData == nil and '暂无' or tostring(string.format("%d", UIRolePowerPanel.nextInnerData.mianshangShow / 100) .. "%")
end

function UIRolePowerPanel.ShowBlink()
    UIRolePowerPanel.nextAttribute01blink:Play()
    UIRolePowerPanel.nextAttribute11blink:Play()
end

function UIRolePowerPanel.InitEffect()
    if UIRolePowerPanel.upEffect ~= nil then
        UIRolePowerPanel.upEffect.gameObject:SetActive(false)
    end
    if UIRolePowerPanel.fireEffect == nil then
        UIRolePowerPanel.LoadEffect('700085', UIRolePowerPanel.bg.transform, function(path, obj)
            UIRolePowerPanel.fireEffect = obj
            UIRolePowerPanel.fireEffect_Path = path
        end)
    end
    if UIRolePowerPanel.btnEffect ~= nil then
        UIRolePowerPanel.btnEffect.gameObject:SetActive(false)
    end
end

function UIRolePowerPanel.ShowBtnEffect()
    local exp = CS.CSScene.MainPlayerInfo.InnerExp
    local max = UIRolePowerPanel.GetNeigongInfo(CS.CSScene.MainPlayerInfo.InnerLevle).exp
    local isOpen = exp >= max
    if isOpen == UIRolePowerPanel.btnEffectStatu then
        return
    end
    UIRolePowerPanel.btnEffectStatu = isOpen
    if UIRolePowerPanel.btnEffect == nil then
        UIRolePowerPanel.LoadEffect('800004', UIRolePowerPanel.btnBackground, function(path, obj)
            UIRolePowerPanel.btnEffect = obj
            UIRolePowerPanel.btnEffect_Path = path
            UIRolePowerPanel.btnEffect.transform.localScale = CS.UnityEngine.Vector3(200, 125, 100)
            UIRolePowerPanel.btnEffect:SetActive(isOpen)
        end)
    else
        UIRolePowerPanel.btnEffect:SetActive(false)
        UIRolePowerPanel.btnEffect:SetActive(isOpen)
    end
end

function UIRolePowerPanel.PlaySucessEffect()
    if UIRolePowerPanel.upEffect ~= nil then
        UIRolePowerPanel.upEffect.gameObject:SetActive(false)
        UIRolePowerPanel.upEffect.gameObject:SetActive(true)
        return
    end
    UIRolePowerPanel.LoadEffect('700086', UIRolePowerPanel.Sprite.transform, function(path, obj)
        UIRolePowerPanel.upEffect = obj
        UIRolePowerPanel.upEffect_Path = path
    end)
end

--endregion


--region 进度条更新协程 (废弃)
---更新准备阶段协程
--function UIRolePowerPanel.IEnumUpdataExpFillAmount(oldlv, newExp, newlv)
--    while UIRolePowerPanel.mPrePareUpdataInnerExp do
--        coroutine.yield(0)
--    end
--    UIRolePowerPanel.ReadNeigongExcel(newlv)
--    UIRolePowerPanel.mNewExp = newExp
--    local TargetDistance = UIRolePowerPanel.mNewExp / UIRolePowerPanel.mInnerPowerinfo.exp
--    local distanceTemp = ternary(TargetDistance > 1, 1, TargetDistance)
--    UIRolePowerPanel.mFillAmountTime = distanceTemp / UIRolePowerPanel.mFillSpeed
--    UIRolePowerPanel.IEnumChangeProgressSlider = StartCoroutine(UIRolePowerPanel.IEnumChangeProgress, oldlv, TargetDistance, newlv)
--end
-----改变Exp及数值协程
--function UIRolePowerPanel.IEnumChangeProgress(oldLv, targetFillAmount, newLv)
--    UIRolePowerPanel.mPrePareUpdataInnerExp = true
--    local time = 0
--    local fillAmount = 0
--    UIRolePowerPanel.ReadNeigongExcel(oldLv)
--    while oldLv < newLv do
--        time = time + CS.UnityEngine.Time.deltaTime
--        fillAmount = CS.UnityEngine.Mathf.Lerp(UIRolePowerPanel.mOldFillAmount, 1, time / UIRolePowerPanel.mFillAmountTime)
--        --规定为小数点后两位
--        if fillAmount >= 1 then
--            ---判断当前等级是否为满级
--            if UIRolePowerPanel.IsShowDaYuanMan(oldLv) then
--                return
--            end
--            time = 0
--            oldLv = oldLv + 1
--            fillAmount = 0
--            UIRolePowerPanel.mOldFillAmount = 0
--            UIRolePowerPanel.ReadNeigongExcel(oldLv)
--            UIRolePowerPanel.RefreshInnerinfo(true, false)
--        end
--        UIRolePowerPanel.ChangeProgressSlider(fillAmount)
--        coroutine.yield(0)
--    end
--    local bumFillAmount = ternary(targetFillAmount > 1, 1, targetFillAmount)
--
--    while oldLv == newLv do
--        if UIRolePowerPanel.IsShowDaYuanMan(oldLv) then
--            return
--        end
--        time = time + CS.UnityEngine.Time.deltaTime
--        fillAmount = CS.UnityEngine.Mathf.Lerp(UIRolePowerPanel.mOldFillAmount, bumFillAmount, time / UIRolePowerPanel.mFillAmountTime)
--        if bumFillAmount - fillAmount <= 0.0001 then
--
--            UIRolePowerPanel.GetSoulSlider_UISlider().value = fillAmount
--            UIRolePowerPanel. GetSouleSliderValue_UILabel().text = UIRolePowerPanel.mNewExp .. '/' .. UIRolePowerPanel.mInnerPowerinfo.exp
--            break
--        end
--        UIRolePowerPanel.ChangeProgressSlider(fillAmount)
--        coroutine.yield(0)
--    end
--    UIRolePowerPanel.mOldFillAmount = fillAmount
--    UIRolePowerPanel.mPrePareUpdataInnerExp = false
--end

--endregion

--region OtherFunction

function UIRolePowerPanel.LoadEffect(code, parent, CallBack)
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            --设置父物体
            if parent == nil and CS.StaticUtility.IsNull(parent) then
                return
            end
            UIRolePowerPanel.promptEffect_Path = res.Path
            local go = res:GetObjInst()
            if go then
                go.transform.parent = parent
                go.transform.localPosition = CS.UnityEngine.Vector3.zero
                go.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
            end
            if CallBack then
                CallBack(res.Path, go)
            end
        end
    end, CS.ResourceAssistType.UI)
end

---是否能够升级
function UIRolePowerPanel.IsCanUpgradePower()
    if UIRolePowerPanel.mCurInnerData == nil then
        return true
    else
        return UIRolePowerPanel.curexp >= UIRolePowerPanel.mCurInnerData.exp
    end
end

---是否显示大圆满
function UIRolePowerPanel.IsShowDaYuanMan(lv)
    if lv == CS.Cfg_NeigongTableManager.Instance.dic.Count then
        UIRolePowerPanel.GetPowerBtn_GameObject().setActive(false)
        return true
    end
    return false
end

--- 根据职业获取等级对应内功值
function UIRolePowerPanel.GetPowerValueOfID()
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    if career == 0 then
        return
    else
        return UIRolePowerPanel.mCareerPowerArray[career]
    end
end

---获得旧的进度值
function UIRolePowerPanel.GetFillAmount(Exp)
    if UIRolePowerPanel.mInnerPowerinfo == nil then
        return
    end
    if Exp >= UIRolePowerPanel.mInnerPowerinfo.exp then
        UIRolePowerPanel.mOldFillAmount = 1
    else
        UIRolePowerPanel.mOldFillAmount = Exp / UIRolePowerPanel.mInnerPowerinfo.exp
    end
    return UIRolePowerPanel.mOldFillAmount
end

--region 人物发光特效加载 （废弃）

--function UIRolePowerPanel:Show()
--    UIRolePowerPanel.OnLoadPowerEffect(nil)
--end
--
--function UIRolePowerPanel.OnLoadPowerEffect(res)
--    if res == nil or res.MirrorObj == nil then
--        return
--    elseif res ~= nil and res.MirrorObj ~= nil then
--        UIRolePowerPanel.mEffectPower_Path = res.Path
--        UIRolePowerPanel.GetPowerEffect_UITexture().mainTexture = res.MirrorObj
--    end
--end

--endregion


--endregion

--region 读表

--刷新内功信息
function UIRolePowerPanel.RefreshInnerData(curLevel)
    local curInnerLevel = curLevel == nil and CS.CSScene.MainPlayerInfo.InnerLevle or curLevel
    local nextInnerLevel = curInnerLevel + 1
    UIRolePowerPanel.mCurInnercarrerArray = {}
    UIRolePowerPanel.mNextInnercarrerArray = {}
    UIRolePowerPanel.mCurInnerData, UIRolePowerPanel.mCurInnercarrerArray = UIRolePowerPanel.GetNeigongInfo(curInnerLevel)
    UIRolePowerPanel.nextInnerData, UIRolePowerPanel.mNextInnercarrerArray = UIRolePowerPanel.GetNeigongInfo(nextInnerLevel)
end
--获得内功当前的经验值
function UIRolePowerPanel.GetCurInnerExp()
    return CS.CSScene.MainPlayerInfo.InnerExp
end

---读内功信息表
function UIRolePowerPanel.GetNeigongInfo(id)
    local powerArray = {}
    local mInnerinfo, isFind
    isFind, mInnerinfo = CS.Cfg_NeigongTableManager.Instance.dic:TryGetValue(id)
    if isFind then
        ---获得内功信息
        --UIRolePowerPanel.mInnerPowerinfo = mInnerinfo;
        ---职业对应的内力值

        local power = mInnerinfo.zsInnerPower
        powerArray[1] = power
        power = mInnerinfo.fsInnerPower
        powerArray[2] = power
        power = mInnerinfo.dsInnerPower
        powerArray[3] = power
        return mInnerinfo, powerArray
    end
    return nil, powerArray
end
---读内功说明表
function UIRolePowerPanel.ReadDescriptionExcel()
    UIRolePowerPanel.mDescriptionArray = {}
    local mDescriptioninfo, isFind
    isFind, mDescriptioninfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(1)
    UIRolePowerPanel.mDescriptionArray = string.Split(mDescriptioninfo.value, "#")
    UIRolePowerPanel.RefreshInnerCaption()
end
--endregion

--region ondestroy
function UIRolePowerPanel:OnDestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResInnerPowerInfoChangeMessage, UIRolePowerPanel.OnResInnerPowerInfoChange)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSendInnerPowerInfoMessage, UIRolePowerPanel.InitInnerData)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResPlayerExpChangeMessage, UIRolePowerPanel.OnReceiveUpLvInnerMessage)
    --if UIRolePowerPanel.IEnumChangeProgressSlider ~= nil then
    --    StopCoroutine(UIRolePowerPanel.IEnumChangeProgressSlider)
    --end
    --if UIRolePowerPanel.IEnumWaitUpDataLv ~= nil then
    --    StopCoroutine(UIRolePowerPanel.IEnumWaitUpDataLv)
    --end
    if UIRolePowerPanel.InnerLevleChangeIenum ~= nil then
        StopCoroutine(UIRolePowerPanel.InnerLevleChangeIenum)
        UIRolePowerPanel.InnerLevleChangeIenum = nil
    end
    if CS.CSResourceManager.Instance ~= nil and self ~= nil then
        if UIRolePowerPanel.upEffect_Path ~= nil or UIRolePowerPanel.upEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIRolePowerPanel.upEffect_Path)
        end
        if UIRolePowerPanel.fireEffect_Path ~= nil or UIRolePowerPanel.fireEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIRolePowerPanel.fireEffect_Path)
        end
        if UIRolePowerPanel.btnEffect_Path ~= nil or UIRolePowerPanel.btnEffect_Path ~= '' then
            CS.CSResourceManager.Instance:ForceDestroyResource(UIRolePowerPanel.btnEffect_Path)
        end
    end

end

function ondestroy()
    UIRolePowerPanel:OnDestroy()
end
--endregion

return UIRolePowerPanel