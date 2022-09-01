---@class 小地图界面:UIBase
local UIMapPanel = {}

---可走点寻找范围
UIMapPanel.mAvailableCoordinateFindingRadius = 5
---开始加载地图事件
UIMapPanel.mOnStartLoadMapClientMsgReceived = nil

--region 组件
---纹理根节点
---@return UnityEngine.GameObject
function UIMapPanel:GetTextureRoot_GO()
    if self.mTextureRoot == nil then
        self.mTextureRoot = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture", "GameObject")
    end
    return self.mTextureRoot
end

---玩家图片
---@return UISprite
function UIMapPanel:GetPlayerSprite_UISprite()
    if self.mPlayerSprite_UISprite == nil then
        self.mPlayerSprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture/Points/Player", "UISprite")
    end
    return self.mPlayerSprite_UISprite
end

---玩家特效图片
---@return UISprite
function UIMapPanel:GetPlayerEffectSprite_UISprite()
    if self.mPlayerEffectSprite_UISprite == nil then
        self.mPlayerEffectSprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/Root/Texture/Points/Player/effect", "UISprite")
    end
    return self.mPlayerEffectSprite_UISprite
end

---地图名文字组件
function UIMapPanel:GetMapNameLabel_UILabel()
    if self.mMapNameLabel_UILabel == nil then
        self.mMapNameLabel_UILabel = self:GetCurComp("WidgetRoot/view/MapPanel/Root/MapName", "UILabel")
    end
    return self.mMapNameLabel_UILabel
end

---玩家坐标文字组件
function UIMapPanel:GetMainPlayerCoordinateLabel_UILabel()
    if self.mMainPlayerCoordinateLabel_UILabel == nil then
        self.mMainPlayerCoordinateLabel_UILabel = self:GetCurComp("WidgetRoot/view/MapPanel/Root/PlayerCoordinate", "UILabel")
    end
    return self.mMainPlayerCoordinateLabel_UILabel
end

---附带文字的图片UI组合预设
---@return UICombination_SpriteAndLabel
function UIMapPanel:GetPointWithLabel_UICombination()
    if self.mPointWithLabel_UICombination == nil then
        self.mPointWithLabel_UICombination = self:GetCurComp("WidgetRoot/view/MapPanel/MapObjects/pointWithLabel", "UICombination_SpriteAndLabel")
    end
    return self.mPointWithLabel_UICombination
end

---仅含图片的预设
---@return UISprite
function UIMapPanel:GetPointOnlySprite_UISprite()
    if self.mPointOnlySprite_UISprite == nil then
        self.mPointOnlySprite_UISprite = self:GetCurComp("WidgetRoot/view/MapPanel/MapObjects/point", "UISprite")
    end
    return self.mPointOnlySprite_UISprite
end

-----传送按钮列表
--function UIMapPanel:GetDeliverButtonsList_UIGridContainer()
--    if self.mDeliverButtonsList_UIGridContainer == nil then
--        self.mDeliverButtonsList_UIGridContainer = self:GetCurComp("WidgetRoot/events/buttons/buttonList", "UIGridContainer")
--    end
--    return self.mDeliverButtonsList_UIGridContainer
--end

---传送按钮循环列表
---@return UILoopScrollViewPlus
function UIMapPanel:GetDeliverButtonsList_UILoopScrollViewPlus()
    if self.mDeliverButtonsList_UILoopScrollViewPlus == nil then
        self.mDeliverButtonsList_UILoopScrollViewPlus = self:GetCurComp("WidgetRoot/events/buttons", "UILoopScrollViewPlus")
    end
    return self.mDeliverButtonsList_UILoopScrollViewPlus
end

---关闭按钮
---@return UnityEngine.GameObject
function UIMapPanel:GetCloseButton_GameObject()
    if self.mCloseButton_GameObject == nil then
        self.mCloseButton_GameObject = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseButton_GameObject
end

---回城石按钮
---@return UnityEngine.GameObject
function UIMapPanel:GetTransferButton_GameObject()
    if self.mTransferButton_GameObject == nil then
        self.mTransferButton_GameObject = self:GetCurComp("WidgetRoot/events/btn_transfer", "GameObject")
    end
    return self.mTransferButton_GameObject
end

---回城石文字
---@return UISprite
function UIMapPanel:GetTransferButtonLabel_UISprite()
    if self.mTransferButtonLabel_UILabel == nil then
        self.mTransferButtonLabel_UILabel = self:GetCurComp("WidgetRoot/events/btn_transfer/LabelSprite", "UISprite")
    end
    return self.mTransferButtonLabel_UILabel
end

---回城石可用数量文字
---@return UILabel
function UIMapPanel:GetTransferCountLabel_UILabel()
    if self.mTransferCountLabel_UILabel == nil then
        self.mTransferCountLabel_UILabel = self:GetCurComp("WidgetRoot/events/btn_transfer/count", "UILabel")
    end
    return self.mTransferCountLabel_UILabel
end

---回城石图片
---@return UISprite
function UIMapPanel:GetTransferButtonSprite_UISprite()
    if self.mTransferButtonSprite_UISprite == nil then
        self.mTransferButtonSprite_UISprite = self:GetCurComp("WidgetRoot/events/btn_transfer", "UISprite")
    end
    return self.mTransferButtonSprite_UISprite
end

---随机石按钮
---@return UnityEngine.GameObject
function UIMapPanel:GetRandomButton_GameObject()
    if self.mRandomButton_GameObject == nil then
        self.mRandomButton_GameObject = self:GetCurComp("WidgetRoot/events/btn_random", "GameObject")
    end
    return self.mRandomButton_GameObject
