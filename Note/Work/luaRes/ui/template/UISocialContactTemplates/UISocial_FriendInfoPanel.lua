local UISocial_FriendInfoPanel = {}

--region 局部变量

--endregion

--region 组件
function UISocial_FriendInfoPanel:GetSocialFriendInfoList_UIGridContainer()
    if (self.mApproveList == nil) then
        self.mApproveList = self:Get("bgleft/Scroll View/player", "UIGridContainer")
    end
    return self.mApproveList
end

function UISocial_FriendInfoPanel:GetPlayerInfo_GameObject()
    if (self.mPlayerInfoGo == nil) then
        self.mPlayerInfoGo = self:Get("bgright/PlayerInfo", "GameObject")
    end
    return self.mPlayerInfoGo
end

function UISocial_FriendInfoPanel:GetPlayerInfoHeadIcon_UISprite()
    if (self.mPlayerInfoHeadIcon == nil) then
        self.mPlayerInfoHeadIcon = self:Get("bgright/PlayerInfo/headicon", "UISprite")
    end
    return self.mPlayerInfoHeadIcon
end

function UISocial_FriendInfoPanel:GetPlayerInfoHeadLetter_UILabel()
    if (self.mPlayerInfoHeadLetter == nil) then
        self.mPlayerInfoHeadLetter = self:Get("bgright/PlayerInfo/headicon/letter", "UILabel")
    end
    return self.mPlayerInfoHeadLetter
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoLevel_UILabel()
    if (self.mPlayerInfoLevel == nil) then
        self.mPlayerInfoLevel = self:Get("bgright/PlayerInfo/level", "UILabel")
    end
    return self.mPlayerInfoLevel
end

function UISocial_FriendInfoPanel:GetPlayerInfoSex_UISprite()
    if (self.mPlayerInfoSex == nil) then
        self.mPlayerInfoSex = self:Get("bgright/PlayerInfo/sex", "UISprite")
    end
    return self.mPlayerInfoSex
end

function UISocial_FriendInfoPanel:GetPlayerInfoName_UILabel()
    if (self.mPlayerInfoName == nil) then
        self.mPlayerInfoName = self:Get("bgright/PlayerInfo/name", "UILabel")
    end
    return self.mPlayerInfoName
end

function UISocial_FriendInfoPanel:GetInfoToggle_GameObject()
    if (self.mInfoToggleGo == nil) then
        self.mInfoToggleGo = self:Get("bgright/InfoToggle", "GameObject")
    end
    return self.mInfoToggleGo
end

function UISocial_FriendInfoPanel:GetInfoToggleList_UIGridContainer()
    if (self.mInfoToggleList == nil) then
        self.mInfoToggleList = self:Get("bgright/InfoToggle/ScrollView/ToggleList", "UIGridContainer")
    end
    return self.mInfoToggleList
end

function UISocial_FriendInfoPanel:GetMyPlayerInfoContact_UILabel()
    if (self.mMyPlayerInfoContact == nil) then
        self.mMyPlayerInfoContact = self:Get("bgright/MyInfo/Area/Value", "UILabel")
    end
    return self.mMyPlayerInfoContact
end

function UISocial_FriendInfoPanel:GetMyPlayerInfoPhone_UILabel()
    if (self.mMyPlayerInfoPhone == nil) then
        self.mMyPlayerInfoPhone = self:Get("bgright/MyInfo/Phone/Chat Input/Label", "UILabel")
    end
    return self.mMyPlayerInfoPhone
end

