---@class UIAuctionMenuPanelTemplateBase:TemplateBase 交易行目录界面Base
local UIAuctionMenuPanelTemplateBase = {}

---选中一级目录
UIAuctionMenuPanelTemplateBase.mCurrentChooseFirstMenuId = -1
---选中二级目录
UIAuctionMenuPanelTemplateBase.mCurrentChooseSecondMenuId = -1
---选中三级目录
UIAuctionMenuPanelTemplateBase.mCurrentChooseThirdMenuId = -1
---选中四级目录
UIAuctionMenuPanelTemplateBase.mCurrentChooseFourthMenuId = -1
---选中五级目录
UIAuctionMenuPanelTemplateBase.mCurrentChooseFifthMenuId = -1

--region 组件
---@return UIGridContainer 一级目录UIGridContainer
function UIAuctionMenuPanelTemplateBase:GetFirstMenu_UIGridContainer()
    if self.mFirstMenuContainer == nil then
        self.mFirstMenuContainer = self:Get("ScrollView/ToggleBtn/FirstMenu", "UIGridContainer")
    end
    return self.mFirstMenuContainer
end

---@return UIGridContainer 二级目录UIGridContainer
function UIAuctionMenuPanelTemplateBase:GetSecondMenu_UIGridContainer()
    if self.mSecondMenuContainer == nil then
        self.mSecondMenuContainer = self:Get("ScrollView/ToggleBtn/SecondMenu", "UIGridContainer")
    end
    return self.mSecondMenuContainer
end

---@return UnityEngine.GameObject
function UIAuctionMenuPanelTemplateBase:GetThirdMenu_Go()
    if self.mThirdMenuGo == nil then
        self.mThirdMenuGo = self:Get("Retrieve", "GameObject")
    end
    return self.mThirdMenuGo
end

---@return UIGridContainer 三级目录UIGridContainer
function UIAuctionMenuPanelTemplateBase:GetThirdMenu_UIGridContainer()
    if self.mThirdMenuContainer == nil then
        self.mThirdMenuContainer = self:Get("Retrieve/SmallType/TypeList", "UIGridContainer")
    end
    return self.mThirdMenuContainer
end

---@return UIScrollView
function UIAuctionMenuPanelTemplateBase:GetScrollView()
    if self.mScroll == nil then
        self.mScroll = self:Get("ScrollView", "UIScrollView")
    end
    return self.mScroll
end

---@return UIPanel
function UIAuctionMenuPanelTemplateBase:GetScrollPanel()
    if self.mScrollPanel == nil then
        self.mScrollPanel = self:Get("ScrollView", "UIPanel")
    end
    return self.mScrollPanel
end

--endregion

--region 初始化
function UIAuctionMenuPanelTemplateBase:Init(mManagePanel)
end
--endregion

function UIAuctionMenuPanelTemplateBase:RefreshMenus()
    self.mHasChooseSecond = false
    self:RefreshFirstMenu()
    self:ClickFirstMenu(0)
end

function UIAuctionMenuPanelTemplateBase:ResetMenu()
    self:RefreshMenus()
end

--region 一级目录
function UIAuctionMenuPanelTemplateBase:RefreshFirstMenu()
    self.mFirstMenuToGo = {}
    local menuF = self:GetFirstMenuData()
    if menuF and #menuF > 0 then
        self:GetFirstMenu_UIGridContainer().MaxCount = #menuF
        for i = 0, self:GetFirstMenu_UIGridContainer().controlList.Count - 1 do
            ---@type UnityEngine.GameObject
            local goF = self:GetFirstMenu_UIGridContainer().controlList[i]
            local menuId = menuF[i + 1]
            ---@type UILabel
            local lb1 = CS.Utility_Lua.Get(goF.transform, "backgroud/Label", "UILabel")
            ---@type UILabel
            local lb2 = CS.Utility_Lua.Get(goF.transform, "checkMark/Label", "UILabel")
            local btn = CS.Utility_Lua.Get(goF.transform, "backgroud", "GameObject")
            local showLb = ""
            if menuId == 0 then
                showLb = "全部"
            else
                local tblInfo = self:CacheTradeTypeTableInfo(menuId)
                if tblInfo then
                    showLb = tblInfo.name
                end
            end
            if not CS.StaticUtility.IsNull(lb1) and not CS.StaticUtility.IsNull(lb2) then
                lb1.text = luaEnumColorType.Gray .. showLb
                lb2.text = showLb
            end
            self:ManageFirstMenuChoose(goF, false)
            self.mFirstMenuToGo[menuId] = goF
            CS.UIEventListener.Get(btn).onClick = function()
                self:ClickFirstMenu(menuId)
            end
        end
    end
