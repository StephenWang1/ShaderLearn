---@class UIBossScoreGridTemplate:TemlateBase Boss积分格子模板
local UIBossScoreGridTemplate = {}

---@param UIBossPanel UIBossPanel
function UIBossScoreGridTemplate:Init(UIBossPanel)
    self.RootPanel = UIBossPanel
    self:InitComponent()
    self:BindEvent()
end

function UIBossScoreGridTemplate:InitComponent()
    ---@type UISprite
    ---背景底图
    self.BG_UISprite = self:Get("backGround", "UISprite")

    ---@type UISprite
    ---进度背景图
    self.progressBG_UISprite = self:Get("Slider_Top/Background", "UISprite")

    ---@type UISprite
    ---前置图
    self.progressForward_UISprite = self:Get("Slider_Top/Foreground", "UISprite")

    ---@type UISprite
    ---亮点
    self.centerLight = self:Get("Slider_Top/Slider_LightPoint", "UISprite")

    ---@type UILabel
    ---分数
    self.score_UILabel = self:Get("Slider_Top/score", "UILabel")

    ---@type UIGridContainer
    ---免费奖励
    self.mFreeReward_UIGridContainer = self:Get("free_reward", "UIGridContainer")

    ---@type UIGridContainer
    ---付费奖励
    self.mChargeReward_UIGridContainer = self:Get("charge_reward", "UIGridContainer")

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.mRewardBtn_GameObject = self:Get("btn_get", "GameObject")

    ---@type UILabel
    ---领奖文字
    self.mRewardBtn_UILabel = self:Get("lb", "UILabel")

    ---@type UnityEngine.GameObject
    ---领完标记
    self.mRewardedSign_GameObject = self:Get("has_got", "GameObject")

    ---箭头图片
    ---@type UISprite
    self.arrow_UISprite = self:Get("Slider_Top/arrow", "UISprite")

    ---@type UnityEngine.GameObject
    ---领奖按钮特效1
    self.mRewardBtn_EffectOneObj = self:Get("btn_get/effectOne", "GameObject")

    ---@type UnityEngine.GameObject
    ---领奖按钮特效2
    self.mRewardBtn_EffectTwoObj = self:Get("btn_get/effectTwo", "GameObject")

    ---前景图片高度
    self.mForwardSpSizeHeight = 98

    ---@type TweenAlpha
    ---背景Alpha
    self.mBg_TweenAlpha = self:Get("backGround", "TweenAlpha")

    ---@type TweenAlpha
    ---箭头Alpha
    self.mArrow_TweenAlpha = self:Get("Slider_Top/arrow", "TweenAlpha")
end

function UIBossScoreGridTemplate:BindEvent()
    CS.UIEventListener.Get(self.centerLight.gameObject).onClick = function()
        if self.killBossNum and self.RootPanel then
            local str = self.RootPanel:GetBossKillBubbleShow()
            if str and self.killBossNum > 0 then
                local Show = string.format(str, self.killBossNum)
                Utility.ShowPopoTips(self.centerLight.gameObject, Show, 221)
            end
        end
    end
end

---刷新单行
---@param data activityV2.BossScoreRewards 积分详情
---@param line  number 行数
---@param length number 长度 判断是否是最后一个
---@param  integralTableData TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIBossScoreGridTemplate:Refresh(data, line, length, integralTableData, isCard)
    self.mIsProgressLine = false
    if data and line and length and integralTableData then
        self.killBossNum = data.killCount
        self:RefreshProgress(data, line, length, integralTableData)
        local hasReward = data.state == 3
        self:RefreshReward(integralTableData, isCard, hasReward)
        self:RefreshBtnShow(data, isCard)
        self:RefreshBgShow(data, line, isCard)
        --self:ProgressEffectState()
    end
end

---刷新进度
---@param data activityV2.BossScoreRewards 积分详情
---@param line  number 行数
---@param length number 长度 判断是否是最后一个
---@param integralTableData TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIBossScoreGridTemplate:RefreshProgress(data, line, length, integralTableData, isCard)
    local isFinish = data.state ~= 0--data.state == 1 or (data.state == 2 and isCard)
    self.centerLight.color = ternary(isFinish, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)

    local scoreColor = isFinish and luaEnumColorType.DeepYellow1 or ""
    self.score_UILabel.text = scoreColor .. integralTableData.remarks

    --[[    local forwardSp = "Hunters_slider_middle2"
        local currentScore = self.RootPanel:GetActivityInfo().BossScoreResInfo.score
        local spRate = 1
        if integralTableData.requestIntegral >= currentScore then
            local lastInfo = self.RootPanel:GetBossScoreData(line - 1)
            if lastInfo then
                local lastTable = self.RootPanel:GetIntegralData(lastInfo.id)
                if currentScore > lastTable.requestIntegral then
                    forwardSp = "Hunters_slider_down2"
                    spRate = (currentScore - lastTable.requestIntegral) / (integralTableData.requestIntegral - lastTable.requestIntegral)
                    self.mIsProgressLine = true
                else
                    --还没到该行
                    forwardSp = "Hunter"
                    spRate = 0
                end
            else
                --当前是首行
                forwardSp = "Hunters_slider_down2"
                spRate = (currentScore / integralTableData.requestIntegral)
                self.mIsProgressLine = true
            end
        end
        self.progressForward_UISprite.height = math.ceil(self.mForwardSpSizeHeight * spRate)
        self.progressForward_UISprite.spriteName = forwardSp]]
end

