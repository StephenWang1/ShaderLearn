---@class UIMainSkillPanel:UIBase
local UIMainSkillPanel = {}

--region parameters
UIMainSkillPanel.PanelLayerType = CS.UILayerType.BasicPlane
UIMainSkillPanel.ShotcutConfigList = {}
UIMainSkillPanel.DragPoint = nil
UIMainSkillPanel.autofightEffects = nil
--是否打开道具快捷键
UIMainSkillPanel.IsOpenItemGroup = false
UIMainSkillPanel.mIsOpen = true
UIMainSkillPanel.IsNeedPlayerSpecialSkillCD = false

---快捷道具tween动画原始位置
UIMainSkillPanel.mItemGroupOriginPos = nil;

UIMainSkillPanel.mIsGoingToUpdateFastItemList = false;
--endregion

---自动战斗的icon游戏物体
---@return UnityEngine.GameObject
function UIMainSkillPanel:GetAutoFightIcon_GO()
    if UIMainSkillPanel.mAutoFightIcon_GO == nil then
        UIMainSkillPanel.mAutoFightIcon_GO = UIMainSkillPanel:GetCurComp("WidgetRoot/autofight/icon", "GameObject")
    end
    return UIMainSkillPanel.mAutoFightIcon_GO
end

---攻击按键
function UIMainSkillPanel.Attack_GameObject()
    if UIMainSkillPanel.mAttack_GameObject == nil then
        UIMainSkillPanel.mAttack_GameObject = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack', 'GameObject')
    end
    return UIMainSkillPanel.mAttack_GameObject
end

---攻击按键图标
function UIMainSkillPanel.skillIcon_Top_UISprite()
    if UIMainSkillPanel.mskillIcon_Top_UISprite == nil then
        UIMainSkillPanel.mskillIcon_Top_UISprite = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/skillIcon', 'Top_UISprite')
    end
    return UIMainSkillPanel.mskillIcon_Top_UISprite
end

---技能按键
function UIMainSkillPanel.Skills_Transform()
    if UIMainSkillPanel.mSkills_Transform == nil then
        UIMainSkillPanel.mSkills_Transform = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/skills', 'Transform')
    end
    return UIMainSkillPanel.mSkills_Transform
end

---自动释放技能
function UIMainSkillPanel.Autofight()
    if UIMainSkillPanel.mAutofight == nil then
        UIMainSkillPanel.mAutofight = UIMainSkillPanel:GetCurComp('WidgetRoot/autofight', 'GameObject')
    end
    return UIMainSkillPanel.mAutofight
end

---技能表动画
function UIMainSkillPanel.SkillTable_TweenAni()
    if UIMainSkillPanel.mSkillTable_TweenAni == nil then
        UIMainSkillPanel.mSkillTable_TweenAni = CS.Utility_Lua.GetComponent(UIMainSkillPanel.go.gameObject, "UIPlayTween")
    end
    return UIMainSkillPanel.mSkillTable_TweenAni
end

function UIMainSkillPanel.up_TweenAni()
    if UIMainSkillPanel.mup_TweenAni == nil then
        UIMainSkillPanel.mup_TweenAni = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/up', 'Top_TweenAlpha')
    end
    return UIMainSkillPanel.mup_TweenAni
end

function UIMainSkillPanel.down_TweenAni()
    if UIMainSkillPanel.mdown_TweenAni == nil then
        UIMainSkillPanel.mdown_TweenAni = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/down', 'Top_TweenAlpha')
    end
    return UIMainSkillPanel.mdown_TweenAni
end

---技能快捷栏1
function UIMainSkillPanel.skillsList1()
    if UIMainSkillPanel.mskillsList1 == nil then
        UIMainSkillPanel.mskillsList1 = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/skills', 'GameObject')
    end
    return UIMainSkillPanel.mskillsList1
end

---技能快捷栏2
function UIMainSkillPanel.skillsList2()
    if UIMainSkillPanel.mskillsList2 == nil then
        UIMainSkillPanel.mskillsList2 = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/skills2', 'GameObject')
    end
    return UIMainSkillPanel.mskillsList2
end

---道具组位置设置
function UIMainSkillPanel.ItemGroup()
    if UIMainSkillPanel.mitemGroup == nil then
        UIMainSkillPanel.mitemGroup = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup/itemList', 'Top_TweenPosition')
    end
    return UIMainSkillPanel.mitemGroup
end

---临时道具组
function UIMainSkillPanel.SnapItemGridTemplate()
    if UIMainSkillPanel.mSnapItemGridTemplate == nil then
        UIMainSkillPanel.mSnapItemGridTemplate = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/snapItemGridTemplate', 'GameObject')
    end
    return UIMainSkillPanel.mSnapItemGridTemplate
end

---道具组
function UIMainSkillPanel.ItemGroupPanel()
    if UIMainSkillPanel.mItemGroupPanel == nil then
        UIMainSkillPanel.mItemGroupPanel = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup', 'GameObject')
    end
    return UIMainSkillPanel.mItemGroupPanel
end

---道具组箭头
function UIMainSkillPanel.ItemGroupArrows()
    if UIMainSkillPanel.mItemGroupArrows == nil then
        UIMainSkillPanel.mItemGroupArrows = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup/autofight', 'GameObject')
    end
    return UIMainSkillPanel.mItemGroupArrows
end

---道具组背景图
function UIMainSkillPanel.ItemGroupBackground()
    if UIMainSkillPanel.mitemGroupBackground == nil then
        UIMainSkillPanel.mitemGroupBackground = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup/autofight/Background', 'GameObject')
    end
    return UIMainSkillPanel.mitemGroupBackground
end

---道具组alpha设置
function UIMainSkillPanel.ItemGroup_TweenAlpha()
    if UIMainSkillPanel.mItemGroup_TweenAlpha == nil then
        UIMainSkillPanel.mItemGroup_TweenAlpha = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup/itemList', 'Top_TweenAlpha')
    end
    return UIMainSkillPanel.mItemGroup_TweenAlpha
end

---道具组列表
function UIMainSkillPanel.ItemGroupList()
    if UIMainSkillPanel.mitemList == nil then
        UIMainSkillPanel.mitemList = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/itemGroup/itemList', 'GameObject')
    end
    return UIMainSkillPanel.mitemList
end

---攻击玩家箭头
function UIMainSkillPanel.PlayerArrow()
    if UIMainSkillPanel.mPlayerArrow == nil then
        UIMainSkillPanel.mPlayerArrow = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/PlayerArrow', 'GameObject')
    end
    return UIMainSkillPanel.mPlayerArrow
end

---攻击怪物箭头
function UIMainSkillPanel.MonsterArrow()
    if UIMainSkillPanel.mMonsterArrow == nil then
        UIMainSkillPanel.mMonsterArrow = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/MonsterArrow', 'GameObject')
    end
    return UIMainSkillPanel.mMonsterArrow
end

---攻击玩家箭头
function UIMainSkillPanel.PlayerArrowLight()
    if UIMainSkillPanel.mPlayerArrowLight == nil then
        UIMainSkillPanel.mPlayerArrowLight = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/PlayerArrow/lb', 'GameObject')
    end
    return UIMainSkillPanel.mPlayerArrowLight