end

---点击一级目录
function UIAuctionMenuPanelTemplateBase:ClickFirstMenu(menuId)
    local go = self.mFirstMenuToGo[menuId]
    if go then
        local lastGo = self.mFirstMenuToGo[self.mCurrentChooseFirstMenuId]
        if lastGo then
            self:ManageFirstMenuChoose(lastGo, false)
        end
        self:ManageFirstMenuChoose(go, true)
        if self.mCurrentChooseFirstMenuId == menuId then
            self.mHasChooseSecond = not self.mHasChooseSecond
        else
            self.mHasChooseSecond = true
        end

        self.mCurrentChooseFirstMenuId = menuId
        self.mCurrentChooseSecondMenuId = -1
        self:ClearThirdMenuTemplate()
        if self.mHasChooseSecond then
            self:RefreshSecondMenu(menuId)
        else
            self:RefreshSecondMenu(nil)
        end
        self:RefreshFirstMenuChooseSp()
        self:SuitMenu()
        self:ChooseSecondMenuChange()
        self:ChooseMenuChange()
    end
end

---管理一级目录选中
function UIAuctionMenuPanelTemplateBase:ManageFirstMenuChoose(go, choose)
    if not CS.StaticUtility.IsNull(go) then
        if self.mGoToChooseSp == nil then
            self.mGoToChooseSp = {}
        end
        local sp = self.mGoToChooseSp[go]
        if sp == nil then
            ---@type UISprite
            sp = CS.Utility_Lua.Get(go.transform, "checkMark", "UISprite")
        end
        sp.gameObject:SetActive(choose)
        if choose then
            self.mCurrentChooseFirstMenuSprite = sp
        end
    end
end

function UIAuctionMenuPanelTemplateBase:RefreshFirstMenuChooseSp()
    if self.mCurrentChooseFirstMenuSprite then
        self.mCurrentChooseFirstMenuSprite.spriteName = self.mCurrentChooseSecondMenuId == -1 and "tab_type3" or "tab_type2"
    end
end
--endregion

--region 二级目录
function UIAuctionMenuPanelTemplateBase:RefreshSecondMenu(secondMenuId)
    self.mSecondMenuToGo = {}
    if secondMenuId then
        local secondMenuInfo = self:CacheTradeTypeTableInfo(secondMenuId)
        if secondMenuInfo then
            local secondIds = secondMenuInfo.subset
            if secondIds and secondIds.list then
                self:GetSecondMenu_UIGridContainer().MaxCount = secondIds.list.Count
                for i = 0, self:GetSecondMenu_UIGridContainer().controlList.Count - 1 do
                    if i < secondIds.list.Count then
                        local goS = self:GetSecondMenu_UIGridContainer().controlList[i]
                        local secondMenuId = secondIds.list[i]
                        ---@type UILabel
                        local lb1 = CS.Utility_Lua.Get(goS.transform, "checkMark/Label", "UILabel")
                        ---@type UILabel
                        local lb2 = CS.Utility_Lua.Get(goS.transform, "checkMarkBg/Label", "UILabel")
                        local btn = CS.Utility_Lua.Get(goS.transform, "checkMarkBg", "GameObject")
                        local showLb = ""
                        local tblInfo = self:CacheTradeTypeTableInfo(secondMenuId)
                        if tblInfo then
                            showLb = tblInfo.name
                        end
                        if not CS.StaticUtility.IsNull(lb1) and not CS.StaticUtility.IsNull(lb2) then
                            lb1.text = showLb
                            lb2.text = luaEnumColorType.Gray .. showLb
                        end
                        self.mSecondMenuToGo[secondMenuId] = goS
                        self:ManageSecondMenuChoose(goS, false)
                        CS.UIEventListener.Get(btn).onClick = function()
                            self:ClickSecondMenu(secondMenuId)
                        end
                    end
                end
                return
            end
        end
    end
    self:GetSecondMenu_UIGridContainer().MaxCount = 0
