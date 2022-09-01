---@class UIEvolutionViewTemplate
local UIEvolutionViewTemplate = {};

UIEvolutionViewTemplate.mLeftPanelType = LuaEnumStrengthenType.Role

UIEvolutionViewTemplate.mLeftPanelName = nil;

UIEvolutionViewTemplate.mSelectBagItemInfo = nil;

--region Components

--region GameObject

function UIEvolutionViewTemplate:GetBtnEvolution_GameObject()
    if (self.mBtnEvolution_GameObject == nil) then
        self.mBtnEvolution_GameObject = self:Get("view2/btn_evolution", "GameObject");
    end
    return self.mBtnEvolution_GameObject;
end

function UIEvolutionViewTemplate:GetFullLevel_GameObject()
    if (self.mFullLevel_GameObject == nil) then
        self.mFullLevel_GameObject = self:Get("view2/fullLevel", "GameObject");
    end
    return self.mFullLevel_GameObject;
end

---需要显示的内容
function UIEvolutionViewTemplate:GetView_GameObject()
    if (self.mViewObj == nil) then
        self.mViewObj = self:Get("view2", "GameObject");
    end
    return self.mViewObj
end

function UIEvolutionViewTemplate:GetGuid_GameObject()
    if (self.mGuidObj == nil) then
        self.mGuidObj = self:Get("guid", "GameObject")
    end
    return self.mGuidObj
end

--endregion

--region UIToggle

function UIEvolutionViewTemplate:GetTglRole_UIToggle()
    if (self.mTglRole_UIToggle == nil) then
        self.mTglRole_UIToggle = self:Get("events/btn_role", "UIToggle");
    end
    return self.mTglRole_UIToggle;
end

function UIEvolutionViewTemplate:GetTglBag_UIToggle()
    if (self.mTglBag_UIToggle == nil) then
        self.mTglBag_UIToggle = self:Get("events/btn_bag", "UIToggle");
    end
    return self.mTglBag_UIToggle;
end
--endregion

--region UILabel

function UIEvolutionViewTemplate:GetCurTypeName_UISprite()
    if (self.mCurTypeName_UISprite == nil) then
        self.mCurTypeName_UISprite = self:Get("view2/currentType", "UISprite");
    end
    return self.mCurTypeName_UISprite;
end

function UIEvolutionViewTemplate:GetNextTypeName_UISprite()
    if (self.mNextTypeName_UISprite == nil) then
        self.mNextTypeName_UISprite = self:Get("view2/nextType", "UISprite");
    end
    return self.mNextTypeName_UISprite;
end

function UIEvolutionViewTemplate:GetFullTypeName_UISprite()
    if (self.mFullTypeName_UISprite == nil) then
        self.mFullTypeName_UISprite = self:Get("view2/fullType", "UISprite");
    end
    return self.mFullTypeName_UISprite;
end

--endregion

function UIEvolutionViewTemplate:GetCostButtonGridContainer()
    if (self.mCostButtonGridContainer == nil) then
        self.mCostButtonGridContainer = self:Get("view2/cost/Scroll View/gridContainer", "UIGridContainer");
    end
    return self.mCostButtonGridContainer;
end

---@return UIForgeTargetItemViewTemplate
function UIEvolutionViewTemplate:GetForgeTargetItemViewTemplate()
    if (self.mForgeTargetItemViewTemplate == nil) then
        self.mForgeTargetItemViewTemplate = templatemanager.GetNewTemplate(self:Get("view2/view", "GameObject"), luaComponentTemplates.UIForgeTargetItemViewTemplate);
    end
    return self.mForgeTargetItemViewTemplate;
end

function UIEvolutionViewTemplate:GetAttributeCompareViewTemplate()
    if (self.mAttributeCompareViewTemplate == nil) then
        self.mAttributeCompareViewTemplate = templatemanager.GetNewTemplate(self:Get("view2/Scroll View", "GameObject"), luaComponentTemplates.UIAttributeCompareViewTemplate);
    end
    return self.mAttributeCompareViewTemplate;
end

