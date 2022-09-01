---@class UIShiWangDianLeftPanel:UIBase 尸王殿
local UIShiWangDianLeftPanel = {}


--region  
function UIShiWangDianLeftPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
    self:BindNetMsg()
end

function UIShiWangDianLeftPanel:InitComponent()
    ---@type UILabel 活动倒计时
    self.lb_activesTime = self:GetCurComp("WidgetRoot/Tween/lb_activesTime","UILabel")
    ---@type UILabel 当前波数
    self.lb_num = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_num","UILabel")
    ---@type UILabel 刷新倒计时
    self.lb_refreshTime = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_refreshTime","UILabel")
    ---@type UILabel 剩余尸王数量
    self.lb_monsterNum = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_monsterNum","UILabel")
    ---@type UILabel 技能书持有者1
    self.lb_skillBook1 = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_skillBook1","UILabel")
    ---@type UILabel 技能书持有者2
    self.lb_skillBook2 = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_skillBook2","UILabel")
    ---@type UnityEngine.GameObject 帮助按钮
    self.mHelpButton = self:GetCurComp("WidgetRoot/Tween/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 退出按钮
    self.mExitButton = self:GetCurComp("WidgetRoot/Tween/btn_exit", "GameObject")
    ---@type UnityEngine.GameObject 箭头
    self.mHideButton = self:GetCurComp("WidgetRoot/Tween/btn_hide","GameObject")
    ---@type Top_TweenPosition
    self.tween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition")
end

function UIShiWangDianLeftPanel:InitParams()
    self.showTips_bool = true
    -- 活动倒计时(毫秒)
    self.time = 0
    -- 尸王刷新倒计时（毫秒）
    self.refreshTime = 0
    -- 技能书持有者的id
    self.curSkillBookHolderId = {}
	-- 需要移除技能书持有者的id
	self.NeedRemoveSkillBookHolderId = {}
    ---@type duplicateV2.RaiderInfo
    self.ShiWangInfo = gameMgr:GetPlayerDataMgr():GetLuaDuplicateMgr():GetShiWangData()
    -- 尸王刷新总波数
    self.totalWave = nil

    self.IEnumTimeLimit = nil
    self.IEnumRefreshTimeLimit = nil
end

function UIShiWangDianLeftPanel:BindEvents()
    -- 箭头
    CS.UIEventListener.Get(self.mHideButton).onClick = function(go)
        self:OnClickHide()
    end
    -- 帮助按钮
    CS.UIEventListener.Get(self.mHelpButton).onClick = function(go)
        self:OnClickHelp()
    end
    -- 退出按钮
    CS.UIEventListener.Get(self.mExitButton).onClick = function(go)
        self:OnClickExit()
    end
end

function UIShiWangDianLeftPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRaiderDuplicateInfoMessage, UIShiWangDianLeftPanel.OnResRaiderDuplicateInfoMessage)
end
--endregion

--region 函数监听

-- 帮助按钮事件
function UIShiWangDianLeftPanel:OnClickHelp()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(224)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

function UIShiWangDianLeftPanel:OnClickExit()
    Utility.ReqExitDuplicate()
end

-- 箭头按钮事件
function UIShiWangDianLeftPanel:OnClickHide()
    self.tween:SetOnFinished(self.ClickHideBtnCallBack)
    if self.showTips_bool then
        self.tween:PlayForward()
        self.showTips_bool = false
    else
        self.tween:PlayReverse()
        self.showTips_bool = true
    end
end
function UIShiWangDianLeftPanel.ClickHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not UIShiWangDianLeftPanel.showTips_bool then
        v3.z = 180
    end
    UIShiWangDianLeftPanel.mHideButton.transform.localEulerAngles = v3
end
--endregion

--region 网络消息处理
function UIShiWangDianLeftPanel.OnResRaiderDuplicateInfoMessage(msgId,msgData)
    UIShiWangDianLeftPanel.ShiWangInfo = msgData
    UIShiWangDianLeftPanel:RefreshUI()
