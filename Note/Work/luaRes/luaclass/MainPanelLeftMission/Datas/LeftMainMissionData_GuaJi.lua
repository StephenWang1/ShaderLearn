---挂机数据
---@class LeftMainMissionData_GuaJi:LeftMainMissionData
local LeftMainMissionData_GuaJi = {}

setmetatable(LeftMainMissionData_GuaJi, luaclass.LeftMainMissionData)

function LeftMainMissionData_GuaJi:GetSortIndex()
    if self:GetIsEnabled() == false then
        return LuaEnumLeftMainMissionSortIndex.None
    end
    return LuaEnumLeftMainMissionSortIndex.GuaJiMap
end

function LeftMainMissionData_GuaJi:Initialize()
    --print("LeftMainMissionData_GuaJi:Initialize()")
    ---解析配置的数据
    local isExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22703)
    ---配置数据
    ---@class GuaJiMissionGroupData
    ---@field isEnabled boolean
    ---@field conditions table<number,number>
    ---@field ids table<number,{type:number,id:number}>}
    ---@type table<number,GuaJiMissionGroupData>
    self.configData = {}
    if isExist and tbl then
        local groups = string.Split(tbl.value, '&')
        for i = 1, #groups do
            local arrays = string.Split(groups[i], '$')
            if arrays and #arrays >= 2 then
                local conditions = string.Split(arrays[1], '#')
                local idstrs = string.Split(arrays[2], '#')
                if idstrs and #idstrs >= 2 then
                    local type = nil
                    local ids = {}
                    for j = 1, #idstrs do
                        if type == nil then
                            type = tonumber(idstrs[j])
                        else
                            local id = tonumber(idstrs[j])
                            table.insert(ids, { type = type, id = id })
                            type = nil
                        end
                    end
                    table.insert(self.configData, { conditions = conditions, ids = ids })
                end
            end
        end
    end
    self:UpdateIsEnabled()
    ---绑定事件,用于刷新
    ---角色等级刷新时触发刷新
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
    ---转生等级刷新时触发刷新
    self:GetOwnerPanel():GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateReincarnation, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
    ---VIP等级刷新时触发刷新
    self:GetOwnerPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResRoleVip2InfoChangeMessage, function()
        self:UpdateIsEnabled()
        self:Refresh()
    end)
end

---是否开启
---@public
---@return boolean
function LeftMainMissionData_GuaJi:GetIsEnabled()
    if self.mIsEnabled == nil then
        self:UpdateIsEnabled()
    end
    return self.mIsEnabled == true
end

---更新是否开启的状态,不触发事件
---@private
function LeftMainMissionData_GuaJi:UpdateIsEnabled()
    local cfg_conditionTblMgr = CS.Cfg_ConditionManager.Instance
    local isEnabled = false
    if self.configData then
        for i = 1, #self.configData do
            local groupTemp = self.configData[i]
            ---如果有一组满足条件则认为本数据满足条件,开启
            local isGroupEnabled = true
            for j = 1, #groupTemp.conditions do
                ---如果某个condition不满足条件,则认为本组不满足条件
                if cfg_conditionTblMgr:IsMainPlayerMatchCondition(groupTemp.conditions[j]) == false then
                    isGroupEnabled = false
                    break
                end
            end
            groupTemp.isEnabled = isGroupEnabled
            --print("group", i, isGroupEnabled)
            if isGroupEnabled then
                isEnabled = true
            end
        end
    end
    self.mIsEnabled = isEnabled
    --print("UpdateIsEnabled", self.mIsEnabled)
end

---获取一个可用的配置组
---@private
---@return GuaJiMissionGroupData
function LeftMainMissionData_GuaJi:GetAvailableConfigGroup()
    local configData = nil
    for i = 1, #self.configData do
        local groupData = self.configData[i]
        if groupData.isEnabled then
            configData = groupData
        end
    end
    return configData
end

