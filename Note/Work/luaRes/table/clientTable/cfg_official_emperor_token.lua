--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_official_emperor_token
local cfg_official_emperor_token = {}

cfg_official_emperor_token.__index = cfg_official_emperor_token

function cfg_official_emperor_token:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  编号
function cfg_official_emperor_token:GetId()
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

---@return TABLE.IntListList 激活货币数量#客户端  货币id#数量
function cfg_official_emperor_token:GetCost()
    if self.cost ~= nil then
        return self.cost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cost
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 可激活条件#客户端  可激活条件，关联cfg_conditions表
function cfg_official_emperor_token:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

---@return number 关联道具id#客户端  同个道具不同id互相关联字段关联cfg_items
function cfg_official_emperor_token:GetLinkItemId()
    if self.linkItemId ~= nil then
        return self.linkItemId
    else
        if self:CsTABLE() ~= nil then
            self.linkItemId = self:CsTABLE().linkItemId
            return self.linkItemId
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 掉落货币数量#客户端  掉落货币的数量，itemsID#数量
function cfg_official_emperor_token:GetDrop()
    if self.drop ~= nil then
        return self.drop
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().drop
        else
            return nil
        end
    end
end

---@return number 回收货币比例#客户端  万分比填写
function cfg_official_emperor_token:GetDropRecycleRate()
    if self.dropRecycleRate ~= nil then
        return self.dropRecycleRate
    else
        if self:CsTABLE() ~= nil then
            self.dropRecycleRate = self:CsTABLE().dropRecycleRate
            return self.dropRecycleRate
        else
            return nil
        end
    end
end

---@return string 虎符掉落描述#客户端  文字配置掉落描述
function cfg_official_emperor_token:GetTips()
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

--@return  TABLE.CFG_OFFICIAL_EMPEROR_TOKEN C#中的数据结构
function cfg_official_emperor_token:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_official_emperor_token lua中的数据结构
function cfg_official_emperor_token:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.cost = decodedData.cost
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.linkItemId = decodedData.linkItemId
    
    ---@private
    self.drop = decodedData.drop
    
    ---@private
    self.dropRecycleRate = decodedData.dropRecycleRate
    
    ---@private
    self.tips = decodedData.tips
end

return cfg_official_emperor_token