end

---随机石可用数量文字
---@return UILabel
function UIMapPanel:GetRandomCountLabel_UILabel()
    if self.mRandomCountLabel_UILabel == nil then
        self.mRandomCountLabel_UILabel = self:GetCurComp("WidgetRoot/events/btn_random/count", "UILabel")
    end
    return self.mRandomCountLabel_UILabel
end

---随机石图片
---@return UISprite
function UIMapPanel:GetRandomButtonSprite_UISprite()
    if self.mRandomButtonSprite_UISprite == nil then
        self.mRandomButtonSprite_UISprite = self:GetCurComp("WidgetRoot/events/btn_random", "UISprite")
    end
    return self.mRandomButtonSprite_UISprite
end

---显示地图配置
---@return UnityEngine.GameObject
function UIMapPanel:GetMapConfig_GameObject()
    if self.mMapConfig_GameObject == nil then
        self.mMapConfig_GameObject = self:GetCurComp("WidgetRoot/view/MapPanel/MapConfig", "GameObject")
    end
    return self.mMapConfig_GameObject
end

---显示boss出生点
---@return Top_UIToggle
function UIMapPanel:GetBossBron_Toggle()
    if self.mBossBron_Toggle == nil then
        self.mBossBron_Toggle = self:GetCurComp("WidgetRoot/view/MapPanel/MapConfig/BossBron", "Top_UIToggle")
    end
    return self.mBossBron_Toggle
end

---显示所有Monster
---@return Top_UIToggle
function UIMapPanel:GetAllMonster_Toggle()
    if self.mAllMonster_Toggle == nil then
        self.mAllMonster_Toggle = self:GetCurComp("WidgetRoot/view/MapPanel/MapConfig/AllMonster", "Top_UIToggle")
    end
    return self.mAllMonster_Toggle
end

--endregion

--region 初始化
function UIMapPanel:Init()
    self:InitializeUIMiniMap()
    self:InitializeButtons()
    self:BindUIEvents()
    self:BindNetMessage()
    self:InitMapConfig()
end

---初始化小地图
function UIMapPanel:InitializeUIMiniMap()
    ---@type UIMiniMapController
    self.mUIMiniMapController = self:GetTextureRoot_GO():AddComponent(typeof(CS.UIMapPanelController))
    if self.mUIMiniMapController and CS.StaticUtility.IsNull(self.mUIMiniMapController) == false then
        --设置小地图控制器的各项参数
        self.mUIMiniMapController.spriteOnlyPrefab = self:GetPointOnlySprite_UISprite()
        self.mUIMiniMapController.spriteAndLabelPrefab = self:GetPointWithLabel_UICombination()
        self.mUIMiniMapController.playerPoint = self:GetPlayerSprite_UISprite()
        self.mUIMiniMapController.playerPointEffect = self:GetPlayerEffectSprite_UISprite()
        self.mUIMiniMapController.mapNameLabel = self:GetMapNameLabel_UILabel()
        self.mUIMiniMapController.mainPlayerCoordinateLabel = self:GetMainPlayerCoordinateLabel_UILabel()
        self.mUIMiniMapController.FontSizeMultiple = 1
        self.mUIMiniMapController.isShowTeleportSubtitle = true
    end
end

---初始化按钮
function UIMapPanel:InitializeButtons()
    ---@type 地图传送类型
    local recentDeliverType = self:GetRecentDeliverType()
    local deliverTypeForDeliverBtns = recentDeliverType
    local deliverTypeForPropBtns = recentDeliverType
    local mapID = CS.CSScene.getMapID()
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(mapID)
    if mapTbl then
        local minmapDeliverType = mapTbl:GetMinMapDeliverType()
        if minmapDeliverType ~= 0 then
            if minmapDeliverType == 1 then
                --比奇
                deliverTypeForDeliverBtns = LuaEnumUIMapDeliverType.BiQi
            elseif minmapDeliverType == 2 then
                --盟重
                deliverTypeForDeliverBtns = LuaEnumUIMapDeliverType.TuCheng
            elseif minmapDeliverType == 3 then
                --比奇分线
                deliverTypeForDeliverBtns = LuaEnumUIMapDeliverType.BiQiFenXian
            elseif minmapDeliverType == 4 then
                --白日门
                deliverTypeForDeliverBtns = LuaEnumUIMapDeliverType.BaiRiMen
            end
            if self:IsMapOfDeliverTypeCanEnter(deliverTypeForDeliverBtns) == false then
                ---当配置的需要优先显示的主城，玩家不满足进入条件时，则按照玩家上次去过的主城相关内容进行显示
                deliverTypeForDeliverBtns = recentDeliverType
            end
        end

        local minmapBackType = mapTbl:GetMinMapBackFirst()
        if minmapBackType ~= 0 then
            if minmapBackType == 1 then
                --比奇
                deliverTypeForPropBtns = LuaEnumUIMapDeliverType.BiQi
            elseif minmapBackType == 2 then
                --盟重
                deliverTypeForPropBtns = LuaEnumUIMapDeliverType.TuCheng
            elseif minmapBackType == 3 then
                --白日门
                deliverTypeForPropBtns = LuaEnumUIMapDeliverType.BaiRiMen
            end
            if self:IsMapOfDeliverTypeCanEnter(deliverTypeForPropBtns) == false then
                ---当配置的需要优先显示的主城，玩家不满足进入条件时，则按照玩家上次去过的主城相关内容进行显示
                deliverTypeForPropBtns = recentDeliverType
            end
        end
    end

    self:InitializeDeliverButtons(deliverTypeForDeliverBtns)

    self:InitializePropButtons(deliverTypeForPropBtns)
