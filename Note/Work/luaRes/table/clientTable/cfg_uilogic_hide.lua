--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_uilogic_hide
local cfg_uilogic_hide = {}

cfg_uilogic_hide.__index = cfg_uilogic_hide

function cfg_uilogic_hide:UUID()
    return self.id
end

---@return number id#客户端#不存在共同参与合并的字段  纯ID
function cfg_uilogic_hide:GetId()
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

---@return number 隐藏类型#客户端  1:隐藏列表为avoidSets的所有界面加上avoidPanelList所标识的界面;2:隐藏列表为从avoidSets界面中排除avoidPanelList所标识的界面后的所有界面
function cfg_uilogic_hide:GetHideType()
    if self.hideType ~= nil then
        return self.hideType
    else
        if self:CsTABLE() ~= nil then
            self.hideType = self:CsTABLE().hideType
            return self.hideType
        else
            return nil
        end
    end
end

---@return number 隐藏界面集合#客户端#不存在共同参与合并的字段  表示隐藏界面在哪些界面集合的基础上处理,关联到cfg_uisets表
function cfg_uilogic_hide:GetUisetsID()
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

---@return TABLE.StringList 隐藏界面列表#客户端  表示在隐藏界面集合的基础上加上或减去哪些界面列表
function cfg_uilogic_hide:GetAvoidPanelList()
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

--@return  TABLE.CFG_UILOGIC_HIDE C#中的数据结构
function cfg_uilogic_hide:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_uilogic_hide lua中的数据结构
function cfg_uilogic_hide:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.hideType = decodedData.hideType
    
    ---@private
    self.uisetsID = decodedData.uisetsID
    
    ---@private
    self.avoidPanelList = decodedData.avoidPanelList
end

return cfg_uilogic_hide