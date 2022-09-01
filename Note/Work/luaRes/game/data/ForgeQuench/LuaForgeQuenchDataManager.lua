---@class LuaForgeQuenchDataManager:luaobject 淬炼数据管理
local LuaForgeQuenchDataManager = {}

--region Data
---根据Cfg_cuilian id放置淬炼单元数据
---@return table<number,LuaForgeQuenchItemData>
function LuaForgeQuenchDataManager:GetAllForgeQuenchItemByIdDic()
    if self.mAllForgeQuenchItemByIdDic == nil then
        self.mAllForgeQuenchItemByIdDic = {}
    end
    return self.mAllForgeQuenchItemByIdDic
end

---根据Cfg_cuilian id放置淬炼单元数据
---@return table<number,LuaForgeQuenchItem>
function LuaForgeQuenchDataManager:GetAllTemperItemAndCuiLianIdList()
    if self.mAllTemperItemAndCuiLianIdList == nil then
        self.mAllTemperItemAndCuiLianIdList = {}
    end
    return self.mAllTemperItemAndCuiLianIdList
end

---根据材料id分类淬炼数据,用于背包刷新时
---@return table<number,table<number,number>>
function LuaForgeQuenchDataManager:GetAllForgeQuenchItemAndMaterialDic()
    if self.mAllTemperItemAndMaterialDic == nil then
        self.mAllTemperItemAndMaterialDic = {}
    end
    return self.mAllTemperItemAndMaterialDic
end

---根据货币消耗id分类淬炼数据,用于背包刷新时
---@return table<number,table<number,number>>
function LuaForgeQuenchDataManager:GetAllTemperItemAndCoinDic()
    if self.mAllTemperItemAndCoinDic == nil then
        self.mAllTemperItemAndCoinDic = {}
    end
    return self.mAllTemperItemAndCoinDic
end

---可淬炼的cfg_cuilian id
---@return table<number,number>
function LuaForgeQuenchDataManager:GetAllCanTemperDic()
    if self.mAllCanTemperDic == nil then
        self.mAllCanTemperDic = {}
    end
    return self.mAllCanTemperDic
end

---页签对应的淬炼列表
---@return table<number,number>
function LuaForgeQuenchDataManager:GetForgeQuenchIdAndPageDic()
    if self.mForgeQuenchIdAndPageDic == nil then
        self.mForgeQuenchIdAndPageDic = {}
    end
    return self.mForgeQuenchIdAndPageDic
end

---储存材料之前的个数，便于比较
---@type table<number,number>
function LuaForgeQuenchDataManager:GetMaterialIDAndLastCountDic()
    if self.MaterialIDAndLastCountDic == nil then
        self.MaterialIDAndLastCountDic = {}
    end
    return self.MaterialIDAndLastCountDic
end

---主装备对应的淬炼列表
---@return table<number,number>
function LuaForgeQuenchDataManager:GetForgeQuenchIdAndEquipItemIdDic()
    if self.mForgeQuenchIdAndEquipItemDic == nil then
        self.mForgeQuenchIdAndEquipItemDic = {}
    end
    return self.mForgeQuenchIdAndEquipItemDic
end

--endregion

--region Event
---客户端事件绑定
---@return EventHandlerManager
function LuaForgeQuenchDataManager:GetClientEventHander()
    return self.mClientEventHandler
end

---lua中的事件绑定
---@return LuaEventHandler
function LuaForgeQuenchDataManager:GetLuaEventHandler()
    return self.mLuaEventHandler
end
--endregion

--region 初始化

---初始化
---@protected
function LuaForgeQuenchDataManager:Init()
    self:InitParams()
    self:InitEvent()
    self:BindNetMsg()
    self:InitForgeQuenchData()
    self:InitRedPointKeyData()
end

function LuaForgeQuenchDataManager:InitParams()
    self.curIndex = 1
    self.isFinished = true
    self.isNeedBreak = false
end

function LuaForgeQuenchDataManager:InitEvent()
    self.mClientEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    self.mLuaEventHandler = eventHandler.CreateNew()
end

