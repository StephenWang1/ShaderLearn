---@class UIRefinePanel:UIBase
local UIRefinePanel = {};

UIRefinePanel.mSelectType = nil;

UIRefinePanel.mFirstChooseBagItemInfo = nil;

UIRefinePanel.mSecondChooseBagItemInfo = nil;

UIRefinePanel.mMainChooseBagItemInfo = nil;

UIRefinePanel.mIsClickedRefine = false;

UIRefinePanel.mServantPos = 0;

---@return CSMainPlayerInfo 玩家信息
function UIRefinePanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---@return CSBagInfoV2 背包
function UIRefinePanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetPlayerInfo() then
        self.mBagInfoV2 = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

--region Components

function UIRefinePanel:GetTglBag_UIToggle()
    if (self.mTglBag_UIToggle == nil) then
        self.mTglBag_UIToggle = self:GetCurComp("WidgetRoot/events/btn_bag", "UIToggle")
    end
    return self.mTglBag_UIToggle;
end

function UIRefinePanel:GetTglRole_UIToggle()
    if (self.mTglRole_UIToggle == nil) then
        self.mTglRole_UIToggle = self:GetCurComp("WidgetRoot/events/btn_role", "UIToggle");
    end
    return self.mTglRole_UIToggle;
end

function UIRefinePanel:GetTglServant_UIToggle()
    if (self.mTglServant_UIToggle == nil) then
        self.mTglServant_UIToggle = self:GetCurComp("WidgetRoot/events/btn_yuanling", "UIToggle");
    end
    return self.mTglServant_UIToggle;
end

function UIRefinePanel:GetBtnRefine_GameObject()
    if (self.mBtnRefine_GameObject == nil) then
        self.mBtnRefine_GameObject = self:GetCurComp("WidgetRoot/events/btn_refine", "GameObject");
    end
    return self.mBtnRefine_GameObject;
end

function UIRefinePanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

function UIRefinePanel:GetOriginEquip_GameObject()
    if (self.mOriginEquip_GameObject == nil) then
        self.mOriginEquip_GameObject = self:GetCurComp("WidgetRoot/view/OriginEquip", "GameObject");
    end
    return self.mOriginEquip_GameObject;
end

function UIRefinePanel:GetAimEquip_GameObject()
    if (self.mAimEquip_GameObject == nil) then
        self.mAimEquip_GameObject = self:GetCurComp("WidgetRoot/view/AimEquip", "GameObject")
    end
    return self.mAimEquip_GameObject;
end

function UIRefinePanel:GetOriginEquipAdd_GameObject()
    if (self.mOriginEquipAdd_GameObject == nil) then
        self.mOriginEquipAdd_GameObject = self:GetCurComp("WidgetRoot/view/OriginEquip/Add", "GameObject");
    end
    return self.mOriginEquipAdd_GameObject;
end

function UIRefinePanel:GetAimEquipEquipAdd_GameObject()
    if (self.mAimEquipEquipAdd_GameObject == nil) then
        self.mAimEquipEquipAdd_GameObject = self:GetCurComp("WidgetRoot/view/AimEquip/Add", "GameObject");
    end
    return self.mAimEquipEquipAdd_GameObject;
end

function UIRefinePanel:GetBtnHelp_GameObject()
    if (self.mBtnHelp_GameObject == nil) then
        self.mBtnHelp_GameObject = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject");
    end
    return self.mBtnHelp_GameObject;
end

function UIRefinePanel:GetNotHasRefine_GameObject()
    if (self.mNotHasRefine_GameObject == nil) then
        self.mNotHasRefine_GameObject = self:GetCurComp("WidgetRoot/view/NoRefine", "GameObject");
    end
    return self.mNotHasRefine_GameObject;
end

function UIRefinePanel:GetNotSelectRefine_GameObject()
    if (self.mNotSelectRefine_GameObject == nil) then
        self.mNotSelectRefine_GameObject = self:GetCurComp("WidgetRoot/view/NotHasRefineItem", "GameObject");
    end
    return self.mNotSelectRefine_GameObject;
end

function UIRefinePanel:GetNotEnoughRefine_GameObject()
    if (self.mNotEnoughRefine_GameObject == nil) then
        self.mNotEnoughRefine_GameObject = self:GetCurComp("WidgetRoot/view/NotEnoughRefineItem", "GameObject");
    end
    return self.mNotEnoughRefine_GameObject;
end

function UIRefinePanel:GetSecondItemName_GameObject()
    if (self.mSecondItemName_GameObject == nil) then
        self.mSecondItemName_GameObject = self:GetCurComp("WidgetRoot/view/lb2", "GameObject");
    end
    return self.mSecondItemName_GameObject;
end

function UIRefinePanel:GetSecondReplaceItemBtnGetWay_GameObject()
    if (self.mSecondReplaceItemBtnGetWay_GameObject == nil) then
        self.mSecondReplaceItemBtnGetWay_GameObject = self:GetCurComp("WidgetRoot/view/AimEquip/Add2", "GameObject");
    end
    return self.mSecondReplaceItemBtnGetWay_GameObject;
end

