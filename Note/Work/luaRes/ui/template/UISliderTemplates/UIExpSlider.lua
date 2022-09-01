---经验条

local UIExpSlider = {}

setmetatable(UIExpSlider, luaComponentTemplates.UISliderBasic)

---通过工具生成 控件变量
function UIExpSlider:InitComponents()
    self:RunBaseFunction("InitComponents")
    --经验文本
    self.mText_UILabel = self:Get("Text", "UILabel")
    self.mainChat = uimanager:GetPanel("UIMainChatPanel")
end
---初始化 变量 按钮点击 服务器消息事件等
function UIExpSlider:InitOther()
    self:RunBaseFunction("InitOther")
    if (CS.CSScene.MainPlayerInfo == nil) then
        return
    end
    --是否在等级限制表示符
    self.mOpenServerLimit = false
    --等级限制
    self.mOpenServerLimitLevel = 0
    --是否更新事件标识符，包括更新和结束事件
    self.mIsUpdateAction = false;
    --更新经验条协程
    self.mUpdateExpCoroutine = nil
    --更新经验条协程
    self.mExpEffectHideCoroutine = nil
    --之前的FillAmount
    self.mPreFillAmount = -1
    --之前的等级
    self.mPreLevel = -1
    self.mPreLevel = CS.CSScene.MainPlayerInfo.Level
    --等级变化值
    self.mLevelChangeValue = 0
    --下一等级的FillAmount
    self.mNextLevelFillAmount = 0
    --总经验
    self.mTotalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(self.mPreLevel)
    --升级完成回调
    self.finishCallBack = nil
    --经验条
    self.mPreFillAmount = CS.CSScene.MainPlayerInfo.Exp / self.mTotalExp
    self.mPreFillAmount = ternary(self.mPreFillAmount >= 1, 1, self.mPreFillAmount)
    self.mSlider_UISprite.fillAmount = self.mPreFillAmount
    self.mSlider_UISprite.spriteName = "exp1"
    self:SetBarText(CS.CSScene.MainPlayerInfo.Exp, self.mTotalExp)
    --监听经验变化
    self.mFuncBindedInExpChangeMsg = function(a, b, c)
        if (uiStaticParameter.ExpNeedDelay) then
            if (self.mCoroutineDelayExpChange == nil) then
                self.mCoroutineDelayFade = StartCoroutine(self.DelayExpChangeCoroutine, self, a, b, c);
            else
                StopCoroutine(self.DelayExpChangeCoroutine)
                self.mCoroutineDelayFade = StartCoroutine(self.DelayExpChangeCoroutine, self, a, b, c);
            end
        else
            self:OnResPlayerExpChangeMessage(a, b, c)
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResPlayerExpChangeMessage, self.mFuncBindedInExpChangeMsg)
end

---更新开服限制
function UIExpSlider:UpdateOpenServerLimit()
    self.mOpenServerLimit = false
    local serverTime = CS.CSServerTime.Now
    local tempTime = CS.CSServerTime.StampToDateTime(CS.CSScene.MainPlayerInfo.OpenServerTime * 1000)
    --local serverTimeTick = serverTime.Ticks
    --local difTicks = serverTimeTick - tempTime.Ticks
    local difTicks = CS.CSServerTime.DeltaTick(serverTime,tempTime)
    local difDay = difTicks / 10000000 / 60 / 60 / 24
    local isFind, item = CS.Cfg_GlobalTableManagerBase.Instance:TryGetValue(20130)
    if isFind then
        local value = string.Split(item.value, "&")
        for i = 1, #value do
            local info = string.Split(value[i], "#")
            if difDay <= tonumber(info[1]) then
                self.mOpenServerLimit = true
                self.mOpenServerLimitLevel = tonumber(info[2])
                break
            end
        end
    end
end

