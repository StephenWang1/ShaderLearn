---主界面提示面板
---@class UIMainHintPanel:UIBase
local UIMainHintPanel = {}

---提示缓存
---@type table<number,{hintType:LuaEnumMainHintType,data:any}>
UIMainHintPanel.HintCache = {}

UIMainHintPanel.IsInitialLoad = true

--***************************************************************** 组件 *****************************************************************
---提示模板根节点
---@protected
---@return UnityEngine.GameObject
function UIMainHintPanel:GetTemplatesRoot()
    if self.mTemplatesRoot == nil then
        self.mTemplatesRoot = self:GetCurComp("HintTemplates", "GameObject")
    end
    return self.mTemplatesRoot
end

---右下锚点的模板
---@protected
---@return UnityEngine.GameObject
function UIMainHintPanel:GetTemplateGO_NormalRDAnchor()
    if self.mTemplateGO_NormalRDAnchor == nil then
        self.mTemplateGO_NormalRDAnchor = self:GetCurComp("HintTemplates/NormalRDAnchorHint", "GameObject")
    end
    return self.mTemplateGO_NormalRDAnchor
end

---右锚点的模板
---@protected
---@return UnityEngine.GameObject
function UIMainHintPanel:GetTemplateGO_NormalRAnchor()
    if self.mTemplateGO_NormalRAnchor == nil then
        self.mTemplateGO_NormalRAnchor = self:GetCurComp("HintTemplates/NormalRAnchorHint", "GameObject")
    end
    return self.mTemplateGO_NormalRAnchor
end

---左下锚点的模板
---@protected
---@return UnityEngine.GameObject
function UIMainHintPanel:GetTemplateGO_NormalLDAnchor()
    if self.mTemplateGO_NormalLDAnchor == nil then
        self.mTemplateGO_NormalLDAnchor = self:GetCurComp("HintTemplates/NormalLDAnchorHint", "GameObject")
    end
    return self.mTemplateGO_NormalLDAnchor
end

---更好的背包物品的模板
---@protected
---@return UnityEngine.GameObject
function UIMainHintPanel:GetTemplateGO_BetterBagItem()
    if self.mTemplateGO_BetterBagItem == nil then
        self.mTemplateGO_BetterBagItem = self:GetCurComp("HintTemplates/BetterBagItem", "GameObject")
    end
    return self.mTemplateGO_BetterBagItem
end

--***************************************************************** 属性 *****************************************************************
---大聚灵珠使用次数限制,0表示不限制
---@return number
function UIMainHintPanel:GetBigJuLingZhuMaxUseLimit()
    if self.mBigJuLingZhuUseLimit == nil then
        ---@type TABLE.CFG_ITEMS
        local tbl
        ___, tbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(8040007)
        if tbl then
            self.mBigJuLingZhuUseLimit = tbl.useLimit
        else
            self.mBigJuLingZhuUseLimit = 0
        end
    end
    return self.mBigJuLingZhuUseLimit
end

--***************************************************************** 初始化 *****************************************************************
---初始化
---@protected
function UIMainHintPanel:Init()
    uiStaticParameter.MainHintPanel = self
    --初始化时隐藏所有模板
    self:GetTemplatesRoot():SetActive(false)
    --绑定所有模板表和游戏物体
    self:RegisterTableAndGO()
    --绑定所有lua枚举和表
    self:RegisterLuaEnumToTable()
    --绑定消息
    self:BindMessages()
    --初始化参数
    self:InitParams()
end

