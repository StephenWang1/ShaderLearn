---白日门闯天关活动 调用示例   gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_HuntingRewar()
---@class BaiRiMenActController_ChuangTianGuan:BaiRiMenActControllerBase
local BaiRiMenActController_ChuangTianGuan = {}

setmetatable(BaiRiMenActController_ChuangTianGuan, luaclass.BaiRiMenActControllerBase)

function BaiRiMenActController_ChuangTianGuan:GetRepresentActivityID()
    return 60001
end

---得到默认白日门闯天关活动表
function BaiRiMenActController_ChuangTianGuan:GetDefaultBairimen_activityTable()
    if self.mDefaulBairimen_activityTable == nil then
        self.mDefaulBairimen_activityTable = clientTableManager.cfg_bairimen_activityManager:TryGetValue(self:GetRepresentActivityID())
    end
    return self.mDefaulBairimen_activityTable
end



return BaiRiMenActController_ChuangTianGuan