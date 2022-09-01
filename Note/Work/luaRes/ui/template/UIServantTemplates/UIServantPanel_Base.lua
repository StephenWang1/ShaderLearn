---灵兽装备格子模板
---@class UIServantPanel_Base:UIServantBasicPanel
local UIServantPanel_Base = {}

setmetatable(UIServantPanel_Base, luaComponentTemplates.UIServantBasicPanel)

---@type UIServantPanel
UIServantPanel_Base.ServantPanel = nil;
UIServantPanel_Base.ServantInfo = nil
---灵兽位类型
---@type luaEnumServantSeatType
UIServantPanel_Base.ServantSeatType = nil
UIServantPanel_Base.mShowEquipReinLevel = 0
---@type table<UnityEngine.GameObject,bagV2.BagItemInfo> 存储格子对应信息
UIServantPanel_Base.mGridToEquipInfo = nil
UIServantPanel_Base.TypeClickLimitTimeDic = {}
---当前灵兽界面打开状态
---@type LuaEnumPanelOpenSourceType
UIServantPanel_Base.ServantPanelOpenType = nil
---当前选中格子模板
UIServantPanel_Base.CurrentChooseGridTemp = nil
---存储格子对应特效
UIServantPanel_Base.mGridToEffect = nil
---当前选中格子信息
UIServantPanel_Base.mCurrentChooseInfoId = nil
---存储lid对应格子信息
UIServantPanel_Base.mLidToGrid = nil
---存储lid对应选中信息
UIServantPanel_Base.mLidToChoose = nil

--region 属性
--region 装备
function UIServantPanel_Base:GetAllEquipView_GameObject()
    if self.mAllEquipView == nil then
        self.mAllEquipView = self:Get("view", "GameObject")
    end
    return self.mAllEquipView
end

function UIServantPanel_Base:GetChangeEffectRoot_GameObject()
    if self.mEffectRoot_GameObject == nil then
        self.mEffectRoot_GameObject = self:Get("view/EffectRoot/changeEffect", "GameObject")
    end
    return self.mEffectRoot_GameObject
end

---装备Root
function UIServantPanel_Base:GetEquipView_GameObject()
    if self.mEquipView == nil then
        self.mEquipView = self:Get("view/equips", "GameObject")
    end
    return self.mEquipView
end
---项链
function UIServantPanel_Base:GetNeckEquip_GameObject()
    if self.mNeckEquip == nil then
        self.mNeckEquip = self:Get("view/equips/necklace", "GameObject")
    end
    return self.mNeckEquip
end
---左手镯
function UIServantPanel_Base:GetLeftCuff_GameObject()
    if self.mLeftCuff == nil then
        self.mLeftCuff = self:Get("view/equips/cuffLeft", "GameObject")
    end
    return self.mLeftCuff
end
---右手镯
function UIServantPanel_Base:GetRightCuff_GameObject()
    if self.mRightCuff == nil then
        self.mRightCuff = self:Get("view/equips/cuffRight", "GameObject")
    end
    return self.mRightCuff
end
---左戒指
function UIServantPanel_Base:GetLeftRing_GameObject()
    if self.mLeftRing == nil then
        self.mLeftRing = self:Get("view/equips/ringLeft", "GameObject")
    end
    return self.mLeftRing
end
---右戒指
function UIServantPanel_Base:GetRightRing_GameObject()
    if self.mRightRing == nil then
        self.mRightRing = self:Get("view/equips/ringRight", "GameObject")
    end
    return self.mRightRing
end
---腰带
function UIServantPanel_Base:GetBelt_GameObject()
    if self.mCloth == nil then
        self.mCloth = self:Get("view/equips/cloth", "GameObject")
    end
    return self.mCloth
end
---鞋子
function UIServantPanel_Base:GetShoes_GameObject()
    if self.mShoes == nil then
        self.mShoes = self:Get("view/equips/shoes", "GameObject")
    end
    return self.mShoes
end
---法宝
function UIServantPanel_Base:GetMagicWeapon_GameObject()
    if (self.mMagicWeapon_GameObject == nil) then
        self.mMagicWeapon_GameObject = self:Get("view/magicWeapon/magicWeapon", "GameObject");
    end
    return self.mMagicWeapon_GameObject;
end

--endregion

--region 肉身装备

---脑
function UIServantPanel_Base:GetBrain_GameObject()
    if self.mBrain == nil then
        self.mBrain = self:Get("view/body/Brain", "GameObject")
    end
    return self.mBrain
end
---心
function UIServantPanel_Base:GetHeart_GameObject()
    if self.mHeart == nil then
        self.mHeart = self:Get("view/body/Heart", "GameObject")
    end
    return self.mHeart
end
---骨
function UIServantPanel_Base:GetBone_GameObject()
    if self.mBone == nil then
        self.mBone = self:Get("view/body/Bone", "GameObject")
    end
    return self.mBone
end
---血
function UIServantPanel_Base:GetBlood_GameObject()
    if self.mBlood == nil then
        self.mBlood = self:Get("view/body/Blood", "GameObject")
    end
    return self.mBlood
end
--endregion

--region 按钮
function UIServantPanel_Base:GetAllBtn_GameObject()
    if self.mAllBtnView == nil then
        self.mAllBtnView = self:Get("events", "GameObject")
    end
    return self.mAllBtnView
end

function UIServantPanel_Base:GetFitBtn_UILabel()
    if (self.mFitBtnUILabel == nil) then
        self.mFitBtnUILabel = self:Get("events/btn_heti/label", "UILabel")
    end
    return self.mFitBtnUILabel
end

function UIServantPanel_Base:GetFightBtn_UILabel()
    if (self.mFightBtnUILabel == nil) then
        self.mFightBtnUILabel = self:Get("events/btn_chuzhan/label", "UILabel")
    end
    return self.mFightBtnUILabel
end

function UIServantPanel_Base:GetFightBtnBottom_TweenPosition()
    if (self.mFightBtnBottomTween == nil) then
        self.mFightBtnBottomTween = self:Get("events/btnbg", "Top_TweenPosition")
    end
    return self.mFightBtnBottomTween
end
--endregion

--region 出战
function UIServantPanel_Base:GetFitBtn_GameObject()
    if (self.mFitBtn == nil) then
        self.mFitBtn = self:Get("events/btn_heti", "GameObject")
    end
    return self.mFitBtn
end

function UIServantPanel_Base:GetFightBtn_GameObject()
    if (self.mFightBtn == nil) then
        self.mFightBtn = self:Get("events/btn_chuzhan", "GameObject")
    end
    return self.mFightBtn
end

function UIServantPanel_Base:GetRegainBtn_GameObject()
    if (self.mRegainBtn == nil) then
        self.mRegainBtn = self:Get("events/btn_huishou", "GameObject")
    end
    return self.mRegainBtn
end
--endregion
--endregion

--region 初始化
function UIServantPanel_Base:Init(panel)
    self.mLidToGrid = {}
    self.mLidToChoose = {}
    self.mGridToEffect = {}
    self.ServantPanel = panel;
    self:InitComponents();
    self:InitData()
    self.ModelBG = nil
    ---当前选中格子信息
    UIServantPanel_Base.mCurrentChooseInfoId = nil
end

function UIServantPanel_Base:InitData()
    self.mLidToChoose = {}
    UIServantPanel_Base.mShowEquipReinLevel = self:GetNoticeTableData(13)
end

--region 读取数据
---获取Notice表数据
function UIServantPanel_Base.GetNoticeTableData(id)
    local res2, limit2 = CS.Cfg_NoticeTableManager.Instance:TryGetValue(id)
    if res2 then
        return tonumber(limit2.conceal)
    end
    return nil
end

---获取Global表数据
function UIServantPanel_Base.GetGlobalTableData(id)
    local res2, limit2 = CS.Cfg_GlobalTableManager.Instance:TryGetValue(id)
    if res2 then
        return limit2.value
    end
    return nil
end
--endregion

