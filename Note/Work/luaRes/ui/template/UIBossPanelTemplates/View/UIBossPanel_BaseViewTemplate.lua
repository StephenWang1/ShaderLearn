---@class UIBossPanel_BaseViewTemplate:TemplateBase boss视图基类
local UIBossPanel_BaseViewTemplate = {}

function UIBossPanel_BaseViewTemplate:GetBossInfo()
    if self.mBossInfo == nil then
        if CS.CSScene.MainPlayerInfo ~= nil then
            self.mBossInfo = CS.CSScene.MainPlayerInfo.BossInfoV2
        end
    end
    return self.mBossInfo
end

function UIBossPanel_BaseViewTemplate:GetBossPage()
    if self.mBossPageInfo == nil then
        self.mBossPageInfo = LuaGlobalTableDeal.GetBossSubTabList(self.mBossType)
    end
    return self.mBossPageInfo
end

---@type table <UnityEngine.GameObject,TemplateBase> <go,TemplateBase>
function UIBossPanel_BaseViewTemplate:GetAllBossUnitTemplateDic()
    if self.allBossUnitTempateDic == nil then
        ---@type UIBossPanel
        local panel = uimanager:GetPanel("UIBossPanel")
        if panel then
            self.allBossUnitTempateDic = panel.allBossUnitTempateDic
        end
    end
    return self.allBossUnitTempateDic
end

---@return UIBossPanel_LeftPageTemplate 左侧页签模板
function UIBossPanel_BaseViewTemplate:GetLeftPageTemplate()
    if self.mLeftPageTemplate == nil then
        local panel = uimanager:GetPanel("UIBossPanel")
        if panel then
            self.mLeftPageTemplate = panel.leftPageViewTemplate
        end
    end
    return self.mLeftPageTemplate
end

---@return number 获取默认选择的子页签id
function UIBossPanel_BaseViewTemplate:GetDefaultChooseSubtype()
    if self.mGetDefaultChooseSubtype == nil then
        ---@type UIBossPanel
        local panel = uimanager:GetPanel("UIBossPanel")
        if panel then
            self.mGetDefaultChooseSubtype = panel:GetDefaultChooseSubtype()
        end
    end
    return self.mGetDefaultChooseSubtype
end
--region 初始化

function UIBossPanel_BaseViewTemplate:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIBossPanel_BaseViewTemplate:InitParameters()
    self.mBossType = nil
    self.targetPageType = nil
    self.targetBossId = nil
    self.curSelectPageInfo = nil
    ---@type table <number,table> <pageType,boss信息列表>
    self.curAllBossDic = {}
    ---@type table <number,table> <pageType,boss信息列表> 排序之后的信息列表
    self.curAllSortedBossDic = {}
    ---@type table <number,boolean> <pageType,可进入地图的怪物是否全部死亡>
    self.curBossPageStateDic = {}
    ---@type table <number,table<number,number>>  ps:<pageType,<configId,count>> boss 可进入地图的boss存活数量
    self.curAllBossStateDic = {}
    ---@type table <number,table<number,boolean>>  ps:<pageType,<configId,是否满足条件>> boss是否满足进入条件字典
    self.curAllIsMeetBossStateDic = {}
    ---@type table <number,table<number,boolean>>  满足条件的boss是否存活字典
    self.curAllIsMeetBossIsSurviveDic = {}
    ---@type table <number,number>  页签下boss存活数量
    self.curAllBossSurviveNumDic = {}
    ---@type table <number,number>  页签下所有boss总数量
    self.curAllBossSurviveTotalCountDic = {}

end

function UIBossPanel_BaseViewTemplate:InitComponents()
    ---@type UILoopScrollViewPlus
    self.loopScrollViewPlus = self:Get("scroll/Grid", "UILoopScrollViewPlus")
    ---@type UIScrollView
    self.scrollView = self:Get("scroll", "Top_UIScrollView")
    ---@type Top_OptimizeClipShaderScript
    self.shaderClip = self:Get("scroll", "Top_OptimizeClipShaderScript")
    ---@type UIScrollViewArrowLoopScrollView
    self.arrowPanel = self:Get("arrowPanel", "UIScrollViewArrow")
end

--endregion

--region Show

