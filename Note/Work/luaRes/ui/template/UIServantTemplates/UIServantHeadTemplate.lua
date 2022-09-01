---左上角人物头像下方灵兽头像
---@class UIServantHeadTemplate:TemplateBase
local UIServantHeadTemplate = {}

--region 属性
function UIServantHeadTemplate:GetReliveCD()
    if self.mReliveCD == nil then
        self.mReliveCD = self:Get("deadtime", "CountDownTimeLabel")
    end
    return self.mReliveCD
end

function UIServantHeadTemplate:GetEffectRoot_GameObejct()
    if self.mEffectRoot == nil then
        self.mEffectRoot = self:Get("EffectRoot", "GameObject")
    end
    return self.mEffectRoot
end

function UIServantHeadTemplate:GetIconShadow_GameObject()
    if (self.mIconShadow_GameObject == nil) then
        self.mIconShadow_GameObject = self:Get("shadow", "GameObject");
    end
    return self.mIconShadow_GameObject
end
---可复活标识
---@return UnityEngine.GameObject
function UIServantHeadTemplate:GetIsReliveAvailableSignGameObject()
    if self.mIsReliveAvailableSignGO == nil then
        self.mIsReliveAvailableSignGO = self:Get("reliveAvailable", "GameObject")
    end
    return self.mIsReliveAvailableSignGO
end

function UIServantHeadTemplate:GetBtnUseLight_GameObject()
    if (self.mBtnUseLight_GameObject == nil) then
        self.mBtnUseLight_GameObject = self:Get("icon/light", "GameObject");
    end
    return self.mBtnUseLight_GameObject;
end

function UIServantHeadTemplate:GetBtnUseLight_TweenAlpha()
    if (self.mBtnUseLight_TweenAlpha == nil) then
        self.mBtnUseLight_TweenAlpha = self:Get("icon/light", "TweenAlpha");
    end
    return self.mBtnUseLight_TweenAlpha;
end
--endregion

--region 初始化
---@param servantHeadPanel UIServantHeadPanel
function UIServantHeadTemplate:Init(servantHeadPanel)
    self.servantHeadPanel = servantHeadPanel
    self:InitComponents()
    self:BindMessage();
    self.type = 0
end

function UIServantHeadTemplate:InitComponents()
    self.icon_UISprite = self:Get("icon", "UISprite")
    self.mode_UILabel = self:Get("mode", "UILabel")
    self.level_UILabel = self:Get("rolelevel", "UILabel")
    self.hp_UISprite = self:Get("hp", "UISprite")
    self.forward = self:Get("forward", "TweenAlpha")
    self.IsUnLock = true    --解锁状态
    self.FirstEmpty = false
    self.IsEmpty = true     --是否装有灵兽
    self.headIcon_UISprite = self:Get("Background/iconHead", "UISprite")
    self.Background = self:Get("Background", "UISprite")
    self.RedPoint = self:Get("RedPoint", "GameObject")
    self.combineEffect = self:Get("fusion", "GameObject")
    self.combineEffectTween = self:Get("fusion", "TweenAlpha")

    self.forward:SetOnFinished(function()
        self.icon_UISprite.spriteName = "question"
        self.icon_UISprite.gameObject:SetActive(true)
        self.icon_UISprite.gameObject.transform.localScale = CS.UnityEngine.Vector3.one
        self.icon_UISprite:MakePixelPerfect()
        self.FirstEmpty = false
    end)
end

---@param info servantV2.ResServantInfo
function UIServantHeadTemplate:InitParameters(info)
    self.info = info
    self.servantId = info.servantId
    local length = self.info.attributes.Count - 1
    for k = 0, length do
        if (self.info.attributes[k].type == LuaEnumAttributeType.MaxHp) then
            self.MaxHP = self.info.attributes[k].value
        end
    end
    if (self.info.state == 1) then
        self.hp_UISprite.fillAmount = self.info.hp / self.MaxHP
        self.combineEffect:SetActive(false)
    elseif (self.info.state == 2) then
        self.hp_UISprite.fillAmount = self.info.combineHp / self.info.combineMaxHp
        if (self.combineEffect.activeSelf == false) then
            self.combineEffect:SetActive(true)
            self.combineEffectTween:ResetToBeginning()
            self.combineEffectTween:Play()
        end
    else
        self.hp_UISprite.fillAmount = 0
        self.combineEffect:SetActive(false)
        self:ChangeEffectState("700054", false)
    end
end