function UISocial_FriendInfoPanel:GetMyPlayerInfoBrief_UILabel()
    if (self.mMyPlayerInfoBiref == nil) then
        self.mMyPlayerInfoBiref = self:Get("bgright/MyInfo/Biref/Chat Input/Label", "UILabel")
    end
    return self.mMyPlayerInfoBiref
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoName_UILabel()
    if (self.mMyFriendPlayerInfoName == nil) then
        self.mMyFriendPlayerInfoName = self:Get("bgright/FriendInfo/Name/Value", "UILabel")
    end
    return self.mMyFriendPlayerInfoName
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoBrief_UILabel()
    if (self.mMyFriendPlayerInfoBiref == nil) then
        self.mMyFriendPlayerInfoBiref = self:Get("bgright/FriendInfo/brief", "UILabel")
    end
    return self.mMyFriendPlayerInfoBiref
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoAffinity_UILabel()
    if (self.mMyFriendPlayerInfoAffinity == nil) then
        self.mMyFriendPlayerInfoAffinity = self:Get("bgright/FriendInfo/Affinity/Value", "UILabel")
    end
    return self.mMyFriendPlayerInfoAffinity
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoArea_UILabel()
    if (self.mMyFriendPlayerInfoArea == nil) then
        self.mMyFriendPlayerInfoArea = self:Get("bgright/FriendInfo/Area/Value", "UILabel")
    end
    return self.mMyFriendPlayerInfoArea
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoPhone_UILabel()
    if (self.mMyFriendPlayerInfoPhone == nil) then
        self.mMyFriendPlayerInfoPhone = self:Get("bgright/FriendInfo/Phone/Value", "UILabel")
    end
    return self.mMyFriendPlayerInfoPhone
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoOther_UIInput()
    if (self.mMyFriendPlayerInfoOtherUIInput == nil) then
        self.mMyFriendPlayerInfoOtherUIInput = self:Get("bgright/FriendInfo/Other/Chat Input", "UIInput")
    end
    return self.mMyFriendPlayerInfoOtherUIInput
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoOther_UILabel()
    if (self.mMyFriendPlayerInfoOther == nil) then
        self.mMyFriendPlayerInfoOther = self:Get("bgright/FriendInfo/Other/Chat Input/Label", "UILabel")
    end
    return self.mMyFriendPlayerInfoOther
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfo_GameObject()
    if (self.mMyFriendPlayerInfo == nil) then
        self.mMyFriendPlayerInfo = self:Get("bgright/FriendInfo", "GameObject")
    end
    return self.mMyFriendPlayerInfo
end

function UISocial_FriendInfoPanel:GetMyFriendPlayerInfoContact_UILabel()
    if (self.mMyFriendPlayerInfoContact == nil) then
        self.mMyFriendPlayerInfoContact = self:Get("bgright/FriendInfo/Contact/Value", "UILabel")
    end
    return self.mMyFriendPlayerInfoContact
end

function UISocial_FriendInfoPanel:GetMyPlayerInfoDelBtn_GameObject()
    if (self.MyPlayerInfoChatBtn == nil) then
        self.MyPlayerInfoChatBtn = self:Get("bgright/FriendInfo/ChatBtn", "GameObject")
    end
    return self.MyPlayerInfoChatBtn
end

--region 原AddFriendPanel
function UISocial_FriendInfoPanel:GetSearchFriendInput_UIInput()
    if (self.mSearchFriendUIInput == nil) then
        self.mSearchFriendUIInput = self:Get("bgright/SearchInfo/Chat Input", "UIInput")
    end
    return self.mSearchFriendUIInput
end

function UISocial_FriendInfoPanel:GetSearchFriendBtn_GameObject()
    if (self.mSearchFriendBtn == nil) then
        self.mSearchFriendBtn = self:Get("bgright/SearchInfo/btn_search", "GameObject")
    end
    return self.mSearchFriendBtn
end

function UISocial_FriendInfoPanel:GetSearchFriendTitle_UILabel()
    if (self.mSearchFriendTitleLabel == nil) then
        self.mSearchFriendTitleLabel = self:Get("bgright/SearchInfo/SearchPeople/Label", "UILabel")
    end
    return self.mSearchFriendTitleLabel
end

function UISocial_FriendInfoPanel:GetAddFriendList_UIGridContainer()
    if (self.mApplyList == nil) then
        self.mApplyList = self:Get("bgright/SearchInfo/SearchPeople/Scroll View/player", "UIGridContainer")
    end
    return self.mApplyList
end

function UISocial_FriendInfoPanel:GetSearchResultPanel_GameObject()
    if (self.mSearchResultPanel == nil) then
        self.mSearchResultPanel = self:Get("bgright/SearchInfo/SearchPeople", "GameObject")
    end
    return self.mSearchResultPanel
end

function UISocial_FriendInfoPanel:GetKnowPeopleResultPanel_GameObject()
    if (self.mKnowPeopleResultPanel == nil) then
        self.mKnowPeopleResultPanel = self:Get("bgright/SearchInfo/KnowPeople", "GameObject")
    end
    return self.mKnowPeopleResultPanel
