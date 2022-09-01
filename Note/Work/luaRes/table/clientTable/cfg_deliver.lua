--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_deliver
local cfg_deliver = {}

cfg_deliver.__index = cfg_deliver

function cfg_deliver:UUID()
    return self.id
end

---@return number 传送id#客户端#C#不存在共同参与合并的字段  唯一ID
function cfg_deliver:GetId()
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

---@return number 绑定的NPCid#客户端#C#不存在共同参与合并的字段  map_npc表id
function cfg_deliver:GetBindNpcId()
    if self.bindNpcId ~= nil then
        return self.bindNpcId
    else
        if self:CsTABLE() ~= nil then
            self.bindNpcId = self:CsTABLE().bindNpcId
            return self.bindNpcId
        else
            return nil
        end
    end
end

---@return number 传送到目标地图id#客户端#C#不存在共同参与合并的字段
function cfg_deliver:GetToMapId()
    if self.toMapId ~= nil then
        return self.toMapId
    else
        if self:CsTABLE() ~= nil then
            self.toMapId = self:CsTABLE().toMapId
            return self.toMapId
        else
            return nil
        end
    end
end

---@return number 目标地图id#客户端#C#不存在共同参与合并的字段
function cfg_deliver:GetMapId()
    if self.MapId ~= nil then
        return self.MapId
    else
        if self:CsTABLE() ~= nil then
            self.MapId = self:CsTABLE().MapId
            return self.MapId
        else
            return nil
        end
    end
end

---@return number 目标NPCid#客户端#C#不存在共同参与合并的字段  map_npc的id-无法直接取得mapnpcid时，才取用本字段配置
function cfg_deliver:GetToNpcId()
    if self.toNpcId ~= nil then
        return self.toNpcId
    else
        if self:CsTABLE() ~= nil then
            self.toNpcId = self:CsTABLE().toNpcId
            return self.toNpcId
        else
            return nil
        end
    end
end

---@return string 是否为安全区#客户端#C  没用到
function cfg_deliver:GetSafe()
    if self.safe ~= nil then
        return self.safe
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().safe
        else
            return nil
        end
    end
end

---@return string 传送链接名称显示#客户端#C
function cfg_deliver:GetShowName()
    if self.showName ~= nil then
        return self.showName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showName
        else
            return nil
        end
    end
end

---@return string 传送消耗的道具#客户端#C  itemid#数量&itemid#数量
function cfg_deliver:GetItem()
    if self.item ~= nil then
        return self.item
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().item
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 传送条件限制#客户端#C  #表示并且 &符号表示或者 消耗道具的填在最后
function cfg_deliver:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().condition
        else
            return nil
        end
    end
end

---@return number 显示条件#客户端#C  不填则不启用
function cfg_deliver:GetDisplay()
    if self.display ~= nil then
        return self.display
    else
        if self:CsTABLE() ~= nil then
            self.display = self:CsTABLE().display
            return self.display
        else
            return nil
        end
    end
end

---@return string 时间限制#客户端#C  时间限制1020#1130
function cfg_deliver:GetTimeLimit()
    if self.timeLimit ~= nil then
        return self.timeLimit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().timeLimit
        else
            return nil
        end
    end
end

---@return number 特殊传送类型#客户端#C  1.沙城争霸
function cfg_deliver:GetSpecial()
    if self.special ~= nil then
        return self.special
    else
        if self:CsTABLE() ~= nil then
            self.special = self:CsTABLE().special
            return self.special
        else
            return nil
        end
    end
end

---@return number 排序#客户端#C  不填按照默认顺序  同类型只计算同类型
function cfg_deliver:GetOrder()
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

---@return string 特殊传送消耗#客户端#C  货币类消耗  货币ID#数量
function cfg_deliver:GetSpeciaItem()
    if self.speciaItem ~= nil then
        return self.speciaItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().speciaItem
        else
            return nil
        end
    end
end

---@return string 地域#客户端#C  地图类判断 biqi mengzhong
function cfg_deliver:GetRegion()
    if self.region ~= nil then
        return self.region
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().region
        else
            return nil
        end
    end
end

---@return number 目标地图x_C
function cfg_deliver:GetX()
    if self.x ~= nil then
        return self.x
    else
        if self:CsTABLE() ~= nil then
            self.x = self:CsTABLE().x
            return self.x
        else
            return nil
        end
    end
end
---@return number 目标地图y_C
function cfg_deliver:GetY()
    if self.y ~= nil then
        return self.y
    else
        if self:CsTABLE() ~= nil then
            self.y = self:CsTABLE().y
            return self.y
        else
            return nil
        end
    end
end
---@return number 随机传送范围_C
function cfg_deliver:GetRange()
    if self.range ~= nil then
        return self.range
    else
        if self:CsTABLE() ~= nil then
            self.range = self:CsTABLE().range
            return self.range
        else
            return nil
        end
    end
end
---@return number 传送员传送按钮分类_C
function cfg_deliver:GetButtonType()
    if self.buttonType ~= nil then
        return self.buttonType
    else
        if self:CsTABLE() ~= nil then
            self.buttonType = self:CsTABLE().buttonType
            return self.buttonType
        else
            return nil
        end
    end
end

---@return number 对应联服地图#客户端  对应联服地图
function cfg_deliver:GetShareMap()
    if self.shareMap ~= nil then
        return self.shareMap
    else
        if self:CsTABLE() ~= nil then
            self.shareMap = self:CsTABLE().shareMap
            return self.shareMap
        else
            return nil
        end
    end
end

---@return number 联服标记#客户端  用于客户端显示联服标记，填1显示，不填不显示
function cfg_deliver:GetLianfuMark()
    if self.lianfuMark ~= nil then
        return self.lianfuMark
    else
        if self:CsTABLE() ~= nil then
            self.lianfuMark = self:CsTABLE().lianfuMark
            return self.lianfuMark
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 消耗道具跳转#客户端  消耗道具不足时，客户端跳转路径，与item字段对应
function cfg_deliver:GetItemJump()
    if self.itemJump ~= nil then
        return self.itemJump
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemJump
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_DELIVER C#中的数据结构
function cfg_deliver:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_DeliverTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_deliver lua中的数据结构
function cfg_deliver:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.shareMap = decodedData.shareMap
    
    ---@private
    self.lianfuMark = decodedData.lianfuMark
    
    ---@private
    self.itemJump = decodedData.itemJump
end

return cfg_deliver