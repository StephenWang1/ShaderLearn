---@class UIItemInfoPanel_Info_RightUpOperateButtons
local UIItemInfoPanel_Info_RightUpOperateButtons = {}

setmetatable(UIItemInfoPanel_Info_RightUpOperateButtons, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 局部变量
---背景图额外增加的宽度
UIItemInfoPanel_Info_RightUpOperateButtons.BgWeight = 10
---背景图额外增加的高度
UIItemInfoPanel_Info_RightUpOperateButtons.BgHeight = 20
--endregion

--region 引用
function UIItemInfoPanel_Info_RightUpOperateButtons:GetBagPanel()
    if self.bagPanel == nil then
        self.bagPanel = uimanager:GetPanel("UIBagPanel")
    end
    return self.bagPanel
end
--endregion

--region 按钮组件
---右上角按钮的集合
function UIItemInfoPanel_Info_RightUpOperateButtons:GetBtns_UIGridContainer()
    if self.mItemInfoPanel_Info_OperateButtons == nil then
        self.mItemInfoPanel_Info_OperateButtons = self:Get("btns", "UIGridContainer")
    end
    return self.mItemInfoPanel_Info_OperateButtons
end

---右上角按钮背景图
function UIItemInfoPanel_Info_RightUpOperateButtons:GetBackGround_GameObject()
    if self.mBackGround_GameObject == nil then
        self.mBackGround_GameObject = self:Get("btns/bg", "GameObject")
    end
    return self.mBackGround_GameObject
end

---右上角按钮背景图
function UIItemInfoPanel_Info_RightUpOperateButtons:GetBackGround_UISprite()
    if self.mBackGround_UISprite == nil then
        self.mBackGround_UISprite = self:Get("btns/bg", "UISprite")
    end
    return self.mBackGround_UISprite
end

---展开关闭按钮
function UIItemInfoPanel_Info_RightUpOperateButtons:GetShowClose_GameObject()
    if self.mShowClose_GameObject == nil then
        self.mShowClose_GameObject = self:Get("btns/showclose", "GameObject")
    end
    return self.mShowClose_GameObject
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_RightUpOperateButtons:RefreshWithInfo(commonData)
    ---@type bagV2.BagItemInfo
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local highLightBtnTable = commonData.highLightBtnTable
    self.mBagItemInfo = bagItemInfo
    ---@type TABLE.CFG_ITEMS
    self.mItemInfo = itemInfo
    self.highLightBtnTable = highLightBtnTable
    if self.highLightBtnTable == nil then
        self.highLightBtnTable = {}
    end
    self:AddHightLightGo(self.highLightBtnTable, bagItemInfo)--添加根据条件显示的特效
    self.compareBagItemInfo = commonData.compareBagItemInfo
    self.mServantSeatType = nil
    ---@type boolean 若是灵兽的魂继,魂继的通灵状态,true表示魂继是否已通灵
    self.mHunJiTongLingState = nil
    if itemInfo then
        self.uiItemInfoPanel = uimanager:GetPanel("UIItemInfoPanel")
        self.uiPetInfoPanel = uimanager:GetPanel("UIPetInfoPanel")
        if (bagItemInfo == nil) then
            self.isEquiped = false;
        else
            if bagItemInfo.ItemTABLE ~= nil then
                if bagItemInfo.ItemTABLE.type == luaEnumItemType.HunJi then
                    self.isEquiped, self.mServantSeatType, self.mHunJiTongLingState = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiEquiped(bagItemInfo)
                elseif bagItemInfo.ItemTABLE.type == luaEnumItemType.Collection then
                    self.isEquiped = gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionDic()[bagItemInfo.lid] ~= nil
                    self.mServantSeatType = nil
                    self.mHunJiTongLingState = nil
                elseif clientTableManager.cfg_itemsManager:IsMagicEquip(bagItemInfo.itemId) then
                    self.isEquiped, self.mServantSeatType, self.mHunJiTongLingState = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():MagicEquipIsEquipped(bagItemInfo)
                else
                    self.isEquiped, self.mServantSeatType, self.mHunJiTongLingState = CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid);
                    if self.isEquiped ~= true then
                        self.isEquiped, self.mServantSeatType, self.mHunJiTongLingState = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsServantEquip(bagItemInfo)
                    end
                end
                if clientTableManager.cfg_itemsManager:IsDivineSuitEquip(bagItemInfo.itemId) then
                    self.isEquiped = bagItemInfo.index ~= 0
                end
            else
                self.isEquiped = false
            end
        end
        --self.isEquiped = ternary(bagItemInfo ~= nil, CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid), false)
        local allOperateTable, showNum = self:GetBtnTable(bagItemInfo, itemInfo)
        if self:GetBtns_UIGridContainer() ~= nil then
            local count = #allOperateTable;
            ---如果没有按钮列表就关闭激活
            self.go:SetActive(count > 0);
            if (count > 0) then
                self:GetBtns_UIGridContainer().MaxCount = count
                for i = 0, self:GetBtns_UIGridContainer().controlList.Count - 1 do
                    self:SetButton(self:GetBtns_UIGridContainer().controlList[i], allOperateTable[i + 1])
                end
                ---右上角按钮展开收起自适应
                if self:GetBtns_UIGridContainer().controlList.Count > showNum then
                    self.btnListOpenAndClose = templatemanager.GetNewTemplate(self:GetBtns_UIGridContainer(), luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList, { defaultShowBtnNum = showNum })
                else
                    if #allOperateTable > 0 then
                        self:BGSelfAdaptaion()
                        self:GetBackGround_GameObject():SetActive(true)
                    else
                        self:GetBackGround_GameObject():SetActive(false)
                    end
                    self:GetShowClose_GameObject():SetActive(false)
                end
            end
        end
    elseif (itemInfo ~= nil) then

    end
    --self:GetBtns_UIGridContainer().gameObject:SetActive(isMainPlayer);
    self.tipLevel = CS.Cfg_GlobalTableManagerBase.Instance[20180] == nil and 0 or tonumber(CS.Cfg_GlobalTableManagerBase.Instance[20180].value);
end

---获取需要显示的按钮列表
---@return 1.按钮列表，2.默认显示的按钮数量
function UIItemInfoPanel_Info_RightUpOperateButtons:GetBtnTable(bagItemInfo, itemInfo)
    ---过滤不需要显示的按钮
    local leftOperateTable = self:FilterOperate(CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemInfo.leftOperate), bagItemInfo, itemInfo)
    local rightOperateTable = self:FilterOperate(CS.Cfg_ItemsOperateTableManager.Instance:GetOperateList(itemInfo.rightOperate), bagItemInfo, itemInfo)
    local addBtn = self:AddExtendBtn(bagItemInfo, itemInfo)
    local allOperateTable = self:MergeOperateTable(rightOperateTable, leftOperateTable, addBtn)
    ---筛选需要默认显示的按钮
    return self:SortOperate(allOperateTable)
end

---背景图自适应
function UIItemInfoPanel_Info_RightUpOperateButtons:BGSelfAdaptaion()
    ---调整背景图的尺寸
    local bg_UISprite = self:GetBackGround_UISprite()
    local lastBtnUISprite = CS.Utility_Lua.GetComponent(self:GetBtns_UIGridContainer().controlList[self:GetBtns_UIGridContainer().controlList.Count - 1].transform:Find("backGround"), "UISprite")
    local singleBtn_Size = lastBtnUISprite.localSize
    local btnHeightIntervals = self:GetBtns_UIGridContainer().CellHeight - singleBtn_Size.y
    local bgHeight = self:GetBtns_UIGridContainer().controlList.Count * singleBtn_Size.y + (self:GetBtns_UIGridContainer().controlList.Count - 1) * btnHeightIntervals + self.BgHeight
    local bgWeight = singleBtn_Size.x + self.BgWeight
    bg_UISprite:SetDimensions(bgWeight, bgHeight)
    ---调整背景图的位置
    --local bgposition_y = lastBtnUISprite.transform.parent.localPosition.y * 0.5
    --local bgposition_x = lastBtnUISprite.transform.localPosition.x + -1 * (self.BgWeight / 2)
    --bg_UISprite.transform.localPosition = CS.UnityEngine.Vector3(bgposition_x, bgposition_y, 0)
end

---合并所有需要显示的按钮，优先右侧按钮
---@param rightOperateTable table
---@param leftOperateTable table
---@return table
function UIItemInfoPanel_Info_RightUpOperateButtons:MergeOperateTable(rightOperateTable, leftOperateTable, addBtn)
    local allOperateTable = {}
    self:AddTableItems(allOperateTable, rightOperateTable)
    self:AddTableItems(allOperateTable, leftOperateTable)
    self:AddTableItems(allOperateTable, addBtn)
    allOperateTable = self:SortAllOperate(allOperateTable)
    return allOperateTable
end

function UIItemInfoPanel_Info_RightUpOperateButtons:SortAllOperate(allOperateTable)
    if allOperateTable ~= nil and type(allOperateTable) == 'table' then
        local endBtn = nil
        for k, v in pairs(allOperateTable) do
            if v == LuaEnumItemOperateType.Destroy then
                endBtn = v
                table.remove(allOperateTable, k)
                break
            end
        end
        table.insert(allOperateTable, endBtn)
    end
    return allOperateTable
end

---添加数据
function UIItemInfoPanel_Info_RightUpOperateButtons:AddTableItems(aimTable, addTable)
    if addTable and #addTable > 0 then
        for i = 1, #addTable do
            table.insert(aimTable, addTable[i])
        end
    end
end

---过滤操作中不应显示的操作
---@param operate TABLE.IntListJingHao
---@param bagItemInfo bagV2.BagItemInfo | "背包物品信息"
---@param itemInfo TABLE.CFG_ITEMS | "物品信息类型"
---@return table
function UIItemInfoPanel_Info_RightUpOperateButtons:FilterOperate(operate, bagItemInfo, itemInfo)
    local operateTable = {}
    if operate ~= nil then
        local isInsertOperate = false;
        for i = 0, operate.list.Count - 1 do
            if (bagItemInfo ~= nil and bagItemInfo.lid ~= nil) then
                ---@type 物品信息界面物品操作类型
                local operationTemp = operate.list[i]
                if (CS.CSScene.MainPlayerInfo.BagInfo:HasItem(bagItemInfo)) then
                    isInsertOperate = true;
                    --region 自己背包或身上的物品
                    ---拆分操作,若物品数量为1,则不显示“拆分”按钮

                    ---不显示兵鉴卸下按钮
                    if operationTemp == LuaEnumItemOperateType.Equip then
                        if self.isEquiped then
                            if gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsSLBingJian(bagItemInfo.itemId) then
                                isInsertOperate = false
                            end
                        end
                    end

                    if operationTemp == LuaEnumItemOperateType.Split then
                        if (bagItemInfo.count == 1) then
                            isInsertOperate = false
                        end
                    end

                    ---丢弃操作,若物品在身上,则不显示“丢弃”按钮
                    if operationTemp == LuaEnumItemOperateType.Discard then
                        if (self.isEquiped) then
                            isInsertOperate = false
                        end
                    end

                    ---销毁操作,若物品在身上,则不显示“销毁”按钮
                    if operationTemp == LuaEnumItemOperateType.Destroy then
                        if (self.isEquiped) then
                            isInsertOperate = false
                        end
                    end

                    ---装备操作,若已装备且处于已通灵状态,则不显示通灵按钮
                    if operationTemp == LuaEnumItemOperateType.HunJiTongLing then
                        if self.isEquiped and self.mHunJiTongLingState then
                            isInsertOperate = false
                        end
                    end

                    ---维修，如果耐久度满的则不显示
                    if operationTemp == LuaEnumItemOperateType.Repair then
                        if bagItemInfo.currentLasting >= itemInfo.maxLasting or bagItemInfo.currentLasting > CS.Cfg_GlobalTableManager.Instance:GetLastingLessValue() then
                            isInsertOperate = false
                        end
                    end

                    ---进化, 如果需求条件不足不显示
                    if operationTemp == LuaEnumItemOperateType.Evolution then
                        isInsertOperate = CS.Cfg_NavigationTableManager.Instance:IsOpen(luaEnumNavigationType.Evolution) and clientTableManager.cfg_synthesisManager:IsCanSynthesis(itemInfo.id);
                    end

                    ---锻造，如果需求条件不足不显示
                    if operationTemp == LuaEnumItemOperateType.Forge then
                        if CS.CSServantInfoV2.IsServantEquip(itemInfo.subType) then
                            isInsertOperate = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsOpenServantStrength()
                        else
                            isInsertOperate = CS.CSScene.MainPlayerInfo.BagInfo:CanItemStrength(bagItemInfo)
                        end
                    end

                    ---日常任务物品出售
                    if operationTemp == LuaEnumItemOperateType.DailyTaskItemSell then
                        if CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance.DailyTaskItemSellLimit then
                            isInsertOperate = false
                        end
                    end

                    ---日常任务物品使用
                    if operationTemp == LuaEnumItemOperateType.DailyTaskItemUse then
                        if CS.CSScene.MainPlayerInfo.Level < CS.Cfg_GlobalTableManager.Instance.DailyTaskItemUseLimit then
                            isInsertOperate = false
                        end
                    end

                    if operationTemp == LuaEnumItemOperateType.HunJiTongLing then
                        isInsertOperate = false;
                    end
                    --endregion
                else
                    if self.isEquiped and bagItemInfo.ItemTABLE ~= nil and bagItemInfo.ItemTABLE.type == luaEnumItemType.HunJi then
                        --region 若为灵兽魂继装备
                        isInsertOperate = true
                        if operationTemp == LuaEnumItemOperateType.HunJiTongLing then
                            if self.mHunJiTongLingState then
                                isInsertOperate = false
                            else
                                ---@type CSServantSeatData_MainPlayer
                                local seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.mServantSeatType)
                                if seatData ~= nil then
                                    local stateTemp = seatData.State
                                    if stateTemp == CS.CSServantSeatData.SeatState.Locked or stateTemp == CS.CSServantSeatData.SeatState.Recall then
                                        isInsertOperate = false
                                    end
                                else
                                    isInsertOperate = false
                                end
                            end
                        end

                        if operationTemp == LuaEnumItemOperateType.Combine then
                            ---魂继的合成,若该魂继装备已经装备在灵兽位上且对应的灵兽位处于召回状态,则不显示合成按钮
                            if self.isEquiped then
                                ---@type CSServantSeatData_MainPlayer
                                local seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.mServantSeatType)
                                if seatData ~= nil and seatData.State == CS.CSServantSeatData.SeatState.Recall then
                                    ---若装备所在的灵兽位已锁住,则不显示合成按钮
                                    isInsertOperate = false
                                end
                            end
                        end
                        --endregion
                    elseif clientTableManager.cfg_itemsManager:IsMagicEquip(itemInfo.id) then
                        isInsertOperate = true
                    elseif itemInfo.type == luaEnumItemType.Collection then
                        ---如果是藏品,如果是自己的藏品则显示操作按钮,否则不显示操作按钮
                        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionDic()[bagItemInfo.lid] ~= nil then
                            if operationTemp == LuaEnumItemOperateType.Collect then
                                isInsertOperate = true
                            elseif operationTemp == LuaEnumItemOperateType.Destroy then
                                isInsertOperate = false
                            end
                        else
                            isInsertOperate = false
                        end
                    else
                        isInsertOperate = false;
                        --region 非自己背包的物品

                        --endregion
                    end
                end
            else
                isInsertOperate = false;
                local operationTemp = operate.list[i]
                --region 非背包物品
                if operationTemp == LuaEnumItemOperateType.Gain then
                    isInsertOperate = true
                end
                --endregion
            end
            ---需要依情况过滤掉在Items表中配置的左右操作时,应在此处添加条件,将isInsertOperate置为false即可不显示该操作按钮
            if isInsertOperate then
                table.insert(operateTable, operate.list[i])
            end
        end
    end
    return operateTable
