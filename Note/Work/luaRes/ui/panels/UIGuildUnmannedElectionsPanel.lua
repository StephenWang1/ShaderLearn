---@class UIGuildUnmannedElectionsPanel:UIBase
local UIGuildUnmannedElectionsPanel = {}

---职位名字
UIGuildUnmannedElectionsPanel.mTypeToName = {
    [LuaEnumUnionElectionBenefits.PositionAppointment] = "职位任命",
    [LuaEnumUnionElectionBenefits.ActivityPrivilege] = "活动特权",
    [LuaEnumUnionElectionBenefits.MemberManage] = "成员管理",
    [LuaEnumUnionElectionBenefits.LootDistinction] = "战利分配",
    [LuaEnumUnionElectionBenefits.FirstPrize] = "首任奖励",
}

---职位Icon
UIGuildUnmannedElectionsPanel.mTypeToIcon = {
    [LuaEnumUnionElectionBenefits.PositionAppointment] = "Guild_icon1",
    [LuaEnumUnionElectionBenefits.ActivityPrivilege] = "Guild_icon2",
    [LuaEnumUnionElectionBenefits.MemberManage] = "Guild_icon3",
    [LuaEnumUnionElectionBenefits.LootDistinction] = "Guild_icon4",
    [LuaEnumUnionElectionBenefits.FirstPrize] = "Guild_icon5",
}

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIGuildUnmannedElectionsPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSUnionInfoV2 帮会信息
function UIGuildUnmannedElectionsPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mUnionInfoV2
end

---@return CSBagInfoV2 背包信息
function UIGuildUnmannedElectionsPanel:GetBagInfoV2()
    if self.mBagInfo == nil then
        if self:GetPlayerInfo() then
            self.mBagInfo = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfo
end
--endregion

--region 组件
---@return UILabel 竞选消费
function UIGuildUnmannedElectionsPanel:GetElectionCost_UILabel()
    if self.mElectionCostLb == nil then
        self.mElectionCostLb = self:GetCurComp("WidgetRoot/view/Costgold", "UILabel")
    end
    return self.mElectionCostLb
end

---@return UISprite 竞选消费Icon
function UIGuildUnmannedElectionsPanel:GetElectionCost_UISprite()
    if self.mElectionCostSp == nil then
        self.mElectionCostSp = self:GetCurComp("WidgetRoot/view/Costgold/icon", "UISprite")
    end
    return self.mElectionCostSp
end

---@type UnityEngine.GameObject 关闭按钮
function UIGuildUnmannedElectionsPanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---@type UnityEngine.GameObject 竞选按钮
function UIGuildUnmannedElectionsPanel:GetEctionsBtn_GameObject()
    if self.mElectionBtn == nil then
        self.mElectionBtn = self:GetCurComp("WidgetRoot/events/btn_ections", "GameObject")
    end
    return self.mElectionBtn
end

---@return UIGridContainer  福利Contianer
function UIGuildUnmannedElectionsPanel:GetBenefits_UIGridContainer()
    if self.mBenefitsContainerBtn == nil then
        self.mBenefitsContainerBtn = self:GetCurComp("WidgetRoot/view/Scroll View/player", "UIGridContainer")
    end
    return self.mBenefitsContainerBtn
end
--endregion

--region初始化
function UIGuildUnmannedElectionsPanel:Init()
    self:BindEvent()
    self:RefreshEctionsCost()
    self:ShowBenefits()
end

function UIGuildUnmannedElectionsPanel:Show()

end

function UIGuildUnmannedElectionsPanel:BindEvent()
    CS.UIEventListener.Get(self:GetEctionsBtn_GameObject()).onClick = function(go)
        self:OnEctionsBtnClicked(go)
    end
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region UI事件
--region 数据
---@return TABLE.CFG_ITEMS 竞选消耗道具信息
function UIGuildUnmannedElectionsPanel:GetEctionsCostItemInfo()
    local id = self:GetEctionsCostCondition(0)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
    if res then
        return itemInfo
    end
end

---@param type number 类型 0 id 1 数目
---@return number 竞选消耗货币Id 或者货币数目
function UIGuildUnmannedElectionsPanel:GetEctionsCostCondition(type)
    if self.mCostCondition == nil then
        self.mCostCondition = CS.Cfg_GlobalTableManager.Instance:EctionsCostCondition()
    end
    if type and self.mCostCondition and self.mCostCondition.Length >= 2 then
        return self.mCostCondition[type]
    end
    return 0
end
--endregion

--region 竞选
---点击竞选按钮
function UIGuildUnmannedElectionsPanel:OnEctionsBtnClicked(go)
    if not self:IsPrefixEnough() then
        Utility.ShowPopoTips(go, self:GetPrefixNotEnoughDes(), 152)--战勋达到%s后可竞选
        return
    end

    if not (self:GetUnionInfoV2() and self:GetUnionInfoV2():IsCanEctions()) then
        Utility.ShowPopoTips(go, self:GetTimeNotEnoughDes(), 170)--加入行会%d小时才能竞选
        return
    end

    if not self:IsMoneyEnough() then
        Utility.ShowPopoTips(go, self:GetCostNotEnoughDes(), 153)--帮会竞选参选时货币不足
        return
    end
    networkRequest.ReqJoinElection()
    self:ClosePanel()
end

