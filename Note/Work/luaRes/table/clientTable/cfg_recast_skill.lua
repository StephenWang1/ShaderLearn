--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_recast_skill
local cfg_recast_skill = {}

cfg_recast_skill.__index = cfg_recast_skill

function cfg_recast_skill:UUID()
    return self.id
end

---@return number id#客户端  重铸id
function cfg_recast_skill:GetId()
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

---@return string 配饰类型#客户端  配饰对应subtype类型items表关联（22灵魂刻印 24面纱 13灯座 15玉佩 21宝饰 18秘宝）
function cfg_recast_skill:GetRemarks()
    if self.remarks ~= nil then
        return self.remarks
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remarks
        else
            return nil
        end
    end
end

---@return number 特效显示#客户端  特殊效果的显示 格式1显示 0不显示
function cfg_recast_skill:GetEffect()
    if self.effect ~= nil then
        return self.effect
    else
        if self:CsTABLE() ~= nil then
            self.effect = self:CsTABLE().effect
            return self.effect
        else
            return nil
        end
    end
end

---@return number 重铸技能tips#客户端  重铸技能tips 格式 buffid
function cfg_recast_skill:GetBuffTips()
    if self.buffTips ~= nil then
        return self.buffTips
    else
        if self:CsTABLE() ~= nil then
            self.buffTips = self:CsTABLE().buffTips
            return self.buffTips
        else
            return nil
        end
    end
end

---@return string 重铸特殊激活等级显示#客户端  特殊效果描述文本 为空就是不显示
function cfg_recast_skill:GetRecastLevel()
    if self.recastLevel ~= nil then
        return self.recastLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().recastLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RECAST_SKILL C#中的数据结构
function cfg_recast_skill:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_recast_skill lua中的数据结构
function cfg_recast_skill:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.remarks = decodedData.remarks
    
    ---@private
    self.effect = decodedData.effect
    
    ---@private
    self.buffTips = decodedData.buffTips
    
    ---@private
    self.recastLevel = decodedData.recastLevel
end

return cfg_recast_skill