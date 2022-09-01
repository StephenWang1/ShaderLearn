---@class UIGuildMemberListPanel:UIBase
---@class UIGuildMemberListPanel:UIBase
local UIGuildMemberListPanel = {}

local Utility = Utility

--region 局部变量定义

---@type boolean 排序
UIGuildMemberListPanel.isUpState = true

---@type table<boolean,string >箭头图片
UIGuildMemberListPanel.spriteName = {
    [true] = "statearrow",
    [false] = "unstatearrow",
}

---帮会成员信息
UIGuildMemberListPanel.mMemberListInfo = nil

---当前选中
UIGuildMemberListPanel.mCurrentChoose = nil

---召唤令职位
UIGuildMemberListPanel.mSummonPos = nil

---退出帮会二次确认
UIGuildMemberListPanel.QuitUnionInfo = nil
---解散帮会二次确认
UIGuildMemberListPanel.CancelUnionInfo = nil
---解散帮会CD
UIGuildMemberListPanel.CancelGuildCD = nil
---退出帮会CD
UIGuildMemberListPanel.QuitGuildCD = nil

---初始退出按钮位置
---@type UnityEngine.Vector3
UIGuildMemberListPanel.startQuitBtnPos = nil

---初始设置按钮位置
---@type UnityEngine.Vector3
UIGuildMemberListPanel.setBtnPos = nil

---设置按钮和退出按钮位置偏差
---@type number
UIGuildMemberListPanel.mBtnOffset = 30

--endregion

--region 组件
---@return UILoopScrollViewPlus 成员循环组件
function UIGuildMemberListPanel:GetLoopScrollView()
    if self.mLoopScrollView == nil then
        self.mLoopScrollView = self:GetCurComp("WidgetRoot/view/ScrollView/Content", "UILoopScrollViewPlus")
    end
    return self.mLoopScrollView
end

---@return UIToggle 获取在线成员列表
function UIGuildMemberListPanel:GetOnlineMemberToggle_UIToggle()
    if self.mGetOnlineMemberToggle == nil then
        self.mGetOnlineMemberToggle = self:GetCurComp("WidgetRoot/event/ShowOnline", "UIToggle")
    end
    return self.mGetOnlineMemberToggle
end

---@return UnityEngine.GameObject 选中仅在线
function UIGuildMemberListPanel:GetOnlineChoose_GameObject()
    if self.mOnlineChooseGo == nil then
        self.mOnlineChooseGo = self:GetCurComp("WidgetRoot/event/ShowOnline/check", "GameObject")
    end
    return self.mOnlineChooseGo
end

---@return UILabel 当前在线成员数
function UIGuildMemberListPanel:GetShowMemberNum_UILabel()
    if self.mShowMemberNumLabel == nil then
        self.mShowMemberNumLabel = self:GetCurComp("WidgetRoot/event/ShowOnline/Label", "UILabel")
    end
    return self.mShowMemberNumLabel
end

---@return UnityEngine.GameObject 退会按钮
function UIGuildMemberListPanel:GetQuitGuildBtn_GameObject()
    if self.mQuitGuildBtn == nil then
        self.mQuitGuildBtn = self:GetCurComp("WidgetRoot/event/btn_cancelUnion", "GameObject")
    end
    return self.mQuitGuildBtn
end

---@return UILabel 退会按钮文字
function UIGuildMemberListPanel:GetQuitGuild_UILabel()
    if self.mQuitGuildLb == nil then
        self.mQuitGuildLb = self:GetCurComp("WidgetRoot/event/btn_cancelUnion/lb_cancelUnion", "UILabel")
    end
    return self.mQuitGuildLb
end

---@return UnityEngine.GameObject 状态按钮
function UIGuildMemberListPanel:GetStateBtn_GameObject()
    if self.mStateBtn == nil then
        self.mStateBtn = self:GetCurComp("WidgetRoot/TitlePanel/Label5", "GameObject")
    end
    return self.mStateBtn
end

---@return UISprite 上箭头图片
function UIGuildMemberListPanel:GetUpState_UISprite()
    if self.mUpStateSp == nil then
        self.mUpStateSp = self:GetCurComp("WidgetRoot/TitlePanel/Label5/arrow1", "UISprite")
    end
    return self.mUpStateSp
end

---@return UISprite 下箭头图片
function UIGuildMemberListPanel:GetDownState_UISprite()
    if self.mDownStateSp == nil then
        self.mDownStateSp = self:GetCurComp("WidgetRoot/TitlePanel/Label5/arrow2", "UISprite")
    end
    return self.mDownStateSp
end

---@return UnityEngine.GameObject 申请列表按钮
function UIGuildMemberListPanel:GetApplyListBtn_GameObject()
    if self.mApplyListBtn == nil then
        self.mApplyListBtn = self:GetCurComp("WidgetRoot/event/btn_application", "GameObject")
    end
    return self.mApplyListBtn
end

