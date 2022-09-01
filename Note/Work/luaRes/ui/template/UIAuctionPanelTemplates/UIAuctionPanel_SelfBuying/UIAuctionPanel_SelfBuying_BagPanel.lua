---个人求购背包界面
---@class UIAuctionPanel_SelfBuying_BagPanel:TemplateBase
local UIAuctionPanel_SelfBuying_BagPanel = {}

UIAuctionPanel_SelfBuying_BagPanel.chooseSecondMenuId = nil

---三级以前group对应选中id
UIAuctionPanel_SelfBuying_BagPanel.groupToChooseId = {}

---五级group对应选中id
UIAuctionPanel_SelfBuying_BagPanel.fifthGroupToChooseId = {}

---是否可发布
UIAuctionPanel_SelfBuying_BagPanel.canPublish = false

---职业偏向
UIAuctionPanel_SelfBuying_BagPanel.propertyTendency = -1

--region 存储数据
--region 一级菜单数据
---一级菜单数据
UIAuctionPanel_SelfBuying_BagPanel.FirstMenu = nil

---一级目录Icon名字
UIAuctionPanel_SelfBuying_BagPanel.IconName = {
    [LuaEnumAuctionMenuType.Equip] = "1",
    [LuaEnumAuctionMenuType.Treasure] = "17",
    [LuaEnumAuctionMenuType.Element] = "23",
    [LuaEnumAuctionMenuType.Signet] = "46",
    [LuaEnumAuctionMenuType.SkillBool] = "58",
    [LuaEnumAuctionMenuType.Servant] = "62",
    [LuaEnumAuctionMenuType.ReincarnationStone] = "92",
    [LuaEnumAuctionMenuType.Other] = "103",
}

---@type table<number,UIToggle> 一级目录id对应Toggle
UIAuctionPanel_SelfBuying_BagPanel.FirstIdToToggle = nil

---默认选中一级目录
UIAuctionPanel_SelfBuying_BagPanel.chooseFirstMenuId = 1

--endregion

--region 二级菜单数据
---是否展开二级菜单
UIAuctionPanel_SelfBuying_BagPanel.IsChooseSecondMenu = false

---格子对应二级菜单信息
UIAuctionPanel_SelfBuying_BagPanel.mGridToSecondMenuId = {}

---缓存二级菜单格子对应Lable组件
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuGoToLabel = {}

---缓存二级菜单格子对应选中按钮上的Lable组件
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuGoToChooseLabel = {}

---缓存二级菜单格子对应Toggle组件
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuGoToToggle = {}

---缓存二级菜单Id对应表数据
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuIdToInfo = {}

---二级目录位置
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuPos = nil

---二级目录id对应格子
---@type table<number,UnityEngine.GameObject>
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuIdToGrid = nil
--endregion

--region 三级目录信息
---缓存三级格子对应label
UIAuctionPanel_SelfBuying_BagPanel.mThirdMenuIdToInfo = {}

---格子对应三级目录信息
UIAuctionPanel_SelfBuying_BagPanel.mGridToThirdInfo = {}

---三级格子对应目录Label
UIAuctionPanel_SelfBuying_BagPanel.ThirdGridToLabel = {}

---三级目录Index对应选中
UIAuctionPanel_SelfBuying_BagPanel.IndexToArrowChoose = {}

---四级目录子节点index对应高度
UIAuctionPanel_SelfBuying_BagPanel.mContainerIndexToHeight = {}

---四级Container
UIAuctionPanel_SelfBuying_BagPanel.GridToForthContainer = {}

---四级目录节点对应箭头
UIAuctionPanel_SelfBuying_BagPanel.mContainerGoToArrow = {}

---四级目录Label
UIAuctionPanel_SelfBuying_BagPanel.mFourthGridToLabel = {}

---四级目录选择label
UIAuctionPanel_SelfBuying_BagPanel.mFourthGridToChooseLabel = {}

---四级目录显示信息（list读表）
UIAuctionPanel_SelfBuying_BagPanel.mFourthIdToLabelInfo = {}

---@type table<UnityEngine.GameObject,UIToggle>
---四级目录对应Toggle
UIAuctionPanel_SelfBuying_BagPanel.mGoToFourthToggle = {}

---四级目录格子Id
UIAuctionPanel_SelfBuying_BagPanel.mToggleGoToId = {}

---四级Toggle 对应Grope
UIAuctionPanel_SelfBuying_BagPanel.mToggleGroup = {}

---三级目录总个数
UIAuctionPanel_SelfBuying_BagPanel.mThirdMenuNum = -1

--endregion
--endregion

--region 位置适配数据
---组件间距
UIAuctionPanel_SelfBuying_BagPanel.mLineHeight = 65
---四级目录间距
UIAuctionPanel_SelfBuying_BagPanel.mForthMenuHeight = 50

