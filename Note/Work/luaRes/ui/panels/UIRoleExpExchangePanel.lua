---角色经验兑换界面
---@class UIRoleExpExchangePanel:UIBase
local UIRoleExpExchangePanel = {}

---最低液面y值
UIRoleExpExchangePanel.minLiquidY = -73
---最高液面y值
UIRoleExpExchangePanel.maxLiquidY = 73
---正常缩放范围的百分比下限
UIRoleExpExchangePanel.normalScaleLimitMin = 0.2
---正常缩放范围的百分比上限
UIRoleExpExchangePanel.normalScaleLimitMax = 0.8
---聚灵珠的itemID
UIRoleExpExchangePanel.jlzItemID = 8540001
---球特效偏移量最低值
UIRoleExpExchangePanel.ballEffectOffsetMin = -0.54
---球特效偏移量最高值
UIRoleExpExchangePanel.ballEffectOffsetMax = 0.64

--region components
---跳转转生按钮
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetJumpButton()
    if self.mJumpButton == nil then
        self.mJumpButton = self:GetCurComp("WidgetRoot/Main/events/btn_jump", "GameObject")
    end
    return self.mJumpButton
end

---关闭按钮
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetCloseButtonGo()
    if self.mCloseButtonGo == nil then
        self.mCloseButtonGo = self:GetCurComp("WidgetRoot/Main/window/left_main/events/btn_close", "GameObject")
    end
    return self.mCloseButtonGo
end

---经验球图片
---@return UISprite
function UIRoleExpExchangePanel:GetExpBallSlider()
    if self.mExpBallSlider == nil then
        self.mExpBallSlider = self:GetCurComp("WidgetRoot/Main/view/ball/Sprite2", "UISprite")
    end
    return self.mExpBallSlider
end

---经验球水平面
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetExpBallLiquidGo()
    if self.mExpBallLiquidGo == nil then
        self.mExpBallLiquidGo = self:GetCurComp("WidgetRoot/Main/view/ball/panel/Sprite3", "GameObject")
    end
    return self.mExpBallLiquidGo
end

---经验池文本
---@return UILabel
function UIRoleExpExchangePanel:GetExpPoolLabel()
    if self.mExpPoolLabel == nil then
        self.mExpPoolLabel = self:GetCurComp("WidgetRoot/Main/view/ball/panel2/expPool", "UILabel")
    end
    return self.mExpPoolLabel
end

---道具数量文本
---@return UILabel
function UIRoleExpExchangePanel:GetPropAmountLabel()
    if self.mPropAmountLabel == nil then
        self.mPropAmountLabel = self:GetCurComp("WidgetRoot/Main/view/JLZNum/value", "UILabel")
    end
    return self.mPropAmountLabel
end

---兑换数量文本
---@return UILabel
function UIRoleExpExchangePanel:GetExchangeNumberLabel()
    if self.mExchangeNumberLabel == nil then
        self.mExchangeNumberLabel = self:GetCurComp("WidgetRoot/Main/view/ExchangeNum/value", "UILabel")
    end
    return self.mExchangeNumberLabel
end

---兑换方法
---@return UIGridContainer
function UIRoleExpExchangePanel:GetExchangeMethodGridContainer()
    if self.mExchangeMethodGridContainer == nil then
        self.mExchangeMethodGridContainer = self:GetCurComp("WidgetRoot/Main/view/ScrollView/Grid", "UIGridContainer")
    end
    return self.mExchangeMethodGridContainer
end

---聚灵珠icon
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetJlzIconGo()
    if self.mJlzIconGo == nil then
        self.mJlzIconGo = self:GetCurComp("WidgetRoot/Main/view/JLZNum/icon", "GameObject")
    end
    return self.mJlzIconGo
end

---聚灵珠添加按钮
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetJlzAddButtonGo()
    if self.mJlzAddButtonGo == nil then
        self.mJlzAddButtonGo = self:GetCurComp("WidgetRoot/Main/view/JLZNum/add", "GameObject")
    end
    return self.mJlzAddButtonGo
end

---兑换次数添加按钮
---@return UnityEngine.GameObject
function UIRoleExpExchangePanel:GetExchangeNumAddButtonGo()
    if self.mExchangeNumAddButtonGo == nil then
        self.mExchangeNumAddButtonGo = self:GetCurComp("WidgetRoot/Main/view/ExchangeNum/add", "GameObject")
    end
    return self.mExchangeNumAddButtonGo
end

---跳转红点
---@return UIRedPoint
function UIRoleExpExchangePanel:GetBtnJumpRedPoint()
    if self.mBtnJumpRedPoint == nil then
        self.mBtnJumpRedPoint = self:GetCurComp("WidgetRoot/Main/events/btn_jump/redpoint", "UIRedPoint")
    end
    return self.mBtnJumpRedPoint
end

