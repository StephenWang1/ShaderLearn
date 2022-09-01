---拍卖行元宝交易界面目录
---@class UIAuctionPanel_TradePanel_Menu:UIAuctionFiltrateList
local UIAuctionPanel_TradePanel_Menu = {}
setmetatable(UIAuctionPanel_TradePanel_Menu, luaComponentTemplates.UIAuctionFiltrateList)

---@type table<number,Top_UIDropDown> 三级页签对应组件
UIAuctionPanel_TradePanel_Menu.ThirdMenuToDropDown = {}

---@type table<number,Top_UIDropDownDropdownData>
UIAuctionPanel_TradePanel_Menu.TypeToCSDropdownData = {}

UIAuctionPanel_TradePanel_Menu.mSortType = {
    [LuaEnumAuctionTradeSortType.PriceUp] = "价格↑",
    [LuaEnumAuctionTradeSortType.PriceDown] = "价格↓",
    [LuaEnumAuctionTradeSortType.TimeUp] = "时间↑",
    [LuaEnumAuctionTradeSortType.TimeDown] = "时间↓",
}

UIAuctionPanel_TradePanel_Menu.mSortCoinType = {
    [LuaEnumAuctionTradeCoinSortType.All] = "全部",
    [LuaEnumAuctionTradeCoinSortType.YuanBao] = "元宝",
    [LuaEnumAuctionTradeCoinSortType.Diamond] = "钻石",
}

UIAuctionPanel_TradePanel_Menu.mSortCoinMenu = {
    LuaEnumAuctionTradeCoinSortType.All, LuaEnumAuctionTradeCoinSortType.YuanBao, LuaEnumAuctionTradeCoinSortType.Diamond
}

UIAuctionPanel_TradePanel_Menu.mSortTypeMenu = {
    LuaEnumAuctionTradeSortType.PriceUp, LuaEnumAuctionTradeSortType.PriceDown, LuaEnumAuctionTradeSortType.TimeUp, LuaEnumAuctionTradeSortType.TimeDown
}

---五级目录筛选条件集合
---@type table<number,number>
UIAuctionPanel_TradePanel_Menu.mFiveChoose = {}

--region 初始化
function UIAuctionPanel_TradePanel_Menu:Init(panel)
    self:RunBaseFunction("Init", panel)
    self:InitEvent()

    self.ChooseSort = false
    self.mChooseCoinSort = false
    self.mPriceHighToLow = true

    self.SortType = LuaEnumAuctionTradeSortType.TimeDown
    self.mStartSortCoinType = LuaEnumAuctionTradeCoinSortType.All
    self.hasInitSortComp = false
    self.hasInitCoinSortComp = false
end

function UIAuctionPanel_TradePanel_Menu:InitComponent()
    self:RunBaseFunction("InitComponent")
    ---@type UIGridContainer
    ---三级目录Container
    self.typeList_UIGridContainer = self:Get("Retrieve/SmallType/TypeList", "UIGridContainer")

    self.search_GameObject = self:Get("Search/search_btn", "GameObject")
    self.search_UIInput = self:Get("Search", "UIInput")

    self.priceSort_GameObject = self:Get("PriceSort/Caption", "GameObject")

    ---@type TweenRotation 排序旋转
    self.sortArrow = self:Get("PriceSort/Caption/Btn_program", "TweenRotation")

    ---排序文本
    self.SortLabel = self:Get("PriceSort/Caption/CaptionLabel", "UILabel")

    ---@type UIGridContainer 排序container
    self.sortContainer = self:Get("PriceSort/Sort", "UIGridContainer")

    ---@type UnityEngine.GameObject 货币排序
    self.mCoinSort_GameObject = self:Get("CoinSort/Caption", "GameObject")

    ---@type TweenRotation 货币排序旋转
    self.mCoinSortArrow_TweenRotation = self:Get("CoinSort/Caption/Btn_program", "TweenRotation")

    ---排序文本
    self.mCoinSortLabel = self:Get("CoinSort/Caption/CaptionLabel", "UILabel")

    ---@type UIGridContainer 排序container
    self.mCoinSortContainer = self:Get("CoinSort/Sort", "UIGridContainer")
end