function UIBossPanel_BaseViewTemplate:InitTemplate(customData)
    self.mBossType = customData.bossType
    self.unitTemplate = luaComponentTemplates.UIChallengeBoss_WildBossTemplates
end

---页面状态控制
---@protected
function UIBossPanel_BaseViewTemplate:SetViewState(isOpen, targetBossId, targetPage)
    self.go:SetActive(isOpen)
    self:ResetData()
    if targetPage then
        self.targetPageType = targetPage
    else
        if targetBossId then
            self:SetTargetBoss(targetBossId)
        end
    end
    --if isOpen then
    --    self:ShowLeftPage()
    --end
end

--endregion

--region UI
---无数据刷新
function UIBossPanel_BaseViewTemplate:NoDataRefresh()
    self:ShowLeftPage()
    self:RefreshView()
    self:SetDefaultSelect()
    self:DefaultRefresh()
end

---显示左侧页签
---显示左侧页签
function UIBossPanel_BaseViewTemplate:ShowLeftPage()
    if not self:IsShowLeftPageView() then
        return
    end
    if self:GetLeftPageTemplate() == nil then
        return
    end
    self.curSelectPageInfo = nil
    local pageList = self:GetBossPage()
    if pageList == nil then
        return
    end
    self.pageDataList = {}
    for i = 1, #pageList do
        if self:IsShowPage(pageList[i]) then
            local data = {}
            data.origionData = pageList[i]
            data.pageType = pageList[i].type
            data.ShowStr = self:GetPageName(pageList[i])
            data.SelectconditionList = pageList[i].SelectconditionList
            data.pageAllMonsterIsDead = self.curBossPageStateDic[pageList[i].type]
            data.RedPointEnum = self:GetRegisterRedPointEnum(i)
            data.ClickCallBack = function(go)
                return self:PageClick(go, pageList[i])
            end
            table.insert(self.pageDataList, data)
        end
    end
    self:GetLeftPageTemplate().go:SetActive(true)
end

---获取页签名字
---@param pageInfo table 页签数据
function UIBossPanel_BaseViewTemplate:GetPageName(pageInfo)

    if pageInfo == nil then
        return ""
    end

    if self:BookMarkIsShowBossFill() and pageInfo.type ~= nil then
        local all = self.curAllBossSurviveTotalCountDic[pageInfo.type]
        if all ~= nil and all ~= 0 then
            local remail = self.curAllBossSurviveNumDic[pageInfo.type]
            local killNum = remail == nil and 0 or remail
            local killNumMax = all == nil and 0 or all
            local stringFormat = pageInfo.typeDes .. "(%d/%d)"
            return string.format(stringFormat, killNum, killNumMax)
        end
    end
    return pageInfo.typeDes == nil and "" or pageInfo.typeDes
end

---页签点击事件
---@param go UnityEngine.GameObject
---@param pageInfo table 策划配置的页签数据
---@return boolean 是否可以点击
function UIBossPanel_BaseViewTemplate:PageClick(go, pageInfo)
    if pageInfo.bubbleId ~= nil and self:IsMeetTabcondition(pageInfo.SelectconditionList) == false then
        Utility.ShowPopoTips(go, nil, pageInfo.bubbleId)
        return false
    end
    if self.curSelectPageInfo ~= pageInfo then
        self.curSelectPageInfo = pageInfo
        self.mInitialized = false;
        self:RefreshView()
    end
    return true
end

