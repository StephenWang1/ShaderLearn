--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_wayget_fastauction
local cfg_wayget_fastauction = {}

cfg_wayget_fastauction.__index = cfg_wayget_fastauction

function cfg_wayget_fastauction:UUID()
    return self.id
end

---@return number 道具id#客户端  道具id
function cfg_wayget_fastauction:GetId()
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

---@return TABLE.IntListJingHao 道具id集合#客户端  道具id对应的需要检测的交易品id集合
function cfg_wayget_fastauction:GetItems()
    if self.items ~= nil then
        return self.items
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().items
        else
            return nil
        end
    end
end

---@return number 是否可选数量#客户端  不填则购买1个  填1弹出交易行选择数量面板
function cfg_wayget_fastauction:GetChooseNumber()
    if self.chooseNumber ~= nil then
        return self.chooseNumber
    else
        if self:CsTABLE() ~= nil then
            self.chooseNumber = self:CsTABLE().chooseNumber
            return self.chooseNumber
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_WAYGET_FASTAUCTION C#中的数据结构
function cfg_wayget_fastauction:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_wayget_fastauction lua中的数据结构
function cfg_wayget_fastauction:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.items = decodedData.items
    
    ---@private
    self.chooseNumber = decodedData.chooseNumber
end

return cfg_wayget_fastauction