function UIAuctionPanel_TradePanel_Menu:InitEvent()
    CS.UIEventListener.Get(self.priceSort_GameObject).onClick = function(go)
        self:OnPriceClicked(go)
    end
    CS.UIEventListener.Get(self.mCoinSort_GameObject).onClick = function(go)
        self:OnSortCoinClicked(go)
    end
    CS.UIEventListener.Get(self.search_GameObject).onClick = function(go)
        self:OnSearchClicked()
        ---@type UIAuctionPanel_TradePanel
        local TradeMenu = self.RootPanel
        TradeMenu:SetNeedRefresh()
    end
    CS.UIEventListener.Get(self.sortContainer.gameObject).onClick = function(go)
        self:OnCloseChooseClicked()
    end
    CS.UIEventListener.Get(self.mCoinSortContainer.gameObject).onClick = function(go)
        self:OnCloseCoinSortClicked()
    end
end
--endregion

--region刷新右上角页签
---@param btnTable TABLE.CFG_ITEM_TRADETYPE 表数据
---@param otherChoose table<number,number> 唯一id对应需要选中id 比如14职业对应要选中职业107
function UIAuctionPanel_TradePanel_Menu:SetFiltrateBtn(btnTable, otherChoose)
    -- self:SetThirdAndFourthOrderBtn(btnTable)
    self:GetThirdMenuData(btnTable)
    if otherChoose then
        for k, v in pairs(otherChoose) do
            ---@type  Top_UIDropDown
            local dropDown = self.ThirdMenuToDropDown[k]
            local chooseId = self.TypeToCSDropdownData[v]
            if dropDown and chooseId then
                dropDown:Selected(chooseId, true)
            end
        end
    end
end
--endregion

---解析三级数据
---@param btnTable TABLE.CFG_ITEM_TRADETYPE
function UIAuctionPanel_TradePanel_Menu:GetThirdMenuData(btnTable)
    self.btnTable = btnTable
    self.ThirdMenuToDropDown = {}
    self.TypeToCSDropdownData = {}
    self.mCurrentChooseFourthId = nil
    self.mCurrentFourthDropDown = nil
    if btnTable ~= nil and btnTable.screenTag ~= nil and btnTable.screenTag.list.Count > 0 then
        local thirdIdList = btnTable.screenTag.list
        local showinfo = self:CombineIds(thirdIdList)
        self:RefreshThirdMenuShow(showinfo)
    else
        self:RefreshThirdMenuShow(nil)
    end
end

---刷新三级页签显示
---@param showIdList table<number,number> 需要显示的id列表
function UIAuctionPanel_TradePanel_Menu:RefreshThirdMenuShow(showIdList)
    if showIdList then
        self.typeList_UIGridContainer.MaxCount = #showIdList
        for i = 0, #showIdList - 1 do
            local go = self.typeList_UIGridContainer.controlList[i]
            local id = showIdList[i + 1]
            local data = self:GetMenuDataCache(id)
            if not CS.StaticUtility.IsNull(go) and data then
                self:RefreshSingleBtn(go, data, i)
            end
        end
    else
        self.typeList_UIGridContainer.MaxCount = 0
    end
end

---刷新增加道具
function UIAuctionPanel_TradePanel_Menu:RefreshAddShowList(addList)
    local CurrentNum = self.btnTable.screenTag.list.Count
    if addList then
        self.typeList_UIGridContainer.MaxCount = CurrentNum + addList.Count
        for i = CurrentNum, CurrentNum + addList.Count - 1 do
            local go = self.typeList_UIGridContainer.controlList[i]
            local id = addList[i - CurrentNum]
            local data = self:GetMenuDataCache(id)
            if not CS.StaticUtility.IsNull(go) and data then
                self:RefreshSingleBtn(go, data, i)
            end
        end
    else
        self.typeList_UIGridContainer.MaxCount = CurrentNum
    end
end

---刷新单个三级页签
---@param go UnityEngine.GameObject 单个页签GO
---@param data TABLE.CFG_ITEM_TRADETYPE
function UIAuctionPanel_TradePanel_Menu:RefreshSingleBtn(go, data, i)
    ---@type UILabel 下拉框名字
    local btnLabel = CS.Utility_Lua.Get(go.transform, "DropDown/Caption/CaptionLabel", "UILabel")
    ---@type Top_UIDropDown
    local dropDown = CS.Utility_Lua.Get(go.transform, "DropDown", "Top_UIDropDown")
    --存储数据
    self.ThirdMenuToDropDown[data.id] = dropDown
    --刷新显示
    btnLabel.text = "[878787]" .. data.name
    if data.screenOption then
        self:RefreshFourthMenu(data.screenOption.list, dropDown, i)
    end
