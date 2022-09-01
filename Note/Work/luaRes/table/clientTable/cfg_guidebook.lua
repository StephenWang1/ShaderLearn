--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_guidebook
local cfg_guidebook = {}

cfg_guidebook.__index = cfg_guidebook

function cfg_guidebook:UUID()
    return self.id
end

---@return number 唯一id#客户端
function cfg_guidebook:GetId()
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

---@return string 页签名称#客户端
function cfg_guidebook:GetMarkName()
    if self.markName ~= nil then
        return self.markName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().markName
        else
            return nil
        end
    end
end

---@return string 一级标题#客户端  显示在界面最上方（不填则不显示，下方文本自动上移），字号固定36号，字色ffff00
function cfg_guidebook:GetMainTitle()
    if self.mainTitle ~= nil then
        return self.mainTitle
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mainTitle
        else
            return nil
        end
    end
end

---@return string 文本正文#客户端  文本,需要显示道具icon的，用{0}代替占位，然后根据icon字段配置的道具id顺序对应显示
function cfg_guidebook:GetText()
    if self.text ~= nil then
        return self.text
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().text
        else
            return nil
        end
    end
end

---@return string 图标显示#客户端  根据type判断具体显示形式，itemId#career#sex#effectId#X坐标#Y坐标&itemId#career#sex#effectId#X坐标#Y坐标&itemId#career#sex#effectId#X坐标#Y坐标，1战2法3道，1男2女，通用道具职业、性别都填0，没有特效也填0
function cfg_guidebook:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return number 行间距#客户端  控制当前页签内所有文本的行间距，不填则按默认的16px行间距
function cfg_guidebook:GetLineSpace()
    if self.lineSpace ~= nil then
        return self.lineSpace
    else
        if self:CsTABLE() ~= nil then
            self.lineSpace = self:CsTABLE().lineSpace
            return self.lineSpace
        else
            return nil
        end
    end
end

---@return number 排序#客户端  按大小来排序，小的往前排
function cfg_guidebook:GetOrder()
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

---@return TABLE.IntListJingHao 显示条件#客户端  连condition表格显示条件
function cfg_guidebook:GetConditionId()
    if self.conditionId ~= nil then
        return self.conditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GUIDEBOOK C#中的数据结构
function cfg_guidebook:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_guidebook lua中的数据结构
function cfg_guidebook:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.markName = decodedData.markName
    
    ---@private
    self.mainTitle = decodedData.mainTitle
    
    ---@private
    self.text = decodedData.text
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.lineSpace = decodedData.lineSpace
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.conditionId = decodedData.conditionId
end

return cfg_guidebook