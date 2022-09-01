---@class LuaSynthesisMgr 合成数据管理类
local LuaSynthesisMgr = {}

---@type table<LuaSynthesis_MainCategory>
LuaSynthesisMgr.MainCategoryList = nil

---人物背包是否发生变动,只有变动的时候,才会重新计算
LuaSynthesisMgr.RoleBagIsChange = true

---当前的红点状态
LuaSynthesisMgr.RedState = false
---当前的红点key
LuaSynthesisMgr.RedKey = nil

---@type EventHandlerManager
LuaSynthesisMgr.mSocketEventHandler = nil

---合成的大类页签列表
---@type table<LuaSynthesis_MainCategory>
LuaSynthesisMgr.MainCategoryPageList = nil

---合成的主要材料对应的合成表数据,用来在点击道具的时候,索引到对应的合成配方
---@type table<number,TABLE.cfg_synthesis>
LuaSynthesisMgr.SynthesisMainMaterialDic = nil

---合成结果对应合成表的数据字典
---@type table<number,TABLE.cfg_synthesis>
LuaSynthesisMgr.mSynthesisResultItemIdDic = nil;

LuaSynthesisMgr.IsInit = false

---@type storeV2.CombineRecord 合成过得记录
LuaSynthesisMgr.mSynthesisHistoryData = nil;

---@return LuaDelayRefreshMessage
function LuaSynthesisMgr:DelayRefresh()
    if self.mdelayRefresh == nil then
        self.mdelayRefresh = luaclass.LuaDelayRefreshMessage:New()
    end
    return self.mdelayRefresh
end

---@return LuaSynthesis_ChooseItemInfo 当前选择的物品信息类
function LuaSynthesisMgr:GetChooseItemInfoClass()
    if self.mChooseItemInfoClass == nil then
        self.mChooseItemInfoClass = luaclass.LuaSynthesis_ChooseItemInfo:New()
    end
    return self.mChooseItemInfoClass
end

function LuaSynthesisMgr:InitData()
    self.IsInit = true;
    self.mSocketEventHandler = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Socket)
    self:InitAllSynthesisTbl()
    self:InitSynthesisMainCategoryPageButton()
    self:RegisterRed();

    self:ResetDataInfo()
end

