--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_demon_boss
local cfg_demon_boss = {}

cfg_demon_boss.__index = cfg_demon_boss

function cfg_demon_boss:UUID()
    return self.id
end

---@return number 怪物id#客户端  魔之BOSSid，索引到monster表
function cfg_demon_boss:GetId()
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

---@return number 回满血时间#客户端  受到攻击后，回满血的时间  单位秒
function cfg_demon_boss:GetReFullTime()
    if self.reFullTime ~= nil then
        return self.reFullTime
    else
        if self:CsTABLE() ~= nil then
            self.reFullTime = self:CsTABLE().reFullTime
            return self.reFullTime
        else
            return nil
        end
    end
end

---@return number 可造成伤害的限制#客户端  可造成伤害的限制类型  1  全身装备转生等级达到需求 2任一灵兽转生达到需求
function cfg_demon_boss:GetHurtType()
    if self.hurtType ~= nil then
        return self.hurtType
    else
        if self:CsTABLE() ~= nil then
            self.hurtType = self:CsTABLE().hurtType
            return self.hurtType
        else
            return nil
        end
    end
end

---@return string 限制参数#客户端  type为1  转生等级#等级  2 灵兽转生等级
function cfg_demon_boss:GetHurtParam()
    if self.hurtParam ~= nil then
        return self.hurtParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hurtParam
        else
            return nil
        end
    end
end

---@return string 是否达到标准#客户端  根据是否可对怪物造成伤害   可以#不可以
function cfg_demon_boss:GetDes()
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

---@return string 限制额外参数#客户端  type为1  人物装备位  id#id  2 灵兽位 id#id
function cfg_demon_boss:GetHurtParamExtra()
    if self.hurtParamExtra ~= nil then
        return self.hurtParamExtra
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hurtParamExtra
        else
            return nil
        end
    end
end

---@return number 怪物种类#客户端  怪物种类  1 装备 2 宝饰 3 技能 4灵兽
function cfg_demon_boss:GetDropType()
    if self.dropType ~= nil then
        return self.dropType
    else
        if self:CsTABLE() ~= nil then
            self.dropType = self:CsTABLE().dropType
            return self.dropType
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 击杀专属奖励#客户端  道具id#道具数量#职业（1 战士 2法师 3道士 0通用）#是否显示概率  1显示 0不显示&道具id#道具数量#职业（1 战士 2法师 3道士）#是否显示概率  1显示 0不显示    纯显示字段
function cfg_demon_boss:GetKillReward()
    if self.killReward ~= nil then
        return self.killReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().killReward
        else
            return nil
        end
    end
end

---@return number 定位条件#客户端  定位条件，配置的为condition表中条件
function cfg_demon_boss:GetChooseCondition()
    if self.chooseCondition ~= nil then
        return self.chooseCondition
    else
        if self:CsTABLE() ~= nil then
            self.chooseCondition = self:CsTABLE().chooseCondition
            return self.chooseCondition
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DEMON_BOSS C#中的数据结构
function cfg_demon_boss:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_demon_boss lua中的数据结构
function cfg_demon_boss:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.reFullTime = decodedData.reFullTime
    
    ---@private
    self.hurtType = decodedData.hurtType
    
    ---@private
    self.hurtParam = decodedData.hurtParam
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.hurtParamExtra = decodedData.hurtParamExtra
    
    ---@private
    self.dropType = decodedData.dropType
    
    ---@private
    self.killReward = decodedData.killReward
    
    ---@private
    self.chooseCondition = decodedData.chooseCondition
end

return cfg_demon_boss