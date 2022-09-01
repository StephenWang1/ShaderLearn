---@class LuaServantInfo:luaobject
local LuaServantInfo = {};

LuaServantInfo.ServantInfoList = {}
LuaServantInfo.mServantEquipSynthesisKeyDic = nil;
LuaServantInfo.mAllServantEquipIndexDic = nil;

function LuaServantInfo:GetCSServantInfo()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        return CS.CSScene.MainPlayerInfo.ServantInfoV2;
    end
    return nil;
end

---@return servantV2.ResServantInfo 灵兽信息列表
function LuaServantInfo:GetLuaServantInfoTable()
    if (self.ServantInfoList == nil) then
        self.ServantInfoList = {}
    end
    return self.ServantInfoList
end

---设置灵兽信息列表
---@param infolist table
function LuaServantInfo:SetLuaServantInfo(infolist)
    self.ServantInfoList = infolist
end

---获取灵兽列表
---@return table<servantV2.ServantInfo>
function LuaServantInfo:GetServantInfoList()
    ---@type servantV2.ResServantInfo
    local servantInfoTable = self:GetLuaServantInfoTable()
    if servantInfoTable == nil or type(servantInfoTable.serverts) ~= 'table' then
        return
    end
    return servantInfoTable.serverts
end

---获取灵兽列表
---@param servantType 灵兽的类型
---@return servantV2.ServantInfo
function LuaServantInfo:GetServantInfoByType(servantType)
    ---@type servantV2.ResServantInfo
    local servantInfoTable = self:GetLuaServantInfoTable()
    if servantInfoTable == nil or servantInfoTable.serverts == nil or type(servantInfoTable.serverts) ~= 'table' then
        return nil
    end
    return servantInfoTable.serverts[servantType]
end

---获取单个灵兽信息
---@param servantSeatType luaEnumServantSeatType 灵兽位
function LuaServantInfo:GetLuaSingleServantInfo(servantSeatType)
    local servantCount = Utility.GetLuaTableCount(self:GetServantInfoList())
    if servantCount >= servantSeatType and type(self:GetLuaServantInfoTable()) == 'table' and type(self:GetLuaServantInfoTable().serverts) == 'table' then
        return self:GetLuaServantInfoTable().serverts[servantSeatType]
    end
    return nil
end

---设置单个灵兽信息
---@param servantSeatType luaEnumServantSeatType 灵兽位
---@param info table 灵兽信息
function LuaServantInfo:SetLuaSingleServantInfo(servantSeatType, info)
    local servantCount = Utility.GetLuaTableCount(self:GetServantInfoList())
    if servantCount >= servantSeatType and type(self:GetLuaServantInfoTable()) == 'table' and type(self:GetLuaServantInfoTable().serverts) == 'table' then
        self:GetLuaServantInfoTable().serverts[servantSeatType] = info
    end
end

function LuaServantInfo:GetServantEquipIndex(servantType)
    if (self.mAllServantEquipIndex == nil) then
        self.mAllServantEquipIndex = {};
    end

    if (self.mAllServantEquipIndex[servantType] == nil) then
        self.mAllServantEquipIndex[servantType] = {};
        local temp = servantType * 1000;
        ---灵兽与角色共享的装备位置
        table.insert(self.mAllServantEquipIndex[servantType], temp + 201);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 202);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 212);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 203);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 213);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 204);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 205);

        ---灵兽肉身的装备位置
        table.insert(self.mAllServantEquipIndex[servantType], temp + 101);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 102);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 103);
        table.insert(self.mAllServantEquipIndex[servantType], temp + 104);

        ---灵兽法宝的装备位
        table.insert(self.mAllServantEquipIndex[servantType], temp + 6);
    end
    return self.mAllServantEquipIndex[servantType];
end