end

---攻击怪物箭头
function UIMainSkillPanel.MonsterArrowLight()
    if UIMainSkillPanel.mMonsterArrowLight == nil then
        UIMainSkillPanel.mMonsterArrowLight = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/MonsterArrow/lb', 'GameObject')
    end
    return UIMainSkillPanel.mMonsterArrowLight
end

---攻击玩家按键
function UIMainSkillPanel.PlayerArrow1()
    if UIMainSkillPanel.mPlayerArrow1 == nil then
        UIMainSkillPanel.mPlayerArrow1 = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/PlayerArrow1', 'GameObject')
    end
    return UIMainSkillPanel.mPlayerArrow1
end

---攻击怪物按键
function UIMainSkillPanel.MonsterArrow1()
    if UIMainSkillPanel.mMonsterArrow1 == nil then
        UIMainSkillPanel.mMonsterArrow1 = UIMainSkillPanel:GetCurComp('WidgetRoot/view/skillTurntable/attack/MonsterArrow1', 'GameObject')
    end
    return UIMainSkillPanel.mMonsterArrow1
end

---@return UIFastItemUseViewTemplate
function UIMainSkillPanel:GetFastItemUseViewTemplate()
    if (UIMainSkillPanel.mFastItemUseViewTemplate == nil) then
        UIMainSkillPanel.mFastItemUseViewTemplate = templatemanager.GetNewTemplate(UIMainSkillPanel.ItemGroupPanel(), luaComponentTemplates.UIFastItemUseViewTemplate, UIMainSkillPanel);
    end
    return UIMainSkillPanel.mFastItemUseViewTemplate;
end

---xp技能按键
---@return UIMainSkillXPSkills
function UIMainSkillPanel:GetXPSkills()
    if self.mXPSkills == nil then
        local mXPSkillsGO = self:GetCurComp("WidgetRoot/view/skillTurntable/xpskills", "GameObject")
        if mXPSkillsGO then
            self.mXPSkills = templatemanager.GetNewTemplate(mXPSkillsGO, luaComponentTemplates.UIMainSkillXPSkills, self)
        end
    end
    return self.mXPSkills
end

---xp滑动条
---@return UIMainSkillXPSlider
function UIMainSkillPanel:GetXPSlider()
    if self.mXPSlider == nil then
        local mXPSlider = self:GetCurComp("WidgetRoot/view/skillTurntable/attack/XPslider", "GameObject")
        if mXPSlider then
            self.mXPSlider = templatemanager.GetNewTemplate(mXPSlider, luaComponentTemplates.UIMainSkillXPSlider, self)
        end
    end
    return self.mXPSlider
end

function UIMainSkillPanel:Init()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    UIMainSkillPanel.SetSkillScheme(nil, CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.AutoFightStateChange, UIMainSkillPanel.OnAutoFightStateChanged)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoPausedStateChanged, UIMainSkillPanel.OnAutoPauseStateChanged)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.AutoPathFindStateChanged, UIMainSkillPanel.OnPathFindStateChanged)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoMissionStateChanged, UIMainSkillPanel.OnAutoMissionStateChanged)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_NormalAttack, UIMainSkillPanel.OnAttack)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SkillSchemeChange, UIMainSkillPanel.SetSkillScheme)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.User_OnConfigChanged, UIMainSkillPanel.OnConfigChanged)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.DeathEvent, UIMainSkillPanel.ChangeSelectSkill)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_EnterSafeArea, UIMainSkillPanel.CloseSelectSkill)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SpecialSkillRefreshCD, UIMainSkillPanel.V2_SpecialSkillRefreshCD)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_UpdateSkillCool, UIMainSkillPanel.V2_UpdateSkillCool)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.Scene_EnterSceneAfter, function()
        self:GetXPSkills():GetXPSkill2Template():MapChangeRefreSh()
        self:GetXPSkills():GetXPSkill1Template():MapChangeRefreSh()
        UIMainSkillPanel.OnResEnterSceneAfter()
    end)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_QuickDrugThreshold, function(msgID, isShow, type)
        self:OnHpSmallUpdate(isShow, type)
    end)

    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        ---背包变化时,下一帧再刷新
        UIMainSkillPanel.mBagItemDirty = true
    end);
    --region 随机石特效刷新事件
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIMainSkillPanel.UpdateRandomStoneEffect);
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIMainSkillPanel.UpdateRandomStoneEffect);
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.FastUseItem_UpdateRandomStoneEffect, UIMainSkillPanel.UpdateRandomStoneEffect)
    --endregion
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_OpenFastUseItem, function(msgID, isShow)
        self.OpenItemGroup();
    end)

    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIMainSkillPanel.RefreshFastItemList)

    ---使用召唤令推送
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.Add_EquipGoodHint, function(msgID, data)
        self:OnZhaoHuanLingUpdate(data)
    end)
    ---使用召唤令推送(取消选中档位取消召唤令推送)
    UIMainSkillPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_SelectUnit, function(msgID, data)
        if CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target == nil then
            if self:GetFastItemUseViewTemplate() then
                self:GetFastItemUseViewTemplate():RefreshShowZhaoHuanLingEffect(false)
            end
        end
    end)

    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_AutoRelease, UIMainSkillPanel.RefreshSkill)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Skill_Refresh, UIMainSkillPanel.RefreshSkillPattern)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.SnapItemGridChange, UIMainSkillPanel.UpdateOtherFastItemList)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillMessage, UIMainSkillPanel.OnResSkillChangeMessage)
    -- commonNetMsgDeal.BindCallback(LuaEnumNetDef.ResBagChangeMessage, UIMainSkillPanel.OnResSkillChangeMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSkillBookUseMessage, UIMainSkillPanel.OnResSkillBookUseMessage)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UIMainSkillPanel.OnBagChanged)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOpenKeySettingPanelMessage, UIMainSkillPanel.OpenItemGroup)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUseItemMessage, UIMainSkillPanel.OnResUseItemMessage)

    CS.UIEventListener.Get(UIMainSkillPanel.Attack_GameObject()).onClick = function()
        luaEventManager.DoCallback(LuaCEvent.ActivityButtons_CloseButtons);
        UIMainSkillPanel.OnAttack();
    end
    CS.UIEventListener.Get(UIMainSkillPanel.Autofight()).onClick = UIMainSkillPanel.OnAutofight
    CS.UIEventListener.Get(UIMainSkillPanel.ItemGroupArrows().gameObject).onClick = UIMainSkillPanel.OnItemGroup

    CS.UIEventListener.Get(UIMainSkillPanel.PlayerArrow1().gameObject).onPress = UIMainSkillPanel.onPressPlayerArrow1
    CS.UIEventListener.Get(UIMainSkillPanel.MonsterArrow1().gameObject).onPress = UIMainSkillPanel.onPressMonsterArrow1

    CS.UIEventListener.Get(UIMainSkillPanel.Attack_GameObject()).onPress = UIMainSkillPanel.OnPress
    CS.UIEventListener.Get(UIMainSkillPanel.Attack_GameObject()).onDragStart = UIMainSkillPanel.OnDragStartSkill
    CS.UIEventListener.Get(UIMainSkillPanel.Attack_GameObject()).onDrag = UIMainSkillPanel.OnDragSkill
    CS.UIEventListener.Get(UIMainSkillPanel.Attack_GameObject()).onDragEnd = UIMainSkillPanel.OnDragEndSkill

    UIMainSkillPanel.SkillTable_TweenAni().onFinished:Add(CS.EventDelegate(UIMainSkillPanel.OnSkillTableTweenEnd))
    UIMainSkillPanel:SetSkillIcon()
    UIMainSkillPanel.RefreshSkill()
    UIMainSkillPanel.Autofight().gameObject:SetActive(true)
    UIMainSkillPanel.mItemGroupOriginPos = UIMainSkillPanel.ItemGroup().transform.localPosition;
    UIMainSkillPanel:InitItemGroup()

    CS.CSScene.MainPlayerInfo.SkillInfoV2:InitSkillRed()

    UIMainSkillPanel.InitSnapItemGridTemplate()
    self:GetXPSkills():Initialize()
    self:GetXPSlider():Initialize()
