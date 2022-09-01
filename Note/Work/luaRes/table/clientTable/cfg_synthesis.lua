--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_synthesis
local cfg_synthesis = {}

cfg_synthesis.__index = cfg_synthesis

function cfg_synthesis:UUID()
    return self.id
end

---@return number 合成ID#客户端#不存在共同参与合并的字段  合成物品排序按等级排序，等级相同按id排序
function cfg_synthesis:GetId()
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

---@return TABLE.IntListJingHao 物品ID#客户端  参与合成主要物品ID
function cfg_synthesis:GetItemid()
    if self.itemid ~= nil then
        return self.itemid
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemid
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 道具id#客户端  可替代的物品id
function cfg_synthesis:GetReplaceItemid()
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

---@return number 道具类型#客户端  1.灵兽碎片2 婚戒 3花朵 4.门票5.转生凭证 6.装备 7.魂继8技能书9印记10元素
function cfg_synthesis:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end

---@return string 道具名称#客户端  参与合成物品名称
function cfg_synthesis:GetName()
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

---@return number 物品ID#客户端#不存在共同参与合并的字段  参与合成辅助物品ID
function cfg_synthesis:GetAuxiliaryitemid()
    if self.auxiliaryitemid ~= nil then
        return self.auxiliaryitemid
    else
        if self:CsTABLE() ~= nil then
            self.auxiliaryitemid = self:CsTABLE().auxiliaryitemid
            return self.auxiliaryitemid
        else
            return nil
        end
    end
end

---@return string 辅助道具名称#客户端  参与合成物品名称
function cfg_synthesis:GetAuxiliaryname()
    if self.auxiliaryname ~= nil then
        return self.auxiliaryname
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().auxiliaryname
        else
            return nil
        end
    end
end

---@return string 辅助道具数量#客户端  合成消耗辅助道具
function cfg_synthesis:GetAuxiliarynumber()
    if self.auxiliarynumber ~= nil then
        return self.auxiliarynumber
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().auxiliarynumber
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 合成数量#客户端  合成物品所需数量
function cfg_synthesis:GetNumber()
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

---@return string 合成权重#客户端  合成物品产出权重  根据合成物品数量配置相应数量个权重
function cfg_synthesis:GetWeight()
    if self.weight ~= nil then
        return self.weight
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().weight
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 合成物品ID#客户端
function cfg_synthesis:GetOutputgoods()
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

---@return TABLE.IntListJingHao 合成物品ID#客户端  使用可替代的物品时，生成的物品取这个
function cfg_synthesis:GetOutputReplace()
    if self.outputReplace ~= nil then
        return self.outputReplace
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().outputReplace
        else
            return nil
        end
    end
end

---@return string 被合成数量#客户端
function cfg_synthesis:GetOutputquantity()
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

---@return string 合成物品名称#客户端
function cfg_synthesis:GetSyntheticgoods()
    if self.syntheticgoods ~= nil then
        return self.syntheticgoods
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().syntheticgoods
        else
            return nil
        end
    end
end

---@return string 合成几率#客户端  物品成功几率 百分比
function cfg_synthesis:GetProbability()
    if self.probability ~= nil then
        return self.probability
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().probability
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 货币消耗#客户端  合成消耗货币  货币ID#数量
function cfg_synthesis:GetCurrency()
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

---@return number 合成逻辑类型#客户端  1为随机合成 0为固定合成 不填默认为0 2分解
function cfg_synthesis:GetSynthesisType()
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

---@return number 页签主类型#客户端  页签主类型1#等级装备&10#转生装备&20灵兽&30#配饰&40#物品&50#技能 60人物法宝 70元素  在杂项表内配置对应22610
function cfg_synthesis:GetTabType()
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

---@return number 页签子类型#客户端  在杂项表内配置对应 22611
function cfg_synthesis:GetTabSubType()
    if self.tabSubType ~= nil then
        return self.tabSubType
    else
        if self:CsTABLE() ~= nil then
            self.tabSubType = self:CsTABLE().tabSubType
            return self.tabSubType
        else
            return nil
        end
    end
end

---@return number 显示类型关系#客户端  1表示多个显示类型为或的关系2表示多个显示类型为并的关系
function cfg_synthesis:GetConditionRelation()
    if self.conditionRelation ~= nil then
        return self.conditionRelation
    else
        if self:CsTABLE() ~= nil then
            self.conditionRelation = self:CsTABLE().conditionRelation
            return self.conditionRelation
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 显示类型#客户端  类型#参数 无参数则填0 类型1：检测玩家等级是否处于等级区间段，类型2：检测玩家转生等级是否处于区间段，类型3：任意一只灵兽等级处于该区间 类型4：任意一只灵兽转生等级处于该区间 5：是否有可合成的主材料6：是否检测开服天数7偏职业显示 类型8 玩家性别 1男2女0通用 类型9：检测是否开启第一位灵兽 类型10：检测是否开启第二位灵兽 类型11：检测是否开启第三位灵兽 类型12：是否检测优先级显示，优先级高的则不显示优先级低的13：合成物品之后不再继续显示
function cfg_synthesis:GetConditionType()
    if self.conditionType ~= nil then
        return self.conditionType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionType
        else
            return nil
        end
    end
