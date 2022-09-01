---@class UIAppearancePanel:UIBase
local UIAppearancePanel = {}

--region 组件
---页签GridContainer
---@return UIGridContainer
function UIAppearancePanel:GetBookMarksGridContainer()
    if UIAppearancePanel.mBookMarkGridContainer == nil then
        UIAppearancePanel.mBookMarkGridContainer = UIAppearancePanel:GetCurComp("WidgetRoot/TypePage/ScrollView/BookMarks", "UIGridContainer")
    end
    return UIAppearancePanel.mBookMarkGridContainer
end

---关闭按钮
---@return UIEventListener
function UIAppearancePanel:GetCloseButton()
    if UIAppearancePanel.mCloseButton == nil then
        local btnGO = UIAppearancePanel:GetCurComp("WidgetRoot/CloseButton", "GameObject")
        if btnGO or CS.StaticUtility.IsNull(btnGO) == false then
            UIAppearancePanel.mCloseButton = CS.UIEventListener.Get(btnGO)
        end
    end
    return UIAppearancePanel.mCloseButton
end

---状态按钮
---@return UIEventListener
function UIAppearancePanel:GetStateButton()
    if UIAppearancePanel.mStateButton == nil then
        local stateGO = UIAppearancePanel:GetCurComp("WidgetRoot/StateButton", "GameObject")
        if stateGO and CS.StaticUtility.IsNull(stateGO) == false then
            UIAppearancePanel.mStateButton = CS.UIEventListener.Get(stateGO)
        end
    end
    return UIAppearancePanel.mStateButton
end

---状态文字
---@return UILabel
function UIAppearancePanel:GetStateLabel()
    if UIAppearancePanel.mStateLabel == nil then
        UIAppearancePanel.mStateLabel = UIAppearancePanel:GetCurComp("WidgetRoot/StateButton/StateLabel", "UILabel")
    end
    return UIAppearancePanel.mStateLabel
end
--endregion

---外观页控制
---@return UIAppearancePanelPagesCtrlTemplate
function UIAppearancePanel:GetAppearancePageCtrlTemplate()
    if UIAppearancePanel.mAppearancePageCtrlTemplate == nil then
        local appearancePageCtrlRootGO = UIAppearancePanel:GetCurComp("WidgetRoot/AppearanceGrids", "GameObject")
        if appearancePageCtrlRootGO and CS.StaticUtility.IsNull(appearancePageCtrlRootGO) == false then
            ---@type UIAppearancePanelPagesCtrlTemplate
            UIAppearancePanel.mAppearancePageCtrlTemplate = templatemanager.GetNewTemplate(appearancePageCtrlRootGO, luaComponentTemplates.UIAppearancePanelPagesCtrlTemplate)
            UIAppearancePanel.mAppearancePageCtrlTemplate:SetGridClickCallback(UIAppearancePanel.OnAppearanceGridClicked)
            UIAppearancePanel.mAppearancePageCtrlTemplate:SetTitleClickCallback(UIAppearancePanel.OnTitleClicked)
        end
    end
    return UIAppearancePanel.mAppearancePageCtrlTemplate
end

---外观信息
---@return UIAppearancePanelInfoTemplate
function UIAppearancePanel:GetAppearanceInfoTemplate()
    if UIAppearancePanel.mAppearanceInfoTemplate == nil then
        local appearanceInfoTrans = UIAppearancePanel:GetCurComp("WidgetRoot/AppearanceInfo", "GameObject")
        if appearanceInfoTrans and CS.StaticUtility.IsNull(appearanceInfoTrans) == false then
            UIAppearancePanel.mAppearanceInfoTemplate = templatemanager.GetNewTemplate(appearanceInfoTrans, luaComponentTemplates.UIAppearancePanelInfoTemplate)
        end
    end
    return UIAppearancePanel.mAppearanceInfoTemplate
end

---称号信息模板
---@return UIAppearancePanelTitleInfoTemplate
function UIAppearancePanel:GetTitleInfoTemplate()
    if self.mTitleInfoTemplate == nil then
        local go = self:GetCurComp("WidgetRoot/TitleInfo", "GameObject")
        self.mTitleInfoTemplate = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAppearance_TitleInfoTemplate)
    end
    return self.mTitleInfoTemplate
end

