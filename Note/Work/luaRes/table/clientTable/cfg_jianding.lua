--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_jianding
local cfg_jianding = {}

cfg_jianding.__index = cfg_jianding

function cfg_jianding:UUID()
    return self.id
end

---@return number 唯一id#客户端  唯一id
function cfg_jianding:GetId()
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

---@return number 鉴定类型#客户端  1、普通鉴定，2、稀有鉴定，3、完美鉴定
function cfg_jianding:GetType()
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

---@return TABLE.IntListJingHao 良品切割属性区间#客户端  良品：区间上限#区间下限
function cfg_jianding:GetAttribute1()
    if self.attribute1 ~= nil then
        return self.attribute1
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute1
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 精品切割属性区间#客户端  精品：区间上限#区间下限
function cfg_jianding:GetAttribute2()
    if self.attribute2 ~= nil then
        return self.attribute2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute2
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 稀有切割属性区间#客户端  稀有：区间上限#区间下限
function cfg_jianding:GetAttribute3()
    if self.attribute3 ~= nil then
        return self.attribute3
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute3
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 罕见切割属性区间#客户端  罕见：区间上限#区间下限
function cfg_jianding:GetAttribute4()
    if self.attribute4 ~= nil then
        return self.attribute4
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute4
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 完美切割属性区间#客户端  完美：区间上限#区间下限
function cfg_jianding:GetAttribute5()
    if self.attribute5 ~= nil then
        return self.attribute5
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute5
        else
            return nil
        end
    end
end

---@return string 普通鉴定价格#客户端  普通鉴定所需道具id#数量
function cfg_jianding:GetNormalConsume()
    if self.normalConsume ~= nil then
        return self.normalConsume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().normalConsume
        else
            return nil
        end
    end
end

---@return string 稀有鉴定价格#客户端  稀有鉴定所需道具id#数量
function cfg_jianding:GetRareConsume()
    if self.rareConsume ~= nil then
        return self.rareConsume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rareConsume
        else
            return nil
        end
    end
end

---@return string 完美鉴定价格#客户端  完美鉴定所需道具id#数量
function cfg_jianding:GetPerfectConsume()
    if self.perfectConsume ~= nil then
        return self.perfectConsume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().perfectConsume
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_JIANDING C#中的数据结构
function cfg_jianding:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_jianding lua中的数据结构
function cfg_jianding:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.attribute1 = decodedData.attribute1
    
    ---@private
    self.attribute2 = decodedData.attribute2
    
    ---@private
    self.attribute3 = decodedData.attribute3
    
    ---@private
    self.attribute4 = decodedData.attribute4
    
    ---@private
    self.attribute5 = decodedData.attribute5
    
    ---@private
    self.normalConsume = decodedData.normalConsume
    
    ---@private
    self.rareConsume = decodedData.rareConsume
    
    ---@private
    self.perfectConsume = decodedData.perfectConsume
end

return cfg_jianding