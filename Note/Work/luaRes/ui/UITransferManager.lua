if uiTransferManager then
    if CS.CSDebug.developerConsoleVisible then
        CS.CSDebug.LogError("uiTransferManager 已被加载")
    end
    return uiTransferManager
end

local UITransferManager = {}

UITransferManager.mTargetTransferId = 0;

UITransferManager.mLastTransferId = 0;

UITransferManager.mIsTransferToLast = true;

--region Method

--region PublicF

function UITransferManager:Initialize()
    if self.CallOnClosePanel ~= nil then
        luaEventManager.RemoveCallback(LuaCEvent.ClosePanel, self.CallOnClosePanel);
        self.CallOnClosePanel = nil
    end
    self.CallOnClosePanel = function(msgId, msgData)
        self:TryTransferLastPanel(msgData);
    end
    luaEventManager.BindCallback(LuaCEvent.ClosePanel, self.CallOnClosePanel);
end

function UITransferManager:SetIsTransferToLast(isTransferLast)
    self.mIsTransferToLast = isTransferLast;
end

function UITransferManager:UpdateLastTransfer(transferTable)
    --if(not self.mIsTransferToLast) then
    if (self.mTargetTransferId ~= 0) then
        self.mLastTransferId = self.mTargetTransferId;
    end

    --先强行写死修复,下版本统一处理
    if (math.ceil(transferTable.id / 100) == math.ceil(self.mLastTransferId / 100)) then
        self:ClearTransfer()
    end
    self.mTargetTransferId = transferTable.id;
    --end
end

function UITransferManager:ClearTransfer()
    self.mIsTransferToLast = false;
    self.mLastTransferId = 0;
end

function UITransferManager:TryResetLastTransfer(panelName)
    if (self.mLastTransferId ~= 0) then
        if (self.mIsTransferToLast) then
            local isFind, transferTable = CS.Cfg_JumpUITableManager.Instance:TryGetValue(self.mLastTransferId);
            if (isFind) then
                local targetPanelName = self:GetPanelName(transferTable);
                if (targetPanelName ~= panelName) then
                    self.mIsTransferToLast = false;
                end
            end
        end
    end
end

---回溯到上一个界面
function UITransferManager:TryTransferLastPanel(panelName)
    if (not self.mIsTransferToLast) then
        return ;
    end
    if (self.mTargetTransferId ~= self.mLastTransferId) then
        local isFind, transferTable = CS.Cfg_JumpUITableManager.Instance:TryGetValue(self.mTargetTransferId);
        if (isFind) then
            local targetPanelName = self:GetPanelName(transferTable);
            if (targetPanelName == panelName and self.mLastTransferId ~= 0) then
                self.mIsTransferToLast = false;
                self:TransferToPanel(self.mLastTransferId);
            end
        end
    end
end

function UITransferManager:TransferToPanel(transferId, customData, createPanelCallBack)
    local isFind, transferTable = CS.Cfg_JumpUITableManager.Instance:TryGetValue(transferId);
    if (isFind) then
        if (self:IsCanTransfer(transferTable)) then
            if (transferTable.channel == 2) then
                self:TryTransferUIInNavigation(transferTable, customData, createPanelCallBack);
            elseif (transferTable.channel == 1) then
                self:TransferCreatePanel(transferTable, customData, createPanelCallBack);
            elseif (transferTable.channel == 3) then
                self:TryTransferUIMainChatPanel(transferTable, customData, createPanelCallBack);
            elseif (transferTable.channel == 4) then
                self:TryTransferSecretBook(transferTable, customData, createPanelCallBack);
            else
                self:TransferCreatePanel(transferTable, customData, createPanelCallBack);
            end
        end
    else
        if CS.CSDebug.developerConsoleVisible then
            CS.CSDebug.LogError("系统跳转表查询不到此ID：" .. tostring(transferId));
        end
        --uimanager:CreatePanel(transferId, createPanelCallBack, customData);
    end
end