end

---设置四级目录显示
---@param forthIdList
---@param q number 这是序号不知道干嘛用的
---@param dropDown Top_UIDropDown
function UIAuctionPanel_TradePanel_Menu:RefreshFourthMenu(forthIdList, dropDown, q)
    if forthIdList == nil or CS.StaticUtility.IsNull(dropDown) then
        return
    end
    local forthNameList = {}
    local forthStrIdList = {}
    for i = 0, forthIdList.Count - 1 do
        local forthId = forthIdList[i]
        local data = self:GetMenuDataCache(forthId)
        if data then
            local name = data.name
            table.insert(forthNameList, name)
            local id = tostring(self:AnalysisForthBtnSave(data))
            table.insert(forthStrIdList, forthId)
            ---@type Top_UIDropDownDropdownData
            local DropDownDropdownData = {}
            DropDownDropdownData.Label = data.name
            DropDownDropdownData.SpriteName = ""
            DropDownDropdownData.ExtraData = id
            self.TypeToCSDropdownData[forthId] = DropDownDropdownData
        end
    end
    dropDown:SetOptions(forthNameList, forthStrIdList)
    dropDown.OnValueChange:Add(function(eventTemp)
        local id = tonumber(eventTemp.ExtraData)
        local data = self:GetMenuDataCache(id)
        if data.type == 4 then
            --点击四级目录
            self.mFiveChoose = {}
            if data.screenOption then
                self:RefreshAddShowList(data.screenOption.list)
            else
                self:RefreshAddShowList(nil)
            end
            local extraData = tostring(self:AnalysisForthBtnSave(data))
            self:AnalysisForthBtnSend(extraData, self.leftConditionCount + q + 1)
        else
            --点击五级目录
            self:AddFiveMenuChooseData(id, self.leftConditionCount + q + 1)
        end
        self:ReqFilterItems(1)
    end)
end

---组合两个list
function UIAuctionPanel_TradePanel_Menu:CombineIds(list1, list2)
    local data = {}
    if list1 then
        for i = 0, list1.Count - 1 do
            table.insert(data, list1[i])
        end
    end
    if list2 then
        for i = 0, list2.Count - 1 do
            table.insert(data, list2[i])
        end
    end
    return data
end
--region设置三四级按钮

function UIAuctionPanel_TradePanel_Menu:SetThirdAndFourthOrderBtn(btnTable)
    ---设置三级页签
    local thirdIdList = btnTable.screenTag.list
    self.typeList_UIGridContainer.MaxCount = thirdIdList.Count
    local length = self.typeList_UIGridContainer.controlList.Count - 1
    for k = 0, length do
        local v = self.typeList_UIGridContainer.controlList[k]
        if v ~= nil then
            local thirdTableIsFind, thirdTable = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(thirdIdList[k])
            if thirdTableIsFind then
                local thirdBtn = v
                local thirdBtn_Label = self:GetCurComp(thirdBtn, "DropDown/Caption/CaptionLabel", "Top_UILabel")
                ---@type Top_UIDropDown
                local thirdBtn_DropDown = self:GetCurComp(thirdBtn, "DropDown", "Top_UIDropDown")
                self.ThirdMenuToDropDown[thirdIdList[k]] = thirdBtn_DropDown
                thirdBtn_Label.text = "[878787]" .. thirdTable.name
                ---策划只对4级页签做了区分
                if thirdTable.screenOption ~= nil then
                    local forthIdList = thirdTable.screenOption.list
                    local forthNameList = {}
                    local forthStrIdList = {}

                    local forthIdListLength = thirdTable.screenOption.list.Count - 1
                    for k = 0, forthIdListLength do
                        local v = forthIdList[k]
                        local forthTableIsFind, forthTable = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(v)
                        if forthTableIsFind then
                            local name = forthTable.name
                            table.insert(forthNameList, name)
                            local id = tostring(self:AnalysisForthBtnSave(forthTable))
                            table.insert(forthStrIdList, id)
                            ---@type Top_UIDropDownDropdownData
                            local DropDownDropdownData = {}
                            DropDownDropdownData.Label = forthTable.name
                            DropDownDropdownData.SpriteName = ""
                            DropDownDropdownData.ExtraData = id
                            self.TypeToCSDropdownData[v] = DropDownDropdownData
                        end
                    end
                    thirdBtn_DropDown:SetOptions(forthNameList, forthStrIdList)
                    thirdBtn_DropDown.OnValueChange:Add(function(eventTemp)
                        self:AnalysisForthBtnSend(eventTemp.ExtraData, self.leftConditionCount + k + 1)
                        -- self:ReqFilterItems(1)
                    end)
                end
            end
        end
    end
