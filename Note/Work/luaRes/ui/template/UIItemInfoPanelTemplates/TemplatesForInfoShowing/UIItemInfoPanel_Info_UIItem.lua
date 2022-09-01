---物品信息界面UIItem 物品信息界面信息
---@class UIItemInfoPanel_Info_UIItem:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_UIItem = {}

setmetatable(UIItemInfoPanel_Info_UIItem, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
---UIItem根节点
function UIItemInfoPanel_Info_UIItem:GetUIItemRoot_GameObject()
    if self.mUIItemRoot_GO == nil then
        self.mUIItemRoot_GO = self:Get("UIItem", "GameObject")
    end
    return self.mUIItemRoot_GO
end

---类型文本
function UIItemInfoPanel_Info_UIItem:GetTypeLabel_UILabel()
    if self.mTypeLabel_UILabel == nil then
        self.mTypeLabel_UILabel = self:Get("baseInfo/Type", "UILabel")
    end
    return self.mTypeLabel_UILabel
end

---等级文本
---@return UILabel
function UIItemInfoPanel_Info_UIItem:GetLevelLabel_UILabel()
    if self.mLevelLabel_UILabel == nil then
        self.mLevelLabel_UILabel = self:Get("baseInfo/Level", "UILabel")
    end
    return self.mLevelLabel_UILabel
end

---装备状态游戏物体
function UIItemInfoPanel_Info_UIItem:GetWearState_GameObject()
    if self.mWearState_GO == nil then
        self.mWearState_GO = self:Get("baseInfo/WearState", "GameObject")
    end
    return self.mWearState_GO
end

---@return UILabel
function UIItemInfoPanel_Info_UIItem:GetWearState_UILabel()
    if self.mWearState_UILabel == nil then
        self.mWearState_UILabel = self:Get("baseInfo/WearState", "UILabel")
    end
    return self.mWearState_UILabel
end

---性别文本
function UIItemInfoPanel_Info_UIItem:GetSexLabel_UILabel()
    if self.mSexLabel_UILabel == nil then
        self.mSexLabel_UILabel = self:Get("baseInfo/Sex", "UILabel")
    end
    return self.mSexLabel_UILabel
end

---职业文本
function UIItemInfoPanel_Info_UIItem:GetCareerLabel_UILabel()
    if self.mCareerLabel_UILabel == nil then
        self.mCareerLabel_UILabel = self:Get("baseInfo/Career", "UILabel")
    end
    return self.mCareerLabel_UILabel
end

---CD时间文本
function UIItemInfoPanel_Info_UIItem:GetCDTimeLabel_UILabel()
    if self.mCDTimeLabel_UILabel == nil then
        self.mCDTimeLabel_UILabel = self:Get("baseInfo/CDTime", "UILabel")
    end
    return self.mCDTimeLabel_UILabel
end

---CD事件倒计时
---@return UICountdownLabel
function UIItemInfoPanel_Info_UIItem:GetCDTimeCountDown()
    if self.mCDTimeCountDown == nil then
        self.mCDTimeCountDown = self:Get("baseInfo/CDTime", "UICountdownLabel")
    end
    return self.mCDTimeCountDown
end

---展示按钮
function UIItemInfoPanel_Info_UIItem:GetShowBtn_GameObject()
    if self.mShowBtn_GameObject == nil then
        self.mShowBtn_GameObject = self:Get("baseInfo/ShowBtn", "GameObject")
    end
    return self.mShowBtn_GameObject
end

---@type UILabel 重量
function UIItemInfoPanel_Info_UIItem:GetWeight_UILabel()
    if self.mWeight_UILabel == nil then
        self.mWeight_UILabel = self:Get("baseInfo/weight", "UILabel")
    end
    return self.mWeight_UILabel
end

---持久
function UIItemInfoPanel_Info_UIItem:GetNaijiu_UILabel()
    if self.mNaijiu_UILabel == nil then
        self.mNaijiu_UILabel = self:Get("baseInfo/naijiu", "UILabel")
    end
    return self.mNaijiu_UILabel
end

---道具品级
function UIItemInfoPanel_Info_UIItem:GetItemRank_UILabel()
    if self.mItemRank_UILabel == nil then
        self.mItemRank_UILabel = self:Get("baseInfo/rank", "UILabel")
    end
    return self.mItemRank_UILabel
end

---强化等级
function UIItemInfoPanel_Info_UIItem:GetintensifyNum_UILabel()
    if self.mintensifyNum_UILabel == nil then
        self.mintensifyNum_UILabel = self:Get("baseInfo/num", "UILabel")
    end
    return self.mintensifyNum_UILabel
end

---@return UISprite 强化等级_星星
function UIItemInfoPanel_Info_UIItem:GetIntensifyStar_UISprite()
    if self.mintensifyStar_GameObject == nil then
        self.mintensifyStar_GameObject = self:Get("baseInfo/star", "UISprite")
    end
    return self.mintensifyStar_GameObject
end

---@return UIItem_UIItemInfoPanel
function UIItemInfoPanel_Info_UIItem:GetUIItem_UIItemInfoPanel()
    if (self.mUIItem_UIItemInfoPanel == nil) then
        self.mUIItem_UIItemInfoPanel = templatemanager.GetNewTemplate(self:GetUIItemRoot_GameObject(), luaComponentTemplates.UIItem_UIItemInfoPanel)
    end
    return self.mUIItem_UIItemInfoPanel;
end

---@return UISprite 品质图片
function UIItemInfoPanel_Info_UIItem:GetFrame_UISprite()
    if self.mFrameSprite == nil then
        self.mFrameSprite = self:Get("UIItem/frame", "UISprite")
    end
    return self.mFrameSprite
end

---效果削减警告文本
function UIItemInfoPanel_Info_UIItem:GetWeakenWarning_UILabel()
    if self.WeakenWarning_UILabel == nil then
        self.WeakenWarning_UILabel = self:Get("baseInfo/Warning", "UILabel")
    end
    return self.WeakenWarning_UILabel
end

---绑定
function UIItemInfoPanel_Info_UIItem:GetBind_TweenPosition()
    if self.Bind_GameObject == nil then
        self.Bind_GameObject = self:Get("baseInfo/bind", "TweenPosition")
    end
    return self.Bind_GameObject
end

---可交易
function UIItemInfoPanel_Info_UIItem:GetCanDeal()
    if self.CanDeal == nil then
        self.CanDeal = self:Get("baseInfo/canDeal", "UILabel")
    end
    return self.CanDeal
end

function UIItemInfoPanel_Info_UIItem:GetCanDeal_TweenPosition()
    if self.CanDealtween == nil then
        self.CanDealtween = self:Get("baseInfo/canDeal", "TweenPosition")
    end
    return self.CanDealtween
end

function UIItemInfoPanel_Info_UIItem:GetRecommend_GameObject()
    if self.Recommend_GameObject == nil then
        self.Recommend_GameObject = self:Get("baseInfo/recommend", "GameObject")
    end
    return self.Recommend_GameObject
end
--endregion

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_Info_UIItem:RefreshWithInfo(commonData)
    local bagItemInfo = commonData.bagItemInfo
    local itemInfo = commonData.itemInfo
    local extraEquipList = commonData.extraEquipIdTable
    local isMainPlayer = commonData.isMainPlayer
    self.showBind = commonData.showBind
    self.showAction = commonData.showAction
    self.ismainPlayer = isMainPlayer == nil and true or isMainPlayer  --添加默认主角标识
    self.itemInfoSource = commonData.itemInfoSource
    self.isMainPartTemplate = commonData.isMainPartTemplate
    local otherMainPlayer = commonData.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL and commonData.isMainPartTemplate
    if self:GetUIItem_UIItemInfoPanel().SetIsMainPlayer ~= nil then
        self:GetUIItem_UIItemInfoPanel():SetIsMainPlayer(not otherMainPlayer);
    end
    if bagItemInfo then
        self.BagItemInfo = bagItemInfo
        if itemInfo == nil then
            ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            itemInfo = self.ItemInfo
        end
    end
    self.ItemInfo = itemInfo
    self.ExtraEquipList = extraEquipList

    self.IsNeedShowBind = false
    self.IsNeedShowBindTwoParamet = 0
    self:RefreshBindInfo()

    self:RefreshItem()
    self:RefreshWearState()
    --职业
    --策划取消，暂留
    --self:RefreshCareer()
    self:RefreshCDTime(bagItemInfo, itemInfo)
    self:RefreshShowButton()
    self:RefreshWeight()
    self:RefreshRank()
    self:RefreshLasting()
    self:RefreshStrengthenInfo()
    self:RefreshWeakenWarning()
    self:RefreshBind()
    self:RefreshTrade()
    self:RefreshRecommend()
end

---刷新绑定数据
function UIItemInfoPanel_Info_UIItem:RefreshBindInfo()
    if self.BagItemInfo ~= nil then
        self.IsNeedShowBind, self.IsNeedShowBindTwoParamet = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.BagItemInfo)
    elseif self.ItemInfo ~= nil then
        self.IsNeedShowBind, self.IsNeedShowBindTwoParamet = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.ItemInfo)
    end
