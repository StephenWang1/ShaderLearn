---@class UIItemInfoManager
local UIItemInfoManager = {}

--region  引用
function UIItemInfoManager:GetMainPlayerInfo()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 初始化
function UIItemInfoManager:CreatePanel(commonData)
    self:ClearData()
    self:InitTemplates()
    self:AnalysisData(commonData)
    ---副面板物品列表（如果传入有参数，则按照传入参数进行显示）
    if self.assistPanelBagItemInfoTable == nil and self.assistPanelItemInfoTable == nil then
        self:AnalysisTabItemInfo()
        self:AnalysisAssistItemInfo()
    end
    if self.needCompare == true then
        self:AnalysisCompareItemInfo()
    end
    self:AnalysisTemplate()
    self:AnalysisShowAssistPanel()
    self:CreateInfoPanel()
end

function UIItemInfoManager:TryCreateSkillVideoPanel()
    if (self.itemInfo ~= nil and self.itemInfo.type == luaEnumItemType.SkillBook) then
        local luaItemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.itemInfo.id);
        if (luaItemTbl ~= nil and luaItemTbl:GetUseParam() ~= nil) then
            local useParams = luaItemTbl:GetUseParam().list;
            if (useParams.Count > 0) then
                local skillId = useParams[0];
                ---@type TABLE.cfg_skills
                local skillTbl = clientTableManager.cfg_skillsManager:TryGetValue(skillId);
                if (skillTbl ~= nil and skillTbl:GetVideoId() ~= nil and skillTbl:GetVideoId() ~= 0) then
                    uimanager:CreatePanel("UISkillVideoPanel", nil, { videoId = skillTbl:GetVideoId(), skillName = skillTbl:GetName() });
                end
            end
        end
    end
end

---清理数据
function UIItemInfoManager:ClearData()
    self.bagItemInfo = nil
    self.itemInfo = nil
    self.itemType = false
    self.showRight = false
    self.showAssistPanel = false
    self.mainPartTemplate = nil
    self.assistPartTemplate = nil
    self.assistPanelBagItemInfoTable = nil
    self.assistPanelItemInfoTable = nil
    self.isCloseCollider = false
    self.TabBagItemInfoTable = nil
    self.compareBagItemInfo = nil
    self.compareItemInfo = nil
end

---初始化模板
function UIItemInfoManager:InitTemplates()
    if self.itemInfoTemplates == nil then
        self.itemInfoTemplates = {}
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Servant_Egg] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServentMainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServentAssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.RoleEquip] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_AssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Servant_Equip] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantEquipAssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Servant_BodyEquip] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantBodyMainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantBodyAssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.DoubleMedal] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart_Medal, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_AssistPart_Medal }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Other] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_AssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Servant_Fragment] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServentFragmentMainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.MarryRing_Bag] = { mainPartTemplate = luaComponentTemplates.BagMarryRingItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.MarryRing_Role] = { mainPartTemplate = luaComponentTemplates.RoleMarryRingItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Servant_BodyCommon] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantBodyMainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_ServantBodyAssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.GemExtraItem] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_GemExtraItemMainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_GemExtraItemMainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.HunJi] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_HunJiMainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.MagicEquip] = { mainPartTemplate = luaComponentTemplates.MagicEquipItemInfo_MainPart, assistPartTemplate = luaComponentTemplates.MagicEquipItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.BloodSuit] = { mainPartTemplate = luaComponentTemplates.BloodSuitItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.DivineEquip] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_AssistPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.Collection] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart_Collection, assistPartTemplate = luaComponentTemplates.UIItemInfoPanel_AssistPart_Collection }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.PotentialEauip] = { mainPartTemplate = luaComponentTemplates.UIItemInfoPanel_MainPart_Potential }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.UpgradeMembership] = { mainPartTemplate = luaComponentTemplates.UpgradeMembershipItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.ZhengFaEquip] = { mainPartTemplate = luaComponentTemplates.ZhenFaEquipItemInfo_MainPart, assistPartTemplate = luaComponentTemplates.ZhenFaEquipItemInfo_MainPart }
        self.itemInfoTemplates[LuaEnumItemInfoPanelItemType.BingJianSL] = { mainPartTemplate = luaComponentTemplates.BingJianEquipItemInfo_MainPart, assistPartTemplate = luaComponentTemplates.BingJianEquipItemInfo_MainPart }
    end