---监听经验值变化
function UIExpSlider:OnResPlayerExpChangeMessage(msgID, tblData, csData)
    ---是否跳过进度条填充动画
    --self:IsJumpExpTween()
    local mainChat = uimanager:GetPanel("UIMainChatPanel")
    if (mainChat ~= nil) then
        local entity = mainChat.mExpSlider
        local level = CS.CSScene.MainPlayerInfo.Level
        local totalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(level)
        entity.mPreFillAmount = entity.mSlider_UISprite.fillAmount
        mainChat.UIExpSliderEndPoint.transform.localPosition = CS.UnityEngine.Vector3(660 * (2 * tonumber(entity.mPreFillAmount) - 1), 0, 0)
        if (entity.mPreFillAmount > 0.5) then
            mainChat.GetBesizerPointup_GameObject().transform.localPosition = CS.UnityEngine.Vector3(mainChat.GetBesizerPointup_GameObject().transform.localPosition.x, -50, 0)
            mainChat.GetBesizerPointdown_GameObject().transform.localPosition = CS.UnityEngine.Vector3(mainChat.GetBesizerPointdown_GameObject().transform.localPosition.x, 50, 0)
        else
            mainChat.GetBesizerPointup_GameObject().transform.localPosition = CS.UnityEngine.Vector3(mainChat.GetBesizerPointup_GameObject().transform.localPosition.x, 50, 0)
            mainChat.GetBesizerPointdown_GameObject().transform.localPosition = CS.UnityEngine.Vector3(mainChat.GetBesizerPointdown_GameObject().transform.localPosition.x, -50, 0)
        end
        mainChat.GetBesizerPoint_GameObject().transform.localPosition = CS.UnityEngine.Vector3(370 * (2 * tonumber(entity.mPreFillAmount) - 1), 155, 0)
        entity.mIsUpdateAction = true
        --entity.mSlider_UISprite.spriteName = "exp"
        --开服等级限制
        entity:UpdateOpenServerLimit()
        --等级变化值
        entity.mLevelChangeValue = level - entity.mPreLevel
        --正常状态标识符
        local isNormal = true
        local form = 0
        local to = 1

        if isNormal then
            --如果当前经验值大于本级所需经验值，说明，刚解除开服等级限制不久，在消耗经验池的经验
            if tblData.curExp > totalExp then
                form = 0
                to = 1
                entity.mPreLevel = CS.CSScene.MainPlayerInfo.Level
                entity.mTotalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(entity.mPreLevel)
                entity:SetBarText(tblData.curExp, entity.mTotalExp)
                entity.mIsUpdateAction = false
                entity.mSlider_UISprite.spriteName = "exp1"
            else
                --设置下一等级的FillAmount
                entity.mNextLevelFillAmount = tblData.curExp / totalExp

                --三种情况
                if entity.mLevelChangeValue == 0 then
                    --正常的经验值
                    form = entity.mPreFillAmount
                    to = tblData.curExp / totalExp
                elseif entity.mLevelChangeValue > 0 then
                    --升级
                    form = entity.mPreFillAmount
                    to = 1
                elseif entity.mLevelChangeValue < 0 then
                    --降级
                    form = entity.mPreFillAmount
                    to = 0
                end
            end
        end
        entity:Play(form, to)
        if entity.mUpdateExpCoroutine ~= nil then
            StopCoroutine(entity.mUpdateExpCoroutine)
        end
        entity.mUpdateExpCoroutine = StartCoroutine(UIExpSlider.UpdateExpCoroutine, self, entity)
    end
    --local sizex = (to - form)
    --local size = CS.UnityEngine.Vector3(sizex, 1, 1)
    --if entity.expEffect == nil then
    --    entity:LoadEffect('700116', self.mainChat.UIBubleEffectRoot.transform, size, function(path, obj)
    --        entity.expEffect = obj
    --        entity.expEffect_Path = path
    --        entity:SetTipsPostion(obj, form)
    --        entity.mExpEffectHideCoroutine = StartCoroutine(UIExpSlider.HideExpEffect, entity, entity.expEffect)
    --    end)
    --else
    --    entity:SetTipsPostion(entity.expEffect, form)
    --    entity.expEffect.transform.localScale = size
    --    entity.expEffect:SetActive(true)
    --    if entity.mExpEffectHideCoroutine ~= nil then
    --        StopCoroutine(entity.mExpEffectHideCoroutine)
    --    end
    --    entity.mExpEffectHideCoroutine = StartCoroutine(UIExpSlider.HideExpEffect, entity, entity.expEffect)
    --end
end

---设置tips位置
function UIExpSlider:SetTipsPostion(panel, form)
    if panel == nil then
        return
    end
    local posY = -266
    local posX = 0

    local limitXMax = 673
    local limitXMin = -662
    --当前进度
    local posX = limitXMin + (limitXMax - limitXMin) * form
    ----目标进度
    --判断界限 设置位置
    panel.transform.localPosition = CS.UnityEngine.Vector3(posX, posY, 3)
end

---延时经验条动画协程
function UIExpSlider:DelayExpChangeCoroutine(a, b, c)
    local entity = self.mainChat.mExpSlider
    local level = CS.CSScene.MainPlayerInfo.Level
    local totalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(level)
    entity.mPreFillAmount = entity.mSlider_UISprite.fillAmount
    self.mainChat.UIExpSliderEndPoint.transform.localPosition = CS.UnityEngine.Vector3(660 * (2 * tonumber(entity.mPreFillAmount) - 1), 0, 0)
    if (entity.mPreFillAmount > 0.5) then
        self.mainChat.GetBesizerPointup_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.GetBesizerPointup_GameObject().transform.localPosition.x, -50, 0)
        self.mainChat.GetBesizerPointdown_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.GetBesizerPointdown_GameObject().transform.localPosition.x, 50, 0)
    else
        self.mainChat.GetBesizerPointup_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.GetBesizerPointup_GameObject().transform.localPosition.x, 50, 0)
        self.mainChat.GetBesizerPointdown_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.GetBesizerPointdown_GameObject().transform.localPosition.x, -50, 0)
    end
    self.mainChat.GetBesizerPoint_GameObject().transform.localPosition = CS.UnityEngine.Vector3(370 * (2 * tonumber(entity.mPreFillAmount) - 1), 155, 0)
    self.mainChat.GetBesizerPointcenter1_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.BesizerPointCen1X * (1 - 2 * tonumber(entity.mPreFillAmount)), self.mainChat.GetBesizerPointcenter1_GameObject().transform.localPosition.y, 0)
    self.mainChat.GetBesizerPointcenter2_GameObject().transform.localPosition = CS.UnityEngine.Vector3(self.mainChat.BesizerPointCen2X * (1 - 2 * tonumber(entity.mPreFillAmount)), self.mainChat.GetBesizerPointcenter2_GameObject().transform.localPosition.y, 0)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(uiStaticParameter.ExpDelayTime))
    self:OnResPlayerExpChangeMessage(a, b, c)
    uiStaticParameter.ExpNeedDelay = false
    --StopCoroutine(self.DelayExpChangeCoroutine)