---当前二级菜所占高度
UIAuctionPanel_SelfBuying_BagPanel.mSecondMenuHeight = nil
--endregion
--endregion

--region 初始化
---@param selfBuyingPanel UIAuctionPanel_SelfBuyingPanel
function UIAuctionPanel_SelfBuying_BagPanel:Init(selfBuyingPanel)
    self.SelfBuyingPanel = selfBuyingPanel
    self:InitComponent()
    self:BindEvents()
    self:RefreshFirstMenu()
    self.IsNeedChooseSecondMenu = true
    self:ChooseFirstMenu()
    self:StartGetData()
end

function UIAuctionPanel_SelfBuying_BagPanel:InitComponent()
    self.mFirstMenu_GridContainer = self:Get("TypeRoot/FirstMenu", "UIGridContainer")

    self.mSecondMenu_GridContainer = self:Get("TypeRoot/SecondMenu/Grid", "UIGridContainer")
    self.mSecondMenu_UILabel = self:Get("TypeRoot/SecondMenu/Label", "UILabel")
    self.mSecondMenuArrow_GameObject = self:Get("TypeRoot/SecondMenu/arrow", "GameObject")
    self.mSecondMenuPos = self:Get("TypeRoot/SecondMenu", "Transform")

    ---@type UIGridContainer
    ---三级目录页签
    self.mThirdMenu_GridContainer = self:Get("TypeRoot/ThirdMenu", "UIGridContainer")
    self.mThirdMenu_GameObject = self:Get("TypeRoot/ThirdMenu", "GameObject")

    self.mItemName_GridContainer = self:Get("TypeRoot/ItemName/Grid", "UIGridContainer")
    self.mItemName_GameObject = self:Get("TypeRoot/ItemName", "GameObject")
    self.mPublishButton_GameObject = self:Get("btn_publish", "GameObject")
    ---@type UISprite 出售按钮图片
    self.mPublishButton_UISprite = self:Get("btn_publish", "UISprite")
    ---@type UILabel
    self.mPublishBtn_UILabel = self:Get("btn_publish/label", "UILabel")
end

function UIAuctionPanel_SelfBuying_BagPanel:BindEvents()
    if CS.StaticUtility.IsNull(self.mPublishButton_GameObject) == false then
        CS.UIEventListener.Get(self.mPublishButton_GameObject).onClick = function(go)
            self:OnPublishClicked(go)
        end
    end
    if CS.StaticUtility.IsNull(self.mSecondMenuArrow_GameObject) == false then
        CS.UIEventListener.Get(self.mSecondMenuArrow_GameObject).onClick = function()
            self:OnFoldSecondMenuClicked()
        end
    end
end
--endregion

--region 服务器消息

function UIAuctionPanel_SelfBuying_BagPanel:SaveRemoveData(isExpire)
    self.isExpire = isExpire
end

---收到出售信息
function UIAuctionPanel_SelfBuying_BagPanel:GetSellInfoFun(msgId, tblData, csData)
    local data = {}
    if tblData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD) then
        ---@type UIAuctionBuyingReAddTemplate
        data.Template = luaComponentTemplates.UIAuctionBuyingReAddTemplate
    elseif tblData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD) then
        ---@type UIAuctionBuyingTemplate
        data.Template = luaComponentTemplates.UIAuctionBuyingTemplate
    end
    data.PriceData = csData
    uimanager:CreatePanel("UIAuctionBuyingPanel", nil, data)
end
--endregion

---点击发布
function UIAuctionPanel_SelfBuying_BagPanel:OnPublishClicked(go)
    if not self.canPublish then
        Utility.ShowPopoTips(go, nil, 225)
        return
    end
    local condition = CS.auctionV2.BuyProductsCondition()
    condition.itemId = nil
    condition.count = -1
    condition.minLevel = self.minLevel
    condition.maxLevel = self.maxLevel
    condition.currency = LuaEnumCoinType.YuanBao
    condition.sex = self.Sex
    condition.career = self.Career
    condition.screenCondition:Add(self.chooseFirstMenuId)
    condition.screenCondition:Add(self.chooseSecondMenuId)
    condition.propertyTendency = self.propertyTendency

    local table = self.menuList
    local name = self.SpecialName
    for k, v in pairs(table) do
        condition.screenCondition:Add(v)
    end
    local MarketPriceSectionType = Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD)
    local itemType = Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS)
    networkRequest.ReqBuyProductsMarketPriceSection(condition, MarketPriceSectionType, itemType, -1, name)
end