---注册表和游戏物体的映射关系,新加的提示需要在这里注册模板类和其预设物体的关系,预设物体需要放在HintTemplates下
---@protected
function UIMainHintPanel:RegisterTableAndGO()
    ---@type table<UIBasicHint,UnityEngine.GameObject>
    self.mTableToGO = {}
    self.mTableToGO[luaComponentTemplates.UIMainHint_BetterBagItem] = self:GetCurComp("HintTemplates/BetterBagItem", "GameObject")
    self.mTableToGO[luaComponentTemplates.UIMainHint_RecycleBagItemTips] = self:GetCurComp("HintTemplates/NormalLDAnchorHint", "GameObject")
    self.mTableToGO[luaComponentTemplates.UIMainHint_SkillLearningAvailableTips] = self:GetCurComp("HintTemplates/NormalRAnchorHint", "GameObject")
    self.mTableToGO[luaComponentTemplates.UIMainHint_BetterBagItem_HighLv] = self:GetCurComp("HintTemplates/NormalLDAnchorHint", "GameObject")
    self.mTableToGO[luaComponentTemplates.UIMainHint_BigJuLingZhuRecommendBug] = self:GetCurComp("HintTemplates/NormalLDAnchorHint", "GameObject")
    self.mTableToGO[luaComponentTemplates.UIMainHint_SpecialBoxUseHint] = self:GetCurComp("HintTemplates/BetterBagItem", "GameObject")
end

---注册lua枚举和表之间的映射关系,新加的提示需要在这里注册枚举和模板类之间的关系
---@protected
function UIMainHintPanel:RegisterLuaEnumToTable()
    ---@type table<LuaEnumMainHintType,UIBasicHint>
    self.mLuaEnumToTable = {}
    self.mLuaEnumToTable[LuaEnumMainHintType.BetterBagItem] = luaComponentTemplates.UIMainHint_BetterBagItem
    self.mLuaEnumToTable[LuaEnumMainHintType.RecycleBagItemTips] = luaComponentTemplates.UIMainHint_RecycleBagItemTips
    self.mLuaEnumToTable[LuaEnumMainHintType.SkillLearningAvailableTips] = luaComponentTemplates.UIMainHint_SkillLearningAvailableTips
    self.mLuaEnumToTable[LuaEnumMainHintType.BetterBagItem_HighLv] = luaComponentTemplates.UIMainHint_BetterBagItem_HighLv
    self.mLuaEnumToTable[LuaEnumMainHintType.SpecialBoxUseHint] = luaComponentTemplates.UIMainHint_SpecialBoxUseHint
    --self.mLuaEnumToTable[LuaEnumMainHintType.BigJuLingZhuRecommendBuy] = luaComponentTemplates.UIMainHint_BigJuLingZhuRecommendBug
end

--***************************************************************** 重新显示 *****************************************************************
---重新显示提示界面
function UIMainHintPanel:ReShowSelf()
    self:RunBaseFunction("ReShowSelf")
    self:CheckOnReshown()
end

--***************************************************************** 显示提示 *****************************************************************
---在某位置创建提示
---@public
---@param mainHintType LuaEnumMainHintType 主界面提示类型
---@param position UnityEngine.Vector3 世界坐标,提示应在的位置
function UIMainHintPanel:CreateHintInPosition(mainHintType, position)
    position = CS.UIManager.Instance:GetUIRoot().transform:InverseTransformPoint(position)
    local table = self:GetTableTemplate(mainHintType, false)
    if table == nil then
        table = self:GetTableTemplate(mainHintType, true)
        if table then
            table:SetPosition(position)
            table:Close(false)
        end
    end
end

---在某物体上创建提示
---@public
---@param mainHintType LuaEnumMainHintType 主界面提示类型
---@param go UnityEngine.GameObject 需要绑定的物体
function UIMainHintPanel:CreateHintWithGameObject(mainHintType, go)
    local table = self:GetTableTemplate(mainHintType, true)
    if table then
        table:SetBindedGameObject(go)
        table:Close(false)
    end
end

---触发提示
---@public
---@param mainHintType LuaEnumMainHintType 主界面提示类型
---@vararg any
function UIMainHintPanel:TriggleHint(mainHintType, ...)
    if self.IsHiden then
        --print("触发提示加入缓存", mainHintType)
        --self.HintCache[mainHintType] = { ... }
        table.insert(self.HintCache, { hintType = mainHintType, data = { ... } })
        return
    end
    --print("触发提示", mainHintType)
    local table = self:GetTableTemplate(mainHintType, false)
    if table then
        table:RefreshPosition()
        table:Triggle()
    end
    self:OnHintTriggled(mainHintType)
    if table ~= nil and table:GetIsOn() then
        table:RefreshData(...)
    end
end

