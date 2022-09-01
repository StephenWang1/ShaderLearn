local UISanctuaryLeftMainPanel = {}

--region Init
function UISanctuaryLeftMainPanel:Init()
    self:InitCompoment()
    self:InitEvent()
    self:InitNetMsg()
    self:ShowEyeEffect(CS.CSScene.MainPlayerInfo.DuplicateV2.HaveBoss)
    --self:LoadEyeEffect("700097",self.Boss_UISprite.transform,CS.UnityEngine.Vector3(0,0,-10),CS.UnityEngine.Vector3.one)
end

function UISanctuaryLeftMainPanel:InitCompoment()
    self.Tween_TweenPosition = self:GetCurComp("WidgetRoot/Tween","TweenPosition")
    self.title_UILabel = self:GetCurComp("WidgetRoot/Tween/view/lb_name","UILabel")
    self.Grid_UIGridContainer = self:GetCurComp("WidgetRoot/Tween/view/ScrollView/Grid","UIGridContainer")
    self.BtnHide_TweenRotation = self:GetCurComp("WidgetRoot/Tween/events/BtnHide","TweenRotation")
    self.Btn_center_GameObject = self:GetCurComp("WidgetRoot/Tween/events/btn_center","GameObject")
    self.Belong_Name_UILabel = self:GetCurComp("WidgetRoot/Tween/view/Belong/name","UILabel")
    self.RemainsKillNum_UILabel = self:GetCurComp("WidgetRoot/Tween/view/RemainsKill","UILabel")
    self.RemainsKillNum_TweenPosition = self:GetCurComp("WidgetRoot/Tween/view/RemainsKill","TweenPosition")
    self.RemainsKillAdd_GameObject = self:GetCurComp("WidgetRoot/Tween/view/add","GameObject")
    self.RemainsKillIcon_UISprite = self:GetCurComp("WidgetRoot/Tween/view/RemainsKill/icon","UISprite")
    self.RemainsKillLabel2_UILabel = self:GetCurComp("WidgetRoot/Tween/view/Label2","UILabel")
    self.Boss_UISprite = self:GetCurComp("WidgetRoot/Tween/view/Boss","UISprite")
    self.helpBtn_UISprite = self:GetCurComp("WidgetRoot/Tween/events/helpBtn","UISprite")
    self.IsOpen = true
end

function UISanctuaryLeftMainPanel:InitEvent()
    CS.UIEventListener.Get(self.BtnHide_TweenRotation.gameObject).onClick = function()
        self:BtnHidClicked()
    end
    CS.UIEventListener.Get(self.Btn_center_GameObject).onClick = self.BtnCenterClicked
    CS.UIEventListener.Get(self.RemainsKillAdd_GameObject).onClick = self.OpenItemNoiconCountPanel
    CS.UIEventListener.Get(self.helpBtn_UISprite.gameObject).onClick = self.HelpBtnOnClick
end

function UISanctuaryLeftMainPanel:InitNetMsg()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateBasicInfoMessage, UISanctuaryLeftMainPanel.ResDuplicateBasicInfoMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSanctuarySpaceInfoMessage, UISanctuaryLeftMainPanel.ResSanctuarySpaceInfoMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResMonsterOwnerChangedMessage, UISanctuaryLeftMainPanel.ResMonsterOwnerChangedMessageReceived)
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDuplicateBossInfoMessage, UISanctuaryLeftMainPanel.ResDuplicateBossInfoMessageReceived)
end

function UISanctuaryLeftMainPanel:BtnHidClicked()
    self:ControlPanelOpenAndClose(self.IsOpen)
    self.IsOpen = not self.IsOpen
end

function UISanctuaryLeftMainPanel.BtnCenterClicked()
    Utility.ReqExitDuplicate()
end

