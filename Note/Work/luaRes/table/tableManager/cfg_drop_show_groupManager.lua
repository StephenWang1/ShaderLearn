---@class cfg_drop_show_groupManager:TableManager
local cfg_drop_show_groupManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_drop_show_group
function cfg_drop_show_groupManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_drop_show_group> 遍历方法
function cfg_drop_show_groupManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_drop_show_groupManager:PostProcess()
end

--- 获取组内首个符合的itemid列表
---@return table<number,TABLE.CFG_DROP_SHOW_GROUP>
function cfg_drop_show_groupManager:GetMeetItemGroupInfo(groupIds)
    if groupIds == nil or groupIds.Count == 0 then
        return nil
    end
    local tbl = {}
    for i = 0, groupIds.Count - 1 do
        local targetTbl = self:GetMeetItemGroup(groupIds[i])
        if #targetTbl > 0 then
            --[[            for i = 1, #targetTbl do
                            table.insert(tbl, targetTbl[i])
                        end]]
            return targetTbl
        end
    end
    return tbl
end

--- 获取组内所有符合的itemid列表
---@return table<number,TABLE.CFG_DROP_SHOW_GROUP>
function cfg_drop_show_groupManager:GetMeetAllItemGroupInfo(groupIds)
    if groupIds == nil or groupIds.Count == 0 then
        return nil
    end
    local tbl = {}
    for i = 0, groupIds.Count - 1 do
        local targetTbl = self:GetMeetItemGroup(groupIds[i])
        for i = 1, #targetTbl do
            table.insert(tbl, targetTbl[i])
        end
    end
    return tbl
end

---获得组内可用物品
---@param id number
---@return table<number,TABLE.CFG_DROP_SHOW_GROUP>
function cfg_drop_show_groupManager:GetMeetItemGroup(id)
    local tbl = {}
    if CS.Cfg_DropShowGroupTableManager.Instance.AllDropShowGroupInfoDic ~= nil then
        local isFind, groupVo = CS.Cfg_DropShowGroupTableManager.Instance.AllDropShowGroupInfoDic:TryGetValue(id)
        if isFind then
            if groupVo.groupConditionList == nil or CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(groupVo.groupConditionList) then
                if groupVo.dropShowInfo ~= nil and groupVo.dropShowInfo.Count > 0 then
                    for i = 0, groupVo.dropShowInfo.Count - 1 do
                        if self:CheckItemMeedConditionForInfo(groupVo.dropShowInfo[i]) then
                            ---@type TABLE.CFG_DROP_SHOW_GROUP
                            local info = self:TryGetValue(groupVo.dropShowInfo[i].id)
                            if info then
                                table.insert(tbl, info)
                            end
                        end
                    end
                end
            end
        end
    end
    return tbl
end

---判断此项是否满足
---@param info TABLE.cfg_drop_show_group
---@return boolean
function cfg_drop_show_groupManager:CheckItemMeedConditionForInfo(info)
    if info == nil or CS.CSScene.MainPlayerInfo == nil then
        return false
    end
    local isMeetSex = info.sex == 0 or info.sex == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex);
    local isMeetCareer = info.career == 0 or info.career == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career);
    if not isMeetSex or not isMeetCareer then
        return false
    end
    if (info.itemConditionId ~= null and info.itemConditionId.list ~= null) then
        if (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(info.itemConditionId.list)) then
            return false
        end
    end
    return true
end

--region 自定义

--endregion
return cfg_drop_show_groupManager