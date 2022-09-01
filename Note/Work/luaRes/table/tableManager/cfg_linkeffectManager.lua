---@class cfg_linkeffectManager:TableManager
local cfg_linkeffectManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_linkeffect
function cfg_linkeffectManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_linkeffect> 遍历方法
function cfg_linkeffectManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_linkeffectManager:PostProcess()
    self:InitCollectionIDToLinkEffectList()
end

---@private
function cfg_linkeffectManager:InitCollectionIDToLinkEffectList()
    ---@type table<number, table<number,TABLE.cfg_linkeffect>>
    self.mCollectionIDToLinkEffectListDic = {}
    ---@type table<number, table<number, TABLE.cfg_linkeffect>>
    self.mLinkEffectSubTypeToLinkEffectListDic = {}
    for i, v in pairs(self.dic) do
        ---@type TABLE.cfg_linkeffect
        local tbl = v
        if tbl:GetLinkItem() ~= nil and tbl:GetLinkItem().list ~= nil then
            for j = 1, #tbl:GetLinkItem().list do
                local itemIDTemp = tbl:GetLinkItem().list[j]
                ---记录 itemID => List<TABLE.cfg_linkeffect>
                local list = self.mCollectionIDToLinkEffectListDic[itemIDTemp]
                if list == nil then
                    list = {}
                    self.mCollectionIDToLinkEffectListDic[itemIDTemp] = list
                end
                table.insert(list, tbl)
                ---记录 linkEffectSubType => List<TABLE.cfg_linkeffect>
                local list2 = self.mLinkEffectSubTypeToLinkEffectListDic[tbl:GetSubType()]
                if list2 == nil then
                    list2 = {}
                    self.mLinkEffectSubTypeToLinkEffectListDic[tbl:GetSubType()] = list2
                end
                table.insert(list2, tbl)
            end
        end
    end
end

---获取藏品对应的连锁属性列表
---@public
---@param collectionItemID number
---@return table<number, TABLE.cfg_linkeffect>|nil
function cfg_linkeffectManager:GetLinkEffectListByCollectionID(collectionItemID)
    if self.mCollectionIDToLinkEffectListDic == nil then
        return nil
    end
    return self.mCollectionIDToLinkEffectListDic[collectionItemID]
end

---获取连锁属性类型对应的连锁属性列表
---@public
---@param linkEffectSubType number
---@return table<number, TABLE.cfg_linkeffect>|nil
function cfg_linkeffectManager:GetLinkEffectListByLinkEffectSubType(linkEffectSubType)
    if self.mLinkEffectSubTypeToLinkEffectListDic == nil then
        return nil
    end
    return self.mLinkEffectSubTypeToLinkEffectListDic[linkEffectSubType]
end

return cfg_linkeffectManager