end

---@class UIItemTipInfoCommonData
---@field OperateID number item_operate表中记录的操作ID
---@field ItemID number item表的ID
---@field ItemInfoData {bagItemInfo:bagV2.BagItemInfo,itemInfo:TABLE.CFG_ITEMS,showRight:boolean,showAssistPanel:boolean,itemType:LuaEnumItemInfoPanelItemType,isCloseCollider:boolean,career:职业类型,roleId:number,rightUpButtonsModule:UIItemInfoPanel_PartBasic,refreshEndFunc:function,endFuncParams:function,extraEquipIdTable:table,highLightBtnTable:table<number,OperateID>,extraEquipIdTable:table<number,ItemID>,itemInfoSource:luaEnumItemInfoSource,showBtnIdTable:boolean,showMoreAssistData:boolean,showTabBtns:boolean,showBind:boolean,showAction:boolean}
---@field bagItemInfo bagV2.BagItemInfo C#,Lua均可,会自动检测背包物品信息
---@field itemInfo TABLE.CFG_ITEMS 道具表物品信息
---@field showRight boolean 显示右侧按钮,默认显示右侧按钮
---@field showAssistPanel boolean 显示副面板，默认不显示副面板
---@field itemType LuaEnumItemInfoPanelItemType 模板类型
---@field isCloseCollider boolean 添加碰撞体关闭面板
---@field career LuaEnumCareer 职业类型（强化显示与当前职业对应显示）
---@field roleId number 角色唯一id（当前用于婚戒tips中）
---@field rightUpButtonsModule UIItemInfoPanel_Info_Basic 右上角按钮模板（如果有则所有的物品的右上角按钮都替换成对应的模板）
---@field refreshEndFunc fun 刷新结束方法（通用参数）
---@field endFuncParams any 刷新结束方法参数
---@field extraEquipIdTable 额外装备列表（主要用于类似宝物有额外装备属性和icon的道具显示）table
---@field highLightBtnTable 高亮右上角按钮列表（对应传入按钮列表，则对应右上角按钮则有特殊提示（当前是特效））
---@field itemInfoSource 物品信息点击来源（默认0）
---@field showBtnIdTable 显示按钮ID列表(table中如果有对应的按钮id，则会按照指定的顺序排列并直接显示，默认第一个按钮是显示的)
---@field showMoreAssistData 显示多副面板数据对比（默认为一对一对比，开启后则会出现多个副面板）
---@field showTabBtns 显示上部页签按钮列表，点击打开不同的副面板数据
---@field showBind 显示绑定（策划需要绑定显示需要在特定的情况下才会显示，不能通用）
---@field showAction 显示交易（策划需要交易显示需要在特定的情况下才会显示，不能通用）
---@field commonData ItemInfoData
---@field getItemList 获取物品列表（itemId列表）
---@field isExhibitionPanel boolean 是否是展示面板（展示面板没有对比界面，没有右上角按钮，对应的预设也不一样）
---@field assistBagItemInfoTable table 副面板背包物品列表(bagItemInfo)
---@field assistItemInfoTable table 副面板背包物品列表(itemInfo)
---@field tipsOnClick function tips点击回调（返回table）
---@field defaultChooseTable table 默认选择物品列表
---@field needCompare boolean 默认选择物品列表
---@field maxFrameHeight number 自定义外框最大高度
---@field ExhibitionPanelNeedLink boolean 展示面板是否需要自动校正位置
---@field backgroundPos UnityEngine.Vector3 展示面板位置