function UISanctuaryLeftMainPanel.OpenItemNoiconCountPanel(go)
    --local goldInfo = CS.Cfg_GlobalTableManager.Instance:GetShengyuGoldInfo()
    --local goldItemid = 0
    --local singlePrice = 0
    --if goldInfo.Length >= 2 then
    --    goldItemid = tonumber(goldInfo[0])
    --    singlePrice = tonumber(goldInfo[1])
    --end
    --local goldItemInfoIsFind,goldItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(goldItemid)
    --local QuickGetCustomData = {
    --    goldItemInfo = goldItemInfo,
    --    singlePrice = singlePrice,
    --    minBuyCount = 0,
    --    maxBuyCount = 10,
    --    ensureCallBack = function(buyNum)
    --        networkRequest.ReqButSanctuaryCount(buyNum)
    --    end
    --}
    --uimanager:CreatePanel("UIItemNoiconCountPanel",nil,QuickGetCustomData)
    ---策划要求打开快捷购买界面
    if UISanctuaryLeftMainPanel.materialItemInfo ~= nil then
        Utility.ShowItemGetWay(UISanctuaryLeftMainPanel.materialItemInfo.id, go, LuaEnumWayGetPanelArrowDirType.Left);
    end
end

function UISanctuaryLeftMainPanel.HelpBtnOnClick()
    local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(110)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
    end
end

---接收副本基础信息
function UISanctuaryLeftMainPanel.ResDuplicateBasicInfoMessageReceived(id,luaData)
    UISanctuaryLeftMainPanel:ChangeTitle(luaData.cfgId)
    UISanctuaryLeftMainPanel:RefreshMaterialNum(luaData.cfgId)

end

---接收圣域空间剩余击杀次数
function UISanctuaryLeftMainPanel.ResSanctuarySpaceInfoMessageReceived(id,luaData)
    UISanctuaryLeftMainPanel:ChangRemainKillNum(luaData.count)
end

function UISanctuaryLeftMainPanel.ResMonsterOwnerChangedMessageReceived(id,luaData)
    local ownerName = ternary(luaData.ownerName == nil,"无",luaData.ownerName)
    UISanctuaryLeftMainPanel:ChangeBossBelongName(ownerName)
end

function UISanctuaryLeftMainPanel.ResDuplicateBossInfoMessageReceived(id,luaData)
    UISanctuaryLeftMainPanel:ChangeBossBelongName("无")
    UISanctuaryLeftMainPanel:ShowEyeEffect(not luaData.bossSurvival)
end

function UISanctuaryLeftMainPanel:Show()
    if CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo ~= nil then
        self:ChangeTitle(CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo.cfgId)
        self:RefreshMaterialNum(CS.CSScene.MainPlayerInfo.DuplicateV2.DuplicateBasicInfo.cfgId)
    end
    self:ChangRemainKillNum(CS.CSScene.MainPlayerInfo.ShengyuSpaceUseNum)
    self:ChangeBossBelongName()
end

--endregion

function UISanctuaryLeftMainPanel:ChangeTitle(duplicateId)
    local duplicateInfoIsFind,duplicateInfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateId)
    if duplicateInfoIsFind then
        self.title_UILabel.text = duplicateInfo.name
    end
    if CS.StaticUtility.IsNull(self.helpBtn_UISprite) == false then
        self.helpBtn_UISprite:UpdateAnchors()
    end
end

function UISanctuaryLeftMainPanel:RefreshMaterialNum(duplicateId)
    local duplicateInfoIsFind,duplicateInfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(duplicateId)
    if duplicateInfoIsFind then
        local materialItemId = nil
        if duplicateInfo.requireItems ~= nil and duplicateInfo.requireItems.list ~= nil and duplicateInfo.requireItems.list[0].list.Count >= 2 then
            materialItemId = duplicateInfo.requireItems.list[0].list[0]
        end
        if materialItemId ~= nil then
            local itemIdIsFind, materialItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(materialItemId)
            if itemIdIsFind then
                UISanctuaryLeftMainPanel.materialItemInfo = materialItemInfo
                local bagItemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(materialItemId)
                self.RemainsKillIcon_UISprite.spriteName = materialItemInfo.id
            end
        end
    end
end

function UISanctuaryLeftMainPanel:ChangeBossBelongName(playerName)
    local playerName = ternary(playerName == nil or playerName == "","无",playerName)
    self.Belong_Name_UILabel.text = playerName
