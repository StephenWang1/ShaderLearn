local UIRefineResultPanel = {};

UIRefineResultPanel.mResult = nil;

UIRefineResultPanel.mChooseTarget = nil;

UIRefineResultPanel.mChooseTipsPanel = nil;

UIRefineResultPanel.mFirTipLabelText = nil;

--region Components

function UIRefineResultPanel:GetWidgetRoot_UIWidget()
    if (self.mWidgetRoot_UIWidget == nil) then
        self.mWidgetRoot_UIWidget = self:GetCurComp("WidgetRoot", "UIWidget")
    end
    return self.mWidgetRoot_UIWidget;
end

function UIRefineResultPanel:GetItemsName_GameObject()
    if (self.mItemsName_GameObject == nil) then
        self.mItemsName_GameObject = self:GetCurComp("WidgetRoot/view/itemsName", "GameObject");
    end
    return self.mItemsName_GameObject;
end

function UIRefineResultPanel:GetItemName1_GameObject()
    if (self.mItemName1_GameObject == nil) then
        self.mItemName1_GameObject = self:GetCurComp("WidgetRoot/view/itemsName/name1", "GameObject");
    end
    return self.mItemName1_GameObject;
end

function UIRefineResultPanel:GetItemName2_GameObject()
    if (self.mItemName2_GameObject == nil) then
        self.mItemName2_GameObject = self:GetCurComp("WidgetRoot/view/itemsName/name2", "GameObject");
    end
    return self.mItemName2_GameObject;
end

function UIRefineResultPanel:GetItemName3_GameObject()
    if (self.mItemName3_GameObject == nil) then
        self.mItemName3_GameObject = self:GetCurComp("WidgetRoot/view/itemsName/name3", "GameObject");
    end
    return self.mItemName3_GameObject;
end

function UIRefineResultPanel:GetBtnDefine_GameObject()
    if (self.mBtnDefine_GameObject == nil) then
        self.mBtnDefine_GameObject = self:GetCurComp("WidgetRoot/events/btn_define", "GameObject");
    end
    return self.mBtnDefine_GameObject;
end

function UIRefineResultPanel:GetRefineDes_Text()
    if (self.mRefineDes_Text == nil) then
        self.mRefineDes_Text = self:GetCurComp("WidgetRoot/view/text", "UILabel")
    end
    return self.mRefineDes_Text;
end