---解析数据
---@param commonData UIItemTipInfoCommonData
function UIItemInfoManager:AnalysisData(commonData)
    self.commonData = commonData
    self.bagItemInfo = (type(commonData.bagItemInfo) == 'table')
            and protobufMgr.DecodeTable.bag.BagItemInfo(commonData.bagItemInfo)
            or commonData.bagItemInfo
    self.itemInfo = ternary(commonData.itemInfo == nil, ternary(self.bagItemInfo ~= nil, self:GetItemInfo(self.bagItemInfo), nil), commonData.itemInfo)
    self.isExhibitionPanel = ternary(commonData.isExhibitionPanel == nil, false, commonData.isExhibitionPanel)
    self.itemInfoSource = ternary(commonData.itemInfoSource == nil, luaEnumItemInfoSource.NONE, commonData.itemInfoSource)
    self.itemType = ternary(commonData.itemType == nil, self:GetItemType(self.itemInfo), commonData.itemType)
    self.showRight = ternary(self.isExhibitionPanel == false, ternary(commonData.showRight == nil, true, commonData.showRight), false)
    self.showAssistPanel = ternary(commonData.showAssistPanel == nil or self.isExhibitionPanel == true, false, commonData.showAssistPanel)
    self.isCloseCollider = ternary(commonData.isCloseCollider == nil, false, commonData.isCloseCollider)
    self.career = ternary(commonData.career == nil, Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career), commonData.career)
    self.rightUpButtonsModule = commonData.rightUpButtonsModule
    self.refreshEndFunc = ternary(commonData.refreshEndFunc == nil, function()
    end, commonData.refreshEndFunc)
    self.extraEquipIdTable = commonData.extraEquipIdTable
    self.highLightBtnTable = ternary(commonData.highLightBtnTable == nil, {}, commonData.highLightBtnTable)
    self.showBtnIdTable = ternary(commonData.showBtnIdTable == nil, {}, commonData.showBtnIdTable)
    self.showMoreAssistData = ternary(commonData.showMoreAssistData == nil, false, commonData.showMoreAssistData)
    self.showTabBtns = ternary(commonData.showTabBtns == nil, false, commonData.showTabBtns)
    self.endFuncParams = commonData.endFuncParams
    self.roleId = ternary(commonData.roleId == nil, CS.CSScene.MainPlayerInfo.ID, commonData.roleId)
    self.showBind = ternary(commonData.showBind == nil, false, commonData.showBind)
    self.showAction = ternary(commonData.showAction == nil, false, commonData.showAction)
    self.getItemList = ternary(commonData.getItemList == nil, self:GetGetItemList(), commonData.getItemList)
    self.assistPanelBagItemInfoTable = commonData.assistBagItemInfoTable
    self.assistPanelItemInfoTable = ternary(commonData.assistItemInfoTable ~= nil, commonData.assistItemInfoTable, self:GetItemInfoTable())
    self.tipsOnClick = commonData.tipsOnClick
    self.defaultChooseTable = commonData.defaultChooseTable
    self.needCompare = ternary(commonData.needCompare == nil, true, commonData.needCompare)
    self.maxFrameHeight = ternary(commonData.maxFrameHeight == nil, 600, commonData.maxFrameHeight)
    self.ExhibitionPanelNeedLink = ternary(commonData.ExhibitionPanelNeedLink == nil, true, commonData.ExhibitionPanelNeedLink)
    self.backgroundPos = ternary(commonData.backgroundPos == nil, CS.UnityEngine.Vector3.Zero, commonData.backgroundPos)
    self:CheckIsMainPlayerUsed()
    self:InitOtherParams()
end

---解析页签物品
function UIItemInfoManager:AnalysisTabItemInfo()
    if self.itemInfo ~= nil and self.showTabBtns == true then
        self.TabBagItemInfoTable, self.TabItemInfoTable, self.TabDefaultChoose = uiStaticParameter.TabDataManager:GetTabData({ type = self.itemType, bagItemInfo = self.bagItemInfo, itemInfo = self.itemInfo, showMoreAssistData = self.showMoreAssistData })
    end
end