end
--endregion

--region UI
function UIShiWangDianLeftPanel:Show()

    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22916)
    if isFind then
        self.totalWave = tonumber(info.value)
    end
    self:RefreshUI()
    self:StartCountDown()
end

function UIShiWangDianLeftPanel:RefreshUI()
    if self.ShiWangInfo == nil then
        return 
    end
    if self.totalWave ~= nil then
        self.lb_num.text = self.ShiWangInfo.wave.."/".. self.totalWave
    end
    self.lb_monsterNum.text = self.ShiWangInfo.curMonsterNum
    self:RefreshSkillBookInfo(self.ShiWangInfo.raiderSpecialItemInfos)
end

-- 刷新技能书持有者信息
---@type duplicateV2.RaiderSpecialItemInfo
function UIShiWangDianLeftPanel:RefreshSkillBookInfo(raiderSpecialItemInfos)
    if raiderSpecialItemInfos == nil then
        return
    end
    self.NeedRemoveSkillBookHolderId = {}
	local raiderSpecialItemInfosId = {}
    if #raiderSpecialItemInfos > 0 then
        table.sort(raiderSpecialItemInfos, function(l, r)
            return l.time < r.time
        end)
		self.lb_skillBook1.text = raiderSpecialItemInfos[1].name
		self.lb_skillBook2.text = #raiderSpecialItemInfos >1 and raiderSpecialItemInfos[2].name or ""
        for i = 1, #raiderSpecialItemInfos do
			table.insert(raiderSpecialItemInfosId,raiderSpecialItemInfos[i].rid)
            if(not Utility.IsContainsValue(self.curSkillBookHolderId,raiderSpecialItemInfos[i].rid)) then
                CS.CSScene.Sington.HeadExtraComponentsInScene:AddExtraEffectName(raiderSpecialItemInfos[i].rid, "800007", 150)
				CS.CSScene.Sington.HeadExtraComponentsInScene:AddExtraCountDownLabel(raiderSpecialItemInfos[i].rid, raiderSpecialItemInfos[i].time)
                table.insert(self.curSkillBookHolderId,raiderSpecialItemInfos[i].rid)
			end
        end
		
        for i =1, #self.curSkillBookHolderId do
            if(not Utility.IsContainsValue(raiderSpecialItemInfosId,self.curSkillBookHolderId[i])) then
                table.insert(self.NeedRemoveSkillBookHolderId,self.curSkillBookHolderId[i])
            end
        end
    else
		self.NeedRemoveSkillBookHolderId = self.curSkillBookHolderId
        self.lb_skillBook1.text = ""
        self.lb_skillBook2.text = ""
    end
    self:DealRemoveHeadEffect()
    self:StartRefreshTime()
end

--endregion

-- 是否移除头顶的宝箱
function UIShiWangDianLeftPanel:DealRemoveHeadEffect()
    for i = 1, #self.NeedRemoveSkillBookHolderId do
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraEffectName(self.NeedRemoveSkillBookHolderId[i])
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraCountDownLabel(self.NeedRemoveSkillBookHolderId[i])
        Utility.RemoveTableValue(self.curSkillBookHolderId,self.NeedRemoveSkillBookHolderId[i])
    end
end


-- 活动倒计时
function UIShiWangDianLeftPanel:StartCountDown()
    if self.ShiWangInfo == nil then
        return
    end
    self.time = self.ShiWangInfo.endTime - CS.CSServerTime.Instance.TotalMillisecond
    if self.IEnumTimeLimit ~= nil then 
        StopCoroutine(self.IEnumTimeLimit)
        self.IEnumTimeLimit = nil
    end
    self.IEnumTimeLimit = StartCoroutine(self.TimeLimit)
end

