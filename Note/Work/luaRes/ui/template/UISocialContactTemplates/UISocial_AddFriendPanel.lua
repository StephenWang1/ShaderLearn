local UISocial_AddFriendPanel = {}

--region 局部变量

--endregion

--region 组件
--region View
function UISocial_AddFriendPanel:GetSearchFriendTitle_UILabel()
    if (self.mSearchFriendTitleLabel == nil) then
        self.mSearchFriendTitleLabel = self:Get("bgright/SearchInfo/SearchPeople/Label", "UILabel")
    end
    return self.mSearchFriendTitleLabel
end

function UISocial_AddFriendPanel:GetSearchFriendInput_UILabel()
    if (self.mSearchFriendLabel == nil) then
        self.mSearchFriendLabel = self:Get("bgright/SearchInfo/Chat Input/Label", "UILabel")
    end
    return self.mSearchFriendLabel
end

function UISocial_AddFriendPanel:GetSearchResultPanel_GameObject()
    if (self.mSearchResultPanel == nil) then
        self.mSearchResultPanel = self:Get("bgright/SearchInfo/SearchPeople", "GameObject")
    end
    return self.mSearchResultPanel
end

function UISocial_AddFriendPanel:GetKnowPeopleResultPanel_GameObject()
    if (self.mKnowPeopleResultPanel == nil) then
        self.mKnowPeopleResultPanel = self:Get("bgright/SearchInfo/KnowPeople", "GameObject")
    end
    return self.mKnowPeopleResultPanel
end

function UISocial_AddFriendPanel:GetKnowPeopleEndTips_GameObject()
    if (self.mKnowPeopleEndTips == nil) then
        self.mKnowPeopleEndTips = self:Get("bgright/SearchInfo/KnowPeople/EndTips", "GameObject")
    end
    return self.mKnowPeopleEndTips
end

function UISocial_AddFriendPanel:GetApproveFriendList_UIGridContainer()
    if (self.mApproveList == nil) then
        self.mApproveList = self:Get("bgleft/Scroll View/player", "UIGridContainer")
    end
    return self.mApproveList
end

function UISocial_AddFriendPanel:GetAddFriendList_UIGridContainer()
    if (self.mApplyList == nil) then
        self.mApplyList = self:Get("bgright/SearchInfo/SearchPeople/Scroll View/player", "UIGridContainer")
    end
    return self.mApplyList
end

function UISocial_AddFriendPanel:GetMayKnowFriendList_UIGridContainer()
    if (self.mMayKnowList == nil) then
        self.mMayKnowList = self:Get("bgright/SearchInfo/KnowPeople/Scroll View/player", "UIGridContainer")
    end
    return self.mMayKnowList
end

function UISocial_AddFriendPanel:GetSearchInfoRoot_GameObject()
    if (self.mSearchInfoRootGo == nil) then
        self.mSearchInfoRootGo = self:Get("bgright/SearchInfo", "GameObject")
    end
    return self.mSearchInfoRootGo
end
--region 原FriendInfoPanel
function UISocial_AddFriendPanel:GetMyPlayerInfo_GameObject()
    if (self.mMyPlayerInfo == nil) then
        self.mMyPlayerInfo = self:Get("bgright/MyInfo", "GameObject")
    end
    return self.mMyPlayerInfo
end

function UISocial_AddFriendPanel:GetMyPlayerInfoBrief_UIInput()
    if (self.mMyPlayerInfoBirefUIInput == nil) then
        self.mMyPlayerInfoBirefUIInput = self:Get("bgright/MyInfo/Biref/Chat Input", "UIInput")
    end
    return self.mMyPlayerInfoBirefUIInput
end

function UISocial_AddFriendPanel:GetMyPlayerInfoPhone_UIInput()
    if (self.mMyPlayerInfoPhoneUIInput == nil) then
        self.mMyPlayerInfoPhoneUIInput = self:Get("bgright/MyInfo/Phone/Chat Input", "UIInput")
    end
    return self.mMyPlayerInfoPhoneUIInput
end

