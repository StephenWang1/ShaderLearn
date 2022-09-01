--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_gather_soul
local cfg_gather_soul = {}

cfg_gather_soul.__index = cfg_gather_soul

function cfg_gather_soul:UUID()
    return self.vipLevel
end

---@return number 充值等级#客户端  聚灵充值等级
function cfg_gather_soul:GetVipLevel()
    if self.vipLevel ~= nil then
        return self.vipLevel
    else
        if self:CsTABLE() ~= nil then
            self.vipLevel = self:CsTABLE().vipLevel
            return self.vipLevel
        else
            return nil
        end
    end
end

---@return number 升到下级所需总充值数#客户端  单位：角，对应需要升到下一级的总充值数
function cfg_gather_soul:GetNeedExp()
    if self.needExp ~= nil then
        return self.needExp
    else
        if self:CsTABLE() ~= nil then
            self.needExp = self:CsTABLE().needExp
            return self.needExp
        else
            return nil
        end
    end
end

---@return number 聚灵数#客户端  对应等级每天能领取的灵力
function cfg_gather_soul:GetServantMana()
    if self.servantMana ~= nil then
        return self.servantMana
    else
        if self:CsTABLE() ~= nil then
            self.servantMana = self:CsTABLE().servantMana
            return self.servantMana
        else
            return nil
        end
    end
end

---@return string 聚灵等级#客户端  对应聚灵不同等级的文字展示
function cfg_gather_soul:GetManaLevel()
    if self.manaLevel ~= nil then
        return self.manaLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().manaLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GATHER_SOUL C#中的数据结构
function cfg_gather_soul:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_gather_soul lua中的数据结构
function cfg_gather_soul:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.vipLevel = decodedData.vipLevel
    
    ---@private
    self.needExp = decodedData.needExp
    
    ---@private
    self.servantMana = decodedData.servantMana
    
    ---@private
    self.manaLevel = decodedData.manaLevel
end

return cfg_gather_soul