end

function UISocial_FriendInfoPanel:GetSearchFriendInput_UILabel()
    if (self.mSearchFriendLabel == nil) then
        self.mSearchFriendLabel = self:Get("bgright/SearchInfo/Chat Input/Label", "UILabel")
    end
    return self.mSearchFriendLabel
end

function UISocial_FriendInfoPanel:GetSearchInfoRoot_GameObject()
    if (self.mSearchInfoRootGo == nil) then
        self.mSearchInfoRootGo = self:Get("bgright/SearchInfo", "GameObject")
    end
    return self.mSearchInfoRootGo
end

function UISocial_FriendInfoPanel:GetMayKnowFriendList_UIGridContainer()
    if (self.mMayKnowList == nil) then
        self.mMayKnowList = self:Get("bgright/SearchInfo/KnowPeople/Scroll View/player", "UIGridContainer")
    end
    return self.mMayKnowList
end
--endregion
--endregion

--region 初始化
function UISocial_FriendInfoPanel:Init(panel)
    self.templateTable = {}
    self.FriendTemplates = {}
    self.FriendTemplatesID = {}
    self.FriendRelationFuncTemplates = {}
    self.RelationBtnNeedDelTable = {}
    self.IsFriendTypeSwitch = false
    self.IsSpouseTypeSwitch = false
    self.IsBrotherTypeSwitch = false
    self.SocialContactPanel = panel
    self.mCurChooseTem = nil
    self.mAddBtnLevel = nil
    self.mAddBtnhaogandu = nil
    self.mAddBtncontact = nil
    self.mAddBtnletter = nil
    self.mAddBtnicon = nil
    self.mAddBtnaddfriend = nil
    self.mAddBtncheck = nil
    self.mAddRedPoint = nil
    self.mInfo = nil
    self.FuncBtnGroupList = CS.System.Collections.Generic["List`1[System.Int32]"]()
    self.isJumpToFriend = true
    self.SetAddBtnState = false
    self:BindUIEvents()
end

function UISocial_FriendInfoPanel:Show()
    self.go:SetActive(true)
    if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply)) then
        self:ResFriendList(LuaEnumSocialLieBiaoType.ZuiJinLieBiao)
        self:CheckAddFriendList()
    else
        self:ResFriendList(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
        self:IsJumpToFriend(true)
    end
end

function UISocial_FriendInfoPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetSearchFriendBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetSearchFriendBtn_GameObject()).OnClickLuaDelegate = self.SearchFriendBtnOnClick
    CS.UIEventListener.Get(self:GetMyPlayerInfoDelBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetMyPlayerInfoDelBtn_GameObject()).OnClickLuaDelegate = self.DeleteBtnOnClick

    self:GetSearchFriendInput_UIInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetSearchFriendInput_UIInput().onSubmit, function(go)
        if (self:GetSearchFriendInput_UILabel().text == "请输入查询的玩家人物名") then
            self:CheckAddFriendList()
        end
    end)

    self:GetMyFriendPlayerInfoOther_UIInput().submitOnUnselect = true
    CS.EventDelegate.Add(self:GetMyFriendPlayerInfoOther_UIInput().onSubmit, function(go)
        networkRequest.ReqEditRemark(self.mCurChooseTem.rid, self:GetMyFriendPlayerInfoOther_UIInput().value)
    end)

end
--endregion

--region 刷新界面
function UISocial_FriendInfoPanel:RefreshAddFriendList(go)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdateApplyFriendIsReceive(self.info.rid)
end

function UISocial_FriendInfoPanel:SetInfoToggleList(info)
    local isFind, result = CS.Cfg_GlobalTableManager.Instance.FriendFuncDic:TryGetValue(info.relation)
    if (isFind) then
        if (result ~= nil) then
            self:SetRelationBtnGroup(result)
        end
    else
        self:GetInfoToggleList_UIGridContainer().MaxCount = 0
    end
end