function UISocial_AddFriendPanel:GetMyPlayerInfoConfirmBtn_GameObject()
    if (self.MyPlayerInfoConfirmBtn == nil) then
        self.MyPlayerInfoConfirmBtn = self:Get("bgright/MyInfo/ConfirmBtn", "GameObject")
    end
    return self.MyPlayerInfoConfirmBtn
end

function UISocial_AddFriendPanel:GetPlayerInfo_GameObject()
    if (self.mPlayerInfoGo == nil) then
        self.mPlayerInfoGo = self:Get("bgright/PlayerInfo", "GameObject")
    end
    return self.mPlayerInfoGo
end

function UISocial_AddFriendPanel:GetPlayerInfoHeadIcon_UISprite()
    if (self.mPlayerInfoHeadIcon == nil) then
        self.mPlayerInfoHeadIcon = self:Get("bgright/PlayerInfo/headicon", "UISprite")
    end
    return self.mPlayerInfoHeadIcon
end

function UISocial_AddFriendPanel:GetPlayerInfoHeadLetter_UILabel()
    if (self.mPlayerInfoHeadLetter == nil) then
        self.mPlayerInfoHeadLetter = self:Get("bgright/PlayerInfo/headicon/letter", "UILabel")
    end
    return self.mPlayerInfoHeadLetter
end

function UISocial_AddFriendPanel:GetMyFriendPlayerInfoLevel_UILabel()
    if (self.mPlayerInfoLevel == nil) then
        self.mPlayerInfoLevel = self:Get("bgright/PlayerInfo/level", "UILabel")
    end
    return self.mPlayerInfoLevel
end

function UISocial_AddFriendPanel:GetPlayerInfoSex_UISprite()
    if (self.mPlayerInfoSex == nil) then
        self.mPlayerInfoSex = self:Get("bgright/PlayerInfo/sex", "UISprite")
    end
    return self.mPlayerInfoSex
end

function UISocial_AddFriendPanel:GetPlayerInfoName_UILabel()
    if (self.mPlayerInfoName == nil) then
        self.mPlayerInfoName = self:Get("bgright/PlayerInfo/name", "UILabel")
    end
    return self.mPlayerInfoName
end

function UISocial_AddFriendPanel:GetMyPlayerInfoBrief_UILabel()
    if (self.mMyPlayerInfoBiref == nil) then
        self.mMyPlayerInfoBiref = self:Get("bgright/MyInfo/Biref/Chat Input/Label", "UILabel")
    end
    return self.mMyPlayerInfoBiref
end

function UISocial_AddFriendPanel:GetInfoToggle_GameObject()
    if (self.mInfoToggleGo == nil) then
        self.mInfoToggleGo = self:Get("bgright/InfoToggle", "GameObject")
    end
    return self.mInfoToggleGo
end

function UISocial_AddFriendPanel:GetAutoFriendContact_GameObject()
    if (self.mAutoFriendContact == nil) then
        self.mAutoFriendContact = self:Get("bgright/MyInfo/Phone/AutoFriendContact", "GameObject")
    end
    return self.mAutoFriendContact
end

function UISocial_AddFriendPanel:GetAutoFriendContact_UISprite()
    if (self.mAutoFriendContactUISprite == nil) then
        self.mAutoFriendContactUISprite = self:Get("bgright/MyInfo/Phone/AutoFriendContact/Sprite", "UISprite")
    end
    return self.mAutoFriendContactUISprite
end

function UISocial_AddFriendPanel:GetAutoFriendContact_Transform()
    if (self.mAutoFriendContactTransform == nil) then
        self.mAutoFriendContactTransform = self:Get("bgright/MyInfo/Phone/AutoFriendContact/thumb", "Transform")
    end
    return self.mAutoFriendContactTransform
end

function UISocial_AddFriendPanel:GetAutoCoupleContact_GameObject()
    if (self.mAutoCoupleContact == nil) then
        self.mAutoCoupleContact = self:Get("bgright/MyInfo/Phone/AutoCoupleContact", "GameObject")
    end
    return self.mAutoCoupleContact
