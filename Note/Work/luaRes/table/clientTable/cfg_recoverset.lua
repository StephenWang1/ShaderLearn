--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_recoverset
local cfg_recoverset = {}

cfg_recoverset.__index = cfg_recoverset

function cfg_recoverset:UUID()
    return self.id
end

---@return number id#客户端#C  按照id排序
function cfg_recoverset:GetId()
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

---@return number 设置类型#客户端#C  1 升星 2 人物转生装备 3 转生灵兽 4 灵兽生肖装备 5至10收藏品
function cfg_recoverset:GetType()
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

---@return TABLE.IntListJingHao 相应参数#客户端#C  参数下限#参数上限
function cfg_recoverset:GetParam()
    if self.param ~= nil then
        return self.param
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().param
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端#C  配置conditionid，不填则无显示条件
function cfg_recoverset:GetShowCondition()
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

---@return number 是否自动选择，同type下只可选一个且优先勾选最高的#客户端#C  不填或0不自动选，1则自动勾选
function cfg_recoverset:GetAutoChoose()
    if self.autoChoose ~= nil then
        return self.autoChoose
    else
        if self:CsTABLE() ~= nil then
            self.autoChoose = self:CsTABLE().autoChoose
            return self.autoChoose
        else
            return nil
        end
    end
end

---@return string 文本#客户端#C  显示文本
function cfg_recoverset:GetDes()
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

---@return TABLE.IntListJingHao 回收物品勾选#客户端  填cfg_recover表里的ID，回收设置里包含的类型都需要填写
function cfg_recoverset:GetRecoveType()
    if self.recoveType ~= nil then
        return self.recoveType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().recoveType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RECOVERSET C#中的数据结构
function cfg_recoverset:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_RecoverSetTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_recoverset lua中的数据结构
function cfg_recoverset:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.recoveType = decodedData.recoveType
end

return cfg_recoverset