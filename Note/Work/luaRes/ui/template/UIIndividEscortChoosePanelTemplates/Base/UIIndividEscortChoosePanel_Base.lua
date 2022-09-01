local UIIndividEscortChoosePanel_Base = {}
--region 组件
---拖拽组件
function UIIndividEscortChoosePanel_Base:GetEscort_ScrollView()
    if self.mEscort_ScrollView == nil or CS.StaticUtility.IsNull(self.mEscort_ScrollView) then
        self.mEscort_ScrollView = self:Get("view/EscortList/Scroll View", "UIScrollView")
    end
    return self.mEscort_ScrollView
end

---列表组件
function UIIndividEscortChoosePanel_Base:GetEscort_UIGridContainer()
    if self.mEscort_UIGridContainer == nil or CS.StaticUtility.IsNull(self.mEscort_UIGridContainer) then
        self.mEscort_UIGridContainer = self:Get("view/EscortList/Scroll View/Escort", "UIGridContainer")
    end
    return self.mEscort_UIGridContainer
end

---滑动组件
function UIIndividEscortChoosePanel_Base:GetEscort_SpringPanel()
    if self.mEscort_SpringPanel == nil or CS.StaticUtility.IsNull(self.mEscort_SpringPanel) then
        self.mEscort_SpringPanel = self:Get("view/EscortList/Scroll View", "SpringPanel")
    end
    return self.mEscort_SpringPanel
end

---收益文本
function UIIndividEscortChoosePanel_Base:GetReward_UILabel()
    if self.mReward_UILabel == nil or CS.StaticUtility.IsNull(self.mReward_UILabel) then
        self.mReward_UILabel = self:Get("view/reward", "UILabel")
    end
    return self.mReward_UILabel
end

---收益图片
function UIIndividEscortChoosePanel_Base:GetReward_UISprite()
    if self.mReward_UISprite == nil or CS.StaticUtility.IsNull(self.mReward_UISprite) then
        self.mReward_UISprite = self:Get("view/reward/icon", "UISprite")
    end
    return self.mReward_UISprite
end

---消耗文本
function UIIndividEscortChoosePanel_Base:GetCost_UILabel()
    if self.mCost_UILabel == nil or CS.StaticUtility.IsNull(self.mCost_UILabel) then
        self.mCost_UILabel = self:Get("view/cost", "UILabel")
    end
    return self.mCost_UILabel
end

---消耗图片
function UIIndividEscortChoosePanel_Base:GetCost_UISprite()
    if self.mCost_UISprite == nil or CS.StaticUtility.IsNull(self.mCost_UISprite) then
        self.mCost_UISprite = self:Get("view/cost/icon", "UISprite")
    end
    return self.mCost_UISprite
end

---获取资源按钮
function UIIndividEscortChoosePanel_Base:GetAddBtn_GameObject()
    if self.mAddBtn_GameObject == nil or CS.StaticUtility.IsNull(self.mAddBtn_GameObject) then
        self.mAddBtn_GameObject = self:Get("view/cost/btn_add", "GameObject")
    end
    return self.mAddBtn_GameObject
end

---开始押镖按钮
function UIIndividEscortChoosePanel_Base:GetStartBtn_GameObject()
    if self.mStartBtn_GameObject == nil or CS.StaticUtility.IsNull(self.mStartBtn_GameObject) then
        self.mStartBtn_GameObject = self:Get("events/StartBtn", "GameObject")
    end
    return self.mStartBtn_GameObject
end

---获取左侧按钮
function UIIndividEscortChoosePanel_Base:GetLeftBtn_GameObject()
    if self.mLeftBtn_GameObject == nil or CS.StaticUtility.IsNull(self.mLeftBtn_GameObject) then
        self.mLeftBtn_GameObject = self:Get("view/EscortList/LeftArrow", "GameObject")
    end
    return self.mLeftBtn_GameObject
end

