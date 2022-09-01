local UISanctuaryPanel = {}
setmetatable(UISanctuaryPanel, luaPanelModules.UIActivityDuplicatePanel)

---列表打开状态
UISanctuaryPanel.listIsOpen = false

function UISanctuaryPanel:GetEventcostTwo_UILabel()
    if self.mEventcostTwo_UILabel == nil then
        self.mEventcostTwo_UILabel = self:GetCurComp("WidgetRoot/eventcostTwo", "UILabel")
    end
    return self.mEventcostTwo_UILabel
end

function UISanctuaryPanel:GetEventcostTwoBtn_Add_GameObject()
    if self.mEventcostTwoBtn_Add_GameObject == nil then
        self.mEventcostTwoBtn_Add_GameObject = self:GetCurComp("WidgetRoot/eventcostTwo/btn_add", "GameObject")
    end
    return self.mEventcostTwoBtn_Add_GameObject
end

function UISanctuaryPanel:GetEventcost_GameObject()
    if self.mEventcost_GameObject == nil then
        self.mEventcost_GameObject = self:GetCurComp("WidgetRoot/eventcost", "GameObject")
    end
    return self.mEventcost_GameObject
end

function UISanctuaryPanel:GetEventcostIcon_UISprite()
    if self.mEventcostIcon_UISprite == nil then
        self.mEventcostIcon_UISprite = self:GetCurComp("WidgetRoot/eventcost/icon", "UISprite")
    end
    return self.mEventcostIcon_UISprite
end

function UISanctuaryPanel:GetEventcostBtn_add_GameObject()
    if self.mEventcostBtn_add_GameObject == nil then
        self.mEventcostBtn_add_GameObject = self:GetCurComp("WidgetRoot/eventcost/btn_add", "GameObject")
    end
    return self.mEventcostBtn_add_GameObject
end

function UISanctuaryPanel:GetDuplicateList_GameObject()
    if self.mDuplicateList_GameObject == nil then
        self.mDuplicateList_GameObject = self:GetCurComp("WidgetRoot/eventcostTwo", "GameObject")
    end
    return self.mDuplicateList_GameObject
end

function UISanctuaryPanel:GetLocation_GameObject()
    if self.mLocation_GameObject == nil then
        self.mLocation_GameObject = self:GetCurComp("WidgetRoot/eventcostTwo/Location", "GameObject")
    end
    return self.mLocation_GameObject
end

function UISanctuaryPanel:GetDuplicateList_UIScrollView()
    if self.mDuplicateList_UIScrollView == nil then
        self.mDuplicateList_UIScrollView = self:GetCurComp("WidgetRoot/eventcostTwo/Location/LocationList", "UIScrollView")
    end
    return self.mDuplicateList_UIScrollView
end

function UISanctuaryPanel:AddParams(duplicateId, descriptionId)
    --副本
    self.mDuplicateId = duplicateId
    self.needLevel = 0
    local isFind, item = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateId)
    if isFind then
        self.mDuplicate = item
        --活动奖励
        local data = CS.Cfg_DuplicateTableManager.Instance:GetRewardItemIds(item);
        self.mAwardList_UIGrid.MaxCount = data.Count
        for i = 0, self.mAwardList_UIGrid.controlList.Count - 1 do
            local template = templatemanager.GetNewTemplate(self.mAwardList_UIGrid.controlList[i], luaComponentTemplates.UIActivityDuplicateRewardItemTemplate)
            template:RefreshUI(data[i], nil)
        end
        --每日活动
        self.mDailyActivityTimeId = item.openTime

        ---文本描述
        isFind, item = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(descriptionId)
        if isFind then
            self.mIntroduce_UILabel.text = string.gsub(item.value, '\\n', '\n')
        end
        --self:ShowConditionContent()
        self:InitUseNum()
        self:BindEvents()
    end
end