---解析副面板物品信息
function UIItemInfoManager:AnalysisAssistItemInfo()
    ---有页签则按照页签的物品中寻找第一对对比物品列表
    if self.TabBagItemInfoTable ~= nil and Utility.GetLuaTableCount(self.TabBagItemInfoTable) > 0 then
        local chooseIndex = 999
        for k, v in pairs(self.TabBagItemInfoTable) do
            if k <= chooseIndex then
                chooseIndex = k
            end
            if k == self.TabDefaultChoose then
                chooseIndex = k
                break
            end
        end
        self.assistPanelBagItemInfoTable = self.TabBagItemInfoTable[chooseIndex]
        self.assistPanelItemInfoTable = self.TabItemInfoTable[chooseIndex]
        self.assistPanelExtraEquipIdTable = uiStaticParameter.AssistDataManager:GetExtraEquipTable(self.bagItemInfo, self.itemInfo)
    else
        if self.itemInfo ~= nil and self.itemType ~= nil then
            ---没有页签但是要开启多项显示的情况下
            if self.showMoreAssistData == true then
                self.assistPanelBagItemInfoTable, self.assistPanelItemInfoTable = uiStaticParameter.AssistDataManager:GetAssistData({ type = self.itemType, bagItemInfo = self.bagItemInfo, itemInfo = self.itemInfo })
            end
            if self.assistPanelItemInfoTable == nil or #self.assistPanelItemInfoTable == 0 then
                ---只对比单个物品的情况下
                self.assistBagItemInfo, self.assistItemInfo = uiStaticParameter.CompareDataManager:GetCompareData({ type = self.itemType, bagItemInfo = self.bagItemInfo, itemInfo = self.itemInfo })
                self.assistPanelBagItemInfoTable = {}
                self.assistPanelItemInfoTable = {}
                table.insert(self.assistPanelBagItemInfoTable, self.assistBagItemInfo)
                table.insert(self.assistPanelItemInfoTable, self.assistItemInfo)
            end
            self.assistPanelExtraEquipIdTable = uiStaticParameter.AssistDataManager:GetExtraEquipTable(self.bagItemInfo, self.itemInfo)
        end
    end
end

---解析对比物品
function UIItemInfoManager:AnalysisCompareItemInfo()
    if self.itemInfo ~= nil and self.itemType ~= nil then
        ---如果没有开启多副面板物品，则找身上最弱的一件装备进行对比
        self.compareBagItemInfo, self.compareItemInfo = uiStaticParameter.CompareDataManager:GetLowData({ type = self.itemType, assistPanelBagItemInfoTable = self.assistPanelBagItemInfoTable })
        if type(self.compareItemInfo) == 'table' then
            local compareItemInfoIsFind, compareItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.compareItemInfo.id)
            if compareItemInfoIsFind then
                self.compareItemInfo = compareItemInfo
            end
        end
    end
end

---根据物品信息解析对应的模板
function UIItemInfoManager:AnalysisTemplate()
    if self.itemType ~= nil then
        self.mainPartTemplate, self.assistPartTemplate = self:GetTemplates(self.itemType)
        self.assistPartTemplate = ternary(self.showAssistPanel == false or self.assistPanelItemInfoTable == nil, nil, self.assistPartTemplate)
    end
end

---解析是否显示副面板
function UIItemInfoManager:AnalysisShowAssistPanel()
    if self.showAssistPanel == true then
        self.showAssistPanel = self.compareBagItemInfo ~= nil
    end
end