function LuaServantInfo:Init()
    ---注册CS中获得灵兽合成动态红点的逻辑
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        self.CallOnGetServantEggSynthesisRedPointKey = function(servantIndex)
            return self:GetServantEggSynthesisRedPointKey(servantIndex);
        end
        self:GetCSServantInfo():RegisterGetLuaSynthesisServantEggRedPointKeyFunction(self.CallOnGetServantEggSynthesisRedPointKey);
    else
        CS.OnlineDebug.LogError("在MainPlayerInfo为NULL的时候就尝试注册了lua中的获得灵兽合成红点逻辑");
    end

    --region 注册熔炼推送逻辑判断
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        self.CallIsMeltingPush = function(lid)
            return self:IsMeltingPush(lid);
        end
        CS.CSScene.MainPlayerInfo.BagInfo:RegisterLuaCallMeltingPushHandler(self.CallIsMeltingPush);
    else
        CS.OnlineDebug.LogError("在MainPlayerInfo为NULL的时候就尝试注册了lua中的熔炼推送逻辑");
    end
    --endregion

    --region 聚灵
    self.CallShowServantGatherSoulRedPoint = function()
        return self:ShowServantGatherSoul();
    end
    --CS.CSUIRedPointManager.GetInstance():RegisterLuaCallRedPointFunction(CS.RedPointKey.SERVANT_GatherSoul, self.CallShowServantGatherSoulRedPoint)
    --endregion
end

---@param servantIndex luaEnumServantSeatType
---@return servantV2.ServantInfo
function LuaServantInfo:GetServantInfoByServantIndex(servantIndex)
    if (self:GetCSServantInfo() ~= nil) then
        if (self:GetCSServantInfo().ServantInfoList ~= nil) then
            local length = self:GetCSServantInfo().ServantInfoList.Count
            for k = 0,length - 1 do
                local servantInfo = self:GetCSServantInfo().ServantInfoList[k]
                if servantInfo.type == servantIndex then
                    return servantInfo
                end
            end
        end
    end
    return nil;
end

---查询身上是否有灵兽
---@return boolean 是否有灵兽
function LuaServantInfo:BodyHaveServant()
    for k,v in pairs(luaEnumServantSeatType) do
        local servantInfo = self:GetServantInfoByServantIndex(v)
        if servantInfo ~= nil then
            return true
        end
    end
    return false
end

--region 装备
---@return LuaServantEquipMgr
function LuaServantInfo:GetServantEquip()
    if self.mServantEquipData == nil then
        self.mServantEquipData = luaclass.LuaServantEquipMgr:New()
    end
    return self.mServantEquipData
end
--endregion

--region 红点
function LuaServantInfo:GetServantRedPointName(servantIndex)
    if (servantIndex == 0) then
        return LuaRedPointName.Synthesis_HM;
    elseif (servantIndex == 1) then
        return LuaRedPointName.Synthesis_LX;
    elseif (servantIndex == 2) then
        return LuaRedPointName.Synthesis_TC;
    end
    return nil;
end

function LuaServantInfo:GetServantMagicWeaponSynthesisRedPointName(servantIndex)
    if (servantIndex == 0) then
        return LuaRedPointName.Synthesis_HM_MagicWeapon;
    elseif (servantIndex == 1) then
        return LuaRedPointName.Synthesis_LX_MagicWeapon;
    elseif (servantIndex == 2) then
        return LuaRedPointName.Synthesis_TC_MagicWeapon;
    end
    return nil;
end

---获得灵兽装备合成红点名字列表
function LuaServantInfo:GetServantEquipRedPointKeys(servantIndex)
    if (self.mServantEquipSynthesisKeyDic == nil) then
        self.mServantEquipSynthesisKeyDic = {};
    end

    if (self.mServantEquipSynthesisKeyDic[servantIndex] == nil) then
        local keys = {};
        if (servantIndex == 0) then
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMNaoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMXinSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMGuSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMXueSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMXiangLianSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMRightJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMLeftJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMRightShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMLeftShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMYaoDaiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasHMXieziSynthesis);
        elseif (servantIndex == 1) then
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXNaoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXXinSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXGuSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXXueSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXXiangLianSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXRightJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXLeftJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXRightShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXLeftShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXYaoDaiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasLXXieziSynthesis);
        elseif (servantIndex == 2) then
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCNaoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCXinSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCGuSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCXueSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCXiangLianSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCRightJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCLeftJieZhiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCRightShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCLeftShouZhuoSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCYaoDaiSynthesis);
            table.insert(keys, CS.RedPointKey.Synthesis_HasTCXieziSynthesis);
        end
        self.mServantEquipSynthesisKeyDic[servantIndex] = keys;
    end
    return self.mServantEquipSynthesisKeyDic[servantIndex];
