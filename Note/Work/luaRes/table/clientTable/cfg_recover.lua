--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_recover
local cfg_recover = {}

cfg_recover.__index = cfg_recover

function cfg_recover:UUID()
    return self.id
end

---@return number id#客户端  id
function cfg_recover:GetId()
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

---@return string 类型文本#客户端  类型文本，本类型文本描述
function cfg_recover:GetDes()
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

---@return TABLE.IntListJingHao 显示条件#客户端  显示条件  conditionid#conditionid
function cfg_recover:GetShowCondition()
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

---@return number 默认勾选#客户端  默认勾选与勾选条件   不填则为不自动勾选
function cfg_recover:GetAutoChooseCondition()
    if self.autoChooseCondition ~= nil then
        return self.autoChooseCondition
    else
        if self:CsTABLE() ~= nil then
            self.autoChooseCondition = self:CsTABLE().autoChooseCondition
            return self.autoChooseCondition
        else
            return nil
        end
    end
end

---@return number 排序#客户端  排序，根据排序排列所有拾取类型
function cfg_recover:GetOrder()
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

---@return number 回收条件#客户端  回收条件，本类型勾选后，所属道具是否直接回收的条件与相关的参数  不填则为无条件全选 1 与人物对比较差装备 2 与当前人物携带灵兽对比较差灵兽 3灵兽肉身 4灵兽装备 5宝物 6转生凭证 7元素 8印记 9材料 10药品 11藏品回收参数  12仙装 13技能书
function cfg_recover:GetRecoverCondition()
    if self.recoverCondition ~= nil then
        return self.recoverCondition
    else
        if self:CsTABLE() ~= nil then
            self.recoverCondition = self:CsTABLE().recoverCondition
            return self.recoverCondition
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RECOVER C#中的数据结构
function cfg_recover:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_recover lua中的数据结构
function cfg_recover:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.showCondition = decodedData.showCondition
    
    ---@private
    self.autoChooseCondition = decodedData.autoChooseCondition
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.recoverCondition = decodedData.recoverCondition
end

return cfg_recover