function LuaForgeQuenchDataManager:BindNetMsg()
    if self:GetLuaEventHandler() ~= nil then
        self.ForgeQuenchStateChangedCallBack = function(msg, data)
            self:onForgeQuenchStateChanged(data)
        end
        self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ForgeQuenchStateChanged, self.ForgeQuenchStateChangedCallBack)
        self.ResBagChangeMessageCallBack = function()
            self:RefreshForgeQuenchData()
        end
        self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, self.ResBagChangeMessageCallBack)
    end

    if self:GetClientEventHander() then
        self.EquipUpdatedCallBack = function()
            self:OnEquipUpdataCallBack()
        end
        self:GetClientEventHander():AddEvent(CS.CEvent.V2_EquipUpdated, self.EquipUpdatedCallBack)
    end

end

---初始化淬炼数据 ( 启动仅执行一次)
---@private
function LuaForgeQuenchDataManager:InitForgeQuenchData()
    local temperItem
    ---@param v TABLE.cfg_cuilian
    clientTableManager.cfg_cuilianManager:ForPair(function(k, v)
        temperItem = luaclass.LuaForgeQuenchItemData:New(v)
        self:GetAllForgeQuenchItemByIdDic()[k] = temperItem
        table.insert(self:GetAllTemperItemAndCuiLianIdList(), temperItem)
        self:SetPageDicByTemperTable(v)
        self:SetMaterialDicByTemperTable(v)
    end)
end

--endregion

---设置材料Id对应表Id
---@param tbl TABLE.cfg_cuilian
---@private
function LuaForgeQuenchDataManager:SetMaterialDicByTemperTable(tbl)
    if tbl == nil then
        return
    end

    self:SetMainMaterialDicByTemperTable(tbl:GetItemid(), tbl:GetId(), self:GetAllForgeQuenchItemAndMaterialDic())
    self:ForeachItemIdList(tbl:GetItemid2(), tbl:GetId(), self:GetAllForgeQuenchItemAndMaterialDic())
    self:ForeachItemIdList(tbl:GetCurrency(), tbl:GetId(), self:GetAllForgeQuenchItemAndMaterialDic(), 1)
end

---设置主材料
function LuaForgeQuenchDataManager:SetMainMaterialDicByTemperTable(key, id, resultDic)
    if resultDic[key] == nil then
        resultDic[key] = {}
    end
    table.insert(resultDic[key], id)
end

---设置页签对应表Id
---@param tbl TABLE.cfg_cuilian
---@private
function LuaForgeQuenchDataManager:SetPageDicByTemperTable(tbl)
    local type = tonumber(tbl:GetTabType())
    if self:GetForgeQuenchIdAndPageDic()[type] == nil then
        self:GetForgeQuenchIdAndPageDic()[type] = {}
    end
    table.insert(self:GetForgeQuenchIdAndPageDic()[type], tbl:GetId())
end

---重置数据 （暂无需要）
---@public
function LuaForgeQuenchDataManager:ResetTemperItemDataDic()

end

---@param targetIntList
---@param resultTable
---@param type  other:正常遍历  1：取余
---@return table<number,number>
function LuaForgeQuenchDataManager:ForeachItemIdList(targetIntList, id, resultDic, type)
    if targetIntList == nil or targetIntList.list == nil then
        return
    end
    local count, key = #targetIntList.list, 0
    for i = 1, count do
        if i % 2 ~= 0 or type ~= 1 then
            key = targetIntList.list[i]
            if resultDic[key] == nil then
                resultDic[key] = {}
            end
            table.insert(resultDic[key], id)
        end
    end
end

---根据材料id查找对应的淬炼id
---@param itemId number
function LuaForgeQuenchDataManager:GetCuiLianIdByMaterialId(itemId)
    local tbl = self:GetAllForgeQuenchItemAndMaterialDic()[itemId]
    if tbl and #tbl > 0 then
        return tbl[1]
    end
    return nil
end

