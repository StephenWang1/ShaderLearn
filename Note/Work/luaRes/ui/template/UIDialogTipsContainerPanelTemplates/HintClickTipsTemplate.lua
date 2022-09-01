local HintClickTipsTemplate = {}
--region 参数
--endregion

--region 初始化
function HintClickTipsTemplate:Init()
    self:InitComponent()
    self:InitTemplate()
    self:InitOtherParams()
end

function HintClickTipsTemplate:InitComponent()
    self.cloneGameObject = self:Get("HintPopTip","GameObject")
    self.cloneGameObjectPoint = self.go
end

function HintClickTipsTemplate:InitTemplate()
    self.objectPoolTemplate = templatemanager.GetNewTemplate(self.go,luaComponentTemplates.CachePoolTemplate)
    self.objectPoolTemplate:InitCachePool({point = self.cloneGameObjectPoint,cloneGameObject = self.cloneGameObject,maxCount = 6})
end

function HintClickTipsTemplate:InitOtherParams()
    self.tipsTemplateTable = {}
    self.tipsTimeTable = {}
end
--endregion

--region 刷新显示
---刷新显示tips
---刷新并显示气泡
function HintClickTipsTemplate:RefreshTips(commonData)
    if self:AnalysisParams(commonData) == true then
        local pushCode,cloneGameObject = self.objectPoolTemplate:TryGetCloneGameObject()
        if pushCode == LuaEnumCachePoolFaultCode.NONE then
            commonData.hintClickTipsManager = self
            commonData.objectPoolTemplate = self.objectPoolTemplate
            local tipTemplate = templatemanager.GetNewTemplate(cloneGameObject,luaComponentTemplates.HintClickTipTemplate)
            tipTemplate:RefreshTip(commonData)
            self.tipsTemplateTable[commonData.guidBubbleInfo.id] = tipTemplate
            return tipTemplate
        end
    end
end

---解析参数
function HintClickTipsTemplate:AnalysisParams(commonData)
    self.commonData = commonData
    self.guidBubbleInfo = commonData.guidBubbleInfo
    self.point = commonData.point
    self.timeEndCallBack = commonData.timeEndCallBack
    ---检查是否有基础数据
    if self.guidBubbleInfo == nil or self.point == nil and self.point.activeSelf == false then
        return false
    end
    ---检查condition条件列表是否满足
    if CS.Cfg_Guide_BubbleTableManager.Instance:MainPlayerIsMatchConditionList(self.guidBubbleInfo.id) == false then
        return false
    end
    ---检查当前点击次数是否超过限制
    if self.guidBubbleInfo.times > 0 then
        local saveClickKey = CS.Cfg_Guide_BubbleTableManager.Instance:GetClickNumType(self.guidBubbleInfo.id)
        if Utility.EnumToInt(saveClickKey) > 0 then
            local nowClickNum = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(saveClickKey)
            if nowClickNum >= self.guidBubbleInfo.times then
                return false
            end
        end
    end
    ---检查是否在可显示时间内
    local nowServerTime = CS.CSScene.MainPlayerInfo.serverTime
    local endTime = self.tipsTimeTable[self.guidBubbleInfo.id]
    if endTime  ~= nil and endTime > 0 and nowServerTime < endTime then
        return false
    else
        self.tipsTimeTable[self.guidBubbleInfo.id] = nowServerTime + self.guidBubbleInfo.showCd * 1000
    end
    return true
end

---移除显示的气泡
function HintClickTipsTemplate:RemoveTips(tipsTemplate)
    if self.objectPoolTemplate ~= nil then
        self.tipsTemplateTable[tipsTemplate.guidBubbleInfo.id] = nil
        self.objectPoolTemplate:PushInCache(tipsTemplate.go)
    end
end
--endregion

--region 刷新气泡状态
function HintClickTipsTemplate:RefreshAllPopState(panelName)
    if self.tipsTemplateTable ~= nil then
        for k,v in pairs(self.tipsTemplateTable) do
            v:RefreshPopState(panelName)
        end
    end
end
--endregion
return HintClickTipsTemplate