end

---对按钮进行排序（默认需要显示的排在最前面）
---@return 1.按钮列表，2.默认显示的按钮数量
function UIItemInfoPanel_Info_RightUpOperateButtons:SortOperate(operateTable)
    local defaultShowOperates = {}
    local defaultHideOperates = {}
    if operateTable ~= nil then
        ---第一个按钮默认显示
        table.insert(defaultShowOperates, operateTable[1])
        for k = 2, #operateTable do
            local operateId = operateTable[k]
            if operateId == LuaEnumItemOperateType.Repair and self.mBagItemInfo ~= nil and self.mBagItemInfo.currentLasting <= CS.Cfg_GlobalTableManager.Instance:GetLastingLessValue() and self.mBagItemInfo.currentLasting > -9999 then
                table.insert(defaultShowOperates, operateId)
            elseif operateId == LuaEnumItemOperateType.Blend and CS.CSScene.MainPlayerInfo.EquipInfo:IsCanBlendBodyMedalEquip(self.mBagItemInfo) then
                table.insert(defaultShowOperates, operateId)
            else
                table.insert(defaultHideOperates, operateId)
            end
        end
        return self:MergeOperateTable(defaultShowOperates, defaultHideOperates), #defaultShowOperates
    end
    return defaultShowOperates, 0
end

--region 按钮处理
---设置按钮名及点击事件
---@param buttonGO UnityEngine.GameObject | "按钮游戏物体"
---@param operateID XLua.Cast.Int32 | "按钮操作ID"
function UIItemInfoPanel_Info_RightUpOperateButtons:SetButton(buttonGO, operateID)
    ---@type UILabel
    local btnLabel = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("Label"), "UILabel")
    local btnRightPoint_GameObject = CS.Utility_Lua.GetComponent(buttonGO.transform:Find("redpoint"), "GameObject")
    btnLabel.text = self:GetOperateString(operateID)
    local isShowEffect = self:BtnNeedHighLight(operateID)
    btnRightPoint_GameObject:SetActive(isShowEffect)
    CS.UIEventListener.Get(buttonGO).LuaEventTable = self
    CS.UIEventListener.Get(buttonGO).OnClickLuaDelegate = self:GetOperateFunction(operateID)
end

---获取操作ID对应的字符串
---@param operateID XLua.Cast.Int32
function UIItemInfoPanel_Info_RightUpOperateButtons:GetOperateString(operateID)
    if operateID == LuaEnumItemOperateType.Cancel then
        return "取消"
    elseif operateID == LuaEnumItemOperateType.Discard then
        return "丢弃"
    elseif operateID == LuaEnumItemOperateType.Use then
        return "使用"
    elseif operateID == LuaEnumItemOperateType.Equip then
        --装备按钮需要考虑装备还是卸下
        return self:SetEquipInfo()
    elseif operateID == LuaEnumItemOperateType.Open then
        return "开启"
    elseif operateID == LuaEnumItemOperateType.Destroy then
        return "销毁"
    elseif operateID == LuaEnumItemOperateType.Split then
        return "拆分"
    elseif operateID == LuaEnumItemOperateType.Forge then
        return "锻造"
    elseif operateID == LuaEnumItemOperateType.Combine then
        return "合成"
    elseif operateID == LuaEnumItemOperateType.Gain then
        return "获取"
    elseif operateID == LuaEnumItemOperateType.Repair then
        return "修理"
    elseif operateID == LuaEnumItemOperateType.AuctionHouse then
        return "上架"
    elseif operateID == LuaEnumItemOperateType.Evolution then
        return "进化"
    elseif operateID == LuaEnumItemOperateType.Bundle then
        return "打捆"
    elseif operateID == LuaEnumItemOperateType.Auction then
        return "竞拍"
    elseif operateID == LuaEnumItemOperateType.Mosaic then
        return "镶嵌"
    elseif operateID == LuaEnumItemOperateType.MarryRing then
        return "婚戒操作"
    elseif operateID == LuaEnumItemOperateType.Blend then
        return "融合"
    elseif operateID == LuaEnumItemOperateType.DailyTaskItemUse then
        return "使用"
    elseif operateID == LuaEnumItemOperateType.DailyTaskItemSell then
        return "出售"
    elseif operateID == LuaEnumItemOperateType.HunJiTongLing then
        return "通灵"
    elseif operateID == LuaEnumItemOperateType.Refine then
        return "精炼"
    elseif operateID == LuaEnumItemOperateType.Semelt then
        return "熔炼"
    elseif operateID == LuaEnumItemOperateType.PromoteClass then
        return "升阶"
    elseif operateID == LuaEnumItemOperateType.AgainRefine then
        return "洗炼"
    elseif operateID == LuaEnumItemOperateType.Collect then
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionDic()[self.mBagItemInfo.lid] ~= nil then
            return "卸下"
        else
            return "收藏"
        end
    elseif operateID == LuaEnumItemOperateType.XianZhuangInlay then
        return "镶嵌"
    elseif operateID == LuaEnumItemOperateType.UpgradeMembership then
        return "前往获取"
    elseif operateID == LuaEnumItemOperateType.JianDing then
        return "鉴定"
    elseif operateID == LuaEnumItemOperateType.ShengJi then
        return "升级"
    elseif operateID == LuaEnumItemOperateType.TuPo then
        return "突破"
    end
    return ""
end

function UIItemInfoPanel_Info_RightUpOperateButtons:SetEquipInfo()
    if self.isEquiped then
        return "卸下"
    else
        ---未装备状态
        return "装备"
    end
end

function UIItemInfoPanel_Info_RightUpOperateButtons:SetCombineShowState(operateID)
    if operateID == LuaEnumItemOperateType.Combine then
        --local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mBagItemInfo.itemId)
        --if (isFind) and itemTable.compoundParam ~= nil and itemTable.compoundParam.list.Count > 1 then
        --    local needCount = itemTable.compoundParam.list[1];
        --    if self.mBagItemInfo.count >= needCount or CS.CSScene.MainPlayerInfo.BagInfo:GetSameKindItemCount(itemTable) >= needCount then
        --        return true;
        --    end
        --end
        --return false;
        if (self.mBagItemInfo ~= nil) then
            return clientTableManager.cfg_synthesisManager:IsCanSynthesis(self.mBagItemInfo.itemId)
        end
    end
    return false;
end

---获取操作ID对应的操作方法
---@param operateID XLua.Cast.Int32
function UIItemInfoPanel_Info_RightUpOperateButtons:GetOperateFunction(operateID)
    if operateID == LuaEnumItemOperateType.Cancel then
        return self.OnButtonClicked_CancelOperate
    elseif operateID == LuaEnumItemOperateType.Discard then
        return self.OnButtonClicked_DiscardOperate
    elseif operateID == LuaEnumItemOperateType.Use then
        return self.OnButtonClicked_UseOperate
    elseif operateID == LuaEnumItemOperateType.Equip then
        return self.OnButtonClicked_EquipOperate
    elseif operateID == LuaEnumItemOperateType.Open then
        return self.OnButtonClicked_OpenOperate
    elseif operateID == LuaEnumItemOperateType.Destroy then
        return self.OnButtonClicked_DestroyOperate
    elseif operateID == LuaEnumItemOperateType.Split then
        return self.OnButtonClicked_SplitOperate
    elseif operateID == LuaEnumItemOperateType.Forge then
        return self.OnButtonClicked_ForgeOperate
    elseif operateID == LuaEnumItemOperateType.Combine then
        return self.OnButtonClicked_CombineOperate
    elseif operateID == LuaEnumItemOperateType.Gain then
        return self.OnButtonClicked_GainOperate
    elseif operateID == LuaEnumItemOperateType.Repair then
        return self.OnButtonClicked_RepairOperate
    elseif operateID == LuaEnumItemOperateType.AuctionHouse then
        return self.OnClickAuctionHouse
    elseif operateID == LuaEnumItemOperateType.Evolution then
        return self.OnClickBtnEvolution
    elseif operateID == LuaEnumItemOperateType.Bundle then
        return self.OnButtonClicked_BundleOperate
    elseif operateID == LuaEnumItemOperateType.Auction then
        return self.OnClickAuction
    elseif operateID == LuaEnumItemOperateType.Mosaic then
        return self.OnClickMosaic
    elseif operateID == LuaEnumItemOperateType.MarryRing then
        return self.OnClickMarryRingClick
    elseif operateID == LuaEnumItemOperateType.Blend then
        return self.OnClickBlendCLick
    elseif operateID == LuaEnumItemOperateType.DailyTaskItemUse then
        return self.OnClickDailyTaskItemUse
    elseif operateID == LuaEnumItemOperateType.DailyTaskItemSell then
        return self.OnClickDailyTaskItemSell
    elseif operateID == LuaEnumItemOperateType.HunJiTongLing then
        return self.OnButtonClicked_HunJiTongLing
    elseif operateID == LuaEnumItemOperateType.AddShelf then
    elseif operateID == LuaEnumItemOperateType.Refine then
        return self.OnButtonClicked_Refine
    elseif operateID == LuaEnumItemOperateType.Semelt then
        return self.OnButtonClicked_Semelt
    elseif operateID == LuaEnumItemOperateType.PromoteClass then
        return self.OnButtonClicked_CombineOperate
    elseif operateID == LuaEnumItemOperateType.Collect then
        return self.OnButtonClicked_CollectOperate
    elseif operateID == LuaEnumItemOperateType.AgainRefine then
        return self.OnButtonClicked_AgainRefine
    elseif operateID == LuaEnumItemOperateType.XianZhuangInlay then
        return self.OnButtonClicked_XianZhuangInlay
    elseif operateID == LuaEnumItemOperateType.UpgradeMembership then
        return self.OnButtonClicked_UpgradeMembership;
    elseif operateID == LuaEnumItemOperateType.JianDing then
        return self.OnButtonClicked_JianDing;
    elseif operateID == LuaEnumItemOperateType.ShengJi then
        return self.OnButtonClicked_ShengJi;
    elseif operateID == LuaEnumItemOperateType.TuPo then
        return self.OnButtonClicked_TuPo;
    end
end
--endregion

--region 按钮点击回调事件
---"更多"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_MoreOperate(go)
    local nextState = self:GetLeftGrids_UIGridContainer().gameObject.activeInHierarchy == false
    --显示子按钮
    self:GetLeftGrids_UIGridContainer().gameObject:SetActive(nextState)
    --箭头调转
    self:GetLeftArrowSign_GameObject().transform.localEulerAngles = ternary(nextState, CS.UnityEngine.Vector3(0, 0, 180), CS.UnityEngine.Vector3.zero)
end

