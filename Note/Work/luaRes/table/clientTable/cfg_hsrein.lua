--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_hsrein
local cfg_hsrein = {}

cfg_hsrein.__index = cfg_hsrein

function cfg_hsrein:UUID()
    return self.id
end

---@return number id#客户端#C  id不能动，动需要跟服务器说
function cfg_hsrein:GetId()
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

---@return number 需要灵力#客户端#C#不存在共同参与合并的字段  转生所需灵力
function cfg_hsrein:GetNeedSoul()
    if self.needSoul ~= nil then
        return self.needSoul
    else
        if self:CsTABLE() ~= nil then
            self.needSoul = self:CsTABLE().needSoul
            return self.needSoul
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 需要灵石#客户端#C  转生所需神石
function cfg_hsrein:GetNeedStone()
    if self.needStone ~= nil then
        return self.needStone
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().needStone
        else
            return nil
        end
    end
end

---@return number 生命#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            self.maxHp = self:CsTABLE().maxHp
            return self.maxHp
        else
            return nil
        end
    end
end

---@return number 最小攻击#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetPhyAttackMin()
    if self.phyAttackMin ~= nil then
        return self.phyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMin = self:CsTABLE().phyAttackMin
            return self.phyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大攻击#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetPhyAttackMax()
    if self.phyAttackMax ~= nil then
        return self.phyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMax = self:CsTABLE().phyAttackMax
            return self.phyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小魔法攻击#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetMagicAttackMin()
    if self.magicAttackMin ~= nil then
        return self.magicAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMin = self:CsTABLE().magicAttackMin
            return self.magicAttackMin
        else
            return nil
        end
    end
end

---@return number 最大魔法攻击#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetMagicAttackMax()
    if self.magicAttackMax ~= nil then
        return self.magicAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMax = self:CsTABLE().magicAttackMax
            return self.magicAttackMax
        else
            return nil
        end
    end
end

---@return number 最小物防#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetPhyDefenceMin()
    if self.phyDefenceMin ~= nil then
        return self.phyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMin = self:CsTABLE().phyDefenceMin
            return self.phyDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大物防#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetPhyDefenceMax()
    if self.phyDefenceMax ~= nil then
        return self.phyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMax = self:CsTABLE().phyDefenceMax
            return self.phyDefenceMax
        else
            return nil
        end
    end
end

---@return number 最小魔防#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetMagicDefenceMin()
    if self.magicDefenceMin ~= nil then
        return self.magicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMin = self:CsTABLE().magicDefenceMin
            return self.magicDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大魔防#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetMagicDefenceMax()
    if self.magicDefenceMax ~= nil then
        return self.magicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMax = self:CsTABLE().magicDefenceMax
            return self.magicDefenceMax
        else
            return nil
        end
    end
end

---@return number 神圣攻击下限#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetHolyAttackMin()
    if self.holyAttackMin ~= nil then
        return self.holyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMin = self:CsTABLE().holyAttackMin
            return self.holyAttackMin
        else
            return nil
        end
    end
end

---@return number 神圣攻击上限#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetHolyAttackMax()
    if self.holyAttackMax ~= nil then
        return self.holyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMax = self:CsTABLE().holyAttackMax
            return self.holyAttackMax
        else
            return nil
        end
    end
end

---@return number 神圣防御下限#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetHolyDefenceMin()
    if self.holyDefenceMin ~= nil then
        return self.holyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMin = self:CsTABLE().holyDefenceMin
            return self.holyDefenceMin
        else
            return nil
        end
    end
end

---@return number 神圣防御上限#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetHolyDefenceMax()
    if self.holyDefenceMax ~= nil then
        return self.holyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMax = self:CsTABLE().holyDefenceMax
            return self.holyDefenceMax
        else
            return nil
        end
    end
end

---@return number 生命恢复#客户端#C#不存在共同参与合并的字段  属性值
function cfg_hsrein:GetHpRecover()
    if self.hpRecover ~= nil then
        return self.hpRecover
    else
        if self:CsTABLE() ~= nil then
            self.hpRecover = self:CsTABLE().hpRecover
            return self.hpRecover
        else
            return nil
        end
    end
end

---@return number 转生等级_C
function cfg_hsrein:GetLevel()
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
---@return number 转生所需灵兽等级_C
function cfg_hsrein:GetNeedLevel()
    if self.needLevel ~= nil then
        return self.needLevel
    else
        if self:CsTABLE() ~= nil then
            self.needLevel = self:CsTABLE().needLevel
            return self.needLevel
        else
            return nil
        end
    end
end

---@return number 麻痹概率_C
function cfg_hsrein:GetMb()
    if self.mb ~= nil then
        return self.mb
    else
        if self:CsTABLE() ~= nil then
            self.mb = self:CsTABLE().mb
            return self.mb
        else
            return nil
        end
    end
end
---@return number 闪避_C
function cfg_hsrein:GetDodge()
    if self.dodge ~= nil then
        return self.dodge
    else
        if self:CsTABLE() ~= nil then
            self.dodge = self:CsTABLE().dodge
            return self.dodge
        else
            return nil
        end
    end
end

---@return number 准确_C
function cfg_hsrein:GetAccurate()
    if self.accurate ~= nil then
        return self.accurate
    else
        if self:CsTABLE() ~= nil then
            self.accurate = self:CsTABLE().accurate
            return self.accurate
        else
            return nil
        end
    end
end
---@return number 基础重量_C
function cfg_hsrein:GetWeight()
    if self.weight ~= nil then
        return self.weight
    else
        if self:CsTABLE() ~= nil then
            self.weight = self:CsTABLE().weight
            return self.weight
        else
            return nil
        end
    end
end

---@return number 转生八门#客户端
function cfg_hsrein:GetEightDoor()
    if self.eightDoor ~= nil then
        return self.eightDoor
    else
        if self:CsTABLE() ~= nil then
            self.eightDoor = self:CsTABLE().eightDoor
            return self.eightDoor
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_HSREIN C#中的数据结构
function cfg_hsrein:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_HsReinTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_hsrein lua中的数据结构
function cfg_hsrein:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.eightDoor = decodedData.eightDoor
end

return cfg_hsrein