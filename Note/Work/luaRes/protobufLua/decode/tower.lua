--[[本文件为工具自动生成,禁止手动修改]]
local towerV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData towerV2.ResRoleTowerInfo lua中的数据结构
---@return towerV2.ResRoleTowerInfo C#中的数据结构
function towerV2.ResRoleTowerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.towerV2.ResRoleTowerInfo()
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.awardList ~= nil and decodedData.awardListSpecified ~= false then
        for i = 1, #decodedData.awardList do
            data.awardList:Add(decodeTable.common.IntIntStruct(decodedData.awardList[i]))
        end
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    --C#的towerV2.ResRoleTowerInfo类中没有找到showRewardList字段,不填充数据
    return data
end

return towerV2