function UIRefinePanel:GetOriginEquip_UIItem()
    if (self.mOriginEquip_UIItem == nil) then
        self.mOriginEquip_UIItem = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/OriginEquip/Item", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mOriginEquip_UIItem;
end

function UIRefinePanel:GetAimEquip_UIItem()
    if (self.mAimEquip_UIItem == nil) then
        self.mAimEquip_UIItem = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/view/AimEquip/Item", "GameObject"), luaComponentTemplates.UIItem);
    end
    return self.mAimEquip_UIItem;
end

function UIRefinePanel:GetRefineStateLabel_Text()
    if (self.mRefineStateLabel_Text == nil) then
        self.mRefineStateLabel_Text = self:GetCurComp("WidgetRoot/view/Unfinish/Label", "UILabel");
    end
    return self.mRefineStateLabel_Text;
end

function UIRefinePanel:GetRefineTargetName_Text()
    if (self.mRefineTargetName_Text == nil) then
        self.mRefineTargetName_Text = self:GetCurComp("WidgetRoot/view/text", "UILabel");
    end
    return self.mRefineTargetName_Text;
end

function UIRefinePanel:GetSecondReplaceItemCount_Text()
    if (self.mSecondReplaceItemCount_Text == nil) then
        self.mSecondReplaceItemCount_Text = self:GetCurComp("WidgetRoot/view/AimEquip/num", "UILabel");
    end
    return self.mSecondReplaceItemCount_Text;
end

function UIRefinePanel:GetRefineReplace_Text()
    if (self.mRefineReplace_Text == nil) then
        self.mRefineReplace_Text = self:GetCurComp("WidgetRoot/view/refineReplaceText", "UILabel");
    end
    return self.mRefineReplace_Text
end

function UIRefinePanel:GetFirstItemAttributeUnitGridContainer()
    if (self.mFirstItemAttributeUnitGridContainer == nil) then
        self.mFirstItemAttributeUnitGridContainer = self:GetCurComp("WidgetRoot/view/Finish/item1/Attr", "UIGridContainer");
    end
    return self.mFirstItemAttributeUnitGridContainer;
end

function UIRefinePanel:GetSecondItemAttributeUnitGridContainer()
    if (self.mSecondItemAttributeUnitGridContainer == nil) then
        self.mSecondItemAttributeUnitGridContainer = self:GetCurComp("WidgetRoot/view/Finish/item2/Attr", "UIGridContainer");
    end
    return self.mSecondItemAttributeUnitGridContainer;
end

--endregion

--region Method

--region Public

function UIRefinePanel:GetShowAttributeTypes()
    if (self.mShowAttributeTypes == nil) then
        self.mShowAttributeTypes = {};
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.PhyDefenceMin, secondType = CS.AttributeType.PhyDefenceMax });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.MagicDefenceMin, secondType = CS.AttributeType.MagicDefenceMax });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.PhyAttackMin, secondType = CS.AttributeType.PhyAttackMax });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.MagicAttackMin, secondType = CS.AttributeType.MagicAttackMax });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.TaoAttackMin, secondType = CS.AttributeType.TaoAttackMax });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.HolyAttackMin, secondType = CS.AttributeType.HolyAttack });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.HolyDefenceMin, secondType = CS.AttributeType.HolyDefence });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.Accurate, secondType = CS.AttributeType.Accurate });
        table.insert(self.mShowAttributeTypes, { firstType = CS.AttributeType.Dodge, secondType = CS.AttributeType.Dodge });
    end
    return self.mShowAttributeTypes;
end

---@return bagV2.BagItemInfo
function UIRefinePanel:GetFirstChooseBagItemInfo()
    return self.mFirstChooseBagItemInfo;
end

---@return bagV2.BagItemInfo
function UIRefinePanel:GetSecondChooseBagItemInfo()
    return self.mSecondChooseBagItemInfo;
end

function UIRefinePanel:GetMainChooseBagItemInfo()
    return self.mMainChooseBagItemInfo;
end

