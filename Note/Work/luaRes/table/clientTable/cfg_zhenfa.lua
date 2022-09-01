--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_zhenfa
local cfg_zhenfa = {}

cfg_zhenfa.__index = cfg_zhenfa

function cfg_zhenfa:UUID()
    return self.id
end

---@return number id#客户端  阵法id
function cfg_zhenfa:GetId()
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

---@return number 阵法等级#客户端  当前阵法等级
function cfg_zhenfa:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end

---@return number 单次升级经验值#客户端  点击按钮，单次升级的经验值
function cfg_zhenfa:GetExpOnce()
    if self.expOnce ~= nil then
        return self.expOnce
    else
        if self:CsTABLE() ~= nil then
            self.expOnce = self:CsTABLE().expOnce
            return self.expOnce
        else
            return nil
        end
    end
end

---@return number 升级总经验#客户端  升级总经验
function cfg_zhenfa:GetExpSum()
    if self.expSum ~= nil then
        return self.expSum
    else
        if self:CsTABLE() ~= nil then
            self.expSum = self:CsTABLE().expSum
            return self.expSum
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 消耗材料#客户端  单次升级消耗的材料 itemid#数量&itemid#数量 要配绑定的id
function cfg_zhenfa:GetCostMaterial()
    if self.costMaterial ~= nil then
        return self.costMaterial
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costMaterial
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 消耗货币#客户端  单次升级消耗的货币 itemid#数量
function cfg_zhenfa:GetCostCurrency()
    if self.costCurrency ~= nil then
        return self.costCurrency
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costCurrency
        else
            return nil
        end
    end
end

---@return number 增加属性#客户端  法阵增加的属性，填cfg_extra_mon_effect的id
function cfg_zhenfa:GetAttribute()
    if self.attribute ~= nil then
        return self.attribute
    else
        if self:CsTABLE() ~= nil then
            self.attribute = self:CsTABLE().attribute
            return self.attribute
        else
            return nil
        end
    end
end

---@return string 序列帧名#客户端  阵法序列帧id
function cfg_zhenfa:GetSequenceId()
    if self.sequenceId ~= nil then
        return self.sequenceId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().sequenceId
        else
            return nil
        end
    end
end

---@return string 阵法名字#客户端  阵法名字
function cfg_zhenfa:GetName()
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

---@return TABLE.IntListJingHao 解锁配件类型#客户端  配件装备子类型
function cfg_zhenfa:GetSubtype()
    if self.subtype ~= nil then
        return self.subtype
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().subtype
        else
            return nil
        end
    end
end

---@return number 阵法特效名#客户端  阵法特效名
function cfg_zhenfa:GetEffectName()
    if self.effectName ~= nil then
        return self.effectName
    else
        if self:CsTABLE() ~= nil then
            self.effectName = self:CsTABLE().effectName
            return self.effectName
        else
            return nil
        end
    end
end

---@return number 阵法道具id#客户端  itemid，显示用
function cfg_zhenfa:GetItemId()
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

---@return TABLE.IntListJingHao 阵法效果1#客户端  阵法的界面效果 X坐标#Y左边#X大小缩放*100#Y大小缩放*100
function cfg_zhenfa:GetEffect1()
    if self.effect1 ~= nil then
        return self.effect1
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effect1
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 阵法效果2#客户端  阵法的界面效果 X坐标#Y左边#X大小缩放*100#Y大小缩放*100
function cfg_zhenfa:GetEffect2()
    if self.effect2 ~= nil then
        return self.effect2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effect2
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ZHENFA C#中的数据结构
function cfg_zhenfa:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_zhenfa lua中的数据结构
function cfg_zhenfa:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.expOnce = decodedData.expOnce
    
    ---@private
    self.expSum = decodedData.expSum
    
    ---@private
    self.costMaterial = decodedData.costMaterial
    
    ---@private
    self.costCurrency = decodedData.costCurrency
    
    ---@private
    self.attribute = decodedData.attribute
    
    ---@private
    self.sequenceId = decodedData.sequenceId
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.subtype = decodedData.subtype
    
    ---@private
    self.effectName = decodedData.effectName
    
    ---@private
    self.itemId = decodedData.itemId
    
    ---@private
    self.effect1 = decodedData.effect1
    
    ---@private
    self.effect2 = decodedData.effect2
end

return cfg_zhenfa