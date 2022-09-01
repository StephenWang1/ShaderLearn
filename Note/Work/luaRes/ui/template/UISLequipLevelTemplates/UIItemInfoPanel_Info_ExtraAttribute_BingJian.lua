---@type 兵鉴
------@class UIItemInfoPanel_Info_ExtraAttribute_BingJian :UIItemInfoPanel_Info_ExtraAttribute
local UIItemInfoPanel_Info_ExtraAttribute_BingJian = {}
setmetatable(UIItemInfoPanel_Info_ExtraAttribute_BingJian, luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute)

---@param bagItemInfo bagV2.BagItemInfo 背包信息
---@param itemInfo TABLE.CFG_ITEMS 物品信息
function UIItemInfoPanel_Info_ExtraAttribute_BingJian:RefreshAttributes(bagItemInfo, itemInfo)
    --兵鉴神力装备
    if bagItemInfo ~= nil or itemInfo ~= nil then
        local itemId = bagItemInfo and bagItemInfo.itemId or itemInfo.id
        local growth = bagItemInfo and bagItemInfo.growthLevel or 0
        if gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsSLBingJian(itemId) then
            local classData = clientTableManager.cfg_growth_weapon_classManager:TryGetValue(itemId)
            local levelGroup = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetLevelTableByClassTable(itemId)
            local equipLevel = growth
            if equipLevel == nil then
                equipLevel = 0
            end
            local levelData, nextLevelData, isMax = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetCurAndNextTable(equipLevel, levelGroup)
            if classData == nil or levelGroup == nil then
                return
            end
            self:RefreshLevelTask(bagItemInfo, levelData)
            self:RefreshClassAttr(bagItemInfo, classData)
            local suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(levelData.divineSuit)
            if suitData == nil then
                suitData = clientTableManager.cfg_divinesuitManager:TryGetValue(nextLevelData.divineSuit)
            end
            if suitData == nil then
                return
            end
            self:RefreshSuitName(bagItemInfo, suitData, itemInfo)
        end
    end
end

---套装显示
function UIItemInfoPanel_Info_ExtraAttribute_BingJian:RefreshSuitName(bagItemInfo, suitData, itemInfo)
    local attrName = "[73ddf7]" .. suitData.suitName
    local attrValue = ""
    local suitInfo = string.Split(suitData.subtypeShow, "&")
    local suitDes = "[73ddf7]" .. "套装属性Lv."
    local suitValue = ""
    local isActive = true
    local suitLevel
    local bagInfo
    for i = 1, #suitInfo do
        local temp = string.Split(suitInfo[i], "#")
        local suitName = temp[2]
        local suitIndex = tonumber(temp[1]) + 100000 + ( suitData.type * 1000)
        local isHave = false
        local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Sl_BingJian)
        if LuaPlayerEquipmentListData then
            local equipDic = LuaPlayerEquipmentListData.EquipmentDic
            for k, v in pairs(equipDic) do
                ---@type LuaEquipDataItem
                local equipInfo = v
                if equipInfo.BagItemInfo then
                    if equipInfo.BagItemInfo.index == suitIndex then
                        if suitLevel == nil then
                            suitLevel = equipInfo.BagItemInfo.growthLevel
                            bagInfo = equipInfo.BagItemInfo
                        end
                        if equipInfo.BagItemInfo.growthLevel < suitLevel then
                            suitLevel = equipInfo.BagItemInfo.growthLevel
                            bagInfo = equipInfo.BagItemInfo
                        end
                        isHave = true
                        break
                    end
                end
            end
        end
        if isHave == false then
            isActive = false
        end
        if suitLevel == 0 then
            isActive = false
        end
        local name = isHave and "[00ff00]" .. suitName .. "[-]" or  "[878787]" .. suitName .. "[-]"
        if  i == 4 then
            attrValue = attrValue .. name .. "\r\n"
        else
            attrValue = attrValue .. name .. "   "
        end
    end
    if suitLevel == nil then
        suitLevel = 0
    end
    self:AddAttribute(attrName, "", attrValue)
    local suitTitle = isActive and suitDes .. (suitLevel) .. "[-][00ff00](已激活)" or suitDes .. suitLevel .. "[878787](未激活)"
    if bagInfo == nil then
        suitValue = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSuitDesBybagItemInfo(bagItemInfo, itemInfo)
    else
        suitValue = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSuitDesBybagItemInfo(bagInfo)
    end
    suitValue = isActive and "[00ff00]" .. suitValue or "[878787]" .. suitValue
    self:AddAttribute(suitTitle, "", suitValue)
