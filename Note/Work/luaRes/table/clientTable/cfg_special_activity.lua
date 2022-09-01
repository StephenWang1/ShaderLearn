--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_special_activity
local cfg_special_activity = {}

cfg_special_activity.__index = cfg_special_activity

function cfg_special_activity:UUID()
    return self.id
end

---@return number id#C#客户端  第12位活动类型；第34位活动id；第567位编号
function cfg_special_activity:GetId()
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

---@return number 活动类型#客户端  1.开服活动；2.联服活动；3.合服活动；4.节日活动
function cfg_special_activity:GetEventType()
    if self.eventType ~= nil then
        return self.eventType
    else
        if self:CsTABLE() ~= nil then
            self.eventType = self:CsTABLE().eventType
            return self.eventType
        else
            return nil
        end
    end
end

---@return number 活动id#客户端  1塔罗牌上新 2怪物攻城 3限购礼包 4充值有礼 5集字狂欢 6boss重生 7狂欢任务 8狂欢商店 9消费排行 10占领皇宫 11合服攻沙 12狂欢密令 13经验狂欢 14塔罗暗殿 15登录有礼 16累充有礼 17挖宝活动 19挖宝回馈
function cfg_special_activity:GetEventId()
    if self.eventId ~= nil then
        return self.eventId
    else
        if self:CsTABLE() ~= nil then
            self.eventId = self:CsTABLE().eventId
            return self.eventId
        else
            return nil
        end
    end
end

---@return string 活动名称#客户端  页签名显示
function cfg_special_activity:GetEventName()
    if self.eventName ~= nil then
        return self.eventName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().eventName
        else
            return nil
        end
    end
end

---@return number 活动排序#客户端  活动在活动面板里页签的排序
function cfg_special_activity:GetOrder()
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

---@return number 子类id#客户端  某一活动存在多条奖励目标时，每条奖励目标分属不同的子类，同时起到在同页签内的排序作用
function cfg_special_activity:GetSmallId()
    if self.smallId ~= nil then
        return self.smallId
    else
        if self:CsTABLE() ~= nil then
            self.smallId = self:CsTABLE().smallId
            return self.smallId
        else
            return nil
        end
    end
end

---@return string 子类名称#客户端  条目内容描述
function cfg_special_activity:GetSmallName()
    if self.smallName ~= nil then
        return self.smallName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smallName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 活动任务目标参数#客户端  根据eventId不同，读取不同数据。（1神装首发关联box表id；3限购礼包关联recharge表id；4充值有礼直接读取累计金额参数；5集字狂欢配任务道具组合；7热血狂欢关联cfg_special_activity_goals表id；8狂欢商店，所需货币id#价格数量；9消费排行直接读取排名参数；13经验狂欢读取buff表id），多目标用#分隔；14塔罗暗殿，翻牌次数#转换守护层数；15登录有礼配置登录几天可领取奖励；16累充有礼，充值档位#累充天数
function cfg_special_activity:GetGoal()
    if self.goal ~= nil then
        return self.goal
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goal
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 活动奖励限制类型#客户端  （类型：1.个人领取；2.服务器总领取；3.个人每天可领取；4.服务器每天可领取）格式：类型id#限制次数，不填则不限
function cfg_special_activity:GetAwardType()
    if self.awardType ~= nil then
        return self.awardType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().awardType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 活动奖励数量限制#客户端  道具id或boxid#数量，数量按奖励类型来限制领取范围，塔罗暗殿di#职业#性别
function cfg_special_activity:GetAward()
    if self.award ~= nil then
        return self.award
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().award
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 付费解锁奖励#客户端  主要给狂欢密令使用，配置付费后才能解锁的奖励，道具id或boxid#数量&道具id或boxid#数量
function cfg_special_activity:GetChargeReward()
    if self.chargeReward ~= nil then
        return self.chargeReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().chargeReward
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端  前端显示用，conditionId#号分隔
function cfg_special_activity:GetDisplayCondition()
    if self.displayCondition ~= nil then
        return self.displayCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().displayCondition
        else
            return nil
        end
    end