end

function UISocial_AddFriendPanel:GetAutoCoupleContact_UISprite()
    if (self.mAutoCoupleContactUISprite == nil) then
        self.mAutoCoupleContactUISprite = self:Get("bgright/MyInfo/Phone/AutoCoupleContact/Sprite", "UISprite")
    end
    return self.mAutoCoupleContactUISprite
end

function UISocial_AddFriendPanel:GetAutoCoupleContact_Transform()
    if (self.mAutoCoupleContactTransform == nil) then
        self.mAutoCoupleContactTransform = self:Get("bgright/MyInfo/Phone/AutoCoupleContact/thumb", "Transform")
    end
    return self.mAutoCoupleContactTransform
end

function UISocial_AddFriendPanel:GetAutoBrothersContact_GameObject()
    if (self.mAutoBrothersContact == nil) then
        self.mAutoBrothersContact = self:Get("bgright/MyInfo/Phone/AutoBrothersContact", "GameObject")
    end
    return self.mAutoBrothersContact
end

function UISocial_AddFriendPanel:GetAutoBrothersContact_UISprite()
    if (self.mAutoBrothersContactUISprite == nil) then
        self.mAutoBrothersContactUISprite = self:Get("bgright/MyInfo/Phone/AutoBrothersContact/Sprite", "UISprite")
    end
    return self.mAutoBrothersContactUISprite
end

function UISocial_AddFriendPanel:GetAutoBrothersContact_Transform()
    if (self.mAutoBrothersContactTransform == nil) then
        self.mAutoBrothersContactTransform = self:Get("bgright/MyInfo/Phone/AutoBrothersContact/thumb", "Transform")
    end
    return self.mAutoBrothersContactTransform
end

function UISocial_AddFriendPanel:GetInfoToggleList_UIGridContainer()
    if (self.mInfoToggleList == nil) then
        self.mInfoToggleList = self:Get("bgright/InfoToggle/ScrollView/ToggleList", "UIGridContainer")
    end
    return self.mInfoToggleList
end

function UISocial_AddFriendPanel:GetMyPlayerInfoLevel_UILabel()
    if (self.MyPlayerInfoLevel == nil) then
        self.MyPlayerInfoLevel = self:Get("bgright/MyInfo/level", "UILabel")
    end
    return self.MyPlayerInfoLevel
end

function UISocial_AddFriendPanel:GetProvinceDropDown_UIDropDown()
    if (self.mProvinceDropDown == nil) then
        self.mProvinceDropDown = self:Get("bgright/MyInfo/Area/DropDown1", "Top_UIDropDown")
    end
    return self.mProvinceDropDown
end

function UISocial_AddFriendPanel:GetProvinceDropDown_UILabel()
    if (self.mProvinceUILabel == nil) then
        self.mProvinceUILabel = self:Get("bgright/MyInfo/Area/DropDown1/Caption/CaptionLabel", "UILabel")
    end
    return self.mProvinceUILabel
end

function UISocial_AddFriendPanel:GetCityDropDown_UIDropDown()
    if (self.mCityDropDown == nil) then
        self.mCityDropDown = self:Get("bgright/MyInfo/Area/DropDown2", "Top_UIDropDown")
    end
    return self.mCityDropDown
end

function UISocial_AddFriendPanel:GetCityDropDown_UILabel()
    if (self.mCityUILabel == nil) then
        self.mCityUILabel = self:Get("bgright/MyInfo/Area/DropDown2/Caption/CaptionLabel", "UILabel")
    end
    return self.mCityUILabel
end

function UISocial_AddFriendPanel:GetMyFriendPlayerInfoOther_UIInput()
    if (self.mMyFriendPlayerInfoOtherUIInput == nil) then
        self.mMyFriendPlayerInfoOtherUIInput = self:Get("bgright/FriendInfo/Other/Chat Input", "UIInput")
    end
    return self.mMyFriendPlayerInfoOtherUIInput
end