function UIServantPanel_Base:InitComponents()
    --self.ServantPanel:GetShowAttributeBtn_GameObject():SetActive(true)
    self.mIndexToEquipTemp = {}
    self.mIndexToEquipTemp[1] = templatemanager.GetNewTemplate(self:GetNeckEquip_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[2] = templatemanager.GetNewTemplate(self:GetLeftRing_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[12] = templatemanager.GetNewTemplate(self:GetRightRing_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[3] = templatemanager.GetNewTemplate(self:GetLeftCuff_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[13] = templatemanager.GetNewTemplate(self:GetRightCuff_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[4] = templatemanager.GetNewTemplate(self:GetBelt_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[5] = templatemanager.GetNewTemplate(self:GetShoes_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToEquipTemp[6] = templatemanager.GetNewTemplate(self:GetMagicWeapon_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel);
    self.mAddGridToEquipIndex = {}
    self.mCanEquipGridToInfo = {}

    ---初始化灵兽肉身(绑定组件存储信息等)
    self.mIndexToBodyTemp = {}
    self.mIndexToBodyTemp[1] = templatemanager.GetNewTemplate(self:GetBrain_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToBodyTemp[2] = templatemanager.GetNewTemplate(self:GetHeart_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToBodyTemp[3] = templatemanager.GetNewTemplate(self:GetBone_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)
    self.mIndexToBodyTemp[4] = templatemanager.GetNewTemplate(self:GetBlood_GameObject(), luaComponentTemplates.UIServantEquipGridTemplate, self.ServantPanel)

    if (self.ServantPanel.mPanelOpenSourceType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        CS.UIEventListener.Get(self:GetEquipHelp_GameObject()).LuaEventTable = self
        CS.UIEventListener.Get(self:GetEquipHelp_GameObject()).OnClickLuaDelegate = self.OntEquipHelpClicked
        CS.UIEventListener.Get(self:GetFitBtn_GameObject()).LuaEventTable = self
        CS.UIEventListener.Get(self:GetFitBtn_GameObject()).OnClickLuaDelegate = self.FitBtnOnClick
        CS.UIEventListener.Get(self:GetFightBtn_GameObject()).LuaEventTable = self
        CS.UIEventListener.Get(self:GetFightBtn_GameObject()).OnClickLuaDelegate = self.FightBtnOnClick
        CS.UIEventListener.Get(self:GetRegainBtn_GameObject()).LuaEventTable = self
        CS.UIEventListener.Get(self:GetRegainBtn_GameObject()).OnClickLuaDelegate = self.RegainBtnOnClick
        CS.UIEventListener.Get(self:GetMagicWeapon_GameObject()).LuaEventTable = self
        self.CallOnServantStateUpdate = function(msgId, msgData)
            self:PlayEffect("700090", self:GetChangeEffectRoot_GameObject().transform, 1);
        end

        self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantUpperBattle, self.CallOnServantStateUpdate)
        self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_ServantChange, self.CallOnServantStateUpdate)
    end
end
--endregion

function UIServantPanel_Base:Show()
    self.go:SetActive(true)
    self:InitInfo()
end

function UIServantPanel_Base:HideButtons()
    self:GetAllBtn_GameObject():SetActive(false);
end

function UIServantPanel_Base:Hide()
    self.go:SetActive(false)
    self.ServantPanel:GetBtnShowAttribute():SetActive(false)
    if (self.ModelBG ~= nil) then
        self.ModelBG:SetActive(false)
    end
    if (self.mEffectDic ~= nil) then
        for k, v in pairs(self.mEffectDic) do
            v:SetActive(false)
        end
    end
    self.ServantPanel:GetTabEquip_UIToggle().value = false
end

---@param servantInfo servantV2.ServantInfo
---@param panelOpenType LuaEnumPanelOpenSourceType 灵兽界面打开类型(可以为空)
---@param bagItemInfo bagV2.BagItemInfo 设置默认选中格子
function UIServantPanel_Base:RefreshServant(servantInfo, panelOpenType, bagItemInfo)
    self.mLidToGrid = {}
    ---@type table<UnityEngine.GameObject,UIServantEquipGridTemplate>
    self.mGridToTemplate = {}
    ---@type table<UnityEngine.GameObject,bagV2.BagItemInfo>
    self.mGridToEquipInfo = {}
    ---标记是否需要显示灵兽装备状态
    self.mNeedShowServantEquip = nil
    self.ServantInfo = servantInfo
    if servantInfo == nil then
        self.ServantSeatType = nil
    else
        self.ServantSeatType = servantInfo.type
    end
    self.ServantPanelOpenType = panelOpenType
    if bagItemInfo and bagItemInfo.lid and UIServantPanel_Base.mCurrentChooseInfoId == nil then
        UIServantPanel_Base.mCurrentChooseInfoId = bagItemInfo.lid
    end
    self:ParseCombineData()
    self:UpdateServantAttriBute(servantInfo)

    local ServantItemHeadList = self.ServantPanel.ServantItemHeadList;
    for k, v in pairs(ServantItemHeadList) do
        v:UpdateServantIconShadow();
    end

    --未装备幻兽 空档位
    if (self.mLastHeadInfo ~= nil) then
        self.mLastHeadInfo:HideAllBackGround();
    end
    if (self.ServantPanel:GetSelectHeadInfo() ~= nil) then
        self.ServantPanel:GetSelectHeadInfo():UpdateBackGround();
        self.mLastHeadInfo = self.ServantPanel:GetSelectHeadInfo();
    end
    if (servantInfo == nil or servantInfo.servantId == 0) then
        self.ServantPanel:GetBtnShowAttribute():SetActive(false)
    else
        self.ServantPanel:GetSelectHeadInfo().id = servantInfo.servantId
        self.ServantPanel:GetBtnShowAttribute():SetActive(self:IsShowArrow())
    end
    self:SetAllButtonShow(servantInfo ~= nil and servantInfo.servantId ~= 0)
    self:UpdateServantModel(self:GetModel_ObservationModel(), self:GetModelRoot())
    self:ChangeStateBtn(self.ServantInfo)
    self:RefreshPanel()
    self:UpdateServantEquip()
    self:ShowBodyEquip()
    self:ShowMagicWeapon();
    self:SetEquipShow()
end

---是否显示箭头(可重写)
---@return boolean
function UIServantPanel_Base:IsShowArrow()
    return self.ServantPanelOpenType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
end

--region UIEvents
---设置出战合体按钮隐藏显示
function UIServantPanel_Base:SetAllButtonShow(isShow)
    self:GetAllBtn_GameObject():SetActive(isShow)
end

---出战按钮
function UIServantPanel_Base:FightBtnOnClick(go)
    local info = self.ServantPanel:GetSelectServantInfo()
    if (info == nil) then
        return ;
    end
    local isFind, mapTable = CS.Cfg_MapTableManager.Instance:TryGetValue(CS.CSScene.MainPlayerInfo.MapID);
    if (isFind and mapTable.innerCondition ~= nil and mapTable.innerCondition.list.Count > 0) then
        local lv = mapTable.innerCondition.list[0]
        local rein = mapTable.innerCondition.list[1]
        if (info.level < lv) then
            self.ServantPanel:ShowTips(go, 102, "灵兽等级不足" .. lv)
            return
        end
        if (info.rein < rein) then
            self.ServantPanel:ShowTips(go, 102, "灵兽转生不足" .. rein)
            return
        end
    end

    --if info.state == LuaEnumServantStateType.Death then
    --self.ServantPanel:ShowTips(go, 20)
    --else
    if info.state == LuaEnumServantStateType.Battle then
        return
    else
        if (self:CheckClickTime(info.type)) then
            networkRequest.ReqServantChangeState(LuaEnumServantStateType.Battle, info.type)
        else
            self.ServantPanel:ShowTips(go, 16)
        end
    end
end

---合体按钮
function UIServantPanel_Base:FitBtnOnClick(go)

    local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
    if (not MiBaores) then
        self.ServantPanel:ShowTips(go, 17)
        return
    end

    local info = self.ServantPanel:GetSelectServantInfo()

    --if info.state == LuaEnumServantStateType.Death then
    --    self.ServantPanel:ShowTips(go, 20)
    --else
    if info.state == LuaEnumServantStateType.Combine then
        return
    else
        if (self:CheckClickTime(info.type)) then
            networkRequest.ReqServantChangeState(LuaEnumServantStateType.Combine, info.type)
        else
            self.ServantPanel:ShowTips(go, 16)
        end
    end
end

---收回按钮
function UIServantPanel_Base:RegainBtnOnClick(go)
    if uiStaticParameter.nowPracticeIndex == self.ServantPanel:GetSelectServantInfo().type then
        local mDestroyInfo = {
            ID = 106,
            CallBack = function()
                self:Regain()
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, mDestroyInfo)
    else
        self:Regain()
    end

    --local mDestroyInfo = {
    --    Title = "[fbd671]提   示",
    --    Content = "[c9b39c]灵兽下阵后，所有培养内容将保留并由下一个灵兽继承，是否确定下阵该灵兽？",
    --    CallBack = function()
    --        networkRequest.ReqServantChangeState(LuaEnumServantStateType.Rest, info.type)
    --        self.ServantPanel:GetSelectHeadInfo():GetBtnUseLight_GameObject():SetActive(true)
    --    end
    --}
    --uimanager:CreatePanel("UIPromptPanel", nil, mDestroyInfo)

end

function UIServantPanel_Base:Regain()
    local info = self.ServantPanel:GetSelectServantInfo()
    self.ServantPanel:GetSelectHeadInfo():GetBtnUseLight_GameObject():SetActive(true)
    networkRequest.ReqServantChangeState(LuaEnumServantStateType.Rest, info.type)
    local servantheadpanel = uimanager:GetPanel("UIServantHeadPanel")
    if (servantheadpanel ~= nil) then
        servantheadpanel.onResShowEffectInServantHead(nil, self.ServantPanel.ServantIndex + 1)
    end
end

---重命名按钮
function UIServantPanel_Base:RenameBtnOnClick(GO)
    local customData = {};
    customData.defaultValue = self.mCurChooseTemplate.name;
    customData.SureCallBack = function(value)
        networkRequest.ReqRename(self.ServantPanel.mCurSerVantInfo.type, value)
    end
    uimanager:CreatePanel("UIChangeNamePanel", nil, customData, "请输入新的灵兽名字");
end
--endregion

function UIServantPanel_Base:OnServantStateUpdate(updateState)
    if (updateState == LuaEnumServantUpdateState.UpperBattle or updateState == LuaEnumServantUpdateState.Change) then
        self:PlayEffect("700090", self.ModelBG.transform);
    end
end

function UIServantPanel_Base:CheckClickTime(type)
    if (self.TypeClickLimitTimeDic[type] == nil) then
        self.TypeClickLimitTimeDic[type] = CS.UnityEngine.Time.time
        return true
    end
    if (CS.UnityEngine.Time.time > self.TypeClickLimitTimeDic[type] + 5) then
        self.TypeClickLimitTimeDic[type] = CS.UnityEngine.Time.time
        return true;
    end
    return false;
end

--region 模型

function UIServantPanel_Base:GetView_GameObject()
    if (self.mView == nil) then
        self.mView = self:Get("view", "GameObject")
    end
    return self.mView
end

---@return UnityEngine.GameObject
function UIServantPanel_Base:GetModelRoot()
    if (self.mView == nil) then
        self.mView = self:Get("view/ModelRoot", "GameObject")
    end
    return self.mView
end

---@return ObservationModel
function UIServantPanel_Base:GetModel_ObservationModel()
    if (self.mModel == nil) then
        self.mModel = CS.ObservationModel()
    end
    return self.mModel
end

---更新灵兽模型
---@param ObservationModel ObservationModel
---@param ModelRootGO UnityEngine.GameObject
function UIServantPanel_Base:UpdateServantModel(ObservationModel, ModelRootGO)
    if ObservationModel == nil or CS.StaticUtility.IsNull(ModelRootGO) then
        return
    end
    ---@type CSServantSeatData
    local seatData
    if self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.ServantSeatType)
    else
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    end
    local monsterID
    local servantID
    if seatData ~= nil and seatData.State ~= CS.CSServantSeatData.SeatState.Locked and seatData.State ~= CS.CSServantSeatData.SeatState.Recall then
        monsterID = seatData:GetMonsterID(true)
        --servantID = seatData.ServantInfo.cfgId
        servantID = monsterID
    end
    if self.mPreviousServantModelMID == monsterID then
        return
    end
    self.mPreviousServantModelMID = monsterID
    if self.mPreviousServantModelMID == nil or self.mPreviousServantModelMID == 0 then
        ObservationModel:ClearModel()
        self.mPreviousServantModelMID = nil
        return
    end
    local servant
    ---@type TABLE.CFG_MONSTERS
    local monsterTbl
    ___, servant = CS.Cfg_ServantTableManager.Instance:TryGetValue(servantID)
    ___, monsterTbl = CS.Cfg_MonsterTableManager.Instance:TryGetValue(self.mPreviousServantModelMID)
    if monsterTbl ~= nil then
        self.mCurSerVantModelId = monsterTbl.model
    else
        self.mCurSerVantModelId = 0
    end
    if (servant ~= nil) then
        self.mWeight = servant.weight
        self.mTotalWeight = servant.weight
        self.mHSScale = servant.hsScale / 100
    else
        ObservationModel:ClearModel()
        self.mPreviousServantModelMID = nil
        return
    end
    ObservationModel:ClearModel()
    if (self.ServantPanel:GetSelectServantInfo() == nil) then
        return
    end
    ObservationModel:SetShowMotion(CS.CSMotion.ShowStand)
    ObservationModel:SetPosition(CS.UnityEngine.Vector3(-180 - servant.offsetX, -150 + servant.y, 300))
    ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    ObservationModel:SetPositionDeviation(servant.offsetX)
    ObservationModel:SetBindRenderQueue()
    ObservationModel:SetDragRoot(ModelRootGO)
    ObservationModel:CreateModel(self.mCurSerVantModelId, CS.EAvatarType.Monster, ModelRootGO.transform, function()
        if (self.mWeight ~= nil and self.mTotalWeight ~= nil and self.mTotalWeight ~= 0 and self.mHSScale ~= 0
                and CS.StaticUtility.IsNull(self.go) == false) then
            ObservationModel:ResetCurScale()
            local num = tonumber(self.ServantPanel:GetSelectServantInfo().weight / self.mTotalWeight * self.mHSScale)-- * self.mScaleK
            ObservationModel:SetScaleSizeforRatio(num * 1.2)
        end
    end)
end
--endregion

---玩家等级超过某个等级时才显示
function UIServantPanel_Base:SetEquipShow()
    if self:IsShowServantEquip() then
        self:GetEquipView_GameObject():SetActive(false)
        self:SetBodyEquipPos(true);
        return
    end
    self:GetEquipView_GameObject():SetActive(false)
    self:SetBodyEquipPos(false);
end

function UIServantPanel_Base:SetBodyEquipPos(isReined)
    local hartPos = self:GetHeart_GameObject().transform.localPosition;
    local heartX = isReined and -280 or -322
    self:GetHeart_GameObject().transform.localPosition = CS.UnityEngine.Vector3(heartX, hartPos.y, hartPos.z);
    local brainPos = self:GetBrain_GameObject().transform.localPosition;
    local brainX = isReined and -280 or -322
    self:GetBrain_GameObject().transform.localPosition = CS.UnityEngine.Vector3(brainX, brainPos.y, brainPos.z);
    local bonePos = self:GetBone_GameObject().transform.localPosition;
    local boneX = isReined and -76 or -35
    self:GetBone_GameObject().transform.localPosition = CS.UnityEngine.Vector3(boneX, bonePos.y, bonePos.z);
    local bloodPos = self:GetBlood_GameObject().transform.localPosition;
    local bloodX = isReined and -76 or -35
    self:GetBlood_GameObject().transform.localPosition = CS.UnityEngine.Vector3(bloodX, bloodPos.y, bloodPos.z);
    local magicWeaponPos = self:GetMagicWeapon_GameObject().transform.localPosition;
    local magicWeaponX = isReined and -368 or -330;
    self:GetMagicWeapon_GameObject().transform.localPosition = CS.UnityEngine.Vector3(magicWeaponX, magicWeaponPos.y, magicWeaponPos.z);
end

--region 装备状态
---刷新灵兽装备
function UIServantPanel_Base:UpdateServantEquip()
    local equipInfo
    if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        equipInfo = self.ServantPanel:GetServantInfo().OtherServantEquip
    else
        equipInfo = self.ServantPanel:GetServantInfo().ServantEquip
    end
    local servantType = self.ServantPanel:GetSelectServantInfo() and self.ServantPanel:GetSelectServantInfo().type or -1

    local neckIndex = servantType * 1000 + 200 + 1
    local leftRingIndex = servantType * 1000 + 200 + 2
    local rightRingIndex = servantType * 1000 + 200 + 2 + 10
    local leftCuffIndex = servantType * 1000 + 200 + 3
    local rightCuffIndex = servantType * 1000 + 200 + 3 + 10

    local bultIndex = servantType * 1000 + 200 + 4
    local shoesIndex = servantType * 1000 + 200 + 5

    local magicWeaponIndex = servantType * 1000 + 6;
    --项链
    self:UpdateItem(1, self:GetNeckEquip_GameObject(), equipInfo, neckIndex, servantType)
    --左戒指
    self:UpdateItem(2, self:GetLeftRing_GameObject(), equipInfo, leftRingIndex, servantType)
    --右戒指
    self:UpdateItem(12, self:GetRightRing_GameObject(), equipInfo, rightRingIndex, servantType)
    --左手镯
    self:UpdateItem(3, self:GetLeftCuff_GameObject(), equipInfo, leftCuffIndex, servantType)
    --右手镯
    self:UpdateItem(13, self:GetRightCuff_GameObject(), equipInfo, rightCuffIndex, servantType)
    --腰带
    self:UpdateItem(4, self:GetBelt_GameObject(), equipInfo, bultIndex, servantType)
    --鞋子
    self:UpdateItem(5, self:GetShoes_GameObject(), equipInfo, shoesIndex, servantType)
    --法宝
    self:UpdateItem(6, self:GetMagicWeapon_GameObject(), equipInfo, magicWeaponIndex, servantType)

    self:RefreshBodyEquip()

    ---刷新完清除数据
    self.ServantPanel:GetServantInfo():ClearReqEquipData()
end

function UIServantPanel_Base:UpdateItem(equipPosIndex, obj, equipInfo, equipIndex, servantType)
    if self.mIndexToEquipTemp[equipPosIndex] ~= nil then
        self:RefreshGridTemp(self.mIndexToEquipTemp[equipPosIndex], equipIndex, equipInfo, obj, servantType)
        if (self.mIndexToEquipTemp[equipPosIndex] ~= nil) then
            self.mIndexToEquipTemp[equipPosIndex]:SetEquipPosIndex(equipPosIndex, servantType);
        end

        if (equipPosIndex ~= 6) then
            if self:SetLock(obj) then
                CS.UIEventListener.Get(obj).LuaEventTable = self
                CS.UIEventListener.Get(obj).OnClickLuaDelegate = self.OnClickLock
            end
        else
            if CS.StaticUtility.IsNull(obj) == false then
                local lock = obj.transform:Find("lock").gameObject
                if (lock ~= nil) then
                    lock:SetActive(false);
                end
            end
        end
    end
end

---设置锁
function UIServantPanel_Base:SetLock(grid)
    if CS.StaticUtility.IsNull(grid) then
        return false
    end
    local isShow = true
    if self.ServantPanel.mShowEquipReinLevel and self.ServantPanel:GetSelectServantInfo() then
        isShow = self.ServantPanel:GetSelectServantInfo().rein < self.ServantPanel.mShowEquipReinLevel
    end
    local lock = grid.transform:Find("lock").gameObject
    local redPoint = grid.transform:Find("RedPoint").gameObject
    lock:SetActive(isShow)
    redPoint:SetActive(false)
    return isShow
end

---点击锁
function UIServantPanel_Base.OnClickLock(obj, gameObject)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Describe] = "灵兽转生后开启"
    TipsInfo[LuaEnumTipConfigType.Parent] = gameObject.transform;
    TipsInfo[LuaEnumTipConfigType.ConfigID] = 31
    return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    --CS.Utility.ShowTips("灵兽转生后开启", 1, CS.ColorType.Red)
end
--endregion

function UIServantPanel_Base:ChangeStateBtn(info)
    if (info ~= nil and info.type == self.ServantPanel.ServantIndex + 1 and info.state == 0) then
        --死亡
        self:GetFitBtn_UILabel().text = "[878787]合体"
        self:GetFightBtn_UILabel().text = "[878787]出战"
        if (info.reviveState == 1) then
            self:GetFightBtnBottom_TweenPosition():PlayReverse()
        elseif (info.reviveState == 2) then
            self:GetFightBtnBottom_TweenPosition():PlayForward()
        end
    end
    if (info ~= nil and info.type == self.ServantPanel.ServantIndex + 1 and info.state == 1) then
        --出战
        self:GetFightBtnBottom_TweenPosition():PlayReverse()
        self:GetFitBtn_UILabel().text = "[878787]合体"
        self:GetFightBtn_UILabel().text = "[dde6eb]出战中"
    end
    if (info ~= nil and info.type == self.ServantPanel.ServantIndex + 1 and info.state == 2) then
        --合体
        self:GetFightBtnBottom_TweenPosition():PlayForward()
        self:GetFitBtn_UILabel().text = "[dde6eb]合体中"
        self:GetFightBtn_UILabel().text = "[878787]出战"
    end
end

--region 刷新装备显示状态肉身/法宝/装备
---刷新肉身装备
function UIServantPanel_Base:RefreshBodyEquip()
    local equipInfo
    if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        equipInfo = self.ServantPanel:GetServantInfo().OtherServantEquip
    else
        equipInfo = self.ServantPanel:GetServantInfo().ServantEquip
    end
    local servantType = self.ServantPanel:GetSelectServantInfo() and self.ServantPanel:GetSelectServantInfo().type or -1

    local brainIndex = servantType * 1000 + 101
    local heartIndex = servantType * 1000 + 102
    local boneIndex = servantType * 1000 + 103
    local bloodIndex = servantType * 1000 + 104
    --脑
    if self.mIndexToBodyTemp[1] ~= nil then
        self:RefreshGridTemp(self.mIndexToBodyTemp[1], brainIndex, equipInfo, self:GetBrain_GameObject(), servantType)
    end
    --心
    if self.mIndexToBodyTemp[2] ~= nil then
        self:RefreshGridTemp(self.mIndexToBodyTemp[2], heartIndex, equipInfo, self:GetHeart_GameObject(), servantType)
    end
    --骨
    if self.mIndexToBodyTemp[3] ~= nil then
        self:RefreshGridTemp(self.mIndexToBodyTemp[3], boneIndex, equipInfo, self:GetBone_GameObject(), servantType)
    end
    --血
    if self.mIndexToBodyTemp[4] ~= nil then
        self:RefreshGridTemp(self.mIndexToBodyTemp[4], bloodIndex, equipInfo, self:GetBlood_GameObject(), servantType)
    end
end

---是否显示装备格子
function UIServantPanel_Base:ShowServantEquip()
    self:SetServantEquipShow(false)
    --self:IsShowServantEquip()
end

function UIServantPanel_Base:ShowBodyEquip()
    self:SetBodyEquipShow(false)
    --self:IsShowBodyEquip()
end

function UIServantPanel_Base:ShowMagicWeapon()
    self:SetServantMagicWeaponShow(false);
    --self:IsShowServantMagicWeapon()
end

---判断当前灵兽是否需要显示装备
---@return boolean
function UIServantPanel_Base:IsShowServantEquip()
    ---直接走配置
    local isOtherServant = self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
    self.mNeedShowServantEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(self.ServantSeatType, isOtherServant)
    return self.mNeedShowServantEquip
    --if self.mNeedShowServantEquip == nil then
    --    local state = false
    --    local playerLevel = 0
    --    local playerReinLevel = 0
    --    if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
    --        if CS.CSScene.MainPlayerInfo.OtherPlayerInfo ~= nil or CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo then
    --            ---@type roleV2.RoleToOtherInfo
    --            local otherRoleInfo = CS.CSScene.MainPlayerInfo.OtherPlayerInfo.OtherRoleInfo
    --            playerLevel = otherRoleInfo.level
    --        end
    --    else
    --        playerLevel = CS.CSScene.MainPlayerInfo.Level
    --        playerReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
    --    end
    --    local limitLevel, limitReinLevel = LuaGlobalTableDeal.GetServantEquipShowLevelAndReinLevel()
    --    local levelFull = playerLevel >= limitLevel and playerReinLevel >= limitReinLevel
    --
    --    if levelFull then
    --        local hasEquip = self:HasCanEquipServantEquip()
    --        if hasEquip then
    --            state = true
    --        end
    --    end
    --    self.mNeedShowServantEquip = state
    --end
    --return self.mNeedShowServantEquip
end

---@return boolean 是否有可装备或者已准备的灵兽装备
function UIServantPanel_Base:HasCanEquipServantEquip()
    if self.ServantInfo then
        local servantType = self.ServantInfo.type
        local hasEquiped = self:HasServantEquiped(servantType)
        if self.ServantInfo.servantEgg then
            local canEquiped = self:HasCanEquipInBag(servantType)
            return hasEquiped or canEquiped
        else
            return hasEquiped
        end
    end
    return false
end

---@return boolean 灵兽是否有已装备
---@param type luaEnumServantType 灵兽类型
function UIServantPanel_Base:HasServantEquiped(type)
    if type then
        local equipInfo = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetSingleServantEquipData(type)
        if equipInfo then
            local allEquipIndex = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetSingleServantAllServantEquipIndex(type)
            for i = 1, #allEquipIndex do
                local index = allEquipIndex[i]
                local equip = equipInfo:GetSingleEquipByEquipIndex(index)
                if equip then
                    return true
                end
            end
        end
    end
    return false
end

---@return boolean 背包中是否有可装备
function UIServantPanel_Base:HasCanEquipInBag(type)
    if type == nil then
        return false
    end
    local info = self.ServantPanel:GetServantInfo()
    if info == nil then
        return false
    end
    local allEquipIndex = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():GetSingleServantAllServantEquipIndex(type)
    if allEquipIndex then
        for i = 1, #allEquipIndex do
            local index = allEquipIndex[i]
            local canEquip = info:GetBagServantEquip(index)
            if canEquip then
                return true
            end
        end
    end
    return false
end

function UIServantPanel_Base:IsShowServantMagicWeapon()
    local isShowServantEquip = false
    --self:IsShowServantEquip();
    local hasEquip = false;
    local equipDic = nil;
    local servantType = self.ServantPanel:GetSelectIndex() + 1;
    local isInBattle = false

    local magicWeaponIndex = servantType * 1000 + 6;
    if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        equipDic = self.ServantPanel:GetServantInfo().OtherServantEquip;
        local res, equipInfo = equipDic:TryGetValue(magicWeaponIndex)
        if res then
            hasEquip = true;
        end
        isInBattle = true
    else
        equipDic = self.ServantPanel:GetServantInfo().ServantEquip;
        local res, equipInfo = equipDic:TryGetValue(magicWeaponIndex)
        if res then
            hasEquip = true;
        end
        local canEquip = self.ServantPanel:GetServantInfo():GetBagServantEquip(magicWeaponIndex)

        hasEquip = hasEquip or canEquip;

        isInBattle = self.ServantPanel:GetServantInfo().ServantInfoList.Count >= servantType and
                self.ServantPanel:GetServantInfo().ServantInfoList[servantType - 1].servantId ~= 0
    end
    return isShowServantEquip or hasEquip or isInBattle;
end

---判断当前灵兽是否需要显示肉身装备（灵兽70级以下如果没有装备或者可装备则隐藏）
function UIServantPanel_Base:IsShowBodyEquip()
    if self.ServantInfo ~= nil then
        local servantType = self.ServantPanel:GetSelectIndex() + 1
        local equipInfo = self.ServantPanel:GetServantInfo().ServantEquip
        local info = self.ServantPanel:GetServantInfo()
        local bodyIndex = { servantType * 1000 + 101, servantType * 1000 + 102, servantType * 1000 + 103, servantType * 1000 + 104 }
        if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
            equipInfo = self.ServantPanel:GetServantInfo().OtherServantEquip
            for i = 1, #bodyIndex do
                local res, dicInfo = equipInfo:TryGetValue(bodyIndex[i])
                if res then
                    return true
                end
            end
            return false
        else
            for i = 1, #bodyIndex do
                local res, dicInfo = equipInfo:TryGetValue(bodyIndex[i])
                if res then
                    return true
                end
                local canEquip = info:GetBagServantEquip(bodyIndex[i])
                if canEquip then
                    return true
                end
            end
            return false
        end
    end
    return false
end

---设置肉身格子隐藏或者显示
function UIServantPanel_Base:SetBodyEquipShow(isShow)
    self:GetBrain_GameObject():SetActive(isShow)
    self:GetHeart_GameObject():SetActive(isShow)
    self:GetBone_GameObject():SetActive(isShow)
    self:GetBlood_GameObject():SetActive(isShow)
end

---设置生肖格子隐藏或者显示
function UIServantPanel_Base:SetServantEquipShow(isShow)
    self:GetEquipView_GameObject():SetActive(isShow)
end

function UIServantPanel_Base:SetServantMagicWeaponShow(isShow)
    self:GetMagicWeapon_GameObject():SetActive(isShow)
end
--endregion

--region 刷新单个格子方法
---刷新单个装备格子
---@param equipInfo Dictionary 灵兽装备字典
---@param index int 装备位置
---@param temp UIServantEquipGridTemplate 灵兽装备格子模板
---@param grid GameObject 格子Obj
---@param servantType int  灵兽类型
function UIServantPanel_Base:RefreshGridTemp(temp, index, equipInfo, grid, servantType)
    if self.mGridToTemplate == nil or (equipInfo == nil) or grid:IsNull() then
        return
    end
    if temp:GetEquipPosIndex() == nil then
        local curEquipIndex = index - servantType * 1000
        temp:SetEquipPosIndex(curEquipIndex, servantType)
    end
    --红点
    local redPoint = grid.transform:Find("RedPoint").gameObject
    redPoint:SetActive(false)
    --加号
    local add = grid.transform:Find("add").gameObject
    --是否显示红点和加号
    local isHideRedPoint = false
    if (self.ServantPanelOpenType and self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByStrengthenPanel or self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) or temp:GetEquipPosIndex() == 6 then
        isHideRedPoint = true
    end
    --灵兽信息
    local info = self.ServantPanel:GetServantInfo()
    --刷新装备信息
    CS.UIEventListener.Get(grid).LuaEventTable = self
    self.mGridToTemplate[grid] = temp
    local res, dicInfo = equipInfo:TryGetValue(index)

    if res then
        local gridEquipInfo = dicInfo
        --该位置有装备
        self.mGridToEquipInfo[grid] = gridEquipInfo
        self.mLidToGrid[dicInfo.lid] = grid
        add:SetActive(false)
        local res, servantInfo
        if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
            res, servantInfo = info.OtherServants:TryGetValue(servantType)
        else
            res, servantInfo = info.Servants:TryGetValue(servantType)
        end
        if res then
            --有元灵刷新正常状态
            if isHideRedPoint then
                self:RefreshStrengthenState(grid, gridEquipInfo)
            end
            self:ShowChooseEffect(grid, self.mLidToChoose[dicInfo.lid])
            temp:RefreshEquip(dicInfo, LuaEnumServantEquipShowColorType.Normal)
            CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickEquip
        else
            --没有元灵显示灰色
            temp:RefreshEquip(dicInfo, LuaEnumServantEquipShowColorType.Gray)
            CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickEquip
            self:ShowChooseEffect(grid, false)
        end
    else
        --if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
        --    return
        --end
        self:ShowChooseEffect(grid, false)
        --该位置没有装备
        temp:ResetEquip(index)
        temp:NoEquipRefresh(index, servantType)

        local canEquip = info:GetBagServantEquip(index)
        local canEquipBody = info:GetBagServantEquip(index)
        local isRoleEquipIndex = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():IsServantRoleEquipIndex(index)
        local servantCanUseRoleEquip = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():ServantIndexCanUseRoleEquip(servantType)
        if isHideRedPoint then
            add:SetActive(false)
            CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickNilEquip
        else
            local empty = self.ServantPanel:GetSelectHeadInfo().info ~= nil and self.ServantPanel:GetSelectHeadInfo().info.servantId ~= 0
            if empty and (canEquip or canEquipBody) and (isRoleEquipIndex == false or servantCanUseRoleEquip == true) then
                add:SetActive(canEquip or canEquipBody)
                self.mAddGridToEquipIndex[grid] = index
                self.mCanEquipGridToInfo[grid] = canEquip
                CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickCanEquip
            else
                add:SetActive(false)
                CS.UIEventListener.Get(grid).OnClickLuaDelegate = self.OnClickNilEquip
            end
        end
    end
end

---刷新为锻造状态
function UIServantPanel_Base:RefreshStrengthenState(grid, gridEquipInfo)
    --当前格子是选中格子
    self:ShowChooseEffect(grid, gridEquipInfo.lid == UIServantPanel_Base.mCurrentChooseInfoId)
    if gridEquipInfo.lid == UIServantPanel_Base.mCurrentChooseInfoId then
        self.CurrentChooseGridTemp = grid
        if luaEventManager.HasCallback(LuaCEvent.Servant_GridClicked) then
            luaEventManager.DoCallback(LuaCEvent.Servant_GridClicked, gridEquipInfo)
        end
    end
end

---点击装备
function UIServantPanel_Base:OnClickEquip(go)
    --local ServantInfo = self.ServantPanel:GetServantInfo()
    if go ~= nil and CS.StaticUtility.IsNull(go) == false then
        local info = self.mGridToEquipInfo[go]
        local temp = self.mGridToTemplate[go]
        if info ~= nil then
            if luaEventManager.HasCallback(LuaCEvent.Servant_GridClicked) then
                if self:IsDoubleClickGridToShowTips() then
                    if self.mCurCliekGridInfo == nil then
                        self.mCurCliekGridInfo = {}
                    end
                    ---双击显示tips
                    if self.mCurCliekGridInfo ~= nil and self.ServantInfo.type == self.mCurCliekGridInfo.type and go == self.mCurCliekGridInfo.curGo then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info, showRight = false, showAssistPanel = false, showBtnIdTable = true, showBind = true })
                    else
                        self.mCurCliekGridInfo.curGo = go
                        self.mCurCliekGridInfo.type = self.ServantInfo.type
                        luaEventManager.DoCallback(LuaCEvent.Servant_GridClicked, info)
                    end
                else
                    luaEventManager.DoCallback(LuaCEvent.Servant_GridClicked, info)
                end
            else
                if (self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant) then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info, showRight = false, showAssistPanel = false, showBtnIdTable = true, showBind = true })
                elseif temp:GetEquipPosIndex() == 6 then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info, showRight = true, showAssistPanel = false, showBtnIdTable = true, showBind = true, rightUpButtonsModule = luaComponentTemplates.UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons })
                else
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info, showRight = true, showAssistPanel = false, showBtnIdTable = true, showBind = true })
                end
            end
        end
    end
