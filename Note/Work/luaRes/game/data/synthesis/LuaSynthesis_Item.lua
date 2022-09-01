---@class LuaSynthesis_Item 合成的道具信息
local LuaSynthesis_Item = {}

--region 调试参数
---是否正在调试
---@type boolean
LuaSynthesis_Item.mIsDebuging = false
---调试中关注的合成表ID
---@type number
LuaSynthesis_Item.mDebugFocusSynthesisID = 1057
--endregion

---lua中的合成表
---@type TABLE.cfg_synthesis
LuaSynthesis_Item.synthesisTable = nil

---输出的物品的物品表
---@type TABLE.cfg_items
LuaSynthesis_Item.outPutGoodItemTable = nil
---货币不作为红点判定条件,注释掉
--[[
---货币是否足够状态(不作为红点触发条件,注释掉)
---@type boolean
--LuaSynthesis_Item.isCoinEnough = nil
--]]

---所属合成大类
LuaSynthesis_Item.Type = 0;
---当前所在合成分类
LuaSynthesis_Item.SubType = 0;

LuaSynthesis_Item.Name = nil
---合成道具的显隐条件
---@type table<number>
LuaSynthesis_Item.conditionTypesCache = nil

---判定条件的检测方式
---@type LuaEnumSynthesisConditionMatchType
LuaSynthesis_Item.conditionRelation = nil

---显示的条件千千万  但是职业性别不符  直接隐藏
---注意了  这个数值需要在换角色的时候重新检查一遍
LuaSynthesis_Item.IsAlwaysHide = nil

---是否显示在合成列表中
LuaSynthesis_Item.IsShowInSynthesisList = nil
---合成的红点显示
LuaSynthesis_Item.RedState = nil
---合成的红点key
LuaSynthesis_Item.RedKey = nil
---合成的输出道具
LuaSynthesis_Item.Outputgoods = nil

---这个合成配方需要的材料列表(在背包变动的时候,只有变动的道具在这个里面找到了,才会去刷新红点以及列表数据)
LuaSynthesis_Item.Materials = nil
---@type table<number, number>
LuaSynthesis_Item.NeedMaterialCountList = nil

---所有的合成材料的数据,这里直接弄成{}  表示这个东西是一个静态的列表,避免了1 2000条的合成数据,然后new出了无数的材料,大部分的情况下,大部分材料是其实是通用的
---@type table<LuaMaterialData>
LuaSynthesis_Item.NeedMaterialDataList = {}

---消耗的货币,由于金币以及元宝这些可能变动的过于频繁,那么在货币筏子的时候才进行判定,并且这里也仅仅只判定货币
LuaSynthesis_Item.Currencies = nil

LuaSynthesis_Item.CostCoins = nil;

---初始化
---@param tbl TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:InitSynthesisTable(tbl)
    self.conditionRelation = LuaEnumSynthesisConditionMatchType.AND;
    self.synthesisTable = tbl;
    self.Type = tbl:GetTabType()
    self.SubType = tbl:GetTabSubType()
    self.Name = tbl:GetName()
    self:InitSynthesisMaterials(tbl)
    self:InitSynthesisCondition(tbl)
    self:RegisterRed();
end

function LuaSynthesis_Item:GetTabType()
    return self.Type;
end

function LuaSynthesis_Item:GetTabSubType()
    return self.SubType;
end