end

---根据灵兽为获得红点Key
function LuaServantInfo:GetServantEggSynthesisRedPointKey(servantIndex)
    local redPointName = self:GetServantRedPointName(servantIndex);
    if (redPointName ~= nil) then
        return gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
    end
    return Utility.EnumToInt(CS.RedPointKey.NON);
end

---获取灵兽聚灵数据
---@return servantV2.ServantMana
function LuaServantInfo:GetGatherSoulData()
    if (self.mGatherSoulData == nil) then
        self.mGatherSoulData = {}
    end
    return self.mGatherSoulData
end

---设置灵兽聚灵数据
---@return servantV2.ServantMana
function LuaServantInfo:SetGatherSoulData(info)
    self:GetGatherSoulData().manaPoll = info.manaPoll
    self:GetGatherSoulData().receiveToday = info.receiveToday
    self:GetGatherSoulData().rechargeToday = info.rechargeToday
    self:GetGatherSoulData().receiveRecharge = info.receiveRecharge
end

--region 是否符合熔炼推送熔炼推送

---@param bagItemInfo bagV2.BagItemInfo 背包物品信息
function LuaServantInfo:IsMeltingPush(lid)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local isFind0, bagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo.BagItems:TryGetValue(lid);
        if (isFind0) then
            local isFind1, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId);
            if (isFind1) then
                if (Utility.IsAvailableForSemelt(itemTable)) then
                    local arrotType = Utility.GetArrowType(bagItemInfo);
                    if (arrotType == LuaEnumArrowType.NONE) then
                        return true;
                    end
                end
            end
        end
    end
    return false;
end

--endregion

--region 是否符合聚灵推送
function LuaServantInfo:ShowServantGatherSoul()
    if (self:GetGatherSoulData() ~= nil and self:GetGatherSoulData().canReceiveMana ~= nil and self:GetGatherSoulData().canReceiveMana > 0) then
        if (LuaGlobalTableDeal.IsOpenServantRein()) then
            return true
        else
            return false
        end
    else
        return false
    end
end
--endregion
--endregion

--region 灵兽VIP（用于聚灵功能）
--function LuaServantInfo:GetServantVipLevel()
--    if (self:GetGatherSoulData().servantVipLv ~= nil) then
--        return self:GetGatherSoulData().servantVipLv
--    else
--        return 0
--    end
--end
--
--function LuaServantInfo:GetServantVipExp()
--    if (self:GetGatherSoulData().servantVipExp ~= nil) then
--        return self:GetGatherSoulData().servantVipExp
--    else
--        return 0
--    end
--end
--endregion

--region 获取聚灵表数据
--function LuaServantInfo:GetPlayerVipServantMana()
--    local tableinfo = clientTableManager.cfg_gather_soulManager:TryGetValue(self:GetServantVipLevel())
--    if (tableinfo ~= nil) then
--        return tableinfo:GetServantMana()
--    else
--        return 0
--    end
--end

---获取当前等级VIP表数据
---@return TABLE.cfg_vip_level
function LuaServantInfo:GetVIPTableData()
    local tableinfo = clientTableManager.cfg_vip_levelManager:TryGetValue(gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Level())
    return tableinfo
end
---获取聚灵槽上限
---@return number
function LuaServantInfo:GetServantLimit()
    local isget
    ---@type TABLE.CFG_GLOBAL
    local tableinfo
    isget, tableinfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22621)
    if (isget) then
        return tonumber(tableinfo.value)
    end
    return 50000
end
---获取每日免费领取聚灵数
---@return number
function LuaServantInfo:GetFreeServantNum()
    local isget
    ---@type TABLE.CFG_GLOBAL
    local tableinfo
    isget, tableinfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22620)
    if (isget) then
        return tonumber(tableinfo.value)
    end
    return 1000
