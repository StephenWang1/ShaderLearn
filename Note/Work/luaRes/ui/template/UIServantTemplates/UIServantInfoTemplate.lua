---灵兽界面头像
---@class UIServantInfoTemplate:TemplateBase
local UIServantInfoTemplate = {}

--region 变量
UIServantInfoTemplate.infoInstance = nil
UIServantInfoTemplate.index = 0;
---@type UIServantPanel
UIServantInfoTemplate.ServantPanel = nil;
UIServantInfoTemplate.Self = nil
---@type LuaEnumPanelOpenSourceType 灵兽界面打开来源类型
UIServantInfoTemplate.openServantPanelType = nil
--endregion

--region 属性
function UIServantInfoTemplate:GetReliveCD()
    if self.mReliveCD == nil then
        self.mReliveCD = self:Get("deadtime", "CountDownTimeLabel")
    end
    return self.mReliveCD
end

function UIServantInfoTemplate:GetEffectRoot_GameObejct()
    if self.mEffectRoot == nil then
        self.mEffectRoot = self:Get("EffectRoot", "GameObject")
    end
    return self.mEffectRoot
end

function UIServantInfoTemplate:GetBtnUse_GameObject()
    if (self.mBtnUse_GameObject == nil) then
        self.mBtnUse_GameObject = self:Get("ModelBG/btnUse", "GameObject");
    end
    return self.mBtnUse_GameObject;
end

function UIServantInfoTemplate:GetBtnUseLight_GameObject()
    if (self.mBtnUseLight_GameObject == nil) then
        self.mBtnUseLight_GameObject = self:Get("ModelBG/btnUse/light", "GameObject");
    end
    return self.mBtnUseLight_GameObject;
end

function UIServantInfoTemplate:GetLock_GameObject()
    if (self.mLock_GameObject == nil) then
        self.mLock_GameObject = self:Get("Lock", "GameObject");
    end
    return self.mLock_GameObject;
end

---@return UnityEngine.GameObject
function UIServantInfoTemplate:GetLockTipsText_GameObject()
    if (self.mLockTipsText_GameObject == nil) then
        self.mLockTipsText_GameObject = self:Get("Lock/LockTipsText", "GameObject");
    end
    return self.mLockTipsText_GameObject;
end

---@return UnityEngine.GameObject
function UIServantInfoTemplate:GetMemberBtn_GameObject()
    if (self.mMemberBtn_GameObject == nil) then
        self.mMemberBtn_GameObject = self:Get("Lock/btn_member", "GameObject");
    end
    return self.mMemberBtn_GameObject;
end

---锁tips文本
---@return UILabel
function UIServantInfoTemplate:GetLockTipsTextLabel()
    if self.mLockTipsText_Label == nil then
        self.mLockTipsText_Label = self:Get("Lock/LockTipsText", "UILabel")
    end
    return self.mLockTipsText_Label
end

---使用提示
---@return UILabel
function UIServantInfoTemplate:GetUseTipsTextLabel()
    if self.mUseTipsTextLabel == nil then
        self.mUseTipsTextLabel = self:Get("ModelBG/UseTipsText", "UILabel")
    end
    return self.mUseTipsTextLabel
end

function UIServantInfoTemplate:GetDeblock_GameObject()
    if (self.mDeblock_GameObject == nil) then
        self.mDeblock_GameObject = self:Get("Lock/btn_deblocking", "GameObject");
    end
    return self.mDeblock_GameObject;
end

function UIServantInfoTemplate:GetLockCost_GameObject()
    if (self.mLockCost == nil) then
        self.mLockCost = self:Get("Lock/CostItem", "GameObject");
    end
    return self.mLockCost;
end

function UIServantInfoTemplate:GetDeblockFirst_UILabel()
    if (self.mDeblockFirst_UILabel == nil) then
        self.mDeblockFirst_UILabel = self:Get("Lock/CostItem/Diamonds/Label", "Top_UILabel");
    end
    return self.mDeblockFirst_UILabel;
end

function UIServantInfoTemplate:GetDeblockSecond_UILabel()
    if (self.mDeblockSecond_UILabel == nil) then
        self.mDeblockSecond_UILabel = self:Get("Lock/CostItem/GoldIngot/Label", "Top_UILabel");
    end
    return self.mDeblockSecond_UILabel;
end

function UIServantInfoTemplate:GetModelBackGround_GameObject()
    if (self.mModelBackGround_GameObject == nil) then
        self.mModelBackGround_GameObject = self:Get("iconHead/backGround", "GameObject")
    end
    return self.mModelBackGround_GameObject;
end

function UIServantInfoTemplate:GetIconShadow_GameObject()
    if (self.mIconShadow_GameObject == nil) then
        self.mIconShadow_GameObject = self:Get("shadow", "GameObject");
    end
    return self.mIconShadow_GameObject
end
--endregion

--region 初始化
---@param openServantPanelType XLua.Cast.Int32
function UIServantInfoTemplate:Init(panel, index, openServantPanelType)
    UIServantInfoTemplate.Self = self
    self.ServantPanel = panel;
    self.index = index;
    self.info = self.ServantPanel:GetTargetServantInfo(self.index)
    self:InitComponents()
    self:BindMessage()
    self:BindUIEvent()
    if openServantPanelType then
        self.openServantPanelType = openServantPanelType
    end
