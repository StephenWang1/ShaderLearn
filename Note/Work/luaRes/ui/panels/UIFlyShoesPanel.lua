---小飞鞋
---@class UIFlyShoesPanel:UIBase
local UIFlyShoesPanel = {}

UIFlyShoesPanel.PanelLayerType = CS.UILayerType.BasicPlane

UIFlyShoesPanel.IsInitialLoad = true

--region 组件
---@return UIGatherHintTarget
function UIFlyShoesPanel:GetGatherHintTarget()
    if self.mGatherHintTarget == nil then
        local go = self:GetCurComp("StaticRoot/dig", "GameObject")
        if CS.StaticUtility.IsNull(go) == false then
            self.mGatherHintTarget = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGatherHintTarget, self)
        end
    end
    return self.mGatherHintTarget
end

---@return UITrainingHorseHintTarget
function UIFlyShoesPanel:GetTrainingHintTarget()
    if self.mTrainingHintTarget == nil then
        local go = self:GetCurComp("StaticRoot/trainingHorse", "GameObject")
        if CS.StaticUtility.IsNull(go) == false then
            self.mTrainingHintTarget = templatemanager.GetNewTemplate(go, luaComponentTemplates.UITrainingHorseHintTarget, self)
        end
    end
    return self.mTrainingHintTarget
end

---@return UITable
function UIFlyShoesPanel:GetGatherTable_UITable()
    if self.mGatherTbl == nil then
        self.mGatherTbl = self:GetCurComp("StaticRoot", "UITable")
    end
    return self.mGatherTbl
end

function UIFlyShoesPanel.GetFlyShoeHighly_GameObject()
    if (UIFlyShoesPanel.mFlyShoeHighly == nil) then
        UIFlyShoesPanel.mFlyShoeHighly = UIFlyShoesPanel:GetCurComp("WidgetRoot/flyshoes/800009(Clone)/low", "GameObject")
    end
    return UIFlyShoesPanel.mFlyShoeHighly
end

function UIFlyShoesPanel.GetFlyShoeBottom_Transform()
    if (UIFlyShoesPanel.mFlyShoeBottom == nil) then
        UIFlyShoesPanel.mFlyShoeBottom = UIFlyShoesPanel:GetCurComp("WidgetRoot/flyshoes/800009(Clone)/images", "Transform")
    end
    return UIFlyShoesPanel.mFlyShoeBottom
end

function UIFlyShoesPanel.GetFlyShoeBottomEffect_GameObject()
    if (UIFlyShoesPanel.mFlyShoeBottomEffect == nil) and UIFlyShoesPanel.GetFlyShoeBottom_Transform() then
        local child = UIFlyShoesPanel.GetFlyShoeBottom_Transform():GetChild(0)
        if child then
            UIFlyShoesPanel.mFlyShoeBottomEffect = child.gameObject
        end
    end
    return UIFlyShoesPanel.mFlyShoeBottomEffect
end

---自动采矿特效
---@return UnityEngine.GameObject
function UIFlyShoesPanel.GetAutoMiningEffectGO()
    if UIFlyShoesPanel.mAutoMiningEffectGO == nil then
        UIFlyShoesPanel.mAutoMiningEffectGO = UIFlyShoesPanel:GetCurComp("WidgetRoot/automining", "GameObject")
    end
    return UIFlyShoesPanel.mAutoMiningEffectGO
end

---自动采集特效
---@return UnityEngine.GameObject
function UIFlyShoesPanel.GetAutoGatherEffectGO()
    if UIFlyShoesPanel.mAutoGatherEffectGO == nil then
        UIFlyShoesPanel.mAutoGatherEffectGO = UIFlyShoesPanel:GetCurComp("WidgetRoot/autogathering", "GameObject")
    end
    return UIFlyShoesPanel.mAutoGatherEffectGO
end

---自动钓鱼特效
---@return UnityEngine.GameObject
function UIFlyShoesPanel.GetAutoFishingEffectGO()
    if UIFlyShoesPanel.mAutoFishingEffectGO == nil then
        UIFlyShoesPanel.mAutoFishingEffectGO = UIFlyShoesPanel:GetCurComp("WidgetRoot/autofishing", "GameObject")
    end
    return UIFlyShoesPanel.mAutoFishingEffectGO
end

--region 千纸鹤特效组件
function UIFlyShoesPanel.GetQianZhiHeHighly_GameObject()
    if (UIFlyShoesPanel.mQianZhiHeHighly == nil) then
        UIFlyShoesPanel.mQianZhiHeHighly = UIFlyShoesPanel:GetCurComp("WidgetRoot/qianzhihe/700222(Clone)/low", "GameObject")
    end
    return UIFlyShoesPanel.mQianZhiHeHighly
end

function UIFlyShoesPanel.GetQianZhiHeBottom_Transform()
    if (UIFlyShoesPanel.mQianZhiHeBottom == nil) then
        UIFlyShoesPanel.mQianZhiHeBottom = UIFlyShoesPanel:GetCurComp("WidgetRoot/qianzhihe/700222(Clone)/images", "Transform")
    end
    return UIFlyShoesPanel.mQianZhiHeBottom
end

function UIFlyShoesPanel.GetQianZhiHeBottomEffect_GameObject()
    if (UIFlyShoesPanel.mQianZhiHeEffect == nil) then
        UIFlyShoesPanel.mQianZhiHeEffect = UIFlyShoesPanel.GetQianZhiHeBottom_Transform():GetChild(0).gameObject
    end
    return UIFlyShoesPanel.mQianZhiHeEffect
end



--endregion

---自动挖尸体特效
function UIFlyShoesPanel.GetAutoWashiEffectGO()
    if UIFlyShoesPanel.mAutoWashiEffectGO == nil then
        UIFlyShoesPanel.mAutoWashiEffectGO = UIFlyShoesPanel:GetCurComp("WidgetRoot/autowashi", "GameObject")
    end
    return UIFlyShoesPanel.mAutoWashiEffectGO
end

---获取自动采集标识的控制
function UIFlyShoesPanel.GetAutoGatherSignController()
    if UIFlyShoesPanel.mAutoGatherSignController == nil then
        UIFlyShoesPanel.mAutoGatherSignController = UIFlyShoesPanel:GetCurComp("WidgetRoot", "UIGatherSignCtrl")
    end
    return UIFlyShoesPanel.mAutoGatherSignController
end

