---隐藏地图倒计时界面
---@class UIHidenMapCountDownPanel:UIBase
local UIHidenMapCountDownPanel = {}

---描述文本组件
---@return UILabel
function UIHidenMapCountDownPanel:GetDescriptionLabel()
    if self.mDescriptionLabel == nil then
        self.mDescriptionLabel = self:GetCurComp("WidgetRoot/Desc", "UILabel")
    end
    return self.mDescriptionLabel
end

---增加时间按钮
---@return UnityEngine.GameObject
function UIHidenMapCountDownPanel:GetAddButtonGo()
    if self.mAddButtonGo == nil then
        self.mAddButtonGo = self:GetCurComp("WidgetRoot/add", "GameObject")
    end
    return self.mAddButtonGo
end

---倒计时文本
---@return UICountdownLabel
function UIHidenMapCountDownPanel:GetCountDownLabel()
    if self.mCountDownLabel == nil then
        self.mCountDownLabel = self:GetCurComp("WidgetRoot/CountDownLabel", "UICountdownLabel")
    end
    return self.mCountDownLabel
end

function UIHidenMapCountDownPanel:Init()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_StartLoadMap, function(msgId, msgData)
        ---切换地图时关闭自己
        self:ClosePanel()
    end)
end

function UIHidenMapCountDownPanel:Show(mapId, finishTimeStamp)
    --print(mapId, finishTimeStamp)
    if mapId == nil or finishTimeStamp == nil then
        self:ClosePanel()
        return
    end
    if CS.CSAstar_Scene.IsSameMapReally(CS.CSScene.MainPlayerInfo.MapID, mapId) == false then
        self:ClosePanel()
        return
    end
    self.mMapID = mapId
    self.mFinishTimeStamp = finishTimeStamp
    self:GetCountDownLabel():StartCountDown(500, 3, finishTimeStamp, "[ff0000]", "[-]")
    local mapTbl = clientTableManager.cfg_mapManager:TryGetValue(self.mMapID)
    if mapTbl then
        self:GetDescriptionLabel().text = mapTbl:GetName() .. "时间"
    end
end

return UIHidenMapCountDownPanel