end

function UIMainSkillPanel:SetSkillIcon()
    local career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    UIMainSkillPanel.skillIcon_Top_UISprite().spriteName = 'jobkill' .. career;
end

function UIMainSkillPanel:Show()
    UIMainSkillPanel.UpdateFastItemList();
end

function update()
    if UIMainSkillPanel.mBagItemDirty then
        UIMainSkillPanel.mBagItemDirty = false
        if UIMainSkillPanel:GetFastItemUseViewTemplate() ~= nil then
            UIMainSkillPanel:GetFastItemUseViewTemplate():OnResBagItemChange();
        end
    end
    UIMainSkillPanel.RefreshCD()
    if UIMainSkillPanel.mIsGoingToUpdateFastItemList then
        UIMainSkillPanel.mIsGoingToUpdateFastItemList = false
        UIMainSkillPanel.UpdateFastItemList()
    end
    UIMainSkillPanel:GetXPSlider():OnUpdate()
end

---打开/关闭 道具组
function UIMainSkillPanel.OnItemGroup()
    if UIMainSkillPanel.IsOpenItemGroup == false then
        UIMainSkillPanel.OpenItemGroup()
    else
        UIMainSkillPanel.CloseItemGroup()
    end
end

function UIMainSkillPanel:InitItemGroup()
    local itemGroupIsOpen = CS.CSScene.MainPlayerInfo.ConfigInfo:GetBool(CS.EConfigOption.FastItemUseExpand)
    UIMainSkillPanel.IsOpenItemGroup = not itemGroupIsOpen
    self.OnItemGroup()
end

function UIMainSkillPanel.GetItemGroupOriginPos()
    if (UIMainSkillPanel.mItemGroupOriginPos ~= nil) then
        return UIMainSkillPanel.mItemGroupOriginPos;
    end
    return CS.UnityEngine.Vector3(16, 389, 0);
end

function UIMainSkillPanel.OpenItemGroup()
    if (not UIMainSkillPanel.IsOpenItemGroup) then
        UIMainSkillPanel.PlayOpenItemGroupTween();
        UIMainSkillPanel.IsOpenItemGroup = true
        CS.CSScene.MainPlayerInfo.ConfigInfo:SetBool(CS.EConfigOption.FastItemUseExpand, UIMainSkillPanel.IsOpenItemGroup)
        networkRequest.ReqSaveRoleSettings(CS.CSScene.MainPlayerInfo.ConfigInfo:GetRoleSettingList())
    end
end

function UIMainSkillPanel.PlayOpenItemGroupTween()
    UIMainSkillPanel:UpdateIsFollowFastItem(true);
    UIMainSkillPanel.ItemGroup():SetOnFinished(UIMainSkillPanel.ClinkFoldBtnCallBack);
    local curPos = UIMainSkillPanel.ItemGroup().transform.localPosition;
    local width = 70;
    local otherGridContainer = UIMainSkillPanel.GetSnapItemViewTemplate().itemList;
    --local otherCount = otherGridContainer == nil and 0 or otherGridContainer.MaxCount;
    --local count = UIMainSkillPanel:GetFastItemUseViewTemplate():GetShowItemCount() + otherCount;
    local count = UIMainSkillPanel:GetFastItemUseViewTemplate():GetShowItemCount()
    local x = UIMainSkillPanel.GetItemGroupOriginPos().x - (width * count + 30);
    UIMainSkillPanel.ItemGroup().from = curPos;
    UIMainSkillPanel.ItemGroup().to = CS.UnityEngine.Vector3(x, curPos.y, curPos.z);
    UIMainSkillPanel.ItemGroup():PlayTween()
    UIMainSkillPanel.ItemGroup_TweenAlpha():PlayForward()
end

function UIMainSkillPanel.CloseItemGroup(callBack)
    if (UIMainSkillPanel.IsOpenItemGroup) then
        UIMainSkillPanel.PlayCloseItemGroupTween(callBack);
        UIMainSkillPanel.IsOpenItemGroup = false
        CS.CSScene.MainPlayerInfo.ConfigInfo:SetBool(CS.EConfigOption.FastItemUseExpand, UIMainSkillPanel.IsOpenItemGroup)
        networkRequest.ReqSaveRoleSettings(CS.CSScene.MainPlayerInfo.ConfigInfo:GetRoleSettingList())
    end
end

function UIMainSkillPanel.PlayCloseItemGroupTween()
    local curPos = UIMainSkillPanel.ItemGroup().transform.localPosition;
    UIMainSkillPanel.SnapItemGridTemplate():SetActive(false);
    UIMainSkillPanel.ItemGroup():SetOnFinished(UIMainSkillPanel.ClinkFoldBtnCallBack);
    UIMainSkillPanel.ItemGroup().from = curPos;
    UIMainSkillPanel.ItemGroup().to = UIMainSkillPanel.GetItemGroupOriginPos();
    UIMainSkillPanel.ItemGroup():PlayTween()
    UIMainSkillPanel.ItemGroup_TweenAlpha():PlayReverse()
end

function UIMainSkillPanel.OnConfigChanged(msgId, msgData)
    if (msgData == Utility.EnumToInt(CS.EConfigOption.ShowItemShortcut) or
            msgData == Utility.EnumToInt(CS.EConfigOption.ShortcutItem1) or
            msgData == Utility.EnumToInt(CS.EConfigOption.ShortcutItem2) or
            msgData == Utility.EnumToInt(CS.EConfigOption.ShortcutItem3)) or
            msgData == Utility.EnumToInt(CS.EConfigOption.ShortcutItem4)
    then
        UIMainSkillPanel.mIsGoingToUpdateFastItemList = true
    end
end

function UIMainSkillPanel.OnBagChanged()
    UIMainSkillPanel.mIsGoingToUpdateFastItemList = true
    UIMainSkillPanel.UpdateFastItemList();
end

function UIMainSkillPanel.RefreshFastItemList()
    UIMainSkillPanel.mIsGoingToUpdateFastItemList = true
    --UIMainSkillPanel.UpdateFastItemList();