---在镖车范围内特效
---@return UnityEngine.GameObject
function UIFlyShoesPanel:GetInDartCarRange()
    if UIFlyShoesPanel.mInDartCarRangeGO == nil then
        UIFlyShoesPanel.mInDartCarRangeGO = UIFlyShoesPanel:GetCurComp("WidgetRoot/indartcarRange", "GameObject")
    end
    return UIFlyShoesPanel.mInDartCarRangeGO
end

---WidgetRoot节点
---@return UnityEngine.GameObject
function UIFlyShoesPanel:GetWidgetRootGO()
    if self.mWidgetRootGO == nil then
        self.mWidgetRootGO = self:GetCurComp("WidgetRoot", "GameObject")
    end
    return self.mWidgetRootGO
end
--endregion

--region 初始化
function UIFlyShoesPanel:Init()
    self:InitComponents()
    self:InitializeDatas()
    self:BindEvents()
    self:InitializeState()
    if self:GetGatherHintTarget() then
        self:GetGatherHintTarget():Initialize()
        self:GetGatherHintTarget():BindStateChangedCallBack(function()
            self:RefreshWidgetRootActiveState(self:GetGatherHintTarget():IsShowing())
            self:RefreshGatherShow()
        end)
        self:RefreshWidgetRootActiveState(self:GetGatherHintTarget():IsShowing())
    end

    if self:GetTrainingHintTarget() then
        self:GetTrainingHintTarget():Initialize()
        self:GetTrainingHintTarget():BindStateChangedCallBack(function()
            self:RefreshWidgetRootActiveState(self:GetTrainingHintTarget():IsShowing())
            self:RefreshGatherShow()
        end)
        self:RefreshWidgetRootActiveState(self:GetTrainingHintTarget():IsShowing())
    end

end

---初始化组件引用
function UIFlyShoesPanel:InitComponents()
    --自动寻路
    self.mAutoFind_GameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/autofind", "GameObject")
    --自动战斗
    self.mAutoFight_GameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/autofight", "GameObject")
    --自动暂停
    self.mAutoPaused_GameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/autopaused", "GameObject")

    --自动寻路
    self.mAutoFind_Anim = UIFlyShoesPanel:GetCurComp("WidgetRoot/autofind", "Top_UISpriteAnimation")
    --自动战斗
    self.mAutoFight_Anim = UIFlyShoesPanel:GetCurComp("WidgetRoot/autofight", "Top_UISpriteAnimation")
    --自动暂停
    --self.mAutoPaused_Anim = UIFlyShoesPanel:GetCurComp("WidgetRoot/autopaused", "Top_UISpriteAnimation")

    --小飞鞋
    self.mFlyShoes_GameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/flyshoes", "GameObject")
    --千纸鹤
    self.mQianZhiHe_GameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/qianzhihe", "GameObject")
    ---小飞鞋临时阻挡遮罩(开启于小飞鞋消失后数秒时间内)
    ---@type UnityEngine.GameObject
    self.mFlyShoes_BlockGameObject = UIFlyShoesPanel:GetCurComp("WidgetRoot/flyshoesblock", "GameObject")
    if CS.StaticUtility.IsNull(self.mFlyShoes_BlockGameObject) == false then
        self.mFlyShoes_BlockGameObject:SetActive(false)
    end
end

---初始化数据
function UIFlyShoesPanel:InitializeDatas()
    --小飞鞋等级限制
    self.mFlyLevelLimit = 20
    local isFind, item = CS.Cfg_GlobalTableManager.Instance:TryGetValue(20040)
    if isFind then
        self.mFlyLevelLimit = tonumber(item.value)
    end
    self.mFlyShoeStateCache = false
    self.mQianZhiHeStateCache = false
end

---绑定事件
function UIFlyShoesPanel:BindEvents()
    --客户端消息监听
    self:GetClientEventHandler():AddEvent(CS.CEvent.AutoFightStateChange, UIFlyShoesPanel.OnAutoFightStateChange)
    self:GetClientEventHandler():AddEvent(CS.CEvent.AutoPathFindStateChanged, UIFlyShoesPanel.OnAutoPathFindStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, UIFlyShoesPanel.OnAutoPathFindStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_AutoPausedStateChanged, UIFlyShoesPanel.OnAutoPausedStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RefreshFlyShoesState, UIFlyShoesPanel.OnRefreshFlyShoesStateMsgReceived)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, UIFlyShoesPanel.OnMapProcessAfterLoaded)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_PathFindTargetEnterClientView, UIFlyShoesPanel.OnPathFindTargetInClientViewStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_PathFindTargetExitClientView, UIFlyShoesPanel.OnPathFindTargetInClientViewStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_StartGatherEvent, UIFlyShoesPanel.OnGatherStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_StopGatherEvent, UIFlyShoesPanel.OnGatherStateChanged)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIFlyShoesPanel.OnBagItemChangeCallBack)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerInRDartCarangeChange, UIFlyShoesPanel.RefreshInUnionDartCarRangeState)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionDartFindPath, UIFlyShoesPanel.RefreshInUnionDartCarRangeState)
    self:GetClientEventHandler():AddEvent(CS.CEvent.BaiRiMenFindPathState, UIFlyShoesPanel.RefreshInUnionDartCarRangeState)
    --地宫挖宝刷新
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResDigTreasureStateMessage, UIFlyShoesPanel.RefreshForDigTreasure)

    CS.UIEventListener.Get(self.mFlyShoes_GameObject).onClick = self.OnClickFlyShoes

    CS.UIEventListener.Get(self.mQianZhiHe_GameObject).onClick = self.OnClickQianZhiHe

    UIFlyShoesPanel.CallOnResCheckPreTaskIsCompleteMessage = function(msgId, msgData)
        if msgData ~= nil then
            local isComplete = msgData.isComplete == 1 or msgData.isComplete == 2;
            if (not uiStaticParameter.isShowFlyShoes) then
                if (CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId() == msgData.tableId) then
                    if (isComplete ~= uiStaticParameter.isShowFlyShoes) then
                        --local isComplete = msgData.isComplete == 1;
                        uiStaticParameter.isShowFlyShoes = isComplete;
                        self:RefreshPathFindAndFlyShoeSign();
                    end
                end
            end

            if (not uiStaticParameter.isShowQianZhiHe) then
                if (CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId() == msgData.tableId) then
                    --local isComplete = msgData.isComplete == 1;
                    if (isComplete ~= uiStaticParameter.isShowQianZhiHe) then
                        uiStaticParameter.isShowQianZhiHe = isComplete;
                        self:RefreshPathFindAndFlyShoeSign();
                    end
                end
            end
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResCheckPreTaskIsCompleteMessage, UIFlyShoesPanel.CallOnResCheckPreTaskIsCompleteMessage)
end

