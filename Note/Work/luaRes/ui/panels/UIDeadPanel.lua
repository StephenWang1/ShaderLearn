---@class UIDeadPanel:UIBase
local UIDeadPanel = {}

--region 字段
---界面层级
UIDeadPanel.PanelLayerType = CS.UILayerType.TipsPlane
---是否可以原地复活
UIDeadPanel.mIsAbleToReliveSitu = false
---复活消息是否已发送
UIDeadPanel.mIsReliveMsgSended = false
---描述文本颜色
UIDeadPanel.DescribeContentColor = "[fffff0]"

UIDeadPanel.mIsReliveDelay = false;
--endregion

--region 组件

function UIDeadPanel:GetJustReliveLabel_GameObject()
    if UIDeadPanel.mJustReliveLabel_GameObject == nil then
        UIDeadPanel.mJustReliveLabel_GameObject = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/Label", "GameObject")
    end
    return UIDeadPanel.mJustReliveLabel_GameObject
end

---@return UILabel
function UIDeadPanel:GetDeadMessagesLabel()
    if UIDeadPanel.mDeadMessagesLabel == nil then
        UIDeadPanel.mDeadMessagesLabel = UIDeadPanel:GetCurComp("WidgetRoot/window/view/messages", "UILabel")
    end
    return UIDeadPanel.mDeadMessagesLabel
end

---获取掉落的物品
---@return UnityEngine.GameObject
function UIDeadPanel:GetDropGameObject()
    if self.mDropGameObject == nil then
        self.mDropGameObject = self:GetCurComp("WidgetRoot/window/view/drop", "GameObject")
    end
    return self.mDropGameObject
end

---获取掉落格子容器
---@return UIGridContainer
function UIDeadPanel:GetDropGridController()
    if self.mDropGridController == nil then
        self.mDropGridController = self:GetCurComp("WidgetRoot/window/view/drop/ScrollView/DropItemList", "UIGridContainer")
    end
    return self.mDropGridController
end

---免费复活按钮
---@return UnityEngine.GameObject
function UIDeadPanel:GetBtn_FreeRelive()
    if UIDeadPanel.mBtn_FreeRelive == nil then
        UIDeadPanel.mBtn_FreeRelive = UIDeadPanel:GetCurComp("WidgetRoot/window/events/FreeRelive", "GameObject")
    end
    return UIDeadPanel.mBtn_FreeRelive
end

---原地复活按钮
---@return UnityEngine.GameObject
function UIDeadPanel:GetBtn_ReliveInPlace()
    if UIDeadPanel.mBtn_ReliveInPlace == nil then
        UIDeadPanel.mBtn_ReliveInPlace = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace", "GameObject")
    end
    return UIDeadPanel.mBtn_ReliveInPlace
end

---@return UnityEngine.GameObject
function UIDeadPanel:GetBtnAddCount_GameObject()
    if UIDeadPanel.mBtnAddCount_GameObject == nil then
        UIDeadPanel.mBtnAddCount_GameObject = UIDeadPanel:GetCurComp("WidgetRoot/window/events/Btn_AddCount", "GameObject")
    end
    return UIDeadPanel.mBtnAddCount_GameObject
end

function UIDeadPanel:GetWindow_GameObject()
    if (UIDeadPanel.mWindow_GameObject == nil) then
        UIDeadPanel.mWindow_GameObject = UIDeadPanel:GetCurComp("WidgetRoot/window", "GameObject");
    end
    return UIDeadPanel.mWindow_GameObject;
end

function UIDeadPanel:GetEvent_GameObject()
    if (UIDeadPanel.mEvent_GameObject == nil) then
        UIDeadPanel.mEvent_GameObject = UIDeadPanel:GetCurComp("WidgetRoot/window/events", "GameObject");
    end
    return UIDeadPanel.mEvent_GameObject;
end

function UIDeadPanel:GetSpecialEvents_GameObject()
    if (UIDeadPanel.mspecialEvents_GameObject == nil) then
        UIDeadPanel.mspecialEvents_GameObject = UIDeadPanel:GetCurComp("WidgetRoot/window/specialEvents", "GameObject");
    end
    return UIDeadPanel.mspecialEvents_GameObject;
end

function UIDeadPanel:GetspecialReliveCD()
    if UIDeadPanel.mspecialReliveCD == nil then
        UIDeadPanel.mspecialReliveCD = UIDeadPanel:GetCurComp("WidgetRoot/window/specialEvents/reliveCD", "CountDownTimeLabel")
    end
    return UIDeadPanel.mspecialReliveCD