function UISocial_AddFriendPanel:GetMyPlayerInfoPhone_UILabel()
    if (self.mMyPlayerInfoPhone == nil) then
        self.mMyPlayerInfoPhone = self:Get("bgright/MyInfo/Phone/Chat Input/Label", "UILabel")
    end
    return self.mMyPlayerInfoPhone
end
--endregion

--endregion

--region Btn
function UISocial_AddFriendPanel:GetEmptyBtn_GameObject()
    if (self.mEmptyBtn == nil) then
        self.mEmptyBtn = self:Get("bgleft/btn_empty", "GameObject")
    end
    return self.mEmptyBtn
end

function UISocial_AddFriendPanel:GetKnowPeople_GameObject()
    if (self.mKnowPeopleGO == nil) then
        self.mKnowPeopleGO = self:Get("bgright/SearchInfo/KnowPeople", "GameObject")
    end
    return self.mKnowPeopleGO
end
--endregion
--endregion

--region 初始化
function UISocial_AddFriendPanel:Init(panel)
    self.SocialContactPanel = panel
    self.templateTable = {}
    self.FriendTemplates = {}
    self.FriendTemplatesID = {}
    self.FriendRelationFuncTemplates = {}
    self:BindUIEvents();
    self:InitProvinceDropDown()
end

function UISocial_AddFriendPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetMyPlayerInfoConfirmBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetMyPlayerInfoConfirmBtn_GameObject()).OnClickLuaDelegate = self.ConfirmBtnOnClick
    CS.UIEventListener.Get(self:GetAutoFriendContact_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetAutoFriendContact_GameObject()).OnClickLuaDelegate = self.SetFriendTypeSwitch
    CS.UIEventListener.Get(self:GetAutoCoupleContact_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetAutoCoupleContact_GameObject()).OnClickLuaDelegate = self.SetSpouseTypeSwitch
    CS.UIEventListener.Get(self:GetAutoBrothersContact_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetAutoBrothersContact_GameObject()).OnClickLuaDelegate = self.SetBrotherTypeSwitch

    if(LuaGlobalTableDeal:CanEditorMyIntroduction()) then
        self:GetMyPlayerInfoBrief_UIInput().enabled = true;
        self:GetMyPlayerInfoBrief_UIInput().submitOnUnselect = true
        CS.EventDelegate.Add(self:GetMyPlayerInfoBrief_UIInput().onSubmit, function(go)
            self:ConfirmBtnOnClick()
        end)
    else
        self:GetMyPlayerInfoBrief_UIInput().enabled = false;
        CS.UIEventListener.Get(self:GetMyPlayerInfoBrief_UIInput().gameObject).onClick = function()
            Utility.ShowPopoTips(self:GetMyPlayerInfoBrief_UIInput().gameObject, nil,397, "UISocialContactPanel");
        end
    end

    if(LuaGlobalTableDeal:CanEditorMyIntroduction()) then
        self:GetMyPlayerInfoPhone_UIInput().enabled = true;
        self:GetMyPlayerInfoPhone_UIInput().submitOnUnselect = true
        CS.EventDelegate.Add(self:GetMyPlayerInfoPhone_UIInput().onSubmit, function(go)
            self:ShowConfirmBtn()
        end)
    else
        self:GetMyPlayerInfoPhone_UIInput().enabled = false;
        CS.UIEventListener.Get(self:GetMyPlayerInfoPhone_UIInput().gameObject).onClick = function()
            Utility.ShowPopoTips(self:GetMyPlayerInfoPhone_UIInput().gameObject, nil,398, "UISocialContactPanel");
        end
    end


    self:GetCityDropDown_UIDropDown().OnValueChange:Add(function(eventTemp)
        self:ShowConfirmBtn()
    end)
    self:GetProvinceDropDown_UIDropDown().OnValueChange:Add(function(eventTemp)
        self:ShowConfirmBtn()
        for k, v in pairs(CS.Cfg_AreaTableManager.Instance.ProvinceCity) do
            if (k == eventTemp.Label) then
                self:GetCityDropDown_UIDropDown():ClearOptions()
                for i = 0, v.Count - 1 do
                    local dropDowntemp = {}
                    dropDowntemp.Label = v[i]
                    self:GetCityDropDown_UIDropDown():AddOptions(dropDowntemp)
                    if (i == 0) then
                        self:GetCityDropDown_UIDropDown():Selected(dropDowntemp)
                    end
                end
                return
            end
        end
    end)
    --CS.UIEventListener.Get(self:GetEmptyBtn_GameObject()).LuaEventTable = self
    --CS.UIEventListener.Get(self:GetEmptyBtn_GameObject()).OnClickLuaDelegate = self.EmptyBtnOnClick
