---@class cfg_noticeManager:TableManager
local cfg_noticeManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_notice
function cfg_noticeManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_notice> 遍历方法
function cfg_noticeManager:ForPair(action)
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
function cfg_noticeManager:PostProcess()
end

--region 活动需要显示的noticeId列表
---@class ActivityBtnInfo 活动按钮信息类
---@field row number
---@field order number
---@field noticeTbl TABLE.cfg_notice

---获取显示的活动列表
---@return table<number> noticeId列表
function cfg_noticeManager:GetNoticeIdList()
    local TableRows = Utility.CSListChangeTable(CS.Cfg_NoticeTableManager.Instance:GetMeetAscriptionGroup(1))
    local noticeIdList = {}
    for k,v in pairs(TableRows) do
        if Utility.IsContainsValue(noticeIdList,v) == false then
            table.insert(noticeIdList,v)
        end
    end
    return noticeIdList
end

---获取排序显示的活动列表
---@return table<number,table<ActivityBtnInfo>> NoticeId字典
function cfg_noticeManager:GetShowNoticeIdDic()
    local noticeList = self:GetNoticeIdList()
    local noticeShowDic = {}
    for k,v in pairs(noticeList) do
        local noticeTbl = self:TryGetValue(v)
        if noticeTbl ~= nil then
            ---@type ActivityBtnInfo
            local activityBtnInfo = {}
            activityBtnInfo.row = noticeTbl:GetPosition()
            activityBtnInfo.order = noticeTbl:GetOrder()
            activityBtnInfo.noticeTbl = noticeTbl
            if type(activityBtnInfo.row) == 'number' and activityBtnInfo.row > 0 then
                noticeShowDic[activityBtnInfo.row] = activityBtnInfo
            end
        end
    end
    return noticeShowDic
end

---查询系统是否开启
---@param noticeId number
---@return boolean
function cfg_noticeManager:CheckNoticeIsOpen(noticeId)
    local noticeTbl = self:TryGetValue(noticeId)
    if noticeTbl ~= nil and noticeTbl:GetOpenCondition() ~= nil and noticeTbl:GetOpenCondition().list ~= nil then
        local conditionIdList = Utility.CSListChangeTable(noticeTbl:GetOpenCondition().list)
        return Utility.IsMainPlayerMatchConditionList_AND(conditionIdList).success
    end
    return true
end

return cfg_noticeManager