---血继装备数据管理   调用参考 gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr()
---@class LuaPlayerBloodSuitEquipMgr
local LuaPlayerBloodSuitEquipMgr = {}

---当前选中的套装
---@type  LuaEquipBloodSuitType
LuaPlayerBloodSuitEquipMgr.NowSelectSuit = LuaEquipBloodSuitType.Yao

---当前选中的装备位下标类型
---@type  number
LuaPlayerBloodSuitEquipMgr.NowSelectEquipItemType = nil

---当前选中的装备位
---@return number
function LuaPlayerBloodSuitEquipMgr:GetNowSelectEquipIndex()
    return self:GetEquipIndex(self.NowSelectSuit, self.NowSelectEquipItemType)
end

---得到灵兽装备位编号
---@param type LuaEquipBloodSuitType 血继装备类型
---@param pos LuaEquipBloodSuitItemType 血继装备位下标类型
function LuaPlayerBloodSuitEquipMgr:GetEquipIndex(type, pos)
    return 300000 + 100 * type + pos
end

---得到灵兽装备位编号
---@param index number 灵兽装备位
---@return LuaEquipBloodSuitType,LuaEquipBloodSuitItemType 血继装备类型/血继装备位下标类型
function LuaPlayerBloodSuitEquipMgr:GetEquipTypeAndPos(index)
    local pos = index % 100;
    local type = math.modf((index - 300000 - pos) / 100)
    return type, pos
end

--region 初始化
function LuaPlayerBloodSuitEquipMgr:Init()
    self:InitBloodSuitDic()
end

---初始化血继套装字典信息
function LuaPlayerBloodSuitEquipMgr:InitBloodSuitDic()
    clientTableManager.cfg_bloodsuit_combinationManager:ForPair(function(id, tbl)
        uiStaticParameter.mBloodSuitTypeName[id] = tbl:GetName()
    end)
    if self.BloodSuitDic == nil then
        ---@type table<LuaEquipBloodSuitType,LuaPlayerEquipBloodSuitListData>
        self.BloodSuitDic = {}
    end
    self:AddBloodSuitDic(LuaEquipBloodSuitType.Yao)
    self:AddBloodSuitDic(LuaEquipBloodSuitType.Xian)
    self:AddBloodSuitDic(LuaEquipBloodSuitType.Mo)
    self:AddBloodSuitDic(LuaEquipBloodSuitType.Ling)
    self:AddBloodSuitDic(LuaEquipBloodSuitType.Shen)
end

---添加血继字典信息
function LuaPlayerBloodSuitEquipMgr:AddBloodSuitDic(key)
    self.BloodSuitDic[key] = luaclass.LuaPlayerEquipBloodSuitListData:New()
    self.BloodSuitDic[key]:Init(key)
end
--endregion

--region 刷新信息
---刷新血继装备套装字典
---@param tblData bagV2.BagItemInfo lua table类型消息数据
function LuaPlayerBloodSuitEquipMgr:RefreShBloodSuitDic(tblData, index)

    local type, pos = self:GetEquipTypeAndPos(index)
    if self.BloodSuitDic[type] == nil then
        return
    end
    self.BloodSuitDic[type]:RefreShData(tblData, pos)
end

---清理血继装备套装字典
function LuaPlayerBloodSuitEquipMgr:CleanBloodSuitDic()
    if self.BloodSuitDic == nil then
        return
    end
    for i, v in pairs(self.BloodSuitDic) do
        if v ~= nil then
            v:CleanData()
        end
    end
end
--endregion

--region 得到数据
---得到指定类型的一套血继Manager
---@param type  LuaEquipBloodSuitType 血继装备类型
---@return LuaPlayerEquipBloodSuitListData
function LuaPlayerBloodSuitEquipMgr:GetSingleBloodSuitListData(type)
    if self.BloodSuitDic[type] == nil then
        return
    end
    return self.BloodSuitDic[type]
end

---得到指定类型的一套血继列表
---@param type  LuaEquipBloodSuitType 血继装备类型
---@return table<LuaEquipBloodSuitItemType,LuaEquipDataBloodSuitItem>
function LuaPlayerBloodSuitEquipMgr:GetSingleBloodSuitDic(type)
    if self.BloodSuitDic[type] == nil then
        return
    end
    return self.BloodSuitDic[type].SingleBloodSuitDic
end