end
--endregion

function UISocial_AddFriendPanel:Show()
    self.go:SetActive(true)
    local list = self.SocialContactPanel.GetCSFriendInfoV2FriendDic(LuaEnumSocialLieBiaoType.HaoYouLieBiao)
    if (list == nil) then
        return
    end
    self:ResFriendList(list)
end

function UISocial_AddFriendPanel:Hide()
    --self:GetCityDropDown_UIDropDown().isOpen = not self:GetCityDropDown_UIDropDown().isOpen
    --self:GetProvinceDropDown_UIDropDown().isOpen = not self:GetProvinceDropDown_UIDropDown().isOpen
    self:GetCityDropDown_UIDropDown():OnClickCaption();
    self:GetProvinceDropDown_UIDropDown():OnClickCaption();
    self:GetMyPlayerInfoConfirmBtn_GameObject():SetActive(false)
    self:GetMyPlayerInfo_GameObject():SetActive(false)
    self.go:SetActive(false)
end

--region UIEvents
function UISocial_AddFriendPanel:EmptyBtnOnClick()
    networkRequest.ReqClearApplyList()
    CS.CSScene.MainPlayerInfo.FriendInfoV2.FriendInfoDic[LuaEnumSocialFriendRelationType.APPLY_LIST]:Clear()
    self:GetApproveFriendList_UIGridContainer().MaxCount = 0
end
--endregion

--region 刷新界面
function UISocial_AddFriendPanel:RefreshAddFriendList(go)
    --self为UIApproveFriendInfoTemplates
    self.info.isReceive = true
    self:RefreshUI()
end

function UISocial_AddFriendPanel:ReFreshTemplateInfo(id, data)
    if data == nil or data.friend == nil then
        return
    end
    local Length = data.friend.Count
    if self.FriendTemplatesID == nil then
        return
    end
    local Count = Utility.GetLuaTableCount(self.FriendTemplatesID)
    for k = 0, Length - 1 do
        for m = 1, Count do
            local temp = self.FriendTemplatesID[m]
            if temp ~= nil and self.FriendTemplates[temp] ~= nil then
                if (self.FriendTemplates[temp].rid == data.friend[k].rid) then
                    self.FriendTemplates[temp].info = data.friend[k]
                end
            end
        end
    end
end

function UISocial_AddFriendPanel:ConfirmBtnOnClick()
    self:GetMyPlayerInfoConfirmBtn_GameObject():SetActive(false)
    local brief = self:GetMyPlayerInfoBrief_UIInput().value
    --if (self:GetMyPlayerInfoBrief_UILabel().text == "点击编辑个人信息") then
    --    brief = ""
    --else
    --    brief = self:GetMyPlayerInfoBrief_UILabel().text
    --end
    local address = self:GetProvinceDropDown_UILabel().text .. "&" .. self:GetCityDropDown_UILabel().text
    local contactWay
    --if (self:GetMyPlayerInfoPhone_UIInput().value == "点击添加联系方式") then
    --    contactWay = ""
    --else
    contactWay = self:GetMyPlayerInfoPhone_UIInput().value
    --end
    local openList = CS.System.Collections.Generic["List`1[System.Int32]"]()
    if (self.IsFriendTypeSwitch) then
        openList:Add(LuaEnumSocialFriendRelationType.Friend)
    end
    if (self.IsSpouseTypeSwitch) then
        openList:Add(LuaEnumSocialFriendRelationType.Spouse)
    end
    if (self.IsBrotherTypeSwitch) then
        openList:Add(LuaEnumSocialFriendRelationType.Brother)
    end
    networkRequest.ReqEditPersonalInfo(brief, address, contactWay, openList)