function UISocial_FriendInfoPanel:SetRelationBtnGroup(BtnGroup)
    self.RelationBtnNeedDelTable = {}
    self.FuncBtnGroupList:Clear()
    self.FuncBtnGroupList:AddRange(BtnGroup)
    self:GetNeedDelRelationBtn(self.FuncBtnGroupList)
    local count = Utility.GetLuaTableCount(self.RelationBtnNeedDelTable)
    table.sort(self.RelationBtnNeedDelTable, function(a, b)
        return a < b
    end
    )
    if (count ~= 0) then
        for i = count, 1, -1 do
            local index = self.RelationBtnNeedDelTable[i]
            self.FuncBtnGroupList:RemoveAt(index)
        end
    end

    self:GetInfoToggleList_UIGridContainer().MaxCount = self.FuncBtnGroupList.Count
    for k = 1, self.FuncBtnGroupList.Count do
        local go = self:GetInfoToggleList_UIGridContainer().transform:GetChild(k)
        if (self.FriendRelationFuncTemplates[go] == nil) then
            self.FriendRelationFuncTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIFriendRelationFunctionTemplates, self, self.SocialContactPanel)
        end
        self.FriendRelationFuncTemplates[go].index = k - 1
        self.FriendRelationFuncTemplates[go]:InitTemplates(self.mCurChooseTem, tonumber(self.FuncBtnGroupList[k - 1]))
        self.FriendRelationFuncTemplates[go]:BindUIEvents()
    end
    --self:RefreshRelationFuncListTemIndex()
end

function UISocial_FriendInfoPanel:GetNeedDelRelationBtn(BtnGroup)
    for i = 0, BtnGroup.Count - 1 do
        if (BtnGroup[i] == LuaEnumFriendRelationFuncType.Team) then
            local GroupInfoV2 = CS.CSScene.MainPlayerInfo.GroupInfoV2
            if GroupInfoV2 ~= nil then
                --主角无队伍
                local TeamID = self.SocialContactPanel.TeamID
                if GroupInfoV2.PlayerInfoList.Count ~= 0 and TeamID ~= 0 then
                    --删除按钮
                    table.insert(self.RelationBtnNeedDelTable, i)
                end
            end
        else
            if (BtnGroup[i] == LuaEnumFriendRelationFuncType.Union) then
                local UnionInfo = CS.CSScene.MainPlayerInfo.UnionInfoV2
                local GuildID = self.SocialContactPanel.GuildID

                local levelArrive = CS.CSUnionInfoV2.IsLevelCanJoinUnion(CS.CSScene.MainPlayerInfo.Level)
                -- 本人无行会且达到入会等级，对方有行会，则点击对方头像，显示申请入会
                if UnionInfo and UnionInfo.UnionInfo then
                    local myPos = UnionInfo:GetCurrentPosition()
                    local canInvite = CS.CSUnionInfoV2.HasUnionApprovalAuthority(myPos)
                    --本人有行会且达到审批职位，对方无行会且达到入会等级，点击对方头像，显示邀请入会
                    if UnionInfo.UnionID == 0 and GuildID ~= 0 and levelArrive then
                    elseif UnionInfo.UnionID ~= 0 and GuildID == 0 and canInvite and levelArrive then
                    else
                        ---删除按钮
                        table.insert(self.RelationBtnNeedDelTable, i)
                    end
                elseif GuildID ~= 0 and levelArrive then
                else
                    ---删除按钮
                    table.insert(self.RelationBtnNeedDelTable, i)
                end
            end
        end
    end


end