end

function UIMainSkillPanel.UpdateFastItemList()
    UIMainSkillPanel:GetFastItemUseViewTemplate():ShowView();
    if (UIMainSkillPanel.ItemGroupPanel().activeSelf and UIMainSkillPanel.IsOpenItemGroup) then
        UIMainSkillPanel.PlayOpenItemGroupTween();
    end
    for i, v in pairs(UIMainSkillPanel.ShotcutConfigList) do
        if v then
            v:RefreshItem()
        end
    end

    UIMainSkillPanel.UpdateOtherFastItemList();
end

function UIMainSkillPanel.UpdateOtherFastItemList()
    UIMainSkillPanel:UpdateIsFollowFastItem(UIMainSkillPanel.ItemGroupPanel().activeSelf and UIMainSkillPanel.IsOpenItemGroup);
end

function UIMainSkillPanel:UpdateIsFollowFastItem(isFollow)
    if (isFollow) then
        UIMainSkillPanel.SnapItemGridTemplate().transform.parent = UIMainSkillPanel:GetFastItemUseViewTemplate():GetUnitGridContainer().transform;
        local count = UIMainSkillPanel:GetFastItemUseViewTemplate():GetShowItemCount();
        local width = UIMainSkillPanel:GetFastItemUseViewTemplate():GetUnitGridContainer().CellWidth;
        local x = (count) * width;
        UIMainSkillPanel.SnapItemGridTemplate().transform.localPosition = CS.UnityEngine.Vector3(-width, 0, 0);
    else
        UIMainSkillPanel.SnapItemGridTemplate().transform.parent = UIMainSkillPanel.ItemGroupPanel().transform.parent;
        UIMainSkillPanel.SnapItemGridTemplate().transform.localPosition = CS.UnityEngine.Vector3(-69, 419, 0);
    end
    UIMainSkillPanel.SnapItemGridTemplate().gameObject:SetActive(false);
    UIMainSkillPanel.SnapItemGridTemplate().gameObject:SetActive(true);
end

---缩进按钮回调
function UIMainSkillPanel.ClinkFoldBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if UIMainSkillPanel.IsOpenItemGroup == false then
        v3.z = 180
    end
    UIMainSkillPanel.ItemGroupBackground().transform.localEulerAngles = v3

    UIMainSkillPanel:UpdateIsFollowFastItem(UIMainSkillPanel.IsOpenItemGroup);
end

---显示技能
function UIMainSkillPanel.ShowSkillTable()
    UIMainSkillPanel.mIsOpen = true
    UIMainSkillPanel.go:SetActive(true)
    UIMainSkillPanel.SkillTable_TweenAni():Play(true)
end

---隐藏技能表
function UIMainSkillPanel.HideSkillTable()
    UIMainSkillPanel.mIsOpen = false
    UIMainSkillPanel.SkillTable_TweenAni():Play(false)
end

---播放技能显示隐藏回调
function UIMainSkillPanel.OnSkillTableTweenEnd()
    if UIMainSkillPanel.mIsOpen == false then
        UIMainSkillPanel.go:SetActive(false)
    end
end

--- 设置技能快捷栏
function UIMainSkillPanel.SetSkillScheme(id, data)
    local position, scale = CS.Cfg_GlobalTableManager.Instance:ShortcutKeyPosition(data);
    UIMainSkillPanel.skillsList1().gameObject:SetActive(data == 0);
    UIMainSkillPanel.skillsList2().gameObject:SetActive(data == 1);
    UIMainSkillPanel.skillPosState = data
    UIMainSkillPanel.ShotcutConfigList = nil
    UIMainSkillPanel.ShotcutConfigList = {}
    UIMainSkillPanel.RefreshSkill()
    networkRequest.ReqSaveRoleSettings(CS.CSScene.MainPlayerInfo.ConfigInfo:GetRoleSettingList())
    UIMainSkillPanel:GetXPSkills():SetCurrentSkillPosType(data)
end

function UIMainSkillPanel.RefreshSkillPattern()
    UIMainSkillPanel.SetSkillScheme(nil, CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme)
    UIMainSkillPanel.RefreshSkill()
end

---刷新技能
function UIMainSkillPanel.RefreshSkill(isNeedInitSkillCool)
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local SkillScheme = nil

    local scheme = CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme
    if scheme == 0 then
        SkillScheme = UIMainSkillPanel.skillsList1().gameObject
    else
        SkillScheme = UIMainSkillPanel.skillsList2().gameObject
    end
    local count = SkillScheme.transform.childCount
    for i = 0, count - 1 do
        local templates
        if UIMainSkillPanel.ShotcutConfigList[i] == nil then
            local item = SkillScheme.transform:GetChild(i).gameObject
            templates = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIShotcutConfigTemplate)
            UIMainSkillPanel.ShotcutConfigList[i] = templates
        else
            templates = UIMainSkillPanel.ShotcutConfigList[i]
        end
        templates:Refresh(UIMainSkillPanel.GetVaue(i), UIMainSkillPanel, i)
    end
    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.SkillScheme, CS.CSScene.MainPlayerInfo.SkillInfoV2.NowSkillScheme);
    if isNeedInitSkillCool == nil or isNeedInitSkillCool == true then
        UIMainSkillPanel.InitSkillCool()
    end

end

function UIMainSkillPanel.OnResSkillBookUseMessage(id, csData)
    if csData.level == 1 and csData.exp == 0 then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:SetSkillOptionsDic(csData.skillId, true);
        local list = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillOptionsList()
        networkRequest.ReqSaveRoleSkillSettings(list)
        UIMainSkillPanel:AutoSetSkill(csData.skillId)
        for i, v in pairs(UIMainSkillPanel.ShotcutConfigList) do
            if v ~= nil then
                v:RefreshIntensifySkillIcon()
            end
        end
        UIMainSkillPanel.RefreshSkill(false)
    end

end

---自动添加技能
function UIMainSkillPanel:AutoSetSkill(skillID)
    local skillKey = CS.Cfg_SkillTableManager.Instance:GetSkillKeyInfo(skillID)
    local nowSelectIndex = -1
    if skillKey ~= nil and skillKey.Count == 3 then
        local oldID = 0
        if skillKey[0] ~= nil and UIMainSkillPanel.ShotcutConfigList[skillKey[0] - 1] ~= nil then
            oldID = UIMainSkillPanel.ShotcutConfigList[skillKey[0] - 1]:ID()
        end
        local oldKey = CS.Cfg_SkillTableManager.Instance:GetSkillKeyInfo(oldID)
        local isfindItem, data = CS.Cfg_ItemsTableManager.Instance:TryGetValue(oldID)
        nowSelectIndex = self:GetIndex(skillKey, oldID, oldKey, isfindItem)
        if nowSelectIndex == -1 then
            return
        end
        if UIMainSkillPanel.ShotcutConfigList[nowSelectIndex] ~= nil then
            oldID = UIMainSkillPanel.ShotcutConfigList[nowSelectIndex]:ID()
        end
        CS.CSScene.MainPlayerInfo.ShortcutInfo:SetShortcut(0, nowSelectIndex, 0, skillID);
        CS.CSScene.MainPlayerInfo.ShortcutInfo:SetShortcut(1, nowSelectIndex, 0, skillID);
        local list = CS.CSScene.MainPlayerInfo.ShortcutInfo:GetShortcutData()
        networkRequest.ReqSetSkillShortcut(list)
        UIMainSkillPanel.RefreshSkill()
        if self.ShotcutConfigList[nowSelectIndex] ~= nil and self.ShotcutConfigList[nowSelectIndex].go.gameObject.activeInHierarchy == true then
            self.ShotcutConfigList[nowSelectIndex]:SetOldlIcon(oldID)
            self.ShotcutConfigList[nowSelectIndex]:SetStartAnimationPoint()
        end

    end
