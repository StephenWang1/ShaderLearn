--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_divinesuit
local cfg_divinesuit = {}

cfg_divinesuit.__index = cfg_divinesuit

function cfg_divinesuit:UUID()
    return self.id
end

---@return number id#客户端  唯一id  决定套装类型和等级  前两位为类型 后两位为等级
function cfg_divinesuit:GetId()
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

---@return number 套装类型#客户端  套装类型  1 记忆套装 2 祈祷  3 神秘
function cfg_divinesuit:GetType()
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

---@return number 子类型#客户端  子类型
function cfg_divinesuit:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end

---@return number 套装等级#客户端  套装等级，同类型套装不可一致
function cfg_divinesuit:GetLevel()
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

---@return string 套装icon#客户端  在角色面板显示的套装ICON
function cfg_divinesuit:GetSuitIcon()
    if self.suitIcon ~= nil then
        return self.suitIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().suitIcon
        else
            return nil
        end
    end
end

---@return number 套装数量#客户端  当前套装的装备位最大上限
function cfg_divinesuit:GetPosition()
    if self.position ~= nil then
        return self.position
    else
        if self:CsTABLE() ~= nil then
            self.position = self:CsTABLE().position
            return self.position
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 套装道具id#客户端  当前套装下属的所有装备id集合
function cfg_divinesuit:GetEquipId()
    if self.equipId ~= nil then
        return self.equipId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equipId
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 套装额外属性#客户端  穿戴本类型套相应等级装备达到数量后触发的额外属性或技能(索引到cfg_divineSuitAttribute表)   部位数量#额外属性id&部位数量#额外属性id （每次单独计算）
function cfg_divinesuit:GetAttribute()
    if self.attribute ~= nil then
        return self.attribute
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attribute
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 套装激活数量#客户端  套装激活的数量
function cfg_divinesuit:GetActiveNumber()
    if self.activeNumber ~= nil then
        return self.activeNumber
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().activeNumber
        else
            return nil
        end
    end
end

---@return TABLE.StringList 套装激活icon#客户端  根据套装激活数量，显示在角色面板神力按钮上的icon   icon名/icon名
function cfg_divinesuit:GetActiveIcon()
    if self.activeIcon ~= nil then
        return self.activeIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().activeIcon
        else
            return nil
        end
    end
end

---@return TABLE.StringList 套装激活特效#客户端  根据套装激活数量，显示在角色面板神力按钮icon上的特效  特效名/特效名
function cfg_divinesuit:GetActiveEffect()
    if self.activeEffect ~= nil then
        return self.activeEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().activeEffect
        else
            return nil
        end
    end
end

---@return string 套装名称#客户端  当前套装的名称  主要显示在tips中
function cfg_divinesuit:GetSuitName()
    if self.suitName ~= nil then
        return self.suitName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().suitName
        else
            return nil
        end
    end
end

---@return string 穿戴需求文本#客户端  穿戴需求文本，显示在tips中
function cfg_divinesuit:GetDressDes()
    if self.dressDes ~= nil then
        return self.dressDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dressDes
        else
            return nil
        end
    end
end

---@return string 套装部件显示#客户端  套装部件显示
function cfg_divinesuit:GetSubtypeShow()
    if self.subtypeShow ~= nil then
        return self.subtypeShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().subtypeShow
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DIVINESUIT C#中的数据结构
function cfg_divinesuit:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_divinesuit lua中的数据结构
function cfg_divinesuit:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.subType = decodedData.subType
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.suitIcon = decodedData.suitIcon
    
    ---@private
    self.position = decodedData.position
    
    ---@private
    self.equipId = decodedData.equipId
    
    ---@private
    self.attribute = decodedData.attribute
    
    ---@private
    self.activeNumber = decodedData.activeNumber
    
    ---@private
    self.activeIcon = decodedData.activeIcon
    
    ---@private
    self.activeEffect = decodedData.activeEffect
    
    ---@private
    self.suitName = decodedData.suitName
    
    ---@private
    self.dressDes = decodedData.dressDes
    
    ---@private
    self.subtypeShow = decodedData.subtypeShow
end

return cfg_divinesuit