---获取右侧按钮
function UIIndividEscortChoosePanel_Base:GetRightBtn_GameObject()
    if self.mRightBtn_GameObject == nil or CS.StaticUtility.IsNull(self.mRightBtn_GameObject) then
        self.mRightBtn_GameObject = self:Get("view/EscortList/RightArrow", "GameObject")
    end
    return self.mRightBtn_GameObject
end
--endregion

--region 初始化
function UIIndividEscortChoosePanel_Base:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitParams()
end

function UIIndividEscortChoosePanel_Base:OnEnable()
    self:BindNetEvents()
end

function UIIndividEscortChoosePanel_Base:OnDisable()
    self.mOwnerPanel:GetLuaEventHandler():RemoveNetMsg(LuaEnumNetDef.ResCartMatterCodeMessage, self.OnResCartMatterCodeMessage)
end

function UIIndividEscortChoosePanel_Base:InitParams()
    if self:GetEscort_SpringPanel() ~= nil and self:GetEscort_UIGridContainer() ~= nil then
        self.startLocalPosition = CS.UnityEngine.Vector3(-360, -90, 0)
        self.localPositionInterval = CS.UnityEngine.Vector3.right * self:GetEscort_UIGridContainer().CellWidth
    end
end

function UIIndividEscortChoosePanel_Base:BindNetEvents()
    self.OnResCartMatterCodeMessage = function(msgId, tablData)
        if tablData.code == LuaEnumPersonCarStartDefault.LOADING then
            local second = 0
            if tablData ~= nil and tablData.time ~= nil then
                second = tablData.time * 0.001
            end
            local str = CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(223, second)
            Utility.ShowPopoTips(self:GetStartBtn_GameObject(), str, 223)
        end
    end
    self.mOwnerPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCartMatterCodeMessage, self.OnResCartMatterCodeMessage)
end

function UIIndividEscortChoosePanel_Base:BindEvents()
    if self:GetEscort_ScrollView() ~= nil then
        self:GetEscort_ScrollView().onStoppedMoving = function()
            if self.dartCarGridTemplateTable ~= nil then
                for k, v in pairs(self.dartCarGridTemplateTable) do
                    local position_x = v.go.transform.position.x
                    --if v.index == 0 then
                    --    print(v.go.transform.position)
                    --end
                    if v ~= nil and v.go ~= nil and position_x > 0.5 and position_x < 0.8 then
                        self.defaultChooseDartCar = v
                        if self.defaultChooseDartCar ~= nil then
                            self:RefreshResource(self.defaultChooseDartCar.yabiaoTable)
                        end
                    end
                end
            end
        end
    end
    if self:GetStartBtn_GameObject() ~= nil then
        CS.UIEventListener.Get(self:GetStartBtn_GameObject()).onClick = function(gameObject)
            local isCanYaBiao = self:IsCanYaBiao()
            if isCanYaBiao == false then
                Utility.ShowPopoTips(gameObject, "材料不足", 219)
            else
                if self.defaultChooseDartCar ~= nil then
                    networkRequest.ReqEscortCart(self.defaultChooseDartCar.yabiaoTable.id)
                end
                --uimanager:ClosePanel("uiindividescortpanel")
                --uimanager:ClosePanel("UIIndividEscortChoosePanel")
            end
        end
    end
    if self:GetAddBtn_GameObject() ~= nil then
        CS.UIEventListener.Get(self:GetAddBtn_GameObject()).onClick = function(gameObject)
            Utility.ShowItemGetWay(self.consumeItemid, gameObject, LuaEnumWayGetPanelArrowDirType.Down)
        end
    end

    if self:GetReward_UISprite() ~= nil then
        CS.UIEventListener.Get(self:GetReward_UISprite().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(self.rewardItemId) })
        end
    end

    if self:GetCost_UISprite() ~= nil then
        CS.UIEventListener.Get(self:GetCost_UISprite().gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = CS.Cfg_ItemsTableManager.Instance:GetItems(self.consumeItemid) })
        end
    end

    if self:GetLeftBtn_GameObject() ~= nil then
        CS.UIEventListener.Get(self:GetLeftBtn_GameObject()).onClick = function()
            local index = self.defaultChooseDartCar.index
            if index > 0 and index < self.dartCarCount then
                index = index - 1
            end
            self:ChooseDartCarByIndex(index)
        end
    end

    if self:GetRightBtn_GameObject() ~= nil then
        CS.UIEventListener.Get(self:GetRightBtn_GameObject()).onClick = function()
            local index = self.defaultChooseDartCar.index
            if index >= 0 and index < self.dartCarCount - 1 then
                index = index + 1
            end
            self:ChooseDartCarByIndex(index)
        end
    end
