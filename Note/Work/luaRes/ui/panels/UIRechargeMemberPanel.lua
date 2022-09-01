local UIRechargeMemberPanel = {}

--region 局部变量
---@return LuaMemberInfo
function UIRechargeMemberPanel:GetLuaMemberInfo()
    return gameMgr:GetPlayerDataMgr():GetLuaMemberInfo()
end

---@return TABLE.cfg_member
function UIRechargeMemberPanel:GetCurMemberTableData()
    return self:GetLuaMemberInfo():GetCurLevelMemberTableData()
end

function UIRechargeMemberPanel:GetCurChooseMemberTableData()
    self.curChooseMemberTableData = clientTableManager.cfg_memberManager:TryGetValue(self.mCurChooseLevel)
    if (self.curChooseMemberTableData ~= nil) then
        return self.curChooseMemberTableData
    end
end
--endregion

--region 组件
---左侧会员页签
function UIRechargeMemberPanel:GetBookMark_GridContainer()
    if (self.mBookMarkGrid == nil) then
        self.mBookMarkGrid = self:GetCurComp("WidgetRoot/view/BookMark/BookMark", "Top_UIGridContainer")
    end
    return self.mBookMarkGrid
end

---每日奖励
function UIRechargeMemberPanel:GetDailyReward_GridContainer()
    if (self.mDailyRewardGrid == nil) then
        self.mDailyRewardGrid = self:GetCurComp("WidgetRoot/view/DailyRewardList", "Top_UIGridContainer")
    end
    return self.mDailyRewardGrid
end

---对应会员礼包奖励
function UIRechargeMemberPanel:GetMemberGiftReward_GridContainer()
    if (self.mMemberGiftRewardGrid == nil) then
        self.mMemberGiftRewardGrid = self:GetCurComp("WidgetRoot/view/MemberPrivilege/MemberGift/ScrollView/reward", "Top_UIGridContainer")
    end
    return self.mMemberGiftRewardGrid
end

---对应会员礼包奖励
function UIRechargeMemberPanel:GetMemberPrivilege_ScrollView()
    if (self.mMemberPrivilegeScrollView == nil) then
        self.mMemberPrivilegeScrollView = self:GetCurComp("WidgetRoot/view/MemberPrivilege/ScrollView", "Top_UIScrollView")
    end
    return self.mMemberPrivilegeScrollView
end

---关闭按钮
function UIRechargeMemberPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---领取奖励按钮
function UIRechargeMemberPanel:GetRechargeBtn_GameObject()
    if (self.mRechargeBtn == nil) then
        self.mRechargeBtn = self:GetCurComp("WidgetRoot/events/btn_recharge", "GameObject")
    end
    return self.mRechargeBtn
end

---升级会员按钮文本
function UIRechargeMemberPanel:GetRechargeBtnLabel()
    if (self.mRechargeBtnLabel == nil) then
        self.mRechargeBtnLabel = self:GetCurComp("WidgetRoot/events/btn_recharge/Background/Label", "Top_UILabel")
    end
    return self.mRechargeBtnLabel
end

---领取特权礼包按钮
function UIRechargeMemberPanel:GetGetPrivilegeRewardBtn_GameObject()
    if (self.mGetPrivilegeRewardBtn == nil) then
        self.mGetPrivilegeRewardBtn = self:GetCurComp("WidgetRoot/view/MemberPrivilege/MemberGift/btn_get", "GameObject")
    end
    return self.mGetPrivilegeRewardBtn
end

---特权列表
function UIRechargeMemberPanel:GetPrivilege_GridContainer()
    if (self.mPrivilegeGrid == nil) then
        self.mPrivilegeGrid = self:GetCurComp("WidgetRoot/view/MemberPrivilege/ScrollView/grid", "Top_UIGridContainer")
    end
    return self.mPrivilegeGrid
end

---特权标题
function UIRechargeMemberPanel:GetPrivilegeTitle_UISprite()
    if (self.mPrivilegeTitle == nil) then
        self.mPrivilegeTitle = self:GetCurComp("WidgetRoot/view/MemberPrivilege/lb_title", "Top_UISprite")
    end
    return self.mPrivilegeTitle
end

