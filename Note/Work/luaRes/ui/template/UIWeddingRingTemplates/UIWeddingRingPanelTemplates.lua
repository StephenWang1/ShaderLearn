local UIWeddingRingPanelTemplates = {}

--region 组件
function UIWeddingRingPanelTemplates:GetArrow_GameObject()
    if (self.marrowGo == nil) then
        self.marrowGo = self:Get("arrow", "GameObject")
    end
    return self.marrowGo
end

function UIWeddingRingPanelTemplates:GetLevelUpBtn_GameObject()
    if (self.mLevelUpBtn == nil) then
        self.mLevelUpBtn = self:Get("levelUpBtn", "GameObject")
    end
    return self.mLevelUpBtn
end

function UIWeddingRingPanelTemplates:GetRing_UISprite()
    if (self.mRingSprite == nil) then
        self.mRingSprite = self:Get("ring", "UISprite")
    end
    return self.mRingSprite
end

function UIWeddingRingPanelTemplates:GetRing_GameObject()
    if (self.mRingGameObject == nil) then
        self.mRingGameObject = self:Get("ring", "GameObject")
    end
    return self.mRingGameObject
end

function UIWeddingRingPanelTemplates:GetRingName_UILabel()
    if (self.mRingName == nil) then
        self.mRingName = self:Get("ring/ringName", "UILabel")
    end
    return self.mRingName
end

function UIWeddingRingPanelTemplates:GetNextRing_UISprite()
    if (self.mNextRingSprite == nil) then
        self.mNextRingSprite = self:Get("newring", "UISprite")
    end
    return self.mNextRingSprite
end

function UIWeddingRingPanelTemplates:GetNextRing_GameObject()
    if (self.mNextRingGameObject == nil) then
        self.mNextRingGameObject = self:Get("newring", "GameObject")
    end
    return self.mNextRingGameObject
end

function UIWeddingRingPanelTemplates:GetNextRingName_UILabel()
    if (self.mNextRingName == nil) then
        self.mNextRingName = self:Get("newring/ringName", "UILabel")
    end
    return self.mNextRingName
end

function UIWeddingRingPanelTemplates:GetRingDes_UILabel()
    if (self.mRingDes == nil) then
        self.mRingDes = self:Get("desNow/labal", "UILabel")
    end
    return self.mRingDes
end

function UIWeddingRingPanelTemplates:GetNextRingDes_UILabel()
    if (self.mNextRingDes == nil) then
        self.mNextRingDes = self:Get("desNext/labal", "UILabel")
    end
    return self.mNextRingDes
end

function UIWeddingRingPanelTemplates:GetNextRingDes_GameObject()
    if (self.mNextRingDesGo == nil) then
        self.mNextRingDesGo = self:Get("desNext", "GameObject")
    end
    return self.mNextRingDesGo
end

function UIWeddingRingPanelTemplates:GetCostIcon_UISprite()
    if (self.mCostIcon == nil) then
        self.mCostIcon = self:Get("costIcon", "UISprite")
    end
    return self.mCostIcon
end

function UIWeddingRingPanelTemplates:GetHelpBtn_GameObject()
    if (self.mHelpBtn == nil) then
        self.mHelpBtn = self:Get("help", "GameObject")
    end
    return self.mHelpBtn
end

function UIWeddingRingPanelTemplates:GetCostIcon_GameObject()
    if (self.mCostIconGameObject == nil) then
        self.mCostIconGameObject = self:Get("costIcon", "GameObject")
    end
    return self.mCostIconGameObject
end

function UIWeddingRingPanelTemplates:GetCostCount_UILabel()
    if (self.mCostCount == nil) then
        self.mCostCount = self:Get("costIcon/costNumber", "UILabel")
    end
    return self.mCostCount
end

function UIWeddingRingPanelTemplates:GetPreviewLeft_GameObject()
    if (self.mPreviewLeft == nil) then
        self.mPreviewLeft = self:Get("preview_left", "GameObject")
    end
    return self.mPreviewLeft
end

function UIWeddingRingPanelTemplates:GetPreviewRight_GameObject()
    if (self.mPreviewRight == nil) then
        self.mPreviewRight = self:Get("preview_right", "GameObject")
    end
    return self.mPreviewRight
end
--endregion

--region 初始化
---@param panel UIWeddingRingUpPanel
function UIWeddingRingPanelTemplates:Init(panel)
    self.panel = panel
    self:BindMessage()
    self:BindUIEvents()
end

function UIWeddingRingPanelTemplates:Show()
    self.go:SetActive(true)
    self:RefreshUIPanel()
end

function UIWeddingRingPanelTemplates:BindMessage()
    self.mResUpdateRingMsg = function(msgID, tblData, CSData)
        CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MARRY_RING)).itemId = tblData.ringItemId
        self:RefreshUIPanel()
    end
    self.panel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResUpdateRingMessage, self.mResUpdateRingMsg)
end