function UISanctuaryPanel:InitUseNum()
    local duplicateInfoIsFind, duplicateInfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(self.mDuplicateId)
    if self.mDuplicate.attackTimes ~= nil and self.mDuplicate.attackTimes.list ~= nil and duplicateInfoIsFind then
        local callBack = nil
        local goldInfo = CS.Cfg_GlobalTableManager.Instance:GetShengyuGoldInfo()
        local goldItemid = 0
        local singlePrice = 0
        local material = nil

        if duplicateInfo.requireItems ~= nil and duplicateInfo.requireItems.list ~= nil and duplicateInfo.requireItems.list[0].list.Count >= 2 then
            material = duplicateInfo.requireItems.list[0].list
        end
        --region 需要材料设置
        if material ~= nil then
            local materialItemInfoIsFind, materialItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(material[0])
            if materialItemInfoIsFind then
                self.materialItemInfo = materialItemInfo
                self.itemId = material[0]
                local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(material[0])
                local materIsEnough = ternary(bagItemCount > 0, true, false)
                local color = Utility.GetBBCode(materIsEnough)
                --self:GetEventcostBtn_add_GameObject():SetActive(not materIsEnough)
                self:GetEventcostIcon_UISprite().spriteName = materialItemInfo.icon
                self.eventcost.text = color .. tostring(bagItemCount) .. "[878787]可击杀" .. tostring(bagItemCount) .. "只BOSS"
            end
        end

        CS.UIEventListener.Get(self:GetEventcostBtn_add_GameObject()).onClick = function()
            Utility.ShowItemGetWay(self.materialItemInfo.id, self:GetEventcostBtn_add_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
        end

        CS.UIEventListener.Get(self:GetEventcostIcon_UISprite().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.materialItemInfo })
        end
        --endregion

        --region 设置可去层数列表
        self.duplicateList = CS.CSScene.MainPlayerInfo.SanctuaryInfo:GetDuplicateList()
        self.sanctuaryPanelListTemplate = templatemanager.GetNewTemplate(self:GetDuplicateList_GameObject(), luaComponentTemplates.UISanctuaryPanel_DuplicateList)
        self.sanctuaryPanelListTemplate:Refresh({ duplicateInfoList = self.duplicateList, UISanctuaryPanel = self })
        --endregion
    end
end

function UISanctuaryPanel:BindEvents()
    CS.UIEventListener.Get(self:GetEventcostTwoBtn_Add_GameObject()).onClick = function()
        self:ChangeDuplicateListState()
    end
end

function UISanctuaryPanel:ChangeDuplicateListState()
    if self.duplicateList.Count > 0 then
        self.listIsOpen = not self.listIsOpen
        self:GetLocation_GameObject():SetActive(self.listIsOpen)
        if self.listIsOpen == false and self:GetDuplicateList_UIScrollView() ~= nil then
            self:GetDuplicateList_UIScrollView():ResetPosition()
        end
    end
end

function UISanctuaryPanel:OnClickEnterBtn(go)

    if self.sanctuaryPanelListTemplate.curDuplicateInfo ~= nil then
        ---判断等级
        local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.sanctuaryPanelListTemplate.curDuplicateInfo.condition)
        if not isMeet then
            Utility.ShowPopoTips(go.transform, nil, 73)
            return
        end
    end

    if self.sanctuaryPanelListTemplate.curDuplicateInfo ~= nil and CS.CSScene.MainPlayerInfo.SanctuaryInfo:CheckSanctuaryIsCanEnter(self.sanctuaryPanelListTemplate.curDuplicateInfo.id) == false then
        Utility.ShowPopoTips(go, nil, 58)
        return
    end
    if CS.CSScene.MainPlayerInfo.PrefixId == 0 then
        Utility.ShowPopoTips(go.transform, nil, 71)
        return
    end
    if self:CheckIsGroup() then
        self:ShowTips()
        return
    end
    if self.sanctuaryPanelListTemplate == nil or self.sanctuaryPanelListTemplate.curDuplicateInfo == nil then
        return
    end
    Utility.ReqEnterDuplicate(self.sanctuaryPanelListTemplate.curDuplicateInfo.id)
    uimanager:ClosePanel('UIActivityDuplicatePanel')
    uimanager:ClosePanel("UIMonsterHeadPanel")
    uimanager:ClosePanel("UISanctuaryPanel")
end

--region otherFunc

---是否组队
function UISanctuaryPanel:CheckIsGroup()
    if CS.CSScene.MainPlayerInfo ~= nil then
        local groupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2
        return groupInfo.IsHaveGroup
    end
    return false
end

---显示提示框
function UISanctuaryPanel:ShowTips()
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(48)
    if isFind then
        local temp = {}
        temp.Content = info.des
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 48
        temp.CallBack = function()
            Utility.ReqEnterDuplicate(self.sanctuaryPanelListTemplate.curDuplicateInfo.id)
            uimanager:ClosePanel('UIActivityDuplicatePanel')
            uimanager:ClosePanel("UIMonsterHeadPanel")
            uimanager:ClosePanel("UISanctuaryPanel")
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

function UISanctuaryPanel:RefreshItemCount()
    local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.itemId)
    local materIsEnough = ternary(bagItemCount > 0, true, false)
    local color = Utility.GetBBCode(materIsEnough)
    --self:GetEventcostBtn_add_GameObject():SetActive(not materIsEnough)
    self.eventcost.text = color .. tostring(bagItemCount) .. "[878787]可击杀" .. tostring(bagItemCount) .. "只BOSS"
end
--endregion

--region 对外功能
---修改剩余次数
function UISanctuaryPanel:ChangeRemainKillNum(killnum)
    self:GetEventcostTwo_UILabel().text = tostring(killnum)
end
--endregion

function ondestroy()
    commonNetMsgDeal.ClearCallback(LuaEnumNetDef.ResBagChangeMessage)
end
return UISanctuaryPanel