---礼包标题
function UIRechargeMemberPanel:GetGiftTitle_UILabel()
    if (self.mGiftgeTitle == nil) then
        self.mGiftgeTitle = self:GetCurComp("WidgetRoot/view/MemberPrivilege/lb_gift/Label", "Top_UILabel")
    end
    return self.mGiftgeTitle
end

---升级目标标题
function UIRechargeMemberPanel:GetTaskTitle_UISprite()
    if (self.mTaskTitle == nil) then
        self.mTaskTitle = self:GetCurComp("WidgetRoot/view/MemberUpLevel/lb_title/Sprite", "Top_UISprite")
    end
    return self.mTaskTitle
end

---按钮下方会员文本
function UIRechargeMemberPanel:GetRecharge_UILabel()
    if (self.mRecharge_UILabel == nil) then
        self.mRecharge_UILabel = self:GetCurComp("WidgetRoot/view/rechargeDes", "UILabel")
    end
    return self.mRecharge_UILabel
end

---隐藏下级任务tips
function UIRechargeMemberPanel:GetNexttips_GameObject()
    if (self.mNexttips == nil) then
        self.mNexttips = self:GetCurComp("WidgetRoot/view/MemberUpLevel/nexttips", "GameObject")
    end
    return self.mNexttips
end

function UIRechargeMemberPanel:GetMissionView_LoopScrollView()
    if (self.mMissionViewLoop == nil) then
        self.mMissionViewLoop = self:GetCurComp("WidgetRoot/view/MemberUpLevel/TaskScrollView/missionView", "UILoopScrollViewPlus");
    end
    return self.mMissionViewLoop
end

function UIRechargeMemberPanel:GetHasgot_GameObject()
    if (self.hasgotGo == nil) then
        self.hasgotGo = self:GetCurComp("WidgetRoot/view/MemberPrivilege/MemberGift/has_got", "GameObject")
    end
    return self.hasgotGo
end
--endregion

--region 初始化
function UIRechargeMemberPanel:Init()
    self.curChooseMemberTableData = self:GetCurMemberTableData()
    self.mCurChooseLevel = 0
    --self:SetFirstChooseLevel()
    self.mBookMarkPageDic = {}
    self.mMemberTaskDic = {}
    self:BindMessage()
    self:BindUIEvents()
end

function UIRechargeMemberPanel:BindMessage()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResVipMemberInfoMessage, function()
        self:RefreshUIPanel()
    end)
end

function UIRechargeMemberPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function(go)
        self:CloseBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetGetPrivilegeRewardBtn_GameObject()).onClick = function(go)
        self:GetLevelRewardBtnOnClick()
    end

    CS.UIEventListener.Get(self:GetRechargeBtn_GameObject()).onClick = function(go)
        self:GetRechargeBtnOnClick()
    end
end

---@class MemberPanelParams
---@field type number 页签类型
---@param customData MemberPanelParams
function UIRechargeMemberPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    if (customData.type ~= nil) then
        self.mCurChooseLevel = customData.type;
        --else
        --    self:SetFirstChooseLevel();
    end
    networkRequest.ReqVipMemberInfo()
end

function UIRechargeMemberPanel:SetFirstChooseLevel()
    self.mCurChooseLevel = self:GetLuaMemberInfo():GetPlayerMemberLevel() == 0 and 1 or self:GetLuaMemberInfo():GetPlayerMemberLevel() + 1
    if (self.mCurChooseLevel > #clientTableManager.cfg_memberManager.dic) then
        self.mCurChooseLevel = #clientTableManager.cfg_memberManager.dic
    end
    for i = 1, self.mCurChooseLevel - 1 do
        if (Utility.IsContainsValue(self:GetLuaMemberInfo():GetPlayerMemberInfo().receivedLevelReward, i) == false) then
            self.mCurChooseLevel = i
            return
        end
    end
end
--endregion

--region 界面刷新
function UIRechargeMemberPanel:RefreshUIPanel()
    self:SetFirstChooseLevel()
    self:RefreshMemberPage()
    self:RefreshShowPanel()
end

function UIRechargeMemberPanel:RefreshShowPanel()
    self:RefreshDailyReward()
    self:RefreshPrivilegeDes()
    self:RefreshPrivilegeTitle()
    self:RefreshPrivilegeReward()
    self:RefreshPrivilegeTaskDes()
    self:RefreshRechargeBtnLabel()
end

---刷新左侧会员页签
function UIRechargeMemberPanel:RefreshMemberPage()
    local count = #clientTableManager.cfg_memberManager.dic
    self:GetBookMark_GridContainer().MaxCount = count
    for i = 0, count - 1 do
        local go = self:GetBookMark_GridContainer().controlList[i];
        if (self.mBookMarkPageDic[go] == nil) then
            self.mBookMarkPageDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMemberPageTemplate, self, clientTableManager.cfg_memberManager:TryGetValue(i + 1));
        end
        if (i + 1 == self.mCurChooseLevel) then
            self.mBookMarkPageDic[go]:SetDefeaultChoose()
        end
        self.mBookMarkPageDic[go]:RefreshUI()
    end
