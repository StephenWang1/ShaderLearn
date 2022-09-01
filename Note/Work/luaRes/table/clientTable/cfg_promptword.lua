--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_promptword
local cfg_promptword = {}

cfg_promptword.__index = cfg_promptword

function cfg_promptword:UUID()
    return self.id
end

---@return number id#客户端#C  弹窗id
function cfg_promptword:GetId()
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

---@return number 弹窗类型#客户端#C  不填或为0为普通弹窗 1弹窗后倒计时
function cfg_promptword:GetType()
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

---@return string 弹窗文本内容#客户端#C  文本内容，%s为文字，%d为数字,\n为换行
function cfg_promptword:GetDes()
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

---@return string 标题#客户端#C  弹窗标题
function cfg_promptword:GetTitle()
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

---@return string 左按钮文字#客户端#C  按钮文字
function cfg_promptword:GetLeftButton()
    if self.leftButton ~= nil then
        return self.leftButton
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().leftButton
        else
            return nil
        end
    end
end

---@return string 右按钮文字#客户端#C  按钮文字
function cfg_promptword:GetRightButton()
    if self.rightButton ~= nil then
        return self.rightButton
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rightButton
        else
            return nil
        end
    end
end

---@return number 倒计时时间#客户端#C  类型1的弹窗使用，单位秒，倒计时结束后自动调用对应按钮
function cfg_promptword:GetCountDown()
    if self.countDown ~= nil then
        return self.countDown
    else
        if self:CsTABLE() ~= nil then
            self.countDown = self:CsTABLE().countDown
            return self.countDown
        else
            return nil
        end
    end
end

---@return number 调用的按钮#客户端#C  类型1用，0左按钮1右按钮
function cfg_promptword:GetCallButton()
    if self.callButton ~= nil then
        return self.callButton
    else
        if self:CsTABLE() ~= nil then
            self.callButton = self:CsTABLE().callButton
            return self.callButton
        else
            return nil
        end
    end
end

---@return string 左按钮图集#客户端#C  按钮图片资源路径
function cfg_promptword:GetLeftButtonSprite()
    if self.leftButtonSprite ~= nil then
        return self.leftButtonSprite
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().leftButtonSprite
        else
            return nil
        end
    end
end

---@return string 右按钮图集#客户端#C  按钮图片资源路径
function cfg_promptword:GetRightButtonSprite()
    if self.rightButtonSprite ~= nil then
        return self.rightButtonSprite
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().rightButtonSprite
        else
            return nil
        end
    end
end

---@return string 下按钮文字#客户端#C  按钮文字
function cfg_promptword:GetDownButton()
    if self.downButton ~= nil then
        return self.downButton
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().downButton
        else
            return nil
        end
    end
end

---@return string 下按钮图集#客户端#C  按钮图片资源路径
function cfg_promptword:GetDownButtonSprite()
    if self.downButtonSprite ~= nil then
        return self.downButtonSprite
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().downButtonSprite
        else
            return nil
        end
    end
end

---@return string 勾选框#客户端  勾选框文本不需要勾选框就不用配
function cfg_promptword:GetNote()
    if self.note ~= nil then
        return self.note
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().note
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_PROMPTWORD C#中的数据结构
function cfg_promptword:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_PromptWordTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_promptword lua中的数据结构
function cfg_promptword:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.note = decodedData.note
end

return cfg_promptword