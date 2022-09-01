---灵兽修炼地图模板(不同于之前的独立地图界面)
---@class UIServantPracticeMapTemplate:TemplateBase
local UIServantPracticeMapTemplate = {}

--region 组件
---小地图控制器
---@return UIMiniMapPracticeController
function UIServantPracticeMapTemplate:GetMiniMapController()
    if self.mMiniMapController == nil then
        self.mMiniMapController = self:InitializeMiniMap()
    end
    return self.mMiniMapController
end

---纹理根节点
---@return UnityEngine.GameObject
function UIServantPracticeMapTemplate:GetTextureRoot()
    if self.mTextureRootTex == nil then
        self.mTextureRootTex = self:Get("ScrollView/Texture", "UITexture")
    end
    return self.mTextureRootTex
end

---仅含图片的预设
---@return UISprite
function UIServantPracticeMapTemplate:GetPointOnlySprite_UISprite()
    if self.mPointOnlySprite_UISprite == nil then
        self.mPointOnlySprite_UISprite = self:Get("MapObjects/point", "UISprite")
    end
    return self.mPointOnlySprite_UISprite
end

---附带文字的图片UI组合预设
---@return UICombination_SpriteAndLabel
function UIServantPracticeMapTemplate:GetPointWithLabel_UICombination()
    if self.mPointWithLabel_UICombination == nil then
        self.mPointWithLabel_UICombination = self:Get("MapObjects/pointWithLabel", "UICombination_SpriteAndLabel")
    end
    return self.mPointWithLabel_UICombination
end

---灵兽图标
---@return UISprite
function UIServantPracticeMapTemplate:GetServantSprite_UISprite()
    if self.mServantSprite_UISprite == nil then
        self.mServantSprite_UISprite = self:Get("ScrollView/Texture/Points/Servant", "UISprite")
    end
    return self.mServantSprite_UISprite
end

---获取主下拉框
---@return Top_UIDropDown
function UIServantPracticeMapTemplate:GetMainDropDown()
    if self.mMainDropDown == nil then
        self.mMainDropDown = self:Get("Options/MainDropDown", "Top_UIDropDown")
    end
    return self.mMainDropDown
end

---获取子下拉框
---@return Top_UIDropDown
function UIServantPracticeMapTemplate:GetSubDropDown()
    if self.mSubDropDown == nil then
        self.mSubDropDown = self:Get("Options/SubDropDown", "Top_UIDropDown")
    end
    return self.mSubDropDown
end

---获取Options的UIPanel
---@return UIPanel
function UIServantPracticeMapTemplate:GetOptionsPanel()
    if self.mOptionsPanel == nil then
        self.mOptionsPanel = self:Get("Options", "UIPanel")
    end
    return self.mOptionsPanel
end

---获取ScrollView的UIPanel
---@return UIPanel
function UIServantPracticeMapTemplate:GetScrollViewPanel()
    if self.mScrollViewPanel == nil then
        self.mScrollViewPanel = self:Get("ScrollView", "UIPanel")
    end
    return self.mScrollViewPanel
end

---关闭Block
---@return UnityEngine.GameObject
function UIServantPracticeMapTemplate:GetCloseBlockGO()
    if self.mCloseBlockGO == nil then
        self.mCloseBlockGO = self:Get("Events/CloseBlock", "GameObject")
    end
    return self.mCloseBlockGO
end

---主下拉框的UIPanel
---@return UIPanel
function UIServantPracticeMapTemplate:GetMainDropDownScrollUIPanel()
    if self.mMainDropDownScrollUIPanel == nil then
        self.mMainDropDownScrollUIPanel = self:Get("Options/MainDropDown/OptionListScrollView", "UIPanel")
    end
    return self.mMainDropDownScrollUIPanel
end

---子下拉框的UIPanel
---@return UIPanel
function UIServantPracticeMapTemplate:GetSubDropDownScrollUIPanel()
    if self.mSubDropDownScrollUIPanel == nil then
        self.mSubDropDownScrollUIPanel = self:Get("Options/SubDropDown/OptionListScrollView", "UIPanel")
    end
    return self.mSubDropDownScrollUIPanel