---导航栏途径跳转
function UITransferManager:TryTransferUIInNavigation(transferTable, customData, createPanelCallBack)
    if (transferTable ~= nil) then
        self:UpdateLastTransfer(transferTable);
        local navId = tonumber(transferTable.params);
        if (navId ~= nil) then
            if self.CallOnNavigationOpenPanelFinished ~= nil then
                luaEventManager.RemoveCallback(LuaCEvent.Navigation_OpenPanelFinished, self.CallOnNavigationOpenPanelFinished)
                self.CallOnNavigationOpenPanelFinished = nil
            end
            self.CallOnNavigationOpenPanelFinished = function(msgId, msgData)
                if (msgData == transferTable.panels) then
                    if (createPanelCallBack ~= nil) then
                        createPanelCallBack(msgData)
                    end
                end
                luaEventManager.RemoveCallback(LuaCEvent.Navigation_OpenPanelFinished, self.CallOnNavigationOpenPanelFinished)
                self.CallOnNavigationOpenPanelFinished = nil
            end
            luaEventManager.BindCallback(LuaCEvent.Navigation_OpenPanelFinished, self.CallOnNavigationOpenPanelFinished)

            local paramsCustomData = self:GetTransferParams(transferTable.id, customData);
            if (paramsCustomData.targetId == nil) then
                paramsCustomData.targetId = navId;
            end
            luaEventManager.DoCallback(LuaCEvent.Navigation_OpenWithId, paramsCustomData);
        end
    end
end

---主界面UIMainChatPanel途径
function UITransferManager:TryTransferUIMainChatPanel(transferTable, customData, createPanelCallBack)
    if (transferTable ~= nil) then

        self:UpdateLastTransfer(transferTable);

        if self.CallOnMainChatPanelOpenPanelFinished ~= nil then
            luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, self.CallOnMainChatPanelOpenPanelFinished);
            self.CallOnMainChatPanelOpenPanelFinished = nil
        end
        self.CallOnMainChatPanelOpenPanelFinished = function(msgId, msgData)
            if (createPanelCallBack ~= nil) then
                createPanelCallBack(msgData);
            end
            luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, self.CallOnMainChatPanelOpenPanelFinished);
            self.CallOnMainChatPanelOpenPanelFinished = nil
        end
        luaEventManager.BindCallback(LuaCEvent.MainChatPanel_OnOpenPanelFinished, self.CallOnMainChatPanelOpenPanelFinished);

        local paramsCustomData = self:GetTransferParams(transferTable.id, customData);
        luaEventManager.DoCallback(LuaCEvent.MainChatPanel_OpenSocialPanel, paramsCustomData);
    end
end

---秘籍打开
function UITransferManager:TryTransferSecretBook(transferTable, customData, createPanelCallBack)
    if (transferTable == nil) then
        return ;
    end

    self:UpdateLastTransfer(transferTable);

    --local paramsCustomData = self:GetTransferParams(transferTable.id, customData);
    local keyWordId = tonumber(transferTable.params);
    if (keyWordId ~= nil) then
        local isFind, secretBookTable = CS.Cfg_SecretBookTableManager.Instance:TryGetValue(keyWordId);
        if (isFind) then
            self:TryCreatePanel(transferTable.panels, secretBookTable.keyWord, createPanelCallBack);
        end
    end
end

---默认途径打开
function UITransferManager:TransferCreatePanel(transferTable, customData, createPanelCallBack)
    if (transferTable == nil) then
        return ;
    end

    self:UpdateLastTransfer(transferTable);

    if (customData == nil) then
        customData = {};
    end
    local paramsCustomData = self:GetTransferParams(transferTable.id, customData, transferTable);
    self:TryCreatePanel(self:GetPanelName(transferTable), paramsCustomData, createPanelCallBack);
end

function UITransferManager:IsCanTransfer(transferTable)
    local isOpen = true;
    if (transferTable.openSystem ~= nil and transferTable.openSystem ~= 0) then
        isOpen = CS.CSSystemController.Sington:CheckSystem(transferTable.openSystem);
    end
    return isOpen;
end

--endregion

--region Private

function UITransferManager:GetPanelName(transferTable)
    if (transferTable ~= nil) then
        return transferTable.panels;
    end
    return "";
end