function UIRefineResultPanel:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:GetCurComp("WidgetRoot/window/bg", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UIRefineResultPanel:GetFirstChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetFirstChooseBagItemInfo();
    end
    return nil;
end

function UIRefineResultPanel:GetSecondChooseBagItemInfo()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        return refinePanel:GetSecondChooseBagItemInfo();
    end
    return nil;
end

--endregion

--region Method

--region Public

function UIRefineResultPanel:UpdateUI()
    self:GetWidgetRoot_UIWidget().alpha = 0.1;
    local topHeight = 70;
    local downHeight = 168;
    if (self.mResult ~= nil) then
        local bagItems = {};
        local showItem1 = CS.CSBagInfoV2.GetRefineShowTipsBagItemInfo(self:GetFirstChooseBagItemInfo())
        local showItem2 = CS.CSBagInfoV2.GetRefineShowTipsBagItemInfo(self:GetSecondChooseBagItemInfo());
        if(CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(showItem1.itemId)) then
            table.insert(bagItems, showItem1);
        end
        if(CS.Cfg_ItemsFloatTableManager.Instance:CanRefine(showItem2.itemId)) then
            table.insert(bagItems, showItem2);
        end
        self.mShowResult = CS.CSBagInfoV2.GetRefineShowTipsBagItemInfo(self.mResult);
        self:SortBagItemInfoTable(bagItems, self.mShowResult)
        self.mChooseTarget = self:GetBetterBagItemInfo();

        local trueBagItems = {};
        table.insert(trueBagItems, self:GetFirstChooseBagItemInfo());
        table.insert(trueBagItems, self:GetSecondChooseBagItemInfo());
        --region 提示文本
        local hasOtherAttribute = false;
        for k, v in pairs(trueBagItems) do
            if (v.intensify > 0 or v.luck > 0 or v.curse > 0) then
                hasOtherAttribute = true;
                break ;
            end
        end

        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22435);
        if (isFind) then
            if (hasOtherAttribute) then
                self:GetRefineDes_Text().text = globalTable.value;
            end
        end

        if (not hasOtherAttribute) then
            self:GetRefineDes_Text().text = self.mFirTipLabelText;
        end

        --endregion

        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.mShowResult, showRight = false, showAssistPanel = true, itemInfoSource = luaEnumItemInfoSource.UIREFINERESULT, assistBagItemInfoTable = bagItems, defaultChooseTable = { self.mChooseTarget }, isCloseCollider = true, needCompare = false, --[[maxFrameHeight = 350,]] tipsOnClick = function(template)
            if (template.commonData ~= nil) then
                self.mChooseTarget = template.commonData.bagItemInfo;
            end
        end, refreshEndFunc = function(panel)
            if (panel ~= nil) then
                local maxHeight = 0;
                if (panel.tipsPanelTable ~= nil) then
                    self.mChooseTipsPanel = panel.tipsPanelTable;
                    for k, v in pairs(panel.tipsPanelTable) do
                        maxHeight = math.max(maxHeight, v:FrameSize().y);
                    end
                    local mainTipsPanelHeight = panel.tipsPanelTable[#panel.tipsPanelTable]:FrameSize().y;
                    self:GetBackGround_UISprite().height = maxHeight + topHeight + downHeight;
                    local localPosition = self:GetBackGround_UISprite().gameObject.transform.localPosition;
                    panel.go.transform.position = self:GetBackGround_UISprite().transform:TransformPoint(CS.UnityEngine.Vector3(panel.go.transform.localPosition.x, localPosition.y + self:GetBackGround_UISprite().height / 2 - topHeight - mainTipsPanelHeight / 2, panel.go.transform.localPosition.z));
                    self:GetItemsName_GameObject().transform.position = self:GetBackGround_UISprite().transform:TransformPoint(CS.UnityEngine.Vector3(localPosition.x, localPosition.y + self:GetBackGround_UISprite().height / 2 - 54, localPosition.z));
                    self:GetRefineDes_Text().transform.position = self:GetBackGround_UISprite().transform:TransformPoint(CS.UnityEngine.Vector3(localPosition.x, localPosition.y - (self:GetBackGround_UISprite().height / 2) + 125, localPosition.z));
                    self:GetBtnDefine_GameObject().transform.position = self:GetBackGround_UISprite().transform:TransformPoint(CS.UnityEngine.Vector3(localPosition.x, localPosition.y - (self:GetBackGround_UISprite().height / 2) + 55, localPosition.z));
                    self:GetWidgetRoot_UIWidget().alpha = 1;
                end
            end
        end });

        local isUseReplaceItem = #bagItems <= 1;
        self:GetItemName2_GameObject():SetActive(not isUseReplaceItem);
        local itemName1Pos = not isUseReplaceItem and CS.UnityEngine.Vector3(-498,6,0) or CS.UnityEngine.Vector3(-325,6,0);
        local itemName3Pos = not isUseReplaceItem and CS.UnityEngine.Vector3(182,6,0) or CS.UnityEngine.Vector3(13,6,0);
        self:GetItemName1_GameObject().transform.localPosition = itemName1Pos;
        self:GetItemName3_GameObject().transform.localPosition = itemName3Pos;
    end
end

function UIRefineResultPanel:ClearRefine()
    local refinePanel = uimanager:GetPanel("UIRefinePanel");
    if (refinePanel ~= nil) then
        refinePanel:TrySetFirstBagItemInfo(nil);
        refinePanel:TrySetSecondBagItemInfo(nil);
    end
end

function UIRefineResultPanel:SortBagItemInfoTable(assistBagItemInfo, result)
    if assistBagItemInfo ~= nil and result ~= nil and type(assistBagItemInfo) == "table" then
        self.allBagItemInfos = Utility.CopyTable(assistBagItemInfo)
        table.insert(self.allBagItemInfos, result)
        self.allBagItemInfos = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.EquipInfo:SortBestBagItemInfo(self.allBagItemInfos))
    end
end

function UIRefineResultPanel:IsBetterBagItemInfo(bagItemInfo)
    if self.allBagItemInfos ~= nil and bagItemInfo ~= nil then
        return bagItemInfo.lid == self.allBagItemInfos[1].lid
    end
    return false
