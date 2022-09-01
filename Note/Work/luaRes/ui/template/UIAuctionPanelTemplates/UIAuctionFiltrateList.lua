---拍卖行目录总模板
---@class UIAuctionFiltrateList
local UIAuctionFiltrateList = {}
--region 局部变量
---按钮-->对应的表数据
UIAuctionFiltrateList.filtrateBtnAndNumList = {}
---筛选条件集合
UIAuctionFiltrateList.filtrateConditionList = {}
---Id-->Btn
UIAuctionFiltrateList.filtrateIdAndBtn = {}
---二级Id-->一级id
UIAuctionFiltrateList.filtrateSecondIdToFirstId = {}
---所有的一级页签
UIAuctionFiltrateList.allFirstBtnTable = {}
---一级二级页签总高(最大按钮数量*按钮高度)
UIAuctionFiltrateList.firstTotalHight = 10 * 58
---二级按钮高度
UIAuctionFiltrateList.sencondBtnHight = 46
---等级职业性别筛选数据
UIAuctionFiltrateList.LevelAndCareerAndSexMsgList = {}
---点击按钮回调
UIAuctionFiltrateList.FilterBtnClickCallBack = nil
---点击按钮回调参数
UIAuctionFiltrateList.FilterBtnClickParams = nil
---职业偏向
UIAuctionFiltrateList.CareerPropertyTendency = -1

---@type UIToggle 当前选中二级Toggle
UIAuctionFiltrateList.mCurrentSecondToggle = nil

---@type UIButton 当前选中一级按钮
UIAuctionFiltrateList.mCurrentFirstButton = nil

---@type UIButton 当前选中二级按钮
UIAuctionFiltrateList.mCurrentSecondButton = nil

---一级菜单按钮对应的index(用于计算当前按钮位置)
---@type table
UIAuctionFiltrateList.mFirstMenuBtnToIndex = nil

---一级菜单id对应的index(用于计算当前按钮位置)
---@type table
UIAuctionFiltrateList.mFirstMenuTableIdToIndex = nil
--endregion

--region 一级页签数据 装备/宝物

---默认选中一级页签的时候打开二级页签
---再次点击一级页签关闭二级页签选中
UIAuctionFiltrateList.mIsShowSecondMenu = false

---@type XLua.Cast.Int32 一级目录id
UIAuctionFiltrateList.mCurrentChooseFirstId = nil
--endregion

--region 二级页签数据
---当前选中二级页签id
UIAuctionFiltrateList.mCurrentChooseSecondId = nil
--endregion

--region 用于通过id打开面板时候调用数据
---一级目录id对应二级目录刷新数据
UIAuctionFiltrateList.mFirstIdToSecondMenuData = {}

---二级目录id对应一级目录id
UIAuctionFiltrateList.mSecondIdToFirstId = {}
--endregion

--region 初始化
function UIAuctionFiltrateList:Init(panel)
    self.RootPanel = panel
    self:InitParams()
    self:InitComponent()
    self:InitAllToggle()
end

function UIAuctionFiltrateList:InitComponent()
    ---@type UIGridContainer
    self.allToggleGridContainer_UIGridContainer = self:Get("ToggleView/ToggleBtn/AllToggleGridContainer", "UIGridContainer")
    self.toggleViewSpring = self:Get("ToggleView", "Top_SpringPanel")
    ---@type  UIScrollView
    self.toggleView_ScrollView = self:Get("ToggleView", "UIScrollView")
    self.firstBtn_UISprite = self:Get("ToggleView/ToggleBtn/DropDown/backgroud", "UISprite")
end

function UIAuctionFiltrateList:InitParams()
    self:ResetLevelAndCareerAndSexMsgList()
    self:InitData()
end