function UISocial_FriendInfoPanel:ShowPlayerDetails(info)
    if (self.mCurChooseTem.info.relation == LuaEnumSocialFriendRelationType.Brother or self.mCurChooseTem.info.relation == LuaEnumSocialFriendRelationType.Spouse) then
        self:GetMyPlayerInfoDelBtn_GameObject():SetActive(false)
    else
        self:GetMyPlayerInfoDelBtn_GameObject():SetActive(true)
    end
    self:GetMyFriendPlayerInfo_GameObject():SetActive(true)
    self:GetMyFriendPlayerInfoContact_UILabel().text = uiStaticParameter.FriendRelation[tonumber(info.relation)]
    if (CS.System.String.IsNullOrEmpty(info.brief)) then
        self:GetMyFriendPlayerInfoBrief_UILabel().text = CS.Utility_Lua.GetRandomBrief()
    else
        self:GetMyFriendPlayerInfoBrief_UILabel().text = info.brief
    end
    self:GetMyFriendPlayerInfoName_UILabel().text = info.name
    self:GetMyFriendPlayerInfoLevel_UILabel().text = info.level
    self:GetMyFriendPlayerInfoAffinity_UILabel().text = info.friendLove
    local address = info.address:Split("&")
    if (#address ~= 0) then
        self:GetMyFriendPlayerInfoArea_UILabel().text = address[1] .. " " .. address[2]
    else
        self:GetMyFriendPlayerInfoArea_UILabel().text = ""
    end
    self:GetMyFriendPlayerInfoPhone_UILabel().text = info.contactWay
    --self:GetMyFriendPlayerInfoOther_UILabel().text
    self:GetMyFriendPlayerInfoOther_UIInput().value = info.remark == "" and "点击编辑备注" or info.remark
end

function UISocial_FriendInfoPanel:SetPlayerInfo(info)
    self:GetPlayerInfoHeadIcon_UISprite().spriteName = "headicon" .. info.sex .. info.career
    if (CS.System.String.IsNullOrEmpty(info.roleLettering)) then
        self:GetPlayerInfoHeadLetter_UILabel().gameObject:SetActive(false)
    else
        self:GetPlayerInfoHeadLetter_UILabel().gameObject:SetActive(true)
        self:GetPlayerInfoHeadLetter_UILabel().text = info.roleLettering
    end
    --if (CS.System.String.IsNullOrEmpty(info.remark)) then
    self:GetPlayerInfoName_UILabel().text = info.name
    --else
    --    self:GetPlayerInfoName_UILabel().text = info.remark
    --end
    if (info.sex == 1) then
        self:GetPlayerInfoSex_UISprite().spriteName = "men"
    else
        self:GetPlayerInfoSex_UISprite().spriteName = "women"
    end
end

function UISocial_FriendInfoPanel:SortFriendList()
    CS.CSScene.MainPlayerInfo.FriendInfoV2:SortListInType(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
end

function UISocial_FriendInfoPanel:IsJumpToFriend(isJump)
    if (isJump) then
        if (self:GetSocialFriendInfoList_UIGridContainer().controlList.Count > 1) then
            self.FriendTemplates[self:GetSocialFriendInfoList_UIGridContainer().controlList[1]]:SocialFriendOnClick()
        else
            self:CheckAddFriendList()
        end
    else
        self:CheckAddFriendList()
    end
end

function UISocial_FriendInfoPanel:Hide()
    self.go:SetActive(false)
    --self.mSelectCheckFriend = false
    self:GetSearchFriendInput_UIInput().value = ""
    self:GetSearchResultPanel_GameObject():SetActive(false)
    self:GetSearchInfoRoot_GameObject():SetActive(false)
    self:GetPlayerInfo_GameObject():SetActive(false)
    self:GetInfoToggle_GameObject():SetActive(false)
    self:GetMyFriendPlayerInfo_GameObject():SetActive(false)
end
--endregion

--region 事件
function UISocial_FriendInfoPanel:DeleteBtnOnClick()
    if (self.mCurChooseTem.info.relation == LuaEnumSocialFriendRelationType.ENEMY) then
        ---移除好友列表
        networkRequest.ReqDeleteFriend(LuaEnumSocialLieBiaoType.HaoYouLieBiao, self.mCurChooseTem.info.rid)
        ---移除聊天列表
        networkRequest.ReqDeleteFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, self.mCurChooseTem.info.rid)
    else
        local text = "[6F6F6FFF]确定和[-]" .. self.mCurChooseTem.info.name .. "[6F6F6FFF]解除好友关系吗？[-]\\n[FF0000FF](关系解除将清空亲密度)[-]"
        local CancelInfo = {
            Content = string.format(string.gsub(text, "\\n", '\n', 1)),
            IsShowCloseBtn = true,
            CenterDescription = "确定",
            CallBack = function()
                ---移除好友列表
                networkRequest.ReqDeleteFriend(LuaEnumSocialLieBiaoType.HaoYouLieBiao, self.mCurChooseTem.info.rid)
                ---移除聊天列表
                networkRequest.ReqDeleteFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, self.mCurChooseTem.info.rid)
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
    end
end

function UISocial_FriendInfoPanel:SearchFriendBtnOnClick()
    --self:GetKnowPeople_GameObject():SetActive(false)
    if (not CS.System.String.IsNullOrEmpty(self:GetSearchFriendInput_UILabel().text)) then
        networkRequest.ReqSearchFriend(self:GetSearchFriendInput_UILabel().text)
    end
end

--endregion

--region 服务器消息处理
--region 原AddFriendPanel
function UISocial_FriendInfoPanel:RefreshAddControListTemIndex()
    local Length = self:GetAddFriendList_UIGridContainer().controlList.Count
    self:GetAddFriendList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetAddFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] ~= nil) then
            self.templateTable[go].index = k
        end
    end
