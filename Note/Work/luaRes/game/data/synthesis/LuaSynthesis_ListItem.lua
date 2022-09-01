---@class LuaSynthesis_ListItem
local LuaSynthesis_ListItem = {};

LuaSynthesis_ListItem.mItemTable = nil;

---@type table<LuaSynthesis_Item>
LuaSynthesis_ListItem.mItems = nil;

---@type number
LuaSynthesis_ListItem.mFirstSynthesisId = nil;

---@type table<TABLE.cfg_synthesis>
LuaSynthesis_ListItem.mSynthesisTables = nil;

LuaSynthesis_ListItem.RedKey = nil;

---@type number
LuaSynthesis_ListItem.SubType = nil;

---@type number
LuaSynthesis_ListItem.Type = nil;

---@public
---@param subCategory LuaSynthesis_SubCategory
function LuaSynthesis_ListItem:InitListItem(subCategory, itemTable, synthesisTables, oneSynthesisID)
    self.mItemTable = itemTable;
    self.mItems = {};
    self.mFirstSynthesisId = oneSynthesisID;
    self:RegisterRed();
    if (synthesisTables ~= nil) then
        for k, v in pairs(synthesisTables) do
            ---@type TABLE.cfg_synthesis
            local synthesisTable = v;
            ---@type LuaSynthesis_Item
            local item = subCategory:GetSynthesis(synthesisTable:GetId());
            item:SetParentRedKey(self.RedKey);
            table.insert(self.mItems, item);
            if (self.SubType == nil) then
                self.SubType = item:GetTabSubType();
            end
            if (self.Type == nil) then
                self.Type = item:GetTabType();
            end
        end
    end
end

---@public
function LuaSynthesis_ListItem:GetItemTable()
    return self.mItemTable;
end

---@public
function LuaSynthesis_ListItem:GetFirstSynthesisId()
    if (self.mFirstSynthesisId == nil) then
        return 0;
    end
    return self.mFirstSynthesisId;
end

---@public
---@return table<LuaSynthesis_Item>
function LuaSynthesis_ListItem:GetItems()
    return self.mItems;
end

---@public
---@return table<TABLE.cfg_synthesis>
function LuaSynthesis_ListItem:GetSynthesisTables()
    self.mSynthesisTables = {};
    local items = self:GetItems()
    ---@type table<TABLE.cfg_synthesis>;
    if (items ~= nil) then
        for k, v in pairs(items) do
            ---@type LuaSynthesis_Item
            local item = v;
            table.insert(self.mSynthesisTables, item.synthesisTable);
        end
    end
    return self.mSynthesisTables;
end

function LuaSynthesis_ListItem:GetFirstSynthesisTable()
    local synthesisTables = self:GetSynthesisTables();
    if (#synthesisTables > 0) then
        return synthesisTables[1];
    end
    return nil;
end

--region 红点相关

---注册红点
function LuaSynthesis_ListItem:RegisterRed()
    self.RedKey = self:GetButtonRedPointKey(self.mItemTable.id);
    if (self.RedKey ~= nil) then
        --定义红点刷新的时候检测方法
        local callBack = function()
            if (self.mItems ~= nil) then
                for k, v in pairs(self.mItems) do
                    ---@type LuaSynthesis_Item
                    local temp = v;
                    if (temp:IsShowSynthesisRedPoint()) then
                        return true;
                    end
                end
            end
            return false;
        end
        --注册红点
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RemoveLuaCallRedPointFunctionByInt(self.RedKey);
        gameMgr:GetLuaRedPointManager():GetCSUIRedPointManager():RegisterLuaCallRedPointFunction(self.RedKey, callBack);
    end
end

function LuaSynthesis_ListItem:GetButtonRedPointKey(itemId)
    if (itemId ~= nil) then
        local redPointName = gameMgr:GetLuaRedPointManager():GetSynthesisListRedPointName(itemId);
        if (redPointName ~= nil) then
            local redKey = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(redPointName);
            return redKey;
        end
    end
    return nil;
end

--endregion


return LuaSynthesis_ListItem;