---判断提示是否存在(不考虑提示界面被整体隐藏的情况)
---@return boolean
function UIMainHintPanel:IsHintExist(mainHintType)
    if mainHintType then
        if self.mTables then
            local table = self.mTables[mainHintType]
            if table then
                return table:GetIsOn()
            end
        end
    end
    return false
end

---关闭所有提示
---@param withAnimation boolean 是否播放关闭动画
function UIMainHintPanel:CloseAllHint(withAnimation)
    if self and self.mTables then
        for i, v in pairs(self.mTables) do
            v:Close(withAnimation)
        end
    end
end

---关闭提示
---@public
---@param mainHintType LuaEnumMainHintType 主界面提示类型
---@param withAnimation boolean 是否播放关闭动画
function UIMainHintPanel:CloseHint(mainHintType, withAnimation)
    local table = self:GetTableTemplate(mainHintType, false)
    if table then
        if table:GetIsOn() then
            table:Close(withAnimation)
        end
    end
end

---获取提示类型对应的表模板
---@protected
---@param mainHintType LuaEnumMainHintType 主界面提示类型
---@param isCreateNewWhenNotFound boolean 为空时是否创建一个新对象
---@return UIBasicHint
function UIMainHintPanel:GetTableTemplate(mainHintType, isCreateNewWhenNotFound)
    if self.mTables == nil then
        ---@type table<LuaEnumMainHintType,UIBasicHint>
        self.mTables = {}
    end
    if isCreateNewWhenNotFound and self.mTables[mainHintType] == nil then
        if self.mLuaEnumToTable then
            local tableTemplate = self.mLuaEnumToTable[mainHintType]
            if tableTemplate and self.mTableToGO then
                local go = self.mTableToGO[tableTemplate]
                local rootTrans
                if CS.StaticUtility.IsNull(self.go) == false then
                    go:SetActive(true)
                    rootTrans = self.go.transform
                end
                local goTemp = CS.Utility_Lua.CopyGO(go, rootTrans)
                if CS.StaticUtility.IsNull(goTemp) == false then
                    local tableTemp = templatemanager.GetNewTemplate(goTemp, tableTemplate, UIMainHintPanel:GetClientEventHandler(), self)
                    self.mTables[mainHintType] = tableTemp
                end
            end
        end
    end
    return self.mTables[mainHintType]
end

--***************************************************************** 提示触发 *****************************************************************
function UIMainHintPanel:InitParams()
    ---回收提醒装备数量
    ---@type number
    self.mRecycleHintEquipCount = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintEquipCount()
    ---回收提醒空格数量
    ---@type number
    self.mRecycleHintEmptySlotCount = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintEmptySlotCount()
    ---最新的提示类型和提示状态类型(只针对更好物品的推送)
    self.hintType = LuaEnumMainHint_BetterBagItemType.None
    self.hintStateType = LuaEnumBetterItemHintStateType.NONE
end

---绑定消息
function UIMainHintPanel:BindMessages()
    ---接收到更好装备提示时触发一次更好装备提醒
    self:GetClientEventHandler():AddEvent(CS.CEvent.Add_EquipGoodHint, function(msgID, data)
        --print("接收到更好装备提示时触发一次更好装备提醒")
        self:OnEquipGoodHintReceived(data)
    end)
    ---接收到Lua更好装备提示时触发一次更好装备提醒
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Push_BetterItem,function(msgId,data)
        self:OnPushBetterItem(data)
    end)
    --self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel, function()
    --    self:RefreshBigJuLingZhuBuyHint()
    --end)
    ---接收到关闭更好装备提示时关闭更好装备提醒
    self:GetClientEventHandler():AddEvent(CS.CEvent.Close_EquipGoodHint, function()
        self:CloseHint(LuaEnumMainHintType.BetterBagItem)
    end)
    ---装备变化时触发一次满背包提醒
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_EquipUpdated, function()
        self:CheckIsNeedFullBagHint()
        --self:CheckIsSkillLearningAvailableHint()
    end)
    ---背包物品变化时触发一次满背包提醒(和一次技能可学提醒)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:CheckIsNeedFullBagHint()
        --self:CheckIsSkillLearningAvailableHint()
    end)
    ---角色VIP等级变化时触发一次满背包提醒
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateVip, function()
        local tbl = self:GetTableTemplate(LuaEnumMainHintType.RecycleBagItemTips, false)
        if tbl ~= nil and tbl:GetIsOn() then
            self:CheckIsNeedFullBagHint()
        end
    end)
    ---身上装备变化事件
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_EquipUpdated, function()
        self:RefreshSpecialBoxHint()
    end)
    ---角色等级变化事件
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshSpecialBoxHint()
    end)
    ---第一次进入地图时触发一次满背包提醒
    local mapLoadedFunction
    mapLoadedFunction = function()
        self:CheckIsNeedFullBagHint()
        --self:RefreshBigJuLingZhuBuyHint()
        self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_MapProcessAfterLoaded, mapLoadedFunction)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MapProcessAfterLoaded, mapLoadedFunction)
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint.hintOnGameStart = function()
            ---游戏开始时也刷新一次宝箱的使用
            self:RefreshSpecialBoxHint()
        end
    end