---循环将所有的合成表内数据进行数据初始化
function LuaSynthesisMgr:InitAllSynthesisTbl()
    self.SynthesisMainMaterialDic = {}
    self.mSynthesisResultItemIdDic = {};

    clientTableManager.cfg_synthesisManager:ForPair(
            function(key, value)
                ---@type TABLE.cfg_synthesis
                local synthesis = value

                if (synthesis:GetItemid() ~= nil and synthesis:GetItemid().list ~= nil and #synthesis:GetItemid().list > 0) then
                    local itemId = synthesis:GetItemid().list[1]
                    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
                    if (itemTbl ~= nil) then
                        if (self.SynthesisMainMaterialDic[itemId] == nil) then
                            self.SynthesisMainMaterialDic[itemId] = {}
                        end
                        table.insert(self.SynthesisMainMaterialDic[itemId], synthesis)
                        ---替换的道具也需要对应添加
                        local replaceId = itemTbl:GetLinkItemId()
                        if (replaceId ~= nil and replaceId ~= 0) then
                            if (self.SynthesisMainMaterialDic[replaceId] == nil) then
                                self.SynthesisMainMaterialDic[replaceId] = {}
                            end
                            table.insert(self.SynthesisMainMaterialDic[replaceId], synthesis)
                        end
                    else
                        CS.UnityEngine.Debug.LogError("LuaSynthesisMgr----没有找到合成表" .. synthesis:GetId() .. "中itemid字段内  道具ID:" .. itemId);
                    end
                end

                local outPutGoods = synthesis:GetOutputgoods();
                if (outPutGoods ~= nil and outPutGoods.list ~= nil and #outPutGoods.list > 0) then
                    for k, v in pairs(outPutGoods.list) do
                        local itemId = v;
                        if (self.mSynthesisResultItemIdDic[itemId] == nil) then
                            self.mSynthesisResultItemIdDic[itemId] = {};
                        end
                        table.insert(self.mSynthesisResultItemIdDic[itemId], synthesis);
                    end
                end

                self:AddItem(value);
            end
    );
end

---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesisMgr:AddItem(synthesisTable)
    if (self.MainCategoryList == nil) then
        self.MainCategoryList = {}
    end
    ---@type LuaSynthesis_MainCategory
    local MainCategory = self.MainCategoryList[synthesisTable:GetTabType()]
    if (MainCategory == nil) then
        MainCategory = luaclass.LuaSynthesis_MainCategory:New();
        self.MainCategoryList[synthesisTable:GetTabType()] = MainCategory
        MainCategory:InitType(synthesisTable:GetTabType())
    end

    MainCategory:AddItem(synthesisTable)
end

---根据道具ID,拿到这个道具可以合成的首个合成配方
---@param itemId number 道具表的ID
---@return TABLE.cfg_synthesis
function LuaSynthesisMgr:GetSynthesisByItemId(itemId)

    if (self.SynthesisMainMaterialDic[itemId] == nil) then
        return nil
    end
    return self.SynthesisMainMaterialDic[itemId][1]
end

---根据道具ID,拿到这个道具可以合成的所有合成配方
---@param itemId number 道具表的ID
---@return table<number,TABLE.cfg_synthesis>
function LuaSynthesisMgr:GetSynthesisListByItemId(itemId)

    if (self.SynthesisMainMaterialDic[itemId] == nil) then
        return nil
    end
    return self.SynthesisMainMaterialDic[itemId]
end

---@public 根据合成结果的物品ID拿到合成配方
---@return table<number,TABLE.cfg_synthesis>
function LuaSynthesisMgr:GetSynthesisByResultItemId(itemId)
    local list = self.mSynthesisResultItemIdDic[itemId]
    if (list ~= nil and #list > 0) then
        return list[1];
    end
    return nil;
end

---@public 根据合成结果的物品ID拿到所有合成配方
---@return table<number,TABLE.cfg_synthesis>
function LuaSynthesisMgr:GetSynthesisListByResultItemId(itemId)
    if (self.mSynthesisResultItemIdDic[itemId] ~= nil) then
        return self.mSynthesisResultItemIdDic[itemId];
    end
    return nil;
end

---@param synthesisId number 合成表的ID
---@return return LuaSynthesis_Item
function LuaSynthesisMgr:GetSynthesisDataBySynthesisId(synthesisId)

    if (clientTableManager.cfg_synthesisManager.AllSynthesisDic[synthesisId] == nil) then
        return nil
    end
    return clientTableManager.cfg_synthesisManager.AllSynthesisDic[synthesisId]
end

---返回这个合成大类
---@return LuaSynthesis_MainCategory
function LuaSynthesisMgr:GetMainCategoryData(type)
    if (self.MainCategoryList == nil) then
        self.MainCategoryList = {}
    end

    return self.MainCategoryList[type]
end

function LuaSynthesisMgr:GetMainCategoryDic()
    return self.MainCategoryList
end

--region 界面显示

LuaSynthesisMgr.SynthesisSubCategoryPageButton = nil

---初始化所有页签
function LuaSynthesisMgr:InitSynthesisMainCategoryPageButton()
    if (self.MainCategoryPageList == nil) then
        self.MainCategoryPageList = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22610);
        if (globalTable ~= nil) then
            local nameAndTypes = string.Split(globalTable.value, "&");
            for k, v in pairs(nameAndTypes) do
                local nameAndType = string.Split(v, "#");
                if (nameAndType ~= nil and #nameAndType > 1) then

                    ---@type LuaSynthesis_MainCategory
                    local mainCategory = self:GetMainCategoryData(tonumber(nameAndType[1]));
                    if (mainCategory ~= nil) then
                        mainCategory.Name = nameAndType[2]

                        table.insert(self.MainCategoryPageList, mainCategory);
                    end
                end
            end
        end
    end

    if (self.mSecondPageButtonDic == nil) then
        self.mSecondPageButtonDic = {};
        local globalTable = LuaGlobalTableDeal.GetGlobalTabl(22611);
        if (globalTable ~= nil) then
            --每个2级分类使用&分割
            local nameAndTypeAndConditions = string.Split(globalTable.value, "&");
            for k, v in pairs(nameAndTypeAndConditions) do
                --合成内子类型类型页签名字 页签主类型#页签子类型#子类型名称显示#显示condition1#显示condition2（多个）
                local nameAndTypeAndCondition = string.Split(v, "#");
                if (nameAndTypeAndCondition ~= nil and #nameAndTypeAndCondition > 2) then
                    local firstType = tonumber(nameAndTypeAndCondition[1]);

                    ---@type LuaSynthesis_MainCategory
                    local mainCategory = self:GetMainCategoryData(firstType);
                    if mainCategory then
                        mainCategory:AddSubCategoryPageButton(nameAndTypeAndCondition);
                    end
                end
            end
        end
    end
end

---获得合成列表第一级页签
---@return table<LuaSynthesis_MainCategory>
function LuaSynthesisMgr:GetSynthesisMainCategoryPageButtons()
    return self.SynthesisSubCategoryPageButton;
end
--endregion


--region 红点

---注册红点
function LuaSynthesisMgr:RegisterRed()
    self.RedKey = self:GetAllPageButtonRedPointKey();
    local mCallResultFunction = function()
        return self:IsShowRed();
    end
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.RedKey);
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self.RedKey, mCallResultFunction);
end

---合成红点的key
function LuaSynthesisMgr:GetAllPageButtonRedPointKey()
    local redPointName = gameMgr:GetLuaRedPointManager():GetAllSynthesisListRedPointName();
    local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
    return redKey;
end

--region 已经点击过的列表是不会再显示红点的
---已经点击过的列表是不会再显示红点的
---@type table<number, boolean>
LuaSynthesisMgr.ShieldSynthesisRedList = nil

---已经显示的红点
---@type table<number, boolean>
LuaSynthesisMgr.CanShieldSynthesisRedList = nil

---@param id number 输出合成结果的道具
---@param synthesisId number 合成表的ID,由于可能同一个合成存在多种道具
function LuaSynthesisMgr:AddToCanShieldSynthesisRedList(id, synthesisId)
    if (self.CanShieldSynthesisRedList == nil) then
        self.CanShieldSynthesisRedList = {}
    end
    if (self.CanShieldSynthesisRedList[id] == nil) then
        self.CanShieldSynthesisRedList[id] = {}
    end

    self.CanShieldSynthesisRedList[id][synthesisId] = true
end

function LuaSynthesisMgr:RemoveToCanShieldSynthesisRedList(id, synthesisId)
    if (self.CanShieldSynthesisRedList == nil) then
        self.CanShieldSynthesisRedList = {}
    end

    if (self:IsExitInShieldSynthesisRedList(id) == false) then
        if (self.CanShieldSynthesisRedList[id] == nil) then
            return ;
        end
        self.CanShieldSynthesisRedList[id][synthesisId] = nil
    end

end

---将id添加到屏蔽列表中(以后合成的红点只有在合成列表中才有,所以只有在点击合成列表的时候才去移除,点击其他的位置移除的可能性再说)
function LuaSynthesisMgr:AddToShieldSynthesisRedList(id)
    if (self.CanShieldSynthesisRedList == nil or self.CanShieldSynthesisRedList[id] == nil or Utility.GetTableCount(self.CanShieldSynthesisRedList[id]) == 0) then
        return
    end
    if (self.ShieldSynthesisRedList == nil) then
        self.ShieldSynthesisRedList = {}
    end
    --已经设置过了,别重新设置然后再刷新红点了 红点他累了
    if (self.ShieldSynthesisRedList[id] == true) then
        return
    end
    self.ShieldSynthesisRedList[id] = true
    self:CalculateSynthesisRedPoint(nil, id)
end

---判定id是否在屏蔽列表中
function LuaSynthesisMgr:IsExitInShieldSynthesisRedList(id)
    if (self.ShieldSynthesisRedList == nil or self.ShieldSynthesisRedList[id] == nil) then
        return false
    end
    return true
end

---清理屏蔽列表
function LuaSynthesisMgr:ClearShieldSynthesisRedList()
    self.CanShieldSynthesisRedList = nil
    self.ShieldSynthesisRedList = nil
end
--endregion

--endregion

---设置合成列表第一个能合成物品的缓存
---@param cache table <number,number,number> { firstType , secondType , thirdItemId}
function LuaSynthesisMgr:SetSynthesisListFirstCache(cache)
    if (self.mSynthesisListFirstCache == nil) then
        self.mSynthesisListFirstCache = cache;
    end
end

---获得合成列表第一个能合成物品的缓存
---@return table <number,number,number> { firstType , secondType , thirdItemId}
function LuaSynthesisMgr:GetSynthesisListFirstCache()
    local cache = self.mSynthesisListFirstCache;
    ---获得一次后就清空
    self.mSynthesisListFirstCache = nil;
    return cache
end

---设置合成角色第一顺位红点缓存数据
function LuaSynthesisMgr:SetSynthesisRolePanelFirstCache(bagItemInfo)
    --if(self.mSynthesisRolePanelFirstCache == nil) then
    self.mSynthesisRolePanelFirstCache = bagItemInfo;
    --end
end

---获得合成角色第一顺位红点对应的缓存数据
function LuaSynthesisMgr:GetSynthesisRolePanelFirstCache()
    local cache = self.mSynthesisRolePanelFirstCache;
    ---获得一次后就清空
    self.mSynthesisRolePanelFirstCache = nil;
    return cache;
end

--region 为了减少合成相关的红点频繁反复的刷新,在下面去检测是是否需要去刷新合成的数据结果  不然直接使用缓存
---@type LuaSynthesisRoleData
LuaSynthesisMgr.RoleData = nil
---人物穿戴的所有装备数据
---@type table<number:用来装备在装备List里面的Index下标, number:道具item>>
LuaSynthesisMgr.PlayerBodyEquip = {}
---人物穿戴的所有灵兽
---@type table<number:用来装备在装备List里面的Index下标, number:道具item>>
LuaSynthesisMgr.PlayerServant = {}
---灵兽的灵兽装备
---@type table<number:用来装备在装备List里面的Index下标, number:道具item>>
LuaSynthesisMgr.PlayerServantEquip = {}
---人物的法宝装备
---@type table<number:用来装备在装备List里面的Index下标, number:道具item>>
LuaSynthesisMgr.PlayerMagicEquips = {}
---人物的外观
---@type number[]
LuaSynthesisMgr.PlayerOutputgood = {}

---重新设置一些检测信息
---为了减少反射消耗,在一系列检测之前,先获取到人物的等级/转生/灵兽的等级/转生
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
---@param JustRefreshRedDot boolean 仅仅刷新红点，不刷新页签
---@return boolean 是否发生了基础属性变动
function LuaSynthesisMgr:ResetDataInfo(itemList, itemId, JustRefreshRedDot)
    if (self.IsInit == false) then
        return
    end
    self.RoleDtaIsChange = false

    if (self.RoleData == nil) then
        self.RoleData = luaclass.LuaSynthesisRoleData:New();
        self.RoleDtaIsChange = true
    end

    self:CheckRoleInfoIsChange();
    self:CheckRoleEquipIsChange();
    if (uiStaticParameter.OpenEudemonsDetection) then
        self:CheckServantInfoIsChange();
        self:CheckServantEquipIsChange();
    end
    self:CheckMagicEquipmentIsChange()
    self:CheckBagIsChange();
    self:CheckSkillIsChange()
    self:CheckOutputgoodIsChange()

    if (self.RoleDtaIsChange) then
        self:CalculateAllSynthesisData(itemList, itemId, JustRefreshRedDot)
    end
    return self.RoleDtaIsChange
end

---检测人物的数据是否发生了改变(等级/转生/职业/性别都会导致红点发生变化)
function LuaSynthesisMgr:CheckRoleInfoIsChange()
    local level = CS.CSScene.MainPlayerInfo.Level;
    if (self.RoleData.roleLevel ~= level) then
        self.RoleData.roleLevel = level
        self.RoleDtaIsChange = true
    end
    local ReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel;
    if (self.RoleData.roleRein ~= ReinLevel) then
        self.RoleData.roleRein = ReinLevel
        self.RoleDtaIsChange = true
    end

    local Career = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career);
    if (self.RoleData.Career ~= Career) then
        self.RoleData.Career = Career
        self.RoleDtaIsChange = true
    end

    local Sex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex);
    if (self.RoleData.Sex ~= Sex) then
        self.RoleData.Sex = Sex
        self.RoleDtaIsChange = true
    end

    local openServerDay = CS.CSScene.MainPlayerInfo.ActualOpenDays
    if self.RoleData.ServerOpenDay ~= openServerDay then
        self.RoleData.ServerOpenDay = openServerDay
        self.RoleDtaIsChange = true
    end
    ---如果服务器时间未同步,上面计算的开服天数就是不正常的,应当绑定心跳包来进行二次刷新
    if openServerDay == -1 and CS.CSServerTime.IsServerTimeReceived == false then
        if self.mResHeartCallBack == nil then
            self.mResHeartCallBack = function()
                if CS.CSServerTime.IsServerTimeReceived == false then
                    return
                end
                self.mSocketEventHandler:RemoveEvent(1010, self.mResHeartCallBack)
                self:ResetDataInfo()
            end
        end
        self.mSocketEventHandler:AddEvent(1010, self.mResHeartCallBack)
    end