end

function UIDeadPanel:GetReliveCD()
    return UIDeadPanel:GetBtnFreeRelive_CountDownLabel();
end

---@return CountDownTimeLabel
function UIDeadPanel:GetReliveDelay()
    if UIDeadPanel.mReliveDelay == nil then
        UIDeadPanel.mReliveDelay = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/reliveDelay", "CountDownTimeLabel")
    end
    return UIDeadPanel.mReliveDelay
end

---@return UILabel
function UIDeadPanel:GetFreeCount_Text()
    if (UIDeadPanel.mFreeCount_Text == nil) then
        UIDeadPanel.mFreeCount_Text = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/reliveTimes", "UILabel")
    end
    return UIDeadPanel.mFreeCount_Text;
end

---免费复活按钮文字
---@return UILabel
function UIDeadPanel:GetBtnFreeRelive_UILabel()
    if UIDeadPanel.mBtn_FreeReliveLabel == nil then
        UIDeadPanel.mBtn_FreeReliveLabel = UIDeadPanel:GetCurComp("WidgetRoot/window/events/FreeRelive/Label", "UILabel")
    end
    return UIDeadPanel.mBtn_FreeReliveLabel
end

---免费复活按钮文字的倒计时
---@return CountDownTimeLabel
function UIDeadPanel:GetBtnFreeRelive_CountDownLabel()
    if UIDeadPanel.mBtn_FreeReliveCountDownLabel == nil then
        UIDeadPanel.mBtn_FreeReliveCountDownLabel = UIDeadPanel:GetCurComp("WidgetRoot/window/events/FreeRelive/Label", "CountDownTimeLabel")
    end
    return UIDeadPanel.mBtn_FreeReliveCountDownLabel
end

---原地复活按钮文字
---@return UILabel
function UIDeadPanel:GetBtnReliveInPlace_UILabel()
    if UIDeadPanel.mBtn_ReliveInPlaceLabel == nil then
        UIDeadPanel.mBtn_ReliveInPlaceLabel = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/Label", "UILabel")
    end
    return UIDeadPanel.mBtn_ReliveInPlaceLabel
end

function UIDeadPanel:GetReliveCostValue_Text()
    if (UIDeadPanel.mReliveCostValue_Text == nil) then
        UIDeadPanel.mReliveCostValue_Text = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/num", "UILabel");
    end
    return UIDeadPanel.mReliveCostValue_Text;
end

function UIDeadPanel:GetReliveCostItemIcon_UISprite()
    if (UIDeadPanel.mReliveCostItemIcon_UISprite == nil) then
        UIDeadPanel.mReliveCostItemIcon_UISprite = UIDeadPanel:GetCurComp("WidgetRoot/window/events/ReliveInPlace/type", "UISprite");
    end
    return UIDeadPanel.mReliveCostItemIcon_UISprite;
end

function UIDeadPanel:GetMapHereReliveCost()
    return CS.CSMapManager.Instance.mapInfoTbl.hereReliveCost;
end

function UIDeadPanel:GetFreeReliveCount()
    return CS.CSScene.MainPlayerInfo.RoleExtraValues == nil and 0 or CS.CSScene.MainPlayerInfo.RoleExtraValues.freeReliveCount;
end

function UIDeadPanel:GetMapHereReliveCostItemId()
    if UIDeadPanel.GetMapHereReliveCost() == nil then
        return
    end
    local list = UIDeadPanel:GetMapHereReliveCost().list;
    if (list ~= nil and list.Count > 0) then
        return list[0];
    end
    return LuaEnumCoinType.YuanBao;
end

function UIDeadPanel:GetMapHereReliveCostMyValue()
    local itemId = UIDeadPanel:GetMapHereReliveCostItemId();
    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    local mNum = 0;
    if (isFindItem) then
        if (itemTable.type == luaEnumItemType.Coin) then
            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemId);
        else
            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
        end
    end
end

function UIDeadPanel:GetMapHereReliveCostNeedValue()
    local tableValue = UIDeadPanel:GetMapHereReliveCost();
    local needNum = 0;
    if (tableValue ~= nil and tableValue.list ~= nil and tableValue.list.Count >= 4) then
        local freeCount = UIDeadPanel:GetFreeReliveCount();
        needNum = tableValue.list[1] + tableValue.list[2] * math.abs(freeCount);
        needNum = needNum > tableValue.list[3] and tableValue.list[3] or needNum;
    end
    return needNum;
