--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_uilogic_caches
local cfg_uilogic_caches = {}

cfg_uilogic_caches.__index = cfg_uilogic_caches

function cfg_uilogic_caches:UUID()
    return self.id
end

---@return number id#客户端#不存在共同参与合并的字段  纯ID
function cfg_uilogic_caches:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return number 缓冲等待类型#客户端  1:缓冲列表为avoidSets的所有界面加上avoidPanelList所标识的界面;2:缓冲列表为从avoidSets界面中排除avoidPanelList所标识的界面后的所有界面
function cfg_uilogic_caches:GetCacheType()
    if self.cacheType ~= nil then
        return self.cacheType
    else
        if self:CsTABLE() ~= nil then
            self.cacheType = self:CsTABLE().cacheType
            return self.cacheType
        else
            return nil
        end
    end
end

---@return number 规避界面集合#客户端#不存在共同参与合并的字段  表示规避界面在哪些界面集合的基础上处理,关联到cfg_uisets表
function cfg_uilogic_caches:GetUisetsID()
    if self.uisetsID ~= nil then
        return self.uisetsID
    else
        if self:CsTABLE() ~= nil then
            self.uisetsID = self:CsTABLE().uisetsID
            return self.uisetsID
        else
            return nil
        end
    end
end

---@return TABLE.StringList 规避界面列表#客户端  表示在规避界面集合的基础上加上或减去哪些界面列表
function cfg_uilogic_caches:GetAvoidPanelList()
    if self.avoidPanelList ~= nil then
        return self.avoidPanelList
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().avoidPanelList
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_UILOGIC_CACHES C#中的数据结构
function cfg_uilogic_caches:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_uilogic_caches lua中的数据结构
function cfg_uilogic_caches:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.cacheType = decodedData.cacheType
    
    ---@private
    self.uisetsID = decodedData.uisetsID
    
    ---@private
    self.avoidPanelList = decodedData.avoidPanelList
end

return cfg_uilogic_caches