end

---点击空格子
function UIServantPanel_Base:OnClickNilEquip(go)
    local temp = self.mGridToTemplate[go];
    local equipPosIndex = temp:GetEquipPosIndex();
    if (equipPosIndex ~= nil and equipPosIndex == 6 and temp.ItemInfo ~= nil) then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false, showAssistPanel = false, showBtnIdTable = true, showBind = true })
        --uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.ServantMagicWeapon
        --Utility.ShowGetWay(22582, go, LuaEnumWayGetPanelArrowDirType.Left, nil, nil, nil, "  灵兽法宝获取途径");
    end
end

---点击可装备格子
function UIServantPanel_Base:OnClickCanEquip(go)
    local mIndex = self.mAddGridToEquipIndex[go]
    local info = self.mCanEquipGridToInfo[go]
    if mIndex ~= nil and info ~= nil then
        self.ServantPanel:GetServantInfo():AddReqEquipData(info.lid)
        networkRequest.ReqPutOnTheEquip(mIndex, info.lid)
    end
end

---设置格子选中特效
---@param grid GameObject 格子
---@param isShow boolean 是否显示特效
function UIServantPanel_Base:ShowChooseEffect(grid, isShow)
    local template = self.mGridToTemplate[grid]
    if template then
        template:SetItemChoose(isShow)
    end
