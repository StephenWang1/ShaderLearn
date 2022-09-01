--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_promptframe
local cfg_promptframe = {}

cfg_promptframe.__index = cfg_promptframe

function cfg_promptframe:UUID()
    return self.id
end

---@return number id#客户端  唯一ID
function cfg_promptframe:GetId()
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

---@return string 内容#客户端#C  气泡框显示内容
function cfg_promptframe:GetContent()
    if self.content ~= nil then
        return self.content
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().content
        else
            return nil
        end
    end
end

---@return string 界面#客户端#C  界面名称（填，则传指定传参；不填，则读取功能程序的默认传参）
function cfg_promptframe:GetPanels()
    if self.panels ~= nil then
        return self.panels
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panels
        else
            return nil
        end
    end
end

---@return string 组件路径#客户端#C  界面内组件路径（填，则传指定传参；不填，则读取功能程序的默认传参）
function cfg_promptframe:GetButton()
    if self.button ~= nil then
        return self.button
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().button
        else
            return nil
        end
    end
end

---@return string 朝向#客户端#C  1.上 2.下 3.左 4.右
function cfg_promptframe:GetDirection()
    if self.direction ~= nil then
        return self.direction
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().direction
        else
            return nil
        end
    end
end

---@return number Y轴#客户端#C  距离中心点距离（像素）：正数为向上，负数为向下，0为居中
function cfg_promptframe:GetDistance()
    if self.distance ~= nil then
        return self.distance
    else
        if self:CsTABLE() ~= nil then
            self.distance = self:CsTABLE().distance
            return self.distance
        else
            return nil
        end
    end
end

---@return number X轴#客户端#C  距离中心点距离（像素）：正数为向右，负数为向左，0为居中
function cfg_promptframe:GetDisplacement()
    if self.displacement ~= nil then
        return self.displacement
    else
        if self:CsTABLE() ~= nil then
            self.displacement = self:CsTABLE().displacement
            return self.displacement
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_PROMPTFRAME C#中的数据结构
function cfg_promptframe:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_promptframe lua中的数据结构
function cfg_promptframe:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_promptframe