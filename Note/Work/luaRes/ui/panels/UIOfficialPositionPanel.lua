---@class UIOfficialPositionPanel:UIBase 官印面板
local UIOfficialPositionPanel = {}
--region 最近变量
UIOfficialPositionPanel.mCurIconMiddlePos = CS.UnityEngine.Vector3(107.5, 0, 0)
UIOfficialPositionPanel.mCurIconDefaultPos = CS.UnityEngine.Vector3.zero
UIOfficialPositionPanel.mNextIconMiddlePos = CS.UnityEngine.Vector3(-115, 0, 0)
UIOfficialPositionPanel.mNextIconDefaultPos = CS.UnityEngine.Vector3.zero
--endregion

--region 组件
function UIOfficialPositionPanel:GetCurOfficialArrow_GameObject()
    if (self.mCurOfficialArrowGo == nil) then
        self.mCurOfficialArrowGo = self:GetCurComp("WidgetRoot/view/Official/arrow", "GameObject")
    end
    return self.mCurOfficialArrowGo
end

function UIOfficialPositionPanel:GetCurOfficialStage_GameObject()
    if (self.mCurOfficialStateGo == nil) then
        self.mCurOfficialStateGo = self:GetCurComp("WidgetRoot/view/Official/curOfficial", "GameObject")
    end
    return self.mCurOfficialStateGo
end

function UIOfficialPositionPanel:GetNextOfficialStage_GameObject()
    if (self.mNextOfficialStateGo == nil) then
        self.mNextOfficialStateGo = self:GetCurComp("WidgetRoot/view/Official/nextOfficial", "GameObject")
    end
    return self.mNextOfficialStateGo
end

function UIOfficialPositionPanel:GetCurOfficialStage_Transform()
    if (self.mCurOfficialStateTrans == nil) then
        self.mCurOfficialStateTrans = self:GetCurComp("WidgetRoot/view/Official/curOfficial", "Transform")
    end
    return self.mCurOfficialStateTrans
end

function UIOfficialPositionPanel:GetNextOfficialStage_Transform()
    if (self.mNextOfficialStateTrans == nil) then
        self.mNextOfficialStateTrans = self:GetCurComp("WidgetRoot/view/Official/nextOfficial", "Transform")
    end
    return self.mNextOfficialStateTrans
end

function UIOfficialPositionPanel:GetCurOfficialStage_UILabel()
    if (self.mCurOfficialStateUILabel == nil) then
        self.mCurOfficialStateUILabel = self:GetCurComp("WidgetRoot/view/Official/curOfficial/stage", "Top_UILabel")
    end
    return self.mCurOfficialStateUILabel
end

function UIOfficialPositionPanel:GetCurOfficialPosition_UILabel()
    if (self.mCurOfficialPositionUILabel == nil) then
        self.mCurOfficialPositionUILabel = self:GetCurComp("WidgetRoot/view/Official/curOfficial/position", "Top_UILabel")
    end
    return self.mCurOfficialPositionUILabel
end

function UIOfficialPositionPanel:GetNextOfficialStage_UILabel()
    if (self.mNextOfficialStateUILabel == nil) then
        self.mNextOfficialStateUILabel = self:GetCurComp("WidgetRoot/view/Official/nextOfficial/stage", "Top_UILabel")
    end
    return self.mNextOfficialStateUILabel
end

function UIOfficialPositionPanel:GetNextOfficialPosition_UILabel()
    if (self.mNextOfficialPositionUILabel == nil) then
        self.mNextOfficialPositionUILabel = self:GetCurComp("WidgetRoot/view/Official/nextOfficial/position", "Top_UILabel")
    end
    return self.mNextOfficialPositionUILabel
end

function UIOfficialPositionPanel:GetAttributeGrid_Container()
    if (self.mAttributeGrid == nil) then
        self.mAttributeGrid = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist", "Top_UIGridContainer")
    end
    return self.mAttributeGrid
end

function UIOfficialPositionPanel:GetCurAttack_UILabel()
    if (self.mCurAttack == nil) then
        self.mCurAttack = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute1/curattribute/attack", "UILabel")
    end
    return self.mCurAttack
end

function UIOfficialPositionPanel:GetNextAttack_UILabel()
    if (self.mNextAttack == nil) then
        self.mNextAttack = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute1/nextattribute/attack", "UILabel")
    end
    return self.mNextAttack
end

function UIOfficialPositionPanel:GetCurAttackName_UILabel()
    if (self.mCurAttackName == nil) then
        self.mCurAttackName = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute1/curattribute/attack/name", "UILabel")
    end
    return self.mCurAttackName
