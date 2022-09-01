--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_divinesuitattribute
local cfg_divinesuitattribute = {}

cfg_divinesuitattribute.__index = cfg_divinesuitattribute

function cfg_divinesuitattribute:UUID()
    return self.id
end

---@return number id#客户端  神力属性唯一id  前两位为神力装备类型（可在divinesuit中查看）\n         后两位为唯一id   虽然可能属性激活比例一致\n         最好还是每一套单独配
function cfg_divinesuitattribute:GetId()
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

---@return string 描述#客户端  激活此条属性的描述
function cfg_divinesuitattribute:GetDes()
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

---@return TABLE.IntListJingHao 激活技能#客户端  激活的技能\n         索引到技能表  skillid#level
function cfg_divinesuitattribute:GetSkill()
    if self.skill ~= nil then
        return self.skill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skill
        else
            return nil
        end
    end
end

---@return string 激活技能的描述#客户端  技能描述
function cfg_divinesuitattribute:GetSkilldes()
    if self.skilldes ~= nil then
        return self.skilldes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skilldes
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DIVINESUITATTRIBUTE C#中的数据结构
function cfg_divinesuitattribute:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_divinesuitattribute lua中的数据结构
function cfg_divinesuitattribute:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.skill = decodedData.skill
    
    ---@private
    self.skilldes = decodedData.skilldes
end

return cfg_divinesuitattribute