end

function UIMainSkillPanel:GetIndex(skillKey, oldID, oldKey, isfindItem)

    if oldKey == nil and isfindItem == false then
        return skillKey[0] - 1
    end
    if oldKey ~= nil and oldKey.Count == 3 then
        --强制类型
        if skillKey[1] == 1 then
            if skillKey[2] > oldKey[2] then
                return skillKey[0] - 1
            end
        end
    end
    if self.ShotcutConfigList[0] ~= nil then
        if self.ShotcutConfigList[0].id == 0 then
            return 0
        end
    end
    for k, v in pairs(self.ShotcutConfigList) do
        if v.id == 0 then
            return k
        end
    end
    return -1
end

---得到技能快捷按键
function UIMainSkillPanel.GetVaue(Key)
    local skillShortcut = CS.CSScene.MainPlayerInfo.ShortcutInfo:GetShortcut(Key)
    if (skillShortcut ~= nil) then
        return skillShortcut:GetSubShort(0)--得到技能按键下的第一个技能(当前版本,一个按键只有一个技能)
    end

    return 0
end

---关闭对点技能状态
function UIMainSkillPanel:CloseUnlockedDotSkill(shotcutConfig)
    for i = 0, #self.ShotcutConfigList - 1 do
        if shotcutConfig ~= self.ShotcutConfigList[i] then
            --  self.ShotcutConfigList[i]:Highlight():SetActive(false);
        end
    end
end

---自动战斗状态切换
function UIMainSkillPanel.OnAutoFightStateChanged(id, data)
    UIMainSkillPanel:RefreshAutofightEffects()
end

---自动暂停状态切换
function UIMainSkillPanel.OnAutoPauseStateChanged(id, data)
    UIMainSkillPanel:RefreshAutofightEffects()
end

---自动寻路状态切换
function UIMainSkillPanel.OnPathFindStateChanged(id, data)
    UIMainSkillPanel:RefreshAutofightEffects()
end

---自动任务状态切换
function UIMainSkillPanel.OnAutoMissionStateChanged(id, data)
    UIMainSkillPanel:RefreshAutofightEffects()
end

---刷新技能消息
function UIMainSkillPanel.OnResSkillChangeMessage()
    UIMainSkillPanel.RefreshSkill()
end

function UIMainSkillPanel.OnResEnterSceneAfter()
    UIMainSkillPanel.RefreshSkill()
    UIMainSkillPanel.RefreshFastItemList()
end


--region 攻击按钮事件
---普通攻击点击事件
function UIMainSkillPanel.OnAttack()
    if CS.CSScene.MainPlayerInfo:SlipStateTip() then
        return
    end
    if LuaGlobalTableDeal.IsAnyAntiSkillReleaseBuffExistInMainPlayer() then
        --print("玩家身上有禁止施法的buff存在")
        ---玩家身上有禁止施法的buff存在
        return
    end
    local avatar = CS.CSScene.Sington:getCurAttackAvatar();
    if avatar == nil then
        local skillTarget = CS.CSScene.Sington:getShortDistanceTarget(0, 0, 10000, true, true, -2);
        if skillTarget == nil then
            CS.Utility.ShowTips("[ffe7be]周围没有可以攻击的目标，无法施放[-]", 1.5, CS.ColorType.White);
            return
        else
            CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
            CS.CSAutoFightMgr.Instance:Toggle(false);
            --需要忽略下次普攻攻击目标的目标筛选
            CS.CSAutoFightMgr.Instance.AutoKeepAttack.IsNeedIgnoreLimitOfAttackForCommonAttack = true
        end
    else
        --屏蔽不可攻击怪
        if avatar.AvatarType == CS.EAvatarType.Monster and not avatar.isCanBeAttack then
            return
        end
        CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
        CS.CSAutoFightMgr.Instance:Toggle(false);
    end
    CS.CSScene.Sington.GatherController:StopGather();
    CS.CSAutoFight.IsOnClickButtonAttack = true;
    CS.CSScene.Sington.MainPlayer.SkillEngine:ResetData();
    CS.CSScene.Sington.MainPlayer.SkillEngine.SkillReleaseType = CS.ESkillReleaseMethodType.ClickCommonButton;
    CS.CSAutoFightMgr.Instance.IsSpecialSkillCanRelease = false;

    Utility.ShowChangAttackPatternTip(avatar)
    UIMainSkillPanel.CloseSelectSkill()

end

-- function UIMainSkillPanel.ShowChangAttackPatternTip(avater)
--     if avater == nil then
--         return
--     end
--     local targetIsPlayer=avater.AvatarType==CS.EAvatarType.Player
--     local isPeace=CS.CSScene.MainPlayerInfo.PKMode==Utility.EnumToInt(CS.PkMode.Peace)
--     local isCanHurtMe=CS.CSScene.MainPlayerInfo:IsCanHurtMe(avater)
--    -- print(targetIsPlayer,isPeace,CS.CSScene.MainPlayerInfo.PKMode,isCanHurtMe)
--     local number= CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.AttackPatternTipNumner)
--     if not isCanHurtMe and targetIsPlayer and isPeace and number<3 then
--      local  CancelInfo = {
--             Content = "和平模式无法攻击目标，是否切换模式",
--             CallBack = function()
--                 number=number+1
--                 CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.AttackPatternTipNumner,number)
--                 uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Equip_Atr)
--                 uimanager:ClosePanel('UIPromptPanel')
--             end,
--         }
--         uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
--     end

-- end

function UIMainSkillPanel:OnPress(IsDown)
    UIMainSkillPanel.PlayerArrow():SetActive(IsDown);
    UIMainSkillPanel.MonsterArrow():SetActive(IsDown);
    UIMainSkillPanel.PlayerArrowLight():SetActive(false);
    UIMainSkillPanel.MonsterArrowLight():SetActive(false);
end

function UIMainSkillPanel.OnDragStartSkill(go)
    if go ~= UIMainSkillPanel.Attack_GameObject() then
        return
    end
    UIMainSkillPanel.DragPoint = CS.UnityEngine.Input.mousePosition.y;
end

