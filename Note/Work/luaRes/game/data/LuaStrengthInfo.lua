---@class LuaStrengthInfo
local LuaStrengthInfo = {}

LuaStrengthInfo.OpenCheck = nil

function LuaStrengthInfo:Init()
    self.OpenCheck = true
end

function LuaStrengthInfo:IsOpenTransferPush()
    local selfPush = self.OpenCheck--用来决定这个功能是否开启（策划不要了就改成false）
    local playerChoose = uiStaticParameter.NeedPushTransfer --玩家选择是否推送
    return playerChoose and selfPush
end

--region 转移推送
---@param bagItemInfo bagV2.BagItemInfo 请求装备道具
function LuaStrengthInfo:CheckRoleNeedPushTransferItem(bagItemInfo)
    if not self:IsOpenTransferPush() then
        return
    end
    self:ClearPushTransferData()

    local EquipIndex = Utility.GetEquipIndexByBagItemInfo(bagItemInfo)
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local res, bodyEquip = mainPlayerInfo.EquipInfo.Equips:TryGetValue(EquipIndex)
        if res then
            local arrowType = Utility.GetArrowType(bagItemInfo)
            if bodyEquip.intensify > bagItemInfo.intensify and arrowType ~= LuaEnumArrowType.NONE then
                self.mNeedPushBagItem = bodyEquip
                self.mNeedPushBodyItem = bagItemInfo
                self.mNeedPushType = LuaEnumStrengthenType.Role
                self.mServantEquipIndex = EquipIndex
            end
        end
    end
end

---灵兽推送
function LuaStrengthInfo:CheckServantNeedPushTransferItem(bagItemInfo, index)
    if not self:IsOpenTransferPush() then
        return
    end
    ---@type bagV2.BagItemInfo
    self.mNeedPushBagItem = nil
    ---@type bagV2.BagItemInfo
    self.mNeedPushBodyItem = nil

    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local res, bodyEquip = mainPlayerInfo.ServantInfoV2.ServantEquip:TryGetValue(index)
        if res then
            local arrowType = Utility.GetArrowType(bagItemInfo)
            if bodyEquip.intensify > bagItemInfo.intensify and arrowType ~= LuaEnumArrowType.NONE then
                self.mNeedPushBagItem = bodyEquip
                self.mNeedPushBodyItem = bagItemInfo
                self.mNeedPushType = LuaEnumStrengthenType.YuanLing
                self.mServantEquipIndex = index
            end
        end
    end
end

---装备变动检测是否推送角色转移
function LuaStrengthInfo:CheckBodyEquipChange()
    if not self:IsOpenTransferPush() then
        return
    end
    if self.mNeedPushBodyItem and self.mServantEquipIndex then
        local EquipIndex = self.mServantEquipIndex
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            local res, bodyEquip = mainPlayerInfo.EquipInfo.Equips:TryGetValue(EquipIndex)
            if res then
                if bodyEquip.lid == self.mNeedPushBodyItem.lid then
                    self:PushStrengthPrompt()
                end
            end
        end
    end
end

---装备变动检测是否推送灵兽转移
function LuaStrengthInfo:CheckServantEquipChange()
    if not self:IsOpenTransferPush() then
        return
    end
    if self.mNeedPushBodyItem and self.mServantEquipIndex then
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            local res, bodyEquip = mainPlayerInfo.ServantInfoV2.ServantEquip:TryGetValue(self.mServantEquipIndex)
            if res and bodyEquip.lid == self.mNeedPushBodyItem.lid then
                self:PushStrengthPrompt()
            end
        end
    end
end