end

---deliverType对应的地图是否可以进入
---@param deliverType 地图传送类型
---@return boolean
function UIMapPanel:IsMapOfDeliverTypeCanEnter(deliverType)
    local mapID = 0
    if deliverType == LuaEnumUIMapDeliverType.BiQi then
        mapID = 1001
    elseif deliverType == LuaEnumUIMapDeliverType.TuCheng then
        mapID = 1002
    elseif deliverType == LuaEnumUIMapDeliverType.BiQiFenXian then
        mapID = 1009
    elseif deliverType == LuaEnumUIMapDeliverType.BaiRiMen then
        mapID = 1006
    end
    return self:IsMapCanEnter(mapID)
end

---地图是否可以进入
---@param mapID number
---@return boolean
function UIMapPanel:IsMapCanEnter(mapID)
    if mapID == nil then
        return false
    end
    ---@type TABLE.CFG_MAP
    local isTblExist, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(mapID)
    if mapTbl then
        if mapTbl.conditionId ~= nil then
            local res = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditionList(mapTbl.conditionId.list)
            return res
        end
        return true
    end
    return false
end

---初始化传送按钮
---@param deliverType 地图传送类型
function UIMapPanel:InitializeDeliverButtons(deliverType)
    if CS.StaticUtility.IsNull(self:GetDeliverButtonsList_UILoopScrollViewPlus()) == false then
        local npcList = CS.Cfg_MapNpcTableManager.Instance.NPCListInMapPanel
        if npcList then
            --local validNpcList = CS.System.Collections.Generic["List`1[TABLE.CFG_MAP_NPC]"]()
            local validNpcList = {}
            local deliverTableMgr = CS.Cfg_DeliverTableManager.Instance
            local conditionTableMgr = CS.Cfg_ConditionManager.Instance
            for i = 0, npcList.Count - 1 do
                ---@class CFG_MAP_NPC
                local npc = npcList[i]
                if npc then
                    local isValidNPC = true
                    if deliverTableMgr and npc.deliverId then
                        if npc.deliverType ~= 0 and npc.deliverType ~= deliverType then
                            isValidNPC = false
                        else
                            local isValidDeliverTbl, deliverTbl
                            isValidDeliverTbl, deliverTbl = deliverTableMgr:TryGetValue(npc.deliverId)
                            --当不满足传送条件时不显示该传送
                            if isValidDeliverTbl and deliverTbl and deliverTbl.condition ~= nil then
                                isValidNPC = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchConditonListOrList(deliverTbl.condition)
                            end
                        end
                    end
                    if isValidNPC then
                        --validNpcList:Add(npc)
                        table.insert(validNpcList, npc)
                    end
                end
            end
            local npcListCount = #validNpcList
            if npcListCount > 0 then
                self:GetDeliverButtonsList_UILoopScrollViewPlus():Init(function(go, line)
                    ---@type UIMapPanelDeliver
                    local template = self:GetTemplateByGO(go)
                    template:Refresh(validNpcList[line + 1])
                    return line < npcListCount
                end, nil)
            end
        end
        return
    end
    --
    --if self:GetDeliverButtonsList_UIGridContainer() ~= nil and CS.StaticUtility.IsNull(self:GetDeliverButtonsList_UIGridContainer()) == false then
    --    local npcList = CS.Cfg_MapNpcTableManager.Instance.NPCListInMapPanel
    --    if npcList then
    --        local validNpcList = {}
    --        local deliverTableMgr = CS.Cfg_DeliverTableManager.Instance
    --        local conditionTableMgr = CS.Cfg_ConditionManager.Instance
    --        for i = 0, npcList.Count - 1 do
    --            ---@type CFG_MAP_NPC
    --            local npc = npcList[i]
    --            if npc then
    --                local isValidNPC = true
    --                if deliverTableMgr and npc.deliverId then
    --                    if npc.deliverType ~= 0 and npc.deliverType ~= deliverType then
    --                        isValidNPC = false
    --                    else
    --                        local isValidDeliverTbl, deliverTbl
    --                        isValidDeliverTbl, deliverTbl = deliverTableMgr:TryGetValue(npc.deliverId)
    --                        --当不满足传送条件时不显示该传送
    --                        if isValidDeliverTbl and deliverTbl and deliverTbl.condition > 0 then
    --                            local isValidConditionTbl, conditionTbl
    --                            isValidConditionTbl, conditionTbl = conditionTableMgr:TryGetValue(deliverTbl.condition)
    --                            if isValidConditionTbl then
    --                                isValidNPC = conditionTableMgr:IsMainPlayerMatchCondition(deliverTbl.condition)
    --                            end
    --                        end
    --                    end
    --                end
    --                if isValidNPC then
    --                    table.insert(validNpcList, npc)
    --                end
    --            end
    --        end
    --        self:GetDeliverButtonsList_UIGridContainer().MaxCount = #validNpcList
    --        for i = 1, #validNpcList do
    --            ---@type UIMapPanelDeliver
    --            local template = templatemanager.GetNewTemplate(self:GetDeliverButtonsList_UIGridContainer().controlList[i - 1], luaComponentTemplates.UIMapPanel_DeliverBtnTemplates)
    --            template:Refresh(validNpcList[i])
    --            template:BindClickEvent(self.OnDeliverBtnClicked)
    --        end
    --    end
    --end
end