end

function UIOfficialPositionPanel:GetCurDropName_UILabel()
    if (self.mCurDropName == nil) then
        self.mCurDropName = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute2/curattribute/attack/name", "UILabel")
    end
    return self.mCurDropName
end

function UIOfficialPositionPanel:GetCurDrop_UILabel()
    if (self.mCurDrop == nil) then
        self.mCurDrop = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute2/curattribute/attack", "UILabel")
    end
    return self.mCurDrop
end

function UIOfficialPositionPanel:GetNextDrop_UILabel()
    if (self.mNextDrop == nil) then
        self.mNextDrop = self:GetCurComp("WidgetRoot/view/Attribute/Scroll View/arributelist/arribute2/nextattribute/attack", "UILabel")
    end
    return self.mNextDrop
end

function UIOfficialPositionPanel:GetNextLevelCost_UILabel()
    if (self.mNextLevelCostUILabel == nil) then
        self.mNextLevelCostUILabel = self:GetCurComp("WidgetRoot/view/nextCombat/label", "Top_UILabel")
    end
    return self.mNextLevelCostUILabel
end

function UIOfficialPositionPanel:GetNextLevelCost_UISprite()
    if (self.mNextLevelCostUISprite == nil) then
        self.mNextLevelCostUISprite = self:GetCurComp("WidgetRoot/view/nextCombat/img", "Top_UISprite")
    end
    return self.mNextLevelCostUISprite
end

function UIOfficialPositionPanel:GetNextLevelImgCost_GameObject()
    if (self.mNextLevelimgCostGo == nil) then
        self.mNextLevelimgCostGo = self:GetCurComp("WidgetRoot/view/nextCombat/img", "GameObject")
    end
    return self.mNextLevelimgCostGo
end

function UIOfficialPositionPanel:GetNeedLevel_UILabel()
    if (self.mNeedLevelUILabel == nil) then
        self.mNeedLevelUILabel = self:GetCurComp("WidgetRoot/events/needlevel", "UILabel")
    end
    return self.mNeedLevelUILabel
end

function UIOfficialPositionPanel:GetNeedLevel_GameObject()
    if (self.mNeedLevelGo == nil) then
        self.mNeedLevelGo = self:GetCurComp("WidgetRoot/events/needlevel", "GameObject")
    end
    return self.mNeedLevelGo
end

function UIOfficialPositionPanel:GetNextLevelCost_GameObject()
    if (self.mNextLevelCostGo == nil) then
        self.mNextLevelCostGo = self:GetCurComp("WidgetRoot/view/nextCombat", "GameObject")
    end
    return self.mNextLevelCostGo
end

function UIOfficialPositionPanel:GetAddBtn_GameObject()
    if (self.mAddBtn == nil) then
        self.mAddBtn = self:GetCurComp("WidgetRoot/events/addBtn", "GameObject")
    end
    return self.mAddBtn
end

function UIOfficialPositionPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

function UIOfficialPositionPanel:GetLevelUpBtn_GameObject()
    if (self.mLevelUpBtn == nil) then
        self.mLevelUpBtn = self:GetCurComp("WidgetRoot/events/btn_up", "GameObject")
    end
    return self.mLevelUpBtn
end

function UIOfficialPositionPanel:GetHelpBtn_GameObject()
    if (self.mHelpBtn == nil) then
        self.mHelpBtn = self:GetCurComp("WidgetRoot/events/helpBtn", "GameObject")
    end
    return self.mHelpBtn
end

function UIOfficialPositionPanel:GetLevelUpBtn_UILabel()
    if (self.mLevelUpBtnUILabel == nil) then
        self.mLevelUpBtnUILabel = self:GetCurComp("WidgetRoot/events/btn_up/Label", "Top_UILabel")
    end
    return self.mLevelUpBtnUILabel
end

function UIOfficialPositionPanel:GeCanLevelUpSuccessEffect_GameObject()
    if (self.mCanLevelUpSuccessEffect == nil) then
        self.mCanLevelUpSuccessEffect = self:GetCurComp("WidgetRoot/events/btn_up/effect", "GameObject")
    end
    return self.mCanLevelUpSuccessEffect
end

function UIOfficialPositionPanel:GetSuccessEffect_GameObject()
    if (self.mSuccessEffect == nil) then
        self.mSuccessEffect = self:GetCurComp("WidgetRoot/Game", "GameObject")
    end
    return self.mSuccessEffect
end

function UIOfficialPositionPanel:GetLevelMax_GameObject()
    if (self.mLevelMax == nil) then
        self.mLevelMax = self:GetCurComp("WidgetRoot/view/max", "GameObject")
    end
    return self.mLevelMax
