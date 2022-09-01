local UIServantPracticeMapPanel = {}

--region 组件
---纹理根节点
---@return UnityEngine.GameObject
function UIServantPracticeMapPanel:GetTextureRoot_GO()
    if self.mTextureRoot == nil then
        self.mTextureRoot = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture", "GameObject")
    end
    return self.mTextureRoot
end

---仅含图片的预设
---@return UISprite
function UIServantPracticeMapPanel:GetPointOnlySprite_UISprite()
    if self.mPointOnlySprite_UISprite == nil then
        self.mPointOnlySprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/MapObjects/point", "UISprite")
    end
    return self.mPointOnlySprite_UISprite
end

---附带文字的图片UI组合预设
---@return UICombination_SpriteAndLabel
function UIServantPracticeMapPanel:GetPointWithLabel_UICombination()
    if self.mPointWithLabel_UICombination == nil then
        self.mPointWithLabel_UICombination = self:GetCurComp("WidgetRoot/view/MapPanel/MapObjects/pointWithLabel", "UICombination_SpriteAndLabel")
    end
    return self.mPointWithLabel_UICombination
end

---玩家图片
---@return UISprite
function UIServantPracticeMapPanel:GetPlayerSprite_UISprite()
    if self.mPlayerSprite_UISprite == nil then
        self.mPlayerSprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture/Points/Servant", "UISprite")
    end
    return self.mPlayerSprite_UISprite
end

---玩家特效图片
---@return UISprite
function UIServantPracticeMapPanel:GetPlayerEffectSprite_UISprite()
    if self.mPlayerEffectSprite_UISprite == nil then
        self.mPlayerEffectSprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture/Points/Servant/effect", "UISprite")
    end
    return self.mPlayerEffectSprite_UISprite
end

---地图名文字组件
function UIServantPracticeMapPanel:GetMapNameLabel_UILabel()
    if self.mMapNameLabel_UILabel == nil then
        self.mMapNameLabel_UILabel = self:GetCurComp("WidgetRoot/view/MapPanel/Root/MapName", "UILabel")
    end
    return self.mMapNameLabel_UILabel
end

---玩家坐标文字组件
function UIServantPracticeMapPanel:GetMainPlayerCoordinateLabel_UILabel()
    if self.mMainPlayerCoordinateLabel_UILabel == nil then
        self.mMainPlayerCoordinateLabel_UILabel = self:GetCurComp("WidgetRoot/view/MapPanel/Root/PlayerCoordinate", "UILabel")
    end
    return self.mMainPlayerCoordinateLabel_UILabel
end

---玩家坐标文字组件
function UIServantPracticeMapPanel:Getbtn_close()
    if self.mbtn_close == nil then
        self.mbtn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mbtn_close
end

---右侧地图按钮列表
function UIServantPracticeMapPanel:AllToggleGridContainer()
    if self.mAllToggleGridContainer == nil then
        self.mAllToggleGridContainer = self:GetCurComp("WidgetRoot/events/buttons/ToggleBtn/AllToggleGridContainer", "UIGridContainer")
    end
    return self.mAllToggleGridContainer
end
---右侧地图按钮列表Table
function UIServantPracticeMapPanel:AllToggleGridContainerTable()
    if self.mAllToggleGridContainerTable == nil then
        self.mAllToggleGridContainerTable = self:GetCurComp("WidgetRoot/events/buttons/ToggleBtn/AllToggleGridContainer", "Top_UITable")
    end
    return self.mAllToggleGridContainerTable
end

--endregion

function UIServantPracticeMapPanel:InitOther()
    CS.UIEventListener.Get(self:Getbtn_close()).onClick = self.OnClose
    local eventListener
    eventListener = CS.UIEventListener.Get(self:GetTextureRoot_GO())
    if eventListener and CS.StaticUtility.IsNull(eventListener) == false then
        eventListener.LuaEventTable = self
        eventListener.OnClickLuaDelegate = self.OnMapTextureClicked
    end
end

function UIServantPracticeMapPanel:Init()
    self:InitOther()
    self:InitializeUIMiniMap()
end

function UIServantPracticeMapPanel:InitializeUIMiniMap()
    self.InitMapTable()
    ---@type UIMiniMapController
    self.mUIMiniMapController = self:GetTextureRoot_GO():AddComponent(typeof(CS.UIMiniMapPracticeController))
    if self.mUIMiniMapController and CS.StaticUtility.IsNull(self.mUIMiniMapController) == false then
        --设置小地图控制器的各项参数
        self.mUIMiniMapController.spriteOnlyPrefab = self:GetPointOnlySprite_UISprite()
        self.mUIMiniMapController.spriteAndLabelPrefab = self:GetPointWithLabel_UICombination()
        self.mUIMiniMapController.playerPoint = self:GetPlayerSprite_UISprite()
        self.mUIMiniMapController.playerPointEffect = self:GetPlayerEffectSprite_UISprite()
        self.mUIMiniMapController.mapNameLabel = self:GetMapNameLabel_UILabel()
        self.mUIMiniMapController.mainPlayerCoordinateLabel = self:GetMainPlayerCoordinateLabel_UILabel()
        self.mUIMiniMapController.FontSizeMultiple = 1
        self.mUIMiniMapController:SwitchMap(1002)
    end
    self.mapID = 1002
    self:RefreshLeftTable()
