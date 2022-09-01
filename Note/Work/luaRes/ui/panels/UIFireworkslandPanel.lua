---@class UIFireworkslandPanel:UINPCDuplicateBase
local UIFireworkslandPanel = {}

setmetatable(UIFireworkslandPanel, luaPanelModules.UINPCDuplicateBase)

---@param mDupType number 副本类型
---@param mDesId  number 描述id
function UIFireworkslandPanel:Show(mDupType, mDesId)
    self.mDuplicateType = mDupType
    self.mDescriptionId = mDesId
    self:RunBaseFunction("Show")
end

function UIFireworkslandPanel:OnEnterBtnClicked(go)
    local bubbleId = self:GetBubbleId()
    if bubbleId == -1 then
        self:EnterDuplicate()
    else
        Utility.ShowPopoTips(go, nil, bubbleId)
    end
end

---@param dupTbl TABLE.CFG_DUPLICATE
---@return boolean,string 是否满足条件,文本后缀
function UIFireworkslandPanel:GetAddShow(dupTbl)
    if dupTbl == nil then
        return false, ""
    end
    local conditionList = dupTbl.specialCondition
    if conditionList.list.Count >= 2 then

        local minId = conditionList.list[0]
        local maxId = conditionList.list[1]
        ---@type TABLE.cfg_conditions
        local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(minId)

        local typeStr = ""
        if (conditionTbl:GetConditionType() == LuaConditionType.RoleLevel) then
            typeStr = "级"
        elseif (conditionTbl:GetConditionType() == LuaConditionType.RoleReinLevel) then
            typeStr = "转"
        end

        ---@type LuaMatchConditionResult
        local resultMin = Utility.IsMainPlayerMatchCondition(minId)
        ---@type LuaMatchConditionResult
        local resultMax = Utility.IsMainPlayerMatchCondition(maxId)
        if resultMin and resultMax then
            local maxShow = ""
            local maxReinLevel = tonumber(resultMax.param)
            if maxReinLevel then
                maxShow = maxReinLevel - 1
            end
            local str = Utility.CombineStringQuickly("(", resultMin.param, typeStr, "-", maxShow, typeStr, ")")
            local full = resultMin.success and resultMax.success
            return full, str
        end
    end
    return false, ""
end

function UIFireworkslandPanel:ChangeConditionState(conditionFull)
    self.mConditionFull = conditionFull
end

function UIFireworkslandPanel:ChangeCostFullState(state)
    self.mCostFull = state
end

function UIFireworkslandPanel:GetBubbleId()
    if not self.mConditionFull then
        return 451
    elseif not self.mCostFull then
        return 452
    end
    return -1
end

function UIFireworkslandPanel:SetChooseListShow(isShow)
    self:RunBaseFunction("SetChooseListShow", isShow)
    self:JumpToLine()
end

return UIFireworkslandPanel