--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_mysteriousoldman
local cfg_mysteriousoldman = {}

cfg_mysteriousoldman.__index = cfg_mysteriousoldman

function cfg_mysteriousoldman:UUID()
    return self.id
end

---@return number id#客户端#C
function cfg_mysteriousoldman:GetId()
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

---@return TABLE.IntListJingHao 显示条目等级#客户端  每条材料条目的显示等级，填conditionID
function cfg_mysteriousoldman:GetShowLevel()
    if self.showLevel ~= nil then
        return self.showLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showLevel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 可兑换等级#客户端  每条材料条目的可兑换等级，填conditionID
function cfg_mysteriousoldman:GetNeedLevel()
    if self.needLevel ~= nil then
        return self.needLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().needLevel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 兑换材料#客户端  兑换的物品，道具ID#数量
function cfg_mysteriousoldman:GetGetItem()
    if self.getItem ~= nil then
        return self.getItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().getItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 所需道具#客户端  兑换消耗道具，conditionID#conditionID
function cfg_mysteriousoldman:GetCostItem()
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

---@return number 每日兑换次数#客户端  每日可兑换的次数限制
function cfg_mysteriousoldman:GetExchangeNum()
    if self.exchangeNum ~= nil then
        return self.exchangeNum
    else
        if self:CsTABLE() ~= nil then
            self.exchangeNum = self:CsTABLE().exchangeNum
            return self.exchangeNum
        else
            return nil
        end
    end
end

---@return number 同组类型#客户端
function cfg_mysteriousoldman:GetGroup()
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

---@return number 同组排序#客户端  同组类型下的排序顺序
function cfg_mysteriousoldman:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MYSTERIOUSOLDMAN C#中的数据结构
function cfg_mysteriousoldman:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_mysteriousoldman lua中的数据结构
function cfg_mysteriousoldman:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.showLevel = decodedData.showLevel
    
    ---@private
    self.needLevel = decodedData.needLevel
    
    ---@private
    self.getItem = decodedData.getItem
    
    ---@private
    self.costItem = decodedData.costItem
    
    ---@private
    self.exchangeNum = decodedData.exchangeNum
    
    ---@private
    self.group = decodedData.group
    
    ---@private
    self.index = decodedData.index
end

return cfg_mysteriousoldman