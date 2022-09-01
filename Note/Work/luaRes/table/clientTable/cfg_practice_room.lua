--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_practice_room
local cfg_practice_room = {}

cfg_practice_room.__index = cfg_practice_room

function cfg_practice_room:UUID()
    return self.id
end

---@return number id#客户端  id
function cfg_practice_room:GetId()
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

---@return number 副本id#客户端  对应的副本id
function cfg_practice_room:GetDupId()
    if self.dupId ~= nil then
        return self.dupId
    else
        if self:CsTABLE() ~= nil then
            self.dupId = self:CsTABLE().dupId
            return self.dupId
        else
            return nil
        end
    end
end

---@return string 按钮文本#客户端  按钮文本
function cfg_practice_room:GetDes()
    if self.des ~= nil then
        return self.des
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().des
        else
            return nil
        end
    end
end

---@return string 描述2#客户端  按钮下消耗文本
function cfg_practice_room:GetDes2()
    if self.des2 ~= nil then
        return self.des2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().des2
        else
            return nil
        end
    end
end

---@return number 传送id#客户端  点击进入对应的deliverid
function cfg_practice_room:GetDeliver()
    if self.deliver ~= nil then
        return self.deliver
    else
        if self:CsTABLE() ~= nil then
            self.deliver = self:CsTABLE().deliver
            return self.deliver
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 经验获取消耗#客户端  经验获取消耗，每当获得经验时扣除，不足则不获得并踢出地图  道具id#道具数量&道具id#道具数量
function cfg_practice_room:GetExpUpCost()
    if self.expUpCost ~= nil then
        return self.expUpCost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().expUpCost
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端  显示条件，玩家不满足此条件则不显示 不配置则无条件  conditionid#conditionid
function cfg_practice_room:GetShowCondition()
    if self.showCondition ~= nil then
        return self.showCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showCondition
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_PRACTICE_ROOM C#中的数据结构
function cfg_practice_room:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_practice_room lua中的数据结构
function cfg_practice_room:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.dupId = decodedData.dupId
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.des2 = decodedData.des2
    
    ---@private
    self.deliver = decodedData.deliver
    
    ---@private
    self.expUpCost = decodedData.expUpCost
    
    ---@private
    self.showCondition = decodedData.showCondition
end

return cfg_practice_room