--region 一级目录
---刷新一级菜单显示
function UIAuctionPanel_SelfBuying_BagPanel:RefreshFirstMenu()
    ---@type System.Array int数组
    if self.FirstMenu == nil then
        self.FirstMenu = CS.Cfg_GlobalTableManager.Instance:GetAuctionMenu()
    end
    if self.FirstMenu then
        self.FirstIdToToggle = {}
        self.mFirstMenu_GridContainer.MaxCount = self.FirstMenu.Length
        for i = 0, self.FirstMenu.Length - 1 do
            ---@type number 一级目录id
            local firstMenuId = self.FirstMenu[i]
            local gp = self.mFirstMenu_GridContainer.controlList[i].gameObject
            ---@type UISprite 一级目录Icon
            local icon = CS.Utility_Lua.GetComponent(gp.transform, "UISprite")
            icon.spriteName = self.IconName[firstMenuId]
            local toggle = CS.Utility_Lua.GetComponent(gp, "UIToggle")
            self.FirstIdToToggle[firstMenuId] = toggle
            ---@type UILabel 一级目录名字
            local name = CS.Utility_Lua.Get(gp.transform, "Label", "UILabel")
            ---@type UISprite
            local bg = CS.Utility_Lua.Get(gp.transform, "bg", "UISprite")
            local data = self:GetTradeTableData(firstMenuId)
            if data then
                name.text = data.name
            end
            CS.EventDelegate.Add(toggle.onChange, function()
                local isChoose = toggle.value
                if isChoose then
                    self:RefreshSecondMenu(firstMenuId)
                end
                bg.gameObject:SetActive(not isChoose)
                icon.color = ternary(isChoose, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Grey)
                name.text = ternary(isChoose, data.name, "[878787]" .. data.name)
            end)
        end
    end
end

---选中一级目录
function UIAuctionPanel_SelfBuying_BagPanel:ChooseFirstMenu()
    --选中一级目录
    if self.FirstIdToToggle and self.chooseFirstMenuId then
        local toggle = self.FirstIdToToggle[self.chooseFirstMenuId]
        if toggle then
            toggle:Set(true)
        end
    end
end
--endregion

--region二级目录
---选中二级目录第一个
function UIAuctionPanel_SelfBuying_BagPanel:ChooseSecondMenu()
    local secondMenuInfo = self:GetTradeTableData(self.chooseFirstMenuId)
    if secondMenuInfo then
        local secondMenuIDList = secondMenuInfo.subset.list
        if secondMenuIDList and self.mSecondMenuIdToGrid then
            local go = self.mSecondMenuIdToGrid[secondMenuIDList[0]]
            if go then
                local toggle = self.mSecondMenuGoToToggle[go]
                if toggle then
                    toggle:Set(true)
                end
            end
        end
    end
end

---折叠按钮点击
function UIAuctionPanel_SelfBuying_BagPanel:OnFoldSecondMenuClicked()
    self.IsChooseSecondMenu = not self.IsChooseSecondMenu
    self:SetSecondMenuArrow()
    self:RefreshSecondMenu(self.chooseFirstMenuId)
    self:SuitPanel()
end

---设置二级目录箭头旋转
function UIAuctionPanel_SelfBuying_BagPanel:SetSecondMenuArrow()
    local rotation = CS.UnityEngine.Vector3(0, 0, ternary(self.IsChooseSecondMenu, 0, 180))
    self.mSecondMenuArrow_GameObject.transform.localEulerAngles = rotation
end

---刷新二级菜单
---@param id XLua.Cast.Int32 一级菜单对应ID
function UIAuctionPanel_SelfBuying_BagPanel:RefreshSecondMenu(id)
    if id == nil then
        return
    end
    ---换一级页签的时候才重置二级页签选中
    if id ~= self.chooseFirstMenuId then
        self.chooseSecondMenuId = nil
        self:ShowThirdMenu(false)
        self.mThirdMenuNum = 0
        self.IsChooseSecondMenu = false
        self:SetSecondMenuArrow()
    end
    ---存储一级选中目录id
    self.chooseFirstMenuId = id
    local data = self:GetTradeTableData(id)
    if data then
        ---每次刷新二级菜单重置数据
        self.mGridToSecondMenuId = {}
        self.IndexToArrowChoose = {}
        self.mSecondMenuIdToGrid = {}
        local idList = data.subset.list
        self.mSecondMenu_UILabel.text = data.name
        local num = ternary(idList.Count >= 3, 3, idList.Count)
        local gridNum = ternary(self.IsChooseSecondMenu, idList.Count, num)
        self:ShowSecondMenuArrow(idList.Count > 3)
        self.mSecondMenu_GridContainer.MaxCount = gridNum
        self.mSecondMenuHeight = math.ceil(gridNum / 3) * self.mLineHeight
        ---刷新列表
        for i = 0, self.mSecondMenu_GridContainer.controlList.Count - 1 do
            ---存储数据
            local gp = self.mSecondMenu_GridContainer.controlList[i]
            self.mGridToSecondMenuId[gp] = idList[i]
            self.mSecondMenuIdToGrid[idList[i]] = gp
            self:RefreshSecondMenuEvent(gp)
            self:RefreshSecondMenuInfo(idList[i])
            self:RefreshSecondMenuLabel(gp, idList[i])
        end
    end
    if self.IsNeedChooseSecondMenu then
        ---只在第一次选中二级目录
        self:ChooseSecondMenu()
        self.IsNeedChooseSecondMenu = false
    end