end

---检测人物的穿戴的是否发生了改变(合成列表会根据人物穿戴的装备发生变化  例如强制显示穿戴的装备到合成列表中)
function LuaSynthesisMgr:CheckRoleEquipIsChange()
    ---@type table<number,bagV2.BagItemInfo> lua的bagV2.BagItemInfo
    local equips = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllEquipmentItemList()
    --local equips = CS.CSScene.MainPlayerInfo.EquipInfo:GetBodyEquipsList();
    if (self.RoleData.EquipData == nil or Utility.GetTableCount(self.RoleData.EquipData) ~= Utility.GetTableCount(equips)) then
        self.RoleData.EquipData = {}
        self.PlayerBodyEquip = {}
        self.RoleDtaIsChange = true
    end

    if (self.IsReCheckRoleEquip == true or self.RoleDtaIsChange == true) then
        --print("只有在人物穿装备,脱装备,替换装备的时候,才会去重写检测人物身上的东西")
        --CS.UnityEngine.Debug.LogError("只有在人物穿装备,脱装备,替换装备的时候,才会去重写检测人物身上的东西")
        self.IsReCheckRoleEquip = false
        ---@param equip bagV2.BagItemInfo
        for i = 1, #equips do
            local equipItemId = equips[i].itemId
            if (self.RoleData.EquipData[i] == nil or self.RoleData.EquipData[i] ~= equipItemId) then
                self.RoleDtaIsChange = true

                self.RoleData.EquipData[i] = equipItemId;
                self.PlayerBodyEquip[i] = equipItemId
            end
        end
    end