---"取消"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_CancelOperate(go)
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---"丢弃"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_DiscardOperate(go)
    if (self.mBagItemInfo.bind == 1) then
        Utility.ShowPromptTipsPanel({ id = 68, Callback = function()
            networkRequest.ReqDiscardItem(self.mBagItemInfo.lid, self.mBagItemInfo.count)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        end })
    else
        networkRequest.ReqDiscardItem(self.mBagItemInfo.lid, self.mBagItemInfo.count)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
    end
end

---点击上架
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickAuctionHouse()
    ---@type AuctionPanelData
    local customData = {}
    customData.mNeedChooseBagItem = self.mBagItemInfo
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_UpperShelf, customData)
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    self:ControlBagGridHighLight(false)
end

---点击竞拍
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickAuction()
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Auction)
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    return
end

function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickBtnEvolution()
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    local customData = {};
    customData.bagItemInfo = self.mBagItemInfo;
    if self.mBagItemInfo.index == 0 then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Evolution_Bag, customData);
    else
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Evolution_Role, customData);
    end
end

---@param trans UnityEngine.GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(trans, str, id)
    local TipsInfo = {}
    if str ~= nil or str ~= '' then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.Parent] = trans.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---"使用"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_UseOperate(go)
    ---@type CSUnionInfoV2
    local UnionInfoV2 = CS.CSScene.MainPlayerInfo.UnionInfoV2
    --region 灵兽背包另外处理
    if self:IsServantBagUseItem(go) then
        return
    end
    --endregion

    --region 无法在安全区使用
    if CS.CSScene.MainPlayerInfo.InProtectArea and not CS.Cfg_GlobalTableManager.Instance:CanUseItemInProtectArea(self.mItemInfo.id) then
        UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 174)
        return
    end
    --endregion

    --region 使用次数限制
    if Utility.ItemUseCountOverLimit(self.mItemInfo.id) == true then
        UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 475)
        return
    end
    --endregion

    --region 检测玩家条件是否达到
    local mainPlayerCanUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(self.mItemInfo.id)
    ---使用等级不足
    if mainPlayerCanUseItem == LuaEnumUseItemParam.UseLvNotEnough then
        UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 48)
        if luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink) then
            luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink)
        end
        return
    end

    ---转生等级不足
    if mainPlayerCanUseItem == LuaEnumUseItemParam.UseReinLvNotEnough then
        UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 49)
        if luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink) then
            luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink)
        end
        return
    end

    ---检测配置的使用条件是否满足
    local configConditionResult = clientTableManager.cfg_itemsManager:CheckItemsConditions(self.mItemInfo.id)
    if configConditionResult ~= nil and configConditionResult.success == false then

        if (Utility.GetItemTblByBagItemInfo(self.mBagItemInfo):GetType() == 3 and Utility.GetItemTblByBagItemInfo(self.mBagItemInfo):GetSubType() == 4) then
            --经验丹
            local isFind, promptInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(480)
            if isFind then
                local showStr = string.format(promptInfo.content, configConditionResult.param)
                Utility.ShowPopoTips(go, showStr, 480, "UIPurchasePromptPanel")
            else
                Utility.ShowPopoTips(go.transform, configConditionResult.txt, 49)
            end
        else
            Utility.ShowPopoTips(go.transform, configConditionResult.txt, 49)
        end

        return
    end
    --endregion

    --region 塔罗牌
    if (self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == 11) then
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
    if self.mItemInfo.type == luaEnumItemType.Material and (self.mItemInfo.subType == luaEnumMaterialType.JinLan or self.mItemInfo.subType == luaEnumMaterialType.Rose) then
        self:UseFlowerCallBack()
        return
    end
    --endregion

    --region 悬赏令
    if self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == luaEnumMaterialType.rewardOrder then
        local mapNPCID = 91
        local isKuaFu = luaclass.RemoteHostDataClass:IsKuaFuMap()
        if isKuaFu then
            mapNPCID = 124
        end

        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ mapNPCID }, "UIArrestPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, { mapNPCID })
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
        return
    end
    --endregion

    --region 狂欢劵
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 31 then
        ---判断活动是否开始
        if not Utility.CheckSystemOpenState(51) then
            ---若限时活动未开启弹出气泡
            Utility.ShowPopoTips(go.transform, nil, 449, 'UIItemInfoPanel')
            return
        end

        if gameMgr:GetPlayerDataMgr() ~= nil then
            if not gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetActivityOpenState(8) then
                ---若狂欢商店未开启弹出气泡
                Utility.ShowPopoTips(go.transform, nil, 449, 'UIItemInfoPanel')
                return
            end
        end
    end
    --endregion

    --region 检查是否为打开界面
    if self:TryOpenPanel(LuaEnumItemOperateType.Use) then
        --特殊处理法阵直升券
        if self.mItemInfo.type == 8 and self.mItemInfo.subType == 51 then
            --不return，打开界面并且使用
        else
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
            return
        end
    end
    --endregion



    --region 检查是否为组队召唤类型
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 5 then
        local GroupInfoV2 = CS.CSScene.MainPlayerInfo.GroupInfoV2
        if (GroupInfoV2.GroupInfo == nil) then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 84)
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
        ---等级低于限制时,且地图未被屏蔽时需要二次弹窗判定是否使用召唤令
        local lid = self.mBagItemInfo.lid
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
    local lid = self.mBagItemInfo.lid
    --endregion

    --region 检查是否为转生直升卷轴类型
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 37 then
        if (self.mItemInfo.useParam ~= nil and self.mItemInfo.useParam.list.Count > 0 and self.mItemInfo.useParam.list[0] <= CS.CSScene.MainPlayerInfo.ReinLevel) then
            local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(471)
            if isfind then
                UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, string.format(data.content, self.mItemInfo.useParam.list[0]), 471)
            end
            return
        end
    end
    --region 检查是否为帮会召唤类型
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 6 then

        ---指定地图不能使用召唤令
        --if (CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(CS.CSScene.getMapID())) then
        --    UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 82)
        --    return
        --end
        ---未加入帮会
        if (UnionInfoV2.UnionID == 0) then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 82)
            return
        end
        ---职位不符
        if (UnionInfoV2.UnionInfo.unionInfo.leaderId ~= 0 and UnionInfoV2.UnionInfo.myPositionInfo < UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition) then
            local pos = uiStaticParameter.PosStringList[UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition]
            local str = pos .. "职位以上可使用"
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, str, 83)
            return
        end
        ---组队条件
        if luaclass.UnionDataInfo:TeamCanUseUnionSummonToken() == false then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 355)
            return
        end

        ---玩家在60级之前，在所有地图，主角当前不在战斗状态需二次确认
        if CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and CS.CSScene.MainPlayerInfo.InCombat == false then
            Utility.ShowSecondConfirmPanel({ PromptWordId = 111, CancelCallBack = function()
                networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.EServerMapObjectType.Null) })
            end })
            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
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
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        return
    end
    --endregion

    --region 是否为联盟召唤
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 30 then
        --region 是否加入联盟
        local isInLeague = gameMgr:GetPlayerDataMgr():GetLeagueInfo():IsMainPlayerInLeague();
        if (not isInLeague) then
            self.ShowTips(go.transform, nil, 418)
            return
        end
        --endregion

        --region 仅盟主和副盟主可使用
        local isBetterPost = gameMgr:GetPlayerDataMgr():GetLeagueInfo():MainPlayerPostIsBetterThenFuMengZhu()
        if isBetterPost == false then
            self.ShowTips(go.transform, nil, 419)
            return
        end
        --endregion

        --region 是否处于跨服地图
        local isInTargetMap = luaclass.RemoteHostDataClass:IsKuaFuMap();
        if (not isInTargetMap) then
            self.ShowTips(go.transform, nil, 424)
            return
        end
        --endregion
        networkRequest.ReqUseItem(1, lid, zhaohuanmonsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        return
    end

    --endregion

    --region Boss召唤令
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 3 then
        if (CS.CSScene.MainPlayerInfo.MapInfoV2:IsMainCityMap(CS.CSScene.MainPlayerInfo.MapID) == false) then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 433)
            return
        end
    end
    --endregion

    --region 元宝宝箱
    if self.mBagItemInfo and self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 32 then
        --聚灵珠当前存储的经验值存在luck中,最大经验值存在maxStar中
        if self.mBagItemInfo.luck < self.mBagItemInfo.maxStar then
            Utility.ShowPopoTips(go, "未满足开启条件", 290, "UIItemInfoPanel")
            return
        else
            networkRequest.ReqUseMoneyBox(self.mBagItemInfo.lid, self.mBagItemInfo.count)
            uimanager:ClosePanel("UIItemInfoPanel")
            return
        end
    end
    --endregion

    --region 聚灵珠
    if self.mBagItemInfo and self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 4 then
        --聚灵珠当前存储的经验值存在luck中,最大经验值存在maxStart中
        local gatheringBeadsInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetGatheringInfo(self.mItemInfo.id)
        if self.mBagItemInfo.luck < self.mBagItemInfo.maxStar then
            CS.Utility.ShowTips("经验尚未存满,不可领取", 1.5, CS.ColorType.Red)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        else
            if gatheringBeadsInfo and gatheringBeadsInfo.useCount and gatheringBeadsInfo.totalCount then
                if gatheringBeadsInfo.useCount < gatheringBeadsInfo.totalCount or gatheringBeadsInfo.totalCount == 0 then
                    Utility.TryOpenJLZPanel({ info = self.mItemInfo })
                    uimanager:ClosePanel("UIItemInfoPanel")
                    uimanager:ClosePanel("UIPetInfoPanel")
                    --uimanager:ClosePanel("UIBagPanel")
                else
                    Utility.ShowPopoTips(go.transform, nil, 101)
                end
            end
        end
        return
    end
    --endregion

    --region 红包类型需要在使用的同时打开红包界面
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 7 then
        if self.mBagItemInfo.count < 2 then
            --物品数量小于2时，直接请求使用该物品
            networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
            --uimanager:CreatePanel("UILuckyMoneyPanel")
        else
            --物品数量大于1时，根据批量使用类型使用
            if self.mItemInfo.batchusage == 1 then
                --若批量使用类型为弹出数量界面选择使用数量
                local part = self
                local useFunction = function(count)
                    networkRequest.ReqUseItem(count, part.mBagItemInfo.lid, 0)
                    --uimanager:CreatePanel("UILuckyMoneyPanel")
                end
                uimanager:CreatePanel("UIItemCountPanel", nil, {
                    Title = "使 用",
                    ItemInfo = self.mItemInfo,
                    CallBack = useFunction,
                    BeginningCount = 1,
                    MaxCount = self.mBagItemInfo.count
                })
            elseif self.mItemInfo.batchusage == 2 then
                --若批量使用类型为使用当前格子所有物品
                networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
                --uimanager:CreatePanel("UILuckyMoneyPanel")
            else
                --不批量使用
                networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
                --uimanager:CreatePanel("UILuckyMoneyPanel")
            end
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        return
    end
    --endregion

    --region 掠宝袋类型使用的时候打开掠宝袋界面
    if Utility.IsEquipBox(self.mItemInfo) then
        local bagData = {}
        bagData.name = self.mItemInfo.name
        bagData.bagItemInfo = self.mBagItemInfo
        uimanager:CreatePanel("UITreasureBagPanel", function()
            --uimanager:ClosePanel("UIBagPanel")
            networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
        end, bagData)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        return
    end
    --endregion

    --region 灵兽蛋
    if (self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 8) then
        local ServantInfoV2 = CS.CSScene.MainPlayerInfo.ServantInfoV2
        local servantList = ServantInfoV2.ServantInfoList
        local uiServantPanel = uimanager:GetPanel("UIServantPanel")
        if uiServantPanel ~= nil then
            ---当前打开了灵兽界面，则以选择的灵兽位进行装备灵兽
            local servantIndexIsUnLock = ServantInfoV2:ServantIndexIsOpen(uiStaticParameter.SelectedServantType)
            if servantIndexIsUnLock == false then
                UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 250)
                return
            end
            --networkRequest.ReqUseServantEgg(self.mBagItemInfo.lid, uiStaticParameter.SelectedServantType)
            networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
            uimanager:ClosePanel("UIPetInfoPanel")
            return
        else
            ---未打开灵兽界面，则根据副面板选择的对象进行上阵对应灵兽
            if self.mItemInfo ~= nil and self.mItemInfo.useParam.list.Count > 0 then
                local res, servantInfo = CS.Cfg_ServantTableManager.Instance.dic:TryGetValue(self.mItemInfo.useParam.list[0])
                if servantList.Count == 0 or (servantInfo ~= nil and servantInfo.type > servantList.Count and servantInfo.type ~= 4) then
                    UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 46)
                    return
                end

                ---达到配置等级则打开灵兽界面
                local index = ServantInfoV2:CheckReqUseServantEgg()
                if (index == 1) then
                    if (servantInfo.type == luaEnumServantType.HM) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                    elseif (servantInfo.type == luaEnumServantType.LX) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                    elseif (servantInfo.type == luaEnumServantType.TC) then
                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                    elseif (servantInfo.type == luaEnumServantType.COMMON) then
                        local pos = ServantInfoV2:GetBodyLowServantIndex()
                        if (pos == 1) then
                            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                        elseif (pos == 2) then
                            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                        elseif (pos == 3) then
                            uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC, { openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel });
                        end
                    end
                end

                ---灵兽上阵
                local servantIndex = 1
                if servantInfo ~= nil then
                    if servantInfo.type ~= luaEnumServantType.COMMON then
                        servantIndex = servantInfo.type
                    else
                        local emptyServantIndex = ServantInfoV2:GetEmptyServantPos()
                        if emptyServantIndex ~= 0 then
                            servantIndex = emptyServantIndex
                        else
                            if self.compareBagItemInfo ~= nil then
                                servantIndex = ServantInfoV2:GetServantIndexByServantBagItemInfo(self.compareBagItemInfo.lid)
                            end
                        end
                    end
                end

                networkRequest.ReqUseServantEgg(self.mBagItemInfo.lid, servantIndex)
                uimanager:ClosePanel("UIPetInfoPanel")
                return
            end
        end
    end
    --endregion

    --region 使用技能书
    local isNeed = CS.CSScene.MainPlayerInfo.SkillInfoV2:IsNeedStudySkill(self.mBagItemInfo);
    local isFind, tbl = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.mBagItemInfo.itemId)
    if (isFind and tbl.type == luaEnumItemType.SkillBook) then
        --先判断技能书是否本职业可用
        local mainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
        if not (tbl.career == mainPlayerCareer or tbl.career == LuaEnumCareer.Common) then
            Utility.ShowPopoTips(go.transform, nil, 394)
            return
        end

        --低级技能书不能升级高级技能c
        if tbl.subType == 0 and tbl.useParam ~= nil and tbl.useParam.list ~= nil and tbl.useParam.list.Count > 1 then
            local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(tbl.useParam.list[0])
            if skillDetailedInfo ~= nil and skillDetailedInfo.IsHighSkill == true then
                Utility.ShowPopoTips(go.transform, nil, 390)
                return
            end
        end
        --高技能书不能升级低级技能
        if tbl.subType == 2 and tbl.useParam ~= nil and tbl.useParam.list ~= nil and tbl.useParam.list.Count > 1 then
            local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(tbl.useParam.list[0])
            if skillDetailedInfo == nil or skillDetailedInfo.IsHighSkill == false then
                Utility.ShowPopoTips(go.transform, nil, 392)
                return
            end
        end
        --强化技能技能书使用限制
        if tbl.subType == 5 and tbl.useParam ~= nil and tbl.useParam.list ~= nil and tbl.useParam.list.Count > 1 and gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic ~= nil then
            ---@type LuaSkillDetailedInfo
            local isCanUse = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsCanUseIntensifySkillBook(tbl.useParam.list[0], tbl.id)
            if isCanUse == false then
                Utility.ShowPopoTips(go.transform, "技能等级不符", 392)
                return
            end
        end
        if tbl.career == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) and uimanager:GetPanel("UISkillPanel") == nil and isNeed then
            local skillId = tbl.useParam.list[0];
            local isGetValue, tblValue = CS.Cfg_SkillTableManager.Instance:TryGetValue(skillId);
            if (isGetValue) then
                if (tblValue.cls == 0 or tblValue.cls == 4) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.SkillDetails);
                elseif (tblValue.cls == 3) then
                    uiTransferManager:TransferToPanel(LuaEnumTransferType.HeartSkill);
                end
                uimanager:ClosePanel("UIItemInfoPanel")
                uimanager:ClosePanel("UIPetInfoPanel")
                return ;
            end
        end
    end
    --end
    --endregion

    --region 圣域斩杀令（圣域斩杀令需特殊处理，打开二次确认面板）
    if self.mItemInfo.id == 6090005 then
        Utility.ShowSecondConfirmPanel({ PromptWordId = 56, ComfireAucion = function()
            if self.mItemInfo.useParam.list.Count >= 2 then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(self.mItemInfo.useParam.list[1])
                uimanager:ClosePanel("UIBagPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            end
        end })
        return
    end
    --endregion

    --region 个人押镖材料
    if CS.Cfg_PersonDartCarTableManager.Instance:IsPersonDartCarConsume(self.mItemInfo.id) then
        local npcId = CS.Cfg_PersonDartCarTableManager.Instance:GetNpcIdByItemId(self.mItemInfo.id)
        if npcId ~= 0 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ npcId }, "UIIndividEscortPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, npcId)
            uimanager:ClosePanel("UIBagPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
            return
        end
    end
    --endregion

    --region 地图通行证
    if self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == luaEnumMaterialType.MapPassCheck then
        if self.mItemInfo.useParam ~= nil and self.mItemInfo.useParam.list.Count > 0 then
            local isFind, propmtWortId = CS.Cfg_GlobalTableManager.Instance:TryGetItemPromptWordId(self.mItemInfo.id);
            if (isFind) then
                Utility.ShowSecondConfirmPanel({ PromptWordId = propmtWortId, ComfireAucion = function()
                    if self.mItemInfo.useParam.list.Count >= 2 then
                        local extraData
                        if self.mItemInfo.id == 6090001 then
                            extraData = 9304
                        end
                        CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(self.mItemInfo.useParam.list[1], nil, extraData)
                        uimanager:ClosePanel("UIBagPanel")
                        uimanager:ClosePanel("UIItemInfoPanel")
                    end
                end })
            else
                local customData = {};
                customData.mItemInfo = self.mItemInfo;
                uimanager:CreatePanel("UIUsePassCheckPanel", nil, customData)
                uimanager:ClosePanel("UIItemInfoPanel");
            end
            return
        end
        return ;
    end
    --endregion

    --region 使用烟花
    if self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == luaEnumMaterialType.Firework then
        if CS.CSScene.MainPlayerInfo.DuplicateV2 ~= nil then
            self:UseFireworkCallBack(self.mBagItemInfo.lid, go)
        end
        return
    end
    --endregion

    --region 烟花之地
    if self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == luaEnumMaterialType.LandOfFireworks then
        if self.mItemInfo.useParam and self.mItemInfo.useParam.list and self.mItemInfo.useParam.list.Count >= 2 then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPassCheckUsedToFindNPCOperation:DoOperation(self.mItemInfo.useParam.list[1], nil)
            uimanager:ClosePanel("UIBagPanel")
            uimanager:ClosePanel("UIItemInfoPanel")
        end
        return
    end
    --endregion

    --region 灵兽复活药
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 19 then
        --local isExist, servantType, bagItemLID = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetDefaultReliveServantType()
        --if isExist then
        networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
        --end
        uimanager:ClosePanel("UIItemInfoPanel")
        return
    end
    --endregion

    --region 沃玛号角
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 21 then
        uimanager:CreatePanel("UICreateGuildPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        return
    end
    --endregion

    --region 祝福油、诅咒油
    if self.mItemInfo.type == luaEnumItemType.Assist and (self.mItemInfo.subType == 9 or self.mItemInfo.subType == 10) then
        local isFind, value = CS.Cfg_GlobalTableManager.Instance.allOilAndEquipIndexDic:TryGetValue(self.mItemInfo.id)
        if not isFind then
            return
        end
        local info = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(value)
        if info then
            local temp = {}
            temp.equipInfo = info
            temp.bagItemInfo = self.mBagItemInfo
            temp.equipIndex = value
            uimanager:CreatePanel("UIZhuFuYouPanel", nil, temp)
            uimanager:ClosePanel("UIItemInfoPanel")
        else
            Utility.ShowPopoTips(go.transform, nil, self.mItemInfo.subType == 9 and 240 or 241)
        end
        return
    end
    --endregion

    --region 间谍牌
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 16 then
        Utility.TrySetSpySnapItemInfoGrid({ lid = self.mBagItemInfo.lid, itemId = self.mBagItemInfo.itemId, icon = self.mItemInfo.icon, go = go })
        uimanager:ClosePanel("UIItemInfoPanel")
        return
    end
    --endregion

    --region 行会红包
    if Utility.IsUnionRedPack(self.mItemInfo) and UnionInfoV2 then
        local UnionId = UnionInfoV2.UnionID
        if UnionId == 0 then
            Utility.ShowPopoTips(go, nil, 307)
        else
            local customData = {}
            customData.BagItemInfo = self.mBagItemInfo
            ---@type UIPersonSendRedPackCouponPanelTemplate
            customData.Template = luaComponentTemplates.UIPersonSendRedPackCouponPanelTemplate
            uimanager:CreatePanel("UIGuildSendRedPackPanel", nil, customData)
            uimanager:ClosePanel("UIItemInfoPanel")
        end
        return
    end
    --endregion

    --region 自选宝箱
    if Utility.TryCreateOptionalList({ bagItemInfo = self.mBagItemInfo }) == true then
        uimanager:ClosePanel("UIItemInfoPanel")
        return
    end
    --endregion

    --region 魔法神石
    if CS.CSScene.MainPlayerInfo.MagicCircleInfo:IsMagicBallItem(self.mItemInfo.id) == true then
        local unionId = UnionInfoV2.UnionID
        if unionId == 0 then
            Utility.ShowPopoTips(go, nil, 302)
        else
            Utility.CreateItemUsePanel({ itemInfo = self.mItemInfo })
            uimanager:ClosePanel("UIItemInfoPanel")
        end
        return
    end
    --endregion

    --region 黄金/白银宝箱
    if Utility.IsSpecialEquipBoxKey(self.mItemInfo) then
        local boxId = Utility.GetSpecialKeyBoxInfo(self.mItemInfo.id)
        local boxItemInfoIsFind, boxItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(boxId)
        local haveBox = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(boxId)

        if not Utility.CanUseSpecialEquipBox(self.mItemInfo) then
            Utility.ShowPopoTips(go, nil, 344)
            return
        end

        local res = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(self.mItemInfo.id)
        if res == LuaEnumUseItemParam.UseLvNotEnough then
            Utility.ShowPopoTips(go, "人物等级不足", 48)
        elseif res == LuaEnumUseItemParam.UseReinLvNotEnough then
            Utility.ShowPopoTips(go, "人物转生等级不足", 48)
        elseif haveBox == false and boxItemInfoIsFind == true then
            Utility.ShowPopoTips(go, "没有" .. boxItemInfo.name, 48)
        else
            local bagData = {}
            bagData.name = self.mItemInfo.name
            bagData.bagItemInfo = self.mBagItemInfo
            uimanager:CreatePanel("UISpecialTreasureBagPanel", nil, bagData)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        end
        return
    end
    --endregion

    --region 使用腕力药水
    if self.mItemInfo.type == luaEnumItemType.Drug and self.mItemInfo.subType == 6 then
        if Utility.IsWristStrengthBoundMax() then
            Utility.ShowPopoTips(go, nil, 399)
            return
        end
    end
    --endregion

    --region 使用精力药水
    if self.mItemInfo.type == luaEnumItemType.Drug and self.mItemInfo.subType == 7 then
        if Utility.IsEnergyBoundMax() then
            Utility.ShowPopoTips(go, nil, 400)
            return
        end
    end
    --endregion

    --region 使用献祭之油
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 28 and
            self.mItemInfo.useParam ~= nil and self.mItemInfo.useParam.list ~= nil and self.mItemInfo.useParam.list.Count > 0 then
        Utility.ShowPromptTipsPanel({ id = 147, Callback = function()
            ---是否开启了联服
            local isKuaFuOpen = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
            if not isKuaFuOpen then
                Utility.ShowPopoTips(go, nil, 442)
            else
                luaclass.FindPath:FindPath_DeliverId(self.mItemInfo.useParam.list[0])
                uimanager:ClosePanel("UIBagPanel")
                uimanager:ClosePanel("UIItemInfoPanel")
            end
        end })
        return
    end
    --endregion

    --region 精炼石
    if gameMgr:GetPlayerDataMgr().GetMainPlayerRefineMgr ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerRefineMgr():IsRefineStone(self.mItemInfo.id) then
        if self.mBagItemInfo == nil or self.mItemInfo == nil then
            return
        end
        uimanager:ClosePanel("UIBagPanel")
        uimanager:ClosePanel("UIItemInfoPanel")
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Refine, { bagItemInfo = self.mBagItemInfo })
        return
    end
    --endregion

    --region 白日门押镖材料
    if gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():IsBaiRiMenDartCarMaterial(self.mItemInfo.id) then
        if self.mBagItemInfo == nil or self.mItemInfo == nil then
            return
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        Utility.ShowSecondConfirmPanel({ PromptWordId = 150, ComfireAucion = function()
            uimanager:ClosePanel("UIBagPanel")
            uimanager:CreatePanel("UIWhiteSunGatePanel", nil, { type = LuaEnumBaiRiMenActivityType.HuoYun })
        end })
    end
    --endregion

    --region 随身仓库
    if self.mItemInfo ~= nil and clientTableManager.cfg_itemsManager:IsStorage(self.mItemInfo.id) then
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:CreatePanel("UIPlayerWarehousePanel")
    end
    --endregion

    --region 扩容石
    if self.mItemInfo.type == luaEnumItemType.Material and self.mItemInfo.subType == 47 then
        local warehouseItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(8350001)
        if warehouseItemCount > 0 then
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:CreatePanel("UIPlayerWarehousePanel")
        else
            CS.Cfg_DeliverTableManager.Instance:TryTransferByDeliverId(1012, function()
                uimanager:ClosePanel("UIItemInfoPanel")
                uimanager:CreatePanel("UIPlayerWarehousePanel")
            end)
        end
    end
    --endregion

    --region 聚宝盆
    if self.mItemInfo.type == luaEnumItemType.Assist and self.mItemInfo.subType == 36 then
        local state = Utility.IsPlayerAutoPickOpen()
        if state == 1 or state == 2 then
            Utility.ShowPopoTips(go, nil, 470)
            return
        end
    end
    --endregion

    --region 需要打开二次确认面板的物品(策划配置)
    local promptWordId = LuaGlobalTableDeal.ItemNeedOpenSecondConfirmPanel(self.mItemInfo.id)
    if type(promptWordId) == 'number' then
        uimanager:ClosePanel("UIItemInfoPanel")
        Utility.ShowSecondConfirmPanel({ PromptWordId = promptWordId, ComfireAucion = function()
            networkRequest.ReqUseItem(1, self.mBagItemInfo.lid)
        end })
        return
    end
    --endregion

    ---闯关令使用
    if self.mItemInfo.id == 6280001 then
        uimanager:ClosePanel("UIItemInfoPanel")
        local deliverID = CS.Cfg_GlobalTableManager.Instance.TowerDeliverId;
        Utility.TryTransfer(deliverID, false);
        return
    end

    ---青铜会员卡使用
    if self.mItemInfo.type == 8 and self.mItemInfo.subType == 45 or self.mItemInfo.id == 5830001 then
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:CreatePanel("UIRechargeMemberPanel")
    end

    ---黄金锄头使用
    if self.mItemInfo.id == 8500002 then
        local isShow = gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetActive()
        if isShow == false then
            CS.Utility.ShowTips("活动未开启")
            return
        end
    end

    ---自动回收卡使用
    if self.mItemInfo.type == 8 and self.mItemInfo.subType == 46 then
        CS.CSListUpdateMgr.Add(100, nil, function()
            if LuaGlobalTableDeal:IsShowQuickRecycle() == false then
                Utility.OpenRecycleHint()
                return
            end
            luaEventManager.DoCallback(LuaCEvent.Bag_AutoRecycleUse);
        end)
    end

    --region 正常打开

    ---是否有晕眩buff
    if (CS.CSScene.MainPlayerInfo.BuffInfo:HasBuff(4)) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end

    if self.mBagItemInfo.count < 2 then
        --物品数量小于2时，直接请求使用该物品
        networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
    else
        --物品数量大于1时，根据批量使用类型使用
        if self.mItemInfo.batchusage == 1 then
            --若批量使用类型为弹出数量界面选择使用数量
            local part = self
            local useFunction = function(count)
                networkRequest.ReqUseItem(count, part.mBagItemInfo.lid, 0)
            end
            uimanager:CreatePanel("UIItemCountPanel", nil, {
                Title = "使 用",
                ItemInfo = self.mItemInfo,
                CallBack = useFunction,
                BeginningCount = 1,
                MaxCount = self.mBagItemInfo.count
            })
        elseif self.mItemInfo.batchusage == 2 then
            --若批量使用类型为使用当前格子所有物品
            networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
        else
            --不批量使用
            networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
        end
    end
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    --endregion
end

---"装备"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_EquipOperate(go)

    ---@type TABLE.cfg_items
    local luaItemInfo
    if self.mBagItemInfo then
        luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.mBagItemInfo.itemId)
    end

    --region 魂继装备
    if self.mBagItemInfo ~= nil and self.mBagItemInfo.ItemTABLE ~= nil and self.mBagItemInfo.ItemTABLE.type == luaEnumItemType.HunJi then
        ---请求装备魂继装备
        self:DoEquipServantHunJiEquip(self.mBagItemInfo, go)
        return
    end
    --endregion

    --region 灵兽背包另外处理
    if self:IsServantBagUseItem(go) then
        return
    end
    --endregion
    --装备操作需要考虑物品是否已被装备,若已被装备,则发送卸下指令
    if self.isEquiped then
        if self.mBagItemInfo ~= nil then
            ---灵兽秘宝无法手动脱下
            --if (self.mBagItemInfo.index == Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA)) then
            --    Utility.ShowPopoTips(go.transform, "此装备无法卸下", 249, "UIDisposeItemPanel");
            --    return ;
            if clientTableManager.cfg_itemsManager:IsMagicEquip(self.mBagItemInfo.itemId) then
                ---法宝手动卸下
                local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(self.mBagItemInfo.itemId)
                if equipIndex ~= nil and type(equipIndex) == 'number' and equipIndex > 0 then
                    networkRequest.ReqPutOffTheEquip(equipIndex)
                end
            else
                networkRequest.ReqPutOffTheEquip(self.mBagItemInfo.index)

            end
        end
    else
        --region 特殊处理灵兽可以使用的装备,此时将根据 灵兽界面是否打开/角色界面是否打开/当前选中的是哪个页签 来综合考虑穿戴在哪个装备位上或者提示什么信息
        if self.mBagItemInfo ~= nil and self.mBagItemInfo.ItemTABLE ~= nil
                and CS.CSServantInfoV2.IsRoleEquipAvailableForServant(self.mBagItemInfo.ItemTABLE) then
            local rolePanel = uimanager:GetPanel("UIRolePanel")
            if rolePanel then
                ---角色界面已经打开的情况下,不考虑其他的,将装备直接穿戴在角色身上,将逻辑交给后面执行
            else
                ---未打开角色界面时
                ---@type number 当前选中的灵兽位,1->寒芒,2->落星,3->天成,为0的话表示选择角色作为装备的穿戴对象
                local selectedServantIndex = 0
                selectedServantIndex = 0
                ---@type UIServantPanel
                local servantPanel = uimanager:GetPanel("UIServantPanel")
                if servantPanel then
                    --灵兽界面打开了的情况下,选择当前灵兽界面选择的灵兽位
                    selectedServantIndex = servantPanel:GetSelectIndex() + 1
                else
                    local arrowType = Utility.GetArrowType(self.mBagItemInfo)
                    --print("selectedServantIndex", arrowType)
                    if arrowType == LuaEnumArrowType.NONE then
                        selectedServantIndex = 0
                    else
                        ---灵兽界面不存在时,考虑下是否比角色装备中最差的装备更好
                        ---获取角色装备位中最差的一个装备位
                        local lowestEquipIndex = CS.CSScene.MainPlayerInfo.BagInfo:GetUseEquipIndex(self.mBagItemInfo)
                        ---@type bagV2.BagItemInfo
                        local currentEquippedBagItem
                        ___, currentEquippedBagItem = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(lowestEquipIndex)
                        if (currentEquippedBagItem ~= nil and CS.CSScene.MainPlayerInfo.EquipInfo:EquipBaseAttributeCompare(currentEquippedBagItem, self.mBagItemInfo) >= 0) then
                            ---如果角色装备位上最差的装备位上的装备不为空且比当前处理的装备好,那么考虑装备到灵兽身上
                            selectedServantIndex = Utility.GetEquipTargetType(self.mBagItemInfo)
                            --print("selectedServantIndex b")
                        else
                            ---如果角色身上有可以装备的装备位,则选择角色,走之前的逻辑
                            selectedServantIndex = 0
                            --print("selectedServantIndex c")
                        end
                    end
                end
                --print("selectedServantIndex", selectedServantIndex)
                if selectedServantIndex == 0 then
                    ---如果未选择灵兽位,则应将装备穿戴在角色身上,将逻辑交给后面逻辑执行
                else
                    ---如果选择了一个灵兽位,则尝试将装备穿戴在角色身上
                    ---角色装备如果不能用于灵兽身上,则不请求并弹出气泡
                    local mainPlayerServantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2
                    ---@type CSServantSeatData_MainPlayer
                    local mainPlayerServantSeatData = mainPlayerServantInfo.MainPlayerServantData:GetServantSeatData(selectedServantIndex)
                    if mainPlayerServantSeatData then
                        local res = clientTableManager.cfg_itemsManager:CanUseItem(self.mBagItemInfo.itemId, mainPlayerServantSeatData.Level, mainPlayerServantSeatData.ReinLevel)
                        local servantIndexCanUseRoleEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(selectedServantIndex)
                        if res == LuaEnumUseItemParam.CanUse and servantIndexCanUseRoleEquip == true then
                            ---获取推荐的灵兽位,尝试装备在灵兽位上
                            local recommendedIndex = mainPlayerServantInfo:GetRecommendedEquipIndexForRoleEquip(self.mBagItemInfo.ItemTABLE, selectedServantIndex)
                            if recommendedIndex and recommendedIndex ~= 0 then
                                networkRequest.ReqPutOnTheEquip(recommendedIndex, self.mBagItemInfo.lid)
                                uimanager:ClosePanel("UIItemInfoPanel")
                                ---只打开背包的情况下，如果直接给灵兽穿戴装备，需要同时灵兽界面+背包，并且灵兽需要定位到穿戴装备的灵兽
                                if servantPanel == nil or rolePanel == nil then
                                    if selectedServantIndex == LuaEnumEquipTargetType.Servant_1 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_HM)
                                    elseif selectedServantIndex == LuaEnumEquipTargetType.Servant_2 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_LX)
                                    elseif selectedServantIndex == LuaEnumEquipTargetType.Servant_3 then
                                        uiTransferManager:TransferToPanel(LuaEnumTransferType.Servant_Base_TC)
                                    end
                                end
                                return
                            end
                        elseif servantIndexCanUseRoleEquip == false then
                            Utility.ShowPopoTips(go, nil, 448, "UIItemInfoPanel")
                            return
                        elseif res == LuaEnumUseItemParam.UseReinLvNotEnough then
                            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIItemInfoPanel")
                            return
                        elseif res == LuaEnumUseItemParam.UseLvNotEnough then
                            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIItemInfoPanel")
                            return
                        end
                    end
                end
            end
        end
        --endregion

        --region 检查装备所需职业
        if not (self.mItemInfo.career == LuaEnumCareer.Common or self.mItemInfo.career == Utility.EnumToInt(CS.CSScene.Sington.MainPlayer.Info.Career)) then
            CS.Utility.ShowTips("装备所需职业不符")
            return
        end
        --endregion

        --region 检测玩家条件是否达到
        local mainPlayerCanUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(self.mItemInfo.id)
        ---使用等级不足
        if mainPlayerCanUseItem == LuaEnumUseItemParam.UseLvNotEnough then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 48)
            if luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink) then
                luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink)
            end
            return
        end

        ---转生等级不足
        if mainPlayerCanUseItem == LuaEnumUseItemParam.UseReinLvNotEnough then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 49)
            if luaEventManager.HasCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink) then
                luaEventManager.DoCallback(LuaCEvent.ItemInfoPanel_UseBtnClickBlink)
            end
            return
        end
        --endregion


        --region 检查装备所需性别
        if not (self.mItemInfo.sex == LuaEnumSex.Common or self.mItemInfo.sex == Utility.EnumToInt(CS.CSScene.Sington.MainPlayer.Info.Sex)) then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 106)
            return
        end

        --region 宝物
        if Utility.IsCanEquippedGem(self.mItemInfo, go.transform) == false then
            return
        end
        --endregion

        --region 法宝
        if self.mBagItemInfo ~= nil and self.mBagItemInfo.ItemTABLE ~= nil and clientTableManager.cfg_itemsManager:IsMagicEquip(self.mBagItemInfo.itemId) then
            self:DoEquipMagicEquip(self.mBagItemInfo, go)
            return
        end
        --endregion

        --region 神力装备
        if self.mBagItemInfo ~= nil and clientTableManager.cfg_itemsManager:IsDivineSuitEquip(self.mBagItemInfo.itemId) then
            self:DoDivineEquip(self.mBagItemInfo, go)
            return
        end
        --endregion

        ---官印暂时特殊处理，直接发请求包（不需要判断性别职业等）
        if (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_SEAL) then
            local info = clientTableManager.cfg_itemsManager:TryGetValue(self.mBagItemInfo.itemId)
            if (info ~= nil) then
                local isOpen = uimanager:IsOpenWithKey(info:GetConditions().list[1]);
                if (isOpen) then
                    self:ReqEquipItem(self.mBagItemInfo)
                else
                    self.ShowTips(go, nil, 456)
                    return
                end
            end
            ---马牌
        elseif (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_MaPai) then
            self:ReqEquipItem(self.mBagItemInfo)
            --- 暗器
        elseif (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_AnQi) then
            self:ReqEquipItem(self.mBagItemInfo)
        elseif (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_LeftWeapon) then
            self:ReqEquipItem(self.mBagItemInfo)
        elseif (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.POS_DouLi) then
            self:ReqEquipItem(self.mBagItemInfo)
        elseif (self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.MainSignet
                or self.mBagItemInfo.ItemTABLE.subType == LuaEquipmentItemType.SubSignet) then
            self:ReqEquipItem(self.mBagItemInfo)
        elseif clientTableManager.cfg_itemsManager:IsZhenFaEquip(self.mItemInfo.id) then
            local useItemParam = Utility.FaZhenEquipCanEquiped(self.mItemInfo.id)
            if useItemParam == LuaEnumUseItemParam.FaZhenEquipIndexIsLock then
                self.ShowTips(go, "装备位未解锁", 456)
                return
            end
            local conditionResult = Utility.FaZhenUseParamCondition(self.mItemInfo.id)
            if conditionResult.success == false then
                self.ShowTips(go, conditionResult.txt, 456)
                return
            end
            Utility.ReqEquipItem(self.mBagItemInfo)
        else
            CS.CSScene.MainPlayerInfo.BagInfo:ReqEquipItem(self.mBagItemInfo)
        end
        gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():CheckRoleNeedPushTransferItem(self.mBagItemInfo)
    end

    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

