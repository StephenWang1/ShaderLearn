--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_boss
local cfg_boss = {}

cfg_boss.__index = cfg_boss

function cfg_boss:UUID()
    return self.id
end

---@return number bossid#客户端#C#不存在共同参与合并的字段  id有用到，不允许修改，所以每个id最好别连续，让以后可以中间插入
function cfg_boss:GetId()
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

---@return number 怪物id#客户端#C#不存在共同参与合并的字段  怪物id#客户端
function cfg_boss:GetConfId()
    if self.confId ~= nil then
        return self.confId
    else
        if self:CsTABLE() ~= nil then
            self.confId = self:CsTABLE().confId
            return self.confId
        else
            return nil
        end
    end
end

---@return string 怪物名称#客户端#C  怪物名称
function cfg_boss:GetName()
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

---@return number 所在地图#客户端#C#不存在共同参与合并的字段  地图编号，远古BOSS地图服务器发
function cfg_boss:GetMapId()
    if self.mapId ~= nil then
        return self.mapId
    else
        if self:CsTABLE() ~= nil then
            self.mapId = self:CsTABLE().mapId
            return self.mapId
        else
            return nil
        end
    end
end

---@return string 地图名字#客户端#C  地图显示名字 #后面为怪物死亡之后的颜色，再#后面为未满足进入条件的颜色
function cfg_boss:GetMapName()
    if self.mapName ~= nil then
        return self.mapName
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().mapName
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 限制条件#客户端#C  关联condition表id
function cfg_boss:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().level
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 掉落物品展示#客户端#C  连接到cfg_boss_drop_show id
function cfg_boss:GetDropShow()
    if self.dropShow ~= nil then
        return self.dropShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropShow
        else
            return nil
        end
    end
end

---@return string 掉落tips#客户端#C  掉落tips#客户端
function cfg_boss:GetDropTips()
    if self.dropTips ~= nil then
        return self.dropTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropTips
        else
            return nil
        end
    end
end

---@return string 怪物描述#客户端#C  怪物描述#客户端
function cfg_boss:GetMonsterTips()
    if self.monsterTips ~= nil then
        return self.monsterTips
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().monsterTips
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 推荐限制#客户端#C  推荐限制
function cfg_boss:GetLimit()
    if self.limit ~= nil then
        return self.limit
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().limit
        else
            return nil
        end
    end
end

---@return number 推荐类型#客户端#C#不存在共同参与合并的字段  表示同个等级段，同一系列
function cfg_boss:GetSeries()
    if self.series ~= nil then
        return self.series
    else
        if self:CsTABLE() ~= nil then
            self.series = self:CsTABLE().series
            return self.series
        else
            return nil
        end
    end
end

---@return number boss类型_C
function cfg_boss:GetType()
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
---@return number 排序_C
function cfg_boss:GetOrder()
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

---@return number 传送id_C
function cfg_boss:GetDeliverId()
    if self.deliverId ~= nil then
        return self.deliverId
    else
        if self:CsTABLE() ~= nil then
            self.deliverId = self:CsTABLE().deliverId
            return self.deliverId
        else
            return nil
        end
    end
end
---@return number 挑战次数_C
function cfg_boss:GetTime()
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

---@return string 按钮点击操作#客户端  满足条件类型#参数&不满足条件类型#参数  1如果为副本则寻找对应npc，非副本正常寻路deliverid（之前特殊处理    副本后添加副本id 在打开面板时可选中指定层）   2气泡 2#气泡id 3跳转界面 3#jumpid 4  直接传送 走deliverid 5 读取传送id  传送后打开面板选中某个页签添加特效6直接寻路到对应deliverid点 7副本传送对应duplicateid
function cfg_boss:GetEventParameters()
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

---@return number 模型左右位置偏移量#客户端  对模型旋转中心轴进行左右（同时反向调整模型的X坐标位置），偏移量为0时则显示原位置
function cfg_boss:GetOffsetX()
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
function cfg_boss:GetOffsetY()
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

---@return string 额外参数#客户端  1.神力BOSS剪影图片
function cfg_boss:GetParameter()
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

---@return TABLE.IntListJingHao 限制条件#客户端  关联condition表id，显示用condition
function cfg_boss:GetCondition()
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

---@return number 是否可进行扫荡#客户端  p判断是否可进行扫荡默认为0 可扫荡为1
function cfg_boss:GetCompletion()
    if self.completion ~= nil then
        return self.completion
    else
        if self:CsTABLE() ~= nil then
            self.completion = self:CsTABLE().completion
            return self.completion
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 扫荡消耗道具#客户端  道具id#数量
function cfg_boss:GetCompletionItem()
    if self.completionItem ~= nil then
        return self.completionItem
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().completionItem
        else
            return nil
        end
    end
end

---@return number boss子页签
function cfg_boss:GetSubType()
    return self.subType20_modelScale7 >> 7 & 1048575
end
---@return number 怪物模型大小
function cfg_boss:GetModelScale()
    return self.subType20_modelScale7 & 127
end

--@return  TABLE.CFG_BOSS C#中的数据结构
function cfg_boss:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_BossTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_boss lua中的数据结构
function cfg_boss:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.eventParameters = decodedData.eventParameters
    
    ---@private
    self.offsetX = decodedData.offsetX
    
    ---@private
    self.offsetY = decodedData.offsetY
    
    ---@private
    self.parameter = decodedData.parameter
    
    ---@private
    self.condition = decodedData.condition
    
    ---@private
    self.completion = decodedData.completion
    
    ---@private
    self.completionItem = decodedData.completionItem
    
    ---@private
    self.subType20_modelScale7 = decodedData.subType20_modelScale7
end

return cfg_boss