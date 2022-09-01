--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_bairimen_activity
local cfg_bairimen_activity = {}

cfg_bairimen_activity.__index = cfg_bairimen_activity

function cfg_bairimen_activity:UUID()
    return self.id
end

---@return number id#客户端  第1位活动类型；第2345位编号
function cfg_bairimen_activity:GetId()
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

---@return number 活动id#客户端  连接到cfg_daily_activity_time表id
function cfg_bairimen_activity:GetActivityId()
    if self.activityId ~= nil then
        return self.activityId
    else
        if self:CsTABLE() ~= nil then
            self.activityId = self:CsTABLE().activityId
            return self.activityId
        else
            return nil
        end
    end
end

---@return string 页签名字显示#客户端  页签
function cfg_bairimen_activity:GetTabName()
    if self.tabName ~= nil then
        return self.tabName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tabName
        else
            return nil
        end
    end
end

---@return string 预设名字#客户端  每个界面预设名
function cfg_bairimen_activity:GetPrefabs()
    if self.prefabs ~= nil then
        return self.prefabs
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().prefabs
        else
            return nil
        end
    end
end

---@return number 怪物id#客户端  各种获得怪物id，不需要的不用填
function cfg_bairimen_activity:GetMonsterId()
    if self.monsterId ~= nil then
        return self.monsterId
    else
        if self:CsTABLE() ~= nil then
            self.monsterId = self:CsTABLE().monsterId
            return self.monsterId
        else
            return nil
        end
    end
end

---@return string 按钮点击操作#客户端  满足条件类型#参数&不满足条件类型#参数  1如果为副本则寻找对应npc 2气泡 2#气泡id 3跳转界面 3#jumpid 4  直接传送 走deliverid 5 读取传送id  传送后打开面板选中某个页签添加特效6直接寻路到对应deliverid点
function cfg_bairimen_activity:GetEventParameters()
    if self.eventParameters ~= nil then
        return self.eventParameters
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().eventParameters
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 页签开放条件#客户端  读取conditions表 多条件用#分隔
function cfg_bairimen_activity:GetOpenCondition()
    if self.openCondition ~= nil then
        return self.openCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openCondition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 活动条件#客户端  读取conditions表 多条件用#分隔
function cfg_bairimen_activity:GetActivityCondition()
    if self.activityCondition ~= nil then
        return self.activityCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().activityCondition
        else
            return nil
        end
    end
end

---@return string 底图显示#客户端  每个物品底图图片名
function cfg_bairimen_activity:GetBackground()
    if self.background ~= nil then
        return self.background
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().background
        else
            return nil
        end
    end
end

---@return string 标题显示#客户端  标题显示图片名
function cfg_bairimen_activity:GetTitle()
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

---@return string 图片显示#客户端  图片名字
function cfg_bairimen_activity:GetModelPicture()
    if self.modelPicture ~= nil then
        return self.modelPicture
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().modelPicture
        else
            return nil
        end
    end
end

---@return number 模型左右位置偏移量#客户端  对模型旋转中心轴进行左右（同时反向调整模型的X坐标位置），偏移量为0时则显示原位置
function cfg_bairimen_activity:GetOffsetX()
    if self.offsetX ~= nil then
        return self.offsetX
    else
        if self:CsTABLE() ~= nil then
            self.offsetX = self:CsTABLE().offsetX
            return self.offsetX
        else
            return nil
        end
    end
end

---@return number 模型界面展示高度调整#客户端  对界面中模型展示的高度进行调整
function cfg_bairimen_activity:GetOffsetY()
    if self.offsetY ~= nil then
        return self.offsetY
    else
        if self:CsTABLE() ~= nil then
            self.offsetY = self:CsTABLE().offsetY
            return self.offsetY
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 联服预告时间#客户端  联服预告时间，连接condition表，按钮显隐，未满足显示倒计时
function cfg_bairimen_activity:GetAdvanceTime()
    if self.advanceTime ~= nil then
        return self.advanceTime
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().advanceTime
        else
            return nil
        end
    end
end

---@return string 按钮事件描述#客户端  事件描述  #回车
function cfg_bairimen_activity:GetDescribe()
    if self.describe ~= nil then
        return self.describe
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().describe
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 页签显示条件#客户端  用于列表页签的显示，读取conditions表 多条件用#分隔
function cfg_bairimen_activity:GetShowCondition()
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

---@return number 消耗体力#客户端  挖掘、击杀扣除体力
function cfg_bairimen_activity:GetPhysicalstrength()
    if self.physicalstrength ~= nil then
        return self.physicalstrength
    else
        if self:CsTABLE() ~= nil then
            self.physicalstrength = self:CsTABLE().physicalstrength
            return self.physicalstrength
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 红点显示条件#客户端  红点显示条件
function cfg_bairimen_activity:GetRedPoint()
    if self.redPoint ~= nil then
        return self.redPoint
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().redPoint
        else
            return nil
        end
    end
end

---@return number 活动类型
function cfg_bairimen_activity:GetSubtype()
    return self.subtype5_order10_modelScale7 >> 17 & 31
end
---@return number 页签排序
function cfg_bairimen_activity:GetOrder()
    return self.subtype5_order10_modelScale7 >> 7 & 1023
end
---@return number 怪物模型大小
function cfg_bairimen_activity:GetModelScale()
    return self.subtype5_order10_modelScale7 & 127
end

--@return  TABLE.CFG_BAIRIMEN_ACTIVITY C#中的数据结构
function cfg_bairimen_activity:CsTABLE()
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_bairimen_activity lua中的数据结构
function cfg_bairimen_activity:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.activityId = decodedData.activityId
    
    ---@private
    self.tabName = decodedData.tabName
    
    ---@private
    self.prefabs = decodedData.prefabs
    
    ---@private
    self.monsterId = decodedData.monsterId
    
    ---@private
    self.eventParameters = decodedData.eventParameters
    
    ---@private
    self.openCondition = decodedData.openCondition
    
    ---@private
    self.activityCondition = decodedData.activityCondition
    
    ---@private
    self.background = decodedData.background
    
    ---@private
    self.title = decodedData.title
    
    ---@private
    self.modelPicture = decodedData.modelPicture
    
    ---@private
    self.offsetX = decodedData.offsetX
    
    ---@private
    self.offsetY = decodedData.offsetY
    
    ---@private
    self.advanceTime = decodedData.advanceTime
    
    ---@private
    self.describe = decodedData.describe
    
    ---@private
    self.showCondition = decodedData.showCondition
    
    ---@private
    self.physicalstrength = decodedData.physicalstrength
    
    ---@private
    self.redPoint = decodedData.redPoint
    
    ---@private
    self.subtype5_order10_modelScale7 = decodedData.subtype5_order10_modelScale7
end

return cfg_bairimen_activity