function UIItemInfoPanel_Info_RightUpOperateButtons:ReqEquipItem(BagItemInfo)
    networkRequest.ReqPutOnTheEquip(BagItemInfo.ItemTABLE.subType, BagItemInfo.lid)
end

---"开启"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_OpenOperate(go)

    --region 黄金/白银宝箱
    if Utility.IsSpecialEquipBox(self.mItemInfo) then
        if not Utility.CanUseSpecialEquipBox(self.mItemInfo) then
            Utility.ShowPopoTips(go, nil, 344)
            return
        end

        local res = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(self.mItemInfo.id)
        if res == LuaEnumUseItemParam.UseLvNotEnough then
            Utility.ShowPopoTips(go, "人物等级不足", 48)
        elseif res == LuaEnumUseItemParam.UseReinLvNotEnough then
            Utility.ShowPopoTips(go, "人物转生等级不足", 48)
        else
            local bagData = {}
            bagData.name = self.mItemInfo.name
            bagData.bagItemInfo = self.mBagItemInfo
            uimanager:CreatePanel("UISpecialTreasureBagPanel", nil, bagData)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        end
        return
    end
    --endregion

    --开启按钮也需要考虑批量使用数量
    --region 正常打开
    if self.mBagItemInfo.count < 2 then
        --物品数量小于2时，直接请求使用该物品
        networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
    else
        --物品数量大于1时，根据批量使用类型使用
        if self.mItemInfo.batchusage == 1 then
            --若批量使用类型为弹出数量界面选择使用数量
            local part = self
            local useFunction = function(count)
                networkRequest.ReqUseItem(count, part.mBagItemInfo.lid, 0)
            end
            uimanager:CreatePanel("UIItemCountPanel", nil, {
                Title = "开启",
                ItemInfo = self.mItemInfo,
                CallBack = useFunction,
                BeginningCount = 1,
                MaxCount = self.mBagItemInfo.count
            })
        elseif self.mItemInfo.batchusage == 2 then
            --若批量使用类型为使用当前格子所有物品
            networkRequest.ReqUseItem(self.mBagItemInfo.count, self.mBagItemInfo.lid, 0)
        else
            --不批量使用
            networkRequest.ReqUseItem(1, self.mBagItemInfo.lid, 0)
        end
    end
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    --endregion
end