---@return UnityEngine.GameObject 申请列表按钮特效
function UIGuildMemberListPanel:GetApplyListBtnEffect_GameObject()
    if self.mApplyListBtnEffect == nil then
        self.mApplyListBtnEffect = self:GetCurComp("WidgetRoot/event/btn_application/effect", "GameObject")
    end
    return self.mApplyListBtnEffect
end

---@return UnityEngine.GameObject 一键招人按钮
function UIGuildMemberListPanel:GetRecruitBtn_GameObject()
    if self.mRecruitBtn == nil then
        self.mRecruitBtn = self:GetCurComp("WidgetRoot/event/btn_allinvite", "GameObject")
    end
    return self.mRecruitBtn
end

---@return UnityEngine.GameObject 仇人列表按钮
function UIGuildMemberListPanel:GetChouRenBtn_GameObject()
    if self.mChouRenBtn == nil then
        self.mChouRenBtn = self:GetCurComp("WidgetRoot/event/btn_enemyList", "GameObject")
    end
    return self.mChouRenBtn
end


--region 帮会召唤令
---@return UnityEngine.GameObject 设置帮会召唤令按钮
function UIGuildMemberListPanel:GetSetBtn_GameObject()
    if self.mSetBtn_GameObject == nil then
        self.mSetBtn_GameObject = self:GetCurComp("WidgetRoot/event/btn_set", "GameObject")
    end
    return self.mSetBtn_GameObject
end

---设置帮会召唤令按钮
function UIGuildMemberListPanel.GetSetLeftBtn_GameObject()
    if UIGuildMemberListPanel.mSetLeftBtn_GameObject == nil then
        UIGuildMemberListPanel.mSetLeftBtn_GameObject = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings/LeftBtn", "GameObject")
    end
    return UIGuildMemberListPanel.mSetLeftBtn_GameObject
end

---设置帮会召唤令按钮
function UIGuildMemberListPanel.GetSetRightBtnBtn_GameObject()
    if UIGuildMemberListPanel.mSetRightBtnBtn_GameObject == nil then
        UIGuildMemberListPanel.mSetRightBtnBtn_GameObject = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings/RightBtn", "GameObject")
    end
    return UIGuildMemberListPanel.mSetRightBtnBtn_GameObject
end

---设置帮会召唤令按钮
function UIGuildMemberListPanel.GetSetCloseBtnBtn_GameObject()
    if UIGuildMemberListPanel.mSetCloseBtnBtn_GameObject == nil then
        UIGuildMemberListPanel.mSetCloseBtnBtn_GameObject = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings/Close", "GameObject")
    end
    return UIGuildMemberListPanel.mSetCloseBtnBtn_GameObject
end

---设置帮会召唤令面板
function UIGuildMemberListPanel.GetDropDown_Settings_GameObject()
    if UIGuildMemberListPanel.mDropDown_Settings_GameObject == nil then
        UIGuildMemberListPanel.mDropDown_Settings_GameObject = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings", "GameObject")
    end
    return UIGuildMemberListPanel.mDropDown_Settings_GameObject
end

---@return Top_UIDropDown 设置帮会召唤令权限
function UIGuildMemberListPanel.GetDropDown_DropDown()
    if UIGuildMemberListPanel.mDropDown_DropDown == nil then
        UIGuildMemberListPanel.mDropDown_DropDown = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings/window/DropDown", "Top_UIDropDown")
    end
    return UIGuildMemberListPanel.mDropDown_DropDown
end

function UIGuildMemberListPanel.GetDropDown_UILabel()
    if UIGuildMemberListPanel.mDropDown_UILabel == nil then
        UIGuildMemberListPanel.mDropDown_UILabel = UIGuildMemberListPanel:GetCurComp("WidgetRoot/view/DropDown_Settings/window/DropDown/Caption/CaptionLabel", "UILabel")
    end
    return UIGuildMemberListPanel.mDropDown_UILabel
end
--endregion
--endregion

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UIGuildMemberListPanel:GetPlayerInfo()
    if self.playerInfo == nil then
        self.playerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.playerInfo
end

---@return CSUnionInfoV2 帮会信息总
function UIGuildMemberListPanel:GetUnionInfoV2()
    if self.mGuildInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mGuildInfoV2 = self:GetPlayerInfo().UnionInfoV2
        end
    end
    return self.mGuildInfoV2
end

---@return CSBagInfoV2 背包信息
function UIGuildMemberListPanel:GetBagInfoV2()
    if self.mBagInfo == nil and self:GetPlayerInfo() then
        self.mBagInfo = self:GetPlayerInfo().BagInfo
    end
    return self.mBagInfo
end

---@return boolean 是否是帮会可审批玩家
function UIGuildMemberListPanel:GetIsUnionManager()
    if self:GetUnionInfoV2() then
        local myPos = self:GetUnionInfoV2():GetCurrentPosition()
        return CS.CSUnionInfoV2.HasUnionApprovalAuthority(myPos)
    end
    return false
end

---@return TABLE.CFG_PROMPTWORD 退出帮会信息
function UIGuildMemberListPanel:GetQuitGuildInfo()
    if self.mQuitGuildInfo == nil then
        ___, self.mQuitGuildInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(4)
    end
    return self.mQuitGuildInfo