function UIAuctionFiltrateList:InitData()
    self.filtrateConditionList = {}

    table.insert(self.filtrateConditionList, 0)
    self.tableDictionary = CS.Cfg_Item_TradeTypeManager.Instance.dic
    self.firstOrderTableArray = {}
    self.filtrateIdAndBtn = {}
    self.filtrateSecondIdToFirstId = {}
    self.allFirstBtnTable = {}
    self.firstOrderTableArray[1] = { id = 0; name = "全部"; type = 1; }
    CS.Cfg_Item_TradeTypeManager.Instance:Foreach(function(id, tbl)
        if tbl.type == 1 then
            table.insert(self.firstOrderTableArray, tbl)
            --print("id="..id);
        end
    end)
    --for k, v in pairs(self.tableDictionary) do
    --    if v.type == 1 then
    --        table.insert(self.firstOrderTableArray, v)
    --    end
    --end
end
--endregion

--region 页签
--region 左侧页签初始化
--region 初始化一级页签
---初始化左侧列表(1级和2级)
function UIAuctionFiltrateList:InitAllToggle()
    self.mFirstIdToSecondMenuData = {}
    self.mSecondIdToFirstId = {}

    self.mFirstMenuBtnToIndex = {}
    self.mFirstMenuTableIdToIndex = {}
    self.SecondIdToFirstData = {}
    self.allToggleGridContainer_UIGridContainer.MaxCount = #self.firstOrderTableArray
    self.filtrateIdAndBtn[0] = self.allToggleGridContainer_UIGridContainer.controlList[0]
    for i = 0, self.allToggleGridContainer_UIGridContainer.controlList.Count - 1 do
        local k = i
        local v = self.allToggleGridContainer_UIGridContainer.controlList[i]
        ---设置1级按钮
        local firstOrderTable = self.firstOrderTableArray[k + 1]
        local firstOrderBtn = v
        local firstClickBtn = self:GetCurComp(firstOrderBtn, "backgroud", "GameObject")
        local name_Label = self:GetCurComp(firstOrderBtn, "backgroud/backgroud/Label", "UILabel")
        local checkName_Label = self:GetCurComp(firstOrderBtn, "backgroud/checkMark/Label", "UILabel")
        local firstBtn_Toogle = self:GetCurComp(firstOrderBtn, "", "UIToggle")
        if not CS.StaticUtility.IsNull(firstBtn_Toogle) then
            firstBtn_Toogle.group = (k + 1)
        end

        --self:SetSingletonBtn(firstOrderTable, firstClickBtn, name_Label, nil, checkName_Label, 1)
        local secondBtnData = { firstOrderTable = firstOrderTable, firstOrderBtn = firstOrderBtn, firstBtn_Toogle = firstBtn_Toogle }
        self:FirstBtnOnClick(firstOrderTable, firstClickBtn, name_Label, checkName_Label, secondBtnData)
        self.mFirstIdToSecondMenuData[firstOrderTable.id] = secondBtnData
        self:SaveSecondIdData(firstOrderTable)

        self.mFirstMenuBtnToIndex[firstClickBtn] = k
        self.mFirstMenuTableIdToIndex[firstOrderTable.id] = k
        self.filtrateBtnAndNumList[firstOrderBtn] = firstOrderTable
        self.filtrateIdAndBtn[firstOrderTable.id] = firstOrderBtn
        table.insert(self.allFirstBtnTable, firstOrderBtn)
        --self:InitSecondBtn(firstOrderTable,firstOrderBtn,firstBtn_Toogle)
    end
    --self:SetScrollViewAndPoint3()
end

---存储二级页签数据
function UIAuctionFiltrateList:SaveSecondIdData(firstOrderTable)
    if firstOrderTable.subset then
        local secondIdList = firstOrderTable.subset.list
        for i = 0, secondIdList.Count - 1 do
            local secondOrderTable = self:GetMenuDataCache(secondIdList[i])
            if secondOrderTable then
                self.mSecondIdToFirstId[secondOrderTable.id] = firstOrderTable.id
            end
        end
    end
end

---获取二级目录初始化数据
function UIAuctionFiltrateList:GetSecondMenuData(secondId)
    local firstID = self.mSecondIdToFirstId[secondId]
    return self.mFirstIdToSecondMenuData[firstID]
end

---@return TABLE.CFG_ITEM_TRADETYPE 缓存目录数据
function UIAuctionFiltrateList:GetMenuDataCache(id)
    if self.mIdToMenuData == nil then
        self.mIdToMenuData = {}
    end
    local data = self.mIdToMenuData[id]
    if data == nil then
        ___, data = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(id)
        self.mIdToMenuData[id] = data
    end
    return data