---特效球加载器
---@return CSUIEffectLoad
function UIRoleExpExchangePanel:GetBallEffectLoad()
    if self.mBallEffectLoad == nil then
        self.mBallEffectLoad = self:GetCurComp("WidgetRoot/Main/view/ball/Sprite1", "CSUIEffectLoad")
    end
    return self.mBallEffectLoad
end
--endregion

--region initialize
function UIRoleExpExchangePanel:Init()
    self:BindUIEvents()
    self:BindEvents()
    self:GetBallEffectLoad().onLoadFinish = function()
        self:RefreshCurrentExp()
    end
end

function UIRoleExpExchangePanel:Show()
    self:RefreshUI()
end

function UIRoleExpExchangePanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButtonGo()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetJumpButton()).onClick = function()
        self:JumpToRoleTurngrowPanel()
    end
    CS.UIEventListener.Get(self:GetJlzIconGo()).onClick = function()
        local mItemInfoExist, mItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.jlzItemID)
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = mItemInfo, showRight = false })
    end
    CS.UIEventListener.Get(self:GetJlzAddButtonGo()).onClick = function()
        Utility.ShowItemGetWay(self.jlzItemID, self:GetJlzAddButtonGo(), LuaEnumWayGetPanelArrowDirType.Left)
    end
    self:GetExchangeNumAddButtonGo():SetActive(false)
    UIRoleExpExchangePanel:GetBtnJumpRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LuaRoleReinRedPoint))
    UIRoleExpExchangePanel:GetBtnJumpRedPoint():AddRedPointKey(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.LianZhi_XiuWei))
end

function UIRoleExpExchangePanel:BindEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_ExpExchangeDataChanged, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshUI()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshUI()
    end)
end
--endregion

--region refresh
function UIRoleExpExchangePanel:ReShowSelf()
    self:RunBaseFunction("ReShowSelf")
    self:RefreshUI()
end

function UIRoleExpExchangePanel:RefreshUI()
    self.mIsDirty = true
end

---@private
function UIRoleExpExchangePanel:RefreshUIInternal()
    self:RefreshCurrentExp()
    self:RefreshPropNumber()
    self:RefreshExchangeList()
end
--endregion

--region exchange list
function UIRoleExpExchangePanel:RefreshExchangeList()
    local expExchange = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange()
    if expExchange == nil or expExchange:GetExpExchangeCostList() == nil then
        self:GetExchangeMethodGridContainer().MaxCount = 0
        return
    end
    local costList = {}
    for i = 1, #expExchange:GetExpExchangeCostList() do
        local expExchangeCost = expExchange:GetExpExchangeCostList()[i]
        if expExchange:IsExchangeGearShow(expExchangeCost.gearIndex) then
            table.insert(costList, expExchangeCost)
        end
    end
    self:GetExchangeMethodGridContainer().MaxCount = #costList
    for i = 1, #costList do
        local go = self:GetExchangeMethodGridContainer().controlList[i - 1]
        local template = self:GetExpExchangeCostOptionTemplate(go)
        template:InitializeCostData(costList[i])
    end
end

---@return UIExpExchangeCostOption
function UIRoleExpExchangePanel:GetExpExchangeCostOptionTemplate(go)
    if self.goToTemplateDic == nil then
        self.goToTemplateDic = {}
    end
    local template = self.goToTemplateDic[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIExpExchangeCostOption, self)
        self.goToTemplateDic[go] = template
    end
    return template
end
--endregion

--region prop ui
---刷新道具和可兑换文本
---@private
function UIRoleExpExchangePanel:RefreshPropNumber()
    if gameMgr:GetPlayerDataMgr() == nil or gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange() == nil then
        return
    end
    local propNumber = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(8540001)
    if propNumber == 0 then
        self:GetPropAmountLabel().text = "[ff0000]" .. tostring(propNumber) .. "[-]"
        self:GetJlzAddButtonGo():SetActive(true)
    else
        self:GetPropAmountLabel().text = tostring(propNumber)
        self:GetJlzAddButtonGo():SetActive(false)
    end
    local exchangeNumber = 0
    if gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData() ~= nil then
        exchangeNumber = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData().hasCount
    end
    if exchangeNumber == 0 then
        self:GetExchangeNumberLabel().text = '[ff0000]0[-]/' .. gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetMaxExchangeTimes()
    else
        self:GetExchangeNumberLabel().text = exchangeNumber .. '/' .. gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetMaxExchangeTimes()
    end
end
--endregion

--region exppool
---刷新当前经验值
---@public
function UIRoleExpExchangePanel:RefreshCurrentExp()
    if gameMgr:GetPlayerDataMgr() ~= nil and
            gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange() ~= nil and
            gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData() ~= nil then
        self:SetCurrentExp(gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData().hasExp)
    else
        self:SetCurrentExp(0)
    end
end