---得到指定血继装备
---@param  type  LuaEquipBloodSuitType 血继装备类型
---@param  pos  LuaEquipBloodSuitItemType 血继装备位下标类型类型
---@return LuaEquipDataBloodSuitItem
function LuaPlayerBloodSuitEquipMgr:GetBloodSuitItem(type, pos)
    local dic = self:GetSingleBloodSuitDic(type)
    if dic == nil then
        return nil
    end
    return dic[pos]
end

--endregion

---是否开启指定类型的装备
function LuaPlayerBloodSuitEquipMgr:IsOpenEquipType(type)
    if type == nil then
        return false
    end
    local EquipTypeDic = clientTableManager.cfg_bloodsuit_combinationManager.EquipTypeDic
    if EquipTypeDic[type] == nil or EquipTypeDic[type]:GetConditions() == nil or EquipTypeDic[type]:GetConditions().list == nil then
        return false
    end

    for i, v in pairs(EquipTypeDic[type]:GetConditions().list) do
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) then
            return false, i
        end
    end
    return true
end

---得到血继类型
---@param ItemType number
function LuaPlayerBloodSuitEquipMgr:GetBloodsuitType(ItemType)
    if ItemType == nil then
        ItemType = self.NowSelectEquipItemType
    end
    if ItemType == nil then
        return 1
    end
    if ItemType <= 8 then
        return 1
    elseif ItemType >= 8 then
        return 2
    end
end

---得到指定类型的背包道具
function LuaPlayerBloodSuitEquipMgr:GetSpecifyTypeBagItemInfo()
    local nowBagItemInfo = nil
    local nowpriority = nil
    local bloodLevel = 0
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return
    end
    local bagItems = CS.CSScene.MainPlayerInfo.BagInfo.BagItems
    if bagItems == nil then
        return
    end
    ---@type table<number,bagBloodsuitInfo>
    local targetPriorityList = {}
    for i, v in pairs(bagItems) do
        local BloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(v.itemId)
        ---是否是当前选中的装备位的装备
        local isNowSuitItem = BloodsuitTbl ~= nil and BloodsuitTbl:GetQualityLevel() == self.NowSelectSuit and BloodsuitTbl:GetType() == self:GetBloodsuitType()
        local isWearSameBloodsuit = false
        if BloodsuitTbl ~= nil then
            isWearSameBloodsuit = self:IsWearSameBloodsuit(BloodsuitTbl:GetItemid(), self.NowSelectSuit)
        end

        if isNowSuitItem and isWearSameBloodsuit == false then
            --if nowpriority == nil then
            --    nowBagItemInfo = v
            --elseif nowpriority.bloodLevel > bloodLevel then
            --    bloodLevel = nowpriority.bloodLevel
            --    nowBagItemInfo = v
            --elseif BloodsuitTbl:GetPriority() > nowpriority then
            --    nowBagItemInfo = v
            --    nowpriority = BloodsuitTbl:GetPriority()
            --end
            ---@class bagBloodsuitInfo
            local bagBloodsuitInfo = {
                bagItemInfo = v,
                bloodsuitTbl = BloodsuitTbl
            }
            table.insert(targetPriorityList, bagBloodsuitInfo)
        end
    end
    table.sort(targetPriorityList, function(l, r)
        if l.bagItemInfo.bloodLevel == r.bagItemInfo.bloodLevel then
            return l.bloodsuitTbl:GetPriority() > r.bloodsuitTbl:GetPriority()
        end
        return l.bagItemInfo.bloodLevel > r.bagItemInfo.bloodLevel
    end)
    if #targetPriorityList >= 1 then
        nowBagItemInfo = targetPriorityList[1].bagItemInfo
    end
    return nowBagItemInfo
end

---是否能使用
---0 裝備無法使用
---1 品阶不符
---2 格子类型不符
---@return boolean,number
function LuaPlayerBloodSuitEquipMgr:IsCanUseBloodSuit(itemTbl, type)
    if itemTbl == nil then
        return false, 0
    end
    local bloodsuit = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemTbl.id)
    if bloodsuit == nil then
        return false, 0
    end
    if type == nil then
        type = self.NowSelectSuit
    end
    if bloodsuit:GetQualityLevel() ~= type then
        return false, 1
    end
    if bloodsuit:GetType() ~= self:GetBloodsuitType() then
        return false, 2
    end
    return true
end