end

---@return number 退出帮会CD
function UIGuildMemberListPanel:GetQuitGuildCD()
    if self.mQuitGuildCD == nil then
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20226)
        if res then
            self.mQuitGuildCD = tonumber(info.value)
        end
    end
    return self.mQuitGuildCD
end

---@return TABLE.CFG_PROMPTWORD 解散帮会信息
function UIGuildMemberListPanel:GetDisbandGuildInfo()
    if self.mDisbandGuildInfo == nil then
        ___, self.mDisbandGuildInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(5)
    end
    return self.mDisbandGuildInfo
end

---@return number 解散帮会CD
function UIGuildMemberListPanel:GetDisbandGuildCD()
    if self.mDisbandGuildCD == nil then
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(20227)
        if res then
            self.mDisbandGuildCD = tonumber(info.value)
        end
    end
    return self.mDisbandGuildCD
end
--endregion

--region 初始化
function UIGuildMemberListPanel:Init()
    self:BindEvents()
    self:BindMessage()
    self.startQuitBtnPos = self:GetQuitGuildBtn_GameObject().transform.localPosition
    self.setBtnPos = self:GetSetBtn_GameObject() .transform.localPosition
end

function UIGuildMemberListPanel:Show()
    self.isUpState = true
    self:ShowCurrentMemberList(false)
    self:InitPanelShow()
    networkRequest.ReqUnionMemberInfo(self:GetUnionInfoV2().UnionID)
end

function UIGuildMemberListPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionMemberChange, function()
        self:RefreshMemberCurrentPage(not self.isUpState)
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionApplicationInfoChange, function()
        self:RefreshApplyEffect()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionVoiceStatusMessage, function()
        networkRequest.ReqUnionMemberInfo()
    end)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUnionSpeakerStatusMessage, function()
        networkRequest.ReqUnionMemberInfo()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionVoiceEndpointsUpdateRefreSh, function(id, data)
        -- self:RefreshCurrentMembevoiceStart(data)
        --   self:ShowCurrentMemberList(false)
        self:RefreshMemberCurrentPage(not self.isUpState)
    end)
end

function UIGuildMemberListPanel:BindEvents()
    local EventDelegate = CS.EventDelegate
    EventDelegate.Add(self:GetOnlineMemberToggle_UIToggle().onChange, function()
        self:ShowCurrentMemberList(false)
    end)
    CS.UIEventListener.Get(self:GetSetBtn_GameObject()).onClick = function()
        self:OnSetButtonClicked()
    end
    CS.UIEventListener.Get(self:GetStateBtn_GameObject()).onClick = function()
        self.isUpState = not self.isUpState
        self:RefreshState()
    end
    CS.UIEventListener.Get(self:GetQuitGuildBtn_GameObject()).onClick = function(go)
        self:OnCancelGuildButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetApplyListBtn_GameObject()).onClick = function(go)
        self:OnApplyListBtnClicked(go)
    end
    CS.UIEventListener.Get(self:GetRecruitBtn_GameObject()).onClick = function(go)
        self:OnRecruitBtnClicked(go)
    end
    CS.UIEventListener.Get(self:GetChouRenBtn_GameObject()).onClick = function(go)
        self:OnChouRenBtnClicked(go)
    end

    CS.UIEventListener.Get(UIGuildMemberListPanel.GetSetLeftBtn_GameObject()).onClick = UIGuildMemberListPanel.OnSetLeftButtonClicked
    CS.UIEventListener.Get(UIGuildMemberListPanel.GetSetCloseBtnBtn_GameObject()).onClick = UIGuildMemberListPanel.OnSetLeftButtonClicked
    CS.UIEventListener.Get(UIGuildMemberListPanel.GetSetRightBtnBtn_GameObject()).onClick = UIGuildMemberListPanel.OnSetRightButtonClicked
    UIGuildMemberListPanel.GetDropDown_DropDown().OnValueChange:Add(function(eventTemp)
        if eventTemp.Label == "会长" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.President
        elseif eventTemp.Label == "副会长" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.VicePresident
        elseif eventTemp.Label == "长老" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.Elder
        elseif eventTemp.Label == "堂主" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.Owner
        elseif eventTemp.Label == "精英" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.Elite
        elseif eventTemp.Label == "成员" then
            UIGuildMemberListPanel.mSummonPos = LuaEnumGuildPosType.Member
        end
    end)
end

--endregion

--region 客户端事件
---刷新申请特效
function UIGuildMemberListPanel:RefreshApplyEffect()
    if self:GetUnionInfoV2() then
        self:GetApplyListBtnEffect_GameObject():SetActive(self:GetUnionInfoV2():HasApplication())
    end
end
--endregion

--region UI事件
---初始化界面显示
function UIGuildMemberListPanel:InitPanelShow()
    self:RefreshState()
    self:RefreshBtnShow()
    self:RefreshApplyEffect()
end