---@return UIEvolutionCostChooseViewTemplate
function UIEvolutionViewTemplate:GetEvolutionCostChooseViewTemplate()
    if (self.mEvolutionCostChooseViewTemplate == nil) then
        self.mEvolutionCostChooseViewTemplate = templatemanager.GetNewTemplate(self:Get("view2/choose", "GameObject"), luaComponentTemplates.UIEvolutionCostChooseViewTemplate, self.mOwnerPanel);
    end
    return self.mEvolutionCostChooseViewTemplate;
end

--endregion

--region Method

--region CallFunction

function UIEvolutionViewTemplate:OnTglRoleClicked()
    self:ShowLeftLayer(LuaEnumStrengthenType.Role);
end

function UIEvolutionViewTemplate:OnTglBagClicked()
    self:ShowLeftLayer(LuaEnumStrengthenType.Bag);
end

function UIEvolutionViewTemplate:OnBtnEvolutionClicked()
    if (self.mSelectBagItemInfo ~= nil) then
        local costList = CS.CSScene.MainPlayerInfo.BagInfo:GetEvolutionCostList();
        local isFind, evolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(self.mSelectBagItemInfo.itemId);
        if (isFind) then
            if (costList.Count > 0) then
                networkRequest.ReqEvolve(self.mSelectBagItemInfo.lid, costList, evolutionTable.type);
            end
        end
    else
        local TipsInfo = {}
        --TipsInfo[LuaEnumTipConfigType.Describe] = "已满级"
        TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnEvolution_GameObject().transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 55
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end
end

function UIEvolutionViewTemplate:OnBagItemClicked(msgId, bagItemInfo)
    if bagItemInfo ~= nil then
        if not CS.Cfg_EvolutionTableManager.Instance:CanEvolution(bagItemInfo.itemId) then
            CS.Utility.ShowTips("此装备不能进化")
        else
            self:ShowEvolutionItem(bagItemInfo)
        end
    end
end

function UIEvolutionViewTemplate:OnRoleItemClicked(msgId, itemTemp)
    if itemTemp ~= nil and itemTemp.bagItemInfo ~= nil then
        if not CS.Cfg_EvolutionTableManager.Instance:CanEvolution(itemTemp.bagItemInfo.itemId) then
            CS.Utility.ShowTips("此装备不能进化")
        else
            self:ShowEvolutionItem(itemTemp.bagItemInfo)
        end
    end
end

function UIEvolutionViewTemplate:OnEvolutionAddCostButtonClick(msgId, index)
    if (self.mSelectBagItemInfo ~= nil) then
        self:GetEvolutionCostChooseViewTemplate():ShowCostChooseView(self.mSelectBagItemInfo, index);
    end
end

function UIEvolutionViewTemplate:OnResEvolveMessage(msgId, tableData)
    self:ShowEvolutionItem(tableData.equipInfo);
end

--endregion

--region Public

---@param customData table {leftPanelType, bagItemInfo}
function UIEvolutionViewTemplate:ShowEvolution(customData)
    self:ShowLeftLayer(customData.leftPanelType, function(panel)
        self:ShowEvolutionItem(customData.bagItemInfo);
    end);
end

function UIEvolutionViewTemplate:ShowLeftLayer(leftPanelType, callBack)
    if (leftPanelType == nil) then
        leftPanelType = LuaEnumStrengthenType.Role;
    end
    self.mLeftPanelType = leftPanelType;
    self:UpdateLeftLayer(callBack);
end

function UIEvolutionViewTemplate:ShowEvolutionItem(bagItemInfo)
    if (self.mSelectBagItemInfo == nil or self.mSelectBagItemInfo.lid ~= bagItemInfo.lid) then
        luaEventManager.DoCallback(LuaCEvent.Evolution_OnChangeItem, bagItemInfo);
    end
    self.mSelectBagItemInfo = bagItemInfo;
    CS.CSScene.MainPlayerInfo.BagInfo.EvolutionCostDic:Clear();
    for k, v in pairs(self.mCostButtonDic) do
        v:ShowCostItem();
    end
    self:GetEvolutionCostChooseViewTemplate():Close();
    self:UpdateEvolutionItem();

end

