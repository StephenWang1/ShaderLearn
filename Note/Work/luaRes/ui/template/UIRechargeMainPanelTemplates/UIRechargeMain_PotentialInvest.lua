---充值面板-潜能投资
---@class UIRechargeMain_PotentialInvest:TemplateBase
local UIRechargeMain_PotentialInvest = {}

---@type UICompetitionPanel
function UIRechargeMain_PotentialInvest:Init(panel)
    self.rootPanel = panel
    self:InitComponents()
    self:InitParams()
    self:BindNetMessage()
end

function UIRechargeMain_PotentialInvest:Refresh()
    self:RefreshPanel()
end

--region
--- 初始化组件
function UIRechargeMain_PotentialInvest:InitComponents()
    ---@type UILoopScrollViewPlus 投资数据
    self.LestInvestList = self:Get("InvestList/ScrollView/GridContainer", "UILoopScrollViewPlus")

    ---@type UILoopScrollViewPlus 详细信息
    self.RightInvestInfoList = self:Get("InvestInfoList/ScrollView/GridContainer", "UILoopScrollViewPlus")

    ---@type UICountdownLabel 倒计时
    self.lblTimeCount = self:Get("TimeCount", "UICountdownLabel")
    self.lblTimeCount_obj = self:Get("TimeCount", "GameObject")
end

-- 初始化参数
function UIRechargeMain_PotentialInvest:InitParams()
    ---@type table<number, UIPotentialInvestTypeTemplate>
    self.LeftInvestDic = {}
    ---@type table<number, UIPotentialInvestConditionTemplate>
    self.RightConditionInvestDic = {}
    ---@type number 选中哪一个
    self.mSelectType = nil
    self.InvestInfo = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo().InvestInfo
    -- 是否已激活
    self.isOpen = false
end

function UIRechargeMain_PotentialInvest:BindNetMessage()
    -- 所有潜能投资数据
    self.rootPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFashionInvestInfoMessage, function(msgId, msgData)
        self:OnResFashionInvestInfoMessage(msgId, msgData)
    end)
    -- 某类型投资数据
    self.rootPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFashionInvestMessage, function(msgId, msgData)
        self:OnResFashionInvestMessage(msgId, msgData)
    end)
end

--endregion

function UIRechargeMain_PotentialInvest:OnResFashionInvestInfoMessage(msgId, msgData)
    self.InvestInfo = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo().InvestInfo
    self:RefreshRightInvestDetail(self.mSelectType)
    self:RefreshTimeCount()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint))
    luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
end

function UIRechargeMain_PotentialInvest:OnResFashionInvestMessage(msgId, msgData)
    self.InvestInfo.invest[self.mSelectType] = msgData
    self:RefreshRightInvestDetail(self.mSelectType)
    self:RefreshTimeCount()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint))
    luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
end

--region UI
function UIRechargeMain_PotentialInvest:RefreshPanel()
    self:RefreshLeftInvestList()
    local GetType, NotGetType = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():GetLatelyGetAndNotGetType()
    local selectType = GetType ~= nil and GetType or (NotGetType == nil and 1 or NotGetType)
    self:SelectInvestType(selectType)
    self:RefreshTimeCount()
end

-- 刷新左侧潜能投资类型
function UIRechargeMain_PotentialInvest:RefreshLeftInvestList()
    self.LestInvestList:Init(function(go, line)
        if line < #self.InvestInfo.invest then
            self:RefreshSingleInvestList(go, line)
            return true
        else
            return false
        end
    end, nil)
end

function UIRechargeMain_PotentialInvest:RefreshSingleInvestList(go, line)
    local template = self:GetInvestTypeTemplate(go)
    local data = {}
    data.index = line + 1
    data.isSelected = (self.mSelectType == data.index)
    template:RefreshUI(data)
end

