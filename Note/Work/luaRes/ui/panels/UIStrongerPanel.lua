---我要变强界面
---@class UIStrongerPanel:UIBase
local UIStrongerPanel = {}

UIStrongerPanel.CurBtn = nil
UIStrongerPanel.TogTb = {}
UIStrongerPanel.GoAndTemplate = {}
UIStrongerPanel.GoAndIndex = {}
UIStrongerPanel.InitiallyIndex = 1


---@return Top_UIScrollView
function UIStrongerPanel:GetTypeListTemplate_UIScrollView()
    if (self.mTypeListTemplate_UIScrollView == nil) then
        self.mTypeListTemplate_UIScrollView = self:GetCurComp("WidgetRoot/view/BookMark", "Top_UIScrollView");
    end
    return self.mTypeListTemplate_UIScrollView;
end

---@return UIGridContainer 按钮Grid
function UIStrongerPanel:GetTypeListTemplate_UIGridContainer()
    if (self.mTypeListTemplate_UIGridContainer == nil) then
        self.mTypeListTemplate_UIGridContainer = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "UIGridContainer");
    end
    return self.mTypeListTemplate_UIGridContainer;
end

---@return UIGridContainer 主体Grid
function UIStrongerPanel:GetTemplate_UIGridContainer()
    if (self.mTemplate_UIGridContainer == nil) then
        self.mTemplate_UIGridContainer = self:GetCurComp("WidgetRoot/view/MainView/Scroll View/Grid", "UIGridContainer");
    end
    return self.mTemplate_UIGridContainer;
end

---@return UnityEngine.GameObject 关闭按钮
function UIStrongerPanel:GetClose_GameObject()
    if (self.mClose_GameObject == nil) then
        self.mClose_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject");
    end
    return self.mClose_GameObject;
end

function UIStrongerPanel:Init()
    self:InitializeData()
    self:BindUIEvents()
end

function UIStrongerPanel:Show(customData)
    UIStrongerPanel.InitiallyIndex = customData ~= nil and customData.targetIndex ~= nil and customData.targetIndex or 1
    self:DefMainBtnGrid()
end

function UIStrongerPanel:BindUIEvents()
    if (CS.StaticUtility.IsNull(self:GetClose_GameObject()) == false) then
        CS.UIEventListener.Get(self:GetClose_GameObject()).onClick = function(go)
            uimanager:ClosePanel("UISystemOpenMainPanel")
        end
    end
end

--- 设置主按钮
---@return UIStrongerMainBtnGrid
function UIStrongerPanel:DefMainBtnGrid()
    if (self.TogTb ~= nil and #self.TogTb > 0 and self:GetTypeListTemplate_UIGridContainer() ~= nil) then
        self:GetTypeListTemplate_UIScrollView():Reposition()
        self:GetTypeListTemplate_UIGridContainer().MaxCount = #self.TogTb / 2
        for i = 1, self:GetTypeListTemplate_UIGridContainer().MaxCount do
            local go = self:GetTypeListTemplate_UIGridContainer().controlList[i - 1]
            if go then
                if UIStrongerPanel.GoAndTemplate[go] == nil then
                    UIStrongerPanel.GoAndTemplate[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIStrongerMainBtnGrid)
                end
                local temp = UIStrongerPanel.GoAndTemplate[go]
                temp:ShowData(tonumber(self.TogTb[(2 * i) - 1]), self.TogTb[2 * i])
                CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                    self:OnSetMainInfo(temp)
                end
                UIStrongerPanel.GoAndIndex[i] = go
                --[[                if (i == UIStrongerPanel.InitiallyIndex and self.CurBtn == nil) then
                                    self:OnSetMainInfo(temp)
                                end]]
            end
        end
        if (self.CurBtn == nil) then
            self:SwitchMainInfo(UIStrongerPanel.InitiallyIndex)
        end
    end
end

function UIStrongerPanel:OnSetMainInfo(temp)
    if (self.CurBtn ~= nil) then
        self.CurBtn:SetBg(temp.type)
    end
    self.CurBtn = temp
    self.CurBtn:SetBg(temp.type)
    self:DefMainInfoGrid(temp.type)
end

function UIStrongerPanel:SwitchMainInfo(index)
    local targetGo = UIStrongerPanel.GoAndIndex[index]
    if targetGo == nil then
        return
    end
    local targetTemplate = UIStrongerPanel.GoAndTemplate[targetGo]
    if targetTemplate then
        self:OnSetMainInfo(targetTemplate)
    end
end

---设置主要信息
---@return UIStrongerMainInfoGrid
function UIStrongerPanel:DefMainInfoGrid(type)
    local IsLowPriority_Active = self:IsLowPriority_Active()
    local powerActiveTable = nil
    local tb = {}
    clientTableManager.cfg_powerfulManager:ForPair(function(i, v)
        ---@type TABLE.cfg_powerful
        local temp = v
        if (v ~= nil and tonumber(v.type) == type) then
            local result = self:IsMeetCondition(v)
            if result then
                if IsLowPriority_Active and temp:GetId() == 1 then
                    ---低优先级的
                    powerActiveTable = temp
                else
                    table.insert(tb, v)
                end
            end
        end
    end)
    if powerActiveTable ~= nil then
        table.insert(tb, powerActiveTable)
    end
    if (tb ~= nil and #tb > 0 and self:GetTemplate_UIGridContainer() ~= nil) then
        self:GetTemplate_UIGridContainer().MaxCount = #tb
        for i = 1, #tb do
            local go = self:GetTemplate_UIGridContainer().controlList[i - 1]
            local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIStrongerMainInfoGrid)
            temp:ShowData(tb[i])
        end
    end

end

---当前日活是否是低优先的
function UIStrongerPanel:IsLowPriority_Active()
    for i, v in pairs(clientTableManager.cfg_activeManager.dic) do
        ---@type TABLE.cfg_active
        local temp = v
        local state = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveState(temp:GetId());
        if state ~= 5 and state ~= 3 then
            return false
        end
    end
    return true
end

function UIStrongerPanel:InitializeData()
    local isTblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22512)
    if (isTblExist) then
        self.TogTb = string.Split(tbl.value, '#')
    end
end

---是否满足Condition限制
---@param table TABLE.cfg_powerful
function UIStrongerPanel:IsMeetCondition(table)
    if table == nil then
        return false
    end
    if table:GetType() == "1" and table:GetJumpType() == "5" and table:GetOpenPanel() ~= "" then
        return CS.CSScene.MainPlayerInfo.RechargeInfo:IsRechargeBoxHasBuy(tonumber(table:GetOpenPanel()))
    end
    local conditionIds = table:GetCondition()
    if conditionIds == nil or conditionIds.list == nil then
        return true
    end
    for i = 1, #conditionIds.list do
        local v = conditionIds.list[i]
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
            return false
        end
    end
    return true
end

function UIStrongerPanel:ResetView()
    self:SwitchMainInfo(1)
    self:GetTypeListTemplate_UIScrollView():Reposition()
end

function ondestroy()
    UIStrongerPanel.CurBtn = nil
    UIStrongerPanel.TogTb = nil
end

return UIStrongerPanel