function UIShiWangDianLeftPanel.TimeLimit()

    local hour, minute, second
    while UIShiWangDianLeftPanel.time > 0 do
        
        hour, minute, second = Utility.MillisecondToFormatTime(UIShiWangDianLeftPanel.time)
        if hour > 0 then
            UIShiWangDianLeftPanel.lb_activesTime.text = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
        else
            UIShiWangDianLeftPanel.lb_activesTime.text = string.format("%02.0f:%02.0f", minute, second)
        end
        UIShiWangDianLeftPanel.time = UIShiWangDianLeftPanel.time - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end

    -- 活动倒计时结束 退出副本 关闭面板
    if UIShiWangDianLeftPanel.time <= 0 then
        networkRequest.ReqExitDuplicate(0)
        uimanager:ClosePanel('UIShiWangDianLeftPanel')
    end

end


-- 刷新倒计时
function UIShiWangDianLeftPanel:StartRefreshTime()
    if self.IEnumTimeLimit ~= nil then
        StopCoroutine(self.IEnumTimeLimit)
        self.IEnumTimeLimit = nil
    end
    self.time = self.ShiWangInfo.endTime - CS.CSServerTime.Instance.TotalMillisecond
    self.IEnumTimeLimit = StartCoroutine(self.TimeLimit)

    if self.IEnumRefreshTimeLimit ~= nil then
        StopCoroutine(self.IEnumRefreshTimeLimit)
        self.IEnumRefreshTimeLimit = nil
    end
    self.refreshTime = self.ShiWangInfo.nextWaveTime - CS.CSServerTime.Instance.TotalMillisecond
    self.IEnumRefreshTimeLimit = StartCoroutine(self.RefreshTimeLimit)
end

function UIShiWangDianLeftPanel.RefreshTimeLimit()
    -- 已经是最后一波则不再进行尸王的倒计时
    if (UIShiWangDianLeftPanel.refreshTime <= 0 or (self.totalWave ~= nil and self.totalWave <= self.ShiWangInfo.wave)) then
        UIShiWangDianLeftPanel.refreshTime = 0
        UIShiWangDianLeftPanel.lb_refreshTime.text = UIShiWangDianLeftPanel.refreshTime <= 0  and "00:00" or "已刷完"
        StopCoroutine(UIShiWangDianLeftPanel.IEnumRefreshTimeLimit)
        UIShiWangDianLeftPanel.IEnumRefreshTimeLimit = nil       
        return
    end
    while UIShiWangDianLeftPanel.refreshTime > 0 do
        
        UIShiWangDianLeftPanel.lb_refreshTime.text = string.format("%02.0f:%02.0f",Utility.MillisecondToMinuteTime(UIShiWangDianLeftPanel.refreshTime))
        UIShiWangDianLeftPanel.refreshTime = UIShiWangDianLeftPanel.refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
    
end

-- 清理头部组件
function UIShiWangDianLeftPanel:ClearHeadExtra()
    if CS.CSScene.Sington == nil then
        return
    end
    for i = 1, #self.curSkillBookHolderId do
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraEffectName(self.curSkillBookHolderId[i])
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraCountDownLabel(self.curSkillBookHolderId[i])
    end
    for i = 1, #self.NeedRemoveSkillBookHolderId do
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraEffectName(self.NeedRemoveSkillBookHolderId[i])
        CS.CSScene.Sington.HeadExtraComponentsInScene:RemoveExtraCountDownLabel(self.NeedRemoveSkillBookHolderId[i])
    end
end

function ondestroy()
    UIShiWangDianLeftPanel:ClearHeadExtra()
    if UIShiWangDianLeftPanel.IEnumTimeLimit ~= nil then
        StopCoroutine(UIShiWangDianLeftPanel.IEnumTimeLimit)
        UIShiWangDianLeftPanel.IEnumTimeLimit = nil
    end
    if UIShiWangDianLeftPanel.IEnumRefreshTimeLimit ~= nil then
        StopCoroutine(UIShiWangDianLeftPanel.IEnumRefreshTimeLimit)
        UIShiWangDianLeftPanel.IEnumRefreshTimeLimit = nil
    end
    
    uimanager:ClosePanel('UIShiWangDianLeftPanel')
end



return UIShiWangDianLeftPanel