end

function UISocial_AddFriendPanel:SetInfoToggleList(info)
    local isFind, result = CS.Cfg_GlobalTableManager.Instance.FriendFuncDic:TryGetValue(info.relation)
    if (isFind) then
        if (result ~= nil) then
            self:SetRelationBtnGroup(result)
        end
    end
end

function UISocial_AddFriendPanel:SetRelationBtnGroup(BtnGroup)
    self:GetInfoToggleList_UIGridContainer().MaxCount = BtnGroup.Count
    for k = 1, BtnGroup.Count do
        local go = self:GetInfoToggleList_UIGridContainer().transform:GetChild(k)
        if (self.FriendRelationFuncTemplates[go] == nil) then
            self.FriendRelationFuncTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIFriendRelationFunctionTemplates, self, self.SocialContactPanel)
        end
        self.FriendRelationFuncTemplates[go]:InitTemplates(self.mCurChooseTem, tonumber(BtnGroup[k - 1]))
        self.FriendRelationFuncTemplates[go]:BindUIEvents()
    end
end

function UISocial_AddFriendPanel:ShowPlayerDetails(info)
    if (info.rid == CS.CSScene.MainPlayerInfo.ID) then
        self:GetMyPlayerInfo_GameObject():SetActive(true)
        --self:GetMyFriendPlayerInfo_GameObject():SetActive(false)
        self:GetMyPlayerInfoLevel_UILabel().text = info.level
    end
end

function UISocial_AddFriendPanel:SetPlayerInfo(info)
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
    --if (CS.System.String.IsNullOrEmpty(info.brief)) then
    --    self:GetMyPlayerInfoBrief_UIInput().value = info.brief
    --else
    self:GetMyPlayerInfoBrief_UIInput().value = info.brief
    --end
    if (CS.System.String.IsNullOrEmpty(info.contactWay)) then
        self:GetMyPlayerInfoPhone_UIInput().value = "点击添加联系方式"
    else
        self:GetMyPlayerInfoPhone_UIInput().value = info.contactWay
    end

    if (info.address ~= "") then
        local address = info.address:Split("&")
        self:GetProvinceDropDown_UILabel().text = address[1]
        self:GetCityDropDown_UILabel().text = address[2]
        self:GetCityDropDown_UIDropDown():ClearOptions()
        for k, v in pairs(CS.Cfg_AreaTableManager.Instance.ProvinceCity) do
            if (k == address[1]) then
                self:GetCityDropDown_UIDropDown():ClearOptions()
                for i = 0, v.Count - 1 do
                    local dropDowntemp = {}
                    dropDowntemp.Label = v[i]
                    self:GetCityDropDown_UIDropDown():AddOptions(dropDowntemp)
                end
                return
            end
        end
    end

    if (info.openList == nil and info.openList.Count == 0) then
        return
    end
    if (info.openList:Contains(LuaEnumSocialFriendRelationType.Friend)) then
        uiStaticParameter.ShowInfoToFriendType = true
        self:SetFriendTypeSwitch(self:GetAutoFriendContact_GameObject(), true)
    else
        uiStaticParameter.ShowInfoToFriendType = false
    end
    if (info.openList:Contains(LuaEnumSocialFriendRelationType.Spouse)) then
        uiStaticParameter.ShowInfoToSpouseType = true
        self:SetSpouseTypeSwitch(self:GetAutoCoupleContact_GameObject(), true)
    else
        uiStaticParameter.ShowInfoToSpouseType = false
    end
    if (info.openList:Contains(LuaEnumSocialFriendRelationType.Brother)) then
        uiStaticParameter.ShowInfoToBrotherType = true
        self:SetBrotherTypeSwitch(self:GetAutoBrothersContact_GameObject(), true)
    else
        uiStaticParameter.ShowInfoToBrotherType = false
    end
end