function UIRechargeMain_PotentialInvest:GetInvestTypeTemplate(go)
    if self.LeftInvestDic == nil then
        ---@type table
        self.LeftInvestDic = {}
    end
    if self.LeftInvestDic[go] ~= nil then
        return self.LeftInvestDic[go]
    end
    ---@type UIPotentialInvestTypeTemplate
    local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIPotentialInvestTypeTemplate)
    self.LeftInvestDic[go] = template
    if self.mInvestTypeClickedCallBack == nil then
        self.mInvestTypeClickedCallBack = function(goTemp, typenum)
            self:OnInvestTypeClicked(goTemp, typenum)
        end
    end
    template:RegisterClickCallBack(self.mInvestTypeClickedCallBack)
    return template
end

function UIRechargeMain_PotentialInvest:OnInvestTypeClicked(goTemp, typenum)
    self:SelectInvestType(typenum)
end

-- 选择类型
function UIRechargeMain_PotentialInvest:SelectInvestType(selectType)
    if self.mSelectType == selectType then
        ---重复选中
        return
    end
    if self.latestSelected ~= nil then
        self.latestSelected:SetSelectedState(false)
    end
    local template = self:GetTemplate(selectType)
    if template then
        self.mSelectType = selectType
        template:SetSelectedState(true)
    end
    self.latestSelected = template

    self:RefreshRightInvestDetail(selectType)
end

function UIRechargeMain_PotentialInvest:GetTemplate(selectType)
    if self.LeftInvestDic == nil or selectType == nil then
        return nil
    end
    for i, v in pairs(self.LeftInvestDic) do
        if v:GetInvestType() == selectType then
            return v
        end
    end
    return nil
end

-- 刷新右侧领取条件
function UIRechargeMain_PotentialInvest:RefreshRightInvestDetail(typenum)
    self:RefreshConditionData()
    self.RightInvestInfoList:Init(function(go, line)
        if line < #self.ShowTypeList then
            self:RefreshConditionInvest(go, line)
            return true
        else
            return false
        end
    end, nil)
end

function UIRechargeMain_PotentialInvest:RefreshConditionInvest(go, line)
    local temp = self.RightConditionInvestDic[go]
    if (temp == nil) then
        ---@type UIPotentialInvestConditionTemplate
        temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIPotentialInvestConditionTemplate)
        self.RightConditionInvestDic[go] = temp
    end
    local data = {}
    data.info = self.ShowTypeList[line + 1]
    data.isOpen = self.isOpen
    data.potentialInvestType = self.mSelectType
    data.line = line
    temp:RefreshUI(data)
end

-- 倒计时刷新
function UIRechargeMain_PotentialInvest:RefreshTimeCount()
    -- local IsPurchased = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():IsPurchased()
    -- self.lblTimeCount_obj:SetActive(not IsPurchased)
    -- -- 倒计时结束时刷新充值页签
    -- if self.InvestInfo ~= nil and self.InvestInfo.endTime ~= nil and not IsPurchased then
    --     self.lblTimeCount:StartCountDown(nil, 10, self.InvestInfo.endTime,'活动倒计时', "", nil, function(go)
    --         luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
    --     end)
    -- end
end


--endregion


--region

-- 处理收到的数据
function UIRechargeMain_PotentialInvest:RefreshConditionData()
    self.ShowTypeList = {}
    local typedata = self.InvestInfo.invest[self.mSelectType]
    if typedata == nil then
        return
    end

    self.isOpen = typedata.isOpen == 1
    for i = 1, #typedata.rewards do
        table.insert(self.ShowTypeList, typedata.rewards[i])
    end
    table.sort(self.ShowTypeList, self.SortTbl)
end

---@param l rechargeV2.Reward
---@param r rechargeV2.Reward
function UIRechargeMain_PotentialInvest.SortTbl(l, r)
    if l == nil or r == nil then
        return false
    end

    -- 类型*1000的数据保持在第一位
    if math.fmod(l.id, 1000) == 0 or math.fmod(r.id, 1000) == 0 then
        return math.fmod(l.id, 1000) == 0
    end

    if l.state ~= r.state then
        if l.state == 1 or r.state == 1 then
            return r.state == 1
        end
        return l.state > r.state
    end

    return l.id < r.id
end
--endregion

return UIRechargeMain_PotentialInvest