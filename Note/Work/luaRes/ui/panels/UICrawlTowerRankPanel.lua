---@class UICrawlTowerRankPanel:UIBase 闯天关排行榜
local UICrawlTowerRankPanel = {}

--region 组件
---@return UnityEngine.GameObject 关闭按钮
function UICrawlTowerRankPanel:GetCloseBtn_Go()
    if self.mCloseBtnGo == nil then
        self.mCloseBtnGo = self:GetCurComp("WidgetRoot/view/RankView/event/CloseBtn", "GameObject")
    end
    return self.mCloseBtnGo
end

---@return UILoopScrollViewPlus 循环组件
function UICrawlTowerRankPanel:GetRankLoop()
    if self.mRankLoop == nil then
        self.mRankLoop = self:GetCurComp("WidgetRoot/view/RankView/view/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")
    end
    return self.mRankLoop
end

---@return UIScrollView
function UICrawlTowerRankPanel:GetScrollView()
    if self.mScrollView == nil then
        self.mScrollView = self:GetCurComp("WidgetRoot/view/RankView/view/Scroll View", "UIScrollView")
    end
    return self.mScrollView
end
--endregion

--region 初始化
function UICrawlTowerRankPanel:Init()
    self:BindEvent()
    self:BindMessage()
    self:GetScrollView().onDragStarted = function()
        self:CloseCurrentChoose()
    end

    --[[
    --这个方法消息会绑定不上去，原因不明
    if self:GetScrollView().onDragStarted == nil then

    else
        self:GetScrollView().onDragStarted('+', function()
            print("开始滑动")
            self:CloseCurrentChoose()
        end)
    end
    --]]
end

function UICrawlTowerRankPanel:Show()
    networkRequest.ReqLookRank(21)
end

function UICrawlTowerRankPanel:BindEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end
end

function UICrawlTowerRankPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResLookRankMessage, function(id, data)
        self:OnResLookRankMessageCallback(id, data)
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCommonMessage, function(msgId, serverData)
        self:OnCommentMessage(msgId, serverData)
    end)
end
--endregion

--region 刷新排行榜
---@param data rankV2.ResLookRank
function UICrawlTowerRankPanel:OnResLookRankMessageCallback(id, data)
    if data then
        self:RefreshRank(data)
    end
end

---@param datas rankV2.ResLookRank
function UICrawlTowerRankPanel:RefreshRank(datas)
    ---@type table<number,UICrawlTowerRankPanel_RankTemplate>
    self.mLidToTemplate = {}
    if datas == nil then
        return
    end

    local rankInfos = datas.roleRankDataInfos
    if rankInfos then
        self:GetRankLoop():Init(function(go, line)
            if line < #rankInfos then
                local template = self:GetRankTemplate(go)
                if template then
                    template:RefreshSingleRank(rankInfos[line + 1], line, datas.ranking)
                    local lid = rankInfos[line + 1].roleRankInfo.uid
                    self.mLidToTemplate[lid] = template
                    template:ChooseItem(lid == self.mCurrentChooseLid)
                    return true
                else
                    return false
                end
            else
                return false
            end
        end, nil)
    end
end

---@return UICrawlTowerRankPanel_RankTemplate
function UICrawlTowerRankPanel:GetRankTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICrawlTowerRankPanel_RankTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

---点击排行信息
---@param rankInfo rankV2.RoleRankDataInfo
function UICrawlTowerRankPanel:ChooseItem(rankInfo)
    if self.mLidToTemplate then
        self:CloseCurrentChoose()
        local lid = rankInfo.roleRankInfo.uid
        local template = self.mLidToTemplate[lid]
        if template then
            template:ChooseItem(true)
            self.mCurrentChooseLid = lid
            self.mCurrentChooseRankInfo = rankInfo
            if rankInfo.roleRankInfo.uid == CS.CSScene.MainPlayerInfo.ID then
                Utility.ShowPopoTips(template:GetName_Lb().gameObject, nil, 308, "UIRankPanel")
                return
            end
            if luaclass.RemoteHostDataClass:IsKuaFuMap() then
                networkRequest.ReqShareCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, rankInfo.roleRankInfo.uid)
            else
                networkRequest.ReqCommon(luaEnumReqServerCommonType.PlayIsOnLine, nil, nil, rankInfo.roleRankInfo.uid)
            end
        end
    end
end

function UICrawlTowerRankPanel:CloseCurrentChoose()
    if self.mCurrentChooseLid then
        if self.mLidToTemplate then
            local template = self.mLidToTemplate[self.mCurrentChooseLid]
            if template then
                template:ChooseItem(false)
            end
            self.mCurrentChooseLid = nil
            self.mCurrentChooseRankInfo = nil
        end
    end
end

function UICrawlTowerRankPanel:OnCommentMessage(msgId, serverData)
    if serverData and serverData.type == luaEnumRspServerCommonType.PlayIsOnLine then
        if self.mCurrentChooseRankInfo == nil then
            return
        end
        if serverData.data == nil or serverData.data64 == nil or serverData.data64 ~= self.mCurrentChooseLid then
            return
        end
        ---不在线
        if serverData.data == 0 then
            local template = self.mLidToTemplate[self.mCurrentChooseLid]
            if template then
                Utility.ShowPopoTips(template.go, nil, 268, "UIRankPanel")
            end
            ---在线
        elseif serverData.data == 1 then
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = LuaEnumPanelIDType.RankPanel_RoleInfo,
                roleId = self.mCurrentChooseLid,
                roleName = self.mCurrentChooseRankInfo.roleRankInfo.name,
                roleSex = self.mCurrentChooseRankInfo.roleRankInfo.sex,
                roleCareer = self.mCurrentChooseRankInfo.roleRankInfo.career
            })
        end
    end
end
--endregion

return UICrawlTowerRankPanel