function UIMapPanel:GetTemplateByGO(go)
    if self.mTemplateGOs == nil then
        self.mTemplateGOs = {}
    end
    if self.mTemplateGOs[go] ~= nil then
        return self.mTemplateGOs[go]
    end
    local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIMapPanel_DeliverBtnTemplates)
    self.mTemplateGOs[go] = template
    template:BindClickEvent(self.OnDeliverBtnClicked)
    return template
end

---初始化道具按钮
---@param deliverType 地图传送类型
function UIMapPanel:InitializePropButtons(deliverType)
    --传送石
    ---需要同时考虑传送石是否可以使用,以传送石所传送的目标地图的进入条件为准
    local biqiExist = self:IsBackStoneUseable(LuaEnumSpecialPropItemID.ReturnBiQiCityStone)
            and (CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(LuaEnumSpecialPropItemID.ReturnBiQiCityStone) ~= nil)
    local tuchengExist = self:IsBackStoneUseable(LuaEnumSpecialPropItemID.ReturnMengZhongCityStone)
            and (CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(LuaEnumSpecialPropItemID.ReturnMengZhongCityStone) ~= nil)
    local bairimenExist = self:IsBackStoneUseable(LuaEnumSpecialPropItemID.ReturnBaiRiMenStone)
            and (CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(LuaEnumSpecialPropItemID.ReturnBaiRiMenStone) ~= nil)
    local isTargetStoneExist = false
    ---判断当前deliverType对应的回城石有没有
    if deliverType == LuaEnumUIMapDeliverType.BiQi or deliverType == LuaEnumUIMapDeliverType.BiQiFenXian then
        isTargetStoneExist = biqiExist
    elseif deliverType == LuaEnumUIMapDeliverType.TuCheng then
        isTargetStoneExist = tuchengExist
    elseif deliverType == LuaEnumUIMapDeliverType.BaiRiMen then
        isTargetStoneExist = bairimenExist
    end
    ---若当前对应的回城石没有,则按照盟重>比奇>白日门的顺序取背包中有的回城石对应的类型
    if isTargetStoneExist == false then
        if tuchengExist then
            deliverType = LuaEnumUIMapDeliverType.TuCheng
            isTargetStoneExist = true
        elseif biqiExist then
            deliverType = LuaEnumUIMapDeliverType.BiQi
            isTargetStoneExist = true
        elseif bairimenExist then
            deliverType = LuaEnumUIMapDeliverType.BaiRiMen
            isTargetStoneExist = true
        end
    end
    if deliverType == LuaEnumUIMapDeliverType.BiQi then
        self.mTransferPropID = LuaEnumSpecialPropItemID.ReturnBiQiCityStone
        self:GetTransferButtonLabel_UISprite().spriteName = "text1"
    elseif deliverType == LuaEnumUIMapDeliverType.TuCheng then
        self.mTransferPropID = LuaEnumSpecialPropItemID.ReturnMengZhongCityStone
        self:GetTransferButtonLabel_UISprite().spriteName = "text2"
    elseif deliverType == LuaEnumUIMapDeliverType.BaiRiMen then
        self.mTransferPropID = LuaEnumSpecialPropItemID.ReturnBaiRiMenStone
        self:GetTransferButtonLabel_UISprite().spriteName = "text4"
    else
        self.mTransferPropID = LuaEnumSpecialPropItemID.ReturnBiQiCityStone
        self:GetTransferButton_GameObject():SetActive(false)
    end

    local itemTbl
    ___, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mTransferPropID)
    if itemTbl then
        local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(self.mTransferPropID)
        if bagItem == nil then
            self:GetTransferButtonSprite_UISprite().color = CS.UnityEngine.Color.black
        end
        self:GetTransferButtonSprite_UISprite().spriteName = itemTbl.icon
    end
    --随机石
    ___, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumSpecialPropItemID.RandomStone)
    if itemTbl then
        local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(itemTbl.id)
        if bagItem == nil then
            self:GetRandomButtonSprite_UISprite().color = CS.UnityEngine.Color.black
        end
        self:GetRandomButtonSprite_UISprite().spriteName = itemTbl.icon
    end
    UIMapPanel:RefreshStoneAvailableCount()
end

---回城石是否可以使用
---@param targetStoneID number
---@return boolean
function UIMapPanel:IsBackStoneUseable(targetStoneID)
    if targetStoneID == nil or targetStoneID == 0 then
        return false
    end
    ---@type TABLE.CFG_ITEMS
    local isExist, stoneItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(targetStoneID)
    if stoneItem.type == 8 and stoneItem.subType == 14 then
        if stoneItem.useParam and stoneItem.useParam.list.Count > 1 then
            local mapID = stoneItem.useParam.list[0]
            return self:IsMapCanEnter(mapID)
        end
    end
    return false
end

--region 小地图显示配置

---初始化地图配置
function UIMapPanel:InitMapConfig()
    self:RefreshMapConfig()
    if CS.UIMapPanelController.IsLimitMiniMapConfig then
        self:RefreshMapMonsterPointConfig()
    end

    CS.EventDelegate.Add(self:GetAllMonster_Toggle().onChange, function()
        CS.UIMapPanelController.IsLimitMonsterPointShow = not self:GetAllMonster_Toggle().value
        CS.UIMiniMapController.RefreshAllMiniMapImmediately()
    end)
end

---刷新地图设置
function UIMapPanel:RefreshMapConfig()
    self:GetMapConfig_GameObject():SetActive(CS.UIMapPanelController.IsLimitMiniMapConfig)
end

