---@class UIConfigPanel_Show:UIConfigPanel_PartBasic
local UIConfigPanel_Show = {}
setmetatable(UIConfigPanel_Show, luaComponentTemplates.UIConfigPanel_PartBasic)
--region 初始设置
function UIConfigPanel_Show:Init(uiConfigPanel)
    self:RunBaseFunction("Init",uiConfigPanel,LuaEnumConfigPanelOpenType.UIConfigPanel_Show)
    self.Transform_Scene = self:Get("scene", "Transform")
    self.Transform_ModePanel = self:Get("modePanel", "GameObject");
    self.Transform_HidePlayers = self:Get("scene/HidePlayers", "Transform");
    self.Transform_HideMonsters = self:Get("scene/HideMonsters", "Transform");
    self.Transform_HideAllSkillEffects = self:Get("scene/HideAllSkillEffects", "Transform");
    self.Transform_HideHero = self:Get("scene/HideHero", "Transform");
    self.Transform_HidePet = self:Get("scene/HidePet", "Transform");
    self.Transform_HideServantName = self:Get("scene/HideServantName", "Transform");
    self.Transform_HideMonstersSkillEffects = self:Get("scene/HideMonstersSkillEffects", "Transform");
    self.UISlider_zoom = self:Get("mapScalePanel/ScaleShow", "UISlider");
    self.zoomTitle = self:Get("mapScalePanel/ScaleShow/Label", "UILabel");
    self.Transform_HideMagicCircle = self:Get("scene/HideMagicCircle", "Transform");
    ---场景资源
    self:SetToogle(self.Transform_Scene, "HidePlayers", CS.EConfigOption.HidePlayers, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideAllSkillEffects", CS.EConfigOption.HideSkillEffects, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideHero", CS.EConfigOption.HideServant, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideServantName", CS.EConfigOption.HideServantName, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HidePet", CS.EConfigOption.HidePet, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideMonsters", CS.EConfigOption.HideMonsters, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideMonstersSkillEffects", CS.EConfigOption.HideMonstersSkillEffects, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideServantMasterName", CS.EConfigOption.HideServantBelongerName, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "ChangeHat", CS.EConfigOption.HideDouLi, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "HideMagicCircle", CS.EConfigOption.HideMagicCircle, self.SetShowTooleFunc)
    self:SetToogle(self.Transform_Scene, "ChangeShield", CS.EConfigOption.HideLeftWeapon, self.SetShowTooleFunc)
    ---下拉列表
    self:SetDropDown(self.Transform_HidePlayers, "DropDown", CS.EConfigOption.HidePlayersList)
    self:SetDropDown(self.Transform_HideAllSkillEffects, "DropDown", CS.EConfigOption.HideAllSkillEffectsList)
    self:SetDropDown(self.Transform_HideHero, "DropDown", CS.EConfigOption.HideServantList)
    self:SetDropDown(self.Transform_HideServantName, "DropDown", CS.EConfigOption.HideTarget)
    self:SetDropDown(self.Transform_HidePet, "DropDown", CS.EConfigOption.HidePetList)
    self:SetDropDown(self.Transform_HideMagicCircle, "DropDown", CS.EConfigOption.HideMagicCircleList)
    ---显示模式
    self:SetSliderPoint(self.Transform_ModePanel, "ModeShow", CS.EConfigOption.Model,self.settingTableManager:GetModelPointList(),function(enum,value)
        self:SetModel(value)
    end)

    self:SetSlider_UISlider(self.UISlider_zoom, CS.EConfigOption.MapZoom, self.SetVolume)
end

--endregion

--region 刷新面板
function UIConfigPanel_Show:RefreshPanel()
    if self:CheckIsRefresh() == false then
        ---场景资源
        self:GetToogle(self.Transform_Scene, "HidePlayers", CS.EConfigOption.HidePlayers)
        self:GetToogle(self.Transform_Scene, "HideAllSkillEffects", CS.EConfigOption.HideSkillEffects)
        self:GetToogle(self.Transform_Scene, "HideHero", CS.EConfigOption.HideServant)
        self:GetToogle(self.Transform_Scene, "HideServantName", CS.EConfigOption.HideServantName,self.SetShowTooleFunc)
        self:GetToogle(self.Transform_Scene, "HidePet", CS.EConfigOption.HidePet)
        self:GetToogle(self.Transform_Scene, "HideMonsters", CS.EConfigOption.HideMonsters)
        self:GetToogle(self.Transform_Scene, "HideMonstersSkillEffects", CS.EConfigOption.HideMonstersSkillEffects)
        self:GetToogle(self.Transform_Scene, "HideServantMasterName", CS.EConfigOption.HideServantBelongerName)
        self:GetToogle(self.Transform_Scene, "ChangeHat", CS.EConfigOption.HideDouLi)
        self:GetToogle(self.Transform_Scene, "HideMagicCircle", CS.EConfigOption.HideMagicCircle, self.SetShowTooleFunc)
        self:GetToogle(self.Transform_Scene, "ChangeShield", CS.EConfigOption.HideLeftWeapon)
        ---下拉列表
        self:GetDropDownByTextTable(self.Transform_HidePlayers, "DropDown", CS.EConfigOption.HidePlayersList,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HidePlayersList)))
        self:GetDropDownByTextTable(self.Transform_HideAllSkillEffects, "DropDown", CS.EConfigOption.HideAllSkillEffectsList,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HideAllSkillEffectsList)))
        self:GetDropDownByTextTable(self.Transform_HideHero, "DropDown", CS.EConfigOption.HideServantList,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HideServantList)))
        self:GetDropDownByTextTable(self.Transform_HideServantName, "DropDown", CS.EConfigOption.HideTarget,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HideTarget)))
        self:GetDropDownByTextTable(self.Transform_HidePet, "DropDown", CS.EConfigOption.HidePetList,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HidePetList)))
        self:GetDropDownByTextTable(self.Transform_HideMagicCircle, "DropDown", CS.EConfigOption.HideMagicCircleList,self.settingTableManager:GetSettingDropDownArray(Utility.EnumToInt(CS.EConfigOption.HideMagicCircleList)))
        ---显示模式
        self:RefreshModel()
        self:GetSliderTwo(self.UISlider_zoom, CS.EConfigOption.MapZoom,self.SetVolume)
    end
    self:InitRefresh()
