---@class MagicBossTypeDataInfo
local MagicBossTypeDataInfo = {}

--region 数据
---@type mapV2.DemonInfo 服务器魔之boss类型信息
MagicBossTypeDataInfo.serverDemonInfo = nil
---@type number 协助次数
MagicBossTypeDataInfo.helpNum = nil
---@type number 击杀次数
MagicBossTypeDataInfo.killNum = nil
---@type LuaEnumMagicBossDropType 魔之boss类型
MagicBossTypeDataInfo.magicBossType = nil
---@type number 增加击杀次数结束时间
MagicBossTypeDataInfo.addKillNumEndTime = nil
---@type number 总击杀次数
MagicBossTypeDataInfo.totalKillNum = nil
---@type number 总共击杀次数下次恢复时间
MagicBossTypeDataInfo.totalKillNumNextRecoverTime = nil
--endregion

--region 刷新
---刷新魔之boss信息类型数据
---@param commonData table 通用参数
function MagicBossTypeDataInfo:RefreshMagicBossTypeInfo(commonData)
    self.serverDemonInfo = commonData.serverDemonInfo
    self.helpNum = commonData.helpNum
    self.killNum = commonData.killNum
    self.magicBossType = commonData.magicBossType
    self.addKillNumEndTime = commonData.addKillNumEndTime
    self.totalKillNum = commonData.totalKillNum
    self.totalKillNumNextRecoverTime = commonData.totalKillNumNextRecoverTime
end
--endregion

--region 获取
---获取实际可击杀boss次数
function MagicBossTypeDataInfo:GetCurKillNum()
    if self.killNum ~= nil and self.totalKillNum ~= nil then
        return math.min(self.killNum,self.totalKillNum)
    end
    return 0
end
--endregion

--region 数据清理
---游戏场景退回到登录/选角界面时触发
function MagicBossTypeDataInfo:OnExitDestroy()
    self.serverDemonInfo = nil
    self.helpNum = nil
    self.killNum = nil
    self.magicBossType = nil
    self.addKillNumEndTime = nil
    self.totalKillNum = nil
    self.totalKillNumNextRecoverTime = nil
end
--endregion
return MagicBossTypeDataInfo