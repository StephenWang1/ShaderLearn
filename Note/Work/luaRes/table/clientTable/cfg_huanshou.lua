--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_huanshou
local cfg_huanshou = {}

cfg_huanshou.__index = cfg_huanshou

function cfg_huanshou:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  唯一ID
function cfg_huanshou:GetId()
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

---@return string 品质#客户端#C  共14阶（1白，2淡蓝，3黄，4嫩草绿，5紫红，6红，7天蓝，8浅蓝，9湖蓝，10淡紫，11次绛蓝，12绛蓝，13蓝）
function cfg_huanshou:GetQuality()
    if self.quality ~= nil then
        return self.quality
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().quality
        else
            return nil
        end
    end
end

---@return string 名字#客户端#C  名字
function cfg_huanshou:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return number 怪物id#客户端#C#不存在共同参与合并的字段
function cfg_huanshou:GetMonsterId()
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

---@return number 模型#客户端#C  灵兽模型
function cfg_huanshou:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            self.model = self:CsTABLE().model
            return self.model
        else
            return nil
        end
    end
end

---@return number 灵兽模型左右位置偏移量#客户端#C  对模型旋转中心轴进行左右（同时反向调整模型的X坐标位置），偏移量为0时则显示原位置
function cfg_huanshou:GetOffsetX()
    if self.offsetX ~= nil then
        return self.offsetX
    else
        if self:CsTABLE() ~= nil then
            self.offsetX = self:CsTABLE().offsetX
            return self.offsetX
        else
            return nil
        end
    end
end

---@return number 灵兽模型界面展示高度调整#客户端#C  对界面中模型展示的高度进行调整
function cfg_huanshou:GetY()
    if self.y ~= nil then
        return self.y
    else
        if self:CsTABLE() ~= nil then
            self.y = self:CsTABLE().y
            return self.y
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 不同类型词条系数#客户端#C  不同类型词条系数（神圣攻伤#神圣魔伤#神圣道伤#神圣物免#神圣魔免），万分比
function cfg_huanshou:GetEntryParam()
    if self.entryParam ~= nil then
        return self.entryParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().entryParam
        else
            return nil
        end
    end
end

---@return number 神圣防御资质#客户端#C  属性（万分比）
function cfg_huanshou:GetHolyDefenceQualifications()
    if self.holyDefenceQualifications ~= nil then
        return self.holyDefenceQualifications
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceQualifications = self:CsTABLE().holyDefenceQualifications
            return self.holyDefenceQualifications
        else
            return nil
        end
    end
end

---@return number 主类型_C
function cfg_huanshou:GetMainType()
    if self.mainType ~= nil then
        return self.mainType
    else
        if self:CsTABLE() ~= nil then
            self.mainType = self:CsTABLE().mainType
            return self.mainType
        else
            return nil
        end
    end
end
---@return number 灵兽类型_C
function cfg_huanshou:GetType()
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

---@return number 基础重量_C
function cfg_huanshou:GetWeight()
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
---@return number 死亡复活冷却时间_C
function cfg_huanshou:GetCallAgainCd()
    if self.callAgainCd ~= nil then
        return self.callAgainCd
    else
        if self:CsTABLE() ~= nil then
            self.callAgainCd = self:CsTABLE().callAgainCd
            return self.callAgainCd
        else
            return nil
        end
    end
end
---@return number 资质浮动id_C
function cfg_huanshou:GetFloatId()
    if self.floatId ~= nil then
        return self.floatId
    else
        if self:CsTABLE() ~= nil then
            self.floatId = self:CsTABLE().floatId
            return self.floatId
        else
            return nil
        end
    end
end

---@return number 灵兽模型比例_C
function cfg_huanshou:GetHsScale()
    if self.hsScale ~= nil then
        return self.hsScale
    else
        if self:CsTABLE() ~= nil then
            self.hsScale = self:CsTABLE().hsScale
            return self.hsScale
        else
            return nil
        end
    end
end
---@return number 血条位置_C
function cfg_huanshou:GetBloodY()
    if self.bloodY ~= nil then
        return self.bloodY
    else
        if self:CsTABLE() ~= nil then
            self.bloodY = self:CsTABLE().bloodY
            return self.bloodY
        else
            return nil
        end
    end
end
---@return number 生命资质_C
function cfg_huanshou:GetHpQualifications()
    if self.hpQualifications ~= nil then
        return self.hpQualifications
    else
        if self:CsTABLE() ~= nil then
            self.hpQualifications = self:CsTABLE().hpQualifications
            return self.hpQualifications
        else
            return nil
        end
    end
end

---@return number 攻击资质_C
function cfg_huanshou:GetAttackQualifications()
    if self.attackQualifications ~= nil then
        return self.attackQualifications
    else
        if self:CsTABLE() ~= nil then
            self.attackQualifications = self:CsTABLE().attackQualifications
            return self.attackQualifications
        else
            return nil
        end
    end