---刷新排序状态图片
function UIGuildMemberListPanel:RefreshState()
    local angle = ternary(self.isUpState, CS.UnityEngine.Vector3(0, 0, 180), CS.UnityEngine.Vector3.zero)
    self:GetUpState_UISprite().gameObject.transform.localEulerAngles = angle
    self:ShowCurrentMemberList(true)
end

---刷新按钮显示
function UIGuildMemberListPanel:RefreshBtnShow()
    if self:GetUnionInfoV2() and self:GetUnionInfoV2().UnionInfo then
        local isSecondUnion = false --排名前2的帮会，不可见
        local isLeader = self:GetUnionInfoV2():CanChangeUseOfSummons()
        ---退出帮会按钮
        self:GetQuitGuildBtn_GameObject():SetActive(not (isSecondUnion and isLeader))
        self:GetQuitGuild_UILabel().text = ternary(isLeader, "解散行会", "退出行会")
        ---申请列表按钮
        self:GetApplyListBtn_GameObject():SetActive(self:GetIsUnionManager())
        ---一键招人按钮
        self:GetRecruitBtn_GameObject():SetActive(self:GetIsUnionManager())
        ---帮会召唤令按钮
        self:GetSetBtn_GameObject():SetActive(isLeader)
        --退会按钮位置
        local des = 0
        local pos = self.setBtnPos.x
        if isLeader then
            des = -80
        else
            des = -40
        end
        pos = pos + des
        self:GetQuitGuildBtn_GameObject().transform.localPosition = CS.UnityEngine.Vector3(pos, self.setBtnPos.y, 0)
        --招人按钮位置
        if self:GetIsUnionManager() then
            des = -120
        end
        pos = pos + des
        self:GetRecruitBtn_GameObject().transform.localPosition = CS.UnityEngine.Vector3(pos, self.setBtnPos.y, 0)
        --申请按钮位置
        if self:GetIsUnionManager() then
            des = -120
        end
        pos = pos + des
        self:GetApplyListBtn_GameObject().transform.localPosition = CS.UnityEngine.Vector3(pos, self.setBtnPos.y, 0)
    end
end

---刷新成员数据
function UIGuildMemberListPanel:RefreshMemberInfo(isReverse)
    self.mMemberListInfo = self:GetShowList(isReverse)
end

---显示当前帮会成员/从第一行重新刷新
function UIGuildMemberListPanel:ShowCurrentMemberList(isReverse)
    self:RefreshMemberInfo(isReverse)
    self:GetLoopScrollView():Init(function(go, line)
        if line < #self.mMemberListInfo then
            self:InitMemberInfoFunc(go, line)
            return true
        else
            return false
        end
    end)
end

---显示当前帮会成员/只刷新当前页
function UIGuildMemberListPanel:RefreshMemberCurrentPage(isReverse)
    self:RefreshMemberInfo(isReverse)--再刷新之前刷新数据
    self:GetLoopScrollView():RefreshCurrentPage()--刷新当前页
end

---刷新麦克风说话状态
function UIGuildMemberListPanel:RefreshCurrentMembevoiceStart(eventdata)
    local showList = self:GetShowList(false)
    if showList then
        local UnionMember = CS.System.Collections.Generic["List`1[System.Object]"]()
        for i = 1, #showList do
            UnionMember:Add(showList[i])
        end
        local selfID = self:GetPlayerInfo().ID
        self:GetLoopScrollView():RefreshCurrentPage()
        self:GetLoopScrollView():Init(function(go, line)
            if line < #showList then
                local data = showList[line + 1]
                self:InitMemberInfoFunc(go, data, line, selfID)
                self:MemberVoiceInfoFunc(go, data, line, selfID, eventdata)
                return true
            else
                return false
            end
        end)
    end
end

function UIGuildMemberListPanel:MemberVoiceInfoFunc(item, data, line, selfID, eventdata)
    local myData = data
    local line = line
    if myData then
        local itemGo = item
        local itemTrans = itemGo.transform
        ---自由麦start↓
        local voice = CS.Utility_Lua.GetComponent(itemTrans:Find("voice"), "Top_UISprite")
        local speak = CS.Utility_Lua.GetComponent(itemTrans:Find("speak"), "Top_UISprite")

        local isHaveTalk = false
        if eventdata == 5 then
            isHaveTalk = true
        elseif eventdata == 6 then
            isHaveTalk = false
        end
        self.isHaveTalk = isHaveTalk
        -- print("自由麦话筒~~：",isHaveTalk,myData.canSendVoice)
        if myData.canSendVoice then
            voice.gameObject:SetActive(not isHaveTalk)
            speak.gameObject:SetActive(isHaveTalk)
        else
            voice.gameObject:SetActive(false)
            speak.gameObject:SetActive(false)
        end
        ---自由麦end↑
    end
end

