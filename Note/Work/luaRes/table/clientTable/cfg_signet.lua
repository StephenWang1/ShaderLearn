--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_signet
local cfg_signet = {}

cfg_signet.__index = cfg_signet

function cfg_signet:UUID()
    return self.id
end

---@return number id唯一标识#客户端#C#不存在共同参与合并的字段  id
function cfg_signet:GetId()
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

---@return number 道具id#客户端#C  道具id，连接到道具表
function cfg_signet:GetItemId()
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

---@return string 技能名字#客户端#C  技能名字，连接到技能表
function cfg_signet:GetSkillName()
    if self.skillName ~= nil then
        return self.skillName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skillName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 技能类型参数#客户端#C  1增加伤害固定值#出现浮动概率#浮动数值下限#浮动数值上限（固定值）
function cfg_signet:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

---@return string 描述#客户端#C  描述#客户端，{0}表示服务器发数据
function cfg_signet:GetDescription()
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

---@return number 技能id_C
function cfg_signet:GetSkillId()
    if self.skillId ~= nil then
        return self.skillId
    else
        if self:CsTABLE() ~= nil then
            self.skillId = self:CsTABLE().skillId
            return self.skillId
        else
            return nil
        end
    end
end
---@return number 技能类型_C
function cfg_signet:GetAddAttack()
    if self.addAttack ~= nil then
        return self.addAttack
    else
        if self:CsTABLE() ~= nil then
            self.addAttack = self:CsTABLE().addAttack
            return self.addAttack
        else
            return nil
        end
    end
end

---@return number 类型#客户端  1印记使用 2魂装-黄金套使用
function cfg_signet:GetType()
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

---@return number 效果等级#客户端  区分效果等级，对应同等级装备
function cfg_signet:GetLv()
    if self.Lv ~= nil then
        return self.Lv
    else
        if self:CsTABLE() ~= nil then
            self.Lv = self:CsTABLE().Lv
            return self.Lv
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SIGNET C#中的数据结构
function cfg_signet:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_SignetTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_signet lua中的数据结构
function cfg_signet:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.Lv = decodedData.Lv
end

return cfg_signet