end

function UISocial_FriendInfoPanel:RefreshRelationFuncListTemIndex()
    local Length = self:GetInfoToggleList_UIGridContainer().controlList.Count
    self:GetInfoToggleList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetInfoToggleList_UIGridContainer().controlList[k]
        if (self.templateTable[go] ~= nil) then
            self.templateTable[go].index = k
        end
    end
end

function UISocial_FriendInfoPanel:RefreshKnowControListTemIndex()
    local Length = self:GetMayKnowFriendList_UIGridContainer().controlList.Count
    self:GetMayKnowFriendList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetMayKnowFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] ~= nil) then
            self.templateTable[go].index = k
        end
    end
end

function UISocial_FriendInfoPanel:ResAddFriendInfo(id, info)
    self:GetKnowPeopleResultPanel_GameObject():SetActive(false)
    self:GetSearchResultPanel_GameObject():SetActive(true)
    if (info == nil or info.list == nil or info.list.Count == 0) then
        self:GetSearchFriendTitle_UILabel().text = "未搜索到相关玩家"
        self:GetAddFriendList_UIGridContainer().MaxCount = 0
        return
    end
    self:GetSearchFriendTitle_UILabel().text = "搜索'" .. self:GetSearchFriendInput_UILabel().text .. "'符合条件的结果"
    local Length = info.list.Count
    self:GetAddFriendList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetAddFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] == nil) then
            self.templateTable[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAddFriendInfoTemplates, self)
        end
        self.templateTable[go]:SetRoleHeadIcon(info.list[k].sex, info.list[k].career)
        self.templateTable[go].index = k
        self.templateTable[go]:InitParameters(info.list[k])
        self.templateTable[go]:RefreshAddUI()
        self.templateTable[go]:BindAddUIEvents()
    end
end

function UISocial_FriendInfoPanel:SetAddFriendBtn(go)
    self.SetAddBtnState = true
    if (self.mCurChooseTem ~= nil) then
        self.mCurChooseTem.di_GameObject:SetActive(false)
    end
    if (self.mAddBtnLevel == nil) then
        self.mAddBtnLevel = CS.Utility_Lua.GetComponent(go.transform:Find("level"), "GameObject")
    end
    if (self.mAddBtnhaogandu == nil) then
        self.mAddBtnhaogandu = CS.Utility_Lua.GetComponent(go.transform:Find("haogandu"), "GameObject")
    end
    if (self.mAddBtncontact == nil) then
        self.mAddBtncontact = CS.Utility_Lua.GetComponent(go.transform:Find("contact"), "GameObject")
    end
    if (self.mAddBtnletter == nil) then
        self.mAddBtnletter = CS.Utility_Lua.GetComponent(go.transform:Find("icon/letter"), "GameObject")
    end
    if (self.mAddBtnicon == nil) then
        self.mAddBtnicon = CS.Utility_Lua.GetComponent(go.transform:Find("icon"), "GameObject")
    end
    if (self.mAddBtnaddfriend == nil) then
        self.mAddBtnaddfriend = CS.Utility_Lua.GetComponent(go.transform:Find("addfriend"), "GameObject")
    end
    if (self.mAddRedPoint == nil) then
        self.mAddRedPoint = CS.Utility_Lua.GetComponent(go.transform:Find("redpoint"), "UIRedPoint")
    end

    self.mAddRedPoint:AddRedPointKey(CS.RedPointKey.FriendApply)
    self.mAddBtnLevel:SetActive(false)
    self.mAddBtnhaogandu:SetActive(false)
    self.mAddBtncontact:SetActive(false)
    self.mAddBtnletter:SetActive(false)
    self.mAddBtnicon:SetActive(false)
    self.mAddBtnaddfriend:SetActive(true)
    if (self.mAddBtncheck == nil) then
        self.mAddBtncheck = CS.Utility_Lua.GetComponent(go.transform:Find("check"), "GameObject")
    end
    local name = go.transform:Find("name")
    CS.Utility_Lua.GetComponent(name, "UILabel").text = "新的好友"
    name.localPosition = CS.UnityEngine.Vector3(-30, 0, 0)
    CS.UIEventListener.Get(go).LuaEventTable = self
    CS.UIEventListener.Get(go).OnClickLuaDelegate = self.CheckAddFriendList