end

---检测灵兽信息是否发生改变,灵兽相关合成道具会根据所有的灵兽的最大的等级/最小等级/最大转生/最小转生发生变动
function LuaSynthesisMgr:CheckServantInfoIsChange()
    if (self.RoleData.Servant == nil) then
        self.RoleData.Servant = {}
        self.PlayerServant = {}
        self.RoleDtaIsChange = true
    end

    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2;
    ---获取到所有的灵兽的最大的等级/最小等级/最大转生/最小转生
    local servantList = servantInfo.ServantInfoList;
    if (servantList.Count > 0) then
        for i = 0, servantList.Count - 1 do
            local servantInfoTemp = servantList[i];
            local servantCache = self.RoleData.Servant[i]
            if (servantCache == nil) then
                servantCache = {}
                servantCache["itemId"] = servantInfoTemp.cfgId
                servantCache["level"] = servantInfoTemp.level
                servantCache["rein"] = servantInfoTemp.rein
                self.RoleDtaIsChange = true
                self.PlayerServant[i] = servantInfoTemp.itemId
            else
                if (servantCache["itemId"] ~= servantInfoTemp.itemId) then
                    servantCache["itemId"] = servantInfoTemp.cfgId
                    self.RoleDtaIsChange = true

                    self.PlayerServant[i] = servantInfoTemp.itemId
                end

                if (servantCache["level"] ~= servantInfoTemp.level) then
                    servantCache["level"] = servantInfoTemp.level
                    self.RoleDtaIsChange = true
                end
                if (servantCache["rein"] ~= servantInfoTemp.rein) then
                    servantCache["rein"] = servantInfoTemp.rein
                    self.RoleDtaIsChange = true
                end
            end
            self.RoleData.Servant[i] = servantCache;
        end
    end
