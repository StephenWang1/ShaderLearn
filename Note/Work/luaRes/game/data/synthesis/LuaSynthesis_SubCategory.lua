---@class LuaSynthesis_SubCategory 合成大类下的分类 即装备>>>>武器/衣服....
local LuaSynthesis_SubCategory = {}

---@type table<number,LuaSynthesis_Item>
LuaSynthesis_SubCategory.LuaSynthesis_ItemList = nil
---所属合成大类
LuaSynthesis_SubCategory.Type = 0;
---当前所在合成分类
LuaSynthesis_SubCategory.SubType = 0;
---当前的红点状态
LuaSynthesis_SubCategory.RedState = false
---当前的红点key
LuaSynthesis_SubCategory.RedKey = 0

---是否为存在页签按钮的名字
LuaSynthesis_SubCategory.Name = ""

---UI列表上面页签的显示条件
---@type table<number> condition表里面的id列表
LuaSynthesis_SubCategory.UIPageShowCondition = nil

LuaSynthesis_SubCategory.ItemIdToSynthesisTablesCache = nil

---@type table<number,LuaSynthesis_Item> 当前显示的合成页签
LuaSynthesis_SubCategory.SynthesisPageButtonItemList = nil

function LuaSynthesis_SubCategory:Init()
    self.LuaSynthesis_ItemList = {}
end
---初始化
---@param type 合成的大类类型
function LuaSynthesis_SubCategory:InitData(type, subType)
    self.Type = type
    self.SubType = subType
    self:RegisterRed()
end

---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_SubCategory:AddItem(synthesisTable)
    -----@type LuaSynthesis_Item
    local Item = self.LuaSynthesis_ItemList[synthesisTable:GetId()]

    if (Item == nil) then
        Item = luaclass.LuaSynthesis_Item:New();
        self.LuaSynthesis_ItemList[synthesisTable:GetId()] = Item

        clientTableManager.cfg_synthesisManager.AllSynthesisDic[synthesisTable:GetId()] = Item
    end
    Item:InitSynthesisTable(synthesisTable)
end

---得到合成数据
---@return number LuaSynthesis_Item
function LuaSynthesis_SubCategory:GetSynthesis(id)
    return self.LuaSynthesis_ItemList[id]
end

---初始化
---@param condition table<number> condition表里面的id列表
function LuaSynthesis_SubCategory:InitInUIListCondition(condition)
    self.UIPageShowCondition = condition
end