end

---设置三四级页签选中
---@param typeId number 选中id Item_TradeType表id
function UIAuctionPanel_TradePanel_Menu:ChooseType(typeId)
    local res, tradeInfo = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(typeId)
    if res then
        local forthBtnMsg = tradeInfo.param
        if forthBtnMsg then
            self:AnalysisForthBtnSend(forthBtnMsg, nil)
        end
    end
end

---解析四级按钮数据并保存
function UIAuctionPanel_TradePanel_Menu:AnalysisForthBtnSave(forthBtnTable)
    if forthBtnTable ~= nil and forthBtnTable.param ~= "" then
        return forthBtnTable.param
    elseif forthBtnTable ~= nil and forthBtnTable.param == "" then
        return forthBtnTable.id
    else
        return 0
    end
end

---解析四级按钮点击数据进行解析
function UIAuctionPanel_TradePanel_Menu:AnalysisForthBtnSend(forthBtnMsg, conditionIndex)
    if forthBtnMsg ~= nil then
        if string.find(forthBtnMsg, '&') ~= 2 then
            ---只需保存id
            self.filtrateConditionList[conditionIndex] = tonumber(forthBtnMsg)
        else
            local typeAndData = string.Split(forthBtnMsg, '&')
            local type = tonumber(typeAndData[1])
            local data = typeAndData[2]
            if type == 1 then
                --使用等级
                self:AnalysisLevel(type, data)
            elseif type == 2 then
                --转生等级
                self:AnalysisLevel(type, data)
            elseif type == 3 then
                --性别
                self:AnalysisSex(data)
            elseif type == 4 then
                --职业
                self:AnalysisCareer(data)
            elseif type == 5 then
                self:AnalysisSpecialCareer(data)
            end
        end
    end
end

function UIAuctionPanel_TradePanel_Menu:AddFiveMenuChooseData(id, conditionIndex)
    if self.mFiveChoose then
        self.mFiveChoose[conditionIndex] = id
    end
end
--endregion

--region 设置职业等级等数据
---解析等级
function UIAuctionPanel_TradePanel_Menu:AnalysisLevel(type, data)
    if type == 2 then
        --转生等级
        local reinLvelList = string.Split(data, '#')
        self.LevelAndCareerAndSexMsgList.minLv = tonumber(reinLvelList[1]) * 1000
        self.LevelAndCareerAndSexMsgList.maxLv = tonumber(reinLvelList[2]) * 1000
    else
        --等级
        local levelList = string.Split(data, '#')
        self.LevelAndCareerAndSexMsgList.minLv = tonumber(levelList[1])
        self.LevelAndCareerAndSexMsgList.maxLv = tonumber(levelList[2])
    end
end

---解析性别
function UIAuctionPanel_TradePanel_Menu:AnalysisSex(data)
    self.LevelAndCareerAndSexMsgList.sex = data
end

---解析职业
function UIAuctionPanel_TradePanel_Menu:AnalysisCareer(data)
    self.LevelAndCareerAndSexMsgList.career = data
end

---解析职业偏向
function UIAuctionPanel_TradePanel_Menu:AnalysisSpecialCareer(data)
    self.CareerPropertyTendency = data
end
--endregion

