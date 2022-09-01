--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_jump
local cfg_jump = {}

cfg_jump.__index = cfg_jump

function cfg_jump:UUID()
    return self.id
end

---@return number 跳转ID#客户端#C#不存在共同参与合并的字段  id说明(100~200： 技能预留, 200~300: 神炉预留 , 300~40: 设置预留 , 400~500 锻造预留),500~600(帮会预留)，600~700（人物预留），700~800（灵兽预留），800~900（背包预留），900~1000（挑战BOSS预留）,1400~1500(社交)
function cfg_jump:GetId()
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

---@return string 界面#客户端#C  界面名称
function cfg_jump:GetPanels()
    if self.panels ~= nil then
        return self.panels
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().panels
        else
            return nil
        end
    end
end

---@return number 系统ID#客户端#C  对应notice表(如果途径不是直接打开(channel = 1)的话，系统开启交于途径判断)   特殊处理：UIShopPanel填1的时候，对应指向商会商城指定参数storeID的商品
function cfg_jump:GetOpenSystem()
    if self.openSystem ~= nil then
        return self.openSystem
    else
        if self:CsTABLE() ~= nil then
            self.openSystem = self:CsTABLE().openSystem
            return self.openSystem
        else
            return nil
        end
    end
end

---@return string 跳转说明#客户端#C  策划用
function cfg_jump:GetRemarks()
    if self.remarks ~= nil then
        return self.remarks
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remarks
        else
            return nil
        end
    end
end

---@return number 途径#客户端#C#不存在共同参与合并的字段  1.直接打开2.导航栏打开3.主界面下方4.秘籍打开
function cfg_jump:GetChannel()
    if self.channel ~= nil then
        return self.channel
    else
        if self:CsTABLE() ~= nil then
            self.channel = self:CsTABLE().channel
            return self.channel
        else
            return nil
        end
    end
end

---@return string 参数#客户端#C  跟途径有关,是途径所需参数, 没有则不填(例：如果是导航栏途径的话则填导航栏id)
function cfg_jump:GetParams()
    if self.params ~= nil then
        return self.params
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().params
        else
            return nil
        end
    end
end

---@return number 特殊类型跳转#客户端  填1代表跳转商会商城指定param的storeid的商品并特效框选（1快捷商店2钻石商城3元宝商城4周末商城 (现促销商城)5宝石系统商店6转生商店7金币商店8杂货铺16商会钻石商店17商会积分商店18钻石限时商店20限时礼包21循环钻石限时商店）
function cfg_jump:GetSpecialType()
    if self.specialType ~= nil then
        return self.specialType
    else
        if self:CsTABLE() ~= nil then
            self.specialType = self:CsTABLE().specialType
            return self.specialType
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_JUMP C#中的数据结构
function cfg_jump:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_JumpUITableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_jump lua中的数据结构
function cfg_jump:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.specialType = decodedData.specialType
end

return cfg_jump