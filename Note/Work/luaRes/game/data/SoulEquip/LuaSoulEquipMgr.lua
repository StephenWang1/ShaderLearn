---@class LuaSoulEquipMgr
local LuaSoulEquipMgr = {};

---@type table<number,table<number, table<number, TABLE.cfg_items>>> <equipSubType, <equipId, <career, itemTable>>>
LuaSoulEquipMgr.mEquipSubTypeToSoulEquipDic = nil;

---孔位数量
LuaSoulEquipMgr.holeCount = 3;

function LuaSoulEquipMgr:Init()
    self.mEquipSubTypeToSoulEquipDic = {};
    ---@param tbl TABLE.cfg_items
    clientTableManager.cfg_itemsManager:ForPair(function(id, tbl)
        if (tbl:GetType() == luaEnumItemType.Equip) then
            if (self:IsSoulEquip(tbl)) then
                local subType = tbl:GetSubType();
                if (self.mEquipSubTypeToSoulEquipDic[subType] == nil) then
                    self.mEquipSubTypeToSoulEquipDic[subType] = {};
                end
                ---@type number 职业偏向
                local career = tbl:GetCareer()
                if (self.mEquipSubTypeToSoulEquipDic[subType][career] == nil) then
                    self.mEquipSubTypeToSoulEquipDic[subType][career] = {};
                end
                self.mEquipSubTypeToSoulEquipDic[subType][career][tbl:GetId()] = tbl;
            end
        end
    end);
end

function LuaSoulEquipMgr:GetEquipIndexList()
    if (self.mEquipIndexList == nil) then
        self.mEquipIndexList = {};
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_HEAD));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_BELT));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_SHOES));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND));
        table.insert(self.mEquipIndexList, Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING));
    end
    return self.mEquipIndexList;
end

--region网络消息刷新数据
---@param tblData equipV2.WholeSoulEquips 所有魂装数据
function LuaSoulEquipMgr:UpdateAllSoulEquip(tblData)
    if tblData == nil then
        return
    end
    for i = 1, #tblData.allSoulEquipInfo do
        ---@type equipV2.AllSoulEquipInfo
        local singleInfo = tblData.allSoulEquipInfo[i]
        self:UpdateSoulEquipSetInfo(singleInfo)
    end
end

---@param type  LuaEnumSoulEquipType
---@return LuaSoulEquipDataClass
function LuaSoulEquipMgr:GetSingleSoulEquipClass(type)
    if self.mSuitBelongToEquipDataClass == nil then
        self.mSuitBelongToEquipDataClass = {}
    end
    local dataClass = self.mSuitBelongToEquipDataClass[type]
    if dataClass == nil then
        dataClass = luaclass.LuaSoulEquipDataClass:New()
        self.mSuitBelongToEquipDataClass[type] = dataClass
    end
    return dataClass
end

---@public 更新单个魂装镶嵌数据
---@param tblData equipV2.AllSoulEquipInfo 单个类型魂装所有数据
function LuaSoulEquipMgr:UpdateSoulEquipSetInfo(tblData)
    local class = self:GetSingleSoulEquipClass(tblData.type)
    class:UpdateSoulEquipSetInfo(tblData);
    ---表示单个 魂装/仙装/神器 数据变动
    luaEventManager.DoCallback(LuaCEvent.mInlaySingleDataChange, tblData.type)
    if tblData.type == LuaEnumSoulEquipType.XianZhuang then
        self:XianZhuangRedPointChange();
    end
end
--endregion

--region通用获取数据方法
---@param type LuaEnumSoulEquipType
---@return table<number,LuaSoulEquipVo> 获得身上所有魂装/仙装/神器
function LuaSoulEquipMgr:GetSingleTypeAllEquip(type)
    local class = self:GetSingleSoulEquipClass(type)
    return class:GetAllBodySoulEquip()
end

---@public
---@return bagV2.BagItemInfo 获得对应装备位上镶嵌的 魂装/仙装/神器
---@param type LuaEnumSoulEquipType
function LuaSoulEquipMgr:GetSingleTypeEquipByEquipIndex(type, equipIndex, SelectInlayHolePosition)
    local class = self:GetSingleSoulEquipClass(type)
    return class:GetSoulEquipToEquipIndex(equipIndex, SelectInlayHolePosition);
end

---@public
---@return table<number,LuaSoulEquipHoleInfo> 获得对应装备位上镶嵌的全部 魂装/仙装/神器
---@param type LuaEnumSoulEquipType
function LuaSoulEquipMgr:GetSingleTypeEquipByEquipIndex_All(type, equipIndex)
    local class = self:GetSingleSoulEquipClass(type)
    return class:GetSoulEquipToEquipIndex_All(equipIndex);
end