end

---选中二级目录
function UIAuctionMenuPanelTemplateBase:ClickSecondMenu(menuId)
    local go = self.mSecondMenuToGo[menuId]
    if go then
        if menuId ~= self.mCurrentChooseSecondMenuId then
            local lastGo = self.mSecondMenuToGo[self.mCurrentChooseSecondMenuId]
            if lastGo then
                self:ManageSecondMenuChoose(lastGo, false)
            end
            self:ManageSecondMenuChoose(go, true)
            self.mCurrentChooseSecondMenuId = menuId
            self:RefreshFirstMenuChooseSp()
            self:ChooseSecondMenuChange()
            self:ChooseMenuChange()
        end
    end
end

---管理二级目录选中
function UIAuctionMenuPanelTemplateBase:ManageSecondMenuChoose(go, choose)
    if not CS.StaticUtility.IsNull(go) then
        if self.mGoToChooseSp == nil then
            self.mGoToChooseSp = {}
        end
        local sp = self.mGoToChooseSp[go]
        if sp == nil then
            ---@type UISprite
            sp = CS.Utility_Lua.Get(go.transform, "checkMark", "UISprite")
        end
        sp.gameObject:SetActive(choose)
    end
end
--endregion

--region 界面适配
---刷新目录位置
function UIAuctionMenuPanelTemplateBase:SuitMenu()
    self:GetScrollView():ResetPosition()
    if self.mCurrentChooseFirstMenuId then
        local firstMenu = self:GetFirstMenuData()
        local currentHeight = 0
        local hasAddSecond = false
        local totalHeight = 0--到选中目录高度，并不是总高度
        for i = 0, self:GetFirstMenu_UIGridContainer().controlList.Count - 1 do
            ---@type UnityEngine.GameObject
            local go = self:GetFirstMenu_UIGridContainer().controlList[i]
            if not CS.StaticUtility.IsNull(go) then
                local firstId = firstMenu[i + 1]
                local pos = go.transform.localPosition
                pos.y = currentHeight
                --设置一级目录位置
                go.transform.localPosition = pos
                --加一级目录高度
                currentHeight = currentHeight - self:GetFirstMenuHeight()
                if not hasAddSecond then
                    totalHeight = totalHeight + self:GetFirstMenuHeight()
                end

                if firstId == self.mCurrentChooseFirstMenuId and self.mHasChooseSecond then
                    local secondPos = self:GetSecondMenu_UIGridContainer().gameObject.transform.localPosition
                    secondPos.y = currentHeight + (self:GetFirstMenuHeight() - self:GetSecondMenuHeight()) / 2
                    --设置二级目录位置
                    self:GetSecondMenu_UIGridContainer().gameObject.transform.localPosition = secondPos
                    --加二级目录高度
                    local secondInfo = self:CacheTradeTypeTableInfo(firstId)
                    if secondInfo and secondInfo.subset then
                        local secondIds = secondInfo.subset.list
                        currentHeight = currentHeight - secondIds.Count * self:GetSecondMenuHeight()
                        --hasAddSecond = true
                        totalHeight = totalHeight + secondIds.Count * self:GetSecondMenuHeight()
                    end

                    hasAddSecond = true
                end
            end
        end
        if self:GetScrollPanel() and self:GetScrollView() then
            local scrollHeight = self:GetScrollPanel().baseClipRegion.w
            local pos = self:GetScrollView().transform.localPosition
            if scrollHeight < totalHeight then
                pos.y = totalHeight - scrollHeight
                self:GetScrollView():Begin(pos, 10)
            end
        end
    end
end
--endregion

