---@class LuaRecastEquipIndex:luaobject 重铸的装备位
local LuaRecastEquipIndex = {}

--region 数据
---@type equipV2.JewelryRecastInfo 服务器数据
LuaRecastEquipIndex.serverData = nil
---@type LuaEquipmentItemType 装备位
LuaRecastEquipIndex.equipIndex = nil
---@type TABLE.cfg_recast 重铸表
LuaRecastEquipIndex.recastTbl = nil
---@type TABLE.cfg_recast 下一级重铸表
LuaRecastEquipIndex.nextRecastTbl = nil
---@type table<CostItemInfo> 升级重铸道具消耗
LuaRecastEquipIndex.UpRecastItemCost = nil
---@type table<CostItemInfo> 升级重铸货币消耗
LuaRecastEquipIndex.UpRecastCoinCost = nil
---@type table<AttributeDes>属性列表
LuaRecastEquipIndex.AttributeList = nil
---@type string 属性内容
LuaRecastEquipIndex.AttributeDes = nil
---@type LuaEnumCareer 职业
LuaRecastEquipIndex.career = nil
---@type number 重铸等级
LuaRecastEquipIndex.recastLevel = nil
---@type table<TABLE.cfg_recast_skill> 等级特效信息列表
LuaRecastEquipIndex.LevelEffectInfoList = nil
--endregion

--region 数据结构

---@class CostItemInfo
---@field itemId number 道具id
---@field costNumber number 花费数量

---@class LevelEffectInfo 等级特效信息
---@field state boolean 开关状态
---@field buffTbl TABLE.cfg_buff buff信息

--endregion

--region 数据刷新
---@param tblData equipV2.JewelryRecastInfo
---@param career LuaEnumCareer
function LuaRecastEquipIndex:RefreshEquipIndexRecastInfo(tblData,career)
    if tblData == nil or tblData.type == nil or tblData.level == nil then
        return
    end
    self.serverData = tblData
    self.equipIndex = tblData.type
    self.recastLevel = tblData.level
    self.career = ternary(career == nil,Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career),career)
    self:InitTblData(tblData.type,tblData.level)
    self:RefreshAttributeList(self.career)
    self:RefreshLevelEffectInfoList()
end

---默认数据初始化
---@param type LuaEnumRecastType
---@param career LuaEnumCareer
function LuaRecastEquipIndex:DefaultDataInit(type,career)
    self.equipIndex = type
    self.recastLevel = 0
    self.career = ternary(career == nil,Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career),career)
    self:InitTblData(type,0)
    self:RefreshAttributeList(self.career)
    self:RefreshLevelEffectInfoList()
end

---刷新表格相关数据
function LuaRecastEquipIndex:InitTblData(type,level)
    self.recastTbl = clientTableManager.cfg_recastManager:GetRecastTbl(type,level)
    self.nextRecastTbl = clientTableManager.cfg_recastManager:GetRecastTbl(type,level + 1)
    if self.nextRecastTbl ~= nil then
        self.UpRecastItemCost = clientTableManager.cfg_recastManager:GetUpRecastItemCost(self.nextRecastTbl:GetId())
        self.UpRecastCoinCost = clientTableManager.cfg_recastManager:GetUpRecastCoinCost(self.nextRecastTbl:GetId())
    end
end

---刷新属性列表
function LuaRecastEquipIndex:RefreshAttributeList(career)
    if type(career) == 'number' and self.recastTbl ~= nil and self.recastTbl:GetAtt() ~= nil then
        self.AttributeList = clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeDesList(self.recastTbl:GetAtt(),career)
        local nextAttributeList
        if self.nextRecastTbl ~= nil then
            nextAttributeList = clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeDesList(self.nextRecastTbl:GetAtt(),career)
        end
        if self.AttributeList == nil or Utility.GetLuaTableCount(self.AttributeList) <= 0 then
            for k,v in pairs(nextAttributeList) do
                ---@type AttributeDes
                local attributeDes = v
                self.AttributeList[k] = Utility.CopyTable(attributeDes)
                self.AttributeList[k].attributeValueDes = "0"
                self.AttributeList[k].attributeNextValueDes = attributeDes.attributeValueDes
            end
        else
            for k,v in pairs(self.AttributeList) do
                ---@type AttributeDes
                local attributeDes = v
                if type(nextAttributeList) == 'table' then
                    if nextAttributeList[k] ~= nil then
                        attributeDes.attributeNextValueDes = nextAttributeList[k].attributeValueDes
                    end
                else
                    attributeDes.attributeNextValueDes = "已达最大值"
                end
            end
        end
    end
    if self.recastTbl ~= nil then
        self.AttributeDes = clientTableManager.cfg_extra_mon_effectManager:GetAllAttributeShow(self.recastTbl:GetAtt(),career)
    end
    self:SortAndFilterAttributeList()