end

---一级按钮点击事件
function UIAuctionFiltrateList:FirstBtnOnClick(btnTable, btn, nameLabel, checkName_Label, secondBtnParams)
    if not CS.StaticUtility.IsNull(nameLabel) then
        local color = luaEnumColorType.Gray
        nameLabel.text = color .. btnTable.name
    end
    if CS.StaticUtility.IsNull(btn) == false then
        CS.UIEventListener.Get(btn).onClick = function(btn)
            --刷新二级页签
            self:InitSecondBtn(secondBtnParams)
            self:SetScrollViewAndPoint3()
            --刷新右上方的三级以下页签
            self:SetFiltrateBtn(btnTable)
            --选中一级菜单的时候把二级菜单的选中关掉
            self.mCurrentFirstButton = btn
            self:CloseSecondMenuChoose()
            self.mCurrentSecondButton = nil
            self:SetFirstChooseBtnSprite(self.mCurrentFirstButton)

            self:SetSecondMenuShowState(btnTable.id)

            --切页处理
            self:OpenPage(btnTable.id)
        end
    end
    if CS.StaticUtility.IsNull(checkName_Label) == false then
        checkName_Label.text = btnTable.name
    end
end
--endregion

--region 初始化二级页签
---初始化二级页签
function UIAuctionFiltrateList:InitSecondBtn(secondBtnParams)
    if secondBtnParams == nil then
        return
    end

    if secondBtnParams.firstOrderTable.subset ~= nil then
        local secondBtnIdList = secondBtnParams.firstOrderTable.subset.list
        local second_UIGridContainer = self:GetCurComp(secondBtnParams.firstOrderBtn, "Scroll View/SecondLayer", "UIGridContainer")
        if secondBtnIdList.Count == 0 or (second_UIGridContainer ~= nil and second_UIGridContainer.controlList.Count > 0) then
            return
        end
        second_UIGridContainer.gameObject:SetActive(false)
        second_UIGridContainer.MaxCount = secondBtnIdList.Count
        for j = 0, second_UIGridContainer.controlList.Count - 1 do
            local k = j
            local v = second_UIGridContainer.controlList[k]
            local secondOrderTableIsFind, secondOrderTable = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(secondBtnIdList[k])
            if secondOrderTableIsFind then
                local secondOrderBtn = v
                local secondName_Label = self:GetCurComp(secondOrderBtn, "Label", "UILabel")
                local secondBtn_Toogle = self:GetCurComp(secondOrderBtn, "", "UIToggle")
                local secondCheckLabel = self:GetCurComp(secondOrderBtn, "checkMark/Label", "UILabel")
                secondBtn_Toogle.group = secondBtnParams.firstBtn_Toogle.group * 10
                self:SetSecondBtn(secondOrderTable, secondOrderBtn, secondName_Label, secondCheckLabel)
                self.filtrateBtnAndNumList[secondOrderBtn] = secondOrderTable
                self.filtrateIdAndBtn[secondOrderTable.id] = secondOrderBtn
                self.filtrateSecondIdToFirstId[secondOrderTable.id] = secondBtnParams.firstOrderTable.id
            end
        end
    end
end

---二级页签按钮点击
function UIAuctionFiltrateList:SetSecondBtn(btnTable, btn, nameLabel, checkName_Label)
    if not CS.StaticUtility.IsNull(nameLabel) then
        local color = luaEnumColorType.White
        nameLabel.text = color .. btnTable.name
    end
    if CS.StaticUtility.IsNull(btn) == false then
        CS.UIEventListener.Get(btn).onClick = function(btn)
            self:SetFiltrateBtn(btnTable)
            self.mCurrentSecondButton = btn
            self:SetFirstChooseBtnSprite(self.mCurrentFirstButton)
            self:OpenPage(btnTable.id)
        end
    end
    if CS.StaticUtility.IsNull(checkName_Label) == false then
        checkName_Label.text = btnTable.name
    end
    ---@type UIToggle
    local toggle = CS.Utility_Lua.GetComponent(btn, "UIToggle")
    if toggle then
        CS.EventDelegate.Add(toggle.onChange, function()
            if toggle.value then
                self.mCurrentSecondToggle = toggle
            end
        end)
    end
    self:SaveSecondMenuToggle(btnTable.id, toggle)
