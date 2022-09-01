---@class cfg_rankManager:TableManager
local cfg_rankManager = {}

---获取Lua值
---@param key number 表ID
---@return TABLE.cfg_rank
function cfg_rankManager:TryGetValue(key)
    if self.dic ~= nil then
        return self.dic[key]
    else
        return nil
    end
end

---遍历
---@param action fun<number,TABLE.cfg_rank> 遍历方法
function cfg_rankManager:ForPair(action)
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
function cfg_rankManager:PostProcess()
end

---获取排行榜页签
---@return table<number,TrankBookMark>
function cfg_rankManager:GetLuaRankBookMarkList()
    local isKuaFuOpen = gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
    if isKuaFuOpen and Utility.IsKuaFuMap(CS.CSScene.getMapID()) then
        if self.addKuaFuRankTbl == nil then
            ---@type table<number,TrankBookMark> 含有跨服的排行榜
            self.addKuaFuRankTbl = self:GetAllRankBookMarkList(true)
        end
        return self.addKuaFuRankTbl
    else
        if self.origionRankTbl == nil then
            ---@type table<number,TrankBookMark> 未含跨服的排行榜
            self.origionRankTbl = self:GetAllRankBookMarkList(false)
        end
        return self.origionRankTbl
    end
end

---获取所有排行榜页签
---@param isNeedAddKuaFu boolean 是否需要添加跨服的页签
---@return table<number,TrankBookMark>
function cfg_rankManager:GetAllRankBookMarkList(isNeedAddKuaFu)
    local tbl = {}

    local originList = CS.Cfg_RankTableManager.Instance.BookMarkList
    if originList ~= nil then
        for i = 0, originList.Count - 1 do
            local trankBookMrak = originList[i]
            ---@type table<number,BranchBookMark>
            local branchBookMarkTbl = {}
            for j = 0, trankBookMrak.branchBookMarkList.Count - 1 do
                local branchBookMark = trankBookMrak.branchBookMarkList[j]
                ---@type TABLE.cfg_rank
                local ranktable = self:TryGetValue(branchBookMark.id)
                if ranktable then

                    local isLianFuRank = ranktable:GetLianfu() ~= nil and ranktable:GetLianfu() == 1

                    if isNeedAddKuaFu or not isLianFuRank then
                        ---@class BranchBookMark 副页签信息
                        local BranchBookMark = {
                            ---@type CS.RankBranchBookMark 副页签基础信息
                            branchBookMarkBaseInfo = branchBookMark,
                            ---@type number 请求id
                            reqId = ranktable:GetReqId(),
                            ---@type boolean 是否为联服排行榜
                            isLinfu = isLianFuRank
                        }
                        table.insert(branchBookMarkTbl, BranchBookMark)
                    end
                end
            end
            if #branchBookMarkTbl > 0 then
                ---@class TrankBookMark 主页签信息
                local TrankBookMark = {
                    ---@type string 页签显示
                    topStr = trankBookMrak.topStr,
                    ---@type number 排序字段
                    index = trankBookMrak.index,
                    ---@type table<number,BranchBookMark>
                    branchBookMarkList = branchBookMarkTbl
                }
                table.insert(tbl, TrankBookMark)
            end
        end
    end
    return tbl
end

return cfg_rankManager