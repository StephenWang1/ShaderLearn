--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_system_preview
local cfg_system_preview = {}

cfg_system_preview.__index = cfg_system_preview

function cfg_system_preview:UUID()
    return self.id
end

---@return number 唯一id#客户端  唯一id
function cfg_system_preview:GetId()
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

---@return string 功能名称#客户端  功能名称
function cfg_system_preview:GetName()
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

---@return string 显示图标#客户端  功能图标资源id
function cfg_system_preview:GetIconName()
    if self.iconName ~= nil then
        return self.iconName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().iconName
        else
            return nil
        end
    end
end

---@return string 预览图资源id#客户端  预览图资源id
function cfg_system_preview:GetImg()
    if self.img ~= nil then
        return self.img
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().img
        else
            return nil
        end
    end
end

---@return string 显示文本#客户端  显示文本
function cfg_system_preview:GetDesc()
    if self.desc ~= nil then
        return self.desc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().desc
        else
            return nil
        end
    end
end

---@return string 短文本#客户端
function cfg_system_preview:GetTips()
    if self.tips ~= nil then
        return self.tips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips
        else
            return nil
        end
    end
end

---@return string 开放条件文本#客户端
function cfg_system_preview:GetOpenTips()
    if self.openTips ~= nil then
        return self.openTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openTips
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 奖励id#客户端  道具id#数量&道具id#数量
function cfg_system_preview:GetReward()
    if self.reward ~= nil then
        return self.reward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reward
        else
            return nil
        end
    end
end

---@return number 跳转类型#客户端  :1、为jumpid、2、为deliverid传送至npc并打开界面
function cfg_system_preview:GetJumpType()
    if self.jumpType ~= nil then
        return self.jumpType
    else
        if self:CsTABLE() ~= nil then
            self.jumpType = self:CsTABLE().jumpType
            return self.jumpType
        else
            return nil
        end
    end
end

---@return string 跳转链接#客户端  跳转界面id
function cfg_system_preview:GetJump()
    if self.jump ~= nil then
        return self.jump
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().jump
        else
            return nil
        end
    end
end

---@return number 排序#客户端  排序
function cfg_system_preview:GetOrder()
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

---@return number 跳转限制#客户端  跳转限制
function cfg_system_preview:GetNotice()
    if self.notice ~= nil then
        return self.notice
    else
        if self:CsTABLE() ~= nil then
            self.notice = self:CsTABLE().notice
            return self.notice
        else
            return nil
        end
    end
end

---@return number 弹出气泡#客户端  气泡表id
function cfg_system_preview:GetPromptframe()
    if self.promptframe ~= nil then
        return self.promptframe
    else
        if self:CsTABLE() ~= nil then
            self.promptframe = self:CsTABLE().promptframe
            return self.promptframe
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SYSTEM_PREVIEW C#中的数据结构
function cfg_system_preview:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_system_preview lua中的数据结构
function cfg_system_preview:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.iconName = decodedData.iconName
    
    ---@private
    self.img = decodedData.img
    
    ---@private
    self.desc = decodedData.desc
    
    ---@private
    self.tips = decodedData.tips
    
    ---@private
    self.openTips = decodedData.openTips
    
    ---@private
    self.reward = decodedData.reward
    
    ---@private
    self.jumpType = decodedData.jumpType
    
    ---@private
    self.jump = decodedData.jump
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.notice = decodedData.notice
    
    ---@private
    self.promptframe = decodedData.promptframe
end

return cfg_system_preview