---不可操作的时候弹出的Tips
function LuaPlayerBloodSuitEquipMgr:NotUseTips(go, notUseIndex)
    if notUseIndex == 1 then
        Utility.ShowPopoTips(go, "品阶不符", 428)
    elseif notUseIndex == 2 then
        Utility.ShowPopoTips(go, "格子类型不符", 428)
    elseif notUseIndex == 0 then
        Utility.ShowPopoTips(go, "该面板不可进行此操作", 428)
    end
end

---是否穿戴血繼
---@return boolean 是否穿戴血繼
function LuaPlayerBloodSuitEquipMgr:IsWearBloodSuit()
    if self.BloodSuitDic == nil then
        return false
    end
    for i, v in pairs(self.BloodSuitDic) do
        if v.SingleBloodSuitDic ~= nil then
            for i, v in pairs(v.SingleBloodSuitDic) do
                if v.BagItemInfo ~= nil then
                    return true
                end
            end
        end
    end
    return false
end

---是否穿戴指定道具血继血繼
---@return boolean 是否穿戴指定道具血继血繼
function LuaPlayerBloodSuitEquipMgr:IsWearBloodSuitSpecifyItemID(itemID)
    if self.BloodSuitDic == nil then
        return false
    end
    if itemID == nil then
        return false
    end
    for i, v in pairs(self.BloodSuitDic) do
        if v.SingleBloodSuitDic ~= nil then
            for i, v in pairs(v.SingleBloodSuitDic) do
                if v.ItemID == itemID then
                    return true
                end
            end
        end
    end
    return false
end

--region 红点数据

---是否显示血继红点
---@param type LuaEquipBloodSuitType 血继装备类型
function LuaPlayerBloodSuitEquipMgr:IsShowBloodSuitRed(type)
    if not self:IsOpenBloodSuitSystem() then
        return false
    end
    if self.SuitTypeCanUseDic == nil then
        return false
    end
    if type == nil then
        for i, v in pairs(self.SuitTypeCanUseDic) do
            if v.iscanUse == true then
                return true
            end
        end
    else
        if self.SuitTypeCanUseDic[type] ~= nil and self.SuitTypeCanUseDic[type].iscanUse == true then
            return true
        end
    end
    return false
end

-----是否开启血继系统
--function LuaPlayerBloodSuitEquipMgr:IsOpenBloodSuitSystem()
--    if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(10050) then
--        return false
--    end
--    return true
--end

---@return boolean 是否开启血继系统
function LuaPlayerBloodSuitEquipMgr:IsOpenBloodSuitSystem()
    if self.BloodSuitCondition == nil then
        local data = {}
        local res, conditions = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22377)
        if res == false then
            return false
        end
        local strs = string.Split(conditions.value, '&')
        if strs == nil or #strs == 0 then
            return false
        end
        for i = 1, #strs do
            local str = strs[i]
            local condition = string.Split(str, '#')
            if #condition >= 1 and tonumber(condition[1]) == 5 then
                self.BloodSuitCondition = condition
            end
        end
    end
    local conditionIds = self.BloodSuitCondition
    if conditionIds and #conditionIds >= 2 then
        for j = 2, #conditionIds do
            if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionIds[j]) then
                return false
            end
        end
    end
    return true
end

---刷新红点数据
function LuaPlayerBloodSuitEquipMgr:RefreShRedData()
    if not self:IsOpenBloodSuitSystem() then
        return false
    end
    local bagItems = CS.CSScene.MainPlayerInfo.BagInfo.BagItems
    if bagItems == nil then
        return
    end
    self:RefreShOpenSuitTypeList()
    self:ResetSuitTypeCanUseDic()
    for i, v in pairs(bagItems) do
        self:RefreShAllBloodSuitEquipData(v.itemId)
    end
    self:CallAllBloodSuitRedRed()
    luaEventManager.DoCallback(LuaCEvent.RefreshBlooodSuitEquipInfo)
end

---Call所有红点
function LuaPlayerBloodSuitEquipMgr:CallAllBloodSuitRedRed()
    local BloodSuit_Yao = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_Yao);
    local BloodSuit_Xian = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_Xian);
    local BloodSuit_Mo = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_Mo);
    local BloodSuit_Ling = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_Ling);
    local BloodSuit_Shen = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_Shen);
    local BloodSuit_All = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BloodSuit_All);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_Yao);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_Xian);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_Mo);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_Ling);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_Shen);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(BloodSuit_All);