---初始化状态
function UIFlyShoesPanel:InitializeState()
    self:RefreshPathFindAndFlyShoeSign()
    self:RefreshAutoFightSign()
    self:RefreshAutoPausedSign()
end

function UIFlyShoesPanel:Show()
    self:LoadEffects()
end

---加载特效到各个物体下
function UIFlyShoesPanel:LoadEffects()
    --self:LoadRes("700039", "mAutoFightEffect", self.mAutoFight_GameObject.transform)
    self:LoadRes("800009", "mAutoFindEffect", self.mFlyShoes_GameObject.transform)
    --self:LoadRes("700025", "mChooseRoleEffect", self.mAutoFind_GameObject.transform)
    --self.mAutoPaused_Anim.namePrefix = 'autostop'
    self.mAutoFind_Anim.namePrefix = 'autofind'
    self.mAutoFight_Anim.namePrefix = 'autofight'
    self:InitQianZhiHeEffect()
end

---加载资源
---@param resName string 资源名
---@param paramName string 变量名
---@param parentTrans UnityEngine.Transform 父物体
function UIFlyShoesPanel:LoadRes(resName, paramName, parentTrans)
    if paramName == nil or resName == nil then
        return
    end
    ---@type UnityEngine.GameObject
    local currentGO = self[paramName]
    if currentGO and CS.StaticUtility.IsNull(currentGO) == false then
        currentGO.transform:SetParent(parentTrans)
        return
    end
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(resName, CS.ResourceType.UIEffect, function(res)
        if self and CS.StaticUtility.IsNull(self.go) == false and res and res.MirrorObj then
            local go = res:GetObjInst()
            self[paramName] = go
            if go then
                go.transform.parent = parentTrans
                go.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
                go.transform.localPosition = CS.UnityEngine.Vector3.zero
            end
        end
    end, CS.ResourceAssistType.UI)
end
--endregion

--region 回调
---自动战斗变化回调
function UIFlyShoesPanel.OnAutoFightStateChange(id, data)
    UIFlyShoesPanel:RefreshAutoFightSign()
    UIFlyShoesPanel:RefreshGatherStateSign()
end

---寻路状态变化回调
function UIFlyShoesPanel.OnAutoPathFindStateChanged(id)
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
    UIFlyShoesPanel:RefreshGatherStateSign()
end

---寻路点在客户端视野范围内状态变化事件
function UIFlyShoesPanel.OnPathFindTargetInClientViewStateChanged()
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign(true)
end

---采集状态变化事件
function UIFlyShoesPanel.OnGatherStateChanged()
    UIFlyShoesPanel:RefreshGatherStateSign()
end

---背包变动事件
function UIFlyShoesPanel.OnBagItemChangeCallBack()
    if UIFlyShoesPanel.mFlyShoeStateCache then
        UIFlyShoesPanel.RefreshFlyShoesBG()
    elseif UIFlyShoesPanel.mQianZhiHeStateCache then
        UIFlyShoesPanel.RefreshQianZhiHeBG()
    end
end

---自动暂停状态变化事件
function UIFlyShoesPanel.OnAutoPausedStateChanged()
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
    UIFlyShoesPanel:RefreshAutoFightSign()
    UIFlyShoesPanel:RefreshAutoPausedSign()
    UIFlyShoesPanel:RefreshGatherStateSign()
end

---地图加载完毕事件
function UIFlyShoesPanel.OnRefreshFlyShoesStateMsgReceived()
    --print("OnRefreshFlyShoesStateMsgReceived");
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
end

---地图加载完毕事件
function UIFlyShoesPanel.OnMapProcessAfterLoaded()
    --print("OnMapProcessAfterLoaded");
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
end

---点击小飞鞋回调
function UIFlyShoesPanel.OnClickFlyShoes()
    UIFlyShoesPanel:TryUseFlyShoes()
end
--endregion

--region 刷新小飞鞋状态
---刷新寻路和小飞鞋标识
---@param isNeedShowFlyShoeBlock boolean|nil 是否需要显示小飞鞋遮罩一段时间
---@return boolean 是否显示寻路标识
function UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign(isNeedShowFlyShoeBlock)
    if CS.CSPathFinderManager.Instance == nil then
        return false
    end

    ---行会押镖
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.DartCarFindPathOperation.IsOn == true then
        if CS.CSScene.MainPlayerInfo.UnionDartCarInfo.InUnionDartCarRange == true then
            UIFlyShoesPanel.mAutoFind_GameObject:SetActive(false)
            luaclass.UIRefresh:RefreshActive(self:GetInDartCarRange(), true)

        else
            UIFlyShoesPanel.mAutoFind_GameObject:SetActive(true)
            luaclass.UIRefresh:RefreshActive(self:GetInDartCarRange(), false)
        end
        return
    else
        luaclass.UIRefresh:RefreshActive(self:GetInDartCarRange(), false)
    end

    local isAutoFind = CS.CSPathFinderManager.Instance.IsPathFinding
    if (CS.CSAutoPauseMgr.Instance ~= nil and CS.CSAutoPauseMgr.Instance.IsAutoPaused) then
        isAutoFind = false
    end

    ---白日门押镖
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation.IsOn == true then
        isAutoFind = true
    end

    local isFlyShoes = isAutoFind and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level >= UIFlyShoesPanel.mFlyLevelLimit and UIFlyShoesPanel.IsFlyShoeEnabled()
    if UIFlyShoesPanel.mAutoFind_GameObject ~= nil and CS.StaticUtility.IsNull(UIFlyShoesPanel.mAutoFind_GameObject) == false and self:ControlAutoFind() == true then
        UIFlyShoesPanel.mAutoFind_GameObject:SetActive(isAutoFind)
    end
    if UIFlyShoesPanel.mFlyShoes_GameObject ~= nil and CS.StaticUtility.IsNull(UIFlyShoesPanel.mFlyShoes_GameObject) == false then
        UIFlyShoesPanel.mFlyShoes_GameObject:SetActive(isFlyShoes)
    end
    if isNeedShowFlyShoeBlock == true and self.mFlyShoeStateCache ~= isFlyShoes and isFlyShoes == false then
        self:ShowFlyShoeBlockForAWhile(1000)
    else
        self:CloseFlyShoeBlock()
    end
    self.mFlyShoeStateCache = isFlyShoes
    if isFlyShoes then
        UIFlyShoesPanel.RefreshFlyShoesBG()
    end
    self:RefreshQianZhiHeState()
    return isAutoFind