end
--endregion

--region帮助界面
---装备帮助按钮
function UIServantPanel_Base:GetEquipHelp_GameObject()
    if self.mEquipHelp == nil then
        self.mEquipHelp = self:Get("btn_help", "GameObject")
    end
    return self.mEquipHelp
end

---装备帮助界面
function UIServantPanel_Base:OntEquipHelpClicked()
    local info = self:GetHelpTableData(39)
    if (info ~= nil) then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---获取Help表数据
function UIServantPanel_Base:GetHelpTableData(id)
    local res, info = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(id)
    if res then
        return info
    end
    return nil
end
--endregion

--region 属性界面
function UIServantPanel_Base:GetServantName_UILabel()
    if (self.mServantName_UILabel == nil) then
        self.mServantName_UILabel = self:Get("view/rolename", "UILabel")
    end
    return self.mServantName_UILabel
end
function UIServantPanel_Base:GetSecondname_UILabel()
    if (self.mSecondname_UILabel == nil) then
        self.mSecondname_UILabel = self:Get("view/secondname", "UILabel")
    end
    return self.mSecondname_UILabel
end

function UIServantPanel_Base:GetPhyAttack_UILabel()
    if (self.phyAttackMax_UILabel == nil) then
        self.phyAttackMax_UILabel = self:Get("shuxing/Main/gongji", "UILabel")
    end
    return self.phyAttackMax_UILabel