function UIRefinePanel:UpdateOtherUI()
    local hasFirst = self:GetFirstChooseBagItemInfo() ~= nil;
    local hasSecond = self:GetSecondChooseBagItemInfo() ~= nil;

    if (not hasFirst and not hasSecond) then
        self:GetNotSelectRefine_GameObject():SetActive(true);
        self:GetNotEnoughRefine_GameObject():SetActive(false);
        --self:GetRefineStateLabel_Text().text = "选择要炼化的装备";
    elseif (not hasFirst or not hasSecond) then
        self:GetNotSelectRefine_GameObject():SetActive(false);
        self:GetNotEnoughRefine_GameObject():SetActive(true);
        --self:GetRefineStateLabel_Text().text = "请放入一件相同装备";
    else
        self:GetNotSelectRefine_GameObject():SetActive(false);
        self:GetNotEnoughRefine_GameObject():SetActive(false);
    end

    local notHasRefine = false;
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        notHasRefine = not CS.CSScene.MainPlayerInfo.BagInfo:HasRefineBagItemInfo();
    else
        notHasRefine = true;
    end
    --self:GetNotHasRefine_GameObject():SetActive(notHasRefine);
    self:GetBtnRefine_GameObject():SetActive(not notHasRefine);
    self:GetRefineStateLabel_Text().gameObject:SetActive(not notHasRefine);
    self:GetBtnRefine_GameObject():SetActive(hasFirst and hasSecond);
    local refineTargetName = ""
    if (self:GetFirstChooseBagItemInfo() ~= nil) then
        refineTargetName = "正在精炼" .. self:GetFirstChooseBagItemInfo().ItemFullName;
    elseif (self:GetSecondChooseBagItemInfo() ~= nil and CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self:GetSecondChooseBagItemInfo().itemId)) then
        refineTargetName = "正在精炼" .. self:GetSecondChooseBagItemInfo().ItemFullName;
    end
    self:GetRefineTargetName_Text().text = refineTargetName;

    ---第二个材料是否是替代材料(炼化石之类的)
    self:GetSecondReplaceItemCount_Text().gameObject:SetActive(false);
    self:GetSecondReplaceItemBtnGetWay_GameObject():SetActive(false);
    self:GetSecondItemName_GameObject():SetActive(true);
    self:GetRefineReplace_Text().gameObject:SetActive(false);
    if (self:GetSecondChooseBagItemInfo() ~= nil) then
        local isSecondReplace = not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self:GetSecondChooseBagItemInfo().itemId);
        if (isSecondReplace) then
            if (self:GetMainChooseBagItemInfo() ~= nil) then
                local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
                if (replaceItemId ~= 0 and replaceItemId == self:GetSecondChooseBagItemInfo().itemId) then
                    self:GetSecondReplaceItemCount_Text().gameObject:SetActive(true);
                    self:GetSecondReplaceItemBtnGetWay_GameObject():SetActive(true);
                    self:GetSecondItemName_GameObject():SetActive(false);
                    local mCount = 0;
                    if (CS.CSMainPlayerInfo ~= nil) then
                        mCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(replaceItemId);
                    end
                    local isEnough = mCount >= count;
                    local colorString = isEnough and luaEnumColorType.Green or luaEnumColorType.Red;
                    self:GetSecondReplaceItemCount_Text().text = colorString .. mCount .. "[-]/" .. count;
                end
            end
            self:GetRefineReplace_Text().gameObject:SetActive(true);
            local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22520);
            if (globalTable ~= nil) then
                self:GetRefineReplace_Text().text = globalTable.value;
            end
        end
    end
end

