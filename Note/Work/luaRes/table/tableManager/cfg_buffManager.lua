---@class cfg_buffManager:TableManager
local cfg_buffManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_buff
function cfg_buffManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_buff> 遍历方法
function cfg_buffManager:ForPair(action)
    if action == nil then
        return
    end
    if self.dic then
        for i, v in pairs(self.dic) do
            action(i, v)
        end
    end
end

---表格解析完毕后调用此方法
function cfg_buffManager:PostProcess()
end

---获取buff描述内容
---@param buffId number
---@return string
function cfg_buffManager:GetBuffDes(buffId)
    if buffId == nil then
        return
    end
    local buffTbl = self:TryGetValue(buffId)
    if buffTbl == nil then
        return
    end
    local buffTxtList = string.Split(buffTbl:GetTxt(),'#')
    if type(buffTxtList) ~= 'table' or Utility.GetLuaTableCount(buffTxtList) <= 0 then
        return
    end
    if #buffTxtList == 3 then
        local mainPlayerCareer = gameMgr:GetLuaMainPlayer():GetCareer()
        return buffTxtList[mainPlayerCareer]
    end
    return buffTxtList[1]
end

---获取buff描述内容
---@param buffId number
---@return string
function cfg_buffManager:GetBuffTipsDes(buffId)
    if buffId == nil then
        return
    end
    local buffTbl = self:TryGetValue(buffId)
    if buffTbl == nil then
        return
    end
    local buffTxtList = string.Split(buffTbl:GetTipsTxt(),'#')
    if type(buffTxtList) ~= 'table' or Utility.GetLuaTableCount(buffTxtList) <= 0 then
        return
    end
    if #buffTxtList == 3 then
        local mainPlayerCareer = gameMgr:GetLuaMainPlayer():GetCareer()
        return buffTxtList[mainPlayerCareer]
    end
    return buffTxtList[1]
end

return cfg_buffManager