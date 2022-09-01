---快捷组队
---@class UIShortcutTeamTemplates
local UIShortcutTeamTemplates = {}

UIShortcutTeamTemplates.MissionPanel = nil
UIShortcutTeamTemplates.SelectItem = nil
function UIShortcutTeamTemplates:Data()
    return self.data
end
---队伍图标
function UIShortcutTeamTemplates:Bg_GameObject()
    if self.mBG == nil then
        self.mBG = self:Get("bg", "GameObject")
    end
    return self.mBG
end

---职业图标
function UIShortcutTeamTemplates:Sp_tubiao_UISprite()
    if self.mSp_tubiao == nil then
        self.mSp_tubiao = self:Get("sp_tubiao", "UISprite")
    end
    return self.mSp_tubiao
end

---名称
function UIShortcutTeamTemplates:Lb_name_UILabel()
    if self.mLb_name == nil then
        self.mLb_name = self:Get("lb_name", "UILabel")
    end
    return self.mLb_name
end

---添加按钮
function UIShortcutTeamTemplates:Btn_add_GameObject()
    if self.mBtn_add == nil then
        self.mBtn_add = self:Get("btn_add", "GameObject")
    end
    return self.mBtn_add
end

---添加按钮信息图片
function UIShortcutTeamTemplates:Btn_Sprite_UISprite()
    if self.mBtn_Sprite == nil then
        self.mBtn_Sprite = self:Get("btn_add/Sprite", "UISprite")
    end
    return self.mBtn_Sprite
end

---旗子
function UIShortcutTeamTemplates:Flag_GameObject()
    if self.mFlag == nil then
        self.mFlag = self:Get("Flag", "GameObject")
    end
    return self.mFlag
end

function UIShortcutTeamTemplates:GetPlayerHP_GameObject()
    if (self.mPlayerHP_GameObject == nil) then
        self.mPlayerHP_GameObject = self:Get("hp", "GameObject");
    end
    return self.mPlayerHP_GameObject;
end

function UIShortcutTeamTemplates:GetPlayerHPEffect_GameObject()
    if (self.mPlayerHPEffect_GameObject == nil) then
        self.mPlayerHPEffect_GameObject = self:Get("hp/Thumb/effect", "GameObject");
    end
    return self.mPlayerHPEffect_GameObject;
end

function UIShortcutTeamTemplates:GetPlayerHPValue_Text()
    if (self.mPlayerHPValue_Text == nil) then
        self.mPlayerHPValue_Text = self:Get("hp/rolehpvalue", "UILabel");
    end
    return self.mPlayerHPValue_Text;
end

function UIShortcutTeamTemplates:GetPlayerHP_UISlider()
    if (self.mPlayerHP_UISlider == nil) then
        self.mPlayerHP_UISlider = self:Get("hp", "UISlider");
    end
    return self.mPlayerHP_UISlider;
end

---刷新数据
function UIShortcutTeamTemplates:Refresh(data, IsCanTeam)
    self.data = data
    self:ClosTexture()
    if IsCanTeam == false then
        self:NoTeam(data)
    else
        self:TeamInfo(data)
    end
end

---没有队伍
function UIShortcutTeamTemplates:NoTeam(data)

    self:Btn_add_GameObject().gameObject:SetActive(true)
    self:Lb_name_UILabel().text = data
    if data == "附近队伍" then
        self:Btn_Sprite_UISprite().spriteName = 'search'
        CS.UIEventListener.Get(self:Bg_GameObject()).onClick = UIShortcutTeamTemplates.NearTeam
    elseif data == "创建队伍" then
        self:Btn_Sprite_UISprite().spriteName = '+'
        CS.UIEventListener.Get(self:Bg_GameObject()).onClick = UIShortcutTeamTemplates.CreatTeam
    end
end

---队伍信息
function UIShortcutTeamTemplates:TeamInfo(data)
    self.mPlayerData = data;
    if (self.mPlayerData ~= nil) then
        local leader = ""

        local GroupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo
        if GroupInfo ~= nil then
            if data.roleId == GroupInfo.leader.roleId then
                -- self:Flag_GameObject().gameObject:SetActive(true)
                leader = luaEnumColorType.Green1 .. "[队长]"
            end
        end

        self:Sp_tubiao_UISprite().gameObject:SetActive(true)
        self:Sp_tubiao_UISprite().spriteName = UIShortcutTeamTemplates.GetCareerName(data.career)
        self:Lb_name_UILabel().text = data.roleName .. leader

    end
end

function UIShortcutTeamTemplates:ClosTexture()
    self:Flag_GameObject().gameObject:SetActive(false)
    self:Btn_add_GameObject().gameObject:SetActive(false)
    self:Sp_tubiao_UISprite().gameObject:SetActive(false)
    self:Btn_add_GameObject().gameObject:SetActive(false)
end

---得到职业对应的图标名称
function UIShortcutTeamTemplates.GetCareerName(career)
    if (career ~= nil) then
        return "teamjob_" .. career;
    end
    return "";
