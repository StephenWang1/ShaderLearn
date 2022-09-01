--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bonfire
local cfg_bonfire = {}

cfg_bonfire.__index = cfg_bonfire

function cfg_bonfire:UUID()
    return self.id
end

---@return number 火堆id#客户端#C#不存在共同参与合并的字段  篝火id
function cfg_bonfire:GetId()
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

---@return number 存在时间#客户端#C  篝火存在时间，单位秒
function cfg_bonfire:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            self.time = self:CsTABLE().time
            return self.time
        else
            return nil
        end
    end
end

---@return number 基础经验#客户端#C  基础经验 单位 经验值/s
function cfg_bonfire:GetBasicExp()
    if self.basicExp ~= nil then
        return self.basicExp
    else
        if self:CsTABLE() ~= nil then
            self.basicExp = self:CsTABLE().basicExp
            return self.basicExp
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 人数加成#客户端#C  人数加成基础经验，人数下限#人数上限#加成万分比   &分割不同人数的情况
function cfg_bonfire:GetNumberAdd()
    if self.numberAdd ~= nil then
        return self.numberAdd
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().numberAdd
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 经验浮动#客户端#C  结算之后的经验浮动 单位：万分比 填写浮动值下限#浮动值上限
function cfg_bonfire:GetFloatingExp()
    if self.floatingExp ~= nil then
        return self.floatingExp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().floatingExp
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 繁荣度加成#客户端#C  繁荣度加成(等级排行榜前五平均等级-玩家自身等级)*A%，上下限B~C%，增加百分比为基础经验的万分比  配置数据A#B#C 单位万分比
function cfg_bonfire:GetProsperityAd()
    if self.prosperityAd ~= nil then
        return self.prosperityAd
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().prosperityAd
        else
            return nil
        end
    end
end

---@return string 篝火名称#客户端#C
function cfg_bonfire:GetName()
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

---@return number NPC模型#客户端#C#不存在共同参与合并的字段  模型资源
function cfg_bonfire:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            self.model = self:CsTABLE().model
            return self.model
        else
            return nil
        end
    end
end

---@return string 模型特效#客户端#C  模型特效
function cfg_bonfire:GetEffect()
    if self.effect ~= nil then
        return self.effect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effect
        else
            return nil
        end
    end
end

---@return string 小地图用名称#客户端#C  不填不显示 scenename 使用场景内名字
function cfg_bonfire:GetShowInMinimap()
    if self.showInMinimap ~= nil then
        return self.showInMinimap
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showInMinimap
        else
            return nil
        end
    end
end

---@return string 功能面板#客户端#C  其他为对应功能面板，预设名
function cfg_bonfire:GetOpenPanel()
    if self.openPanel ~= nil then
        return self.openPanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openPanel
        else
            return nil
        end
    end
end

---@return number 火堆类型_C
function cfg_bonfire:GetType()
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
---@return number 火堆范围_C
function cfg_bonfire:GetRange()
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
---@return number 范围圈大小_C
function cfg_bonfire:GetEffectRange()
    if self.effectRange ~= nil then
        return self.effectRange
    else
        if self:CsTABLE() ~= nil then
            self.effectRange = self:CsTABLE().effectRange
            return self.effectRange
        else
            return nil
        end
    end
end

---@return number npc名字垂直偏移_C
function cfg_bonfire:GetNamey()
    if self.namey ~= nil then
        return self.namey
    else
        if self:CsTABLE() ~= nil then
            self.namey = self:CsTABLE().namey
            return self.namey
        else
            return nil
        end
    end
end
---@return number 模型大小_C
function cfg_bonfire:GetSize()
    if self.size ~= nil then
        return self.size
    else
        if self:CsTABLE() ~= nil then
            self.size = self:CsTABLE().size
            return self.size
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BONFIRE C#中的数据结构
function cfg_bonfire:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_BonfireTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bonfire lua中的数据结构
function cfg_bonfire:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
end

return cfg_bonfire