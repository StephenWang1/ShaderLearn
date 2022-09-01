--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_title
local cfg_title = {}

cfg_title.__index = cfg_title

function cfg_title:UUID()
    return self.id
end

---@return number ID#客户端#C  ID#客户端
function cfg_title:GetId()
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

---@return string 称号名称#客户端#C
function cfg_title:GetTitleName()
    if self.titleName ~= nil then
        return self.titleName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().titleName
        else
            return nil
        end
    end
end

---@return number 界面排序#客户端#C
function cfg_title:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end

---@return string 图片与模型#客户端#C
function cfg_title:GetModel()
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

---@return number 同组称号#客户端#C  保留ID最大
function cfg_title:GetGroup()
    if self.group ~= nil then
        return self.group
    else
        if self:CsTABLE() ~= nil then
            self.group = self:CsTABLE().group
            return self.group
        else
            return nil
        end
    end
end

---@return number 对玩家造成伤害增加#客户端#C#不存在共同参与合并的字段
function cfg_title:GetPkAtt()
    if self.pkAtt ~= nil then
        return self.pkAtt
    else
        if self:CsTABLE() ~= nil then
            self.pkAtt = self:CsTABLE().pkAtt
            return self.pkAtt
        else
            return nil
        end
    end
end

---@return number 受到玩家伤害减少#客户端#C#不存在共同参与合并的字段
function cfg_title:GetPkDef()
    if self.pkDef ~= nil then
        return self.pkDef
    else
        if self:CsTABLE() ~= nil then
            self.pkDef = self:CsTABLE().pkDef
            return self.pkDef
        else
            return nil
        end
    end
end

---@return string 描述#客户端#C
function cfg_title:GetDes()
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

---@return string 职业条件#客户端#C
function cfg_title:GetCareer()
    if self.career ~= nil then
        return self.career
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().career
        else
            return nil
        end
    end
end

---@return string 持续时间#客户端#C  单位：分钟
function cfg_title:GetLastTime()
    if self.lastTime ~= nil then
        return self.lastTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().lastTime
        else
            return nil
        end
    end
end

---@return string 时间描述#客户端#C  用于特殊情况（时效不确定）的称号，如果填了此列，则不显示剩余时间，显示这里的内容
function cfg_title:GetTimeRemark()
    if self.timeRemark ~= nil then
        return self.timeRemark
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().timeRemark
        else
            return nil
        end
    end
end

---@return string 客户端显示#客户端#C
function cfg_title:GetPriority()
    if self.priority ~= nil then
        return self.priority
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().priority
        else
            return nil
        end
    end
end

---@return number 品质#客户端#C  和背包quality意义相同，用于显示品质色
function cfg_title:GetQuality()
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

---@return number 称号对应的itemid#客户端#C  主要实现在界面中的称号点击显示tips，配置相对应的道具id
function cfg_title:GetItemId()
    if self.itemId ~= nil then
        return self.itemId
    else
        if self:CsTABLE() ~= nil then
            self.itemId = self:CsTABLE().itemId
            return self.itemId
        else
            return nil
        end
    end
end

---@return number 图标显示_C
function cfg_title:GetIcon()
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
---@return number 法术最小攻击_C
function cfg_title:GetMagicAttackMin()
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

---@return number 法术最大攻击_C
function cfg_title:GetMagicAttackMax()
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
---@return number 道术最小攻击_C
function cfg_title:GetTaoAttackMin()
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

---@return number 道术最大攻击_C
function cfg_title:GetTaoAttackMax()
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
---@return number 物理最小攻击_C
function cfg_title:GetPhyAttackMin()
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

---@return number 物理最大攻击_C
function cfg_title:GetPhyAttackMax()
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
---@return number 物防_C
function cfg_title:GetDef()
    if self.def ~= nil then
        return self.def
    else
        if self:CsTABLE() ~= nil then
            self.def = self:CsTABLE().def
            return self.def
        else
            return nil
        end
    end
end

---@return number 魔防_C
function cfg_title:GetMdef()
    if self.mdef ~= nil then
        return self.mdef
    else
        if self:CsTABLE() ~= nil then
            self.mdef = self:CsTABLE().mdef
            return self.mdef
        else
            return nil
        end
    end
end
---@return number 生命_C
function cfg_title:GetHp()
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

---@return number BOSS伤害#客户端  对BOSS伤害增加属性（万分比
function cfg_title:GetBossDamageAdd()
    if self.bossDamageAdd ~= nil then
        return self.bossDamageAdd
    else
        if self:CsTABLE() ~= nil then
            self.bossDamageAdd = self:CsTABLE().bossDamageAdd
            return self.bossDamageAdd
        else
            return nil
        end
    end
end

---@return number 掉率#客户端  增加掉宝概率（十万分比
function cfg_title:GetDropRate()
    if self.dropRate ~= nil then
        return self.dropRate
    else
        if self:CsTABLE() ~= nil then
            self.dropRate = self:CsTABLE().dropRate
            return self.dropRate
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_TITLE C#中的数据结构
function cfg_title:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_TitleTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_title lua中的数据结构
function cfg_title:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.bossDamageAdd = decodedData.bossDamageAdd
    
    ---@private
    self.dropRate = decodedData.dropRate
end

return cfg_title