end
---@return number 物防资质_C
function cfg_huanshou:GetPhyDefenceQualifications()
    if self.phyDefenceQualifications ~= nil then
        return self.phyDefenceQualifications
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceQualifications = self:CsTABLE().phyDefenceQualifications
            return self.phyDefenceQualifications
        else
            return nil
        end
    end
end

---@return number 魔防资质_C
function cfg_huanshou:GetMagicDefenceQualifications()
    if self.magicDefenceQualifications ~= nil then
        return self.magicDefenceQualifications
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceQualifications = self:CsTABLE().magicDefenceQualifications
            return self.magicDefenceQualifications
        else
            return nil
        end
    end
end
---@return number 神圣攻击资质_C
function cfg_huanshou:GetHolyAttackQualifications()
    if self.holyAttackQualifications ~= nil then
        return self.holyAttackQualifications
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackQualifications = self:CsTABLE().holyAttackQualifications
            return self.holyAttackQualifications
        else
            return nil
        end
    end
end

---@return number 生命#客户端  属性值
function cfg_huanshou:GetMaxHp()
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

---@return number 最小攻击#客户端  属性值
function cfg_huanshou:GetPhyAttackMin()
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

---@return number 最大攻击#客户端  属性值
function cfg_huanshou:GetPhyAttackMax()
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

---@return number 最小魔法攻击#客户端  属性
function cfg_huanshou:GetMagicAttackMin()
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

---@return number 最大魔法攻击#客户端  属性
function cfg_huanshou:GetMagicAttackMax()
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

---@return number 最小道术攻击#客户端  属性
function cfg_huanshou:GetTaoAttackMin()
    if self.taoAttackMin ~= nil then
        return self.taoAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMin = self:CsTABLE().taoAttackMin
            return self.taoAttackMin
        else
            return nil
        end
    end
end

---@return number 最大道术攻击#客户端  属性
function cfg_huanshou:GetTaoAttackMax()
    if self.taoAttackMax ~= nil then
        return self.taoAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMax = self:CsTABLE().taoAttackMax
            return self.taoAttackMax
        else
            return nil
        end
    end
end

---@return number 最小物防#客户端  属性值
function cfg_huanshou:GetPhyDefenceMin()
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

---@return number 最大物防#客户端  属性值
function cfg_huanshou:GetPhyDefenceMax()
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

---@return number 最小魔防#客户端  属性值
function cfg_huanshou:GetMagicDefenceMin()
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

---@return number 最大魔防#客户端  属性值
function cfg_huanshou:GetMagicDefenceMax()
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

---@return number 神圣攻击下限#客户端  属性值
function cfg_huanshou:GetHolyAttackMin()
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

---@return number 神圣攻击上限#客户端  属性值
function cfg_huanshou:GetHolyAttackMax()
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

---@return number 神圣防御下限#客户端  属性值
function cfg_huanshou:GetHolyDefenceMin()
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

---@return number 神圣防御上限#客户端  属性值
function cfg_huanshou:GetHolyDefenceMax()
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

---@return number 生命恢复#客户端  属性值(3秒回复1次)
function cfg_huanshou:GetHpRecover()
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

---@return number 闪避#客户端  属性值
function cfg_huanshou:GetDodge()
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

---@return number 准确#客户端  属性值
function cfg_huanshou:GetAccurate()
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

--@return  TABLE.CFG_HUANSHOU C#中的数据结构
function cfg_huanshou:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_ServantTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_huanshou lua中的数据结构
function cfg_huanshou:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.maxHp = decodedData.maxHp
    
    ---@private
    self.phyAttackMin = decodedData.phyAttackMin
    
    ---@private
    self.phyAttackMax = decodedData.phyAttackMax
    
    ---@private
    self.magicAttackMin = decodedData.magicAttackMin
    
    ---@private
    self.magicAttackMax = decodedData.magicAttackMax
    
    ---@private
    self.taoAttackMin = decodedData.taoAttackMin
    
    ---@private
    self.taoAttackMax = decodedData.taoAttackMax
    
    ---@private
    self.phyDefenceMin = decodedData.phyDefenceMin
    
    ---@private
    self.phyDefenceMax = decodedData.phyDefenceMax
    
    ---@private
    self.magicDefenceMin = decodedData.magicDefenceMin
    
    ---@private
    self.magicDefenceMax = decodedData.magicDefenceMax
    
    ---@private
    self.holyAttackMin = decodedData.holyAttackMin
    
    ---@private
    self.holyAttackMax = decodedData.holyAttackMax
    
    ---@private
    self.holyDefenceMin = decodedData.holyDefenceMin
    
    ---@private
    self.holyDefenceMax = decodedData.holyDefenceMax
    
    ---@private
    self.hpRecover = decodedData.hpRecover
    
    ---@private
    self.dodge = decodedData.dodge
    
    ---@private
    self.accurate = decodedData.accurate
end

return cfg_huanshou