end

function UIOfficialPositionPanel:GetGameMgrOfficialInfo()
    return gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo()
end

--region 虎符
---@return UnityEngine.GameObject 选择按钮
function UIOfficialPositionPanel:GetChooseBtn_GO()
    if self.mChooseBtn == nil then
        self.mChooseBtn = self:GetCurComp("WidgetRoot/events/Choose", "GameObject")
    end
    return self.mChooseBtn
end

---@return UnityEngine.GameObject 背景按钮
function UIOfficialPositionPanel:GetHuFuBg_GO()
    if self.mHuFuBgGO == nil then
        self.mHuFuBgGO = self:GetCurComp("WidgetRoot/view/HuFu/background/Sprite", "GameObject")
    end
    return self.mHuFuBgGO
end

---@return UISprite icon
function UIOfficialPositionPanel:GetHuFuIcon_UISprite()
    if self.mHuFuSp == nil then
        self.mHuFuSp = self:GetCurComp("WidgetRoot/view/HuFu/icon", "UISprite")
    end
    return self.mHuFuSp
end

---@return UnityEngine.GameObject 虎符按钮
function UIOfficialPositionPanel:GetHuFuBtn_GO()
    if self.mHuFuBtnGo == nil then
        self.mHuFuBtnGo = self:GetCurComp("WidgetRoot/view/HuFu", "GameObject")
    end
    return self.mHuFuBtnGo
end


---@return UnityEngine.GameObject 虎符激活特效
function UIOfficialPositionPanel:GetHuFuActiveEffect_GO()
    if self.mHuFuActiveEffect_GO == nil then
        self.mHuFuActiveEffect_GO = self:GetCurComp("WidgetRoot/view/HuFu/effect_active", "GameObject")
    end
    return self.mHuFuActiveEffect_GO
end
--endregion
--endregion

--region 初始化
function UIOfficialPositionPanel:Init()
    self:BindMessage()
    self:BindUIEvents()
end

function UIOfficialPositionPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOfficialInfoV2Message, function(msgId,data)
        self:RefreshUIPanel()
        self:RefreshHuFuShow()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function()
        self:RefreshCostItem()
        self:RefreshLevelUpCondition()
    end)
end

function UIOfficialPositionPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).onClick = function(go)
        self:HelpBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function(go)
        self:CloseBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).onClick = function(go)
        self:LevelUpbtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetAddBtn_GameObject()).onClick = function(go)
        self:AddBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetChooseBtn_GO()).onClick = function()
        self:OpenHuFu()
    end
    CS.UIEventListener.Get(self:GetNextLevelImgCost_GameObject()).onClick = function(go)
        self:NextLevelCostOnClick(go)
    end
    ---角色等级变化事件
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshUIPanel()
    end)
end

---@param customData
function UIOfficialPositionPanel:Show(customData)
    if customData then
        if customData.isOpenHuFu then
            self:OpenHuFu()
        end
    end
    uiStaticParameter.OfficialPositionLastRefreshOperation = LuaEnumOfficialPositionLastOperationReason.Init
    self:RefreshUIPanel()
    self:RefreshHuFuShow()
end
--endregion

--region 刷新界面
function UIOfficialPositionPanel:RefreshUIPanel()
    --未满级
    if (self:GetGameMgrOfficialInfo():GetNextOfficialTable() ~= nil) then
        self:GetNextLevelCost_GameObject():SetActive(true)
        self:RefreshCostItem()
        self:RefreshAttributeList()
        self:RefreshLevelUpCondition()
        self:RefreshCurAndNextOfficialInfo()
    else
        --满级
        self:RefreshAttributeList()
        self:RefreshCurAndNextOfficialInfo()
        self:GetNextLevelCost_GameObject():SetActive(false)
        self:GetAddBtn_GameObject():SetActive(false)
        self:GetLevelUpBtn_GameObject():SetActive(false)
        self:GetLevelMax_GameObject():SetActive(true)
    end
end

