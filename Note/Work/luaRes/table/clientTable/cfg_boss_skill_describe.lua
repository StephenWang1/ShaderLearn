--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_boss_skill_describe
local cfg_boss_skill_describe = {}

cfg_boss_skill_describe.__index = cfg_boss_skill_describe

function cfg_boss_skill_describe:UUID()
    return self.id
end

---@return number 技能id#客户端
function cfg_boss_skill_describe:GetId()
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

---@return string 技能名称#客户端
function cfg_boss_skill_describe:GetName()
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

---@return string 图标#客户端  icon的id
function cfg_boss_skill_describe:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return string 技能描述#客户端
function cfg_boss_skill_describe:GetTips()
    if self.tips ~= nil then
        return self.tips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips
        else
            return nil
        end
    end
end

---@return string 补充说明#客户端  多条内容用&分隔
function cfg_boss_skill_describe:GetTips2()
    if self.tips2 ~= nil then
        return self.tips2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips2
        else
            return nil
        end
    end
end

---@return TABLE.IntListList tips2显示颜色变化条件#客户端  关联condition表id（多条内容的条件用&分隔）
function cfg_boss_skill_describe:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BOSS_SKILL_DESCRIBE C#中的数据结构
function cfg_boss_skill_describe:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_boss_skill_describe lua中的数据结构
function cfg_boss_skill_describe:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.tips = decodedData.tips
    
    ---@private
    self.tips2 = decodedData.tips2
    
    ---@private
    self.conditions = decodedData.conditions
end

return cfg_boss_skill_describe