end

---刷新每日奖励
function UIRechargeMemberPanel:RefreshDailyReward()
    local DailyReward = self:GetCurMemberTableData():GetDailyReward()
    if (DailyReward == nil) then
        return
    end

    local count = 1
    if (DailyReward.list[2] == self:GetLuaMemberInfo():GetPlayerMemberInfo().dailyReceivedCount or self:GetLuaMemberInfo():GetPlayerMemberLevel() == 0) then
        self:GetDailyReward_GridContainer().MaxCount = 0
        return
    end
    self:GetDailyReward_GridContainer().MaxCount = 1
    for i = 0, count - 1 do
        local go = self:GetDailyReward_GridContainer().controlList[i];
        local ItemCount = CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel")
        local ItemIcon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
        local canget = CS.Utility_Lua.GetComponent(go.transform:Find("btn_get"), "GameObject")
        local count = DailyReward.list[2] - self:GetLuaMemberInfo():GetPlayerMemberInfo().dailyReceivedCount
        ItemCount.text = count == 1 and "" or tostring(DailyReward.list[2] - self:GetLuaMemberInfo():GetPlayerMemberInfo().dailyReceivedCount)
        if (count > 0 and self:GetLuaMemberInfo():GetPlayerMemberLevel() ~= 0) then
            canget:SetActive(true)
        else
            canget:SetActive(false)
        end
        ---@type boolean
        local isfind
        ---@type TABLE.cfg_items
        local data
        isfind, data = CS.Cfg_ItemsTableManager.Instance:TryGetValue(DailyReward.list[1])
        if (isfind) then
            ItemIcon.spriteName = data.icon
            ItemIcon:MakePixelPerfect()
        end
        CS.UIEventListener.Get(go).onClick = function(go)
            if go ~= nil and CS.StaticUtility.IsNull(go) == false and ItemIcon ~= nil then
                --打开物品信息界面
                local id = data.id
                if (id ~= nil) then
                    --uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = data, showRight = false })
                    if (DailyReward.list[2] ~= self:GetLuaMemberInfo():GetPlayerMemberInfo().dailyReceivedCount) then
                        self:GetDailyRewardBtnOnClick()
                    end
                end
            end
        end
    end
end

---刷新会员特权描述
function UIRechargeMemberPanel:RefreshPrivilegeDes()
    local PrivilegeTips = string.Split(self:GetCurChooseMemberTableData():GetTips(), '#')
    local count = #PrivilegeTips
    self:GetPrivilege_GridContainer().MaxCount = count
    for i = 0, count - 1 do
        local go = self:GetPrivilege_GridContainer().controlList[i];
        local des = CS.Utility_Lua.GetComponent(go.transform:Find("desText"), "Top_UILabel")
        des.text = PrivilegeTips[i + 1]
    end
    self:GetMemberPrivilege_ScrollView():Reposition()
end

---刷新会员标题描述
function UIRechargeMemberPanel:RefreshPrivilegeTitle()
    local titleSprite = string.Split(self:GetCurChooseMemberTableData():GetTitleSprite(), '#')
    self:GetPrivilegeTitle_UISprite().spriteName = titleSprite[1]
    self:GetPrivilegeTitle_UISprite():MakePixelPerfect()
    self:GetGiftTitle_UILabel().text = string.gsub(self:GetCurChooseMemberTableData():GetName(), "会员", "") .. "礼包"
    self:GetTaskTitle_UISprite().spriteName = titleSprite[2]
    self:GetTaskTitle_UISprite():MakePixelPerfect()
    self:GetRecharge_UILabel().text = self:GetCurChooseMemberTableData():GetButtonTips()