end

function UIServantInfoTemplate:InitComponents()
    --self.icon = self:Get("icon", "GameObject")
    --self.icon_UISprite = self:Get("icon", "UISprite")
    self.hp_UISprite = self:Get("hp", "UISprite")
    self.ChooseIcon = self:Get("ChooseIcon", "GameObject")
    self.ChooseIconAlpha = self:Get("ChooseIcon", "Top_UISprite")
    self.mode_UILabel = self:Get("mode", "UILabel")
    self.level_UILabel = self:Get("rolelevel", "UILabel")
    self.CanLevelUp_Go = self:Get("canLevelUp", "GameObject")
    self.toggle = CS.Utility_Lua.GetComponent(self.go, "Top_UIToggle")
    self.ModelBG = self:Get("ModelBG", "GameObject")
    self.IsEmpty = true
    self.IsUnLock = true
    self.RedPoint = self:Get("RedPoint", "GameObject")
    self.headIcon_UISprite = self:Get("iconHead", "UISprite")
    self.DiamondTypeToggle = self:Get("Lock/CostItem/Diamonds", "Top_UIToggle")
    self.IngotTypeToggle = self:Get("Lock/CostItem/GoldIngot", "Top_UIToggle")
    self.Costtips = self:Get("Lock/Costtips", "GameObject")
    --self.CosttipsNum = self:Get("Lock/Costtips/price/num", "Top_UILabel")
    --self.CosttipsIcon = self:Get("Lock/Costtips/price/icon", "Top_UISprite")
    --self.mTime_UICountdownLabel = self:Get("Lock/Costtips/Time", "UICountdownLabel")
    self.mRedPointComponent = CS.Utility_Lua.GetComponent(self.RedPoint, "UIRedPoint");
end

function UIServantInfoTemplate:InitParameters()
    if (self.IsUnLock == false) then
        self.id = self.info.servantId
        self.monsterid = self.info.mid
        if (self.id ~= 0) then
            self.IsEmpty = false
            self:ParseData()
        end
    end
end

function UIServantInfoTemplate:BindMessage()
    local servantHeadTemplateSelf = self
    --复活特效
    self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantReborn, function(uiEvtID, data)
        if servantHeadTemplateSelf and servantHeadTemplateSelf.go and data then
            if servantHeadTemplateSelf.info and servantHeadTemplateSelf.info.type == data then
                servantHeadTemplateSelf:ChangeEffectState("700054", true)
            end
        end
    end)
    --升级特效
    self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantLevelUp, function(uiEvtID, data)
        if servantHeadTemplateSelf and servantHeadTemplateSelf.go and data then
            if servantHeadTemplateSelf.info and servantHeadTemplateSelf.info.type == data then
                servantHeadTemplateSelf:ChangeEffectState("700132", true, 1, CS.UnityEngine.Vector3(-4.5, -0.5, 0))
            end
        end
    end)

    if (servantHeadTemplateSelf.DiamondTypeToggle ~= nil) then
        CS.EventDelegate.Add(servantHeadTemplateSelf.DiamondTypeToggle.onChange, function()
            if servantHeadTemplateSelf.DiamondTypeToggle.value then
                servantHeadTemplateSelf.BuySiteType = LuaEnumBuyServantSiteType.Diamond
            end
        end)
    end
    if (servantHeadTemplateSelf.IngotTypeToggle ~= nil) then
        CS.EventDelegate.Add(servantHeadTemplateSelf.IngotTypeToggle.onChange, function()
            if servantHeadTemplateSelf.IngotTypeToggle.value then
                servantHeadTemplateSelf.BuySiteType = LuaEnumBuyServantSiteType.Ingot
            end
        end)
    end
end

function UIServantInfoTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.go).onPress = function(gobj, isPress)
        if (isPress) then
            self.mTimer = 0;
            self.mIsLongPress = true;
        else
            if (self.mTimer < 0.2) then
                self.mIsLongPress = false;
            end
            if (not self.mIsLongPress) then
                if (self.info ~= nil and self.info.servantId ~= 0 and self.ServantPanel.ServantIndex == self.index) then
                    self:TryShowServantTip();
                    self:OnPlayerClickHead();
                else
                    self:OnPlayerClickHead();
                end
            end
        end
    end

    CS.UIEventListener.Get(self:GetBtnUse_GameObject()).onClick = function()
        local bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBestServantEgg(self:GetServantType());
        if (bagItemInfo ~= nil) then
            networkRequest.ReqUseItem(bagItemInfo.count, bagItemInfo.lid, uiStaticParameter.SelectedServantType)
        else
            local TipsInfo = {}
            TipsInfo[LuaEnumTipConfigType.Parent] = self:GetBtnUse_GameObject().transform;
            TipsInfo[LuaEnumTipConfigType.ConfigID] = 61
            uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
        end
    end

    if (self:GetMemberBtn_GameObject() ~= nil) then
        CS.UIEventListener.Get(self:GetMemberBtn_GameObject()).onClick = function()
            uimanager:CreatePanel("UIRechargeMemberPanel")
        end
    end

    --region 前往解锁
    if self:GetDeblock_GameObject() ~= nil then
        --Utility.CheckSystemOpenState(66)
        self:GetDeblock_GameObject():SetActive(false)