function UISocial_AddFriendPanel:ShowConfirmBtn()
    self:GetMyPlayerInfoConfirmBtn_GameObject():SetActive(true)
end

function UISocial_AddFriendPanel:SetFriendTypeSwitch(go, bool)
    if (bool == true) then
        self.IsFriendTypeSwitch = bool
    else
        self:ShowConfirmBtn()
        self.IsFriendTypeSwitch = not self.IsFriendTypeSwitch
    end

    if self.IsFriendTypeSwitch then
        self:GetAutoFriendContact_UISprite().spriteName = 'slbg2'
        self:GetAutoFriendContact_Transform().localPosition = CS.UnityEngine.Vector3(-12, 10, 0)
    else
        self:GetAutoFriendContact_UISprite().spriteName = 'slbg'
        self:GetAutoFriendContact_Transform().localPosition = CS.UnityEngine.Vector3(-45, 10, 0)
    end
    if (not bool) then
        self:ShowFriendTypeTips(self.IsFriendTypeSwitch)
    end
end

function UISocial_AddFriendPanel:SetSpouseTypeSwitch(go, bool)
    if (bool == true) then
        self.IsSpouseTypeSwitch = bool
    else
        self:ShowConfirmBtn()
        self.IsSpouseTypeSwitch = not self.IsSpouseTypeSwitch
    end
    if self.IsSpouseTypeSwitch then
        self:GetAutoCoupleContact_UISprite().spriteName = 'slbg2'
        self:GetAutoCoupleContact_Transform().localPosition = CS.UnityEngine.Vector3(-12, 10, 0)
    else
        self:GetAutoCoupleContact_UISprite().spriteName = 'slbg'
        self:GetAutoCoupleContact_Transform().localPosition = CS.UnityEngine.Vector3(-45, 10, 0)
    end
    if (not bool) then
        self:ShowSpouseTypeTips(self.IsSpouseTypeSwitch)
    end
end

function UISocial_AddFriendPanel:SetBrotherTypeSwitch(go, bool)
    if (bool) then
        self.IsBrotherTypeSwitch = bool
    else
        self:ShowConfirmBtn()
        self.IsBrotherTypeSwitch = not self.IsBrotherTypeSwitch
    end
    if self.IsBrotherTypeSwitch then
        self:GetAutoBrothersContact_UISprite().spriteName = 'slbg2'
        self:GetAutoBrothersContact_Transform().localPosition = CS.UnityEngine.Vector3(-12, 10, 0)
    else
        self:GetAutoBrothersContact_UISprite().spriteName = 'slbg'
        self:GetAutoBrothersContact_Transform().localPosition = CS.UnityEngine.Vector3(-45, 10, 0)
    end
    if (not bool) then
        self:ShowBrotherTypeTips(self.IsBrotherTypeSwitch)
    end
end

function UISocial_AddFriendPanel:ShowFriendTypeTips(bool)
    if (bool) then
        CS.Utility.ShowTips("开启好友公开")
    else
        CS.Utility.ShowTips("关闭好友公开")
    end
    uiStaticParameter.ShowInfoToFriendType = false
end

function UISocial_AddFriendPanel:ShowSpouseTypeTips(bool)
    if (bool) then
        CS.Utility.ShowTips("开启夫妻公开")
    else
        CS.Utility.ShowTips("关闭夫妻公开")
    end
    uiStaticParameter.ShowInfoToSpouseType = false
end

function UISocial_AddFriendPanel:ShowBrotherTypeTips(bool)
    if (bool) then
        CS.Utility.ShowTips("开启兄弟公开")
    else
        CS.Utility.ShowTips("关闭兄弟公开")
    end
    uiStaticParameter.ShowInfoToBrotherType = false
end