end
--endregion

--region 数据
---获取当前显示的地图ID
---@return number
function UIServantPracticeMapTemplate:GetMapID()
    return self.mMapID or 0
end

---获取灵兽坐标
---@return SFMiscBaseDot2
function UIServantPracticeMapTemplate:GetServantCoordinate()
    if self.mServantCoordinate == nil then
        self.mServantCoordinate = {}
        self.mServantCoordinate.x = 0
        self.mServantCoordinate.y = 0
    end
    return self.mServantCoordinate
end

---获取灵兽地图ID(可能不是当前地图)
---@return number
function UIServantPracticeMapTemplate:GetServantMapID()
    if self.mServantMapID == nil then
        self.mServantMapID = 0
    end
    return self.mServantMapID
end

---获取锁定坐标
---@return SFMiscBaseDot2
function UIServantPracticeMapTemplate:GetFocusCoordiante()
    if self.mFocusCoordiante == nil then
        self.mFocusCoordiante = {}
        self.mFocusCoordiante.x = 0
        self.mFocusCoordiante.y = 0
    end
    return self.mFocusCoordiante
end
--endregion

--region 初始化
---初始化
---@param servantPracticePanel UIServantPracticePanel
function UIServantPracticeMapTemplate:Init(servantPracticePanel)
    self.mServantPracticePanel = servantPracticePanel
    self:BindUIEvents()
    self:BindDragEvents()
    self:BindServantDragEvents()
    self:InitializeDropDown()
end
--endregion

--region UI事件
---绑定UI事件
---@private
function UIServantPracticeMapTemplate:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseBlockGO()).onClick = function()
        if self.mServantPracticePanel then
            self.mServantPracticePanel.OnClickLocationBtn_add()
        end
    end
end
--endregion

--region 显隐状态
---是否正在显示中
---@return boolean
function UIServantPracticeMapTemplate:GetIsShowing()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    return self.go.activeSelf
end

---显示地图
---@public
function UIServantPracticeMapTemplate:ShowMap()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    if self.go.activeSelf == false then
        self.go:SetActive(true)
    end
end

---隐藏地图
---@public
function UIServantPracticeMapTemplate:HideMap()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    if self.go.activeSelf == true then
        self.go:SetActive(false)
    end
end

---切换地图显示状态
---@public
function UIServantPracticeMapTemplate:ToggleMapShowHideState()
    if CS.StaticUtility.IsNull(self.go) then
        return
    end
    if self.go.activeSelf then
        self.go:SetActive(false)
    else
        self.go:SetActive(true)
    end
end
--endregion

--region 显隐事件
---地图显示事件
---@private
function UIServantPracticeMapTemplate:OnEnable()
    self:RefreshDropDownDatas()
    local mapID, coord = self:GetCurrentServerPracticeInfo()
    if mapID and coord then
        self:RefreshMapAndCoordinate(mapID, mapID, coord, coord)
        self:GetMiniMapController():RefreshViewData()
        self:GetMiniMapController():RefreshMapTextureUV()
        self:GetServantSprite_UISprite().gameObject:SetActive(false)
        self:GetMainDropDownScrollUIPanel().depth = self:GetScrollViewPanel().depth + 6
        self:GetSubDropDownScrollUIPanel().depth = self:GetScrollViewPanel().depth + 6
    end
end

---地图隐藏事件
---@private
function UIServantPracticeMapTemplate:OnDisable()

end
--endregion

--region 服务器事件
---服务器坐标刷新事件
---@public
function UIServantPracticeMapTemplate:OnServerCoordinateRefreshed()
    if self:GetIsShowing() then
        local mapID, coord = self:GetCurrentServerPracticeInfo()
        if mapID and coord then
            ---仅刷新灵兽所在的地图和坐标,不动当前显示的地图和当前关注的坐标
            self:RefreshMapAndCoordinate(nil, mapID, coord, nil)
        end
    end