end

---套装类型字典
LuaPlayerBloodSuitEquipMgr.SuitTypeDic = { LuaEquipBloodSuitType.Yao, LuaEquipBloodSuitType.Xian, LuaEquipBloodSuitType.Mo, LuaEquipBloodSuitType.Ling, LuaEquipBloodSuitType.Shen }

---重置开启套装类型字典
function LuaPlayerBloodSuitEquipMgr:RefreShOpenSuitTypeList()
    ---@type table<number,LuaEquipBloodSuitType>
    self.OpenSuitTypeList = {}
    for i, v in pairs(LuaPlayerBloodSuitEquipMgr.SuitTypeDic) do
        local isOpenEquipType = self:IsOpenEquipType(v)
        if isOpenEquipType then
            table.insert(self.OpenSuitTypeList, v)
        end
    end
    return self.OpenSuitTypeList
end

---重置可以使用装备字典
function LuaPlayerBloodSuitEquipMgr:ResetSuitTypeCanUseDic()
    ---@type table<number,SuitTypeRed>
    self.SuitTypeCanUseDic = {}
    if self.OpenSuitTypeList == nil then
        self:RefreShOpenSuitTypeList()
    end
    for i, v in pairs(self.OpenSuitTypeList) do
        ---@class SuitTypeRed
        local SuitTypeRed = {
            iscanUse = false,
            iscanUseBody = false,
            iscanUseEgg = false,
        }
        self.SuitTypeCanUseDic[v] = SuitTypeRed
    end
end

---刷新所有血继装备位是否有可以新增装备字典
function LuaPlayerBloodSuitEquipMgr:RefreShAllBloodSuitEquipData(itemId)
    self:IsBetterBloodSuitEquipData(itemId, function(type, BloodsuitType)
        self.SuitTypeCanUseDic[type].iscanUse = true
        if BloodsuitType == 1 then
            self.SuitTypeCanUseDic[type].iscanUseEgg = true
        elseif BloodsuitType == 2 then
            self.SuitTypeCanUseDic[type].iscanUseBody = true
        end
    end)
end

---是否是更好的血继装备
---@param itemId number 道具ID
---@param extFunction function 当是更好的血继装备时候回调方法 不需要可不传
function LuaPlayerBloodSuitEquipMgr:IsBetterBloodSuitEquipData(itemId, extFunction)
    if itemId == nil then
        return false
    end
    local bloodsuit = clientTableManager.cfg_bloodsuitManager:TryGetValue(itemId)
    if bloodsuit == nil then
        return false
    end
    local isCanUseItem = false
    --if self.OpenSuitTypeList == nil then
    --    self:RefreShOpenSuitTypeList()
    --end
    if self.OpenSuitTypeList == nil then
        return false
    end
    for i, v in pairs(self.OpenSuitTypeList) do
        if self.SuitTypeCanUseDic[v] ~= nil then
            for p = 1, 12 do
                if self:IsIndexHavaEquip(i, p) == false then
                    local BloodsuitType = self:GetBloodsuitType(p)
                    local iscanUse = self:IsCanUseBloodSuitRed(bloodsuit, i, BloodsuitType)
                    local isWearSameBloodsuit = self:IsWearSameBloodsuit(itemId, i)
                    local equipIndex = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetEquipIndex(v, p)
                    local isUnlocked = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsEquipGridUnlocked(equipIndex)
                    if isUnlocked and iscanUse == true and isWearSameBloodsuit == false then
                        isCanUseItem = true
                        if extFunction ~= nil then
                            extFunction(v, BloodsuitType)
                        end
                        --self.SuitTypeCanUseDic[v].iscanUse = true
                        --if BloodsuitType == 1 then
                        --    self.SuitTypeCanUseDic[v].iscanUseEgg = true
                        --elseif BloodsuitType == 2 then
                        --    self.SuitTypeCanUseDic[v].iscanUseBody = true
                        --end
                    end
                end
            end
        end
    end
    return isCanUseItem
end

---得到已經穿戴相同血繼
---@return LuaEquipDataBloodSuitItem
function LuaPlayerBloodSuitEquipMgr:GetWearSameBloodsuit(itemId, type)
    local nowData = self:GetSingleBloodSuitDic(type)
    if nowData == nil then
        return nil
    end
    for i, v in pairs(nowData) do
        if v.ItemID == itemId then
            return v
        end
    end
    return nil
