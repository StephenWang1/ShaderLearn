---@class UIWayGetUnitTemplate:TemplateBase
local UIWayGetUnitTemplate = {};

---@type TABLE.CFG_WAY_GET
UIWayGetUnitTemplate.mWayGetTable = nil;
--region Components

---@return UnityEngine.GameObject
function UIWayGetUnitTemplate:GetBtnGo_GameObject()
    if (self.mBtnGo_GameObject == nil) then
        self.mBtnGo_GameObject = self:Get("arrow", "GameObject");
    end
    return self.mBtnGo_GameObject;
end

function UIWayGetUnitTemplate:GetWayGetName_Text()
    if (self.mWayGetName_Text == nil) then
        self.mWayGetName_Text = self:Get("Label", "UILabel");
    end
    return self.mWayGetName_Text;
end

---@return UILabel
function UIWayGetUnitTemplate:GetSpLabel()
    if self.mSpLabel == nil then
        self.mSpLabel = self:Get("spLabel", "UILabel")
    end
    return self.mSpLabel
end
--endregion

--region Method

function UIWayGetUnitTemplate:IEnumBtnGoOnClick(go)
    --coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01));
    uimanager:ClosePanel("UISkillPanel");
    uimanager:ClosePanel("UIItemInfoPanel");
    uimanager:ClosePanel("UIDisposeItemPanel");
    uimanager:ClosePanel("UISuperJuLingZhuPanel");
    uimanager:ClosePanel("UISpecialTreasureBagPanel");
    uimanager:ClosePanel("UISynthesisPanel")

    --coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01));
    if (self.mWayGetTable ~= nil) then
        if self.mWayGetTable.openType == LuaEnumWayGetFuncType.CreatePanel then
            local itemID = self:GetItemID()
            if itemID ~= 0 and (self.mWayGetTable.openPanel == "1102" or self.mWayGetTable.openPanel == "1101") then
                if (not CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(itemID, function(vo)
                    local customData = {}
                    customData.type = vo.storeClassId
                    customData.chooseStore = {};
                    table.insert(customData.chooseStore, vo.storeId);
                    uiTransferManager:TransferToPanel(tonumber(self.mWayGetTable.openPanel), customData)
                end)) then
                    uimanager:ClosePanel("UIAuctionItemPanel")
                    uiTransferManager:TransferToPanel(tonumber(self.mWayGetTable.openPanel))
                end
            else
                uimanager:ClosePanel("UIAuctionItemPanel")
                if (self.mWayGetTable.id == 208) then
                    ---炼制大师 修为
                    if (self.mOpenServerLimitLevel == nil) then
                        self:GetRefineMasterOpenLevel()
                    end
                    if (CS.CSScene.Sington.MainPlayer.BaseInfo.Level >= self.mOpenServerLimitLevel) then
                        uiTransferManager:TransferToPanel(tonumber(self.mWayGetTable.openPanel))
                    else
                        self:ShowTips(go, 237, "达到" .. self.mOpenServerLimitLevel .. "级后可炼制")
                        return
                    end
                elseif (self.mWayGetTable.id == 209) then
                    ---炼制大师 灵兽
                    for k = 0, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count - 1 do
                        if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[k].level >= CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterLevel) then
                            uiTransferManager:TransferToPanel(tonumber(self.mWayGetTable.openPanel))
                            return
                        end
                    end
                    self:ShowTips(go, 237, "灵兽达到" .. CS.Cfg_GlobalTableManager.Instance.ServantRefineMasterLevel .. "级后可炼制")
                    return
                elseif tonumber(self.mWayGetTable.openPanel) == LuaEnumTransferType.Bag_Smelt then
                    local panel = uimanager:GetPanel("UIRefinePanel")
                    if panel then
                        panel:ClosePanel()
                    end
                    uiTransferManager:TransferToPanel(tonumber(self.mWayGetTable.openPanel))
                else
                    local transferId = tonumber(self.mWayGetTable.openPanel);
                    if (transferId == LuaEnumTransferType.Synthesis_List and itemID ~= 0) then
                        local luaWayGetTbl = clientTableManager.cfg_way_getManager:TryGetValue(self.mWayGetTable.id)
                        local type = 1;
                        if (luaWayGetTbl ~= nil) then
                            if (luaWayGetTbl:GetParameter() ~= nil and luaWayGetTbl:GetParameter() ~= "") then
                                type = tonumber(luaWayGetTbl:GetParameter());
                            end
                        end

                        local customData = {};
                        ---@type TABLE.cfg_synthesis
                        local synthesisTbl = nil;
                        if (type == 2) then
                            synthesisTbl = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisByResultItemId(itemID);
                        else
                            synthesisTbl = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisByItemId(itemID);
                        end
                        if (synthesisTbl ~= nil) then
                            customData.firstType = synthesisTbl:GetTabType();
                            customData.secondType = synthesisTbl:GetTabSubType();
                            customData.thirdItemId = itemID;
                            uiTransferManager:TransferToPanel(transferId, { subCustomData = customData });
                        end
                    elseif transferId == LuaEnumTransferType.Recharge_Potential then
                        uiTransferManager:TransferToPanel(transferId, { type = LuaEnumRechargeType.PotentialInvest })
                    elseif transferId == LuaEnumTransferType.Competition_LevelUp then
                        uiTransferManager:TransferToPanel(transferId, { type = luaEnumCompetitionType.OpenActivity })
                    elseif transferId == LuaEnumTransferType.Competition_FirstKill then
                        uiTransferManager:TransferToPanel(transferId, { type = luaEnumCompetitionType.FirstKill })
                    elseif transferId == LuaEnumTransferType.Competition_FirstDropReward then
                        uiTransferManager:TransferToPanel(transferId, { type = luaEnumCompetitionType.FirstDrop })
                    elseif transferId == LuaEnumTransferType.Competition_EquipRecycle then
                        uiTransferManager:TransferToPanel(transferId, { type = luaEnumCompetitionType.Recycle })
                    else
                        uiTransferManager:TransferToPanel(transferId);
                    end
                end
            end
            --uiTransferManager:SetIsTransferToLast(true);
        elseif self.mWayGetTable.openType == LuaEnumWayGetFuncType.FindPathAndOpenFlyShose then
            if (not self:TryFindPathAndOpenFlyShose()) then
                return ;
            end
        elseif self.mWayGetTable.openType == LuaEnumWayGetFuncType.GoAndKillMonster then
            ---前往杀怪
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoAndKillTargetMonster:DoOperation(self.mWayGetTable.openPanel)
        elseif self.mWayGetTable.openType == LuaEnumWayGetFuncType.SecretBook then
            ---秘籍
            return self:TryOpenSecretBookPush();
        elseif self.mWayGetTable.openType == LuaEnumWayGetFuncType.CheckSecretBook then
            uimanager:CreatePanel("UISecretBookPanel", nil, self.mWayGetTable.openPanel);
        elseif self.mWayGetTable.openType == LuaEnumWayGetFuncType.SHIWANGDIAN then
            ---寻路至传送员并打开面板且选中对应的地图
            CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 1001, 8 }, "UInewTeleportPanel",
                    CS.EAutoPathFindSourceSystemType.Normal,
                    CS.EAutoPathFindType.Normal_TowardNPC,
                    { 0, tonumber(self.mWayGetTable.openPanel) })
        end

        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01));
        uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
    end