end

---刷新基本信息
function UIItemInfoPanel_Info_UIItem:RefreshItem()
    ---@type TABLE.CFG_ITEMS
    local itemInfo = self.ItemInfo
    ---@type bagV2.BagItemInfo
    local bagItemInfo = self.BagItemInfo
    --UIItem
    self:RefreshUIItem()
    --类型
    if self:GetTypeLabel_UILabel() and CS.StaticUtility.IsNull(self:GetTypeLabel_UILabel()) == false then
        if itemInfo then
            if itemInfo.tipsSpecified and itemInfo.tips ~= "" then
                self:GetTypeLabel_UILabel().text = tostring(itemInfo.tips)
            else
                self:GetTypeLabel_UILabel().text = Utility.GetItemType(itemInfo.type, itemInfo.subType)
            end
        end
    end
    --等级
    if self:GetLevelLabel_UILabel() and CS.StaticUtility.IsNull(self:GetLevelLabel_UILabel()) == false then
        --若为装备,则显示为装备内的等级
        if itemInfo then
            self:GetLevelLabel_UILabel().text = self:GetLevelString(itemInfo)
        end
    end
    --性别
    if self:GetSexLabel_UILabel() and CS.StaticUtility.IsNull(self:GetSexLabel_UILabel()) == false then
        self:GetSexLabel_UILabel().text = self:GetSexString(itemInfo)
    end
    self:RefreshFrame()