end

--endregion

---存储二级目录对应toggle
function UIAuctionFiltrateList:SaveSecondMenuToggle(id, toggle)
    ---@type table<number,UIToggle>
    if self.mSecondMenuIdToToggle == nil then
        self.mSecondMenuIdToToggle = {}
    end
    self.mSecondMenuIdToToggle[id] = toggle
end

---设置二级目录选中状态（仅仅设置显示上的选中，并没有操作实际数据）
function UIAuctionFiltrateList:SetSecondMenuToggleChoose(id, choose)
    if self.mSecondMenuIdToToggle then
        ---@type UIToggle
        local toggle = self.mSecondMenuIdToToggle[id]
        if toggle then
            toggle:Set(choose)
            if choose then
                self.mCurrentSecondToggle = toggle
            end
        end
    end
end


--region 关闭当前选中二级页签
function UIAuctionFiltrateList:CloseSecondMenuChoose()
    if self.mCurrentSecondToggle then
        self.mCurrentSecondToggle:Set(false)
        self.mCurrentSecondToggle = nil
    end
end

---设置一级菜单目录按钮选中图片
---规则：有选中二级目录 tab_type2 没有选中二级目录 tab_type3
function UIAuctionFiltrateList:SetFirstChooseBtnSprite(btn)
    if CS.StaticUtility.IsNull(btn) then
        return
    end

    ---@type table<UnityEngine.GameObject,UISprite>
    if self.mFirstButtonToSprite == nil then
        self.mFirstButtonToSprite = {}
    end
    ---@type UISprite
    local sprite = self.mFirstButtonToSprite[btn]
    if sprite == nil then
        sprite = CS.Utility_Lua.GetComponent(btn.transform:Find("checkMark"), "UISprite")
        self.mFirstButtonToSprite[btn] = sprite
    end
    if sprite then
        sprite.spriteName = ternary(self.mCurrentSecondButton == nil, "tab_type3", "tab_type2")
    end
end

--endregion

---存储条件内容
function UIAuctionFiltrateList:FilterIdAddToFilterList(item_TradeTypeId)
    if item_TradeTypeId ~= nil then
        self.filtrateConditionList = {}
        self:ResetLevelAndCareerAndSexMsgList()
        if item_TradeTypeId == 0 then
            self.firstId = 0
            table.insert(self.filtrateConditionList, self.firstId)
            self.leftConditionCount = 1
        else
            local item_TradeTypeInfoIsFind, item_TradeTypeInfo = CS.Cfg_Item_TradeTypeManager.Instance:TryGetValue(item_TradeTypeId)
            if item_TradeTypeInfoIsFind then
                --1级2级筛选数据处理
                if item_TradeTypeInfo.type == 2 then
                    self.firstId = self.filtrateSecondIdToFirstId[item_TradeTypeInfo.id]
                    self.secondId = item_TradeTypeInfo.id
                    table.insert(self.filtrateConditionList, self.firstId)
                    table.insert(self.filtrateConditionList, item_TradeTypeInfo.id)
                elseif item_TradeTypeInfo.type == 1 then
                    self.firstId = item_TradeTypeInfo.id
                    table.insert(self.filtrateConditionList, self.firstId)
                end
                self.leftConditionCount = item_TradeTypeInfo.type
            end
        end
    end
end

---重置等级职业性别列表
function UIAuctionFiltrateList:ResetLevelAndCareerAndSexMsgList()
    self.LevelAndCareerAndSexMsgList.career = -1
    self.LevelAndCareerAndSexMsgList.sex = -1
    self.LevelAndCareerAndSexMsgList.minLv = -1
    self.LevelAndCareerAndSexMsgList.maxLv = -1
    self.CareerPropertyTendency = -1
end
--endregion

---刷新右上角页签
---@param otherChoose table 三级四五级子页签选中 无先后之分
function UIAuctionFiltrateList:SetFiltrateBtn(btnTable, otherChoose)
end