end

---是否显示自动寻路
function UIFlyShoesPanel:ControlAutoFind()
    local pathFindType = CS.CSPathFinderManager.Instance.AutoPathFindType
    --if pathFindType == CS.EAutoPathFindType.DartCar_TowardPoint then
    --    return false
    --end
    return true
end

---判断小飞鞋是否可用
---@return boolean
function UIFlyShoesPanel.IsFlyShoeEnabled()
    if (not uiStaticParameter.isShowFlyShoes) then
        networkRequest.ReqCheckPreTaskIsComplete(CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId(), CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId());
        return false;
    end

    ---目标点或传送目标点在客户端视野范围内时,不显示小飞鞋(该需求暂时不需要)
    local isTargetInViewRange = CS.CSPathFinderManager.Instance.IsTargetInClientViewRange or CS.CSPathFinderManager.Instance.IsDeliverTargetInClientViewRange
    local pathFindType = CS.CSPathFinderManager.Instance.AutoPathFindType;
    local pathSourceType = CS.CSPathFinderManager.Instance.SourceSystemType;
    local destMapID = CS.CSPathFinderManager.Instance.DestinationMapID
    local currentPlayerMapID = CS.CSScene.getMapID()
    if UIFlyShoesPanel.GetIsFlyShoeForbiddenInThisPathFind(currentPlayerMapID, destMapID) then
        return false
    end
    ---是否在目标地图
    local isAtDestMap = CS.CSAstar_Scene.IsSameMapReally(destMapID, currentPlayerMapID)
    if pathFindType == CS.EAutoPathFindType.Normal_TowardPoint then
        ---正常寻路不显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Normal_TowardNPC then
        ---寻路npc不显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Normal_TowardBooth then
        ---走向摊位不显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.AutoFight_FindNextMonsterPoint then
        ---自动战斗寻找下一个怪点不显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Mission_FindMonsterPoint then
        ---同地图的情况下非日常任务寻找怪点不显示小飞鞋,不同地图的情况下任务寻找怪点显示小飞鞋
        return isAtDestMap == false
    end
    if pathFindType == CS.EAutoPathFindType.Mission_FindDailyTaskTargetPoint then
        ---日常任务寻找目标点,若不在目标地图,则显示小飞鞋,若在目标地图,则只有非挖肉/挖尸体任务才显示小飞鞋
        if isAtDestMap then
            local currentTask = CS.CSMissionManager.Instance.CurrentTask
            if currentTask ~= nil and currentTask.GatherIDList.Count > 0 then
                for i = 0, currentTask.GatherIDList.Count - 1 do
                    local gatherID = currentTask.GatherIDList[i]
                    local gatherTbl
                    ___, gatherTbl = CS.Cfg_GatherTableManager.Instance:TryGetValue(gatherID)
                    if gatherTbl then
                        local gatherType = gatherTbl.gatherType
                        if gatherType ~= 1 and gatherType ~= 2 then
                            return true
                        end
                    end
                end
            end
            return false
        end
    end
    if pathFindType == CS.EAutoPathFindType.Chat_MoveToCoordinate then
        ---聊天移动不显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Normal_GoForKillMonster then
        ---正常前往杀怪点杀指定怪时,若在目标地图则不显示小飞鞋
        return isAtDestMap == false
    end
    if pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinate then
        --luaDebug.Log("IsFlyShoesAvailable")
        return false
        --return CS.CSScene.MainPlayerInfo.AsyncOperationController.ChatPanelFindPlayerCoordinateOperation:IsFlyShoesAvailable()
    end
    if pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinateMapNPC then
        ---聊天界面点击其他玩家分享的坐标寻路时,若需要前往NPC,则显示小飞鞋
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Union_FindNPC then
        ---帮会寻找NPC显示小飞鞋
        return true
    end
    if pathFindType == CS.EAutoPathFindType.ServantPractice_FindServantPoint then
        ---灵兽修炼被攻击寻找灵兽位置
        return false
    end
    if pathFindType == CS.EAutoPathFindType.Arrest_FindPoint then
        ---悬赏寻路点显示小飞鞋(特殊处理下,目标点在视野内时不显示小飞鞋)
        if isTargetInViewRange then
            return false
        end
        ---若deliver表对应的表数据中的toMapID对应的map表的announceDeliverID与当前地图表数据的announceDeliverID一致,则认为是同一个副本,不显示小飞鞋
        ---@type TABLE.CFG_MAP
        local currentMapTbl
        ___, currentMapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(currentPlayerMapID)
        ---@type TABLE.CFG_MAP
        local targetMapTbl
        ___, targetMapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(destMapID)
        if currentMapTbl ~= nil and targetMapTbl ~= nil and currentMapTbl.announceDeliver == targetMapTbl.announceDeliver then
            return false
        end
        return true
    end
    if pathFindType == CS.EAutoPathFindType.BaiRiMenDartCar_TowardPoint then
        ---白日门押镖显示小飞鞋
        return true
    end
    if pathFindType == CS.EAutoPathFindType.UnionRevenge_FindPath then
        ---正常寻路不显示小飞鞋
        return false
    end
    return pathFindType ~= CS.EAutoPathFindType.Undefined
end

---显示小飞鞋Block一段时间
---@param timeInterval number 小飞鞋临时显示的时间(毫秒)
function UIFlyShoesPanel:ShowFlyShoeBlockForAWhile(timeInterval)
    if self.mCloseFlyShoeBlockFunc == nil then
        self.mCloseFlyShoeBlockFunc = function(data)
            if self ~= nil and CS.StaticUtility.IsNull(self.go) == false and self.mFlyShoes_BlockGameObject ~= nil or CS.StaticUtility.IsNull(self.mFlyShoes_BlockGameObject) == false then
                self.mFlyShoes_BlockGameObject:SetActive(false)
            end
        end
    end
    if self.mCloseFlyShoeBlockUpdateItem == nil then
        self.mCloseFlyShoeBlockUpdateItem = CS.CSListUpdateMgr.Add(timeInterval, nil, self.mCloseFlyShoeBlockFunc, false)
    else
        CS.CSListUpdateMgr.Instance:Remove(self.mCloseFlyShoeBlockUpdateItem)
        self.mCloseFlyShoeBlockUpdateItem.timeDelay = timeInterval
        CS.CSListUpdateMgr.Instance:Add(self.mCloseFlyShoeBlockUpdateItem)
    end
    if self.mFlyShoes_BlockGameObject ~= nil or CS.StaticUtility.IsNull(self.mFlyShoes_BlockGameObject) == false then
        self.mFlyShoes_BlockGameObject:SetActive(true)
    end
