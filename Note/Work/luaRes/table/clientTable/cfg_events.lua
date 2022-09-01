--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_events
local cfg_events = {}

cfg_events.__index = cfg_events

function cfg_events:UUID()
    return self.id
end

---@return number 服#客户端#C#不存在共同参与合并的字段  事件ID
function cfg_events:GetId()
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

---@return string 事件名称#客户端#C  事件名称
function cfg_events:GetName()
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

---@return TABLE.IntListXiaHuaXian 地图参数#客户端#C  type=1：map表id_x_y type=2：副本id  type=4：扣血类型(0绝对值1百分比)_扣血量_影响范围_次数_技能id
function cfg_events:GetParam()
    if self.param ~= nil then
        return self.param
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().param
        else
            return nil
        end
    end
end

---@return string 触发参数#客户端#C  根据triggertype配置不同的条件参数，triggertype=1不配置，triggertype=2任务id  type 4  爆炸倒计时，单位秒
function cfg_events:GetTriggerparam()
    if self.triggerparam ~= nil then
        return self.triggerparam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().triggerparam
        else
            return nil
        end
    end
end

---@return string 事件模型#客户端#C
function cfg_events:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().model
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 传送阵使用等级限制#客户端#C  关联cfg_conditions
function cfg_events:GetConditionId()
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

---@return number 范围类型#客户端#C  0圆1长方形2不规则
function cfg_events:GetRangeType()
    if self.rangeType ~= nil then
        return self.rangeType
    else
        if self:CsTABLE() ~= nil then
            self.rangeType = self:CsTABLE().rangeType
            return self.rangeType
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 不规则传送坐标#客户端#C  X轴#Y轴坐标
function cfg_events:GetIrregularList()
    if self.irregularList ~= nil then
        return self.irregularList
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().irregularList
        else
            return nil
        end
    end
end

---@return number 长方型的左上顶点x#客户端#C
function cfg_events:GetRectanglePtLeftUpX()
    if self.rectanglePtLeftUpX ~= nil then
        return self.rectanglePtLeftUpX
    else
        if self:CsTABLE() ~= nil then
            self.rectanglePtLeftUpX = self:CsTABLE().rectanglePtLeftUpX
            return self.rectanglePtLeftUpX
        else
            return nil
        end
    end
end

---@return number 长方型的左上顶点y#客户端#C
function cfg_events:GetRectanglePtLeftUpY()
    if self.rectanglePtLeftUpY ~= nil then
        return self.rectanglePtLeftUpY
    else
        if self:CsTABLE() ~= nil then
            self.rectanglePtLeftUpY = self:CsTABLE().rectanglePtLeftUpY
            return self.rectanglePtLeftUpY
        else
            return nil
        end
    end
end

---@return number 长方型的长#客户端#C
function cfg_events:GetRectangleLong()
    if self.rectangleLong ~= nil then
        return self.rectangleLong
    else
        if self:CsTABLE() ~= nil then
            self.rectangleLong = self:CsTABLE().rectangleLong
            return self.rectangleLong
        else
            return nil
        end
    end
end

---@return number 长方型的宽#客户端#C
function cfg_events:GetRectangleWidth()
    if self.rectangleWidth ~= nil then
        return self.rectangleWidth
    else
        if self:CsTABLE() ~= nil then
            self.rectangleWidth = self:CsTABLE().rectangleWidth
            return self.rectangleWidth
        else
            return nil
        end
    end
end

---@return number 长方型的范围#客户端#C  中线的粗细0一层1三层2五层，以此类推
function cfg_events:GetRectangleRange()
    if self.rectangleRange ~= nil then
        return self.rectangleRange
    else
        if self:CsTABLE() ~= nil then
            self.rectangleRange = self:CsTABLE().rectangleRange
            return self.rectangleRange
        else
            return nil
        end
    end
end

---@return number 对线#客户端#C  左上角对线1左下角对线2
function cfg_events:GetLineType()
    if self.lineType ~= nil then
        return self.lineType
    else
        if self:CsTABLE() ~= nil then
            self.lineType = self:CsTABLE().lineType
            return self.lineType
        else
            return nil
        end
    end
end

---@return number 事件倒计时描述#客户端#C  事件倒计时描述连接gloabl22349
function cfg_events:GetCountTimeDesc()
    if self.CountTimeDesc ~= nil then
        return self.CountTimeDesc
    else
        if self:CsTABLE() ~= nil then
            self.CountTimeDesc = self:CsTABLE().CountTimeDesc
            return self.CountTimeDesc
        else
            return nil
        end
    end
end

---@return string 传送阵副标题#客户端#C  传送阵副标题
function cfg_events:GetSubtitle()
    if self.subtitle ~= nil then
        return self.subtitle
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().subtitle
        else
            return nil
        end
    end
end

---@return number 事件类型_C
function cfg_events:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end
---@return number 事件范围_C
function cfg_events:GetEventRange()
    if self.eventRange ~= nil then
        return self.eventRange
    else
        if self:CsTABLE() ~= nil then
            self.eventRange = self:CsTABLE().eventRange
            return self.eventRange
        else
            return nil
        end
    end
end
---@return number 触发类型_C
function cfg_events:GetTriggertype()
    if self.triggertype ~= nil then
        return self.triggertype
    else
        if self:CsTABLE() ~= nil then
            self.triggertype = self:CsTABLE().triggertype
            return self.triggertype
        else
            return nil
        end
    end
end
---@return number 是否为秘密通道_C
function cfg_events:GetUnknowns()
    if self.unknowns ~= nil then
        return self.unknowns
    else
        if self:CsTABLE() ~= nil then
            self.unknowns = self:CsTABLE().unknowns
            return self.unknowns
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_EVENTS C#中的数据结构
function cfg_events:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_EventTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_events lua中的数据结构
function cfg_events:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_events