end

function UIServantPracticeMapPanel:SetMapDataInfo(mapID)
    if self.mUIMiniMapController ~= nil then
        self.mapID = mapID
        self.mUIMiniMapController:SwitchMap(mapID)
    end
end

function UIServantPracticeMapPanel:RefreshUI()

end

function UIServantPracticeMapPanel:RefreshLeftTable(unfoldType)
    local data = self.hsMapInfoList
    self:AllToggleGridContainer().MaxCount = Utility.GetLuaTableCount(data)
    if self.TabTemplate == nil then
        self.TabTemplate = {}
    end
    local index = 0
    for i, v in pairs(data) do
        local item = self:AllToggleGridContainer().controlList[index].gameObject
        if self.TabTemplate[item] == nil then
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIServantPracticeMapPanelTemplate)
            self.TabTemplate[item] = template
        end
        self.TabTemplate[item]:RefreshUI(v, self)
        if unfoldType == v.Type then
            self.TabTemplate[item]:Unfold()
        else
            self.TabTemplate[item]:Fold()
        end
        index = index + 1
    end
    self:AllToggleGridContainerTable().IsDealy = true
    self:AllToggleGridContainerTable():Reposition()
end

---地图纹理点击事件
function UIServantPracticeMapPanel:OnMapTextureClicked(go)
    if self.mUIMiniMapController == nil and CS.StaticUtility.IsNull(self.mUIMiniMapController) == false then
        return
    end
    --点击屏幕的世界坐标
    local touchPos = CS.UICamera.currentTouch.pos;
    touchPos = self:GetTextureRoot_GO().transform:InverseTransformPoint(CS.UICamera.currentCamera:ScreenToWorldPoint(CS.UnityEngine.Vector3(touchPos.x, touchPos.y, 0)))
    local dot = self.mUIMiniMapController.CoordinateCalculator:TransLocalPosInMiniMapToSceneCoord(touchPos)
    self.mUIMiniMapController.playerDot = dot
    if uiStaticParameter.isOpenGMSend then
        networkRequest.ReqGM("@传送 " .. tostring(self.mapID) .. " " .. tostring(dot.x) .. " " .. tostring(dot.y))
    end
    networkRequest.ReqServantCultivateFly(self.mapID, dot.x, dot.y)
end

--region 点击事件
---关闭面板
function UIServantPracticeMapPanel.OnClose()
    uimanager:ClosePanel('UIServantPracticeMapPanel')
end

--endregion

--region 数据处理
function UIServantPracticeMapPanel.OnTableDataInit()

end

function UIServantPracticeMapPanel.InitMapTable()

    if UIServantPracticeMapPanel.hsMapInfoList == nil then
        local dic = CS.Cfg_HsCultivationTableManager.Instance.dic
        local hsMapTableList = {};
        if UIServantPracticeMapPanel.transList == nil then
            if dic ~= nil then
                CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
                    table.insert(hsMapTableList, v);
                end)
            end
            UIServantPracticeMapPanel.transList = hsMapTableList
        else
            hsMapTableList = UIServantPracticeMapPanel.transList
        end

        local hsInfoList = {}
        for i = 1, #hsMapTableList do
            local v = hsMapTableList[i]
            if v ~= nil then

                if UIServantPracticeMapPanel.Condition(v) then
                    if hsInfoList[v.type] == nil then
                        local nowTbleList = {}
                        table.insert(nowTbleList, v);
                        local localdata = {
                            Name = v.name,
                            Type = v.type,
                            tabList = nowTbleList,
                        }
                        hsInfoList[v.type] = localdata
                    else
                        table.insert(hsInfoList[v.type].tabList, v);
                    end
                end
            end
        end
        UIServantPracticeMapPanel.hsMapInfoList = hsInfoList
    end
end

---table TABLE.CFG_HSCULTIVATION
function UIServantPracticeMapPanel.Condition(Table)
    if Table == nil then
        return false
    end
    if Table.condition == nil then
        return true
    end
    for i = 0, Table.condition.list.Count - 1 do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(Table.condition.list[i]) then
            return false
        end
    end
    return true
end

--endregion

return UIServantPracticeMapPanel