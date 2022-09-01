--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_inlay_effect
local cfg_inlay_effect = {}

cfg_inlay_effect.__index = cfg_inlay_effect

function cfg_inlay_effect:UUID()
    return self.id
end

---@return number id#客户端  id
function cfg_inlay_effect:GetId()
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

---@return number 类型#客户端  类型 1仙装
function cfg_inlay_effect:GetType()
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

---@return string 标题#客户端  显示在tips中的标题
function cfg_inlay_effect:GetTitle()
    if self.title ~= nil then
        return self.title
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title
        else
            return nil
        end
    end
end

---@return string 标题2#客户端  未镶嵌时候标题
function cfg_inlay_effect:GetTitle2()
    if self.title2 ~= nil then
        return self.title2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title2
        else
            return nil
        end
    end
end

---@return string 标题3#客户端  镶嵌后未激活标题
function cfg_inlay_effect:GetTitle3()
    if self.title3 ~= nil then
        return self.title3
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title3
        else
            return nil
        end
    end
end

---@return number 额外属性#客户端  生效额外属性，索引到extra_mon_effect表
function cfg_inlay_effect:GetExtraMonEffect()
    if self.extraMonEffect ~= nil then
        return self.extraMonEffect
    else
        if self:CsTABLE() ~= nil then
            self.extraMonEffect = self:CsTABLE().extraMonEffect
            return self.extraMonEffect
        else
            return nil
        end
    end
end

---@return string 镶嵌特效#客户端  镶嵌特效，镶嵌后显示在icon上
function cfg_inlay_effect:GetEffect()
    if self.effect ~= nil then
        return self.effect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effect
        else
            return nil
        end
    end
end

---@return string 特效处理#客户端  特效处理参数  1类型  类型id#r#g#b#a
function cfg_inlay_effect:GetEffectParam()
    if self.effectParam ~= nil then
        return self.effectParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectParam
        else
            return nil
        end
    end
end

---@return string 镶嵌底纹#客户端  镶嵌底纹，镶嵌后显示在装备位底部
function cfg_inlay_effect:GetBasePicture()
    if self.basePicture ~= nil then
        return self.basePicture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().basePicture
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao buffid#客户端  填buffid关联到buff表
function cfg_inlay_effect:GetBuffers()
    if self.buffers ~= nil then
        return self.buffers
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buffers
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_INLAY_EFFECT C#中的数据结构
function cfg_inlay_effect:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_inlay_effect lua中的数据结构
function cfg_inlay_effect:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.title = decodedData.title
    
    ---@private
    self.title2 = decodedData.title2
    
    ---@private
    self.title3 = decodedData.title3
    
    ---@private
    self.extraMonEffect = decodedData.extraMonEffect
    
    ---@private
    self.effect = decodedData.effect
    
    ---@private
    self.effectParam = decodedData.effectParam
    
    ---@private
    self.basePicture = decodedData.basePicture
    
    ---@private
    self.buffers = decodedData.buffers
end

return cfg_inlay_effect