---刷新每一条成员消息
---@param data unionV2.UnionMemberInfo 帮会成员信息
function UIGuildMemberListPanel:InitMemberInfoFunc(item, line)
    local selfID = self:GetPlayerInfo().ID
    local line = line
    local myData = self.mMemberListInfo[line + 1]
    if myData then
        local isOnLine = myData.online
        local color = ternary(isOnLine, luaEnumColorType.White, luaEnumColorType.Gray)

        local itemGo = item
        local itemTrans = itemGo.transform
        ---@type UILabel 玩家名称
        local name = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_name"), "UILabel")
        if not CS.StaticUtility.IsNull(name) then
            name.text = color .. myData.memberName
        end
        ---@type UISprite 商会标识
        --[[local commerce = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_name/commerce"), "UISprite")
        if not CS.StaticUtility.IsNull(commerce) then
            if myData.activeMonthCard ~= nil and myData.activeMonthCard ~= 0 then
                commerce.gameObject:SetActive(true)
                if myData.activeMonthCard == 1 then
                    commerce.spriteName = "Commerce_bq"
                elseif myData.activeMonthCard == 2 then
                    commerce.spriteName = "Commerce_mc"
                end
                CS.UIEventListener.Get(commerce.gameObject).onClick = function(go)
                    uimanager:CreatePanel("UICommercePanel")
                end
            --if myData.activeMonthCard == 1 then
                --commerce.spriteName = "Commerce_bq"
            --elseif myData.activeMonthCard == 2 then
                --commerce.spriteName = "Commerce_mc"
            --end
            --local memberLevel = myData.vipMemberLevel
            --if memberLevel > 0 then --myData.activeMonthCard ~= nil and myData.activeMonthCard ~= 0 and then
                --local memberData = clientTableManager.cfg_memberManager:TryGetValue(memberLevel)
                --local spriteName = memberData:GetSpirit()
                --commerce.gameObject:SetActive(true)
                --commerce.spriteName = spriteName
                --commerce:MakePixelPerfect()
                
                --CS.UIEventListener.Get(commerce.gameObject).onClick = function(go)
                    --uimanager:CreatePanel("UIRechargeMemberPanel")
                --end
            else
                commerce.gameObject:SetActive(false)
            end
        end]]
        ---@type UILabel 等级
        local level = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_level"), "UILabel")
        if not CS.StaticUtility.IsNull(level) then
            level.text = color .. myData.memberLevel
        end
        ---@type UILabel 职位
        local lb_duty = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_duty"), "UILabel")
        if not CS.StaticUtility.IsNull(lb_duty) then
            local pos = myData.position
            local dutyColor = isOnLine and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.Grey
            local ActingPresidentRoleID = self:GetUnionInfoV2().ActingPresidentRoleID
            if ActingPresidentRoleID ~= 0 and ActingPresidentRoleID == myData.roleId then
                pos = 19
            end
            local showDuty = uiStaticParameter.PosStringListWithColor[pos]
            lb_duty.text = showDuty
            lb_duty.color = dutyColor
        end
        ---@type UILabel 活跃度
        local lb_active = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_active"), "UILabel")
        if not CS.StaticUtility.IsNull(lb_active) then
            lb_active.text = color .. myData.activeToday
        end
        ---@type UILabel 在线
        local lb_offline = CS.Utility_Lua.GetComponent(itemTrans:Find("lb_offline"), "UILabel")
        if not CS.StaticUtility.IsNull(lb_offline) then
            lb_offline.text = color .. ternary(isOnLine, "在线", self:GetUnionInfoV2():ChangTimeToBeforDays(myData.offlineTime))
        end
        ---@type UnityEngine.GameObject 背景图片
        local bg2 = itemTrans:Find("bg").gameObject
        if not CS.StaticUtility.IsNull(bg2) then
            bg2:SetActive(line % 2 ~= 0)
        end

        ---自由麦start↓
        local voice = CS.Utility_Lua.GetComponent(itemTrans:Find("voice"), "Top_UISprite")
        local voiceBox = CS.Utility_Lua.GetComponent(itemTrans:Find("voice"), "BoxCollider")
        local speak = CS.Utility_Lua.GetComponent(itemTrans:Find("speak"), "Top_UISprite")
        if voiceBox ~= nil then
            voiceBox.enabled = myData.roleId == CS.CSScene.MainPlayerInfo.ID
        end
        if not CS.StaticUtility.IsNull(voice) then
            voice.gameObject:SetActive(myData.canSendVoice)
            if myData.voiceOpen then
                voice.spriteName = "Speak_Guild1"
            else
                voice.spriteName = "Speak_Guild2"
            end
            -- voice.gameObject:SetActive(myData.canSendVoice)
        end
        CS.UIEventListener.Get(voice.gameObject).onClick = function()
            if UIGuildMemberListPanel.IsBuDouKaiCloseVoice(voice) == true then
                return
            end
            if not myData.canSendVoice then
                Utility.ShowPopoTips(voice.gameObject.transform, nil, 297)
            else
                local openIndex = 1
                if myData.voiceOpen then
                    openIndex = 0
                end
                networkRequest.ReqToggleVoiceOpen(openIndex)
                if not myData.voiceOpen then
                    Utility.ShowBlackPopoTips(voice.gameObject.transform, nil, 286)
                else
                    Utility.ShowBlackPopoTips(voice.gameObject.transform, nil, 287)
                end
                if self.isHaveTalk ~= nil then
                    voice.gameObject:SetActive(not self.isHaveTalk)
                    speak.gameObject:SetActive(self.isHaveTalk)
                end

            end
        end
        CS.UIEventListener.Get(speak.gameObject).onClick = function()
            if UIGuildMemberListPanel.IsBuDouKaiCloseVoice(speak) == true then
                return
            end
            local openIndex = 1
            if myData.voiceOpen then
                openIndex = 0
            end
            networkRequest.ReqToggleVoiceOpen(openIndex)
            if not myData.voiceOpen then
                Utility.ShowBlackPopoTips(voice.gameObject.transform, nil, 286)
            else
                Utility.ShowBlackPopoTips(voice.gameObject.transform, nil, 287)
            end
            voice.gameObject:SetActive(true)
            speak.gameObject:SetActive(false)
        end

        local mic = CS.Utility_Lua.GetComponent(itemTrans:Find("mic"), "Top_UISprite")
        local micBox = CS.Utility_Lua.GetComponent(itemTrans:Find("mic"), "BoxCollider")
        if micBox ~= nil then
            micBox.enabled = myData.roleId == CS.CSScene.MainPlayerInfo.ID
        end
        if not CS.StaticUtility.IsNull(mic) then
            if myData.speakerOpen then
                mic.spriteName = "Lister_Guild1"
            else
                mic.spriteName = "Lister_Guild2"
            end
        end
        CS.UIEventListener.Get(mic.gameObject).onClick = function()
            if UIGuildMemberListPanel.IsBuDouKaiCloseVoice(mic) == true then
                return
            end
            networkRequest.ReqToggleSpeaker()
            if not myData.speakerOpen then
                Utility.ShowBlackPopoTips(mic.gameObject.transform, nil, 288)
            else
                Utility.ShowBlackPopoTips(mic.gameObject.transform, nil, 289)
            end
        end
        if myData.canSendVoice then
            if myData.voiceOpen then
                voice.gameObject:SetActive(not CS.SDKManager.VoiceSDKInterface.IsMemberSpeak)
                speak.gameObject:SetActive(CS.SDKManager.VoiceSDKInterface.IsMemberSpeak)
            else
                voice.gameObject:SetActive(true)
                speak.gameObject:SetActive(false)
            end

        else
            voice.gameObject:SetActive(false)
            speak.gameObject:SetActive(false)
        end

        ---自由麦end↑

        CS.UIEventListener.Get(itemGo).onClick = function(go)
            self:OnClickItem(go, myData)
        end
        ---@type UnityEngine.GameObject 个人标记
        local selfPic = CS.Utility_Lua.GetComponent(itemTrans:Find("chosenhight"), "GameObject")
        if not CS.StaticUtility.IsNull(selfPic) then
            selfPic:SetActive(myData.roleId == selfID)
        end
    end