---"销毁"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_DestroyOperate(go)
    Utility.ShowPromptTipsPanel({ id = 68, Callback = function()
        networkRequest.ReqDestruction(self.mBagItemInfo.lid)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
    end })
end

---"拆分"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_SplitOperate(go)
    local part = self
    local splitFunction = function(count)
        if count and part then
            networkRequest.ReqItemApart(part.mBagItemInfo.lid, count)
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
    end
    uimanager:CreatePanel("UIItemCountPanel", nil, {
        Title = "拆 分",
        ItemInfo = self.mItemInfo,
        CallBack = splitFunction,
        MinCount = 1,
        MaxCount = self.mBagItemInfo.count - 1
    })
end

---"锻造"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_ForgeOperate(go)
    --region 检查是否为打开界面
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    local customData = {};
    customData.bagItemInfo = self.mBagItemInfo
    if self.mBagItemInfo.index == 0 then
        customData.type = LuaEnumStrengthenType.Bag
        uimanager:ClosePanel("UIBagPanel")
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Strengthen_Bag, customData);
    else
        customData.type = LuaEnumStrengthenType.Role
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Strengthen_Role, customData);
    end
    --endregion
end

---"合成"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_CombineOperate(go)
    --region 检查是否为打开界面
    --if self:TryOpenPanel(LuaEnumItemOperateType.Combine) then
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    --    return
    --end
    local ItemJumpSynthesisData = self:IsJumpSynthesisList(self.mBagItemInfo);
    if (ItemJumpSynthesisData ~= nil) then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Synthesis_List, ItemJumpSynthesisData);
    else
        local customData = {};
        --合成背包移除了，就不用直接跳到背包界面，并且也不用默认选中合成啦
        --customData.bagItemInfo = self.mBagItemInfo;
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Synthesis_List, customData);
    end
    --endregion