end

---筛选并排序属性列表(有配表：则筛选并按照配表排序，没有配表，则直接显示元数据)
function LuaRecastEquipIndex:SortAndFilterAttributeList()
    if type(self.AttributeList) ~= 'table' then
        return
    end
    local newAttributeList = {}
    if self.recastTbl ~= nil and self.recastTbl:GetAttriBute() ~= nil and self.recastTbl:GetAttriBute().list ~= nil then
        for k,v in pairs(self.recastTbl:GetAttriBute().list) do
            ---@type LuaEnumExtraAttributeType
            local attributeType = v
            local attributeDes = self.AttributeList[attributeType]
            if attributeDes ~= nil then
                table.insert(newAttributeList,attributeDes)
            end
        end
    end
    if Utility.GetLuaTableCount(newAttributeList) <= 0 then
        for k,v in pairs(self.AttributeList) do
            table.insert(newAttributeList,v)
        end
    end
    if type(newAttributeList) == 'table' and Utility.GetLuaTableCount(newAttributeList) > 0 then
        self.AttributeList = newAttributeList
    end
end

---刷新等级特效信息列表
function LuaRecastEquipIndex:RefreshLevelEffectInfoList()
    if self.recastTbl == nil or self.recastTbl:GetRecastSkill() == nil or self.recastTbl:GetRecastSkill().list == nil then
        self.LevelEffectInfoList = nil
        return
    end
    self.LevelEffectInfoList = {}
    for k,v in pairs(self.recastTbl:GetRecastSkill().list) do
        local recastSkillId = v
        local recastSkillTbl = clientTableManager.cfg_recast_skillManager:TryGetValue(recastSkillId)
        if recastSkillTbl ~= nil then
            table.insert(self.LevelEffectInfoList,recastSkillTbl)
        end
    end
end
--endregion

--region 查询
---@return boolean 是否有下一等级
function LuaRecastEquipIndex:HaveNextLevel()
    return self:GetNextLevelRecastTbl() ~= nil
end
--endregion

--region 获取
---@return TABLE.cfg_recast 获取下一级重铸表
function LuaRecastEquipIndex:GetNextLevelRecastTbl()
    if self.recastTbl == nil then
        return
    end
    return clientTableManager.cfg_recastManager:GetRecastTbl(self.recastTbl:GetType(),self.recastTbl:GetLevel() + 1)
end

---@return string 如果string为空表示可以升级重铸
function LuaRecastEquipIndex:CanUpRecastLevel()
    if clientTableManager.cfg_noticeManager:CheckNoticeIsOpen(93) == false then
        return "系统未开启"
    end
    if self:HaveNextLevel() == false then
        return "没有下一级"
    end
    if type(self.UpRecastItemCost) == 'table' and Utility.GetLuaTableCount(self.UpRecastItemCost) > 0 then
        for k,v in pairs(self.UpRecastItemCost) do
            ---@type CostItemInfo
            local costInfo = v
            if gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():CheckBagHaveEnoughItem(costInfo.itemId,costInfo.costNumber) == false then
                return clientTableManager.cfg_promptframeManager:GetPopContent(511)
            end
        end
    end
    if type(self.UpRecastCoinCost) == 'table' and Utility.GetLuaTableCount(self.UpRecastCoinCost) > 0 then
        for k,v in pairs(self.UpRecastCoinCost) do
            ---@type CostItemInfo
            local costInfo = v
            if gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():CheckBagHaveEnoughItem(costInfo.itemId,costInfo.costNumber) == false then
                return clientTableManager.cfg_promptframeManager:GetPopContent(512)
            end
        end
    end
    if self.nextRecastTbl ~= nil and self.nextRecastTbl:GetConditionId() ~= nil and self.nextRecastTbl:GetConditionId().list ~= nil then
        local conditonResult = Utility.IsMainPlayerMatchConditionList_AND(self.nextRecastTbl:GetConditionId().list)
        if conditonResult.success == false then
            local hintText = conditonResult.txt
            if CS.StaticUtility.IsNullOrEmpty(hintText) then
                hintText = "条件不满足"
            end
        end
    end
end

---获取重铸等级效果开启状态列表
---@return table<TABLE.cfg_recast_skill>
function LuaRecastEquipIndex:GetRecastLevelEffectInfoList()
    return self.LevelEffectInfoList
end
--endregion

return LuaRecastEquipIndex