---检测此次升级等级条件是否满足
function UIOfficialPositionPanel:RefreshLevelUpCondition()
    ---未满足条件
    if (not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(self:GetGameMgrOfficialInfo():getCurLevelUpConditionsId())) then
        local find, level = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(self:GetGameMgrOfficialInfo():getCurLevelUpConditionsId()[1])
        if (find and level.conditionParam.list ~= nil) then
            self:GetNeedLevel_GameObject():SetActive(true)
            self:GetNeedLevel_UILabel().text = level.conditionParam.list[0]
            self:GetAddBtn_GameObject():SetActive(false)
            self:GetLevelUpBtn_GameObject():SetActive(false)
            self:GetNextLevelCost_GameObject():SetActive(false)
            self:GeCanLevelUpSuccessEffect_GameObject():SetActive(false)
        end
    else
        ---满足条件
        self:GetAddBtn_GameObject():SetActive(true)
        self:GetNeedLevel_GameObject():SetActive(false)
        self:GetLevelUpBtn_GameObject():SetActive(true)
        self:GetNextLevelCost_GameObject():SetActive(true)
        if (gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId()) >= self:GetGameMgrOfficialInfo():getCurLevelUpCostItemCount()) then
            self:GeCanLevelUpSuccessEffect_GameObject():SetActive(true)
        else
            self:GeCanLevelUpSuccessEffect_GameObject():SetActive(false)
        end
    end
end

---刷新界面当前等级和下级图标显示
function UIOfficialPositionPanel:RefreshCurAndNextOfficialInfo()
    if (self:GetGameMgrOfficialInfo():GetCurOfficialTable() ~= nil) then
        --已开启官阶
        self:GetLevelUpBtn_UILabel().text = "提升官阶"
        self:GetCurOfficialStage_UILabel().text = self:GetGameMgrOfficialInfo():GetCurOfficialTable():GetName()
        self:GetCurOfficialPosition_UILabel().text = self:GetGameMgrOfficialInfo():GetCurOfficialTable():GetLastname()
        self:GetNextOfficialStage_Transform().localPosition = self.mNextIconDefaultPos
        self:GetCurOfficialStage_GameObject():SetActive(true)
        self:GetCurOfficialArrow_GameObject():SetActive(true)
        if (self:GetGameMgrOfficialInfo():GetNextOfficialTable() ~= nil) then
            --普通阶段
            self:GetNextOfficialStage_UILabel().text = self:GetGameMgrOfficialInfo():GetNextOfficialTable():GetName()
            self:GetNextOfficialPosition_UILabel().text = self:GetGameMgrOfficialInfo():GetNextOfficialTable():GetLastname()
            self:GetNextOfficialStage_GameObject():SetActive(true)
            self:GetCurOfficialStage_Transform().localPosition = self.mCurIconDefaultPos
        else
            --满阶
            self:GetNeedLevel_GameObject():SetActive(false)
            self:GetCurOfficialArrow_GameObject():SetActive(false)
            self:GetNextOfficialStage_GameObject():SetActive(false)
            self:GetCurOfficialStage_Transform().localPosition = self.mCurIconMiddlePos
        end
    else
        --未开启官阶
        self:GetCurOfficialArrow_GameObject():SetActive(false)
        self:GetCurOfficialStage_GameObject():SetActive(false)
        self:GetLevelUpBtn_UILabel().text = "开启官阶"
        self:GetNextOfficialStage_Transform().localPosition = self.mNextIconMiddlePos
    end
end

---刷新升级所需花费Item的Icon和数量
function UIOfficialPositionPanel:RefreshCostItem()
    local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId())
    if (isfind) then
        self:GetNextLevelCost_UISprite().spriteName = itemInfo.icon
        self:GetNextLevelCost_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId()), self:GetGameMgrOfficialInfo():getCurLevelUpCostItemCount())
    end
end

---刷新升级官阶的属性
function UIOfficialPositionPanel:RefreshAttributeList()
    self:GetCurAttackName_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    self:GetCurDropName_UILabel().text = "掉宝概率"
    if (self:GetGameMgrOfficialInfo():GetCurOfficialTable() ~= nil) then
        self:GetCurAttack_UILabel().text = self:GetGameMgrOfficialInfo():GetCurOfficialTable():GetAtt() .. " - " .. self:GetGameMgrOfficialInfo():GetCurOfficialTable():GetAttMax()
        self:GetCurDrop_UILabel().text = tostring(math.floor(self:GetGameMgrOfficialInfo():GetCurOfficialTable():GetDropItemRate() / 1000)) .. "%[-]"
        if (self:GetGameMgrOfficialInfo():GetNextOfficialTable() ~= nil) then
            self:GetNextAttack_UILabel().text = "[00ff00]" .. self:GetGameMgrOfficialInfo():GetNextOfficialTable():GetAtt() .. " - " .. self:GetGameMgrOfficialInfo():GetNextOfficialTable():GetAttMax()
            self:GetNextDrop_UILabel().text = "[00ff00]" .. tostring(math.floor(self:GetGameMgrOfficialInfo():GetNextOfficialTable():GetDropItemRate() / 1000)) .. "%[-]"
        else
            self:GetNextAttack_UILabel().text = "[00ff00]已达到最大[-]"
            self:GetNextDrop_UILabel().text = "[00ff00]已达到最大[-]"
        end
    else
        self:GetCurAttack_UILabel().text = "0 - 0"
        self:GetNextAttack_UILabel().text = "[00ff00]" .. self:GetGameMgrOfficialInfo():GetFirstLevelOfficalTable():GetAtt() .. "-" .. self:GetGameMgrOfficialInfo():GetFirstLevelOfficalTable():GetAttMax() .. "[-]"
        self:GetCurDrop_UILabel().text = "0"
        self:GetNextDrop_UILabel().text = "[00ff00]" .. tostring(math.floor(self:GetGameMgrOfficialInfo():GetFirstLevelOfficalTable():GetDropItemRate() / 1000)) .. "%[-]"
    end
