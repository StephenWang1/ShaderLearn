---@class cfg_uilogic_cachesManager:TableManager
local cfg_uilogic_cachesManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_uilogic_caches
function cfg_uilogic_cachesManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_uilogic_caches> 遍历方法
function cfg_uilogic_cachesManager:ForPair(action)
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
function cfg_uilogic_cachesManager:PostProcess()
end

---测试界面是否符合缓冲的条件,若符合缓冲条件,则返回true
---@param cacheID number
---@param testingPanelName string
---@param layerInt number
---@return boolean
function cfg_uilogic_cachesManager:IsPanelConformToCache(cacheID, testingPanelName, layerInt)
    if (testingPanelName == nil or testingPanelName == "") then
        return false;
    end
    local tbl = self:TryGetValue(cacheID)
    if tbl:GetCacheType() == 1 then
        ---缓冲列表为avoidSets的所有界面加上avoidPanelList所标识的界面
        if clientTableManager.cfg_uisetsManager:IsContainedInUISets(tbl:GetUisetsID(), testingPanelName, layerInt) then
            return true
        end
        if tbl:GetAvoidPanelList() ~= nil and tbl:GetAvoidPanelList().list ~= nil
                and Utility.IsContainsValue(tbl:GetAvoidPanelList().list, testingPanelName) then
            return true
        end
    elseif tbl:GetCacheType() == 2 then
        ---缓冲列表为从avoidSets界面中排除avoidPanelList所标识的界面后的所有界面
        if clientTableManager.cfg_uisetsManager:IsContainedInUISets(tbl:GetUisetsID(), testingPanelName, layerInt) then
            if tbl:GetAvoidPanelList() ~= nil and tbl:GetAvoidPanelList().list ~= nil then
                return ~Utility.IsContainsValue(tbl:GetAvoidPanelList().list, testingPanelName)
            else
                return true
            end
        end
    end
    return false
end

return cfg_uilogic_cachesManager