end

---刷新二级菜单箭头显示
function UIAuctionPanel_SelfBuying_BagPanel:ShowSecondMenuArrow(isShow)
    if CS.StaticUtility.IsNull(self.mSecondMenuArrow_GameObject) == false then
        self.mSecondMenuArrow_GameObject:SetActive(isShow)
    end
end

---二级菜单事件
---@param gp UnityEngine.GameObject 二级菜单格子
---@param secondId XLua.Cast.Int32 二级菜单Id
function UIAuctionPanel_SelfBuying_BagPanel:RefreshSecondMenuEvent(gp)
    ---缓存二级菜单对应Toggle组件
    if self.mSecondMenuGoToToggle[gp] == nil then
        local toggle = CS.Utility_Lua.GetComponent(gp.transform, "UIToggle")
        self.mSecondMenuGoToToggle[gp] = toggle
        CS.EventDelegate.Add(toggle.onChange, function()
            if toggle.value then
                local id = self.mGridToSecondMenuId[gp]
                self.chooseSecondMenuId = id
                self.groupToChooseId = {}
                self:RefreshThirdMenu(id)
            end
        end)
    end
    local toggle = self.mSecondMenuGoToToggle[gp]
    local id = self.mGridToSecondMenuId[gp]
    if id and toggle then
        toggle:Set(id == self.chooseSecondMenuId)
    end
end

---存储二级菜单对应数据
---@param secondId XLua.Cast.Int32 二级菜单Id
function UIAuctionPanel_SelfBuying_BagPanel:RefreshSecondMenuInfo(secondId)
    if self.mSecondMenuIdToInfo[secondId] == nil then
        local res, menuInfo = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(secondId)
        if res then
            self.mSecondMenuIdToInfo[secondId] = menuInfo
        end
    end
end

---刷新二级菜单组件对应文字
---@param go UnityEngine.GameObject 二级菜单格子
---@param secondId XLua.Cast.Int32 二级菜单Id
function UIAuctionPanel_SelfBuying_BagPanel:RefreshSecondMenuLabel(gp, secondId)
    ---刷新二级菜单文字（并缓存组件）
    local secondMenuInfo = self.mSecondMenuIdToInfo[secondId]
    if secondMenuInfo then
        --缓存组件
        if self.mSecondMenuGoToLabel[gp] == nil then
            local label = CS.Utility_Lua.GetComponent(gp.transform:Find("Label"), "UILabel")
            self.mSecondMenuGoToLabel[gp] = label
        end
        if self.mSecondMenuGoToChooseLabel[gp] == nil then
            local label = CS.Utility_Lua.GetComponent(gp.transform:Find("check/Label"), "UILabel")
            self.mSecondMenuGoToChooseLabel[gp] = label
        end
        --刷新文字
        local label = self.mSecondMenuGoToLabel[gp]
        if label then
            label.text = secondMenuInfo.name
        end
        local checkLabel = self.mSecondMenuGoToChooseLabel[gp]
        if checkLabel then
            checkLabel.text = secondMenuInfo.name
        end
    end
end
--endregion

--region 刷新三级目录
---是否显示三级页签
function UIAuctionPanel_SelfBuying_BagPanel:ShowThirdMenu(isShow)
    self.mThirdMenu_GameObject:SetActive(isShow)
    self:ShowPublishButton(false)
end

---刷新三级菜单
---@param id XLua.Cast.Int32 选中二级菜单id 武器/衣服/...
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenu(id)
    if id == nil then
        return
    end
    self.mMustChooseId = {}
    local info = self:GetTradeTableData(id)
    self:ShowThirdMenu(info and info.mustChoose)
    if info and info.mustChoose then
        ---刷新三级页签
        self.mToggleGoToId = {}
        self.mToggleGroup = {}
        self.mContainerGoToArrow = {}
        ---@type table<number,number> 表示 forthID 对应的表信息里 seekOption必须选一个才能发布
        local idList = info.mustChoose.list
        self.mThirdMenu_GridContainer.MaxCount = idList.Count
        self.mThirdMenuNum = idList.Count
        self:RefreshThirdMenuContainer(idList)
    else
        self.mThirdMenuNum = 0
    end
    self:ShowChooseItem()
    self:SuitPanel()
end