end

function UIWayGetUnitTemplate:GetRefineMasterOpenLevel()
    local difDay = CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1
    local isFind, item = CS.Cfg_GlobalTableManagerBase.Instance:TryGetValue(22224)
    if isFind then
        local value = string.Split(item.value, "&")
        for i = 1, #value do
            local info = string.Split(value[i], "#")
            if difDay >= tonumber(info[1]) and difDay <= tonumber(info[2]) then
                self.mOpenServerLimitLevel = tonumber(info[3])
                break
            end
        end
    end
end

function UIWayGetUnitTemplate:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIRefineMasterLeftPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--region CallFunction

function UIWayGetUnitTemplate:OnBtnGoClick(go)
    if (self.IEnumBtnGoOnClickFun == nil) then
        self.IEnumBtnGoOnClickFun = StartCoroutine(self.IEnumBtnGoOnClick, self, go)
    end
end

function UIWayGetUnitTemplate:GetItemID()
    if self.mItemID ~= nil and self.mItemID ~= 0 then
        return self.mItemID
    end
    local uiFurnaceWayAndBuyPanel = uimanager:GetPanel("UIFurnaceWayAndBuyPanel")
    if uiFurnaceWayAndBuyPanel ~= nil and uiFurnaceWayAndBuyPanel.mPanelParams ~= nil then
        return uiFurnaceWayAndBuyPanel.mPanelParams.itemId;
    end
    return 0;
