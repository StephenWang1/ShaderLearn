--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_member
local cfg_member = {}

cfg_member.__index = cfg_member

function cfg_member:UUID()
    return self.id
end

---@return number id#客户端  新玩家会员等级id为0
function cfg_member:GetId()
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

---@return string 会员名称#客户端
function cfg_member:GetName()
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

---@return string 会员等级图标#客户端  资源名称
function cfg_member:GetSpirit()
    if self.spirit ~= nil then
        return self.spirit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().spirit
        else
            return nil
        end
    end
end

---@return string 会员界面资源#客户端  资源名称
function cfg_member:GetTitleSprite()
    if self.titleSprite ~= nil then
        return self.titleSprite
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().titleSprite
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升级任务#客户端  升级到对应等级，不是下一等级，索引memberTask
function cfg_member:GetTask()
    if self.task ~= nil then
        return self.task
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().task
        else
            return nil
        end
    end
end

---@return number 会员等级奖励#客户端  索引boxId
function cfg_member:GetReward()
    if self.reward ~= nil then
        return self.reward
    else
        if self:CsTABLE() ~= nil then
            self.reward = self:CsTABLE().reward
            return self.reward
        else
            return nil
        end
    end
end

---@return string 特权说明#客户端
function cfg_member:GetTips()
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

---@return string 快捷跳转#客户端  0跳转充值，1#礼包弹窗#商店id
function cfg_member:GetJump()
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

---@return TABLE.IntListJingHao 秒升礼包价格#客户端  id#数量
function cfg_member:GetPrice()
    if self.price ~= nil then
        return self.price
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().price
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 每日奖励#客户端  itemId#num
function cfg_member:GetDailyReward()
    if self.dailyReward ~= nil then
        return self.dailyReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dailyReward
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 回收加成#客户端  回收id#参数万分比#回收id#万分比
function cfg_member:GetRecAdd()
    if self.recAdd ~= nil then
        return self.recAdd
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().recAdd
        else
            return nil
        end
    end
end

---@return number 增加终极boss每日击杀次数#客户端  增加的次数
function cfg_member:GetBossCount()
    if self.bossCount ~= nil then
        return self.bossCount
    else
        if self:CsTABLE() ~= nil then
            self.bossCount = self:CsTABLE().bossCount
            return self.bossCount
        else
            return nil
        end
    end
end

---@return number 增加击杀终极boss的额外购买次数#客户端  增加的额外购买次数
function cfg_member:GetExCount()
    if self.exCount ~= nil then
        return self.exCount
    else
        if self:CsTABLE() ~= nil then
            self.exCount = self:CsTABLE().exCount
            return self.exCount
        else
            return nil
        end
    end
end

---@return string 按钮下方文本#客户端
function cfg_member:GetButtonTips()
    if self.buttonTips ~= nil then
        return self.buttonTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buttonTips
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MEMBER C#中的数据结构
function cfg_member:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_member lua中的数据结构
function cfg_member:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.spirit = decodedData.spirit
    
    ---@private
    self.titleSprite = decodedData.titleSprite
    
    ---@private
    self.task = decodedData.task
    
    ---@private
    self.reward = decodedData.reward
    
    ---@private
    self.tips = decodedData.tips
    
    ---@private
    self.jump = decodedData.jump
    
    ---@private
    self.price = decodedData.price
    
    ---@private
    self.dailyReward = decodedData.dailyReward
    
    ---@private
    self.recAdd = decodedData.recAdd
    
    ---@private
    self.bossCount = decodedData.bossCount
    
    ---@private
    self.exCount = decodedData.exCount
    
    ---@private
    self.buttonTips = decodedData.buttonTips
end

return cfg_member