---刷新三级目录container
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenuContainer(idList)
    for i = 0, self.mThirdMenu_GridContainer.controlList.Count - 1 do
        local gp = self.mThirdMenu_GridContainer.controlList[i]
        local idInfoList = idList[i].list
        if idInfoList and idInfoList.Count >= 2 then
            ---@type number 四级目录id
            local forthID = idInfoList[0]---0是id 1是否必选（0/不是必选 1/必选）
            if idInfoList[1] == 1 then
                ---表示 forthID 对应的表信息里 seekOption必须选一个才能发布
                table.insert(self.mMustChooseId, forthID)
            end

            local forthInfo = self:GetTradeTableData(forthID)
            if forthInfo then
                --刷新四级页签
                self:RefreshThirdMenuComponent(gp, i)
                self:RefreshThirdMenuLabel(gp, forthInfo)
                self:RefreshThirdMenuArrow(gp, i)
                self:RefreshForthMenu(gp, forthInfo, i, forthID)
            end
        end
    end
end

---刷新五级目录页签（加在三级页签后）
function UIAuctionPanel_SelfBuying_BagPanel:RefreshFiveMenuContainer(idList)
    local currentThirdMenuInfo = self:GetTradeTableData(self.chooseSecondMenuId)
    if currentThirdMenuInfo then
        local currentMenuNum = currentThirdMenuInfo.mustChoose.list.Count
        if idList == nil then
            self.mThirdMenu_GridContainer.MaxCount = currentMenuNum
            return
        end
        self.mThirdMenu_GridContainer.MaxCount = currentMenuNum + idList.Count
        for i = currentMenuNum, currentMenuNum + idList.Count - 1 do
            local gp = self.mThirdMenu_GridContainer.controlList[i]
            local dataList = idList[i - currentMenuNum].list
            local fiveId
            if dataList and dataList.Count >= 2 then
                fiveId = dataList[0]
                if dataList[1] == 1 then
                    table.insert(self.mMustChooseFifthId, fiveId)
                end
            end
            local fiveInfo = self:GetTradeTableData(fiveId)
            if fiveInfo then
                self:RefreshThirdMenuComponent(gp, i)
                self:RefreshThirdMenuLabel(gp, fiveInfo)
                self:RefreshThirdMenuArrow(gp, i)
                self:RefreshForthMenu(gp, fiveInfo, i, fiveId)
            end
        end
    end
end

---缓存三级页签组件
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenuComponent(gp, i)
    if self.ThirdGridToLabel[gp] == nil then
        self.ThirdGridToLabel[gp] = CS.Utility_Lua.GetComponent(gp.transform:Find("Label"), "UILabel")
    end
    if self.mContainerGoToArrow[gp] == nil then
        self.mContainerGoToArrow[gp] = gp.transform:Find("arrow").gameObject
    end
    if self.IndexToArrowChoose[i] == nil then
        self.IndexToArrowChoose[i] = false
        self:SetThirdArrowRotation(self.mContainerGoToArrow[gp], self.IndexToArrowChoose[i])
    end
    if self.GridToForthContainer[gp] == nil then
        self.GridToForthContainer[gp] = CS.Utility_Lua.GetComponent(gp.transform:Find("Grid"), "UIGridContainer")
    end
end

---刷新三级目录名称显示
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenuLabel(gp, forthInfo)
    local label = self.ThirdGridToLabel[gp]
    if CS.StaticUtility.IsNull(label) == false then
        label.text = forthInfo.name
    end
end

---刷新三级目录箭头显示
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenuArrow(gp, i)
    local arrow = self.mContainerGoToArrow[gp]
    if CS.StaticUtility.IsNull(arrow) == false then
        CS.UIEventListener.Get(arrow).onClick = function(go)
            self:OnThirdArrowClicked(go, i)
        end
    end
end

---点击三级页签箭头
function UIAuctionPanel_SelfBuying_BagPanel:OnThirdArrowClicked(gp, i)
    self.IndexToArrowChoose[i] = not self.IndexToArrowChoose[i]
    self:SetThirdArrowRotation(gp, self.IndexToArrowChoose[i])
    self:RefreshThirdMenu(self.chooseSecondMenuId)
end

---设置三级页签旋转
function UIAuctionPanel_SelfBuying_BagPanel:SetThirdArrowRotation(gp, isChoose)
    local rotation = CS.UnityEngine.Vector3(0, 0, ternary(isChoose, 0, 180))
    gp.transform.localEulerAngles = rotation
end