---设置当前经验值
---@private
---@param expAmount number
function UIRoleExpExchangePanel:SetCurrentExp(expAmount)
    if expAmount == nil then
        return
    end
    local maxExp = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetMaxExp()
    self:GetExpPoolLabel().text = "[c7efff]" .. self:GetNumberChineseStr(expAmount, true) .. "/" .. self:GetNumberChineseStr(maxExp)
    self:SetExpBallPercentage(expAmount / maxExp)
end

---获取数字的中文简写
---@public
---@param num number
---@param useDecimal boolean|nil
---@return string
function UIRoleExpExchangePanel:GetNumberChineseStr(num, useDecimal)
    if num < 10000 then
        return tostring(num)
    elseif num >= 10000 and num < 100000000 then
        if num % 10000 ~= 0 and useDecimal then
            return tostring(math.floor((num / 10000) * 10) / 10) .. "万"
        else
            return tostring(math.floor(num / 10000)) .. "万"
        end
    elseif num >= 100000000 then
        if num % 100000000 ~= 0 and useDecimal then
            return tostring(math.floor((num / 100000000) * 100) / 100) .. "亿"
        else
            return tostring(math.floor(num / 100000000)) .. "亿"
        end
    end
end

---设置经验球水平面的百分比
---@private
---@param percentage number
function UIRoleExpExchangePanel:SetExpBallPercentage(percentage)
    if percentage == nil then
        return
    end
    percentage = math.clamp01(percentage)
    ---底图百分比
    self:GetExpBallSlider().fillAmount = percentage
    ---液面缩放
    local liquidGoY = percentage * (self.maxLiquidY - self.minLiquidY) + self.minLiquidY
    local liquidGoScaleY = 1
    if self.normalScaleLimitMin > 0 and percentage < self.normalScaleLimitMin then
        liquidGoScaleY = 1 - (self.normalScaleLimitMin - percentage) / self.normalScaleLimitMin
    end
    if self.normalScaleLimitMax < 1 and percentage > self.normalScaleLimitMax then
        liquidGoScaleY = 1 - (percentage - self.normalScaleLimitMax) / (1 - self.normalScaleLimitMax)
    end
    ---液面位置
    local pos = self:GetExpBallLiquidGo().transform.localPosition
    pos.y = liquidGoY
    self:GetExpBallLiquidGo().transform.localPosition = pos
    local scale = self:GetExpBallLiquidGo().transform.localScale
    scale.y = liquidGoScaleY
    self:GetExpBallLiquidGo().transform.localScale = scale
    ---三个特效的位置
    ---@type UnityEngine.Transform
    local effectTransLoaded = self:GetComp(self:GetBallEffectLoad().transform, "700254(Clone)", "Transform")
    if effectTransLoaded == nil or CS.StaticUtility.IsNull(effectTransLoaded) then
        return
    end
    local offset = CS.UnityEngine.Vector2(0, (1 - percentage) * (self.ballEffectOffsetMax - self.ballEffectOffsetMin) + self.ballEffectOffsetMin)
    ---@type UnityEngine.ParticleSystemRenderer
    local particle1Renderer = self:GetComp(effectTransLoaded, "low/rot_01", "ParticleSystemRenderer")
    if particle1Renderer ~= nil and particle1Renderer.sharedMaterial ~= nil then
        particle1Renderer.sharedMaterial:SetTextureOffset("_MaskTex", offset)
    end
    ---@type UnityEngine.ParticleSystemRenderer
    local particle2Renderer = self:GetComp(effectTransLoaded, "low/rot_02", "ParticleSystemRenderer")
    if particle2Renderer ~= nil and particle2Renderer.sharedMaterial ~= nil then
        particle2Renderer.sharedMaterial:SetTextureOffset("_MaskTex", offset)
    end
    ---@type UnityEngine.ParticleSystemRenderer
    local particle3Renderer = self:GetComp(effectTransLoaded, "low/rot_03", "ParticleSystemRenderer")
    if particle3Renderer ~= nil and particle3Renderer.sharedMaterial ~= nil then
        particle3Renderer.sharedMaterial:SetTextureOffset("_MaskTex", offset)
    end
end
--endregion

function update()
    if UIRoleExpExchangePanel.mIsDirty then
        UIRoleExpExchangePanel.mIsDirty = false
        UIRoleExpExchangePanel:RefreshUIInternal()
    end
end

---跳转至角色转生界面
---@public
function UIRoleExpExchangePanel:JumpToRoleTurngrowPanel()
    self:HideSelf()
    local roleTurngrowPanel = uimanager:GetPanel("UIRoleTurngrowPanel")
    if roleTurngrowPanel then
        roleTurngrowPanel:ReShowSelf()
    else
        uimanager:CreatePanel("UIRoleTurngrowPanel")
    end
end

function ondestroy()
    ---关闭时带着转生面板一起走
    uimanager:ClosePanel("UIRoleTurngrowPanel")
end

return UIRoleExpExchangePanel