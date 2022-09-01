--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_daily_activity_time
local cfg_daily_activity_time = {}

cfg_daily_activity_time.__index = cfg_daily_activity_time

function cfg_daily_activity_time:UUID()
    return self.id
end

---@return number 活动id#客户端#C#不存在共同参与合并的字段  活动id
function cfg_daily_activity_time:GetId()
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

---@return string 活动简介#客户端#C  活动简介
function cfg_daily_activity_time:GetTips()
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

---@return TABLE.IntListJingHao 开服时间#客户端#C  开服第几天开启
function cfg_daily_activity_time:GetServiceTime()
    if self.serviceTime ~= nil then
        return self.serviceTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().serviceTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 合服时间#客户端#C  合服第几天开启活动
function cfg_daily_activity_time:GetMergeTime()
    if self.mergeTime ~= nil then
        return self.mergeTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mergeTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 周几开放#客户端#C  1234567表示星期一到星期天
function cfg_daily_activity_time:GetWeekday()
    if self.weekday ~= nil then
        return self.weekday
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().weekday
        else
            return nil
        end
    end
end

---@return number 是否有冷却时间，每次活动结束后几天内不会再次举行#客户端#C#不存在共同参与合并的字段  是否有冷却时间，每次活动结束后几天内不会再次举行
function cfg_daily_activity_time:GetTimeCD()
    if self.timeCD ~= nil then
        return self.timeCD
    else
        if self:CsTABLE() ~= nil then
            self.timeCD = self:CsTABLE().timeCD
            return self.timeCD
        else
            return nil
        end
    end
end

---@return number 开始时间距离0点的分钟#客户端#C#不存在共同参与合并的字段  开始时间距离0点的分钟
function cfg_daily_activity_time:GetStartTime()
    if self.startTime ~= nil then
        return self.startTime
    else
        if self:CsTABLE() ~= nil then
            self.startTime = self:CsTABLE().startTime
            return self.startTime
        else
            return nil
        end
    end
end

---@return number 结束时间距离0点的分钟#客户端#C#不存在共同参与合并的字段
function cfg_daily_activity_time:GetOverTime()
    if self.overTime ~= nil then
        return self.overTime
    else
        if self:CsTABLE() ~= nil then
            self.overTime = self:CsTABLE().overTime
            return self.overTime
        else
            return nil
        end
    end
end

---@return string 活动名称#客户端#C  必要时显示
function cfg_daily_activity_time:GetName()
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

---@return number 目标参数#客户端#C  不同事件用到的参数不同，暂用：等级封印事件的等级上限配置
function cfg_daily_activity_time:GetParam()
    if self.param ~= nil then
        return self.param
    else
        if self:CsTABLE() ~= nil then
            self.param = self:CsTABLE().param
            return self.param
        else
            return nil
        end
    end
end

---@return number 是否在历法界面显示#客户端#C  是否在历法界面显示
function cfg_daily_activity_time:GetIsCalendarShow()
    if self.isCalendarShow ~= nil then
        return self.isCalendarShow
    else
        if self:CsTABLE() ~= nil then
            self.isCalendarShow = self:CsTABLE().isCalendarShow
            return self.isCalendarShow
        else
            return nil
        end
    end
end

---@return number 大事件排序#客户端#C  开启时间相同的按照顺序决定优先级（0：特殊事件，强制成为当前最高优先级）
function cfg_daily_activity_time:GetOrder()
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

---@return TABLE.IntListJingHao 事件显示限制#客户端#C  开服几天后显示#合服几天后显示#活动前几天显示
function cfg_daily_activity_time:GetCalendarShowTime()
    if self.calendarShowTime ~= nil then
        return self.calendarShowTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().calendarShowTime
        else
            return nil
        end
    end
end

---@return string 主界面icon#客户端#C  主界面icon
function cfg_daily_activity_time:GetMainIcon()
    if self.mainIcon ~= nil then
        return self.mainIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mainIcon
        else
            return nil
        end
    end
end

---@return string icon#客户端#C  历法界面日期列表事件icon
function cfg_daily_activity_time:GetShowIcon()
    if self.showIcon ~= nil then
        return self.showIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showIcon
        else
            return nil
        end
    end
end

---@return string 背景图#客户端#C  背景图
function cfg_daily_activity_time:GetBackGround()
    if self.backGround ~= nil then
        return self.backGround
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().backGround
        else
            return nil
        end
    end
end

---@return string 规则面板#客户端#C  配置需要打开的界面名
function cfg_daily_activity_time:GetButtonType()
    if self.buttonType ~= nil then
        return self.buttonType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buttonType
        else
            return nil
        end
    end
end

---@return number 事件参与条件等级#客户端#C  事件参与条件等级（纯显示）
function cfg_daily_activity_time:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return string 奖励展示#客户端#C  奖励展示（道具id#数量&道具id#数量）（沙巴克：奖励描述#1#文本内容&奖励描述2#道具id_数量#道具id_数量；文本可配置颜色；&分隔显示不同的奖励内容；配置道具id则显示道具icon和数量）
function cfg_daily_activity_time:GetRewardShow()
    if self.rewardShow ~= nil then
        return self.rewardShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewardShow
        else
            return nil
        end
    end
end

---@return string 前往按钮点击效果#客户端#C  类型1:1#cfg_deliverID（点击后直接传送到目标地图坐标）；类型2:2#map_npcID（点击关闭历法界面，寻路到对应npc，然后打开npc面板）类型3：3#npcid 上次去过的主城的npcid 类型4:4#jumpid
function cfg_daily_activity_time:GetJumpButton()
    if self.jumpButton ~= nil then
        return self.jumpButton
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().jumpButton
        else
            return nil
        end
    end