---刷新四级目录
---@param gp UnityEngine.GameObject 四级目录Root
---@param info 四级目录信息
---@param i XLua.Cast.Int32 三级目录Index
function UIAuctionPanel_SelfBuying_BagPanel:RefreshForthMenu(gp, info, i, menuId)
    if info and info.seekOption then
        local container = self.GridToForthContainer[gp]
        if CS.StaticUtility.IsNull(container) == false then
            local forthInfo = info.seekOption
            local num = ternary(forthInfo.list.Count > 3, 3, forthInfo.list.Count)
            local showNum = ternary(self.IndexToArrowChoose[i], forthInfo.list.Count, num)
            self:RefreshThirdMenuArrowShow(gp, forthInfo.list.Count > 3)
            container.MaxCount = showNum
            local height = math.ceil(showNum / 3) * self.mForthMenuHeight * -1
            local lastHeight = self.mContainerIndexToHeight[i - 1]
            local addHeight = ternary(lastHeight == nil, 0, lastHeight)
            self.mContainerIndexToHeight[i] = height + addHeight
            gp.transform.localPosition = CS.UnityEngine.Vector3(0, addHeight, 0)
            for j = 0, container.controlList.Count - 1 do
                local id = forthInfo.list[j]
                local gp = container.controlList[j]
                self:RefreshFourthMenuLabel(gp, id, i, menuId)
            end
            local chooseId = self.groupToChooseId[menuId]
            self:RefreshFiveMenuById(chooseId)
        end
    end
end

function UIAuctionPanel_SelfBuying_BagPanel:RefreshFourthMenuPos(pos)

end

---刷新三级目录箭头显示
function UIAuctionPanel_SelfBuying_BagPanel:RefreshThirdMenuArrowShow(gp, isShow)
    local arrow = self.mContainerGoToArrow[gp]
    if CS.StaticUtility.IsNull(arrow) == false then
        arrow:SetActive(isShow)
    end
end

---刷新四级页签显示
function UIAuctionPanel_SelfBuying_BagPanel:RefreshFourthMenuLabel(gp, id, i, menuId)
    ---缓存数据
    if self.mFourthIdToLabelInfo[id] == nil then
        local res, info = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(id)
        if res then
            self.mFourthIdToLabelInfo[id] = info
        end
    end
    local info = self.mFourthIdToLabelInfo[id]
    if info then
        ---缓存组件
        if self.mFourthGridToLabel[gp] == nil then
            self.mFourthGridToLabel[gp] = CS.Utility_Lua.GetComponent(gp.transform:Find("Label"), "UILabel")
        end
        if self.mFourthGridToChooseLabel[gp] == nil then
            self.mFourthGridToChooseLabel[gp] = CS.Utility_Lua.GetComponent(gp.transform:Find("check/Label"), "UILabel")
        end
        ---刷新
        local label = self.mFourthGridToLabel[gp]
        local chooseLabel = self.mFourthGridToChooseLabel[gp]
        if CS.StaticUtility.IsNull(label) == false then
            label.text = info.name
        end
        if CS.StaticUtility.IsNull(chooseLabel) == false then
            chooseLabel.text = info.name
        end

        if self.mGoToFourthToggle[gp] == nil then
            local toggle = CS.Utility_Lua.GetComponent(gp.transform, "UIToggle")
            if toggle then
                self.mGoToFourthToggle[gp] = toggle
                CS.EventDelegate.Add(toggle.onChange, function()
                    if toggle.value then
                        self:OnThirdMenuClicked(gp)
                    end
                end)
            end
        end
        --存储数据
        self.mToggleGoToId[gp] = id
        self.mToggleGroup[gp] = menuId
        --设置上次选中
        local chooseId = self.groupToChooseId[menuId]
        local toggle = self.mGoToFourthToggle[gp]
        if toggle then
            toggle.group = i + 3
            toggle:Set(id == chooseId, true)
        end
    end
end

---三级菜单点击事件
function UIAuctionPanel_SelfBuying_BagPanel:OnThirdMenuClicked(gp)
    local id = self.mToggleGoToId[gp]
    local info = self:GetTradeTableData(id)
    if info then
        if info.type == 4 then
            local group = self.mToggleGroup[gp]
            if group then
                self.groupToChooseId[group] = id
            end
        elseif info.type == 6 then
            local group = self.mToggleGroup[gp]
            if group then
                self.fifthGroupToChooseId[group] = id
            end
        end
    end
    self:RefreshFiveMenuById(id)
    -- self:SpecialShowPublishButton()
    self:ShowChooseItem()
end

---通过当前选中id刷新五级目录
function UIAuctionPanel_SelfBuying_BagPanel:RefreshFiveMenuById(id)
    local info = self:GetTradeTableData(id)
    if info and info.type == 4 then
        self.mMustChooseFifthId = {}
        self.fifthGroupToChooseId = {}
        if info.mustChoose then
            self:RefreshFiveMenuContainer(info.mustChoose.list)
        else
            self:RefreshFiveMenuContainer(nil)
        end
    end
end

--endregion