---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:InitSynthesisMaterials(synthesisTable)
    self.Materials = {}

    local items = synthesisTable:GetItemid()

    if (items ~= nil and items.list ~= nil) then
        ---@param itemId number 道具表的id
        for i, itemId in pairs(items.list) do

            table.insert(self.Materials, itemId);
            if (LuaSynthesis_Item.NeedMaterialDataList[itemId] == nil) then
                ---@type LuaMaterialData
                local temp = luaclass.LuaMaterialData:New()
                LuaSynthesis_Item.NeedMaterialDataList[itemId] = temp

                temp:GenerateData(itemId)
            end

        end
    end

    self.NeedMaterialCountList = {}
    ---@type TABLE.IntListJingHao
    local costNumber = synthesisTable:GetNumber()

    if costNumber ~= nil and costNumber.list ~= nil then
        for i, v in pairs(costNumber.list) do
            table.insert(self.NeedMaterialCountList, tonumber(v));
        end
    end


    --local items = synthesisTable:GetItemid()
    --if (items ~= nil and items.list ~= nil and items.list.Count > 0) then
    --    for i = 0, items.list.Count - 1 do
    --        table.insert(self.Materials, items.list[i]);
    --    end
    --end
    --
    --local ReplaceItemids = synthesisTable:GetReplaceItemid()
    --if (ReplaceItemids ~= nil and ReplaceItemids.list ~= nil and ReplaceItemids.list.Count > 0) then
    --    for i = 0, ReplaceItemids.list.Count - 1 do
    --        table.insert(self.Materials, ReplaceItemids.list[i]);
    --    end
    --end

    self.CostCoins = {};
    local coins = synthesisTable:GetCurrency()

    if (coins ~= nil and coins.list ~= 0 and #coins.list >= 2) then
        self.CostCoins[coins.list[1]] = coins.list[2];
    end
end

--region 列表的显示
---初始化合成的条件
---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:InitSynthesisCondition(synthesisTable)
    if (synthesisTable.conditionType ~= nil and #synthesisTable.conditionType.list > 0) then
        self.conditionTypesCache = {}
        for i = 1, #synthesisTable.conditionType.list do
            local type = synthesisTable.conditionType.list[i].list[1];
            if (type ~= nil) then
                if type == LuaEnumSynthesisConditionType.CheckShowPriority then
                    ---如果需要检查显示优先级,则不应在单个表的显示条件中进行判定,而应在后续处理中进行判定,在此处加上标记即可
                    synthesisTable.mIsNeedCheckShowPriority = true
                else
                    if (#synthesisTable.conditionType.list[i].list > 1) then
                        local params = {};
                        for j = 2, #synthesisTable.conditionType.list[i].list do
                            table.insert(params, synthesisTable.conditionType.list[i].list[j]);
                        end
                        table.insert(self.conditionTypesCache, { table = synthesisTable, type = type, params = params });
                    else
                        table.insert(self.conditionTypesCache, { table = synthesisTable, type = type });
                    end
                end
            end
        end
    end

    --判定条件的检测方式(并/或)
    if (self.synthesisTable.conditionRelation ~= nil) then
        self.conditionRelation = self.synthesisTable.conditionRelation;
    end
end

---是否显示在UI上面
---@return boolean 是否能显示在列表中
function LuaSynthesis_Item:GetIsShowInSynthesisList()
    return self.IsShowInSynthesisList
end

---计算是否显示的UI上面
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
function LuaSynthesis_Item:CalculateSynthesisPageButton(itemList, itemId)
    ---如果这个传入的参数不为null,说明这个变动是由于背包变动导致的,那么只有这个里面变动的东西是和当前合成的相关联,才需要重新计算
    if (itemList ~= nil and self:IsInfluenceSynthesis(itemList) == false) then
        return
    end

    if (itemId ~= nil and self:IsInfluenceSynthesis(nil, itemId) == false and (self.synthesisTable:GetEquipItem() ~= nil and Utility.IsContainsValue(self.synthesisTable:GetEquipItem().list, itemId) == false)) then
        return
    end

    --if(itemId ~= nil and self.synthesisTable:GetEquipItem() ~= itemId) then
    --    return
    --end

    ---计算是否显示的UI上面
    if (self:IsExitBody(self.synthesisTable)) then
        self.IsShowInSynthesisList = true;
    else
        self.IsShowInSynthesisList = self:CheckIsShowInUI()
    end
end

---隐藏在合成列表中
---@private
function LuaSynthesis_Item:SetHideInSynthesisList()
    self.IsShowInSynthesisList = false
end

---是否显示在合成列表中  只有在满足条件的情况下,才能显示在列表里面
---@return boolean
function LuaSynthesis_Item:CheckIsShowInUI()
    ---不存在任何的显隐条件,那么直接显示
    if (self.conditionTypesCache == nil) then
        return true
    end

    ---总是隐藏
    if (self.IsAlwaysHide) then
        return false
    end

    local isShowToHistory = self.synthesisTable:GetShow() == 1;

    if (isShowToHistory) then
        if (gameMgr:GetPlayerDataMgr():GetSynthesisMgr():HasBeenSynthesized(self.synthesisTable:GetId())) then
            return false;
        end
    end

    local isHaveFinalEquipmentAndNoDisplayed = self:IsHaveFinalEquipmentAndNoDisplayed(self.synthesisTable)
    if (isHaveFinalEquipmentAndNoDisplayed) then
        return false
    end

    if (self.conditionRelation == LuaEnumSynthesisConditionMatchType.AND) then

        ---所有条件都满足的情况下才显示
        for k, v in pairs(self.conditionTypesCache) do
            if (not self:IsMainPlayerMatchSynthesisType(v.table, v.type, v.params)) then

                return false;
            end
        end

        return true;
    elseif (self.conditionRelation == LuaEnumSynthesisConditionMatchType.OR) then
        ---所以条件任意满足
        for k, v in pairs(self.conditionTypesCache) do
            if (self:IsMainPlayerMatchSynthesisType(v.table, v.type, v.params)) then
                return true;
            end
        end
    end
end

---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:IsMainPlayerMatchSynthesisType(synthesisTable, type, params)
    if (synthesisTable == nil) then
        return false;
    end
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    if (type == LuaEnumSynthesisConditionType.PlayerLevel) then
        ---玩家等级区间
        local levelMin = synthesisTable:GetRoleLevelMin();
        local levelMax = synthesisTable:GetRoleLevelMax();
        if ((levelMin ~= nil and SynthesisMgr.RoleData["roleLevel"] >= synthesisTable:GetRoleLevelMin()) and
                (levelMax ~= nil and SynthesisMgr.RoleData["roleLevel"] <= synthesisTable:GetRoleLevelMax())) then
            return true
        end
    elseif (type == LuaEnumSynthesisConditionType.PlayerReinLevel) then
        ---玩家转生等级上限
        local reinMin = synthesisTable:GetRoleReinMin();
        local reinMax = synthesisTable:GetRoleReinMax();
        if ((reinMin ~= nil and SynthesisMgr.RoleData["roleRein"] >= synthesisTable:GetRoleReinMin()) and
                (reinMax ~= nil and SynthesisMgr.RoleData["roleRein"] <= synthesisTable:GetRoleReinMax())) then
            return true
        end
    elseif (type == LuaEnumSynthesisConditionType.SomeServantLevel) then
        ---任意灵兽等级在区间中
        local min = synthesisTable:GetServantLevelMin()
        local max = synthesisTable:GetServantLevelMax()
        for i, v in pairs(SynthesisMgr.RoleData["Servant"]) do
            local level = v["level"]
            if (level >= min and level <= max) then
                return true
            end
        end
    elseif (type == LuaEnumSynthesisConditionType.SomeServantReinLevel) then
        ---任意灵兽转生上限
        local min = synthesisTable:GetServantReinMin()
        local max = synthesisTable:GetServantReinMax()
        for i, v in pairs(SynthesisMgr.RoleData["Servant"]) do
            local level = v["rein"]
            if (level >= min and level <= max) then
                return true
            end
        end
    elseif (type == LuaEnumSynthesisConditionType.HasMainMaterial) then
        ---身上有主材料
        if synthesisTable:GetBagItem() ~= nil and synthesisTable:GetBagItem().list ~= nil and Utility.GetLuaTableCount(synthesisTable:GetBagItem().list) > 0 then
            for k, v in pairs(synthesisTable:GetBagItem().list) do
                local itemId = v
                if gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(itemId) > 0 then
                    return true
                end
            end
        end
        --if (gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(synthesisTable:GetBagItem()) > 0) then
        --    return true
        --end
    elseif (type == LuaEnumSynthesisConditionType.OpenServerDay) then
        ---开服天数
        local openServerDay = synthesisTable:GetOpenDay()
        if openServerDay and SynthesisMgr.RoleData.ServerOpenDay then
            if SynthesisMgr.RoleData.ServerOpenDay >= openServerDay then
                return true;
            end
        end
    elseif (type == LuaEnumSynthesisConditionType.NearOccupation) then
        ---偏职业
        if (synthesisTable:GetCareer() == 0 or synthesisTable:GetCareer() == SynthesisMgr.RoleData.Career) then
            return true
        end
    elseif (type == LuaEnumSynthesisConditionType.MainPlayerLevelSex) then
        ---玩家性别
        if (synthesisTable:GetSex() == 0 or synthesisTable:GetSex() == SynthesisMgr.RoleData.Sex) then
            return true
        end
    elseif (type == LuaEnumSynthesisConditionType.UnLock_HMServant) then
        return CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > 0
    elseif (type == LuaEnumSynthesisConditionType.UnLock_LXServant) then
        return CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > 1
    elseif (type == LuaEnumSynthesisConditionType.UnLock_TCServant) then
        return CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ServantInfoV2.ServantInfoList.Count > 2
    elseif (type == LuaEnumSynthesisConditionType.CheckShowPriority) then
        ---检查是否显示优先级时,返回true,在后续步骤中进行检查
        return true
    end

    return false;
end

--endregion

--region 红点相关的东西

function LuaSynthesis_Item:SetParentRedKey(redKey)
    self.RedKey = redKey;
end

---注册红点
function LuaSynthesis_Item:RegisterRed()
    self.Outputgoods = {}
    if (self.synthesisTable:GetOutputgoods() ~= nil and self.synthesisTable:GetOutputgoods().list ~= nil) then
        --由于一个合成道具表可能1对多  所以需要去注册可能合成的所有东西(感觉后续可以优化,毕竟所有的合成目标所需要的测材料是一样的,那么1个能合成,其他应该也能合成,干嘛不直接用合成表的ID去注册)
        for i, itemId in pairs(self.synthesisTable:GetOutputgoods().list) do
            table.insert(self.Outputgoods, itemId)
            ---第一个合成目标
            if (self.outPutGoodItemTable == nil) then
                self.outPutGoodItemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
            end
        end
    end

    --self.RedKey = self:GetButtonRedPointKey(self.synthesisTable:GetId());
    --if (self.RedKey ~= nil) then
    --    --定义红点刷新的时候检测方法
    --    local callBack =  function()
    --        return self:IsShowSynthesisRedPoint();
    --    end
    --    --注册红点
    --    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.RedKey);
    --    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self.RedKey, callBack);
    --end
end

function LuaSynthesis_Item:GetButtonRedPointKey(itemId)
    if (itemId ~= nil) then
        local redPointName = gameMgr:GetLuaRedPointManager():GetSynthesisListRedPointName(itemId);
        if (redPointName ~= nil) then
            local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
            return redKey;
        end
    end
    return nil;
end

---是否显示红点
function LuaSynthesis_Item:IsShowSynthesisRedPoint()
    local isShow = self.IsShowInSynthesisList and self.RedState;
    return isShow;
end

---重新计算所有红点合成数据
---注意了,这个是为了减少性能消耗,只有在调用这个对应以及下属对应的方法的时候,才会去计算红点的显隐条件,其他的使用IsShowRed方法只是简单的返回一个true/false
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId相关变动变动
function LuaSynthesis_Item:CalculateSynthesisData(itemList, itemId)
    ---合成表中的redPoint字段表示是否响应红点
    if self.synthesisTable and self.synthesisTable:GetRedPoint() == 0 then
        self.RedState = false
        return
    end
    ---如果这个传入的参数不为null,说明这个变动是由于背包变动导致的,那么只有这个里面变动的东西是和当前合成的相关联,才需要重新计算
    if (itemList ~= nil and self:IsInfluenceSynthesis(itemList) == false) then
        return
    end

    --if (itemId ~= nil and self:IsInfluenceSynthesis(nil, itemId) == false) then
    --    return
    --end

    ---计算红点
    local lastRedState = self.RedState
    if (self.Outputgoods == nil) then
        self.RedState = false
    else
        ---只要有一个目标可以合成,那么这个合成项就可以有红点
        for i, outItemId in pairs(self.Outputgoods) do
            self.RedState = false
            if (self:IsShowSynthesisResultRedPoint(outItemId)) then
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToCanShieldSynthesisRedList(outItemId, self.synthesisTable:GetId())
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():SetSynthesisListFirstCache({ firstType = self.Type, secondType = self.SubType, thirdItemId = outItemId })
                self.RedState = true
            else
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():RemoveToCanShieldSynthesisRedList(outItemId, self.synthesisTable:GetId())
            end
        end
    end

    ---只有2次红点状态不一样的时候,才需要重新call
    if (lastRedState ~= self.RedState) then
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():CallRedPoint(self.RedKey);
    end
end

---判定传入的合成道具是否在人物身上/灵兽位上/灵兽位的装备上 如果是的话,那么列表需要强制显示
---判定传入的合成道具是否在人物身上/灵兽位上/灵兽位的装备上
---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:IsExitBody(synthesisTable)
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    ---偏职业
    if (synthesisTable:GetCareer() ~= 0 and synthesisTable:GetCareer() ~= SynthesisMgr.RoleData.Career) then
        return false
    end

    local compel = synthesisTable:GetCompel();
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()

    local isShowToHistory = synthesisTable:GetShow() == 1;

    if (isShowToHistory) then
        if (gameMgr:GetPlayerDataMgr():GetSynthesisMgr():HasBeenSynthesized(synthesisTable:GetId())) then
            return false;
        end
    end

    local isHaveFinalEquipmentAndNoDisplayed = self:IsHaveFinalEquipmentAndNoDisplayed(synthesisTable)
    if (isHaveFinalEquipmentAndNoDisplayed) then
        return false
    end

    ---根据检测类型,获取到对应的穿戴带孀居
    if (compel == LuaEnumSynthesisMaterialExitPos.PlayerBodyEquip) then
        local result = self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerBodyEquip)
        if (result == true) then
            return true
        end

        local result = self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerMagicEquips)
        if (result == true) then
            return true
        end
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServant) then

        return self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerServant)
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServantEquip) then

        return self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerServantEquip)
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServantRoleEquip) then

        local result = self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerBodyEquip)
        if (result == true) then
            return true
        end

        local result = self:IsExitBodyCheck(synthesisTable, SynthesisMgr.PlayerServantEquip)
        if (result == true) then
            return true
        end
    end

    return false
