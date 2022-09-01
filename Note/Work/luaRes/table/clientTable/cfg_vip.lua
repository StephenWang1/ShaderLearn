--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_vip
local cfg_vip = {}

cfg_vip.__index = cfg_vip

function cfg_vip:UUID()
    return self.vipLevel
end

---@return number VIP等级#客户端#C#不存在共同参与合并的字段  等级，0级开始
function cfg_vip:GetVipLevel()
    if self.vipLevel ~= nil then
        return self.vipLevel
    else
        if self:CsTABLE() ~= nil then
            self.vipLevel = self:CsTABLE().vipLevel
            return self.vipLevel
        else
            return nil
        end
    end
end

---@return number 升到下级所需vip经验#客户端#C  升到下级所需vip经验
function cfg_vip:GetNeedExp()
    if self.needExp ~= nil then
        return self.needExp
    else
        if self:CsTABLE() ~= nil then
            self.needExp = self:CsTABLE().needExp
            return self.needExp
        else
            return nil
        end
    end
end

---@return string vip特权说明#客户端#C  特权描述说明
function cfg_vip:GetTips()
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

---@return TABLE.IntListJingHao 拍卖行上架道具最大数量#客户端#C  元宝物品上架#拍品上架#求购上架
function cfg_vip:GetAuctionCount()
    if self.auctionCount ~= nil then
        return self.auctionCount
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().auctionCount
        else
            return nil
        end
    end
end

---@return number 等级礼包id_C
function cfg_vip:GetLevelGift()
    if self.levelGift ~= nil then
        return self.levelGift
    else
        if self:CsTABLE() ~= nil then
            self.levelGift = self:CsTABLE().levelGift
            return self.levelGift
        else
            return nil
        end
    end
end
---@return number 经验buffid_C
function cfg_vip:GetBuffId()
    if self.buffId ~= nil then
        return self.buffId
    else
        if self:CsTABLE() ~= nil then
            self.buffId = self:CsTABLE().buffId
            return self.buffId
        else
            return nil
        end
    end
end
---@return number 攻击加成_C
function cfg_vip:GetAtkAdd()
    if self.atkAdd ~= nil then
        return self.atkAdd
    else
        if self:CsTABLE() ~= nil then
            self.atkAdd = self:CsTABLE().atkAdd
            return self.atkAdd
        else
            return nil
        end
    end
end
---@return number 原地复活次数_C
function cfg_vip:GetReborn()
    if self.reborn ~= nil then
        return self.reborn
    else
        if self:CsTABLE() ~= nil then
            self.reborn = self:CsTABLE().reborn
            return self.reborn
        else
            return nil
        end
    end
end
---@return number 每日祈祷上限_C
function cfg_vip:GetWishTime()
    if self.wishTime ~= nil then
        return self.wishTime
    else
        if self:CsTABLE() ~= nil then
            self.wishTime = self:CsTABLE().wishTime
            return self.wishTime
        else
            return nil
        end
    end
end
---@return number 经验丹使用次数_C
function cfg_vip:GetEatExpTime()
    if self.eatExpTime ~= nil then
        return self.eatExpTime
    else
        if self:CsTABLE() ~= nil then
            self.eatExpTime = self:CsTABLE().eatExpTime
            return self.eatExpTime
        else
            return nil
        end
    end
end
---@return number 聚魂珠免费多倍领取次数_C
function cfg_vip:GetExpBallReward()
    if self.expBallReward ~= nil then
        return self.expBallReward
    else
        if self:CsTABLE() ~= nil then
            self.expBallReward = self:CsTABLE().expBallReward
            return self.expBallReward
        else
            return nil
        end
    end
end

---@return number 聚魂珠经验存储速度_C
function cfg_vip:GetExpBallSpeed()
    if self.expBallSpeed ~= nil then
        return self.expBallSpeed
    else
        if self:CsTABLE() ~= nil then
            self.expBallSpeed = self:CsTABLE().expBallSpeed
            return self.expBallSpeed
        else
            return nil
        end
    end
end
---@return number 更多降妖伏魔次数_C
function cfg_vip:GetMoreTaskTime()
    if self.moreTaskTime ~= nil then
        return self.moreTaskTime
    else
        if self:CsTABLE() ~= nil then
            self.moreTaskTime = self:CsTABLE().moreTaskTime
            return self.moreTaskTime
        else
            return nil
        end
    end