function UIEvolutionViewTemplate:UpdateLeftLayer(callBack)
    if (self.mLeftPanelType == LuaEnumStrengthenType.Role) then
        self:CreateOrShowLeftPanel("UIRolePanel", callBack);
    elseif (self.mLeftPanelType == LuaEnumStrengthenType.Bag) then
        self:CreateOrShowLeftPanel("UIBagPanel", callBack);
    end
    self:GetTglRole_UIToggle().value = self.mLeftPanelType == LuaEnumStrengthenType.Role;
    self:GetTglBag_UIToggle().value = self.mLeftPanelType == LuaEnumStrengthenType.Bag;
end

function UIEvolutionViewTemplate:UpdateEvolutionItem()
    self:GetGuid_GameObject():SetActive(self.mSelectBagItemInfo == nil)
    self:GetView_GameObject():SetActive(self.mSelectBagItemInfo ~= nil)
    if (self.mSelectBagItemInfo ~= nil) then
        local isFind, evolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(self.mSelectBagItemInfo.itemId);
        local itemId = isFind and self.mSelectBagItemInfo.itemId or nil;
        self:GetForgeTargetItemViewTemplate():ShowItemAndProbability(itemId, self:GetEvolutionProbability(evolutionTable.type));
        if (isFind) then
            --region 装备进化类型名
            if (evolutionTable.newid ~= nil) then
                local isFindNext, nextEvolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(evolutionTable.newid);
                if (isFindNext) then
                    self:GetCurTypeName_UISprite().gameObject:SetActive(true);
                    self:GetNextTypeName_UISprite().gameObject:SetActive(true);
                    self:GetFullTypeName_UISprite().gameObject:SetActive(false);
                    self:GetCurTypeName_UISprite().spriteName = self:GetEvolutionTypeName(evolutionTable.type);
                    self:GetNextTypeName_UISprite().spriteName = self:GetEvolutionTypeName(nextEvolutionTable.type);
                    self:GetForgeTargetItemViewTemplate():SetProbabilityActive(true);
                    self:GetFullLevel_GameObject():SetActive(false);
                else
                    self:GetCurTypeName_UISprite().gameObject:SetActive(false);
                    self:GetNextTypeName_UISprite().gameObject:SetActive(false);
                    self:GetFullTypeName_UISprite().gameObject:SetActive(true);
                    self:GetFullLevel_GameObject():SetActive(true);
                    self:GetForgeTargetItemViewTemplate():SetProbabilityActive(false);
                    self:GetFullTypeName_UISprite().spriteName = self:GetEvolutionTypeName(evolutionTable.type);
                end
            else
                self:GetCurTypeName_UISprite().gameObject:SetActive(false);
                self:GetNextTypeName_UISprite().gameObject:SetActive(false);
                self:GetFullTypeName_UISprite().gameObject:SetActive(true);
                self:GetFullLevel_GameObject():SetActive(true);
                self:GetForgeTargetItemViewTemplate():SetProbabilityActive(false);
                self:GetFullTypeName_UISprite().spriteName = self:GetEvolutionTypeName(evolutionTable.type);
            end
            --endregion

            --region 属性对比
            local list = {};
            local count = 0;
            local changeTypes = evolutionTable.changeType;
            for i = 0, changeTypes.list.Count - 1 do
                local type = changeTypes.list[i];
                local customData = {};
                local isGetValue0, itemTable0 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(evolutionTable.id);
                local isGetValue1, itemTable1 = CS.Cfg_ItemsTableManager.Instance:TryGetValue(evolutionTable.newid);
                if (type == LuaEnumAttributeType.InnerPowerMax) then
                    customData.name = "内力";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.innerPowerMax;
                        ---流水账艺博让加的，后期艺博优化处理
                        customData.minTotalValue = itemTable0.innerPowerMax
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.innerPowerMax;
                        customData.maxTotalValue = itemTable1.innerPowerMax
                    end
                    list[type] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.CriticalDamage) then
                    customData.name = "爆伤";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.criticalDamage;
                        customData.minTotalValue = itemTable0.criticalDamage
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.criticalDamage;
                        customData.maxTotalValue = itemTable1.criticalDamage
                    end
                    list[type] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.MaxHp) then
                    customData.name = "血量";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.maxHp;
                        customData.minTotalValue = itemTable1.maxHp
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.maxHp;
                        customData.maxTotalValue = itemTable1.maxHp
                    end
                    list[type] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.PhyAttackMin) then
                    customData.name = "物攻";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.phyAttackMin .. " - " .. itemTable0.phyAttackMax;
                        customData.minTotalValue = itemTable0.phyAttackMin + itemTable0.phyAttackMax;
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.phyAttackMin .. " - " .. itemTable1.phyAttackMax;
                        customData.maxTotalValue = itemTable1.phyAttackMin + itemTable1.phyAttackMax;
                    end
                    list[LuaEnumAttributeType.PhyAttackMin] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.PhyAttackMax) then
                    if (list[LuaEnumAttributeType.PhyAttackMin] == nil) then
                        customData.name = "物攻";
                        if (isGetValue0) then
                            customData.curValue = itemTable0.phyAttackMin .. " - " .. itemTable0.phyAttackMax;
                            customData.minTotalValue = itemTable0.phyAttackMin + itemTable0.phyAttackMax;
                        end
                        if (isGetValue1) then
                            customData.nextValue = itemTable1.phyAttackMin .. " - " .. itemTable1.phyAttackMax;
                            customData.maxTotalValue = itemTable1.phyAttackMin + itemTable1.phyAttackMax;
                        end
                        list[LuaEnumAttributeType.PhyAttackMin] = customData;
                        count = count + 1;
                    end
                elseif (type == LuaEnumAttributeType.MagicAttackMin) then
                    customData.name = "魔攻";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.magicAttackMin .. " - " .. itemTable0.magicAttackMax;
                        customData.minTotalValue = itemTable0.magicAttackMin + itemTable0.magicAttackMax;
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.magicAttackMin .. " - " .. itemTable1.magicAttackMax;
                        customData.maxTotalValue = itemTable1.magicAttackMin + itemTable1.magicAttackMax;
                    end
                    list[LuaEnumAttributeType.MagicAttackMin] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.MagicAttackMax) then
                    if (list[LuaEnumAttributeType.MagicAttackMin] == nil) then
                        customData.name = "魔攻";
                        if (isGetValue0) then
                            customData.curValue = itemTable0.magicAttackMin .. " - " .. itemTable0.magicAttackMax;
                            customData.minTotalValue = itemTable0.magicAttackMin + itemTable0.magicAttackMax;
                        end
                        if (isGetValue1) then
                            customData.nextValue = itemTable1.magicAttackMin .. " - " .. itemTable1.magicAttackMax;
                            customData.maxTotalValue = itemTable1.magicAttackMin + itemTable1.magicAttackMax;
                        end
                        list[LuaEnumAttributeType.MagicAttackMin] = customData;
                        count = count + 1;
                    end
                elseif (type == LuaEnumAttributeType.TaoAttackMin) then
                    customData.name = "道攻";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.taoAttackMin .. " - " .. itemTable0.taoAttackMax;
                        customData.minTotalValue = itemTable0.taoAttackMin + itemTable0.taoAttackMax;
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.taoAttackMin .. " - " .. itemTable1.taoAttackMax;
                        customData.maxTotalValue = itemTable1.taoAttackMin + itemTable1.taoAttackMax;
                    end
                    list[LuaEnumAttributeType.TaoAttackMin] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.TaoAttackMax) then
                    if (list[LuaEnumAttributeType.TaoAttackMin] == nil) then
                        customData.name = "道攻";
                        if (isGetValue0) then
                            customData.curValue = itemTable0.taoAttackMin .. " - " .. itemTable0.taoAttackMax;
                            customData.minTotalValue = itemTable0.taoAttackMin + itemTable0.taoAttackMax;
                        end
                        if (isGetValue1) then
                            customData.nextValue = itemTable1.taoAttackMin .. " - " .. itemTable1.taoAttackMax;
                            customData.maxTotalValue = itemTable1.taoAttackMin + itemTable1.taoAttackMax;
                        end
                        list[LuaEnumAttributeType.TaoAttackMin] = customData;
                        count = count + 1;
                    end
                elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
                    customData.name = "物防";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.phyDefenceMin .. " - " .. itemTable0.phyDefenceMax;
                        customData.minTotalValue = itemTable0.phyDefenceMin + itemTable0.phyDefenceMax;
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.phyDefenceMin .. " - " .. itemTable1.phyDefenceMax;
                        customData.maxTotalValue = itemTable1.phyDefenceMin + itemTable1.phyDefenceMax;
                    end
                    list[LuaEnumAttributeType.PhyDefenceMin] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
                    if (list[LuaEnumAttributeType.PhyDefenceMin] == nil) then
                        customData.name = "物防";
                        if (isGetValue0) then
                            customData.curValue = itemTable0.phyDefenceMin .. " - " .. itemTable0.phyDefenceMax;
                            customData.minTotalValue = itemTable0.phyDefenceMin + itemTable0.phyDefenceMax;
                        end
                        if (isGetValue1) then
                            customData.nextValue = itemTable1.phyDefenceMin .. " - " .. itemTable1.phyDefenceMax;
                            customData.maxTotalValue = itemTable1.phyDefenceMin + itemTable1.phyDefenceMax;
                        end
                        list[LuaEnumAttributeType.PhyDefenceMin] = customData;
                        count = count + 1;
                    end
                elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
                    customData.name = "魔防";
                    if (isGetValue0) then
                        customData.curValue = itemTable0.magicDefenceMin .. " - " .. itemTable0.magicDefenceMax;
                        customData.minTotalValue = itemTable0.magicDefenceMin + itemTable0.magicDefenceMax;
                    end
                    if (isGetValue1) then
                        customData.nextValue = itemTable1.magicDefenceMin .. " - " .. itemTable1.magicDefenceMax;
                        customData.maxTotalValue = itemTable1.magicDefenceMin + itemTable1.magicDefenceMax;
                    end
                    list[LuaEnumAttributeType.MagicDefenceMin] = customData;
                    count = count + 1;
                elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
                    if (list[LuaEnumAttributeType.MagicDefenceMin] == nil) then
                        customData.name = "魔防";
                        if (isGetValue0) then
                            customData.curValue = itemTable0.magicDefenceMin .. " - " .. itemTable0.magicDefenceMax;
                            customData.minTotalValue = itemTable0.magicDefenceMin + itemTable0.magicDefenceMax;
                        end
                        if (isGetValue1) then
                            customData.nextValue = itemTable1.magicDefenceMin .. " - " .. itemTable1.magicDefenceMax;
                            customData.maxTotalValue = itemTable1.magicDefenceMin + itemTable1.magicDefenceMax;
                        end
                        list[LuaEnumAttributeType.MagicDefenceMin] = customData;
                        count = count + 1;
                    end
                end
            end
            self:GetAttributeCompareViewTemplate():ShowAttributeCompare(list, count);
            --endregion
        end
    else
        self:GetFullTypeName_UISprite().gameObject:SetActive(false);
        self:GetFullLevel_GameObject():SetActive(false);
    end
    self:CloseAllEquipChooseEffect();
    if (self.mLeftPanelType == LuaEnumStrengthenType.Role) then
        ---@type UIRolePanel
        local rolePanel = uimanager:GetPanel("UIRolePanel");
        if (rolePanel ~= nil) then
            rolePanel:SetItemChoose(self.mSelectBagItemInfo);
        end
    elseif (self.mLeftPanelType == LuaEnumStrengthenType.Bag) then
        --local panel = uimanager:GetPanel("UIBagPanel");
        --if (panel ~= nil) then
        --    panel.OpenOneItemHighLight(self.mSelectBagItemInfo);
        --end
    end
