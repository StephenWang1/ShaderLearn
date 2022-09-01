---@class LuaRecastMgr:luaobject 重铸管理类
local LuaRecastMgr = {}

--region 数据结构

---@class recastItemConfigInfo 重铸对象配置信息
---@field type number
---@field subType number

--endregion

--region 数据
---获取重铸列表类
---@return LuaRecastList
function LuaRecastMgr:GetRecastList()
    if self.RecastList == nil then
        self.RecastList = luaclass.LuaRecastList:New()
    end
    return self.RecastList
end
--endregion

--region 数据刷新
---刷新重铸列表
---@param tblData equipV2.ResRecast lua table类型消息数据
---@param career LuaEnumCareer 非必要参数
function LuaRecastMgr:RefreshRecastList(tblData,career,recastSuccess)
    self:GetRecastList():RefreshEquipIndexRecastInfoList(tblData,career)
end

---刷新重铸信息
---@param tblData equipV2.ResRecast lua table类型消息数据
---@param career LuaEnumCareer 非必要参数
function LuaRecastMgr:RefreshRecast(tblData,career)
    self:GetRecastList():RefreshSingleRecastInfo(tblData.info,career)
    luaEventManager.DoCallback(LuaCEvent.ReforgedResult)
    luaEventManager.DoCallback(LuaCEvent.ReforgedPanelRefresh)
end
--endregion

--region 查询
---@return boolean 是否有数据
function LuaRecastMgr:HaveData()
    return self:GetRecastList().ServerData ~= nil
end

---@return boolean 是否是重铸对象
function LuaRecastMgr:IsRecastItem(itemId)
    if self.recastItemTypeList == nil then
        local data = LuaGlobalTableDeal.GetGlobalTabl(23034)
        self.recastItemTypeList = {}
        if data ~= nil then
            local temp = string.Split(data.value, '&')
            for i, v in pairs(temp) do
                local strS = string.Split(v, '#')
                if type(strS) == 'table' and Utility.GetLuaTableCount(strS) > 1 then
                    ---@type recastItemConfigInfo
                    local recastItemConfigInfo = {}
                    recastItemConfigInfo.type = tonumber(strS[1])
                    recastItemConfigInfo.subType = tonumber(strS[2])
                    table.insert(self.recastItemTypeList,recastItemConfigInfo)
                end
            end
        end
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemTbl ~= nil and type(self.recastItemTypeList) == 'table' and Utility.GetLuaTableCount(self.recastItemTypeList) > 0 then
        for k,v in pairs(self.recastItemTypeList) do
            ---@type recastItemConfigInfo
            local recastItemConfigInfo = v
            if recastItemConfigInfo.type == itemTbl:GetType() and recastItemConfigInfo.subType == itemTbl:GetSubType() then
                return true
            end
        end
    end
    return false
end
--endregion

--region 红点
---触发红点回调
function LuaRecastMgr:CallRecastRedPoint()
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo))
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_YuPei))
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MiBao))
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi))
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin))
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MianSha))
end
--endregion

--region 获取
---@param recastType LuaEnumRecastType
---@return LuaEquipmentItemType
function LuaRecastMgr:GetEquipIndexByRecastType(recastType)
    if recastType == LuaEnumRecastType.DengZuo then
        return LuaEquipmentItemType.POS_LAMP
    elseif recastType == LuaEnumRecastType.YuPei then
        return LuaEquipmentItemType.POS_SOULJADE
    elseif recastType == LuaEnumRecastType.MiBao then
        return LuaEquipmentItemType.POS_RAWANIMA
    elseif recastType == LuaEnumRecastType.BaoShi then
        return LuaEquipmentItemType.POS_GEMGLOVE
    elseif recastType == LuaEnumRecastType.LingHunKeYin then
        return LuaEquipmentItemType.POS_MEDAL
    elseif recastType == LuaEnumRecastType.MianSha then
        return LuaEquipmentItemType.POS_FACE
    end
end

---@return number 重铸总等级
function LuaRecastMgr:GetRecastTotalLevel()
    local recastList = self:GetRecastList()
    local totalLevel = 0
    if recastList ~= nil and recastList.EquipIndexRecastInfoList ~= nil then
        for k,v in pairs(recastList.EquipIndexRecastInfoList) do
            ---@type LuaRecastEquipIndex
            local equipIndexRecastInfo = v
            totalLevel = totalLevel + equipIndexRecastInfo.recastLevel
        end
    end
    return totalLevel
end
--endregion

return LuaRecastMgr