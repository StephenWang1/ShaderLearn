---@class LuaRepairInfo
local LuaRepairInfo = {}

function LuaRepairInfo:Init()

end

---@return boolean 是否有灵兽道具需要维修
function LuaRepairInfo:NeedShowServantRepairRedPoint()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        for k, v in pairs(luaEnumServantType) do
            local type = v
            local equipData = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetSingleServantEquipData(type)
            if equipData then
                local equipList = equipData.mEquipIndexToEquipDic
                for k, v in pairs(equipList) do
                    local bagItemInfo = v
                    if bagItemInfo then
                        ---@type TABLE.cfg_items
                        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
                        if itemInfo then
                            local isChoose = itemInfo:GetMaxLasting() and itemInfo:GetMaxLasting() ~= 0 and bagItemInfo.currentLasting < itemInfo:GetMaxLasting()
                            if isChoose then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

return LuaRepairInfo