---适配界面
function UIAuctionPanel_SelfBuying_BagPanel:SuitPanel()
    --二级菜单当前高度
    if self.mSecondMenuHeight then
        local thirdMenuPosY = self.mSecondMenuPos.localPosition.y - self.mSecondMenuHeight
        local thirdMenuLocalPos = self.mSecondMenuPos.localPosition
        thirdMenuLocalPos.y = thirdMenuPosY
        self.mThirdMenu_GameObject.transform.localPosition = thirdMenuLocalPos
    end
end

--region 显示可选择道具
---获取可选择道具
function UIAuctionPanel_SelfBuying_BagPanel:ShowChooseItem()
    self:ClearLevelCareerInfo()
    if self.chooseFirstMenuId == nil or self.chooseSecondMenuId == nil then
        self:ShowPublishButton(false)
        --self:RefreshItemNameContainer()
        return
    end
    local menuName = self.chooseFirstMenuId .. "#" .. self.chooseSecondMenuId
    local info1 = -1
    local info2 = -1
    local info3 = -1
    local count = 0

    self.menuList = {}
    local otherInfo = {}
    ---该组对应选中
    local groupToChoose = {}
    for k, v in pairs(self.groupToChooseId) do
        count = count + 1
        local info = CS.Cfg_Item_TradeTypeManager.Instance:GetTradDicInfo(v)
        if info then
            ---有参数表示有职业偏向之类的
            if info1 == -1 then
                info1 = v
            elseif info2 == -1 then
                info2 = v
            elseif info3 == -1 then
                info3 = v
            end
            table.insert(otherInfo, info)
        else
            table.insert(self.menuList, v)
        end
        groupToChoose[k] = true
    end
    --判断必选是否选完
    for i = 1, #self.mMustChooseId do
        local id = self.mMustChooseId[i]
        local isChoose = groupToChoose[id]
        if isChoose == nil then
            self:ShowPublishButton(false)
            return
        end
    end
    local fifthGroupToChoose = {}
    for k, v in pairs(self.fifthGroupToChooseId) do
        fifthGroupToChoose[k] = true
    end

    --判断五级目录是否选完
    if self.mMustChooseFifthId then
        for i = 1, #self.mMustChooseFifthId do
            local id = self.mMustChooseFifthId[i]
            local isChoose = fifthGroupToChoose[id]
            if isChoose == nil then
                self:ShowPublishButton(false)
                return
            end
        end
    end

    self.SpecialName = self:GetSpecialName()
    self:ShowPublishButton(true)
    self:GetLevelCareerInfo(otherInfo)
end

function UIAuctionPanel_SelfBuying_BagPanel:ClearLevelCareerInfo()
    self.minLevel = -1
    self.maxLevel = -1
    self.Sex = -1
    self.Career = -1
    self.SpecialName = ""
    self.propertyTendency = -1
end

---获取职业等级等特殊信息
function UIAuctionPanel_SelfBuying_BagPanel:GetLevelCareerInfo(info)
    for i = 1, #info do
        local str = string.Split(info[i], '&')
        if #str >= 2 then
            local id = tonumber(str[1])
            if id then
                if id == 1 then
                    local levelInfo = string.Split(str[2], '#')
                    if #levelInfo >= 2 then
                        self.minLevel = tonumber(levelInfo[1])
                        self.maxLevel = tonumber(levelInfo[2])
                    end
                elseif id == 2 then
                    local levelInfo = string.Split(str[2], '#')
                    if #levelInfo >= 2 then
                        self.minLevel = tonumber(levelInfo[1]) * 1000
                        self.maxLevel = tonumber(levelInfo[2]) * 1000
                    end
                elseif id == 3 then
                    self.Sex = tonumber(str[2])
                elseif id == 4 then
                    self.Career = tonumber(str[2])
                elseif id == 5 then
                    self.propertyTendency = tonumber(str[2])
                end
            end
        end
    end
end

---获取名字显示
function UIAuctionPanel_SelfBuying_BagPanel:GetSpecialName()
    local nameTable = {}
    self:AddName(nameTable, self.chooseFirstMenuId)
    self:AddName(nameTable, self.chooseSecondMenuId)
    for k, v in pairs(self.groupToChooseId) do
        self:AddName(nameTable, v)
    end
    for k1, v1 in pairs(self.fifthGroupToChooseId) do
        self:AddName(nameTable, v1)
    end
    table.sort(nameTable, function(l, r)
        if (l.order < r.order) then
            return true
        else
            return false
        end
    end)
    local str = ""
    for i = 1, #nameTable do
        str = str .. nameTable[i].name
        if i < #nameTable then
            str = str .. " "
        end
    end
    return str
end

function UIAuctionPanel_SelfBuying_BagPanel:AddName(nameTable, chooseID)
    local nameInfo = self:GetTradeTableData(chooseID)
    if nameInfo and nameInfo.order and nameInfo.order ~= 0 then
        local data = {}
        data.name = nameInfo.name
        data.order = nameInfo.order
        table.insert(nameTable, data)
    end
