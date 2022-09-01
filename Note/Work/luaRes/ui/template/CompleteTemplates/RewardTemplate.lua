--- DateTime: 2021/05/07 14:46
--- Description 

---@class RewardTemplate:TemplateBase
local RewardTemplate = {}

---@class ReceiveAwardCommonData
---@field leftBtnCallBack function
---@field rightBtnCallBack function
---@field multipleCost Cost

--region parameters
--endregion

--region Init
---@private
function RewardTemplate:Init()
    self:InitComponent()
    self:BindClientEvents()
end

---@private
function RewardTemplate:InitComponent()
    ---
    ---@type UnityEngine.GameObject
    self.go_btn = self:Get("btn", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_doubleBtn = self:Get("doubleBtn", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_cost = self:Get("cost", "GameObject")
end
--endregion

--region public methods
---@param commonData ReceiveAwardCommonData
function RewardTemplate:RefreshPanel(commonData)
    if (self:AnalysisParams(commonData) == false) then
        luaclass.UIRefresh:RefreshActive(self.go, false)
        return
    end
    self:RefreshCost()
end
--endregion

--region private methods
---解析参数
---@private
---@param commonData ReceiveAwardCommonData
---@return boolean 解析结果
function RewardTemplate:AnalysisParams(commonData)
    if type(commonData) ~= 'table' or commonData.leftBtnCallBack == nil or commonData.rightBtnCallBack == nil or commonData.multipleCost == nil then
        return false
    end
    self.commonData = commonData
    self.leftBtnCallBack = commonData.leftBtnCallBack
    self.rightBtnCallBack = commonData.rightBtnCallBack
    self.multipleCost = commonData.multipleCost
    return true
end

---刷新消耗
---@private
function RewardTemplate:RefreshCost()
    ---双倍领取花费刷新
    if self.doubleCostTemplate == nil then
        self.doubleCostTemplate = templatemanager.GetNewTemplate(self.go_cost, luaComponentTemplates.CostTemplate)
    end
    if self.doubleCostTemplate ~= nil then
        self.doubleCostTemplate:SimpleRefreshPanel({ Cost = self.multipleCost })
    end
end

--endregion

--region bind event
---@private
function RewardTemplate:BindClientEvents()
    --单倍领取
    luaclass.UIRefresh:BindClickCallBack(self.go_btn, function()
        if (self.leftBtnCallBack ~= nil) then
            self.leftBtnCallBack()
        end
    end)
    --双倍领取
    luaclass.UIRefresh:BindClickCallBack(self.go_doubleBtn, function()
        if (self.rightBtnCallBack ~= nil) then
            self.rightBtnCallBack()
        end
    end)
end
--endregion

--region destroy
--endregion

return RewardTemplate