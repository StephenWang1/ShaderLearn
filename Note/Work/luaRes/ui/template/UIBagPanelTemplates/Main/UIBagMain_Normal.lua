---正常打开的背包主导模板
---@class UIBagMain_Normal:UIBagMainBasic
local UIBagMain_Normal = {}

local CSUtility = CS.Utility
local luaEnumColorType = luaEnumColorType

setmetatable(UIBagMain_Normal, luaComponentTemplates.UIBagMainBasic)

--region 基础数据
---装备耐久较少最大值
function UIBagMain_Normal:GetLimitingValue()
    if self.LimitingValue == nil or self.LimitingValue == 0 then
        self.LimitingValue = tonumber(CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax())
    end
    return self.LimitingValue
end

---卸下装备延迟刷新时间
function UIBagMain_Normal:RemoveEquipDelayRefreshTime()
    if self.removeEquipBagDelayRefreshTime == nil or self.removeEquipBagDelayRefreshTime == 0 then
        self.removeEquipBagDelayRefreshTime = CS.Cfg_GlobalTableManager.Instance:GetRemoveEquipBagDelayRefreshTime()
    end
    return self.removeEquipBagDelayRefreshTime
end
--endregion

--region 初始化
function UIBagMain_Normal:OnInit()
    ---技能面板打开事件
    ---@type function
    self.mOnSkillPanelOpenedFunction = function(msgID, panelName)
        if panelName == "UISkillPanel" then
            self:OnSkillPanelOpened()
        end
    end
    ---确认使用红包事件
    ---@type function
    self.mOnConfirmUseLuckyMoneyFunction = function(count)
        self:OnUseLuckyMoneyConfirmed(count)
    end
    ---烟花提示回调
    ---@param go UnityEngine.GameObject
    self.mOnFireWorkPromptCallbackFunction = function(go)
        self:UseFireworkCallBack(go)
    end
    ---批量使用物品回调
    ---@param count number
    self.mOnBatchUseItemCallbackFunction = function(count)
        self:OnBatchUseItemCallback(count)
    end
    ---灵兽经验刷新事件
    self.mOnServantExtUpdateCallbackFunction = function(msgID, data)
        if self:IsOn() then
            self:OnServantExtUpdateReceived(msgID, data)
        end
    end
    self:GetBagPanel():GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResServantExpUpdateMessage, self.mOnServantExtUpdateCallbackFunction)
end
--endregion

--region 重写交互方法
---正常点击时,打开物品信息界面
function UIBagMain_Normal:OnGridClicked(bagGrid, bagItemInfo, itemTbl)
    self:ShowItemInfo(bagItemInfo)
end

---双击点击时,尝试使用物品
function UIBagMain_Normal:OnGridDoubleClicked(bagGrid, bagItemInfo, itemTbl)
    self:DoOperateToBagItem(bagGrid, bagItemInfo, itemTbl)
end
--endregion

--region 重写刷新格子方法
---最基础的格子刷新
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshSingleGrid(bagGrid, bagItemInfo, itemTbl)
    if self:CheckDelayBagItemInfoRefresh(bagGrid, bagItemInfo, itemTbl) == true then
        return
    end
    ---刷新最基础的格子参数
    self:RefreshBasicGridParams(bagGrid, bagItemInfo, itemTbl)
    ---刷新输入的高亮背包物品列表

    self:RefreshInputChosenBagGridState(bagGrid, bagItemInfo, itemTbl)
    --region 红点刷新
    local isShowRedPoint = false;
    if (itemTbl ~= nil) then
        isShowRedPoint = itemTbl.bagSign == 1 and CS.Utility_Lua.IsBagItemCanShowRedPoint(itemTbl);
        if (itemTbl.type == luaEnumItemType.SkillBook) then
            --local stateCode = -1;
            --if (itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 0) then
            --    stateCode = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillState(itemTbl.useParam.list[0]);
            --end
            isShowRedPoint = isShowRedPoint and Utility.SkillBookCanUse(itemTbl.id);
        elseif (bagItemInfo ~= nil and Utility.GetItemTblByBagItemInfo(bagItemInfo) ~= nil and Utility.GetItemTblByBagItemInfo(bagItemInfo):GetType() == 3 and Utility.GetItemTblByBagItemInfo(bagItemInfo):GetSubType() == 4) then
            --尽量不去动其他逻辑
            local configConditionResult = clientTableManager.cfg_itemsManager:CheckItemsConditions(bagItemInfo.itemId)
            if configConditionResult ~= nil and configConditionResult.success == false then
                isShowRedPoint = false
            end

            if bagItemInfo ~= nil then
                local useCount, useMaxCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemUseCountLimit(bagItemInfo)
                if (useMaxCount ~= nil and useCount >= useMaxCount) then
                    isShowRedPoint = false
                end
            end
        end
    end
    bagGrid:SetCompActive(bagGrid.Components.RedPoint, isShowRedPoint);
    --endregion
    ---耐久不足
    self:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
end

---刷新输入的高亮背包物品列表
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshBasicGridParams(bagGrid, bagItemInfo, itemTbl)
    ---刷新icon
    bagGrid:SetCompSpriteName(bagGrid.Components.Icon, itemTbl.icon)
    ---刷新物品数量/剩余使用次数
    local count = bagItemInfo.count
    if count <= 1 then
        count = bagItemInfo.leftUseNum
    end
    bagGrid:SetCompLabelContent(bagGrid.Components.Count, (count > 1) and tostring(count) or nil)
    ---刷新背包格子新物品动画
    self:RefreshBagGridNewTween(bagGrid, bagItemInfo, itemTbl)
    ---刷新背包格子绿色箭头标记
    self:RefreshBagGridIsGood(bagGrid, bagItemInfo, itemTbl)
    ---刷新背包物品强化标记
    self:RefreshBagGridStrength(bagGrid, bagItemInfo, itemTbl)
    ---刷新聚灵珠的百分比
    self:RefreshJuLingZhuFillAmount(bagGrid, bagItemInfo, itemTbl)
    ---刷新血继套装标识
    self:RefreshBloodSuitSign(bagGrid, bagItemInfo, itemTbl)
    ---刷新投保标识
    self:RefreshInsureSign(bagGrid, bagItemInfo, itemTbl)
end

---刷新输入的背包格子选中状态
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshInputChosenBagGridState(bagGrid, bagItemInfo, itemTbl)
    if self.mCustomData and bagItemInfo and bagGrid:GetCompActive(bagGrid.Components.ChosenEffect) == false then
        local ids = self.mCustomData.chosenBagItemIDs
        if ids then
            for i, v in pairs(ids) do
                if v and v == bagItemInfo.lid then
                    ---若当前格子属于高亮格子的一部分,则设置高亮为true
                    bagGrid:SetCompActive(bagGrid.Components.ChosenEffect, true)
                    break
                end
            end
        end
    end
end

---刷新装备耐久不足状态显示
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshEquipDurabilityIsLess(bagGrid, bagItemInfo, itemTbl)
    if itemTbl.type == luaEnumItemType.Equip and itemTbl.isWastageLasting > -1 and bagItemInfo.currentLasting >= -10 and bagItemInfo.currentLasting <= self:GetLimitingValue() then
        --self:SetBagGridRed(bagGrid, bagItemInfo, itemTbl)
        bagGrid:SetCompActive(bagGrid.Components.RedMask, true)
    end
end

---刷新聚灵珠百分比
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshJuLingZhuFillAmount(bagGrid, bagItemInfo, itemTbl)
    local CSMainPlayerInfo = CS.CSScene.MainPlayerInfo
    local itemType = itemTbl.type
    local itemSubType = itemTbl.subType
    if itemType == luaEnumItemType.Assist and itemSubType == 4 then
        ---聚灵珠类型需要显示聚灵珠的百分比
        if bagItemInfo.maxStar > 0 and bagItemInfo.luck > 0 then
            bagGrid:SetCompSpriteName(bagGrid.Components.Icon2, CS.Cfg_GlobalTableManager.Instance:GetJuLingZhuIcon2SpriteName(itemTbl.id))
            bagGrid:SetCompSpriteFillAmount(bagGrid.Components.Icon2, CSMainPlayerInfo.BagInfo:GetJvLingZhuShowIcon2FillAmountValue(bagItemInfo))
        end
    end
end

---刷新背包格子新物品特效
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshBagGridNewTween(bagGrid, bagItemInfo, itemTbl)
    local CSMainPlayerInfo = CS.CSScene.MainPlayerInfo
    if bagItemInfo and bagGrid:GetCompActive(bagGrid.Components.NewBagItemEffect) == false then
        local playNewEffect = CSMainPlayerInfo.BagInfo:CheckShowNewInfo(bagItemInfo) or CSMainPlayerInfo.BagInfo:CheckIsDomountEquipAndRemoveCache(LuaEnumBagChangeAction.PUTOFF, bagItemInfo) or CSMainPlayerInfo.BagInfo:CheckIsDomountEquipAndRemoveCache(LuaEnumBagChangeAction.PUTOFF_ChangeEquip, bagItemInfo)
        if playNewEffect then
            --bagGrid:SetCompActive(bagGrid.Components.NewBagItemEffect, false)
            --bagGrid:SetCompActive(bagGrid.Components.NewBagItemEffect, playNewEffect)
            bagGrid:PlayShakeTween(bagGrid.Components.Icon)
            CSMainPlayerInfo.BagInfo:RemoveNewItem(bagItemInfo)
        end
    end
end

---刷新背包格子绿色箭头标记
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshBagGridIsGood(bagGrid, bagItemInfo, itemTbl)
    if CS.Utility_Lua.CheckShowBetterArrow(itemTbl) == false then
        return
    end
    local arrowType = Utility.GetArrowType(bagItemInfo)
    if arrowType ~= LuaEnumArrowType.NONE then
        bagGrid:SetCompActive(bagGrid.Components.Good, true)
        bagGrid:SetCompSpriteName(bagGrid.Components.Good, CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(arrowType))
    end
end

---刷新背包格子强化标记
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshBagGridStrength(bagGrid, bagItemInfo, itemTbl, isGray)
    if bagItemInfo.intensify > 0 then
        local str, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
        bagGrid:SetCompLabelContent(bagGrid.Components.Strengthen, str)
        bagGrid:SetCompSpriteName(bagGrid.Components.Star, icon)
    end
end