end

function UIServantPanel_Base:GetPhyAttackTitle_UILabel()
    if (self.phyAttackMaxTitle_UILabel == nil) then
        self.phyAttackMaxTitle_UILabel = self:Get("shuxing/Main/gongji/Label", "UILabel")
    end
    return self.phyAttackMaxTitle_UILabel
end

function UIServantPanel_Base:GetPhyDefence_UILabel()
    if (self.phyDefence_UILabel == nil) then
        self.phyDefence_UILabel = self:Get("shuxing/Main/wulifangyu", "UILabel")
    end
    return self.phyDefence_UILabel
end

function UIServantPanel_Base:GetPhyMDefence_UILabel()
    if (self.phyMDefence_UILabel == nil) then
        self.phyMDefence_UILabel = self:Get("shuxing/Main/mofafangyu", "UILabel")
    end
    return self.phyMDefence_UILabel
end

function UIServantPanel_Base:GetPhyHP_UILabel()
    if (self.phyHP_UILabel == nil) then
        self.phyHP_UILabel = self:Get("shuxing/Main/shengmingzhi", "UILabel")
    end
    return self.phyHP_UILabel
end

function UIServantPanel_Base:GetPhyHoly_UILabel()
    if (self.phyHoly_UILabel == nil) then
        self.phyHoly_UILabel = self:Get("shuxing/Main/shensheng", "UILabel")
    end
    return self.phyHoly_UILabel