end

---服务器坐标设置失败
---@private
function UIServantPracticeMapTemplate:OnServerCoordSetFailed()
    if self:GetIsShowing() then
        local mapID, coord = self:GetCurrentServerPracticeInfo()
        if mapID and coord then
            ---仅刷新灵兽所在的地图和坐标,不动当前显示的地图和当前关注的坐标
            self:RefreshMapAndCoordinate(nil, mapID, coord, nil)
        end
    end
end
--endregion

--region 小地图初始化
---初始化小地图
---@private
---@return UIMiniMapPracticeController
function UIServantPracticeMapTemplate:InitializeMiniMap()
    ---@type UIMiniMapPracticeController
    local miniMapController = self:GetTextureRoot().gameObject:AddComponent(typeof(CS.UIMiniMapPracticeController))
    --设置小地图控制器的各项参数
    miniMapController.spriteOnlyPrefab = self:GetPointOnlySprite_UISprite()
    miniMapController.spriteAndLabelPrefab = self:GetPointWithLabel_UICombination()
    miniMapController.playerPoint = self:GetServantSprite_UISprite()
    miniMapController.ViewRange = self:GetTextureRoot().width
    miniMapController.RefreshTimeInterval = 0
    miniMapController.CoordinateCalculator.BorderExpandWidth = 200
    miniMapController.CoordinateCalculator.BorderExpandHeight = 200
    miniMapController:Initialize()
    return miniMapController
end
--endregion

--region 小地图刷新/数据设置
---获取当前的服务器修炼信息
---@private
---@return number|nil,{x:number,y:number}|nil
function UIServantPracticeMapTemplate:GetCurrentServerPracticeInfo()
    if self.mServantPracticePanel ~= nil and self.mServantPracticePanel.Data ~= nil
            and self.mServantPracticePanel.Data.mapId ~= nil and self.mServantPracticePanel.Data.mapId ~= 0 then
        local mapID = self.mServantPracticePanel.Data.mapId
        local coordinate = { x = self.mServantPracticePanel.Data.x, y = self.mServantPracticePanel.Data.y }
        return mapID, coordinate
    end
end

---获取当前地图的中心点坐标
---@return {x:number,y:number}|nil
function UIServantPracticeMapTemplate:GetCurrentCenterCoord()
    local calculator = self:GetMiniMapController().CoordinateCalculator
    if calculator then
        return { x = math.ceil(calculator.SceneMeshSizeX * 0.5), y = math.ceil(calculator.SceneMeshSizeY * 0.5) }
    end
end

---设置地图和坐标
---@param mapID number 地图ID
---@param servantMapID number 灵兽地图ID
---@param servantCoord SFMiscBaseDot2 灵兽坐标
---@param focusCoord SFMiscBaseDot2 当前焦点坐标
function UIServantPracticeMapTemplate:RefreshMapAndCoordinate(mapID, servantMapID, servantCoord, focusCoord)
    --配置灵兽所在的地图ID
    if servantMapID ~= nil then
        self.mServantMapID = servantMapID
        self:GetMiniMapController().playerMapID = self:GetServantMapID()
    end
    --配置mapID
    if mapID ~= nil and self.mMapID ~= mapID then
        self.mMapID = mapID
        self:GetMiniMapController():SwitchMap(mapID)
        self:SetCurrentSelectedMapID(mapID)
    end
    --配置灵兽坐标
    if servantCoord ~= nil then
        if self:GetServantCoordinate().x ~= servantCoord.x then
            self:GetServantCoordinate().x = servantCoord.x
        end
        if self:GetServantCoordinate().y ~= servantCoord.y then
            self:GetServantCoordinate().y = servantCoord.y
        end
        self:GetMiniMapController().playerDot = self:GetServantCoordinate()
    end
    --配置focus坐标
    if focusCoord then
        if self:GetFocusCoordiante().x ~= focusCoord.x then
            self:GetFocusCoordiante().x = focusCoord.x
        end
        if self:GetFocusCoordiante().y ~= focusCoord.y then
            self:GetFocusCoordiante().y = focusCoord.y
        end
        self:GetMiniMapController().focusDot = focusCoord
    end