---刷新地图boss点配置
function UIMapPanel:RefreshMapMonsterPointConfig()
    self:GetAllMonster_Toggle().value = not CS.UIMapPanelController.IsLimitMonsterPointShow
    self:GetBossBron_Toggle().value = CS.UIMapPanelController.IsLimitMonsterPointShow
end

--endregion

---获取最近经过的主城对应的传送类型
---@return 地图传送类型
function UIMapPanel:GetRecentDeliverType()
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MapInfoV2 ~= nil then
        local recentMapId = CS.CSScene.MainPlayerInfo.MapInfoV2.RecentMainCityMapID
        if recentMapId == 1002 then
            return LuaEnumUIMapDeliverType.TuCheng
        elseif recentMapId == 1009 or CS.CSMissionManager.Instance.CurMissionIsSubLineBIQI then
            return LuaEnumUIMapDeliverType.BiQiFenXian
        elseif recentMapId == 1006 then
            return LuaEnumUIMapDeliverType.BaiRiMen
        end
    end
    return LuaEnumUIMapDeliverType.TuCheng
    --return LuaEnumUIMapDeliverType.BiQi
end

---绑定UI事件
function UIMapPanel:BindUIEvents()
    ---@type UIEventListener
    local eventListener
    --关闭按钮
    eventListener = CS.UIEventListener.Get(self:GetCloseButton_GameObject())
    if eventListener and CS.StaticUtility.IsNull(eventListener) == false then
        eventListener.LuaEventTable = self
        eventListener.OnClickLuaDelegate = self.OnCloseButtonClicked
    end
    --传送石按钮
    eventListener = CS.UIEventListener.Get(self:GetTransferButton_GameObject())
    if eventListener and CS.StaticUtility.IsNull(eventListener) == false then
        eventListener.LuaEventTable = self
        eventListener.OnClickLuaDelegate = self.OnTransferButtonClicked
        local transferProp = CS.Cfg_ItemsTableManager.Instance:GetItems(self.mTransferPropID)
        if transferProp then
            eventListener.ClickIntervalTime = transferProp.resetTime
        end
    end
    --随机石按钮
    eventListener = CS.UIEventListener.Get(self:GetRandomButton_GameObject())
    if eventListener and CS.StaticUtility.IsNull(eventListener) == false then
        eventListener.LuaEventTable = self
        eventListener.OnClickLuaDelegate = self.OnRandomButtonClicked
        local randomStone = CS.Cfg_ItemsTableManager.Instance:GetItems(LuaEnumSpecialPropItemID.RandomStone)
        if randomStone then
            eventListener.ClickIntervalTime = randomStone.resetTime
        end
    end
    --地图纹理点击
    eventListener = CS.UIEventListener.Get(self:GetTextureRoot_GO())
    if eventListener and CS.StaticUtility.IsNull(eventListener) == false then
        eventListener.LuaEventTable = self
        eventListener.OnClickLuaDelegate = self.OnMapTextureClicked
    end
end

function UIMapPanel:BindNetMessage()
    UIMapPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:OnBagItemUseCountChanged()
    end)
    UIMapPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StartLoadMap, function()
        self:OnStartLoadMapClientMsgReceived()
    end)
    UIMapPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, function()
        self:OnMapProcessAfterLoaded()
    end)
end

--endregion

--region UI事件
---关闭按钮点击事件
function UIMapPanel:OnCloseButtonClicked(go)
    uimanager:ClosePanel(self)
end

---回城石按钮点击事件
function UIMapPanel:OnTransferButtonClicked(go)
    local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(self.mTransferPropID)
    if bagItem then
        networkRequest.ReqUseItem(1, bagItem.lid, 0)
        --清空传送后寻路
        CS.CSScene.Sington.SetPathFindAfterDeliver:Clear()
        --若传送则关闭自动寻路和自动战斗
        CS.CSPathFinderManager.Instance:Reset(true, true)
        --清除当前任务
        CS.CSMissionManager.Instance:ClearCurrentTask()
        --清除并关闭目标选择系统
        CS.CSTargetGetWayManager.Instanece:Clear()
        local currentMapID = CS.CSScene.getMapID()
        if currentMapID == 9701 or currentMapID == 9702 then
            ---处在监狱的话,等到传送后再关闭界面
            UIMapPanel.mOnStartLoadMapClientMsgReceived = function()
                UIMapPanel:OnCloseButtonClicked()
            end
        else
            UIMapPanel:OnCloseButtonClicked()
        end
    else
        --local wayGetShopId = 3; ---获取途径表里面的商城途径的id
        --local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mTransferPropID);
        --if (isFind and itemInfo.wayGet.list:Contains(wayGetShopId)) then
            --[[
                        local data = {
                            Title = "提示",
                            Content = itemInfo.name .. "道具不足，是否前往商场购买",
                            CallBack = function()
                                uimanager:CreatePanel("UIShopPanel");
                            end
                        }
                        uimanager:CreatePanel("UIPromptPanel", nil, data)
            --]]

            --local TipData = {}
            --TipData.PromptWordId = 94
            --local des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(94)
            --TipData.des = string.format(des, itemInfo.name)
            --TipData.ComfireAucion = function()
            --    Utility.TransferShopChooseItem(itemInfo.id)
            --    --uimanager:CreatePanel("UIShopPanel");
            --end
            --Utility.ShowSecondConfirmPanel(TipData)

        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(LuaEnumSpecialPropItemID.ReturnMengZhongCityStone, function(storeVo)
            if (storeVo ~= nil) then
                Utility.ShowItemGetWayByData({
                    itemId = storeVo.itemTable.id,
                    target = go,
                    arrowType = LuaEnumWayGetPanelArrowDirType.Down,
                })
            else
                uimanager:CreatePanel("UIShopPanel")
            end
        end);
        --Utility.ShowItemGetWay(LuaEnumSpecialPropItemID.ReturnMengZhongCityStone, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector3.zero);

        --else
        --    CS.Utility.ShowTips("回城石不足", 1.5, CS.ColorType.Yellow)
        --end
    end