---设定格子灰色
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:SetBagGridGray(bagGrid, bagItemInfo, itemTbl)
    local grayR = 0
    local grayG = 0
    local grayB = 0
    local grayA = 128
    bagGrid:SetCompColor(bagGrid.Components.Icon, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Icon2, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Count, 255, 255, 255, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Strengthen, 255, 255, 255, grayA)
    self:RefreshBagGridStrength(bagGrid, bagItemInfo, itemTbl, true)
    bagGrid:SetCompColor(bagGrid.Components.Good, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.RedPoint, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.BloodLv, 135, 135, 135, 255)
    bagGrid:SetCompColor(bagGrid.Components.BloodLvLabel, 135, 135, 135, 255)
    bagGrid:SetCompColor(bagGrid.Components.Insure, 135, 135, 135, 255)
end

---设定格子红色
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:SetBagGridRed(bagGrid, bagItemInfo, itemTbl)
    local grayR = 232
    local grayG = 80
    local grayB = 56
    local grayA = 255
    bagGrid:SetCompColor(bagGrid.Components.Icon, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Icon2, grayR, grayG, grayB, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Count, 255, 255, 255, grayA)
    bagGrid:SetCompColor(bagGrid.Components.Strengthen, 255, 255, 255, grayA)
end

---刷新保险标识
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshInsureSign(bagGrid, bagItemInfo, itemTbl)
    if (self:IsInsurance(bagItemInfo)) then
        bagGrid:SetCompActive(bagGrid.Components.Insure, true)
    else
        bagGrid:SetCompActive(bagGrid.Components.Insure, false)
    end
end

---是否已投保
function UIBagMain_Normal:IsInsurance(bagItemInfo)
    return gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
end

---刷新血继套装标识
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:RefreshBloodSuitSign(bagGrid, bagItemInfo, itemTbl)
    local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemTbl.id)
    local bloodLevel = bagItemInfo.bloodLevel
    if bloodsuitTbl and bloodLevel > 0 then
        bagGrid:SetCompActive(bagGrid.Components.BloodLv, true)
        bagGrid:SetCompLabelContent(bagGrid.Components.BloodLvLabel, tostring(bloodLevel))
    else
        bagGrid:SetCompActive(bagGrid.Components.BloodLv, false)
        bagGrid:SetCompActive(bagGrid.Components.BloodLvLabel, false)
    end
end

---是否显示扩展按钮
---@public
---@return boolean
function UIBagMain_Normal:IsShowExpandButton()
    return CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId()) and LuaGlobalTableDeal:IsShowQuickRecycle()
end

---是否显示回收按钮
---@public
---@return boolean
function UIBagMain_Normal:IsShowRecycleButton()
    return CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId())
end
--endregion

--region 显示物品信息界面
---显示物品信息界面
---@param bagItemInfo bagV2.BagItemInfo
function UIBagMain_Normal:ShowItemInfo(bagItemInfo)
    local itemInfo = bagItemInfo.ItemTABLE
    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = true, showAssistPanel = true, career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career), showMoreAssistData = true, showTabBtns = true, showBind = true, showAction = true })
end
--endregion

--region 操作物品
---尝试操作物品
---@public
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:DoOperateToBagItem(bagGrid, bagItemInfo, itemTbl)
    if itemTbl and bagItemInfo and bagGrid then
        if self:TryDoAnyOperation(bagGrid, bagItemInfo, itemTbl) == false then
            --CSUtility.ShowTips("不可直接使用")
        end
    end
end

---尝试执行任意操作
---@private
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean 是否执行了任意操作
function UIBagMain_Normal:TryDoAnyOperation(bagGrid, bagItemInfo, itemTbl)
    if itemTbl and bagItemInfo and bagGrid then
        local rightOperateList = CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemTbl.rightOperate)
        local leftOperateList = CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemTbl.leftOperate)
        if rightOperateList ~= nil then
            local rightCount = rightOperateList.list.Count
            if rightCount > 0 then
                for i = 0, rightCount - 1 do
                    local rightOperate = rightOperateList.list[i]
                    if rightOperate == LuaEnumItemOperateType.Equip then
                        ---装备操作
                        self:TryEquipBagItem(bagGrid, bagItemInfo, itemTbl)
                        return true
                    elseif rightOperate == LuaEnumItemOperateType.Use
                            or rightOperate == LuaEnumItemOperateType.Open
                            or rightOperate == LuaEnumItemOperateType.Mosaic
                            or rightOperate == LuaEnumItemOperateType.AgainRefine
                            or rightOperate == LuaEnumItemOperateType.Collect then
                        ---打开或使用物品
                        self:TryOpenOrUseItem(bagGrid, bagItemInfo, itemTbl)
                        return true
                    end
                end
            end
        end
        if leftOperateList ~= nil then
            local leftCount = leftOperateList.list.Count
            if leftCount > 0 then
                for i = 0, leftCount - 1 do
                    local leftOperate = leftOperateList.list[i]
                    if leftOperate == LuaEnumItemOperateType.Equip then
                        ---装备操作
                        self:TryEquipBagItem(bagGrid, bagItemInfo, itemTbl)
                        return true
                    elseif leftOperate == LuaEnumItemOperateType.Use
                            or leftOperate == LuaEnumItemOperateType.Open
                            or leftOperate == LuaEnumItemOperateType.Mosaic
                            or leftOperate == LuaEnumItemOperateType.AgainRefine
                            or leftOperate == LuaEnumItemOperateType.Collect then
                        ---打开或使用物品
                        self:TryOpenOrUseItem(bagGrid, bagItemInfo, itemTbl)
                        return true
                    end
                end
            end
        end
    end
    return false
end

--region 魂继的装备操作
---尝试装备魂继
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:TryEquipHunJiBagItem(bagGrid, bagItemInfo, itemTbl)
    local isEquiped, mServantSeatType, mHunJiTongLingState = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiEquiped(bagItemInfo)
    if isEquiped then
        ---请求卸下魂继装备
        ---若魂继装备已经装备,则请求卸下该装备
        ---请求卸下之前,先请求取消通灵
        if mHunJiTongLingState then
            networkRequest.ReqServantEquipSoul(bagItemInfo.index)
        end
        networkRequest.ReqPutOffTheEquip(bagItemInfo.index)
    else
        ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
        ---@type CSServantData_MainPlayer
        local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
        if mainPlayerServantData == nil then
            return
        end
        ---根据灵兽界面是否存在做不同处理
        ---@type UIServantPanel
        local servantPanel = uimanager:GetPanel("UIServantPanel")
        if servantPanel ~= nil and servantPanel.ServantIndex ~= -1 and servantPanel.ServantIndex ~= nil then
            ---当前选中的灵兽位
            ---@type luaEnumServantSeatType
            local servantSeatType = servantPanel.ServantIndex + 1
            ---灵兽界面存在时
            if uiStaticParameter.mSelectedHunJiPos ~= nil then
                ---根据选中了某个魂继位时的处理
                self:TryDoEquipServantHunJi_WithServantPanel_SelectedHunJiPos(bagItemInfo, bagGrid.go, servantSeatType, uiStaticParameter.mSelectedHunJiPos)
            else
                ---根据未选中了某个魂继位时的处理
                self:TryDoEquipServantHunJi_WithServantPanel_NonSelectedHunJiPos(bagItemInfo, bagGrid.go, servantSeatType)
            end
        else
            ---灵兽界面不存在时
            if bagItemInfo.ItemTABLE.subType == 0 then
                self:TryDoEquipServantHunJi_NoServantPanel_GeneralHunJi(bagItemInfo, bagGrid.go)
            else
                self:TryDoEquipServantHunJi_NoServantPanel_NoGeneralHunJi(bagItemInfo, bagGrid.go)
            end
        end
    end
end

---尝试穿戴法宝装备
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIBagMain_Normal:TryEquipMagicEquip(bagItemInfo, go)
    if bagItemInfo == nil or CS.StaticUtility.IsNull(go) == true then
        return
    end
    local useParam = clientTableManager.cfg_itemsManager:CanUseMagicEquip(bagItemInfo.itemId)
    if useParam == LuaEnumUseItemParam.MagicEquipSuitTypeLocked then
        self:ShowTipBubble(go, nil, 427)
    else
        local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
        if equipIndex ~= nil then
            networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
            local suitType = clientTableManager.cfg_itemsManager:GetMagicEquipSuitType(bagItemInfo.itemId)
            uiTransferManager:TransferToMagicEquipPanel(suitType)
        end
    end
end

