--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_rank
local cfg_rank = {}

cfg_rank.__index = cfg_rank

function cfg_rank:UUID()
    return self.id
end

---@return number id#客户端#C  与cfg_ranking_reward表type字段对应，如果有发放排行榜奖励的，两边必须相同，否则排行榜奖励发放异常
function cfg_rank:GetId()
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

---@return number 排序#客户端#C#不存在共同参与合并的字段  榜单排序
function cfg_rank:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end

---@return string 上方页签名称#客户端#C  界面上方显示按钮
function cfg_rank:GetTop()
    if self.top ~= nil then
        return self.top
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().top
        else
            return nil
        end
    end
end

---@return string 左侧页排序#客户端#C  界面左侧显示按钮，排序#名称
function cfg_rank:GetLeft()
    if self.left ~= nil then
        return self.left
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().left
        else
            return nil
        end
    end
end

---@return string 分类页签#客户端#C  每个榜单里显示的条目类型，项#分隔
function cfg_rank:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().type
        else
            return nil
        end
    end
end

---@return string 排行榜下方视图#客户端#C  下方信息栏类型：1.无奖励   2.有奖励
function cfg_rank:GetViewType()
    if self.viewType ~= nil then
        return self.viewType
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().viewType
        else
            return nil
        end
    end
end

---@return number 说明#客户端#C  是否显示说明问号，显示填Cfg_Description id，不显就不填
function cfg_rank:GetDescription()
    if self.description ~= nil then
        return self.description
    else
        if self:CsTABLE() ~= nil then
            self.description = self:CsTABLE().description
            return self.description
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 排行榜数据widget#客户端#C  排行榜数据widget 排行榜数据ID（客户端定）#X坐标1名次 2名字 3职业 4等级 5灵兽 6划拳积分 7奖励宝箱 8魅力值 9夫妻信息 10亲密度 11性别 12送花数 13元宝交易额 14行会 15boss击杀 16人物击杀 17装备掉落 18详情 19战勋 20称号 21奖励预览
function cfg_rank:GetWidget()
    if self.widget ~= nil then
        return self.widget
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().widget
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 排行榜数据topWidget#客户端#C  排行榜数据topWwidget X坐标
function cfg_rank:GetTopWidget()
    if self.topWidget ~= nil then
        return self.topWidget
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().topWidget
        else
            return nil
        end
    end
end

---@return number 联服是否显示#客户端  联服是否显示此榜 1显示0不显示默认0
function cfg_rank:GetLianfu()
    if self.lianfu ~= nil then
        return self.lianfu
    else
        if self:CsTABLE() ~= nil then
            self.lianfu = self:CsTABLE().lianfu
            return self.lianfu
        else
            return nil
        end
    end
end

---@return number 请求id#客户端  对应原排行榜id
function cfg_rank:GetReqId()
    if self.reqId ~= nil then
        return self.reqId
    else
        if self:CsTABLE() ~= nil then
            self.reqId = self:CsTABLE().reqId
            return self.reqId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_RANK C#中的数据结构
function cfg_rank:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_RankTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_rank lua中的数据结构
function cfg_rank:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.lianfu = decodedData.lianfu
    
    ---@private
    self.reqId = decodedData.reqId
end

return cfg_rank