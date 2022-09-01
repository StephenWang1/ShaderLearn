--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_collection
local cfg_collection = {}

cfg_collection.__index = cfg_collection

function cfg_collection:UUID()
    return self.itemId
end

---@return number 道具id#客户端#C  对应item表id
function cfg_collection:GetItemId()
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

---@return string 名字#客户端  藏品名字
function cfg_collection:GetName()
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

---@return string 摆放道具id#客户端  摆放在藏品界面里的道具id，对应道具的id
function cfg_collection:GetBindingId()
    if self.bindingId ~= nil then
        return self.bindingId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bindingId
        else
            return nil
        end
    end
end

---@return number 横向大小#客户端  藏品占用格子的横向大小
function cfg_collection:GetXSize()
    if self.xSize ~= nil then
        return self.xSize
    else
        if self:CsTABLE() ~= nil then
            self.xSize = self:CsTABLE().xSize
            return self.xSize
        else
            return nil
        end
    end
end

---@return number 纵向大小#客户端  藏品占用格子的纵向大小
function cfg_collection:GetYSize()
    if self.ySize ~= nil then
        return self.ySize
    else
        if self:CsTABLE() ~= nil then
            self.ySize = self:CsTABLE().ySize
            return self.ySize
        else
            return nil
        end
    end
end

---@return number 生命恢复#客户端  生命恢复速度属性
function cfg_collection:GetRecover()
    if self.recover ~= nil then
        return self.recover
    else
        if self:CsTABLE() ~= nil then
            self.recover = self:CsTABLE().recover
            return self.recover
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最小物攻#客户端  物攻随机范围最小值，下限#上限
function cfg_collection:GetPhyAttMin()
    if self.phyAttMin ~= nil then
        return self.phyAttMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyAttMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最大物攻#客户端  物攻随机范围最大值，下限#上限
function cfg_collection:GetPhyAttMax()
    if self.phyAttMax ~= nil then
        return self.phyAttMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyAttMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最小魔法#客户端  魔法随机范围最小值，下限#上限
function cfg_collection:GetMagicAttMin()
    if self.magicAttMin ~= nil then
        return self.magicAttMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicAttMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最大魔法#客户端  魔法随机范围最大值，下限#上限
function cfg_collection:GetMagicAttMax()
    if self.magicAttMax ~= nil then
        return self.magicAttMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicAttMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最小道术#客户端  道术随机范围最小值，下限#上限
function cfg_collection:GetTaoAttMin()
    if self.taoAttMin ~= nil then
        return self.taoAttMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taoAttMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最大道术#客户端  道术随机范围最大值，下限#上限
function cfg_collection:GetTaoAttMax()
    if self.taoAttMax ~= nil then
        return self.taoAttMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taoAttMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最小物防#客户端  物防随机范围最小值，下限#上限
function cfg_collection:GetPhyDefMin()
    if self.phyDefMin ~= nil then
        return self.phyDefMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最大物防#客户端  物防随机范围最大值，下限#上限
function cfg_collection:GetPhyDefMax()
    if self.phyDefMax ~= nil then
        return self.phyDefMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().phyDefMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最小魔防#客户端  魔防随机范围最小值，下限#上限
function cfg_collection:GetMagicDefMin()
    if self.magicDefMin ~= nil then
        return self.magicDefMin
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefMin
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 最大魔防#客户端  魔防随机范围最大值，下限#上限
function cfg_collection:GetMagicDefMax()
    if self.magicDefMax ~= nil then
        return self.magicDefMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().magicDefMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 生命值#客户端  生命随机范围值，最小值#最大值
function cfg_collection:GetHp()
    if self.hp ~= nil then
        return self.hp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hp
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_COLLECTION C#中的数据结构
function cfg_collection:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_collection lua中的数据结构
function cfg_collection:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.itemId = decodedData.itemId
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.bindingId = decodedData.bindingId
    
    ---@private
    self.xSize = decodedData.xSize
    
    ---@private
    self.ySize = decodedData.ySize
    
    ---@private
    self.recover = decodedData.recover
    
    ---@private
    self.phyAttMin = decodedData.phyAttMin
    
    ---@private
    self.phyAttMax = decodedData.phyAttMax
    
    ---@private
    self.magicAttMin = decodedData.magicAttMin
    
    ---@private
    self.magicAttMax = decodedData.magicAttMax
    
    ---@private
    self.taoAttMin = decodedData.taoAttMin
    
    ---@private
    self.taoAttMax = decodedData.taoAttMax
    
    ---@private
    self.phyDefMin = decodedData.phyDefMin
    
    ---@private
    self.phyDefMax = decodedData.phyDefMax
    
    ---@private
    self.magicDefMin = decodedData.magicDefMin
    
    ---@private
    self.magicDefMax = decodedData.magicDefMax
    
    ---@private
    self.hp = decodedData.hp
end

return cfg_collection