--region 适配功能
---自适应方案3
function UIAuctionFiltrateList:SetScrollViewAndPoint3()
    local allLeftBtn = self.allToggleGridContainer_UIGridContainer.controlList
    local templateFirstBtn_UISprite = self:GetCurComp(allLeftBtn[0], "backgroud/backgroud", "UISprite")
    local point = nil
    for i = 0, allLeftBtn.Count - 1 do
        local btn = allLeftBtn[i]
        ---设置节点
        if point ~= nil then
            local btn_UIWidget = self:GetCurComp(btn, "", "UIWidget")
            btn_UIWidget:SetAnchor(point, 0, 0, 0, -templateFirstBtn_UISprite.localSize.y)
            point = self:GetCurComp(btn, "mathNode/mathNode", "GameObject")
        else
            point = self:GetCurComp(btn, "mathNode/mathNode", "GameObject")
        end
    end
end
--endregion

--region 对外方法
---切页（对应表内的按钮id）自动选中
---@param id number 一级页签选中
---@param second number 二级页签选中
---@param otherChoose table 三级四五级子页签选中 无先后之分 可以为空
function UIAuctionFiltrateList:OpenPage(id, second, otherChoose)
    self:SetMenuChooseData(id, second, otherChoose)
    if id == -1 then
        --id为-1 表示不请求消息只是刷新页签显示
        return
    end
    self:ReqFilterItems()
end

---设置目录选中数据（仅仅处理数据，不进行请求）
function UIAuctionFiltrateList:SetMenuChooseData(id, second, otherChoose)
    if self.mFirstMenuTableIdToIndex[id] then
        self:SuitScrollView(self.mFirstMenuTableIdToIndex[id])
    end
    self:FilterIdAddToFilterList(id)
    local btnTable = self:GetMenuDataCache(id)
    if btnTable then
        if btnTable.type == 2 then
            self.firstId = self.filtrateSecondIdToFirstId[btnTable.id]
            if self.firstId == nil then
                local secondData = self:GetSecondMenuData(btnTable.id)
                self:InitSecondBtn(secondData)
                self.firstId = self.filtrateSecondIdToFirstId[btnTable.id]
            end
            self.secondId = btnTable.id
        else
            self.firstId = btnTable.id
            self.secondId = nil
        end
        self:SetFiltrateBtn(btnTable, otherChoose)
        self:OpenLeftPage()
    elseif id == 0 then
        self.firstId = 0
        self.mIsShowSecondMenu = false
        self.mCurrentChooseFirstId = nil
        self.mCurrentChooseSecondId = nil
        self:OpenLeftPage()
        self:SetFiltrateBtn()
        self.toggleView_ScrollView:ResetPosition()
    end
    if self.FilterBtnClickCallBack ~= nil then
        self.FilterBtnClickCallBack(self.filtrateConditionList, self.FilterBtnClickParams)
    end
    self:RefreshAllFirstBtnWidget()
end

function UIAuctionFiltrateList:OpenLeftPage()
    if self.lastBtn == self.filtrateIdAndBtn[self.firstId] then
        --  return
    end
    if self.lastBtn ~= nil then
        local lastBtnList = self:GetCurComp(self.lastBtn, "Scroll View/SecondLayer", "UIGridContainer")
        local lastBtnPoint = self:GetCurComp(self.lastBtn, "mathNode/mathNode", "Transform")
        if lastBtnList ~= nil then
            self:ResetBtnState(lastBtnList)
            self:BtnChooseStateChange(false, self.lastBtn)
            lastBtnPoint.localPosition = CS.UnityEngine.Vector3.zero
        end
    end
    local btn = self.filtrateIdAndBtn[self.firstId]
    if btn ~= nil then
        local nextBtnList = self:GetCurComp(btn, "Scroll View/SecondLayer", "UIGridContainer")
        local nextBtnPoint = self:GetCurComp(btn, "mathNode/mathNode", "Transform")
        if not self.mIsShowSecondMenu then
            nextBtnList = nil
            self.toggleView_ScrollView:ResetPosition()
        end
        if nextBtnList ~= nil then
            self:BtnChooseStateChange(true, btn)
            if self.firstId ~= 0 then
                nextBtnPoint.localPosition = CS.UnityEngine.Vector3.down * (nextBtnList.MaxCount) * UIAuctionFiltrateList.sencondBtnHight
            end
            self.lastBtn = btn
        end

        --设置选中
        self:SetToggleState(true, btn)

        --设置选中图片
        local firstBtn = btn.transform:Find("backgroud").gameObject
        self.mCurrentFirstButton = firstBtn
        --设置一级目录选中前先设置二级目录选中按钮
        if self.secondId then
            local btn = self.filtrateIdAndBtn[self.secondId]
            if btn ~= nil then
                self.mCurrentSecondButton = btn
            end
        end
        --设置一级目录选中
        self:SetFirstChooseBtnSprite(firstBtn)
        if self.secondId then
            self:SetSecondMenuToggleChoose(self.secondId, true)
        end
    end