function UIRefinePanel:TrySetFirstBagItemInfo(bagItemInfo)
    if (bagItemInfo == nil) then
        luaEventManager.DoCallback(LuaCEvent.Refine_OnClearFirstBagItem, self.mFirstChooseBagItemInfo);
        self.mFirstChooseBagItemInfo = nil;
        self:TrySetMainChooseBagItemInfo(nil);
        self:UpdateFirstBagItem();
        return true;
    else
        if (not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
            return false;
        end

        local secondBagItemInfo = self:GetSecondChooseBagItemInfo();
        if (secondBagItemInfo ~= nil) then
            local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(bagItemInfo.itemId);
            if (secondBagItemInfo.lid ~= bagItemInfo.lid and (secondBagItemInfo.itemId == bagItemInfo.itemId or replaceItemId == secondBagItemInfo.itemId)) then
                self.mFirstChooseBagItemInfo = bagItemInfo;
                if (secondBagItemInfo.itemId == replaceItemId) then
                    self:TrySetMainChooseBagItemInfo(self.mFirstChooseBagItemInfo);
                end
                luaEventManager.DoCallback(LuaCEvent.Refine_OnFirstBagItemChange);
                self:UpdateFirstBagItem();
                return true;
            end
        else
            self.mFirstChooseBagItemInfo = bagItemInfo;
            self:TrySetMainChooseBagItemInfo(self.mFirstChooseBagItemInfo);
            luaEventManager.DoCallback(LuaCEvent.Refine_OnFirstBagItemChange);
            self:UpdateFirstBagItem();
            return true;
        end
    end
    return false;
end

function UIRefinePanel:TrySetSecondBagItemInfo(bagItemInfo)
    if (bagItemInfo ~= nil) then
        if (not CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
            if (self:GetMainChooseBagItemInfo() ~= nil) then
                local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(self:GetMainChooseBagItemInfo().itemId);
                if not (replaceItemId ~= 0 or replaceItemId ~= bagItemInfo.itemId) then
                    return false;
                end
            end
        end

        local firstBagItemInfo = self:GetFirstChooseBagItemInfo();
        if (firstBagItemInfo ~= nil) then
            local replaceItemId, count = CS.Cfg_ItemsFloatTableManager.Instance:GetRefineReplaceItem(firstBagItemInfo.itemId);
            if (firstBagItemInfo.lid ~= bagItemInfo.lid and (firstBagItemInfo.itemId == bagItemInfo.itemId or replaceItemId == bagItemInfo.itemId)) then
                self.mSecondChooseBagItemInfo = bagItemInfo;
                luaEventManager.DoCallback(LuaCEvent.Refine_OnSecondBagItemChange);
                self:UpdateSecondBagItem();
                return true;
            end
        else
            self.mSecondChooseBagItemInfo = bagItemInfo;
            self:TrySetMainChooseBagItemInfo(self.mFirstChooseBagItemInfo);
            luaEventManager.DoCallback(LuaCEvent.Refine_OnSecondBagItemChange);
            self:UpdateSecondBagItem();
            return true;
        end
    else
        luaEventManager.DoCallback(LuaCEvent.Refine_OnClearSecondBagItem, self.mSecondChooseBagItemInfo);
        self.mSecondChooseBagItemInfo = nil;
        self:TrySetMainChooseBagItemInfo(nil);
        self:UpdateSecondBagItem();
        return true;
    end
    return false;
end

function UIRefinePanel:TrySetBagItemInfo(bagItemInfo)
    if (bagItemInfo ~= nil) then
        if (self.mFirstChooseBagItemInfo == nil) then
            return self:TrySetFirstBagItemInfo(bagItemInfo);
        else
            return self:TrySetSecondBagItemInfo(bagItemInfo);
        end
    end
    return false;
end

function UIRefinePanel:TrySetMainChooseBagItemInfo(bagItemInfo)
    local isSuccess = false;
    if (bagItemInfo == nil) then
        if (self:GetFirstChooseBagItemInfo() ~= nil) then
            if (CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self:GetFirstChooseBagItemInfo().itemId)) then
                self.mMainChooseBagItemInfo = self:GetFirstChooseBagItemInfo();
                isSuccess = true;
            end
        elseif (self:GetSecondChooseBagItemInfo() ~= nil) then
            if (CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(self:GetSecondChooseBagItemInfo().itemId)) then
                self.mMainChooseBagItemInfo = self:GetSecondChooseBagItemInfo();
                isSuccess = true;
            end
        end
        if (not isSuccess) then
            self.mMainChooseBagItemInfo = nil;
            isSuccess = true;
        end
    else
        if (self.mMainChooseBagItemInfo == nil) then
            if (CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(bagItemInfo.itemId)) then
                self.mMainChooseBagItemInfo = bagItemInfo;
            end
            isSuccess = true;
        end
    end

    if (isSuccess) then
        local bagPanel = uimanager:GetPanel("UIBagPanel");
        if (bagPanel ~= nil) then
            bagPanel:RefreshGrids();
        end
    end

    return isSuccess;
end

function UIRefinePanel:SetLeftPanel(type)
    if (UIRefinePanel.mSelectType ~= type) then
        UIRefinePanel.mSelectType = type;
        UIRefinePanel.mDelayFrameCount = 8;
    end
end

function update()
    if (UIRefinePanel.mDelayFrameCount ~= nil and UIRefinePanel.mDelayFrameCount > 0) then
        UIRefinePanel.mDelayFrameCount = UIRefinePanel.mDelayFrameCount - 1;
        if (UIRefinePanel.mDelayFrameCount <= 0) then
            if (UIRefinePanel.mSelectType == LuaEnumRefineLeftPanelType.RoleEquip) then
                UIRefinePanel:GetTglRole_UIToggle().value = true;
                uimanager:ClosePanel("UIBagPanel");
                uimanager:ClosePanel("UIServantPanel");
                uimanager:CreatePanel("UIRolePanel", function(panel)
                    if (not CS.StaticUtility.IsNull(UIRefinePanel.go)) then
                        panel:ShowCloseButton(false);
                        panel:SetSLToggle(false)
                        if (UIRefinePanel:GetFirstChooseBagItemInfo() ~= nil) then
                            panel:SetItemChoose(UIRefinePanel:GetFirstChooseBagItemInfo());
                        end
                        if (UIRefinePanel:GetSecondChooseBagItemInfo() ~= nil) then
                            panel:SetItemChoose(UIRefinePanel:GetSecondChooseBagItemInfo());
                        end
                    end
                end, { equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateRefine, equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateRefine });
            elseif (UIRefinePanel.mSelectType == LuaEnumRefineLeftPanelType.Bag) then
                uimanager:ClosePanel("UIRolePanel");
                uimanager:ClosePanel("UIServantPanel");
                uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Refine });
                UIRefinePanel:GetTglBag_UIToggle().value = true;
            elseif (UIRefinePanel.mSelectType == LuaEnumRefineLeftPanelType.Servant) then
                uimanager:ClosePanel("UIBagPanel");
                uimanager:ClosePanel("UIRolePanel");
                local customData = {}
                customData.BaseTemplate = luaComponentTemplates.UIServantPanel_Base_Refine;
                customData.openServantPanelType = LuaEnumPanelOpenSourceType.ByRefine;
                customData.topOpenType = LuaEnumServantPanelType.BasePanel;
                customData.pos = UIRefinePanel.mServantPos
                uimanager:CreatePanel("UIServantPanel", nil, customData);
                UIRefinePanel:GetTglServant_UIToggle().value = true;
            end
        end
    end
end