end

---突破属性
function UIItemInfoPanel_Info_ExtraAttribute_BingJian:RefreshClassAttr(bagItemInfo, classData)
    local attrInfo
    local isZero = false
    if classData.weaponClass <= 0 then
        isZero = true
    else
        attrInfo = classData.attributeTip
    end
    local attrName = ""
    local isMax = false
    if classData.needLevel == nil or classData.needLevel == "" then
        isMax = true
        attrName = "[73ddf7]元素属性[-]"
    else
        attrName = "[73ddf7]元素属性[-]"
    end
    local attrList = string.Split(attrInfo, "&")
    local data = ""
    if isZero == false then
        data = isMax and "[00ff00]【突破+" .. classData.weaponClass .. "】(已满级)[-]" .. "\r\n" or  "[00ff00]【突破+" .. classData.weaponClass .. "】[-]" .. "\r\n"
        for i = 1, #attrList do
            local des = string.Split(attrList[i] , "#")
            if attrList[i + 1] == nil then
                data = data .. "[-]" .. des[1] .. "[00ff00]" .. des[2]
            else
                data = data .. "[-]" .. des[1] .. "[00ff00]" .. des[2] .. "\r\n"
            end
        end
    end
    if isMax == false then
        local nextClass = clientTableManager.cfg_growth_weapon_classManager:TryGetValue(classData.itemid)
        local nextAttrInfo = nextClass.attributeTip
        local nextList = string.Split(nextAttrInfo, "&")
        data = isZero and data .. "[878787]【突破+" .. nextClass.weaponClass .. "】[-][878787](" .. classData.needLevel .. "级可突破)[-]" .. "\r\n" or data ..  "\r\n" .. "[878787]【突破+" .. nextClass.weaponClass .. "】[-][878787](" .. classData.needLevel .. "级可突破)[-]" .. "\r\n"
        for i = 1, #nextList do
            local des = string.Split(nextList[i] , "#")
            if nextList[i + 1] == nil then
                data = data .. "[878787]" .. des[1] .. des[2]
            else
                data = data .. "[878787]" .. des[1] .. des[2] .. "\r\n"
            end
        end
    end
    self:AddAttribute(attrName, "", data)
end

---升级任务进度
function UIItemInfoPanel_Info_ExtraAttribute_BingJian:RefreshLevelTask(bagItemInfo, levelData)
    if self.isMainPlayerEquip then
        local itemData = string.Split(levelData.cost, "#")
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(tonumber(itemData[1]))
        if itemInfo ~= nil then
            local UpgradeCon = "[73ddf7]升级条件"
            local curItemHave
            if itemInfo:GetType() == 1 then
                curItemHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemInfo:GetId())
            else
                curItemHave = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(itemInfo:GetId())
            end
            local itemDemand = curItemHave >= tonumber(itemData[2])
            local UpgradeName = CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo:GetId())
            local UgradeCount = itemDemand and luaEnumColorType.Green3 .. "(" .. curItemHave .. "/" .. itemData[2] .. ")[-]"or luaEnumColorType.Red .. "(" .. curItemHave .. "/" .. itemData[2] .. ")[-]"
            local curGoal
            if bagItemInfo == nil then
                curGoal = 0
            else
                curGoal = bagItemInfo.killMonsterCount
            end
            if curGoal == nil then
                curGoal = 0
            end
            local taskgoalTbl = clientTableManager.cfg_taskgoalManager:TryGetValue(tonumber(levelData.taskgoal))
            if taskgoalTbl == nil then
                self:AddAttribute(UpgradeCon, "", "[878787]" .. UpgradeName .. "[-]" .. UgradeCount)
            else
                local goalNeed = taskgoalTbl:GetTaskGoalCountParam()
                local curLevel = curGoal >= goalNeed.list[0]
                local taskName = taskgoalTbl:GetName()
                local taskData = curLevel and luaEnumColorType.Green3 .. "(" .. curGoal .. "/" .. goalNeed.list[0] .. ")[-]" or luaEnumColorType.Red .. "(" .. curGoal .. "/" .. goalNeed.list[0] .. ")[-]"
                self:AddAttribute(UpgradeCon, "", "[878787]" .. UpgradeName .. "[-]" .. UgradeCount .. "\r\n[878787]" .. taskName .. taskData )
            end
        end
    end
end

return UIItemInfoPanel_Info_ExtraAttribute_BingJian