---获取当前书签的类型索引
---@return number
function UIAppearancePanel:GetCurrentBookMarkIndex()
    return UIAppearancePanel.mCurrentBookMarkIndex
end

---设置当前书签的类型索引
---@param index number
function UIAppearancePanel:SetCurrentBookMarkIndex(index)
    if UIAppearancePanel.mCurrentBookMarkIndex == index or index == nil then
        return
    end
    UIAppearancePanel:SetBookMarkActive(UIAppearancePanel.mCurrentBookMarkIndex, false)
    UIAppearancePanel.mCurrentBookMarkIndex = index
    UIAppearancePanel:SetBookMarkActive(UIAppearancePanel.mCurrentBookMarkIndex, true)
    UIAppearancePanel:OnBookMarkChanged()
    --称谓视图切换
    UIAppearancePanel:SetAppellationView()
end

---获取当前选中的外观
---@return bagV2.BagItemInfo
function UIAppearancePanel:GetCurrentSelectedAppearance()
    return UIAppearancePanel.mCurrentSelectedAppearance
end

---获取当前选中的外观类型
---@return 外观类型
function UIAppearancePanel:GetCurrentSelectedAppearanceType()
    return UIAppearancePanel.mCurrentAppearanceType
end

---设置当前选中的外观
---@param info bagV2.BagItemInfo|titleV2.TitleInfo
---@param type 外观类型
function UIAppearancePanel:SetCurrentSelectedAppearance(info, type)
    if UIAppearancePanel.mCurrentSelectedAppearance == info then
        return
    end
    local previousSelectedAppearance = UIAppearancePanel.mCurrentSelectedAppearance
    local previousType = UIAppearancePanel.mCurrentAppearanceType
    UIAppearancePanel.mCurrentSelectedAppearance = info
    UIAppearancePanel.mCurrentAppearanceType = type
    UIAppearancePanel:OnSelectedAppearanceChanged(previousSelectedAppearance, info, previousType, type)
end

function UIAppearancePanel:Init()
    UIAppearancePanel:BindMessage()
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData then
        CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:StartPreview()
    end
end

---@param appearanceType 外观类型 外观的类型(页签)
---@param itemID number 外观物品ID
function UIAppearancePanel:Show(appearanceType, itemID)
    --检查是否能够显示外观
    if not (CS.CSScene.MainPlayerInfo ~= nil and
            ((CS.CSScene.MainPlayerInfo.Appearance.AppearanceData ~= nil and CS.CSScene.MainPlayerInfo.Appearance.AppearanceData.IsOnceHoldAnyFashion) or
                    (CS.CSScene.MainPlayerInfo.TitleInfoV2 ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count > 0)) and
            not CS.CSScene.MainPlayerInfo.IsSpy) then
        uimanager:ClosePanel("UIAppearancePanel")
        return
    end
    if appearanceType == nil and itemID == nil then
        itemID = gameMgr:GetPlayerDataMgr():GetAppearanceInfo():TryGetNewAppearanceItemID()
    end
    --获得默认页签
    if appearanceType == nil then
        if itemID then
            ---@type TABLE.CFG_ITEMS
            local itemTblTemp
            ___, itemTblTemp = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemID)
            if itemTblTemp.appearanceId ~= 0 then
                ---@type TABLE.CFG_APPEARANCE
                local appearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(itemTblTemp.appearanceId)
                if appearanceTbl then
                    appearanceType = appearanceTbl.type
                end
            end
        end
        if appearanceType == nil then
            appearanceType = UIAppearancePanel:GetDefaultAppearanceType()
        end
    end
    --刷新当前页签
    UIAppearancePanel:RefreshBookMarks()
    UIAppearancePanel:SetCurrentBookMarkIndex(appearanceType)
    --清空外观信息
    if UIAppearancePanel:GetAppearanceInfoTemplate() ~= nil then
        if UIAppearancePanel:GetCurrentSelectedAppearanceType() == LuaEnumAppearanceType.Title then
            UIAppearancePanel:GetTitleInfoTemplate().go:SetActive(true)
            UIAppearancePanel:GetAppearanceInfoTemplate().go:SetActive(false)
            UIAppearancePanel:GetTitleInfoTemplate():Refresh(UIAppearancePanel:GetCurrentSelectedAppearance(), UIAppearancePanel:GetCurrentSelectedAppearanceType())
        else
            UIAppearancePanel:GetAppearanceInfoTemplate().go:SetActive(true)
            UIAppearancePanel:GetTitleInfoTemplate().go:SetActive(false)
            UIAppearancePanel:GetAppearanceInfoTemplate():Refresh(UIAppearancePanel:GetCurrentSelectedAppearance(), UIAppearancePanel:GetCurrentSelectedAppearanceType())
        end
    end
    --刷新选中的物品
    if itemID then
        if CS.CSScene.Sington and CS.CSScene.Sington.MainPlayer and CS.CSScene.Sington.MainPlayer.BaseInfo and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData then
            ---@type bagV2.BagItemInfo
            local bagItemInfoTemp = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:GetBagItemInfoByItemID(itemID)
            if bagItemInfoTemp and bagItemInfoTemp.ItemTABLE then
                local subType = bagItemInfoTemp.ItemTABLE.subType
                if bagItemInfoTemp.ItemTABLE.appearanceId ~= 0 then
                    local appearanceID = bagItemInfoTemp.ItemTABLE.appearanceId
                    ---@type TABLE.CFG_APPEARANCE
                    local isAppearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(appearanceID)
                    if appearanceTbl then
                        subType = appearanceTbl.type
                    end
                end
                UIAppearancePanel:SetCurrentSelectedAppearance(bagItemInfoTemp, subType)
            end
        end
    end