end

---UIItem
function UIItemInfoPanel_Info_UIItem:RefreshUIItem()
    if self:GetUIItemRoot_GameObject() and CS.StaticUtility.IsNull(self:GetUIItemRoot_GameObject()) == false then
        local extraEquipList = self.ExtraEquipList
        local itemInfo = self.ItemInfo
        local bagItemInfo = self.BagItemInfo
        if (extraEquipList ~= nil) then
            self:GetUIItem_UIItemInfoPanel():AddExtraEquips(extraEquipList);
        end
        if bagItemInfo then
            self:GetUIItem_UIItemInfoPanel():RefreshUIWithBagItemInfo(bagItemInfo)
        else
            self:GetUIItem_UIItemInfoPanel():RefreshUIWithItemInfo(itemInfo)
        end
    end
end

---刷新品质
function UIItemInfoPanel_Info_UIItem:RefreshFrame()
    self:GetFrame_UISprite().gameObject:SetActive(false)
    --if CS.StaticUtility.IsNull(self:GetFrame_UISprite()) == false then
    --    self:GetFrame_UISprite().gameObject:SetActive(self.ItemInfo ~= nil)
    --    self:GetFrame_UISprite().spriteName = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipFrameIcon(self.ItemInfo)
    --end
end

---装备标识
function UIItemInfoPanel_Info_UIItem:RefreshWearState()
    ---@type TABLE.CFG_ITEMS
    local itemInfo = self.ItemInfo
    ---@type bagV2.BagItemInfo
    local bagItemInfo = self.BagItemInfo
    if self:GetWearState_GameObject() and CS.StaticUtility.IsNull(self:GetWearState_GameObject()) == false then
        if bagItemInfo then
            if itemInfo.type == luaEnumItemType.HunJi then
                local isEquiped, servantSeatType, isUsed = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiEquiped(bagItemInfo)
                if isEquiped and isUsed then
                    self:GetWearState_UILabel().text = "[39ce1b]已通灵"
                    self:GetWearState_GameObject():SetActive(true)
                else
                    self:GetWearState_GameObject():SetActive(false)
                end
            elseif itemInfo.type == luaEnumItemType.Collection then
                local isInCabinet = false
                if gameMgr:GetPlayerDataMgr() ~= nil then
                    isInCabinet = gameMgr:GetPlayerDataMgr():GetCollectionInfo():GetCollectionDic()[bagItemInfo.lid] ~= nil
                end
                self:GetWearState_GameObject():SetActive(isInCabinet)
            elseif CS.Utility_Lua.CheckEquipIsUsed(self.BagItemInfo) == true and self.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT then
                self:GetWearState_GameObject():SetActive(true)
            elseif clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id) then
                self:GetWearState_GameObject():SetActive(bagItemInfo.index ~= 0 and not self.isMainPartTemplate)
            else
                self:GetWearState_GameObject():SetActive(false)
            end
        else
            self:GetWearState_GameObject():SetActive(false)
        end
    end
end

---刷新职业显示
function UIItemInfoPanel_Info_UIItem:RefreshCareer()
    local itemInfo = self.ItemInfo
    local bagItemInfo = self.BagItemInfo
    if self:GetCareerLabel_UILabel() and CS.StaticUtility.IsNull(self:GetCareerLabel_UILabel()) == false then
        self:GetCareerLabel_UILabel().text = self:GetCareerString(itemInfo)
    end
end

---刷新CD时间(该位置还有属性,如聚灵珠的经验值)
---CD时间及其他
---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
---@param itemInfo TABLE.CFG_ITEMS 背包物品表信息
function UIItemInfoPanel_Info_UIItem:RefreshCDTime(bagItemInfo, itemInfo)
    self:GetCDTimeLabel_UILabel().gameObject:SetActive(false)
    if bagItemInfo ~= nil then
        if itemInfo.type == luaEnumItemType.Assist and itemInfo.subType == 4 then
            local storateExp = bagItemInfo.luck
            local maxExp = bagItemInfo.maxStar
            local color = Utility.NewGetBBCode(storateExp >= maxExp)
            local showText = "储存经验" .. color .. storateExp .. "[-]/" .. maxExp
            self:GetCDTimeLabel_UILabel().text = showText
            self:GetCDTimeLabel_UILabel().gameObject:SetActive(true)
        end
    end