function UITransferManager:GetTransferParams(transferId, customData, transferTable)
    if (customData == nil) then
        customData = {};
    end

    local transferTbl = clientTableManager.cfg_jumpManager:TryGetValue(transferId)

    if (transferId == LuaEnumTransferType.Strengthen_Role) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Role;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Strengthen;
        end

    elseif (transferId == LuaEnumTransferType.Strengthen_Bag) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Bag;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Strengthen;
        end

    elseif (transferId == LuaEnumTransferType.Strengthen_Servant) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.YuanLing;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Strengthen;
        end

    elseif (transferId == LuaEnumTransferType.Element_Role) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Role;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Element;
        end

    elseif (transferId == LuaEnumTransferType.Element_Bag) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Bag;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Element;
        end

    elseif (transferId == LuaEnumTransferType.Evolution_Role) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Role;
        end

    elseif (transferId == LuaEnumTransferType.Evolution_Bag) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Bag;
        end

    elseif (transferId == LuaEnumTransferType.Imprint_Role) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Role;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Signet;
        end

    elseif (transferId == LuaEnumTransferType.Imprint_Bag) then
        if (customData.leftPanelType == nil) then
            customData.leftPanelType = LuaEnumStrengthenType.Bag;
        end
        if (customData.rightPanelType == nil) then
            customData.rightPanelType = LuaEnumForgeOpenType.Signet;
        end

    elseif (transferId == LuaEnumTransferType.Guild_Info) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildInfo;

    elseif (transferId == LuaEnumTransferType.Guild_Member) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildMember;

    elseif (transferId == LuaEnumTransferType.Guild_Welfare) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildWelfare;

    elseif (transferId == LuaEnumTransferType.Guild_WareHouse) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildWarehouse;

    elseif (transferId == LuaEnumTransferType.Guild_Smelt) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildSmelt;

    elseif (transferId == LuaEnumTransferType.Guild_Activity) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.GuildPanel
        end

        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumGuildPanelType.GuildActivity;

    elseif (transferId == LuaEnumTransferType.ConfigBase) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.BasePanel;
        end

    elseif (transferId == LuaEnumTransferType.ConfigPickup) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.PickupPanel;
        end

    elseif (transferId == LuaEnumTransferType.ConfigPattern) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.ShowPanel;
        end

    elseif (transferId == LuaEnumTransferType.ConfigFeedback) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.FeedbackPanel;
        end

    elseif (transferId == LuaEnumTransferType.ConfigKeyPos) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.SkillConfigPanel;
        end
    elseif (transferId == LuaEnumTransferType.ConfigProtect) then
        if (customData.type == nil) then
            customData.type = LuaEnumConfigPanelOpenType.ProtectPanel;
        end


    elseif (transferId == LuaEnumTransferType.HeartSkill) then
        if (customData.type == nil) then
            customData.type = LuaEnumHeartSkillShowType.HeartSkill;
        end

    elseif (transferId == LuaEnumTransferType.HeartFormation) then
        if (customData.type == nil) then
            customData.type = LuaEnumHeartSkillShowType.HeartFormation;
        end

    elseif (transferId == LuaEnumTransferType.SkillDetails) then
        if (customData.type == nil) then
            customData.type = 0;
        end

    elseif (transferId == LuaEnumTransferType.FurnaceLight) then
        if (customData.type == nil) then
            customData.type = LuaEnumFurnaceOpenType.ChyanLamp;
        end

    elseif (transferId == LuaEnumTransferType.FurnaceSoulBead) then
        if (customData.type == nil) then
            customData.type = LuaEnumFurnaceOpenType.SoulBead;
        end

    elseif (transferId == LuaEnumTransferType.FurnaceGem) then
        if (customData.type == nil) then
            customData.type = LuaEnumFurnaceOpenType.Gem;
        end

    elseif (transferId == LuaEnumTransferType.FurnaceTheSourceOfAttack) then
        if (customData.type == nil) then
            customData.type = LuaEnumFurnaceOpenType.TheSourceOfAttack;
        end

    elseif (transferId == LuaEnumTransferType.FurnaceTheSourceOfDefence) then
        if (customData.type == nil) then
            customData.type = LuaEnumFurnaceOpenType.TheSourceOfDefense;
        end
    elseif (transferId == LuaEnumTransferType.Role_Prefix) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRolePrefixPanel;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Elite) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.EliteBoss;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Nest) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.WorldBoss;
        end
    elseif (transferId >= 5101 and transferId < 5200) then
        --小页签范围处理
        if (customData.type == nil) then
            if transferTbl:GetParams() then
                local paramTbl = string.Split(transferTbl:GetParams(), '#')
                if #paramTbl > 0 then
                    customData.type = tonumber(paramTbl[1])
                    customData.subType = tonumber(paramTbl[2])
                end
            end
        end
    elseif (transferId == LuaEnumTransferType.Boss_Final) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.FinalBoss;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Final_Ancient) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.FinalBoss;
            customData.subType = LuaEnumFinalBossType.AncientBoss
        end
    elseif (transferId == LuaEnumTransferType.Boss_Final_God) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.FinalBoss;
            customData.subType = LuaEnumFinalBossType.MythBoss
        end
    elseif (transferId == LuaEnumTransferType.Boss_Integral) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.BossScore;
        end

    elseif (transferId == LuaEnumTransferType.Boss_Demon) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.DemonBoss;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Dark) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.DarkBoss;
        end

    elseif (transferId == LuaEnumTransferType.Boss_Wander) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.WanderBoss;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Personal) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.PersonalBoss;
        end
    elseif (transferId == LuaEnumTransferType.Boss_Zodiac) then
        if (customData.type == nil) then
            customData.type = LuaEnumBossType.ZodiacBOSS;
        end
    elseif (transferId == LuaEnumTransferType.Bag_Base) then
        if (customData.type == nil) then
            customData.type = LuaEnumBagType.Normal;
        end
    elseif (transferId == LuaEnumTransferType.Bag_Recycl) then
        if (customData.type == nil) then
            customData.type = LuaEnumBagType.Recycle;
        end
    elseif (transferId == LuaEnumTransferType.Bag_Smelt) then
        if (customData.type == nil) then
            customData.type = LuaEnumBagType.Smelt;
        end
        --灵兽主界面
    elseif (transferId == LuaEnumTransferType.Servant_Base_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Base_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Base_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
        --灵兽升级
    elseif (transferId == LuaEnumTransferType.Servant_Upgrade_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.LevelPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Upgrade_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.LevelPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Upgrade_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.LevelPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
        --灵兽肉身
    elseif (transferId == LuaEnumTransferType.Servant_Flesh_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Flesh_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Flesh_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
        --灵兽合体
    elseif (transferId == LuaEnumTransferType.Servant_Combit_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Combit_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Combit_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
        --灵兽出战
    elseif (transferId == LuaEnumTransferType.Servant_Battle_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Battle_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Battle_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.BasePanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
        --灵兽转生
    elseif (transferId == LuaEnumTransferType.Servant_Rein_HM) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.ReinPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.First - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Rein_LX) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.ReinPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Second - 1
        end
    elseif (transferId == LuaEnumTransferType.Servant_Rein_TC) then
        if (customData.type == nil) then
            customData.type = LuaEnumServantPanelType.ReinPanel;
        end
        if customData.servantIndex == nil then
            customData.servantIndex = LuaEnumServantSpeciesType.Third - 1
        end
    elseif (transferId == LuaEnumTransferType.Shop_Gold) then
        if (customData.type == nil) then
            customData.type = LuaEnumStoreType.GoldShop;
        end
    elseif (transferId == LuaEnumTransferType.Shop_Diamond
            or transferId == LuaEnumTransferType.Shop_CommerceTaLuoPai) then
        if (customData.type == nil) then
            customData.type = LuaEnumStoreType.Diamond;
        end
    elseif (transferId == LuaEnumTransferType.Shop_YuanBao) then
        if (customData.type == nil) then
            customData.type = LuaEnumStoreType.YuanBao;
        end
    elseif (transferId == LuaEnumTransferType.Shop_Commerce) then
        if (customData.type == nil) then
            customData.type = LuaEnumStoreType.CommerceDiamond;
        end
    elseif (transferId == LuaEnumTransferType.Auction_Trade) then
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.Trade
        end
    elseif (transferId == LuaEnumTransferType.Auction_Auction) then
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.Auction
        end
    elseif (transferId == LuaEnumTransferType.Auction_UpperShelf) then
        ---拍卖行上架
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.SelfSell
        end
    elseif (transferId == LuaEnumTransferType.Auction_StallShelf) then
        ---摊位上架
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.SelfSell
            customData.ShelfType = LuaEnumAuctionSelfSellType.Stall
        end
    elseif (transferId == LuaEnumTransferType.Auction_Smelt) then
        ---熔炼行
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.Smelt
        end
    elseif (transferId == LuaEnumTransferType.Auction_Union) then
        ---行会竞拍
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.UnionAuction
        end
    elseif (transferId == LuaEnumTransferType.Team_TeamPanel) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.TeamPanel
        end
    elseif (transferId == LuaEnumTransferType.Team_Req) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.TeamPanel
        end
        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumTeamPanelType.TeamReq

    elseif (transferId == LuaEnumTransferType.Friend_CircleOfFriends) then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.SocialChatPanel
        end
        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumSocialFriendPanelType.FriendCirclePanel;
    elseif (transferId == LuaEnumTransferType.Role_Rein) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRoleTurnGrowPanel
        end
        customData.index = LuaEnumRoleReinPanelType.ReinPanel
    elseif (transferId == LuaEnumTransferType.Role_Rein_LevelExpExchange) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRoleTurnGrowPanel
        end
        customData.index = LuaEnumRoleReinPanelType.ExpExchange
    elseif transferId == LuaEnumTransferType.Aid_JuLingZhu then
        if customData.info == nil then
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBeadsJuLingZhuInfo()
            customData.info = itemInfo
        end
    elseif transferId == LuaEnumTransferType.Friend_FrindInfoPanel then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.SocialChatPanel
        end
        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumSocialFriendPanelType.FriendInfoPanel;
    elseif transferId == LuaEnumTransferType.Friend_FriendChat then
        if (customData.type == nil) then
            customData.type = LuaEnumSocialPanelType.SocialChatPanel
        end
        if (customData.subCustomData == nil) then
            customData.subCustomData = {};
        end
        customData.subCustomData.type = LuaEnumSocialFriendPanelType.LastChatPanel;
    elseif transferId == LuaEnumTransferType.SecondConfirm_Marry then
        customData = Utility.GetSecondConfirmPanelParams(55)
        customData.CallBack = function()
            local marryRingNpcId = CS.Cfg_GlobalTableManager.Instance:GetMarryRingNpcId()
            local marryRingDeliverId = CS.Cfg_GlobalTableManager.Instance:GetMarryRingDeliverId()
            --[[            local finishCodeEnum = CS.CSScene.MainPlayerInfo.AsyncOperationController.MarryRingOperateFindNPCOperation:DoOperation(marryRingDeliverId, marryRingNpcId)
                        local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(finishCodeEnum)
                        if finishCode >= 0 then
                            uimanager:ClosePanel('UIRolePanel')
                            uimanager:ClosePanel('UIBagPanel')
                        end]]
            Utility.TryTransfer(marryRingDeliverId)
            uimanager:ClosePanel('UIRolePanel')
            uimanager:ClosePanel('UIBagPanel')
        end
    elseif transferId == LuaEnumTransferType.Rename_Role then
        if (customData.id == nil) then
            customData.id = 6000006
        end
    elseif transferId == LuaEnumTransferType.Rename_Union then
        if (customData.id == nil) then
            customData.id = 6000007
        end
    elseif transferId == LuaEnumTransferType.Recharge then
        customData.type = LuaEnumRechargeMainBookMarkType.Recharge
    elseif transferId == LuaEnumTransferType.Recharge_Award then
        customData.type = LuaEnumRechargeMainBookMarkType.Award
    elseif transferId == LuaEnumTransferType.Recharge_SpecialGift then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.PreferenceGift }
    elseif transferId == LuaEnumTransferType.Recharge_Potential then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.PotentialInvest }


    elseif transferId == LuaEnumTransferType.Competition_LevelUp then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.OpenActivity }
    elseif transferId == LuaEnumTransferType.Competition_FirstKill then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.FirstKill }
    elseif transferId == LuaEnumTransferType.Competition_FirstDropReward then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.FirstDrop }
    elseif transferId == LuaEnumTransferType.Competition_EquipRecycle then
        customData.type = LuaEnumRechargeMainBookMarkType.Activity
        customData.customData = { type = luaEnumCompetitionType.Recycle }

    elseif transferId == LuaEnumTransferType.Role_Equip_Atr then
        if customData.CallBack == nil then
            customData.CallBack = function(panel)
                panel:OnRightArrowClick(nil)
                if panel.dataDelta ~= nil then
                    panel.dataDelta:ChangeMoShiLight(true)
                end
            end
        end
    elseif (transferId == LuaEnumTransferType.Synthesis_Role) then
        --if (customData.type == nil) then
        --    customData.type = LuaEnumSynthesisLeftPanelType.Role;
        --end
    elseif (transferId == LuaEnumTransferType.Synthesis_Bag) then
        --合成背包已删除，现在跳转到合成列表
        if (customData.type == nil) then
            customData.type = LuaEnumSynthesisLeftPanelType.Synthesis_List;
        end
    elseif (transferId == LuaEnumTransferType.Synthesis_List) then
        if (customData.type == nil) then
            customData.type = LuaEnumSynthesisLeftPanelType.SynthesisList;
        end
    elseif (transferId == LuaEnumTransferType.Synthesis_Servant) then
        if (customData.type == nil) then
            customData.type = LuaEnumSynthesisLeftPanelType.Servant;
        end
    elseif (transferId == LuaEnumTransferType.SpiritPractice) then
        customData.servantIndex = 0
        customData.type = LuaEnumServantPanelType.LevelPanel;
        customData.IsOpenPracticePanel = true
    elseif (transferId == LuaEnumTransferType.GatherSoul) then
        customData.servantIndex = 0
        customData.type = LuaEnumServantPanelType.ReinPanel;
        customData.IsOpenGatherSoulPanel = true
    elseif (transferId == LuaEnumTransferType.BloodSuitSmelt_BloodSuit) then
        if (customData.type == nil) then
            customData.type = LuaEnumBloodSuitSmeltType.BloodSuit
        end
    elseif (transferId == LuaEnumTransferType.BloodSuitSmelt_Bag) then
        if (customData.type == nil) then
            customData.type = LuaEnumBloodSuitSmeltType.Bag
        end
    elseif (transferId == LuaEnumTransferType.SLSuitSmelt_Role) then
        if (customData.type == nil) then
            customData.type = 1
        end
    elseif (transferId == LuaEnumTransferType.BloodEquip_Yao) or (transferId == LuaEnumTransferType.BloodEquip_Xian) or
            (transferId == LuaEnumTransferType.BloodEquip_Mo) or (transferId == LuaEnumTransferType.BloodEquip_Ling) or
            (transferId == LuaEnumTransferType.BloodEquip_Shen)
    then
        customData = {}
        customData.type = LuaEnumLeftTagType.UIRoleBloodSuitPanel
        customData.BloodSuitType = transferId - 3400
        customData.BloodSuitPos = customData.BloodSuitPos
        if customData.BloodSuitPos == nil then
            customData.BloodSuitPos = LuaEquipBloodSuitItemType.None
        end
    elseif (transferId == LuaEnumTransferType.SLSuitSmelt_Bag) then
        if (customData.type == nil) then
            customData.type = 2
        end
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_ShengWu) then
        customData.type = LuaEnumBaiRiMenActivityType.ShengWu
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_FengShang) then
        customData.type = LuaEnumBaiRiMenActivityType.FengShang
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_LieMo) then
        customData.type = LuaEnumBaiRiMenActivityType.LieMo
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_HuoYun) then
        customData.type = LuaEnumBaiRiMenActivityType.HuoYun
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_LianFu) then
        customData.type = LuaEnumBaiRiMenActivityType.LianFu
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_CangYue) then
        customData.type = LuaEnumBaiRiMenActivityType.CangYue
    elseif (transferId == LuaEnumTransferType.SpecialMenActivity_KHSD) then
        customData.mChooseActivityType = 8
    elseif (transferId == LuaEnumTransferType.SpecialMenActivity_XSLB) then
        customData.mChooseActivityType = 3
    elseif (transferId == LuaEnumTransferType.BaiRiMenActivity_ChuangTianGuan) then
        customData.type = LuaEnumBaiRiMenActivityType.ChuangTianGuan
    elseif (transferId == LuaEnumTransferType.Role_Position_HuFu) then
        customData.type = LuaEnumLeftTagType.UIOfficialPositionPanel
        customData.isOpenHuFu = true
    elseif (transferId == LuaEnumTransferType.Role_Collection) then
        customData.type = LuaEnumLeftTagType.UICollectionPanel
    elseif (transferId == LuaEnumTransferType.Role_Potential) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRolePotentialPanel
        end

        if (customData.index == nil) then
            customData.index = 1;
        end
    elseif (transferId == LuaEnumTransferType.Role_Potential_ZuZhou) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRolePotentialPanel
        end

        if (customData.index == nil) then
            customData.index = 2;
        end
    elseif (transferId == LuaEnumTransferType.Role_Potential_JiSu) then
        if (customData.type == nil) then
            customData.type = LuaEnumLeftTagType.UIRolePotentialPanel
        end

        if (customData.index == nil) then
            customData.index = 3;
        end
    elseif (transferId == LuaEnumTransferType.AgainRefine_Role) then
        ---@type AgainRefinePanelData
        if (customData.mType == nil) then
            customData.mType = LuaEnumAgainRefineType.Soul;
        end
    elseif (transferId == LuaEnumTransferType.AgainRefine_Bag) then
        ---@type AgainRefinePanelData
        if (customData.mType == nil) then
            customData.mType = LuaEnumAgainRefineType.Bag;
        end
    elseif (transferId == LuaEnumTransferType.Calender_HHDG) then
        if (customData.type == nil) then
            customData.type = LuaEnumDailyActivityType.HangHuiDiGong;
        end
    elseif (transferId == LuaEnumTransferType.Calender_HHSL) then
        if (customData.type == nil) then
            customData.type = LuaEnumDailyActivityType.GuildBoss;
        end
    elseif (transferId == LuaEnumTransferType.Member_Panel
            or transferId == LuaEnumTransferType.Member_ZuanShi
            or transferId == LuaEnumTransferType.Member_XingYao
            or transferId == LuaEnumTransferType.Member_BaiYin
            or transferId == LuaEnumTransferType.Member_HuangJin
            or transferId == LuaEnumTransferType.Member_BaiJin
            or transferId == LuaEnumTransferType.Member_WangZhe
            or transferId == LuaEnumTransferType.Member_RongYao
            or transferId == LuaEnumTransferType.Member_ShenSheng
            or transferId == LuaEnumTransferType.Member_YongHeng
            or transferId == LuaEnumTransferType.Member_ZhiZun) then
        if (customData.type == nil) then
            customData.type = transferTbl:GetParams()
        end
    elseif (transferId == LuaEnumTransferType.ForgeIdentify) then
        if (customData.type == nil) then
            -- customData.type =
        end
    elseif (transferId == LuaEnumTransferType.ShareSell_Shelf) then
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.ShareStall
        end
        uiStaticParameter.curShareSellType = LuaEnumAuctionSelfSellType.Shelf
    elseif (transferId == LuaEnumTransferType.ShareSell_Stall) then
        if (customData.type == nil) then
            customData.type = luaEnumAuctionPanelType.ShareStall
        end
        uiStaticParameter.curShareSellType = LuaEnumAuctionSelfSellType.Stall
    elseif transferTbl ~= nil and transferTbl:GetPanels() == "UIShopPanel" and transferTbl:GetSpecialType() > 0 then
        if (customData.type == nil) then
            customData.type = transferTbl:GetSpecialType()
        end
        customData.chooseStore = {};
        table.insert(customData.chooseStore, tonumber(transferTbl:GetParams()));
    elseif (transferId == LuaEnumTransferType.Recast_HunYin) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.LingHunKeYin
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.LingHunKeYin
    elseif (transferId == LuaEnumTransferType.Recast_MianSha) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.MianSha
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.MianSha
    elseif (transferId == LuaEnumTransferType.Recast_HunYin) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.LingHunKeYin
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.LingHunKeYin
    elseif (transferId == LuaEnumTransferType.Recast_DengZuo) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.DengZuo
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.DengZuo
    elseif (transferId == LuaEnumTransferType.Recast_YuPei) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.YuPei
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.YuPei
    elseif (transferId == LuaEnumTransferType.Recast_BaoShi) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.BaoShi
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.BaoShi
    elseif (transferId == LuaEnumTransferType.Recast_MiBao) then
        if (customData.type == nil) then
            customData.type = LuaEnumRecastType.MiBao
        end
        uiStaticParameter.RecastChooseEquipIndex = LuaEnumRecastType.MiBao
    else
        --local data = clientTableManager.cfg_jumpManager:TryGetValue(transferId)
        --if (data ~= nil) then
        --    local SpecialType = data:GetSpecialType()
        --    ---跳转表格SpecialType字段==1的时候  是专门为了跳转到商会商店的跳转,并指向transferTable.params填写的商品
        --    ---跳转表格SpecialType字段==2的时候  是专门为了跳转到钻石商店的跳转,并指向transferTable.params填写的商品
        --    if SpecialType == 1 then
        --        if (customData.type == nil) then
        --            customData.type = LuaEnumStoreType.CommerceDiamond;
        --        end
        --        customData.chooseStore = {};
        --        table.insert(customData.chooseStore, tonumber(transferTable.params));
        --    elseif SpecialType == 2 then
        --        if (customData.type == nil) then
        --            customData.type = LuaEnumStoreType.Diamond;
        --        end
        --        customData.chooseStore = {};
        --        table.insert(customData.chooseStore, tonumber(transferTable.params));
        --    end
        --    ---specialType
        --end
    end
    return customData;