---有UIServantPanel且未选中某个魂继位时的处理
---@private
---@param bagItemInfo
---@param go
---@param servantSeatType luaEnumServantSeatType 当前选中的灵兽位
function UIBagMain_Normal:TryDoEquipServantHunJi_WithServantPanel_NonSelectedHunJiPos(bagItemInfo, go, servantSeatType)
    ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
    if mainPlayerServantData == nil then
        return
    end
    ---@type CSServantData_MainPlayer
    local servantSeatData = mainPlayerServantData:GetServantSeatData(servantSeatType)
    if servantSeatData == nil then
        return
    end
    local equipIndex, reason = servantSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
    if equipIndex == 0 then
        if reason == CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---灵兽位均未开启
            Utility.ShowPopoTips(go, "目标灵兽位未开启", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.ServantNotOn then
            ---灵兽未上阵
            Utility.ShowPopoTips(go, "请先召唤灵兽", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
            ---灵兽等级不足
            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.HunJiTypeUnmatch then
            ---魂继类型不匹配
            Utility.ShowPopoTips(go, "与所选灵兽类型不符", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIItemInfoPanel")
        end
    else
        networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
        uimanager:ClosePanel("UIItemInfoPanel")
    end
end

---有UIServantPanel且选中了某个魂继位时的处理
---@private
---@param bagItemInfo
---@param go
---@param servantSeatType luaEnumServantSeatType 当前选中的灵兽位
---@param selectedPos number 当前选中的魂继装备位
function UIBagMain_Normal:TryDoEquipServantHunJi_WithServantPanel_SelectedHunJiPos(bagItemInfo, go, servantSeatType, selectedPos)
    ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
    if mainPlayerServantData == nil then
        return
    end
    ---@type CSServantData_MainPlayer
    local servantSeatData = mainPlayerServantData:GetServantSeatData(servantSeatType)
    if servantSeatData == nil then
        return
    end
    local isAvailableToReplace, reason = servantSeatData:IsHunJiItemAbleToReplaceEquipIndex(bagItemInfo, selectedPos)
    if isAvailableToReplace then
        networkRequest.ReqPutOnTheEquip(selectedPos, bagItemInfo.lid)
        uimanager:ClosePanel("UIItemInfoPanel")
    else
        if reason == CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---灵兽位均未开启
            Utility.ShowPopoTips(go, "目标灵兽位未开启", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.ServantNotOn then
            ---灵兽未上阵
            Utility.ShowPopoTips(go, "请先召唤灵兽", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
            ---灵兽等级不足
            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.HunJiTypeUnmatch then
            ---魂继类型不匹配
            Utility.ShowPopoTips(go, "与所选灵兽类型不符", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIItemInfoPanel")
        elseif reason == CS.EHunJiEquipFailReason.SameGroupHasEquiped then
            ---同种类的魂继不可重复穿戴
            Utility.ShowPopoTips(go, "同种类的魂继不可重复穿戴", 205, "UIItemInfoPanel")
        end
    end
end

---无UIServantPanel时装备通用魂继
---@private
function UIBagMain_Normal:TryDoEquipServantHunJi_NoServantPanel_GeneralHunJi(bagItemInfo, go)
    ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
    ---找到通用魂继装备的一个可以装备的装备位
    ---校验不可替换的寒芒位
    local equipIndex, reason = mainPlayerServantData.HanMangSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, false)
    if equipIndex == 0 then
        equipIndex, reason = mainPlayerServantData.LuoXingSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, false)
        if equipIndex == 0 then
            equipIndex, reason = mainPlayerServantData.TianChengSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, false)
        end
    end
    ---是否所有灵兽位均未开启
    local isAllServantSeatUnopened = true
    ---是否所有灵兽均未上阵
    local isAllServantNotOn = true
    ---是否因为灵兽等级不足
    local servantLevelUnmatch = false
    ---是否因为灵兽转生等级不足
    local servantReinLevelUnmatch = false
    if equipIndex == 0 then
        ---校验可替换的寒芒位
        ---取可以替换的灵兽魂继装备位中属性最低的一个魂继装备位作为替换目标
        local lowestEquipIndex = 0
        local propertyTemp = 9999999999999
        equipIndex, reason = mainPlayerServantData.HanMangSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
        if equipIndex ~= 0 then
            local hanmangEquip = mainPlayerServantData.HanMangSeatData:GetServantHunJiEquip(equipIndex)
            if hanmangEquip then
                local hanmangProperty = mainPlayerServantData.HanMangSeatData:GetHunJiEquipProperty(hanmangEquip)
                if hanmangProperty < propertyTemp then
                    propertyTemp = hanmangProperty
                    lowestEquipIndex = equipIndex
                end
            end
        end
        if reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---某个灵兽位开启,则否定之前的标志位
            isAllServantSeatUnopened = false
        end
        if reason ~= CS.EHunJiEquipFailReason.ServantNotOn and reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---某个灵兽位已上阵,则否定之前的标志位
            isAllServantNotOn = false
        end
        if reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
            ---灵兽等级不足
            servantLevelUnmatch = true
        end
        if reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            servantReinLevelUnmatch = true
        end
        ---未找到合适的装备位时,校验可替换的落星位
        equipIndex, reason = mainPlayerServantData.LuoXingSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
        if equipIndex ~= 0 then
            local luoxingEquip = mainPlayerServantData.LuoXingSeatData:GetServantHunJiEquip(equipIndex)
            if luoxingEquip then
                local luoxingProperty = mainPlayerServantData.LuoXingSeatData:GetHunJiEquipProperty(luoxingEquip)
                if luoxingProperty < propertyTemp then
                    propertyTemp = luoxingProperty
                    lowestEquipIndex = equipIndex
                end
            end
        end
        if reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---某个灵兽位开启,则否定之前的标志位
            isAllServantSeatUnopened = false
        end
        if reason ~= CS.EHunJiEquipFailReason.ServantNotOn and reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---某个灵兽位已上阵,则否定之前的标志位
            isAllServantNotOn = false
        end
        if reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
            ---灵兽等级不足
            servantLevelUnmatch = true
        end
        if reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            servantReinLevelUnmatch = true
        end
        ---未找到合适的装备位时,校验可替换的天成位
        equipIndex, reason = mainPlayerServantData.TianChengSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
        if equipIndex ~= 0 then
            local tianchengEquip = mainPlayerServantData.TianChengSeatData:GetServantHunJiEquip(equipIndex)
            if tianchengEquip then
                local tianchengProperty = mainPlayerServantData.TianChengSeatData:GetHunJiEquipProperty(tianchengEquip)
                if tianchengProperty < propertyTemp then
                    propertyTemp = tianchengProperty
                    lowestEquipIndex = equipIndex
                end
            end
        end
        if equipIndex == 0 then
            if reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
                isAllServantSeatUnopened = false
            end
            if reason ~= CS.EHunJiEquipFailReason.ServantNotOn and reason ~= CS.EHunJiEquipFailReason.ServantPosNotAvailable then
                isAllServantNotOn = false
            end
            if reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
                ---灵兽等级不足
                servantLevelUnmatch = true
            end
            if reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
                ---灵兽转生等级不足
                servantReinLevelUnmatch = true
            end
        end
        if lowestEquipIndex ~= 0 then
            ---找到了可以装备的装备位中最弱的,将最弱的装备位作为目标装备位
            equipIndex = lowestEquipIndex
        end
    end
    ---若选中的装备位不为0,则请求装备到目标格子上
    if equipIndex ~= 0 then
        networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
        local servantIndex = math.floor(equipIndex / 10000) - 1
        uimanager:CreatePanel("UIServantTagPanel", nil, {
            type = LuaEnumServantPanelType.HunJiPanel,
            servantIndex = servantIndex,
            openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel
        })
    else
        if isAllServantSeatUnopened then
            ---所有灵兽位均未开启
            Utility.ShowPopoTips(go, "目标灵兽位未开启", 205, "UIBagPanel")
        elseif isAllServantNotOn then
            ---所有灵兽均未上阵
            Utility.ShowPopoTips(go, "请先召唤灵兽", 205, "UIBagPanel")
        elseif servantLevelUnmatch then
            ---灵兽等级不足
            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIBagPanel")
        elseif servantReinLevelUnmatch then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIBagPanel")
        end
    end
end

---无UIServantPanel时装备非通用魂继
---@private
function UIBagMain_Normal:TryDoEquipServantHunJi_NoServantPanel_NoGeneralHunJi(bagItemInfo, go)
    ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
    ---非通用魂继时,直接去对应灵兽位的空闲或可替换的灵兽装备位,若没有则直接根据原因弹出提示
    ---@type CSServantSeatData_MainPlayer
    local servantSeatData = mainPlayerServantData:GetServantSeatData(bagItemInfo.ItemTABLE.subType)
    local equipIndex, reason = servantSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
    if equipIndex ~= 0 then
        networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
        local servantIndex = math.floor(equipIndex / 10000) - 1
        uimanager:CreatePanel("UIServantTagPanel", nil, {
            type = LuaEnumServantPanelType.HunJiPanel,
            servantIndex = servantIndex,
            openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel
        })
    else
        if reason == CS.EHunJiEquipFailReason.ServantPosNotAvailable then
            ---灵兽位均未开启
            Utility.ShowPopoTips(go, "目标灵兽位未开启", 205, "UIBagPanel")
        elseif reason == CS.EHunJiEquipFailReason.ServantNotOn then
            ---灵兽未上阵
            Utility.ShowPopoTips(go, "请先召唤灵兽", 205, "UIBagPanel")
        elseif reason == CS.EHunJiEquipFailReason.UseLevelNotAvailable then
            ---灵兽等级不足
            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIBagPanel")
        elseif reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIBagPanel")
        end
    end
end
--endregion

---尝试装备物品
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:TryEquipBagItem(bagGrid, bagItemInfo, itemTbl)
    local bubbleId = -1
    local CSMainPlayerInfo = CS.CSScene.MainPlayerInfo
    local mainPlayerLevel = CSMainPlayerInfo.Level
    local mainPlayerReinLevel = CSMainPlayerInfo.ReinLevel
    local mainPlayerSex = CSMainPlayerInfo.Sex
    ---@type CSServantInfoV2
    local mainPlayerServantInfo = CSMainPlayerInfo.ServantInfoV2
    local mainPlayerEquipInfo = CSMainPlayerInfo.EquipInfo
    if CS.CSServantInfoV2.IsServantJustEquip(itemTbl) or CS.CSServantInfoV2.IsServantMagicWeapon(itemTbl) then
        ---灵兽装备
        bubbleId = mainPlayerServantInfo:ReqEquipItem(bagItemInfo, itemTbl)
        if (bubbleId == -1) then
            if (mainPlayerServantInfo:LevelEquipToShowBaseServantPanel(bagItemInfo) ~= -1) then
                local servantTblType = mainPlayerServantInfo:GetEquipServantType(itemTbl)
                if (servantTblType == 1) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM);
                elseif (servantTblType == 2) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX);
                elseif (servantTblType == 3) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC);
                end
            end
        end
    elseif CS.CSServantInfoV2.IsServantBody(itemTbl) then
        bubbleId = self:EquipServantBody(mainPlayerServantInfo, bagItemInfo, itemTbl)
    elseif itemTbl.type == luaEnumItemType.HunJi then
        ---双击魂继
        self:TryEquipHunJiBagItem(bagGrid, bagItemInfo, itemTbl)
        return
    else
        local arrowType = Utility.GetArrowType(bagItemInfo)
        ---@type UIRolePanel
        local uirolePanel = uimanager:GetPanel("UIRolePanel")
        ---@type UIServantPanel
        local uiservantPanel = uimanager:GetPanel("UIServantPanel")
        if arrowType == LuaEnumArrowType.NONE and uirolePanel == nil and uiservantPanel == nil then
            ---没有箭头时,未打开角色和灵兽界面时,双击装备,只替换角色的装备
        else
            ---对于可以装备在灵兽身上的角色装备,需要考虑下是装备在主角身上还是装备在某个灵兽位上
            if uirolePanel == nil and CS.CSServantInfoV2.IsRoleEquipAvailableForServant(itemTbl) then
                local equipTarget = 0
                if uiservantPanel ~= nil and uiservantPanel:GetSelectIndex() ~= -1 then
                    ---灵兽界面存在时,装备到目标灵兽上
                    equipTarget = uiservantPanel:GetSelectIndex() + 1
                else
                    ---灵兽界面不存在时,考虑下是否比角色装备中最差的装备更好
                    ---获取角色装备位中最差的一个装备位
                    local lowestEquipIndex = CS.CSScene.MainPlayerInfo.BagInfo:GetUseEquipIndex(bagItemInfo)
                    ---@type bagV2.BagItemInfo
                    local currentEquippedBagItem
                    ___, currentEquippedBagItem = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(lowestEquipIndex)
                    if (currentEquippedBagItem ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:EquipBaseAttributeCompare(currentEquippedBagItem, bagItemInfo) >= 0) then
                        ---如果角色装备位上最差的装备位上的装备不为空且比当前处理的装备好,那么考虑装备到灵兽身上
                        equipTarget = Utility.GetEquipTargetType(bagItemInfo)
                    else
                        ---如果角色身上有可以装备的装备位,则选择角色,走之前的逻辑
                        equipTarget = 0
                    end
                end
                if equipTarget ~= LuaEnumEquipTargetType.None then
                    ---普通装备需要装备到灵兽身上
                    local isEquipInServant = mainPlayerServantInfo.MainPlayerServantData:IsServantEquip(bagItemInfo)
                    if isEquipInServant then
                        ---如果已经装备在灵兽身上,则请求卸下
                        networkRequest.ReqPutOffTheEquip(bagItemInfo.index)
                        return
                    else
                        local canUseRoleEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(equipTarget)
                        if equipTarget > 0 and canUseRoleEquip == false then
                            self:ShowTipBubble(bagGrid.go, nil, 448)
                            return
                        end
                        ---获取推荐的灵兽位,尝试装备在灵兽位上,如果不能装备,则装备在角色身上
                        local recommendedIndex = mainPlayerServantInfo:GetRecommendedEquipIndexForRoleEquip(bagItemInfo.ItemTABLE, equipTarget)
                        if recommendedIndex and recommendedIndex ~= 0 then
                            local servantSeatData = mainPlayerServantInfo.MainPlayerServantData:GetServantSeatData(equipTarget)
                            if servantSeatData and clientTableManager.cfg_itemsManager:CanUseItem(bagItemInfo.itemId, servantSeatData.Level, servantSeatData.ReinLevel) == LuaEnumUseItemParam.CanUse then
                                networkRequest.ReqPutOnTheEquip(recommendedIndex, bagItemInfo.lid)
                                ---只打开背包的情况下，如果直接给灵兽穿戴装备，需要同时灵兽界面+背包，并且灵兽需要定位到穿戴装备的灵兽
                                if uirolePanel == nil or uiservantPanel == nil then
                                    if equipTarget == LuaEnumEquipTargetType.Servant_1 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM)
                                    elseif equipTarget == LuaEnumEquipTargetType.Servant_2 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX)
                                    elseif equipTarget == LuaEnumEquipTargetType.Servant_3 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC)
                                    end
                                end
                                return
                            end
                        end
                    end
                end
            end
        end
        ---普通装备
        local isEquiped = mainPlayerEquipInfo:IsEquip(bagItemInfo.lid)
        if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(bagItemInfo.itemId) then
            isEquiped = bagItemInfo.index ~= 0
        end
        if isEquiped then
            ---若该装备已被装备,则请求脱下
            networkRequest.ReqPutOffTheEquip(bagItemInfo.index)
        else
            local res = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemTbl.id)
            ---检查使用等级是否合乎限制
            if res == LuaEnumUseItemParam.UseLvNotEnough then
                self:ShowTipBubble(bagGrid.go, nil, 48)
                return
            end
            ---检查转生等级是否合乎限制
            if res == LuaEnumUseItemParam.UseReinLvNotEnough then
                self:ShowTipBubble(bagGrid.go, nil, 49)
                return
            end
            ---检查性别限制是否合乎限制
            if not (itemTbl.sex == LuaEnumSex.Common or itemTbl.sex == Utility.EnumToInt(mainPlayerSex)) then
                self:ShowTipBubble(bagGrid.go, nil, 106)
                return
            end
            ---宝物限制
            if Utility.IsCanEquippedGem(itemTbl, bagGrid.go) == false then
                return
            end
            --region 法宝
            if clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId) then
                self:TryEquipMagicEquip(bagItemInfo, bagGrid.go)
                return
            end
            --endregion

            --region 神力装备
            if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(bagItemInfo.itemId) then
                self:DoDivineEquip(bagItemInfo, bagGrid.go)
                return
            end
            --endregion

            --region 阵法装备
            if clientTableManager.cfg_itemsManager:IsZhenFaEquip(bagItemInfo.itemId) then
                local useItemParam = Utility.FaZhenEquipCanEquiped(bagItemInfo.itemId)
                if useItemParam == LuaEnumUseItemParam.FaZhenEquipIndexIsLock then
                    self:ShowTipBubble(bagGrid.go, "装备位未解锁", 48)
                    return
                end
                local conditionResult = Utility.FaZhenUseParamCondition(bagItemInfo.itemId)
                if conditionResult.success == false then
                    self:ShowTipBubble(bagGrid.go, conditionResult.txt, 48)
                    return
                end
                Utility.ReqEquipItem(bagItemInfo)
                return
            end
            --endregion

            ---官印暂时特殊处理，直接发请求包（不需要判断性别职业等）
            if (itemTbl.subType == LuaEquipmentItemType.POS_SEAL) then
                local info = clientTableManager.cfg_itemsManager:TryGetValue(itemTbl.id)
                if (info ~= nil) then
                    local isOpen = uimanager:IsOpenWithKey(info:GetConditions().list[1]);
                    if (isOpen) then
                        networkRequest.ReqPutOnTheEquip(itemTbl.subType, bagItemInfo.lid)
                    else
                        self:ShowTipBubble(bagGrid.go, nil, 456)
                    end
                end
            else
                CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(self.mBagItemInfo)
            end
            ---向服务器请求穿装备
            self:TrySendRequestEquipPlayerItemToServer(bagGrid, bagItemInfo, itemTbl)
        end
        if bubbleId ~= -1 then
            self:ShowTipBubble(bagGrid.go, nil, bubbleId)
        end

    end
