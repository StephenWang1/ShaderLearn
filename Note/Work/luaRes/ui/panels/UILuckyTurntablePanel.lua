---@class UILuckyTurntablePanel:UIBase
local UILuckyTurntablePanel = {}

--region 组件
function UILuckyTurntablePanel:GetActivityTime_UICountdownLabel()
    if (self.mActivityTime == nil) then
        self.mActivityTime = self:GetCurComp("WidgetRoot/view/label_remainDay", "UICountdownLabel")
    end
    return self.mActivityTime
end

function UILuckyTurntablePanel:GetRemainLotteryCount_UILabel()
    if (self.mRemainLotteryCount == nil) then
        self.mRemainLotteryCount = self:GetCurComp("WidgetRoot/view/btn_chou/Label", "UILabel")
    end
    return self.mRemainLotteryCount
end

function UILuckyTurntablePanel:GetRechargeDes_UILabel()
    if (self.mRechargeDes == nil) then
        self.mRechargeDes = self:GetCurComp("WidgetRoot/view/rechargeDes", "UILabel")
    end
    return self.mRechargeDes
end

function UILuckyTurntablePanel:GetLotteryBtn_GameObject()
    if (self.mLotteryBtn == nil) then
        self.mLotteryBtn = self:GetCurComp("WidgetRoot/view/btn_chou", "GameObject")
    end
    return self.mLotteryBtn
end

function UILuckyTurntablePanel:GetRechargeBtn_GameObject()
    if (self.mRechargeBtn == nil) then
        self.mRechargeBtn = self:GetCurComp("WidgetRoot/events/btn_recharge", "GameObject")
    end
    return self.mRechargeBtn
end

function UILuckyTurntablePanel:GetRewardGroup_GameObject()
    if (self.mRewardGroupGo == nil) then
        self.mRewardGroupGo = self:GetCurComp("WidgetRoot/view/reward", "GameObject")
    end
    return self.mRewardGroupGo
end

function UILuckyTurntablePanel:GetZhiZhen_Transform()
    if (self.mZhiZhenTran == nil) then
        self.mZhiZhenTran = self:GetCurComp("WidgetRoot/view/zhizhen", "Transform")
    end
    return self.mZhiZhenTran
end

function UILuckyTurntablePanel:GetLotteryBtnEffect_GameObject()
    if (self.mLotteryBtnEffect == nil) then
        self.mLotteryBtnEffect = self:GetCurComp("WidgetRoot/view/btn_chou/Effect", "GameObject")
    end
    return self.mLotteryBtnEffect
end

--endregion

--region 初始化
function UILuckyTurntablePanel:Init()
    self.isStartRotate = false
    self:BindMessage()
    self:BindUIEvents()
end

---@param activityData SpecialActivityPanelData
function UILuckyTurntablePanel:Show(activityData)
    networkRequest.ReqLuckTurntableInfo()
    self.mActivityData = activityData
    self:ParseData()
    self:RefreshPanel()
end

--endregion

--region 绑定网络消息
function UILuckyTurntablePanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLuckTurntableInfoMessage, function()
        self:ResLuckTurntableInfo()
    end)
end

--endregion

--region 网络消息处理
function UILuckyTurntablePanel:ResLuckTurntableInfo()
    self:RefreshEndTime()
    self:RefreshLotteryRemainCount()
    self:RefreshRechargeCount()
    self.mCurLotteryIndex = gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetNextLotteryIndex()
end

--endregion

--region 绑定客户端事件

function UILuckyTurntablePanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetLotteryBtn_GameObject()).onClick = function(go)
        self:LotteryBtnOnClick(go)
    end

    CS.UIEventListener.Get(self:GetRechargeBtn_GameObject()).onClick = function(go)
        self:RechargeBtnOnClick(go)
    end

end
--endregion

--region 客户端事件处理
---抽奖按钮点击事件
function UILuckyTurntablePanel:LotteryBtnOnClick(go)
    if (self.isStartRotate == false) then
        if (math.max(0, self.LotteryRemainNum - gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnLotteryNum()) > 0) then
            --self:RefreshRewardPool()
            if (self.LastLotteryEffect ~= nil) then
                self.LastLotteryEffect:SetActive(false)
            end
            self:StartZhiZhenRotation()
        else
            Utility.ShowTips(go, 515)
        end
    end
end

function UILuckyTurntablePanel:RechargeBtnOnClick(go)
    Utility.TryShowFirstRechargePanel()
end
--endregion