end

---刷新所有一级页签的widget
function UIAuctionFiltrateList:RefreshAllFirstBtnWidget()
    if self.allFirstBtnTable ~= nil then
        for k, v in pairs(self.allFirstBtnTable) do
            local mWidget = self:GetCurComp(v, "", "UIWidget")
            if mWidget ~= nil then
                mWidget:UpdateAnchors()
            end
        end
    end
end

function UIAuctionFiltrateList:BtnChooseStateChange(state, Btn)
    local btn_Arrow = self:GetCurComp(Btn, "backgroud/arrow", "TweenRotation")
    --local btn_Toogle = self:GetCurComp(Btn, "backgroud", "UIToggle")
    local btn_secondBtnList = self:GetCurComp(Btn, "Scroll View/SecondLayer", "GameObject")

    if btn_secondBtnList ~= nil then
        btn_secondBtnList:SetActive(state)
    end

    --if btn_Toogle ~= nil then
    --    btn_Toogle:Set(state)
    --end
    self:SetToggleState(state, Btn)

    if btn_Arrow ~= nil and state == true then
        btn_Arrow:PlayReverse()
    elseif btn_Arrow ~= nil and state == false then
        btn_Arrow:PlayForward()
    end
end

---设置状态
function UIAuctionFiltrateList:SetToggleState(state, btn)
    local toggle = self:GetCurComp(btn, "backgroud", "UIToggle")
    if not CS.StaticUtility.IsNull(toggle) then
        toggle:Set(state)
    end
end

function UIAuctionFiltrateList:ResetBtnState(btnList)
    local length = btnList.controlList.Count - 1
    for k = 0, length do
        local v = btnList.controlList[k]
        local toogle = self:GetCurComp(v, "", "UIToggle")
        ---@type TweenAlpha
        local toogle_Tween = self:GetCurComp(v, "checkMark", "TweenAlpha")
        if toogle ~= nil and toogle.value and toogle_Tween ~= nil then
            -- toogle_Tween:PlayReverse()
            toogle_Tween.duration = 0
            toogle:Set(false)
        end
    end
end

---设置按钮点击回调（没有默认回调）
function UIAuctionFiltrateList:SetFilterBtnClick(callBack, params)
    if callBack ~= nil then
        self.FilterBtnClickCallBack = callBack
    end
    if params ~= nil then
        self.FilterBtnClickParams = params
    end
end
--endregion

--region 页面布局
function UIAuctionFiltrateList:SetToggleViewSpring(moveNumber)
    self.toggleViewSpring.target = CS.UnityEngine.Vector3(0, moveNumber, 0);
    self.toggleViewSpring.enabled = true
end
--endregion

--region ScrollView适配
--region 数据
---@return UIPanel ScrollView对应Panel
function UIAuctionFiltrateList:GetPanel()
    if self.mPanel == nil and self.toggleView_ScrollView then
        self.mPanel = self.toggleView_ScrollView.panel
    end
    return self.mPanel
end

---@return number ScrollView显示高度
function UIAuctionFiltrateList:GetScrollViewHeight()
    if self.mScrollViewHeight == nil and self:GetPanel() then
        self.mScrollViewHeight = self:GetPanel():GetViewSize().y
    end
    return self.mScrollViewHeight
end

