--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_task
local cfg_task = {}

cfg_task.__index = cfg_task

function cfg_task:UUID()
    return self.id
end

---@return number 任务的id #客户端#C#不存在共同参与合并的字段  任务的id #客户端
function cfg_task:GetId()
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

---@return string 任务名称#客户端#C
function cfg_task:GetName()
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

---@return number 任务组结束标识#客户端#C  是否是环任务的最后一环
function cfg_task:GetIsend()
    if self.isend ~= nil then
        return self.isend
    else
        if self:CsTABLE() ~= nil then
            self.isend = self:CsTABLE().isend
            return self.isend
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端#C
function cfg_task:GetBeizhu()
    if self.beizhu ~= nil then
        return self.beizhu
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().beizhu
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 后置任务#客户端#C  #隔开主线和分线任务，分线失效接#前面的任务id，分线未失效接取后面的任务id
function cfg_task:GetNext()
    if self.next ~= nil then
        return self.next
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().next
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 推荐跳转#客户端#C  条对应task.jump表
function cfg_task:GetJump()
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

---@return TABLE.IntListJingHao 每日次数#客户端#C  每日免费次数#每日购买次数
function cfg_task:GetTimes()
    if self.times ~= nil then
        return self.times
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().times
        else
            return nil
        end
    end
end

---@return string 任务条件#客户端#C  （1等级达到 2等级低于 3转生达到 4转生低于 5开服天数达到 6开服天数低于 7指定日期）
function cfg_task:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 任务目标id#客户端#C  对应cfg_taskGoal，修改主线目标，对应分线任务的目标一定也需要修改
function cfg_task:GetTaskGoalId()
    if self.taskGoalId ~= nil then
        return self.taskGoalId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskGoalId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 采集目标#客户端#C  对应cfg_gather
function cfg_task:GetGatherId()
    if self.gatherId ~= nil then
        return self.gatherId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().gatherId
        else
            return nil
        end
    end
end

---@return string 任务奖励#客户端#C  丨后为环任务总奖励
function cfg_task:GetRewards()
    if self.rewards ~= nil then
        return self.rewards
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewards
        else
            return nil
        end
    end
end

---@return number 地图#客户端#C
function cfg_task:GetMapid()
    if self.mapid ~= nil then
        return self.mapid
    else
        if self:CsTABLE() ~= nil then
            self.mapid = self:CsTABLE().mapid
            return self.mapid
        else
            return nil
        end
    end
end

---@return number 怪物是否传送#客户端#C  1为传送 不填为不传
function cfg_task:GetDelivery()
    if self.delivery ~= nil then
        return self.delivery
    else
        if self:CsTABLE() ~= nil then
            self.delivery = self:CsTABLE().delivery
            return self.delivery
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 任务坐标#客户端#C  怪物悬赏类型此字段用于随机传送
function cfg_task:GetPosition()
    if self.position ~= nil then
        return self.position
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().position
        else
            return nil
        end
    end
end

---@return TABLE.IntListList NPC周围坐标#客户端#C
function cfg_task:GetNpcposition()
    if self.npcposition ~= nil then
        return self.npcposition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().npcposition
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 近点坐标#客户端#C
function cfg_task:GetNearposition()
    if self.nearposition ~= nil then
        return self.nearposition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().nearposition
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 远点客户端坐标#客户端#C
function cfg_task:GetFarposition()
    if self.farposition ~= nil then
        return self.farposition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().farposition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 坐标浮动值#客户端#C
function cfg_task:GetRandomRange()
    if self.randomRange ~= nil then
        return self.randomRange
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().randomRange
        else
            return nil
        end
    end
end

---@return string 服务器类型#客户端#C  判断该任务是否在跨服中显示  1普通服 3苍月岛 5神龙帝国
function cfg_task:GetServerType()
    if self.serverType ~= nil then
        return self.serverType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().serverType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 传送用NPC#客户端#C  不在任务目标地图，某些任务在点击后需要点击npc进行中转操作（目前是传送）  这里配置的是目标npc的mapnpcid  配多个时根据距离优先寻路较近的 比奇#土城