---创建信息面板
function UIItemInfoManager:CreateInfoPanel()
    self:CheckLuaBagItemInfo()
    local commonData = { commonData = self.commonData, bagItemInfo = self.bagItemInfo, itemInfo = self.itemInfo, showRight = self.showRight, showAssistPanel = self.showAssistPanel,
                         mainPartTemplate = self.mainPartTemplate, assistPartTemplate = self.assistPartTemplate, assistPanelBagItemInfoTable = self.assistPanelBagItemInfoTable,
                         assistPanelItemInfoTable = self.assistPanelItemInfoTable, isCloseCollider = self.isCloseCollider, career = self.career, rightUpButtonsModule = self.rightUpButtonsModule, refreshEndFunc = self.refreshEndFunc,
                         extraEquipIdTable = self.extraEquipIdTable, assistPanelExtraEquipIdTable = self.assistPanelExtraEquipIdTable, highLightBtnTable = self.highLightBtnTable, itemInfoSource = self.itemInfoSource, compareBagItemInfo = self.compareBagItemInfo, compareItemInfo = self.compareItemInfo, TabBagItemInfoTable = self.TabBagItemInfoTable,
                         TabItemInfoTable = self.TabItemInfoTable, showTabBtns = self.showTabBtns, endFuncParams = self.endFuncParams, TabDefaultChoose = self.TabDefaultChoose, roleId = self.roleId, showBind = self.showBind, showAction = self.showAction, getItemList = self.getItemList, tipsOnClick = self.tipsOnClick, defaultChooseTable = self.defaultChooseTable, maxFrameHeight = self.maxFrameHeight,
                         ExhibitionPanelNeedLink = self.ExhibitionPanelNeedLink, backgroundPos = self.backgroundPos }

    if self.mainPartTemplate ~= nil and self.itemInfo ~= nil then
        ---极端情况下，可能会同时创建多个信息面板组合的情况（注意，可能出现会出现奇怪的问题）
        if self.itemType == LuaEnumItemInfoPanelItemType.Servant_Egg then
            uimanager:CreatePanel("UIPetInfoPanel", nil, commonData)
        elseif self.isExhibitionPanel == true then
            uimanager:CreatePanel("UIItemShowInfoPanel", nil, commonData)
        elseif self.itemInfoSource == luaEnumItemInfoSource.UIREFINERESULT then
            uimanager:CreatePanel("UIItemRefineInfoPanel", nil, commonData)
        else
            uimanager:CreatePanel("UIItemInfoPanel", nil, commonData)
        end
        ---存储显示数据
        local mainItem = ternary(self.bagItemInfo == nil, self.itemInfo, self.bagItemInfo)
        self:InitShowItemTable(mainItem, self.TabBagItemInfoTable, self.itemType)
    end
end

---检测lua的背包物品信息，并转换成c#的背包物品信息
function UIItemInfoManager:CheckLuaBagItemInfo()
    if type(self.TabBagItemInfoTable) == 'table' and Utility.GetLuaTableCount(self.TabBagItemInfoTable) > 0 then
        for k, v in pairs(self.TabBagItemInfoTable) do
            local chooseIndex = k
            local bagItemInfoList = v
            local curBagItemInfoList = {}
            for a, b in pairs(bagItemInfoList) do
                local CSBagItemInfo = b
                if type(CSBagItemInfo) == 'table' then
                    CSBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(CSBagItemInfo)
                end
                table.insert(curBagItemInfoList, CSBagItemInfo)
            end
            self.TabBagItemInfoTable[chooseIndex] = curBagItemInfoList
        end
    end

    if type(self.assistPanelBagItemInfoTable) == 'table' and Utility.GetLuaTableCount(self.assistPanelBagItemInfoTable) > 0 then
        for k, v in pairs(self.assistPanelBagItemInfoTable) do
            local chooseIndex = k
            local CSBagItemInfo = v
            if type(CSBagItemInfo) == 'table' then
                CSBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(CSBagItemInfo)
            end
            self.assistPanelBagItemInfoTable[chooseIndex] = CSBagItemInfo
        end
    end

    if type(self.compareBagItemInfo) == 'table' then
        self.compareBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(self.compareBagItemInfo)
    end
end

---获取显示的物品列表（tips最下方的物品列表）
function UIItemInfoManager:GetGetItemList()
    if (self.itemInfo ~= nil) then
        return CS.Cfg_BoxTableManager.Instance:GetBoxItemIdList(self.itemInfo.id)
    end
end
--endregion

--region 获取
---获取itemInfo
function UIItemInfoManager:GetItemInfo(bagItemInfo)
    if bagItemInfo ~= nil then
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
        if itemInfoIsFind then
            return itemInfo
        end
    end
    return nil
end