end


--endregion

--endregion

--region 处理Item表数据
---获取数据
function UIAuctionPanel_SelfBuying_BagPanel:StartGetData()
    CS.Cfg_ItemsTableManager.Instance:StartGetAuctionData()
end
--endregion

---设置发布按钮显示
function UIAuctionPanel_SelfBuying_BagPanel:ShowPublishButton(isShow)
    self.canPublish = isShow
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Gray)
    self.mPublishButton_UISprite.color = color
    local labelColor = ternary(isShow, luaEnumColorType.Red3, luaEnumColorType.Gray)
    self.mPublishBtn_UILabel.text = labelColor .. "发布"
end

---@return TABLE.CFG_ITEM_TRADETYPE 交易行目录缓存表数据
function UIAuctionPanel_SelfBuying_BagPanel:GetTradeTableData(id)
    if self.mIdToData == nil then
        self.mIdToData = {}
    end
    local data = self.mIdToData[id]
    if data == nil then
        ___, data = CS.Cfg_Item_TradeTypeManager.Instance.dic:TryGetValue(id)
    end
    return data
end

--region 上一版特殊名字废弃

--[[
---判断特殊条件
function UIAuctionPanel_SelfBuying_BagPanel:SpecialShowPublishButton()
    if self.chooseItemNameId == nil then
        if self.chooseFirstMenuId and self.chooseSecondMenuId then
            local specialName = self:GetSpecialMenuName()
            local isSpecialName, specialName = CS.Cfg_GlobalTableManager.Instance:IsSpecialName(specialName)
            --self:ShowPublishButton(isSpecialName)
            if CS.StaticUtility.IsNullOrEmpty(specialName) == false then
                self.SpecialName = specialName
            end
        end
    else
          self:ShowPublishButton(self.chooseItemNameId ~= nil)
    end
end

---刷新名字列表
function UIAuctionPanel_SelfBuying_BagPanel:RefreshItemNameContainer(itemList)
    self.chooseItemNameId = nil
    if itemList then
        self.mItemName_GridContainer.MaxCount = itemList.Count
        local oneItemChoose = itemList.Count == 1
        for i = 0, itemList.Count - 1 do
            local gp = self.mItemName_GridContainer.controlList[i]
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemList[i])
            if res then
                self:RefreshItemNameShow(gp, itemInfo, oneItemChoose)
            end
        end
    else
        self.mItemName_GridContainer.MaxCount = 0
    end
end


---获取特殊条件名字
function UIAuctionPanel_SelfBuying_BagPanel:GetSpecialMenuName()
    local menuName = self.chooseFirstMenuId .. "#" .. self.chooseSecondMenuId
    local menuList = {}
    for k, v in pairs(self.groupToChooseId) do
        table.insert(menuList, v)
    end
    table.sort(menuList)
    for q = 1, #menuList do
        menuName = menuName .. "#" .. menuList[q]
    end
    return menuName
end



---刷新名字显示
---@param gp UnityEngine.GameObject 名字列表格子
---@param info TABLE.CFG_ITEMS 道具信息
---@param oneItemChoose boolean 筛选后只有一个具体道具时直接选中(86413需求)
function UIAuctionPanel_SelfBuying_BagPanel:RefreshItemNameShow(gp, info, oneItemChoose)
    if gp and info then
        ---缓存数据
        if self.ItemNameGoToLabel[gp] == nil then
            self.ItemNameGoToLabel[gp] = CS.Utility_Lua.GetComponent(gp.transform:Find("Label"), "UILabel")
            local toggle = CS.Utility_Lua.GetComponent(gp.transform:Find("Background"), "UIToggle")
            self.ItemGoToToggle[gp] = toggle
            CS.EventDelegate.Add(toggle.onChange, function()
                if toggle.value then
                    self:OnItemNameChoose(gp)
                end
            end)
        end
        ---刷新
        self.ItemNameGoToItemInfo[gp] = info
        local label = self.ItemNameGoToLabel[gp]
        if CS.StaticUtility.IsNull(label) == false then
            label.text = info.name
        end
        local toggle = self.ItemGoToToggle[gp]
        if CS.StaticUtility.IsNull(toggle) == false then
            toggle:Set(info.id == self.chooseItemNameId or oneItemChoose)
            if oneItemChoose then
                self.chooseItemNameId = info.id
            end
        end
    end
end

---选中名字
function UIAuctionPanel_SelfBuying_BagPanel:OnItemNameChoose(gp)
    local info = self.ItemNameGoToItemInfo[gp]
    if info then
        self.chooseItemNameId = info.id
        --self:SpecialShowPublishButton()
    end
end

--]]
--endregion


return UIAuctionPanel_SelfBuying_BagPanel