---刷新奖励
---@param isCard boolean 是否是猎魔人
---@param integralTableData TABLE.CFG_BOSS_INTEGRAL_REWARD
function UIBossScoreGridTemplate:RefreshReward(integralTableData, isCard, hasReward)
    local freeRewardList = integralTableData.freeReward.list
    self:RefreshRewardContainer(freeRewardList, self.mFreeReward_UIGridContainer, 1, isCard, hasReward)
    local chargeRewardList = integralTableData.chargeReward.list
    self:RefreshRewardContainer(chargeRewardList, self.mChargeReward_UIGridContainer, 2, isCard, hasReward)
end

---@param showList table< TABLE.IntList> 显示List
---@param container UIGridContainer 组件
---@param type /免费1/付费2
---@param isCard boolean 是否猎魔人
function UIBossScoreGridTemplate:RefreshRewardContainer(showList, container, type, isCard, hasReward)
    if showList == nil or CS.StaticUtility.IsNull(container) then
        return
    end
    if showList then
        container.MaxCount = showList.Count
        for i = 0, showList.Count - 1 do
            local go = container.controlList[i]

            ---@type UnityEngine.GameObject
            ---icon
            local sp = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")

            ---@type  UILabel
            ---数目
            local num = CS.Utility_Lua.Get(go.transform, "count", "UILabel")

            ---锁
            ---@type UnityEngine.GameObject
            local lock = CS.Utility_Lua.Get(go.transform, "lock", "GameObject")

            ---奖励数据
            local data = showList[i].list

            ---不上锁
            local notLock = type == 1 or (type == 2 and isCard)

            ---设置锁
            if not CS.StaticUtility.IsNull(lock) then
                lock:SetActive(not notLock)
            end
            self.ShowList = showList
            ---设置显示
            if data and data.Count >= 2 then
                local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data[0])
                if res then
                    sp.spriteName = itemInfo.icon
                    local isGray = hasReward --or (type == 2 and not notLock)
                    local color = ternary(isGray, LuaEnumUnityColorType.DarkGray, LuaEnumUnityColorType.Normal)
                    sp.color = color
                    CS.UIEventListener.Get(sp.gameObject).onClick = function()
                        if notLock then
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                        else
                            local info = {}
                            info.type = 2
                            info.rewardList = self.RootPanel:GetFirstLineTableData()
                            uimanager:CreatePanel("UIMonsterHunterActivePanel", nil, info)
                        end
                    end
                end
                local showNum = data[1]
                num.text = showNum <= 1 and "" or showNum
            end
        end
    end
end

---刷新按钮显示
---@param data activityV2.BossScoreRewards 积分详情
---@param isCard boolean 是否猎魔人
---0未完成/1未领取普通/2未领取猎魔人/3全部领取完
function UIBossScoreGridTemplate:RefreshBtnShow(data, isCard)
    self.mRewardedSign_GameObject:SetActive(data.state == 3)
    self.mRewardBtn_GameObject:SetActive(data.state == 1 or data.state == 2)
    self.mRewardBtn_UILabel.gameObject:SetActive(data.state ~= 3)
    local word = luaEnumColorType.Gray .. "未完成"
    if data.state == 1 then
        word = "领取"
    elseif data.state == 2 then
        word = "继续领取"
    end
    self.mRewardBtn_UILabel.text = word
    CS.UIEventListener.Get(self.mRewardBtn_GameObject).onClick = function()
        if data.state == 0 then
            if self.RootPanel then
                Utility.ShowPopoTips(self.mRewardBtn_GameObject, self.RootPanel:GetUnFinishBubbleShow(), 221)
            end
        elseif data.state == 1 then
            networkRequest.ReqGetBossScoreReward(data.id)
        elseif data.state == 2 then
            if isCard then
                networkRequest.ReqGetBossScoreReward(data.id)
            else
                local data = {}
                data.type = 2
                data.isCard = false
                data.showList = self.ShowList
                uimanager:CreatePanel("UIMonsterHunterActivePanel", nil, data)
            end
        end
    end
    self:IsShowBtnEffectOne(data.state == 1)
    self:IsShowBtnEffectTwo(data.state == 2 and isCard)
end

---刷新背景显示
---@param data activityV2.BossScoreRewards 积分详情 0未完成/1未领取普通/2未领取猎魔人/3全部领取完
---@param line  number 行数
function UIBossScoreGridTemplate:RefreshBgShow(data, line, isCard)
    local sp = "bg_dark_l"
    local arrowSp = "lightPoint_lock"
    if data.state ~= 0 then
        sp = "bg_dark_l_full"
        arrowSp = "lightPoint_full"
    end

    self.BG_UISprite.spriteName = sp
    self.arrow_UISprite.spriteName = arrowSp
end

--region 特效

--region 按钮特效

function UIBossScoreGridTemplate:IsShowBtnEffectOne(isShow)
    if self.mRewardBtn_EffectOneObj then
        self.mRewardBtn_EffectOneObj:SetActive(isShow)
    end
end

function UIBossScoreGridTemplate:IsShowBtnEffectTwo(isShow)
    if self.mRewardBtn_EffectTwoObj then
        self.mRewardBtn_EffectTwoObj:SetActive(isShow)
    end
end

--endregion

--region 进度特效
function UIBossScoreGridTemplate:ProgressEffectState()
    self.mBg_TweenAlpha.enabled = self.mIsProgressLine
    self.mArrow_TweenAlpha.enabled = self.mIsProgressLine
end

--endregion

--endregion

--endregion

return UIBossScoreGridTemplate