--[[        CS.UIEventListener.Get(self:GetDeblock_GameObject()).onClick = function()
            uimanager:CreatePanel("UILsMissionPanel", nil, { jumpSec = self.index + 1 })
        end]]
    end
    --endregion

    --[[    if (self:GetDeblock_GameObject() ~= nil) then
            local tab = CS.Cfg_GlobalTableManager.Instance
            CS.UIEventListener.Get(self:GetDeblock_GameObject()).onClick = function()
                if (self.BuySiteType == LuaEnumBuyServantSiteType.Diamond) then
                    local count = 0
                    if (self.index == 1) then
                        if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1 > CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemDays) then
                            count = CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemCount
                        else
                            count = CS.Cfg_GlobalTableManager.Instance.PurchaseSecondServantNeedItemCount
                        end
                    elseif (self.index == 2) then
                        if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1 > CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemDays) then
                            count = CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemCount
                        else
                            count = CS.Cfg_GlobalTableManager.Instance.PurchaseThirdServantNeedItemCount
                        end
                    end

                    if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(tab.PurchaseSecondServantNeedItemID) >= count) then
                        networkRequest.ReqPurchaseServantSite((self.index + 1), self.BuySiteType)
                    else
                        local type = nil
                        if (self.index == 1) then
                            type = LuaEnumRechargePointEntranceType.SecondServantSiteCurrencyNotEnough
                        elseif (self.index == 2) then
                            type = LuaEnumRechargePointEntranceType.ThirdServantSiteCurrencyNotEnough
                        end
                        Utility.TryShowFirstRechargePanel(type);
                    end
                elseif (self.BuySiteType == LuaEnumBuyServantSiteType.Ingot) then
                    if (CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(tab.PurchaseSecondServantNeedSecondItemID) >= tab.PurchaseSecondServantNeedSecondItemCount) then
                        networkRequest.ReqPurchaseServantSite((self.index + 1), self.BuySiteType)
                    else
                        local type = nil
                        if (self.index == 1) then
                            type = LuaEnumRechargePointType.SecondServantSiteIngotNotEnoughToRewardGift
                            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.SecondServantSiteIngotNotEnough
                        elseif (self.index == 2) then
                            type = LuaEnumRechargePointType.ThirdServantSiteIngotNotEnoughToRewardGift
                            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.ThirdServantSiteIngotNotEnough
                        end
                        Utility.ShowItemGetWay(LuaEnumCoinType.YuanBao, self:GetDeblock_GameObject(), LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, type)
                    end
                end
            end
        end]]
end

function UIServantInfoTemplate:TryShowServantTip()
    local panel = uimanager:GetPanel("UIPetInfoPanel");
    if (panel == nil) then
        local servants
        if (self.ServantPanel.mPanelOpenSourceType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
            servants = self.ServantPanel:GetServantInfo().OtherServants
        else
            servants = self.ServantPanel:GetServantInfo().Servants
        end
        ---@type boolean
        local isFind
        ---@type servantV2.ServantInfo
        local servantInfo
        isFind, servantInfo = servants:TryGetValue(self.index + 1);
        if (isFind and servantInfo.servantEgg ~= nil) then
            local equipsTemp = servantInfo.soulEquips
            if servantInfo.equippedSoul ~= 0 and equipsTemp.Count > 0 then
                local equippedIndex = servantInfo.equippedSoul
                local hunjiBagItem = nil
                for i = 0, equipsTemp.Count - 1 do
                    ---@type bagV2.BagItemInfo
                    local equipTemp = equipsTemp[i]
                    if equipTemp.index == equippedIndex then
                        hunjiBagItem = equipTemp
                        break
                    end
                end
                if hunjiBagItem ~= nil then
                    ---若魂继已通灵,则同时打开魂继和灵兽蛋tips界面进行对比
                    uiStaticParameter.UIItemInfoManager:CreatePanel({
                        bagItemInfo = hunjiBagItem,
                        showRight = false,
                        showAssistPanel = true,
                        career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career),
                        showMoreAssistData = true,
                        showTabBtns = true,
                        showBind = true,
                        showAction = true
                    })
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = servantInfo.servantEgg, isCloseCollider = true, showRight = false })
                else
                    ---若魂继没有通灵,则直接打开灵兽蛋tips界面
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = servantInfo.servantEgg, showRight = false })
                end
            else
                uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = servantInfo.servantEgg, showRight = false })
            end
            return true;
        end
    end
    return false;
end

function UIServantInfoTemplate:Update()
    if (self.mIsLongPress) then
        self.mTimer = self.mTimer + CS.UnityEngine.Time.deltaTime;
        if (self.mTimer >= 0.2) then
            self.mIsLongPress = false;
            self:TryShowServantTip();
            return ;
        end
    end
end

