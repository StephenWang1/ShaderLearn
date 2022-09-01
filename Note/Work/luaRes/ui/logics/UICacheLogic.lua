---@class UICacheLogic
local UICacheLogic = {}

---@type cfg_uilogicManager
UICacheLogic.uilogicTblMgr = clientTableManager.cfg_uilogicManager
---@type cfg_uilogic_cachesManager
UICacheLogic.logicCacheTblMgr = clientTableManager.cfg_uilogic_cachesManager
---@type cfg_uisetsManager
UICacheLogic.uiSetsTblMgr = clientTableManager.cfg_uisetsManager

UICacheLogic.cachePanels = {}
---@type boolean 表示是否需要跳过本次打开检查
UICacheLogic.mNeedSkip = false
---需要被打开的界面
UICacheLogic.mPanelsThatNeedToBeOpened = {}
---最近一次打开界面或关闭界面的帧索引
UICacheLogic.mLatestPanelOperateFrameIndex = 0
---延迟的帧数
UICacheLogic.mFrameCountForLate = 5
---代码层面的规避列表
---@type table
UICacheLogic.avoidListInScript = {
    "UILoginPanel", "UILoginRolePanel", "UIServerListPanel", "UIAllTextTipsContainerPanel", "UIDeadPanel", "UIAntiAddictionPanel"
}

---界面打开前检查
---@param panelName string 待打开的UI面板名
---@param action function 打开回调
---@return boolean 是否可以打开界面
function UICacheLogic:CheckBeforePanelOpened(panelName, action, ...)
    if self.mNeedSkip then
        return true
    end
    self.mLatestPanelOperateFrameIndex = CS.UnityEngine.Time.frameCount
    if Utility.IsContainsValue(self.avoidListInScript, panelName) then
        return true
    end
    local needCache = self:CheckIsNeedToBeCached(panelName)
    if needCache then
        --若符合缓冲条件,则将界面和各参数加入缓冲,并中断打开界面
        if self.cachePanels[panelName] == nil then
            self.cachePanels[panelName] = {}
        end
        self.cachePanels[panelName].action = action
        self.cachePanels[panelName].data = { ... }
    end
    return needCache == false
end

---界面关闭后检查是否有缓冲的Cache需要处理
---@param panel UIBase
function UICacheLogic:CheckAfterPanelClosed(panel)
    self.mLatestPanelOperateFrameIndex = CS.UnityEngine.Time.frameCount
    if self.cachePanels then
        for panelName, dataTbl in pairs(self.cachePanels) do
            if self:CheckIsNeedToBeCached(panelName) == false then
                table.insert(self.mPanelsThatNeedToBeOpened, panelName)
            end
        end
    end
end

---检查是否需要缓冲处理
---@param panelName string 待检查的界面名
---@return boolean 是否需要缓冲处理
function UICacheLogic:CheckIsNeedToBeCached(panelName)
    local uilogicTbl = self.uilogicTblMgr:GetUILogic(panelName)
    if uilogicTbl and uilogicTbl:GetCacheLogics() and uilogicTbl:GetCacheLogics().list then
        for i = 1, #uilogicTbl:GetCacheLogics().list do
            local cacheTblIndex = uilogicTbl:GetCacheLogics().list[i]
            --检查已经打开的界面
            if uimanager and uimanager.UIGameObjects then
                for panelNameTemp, panelTemp in pairs(uimanager.UIGameObjects) do
                    --若符合缓冲条件,则将界面和各参数加入缓冲,并中断打开界面,规避与待检查的界面名重名的界面
                    if panelTemp.PanelLayerTypeInt == nil then
                        panelTemp.PanelLayerTypeInt = Utility.EnumToInt(panelTemp.PanelLayerType)
                    end
                    if panelName ~= panelNameTemp and self.logicCacheTblMgr:IsPanelConformToCache(cacheTblIndex, panelNameTemp, panelTemp.PanelLayerTypeInt) then
                        if panelTemp._PanelState == LuaEnumUIState.Normal and panelTemp.go and CS.StaticUtility.IsNull(panelTemp.go) == false and panelTemp.IsHiden == false then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

---重新打开缓冲的界面
---@param panelName string 界面名
---@param cachedPanelData table 界面数据
function UICacheLogic:ReOpenCachedPanel(panelName, cachedPanelData)
    if panelName and cachedPanelData then
        self.mNeedSkip = true
        uimanager:CreatePanel(panelName, cachedPanelData.action, table.unpack(cachedPanelData.data))
        self.mNeedSkip = false
    end
end

---移除缓冲的界面
function UICacheLogic:RemoveCachedPanel(panelName)
    if self.cachePanels then
        self.cachePanels[panelName] = nil
    end
    if self.mPanelsThatNeedToBeOpened then
        self.mPanelsThatNeedToBeOpened[panelName] = nil
    end
end

---清理所有缓存的Cache
function UICacheLogic:ClearAllCaches()
    Utility.ClearTable(self.cachePanels)
    Utility.ClearTable(self.mPanelsThatNeedToBeOpened)
end

---逐帧刷新
function UICacheLogic:OnUpdate(timeInterval)
    if self.mPanelsThatNeedToBeOpened == nil or #self.mPanelsThatNeedToBeOpened == 0 then
        return
    end
    if CS.UnityEngine.Time.frameCount > self.mLatestPanelOperateFrameIndex + self.mFrameCountForLate then
        local length = #self.mPanelsThatNeedToBeOpened
        for i = length, 1, -1 do
            local panelNameTemp = self.mPanelsThatNeedToBeOpened[i]
            if panelNameTemp then
                if self:CheckIsNeedToBeCached(panelNameTemp) == false then
                    self:ReOpenCachedPanel(panelNameTemp, self.cachePanels[panelNameTemp])
                    self.cachePanels[panelNameTemp] = nil
                    table.remove(self.mPanelsThatNeedToBeOpened, i)
                end
            end
        end
    end
end

return UICacheLogic