function UIWeddingRingPanelTemplates:BindUIEvents()
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetLevelUpBtn_GameObject()).OnClickLuaDelegate = self.LevelUpBtnOnClick
    CS.UIEventListener.Get(self:GetPreviewLeft_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetPreviewLeft_GameObject()).OnClickLuaDelegate = self.PreviewLeftBtnOnClick
    CS.UIEventListener.Get(self:GetPreviewRight_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetPreviewRight_GameObject()).OnClickLuaDelegate = self.PreviewRightBtnOnClick
    CS.UIEventListener.Get(self:GetRing_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetRing_GameObject()).OnClickLuaDelegate = self.RingOnClick
    CS.UIEventListener.Get(self:GetNextRing_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetNextRing_GameObject()).OnClickLuaDelegate = self.NextRingOnClick
    CS.UIEventListener.Get(self:GetCostIcon_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetCostIcon_GameObject()).OnClickLuaDelegate = self.CostRingOnClick
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).LuaEventTable = self
    CS.UIEventListener.Get(self:GetHelpBtn_GameObject()).OnClickLuaDelegate = self.HelpBtnOnClick

end
--endregion

--region 界面
function UIWeddingRingPanelTemplates:Hide()
    self.go:SetActive(false)
    self.panel:GetMaxLevel_UISprite().gameObject:SetActive(false)
    self:GetPreviewLeft_GameObject():SetActive(false)
    self:GetPreviewRight_GameObject():SetActive(true)
end

function UIWeddingRingPanelTemplates:RefreshUIPanel()
    local weddingItem = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MARRY_RING))
    if (weddingItem == nil) then
        return
    end
    local WeddingRingDic = CS.Cfg_WeddingRingTableManager.Instance.dic
    local isFind, Info = WeddingRingDic:TryGetValue(weddingItem.itemId)
    if (isFind and (Info.nextRing == nil or Info.nextRing == 0)) then
        self:GetPreviewRight_GameObject():SetActive(false)
        if (isFind) then
            local curBool, curInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.itemId)
            if (curBool) then
                self.mCurRingInfo = curInfo
            end
            self:GetRing_UISprite().spriteName = curInfo.icon
            self.mCurRingName = curInfo.name
            self:GetRingName_UILabel().text = self.mCurRingName
            self:GetRingDes_UILabel().text = Info.des
        end
        --self.go:SetActive(false)
        self:GetArrow_GameObject():SetActive(false)
        self:GetLevelUpBtn_GameObject():SetActive(false)
        self:GetCostIcon_GameObject():SetActive(false)
        self:GetNextRingDes_GameObject():SetActive(false)
        self:GetNextRing_GameObject():SetActive(false)
        self:GetRing_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-287, 139, 0)
        self.panel:GetMaxLevel_UISprite().gameObject:SetActive(true)
        return
    else
        if (WeddingRingDic:ContainsKey(Info.nextRing) and WeddingRingDic[Info.nextRing].nextRing == nil or WeddingRingDic[Info.nextRing].nextRing == 0) then
            self:GetPreviewRight_GameObject():SetActive(false)
        end

        self.panel:GetMaxLevel_UISprite().gameObject:SetActive(false)
        if (isFind) then
            local curBool, curInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.itemId)
            if (curBool) then
                self.mCurRingInfo = curInfo
            end
            local nextBool, nextInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.nextRing)
            if (nextBool) then
                self.mNextRingInfo = nextInfo
            end
            local costBool, costInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.CostItem)
            if (costBool) then
                self.mCostRingInfo = costInfo
                self.mCostRingCount = costInfo.CostNumber
            end
            self:GetRing_UISprite().spriteName = curInfo.icon
            self.mCurRingName = curInfo.name
            self:GetRingName_UILabel().text = self.mCurRingName
            self:GetNextRing_UISprite().spriteName = nextInfo.icon ~= 0 and nextInfo.icon or ""
            self:GetNextRingName_UILabel().text = Info.nextRing ~= 0 and nextInfo.name or ""
            self:GetRingDes_UILabel().text = Info.des
            self:GetCostIcon_UISprite().spriteName = costInfo.icon
            self:GetCostCount_UILabel().text = Info.CostNumber
            if (Info.nextRing ~= nil and WeddingRingDic:TryGetValue(Info.nextRing)) then
                self:GetNextRingDes_UILabel().text = WeddingRingDic[Info.nextRing].des
            else
                self:GetNextRingDes_UILabel().text = ""
                self:GetCostCount_UILabel().text = ""
            end
        end
    end
    self:RefreshView(weddingItem.itemId)
end

function UIWeddingRingPanelTemplates:RefreshView(itemId)
    local isFind, funcTypeList = CS.Cfg_GlobalTableManager.Instance.WeddingRingFuncDic:TryGetValue(itemId)
    if (isFind) then
        if (not funcTypeList:Contains(LuaEnumWeddingRingFuncType.ChangeOath)) then
            self.panel:GetMoreInfoBtn_GameObject():SetActive(false)
        else
            self.panel:GetMoreInfoBtn_GameObject():SetActive(true)
        end
    end
end
--region Tips
function UIWeddingRingPanelTemplates:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion
--endregion