---@return number 一级菜单高度
function UIAuctionFiltrateList:GetFirstMenuHeight()
    if self.mFirstMenuHeight == nil and self.allToggleGridContainer_UIGridContainer then
        self.mFirstMenuHeight = self.allToggleGridContainer_UIGridContainer.CellHeight
    end
    return self.mFirstMenuHeight
end

---@return number 二级菜单高度
function UIAuctionFiltrateList:GetSecondMenuHeight()
    if self.mSecondMenuHeight == nil and self:GetSecondContainer() then
        self.mSecondMenuHeight = self:GetSecondContainer().CellHeight
    end
    return self.mSecondMenuHeight
end

---@return UnityEngine.GameObject 获取二级菜单Obj
function UIAuctionFiltrateList:GetSecondMenuTemplate()
    if self.mSecondMenuObj == nil and self.allToggleGridContainer_UIGridContainer then
        self.mSecondMenuObj = self.allToggleGridContainer_UIGridContainer.controlTemplate
    end
    return self.mSecondMenuObj
end

---@return UIGridContainer 二级菜单Container
function UIAuctionFiltrateList:GetSecondContainer()
    if self.mSecondContainer == nil and self:GetSecondMenuTemplate() then
        self.mSecondContainer = CS.Utility_Lua.GetComponent(self:GetSecondMenuTemplate().transform:Find("Scroll View/SecondLayer"), "UIGridContainer")
    end
    return self.mSecondContainer
end

---@return number 初始（组件位置原因导致的偏移）
function UIAuctionFiltrateList:GetCountOffSize()
    if self.mOff == nil and self:GetSecondMenuHeight() then
        local scrollViewOff = self:GetSecondMenuTemplate().transform:Find("Scroll View").gameObject.transform.localPosition.y
        local containerOff = self:GetSecondMenuTemplate().transform:Find("Scroll View/SecondLayer").gameObject.transform.localPosition.y
        self.mOff = (scrollViewOff + containerOff) + self:GetSecondMenuHeight() / 2
    end
    return self.mOff
end
--endregion

---获取当前ScrollView适配位置
---@param index number 当前选中一级菜单index
function UIAuctionFiltrateList:SuitScrollView(index)
    local firstMenuHeight = (index + 1) * self:GetFirstMenuHeight()
    local firstOrderTable = self.firstOrderTableArray[index + 1]
    if firstOrderTable and firstOrderTable.subset then
        local secondBtnIdList = firstOrderTable.subset.list
        local secondMenuNum = 0
        if secondBtnIdList then
            secondMenuNum = secondBtnIdList.Count * self:GetSecondMenuHeight()
        end
        local totalHeight = firstMenuHeight + secondMenuNum
        --超出边界
        if totalHeight - self:GetScrollViewHeight() + self:GetCountOffSize() > 0 then
            local offsetY = totalHeight - self:GetScrollViewHeight() + self:GetCountOffSize()
            local pos = CS.UnityEngine.Vector3(0, offsetY, 0)
            self.toggleView_ScrollView:Begin(pos, 100)
        else
            self.toggleView_ScrollView:ResetPosition()
        end
    end
end

--endregion

--region 网络请求相关
function UIAuctionFiltrateList:ReqFilterItems(page)
    self:NetWorkReq(page)
end

---重置数据
function UIAuctionFiltrateList:ResetAuction()
end

---向服务器请求
function UIAuctionFiltrateList:NetWorkReq(page)
end

---获取当前页信息
function UIAuctionFiltrateList:GetCurrentPageInfo(page, maxPage)
    if page and maxPage then
        self.Page = page
        self.maxPage = maxPage
    end
    self:NetWorkReq(self.Page)
end

--endregion

--region 设置页签选中
---设置二级页签选中状态
function UIAuctionFiltrateList:SetSecondMenuShowState(firstId)
    local isSameBtn = not (firstId == self.mCurrentChooseFirstId) or self.mCurrentChooseFirstId == nil
    local currentChoose = not self.mIsShowSecondMenu
    self.mIsShowSecondMenu = isSameBtn or currentChoose
    self.mCurrentChooseFirstId = firstId
end

--endregion

return UIAuctionFiltrateList