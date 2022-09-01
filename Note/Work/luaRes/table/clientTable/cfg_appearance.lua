--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_appearance
local cfg_appearance = {}

cfg_appearance.__index = cfg_appearance

function cfg_appearance:UUID()
    return self.id
end

---@return number id#客户端#C  id
function cfg_appearance:GetId()
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

---@return number 外观类型#客户端#C  外观类型：1 武器 2头盔 3 衣服 4 翅 膀 5 称号
function cfg_appearance:GetType()
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

---@return string 外观名#客户端#C  外观名
function cfg_appearance:GetName()
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

---@return number 品质#客户端#C  品质，与道具品质颜色一致 1白，2淡蓝，3黄，4嫩草绿，5紫红，6红，7天蓝，8浅蓝，9湖蓝，10淡紫，11次绛蓝，12绛蓝，13蓝
function cfg_appearance:GetQuality()
    if self.quality ~= nil then
        return self.quality
    else
        if self:CsTABLE() ~= nil then
            self.quality = self:CsTABLE().quality
            return self.quality
        else
            return nil
        end
    end
end

---@return number iconid#客户端#C  iconid
function cfg_appearance:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            self.icon = self:CsTABLE().icon
            return self.icon
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 模型id#客户端#C  模型id  填2个时 男性#女性
function cfg_appearance:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().model
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  物攻下限
function cfg_appearance:GetPhyAttMin()
    if self.phyAttMin ~= nil then
        return self.phyAttMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttMin = self:CsTABLE().phyAttMin
            return self.phyAttMin
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  物攻上限
function cfg_appearance:GetPhyAttMax()
    if self.phyAttMax ~= nil then
        return self.phyAttMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttMax = self:CsTABLE().phyAttMax
            return self.phyAttMax
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  魔攻下限
function cfg_appearance:GetMagicAttMin()
    if self.magicAttMin ~= nil then
        return self.magicAttMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttMin = self:CsTABLE().magicAttMin
            return self.magicAttMin
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  魔攻上限
function cfg_appearance:GetMagicAttMax()
    if self.magicAttMax ~= nil then
        return self.magicAttMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttMax = self:CsTABLE().magicAttMax
            return self.magicAttMax
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  道术下限
function cfg_appearance:GetMonkAttMin()
    if self.monkAttMin ~= nil then
        return self.monkAttMin
    else
        if self:CsTABLE() ~= nil then
            self.monkAttMin = self:CsTABLE().monkAttMin
            return self.monkAttMin
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  道术上限
function cfg_appearance:GetMonkAttMax()
    if self.monkAttMax ~= nil then
        return self.monkAttMax
    else
        if self:CsTABLE() ~= nil then
            self.monkAttMax = self:CsTABLE().monkAttMax
            return self.monkAttMax
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  物防下限
function cfg_appearance:GetPhyDenMin()
    if self.phyDenMin ~= nil then
        return self.phyDenMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDenMin = self:CsTABLE().phyDenMin
            return self.phyDenMin
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  物防上限
function cfg_appearance:GetPhyDenMax()
    if self.phyDenMax ~= nil then
        return self.phyDenMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDenMax = self:CsTABLE().phyDenMax
            return self.phyDenMax
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  魔防下限
function cfg_appearance:GetMagicDenMin()
    if self.magicDenMin ~= nil then
        return self.magicDenMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDenMin = self:CsTABLE().magicDenMin
            return self.magicDenMin
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  魔防上限
function cfg_appearance:GetMagicDenMax()
    if self.magicDenMax ~= nil then
        return self.magicDenMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDenMax = self:CsTABLE().magicDenMax
            return self.magicDenMax
        else
            return nil
        end
    end
end

---@return number 属性加成#客户端#C  血量
function cfg_appearance:GetBlood()
    if self.blood ~= nil then
        return self.blood
    else
        if self:CsTABLE() ~= nil then
            self.blood = self:CsTABLE().blood
            return self.blood
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 时间限制#客户端#C  时间限制 时间限制类型#参数  1 小时
function cfg_appearance:GetTimeLimit()
    if self.timeLimit ~= nil then
        return self.timeLimit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().timeLimit
        else
            return nil
        end
    end
end

---@return number conditionid#客户端#C  conditionid 不填则没有条件  填写的话 则使用外观道具时，及启用外观时需检测相应条件
function cfg_appearance:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return number 对BOSS伤害#客户端  对BOSS伤害，万分数
function cfg_appearance:GetMonsterHurtAdd()
    if self.monsterHurtAdd ~= nil then
        return self.monsterHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.monsterHurtAdd = self:CsTABLE().monsterHurtAdd
            return self.monsterHurtAdd
        else
            return nil
        end
    end
end

---@return number 掉宝率#客户端  掉宝率  十万分数
function cfg_appearance:GetAddDropTreasure()
    if self.addDropTreasure ~= nil then
        return self.addDropTreasure
    else
        if self:CsTABLE() ~= nil then
            self.addDropTreasure = self:CsTABLE().addDropTreasure
            return self.addDropTreasure
        else
            return nil
        end
    end
end

---@return string 外观效果说明#客户端  描述
function cfg_appearance:GetTxt()
    if self.txt ~= nil then
        return self.txt
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().txt
        else
            return nil
        end
    end
end

---@return number 转性对应时装id#客户端  转性后对应的时装id，填写需要转变的时装id
function cfg_appearance:GetChangeId()
    if self.changeId ~= nil then
        return self.changeId
    else
        if self:CsTABLE() ~= nil then
            self.changeId = self:CsTABLE().changeId
            return self.changeId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_APPEARANCE C#中的数据结构
function cfg_appearance:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_AppearanceTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_appearance lua中的数据结构
function cfg_appearance:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.monsterHurtAdd = decodedData.monsterHurtAdd
    
    ---@private
    self.addDropTreasure = decodedData.addDropTreasure
    
    ---@private
    self.txt = decodedData.txt
    
    ---@private
    self.changeId = decodedData.changeId
end

return cfg_appearance