end

---关闭小飞鞋Block
function UIFlyShoesPanel:CloseFlyShoeBlock()
    if self.mCloseFlyShoeBlockUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.mCloseFlyShoeBlockUpdateItem)
    end
    if self.mFlyShoes_BlockGameObject ~= nil and CS.StaticUtility.IsNull(self.mFlyShoes_BlockGameObject) == false then
        self.mFlyShoes_BlockGameObject:SetActive(false)
    end
end

---小飞鞋在本次寻路中是否禁止显示
---@param currentMapID number
---@param targetMapID number
---@return boolean
function UIFlyShoesPanel.GetIsFlyShoeForbiddenInThisPathFind(currentMapID, targetMapID)
    if UIFlyShoesPanel.mForbiddenShowFlyShoeMaps == nil then
        UIFlyShoesPanel.mForbiddenShowFlyShoeMaps = {}
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22740)
        if tbl and tbl.value then
            local strs = string.Split(tbl.value, '#')
            if strs then
                for i = 1, #strs do
                    local mapID = tonumber(strs[i])
                    table.insert(UIFlyShoesPanel.mForbiddenShowFlyShoeMaps, mapID)
                end
            end
        end
    end
    local isCurrentInForbiddenMaps = false
    local isTargetInForbiddenMaps = false
    for i = 1, #UIFlyShoesPanel.mForbiddenShowFlyShoeMaps do
        local temp = UIFlyShoesPanel.mForbiddenShowFlyShoeMaps[i]
        if temp == currentMapID then
            isCurrentInForbiddenMaps = true
        end
        if temp == targetMapID then
            isTargetInForbiddenMaps = true
        end
    end
    return isCurrentInForbiddenMaps and isTargetInForbiddenMaps
end
--endregion

--region 刷新自动战斗状态
---刷新自动战斗标识状态
---@return boolean 是否显示标识
function UIFlyShoesPanel:RefreshAutoFightSign()
    if CS.CSAutoFightMgr.Instance == nil then
        self.mAutoFight_GameObject:SetActive(false)
        return false
    end
    if CS.CSAutoPauseMgr.Instance ~= nil and CS.CSAutoPauseMgr.Instance.IsAutoPaused then
        self.mAutoFight_GameObject:SetActive(false)
        return false
    end
    if CS.StaticUtility.IsNull(self.mAutoFight_GameObject) == false then
        self.mAutoFight_GameObject:SetActive(CS.CSAutoFightMgr.Instance.IsOn)
    end
end
--endregion

--region 刷新自动暂停状态
---刷新自动暂停标识状态
---@return boolean 是否显示标识
function UIFlyShoesPanel:RefreshAutoPausedSign()
    if CS.CSAutoPauseMgr.Instance == nil then
        self.mAutoPaused_GameObject:SetActive(false)
        return false
    end
    if CS.StaticUtility.IsNull(self.mAutoPaused_GameObject) == false then
        self.mAutoPaused_GameObject:SetActive(CS.CSAutoPauseMgr.Instance.IsAutoPaused)
    end
end
--endregion

--region 刷新采集状态标识
---刷新采集状态标识
---@return boolean 是否显示标识
function UIFlyShoesPanel:RefreshGatherStateSign()
    local isDigTreasure  = false
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Owner.FSM.CurrentState == CS.EFSMState.DigTreasure then
        isDigTreasure = true
    end
    if not isDigTreasure then
        ---不显示采集状态标识
        if (CS.CSAutoPauseMgr.Instance ~= nil and CS.CSAutoPauseMgr.Instance.IsAutoPaused)
                or (CS.CSPathFinderManager.Instance ~= nil and CS.CSPathFinderManager.Instance.IsPathFinding)
                or (CS.CSAutoFightMgr.Instance ~= nil and CS.CSAutoFightMgr.Instance.IsOn) or CS.CSScene.Sington == nil or CS.CSScene.Sington.GatherController.IsGathering == false then
            --if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoFishingEffectGO()) == false then
            --    UIFlyShoesPanel.GetAutoFishingEffectGO():SetActive(false)
            --end
            --if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherEffectGO()) == false then
            --    UIFlyShoesPanel.GetAutoGatherEffectGO():SetActive(false)
            --end
            --if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoMiningEffectGO()) == false then
            --    UIFlyShoesPanel.GetAutoMiningEffectGO():SetActive(false)
            --end
            --if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoWashiEffectGO()) == false then
            --    UIFlyShoesPanel.GetAutoWashiEffectGO():SetActive(false)
            --end
            if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherSignController()) == false then
                UIFlyShoesPanel.GetAutoGatherSignController():ClearSign()
            end
            return false
        end
    end
    ---显示采集状态标识,对采矿和钓鱼特殊处理
    local gatherType = CS.CSScene.Sington.GatherController.CurrentGatherType
    if isDigTreasure then
        gatherType = CS.EGatherType.DigTreasure
    end
    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherSignController()) == false then
        UIFlyShoesPanel.GetAutoGatherSignController():RefreshSign(gatherType)
    end
    --if gatherType == CS.EGatherType.Mining or gatherType == CS.EGatherType.HideMinning then
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoFishingEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoFishingEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoGatherEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoMiningEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoMiningEffectGO():SetActive(true)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoWashiEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoWashiEffectGO():SetActive(false)
    --    end
    --elseif gatherType == CS.EGatherType.Fishing then
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoFishingEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoFishingEffectGO():SetActive(true)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoGatherEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoMiningEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoMiningEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoWashiEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoWashiEffectGO():SetActive(false)
    --    end
    --else
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoFishingEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoFishingEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoGatherEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoGatherEffectGO():SetActive(true)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoMiningEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoMiningEffectGO():SetActive(false)
    --    end
    --    if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetAutoWashiEffectGO()) == false then
    --        UIFlyShoesPanel.GetAutoWashiEffectGO():SetActive(false)
    --    end
    --end
