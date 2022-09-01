--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_cuilian
local cfg_cuilian = {}

cfg_cuilian.__index = cfg_cuilian

function cfg_cuilian:UUID()
    return self.id
end

---@return number 淬炼ID#客户端#不存在共同参与合并的字段  不能变动淬炼物品排序按等级排序，等级相同按id排序
function cfg_cuilian:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return number 装备ID#客户端  参与淬炼主要物品ID 格式：物品id#数量
function cfg_cuilian:GetItemid()
    if self.itemid ~= nil then
        return self.itemid
    else
        if self:CsTABLE() ~= nil then
            self.itemid = self:CsTABLE().itemid
            return self.itemid
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具id#客户端  参与淬炼的消耗物品id 格式：物品id#物品id
function cfg_cuilian:GetItemid2()
    if self.itemid2 ~= nil then
        return self.itemid2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemid2
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具id#客户端  可替代的物品id 格式：物品id#物品id
function cfg_cuilian:GetReplaceItemid()
    if self.replaceItemid ~= nil then
        return self.replaceItemid
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().replaceItemid
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 合成数量#客户端  合成物品所需数量
function cfg_cuilian:GetNumber()
    if self.number ~= nil then
        return self.number
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().number
        else
            return nil
        end
    end
end

---@return string 道具名称#客户端  参与淬炼物品名称
function cfg_cuilian:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 淬炼物品ID#客户端  目标装备 需要淬炼成的装备id
function cfg_cuilian:GetOutputgoods()
    if self.outputgoods ~= nil then
        return self.outputgoods
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().outputgoods
        else
            return nil
        end
    end
end

---@return string 被淬炼数量#客户端
function cfg_cuilian:GetOutputquantity()
    if self.outputquantity ~= nil then
        return self.outputquantity
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().outputquantity
        else
            return nil
        end
    end
end

---@return number 淬炼物品名称#客户端
function cfg_cuilian:GetSyntheticgoods()
    if self.syntheticgoods ~= nil then
        return self.syntheticgoods
    else
        if self:CsTABLE() ~= nil then
            self.syntheticgoods = self:CsTABLE().syntheticgoods
            return self.syntheticgoods
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 货币消耗#客户端  淬炼消耗货币  货币ID#数量
function cfg_cuilian:GetCurrency()
    if self.currency ~= nil then
        return self.currency
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().currency
        else
            return nil
        end
    end
end

---@return number 淬炼逻辑类型#客户端  1为随机淬炼 0为固定淬炼 不填默认为0
function cfg_cuilian:GetSynthesisType()
    if self.synthesisType ~= nil then
        return self.synthesisType
    else
        if self:CsTABLE() ~= nil then
            self.synthesisType = self:CsTABLE().synthesisType
            return self.synthesisType
        else
            return nil
        end
    end
end

---@return number 页签类型#客户端  页签类型1武器 2衣服 3头盔 4项链 5手镯 6戒指 7腰带 8鞋子
function cfg_cuilian:GetTabType()
    if self.tabType ~= nil then
        return self.tabType
    else
        if self:CsTABLE() ~= nil then
            self.tabType = self:CsTABLE().tabType
            return self.tabType
        else
            return nil
        end
    end
end

---@return number 是否于身上装备进行比较#客户端  是否于身上装备进行比较 1 是 2 否
function cfg_cuilian:GetCompare()
    if self.compare ~= nil then
        return self.compare
    else
        if self:CsTABLE() ~= nil then
            self.compare = self:CsTABLE().compare
            return self.compare
        else
            return nil
        end
    end
end

---@return number 是否需要显示身上穿戴的装备#客户端  检测存在哪个位置上 1主材料是否人物装备着 2主材料是否为身上灵兽3主材料是否为灵兽身上装备 4检测人物和灵兽装备  检测存在哪个位置上,如果存在,强制显示
function cfg_cuilian:GetCompel()
    if self.compel ~= nil then
        return self.compel
    else
        if self:CsTABLE() ~= nil then
            self.compel = self:CsTABLE().compel
            return self.compel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 检测身上物品id#客户端  检测身上物品id和装备位   格式  装备ID#装备位（武器 1 头盔2  衣服 3 项链4 左手5 右手51 左戒6  右戒61 腰带7 鞋子8 灯13 魂玉15
function cfg_cuilian:GetEquipItem()
    if self.equipItem ~= nil then
        return self.equipItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equipItem
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 检车背包物品id#客户端  背包中检测ID  如果需要检测类型5(是否有淬炼的主材料) 如果有这个ID 返回条件true
function cfg_cuilian:GetBagItem()
    if self.bagItem ~= nil then
        return self.bagItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bagItem
        else
            return nil
        end
    end
end

---@return string 列表名字内容显示#客户端  列表名字内容显示，如果填了此列则显示此名字，未填则显示道具名字
function cfg_cuilian:GetReplaceName()
    if self.replaceName ~= nil then
        return self.replaceName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().replaceName
        else
            return nil
        end
    end
end

---@return number 开服天数#客户端  开服天数显示判断
function cfg_cuilian:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return number 是否需要红点#客户端  是否需要红点，1需要0不需要默认不需要, 偏职业 淬炼之后可使用 材料足够显示红点
function cfg_cuilian:GetRedPoint()
    if self.redPoint ~= nil then
        return self.redPoint
    else
        if self:CsTABLE() ~= nil then
            self.redPoint = self:CsTABLE().redPoint
            return self.redPoint
        else
            return nil
        end
    end
end

---@return number 红点是否需要对比身上的装备#客户端  0需要1不需要
function cfg_cuilian:GetRedPointCompare()
    if self.redPointCompare ~= nil then
        return self.redPointCompare
    else
        if self:CsTABLE() ~= nil then
            self.redPointCompare = self:CsTABLE().redPointCompare
            return self.redPointCompare
        else
            return nil
        end
    end
end

---@return string 淬炼提示文本#客户端  必定成功提示文本
function cfg_cuilian:GetDesc()
    if self.desc ~= nil then
        return self.desc
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().desc
        else
            return nil
        end
    end
end

---@return number 排序#客户端  根据页签内排序显示
function cfg_cuilian:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_CUILIAN C#中的数据结构
function cfg_cuilian:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_cuilian lua中的数据结构
function cfg_cuilian:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.itemid = decodedData.itemid
    
    ---@private
    self.itemid2 = decodedData.itemid2
    
    ---@private
    self.replaceItemid = decodedData.replaceItemid
    
    ---@private
    self.number = decodedData.number
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.outputgoods = decodedData.outputgoods
    
    ---@private
    self.outputquantity = decodedData.outputquantity
    
    ---@private
    self.syntheticgoods = decodedData.syntheticgoods
    
    ---@private
    self.currency = decodedData.currency
    
    ---@private
    self.synthesisType = decodedData.synthesisType
    
    ---@private
    self.tabType = decodedData.tabType
    
    ---@private
    self.compare = decodedData.compare
    
    ---@private
    self.compel = decodedData.compel
    
    ---@private
    self.equipItem = decodedData.equipItem
    
    ---@private
    self.bagItem = decodedData.bagItem
    
    ---@private
    self.replaceName = decodedData.replaceName
    
    ---@private
    self.condition = decodedData.condition
    
    ---@private
    self.redPoint = decodedData.redPoint
    
    ---@private
    self.redPointCompare = decodedData.redPointCompare
    
    ---@private
    self.desc = decodedData.desc
    
    ---@private
    self.order = decodedData.order
end

return cfg_cuilian