---设置默认页签选择（从下往上选择有可杀boss的页签）
function UIBossPanel_BaseViewTemplate:SetDefaultSelect()
    if self.pageDataList ~= nil then
        local index = 0;
        if self.mBossType == LuaEnumBossType.ZodiacBOSS or self.mBossType == LuaEnumBossType.DemonBoss then

            local jumpNumber = self:GetJumpNumber()
            index = #self.pageDataList - jumpNumber
            if index == 0 then
                index = 1
            end
            if self.curSelectPageInfo == nil then
                self.curSelectPageInfo = self.pageDataList[index]
                self:RefreshView()
            end
            if self.pageDataList[index] ~= nil then
                self.targetPageType = self.pageDataList[index].pageType
            end
        end

        ---默认选择页签数据
        if self:GetDefaultChooseSubtype() ~= nil then
            self.targetPageType = self:GetDefaultChooseSubtype()
        end

        self:GetLeftPageTemplate():SetTemplate(self.pageDataList, { targetTyp = self.targetPageType, bossType = self.mBossType })
        if self.mBossType == LuaEnumBossType.ZodiacBOSS or self.mBossType == LuaEnumBossType.DemonBoss then
            if #self.pageDataList > 9 then
                local line = index - 1
                if line < 0 then
                    line = 0
                end
                if line >= #self.pageDataList - 10 then
                    line = #self.pageDataList - 9
                end
                self:GetLeftPageTemplate().BookMarkLoopScrollViewPlus:JumpToLine(line)
                if index == 1 then
                    index = 0
                end
                self:GetLeftPageTemplate().ScorllView:ScrollImmediately(index / #self.pageDataList)
            end
        end
    end
end

---得到默认跳转页签
function UIBossPanel_BaseViewTemplate:GetJumpNumber()
    if self.curAllIsMeetBossIsSurviveDic == nil then
        return 0
    end
    local index = 0
    for i = 0, #self.pageDataList - 1 do
        local nowTab = self.pageDataList[#self.pageDataList - i]
        local SelectconditionList = nowTab.SelectconditionList
        local isMeetTabcondition = self:IsMeetTabcondition(SelectconditionList)

        if isMeetTabcondition == false then
            index = index + 1
        else
            local dic = self.curAllIsMeetBossIsSurviveDic[#self.pageDataList - i]
            if dic ~= nil then
                for i, v in pairs(dic) do
                    if v >= 1 then
                        return index
                    end
                end
                index = index + 1
            end
        end
    end
    return index
end

---是否满足页签选择限制条件
function UIBossPanel_BaseViewTemplate:IsMeetTabcondition(SelectconditionList)
    if SelectconditionList == nil then
        return false
    end
    local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(SelectconditionList)
    return isMeet
end

---刷新视图
function UIBossPanel_BaseViewTemplate:RefreshView()
    self:RefreshOtherView(self.curSelectPageInfo)
    self:RefreshGrid(self.curSelectPageInfo ~= nil and self.curSelectPageInfo.type or nil)
    self:CloseCurrentChoose()
    self:RefreshDefaultView()
end

function UIBossPanel_BaseViewTemplate:RefreshOtherView(pageInfo)
    if pageInfo == nil then
        return
    end
    self.lastSelectPageId = self.curSelectPageId
    self.curSelectPageId = pageInfo.type
    ---@type boolean 当前选择的页签是否变化
    self.selectPageChange = self.lastSelectPageId ~= self.curSelectPageId
end

---刷新boss列表
function UIBossPanel_BaseViewTemplate:RefreshGrid(type)
    ---存储怪物id对应的模板，由于模板是循环利用的，所以必须在该物体已经在视野内才能获取到正确的数据
    self.mMonsterIdToTemplate = {}
    self.curList = self:GetSortedBossListInfo(type)
    if self.selectPageChange then
        self.scrollView:ResetPosition()
    end
    if self.mInitialized then
        self.loopScrollViewPlus:RefreshCurrentPage()
    else
        self.mInitialized = true
        self.loopScrollViewPlus:Init(function(go, line)
            return self:RefreshTemplate(go, line)
        end)
    end
    if self.curList ~= nil and self.arrowPanel ~= nil and not CS.StaticUtility.IsNull(self.arrowPanel.gameObject) then
        self.arrowPanel:InitMaxCount(#self.curList)
    end
    self.scrollView:SetSoftnessValue(true, 3)
    self:JumpToCanEnterDup()
end

---刷新boss单元模板
function UIBossPanel_BaseViewTemplate:RefreshTemplate(go, line)
    if self.curList == nil or go == nil or #self.curList < line + 1 then
        return false
    end
    local info = self:ParseBossTemplateInfo(self.curList[line + 1])
    if info == nil then
        return false
    end
    local temp
    if self:GetAllBossUnitTemplateDic()[go] == nil then
        temp = templatemanager.GetNewTemplate(go, self.unitTemplate)
        self:GetAllBossUnitTemplateDic()[go] = temp
    else
        temp = self:GetAllBossUnitTemplateDic()[go]
    end
    temp:RefreshUI(info, self.shaderClip, { line = line })
    local monsterId = self.curList[line + 1].monsterId
    if monsterId then
        self.mMonsterIdToTemplate[monsterId] = temp
    end
    return true
end

---处理发送模板数据
function UIBossPanel_BaseViewTemplate:ParseBossTemplateInfo(bossInfo)
    return bossInfo.allInfo
end

---默认刷新
function UIBossPanel_BaseViewTemplate:DefaultRefresh()

end

--endregion

--region 函数监听

---请求boss列表信息响应
---@param targetMonsterId number 目标id
function UIBossPanel_BaseViewTemplate:OnResBossInfoMessageCallBack(data, targetMonsterId)
    self:ResetData(data)
    self:ParsData(data)
    self:ShowLeftPage()
    self:RefreshView()
    self:SetDefaultSelect()
    self:DefaultRefresh()
end
--endregion

--region otherFunction

function UIBossPanel_BaseViewTemplate:ResetData()
    self.curList = nil
    self.targetPageType = nil
    self.mInitialized = false
    self.curAllBossDic = {}
    self.curAllBossStateDic = {}
    self.curBossPageStateDic = {}
    self.curAllSortedBossDic = {}
    self.curAllBossSurviveNumDic = {}
    self.curAllBossSurviveTotalCountDic = {}
    ---数据未到之前 关闭左侧页签
    if self:IsShowLeftPageView() and self:GetLeftPageTemplate() ~= nil then
        self:GetLeftPageTemplate().go:SetActive(false)
    end
    --self:RefreshView()
end

---获取排序之后的boss列表
function UIBossPanel_BaseViewTemplate:GetSortedBossListInfo(type)
    if type == nil then
        return
    end
    if self.curAllSortedBossDic[type] == nil then
        local list = self.curAllBossDic[type]
        if list == nil then
            return nil
        end
        local info = {}
        for i, v in pairs(list) do
            local IsMeet = 0
            if self.curAllIsMeetBossStateDic[type] ~= nil then
                for j, allInfo in pairs(v) do
                    if self.curAllIsMeetBossStateDic[type][allInfo.bossId] then
                        IsMeet = 1
                    end
                end
            end
            local IsSurvive = 0
            if self.curAllIsMeetBossIsSurviveDic[type] ~= nil then
                if self.curAllIsMeetBossIsSurviveDic[type][i] ~= 0 then
                    IsSurvive = 1
                end
            end
            local data = { bossId = v[1].bossId, monsterId = i, allInfo = v, isMeet = IsMeet, isSurvive = IsSurvive }
            table.insert(info, data)
        end
        if #info > 0 then
            table.sort(info, function(a, b)
                return self:SortBoss(a, b)
            end)
            self.curAllSortedBossDic[type] = info
        end
    end
    return self.curAllSortedBossDic[type]
end

---boss列表排序
function UIBossPanel_BaseViewTemplate:SortBoss(a, b)
    local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
    if a.isMeet ~= b.isMeet then
        return a.isMeet > b.isMeet
    end
    if a.isSurvive ~= b.isSurvive then
        return a.isSurvive > b.isSurvive
    end
    local aOrder = 0
    local bOrder = 0
    if a and b and a.bossId and b.bossId then
        local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(a.bossId)
        if bossInfo then
            aOrder = bossInfo:GetOrder()
            aOrder = aOrder == nil and 0 or aOrder
        end
        bossInfo = clientTableManager.cfg_bossManager:TryGetValue(b.bossId)
        if bossInfo then
            bOrder = bossInfo:GetOrder()
            bOrder = bOrder == nil and 0 or bOrder
        end
    end
    return aOrder < bOrder
end

---是否显示左侧页签
---@protected
function UIBossPanel_BaseViewTemplate:IsShowLeftPageView()
    return false
end

---是否需要跳转到最高可进入
function UIBossPanel_BaseViewTemplate:IsNeedJumpToCanEnterLine()
    return false
end

---解析数据
---@return boolean 是否解析成功
function UIBossPanel_BaseViewTemplate:ParsData(data)
    ---处理服务器boss数据

    if data == nil or data.boss == nil or data.type ~= self.mBossType then
        return
    end
    if self:GetBossPage() == nil then
        return
    end
    local subType
    local curAllBossDicValue
    local curAllBossDicConfigid
    local curAllBossStateDicValue
    local curAllBossStateDicValueConfigid
    local curAllBossSurviveNumDicValue
    local curAllBossSurviveTotalCountDicValue
    local curAllIsMeetBossStateDicValue
    local curAllIsMeetBossIsSurviveDicValue
    local curAllIsMeetBossIsSurviveDicValueConfigid
    local IsMeetBossCondition
    for i = 1, #data.boss do
        local info = data.boss[i]
        if info.bossId ~= nil then
            local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(info.bossId)
            if bossInfo then
                subType = bossInfo:GetSubType()
                curAllBossDicValue = self.curAllBossDic[subType]
                if curAllBossDicValue == nil then
                    curAllBossDicValue = {}
                    self.curAllBossDic[subType] = curAllBossDicValue
                end
                curAllBossDicConfigid = curAllBossDicValue[info.configId]
                if curAllBossDicConfigid == nil then
                    curAllBossDicConfigid = {}
                    curAllBossDicValue[info.configId] = curAllBossDicConfigid
                end
                curAllBossStateDicValue = self.curAllBossStateDic[subType]
                if curAllBossStateDicValue== nil then
                    curAllBossStateDicValue = {}
                    self.curAllBossStateDic[subType] = curAllBossStateDicValue
                end
                IsMeetBossCondition = Utility.IsMeetBossCondition(bossInfo)
                if IsMeetBossCondition then
                    curAllBossStateDicValueConfigid = curAllBossStateDicValue[info.configId]
                    if curAllBossStateDicValueConfigid == nil then
                        curAllBossStateDicValue[info.configId] = info.count
                        curAllBossStateDicValueConfigid = info.count
                    else
                        curAllBossStateDicValue[info.configId] = curAllBossStateDicValueConfigid + info.count
                        curAllBossStateDicValueConfigid = curAllBossStateDicValueConfigid + info.count
                    end
                end
                curAllBossSurviveNumDicValue = self.curAllBossSurviveNumDic[subType]
                --region 每个页签的存活总数量
                if curAllBossSurviveNumDicValue == nil then
                    self.curAllBossSurviveNumDic[subType] = info.count
                    curAllBossSurviveNumDicValue = info.count
                else
                    self.curAllBossSurviveNumDic[subType] = curAllBossSurviveNumDicValue + info.count
                    curAllBossSurviveNumDicValue = curAllBossSurviveNumDicValue + info.count
                end
                --endregion

                --region 页签的总数量
                if info.totalCount ~= nil then
                    curAllBossSurviveTotalCountDicValue = self.curAllBossSurviveTotalCountDic[subType]
                    if curAllBossSurviveTotalCountDicValue == nil then
                        self.curAllBossSurviveTotalCountDic[subType] = info.totalCount
                        curAllBossSurviveTotalCountDicValue = info.totalCount
                    else
                        self.curAllBossSurviveTotalCountDic[subType] = curAllBossSurviveTotalCountDicValue+ info.totalCount
                        curAllBossSurviveTotalCountDicValue= curAllBossSurviveTotalCountDicValue+ info.totalCount
                    end
                end
                --endregion
                curAllIsMeetBossStateDicValue = self.curAllIsMeetBossStateDic[subType]
                if curAllIsMeetBossStateDicValue == nil then
                    curAllIsMeetBossStateDicValue = {}
                    self.curAllIsMeetBossStateDic[subType] = curAllIsMeetBossStateDicValue
                end
                curAllIsMeetBossStateDicValue[info.bossId] = IsMeetBossCondition

                curAllIsMeetBossIsSurviveDicValue = self.curAllIsMeetBossIsSurviveDic[subType]
                if curAllIsMeetBossIsSurviveDicValue == nil then
                    curAllIsMeetBossIsSurviveDicValue = {}
                    self.curAllIsMeetBossIsSurviveDic[subType] = curAllIsMeetBossIsSurviveDicValue
                end
                curAllIsMeetBossIsSurviveDicValueConfigid = curAllIsMeetBossIsSurviveDicValue[info.configId]
                if curAllIsMeetBossIsSurviveDicValueConfigid == nil then
                    if curAllIsMeetBossStateDicValue[info.bossId] then
                        curAllIsMeetBossIsSurviveDicValue[info.configId] = info.count
                        curAllIsMeetBossIsSurviveDicValueConfigid = info.count
                    else
                        curAllIsMeetBossIsSurviveDicValue[info.configId]= 0
                        curAllIsMeetBossIsSurviveDicValueConfigid = 0
                    end
                else
                    if curAllIsMeetBossStateDicValue[info.bossId] then
                        curAllIsMeetBossIsSurviveDicValue[info.configId] = curAllIsMeetBossIsSurviveDicValueConfigid+ info.count
                        curAllIsMeetBossIsSurviveDicValueConfigid = curAllIsMeetBossIsSurviveDicValueConfigid+ info.count
                    end
                end

                table.insert(curAllBossDicConfigid, info)
            end
        end
    end
    for k1, v in pairs(self.curAllBossStateDic) do
        self.curBossPageStateDic[k1] = self:GetBossPageState(data.type, k1, v)
    end
    return
end

---获取boss页签状态
---@param bossType LuaEnumBossType boss大类
---@param bossSubType number boss子类型
---@param bossList table<number,number> key:monsterId value:count
---@return boolean 显示状态
function UIBossPanel_BaseViewTemplate:GetBossPageState(bossType, bossSubType, bossList)
    local pageGrayLogicType = LuaGlobalTableDeal.GetBossPageGrayLogicType(bossType, bossSubType)
    if pageGrayLogicType ~= nil then
        if pageGrayLogicType == LuaEnumBossPanelSubtypePageGrayLogicType.Normal then
            for k, v in pairs(bossList) do
                if v > 0 then
                    return false
                end
            end
            return true
        elseif pageGrayLogicType == LuaEnumBossPanelSubtypePageGrayLogicType.ByGrayConditionList then
            return not LuaGlobalTableDeal.CheckBossGrayConditionList(bossType, bossSubType)
        end
    end
    return false
end

---是否显示此页签
---@protected
---@return boolean
function UIBossPanel_BaseViewTemplate:IsShowPage(pageData)
    local isMeetCondition = true
    if pageData.conditionList ~= nil and #pageData.conditionList > 0 then
        for i = 1, #pageData.conditionList do
            local conditionid = tonumber(pageData.conditionList[i])
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionid) then
                isMeetCondition = false
            end
        end
    end
    --if not isMeetCondition then
    --    if self:GetBossMeetStateOfPageType(pageData.type) then
    --        return false
    --    end
    --end
    return isMeetCondition
end

---判断页签下的boss的限制状态
---@return boolean 是否被限制
function UIBossPanel_BaseViewTemplate:GetBossMeetStateOfPageType(type)
    if self.curAllIsMeetBossStateDic[type] ~= nil then
        for k, v in pairs(self.curAllIsMeetBossStateDic[type]) do
            if v then
                return false
            end
        end
        return true
    end
    return false
end

---boss副页签是否显示boss击杀进度
---@return boolean
function UIBossPanel_BaseViewTemplate:BookMarkIsShowBossFill()
    return false
end

--endregion

--region update
---启动刷新
function UIBossPanel_BaseViewTemplate:RefreshUpdate(action)
    self:RemoveUpdate()
    if action == nil then
        return
    end
    self.initListUpdate = CS.CSListUpdateMgr.Add(200, nil, action, true)
end

function UIBossPanel_BaseViewTemplate:RemoveUpdate()
    if self.initListUpdate ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.initListUpdate)
        self.initListUpdate = nil
    end
end
--endregion

--region OnDisable
function UIBossPanel_BaseViewTemplate:OnDisable()
    self:RemoveUpdate()
end
--endregion

--region onDestroy
function UIBossPanel_BaseViewTemplate:onDestroy()
    self:RemoveUpdate()
end
--endregion

--region跳转到最高可进入位置，如果有需要选中的怪物，则此功能不生效
function UIBossPanel_BaseViewTemplate:JumpToCanEnterDup()
    if self:IsNeedJumpToCanEnterLine() == false then
        return
    end
    if self.curList == nil then
        return
    end
    local line = 1
    for p = 1, #self.curList do
        local listInfo = self.curList[p]
        local data = self:ParseBossTemplateInfo(listInfo)
        if data then
            for i, v in pairs(data) do
                local bossInfo = clientTableManager.cfg_bossManager:TryGetValue(v.bossId)
                local mainPlayerCanMeet = self:IsMeetCondition(bossInfo)
                local bossNum = v.count
                if bossNum > 0 and mainPlayerCanMeet == true then
                    line = p
                end
            end
        end
    end
    self:SetSuitJump(3 - line)
end

---是否满足条件
function UIBossPanel_BaseViewTemplate:IsMeetCondition(bossTable)
    if bossTable == nil then
        return false
    end
    local isMeet = true
    if bossTable:GetLevel() ~= nil then
        for i = 0, bossTable:GetLevel().list.Count - 1 do
            local conditionID = bossTable:GetLevel().list[i]
            local luaConditionResult = Utility.IsMainPlayerMatchCondition(conditionID)
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false or (luaConditionResult ~= nil and luaConditionResult.success == false) then
                isMeet = false
                break
            end
        end
    end
    return isMeet
end
--endregion

--region 设置跳转
---跳转并选中怪物
function UIBossPanel_BaseViewTemplate:ChooseItem(MonsterId)
    if self.curList then
        for i = 1, #self.curList do
            local listInfo = self.curList[i]
            if listInfo and listInfo.monsterId == MonsterId then
                local index = i
                local jumpLine = 2 - index
                self:SetSuitJump(jumpLine)
                if self.mMonsterIdToTemplate then
                    local template = self.mMonsterIdToTemplate[MonsterId]
                    if template and template.ChooseItem then
                        template:ChooseItem(true)
                        self.mCurrentChooseTemplate = template
                    end
                end
            end
        end
    end
end

---设置适配跳转，保证页面始终在视野内
function UIBossPanel_BaseViewTemplate:SetSuitJump(jumpLine)

    if self.curList == nil then
        return
    end
    if jumpLine <= 3 - #self.curList then
        jumpLine = 3 - #self.curList
    end
    if jumpLine >= 0 then
        jumpLine = 0
    end
    self.loopScrollViewPlus:JumpToLine(jumpLine)
end

---跳转并选中第一个怪物
function UIBossPanel_BaseViewTemplate:ChooseFirstItem()
    if CS.StaticUtility.IsNull(self.loopScrollViewPlus) == false then
        self.loopScrollViewPlus:JumpToLine(0)
    end
end

---关闭当前选中
function UIBossPanel_BaseViewTemplate:CloseCurrentChoose()
    if self.mCurrentChooseTemplate and self.mCurrentChooseTemplate.ChooseItem and self.selectPageChange then
        self.mCurrentChooseTemplate:ChooseItem(false)
    end
end

---刷新默认视图
function UIBossPanel_BaseViewTemplate:RefreshDefaultView()

end
--endregion

--region 红点
---注册红点
---@param pageIndex number 页签下标
---@return LuaRedPointName 红点枚举
function UIBossPanel_BaseViewTemplate:GetRegisterRedPointEnum(pageIndex)
    if self.mBossType == nil or pageIndex == nil then
        return
    end
    --if self.mBossType == LuaEnumBossType.FinalBoss then
    --    if pageIndex == LuaEnumFinalBossType.AncientBoss then
    --        return Utility.EnumToInt(CS.RedPointKey.BOSS_ANCIENT)
    --    elseif pageIndex == LuaEnumFinalBossType.MythBoss then
    --        --return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_God)
    --    end
    --end
end
--endregion

--region 页签数据请求
---请求页签服boss列表数据
---@param type LuaEnumBossType 主页签类型id
---@param subType number 子页签类型id
function UIBossPanel_BaseViewTemplate:ReqPageBossListInfo(type, subType)
    if type == nil then
        return
    end
    networkRequest.ReqFieldBossOpen(type, subType)
end
--endregion

--region 扫荡
---刷新boss列表扫荡
function UIBossPanel_BaseViewTemplate:RefreshBossListClear()
    if type(self.mMonsterIdToTemplate) == 'table' then
        for k, v in pairs(self.mMonsterIdToTemplate) do
            ---@type UIChallengeBossBaseTemplates
            local temp = v
            temp:RefreshClearBtn()
        end
    end
end
--endregion
return UIBossPanel_BaseViewTemplate