end

---展示按钮
function UIItemInfoPanel_Info_UIItem:RefreshShowButton()
    local itemInfo = self.ItemInfo
    local bagItemInfo = self.BagItemInfo
    if CS.StaticUtility.IsNull(self:GetShowBtn_GameObject()) == false and itemInfo then
        if CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(itemInfo.subType) ~= nil then
            if CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipType(itemInfo.subType).itemId == itemInfo.id then
                self:GetShowBtn_GameObject():SetActive(false)
            end
        end
        if itemInfo.sex ~= LuaEnumSex.Common then
            if Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) ~= itemInfo.sex then
                self:GetShowBtn_GameObject():SetActive(false)
            end
        end
        if itemInfo.career ~= LuaEnumCareer.Common then
            if Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) ~= itemInfo.career then
                self:GetShowBtn_GameObject():SetActive(false)
            end
        end
        if not Utility.IntToBool(itemInfo.isModelPreview) then
            self:GetShowBtn_GameObject():SetActive(false)
        end
        CS.UIEventListener.Get(self:GetShowBtn_GameObject()).onClick = function()
            --uimanager:CreatePanel("UIShowEquipPanel", nil, bagItemInfo, itemInfo)
        end
    end
end

---刷新品级
function UIItemInfoPanel_Info_UIItem:RefreshRank()
    ---@type TABLE.CFG_ITEMS
    local itemInfo = self.ItemInfo

    local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
    --判定预设是否存在
    if self:GetItemRank_UILabel() == nil or CS.StaticUtility.IsNull(self:GetItemRank_UILabel()) == true or itemInfo == nil or luaItemTable == nil then
        return
    end
    if (itemInfo.type ~= luaEnumItemType.Equip) then
        self:GetItemRank_UILabel().gameObject:SetActive(false)
        return
    end
    local luaTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
    if (luaTbl ~= nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetInlayEquipName(itemInfo.id)) then
        self:GetItemRank_UILabel().text = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetInlayEquipName(itemInfo.id)
        self:GetItemRank_UILabel().gameObject:SetActive(true)
    elseif CS.CSScene.MainPlayerInfo.EquipInfo:IsGem(itemInfo) then
        local gemLevel = Utility:GetGemLevel(itemInfo.id)
        local gemLevelDes = ""
        if type(gemLevel) == 'number' then
            gemLevelDes = CS.Utility_Lua.ArabicNumeralsToWordNumbers(gemLevel) .. "级"
        end
        self:GetItemRank_UILabel().text = Utility.LuaTryStringFormat("类型  %s佩饰", gemLevelDes)
        self:GetItemRank_UILabel().gameObject:SetActive(true)
    else
        if luaItemTable:GetItemLevel() ~= nil and (itemInfo.subType == 13 or itemInfo.subType == 15 or itemInfo.subType == 18 or itemInfo.subType == 21) then
            self:GetItemRank_UILabel().gameObject:SetActive(true)
            self:GetItemRank_UILabel().text = "品级 " .. tostring(luaItemTable:GetItemLevel()) .. "阶"
        else
            self:GetItemRank_UILabel().gameObject:SetActive(false)
        end
    end
end

---刷新重量
function UIItemInfoPanel_Info_UIItem:RefreshWeight()
    ---@type TABLE.CFG_ITEMS
    local itemInfo = self.ItemInfo
    local bagItemInfo = self.BagItemInfo
    if self:GetWeight_UILabel() and CS.StaticUtility.IsNull(self:GetWeight_UILabel()) == false then
        if itemInfo then
            --神力装备
            local isDivineSuit = clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id)
            if itemInfo.type == luaEnumItemType.Equip and not isDivineSuit then
                local luaTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id);
                if (luaTbl ~= nil and gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetInlayEquipName(itemInfo.id)) then
                    ---魂装
                    self:GetWeight_UILabel().text = gameMgr:GetPlayerDataMgr():GetLuaSoulEquipMgr():GetInlayEquipName(itemInfo.id)
                else
                    if itemInfo.weight ~= nil and itemInfo.weight ~= 0 then
                        self:GetWeight_UILabel().text = "重量 " .. tostring(itemInfo.weight)
                    elseif clientTableManager.cfg_itemsManager:IsMagicEquip(itemInfo.id) then
                        self:GetWeight_UILabel().text = itemInfo.tag
                    elseif CS.StaticUtility.IsNullOrEmpty(itemInfo.tag) == false then
                        self:GetWeight_UILabel().text = itemInfo.tag
                    else
                        self:GetWeight_UILabel().gameObject:SetActive(false)
                    end
                end

            elseif itemInfo.type == luaEnumItemType.HunJi then
                local hunjiSubType = itemInfo.subType
                if hunjiSubType == 0 then
                    self:GetWeight_UILabel().text = "类型  魂继 通用"
                elseif hunjiSubType == luaEnumServantType.HM then
                    self:GetWeight_UILabel().text = "类型  魂继 寒芒"
                elseif hunjiSubType == luaEnumServantType.LX then
                    self:GetWeight_UILabel().text = "类型  魂继 落星"
                elseif hunjiSubType == luaEnumServantType.TC then
                    self:GetWeight_UILabel().text = "类型  魂继 天成"
                end
            elseif itemInfo.type == luaEnumItemType.Collection then
                local linkEffectSubType = itemInfo.subType
                local tipName = clientTableManager.cfg_collectionManager:GetCollectionTypeStr(linkEffectSubType)
                if linkEffectSubType ~= nil and tipName ~= nil then
                    self:GetWeight_UILabel().text = Utility.CombineStringQuickly(Utility.GetItemType(itemInfo.type, itemInfo.subType), "    ",
                            CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality), tipName, "[-]")
                else
                    self:GetWeight_UILabel().text = Utility.GetItemType(itemInfo.type, itemInfo.subType)
                end
            else
                if itemInfo.tag ~= "" then
                    self:GetWeight_UILabel().text = itemInfo.tag
                else
                    self:GetWeight_UILabel().text = Utility.GetItemType(itemInfo.type, itemInfo.subType)
                end
            end
        end
    end