end

---接收到更好装备提示消息
function UIMainHintPanel:OnEquipGoodHintReceived(data)

    if (CS.CSScene.MainPlayerInfo == nil) then
        return ;
    end

    if data == LuaEnumMainHint_BetterBagItemType.UnionSummonToken then
        return
    end
    local bagItemHint = CS.CSScene.MainPlayerInfo.BagInfo.BagItemHint
    if bagItemHint ~= nil and data ~= nil then
        self.hintType = data
        self.hintStateType = luaclass.BetterItemHint_Data:GetHintStateType(data)
        if self:PushTypeHaveHintItem(self.hintType,self.hintStateType) == false then
            return
        end
        if self.hintStateType == LuaEnumBetterItemHintStateType.IconHint then
            self:TriggleHint(LuaEnumMainHintType.BetterBagItem, data)
        elseif data == LuaEnumMainHint_BetterBagItemType.DeployProp then
            self:TriggleHint(LuaEnumMainHintType.BetterBagItem, data)
        elseif self.hintStateType == LuaEnumBetterItemHintStateType.TextHint then
            if CS.Cfg_GlobalTableManager.Instance:CheckHintIsDefined(data) or data == LuaEnumMainHint_BetterBagItemType.None then
                self:TriggleHint(LuaEnumMainHintType.BetterBagItem_HighLv, data)
            end
        end
    end
end

---推送提示类型是否有可提示内容
---@param hintType LuaEnumMainHint_BetterBagItemType
---@param hintStateType LuaEnumBetterItemHintStateType
---@return boolean
function UIMainHintPanel:PushTypeHaveHintItem(hintType,hintStateType)
    if type(hintType) ~= 'number' or type(hintStateType) ~= 'number' then
        return false
    end
    if hintType == LuaEnumMainHint_BetterBagItemType.None then
        ---@type UIMainHint_BetterBagItem
        local hintTemplate = self:GetHintTemplateTypeByHintStateType(hintStateType)
        if hintTemplate == nil then
            return false
        end
        local hintType,haveItem = hintTemplate:GetHintFromCacheQueue(hintType)
        return haveItem
    end
    return true
end

---通过推送显示类型获取推送模板
---@param hintStateType LuaEnumBetterItemHintStateType
---@return UIBasicHint
function UIMainHintPanel:GetHintTemplateTypeByHintStateType(hintStateType)
    if type(hintStateType) ~= 'number' then
        return
    end
    local hintTemplateType = nil
    if hintStateType == LuaEnumBetterItemHintStateType.IconHint or hintStateType == LuaEnumMainHint_BetterBagItemType.DeployProp then
        hintTemplateType = LuaEnumMainHintType.BetterBagItem
    elseif hintStateType == LuaEnumBetterItemHintStateType.TextHint then
        hintTemplateType = LuaEnumMainHintType.BetterBagItem_HighLv
    end
    if hintTemplateType == nil then
        return
    end
    return self:GetTableTemplate(hintTemplateType,true)
end