end

function UIGuildMemberListPanel.IsBuDouKaiCloseVoice(mic)
    --if uiStaticParameter.voiceMgr.recordState == false and uiStaticParameter.voiceMgr.recordSource == LuaEnumControlRecordStateSource.BuDouKai then
    --    Utility.ShowBlackPopoTips(mic.gameObject.transform, nil, 316)
    --    return true
    --else
    --    return false
    --end
    return false
end

--region 打开玩家信息面板
---选中玩家
---@param info unionV2.UnionMemberInfo
function UIGuildMemberListPanel:OnClickItem(go, info)
    if info and self:GetUnionInfoV2() then
        if self:GetPlayerInfo().ID == info.roleId then
            CS.Utility.ShowRedTips("不可选中自己")
        else
            local myPos = self:GetUnionInfoV2():GetCurrentPosition()
            local customData = {}
            customData.Pos = info.position
            customData.Cost, customData.CostName, customData.costEnough = self:GetUnionKickCost(info.offlineTime, info.memberLevel)
            local panelType
            if self:IsAutoSetPos() then
                panelType = LuaEnumPanelIDType.GuildMemberListPanel
            else
                if myPos >= LuaEnumGuildPosType.President then
                    customData.info = info
                    panelType = LuaEnumPanelIDType.GuildChairman
                elseif myPos >= LuaEnumGuildPosType.Elder then
                    if myPos > info.position then
                        panelType = LuaEnumPanelIDType.GuildLeaderListPanel
                    else
                        panelType = LuaEnumPanelIDType.GuildMemberListPanel
                    end
                elseif myPos >= LuaEnumGuildPosType.Owner then
                    if myPos > info.position then
                        panelType = LuaEnumPanelIDType.GuildOwnerListPanel
                    else
                        panelType = LuaEnumPanelIDType.GuildMemberListPanel
                    end
                else
                    panelType = LuaEnumPanelIDType.GuildMemberListPanel
                end
            end
            uimanager:CreatePanel("UIGuildTipsPanel", nil, {
                panelType = panelType,
                roleId = info.roleId,
                roleName = info.memberName,
                UnionData = customData,
                roleSex = info.sex
            })
        end
    end