function cfg_task:GetCnpc()
    if self.cnpc ~= nil then
        return self.cnpc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cnpc
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 接取NPC#客户端#C
function cfg_task:GetFnpc()
    if self.fnpc ~= nil then
        return self.fnpc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().fnpc
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 提交NPC#客户端#C  提交任务的npc  mapnpcid
function cfg_task:GetTnpc()
    if self.tnpc ~= nil then
        return self.tnpc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tnpc
        else
            return nil
        end
    end
end

---@return string 偏移量#客户端#C
function cfg_task:GetDeviation()
    if self.deviation ~= nil then
        return self.deviation
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().deviation
        else
            return nil
        end
    end
end

---@return number 完成任务传送#客户端#C  0不传1传送
function cfg_task:GetOverchuan()
    if self.overchuan ~= nil then
        return self.overchuan
    else
        if self:CsTABLE() ~= nil then
            self.overchuan = self:CsTABLE().overchuan
            return self.overchuan
        else
            return nil
        end
    end
end

---@return number 提交任务传送#客户端#C  0不传1传送
function cfg_task:GetAddchuan()
    if self.addchuan ~= nil then
        return self.addchuan
    else
        if self:CsTABLE() ~= nil then
            self.addchuan = self:CsTABLE().addchuan
            return self.addchuan
        else
            return nil
        end
    end
end

---@return number 任务子类型#客户端#C  日常任务1铁匠2屠夫3药店4书店5水果6渔夫；
function cfg_task:GetTaskgroupid()
    if self.taskgroupid ~= nil then
        return self.taskgroupid
    else
        if self:CsTABLE() ~= nil then
            self.taskgroupid = self:CsTABLE().taskgroupid
            return self.taskgroupid
        else
            return nil
        end
    end
end

---@return string 立即完成花费#客户端#C  itemid#花费
function cfg_task:GetImmediately()
    if self.immediately ~= nil then
        return self.immediately
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().immediately
        else
            return nil
        end
    end
end

---@return string 多倍领取 #客户端#C  itemid#花费#倍数
function cfg_task:GetMutireward()
    if self.mutireward ~= nil then
        return self.mutireward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mutireward
        else
            return nil
        end
    end
end

---@return number 任务消耗道具 #客户端#C#不存在共同参与合并的字段  暂时没用
function cfg_task:GetItem()
    if self.item ~= nil then
        return self.item
    else
        if self:CsTABLE() ~= nil then
            self.item = self:CsTABLE().item
            return self.item
        else
            return nil
        end
    end
end

---@return string 任务栏任务信息1#客户端#C  未接收任务，任务栏中显示的目标信息
function cfg_task:GetTaskInfo()
    if self.taskInfo ~= nil then
        return self.taskInfo
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().taskInfo
        else
            return nil
        end
    end
end

---@return string 任务栏任务信息2#客户端#C  接受任务后，任务栏中显示的目标信息
function cfg_task:GetGoinfo()
    if self.goinfo ~= nil then
        return self.goinfo
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().goinfo
        else
            return nil
        end
    end
end

---@return string 任务栏任务信息3#客户端#C  完成任务后，任务栏中显示的目标信息
function cfg_task:GetCompleteinfo()
    if self.completeinfo ~= nil then
        return self.completeinfo
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().completeinfo
        else
            return nil
        end
    end
end

---@return string 完成任务面板文字#客户端#C
function cfg_task:GetTip3()
    if self.tip3 ~= nil then
        return self.tip3
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tip3
        else
            return nil
        end
    end
end

---@return string 接取任务时面板内容#客户端#C  主线任务里面 不显示右侧快速传送
function cfg_task:GetTips4()
    if self.tips4 ~= nil then
        return self.tips4
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips4
        else
            return nil
        end
    end