end

---@return UnityEngine.GameObject 不掉落提示
function UIDeadPanel:GetDeadNotDropPrompt_GO()
    if self.mNotDropPromptGo == nil then
        self.mNotDropPromptGo = self:GetCurComp("WidgetRoot/window/view/NeverDrop", "GameObject")
    end
    return self.mNotDropPromptGo
end

--endregion

--region 初始化
function UIDeadPanel:Init()
    UIDeadPanel.mIsReliveMsgSended = false
end

function UIDeadPanel:Show()
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.PlayerDead

    if (uimanager:GetPanel("UICrawlTowerResultPanel") ~= nil) then
        if isOpenLog then
            CS.UnityEngine.Debug.LogWarning("UICrawlTowerResultPanel闯天关需求，关闭死亡面板")
        end
        uimanager:ClosePanel("UIDeadPanel")
    end
    if UIDeadPanel:CheckIsNeedCloseSelf() then
        return
    end
    CS.UIEventListener.Get(UIDeadPanel:GetBtn_FreeRelive()).onClick = UIDeadPanel.OnClickBtn_FreeRelive
    CS.UIEventListener.Get(UIDeadPanel:GetBtn_ReliveInPlace()).onClick = UIDeadPanel.OnClickBtn_ReliveInPlace
    CS.UIEventListener.Get(UIDeadPanel:GetBtnAddCount_GameObject()).onClick = UIDeadPanel.OnClickBtnAddCount
    self:RefreshComponents()
    UIDeadPanel.IsSpecialPanel()
    if CS.CSAudioMgr.Instance then
        UIDeadPanel.DeadAudio = CS.CSAudioMgr.Instance:Play(true, CS.Cfg_GlobalTableManager.Instance.MainPlayerDeadPanelAudio)
    end
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.SkillInfoV2.DiePetSkillID = CS.CSScene.MainPlayerInfo.SkillInfoV2.NowPetSkillID
        CS.CSScene.MainPlayerInfo.SkillInfoV2.NowPetSkillID = 0
    end
end

function UIDeadPanel:IsSpecialPanel()
    local isSpecial = false;
    if CS.CSScene.Sington:IsOnGoddesMap() then
        isSpecial = true;
    end
    UIDeadPanel:GetEvent_GameObject().gameObject:SetActive(not isSpecial);
    UIDeadPanel:GetSpecialEvents_GameObject().gameObject:SetActive(isSpecial);
    if (CS.CSMapManager.Instance.mapInfoTbl.autoRelive ~= nil and CS.CSMapManager.Instance.mapInfoTbl.autoRelive.list.Count >= 2) then
        UIDeadPanel:GetspecialReliveCD():StartCountDown("[c9b394]自动复活:  [fbd671]{0}", CS.CSMapManager.Instance.mapInfoTbl.autoRelive.list[1])
    else
        UIDeadPanel:GetspecialReliveCD():StartCountDown("[c9b394]自动复活:  [fbd671]{0}", 30)
    end

end

---校验是否需要关闭自身
function UIDeadPanel:CheckIsNeedCloseSelf()
    if (CS.CSScene.MainPlayerInfo.HP > 0) then
        if isOpenLog then
            CS.UnityEngine.Debug.LogWarning("玩家当前的血量是" .. CS.CSScene.MainPlayerInfo.HP .. ",关闭死亡面板")
        end
        uimanager:ClosePanel("UIDeadPanel")
        return true
    end
    return false
end
--endregion

