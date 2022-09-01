---@class UIGMPanel_SceneInfo:TemplateBase
local UIGMPanel_SceneInfo = {}

---@return UIGridContainer
function UIGMPanel_SceneInfo:GetGridContainerList()
    if self.mGridContainerList == nil then
        self.mGridContainerList = self:Get("InfoScrollView/Labels", "UIGridContainer")
    end
    return self.mGridContainerList
end

function UIGMPanel_SceneInfo:Init()
    self.mUpdateCallback = function()
        if CS.StaticUtility.IsNull(self.go) then
            if self.mUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil and CS.StaticUtility.IsNull(CS.CSListUpdateMgr.Instance) == false then
                CS.CSListUpdateMgr.Instance:Remove(self.mUpdateItem)
                self.mUpdateItem = nil
            end
            return
        end
        if not self.go.activeInHierarchy then
            return
        end
        self:OnUpdate()
    end
    self.mUpdateItem = CS.CSListUpdateMgr.Add(0.5, nil, self.mUpdateCallback, true)
end

local firstBatteryLevel = -1
local firstBatteryLevelTime = -1
function UIGMPanel_SceneInfo:OnUpdate()
    self:ClearCache()
    if self.mIsGameInterfaceInitialized then
        self:AddInfo(self.mSystemInfo1)
        self:AddInfo(self.mSystemInfo2)
        self:AddInfo(self.mSystemInfo3)
        self:AddInfo(self.mSystemInfo4)
        self:AddInfo(self.mSystemInfo5)
        self:AddInfo(self.mSystemInfo6)
    end
    if CS.CSGame.Sington ~= nil then
        local Size = CS.CSGame.Sington.ContentSize
        self:AddInfo("ContentSize(分辨率设置):    " .. tostring(Size))
    end

    self:AddInfo("SDKID:    " .. tostring(CS.Constant.UserID_SDK))
    self:AddInfo("真实账号ID:    " .. tostring(CS.Constant.UserID_Game))
    self:AddInfo("LoginToken_SDK:    " .. tostring(CS.Constant.LoginToken_SDK))
    self:AddInfo("LoginToken_Game:    " .. tostring(CS.Constant.LoginToken_Game))
    self:AddInfo("LoginToken_Token:    " .. tostring(CS.Constant.LoginToken_Token))
    self:AddInfo("默认包名:    " .. tostring(CS.SDKManager.GameInterface:GetDefaultPackageName()))
    self:AddInfo("真实应用包名:    " .. tostring(CS.SDKManager.GameInterface:GetPackageName()))
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil then
        self:AddInfo("玩家ID:    " .. tostring(CS.CSScene.Sington.MainPlayer.ID))
        self:AddInfo("玩家名:    " .. tostring(CS.CSScene.Sington.MainPlayer:getName()))
        self:AddInfo("等级:    " .. tostring(CS.CSScene.Sington.MainPlayer.BaseInfo.Level))
        self:AddInfo("转生等级:    " .. tostring(CS.CSScene.Sington.MainPlayer.BaseInfo.ReinLevel))
        self:AddInfo("当前地图ID:(MainPlayerInfo.MapID)    " .. tostring(CS.CSScene.MainPlayerInfo.MapID))

        if (CS.CSMapManager.Instance.mapInfoTbl ~= nil) then
            self:AddInfo("当前地图ID:(mapInfoTbl)    " .. tostring(CS.CSMapManager.Instance.mapInfoTbl.id))
        end
        if (CS.CSMapManager.Instance.mapInfoTbl ~= nil) then
            self:AddInfo("预加载地图ID:(preMapInfoTbl)    " .. tostring(CS.CSMapManager.Instance.preMapInfoTbl.id))
        end
        self:AddInfo("CSSceneManager.Instance.IsChangeMap    " .. tostring(CS.CSSceneManager.Instance.IsChangeMap))
        self:AddInfo("CSPreLoadingMgr.Singleton.CurScene.isLoadedScaleMap    " .. tostring(CS.CSPreLoadingMgr.Singleton.CurScene.isLoadedScaleMap))
        self:AddInfo("CSPreLoadingMgr.Singleton.CurScene.IsTerrainDataLoaded    " .. tostring(CS.CSPreLoadingMgr.Singleton.CurScene.IsTerrainDataLoaded))
    end
    self:AddInfo('IsMono:    ' .. tostring(CS.CSGame.IsUseMono));
    self:AddInfo('设备温度:    ' .. tostring(CS.SDKManager.GameInterface:GetTemperature()));
    self:AddInfo("单帧内最多处理过的消息数量:    " .. tostring(CS.CSNetwork.mMaxNetMsgDealedCountPerFrame))
    self:AddInfo('当前温度适配设置:    ' .. tostring(CS.CSAdaptManager.adaptAttach.isVisible));
    self:AddInfo('MeshLod:    ' .. tostring(CS.CSAdaptManager.adaptAttach.MeshLOD));
    self:AddInfo('MaxSkillEffectAmount:    ' .. tostring(CS.CSAdaptManager.adaptAttach.MaxSkillEffectAmount));
    self:AddInfo('SkillEffectLevel:    ' .. tostring(CS.CSAdaptManager.adaptAttach.SkillEffectLevel));
    if firstBatteryLevel == -2 then
        firstBatteryLevel = CS.ToolPhoneStateGet.GetBatteryLevel()
        firstBatteryLevelTime = CS.UnityEngine.Time.time
    end
    self:AddInfo('初始电量:    ' .. tostring(firstBatteryLevel));
    self:AddInfo('当前电量:    ' .. tostring(CS.ToolPhoneStateGet.GetBatteryLevel()));
    self:AddInfo('电量消耗时间:    ' .. tostring(CS.UnityEngine.Time.time - firstBatteryLevelTime));
    --self:AddInfo('堆栈内存:    ' .. tostring( CS.UnityEngine.Profiling.Profiler.GetMonoUsedSizeLong()/1024/1024));
    if CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.Sington.MainPlayer.Head ~= nil then
        self:AddInfo(CS.CSScene.Sington.MainPlayer.Head:GetMainPlayerHeadHpInfoLog())
    else
        self:AddInfo('MainHead Is Null')
    end

    self:FlushCache()

    --//self:AddInfo("最后一次的    " .. CS.CSMapManager.Instance.LastLoadMapStack)