end

---合成的最终物品是否已经拥有并且合成之后不再显示，如果成立从合成界面删除
---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_Item:IsHaveFinalEquipmentAndNoDisplayed(synthesisTable)
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    if (synthesisTable == nil or SynthesisMgr == nil or synthesisTable:GetOutputgoods() == nil) then
        return false
    end
    local isHide = synthesisTable:GetShow() == 1
    local isItemsInBag = self:DoYouHaveThisItemInYourBag(synthesisTable:GetOutputgoods().list)
    if (isItemsInBag and isHide) then
        return true
    end

    local compel = synthesisTable:GetCompel();
    local result = false
    ---根据检测类型,获取到对应的穿戴数据
    if (compel == LuaEnumSynthesisMaterialExitPos.PlayerBodyEquip) then
        result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerBodyEquip)
        if (result == false) then
            result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerMagicEquips)
        end
        if (result == false) then
            result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerOutputgood)
        end
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServant) then
        result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerServant)
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServantEquip) then
        result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerServantEquip)
    elseif (compel == LuaEnumSynthesisMaterialExitPos.PlayerServantRoleEquip) then
        result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerBodyEquip)
        if (result == false) then
            result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerServantEquip)
        end
        if (result == false) then
            result = self:IsHaveTheFinalGoods(synthesisTable, SynthesisMgr.PlayerOutputgood)
        end
    end
    return result and isHide