end

function UIAppearancePanel:BindMessage()
    UIAppearancePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerAppearanceListRefresh, UIAppearancePanel.OnMainPlayerAppearanceListRefresh)
    UIAppearancePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerFashionListRefresh, UIAppearancePanel.OnMainPlayerFashionListRefresh)
    UIAppearancePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerTitleRefresh, UIAppearancePanel.OnTitleInfoRefresh)
    UIAppearancePanel:GetCloseButton().onClick = UIAppearancePanel.OnCloseButtonClicked
    UIAppearancePanel:GetStateButton().onClick = UIAppearancePanel.OnStateButtonClicked
    UIAppearancePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResGetHasAppellationMessage, UIAppearancePanel.OnResAppellationChangeMessageReceived)
    UIAppearancePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResEnableAppellationMessage, UIAppearancePanel.OnResAppellationStateChangeMessageReceived)
end

---刷新书签
function UIAppearancePanel:RefreshBookMarks()
    if CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil or CS.CSScene.Sington.MainPlayer.BaseInfo == nil
            or CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData == nil or CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList == nil then
        return
    end
    local appearanceFashionListCount = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList.Count
    local bookMarkCount = appearanceFashionListCount
    local titleInfoListCount = CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count
    if titleInfoListCount > 0 then
        bookMarkCount = bookMarkCount + 1
    end
    UIAppearancePanel:GetBookMarksGridContainer().MaxCount = bookMarkCount
    for index = 0, bookMarkCount - 1 do
        local bookMarkBtn = UIAppearancePanel:GetBookMarksGridContainer().controlList[index]
        if bookMarkBtn and CS.StaticUtility.IsNull(bookMarkBtn) == false then
            if index >= appearanceFashionListCount then
                local subType = LuaEnumAppearanceType.Title
                local uieventlistener = CS.UIEventListener.Get(bookMarkBtn)
                if uieventlistener then
                    uieventlistener.OnClickLuaDelegate = UIAppearancePanel.OnBookMarkClicked
                    uieventlistener.LuaEventTable = subType
                end
                ---@type UISprite
                local bgSprite = UIAppearancePanel:GetComp(bookMarkBtn.transform, "Background/Sprite", "UISprite")
                ---@type UISprite
                local fgSprite = UIAppearancePanel:GetComp(bookMarkBtn.transform, "Foreground/Sprite", "UISprite")
                bgSprite.spriteName = UIAppearancePanel.GetBookMarkBGSpriteName(subType)
                fgSprite.spriteName = UIAppearancePanel.GetBookMarkFGSpriteName(subType)
                UIAppearancePanel:SetBookMarkActive(subType, UIAppearancePanel:GetCurrentBookMarkIndex() == subType)
            else
                local fashion = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList[index]
                local subType = fashion.subType
                local uieventListener = CS.UIEventListener.Get(bookMarkBtn)
                if uieventListener then
                    uieventListener.OnClickLuaDelegate = UIAppearancePanel.OnBookMarkClicked
                    uieventListener.LuaEventTable = subType
                end
                ---@type UISprite
                local bgSprite = UIAppearancePanel:GetComp(bookMarkBtn.transform, "Background/Sprite", "UISprite")
                ---@type UISprite
                local fgSprite = UIAppearancePanel:GetComp(bookMarkBtn.transform, "Foreground/Sprite", "UISprite")
                bgSprite.spriteName = UIAppearancePanel.GetBookMarkBGSpriteName(subType)
                fgSprite.spriteName = UIAppearancePanel.GetBookMarkFGSpriteName(subType)
                UIAppearancePanel:SetBookMarkActive(subType, UIAppearancePanel:GetCurrentBookMarkIndex() == subType)
            end
        end
    end