end
--endregion

--region 千纸鹤
UIFlyShoesPanel.mQianZhiHeCostItemCount = 1
UIFlyShoesPanel.mQianZhiHeCostItemID = 6000010

---初始化千纸鹤
function UIFlyShoesPanel:InitQianZhiHeEffect()
    self:LoadRes("700222", "mAutoFindQianZhiHeEffect", self.mQianZhiHe_GameObject.transform)
end

---刷新显示千纸鹤
function UIFlyShoesPanel:RefreshQianZhiHeState()
    local isAutoFind = CS.CSPathFinderManager.Instance.IsPathFinding
    local isShowQianZhiHe = isAutoFind and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level >= UIFlyShoesPanel.mFlyLevelLimit and self:IsQianZhiHeEnabled()
    if UIFlyShoesPanel.mQianZhiHe_GameObject ~= nil and CS.StaticUtility.IsNull(UIFlyShoesPanel.mQianZhiHe_GameObject) == false then
        UIFlyShoesPanel.mQianZhiHe_GameObject:SetActive(isShowQianZhiHe)
    end
    if not (isNeedShowFlyShoeBlock == true and self.mQianZhiHeStateCache ~= isShowQianZhiHe and isShowQianZhiHe == false) then
        self:CloseFlyShoeBlock()
    end
    self.mQianZhiHeStateCache = isShowQianZhiHe
    if isShowQianZhiHe then
        UIFlyShoesPanel.RefreshQianZhiHeBG()
    end
end

---是否显示千纸鹤
function UIFlyShoesPanel:IsQianZhiHeEnabled()
    if self.mFlyShoeStateCache then
        return false
    end
    if (not uiStaticParameter.isShowQianZhiHe) then
        networkRequest.ReqCheckPreTaskIsComplete(CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId(), CS.Cfg_GlobalTableManager.Instance:GetFlyShoesPreTaskId());
        return false;
    end
    local pathFindType = CS.CSPathFinderManager.Instance.AutoPathFindType;
    local targetMapID = CS.CSPathFinderManager.Instance.DestinationMapID
    local currentMapID = CS.CSScene.getMapID()
    if UIFlyShoesPanel.GetIsQianZhiHeForbiddenInThisPathFind(currentMapID, targetMapID) then
        return false
    end
    return pathFindType == CS.EAutoPathFindType.Chat_MoveToCoordinate or
            pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinate or
            pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinateMapNPC or
            pathFindType == CS.EAutoPathFindType.ServantPractice_FindServantPoint or
            pathFindType == CS.EAutoPathFindType.UnionRevenge_FindPath
end

---刷新千纸鹤背景
function UIFlyShoesPanel.RefreshQianZhiHeBG()
    if not UIFlyShoesPanel.IsQianZhiHeCostEnough() then
        UIFlyShoesPanel.GetQianZhiHeHighly_GameObject():SetActive(false)
        UIFlyShoesPanel.GetQianZhiHeBottomEffect_GameObject():SetActive(false)
    else
        UIFlyShoesPanel.GetQianZhiHeHighly_GameObject():SetActive(true)
        UIFlyShoesPanel.GetQianZhiHeBottomEffect_GameObject():SetActive(true)
    end
end

---点击千纸鹤
function UIFlyShoesPanel.OnClickQianZhiHe()
    UIFlyShoesPanel:TryUseQianZhiHe()
end

---尝试使用千纸鹤
function UIFlyShoesPanel:TryUseQianZhiHe()
    ---检查千纸鹤使用等级
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level < UIFlyShoesPanel.mFlyLevelLimit then
        UIFlyShoesPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_MiddleTips, tostring(UIFlyShoesPanel.mFlyLevelLimit) .. "级开启千纸鹤传送")
        return
    end
    if (UIFlyShoesPanel.IsQianZhiHeCostEnough()) then
        self:UseQianZhiHeFly()
    else

        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(UIFlyShoesPanel.mQianZhiHeCostItemID, function(storeVo)
            if (storeVo ~= nil) then
                uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } });
            else
                uimanager:CreatePanel("UIShopPanel");
            end
        end);

        Utility.TransferShopChooseItem()
        --local TipData = {}
        --TipData.PromptWordId = 96
        --TipData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(96)
        --TipData.ComfireAucion = function()
        --    CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(6000008, function(storeVo)
        --        if (storeVo ~= nil) then
        --            uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } });
        --        else
        --            uimanager:CreatePanel("UIShopPanel");
        --        end
        --    end);
        --end
        --Utility.ShowSecondConfirmPanel(TipData)
    end
end

function UIFlyShoesPanel:UseQianZhiHeFly()
    if CS.CSPathFinderManager.Instance == nil then
        return
    end
    local findPathQianZhiHeInfo = CS.CSPathFinderManager.Instance.CurChatFindPathQianZhiHeInfo
    if findPathQianZhiHeInfo == nil then
        return
    end
    if self:CanUseQianZhiHe(findPathQianZhiHeInfo.mapId) == false then
        return
    end

    local AimMapId = findPathQianZhiHeInfo.mapId
    local AimPosX = findPathQianZhiHeInfo.dot.x
    local AimPosY = findPathQianZhiHeInfo.dot.y

    -----如果为恶魔广场地图且剩余时间为0时传送到npc旁边
    --if LuaGlobalTableDeal.IsEMGCMap(findPathQianZhiHeInfo.mapId) and uiStaticParameter.DevilRemaining == 0 then
    --    local res, deliverInfo = CS.Cfg_DeliverTableManager.Instance.dic:TryGetValue(1017)
    --    if res then
    --        AimPosX = deliverInfo.x
    --        AimPosY = deliverInfo.y
    --        AimMapId = deliverInfo.toMapId
    --    end
    --    networkRequest.ReqPaperCraneDelivery(AimMapId, AimPosX, AimPosY, findPathQianZhiHeInfo.line)
    --    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ deliverInfo.toNpcId }, "UIDevilSquarePanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, nil)
    --    return
    --end

    networkRequest.ReqPaperCraneDelivery(AimMapId, AimPosX, AimPosY, findPathQianZhiHeInfo.line)
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
        if CS.CSPathFinderManager.Instance ~= nil
                and (CS.CSPathFinderManager.Instance.AutoPathFindType == CS.EAutoPathFindType.Chat_MoveToCoordinate or
                CS.CSPathFinderManager.Instance.AutoPathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinate or
                CS.CSPathFinderManager.Instance.AutoPathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinateMapNPC) then
            --关闭自动寻路
            CS.CSPathFinderManager.Instance:Reset(true, false)
            CS.CSScene.Sington.MainPlayer:Stop();
        end
    end
