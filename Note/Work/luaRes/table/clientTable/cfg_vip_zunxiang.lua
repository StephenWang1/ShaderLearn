--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_vip_zunxiang
local cfg_vip_zunxiang = {}

cfg_vip_zunxiang.__index = cfg_vip_zunxiang

function cfg_vip_zunxiang:UUID()
    return self.id
end

---@return number 渠道id#客户端  渠道id
function cfg_vip_zunxiang:GetId()
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

---@return string 照片链接#客户端  照片链接
function cfg_vip_zunxiang:GetPicture()
    if self.picture ~= nil then
        return self.picture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().picture
        else
            return nil
        end
    end
end

---@return string 二维码链接#客户端  二维码链接
function cfg_vip_zunxiang:GetCode()
    if self.code ~= nil then
        return self.code
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().code
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 道具展示#客户端  礼包道具展示
function cfg_vip_zunxiang:GetItemShow()
    if self.itemShow ~= nil then
        return self.itemShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().itemShow
        else
            return nil
        end
    end
end

---@return string 标题名#客户端  标题名#客户端
function cfg_vip_zunxiang:GetTitle()
    if self.title ~= nil then
        return self.title
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().title
        else
            return nil
        end
    end
end

---@return string 内容#客户端
function cfg_vip_zunxiang:GetContent()
    if self.content ~= nil then
        return self.content
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().content
        else
            return nil
        end
    end
end

---@return string 温馨提示#客户端
function cfg_vip_zunxiang:GetTips()
    if self.tips ~= nil then
        return self.tips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tips
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_VIP_ZUNXIANG C#中的数据结构
function cfg_vip_zunxiang:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_vip_zunxiang lua中的数据结构
function cfg_vip_zunxiang:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.picture = decodedData.picture
    
    ---@private
    self.code = decodedData.code
    
    ---@private
    self.itemShow = decodedData.itemShow
    
    ---@private
    self.title = decodedData.title
    
    ---@private
    self.content = decodedData.content
    
    ---@private
    self.tips = decodedData.tips
end

return cfg_vip_zunxiang