end

---刷新会员特权奖励
function UIRechargeMemberPanel:RefreshPrivilegeReward()
    if (self.mCurChooseLevel > self:GetLuaMemberInfo():GetPlayerMemberLevel()) then
        self:GetGetPrivilegeRewardBtn_GameObject():SetActive(false)
    else
        self:GetGetPrivilegeRewardBtn_GameObject():SetActive(true)
    end

    if (Utility.IsContainsValue(self:GetLuaMemberInfo():GetPlayerMemberInfo().receivedLevelReward, self.mCurChooseLevel)) then
        self:GetGetPrivilegeRewardBtn_GameObject():SetActive(false)
        self:GetHasgot_GameObject():SetActive(true)
    else
        self:GetHasgot_GameObject():SetActive(false)
    end

    local RewardItemId = self:GetCurChooseMemberTableData():GetReward()
    local RwardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(RewardItemId)
    local count = RwardList.Count
    self:GetMemberGiftReward_GridContainer().MaxCount = count
    for i = 0, count - 1 do
        local go = self:GetMemberGiftReward_GridContainer().controlList[i];
        local ItemCount = CS.Utility_Lua.GetComponent(go.transform:Find("count"), "Top_UILabel")
        local ItemIcon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "Top_UISprite")
        ---@type bagV2.CoinInfo
        local rewardInfo = RwardList[i]
        ItemCount.text = rewardInfo.count == 1 and "" or tostring(rewardInfo.count)
        ---@type boolean
        local isfind
        ---@type TABLE.cfg_items
        local data
        isfind, data = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
        if (isfind) then
            ItemIcon.spriteName = data.icon
            ItemIcon:MakePixelPerfect()
        end
        CS.UIEventListener.Get(go).onClick = function(go)
            if go ~= nil and CS.StaticUtility.IsNull(go) == false and ItemIcon ~= nil then
                --打开物品信息界面
                local id = data.id
                if (id ~= nil) then
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = data, showRight = false })
                end
            end
        end
    end

end

---刷新会员目标任务进度
function UIRechargeMemberPanel:RefreshPrivilegeTaskDes()
    ---@type table<number,vipV2.VipMemberTask>
    if (self:GetLuaMemberInfo():GetPlayerMemberInfo() == nil) then
        return
    end
    self:GetNexttips_GameObject():SetActive(false)
    if (self:GetLuaMemberInfo():GetPlayerMemberLevel() == 0) then
        if (self.mCurChooseLevel == 1) then
            local taskList = self:GetLuaMemberInfo():GetPlayerMemberInfo().taskList
            self:GetMissionView_LoopScrollView():Init(function(go, line)
                if line < #taskList then
                    ---@type UIMemberTaskTemplate
                    if (self.mMemberTaskDic[go] == nil) then
                        self.mMemberTaskDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMemberTaskTemplate);
                    end
                    local tabledata = clientTableManager.cfg_member_taskManager:TryGetValue(taskList[line + 1].taskId)
                    self.mMemberTaskDic[go]:InitData(taskList[line + 1], tabledata)
                    self.mMemberTaskDic[go]:RefreshUI()
                    return true
                else
                    return false
                end
            end)
        else
            self:GetNexttips_GameObject():SetActive(true)
            self:GetMissionView_LoopScrollView():Init(function(go, line)
                return false
            end)
        end
    else
        if (self.mCurChooseLevel > self:GetLuaMemberInfo():GetPlayerMemberLevel() + 1) then
            self:GetMissionView_LoopScrollView():Init(function(go, line)
                return false
            end)
            self:GetNexttips_GameObject():SetActive(true)
        elseif (self.mCurChooseLevel == self:GetLuaMemberInfo():GetPlayerMemberLevel() + 1) then
            local taskList = self:GetLuaMemberInfo():GetPlayerMemberInfo().taskList
            self:GetMissionView_LoopScrollView():Init(function(go, line)
                if line < #taskList then
                    ---@type UIMemberTaskTemplate
                    local tabledata = clientTableManager.cfg_member_taskManager:TryGetValue(taskList[line + 1].taskId)
                    if (self.mMemberTaskDic[go] == nil) then
                        self.mMemberTaskDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMemberTaskTemplate);
                    end
                    self.mMemberTaskDic[go]:InitData(taskList[line + 1], tabledata)
                    self.mMemberTaskDic[go]:RefreshUI()
                    return true
                else
                    return false
                end
            end)
        else
            local taskList = self:GetCurChooseMemberTableData():GetTask().list
            self:GetMissionView_LoopScrollView():Init(function(go, line)
                if line < #taskList then
                    ---@type UIMemberTaskTemplate
                    local taskinfo = clientTableManager.cfg_member_taskManager:TryGetValue(taskList[line + 1])
                    if (self.mMemberTaskDic[go] == nil) then
                        self.mMemberTaskDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMemberTaskTemplate);
                    end
                    self.mMemberTaskDic[go]:InitData(nil, taskinfo)
                    self.mMemberTaskDic[go]:RefreshUI(true)
                    return true
                else
                    return false
                end
            end)
        end
    end