end

--endregion

--region Public

function UIWayGetUnitTemplate:UpdateUnit(wayGetId)
    if (wayGetId ~= nil) then
        local isFindWayGetTable, wayGetTable = CS.Cfg_Way_GetTableManager.Instance:TryGetValue(wayGetId);
        if (isFindWayGetTable) then
            self.mWayGetTable = wayGetTable;
            self:UpdateUI();
        end
    end
end

function UIWayGetUnitTemplate:UpdateUI()
    if (self.mWayGetTable ~= nil) then
        self:GetWayGetName_Text().text = self.mWayGetTable.name;
        local isShowSpecialParam = false
        local specialParamStr = ""
        ---如果condition满足,那么根据parameters字段的条件显示相应的文字
        local luaWayGetTbl = clientTableManager.cfg_way_getManager:TryGetValue(self.mWayGetTable.id)
        if luaWayGetTbl and luaWayGetTbl:GetParameter() ~= "" then
            local strs = string.Split(luaWayGetTbl:GetParameter(), '#')
            if #strs > 1 then
                local conditionID = tonumber(strs[1])
                specialParamStr = strs[2]
                if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
                    isShowSpecialParam = true
                end
            end
        end
        if isShowSpecialParam then
            self:GetSpLabel().gameObject:SetActive(true)
            self:GetSpLabel().text = Utility.CombineStringQuickly("[e85038]", specialParamStr, "[-]")
            self:GetBtnGo_GameObject():SetActive(false)
        else
            self:GetSpLabel().gameObject:SetActive(false)
            self:GetBtnGo_GameObject():SetActive(true)
        end
    else
        self:GetSpLabel().gameObject:SetActive(false)
    end
end

--endregion

--region Private

function UIWayGetUnitTemplate:TryOpenSecretBookPush()
    if (self.mWayGetTable ~= nil) then
        local pushId = tonumber(self.mWayGetTable.openPanel);
        if (pushId ~= nil) then
            local pushSuccess = Utility.ShowCheatPushTips({ id = pushId, dependPanel = "UIFurnaceWayAndBuyPanel", trans = self:GetBtnGo_GameObject() });
            if (not pushSuccess) then
                CS.Utility.ShowTips("不满足推送条件");
                uimanager:ClosePanel("UIFurnaceWayAndBuyPanel");
            end
        end
    end
end

function UIWayGetUnitTemplate:TryFindPathAndOpenFlyShose()
    if (self.mWayGetTable ~= nil) then
        local tbl = Utility.ParseWayGetFindPathAndOpenFlyShoeOpenPanel(self.mWayGetTable.openPanel)
        if (tbl ~= nil) then
            local deliverID = tbl.deliverID
            local conditionId = tbl.conditionID
            local bubbleId = tbl.bubbleID
            if (conditionId ~= nil) then
                if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId)) then
                    ---寻路并开启小飞鞋
                    if deliverID then
                        Utility.TryTransfer(deliverID, false);
                        --CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(deliverID)
                    else
                        if isOpenLog then
                            luaDebug.LogError("Way_Get表openPanel数据错误  " + self.mWayGetTable.openPanel)
                        end
                    end
                else
                    if (bubbleId ~= nil) then
                        Utility.ShowPopoTips(self:GetBtnGo_GameObject().transform, nil, bubbleId, "UIFurnaceWayAndBuyPanel");
                    end
                    return false;
                end
            else
                ---寻路并开启小飞鞋
                if deliverID then
                    Utility.TryTransfer(deliverID, false);
                    --CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(deliverID)
                else
                    if isOpenLog then
                        luaDebug.LogError("Way_Get表openPanel数据错误  " + self.mWayGetTable.openPanel)
                    end
                end
            end
        end
    end
    return true;
end

function UIWayGetUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self:GetBtnGo_GameObject()).onClick = function(go)
        self:OnBtnGoClick(go);
    end
end

function UIWayGetUnitTemplate:RemoveEvents()

end

--endregion

--endregion

function UIWayGetUnitTemplate:Init()
    self:InitEvents();
end

function UIWayGetUnitTemplate:OnDestroy()
    if (self.IEnumBtnGoOnClickFun ~= nil) then
        StopCoroutine(self.IEnumBtnGoOnClickFun)
        self.IEnumBtnGoOnClickFun = nil
    end
end

return UIWayGetUnitTemplate;