end

---@return string 活动开启时间#客户端  根据eventType字段判断  1.开服活动，填开服天数；2.联服活动，填联服天数；3.合服活动，填合服天数；4.节日活动，填具体日期，年-月-日
function cfg_special_activity:GetEventOpen()
    if self.eventOpen ~= nil then
        return self.eventOpen
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().eventOpen
        else
            return nil
        end
    end
end

---@return number 活动持续时间#客户端  单位：天
function cfg_special_activity:GetEventLast()
    if self.eventLast ~= nil then
        return self.eventLast
    else
        if self:CsTABLE() ~= nil then
            self.eventLast = self:CsTABLE().eventLast
            return self.eventLast
        else
            return nil
        end
    end
end

---@return string 活动内容描述#客户端  用于活动介绍文本内容，可配置字色及换行、分段
function cfg_special_activity:GetDescription()
    if self.description ~= nil then
        return self.description
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().description
        else
            return nil
        end
    end
end

---@return number 提前展示时间#客户端  控制活动哪天（开服天数）开始提前展示
function cfg_special_activity:GetIsShow()
    if self.isShow ~= nil then
        return self.isShow
    else
        if self:CsTABLE() ~= nil then
            self.isShow = self:CsTABLE().isShow
            return self.isShow
        else
            return nil
        end
    end
end

---@return string 特殊图标#客户端  用于特惠礼包等活动的图片资源显示，填写icon在图集中的名字
function cfg_special_activity:GetIcon()
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

---@return string 背景图片#客户端  策划配置替换界面底图
function cfg_special_activity:GetPicture()
    if self.picture ~= nil then
        return self.picture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().picture
        else
            return nil
        end
    end
end

---@return string 对应打开界面#客户端  活动对应的界面
function cfg_special_activity:GetPanel()
    if self.panel ~= nil then
        return self.panel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 功能跳转#客户端  类型1:1#cfg_deliverID（点击后直接传送到目标地图坐标）；类型2:2#map_npcID（点击关闭当前界面，寻路到对应npc，然后打开npc面板）类型3：3#npcid# 挑最近的寻路 类型4:4#jumpid
function cfg_special_activity:GetOpenWay()
    if self.openWay ~= nil then
        return self.openWay
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openWay
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 生效条件#客户端  根据具体活动类型配置，经验狂欢：生效condition
function cfg_special_activity:GetSupply()
    if self.supply ~= nil then
        return self.supply
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().supply
        else
            return nil
        end
    end
end

---@return number 红点类型#客户端  塔罗暗殿红点控制用的，不懂问杨康杰
function cfg_special_activity:GetRedPoint()
    if self.redPoint ~= nil then
        return self.redPoint
    else
        if self:CsTABLE() ~= nil then
            self.redPoint = self:CsTABLE().redPoint
            return self.redPoint
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SPECIAL_ACTIVITY C#中的数据结构
function cfg_special_activity:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_special_activity lua中的数据结构
function cfg_special_activity:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.eventType = decodedData.eventType
    
    ---@private
    self.eventId = decodedData.eventId
    
    ---@private
    self.eventName = decodedData.eventName
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.smallId = decodedData.smallId
    
    ---@private
    self.smallName = decodedData.smallName
    
    ---@private
    self.goal = decodedData.goal
    
    ---@private
    self.awardType = decodedData.awardType
    
    ---@private
    self.award = decodedData.award
    
    ---@private
    self.chargeReward = decodedData.chargeReward
    
    ---@private
    self.displayCondition = decodedData.displayCondition
    
    ---@private
    self.eventOpen = decodedData.eventOpen
    
    ---@private
    self.eventLast = decodedData.eventLast
    
    ---@private
    self.description = decodedData.description
    
    ---@private
    self.isShow = decodedData.isShow
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.picture = decodedData.picture
    
    ---@private
    self.panel = decodedData.panel
    
    ---@private
    self.openWay = decodedData.openWay
    
    ---@private
    self.supply = decodedData.supply
    
    ---@private
    self.redPoint = decodedData.redPoint
end

return cfg_special_activity