---导航栏图标
---@class UINavigationUnitTemplate:TemplateBase
local UINavigationUnitTemplate = { }

--region Components

--region GameObject

function UINavigationUnitTemplate:GetBackGround_GameObject()
    if (self.mBackGround_GameObject == nil) then
        self.mBackGround_GameObject = self:Get("icon/backGround", "GameObject");
    end
    return self.mBackGround_GameObject;
end

function UINavigationUnitTemplate:GetCheckMark_GameObject()
    if (self.mCheckMark_GameObject == nil) then
        self.mCheckMark_GameObject = self:Get("icon/Checkmark", "GameObject");
    end
    return self.mCheckMark_GameObject;
end
--endregion

function UINavigationUnitTemplate:GetButtonBoxCollider()
    if (self.mButtonBoxCollider == nil) then
        self.mButtonBoxCollider = self:Get("icon", "BoxCollider");
    end
    return self.mButtonBoxCollider;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

---@param tableInfo TABLE.CFG_NAVIGATION
function UINavigationUnitTemplate:ShowButton(tableInfo)
    if tableInfo then
        self.mTableInfo = tableInfo
        self.mIcon_UISprite.spriteName = tableInfo.icon
        self:RemoveRedPoint();
        self:SetToggleValue(false)
        if self.mTableInfo.ID == 4 then
            self:RegisterRedPoint(CS.RedPointKey.SKILL_ALL)
            local Equip_Proficient = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Equip_Proficient)
            self:RegisterRedPoint(Equip_Proficient)
            local QiShuSkill = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.QiShuSkill)
            self:RegisterRedPoint(QiShuSkill)
        elseif (self.mTableInfo.ID == 24) then
            self:RegisterRedPoint(CS.RedPointKey.SKILL_PARTICULARS);
        elseif (self.mTableInfo.ID == 21) then
            self:RegisterRedPoint(CS.RedPointKey.SKILL_PARTICULARS);
        elseif (self.mTableInfo.ID == 2) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_ALL);
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_YuPei))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MiBao))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MianSha))
        elseif (self.mTableInfo.ID == 12) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_GEM);
        elseif (self.mTableInfo.ID == 10) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_CHYANLAMP);
        elseif (self.mTableInfo.ID == 11) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_SOULBEAD);
        elseif (self.mTableInfo.ID == 13) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFATTACK);
        elseif (self.mTableInfo.ID == 14) then
            self:RegisterRedPoint(CS.RedPointKey.FURNACE_THE_SOURCEOFDEFENSE);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.HeartSkill) then
            self:RegisterRedPoint(CS.RedPointKey.SKILL_SECRETSKILL);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Signet) then
            self:RegisterRedPoint(CS.RedPointKey.Signet);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Forge) then
            self:RegisterRedPoint(CS.RedPointKey.Signet);
            self:RegisterRedPoint(CS.RedPointKey.Element);
            self:RegisterRedPoint(CS.RedPointKey.Refine_HasRefineEquip);
            local BloodSuit_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_All);
            self:RegisterRedPoint(BloodSuit_All);
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All));
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Strength_All));
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.XianZhuangPush));
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint));
            self:RegisterRedPoint(gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetRedPointKey(nil, 1));
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint);
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasSynthesis);
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM_MagicWeapon));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX_MagicWeapon));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC_MagicWeapon));

            --- 灵兽装备合成
            --for i = 0, 2 do
            --    local keys = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquipRedPointKeys(i);
            --    if(keys ~= nil) then
            --        for k,v in pairs(keys) do
            --            self:RegisterRedPoint(v);
            --        end
            --    end
            --end
            ---元素合成
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
            ---印记合成
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
            ---合成列表
            local key = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey()
            self:RegisterRedPoint(key);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Element) then
            self:RegisterRedPoint(CS.RedPointKey.Element);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Refine) then
            self:RegisterRedPoint(CS.RedPointKey.Refine_HasRefineEquip);
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_All));
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All));
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Synthesis) then
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasRolePanelRedPoint);
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasSynthesis);
            --self:RegisterRedPoint(CS.RedPointKey.Synthesis_HasServantPanelRedPoint);
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_HM_MagicWeapon));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_LX_MagicWeapon));
            --self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_TC_MagicWeapon));
            --- 灵兽装备合成
            --for i = 0, 2 do
            --    local keys = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquipRedPointKeys(i);
            --    if(keys ~= nil) then
            --        for k,v in pairs(keys) do
            --            self:RegisterRedPoint(v);
            --        end
            --    end
            --end
            ---元素合成
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipElement));
            ---印记合成
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Synthesis_EquipSignet));
            ---合成列表
            local key = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetAllPageButtonRedPointKey()
            self:RegisterRedPoint(key);
        elseif (self.mTableInfo.ID == luaEnumNavigationType.BloodSuitSmelt) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuitSmelt_All));
        elseif (self.mTableInfo.ID == luaEnumNavigationType.ForgeGodPowerSmelt) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeGodPowerSmelt_All));
        elseif (self.mTableInfo.ID == luaEnumNavigationType.ForgeUpStar) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Strength_All));
        elseif (self.mTableInfo.ID == luaEnumNavigationType.StarLevel) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Strength_All));
        elseif (self.mTableInfo.ID == luaEnumNavigationType.SkillProficient) then
            local Equip_Proficient = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Equip_Proficient)
            self:RegisterRedPoint(Equip_Proficient)
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Inlay) then
            local XianZhuangPush = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.XianZhuangPush)
            self:RegisterRedPoint(XianZhuangPush)
        elseif (self.mTableInfo.ID == luaEnumNavigationType.XianZhuang) then
            local XianZhuangPush = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.XianZhuangPush)
            self:RegisterRedPoint(XianZhuangPush)
        elseif (self.mTableInfo.ID == luaEnumNavigationType.HuanHua) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ZhenFa))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.ZhenFa) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ZhenFa))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.JianDing) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.JianDingRedPoint))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.ForgeQuench) then
            local ForgeQuenchRedPoint = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr():GetRedPointKey(nil, 1)
            self:RegisterRedPoint(ForgeQuenchRedPoint)
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_YuPei))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MiBao))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin))
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MianSha))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_DengZuo) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_DengZuo))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_YuPei) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_YuPei))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_MiBao) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MiBao))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_BaoShi) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_BaoShi))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_LingHunKeYin) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_LingHunKeYin))
        elseif (self.mTableInfo.ID == luaEnumNavigationType.Recast_MianSha) then
            self:RegisterRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Recast_MianSha))
        end
    end