end
--endregion

--region 客户端事件
function UIOfficialPositionPanel:HelpBtnOnClick(go)
    Utility.ShowHelpPanel({ id = 186 })
end

function UIOfficialPositionPanel:CloseBtnOnClick(go)
    uimanager:ClosePanel("UIOfficialPositionPanel")
end

function UIOfficialPositionPanel:LevelUpbtnOnClick(go)
    if (self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId() ~= 0 and
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId())
                    >= self:GetGameMgrOfficialInfo():getCurLevelUpCostItemCount()) then
        uiStaticParameter.OfficialPositionLastRefreshOperation = LuaEnumOfficialPositionLastOperationReason.UpOfficialPosition
        networkRequest.ReqOfficialUpgradeV2()
        self:GetSuccessEffect_GameObject():SetActive(false)
        self:GetSuccessEffect_GameObject():SetActive(true)
    else
        self:ShowTips(go, 453)
    end
end

function UIOfficialPositionPanel:NextLevelCostOnClick(go)
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(1000045) })
end

function UIOfficialPositionPanel:AddBtnOnClick(go)
    Utility.ShowItemGetWay(self:GetGameMgrOfficialInfo():getCurLevelUpCostItemId(), go, LuaEnumWayGetPanelArrowDirType.Left);
end

---@param trans GameObject 按钮
---@param str string    内容
---@param id  number    提示框id
function UIOfficialPositionPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 虎符
function UIOfficialPositionPanel:OpenHuFu()
    uimanager:CreatePanel("UIHuFuPanel")
end

---刷新虎符显示
function UIOfficialPositionPanel:RefreshHuFuShow()
    local official = self:GetGameMgrOfficialInfo():GetOfficialInfo()
    if official then
        local tokenIId = official.emperorTokenId
        local hasHuFu = tokenIId ~= 0
        self:GetHuFuBg_GO():SetActive(not hasHuFu)
        self:GetHuFuIcon_UISprite().gameObject:SetActive(hasHuFu)
        if uiStaticParameter.OfficialPositionLastRefreshOperation == LuaEnumOfficialPositionLastOperationReason.ActiveHuFu and hasHuFu then
            self:PlayActiveHuFuEffect()
        else
            self:CloseActiveHuFuEffect()
        end
        local color = official.emperorTokenValid ~= 0 and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.Grey
        self:GetHuFuIcon_UISprite().color = color
        if hasHuFu then
            local luaTokenInfo = clientTableManager.cfg_official_emperor_tokenManager:TryGetValue(tokenIId)
            if luaTokenInfo then
                local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(luaTokenInfo:GetLinkItemId())
                if res then
                    self:GetHuFuIcon_UISprite().spriteName = itemInfo.icon
                    CS.UIEventListener.Get(self:GetHuFuBtn_GO()).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo })
                    end
                end
            end
        else
            CS.UIEventListener.Get(self:GetHuFuBtn_GO()).onClick = function()
                self:OpenHuFu()
            end
        end
    end
end

---播放激活虎符特效
function UIOfficialPositionPanel:PlayActiveHuFuEffect()
    luaclass.UIRefresh:RefreshActive(self:GetHuFuActiveEffect_GO(),false)
    luaclass.UIRefresh:RefreshActive(self:GetHuFuActiveEffect_GO(),true)
end

---关闭激活虎符特效
function UIOfficialPositionPanel:CloseActiveHuFuEffect()
    luaclass.UIRefresh:RefreshActive(self:GetHuFuActiveEffect_GO(),false)
end
--endregion

function ondestroy()
    uimanager:ClosePanel("UIHuFuPanel")
    uimanager:ClosePanel("UIRefineOfficialPanel")
end

return UIOfficialPositionPanel