end

---刷新持久
function UIItemInfoPanel_Info_UIItem:RefreshLasting()
    ---@type TABLE.CFG_ITEMS
    local itemInfo = self.ItemInfo
    ---@type bagV2.BagItemInfo
    local bagItemInfo = self.BagItemInfo
    if itemInfo then
        --持久
        if self:GetNaijiu_UILabel() and CS.StaticUtility.IsNull(self:GetNaijiu_UILabel()) == false then
            local level = CS.CSScene.MainPlayerInfo.Level
            local reinLv = CS.CSScene.MainPlayerInfo.ReinLevel
            local levelColor = Utility.NewGetBBCode(level >= itemInfo.useLv)
            local reinLvColor = Utility.NewGetBBCode(reinLv >= itemInfo.reinLv)
            local levelCanUse = level >= itemInfo.useLv
            local reinLvCanUse = reinLv >= itemInfo.reinLv
            local canUseItem = clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id)
            if itemInfo then
                local isDivineEquip = clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id)
                ---兵鉴显示为tips2
                if CS.StaticUtility.IsNullOrEmpty(itemInfo.tips2) == false then
                    if gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsSLBingJian(itemInfo.id) then
                        self:GetNaijiu_UILabel().text = itemInfo.tips2
                        return
                    end
                end
                if itemInfo.type == luaEnumItemType.Equip and not isDivineEquip then
                    self:RefreshLasting_Equip(bagItemInfo, itemInfo)
                else
                    if itemInfo.type == luaEnumItemType.Material then
                        if itemInfo.subType == 8 then
                            -- 黑铁矿
                            local info = itemInfo.useParam.list[0]
                            if info ~= nil then
                                self:GetNaijiu_UILabel().text = levelColor .. '纯度 ' .. info .. ""
                            else
                                self:GetNaijiu_UILabel().text = levelColor .. '纯度 nil'
                            end
                        else
                            if not levelCanUse then
                                levelColor = ""
                                self:AddBlinkList(self:GetNaijiu_UILabel())
                            end
                            if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
                                self:GetNaijiu_UILabel().text = "无等级"
                            else
                                self:GetNaijiu_UILabel().text = levelColor .. itemInfo.useLv .. "[-]级可使用"
                            end
                        end
                    elseif itemInfo.type == luaEnumItemType.SkillBook then
                        if not levelCanUse then
                            levelColor = ""
                            self:AddBlinkList(self:GetNaijiu_UILabel())
                        end
                        if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
                            self:GetNaijiu_UILabel().text = "无等级"
                        else
                            self:GetNaijiu_UILabel().text = levelColor .. itemInfo.useLv .. "[-]级可学习"
                        end
                    elseif itemInfo.type == luaEnumItemType.Element then
                        local elementInfoIsFind, elementInfo = CS.Cfg_ElementTableManager.Instance.dic:TryGetValue(itemInfo.id)
                        if elementInfoIsFind and bagItemInfo ~= nil then
                            local canUse = Utility.GetArrowType(bagItemInfo) ~= LuaEnumArrowType.YellowArrow
                            local textContent = CS.Cfg_ElementTableManager.Instance:GetElementUseCondition(itemInfo.id)
                            if not canUse then
                                reinLvColor = ""
                                self:AddBlinkList(self:GetNaijiu_UILabel())
                            end
                            self:GetWeight_UILabel().text = self:ElementLevel(itemInfo, elementInfo)
                            self:GetNaijiu_UILabel().text = reinLvColor .. textContent
                        else
                            self:GetNaijiu_UILabel().text = ""
                        end
                    elseif itemInfo.type == luaEnumItemType.Signet then
                        self:GetWeight_UILabel().text = self:SignetLevel(itemInfo)
                        self:GetNaijiu_UILabel().text = self:SignetNeedLevel(itemInfo, bagItemInfo)
                    elseif itemInfo.type == luaEnumItemType.Collection then
                        self:GetNaijiu_UILabel().text = "稀有度 " .. luaclass.LuaCollectionInfo.GetRarenessOfCollection(bagItemInfo)
                    elseif itemInfo.type == luaEnumItemType.HunJi then
                        local isAbleToEquipInMainPlayerServant = true
                        if bagItemInfo == nil then
                            isAbleToEquipInMainPlayerServant = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiAvailableToEquipInAnySeat(itemInfo)
                        else
                            ---根据灵兽位是否能够装备该魂继来决定字的颜色
                            ---@type UIServantPanel
                            local servantPanel = uimanager:GetPanel("UIServantPanel")
                            if servantPanel ~= nil then
                                local currentSelectedServantIndex = 0
                                if servantPanel.ServantIndex == 0 then
                                    ---灵兽界面当前选中寒芒位
                                    currentSelectedServantIndex = 1
                                elseif servantPanel.ServantIndex == 1 then
                                    ---灵兽界面当前选中落星位
                                    currentSelectedServantIndex = 2
                                elseif servantPanel.ServantIndex == 2 then
                                    ---灵兽界面当前选中天成位
                                    currentSelectedServantIndex = 3
                                end
                                if currentSelectedServantIndex ~= 0 then
                                    ---@type CSServantSeatData_MainPlayer
                                    local servantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(currentSelectedServantIndex)
                                    isAbleToEquipInMainPlayerServant = servantData:IsHunJiAvailableToForSeat(bagItemInfo)
                                else
                                    isAbleToEquipInMainPlayerServant = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiAvailableToForSeat(bagItemInfo)
                                end
                            else
                                isAbleToEquipInMainPlayerServant = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiAvailableToEquipInAnySeat(bagItemInfo)
                            end
                        end
                        local textStr = isAbleToEquipInMainPlayerServant and "" or "[ff0000]"
                        if itemInfo.reinLv > 0 then
                            textStr = textStr .. "需要灵兽转生  " .. tostring(itemInfo.reinLv)
                        elseif itemInfo.useLv > 0 then
                            textStr = textStr .. "需要灵兽等级  " .. tostring(itemInfo.useLv)
                        end
                        --self:GetNaijiu_UILabel().text = textStr
                        self:GetNaijiu_UILabel().text = ""
                    elseif CS.CSScene.MainPlayerInfo.EquipInfo:IsGem(itemInfo) then
                        local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
                        if luaItemTable:GetItemLevel() ~= nil then
                            self:GetNaijiu_UILabel().text = "品级 " .. tostring(luaItemTable:GetItemLevel()) .. "阶"
                        end
                    elseif isDivineEquip then
                        local luaItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
                        if luaItemTable then
                            local divineData = clientTableManager.cfg_divinesuitManager:TryGetValue(luaItemTable:GetDivineId())
                            if divineData then
                                self:GetNaijiu_UILabel().text = Utility.CombineStringQuickly('品阶 ', divineData:GetLevel(), "阶")
                            end
                        end
                    else
                        if not levelCanUse then
                            levelColor = ""
                            self:AddBlinkList(self:GetNaijiu_UILabel())
                        end
                        if itemInfo.useLv == 0 and itemInfo.reinLv == 0 then
                            self:GetNaijiu_UILabel().text = "无等级"
                        else
                            if (itemInfo.type == luaEnumItemType.Coin) then
                                self:GetNaijiu_UILabel().gameObject:SetActive(false)
                            else
                                self:GetNaijiu_UILabel().gameObject:SetActive(true)
                                if itemInfo.useLv > 0 then
                                    self:GetNaijiu_UILabel().text = levelColor .. itemInfo.useLv .. "[-]级可使用"
                                elseif itemInfo.reinLv > 0 then
                                    self:GetNaijiu_UILabel().text = levelColor .. itemInfo.reinLv .. "[-]转可使用"
                                end
                            end
                        end
                        --self:GetNaijiu_UILabel().text = ""
                    end
                end
            end
        end
    else
        self:GetNaijiu_UILabel().gameObject:SetActive(false)
    end