end

---随机石按钮点击事件
function UIMapPanel:OnRandomButtonClicked(go)

    ---是否有晕眩buff
    if (CS.CSScene.MainPlayerInfo.BuffInfo:HasBuff(4)) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIMapPanel"
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end

    local bagItem = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(LuaEnumSpecialPropItemID.RandomStone)
    if bagItem then
        networkRequest.ReqUseItem(1, bagItem.lid, 0)
        --if CS.CSPathFinderManager.Instance.IsPathFinding == false and CS.CSScene.Sington.MainPlayer.Moveing then
        --    ---仅在非自动寻路时生效
        --    --清空传送后寻路
        --    CS.CSScene.Sington.SetPathFindAfterDeliver:Clear()
        --    --当自动寻路关闭,当前攻击目标为空且正在进行地图寻路时,使用随机石后继续该寻路
        --    local cachedCoord = CS.CSScene.Sington.MainPlayer.TouchEvent.Coord
        --    --if CS.CSPathFinderManager.Instance.IsPathFinding == true
        --    --        or CS.CSScene.Sington.MainPlayer.TouchEvent.TargetAvater.Target ~= nil
        --    --        or CS.CSScene.Sington.MainPlayer.Moveing == false
        --    --        or (CS.CSScene.Sington.MainPlayer.Moveing and CS.CSScene.Sington.MainPlayer.TouchMove ~= CS.ControlState.Idle)
        --    --then
        --    --    cachedCoord = CS.SFMiscBase.Dot2.Zero
        --    --end
        --    CS.CSScene.Sington.SetPathFindAfterDeliver:SetPathFindTargetAfterDeliver(cachedCoord, 5, Utility.EnumToInt(CS.NewEventProcess.PositionChangeReason.RandomStone))
        --end
    else
        --local wayGetShopId = 3; ---获取途径表里面的商城途径的id
        --local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumSpecialPropItemID.RandomStone);
        --if (isFind and itemInfo.wayGet.list:Contains(wayGetShopId)) then
            --local TipData = {}
            --TipData.PromptWordId = 95
            --local des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(94)
            --TipData.des = string.format(des, itemInfo.name)
            --TipData.ComfireAucion = function()
            --    Utility.TransferShopChooseItem(itemInfo.id)
            --    --uimanager:CreatePanel("UIShopPanel");
            --end
            --Utility.ShowSecondConfirmPanel(TipData)
        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(LuaEnumSpecialPropItemID.RandomStone, function(storeVo)
            if (storeVo ~= nil) then
                Utility.ShowItemGetWayByData({
                    itemId = storeVo.itemTable.id,
                    target = go,
                    arrowType = LuaEnumWayGetPanelArrowDirType.Down,
                })
            else
                uimanager:CreatePanel("UIShopPanel")
            end
        end);

            --Utility.ShowItemGetWay(LuaEnumSpecialPropItemID.RandomStone, go, LuaEnumWayGetPanelArrowDirType.Down, CS.UnityEngine.Vector3.zero);
        --else
        --    CS.Utility.ShowTips("随机石不足", 1.5, CS.ColorType.Yellow)
        --end
    end
end

---地图纹理点击事件
function UIMapPanel:OnMapTextureClicked(go)
    if self.mUIMiniMapController == nil and CS.StaticUtility.IsNull(self.mUIMiniMapController) == false then
        return
    end
    --点击屏幕的世界坐标
    local touchPos = CS.UICamera.currentTouch.pos;
    touchPos = self:GetTextureRoot_GO().transform:InverseTransformPoint(CS.UICamera.currentCamera:ScreenToWorldPoint(CS.UnityEngine.Vector3(touchPos.x, touchPos.y, 0)))
    local dot = self.mUIMiniMapController.CoordinateCalculator:TransLocalPosInMiniMapToSceneCoord(touchPos)
    if uiStaticParameter.isOpenGMSend then
        local mapId = CS.CSScene.getMapID()
        if mapId and dot then
            networkRequest.ReqGM("@传送 " .. tostring(mapId) .. " " .. tostring(dot.x) .. " " .. tostring(dot.y))
        end
        return
    end
    self:SetMainPlayerPathFinding(self:CorrectCoordinate(dot))
end

---传送按钮点击事件
---@param deliverBtnTemplate UIMapPanelDeliver 传送按钮模板
function UIMapPanel.OnDeliverBtnClicked(deliverBtnTemplate)
    ---是否有晕眩buff
    if (CS.CSScene.MainPlayerInfo.BuffInfo:HasBuff(4)) then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = deliverBtnTemplate.go.transform;
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 64
        TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIMapPanel"
        return uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo);
    end

    --region 塔罗神庙特殊处理
    ---（未加入商会时，在塔罗神庙点击小地图的npc按钮时，能直接退出地图，回到主城安全区 单号 95173）
    local isJoinedCommerce = CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce() == true
    local isInTarotMap = CS.Cfg_GlobalTableManager.Instance:CurMapIsTarotMap()
    if isInTarotMap and not isJoinedCommerce then
        --退出安全区
        networkRequest.ReqMapCommon(6)
        uimanager:ClosePanel("UIMapPanel")
        return
    end
    --endregion

    local finishCodeEnum = CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPanelFindNPCOperation:DoOperation(deliverBtnTemplate.npcTbl)
    local finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(finishCodeEnum)
    if finishCode >= 0 then
        uimanager:ClosePanel("UIMapPanel")
    else
        finishCode = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            UIMapPanel:ClosePanel(UIMapPanel)
            CS.CSScene.MainPlayerInfo.AsyncOperationController.MapPanelFindNPCOperation:DoOperation(deliverBtnTemplate.npcTbl)
        end))
        if finishCode < 0 then
            --CS.Utility.ShowTips("该坐标无法寻路到达")
        end
    end