end

function UIEvolutionViewTemplate:UpdateProbability()
    local evolutionType = 0;
    if (self.mSelectBagItemInfo ~= nil) then
        local isFind, evolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(self.mSelectBagItemInfo.itemId);
        if (isFind) then
            evolutionType = evolutionTable.type;
        end
    end
    self:GetForgeTargetItemViewTemplate():ShowProbability(self:GetEvolutionProbability(evolutionType));
end

function UIEvolutionViewTemplate:CloseAllEquipChooseEffect()
    --local panel = uimanager:GetPanel("UIBagPanel");
    --if (panel ~= nil) then
    --    panel.CloseAllHighLight();
    --end
    local panel = uimanager:GetPanel("UIRolePanel");
    if (panel ~= nil) then
        panel:HideCurrentChooseItem();
    end
end

--endregion

--region Private

function UIEvolutionViewTemplate:CreateOrShowLeftPanel(panelName, callBack)
    if (self.mLeftPanelName ~= nil and self.mLeftPanelName ~= panelName) then
        uimanager:ClosePanel(self.mLeftPanelName);
    end
    self.mLeftPanelName = panelName;
    local customData = nil;
    if (panelName == "UIRolePanel") then
        customData = {};
        customData.avatarInfo = CS.CSScene.MainPlayerInfo;
        customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateEvolution;
        customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateEvolution;
    end

    if (panelName == "UIBagPanel") then
        customData = {};
        customData.type = LuaEnumBagType.Evolution;
    end

    uimanager:CreatePanel(panelName, function(panel)

        self:CreatePanelSuccessDoSomething(panel);

        if (callBack ~= nil) then
            callBack(panel);
        end
    end, customData);
