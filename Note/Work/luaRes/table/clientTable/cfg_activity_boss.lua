--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_activity_boss
local cfg_activity_boss = {}

cfg_activity_boss.__index = cfg_activity_boss

function cfg_activity_boss:UUID()
    return self.group
end

---@return number group#客户端#C  关联cfg_task表type为11的任务的subtype,为小组，每个小组包含数个task
function cfg_activity_boss:GetGroup()
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

---@return number 大组#客户端#C  批次，用于特殊判断
function cfg_activity_boss:GetBatch()
    if self.batch ~= nil then
        return self.batch
    else
        if self:CsTABLE() ~= nil then
            self.batch = self:CsTABLE().batch
            return self.batch
        else
            return nil
        end
    end
end

---@return number 等级段#客户端#C  等级段标识
function cfg_activity_boss:GetLevel()
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

---@return string 备注#客户端#C  策划用
function cfg_activity_boss:GetRemark()
    if self.remark ~= nil then
        return self.remark
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remark
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 出现条件#客户端#C  0.无条件 1.等级 2.任务id接取 3任务id完成 4.指定group任务全部完成（多个group#分隔）5.本组完成任意一个任务，多个条件&分隔(或逻辑）
function cfg_activity_boss:GetAppear()
    if self.appear ~= nil then
        return self.appear
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().appear
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 消失条件#客户端#C  1.等级 2.任务id接取 3任务id完成，多个条件&分隔
function cfg_activity_boss:GetDisappear()
    if self.disappear ~= nil then
        return self.disappear
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().disappear
        else
            return nil
        end
    end
end

---@return number 击杀类型#客户端#C  1点击传送 2打开BOSS面板
function cfg_activity_boss:GetType()
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

---@return string 界面标题#客户端#C  每个页签左上角图片展示，填图片名，不填代表不需要展示图片
function cfg_activity_boss:GetTitle()
    if self.title ~= nil then
        return self.title
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title
        else
            return nil
        end
    end
end

---@return string 页签名#客户端#C  对应页签的名字
function cfg_activity_boss:GetTableName()
    if self.tableName ~= nil then
        return self.tableName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tableName
        else
            return nil
        end
    end
end

---@return number 页签排序#客户端#C
function cfg_activity_boss:GetTableOrder()
    if self.tableOrder ~= nil then
        return self.tableOrder
    else
        if self:CsTABLE() ~= nil then
            self.tableOrder = self:CsTABLE().tableOrder
            return self.tableOrder
        else
            return nil
        end
    end
end

---@return string 按钮名#客户端#C
function cfg_activity_boss:GetButtonName()
    if self.buttonName ~= nil then
        return self.buttonName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buttonName
        else
            return nil
        end
    end
end

---@return string 按钮参数#客户端#C  点击按钮后对应操作所需参数，type为1  deliverid ；type为2的，BOSS面板的type和subtype
function cfg_activity_boss:GetButtonParam()
    if self.buttonParam ~= nil then
        return self.buttonParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buttonParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 坐标点#客户端#C  type1的按钮所需参数，x#y&x#y&…..
function cfg_activity_boss:GetPosition()
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

---@return number 奖励组#客户端#C  同组的全部完成后额外发放奖励  弃用
function cfg_activity_boss:GetRewardGroup()
    if self.rewardGroup ~= nil then
        return self.rewardGroup
    else
        if self:CsTABLE() ~= nil then
            self.rewardGroup = self:CsTABLE().rewardGroup
            return self.rewardGroup
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 点击条件#客户端  1.等级 2.转生等级 类型#数值
function cfg_activity_boss:GetOnClick()
    if self.onClick ~= nil then
        return self.onClick
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().onClick
        else
            return nil
        end
    end
end

---@return number 领取全部奖励后关闭页签#客户端  0关闭，1保留
function cfg_activity_boss:GetIsClose()
    if self.isClose ~= nil then
        return self.isClose
    else
        if self:CsTABLE() ~= nil then
            self.isClose = self:CsTABLE().isClose
            return self.isClose
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 完成奖励#客户端  本组所有任务目标完成后奖励  itemid#数量&itemid#数量
function cfg_activity_boss:GetCompleteReward()
    if self.completeReward ~= nil then
        return self.completeReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().completeReward
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 模型参数#客户端  本组内各怪物对应的boss表id  根据id中的模型处理参数处理对应怪物的模型显示  boss表id#boss表id   一般数量与组内怪物种类数量一致 若配少了或没配 则显示头像
function cfg_activity_boss:GetModelParam()
    if self.modelParam ~= nil then
        return self.modelParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().modelParam
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_ACTIVITY_BOSS C#中的数据结构
function cfg_activity_boss:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Activity_BossTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_activity_boss lua中的数据结构
function cfg_activity_boss:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.group = decodedData.group
    
    ---@private
    self.onClick = decodedData.onClick
    
    ---@private
    self.isClose = decodedData.isClose
    
    ---@private
    self.completeReward = decodedData.completeReward
    
    ---@private
    self.modelParam = decodedData.modelParam
end

return cfg_activity_boss