end

---检测灵兽穿戴的装备是否发生变化
function LuaSynthesisMgr:CheckServantEquipIsChange()
    local servantInfo = CS.CSScene.MainPlayerInfo.ServantInfoV2;
    local servantEquips = servantInfo:GetAllServantInfoList();

    if (self.RoleData.ServantEquipData == nil or Utility.GetTableCount(self.RoleData.ServantEquipData) ~= servantEquips.Count) then
        self.RoleData.ServantEquipData = {}
        self.PlayerServantEquip = {}
        self.RoleDtaIsChange = true
    end

    if (self.IsReCheckRoleEquip == true or self.RoleDtaIsChange == true) then
        for i = 0, servantEquips.Count - 1 do
            local equip = servantEquips[i].itemId
            if (self.RoleData.ServantEquipData[i] == nil or self.RoleData.ServantEquipData[i] ~= equip) then
                self.RoleDtaIsChange = true
                self.RoleData.ServantEquipData[i] = equip;
                self.PlayerServantEquip[i] = equip;

            end
        end
    end
end

---检测身上的法宝是否发生改变
function LuaSynthesisMgr:CheckMagicEquipmentIsChange()
    ---@type table<bagV2.BagItemInfo>
    local magicEquips = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():GetAllMagicEquipItems()
    if (self.RoleData.MagicEquips == nil or Utility.GetTableCount(self.RoleData.MagicEquips) ~= #magicEquips) then
        self.RoleData.MagicEquips = {}
        self.PlayerMagicEquips = {}
        self.RoleDtaIsChange = true
    end

    if (self.IsReCheckRoleEquip == true or self.RoleDtaIsChange == true) then
        for i = 1, #magicEquips do
            local equip = magicEquips[i].itemId
            if (self.RoleData.MagicEquips[i] == nil or self.RoleData.MagicEquips[i] ~= equip) then
                self.RoleDtaIsChange = true
                self.RoleData.MagicEquips[i] = equip;
                self.PlayerMagicEquips[i] = equip;
            end
        end
    end
end

---有些道具会根据是否存在背包中进行显示
function LuaSynthesisMgr:CheckBagIsChange()
    if (self.RoleBagIsChange == true) then
        self.RoleBagIsChange = false
        self.RoleDtaIsChange = true
    end
end

---检测技能数据是否发生了变化
function LuaSynthesisMgr:CheckSkillIsChange()
    ---@type table<number,LuaSkillDetailedInfo> key：技能ID  value：LuaSkillDetailedInfo
    local SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if (self.RoleData.Skill == nil or Utility.GetTableCount(SkillInfoDic) ~= #self.RoleData.Skill) then
        self.RoleData.Skill = {}
        self.RoleDtaIsChange = true
    end

    if (self.RoleDtaIsChange and #self.RoleData.Skill == 0) then
        for i, v in pairs(SkillInfoDic) do
            table.insert(self.RoleData.Skill, i)
        end
    end
end

---检测外观数据是否发生了变化
function LuaSynthesisMgr:CheckOutputgoodIsChange()
    local FashionList = CS.CSScene.MainPlayerInfo.Appearance.AppearanceData.FashionList
    if (FashionList == nil) then
        return
    end

    local temPlayerOutputgood = {}

    for i = 0, FashionList.Count - 1 do
        if (FashionList[i].itemList ~= nil) then
            for j = 0, FashionList[i].itemList.Count - 1 do
                if (FashionList[i].itemList[j] ~= nil) then
                    table.insert(temPlayerOutputgood, FashionList[i].itemList[j].itemId)
                end
            end
        end
    end

    if (self.RoleData.FashionList == nil or #temPlayerOutputgood ~= #self.RoleData.FashionList) then
        self.RoleData.FashionList = temPlayerOutputgood
        self.PlayerOutputgood = temPlayerOutputgood
        self.RoleDtaIsChange = true
    end
end
--endregion

--region 背包变动的时候,判定是否需要去检测合成变动(变动的东西以一定会影响合成变动)
---合成的条件发生了变动 刷新所有合成     红点/背包变动,等级变动的时候刷新所有红点
---@param tblData bagV2.ResBagChange lua table类型消息数据
function LuaSynthesisMgr:SynthesisConditionUpdate(tblData)
    local coinList = tblData.coinList
    local getItemList = tblData.itemList
    local RemovedIdList = tblData.removedIdList
    ---只有在人物穿装备,脱装备,替换装备的时候,才会去重写检测人物身上的东西
    if (tblData.action == LuaEnumBagChangeAction.PUTON or tblData.action == LuaEnumBagChangeAction.PUTOFF or tblData.action == LuaEnumBagChangeAction.PUTOFF_ChangeEquip) then
        self.IsReCheckRoleEquip = true;
    end

    local isChange = false

    if (coinList ~= nil and isChange == false) then
        isChange = #coinList > 0
    end

    if (getItemList ~= nil and isChange == false) then
        isChange = self:IsExitBagItemListChange(getItemList);
    end

    --测试,所有背包移除都进行红点变动
    if (RemovedIdList ~= nil and #RemovedIdList > 0) then
        isChange = true
    end

    --if (isChange == false) then
    --    return
    --end
    self.RoleBagIsChange = true
    if (tblData.itemList ~= nil and #tblData.itemList > 0) then
        self:CallAllRedPoint(tblData.itemList);
    end
    if (tblData.removeItemList ~= nil and #tblData.removeItemList > 0) then
        self:CallAllRedPoint(tblData.removeItemList);
    end
    if tblData.coinList ~= nil and #tblData.coinList > 0 then
        self:CallAllRedPoint(nil, nil, true)
    end
end

function LuaSynthesisMgr:IsExitBagItemListChange(list)
    for i, v in pairs(list) do
        if (self:IsExitBagItemChange(v.itemId)) then
            return true
        end
    end
    return false
end

---背包变动了,但是导致背包变动的不一定是合成相关的
---@return boolean 背包变动是否会导致合成相关发生改变
function LuaSynthesisMgr:IsExitBagItemChange(itemId)
    if (self.SynthesisMainMaterialDic ~= nil and self.SynthesisMainMaterialDic[itemId] ~= nil) then
        return true
    end
    return false
end
--endregion

---刷新所有合成红点
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
---@param JustRefreshRedDot boolean 仅仅刷新红点，不刷新页签
function LuaSynthesisMgr:CallAllRedPoint(itemList, itemId, JustRefreshRedDot)
    self:ResetDataInfo(itemList, itemId, JustRefreshRedDot)
end

---直接重新计算所有
function LuaSynthesisMgr:JustCallAllRedPoint()
    self:CalculateAllSynthesisData()
end

---重新计算所有红点合成数据
---注意了,这个是为了减少性能消耗,只有在调用这个对应以及下属对应的方法的时候,才会去计算红点的显隐条件,其他的使用IsShowRed方法只是简单的返回一个true/false
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
---@param JustRefreshRedDot boolean 仅仅刷新红点，不刷新页签
function LuaSynthesisMgr:CalculateAllSynthesisData(itemList, itemId, JustRefreshRedDot)
    local panel = uimanager:GetPanel("UISynthesisPanel")
    local delayFrame = 0
    if panel then
        delayFrame = 500
    else
        delayFrame = 1000
    end
    if (self:DelayRefresh():GetDelayCount() > 0) then
        delayFrame = delayFrame * (self:DelayRefresh():GetDelayCount() + 1)
    end

    self:DelayRefresh():Creat(delayFrame, function(itemList, itemId, JustRefreshRedDot)
        --计算更新合成的界面显示按钮列表
        if (self:CheckWhetherToRefreshTheCompositeTab(itemList, JustRefreshRedDot)) then
            self:CalculateSynthesisMainCategoryPageButton(itemList, itemId)
        end
        --计算合成红点
        self:CalculateSynthesisRedPoint(itemList, itemId)
    end, false, itemList, itemId, JustRefreshRedDot)
end

---计算更新合成的界面显示按钮列表
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
function LuaSynthesisMgr:CalculateSynthesisMainCategoryPageButton(itemList, itemId)
    if (self.IsInit == false) then
        return
    end
    self.SynthesisSubCategoryPageButton = {};
    if self.MainCategoryPageList then
        for k, v in pairs(self.MainCategoryPageList) do
            ---@type LuaSynthesis_MainCategory
            local mainCategory = v
            mainCategory:CalculateSynthesisSubCategoryPageButton(itemList, itemId);

            if (mainCategory ~= nil and Utility.GetTableCount(mainCategory:GetSynthesisSubCategoryPageButton()) > 0) then
                table.insert(self.SynthesisSubCategoryPageButton, mainCategory);
            end
        end
    end

    luaEventManager.DoCallback(LuaCEvent.Synthesis_UpdateUI);
end

---计算更新合成的红点数据
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId相关变动变动
function LuaSynthesisMgr:CalculateSynthesisRedPoint(itemList, itemId)
    self:SyncCalculateSynthesisRedPoint(itemList, itemId)
end

---计算更新合成的红点数据
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId相关变动变动
function LuaSynthesisMgr:SyncCalculateSynthesisRedPoint(itemList, itemId)
    if (self.IsInit == false) then
        return
    end
    local lastRedState = self.RedState
    self.RedState = false
    if self.SynthesisSubCategoryPageButton then
        for i, v in pairs(self.SynthesisSubCategoryPageButton) do
            ---@type LuaSynthesis_MainCategory
            local MainCategory = v

            MainCategory:CalculateAllSynthesisData(itemList, itemId)
            if (MainCategory:IsShowRed()) then
                self.RedState = true
            end
        end
    end
    ---只有2次红点状态不一样的时候,才需要重新call
    if (lastRedState ~= self.RedState) then
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():CallRedPoint(self.RedKey);
    end
end

---是否显示红点
function LuaSynthesisMgr:IsShowRed()
    return self.RedState
end

---是否刷新合成页签
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param JustRefreshRedDot boolean 仅仅刷新红点，不刷新页签
---@return boolean
function LuaSynthesisMgr:CheckWhetherToRefreshTheCompositeTab(itemList, JustRefreshRedDot)
    ---只刷新红点时不刷新页签，如金钱变动
    if (JustRefreshRedDot == true) then
        return false
    end
    ---非物品变动时，刷新页签，如升级，飞升，属性变化等
    if (itemList == nil) then
        return true
    end
    ---物品变动，但不能合成物品，不刷新页签
    for i = 1, #itemList do
        local itemId = itemList[i].itemId
        if (clientTableManager.cfg_synthesisManager:IsCanSynthesis(itemId) == true) then
            return true
        end
    end
    return false
end

--region 合成相关的数据获取
---合成的状态编码
---@class ELuaSynthesisStateCode
ELuaSynthesisStateCode = {
    ---正常合成
    NormalCanSynthesis = 0,
    ---不能合成
    NoCan = 1,
    ---不能材料不足
    MaterialNotEnough = 2,
    ---提示合成
    TipSynthesis = 3,
}

---获取此个物品合成的异常码0:可正常合成, 1:此物品不能合成, 2:需求数量不足,3:可以正常合成,但是所有的材料均是身上材料(2个戒指都是身上的)
---@param synthesisTable TABLE.cfg_synthesis lua合成表
---@param bagItemInfo bagV2.BagItemInfo lua的道具类
---@param count number 合成数量
---@return ELuaSynthesisStateCode
function LuaSynthesisMgr:GetSynthesisStateCode(synthesisTable, bagItemInfo, count)
    if (synthesisTable == nil) then
        return ELuaSynthesisStateCode.NoCan
    end
    local synthesisId = synthesisTable:GetId()
    ---@type LuaSynthesis_Item
    local synthesisData = self:GetSynthesisDataBySynthesisId(synthesisTable:GetId())

    return synthesisData:GetSynthesisStateCode()
end

--endregion

--region 自动选择
---自动选择当前选择的装备位
function LuaSynthesisMgr:AutoChooseEquipIndex()
    local chooseItem = self:GetChooseItemInfoClass():GetChooseItem()
    if chooseItem == nil then
        return
    end
    ---@type UISynthesisPanel
    local uiSynthesisPanel = uimanager:GetPanel("UISynthesisPanel")
    if uiSynthesisPanel == nil then
        return
    end
    uiSynthesisPanel:TrySetSelectBagItem(chooseItem)
end

---判定道具是否点击合成的时候跳转到合成列表
---@param bagItemInfo bagV2.BagItemInfo
function LuaSynthesisMgr:IsJumpSynthesisList(bagItemInfo)
    if (self.AllItemJumpSynthesisData == nil) then
        ---所有需要跳转到合成表的列表,key为道具ID
        self.AllItemJumpSynthesisData = LuaGlobalTableDeal:GetItemJumpSynthesisData()
    end

    for i, jumpData in pairs(self.AllItemJumpSynthesisData) do
        if (i == bagItemInfo.itemId) then
            return jumpData
        end
    end
    return nil
end

--endregion

---@public 更新合成记录
function LuaSynthesisMgr:UpdateSynthesisHistoryData(historyData)
    if (self.mSynthesisHistoryData ~= historyData) then
        self.mSynthesisHistoryData = historyData;
        self:CalculateAllSynthesisData();
    end
end

---@public 获得合成记录数据
---@return storeV2.CombineRecord
function LuaSynthesisMgr:GetSynthesisHistoryData()
    return self.mSynthesisHistoryData;
end

---@public 是否已经合成过
---@return boolean
function LuaSynthesisMgr:HasBeenSynthesized(synthesisId)
    if (self.mSynthesisHistoryData ~= nil and self.mSynthesisHistoryData.combineId ~= nil) then
        for k, v in pairs(self.mSynthesisHistoryData.combineId) do
            if (v == synthesisId) then
                return true;
            end
        end
    end
    return false;
end

---@public
---是否是法宝装备,不检测身上装备
---@param synthesis TABLE.cfg_synthesis
---@return boolean true:不检测身上装备，false:检测身上装备
function LuaSynthesisMgr:IsMagicWeapon(itemId, synthesis)
    ---合成表检测类型判断
    if (synthesis ~= nil and synthesis:GetEquipExamine() ~= nil and synthesis:GetEquipExamine() == 1) then
        return true
    end
    ---装备类型判断
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(itemId)
    local isArtifact = false;
    if (itemTbl ~= nil) then
        isArtifact = itemTbl:GetType() == luaEnumItemType.Equip and itemTbl:GetSubType() == LuaEnumEquipSubType.Equip_MagicWeapon
    end
    return isArtifact
end

---获取合成次数
---@public
function LuaSynthesisMgr:GetSynthesCount(synthesisId)
    if (self.mSynthesisHistoryData ~= nil and self.mSynthesisHistoryData.combineId ~= nil) then
        for k, v in pairs(self.mSynthesisHistoryData.combineCount) do
            if (v.combineId == synthesisId) then
                return v.count
            end
        end
    end
    return 0
end

function LuaSynthesisMgr:Release()
    if self.mSocketEventHandler then
        self.mSocketEventHandler:UnRegAll()
        self.mSocketEventHandler = nil
    end
end

return LuaSynthesisMgr