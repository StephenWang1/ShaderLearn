--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_yabiao
local cfg_yabiao = {}

cfg_yabiao.__index = cfg_yabiao

function cfg_yabiao:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  镖车id
function cfg_yabiao:GetId()
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

---@return number 地图#客户端#C  押镖地图ID
function cfg_yabiao:GetMap()
    if self.map ~= nil then
        return self.map
    else
        if self:CsTABLE() ~= nil then
            self.map = self:CsTABLE().map
            return self.map
        else
            return nil
        end
    end
end

---@return string 图标#客户端#C  发车界面右侧图片
function cfg_yabiao:GetPicture()
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

---@return TABLE.IntListJingHao NPC#客户端#C  对应发车#领取NPCID
function cfg_yabiao:GetNpcId()
    if self.npcId ~= nil then
        return self.npcId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().npcId
        else
            return nil
        end
    end
end

---@return string 镖车血量#客户端#C  每次攻击强制1点
function cfg_yabiao:GetDartHP()
    if self.dartHP ~= nil then
        return self.dartHP
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dartHP
        else
            return nil
        end
    end
end

---@return string 等级显示#客户端#C  对应等级显示图片
function cfg_yabiao:GetDartLvPicture()
    if self.dartLvPicture ~= nil then
        return self.dartLvPicture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dartLvPicture
        else
            return nil
        end
    end
end

---@return string 类型显示#客户端#C  对应类型图片
function cfg_yabiao:GetTypePicture()
    if self.typePicture ~= nil then
        return self.typePicture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().typePicture
        else
            return nil
        end
    end
end

---@return number 怪物id#客户端#C  对照怪物表
function cfg_yabiao:GetMid()
    if self.mid ~= nil then
        return self.mid
    else
        if self:CsTABLE() ~= nil then
            self.mid = self:CsTABLE().mid
            return self.mid
        else
            return nil
        end
    end
end

---@return string 镖车名字#客户端#C
function cfg_yabiao:GetName()
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

---@return TABLE.IntListJingHao 镖车消耗#客户端#C  道具ID#数量,（除个人押镖不用此字段）
function cfg_yabiao:GetConsume()
    if self.consume ~= nil then
        return self.consume
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().consume
        else
            return nil
        end
    end
end

---@return number 押镖时间#客户端#C  单位=分钟
function cfg_yabiao:GetWalkingTime()
    if self.walkingTime ~= nil then
        return self.walkingTime
    else
        if self:CsTABLE() ~= nil then
            self.walkingTime = self:CsTABLE().walkingTime
            return self.walkingTime
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 镖车奖励#客户端#C  数量#货币单位（除个人押镖不用此字段）
function cfg_yabiao:GetReward()
    if self.reward ~= nil then
        return self.reward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reward
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 押镖失败奖励#客户端#C  飙车被劫后奖励 （除个人押镖不用此字段）
function cfg_yabiao:GetFailReward()
    if self.failReward ~= nil then
        return self.failReward
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().failReward
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 劫镖奖励#客户端#C  盟重（除个人押镖不用此字段）
function cfg_yabiao:GetRobbery()
    if self.robbery ~= nil then
        return self.robbery
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().robbery
        else
            return nil
        end
    end
end

---@return number 掉落档次#客户端#C  每次少多少血掉落
function cfg_yabiao:GetArrangement()
    if self.arrangement ~= nil then
        return self.arrangement
    else
        if self:CsTABLE() ~= nil then
            self.arrangement = self:CsTABLE().arrangement
            return self.arrangement
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 掉落数量#客户端#C
function cfg_yabiao:GetDrop()
    if self.drop ~= nil then
        return self.drop
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().drop
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 掉落模式#客户端#C  1.随机掉落2.固定掉落
function cfg_yabiao:GetPattern()
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

---@return TABLE.IntListList 镖车路径#客户端#C
function cfg_yabiao:GetRoute()
    if self.route ~= nil then
        return self.route
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().route
        else
            return nil
        end
    end
end

---@return number 镖车类型_C
function cfg_yabiao:GetType()
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
---@return number 镖车等级_C
function cfg_yabiao:GetDartLv()
    if self.dartLv ~= nil then
        return self.dartLv
    else
        if self:CsTABLE() ~= nil then
            self.dartLv = self:CsTABLE().dartLv
            return self.dartLv
        else
            return nil
        end
    end
end

---@return number 连接到活动页签表#客户端  仅白日门押镖用，连接到cfg_bairimen_activity di
function cfg_yabiao:GetBairimenId()
    if self.bairimenId ~= nil then
        return self.bairimenId
    else
        if self:CsTABLE() ~= nil then
            self.bairimenId = self:CsTABLE().bairimenId
            return self.bairimenId
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 白日门镖车奖励#客户端  白日门押镖正常奖励，新的都用此字段
function cfg_yabiao:GetRewardNew()
    if self.rewardNew ~= nil then
        return self.rewardNew
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rewardNew
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 白日门押镖失败奖励#客户端  白日门镖车被劫后奖励，新的都用此字段
function cfg_yabiao:GetFailRewardNew()
    if self.failRewardNew ~= nil then
        return self.failRewardNew
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().failRewardNew
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 白日门劫镖奖励#客户端  白日门劫镖奖励，新的都用此字段
function cfg_yabiao:GetRobberyNew()
    if self.robberyNew ~= nil then
        return self.robberyNew
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().robberyNew
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 白日门镖车消耗#客户端  白日门镖车开启消耗，新的都用此字段
function cfg_yabiao:GetConsumeNew()
    if self.consumeNew ~= nil then
        return self.consumeNew
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().consumeNew
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_YABIAO C#中的数据结构
function cfg_yabiao:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_PersonDartCarTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_yabiao lua中的数据结构
function cfg_yabiao:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.bairimenId = decodedData.bairimenId
    
    ---@private
    self.rewardNew = decodedData.rewardNew
    
    ---@private
    self.failRewardNew = decodedData.failRewardNew
    
    ---@private
    self.robberyNew = decodedData.robberyNew
    
    ---@private
    self.consumeNew = decodedData.consumeNew
end

return cfg_yabiao