---获取对应的物品
---@type LuaEnumForgeQuenchItemCheckReason
---@return bagV2.BagItemInfo
function LuaForgeQuenchDataManager:GetTargetBagItemInfo(type, itemId)

    if type == nil or itemId == nil then
        return nil
    end

    local targetInfo = nil
    if type == LuaEnumForgeQuenchItemCheckReason.Bag then
        local bagItemInfoList = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemInfoListByItemId(itemId, function(bagItemInfo)
            return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
        end)
        if #bagItemInfoList > 0 then
            return bagItemInfoList[1]
        end
    elseif type == LuaEnumForgeQuenchItemCheckReason.Role then
        local isWearing
        isWearing, targetInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsWearingEquipByItemId(itemId, function(bagItemInfo)
            return not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)
        end)
    elseif type == LuaEnumForgeQuenchItemCheckReason.ForgeQuenchList then
        targetInfo = self:GetTargetBagItemInfo(LuaEnumForgeQuenchItemCheckReason.Role, itemId)
        if targetInfo == nil then
            targetInfo = self:GetTargetBagItemInfo(LuaEnumForgeQuenchItemCheckReason.Bag, itemId)
        end
    end
    return targetInfo
end

---获取可显示的淬炼id列表
function LuaForgeQuenchDataManager:GetNeedShowForgetQuenchIdList(pageType)
    local result = {}
    local tbl = self:GetForgeQuenchIdAndPageDic()[pageType]
    ---@type LuaForgeQuenchItemData
    local dataItem = nil
    if tbl and #tbl > 0 then
        local count = #tbl
        for i = 1, count do
            dataItem = self:GetAllForgeQuenchItemByIdDic()[tbl[i]]
            if dataItem:IsShow() then
                table.insert(result, {
                    Id = tbl[i],
                    tbl = dataItem:GetForgeQuenchTbl()
                })
            end
        end
    end
    if self.sortShowTbl == nil then
        self.sortShowTbl = function(l, r)
            return self:SortShowTbl(l, r)
        end
    end
    table.sort(result, self.sortShowTbl)

    return result
end

---排序
---@private
function LuaForgeQuenchDataManager:SortShowTbl(l, r)
    if l.tbl == nil or r.tbl == nil then
        return false
    end
    if l.tbl:GetOrder() == nil or r.tbl:GetOrder() == nil then
        return false
    end
    return l.tbl:GetOrder() < r.tbl:GetOrder()
end

---是否为淬炼材料
---@param bagItemInfo bagV2.BagItemInfo
---@return boolean
function LuaForgeQuenchDataManager:IsAvailableForForgeQuench(bagItemInfo)
    if bagItemInfo.ItemTABLE ~= nil then
        local itemId = bagItemInfo.ItemTABLE.id
        local forgeQuenchId = self:GetCuiLianIdByMaterialId(itemId)
        return forgeQuenchId ~= nil and forgeQuenchId ~= 0
    end
    return false
end

--region NetCallBack

---淬炼状态改变
function LuaForgeQuenchDataManager:onForgeQuenchStateChanged(data)
    if data == nil then
        return
    end
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    ---刷新红点数据
    self:GetAllCanTemperDic()[data.id] = data.state

    local key = self:GetRedPointKey(nil, 1)
    luaRedPointMgr:CallRedPointKey(key)

    local key = self:GetRedPointKey(data.id, 3)
    luaRedPointMgr:CallRedPointKey(key)

    local key = self:GetRedPointKey(data.page, 2)
    luaRedPointMgr:CallRedPointKey(key)
end

---装备列表改变
function LuaForgeQuenchDataManager:OnEquipUpdataCallBack()
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    local count = #self:GetEquipIndexRedPointKeyList()
    for i = 1, count do
        luaRedPointMgr:CallRedPointKey(self:GetEquipIndexRedPointKeyList()[i])
    end
end

---刷新data数据
function LuaForgeQuenchDataManager:RefreshForgeQuenchData()
    self.curIndex = 1
    self.isNeedBreak = true
    self.isFinished = false
end

--endregion

--region RedPoint

--region Data