end

---设置灵兽坐标
---@param servantMapID number
---@param servantCoord SFMiscBaseDot2
function UIServantPracticeMapTemplate:SetServantMapIDAndCoordinate(servantMapID, servantCoord)
    self:RefreshMapAndCoordinate(nil, servantMapID, servantCoord, nil)
end

---设置锁定坐标
---@param focusCoord SFMiscBaseDot2
function UIServantPracticeMapTemplate:SerFocusCoordinate(focusCoord)
    self:RefreshMapAndCoordinate(nil, nil, nil, focusCoord)
end

---设置当前显示的地图ID
---@param mapID number
function UIServantPracticeMapTemplate:SetMapID(mapID)
    self:RefreshMapAndCoordinate(mapID, nil, nil, nil)
end
--endregion

--region 小地图UI事件
---绑定拖拽事件
---@private
function UIServantPracticeMapTemplate:BindDragEvents()
    ---@type UIEventListener
    local uiEventlistener = CS.UIEventListener.Get(self:GetTextureRoot().gameObject)
    uiEventlistener.onDragStart = function(go)
        self:OnTextureDragStarted(go)
    end
    uiEventlistener.onDrag = function(go, delta)
        self:OnTextureDragged(go, delta)
    end
    uiEventlistener.onDragEnd = function(go)
        self:OnTextureDragEnded(go)
    end
    uiEventlistener.onClick = function(go)
        self:OnTextureClicked(go)
    end
end

---纹理拖拽开始事件
---@private
---@param go UnityEngine.GameObject
function UIServantPracticeMapTemplate:OnTextureDragStarted(go)
    local coordinateCalculator = self:GetMiniMapController().CoordinateCalculator
    ---记录拖拽开始时视野中心相对于地图中心的相对坐标
    self.mTextureStartDragPos = coordinateCalculator:TransLocalPosInViewToLocalPosInMiniMap(0, 0)
end

---纹理拖拽事件
---@private
---@param go UnityEngine.GameObject
---@param delta UnityEngine.Vector2
function UIServantPracticeMapTemplate:OnTextureDragged(go, delta)
    if self.mTextureStartDragPos == nil then
        return
    end
    local coordinateCalculator = self:GetMiniMapController().CoordinateCalculator
    self.mTextureStartDragPos.x = self.mTextureStartDragPos.x - delta.x
    self.mTextureStartDragPos.y = self.mTextureStartDragPos.y - delta.y
    ---相对坐标上加上delta值
    local coord = coordinateCalculator:TransLocalPosInMiniMapToSceneCoord(self.mTextureStartDragPos)
    ---设置锁定坐标
    self:SerFocusCoordinate(coord)
end

---纹理结束拖拽事件
---@private
---@param go UnityEngine.GameObject
function UIServantPracticeMapTemplate:OnTextureDragEnded(go)
    self.mTextureStartDragPos = nil
end

---纹理点击事件
---@private
---@param go UnityEngine.GameObject
function UIServantPracticeMapTemplate:OnTextureClicked(go)
    local coordinateCalculator = self:GetMiniMapController().CoordinateCalculator
    --点击屏幕的世界坐标
    local touchPos = CS.UICamera.currentTouch.pos;
    touchPos = go.transform:InverseTransformPoint(CS.UICamera.currentCamera:ScreenToWorldPoint(CS.UnityEngine.Vector3(touchPos.x, touchPos.y, 0)))
    local localPos = coordinateCalculator:TransLocalPosInViewToLocalPosInMiniMap(touchPos.x, touchPos.y)
    local coord = coordinateCalculator:TransLocalPosInMiniMapToSceneCoord(localPos)
    self:SetServantMapIDAndCoordinate(self:GetServantMapID(), coord)
    self:RequestServantPractice()
end
--endregion