end

---更新协程
function UIExpSlider:UpdateExpCoroutine(entity)
    while (entity.mIsUpdateAction) do
        entity:SetBarText(entity.mSlider_UISprite.fillAmount * entity.mTotalExp, entity.mTotalExp)
        coroutine.yield(0)
    end
    if self.finishCallBack ~= nil then
        self.finishCallBack()
        self.finishCallBack = nil
    end
end

function UIExpSlider:HideExpEffect(effect)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(self.mSlider_TweenFillAmount.duration + 0.5))
    if (effect ~= nil) then
        effect:SetActive(false)
    end
end
---填充结束
function UIExpSlider:OnFillFinished()
    local entity = self.mainChat.mExpSlider
    if entity.mIsUpdateAction == false then
        entity.mLevelChangeValue = 0
        return
    end
    entity.mPreLevel = CS.CSScene.MainPlayerInfo.Level
    entity.mTotalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(entity.mPreLevel)
    if entity.mLevelChangeValue > 0 then
        local form = 0
        local to = entity.mNextLevelFillAmount
        --if entity.mExpEffectHideCoroutine ~= nil then
        --    StopCoroutine(entity.mExpEffectHideCoroutine)
        --end
        local size = CS.UnityEngine.Vector3(to, 1, 1)
        --entity:SetTipsPostion(entity.expEffect, form)
        --entity.expEffect.transform.localScale = size
        --entity.expEffect:SetActive(true)
        entity:Play(form, to)
        --entity.mExpEffectHideCoroutine = StartCoroutine(UIExpSlider.HideExpEffect, entity, entity.expEffect)
    elseif entity.mLevelChangeValue < 0 then
        local form = 1
        local to = entity.mNextLevelFillAmount
        entity:Play(form, to)
    elseif entity.mLevelChangeValue == 0 then
        entity.mIsUpdateAction = false
        entity.mSlider_UISprite.spriteName = "exp1"
        entity:SetBarText(CS.CSScene.MainPlayerInfo.Exp, entity.mTotalExp)
    end
    entity.mLevelChangeValue = 0
end

---设置文本
function UIExpSlider:SetBarText(curExp, totalExp)
    local expStr = string.format("Exp %.0f/%.0f", curExp, totalExp)
    self.mText_UILabel.text = expStr
end

---是否跳过填充动画
function UIExpSlider:IsJumpExpTween()
    if self.mainChat then
        local entity = self.mainChat.mExpSlider
        if entity.mUpdateExpCoroutine ~= nil then
            StopCoroutine(entity.mUpdateExpCoroutine)
            entity.mUpdateExpCoroutine = nil
        end
        if (CS.CSScene.MainPlayerInfo == nil) then
            return
        end
        self.mPreLevel = CS.CSScene.MainPlayerInfo.Level
        self.mTotalExp = CS.Cfg_CharacterManager.Instance:GetUpGradeExpByLevel(self.mPreLevel)
        self.mPreFillAmount = CS.CSScene.MainPlayerInfo.Exp / self.mTotalExp
        self.mPreFillAmount = ternary(self.mPreFillAmount >= 1, 1, self.mPreFillAmount)
        self:SetBarText(CS.CSScene.MainPlayerInfo.Exp, self.mTotalExp)
    end
    if self.finishCallBack ~= nil then
        self.finishCallBack()
        self.finishCallBack = nil
    end
    return
end

function UIExpSlider:LoadEffect(code, parent, size, CallBack)
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.UIEffect, function(res)
        if res ~= nil or res.MirrorObj ~= nil then
            --设置父物体
            if parent == nil and CS.StaticUtility.IsNull(parent) then
                return
            end
            self.promptEffect_Path = res.Path
            local go = res:GetObjInst()
            if go then
                go.transform.parent = parent
                go.transform.localScale = size
            end
            if CallBack then
                CallBack(res.Path, go)
            end
        end
    end, CS.ResourceAssistType.UI)
end

function UIExpSlider:OnDestroy()
    if self.mUpdateExpCoroutine ~= nil then
        if self.mUpdateExpCoroutine ~= nil then
            StopCoroutine(self.mUpdateExpCoroutine)
        end
    end
    --if self ~= nil and self.mExpEffectHideCoroutine ~= nil then
    --    StopCoroutine(self.mExpEffectHideCoroutine)
    --end
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResPlayerExpChangeMessage, self.mFuncBindedInExpChangeMsg)
end

return UIExpSlider