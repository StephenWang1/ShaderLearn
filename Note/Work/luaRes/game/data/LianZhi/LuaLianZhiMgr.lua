---@class LuaLianZhiMgr 炼制大师数据管理 调用实例   gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr()
local LuaLianZhiMgr = {}
---是否推送灵兽炼制红点
LuaLianZhiMgr.isPushRed_LingShou = false
---是否推送修为红点
LuaLianZhiMgr.isPushRed_XiuWei = false
---是否推送功勋红点
LuaLianZhiMgr.isPushRed_GongXun = false
---是否是首次进入
LuaLianZhiMgr.IsStartInter = false

---是否需要显示灵兽炼制面板
LuaLianZhiMgr.isNeedopen_LianzhiLingShou = false
---是否需要显示修为炼制面板
LuaLianZhiMgr.isNeedopen_LianzhiXiuWei = false
---是否需要显示功勋炼制面板
LuaLianZhiMgr.isNeedopen_LianzhiGongXun = false

---@param tblData roleV2.ResRefineMasterRedDot lua table类型消息数据
function LuaLianZhiMgr:RefreShData(tblData)

    self:StartRefreShRed(tblData)
    self:RefreShShowData(tblData)
end
function LuaLianZhiMgr:Init()
    LuaLianZhiMgr.IsStartInter = false
end

---是否首次进入刷新红点
function LuaLianZhiMgr:StartRefreShRed(tblData)
    if LuaLianZhiMgr.IsStartInter == false then
        if tblData == nil then
            self.isPushRed_LingShou = false
            self.isPushRed_XiuWei = false
            self.isPushRed_GongXun = false
            return
        end
        self.isPushRed_LingShou = tblData.servantReinExp == 1
        self.isPushRed_XiuWei = tblData.reinExp == 1
        if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(81004) then
            self.isPushRed_GongXun = tblData.feats == 1
        else
            self.isPushRed_GongXun = false
        end
        self:CallAllRed()
        LuaLianZhiMgr.IsStartInter = true
    end
end

function LuaLianZhiMgr:RefreShShowData(tblData)
    if tblData == nil then
        self.isNeedopen_LianzhiLingShou = false
        self.isNeedopen_LianzhiXiuWei = false
        self.isNeedopen_LianzhiGongXun = false
        return
    end
    self.isNeedopen_LianzhiLingShou = tblData.servantReinExp == 1
    self.isNeedopen_LianzhiXiuWei = tblData.reinExp == 1
    self.isNeedopen_LianzhiGongXun = tblData.feats == 1
end

---刷新单个红点
function LuaLianZhiMgr:CallRed(callName)
    local LianZhi = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(callName);
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(LianZhi);
end

---得到炼制次数
function LuaLianZhiMgr:GetLianZhiCount(type)
    if LuaLianZhiMgr.mLianZhiCount == nil then
        LuaLianZhiMgr.mLianZhiCount = {}
        local data = LuaGlobalTableDeal.GetGlobalTabl(22028)
        if data == nil then
            return
        end
        local str = string.Split(data.value, '#')
        for i, v in pairs(str) do
            table.insert(LuaLianZhiMgr.mLianZhiCount, tonumber(v))
        end
    end
    return LuaLianZhiMgr.mLianZhiCount[type]
end

---得到花费描述
function LuaLianZhiMgr:GetHuaFeiDes(huafei, ItemID)
    local itemNumber = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(ItemID)
    if tonumber(huafei) > itemNumber then
        return "[e85038]" .. huafei
    end
    return huafei
end

---刷新所有红点
function LuaLianZhiMgr:CallAllRed()
    --self:CallRed(LuaRedPointName.LianZhi_LingShou)
    self:CallRed(LuaRedPointName.LianZhi_GongXun)
    self:CallRed(LuaRedPointName.LianZhi_XiuWei)
end

return LuaLianZhiMgr