---需要显示淬炼红点的装备位
function LuaForgeQuenchDataManager:GetNeedShowRedPointEquipIndex()
    if self.mNeedShowRedPointEquipIndex == nil then
        self.mNeedShowRedPointEquipIndex = {
            Utility.EnumToInt(CS.EEquipIndex.POS_WEAPON),
            Utility.EnumToInt(CS.EEquipIndex.POS_HEAD),
            Utility.EnumToInt(CS.EEquipIndex.POS_CLOTHES),
            Utility.EnumToInt(CS.EEquipIndex.POS_NECKLACE),
            Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND),
            Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND),
            Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING),
            Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING),
            Utility.EnumToInt(CS.EEquipIndex.POS_SHOES),
        }
    end
    return self.mNeedShowRedPointEquipIndex
end

---需要特殊判断的装备位
function LuaForgeQuenchDataManager:GetOtherEquipIndexDic()
    if self.mOtherEquipIndexDic == nil then
        self.mOtherEquipIndexDic = {
            [Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND)] = {
                Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND),
                Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND)
            },

            [Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND)] = {
                Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_HAND),
                Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_HAND)
            },

            [Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING)] = {
                Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING),
                Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING)
            },

            [Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING)] = {
                Utility.EnumToInt(CS.EEquipIndex.POS_LEFT_RING),
                Utility.EnumToInt(CS.EEquipIndex.POS_RIGHT_RING)
            }
        }
    end
    return self.mOtherEquipIndexDic
end

---页签类型的红点key列表
function LuaForgeQuenchDataManager:GetPageRedPointKeyList()
    if self.mPageRedPointKeyList == nil then
        self.mPageRedPointKeyList = {}
    end
    return self.mPageRedPointKeyList
end

---淬炼ID类型的红点key列表
function LuaForgeQuenchDataManager:GetForgeQuenchIdRedPointKeyList()
    if self.mForgeQuenchIdRedPointKeyList == nil then
        self.mForgeQuenchIdRedPointKeyList = {}
    end
    return self.mForgeQuenchIdRedPointKeyList
end

---装备位类型的红点key列表
function LuaForgeQuenchDataManager:GetEquipIndexRedPointKeyList()
    if self.mEquipIndexRedPointKeyList == nil then
        self.mEquipIndexRedPointKeyList = {}
    end
    return self.mEquipIndexRedPointKeyList
end

--endregion

--region Init

---初始化红点键值数据
function LuaForgeQuenchDataManager:InitRedPointKeyData()
    ---@type CSUIRedPointManager
    local csRedPointMgr = gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager()

    local key = self:GetRedPointKey(nil, 1)
    local callBack = function()
        return self:IsShowAllRedPoint()
    end
    csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)

    local pageData = self:GetForgeQuenchPageTblInfo()
    local count = #pageData
    for i1 = 1, count do
        local key, callBack
        key = pageData[i1].redPoint
        callBack = function()
            return self:IsShowRedPointByPage(pageData[i1].type)
        end
        csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)
        table.insert(self:GetPageRedPointKeyList(), key)
    end

    for k, v in pairs(self:GetAllForgeQuenchItemByIdDic()) do
        local key, callBack
        key = self:GetRedPointKey(k, 3)
        callBack = function()
            return self:IsShowRedPointById(k)
        end
        csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)
        table.insert(self:GetForgeQuenchIdRedPointKeyList(), key)
    end

    count = #self:GetNeedShowRedPointEquipIndex()
    for i2 = 1, count do
        local key, callBack
        key = self:GetRedPointKey(self:GetNeedShowRedPointEquipIndex()[i2], 4)
        callBack = function()
            return self:IsShowRedPointByEquipIndex(self:GetNeedShowRedPointEquipIndex()[i2])
        end
        csRedPointMgr:RegisterLuaCallRedPointFunction(key, callBack)
        table.insert(self:GetEquipIndexRedPointKeyList(), key)
    end
end

--endregion

---获取红点键值
---@param type 1:all 2:第一层页签 3:第二层页签 4:装备
---@return number
function LuaForgeQuenchDataManager:GetRedPointKey(tag, type)
    if type == 1 then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.ForgeQuenchAllRedPoint)
    elseif type == 2 then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("ForgeQuenchFirstPage_" .. tostring(tag))
    elseif type == 3 then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("ForgeQuenchSecondPage_" .. tostring(tag))
    elseif type == 4 then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey("ForgeQuenchEquip_" .. tostring(tag))
    end
end