end

function UIEvolutionViewTemplate:CreatePanelSuccessDoSomething(panel)
    if (panel._PanelName == "UIBagPanel") then
        --panel.SetFilterBagItem(false, function(bagItemInfo)
        --    return CS.Cfg_EvolutionTableManager.Instance:CanEvolution(bagItemInfo.itemId)
        --end, function()
        --    if (self.mSelectBagItemInfo ~= nil) then
        --        panel.OpenOneItemHighLight(self.mSelectBagItemInfo);
        --    end
        --end);
        --panel.GetRecycleBtnArrow_UISprite().gameObject:SetActive(false)
        --panel.GetBaseCloseBtn_GameObject():SetActive(false)

    elseif (panel._PanelName == "UIRolePanel") then
        panel:ShowCloseButton(false);
        if (self.mSelectBagItemInfo ~= nil) then
            panel:SetItemChoose(self.mSelectBagItemInfo);
        end

        ---因为角色面板绑定的此事件跟本界面的事件会冲突所以先移除， 再添加
        luaEventManager.ClearCallback(LuaCEvent.MainChatPanel_BtnBag);
        if self.mOwnerPanel then
            self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnBagBtnClicked)
        end
    end
end

function UIEvolutionViewTemplate:GetEvolutionTypeName(evolutionType)
    if (evolutionType == LuaEnumEquipEvolutionType.Normal) then
        return "evolution_1";
    elseif (evolutionType == LuaEnumEquipEvolutionType.God) then
        return "evolution_2";
    elseif (evolutionType == LuaEnumEquipEvolutionType.Holy) then
        return "evolution_3";
    elseif (evolutionType == LuaEnumEquipEvolutionType.Supreme) then
        return "evolution_4";
    end
    return "evolution_1";