end

function UIGuildMemberListPanel:IsAutoSetPos()
    if self:GetPlayerInfo() and self:GetUnionInfoV2() then
        local openDays = self:GetPlayerInfo().ActualOpenDays
        if self:GetUnionInfoV2().UnionInfo.unionInfo.isAutoCreated then
            if openDays < 3 then
                return true
            elseif openDays == 3 then
                local hour = CS.CSServerTime.Now.Hour
                if hour < 19 then
                    return true
                end
            end
        end
    end
    return false
end

---@return number 花费
---@return string 名字
function UIGuildMemberListPanel:GetUnionKickCost(offlineTime, level)
    local name
    local Cost, costID = self:GetKickMemberCost(offlineTime, level)
    if costID ~= 0 then
        local itemInfo = self:GetItemInfoCache(costID)
        if itemInfo then
            name = itemInfo.name
        end
    end
    local playerHas = self:GetBagInfoV2():GetCoinAmount(costID)
    local playerEnough = playerHas >= Cost
    return Cost, name, playerEnough
end

function UIGuildMemberListPanel:GetKickMemberCost(offlineTime, level)
    local costNum, costId = self:GetKickCostInfo(offlineTime, level)
    if costNum ~= 0 then
        local kickNum = self:GetUnionInfoV2().UnionInfo.todayKickOutCount
        local freeKickNum = CS.Cfg_GlobalTableManager.Instance:GetUnionFreeKickMemberNum()
        if kickNum and freeKickNum and kickNum < freeKickNum then
            return 0, 0
        end
    end
    return costNum, costId
end

---获取踢人花费
function UIGuildMemberListPanel:GetKickCostInfo(offlineTime, level)
    if offlineTime == nil or level == nil then
        return 0, 0
    end
    if self.mKickCostInfo == nil then
        self.mKickCostInfo = CS.Cfg_GlobalTableManager.Instance:KickMemberCost()
    end
    if self.mKickCostInfo then
        for i = 0, self.mKickCostInfo.Count - 1 do
            local info = self.mKickCostInfo[i]
            if info.Count >= 5 then
                local levelDowm = info[0]
                local levelUp = info[1]
                local leaveTime = info[2]
                local coinId = info[3]
                local coinNum = info[4]
                if level >= levelDowm and level <= levelUp then
                    local time = CS.CSServerTime.Instance.TotalMillisecond - offlineTime
                    if offlineTime ~= 0 and time > leaveTime * 60 * 60 * 1000 then
                        return 0, 0
                    else
                        return coinNum, coinId
                    end
                end
            end
        end
    end
    return 0, 0
end

--endregion

--region 帮会召唤令
function UIGuildMemberListPanel.SetCanUseUnionCallBackPosText(index)
    UIGuildMemberListPanel.GetDropDown_UILabel().text = uiStaticParameter.PosStringList[index];
end

---设置帮会召唤令按钮点击
function UIGuildMemberListPanel:OnSetButtonClicked()
    UIGuildMemberListPanel.GetDropDown_Settings_GameObject():SetActive(true)
    UIGuildMemberListPanel.mSummonPos = CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionInfo.unionInfo.canUseUnionCallBackPosition
    UIGuildMemberListPanel.SetCanUseUnionCallBackPosText(UIGuildMemberListPanel.mSummonPos)
end

---设置帮会召唤令左按钮
function UIGuildMemberListPanel.OnSetLeftButtonClicked()
    UIGuildMemberListPanel.GetDropDown_Settings_GameObject():SetActive(false)
end

---设置帮会召唤令左按钮
function UIGuildMemberListPanel.OnSetRightButtonClicked()
    UIGuildMemberListPanel.GetDropDown_Settings_GameObject():SetActive(false)
    if UIGuildMemberListPanel.mSummonPos ~= nil then
        networkRequest.ReqUpdateUnionCallBackUsePosition(UIGuildMemberListPanel.mSummonPos)
    end
end
--endregion



