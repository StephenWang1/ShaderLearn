--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_uilogic_close
local cfg_uilogic_close = {}

cfg_uilogic_close.__index = cfg_uilogic_close

function cfg_uilogic_close:UUID()
    return self.id
end

---@return number id#客户端  纯ID
function cfg_uilogic_close:GetId()
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

---@return TABLE.StringList 目标界面列表#客户端  填入需要关闭的界面名列表,或者需要规避关闭的界面名列表,具体情况依据前面的关闭类型和目标选择方式而定
function cfg_uilogic_close:GetTargetPanelList()
    if self.targetPanelList ~= nil then
        return self.targetPanelList
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().targetPanelList
        else
            return nil
        end
    end
end

---@return number 关闭类型
function cfg_uilogic_close:GetCloseType()
    return self.closeType2_targetSelectType2_uisetID4 >> 6 & 3
end
---@return number 关闭目标选择方式
function cfg_uilogic_close:GetTargetSelectType()
    return self.closeType2_targetSelectType2_uisetID4 >> 4 & 3
end
---@return number 目标界面集合ID
function cfg_uilogic_close:GetUisetID()
    return self.closeType2_targetSelectType2_uisetID4 & 15
end

--@return  TABLE.CFG_UILOGIC_CLOSE C#中的数据结构
function cfg_uilogic_close:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_uilogic_close lua中的数据结构
function cfg_uilogic_close:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.targetPanelList = decodedData.targetPanelList
    
    ---@private
    self.closeType2_targetSelectType2_uisetID4 = decodedData.closeType2_targetSelectType2_uisetID4
end

return cfg_uilogic_close