UIMainSkillPanel.IsSelectAvaterType = 0;
function UIMainSkillPanel.OnDragSkill(go, delta)
    if go ~= UIMainSkillPanel.Attack_GameObject() then
        return
    end
    local touchPos = CS.UICamera.currentTouch.pos
    local touchWorldPos = CS.UICamera.currentCamera:ScreenToWorldPoint(CS.UnityEngine.Vector3(touchPos.x, touchPos.y, 0))
    local attackGOWorldPos = UIMainSkillPanel.Attack_GameObject().transform.position
    local dis = touchWorldPos - attackGOWorldPos
    if dis.x + dis.y > 0 then
        UIMainSkillPanel.IsSelectAvaterType = 1
        UIMainSkillPanel.PlayerArrow():SetActive(true);
        UIMainSkillPanel.MonsterArrow():SetActive(false);
    else
        UIMainSkillPanel.IsSelectAvaterType = 2
        UIMainSkillPanel.PlayerArrow():SetActive(false);
        UIMainSkillPanel.MonsterArrow():SetActive(true);
    end
end

function UIMainSkillPanel.OnDragEndSkill(go)
    if go ~= UIMainSkillPanel.Attack_GameObject() then
        return
    end
    --UIMainSkillPanel.PlayerArrow():SetActive(false);
    --UIMainSkillPanel.MonsterArrow():SetActive(false);
    if (UIMainSkillPanel.IsSelectAvaterType == 1) then
        CS.CSScene.Sington:SwitchSelectTarget(CS.EAvatarType.Player, 8);
        UIMainSkillPanel.SetAttactTip()
    elseif UIMainSkillPanel.IsSelectAvaterType == 2 then
        CS.CSScene.Sington:SwitchSelectTarget(CS.EAvatarType.Monster, 8);
    end

    UIMainSkillPanel.IsSelectAvaterType = 0;
end

---按下攻击玩家
function UIMainSkillPanel.onPressPlayerArrow1(go, IsDown)
    if IsDown then
        UIMainSkillPanel.PlayerArrow():SetActive(true);
        UIMainSkillPanel.MonsterArrow():SetActive(false);
        UIMainSkillPanel.PlayerArrowLight():SetActive(true);
        UIMainSkillPanel.MonsterArrowLight():SetActive(false);
    else
        CS.CSScene.Sington.GatherController:StopGather();
        CS.CSScene.Sington:SwitchSelectTarget(CS.EAvatarType.Player, 8);
        UIMainSkillPanel.SetAttactTip()
        UIMainSkillPanel.PlayerArrow():SetActive(false);
        UIMainSkillPanel.MonsterArrow():SetActive(false);
        UIMainSkillPanel.PlayerArrowLight():SetActive(false);
        UIMainSkillPanel.MonsterArrowLight():SetActive(false);
    end
end

------按下攻击怪物
function UIMainSkillPanel.onPressMonsterArrow1(go, IsDown)
    if IsDown then
        UIMainSkillPanel.PlayerArrow():SetActive(false);
        UIMainSkillPanel.MonsterArrow():SetActive(true);
        UIMainSkillPanel.PlayerArrowLight():SetActive(false);
        UIMainSkillPanel.MonsterArrowLight():SetActive(true);
    else
        CS.CSScene.Sington.GatherController:StopGather();
        CS.CSScene.Sington:SwitchSelectTarget(CS.EAvatarType.Monster, 8);
        UIMainSkillPanel.PlayerArrow():SetActive(false);
        UIMainSkillPanel.MonsterArrow():SetActive(false);
        UIMainSkillPanel.PlayerArrowLight():SetActive(false);
        UIMainSkillPanel.MonsterArrowLight():SetActive(false);
    end

end

---设置攻击提示
function UIMainSkillPanel.SetAttactTip()
    local AvaterListDic = CS.CSScene.Sington.AvaterListDic
    local IsFind = true
    local res, playerInfo = AvaterListDic:TryGetValue(CS.AvatarType.Player)
    if res then
        IsFind = playerInfo.Count > 0
    else
        IsFind = false
    end

    if IsFind == false then
        if CS.CSScene.MainPlayerInfo.PKMode == 0 then
            --  CS.Utility.ShowTips("和平模式不能攻击玩家", 1.5, CS.ColorType.Red);
        end
    end

end
--endregion
---自动战斗按钮点击事件
function UIMainSkillPanel.OnAutofight()
    if LuaGlobalTableDeal.IsAnyAntiSkillReleaseBuffExistInMainPlayer() then
        --print("玩家身上有禁止施法的buff存在")
        ---玩家身上有禁止施法的buff存在
        return
    end
    ---自动战斗按钮点击时,应当退出异步操作的流程
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop();
    end
    ---自动战斗按钮点击时,应当退出采集状态
    if CS.CSScene.Sington ~= nil then
        CS.CSScene.Sington.GatherController:StopGather()
    end
    ---自动暂停状态下,退出自动暂停状态,关闭自动战斗,停下玩家
    if CS.CSAutoPauseMgr.Instance.IsAtAutoState then
        if not CS.CSMissionManager.Instance:IsOnCurTaskMap() then
            ---清空当前任务
            CS.CSMissionManager.Instance:ClearCurrentTask()
        end
        --清除并关闭目标选择系统
        CS.CSTargetGetWayManager.Instanece:Clear()
        ---关闭寻路
        CS.CSPathFinderManager.Instance:ClearDestination()
        ---退出自动暂停
        CS.CSAutoPauseMgr.Instance:ExitPauseState(false)
        ---关闭自动战斗
        CS.CSAutoFightMgr.Instance:Toggle(false)
        ---玩家停住
        if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
            CS.CSScene.Sington.MainPlayer:Stop()
        end
    else
        if not CS.CSMissionManager.Instance:IsOnCurTaskMap() then
            ---清空当前任务
            CS.CSMissionManager.Instance:ClearCurrentTask()
        end
        --清除并关闭目标选择系统
        CS.CSTargetGetWayManager.Instanece:Clear()
        ---关闭寻路
        CS.CSPathFinderManager.Instance:ClearDestination()
        ---关闭自动战斗
        CS.CSAutoFightMgr.Instance:Toggle()
        ---正常关闭自动战斗时,玩家停下
        if CS.CSAutoFightMgr.Instance.IsOn == false then
            if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
                CS.CSScene.Sington.MainPlayer:Stop()
            end
        end
    end
end

function UIMainSkillPanel.RefreshCD()
    if CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil then
        return
    end
    for k, item in pairs(UIMainSkillPanel.ShotcutConfigList) do
        if item:ID() ~= 0 then
            if item ~= nil then
                item:RefeshSkillCD()
            end
        end
    end
end

---初始化技能cd
function UIMainSkillPanel.InitSkillCool()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local CDInfo = CS.CSScene.MainPlayerInfo.CDInfo;
    if CDInfo == nil then
        return
    end
    for k, item in pairs(UIMainSkillPanel.ShotcutConfigList) do
        if item:ID() ~= 0 and item:ID() ~= nil then
            local surplusCD = CDInfo:SurplusCD(item:ID(), CS.ECDType.SKILL)
            if surplusCD ~= nil then
                item.SurplusSkillCD = surplusCD
            end

        end
    end
end