end

---@param mainPlayerServantInfo CSServantInfoV2 灵兽肉身装备
function UIBagMain_Normal:EquipServantBody(mainPlayerServantInfo, bagItemInfo, itemTbl)
    local bubbleId = -1
    local servantTblType = 0
    local servantPanel = uimanager:GetPanel("UIServantPanel")
    if CS.CSServantInfoV2.IsServantCommonBody(itemTbl) then
        ---通用肉身装备
        local servantType = 0
        if servantPanel then
            servantType = servantPanel:GetSelectHeadInfo():GetServantType()
        end
        bubbleId, servantTblType = CS.CSScene.MainPlayerInfo.ServantInfoV2:ReqEquipCommonBodyEquip(bagItemInfo, itemTbl, servantType)
    else
        ---灵兽肉身
        local bodyEquipIndex = mainPlayerServantInfo:GetServantBodyIndex(itemTbl.subType)
        local servantType = math.modf(bodyEquipIndex / 1000)
        ---灵兽界面
        ---@type UIServantPanel
        if servantPanel ~= nil and servantPanel:GetSelectHeadInfo() ~= nil then
            local servantTypeOfCurrentServantPanel = servantPanel:GetSelectHeadInfo():GetServantType()
            ---若灵兽界面存在,则装备到灵兽界面当前选中的灵兽位上
            bodyEquipIndex = mainPlayerServantInfo:TransferBodyIndexWithServantType(bodyEquipIndex, servantTypeOfCurrentServantPanel)
        else
            ---若灵兽界面不存在,且为通用灵兽,则选择一个最弱的灵兽位装备上去
            if servantType == 4 then
                bodyEquipIndex = mainPlayerServantInfo:GetEquipBodyRecommendedServantIndex(bagItemInfo)
            end
        end
        bubbleId = mainPlayerServantInfo:ReqEquipBodyItem(bagItemInfo, bodyEquipIndex)
        if (bubbleId == -1) then
            if (mainPlayerServantInfo:BodyEquipToShowBaseServantPanel(bagItemInfo) ~= -1) then
                servantTblType = mainPlayerServantInfo:GetEquipServantType(itemTbl)
            end
        end
    end

    ---没有气泡则跳转
    if bubbleId == -1 then
        Utility.TransferServantPanelOpenBag(servantTblType, bagItemInfo)
    end

    return bubbleId
end

--region 神力装备的装备
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIBagMain_Normal:DoDivineEquip(bagItemInfo, go)
    if bagItemInfo then
        local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if luaItemInfo == nil then
            return
        end
        local divineId = luaItemInfo:GetDivineId()
        local divineData = clientTableManager.cfg_divinesuitManager:TryGetValue(divineId)
        if divineData == nil then
            return
        end
        if luaItemInfo:GetSubType() ~= LuaEquipmentItemType.POS_SL_FABAO then
            local playerHasEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineData:GetType(), LuaEquipmentItemType.POS_SL_FABAO)
            if divineData:GetDressDes() ~= nil and divineData:GetDressDes() ~= "" then
                local canUse = false
                if playerHasEquip and playerHasEquip.DivineSuitTbl_lua then
                    canUse = playerHasEquip.DivineSuitTbl_lua:GetLevel() >= divineData:GetLevel()
                end
                if not canUse then
                    Utility.ShowPopoTips(go, divineData:GetDressDes(), 1)
                    return
                end
            end
        end

        local type = divineData:GetType()
        if type ~= LuaEquipmentListType.Base then
            local subType = luaItemInfo:GetSubType()
            local hasRight = subType == LuaEquipmentItemType.POS_SL_LEFT_HAND or subType == LuaEquipmentItemType.POS_SL_LEFT_RING
            local isNeedSecEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsNeedSec(bagItemInfo.ItemTABLE.id)
            if isNeedSecEquip == true then
                hasRight = false
            end
            local leftIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLEquipIndex(type, luaItemInfo:GetSubType(), false)
            local reqIndex = leftIndex
            if hasRight then
                local rightIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLEquipIndex(type, luaItemInfo:GetSubType(), true)
                local mLeftPlayerDivineData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(type, leftIndex, true)
                local mRightPlayerDivineData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(type, rightIndex, true)
                if mLeftPlayerDivineData == nil or mLeftPlayerDivineData.BagItemInfo == nil then
                    reqIndex = leftIndex
                elseif mRightPlayerDivineData == nil or mRightPlayerDivineData.BagItemInfo == nil then
                    reqIndex = rightIndex
                else
                    local isBetter = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():ItemCompare(mLeftPlayerDivineData.BagItemInfo, mRightPlayerDivineData.BagItemInfo)
                    reqIndex = isBetter and leftIndex or rightIndex
                end
            end
            networkRequest.ReqPutOnTheEquip(reqIndex, bagItemInfo.lid)
        end
    end
end
--endregion