end
---@return number vip回收次数_C
function cfg_vip:GetRecycleTimes()
    if self.recycleTimes ~= nil then
        return self.recycleTimes
    else
        if self:CsTABLE() ~= nil then
            self.recycleTimes = self:CsTABLE().recycleTimes
            return self.recycleTimes
        else
            return nil
        end
    end
end
---@return number 金条使用次数_C
function cfg_vip:GetGoldBar()
    if self.goldBar ~= nil then
        return self.goldBar
    else
        if self:CsTABLE() ~= nil then
            self.goldBar = self:CsTABLE().goldBar
            return self.goldBar
        else
            return nil
        end
    end
end
---@return number 每天可发语音次数_C
function cfg_vip:GetVoice()
    if self.voice ~= nil then
        return self.voice
    else
        if self:CsTABLE() ~= nil then
            self.voice = self:CsTABLE().voice
            return self.voice
        else
            return nil
        end
    end
end
---@return number 背包格子增加_C
function cfg_vip:GetAddBagGrid()
    if self.addBagGrid ~= nil then
        return self.addBagGrid
    else
        if self:CsTABLE() ~= nil then
            self.addBagGrid = self:CsTABLE().addBagGrid
            return self.addBagGrid
        else
            return nil
        end
    end
end
---@return number 挂机经验_C
function cfg_vip:GetExpUp()
    if self.expUp ~= nil then
        return self.expUp
    else
        if self:CsTABLE() ~= nil then
            self.expUp = self:CsTABLE().expUp
            return self.expUp
        else
            return nil
        end
    end
end

---@return number 挂机金币_C
function cfg_vip:GetCoinUp()
    if self.coinUp ~= nil then
        return self.coinUp
    else
        if self:CsTABLE() ~= nil then
            self.coinUp = self:CsTABLE().coinUp
            return self.coinUp
        else
            return nil
        end
    end
end
---@return number 重置帮会挑战次数_C
function cfg_vip:GetReUnionBos()
    if self.reUnionBos ~= nil then
        return self.reUnionBos
    else
        if self:CsTABLE() ~= nil then
            self.reUnionBos = self:CsTABLE().reUnionBos
            return self.reUnionBos
        else
            return nil
        end
    end
end
---@return number 一键扫荡个人boss_C
function cfg_vip:GetSweepBos()
    if self.sweepBos ~= nil then
        return self.sweepBos
    else
        if self:CsTABLE() ~= nil then
            self.sweepBos = self:CsTABLE().sweepBos
            return self.sweepBos
        else
            return nil
        end
    end
end
---@return number 帮派boos召唤次数增加_C
function cfg_vip:GetAddUnionBossNum()
    if self.addUnionBossNum ~= nil then
        return self.addUnionBossNum
    else
        if self:CsTABLE() ~= nil then
            self.addUnionBossNum = self:CsTABLE().addUnionBossNum
            return self.addUnionBossNum
        else
            return nil
        end
    end
end
---@return number 材料副本次数_C
function cfg_vip:GetAddMaterialNum()
    if self.addMaterialNum ~= nil then
        return self.addMaterialNum
    else
        if self:CsTABLE() ~= nil then
            self.addMaterialNum = self:CsTABLE().addMaterialNum
            return self.addMaterialNum
        else
            return nil
        end
    end
end

---@return number 灵兽聚灵数#客户端  对应等级每天能领取的灵力
function cfg_vip:GetServantMana()
    if self.servantMana ~= nil then
        return self.servantMana
    else
        if self:CsTABLE() ~= nil then
            self.servantMana = self:CsTABLE().servantMana
            return self.servantMana
        else
            return nil
        end
    end
end

---@return string 聚灵等级#客户端  对应聚灵不同等级的文字展示
function cfg_vip:GetManaLevel()
    if self.manaLevel ~= nil then
        return self.manaLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().manaLevel
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_VIP C#中的数据结构
function cfg_vip:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_VipTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_vip lua中的数据结构
function cfg_vip:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.vipLevel = decodedData.vipLevel
    
    ---@private
    self.servantMana = decodedData.servantMana
    
    ---@private
    self.manaLevel = decodedData.manaLevel
end

return cfg_vip