end

---@private 提升会员等级按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_UpgradeMembership(go)
    uimanager:ClosePanel("UIItemInfoPanel")
    if(self.mItemInfo ~= nil) then
        local params = LuaGlobalTableDeal:GetReinPanelShowItemData(self.mItemInfo.id);
        if(params ~= nil) then
            uiTransferManager:TransferToPanel(params.transferId);
        end
    end
end

---"收藏"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_CollectOperate(go)
    local collectionInfo = gameMgr:GetPlayerDataMgr():GetCollectionInfo()
    local collectionOpened, reasonStr = collectionInfo:IsMainPlayerCollectionOpened()
    if collectionOpened == false then
        if reasonStr ~= nil then
            Utility.ShowPopoTips(go, reasonStr, 290, "UIBagPanel")
        end
        return
    end
    if collectionInfo:GetCollectionDic()[self.mBagItemInfo.lid] ~= nil then
        ---下架操作
        collectionInfo:ReqPutOffCollectionItem(self.mBagItemInfo.lid)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
    else
        ---收藏操作
        local bagItemInCarbinet = collectionInfo:GetCollectionItemByCollectionID(self.mBagItemInfo.itemId)
        if bagItemInCarbinet ~= nil and collectionInfo:IsLeftBetterThanRight(bagItemInCarbinet:GetCollectionBagItem(), self.mBagItemInfo) then
            ---如果藏品阁中有该物品且比当前物品更好,则二次弹窗确认
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(self.mBagItemInfo, nil, nil, nil, false)
            if result == false then
                Utility.ShowPopoTips(go, resultStr, 290, "UIItemInfoPanel")
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            else
                local wordTbl, tblExist
                tblExist, wordTbl = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(155)
                if tblExist and wordTbl then
                    Utility.ShowSecondConfirmPanel({ PromptWordId = 155, ComfireAucion = function()
                        uimanager:ClosePanel("UIItemInfoPanel")
                        uimanager:ClosePanel("UIPetInfoPanel")
                        collectionInfo:TryReqPutOnCollectionItem(self.mBagItemInfo, nil, nil, nil, true)
                        if uimanager:GetPanel("UICollectionPanel") == nil then
                            ---如果藏品界面未打开,则跳转到藏品界面
                            uiTransferManager:TransferToPanel(607)
                        end
                    end })
                else
                    uimanager:ClosePanel("UIItemInfoPanel")
                    uimanager:ClosePanel("UIPetInfoPanel")
                    collectionInfo:TryReqPutOnCollectionItem(self.mBagItemInfo, nil, nil, nil, true)
                    if uimanager:GetPanel("UICollectionPanel") == nil then
                        ---如果藏品界面未打开,则跳转到藏品界面
                        uiTransferManager:TransferToPanel(607)
                    end
                end
            end
        else
            local result, resultStr = collectionInfo:TryReqPutOnCollectionItem(self.mBagItemInfo, nil, nil, nil, true)
            if result then
                uimanager:ClosePanel("UIItemInfoPanel")
                uimanager:ClosePanel("UIPetInfoPanel")
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            else
                Utility.ShowPopoTips(go, resultStr, 290, "UIItemInfoPanel")
                if uimanager:GetPanel("UICollectionPanel") == nil then
                    ---如果藏品界面未打开,则跳转到藏品界面
                    uiTransferManager:TransferToPanel(607)
                end
            end
        end
    end
end

---所有需要跳转到合成表的列表,key为道具ID
UIItemInfoPanel_Info_RightUpOperateButtons.AllItemJumpSynthesisData = nil
---判定道具是否点击合成的时候跳转到合成列表
---@param bagItemInfo bagV2.BagItemInfo
function UIItemInfoPanel_Info_RightUpOperateButtons:IsJumpSynthesisList(bagItemInfo)
    if (UIItemInfoPanel_Info_RightUpOperateButtons.AllItemJumpSynthesisData == nil) then
        UIItemInfoPanel_Info_RightUpOperateButtons.AllItemJumpSynthesisData = LuaGlobalTableDeal:GetItemJumpSynthesisData()
    end

    for i, jumpData in pairs(UIItemInfoPanel_Info_RightUpOperateButtons.AllItemJumpSynthesisData) do
        if (i == bagItemInfo.itemId) then
            return jumpData
        end
    end
    return nil
end

---"获取"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_GainOperate(go)
    if (self.mItemInfo ~= nil) then
        local itemInfoPanel = uimanager:GetPanel("UIItemInfoPanel");
        if itemInfoPanel == nil then
            itemInfoPanel = uimanager:GetPanel("UIPetInfoPanel");
        end
        if itemInfoPanel == nil then
            return
        end
        local itemInfoPanelOriginPosition = itemInfoPanel.go.transform.localPosition;
        if (itemInfoPanel ~= nil and Utility.GetTableCount(itemInfoPanel.assistPanelBagItemInfoTable) > 0) then
            itemInfoPanel.go.transform.localPosition = CS.UnityEngine.Vector3(itemInfoPanelOriginPosition.x - 165, itemInfoPanelOriginPosition.y, itemInfoPanelOriginPosition.z);
        end

        local CloseCallBack = function()
            if (not CS.StaticUtility.IsNull(self.go)) then
                self.go:SetActive(true);
            end
            if (not CS.StaticUtility.IsNull(itemInfoPanel.go)) then
                itemInfoPanel.go.transform.localPosition = itemInfoPanelOriginPosition;
            end
        end

        if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(self.mItemInfo.id)) then
            local isCloseSelf = true;
            if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ShopDiamondGetWay);
            elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Auction) then
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.AuctionDiamondGetWay);
            elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagPanel) then
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.BagDiamondGetWay);
            else
                isCloseSelf = false;
                Utility.ShowItemGetWay(self.mItemInfo.id, self:GetBackGround_GameObject(), LuaEnumWayGetPanelArrowDirType.LeftUp, CS.UnityEngine.Vector2(100, 0), CloseCallBack, uiStaticParameter.RechargePoint);
            end
            if (isCloseSelf) then
                uimanager:ClosePanel("UIItemInfoPanel");
            end
        else
            if (not CS.StaticUtility.IsNull(self.go)) then
                self.go:SetActive(false);
            end
            --获取按钮
            if (self.mItemInfo.id == 1000002) then
                --元宝
                if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
                    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.ShopIngotGetWay
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelIngotGetWayToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Auction) then
                    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.AuctionIngotGetWay
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuctionIngotGetWayToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagPanel) then
                    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.BagIngotGetWay
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagIngotGetWayToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.LevelUpReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.LevelUpRewardIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.FirstKillReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.FirstKillRewardIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.FirstDropReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.FirstDropRewardIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PrefixReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PrefixRewardIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.LSSchoolPanel) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.LSSchoolIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.SecondServantSiteCurrencyNotEnough) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.SecondServantSiteIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ThirdServantSiteCurrencyNotEnough) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ThirdServantSiteIngotNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DiamondToPushGiftPanel) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DiamondToPushGiftPanelToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantGatherSoulPanel) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantGatherSoulPanelToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.ServantMagicWeapon) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ServantMagicWeaponToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MagicBossPanel) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MagicBossPanelToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagDiamondGetWay) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagPanelDiamondGetWayToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.DayRecharge) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.DayRechargeToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerRechargeToReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerRechargeToRewardToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrossServerLimitGift) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrossServerLimitGiftToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.IngotGiftToReward) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.IngotGiftToRewardToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Investment) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.InvestmentToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Carnival) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CarnivalToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.CrawlTower) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CrawlTowerToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PlayerDead) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PlayerDeadToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PotentialInvest) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PotentialInvestToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberPromote) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberPromoteToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.MemberGift) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.MemberGiftToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BerserkPower) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BerserkPowerToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickAuctionBuy) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickAuctionBuyToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.QuickShopBuy) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.QuickShopBuyToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BuyExpElixir) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BuyExpElixirToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.PracticeRoom) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.PracticeRoomToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.AuthenticateDiamondNotEnough) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.AuthenticateDiamondNotEnoughToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.UnionInspireDiamondNotEnough) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.UnionInspireDiamondNotEnoughToRewardGift
                end
            elseif (self.mItemInfo.id == 1000004) then
                --金币
                if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.ShopPanelGoldGetWayToRewardGift
                elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagPanel) then
                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.BagGoldGetWayToRewardGift
                end
            end
            --print("---购买", uiStaticParameter.RechargePoint)
            Utility.ShowItemGetWay(self.mItemInfo.id, self:GetBackGround_GameObject(), LuaEnumWayGetPanelArrowDirType.LeftUp, CS.UnityEngine.Vector2(100, 0), CloseCallBack, uiStaticParameter.RechargePoint);
        end
    end
end

---是否是钻石自定义埋点
---@return boolean 是否是钻石配置埋点
function UIItemInfoPanel_Info_RightUpOperateButtons:IsDiamondIdListRechargePoint()
    if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(self.mItemInfo.id)) then
        if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Shop) then
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ShopDiamondGetWay);
            return true
        elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.Auction) then
            Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.AuctionDiamondGetWay);
            return true
        elseif (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.BagPanel) then
            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.BagDiamondGetWay
        end
    end
    return false
end