--region 发送消息请求
function UIAuctionPanel_TradePanel_Menu:NetWorkReq(page)
    local matchesString = self.search_UIInput.value
    if not CS.StaticUtility.IsNullOrEmpty(matchesString) then
        self:OnSearchClicked(page)
        return
    end
    local pageIndex = ternary(page == nil or page == 0, 1, page)
    local minLv = tonumber(self.LevelAndCareerAndSexMsgList.minLv)
    local maxLv = tonumber(self.LevelAndCareerAndSexMsgList.maxLv)
    local career = tonumber(self.LevelAndCareerAndSexMsgList.career)
    local sex = tonumber(self.LevelAndCareerAndSexMsgList.sex)
    local list = CS.auctionV2.GetAuctionItemsRequest().screenCondition
    if list ~= nil then
        if #self.filtrateConditionList == 0 then
            list:Add(0)
        else
            for k, v in pairs(self.filtrateConditionList) do
                list:Add(v)
            end
        end
        for k, v in pairs(self.mFiveChoose) do
            list:Add(v)
        end
    end
    local itemType = Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)
    local sortType = uiStaticParameter.mAuctionSortType[self.sortBy]
    networkRequest.ReqGetAuctionItems(pageIndex, minLv, maxLv, self.sortCoinType, sex, career, -1, list, itemType, sortType, self.mPriceHighToLow, self.CareerPropertyTendency)
end

function UIAuctionPanel_TradePanel_Menu:ReqFilterItems(page)
    self:ClearSearchInfo()
    if not self.hasInitCoinSortComp or not self.hasInitSortComp then
        self:InitSortChoose()
        return
    end
    ---@type UIAuctionPanel_TradePanel
    local TradeMenu = self.RootPanel
    TradeMenu:ClearCurrentData()
    self:NetWorkReq(page)
    TradeMenu:SetNeedRefresh()
end
--endregion

--region 点击事件
---点击搜索
function UIAuctionPanel_TradePanel_Menu:OnSearchClicked(page)
    if page == nil then
        ---@type UIAuctionPanel_TradePanel
        local TradeMenu = self.RootPanel
        TradeMenu:ClearCurrentData()
        TradeMenu:SetNeedRefresh()
    end

    local matchesString = self.search_UIInput.value
    local minLv = tonumber(self.LevelAndCareerAndSexMsgList.minLv)
    local maxLv = tonumber(self.LevelAndCareerAndSexMsgList.maxLv)
    local career = tonumber(self.LevelAndCareerAndSexMsgList.career)
    local sex = tonumber(self.LevelAndCareerAndSexMsgList.sex)
    ---@type auctionV2.GetAuctionItemsRequest
    local info = CS.auctionV2.GetAuctionItemsRequest()
    info.page = ternary(page == nil or page == 0, 1, page)
    info.minLevel = minLv
    info.maxLevel = maxLv
    info.currency = self.sortCoinType
    info.sex = sex
    info.career = career
    info.toatlPageCount = -1
    if #self.filtrateConditionList == 0 then
        info.screenCondition:Add(0)
    else
        for i = 1, #self.filtrateConditionList do
            if self.filtrateConditionList[i] ~= "" then
                info.screenCondition:Add(self.filtrateConditionList[i])
            end
        end
    end
    info.itemType = Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)
    local sortType = uiStaticParameter.mAuctionSortType[self.sortBy]
    info.sortBy = sortType
    info.sort = self.mPriceHighToLow
    info.propertyTendency = self.CareerPropertyTendency
    networkRequest.ReqAuctionSearch(matchesString, info)
end

---点击价格排序
function UIAuctionPanel_TradePanel_Menu:OnPriceClicked(go)
    self.ChooseSort = true
    self:CloseChooseMenu(true)
    self:SetPriceAngle()
end

---关闭价格排序
function UIAuctionPanel_TradePanel_Menu:OnCloseChooseClicked(go)
    self.ChooseSort = false
    self:CloseChooseMenu(false)
    self:SetPriceAngle()
end

---设置价格图标旋转
function UIAuctionPanel_TradePanel_Menu:SetPriceAngle()
    if self.ChooseSort then
        self.sortArrow:PlayForward()
    else
        self.sortArrow:PlayReverse()
    end
end

---关闭价格排序显示
function UIAuctionPanel_TradePanel_Menu:CloseChooseMenu(isShow)
    self.sortContainer.gameObject:SetActive(isShow)
end

---点击货币排序
function UIAuctionPanel_TradePanel_Menu:OnSortCoinClicked()
    self.mChooseCoinSort = true
    self:CloseCoinSort(true)
    self:SetCoinSortAngle()
end