function UIServantInfoTemplate:Start()
    --[[    if (self.mTime_UICountdownLabel ~= nil) then
            if (self.index == 1) then
                self.delayTime = CS.Utility_Lua.GetServerTimeIntervalDays(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemDays) * 1000;
            elseif (self.index == 2) then
                self.delayTime = CS.Utility_Lua.GetServerTimeIntervalDays(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemDays) * 1000;
            end
            if (self.delayTime <= CS.CSServerTime.Instance.TotalMillisecond) then
                if (self.Costtips ~= nil) then
                    self.Costtips:SetActive(false)
                end
            else
                if (self.Costtips ~= nil) then
                    self.Costtips:SetActive(true)
                end
                self.mTime_UICountdownLabel:StartCountDown(nil, 9, self.delayTime, "[e9cfa7]", "后结束[-]", nil, function()
                    if (self.Costtips ~= nil) then
                        self.Costtips:SetActive(false)
                    end
                end)
            end
        end]]
end
--endregion

--region 获取属性数据
function UIServantInfoTemplate:ParseData()
    local list = self.info.attributes
    local listCount = list.Count - 1
    for k = 0, listCount do
        local temp = list[k]
        local type = temp.type
        local value = temp.value
        if (type == LuaEnumAttributeType.MaxHp) then
            self.MaxHP = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
            self.PhyDefenceMin = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
            self.PhyDefenceMax = value
        elseif (type == LuaEnumAttributeType.PhyAttackMin) then
            self.PhyAttackMin = value
        elseif (type == LuaEnumAttributeType.PhyAttackMax) then
            self.PhyAttackMax = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
            self.MagicDefenceMin = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
            self.MagicDefenceMax = value
        elseif (type == LuaEnumAttributeType.HolyAttackMax) then
            self.HolyAttackMax = value
        elseif (type == LuaEnumAttributeType.HolyDefenceMax) then
            self.HolyDefenceMax = value
        end
    end

    self:ParseLevelData()
    self:ParseCombineData()
    self:RefreshHP()

end

function UIServantInfoTemplate:ParseLevelData()
    local list = self.info.levelAttrs
    local listCount = list.Count - 1
    for k = 0, listCount do
        local temp = list[k]
        local type = temp.type
        local value = temp.value
        if (type == LuaEnumAttributeType.MaxHp) then
            self.LevelPanelHP = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
            self.LevelPanelMinDefence = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
            self.LevelPanelMaxDefence = value
        elseif (type == LuaEnumAttributeType.PhyAttackMin) then
            self.LevelPanelMinAttack = value
        elseif (type == LuaEnumAttributeType.PhyAttackMax) then
            self.LevelPanelMaxAttack = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
            self.LevelPanelMinMDefence = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
            self.LevelPanelMaxMDefence = value
        elseif (type == LuaEnumAttributeType.HolyAttackMax) then
            self.LevelPanelHolyAttack = value
        elseif (type == LuaEnumAttributeType.HolyDefenceMax) then
            self.LevelPanelHolyDefence = value
        elseif (type == LuaEnumAttributeType.Dodge) then
            self.LevelPanelDodge = value
        elseif (type == LuaEnumAttributeType.Accurate) then
            self.LevelPanelAccurate = value
        end
    end

    local nextlist = self.info.nextLevelAttrs
    listCount = nextlist.Count - 1
    for k = 0, listCount do
        local temp = list[k]
        local type = temp.type
        local value = temp.value
        if (type == LuaEnumAttributeType.MaxHp) then
            self.NextLevelPanelHP = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
            self.NextLevelPanelMinDefence = value
        elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
            self.NextLevelPanelMaxDefence = value
        elseif (type == LuaEnumAttributeType.PhyAttackMin) then
            self.NextLevelPanelMinAttack = value
        elseif (type == LuaEnumAttributeType.PhyAttackMax) then
            self.NextLevelPanelMaxAttack = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
            self.NextLevelPanelMinMDefence = value
        elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
            self.NextLevelPanelMaxMDefence = value
        elseif (type == LuaEnumAttributeType.HolyAttackMax) then
            self.NextLevelPanelHolyAttack = value
        elseif (type == LuaEnumAttributeType.HolyDefenceMax) then
            self.NextLevelPanelHolyDefence = value
        elseif (type == LuaEnumAttributeType.Dodge) then
            self.NextLevelPanelDodge = value
        elseif (type == LuaEnumAttributeType.Accurate) then
            self.NextLevelPanelAccurate = value
        end
    end
end