---"维修"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_RepairOperate(go)
    --[[    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 55, 61 }, "UIRepairPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)
        ---如果最近一次寻路失败,那么可以猜测在副本里不能抵达寻路目标点,所以先请求暂停并弹窗
        if CS.CSPathFinderManager.Instance.IsLatestPathFindRequestFailed then
            CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 55, 61 }, "UIRepairPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)
            end)
        end]]
    --寻路改传送
    Utility.TryTransfer(1013)
    uimanager:ClosePanel('UIRolePanel')
    uimanager:ClosePanel('UIBagPanel')
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIPetInfoPanel")
end

---"镶嵌"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickMosaic(go)
    local customData = {}
    if self.mItemInfo.type == luaEnumItemType.Element then
        ---是元素鸭
        customData = { chooseEquipIndex = CS.CSScene.MainPlayerInfo.ElementInfo:GetDefaultChooseEquipIndex(self.mItemInfo), chooseElementItemId = self.mItemInfo.id }
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Element_Role, customData);
        uimanager:ClosePanel('UIBagPanel')
        uimanager:ClosePanel('UIItemInfoPanel')
    elseif self.mItemInfo.type == luaEnumItemType.Signet then
        customData = { chooseEquipIndex = CS.CSScene.MainPlayerInfo.SignetV2:GetEquipSignetIndex(self.mItemInfo), chooseSignetmBagItemInfo = self.mBagItemInfo }
        if self.mItemInfo ~= nil and self.mItemInfo.career == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) then
            ---是印记鸭
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Imprint_Role, customData);
            uimanager:ClosePanel('UIBagPanel')
            uimanager:ClosePanel('UIItemInfoPanel')
        else
            Utility.ShowPopoTips(go.transform, '非本职业印记无法镶嵌', 269)
        end
    end
end

---"捆绑"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_BundleOperate(go)
    CS.CSScene.MainPlayerInfo.AsyncOperationController.ItemInfoFindNPCOperation:DoOperation({ 54, 59 }, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)
    if uimanager:GetPanel('UIBagPanel') then
        uimanager:ClosePanel('UIBagPanel')
    end
    if uimanager:GetPanel('UIRolePanel') then
        uimanager:ClosePanel('UIRolePanel')
    end
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIPetInfoPanel")
end

---"婚戒操作"按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickMarryRingClick(go)
    local marryRingNpcId = CS.Cfg_GlobalTableManager.Instance:GetMarryRingNpcId()
    local marryRingDeliverId = CS.Cfg_GlobalTableManager.Instance:GetMarryRingDeliverId()
    local finishCodeEnum = CS.CSScene.MainPlayerInfo.AsyncOperationController.MarryRingOperateFindNPCOperation:DoOperation(marryRingDeliverId, marryRingNpcId)
    local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(finishCodeEnum)
    if finishCode >= 0 then
        uimanager:ClosePanel('UIItemInfoPanel')
        uimanager:ClosePanel('UIRolePanel')
        uimanager:ClosePanel('UIBagPanel')
    end
end

---融合按钮点击回调
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickBlendCLick(go)
    ---寻路并开启小飞鞋
    local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 14, 1000 }, "UIMedalInlayPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)
    ----融合按钮可能会加上副本内弹窗决定是否返回主城后继续操作的逻辑,如果需要,将这段逻辑解注释即可
    --if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
    --    ---不能前往主城时,先前往主城
    --    res = CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
    --        self:OnClickBlendCLick(go)
    --    end)
    --    if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
    --        uimanager:ClosePanel('UIRolePanel')
    --        uimanager:ClosePanel('UIBagPanel')
    --        uimanager:ClosePanel('UIItemInfoPanel')
    --        uimanager:ClosePanel("UIPetInfoPanel")
    --    end
    --else
    uimanager:ClosePanel('UIRolePanel')
    uimanager:ClosePanel('UIBagPanel')
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIPetInfoPanel")
    --end
end

---日常任务使用
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickDailyTaskItemUse(go)
    if self.mItemInfo == nil then
        return
    end
    local useParam = self.mItemInfo.useParam
    if useParam == nil or useParam.list == nil or useParam.list.Count == 0 then
        return
    end
    if CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance.DailyTaskItemUseTipLimit then
        ---CS.CSTargetGetWayManager.Instanece:OpenFindTarget(useParam.list[0])
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(useParam.list[0])
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
    else
        self:DailyTaskItemTip(useParam.list[0])
    end
end

---魂继装备通灵
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_HunJiTongLing(go)
    if self.mItemInfo == nil or self.mBagItemInfo == nil then
        return
    end
    if self.isEquiped == false then
        return
    end
    networkRequest.ReqServantEquipSoul(self.mBagItemInfo.index)
    uimanager:ClosePanel("UIItemInfoPanel")
end

---装备炼化按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_Refine(go)
    if self.mItemInfo == nil or self.mBagItemInfo == nil then
        return
    end
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Refine, { bagItemInfo = self.mBagItemInfo })
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---熔炼按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_Semelt(go)
    if self.mItemInfo == nil or self.mBagItemInfo == nil then
        return
    end
    uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Smelt)
    uimanager:ClosePanel("UIItemInfoPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
end

---洗炼按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_AgainRefine(go)
    if self.mItemInfo == nil or self.mBagItemInfo == nil then
        return
    end
    local noticeInfo = clientTableManager.cfg_noticeManager:TryGetValue(73)
    if noticeInfo then
        local openSys = Utility.IsNoticeOpenSystem(noticeInfo)
        if openSys then
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
            uimanager:ClosePanel("UIBagPanel")
            uiTransferManager:TransferToPanel(LuaEnumTransferType.AgainRefine_Role)
        else
            Utility.ShowPopoTips(go, nil, 464)
        end
    end
end

---仙装镶嵌按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_XianZhuangInlay(go)
    if self.mBagItemInfo ~= nil then
        if not Utility.CheckSystemOpenState(76) then
            Utility.ShowPopoTips(go,nil,505,"UIItemInfoPanel")
            return
        end
        uiTransferManager:TransferToSoulEquipPanel(self.mBagItemInfo)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
    end
end

function UIItemInfoPanel_Info_RightUpOperateButtons:DailyTaskItemTip(useParam)
    local temp = {}
    temp.CallBack = function()
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(useParam)
        ---CS.CSTargetGetWayManager.Instanece:OpenFindTarget(useParam)
        uimanager:ClosePanel('UIPromptPanel')
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
    end
    temp.CancelCallBack = function()
        uimanager:ClosePanel('UIPromptPanel')
    end
    local isfind, itemGatway = CS.Cfg_ItemGetWayTableManager.Instance:TryGetValue(useParam)
    if isfind then
        temp.Content = itemGatway.text
    end

    temp.LeftDescription = "取消"
    temp.RightDescription = "确定"
    uimanager:CreatePanel("UIPromptPanel", nil, temp)

end

---日常任务出售
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnClickDailyTaskItemSell(go)
    if self.mItemInfo == nil then
        return
    end
    local useParam = self.mItemInfo.useParam
    if useParam == nil or useParam.list == nil or useParam.list.Count < 2 then
        return
    end
    if CS.CSScene.MainPlayerInfo.Level >= CS.Cfg_GlobalTableManager.Instance.DailyTaskItemSellTipLimit then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForObtainItemByGetWay:DoOperation(useParam.list[1])
        ---CS.CSTargetGetWayManager.Instanece:OpenFindTarget(useParam.list[1])
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
    else
        self:DailyTaskItemTip(useParam.list[1])
    end
end

---控制背包格子提示高光开关
---@param open boolean 是否开启背包格子高光开关
function UIItemInfoPanel_Info_RightUpOperateButtons:ControlBagGridHighLight(open)
    if luaEventManager.HasCallback(LuaCEvent.Bag_ControlBagGirdHighLightEffect) then
        luaEventManager.DoCallback(LuaCEvent.Bag_ControlBagGirdHighLightEffect, open)
    end
end

---读取Items表中的参数,尝试打开界面
---@param operateID number 操作ID
---@return boolean 是否打开界面
function UIItemInfoPanel_Info_RightUpOperateButtons:TryOpenPanel(operateID)
    if self.mItemInfo.openPanelSpecified then
        local res, panelParams = CS.Cfg_ItemsTableManager.Instance.OpenPanel:TryGetValue(self.mItemInfo.id)
        if res and panelParams then
            for i = 0, panelParams.Count - 1 do
                if panelParams[i].operateID == operateID then
                    if panelParams[i].jumpID ~= 0 then
                        uiTransferManager:TransferToPanel(panelParams[i].jumpID);
                    else
                        CS.Utility.ShowTips("openPanel未配置")
                    end
                    return true
                end
            end
        end
    end
    return false
end

---鉴定按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_JianDing(go)
    if self.mBagItemInfo ~= nil then
        uiTransferManager:TransferToForgeIdentifyPanel(self.mBagItemInfo)
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
    end
end

---升级按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_ShengJi(go)
    local customData = {}
    local openPanelFunc
    if self.mBagItemInfo ~= nil then
        ---套装类型
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        local DivineSuitType = clientTableManager.cfg_itemsManager:GetDivineSuitType(self.mBagItemInfo.itemId)
        ---人物穿戴装备||兵鉴穿戴后，自动打开对应的角色-兵鉴界面
        if DivineSuitType ~= nil and DivineSuitType > 0 then
            customData = {
                type = LuaEnumLeftTagType.UIRolePanel,
                openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel,
            }
            ---@param uiPanel UIRolePanel
            openPanelFunc = (DivineSuitType ~= nil and DivineSuitType > 0) and function(uiPanel)
                if (uiPanel ~= nil) then
                    uiPanel:SwitchSuitPage(DivineSuitType)
                end
            end or nil
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
        if self.mBagItemInfo.index ~= 0 then
            CS.CSListUpdateMgr.Add(150, nil, function()
                luaEventManager.DoCallback(LuaCEvent.BingJianChoose, self.mBagItemInfo)
                uimanager:CreatePanel("UISLequipLevelPanel", nil, 1, self.mBagItemInfo)
            end)
        else
            local LuaPlayerEquipmentListData = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentList(LuaEquipmentListType.Sl_BingJian)
            if LuaPlayerEquipmentListData then
                local equipDic = LuaPlayerEquipmentListData.EquipmentDic
                for k, v in pairs(equipDic) do
                    ---@type LuaEquipDataItem
                    local equipInfo = v
                    if equipInfo.BagItemInfo then
                        if equipInfo.BagItemInfo.index == 106301 then
                            uimanager:ClosePanel("UIRolePanel")
                            uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, openPanelFunc)
                            CS.CSListUpdateMgr.Add(200, nil, function()
                                luaEventManager.DoCallback(LuaCEvent.BingJianChoose, equipInfo.BagItemInfo)
                                uimanager:CreatePanel("UISLequipLevelPanel", nil, 1, equipInfo.BagItemInfo)
                            end)
                            return
                        end
                    end
                end
                uimanager:ClosePanel("UIRolePanel")
                uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, openPanelFunc)
                CS.CSListUpdateMgr.Add(200, nil, function()
                    uimanager:CreatePanel("UISLequipLevelPanel", nil, 1)
                end)
            end
        end
    end
end

---突破按钮点击
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:OnButtonClicked_TuPo(go)
    local customData = {}
    local openPanelFunc
    if self.mBagItemInfo ~= nil then
        ---套装类型
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        local DivineSuitType = clientTableManager.cfg_itemsManager:GetDivineSuitType(self.mBagItemInfo.itemId)
        ---人物穿戴装备||兵鉴穿戴后，自动打开对应的角色-兵鉴界面
        if DivineSuitType ~= nil and DivineSuitType > 0 then
            customData = {
                type = LuaEnumLeftTagType.UIRolePanel,
                openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel,
            }
            ---@param uiPanel UIRolePanel
            openPanelFunc = (DivineSuitType ~= nil and DivineSuitType > 0) and function(uiPanel)
                if (uiPanel ~= nil) then
                    uiPanel:SwitchSuitPage(DivineSuitType)
                end
            end or nil
        end
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel("UIPetInfoPanel")
        uimanager:ClosePanel("UIBagPanel")
        if self.mBagItemInfo.index ~= 0 then
            CS.CSListUpdateMgr.Add(150, nil, function()
                luaEventManager.DoCallback(LuaCEvent.BingJianChoose, self.mBagItemInfo)
                uimanager:CreatePanel("UISLequipLevelPanel", nil, 2, self.mBagItemInfo)
            end)
        else
            local equipInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetSLBingJianByGlobalOrder()
            if equipInfo then
                uimanager:ClosePanel("UIRolePanel")
                uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, openPanelFunc)
                CS.CSListUpdateMgr.Add(200, nil, function()
                    luaEventManager.DoCallback(LuaCEvent.BingJianChoose, equipInfo)
                    uimanager:CreatePanel("UISLequipLevelPanel", nil, 2, equipInfo)
                end)
            end
            uimanager:ClosePanel("UIRolePanel")
            uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, openPanelFunc)
            CS.CSListUpdateMgr.Add(200, nil, function()
                uimanager:CreatePanel("UISLequipLevelPanel", nil, 2)
            end)
        end
    end
end


--endregion

--region 烟花使用