---获取物品类型
---@param itemInfo TABLE.CFG_ITEMS
---@return LuaEnumItemInfoPanelItemType
function UIItemInfoManager:GetItemType(itemInfo)
    if itemInfo == nil then
        return
    end
    if itemInfo.ItemTABLE ~= nil then
        itemInfo = itemInfo.ItemTABLE
    end
    if self:GetMainPlayerInfo().EquipInfo:IsMedal(itemInfo) then
        return LuaEnumItemInfoPanelItemType.DoubleMedal
    elseif CS.CSServantInfoV2.isServantEgg(itemInfo) then
        return LuaEnumItemInfoPanelItemType.Servant_Egg
    elseif CS.CSServantInfoV2.IsServantJustEquip(itemInfo) or CS.CSServantInfoV2.IsServantMagicWeapon(itemInfo) then
        return LuaEnumItemInfoPanelItemType.Servant_Equip
    elseif clientTableManager.cfg_itemsManager:IsZhenFaEquip(itemInfo.id) then
        return LuaEnumItemInfoPanelItemType.ZhengFaEquip
    elseif CS.CSServantInfoV2.IsServantBody(itemInfo) then
        if CS.CSServantInfoV2.IsServantCommonBody(itemInfo) then
            return LuaEnumItemInfoPanelItemType.Servant_BodyCommon
        else
            return LuaEnumItemInfoPanelItemType.Servant_BodyEquip
        end
    elseif self:GetMainPlayerInfo().EquipInfo:IsMarryRing(itemInfo) then
        if self.bagItemInfo ~= nil and self.bagItemInfo.itemId == nil then
            return LuaEnumItemInfoPanelItemType.MarryRing_Role
        end
        return LuaEnumItemInfoPanelItemType.MarryRing_Bag
    elseif self:GetMainPlayerInfo().EquipInfo:IsGemExtraItem(itemInfo) and (self.itemInfoSource == luaEnumItemInfoSource.UIROLEPANEL or self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL) then
        return LuaEnumItemInfoPanelItemType.GemExtraItem
    elseif self:GetMainPlayerInfo().EquipInfo:CheckIsRoleEquip(itemInfo) then
        return LuaEnumItemInfoPanelItemType.RoleEquip
    elseif itemInfo.type == luaEnumItemType.HunJi then
        return LuaEnumItemInfoPanelItemType.HunJi
    elseif clientTableManager.cfg_itemsManager:IsMagicEquip(itemInfo.id) then
        return LuaEnumItemInfoPanelItemType.MagicEquip
    elseif gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():CheckIsSLBingJian(itemInfo.id) then
        return LuaEnumItemInfoPanelItemType.BingJianSL
    elseif clientTableManager.cfg_itemsManager:IsDivineSuitEquip(itemInfo.id) then
        return LuaEnumItemInfoPanelItemType.DivineEquip
    elseif itemInfo.type == luaEnumItemType.Collection then
        return LuaEnumItemInfoPanelItemType.Collection
    elseif gameMgr:GetPlayerDataMgr() ~= nil then
        if gameMgr:GetPlayerDataMgr():GetLuaPotentialEquipMgr():IsPotentialEquip(itemInfo) then
            return LuaEnumItemInfoPanelItemType.PotentialEauip
        end

    end
    return LuaEnumItemInfoPanelItemType.Other
end

---获取主面板模板和副面板模板
---@param type LuaEnumItemInfoPanelItemType
---@return UIItemInfoPanel_PartBasic, UIItemInfoPanel_PartBasic
function UIItemInfoManager:GetTemplates(type)
    if self.itemInfoTemplates ~= nil then
        local templateTable = self.itemInfoTemplates[type]
        if templateTable ~= nil then
            return templateTable.mainPartTemplate, templateTable.assistPartTemplate
        end
    end
end

---检测物品是否是主角使用的
function UIItemInfoManager:CheckIsMainPlayerUsed()
    if self.bagItemInfo ~= nil and self.itemType ~= LuaEnumItemInfoPanelItemType.MarryRing_Role then
        local isMainPlayerUsed = CS.Utility_Lua.CheckEquipIsUsed(self.bagItemInfo)
        if isMainPlayerUsed == true and self.itemInfoSource ~= luaEnumItemInfoSource.UIREFINERESULT then
            self.showAssistPanel = false
        else
            if self.bagItemInfo.ItemTABLE ~= nil and self.bagItemInfo.ItemTABLE.type == luaEnumItemType.HunJi then
                return false
            end
            --self.bagItemInfo.index = 0
        end
        return isMainPlayerUsed
    end
    return false
