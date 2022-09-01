---@class LuaSynthesis_MainCategory 合成的主要大类 即装备/灵兽/技能....
local LuaSynthesis_MainCategory = {}

---@type table<LuaSynthesis_SubCategory>
LuaSynthesis_MainCategory.LuaSynthesis_SubCategoryList = nil

---大类类型
LuaSynthesis_MainCategory.Type = 0
---大类名字
LuaSynthesis_MainCategory.Name = nil

---当前的红点状态
LuaSynthesis_MainCategory.RedState = false
---当前的红点key
LuaSynthesis_MainCategory.RedKey = 0


---合成的分类类页签列表 (就算一个大类里面有100个分类,但是大部分分类只是能合成,不能显示在界面列表中)
---@type table<LuaSynthesis_MainCategory>
LuaSynthesis_MainCategory.SubCategoryPageList = nil

function LuaSynthesis_MainCategory:Init()
    self.LuaSynthesis_SubCategoryList = {}
end

---初始化
---@param type 合成的大类类型
function LuaSynthesis_MainCategory:InitType(type)
    self.Type = type
    --注册红点
    self:RegisterRed()
end


---@param synthesisTable TABLE.cfg_synthesis(lua中的合成表)
function LuaSynthesis_MainCategory:AddItem(synthesisTable)

    ---@type LuaSynthesis_SubCategory
    local SubCategory = self.LuaSynthesis_SubCategoryList[synthesisTable.tabSubType]

    if (SubCategory == nil) then
        SubCategory = luaclass.LuaSynthesis_SubCategory:New();
        self.LuaSynthesis_SubCategoryList[synthesisTable.tabSubType] = SubCategory
        SubCategory:InitData(self.Type, synthesisTable.tabSubType)
    end

    SubCategory:AddItem(synthesisTable)
end

---得到当前大类下面下属的分类
---@return LuaSynthesis_SubCategory
function LuaSynthesis_MainCategory:GetSubCategory(subType)
    return self.LuaSynthesis_SubCategoryList[subType]
end

--region UI页签

---@param str table<string> 合成内子类型类型页签名字 页签主类型#页签子类型#子类型名称显示#显示condition1#显示condition2（多个）
function LuaSynthesis_MainCategory:AddSubCategoryPageButton(nameAndTypeAndCondition)

    if(self.SubCategoryPageList == nil) then
        LuaSynthesis_MainCategory.SubCategoryPageList = {}
    end

    local secondType = tonumber(nameAndTypeAndCondition[2]);

    ---@type LuaSynthesis_SubCategory
    local subCategory = self:GetSubCategory(secondType);
    if(subCategory ~= nil) then
        subCategory.Name = nameAndTypeAndCondition[3];

        local conditions = nil;
        if (#nameAndTypeAndCondition > 3) then
            conditions = {};
            for i = 4, #nameAndTypeAndCondition do
                table.insert(conditions, tonumber(nameAndTypeAndCondition[i]));
            end
        end
        subCategory:InitInUIListCondition(conditions)

        table.insert(self.SubCategoryPageList, subCategory)
    end
end

---@type table<LuaSynthesis_SubCategory>
LuaSynthesis_MainCategory.SynthesisSubCategoryPageButton = ""

---计算当前大类下面下属的分类页签
---@param itemList table<bagV2.BagItemInfo> lua table类型消息数据
---@param itemId number 道具表的ItemId
function LuaSynthesis_MainCategory:CalculateSynthesisSubCategoryPageButton(itemList, itemId)
    self.SynthesisSubCategoryPageButton = {}
    for i, v in pairs(self.LuaSynthesis_SubCategoryList) do
        ---@type LuaSynthesis_SubCategory
        local subCategory = v;
        subCategory:CalculateSynthesisPageButton(itemList, itemId)
        ---下属的页签个数>0
        if(Utility.GetTableCount(subCategory:GetSynthesisPageButtonItemList()) > 0) then
            table.insert(self.SynthesisSubCategoryPageButton, subCategory)
        end
    end
end



---得到当前大类下面下属的分类页签
---@return table<LuaSynthesis_SubCategory>
function LuaSynthesis_MainCategory:GetSynthesisSubCategoryPageButton()
    return self.SynthesisSubCategoryPageButton
end

--endregion

--region 红点相关

---注册红点
function LuaSynthesis_MainCategory:RegisterRed()
    self.RedKey  = self:GetFistPagButtonRedPointKey(self.Type);
    local mCallResultFunction = function()
        return self:IsShowRed();
    end
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.RedKey );
    gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self.RedKey , mCallResultFunction);
end


function LuaSynthesis_MainCategory:GetFistPagButtonRedPointKey(firstType)
    local redPointName = gameMgr:GetLuaRedPointManager():GetSynthesisListFirstPageButtonRedPointName(firstType);
    local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
    return redKey;
end
--endregion


---重新计算所有红点合成数据
---注意了,这个是为了减少性能消耗,只有在调用这个对应以及下属对应的方法的时候,才会去计算红点的显隐条件,其他的使用IsShowRed方法只是简单的返回一个true/false
---@param tblData bagV2.ResBagChange lua table类型消息数据
---@param itemId number 道具表的ItemId相关变动变动
function LuaSynthesis_MainCategory:CalculateAllSynthesisData(tblData, itemId)
    local lastRedState = self.RedState
    self.RedState = false
    for i, v in pairs(self.LuaSynthesis_SubCategoryList) do
        ---@type LuaSynthesis_SubCategory
        local SubCategory = v

        SubCategory:CalculateAllSynthesisData(tblData, itemId)

        if(SubCategory:IsShowRed()) then
            self.RedState = true
        end
    end

    ---只有2次红点状态不一样的时候,才需要重新call
    if(lastRedState ~= self.RedState) then
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():CallRedPoint(self.RedKey);
    end
end

---是否显示红点
function LuaSynthesis_MainCategory:IsShowRed()
    return self.RedState
end

return LuaSynthesis_MainCategory