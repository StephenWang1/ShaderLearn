--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_time_clock
local cfg_time_clock = {}

cfg_time_clock.__index = cfg_time_clock

function cfg_time_clock:UUID()
    return self.id
end

---@return number id#客户端#不存在共同参与合并的字段  程序唯一标识，服务器说啥配啥
function cfg_time_clock:GetId()
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

---@return number type#客户端#不存在共同参与合并的字段  相同的图片与倒计时组合方式为同一类型 ;类型1，图片后跟倒计时
function cfg_time_clock:GetType()
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

---@return string 参数#客户端  类型1，资源id
function cfg_time_clock:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

---@return number 倒计时#客户端  倒计时时长，秒
function cfg_time_clock:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            self.time = self:CsTABLE().time
            return self.time
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_TIME_CLOCK C#中的数据结构
function cfg_time_clock:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_time_clock lua中的数据结构
function cfg_time_clock:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.parameter = decodedData.parameter
    
    ---@private
    self.time = decodedData.time
end

return cfg_time_clock