end

---@return number 标记#客户端  是否有可合成的主材料 1是 0否
function cfg_synthesis:GetTab1()
    if self.tab1 ~= nil then
        return self.tab1
    else
        if self:CsTABLE() ~= nil then
            self.tab1 = self:CsTABLE().tab1
            return self.tab1
        else
            return nil
        end
    end
end

---@return number 人物最低等级#客户端  人物最低等级
function cfg_synthesis:GetRoleLevelMin()
    if self.roleLevelMin ~= nil then
        return self.roleLevelMin
    else
        if self:CsTABLE() ~= nil then
            self.roleLevelMin = self:CsTABLE().roleLevelMin
            return self.roleLevelMin
        else
            return nil
        end
    end
end

---@return number 人物最高等级#客户端  人物最高等级
function cfg_synthesis:GetRoleLevelMax()
    if self.roleLevelMax ~= nil then
        return self.roleLevelMax
    else
        if self:CsTABLE() ~= nil then
            self.roleLevelMax = self:CsTABLE().roleLevelMax
            return self.roleLevelMax
        else
            return nil
        end
    end
end

---@return number 人物最低转生#客户端  人物最低转生
function cfg_synthesis:GetRoleReinMin()
    if self.roleReinMin ~= nil then
        return self.roleReinMin
    else
        if self:CsTABLE() ~= nil then
            self.roleReinMin = self:CsTABLE().roleReinMin
            return self.roleReinMin
        else
            return nil
        end
    end
end

---@return number 人物最高转生#客户端  人物最高转生
function cfg_synthesis:GetRoleReinMax()
    if self.roleReinMax ~= nil then
        return self.roleReinMax
    else
        if self:CsTABLE() ~= nil then
            self.roleReinMax = self:CsTABLE().roleReinMax
            return self.roleReinMax
        else
            return nil
        end
    end
end

---@return number 灵兽最低等级#客户端  灵兽最低等级
function cfg_synthesis:GetServantLevelMin()
    if self.servantLevelMin ~= nil then
        return self.servantLevelMin
    else
        if self:CsTABLE() ~= nil then
            self.servantLevelMin = self:CsTABLE().servantLevelMin
            return self.servantLevelMin
        else
            return nil
        end
    end
end

---@return number 灵兽最高等级#客户端  灵兽最高等级
function cfg_synthesis:GetServantLevelMax()
    if self.servantLevelMax ~= nil then
        return self.servantLevelMax
    else
        if self:CsTABLE() ~= nil then
            self.servantLevelMax = self:CsTABLE().servantLevelMax
            return self.servantLevelMax
        else
            return nil
        end
    end
end

---@return number 灵兽最低转生#客户端  灵兽最低转生
function cfg_synthesis:GetServantReinMin()
    if self.servantReinMin ~= nil then
        return self.servantReinMin
    else
        if self:CsTABLE() ~= nil then
            self.servantReinMin = self:CsTABLE().servantReinMin
            return self.servantReinMin
        else
            return nil
        end
    end
end

---@return number 灵兽最高转生#客户端  灵兽最高转生端
function cfg_synthesis:GetServantReinMax()
    if self.servantReinMax ~= nil then
        return self.servantReinMax
    else
        if self:CsTABLE() ~= nil then
            self.servantReinMax = self:CsTABLE().servantReinMax
            return self.servantReinMax
        else
            return nil
        end
    end
end

---@return number 职业显示#客户端  职业显示
function cfg_synthesis:GetCareer()
    if self.career ~= nil then
        return self.career
    else
        if self:CsTABLE() ~= nil then
            self.career = self:CsTABLE().career
            return self.career
        else
            return nil
        end
    end
end

---@return number 性别显示#客户端  性别显示
function cfg_synthesis:GetSex()
    if self.sex ~= nil then
        return self.sex
    else
        if self:CsTABLE() ~= nil then
            self.sex = self:CsTABLE().sex
            return self.sex
        else
            return nil
        end
    end
end

---@return number 是否于身上装备进行比较#客户端  是否于身上装备进行比较 1 是 2 否
function cfg_synthesis:GetCompare()
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
function cfg_synthesis:GetCompel()
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

---@return TABLE.IntListJingHao 检测身上物品id#客户端  检测身上物品id，如果身上穿戴了这个ID的装备,强制显示该合成
function cfg_synthesis:GetEquipItem()
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

---@return TABLE.IntListJingHao 检车背包物品id#客户端  背包中检测ID  如果需要检测类型5(是否有合成的主材料) 如果有这个ID 返回条件true
function cfg_synthesis:GetBagItem()
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
function cfg_synthesis:GetReplaceName()
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

---@return TABLE.IntListJingHao 显示优先级#客户端  显示优先级 类型#优先级 前面数字代表同一页签下的类型，后面数字代表优先级，需要在conditionType内配置类型12，同页签下，同优先级可以共存，只显示最高优先级的物品
function cfg_synthesis:GetShowPriority()
    if self.showPriority ~= nil then
        return self.showPriority
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showPriority
        else
            return nil
        end
    end