end

function UIConfigPanel_Show:RefushModePanel()
end
--endregion

--region 对应功能
---设置Toogle
function UIConfigPanel_Show.SetShowTooleFunc(Go_Enum, value)
    --region 显示面板
    if Go_Enum == CS.EConfigOption.HidePlayers then
        --隐藏玩家
        --CS.UnityEngine.Debug.LogError("隐藏玩家")
    end
    if Go_Enum == CS.EConfigOption.HideMonsters then
        --隐藏怪物
        --CS.UnityEngine.Debug.LogError("隐藏怪物")
    end
    if Go_Enum == CS.EConfigOption.HideSkillEffects then
        --隐藏技能特效
        --CS.UnityEngine.Debug.LogError("隐藏技能特效")
    end
    if Go_Enum == CS.EConfigOption.HideWing then
        --隐藏角色翅膀
        --CS.UnityEngine.Debug.LogError("隐藏人物翅膀")
    end
    if Go_Enum == CS.EConfigOption.HideServant then
        --隐藏法神
        --CS.UnityEngine.Debug.LogError("隐藏法神")
    end
    if Go_Enum == CS.EConfigOption.HidePet then
        --隐藏召唤物
        --CS.UnityEngine.Debug.LogError("隐藏召唤物")
    end
    if Go_Enum == CS.EConfigOption.HideServantName then
        --隐藏灵兽名称
        --CS.CSScene.Sington:headCompController(CS.HeadPlayerType.Servant, CS.HeadCompSwich.Name, not value)
    end
    if Go_Enum == CS.EConfigOption.ShowCardIcon then
        --显示特权卡图标
        --CS.UnityEngine.Debug.LogError("显示特权卡图标")
    end
    if Go_Enum == CS.EConfigOption.ShowPostIcon then
        --显示官位图标
        --CS.UnityEngine.Debug.LogError("显示官位图标")
    end
    if Go_Enum == CS.EConfigOption.ShowSuitIcon then
        --显示龙装图标
        --CS.UnityEngine.Debug.LogError("显示龙装图标")
    end
    if Go_Enum == CS.EConfigOption.ShowZZSuitIcon then
        --显示主宰套装图标
        --CS.UnityEngine.Debug.LogError("显示主宰套装图标")
    end
    if Go_Enum == CS.EConfigOption.DoubleJoysticks then
        --双摇杆
        if luaEventManager.HasCallback(LuaCEvent.DoubleJoysticksStatuChange) then
            luaEventManager.DoCallback(LuaCEvent.DoubleJoysticksStatuChange, value)
        end
    end
    if Go_Enum == CS.EConfigOption.HideServantBelongerName then
        ---刷新灵兽头像
        CS.CSSceneExt.Sington:RefreshNameByAvatarType(CS.EAvatarType.Servant)
    end
    --endregion
end

--region 显示模式
function UIConfigPanel_Show:SetModel(value)
    if value >= 0.75 and value <= 1 then
        self:OnModeToggleClicked(CS.EAdaptModel.Default, value)
    elseif value >= 0.25 and value <= 0.75 then
        self:OnModeToggleClicked(CS.EAdaptModel.Process, value)
    else
        self:OnModeToggleClicked(CS.EAdaptModel.Turbo, value)
    end
end

---显示模式Toggle点击事件
---@param enum EAdaptModel
---@param value boolean
function UIConfigPanel_Show:OnModeToggleClicked(enum, value)
    if value then
        CS.CSAdaptManager.Instance:SwitchAdaptModel(enum)
    end
end

function UIConfigPanel_Show:RefreshModel()
    self:GetSlider(self.Transform_ModePanel, "ModeShow", CS.EConfigOption.Model)
end

function UIConfigPanel_Show.SetVolume(Go_Enum, value,slider)
    local nowValue=Utility.TransformRange(value,0, 1, 1.25, 0.75)
    if Go_Enum == CS.EConfigOption.MapZoom then
        local f =  CS.CSGame.Sington.ContentSize.y / 2 * CS.CSScene.SceneScale.y
        if CS.StaticUtility.IsNull(CS.UnityEngine.Camera.main)==false  then
            CS.UnityEngine.Camera.main.orthographicSize = f*(nowValue)
        end
        if slider~=nil then
            local Title = UIConfigPanel_Show:GetCurComp(slider.transform, "Label", "UILabel")
            local showValue=tonumber(Utility.TransformRange(value,0, 1, 1, 1.5))
            Title.text= "[dde6eb]缩放(".. string.format("%.2f", showValue).."倍)"
        end
    end
end


--endregion
--endregion
return UIConfigPanel_Show