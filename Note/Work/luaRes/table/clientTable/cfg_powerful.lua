--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_powerful
local cfg_powerful = {}

cfg_powerful.__index = cfg_powerful

function cfg_powerful:UUID()
    return self.id
end

---@return number id#客户端
function cfg_powerful:GetId()
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

---@return string 类型#客户端  1.我要升级 2.我要装备 3.装备提升 4.技能获取 5.转生凭证 6.资源获取
function cfg_powerful:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().type
        else
            return nil
        end
    end
end

---@return string 名称#客户端
function cfg_powerful:GetName()
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

---@return string 描述#客户端
function cfg_powerful:GetDescribe()
    if self.describe ~= nil then
        return self.describe
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().describe
        else
            return nil
        end
    end
end

---@return number 排序#客户端#不存在共同参与合并的字段
function cfg_powerful:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end

---@return number 星级#客户端
function cfg_powerful:GetStar()
    if self.star ~= nil then
        return self.star
    else
        if self:CsTABLE() ~= nil then
            self.star = self:CsTABLE().star
            return self.star
        else
            return nil
        end
    end
end

---@return number 等级#客户端
function cfg_powerful:GetLevel()
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

---@return string 跳转类型#客户端  1.打开界面 2.寻路到NPC 3.商城购买物品 4.地图挂机
function cfg_powerful:GetJumpType()
    if self.jumpType ~= nil then
        return self.jumpType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().jumpType
        else
            return nil
        end
    end
end

---@return string 参数#客户端  1.jump表ID 2. map_npc表ID 4.挂机参数：第1位固定deliverID#第2位固定门票conditionsID（没有填0）#第三位conditionID条件…#第N位conditionID
function cfg_powerful:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

---@return string 额外参数#客户端  传送对应读取mapid#deliverID
function cfg_powerful:GetOpenPanel()
    if self.openPanel ~= nil then
        return self.openPanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openPanel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端  显示条目的条件，满足条件需求才显示，conditionID#conditionID
function cfg_powerful:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condition
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_POWERFUL C#中的数据结构
function cfg_powerful:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_powerful lua中的数据结构
function cfg_powerful:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.describe = decodedData.describe
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.star = decodedData.star
    
    ---@private
    self.level = decodedData.level
    
    ---@private
    self.jumpType = decodedData.jumpType
    
    ---@private
    self.parameter = decodedData.parameter
    
    ---@private
    self.openPanel = decodedData.openPanel
    
    ---@private
    self.condition = decodedData.condition
end

return cfg_powerful