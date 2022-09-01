--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_vip_level
local cfg_vip_level = {}

cfg_vip_level.__index = cfg_vip_level

function cfg_vip_level:UUID()
    return self.vipLevel
end

---@return number VIP等级#客户端#不存在共同参与合并的字段  等级,0级开始
function cfg_vip_level:GetVipLevel()
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

---@return number 升到下级所需vip经验总值#客户端  升到下级所需vip经验总值,vip经验来源于消耗钻石
function cfg_vip_level:GetNeedExp()
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

---@return string 特权描述#客户端  对应等级vip特权,多条#分隔
function cfg_vip_level:GetPrivilege()
    if self.privilege ~= nil then
        return self.privilege
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().privilege
        else
            return nil
        end
    end
end

---@return number 离线泡点经验增加#客户端  增加的万分比
function cfg_vip_level:GetPaodianOfflineExp()
    if self.paodianOfflineExp ~= nil then
        return self.paodianOfflineExp
    else
        if self:CsTABLE() ~= nil then
            self.paodianOfflineExp = self:CsTABLE().paodianOfflineExp
            return self.paodianOfflineExp
        else
            return nil
        end
    end
end

---@return number 任务兑换卷可使用次数#客户端  每日每个任务兑换卷可使用的次数
function cfg_vip_level:GetDailyTaskPurchase()
    if self.dailyTaskPurchase ~= nil then
        return self.dailyTaskPurchase
    else
        if self:CsTABLE() ~= nil then
            self.dailyTaskPurchase = self:CsTABLE().dailyTaskPurchase
            return self.dailyTaskPurchase
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 宝箱每日使用次数#客户端  每日可使用白银宝箱、赤金宝箱的次数,宝箱id#次数&宝箱id#次数....,0代表无限
function cfg_vip_level:GetBoxUseTime()
    if self.boxUseTime ~= nil then
        return self.boxUseTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().boxUseTime
        else
            return nil
        end
    end
end

---@return number 铁匠铺维修价格下降万分比#客户端  铁匠铺维修价格
function cfg_vip_level:GetRepairCost()
    if self.repairCost ~= nil then
        return self.repairCost
    else
        if self:CsTABLE() ~= nil then
            self.repairCost = self:CsTABLE().repairCost
            return self.repairCost
        else
            return nil
        end
    end
end

---@return number 回收获得元宝增加万分比#客户端  回收获得元宝
function cfg_vip_level:GetRecycleUp()
    if self.recycleUp ~= nil then
        return self.recycleUp
    else
        if self:CsTABLE() ~= nil then
            self.recycleUp = self:CsTABLE().recycleUp
            return self.recycleUp
        else
            return nil
        end
    end
end

---@return number 日常任务卷轴可使用次数#客户端  每日每个任务兑换卷可使用卷轴的次数
function cfg_vip_level:GetDailyTaskjuanzhou()
    if self.dailyTaskjuanzhou ~= nil then
        return self.dailyTaskjuanzhou
    else
        if self:CsTABLE() ~= nil then
            self.dailyTaskjuanzhou = self:CsTABLE().dailyTaskjuanzhou
            return self.dailyTaskjuanzhou
        else
            return nil
        end
    end
end

---@return number 聚灵每日可积攒灵力数#客户端  每天0点能积攒的灵力数量
function cfg_vip_level:GetGatherSoulNum()
    if self.gatherSoulNum ~= nil then
        return self.gatherSoulNum
    else
        if self:CsTABLE() ~= nil then
            self.gatherSoulNum = self:CsTABLE().gatherSoulNum
            return self.gatherSoulNum
        else
            return nil
        end
    end
end

---@return string 聚灵等级#客户端  对应聚灵不同等级的文字展示
function cfg_vip_level:GetManaLevel()
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

---@return string vip图标#客户端  vip小图标#大图标
function cfg_vip_level:GetIconId()
    if self.IconId ~= nil then
        return self.IconId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().IconId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_VIP_LEVEL C#中的数据结构
function cfg_vip_level:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_vip_level lua中的数据结构
function cfg_vip_level:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.vipLevel = decodedData.vipLevel
    
    ---@private
    self.needExp = decodedData.needExp
    
    ---@private
    self.privilege = decodedData.privilege
    
    ---@private
    self.paodianOfflineExp = decodedData.paodianOfflineExp
    
    ---@private
    self.dailyTaskPurchase = decodedData.dailyTaskPurchase
    
    ---@private
    self.boxUseTime = decodedData.boxUseTime
    
    ---@private
    self.repairCost = decodedData.repairCost
    
    ---@private
    self.recycleUp = decodedData.recycleUp
    
    ---@private
    self.dailyTaskjuanzhou = decodedData.dailyTaskjuanzhou
    
    ---@private
    self.gatherSoulNum = decodedData.gatherSoulNum
    
    ---@private
    self.manaLevel = decodedData.manaLevel
    
    ---@private
    self.IconId = decodedData.IconId
end

return cfg_vip_level