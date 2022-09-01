local UIGuildEnemyTemplate = {}

function UIGuildEnemyTemplate:Init(panel)
    self.panel = panel
    self:InitParam()
    self:BindUIEvent()
end

function UIGuildEnemyTemplate:InitParam()
    self.headIcon = self:Get("player", "Top_UISprite")
    self.level = self:Get("level", "Top_UILabel")
    self.time = self:Get("time", "Top_UILabel")
    self.desc = self:Get("decs", "Top_UILabel")
    self.enemyName = self:Get("NameTable/name", "Top_UILabel")
    self.enemyUnionName = self:Get("NameTable/guild", "Top_UILabel")
    self.revenge = self:Get("revenge", "GameObject")
    self.revengebtn = self:Get("btn_revenge", "GameObject")
    self.receivebtn = self:Get("btn_geted", "GameObject")
    self.NameTable = self:Get("NameTable", "Top_UITable")
end

function UIGuildEnemyTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.receivebtn).onClick = function(go)
        networkRequest.ReqRewardUnionRevenge(self.id)
    end

    CS.UIEventListener.Get(self.revengebtn).onClick = function(go)
        --uimanager:CreatePanel("UIGangTrackPromptPanel", nil, self.id)
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.killerid)
        else
            networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, self.killerid)
        end

        self.panel.RevengePointID = self.id
        self.panel.RevengePointGo = self.revengebtn
    end

    CS.UIEventListener.Get(self.headIcon.gameObject).onClick = function(go)
        if (self.killerid == CS.CSScene.MainPlayerInfo.ID) then
        else
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.UnionRevengePanel,
                roleId = self.killerid,
                roleName = self.killedRoleName,
                roleSex = self.revengeRoleSex,
                roleCareer = self.revengeRoleCareer,
            })
        end
    end

end

function UIGuildEnemyTemplate:Start()

end

---@param info unionV2.UnionRevenge
function UIGuildEnemyTemplate:Refresh(info)
    if (info == nil) then
        return
    end
    self.id = info.id
    self.killerid = info.revengeRoleId
    self.killedRoleName = info.killedRoleName
    self.revengeRoleSex = info.revengeRoleSex
    self.revengeRoleCareer = info.revengeRoleCareer
    self:SetRoleHeadIcon(info.revengeRoleSex, info.revengeRoleCareer)
    self.level.text = info.revengeRoleLevel
    self.time.text = CS.CSServerTime.StampToDateTimeForSecondToString("MM-dd", info.createTime)
    self.desc.text = "杀害" .. info.killedRoleName .. "，血海深仇，不共戴天"
    self.enemyName.text = "[FF0000]" .. info.revengeRoleName
    self.enemyUnionName.text = "[ed6328]" .. info.revengeRoleUnionName
    if (self.NameTable ~= nil) then
        self.NameTable:Reposition()
    end
    if (info.revengeType == 0) then
        self.revengebtn:SetActive(true)
        self.revenge:SetActive(false)
        self.receivebtn:SetActive(false)
    elseif (info.revengeType == 1) then
        if (info.canReward == 0) then
            self.revengebtn:SetActive(false)
            self.revenge:SetActive(true)
            self.receivebtn:SetActive(false)
        else
            self.revengebtn:SetActive(false)
            self.revenge:SetActive(false)
            self.receivebtn:SetActive(true)

        end
    end
end

function UIGuildEnemyTemplate:SetRoleHeadIcon(sex, career)
    self.sex = sex;
    self.career = career;
    self.headIcon.spriteName = "headicon" .. sex .. career
    if (self.info ~= nil) then
        if (self.info.isOnline) then
            self.icon_UISprite.color = CS.UnityEngine.Color.white
        else
            self.icon_UISprite.color = CS.UnityEngine.Color.black
        end
    end
end

function UIGuildEnemyTemplate:OnDestroy()

end

return UIGuildEnemyTemplate