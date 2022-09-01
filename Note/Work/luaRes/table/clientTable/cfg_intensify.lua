--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_intensify
local cfg_intensify = {}

cfg_intensify.__index = cfg_intensify

function cfg_intensify:UUID()
    return self.lv
end

---@return number 等级#客户端#C#不存在共同参与合并的字段  强化等级
function cfg_intensify:GetLv()
    if self.lv ~= nil then
        return self.lv
    else
        if self:CsTABLE() ~= nil then
            self.lv = self:CsTABLE().lv
            return self.lv
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 普通道具种类及对应的数量#客户端#C  强化消耗物品#数量#概率&物品#数量#概率，可消耗各种黑铁矿不同概率 &分割不同的物品
function cfg_intensify:GetConsume()
    if self.consume ~= nil then
        return self.consume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().consume
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 攻击下限#客户端#C  套装属性，123表示战士法师道士
function cfg_intensify:GetAttTaoMin()
    if self.attTaoMin ~= nil then
        return self.attTaoMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attTaoMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 攻击上限#客户端#C  套装属性，高级套装直接覆盖低级套装
function cfg_intensify:GetAttTaoMax()
    if self.attTaoMax ~= nil then
        return self.attTaoMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attTaoMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 生命#客户端#C  套装属性
function cfg_intensify:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().maxHp
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 物防下限#客户端#C  套装属性
function cfg_intensify:GetPhyDefenceMin()
    if self.phyDefenceMin ~= nil then
        return self.phyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 物防上限#客户端#C  套装属性
function cfg_intensify:GetPhyDefenceMax()
    if self.phyDefenceMax ~= nil then
        return self.phyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefenceMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 魔防下线#客户端#C  套装属性
function cfg_intensify:GetMagicDefenceMin()
    if self.magicDefenceMin ~= nil then
        return self.magicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 魔防上限#客户端#C  套装属性
function cfg_intensify:GetMagicDefenceMax()
    if self.magicDefenceMax ~= nil then
        return self.magicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefenceMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 装备强化等级转移需要消耗的道具种类及数量#客户端#C  消耗的道具种类及对应的数量
function cfg_intensify:GetTransferResource()
    if self.transferResource ~= nil then
        return self.transferResource
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().transferResource
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升星发光特效RGB#客户端#C  R#G#B#A
function cfg_intensify:GetEffectColor()
    if self.effectColor ~= nil then
        return self.effectColor
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectColor
        else
            return nil
        end
    end
end

---@return string 升星发光特效速度#客户端#C  X#Y#Z#W
function cfg_intensify:GetEffectSpeed()
    if self.effectSpeed ~= nil then
        return self.effectSpeed
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectSpeed
        else
            return nil
        end
    end
end

---@return number 装备类型_C
function cfg_intensify:GetType()
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
---@return number 攻击力上限数值_C
function cfg_intensify:GetAttAdd()
    if self.attAdd ~= nil then
        return self.attAdd
    else
        if self:CsTABLE() ~= nil then
            self.attAdd = self:CsTABLE().attAdd
            return self.attAdd
        else
            return nil
        end
    end
end
---@return number 升星发光特效亮度_C
function cfg_intensify:GetEffectLuminance()
    if self.effectLuminance ~= nil then
        return self.effectLuminance
    else
        if self:CsTABLE() ~= nil then
            self.effectLuminance = self:CsTABLE().effectLuminance
            return self.effectLuminance
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_INTENSIFY C#中的数据结构
function cfg_intensify:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_IntensifyTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_intensify lua中的数据结构
function cfg_intensify:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.lv = decodedData.lv
end

return cfg_intensify