end

---是否已經穿戴相同血繼
function LuaPlayerBloodSuitEquipMgr:IsWearSameBloodsuit(itemId, type)
    local nowData = self:GetSingleBloodSuitDic(type)
    if nowData == nil then
        return false
    end
    for i, v in pairs(nowData) do
        if v.ItemID == itemId then
            return true
        end
    end
    return false

end

function LuaPlayerBloodSuitEquipMgr:IsCanUseBloodSuitRed(bloodsuit, type, pos)
    if bloodsuit == nil then
        return false
    end
    if bloodsuit:GetQualityLevel() ~= type then
        return false
    end
    if bloodsuit:GetType() ~= pos then
        return false
    end
    return true
end

---指定装备位是否有装备
---@param type LuaEquipBloodSuitType 血继装备类型
---@param bloodsuitType number 1 1~8装备位 2 9~12 装备位
---@return boolean
function LuaPlayerBloodSuitEquipMgr:IsIndexHavaEquip(type, pos)

    local item = self:GetBloodSuitItem(type, pos)
    if item == nil then
        return false
    end
    if item.BagItemInfo == nil then
        return false
    end
    return true
end

--endregion

--region 属性数据获取
---@return table<LuaEnumAttributeType,BloodSuitAttributeData>
function LuaPlayerBloodSuitEquipMgr:GetAllEquipAttribute()
    local AllAttribute = {}
    for i = 1, #uiStaticParameter.mBloodSuitType do
        local type = uiStaticParameter.mBloodSuitType[i]
        local singleData = self:GetSingleBloodSuitListData(type)
        if singleData then
            ---@type table<LuaEnumAttributeType,BloodSuitAttributeData>
            local attribute = singleData:GetBloodSuitAttribute()
            for k, v in pairs(attribute) do
                ---@type BloodSuitAttributeData
                local data = AllAttribute[k]
                if data == nil then
                    data = {}
                    data.attributeType = k
                    if v.min then
                        data.min = 0
                    end
                    if v.max then
                        data.max = 0
                    end
                    data.sort = v.sort
                    AllAttribute[k] = data
                end
                if v.min then
                    data.min = data.min + v.min
                end
                if v.max then
                    data.max = data.max + v.max
                end
            end
        end
    end
    return AllAttribute
end

---得到已开启并装备血继的最大类型
function LuaPlayerBloodSuitEquipMgr:GetMaxOpenEquipType()
    for i = #LuaPlayerBloodSuitEquipMgr.SuitTypeDic, 1, -1 do
        for c = 1, 12 do
            if self:IsIndexHavaEquip(LuaPlayerBloodSuitEquipMgr.SuitTypeDic[i], c) then
                return i
            end
        end
    end
    return 0
end

--endregion

--region 其他玩家特殊数据处理
---得到其他玩家开启页签列表
function LuaPlayerBloodSuitEquipMgr:GetOtherOpenSuitTypeList()
    ---@type table<number,LuaEquipBloodSuitType>
    self.OpenSuitTypeList = {}
    local maxIndex = self:GetMaxOpenEquipType()
    if maxIndex == 0 then
        maxIndex = #LuaPlayerBloodSuitEquipMgr.SuitTypeDic
    end
    local index = 0
    for i = 1, maxIndex do
        local v = LuaPlayerBloodSuitEquipMgr.SuitTypeDic[i]
        local isOpenEquipType = self:IsOpenOtherEquipType(v)
        if isOpenEquipType then
            table.insert(self.OpenSuitTypeList, v)
        end
    end
    return self.OpenSuitTypeList
end

---其玩家是否开启指定类型的装备
function LuaPlayerBloodSuitEquipMgr:IsOpenOtherEquipType(type)
    if type == nil then
        return false
    end
    local EquipTypeDic = clientTableManager.cfg_bloodsuit_combinationManager.EquipTypeDic
    if EquipTypeDic[type] == nil or EquipTypeDic[type]:GetConditions() == nil then
        return false
    end

    for i, v in pairs(EquipTypeDic[type]:GetConditions().list) do
        local conditionType = 0;
        local isfind, info = CS.Cfg_ConditionManager.Instance.dic:TryGetValue(v)
        if isfind then
            conditionType = info.conditionType
        end
        if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v) and conditionType == 8 then
            return false, i
        end
    end
    return true
end
--endregion


return LuaPlayerBloodSuitEquipMgr