function UIServantHeadTemplate:BindMessage()
    self.CallOnNavCloseFinished = function()
        self:OnNavCloseFinished();
    end
    local servantHeadTemplateSelf = self
    --复活特效
    self.servantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantReborn, function(uiEvtID, data)
        if servantHeadTemplateSelf and servantHeadTemplateSelf.go and data then
            if servantHeadTemplateSelf.info and servantHeadTemplateSelf.info.type == data then
                servantHeadTemplateSelf:ChangeEffectState("700054", true)
            end
        end
    end)
    --升级特效
    self.servantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantLevelUp, function(uiEvtID, data)
        if servantHeadTemplateSelf and servantHeadTemplateSelf.go and data then
            if servantHeadTemplateSelf.info and servantHeadTemplateSelf.info.type == data then
                servantHeadTemplateSelf:ChangeEffectState("700132", true, 1, CS.UnityEngine.Vector3(26, -6, 0))
            end
        end
    end)
    self.servantHeadPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerHunJiInfoChanged, function()
        self:RefreshUI()
    end)
end
--endregion

--region 刷新UI界面
function UIServantHeadTemplate:RefreshUI()
    self:GetIconShadow_GameObject():SetActive(not (self.info ~= nil and self.info.servantId ~= 0));

    if (self.IsUnLock == true) then
        self.Background.alpha = 0.5
        --未解锁
        if (self.icon_UISprite ~= nil) then
            self:SetIconShow(true)
            self.hp_UISprite.gameObject:SetActive(false)
            self.icon_UISprite.gameObject.transform.localScale = CS.UnityEngine.Vector3.one
            self.icon_UISprite.spriteName = "img_suo"
            self.level_UILabel.gameObject:SetActive(false)
            self.hp_UISprite.fillAmount = 0
            self.icon_UISprite:MakePixelPerfect()
        end
        return
    end
    if (self.IsEmpty == true) then
        --解锁未装备
        self.Background.alpha = 0.5
        self:SetIconShow(true)
        if (self.FirstEmpty) then
            self.icon_UISprite.gameObject:SetActive(false)
            self.forward.gameObject:SetActive(true)
            self:ServantIconInit()
        end
        self.hp_UISprite.gameObject:SetActive(false)
        self.level_UILabel.gameObject:SetActive(false)
    else
        self.Background.alpha = 1
        self.hp_UISprite.gameObject:SetActive(true)
        if (self.info.state == 0) then
            ---灵兽已装备且死亡的状态
            self:GetIsReliveAvailableSignGameObject():SetActive(self:IsReliveAvailable())
            self:GetReliveCD().gameObject:SetActive(true)
            self:GetReliveCD():StartCountDown("[f00000]{0}", (self.info.callAgainTime - CS.CSServerTime.Instance.TotalMillisecond) / 1000 + 1)
            self.headIcon_UISprite.color = CS.UnityEngine.Color.black
        else
            self:GetReliveCD().gameObject:SetActive(false)
            self:GetIsReliveAvailableSignGameObject():SetActive(false)
            self.headIcon_UISprite.color = CS.UnityEngine.Color.white
        end
        --已装备
        self:SetIconShow(false)
        self.headIcon_UISprite.spriteName = self:GetIcon()
        self.level_UILabel.gameObject:SetActive(false)
        self.level_UILabel.text = self.info.level
        self.icon_UISprite:MakePixelPerfect()
    end
end

function UIServantHeadTemplate:SetIconShow(isShow)
    self.icon_UISprite.gameObject:SetActive(isShow)
    self.headIcon_UISprite.gameObject:SetActive(not isShow)
end

---获取灵兽头像
function UIServantHeadTemplate:GetIcon()
    if self.info then
        local res, iconInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(self.info.mid)
        if res then
            return iconInfo.head
        end
    end
    return "6666666"
end

---开启灵兽栏Icon
function UIServantHeadTemplate:ServantIconInit()
    --self.forward:ResetToBeginning()
    self.forward:PlayTween()
end

---血量条刷新
function UIServantHeadTemplate:RefreshServantHP(id, data)
    if (data ~= nil and self.info ~= nil and self.info.servantId == 0 or self.info.state == LuaEnumServantStateType.Death) then
        self.hp_UISprite.gameObject:SetActive(false)
        return
    end
    if (self.info.type == data.type) then
        self.hp_UISprite.gameObject:SetActive(true)
        self.info.hp = data.hp
        self.MaxHP = data.maxHp
        self.mHpRate_float = self.info.hp / self.MaxHP
        CS.CSValueTween.Begin(self.hp_UISprite.gameObject, 1, self.hp_UISprite.fillAmount, self.mHpRate_float, function(item, value)
            self.hp_UISprite.fillAmount = value
        end)
    end
end

function UIServantHeadTemplate:RefreshOnlyServantHP(type, hp)
    if (self.info.type == type) then
        self.hp_UISprite.gameObject:SetActive(true)
        self.info.hp = hp
        self.mHpRate_float = self.info.hp / self.MaxHP

        CS.CSValueTween.Begin(self.hp_UISprite.gameObject, 1, self.hp_UISprite.fillAmount, self.mHpRate_float, function(item, value)
            self.hp_UISprite.fillAmount = value
        end)
    end
end