--region 界面刷新
function UIDeadPanel:RefreshComponents()
    if CS.CSScene.MainPlayerInfo.BudowillInfo.mainPlayerIsInCompetitionArea == true then
        UIDeadPanel:GetWindow_GameObject():SetActive(false);
    else
        UIDeadPanel:GetWindow_GameObject():SetActive(true);
        local killerName = UIDeadPanel.GetKillerName()
        if killerName then
            UIDeadPanel:GetDeadMessagesLabel().text = UIDeadPanel.DescribeContentColor .. "你被[-]" .. killerName .. UIDeadPanel.DescribeContentColor .. "杀害了[-]"
        else
            UIDeadPanel:GetDeadMessagesLabel().text = UIDeadPanel.DescribeContentColor .. "你阵亡了[-]"
        end
        UIDeadPanel.RefreshIsAbleToReliveSitu()
        if (CS.CSMapManager.Instance.mapInfoTbl.autoRelive ~= nil and CS.CSMapManager.Instance.mapInfoTbl.autoRelive.list.Count >= 2) then
            UIDeadPanel:GetBtnFreeRelive_CountDownLabel():StartCountDown(UIDeadPanel:GetBtnFreeRelive_UILabel().text .. " {0}", CS.CSMapManager.Instance.mapInfoTbl.autoRelive.list[1])
        end
        local freeCount = UIDeadPanel:GetFreeReliveCount();
        freeCount = freeCount < 0 and 0 or freeCount;
        local colorStr = freeCount <= 0 and "[FF4500]" or "[00ff00]";
        UIDeadPanel:GetFreeCount_Text().text = "[c9b394]剩余免费" .. colorStr .. freeCount .. "[-]次";
        UIDeadPanel:GetFreeCount_Text().gameObject:SetActive((freeCount > 0));
        UIDeadPanel:GetReliveCostItemIcon_UISprite().gameObject:SetActive(freeCount <= 0);
        local itemId = UIDeadPanel:GetMapHereReliveCostItemId();
        local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
        if (isFindItem) then
            UIDeadPanel:GetReliveCostItemIcon_UISprite().spriteName = itemTable.icon;
        end
        UIDeadPanel:GetReliveCostValue_Text().text = tostring(UIDeadPanel:GetMapHereReliveCostNeedValue());
        UIDeadPanel:GetReliveCostValue_Text().gameObject:SetActive(freeCount <= 0);
        UIDeadPanel:RefreshDropItems()
        self:RefreshNotDropPrompt()
    end
end

---获取凶手名
---@return string
function UIDeadPanel.GetKillerName()
    local killerInScene = CS.CSScene.Sington:getAvatar(CS.CSScene.MainPlayerInfo.KillerID)
    --print(CS.CSScene.MainPlayerInfo.KillerID, CS.CSScene.MainPlayerInfo.KillerName)
    if (CS.Cfg_GlobalTableManager.CfgInstance:IsLangYanMengJingMap(CS.CSScene.getMapID())) then
        ---狼烟梦境地图特殊显示凶手名
        if killerInScene ~= nil then
            if killerInScene.AvatarType == CS.EAvatarType.Player then
                return "[f8debc]" .. "同梦者[-]"
            else
                return "[e85038]" .. CS.CSScene.MainPlayerInfo.KillerName .. "[-]"
            end
        else
            return "[f8debc]" .. "同梦者[-]"
        end
    else
        if (CS.CSScene.MainPlayerInfo.KillerName ~= nil) then
            if killerInScene ~= nil then
                if killerInScene.AvatarType == CS.EAvatarType.Player then
                    return "[f8debc]" .. CS.CSScene.MainPlayerInfo.KillerName .. "[-]"
                else
                    return "[e85038]" .. CS.CSScene.MainPlayerInfo.KillerName .. "[-]"
                end
            else
                return "[f8debc]" .. CS.CSScene.MainPlayerInfo.KillerName .. "[-]"
            end
        end
    end
    return nil
end

---刷新掉落的物品
---@public
function UIDeadPanel:RefreshDropItems()
    local drops = self:GetDropItems()
    if drops == nil or #drops == 0 then
        self:GetDropGameObject():SetActive(false)
        self:GetDeadMessagesLabel().transform.localPosition = { x = -1, y = 84, z = 0 }
    else
        self:GetDropGameObject():SetActive(true)
        self:GetDeadMessagesLabel().transform.localPosition = { x = -1, y = 84, z = 0 }
        self:GetDropGridController().MaxCount = #drops
        for i = 1, #drops do
            ---@type UnityEngine.GameObject
            local go = self:GetDropGridController().controlList[i - 1]
            local bagItem = drops[i]
            ---@type UISprite
            local iconSprite = self:GetComp(go.transform, "icon", "UISprite")
            iconSprite.spriteName = bagItem.ItemTABLE.icon
            ---@type UILabel
            local countLabel = self:GetComp(go.transform, "count", "UILabel")
            countLabel.text = bagItem.count < 2 and "" or tostring(bagItem.count)
            CS.UIEventListener.Get(go).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({
                    bagItemInfo = bagItem,
                    showRight = false,
                })
            end
        end
    end
end