end

---附近队伍
function UIShortcutTeamTemplates.NearTeam()
    uimanager:CreatePanel('UITeamPanel', UIShortcutTeamTemplates.CreatUITeamPanelNearTeamCallBack)
end

---创建队伍
function UIShortcutTeamTemplates.CreatTeam()
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareCreatGroup()
    else
        networkRequest.ReqCreatGroup()
    end
end

---邀请玩家
function UIShortcutTeamTemplates.InvitedPlayers()
    uimanager:CreatePanel('UITeamPanel')
end

function UIShortcutTeamTemplates:OnOperationPanel()
    --UIShortcutTeamTemplates.MissionPanel.QuickTeamTip.OnOperationPanel(go)
    if (self.mPlayerData ~= nil) then
        local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain;
        local type = isCaptain and LuaEnumPanelIDType.TeamPanel_MyTeamPanel or LuaEnumPanelIDType.TeamPanel_Members;

        uimanager:CreatePanel("UIGuildTipsPanel", nil, {
            panelType = type,
            roleId = self.mPlayerData.roleId,
            roleName = self.mPlayerData.roleName,
            roleSex = self.mPlayerData.sex,
            roleCareer = self.mPlayerData.career,
            teamData = self.mPlayerData
        })

    end
end

function UIShortcutTeamTemplates:UpdatePlayerHp()
    if (self.mPlayerData ~= nil) and CS.CSScene.MainPlayerInfo then
        local teamPlayerHpInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2:GetTeamPlayerHpInfo(self.mPlayerData.roleId)
        if (teamPlayerHpInfo ~= nil) then
            if CS.StaticUtility.IsNull(self:GetPlayerHPValue_Text()) == false then
                self:GetPlayerHPValue_Text().text = teamPlayerHpInfo.hp .. "/" .. teamPlayerHpInfo.maxHp;
            end
            if CS.StaticUtility.IsNull(self:GetPlayerHP_UISlider()) == false then
                self:GetPlayerHP_UISlider().value = teamPlayerHpInfo.hp / teamPlayerHpInfo.maxHp;
            end
            if CS.StaticUtility.IsNull(self:GetPlayerHPEffect_GameObject()) == false and CS.StaticUtility.IsNull(self:GetPlayerHP_UISlider()) == false then
                self:GetPlayerHPEffect_GameObject():SetActive(self:GetPlayerHP_UISlider().value > 0.1);
            end
        end
    end
end

--region CallFunction

function UIShortcutTeamTemplates:OnResTeamPlayerHpMessage(msdId, msgData)
    self:UpdatePlayerHp();
end

function UIShortcutTeamTemplates:OnResTeamAllMemHpInfoMessage(msdId, msgData)
    self:UpdatePlayerHp();
end

--endregion
---@param panel
function UIShortcutTeamTemplates:Init()
    ---@type UIMissionPanel
    self.MissionPanel = uimanager:GetPanel("UIMissionPanel")
end

function UIShortcutTeamTemplates:Start()
    self:InitEvents();
end

function UIShortcutTeamTemplates:InitEvents()
    --region NetEvents
    if (self.CallOnResTeamPlayerHpMessage == nil) then
        self.CallOnResTeamPlayerHpMessage = function(msdId, msgData)
            self:OnResTeamPlayerHpMessage(msdId, msgData);
        end
    end

    if (self.CallOnResTeamAllMemHpInfoMessage == nil) then
        self.CallOnResTeamAllMemHpInfoMessage = function(msgId, msgData)
            self:OnResTeamAllMemHpInfoMessage(msgId, msgData);
        end
    end

    if self.MissionPanel then
        self.MissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTeamPlayerHpMessage, self.CallOnResTeamPlayerHpMessage)
        self.MissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareTeamPlayerHpMessage, self.CallOnResTeamPlayerHpMessage)
        self.MissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTeamAllMemHpInfoMessage, self.CallOnResTeamAllMemHpInfoMessage)
        self.MissionPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResShareTeamAllMemHpInfoMessage, self.CallOnResTeamAllMemHpInfoMessage)
    end

    --endregion
    CS.UIEventListener.Get(self:Bg_GameObject()).onClick = function()
        self:OnOperationPanel();
    end;
end

function UIShortcutTeamTemplates:RemoveEvents()
    if self.MissionPanel then
        self.MissionPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResTeamPlayerHpMessage, self.CallOnResTeamPlayerHpMessage)
        self.MissionPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResShareTeamPlayerHpMessage, self.CallOnResTeamPlayerHpMessage)
        self.MissionPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResTeamAllMemHpInfoMessage, self.CallOnResTeamAllMemHpInfoMessage)
        self.MissionPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResShareTeamAllMemHpInfoMessage, self.CallOnResTeamAllMemHpInfoMessage)
    end
end

function UIShortcutTeamTemplates:OnDestroy()
    self:RemoveEvents();
end

return UIShortcutTeamTemplates