---任务栏的选项点击事件
---@private
---@param template UIMissionInfoTemplates
function LeftMainMissionData_GuaJi:OnOptionClicked(template)
    local configGroup = self:GetAvailableConfigGroup()
    if configGroup == nil then
        return
    end
    local options = {}
    local callback = function(param, go)
        self:OnPopupOptionClicked(param.type, param.id, go)
    end
    for i = 1, #configGroup.ids do
        local temp = configGroup.ids[i]
        local showName = self:GetShowNameForID(temp.type, temp.id)
        table.insert(options, {
            showName = showName,
            clickCallBack = callback,
            param = temp
        })
    end
    uimanager:CreatePanel("UILeftMainMissionPartSelectPanel", nil,
            options,
            template.lb_state.transform.position)
end

---获取特定类型ID的显示名字
---@private
---@param type number
---@param id number
---@return string
function LeftMainMissionData_GuaJi:GetShowNameForID(type, id)
    if type == 1 then
        return self:GetDeliverOptionName(id)
    elseif type == 2 then
        return self:GetDuplicateOptionName(id)
    end
    return ""
end

---点击任务栏选项后弹出的界面中选项的点击事件
---@private
---@param type number id的意义
---@param id number 选项对应的deliverID
---@param go UnityEngine.GameObject 选项的GameObject
function LeftMainMissionData_GuaJi:OnPopupOptionClicked(type, id, go)
    local failedConditionID
    if type == 1 then
        ---Deliver表的ID
        failedConditionID = self:DoDeliver(id, go)
    elseif type == 2 then
        ---Duplicate表的ID
        failedConditionID = self:DoDuplicate(id, go)
    end
    ---如果有failedConditionID时,根据该conditionID进行异常处理
    if failedConditionID ~= nil then
        if go == nil or CS.StaticUtility.IsNull(go) then
            uimanager:ClosePanel("UILeftMainMissionPartSelectPanel")
            return
        end
        ---deliverID不允许使用,查询原因并弹窗
        local isExist
        ---@type TABLE.CFG_CONDITIONS
        local conditionTbl
        isExist, conditionTbl = CS.Cfg_ConditionManager.Instance:TryGetValue(failedConditionID)
        if conditionTbl then
            if conditionTbl.conditionType == 1 then
                ---等级不足
                Utility.ShowPopoTips(go.transform, "等级不足", 290, "UILeftMainMissionPartSelectPanel")
            elseif conditionTbl.conditionType == 3 then
                ---转生等级不足
                Utility.ShowPopoTips(go.transform, "转生不足", 290, "UILeftMainMissionPartSelectPanel")
            elseif conditionTbl.conditionType == 43 then
                ---新VIP等级不足
                uimanager:CreatePanel("UIVipInfoPanel")
                uimanager:ClosePanel("UILeftMainMissionPartSelectPanel")
            end
        end
    end
end

--region Deliver
---执行配置传送或者弹窗,type为1时执行
---@private
---@param deliverID number deliver表的ID
---@param go UnityEngine.GameObject 按钮的GameObject
---@return number|nil 若返回一个number,表示传送失败,需要上层根据返回的conditionID进行处理
function LeftMainMissionData_GuaJi:DoDeliver(deliverID, go)
    local isDeliverAvailable, conditionID = self:IsDeliverAvailable(deliverID)
    if isDeliverAvailable then
        uimanager:ClosePanel("UILeftMainMissionPartSelectPanel")
        ---deliverID允许使用,直接向服务器请求传送并在之后开启自动战斗
        networkRequest.ReqDeliverByConfig(deliverID, false)
        uiStaticParameter.SetOpenAutoFightAfterDeliver()
    else
        return conditionID
    end
end

---deliverID是否可用
---@private
---@param deliverID number
---@return boolean,number|nil
function LeftMainMissionData_GuaJi:IsDeliverAvailable(deliverID)
    --判断deliverID对应的地图是否可以进入
    local isExist
    ---@type TABLE.CFG_DELIVER
    local deliverTbl
    isExist, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverID)
    if deliverTbl ~= nil then
        ---@type Cfg_ConditionManager
        local conditionTblMgr = CS.Cfg_ConditionManager.Instance
        if deliverTbl.condition ~= nil and deliverTbl.condition ~= 0 then
            if conditionTblMgr:IsMainPlayerMatchCondition(deliverTbl.condition) == false then
                return false, deliverTbl.condition
            end
        end
        ---@type TABLE.CFG_MAP
        local mapTbl
        isExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(deliverTbl.toMapId)
        if mapTbl.conditionId ~= nil and mapTbl.conditionId.list ~= nil and mapTbl.conditionId.list.Count > 0 then
            for i = 1, mapTbl.conditionId.list.Count do
                local conditionIDTemp = mapTbl.conditionId.list[i - 1]
                if conditionIDTemp ~= 0 and conditionTblMgr:IsMainPlayerMatchCondition(conditionIDTemp) == false then
                    return false, conditionIDTemp
                end
            end
        end
        return true
    end
    return false