---获取掉落的物品
---@return table<number, bagV2.BagItemInfo>
function UIDeadPanel:GetDropItems()
    local drops
    if uiStaticParameter.mDeadAndDropItemParam ~= nil and uiStaticParameter.mDeadAndDropItemTime ~= nil then
        if CS.UnityEngine.Time.time < uiStaticParameter.mDeadAndDropItemTime + 5 then
            --5s内的数据才有效,超过5s则认为数据无效了
            drops = uiStaticParameter.mDeadAndDropItemParam
        end
        uiStaticParameter.mDeadAndDropItemParam = nil
        uiStaticParameter.mDeadAndDropItemTime = nil
    end
    return drops
end

---刷新是否可以原地复活
function UIDeadPanel.RefreshIsAbleToReliveSitu()
    local currentMapId = CS.CSScene.getMapID()
    local canRelive = false
    local res, tableInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(currentMapId)
    if res then
        canRelive = tableInfo.canHereRelive == 1
    end
    local isInShaBaKPrisonSafeArea = false;
    if (CS.CSScene.MainPlayerInfo) then
        isInShaBaKPrisonSafeArea = CS.CSScene.MainPlayerInfo:IsInShaBaKPrisonSafeArea();
    end
    --UIDeadPanel.mIsAbleToReliveSitu = CS.CSMapManager.Instance.mapInfoTbl.canHereRelive == 1
    UIDeadPanel.mIsAbleToReliveSitu = canRelive;
    local isSavacActivityShowBtn = UIDeadPanel.IsSabacShowRelive()
    --if UIDeadPanel.mIsAbleToReliveSitu or isSavacActivityShowBtn or canRelive then
    if UIDeadPanel.mIsAbleToReliveSitu then
        if (isInShaBaKPrisonSafeArea) then
            UIDeadPanel:GetBtn_ReliveInPlace():SetActive(false)
            local pos = CS.UnityEngine.Vector3(0, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.y, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.z);
            UIDeadPanel:GetBtn_FreeRelive().transform.localPosition = pos;
        elseif (isSavacActivityShowBtn) then
            UIDeadPanel:GetBtn_ReliveInPlace():SetActive(false)
            local pos = CS.UnityEngine.Vector3(0, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.y, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.z);
            UIDeadPanel:GetBtn_FreeRelive().transform.localPosition = pos;
        end
    else
        UIDeadPanel:GetBtn_ReliveInPlace():SetActive(false)
        local pos = CS.UnityEngine.Vector3(0, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.y, UIDeadPanel:GetBtn_FreeRelive().transform.localPosition.z);
        UIDeadPanel:GetBtn_FreeRelive().transform.localPosition = pos;
    end
end

--region 不掉落提示
---刷新不掉落提示显示
function UIDeadPanel:RefreshNotDropPrompt()
    self:GetDeadNotDropPrompt_GO():SetActive(self:IsShowNotDropPrompt())
end

---@return boolean 是否显示不掉落提示
function UIDeadPanel:IsShowNotDropPrompt()
    local mapId = CS.CSScene.getMapID()
    local res, data = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
    if res then
        if data.canNoDropOfDie == 1 then
            local killerInScene = CS.CSScene.Sington:getAvatar(CS.CSScene.MainPlayerInfo.KillerID)
            if killerInScene and killerInScene.AvatarType == CS.EAvatarType.Player then
                return true
            end
        end
    end
    return false
end
--endregion
--endregion

---沙巴克地图不显示立即复活按钮
function UIDeadPanel.IsSabacShowRelive()
    local isOpenAndInMap = Utility.IsSabacActivityChangeMissionPanel()
    if isOpenAndInMap then
        UIDeadPanel:GetBtnFreeRelive_UILabel().text = "[C3F4FF]立即复活"
        return true;
    else
        UIDeadPanel:GetBtnFreeRelive_UILabel().text = "[C3F4FF]复活"
    end
    return false
end

function UIDeadPanel.CloseDeadAudio()
    if UIDeadPanel.DeadAudio ~= nil and CS.CSAudioMgr.Instance ~= nil then
        CS.CSAudioMgr.Instance:RemoveAudio(UIDeadPanel.DeadAudio)
    end
end

--region 事件
---免费复活按钮点击事件
function UIDeadPanel.OnClickBtn_FreeRelive(obj)

    if UIDeadPanel.mIsReliveMsgSended then
        return
    end
    UIDeadPanel.mIsReliveMsgSended = true
    local autoRelive = CS.CSMapManager.Instance.mapInfoTbl.autoRelive
    if (autoRelive ~= nil and autoRelive.list.Count >= 2) then
        if autoRelive.list[0] == 1 then
            networkRequest.ReqPlayerRelive(1)
        else
            networkRequest.ReqPlayerRelive(0)
        end
    else
        networkRequest.ReqPlayerRelive(0)
    end