end

---列表中的物品在背包中数量大于0
---@param Outputgoods TABLE.IntListJingHao 合成物品集合
---@return boolean
function LuaSynthesis_Item:DoYouHaveThisItemInYourBag(Outputgoods)
    if (Outputgoods == nil) then
        return false
    end
    local count = 0
    for i, v in pairs(Outputgoods) do
        count = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(v)
        if (count > 0) then
            return true
        end
    end
    return false
end

---装备列表中是否拥有最终合成物品
---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
---@param exitList table<number:用来装备在装备List里面的Index下标, number:道具item>>
function LuaSynthesis_Item:IsHaveTheFinalGoods(synthesisTable, exitList)
    ---遍历所有的装备
    for i, itemId in pairs(exitList) do
        if (synthesisTable:GetOutputgoods() ~= nil and synthesisTable:GetOutputgoods().list ~= nil and Utility.IsContainsValue(synthesisTable:GetOutputgoods().list, itemId)) then
            return true
        end
    end
    return false
end

---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
---@param exitList table<number:用来装备在装备List里面的Index下标, number:道具item>>
function LuaSynthesis_Item:IsExitBodyCheck(synthesisTable, exitList)
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()
    ---遍历所有的装备
    for i, itemId in pairs(exitList) do
        if (synthesisTable:GetEquipItem() ~= nil and synthesisTable:GetEquipItem().list ~= nil and Utility.GetLuaTableCount(synthesisTable:GetEquipItem().list) > 0 and Utility.IsContainsValue(synthesisTable:GetEquipItem().list, itemId)) then
            ---偏职业
            if (synthesisTable:GetCareer() == 0 or synthesisTable:GetCareer() == SynthesisMgr.RoleData.Career) then
                return true
            end
            return true
        end
    end
    return false