--region 获取数据
---@return number  一级目录高度
function UIAuctionMenuPanelTemplateBase:GetFirstMenuHeight()
    if self.mFirstMenuHeight == nil and self:GetFirstMenu_UIGridContainer() then
        self.mFirstMenuHeight = 0
        self.mFirstMenuHeight = self:GetFirstMenu_UIGridContainer().CellHeight
    end
    return self.mFirstMenuHeight
end

---@return number 二级目录高度
function UIAuctionMenuPanelTemplateBase:GetSecondMenuHeight()
    if self.mSecondMenuHeight == nil and self:GetSecondMenu_UIGridContainer() then
        self.mSecondMenuHeight = 0
        self.mSecondMenuHeight = self:GetSecondMenu_UIGridContainer().CellHeight
    end
    return self.mSecondMenuHeight
end

---@return TABLE.CFG_ITEM_TRADETYPE 缓存目录表数据
function UIAuctionMenuPanelTemplateBase:CacheTradeTypeTableInfo(tradeId)
    if tradeId == nil then
        return
    end
    if self.mTradeIdToInfo == nil then
        self.mTradeIdToInfo = {}
    end
    local info = self.mTradeIdToInfo[tradeId]
    if info == nil then
        ___, info = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(tradeId)
        self.mTradeIdToInfo[tradeId] = info
    end
    return info
end
--endregion

--region三级目录
---是否显示三级目录
function UIAuctionMenuPanelTemplateBase:NeedShowThirdMenu()
    return false
end

---选中二级目录改变(用于扩展三四级目录等操作)
function UIAuctionMenuPanelTemplateBase:ChooseSecondMenuChange()
    self:ClearThirdMenuTemplate()
    self:GetThirdMenu_Go():SetActive(self:NeedShowThirdMenu())
    if self.mCurrentChooseSecondMenuId ~= -1 then
        self:RefreshThirdMenu(self.mCurrentChooseSecondMenuId)
    elseif self.mCurrentChooseFirstMenuId ~= -1 then
        self:RefreshThirdMenu(self.mCurrentChooseFirstMenuId)
    end
end

---清除当前选中的三级目录模板
function UIAuctionMenuPanelTemplateBase:ClearThirdMenuTemplate()
    ---@type table<number,UIAuctionDropDown_SmeltSortTemplate>
    self.mThirdTemplates = {}
end

---获取当前选中的三级目录模板
function UIAuctionMenuPanelTemplateBase:GetCurrentThirdMenuTemplate()
    return self.mThirdTemplates
end

---存储当前选中三级目录模板
function UIAuctionMenuPanelTemplateBase:SaveCurrentThirdMenuTemplate(template)
    if self.mThirdTemplates == nil then
        self.mThirdTemplates = {}
    end
    table.insert(self.mThirdTemplates, template)
end

---刷新三级目录
function UIAuctionMenuPanelTemplateBase:RefreshThirdMenu(chooseId)
    local menuInfo = self:CacheTradeTypeTableInfo(chooseId)
    if menuInfo and menuInfo.screenTag then
        local showList = menuInfo.screenTag.list
        if showList and showList.Count > 0 then
            local thirdMenuId = self:GetTableList(menuInfo.screenTag.list)
            self:RefreshThirdMenuGridContainer(thirdMenuId)
        else
            self:RefreshThirdMenuGridContainer(nil)
        end
    else
        self:RefreshThirdMenuGridContainer(nil)
    end
end

---刷新三级目录container显示,方便添加四五级目录（策划的骚操作）
---@param menuList table<number,number> 需要显示的menulist
function UIAuctionMenuPanelTemplateBase:RefreshThirdMenuGridContainer(menuList)
    self.mCurrentThirdMenuList = menuList
    if menuList == nil then
        self:GetThirdMenu_UIGridContainer().MaxCount = 0
        return
    end
    self:GetThirdMenu_UIGridContainer().MaxCount = #menuList
    for i = 0, self:GetThirdMenu_UIGridContainer().controlList.Count - 1 do
        local thirdId = menuList[i + 1]
        local go = self:GetThirdMenu_UIGridContainer().controlList[i]
        local thirdInfo = self:CacheTradeTypeTableInfo(thirdId)
        self:RefreshSingleThirdMenuItem(thirdInfo, thirdId, go)
    end