end

---@return boolean 是否可以使用千纸鹤
function UIFlyShoesPanel:CanUseQianZhiHe(mapId)
    if Utility.CanEnterAncientBattlefileldMap(mapId) == false then
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Role_Prefix)
        return false
    end

    return true
end

---千纸鹤消耗是否够用
---@return boolean 千纸鹤花费的道具是否够用
function UIFlyShoesPanel.IsQianZhiHeCostEnough()

    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return false
    end
    return CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIFlyShoesPanel.mQianZhiHeCostItemID) >= UIFlyShoesPanel.mQianZhiHeCostItemCount
end

---千纸鹤在本次寻路中是否禁止显示
---@param currentMapID number
---@param targetMapID number
---@return boolean
function UIFlyShoesPanel.GetIsQianZhiHeForbiddenInThisPathFind(currentMapID, targetMapID)
    if UIFlyShoesPanel.mForbiddenShowQianZhiHeMaps == nil then
        UIFlyShoesPanel.mForbiddenShowQianZhiHeMaps = {}
        local tblExist, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22747)
        if tbl and tbl.value then
            local strs = string.Split(tbl.value, '#')
            if strs then
                for i = 1, #strs do
                    local mapID = tonumber(strs[i])
                    table.insert(UIFlyShoesPanel.mForbiddenShowQianZhiHeMaps, mapID)
                end
            end
        end
    end
    local isCurrentInForbiddenMaps = false
    local isTargetInForbiddenMaps = false
    for i = 1, #UIFlyShoesPanel.mForbiddenShowQianZhiHeMaps do
        local temp = UIFlyShoesPanel.mForbiddenShowQianZhiHeMaps[i]
        if temp == currentMapID then
            isCurrentInForbiddenMaps = true
        end
        if temp == targetMapID then
            isTargetInForbiddenMaps = true
        end
    end
    return isCurrentInForbiddenMaps and isTargetInForbiddenMaps
end
--endregion

--region 检查需要消耗的道具是否够用
---小飞鞋消耗是否够用
---@return boolean 小飞鞋花费的道具是否够用
function UIFlyShoesPanel.IsFlyShoeCostEnough()
    local pathFindType = CS.CSPathFinderManager.Instance.AutoPathFindType
    local sourceSystemType = CS.CSPathFinderManager.Instance.SourceSystemType
    local isNeedProp, flyShoeCostItemID, flyShoeCostItemCount = UIFlyShoesPanel.GetFlyShoeTransferCost(sourceSystemType, pathFindType)
    if isNeedProp then
        if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
            return false
        end
        return CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(flyShoeCostItemID) >= flyShoeCostItemCount
    end
    return true
end

---获取小飞鞋传送消耗的道具及其数量
---@param sourceSystemType EAutoPathFindSourceSystemType 寻路源系统类型
---@param pathFindType EAutoPathFindType 寻路类型
---@return boolean,number,number 是否可以需要消耗道具/消耗的道具ID/消耗的道具数量
function UIFlyShoesPanel.GetFlyShoeTransferCost(sourceSystemType, pathFindType)
    if sourceSystemType == CS.EAutoPathFindSourceSystemType.Mission then
        return CS.Cfg_GlobalTableManager.Instance:GetTaskFlyShoesPropConsume()
    else
        return CS.Cfg_GlobalTableManager.Instance:GetMinMapTransferFlyShoesPropConsume()
    end
end

---刷新小飞鞋背景
---@private
function UIFlyShoesPanel.RefreshFlyShoesBG()
    if not UIFlyShoesPanel.IsFlyShoeCostEnough() then
        if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetFlyShoeHighly_GameObject()) == false then
            UIFlyShoesPanel.GetFlyShoeHighly_GameObject():SetActive(false)
        end
        if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetFlyShoeBottomEffect_GameObject()) == false then
            UIFlyShoesPanel.GetFlyShoeBottomEffect_GameObject():SetActive(false)
        end
    else
        if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetFlyShoeHighly_GameObject()) == false then
            UIFlyShoesPanel.GetFlyShoeHighly_GameObject():SetActive(true)
        end
        if CS.StaticUtility.IsNull(UIFlyShoesPanel.GetFlyShoeBottomEffect_GameObject()) == false then
            UIFlyShoesPanel.GetFlyShoeBottomEffect_GameObject():SetActive(true)
        end
    end
end

---刷新在行会镖车附近状态
function UIFlyShoesPanel.RefreshInUnionDartCarRangeState(msgId, data)
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
end
--endregion

--region    挖宝刷新
function UIFlyShoesPanel.RefreshForDigTreasure(msgId, tblData, csData)
    UIFlyShoesPanel:RefreshPathFindAndFlyShoeSign()
    UIFlyShoesPanel:RefreshAutoFightSign()
    UIFlyShoesPanel:RefreshAutoPausedSign()
    UIFlyShoesPanel:RefreshGatherStateSign()
end
--endregion

--region 使用小飞鞋
---尝试使用小飞鞋
---@public
function UIFlyShoesPanel:TryUseFlyShoes()
    ---检查小飞鞋使用等级
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.Level < UIFlyShoesPanel.mFlyLevelLimit then
        UIFlyShoesPanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_MiddleTips, tostring(UIFlyShoesPanel.mFlyLevelLimit) .. "级开启小飞鞋传送")
        return
    end
    if (UIFlyShoesPanel.IsFlyShoeCostEnough()) then
        self:Fly()
    else
        local TipData = {}
        TipData.PromptWordId = 96
        TipData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(96)
        TipData.ComfireAucion = function()
            CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfoWithItemId(6000008, function(storeVo)
                if (storeVo ~= nil) then
                    uimanager:CreatePanel("UIShopPanel", nil, { type = storeVo.storeTable.sellId, chooseStore = { storeVo.storeId } });
                else
                    uimanager:CreatePanel("UIShopPanel");
                end
            end);
        end
        Utility.ShowSecondConfirmPanel(TipData)
    end
end