--region 小地图灵兽图标拖拽事件
---绑定灵兽图标拖拽事件
---@private
function UIServantPracticeMapTemplate:BindServantDragEvents()
    local uiEventListener = CS.UIEventListener.Get(self:GetServantSprite_UISprite().gameObject)
    uiEventListener.onDragStart = function(go)
        self:OnServantIconDragStarted(go)
    end
    uiEventListener.onDrag = function(go, delta)
        self:OnServantIconDragged(go, delta)
    end
    uiEventListener.onDragEnd = function(go)
        self:OnServantIconDragEnded(go)
    end
end

---灵兽图标拖拽开始事件
---@private
---@param go UnityEngine.GameObject
function UIServantPracticeMapTemplate:OnServantIconDragStarted(go)
    self.mServantDragPos = {}
    self.mServantDragPos = { x = go.transform.localPosition.x, y = go.transform.localPosition.y }
end

---灵兽图标拖拽中事件
---@private
---@param go UnityEngine.GameObject
---@param delta UnityEngine.Vector2
function UIServantPracticeMapTemplate:OnServantIconDragged(go, delta)
    if self.mServantDragPos == nil then
        return
    end
    local coordinateCalculator = self:GetMiniMapController().CoordinateCalculator
    self.mServantDragPos.x = self.mServantDragPos.x + delta.x
    self.mServantDragPos.y = self.mServantDragPos.y + delta.y
    local localPos = coordinateCalculator:TransLocalPosInViewToLocalPosInMiniMap(self.mServantDragPos.x, self.mServantDragPos.y)
    local coord = coordinateCalculator:TransLocalPosInMiniMapToSceneCoord(localPos)
    self:SetServantMapIDAndCoordinate(nil, coord)
end

---灵兽图标拖拽结束事件
---@private
---@param go UnityEngine.GameObject
function UIServantPracticeMapTemplate:OnServantIconDragEnded(go)
    self:RequestServantPractice()
end
--endregion

--region 发送服务器消息
---请求设置灵兽修炼坐标
---@private
function UIServantPracticeMapTemplate:RequestServantPractice()
    if self:GetMapID() == nil or self:GetMapID() == 0 then
        return
    end
    if self:GetServantCoordinate() == nil then
        return
    end
    networkRequest.ReqServantCultivateFly(self:GetMapID(), self:GetServantCoordinate().x, self:GetServantCoordinate().y)
end
--endregion

--region 修炼地图数据
---单个修炼地图
---@alias SinglePracticeMap {tbl:TABLE.CFG_HSCULTIVATION,isConditionConfirm:boolean}
---@alias PracticeMaps {name:string,isAnyAvailableMap:boolean,type:number,maps:table<number,SinglePracticeMap>}
---获取修炼地图主地图集合
---@return table<number,PracticeMaps>
function UIServantPracticeMapTemplate:GetPracticeMaps()
    if self.mPracticeMaps == nil then
        self.mPracticeMaps = {}
    end
    return self.mPracticeMaps
end
--endregion

--region 初始化下拉框
---初始化下拉框
---@private
function UIServantPracticeMapTemplate:InitializeDropDown()
    self:InitializePracticeMapData()
    self:BindServantDragEvents()
    self:RefreshDropDownDatas()
    self:BindDropDownEvents()
end

---初始化修炼地图数据
---@private
function UIServantPracticeMapTemplate:InitializePracticeMapData()
    local dic = CS.Cfg_HsCultivationTableManager.Instance.dic
    if dic then
        local maps = self:GetPracticeMaps()
        CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
            ---@type TABLE.CFG_HSCULTIVATION
            local tbl = v
            local tblType = tbl.type
            local data = nil
            for i = 1, #maps do
                if maps[i].type == tblType then
                    data = maps[i]
                    break
                end
            end

            if data == nil then
                data = {}
                data.name = tbl.name
                data.isAnyAvailableMap = false
                data.type = tblType
                data.maps = {}
                table.insert(maps, data)
            end
            for i = 1, #data.maps do
                if data.maps[i].tbl.id == tbl.id then
                    return
                end
            end
            table.insert(data.maps, { tbl = tbl, isConditionConfirm = false })
        end)
        ---按type从小到大排序
        table.sort(maps, function(left, right)
            return left.type < right.type
        end)
        ---单个type按ID从小到大排序
        for i = 1, #maps do
            table.sort(maps[i].maps, function(left, right)
                return left.tbl.id < right.tbl.id
            end)
        end
    end
