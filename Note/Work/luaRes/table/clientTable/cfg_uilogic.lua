--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_uilogic
local cfg_uilogic = {}

cfg_uilogic.__index = cfg_uilogic

function cfg_uilogic:UUID()
    return self.id
end

---@return number id#客户端  纯ID
function cfg_uilogic:GetId()
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

---@return string UI界面名#客户端  UI界面名，每一行都与其他行不一致
function cfg_uilogic:GetPanelName()
    if self.panelName ~= nil then
        return self.panelName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panelName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao UI界面关闭逻辑#客户端  UI界面的关闭逻辑ID集合，关联到cfg_uilogic_close表
function cfg_uilogic:GetCloseLogics()
    if self.closeLogics ~= nil then
        return self.closeLogics
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().closeLogics
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 缓冲设定#客户端  若UI界面为tips界面等需要等其他界面关闭后再显示消息的界面，则根据缓冲设定决定哪些界面存在时该界面会进入缓冲队列，关联到cfg_uilogic_caches表
function cfg_uilogic:GetCacheLogics()
    if self.cacheLogics ~= nil then
        return self.cacheLogics
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cacheLogics
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao UI界面隐藏逻辑#客户端  UI界面的隐藏逻辑ID集合，关联到cfg_uilogic_hide表
function cfg_uilogic:GetHideLogics()
    if self.hideLogics ~= nil then
        return self.hideLogics
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hideLogics
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_UILOGIC C#中的数据结构
function cfg_uilogic:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_uilogic lua中的数据结构
function cfg_uilogic:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.panelName = decodedData.panelName
    
    ---@private
    self.closeLogics = decodedData.closeLogics
    
    ---@private
    self.cacheLogics = decodedData.cacheLogics
    
    ---@private
    self.hideLogics = decodedData.hideLogics
end

return cfg_uilogic