end

function UISanctuaryLeftMainPanel:ChangRemainKillNum(count)
    local maxCount = CS.Cfg_GlobalTableManager.Instance:GetMaxKillNumOneDay()
    local color = ternary(count > 0,luaEnumColorType.Green,luaEnumColorType.Red)
    self.RemainsKillNum_UILabel.text = color .. tostring(count)
    local openAddBtn = ternary(count == 0,true,false)
    self.RemainsKillAdd_GameObject:SetActive(openAddBtn)
    if openAddBtn == true then
        self.RemainsKillNum_TweenPosition:PlayReverse()
    else
        self.RemainsKillNum_TweenPosition:PlayForward()
    end
    self.RemainsKillIcon_UISprite:UpdateAnchors()
    self.RemainsKillLabel2_UILabel.text = "可有效击杀" .. count .. "只BOSS"
end

function UISanctuaryLeftMainPanel:InitPanel()

end

function UISanctuaryLeftMainPanel:ClearAllParams()
    self.ShowContentTable = {}
end

function UISanctuaryLeftMainPanel:ControlPanelOpenAndClose(bool)
    if self.Tween_TweenPosition ~= nil and self.BtnHide_TweenRotation ~= nil then
        if bool then
            self.Tween_TweenPosition:PlayForward()
            self.BtnHide_TweenRotation:PlayForward()
        else
            self.Tween_TweenPosition:PlayReverse()
            self.BtnHide_TweenRotation:PlayReverse()
        end
    end
end

function UISanctuaryLeftMainPanel:AddContent(title,num)
    local content = {title = title,
    num = num}
    table.insert(self.ShowContentTable,content)
end

function UISanctuaryLeftMainPanel:ChangeContent(title,num)
    for k,v in pairs(self.ShowContentTable) do
        if v.title == title then
            v.num = num
            return
        end
    end
    self:AddContent(title,num)
end

function UISanctuaryLeftMainPanel:ShowContent()
    if self.Grid_UIGridContainer == nil or CS.StaticUtility.IsNull(self.Grid_UIGridContainer) then
        return
    end
    self.Grid_UIGridContainer.MaxCount = #self.ShowContentTable
    local index = 1
    for k,v in pairs(self.Grid_UIGridContainer.controlList) do
        local content = self.ShowContentTable[index]
        local title_UILabel = self:GetComp(v.transform,"lb_describe","UILabel")
        local num_UILabel = self:GetComp(v.transform,"lb_num","UILabel")
        title_UILabel.text = content.title
        num_UILabel.text = content.num
        index = index + 1
    end
end

function UISanctuaryLeftMainPanel:ShowEyeEffect(open)
    self.eyeEffectIsShow = open
    if self.eyeEffect then
        self.eyeEffect.gameObject:SetActive(open)
    end
end

---加载眼睛特效
function UISanctuaryLeftMainPanel:LoadEyeEffect(effectName, parent, localPosition, localScale)
    if self.eyeEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete(effectName, CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                self.eyeEffect = res:GetObjInst()
                if self.eyeEffect then
                    self.eyeEffect.transform.parent = parent
                    self.eyeEffect.transform.localPosition = localPosition
                    self.eyeEffect.transform.localScale = localScale
                    self.eyeEffect.gameObject:SetActive(self.eyeEffectIsShow)
                end
            end
        end
        , CS.ResourceAssistType.UI)
    end
end


function ondestroy()
     uimanager:ClosePanel("UISanctuaryUpDownPanel")
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDuplicateBasicInfoMessage, UISanctuaryLeftMainPanel.ResDuplicateBasicInfoMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSanctuarySpaceInfoMessage, UISanctuaryLeftMainPanel.ResSanctuarySpaceInfoMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResMonsterOwnerChangedMessage, UISanctuaryLeftMainPanel.ResMonsterOwnerChangedMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResDuplicateBossInfoMessage, UISanctuaryLeftMainPanel.ResDuplicateBossInfoMessageReceived)
end

return UISanctuaryLeftMainPanel