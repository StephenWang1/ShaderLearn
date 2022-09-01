--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_pick_up
local cfg_pick_up = {}

cfg_pick_up.__index = cfg_pick_up

function cfg_pick_up:UUID()
    return self.id
end

---@return number id#客户端#C  id
function cfg_pick_up:GetId()
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

---@return number 默认勾选#客户端#C  是否默认勾选，1勾选 0或不填不勾选
function cfg_pick_up:GetAutoChoose()
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

---@return number 是否显示#客户端#C  1为显示，0或不填不显示；生效则按照排序字段排序，不生效后方项目向前排序
function cfg_pick_up:GetEffective()
    if self.effective ~= nil then
        return self.effective
    else
        if self:CsTABLE() ~= nil then
            self.effective = self:CsTABLE().effective
            return self.effective
        else
            return nil
        end
    end
end

---@return string 类型文本#客户端  类型文本，本类型文本描述
function cfg_pick_up:GetDes()
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

---@return number 排序#客户端  排序，根据排序排列所有拾取类型
function cfg_pick_up:GetOrder()
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

--@return  TABLE.CFG_PICK_UP C#中的数据结构
function cfg_pick_up:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_PickUpTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_pick_up lua中的数据结构
function cfg_pick_up:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.order = decodedData.order
end

return cfg_pick_up