--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_prefix_title
local cfg_prefix_title = {}

cfg_prefix_title.__index = cfg_prefix_title

function cfg_prefix_title:UUID()
    return self.id
end

---@return number id#客户端#C  id#客户端
function cfg_prefix_title:GetId()
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

---@return number icon间隔#客户端#C  小数乘100
function cfg_prefix_title:GetGap()
    if self.gap ~= nil then
        return self.gap
    else
        if self:CsTABLE() ~= nil then
            self.gap = self:CsTABLE().gap
            return self.gap
        else
            return nil
        end
    end
end

---@return number 品级_C
function cfg_prefix_title:GetClassNumber()
    if self.classNumber ~= nil then
        return self.classNumber
    else
        if self:CsTABLE() ~= nil then
            self.classNumber = self:CsTABLE().classNumber
            return self.classNumber
        else
            return nil
        end
    end
end
---@return number 分组_C
function cfg_prefix_title:GetGroup()
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

---@return string 前缀称号名称#客户端  战#法#道
function cfg_prefix_title:GetName()
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

---@return number 下阶id#客户端
function cfg_prefix_title:GetNextId()
    if self.nextId ~= nil then
        return self.nextId
    else
        if self:CsTABLE() ~= nil then
            self.nextId = self:CsTABLE().nextId
            return self.nextId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 消耗道具#客户端  升级消耗的道具，conditionID#conditionID
function cfg_prefix_title:GetCostItem()
    if self.costItem ~= nil then
        return self.costItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().costItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 生命值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetHp()
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

---@return TABLE.IntListList 战力下限加值#客户端  1#n&2#n&3#n  1战士2法师3道士   N为属性值
function cfg_prefix_title:GetCeLower()
    if self.ceLower ~= nil then
        return self.ceLower
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().ceLower
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 战力上限加值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetCeUpper()
    if self.ceUpper ~= nil then
        return self.ceUpper
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().ceUpper
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 物理防御下限加值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetDefLower()
    if self.defLower ~= nil then
        return self.defLower
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().defLower
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 物防上限加值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetDefUpper()
    if self.defUpper ~= nil then
        return self.defUpper
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().defUpper
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 魔法防御下限加值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetMDefLower()
    if self.mDefLower ~= nil then
        return self.mDefLower
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mDefLower
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 魔防上限加值#客户端  1#n&2#n&3#n   1战士2法师3道士   N为属性值
function cfg_prefix_title:GetMDefUpper()
    if self.mDefUpper ~= nil then
        return self.mDefUpper
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mDefUpper
        else
            return nil
        end
    end
end

---@return string 品质色#客户端
function cfg_prefix_title:GetColor()
    if self.color ~= nil then
        return self.color
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().color
        else
            return nil
        end
    end
end

---@return number 属性点#客户端  给客户端用面板中显示的天赋点数量
function cfg_prefix_title:GetAttributeShow()
    if self.attributeShow ~= nil then
        return self.attributeShow
    else
        if self:CsTABLE() ~= nil then
            self.attributeShow = self:CsTABLE().attributeShow
            return self.attributeShow
        else
            return nil
        end
    end
end

---@return number 属性丹使用上限#客户端  给客户端用面板中显示的天赋丹使用数量上限
function cfg_prefix_title:GetAttributeItemShow()
    if self.attributeItemShow ~= nil then
        return self.attributeItemShow
    else
        if self:CsTABLE() ~= nil then
            self.attributeItemShow = self:CsTABLE().attributeItemShow
            return self.attributeItemShow
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_PREFIX_TITLE C#中的数据结构
function cfg_prefix_title:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_PrefixTitleTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_prefix_title lua中的数据结构
function cfg_prefix_title:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.nextId = decodedData.nextId
    
    ---@private
    self.costItem = decodedData.costItem
    
    ---@private
    self.hp = decodedData.hp
    
    ---@private
    self.ceLower = decodedData.ceLower
    
    ---@private
    self.ceUpper = decodedData.ceUpper
    
    ---@private
    self.defLower = decodedData.defLower
    
    ---@private
    self.defUpper = decodedData.defUpper
    
    ---@private
    self.mDefLower = decodedData.mDefLower
    
    ---@private
    self.mDefUpper = decodedData.mDefUpper
    
    ---@private
    self.color = decodedData.color
    
    ---@private
    self.attributeShow = decodedData.attributeShow
    
    ---@private
    self.attributeItemShow = decodedData.attributeItemShow
end

return cfg_prefix_title