end

---@return number 小飞鞋（不填就是不能传送，1就是可以传送#客户端#C#不存在共同参与合并的字段  主线任务里面 不显示右侧快速传送
function cfg_task:GetNofly()
    if self.nofly ~= nil then
        return self.nofly
    else
        if self:CsTABLE() ~= nil then
            self.nofly = self:CsTABLE().nofly
            return self.nofly
        else
            return nil
        end
    end
end

---@return number 小飞鞋使用提醒#客户端#C#不存在共同参与合并的字段  1有提醒0不提醒
function cfg_task:GetFlyRemind()
    if self.flyRemind ~= nil then
        return self.flyRemind
    else
        if self:CsTABLE() ~= nil then
            self.flyRemind = self:CsTABLE().flyRemind
            return self.flyRemind
        else
            return nil
        end
    end
end

---@return number 传送ID#客户端#C  唯一ID
function cfg_task:GetDeliverid()
    if self.deliverid ~= nil then
        return self.deliverid
    else
        if self:CsTABLE() ~= nil then
            self.deliverid = self:CsTABLE().deliverid
            return self.deliverid
        else
            return nil
        end
    end
end

---@return number 传送位置#客户端#C  唯一ID
function cfg_task:GetPositiondeliverid()
    if self.positiondeliverid ~= nil then
        return self.positiondeliverid
    else
        if self:CsTABLE() ~= nil then
            self.positiondeliverid = self:CsTABLE().positiondeliverid
            return self.positiondeliverid
        else
            return nil
        end
    end
end

---@return number 交任务传送#客户端#C  寻路传送id，关联deliver
function cfg_task:GetFlyingDeliverid()
    if self.flyingDeliverid ~= nil then
        return self.flyingDeliverid
    else
        if self:CsTABLE() ~= nil then
            self.flyingDeliverid = self:CsTABLE().flyingDeliverid
            return self.flyingDeliverid
        else
            return nil
        end
    end
end

---@return number 任务进行中传送#客户端#C  任务进行中传送，关联deliver表
function cfg_task:GetHalfDeliverid()
    if self.halfDeliverid ~= nil then
        return self.halfDeliverid
    else
        if self:CsTABLE() ~= nil then
            self.halfDeliverid = self:CsTABLE().halfDeliverid
            return self.halfDeliverid
        else
            return nil
        end
    end
end

---@return string 提交任务打开面板#客户端#C  提交任务时，点击NPC效果 不填或0 打开左侧任务提交面板  配置的话则打开功能面板并点击相应按钮提交任务（配置相应面板名）
function cfg_task:GetSubmitShow()
    if self.submitShow ~= nil then
        return self.submitShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().submitShow
        else
            return nil
        end
    end
end

---@return number 完成任务后自动传送#客户端#C  完成任务后传送，配置后在完成任务的状态下  点击任务即可传送  这里实际使用的传送是flyingDeliverid中的配置 这里配置有值即可
function cfg_task:GetCompleteDeliver()
    if self.completeDeliver ~= nil then
        return self.completeDeliver
    else
        if self:CsTABLE() ~= nil then
            self.completeDeliver = self:CsTABLE().completeDeliver
            return self.completeDeliver
        else
            return nil
        end
    end
end

---@return string 传送NPC面板#客户端#C  组合cnpc字段使用   在寻路到npc附近后打开的面板名 若不配置 则会默认打开传送员面板
function cfg_task:GetCnpcPanel()
    if self.cnpcPanel ~= nil then
        return self.cnpcPanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().cnpcPanel
        else
            return nil
        end
    end
end

---@return number 任务组_C
function cfg_task:GetGroup()
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
---@return number 分线替换为主线ID_C
function cfg_task:GetChangeLine()
    if self.changeLine ~= nil then
        return self.changeLine
    else
        if self:CsTABLE() ~= nil then
            self.changeLine = self:CsTABLE().changeLine
            return self.changeLine
        else
            return nil
        end
    end