end

function UIServantPanel_Base:GetPhyHolyDefence_UILabel()
    if (self.phyHolyDefence_UILabel == nil) then
        self.phyHolyDefence_UILabel = self:Get("shuxing/Main/shenshengkangxing", "UILabel")
    end
    return self.phyHolyDefence_UILabel
end

function UIServantPanel_Base:GetCombineAttack_UILabel()
    if (self.CombineAttackMax_UILabel == nil) then
        self.CombineAttackMax_UILabel = self:Get("shuxing/Combine/gongji", "UILabel")
    end
    return self.CombineAttackMax_UILabel
end

function UIServantPanel_Base:GetCombineAttackTitle_UILabel()
    if (self.CombineAttackMaxTitle_UILabel == nil) then
        self.CombineAttackMaxTitle_UILabel = self:Get("shuxing/Combine/gongji/Label", "UILabel")
    end
    return self.CombineAttackMaxTitle_UILabel
end

function UIServantPanel_Base:GetCombineDefence_UILabel()
    if (self.CombineDefence_UILabel == nil) then
        self.CombineDefence_UILabel = self:Get("shuxing/Combine/wulifangyu", "UILabel")
    end
    return self.CombineDefence_UILabel
end

function UIServantPanel_Base:GetCombineMDefence_UILabel()
    if (self.CombineMDefence_UILabel == nil) then
        self.CombineMDefence_UILabel = self:Get("shuxing/Combine/mofafangyu", "UILabel")
    end
    return self.CombineMDefence_UILabel
end

function UIServantPanel_Base:GetCombineHP_UILabel()
    if (self.CombineHP_UILabel == nil) then
        self.CombineHP_UILabel = self:Get("shuxing/Combine/shengmingzhi", "UILabel")
    end
    return self.CombineHP_UILabel
end

function UIServantPanel_Base:GetCombineAttackInherit_UILabel()
    if (self.CombineAttackInherit_UILabel == nil) then
        self.CombineAttackInherit_UILabel = self:Get("shuxing/Combine/gongjijicheng", "UILabel")
    end
    return self.CombineAttackInherit_UILabel
end

function UIServantPanel_Base:GetEquipAttribute_GameObject()
    if (self.mEquipAttribute == nil) then
        self.mEquipAttribute = self:Get("shuxing", "GameObject")
    end
    return self.mEquipAttribute
end

function UIServantPanel_Base:GetEquipRolefight_UILabel()
    if (self.mEquipRolefight == nil) then
        self.mEquipRolefight = self:Get("shuxing/rolefight", "Top_UILabel")
    end
    return self.mEquipRolefight
end

---获取属性列表
---@return Top_UIGridContainer
function UIServantPanel_Base:GetServantAttributeList_UIGridContainer()
    if (self.mServantAttributeList_UIGridContainer == nil) then
        self.mServantAttributeList_UIGridContainer = self:Get("shuxing/Main/attributeGrid", "UIGridContainer")
    end
    return self.mServantAttributeList_UIGridContainer
end

function UIServantPanel_Base:ShowFull(full)
    self:GetEquipAttribute_GameObject():SetActive(full)
end

