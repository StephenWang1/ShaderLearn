--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_member_task
local cfg_member_task = {}

cfg_member_task.__index = cfg_member_task

function cfg_member_task:UUID()
    return self.id
end

---@return number id#客户端#c  id
function cfg_member_task:GetId()
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

---@return number 任务类型#客户端  1满足条件；2击杀指定怪物id；3升级宝物；4使用道具；5封号等级；6人物等级；7转生等级；8攻击力；9完成悬赏任务；10经验池兑换；11法阵
function cfg_member_task:GetType()
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

---@return TABLE.IntListJingHao 任务参数#客户端  如果多个参数，次数要放在第一位，1索引condition；2击杀次数#怪物id#怪物id；3次数；4使用个数#道具type#subtype；5封号等级；6人物等级；7转生等级；8攻击力；9悬赏groupId
function cfg_member_task:GetUseParam()
    if self.useParam ~= nil then
        return self.useParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().useParam
        else
            return nil
        end
    end
end

---@return string 任务描述#客户端
function cfg_member_task:GetDes()
    if self.des ~= nil then
        return self.des
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().des
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 功能跳转#客户端  类型1:1#cfg_deliverID，点击后传送到坐标；类型2:2#map_npcID，点击关闭当前界面，寻路到对应npc，然后打开npc面板；类型3：3#npcid#，挑最近的寻路；类型4：4#jumpId，打开界面；类型5：5#deliverId；类型6：6#task subTyoe；类型7：7#bossType#页签type，global22568；类型8：8#,类型9,9#waygetid#
function cfg_member_task:GetOpenWay()
    if self.openWay ~= nil then
        return self.openWay
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openWay
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MEMBER_TASK C#中的数据结构
function cfg_member_task:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_member_task lua中的数据结构
function cfg_member_task:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.useParam = decodedData.useParam
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.openWay = decodedData.openWay
end

return cfg_member_task