end

---设置书签是否激活
function UIAppearancePanel:SetBookMarkActive(subType, isActive)
    if subType == nil then
        return
    end
    local bookMarkCount = UIAppearancePanel:GetBookMarksGridContainer().MaxCount
    for index = 0, bookMarkCount - 1 do
        local bookMarkBtn = UIAppearancePanel:GetBookMarksGridContainer().controlList[index]
        if bookMarkBtn and CS.StaticUtility.IsNull(bookMarkBtn) == false then
            local uieventListener = CS.UIEventListener.Get(bookMarkBtn)
            if uieventListener.LuaEventTable == subType then
                local fgGO = UIAppearancePanel:GetComp(bookMarkBtn.transform, "Foreground", "GameObject")
                if fgGO then
                    fgGO:SetActive(isActive)
                end
            end
        end
    end
end

---刷新格子
function UIAppearancePanel:RefreshGrids()
    local bookMarkIndex = UIAppearancePanel:GetCurrentBookMarkIndex()
    local containsBookMarkIndex = false
    local infoList
    local isTitle = bookMarkIndex == LuaEnumAppearanceType.Title
    if isTitle == false then
        if CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList.Count > 0 then
            for i = 0, CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList.Count - 1 do
                local fashion = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList[i]
                if fashion.subType == bookMarkIndex then
                    containsBookMarkIndex = true
                    infoList = fashion.itemList
                    break
                end
            end
        end
    end
    if isTitle then
        if CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count > 0 then
            infoList = CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList
        end
    end
    UIAppearancePanel:GetAppearancePageCtrlTemplate():Refresh(infoList, UIAppearancePanel:GetCurrentBookMarkIndex(), UIAppearancePanel:GetCurrentSelectedAppearance(), isTitle)
end

---刷新状态按钮
function UIAppearancePanel:RefreshStateButton()
    if UIAppearancePanel:GetCurrentSelectedAppearance() == nil then
        UIAppearancePanel:GetStateButton().gameObject:SetActive(false)
        return
    end
    UIAppearancePanel:GetStateButton().gameObject:SetActive(true)
    local isUsingCurrentAppearance
    if UIAppearancePanel:GetCurrentSelectedAppearanceType() == LuaEnumAppearanceType.Title then
        isUsingCurrentAppearance = CS.CSScene.Sington.MainPlayer.BaseInfo.TitleInfoV2.TitleId == UIAppearancePanel:GetCurrentSelectedAppearance().titleId
        UIAppearancePanel:GetStateLabel().text = isUsingCurrentAppearance and "停用称号" or "启用称号"
    else
        isUsingCurrentAppearance = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:IsFashionEnabled(UIAppearancePanel:GetCurrentSelectedAppearance())
        UIAppearancePanel:GetStateLabel().text = isUsingCurrentAppearance and "停用外观" or "启用外观"
    end
end