function UIServantInfoTemplate:ParseCombineData()
    local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
    local AttackKey = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan
    local DefineKey = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan
    local attackKey = 1
    local defenceKey = 1
    local mdefenceKey = 1
    local hpKey = 1
    local careerContent = nil
    local res, tab = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20129) --职业参数
    if (res) then
        careerContent = tab.value:Split('&')
        if (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior) then
            ---血量&物防&魔防&攻击，#分割职业，战士#法师#道士
            hpKey = tonumber(careerContent[1]:Split('#')[1])
            defenceKey = tonumber(careerContent[2]:Split('#')[1])
            mdefenceKey = tonumber(careerContent[3]:Split('#')[1])
            attackKey = tonumber(careerContent[4]:Split('#')[1])
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) then
            hpKey = tonumber(careerContent[1]:Split('#')[3])
            defenceKey = tonumber(careerContent[2]:Split('#')[3])
            mdefenceKey = tonumber(careerContent[3]:Split('#')[3])
            attackKey = tonumber(careerContent[4]:Split('#')[3])
        elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) then
            hpKey = tonumber(careerContent[1]:Split('#')[2])
            defenceKey = tonumber(careerContent[2]:Split('#')[2])
            mdefenceKey = tonumber(careerContent[3]:Split('#')[2])
            attackKey = tonumber(careerContent[4]:Split('#')[2])
        end
    end
    if (MiBaores) then
        local Hpres, HPtab = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(MiBaotab.itemId)
        if (Hpres) then
            self.CombineHP = HPtab.hpPercentage / 10
            --self.CombineHP = math.ceil(tonumber(self.MaxHP) * tonumber(HPtab.hpPercentage) / 1000 * hpKey / 1000)
        end
    end
    if (AttackKey ~= 0) then
        local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(AttackKey)
        if (infobool) then
            --self.CombineAttackMin = math.ceil(tonumber(self.PhyAttackMin) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
            --self.CombineAttackMax = math.ceil(tonumber(self.PhyAttackMax) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
            self.CombineAttackMin = iteminfo.attackPercentage / 10
            --self.CombineAttackMax = math.ceil(tonumber(self.PhyAttackMax) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
        end
    end
    if (DefineKey ~= 0) then
        local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(DefineKey)
        if (infobool) then
            self.CombineDefenceMin = iteminfo.defensePercentage / 10
            self.CombineMDefenceMin = iteminfo.defensePercentage / 10
            --self.CombineDefenceMin = math.ceil(tonumber(self.PhyDefenceMin) * tonumber(iteminfo.defensePercentage) / 1000 * defenceKey / 1000)
            --self.CombineDefenceMax = math.ceil(tonumber(self.PhyDefenceMax) * tonumber(iteminfo.defensePercentage) / 1000 * defenceKey / 1000)
            --self.CombineMDefenceMin = math.ceil(tonumber(self.MagicDefenceMin) * tonumber(iteminfo.defensePercentage) / 1000 * mdefenceKey / 1000)
            --self.CombineMDefenceMax = math.ceil(tonumber(self.MagicDefenceMax) * tonumber(iteminfo.defensePercentage) / 1000 * mdefenceKey / 1000)
        end
    end

end
--endregion

--region 事件
function UIServantInfoTemplate:ServantIconClickEvent(clickCallback)
    self.mServantIconclickCallback = clickCallback
end

function UIServantInfoTemplate:OnPlayerClickHead()
    self:IconOnClick(LuaEnumPanelOpenSourceType.ByServantPanel);
end

---灵兽按钮点击事件
---@param openSourceType LuaEnumPanelOpenSourceType
function UIServantInfoTemplate:IconOnClick(openSourceType, otherType)
    if (self.IsUnLock or self.info.servantId == 0) then
        --未解锁
        --UIServantInfoTemplate:ShowUnLockTips(self)
        self.ServantPanel.OnClickBtnHideAttribute()
    end
    if (self.DiamondTypeToggle ~= nil) then
        self.DiamondTypeToggle:Set(true, true)
    end
    uiStaticParameter.SelectedServantType = self.index + 1
    if (self.ServantPanel ~= nil) then
        if (self.ServantPanel.go.name == "UIOtherServantPanel") then
            self.ServantPanel:SwitchServantByIndex(self.info.type)
        else
            self.ServantPanel:SwitchServant(self.index)
        end
    end
    if self.openServantPanelType == LuaEnumPanelOpenSourceType.ByStrengthenPanel then
        return
    end

    local OtherservantPanel = uimanager:GetPanel("UIOtherPlayerMessagePanel")
    local UIServantPracticePanel = uimanager:GetPanel("UIServantPracticePanel")
    if UIServantPracticePanel ~= nil then
    elseif self.openServantPanelType ~= LuaEnumPanelOpenSourceType.ByStrengthenPanel
            and self.openServantPanelType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
            and self.openServantPanelType ~= LuaEnumPanelOpenSourceType.ByServantHintHighLv
            and self.openServantPanelType ~= LuaEnumPanelOpenSourceType.BySynthesis
            and self.openServantPanelType ~= LuaEnumPanelOpenSourceType.ByRefine
            and self.openServantPanelType ~= LuaEnumPanelOpenSourceType.ByRefineMaster
            and OtherservantPanel == nil then
        if (CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantRecommend_COMMON).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantRecommend_HM).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantRecommend_LX).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantRecommend_TC).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_COMMON).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_HM).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_LX).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantBodyRecommend_TC).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintListWithoutLevel(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_HM).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_LX).Count > 0
                or CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint:GetHintList(LuaEnumMainHint_BetterBagItemType.ServantEquipRecommend_TC).Count > 0
                or gameMgr:GetLuaRedPointManager():GetRedPointState(CS.RedPointKey.SERVANT_EQUIP) == true
        ) then
            if self:IsNeedOpenXiuLianLingLiPanel(openSourceType, otherType) == false then
                if uimanager:GetPanel("UIBagPanel") == nil then
                    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant, openSourceType = openSourceType })
                else
                    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant })
                end
            end
        else
            ---@type CSServantData_MainPlayer
            local servantData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData
            if servantData.HanMangSeatData:IsAnyBetterHunJiInBagToEquipInServantSeat() or servantData.LuoXingSeatData:IsAnyBetterHunJiInBagToEquipInServantSeat() or servantData.TianChengSeatData:IsAnyBetterHunJiInBagToEquipInServantSeat() then
                if self:IsNeedOpenXiuLianLingLiPanel(openSourceType, otherType) == false then
                    if uimanager:GetPanel("UIBagPanel") == nil then
                        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant, openSourceType = openSourceType })
                    else
                        uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant })
                    end
                end
            end
        end
    end

    if (self.ServantPanel.ServantNavType == LuaEnumServantPanelType.LevelPanel) then
        self.ServantPanel:GetCurBranchPanel():SetLevelProgress(self.info)
    end
    if (CS.CSScene.MainPlayerInfo.BagInfo:IsShowEggToUseEffect(self.index)) then
        self.ServantPanel:GetSelectHeadInfo():GetBtnUseLight_GameObject():SetActive(true)
    else
        self.ServantPanel:GetSelectHeadInfo():GetBtnUseLight_GameObject():SetActive(false)
    end

    ---@type UIBagPanel
    local uiBagPanel = uimanager:GetPanel("UIBagPanel")
    if uiBagPanel ~= nil then
        if self.openServantPanelType == LuaEnumPanelOpenSourceType.ByServantHintHighLv then
            --此处不需要重复打开,若重复打开反而会洗掉之前设置的锁定的物品
            local bagMainController = uiBagPanel:GetBagMainController()
            if bagMainController ~= nil then
                uiBagPanel:GetBagMainController():SetBagInfoIsDirty()
                uiBagPanel:RefreshGrids()
            end
            --uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant_HighLv })
        else
            if self:IsNeedOpenXiuLianLingLiPanel(openSourceType, otherType) == false then
                uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Servant })
            end

        end
    end