end

function UIEvolutionViewTemplate:GetEvolutionProbability(evolutionType)
    local typeCountDic = {};
    typeCountDic[LuaEnumEquipEvolutionType.Normal] = 0;
    typeCountDic[LuaEnumEquipEvolutionType.God] = 0;
    typeCountDic[LuaEnumEquipEvolutionType.Holy] = 0;

    local costDic = CS.CSScene.MainPlayerInfo.BagInfo.EvolutionCostDic;
    if (costDic.Count > 0) then
        for k, v in pairs(costDic) do
            local isFind0, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(v);
            if (isFind0) then
                local itemId = bagItemInfo.itemId;
                local isFind1, evolutionTable = CS.Cfg_EvolutionTableManager.Instance:TryGetValue(itemId);
                if (isFind1) then
                    typeCountDic[evolutionTable.type] = typeCountDic[evolutionTable.type] + 1;
                end
            end
        end
    end
    local firstCount = typeCountDic[LuaEnumEquipEvolutionType.Normal];
    local secondCount = typeCountDic[LuaEnumEquipEvolutionType.God];
    local thirdCount = typeCountDic[LuaEnumEquipEvolutionType.Holy];
    local probability = self:GetCSEvolutionProbability(evolutionType, firstCount, secondCount, thirdCount);
    return math.floor(probability / 100);
