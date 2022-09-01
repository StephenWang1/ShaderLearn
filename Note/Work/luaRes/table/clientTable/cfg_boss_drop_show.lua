--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_boss_drop_show
local cfg_boss_drop_show = {}

cfg_boss_drop_show.__index = cfg_boss_drop_show

function cfg_boss_drop_show:UUID()
    return self.id
end

---@return number ID#客户端#C#不存在共同参与合并的字段  ID#客户端，将此id填入怪物表内dropShow字段
function cfg_boss_drop_show:GetId()
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

---@return TABLE.IntListList 掉落物品展示#客户端#C  职业#性别#itemID#itemID&职业#性别#itemID#itemID(职业：1战士2法师3道士；性别1男2女)（无用）
function cfg_boss_drop_show:GetDropShow()
    if self.dropShow ~= nil then
        return self.dropShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropShow
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件参数#客户端#C  限制时间：开始时间#结束时间(时间戳)；指定活动开启：活动id
function cfg_boss_drop_show:GetDisplayConditionParameter()
    if self.displayConditionParameter ~= nil then
        return self.displayConditionParameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().displayConditionParameter
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 掉落组Id#客户端#C  连接cfg_drop_show_group的groupId，#分割所有要显示的组 取到可用的组就返回，&特殊显示组，额外显示
function cfg_boss_drop_show:GetDropGroup()
    if self.dropGroup ~= nil then
        return self.dropGroup
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropGroup
        else
            return nil
        end
    end
end

---@return number 怪物id_C
function cfg_boss_drop_show:GetMonsterId()
    if self.monsterId ~= nil then
        return self.monsterId
    else
        if self:CsTABLE() ~= nil then
            self.monsterId = self:CsTABLE().monsterId
            return self.monsterId
        else
            return nil
        end
    end
end
---@return number 显示条件类型_C
function cfg_boss_drop_show:GetDisplayConditionType()
    if self.displayConditionType ~= nil then
        return self.displayConditionType
    else
        if self:CsTABLE() ~= nil then
            self.displayConditionType = self:CsTABLE().displayConditionType
            return self.displayConditionType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BOSS_DROP_SHOW C#中的数据结构
function cfg_boss_drop_show:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_BossDropShowTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_boss_drop_show lua中的数据结构
function cfg_boss_drop_show:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_boss_drop_show