end

---@return number 可选择数量#客户端  是否需要可选择合成数量，1需要 0不需要 默认0不需要
function cfg_synthesis:GetNumberChoose()
    if self.numberChoose ~= nil then
        return self.numberChoose
    else
        if self:CsTABLE() ~= nil then
            self.numberChoose = self:CsTABLE().numberChoose
            return self.numberChoose
        else
            return nil
        end
    end
end

---@return number 开服天数#客户端  开服天数显示判断
function cfg_synthesis:GetOpenDay()
    if self.openDay ~= nil then
        return self.openDay
    else
        if self:CsTABLE() ~= nil then
            self.openDay = self:CsTABLE().openDay
            return self.openDay
        else
            return nil
        end
    end
end

---@return number 是否需要红点#客户端  是否需要红点，1需要0不需要默认不需要, 偏职业 合成之后可使用 材料足够显示红点
function cfg_synthesis:GetRedPoint()
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

---@return TABLE.IntListJingHao 限制条件#客户端  合成限制条件，未满足不可合成
function cfg_synthesis:GetConditionId()
    if self.conditionId ~= nil then
        return self.conditionId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().conditionId
        else
            return nil
        end
    end
end

---@return number 是否合成之后不再显示#客户端  0显示1不再显示
function cfg_synthesis:GetShow()
    if self.show ~= nil then
        return self.show
    else
        if self:CsTABLE() ~= nil then
            self.show = self:CsTABLE().show
            return self.show
        else
            return nil
        end
    end
end

---@return number 红点是否需要对比身上的装备#客户端  0需要1不需要
function cfg_synthesis:GetRedPointCompare()
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

---@return number 合成次数限制#客户端  合成每日最多合成几次
function cfg_synthesis:GetNumberLimit()
    if self.numberLimit ~= nil then
        return self.numberLimit
    else
        if self:CsTABLE() ~= nil then
            self.numberLimit = self:CsTABLE().numberLimit
            return self.numberLimit
        else
            return nil
        end
    end
end

---@return number 是否需要检测身上的的装备#客户端  是否需要检测身上的的装备，1不检测0检测
function cfg_synthesis:GetEquipExamine()
    if self.equipExamine ~= nil then
        return self.equipExamine
    else
        if self:CsTABLE() ~= nil then
            self.equipExamine = self:CsTABLE().equipExamine
            return self.equipExamine
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SYNTHESIS C#中的数据结构
function cfg_synthesis:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_synthesis lua中的数据结构
function cfg_synthesis:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.itemid = decodedData.itemid
    
    ---@private
    self.replaceItemid = decodedData.replaceItemid
    
    ---@private
    self.type = decodedData.type
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.auxiliaryitemid = decodedData.auxiliaryitemid
    
    ---@private
    self.auxiliaryname = decodedData.auxiliaryname
    
    ---@private
    self.auxiliarynumber = decodedData.auxiliarynumber
    
    ---@private
    self.number = decodedData.number
    
    ---@private
    self.weight = decodedData.weight
    
    ---@private
    self.outputgoods = decodedData.outputgoods
    
    ---@private
    self.outputReplace = decodedData.outputReplace
    
    ---@private
    self.outputquantity = decodedData.outputquantity
    
    ---@private
    self.syntheticgoods = decodedData.syntheticgoods
    
    ---@private
    self.probability = decodedData.probability
    
    ---@private
    self.currency = decodedData.currency
    
    ---@private
    self.synthesisType = decodedData.synthesisType
    
    ---@private
    self.tabType = decodedData.tabType
    
    ---@private
    self.tabSubType = decodedData.tabSubType
    
    ---@private
    self.conditionRelation = decodedData.conditionRelation
    
    ---@private
    self.conditionType = decodedData.conditionType
    
    ---@private
    self.tab1 = decodedData.tab1
    
    ---@private
    self.roleLevelMin = decodedData.roleLevelMin
    
    ---@private
    self.roleLevelMax = decodedData.roleLevelMax
    
    ---@private
    self.roleReinMin = decodedData.roleReinMin
    
    ---@private
    self.roleReinMax = decodedData.roleReinMax
    
    ---@private
    self.servantLevelMin = decodedData.servantLevelMin
    
    ---@private
    self.servantLevelMax = decodedData.servantLevelMax
    
    ---@private
    self.servantReinMin = decodedData.servantReinMin
    
    ---@private
    self.servantReinMax = decodedData.servantReinMax
    
    ---@private
    self.career = decodedData.career
    
    ---@private
    self.sex = decodedData.sex
    
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
    self.showPriority = decodedData.showPriority
    
    ---@private
    self.numberChoose = decodedData.numberChoose
    
    ---@private
    self.openDay = decodedData.openDay
    
    ---@private
    self.redPoint = decodedData.redPoint
    
    ---@private
    self.conditionId = decodedData.conditionId
    
    ---@private
    self.show = decodedData.show
    
    ---@private
    self.redPointCompare = decodedData.redPointCompare
    
    ---@private
    self.numberLimit = decodedData.numberLimit
    
    ---@private
    self.equipExamine = decodedData.equipExamine
end

return cfg_synthesis