--region 点击事件
function UIWeddingRingPanelTemplates:LevelUpBtnOnClick(go)
    local hasGroup = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup;
    local isCaptain = CS.CSScene.MainPlayerInfo.GroupInfoV2.IsCaptain;
    if (hasGroup == false) then
        self:ShowTips(go, 119)
        return
    else
        if (isCaptain == false) then
            self:ShowTips(go, 121)
            return
        end
        if (CS.CSScene.MainPlayerInfo.GroupInfoV2:IsTeamMember(CS.CSScene.MainPlayerInfo.MarryInfo.LoverInfo.rid) == false) then
            self:ShowTips(go, 119)
            return
        end
        if (CS.CSScene.MainPlayerInfo.BagInfo:WeddingRingCanLevelUp() == false) then
            self:ShowTips(go, 143, self.mCurRingName .. "不足")
            return
        end
    end
    networkRequest.ReqUpdateRing()
end

function UIWeddingRingPanelTemplates:PreviewLeftBtnOnClick(go)
    self:GetPreviewRight_GameObject():SetActive(true)
    self:GetPreviewLeft_GameObject():SetActive(false)
    self:GetLevelUpBtn_GameObject():SetActive(true)
    self:RefreshUIPanel()
end

function UIWeddingRingPanelTemplates:PreviewRightBtnOnClick(go)
    self:GetPreviewRight_GameObject():SetActive(false)
    self:GetPreviewLeft_GameObject():SetActive(true)
    self:GetLevelUpBtn_GameObject():SetActive(false)
    local weddingItem = CS.CSScene.MainPlayerInfo.EquipInfo:GetEquipByEquipIndex(Utility.EnumToInt(CS.EEquipIndex.POS_MARRY_RING))
    local temisFind, temInfo = CS.Cfg_WeddingRingTableManager.Instance.dic:TryGetValue(weddingItem.itemId)
    local isFind, Info = CS.Cfg_WeddingRingTableManager.Instance.dic:TryGetValue(temInfo.nextRing)
    if (isFind and (Info.nextRing == nil or Info.nextRing == 0)) then
        --self.go:SetActive(false)
        self:GetPreviewRight_GameObject():SetActive(false)
        if (isFind) then
            local curBool, curInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.itemId)
            if (curBool) then
                self.mCurRingInfo = curInfo
            end
            self:GetRing_UISprite().spriteName = curInfo.icon
            self.mCurRingName = curInfo.name
            self:GetRingName_UILabel().text = self.mCurRingName
            self:GetRingDes_UILabel().text = Info.des
        end
        self:GetArrow_GameObject():SetActive(false)
        self:GetLevelUpBtn_GameObject():SetActive(false)
        self:GetCostIcon_GameObject():SetActive(false)
        self:GetNextRingDes_GameObject():SetActive(false)
        self:GetNextRing_GameObject():SetActive(false)
        self:GetRing_GameObject().transform.localPosition = CS.UnityEngine.Vector3(-287, 139, 0)
        self.panel:GetMaxLevel_UISprite().gameObject:SetActive(true)
        return
    else
        self.panel:GetMaxLevel_UISprite().gameObject:SetActive(false)
        if (isFind) then
            local curBool, curInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.itemId)
            if (curBool) then
                self.mCurRingInfo = curInfo
            end
            local nextBool, nextInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.nextRing)
            if (nextBool) then
                self.mNextRingInfo = nextInfo
            end
            local costBool, costInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(Info.CostItem)
            if (costBool) then
                self.mCostRingInfo = costInfo
            end
            self:GetRing_UISprite().spriteName = curInfo.icon
            self:GetRingName_UILabel().text = curInfo.name
            self:GetNextRing_UISprite().spriteName = nextInfo.icon ~= 0 and nextInfo.icon or ""
            self:GetNextRingName_UILabel().text = Info.nextRing ~= 0 and nextInfo.name or ""
            self:GetRingDes_UILabel().text = Info.des
            self:GetCostIcon_UISprite().spriteName = costInfo.icon
            self:GetCostCount_UILabel().text = Info.CostNumber
            if (Info.nextRing ~= nil and CS.Cfg_WeddingRingTableManager.Instance.dic:TryGetValue(Info.nextRing)) then
                self:GetNextRingDes_UILabel().text = CS.Cfg_WeddingRingTableManager.Instance.dic[Info.nextRing].des
            else
                self:GetNextRingDes_UILabel().text = ""
                self:GetCostCount_UILabel().text = ""
            end
        end
    end
end

function UIWeddingRingPanelTemplates.HelpBtnOnClick(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(95)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

function UIWeddingRingPanelTemplates:RingOnClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mCurRingInfo, showRight = false })
end

function UIWeddingRingPanelTemplates:NextRingOnClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mNextRingInfo, showRight = false })
end

function UIWeddingRingPanelTemplates:CostRingOnClick()
    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mCostRingInfo, showRight = false })
end
--endregion

function UIWeddingRingPanelTemplates:OnDestroy()
    self.panel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResUpdateRingMessage, self.mResUpdateRingMsg)
end
return UIWeddingRingPanelTemplates