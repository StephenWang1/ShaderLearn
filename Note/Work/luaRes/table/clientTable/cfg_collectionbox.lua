--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_collectionbox
local cfg_collectionbox = {}

cfg_collectionbox.__index = cfg_collectionbox

function cfg_collectionbox:UUID()
    return self.level
end

---@return number 藏品阁等级#客户端  当前藏品阁等级
function cfg_collectionbox:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end

---@return number 升级所需经验#客户端  藏品阁升级所需经验
function cfg_collectionbox:GetRequired()
    if self.required ~= nil then
        return self.required
    else
        if self:CsTABLE() ~= nil then
            self.required = self:CsTABLE().required
            return self.required
        else
            return nil
        end
    end
end

---@return number 开启格子#客户端  藏品阁升级后开启格子的数量
function cfg_collectionbox:GetOpenBox()
    if self.openBox ~= nil then
        return self.openBox
    else
        if self:CsTABLE() ~= nil then
            self.openBox = self:CsTABLE().openBox
            return self.openBox
        else
            return nil
        end
    end
end

---@return number 基础生命#客户端  基础生命属性（万分比）
function cfg_collectionbox:GetHp()
    if self.hp ~= nil then
        return self.hp
    else
        if self:CsTABLE() ~= nil then
            self.hp = self:CsTABLE().hp
            return self.hp
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_COLLECTIONBOX C#中的数据结构
function cfg_collectionbox:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_collectionbox lua中的数据结构
function cfg_collectionbox:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.required = decodedData.required
    
    ---@private
    self.openBox = decodedData.openBox
    
    ---@private
    self.hp = decodedData.hp
end

return cfg_collectionbox