end
-----获取下一级VIP表数据
-----@return TABLE.cfg_vip
--function LuaServantInfo:GetNextVIPTableData()
--    local nexttableinfo = clientTableManager.cfg_gather_soulManager:TryGetValue(self:GetServantVipLevel() + 1)
--    return nexttableinfo
--end

-----返回玩家下次VIP升级时该补足的聚灵灵力
-----@param count number
-----@return number
--function LuaServantInfo:GetPlayerSupplementServantMana(count)
--    local nexttableinfo = self:GetNextVIPTableData()
--    local tableinfo = self:GetVIPTableData()
--    if (nexttableinfo ~= nil and tableinfo ~= nil) then
--        return math.floor((nexttableinfo:GetServantMana() - tableinfo:GetServantMana()) * count)
--    end
--    return 0
--end

-----返回差多少元可以升级到下级VIP
-----@return number
--function LuaServantInfo:GetNeedCostToNextLevel()
--    local tableinfo = self:GetNextVIPTableData()
--    if (tableinfo ~= nil and self:GetServantVipExp() ~= nil) then
--        return math.floor((self:GetVIPTableData():GetNeedExp() - self:GetServantVipExp()) / 10)
--    else
--        return 0
--    end
--end
--endregion

--region 灵兽战斗力
---返回灵兽战斗力
---@param index 灵兽位
---@return number
function LuaServantInfo:GetServantFightPower(index)
    local isfind, Servants = CS.CSScene.MainPlayerInfo.ServantInfoV2.Servants:TryGetValue(index)
    if (isfind) then
        return Servants.fightPower
    else
        return 0
    end
end
--endregion

--region 修炼数据
---@type servantcultivateV2.resCultivateInfo lua table类型消息数据
LuaServantInfo.mServantPracticeData = nil
---@type table<number,boolean> 灵兽类型对应是否需要显示红点
LuaServantInfo.mServantTypeToNeedShowRedPoint = nil
---刷新灵兽修炼数据
---@param tblData servantcultivateV2.resCultivateInfo lua table类型消息数据
function LuaServantInfo:RefreshServantPracticeData(tblData)
    self.mServantPracticeData = tblData
    uiStaticParameter.NeedCallServantPracticeRedPoint = false
    self.mServantTypeToNeedShowRedPoint = nil -- 避免计算三次缓存数据
    local luaRedPointMgr = gameMgr:GetLuaRedPointManager()
    --luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.ServantPractice_HM))
    --luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.ServantPractice_LX))
    --luaRedPointMgr:CallRedPoint(luaRedPointMgr:GetLuaRedPointKey(LuaRedPointName.ServantPractice_TC))
end

---判断是否需要显示灵兽红点
function LuaServantInfo:CanShowRedPoint(servantType)
    if self.mServantPracticeData then
        if self.mServantTypeToNeedShowRedPoint == nil then
            self.mServantTypeToNeedShowRedPoint = {}
            if self.mServantPracticeData.status == 1 then
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.HM] = false
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.LX] = false
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.TC] = false
            else
                local isServantAliveHM = self:IsServantDie(luaEnumServantType.HM) == false
                local isServantAliveLX = self:IsServantDie(luaEnumServantType.LX) == false
                local isServantAliveTC = self:IsServantDie(luaEnumServantType.TC) == false
                local isServantShangZhenHM = Utility.IsServantBattle(luaEnumServantType.HM)
                local isServantShangZhenLX = Utility.IsServantBattle(luaEnumServantType.LX)
                local isServantShangZhenTC = Utility.IsServantBattle(luaEnumServantType.TC)
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.HM] = isServantAliveHM and isServantShangZhenHM and self:IsExpPoolNotFull()
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.LX] = isServantAliveLX and isServantShangZhenLX and self:IsExpPoolNotFull()
                self.mServantTypeToNeedShowRedPoint[luaEnumServantType.TC] = isServantAliveTC and isServantShangZhenTC and self:IsExpPoolNotFull()
                --[[
                --检查红点问题的注释，请不要删掉
                print("isServantAliveHM", isServantAliveHM)
                print("isServantAliveLX", isServantAliveLX)
                print("isServantAliveTC", isServantAliveTC)
                print("isServantShangZhenHM", isServantShangZhenHM)
                print("isServantShangZhenLX", isServantShangZhenLX)
                print("isServantShangZhenTC", isServantShangZhenTC)
                print("self:IsExpPoolNotFull()", self:IsExpPoolNotFull())
                print(self.mServantTypeToNeedShowRedPoint[luaEnumServantType.HM], self.mServantTypeToNeedShowRedPoint[luaEnumServantType.LX], self.mServantTypeToNeedShowRedPoint[luaEnumServantType.TC])
                --]]
            end
        end
        local state = self.mServantTypeToNeedShowRedPoint[servantType]
        return state
    end
    return false