---推送弹窗
function LuaStrengthInfo:PushStrengthPrompt()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if self.mNeedPushType and self.mNeedPushBagItem and self.mNeedPushBodyItem and mainPlayerInfo then
        ---@type CSBagInfoV2
        local bagInfoV2 = mainPlayerInfo.BagInfo
        ---@type CSServantInfoV2
        local servantV2 = mainPlayerInfo.ServantInfoV2
        ---@type  CSEquipInfoV2
        local equipV2 = mainPlayerInfo.EquipInfo
        if bagInfoV2 == nil then
            return
        end
        --[[        local pushInfo = {}
                pushInfo.mBagEquip = self.mNeedPushBagItem
                pushInfo.mBodyEquip = self.mNeedPushBodyItem
                pushInfo.mServantEquipIndex = self.mServantEquipIndex]]
        local customData = {}
        customData.id = 142
        customData.IsToggleVisable = true
        customData.visabelText = "下次不提示"
        customData.OptionBtnCallBack = function(value)
            uiStaticParameter.NeedPushTransfer = not value
        end
        customData.IsClose = false
        customData.IsShowGoldLabel = true
        local costItemId, costNum = self:GetTransferCost(self.mNeedPushBagItem.intensify)
        local costInfo = clientTableManager.cfg_itemsManager:TryGetValue(costItemId)
        if costInfo then
            customData.GoldIcon = costInfo:GetIcon()
        end
        local playerHas = bagInfoV2:GetCoinAmount(costItemId)
        if playerHas == nil or costNum == nil then
            self:ClearPushTransferData()
            return
        end
        local playerEnough = playerHas >= costNum
        local color = playerEnough and "" or luaEnumColorType.Red
        customData.GoldCount = color .. costNum
        local newBodyEquip
        if self.mNeedPushType == LuaEnumStrengthenType.YuanLing then
            local res1
            res1, newBodyEquip = servantV2.ServantEquip:TryGetValue(self.mServantEquipIndex)
        else
            local res2
            local newEquipIndex = equipV2:GetEquipIndexByEquip(self.mNeedPushBodyItem)
            res2, newBodyEquip = equipV2.Equips:TryGetValue(newEquipIndex)
        end
        local originID = self.mNeedPushBagItem.lid
        local aimID = 0
        if newBodyEquip then
            aimID = newBodyEquip.index * -1
        end
        if aimID == 0 then
            return
        end
        customData.Callback = function()
            --[[            local pushData = {}
                        pushData.mChooseItemInfo = pushInfo
                        pushData.type = self.mNeedPushType
                        uimanager:ClosePanel("UIServantPanel")
                        uimanager:ClosePanel("UIBagPanel")
                        uimanager:ClosePanel("UIRolePanel")
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Transfer_Role, pushData)]]
            if playerEnough then
                networkRequest.ReqIntensifyTransfer(originID, aimID)
                uimanager:ClosePanel("UIPromptPanel")
            else
                ---@type  UIPromptPanel
                local panel = uimanager:GetPanel("UIPromptPanel")
                local go = panel.GetCenterButton_GameObject()
                local str = costInfo:GetName() .. "不足"
                Utility.ShowPopoTips(go, str, 1)
            end
        end
        Utility.ShowPromptTipsPanel(customData)
        self:ClearPushTransferData()
    end
end

function LuaStrengthInfo:GetTransferCost(intensify)
    local itemId, num = 0
    local res, intensifyInfo = CS.Cfg_IntensifyTableManager.Instance.dic:TryGetValue(intensify)
    if res then
        local costInfo = intensifyInfo.transferResource.list
        if costInfo.Count >= 2 then
            itemId = costInfo[0]
            num = costInfo[1]
        end
    end
    return itemId, num
end

function LuaStrengthInfo:ClearPushTransferData()
    self.mNeedPushBagItem = nil
    self.mNeedPushBodyItem = nil
end
--endregion