end

---获取deliverID对应的选项名
---@private
---@param deliverID number
---@return string
function LeftMainMissionData_GuaJi:GetDeliverOptionName(deliverID)
    ---deliver表的ID
    ---@type TABLE.CFG_DELIVER
    local isTblExist, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(deliverID)
    if deliverTbl then
        ---@type TABLE.CFG_MAP
        local mapTbl
        isTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(deliverTbl.toMapId)
        if mapTbl then
            return mapTbl.name
        end
    end
    return ""
end
--endregion

--region Duplicate
---执行配置传送或者弹窗,type为1时执行
---@private
---@param duplicateID number deliver表的ID
---@param go UnityEngine.GameObject 按钮的GameObject
---@return number|nil 若返回一个number,表示传送失败,需要上层根据返回的conditionID进行处理
function LeftMainMissionData_GuaJi:DoDuplicate(duplicateID, go)
    local isAvailable, conditionID = self:IsDuplicateAvailable(duplicateID)
    if isAvailable then
        uimanager:ClosePanel("UILeftMainMissionPartSelectPanel")
        ---deliverID允许使用,直接向服务器请求传送并在之后开启自动战斗
        Utility.ReqEnterDuplicate(duplicateID)
        uiStaticParameter.SetOpenAutoFightAfterDeliver()
    else
        return conditionID
    end
end

---duplicateID是否可用
---@private
---@param duplicateID number
---@return boolean,number|nil
function LeftMainMissionData_GuaJi:IsDuplicateAvailable(duplicateID)
    --判断deliverID对应的地图是否可以进入
    local isExist
    ---@type TABLE.CFG_DUPLICATE
    local duplicateTbl
    isExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateID)
    if duplicateTbl ~= nil then
        ---@type Cfg_ConditionManager
        local conditionTblMgr = CS.Cfg_ConditionManager.Instance
        if duplicateTbl.condition ~= nil and duplicateTbl.condition ~= 0 then
            if conditionTblMgr:IsMainPlayerMatchCondition(duplicateTbl.condition) == false then
                return false, duplicateTbl.condition
            end
        end
        ---@type TABLE.CFG_MAP
        local mapTbl
        isExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(duplicateTbl.groupID)
        if mapTbl.conditionId ~= nil and mapTbl.conditionId.list ~= nil and mapTbl.conditionId.list.Count > 0 then
            for i = 1, mapTbl.conditionId.list.Count do
                local conditionIDTemp = mapTbl.conditionId.list[i - 1]
                if conditionIDTemp ~= 0 and conditionTblMgr:IsMainPlayerMatchCondition(conditionIDTemp) == false then
                    return false, conditionIDTemp
                end
            end
        end
        return true
    end
    return false
end

---获取deliverID对应的选项名
---@private
---@param duplicateID number
---@return string
function LeftMainMissionData_GuaJi:GetDuplicateOptionName(duplicateID)
    ---duplicate表的ID
    ---@type TABLE.CFG_DUPLICATE
    local isTblExist, duplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateID)
    if duplicateTbl then
        ---@type TABLE.CFG_MAP
        local mapTbl
        isTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(duplicateTbl.groupID)
        if mapTbl then
            return mapTbl.name
        end
    end
end
--endregion

---刷新UI
---@param template UIMissionInfoTemplates
function LeftMainMissionData_GuaJi:OnRefreshUI(template)
    template.task_type.spriteName = 'richang'
    template.bg2.spriteName = 'richangdise'
    template.lb_content.text = luaEnumColorType.White .. '推荐挂机地图'
    template:SetSize(template.lb_content, template.lb_content2, template.lb_content_target, template.lb_content_target2)
    template:BindClickEvent(function()
        self:OnOptionClicked(template)
    end)
end

return LeftMainMissionData_GuaJi