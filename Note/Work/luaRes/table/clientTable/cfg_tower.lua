--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_tower
local cfg_tower = {}

cfg_tower.__index = cfg_tower

function cfg_tower:UUID()
    return self.storey
end

---@return number 层数#客户端  层数（只能按照顺序排序，不可跳跃id，导致崩溃，直接嫩死）
function cfg_tower:GetStorey()
    if self.storey ~= nil then
        return self.storey
    else
        if self:CsTABLE() ~= nil then
            self.storey = self:CsTABLE().storey
            return self.storey
        else
            return nil
        end
    end
end

---@return number 副本id#客户端  对应副本id
function cfg_tower:GetDuplicateId()
    if self.duplicateId ~= nil then
        return self.duplicateId
    else
        if self:CsTABLE() ~= nil then
            self.duplicateId = self:CsTABLE().duplicateId
            return self.duplicateId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 关卡限制#客户端  取cfg_conditions
function cfg_tower:GetTotalLv()
    if self.totalLv ~= nil then
        return self.totalLv
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().totalLv
        else
            return nil
        end
    end
end

---@return string 关卡限制描述#客户端  用于主界面条件文字描述
function cfg_tower:GetTotalDes()
    if self.totalDes ~= nil then
        return self.totalDes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().totalDes
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 通关条件#客户端  通关的条件需求
function cfg_tower:GetConditions()
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

---@return TABLE.IntListList 保底奖励#客户端  结算界面、左侧面板显示的保底道具，道具id#数量&道具id#数量
function cfg_tower:GetNormalReward()
    if self.normalReward ~= nil then
        return self.normalReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().normalReward
        else
            return nil
        end
    end
end

---@return number 随机库奖励道具#客户端  对应cfg_tower_special_box表id，最终只取服务器随机到的道具id作为展示
function cfg_tower:GetSpecialBox()
    if self.specialBox ~= nil then
        return self.specialBox
    else
        if self:CsTABLE() ~= nil then
            self.specialBox = self:CsTABLE().specialBox
            return self.specialBox
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_TOWER C#中的数据结构
function cfg_tower:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_tower lua中的数据结构
function cfg_tower:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.storey = decodedData.storey
    
    ---@private
    self.duplicateId = decodedData.duplicateId
    
    ---@private
    self.totalLv = decodedData.totalLv
    
    ---@private
    self.totalDes = decodedData.totalDes
    
    ---@private
    self.conditions = decodedData.conditions
    
    ---@private
    self.normalReward = decodedData.normalReward
    
    ---@private
    self.specialBox = decodedData.specialBox
end

return cfg_tower