end

function UITransferManager:TryCreatePanel(panelName, customData, createPanelCallBack)
    local panel = uimanager:GetPanel(panelName);
    if (panel ~= nil and not CS.StaticUtility.IsNull(panel.go)) then
        panel:Show(customData);
    else
        uimanager:CreatePanel(panelName, function(panel)
            if (createPanelCallBack ~= nil) then
                createPanelCallBack(panel._PanelName)
            end
        end, customData);
    end
end

---跳转至合成界面
function UITransferManager:TransferToSynthesisPanel(bagItemInfo, callBack)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        if (bagItemInfo ~= nil) then
            --local transferId = LuaEnumTransferType.Synthesis_Role;
            --if (CS.CSScene.MainPlayerInfo.BagInfo.BagItems:ContainsKey(bagItemInfo.lid)) then
            --    transferId = LuaEnumTransferType.Synthesis_Bag;
            --elseif (CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid)) then
            --    transferId = LuaEnumTransferType.Synthesis_Role;
            --else
            --    transferId = LuaEnumTransferType.Synthesis_Servant;
            --end
            local customData = {};
            customData.bagItemInfo = bagItemInfo;
            self:TransferToPanel(LuaEnumTransferType.Synthesis_Role, customData, callBack);
        end
    end
end

---@public 跳转到魂装界面
---@param bagItemInfo bagV2.BagItemInfo
function UITransferManager:TransferToSoulEquipPanel(bagItemInfo, callBack)
    if (bagItemInfo ~= nil) then
        local customData = {};
        customData.equipInfo = bagItemInfo;
        customData.mMaterial = bagItemInfo
        local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
        if itemInfo ~= nil then
            if itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.HunZhuang then
                self:TransferToPanel(LuaEnumTransferType.SoulEquip, customData, callBack);
            elseif itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.XianZhuang then
                self:TransferToPanel(LuaEnumTransferType.XianQiEquip, customData, callBack);
            elseif itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.ShenQi then
                self:TransferToPanel(LuaEnumTransferType.ShenQiEquip, customData, callBack);
            end
        end

    end
end

---跳转到法宝界面
---@param chooseType LuaEnumMagicEquipSuitType 法宝套装类型
function UITransferManager:TransferToMagicEquipPanel(chooseType)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local customData = { ChooseType = chooseType }
        uimanager:CreatePanel("UIRolePanelTagPanel", nil, nil, function(panel)
            panel:MagicEquipBtnOnClick(nil, customData)
        end)
    end
end

---跳转到血继界面
---@param equipBloodSuitType LuaEquipBloodSuitType 血继装备类型
---@param bloodSuitItemType LuaEquipBloodSuitItemType 血继装备位下标类型
function UITransferManager:TransferToEquipBloodPanel(equipBloodSuitType, bloodSuitItemType)
    local transferId = 3400 + equipBloodSuitType
    self:TransferToPanel(transferId, { BloodSuitPos = bloodSuitItemType })
end

---跳转到鉴定界面
function UITransferManager:TransferToForgeIdentifyPanel(BagItemInfo, callBack)
    if BagItemInfo ~= nil then
        local customData = {};
        customData.bagItemInfo = BagItemInfo;
        self:TransferToPanel(LuaEnumTransferType.ForgeIdentify, customData, callBack)
    end
end

--endregion

--endregion

return UITransferManager;