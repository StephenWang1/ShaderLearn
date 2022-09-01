---@class cfg_vip_zunxiangManager:TableManager
local cfg_vip_zunxiangManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_vip_zunxiang
function cfg_vip_zunxiangManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_vip_zunxiang> 遍历方法
function cfg_vip_zunxiangManager:ForPair(action)
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
function cfg_vip_zunxiangManager:PostProcess()
end

---@return TABLE.cfg_vip_zunxiang
function cfg_vip_zunxiangManager:GetPlatformVipZunXiangInfo()
    if self.mPlatformVipZunXiangInfo == nil and gameMgr ~= nil and gameMgr:GetPlatformMgr() ~= nil and gameMgr:GetPlatformMgr():GetPlatformInfo() ~= nil then
        self.mPlatformVipZunXiangInfo = self:TryGetValue(gameMgr:GetPlatformMgr():GetPlatformInfo():GetPlatformId())
    end
    return self.mPlatformVipZunXiangInfo
end

---@return boolean 是否可以显示尊享面板
function cfg_vip_zunxiangManager:CanShowPlatformVipZunXiangPanel()
    local zunXiangInfo = self:GetPlatformVipZunXiangInfo()
    return zunXiangInfo ~= nil and CS.StaticUtility.IsNullOrEmpty(zunXiangInfo:GetPicture()) == false and CS.StaticUtility.IsNullOrEmpty(zunXiangInfo:GetCode()) == false
end

---@class rewardInfo
---@field itemId number
---@field itemInfo TABLE.cfg_items
---@field CSItemInfo TABLE.CFG_ITEMS
---@field num number

---@return table<rewardInfo>
function cfg_vip_zunxiangManager:GetItemInfoList()
    if self.zunXiangRewardList == nil then
        local zunXiangInfo = self:GetPlatformVipZunXiangInfo()
        self.zunXiangRewardList = {}
        if zunXiangInfo ~= nil and zunXiangInfo:GetItemShow() ~= nil and zunXiangInfo:GetItemShow().list ~= nil then
            for k,v in pairs(zunXiangInfo:GetItemShow().list) do
                ---@type TABLE.IntList
                local itemInfoList = v.list
                if type(itemInfoList) == 'table' and Utility.GetLuaTableCount(itemInfoList) > 1 then
                    ---@type rewardInfo
                    local rewardInfo = {}
                    rewardInfo.itemId = itemInfoList[1]
                    rewardInfo.num = itemInfoList[2]
                    rewardInfo.itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(rewardInfo.itemId)
                    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
                    if itemInfoIsFind then
                        rewardInfo.CSItemInfo = itemInfo
                    end
                    table.insert(self.zunXiangRewardList,rewardInfo)
                end
            end
        end
    end
    return self.zunXiangRewardList
end

return cfg_vip_zunxiangManager