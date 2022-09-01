--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_activity_current
local cfg_activity_current = {}

cfg_activity_current.__index = cfg_activity_current

function cfg_activity_current:UUID()
    return self.id
end

---@return number id#客户端  程序唯一标识(最大不可超过20位）,第12位活动类型；第34位活动id；第567位编号
function cfg_activity_current:GetId()
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

---@return number 页签id#客户端  同id的放在一个页签内，id从小到大排序
function cfg_activity_current:GetClientType()
    if self.clientType ~= nil then
        return self.clientType
    else
        if self:CsTABLE() ~= nil then
            self.clientType = self:CsTABLE().clientType
            return self.clientType
        else
            return nil
        end
    end
end

---@return number 排序#客户端  页签在活动面板里的排序
function cfg_activity_current:GetOrder()
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

---@return number 活动id#客户端  每个id程序单独写死（具体id多少由程序给）
function cfg_activity_current:GetActivityType()
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

---@return number 活动类型#客户端  类型可重复，代表对应活动所属的不同活动入口，关联cfg_notice表id 1联服活动2节日活动
function cfg_activity_current:GetGroup()
    if self.group ~= nil then
        return self.group
    else
        if self:CsTABLE() ~= nil then
            self.group = self:CsTABLE().group
            return self.group
        else
            return nil
        end
    end
end

---@return string 活动名称#客户端  必要时显示
function cfg_activity_current:GetName()
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

---@return number 活动页签#客户端  标记几条属于哪个页签
function cfg_activity_current:GetSmallGroup()
    if self.smallGroup ~= nil then
        return self.smallGroup
    else
        if self:CsTABLE() ~= nil then
            self.smallGroup = self:CsTABLE().smallGroup
            return self.smallGroup
        else
            return nil
        end
    end
end

---@return number smallid#客户端  某一活动存在多条奖励目标时，每条奖励目标分属不同的子类
function cfg_activity_current:GetSmallid()
    if self.smallid ~= nil then
        return self.smallid
    else
        if self:CsTABLE() ~= nil then
            self.smallid = self:CsTABLE().smallid
            return self.smallid
        else
            return nil
        end
    end
end

---@return string 活动描述#客户端
function cfg_activity_current:GetSmallname()
    if self.smallname ~= nil then
        return self.smallname
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().smallname
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 活动奖励#客户端  道具id#数量&道具id#数量（boxid与道具id相对应所以没关系）
function cfg_activity_current:GetAward()
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

---@return number 开服天数#客户端  开服多少天后对应的奖励没有不填
function cfg_activity_current:GetOpenDay()
    if self.openDay ~= nil then
        return self.openDay
    else
        if self:CsTABLE() ~= nil then
            self.openDay = self:CsTABLE().openDay
            return self.openDay
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 活动奖励2#客户端  开服至openDay之后对应的活动奖励变为此列
function cfg_activity_current:GetAward2()
    if self.award2 ~= nil then
        return self.award2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().award2
        else
            return nil
        end
    end
end

---@return number 奖励领取类型#客户端  1个人总领取2服务器总领取3个人每日领取4服务器每日领取5全服领取-服务器第1日注册数与固定值num对比动态取高值的奖励数量
function cfg_activity_current:GetAwardtype()
    if self.awardtype ~= nil then
        return self.awardtype
    else
        if self:CsTABLE() ~= nil then
            self.awardtype = self:CsTABLE().awardtype
            return self.awardtype
        else
            return nil
        end
    end
end

---@return number 数量限制#客户端  不填无限制
function cfg_activity_current:GetNum()
    if self.num ~= nil then
        return self.num
    else
        if self:CsTABLE() ~= nil then
            self.num = self:CsTABLE().num
            return self.num
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 奖励数量控制#客户端  awardType5的填此字段代表百分比
function cfg_activity_current:GetNumControl()
    if self.numControl ~= nil then
        return self.numControl
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().numControl
        else
            return nil
        end
    end
end