function UIServantPanel_Base:ParseCombineData()
    local MiBaores, MiBaotab = CS.CSScene.MainPlayerInfo.EquipInfo.Equips:TryGetValue(Utility.EnumToInt(CS.EEquipIndex.POS_RAWANIMA))
    local AttackKey = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan
    local DefineKey = CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_ShouHuZhiYuan
    local attackKey = 1
    local defenceKey = 1
    local mdefenceKey = 1
    local hpKey = 1

    local globalTblMgr = CS.Cfg_GlobalTableManager.Instance;
    local itemTblMgr = CS.Cfg_ItemsTableManager.Instance;
    local mainPlayerCareer = CS.CSScene.MainPlayerInfo.Career
    ---血量&物防&魔防&攻击，#分割职业，战士#法师#道士
    if (mainPlayerCareer == CS.ECareer.Warrior) then
        hpKey = globalTblMgr.Warriorhpkey
        defenceKey = globalTblMgr.Warriordefencekey
        mdefenceKey = globalTblMgr.Warriormdefencekey
        attackKey = globalTblMgr.Warriorattackkey
    elseif (mainPlayerCareer == CS.ECareer.Taoist) then
        hpKey = globalTblMgr.Taoisthpkey
        defenceKey = globalTblMgr.Taoistdefencekey
        mdefenceKey = globalTblMgr.Taoistmdefencekey
        attackKey = globalTblMgr.Taoistattackkey
    elseif (mainPlayerCareer == CS.ECareer.Master) then
        hpKey = globalTblMgr.Masterhpkey
        defenceKey = globalTblMgr.Masterdefencekey
        mdefenceKey = globalTblMgr.Mastermdefencekey
        attackKey = globalTblMgr.Masterattackkey
    end
    if (MiBaores) then
        local Hpres, HPtab = itemTblMgr:TryGetValue(MiBaotab.itemId)
        if (Hpres) then
            self.CombineHP = HPtab.hpPercentage / 10
            --self.CombineHP = math.ceil(tonumber(self.MaxHP) * tonumber(HPtab.hpPercentage) / 1000 * hpKey / 1000)
        end
    end
    if (AttackKey ~= 0) then
        local infobool, iteminfo = itemTblMgr:TryGetValue(AttackKey)
        if (infobool) then
            --self.CombineAttackMin = math.ceil(tonumber(self.PhyAttackMin) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
            --self.CombineAttackMax = math.ceil(tonumber(self.PhyAttackMax) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
            self.CombineAttackMin = iteminfo.attackPercentage / 10
            --self.CombineAttackMax = math.ceil(tonumber(self.PhyAttackMax) * tonumber(iteminfo.attackPercentage) / 1000 * attackKey / 1000)
        end
    end
    if (DefineKey ~= 0) then
        local infobool, iteminfo = itemTblMgr:TryGetValue(DefineKey)
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

function UIServantPanel_Base:UpdateServantAttriBute(info)
    self:GetPhyAttackTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))
    self:GetCombineAttackTitle_UILabel().text = Utility.GetCareerAttackName(Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career))

    if (info == nil) then
        self:GetServantName_UILabel().text = "";
        self:GetSecondname_UILabel().text = "";
        return
    end

    local seatData
    local isOtherPlayerServant = self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
    if isOtherPlayerServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.ServantSeatType)
    else
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    end
    if seatData ~= nil then
        self:GetServantName_UILabel().text = seatData:GetServantName(false, isOtherPlayerServant == false)
    else
        self:GetServantName_UILabel().text = ""
    end
    if (info.attributes == nil) then
        return
    end

    self:RefreshAttribute(info.attributes)
    --for k, v in pairs(info.attributes) do
    --if (info.attributes ~= nil and info.attributes.Count > 0) then
    --    local listCount = info.attributes.Count - 1
    --    for i = 0, listCount do
    --        local v = info.attributes[i];
    --        local type = v.type
    --        local value = v.value
    --        if (type == LuaEnumAttributeType.MaxHp) then
    --            self.MaxHP = value
    --        elseif (type == LuaEnumAttributeType.PhyDefenceMin) then
    --            self.PhyDefenceMin = value
    --        elseif (type == LuaEnumAttributeType.PhyDefenceMax) then
    --            self.PhyDefenceMax = value
    --        elseif (type == LuaEnumAttributeType.PhyAttackMin) then
    --            self.PhyAttackMin = value
    --        elseif (type == LuaEnumAttributeType.MagicAttackMin) then
    --            self.PhyMagicAttackMin = value
    --        elseif (type == LuaEnumAttributeType.TaoAttackMin) then
    --            self.PhyTaoAttackMin = value
    --        elseif (type == LuaEnumAttributeType.PhyAttackMax) then
    --            self.PhyAttackMax = value
    --        elseif (type == LuaEnumAttributeType.MagicAttackMax) then
    --            self.PhyMagicAttackMax = value
    --        elseif (type == LuaEnumAttributeType.TaoAttackMax) then
    --            self.PhyTaoAttackMax = value
    --        elseif (type == LuaEnumAttributeType.MagicDefenceMin) then
    --            self.MagicDefenceMin = value
    --        elseif (type == LuaEnumAttributeType.MagicDefenceMax) then
    --            self.MagicDefenceMax = value
    --        elseif (type == LuaEnumAttributeType.HolyAttackMax) then
    --            self. HolyAttackMax = value
    --        elseif (type == LuaEnumAttributeType.HolyAttackMin) then
    --            self. HolyAttackMin = value
    --        elseif (type == LuaEnumAttributeType.HolyDefenceMax) then
    --            self. HolyDefenceMax = value
    --        elseif (type == LuaEnumAttributeType.HolyDefenceMin) then
    --            self. HolyDefenceMin = value
    --        end
    --    end
    --end

    if (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Warrior) then
    elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Master) then
        self.PhyAttackMin = self.PhyMagicAttackMin
        self.PhyAttackMax = self.PhyMagicAttackMax
    elseif (CS.CSScene.MainPlayerInfo.Career == CS.ECareer.Taoist) then
        self.PhyAttackMin = self.PhyTaoAttackMin
        self.PhyAttackMax = self.PhyTaoAttackMax
    end

    if (info.itemId == 0) then
        self:GetPhyAttack_UILabel().text = 0
        self:GetPhyDefence_UILabel().text = 0
        self:GetPhyMDefence_UILabel().text = 0
        self:GetPhyHP_UILabel().text = 0
        self:GetPhyHoly_UILabel().text = 0
        self:GetPhyHolyDefence_UILabel().text = 0
        self:GetServantName_UILabel().text = ""
        self:GetSecondname_UILabel().text = ""

        self:GetCombineAttack_UILabel().text = "0"
        self:GetCombineDefence_UILabel().text = "0"
        self:GetCombineMDefence_UILabel().text = "0"
        self:GetCombineHP_UILabel().text = "0"
        self:GetCombineAttackInherit_UILabel().text = "0"
        self:GetEquipRolefight_UILabel().text = "0"
        return
    end

    self:GetEquipRolefight_UILabel().text = info.fightPower

    --if (self.PhyAttackMin ~= nil and self.PhyAttackMax ~= nil) then
    --    self:GetPhyAttack_UILabel().text = tostring(self.PhyAttackMin .. " - " .. self.PhyAttackMax)
    --end
    --if (self.PhyDefenceMin ~= nil and self.PhyDefenceMax ~= nil) then
    --    self:GetPhyDefence_UILabel().text = tostring(self.PhyDefenceMin .. " - " .. self.PhyDefenceMax)
    --end
    --if (self.MagicDefenceMin ~= nil and self.MagicDefenceMax ~= nil) then
    --    self:GetPhyMDefence_UILabel().text = tostring(self.MagicDefenceMin .. " - " .. self.MagicDefenceMax)
    --end
    --if (self.HolyDefenceMax ~= nil) then
    --    self:GetPhyHolyDefence_UILabel().text = tostring(self.HolyDefenceMin) .. "-" .. tostring(self.HolyDefenceMax)
    --end
    --if (self.HolyAttackMax ~= nil) then
    --    self:GetPhyHoly_UILabel().text = tostring(self.HolyAttackMin) .. "-" .. tostring(self.HolyAttackMax)
    --end
    --if (self.MaxHP ~= nil) then
    --    self:GetPhyHP_UILabel().text = tostring(self.MaxHP)
    --end

    if (self.name ~= nil) then
        self:GetServantName_UILabel().text = tostring(self.name)
    end

    if (self.CombineAttackMin ~= nil) then
        --and self.CombineAttackMax ~= nil
        self:GetCombineAttack_UILabel().text = tostring(self.CombineAttackMin) .. "%" --.. " - " .. tostring(self.CombineAttackMax)
    end
    if (self.CombineDefenceMin ~= nil) then
        --and self.CombineDefenceMax ~= nil
        self:GetCombineDefence_UILabel().text = tostring(self.CombineDefenceMin) .. "%" --.. " - " .. tostring(self.CombineDefenceMax)
    end
    if (self.CombineMDefenceMin ~= nil) then
        --and self.CombineMDefenceMax ~= nil
        self:GetCombineMDefence_UILabel().text = tostring(self.CombineMDefenceMin) .. "%" --.. " - " .. tostring(self.CombineMDefenceMax)
    end
    if (self.CombineHP ~= nil) then
        self:GetCombineHP_UILabel().text = tostring(self.CombineHP) .. "%"
    end
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(CS.CSScene.MainPlayerInfo.BagInfo.SpecialEquipID_JingGongZhiYuan)
    if (isFind) then
        self:GetCombineAttackInherit_UILabel().text = tostring(info.attackPercentage / 10) .. "%"
    else
        self:GetCombineAttackInherit_UILabel().text = "0"
    end
    -- self:SetSecondname()
