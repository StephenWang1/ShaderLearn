---@class UIPotentialInvestPanel:UIBase
local UIPotentialInvestPanel= {}


--region 
function UIPotentialInvestPanel:Init()
    self:InitComponents()
    self:InitParams()
    self:BindNetMessage()
end

--- 初始化组件
function UIPotentialInvestPanel:InitComponents()
    ---@type UILoopScrollViewPlus 投资数据
    UIPotentialInvestPanel.LestInvestList = self:GetCurComp("WidgetRoot/view/InvestList/ScrollView/GridContainer","UILoopScrollViewPlus")

    ---@type UILoopScrollViewPlus 详细信息
    UIPotentialInvestPanel.RightInvestInfoList = self:GetCurComp("WidgetRoot/view/InvestInfoList/ScrollView/GridContainer", "UILoopScrollViewPlus")

    ---@type UICountdownLabel 倒计时
    UIPotentialInvestPanel.lblTimeCount = self:GetCurComp("WidgetRoot/view/TimeCount", "UICountdownLabel")
    UIPotentialInvestPanel.lblTimeCount_obj = self:GetCurComp("WidgetRoot/view/TimeCount", "GameObject")
    
end

-- 初始化参数
function UIPotentialInvestPanel:InitParams()
    ---@type table<number, UIPotentialInvestTypeTemplate>
    self.LeftInvestDic ={}
    ---@type table<number, UIPotentialInvestConditionTemplate>
    self.RightConditionInvestDic ={}
    ---@type number 选中哪一个
    self.mSelectType = nil
    self.InvestInfo = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo().InvestInfo
    -- 是否已激活
    self.isOpen = false
end

function UIPotentialInvestPanel:BindNetMessage()
    -- 所有潜能投资数据
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFashionInvestInfoMessage, UIPotentialInvestPanel.OnResFashionInvestInfoMessage)
    -- 某类型投资数据
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFashionInvestMessage, UIPotentialInvestPanel.OnResFashionInvestMessage)
end

--endregion

function UIPotentialInvestPanel.OnResFashionInvestInfoMessage(msgId,msgData)
    UIPotentialInvestPanel.InvestInfo = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo().InvestInfo
    UIPotentialInvestPanel:RefreshRightInvestDetail(UIPotentialInvestPanel.mSelectType)
    UIPotentialInvestPanel:RefreshTimeCount()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint))
    luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
end

function UIPotentialInvestPanel.OnResFashionInvestMessage(msgId,msgData)
    UIPotentialInvestPanel.InvestInfo.invest[UIPotentialInvestPanel.mSelectType] = msgData
    UIPotentialInvestPanel:RefreshRightInvestDetail(UIPotentialInvestPanel.mSelectType)
    UIPotentialInvestPanel:RefreshTimeCount()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint))
    luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
end

--region UI

function UIPotentialInvestPanel:Show(customData)
    self:RefreshPanel()
end

function UIPotentialInvestPanel:RefreshPanel()
    self:RefreshLeftInvestList()
    local GetType,NotGetType = gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():GetLatelyGetAndNotGetType()
    local selectType = GetType ~= nil and GetType or (NotGetType == nil and 1 or NotGetType)
    self:SelectInvestType(selectType)
    self:RefreshTimeCount()
end

-- 刷新左侧潜能投资类型
function UIPotentialInvestPanel:RefreshLeftInvestList()
    self.LestInvestList:Init(function(go, line)
        if line < #self.InvestInfo.invest then
            self:RefreshSingleInvestList(go, line)
            return true
        else
            return false
        end
    end, nil)
end

function UIPotentialInvestPanel:RefreshSingleInvestList(go, line)
    local template = self:GetInvestTypeTemplate(go)
    local data = {}
    data.index = line+1
    data.isSelected = (self.mSelectType == data.index)
    template:RefreshUI(data)
end

function UIPotentialInvestPanel:GetInvestTypeTemplate(go)
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

function UIPotentialInvestPanel:OnInvestTypeClicked(goTemp, typenum)
    self:SelectInvestType(typenum)
end

-- 选择类型
function UIPotentialInvestPanel:SelectInvestType(selectType)
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

function UIPotentialInvestPanel:GetTemplate(selectType)
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
function UIPotentialInvestPanel:RefreshRightInvestDetail(typenum)
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

function UIPotentialInvestPanel:RefreshConditionInvest(go, line)
    local temp = self.RightConditionInvestDic[go]
    if(temp == nil) then
        ---@type UIPotentialInvestConditionTemplate
        temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIPotentialInvestConditionTemplate)
        self.RightConditionInvestDic[go] = temp
    end
    local data = {}
    data.info = self.ShowTypeList[line+1]
    data.isOpen = self.isOpen
    data.potentialInvestType = self.mSelectType
    data.line = line
    temp:RefreshUI(data)
end

-- 倒计时刷新
function UIPotentialInvestPanel:RefreshTimeCount()
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
function UIPotentialInvestPanel:RefreshConditionData()
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
function UIPotentialInvestPanel.SortTbl(l, r)
    if l == nil or r == nil then
        return false
    end

    -- 类型*1000的数据保持在第一位
    if math.fmod( l.id, 1000) == 0 or math.fmod( r.id, 1000) == 0 then
        return math.fmod( l.id, 1000) == 0
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

return UIPotentialInvestPanel