end

---是否需要打开修炼灵力面板
---@return boolean
function UIServantInfoTemplate:IsNeedOpenXiuLianLingLiPanel(openSourceType, otherType)
    if gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr().isNeedopen_LianzhiLingShou and LuaEnumPanelOpenSourceType.ByServantPanel == openSourceType and otherType == LuaEnumServantPanelType.ReinPanel then
        uimanager:CreatePanel("UIRefineServantPanel")
        uimanager:ClosePanel("UIBagPanel")
        return true
    end
    return false
end

---@param index number
---@return string
function UIServantInfoTemplate:GetLockTipsTextContent(index)
    if self.ServantPanel.ServantNavType == LuaEnumServantPanelType.HunJiPanel then
        return "请先召唤灵兽"
    else
        return LuaGlobalTableDeal:GetServantOpenTips(index + 1)
    end
end

function UIServantInfoTemplate:GetServantType()
    if (self.index == 0) then
        return LuaEnumServantSpeciesType.First;
    elseif (self.index == 1) then
        return LuaEnumServantSpeciesType.Second;
    elseif (self.index == 2) then
        return LuaEnumServantSpeciesType.Third;
    end
end

--region UI界面
--region 锁定提示
function UIServantInfoTemplate:ShowUnLockTips(tem)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = tem.go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 18
    local isFind, item = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(18)
    if isFind then
        local UnLockTips = string.Split(item.content, '#')[tem.index + 1]
        TipsInfo[LuaEnumTipConfigType.Describe] = UnLockTips
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

--region 刷新灵兽头像
function UIServantInfoTemplate:RefreshHP()
    if (self.info.state == 1) then
        if self.MaxHP ~= nil then
            self.hp_UISprite.fillAmount = self.info.hp / self.MaxHP
            CS.CSValueTween.Begin(self.hp_UISprite.gameObject, 0.1, self.hp_UISprite.fillAmount, self.hp_UISprite.fillAmount, function(item, value)
                self.hp_UISprite.fillAmount = value
            end)
        end
    elseif (self.info.state == 2) then
        self.hp_UISprite.fillAmount = self.info.combineHp / self.info.combineMaxHp
    else
        self.hp_UISprite.fillAmount = 0
    end
end

function UIServantInfoTemplate:RefreshIcon()
    if (self.info ~= nil) then
        self.IsEmpty = self.info.servantId == 0 and true or false
    end
    if (self.IsUnLock == true) then
        --未解锁灵兽
        self.headIcon_UISprite.spriteName = "img_suo"
        self.hp_UISprite.gameObject:SetActive(false)
        self.level_UILabel.gameObject:SetActive(false)
        self.headIcon_UISprite:MakePixelPerfect()
        return
    end
    if (self.info ~= nil and self.info.state == 0) then
        self:GetReliveCD().gameObject:SetActive(true)
        self:GetReliveCD():StartCountDown("[f00000]{0}", (self.info.callAgainTime - CS.CSServerTime.Instance.TotalMillisecond) / 1000 + 1)
        self.headIcon_UISprite.color = CS.UnityEngine.Color.black
    else
        self:GetReliveCD().gameObject:SetActive(false)
        self.headIcon_UISprite.color = CS.UnityEngine.Color.white
    end
    if (self.IsEmpty == true) then
        --解锁未装备灵兽
        self.hp_UISprite.gameObject:SetActive(false)
        self.headIcon_UISprite.spriteName = "question"
        self.headIcon_UISprite:MakePixelPerfect()
        self.level_UILabel.gameObject:SetActive(false)
    else
        self.hp_UISprite.gameObject:SetActive(true)
        self.headIcon_UISprite.spriteName = self:GetHeadIcon()
        --已装备灵兽
        self.level_UILabel.gameObject:SetActive(false)
        self.go:SetActive(true)
    end