---@return number 领取方式#客户端  1点击领取后获得2邮件直接发送
function cfg_activity_current:GetGetway()
    if self.getway ~= nil then
        return self.getway
    else
        if self:CsTABLE() ~= nil then
            self.getway = self:CsTABLE().getway
            return self.getway
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 需达到条件#客户端  关联activity_goals表id，多个id#分隔代表需要依照次序满足（全服首爆的1、2、3名）
function cfg_activity_current:GetGoalIds()
    if self.goalIds ~= nil then
        return self.goalIds
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goalIds
        else
            return nil
        end
    end
end

---@return number 第二目标#客户端  前面的条件完成后才开始这个目标，saveType3使用
function cfg_activity_current:GetSecondGoal()
    if self.secondGoal ~= nil then
        return self.secondGoal
    else
        if self:CsTABLE() ~= nil then
            self.secondGoal = self:CsTABLE().secondGoal
            return self.secondGoal
        else
            return nil
        end
    end
end

---@return string 特殊参数#客户端  必要的参数
function cfg_activity_current:GetParam()
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

---@return number 活动开启时间类型#客户端  1开服天数2联服天数3固定时间（时间戳）4固定时间内开服走开服天数否则走固定时间5走时间戳遇到开服和合服天数不开 6创角天数 7condition条件8走时间戳遇到开服天数不开
function cfg_activity_current:GetTimeType()
    if self.timeType ~= nil then
        return self.timeType
    else
        if self:CsTABLE() ~= nil then
            self.timeType = self:CsTABLE().timeType
            return self.timeType
        else
            return nil
        end
    end
end

---@return number 开服天数开启#客户端
function cfg_activity_current:GetStartTime()
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

---@return number 开服天数持续时间结束#客户端
function cfg_activity_current:GetOverTime()
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

---@return number 联服次数#客户端  联服第几次开启
function cfg_activity_current:GetLfTime()
    if self.lfTime ~= nil then
        return self.lfTime
    else
        if self:CsTABLE() ~= nil then
            self.lfTime = self:CsTABLE().lfTime
            return self.lfTime
        else
            return nil
        end
    end
end

---@return number 联服天数开启#客户端  联服多少天后开启
function cfg_activity_current:GetLfStartTime()
    if self.lfStartTime ~= nil then
        return self.lfStartTime
    else
        if self:CsTABLE() ~= nil then
            self.lfStartTime = self:CsTABLE().lfStartTime
            return self.lfStartTime
        else
            return nil
        end
    end
end

---@return number 联服天数持续时间结束#客户端  开启后活动持续时间
function cfg_activity_current:GetLfOverTime()
    if self.lfOverTime ~= nil then
        return self.lfOverTime
    else
        if self:CsTABLE() ~= nil then
            self.lfOverTime = self:CsTABLE().lfOverTime
            return self.lfOverTime
        else
            return nil
        end
    end
end

---@return number 固定时间持续开始#客户端  配置时间戳(秒)
function cfg_activity_current:GetFixStartTime()
    if self.fixStartTime ~= nil then
        return self.fixStartTime
    else
        if self:CsTABLE() ~= nil then
            self.fixStartTime = self:CsTABLE().fixStartTime
            return self.fixStartTime
        else
            return nil
        end
    end
end

---@return number 固定时间结束#客户端  配置时间戳(秒)
function cfg_activity_current:GetFixOverTime()
    if self.fixOverTime ~= nil then
        return self.fixOverTime
    else
        if self:CsTABLE() ~= nil then
            self.fixOverTime = self:CsTABLE().fixOverTime
            return self.fixOverTime
        else
            return nil
        end
    end
end

---@return number 开启条件#客户端  动态开启，条件一旦不满足就关闭
function cfg_activity_current:GetOpenConditions()
    if self.openConditions ~= nil then
        return self.openConditions
    else
        if self:CsTABLE() ~= nil then
            self.openConditions = self:CsTABLE().openConditions
            return self.openConditions
        else
            return nil
        end
    end