---获取当前显示列表(排序在C#内筛选是否在线在lua内)
function UIGuildMemberListPanel:GetShowList(isReverse)
    local reverse = ternary(isReverse, true, false)
    local list = self:GetUnionInfoV2():GetUnionMemberInfo(reverse)
    local isOnline = self:GetOnlineMemberToggle_UIToggle().value
    local onLineCount = 0
    local showList = {}
    local onLineList = {}
    if list then
        for i = 0, list.Count - 1 do
            if list[i].online then
                table.insert(onLineList, list[i])
            end
            table.insert(showList, list[i])
        end
    end
    self:GetShowMemberNum_UILabel().text = "仅在线(" .. #onLineList .. "/" .. list.Count .. ")"
    if isOnline then
        return onLineList
    else
        return showList
    end
end

---解散行会
function UIGuildMemberListPanel:OnCancelGuildButtonClicked(go)
    if Utility.IsSabacActivityNotOpen(go) then
        local CancelInfo = {}
        if self:GetUnionInfoV2():IsLeader() then
            if self:GetDisbandGuildInfo() and self:GetDisbandGuildCD() then
                CancelInfo = {
                    Title = self:GetDisbandGuildInfo().title,
                    LeftDescription = self:GetDisbandGuildInfo().leftButton,
                    RightDescription = self:GetDisbandGuildInfo().rightButton,
                    Content = string.format(string.gsub(self:GetDisbandGuildInfo().des, "\\n", '\n'), self:GetDisbandGuildCD()),
                    CallBack = function()
                        local roleID = self:GetPlayerInfo().ID
                        networkRequest.ReqQuitOrDissolveUnion(roleID, 2)
                    end
                }
            end
        else
            if self:GetUnionInfoV2():IsSelfElection() then
                local data = self:GetPromptWordCacheData(85)
                if data then
                    CancelInfo = {
                        Title = data.title,
                        LeftDescription = data.leftButton,
                        RightDescription = data.rightButton,
                        Content = data.des,
                        CallBack = function()
                            local roleID = self:GetPlayerInfo().ID
                            networkRequest.ReqQuitOrDissolveUnion(roleID, 1)
                        end
                    }
                end
            else
                if self:GetQuitGuildInfo() and self:GetQuitGuildCD() then
                    CancelInfo = {
                        Title = self:GetQuitGuildInfo().title,
                        LeftDescription = self:GetQuitGuildInfo().leftButton,
                        RightDescription = self:GetQuitGuildInfo().rightButton,
                        ID = self:GetQuitGuildInfo().id,
                        Content = string.format(string.gsub(self:GetQuitGuildInfo().des, "\\n", '\n'), self:GetQuitGuildCD()),
                        CallBack = function()
                            local roleID = self:GetPlayerInfo().ID
                            networkRequest.ReqQuitOrDissolveUnion(roleID, 1)
                        end
                    }
                end
            end
        end
        uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
    end
end

function UIGuildMemberListPanel:GetPromptWordCacheData(id)
    if self.mPromptWordIdToData == nil then
        self.mPromptWordIdToData = {}
    end
    local data = self.mPromptWordIdToData[id]
    if data == nil then
        ___, data = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(id)
        self.mPromptWordIdToData[id] = data
    end
    return data
end

---打开申请列表面板
function UIGuildMemberListPanel:OnApplyListBtnClicked()
    uimanager:CreatePanel("UIGuildApplicationsPanel")

end

---点击一键招人
function UIGuildMemberListPanel:OnRecruitBtnClicked(go)
    local customData = {}
    customData.ID = 89
    customData.CenterCostID = self:GetHiringCost(0)
    customData.CenterCostNum = self:GetHiringCost(1)
    customData.CenterCallBack = function(go)
        if self:IsPlayerCostEnough() then
            networkRequest.ReqOneKeyRecruit()
            uimanager:ClosePanel("UIGuildAccusePromptPanel")
        else
            Utility.ShowPopoTips(go, self:GetCostNotEnoughDes(), 157)
        end
    end
    uimanager:CreatePanel("UIGuildAccusePromptPanel", nil, customData)
end

---点击仇人列表按钮
function UIGuildMemberListPanel:OnChouRenBtnClicked(go)
    uimanager:CreatePanel("UIGangEnemyListPanel", nil, nil)
end

---@return boolean 玩家货币是否足够
function UIGuildMemberListPanel:IsPlayerCostEnough()
    local playerHas = self:GetBagInfoV2():GetCoinAmount(self:GetHiringCost(0))
    --if res then
    return playerHas >= self:GetHiringCost(1)
    --end
    --return false
end

---@return string 货币不足描述
function UIGuildMemberListPanel:GetCostNotEnoughDes()
    if self.mCostDes == nil then
        local res, costInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(157)
        if res and self:GetHiringCostItemInfo() then
            self.mCostDes = string.format(costInfo.content, self:GetHiringCostItemInfo().name)
        end
    end
    return self.mCostDes
end

---@return TABLE.CFG_ITEMS 招人花费信息
function UIGuildMemberListPanel:GetHiringCostItemInfo()
    if self.mHiringCostItemInfo == nil then
        ___, self.mHiringCostItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self:GetHiringCost(0))
    end
    return self.mHiringCostItemInfo
end

---@param type number 货币id0/货币数目1
---@return number 招人花费
function UIGuildMemberListPanel:GetHiringCost(type)
    if self.mHiringCost == nil then
        self.mHiringCost = CS.Cfg_GlobalTableManager.Instance:HiringUnionMemberCost()
    end
    if self.mHiringCost then
        return self.mHiringCost[type]
    end
    return 0
end

---@return TABLE.CFG_ITEMS 缓存道具表数据
function UIGuildMemberListPanel:GetItemInfoCache(itemId)
    if itemId then
        if self.mItemIdToInfo == nil then
            self.mItemIdToInfo = {}
        end
        local info = self.mItemIdToInfo[itemId]
        if info == nil then
            ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
            self.mItemIdToInfo[itemId] = info
        end
        return info
    end
end
--endregion

return UIGuildMemberListPanel