end

---是否能合成最终目标道具
---@param itemId number 目标道具ID,用来判定箭头
function LuaSynthesis_Item:IsShowSynthesisResultRedPoint(itemId)
    --if (not gameMgr:GetLuaRedPointManager():HasSynthesisRedKey(itemId, rawItemIDs)) then
    --    return false;
    --end

    local MainPlayerInfo = CS.CSScene.MainPlayerInfo
    if (MainPlayerInfo == nil or MainPlayerInfo.BagInfo == nil) then
        return false;
    end

    if (gameMgr:GetPlayerDataMgr():GetSynthesisMgr():IsExitInShieldSynthesisRedList(itemId)) then
        return false;
    end

    if self:CoinCostIsEnough() == false then
        return false
    end

    ---@type TABLE.cfg_synthesis
    local synthesisTable = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesisByResultItemId(itemId)
    if (synthesisTable ~= nil) then
        local targetCount = synthesisTable:GetNumberLimit()
        ---合成次数限制
        if (targetCount > 0) then
            local synthesCount = gameMgr:GetPlayerDataMgr():GetSynthesisMgr():GetSynthesCount(synthesisTable.id)
            ---合成次数不足
            if (synthesCount >= targetCount) then
                return false
            end
        end
    end

    local itemTable = clientTableManager.cfg_itemsManager:TryGetValue(itemId);
    if (itemTable ~= nil) then
        ---等级不足不显示红点
        if (MainPlayerInfo.Level < itemTable:GetUseLv()) then
            return false
        end

        ---飞升不足不显示红点
        if (MainPlayerInfo.ReinLevel < itemTable:GetReinLv()) then
            return false
        end

        ---如果是技能书并且已经学习过该技能，不显示红点
        if (itemTable:GetType() == luaEnumItemType.SkillBook and gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():HasTheSkillBookBeenLearned(itemId)) then
            return false
        end

        ---@type boolean 需要对比装备红点
        local needToCompareRedDots = synthesisTable ~= nil and synthesisTable:GetRedPointCompare() == 0

        ---如果是装备/灵兽需要进行比较
        if ((itemTable:GetType() == luaEnumItemType.Equip and needToCompareRedDots) or (itemTable:GetType() == luaEnumItemType.Assist and itemTable:GetSubType() == 8)) then
            local bagItemInfo = CS.Cfg_ItemsFakeTipsTableManager.Instance:GetFakeBagItemInfoByItemId(itemId);
            if (bagItemInfo ~= nil) then
                local arrowType = Utility.GetArrowType(bagItemInfo, false);
                if (arrowType ~= LuaEnumArrowType.GreenArrow) then
                    return false;
                end
            end
        end
    end

    return self:IsCanSynthesis()
