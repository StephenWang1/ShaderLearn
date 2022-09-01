--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_uisets
local cfg_uisets = {}

cfg_uisets.__index = cfg_uisets

function cfg_uisets:UUID()
    return self.id
end

---@return number id#客户端  纯ID
function cfg_uisets:GetId()
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

---@return TABLE.StringList UI层级名列表#客户端  表示该UI面板集合包括哪些UI层级
function cfg_uisets:GetLayerNameList()
    if self.layerNameList ~= nil then
        return self.layerNameList
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().layerNameList
        else
            return nil
        end
    end
end

---@return TABLE.StringList UI界面名列表#客户端  表示该UI面板集合中包含了哪些界面
function cfg_uisets:GetPanelNameList()
    if self.panelNameList ~= nil then
        return self.panelNameList
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panelNameList
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao UI层级深度#客户端  层级深度列表,仅仅用于代码中,策划不用填此列,填了也没用
function cfg_uisets:GetDepth()
    if self.depth ~= nil then
        return self.depth
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().depth
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_UISETS C#中的数据结构
function cfg_uisets:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_uisets lua中的数据结构
function cfg_uisets:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.layerNameList = decodedData.layerNameList
    
    ---@private
    self.panelNameList = decodedData.panelNameList
    
    ---@private
    self.depth = decodedData.depth
end

return cfg_uisets