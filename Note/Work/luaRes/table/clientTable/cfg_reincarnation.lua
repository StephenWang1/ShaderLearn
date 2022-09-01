--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_reincarnation
local cfg_reincarnation = {}

cfg_reincarnation.__index = cfg_reincarnation

function cfg_reincarnation:UUID()
    return self.id
end

---@return number id#客户端#C  id不能动，动需要跟服务器说
function cfg_reincarnation:GetId()
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

---@return number 需要修为#客户端#C#不存在共同参与合并的字段  升到下级转生等级所需修为
function cfg_reincarnation:GetNeedEnergy()
    if self.needEnergy ~= nil then
        return self.needEnergy
    else
        if self:CsTABLE() ~= nil then
            self.needEnergy = self:CsTABLE().needEnergy
            return self.needEnergy
        else
            return nil
        end
    end
end

---@return number 最小攻击#客户端#C#不存在共同参与合并的字段  属性（战士加物理攻击，法师加魔法攻击，道士加道术攻击）；不填写数据，则不在面板中显示
function cfg_reincarnation:GetAtt()
    if self.att ~= nil then
        return self.att
    else
        if self:CsTABLE() ~= nil then
            self.att = self:CsTABLE().att
            return self.att
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最小物防#客户端#C  根据不同职业加成 职业#数值&职业#数值 1 战士 2 法师 3 道士；不填写数据，则不在面板中显示
function cfg_reincarnation:GetDef()
    if self.def ~= nil then
        return self.def
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().def
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最大物防#客户端#C  根据不同职业加成 职业#数值&职业#数值 1 战士 2 法师 3 道士；不填写数据，则不在面板中显示
function cfg_reincarnation:GetDefMax()
    if self.defMax ~= nil then
        return self.defMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().defMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最小魔防#客户端#C  根据不同职业加成 职业#数值&职业#数值 1 战士 2 法师 3 道士；不填写数据，则不在面板中显示
function cfg_reincarnation:GetDefMagic()
    if self.defMagic ~= nil then
        return self.defMagic
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().defMagic
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 最大魔防#客户端#C  根据不同职业加成 职业#数值&职业#数值 1 战士 2 法师 3 道士；不填写数据，则不在面板中显示
function cfg_reincarnation:GetDefMagicMax()
    if self.defMagicMax ~= nil then
        return self.defMagicMax
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().defMagicMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 血量#客户端#C  职业#血量，用&分隔（职业：1战士2法师3道士）；不填写数据，则不在面板中显示
function cfg_reincarnation:GetHp()
    if self.hp ~= nil then
        return self.hp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hp
        else
            return nil
        end
    end
end

---@return number 进入副本最低等级#客户端#C#不存在共同参与合并的字段  做转生神殿时用（未用）
function cfg_reincarnation:GetToLevel()
    if self.toLevel ~= nil then
        return self.toLevel
    else
        if self:CsTABLE() ~= nil then
            self.toLevel = self:CsTABLE().toLevel
            return self.toLevel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升到下级所需道具#客户端#C  所需道具和击杀BOSS只可填其1，另一个必须不填；conditionid#conditionid
function cfg_reincarnation:GetNeedItem()
    if self.needItem ~= nil then
        return self.needItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().needItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 开八门需要道具#客户端#C  conditionid#conditionid
function cfg_reincarnation:GetOpenNeedItem()
    if self.openNeedItem ~= nil then
        return self.openNeedItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openNeedItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 升到下级所需击杀BOSS#客户端#C  所需道具和击杀BOSS只可填其1，另一个必须不填；conditionid#conditionid
function cfg_reincarnation:GetBoss()
    if self.boss ~= nil then
        return self.boss
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().boss
        else
            return nil
        end
    end
end

---@return number 转生等级_C
function cfg_reincarnation:GetReincarnation()
    if self.reincarnation ~= nil then
        return self.reincarnation
    else
        if self:CsTABLE() ~= nil then
            self.reincarnation = self:CsTABLE().reincarnation
            return self.reincarnation
        else
            return nil
        end
    end
end
---@return number 需求等级_C
function cfg_reincarnation:GetNeedLevel()
    if self.needLevel ~= nil then
        return self.needLevel
    else
        if self:CsTABLE() ~= nil then
            self.needLevel = self:CsTABLE().needLevel
            return self.needLevel
        else
            return nil
        end
    end
end

---@return number 最大攻击_C
function cfg_reincarnation:GetAttMax()
    if self.attMax ~= nil then
        return self.attMax
    else
        if self:CsTABLE() ~= nil then
            self.attMax = self:CsTABLE().attMax
            return self.attMax
        else
            return nil
        end
    end
end
---@return number 准确_C
function cfg_reincarnation:GetAccurate()
    if self.accurate ~= nil then
        return self.accurate
    else
        if self:CsTABLE() ~= nil then
            self.accurate = self:CsTABLE().accurate
            return self.accurate
        else
            return nil
        end
    end
end

---@return number 闪避_C
function cfg_reincarnation:GetDodge()
    if self.dodge ~= nil then
        return self.dodge
    else
        if self:CsTABLE() ~= nil then
            self.dodge = self:CsTABLE().dodge
            return self.dodge
        else
            return nil
        end
    end
end
---@return number 转生神殿地图_C
function cfg_reincarnation:GetMapId()
    if self.mapId ~= nil then
        return self.mapId
    else
        if self:CsTABLE() ~= nil then
            self.mapId = self:CsTABLE().mapId
            return self.mapId
        else
            return nil
        end
    end
end

---@return number 转生八门#客户端
function cfg_reincarnation:GetEightDoor()
    if self.eightDoor ~= nil then
        return self.eightDoor
    else
        if self:CsTABLE() ~= nil then
            self.eightDoor = self:CsTABLE().eightDoor
            return self.eightDoor
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 额外参数#客户端  对应转生突破时的击杀BOSS条目数量，不填没有跳转；格式：bossid（暂不支持2个BOSS的跳转，需要的话需要客户端处理）
function cfg_reincarnation:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_REINCARNATION C#中的数据结构
function cfg_reincarnation:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_ReincarnationManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_reincarnation lua中的数据结构
function cfg_reincarnation:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.eightDoor = decodedData.eightDoor
    
    ---@private
    self.parameter = decodedData.parameter
end

return cfg_reincarnation