end

---刷新装备类型耐久显示
function UIItemInfoPanel_Info_UIItem:RefreshLasting_Equip(bagItemInfo, itemInfo)
    if itemInfo then
        local isHuFu = clientTableManager.cfg_itemsManager:IsHuFuEquip(itemInfo.id)
        if isHuFu then
            local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemInfo.id)
            if luaItemInfo and luaItemInfo:GetItemLevel() then
                self:GetWeight_UILabel().text = string.format("品级 %s阶", luaItemInfo:GetItemLevel())
                self:GetWeight_UILabel().gameObject:SetActive(true)
            end
            self:GetNaijiu_UILabel().gameObject:SetActive(false)
            return
        end
        local anqiTable = clientTableManager.cfg_hidden_weaponManager:TryGetValue(itemInfo.id)
        if anqiTable then
            self:GetWeight_UILabel().text = string.format("品级 %s阶", anqiTable:GetStage())
            self:GetWeight_UILabel().gameObject:SetActive(true)
        end
        local mapai = clientTableManager.cfg_horse_cardManager:TryGetValue(itemInfo.id)
        if mapai then
            self:GetWeight_UILabel().text = string.format("品级 %s阶", mapai:GetStage())
            self:GetWeight_UILabel().gameObject:SetActive(true)
        end
    end
    if bagItemInfo then
        local itemInfoNaiJiu = bagItemInfo.currentLasting
        local NaiJiuValue = ""
        if itemInfoNaiJiu >= -10 then
            if (itemInfo.maxLasting > 0) then
                local currentLastingMaxValue = CS.Cfg_GlobalTableManager.Instance:GetCurrentLastingMax()
                NaiJiuValue = Utility.NewGetBBCode(bagItemInfo.currentLasting > currentLastingMaxValue) .. tostring(bagItemInfo.currentLasting) .. "[-]" .. " / " .. tostring(itemInfo.maxLasting)
            else
                NaiJiuValue = tostring(bagItemInfo.currentLasting) .. " / --"
            end
        else
            NaiJiuValue = "永不损坏"
        end
        local naijiuState = ternary(itemInfo.isWastageLasting < 0 or bagItemInfo.currentLasting <= -9999, false, true)
        self:GetNaijiu_UILabel().gameObject:SetActive(naijiuState)
        self:GetNaijiu_UILabel().text = "持久  " .. NaiJiuValue
    else
        self:GetNaijiu_UILabel().gameObject:SetActive(false)
    end
