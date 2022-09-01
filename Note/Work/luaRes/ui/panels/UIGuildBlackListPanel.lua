---@class UIGuildBlackListPanel:UIBase 行会黑名单界面
local UIGuildBlackListPanel = {}

--region 组件
---关闭按钮
function UIGuildBlackListPanel.GetCloseButton_GameObject()
    if UIGuildBlackListPanel.mCloseButton == nil then
        UIGuildBlackListPanel.mCloseButton = UIGuildBlackListPanel:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return UIGuildBlackListPanel.mCloseButton
end

---黑名单Container
function UIGuildBlackListPanel:GetGridList_UILoopScrollViewPlus()
    if self.mGridList == nil then
        self.mGridList = UIGuildBlackListPanel:GetCurComp("WidgetRoot/ScrollView/GuildList", "UILoopScrollViewPlus")
    end
    return self.mGridList
end

---@return UnityEngine.GameObject 空黑名单显示
function UIGuildBlackListPanel:GetNullShow_Go()
    if self.mNullShow == nil then
        self.mNullShow = self:GetCurComp("WidgetRoot/NoBlacklist", "GameObject")
    end
    return self.mNullShow
end
--endregion

--region 初始化
function UIGuildBlackListPanel:Init()
    self:BindMessage()
    self:BindEvents()
end

function UIGuildBlackListPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetBlackApplyRoleMessage, UIGuildBlackListPanel.OnResGetBlackApplyRoleMessageReceived)
end

function UIGuildBlackListPanel:BindEvents()
    CS.UIEventListener.Get(UIGuildBlackListPanel.GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

--region 服务器事件
---收到黑名单列表消息
---@param tblData unionV2.ResGetBlackApplyRole
function UIGuildBlackListPanel.OnResGetBlackApplyRoleMessageReceived(msgId, tblData, csData)
    if tblData and tblData.blackApplyRole then
        local blackList = tblData.blackApplyRole
        if blackList then
            UIGuildBlackListPanel:GetNullShow_Go():SetActive(#blackList == 0)
            UIGuildBlackListPanel:GetGridList_UILoopScrollViewPlus().gameObject:SetActive(true)
            UIGuildBlackListPanel:GetGridList_UILoopScrollViewPlus():Init(function(go, line)
                if line < #blackList then
                    ---@type unionV2.blackApplyInfo
                    local info = blackList[line + 1]
                    UIGuildBlackListPanel:RefreshSingleGrid(go, info)
                    return true
                else
                    return false
                end
            end, nil)
        end
    else
        UIGuildBlackListPanel:GetGridList_UILoopScrollViewPlus().gameObject:SetActive(false)
        UIGuildBlackListPanel:GetNullShow_Go():SetActive(true)
    end
end

function UIGuildBlackListPanel:RefreshSingleGrid(item, info)
    --名字
    local nameLabel = CS.Utility_Lua.GetComponent(item.transform:Find("lb_name"), "UILabel")
    if nameLabel then
        nameLabel.text = "[c9b39c]" .. info.roleName
    end
    --职业
    local careerLabel = CS.Utility_Lua.GetComponent(item.transform:Find("sp_career"), "UISprite")
    if careerLabel then
        local sprite = ""
        if info.career == LuaEnumCareer.Master then
            sprite = "3"
        elseif info.career == LuaEnumCareer.Taoist then
            sprite = "3-1"
        elseif info.career == LuaEnumCareer.Warrior then
            sprite = "3-2"
        end
        careerLabel.spriteName = sprite
    end
    --头像
    local icon = CS.Utility_Lua.Get(item.transform, ("headframe/head"), "UISprite")
    if not CS.StaticUtility.IsNull(icon) and info.sex and info.career then
        icon .spriteName = Utility.GetPlayerHeadIconSpriteName(info.sex, info.career)
    end
    --等级
    local levelLabel = CS.Utility_Lua.GetComponent(item.transform:Find("lb_level"), "UILabel")
    if levelLabel then
        levelLabel.text = "Lv." .. tostring(info.level)
    end

    --移除
    local removeGo = CS.Utility_Lua.Get(item.transform, "lb_delete", "GameObject")
    CS.UIEventListener.Get(removeGo).onClick = function()
        networkRequest.ReqRemoveBlackApplyRole(info.roleId)
    end
end
--endregion

return UIGuildBlackListPanel