--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_drop_show_group
local cfg_drop_show_group = {}

cfg_drop_show_group.__index = cfg_drop_show_group

function cfg_drop_show_group:UUID()
    return self.id
end

---@return number 唯一id#客户端#C  唯一标识id
function cfg_drop_show_group:GetId()
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

---@return number 怪物箱id#客户端#C  boxid
function cfg_drop_show_group:GetGroupId()
    if self.groupId ~= nil then
        return self.groupId
    else
        if self:CsTABLE() ~= nil then
            self.groupId = self:CsTABLE().groupId
            return self.groupId
        else
            return nil
        end
    end
end

---@return number 道具id#客户端#C  道具id item表（配错将不掉落物品注意）
function cfg_drop_show_group:GetItemId()
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

---@return string 道具名#客户端#C  道具名称
function cfg_drop_show_group:GetItemName()
    if self.itemName ~= nil then
        return self.itemName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemName
        else
            return nil
        end
    end
end

---@return number 性别#客户端#C  0无限制；1男；2女
function cfg_drop_show_group:GetSex()
    if self.sex ~= nil then
        return self.sex
    else
        if self:CsTABLE() ~= nil then
            self.sex = self:CsTABLE().sex
            return self.sex
        else
            return nil
        end
    end
end

---@return number 职业#客户端#C  0无限制；1战士；2法师；3道士
function cfg_drop_show_group:GetCareer()
    if self.career ~= nil then
        return self.career
    else
        if self:CsTABLE() ~= nil then
            self.career = self:CsTABLE().career
            return self.career
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具的conditionid#客户端#C  连接conditionid 显示
function cfg_drop_show_group:GetItemConditionId()
    if self.itemConditionId ~= nil then
        return self.itemConditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemConditionId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具组的conditionid#客户端#C  连接conditionid 显示，只需填第一个
function cfg_drop_show_group:GetGroupConditionId()
    if self.groupConditionId ~= nil then
        return self.groupConditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().groupConditionId
        else
            return nil
        end
    end
end

---@return string 特殊标记#客户端  展示面板，icon上的特殊标记  配置为图片名 不配置则不显示
function cfg_drop_show_group:GetTag()
    if self.tag ~= nil then
        return self.tag
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tag
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DROP_SHOW_GROUP C#中的数据结构
function cfg_drop_show_group:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_DropShowGroupTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_drop_show_group lua中的数据结构
function cfg_drop_show_group:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.tag = decodedData.tag
end

return cfg_drop_show_group