--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_union_boss_rank
local cfg_union_boss_rank = {}

cfg_union_boss_rank.__index = cfg_union_boss_rank

function cfg_union_boss_rank:UUID()
    return self.id
end

---@return number id#客户端#C  id#客户端
function cfg_union_boss_rank:GetId()
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

---@return number 排行类型#客户端  1、个人排行   2、行会排行
function cfg_union_boss_rank:GetType()
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

---@return number 排名#客户端#不存在共同参与合并的字段  排名为0表示基础奖励
function cfg_union_boss_rank:GetRank()
    if self.rank ~= nil then
        return self.rank
    else
        if self:CsTABLE() ~= nil then
            self.rank = self:CsTABLE().rank
            return self.rank
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 奖励#客户端  排名奖励
function cfg_union_boss_rank:GetItem()
    if self.item ~= nil then
        return self.item
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().item
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_UNION_BOSS_RANK C#中的数据结构
function cfg_union_boss_rank:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_union_boss_rank lua中的数据结构
function cfg_union_boss_rank:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.rank = decodedData.rank
    
    ---@private
    self.item = decodedData.item
end

return cfg_union_boss_rank