end
---@return number 任务类型_C
function cfg_task:GetType()
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

---@return number 任务子类型_C
function cfg_task:GetSubtype()
    if self.subtype ~= nil then
        return self.subtype
    else
        if self:CsTABLE() ~= nil then
            self.subtype = self:CsTABLE().subtype
            return self.subtype
        else
            return nil
        end
    end
end
---@return number 任务目标类型_C
function cfg_task:GetTaskGoalType()
    if self.taskGoalType ~= nil then
        return self.taskGoalType
    else
        if self:CsTABLE() ~= nil then
            self.taskGoalType = self:CsTABLE().taskGoalType
            return self.taskGoalType
        else
            return nil
        end
    end
end

---@return number 任务对话类型_C
function cfg_task:GetDialoguetype()
    if self.dialoguetype ~= nil then
        return self.dialoguetype
    else
        if self:CsTABLE() ~= nil then
            self.dialoguetype = self:CsTABLE().dialoguetype
            return self.dialoguetype
        else
            return nil
        end
    end
end
---@return number 是否直接传送_C
function cfg_task:GetChuansong()
    if self.chuansong ~= nil then
        return self.chuansong
    else
        if self:CsTABLE() ~= nil then
            self.chuansong = self:CsTABLE().chuansong
            return self.chuansong
        else
            return nil
        end
    end
end
---@return number 接取任务传送随机怪点_C
function cfg_task:GetGetchuan()
    if self.getchuan ~= nil then
        return self.getchuan
    else
        if self:CsTABLE() ~= nil then
            self.getchuan = self:CsTABLE().getchuan
            return self.getchuan
        else
            return nil
        end
    end
end
---@return number 任务限制(1时间_毫秒2死亡_次数_C
function cfg_task:GetLimit()
    if self.limit ~= nil then
        return self.limit
    else
        if self:CsTABLE() ~= nil then
            self.limit = self:CsTABLE().limit
            return self.limit
        else
            return nil
        end
    end
end

---@return number 自动接取任务_C
function cfg_task:GetState()
    if self.state ~= nil then
        return self.state
    else
        if self:CsTABLE() ~= nil then
            self.state = self:CsTABLE().state
            return self.state
        else
            return nil
        end
    end
end
---@return number 自动寻路_C
function cfg_task:GetAutopathing()
    if self.autopathing ~= nil then
        return self.autopathing
    else
        if self:CsTABLE() ~= nil then
            self.autopathing = self:CsTABLE().autopathing
            return self.autopathing
        else
            return nil
        end
    end
end
---@return number 自动战斗_C
function cfg_task:GetAutofight()
    if self.autofight ~= nil then
        return self.autofight
    else
        if self:CsTABLE() ~= nil then
            self.autofight = self:CsTABLE().autofight
            return self.autofight
        else
            return nil
        end
    end
end
---@return number 自动提交任务__C
function cfg_task:GetAutofinsh()
    if self.autofinsh ~= nil then
        return self.autofinsh
    else
        if self:CsTABLE() ~= nil then
            self.autofinsh = self:CsTABLE().autofinsh
            return self.autofinsh
        else
            return nil
        end
    end
end

---@return number 任务排序#客户端  目前仅怪物悬赏用，任务在界面内的排序
function cfg_task:GetOrder()
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

---@return number 自动任务暂停#客户端  配1 则在完成此任务后，不继续自动提交的流程  需玩家自行操作
function cfg_task:GetAutoPause()
    if self.autoPause ~= nil then
        return self.autoPause
    else
        if self:CsTABLE() ~= nil then
            self.autoPause = self:CsTABLE().autoPause
            return self.autoPause
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_TASK C#中的数据结构
function cfg_task:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_TaskTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_task lua中的数据结构
function cfg_task:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.autoPause = decodedData.autoPause
end

return cfg_task