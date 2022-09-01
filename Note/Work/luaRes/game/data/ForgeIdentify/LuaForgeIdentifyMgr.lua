---@class LuaForgeIdentifyMgr 鉴定管理类
local LuaForgeIdentifyMgr = {}

function LuaForgeIdentifyMgr:IsShowRedPoint()
    return self:RedPointCheck()
end

function LuaForgeIdentifyMgr:RedPointCheck()
    local redPointLevel = self:GetLuaTable(22988)
    local redPointEquip = self:GetEquipCondition()
    local redPointBag = self:GetBagCondition()
    local redPointShow = self:SetRedPointShow()
    if redPointLevel == true and redPointEquip == true and redPointBag== true and redPointShow == true then
        return true
    else
        return false
    end
end

function LuaForgeIdentifyMgr:SetRedPointShow(boolean)
    if boolean ~= nil then
        self.IsShow = boolean
    else
        if self.IsShow ~= nil then
            return self.IsShow
        else
            return true
        end
    end
end

function LuaForgeIdentifyMgr:GetLuaTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    local levelInfo = string.Split(Lua_GlobalTABLE.value,"#")
    local levelBottom = Utility.IsMainPlayerMatchCondition(tonumber(levelInfo[1]))
    local levelTop = Utility.IsMainPlayerMatchCondition(tonumber(levelInfo[2]))
    if levelBottom.success == true and levelTop.success == true then
        return true
    end
    return false
end

function LuaForgeIdentifyMgr:GetEquipCondition()
    local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if LuaPlayerEquipmentListData then
        local equipDic = LuaPlayerEquipmentListData.EquipmentDic
        for k, v in pairs(equipDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            if equipInfo.BagItemInfo then
                if equipInfo.BagItemInfo.index ~= 0 then
                    if self:GetJianDingTable(equipInfo.BagItemInfo) == true then
                        local curAttr = equipInfo.BagItemInfo.appraisalQuality
                        if curAttr < 3 then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function LuaForgeIdentifyMgr:GetBagCondition()
    local normalHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(99000064)
    local perfectHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(99000065)
    local goldHave = self:GetCountdataList(22990)
    local diamondHave = self:GetCountdataList(22991)
    if tonumber(normalHave) > 0 and tonumber(goldHave.have) >= tonumber(goldHave.need) then
        return true
    end
    if tonumber(perfectHave) > 0 and tonumber(diamondHave.have) >= tonumber(diamondHave.need) then
        return true
    end
    return false
end

function LuaForgeIdentifyMgr:GetToggleState(index)
    self.index = index
end

function LuaForgeIdentifyMgr:GetState()
    if self.index ~= nil then
        return self.index
    end
    return 0
end

function LuaForgeIdentifyMgr:GetJianDingTable(bagItemInfo)
    local Lua_jianDingTABLE = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if Lua_jianDingTABLE == nil then
        return false
    end
    if Lua_jianDingTABLE:GetJianDing() == 1 then
        return true
    else
        return false
    end
end

---获取table内容
function LuaForgeIdentifyMgr:GetCountdataList(id)
    local numData = LuaGlobalTableDeal.GetGlobalTabl(id)
    local numList = numData.value
    numList = string.Split(numData.value, "&")
    local tempData={}
    local temp
    temp = string.Split(numList[2], "#")
    local itemHave = tonumber(temp[1])
    local curHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(tonumber(itemHave))
    tempData.have = curHave
    tempData.need = temp[2]
    return tempData
end

--endregion
return LuaForgeIdentifyMgr