---向服务器发送请求装备物品消息
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:TrySendRequestEquipPlayerItemToServer(bagGrid, bagItemInfo, itemTbl)
    ---向服务器请求穿装备
    if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo.BagInfo then
        if (bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_MaPai
                or bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_AnQi
                or bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.MainSignet
                or bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_DouLi
                or bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_LeftWeapon
                or bagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.SubSignet) then
            networkRequest.ReqPutOnTheEquip(bagItemInfo.ItemTABLE.subType, bagItemInfo.lid)
        else
            CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(bagItemInfo)
        end
        gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckRoleNeedPushTransferItem(bagItemInfo)
    end
end

---尝试打开或使用物品
---@protected
---@param bagGrid UIBagGrid
---@param bagItemInfo bagV2.BagItemInfo
---@param itemTbl TABLE.CFG_ITEMS
function UIBagMain_Normal:TryOpenOrUseItem(bagGrid, bagItemInfo, itemTbl)
    local CSMainPlayerInfo = CS.CSScene.MainPlayerInfo
    local CSSkillTblMgr = CS.Cfg_SkillTableManager.Instance
    local CSItemTblMgr = CS.Cfg_ItemsTableManager.Instance
    local CSServantTblMgr = CS.Cfg_ServantTableManager.Instance
    local CSGlobalTblMgr = CS.Cfg_GlobalTableManager.Instance
    local mainPlayerSkillInfo = CSMainPlayerInfo.SkillInfo
    local mainPlayerServantInfo = CSMainPlayerInfo.ServantInfoV2
    local mainPlayerDuplicate = CSMainPlayerInfo.DuplicateV2
    local mainPlayerLevel = CSMainPlayerInfo.Level
    local mainPlayerReinLevel = CSMainPlayerInfo.ReinLevel
    ---@type CSUnionInfoV2
    local UnionInfoV2 = CSMainPlayerInfo.UnionInfoV2

    --region 无法在安全区使用
    if CS.CSScene.MainPlayerInfo.InProtectArea and not CS.Cfg_GlobalTableManager.Instance:CanUseItemInProtectArea(itemTbl.id) then
        self:ShowTipBubble(bagGrid.go, nil, 174)
        return
    end
    --endregion

    --region 无法背包双击使用物品
    if not CS.Cfg_GlobalTableManager.Instance:CanUseItemBagDoubbleClick(itemTbl.id) then
        return
    end
    --endregion

    --region 使用次数限制
    if Utility.ItemUseCountOverLimit(itemTbl.id) == true then
        self:ShowTipBubble(bagGrid.go, nil, 475)
        return
    end
    --endregion

    --region 元素镶嵌
    if itemTbl.type == luaEnumItemType.Element then
        local customData = { chooseEquipIndex = CS.CSScene.MainPlayerInfo.ElementInfo:GetDefaultChooseEquipIndex(itemTbl), chooseElementItemId = itemTbl.id }
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Element_Role, customData);
        uimanager:ClosePanel("UIBagPanel")
        return
    end
    --endregion

    --region 印记镶嵌（印记元素镶嵌要求不查询角色等级）
    if itemTbl.type == luaEnumItemType.Signet then

        local customData = { chooseEquipIndex = CS.CSScene.MainPlayerInfo.SignetV2:GetEquipSignetIndex(itemTbl), chooseSignetmBagItemInfo = bagItemInfo }
        if itemTbl ~= nil and itemTbl.career == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) then
            ---是印记鸭
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Imprint_Role, customData);
            uimanager:ClosePanel("UIBagPanel")
            return
        else
            Utility.ShowPopoTips(bagGrid.go.transform, '非本职业印记无法镶嵌', 269)
            return
        end
    end
    --endregion

    --region 检测玩家条件是否达到
    local mainPlayerCanUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemTbl.id)
    ---使用等级不足
    if mainPlayerCanUseItem == LuaEnumUseItemParam.UseLvNotEnough then
        self:ShowTipBubble(bagGrid.go, nil, 48)
        return
    end
    ---转生等级不足
    if mainPlayerCanUseItem == LuaEnumUseItemParam.UseReinLvNotEnough then
        self:ShowTipBubble(bagGrid.go, nil, 49)
        return
    end

    ---检测配置的使用条件是否满足
    local configConditionResult = clientTableManager.cfg_itemsManager:CheckItemsConditions(itemTbl.id)
    if configConditionResult ~= nil and configConditionResult.success == false then
        Utility.ShowPopoTips(bagGrid.go.transform, configConditionResult.txt, 49)
        return
    end
    --endregion
    --endregion

    --region 塔罗牌
    if (itemTbl.type == luaEnumItemType.Material and itemTbl.subType == 11) then
        uimanager:CreatePanel("UITreasureUsePanel")
        -- self.cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(LuaEnumCardType.Coceral)
        -- if self.cardInfo == nil or self.cardInfo.cardType == LuaEnumCoceralCardType.None then
        --     --寻路到最近塔罗先生
        --     CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 1019, 1020 }, "UIMrTarotPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, nil)
        -- else
        --     --[[            local targetMapNpcId = self.cardInfo.cardType == LuaEnumCoceralCardType.BiqiMonthCard and 202 or 205
        --                 local targetDeliverId = self.cardInfo.cardType == LuaEnumCoceralCardType.BiqiMonthCard and 10009 or 10010
        --                 CS.CSScene.MainPlayerInfo.AsyncOperationController.LangYanMengJingDeliverAndOpenPanelOperation:DoOperation(targetDeliverId, 2, targetMapNpcId)]]
        --     uimanager:CreatePanel("UIMrTarotPanel")
        -- end
        uimanager:ClosePanel("UIItemInfoPanel")
        return
    end
    --endregion

    --region 鲜花
    if itemTbl.type == luaEnumItemType.Material and (itemTbl.subType == luaEnumMaterialType.JinLan or itemTbl.subType == luaEnumMaterialType.Rose) then
        self:UseFlowerCallBack(bagItemInfo, itemTbl)
        return
    end
    --endregion

    --region 悬赏令
    if itemTbl.type == luaEnumItemType.Material and itemTbl.subType == luaEnumMaterialType.rewardOrder then
        local mapNPCID = 91
        local isKuaFu = luaclass.RemoteHostDataClass:IsKuaFuMap()
        if isKuaFu then
            mapNPCID = 124
        end

        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ mapNPCID }, "UIArrestPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, { mapNPCID })
        uimanager:ClosePanel("UIBagPanel")
        return
    end
    --endregion

    --region 狂欢劵
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 31 then
        ---判断活动是否开始
        if not Utility.CheckSystemOpenState(51) then
            ---若限时活动未开启弹出气泡
            Utility.ShowPopoTips(go.transform, nil, 449, "UIBagPanel")
            return
        end

        if gameMgr:GetPlayerDataMgr() ~= nil then
            if not gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetActivityOpenState(8) then
                ---若狂欢商店未开启弹出气泡
                Utility.ShowPopoTips(bagGrid.go, nil, 449, 'UIBagPanel')
                return
            end
        end
    end
    --endregion

    --region 使用物品时检查是否打开界面，如果打开界面,则不向服务器发送消息
    if self:TryOpenPanel(LuaEnumItemOperateType.Use, itemTbl) then
        --特殊处理法阵直升券
        if itemTbl.type == 8 and itemTbl.subType == 51 then
            --不return，打开界面并且使用
        else
            uimanager:ClosePanel("UIBagPanel")
            return
        end
    end
    if self:TryOpenPanel(LuaEnumItemOperateType.Open, itemTbl) then
        uimanager:ClosePanel("UIBagPanel")
        return
    end
    --endregion

    --region 间谍牌
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 16 then
        Utility.TrySetSpySnapItemInfoGrid({ lid = bagItemInfo.lid, itemId = itemTbl.id, icon = itemTbl.icon, go = bagGrid.go })
        return
    end
    --endregion

    --region 检查是否为组队召唤类型
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 5 then
        local GroupInfoV2 = CS.CSScene.MainPlayerInfo.GroupInfoV2
        if (GroupInfoV2.GroupInfo == nil) then
            self:ShowTipBubble(bagGrid.go, nil, 84)
            return
        end
        local zhaohuanmonsterid = 0
        if (CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList ~= nil) then
            local list = CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList
            for i = 0, list.Count - 1 do
                local monster = CS.CSScene.Sington:getAvatar(list[i].targetId)
                if (monster ~= nil and monster.isDead == false and monster.AvatarType == CS.EAvatarType.Monster) then
                    if (Utility.IsContainsValue(LuaGlobalTableDeal.ZhaoHuanLingShowNameBossTypeTable(), monster.MonsterTable.type)) then
                        zhaohuanmonsterid = monster.MonsterTable.id
                        break
                    end
                end
            end
        end
        local lid = bagItemInfo.lid
        networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        return
    end
    --endregion

    --region 玩家战斗状态
    local zhaohuanmonsterid = 0
    if (CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList ~= nil) then
        local list = CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList
        for i = 0, list.Count - 1 do
            local monster = CS.CSScene.Sington:getAvatar(list[i].targetId)
            if (monster ~= nil and monster.isDead == false and monster.AvatarType == CS.EAvatarType.Monster) then
                if (Utility.IsContainsValue(LuaGlobalTableDeal.ZhaoHuanLingShowNameBossTypeTable(), monster.MonsterTable.type)) then
                    zhaohuanmonsterid = monster.MonsterTable.id
                    break
                end
            end
        end
    end
    local lid = bagItemInfo.lid
    --endregion

    --region 检查是否为转生直升卷轴类型
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 37 then
        if (itemTbl.useParam ~= nil and itemTbl.useParam.list.Count > 0 and itemTbl.useParam.list[0] <= CS.CSScene.MainPlayerInfo.ReinLevel) then
            local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(471)
            if isfind then
                self:ShowTipBubble(bagGrid.go, string.format(data.content, itemTbl.useParam.list[0]), 471)
            end
            return
        end
    end

    --region 检查是否为帮会召唤类型
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 6 then
        ---指定地图不能使用召唤令
        --if (CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(CS.CSScene.getMapID())) then
        --    UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 82)
        --    return
        --end
        ---未加入帮会
        if (UnionInfoV2.UnionID == 0) then
            self:ShowTipBubble(bagGrid.go, nil, 82)
            return
        end
        ---职位不符
        if (UnionInfoV2.UnionInfo.unionInfo.leaderId ~= 0 and UnionInfoV2.UnionInfo.myPositionInfo < UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition) then
            local pos = uiStaticParameter.PosStringList[UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition]
            local str = pos .. "职位以上可使用"
            self:ShowTipBubble(bagGrid.go, str, 83)
            return
        end
        ---组队条件
        if luaclass.UnionDataInfo:TeamCanUseUnionSummonToken() == false then
            self:ShowTipBubble(bagGrid.go, nil, 355)
            return
        end

        ---玩家在60级之前，在所有地图，主角当前不在战斗状态需二次确认
        if CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and CS.CSScene.MainPlayerInfo.InCombat == false then
            Utility.ShowSecondConfirmPanel({ PromptWordId = 111, CancelCallBack = function()
                networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.EServerMapObjectType.Null) })
            end })
            return
        end
        ---等级低于限制时,且地图未被屏蔽时需要二次弹窗判定是否使用召唤令
        --if (CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and Utility.IsContainsValue(LuaGlobalTableDeal.ZhaoHuanLingDontNeedSecondConfirmMapTable(), CS.CSScene.getMapID()) == false) then
        --    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(111)
        --    if isFind then
        --        local temp = {}
        --        temp.Content = info.des
        --        temp.LeftDescription = info.leftButton
        --        temp.RightDescription = info.rightButton
        --        temp.ID = 111
        --        temp.CancelCallBack = function()
        --            networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid)
        --        end
        --        temp.CallBack = function()
        --        end
        --        uimanager:CreatePanel("UIPromptPanel", nil, temp)
        --        uimanager:ClosePanel("UIItemInfoPanel")
        --        uimanager:ClosePanel("UIPetInfoPanel")
        --        return
        --    end
        --end
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        return
    end
    --endregion

    --region 是否为联盟召唤
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 30 then
        --region 是否加入联盟
        local isInLeague = gameMgr:GetPlayerDataMgr():GetLeagueInfo():IsMainPlayerInLeague();
        if (not isInLeague) then
            self:ShowTipBubble(bagGrid.go, nil, 418)
            return
        end
        --endregion

        --region 仅盟主和副盟主可使用
        local isBetterPost = gameMgr:GetPlayerDataMgr():GetLeagueInfo():MainPlayerPostIsBetterThenFuMengZhu()
        if isBetterPost == false then
            self:ShowTipBubble(bagGrid.go, nil, 419)
            return
        end
        --endregion

        --region 是否处于跨服地图
        local isInTargetMap = luaclass.RemoteHostDataClass:IsKuaFuMap();
        if (not isInTargetMap) then
            self:ShowTipBubble(bagGrid.go, nil, 424)
            return
        end
        --endregion
        print("请求的战斗状态" .. tostring(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType)))
        networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        return
    end

    --endregion

    --region Boss召唤令
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 3 then
        if (CS.CSScene.MainPlayerInfo.MapInfoV2:IsMainCityMap(CS.CSScene.MainPlayerInfo.MapID) == false) then
            self:ShowTipBubble(bagGrid.go, nil, 433)
            return
        end
    end
    --endregion

    --region 青铜会员使用
    if itemTbl.type == 8 and itemTbl.subType == 45 then
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:CreatePanel("UIRechargeMemberPanel")
    end
    --endregion

    --region 自动回收卡使用
    if itemTbl.type == 8 and itemTbl.subType == 46 then
        CS.CSListUpdateMgr.Add(100, nil, function()
            if LuaGlobalTableDeal:IsShowQuickRecycle() == false then
                Utility.OpenRecycleHint()
                return
            end
            luaEventManager.DoCallback(LuaCEvent.Bag_AutoRecycleUse);
        end)
    end
    --endregion

    --region 使用技能书时,若未学习该技能且技能面板未打开,则打开技能面板以手动学习该技能
    if itemTbl.type == luaEnumItemType.SkillBook then
        --先判断技能书是否本职业可用
        local mainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        if not (itemTbl.career == mainPlayerCareer or itemTbl.career == LuaEnumCareer.Common) then
            Utility.ShowPopoTips(bagGrid.go.transform, nil, 394)
            return
        end

        --低级技能书不能升级高级技能
        if itemTbl.subType == 0 and itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 1 then
            local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(itemTbl.useParam.list[0])
            if skillDetailedInfo ~= nil and skillDetailedInfo.IsHighSkill == true then
                Utility.ShowPopoTips(bagGrid.go.transform, nil, 390)
                return
            end
        end
        --高技能书不能升级低级技能
        if itemTbl.subType == 2 and itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 1 then
            local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(itemTbl.useParam.list[0])
            if skillDetailedInfo == nil or skillDetailedInfo.IsHighSkill == false then
                Utility.ShowPopoTips(bagGrid.go.transform, nil, 392)
                return
            end
        end
        --强化技能技能书使用限制
        if itemTbl.subType == 5 and itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 1 and gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic ~= nil then
            ---@type LuaSkillDetailedInfo
            local isCanUse = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsCanUseIntensifySkillBook(itemTbl.useParam.list[0], itemTbl.id)
            if isCanUse == false then
                Utility.ShowPopoTips(bagGrid.go.transform, "技能等级不符", 392)
                return
            end
        end
        local isNeed = mainPlayerSkillInfo:IsNeedStudySkill(bagItemInfo);
        local skillPanel = uimanager:GetPanel("UISkillPanel")
        if isNeed and skillPanel == nil and itemTbl.useParam ~= nil and itemTbl.useParam.list.Count > 0 then
            local skillID = itemTbl.useParam.list[0]
            ---@type TABLE.CFG_SKILLS
            local skillTbl
            ___, skillTbl = CSSkillTblMgr:TryGetValue(skillID)
            if skillTbl then
                if skillTbl.cls == 0 or skillTbl.cls == 4 then
                    ---打开技能详情
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, { targetId = luaEnumNavigationType.SkillDetails })
                elseif skillTbl.cls == 3 then
                    ---打开心法
                    luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, { targetId = luaEnumNavigationType.HeartSkill })
                end
            end
            self:GetBagPanel():GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OpenPanelFinished, self.mOnSkillPanelOpenedFunction)
            return
        end
    end
    --endregion

    --region 元宝宝箱
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 32 then
        --元宝宝箱的击杀次数判定
        if bagItemInfo.luck < bagItemInfo.maxStar then
            self:ShowTipBubble(bagGrid.go, "未满足开启条件", 48)
            return
        else
            networkRequest.ReqUseMoneyBox(bagItemInfo.lid, bagItemInfo.count)
            return
        end
    end
    --endregion

    --region 聚灵珠类型使用时需要打开聚灵珠界面或不打开仅提示
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 4 then
        --聚灵珠当前存储的经验值存在luck中,最大经验值存在maxStart中
        if bagItemInfo.luck < bagItemInfo.maxStar then
            self:ShowTipBubble(bagGrid.go, nil, 187)
            return
        else
            ---@type UIJuLingZhuPanel
            Utility.TryOpenJLZPanel({ info = itemTbl })
            --uimanager:ClosePanel("UIBagPanel")
        end
        return
    end
    --endregion

    --region 红包类型需要在使用的同时打开红包界面
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 7 then
        if bagItemInfo.count < 2 then
            --物品数量小于2时，直接请求使用该物品
            networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
            --uimanager:CreatePanel("UILuckyMoneyPanel")
        else
            --物品数量大于1时，根据批量使用类型使用
            if itemTbl.batchusage == 1 then
                --若批量使用类型为弹出数量界面选择使用数量
                self.mLuckyMoneyBagItemInfo = bagItemInfo
                uimanager:CreatePanel("UIItemCountPanel", nil, {
                    Title = "使 用",
                    ItemInfo = itemTbl,
                    CallBack = self.mOnConfirmUseLuckyMoneyFunction,
                    BeginningCount = 1,
                    MaxCount = bagItemInfo.count
                })
            elseif itemTbl.batchusage == 2 then
                --若批量使用类型为使用当前格子所有物品
                networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
                --uimanager:CreatePanel("UILuckyMoneyPanel")
            else
                --不批量使用
                networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
                --uimanager:CreatePanel("UILuckyMoneyPanel")
            end
        end
        return
    end
    --endregion

    --region 掠宝袋类型使用的时候打开掠宝袋界面
    if Utility.IsEquipBox(itemTbl) then
        local bagData = {}
        bagData.bagItemInfo = bagItemInfo
        bagData.name = itemTbl.name
        uimanager:CreatePanel("UITreasureBagPanel", nil, bagData)
        return
    end
    --endregion

    --region 黄金/白银宝箱
    if Utility.IsSpecialEquipBox(itemTbl) or Utility.IsSpecialEquipBoxKey(itemTbl) then
        local boxId = Utility.GetSpecialKeyBoxInfo(itemTbl.id)
        local boxItemInfoIsFind, boxItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(boxId)
        local haveBox = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(boxId)

        if not Utility.CanUseSpecialEquipBox(itemTbl) then
            Utility.ShowPopoTips(bagGrid.go, nil, 344)
            return
        end

        local res = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemTbl.id)
        if res == LuaEnumUseItemParam.UseLvNotEnough then
            self:ShowTipBubble(bagGrid.go, "人物等级不足", 48)
        elseif res == LuaEnumUseItemParam.UseReinLvNotEnough then
            self:ShowTipBubble(bagGrid.go, "人物转生等级不足", 48)
        elseif haveBox == false and boxItemInfoIsFind == true then
            self:ShowTipBubble(bagGrid.go, "没有" .. boxItemInfo.name, 48)
        else
            local bagData = {}
            bagData.bagItemInfo = bagItemInfo
            bagData.name = itemTbl.name
            uimanager:CreatePanel("UISpecialTreasureBagPanel", nil, bagData)
        end
        return
    end
    --endregion

    --region 使用灵兽蛋,需要跳转到对应的灵兽界面
    if (itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 8) then
        local servantList = mainPlayerServantInfo.ServantInfoList
        local typeInfo
        ___, typeInfo = CSItemTblMgr:TryGetValue(itemTbl.id)
        if typeInfo ~= nil then
            local servantTbl
            ___, servantTbl = CSServantTblMgr:TryGetValue(typeInfo.useParam.list[0])
            if servantList.Count == 0 or (servantTbl.type > servantList.Count and servantTbl.type ~= 4) then
                self:ShowTipBubble(bagGrid.go, nil, 46)
                return
            end
            local index = mainPlayerServantInfo:CheckReqUseServantEgg()
            if (index == 1) then
                if (servantTbl.type == 1) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                elseif (servantTbl.type == 2) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                elseif (servantTbl.type == 3) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                elseif (servantTbl.type == 4) then
                    local pos = mainPlayerServantInfo:GetBodyLowServantIndex()
                    if (pos == 1) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                    elseif (pos == 2) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                    elseif (pos == 3) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC, { openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel });
                    end
                end
            end
        end
    end
    --endregion

    --region 使用烟花需要判断时间弹出tips播放烟花特效
    if itemTbl.type == luaEnumItemType.Material and itemTbl.subType == luaEnumMaterialType.Firework then
        self.firworkItemTabel = itemTbl
        self.firworkBagInfo = bagItemInfo
        self.mOnFireWorkPromptCallbackFunction(bagGrid.go)
        return
    end
    --endregion

    --region 烟花之地
    if itemTbl.type == luaEnumItemType.Material and itemTbl.subType == luaEnumMaterialType.LandOfFireworks then
        if itemTbl.useParam and itemTbl.useParam.list and itemTbl.useParam.list.Count >= 2 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(itemTbl.useParam.list[1], nil)
            uimanager:ClosePanel("UIBagPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        end
        return
    end
    --endregion

    --region 藏品
    if itemTbl.type == luaEnumItemType.Collection then
        local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
        local bagItemInCarbinet = collectionInfo:GetCollectionItemByCollectionID(bagItemInfo.itemId)
        local collectionOpened, reasonStr = collectionInfo:IsMainPlayerCollectionOpened()
        if collectionOpened == false then
            if reasonStr ~= nil then
                Utility.ShowPopoTips(bagGrid.go, reasonStr, 290, "UIBagPanel")
            end
            return
        end
        if bagItemInCarbinet ~= nil and collectionInfo:IsLeftBetterThanRight(bagItemInCarbinet:GetCollectionBagItem(), bagItemInfo) then
            ---如果藏品阁中有该物品且比当前物品更好,则二次弹窗确认
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, false)
            if result == false then
                Utility.ShowPopoTips(bagGrid.go, resultStr, 290, "UIBagPanel")
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            else
                local wordTbl, tblExist
                tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(155)
                if tblExist and wordTbl then
                    Utility.ShowSecondConfirmPanel({ PromptWordId = 155, ComfireAucion = function()
                        collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
                        if uimanager:GetPanel("UICollectionPanel") == nil then
                            ---如果藏品界面未打开,则跳转到藏品界面
                            uiTransferManager:TransferToPanel(607)
                        end
                    end })
                else
                    collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
                    if uimanager:GetPanel("UICollectionPanel") == nil then
                        ---如果藏品界面未打开,则跳转到藏品界面
                        uiTransferManager:TransferToPanel(607)
                    end
                end
            end
        else
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(bagItemInfo, nil, nil, nil, true)
            if result == false then
                Utility.ShowPopoTips(bagGrid.go, resultStr, 290, "UIBagPanel")
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            else
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            end
        end
    end
    --endregion

    --region 圣域斩杀令（圣域斩杀令需特殊处理，打开二次确认面板）
    if itemTbl.id == 6090005 then
        Utility.ShowSecondConfirmPanel({ PromptWordId = 56, ComfireAucion = function()
            if itemTbl.useParam.list.Count >= 2 then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(itemTbl.useParam.list[1])
                uimanager:ClosePanel("UIBagPanel")
            end
        end })
        return
    end
    --endregion

    --region 个人押镖材料
    if CS.Cfg_PersonDartCarTableManager.Instance:IsPersonDartCarConsume(itemTbl.id) then
        local npcId = CS.Cfg_PersonDartCarTableManager.Instance:GetNpcIdByItemId(itemTbl.id)
        if npcId ~= 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ npcId }, "UIIndividEscortPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, npcId)
            uimanager:ClosePanel("UIBagPanel")
            return
        end
    end
    --endregion

    --region 地图通行证
    if itemTbl.type == luaEnumItemType.Material and itemTbl.subType == luaEnumMaterialType.MapPassCheck then
        if itemTbl.useParam ~= nil and itemTbl.useParam.list.Count > 0 then
            local isFind, propmtWortId = CS.Cfg_GlobalTableManager.Instance:TryGetItemPromptWordId(itemTbl.id);
            if (isFind) then
                Utility.ShowSecondConfirmPanel({ PromptWordId = propmtWortId, ComfireAucion = function()
                    if itemTbl.useParam.list.Count >= 2 then
                        local extraData
                        if itemTbl.id == 6090001 then
                            extraData = 9304
                        end
                        CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(itemTbl.useParam.list[1], nil, extraData)
                        uimanager:ClosePanel("UIBagPanel")
                        uimanager:ClosePanel("UIItemInfoPanel")
                    end
                end })
            else
                local customData = {};
                customData.mItemInfo = itemTbl;
                uimanager:CreatePanel("UIUsePassCheckPanel", nil, customData)
            end
        end
        return
    end
    --endregion

    --region 灵兽复活药
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 19 then
        --local isExist, servantType, bagItemLID = CSMainPlayerInfo.ServantInfoV2:GetDefaultReliveServantType()
        --if isExist then
        networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
        --end
        return
    end
    --endregion

    --region 沃玛号角
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 21 then
        uimanager:CreatePanel("UICreateGuildPanel")
        return
    end
    --endregion

    --region 祝福油、诅咒油
    if itemTbl.type == luaEnumItemType.Assist and (itemTbl.subType == 9 or itemTbl.subType == 10) then

        local isFind, value = CS.Cfg_GlobalTableManager.Instance.allOilAndEquipIndexDic:TryGetValue(itemTbl.id)
        if not isFind then
            return
        end
        local info = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(value)
        if info then
            local temp = {}
            temp.equipInfo = info
            temp.bagItemInfo = bagItemInfo
            temp.equipIndex = value
            uimanager:CreatePanel("UIZhuFuYouPanel", nil, temp)
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            Utility.ShowPopoTips(bagGrid.go.transform, nil, itemTbl.subType == 9 and 240 or 241)
        end
        return
    end
    --endregion

    --region 行会红包
    if Utility.IsUnionRedPack(itemTbl) then
        local hasUnion = UnionInfoV2.UnionID ~= 0
        if hasUnion then
            local customData = {}
            customData.BagItemInfo = bagItemInfo
            ---@type UIPersonSendRedPackCouponPanelTemplate
            customData.Template = luaComponentTemplates.UIPersonSendRedPackCouponPanelTemplate
            uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
        else
            Utility.ShowPopoTips(bagGrid.go, nil, 307)
        end
        return
    end
    --endregion

    --region 自选宝箱
    if Utility.TryCreateOptionalList({ bagItemInfo = bagItemInfo }) == true then
        return
    end
    --endregion

    --region 魔法神石
    if CS.CSScene.MainPlayerInfo.MagicCircleInfo:IsMagicBallItem(itemTbl.id) == true then
        local unionId = UnionInfoV2.UnionID
        if unionId == 0 then
            Utility.ShowPopoTips(bagGrid.go, nil, 302)
        else
            Utility.CreateItemUsePanel({ itemInfo = itemTbl })
        end
        return
    end
    --endregion

    --region 使用腕力药水
    if itemTbl.type == luaEnumItemType.Drug and itemTbl.subType == 6 then
        if Utility.IsWristStrengthBoundMax() then
            Utility.ShowPopoTips(bagGrid.go, nil, 399)
            return
        end

    end
    --endregion

    --region 使用精力药水
    if itemTbl.type == luaEnumItemType.Drug and itemTbl.subType == 7 then
        if Utility.IsEnergyBoundMax() then
            Utility.ShowPopoTips(bagGrid.go, nil, 400)
            return
        end
    end
    --endregion

    --region 使用献祭之油
    if itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 28 and
            itemTbl.useParam ~= nil and itemTbl.useParam.list ~= nil and itemTbl.useParam.list.Count > 0 then
        Utility.ShowPromptTipsPanel({ id = 147, Callback = function()
            ---是否开启了联服
            local isKuaFuOpen = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
            if not isKuaFuOpen then
                Utility.ShowPopoTips(bagGrid.go, nil, 442)
            else
                luaclass.FindPath:FindPath_DeliverId(itemTbl.useParam.list[0])
                uimanager:ClosePanel("UIBagPanel")
            end
        end })
        return
    end
    --endregion

    --region 精炼石
    if gameMgr:GetPlayerDataMgr().GetMainPlayerRefineMgr ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerRefineMgr():IsRefineStone(itemTbl.id) then
        if bagItemInfo == nil or itemTbl == nil then
            return
        end
        uimanager:ClosePanel("UIBagPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Refine, { bagItemInfo = bagItemInfo })
        return
    end
    --endregion

    --region 白日门押镖材料
    if gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():IsBaiRiMenDartCarMaterial(itemTbl.id) then
        if bagItemInfo == nil or itemTbl == nil then
            return
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        Utility.ShowSecondConfirmPanel({ PromptWordId = 150, ComfireAucion = function()
            uimanager:ClosePanel("UIBagPanel")
            uimanager:CreatePanel("UIWhiteSunGatePanel", nil, { type = LuaEnumBaiRiMenActivityType.HuoYun })
        end })
    end
    --endregion

    --region 洗髓石
    if itemTbl.type == luaEnumItemType.Material and itemTbl.subType == 44 then
        local noticeInfo = clientTableManager.cfg_noticeManager:TryGetValue(73)
        if noticeInfo then
            local openSys = Utility.IsNoticeOpenSystem(noticeInfo)
            if openSys then
                uimanager:ClosePanel("UIItemInfoPanel")
                uimanager:ClosePanel("UIBagPanel")
                uiTransferManager:TransferToPanel(LuaEnumTransferType.AgainRefine_Role)
            else
                Utility.ShowPopoTips(bagGrid.go, nil, 464)
            end
        end
        return
    end
    --endregion

    --region 随身仓库
    if itemTbl ~= nil and clientTableManager.cfg_itemsManager:IsStorage(itemTbl.id) then
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:CreatePanel("UIPlayerWarehousePanel")
    end
    --endregion

    --region 聚宝盆
    if itemTbl ~= nil and itemTbl.type == luaEnumItemType.Assist and itemTbl.subType == 36 then
        local state = Utility.IsPlayerAutoPickOpen()
        if state == 1 or state == 2 then
            Utility.ShowPopoTips(bagGrid.go, nil, 470)
            return
        end
    end
    --endregion

    --region 需要打开二次确认面板的物品(策划配置)
    local promptWordId = LuaGlobalTableDeal.ItemNeedOpenSecondConfirmPanel(itemTbl.id)
    if type(promptWordId) == 'number' then
        Utility.ShowSecondConfirmPanel({ PromptWordId = promptWordId, ComfireAucion = function()
            networkRequest.ReqUseItem(1, bagItemInfo.lid)
        end })
        return
    end
    --endregion

    ---闯关令使用
    if itemTbl.id == 6280001 then
        uimanager:ClosePanel("UIItemInfoPanel")
        local deliverID = CS.Cfg_GlobalTableManager.Instance.TowerDeliverId;
        Utility.TryTransfer(deliverID, false);
        return
    end

    --region 正常使用
    if bagItemInfo.count < 2 then
        ---物品数量小于2时,直接请求使用
        networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
    else
        ---物品数量大于1时,根据批量使用的类型决定使用数量
        if itemTbl.batchusage == 1 then
            ---若可批量使用则弹出数量窗口并选择数量
            self.mBatchUseItemBagItemInfo = bagItemInfo
            uimanager:CreatePanel("UIItemCountPanel", nil, { Title = "使 用", ItemInfo = itemTbl, CallBack = self.mOnBatchUseItemCallbackFunction, BeginningCount = 1, MaxCount = bagItemInfo.count })
        elseif itemTbl.batchusage == 2 then
            ---若批量使用类型为使用当前格子所有物品
            networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, 0)
        else
            ---不批量使用
            networkRequest.ReqUseItem(1, bagItemInfo.lid, 0)
        end
    end
    --endregion
