---@class UIGangEscortPanel:UIBase
local UIGangEscortPanel = {}

setmetatable(UIGangEscortPanel, luaPanelModules.UIActivityDuplicatePanel)

---用于显示活动奖励内容（策划要求只显示第一个）
UIGangEscortPanel.ActivityAwardDicIndex = {1}

function UIGangEscortPanel:GetBtnHelp_GameObject()
    if(self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/event/btn_help","GameObject")
    end
    return self.mBtnHelp_GameObject;
end


function UIGangEscortPanel:GetAwards_UIGridContainer()
    if self.mAwards_UIGridContainer == nil then
        self.mAwards_UIGridContainer = self:GetCurComp("WidgetRoot/introduce/labelGroup/title/Awards", "UIGridContainer")
    end
    return self.mAwards_UIGridContainer
end

function UIGangEscortPanel:GetCarState_UIGridContainer()
    if self.mCarState_UIGridContainer == nil then
        self.mCarState_UIGridContainer = self:GetCurComp("WidgetRoot/event", "UIGridContainer")
    end
    return self.mCarState_UIGridContainer
end

function UIGangEscortPanel:GetTimeDes_UILabel()
    if self.mTimeDes_UILabel == nil then
        self.mTimeDes_UILabel = self:GetCurComp("WidgetRoot/introduce/labelGroup/timeDes", "UILabel")
    end
    return self.mTimeDes_UILabel
end


--region 初始化
function UIGangEscortPanel:Init()
    self:InitComponents()
    self:InitOther()
    self:BindNetMsg()
end

function UIGangEscortPanel:BindBlock()
end

function UIGangEscortPanel:Show(activityId, descriptionId, helpId)
    if activityId == nil or descriptionId == nil then
        return
    end
    if(helpId ~= nil) then
        self.mHelpId = helpId;
    end
    if not self:AnalysisData(activityId, descriptionId) then
        return
    end
    self:RefreshActivityContent()
    self:ReqParams()
end

---解析数据
function UIGangEscortPanel:AnalysisData(activityId, descriptionId)
    local activityInfoIsFind,activityInfo = CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(activityId)
    if activityInfoIsFind then
        self.activityInfo = activityInfo
    end
    local descriptionInfoIsFind,descriptionInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(descriptionId)
    if descriptionInfoIsFind then
        self.descriptionInfo = descriptionInfo
    end
    return activityInfoIsFind and descriptionInfoIsFind
end

---刷新面板
function UIGangEscortPanel:RefreshActivityContent()
    self:RefreshTitle()
    self:RefreshDescription()
    self:RefreshTime()
    self:RefreshActivityAward()
    self:RefreshNoCarState()
end

function UIGangEscortPanel:ReqParams()
    networkRequest.ReqBodyGuardInfo()
end

function UIGangEscortPanel:BindNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBodyGuardInfoMessage, UIGangEscortPanel.OnResBodyGuardInfoMessageReceived)
end
--endregion

--region 网络消息接收
---返回镖师面板
function UIGangEscortPanel.OnResBodyGuardInfoMessageReceived(msgID, tblData, csData)
    UIGangEscortPanel:RefreshCarState(tblData)
end
--endregion

--region 刷新
---刷新活动名称
function UIGangEscortPanel:RefreshTitle()
    if self.mTitleName_UILabel ~= nil and not CS.StaticUtility.IsNull(self.mTitleName_UILabel) then
        self.mTitleName_UILabel.text = self.activityInfo.name
    end
end

---刷新活动描述内容
function UIGangEscortPanel:RefreshDescription()
    if self.mIntroduce_UILabel ~= nil and not CS.StaticUtility.IsNull(self.mIntroduce_UILabel) then
        self.mIntroduce_UILabel.text = string.format(string.gsub(self.descriptionInfo.value, "\\n", '\n'))
    end
end

---刷新活动时间
function UIGangEscortPanel:RefreshTime()
    if self:GetTimeDes_UILabel() ~= nil and not CS.StaticUtility.IsNull(self:GetTimeDes_UILabel()) then
        local startTimeHour = math.floor(self.activityInfo.startTime / 60)
        local startTimeMinutes = math.floor(self.activityInfo.startTime % 60)
        local endTimeHour = math.floor(self.activityInfo.overTime / 60)
        local endTimeMinutes = math.floor(self.activityInfo.overTime % 60)
        local time = string.format("%02s:%02s - %02s:%02s", startTimeHour, startTimeMinutes, endTimeHour, endTimeMinutes)
        self:GetTimeDes_UILabel().text = time
    end
end

---刷新活动奖励
function UIGangEscortPanel:RefreshActivityAward()
    self.awardTable = self:GetAwardTableByFilterAwardDic()
    self:GetAwards_UIGridContainer().MaxCount = #self.awardTable
    for k = 0,self:GetAwards_UIGridContainer().MaxCount - 1 do
        local template = templatemanager.GetNewTemplate(self:GetAwards_UIGridContainer().controlList[k], luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
        local award = self.awardTable[k+1]
        template:RefreshUI(award.itemId,award.num)
    end
end

---刷新镖车状态（活动未开启时）
function UIGangEscortPanel:RefreshNoCarState()
    if self:GetCarState_UIGridContainer() ~= nil then
        self:GetCarState_UIGridContainer().MaxCount = 1
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[0], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        template:Refresh({titleName = "当前镖车状态",content = CS.Cfg_GlobalTableManager.Instance:GetNoCarStateText()})
    end
    self.carState = false
end

---刷新镖车状态（活动开启时）
function UIGangEscortPanel:RefreshCarState(tblData)
    if self:GetCarState_UIGridContainer() ~= nil then
        self:GetCarState_UIGridContainer().MaxCount = 2
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[0], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        local carStateText = CS.Cfg_GlobalTableManager.Instance:GetCarStateTextByCarState(tblData.cartState)
        template:Refresh({titleName = "当前镖车状态",content = carStateText})
        local template = templatemanager.GetNewTemplate(self:GetCarState_UIGridContainer().controlList[1], luaComponentTemplates.UIActivityDuplicateTitleTeamplate)
        local positionContent = tblData.mapName ..tostring(tblData.x) .. "," .. tostring(tblData.y)
        template:Refresh({titleName = "当前镖车位置",content = positionContent})
    end
    self.carState = true
end
--endregion


--region 监听
---关闭按钮
function UIGangEscortPanel:OnClickCloseBtn()
    uimanager:ClosePanel(self)
end

---进入活动按钮
function UIGangEscortPanel:OnClickEnterBtn(go)
    if self.carState == false then
        Utility.ShowPopoTips(go,nil,133)
        return
    elseif Utility.ReqJoinUnionDartCarActivity(go) == true then
        uimanager:ClosePanel(self)
    end
end
--endregion

--region 获取数据
---通过筛选奖励字典获取奖励表
function UIGangEscortPanel:GetAwardTableByFilterAwardDic()
    local awardTable = {}
    local awardStr = self.activityInfo.rewardShow
    if awardStr ~= "" then
        local allAwardstrTable = string.Split(awardStr,'&')
        for k,v in pairs(allAwardstrTable) do
            local curAwardTable = string.Split(v,'#')
            if #curAwardTable >= 2 then
                table.insert(awardTable,{itemId = curAwardTable[1],num = curAwardTable[2]})
            end
        end
    end
    return awardTable
end
--endregion

--region 查询
function UIGangEscortPanel:TableContain(table,element)
    for k,v in pairs(table) do
        if v == element then
            return true
        end
    end
    return false
end
--endregion

return UIGangEscortPanel