--region 数据处理
function UILuckyTurntablePanel:ParseData()
    local mActivityID = 0
    if (self.mActivityData ~= nil) then
        mActivityID = self.mActivityData.mActivityID
        ---@type TABLE.cfg_special_activity
        local SpecialActivityData = clientTableManager.cfg_special_activityManager:TryGetValue(mActivityID)
        if (SpecialActivityData ~= nil) then
            ---获取当前充值金额能够进行抽奖的次数（注意，真实次数应再减去已抽次数）
            self.LotteryRemainNum = self:GetCurRechargeCanLotteryCount(SpecialActivityData)
            ---奖励列表
            self.CurRewardList = self:GetCurRewardList(SpecialActivityData)
        end
    end

    self:GetBgEffectId()
end

---获取当前充值金额能够进行抽奖的次数
function UILuckyTurntablePanel:GetCurRechargeCanLotteryCount(SpecialActivityData)
    ---参数列表 globalid#globalid#globalid
    local ParmList = SpecialActivityData:GetGoal().list
    ---充值额度对应抽奖次数列表 globalId
    local LotteryCountListID = ParmList[1]
    local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(LotteryCountListID)
    if (tblExist) then
        local LotteryCountList = string.Split(tbl.value, '&')
        for i = 1, #LotteryCountList do
            local str2 = string.Split(LotteryCountList[i], '#')
            if (gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnRechargeRmb() < tonumber(str2[2])) then
                self.NextLotteryRechargeCount = tonumber(str2[2])
                if (i == 1) then
                    return 0
                else
                    str2 = string.Split(LotteryCountList[i - 1], '#')
                    return tonumber(str2[1])
                end
            else
                self.NextLotteryRechargeCount = nil
                if (i == #LotteryCountList) then
                    str2 = string.Split(LotteryCountList[i], '#')
                    return tonumber(str2[1])
                end
            end
        end
    end
    return 0
end

---奖励列表
function UILuckyTurntablePanel:GetCurRewardList(SpecialActivityData)
    ---参数列表 globalid#globalid#globalid
    local ParmList = SpecialActivityData:GetGoal().list
    ---抽奖奖励列表 globalId
    local RewardListID = ParmList[2]
    local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(RewardListID)
    if (tblExist) then
        local RewardList = string.Split(tbl.value, '&')
        return RewardList
    end
end

function UILuckyTurntablePanel:GetBgEffectId()
    ---奖品品质色列表 globalId
    self.BgEffectList = {}
    local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(23127)
    if (tblExist) then
        local BgEffectIndexList = string.Split(tbl.value, '&')
        for i = 1, #BgEffectIndexList do
            local BgEffectIdList = string.Split(BgEffectIndexList[i], '#')
            if (#BgEffectIdList >= 2) then
                self.BgEffectList[tonumber(BgEffectIdList[1])] = BgEffectIdList[2]
            end
        end
    end
    return self.BgEffectList
end

--endregion

--region 界面刷新
function UILuckyTurntablePanel:RefreshPanel()
    self:RefreshEndTime()
    self:RefreshRewardPool()
    self:RefreshLotteryRemainCount()
    self:RefreshRechargeCount()
end

---刷新奖励池子
function UILuckyTurntablePanel:RefreshRewardPool()
    local count = self:GetRewardGroup_GameObject().transform.childCount
    for i = 0, count - 1 do
        local go = self:GetRewardGroup_GameObject().transform:GetChild(i)
        if (go ~= nil) then
            local icon = CS.Utility_Lua.GetComponent(go.transform:Find("UIItem/icon"), "UISprite")
            local count = CS.Utility_Lua.GetComponent(go.transform:Find("UIItem/count"), "UILabel")
            local bg = CS.Utility_Lua.GetComponent(go.transform:Find("pan"), "GameObject")
            local effect = CS.Utility_Lua.GetComponent(go.transform:Find("effect"), "GameObject")
            local bgeffect = CS.Utility_Lua.GetComponent(go.transform:Find("UIItem/bgeffect"), "UISprite")
            local str = string.Split(self.CurRewardList[i + 1], '#')

            if (Utility.GetLuaTableCount(str) >= 2) then
                local itemId = str[1]
                local itemcount = str[2]
                ---@type TABLE.CFG_ITEMS
                local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(itemId))
                if (isfind) then
                    icon.spriteName = itemInfo.icon
                    count.text = itemcount
                    CS.UIEventListener.Get(icon.gameObject).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                    end
                end
                bg:SetActive(false)
            end
            bgeffect.spriteName = self:RefreshGiftQualitColor(i + 1)
            bgeffect:MakePixelPerfect()

            if (self:CheckIsLotterySuccess(i + 1)) then
                bg:SetActive(true)
            end
            if (self.mCurLotteryIndex ~= nil and self.mCurLotteryIndex == i + 1) then
                effect:SetActive(true)
                self.LastLotteryEffect = effect
            end
        end
    end
end

---检测是否这个格子是否被抽中过
---@param index number 格子位置
function UILuckyTurntablePanel:CheckIsLotterySuccess(index)
    local obtains = gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnLotteryObtains()
    table.insert(obtains, self.mCurLotteryIndex)
    for i = 1, #obtains do
        if (obtains[i] == index) then
            return true
        end
    end
    return false
end

---刷新奖励品质色特效框
function UILuckyTurntablePanel:RefreshGiftQualitColor(index)
    if (self.BgEffectList[index] ~= nil) then
        return self.BgEffectList[index]
    end
    return 0
end

---刷新活动倒计时
function UILuckyTurntablePanel:RefreshEndTime()
    self:GetActivityTime_UICountdownLabel():StartCountDown(nil, 8, gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnLotteryEndTime() * 1000, '活动倒计时', "", nil, nil)
end

---刷新剩余抽奖次数
function UILuckyTurntablePanel:RefreshLotteryRemainCount()
    self:GetRemainLotteryCount_UILabel().text = "剩余次数" .. tostring(math.max(0, self.LotteryRemainNum - gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnLotteryNum()))
    if (math.max(0, self.LotteryRemainNum - gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnLotteryNum()) > 0) then
        self:GetLotteryBtnEffect_GameObject():SetActive(true)
    else
        self:GetLotteryBtnEffect_GameObject():SetActive(false)
    end
end

---刷新再充值多少数量可以开启下一次抽奖
function UILuckyTurntablePanel:RefreshRechargeCount()
    if (self.NextLotteryRechargeCount == nil) then
        self:GetRechargeDes_UILabel().text = "[ffd3a3]抽奖次数已全部领取"
    else
        local count = self.NextLotteryRechargeCount - gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():GetLuckTurnRechargeRmb()
        self:GetRechargeDes_UILabel().text = "[ffd3a3]再充值[00ff00]" .. tostring(count) .. "[-]元，即可增加1次抽奖机会"
    end
end

---开始旋转指针
function UILuckyTurntablePanel:StartZhiZhenRotation()
    ---目标旋转角度
    self.mRotationAngle = self:GetRotationAngle()
    self.mCurRotationAngle = 0
    self.isStartRotate = true
end

---获取目标旋转角度
function UILuckyTurntablePanel:GetRotationAngle()
    if (self.mCurLotteryIndex == nil) then
        return 0
    end
    if (self.mCurLotteryIndex <= 4) then
        return (1 - self.mCurLotteryIndex) * 45 - 22.5
    else
        return (8 - self.mCurLotteryIndex) * 45 + 22.5
    end
end
--endregion

function update()
    if (UILuckyTurntablePanel.isStartRotate) then
        ---先虚拟转一圈，模拟抽奖
        if (math.abs(UILuckyTurntablePanel.mCurRotationAngle) >= 360) then
            UILuckyTurntablePanel:GetZhiZhen_Transform().localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, UILuckyTurntablePanel.mCurRotationAngle);
            UILuckyTurntablePanel.mCurRotationAngle = UILuckyTurntablePanel.mCurRotationAngle - 3

            if (math.fmod(UILuckyTurntablePanel.mCurRotationAngle, 360) >= -180) then
                if (math.abs(UILuckyTurntablePanel.mRotationAngle - math.fmod(UILuckyTurntablePanel.mCurRotationAngle, 360)) <= 5) then
                    UILuckyTurntablePanel:GetZhiZhen_Transform().localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, UILuckyTurntablePanel.mCurRotationAngle - 5);
                    UILuckyTurntablePanel.isStartRotate = false
                    UILuckyTurntablePanel:RefreshRewardPool()
                    networkRequest.ReqLuckTurntableLottery()
                end
            else
                if (math.abs(UILuckyTurntablePanel.mRotationAngle - 180 - math.fmod(UILuckyTurntablePanel.mCurRotationAngle, 180)) <= 5) then
                    UILuckyTurntablePanel:GetZhiZhen_Transform().localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, UILuckyTurntablePanel.mCurRotationAngle - 5);
                    UILuckyTurntablePanel.isStartRotate = false
                    UILuckyTurntablePanel:RefreshRewardPool()
                    networkRequest.ReqLuckTurntableLottery()
                end
            end
        else
            UILuckyTurntablePanel:GetZhiZhen_Transform().localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, UILuckyTurntablePanel.mCurRotationAngle);
            UILuckyTurntablePanel.mCurRotationAngle = UILuckyTurntablePanel.mCurRotationAngle - 8
        end
    end
end

function UILuckyTurntablePanel:HideSelf()
    if (self.LastLotteryEffect ~= nil) then
        self.LastLotteryEffect:SetActive(false)
    end
    self.mCurLotteryIndex = nil---切换页签将亮起的icon隐藏

    self:RunBaseFunction("HideSelf")
end

function ondestroy()

end

return UILuckyTurntablePanel