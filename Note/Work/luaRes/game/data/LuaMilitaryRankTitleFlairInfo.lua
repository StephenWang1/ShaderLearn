---@class LuaMilitaryRankTitleFlairInfo:luaobject
local LuaMilitaryRankTitleFlairInfo = {}

LuaMilitaryRankTitleFlairInfo.mBasicData = {}

---配置后的临时数据
LuaMilitaryRankTitleFlairInfo.mTempData = {}
-- 剩余可分配点数
LuaMilitaryRankTitleFlairInfo.mRemainPointData = 0


function LuaMilitaryRankTitleFlairInfo:Init()
    self.mBasicData = { 0, 0, 0, 0, 0, 0, 0 }
    self.mTempData = { 0, 0, 0, 0, 0, 0 }
    self.mRemainPointData = 0
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance:TryGetValue(22887)
    if isFind then
        self.attrMax = tonumber(tbl.value)
    end
end

---收到响应时刷新数据
---@param tblData roleV2.ResTitleTianfu
function LuaMilitaryRankTitleFlairInfo:RefreshData(tblData)
    --self.mBasicData = { tblData.zhanAddPoint, tblData.zhanReducePoint, tblData.faAddPoint, tblData.faReducePoint, tblData.daoAddPoint, tblData.daoReducePoint, tblData.available }
    self.mBasicData[1] = tblData.zhanAddPoint
    self.mBasicData[2] = tblData.zhanReducePoint
    self.mBasicData[3] = tblData.faAddPoint
    self.mBasicData[4] = tblData.faReducePoint
    self.mBasicData[5] = tblData.daoAddPoint
    self.mBasicData[6] = tblData.daoReducePoint
    self.mBasicData[7] = tblData.available
    self.mRemainPointData = self.mBasicData[7]
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.TitleTalentMark))
end

---@return table
function LuaMilitaryRankTitleFlairInfo:GetTalentData()
    return self.mBasicData
end

---@return table
function LuaMilitaryRankTitleFlairInfo:GetTalentTempData()
    return self.mTempData
end

---@param index 下标
---@param value 下标值
function LuaMilitaryRankTitleFlairInfo:SetTalentTempData(index, value)
    self.mTempData[index] = value
end

---重置临时数据为0
function LuaMilitaryRankTitleFlairInfo:ResetTalentTempData()
    self.mTempData = { 0, 0, 0, 0, 0, 0 }
    self.mRemainPointData = self.mBasicData[7]
end

-- 获取剩余可分配点数
---@return number
function LuaMilitaryRankTitleFlairInfo:GetRemainPointData()
    return self.mRemainPointData
end

-- 设置临时数据
---@param index 下标
---@param value 改变值
---@param type 操作类型
function LuaMilitaryRankTitleFlairInfo:SetChange(index,value,type)
    --类型123分别是加、减、输入
    local curTempData = self.mTempData[index]
    local curData = self.mBasicData[index]
    if type == 1 then
        if self.mRemainPointData <= 0 then
            return false
        end
        if self.attrMax < value then
            return false
        end
        return true
    elseif type == 2 then
        return self:GetCanReduce(index)
    else
        if value < curData then
            return false
        end
        return self:GetCanAdd(index,value)
    end
end

function LuaMilitaryRankTitleFlairInfo:GetCanAdd(index,number)
    if self.mRemainPointData <= 0 then
        return false
    end
    if self.attrMax < number then
        return false
    end
    local gap = number - self.mBasicData[index]
    if self.mTempData[index] ~= gap and gap < self.mRemainPointData then
        self:SetTalentTempData(index,gap)
        --luaEventManager.DoCallback(LuaCEvent.RefreshFengHaoRemainPoint)
    end
    if gap > self.mRemainPointData then
        return false
    end
    return true
end

function LuaMilitaryRankTitleFlairInfo:GetCanReduce(index)
    return self.mTempData[index] > 0
end

-- 设置剩余可分配点数
---@return number
function LuaMilitaryRankTitleFlairInfo:SetRemainPointData(num)
    self.mRemainPointData = num
end
function LuaMilitaryRankTitleFlairInfo:AddRemainPointData(num)
    self.mRemainPointData = self.mRemainPointData + num
end


-- 获取剩余可用天赋丹
---@return number
function LuaMilitaryRankTitleFlairInfo:GetRemainTalentDan()
    local id = CS.CSScene.MainPlayerInfo.SealMarkId
    local sealMarkTblInfo = clientTableManager.cfg_prefix_titleManager:TryGetValue(id)
    local curRemainCount = 0
    if sealMarkTblInfo ~= nil then
        local maxValue = sealMarkTblInfo:GetAttributeItemShow() == nil and 0 or sealMarkTblInfo:GetAttributeItemShow()
        curRemainCount = maxValue
        local haveItemUseCount, itemUseCount = Utility.GetItemUseCount(5000765)
        if haveItemUseCount then
            curRemainCount = curRemainCount - itemUseCount < 0 and 0 or curRemainCount - itemUseCount
        end
    end
    return curRemainCount
end



return LuaMilitaryRankTitleFlairInfo