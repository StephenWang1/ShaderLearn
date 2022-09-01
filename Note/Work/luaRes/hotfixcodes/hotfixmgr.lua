---注入修复管理器
---@class hotfixmgr
local hotfixmgr = {}

---初始化注入修复
function hotfixmgr.Initialize()
    ---注入编辑器测试时将下面的if注释掉
    --if true then
    if (CS.CSGameState.RunPlatform ~= CS.ERunPlatform.Editor) then
        --hotfixmgr.LoadHotfix_MainPlayerGather()
        --hotfixmgr.LoadHotfix_BonfireRangeSize()
    end
end

--region 采集修复代码
--function hotfixmgr.LoadHotfix_MainPlayerGather()
--    util.hotfix_ex(CS.CSMainPlayerGather, "GatherServerFinished", function(self, gatherState)
--        --print("hotfixmgr.LoadHotfix_MainPlayerGather")
--        if gatherState.lid ~= self.Data.TargetLid then
--            --不处理跟当前采集无关的完成消息
--            return
--        end
--        ---@type CSMainPlayerInfo
--        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
--        ---@type CSAvater
--        local mainPlayer
--        if CS.CSScene.Sington ~= nil then
--            mainPlayer = CS.CSScene.Sington.MainPlayer
--        end
--        if mainPlayer ~= nil then
--            if mainPlayer.FSMState == CS.EFSMState.Gather then
--                mainPlayerInfo.GatherData.GatherProcess = CS.EGatherProcess.Finishing
--            else
--                --收到了采集结束的包,但是当前人物状态机已经进入了非采集状态,所以将采集状态置为None
--                mainPlayerInfo.GatherData.GatherProcess = CS.EGatherProcess.None
--                --CS.UnityEngine.Debug.LogError("收到了采集结束的包,但是当前人物状态机已经进入了非采集状态,所以将采集状态置为None")
--            end
--        else
--            mainPlayerInfo.GatherData.GatherProcess = CS.EGatherProcess.None
--        end
--        local gatherType = self.Data.GatherType
--        if gatherType == CS.EGatherType.Fishing or gatherType == CS.EGatherType.SpecialFishing
--                or gatherType == CS.EGatherType.Mining or gatherType == CS.EGatherType.HideMinning then
--            --钓鱼,挖矿完成后需要重置已请求标志位
--            self.Data.IsRequestSended = false;
--        end
--    end)
--end
--endregion

--region 修复篝火范围
--function hotfixmgr.LoadHotfix_BonfireRangeSize()
--    util.hotfix_ex(CS.CSBonfire, "InitBonfireInfo", function(self, info)
--        self:InitBonfireInfo(info)
--        local bonefireTbl = clientTableManager.cfg_bonfireManager:TryGetValue(info.type)
--        if bonefireTbl ~= nil then
--            self.rangeSize = bonefireTbl:GetEffectRange() * CS.UnityEngine.Vector3.one
--        end
--    end)
--end
--endregion

return hotfixmgr