---接收到Lua更好装备提示消息
---@param data table 消息数据
function UIMainHintPanel:OnPushBetterItem(data)
    if data == nil or data.betterBagItemType == nil then
        return
    end
    local hintReason = data.hintReason
    local hintPanelType = data.hintPanelType
    local betterBagItemType = data.betterBagItemType

    if hintPanelType == nil then
        hintPanelType = luaclass.BetterItemHint_Data:GetHintStateType(betterBagItemType)
    end
 if hintPanelType == nil then
        return
    end

    if hintPanelType == LuaEnumBetterItemHintStateType.IconHint then
        self:TriggleHint(LuaEnumMainHintType.BetterBagItem, data)
    elseif betterBagItemType == LuaEnumMainHint_BetterBagItemType.DeployProp then
        self:TriggleHint(LuaEnumMainHintType.BetterBagItem, data)
    elseif hintPanelType == LuaEnumBetterItemHintStateType.TextHint then
        if CS.Cfg_GlobalTableManager.Instance:CheckHintIsDefined(betterBagItemType) or hintPanelType == LuaEnumMainHint_BetterBagItemType.None then
            self:TriggleHint(LuaEnumMainHintType.BetterBagItem_HighLv, data)
        end
    end
end

---检查是否需要打开满背包提醒
function UIMainHintPanel:CheckIsNeedFullBagHint()
    local fullBagHint = self:GetTableTemplate(LuaEnumMainHintType.RecycleBagItemTips, false)
    if fullBagHint and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BagInfo ~= nil then
        ---当前的背包空格数量
        ---@type number
        local emptySlotCount = CS.CSScene.MainPlayerInfo.BagInfo.EmptyGridCount
        ---当前可回收装备数量
        ---@type number
        local recycleAvailableEquipCount = CS.CSScene.MainPlayerInfo.BagInfo:GetRecycleAvailableEquipCount()
        local hintContentString, isHintShow
        if recycleAvailableEquipCount >= self.mRecycleHintEquipCount then
            ---可回收装备数量大于回收提示的装备最小数量
            isHintShow = true
            hintContentString = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintString_ManyLowLevelEquip()
        elseif emptySlotCount <= self.mRecycleHintEmptySlotCount then
            ---空格数量小于回收提示空格最大数量
            if recycleAvailableEquipCount > 0 then
                isHintShow = true
                hintContentString = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintString_RecycleAvailable()
                --else
                --    hintContentString = CS.Cfg_GlobalTableManager.Instance:GetRecycleHintString_RecycleUnable()
            end
        end
        if isHintShow then
            uiStaticParameter.RecycleBubbleContent = hintContentString
            if fullBagHint:GetIsOn() == false then
                self:TriggleHint(LuaEnumMainHintType.RecycleBagItemTips, hintContentString)
            else
                fullBagHint:RefreshData(hintContentString)
            end
        else
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, true)
        end
    else
        self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
    end
end

---检查是否需要打开技能可学提醒
function UIMainHintPanel:CheckIsSkillLearningAvailableHint()
    local skillState = CS.CSScene.MainPlayerInfo.SkillInfoV2:GetSkillState()
    local mainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
    local tipLevel = CS.Cfg_GlobalTableManager.Instance:GetEquipHintRoleLvMax()
    if (mainPlayerLevel < tipLevel and skillState == LuaEnumSkillStateCode.UpLevel)
            or (mainPlayerLevel >= tipLevel and skillState == LuaEnumSkillStateCode.Study)
    then
        local showStr = ""
        if (skillState == LuaEnumSkillStateCode.Study) then
            showStr = "[dde6eb]有新技能可以学习, [39ce1b]点击前往[-][-]"
        elseif (skillState == LuaEnumSkillStateCode.UpLevel) then
            showStr = "[dde6eb]有技能可以升级, [39ce1b]点击前往[-][-]"
        elseif (skillState == LuaEnumSkillStateCode.Proficiency) then
            showStr = "[dde6eb]技能熟练度可提升, [39ce1b]点击前往[-][-]"
        end
        self:TriggleHint(LuaEnumMainHintType.SkillLearningAvailableTips, showStr)
    end
end

---刷新大聚灵珠使用次数
function UIMainHintPanel:RefreshBigJuLingZhuUseCount()
    --self:RefreshBigJuLingZhuBuyHint()
end