---书签索引变化事件
function UIAppearancePanel:OnBookMarkChanged()
    --选中页签中已启用的装备,若均未启用,则置为nil
    local isSelectedAppearanceExist = false
    if UIAppearancePanel:GetCurrentBookMarkIndex() ~= LuaEnumAppearanceType.Title
            and CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer and CS.CSScene.Sington.MainPlayer.BaseInfo and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData then
        local appearanceData = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData
        if appearanceData.FashionList then
            for i = 0, appearanceData.FashionList.Count - 1 do
                local fashionType = appearanceData.FashionList[i]
                if fashionType and fashionType.subType == UIAppearancePanel:GetCurrentBookMarkIndex() then
                    for j = 0, fashionType.itemList.Count - 1 do
                        ---@type bagV2.BagItemInfo
                        local itemTemp = fashionType.itemList[j]
                        if appearanceData:IsFashionEnabled(itemTemp) then
                            local subType = itemTemp.ItemTABLE.subType
                            if itemTemp.ItemTABLE.appearanceId ~= 0 then
                                local appearanceID = itemTemp.ItemTABLE.appearanceId
                                ---@type TABLE.CFG_APPEARANCE
                                local isAppearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(appearanceID)
                                if appearanceTbl then
                                    subType = appearanceTbl.type
                                end
                            end
                            UIAppearancePanel:SetCurrentSelectedAppearance(itemTemp, subType)
                            isSelectedAppearanceExist = true
                            break
                        end
                    end
                    if isSelectedAppearanceExist then
                        break
                    end
                end
            end
        end
    end
    if UIAppearancePanel:GetCurrentBookMarkIndex() == LuaEnumAppearanceType.Title and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList ~= nil then
        local titleInfoList = CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList
        local currentEquippedTitleID = CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleId
        local countTemp = titleInfoList.Count
        if countTemp > 0 then
            for i = 0, countTemp - 1 do
                ---@type titleV2.TitleInfo
                local titleInfoTemp = titleInfoList[i]
                if titleInfoTemp and titleInfoTemp.titleId == currentEquippedTitleID then
                    UIAppearancePanel:SetCurrentSelectedAppearance(titleInfoTemp, LuaEnumAppearanceType.Title)
                    isSelectedAppearanceExist = true
                end
            end
        else
            isSelectedAppearanceExist = false
        end
    end
    if isSelectedAppearanceExist == false then
        UIAppearancePanel:SetCurrentSelectedAppearance(nil, nil)
    end
    UIAppearancePanel:RefreshGrids()
    UIAppearancePanel:RefreshStateButton()
end

---当前选中的外观变化事件
---@param previousSelectedAppearance bagV2.BagItemInfo|titleV2.TitleInfo
---@param currentAppearance bagV2.BagItemInfo|titleV2.TitleInfo
---@param previousType 外观类型
---@param currentType 外观类型
function UIAppearancePanel:OnSelectedAppearanceChanged(previousSelectedAppearance, currentAppearance, previousType, currentType)
    if UIAppearancePanel:GetAppearanceInfoTemplate() ~= nil then
        if currentType == LuaEnumAppearanceType.Title then
            UIAppearancePanel:GetTitleInfoTemplate().go:SetActive(true)
            UIAppearancePanel:GetAppearanceInfoTemplate().go:SetActive(false)
            UIAppearancePanel:GetTitleInfoTemplate():Refresh(currentAppearance, currentType)
        else
            UIAppearancePanel:GetAppearanceInfoTemplate().go:SetActive(true)
            UIAppearancePanel:GetTitleInfoTemplate().go:SetActive(false)
            UIAppearancePanel:GetAppearanceInfoTemplate():Refresh(currentAppearance, currentType)
        end
    end
    UIAppearancePanel:RefreshStateButton()
    UIAppearancePanel:RefreshGrids()
    --设置主角的外观预览
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil
            and CS.CSScene.Sington.MainPlayer.BaseInfo ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData then
        if previousType == currentType then
            ---替换
            if currentType ~= nil and currentType ~= LuaEnumAppearanceType.Title then
                CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:SetPreviewAppearance(currentType, currentAppearance.itemId)
            end
        elseif previousType ~= nil then
            if previousType ~= LuaEnumAppearanceType.Title then
                CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:SetPreviewAppearance(previousType, 0)
            end
        elseif currentType ~= nil then
            if currentType ~= nil then
                CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:SetPreviewAppearance(previousType, currentAppearance.itemId)
            end
        end
    end
end

---@return 外观类型
function UIAppearancePanel:GetDefaultAppearanceType()
    if CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList.Count > 0 then
        return CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData.FashionList[0].subType
    end
    if CS.CSScene.MainPlayerInfo.TitleInfoV2.TitleInfoList.Count > 0 then
        ---称号暂时没有外观和非外观之分
        return LuaEnumAppearanceType.Title
    end
    return LuaEnumAppearanceType.Weapon
end