---更新技能冷却
function UIMainSkillPanel.V2_UpdateSkillCool(id, skillID, cd)
    local IsSpecialSkill = CS.Cfg_GlobalTableManager.Instance:IsSpecialCDSkill(skillID)
    if IsSpecialSkill == false then
        UIMainSkillPanel.SetSurplusSkillCD(skillID, cd)
    end
end

---移除Buff类刷新技能CD
function UIMainSkillPanel.V2_SpecialSkillRefreshCD(id, data)
    if data == nil then
        return
    end
    if CS.CSScene.Sington.MainPlayer.ID ~= data.roleId then
        return
    end
    if data.bufferConfigId == nil then
        return
    end
    if CS.CSServerTime.Instance.TotalMillisecond < data.addTime + data.totalTime then
        local skillID = CS.Cfg_GlobalTableManager.Instance:GetSpecialCDSkillID(data.bufferConfigId)
        if skillID ~= 0 then
            UIMainSkillPanel.SetSurplusSkillCD(skillID)
        end
    end
end

---使用道具返回信息
function UIMainSkillPanel.OnResUseItemMessage(id, data)
    if data ~= nil then

        UIMainSkillPanel.SetSurplusSkillCD(data.itemId)
    end


end

function UIMainSkillPanel.SetSurplusSkillCD(SkillID, cd)
    for k, item in pairs(UIMainSkillPanel.ShotcutConfigList) do
        if item:ID() ~= 0 and item:ID() == SkillID then
            if cd == nil then
                if item.ItemCD == nil then
                    item.SkillCD = item.SkillCD
                    item.SurplusSkillCD = item.SkillCD
                else
                    item.SkillCD = item.ItemCD
                    item.SurplusSkillCD = item.ItemCD
                end
            else
                item.SkillCD = cd
                item.SurplusSkillCD = cd
            end
        end
    end
end

---关闭当前选中的技能
function UIMainSkillPanel:ChangeSelectSkill()
    if CS.CSScene.MainPlayerInfo.HP <= 0 then
        UIMainSkillPanel:CloseSelectSkill()
    end
end

function UIMainSkillPanel:CloseSelectSkill()
    if CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill ~= nil then
        CS.CSScene.Sington.MainPlayer.BaseInfo.SkillInfo.UnlockedDotSkill = nil;
        for k, v in pairs(UIMainSkillPanel.ShotcutConfigList) do
            v:SetAutofightEffects(false)
        end
    end
end

---刷新自动战斗特效
function UIMainSkillPanel:RefreshAutofightEffects()
    local isOn = false
    if CS.CSAutoPauseMgr.Instance ~= nil and CS.StaticUtility.IsNull(CS.CSAutoPauseMgr.Instance) == false then
        isOn = CS.CSAutoPauseMgr.Instance.IsAtAutoState
    end
    if UIMainSkillPanel.autofightEffects == nil then
        UIMainSkillPanel.autofightEffects = UIMainSkillPanel:GetCurComp("WidgetRoot/autofight/animation", "GameObject")
    end
    if CS.StaticUtility.IsNull(UIMainSkillPanel.autofightEffects) == false then
        UIMainSkillPanel.autofightEffects:SetActive(isOn)
    end
    if CS.StaticUtility.IsNull(UIMainSkillPanel:GetAutoFightIcon_GO()) == false then
        UIMainSkillPanel:GetAutoFightIcon_GO():SetActive(isOn == false)
    end
end

