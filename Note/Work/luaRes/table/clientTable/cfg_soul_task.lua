--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_soul_task
local cfg_soul_task = {}

cfg_soul_task.__index = cfg_soul_task

function cfg_soul_task:UUID()
    return self.id
end

---@return number id#客户端#C  编号
function cfg_soul_task:GetId()
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

---@return number 任务类型#客户端  对应任务类型（1.绿色灵魂、2.黄色灵魂、3蓝色灵魂、4.紫色灵魂、5.红色灵魂）
function cfg_soul_task:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end

---@return number 灵魂道具ID#客户端  需要提交的灵魂道具ID
function cfg_soul_task:GetItemId()
    if self.itemId ~= nil then
        return self.itemId
    else
        if self:CsTABLE() ~= nil then
            self.itemId = self:CsTABLE().itemId
            return self.itemId
        else
            return nil
        end
    end
end

---@return number 跳转页签#客户端  跳转的jumpid
function cfg_soul_task:GetJumpId()
    if self.jumpId ~= nil then
        return self.jumpId
    else
        if self:CsTABLE() ~= nil then
            self.jumpId = self:CsTABLE().jumpId
            return self.jumpId
        else
            return nil
        end
    end
end

---@return string 文本描述#客户端  目标怪物文本描述
function cfg_soul_task:GetDes()
    if self.des ~= nil then
        return self.des
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().des
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SOUL_TASK C#中的数据结构
function cfg_soul_task:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_soul_task lua中的数据结构
function cfg_soul_task:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.itemId = decodedData.itemId
    
    ---@private
    self.jumpId = decodedData.jumpId
    
    ---@private
    self.des = decodedData.des
end

return cfg_soul_task