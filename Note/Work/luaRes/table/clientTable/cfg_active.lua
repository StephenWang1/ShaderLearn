--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_active
local cfg_active = {}

cfg_active.__index = cfg_active

function cfg_active:UUID()
    return self.id
end

---@return number 目标id#客户端#C  每日目标任务id
function cfg_active:GetId()
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

---@return string 活动名称#客户端#C
function cfg_active:GetName()
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

---@return string 图标id#客户端#C
function cfg_active:GetIcon()
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

---@return string 目标描述#客户端#C
function cfg_active:GetDesc()
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

---@return number 第二状态次数#客户端#C  某一条活跃度领取了x次之后，不管其是否还有次数，优先级都会放低，排序在正常之后
function cfg_active:GetSecondStateTime()
    if self.secondStateTime ~= nil then
        return self.secondStateTime
    else
        if self:CsTABLE() ~= nil then
            self.secondStateTime = self:CsTABLE().secondStateTime
            return self.secondStateTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 每日开放时间#客户端#C  24小时制，开始时间#结束时间
function cfg_active:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().time
        else
            return nil
        end
    end
end

---@return number 传送npc#客户端#C  左侧传送id对应的map_npc的id
function cfg_active:GetNpc()
    if self.npc ~= nil then
        return self.npc
    else
        if self:CsTABLE() ~= nil then
            self.npc = self:CsTABLE().npc
            return self.npc
        else
            return nil
        end
    end
end

---@return string 使用参数#客户端#C  1.cfg_jump界面跳转id；2.任务类型 3
function cfg_active:GetParamter()
    if self.paramter ~= nil then
        return self.paramter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().paramter
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHaoMeiYuan 奖励#客户端#C  道具id#数量
function cfg_active:GetAwards()
    if self.awards ~= nil then
        return self.awards
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().awards
        else
            return nil
        end
    end
end

---@return string 奖励说明#客户端#C
function cfg_active:GetAwardsTips()
    if self.awardsTips ~= nil then
        return self.awardsTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().awardsTips
        else
            return nil
        end
    end
end

---@return number 开启时间#客户端#C#不存在共同参与合并的字段  开服第n天开启（否则该任务不显示）
function cfg_active:GetOpenTime()
    if self.openTime ~= nil then
        return self.openTime
    else
        if self:CsTABLE() ~= nil then
            self.openTime = self:CsTABLE().openTime
            return self.openTime
        else
            return nil
        end
    end
end

---@return number 是否参与随机排序#客户端#C  1是0不是；开服前3天，每位玩家会有各自的一套日活条目随机排序，3天以后全部统一表里默认排序，这里填0的，固定位置为id序号
function cfg_active:GetIsSort()
    if self.isSort ~= nil then
        return self.isSort
    else
        if self:CsTABLE() ~= nil then
            self.isSort = self:CsTABLE().isSort
            return self.isSort
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 额外奖励#客户端#C  领取活跃时额外附赠的奖励内容，道具#数量&道具#数量...
function cfg_active:GetExtraAward()
    if self.extraAward ~= nil then
        return self.extraAward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraAward
        else
            return nil
        end
    end
end

---@return number 排序#客户端#C  排序用
function cfg_active:GetOrder()
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

---@return number 目标类型_C
function cfg_active:GetType()
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
---@return number 目标类型_C
function cfg_active:GetGoal()
    if self.goal ~= nil then
        return self.goal
    else
        if self:CsTABLE() ~= nil then
            self.goal = self:CsTABLE().goal
            return self.goal
        else
            return nil
        end
    end
end
---@return number 目标数_C
function cfg_active:GetCount()
    if self.count ~= nil then
        return self.count
    else
        if self:CsTABLE() ~= nil then
            self.count = self:CsTABLE().count
            return self.count
        else
            return nil
        end
    end
end
---@return number 增加活跃度_C
function cfg_active:GetBonus()
    if self.bonus ~= nil then
        return self.bonus
    else
        if self:CsTABLE() ~= nil then
            self.bonus = self:CsTABLE().bonus
            return self.bonus
        else
            return nil
        end
    end
end

---@return number 任务开放等级_C
function cfg_active:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end
---@return number 传送事件_C
function cfg_active:GetDeliverId()
    if self.deliverId ~= nil then
        return self.deliverId
    else
        if self:CsTABLE() ~= nil then
            self.deliverId = self:CsTABLE().deliverId
            return self.deliverId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 日常任务对应日常任务卷轴#客户端  任务对应道具，道具#道具
function cfg_active:GetJuanzhou()
    if self.juanzhou ~= nil then
        return self.juanzhou
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().juanzhou
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ACTIVE C#中的数据结构
function cfg_active:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_ActiveTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_active lua中的数据结构
function cfg_active:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.juanzhou = decodedData.juanzhou
end

return cfg_active