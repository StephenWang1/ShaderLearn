--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_animals_boss
local cfg_animals_boss = {}

cfg_animals_boss.__index = cfg_animals_boss

function cfg_animals_boss:UUID()
    return self.monsterId
end

---@return number 怪物id#客户端#C#不存在共同参与合并的字段  十二生肖小怪怪物id
function cfg_animals_boss:GetMonsterId()
    if self.monsterId ~= nil then
        return self.monsterId
    else
        if self:CsTABLE() ~= nil then
            self.monsterId = self:CsTABLE().monsterId
            return self.monsterId
        else
            return nil
        end
    end
end

---@return number boss怪物id#客户端#C#不存在共同参与合并的字段  十二生肖boss怪物id
function cfg_animals_boss:GetBossId()
    if self.bossId ~= nil then
        return self.bossId
    else
        if self:CsTABLE() ~= nil then
            self.bossId = self:CsTABLE().bossId
            return self.bossId
        else
            return nil
        end
    end
end

---@return number 掉落展示#客户端#C#不存在共同参与合并的字段  掉落展示，连接到drop_show表格 id
function cfg_animals_boss:GetDropShowId()
    if self.dropShowId ~= nil then
        return self.dropShowId
    else
        if self:CsTABLE() ~= nil then
            self.dropShowId = self:CsTABLE().dropShowId
            return self.dropShowId
        else
            return nil
        end
    end
end

---@return string 怪物描述#客户端#C  怪物描述#客户端
function cfg_animals_boss:GetDescription()
    if self.description ~= nil then
        return self.description
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().description
        else
            return nil
        end
    end
end

---@return string 需求灵兽等级描述#客户端#C  需求灵兽等级描述
function cfg_animals_boss:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().level
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 灵兽攻击限制#客户端#C  等级#转生等级
function cfg_animals_boss:GetConditionLevel()
    if self.conditionLevel ~= nil then
        return self.conditionLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionLevel
        else
            return nil
        end
    end
end

---@return number 进入人数限制_C
function cfg_animals_boss:GetNumberLimit()
    if self.numberLimit ~= nil then
        return self.numberLimit
    else
        if self:CsTABLE() ~= nil then
            self.numberLimit = self:CsTABLE().numberLimit
            return self.numberLimit
        else
            return nil
        end
    end
end
---@return number 怪物死亡出现npcid_C
function cfg_animals_boss:GetNpcId()
    if self.npcId ~= nil then
        return self.npcId
    else
        if self:CsTABLE() ~= nil then
            self.npcId = self:CsTABLE().npcId
            return self.npcId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 人物攻击限制#客户端  人物伤害根据满足对应灵兽等级只数调整对应万分比伤害 人物最终伤害=满足只数比例*人物原本伤害 0只满足#1只满足#2只满足#3只满足，填0的时候表示扣1血
function cfg_animals_boss:GetConditionRoleLevel()
    if self.conditionRoleLevel ~= nil then
        return self.conditionRoleLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionRoleLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ANIMALS_BOSS C#中的数据结构
function cfg_animals_boss:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_AnimalBossManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_animals_boss lua中的数据结构
function cfg_animals_boss:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.monsterId = decodedData.monsterId
    
    ---@private
    self.conditionRoleLevel = decodedData.conditionRoleLevel
end

return cfg_animals_boss