---使用烟花回调（基础判定）
function UIItemInfoPanel_Info_RightUpOperateButtons:UseFireworkCallBack(id, go)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    --是否已达每日上限
    if CS.CSScene.MainPlayerInfo.DuplicateV2.isBoundMaxDay then
        UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 85)
        return
    end
    self:CheckUseCount()
end

---查看使用多个烟花
function UIItemInfoPanel_Info_RightUpOperateButtons:CheckUseCount()
    if self.mBagItemInfo.count < 2 then
        --物品数量小于2时，直接请求使用该物品
        self:TryUseFireworkFunc(1)
    else
        --物品数量大于1时，根据批量使用类型使用
        if self.mItemInfo.batchusage == 1 then
            --若批量使用类型为弹出数量界面选择使用数量
            local useFunction = function(count)
                self:TryUseFireworkFunc(count)
            end
            local maxCount = CS.CSScene.MainPlayerInfo.DuplicateV2:SelectFireworkCount(self.mBagItemInfo.count)
            uimanager:CreatePanel("UIItemCountPanel", function()
                uimanager:ClosePanel("UIItemInfoPanel")
            end, {
                Title = "使 用",
                ItemInfo = self.mItemInfo,
                CallBack = useFunction,
                MinCount = 1,
                BeginningCount = maxCount,
                MaxCount = maxCount == 0 and 1 or maxCount
            })
        elseif self.mItemInfo.batchusage == 2 then
            --若批量使用类型为使用当前格子所有物品
            self:TryUseFireworkFunc(self.mBagItemInfo.count)
        else
            --不批量使用
            self:TryUseFireworkFunc(1)
        end
    end
end

---尝试使用烟花
function UIItemInfoPanel_Info_RightUpOperateButtons:TryUseFireworkFunc(count)
    --判断是否超过时间界限而非使用界限
    if CS.CSScene.MainPlayerInfo.DuplicateV2:IsOutOfBoundsOfCount(count) then
        self:ShowOutOfBoundsFireworkTips(count)
    else
        self:UseFirworkItemCount(count)
    end
end

---使用烟花最终方法
function UIItemInfoPanel_Info_RightUpOperateButtons:UseFirworkItemCount(count)
    networkRequest.ReqUseItem(count, self.mBagItemInfo.lid)
    uimanager:ClosePanel("UIBagPanel")
    uimanager:ClosePanel("UIPromptPanel")
    uimanager:ClosePanel("UIPetInfoPanel")
    uimanager:ClosePanel('UIItemInfoPanel')
    uimanager:ClosePanel("UIItemCountPanel")
end

---显示超界烟花tips
function UIItemInfoPanel_Info_RightUpOperateButtons:ShowOutOfBoundsFireworkTips(count)
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

--region 灵兽背包处理
function UIItemInfoPanel_Info_RightUpOperateButtons:IsServantBagUseItem(go)
    --region 灵兽背包另外处理
    local bagPanel = self:GetBagPanel()
    if bagPanel ~= nil and bagPanel:GetBagType() == LuaEnumBagType.Servant then
        local isServantEgg, isServantFragment, isServantEquip, isServantMagicWeapon, isBodyServantEquip, isServantRelatedBagItem, isServantReinOrLevelBagItem, isSameWithServantPanel = bagPanel:GetBagMainController():GetBagItemInfoCompareWithWithServantPanel(self.mBagItemInfo, self.mItemInfo)
        if isServantRelatedBagItem == false then
            Utility.ShowPopoTips(go.transform, "该面板不可进行此操作", 48)
            return true
        elseif isSameWithServantPanel == false then
            Utility.ShowPopoTips(go.transform, "与所选灵兽类型不符", 48)
            return true
        end
    end
    return false
    --endregion
end
--endregion

--region 按钮红点
---按钮是否开启高亮
function UIItemInfoPanel_Info_RightUpOperateButtons:BtnNeedHighLight(btnId)
    if self.highLightBtnTable == nil then
        return false
    end
    if type(self.highLightBtnTable) == 'boolean' then
        return false
    end
    for k, v in pairs(self.highLightBtnTable) do
        if v == btnId then
            return true
        end
    end
    return false
end
--endregion

--region 鲜花使用
function UIItemInfoPanel_Info_RightUpOperateButtons:UseFlowerCallBack()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil then
        return
    end
    local isFind = CS.CSScene.MainPlayerInfo.FriendInfoV2:isHasFriendOfSex(self.mItemInfo.subType == luaEnumMaterialType.Rose)
    if not isFind then
        uimanager:CreatePanel("UISendFlowerRandomPanel", nil, { bagInfo = self.mBagItemInfo, tabelInfo = self.mItemInfo })
        uimanager:ClosePanel('UIItemInfoPanel')
    else
        uiTransferManager:TransferToPanel(1405)
        uimanager:ClosePanel('UIItemInfoPanel')
    end
end

--endregion

--region 法宝装备
---法宝装备装备/卸下
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:DoEquipMagicEquip(bagItemInfo, go)
    if bagItemInfo == nil or CS.StaticUtility.IsNull(go) == true then
        return
    end
    local equipIndex = clientTableManager.cfg_itemsManager:GetMagicEquipEquipIndex(bagItemInfo.itemId)
    if equipIndex == nil then
        return
    end
    if self.isEquiped then
        if equipIndex ~= nil then
            networkRequest.ReqPutOffTheEquip(equipIndex)
        end
    else
        local useParam = clientTableManager.cfg_itemsManager:CanUseMagicEquip(bagItemInfo.itemId)
        if useParam == LuaEnumUseItemParam.MagicEquipSuitTypeLocked then
            UIItemInfoPanel_Info_RightUpOperateButtons.ShowTips(go.transform, nil, 427)
        else
            networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
            local suitType = clientTableManager.cfg_itemsManager:GetMagicEquipSuitType(bagItemInfo.itemId)
            uiTransferManager:TransferToMagicEquipPanel(suitType)
        end
    end
    uimanager:ClosePanel('UIItemInfoPanel')
end
--endregion

--region 神力装备的装备
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:DoDivineEquip(bagItemInfo, go)
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
            local playerHasEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipmentItem(divineData:GetType(), LuaEquipmentItemType.POS_SL_FABAO, false)
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
            local isNeedSecEquip =  gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsNeedSec(bagItemInfo.ItemTABLE.id)
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
                    ---对比获得更差神力装备
                end
            end

            networkRequest.ReqPutOnTheEquip(reqIndex, bagItemInfo.lid)
            uimanager:ClosePanel("UIItemInfoPanel")
            uimanager:ClosePanel("UIPetInfoPanel")
        end
    end
end
--endregion

--region 魂继的装备/通灵/卸下
---灵兽魂继装备的装备或通灵
---@protected
---@param bagItemInfo bagV2.BagItemInfo
---@param go UnityEngine.GameObject
function UIItemInfoPanel_Info_RightUpOperateButtons:DoEquipServantHunJiEquip(bagItemInfo, go)
    if self.isEquiped then
        ---请求卸下装备
        ---若魂继装备已经装备,则请求卸下该装备
        ---请求卸下之前,先请求取消通灵
        if self.mHunJiTongLingState then
            networkRequest.ReqServantEquipSoul(bagItemInfo.index)
        end
        networkRequest.ReqPutOffTheEquip(bagItemInfo.index)
        uimanager:ClosePanel("UIItemInfoPanel")
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
                self:TryDoEquipServantHunJi_WithServantPanel_SelectedHunJiPos(bagItemInfo, go, servantSeatType, uiStaticParameter.mSelectedHunJiPos)
            else
                ---根据未选中了某个魂继位时的处理
                self:TryDoEquipServantHunJi_WithServantPanel_NonSelectedHunJiPos(bagItemInfo, go, servantSeatType)
            end
        else
            ---灵兽界面不存在时
            if bagItemInfo.ItemTABLE.subType == 0 then
                self:TryDoEquipServantHunJi_NoServantPanel_GeneralHunJi(bagItemInfo, go)
            else
                self:TryDoEquipServantHunJi_NoServantPanel_NoGeneralHunJi(bagItemInfo, go)
            end
        end
    end
end

---有UIServantPanel且未选中某个魂继位时的处理
---@private
---@param bagItemInfo
---@param go
---@param servantSeatType luaEnumServantSeatType 当前选中的灵兽位
function UIItemInfoPanel_Info_RightUpOperateButtons:TryDoEquipServantHunJi_WithServantPanel_NonSelectedHunJiPos(bagItemInfo, go, servantSeatType)
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
function UIItemInfoPanel_Info_RightUpOperateButtons:TryDoEquipServantHunJi_WithServantPanel_SelectedHunJiPos(bagItemInfo, go, servantSeatType, selectedPos)
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
function UIItemInfoPanel_Info_RightUpOperateButtons:TryDoEquipServantHunJi_NoServantPanel_GeneralHunJi(bagItemInfo, go)
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
            ---灵兽等级不足SkillBook
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
        uimanager:ClosePanel("UIItemInfoPanel")
        local servantIndex = math.floor(equipIndex / 10000) - 1
        uimanager:CreatePanel("UIServantTagPanel", nil, {
            type = LuaEnumServantPanelType.HunJiPanel,
            servantIndex = servantIndex,
            openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel
        })
    else
        if isAllServantSeatUnopened then
            ---所有灵兽位均未开启
            Utility.ShowPopoTips(go, "目标灵兽位未开启", 205, "UIItemInfoPanel")
        elseif isAllServantNotOn then
            ---所有灵兽均未上阵
            Utility.ShowPopoTips(go, "请先召唤灵兽", 205, "UIItemInfoPanel")
        elseif servantLevelUnmatch then
            ---灵兽等级不足
            Utility.ShowPopoTips(go, "灵兽等级不足", 205, "UIItemInfoPanel")
        elseif servantReinLevelUnmatch then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIItemInfoPanel")
        end
    end
end

---无UIServantPanel时装备非通用魂继
---@private
function UIItemInfoPanel_Info_RightUpOperateButtons:TryDoEquipServantHunJi_NoServantPanel_NoGeneralHunJi(bagItemInfo, go)
    ---若非已装备的魂继装备,则视情况装备到目标魂继位上,一般在背包中
    ---@type CSServantData_MainPlayer
    local mainPlayerServantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
    ---非通用魂继时,直接去对应灵兽位的空闲或可替换的灵兽装备位,若没有则直接根据原因弹出提示
    ---@type CSServantSeatData_MainPlayer
    local servantSeatData = mainPlayerServantData:GetServantSeatData(bagItemInfo.ItemTABLE.subType)
    local equipIndex, reason = servantSeatData:GetNextHunJiEquipIndexInServantSeat(bagItemInfo, true)
    if equipIndex ~= 0 then
        networkRequest.ReqPutOnTheEquip(equipIndex, bagItemInfo.lid)
        uimanager:ClosePanel("UIItemInfoPanel")
        local servantIndex = math.floor(equipIndex / 10000) - 1
        uimanager:CreatePanel("UIServantTagPanel", nil, {
            type = LuaEnumServantPanelType.HunJiPanel,
            servantIndex = servantIndex,
            openSourceType = LuaEnumPanelOpenSourceType.ByItemInfoPanel
        })
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
        elseif reason == CS.EHunJiEquipFailReason.ReinLevelNotAvailable then
            ---灵兽转生等级不足
            Utility.ShowPopoTips(go, "灵兽转生等级不足", 205, "UIItemInfoPanel")
        end
    end
end
--endregion

--region 额外按钮
---@param itemInfo TABLE.CFG_ITEMS
---@param bagItemInfo bagV2.BagItemInfo
function UIItemInfoPanel_Info_RightUpOperateButtons:AddExtendBtn(bagItemInfo, itemInfo)
    local addBtn = {}
    --添加交易上架按钮
    if bagItemInfo ~= nil and itemInfo ~= nil and (Utility.GetActivityOpen(11) and (bagItemInfo.index == 0 or bagItemInfo.index == nil)) then
        local IsNeedShowBind, IsNeedShowBindTwoParamet = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(bagItemInfo)
        if not IsNeedShowBind then
            local id = itemInfo.id
            if CS.CSServerItemInfo.CanYuanBaoDeal(id) or CS.CSServerItemInfo.CanDiamondDeal(id) then
                ---@type CSMainPlayerInfo
                local mainPlayerInfo = CS.CSScene.MainPlayerInfo
                if mainPlayerInfo then
                    local bagItemDic = mainPlayerInfo.BagInfo.BagItems
                    if bagItemDic:TryGetValue(bagItemInfo.lid) then
                        table.insert(addBtn, LuaEnumItemOperateType.AuctionHouse)
                    end
                end
            end
        end
    end
    --[[    --熔炼
        if bagItemInfo ~= nil and itemInfo ~= nil and Utility.IsAvailableForSemelt(itemInfo) == true and Utility.CheckOpenSmelt() == true then
            table.insert(addBtn, LuaEnumItemOperateType.Semelt)
        end]]
    --扩展ing
    return addBtn
end
--endregion

--region 额外特效
function UIItemInfoPanel_Info_RightUpOperateButtons:AddHightLightGo(tbl, bagItemInfo)
    if(bagItemInfo == nil) then
        return;
    end
    local luaItemInfo =Utility.GetItemTblByBagItemInfo(bagItemInfo)
    if bagItemInfo.currentLasting <= 0 then
        table.insert(tbl, LuaEnumItemOperateType.Repair)
    end
end
--endregion

return UIItemInfoPanel_Info_RightUpOperateButtons