end

---@return string 历法主界面图标倒计时提醒缩写#客户端#C  活动缩写，不配置则该活动不进行倒计时提醒
function cfg_daily_activity_time:GetCountdownRemind()
    if self.countdownRemind ~= nil then
        return self.countdownRemind
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().countdownRemind
        else
            return nil
        end
    end
end

---@return string 历法活动名字图标#客户端#C  历法活动名字图标
function cfg_daily_activity_time:GetNameIcon()
    if self.nameIcon ~= nil then
        return self.nameIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().nameIcon
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 进入活动切换模式#客户端#C  0和平模式，1组队模式，2行会模式，3全体模式，#后面接进入哪张地图切换模式
function cfg_daily_activity_time:GetPattern()
    if self.pattern ~= nil then
        return self.pattern
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().pattern
        else
            return nil
        end
    end
end

---@return string 活动大使打开面板#客户端#C  活动大使打开面板名
function cfg_daily_activity_time:GetPanelNameAndParams()
    if self.panelNameAndParams ~= nil then
        return self.panelNameAndParams
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panelNameAndParams
        else
            return nil
        end
    end
end

---@return string 活动大使背景图#客户端#C  活动大使背景图
function cfg_daily_activity_time:GetBgName()
    if self.bgName ~= nil then
        return self.bgName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bgName
        else
            return nil
        end
    end
end

---@return string 界面加载时，活动对应的加载图#客户端#C  界面加载时，活动对应的加载图
function cfg_daily_activity_time:GetLoading()
    if self.loading ~= nil then
        return self.loading
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().loading
        else
            return nil
        end
    end
end

---@return string 缩回左侧面板图标名#客户端#C  缩回左侧面板图标名
function cfg_daily_activity_time:GetLeftName()
    if self.leftName ~= nil then
        return self.leftName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().leftName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 活动地图#客户端#C  配置的活动地图id，用于判断玩家是否在活动地图里，在活动地图里则不显示外部图标；格式：地图id#地图id
function cfg_daily_activity_time:GetActivityMapId()
    if self.activityMapId ~= nil then
        return self.activityMapId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().activityMapId
        else
            return nil
        end
    end
end

---@return number 是否联服后显示#客户端#C  1联服显示0正常显示
function cfg_daily_activity_time:GetIsShare()
    if self.isShare ~= nil then
        return self.isShare
    else
        if self:CsTABLE() ~= nil then
            self.isShare = self:CsTABLE().isShare
            return self.isShare
        else
            return nil
        end
    end
end

---@return number 活动类型_C
function cfg_daily_activity_time:GetActivityType()
    if self.activityType ~= nil then
        return self.activityType
    else
        if self:CsTABLE() ~= nil then
            self.activityType = self:CsTABLE().activityType
            return self.activityType
        else
            return nil
        end
    end
end
---@return number 传送id_C
function cfg_daily_activity_time:GetDeliverId()
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

---@return string 规则界面背景小图#客户端  规则界面背景小图
function cfg_daily_activity_time:GetRuleBackGround()
    if self.ruleBackGround ~= nil then
        return self.ruleBackGround
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().ruleBackGround
        else
            return nil
        end
    end
end

---@return number 是否可领取历法小礼包#客户端  默认0不可领取，1可领取
function cfg_daily_activity_time:GetHaveGift()
    if self.haveGift ~= nil then
        return self.haveGift
    else
        if self:CsTABLE() ~= nil then
            self.haveGift = self:CsTABLE().haveGift
            return self.haveGift
        else
            return nil
        end
    end
end

---@return number 合服冷却天数#客户端  合服活动冷却天数
function cfg_daily_activity_time:GetMergeTimeCD()
    if self.mergeTimeCD ~= nil then
        return self.mergeTimeCD
    else
        if self:CsTABLE() ~= nil then
            self.mergeTimeCD = self:CsTABLE().mergeTimeCD
            return self.mergeTimeCD
        else
            return nil
        end
    end
end

---@return number 合服指定天数不开启#客户端  指定活动在合服前X天不开启活动
function cfg_daily_activity_time:GetMergeTimeProhibit()
    if self.mergeTimeProhibit ~= nil then
        return self.mergeTimeProhibit
    else
        if self:CsTABLE() ~= nil then
            self.mergeTimeProhibit = self:CsTABLE().mergeTimeProhibit
            return self.mergeTimeProhibit
        else
            return nil
        end
    end
end

---@return number 新系统判定#客户端  判定是否为新系统预告并显示相关资源 0否 1是  默认为0
function cfg_daily_activity_time:GetNewSystem()
    if self.newSystem ~= nil then
        return self.newSystem
    else
        if self:CsTABLE() ~= nil then
            self.newSystem = self:CsTABLE().newSystem
            return self.newSystem
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DAILY_ACTIVITY_TIME C#中的数据结构
function cfg_daily_activity_time:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_DailyActivityTimeTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_daily_activity_time lua中的数据结构
function cfg_daily_activity_time:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.ruleBackGround = decodedData.ruleBackGround
    
    ---@private
    self.haveGift = decodedData.haveGift
    
    ---@private
    self.mergeTimeCD = decodedData.mergeTimeCD
    
    ---@private
    self.mergeTimeProhibit = decodedData.mergeTimeProhibit
    
    ---@private
    self.newSystem = decodedData.newSystem
end

return cfg_daily_activity_time