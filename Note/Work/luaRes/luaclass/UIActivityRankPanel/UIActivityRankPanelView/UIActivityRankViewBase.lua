---@class UIActivityRankViewBase 活动排行榜详情视图基类
local UIActivityRankViewBase = {}

--region 局部变量

--endregion

--region 初始化

---@param panel UIActivityRankPanel
function UIActivityRankViewBase:Init(panel)
    ---@type UIActivityRankPanel
    self.mPanel = panel
    self:InitComponents()
    self:InitParameters()
    self:BindNetEvents()
    self:BindUIEvents()
end

---初始化变量
function UIActivityRankViewBase:InitParameters()
    self.data = {}
    self.curIndex = 0
    self.leaderboardID = 0
    self.itemTemplateDic = {}
    self.itemTemplateDicOfID = {}
    self.isInitLeft = false
    self.isInitRight = false
    --当前页签对应的功能类型
    self.curFeatureId = LuaEnumActivityRankComponentType.None
end

--- 初始化组件
function UIActivityRankViewBase:InitComponents()
    self.title = self:Get("WidgetRoot/window/title", "UILabel")
    self.myRank = self:Get("WidgetRoot/window/myRank", "UILabel")
    self.myNum = self:Get("WidgetRoot/window/myNum", "UILabel")

    self.closeBtn = self:Get("WidgetRoot/events/CloseBtn", "GameObject")

    self.leftTops = self:Get("WidgetRoot/leftPanel/background/rankTops", "Top_UIGridContainer")
    self.rightTops = self:Get("WidgetRoot/rightPanel/background/rankTops", "Top_UIGridContainer")

    ---@type Top_UIScrollView
    self.leftScrollView = self:Get("WidgetRoot/leftPanel/firstRightView/Scroll View", "Top_UIScrollView")
    ---@type Top_UIScrollView
    self.rightScrollView = self:Get("WidgetRoot/rightPanel/firstRightView/Scroll View", "Top_UIScrollView")

    self.leftRankMiddle = self:Get("WidgetRoot/leftPanel/firstRightView/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")
    self.rightRankMiddle = self:Get("WidgetRoot/rightPanel/firstRightView/Scroll View/firstRankMiddle", "UILoopScrollViewPlus")

    self.ourSideBtn_GameObject = self:Get("WidgetRoot/events/Btn/Oursidebtn", "GameObject")
    self.enemySideBtn_GameObject = self:Get("WidgetRoot/events/Btn/Enemysidebtn", "GameObject")

    self.leftPanel_GameObject = self:Get("WidgetRoot/leftPanel", "GameObject")
    self.rightPanel_GameObject = self:Get("WidgetRoot/rightPanel", "GameObject")
end

function UIActivityRankViewBase:BindUIEvents()
    CS.UIEventListener.Get(self.closeBtn).onClick = function()
        uimanager:ClosePanel('UIActivityRankPanel')
        uimanager:ClosePanel(self.go.name)
    end

    if CS.StaticUtility.IsNull(self.ourSideBtn_GameObject) == false then
        CS.UIEventListener.Get(self.ourSideBtn_GameObject).onClick = function()
            if CS.StaticUtility.IsNull(self.leftPanel_GameObject) == false and CS.StaticUtility.IsNull(self.rightPanel_GameObject) == false then
                self.leftPanel_GameObject:SetActive(true)
                self.rightPanel_GameObject:SetActive(false)
                self:ResetScrollView()
            end
        end
    end

    if CS.StaticUtility.IsNull(self.enemySideBtn_GameObject) == false then
        CS.UIEventListener.Get(self.enemySideBtn_GameObject).onClick = function()
            if CS.StaticUtility.IsNull(self.leftPanel_GameObject) == false and CS.StaticUtility.IsNull(self.rightPanel_GameObject) == false then
                self.leftPanel_GameObject:SetActive(false)
                self.rightPanel_GameObject:SetActive(true)
                self:ResetScrollView()
            end
        end
    end
end

---绑定消息监听
function UIActivityRankViewBase:BindNetEvents()

end

--endregion

--region top