--region 获取角色身上星级最低的一件可锻造装备
function LuaStrengthInfo:GetCanStrengthEquipItem()
    local equipListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if equipListData then
        ---@type bagV2.BagItemInfo
        local badEquip = nil
        for k, v in pairs(equipListData.EquipmentDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            ---@type bagV2.BagItemInfo
            local bagItemInfo = equipInfo.BagItemInfo
            if bagItemInfo and self:CanItemStrength(bagItemInfo) then
                if badEquip then
                    if badEquip.intensify > bagItemInfo.intensify then
                        badEquip = bagItemInfo
                    end
                else
                    badEquip = bagItemInfo
                end
            end
        end
        return badEquip
    end
    return nil
end

function LuaStrengthInfo:CanItemStrength(bagItemInfo)
    if bagItemInfo == nil then
        return
    end

    ---大于10000是血继神力装备
    if bagItemInfo.index > 1000 then
        return false
    end

    ---读表
    local itemInfo = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    if itemInfo == nil then
        return false
    end

    ---某些类型不能强化
    if self:IsItemSubtypeCanStrength(itemInfo:GetSubType()) == false then
        return false
    end

    ---不满足20天某些道具限制强化
    if self:IsArriveStrengthOpenDays() == false then
        local limitItemList = CS.Cfg_GlobalTableManager.Instance:GetNeedLimitId()
        for i = 0, limitItemList.Length - 1 do
            if itemInfo:GetSubType() == limitItemList[i] then
                return false
            end
        end
    end
    return true
end

---@return boolean 判断该subtype类型的道具是否可锻造
function LuaStrengthInfo:IsItemSubtypeCanStrength(subtype)
    local canStrengthList = CS.Cfg_GlobalTableManager.Instance:GetStrengthenID()
    if canStrengthList and canStrengthList.Length > 0 then
        for i = 0, canStrengthList.Length - 1 do
            if (subtype == canStrengthList[i]) then
                return true
            end
        end
    end
    return false
end

---@return boolean 根据开服天数等是否达到强化开启条件
function LuaStrengthInfo:IsArriveStrengthOpenDays()
    local res, notice = CS.Cfg_NoticeTableManager.Instance.dic:TryGetValue(21)
    if res and notice.openCondition then
        local conditionList = notice.openCondition.list
        return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(conditionList)
    end
    return false
end

--endregion

--region 升星红点
function LuaStrengthInfo:RefreshStrengthRedPoint()
    self.mCoinStrengthFull = false
    self:GetMoneyEnoughToStrength()
    local equipListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if equipListData then
        for k, v in pairs(equipListData.EquipmentDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            if equipInfo.BagItemInfo then
                local key = "Strength_" .. equipInfo.BagItemInfo.index
                local StrengthKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
                CS.CSUIRedPointManager.GetInstance():CallRedPoint(StrengthKey);
            end
        end
    end
    local key = LuaRedPointName.Strength_All
    local allKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(key);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(allKey);
end

---获得红点推送货币条件
function LuaStrengthInfo:GetMoneyEnoughToStrength()
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        local bagInfoV2 = mainPlayerInfo.BagInfo
        if bagInfoV2 then
            local singleData = self:GetIntensifyCost(0)
            if singleData then
                if #singleData > 0 then
                    local moneyNum = bagInfoV2:GetCoinAmount(singleData[1].itemId)
                    local callNum = self:GetStrengthRedPointCondition(1)
                    self.mCoinStrengthFull = moneyNum >= callNum
                end
            end
        end
    end
end

---@return table<number,StrengthMineInfo>获得强化星级对应的货币消耗
function LuaStrengthInfo:GetIntensifyCost(intensify)
    local costList = {}
    local data = clientTableManager.cfg_intensifyManager:TryGetValue(intensify)
    if data == nil then
        return costList
    end
    local canStrengthList = data:GetConsume()
    if canStrengthList and canStrengthList.list and canStrengthList.list.Count > 0 then
        for i = 0, canStrengthList.list.Count - 1 do
            local tblList = canStrengthList.list[i].list
            if tblList and tblList.Count >= 3 then
                ---@type  StrengthMineInfo
                local costInfo = {}
                costInfo.itemId = tblList[0]
                costInfo.costNum = tblList[1]
                costInfo.rate = math.ceil(tblList[2] / 100)
                table.insert(costList, costInfo)
            end
        end
    end
    return costList
end

---判断总红点是否显示
function LuaStrengthInfo:NeedShowAllStrengthRedPoint()
    local noticeId = clientTableManager.cfg_noticeManager:TryGetValue(64)
    if noticeId then
        local isOpen = Utility.IsNoticeOpenSystem(noticeId)
        if not isOpen then
            return false
        end
    end

    local equipListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Base)
    if equipListData then
        for k, v in pairs(equipListData.EquipmentDic) do
            ---@type LuaEquipDataItem
            local equipInfo = v
            local bagItemInfo = equipInfo.BagItemInfo
            if bagItemInfo then
                local canStrength = self:CanItemStrength(bagItemInfo)
                local redPoint = self:IsItemNeedRedPoint(bagItemInfo)
                if canStrength and redPoint then
                    return true
                end
            end
        end
    end
    return false
end

---判断单个道具是否显示红点
---@param bagItemInfo bagV2.BagItemInfo
function LuaStrengthInfo:IsItemNeedRedPoint(bagItemInfo)
    if self.mCoinStrengthFull == nil then
        self:GetMoneyEnoughToStrength()
    end

    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return false
    end
    local bagInfoV2 = mainPlayerInfo.BagInfo
    if bagInfoV2 == nil then
        return false
    end
    if bagItemInfo and self.mCoinStrengthFull then
        local intensify = bagItemInfo.intensify
        local limit = self:GetStrengthRedPointCondition(2)
        if limit and intensify < limit then
            local singleData = self:GetIntensifyCost(bagItemInfo.intensify)
            if singleData and #singleData > 0 then
                local cost = singleData[1]
                if cost then
                    local costID = cost.itemId
                    local costNum = cost.costNum
                    local playerHas = bagInfoV2:GetCoinAmount(costID)
                    return playerHas >= costNum
                end
            end
        end
    end
    return false
end

---@return 红点条件
function LuaStrengthInfo:GetStrengthRedPointCondition(type)
    if self.mStrengthRedPointRedPointCondition == nil then
        self.mStrengthRedPointRedPointCondition = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22780)
        if data then
            local strs = string.Split(data.value, '&')
            for i = 1, #strs do
                local singleData = string.Split(strs[i], '#')
                if #singleData >= 4 then
                    local singleLimit = {}
                    singleLimit.costNum = tonumber(singleData[1])
                    singleLimit.intensifyLimit = tonumber(singleData[2])
                    singleLimit.levelMin = tonumber(singleData[3])
                    singleLimit.levelMax = tonumber(singleData[4])
                    table.insert(self.mStrengthRedPointRedPointCondition, singleLimit)
                end
            end
        end
    end
    ---@type CSMainPlayerInfo
    local playerInfo = CS.CSScene.MainPlayerInfo
    if playerInfo == nil then
        return 0
    end
    local playerLevel = playerInfo.Level
    if self.mStrengthRedPointRedPointCondition and #self.mStrengthRedPointRedPointCondition > 0 then
        for i = 1, #self.mStrengthRedPointRedPointCondition do
            local singleLimit = self.mStrengthRedPointRedPointCondition[i]
            if singleLimit then
                if playerLevel >= singleLimit.levelMin and playerLevel <= singleLimit.levelMax then
                    return type == 1 and singleLimit.costNum or singleLimit.intensifyLimit
                end
            end
        end
    end
    return 0
end
--endregion

return LuaStrengthInfo