end
--endregion

--region 刷新
---刷新面板
function UIIndividEscortChoosePanel_Base:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshDartCarList()
    self:BindEvents()
    self:AutoChooseRecommendDartCar()
    if self.defaultChooseDartCar ~= nil then
        self:RefreshResource(self.defaultChooseDartCar.yabiaoTable)
    end
end

---解析参数
function UIIndividEscortChoosePanel_Base:AnalysisParams(commonData)
    if commonData ~= nil and commonData.dartCatType then
        self.recommendDartCarInfo = commonData.recommendDartCarInfo
        self.dartCatType = commonData.dartCatType
        self.personDartCarSourceType = commonData.personDartCarSourceType
        local mapId = CS.CSScene.MainPlayerInfo.MapID
        if self.yaBiaoTableList == nil then
            self.yaBiaoTableList = CS.Cfg_PersonDartCarTableManager.Instance:GetYaBiaoList(mapId, self.dartCatType)
        end
        return true
    end
    return false
end

---刷新镖车列表
function UIIndividEscortChoosePanel_Base:RefreshDartCarList()
    self.dartCarGridTemplateTable = {}
    if self.yaBiaoTableList ~= nil and self:GetEscort_UIGridContainer() ~= nil then
        self:GetEscort_UIGridContainer().MaxCount = self.yaBiaoTableList.Count
        self.dartCarCount = self.yaBiaoTableList.Count
        local length = self.yaBiaoTableList.Count - 1
        for k = 0, length do
            local grid = self:GetEscort_UIGridContainer().controlList[k]
            local yabiaoTable = self.yaBiaoTableList[k]
            local yaBiaoGridTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIIndividEscortChoosePanel_DartCarGrid)
            yaBiaoGridTemplate:RefreshPanel({ yabiaoTable = yabiaoTable, index = k })
            self.dartCarGridTemplateTable[grid] = yaBiaoGridTemplate
        end
    end
end

---刷新资源数据
function UIIndividEscortChoosePanel_Base:RefreshNowResource()
    if self.defaultChooseDartCar ~= nil then
        self:RefreshResource(self.defaultChooseDartCar.yabiaoTable)
    end
end

---刷新资源数据
function UIIndividEscortChoosePanel_Base:RefreshResource(yabiaoTable)
    if yabiaoTable ~= nil then
        self:AnalysisYaBiaoTable(yabiaoTable)
        if self:GetReward_UILabel() ~= nil then
            self:GetReward_UILabel().text = self.rewardCount
        end
        if self:GetReward_UISprite() ~= nil then
            self:GetReward_UISprite().spriteName = self.rewardIconName
        end
        if self:GetCost_UILabel() ~= nil then
            local bagCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.consumeItemid)
            self:GetCost_UILabel().text = CS.Utility_Lua.SetProgressLabelColor(bagCount, self.consumeCount)
        end
        if self:GetCost_UISprite() ~= nil then
            self:GetCost_UISprite().spriteName = self.consumeIconName
        end
    end
end