function UIRefinePanel:UpdateFirstBagItem()
    if (self.mFirstAttributeUnitDic == nil) then
        self.mFirstAttributeUnitDic = {};
    end
    local gridContainer = self:GetFirstItemAttributeUnitGridContainer();
    if (self:GetFirstChooseBagItemInfo() ~= nil) then
        local itemId = self:GetFirstChooseBagItemInfo().itemId;
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind) then
            self:GetOriginEquip_UIItem():RefreshUIWithItemInfo(itemTable);
            local showTexts = self:GetAttributeShowTexts(self:GetFirstChooseBagItemInfo());
            if (showTexts ~= nil) then
                gridContainer.MaxCount = #showTexts;
                local index = 0;
                for k, v in pairs(showTexts) do
                    local gobj = gridContainer.controlList[index];
                    if (self.mFirstAttributeUnitDic[gobj] == nil) then
                        self.mFirstAttributeUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIRefineItemAttributeUnitTemplate);
                    end
                    self.mFirstAttributeUnitDic[gobj]:UpdateUnit(v.nameString, v.valueString);
                    index = index + 1;
                end
            end
        end
    else
        self:GetOriginEquip_UIItem():ResetUI();
        gridContainer.MaxCount = 0;
    end
    self:GetOriginEquipAdd_GameObject():SetActive(self:GetFirstChooseBagItemInfo() == nil);
    self:GetFirstItemAttributeUnitGridContainer().transform.parent.gameObject:SetActive(self:GetFirstChooseBagItemInfo() ~= nil);
    self:UpdateOtherUI();
end

function UIRefinePanel:UpdateSecondBagItem()
    if (self.mSecondAttributeUnitDic == nil) then
        self.mSecondAttributeUnitDic = {};
    end
    local gridContainer = self:GetSecondItemAttributeUnitGridContainer();
    if (self:GetSecondChooseBagItemInfo() ~= nil) then
        local itemId = self:GetSecondChooseBagItemInfo().itemId;
        local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFind) then
            self:GetAimEquip_UIItem():RefreshUIWithItemInfo(itemTable);
            local showTexts = self:GetAttributeShowTexts(self:GetSecondChooseBagItemInfo());
            if (showTexts ~= nil) then
                gridContainer.MaxCount = #showTexts;
                local index = 0;
                for k, v in pairs(showTexts) do
                    local gobj = gridContainer.controlList[index];
                    if (self.mFirstAttributeUnitDic[gobj] == nil) then
                        self.mFirstAttributeUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIRefineItemAttributeUnitTemplate);
                    end
                    self.mFirstAttributeUnitDic[gobj]:UpdateUnit(v.nameString, v.valueString);
                    index = index + 1;
                end
            end
        end
    else
        self:GetAimEquip_UIItem():ResetUI();
        gridContainer.MaxCount = 0;
    end
    self:GetAimEquipEquipAdd_GameObject():SetActive(self:GetSecondChooseBagItemInfo() == nil);
    self:GetSecondItemAttributeUnitGridContainer().transform.parent.gameObject:SetActive(self:GetSecondChooseBagItemInfo() ~= nil);
    self:UpdateOtherUI();
end

function UIRefinePanel:GetAttributeShowTexts(bagItemInfo)
    local showTexts = {};
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        if (bagItemInfo ~= nil) then
            if (self:GetShowAttributeTypes() ~= nil) then
                for k, v in pairs(self:GetShowAttributeTypes()) do
                    local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId);
                    if (isFind) then
                        local attributeName = Utility.GetAttributeName(Utility.EnumToInt(v.firstType));
                        if (v.firstType ~= v.secondType) then
                            local baseMinValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetBaseAttribute(itemTable, v.firstType);
                            local baseMaxValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetBaseAttribute(itemTable, v.secondType);
                            local otherMinValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetRateAttribute(bagItemInfo, v.firstType);
                            local otherMaxValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetRateAttribute(bagItemInfo, v.secondType);
                            if (baseMaxValue > 0 or baseMinValue > 0) then
                                local colorStr = otherMaxValue > 0 and luaEnumColorType.Green2 or "";
                                --local otherShowText = otherMaxValue > 0 and "("..otherMinValue.."-"..otherMaxValue..")" or "";
                                local otherShowText = otherMaxValue > 0 and "(+" .. otherMaxValue .. ")" or "";
                                table.insert(showTexts, { nameString = colorStr .. attributeName, valueString = colorStr .. baseMinValue + otherMinValue .. " - " .. baseMaxValue + otherMaxValue .. otherShowText });
                            else
                                if (otherMaxValue > 0 or otherMinValue > 0) then
                                    baseMinValue = otherMinValue;
                                    baseMaxValue = otherMaxValue;
                                    --local otherShowText = otherMaxValue > 0 and "("..otherMinValue.."-"..otherMaxValue..")" or "";
                                    local otherShowText = otherMaxValue > 0 and "(+" .. otherMaxValue .. ")" or "";
                                    table.insert(showTexts, { nameString = luaEnumColorType.Green2 .. attributeName, valueString = luaEnumColorType.Green2 .. baseMinValue .. " - " .. baseMaxValue .. otherShowText .. "[-]" });
                                end
                            end
                        else
                            local baseValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetBaseAttribute(itemTable, v.firstType, CS.CSScene.MainPlayerInfo.Career);
                            local otherValue = CS.CSScene.MainPlayerInfo.EquipInfo:GetRateAttribute(bagItemInfo, v.firstType);
                            if (baseValue > 0) then
                                if (otherValue <= 0) then
                                    table.insert(showTexts, { nameString = attributeName, valueString = "+" .. baseValue });
                                else
                                    local colorStr = otherValue > 0 and luaEnumColorType.Green2 or "";
                                    local otherShowText = otherValue > 0 and "(+" .. otherValue .. ")" or "";
                                    table.insert(showTexts, { nameString = colorStr .. attributeName, valueString = colorStr .. baseValue + otherValue .. otherShowText });
                                end
                            else
                                if (otherValue > 0) then
                                    baseValue = otherValue;
                                    local otherShowText = otherValue > 0 and "(+" .. otherValue .. ")" or "";
                                    table.insert(showTexts, { nameString = luaEnumColorType.Green2 .. attributeName, valueString = luaEnumColorType.Green2 .. baseValue .. otherShowText });
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return showTexts;
end

