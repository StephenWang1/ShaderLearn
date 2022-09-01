--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_special_activity_goals
local cfg_special_activity_goals = {}

cfg_special_activity_goals.__index = cfg_special_activity_goals

function cfg_special_activity_goals:UUID()
    return self.id
end

---@return number 目标id#客户端#C  唯一id，纯自增
function cfg_special_activity_goals:GetId()
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

---@return number 目标类型#客户端#C  1.累计充值  2.击杀指定类型怪物   3.参与烤火  4.击杀敌对玩家  5.完成送花   6. 完成白日门活动   7.完成日常双倍领取   8.完成一次限时活动   9.完成塔罗牌翻牌   10.完成指定每日活动     11.完成角色转生(次数)  12.完成角色升级(次数)  13.完成宝物升级(次数)  14.完成首领调整次数
function cfg_special_activity_goals:GetGoalType()
    if self.goalType ~= nil then
        return self.goalType
    else
        if self:CsTABLE() ~= nil then
            self.goalType = self:CsTABLE().goalType
            return self.goalType
        else
            return nil
        end
    end
end

---@return number 目标参数#客户端#C  填写完成对应目标所需的数量参数，如goalType为1，该字段填3，表示击杀指定怪3次才算达成目标
function cfg_special_activity_goals:GetGoalParam()
    if self.goalParam ~= nil then
        return self.goalParam
    else
        if self:CsTABLE() ~= nil then
            self.goalParam = self:CsTABLE().goalParam
            return self.goalParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 目标附加参数#客户端#C  对应不同目标类型，含义不同。1.累计充值：结算单位(1钻石 2RMB)  2.击杀指定类型怪物：类型标记对应怪物表的group字段，怪物最小等级#怪物最大等级#group id#group id#group id...(怪物类型可填一个，可填多个)    4.击杀敌对玩家：击杀同一玩家是否计数(0不记录  1记录)   5.完成送花：(1玫瑰花  2金兰花)   6. 完成白日门活动：填写白日门活动表中的subType id(多个活动可任意生效时，用#连接)      8.完成一次限时活动：对应限时活动表，活动类型#活动id#子类id(填0表示对应位置参数不生效)
function cfg_special_activity_goals:GetGoalExtParams()
    if self.goalExtParams ~= nil then
        return self.goalExtParams
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goalExtParams
        else
            return nil
        end
    end
end

---@return string 目标的描述#客户端#C  对应条目显示在界面上的目标文本
function cfg_special_activity_goals:GetGoalShow()
    if self.goalShow ~= nil then
        return self.goalShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goalShow
        else
            return nil
        end
    end
end

---@return number 排序#客户端#C#不存在共同参与合并的字段  有需要的时候用到
function cfg_special_activity_goals:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SPECIAL_ACTIVITY_GOALS C#中的数据结构
function cfg_special_activity_goals:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_special_activity_goals lua中的数据结构
function cfg_special_activity_goals:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_special_activity_goals