local UITeamTipTemplate = {}
UITeamTipTemplate.TeamTips_GameObject = nil
UITeamTipTemplate.MissionPanel = nil
UITeamTipTemplate.TeamTipsBt1_GameObject = nil
UITeamTipTemplate.TeamTipsBt2_GameObject = nil
UITeamTipTemplate.TeamTipsBt1_UILabel = nil
UITeamTipTemplate.TeamTipsBt2_UILabel = nil
UITeamTipTemplate.SelectItem = nil

function UITeamTipTemplate:Init()
    UITeamTipTemplate.MissionPanel = uimanager:GetPanel("UIMissionPanel")
    UITeamTipTemplate.TeamTips_GameObject = self.go
    UITeamTipTemplate.TeamTipsBt1_GameObject = self:Get("bt_1", "GameObject")
    UITeamTipTemplate.TeamTipsBt2_GameObject = self:Get("bt_2", "GameObject")
    UITeamTipTemplate.TeamTipsBt1_UILabel = self:Get("bt_1/Label", "UILabel")
    UITeamTipTemplate.TeamTipsBt2_UILabel = self:Get("bt_2/Label", "UILabel")
    CS.UIEventListener.Get(self.go).onClick = UITeamTipTemplate.CloseTeamTips
    self:SetDepth()
end

function UITeamTipTemplate:SetDepth()
    local panel = CS.Utility_Lua.GetComponent(self.go.gameObject, "UIWidget")
    if panel ~= nil then
        panel.depth = 6
    end
end

--region
function UITeamTipTemplate.OnOperationPanel(go)
    UITeamTipTemplate.TeamTips_GameObject.gameObject:SetActive(true)
    UITeamTipTemplate.SelectItem = UITeamTipTemplate.MissionPanel.QuickTeam.ShortcutTeamList[go.transform.parent.gameObject].data
    local bt1_Obj = UITeamTipTemplate.TeamTipsBt1_GameObject
    local bt2_Obj = UITeamTipTemplate.TeamTipsBt2_GameObject
    CS.UIEventListener.Get(bt1_Obj).onClick = nil
    CS.UIEventListener.Get(bt2_Obj).onClick = nil
    local GroupInfo = CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo
    bt2_Obj.gameObject:SetActive(false);
    if GroupInfo == nil then
        print("GroupInfo为Nil，请检查")
        return
    end
    if GroupInfo.leader.roleId == CS.CSScene.MainPlayerInfo.ID then
        --当自己是队长时
        if UITeamTipTemplate.SelectItem.roleId == CS.CSScene.MainPlayerInfo.ID then
            bt2_Obj.gameObject:SetActive(true);
            UITeamTipTemplate.TeamTipsBt1_UILabel.text = "解散队伍"
            UITeamTipTemplate.TeamTipsBt2_UILabel.text = "退出队伍"
            CS.UIEventListener.Get(bt1_Obj).onClick = UITeamTipTemplate.DissolveTeam
            CS.UIEventListener.Get(bt2_Obj).onClick = UITeamTipTemplate.QuitTeam
        else
            bt2_Obj.gameObject:SetActive(true);
            UITeamTipTemplate.TeamTipsBt1_UILabel.text = "转让队长"
            UITeamTipTemplate.TeamTipsBt2_UILabel.text = "踢出队伍"
            CS.UIEventListener.Get(bt1_Obj).onClick = UITeamTipTemplate.TransferCaptain
            CS.UIEventListener.Get(bt2_Obj).onClick = UITeamTipTemplate.QuitTeam
        end
    else
        --当自己不是队长时
        if UITeamTipTemplate.SelectItem.roleId == CS.CSScene.MainPlayerInfo.ID then
            UITeamTipTemplate.TeamTipsBt1_UILabel.text = "退出队伍"
            CS.UIEventListener.Get(bt1_Obj).onClick = UITeamTipTemplate.QuitTeam
        else
            UITeamTipTemplate.TeamTipsBt1_UILabel.text = "查看资料"

            CS.UIEventListener.Get(bt1_Obj).onClick = UITeamTipTemplate.LookData
        end

    end
end

---查看资料
function UITeamTipTemplate.LookData()
    UITeamTipTemplate.TeamTips_GameObject.gameObject:SetActive(false)
end

---解散队伍
function UITeamTipTemplate.DissolveTeam()
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqShareDissolveGroup();
    else
        networkRequest.ReqDissolveGroup()
    end
    UITeamTipTemplate.TeamTips_GameObject.gameObject:SetActive(false)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:QuitTeam()
    UITeamTipTemplate.MissionPanel.OnResGroupDetailedInfoMessage(0)
end

---退出队伍
function UITeamTipTemplate.QuitTeam()
    if UITeamTipTemplate.SelectItem ~= nil then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareExitGroup(UITeamTipTemplate.SelectItem.roleId)
        else
            networkRequest.ReqExitGroup(UITeamTipTemplate.SelectItem.roleId)
        end
    end
    UITeamTipTemplate.TeamTips_GameObject.gameObject:SetActive(false)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:QuitTeam()
    UITeamTipTemplate.MissionPanel.OnResGroupDetailedInfoMessage(0)
end

---转让队长
function UITeamTipTemplate.TransferCaptain()
    if UITeamTipTemplate.SelectItem ~= nil then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqShareChangeCaptain(UITeamTipTemplate.SelectItem.roleId)
        else
            networkRequest.ReqChangeCaptain(UITeamTipTemplate.SelectItem.roleId)
        end
    end
    UITeamTipTemplate.TeamTips_GameObject.gameObject:SetActive(false)
    UITeamTipTemplate.MissionPanel.OnResGroupDetailedInfoMessage(1)
end



--endregion
---关闭TeamTips面板
function UITeamTipTemplate:CloseTeamTips()
    self.gameObject:SetActive(false)
end

function UITeamTipTemplate:OnDestroy()
    UITeamTipTemplate.MissionPanel = nil
    UITeamTipTemplate.TeamTips_GameObject = nil
    UITeamTipTemplate.TeamTipsBt1_GameObject = nil
    UITeamTipTemplate.TeamTipsBt2_GameObject = nil
    UITeamTipTemplate.TeamTipsBt1_UILabel = nil
    UITeamTipTemplate.TeamTipsBt2_UILabel = nil
end

return UITeamTipTemplate