---计算当前大类下面下属的分类页签
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
function LuaSynthesis_SubCategory:CalculateSynthesisPageButton(itemList, itemId)
    ---@type table<LuaSynthesis_Item>
    self.SynthesisPageButtonItemList = {}
    ---首先判定是否满足页签的显示条件
    if (self.UIPageShowCondition ~= nil) then
        for k, v in pairs(self.UIPageShowCondition) do
            if (Utility.IsMainPlayerMatchCondition(v).success == false) then
                return
            end
        end
    end
    ---@type table<number, LuaSynthesis_Item>
    local tempList = {};
    ---在满足页签条件的情况下,逐个判定是下属的个体是否能合成
    for i, v in pairs(self.LuaSynthesis_ItemList) do
        ---@type LuaSynthesis_Item
        local item = v;
        --table.insert(self.SynthesisPageButtonItemList, item)
        item:CalculateSynthesisPageButton(itemList, itemId)
        if (item:GetIsShowInSynthesisList()) then
            table.insert(tempList, item)
        end
    end

    local itemIdToSynthesisTables = {};
    ---@type table<number, LuaSynthesis_Item>
    local synthesisTables = tempList;
    if (synthesisTables ~= nil) then
        ---整理合成列表中需要检查优先级的项,这些需要检查优先级的选项的每个类型中只留下最大优先级的那些
        ---获取各类型中的最大优先级
        local maxPriorities = {}
        for i = 1, #synthesisTables do
            local tbl = synthesisTables[i].synthesisTable
            if tbl.mIsNeedCheckShowPriority then
                local showPriority = tbl:GetShowPriority()
                if #showPriority.list > 1 then
                    local type = showPriority.list[1]
                    local priorityTemp = showPriority.list[2]
                    if maxPriorities[type] == nil or maxPriorities[type] < priorityTemp then
                        --记录各类型中优先级的最大值
                        maxPriorities[type] = priorityTemp
                    end
                end
            end
        end
        ---需要检查优先级的选项中,小于最大优先级的都要被忽略,并将被忽略的设置为不显示状态
        if Utility.GetTableCount(maxPriorities) > 0 then
            for i = #synthesisTables, 1, -1 do
                local tbl = synthesisTables[i].synthesisTable
                if tbl.mIsNeedCheckShowPriority then
                    local showPriority = tbl:GetShowPriority()
                    if #showPriority.list > 1 then
                        local type = showPriority.list[1]
                        local priorityTemp = showPriority.list[2]
                        if maxPriorities[type] ~= nil and maxPriorities[type] > priorityTemp then
                            --去掉该类型中优先级低于该类型中优先级的最大值的选项
                            --if self.Type == 60 and self.SubType == 1 then
                            --    print(self.Type, self.SubType, "remove", tbl:GetId(), type, priorityTemp)
                            --end
                            synthesisTables[i]:SetHideInSynthesisList()
                            table.remove(synthesisTables, i)
                        end
                    end
                end
            end
        end

        for k, v in pairs(synthesisTables) do
            local tbl = v.synthesisTable
            if (tbl:GetOutputgoods() ~= nil and tbl:GetOutputgoods().list ~= nil) then
                for i, itemId in pairs(tbl:GetOutputgoods().list) do
                    if (itemIdToSynthesisTables[itemId] == nil) then
                        itemIdToSynthesisTables[itemId] = {};
                    end
                    table.insert(itemIdToSynthesisTables[itemId], tbl);
                end
            end
        end

        if (self.ItemIdToSynthesisTablesCache == nil) then
            self.ItemIdToSynthesisTablesCache = {}
        end

        for k, v in pairs(itemIdToSynthesisTables) do
            local isFind, itemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(k);
            if (isFind) then
                local oneSynthesisID = 0
                if #v > 0 then
                    oneSynthesisID = v[1]:GetId()
                end
                ---@type LuaSynthesis_ListItem
                local listItem = self.ItemIdToSynthesisTablesCache[k]

                if (listItem == nil) then
                    self.ItemIdToSynthesisTablesCache[k] = luaclass.LuaSynthesis_ListItem:New();
                    listItem = self.ItemIdToSynthesisTablesCache[k]
                    listItem:InitListItem(self, itemTable, v, oneSynthesisID);
                else
                    listItem:InitListItem(self, itemTable, v, oneSynthesisID);
                end
                table.insert(self.SynthesisPageButtonItemList, listItem);
            end
        end

        table.sort(self.SynthesisPageButtonItemList, function(a, b)
            ---按照item转生等级，item等级，第一个synthesis的id来从小到大排序
            local aItemTable = a:GetItemTable();
            local bItemTable = b:GetItemTable();
            if (aItemTable == nil or bItemTable == nil) then
                return false;
            end
            if (aItemTable.reinLv ~= bItemTable.reinLv) then
                return bItemTable.reinLv > aItemTable.reinLv;
            else
                if (aItemTable.useLv ~= bItemTable.useLv) then
                    return bItemTable.useLv > aItemTable.useLv;
                end
                return b:GetFirstSynthesisId() > a:GetFirstSynthesisId();
            end
        end);
    end
end

function LuaSynthesis_SubCategory:SortSubCategory()

end

---得到当前大类下面下属的分类页签
---@return table<LuaSynthesis_Item>
function LuaSynthesis_SubCategory:GetSynthesisPageButtonItemList()
    return self.SynthesisPageButtonItemList
end

--region 红点相关

---注册红点
function LuaSynthesis_SubCategory:RegisterRed()
    self.RedKey = self:GetSecondPageButtonRedPointKey(self.Type, self.SubType);
    local mCallResultFunction = function()
        return self:IsShowRed();
    end
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.RedKey);
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self.RedKey, mCallResultFunction);
end

---得到当前注册的红点key
function LuaSynthesis_SubCategory:GetSecondPageButtonRedPointKey(firstType, secondType)
    local redPointName = gameMgr:GetLuaRedPointManager():GetSynthesisListSecondPageButtonRedPointName(firstType, secondType);
    local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
    return redKey;
end
--endregion


---重新计算所有红点合成数据
---注意了,这个是为了减少性能消耗,只有在调用这个对应以及下属对应的方法的时候,才会去计算红点的显隐条件,其他的使用IsShowRed方法只是简单的返回一个true/false
---@param tblData bagV2.ResBagChange lua table类型消息数据
---@param itemId number 道具表的ItemId相关变动变动
function LuaSynthesis_SubCategory:CalculateAllSynthesisData(tblData, itemId)
    local lastRedState = self.RedState
    self.RedState = false
    for i, v in pairs(self.LuaSynthesis_ItemList) do
        ---@type LuaSynthesis_Item
        local Item = v

        Item:CalculateSynthesisData(tblData, itemId)

        if (Item:IsShowSynthesisRedPoint()) then
            self.RedState = true
        end
    end
    -----只有2次红点状态不一样的时候,才需要重新call
    if (lastRedState ~= self.RedState) then
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():CallRedPoint(self.RedKey);
    end
end

---是否显示红点
function LuaSynthesis_SubCategory:IsShowRed()
    return self.RedState
    --for i, v in pairs(self.LuaSynthesis_ItemList) do
    --    ---@type LuaSynthesis_Item
    --    local Item = v
    --
    --    if(Item:IsShowRed()) then
    --        return true
    --    end
    --end
    --return false
end

return LuaSynthesis_SubCategory