--region
---刷新大聚灵珠使用提示
--function UIMainHintPanel:RefreshBigJuLingZhuBuyHint()
--    if CS.CSScene.MainPlayerInfo == nil then
--        return
--    end
--    ---40级后，未达到每日大聚灵珠使用上限时，背包内未存在空的大聚灵珠，触发购买大聚灵珠的提示
--    local mainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
--    if mainPlayerLevel < 40 then
--        return
--    end
--    local bigJuLingZhuUseCount = 0
--    ---大聚灵珠(满)的当前使用次数
--    local isFind, data = CS.CSScene.MainPlayerInfo.BagInfo.JvLingZhuUseNumDic:TryGetValue(8040007)
--    if isFind and data then
--        bigJuLingZhuUseCount = data.useCount
--    end
--    if bigJuLingZhuUseCount >= self:GetBigJuLingZhuMaxUseLimit() and self:GetBigJuLingZhuMaxUseLimit() > 0 then
--        return
--    end
--    if CS.CSScene.MainPlayerInfo == nil then
--        return
--    end
--    local bagInfo = CS.CSScene.MainPlayerInfo.BagInfo
--    if bagInfo == nil then
--        return
--    end
--    ---当前背包内大聚灵珠数量,包括空聚灵珠和正在灌满的聚灵珠
--    local bigJuLingZhuCountInBag = bagInfo:GetItemCountByItemId(8040001) + bagInfo:GetItemCountByItemId(8040004)
--    if bigJuLingZhuCountInBag > 0 then
--        return
--    end
--    self:TriggleHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy, 8040001)
--end
--endregion

---刷新宝箱使用提示
function UIMainHintPanel:RefreshSpecialBoxHint()
    --print("RefreshSpecialBoxHint")
    --if CS.CSScene.MainPlayerInfo == nil then
    --    return
    --end
    --if uimanager:GetPanel("UISpecialTreasureBagPanel") ~= nil then
    --    return
    --end
    --local specialBoxKeyInfos = Utility.GetSpecialBoxKeyInfos()
    -----@type CSBagInfoV2
    --local mainPlayerBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
    --local quality = 0
    --local recommendedBagItem = nil
    --local boxCanUseCount = 0
    --local mainPlayerLevel = CS.CSScene.MainPlayerInfo.Level
    --local mainPlayerReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
    --for i, v in pairs(specialBoxKeyInfos) do
    --    local boxItemID = i
    --    local keyItemID = v.keyId
    --    local keyItemUseMinCount = v.keyNum
    --    local boxItemCount = mainPlayerBagInfo:GetItemCountByItemId(boxItemID)
    --    local keyItemCount = mainPlayerBagInfo:GetItemCountByItemId(keyItemID)
    --    local maxUseCountPerDay = Utility.GetSpecialBoxUseCountLimitPerDay(boxItemID)
    --    local res, useNum = mainPlayerBagInfo.ItemUseTime:TryGetValue(boxItemID)
    --    if maxUseCountPerDay == 0 or useNum < maxUseCountPerDay then
    --        ---每日最大使用次数为0或者当前使用次数小于最大使用次数时才可以用宝箱
    --        if keyItemCount >= keyItemUseMinCount and boxItemCount > 0 then
    --            ---当前钥匙数量不小于最小钥匙使用数量时才可以使用宝箱
    --            ---@type TABLE.CFG_ITEMS
    --            local boxItemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(boxItemID)
    --            local keyItemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(keyItemID)
    --            if boxItemTbl.useLv <= mainPlayerLevel and boxItemTbl.reinLv <= mainPlayerReinLevel
    --                    and keyItemTbl.useLv <= mainPlayerLevel and keyItemTbl.reinLv <= mainPlayerLevel then
    --                if quality == 0 or boxItemTbl.quality > quality then
    --                    quality = boxItemTbl.quality
    --                    recommendedBagItem = mainPlayerBagInfo:GetBagItemInfo(boxItemID)
    --                    boxCanUseCount = keyItemCount > boxItemCount and boxItemCount or keyItemCount
    --                end
    --            end
    --        end
    --    end
    --end
    --if recommendedBagItem == nil then
    --    return
    --end
    --self:TriggleHint(LuaEnumMainHintType.SpecialBoxUseHint, recommendedBagItem, boxCanUseCount)
end

