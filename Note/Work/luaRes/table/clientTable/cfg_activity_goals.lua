--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_activity_goals
local cfg_activity_goals = {}

cfg_activity_goals.__index = cfg_activity_goals

function cfg_activity_goals:UUID()
    return self.id
end

---@return number 条件id#客户端#C  唯一id，纯自增
function cfg_activity_goals:GetId()
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

---@return number 目标子类型类型#客户端#C  1不低于等级；2低于等级；3不低于转生等级；4低于转生等级；5不低于行会等级；6不低于VIP等级；7低于等于VIP等级；8开服天数不小于；9开服天数小于；10不低于战力；11低于战力；12主角光翼等级；13等级下限#等级上限#转生下限#转生上限；14消费元宝；15需要多少时间（分钟）；16固定时间（3600#7200表示距离凌晨3600秒时间到7200秒 即凌晨一点到两点）;17固定时间（星期）18一只灵兽等级达到；19两只灵兽等级达到；20三只灵兽等级达到；21声望值不低于；22宝石等级不低于；23灯芯等级不低于；24生命精魄等级不低于；25进攻之源等级不低于；26防守之源等级不低于；27进攻之源和防守之源同时不低于 ------|||开服活动定义用类型Start|||//1000人物等级；1001人物转生；1002寒芒等级；1003落星等级；1004天成等级；1005寒芒转生；1006落星转生；1007天成转生；1008战勋等级；1009全服目标完成，发放个人奖励；1010个人首杀；1011个人首爆；1012宝石等级；1013穿戴x件y级（或z转）以上装备，穿戴过就算；1014身上穿着x件装备升至y星；1015穿戴对应等级的勋章（勋章itemid合集#分隔）；1016镶嵌x个y级以上元素；1017穿戴n件 x类型（武器衣服防具首饰）y级或者z转以上装备；1018 灵兽总战力达到；1019灯芯等级；1020声望达到；1021活动期间消耗黑铁矿总数达到；1022.不低于等级或者不低于转升等级，满足一项条件即可; 3000全服首杀；3001首爆 ;3002首爆指定道具；3003回收指定类型装备；1023 装备专精总等级达到x//||||开服活动定义用类型End|||-----1024 官位等级读official_position
function cfg_activity_goals:GetGoalType()
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

---@return number 目标参数#客户端#C  1010、3000首杀类型monsterID 等级=
function cfg_activity_goals:GetGoalParam()
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

---@return TABLE.IntListJingHao 目标附加参数#客户端#C  1011和3001类型（首爆）参数格式：装备类型（1武器衣服2防具3首饰4首饰（包含防具）5只有武器 6只有衣服）#等级下限#等级上限（填99#99默认不判断）#转生下限#转生上限（填99#99默认不判断）；1013类型，y和z是或逻辑，满足其中一条就算完成；1017同1013，多一个件数n在最前；1022.等级#转生等级 0不限;3002填写itemID；3003填写itemid，多个itemid#分隔;
function cfg_activity_goals:GetGoalExtParams()
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

---@return string 目标的描述#客户端#C
function cfg_activity_goals:GetGoalShow()
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
function cfg_activity_goals:GetIndex()
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

--@return  TABLE.CFG_ACTIVITY_GOALS C#中的数据结构
function cfg_activity_goals:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_ActivityGoalsTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_activity_goals lua中的数据结构
function cfg_activity_goals:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_activity_goals