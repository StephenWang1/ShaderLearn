---@class UITreasureUsePanel
local UITreasureUsePanel = {}

function UITreasureUsePanel:InitComponents()
    ---塔罗神庙点击按钮
    self.Btn1 = self:GetCurComp("WidgetRoot/events/Btn1", "GameObject")
    ---塔罗牌点击按钮
    self.Btn2 = self:GetCurComp("WidgetRoot/events/Btn2", "GameObject")
    ---关闭按钮
    self.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    ---塔罗牌限制文本
    self.taluopaiLimit = self:GetCurComp("WidgetRoot/view/taluopaiLimit", "GameObject")
end

function UITreasureUsePanel:InitOther()
    CS.UIEventListener.Get(self.Btn1.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn1.gameObject).OnClickLuaDelegate = self.onClickBtn1

    CS.UIEventListener.Get(self.Btn2.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn2.gameObject).OnClickLuaDelegate = self.onClickBtn2

    CS.UIEventListener.Get(self.CloseBtn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.CloseBtn.gameObject).OnClickLuaDelegate = self.onClickCloseBtn

    self.isOpenTaLuoPai = self:IsOpenTaLuoPai()
    self.taluopaiLimit.gameObject:SetActive(not self.isOpenTaLuoPai)
end

---是否开启塔罗牌
function UITreasureUsePanel:IsOpenTaLuoPai()
    if self.notice == nil then
        self.notice = clientTableManager.cfg_noticeManager:TryGetValue(27)
    end
    if self.notice == nil then
        return false
    end
    local conditionS = self.notice:GetOpenCondition()
    if conditionS == nil or conditionS.list == nil then
        return true
    end
    print(conditionS.list.Count)
    for i = 0, conditionS.list.Count-1 do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionS.list[i]) then
            return false
        end
    end
    return true
end

---初始化数据
function UITreasureUsePanel:Init()
    self:InitComponents()
    self:InitOther()
end

---塔罗神庙点击按钮
function UITreasureUsePanel:onClickBtn1()
    local cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
    if cardInfo == nil or cardInfo.cardType == LuaEnumCoceralCardType.None then
        --寻路到最近塔罗先生
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 1019, 1020 }, "UIMrTarotPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, nil)
    else
        uimanager:CreatePanel("UIMrTarotPanel")
    end
    uimanager:ClosePanel("UITreasureUsePanel")
end
---塔罗牌点击按钮
function UITreasureUsePanel:onClickBtn2(go)
    if self.isOpenTaLuoPai then
        uimanager:CreatePanel("UITreasurePanel")
    else
        CS.Utility.ShowTips("未满足开启条件", 1.5, CS.ColorType.Red)
    end
end
---关闭按钮
function UITreasureUsePanel:onClickCloseBtn()
    uimanager:ClosePanel("UITreasureUsePanel")
end

return UITreasureUsePanel