end

function UIServantInfoTemplate:SetChooseIcon()
    for i = 0, 2 do
        self.ServantPanel.ServantItemHeadList[i].ChooseIconAlpha.alpha = 0
    end
    self.ChooseIcon:SetActive(true)
    self.ChooseIconAlpha.alpha = 1
end

---设置头像显示（头像和加号锁互斥）
function UIServantInfoTemplate:SetIconShow()
    --if (self.ServantPanel:GetSelectHeadInfo() == self) then
    --    self.headIcon_UISprite.gameObject:SetActive(false)
    --end
end

---获取灵兽头像图片
function UIServantInfoTemplate:GetHeadIcon()
    if self.openServantPanelType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        ---其他玩家的icon使用魂继icon
        local seatData
        --if self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.index + 1)
        --else
        --seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.index + 1)
        --end
        if seatData ~= nil then
            ---处于魂继预览时不用修改icon
            return seatData:GetServantIcon(false)
        end
        return ""
    else
        ---自己的icon使用原icon
        if self.info then
            local res, iconInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(self.info.mid)
            if res then
                return iconInfo.head
            end
        end
        return ""
    end
end

--刷新灵兽等级
function UIServantInfoTemplate:RefreshLevel(level)
    --如果在升级过程中 调用传入值
    --self.level_UILabel.gameObject:SetActive(not self.IsUnLock and not self.IsEmpty)
    --self.level_UILabel.text = level ~= nil and string.format('%.0f', level) or self.info ~= nil and self.info.level or ''
    --self:ShowCanLevelUpGo(level)
end

--region 显示升级标识
--function UIServantInfoTemplate:ShowCanLevelUpGo(level)
--    --否则调用servantinfo值
--    if level ~= nil then
--        if (self.IsEmpty) then
--            return
--        end
--        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(level + 1)
--        if (res) then
--            if (levelInfo.upgrade - self.info.exp <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool) then
--                return
--            end
--        end
--    elseif (self.info ~= nil) then
--        if (self.IsEmpty) then
--            return
--        end
--        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(self.info.level + 1)
--        if (res) then
--            if (levelInfo.upgrade - self.info.exp <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool) then
--                return
--            end
--        end
--    end
--end
--endregion

--endregion

--region 刷新灵兽界面信息
--刷新血量
function UIServantInfoTemplate:RefreshServantHP(id, data)
    if (data ~= nil and self.info ~= nil and self.info.servantId == 0 or self.info.state == LuaEnumServantStateType.Death) then
        self.hp_UISprite.gameObject:SetActive(false)
        return
    end
    if (self.info.hp ~= nil and self.info.type == data.type) then
        self.hp_UISprite.gameObject:SetActive(true)
        self.info.hp = data.hp
        self.MaxHP = data.maxHp
        self.mHpRate_float = self.info.hp / self.MaxHP
        CS.CSValueTween.Begin(self.hp_UISprite.gameObject, 1, self.hp_UISprite.fillAmount, self.mHpRate_float, function(item, value)
            self.hp_UISprite.fillAmount = value
        end)
    end
end
--endregion

--region 显示背景
function UIServantInfoTemplate:HideAllBackGround()
    self:GetLock_GameObject():SetActive(false);
    self.ModelBG:SetActive(false);
    self:GetModelBackGround_GameObject():SetActive(false);
end

function UIServantInfoTemplate:UpdateBackGround(hideLockTips)
    self:GetLock_GameObject():SetActive(self.info == nil);
    local tipcontent = self:GetLockTipsTextContent(self.index)
    if tipcontent then
        self:GetLockTipsTextLabel().text = tipcontent
    end
    if hideLockTips == true then
        self:GetLockTipsText_GameObject():SetActive(false)
        self:GetUseTipsTextLabel().gameObject:SetActive(false)
    else
        self:GetLockTipsText_GameObject():SetActive(true)
        self:GetUseTipsTextLabel().gameObject:SetActive(true)
    end

    --[[    if (self.info == nil and self:GetDeblock_GameObject() ~= nil) then
        self:GetLockTipsText_GameObject():SetActive(false)
        self:GetDeblock_GameObject():SetActive(false)
        if (self:GetLockCost_GameObject() ~= nil) then
            self:GetLockCost_GameObject():SetActive(true)
        end

        if (self.index == 1) then
            if (self:GetDeblockFirst_UILabel() ~= nil) then
                if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1 > CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemDays) then
                    self:GetDeblockFirst_UILabel().text = "[e85038]" .. tostring(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemCount) .. "[-]"
                else
                    self:GetDeblockFirst_UILabel().text = "[878787][s]" .. tostring(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseSecondServantNeedItemCount) .. "[/s][-]  [e85038]" .. tostring(CS.Cfg_GlobalTableManager.Instance.PurchaseSecondServantNeedItemCount) .. "[-]"
                end
            end
            if (self:GetDeblockSecond_UILabel() ~= nil) then
                self:GetDeblockSecond_UILabel().text = "[FFcb3d]" .. CS.Cfg_GlobalTableManager.Instance.PurchaseSecondServantNeedSecondItemCount .. "[-]"
            end
        elseif (self.index == 2) then
            if (self:GetDeblockFirst_UILabel() ~= nil) then
                if (CS.CSScene.MainPlayerInfo.OpenServerDayNumber + 1 > CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemDays) then
                    self:GetDeblockFirst_UILabel().text = "[e85038]" .. tostring(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemCount) .. "[-]"
                else
                    self:GetDeblockFirst_UILabel().text = "[878787][s]" .. tostring(CS.Cfg_GlobalTableManager.Instance.OriginalPurchaseThirdServantNeedItemCount) .. "[/s][-]  [e85038]" .. tostring(CS.Cfg_GlobalTableManager.Instance.PurchaseThirdServantNeedItemCount) .. "[-]"
                end
            end
            if (self:GetDeblockSecond_UILabel() ~= nil) then
                self:GetDeblockSecond_UILabel().text = "[FFcb3d]" .. tostring(CS.Cfg_GlobalTableManager.Instance.PurchaseThirdServantNeedSecondItemCount) .. "[-]"
            end
        end
    else
        if (self:GetLockCost_GameObject() ~= nil) then
            self:GetLockCost_GameObject():SetActive(false)
        end
    end]]

    self.ModelBG:SetActive(self.info ~= nil and self.info.servantId == 0);
    self:GetModelBackGround_GameObject():SetActive(true);
