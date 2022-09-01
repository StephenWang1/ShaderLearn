--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_suit
local cfg_suit = {}

cfg_suit.__index = cfg_suit

function cfg_suit:UUID()
    return self.id
end

---@return number id#客户端  唯一id，不能重复
function cfg_suit:GetId()
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

---@return number 套装id#客户端  item表中suitBelong字段会引用这里的id，相同id属于同一套装  10001 魂装 10002 仙装 10003 神器 20001宝物套装
function cfg_suit:GetSuitId()
    if self.suitId ~= nil then
        return self.suitId
    else
        if self:CsTABLE() ~= nil then
            self.suitId = self:CsTABLE().suitId
            return self.suitId
        else
            return nil
        end
    end
end

---@return string 名字#客户端  套装的名字
function cfg_suit:GetName()
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

---@return number 套装等级#客户端  套装等级划分，item表中的group字段可索引对应等级套装生效的等级
function cfg_suit:GetSuitLv()
    if self.suitLv ~= nil then
        return self.suitLv
    else
        if self:CsTABLE() ~= nil then
            self.suitLv = self:CsTABLE().suitLv
            return self.suitLv
        else
            return nil
        end
    end
end

---@return number 套装生效所需角色等级#客户端  不填不生效
function cfg_suit:GetLv()
    if self.Lv ~= nil then
        return self.Lv
    else
        if self:CsTABLE() ~= nil then
            self.Lv = self:CsTABLE().Lv
            return self.Lv
        else
            return nil
        end
    end
end

---@return number 套装生效所需角色转生等级#客户端  不填不生效
function cfg_suit:GetReinLv()
    if self.reinLv ~= nil then
        return self.reinLv
    else
        if self:CsTABLE() ~= nil then
            self.reinLv = self:CsTABLE().reinLv
            return self.reinLv
        else
            return nil
        end
    end
end

---@return number 套装职业#客户端  1战士 2法师 3道士
function cfg_suit:GetCareer()
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

---@return string 套装属性名字#客户端  套装属性标题
function cfg_suit:GetAttributeName()
    if self.attributeName ~= nil then
        return self.attributeName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attributeName
        else
            return nil
        end
    end
end

---@return number 套装属性所需装备数量#客户端  激活套装属性所需要本套套装的件数
function cfg_suit:GetNeedNum()
    if self.needNum ~= nil then
        return self.needNum
    else
        if self:CsTABLE() ~= nil then
            self.needNum = self:CsTABLE().needNum
            return self.needNum
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 套装效果参数#客户端  不同套装各自定义 【10001黄金套】：激活效果后，提升一定比例魂装附加的技能固定伤害数值，按万分位填写【20001宝物套】：buffid获得BUFF
function cfg_suit:GetAttributeParam()
    if self.attributeParam ~= nil then
        return self.attributeParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().attributeParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 套装包含装备#客户端  如果需要在tips中显示套装中包含哪些装备的名称，需要在这里填写装备道具id
function cfg_suit:GetEquips()
    if self.equips ~= nil then
        return self.equips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equips
        else
            return nil
        end
    end
end

---@return string 描述#客户端  激活此条属性的描述
function cfg_suit:GetDes()
    if self.des ~= nil then
        return self.des
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().des
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 激活技能#客户端  激活的技能\n         索引到技能表  skillid#level
function cfg_suit:GetSkill()
    if self.skill ~= nil then
        return self.skill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skill
        else
            return nil
        end
    end
end

---@return string 激活技能的描述#客户端  技能描述
function cfg_suit:GetSkilldes()
    if self.skilldes ~= nil then
        return self.skilldes
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skilldes
        else
            return nil
        end
    end
end

---@return string 镶嵌名称#客户端  镶嵌后显示在主装备名称中的文本
function cfg_suit:GetInlayName()
    if self.inlayName ~= nil then
        return self.inlayName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().inlayName
        else
            return nil
        end
    end
end

---@return number 镶嵌名称位置#客户端  镶嵌后显示在主装备名称中的位置 1主装备前 2 主装备后
function cfg_suit:GetInlayNameOrder()
    if self.inlayNameOrder ~= nil then
        return self.inlayNameOrder
    else
        if self:CsTABLE() ~= nil then
            self.inlayNameOrder = self:CsTABLE().inlayNameOrder
            return self.inlayNameOrder
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 类型组合#客户端  由哪些类型组合而成，填对应的主类型#子类型#此部位无装备时tips上显示的道具id
function cfg_suit:GetBelongSuit()
    if self.belongSuit ~= nil then
        return self.belongSuit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().belongSuit
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SUIT C#中的数据结构
function cfg_suit:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_suit lua中的数据结构
function cfg_suit:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.suitId = decodedData.suitId
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.suitLv = decodedData.suitLv
    
    ---@private
    self.Lv = decodedData.Lv
    
    ---@private
    self.reinLv = decodedData.reinLv
    
    ---@private
    self.career = decodedData.career
    
    ---@private
    self.attributeName = decodedData.attributeName
    
    ---@private
    self.needNum = decodedData.needNum
    
    ---@private
    self.attributeParam = decodedData.attributeParam
    
    ---@private
    self.equips = decodedData.equips
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.skill = decodedData.skill
    
    ---@private
    self.skilldes = decodedData.skilldes
    
    ---@private
    self.inlayName = decodedData.inlayName
    
    ---@private
    self.inlayNameOrder = decodedData.inlayNameOrder
    
    ---@private
    self.belongSuit = decodedData.belongSuit
end

return cfg_suit