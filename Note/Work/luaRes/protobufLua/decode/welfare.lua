--[[本文件为工具自动生成,禁止手动修改]]
local welfareV2 = {}

local decodeTable = protobufMgr.DecodeTable

--[[welfareV2.ResSignInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.ReqCdkeyReward lua中的数据结构
---@return welfareV2.ReqCdkeyReward C#中的数据结构
function welfareV2.ReqCdkeyReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.ReqCdkeyReward()
    if decodedData.cdkey ~= nil and decodedData.cdkeySpecified ~= false then
        data.cdkey = decodedData.cdkey
    end
    return data
end

--[[welfareV2.ResCdkeyReward 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.ReqDrawSummaryDayReward lua中的数据结构
---@return welfareV2.ReqDrawSummaryDayReward C#中的数据结构
function welfareV2.ReqDrawSummaryDayReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.ReqDrawSummaryDayReward()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

--[[welfareV2.ResSevenDaysInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.ReqDrawSevenDays lua中的数据结构
---@return welfareV2.ReqDrawSevenDays C#中的数据结构
function welfareV2.ReqDrawSevenDays(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.ReqDrawSevenDays()
    data.days = decodedData.days
    return data
end

--[[welfareV2.OnlineRewardMsg 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.OnlineRewardRequest lua中的数据结构
---@return welfareV2.OnlineRewardRequest C#中的数据结构
function welfareV2.OnlineRewardRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.OnlineRewardRequest()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        for i = 1, #decodedData.index do
            data.index:Add(decodedData.index[i])
        end
    end
    return data
end

---@param decodedData welfareV2.GetRewardHall lua中的数据结构
---@return welfareV2.GetRewardHall C#中的数据结构
function welfareV2.GetRewardHall(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.GetRewardHall()
    return data
end

--[[welfareV2.RewardHall 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.RewardHallInfo lua中的数据结构
---@return welfareV2.RewardHallInfo C#中的数据结构
function welfareV2.RewardHallInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.RewardHallInfo()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    if decodedData.order ~= nil and decodedData.orderSpecified ~= false then
        data.order = decodedData.order
    end
    return data
end

---@param decodedData welfareV2.TimingRewardRequest lua中的数据结构
---@return welfareV2.TimingRewardRequest C#中的数据结构
function welfareV2.TimingRewardRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.TimingRewardRequest()
    if decodedData.timingRewardType ~= nil and decodedData.timingRewardTypeSpecified ~= false then
        data.timingRewardType = decodedData.timingRewardType
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        for i = 1, #decodedData.index do
            data.index:Add(decodedData.index[i])
        end
    end
    return data
end

--[[welfareV2.TimingReward 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.TimmngRewardInfo lua中的数据结构
---@return welfareV2.TimmngRewardInfo C#中的数据结构
function welfareV2.TimmngRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.TimmngRewardInfo()
    return data
end

---@param decodedData welfareV2.GetLevelPacks lua中的数据结构
---@return welfareV2.GetLevelPacks C#中的数据结构
function welfareV2.GetLevelPacks(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.GetLevelPacks()
    return data
end

--[[welfareV2.LevelPacksInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

---@param decodedData welfareV2.GetLevelPacksInfo lua中的数据结构
---@return welfareV2.GetLevelPacksInfo C#中的数据结构
function welfareV2.GetLevelPacksInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.GetLevelPacksInfo()
    return data
end

---@param decodedData welfareV2.GetServantGrid lua中的数据结构
---@return welfareV2.GetServantGrid C#中的数据结构
function welfareV2.GetServantGrid(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.welfareV2.GetServantGrid()
    return data
end

return welfareV2