---@return boolean
function LuaForgeQuenchDataManager:IsShowAllRedPoint()

    if not Utility.CheckSystemOpenState(86) then
        return false
    end

    for i, v in pairs(self:GetAllCanTemperDic()) do
        if v then
            return true
        end
    end
    return false
end
---根据淬炼id判断红点
---@return boolean
function LuaForgeQuenchDataManager:IsShowRedPointById(id)
    if not Utility.CheckSystemOpenState(86) then
        return false
    end
    local forgeQuenchData = self:GetAllForgeQuenchItemByIdDic()[id]
    if forgeQuenchData then
        if forgeQuenchData:IsNeedShowRedPoint() then
            return forgeQuenchData:IsCanForgeQuench()
        end
    end
    return false
end

---根据主页签类型判断红点
---@return boolean
function LuaForgeQuenchDataManager:IsShowRedPointByPage(pageType)
    if not Utility.CheckSystemOpenState(86) then
        return false
    end
    local tbl = self:GetForgeQuenchIdAndPageDic()[pageType]
    if tbl then
        local count = #tbl
        for i = 1, count do
            if self:IsShowRedPointById(tbl[i]) then
                return true
            end
        end
    end

    return false
end

---根据装备位判断红点
---@return boolean
function LuaForgeQuenchDataManager:IsShowRedPointByEquipIndex(equipIndex)
    if not Utility.CheckSystemOpenState(86) then
        return false
    end
    local bagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetEquipInfoByEquipIndex(equipIndex)
    if bagItemInfo ~= nil and (not gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():IsInsurance(bagItemInfo)) then
        local tbl = self:GetAllForgeQuenchItemAndMaterialDic()[bagItemInfo.itemId]
        if tbl then
            local count = #tbl
            for i = 1, count do
                if self:IsShowRedPointById(tbl[i]) then
                    return true
                end
            end
        end
    end
    return false
end

--endregion

--region  Page

---@class ForgeQuenchPageData
---@field public type
---@field public str
---@field public isShow
---@field public redPoint

---@return table<number,ForgeQuenchPageData>
function LuaForgeQuenchDataManager:GetForgeQuenchPageTblInfo()
    if self.mPageTblInfo == nil or #self.mPageTblInfo == 0 then
        self.mPageTblInfo = {}
        local tbl = string.SplitGlobalStrToStrListList(23011, '&', '#')
        local count, isShowPage, redPointStr = #tbl, false, ""
        for i = 1, count do
            if #tbl[i] > 1 then
                isShowPage = self:IsShowMainPage(tbl[i][1])
                redPointStr = self:GetRedPointKey(tbl[i][1], 2)
                ---@type temperPageData
                table.insert(self.mPageTblInfo, {
                    type = tonumber(tbl[i][1]),
                    str = tbl[i][2],
                    isShow = isShowPage,
                    redPoint = redPointStr
                })
            end
        end
    end
    return self.mPageTblInfo
end

function LuaForgeQuenchDataManager:IsShowMainPage(pageType)
    return true
end

--endregion

--region Updata

---隔一帧执行
function LuaForgeQuenchDataManager:Updata()
    self:DoFor()
end

---每帧执行10次
function LuaForgeQuenchDataManager:DoFor()
    if self.isFinished then
        return
    end
    local count, maxCount = #self:GetAllTemperItemAndCuiLianIdList(), self.curIndex + 9
    for i = self.curIndex, maxCount do
        if self.isNeedBreak then
            self.isNeedBreak = false
            return
        end
        if i <= count then
            if self:GetAllTemperItemAndCuiLianIdList()[i] then
                self:GetAllTemperItemAndCuiLianIdList()[i]:RefreshTemperState()
            end
            self.curIndex = self.curIndex + 1
        else
            self.isFinished = true
            return
        end
    end
end

--endregion

--region Destroy

---销毁时执行
---@private
function LuaForgeQuenchDataManager:OnDestroy()
    if self.mClientEventHandler ~= nil then
        self.mClientEventHandler:UnRegAll()
    end
    if self.mLuaEventHandler ~= nil then
        self.mLuaEventHandler:ReleaseAll()
    end
end
--endregion

return LuaForgeQuenchDataManager