end

---@return string 跳转链接#客户端  点击按钮跳转到其他界面的功能，视情况关联cfg_jump表或其他
function cfg_activity_current:GetLink()
    if self.link ~= nil then
        return self.link
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().link
        else
            return nil
        end
    end
end

---@return number 是否需要红点提醒#客户端  1需要红点提醒2不需要
function cfg_activity_current:GetRemind()
    if self.remind ~= nil then
        return self.remind
    else
        if self:CsTABLE() ~= nil then
            self.remind = self:CsTABLE().remind
            return self.remind
        else
            return nil
        end
    end
end

---@return string 活动文本描述#客户端
function cfg_activity_current:GetDescription()
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

---@return number 结束清数据不填不清#客户端  填1代表活动结束相关数据立刻清除
function cfg_activity_current:GetRepeats()
    if self.repeats ~= nil then
        return self.repeats
    else
        if self:CsTABLE() ~= nil then
            self.repeats = self:CsTABLE().repeats
            return self.repeats
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端  前端显示用，conditionId#号分隔
function cfg_activity_current:GetDisplayCondition()
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

---@return TABLE.IntListJingHao 目标达成后发送公告及显示条件#客户端  公告id#conditionId#conditionId#conditionId...（条件id可以是多个），此栏不填代表完成时不发公告
function cfg_activity_current:GetAnnounce()
    if self.announce ~= nil then
        return self.announce
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().announce
        else
            return nil
        end
    end
end

---@return string 背景图片#客户端  策划配置替换界面底图
function cfg_activity_current:GetPicture()
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

---@return string 活动图标#客户端  前端显示用
function cfg_activity_current:GetIcon()
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

---@return string 对应打开界面#客户端  活动对应的界面
function cfg_activity_current:GetPanel()
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

--@return  TABLE.CFG_ACTIVITY_CURRENT C#中的数据结构
function cfg_activity_current:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_activity_current lua中的数据结构
function cfg_activity_current:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.clientType = decodedData.clientType
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.activityType = decodedData.activityType
    
    ---@private
    self.group = decodedData.group
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.smallGroup = decodedData.smallGroup
    
    ---@private
    self.smallid = decodedData.smallid
    
    ---@private
    self.smallname = decodedData.smallname
    
    ---@private
    self.award = decodedData.award
    
    ---@private
    self.openDay = decodedData.openDay
    
    ---@private
    self.award2 = decodedData.award2
    
    ---@private
    self.awardtype = decodedData.awardtype
    
    ---@private
    self.num = decodedData.num
    
    ---@private
    self.numControl = decodedData.numControl
    
    ---@private
    self.getway = decodedData.getway
    
    ---@private
    self.goalIds = decodedData.goalIds
    
    ---@private
    self.secondGoal = decodedData.secondGoal
    
    ---@private
    self.param = decodedData.param
    
    ---@private
    self.timeType = decodedData.timeType
    
    ---@private
    self.startTime = decodedData.startTime
    
    ---@private
    self.overTime = decodedData.overTime
    
    ---@private
    self.lfTime = decodedData.lfTime
    
    ---@private
    self.lfStartTime = decodedData.lfStartTime
    
    ---@private
    self.lfOverTime = decodedData.lfOverTime
    
    ---@private
    self.fixStartTime = decodedData.fixStartTime
    
    ---@private
    self.fixOverTime = decodedData.fixOverTime
    
    ---@private
    self.openConditions = decodedData.openConditions
    
    ---@private
    self.link = decodedData.link
    
    ---@private
    self.remind = decodedData.remind
    
    ---@private
    self.description = decodedData.description
    
    ---@private
    self.repeats = decodedData.repeats
    
    ---@private
    self.displayCondition = decodedData.displayCondition
    
    ---@private
    self.announce = decodedData.announce
    
    ---@private
    self.picture = decodedData.picture
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.panel = decodedData.panel
end

return cfg_activity_current