function UIIndividEscortChoosePanel_Base:AnalysisYaBiaoTable(yabiaoTable)
    self.yaBiaoTable = yabiaoTable
    self.rewardItemId = 0
    self.rewardIconName = ""
    self.rewardCount = ""
    self.consumeItemid = 0
    self.consumeIconName = ""
    self.consumeCount = ""
    if self.yaBiaoTable ~= nil and self.yaBiaoTable.reward and self.yaBiaoTable.reward.list.Count > 1 then
        self.rewardItemId = self.yaBiaoTable.reward.list[0]
        self.rewardIconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.rewardItemId)
        self.rewardCount = tostring(self.yaBiaoTable.reward.list[1])
    end
    if self.yaBiaoTable ~= nil and self.yaBiaoTable.consume and self.yaBiaoTable.consume.list.Count > 1 then
        self.consumeItemid = self.yaBiaoTable.consume.list[0]
        self.consumeIconName = CS.Cfg_ItemsTableManager.Instance:GetIconName(self.consumeItemid)
        self.consumeCount = tostring(self.yaBiaoTable.consume.list[1])
    end
end

---自动选择默认推荐镖车（默认选第一个）
---@param 是否延迟刷新
function UIIndividEscortChoosePanel_Base:AutoChooseRecommendDartCar()
    if self.dartCarGridTemplateTable ~= nil then
        local recommendDartCarTableInfo = CS.Cfg_PersonDartCarTableManager.Instance:GetMaxCanUseCar(self.personDartCarSourceType, self.personCarType)
        self.defaultChooseDartCar = nil
        for k, v in pairs(self.dartCarGridTemplateTable) do
            if self.defaultChooseDartCar == nil and v.index == 0 then
                self.defaultChooseDartCar = v
            end
            if recommendDartCarTableInfo ~= nil and v.yabiaoTable.id == recommendDartCarTableInfo.id then
                self.defaultChooseDartCar = v
                break
            end
        end
        if self:GetEscort_SpringPanel() ~= nil then
            self.delayRefresh = CS.CSListUpdateMgr.Add(200, nil, function()
                local index = 0
                if self.defaultChooseDartCar ~= nil then
                    index = self.defaultChooseDartCar.index
                end
                self:GetEscort_SpringPanel().target = self.startLocalPosition - index * self.localPositionInterval
                self:GetEscort_SpringPanel().enabled = true
            end)
        end
    end
end

---通过点击
function UIIndividEscortChoosePanel_Base:ChooseDartCarByIndex(index)
    for k, v in pairs(self.dartCarGridTemplateTable) do
        if v.index == index then
            self.defaultChooseDartCar = v
            break
        end
    end
    self:GetEscort_SpringPanel().target = self.startLocalPosition - self.defaultChooseDartCar.index * self.localPositionInterval
    self:GetEscort_SpringPanel().enabled = true
    self:RefreshResource(self.defaultChooseDartCar.yabiaoTable)
end
--endregion

--region UI控制
---控制显示
function UIIndividEscortChoosePanel_Base:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UIIndividEscortChoosePanel_Base:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function UIIndividEscortChoosePanel_Base:RefreshLabel(obj, text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end
--endregion

--region 查询
function UIIndividEscortChoosePanel_Base:IsCanYaBiao()
    if self.defaultChooseDartCar ~= nil and self.consumeItemid ~= nil and self.consumeCount ~= nil then
        local bagCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.consumeItemid)
        return bagCount >= tonumber(self.consumeCount)
    end
end

---通过下标获取镖车模板
function UIIndividEscortChoosePanel_Base:GetDartCarTemplateByIndex(index)
    for k, v in pairs(self.dartCarGridTemplateTable) do
        if v.index == index then
            return v
        end
    end
    return nil
end
--endregion

function UIIndividEscortChoosePanel_Base:OnDestroy()
    if self.delayRefresh ~= nil then
        if CS.CSListUpdateMgr.Instance ~= nil then
            CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        end
        self.delayRefresh = nil
    end
end
return UIIndividEscortChoosePanel_Base