end

function UIEvolutionViewTemplate:GetCSEvolutionProbability(evolutionType, firstCount, secondCount, thirdCount)
    if (firstCount == nil) then
        firstCount = 0;
    end
    if (secondCount == nil) then
        secondCount = 0;
    end
    if (thirdCount == nil) then
        thirdCount = 0;
    end

    if (evolutionType == 1) then
        return CS.Cfg_GlobalTableManager.Instance:GetFirstEvolutionProbability(firstCount);
    elseif (evolutionType == 2) then
        return CS.Cfg_GlobalTableManager.Instance:GetSecondEvolutionProbability(firstCount, secondCount);
    elseif (evolutionType == 3) then
        return CS.Cfg_GlobalTableManager.Instance:GetThirdEvolutionProbability(firstCount, secondCount, thirdCount);
    end
    return 0;
end

function UIEvolutionViewTemplate:Initialize()
    if (self.mCostButtonDic == nil) then
        self.mCostButtonDic = {};
    end

    local gridContainer = self:GetCostButtonGridContainer();
    gridContainer.MaxCount = 5;
    for i = 0, 4 do
        local gobj = gridContainer.controlList[i];
        if (self.mCostButtonDic[i] == nil) then
            self.mCostButtonDic[i] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UIEvolutionCostButtonTemplate, self.mOwnerPanel);
        end
        self.mCostButtonDic[i]:ShowCostButton(i);
    end
end

function UIEvolutionViewTemplate:InitEvents()

    CS.UIEventListener.Get(self:GetTglRole_UIToggle().gameObject).onClick = function()
        self:OnTglRoleClicked();
    end

    CS.UIEventListener.Get(self:GetTglBag_UIToggle().gameObject).onClick = function()
        self:OnTglBagClicked();
    end

    CS.UIEventListener.Get(self:GetBtnEvolution_GameObject()).onClick = function()
        self:OnBtnEvolutionClicked();
    end

    self.CallOnBagItemClicked = function(msgId, itemTemp)
        self:OnBagItemClicked(msgId, itemTemp);
    end

    self.CallOnBagBtnClicked = function(msgId, msgData)
        self:OnTglBagClicked();
    end

    self.CallOnRoleItemClicked = function(msgId, itemTemp)
        self:OnRoleItemClicked(msgId, itemTemp);
    end

    self.CallOnEvolutionAddCostButtonClick = function(msgId, index)
        self:OnEvolutionAddCostButtonClick(msgId, index);
    end

    self.CallOnEvolutionOnAddCostSuccess = function()
        self:UpdateProbability();
    end

    self.CallOnEvolutionOnLessCostSuccess = function()
        self:UpdateProbability();
    end

    self.CallOnResEvolveMessage = function(msgId, tableData)
        self:OnResEvolveMessage(msgId, tableData)
    end

    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnBagBtnClicked)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnBagGridClicked, self.CallOnBagItemClicked)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_EquipGridClicked, self.CallOnRoleItemClicked)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnAddCostButtonClick, self.CallOnEvolutionAddCostButtonClick)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionOnAddCostSuccess)
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Evolution_OnLessCostSuccess, self.CallOnEvolutionOnLessCostSuccess)

        self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEvolveMessage, self.CallOnResEvolveMessage)
    end
end

function UIEvolutionViewTemplate:RemoveEvents()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.MainChatPanel_BtnBag, self.CallOnBagBtnClicked)
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnBagGridClicked, self.CallOnBagItemClicked);
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Role_EquipGridClicked, self.CallOnRoleItemClicked);
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnAddCostButtonClick, self.CallOnEvolutionAddCostButtonClick);
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Evolution_OnAddCostSuccess, self.CallOnEvolutionOnAddCostSuccess);
        self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResEvolveMessage, self.CallOnResEvolveMessage)
    end
end

--endregion

--endregion
---@param panel UIEvolutionPanel
function UIEvolutionViewTemplate:Init(panel)
    self.mOwnerPanel = panel
    self:Initialize();
    self:InitEvents();
end

function UIEvolutionViewTemplate:OnDestroy()
    self:RemoveEvents();
end

return UIEvolutionViewTemplate;