--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_ancient_boss
local cfg_ancient_boss = {}

cfg_ancient_boss.__index = cfg_ancient_boss

function cfg_ancient_boss:UUID()
    return self.id
end

---@return number 远古boss怪物id#客户端#C  远古boss怪物id
function cfg_ancient_boss:GetId()
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

---@return TABLE.IntListJingHao 前置怪物id#客户端#C  需要击杀的前置怪物id，多个用#隔开
function cfg_ancient_boss:GetNeed()
    if self.need ~= nil then
        return self.need
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().need
        else
            return nil
        end
    end
end

---@return number 击杀数量#客户端#C  需要击杀多少只召唤，总数
function cfg_ancient_boss:GetNum()
    if self.num ~= nil then
        return self.num
    else
        if self:CsTABLE() ~= nil then
            self.num = self:CsTABLE().num
            return self.num
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 地图id#客户端#C  远古boss刷新地图id，多个用#隔开
function cfg_ancient_boss:GetMapId()
    if self.mapId ~= nil then
        return self.mapId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mapId
        else
            return nil
        end
    end
end

---@return number 最低伤害#客户端#C  邮件声望奖励，最低伤害限制
function cfg_ancient_boss:GetDamageLimit()
    if self.damageLimit ~= nil then
        return self.damageLimit
    else
        if self:CsTABLE() ~= nil then
            self.damageLimit = self:CsTABLE().damageLimit
            return self.damageLimit
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端#C  备注用
function cfg_ancient_boss:GetTips()
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

---@return number 怪物类型#客户端#C  1.远古boss  2.非远古boss
function cfg_ancient_boss:GetType()
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

---@return number 远古boss联服地图id#客户端  远古boss第几次联服加入
function cfg_ancient_boss:GetShareNum()
    if self.shareNum ~= nil then
        return self.shareNum
    else
        if self:CsTABLE() ~= nil then
            self.shareNum = self:CsTABLE().shareNum
            return self.shareNum
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ANCIENT_BOSS C#中的数据结构
function cfg_ancient_boss:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_AncientBossTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_ancient_boss lua中的数据结构
function cfg_ancient_boss:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.shareNum = decodedData.shareNum
end

return cfg_ancient_boss