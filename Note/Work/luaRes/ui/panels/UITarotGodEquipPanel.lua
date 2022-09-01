---@class UITarotGodEquipPanel:UIBase 限时活动-塔罗牌上新
local UITarotGodEquipPanel = {}

--region 组件
---@return UnityEngine.GameObject 前往获取塔罗牌
function UITarotGodEquipPanel:GetGoToGetBtn_TarotCard()
    if self.mGoToGetBtn_TarotCard == nil then
        self.mGoToGetBtn_TarotCard = self:GetCurComp("WidgetRoot/events/btn_TarotCard", "GameObject")
    end
    return self.mGoToGetBtn_TarotCard
end

---@return UnityEngine.GameObject 前往获取神级BOSS
function UITarotGodEquipPanel:GetGoToGetBtn_GodBoss()
    if self.mGoToGetBtn_GodBoss == nil then
        self.mGoToGetBtn_GodBoss = self:GetCurComp("WidgetRoot/events/btn_GodBoss", "GameObject")
    end
    return self.mGoToGetBtn_GodBoss
end

---@return UICountdownLabel 倒计时
function UITarotGodEquipPanel:GetTimeCount_UICountdownLabel()
    if self.mTimeCountLabel == nil then
        self.mTimeCountLabel = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    end
    return self.mTimeCountLabel
end

---@return UILabel 倒计时文本
function UITarotGodEquipPanel:GetTimeCount_UILabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetCurComp("WidgetRoot/view/TimeCount", "UILabel")
    end
    return self.mTimeCountLb
end

---@return UnityEngine.Transform 道具
function UITarotGodEquipPanel:GetItem_Transform()
    if self.mItemTrans == nil then
        self.mItemTrans = self:GetCurComp("WidgetRoot/view/Item", "Transform")
    end
    return self.mItemTrans
end
--endregion

--region 初始化
function UITarotGodEquipPanel:Init()
    self:BindEvents()
end

---@param activityData SpecialActivityPanelData
function UITarotGodEquipPanel:Show(activityData)
    if activityData == nil then
        self:ClosePanel()
        return
    end
    self.mActivityData = activityData

    self:RefreshPanelShow()
end

function UITarotGodEquipPanel:BindEvents()
    CS.UIEventListener.Get(self:GetGoToGetBtn_TarotCard()).onClick = function()
        -- local isJoinedCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce() == true
        if CS.CSScene.MainPlayerInfo.Level >= 70 then
            uimanager:CreatePanel("UITreasurePanel")
        else
            Utility.ShowPopoTips(self:GetGoToGetBtn_TarotCard(), "等级不足70级", 349, "UITarotGodEquipPanel")
        end
    end
    CS.UIEventListener.Get(self:GetGoToGetBtn_GodBoss()).onClick = function()
        local customData = { }
        customData.type = LuaEnumBossType.FinalBoss
        customData.subType = 2
        uimanager:CreatePanel("UIBossPanel", nil, customData)
    end
end
--endregion

--region 刷新界面显示
---刷新界面显示
function UITarotGodEquipPanel:RefreshPanelShow()
    --icon
    local tblData = clientTableManager.cfg_special_activityManager:TryGetValue(self.mActivityData.mActivityID)
    if tblData.goal then
        local itemlist = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(tblData.goal.list[1])
        if itemlist.Count == self:GetItem_Transform().childCount then
            for i = 0, self:GetItem_Transform().childCount - 1 do
                local itemGo = self:GetItem_Transform():GetChild(i).gameObject
                local itemId = itemlist[i].itemId
                local res, itemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId);
                if (res) then
                    local uiItem = templatemanager.GetNewTemplate(itemGo, luaComponentTemplates.UIItem)
                    if uiItem then
                        uiItem:RefreshUIWithItemInfo(itemTable)
                        CS.UIEventListener.Get(itemGo).onClick = function()
                            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = uiItem.ItemInfo, showRight = false })
                        end
                    end
                end
            end
        end
    end

    --倒计时
    local finishTime = self.mActivityData.mFinishTime
    if finishTime then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 8, finishTime * 1000, "活动倒计时", nil, nil, function()
            self:GetTimeCount_UILabel().text = "已结束"
        end)
    end
end
--endregion

return UITarotGodEquipPanel