end

---尝试打开界面
---@protected
---@param operateID number 操作ID
---@param itemTbl TABLE.CFG_ITEMS
---@return boolean 是否成功打开界面
function UIBagMain_Normal:TryOpenPanel(operateID, itemTbl)
    local CSItemTblMgr = CS.Cfg_ItemsTableManager.Instance
    if itemTbl.openPanelSpecified then
        local res, panelParams = CSItemTblMgr.OpenPanel:TryGetValue(itemTbl.id)
        if res and panelParams ~= nil and panelParams.Count > 0 then
            for i = 0, panelParams.Count - 1 do
                local paramTemp = panelParams[i]
                if paramTemp.operateID == operateID then
                    if paramTemp.jumpID ~= 0 then
                        uiTransferManager:TransferToPanel(paramTemp.jumpID);
                    else
                        CSUtility.ShowTips("openPanel未配置")
                    end
                    return true
                end
            end
        end
    end
    return false
end
--endregion

--region 显示背包内提示
---显示提示气泡
---@public
---@param go UnityEngine.GameObject
---@param content string 为nil时表示使用ID对应的提示内容
---@param id number
function UIBagMain_Normal:ShowTipBubble(go, content, id)
    if CS.StaticUtility.IsNull(go) == false then
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, {
            [LuaEnumTipConfigType.Parent] = go.transform,
            [LuaEnumTipConfigType.Describe] = content,
            [LuaEnumTipConfigType.ConfigID] = id,
            [LuaEnumTipConfigType.DependPanel] = "UIBagPanel",
        })
    end