---@public
---@return LuaSoulEquipVo 获得对应装备位上镶嵌的装备类 魂装/仙装/神器
---@param type LuaEnumSoulEquipType
function LuaSoulEquipMgr:GetSoulEquipClassToEquipIndex(type, equipIndex)
    local class = self:GetSingleSoulEquipClass(type)
    return class:GetSoulEquipClassToEquipIndex(equipIndex);
end

---region 格子开启及消耗条件
local OpeningConditions = {}
---当前格子是否满足显示条件
---@return
function LuaSoulEquipMgr:CanItBeDisplayed(subIndex)
    if (OpeningConditions == nil or #OpeningConditions <= 0) then
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23031)
        if (isFind) then
            OpeningConditions = string.Split(tbl_global.value, '&')
        end
    end
    if (OpeningConditions ~= nil and subIndex > 0 and subIndex <= #OpeningConditions) then
        local conditions = string.Split(OpeningConditions[subIndex], '#')
        for i = 1, #conditions do
            if (Utility.IsMainPlayerMatchCondition(tonumber(conditions[i])).success == false) then
                return false
            end
        end
    end
    return true
end

---能显示的格子数量
---@return
function LuaSoulEquipMgr:CanBeDisplayedCount()
    if (OpeningConditions == nil or #OpeningConditions <= 0) then
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23031)
        if (isFind) then
            OpeningConditions = string.Split(tbl_global.value, '&')
        end
    end

    ---根据可显示数量，判断
    local canBeDisplayedCount = 0
    for i = 1, self.holeCount do
        if (self:CanItBeDisplayed(i)) then
            canBeDisplayedCount = canBeDisplayedCount + 1
        end
    end
    return canBeDisplayedCount
end

local OpenCostConditions = {}
---满足开启格子的消耗
---@return boolean
function LuaSoulEquipMgr:CanTurnOnTheGrid(type, equipIndex)
    if (type == nil or equipIndex == nil) then
        return false
    end
    if (OpenCostConditions == nil or #OpenCostConditions <= 0) then
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23032)
        if (isFind) then
            OpenCostConditions = string.Split(tbl_global.value, '#')
        end
    end
    local soulEquip = self:GetSoulEquipClassToEquipIndex(type, equipIndex)

    if (soulEquip == nil) then
        return false
    end

    ---@type number 孔位解锁数量
    local openHoleCount = 3
    if (soulEquip:GetSoulEquip_SubIndex(1) == nil) then
        openHoleCount = openHoleCount - 1
    end
    if (soulEquip:GetSoulEquip_SubIndex(3) == nil) then
        openHoleCount = openHoleCount - 1
    end

    ---根据未解锁孔位，判断是否满足解锁条件
    if (OpenCostConditions ~= nil and openHoleCount <= #OpenCostConditions) then
        local Condition = Utility.IsMainPlayerMatchCondition(tonumber(OpenCostConditions[openHoleCount]))
        return Condition.success, Condition
    end
    return false
end
--endregion

---获取一个格子位置
function LuaSoulEquipMgr:GetFirstGridPosition(type, equipIndex)
    local soulEquip = self:GetSoulEquipClassToEquipIndex(type, equipIndex)

    if (soulEquip ~= nil) then
        for i = 1, LuaSoulEquipMgr.holeCount do
            if (self:CanItBeDisplayed(i)) then
                local holeInfo = soulEquip:GetSoulEquip_SubIndex(i)
                if (holeInfo ~= nil and holeInfo.bagItemInfo == nil) then
                    return i
                end
            end
        end
        for i = 1, LuaSoulEquipMgr.holeCount do
            if (self:CanItBeDisplayed(i)) then
                local holeInfo = soulEquip:GetSoulEquip_SubIndex(i)
                if (holeInfo ~= nil) then
                    return i
                end
            end
        end
    end
    return 0
end

---获取一个已解锁但未镶嵌的格子
function LuaSoulEquipMgr:GetTheUnmountedGrid(type, equipIndex)
    local soulEquip = self:GetSoulEquipClassToEquipIndex(type, equipIndex)
    if (soulEquip ~= nil) then
        for i = 1, LuaSoulEquipMgr.holeCount do
            if (self:CanItBeDisplayed(i)) then
                local holeInfo = soulEquip:GetSoulEquip_SubIndex(i)
                if (holeInfo ~= nil and holeInfo.bagItemInfo == nil) then
                    return i
                end
            end
        end
    end
    return 0
end

---检查能不能镶嵌
---@param bagItemInfo bagV2.BagItemInfo
function LuaSoulEquipMgr:CheckIfItCanBeMounted(type, equipIndex, subIndex, bagItemInfo)
    if (bagItemInfo == nil) then
        return false
    end

    local soulEquip = self:GetSoulEquipClassToEquipIndex(type, equipIndex)
    if (soulEquip == nil) then
        return false
    end

    local holeInfo = soulEquip:GetSoulEquip_SubIndex(subIndex)
    if (holeInfo == nil) then
        CS.Utility.ShowRedTips('孔位未解锁')
        return false
    end

    if (self:CheckWhetherTheSameTypeOfEquipmentIsInlaid(type, equipIndex, bagItemInfo, subIndex)) then
        CS.Utility.ShowRedTips('已镶嵌相同类型仙装')
        return false
    end
    return true
end

---检查是否镶嵌同类型装备
function LuaSoulEquipMgr:CheckWhetherTheSameTypeOfEquipmentIsInlaid(type, equipIndex, bagItemInfo, subIndex)
    local sameType, better = false, false
    local soulEquip = self:GetSoulEquipClassToEquipIndex(type, equipIndex)
    if (soulEquip == nil) then
        return sameType, better
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if (itemTbl ~= nil) then
        local extraMonEffectInlay = itemTbl:GetExtraMonEffectInlay()
        for i, v in pairs(soulEquip:GetSoulEquip_All()) do
            if (v.cfg_items ~= nil and v.cfg_items:GetDifferentInlay() ~= nil and Utility.HasTableValue(v.cfg_items:GetDifferentInlay().list, extraMonEffectInlay) and subIndex ~= i) then
                if (itemTbl:GetGroup() > v.cfg_items:GetGroup()) then
                    better = true
                end
                sameType = true
            end
        end
    end
    return sameType, better
end

--endregion

--region 魂装部分保留原有引用，把逻辑抽出来
---@return LuaSoulEquipDataClass
function LuaSoulEquipMgr:GetLuaSoulEquipData()
    return self:GetSingleSoulEquipClass(LuaEnumSoulEquipType.HunZhuang)
end

---@public 获得装备子类型对应的可镶嵌的魂装集合
---@param equipSubType number
---@param career number
---@return table<number, TABLE.cfg_items>
function LuaSoulEquipMgr:GetEquipSubTypeToSoulEquipSet(equipSubType, career)
    if (self.mEquipSubTypeToSoulEquipDic ~= nil and self.mEquipSubTypeToSoulEquipDic[equipSubType] ~= nil) then
        local careerSoulEquipDic = self.mEquipSubTypeToSoulEquipDic[equipSubType][career];
        return careerSoulEquipDic;
    end
    return nil;
end

---@public 是否是魂装
---@param tbl TABLE.cfg_items
function LuaSoulEquipMgr:IsSoulEquip(tbl)
    if (tbl ~= nil and tbl:GetInsertLv() ~= nil and #tbl:GetInsertLv().list > 0) then
        if (tbl:GetSuitBelong() == LuaEnumSoulEquipType.HunZhuang) then
            return true;
        end
    end
    return false;
end

---@public 是否可镶嵌装备
---@param tbl TABLE.cfg_items
function LuaSoulEquipMgr:IsInlayEquip(tbl)
    if (tbl ~= nil and tbl:GetInsertLv() ~= nil and #tbl:GetInsertLv().list > 0) then
        return true;
    end
    return false;
end

---@public 是否激活魂装套装
function LuaSoulEquipMgr:IsSuitActive(suitId)
    return self:GetLuaSoulEquipData():IsSuitActive(suitId);
end

---@public 是否能镶嵌魂装
---@param itemId number
function LuaSoulEquipMgr:CanSetSoulEquip(itemId)
    return self:GetLuaSoulEquipData():CanSetSoulEquip(itemId);
end

---@public 获得激活的魂装套装ID
---@return table<number>
function LuaSoulEquipMgr:GetActiveSoulEquipSuitIds()
    return self:GetLuaSoulEquipData():GetActiveSoulEquipSuitIds();
end

---@public 获得背包内可镶嵌的魂装列表
---@return table<bagV2.BagItemInfo>
function LuaSoulEquipMgr:GetEquipCanSetSoulEquipList(equipId)
    local returnList = {};
    ---@type TABLE.cfg_items
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(equipId);
    if (tbl ~= nil) then
        if (tbl:GetType() == luaEnumItemType.Equip) then
            ---@type table<number, TABLE.cfg_items>
            local careerEquipSubTypeToSoulEquipSetDic = self:GetEquipSubTypeToSoulEquipSet(tbl:GetSubType(), Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career));
            ---玩家职业
            if (careerEquipSubTypeToSoulEquipSetDic ~= nil) then
                ---@param v TABLE.cfg_items+-
                for k, v in pairs(careerEquipSubTypeToSoulEquipSetDic) do
                    if (v:GetInsertLv() ~= nil) then
                        ---转生等级
                        if (#v:GetInsertLv().list > 1) then
                            local needLevel = v:GetInsertLv().list[1];
                            local needReinLevel = v:GetInsertLv().list[2];
                            if (tbl:GetUseLv() >= needLevel and tbl:GetReinLv() >= needReinLevel) then
                                local count, bagItemInfos = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemListByItemId(k);
                                if (bagItemInfos ~= nil) then
                                    for k, v in pairs(bagItemInfos) do
                                        table.insert(returnList, v);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return returnList;
end

---@public 获得镶嵌所需限制等级
function LuaSoulEquipMgr:GetSoulEquipSetNeedLevel(itemId)
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
    if (self:IsInlayEquip(tbl)) then
        local needLevel = tbl:GetInsertLv().list[1];
        local needReinLevel = tbl:GetInsertLv().list[2];
        return needLevel, needReinLevel;
    end
    return 0, 0
end

---@public 获得身上镶嵌的所有魂装
---@return table<number, LuaSoulEquipVo>
function LuaSoulEquipMgr:GetAllBodySoulEquip()
    return self:GetLuaSoulEquipData():GetAllBodySoulEquip();
end

---@public 获得对应装备为上镶嵌的魂装
---@return bagV2.BagItemInfo
function LuaSoulEquipMgr:GetSoulEquipToEquipIndex(equipIndex)
    return self:GetLuaSoulEquipData():GetSoulEquipToEquipIndex(equipIndex);
end

---@public 获得对应装备位魂装的激活状态
---@return boolean
function LuaSoulEquipMgr:GetSoulEquipActiveState(equipIndex)
    return self:GetLuaSoulEquipData():GetSoulEquipActiveState(equipIndex)
end

---@public 获得身上镶嵌的魂装
---@return table<number,bagV2.BagItemInfo>
function LuaSoulEquipMgr:GetSetSoulEquipList(itemId)
    return self:GetLuaSoulEquipData():GetSetSoulEquipList(itemId)
end

---@public 默认魂装说明
---@return string
function LuaSoulEquipMgr:GetDefaultSoulEquipDes()
    if (self.mDefaultSoulEquipDes == nil) then
        local isFind, globalTable = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22834);
        if (isFind) then
            self.mDefaultSoulEquipDes = globalTable.value;
        end
    end
    if (self.mDefaultSoulEquipDes == nil) then
        self.mDefaultSoulEquipDes = "可随机获得本职业技能加成";
    end
    return self.mDefaultSoulEquipDes;
end

---@public 默认获得身上能镶嵌魂装的一件装备
function LuaSoulEquipMgr:GetDefaultCanSetSoulEquip()
    local list = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllEquipmentItemList();
    local defaultEquip = nil;
    for k, v in pairs(list) do
        if (self:CanSetSoulEquip(v.itemId)) then
            local soulEquip = self:GetSoulEquipToEquipIndex(v.index);
            if (soulEquip == nil) then
                local list = self:GetEquipCanSetSoulEquipList(v.itemId);
                if (#list > 0) then
                    return v;
                end
            end
            if (defaultEquip == nil) then
                defaultEquip = v;
            end
        end
    end
    return defaultEquip;
end

---@return number
function LuaSoulEquipMgr:GetEquipIndexBySetSoulEquip(lid)
    return self:GetLuaSoulEquipData():GetEquipIndexBySetSoulEquip(lid);
end
--endregion

--region仙装
---@return boolean 该身上道具等级是否可以进行镶嵌(勋章不论等级)
---@param bagItemInfo bagV2.BagItemInfo 玩家身上的装备
function LuaSoulEquipMgr:IsEquipCanInlay_XianZhuang(type, bagItemInfo)
    ---注释于2021/123 by zyb (策划说取消所有仙装镶嵌的限制)
    --local class = self:GetSingleSoulEquipClass(type)
    --if class then
    --    local level, reinLevel = class:GetSoulEquipSetLimit()
    --    local luaItemInfo = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    --    if luaItemInfo and luaItemInfo:GetType() == luaEnumItemType.Equip then
    --        if luaItemInfo:GetSubType() == LuaEnumEquipSubType.Equip_xunzhang then
    --            return true
    --        end
    --        return luaItemInfo:GetUseLv() >= level and luaItemInfo:GetReinLv() >= reinLevel
    --    end
    --end
    --return false

    ---如果身上装备有suitbelong就不可镶嵌(高翔2021/1/30要加的)
    local luaItemInfo = Utility.GetItemTblByBagItemInfo(bagItemInfo)
    if luaItemInfo:GetSuitBelong() and luaItemInfo:GetSuitBelong() ~= 0 then
        return false
    end
    return true;
end

---@return table<number,bagV2.BagItemInfo> 获取背包中所有可以镶嵌的装备列表
---@param bodyBagItemInfo bagV2.BagItemInfo 身上的装备
function LuaSoulEquipMgr:GetBagAllCanInlay_XianZhuang(equipType, bodyBagItemInfo)
    local CanEquipItemList = {}
    if bodyBagItemInfo == nil then
        return CanEquipItemList
    end

    local selectItemInfo = Utility.GetItemTblByBagItemInfo(bodyBagItemInfo)
    if selectItemInfo == nil then
        return CanEquipItemList
    end
    local type = selectItemInfo:GetType()
    local subType = selectItemInfo:GetSubType()

    ---@type LuaMainPlayerBagMgr
    local LuaMainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    local allItems = LuaMainPlayerBagMgr:GetAllBagItemData()

    for i, v in pairs(allItems) do
        ---@type bagV2.BagItemInfo
        local item = v;
        ---@type TABLE.cfg_items
        local itemTbl = Utility.GetItemTblByBagItemInfo(item)
        if itemTbl and itemTbl:GetType() == luaEnumItemType.Equip then
            local isSoulEquip = itemTbl:GetSuitBelong() == equipType --是对应类型魂装
            local isSameType = itemTbl:GetType() == type and itemTbl:GetSubType() == subType --装备类型相同
            local levelEnough = self:IsInsertLevelEnough(selectItemInfo, itemTbl) --镶嵌等级足够
            local isSameCareer = itemTbl:GetCareer() == LuaEnumCareer.Common or itemTbl:GetCareer() == self:GetMainPlayerCareer()
            local isSameSex = itemTbl:GetSex() == LuaEnumCareer.Common or itemTbl:GetSex() == self:GetMainPlayerSex()
            if isSoulEquip and isSameType and levelEnough and isSameCareer and isSameSex then
                table.insert(CanEquipItemList, item)
            end
        end
    end
    return CanEquipItemList
end

---@return LuaEnumCareer 主角职业
function LuaSoulEquipMgr:GetMainPlayerCareer()
    if self.mMainPlayerCareer == nil then
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            self.mMainPlayerCareer = Utility.EnumToInt(mainPlayerInfo.Career)
        end
    end
    return self.mMainPlayerCareer
end

function LuaSoulEquipMgr:GetMainPlayerSex()
    if self.mMainPlayerSex == nil then
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            self.mMainPlayerSex = Utility.EnumToInt(mainPlayerInfo.Sex)
        end
    end
    return self.mMainPlayerSex
end

---@return boolean 背包道具是否可以镶嵌到身上
---@param selectItemInfo TABLE.cfg_items 身上装备信息
---@param itemTbl TABLE.cfg_items 背包装备信息
function LuaSoulEquipMgr:IsInsertLevelEnough(selectItemInfo, itemTbl)
    if itemTbl and itemTbl:GetInsertLv() and itemTbl:GetInsertLv().list and #itemTbl:GetInsertLv().list >= 2 then
        local limit = itemTbl:GetInsertLv().list
        local level = limit[1]
        local reinLevel = limit[2]
        local XunZhangLevel = 0
        if #itemTbl:GetInsertLv().list >= 3 then
            XunZhangLevel = limit[3]
        end
        local levelEnough = selectItemInfo:GetUseLv() >= level
        local reinLevelEnough = selectItemInfo:GetReinLv() >= reinLevel
        if selectItemInfo:GetItemLevel() then
            return levelEnough and reinLevelEnough and selectItemInfo:GetItemLevel() >= XunZhangLevel
        else
            return levelEnough and reinLevelEnough
        end
    end
    return false
end

---@return number 获取推送仙装装备位
function LuaSoulEquipMgr:GetCurrentPushXianZhuang()
    return self.mCurrentPushMaterial
end
--endregion

--region 通用
---获取装备位上所有的镶嵌装备
---@param equipIndex number
---@return table<LuaSoulEquipVo>
function LuaSoulEquipMgr:GetEquipIndexAllInlayEquip(equipIndex)
    local InlayEquipClassTable = {}
    local sortSoulEquipTypeList = self:GetSortSoulEquipTypeList()
    for k, v in pairs(sortSoulEquipTypeList) do
        local soulEquipType = v
        ---@type LuaSoulEquipMgr
        local luaSoulEquipClass = self:GetSoulEquipClassToEquipIndex(soulEquipType, equipIndex)
        if luaSoulEquipClass ~= nil then
            table.insert(InlayEquipClassTable, luaSoulEquipClass)
        end
    end
    return InlayEquipClassTable
end

---获取排序魂装转装备类型列表
---@return table<LuaEnumSoulEquipType>
function LuaSoulEquipMgr:GetSortSoulEquipTypeList()
    local soulEquipTypeTable = {}
    for k, v in pairs(LuaEnumSoulEquipType) do
        table.insert(soulEquipTypeTable, v)
    end
    table.sort(soulEquipTypeTable, function(v1, v2)
        return v1 < v2
    end)
    return soulEquipTypeTable
end

---指定装备位是否有指定的装备类型的镶嵌装备
---@param equipIndex number
---@param inlayEquipType LuaEnumSoulEquipType
---@return LuaSoulEquipVo
function LuaSoulEquipMgr:GetCurTypeInlayEquip(equipIndex, inlayEquipType)
    local inlayEquipClassTable = self:GetEquipIndexAllInlayEquip(equipIndex)
    if type(inlayEquipClassTable) == 'table' then
        for k, v in pairs(inlayEquipClassTable) do
            ---@type LuaSoulEquipVo
            local soulEquipClass = v
            if soulEquipClass:IsInlayThisSetSuitType(inlayEquipType) then
                return soulEquipClass
            end
        end
    end
end

---获取装备位镶嵌装备适配物品的合批名字
---@param itemId number
---@param equipIndex number
function LuaSoulEquipMgr:GetInlayItemName(itemId, equipIndex)
    if type(itemId) ~= 'number' or type(equipIndex) ~= 'number' then
        return ""
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemInfo == nil then
        return ""
    end
    local itemColor = CS.Utility_Lua.GetItemColorByQualityValue(luaItemInfo:GetQuality())
    local itemName = luaItemInfo:GetName()
    local InlayEquipClassTable = self:GetEquipIndexAllInlayEquip(equipIndex)
    if itemColor == nil then
        itemColor = luaEnumColorType.White
    end
    return itemColor .. self:GetNameByNameOrder(InlayEquipClassTable, 1) .. itemName .. self:GetNameByNameOrder(InlayEquipClassTable, 2) .. self:GetNameByNameOrder(InlayEquipClassTable, 3)
end

---通过名字的order获取名字
---@param nameOrder number
---@param soulEquipClassTable table<LuaSoulEquipVo>
---@return string
function LuaSoulEquipMgr:GetNameByNameOrder(soulEquipClassTable, nameOrder)
    for k, v in pairs(soulEquipClassTable) do
        ---@type LuaSoulEquipVo
        local soulEquipClass = v
        return soulEquipClass:GetAllSuitInlayName_NameOrder(nameOrder)
    end
    return ""
end

---通过装备位获取底图名字和特效名字
---@param equipIndex number
---@return string,string,TABLE.cfg_inlay_effect
function LuaSoulEquipMgr:GetEquipIndexEffectNameAndBaseMap(equipIndex)
    local baseMapSpriteName = ""
    local effectName = ""
    local inlayEffectTbl = nil
    local InlayEquipClassTable = self:GetEquipIndexAllInlayEquip(equipIndex)
    for k, v in pairs(InlayEquipClassTable) do
        ---@type LuaSoulEquipVo
        local soulEquipClass = v
        if soulEquipClass:GetActiveState() == true and CS.StaticUtility.IsNullOrEmpty(soulEquipClass:GetInlayEffectName()) == false then
            effectName = soulEquipClass:GetInlayEffectName()
            inlayEffectTbl = soulEquipClass:GetInlayEffectTbl()
        end
        if soulEquipClass:GetActiveState() == true and CS.StaticUtility.IsNullOrEmpty(soulEquipClass:GetInlayBaseMap()) == false then
            baseMapSpriteName = soulEquipClass:GetInlayBaseMap()
        end
    end
    return baseMapSpriteName, effectName, inlayEffectTbl
end

function LuaSoulEquipMgr:GetInlayEquipName(itemId)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil or itemInfo:GetSuitBelong() <= 0 then
        return
    end
    if itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.XianZhuang then
        return "仙装"
    elseif itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.HunZhuang then
        return "魂装"
    elseif itemInfo:GetSuitBelong() == LuaEnumSoulEquipType.ShenQi then
        return "神器"
    end
end
--endregion

---物品是否可镶嵌且比身上以镶嵌的装备好
---@param itemId number
---@return boolean
function LuaSoulEquipMgr:IsBetterSoulEquipData(itemId)
    ---@type TABLE.cfg_items
    local tbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
    if (tbl ~= nil and self:MainPlayerCanInlayEquip(itemId)) then
        ---@type LuaEnumSoulEquipType
        local suitType = tbl:GetSuitBelong()
        local equipIndexes = Utility.GetEquipIndexesByLuaItemTbl(tbl);
        for k, v in pairs(equipIndexes) do
            local bodyInlayEquip = self:GetSingleTypeEquipByEquipIndex_All(suitType, v)
            if bodyInlayEquip == nil then
                return true
            else
                for i, j in pairs(bodyInlayEquip) do
                    if (j.bagItemInfo ~= nil) then
                        local compareId = self:CompareInlayEquip(itemId, j.bagItemInfo.itemId)
                        if compareId == 1 then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false;
end

---对比两个镶嵌装备
---@param firstItemId number
---@param secondItemId number
---@return number -1:传入数据有问题 0:firstItemInfo = secondItemInfo 1:firstItemInfo > secondItemInfo 2:firstItemInfo < secondItemInfo
function LuaSoulEquipMgr:CompareInlayEquip(firstItemId, secondItemId)
    if type(firstItemId) ~= 'number' or type(secondItemId) ~= 'number' then
        return -2
    end
    local firstItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(firstItemId)
    local secondItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(secondItemId)
    if firstItemInfo == nil or secondItemInfo == nil or self:IsInlayEquip(firstItemInfo) == false or self:IsInlayEquip(secondItemInfo) == false then
        return -2
    end
    if firstItemInfo:GetGroup() > secondItemInfo:GetGroup() then
        return 1
    elseif firstItemInfo:GetGroup() == secondItemInfo:GetGroup() then
        return 0
    else
        return -1
    end
    return -2
end

---是否可以镶嵌装备对应的装备位上
---@param itemId
---@return boolean
function LuaSoulEquipMgr:MainPlayerCanInlayEquip(itemId)
    if type(itemId) ~= 'number' then
        return false
    end
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if itemInfo == nil then
        return false
    end
    local equipIndexes = Utility.GetEquipIndexesByLuaItemTbl(itemInfo)
    for k, v in pairs(equipIndexes) do
        local equipIndex = v
        ---@type bagV2.BagItemInfo
        local bodyEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(equipIndex)
        if bodyEquip ~= nil and self:ItemCanInlayCurItem(itemId, bodyEquip.itemId) then
            return true
        end
    end
    return false
end

---镶嵌装备是否可以镶嵌到指定的装备上
---@param inlayEquipItemId number
---@param beInlayEquipItemId number
---@return boolean
function LuaSoulEquipMgr:ItemCanInlayCurItem(inlayEquipItemId, beInlayEquipItemId)
    if type(inlayEquipItemId) ~= 'number' or type(beInlayEquipItemId) ~= 'number' then
        return false
    end
    local inlayEquipItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(inlayEquipItemId)
    local beInlayEquipItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(beInlayEquipItemId)
    if inlayEquipItemInfo == nil or beInlayEquipItemInfo == nil or clientTableManager.cfg_itemsManager:MainPlayerCanUseItemAndCareer(inlayEquipItemId) == false or clientTableManager.cfg_itemsManager:MainPlayerCanUseItemAndCareer(beInlayEquipItemId) == false then
        return false
    end
    if self:GetLuaSoulEquipData():CanSetSoulEquip(beInlayEquipItemId) == false then
        return false
    end
    if (inlayEquipItemInfo:GetInsertLv() ~= nil and #inlayEquipItemInfo:GetInsertLv().list > 0) then
        local needLevel = 0;
        local needReinLevel = 0;
        if (#inlayEquipItemInfo:GetInsertLv().list > 0) then
            needLevel = inlayEquipItemInfo:GetInsertLv().list[1];
        end
        if (#inlayEquipItemInfo:GetInsertLv().list > 0) then
            needReinLevel = inlayEquipItemInfo:GetInsertLv().list[2];
        end
        return beInlayEquipItemInfo:GetReinLv() >= needReinLevel and beInlayEquipItemInfo:GetUseLv() >= needLevel
    end
    return false
end

---根据魂装名字获得镶嵌后的装备名字
---@param soulEquipId number 需要镶嵌的魂装id,用来替换已镶嵌名字
---@param itemId number 被镶嵌装备id
function LuaSoulEquipMgr:GetAddSoulEquipName(soulEquipId, itemId, equipIndex)
    if soulEquipId == nil or itemId == nil then
        return ""
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    if luaItemInfo == nil then
        return ""
    end
    local itemColor = CS.Utility_Lua.GetItemColorByQualityValue(luaItemInfo:GetQuality())
    local itemName = luaItemInfo:GetName()
    local InlayEquipClassTable = self:GetEquipIndexAllInlayEquip(equipIndex)

    local order, name = self:GetReplaceOrderName(soulEquipId)
    local name1 = order == 1 and name or self:GetNameByNameOrder(InlayEquipClassTable, 1)
    local name2 = order == 2 and name or self:GetNameByNameOrder(InlayEquipClassTable, 2)
    local name3 = order == 3 and name or self:GetNameByNameOrder(InlayEquipClassTable, 3)
    return itemColor .. name1 .. itemName .. name2 .. name3
end

---@return number,string 获得替换魂装的顺序和名字
function LuaSoulEquipMgr:GetReplaceOrderName(soulEquipId)
    if soulEquipId == nil then
        return 0, ""
    end
    local luaItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(soulEquipId)
    if luaItemInfo == nil then
        return 0, ""
    end
    local suitType = luaItemInfo:GetSuitBelong()
    local suitLevel = luaItemInfo:GetGroup()
    if suitType == nil or suitLevel == nil then
        return 0, ""
    end
    ---@type TABLE.cfg_suit
    local suitTbl = gameMgr:GetPlayerDataMgr():GetLuaSuitMgr():GetSuitTbl(suitType, suitLevel)
    if suitTbl ~= nil then
        return suitTbl:GetInlayNameOrder(), suitTbl:GetInlayName()
    end
end

--region 镶嵌孔位红点
---@public
---刷新仙装红点（背包变化/仙装变化）
function LuaSoulEquipMgr:XianZhuangRedPointChange()
    self:RefreshXianZhuangRedPoint()
    local XianZhuang = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.XianZhuangPush)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(XianZhuang)
end

---@public
---@return boolean 背包中是否有更好仙装
function LuaSoulEquipMgr:HasBetterXianZhuangEquipInBag()
    if LuaGlobalTableDeal:XianZhuangInlaySystemIsOpen() == false then
        return false
    end
    if self.mHasBetterXianZhaung == nil then
        self:RefreshXianZhuangRedPoint()
    end
    local noticeTbl = clientTableManager.cfg_noticeManager:TryGetValue(76)
    local isXianZhuangOpen = Utility.IsNoticeOpenSystem(noticeTbl)
    return self.mHasBetterXianZhaung and isXianZhuangOpen
end

---@public
---刷新仙装红点
function LuaSoulEquipMgr:RefreshXianZhuangRedPoint()
    ---可镶嵌红点
    local HasBetter, bodyEquip = self:GetXianZhuangHoleRedPoint()
    if (HasBetter == true) then
        self.mHasBetterXianZhaung = HasBetter
        self.mCurrentPushMaterial = bodyEquip
        return
    end

    local suitBelong = LuaEnumSoulEquipType.XianZhuang
    ---更好装备红点
    self.mCurrentPushMaterial = nil
    ---遍历背包
    ---@type LuaMainPlayerBagMgr
    local LuaMainPlayerBagMgr = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr()
    local allItems = LuaMainPlayerBagMgr:GetAllBagItemData()

    for i, v in pairs(allItems) do
        ---@type bagV2.BagItemInfo
        local item = v;
        ---@type TABLE.cfg_items
        local itemTbl = Utility.GetItemTblByBagItemInfo(item)
        if itemTbl and itemTbl:GetType() == luaEnumItemType.Equip then
            local isSoulEquip = itemTbl:GetSuitBelong() == suitBelong --是对应类型魂装
            local levelEnough = self:IsInsertLevelEnough(itemTbl, itemTbl) --镶嵌等级足够
            local isSameCareer = itemTbl:GetCareer() == LuaEnumCareer.Common or itemTbl:GetCareer() == self:GetMainPlayerCareer()
            local isSameSex = itemTbl:GetSex() == LuaEnumCareer.Common or itemTbl:GetSex() == self:GetMainPlayerSex()
            if isSoulEquip and levelEnough and isSameCareer and isSameSex then
                ---获取背包装备可以镶嵌的装备位
                local equipIndexes = Utility.GetEquipIndexesByLuaItemTbl(itemTbl)
                for k, v in pairs(equipIndexes) do
                    local equipIndex = v
                    ---@type bagV2.BagItemInfo
                    ---获取玩家身上的装备
                    local bodyEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(equipIndex)
                    ---可以镶嵌的格子位置
                    local inlayHolePos = self:GetTheUnmountedGrid(suitBelong, equipIndex)
                    ---是否已经镶嵌了同类型的装备
                    local sameType, better = self:CheckWhetherTheSameTypeOfEquipmentIsInlaid(suitBelong, equipIndex, item)
                    if bodyEquip and self:IsEquipCanInlay_XianZhuang(suitBelong, bodyEquip) then
                        if (inlayHolePos ~= 0 and sameType == false) or (sameType == true and better == true) then
                            --背包有身上没有
                            self.mHasBetterXianZhaung = true
                            self.mCurrentPushMaterial = item
                            return
                        end
                    end
                end
            end
        end
    end
    self.mHasBetterXianZhaung = false
end

function LuaSoulEquipMgr:GetXianZhuangHoleRedPoint()
    local SoulEquipIndexList = self:GetEquipIndexList()
    if type(SoulEquipIndexList) == 'table' and Utility.GetLuaTableCount(SoulEquipIndexList) > 0 then
        for i = 1, LuaSoulEquipMgr.holeCount do
            ---满足显示条件
            if (self:CanItBeDisplayed(i)) then
                for k, v in pairs(SoulEquipIndexList) do
                    --获取玩家身上的装备
                    local bodyEquip = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(v)
                    local soulEquip = self:GetSoulEquipClassToEquipIndex(LuaEnumSoulEquipType.XianZhuang, v)
                    ---未镶嵌
                    local unmounted = soulEquip ~= nil and soulEquip:GetSoulEquip_SubIndex(i) == nil
                    ---装备武器&未镶嵌&满足镶嵌条件
                    if (bodyEquip and unmounted and self:CanTurnOnTheGrid(LuaEnumSoulEquipType.XianZhuang, v)) then
                        return true, bodyEquip
                    end
                end
            end
        end
    end
    return false
end

--endregion

return LuaSoulEquipMgr;