--region 客户端事件
---书签点击事件
---@param bookMarkIndex 外观类型
function UIAppearancePanel.OnBookMarkClicked(bookMarkIndex, gameObject)
    UIAppearancePanel:SetCurrentBookMarkIndex(bookMarkIndex)
end

---状态按钮点击事件
function UIAppearancePanel.OnStateButtonClicked()
    if UIAppearancePanel:GetCurrentSelectedAppearance() == nil or UIAppearancePanel:GetCurrentSelectedAppearanceType() == nil then
        return
    end
    if UIAppearancePanel:GetCurrentSelectedAppearanceType() == LuaEnumAppearanceType.Title then
        local titleID = UIAppearancePanel:GetCurrentSelectedAppearance().titleId
        if titleID ~= nil then
            local isUsingCurrentAppearance = CS.CSScene.Sington.MainPlayer.BaseInfo.TitleInfoV2.TitleId == titleID
            if isUsingCurrentAppearance then
                networkRequest.ReqPutOffTitle(titleID)
            else
                networkRequest.ReqPutOnTitle(titleID)
            end
        end
    else
        local itemID = UIAppearancePanel:GetCurrentSelectedAppearance().itemId
        if itemID ~= nil then
            local isUsingCurrentAppearance = CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:IsFashionEnabled(UIAppearancePanel:GetCurrentSelectedAppearance())
            if isUsingCurrentAppearance then
                networkRequest.ReqEnableFashion(UIAppearancePanel:GetCurrentSelectedAppearance().itemId, 2)
            else
                networkRequest.ReqEnableFashion(UIAppearancePanel:GetCurrentSelectedAppearance().itemId, 1)
            end
        end
    end
end

---关闭按钮事件
function UIAppearancePanel.OnCloseButtonClicked()
    uimanager:ClosePanel(UIAppearancePanel)
end

---外观格子点击事件
---@param template UIAppearancePanelGridTemplate
function UIAppearancePanel.OnAppearanceGridClicked(template)
    if template then
        local target = template.bagItemInfo
        if target == UIAppearancePanel:GetCurrentSelectedAppearance() then
            --UIAppearancePanel:SetCurrentSelectedAppearance(nil, nil)
        else
            if template.bagItemInfo ~= nil then
                local subType = template.bagItemInfo.ItemTABLE.subType
                if template.bagItemInfo.ItemTABLE.appearanceId ~= 0 then
                    local appearanceID = template.bagItemInfo.ItemTABLE.appearanceId
                    ---@type TABLE.CFG_APPEARANCE
                    local isAppearanceTblExist, appearanceTbl = CS.Cfg_AppearanceTableManager.Instance:TryGetValue(appearanceID)
                    if appearanceTbl then
                        subType = appearanceTbl.type
                    end
                end
                UIAppearancePanel:SetCurrentSelectedAppearance(template.bagItemInfo, subType)
            end
        end
    end
end

---称号点击事件
---@param template UIAppearancePanelTitleTemplate
function UIAppearancePanel.OnTitleClicked(template)
    if template then
        local info = template.mTitleInfo
        if info == UIAppearancePanel:GetCurrentSelectedAppearance() then
            --UIAppearancePanel:SetCurrentSelectedAppearance(nil, nil)
        else
            UIAppearancePanel:SetCurrentSelectedAppearance(info, LuaEnumAppearanceType.Title)
        end
    end
end

---主角外观列表刷新
function UIAppearancePanel.OnMainPlayerAppearanceListRefresh()
    UIAppearancePanel:RefreshBookMarks()
    UIAppearancePanel:RefreshGrids()
    UIAppearancePanel:RefreshStateButton()
end

---主角时装列表刷新
function UIAppearancePanel.OnMainPlayerFashionListRefresh()
    UIAppearancePanel:RefreshBookMarks()
    UIAppearancePanel:RefreshGrids()
    UIAppearancePanel:RefreshStateButton()
end

---主角称号信息刷新
function UIAppearancePanel.OnTitleInfoRefresh()
    UIAppearancePanel:RefreshBookMarks()
    UIAppearancePanel:RefreshGrids()
    UIAppearancePanel:RefreshStateButton()
end
--endregion