function UISocial_AddFriendPanel:InitProvinceDropDown()
    self:GetProvinceDropDown_UIDropDown():ClearOptions()
    local dic = CS.Cfg_AreaTableManager.Instance.dic
    dic:Begin()
    while dic:Next() do
        local dropDowntemp = {}
        dropDowntemp.Label = dic.Value.province
        self:GetProvinceDropDown_UIDropDown():AddOptions(dropDowntemp)
        if (dic.Key == 1) then
            for m, n in pairs(CS.Cfg_AreaTableManager.Instance.ProvinceCity) do
                if (m == dic.Value.province) then
                    self:GetCityDropDown_UIDropDown():ClearOptions()
                    for i = 0, n.Count - 1 do
                        local dropDowntemp = {}
                        dropDowntemp.Label = n[i]
                        self:GetCityDropDown_UIDropDown():AddOptions(dropDowntemp)
                    end
                end
            end
        end
    end
    -- for k, v in pairs(CS.Cfg_AreaTableManager.Instance.dic) do

    -- end
end
--endregion

--region 服务器消息处理
function UISocial_AddFriendPanel:ResPersonalInfo(info, csinfo)
    self:GetPlayerInfo_GameObject():SetActive(true)
    self:GetInfoToggle_GameObject():SetActive(true)
    self:SetPlayerInfo(csinfo)
    self:SetInfoToggleList(info)
    self:ShowPlayerDetails(info)
    self.mCurChooseTem:RefreshUI()
    self.mCurChooseTem.di_GameObject:SetActive(true)
end

function UISocial_AddFriendPanel:ResFriendList(list)
    --if (list == nil or list.Count == 0) then
    --    self:GetApproveFriendList_UIGridContainer().MaxCount = 0
    --    return
    --end
    self:GetApproveFriendList_UIGridContainer().MaxCount = 1

    local go = self:GetApproveFriendList_UIGridContainer().controlList[0]
    if (self.FriendTemplates[go] == nil) then
        self.FriendTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UISocialFriendInfoTemplates, self)
    end
    self.FriendTemplates[go]:InitParameters(list[0])
    self.FriendTemplates[go]:SetRoleHeadIcon(list[0].sex, list[0].career)
    self.FriendTemplatesID[list[0].rid] = go
    self.FriendTemplates[go].index = 1
    self.FriendTemplates[go]:RefreshUI()
    self.FriendTemplates[go]:SocialFriendOnClick()
end

function UISocial_AddFriendPanel:RefreshKnowControListTemIndex()
    local Length = self:GetMayKnowFriendList_UIGridContainer().controlList.Count
    self:GetMayKnowFriendList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetMayKnowFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] ~= nil) then
            self.templateTable[go].index = k
        end
    end
end

function UISocial_AddFriendPanel:RefreshAddControListTemIndex()
    local Length = self:GetAddFriendList_UIGridContainer().controlList.Count
    self:GetAddFriendList_UIGridContainer().MaxCount = Length
    for k = 0, Length - 1 do
        local go = self:GetAddFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] ~= nil) then
            self.templateTable[go].index = k
        end
    end
end

function UISocial_AddFriendPanel:ResKnowFriend(id, info)
    self:GetKnowPeople_GameObject():SetActive(true)

    if (info == nil) then
        self:GetKnowPeopleEndTips_GameObject():SetActive(true)
        return
    end
    self:GetSearchResultPanel_GameObject():SetActive(false)
    local Length = info.list.Count
    self:GetMayKnowFriendList_UIGridContainer().MaxCount = Length
    if (Length == 0) then
        self:GetKnowPeopleEndTips_GameObject():SetActive(true)
    else
        self:GetKnowPeopleEndTips_GameObject():SetActive(false)
    end
    for k = 0, Length - 1 do
        local go = self:GetMayKnowFriendList_UIGridContainer().controlList[k]
        if (self.templateTable[go] == nil) then
            self.templateTable[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAddFriendInfoTemplates, self)
            self.templateTable[go]:SetRoleHeadIcon(info.list[k].info.sex, info.list[k].info.career)
            self.templateTable[go].index = k
            self.templateTable[go].knowcausetype = info.list[k].type
            self.templateTable[go]:InitParameters(info.list[k].info)
            self.templateTable[go]:BindMayUIEvents()
        end
        self.templateTable[go]:RefreshUI()
    end
end
--endregion
return UISocial_AddFriendPanel