end

--region 灵兽属性刷新
---@class ServantPantAttribute
---@field attributeName
---@field attributeDes
---@field labelHorizontalSpacing

---刷新灵兽属性
function UIServantPanel_Base:RefreshAttribute(attributeList)
    local attributeList = self:GetAttributeList(attributeList)
    if type(attributeList) ~= 'table' then
        return
    end
    luaclass.UIRefresh:RefreshGridContainer(self:GetServantAttributeList_UIGridContainer(),attributeList,function(go,attribute)
        ---@type ServantPantAttribute
        local attribute = attribute
        local name_label = luaclass.UIRefresh:GetCurComp(go,"Label","UILabel")
        if attribute.labelHorizontalSpacing == nil then
            attribute.labelHorizontalSpacing = 0
        end
        luaclass.UIRefresh:RefreshLabel(name_label,attribute.attributeName,nil,attribute.labelHorizontalSpacing)
        luaclass.UIRefresh:RefreshLabel(go,attribute.attributeDes)
    end)
end

---获取属性列表
---@return table<ServantPantAttribute>
function UIServantPanel_Base:GetAttributeList(attributeList)
    if attributeList == nil then
        return
    end
    local mainPlayerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local attributeTable = {}
    local attributeName = ""
    local attributeDes = ""

    --region 血量
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MaxHp)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.MaxHp},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 物理攻击
    if mainPlayerCareer == LuaEnumCareer.Warrior then
        attributeName = Utility.GetAttributeName(LuaEnumAttributeType.PhyAttackMax)
        attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.PhyAttackMin, LuaEnumAttributeType.PhyAttackMax},attributeList)
        if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
            ---@type ServantPantAttribute
            local attributeAttribute = {}
            attributeAttribute.attributeName = attributeName
            attributeAttribute.attributeDes = attributeDes
            attributeAttribute.labelHorizontalSpacing = 17
            table.insert(attributeTable,attributeAttribute)
        end
    end
    --endregion

    --region 魔法攻击
    if mainPlayerCareer == LuaEnumCareer.Master then
        attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MagicAttackMax)
        attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.MagicAttackMin, LuaEnumAttributeType.MagicAttackMax},attributeList)
        if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
            ---@type ServantPantAttribute
            local attributeAttribute = {}
            attributeAttribute.attributeName = attributeName
            attributeAttribute.attributeDes = attributeDes
            attributeAttribute.labelHorizontalSpacing = 17
            table.insert(attributeTable,attributeAttribute)
        end
    end
    --endregion

    --region 道术攻击
    if mainPlayerCareer == LuaEnumCareer.Taoist then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeName = Utility.GetAttributeName(LuaEnumAttributeType.TaoAttackMax)
        attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.TaoAttackMin, LuaEnumAttributeType.TaoAttackMax},attributeList)
        if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
            ---@type ServantPantAttribute
            local attributeAttribute = {}
            attributeAttribute.attributeName = attributeName
            attributeAttribute.attributeDes = attributeDes
            attributeAttribute.labelHorizontalSpacing = 17
            table.insert(attributeTable,attributeAttribute)
        end
    end
    --endregion

    --region 物防
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.PhyDefenceMax)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.PhyDefenceMin, LuaEnumAttributeType.PhyDefenceMax},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 魔防
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.MagicDefenceMax)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.MagicDefenceMin, LuaEnumAttributeType.MagicDefenceMax},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 神圣攻击
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.HolyAttackMax)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.HolyAttackMin, LuaEnumAttributeType.HolyAttackMax},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 神圣防御
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.HolyDefenceMax)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.HolyDefenceMin, LuaEnumAttributeType.HolyDefenceMax},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 闪避
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.Dodge)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.Dodge},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    --region 准确
    attributeName = Utility.GetAttributeName(LuaEnumAttributeType.Accurate)
    attributeDes = self:GetCurAttributeValueDes({ LuaEnumAttributeType.Accurate},attributeList)
    if CS.StaticUtility.IsNullOrEmpty(attributeName) == false and CS.StaticUtility.IsNullOrEmpty(attributeDes) == false then
        ---@type ServantPantAttribute
        local attributeAttribute = {}
        attributeAttribute.attributeName = attributeName
        attributeAttribute.attributeDes = attributeDes
        attributeAttribute.labelHorizontalSpacing = 17
        table.insert(attributeTable,attributeAttribute)
    end
    --endregion

    return attributeTable
end

---获取指定属性值列表描述内容
---@param curAttributeTypeTable table<LuaEnumAttributeType> 属性类型列表
---@param attributeList
---@return string
function UIServantPanel_Base:GetCurAttributeValueDes(curAttributeTypeTable,attributeList)
    if type(curAttributeTypeTable) ~= 'table' or attributeList == nil then
        return
    end
    local attributeValueList = {}
    local attributeValueDes = ""
    for k,v in pairs(curAttributeTypeTable) do
        local attributeType = v
        local attributeValue = self:GetAttributeValue(attributeType,attributeList)
        table.insert(attributeValueList,attributeValue)
    end
    local allValueIsZero = Utility.TableValueAllIsCurValue(attributeValueList,0)
    if allValueIsZero == true then
        return
    end
    for k,v in pairs(attributeValueList) do
        if k == #attributeValueList then
            attributeValueDes = attributeValueDes .. tostring(v)
        else
            attributeValueDes = attributeValueDes .. tostring(v) .. " - "
        end
    end
    return attributeValueDes
end

---获取属性值
---@param attributeType LuaEnumAttributeType
---@param attributeList
---@return number 属性值
function UIServantPanel_Base:GetAttributeValue(attributeType,attributeList)
    if attributeType == nil or attributeList == nil then
        return
    end
    local length = attributeList.Count
    for k = 0,length - 1 do
        local v = attributeList[k];
        local curAttributeType = v.type
        local curAttributeValue = v.value
        if curAttributeType == attributeType then
            return curAttributeValue
        end
    end
    return 0
end
--endregion


---设置灵兽位名称
function UIServantPanel_Base:SetSecondname()
    local name = ""
    if self.ServantSeatType == 1 then
        name = "[425e62]寒芒"
    elseif self.ServantSeatType == 2 then
        name = "[705843]落星"
    elseif self.ServantSeatType == 3 then
        name = "[527552]天成"
    end
    self:GetSecondname_UILabel().text = name
end

--endregion

--region 初始化调用（用于其他界面重写）
function UIServantPanel_Base:InitInfo()
end
--endregion

--region 刷新界面
function UIServantPanel_Base:RefreshPanel()
    if self.ServantPanelOpenType and self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByStrengthenPanel or self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        self:GetAllBtn_GameObject():SetActive(false)
    end
end

function UIServantPanel_Base:PlayEffect(effectId, parent, scale)
    if (scale == nil) then
        scale = 100;
    end
    if (parent == nil) then
        parent = self.go.transform;
    end
    if (self.mEffectDic == nil) then
        self.mEffectDic = {};
    end
    if (self.mEffectDic[effectId] == nil) then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectId, CS.ResourceType.UIEffect, function(res)
            if CS.StaticUtility.IsNull(parent) == false and res and res.MirrorObj then
                res.IsCanBeDelete = false
                self.mEffectDic[effectId] = res:GetObjInst();
                if self.mEffectDic[effectId] ~= nil then
                    self.mEffectDic[effectId].transform.parent = parent;
                    self.mEffectDic[effectId].transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0);
                    self.mEffectDic[effectId].transform.localScale = CS.UnityEngine.Vector3(scale, scale, scale);
                end
            end
        end, CS.ResourceAssistType.UI);
    else
        self.mEffectDic[effectId]:SetActive(false);
        self.mEffectDic[effectId]:SetActive(true);
    end
end


--endregion

---再次点击装备时是否显示装备tips
---@return boolean
function UIServantPanel_Base:IsDoubleClickGridToShowTips()
    return false
end

function UIServantPanel_Base:OnDestroy()
    UIServantPanel_Base.mCurrentChooseInfoId = nil
    self.ServantPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_ServantUpperBattle, self.CallOnServantStateUpdate)
    self.ServantPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_ServantChange, self.CallOnServantStateUpdate)
    if self.mModel ~= nil then
        self.mModel:ClearModel()
        self.mModel = nil
    end
end

return UIServantPanel_Base