end

function UIGMPanel_SceneInfo:OnEnable()
    self:RefreshSystemInfo()
end

function UIGMPanel_SceneInfo:RefreshSystemInfo()
    if CS.SDKManager.GameInterface ~= nil then
        self.mSystemInfo1 = "[afafaf]内存剩余: " .. tostring(CS.SDKManager.GameInterface:SystemAvaialbeMemorySize() * 0.001) .. " MB"
        self.mSystemInfo2 = "[afafaf]应用占用内存: " .. tostring(CS.SDKManager.GameInterface:GetProcessMemoryInfo() * 0.001) .. " MB"
        self.mSystemInfo3 = "[afafaf]应用内存界限: " .. tostring(CS.SDKManager.GameInterface:GetMemoryThreshold() * 0.001) .. " MB"
        self.mSystemInfo4 = "[afafaf]当前是否处于低内存状态: " .. tostring(CS.SDKManager.GameInterface:GetIsLowMemoryState())
        self.mSystemInfo5 = "[afafaf]距低内存状态还有多少内存可用: " .. tostring(CS.SDKManager.GameInterface:GetMemoryLimitResidue() * 0.001) .. " MB"
        self.mSystemInfo6 = "[afafaf]系统总内存: " .. tostring(CS.SDKManager.GameInterface:GetSystemeMemoryTotalSize() * 0.001) .. " MB"
        self.mIsGameInterfaceInitialized = true
    end
end

function UIGMPanel_SceneInfo:ClearCache()
    self.mInfos = {}
end

function UIGMPanel_SceneInfo:AddInfo(infoStr)
    table.insert(self.mInfos, infoStr)
end

function UIGMPanel_SceneInfo:FlushCache()
    local count = #self.mInfos
    self:GetGridContainerList().MaxCount = count
    if count > 0 then
        for i = 1, count do
            local go = self:GetGridContainerList().controlList[i - 1]
            local label = self:GetCurComp(go, "", "UILabel")
            label.text = self.mInfos[i]
        end
    end
end

function UIGMPanel_SceneInfo:OnDestroy()
    if self.mUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil and CS.StaticUtility.IsNull(CS.CSListUpdateMgr.Instance) == false then
        CS.CSListUpdateMgr.Instance:Remove(self.mUpdateItem)
        self.mUpdateItem = nil
    end
end

return UIGMPanel_SceneInfo