---初步设置ui
---@param id number cfg_activity_leaderboard id
function UIActivityRankViewBase:SetUI(id)
    self.leaderboardID = id
    local isFind
    isFind, self.tabelInfo = CS.Cfg_activity_leaderboardTableManager.Instance.dic:TryGetValue(id)
    if not isFind then
        return
    end
    ---设置标签开关
    if CS.StaticUtility.IsNull(self.ourSideBtn_GameObject) == false then
        self.ourSideBtn_GameObject:SetActive(self:IsShowBookMark())
    end
    if CS.StaticUtility.IsNull(self.enemySideBtn_GameObject) == false then
        self.enemySideBtn_GameObject:SetActive(self:IsShowBookMark())
    end

    self.curFeatureId = self.tabelInfo.startFeature

    local des = string.Split(self.tabelInfo.des, '#')
    if #des > 0 then
        self.myRank.text = des[1]
    end

    self:SetTitle()
    self:SetTop()
    self:RefreshAllRankMiddle()
    self.myRank:UpdateAnchors()
end

function UIActivityRankViewBase:SetTop()

    local topInfoList = CS.Cfg_activity_leaderboardTableManager.Instance:GetTopInfo(self.leaderboardID)

    if topInfoList == nil and topInfoList.Count == 0 then
        return
    end
    local leftIsNull = self.leftTops == nil or CS.StaticUtility.IsNull(self.leftTops.gameObject)
    local rightIsNull = self.rightTops == nil or CS.StaticUtility.IsNull(self.rightTops.gameObject)
    if not leftIsNull then
        self.leftTops.MaxCount = topInfoList.Count
    end

    if not rightIsNull then
        self.rightTops.MaxCount = topInfoList.Count
    end
    for i = 0, topInfoList.Count - 1 do
        local topInfo = topInfoList[i]
        if not leftIsNull then
            local go = self.leftTops.controlList[i]
            self:SetTopUnit(go, topInfo, i)
        end
        if not rightIsNull then
            local go = self.rightTops.controlList[i]
            self:SetTopUnit(go, topInfo, i)
        end
    end
end

function UIActivityRankViewBase:SetTopUnit(go, topInfo, index)
    if go == nil or topInfo == nil then
        return
    end
    --region 设置显示
    local label = CS.Utility_Lua.GetComponent(go.transform:Find("Label"), "Top_UILabel")
    local icon = CS.Utility_Lua.GetComponent(go.transform:Find("Label/icon"), "Top_UISprite")
    local bg = CS.Utility_Lua.GetComponent(go.transform:Find("Sprite1"), "UISprite")
    if label then
        label.text = topInfo.str
        --self.curFeatureId == topInfo.featureType and luaEnumColorType.White .. topInfo.str or luaEnumColorType.Gray .. topInfo.str
    end
    if bg then
        bg.spriteName = self.curFeatureId == topInfo.featureType and "ActivityRank_ourside_titlebg" or "ActivityRank_ourside_titlebg1"
    end
    if icon then
        icon.spriteName = topInfo.iconName
    end
    --endregion

    --region 设置位置
    go.transform.localPosition = { x = topInfo.posX, y = 0, z = 0 }
    --endregion

    CS.UIEventListener.Get(go.gameObject).onClick = nil
    CS.UIEventListener.Get(go.gameObject).onClick = function(go)
        if topInfo.featureType == 0 then
            return
        end
        self.curFeatureId = self.curFeatureId == topInfo.featureType and self.tabelInfo.startFeature or topInfo.featureType
        self.curIndex = index == self.curIndex and 0 or index
        self:RefreshMyRankDes()
        self:OnClickTopCallBack()
    end
end

---设置title
function UIActivityRankViewBase:SetTitle()
    self.title.text = self.tabelInfo.activityTitle
end

---刷新名次
function UIActivityRankViewBase:RefreshMyRank()
    self.myNum.text = "未上榜"
end

function UIActivityRankViewBase:RefreshMyRankDes()
    local des = string.Split(self.tabelInfo.des, '#')
    if #des >= self.curIndex + 1 then
        self.myRank.text = des[self.curIndex + 1]
    end
end

--endregion

--region center

---刷新所有排行榜
function UIActivityRankViewBase:RefreshAllRankMiddle()
    self:ParseData()
    self:RefreshLeftRankMiddle()
    self:RefreshRightRankMiddle()
    self:ResetScrollView()
end

function UIActivityRankViewBase:ResetScrollView()
    if self.leftScrollView then
        self.leftScrollView:ResetPosition()
    end

    if self.rightScrollView then
        self.rightScrollView:ResetPosition()
    end
end

---刷新左侧排行榜
function UIActivityRankViewBase:RefreshLeftRankMiddle()
    if self.leftRankMiddle == nil or CS.StaticUtility.IsNull(self.leftRankMiddle.gameObject) or self.data[1] == nil then
        return
    end
    if not self.isInitLeft then
        self.isInitLeft = true
        self.leftRankMiddle:Init(function(go, line)
            return self:RankTempCallBack(go, line, 1)
        end, function(line)
            self:CheckLeftRefreshData(line)
        end)
    else
        self.leftRankMiddle:RefreshCurrentPage()
    end