end

function UIServantInfoTemplate:UpdateServantIconShadow()
    self:GetIconShadow_GameObject():SetActive(not (self.info ~= nil and self.info.servantId ~= 0));
end

--endregion

--region 特效的显示与隐藏
---@param effectName string 特效名
---@param state boolean 特效状态
function UIServantInfoTemplate:ChangeEffectState(effectName, state, scale, pos)
    if self.effectPool == nil then
        self.effectPool = {}
    end
    if self.effectPool[effectName] ~= nil and self.effectPool[effectName].state == state then
        if (self.effectPool[effectName].go ~= nil) then
            if (state) then
                self.effectPool[effectName].go:SetActive(false)
            end
            self.effectPool[effectName].go:SetActive(state)
        end
        return
    end
    if Utility.IsContainsKey(self.effectPool, effectName) == false then
        self.effectPool[effectName] = { go = nil, state = state }
    else
        self.effectPool[effectName].state = state
    end
    if self.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(self.effectPool[effectName].go) == true then
        local mCurTem = self
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
            if mCurTem and mCurTem.go and res and res.MirrorObj then
                res.IsCanBeDelete = false
                if mCurTem.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(mCurTem.effectPool[effectName].go) == true then
                    mCurTem.effectPool[effectName].go = res:GetObjInst()
                    if mCurTem.effectPool[effectName].go == nil or CS.StaticUtility.IsNull(mCurTem.effectPool[effectName].go) == true then
                        return
                    end
                    mCurTem.effectPool[effectName].go.transform.parent = mCurTem:GetEffectRoot_GameObejct().transform
                    if (pos == nil) then
                        mCurTem.effectPool[effectName].go.transform.localPosition = CS.UnityEngine.Vector3.zero
                    else
                        mCurTem.effectPool[effectName].go.transform.localPosition = pos
                    end
                    if (scale == nil) then
                        scale = 120
                    end
                    mCurTem.effectPool[effectName].go.transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale)
                end
                mCurTem.effectPool[effectName].go:SetActive(mCurTem.effectPool[effectName].state)
            end
        end
        , CS.ResourceAssistType.UI)
    else
        if state then
            CS.CSReactiveAtFutureFrameMgr.Instance:ReactiveTarget(self.effectPool[effectName].go)
        else
            self.effectPool[effectName].go:SetActive(state)
        end
    end
end
--endregion
--endregion

function UIServantInfoTemplate:OnEnable()
    if (self.mRedPointComponent ~= nil) then
        self.mRedPointComponent.isEnabled = not (self.openServantPanelType == LuaEnumPanelOpenSourceType.ByRefine);
    end

    if (self.openServantPanelType == LuaEnumPanelOpenSourceType.BySynthesis) then
        --self.mRedPointComponent:RemoveRedPointKey();
        --local keys = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquipRedPointKeys(self.index);
        --if(keys ~= nil) then
        --    for k,v in pairs(keys) do
        --        self.mRedPointComponent:AddRedPointKey(v);
        --    end
        --end

        --local redPointName = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantRedPointName(self.index);
        --if(redPointName ~= nil) then
        --    local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
        --    self.mRedPointComponent:AddRedPointKey(key);
        --    --print(self.index.."  :"..key);
        --end

        --local magicWeaponRedpOintName = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantMagicWeaponSynthesisRedPointName(self.index);
        --
        --if(magicWeaponRedpOintName ~= nil) then
        --    local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(magicWeaponRedpOintName);
        --    self.mRedPointComponent:AddRedPointKey(key);
        --    --print(self.index.."  :"..key);
        --end
    end
end

function UIServantInfoTemplate:OnDestroy()
    --if (self.mTime_UICountdownLabel ~= nil) then
    --    self.mTime_UICountdownLabel:StopCountDown()
    --end
    UIServantInfoTemplate.Self = nil
end

return UIServantInfoTemplate
