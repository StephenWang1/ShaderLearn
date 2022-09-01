--- DateTime: 2021/03/26 09:20
--- Description 

---@class UIBrmCangYuePanel:UIBase
local UIBrmCangYuePanel = {}

--region parameters

--endregion

--region init
function UIBrmCangYuePanel:Init()
    self.CangYueController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_CangYue()
    self:InitComponents()
    self:BindComponentsEvent()
end

function UIBrmCangYuePanel:InitComponents()
    ---前往苍月岛
    ---@type UnityEngine.GameObject
    UIBrmCangYuePanel.Go_GotoCangyueIsland = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/btn_leaveFor", "GameObject")
    ---关闭面板按钮
    ---@type UnityEngine.GameObject
    UIBrmCangYuePanel.go_CloseBtn = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CloseBtn", "GameObject")
    ---标题
    ---@type Top_UILabel
    UIBrmCangYuePanel.lb_title = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/title2/desc/Label", "Top_UILabel")
    ---限制条件1
    ---@type Top_UILabel
    UIBrmCangYuePanel.lb_condition1 = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/lb_condition1", "UILabel")
    ---限制条件2
    ---@type Top_UILabel
    UIBrmCangYuePanel.lb_condition2 = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/lb_condition2", "UILabel")
    ---奖励展示
    ---@type Top_UIGridContainer
    UIBrmCangYuePanel.grid_Awards = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/title2/Reward/ScrollView/Awards", "Top_UIGridContainer")
    ---帮助按钮
    ---@type UnityEngine.GameObject
    UIBrmCangYuePanel.BtnHelp_GameObject = UIBrmCangYuePanel:GetCurComp("WidgetRoot/view/MainView/CangYue/title2/Reward/btn_help", "GameObject")
end

function UIBrmCangYuePanel:BindComponentsEvent()
    if (self.Go_GotoCangyueIsland) then
        CS.UIEventListener.Get(self.Go_GotoCangyueIsland).onClick = function(go)
            self.CangYueController:TryDeliverCangyueIsland(go.transform)
        end
    end
    if (self.go_CloseBtn) then
        CS.UIEventListener.Get(self.go_CloseBtn).onClick = function(go)
            uimanager:ClosePanel('UIWhiteSunGatePanel')
        end
    end
    if (self.BtnHelp_GameObject ~= nil) then
        CS.UIEventListener.Get(self.BtnHelp_GameObject).onClick = function()
            local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(235)
            if isFind then
                uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
            end
        end
    end
end

--endregion

--region methods
function UIBrmCangYuePanel:Show()
    self:RefreshUI()
    self:RefreshReward()
end

function UIBrmCangYuePanel:RefreshUI()
    if (self.lb_title) then
        self.lb_title.text = self.CangYueController:GetTitle()
    end

    ---条件1
    local conditionIDs, text = self.CangYueController:GetFormConditionInformation(23023)
    local IsItSatisfied = self.CangYueController:CheckWhetherTheConditionsAreMet(conditionIDs)
    if (self.lb_condition1 ~= nil and text ~= nil) then
        self.lb_condition1.text = string.format('%s%s', IsItSatisfied and luaEnumColorType.Green or luaEnumColorType.Red, text)
    end

    ---条件2
    conditionIDs, text = self.CangYueController:GetFormConditionInformation(23024)
    IsItSatisfied = self.CangYueController:CheckWhetherTheConditionsAreMet(conditionIDs)
    if (self.lb_condition2 ~= nil and text ~= nil) then
        self.lb_condition2.text = string.format('%s%s', IsItSatisfied and luaEnumColorType.Green or luaEnumColorType.Red, text)
    end
end

---刷新奖励展示
function UIBrmCangYuePanel:RefreshReward()
    if (self.grid_Awards == nil) then
        return
    end
    ---@type table
    local rewards = self.CangYueController:GetRewardDisplayList()
    if (rewards == nil or #rewards == 0) then
        return
    end
    self.grid_Awards.MaxCount = #rewards
    for i = 0, self.grid_Awards.MaxCount - 1 do
        self:RefreshRewardItem(self.grid_Awards.controlList[i], rewards[i + 1])
    end
end

---刷新奖励展示Item
---@param go UnityEngine.GameObject
---@param reward CangYueShowRewards
function UIBrmCangYuePanel:RefreshRewardItem(go, reward)
    if (go == nil or reward == nil) then
        return
    end
    local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
    local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(reward.itemID)
    if template ~= nil and itemInfoIsFind then
        template:RefreshUIWithItemInfo(itemInfo, reward.itemCount)
        CS.UIEventListener.Get(go.gameObject).onClick = function(go)
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
        end
    end
end

--endregion

--region destroy

--endregion

return UIBrmCangYuePanel