end

function UISocial_FriendInfoPanel:CheckAddFriendList()
    self.isJumpToFriend = false
    if (self.mAddBtncheck ~= nil) then
        self.mAddBtncheck:SetActive(true)
    end
    if (self.mCurChooseTem ~= nil) then
        self.mCurChooseTem.di_GameObject:SetActive(false)
    end
    self:GetSearchInfoRoot_GameObject():SetActive(true)
    self:GetKnowPeopleResultPanel_GameObject():SetActive(true)
    self:GetSearchResultPanel_GameObject():SetActive(false)
    self:GetPlayerInfo_GameObject():SetActive(false)
    self:GetInfoToggle_GameObject():SetActive(false)
    self:GetMyFriendPlayerInfo_GameObject():SetActive(false)
    self:ResFriendList(LuaEnumSocialLieBiaoType.ShenQingLieBiao)
    if (CS.CSUIRedPointManager.GetInstance():GetRedPointValue(CS.RedPointKey.FriendApply)) then
        CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Remove(1)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FriendApply)
        networkRequest.ReqLookApplicant()
    end
end
--endregion

function UISocial_FriendInfoPanel:ReFreshTemplateInfo(id, data)
    local Length = data.friend.Count
    for k = 0, Length - 1 do
        for m, n in pairs(self.FriendTemplatesID) do
            if (self.FriendTemplates[n].rid == data.friend[k].rid) then
                self.FriendTemplates[n].info = data.friend[k]
                self.FriendTemplates[n]:RefreshUI()
            end
        end
    end
end