end

function UIItemInfoManager:InitOtherParams()
    if self.itemInfoSource == luaEnumItemInfoSource.UIOTHERROLEPANEL then
        self.showRight = false
    end
end

---通过bagItemInfo表获取itemInfo表
function UIItemInfoManager:GetItemInfoTable()
    if self.assistPanelBagItemInfoTable ~= nil and type(self.assistPanelBagItemInfoTable) == 'table' then
        local itemInfoTable = {}
        for k, v in pairs(self.assistPanelBagItemInfoTable) do
            if v ~= nil and v.ItemTABLE ~= nil then
                table.insert(itemInfoTable, v.ItemTABLE)
            end
        end
        return itemInfoTable
    end
    return nil
end
--endregion

--region 当前显示的物品信息
---@param MainItem bagV2.BagItemInfo 主面板显示的物品信息
---@param MainItem TABLE.CFG_ITEMS 主面板显示的物品信息
UIItemInfoManager.MainItem = nil
---@param AssistItemTable table<number,table<bagV2.BagItemInfo>>
UIItemInfoManager.AssistItemTable = nil
---@param ChooseIndex LuaEnumItemInfoPanelPageType
UIItemInfoManager.ChooseIndex = nil

---初始化显示的物品表
---@param mainItem bagV2.BagItemInfo 主面板显示的物品信息
---@param mainItem TABLE.CFG_ITEMS 主面板显示的物品信息
---@param assistItemTable table 副面板显示物品表
function UIItemInfoManager:InitShowItemTable(mainItem, assistItemTable)
    self.MainItem = mainItem
    self.AssistItemTable = assistItemTable
end

---获取副面板物品信息
---@param index number 数据下标（一般都是页签下标）
---@return table<bagV2.BagItemInfo> 副面板物品表
---@return table<TABLE.CFG_ITEMS> 物品信息表
---@return bagV2.BagItemInfo 对比的装备
function UIItemInfoManager:GetShowItemTable(index)
    if self.MainItem ~= nil and self.AssistItemTable ~= nil and type(self.AssistItemTable) == 'table' then
        if index == nil or Utility.GetTableCount(self.AssistItemTable) <= 1 then
            return Utility.GetTableFirstValue(self.AssistItemTable)
        end
        local assistItemTable = self.AssistItemTable[index]
        if assistItemTable == nil then
            return
        end
        local assistItemInfoTable = self:BagItemInfoTableChangeItemInfoTable(assistItemTable)
        local compareBagitemInfo, compareItemInfo = nil
        if assistItemTable ~= nil and type(assistItemTable) == 'table' then
            local assistItemCount = Utility.GetTableCount(assistItemTable)
            if assistItemCount > 0 then
                compareBagitemInfo, compareItemInfo = uiStaticParameter.CompareDataManager:GetLowData({ type = self:GetItemType(self.MainItem), assistPanelBagItemInfoTable = assistItemTable })
            end
        end
        self.showAssistItemTable, self.showCompareBagItemInfo = assistItemTable, compareBagitemInfo
        return assistItemTable, assistItemInfoTable, compareBagitemInfo
    end
end

---设置页签下标
---@param index number 数据下标（一般都是页签下标）
function UIItemInfoManager:SetChooseIndex(index)
    self.ChooseIndex = index
end

---背包物品表转物品表
---@return table<TABLE.CFG_ITEMS> 物品信息表
function UIItemInfoManager:BagItemInfoTableChangeItemInfoTable(bagItemInfoTable)
    if bagItemInfoTable ~= nil and type(bagItemInfoTable) == 'table' and Utility.GetTableCount(bagItemInfoTable) > 0 then
        local itemInfoTable = {}
        for k, v in pairs(bagItemInfoTable) do
            if v ~= nil and v.ItemTABLE then
                table.insert(itemInfoTable, v.ItemTABLE)
            end
        end
        return itemInfoTable
    end
end

---清空显示的物品表
function UIItemInfoManager:ClearShowItemTable()
    self.MainItem = nil
    self.AssistItemTable = nil
    self.ChooseIndex = nil
end
--endregion

return UIItemInfoManager