end

function UIRefineResultPanel:GetBetterBagItemInfo()
    if self.allBagItemInfos ~= nil and self.allBagItemInfos[1] ~= nil then
        local attributeType = self:GetArrowAttributeType()
        if attributeType == nil or attributeType == CS.BetterAttributeReason.Null then
            return self.mShowResult;
        end
        return self.allBagItemInfos[1];
    end
    return nil;
end

function UIRefineResultPanel:GetBagItemInfoIndex(bagItemInfo)
    if (bagItemInfo ~= nil) then
        for k, v in pairs(self.allBagItemInfos) do
            if (bagItemInfo.lid == v.lid) then
                return k;
            end
        end
    end
    return 1;
end

function UIRefineResultPanel:GetArrowAttributeType()
    if self.allBagItemInfos ~= nil and #self.allBagItemInfos > 1 then
        return CS.CSScene.MainPlayerInfo.EquipInfo:EquipBaseAttributeCompareReason(self.allBagItemInfos[1], self.allBagItemInfos[2])
    end
    return nil;
end
--endregion

--region Private

function UIRefineResultPanel:InitEvents()
    CS.UIEventListener.Get(self:GetBtnDefine_GameObject()).onClick = function()
        if (self.mChooseTarget ~= nil) then
            local index = 0;
            if self:GetFirstChooseBagItemInfo() and (self.mChooseTarget.lid == self:GetFirstChooseBagItemInfo().lid) then
                index = 1;
            elseif self:GetSecondChooseBagItemInfo() and (self.mChooseTarget.lid == self:GetSecondChooseBagItemInfo().lid) then
                index = 2;
            elseif self.mResult and (self.mChooseTarget.lid == self.mResult.lid) then
                index = 0;
            end

            --local equipInfo = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipInfo(self.mResult.lid);
            --if (equipInfo ~= nil) then
            --    networkRequest.ReqSaveEquipRefine(-equipInfo.index, index);
            --else
            --    local servantEquip = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetServantEquip(self.mResult.lid)
            --    networkRequest.ReqSaveEquipRefine(self.mResult.lid, index);
            --end
            if(self.mResult.index > 0) then
                networkRequest.ReqSaveEquipRefine(-self.mResult.index, index);
            else
                networkRequest.ReqSaveEquipRefine(self.mResult.lid, index);
            end

            if (self.mChooseTipsPanel ~= nil) then
                for k, v in pairs(self.mChooseTipsPanel) do
                    if (v.commonData.bagItemInfo.lid == self.mChooseTarget.lid) then
                        local mainChatPanel = uimanager:GetPanel("UIMainChatPanel");
                        if (mainChatPanel ~= nil) then
                            local toPosition = mainChatPanel.btn_bag.transform.position;
                            luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, { itemId = self.mResult.itemId, from = v.go.transform.position, to = toPosition });
                            break ;
                        end
                    end
                end
            end
        end
        uimanager:ClosePanel("UIItemRefineInfoPanel");
        uimanager:ClosePanel("UIRefineResultPanel");
        self:ClearRefine();
    end

    CS.UIEventListener.Get(self:GetBackGround_UISprite().gameObject).onClick = function()
        local allTextTipsContainerPanel = uimanager:GetPanel("UIAllTextTipsContainerPanel");
        if (allTextTipsContainerPanel ~= nil) then
            allTextTipsContainerPanel.SendTips(LuaEnumTextTipsType.MiddleTips, "请先选择一件装备!");
        end
    end
end

function UIRefineResultPanel:RemoveEvents()

end

--endregion

--endregion

function UIRefineResultPanel:Init()
    self:InitEvents();
    self.mFirTipLabelText = self:GetRefineDes_Text().text;
end

function UIRefineResultPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.result == nil or self:GetFirstChooseBagItemInfo() == nil or self:GetSecondChooseBagItemInfo() == nil) then
        uimanager:ClosePanel("UIRefineResultPanel");
    end
    self.mResult = customData.result;
    self:UpdateUI();
end

function ondestroy()
    uimanager:ClosePanel("UIItemRefineInfoPanel");
    UIRefineResultPanel:RemoveEvents();
end

return UIRefineResultPanel;