end
--endregion

--region 客户端事件
--刷新传送石数量
function UIMapPanel:OnBagItemUseCountChanged()
    UIMapPanel:RefreshStoneAvailableCount()
end

---开始加载地图事件
function UIMapPanel:OnStartLoadMapClientMsgReceived()
    if UIMapPanel.mOnStartLoadMapClientMsgReceived ~= nil then
        UIMapPanel.mOnStartLoadMapClientMsgReceived()
        UIMapPanel.mOnStartLoadMapClientMsgReceived = nil
    end
end

function UIMapPanel:OnMapProcessAfterLoaded()
    self:RefreshMapConfig()
end

--endregion

--region 逻辑方法
---修正坐标
---将传入的坐标点修正为离坐标点最近的可走点
---超出修正范围则返回nil
---@param coordinate SFMiscBaseDot2 待修正坐标
---@return SFMiscBaseDot2
function UIMapPanel:CorrectCoordinate(coordinate)
    if coordinate then
        if self:IsCoordinateReachable(coordinate) then
            return coordinate
        else
            ---初始格子环形指针
            local startingCirclePointer = {}
            startingCirclePointer.x = 1
            startingCirclePointer.y = 1
            ---寻格步长(大于0表示顺时针,小于0表示逆时针)
            local startingFindDirection = 1
            ---半径
            local radius = 1
            --根据玩家当前位置更改寻找格子的参数
            local currentPlayerCoord = CS.CSScene.Sington.MainPlayer.OldCell.Coord
            if currentPlayerCoord then
                --找到目标点的八个方向上离玩家最近的点,并分辨出趋向于靠近目标点的方向是逆时针还是顺时针
                local xDis = currentPlayerCoord.x - coordinate.x
                local yDis = currentPlayerCoord.y - coordinate.y
                local xTemp = ternary(xDis < 0, -radius, ternary(xDis > 0, radius, 0))
                local yTemp = ternary(yDis < 0, -radius, ternary(yDis > 0, radius, 0))
                --顺时针移动一位,计算该位与玩家之间距离
                startingCirclePointer.x = xTemp
                startingCirclePointer.y = yTemp
                self:MoveCirclePointer(startingCirclePointer, radius, 1)
                startingCirclePointer.x = startingCirclePointer.x + coordinate.x
                startingCirclePointer.y = startingCirclePointer.y + coordinate.y
                local forwardDis = self:CalculateSqrDistance(currentPlayerCoord, startingCirclePointer)
                --逆时针移动一位,计算该位与玩家之间距离
                startingCirclePointer.x = xTemp
                startingCirclePointer.y = yTemp
                self:MoveCirclePointer(startingCirclePointer, radius, -1)
                startingCirclePointer.x = startingCirclePointer.x + coordinate.x
                startingCirclePointer.y = startingCirclePointer.y + coordinate.y
                local backDis = self:CalculateSqrDistance(currentPlayerCoord, startingCirclePointer)
                startingFindDirection = ternary(forwardDis < backDis, 1, -1)
                startingCirclePointer.x = xTemp
                startingCirclePointer.y = yTemp
            end
            --从内圈向外圈遍历格子,返回第一个可走的格子
            local coordinateTemp = {}
            local pointerTemp = {}
            local searchSumTemp = 0
            if self.mAvailableCoordinateFindingRadius > 0 then
                while radius < self.mAvailableCoordinateFindingRadius do
                    searchSumTemp = 8 * radius
                    pointerTemp.x = startingCirclePointer.x * radius
                    pointerTemp.y = startingCirclePointer.y * radius
                    for i = 1, searchSumTemp do
                        self:MoveCirclePointer(pointerTemp, radius, startingFindDirection)
                        coordinateTemp.x = pointerTemp.x + coordinate.x
                        coordinateTemp.y = pointerTemp.y + coordinate.y
                        if self:IsCoordinateReachable(coordinateTemp) then
                            coordinate.x = coordinateTemp.x
                            coordinate.y = coordinateTemp.y
                            return coordinate
                        end
                    end
                    radius = radius + 1
                end
            end
            return nil
        end
    else
        return nil
    end
end