end

---添加次数按钮点击事件
function UIDeadPanel.OnClickBtnAddCount()
    if UIDeadPanel.mIsReliveMsgSended then
        return
    end
    Utility.TryShowFirstRechargePanel()
end

---原地复活按钮点击事件
function UIDeadPanel.OnClickBtn_ReliveInPlace(obj)
    UIDeadPanel:CheckIsNeedCloseSelf();

    if UIDeadPanel.mIsReliveMsgSended then
        return
    end
    if (UIDeadPanel.mIsReliveDelay) then
        return ;
    end
    --
    --local tableValue = UIDeadPanel:GetMapHereReliveCost();
    local itemId = UIDeadPanel:GetMapHereReliveCostItemId();
    local isFindItem, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId);
    local mNum = 0;
    if (isFindItem) then
        if (itemTable.type == luaEnumItemType.Coin) then
            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemId);
        else
            mNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(itemId);
        end

        local needNum = UIDeadPanel:GetMapHereReliveCostNeedValue();
        --local freeCount = UIDeadPanel:GetFreeReliveCount();
        local SureRelive = function()
            if (mNum >= needNum) then
                --uimanager:ClosePanel("UIPromptPanel", nil);
                if (UIDeadPanel.mCoroutineDelayTime ~= nil) then
                    StopCoroutine(UIDeadPanel.mCoroutineDelayTime);
                    UIDeadPanel.mCoroutineDelayTime = nil;
                end
                UIDeadPanel:GetReliveCD().enabled = false;
                UIDeadPanel:GetBtnFreeRelive_UILabel().text = "[C3F4FF]复活";
                uimanager:ClosePanel("UIPromptPanel", nil);
                UIDeadPanel:GetReliveDelay().gameObject:SetActive(true);
                UIDeadPanel:GetJustReliveLabel_GameObject():SetActive(false);
                UIDeadPanel:GetReliveDelay():StartCountDown(luaEnumColorType.Red .. "{0}[-]", 4)
                UIDeadPanel.mCoroutineDelayTime = StartCoroutine(UIDeadPanel.IEnumDelayedResurrection, 3);
                UIDeadPanel.mIsReliveMsgSended = true
                networkRequest.ReqPlayerRelive(2)--请求原地复活
            else
                if (itemTable.type == luaEnumItemType.Coin) then
                    if (gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false) then
                        return uimanager:CreatePanel("UIRechargeFirstTips", nil, { PanelLayerType = CS.UILayerType.TipsPlane });
                    else
                        return uiTransferManager:TransferToPanel(LuaEnumTransferType.Recharge, { PanelLayerType = CS.UILayerType.TipsPlane });
                    end
                else
                    local TipsInfo = {}
                    TipsInfo[LuaEnumTipConfigType.Describe] = itemTable.name .. "不足";
                    TipsInfo[LuaEnumTipConfigType.Parent] = UIDeadPanel:GetBtn_ReliveInPlace().transform;
                    TipsInfo[LuaEnumTipConfigType.ConfigID] = 23
                    return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
                end
            end
        end

        SureRelive();
    end

end

function UIDeadPanel.IEnumDelayedResurrection(delayTime)
    UIDeadPanel.mIsReliveDelay = true;
    coroutine.yield(CS.UnityEngine.WaitForSeconds(delayTime))
    UIDeadPanel.mIsReliveDelay = false;
    if isOpenLog then
        CS.UnityEngine.Debug.LogWarning("买活，关闭死亡面板")
    end
    uimanager:ClosePanel("UIDeadPanel");
end
--endregion

function update()
    if (CS.CSScene.IsLanuchMainPlayer and CS.CSScene.MainPlayerInfo.HP > 0) then
        uimanager:ClosePanel("UIDeadGrayPanel")
        uimanager:ClosePanel("UIDeadPanel")
        if isOpenLog then
            CS.UnityEngine.Debug.LogWarning("玩家当前血量" .. CS.CSScene.MainPlayerInfo.HP .. ",关闭死亡面板")
        end
    else
        CS.CSScene.MainPlayerInfo.MainPlayerIsResurgence = false
    end
end

function ondestroy()
    UIDeadPanel.CloseDeadAudio()
    uimanager:ClosePanel("UIDeadGrayPanel")
    uimanager:ClosePanel("UIItemInfoPanel")
end

return UIDeadPanel