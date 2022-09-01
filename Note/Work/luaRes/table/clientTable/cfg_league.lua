--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_league
local cfg_league = {}

cfg_league.__index = cfg_league

function cfg_league:UUID()
    return self.id
end

---@return number id#客户端#C#不存在共同参与合并的字段  编号
function cfg_league:GetId()
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

---@return string 联盟名称#客户端  联盟名称
function cfg_league:GetName()
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

---@return string 联盟描述#客户端  联盟描述，\n换行
function cfg_league:GetDes()
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

---@return string 联盟图标#客户端  用在联盟npc面板中
function cfg_league:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return string 联盟底图#客户端  用在预选面板中
function cfg_league:GetPainting()
    if self.painting ~= nil then
        return self.painting
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().painting
        else
            return nil
        end
    end
end

---@return number 排序#客户端  用在预选面板中
function cfg_league:GetOrder()
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

---@return string 封印塔icon#客户端  用在封印塔界面中
function cfg_league:GetTowerIcon()
    if self.towerIcon ~= nil then
        return self.towerIcon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().towerIcon
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_LEAGUE C#中的数据结构
function cfg_league:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_league lua中的数据结构
function cfg_league:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.name = decodedData.name
    
    ---@private
    self.des = decodedData.des
    
    ---@private
    self.icon = decodedData.icon
    
    ---@private
    self.painting = decodedData.painting
    
    ---@private
    self.order = decodedData.order
    
    ---@private
    self.towerIcon = decodedData.towerIcon
end

return cfg_league