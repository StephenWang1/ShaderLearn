--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_guide_bubble
local cfg_guide_bubble = {}

cfg_guide_bubble.__index = cfg_guide_bubble

function cfg_guide_bubble:UUID()
    return self.id
end

---@return number id#客户端#C  唯一ID
function cfg_guide_bubble:GetId()
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

---@return string 内容#客户端#C  气泡框显示内容
function cfg_guide_bubble:GetContent()
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

---@return string 使用图片名#客户端#C  使用图片名
function cfg_guide_bubble:GetAtlas()
    if self.atlas ~= nil then
        return self.atlas
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().atlas
        else
            return nil
        end
    end
end

---@return number 点击后消失次数#客户端#C  点击后消失次数
function cfg_guide_bubble:GetTimes()
    if self.times ~= nil then
        return self.times
    else
        if self:CsTABLE() ~= nil then
            self.times = self:CsTABLE().times
            return self.times
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 初始位置#客户端#C  初始位置  X#Y
function cfg_guide_bubble:GetPositionStart()
    if self.positionStart ~= nil then
        return self.positionStart
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().positionStart
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 终点位置#客户端#C  终点位置  X#Y
function cfg_guide_bubble:GetPositionEnd()
    if self.positionEnd ~= nil then
        return self.positionEnd
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().positionEnd
        else
            return nil
        end
    end
end

---@return string 隐藏参数#客户端#C  打开面板时，暂时隐藏  面板名字#面板名字
function cfg_guide_bubble:GetHidePanel()
    if self.hidePanel ~= nil then
        return self.hidePanel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hidePanel
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 显示条件#客户端#C  显示条件  条件id#条件id
function cfg_guide_bubble:GetShowCondition()
    if self.showCondition ~= nil then
        return self.showCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showCondition
        else
            return nil
        end
    end
end

---@return number 显示cd#客户端#C  显示cd 单位 秒
function cfg_guide_bubble:GetShowCd()
    if self.showCd ~= nil then
        return self.showCd
    else
        if self:CsTABLE() ~= nil then
            self.showCd = self:CsTABLE().showCd
            return self.showCd
        else
            return nil
        end
    end
end

---@return number 是否可点击#客户端#C  不配置不可点击 1可点击
function cfg_guide_bubble:GetCanClick()
    if self.canClick ~= nil then
        return self.canClick
    else
        if self:CsTABLE() ~= nil then
            self.canClick = self:CsTABLE().canClick
            return self.canClick
        else
            return nil
        end
    end
end

---@return number 持续时间#客户端#C  不配置不自动消失 配置则相应时间后消失 单位 秒
function cfg_guide_bubble:GetLastTime()
    if self.lastTime ~= nil then
        return self.lastTime
    else
        if self:CsTABLE() ~= nil then
            self.lastTime = self:CsTABLE().lastTime
            return self.lastTime
        else
            return nil
        end
    end
end

---@return number 翻转类型#客户端#C  资源翻转 1 横向翻转 2 纵向翻转 3 横纵都翻转
function cfg_guide_bubble:GetFlip()
    if self.flip ~= nil then
        return self.flip
    else
        if self:CsTABLE() ~= nil then
            self.flip = self:CsTABLE().flip
            return self.flip
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 文本坐标位置#客户端#C  文本坐标位置（不填就默认）
function cfg_guide_bubble:GetLabelPosition()
    if self.labelPosition ~= nil then
        return self.labelPosition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().labelPosition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao X长度拉伸#客户端  X长度拉伸（（支持正负）
function cfg_guide_bubble:GetBackGroundSize()
    if self.backGroundSize ~= nil then
        return self.backGroundSize
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().backGroundSize
        else
            return nil
        end
    end
end

---@return string 边缘特效#客户端  边缘特效图片
function cfg_guide_bubble:GetFrameLight()
    if self.frameLight ~= nil then
        return self.frameLight
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().frameLight
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 边缘位移#客户端  边缘特效位移  X#Y
function cfg_guide_bubble:GetFrameLightPosition()
    if self.frameLightPosition ~= nil then
        return self.frameLightPosition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().frameLightPosition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 边缘特效尺寸#客户端  边缘特效尺寸 X#Y
function cfg_guide_bubble:GetFrameLightSize()
    if self.frameLightSize ~= nil then
        return self.frameLightSize
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().frameLightSize
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_GUIDE_BUBBLE C#中的数据结构
function cfg_guide_bubble:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_Guide_BubbleTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_guide_bubble lua中的数据结构
function cfg_guide_bubble:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.backGroundSize = decodedData.backGroundSize
    
    ---@private
    self.frameLight = decodedData.frameLight
    
    ---@private
    self.frameLightPosition = decodedData.frameLightPosition
    
    ---@private
    self.frameLightSize = decodedData.frameLightSize
end

return cfg_guide_bubble