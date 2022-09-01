---@class UISevenDayInvestmentPanel 投资面板
local UISevenDayInvestmentPanel = {}

function UISevenDayInvestmentPanel:InitComponents()
    ---左侧道具列表
    self.GridContainerLeft = self:GetCurComp("ContinuityRecharge/ScrollView/GridContainer_left", "Top_UIGridContainer")
    ---右侧道具列表
    self.GridContainerRight = self:GetCurComp("ContinuityRecharge/ScrollView/GridContainer_right", "Top_UIGridContainer")
    ---充值购买按钮
    self.btn_Investment = self:GetCurComp("ContinuityRecharge/Sprite_slogan/btn_Investment", "GameObject")
    ---倒计时
    self.Time = self:GetCurComp('ContinuityRecharge/Time', 'UICountdownLabel')
    ---钻石数量
    self.itemgold = self:GetCurComp('ContinuityRecharge/Sprite_slogan/itemgold', 'UILabel')
end

function UISevenDayInvestmentPanel:InitOther()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInvestPlanDataMessage, function()
        self:ResInvestPlanDataMessage()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResInvestPlanInfoMessage, function()
        self:ResInvestPlanInfoMessage()
    end)

    CS.UIEventListener.Get(self.btn_Investment).onClick = function(go)
        self:OnClickedbtn_Investment()
    end
end

---初始化数据
function UISevenDayInvestmentPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UISevenDayInvestmentPanel:Show(Turm)
    self.go:SetActive(true)
    self.Turm = Turm
    UISevenDayInvestmentPanel:RefreshUI()
end

---隐藏
function UISevenDayInvestmentPanel:Hide()
    self.go:SetActive(false)
end

---刷新UI
---@param 投资期数
function UISevenDayInvestmentPanel:RefreshUI()
    self.InvestmentMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr()
    if self.InvestmentMgr == nil then
        return
    end
    self.InvestmentTurm = self.InvestmentMgr:GetSingleInvestmentTurm(self.Turm)
    if self.InvestmentTurm == nil then
        return
    end
    local leftDataList = self.InvestmentTurm:GetSingleTypeList(1)
    local rigthDataList = self.InvestmentTurm:GetSingleTypeList(2)

    leftDataList = self.InvestmentTurm:InvestmentItemListSort(leftDataList)
    rigthDataList = self.InvestmentTurm:InvestmentItemListSort(rigthDataList)
    self:RefreshGridContainer(self.GridContainerLeft, leftDataList)
    self:RefreshGridContainer(self.GridContainerRight, rigthDataList)
    self:Refresbtn_InvestmentActive()
    self:RefresEndTime()

end

---刷新按钮显示状态
function UISevenDayInvestmentPanel:Refresbtn_InvestmentActive()
    if self.InvestmentTurm == nil then
        return
    end
    local isPurchased = self.InvestmentTurm.isPurchased
    self.btn_Investment.gameObject:SetActive(isPurchased == 0)
    self.itemgold.gameObject:SetActive(isPurchased == 0)
    if self.InvestmentMgr == nil then
        return
    end

    self.itemgold.text = self.InvestmentMgr:GetTurmBuyPrice(self.Turm)
end

---刷新结束倒计时
function UISevenDayInvestmentPanel:RefresEndTime()
    if self.InvestmentTurm == nil then
        return
    end
    local endTime = self.InvestmentTurm.endTime
    if endTime == 0 or endTime == nil or self.InvestmentTurm.isPurchased == 1 then
        self.Time.gameObject:SetActive(false)
    else
        self.Time.gameObject:SetActive(true)
        self.Time:StartCountDown(nil, 2, endTime, "", "")
    end

end

---刷新投资列表
---@param  Grid Top_UIGridContainer
---@param data table<number,LuaInvestmentItem>
function UISevenDayInvestmentPanel:RefreshGridContainer(Grid, data)
    if data == nil or Grid == nil then
        return
    end
    if self.GridDic == nil then
        ---@type table<GameObject,UIInvestmentTemplate>
        self.GridDic = {}
    end
    Grid.MaxCount = #data
    local index = 0
    for i, v in pairs(data) do
        local go = Grid.controlList[index]
        if self.GridDic[go] == nil then
            self.GridDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIInvestmentTemplate)
        end
        self.GridDic[go]:RefreshUI(v)
        index = index + 1
    end
end

---投资按钮点击事件
function UISevenDayInvestmentPanel:OnClickedbtn_Investment()
    if self.InvestmentMgr == nil then
        return
    end
    ---购买价格
    local price = self.InvestmentMgr:GetTurmBuyPrice(self.Turm)
    ---钻石数量
    local diamondNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(LuaEnumCoinType.Diamond)
    if diamondNumber < price then
        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.Investment
        Utility.TryShowFirstRechargePanel()
        return
    end
    ---请求购买投资
    if self.Turm == nil then
        return
    end
    networkRequest.ReqBuyInvestPlan(self.Turm)

end

---所有数据变化消息
function UISevenDayInvestmentPanel:ResInvestPlanDataMessage()
    self:RefreshUI()
end

---返回当前期数据变化
function UISevenDayInvestmentPanel:ResInvestPlanInfoMessage()
    self:RefreshUI()
end

return UISevenDayInvestmentPanel