end

---是否满足货币花费
---@return boolean
function LuaSynthesis_Item:CoinCostIsEnough()
    if type(self.CostCoins) ~= 'table' then
        return true
    end
    for k, v in pairs(self.CostCoins) do
        local itemId = k
        local costNum = v
        local bagCoinNum = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(itemId)
        if bagCoinNum < costNum then
            return false
        end
    end
    return true
end

---获取此个物品合成的异常码0:可正常合成, 1:此物品不能合成, 2:需求数量不足,3:可以正常合成,但是所有的材料均是身上材料(2个戒指都是身上的)
---@return ELuaSynthesisStateCode
function LuaSynthesis_Item:GetSynthesisStateCode()
    if (self:IsCanSynthesis() == false) then
        return ELuaSynthesisStateCode.MaterialNotEnough
    end
    for i = 1, #self.Materials do
        local itemId = self.Materials[i]

        ---@type LuaMaterialData
        local materialData = LuaSynthesis_Item.NeedMaterialDataList[itemId]
        ---任一一个材料但需要的数量>1  并且背包中没有材料数量,并且满足条件,那么这个东西就是全在身上
        if (materialData:GetMaterialCount(LuaItemSavePos.Bag) == 0 and self.NeedMaterialCountList[i] ~= 1) then
            return ELuaSynthesisStateCode.TipSynthesis
        end
    end

    return ELuaSynthesisStateCode.NormalCanSynthesis
end

