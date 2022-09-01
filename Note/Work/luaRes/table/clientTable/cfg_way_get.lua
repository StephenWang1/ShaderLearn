--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_way_get
local cfg_way_get = {}

cfg_way_get.__index = cfg_way_get

function cfg_way_get:UUID()
    return self.id
end

---@return number 唯一id#客户端#C#不存在共同参与合并的字段  唯一id
function cfg_way_get:GetId()
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

---@return string 按钮名称#客户端#C  界面中显示
function cfg_way_get:GetName()
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

---@return string 关联参数#客户端#C  打开界面：1 jump id；2 传送：deliverID#conditionID#bubbleID&deliverID  3 快捷购买storeid#数量#购买后是否自动使用（1否2是）4.指定地点deliverid（没有怪就下一个点）#deliverid#deliverid&monsterID#monsterID... 5/6 对应cfg_cheatPush表 12npcid传送员#deliverid尸王殿
function cfg_way_get:GetOpenPanel()
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

---@return TABLE.IntListJingHao 替换优先级#客户端#C  存在此ID时被替换
function cfg_way_get:GetPriority()
    if self.priority ~= nil then
        return self.priority
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().priority
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 条件#客户端#C
function cfg_way_get:GetConditions()
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

---@return number 关联类型（点击效果）_C
function cfg_way_get:GetOpenType()
    if self.openType ~= nil then
        return self.openType
    else
        if self:CsTABLE() ~= nil then
            self.openType = self:CsTABLE().openType
            return self.openType
        else
            return nil
        end
    end
end
---@return number 是否显示推荐角标_C
function cfg_way_get:GetIsRecommend()
    if self.isRecommend ~= nil then
        return self.isRecommend
    else
        if self:CsTABLE() ~= nil then
            self.isRecommend = self:CsTABLE().isRecommend
            return self.isRecommend
        else
            return nil
        end
    end
end

---@return number order#客户端  仅openType实现功能，排列顺序由小到大
function cfg_way_get:GetOrder()
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

---@return string 额外参数#客户端  仅用于给客户端判断条件是否满足，按钮是否隐藏，填写格式：conditionID#文本  合成跳转1.材料判定  2结果判定
function cfg_way_get:GetParameter()
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

--@return  TABLE.CFG_WAY_GET C#中的数据结构
function cfg_way_get:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Way_GetTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_way_get lua中的数据结构
function cfg_way_get:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.parameter = decodedData.parameter
end

return cfg_way_get