---获取炼化错误码 0:无错误码可炼化, 1:没有炼化装备, 2:缺少第二件炼化装备
function UIRefinePanel:GetRefineErrorCode()
    if (self:GetFirstChooseBagItemInfo() == nil and self:GetSecondChooseBagItemInfo() == nil) then
        return 1;
    elseif (self:GetFirstChooseBagItemInfo() == nil or self:GetSecondChooseBagItemInfo() == nil) then
        return 2;
    end
    return 0;
end

--function UIRefinePanel:DelayFrameAutoAddRefine()
--    if(self.mCoroutineDelayFrameAutoAdd ~= nil) then
--       StopCoroutine(self.mCoroutineDelayFrameAutoAdd);
--        self.mCoroutineDelayFrameAutoAdd = nil;
--    end
--    self.mCoroutineDelayFrameAutoAdd = StartCoroutine(self.CAutoAddRefine, self);
--end
--
--function UIRefinePanel:CAutoAddRefine()
--    coroutine.yield(CS.UnityEngine.WaitForSeconds(1));
--    self:AutoAddRefine();
--end

function UIRefinePanel:AutoAddRefine(targetBagItemInfo)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local isBodyEquip = false;
        local isGetValue = false;
        local isServantEquip = false;
        ---有指定精炼道具
        if (targetBagItemInfo ~= nil) then
            local bagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(targetBagItemInfo.lid);
            isServantEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(targetBagItemInfo.lid)
            if (bagItemInfo ~= nil) then
                isGetValue = true;
                isBodyEquip = true;
            elseif (isServantEquip) then
                isGetValue = true;
                local servantIndex = math.floor(targetBagItemInfo.index / 1000) - 1;
                UIRefinePanel.mServantPos = servantIndex < 0 and 0 or servantIndex;
            else
                isGetValue, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(targetBagItemInfo.lid);
            end
            if (isGetValue) then
                self:TrySetBagItemInfo(targetBagItemInfo);
                local autoRefineTarget;
                local otherIsBody;
                autoRefineTarget, otherIsBody = CS.CSScene.MainPlayerInfo.BagInfo:GetAutoRefineBagItemInfo(targetBagItemInfo);
                if (autoRefineTarget ~= nil) then
                    self:TrySetBagItemInfo(autoRefineTarget);
                end
            end
        else
            ---没有指定精炼道具
            local hasAutoRefineTarget = false;

            --region 上次精炼物品不为nil
            if (uiStaticParameter.mLastRefineResult ~= nil) then
                local bagItemInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(uiStaticParameter.mLastRefineResult.lid);
                isServantEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:IsServantEquip(uiStaticParameter.mLastRefineResult.lid)
                if (bagItemInfo ~= nil) then
                    isGetValue = true;
                    isBodyEquip = true;
                elseif (isServantEquip) then
                    isGetValue = true;
                    bagItemInfo = uiStaticParameter.mLastRefineResult;
                else
                    isGetValue, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(uiStaticParameter.mLastRefineResult.lid);
                end
                if (isGetValue) then
                    local autoRefineTarget;
                    local hasBodyEquip = false;
                    if (bagItemInfo ~= nil) then
                        autoRefineTarget, hasBodyEquip = CS.CSScene.MainPlayerInfo.BagInfo:GetAutoRefineBagItemInfo(bagItemInfo);
                    elseif (isServantEquip) then
                        autoRefineTarget, hasBodyEquip = CS.CSScene.MainPlayerInfo.BagInfo:GetAutoRefineBagItemInfo(uiStaticParameter.mLastRefineResult);
                    end
                    if (not isBodyEquip) then
                        isBodyEquip = hasBodyEquip;
                    end
                    if (autoRefineTarget ~= nil) then
                        self:TrySetBagItemInfo(bagItemInfo);
                        self:TrySetBagItemInfo(autoRefineTarget);
                        hasAutoRefineTarget = true;
                    end
                end
            end
            --endregion

            if (not hasAutoRefineTarget) then
                local autoRefineList;
                local hasBodyEquip = false;
                autoRefineList, hasBodyEquip, isServantEquip, UIRefinePanel.mServantPos = CS.CSScene.MainPlayerInfo.BagInfo:GetAutoRefineList();
                if (not isBodyEquip) then
                    isBodyEquip = hasBodyEquip;
                end
                if (autoRefineList ~= nil) then
                    for i = 0, autoRefineList.Count - 1 do
                        self:TrySetBagItemInfo(autoRefineList[i]);
                    end
                end
            end
        end

        if (self:GetFirstChooseBagItemInfo() ~= nil or self:GetSecondChooseBagItemInfo() ~= nil) then
            if (isBodyEquip) then
                self:SetLeftPanel(LuaEnumRefineLeftPanelType.RoleEquip)
            elseif (isServantEquip) then
                self:SetLeftPanel(LuaEnumRefineLeftPanelType.Servant);
            else
                self:SetLeftPanel(LuaEnumRefineLeftPanelType.Bag)
            end
        else
            if (UIRefinePanel.mSelectType == nil) then
                self:SetLeftPanel(LuaEnumRefineLeftPanelType.RoleEquip);
            end
        end
    end
