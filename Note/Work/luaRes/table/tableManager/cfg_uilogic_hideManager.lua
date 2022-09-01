---@class cfg_uilogic_hideManager:TableManager
local cfg_uilogic_hideManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_uilogic_hide
function cfg_uilogic_hideManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_uilogic_hide> 遍历方法
function cfg_uilogic_hideManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_uilogic_hideManager:PostProcess()
end

---测试界面是否符合隐藏的条件,若符合隐藏条件,则返回true
---@param hideID number
---@param testingPanelName string
---@param layerInt number
---@return boolean
function cfg_uilogic_hideManager:IsPanelConformToHide(hideID, testingPanelName, layerInt)
    if testingPanelName == nil or testingPanelName == "" then
        return false
    end
    local tbl = self:TryGetValue(hideID)
    if tbl then
        if tbl:GetHideType() == 1 then
            ---隐藏列表为avoidSets的所有界面加上avoidPanelList所标识的界面
            if clientTableManager.cfg_uisetsManager:IsContainedInUISets(tbl:GetUisetsID(), testingPanelName, layerInt) then
                return true
            end
            if tbl:GetAvoidPanelList() ~= nil and tbl:GetAvoidPanelList().list ~= nil
                    and Utility.IsContainsValue(tbl:GetAvoidPanelList().list, testingPanelName) then
                return true
            end
        elseif tbl:GetHideType() == 2 then
            ---隐藏列表为从avoidSets界面中排除avoidPanelList所标识的界面后的所有界面
            if clientTableManager.cfg_uisetsManager:IsContainedInUISets(tbl:GetUisetsID(), testingPanelName, layerInt) then
                return ~Utility.IsContainsValue(tbl:GetAvoidPanelList().list, testingPanelName)
            else
                return true
            end
        end
    end
    return false
end

return cfg_uilogic_hideManager