end

---刷新会员升级按钮文本 展示会员等级+1的数据
function UIRechargeMemberPanel:RefreshRechargeBtnLabel()
    local maxLevel = clientTableManager.cfg_memberManager:GetMaxLevel()
    local isShow = self:GetLuaMemberInfo():GetPlayerMemberLevel() < maxLevel
    self:GetRechargeBtn_GameObject():SetActive(isShow)
    if isShow then
        local nextLevel = self:GetLuaMemberInfo():GetPlayerMemberLevel() + 1
        ---@type TABLE.cfg_member
        local tbl_member = clientTableManager.cfg_memberManager:TryGetValue(nextLevel)
        if tbl_member == nil then
            ---没有下一级已到最大级
            tbl_member = self:GetCurMemberTableData()
        end
        local jumpSprite = string.Split(tbl_member:GetJump(), '#')
        if jumpSprite == nil or #jumpSprite <= 0 then
            return
        end
        if #jumpSprite >= 2 then
            self:GetRechargeBtnLabel().text = jumpSprite[2]
        end
    end

end

---选择页签
function UIRechargeMemberPanel:ChooseMemberPageToRefresh()
    self:RefreshDailyReward()
    self:RefreshPrivilegeDes()
    self:RefreshPrivilegeTitle()
    self:RefreshPrivilegeReward()
    self:RefreshPrivilegeTaskDes()
    self:RefreshRechargeBtnLabel()
end
--endregion

--region 客户端事件处理
function UIRechargeMemberPanel:CloseBtnOnClick(go)
    uimanager:ClosePanel("UIRechargeMemberPanel")
end

function UIRechargeMemberPanel:GetLevelRewardBtnOnClick(go)
    networkRequest.ReqVipMemberLevelReward(self.mCurChooseLevel)
end

function UIRechargeMemberPanel:GetDailyRewardBtnOnClick(go)
    networkRequest.ReqVipMemberDailyReward()
end

function UIRechargeMemberPanel:GetRechargeBtnOnClick(go)
    local nextLevel = self:GetLuaMemberInfo():GetPlayerMemberLevel() + 1
    ---@type TABLE.cfg_member
    local tbl_member = clientTableManager.cfg_memberManager:TryGetValue(nextLevel)
    if tbl_member == nil then
        ---没有下一级已到最大级
        tbl_member = self:GetCurMemberTableData()
    end
    local jumpSprite = string.Split(tbl_member:GetJump(), '#')
    if jumpSprite == nil or #jumpSprite <= 0 then
        return
    end
    --- 0跳转充值界面
    if tonumber(jumpSprite[1]) == 0 then
        --uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.MemberPromote
        --if (Utility.TryShowFirstRechargePanel()) then
        --    uiTransferManager:TransferToPanel(LuaEnumTransferType.FirstRecharge)
        --else
        --    uiTransferManager:TransferToPanel(LuaEnumTransferType.Recharge)
        --end
        Utility.TryShowFirstRechargePanel()
    else
        uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.MemberGift
        --- 1 展示礼包弹窗
        local storeId = nil
        if #jumpSprite >= 3 then
            storeId = tonumber(jumpSprite[3])
        end
        uimanager:CreatePanel("UIPromptMemberPanel", nil, tbl_member:GetName(), storeId)
    end
end
--endregion

--region 服务器事件处理

--endregion

function ondestroy()

end

return UIRechargeMemberPanel