---这里开始判定是否能合成了(不过不需要判定货币)
function LuaSynthesis_Item:IsCanSynthesis()
    for i = 1, #self.Materials do
        local itemId = self.Materials[i]

        ---@type LuaMaterialData
        local materialData = LuaSynthesis_Item.NeedMaterialDataList[itemId]
        if (materialData == nil) then
            return false
        end

        local need = self.NeedMaterialCountList[i]

        if need ~= nil then

            if (gameMgr:GetPlayerDataMgr():GetSynthesisMgr():IsMagicWeapon(itemId, self.synthesisTable)) then
                if (materialData:GetAllMaterialCount(true, LuaItemSavePos.Bag) < need) then
                    return false;
                end
            else
                local IsTheAllMaterialNotEnough = materialData:GetAllMaterialCount(true, LuaItemSavePos.RoleEquip) < need
                        and materialData:GetAllMaterialCount(true, LuaItemSavePos.RoleXJ, false) < need
                        and materialData:GetAllMaterialCount(true, LuaItemSavePos.Elements, false) < need
                        and materialData:GetAllMaterialCount(true, LuaItemSavePos.Imprint, false) < need
                --and materialData:GetAllMaterialCount(true, LuaItemSavePos.MagicWeapon, false) < need

                IsTheAllMaterialNotEnough = uiStaticParameter.OpenEudemonsDetection and (
                        IsTheAllMaterialNotEnough
                                and materialData:GetAllMaterialCount(true, LuaItemSavePos.RoleServant, false) < need
                                and materialData:GetAllMaterialCount(true, LuaItemSavePos.ServantEquip_HM, false) < need
                                and materialData:GetAllMaterialCount(true, LuaItemSavePos.ServantEquip_LX, false) < need
                                and materialData:GetAllMaterialCount(true, LuaItemSavePos.ServantEquip_TC, false) < need
                ) or IsTheAllMaterialNotEnough

                if (IsTheAllMaterialNotEnough) then
                    return false
                end
            end
        end
    end

    return true
end

---@return number 最大合成数量
function LuaSynthesis_Item:GetMaxSynthesisCount()
    local MaxCount = 999999
    for i, itemId in pairs(self.Materials) do
        ---@type LuaMaterialData
        local materialData = LuaSynthesis_Item.NeedMaterialDataList[itemId]

        if (materialData ~= nil) then
            local isresolve = self.synthesisTable.synthesisType == 2
            local count = math.floor(materialData:GetAllMaterialCount(nil, nil, nil, isresolve) / self.NeedMaterialCountList[i])
            if (count < MaxCount) then
                MaxCount = count
            end
        end
    end
    if (MaxCount == 999999) then
        MaxCount = 0
    end
    return MaxCount
end

--endregion

---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
function LuaSynthesis_Item:IsInfluenceSynthesis(itemList, targetId)
    if (itemList ~= nil) then
        for i, itemId in pairs(self.Materials) do
            ---@type LuaMaterialData
            local materialData = LuaSynthesis_Item.NeedMaterialDataList[itemId]
            ---@param bagItemInfo bagV2.BagItemInfo
            for j, bagItemInfo in pairs(itemList) do
                if (materialData ~= nil and materialData:IsExitMaterial(bagItemInfo.itemId)) then

                    ---如果道具变动了,那么需要重新取查询道具数量的,所以这里重置掉
                    ---但是目前还有点问题,如果多个配方存在重复的材料,那么这个材料就重复的取获取了
                    materialData:Reset()
                    return true
                end
            end
        end

        local itemTable = nil
        ---@param bagItemInfo bagV2.BagItemInfo
        for i, bagItemInfo in pairs(itemList) do
            if (Utility.HasTableValue(self.Outputgoods, bagItemInfo.itemId)) then
                ---@type TABLE.cfg_items
                itemTable = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId);
                ---这个是为了减少性能消耗，目前只规定了外观
                if (itemTable:GetType() == luaEnumItemType.Appearance) then
                    return true
                end
            end
        end
    end

    if (targetId ~= nil) then
        for i, outItemId in pairs(self.Outputgoods) do
            if (outItemId == targetId) then
                return true
            end
        end

        for i, itemId in pairs(self.Materials) do
            ---@type LuaMaterialData
            local MaterialData = LuaSynthesis_Item.NeedMaterialDataList[itemId]
            if (MaterialData:IsExitMaterial(targetId)) then
                MaterialData:Reset()
                return true
            end
        end
    end

    return false
end

return LuaSynthesis_Item