end
--endregion

--region Private
function UIRefinePanel:InitEvents()
    CS.UIEventListener.Get(self:GetTglBag_UIToggle().gameObject).onClick = function()
        self:SetLeftPanel(LuaEnumRefineLeftPanelType.Bag);
    end

    CS.UIEventListener.Get(self:GetTglRole_UIToggle().gameObject).onClick = function()
        self:SetLeftPanel(LuaEnumRefineLeftPanelType.RoleEquip);
    end

    CS.UIEventListener.Get(self:GetTglServant_UIToggle().gameObject).onClick = function()
        self:SetLeftPanel(LuaEnumRefineLeftPanelType.Servant);
    end

    CS.UIEventListener.Get(self:GetBtnRefine_GameObject()).onClick = function(go)
        self.mIsClickedRefine = true;
        if (self:GetRefineErrorCode() == 0) then
            local firstEquipLid = self:GetFirstChooseBagItemInfo().lid;
            local secondEquipLid = self:GetSecondChooseBagItemInfo().lid;
            if (self:GetFirstChooseBagItemInfo().index > 0) then
                firstEquipLid = -self:GetFirstChooseBagItemInfo().index;
            end
            if (self:GetSecondChooseBagItemInfo().index > 0) then
                secondEquipLid = -self:GetSecondChooseBagItemInfo().index;
            end

            local empty = self:GetBagInfoV2().EmptyGridCount
            local firstIndex = self:GetFirstChooseBagItemInfo().index
            local secondIndex = self:GetSecondChooseBagItemInfo().index
            if firstIndex and firstIndex > 0 and secondIndex and secondIndex > 0 and empty == 0 then
                Utility.ShowPopoTips(go, nil, 335)
            else
                networkRequest.ReqEquipRefine(firstEquipLid, secondEquipLid);
            end
        elseif (self:GetRefineErrorCode() == 1) then
            local tipsInfo = {};
            tipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnRefine_GameObject().transform;
            tipsInfo[LuaEnumTipConfigType.ConfigID] = 330;
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        elseif (self:GetRefineErrorCode() == 2) then
            local tipsInfo = {};
            tipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnRefine_GameObject().transform;
            tipsInfo[LuaEnumTipConfigType.ConfigID] = 332;
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
        end
    end

    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIRefinePanel");
    end

    CS.UIEventListener.Get(self:GetOriginEquip_GameObject()).onClick = function()
        if (self:GetFirstChooseBagItemInfo() == nil) then
            local hasFirst = self:GetFirstChooseBagItemInfo() ~= nil;
            local hasSecond = self:GetSecondChooseBagItemInfo() ~= nil;
            if (not hasFirst and not hasSecond) then
                local tipsInfo = {};
                tipsInfo[LuaEnumTipConfigType.Parent] = self:GetOriginEquip_GameObject().transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 334;
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
            elseif (not hasFirst or not hasSecond) then
                local tipsInfo = {};
                tipsInfo[LuaEnumTipConfigType.Parent] = self:GetOriginEquip_GameObject().transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 333;
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
            end
        else
            self:TrySetFirstBagItemInfo(nil);
        end
    end

    CS.UIEventListener.Get(self:GetAimEquip_GameObject()).onClick = function()
        if (self:GetSecondChooseBagItemInfo() == nil) then
            local hasFirst = self:GetFirstChooseBagItemInfo() ~= nil;
            local hasSecond = self:GetSecondChooseBagItemInfo() ~= nil;
            if (not hasFirst and not hasSecond) then
                local tipsInfo = {};
                tipsInfo[LuaEnumTipConfigType.Parent] = self:GetAimEquip_GameObject().transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 334;
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
            elseif (not hasFirst or not hasSecond) then
                local tipsInfo = {};
                tipsInfo[LuaEnumTipConfigType.Parent] = self:GetAimEquip_GameObject().transform;
                tipsInfo[LuaEnumTipConfigType.ConfigID] = 333;
                uimanager:CreatePanel("UIBubbleTipsPanel", nil, tipsInfo);
            end
        else
            self:TrySetSecondBagItemInfo(nil);
        end
    end

    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(158);
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
        end
    end

    CS.UIEventListener.Get(self:GetSecondReplaceItemBtnGetWay_GameObject()).onClick = function()
        if (self:GetSecondChooseBagItemInfo() ~= nil) then
            Utility.ShowItemGetWay(self:GetSecondChooseBagItemInfo().itemId, self:GetSecondReplaceItemBtnGetWay_GameObject(), LuaEnumWayGetPanelArrowDirType.Down);
        end
    end

    --region LuaEvents
    self.CallOnMainChatBagButtonClick = function()
        self:SetLeftPanel(LuaEnumRefineLeftPanelType.Bag);
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnMainChatBagButtonClick)

    self.CallOnBagItemClick = function(msgId, msgData)
        self:TrySetBagItemInfo(msgData);
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Refine_OnBagItemClick, self.CallOnBagItemClick)

    self.CallOnEquipGridClicked = function(msgId, msgData)
        if msgData ~= nil and msgData.bagItemInfo ~= nil then
            local rolePanel = uimanager:GetPanel("UIRolePanel");
            if (rolePanel ~= nil) then
                if (self:GetFirstChooseBagItemInfo() ~= nil or self:GetSecondChooseBagItemInfo() ~= nil) then
                    self:TrySetFirstBagItemInfo(nil);
                    self:TrySetSecondBagItemInfo(nil);
                    uiStaticParameter.mLastRefineResult = msgData.bagItemInfo
                    self:TrySetBagItemInfo(msgData.bagItemInfo);
                    self:AutoAddRefine();
                else
                    self:TrySetBagItemInfo(msgData.bagItemInfo);
                end
            end
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, self.CallOnEquipGridClicked)

    self.CallOnServantEquipGridClicked = function(msgId, msgData)
        if msgData ~= nil then
            if (self:GetFirstChooseBagItemInfo() ~= nil or self:GetSecondChooseBagItemInfo() ~= nil) then
                self:TrySetFirstBagItemInfo(nil);
                self:TrySetSecondBagItemInfo(nil);
            end
            self:TrySetBagItemInfo(msgData);
        end
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Servant_OnEquipRefineClick, self.CallOnServantEquipGridClicked)
    --endregion
