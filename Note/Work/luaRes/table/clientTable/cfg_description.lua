--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_description
local cfg_description = {}

cfg_description.__index = cfg_description

function cfg_description:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  编号
function cfg_description:GetId()
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

---@return number 系统划分#客户端#C#不存在共同参与合并的字段  根据系统划分（客户端写死，不可改）(第2345位划分系统，第67位为编号)
function cfg_description:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end

---@return string 描述内容#客户端#C  规则界面（#分段\n换行）活动面板（\n换行） 标题&内容&按钮
function cfg_description:GetValue()
    if self.value ~= nil then
        return self.value
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().value
        else
            return nil
        end
    end
end

---@return string 标题#客户端#C  说明标题栏（填入色值可自行换色）
function cfg_description:GetRemarks()
    if self.remarks ~= nil then
        return self.remarks
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remarks
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 内容更换#客户端  内容更换，在玩家达到一定条件后，更换显示为相应描述id的内容   condition#id&conditionid#id
function cfg_description:GetValueChange()
    if self.valueChange ~= nil then
        return self.valueChange
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().valueChange
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DESCRIPTION C#中的数据结构
function cfg_description:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_DescriptionTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_description lua中的数据结构
function cfg_description:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.valueChange = decodedData.valueChange
end

return cfg_description