end

--endregion

--region Private

---设置Toggle值
function UINavigationUnitTemplate:SetToggleValue(value)
    if (self.mToggle_UIToggle ~= nil and not CS.StaticUtility.IsNull(self.mToggle_UIToggle)) then
        self.mToggle_UIToggle:Set(value, true);
    end
    self:OnToggleValueChanged(value);
end

---点击图标
function UINavigationUnitTemplate:OnClickIcon()
    if self:IsSystemOpen() then
        if luaEventManager.HasCallback(LuaCEvent.Navigation_OnClickUnit) then
            luaEventManager.DoCallback(LuaCEvent.Navigation_OnClickUnit, self.mTableInfo)
        end
    else
        self:SetToggleValue(false);
    end
end

function UINavigationUnitTemplate:OnToggleValueChanged(value)
    if (self.mIcon_UISprite ~= nil and not CS.StaticUtility.IsNull(self.mIcon_UISprite)) then
        if (self.mTableInfo ~= nil and self.mTableInfo.layer ~= LuaEnumNavMenusLayer.First) then
            self.mIcon_UISprite.spriteName = value and self.mTableInfo.icon or self.mTableInfo.darkicon;
        else
            self.mIcon_UISprite.spriteName = self.mTableInfo.icon;
        end
    end
end

---判断图标是否可点击
function UINavigationUnitTemplate:IsSystemOpen()
    return true
end

function UINavigationUnitTemplate:RegisterRedPoint(redPointKey)
    if self.mRedPointComponent ~= nil and not CS.StaticUtility.IsNull(self.mRedPointComponent) then
        self.mRedPointComponent:AddRedPointKey(redPointKey)
    end
end

function UINavigationUnitTemplate:RemoveRedPoint()
    if self.mRedPointComponent ~= nil then
        self.mRedPointComponent:RemoveRedPointKey()
    end
end

--通过工具生成 控件变量
function UINavigationUnitTemplate:InitComponents()
    --图标
    self.mIcon_UISprite = self:Get("icon", "UISprite");
    --图标物体
    self.mIcon_GameObject = self:Get("icon", "GameObject");
    --Toggle
    self.mToggle_UIToggle = self:Get("icon", "UIToggle");
    --红点
    self.mRedPointComponent = self:Get("icon/redpoint", "UIRedPoint");

    --表数据
    self.mTableInfo = nil;
end

function UINavigationUnitTemplate:InitEvents()
    CS.UIEventListener.Get(self.mIcon_GameObject).LuaEventTable = self;
    CS.UIEventListener.Get(self.mIcon_GameObject).OnClickLuaDelegate = self.OnClickIcon;

    self.CallOnNavClicked = function(msgId, tableInfo)
        if (not CS.StaticUtility.IsNull(self.go) and self.go.activeSelf) then
            if (self.mTableInfo ~= nil and tableInfo.layer == self.mTableInfo.layer) then
                self:SetToggleValue(tableInfo.ID == self.mTableInfo.ID);
            end
        end
    end
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Navigation_OnClickUnit, self.CallOnNavClicked)
    end
end

function UINavigationUnitTemplate:RemoveEvents()
    if self.mOwnerPanel then
        self.mOwnerPanel:GetLuaEventHandler():RemoveLuaEvent(LuaCEvent.Navigation_OnClickUnit, self.CallOnNavClicked)
    end
end

function UINavigationUnitTemplate:Clear()
    self.mIcon_UISprite = nil;
    self.mIcon_GameObject = nil;
    self.mToggle_UIToggle = nil;
    self.mRedPointComponent = nil;
    self.mTableInfo = nil;

    self.mButtonBoxCollider = nil;
    self.mCheckMark_GameObject = nil;
    self.mBackGround_GameObject = nil;
end
--endregion

--endregion

function UINavigationUnitTemplate:OnEnable()
    self:InitEvents();
end

function UINavigationUnitTemplate:OnDisable()
    self:RemoveEvents();
end

function UINavigationUnitTemplate:Init()
    ---@type UINavigationPanel
    self.mOwnerPanel = uimanager:GetPanel("UINavigationPanel")
    self:InitComponents();
end

function UINavigationUnitTemplate:OnDestroy()
    self:RemoveEvents();
    self:Clear();
end

return UINavigationUnitTemplate