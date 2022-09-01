--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_union_activity
local cfg_union_activity = {}

cfg_union_activity.__index = cfg_union_activity

function cfg_union_activity:UUID()
    return self.id
end

---@return number 活动id#客户端#C  活动id 索引daily表 0为敬请期待
function cfg_union_activity:GetId()
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

---@return number 界面排序#客户端#C  界面排序，由低到高排序
function cfg_union_activity:GetOrder()
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

---@return string 标题名#客户端#C  标题所用图片名
function cfg_union_activity:GetTitle()
    if self.title ~= nil then
        return self.title
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title
        else
            return nil
        end
    end
end

---@return string 底图#客户端#C  底图所用ab名
function cfg_union_activity:GetBackGround()
    if self.backGround ~= nil then
        return self.backGround
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().backGround
        else
            return nil
        end
    end
end

---@return string 特效#客户端#C  特效id#特效id
function cfg_union_activity:GetEffect()
    if self.effect ~= nil then
        return self.effect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effect
        else
            return nil
        end
    end
end

---@return string 特效节点#客户端#C  相应特效偏移量X#相应特效偏移量Y#相应特效偏移量z
function cfg_union_activity:GetEffectMove()
    if self.effectMove ~= nil then
        return self.effectMove
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectMove
        else
            return nil
        end
    end
end

---@return string 按钮文本#客户端#C  按钮文本
function cfg_union_activity:GetButtonLabel()
    if self.buttonLabel ~= nil then
        return self.buttonLabel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buttonLabel
        else
            return nil
        end
    end
end

---@return string 常显文本#客户端  常显文本
function cfg_union_activity:GetDes()
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

---@return string 规则文本#客户端  规则文本
function cfg_union_activity:GetRule()
    if self.rule ~= nil then
        return self.rule
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rule
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_UNION_ACTIVITY C#中的数据结构
function cfg_union_activity:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Union_ActivityTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_union_activity lua中的数据结构
function cfg_union_activity:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.rule = decodedData.rule
end

return cfg_union_activity