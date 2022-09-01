--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_video
local cfg_video = {}

cfg_video.__index = cfg_video

function cfg_video:UUID()
    return self.id
end

---@return number id#客户端  被item表索引
function cfg_video:GetId()
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

---@return string 参数#客户端  视频资源
function cfg_video:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

---@return string 指定来源#客户端  客户端说配啥配啥
function cfg_video:GetSource()
    if self.source ~= nil then
        return self.source
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().source
        else
            return nil
        end
    end
end

---@return number x轴位置偏移#客户端  万分比
function cfg_video:GetX()
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

---@return number y轴位置偏移#客户端  万分比
function cfg_video:GetY()
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

---@return number 窗口比例#客户端  比例
function cfg_video:GetScale()
    if self.scale ~= nil then
        return self.scale
    else
        if self:CsTABLE() ~= nil then
            self.scale = self:CsTABLE().scale
            return self.scale
        else
            return nil
        end
    end
end

---@return number 窗口像素#客户端  像素
function cfg_video:GetWh()
    if self.wh ~= nil then
        return self.wh
    else
        if self:CsTABLE() ~= nil then
            self.wh = self:CsTABLE().wh
            return self.wh
        else
            return nil
        end
    end
end

---@return number 循环播放#客户端  播完自动循环，或播完后暂停，点击视频重新播放 0不重复 1重复 默认0
function cfg_video:GetLoop()
    if self.loop ~= nil then
        return self.loop
    else
        if self:CsTABLE() ~= nil then
            self.loop = self:CsTABLE().loop
            return self.loop
        else
            return nil
        end
    end
end

---@return number 可暂停#客户端  点击视频暂停
function cfg_video:GetSuspend()
    if self.suspend ~= nil then
        return self.suspend
    else
        if self:CsTABLE() ~= nil then
            self.suspend = self:CsTABLE().suspend
            return self.suspend
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_VIDEO C#中的数据结构
function cfg_video:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_video lua中的数据结构
function cfg_video:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.parameter = decodedData.parameter
    
    ---@private
    self.source = decodedData.source
    
    ---@private
    self.x = decodedData.x
    
    ---@private
    self.y = decodedData.y
    
    ---@private
    self.scale = decodedData.scale
    
    ---@private
    self.wh = decodedData.wh
    
    ---@private
    self.loop = decodedData.loop
    
    ---@private
    self.suspend = decodedData.suspend
end

return cfg_video