---关闭货币排序
function UIAuctionPanel_TradePanel_Menu:OnCloseCoinSortClicked()
    self.mChooseCoinSort = false
    self:CloseCoinSort(false)
    self:SetCoinSortAngle()
end

---设置货币排序图标旋转
function UIAuctionPanel_TradePanel_Menu:SetCoinSortAngle()
    if self.mChooseCoinSort then
        self.mCoinSortArrow_TweenRotation:PlayForward()
    else
        self.mCoinSortArrow_TweenRotation:PlayReverse()
    end
end

---关闭货币排序
function UIAuctionPanel_TradePanel_Menu:CloseCoinSort(isShow)
    self.mCoinSortContainer.gameObject:SetActive(isShow)
end

function UIAuctionPanel_TradePanel_Menu:InitSortChoose()
    if not self.hasInitSortComp then
        self.hasInitSortComp = true
        local func = function(type)
            if type == LuaEnumAuctionTradeSortType.PriceUp then
                self.mPriceHighToLow = false
                self.sortBy = LuaEnumAuctionPanelSortType.Price
            elseif type == LuaEnumAuctionTradeSortType.PriceDown then
                self.mPriceHighToLow = true
                self.sortBy = LuaEnumAuctionPanelSortType.Price
            elseif type == LuaEnumAuctionTradeSortType.TimeUp then
                self.mPriceHighToLow = false
                self.sortBy = LuaEnumAuctionPanelSortType.OverTime
            elseif type == LuaEnumAuctionTradeSortType.TimeDown then
                self.mPriceHighToLow = true
                self.sortBy = LuaEnumAuctionPanelSortType.OverTime
            end
            self:ReqFilterItems()
            self.SortLabel.text = self.mSortType[type]
            self:OnCloseChooseClicked()
        end
        self:InitSortMenu(self.sortContainer, self.mSortTypeMenu, self.mSortType, func, self.SortType)
    end
    if not self.hasInitCoinSortComp then
        self.hasInitCoinSortComp = true
        local func = function(type)
            self.sortCoinType = type
            self:ReqFilterItems()
            self.mCoinSortLabel.text = self.mSortCoinType[type]
            self:OnCloseCoinSortClicked()
        end
        self:InitSortMenu(self.mCoinSortContainer, self.mSortCoinMenu, self.mSortCoinType, func, self.mStartSortCoinType)
    end
end

---@param container UIGridContainer 组件
---@param menuTable table<number,string> 页签
---@param menu table<number,number> 目录
---@param delegate function 回调
---@param chooseType number 要选中的目录
function UIAuctionPanel_TradePanel_Menu:InitSortMenu(container, menu, menuTable, delegate, chooseType)
    if menu and menuTable then
        local typeToToggle = {}

        if not CS.StaticUtility.IsNull(container) then
            container.MaxCount = #menu
            for i = 0, #menu - 1 do
                local go = container.controlList[i]
                local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
                ---@type UILabel
                local typeLabel = CS.Utility_Lua.Get(go.transform, "LabelValue", "UILabel")
                typeLabel.text = menuTable[menu[i + 1]]
                CS.EventDelegate.Add(toggle.onChange, function()
                    if toggle.value then
                        delegate(menu[i + 1])
                        typeLabel.text = menuTable[menu[i + 1]]
                        typeLabel.effectStyle = CS.UILabel.Effect.Outline
                    else
                        typeLabel.text = "[878787]" .. menuTable[menu[i + 1]]
                        typeLabel.effectStyle = CS.UILabel.Effect.None
                    end
                end)
                typeToToggle[menu[i + 1]] = toggle
            end
        end
        local toggle = typeToToggle[chooseType]
        if toggle then
            toggle:Set(true)
        end
    end
end

--endregion

--region  外部调用搜索方法
function UIAuctionPanel_TradePanel_Menu:SelectSpecialItem(name)
    if name and name ~= "" then
        self:SetMenuChooseData(0)
        self.search_UIInput.value = name
        self:OnSearchClicked(0)
        ---@type UIAuctionPanel_TradePanel
        local TradeMenu = self.RootPanel
        TradeMenu:SetNeedRefresh()
    else
        self:OpenPage(0)
    end
end
--endregion

---清除搜索信息
function UIAuctionPanel_TradePanel_Menu:ClearSearchInfo()
    self.search_UIInput.value = ""
end

return UIAuctionPanel_TradePanel_Menu