end
--endregion

--region 事件
---技能界面打开事件
---@private
function UIBagMain_Normal:OnSkillPanelOpened()
    self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OpenPanelFinished, self.mOnSkillPanelOpenedFunction)
    uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Skill)
end

---确认使用红包事件
---@private
---@param count number 使用的数量
function UIBagMain_Normal:OnUseLuckyMoneyConfirmed(count)
    local bagItemInfo = self.mLuckyMoneyBagItemInfo
    self.mLuckyMoneyBagItemInfo = nil
    if bagItemInfo then
        networkRequest.ReqUseItem(count, bagItemInfo.lid, 0)
        --uimanager:CreatePanel("UILuckyMoneyPanel")
    end
end

---批量使用物品回调
---@private
function UIBagMain_Normal:OnBatchUseItemCallback(count)
    if count and count > 0 and self.mBatchUseItemBagItemInfo then
        networkRequest.ReqUseItem(count, self.mBatchUseItemBagItemInfo.lid, 0)
        self.mBatchUseItemBagItemInfo = nil
    end
end

---灵兽经验刷新事件
---@private
function UIBagMain_Normal:OnServantExtUpdateReceived(msgID, data)
    if data and data.actId ~= nil and data.actId == 4001 and (data.pool ~= nil and data.pool > 0) then
        --延迟10帧
        self.mNeedPlayServantExpEffect = 10
    end