--region 书签
---获取书签索引对应的背景图片名
---@return string
function UIAppearancePanel.GetBookMarkBGSpriteName(index)
    if index == LuaEnumAppearanceType.Weapon then
        return "appearance_4"
    end
    if index == LuaEnumAppearanceType.Helmet then
        return "appearance_6"
    end
    if index == LuaEnumAppearanceType.Clothes then
        return "appearance_2"
    end
    if index == LuaEnumAppearanceType.Wing then
        return "appearance_8"
    end
    if index == LuaEnumAppearanceType.Title then
        return "appearance_10"
    end
    if index == LuaEnumAppearanceType.Appellation then
        return "appearance_12"
    end
    return ""
end

---获取书签索引对应的背景图片名（选中状态）
---@return string
function UIAppearancePanel.GetBookMarkFGSpriteName(index)
    if index == LuaEnumAppearanceType.Weapon then
        return "appearance_3"
    end
    if index == LuaEnumAppearanceType.Helmet then
        return "appearance_5"
    end
    if index == LuaEnumAppearanceType.Clothes then
        return "appearance_1"
    end
    if index == LuaEnumAppearanceType.Wing then
        return "appearance_7"
    end
    if index == LuaEnumAppearanceType.Title then
        return "appearance_9"
    end
    if index == LuaEnumAppearanceType.Appellation then
        return "appearance_11"
    end
    return ""
end
--endregion

--region 称号

--endregion

--region 称谓
UIAppearancePanel.isOldAppellationView = false

---称谓视图模板
---@return UIAppearancePanelAppellationViewTemplate
function UIAppearancePanel:GetAppellationViewTemplate()
    if UIAppearancePanel.mAppellationViewTemplate == nil then
        local appellationViewGO = UIAppearancePanel:GetCurComp("WidgetRoot/AppellationView", "GameObject")
        if appellationViewGO and CS.StaticUtility.IsNull(appellationViewGO) == false then
            UIAppearancePanel.mAppellationViewTemplate = templatemanager.GetNewTemplate(appellationViewGO, luaComponentTemplates.UIAppellationViewTemplate)
        end
    end
    return UIAppearancePanel.mAppellationViewTemplate
end

---设置称谓视图
function UIAppearancePanel:SetAppellationView()
    local isAppellation = UIAppearancePanel.mCurrentBookMarkIndex == LuaEnumAppearanceType.Appellation --Clothes
    if UIAppearancePanel.isOldAppellationView == isAppellation then
        return
    end
    UIAppearancePanel.isOldAppellationView = isAppellation
    if UIAppearancePanel:GetAppearanceInfoTemplate() ~= nil and UIAppearancePanel.isOldAppellationView then
        UIAppearancePanel:GetAppearanceInfoTemplate().go:SetActive(not UIAppearancePanel.isOldAppellationView)
    end
    if UIAppearancePanel:GetAppearancePageCtrlTemplate() ~= nil then
        UIAppearancePanel:GetAppearancePageCtrlTemplate().go:SetActive(not UIAppearancePanel.isOldAppellationView)
    end
    if UIAppearancePanel:GetAppellationViewTemplate() ~= nil then
        UIAppearancePanel:GetAppellationViewTemplate():SetGoActive(UIAppearancePanel.isOldAppellationView)
    end
    if UIAppearancePanel:GetStateButton() then
        UIAppearancePanel:GetStateButton().gameObject:SetActive(not UIAppearancePanel.isOldAppellationView)
    end
end

---称谓信息更改
function UIAppearancePanel.OnResAppellationChangeMessageReceived()
    if UIAppearancePanel.mCurrentBookMarkIndex == LuaEnumAppearanceType.Appellation then
        if UIAppearancePanel:GetAppellationViewTemplate() ~= nil then
            UIAppearancePanel:GetAppellationViewTemplate():SetGoActive(UIAppearancePanel.isOldAppellationView)
        end
    end
end

---称谓状态改变
function UIAppearancePanel.OnResAppellationStateChangeMessageReceived()
    if UIAppearancePanel.mCurrentBookMarkIndex == LuaEnumAppearanceType.Appellation then
        if UIAppearancePanel:GetAppellationViewTemplate() ~= nil then
            UIAppearancePanel:GetAppellationViewTemplate():OnResAppellationStateChangeMessageReceived()
        end
    end
end
--endregion

function ondestroy()
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo ~= nil and CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData then
        CS.CSScene.Sington.MainPlayer.BaseInfo.Appearance.AppearanceData:StopPreview()
    end
end

return UIAppearancePanel