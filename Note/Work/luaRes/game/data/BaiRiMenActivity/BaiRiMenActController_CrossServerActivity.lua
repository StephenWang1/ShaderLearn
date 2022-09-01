---@class BaiRiMenActController_CrossServerActivity:BaiRiMenActControllerBase 白日门联服活动
local BaiRiMenActController_CrossServerActivity = {}

setmetatable(BaiRiMenActController_CrossServerActivity, luaclass.BaiRiMenActControllerBase)

---ID
function BaiRiMenActController_CrossServerActivity:GetRepresentActivityID()
    return 50001
end

---region 数据
function BaiRiMenActController_CrossServerActivity:Initialize()

end

---得到默认白日门联服活动表
function BaiRiMenActController_CrossServerActivity:GetDefaultBairimen_activityTable()
    if self.mDefaulBairimen_activityTable == nil then
        self.mDefaulBairimen_activityTable = clientTableManager.cfg_bairimen_activityManager:TryGetValue(self:GetRepresentActivityID())
    end
    return self.mDefaulBairimen_activityTable
end


--endregion

--region 白日门联服
---联服开启次数
function BaiRiMenActController_CrossServerActivity:GetCrossServerOpenNum()
    if (gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo() ~= nil) then
        return gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetOpenKuaFuNum()
    end
    return 0
end

---联服开启状态
function BaiRiMenActController_CrossServerActivity:GetCrossServerOpenNum()
    if (gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo() ~= nil) then
        return gameMgr:GetPlayerDataMgr():GetShareMapInfo().mBasicData.enterShare == 1
    end
    return false
end

---下次联服开启时间
function BaiRiMenActController_CrossServerActivity:GetCrossServerTime()
    if (gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo() ~= nil) then
        return gameMgr:GetPlayerDataMgr():GetShareMapInfo():GetNextCrossServerTime()
    end
    return 0
end
--endregion

return BaiRiMenActController_CrossServerActivity