---使用道具
---@param id number 需要使用的物品ID
function UIMainSkillPanel:UseItem(id)
    local item = self:GetBagProp(id)
    if item ~= nil then
        --region 玩家战斗状态
        local monsterid = 0
        if (CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult ~= nil and CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList ~= nil) then
            local list = CS.CSScene.Sington.MainPlayer.SkillResult.LastAttackHurtList
            for i = 0, list.Count - 1 do
                local monster = CS.CSScene.Sington:getAvatar(list[i].targetId)
                if (monster ~= nil and monster.isDead == false and monster.AvatarType == CS.EAvatarType.Monster) then
                    if (Utility.IsContainsValue(LuaGlobalTableDeal.ZhaoHuanLingShowNameBossTypeTable(), monster.MonsterTable.type)) then
                        monsterid = monster.MonsterTable.id
                        break
                    end
                end
            end
        end

        local lid = item.lid
        --endregion

        if item.ItemTABLE ~= nil and item.ItemTABLE.type == luaEnumItemType.Assist and item.ItemTABLE.subType == 19 then
            networkRequest.ReqUseItem(1, item.lid, 0)
            return true
            --end
        elseif item.ItemTABLE ~= nil and item.ItemTABLE.type == luaEnumItemType.Assist and item.ItemTABLE.subType == 16 then
            ---间谍牌
            Utility.TryUseSpyItemfunc(nil, item.lid)
            return
        elseif item.ItemTABLE ~= nil and item.ItemTABLE.type == luaEnumItemType.Assist and item.ItemTABLE.subType == 6 then
            ---玩家在60级之前，在所有地图，主角当前不在战斗状态需二次确认
            if CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and CS.CSScene.MainPlayerInfo.InCombat == false then
                Utility.ShowSecondConfirmPanel({ PromptWordId = 111, CancelCallBack = function()
                    networkRequest.ReqUseItem(1, lid, monsterid, { Utility.EnumToInt(CS.EServerMapObjectType.Null) })
                end })
                return
            end

            --if (CS.CSScene.MainPlayerInfo.Level < LuaGlobalTableDeal.ZhaoHuanLingSecondConfirmLevel() and Utility.IsContainsValue(LuaGlobalTableDeal.ZhaoHuanLingDontNeedSecondConfirmMapTable(), CS.CSScene.getMapID()) == false) then
            --    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(111)
            --    if isFind then
            --        local temp = {}
            --        temp.Content = info.des
            --        temp.LeftDescription = info.leftButton
            --        temp.RightDescription = info.rightButton
            --        temp.ID = 111
            --        temp.CancelCallBack = function()
            --            networkRequest.ReqUseItem(1, lid, monsterid)
            --        end
            --        temp.CallBack = function()
            --        end
            --        uimanager:CreatePanel("UIPromptPanel", nil, temp)
            --        uimanager:ClosePanel("UIItemInfoPanel")
            --        uimanager:ClosePanel("UIPetInfoPanel")
            --        return
            --    end
            --end
            networkRequest.ReqUseItem(1, lid, monsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        elseif item.ItemTABLE.type == luaEnumItemType.Assist and item.ItemTABLE.subType == 30 then
            ---联盟召唤令
            networkRequest.ReqUseItem(1, lid, monsterid, { Utility.EnumToInt(CS.CSScene.MainPlayerInfo.LastCombatObjectType) })
        else
            networkRequest.ReqUseItem(1, item.lid, 1)
            return true
        end
    else
        local PropItem = CS.Cfg_ItemsTableManager.Instance:GetItems(id)
        if PropItem ~= nil then
            local tip = "背包中" .. PropItem.name .. "道具数量不足"
            CS.Utility.ShowTips(tip, 1.5, CS.ColorType.Red);
        end
        return false
    end
end

---获取背包中id对应及关联的物品
---@return bagV2.BagItemInfo
function UIMainSkillPanel:GetBagProp(id)
    local item = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfo(id)
    if item == nil then
        local currentID = id
        --最大允许递归20次,防止死循环
        for i = 1, 20 do
            if item ~= nil then
                break
            end
            local nextID = CS.Cfg_GlobalTableManager.Instance:GetNextProp(currentID)
            if nextID == 0 then
                break
            end
            item = CS.CSScene.MainPlayerInfo.BagInfo:GetBagItemInfo(nextID)
            currentID = nextID
        end
    end
    return item
end

---玩家血量变化
function UIMainSkillPanel:OnHpSmallUpdate(isShow, type)
    if self:GetFastItemUseViewTemplate() and self:GetFastItemUseViewTemplate().RefreshEffectShowByBlood then
        self:GetFastItemUseViewTemplate():RefreshEffectShowByBlood(isShow, type)
        local showItemList = UIMainSkillPanel.GetFastUseItemList();
        local hasDrug = false;
        for k, v in pairs(showItemList) do
            if v ~= 0 then
                local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(v);
                if (isFind) then
                    if (itemTable.type == luaEnumItemType.Drug) then
                        hasDrug = true;
                        break ;
                    end
                end
            end
        end
        if UIMainSkillPanel.IsOpenItemGroup == false and isShow and UIMainSkillPanel.GetShowItemListCount() > 0 and hasDrug then
            UIMainSkillPanel.OnItemGroup()
        end
    end
end

function UIMainSkillPanel.GetShowItemListCount()
    local count = 0
    for k, v in pairs(UIMainSkillPanel.FastUseItemList) do
        if v ~= 0 then
            count = count + 1
        end
    end
    return count
end

---玩家召唤令状态发生变化
function UIMainSkillPanel:OnZhaoHuanLingUpdate(data)
    if data == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        if self:GetFastItemUseViewTemplate() then
            self:GetFastItemUseViewTemplate():RefreshShowZhaoHuanLingEffect(true)
        end
    end
end

---更新随机石特效
function UIMainSkillPanel.UpdateRandomStoneEffect()
    local hasMonsterHead = false;
    local monsterHeadPanel = uimanager:GetPanel("UIMonsterHeadPanel");
    if (monsterHeadPanel ~= nil and
            monsterHeadPanel.go ~= nil and
            not CS.StaticUtility.IsNull(monsterHeadPanel.go)) then

        hasMonsterHead = true;
    end

    local hasMonsterWarning = false;
    local mapDirectionPanel = uimanager:GetPanel("UIMapDirectionPanel");
    if (mapDirectionPanel ~= nil and
            mapDirectionPanel.go ~= nil and
            not CS.StaticUtility.IsNull(mapDirectionPanel.go) and
            mapDirectionPanel.go.activeSelf and
            mapDirectionPanel:GetEnemyWarning() ~= nil and
            not CS.StaticUtility.IsNull(mapDirectionPanel:GetEnemyWarning()) and
            mapDirectionPanel:GetEnemyWarning().avatarTargetID ~= 0) then

        hasMonsterWarning = true;
    end

    local isMatchCondition = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(CS.Cfg_GlobalTableManager.Instance.RandomStoneEffectNeedConditions);
    local isInMap = false;
    if (CS.Cfg_GlobalTableManager.Instance.RandomStoneEffectNeedMaps ~= nil and CS.CSScene.MainPlayerInfo ~= nil) then
        isInMap = CS.CSScene.MainPlayerInfo:IsInMap(CS.Cfg_GlobalTableManager.Instance.RandomStoneEffectNeedMaps);
    end

    if (not hasMonsterHead and not hasMonsterWarning and isMatchCondition and isInMap) then
        UIMainSkillPanel:GetFastItemUseViewTemplate():RefreshRandomStoneEffect(true);
    else
        UIMainSkillPanel:GetFastItemUseViewTemplate():RefreshRandomStoneEffect(false);
    end
end

UIMainSkillPanel.FastUseItemList = {}
function UIMainSkillPanel.GetFastUseItemList()
    local itemId1 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem1);
    local itemId2 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem2);
    local itemId3 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem3);
    local itemId4 = CS.CSScene.MainPlayerInfo.ConfigInfo:GetInt(CS.EConfigOption.ShortcutItem4);

    UIMainSkillPanel.FastUseItemList[1] = itemId1;
    UIMainSkillPanel.FastUseItemList[2] = itemId2;
    UIMainSkillPanel.FastUseItemList[3] = itemId3;
    UIMainSkillPanel.FastUseItemList[4] = itemId4;
    --local list = {};
    --table.insert(list, itemId1)
    --table.insert(list, itemId2)
    --table.insert(list, itemId3)
    --table.insert(list, itemId4)

    --local showList = {};
    --for k, v in pairs(list) do
    --    if (v ~= 0) then
    --        table.insert(showList, v);
    --    end
    --end
    return UIMainSkillPanel.FastUseItemList;
end

--region 临时道具栏

UIMainSkillPanel.SnapItemViewTemplate = nil

function UIMainSkillPanel.InitSnapItemGridTemplate()
    if UIMainSkillPanel.SnapItemGridTemplate() ~= nil and not CS.StaticUtility.IsNull(UIMainSkillPanel.SnapItemGridTemplate()) and UIMainSkillPanel.SnapItemViewTemplate == nil then
        UIMainSkillPanel.SnapItemViewTemplate = templatemanager.GetNewTemplate(UIMainSkillPanel.SnapItemGridTemplate(), luaComponentTemplates.UISnapItemViewTemplate)
    end
end

function UIMainSkillPanel.GetSnapItemViewTemplate()
    if (UIMainSkillPanel.SnapItemViewTemplate == nil) then
        UIMainSkillPanel.InitSnapItemGridTemplate()
    end
    return UIMainSkillPanel.SnapItemViewTemplate;
end

--endregion



---销毁
function ondestroy()
    if UIMainSkillPanel.ReleaseClientEventHandler ~= nil then
        UIMainSkillPanel:ReleaseClientEventHandler()
    end
    --luaEventManager.RemoveCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect, UIMainSkillPanel.UpdateRandomStoneEffect);
    --luaEventManager.RemoveCallback(LuaCEvent.Skill_AutoRelease, UIMainSkillPanel.RefreshSkill)
    --luaEventManager.RemoveCallback(LuaCEvent.Skill_Refresh, UIMainSkillPanel.RefreshSkillPattern)
    --luaEventManager.RemoveCallback(LuaCEvent.SnapItemGridChange, UIMainSkillPanel.UpdateOtherFastItemList);
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSkillMessage, UIMainSkillPanel.OnResSkillChangeMessage)
    --  commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIMainSkillPanel.OnResSkillChangeMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSkillBookUseMessage, UIMainSkillPanel.OnResSkillBookUseMessage)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIMainSkillPanel.OnBagChanged);
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResOpenKeySettingPanelMessage, UIMainSkillPanel.OpenItemGroup)
    ;
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResUseItemMessage, UIMainSkillPanel.OnResUseItemMessage);
    UIMainSkillPanel.SnapItemViewTemplate = nil
end

return UIMainSkillPanel