---@return boolean 道具是否足够
function UIGuildUnmannedElectionsPanel:IsMoneyEnough()
    if self:GetBagInfoV2() then
        local costID = self:GetEctionsCostCondition(0)
        local costNum = self:GetEctionsCostCondition(1)
        local playerHas = self:GetBagInfoV2():GetCoinAmount(costID)
        --if res then
        return playerHas >= costNum
        --end
    end
    return false
end

---@return boolean 功勋等级是否足够
function UIGuildUnmannedElectionsPanel:IsPrefixEnough()
    if self:GetPlayerInfo() then
        --  local playerPrefix = self:GetPlayerInfo().PrefixId
        local conditionid = self:GetEctionsCondition(1)
        return Utility.IsMainPlayerMatchCondition(conditionid).success
    end
    return false
end

---@param type number 条件类型 1 战勋 0 入会时间
---@return number 竞选条件
function UIGuildUnmannedElectionsPanel:GetEctionsCondition(type)
    if self.mEctionsCondition == nil then
        self.mEctionsCondition = CS.Cfg_GlobalTableManager.Instance:EctionsCondition()
    end
    if type and self.mEctionsCondition and self.mEctionsCondition.Length >= 2 then
        return self.mEctionsCondition[type]
    end
    return 0
end

---@return string 获取战勋不足描述
function UIGuildUnmannedElectionsPanel:GetPrefixNotEnoughDes()
    if self.mPrefixDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(152)
        if res then
            local conditionid = self:GetEctionsCondition(1)
            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(conditionid)
            if conditionTbl and conditionTbl:GetConditionParam() and conditionTbl:GetConditionParam().list.Count > 0 then
                self.mPrefixDes = string.format(desInfo.content, conditionTbl:GetConditionParam().list[0])
            end
            --local playerCareer = self:GetPlayerInfo().Career
            --local showInfo = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(conditionid, playerCareer)
        end
    end
    return self.mPrefixDes
end

---@return string  竞选入会时间不足描述
function UIGuildUnmannedElectionsPanel:GetTimeNotEnoughDes()
    if self.mTimeDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(170)
        if res then
            local condition = self:GetEctionsCondition(0)
            self.mTimeDes = string.format(desInfo.content, condition)
        end
    end
    return self.mTimeDes
end

---@return string 竞选货币不足描述
function UIGuildUnmannedElectionsPanel:GetCostNotEnoughDes()
    if self.mCostDes == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(153)
        if res and self:GetEctionsCostItemInfo() then
            self.mCostDes = string.format(desInfo.content, self:GetEctionsCostItemInfo().name)
        end
    end
    return self.mCostDes
end
--endregion

--region 竞选消费
function UIGuildUnmannedElectionsPanel:RefreshEctionsCost()
    self:GetElectionCost_UILabel().text = self:GetEctionsCostCondition(1)
    if self:GetEctionsCostItemInfo() then
        self:GetElectionCost_UISprite().spriteName = self:GetEctionsCostItemInfo().icon
    end
end
--endregion

--region 福利显示
---显示福利
function UIGuildUnmannedElectionsPanel:ShowBenefits()
    self:AddBenefitsID(LuaEnumUnionElectionBenefits.PositionAppointment)
    self:AddBenefitsID(LuaEnumUnionElectionBenefits.ActivityPrivilege)
    self:AddBenefitsID(LuaEnumUnionElectionBenefits.MemberManage)
    self:AddBenefitsID(LuaEnumUnionElectionBenefits.LootDistinction)
    if self:GetUnionInfoV2().UnionInfo.unionInfo.isAutoCreated and self:GetPlayerInfo().ActualOpenDays <= 4 then
        self:AddBenefitsID(LuaEnumUnionElectionBenefits.FirstPrize)
    end
    self:RefreshBenefitsShow()
end

---添加数据
function UIGuildUnmannedElectionsPanel:AddBenefitsID(id)
    if self.mShowBenefitsId == nil then
        self.mShowBenefitsId = {}
    end
    table.insert(self.mShowBenefitsId, id)
end

function UIGuildUnmannedElectionsPanel:RefreshBenefitsShow()
    if self.mShowBenefitsId then
        self:GetBenefits_UIGridContainer().MaxCount = #self.mShowBenefitsId
        for i = 0, #self.mShowBenefitsId - 1 do
            local go = self:GetBenefits_UIGridContainer().controlList[i]
            local bg = CS.Utility_Lua.Get(go.transform, "background", "GameObject")
            local name = CS.Utility_Lua.Get(go.transform, "name", "UILabel")
            local sp = CS.Utility_Lua.Get(go.transform, "sp", "UISprite")
            local id = self.mShowBenefitsId[i + 1]
            CS.UIEventListener.Get(bg).onClick = function()
                self:CreateHelpTips(id)
            end
            name.text = self.mTypeToName[id]
            sp.spriteName = self.mTypeToIcon[id]
        end
    end
end

---创建帮助界面
function UIGuildUnmannedElectionsPanel:CreateHelpTips(id)
    local tableInfo = self:GetBenefitsData(id)
    if tableInfo then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, tableInfo)
    end
end

---获取福利数据
function UIGuildUnmannedElectionsPanel:GetBenefitsData(id)
    if self.mBenefitsIDToData == nil then
        self.mBenefitsIDToData = {}
    end
    local data = self.mBenefitsIDToData[id]
    if data == nil then
        ___, data = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(id)
        self.mBenefitsIDToData[id] = data
    end
    return data
end
--endregion


--endregion

return UIGuildUnmannedElectionsPanel