end

function UIItemInfoPanel_Info_UIItem:SignetNeedLevel(itemInfo, bagItemInfo)
    local color = ''
    local colorIndex = 0;
    if itemInfo ~= nil and itemInfo.career == Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) then
        colorIndex = CS.CSScene.MainPlayerInfo.SignetV2:SignetUseType(bagItemInfo);
    else
        colorIndex = 0
    end
    if colorIndex == 0 or colorIndex == -1 then
        color = '[ffffff]'
    else
        color = '[ff0000]'
    end
    if itemInfo.reinLv == 0 and itemInfo.useLv ~= 0 then
        return color .. "需要装备等级" .. itemInfo.useLv .. "级"
    elseif itemInfo.useLv == 0 and itemInfo.reinLv ~= 0 then
        return color .. "需要装备转生等级" .. itemInfo.reinLv .. "级"
    elseif itemInfo.useLv ~= 0 and itemInfo.reinLv ~= 0 then
        return color .. "需要装备" .. itemInfo.useLv .. "级或转生" .. itemInfo.reinLv .. "级"
    else
        return color .. ""
    end
end

function UIItemInfoPanel_Info_UIItem:SignetLevel(itemInfo)
    if itemInfo == nil or itemInfo.useParam == nil or itemInfo.useParam.list.Count < 2 then
        return ''
    end
    local level = CS.Utility_Lua.ArabicNumeralsToWordNumbers(itemInfo.useParam.list[1])
    local color = CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality)
    return "Lv" .. itemInfo.useParam.list[1]
end

function UIItemInfoPanel_Info_UIItem:ElementLevel(itemInfo, elementInfo)
    local level = CS.Utility_Lua.ArabicNumeralsToWordNumbers(elementInfo.quality)
    local color = CS.Utility_Lua.GetItemColorByQualityValue(itemInfo.quality)
    return "Lv" .. elementInfo.quality
end

---刷新强化等级
function UIItemInfoPanel_Info_UIItem:RefreshStrengthenInfo()
    if CS.StaticUtility.IsNull(self:GetintensifyNum_UILabel()) == false then
        local isShow = self.BagItemInfo and self.BagItemInfo.intensify > 0
        if isShow then
            local showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
            self:GetintensifyNum_UILabel().text = showInfo
            self:GetIntensifyStar_UISprite().spriteName = icon
        end

        self:GetintensifyNum_UILabel().gameObject:SetActive(isShow)
        self:GetIntensifyStar_UISprite().gameObject:SetActive(isShow)
    end
end

---刷新效果削减文本
function UIItemInfoPanel_Info_UIItem:RefreshWeakenWarning()
    if self.BagItemInfo and self:GetWeakenWarning_UILabel() ~= nil then
        local naijiu = self.BagItemInfo.currentLasting
        local text = CS.Cfg_GlobalTableManager.Instance:GetWeakenWarningText(self.BagItemInfo)
        if self.BagItemInfo ~= nil and self.ItemInfo ~= nil and self.ItemInfo.type == luaEnumItemType.Equip and self.ItemInfo.subType == LuaEnumEquipSubType.Equip_seal then
            text = luaEnumColorType.Red .. "已失效"
        end
        self:GetWeakenWarning_UILabel().text = text
        self:GetWeakenWarning_UILabel().gameObject:SetActive(self.ItemInfo.type == luaEnumItemType.Equip and naijiu <= 0 and naijiu > -9999)
    end