---执行小飞鞋传送
---@private
function UIFlyShoesPanel:Fly()
    local pathFindType = CS.CSPathFinderManager.Instance.AutoPathFindType
    local pathFindSourceSystemType = CS.CSPathFinderManager.Instance.SourceSystemType
    local pathFindParam = CS.CSPathFinderManager.Instance.AutoPathFindParams
    ---从寻路参数中尝试获取寻路的npcID和DeliverID
    local npcID = CS.CSPathFinderManager.Instance.NPCID
    local deliverID = CS.CSPathFinderManager.Instance.DeliverID
    local targetMapID = CS.CSPathFinderManager.Instance.DestinationMapID
    local targetCoordinate = CS.CSPathFinderManager.Instance.DestinationCoordinate
    if (pathFindType == CS.EAutoPathFindType.Normal_TowardNPC
            or pathFindType == CS.EAutoPathFindType.Duplicate_FindNPC
            or pathFindType == CS.EAutoPathFindType.Mission_FindNPC
            or pathFindType == CS.EAutoPathFindType.Calendar_FindNPC
            or pathFindType == CS.EAutoPathFindType.PassCheck_FindNPC
            or pathFindType == CS.EAutoPathFindType.Boss_FightWithEliteBoss
            or pathFindType == CS.EAutoPathFindType.Boss_FightWithAncientBoss
            or pathFindType == CS.EAutoPathFindType.Boss_FindTransferMan
            or pathFindType == CS.EAutoPathFindType.DailyTask_FindRecommend
            or pathFindType == CS.EAutoPathFindType.Active_FindNPC
            or pathFindType == CS.EAutoPathFindType.ChatPanel_FindNPC
            or pathFindType == CS.EAutoPathFindType.Normal_GoForKillMonster
            or pathFindType == CS.EAutoPathFindType.Relationwords_Rescue
            or pathFindType == CS.EAutoPathFindType.ItemGetWayFindTarget
            or pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinateMapNPC
            or pathFindType == CS.EAutoPathFindType.ItemObtain_Dig
            or pathFindType == CS.EAutoPathFindType.ItemObtain_KillMonster
            or pathFindType == CS.EAutoPathFindType.ItemObtain_OpenNormalNPCPanel
            or pathFindType == CS.EAutoPathFindType.ItemObtain_OpenGeneralNPCPanel
            or pathFindType == CS.EAutoPathFindType.ItemObtain_MiningOrFishing
            or pathFindType == CS.EAutoPathFindType.Union_FindNPC
            or pathFindType == CS.EAutoPathFindType.Arrest_FindPoint
    ) and deliverID ~= 0 then
        networkRequest.ReqMinMapDeliver(deliverID)
    elseif pathFindType == CS.EAutoPathFindType.Chat_MoveToPlayerSharedCoordinate or pathFindType == CS.EAutoPathFindType.ServantPractice_FindServantPoint then
        ---@type TABLE.CFG_MAP
        local destMapTbl
        ___, destMapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(targetMapID)
        if destMapTbl ~= nil then
            if destMapTbl.isTransmit == 1 then
                ---传坐标
                CS.CSScene.MainPlayerInfo.AsyncOperationController.ChatPanelFindPlayerCoordinateOperation.IsDeliverProcessed = true
                self:RefreshPathFindAndFlyShoeSign(true)
                networkRequest.ReqLocationDelivery(targetMapID, targetCoordinate.x, targetCoordinate.y)
            elseif destMapTbl.isTransmit == 2 then
                ---传deliver
                if deliverID ~= 0 then
                    networkRequest.ReqMinMapDeliver(deliverID)
                end
            end
        elseif deliverID ~= 0 then
            networkRequest.ReqMinMapDeliver(deliverID)
        end
    elseif pathFindType == CS.EAutoPathFindType.PersonDartCar_TowardPoint then
        networkRequest.ReqFlyToDynamicGoal(1, CS.CSScene.MainPlayerInfo.AsyncOperationController.PersonDartCarFindPathOperation.dartCarLid)
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PersonDartCarFindPathOperation:StopOperation()
    elseif pathFindType == CS.EAutoPathFindType.SealTowerFindPath then
        networkRequest.ReqFlyToDynamicGoal(3, CS.CSScene.MainPlayerInfo.AsyncOperationController.SealTowerFindPathOperation.monsterLid, CS.CSScene.MainPlayerInfo.AsyncOperationController.SealTowerFindPathOperation.curDot.x, CS.CSScene.MainPlayerInfo.AsyncOperationController.SealTowerFindPathOperation.curDot.y)
        CS.CSScene.MainPlayerInfo.AsyncOperationController.SealTowerFindPathOperation:StopOperation()
    elseif pathFindType == CS.EAutoPathFindType.DartCar_TowardPoint then
        networkRequest.ReqFlyToDynamicGoal(2)
    elseif pathFindType == CS.EAutoPathFindType.BaiRiMenDartCar_TowardPoint then
        networkRequest.ReqFlyToDynamicGoal(4, CS.CSScene.MainPlayerInfo.AsyncOperationController.BaiRiMenFindPathOperation.CarLid)
    else
        CS.CSMissionManager.Instance:TaskTransfer()
    end
    ---使用小飞鞋时,清空选择范围内随机点的标志位
    CS.CSPathFinderManager.Instance:ClearSelectRandomCoordInRange()
end
--endregion

--region 刷新挖掘排版
function UIFlyShoesPanel:RefreshGatherShow()
    self:GetGatherTable_UITable():Reposition()
end
--endregion

--region 析构
function ondestroy()
    if CS.StaticUtility.IsNull(CS.CSListUpdateMgr.Instance) == false then
        CS.CSListUpdateMgr.Instance:Remove(UIFlyShoesPanel.mCloseFlyShoeBlockUpdateItem)
    end
    UIFlyShoesPanel.mCloseFlyShoeBlockUpdateItem = nil
end
--endregion

--region 帧刷新/挖掘提示状态刷新
function update()
    if UIFlyShoesPanel:GetGatherHintTarget() then
        UIFlyShoesPanel:GetGatherHintTarget():OnUpdate()
    end
    if UIFlyShoesPanel:GetTrainingHintTarget() then
        UIFlyShoesPanel:GetTrainingHintTarget():OnUpdate()
    end
end

---刷新WidgetRoot激活状态
---@private
function UIFlyShoesPanel:RefreshWidgetRootActiveState(isShow)
    self:GetWidgetRootGO():SetActive(not isShow)
end
--endregion

return UIFlyShoesPanel