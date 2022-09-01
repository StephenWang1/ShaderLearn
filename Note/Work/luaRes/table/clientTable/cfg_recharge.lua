--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_recharge
local cfg_recharge = {}

cfg_recharge.__index = cfg_recharge

function cfg_recharge:UUID()
    return self.id
end

---@return number id#客户端#C   id#客户端
function cfg_recharge:GetId()
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

---@return number 充值类型#客户端#C  1常规档次2首充档次6直购7活动充值8投资充值9零元购10猎魔人11限购礼包钻石购买3元宝礼包4新增钻石礼包13循环礼包14狂欢密令15新首充
function cfg_recharge:GetType()
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

---@return string 充值说明#客户端#C
function cfg_recharge:GetName()
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

---@return string 充值描述#客户端#C
function cfg_recharge:GetDesc()
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

---@return number 排序#客户端#C
function cfg_recharge:GetIndex()
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

---@return number 实发奖励包#客户端#C  boxID，展示效果
function cfg_recharge:GetReward()
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

---@return string 标题#客户端#C  前端显示用,资源名（背景#标题#礼包图片）
function cfg_recharge:GetTitle()
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

---@return string 使用的特效#客户端#C  特效id，仅充值档位用
function cfg_recharge:GetEffectId()
    if self.effectId ~= nil then
        return self.effectId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectId
        else
            return nil
        end
    end
end

---@return number 充值金额#客户端#C  价格除2之外不可重复，单位是分不是元
function cfg_recharge:GetRmb()
    if self.rmb ~= nil then
        return self.rmb
    else
        if self:CsTABLE() ~= nil then
            self.rmb = self:CsTABLE().rmb
            return self.rmb
        else
            return nil
        end
    end
end

---@return number 商店索引#客户端#C  有些不需要在这里实际购买的，转为买商店的物品，填写cfg_store表id
function cfg_recharge:GetStoreIndex()
    if self.storeIndex ~= nil then
        return self.storeIndex
    else
        if self:CsTABLE() ~= nil then
            self.storeIndex = self:CsTABLE().storeIndex
            return self.storeIndex
        else
            return nil
        end
    end
end

---@return number 商店价格#客户端#C  客户端用，storeIndex有填的字段这里填写价格用于展示
function cfg_recharge:GetClientPrice()
    if self.clientPrice ~= nil then
        return self.clientPrice
    else
        if self:CsTABLE() ~= nil then
            self.clientPrice = self:CsTABLE().clientPrice
            return self.clientPrice
        else
            return nil
        end
    end
end

---@return number 获得钻石数量#客户端#C  实际获得的（获得的不是钻石的，一律配在reward里）
function cfg_recharge:GetDiamond()
    if self.diamond ~= nil then
        return self.diamond
    else
        if self:CsTABLE() ~= nil then
            self.diamond = self:CsTABLE().diamond
            return self.diamond
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 获得返利钻石数量#客户端#C  每日第一次额外赠送的返利钻石数，vip下限#vip上限#数量&vip下限#vip上限#数量...
function cfg_recharge:GetBind()
    if self.bind ~= nil then
        return self.bind
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bind
        else
            return nil
        end
    end
end

---@return number 限购类型#客户端#C  1每日限购2终身限购
function cfg_recharge:GetLimitType()
    if self.limitType ~= nil then
        return self.limitType
    else
        if self:CsTABLE() ~= nil then
            self.limitType = self:CsTABLE().limitType
            return self.limitType
        else
            return nil
        end
    end
end

---@return number 限购次数#客户端#C
function cfg_recharge:GetLimitCount()
    if self.limitCount ~= nil then
        return self.limitCount
    else
        if self:CsTABLE() ~= nil then
            self.limitCount = self:CsTABLE().limitCount
            return self.limitCount
        else
            return nil
        end
    end
end

---@return string 购买限制#客户端#C  conditionId,&与 |或
function cfg_recharge:GetConditions()
    if self.conditions ~= nil then
        return self.conditions
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditions
        else
            return nil
        end
    end
end

---@return number 商品组#客户端#C  不同组互不影响
function cfg_recharge:GetGoodsGroup()
    if self.goodsGroup ~= nil then
        return self.goodsGroup
    else
        if self:CsTABLE() ~= nil then
            self.goodsGroup = self:CsTABLE().goodsGroup
            return self.goodsGroup
        else
            return nil
        end
    end
end

---@return number 商品id#客户端#C  一键直购的总和包id为0买了之后同组的就不可以买了，其余商品id不可相同(不同组的也不可以）
function cfg_recharge:GetGoodsId()
    if self.goodsId ~= nil then
        return self.goodsId
    else
        if self:CsTABLE() ~= nil then
            self.goodsId = self:CsTABLE().goodsId
            return self.goodsId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 生效时间#客户端#C  开服第几天开始#开服第几天结束，9999默认不结束
function cfg_recharge:GetEffectiveTime()
    if self.effectiveTime ~= nil then
        return self.effectiveTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectiveTime
        else
            return nil
        end
    end
end

---@return number 礼包类型#客户端#C  1是领奖-领奖页签下的限时礼包，2是领奖-终身限购页签下的礼包，不填或填0默认否
function cfg_recharge:GetIsTimeLimit()
    if self.isTimeLimit ~= nil then
        return self.isTimeLimit
    else
        if self:CsTABLE() ~= nil then
            self.isTimeLimit = self:CsTABLE().isTimeLimit
            return self.isTimeLimit
        else
            return nil
        end
    end
end

---@return number 首次充值返利道具间隔天数#客户端  开服第1天起，每x天作为一个时间段，在此时间段内的首次档位充值可领取奖励
function cfg_recharge:GetRebatePeriod()
    if self.rebatePeriod ~= nil then
        return self.rebatePeriod
    else
        if self:CsTABLE() ~= nil then
            self.rebatePeriod = self:CsTABLE().rebatePeriod
            return self.rebatePeriod
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 首次充值返利道具#客户端  开服天数开始#开服天数结束#返利box&开服天数开始#开服天数结束#返利box.....（代表领取返利时所处的开服天数，不同天数给对应的box）
function cfg_recharge:GetRebateBox()
    if self.rebateBox ~= nil then
        return self.rebateBox
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rebateBox
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 首次充值返利道具-展示用#客户端  rebateBox字段客户端特殊展示使用，不参与投放
function cfg_recharge:GetRebateBoxClient()
    if self.rebateBoxClient ~= nil then
        return self.rebateBoxClient
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rebateBoxClient
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 首次充值返利道具#客户端  当前在用，开服天数开始#开服天数结束#返利box&开服天数开始#开服天数结束#返利box.....（代表领取返利时所处的开服天数，不同天数给对应的box）
function cfg_recharge:GetRewardBox()
    if self.rewardBox ~= nil then
        return self.rewardBox
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewardBox
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RECHARGE C#中的数据结构
function cfg_recharge:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_RechargeTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_recharge lua中的数据结构
function cfg_recharge:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.rebatePeriod = decodedData.rebatePeriod
    
    ---@private
    self.rebateBox = decodedData.rebateBox
    
    ---@private
    self.rebateBoxClient = decodedData.rebateBoxClient
    
    ---@private
    self.rewardBox = decodedData.rewardBox
end

return cfg_recharge