function UISocial_FriendInfoPanel:ResFriendLoveChange(info)
    if (self.FriendTemplates[self.FriendTemplatesID[info.targetId]] ~= nil) then
        self.FriendTemplates[self.FriendTemplatesID[info.targetId]].info.friendLove = info.friendLove
        self.FriendTemplates[self.FriendTemplatesID[info.targetId]]:RefreshUI()
    end
    if (self.mCurChooseTem ~= nil) then
        self.mCurChooseTemID = self.mCurChooseTem.rid
    end
    self:ResFriendList(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
    if (info.targetId ~= nil and self.FriendTemplatesID ~= nil and self.FriendTemplatesID[info.targetId] ~= nil and self.FriendTemplates ~= nil and self.FriendTemplates[self.FriendTemplatesID[info.targetId]] ~= nil) then
        self.FriendTemplates[self.FriendTemplatesID[info.targetId]]:SocialFriendOnClick()
    end
end

function UISocial_FriendInfoPanel:ResFriendList(type)
    if (type == LuaEnumSocialLieBiaoType.ShenQingLieBiao) then
        local allreceive = true
        local applyList = {}
        local applyIsReceiveList = {}
        local friends = self.SocialContactPanel.GetCSFriendInfoV2FriendDic(LuaEnumSocialLieBiaoType.ShenQingLieBiao)
        local mayKnowList = CS.CSScene.MainPlayerInfo.FriendInfoV2.MayKnowList
        if (friends ~= nil) then
            for i = 0, friends.Count - 1 do
                if (friends[i].isReceive == false) then
                    allreceive = false
                    table.insert(applyList, friends[i])
                else
                    table.insert(applyIsReceiveList, friends[i])
                end
            end
        end
        if (mayKnowList ~= nil) then
            for j = 0, mayKnowList.Count - 1 do
                table.insert(applyList, mayKnowList[j])
            end
        end
        for i = 1, Utility.GetLuaTableCount(applyIsReceiveList) do
            table.insert(applyList, applyIsReceiveList[i])
        end

        local Length = Utility.GetLuaTableCount(applyList)
        self:GetMayKnowFriendList_UIGridContainer().MaxCount = Length

        for k = 0, Length - 1 do
            local go = self:GetMayKnowFriendList_UIGridContainer().controlList[k]
            local info
            local knowcausetype = nil
            if (applyList[k + 1].info == nil) then
                info = applyList[k + 1]
            else
                info = applyList[k + 1].info
                knowcausetype = applyList[k + 1].type
            end
            if (self.templateTable[go] == nil) then
                self.templateTable[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAddFriendInfoTemplates, self)
            end
            self.templateTable[go].index = k
            self.templateTable[go]:SetRoleHeadIcon(info.sex, info.career)
            self.templateTable[go]:InitParameters(info)
            self.templateTable[go].knowcausetype = knowcausetype
            self.templateTable[go]:RefreshApplyUI()
            if (knowcausetype ~= nil) then
                self.templateTable[go]:BindMayUIEvents()
            else
                self.templateTable[go]:BindApplyUIEvents()
            end
        end
        if (self.isJumpToFriend == true and allreceive) then
            if (self:GetSocialFriendInfoList_UIGridContainer().controlList.Count > 1) then
                self.FriendTemplates[self:GetSocialFriendInfoList_UIGridContainer().controlList[1]]:SocialFriendOnClick()
            end
        end
        return
    else
        local friends = self.SocialContactPanel.GetCSFriendInfoV2FriendDic(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
        if (friends == nil or friends.Count == 0) then
            self:GetSocialFriendInfoList_UIGridContainer().MaxCount = 0
            return
        end
        self:SortFriendList()
        self:GetSocialFriendInfoList_UIGridContainer().MaxCount = friends.Count
        ---新的好友按钮特殊处理
        if (self.SetAddBtnState == false) then
            local go = self:GetSocialFriendInfoList_UIGridContainer().controlList[0]
            self:SetAddFriendBtn(go)
        end

        local Length = friends.Count - 1
        for k = 1, Length do
            local go = self:GetSocialFriendInfoList_UIGridContainer().controlList[k]
            if (self.FriendTemplates[go] == nil) then
                self.FriendTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISocialFriendInfoTemplates, self)
            end
            self.FriendTemplates[go]:InitParameters(friends[k])
            self.FriendTemplates[go]:SetRoleHeadIcon(friends[k].sex, friends[k].career)
            self.FriendTemplatesID[friends[k].rid] = go
            self.FriendTemplates[go].index = k + 1
            self.FriendTemplates[go]:RefreshUI()
        end
        if (friends.Count == 1) then
            self:CheckAddFriendList()
        end
    end
end

function UISocial_FriendInfoPanel:ResFriendInfo(csdata)
    if (csdata.type == LuaEnumSocialLieBiaoType.HaoYouLieBiao) then
        for k, v in pairs(self.FriendTemplates) do
            if (v.rid == csdata.friend.rid) then
                v:InitParameters(csdata.friend)
                v:RefreshUI()
            end
        end
    end
end

function UISocial_FriendInfoPanel:ResFriendIsOnLine(type)
    local friends = self.SocialContactPanel.GetCSFriendInfoV2FriendDic(type)
    if (friends == nil or friends.Count == 0) then
        return
    end
    local Length = friends.Count - 1
    for k = 1, Length do
        local go = self:GetSocialFriendInfoList_UIGridContainer().controlList[k]
        if (self.FriendTemplates[go] ~= nil) then
            self.FriendTemplates[go]:SetRoleHeadIcon(friends[k].sex, friends[k].career)
        end
    end
end

function UISocial_FriendInfoPanel:ResPersonalInfo(info, csinfo)
    self.mInfo = info
    self:GetPlayerInfo_GameObject():SetActive(true)
    self:GetInfoToggle_GameObject():SetActive(true)
    self:SetPlayerInfo(info)
    self:ShowPlayerDetails(info)
    if (self.mCurChooseTem ~= nil) then
        self.mCurChooseTem:RefreshUI()
    end
end

function UISocial_FriendInfoPanel:ResRefreshInfoToggle()
    if (self.mInfo ~= nil) then
        self:SetInfoToggleList(self.mInfo)
    end
end
--endregion

return UISocial_FriendInfoPanel