end

---绑定下拉框事件
---@private
function UIServantPracticeMapTemplate:BindDropDownEvents()
    self:GetMainDropDown():AddValueChangeEvent(function(selectedData)
        self:OnMainDropDownValueChanged(selectedData)
    end)
    self:GetSubDropDown():AddValueChangeEvent(function(selectedData)
        self:OnSubDropDownValueChanged(selectedData)
    end)
end
--endregion

--region 下拉框数据
---获取主下拉框内容
---@return string
function UIServantPracticeMapTemplate:GetMainDropDownData()
    return self.mMainDropDownData
end

---获取子下拉框内容
---@return string
function UIServantPracticeMapTemplate:GetSubDropDownData()
    return self.mSubDropDownData
end

---刷新下拉框数据
---@private
function UIServantPracticeMapTemplate:RefreshDropDownDatas()
    local maps = self:GetPracticeMaps()
    ---对于某个类型内的,进行条件判定
    local conditionTblMgr = CS.Cfg_ConditionManager.Instance
    for i = 1, #maps do
        local mapData = maps[i]
        local isAnyAvailable = false
        for j = 1, #mapData.maps do
            local singleMapData = mapData.maps[j]
            if singleMapData.tbl.condition == nil or singleMapData.tbl.condition.list.Count == 0 then
                singleMapData.isConditionConfirm = true
            else
                singleMapData.isConditionConfirm = conditionTblMgr:IsMainPlayerMatchConditionList(singleMapData.tbl.condition.list)
            end
            if singleMapData.isConditionConfirm then
                isAnyAvailable = true
            end
        end
        mapData.isAnyAvailableMap = isAnyAvailable
    end
end

---设置当前选择的地图ID
---@public
function UIServantPracticeMapTemplate:SetCurrentSelectedMapID(mapID)
    if self.mIsSettingSelectedMapID then
        return
    end
    self.mIsSettingSelectedMapID = true
    if mapID and mapID ~= 0 then
        local maps = self:GetPracticeMaps()
        local isExist = false
        for i = 1, #maps do
            for j = 1, #maps[i].maps do
                if maps[i].maps[j].isConditionConfirm and maps[i].maps[j].tbl.map == mapID then
                    isExist = true
                    self.mMainDropDownData = maps[i].name
                    self.mSubDropDownData = maps[i].maps[j].tbl.name2
                    break
                end
            end
        end
        if isExist then
            self:RefreshDropDownShowing()
        end
    end
    self.mIsSettingSelectedMapID = false
end
--endregion

--region 下拉框事件
---主下拉框选项变化事件
---@alias DropdownData {Label:string,SpriteName:string,ExtraData:string,color:string,index:number}
---@param data DropdownData
function UIServantPracticeMapTemplate:OnMainDropDownValueChanged(data)
    if self.mIsRefreshingOptions then
        return
    end
    if data and data.Label and data.Label ~= "" then
        local option = data.Label
        if self.mMainDropDownData ~= option then
            self.mMainDropDownData = option
            self:RefreshCurrentSelectedMapByDoubleMapName()
        end
    end
end

---子下拉框选项变化事件
---@alias DropdownData {Label:string,SpriteName:string,ExtraData:string,color:string,index:number}
---@param data DropdownData
function UIServantPracticeMapTemplate:OnSubDropDownValueChanged(data)
    if self.mIsRefreshingOptions then
        return
    end
    if data and data.Label and data.Label ~= "" then
        local option = data.Label
        if self.mSubDropDownData ~= option then
            self.mSubDropDownData = option
            self:RefreshCurrentSelectedMapByDoubleMapName()
        end
    end