--***************************************************************** 提示管理 *****************************************************************
---重新显示时检查所有提示,隐藏不需要的提示,并分发需要执行的提示
function UIMainHintPanel:CheckOnReshown()
    ---重新显示缓冲区的提示
    if self.HintCache and self.IsHiden ~= true then
        for i = 1, #self.HintCache do
            local hintType = self.HintCache[i].hintType
            local data = self.HintCache[i].data
            self:TriggleHint(hintType, table.unpack(data))
        end
        self.HintCache = {}
        --for type, data in pairs(self.HintCache) do
        --    self:TriggleHint(type, table.unpack(data))
        --    self.HintCache[type] = nil
        --end
    end
    ---检查已打开的界面
    if self.mTables then
        for i, v in pairs(self.mTables) do
            if v then
                if v:OnReshown() == false then
                    v:Close(false)
                else
                    ---重新打开提示界面时,需要重新检查所有提示界面的位置
                    v:RefreshPosition()
                end
            end
        end
    end
end

---提示触发事件(打开提示后立即执行,可以在此方法中同时关闭该提示)
---@param mainHintType LuaEnumMainHintType 主界面提示类型
function UIMainHintPanel:OnHintTriggled(mainHintType)
    if mainHintType == LuaEnumMainHintType.SpecialBoxUseHint then
        ---宝箱使用提示
        if self:IsHintExist(LuaEnumMainHintType.RecycleBagItemTips) then
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem_HighLv) then
            self:CloseHint(LuaEnumMainHintType.SpecialBoxUseHint, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BigJuLingZhuRecommendBuy) then
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy)
        end
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem) then
            self:CloseHint(LuaEnumMainHintType.BetterBagItem, false)
        end
    elseif mainHintType == LuaEnumMainHintType.BetterBagItem or mainHintType == LuaEnumMainHintType.SkillLearningAvailableTips then
        if self:IsHintExist(LuaEnumMainHintType.RecycleBagItemTips) then
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem_HighLv) then
            self:CloseHint(LuaEnumMainHintType.BetterBagItem_HighLv, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BigJuLingZhuRecommendBuy) then
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy)
        end
        if self:IsHintExist(LuaEnumMainHintType.SpecialBoxUseHint) then
            self:CloseHint(LuaEnumMainHintType.BetterBagItem)
        end
    elseif mainHintType == LuaEnumMainHintType.BetterBagItem_HighLv then
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem) then
            self:CloseHint(LuaEnumMainHintType.BetterBagItem, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.RecycleBagItemTips) then
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BigJuLingZhuRecommendBuy) then
            --若弹出其他提示,则不显示大聚灵珠购买提示
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy)
        end
        if self:IsHintExist(LuaEnumMainHintType.SpecialBoxUseHint) then
            self:CloseHint(LuaEnumMainHintType.SpecialBoxUseHint, false)
        end
    elseif mainHintType == LuaEnumMainHintType.RecycleBagItemTips then
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem) or self:IsHintExist(LuaEnumMainHintType.BetterBagItem_HighLv) then
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.BigJuLingZhuRecommendBuy) then
            --若弹出其他提示,则不显示大聚灵珠购买提示
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy)
        end
        if self:IsHintExist(LuaEnumMainHintType.SpecialBoxUseHint) then
            self:CloseHint(LuaEnumMainHintType.RecycleBagItemTips, false)
        end
    elseif mainHintType == LuaEnumMainHintType.BigJuLingZhuRecommendBuy then
        --若其他提示存在,则不显示大聚灵珠购买提示
        if self:IsHintExist(LuaEnumMainHintType.BetterBagItem) or self:IsHintExist(LuaEnumMainHintType.BetterBagItem_HighLv) or self:IsHintExist(LuaEnumMainHintType.RecycleBagItemTips) then
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy, false)
        end
        if self:IsHintExist(LuaEnumMainHintType.SpecialBoxUseHint) then
            self:CloseHint(LuaEnumMainHintType.BigJuLingZhuRecommendBuy, false)
        end
    end
end

--***************************************************************** 析构 *****************************************************************
function ondestroy()
    if uiStaticParameter then
        uiStaticParameter.MainHintPanel = nil
    end
end

return UIMainHintPanel