end

---添加三级目录
function UIAuctionMenuPanelTemplateBase:AddThirdMenuGridContainer(menuList)
    if self.mCurrentThirdMenuList then
        local currentNum = #self.mCurrentThirdMenuList
        local allNum = #menuList + currentNum
        self:GetThirdMenu_UIGridContainer().MaxCount = allNum
        print("menuList", #menuList)
        for k, v in pairs(menuList) do
            print(k, v)
        end
        for i = currentNum, allNum - 1 do
            local index = i - currentNum + 1
            local thirdId = menuList[index]
            local go = self:GetThirdMenu_UIGridContainer().controlList[i]
            local thirdInfo = self:CacheTradeTypeTableInfo(thirdId)
            self:RefreshSingleThirdMenuItem(thirdInfo, thirdId, go)
        end
    end
end

---获得三级目录选中状态
function UIAuctionMenuPanelTemplateBase:GetThirdMenuChooseState(id)
    if self.mThirdMenuChooseState == nil then
        self.mThirdMenuChooseState = {}
    end
    local state = self.mThirdMenuChooseState[id]
    if state == nil then
        state = false
    end
    return state
end

---存储三级目录选中状态
function UIAuctionMenuPanelTemplateBase:SaveThirdMenuChooseState(id, state)
    if self.mThirdMenuChooseState == nil then
        self.mThirdMenuChooseState = {}
    end
    self.mThirdMenuChooseState[id] = state
end

---清空三级目录选中状态
function UIAuctionMenuPanelTemplateBase:ClearThirdMenuChooseState()
    if self.mThirdMenuChooseState == nil then
        self.mThirdMenuChooseState = {}
    end
    self.mThirdMenuChooseState = {}
end

---刷新单个三级目录
function UIAuctionMenuPanelTemplateBase:RefreshSingleThirdMenuItem(thirdInfo, thirdId, go)
    if thirdInfo then
        local dropDown = thirdInfo.screenOption.list
        local info = self:GetTableList(dropDown)
        local template = self:SaveSortTemplate(go)
        if template then
            template:RefreshDropDown(info, thirdId)
            self:SaveCurrentThirdMenuTemplate(template)
        end
    end
end

---将list转为table
function UIAuctionMenuPanelTemplateBase:GetTableList(list)
    local tblList = {}
    if list then
        for i = 0, list.Count - 1 do
            table.insert(tblList, list[i])
        end
        return tblList
    end
end

---@return UIAuctionDropDown_SmeltSortTemplate
function UIAuctionMenuPanelTemplateBase:SaveSortTemplate(go)
    if self.mSortGoToTemplate == nil then
        self.mSortGoToTemplate = {}
    end
    local template = self.mSortGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionDropDown_SmeltSortTemplate, self)
        self.mSortGoToTemplate[go] = template
    end
    return template
end
--endregion

--region 四级目录
---当选中三级目录的时候如果有四级页签继续把这部分页签加到三级目录里面，数据从三级目录里面取
---@param rootId number 选中的三级目录id
function UIAuctionMenuPanelTemplateBase:RefreshFourthMenu(rootId, type)
    local fourthMenuData = self:CacheTradeTypeTableInfo(type)
    if fourthMenuData and fourthMenuData then
        if fourthMenuData.type == 4 and fourthMenuData.screenOption and fourthMenuData.screenOption.list then
            local thirdMenuId = self:GetTableList(fourthMenuData.screenOption.list)
            self:AddThirdMenuGridContainer(thirdMenuId)
        end
    end
end
--endregion

--region 重写变化
function UIAuctionMenuPanelTemplateBase:GetFirstMenuData()
end

---选中目录改变（用于发送请求）
function UIAuctionMenuPanelTemplateBase:ChooseMenuChange()
    -- print("一级目录", self.mCurrentChooseFirstMenuId)
    -- print("二级目录", self.mCurrentChooseSecondMenuId)
    -- 懂我意思伐
end
--endregion

return UIAuctionMenuPanelTemplateBase