end

---根据两个地图名设置当前选中的地图
---@private
function UIServantPracticeMapTemplate:RefreshCurrentSelectedMapByDoubleMapName()
    local maps = self:GetPracticeMaps()
    local mapID = nil
    local defaultMapID = nil
    ---选择主选项
    ---刷新主options,如果没有就选择默认的
    local defaultOption
    local isCurrentExist = false
    for i = 1, #maps do
        if maps[i].isAnyAvailableMap then
            local nameTemp = maps[i].name
            if defaultOption == nil then
                defaultOption = nameTemp
            end
            if self:GetMainDropDownData() == nameTemp then
                isCurrentExist = true
                break
            end
        end
    end
    if isCurrentExist == false then
        self.mMainDropDownData = defaultOption
    end
    ---选择子选项
    local defaultSubOption
    isCurrentExist = false
    for i = 1, #maps do
        if maps[i].name == self:GetMainDropDownData() then
            ---筛选出符合条件的子选项
            for j = 1, #maps[i].maps do
                local nameTemp = maps[i].maps[j].tbl.name2
                if maps[i].maps[j].isConditionConfirm then
                    if defaultSubOption == nil then
                        defaultSubOption = nameTemp
                        defaultMapID = maps[i].maps[j].tbl.map
                    end
                    if self:GetSubDropDownData() == nameTemp then
                        isCurrentExist = true
                        mapID = maps[i].maps[j].tbl.map
                        break
                    end
                end
            end
        end
    end
    if isCurrentExist == false then
        self.mSubDropDownData = defaultSubOption
        mapID = defaultMapID
    end
    self:SetMapID(mapID)
    if self:GetServantMapID() == self:GetMapID() then
        ---若在同地图,则将焦点放在灵兽坐标上
        self:SerFocusCoordinate(self:GetServantCoordinate())
    else
        ---若在不同地图,则将焦点放在地图中央
        self:SerFocusCoordinate(self:GetCurrentCenterCoord())
    end
end
--endregion

--region 刷新下拉框显示
---刷新下拉框显示
---@private
function UIServantPracticeMapTemplate:RefreshDropDownShowing()
    self.mIsRefreshingOptions = true
    ---配置一下panel的depth
    self:GetOptionsPanel().depth = self:GetScrollViewPanel().depth + 1
    local maps = self:GetPracticeMaps()
    ---刷新主options,如果没有就选择默认的
    local options = {}
    local defaultOption
    local isCurrentExist = false
    for i = 1, #maps do
        if maps[i].isAnyAvailableMap then
            local nameTemp = maps[i].name
            if defaultOption == nil then
                defaultOption = nameTemp
            end
            if self:GetMainDropDownData() == nameTemp then
                isCurrentExist = true
            end
            table.insert(options, nameTemp)
        end
    end
    if isCurrentExist == false then
        self.mMainDropDownData = defaultOption
    end
    self:GetMainDropDown():SetOptions(options)
    self:GetMainDropDown():Select(self:GetMainDropDownData())
    ---刷新子options,如果没有就选择默认的
    local subOptions = {}
    local defaultSubOption
    isCurrentExist = false
    for i = 1, #maps do
        if maps[i].name == self:GetMainDropDownData() then
            ---筛选出符合条件的子选项
            for j = 1, #maps[i].maps do
                local nameTemp = maps[i].maps[j].tbl.name2
                if maps[i].maps[j].isConditionConfirm then
                    if defaultSubOption == nil then
                        defaultSubOption = nameTemp
                    end
                    if self:GetSubDropDownData() == nameTemp then
                        isCurrentExist = true
                    end
                    table.insert(subOptions, nameTemp)
                end
            end
        end
    end
    if isCurrentExist == false then
        self.mSubDropDownData = defaultSubOption
    end
    self:GetSubDropDown():SetOptions(subOptions)
    self:GetSubDropDown():Select(self:GetSubDropDownData())
    self.mIsRefreshingOptions = false
end
--endregion

return UIServantPracticeMapTemplate