end
--endregion

--region 重写逐帧刷新
function UIBagMain_Normal:OnUpdate(time)
    if self.DelayRefreshGridTable ~= nil then
        for k, v in pairs(self.DelayRefreshGridTable) do
            if v ~= nil and time > v.delayTime then
                self:RefreshSingleGrid(v.bagGrid, v.bagItemInfo, v.itemTbl)
                table.remove(self.DelayRefreshGridTable, k)
            end
        end
    end
    self:TryPlayServantExpEffect()
end
--endregion

--region 延迟刷新格子数据管理
---检测是否延迟刷新（如果延迟刷新则加入延迟刷新缓存）
function UIBagMain_Normal:CheckDelayBagItemInfoRefresh(bagGrid, bagItemInfo, itemTbl)
    if self.DelayRefreshGridTable == nil then
        self.DelayRefreshGridTable = {}
    end
    if bagItemInfo == nil or not (uimanager:GetPanel("UIRolePanel") ~= nil or uimanager:GetPanel("UIServantPanel") ~= nil) then
        return false
    end
    if CS.CSScene.MainPlayerInfo.BagInfo:CheckIsDomountEquip(LuaEnumBagChangeAction.PUTOFF_ChangeEquip, bagItemInfo) == true and self:CheckCotainsGrid(bagGrid) == false then
        local commonData = { bagGrid = bagGrid, bagItemInfo = bagItemInfo, itemTbl = itemTbl, delayTime = self:GetBagPanel():GetTime() + self:RemoveEquipDelayRefreshTime() }
        table.insert(self.DelayRefreshGridTable, commonData)
        return true
    end
    return false
end

---是否有该格子缓存
function UIBagMain_Normal:CheckCotainsGrid(bagGrid)
    if self.DelayRefreshGridTable ~= nil then
        for k, v in pairs(self.DelayRefreshGridTable) do
            if v.bagGrid.go == bagGrid.go then
                return true
            end
        end
    end
    return false
end
--endregion

--region 烟花使用

---使用烟花回调（基础判定）
function UIBagMain_Normal:UseFireworkCallBack(go)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    --是否已达每日上限
    if CS.CSScene.MainPlayerInfo.DuplicateV2.isBoundMaxDay then
        Utility.ShowPopoTips(go, nil, 85)
        return
    end
    self:CheckUseCount()
end

---查看使用多个烟花
function UIBagMain_Normal:CheckUseCount()
    if self.firworkBagInfo.count < 2 then
        --物品数量小于2时，直接请求使用该物品
        self:TryUseFireworkFunc(1)
    else
        --物品数量大于1时，根据批量使用类型使用
        if self.firworkItemTabel.batchusage == 1 then
            --若批量使用类型为弹出数量界面选择使用数量
            local useFunction = function(count)
                self:TryUseFireworkFunc(count)
            end
            local maxCount = CS.CSScene.MainPlayerInfo.DuplicateV2:SelectFireworkCount(self.firworkBagInfo.count)
            uimanager:CreatePanel("UIItemCountPanel", function()
                uimanager:ClosePanel("UIItemInfoPanel")
            end, {
                Title = "使 用",
                ItemInfo = self.firworkItemTabel,
                CallBack = useFunction,
                MinCount = 1,
                BeginningCount = maxCount,
                MaxCount = maxCount == 0 and 1 or maxCount
            })
        elseif self.firworkItemTabel.batchusage == 2 then
            --若批量使用类型为使用当前格子所有物品
            self:TryUseFireworkFunc(self.firworkBagInfo.count)
        else
            --不批量使用
            self:TryUseFireworkFunc(1)
        end
    end
end

---尝试使用烟花
function UIBagMain_Normal:TryUseFireworkFunc(count)
    --判断是否超过时间界限而非使用界限
    if CS.CSScene.MainPlayerInfo.DuplicateV2:IsOutOfBoundsOfCount(count) then
        self:ShowOutOfBoundsFireworkTips(count)
    else
        self:UseFirworkItemCount(count)
    end
end

---使用烟花最终方法
function UIBagMain_Normal:UseFirworkItemCount(count)
    networkRequest.ReqUseItem(count, self.firworkBagInfo.lid)
    uimanager:ClosePanel("UIBagPanel")
    uimanager:ClosePanel("UIPromptPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIItemCountPanel")
end

---显示超界烟花tips
function UIBagMain_Normal:ShowOutOfBoundsFireworkTips(count)
    local isFind, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20413)
    if isFind then
        local str = info.value
        str = string.Split(str, '#')
        local temp = {}
        temp.Title = ''
        temp.Content = str[1]
        --temp.LeftDescription = str[2]
        temp.RightDescription = str[3]
        temp.IsClose = false
        temp.CallBack = function()
            self:UseFirworkItemCount(count)
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

--endregion

--region 鲜花使用
function UIBagMain_Normal:UseFlowerCallBack(bagIteminfo, itemTabel)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    local isFind = CS.CSScene.MainPlayerInfo.FriendInfoV2:isHasFriendOfSex(itemTabel.subType == luaEnumMaterialType.Rose)
    if not isFind then
        uimanager:CreatePanel("UISendFlowerRandomPanel", nil, { bagInfo = bagIteminfo, tabelInfo = itemTabel })
        uimanager:ClosePanel('UIItemInfoPanel')
    else
        uiTransferManager:TransferToPanel(1405)
        uimanager:ClosePanel('UIItemInfoPanel')
    end
end
--endregion


--region 播放灵兽经验特效
---尝试播放灵兽经验特效
---@protected
function UIBagMain_Normal:TryPlayServantExpEffect()
    if self.mNeedPlayServantExpEffect ~= nil then
        self.mNeedPlayServantExpEffect = self.mNeedPlayServantExpEffect - 1
        if self.mNeedPlayServantExpEffect == 0 then
            self.mNeedPlayServantExpEffect = nil
            if uimanager:GetPanel("UIServantPanel") == nil then
                ---在背包中央创建特效
                local position = self:GetBagPanel():GetScrollView().transform.parent.position
                local effectLoad = CS.UILocalScreenEffectLoader.Instance:CreateNewEffect()
                effectLoad:AddTimeLineData("700109", CS.UILayerType.WindowsPlane, nil, { position = position, timePoint = 0 }, { position = position, timePoint = 5 })
                effectLoad:Play()
            end
        end
    end
end
--endregion

--region 析构
function UIBagMain_Normal:OnDestroy()
    self:RunBaseFunction("OnDestroy")
    if self.mOnSkillPanelOpenedFunction then
        self:GetBagPanel():GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OpenPanelFinished, self.mOnSkillPanelOpenedFunction)
    end
    if self.mOnServantExtUpdateCallbackFunction then
        self:GetBagPanel():GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResServantExpUpdateMessage, self.mOnServantExtUpdateCallbackFunction)
    end
end
--endregion

return UIBagMain_Normal