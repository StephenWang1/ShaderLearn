---@class UIMemberTaskTemplate:TemplateBase 会员面板任务进度页签
local UIMemberTaskTemplate = {}

--region 初始化
function UIMemberTaskTemplate:Init()
    ---@type vipV2.VipMemberTask
    self:InitData()
    self:InitComponent()
    self:BindUIevents()
end

---@param taskinfo vipV2.VipMemberTask
---@param tableData TABLE.cfg_member_task
function UIMemberTaskTemplate:InitData(taskinfo, tableData)
    self.taskInfo = taskinfo
    self.tableData = tableData
end

function UIMemberTaskTemplate:InitComponent()
    self.Title = self:Get("Title", "Top_UILabel")
    self.btn_go = self:Get("btn_go", "GameObject")
    self.geted = self:Get("geted", "GameObject")
    self.diIcon = self:Get("di", "Top_UISprite")
end

function UIMemberTaskTemplate:BindUIevents()
    CS.UIEventListener.Get(self.btn_go).onClick = function(go)
        self:GoBtnOnClick(go)
    end
end

--endregion

--region 刷新面板
function UIMemberTaskTemplate:RefreshUI(isFinish)
    if (isFinish ~= nil) then
        self.state = isFinish
    else
        self.state = false
    end
    self:RefreshBtn()
    self:RefreshTitle()
end

---刷新按钮状态
function UIMemberTaskTemplate:RefreshBtn()
    if (self.state) then
        self.geted:SetActive(true)
        self.diIcon.alpha = 0.5
        self.btn_go:SetActive(false)
    else
        if (self.taskInfo.state == 1) then
            self.diIcon.alpha = 0.5
            self.geted:SetActive(true)
            self.btn_go:SetActive(false)
        else
            self.diIcon.alpha = 1
            self.geted:SetActive(false)
            if (self.tableData ~= nil and self.tableData:GetOpenWay() ~= nil) then
                self.btn_go:SetActive(true)
            else
                self.btn_go:SetActive(false)
            end
        end
    end
end

---刷新任务描述
function UIMemberTaskTemplate:RefreshTitle()
    if (self.state) then
        if (self.tableData ~= nil) then
            self.Title.text = string.format(self.tableData:GetDes(), "")
        end
    else
        if (self.tableData ~= nil) then
            if (self.tableData:GetType() == 1) then
                self.Title.text = self.tableData:GetDes()
            else
                local isfinish = self.taskInfo.process >= self.tableData:GetUseParam().list[1]
                self.Title.text = string.format(self.tableData:GetDes(), Utility.GetBBCode(isfinish) .. self.taskInfo.process .. "/")
            end
        end
    end
end
--endregion

--region 客户端事件
function UIMemberTaskTemplate:GoBtnOnClick(go)
    if self:IsShowTaskJump() then
        return
    end

    if  self:CheckJianDingCondition() then
        CS.Utility.ShowTips("功能尚未开启", 1.5, CS.ColorType.Red)
        return
    end


    if (self.tableData ~= nil) then
        local jumpType = self.tableData:GetOpenWay().list[1]
        local param = self.tableData:GetOpenWay().list[2]
        if (jumpType == 1) then
            networkRequest.ReqDeliverByConfig(param, false)
        elseif (jumpType == 2) then
            --点击关闭历法界面，寻路到对应npc，然后打开npc面板
            local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(param);
            if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                    self:OnJumpActivity(type, param);
                    uimanager:ClosePanel("UICalendarPanel");
                end)
                return
            end
        elseif (jumpType == 3) then
            local mapNpcId = CS.CSScene.MainPlayerInfo.MapInfoV2:GetLastMainCityMapNpcId(param);
            mapNpcId = mapNpcId == 0 and 341 or mapNpcId;
            local res = CS.CSScene.MainPlayerInfo.AsyncOperationController.CalendarFindNpcOperation:DoOperation(mapNpcId);
            if CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(res) < 0 then
                CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
                    self:OnJumpActivity(type, param);
                    uimanager:ClosePanel("UICalendarPanel");
                end)
                return
            end
        elseif (jumpType == 4) then
            local customData
            if #self.tableData:GetOpenWay().list >= 3 then
                local bookmarkIndex = self.tableData:GetOpenWay().list[3]
                customData = { index = bookmarkIndex }
            end
            uiTransferManager:TransferToPanel(param, customData)
        elseif (jumpType == 5) then
            Utility.TryTransfer(param)
        elseif (jumpType == 6) then
            uimanager:CreatePanel("UIMonsterArrestPanel", nil, { Group = param })
        elseif (jumpType == 7) then
            local pageSubType = self.tableData:GetOpenWay().list[3]
            uimanager:CreatePanel("UIBossPanel", nil, { type = param, subType = pageSubType })
        elseif (jumpType == 9) then
            Utility.ShowItemGetWay(tonumber(param), go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2.zero)
            return
        end
        uimanager:ClosePanel("UIRechargeMemberPanel")
    end
end
--endregion

function UIMemberTaskTemplate:IsShowTaskJump()
    if self.tableData == nil then
        return false
    end
    local dic = LuaGlobalTableDeal:GetHuiYuanTaskJumpIDDic()
    if dic == nil then
        return false
    end
    local id = self.tableData:GetId()
    local jump = dic[id]
    if jump ~= nil then
        local data = CS.Cfg_TaskJumpTableManager.Instance:GteMainMenuList_List(jump)
        uimanager:CreatePanel('UIRechargeMemberTipsPanel', nil, data, self.go.transform)
        return true
    end
    return false
end

--判断是否满足鉴定Condition
---@return boolean
function UIMemberTaskTemplate:CheckJianDingCondition()
    return self:CheckCondition(12,85)
end
---@param taskType number
---@param key number
function UIMemberTaskTemplate:CheckCondition(taskType, key)
    local tType=self.tableData :GetType()
    if(tType ~= taskType) then
        return false
    end

    local conditionS = clientTableManager.cfg_noticeManager:TryGetValue(key):GetOpenCondition()
    for i = 0, conditionS.list.Count-1 do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionS.list[i]) then
            return true
        end
    end
    return false
end


function ondestroy()

end

return UIMemberTaskTemplate