---移动环状指针
---按类似于下面的环状结构移动指针,环状半径为2
---(-2, -2)  (-1, -2)  ( 0, -2)  ( 1, -2)  ( 2, -2)
---(-2, -1)                                ( 2, -1)
---(-2,  0)                                ( 2,  0)
---(-2,  1)                                ( 2,  1)
---(-2,  2)  (-1,  2)  ( 0,  2)  ( 1,  2)  ( 2,  2)
---@param currentPointer table 当前指针
---@param radius number 环状半径
---@param step number 移动步数(正数表示顺时针移动步数,负数表示逆时针移动步数)
function UIMapPanel:MoveCirclePointer(currentPointer, radius, step)
    if radius == nil then
        radius = 1
    end
    if step == nil then
        step = 1
    end
    if step == 0 then
        return
    end
    if currentPointer and currentPointer.x and currentPointer.y then
        radius = math.abs(radius)
        if step > 0 then
            if currentPointer.x < radius and currentPointer.y == -radius then
                currentPointer.x = currentPointer.x + 1
            elseif currentPointer.x == radius and currentPointer.y < radius then
                currentPointer.y = currentPointer.y + 1
            elseif currentPointer.x > -radius and currentPointer.y == radius then
                currentPointer.x = currentPointer.x - 1
            elseif currentPointer.x == -radius and currentPointer.y > -radius then
                currentPointer.y = currentPointer.y - 1
            end
            step = step - 1
        elseif step < 0 then
            if currentPointer.x > -radius and currentPointer.y == -radius then
                currentPointer.x = currentPointer.x - 1
            elseif currentPointer.x == radius and currentPointer.y > -radius then
                currentPointer.y = currentPointer.y - 1
            elseif currentPointer.x < radius and currentPointer.y == radius then
                currentPointer.x = currentPointer.x + 1
            elseif currentPointer.x == -radius and currentPointer.y < radius then
                currentPointer.y = currentPointer.y + 1
            end
            step = step + 1
        end
        if step ~= 0 then
            return self:MoveCirclePointer(currentPointer, radius, step)
        end
    end
end

---计算坐标之间的距离
---@param coordinate1 table 坐标1
---@param coordinate2 table 坐标2
---@return number
function UIMapPanel:CalculateSqrDistance(coordinate1, coordinate2)
    if coordinate1 and coordinate2 then
        local xDis = coordinate1.x - coordinate2.x
        local yDis = coordinate1.y - coordinate2.y
        return (xDis * xDis + yDis * yDis)
    end
    return 0
end

---判断坐标是否可到达
---@param coordinate SFMiscBaseDot2
---@return boolean
function UIMapPanel:IsCoordinateReachable(coordinate)
    if coordinate then
        if coordinate.x <= 0 or coordinate.y <= 0 or coordinate.x >= CS.CSMesh.SizeX or coordinate.y >= CS.CSMesh.SizeZ then
            return false
        end
        if CS.CSScene.Sington.Mesh == nil then
            return false
        end
        local cell = CS.CSScene.Sington.Mesh:getCell(coordinate)
        if self:IsResistance(cell) ~= true then
            return true
        end
    end
    return false
end

---是否是不可走点
function UIMapPanel:IsResistance(cell)
    if cell == nil then
        return true
    end
    --如果是不可走点类型或者是单向格子，默认为此格子不可寻路到达
    if cell:isAttributes(CS.MapEditor.CellType.Resistance) or cell:isAttributes(CS.MapEditor.CellType.Special_3) or self:IsOpenAirWall(cell) then
        return true
    end
    return false
end

function UIMapPanel:IsOpenAirWall(cell)

    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
        return not CS.CSAStar.IsEqualCellSpecial_6(CS.CSScene.Sington.MainPlayer.OldCell, cell)
    else
        return false
    end

    -- if  CS.CSAStar.IsOpenCellSpecial_6 then
    --     if cell:isAttributes(CS.MapEditor.CellType.Special_6) or  cell:isAttributes(CS.MapEditor.CellType.Special_8) then
    --         return true
    --     else
    --         return false
    --     end
    -- else
    --     return false
    -- end

end
--endregion

--region 主角自动寻路
---设置主角寻路
---@param coordinate SFMiscBaseDot2
function UIMapPanel:SetMainPlayerPathFinding(coordinate)
    if coordinate == nil then
        return
    end
    --尝试进入自动暂停状态
    CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
    --关闭自动寻路
    CS.CSPathFinderManager.Instance:Reset(true, true)
    --清除当前任务
    CS.CSMissionManager.Instance:ClearCurrentTask()
    --清除并关闭目标选择系统
    CS.CSTargetGetWayManager.Instanece:Clear()
    --设置寻路
    if CS.CSScene.Sington.MainPlayer then
        CS.CSScene.Sington.MainPlayer:TowardsTaskTarget(coordinate)
    end
end
--endregion

function UIMapPanel:RefreshStoneAvailableCount()
    local count = 0
    --回城石
    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mTransferPropID)
    UIMapPanel:GetTransferCountLabel_UILabel().text = count ~= 0 and tostring(count) or ''
    UIMapPanel:GetTransferButtonSprite_UISprite().color = count ~= 0 and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black
    --随机石  (数量不显示)
    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(LuaEnumSpecialPropItemID.RandomStone)
    UIMapPanel:GetRandomCountLabel_UILabel().text = count ~= 0 and tostring(count) or ''
    UIMapPanel:GetRandomButtonSprite_UISprite().color = count ~= 0 and CS.UnityEngine.Color.white or CS.UnityEngine.Color.black
    --
    --if UIMapPanel:GetTransferButton_GameObject().activeSelf then
    --    str = UIMapPanel:GetTransferButtonLabel_UILabel().text
    --    str = string.sub(str, 1, 6)
    --    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(self.mTransferPropID)
    --    str = count ~= nil and count ~= 0 and str .. count or str
    --    UIMapPanel:GetTransferCountLabel_UILabel().text = str
    --end
    ----随机石
    --if UIMapPanel:GetRandomButtonLabel_UILabel().gameObject.activeSelf then
    --    str = UIMapPanel:GetRandomButtonLabel_UILabel().text
    --    str = string.sub(str, 1, 6)
    --    count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemUseNumber(LuaEnumSpecialPropItemID.RandomStone)
    --    str = count ~= nil and count ~= 0 and str .. count or str
    --    UIMapPanel:GetRandomButtonLabel_UILabel().text = str
    --end
end

return UIMapPanel