end

---灵兽是否死亡了
function LuaServantInfo:IsServantDie(showType)
    local dieTime = self:GetServantDieTime(showType)
    if dieTime and dieTime ~= 0 then
        local desTime = self:GetServantDieCD()
        local currentTime = 0
        if CS.CSServerTime.Instance then
            currentTime = CS.CSServerTime.Instance.TotalSeconds
        end
        if desTime then
            if currentTime - dieTime <= desTime then
                return true
            end
        end
    end
    return false
end

---修炼灵兽死亡CD
function LuaServantInfo:GetServantDieCD()
    if self.mServantDieCD == nil then
        local res, info = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22399)
        if res then
            self.mServantDieCD = tonumber(info.value)
        end
    end
    return self.mServantDieCD
end

---@return XLua.Cast.Int64 死亡时间戳
function LuaServantInfo:GetServantDieTime(showType)
    if self.mServantPracticeData and self.mServantPracticeData.dieTimeMap then
        for i = 1, #self.mServantPracticeData.dieTimeMap do
            local info = self.mServantPracticeData.dieTimeMap[i]
            if info and info.type == showType then
                return info.dieTimeS
            end
        end
    end
    return 0
end

---@return boolwan 经验池未满
function LuaServantInfo:IsExpPoolNotFull()
    if self.mServantPracticeData then
        local PracticeExpMax = CS.Cfg_GlobalTableManager.Instance.PracticeExpMax
        local currentExp = self.mServantPracticeData.exp
        return currentExp < PracticeExpMax
    end
    return false
end

---是否是灵兽身上的装备
function LuaServantInfo:IsServantEquip(servantType, itemId)
    local csServantInfo = self:GetCSServantInfo();
    if (csServantInfo == nil) then
        return false;
    end
    local equipIndex = self:GetServantEquipIndex(servantType);
    if (equipIndex ~= nil) then
        for k, v in pairs(equipIndex) do
            local isFind, equipInfo = csServantInfo.ServantEquip:TryGetValue(v);
            if (isFind) then
                if (equipInfo.itemId == itemId) then
                    return true;
                end
            end
        end
    end
    return false;
end

---是否是主角携带的灵兽
---@param lid number 唯一id
---@return boolean
function LuaServantInfo:IsServantEgg(lid)
    if (CS.CSScene.MainPlayerInfo == nil) then
        return false;
    end

    if (CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count <= 0) then
        return false;
    end

    for i = 0, CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count - 1 do
        local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList[i];
        if (servantInfo ~= nil and servantInfo.servantEgg ~= nil) then
            if (servantInfo.servantEgg.lid == lid) then
                return true;
            end
        end
    end
    return false;
end

---获取灵兽数据
---@param lid number
---@return servantV2.ServantInfo
function LuaServantInfo:GetServantInfoByLid(lid)
    local servantList = self:GetServantInfoList()
    if type(servantList) ~= 'table' then
        return
    end
    for k,v in pairs(servantList) do
        ---@type servantV2.ServantInfo
        local servantInfo = v
        if servantInfo ~= nil and servantInfo.cfgId == lid then
            return servantInfo
        end
    end
end

--endregion


function LuaServantInfo:OnDestroy()
    --CS.CSUIRedPointManager.GetInstance():RemoveLuaCallRedPointFunction(CS.RedPointKey.SERVANT_GatherSoul)
end

return LuaServantInfo