---经验刷新
function UIServantHeadTemplate:RefreshServantExp(id, data)
    if (self.info ~= nil) then
        local res, levelInfo = CS.Cfg_HsLevelTableManager.Instance.dic:TryGetValue(self.info.level + 1)
        if (res) then
            if (levelInfo.upgrade - self.info.exp <= CS.CSScene.MainPlayerInfo.ServantInfoV2.ResServantInfo.expPool) then
                self.RedPoint:SetActive(true)
                return
            end
        end
    end
    self.RedPoint:SetActive(false)
end
---锁定提示
function UIServantHeadTemplate:ShowUnLockTips(tem)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = tem.go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 13
    local isFind, item = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(13)
    if isFind then
        local UnLockTips = string.Split(item.content, '#')[tem.type]
        TipsInfo[LuaEnumTipConfigType.Describe] = UnLockTips
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end

---是否可复活
---@return boolean
function UIServantHeadTemplate:IsReliveAvailable()
    ---当前灵兽死亡且背包中有可用的复活药的情况下,可以复活
    if self.info ~= nil and self.info.mid ~= 0 and self.info.state == 0 then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo.BagInfoState.AnyUseableServantReliveDrug ~= 0 then
            return true;
        end
    end
    return false
end
--endregion

--region UI事件处理
function UIServantHeadTemplate:BindClickEvent()
    if (self.go ~= nil) then
        CS.UIEventListener.Get(self.go).LuaEventTable = self
        CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.HeadonClick
    end
end

---左上角三个幻兽头像点击事件
function UIServantHeadTemplate:HeadonClick()
    if (self.IsUnLock) then
        --未解锁
        --self:ShowUnLockTips(self)
    end

    ---可复活时,点击头像请求复活
    if self:IsReliveAvailable() then
        networkRequest.ReqUseItem(1, CS.CSScene.MainPlayerInfo.BagInfo.BagInfoState.AnyUseableServantReliveDrug, self.info.type)
        return
    end

    local navPanel = uimanager:GetPanel("UINavigationPanel");
    if (navPanel ~= nil) then
        if (navPanel:GetNavIsOpen()) then
            self.mIsHeadClickedWithNavClose = true;
            if (luaEventManager.HasCallback(LuaCEvent.Navigation_CloseNavAndPanel)) then
                luaEventManager.DoCallback(LuaCEvent.Navigation_CloseNavAndPanel)
            end
        else
            self.mIsHeadClickedWithNavClose = false;
            local customData = {};
            customData.redpoint = self.RedPoint.activeSelf
            if (self.info ~= nil) then
                customData.servantIndex = self.info.type - 1;
                uiStaticParameter.SelectedServantType = self.info.type
            else
                customData.servantIndex = self.type - 1;
                uiStaticParameter.SelectedServantType = self.type
            end
            customData.SpecialOpen = self.servantHeadPanel.SpecialOpen

            uimanager:CreatePanel("UIServantTagPanel", nil, customData)
        end
    end
    if self.servantHeadPanel ~= nil then
        self.servantHeadPanel.RemovePop()
    end
end

function UIServantHeadTemplate:OnNavCloseFinished()
    if (self.mIsHeadClickedWithNavClose and uimanager:GetPanel("UIServantTagPanel") == nil) then
        local customData = {};
        if (self.info ~= nil) then
            customData.servantIndex = self.info.type - 1;
            uimanager:CreatePanel("UIServantTagPanel", nil, customData)
            self.mIsHeadClickedWithNavClose = false;
        end
    end
end
--endregion

--region 特效的显示与隐藏
---@param effectName string 特效名
---@param state boolean 特效状态

function UIServantHeadTemplate:HideEggToUseEffectState()
    if Utility.IsContainsKey(self.effectPool, "700131") == true then
        if (self.effectPool["700131"].go ~= nil) then
            self.effectPool["700131"].go:SetActive(false)
        end
    end
end

function UIServantHeadTemplate:ChangeEffectState(effectName, state, scale, pos)
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
                        mCurTem.effectPool[effectName].go.transform.localPosition = CS.UnityEngine.Vector3(30, -5, 0)
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

--region 筛选背包内物品
function UIServantHeadTemplate.FilterItemsInBag(bagItem)
    local isAbleToBeSelected = false
    --如果是幻兽蛋类型，return true
    local res, typeInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItem.itemId)
    if res then
        if typeInfo.type == Utility.EnumToInt(CS.EItem_Type.Assist) and typeInfo.subType == 8 then
            isAbleToBeSelected = true
        end
    end
    return isAbleToBeSelected
end
--endregion

function UIServantHeadTemplate:OnEnable()
    if self.servantHeadPanel then
        self.servantHeadPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnCloseFinished, self.CallOnNavCloseFinished)
    end
end

function UIServantHeadTemplate:OnDisable()
    if self.servantHeadPanel then
        self.servantHeadPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OnCloseFinished, self.CallOnNavCloseFinished)
    end
end

function UIServantHeadTemplate:OnDestroy()
    if self.servantHeadPanel then
        self.servantHeadPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OnCloseFinished, self.CallOnNavCloseFinished)
    end
end

return UIServantHeadTemplate