end

---刷新右侧排行榜
function UIActivityRankViewBase:RefreshRightRankMiddle()
    if self.rightRankMiddle == nil or CS.StaticUtility.IsNull(self.rightRankMiddle.gameObject) or self.data[2] == nil then
        return
    end

    if not self.isInitRight then
        self.isInitRight = true
        self.rightRankMiddle:Init(function(go, line)
            return self:RankTempCallBack(go, line, 2)
        end, function(line)
            self:CheckRightRefreshData(line)
        end)
    else
        self.rightRankMiddle:RefreshCurrentPage()
    end
end

function UIActivityRankViewBase:RankTempCallBack(go, line, key)
    if go == nil or #self.data[key] < line + 1 then
        return false
    end
    ---显示50限制
    if line > 50 then
        return
    end
    local settleInfo = self.data[key][line + 1]
    if settleInfo == nil then
        return false
    end
    local template = self.itemTemplateDic[go] == nil and templatemanager.GetNewTemplate(go, luaComponentTemplates.UIActivityRankUnitTemplate) or self.itemTemplateDic[go]
    local temp = {}
    temp.Line = line + 1
    temp.settleInfo = settleInfo
    temp.leaderboardID = self.leaderboardID
    temp.curFeatureType = self.curFeatureId
    temp.isLeft = key == 1
    temp.icons = self.tabelInfo.icon
    local featureClass = luaclass[uiStaticParameter.ActivityRankPanelUnitClass[self.leaderboardID]]
    if featureClass == nil then
        featureClass = luaclass.UIActivityRankUnitFeatureBase
    end
    temp.feature = featureClass
    template:SetTemplate(temp)
    if self.itemTemplateDic[go] == nil then
        self.itemTemplateDic[go] = template
    end
    self.itemTemplateDicOfID[settleInfo.rid] = template
    return true
end

---根据id刷新单元
function UIActivityRankViewBase:RefreshTempalte(id)
    if self.itemTemplateDicOfID[id] ~= nil then
        self.itemTemplateDicOfID[id]:RefreshTemplate()
    end
end

---loopScrollview 顶部行数改变回调
function UIActivityRankViewBase:CheckLeftRefreshData(line)

end

---loopScrollview 顶部行数改变回调
function UIActivityRankViewBase:CheckRightRefreshData(line)

end

--endregion

--region otherFunction

---是否显示敌方我方标签
function UIActivityRankViewBase:IsShowBookMark()
    return true
end

---头顶top点击功能
function UIActivityRankViewBase:OnClickTopCallBack()
    self:SetTop()
    self:RefreshAllRankMiddle()
    self:RefreshMyRank()
    self.myRank:UpdateAnchors()
end

---处理数据
function UIActivityRankViewBase:ParseData()
    self.data = {}
    --拿到数据的list
    local curTbl = uiStaticParameter.UIRankManager.GetActivityRankSortedList(self.leaderboardID, self.curFeatureId)
    if curTbl ~= nil then
        self.data[1] = curTbl.main
        self.data[2] = curTbl.other
    end
end

---获取主角当前排序后的排行
function UIActivityRankViewBase:GetMainPlayerRank()
    return self:GetPlayerRank(CS.CSScene.MainPlayerInfo.ID)
end

---获取角色当前排序后的排行
function UIActivityRankViewBase:GetPlayerRank(rid)
    if self.data ~= nil and self.data[1] ~= nil then
        for k, v in pairs(self.data[1]) do
            if v.rid == rid then
                return k
            end
        end
    end
    if self.data ~= nil and self.data[2] ~= nil then
        for k, v in pairs(self.data[2]) do
            if v.rid == rid then
                return k
            end
        end
    end
    return nil
end

---移除消息监听
function UIActivityRankViewBase:RemoveNetEvents()

end

--endregion

--region ondestroy

function UIActivityRankViewBase:Clear()
    self.go = nil
    self.title = nil
    self.myRank = nil
    self.myNum = nil

    self.closeBtn = nil

    self.leftTops = nil
    self.rightTops = nil

    self.leftRankMiddle = nil
    self.rightRankMiddle = nil

    self.data = {}

    self.leaderboardID = 0
    self.isInitLeft = false
    self.isInitRight = false
    self.curFeatureId = 0
    self.itemTemplateDic = {}
    self.itemTemplateDicOfID = {}
    self:RemoveNetEvents()
end


--endregion

return UIActivityRankViewBase