end

function UIRefinePanel:RemoveEvents()
    --luaEventManager.RemoveCallback(LuaCEvent.Role_EquipGridClicked, self.CallOnEquipGridClicked);
    --luaEventManager.RemoveCallback(LuaCEvent.Refine_OnBagItemClick, self.CallOnBagItemClick);
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, self.CallOnMainChatBagButtonClick);
    --luaEventManager.RemoveCallback(LuaCEvent.Servant_OnEquipRefineClick, self.CallOnServantEquipGridClicked);


    if (self.mCoroutineDelayFrameAutoAdd ~= nil) then
        StopCoroutine(self.mCoroutineDelayFrameAutoAdd);
        self.mCoroutineDelayFrameAutoAdd = nil;
    end

    if (not self.mIsClickedRefine) then
        if (CS.CSScene.MainPlayerInfo ~= nil and self:GetFirstChooseBagItemInfo() ~= nil) then
            if (UIRefinePanel.mSelectType == LuaEnumRefineLeftPanelType.RoleEquip) then
                CS.CSScene.MainPlayerInfo.BagInfo:AddToNotRecommendList(self:GetFirstChooseBagItemInfo().itemId);
            elseif (UIRefinePanel.mSelectType == LuaEnumRefineLeftPanelType.Servant) then
                CS.CSScene.MainPlayerInfo.BagInfo:AddToNotServantRecommendList(self:GetFirstChooseBagItemInfo().itemId);
            end
        end
    end
end

--endregion

--endregion

function UIRefinePanel:Init()
    self:InitEvents();
    CS.Cfg_ItemsFloatTableManager.Instance.CanShowRefineRedPoint = false;
end

function UIRefinePanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    --if (customData.type == nil) then
    --    customData.type = LuaEnumRefineLeftPanelType.RoleEquip;
    --end

    if (customData.bagItemInfo ~= nil) then
        self:AutoAddRefine(customData.bagItemInfo);
    else
        self:AutoAddRefine();
    end

    uimanager:ClosePanel("UIBagPanel");
    self:UpdateFirstBagItem();
    self:UpdateSecondBagItem();
end

function UIRefinePanel:ClosePanel()
    self:RunBaseFunction("ClosePanel")
    self.isCloseOther = true
    uimanager:ClosePanel("UIRolePanel");
    uimanager:ClosePanel("UIBagPanel");
    uimanager:ClosePanel("UIServantPanel");
end

function ondestroy()
    UIRefinePanel:RemoveEvents();
    if UIRefinePanel.isCloseOther ~= true then
        uimanager:ClosePanel("UIRolePanel");
        uimanager:ClosePanel("UIBagPanel");
        uimanager:ClosePanel("UIServantPanel");
    end
end

return UIRefinePanel;