end

---刷新可交易状态
function UIItemInfoPanel_Info_UIItem:RefreshTrade()
    if self:GetCanDeal() == nil then
        return
    end
    if self.showAction == nil or self.showAction == false or self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL then
        self:GetCanDeal().gameObject:SetActive(false)
        return
    end
    if self.BagItemInfo ~= nil then
        if self.BagItemInfo.index ~= 0 then
            self:GetCanDeal_TweenPosition():PlayForward()
        else
            self:GetCanDeal_TweenPosition():PlayReverse()
        end
        local isBind = not self.IsNeedShowBind -- self.BagItemInfo.canTrade == 1 and not self.IsNeedShowBind
        self:GetCanDeal().gameObject:SetActive(isBind)
        self:GetCanDeal().text = "可交易"
        --self.IsNeedShowBindTwoParamet == 1 and "交易后绑定" or "可交易"
    end
end

---刷新推送
function UIItemInfoPanel_Info_UIItem:RefreshRecommend()
    if CS.StaticUtility.IsNull(self:GetRecommend_GameObject()) == true then
        return
    end
    if self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
        local uiRefineResultPanel = uimanager:GetPanel("UIRefineResultPanel")
        if uiRefineResultPanel ~= nil and uiRefineResultPanel.allBagItemInfos ~= nil and #uiRefineResultPanel.allBagItemInfos > 0 then
            self:GetRecommend_GameObject():SetActive(uiRefineResultPanel:IsBetterBagItemInfo(self.BagItemInfo) and uiRefineResultPanel:GetArrowAttributeType() ~= CS.BetterAttributeReason.Null)
        end
    end
end

---刷新绑定
function UIItemInfoPanel_Info_UIItem:RefreshBind()
    if self:GetBind_TweenPosition() == nil then
        return
    end
    if self.showBind == nil or self.showBind == false then
        self:GetBind_TweenPosition().gameObject:SetActive(false)
        return
    end
    if self.ItemInfo ~= nil then
        if self.BagItemInfo ~= nil and self.BagItemInfo.index ~= 0 then
            self:GetBind_TweenPosition():PlayForward()
        else
            self:GetBind_TweenPosition():PlayReverse()
        end
        self:GetBind_TweenPosition().gameObject:SetActive(self.IsNeedShowBind)
    end
end

--region 辅助函数
---获取等级字符串
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_UIItem:GetLevelString(itemInfo)
    if itemInfo then
        return Utility.GetBBCode(clientTableManager.cfg_itemsManager:MainPlayerCanUseItem(itemInfo.id) == LuaEnumUseItemParam.CanUse)
                .. ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv) .. "转", tostring(itemInfo.useLv) .. "级")
        --return Utility.GetBBCode((CS.CSScene.MainPlayerInfo.Level >= itemInfo.useLv) and (CS.CSScene.MainPlayerInfo.ReinLevel >= itemInfo.reinLv))
        --.. ternary(itemInfo.reinLv > 0, tostring(itemInfo.reinLv) .. "转", tostring(itemInfo.useLv) .. "级")
    else
        return ""
    end
end

---获取性别字符串
---@param itemInfo TABLE.CFG_ITEMS
function UIItemInfoPanel_Info_UIItem:GetSexString(itemInfo)
    if itemInfo then
        if itemInfo.sex == LuaEnumSex.Man then
            return Utility.GetBBCode((Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == itemInfo.sex) or (itemInfo.sex == LuaEnumSex.Common))
                    .. "男"
        elseif itemInfo.sex == LuaEnumSex.WoMan then
            return Utility.GetBBCode((Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == itemInfo.sex) or (itemInfo.sex == LuaEnumSex.Common))
                    .. "女"
        elseif itemInfo.sex == LuaEnumSex.Common then
            return Utility.GetBBCode((Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == itemInfo.sex) or (itemInfo.sex == LuaEnumSex.Common))
                    .. "通用"
        end
    end
    return ""
end

---获取职业字符串
---@param itemInfo TABLE.CFG_ITEMS 物品信息类型
---@return string 返回职业信息字符串,职业是否与主角角色匹配决定了职业的表现颜色
function UIItemInfoPanel_Info_UIItem:GetCareerString(itemInfo)
    if itemInfo then
        return Utility.GetBBCode((Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) == itemInfo.career) or (itemInfo.career == LuaEnumCareer.Common))
                .. CS.Utility.GetCareerName(itemInfo.career)
    else
        return ""
    end
end
--endregion

return UIItemInfoPanel_Info_UIItem