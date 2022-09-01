---@class UIPracticeRoomCountDownPanel
local UIPracticeRoomCountDownPanel = {}

function UIPracticeRoomCountDownPanel:InitComponents()
    self.Desc1 = self:GetCurComp("WidgetRoot/Desc1", "UILabel")
    self.Desc2 = self:GetCurComp("WidgetRoot/Desc2", "UILabel")
    ---倒计时
    self.Time = self:GetCurComp('WidgetRoot/Desc1', 'UICountdownLabel')
end

function UIPracticeRoomCountDownPanel:InitOther()
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, function()
        self:RefreShUI()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResKongFuHouseTimeLimitMessage, function(msgId, tblInfo)
        self.mMapIdToTime = {}
        for i = 1, #tblInfo.times do
            local time = tblInfo.times[i]
            local mapId, leaveTime = CS.Utility_Lua.DecodeHD(time, 32, 0x0ffffffff);
            if leaveTime < 0 then
                leaveTime = 0
            end
            self.Time:StartCountDown(nil, 7, tonumber(CS.CSServerTime.Instance.TotalMillisecond + leaveTime), "剩余时间 [ff0000]", "")
            --if mapId and leaveTime and mapId > 0 and leaveTime >= 0 then
            --    self.mMapIdToTime[mapId] = math.ceil(leaveTime / 1000)
            --    self.mLeaveTimeShow = math.ceil(leaveTime / 1000)
            --end
        end
    end)
end

---初始化数据
function UIPracticeRoomCountDownPanel:Init()
    self:InitComponents()
    self:InitOther()
end

---@param data TABLE.cfg_practice_room
function UIPracticeRoomCountDownPanel:Show(data)
    if data == nil then
        self:ClosePanel()
        return
    end
    self.data = data
    self:RefreShUI()
end

function UIPracticeRoomCountDownPanel:RefreShUI()
    if self.data:GetId() == 4 then
        self:ShowType1(self.data)
    elseif self.data:GetId() == 5 then
        self:ShowType2(self.data)
    end
end

---显示类型1(只消耗资源)
---@param data TABLE.cfg_practice_room
function UIPracticeRoomCountDownPanel:ShowType1(data)
    self.Desc1.gameObject:SetActive(false)
    self.Desc2.gameObject.transform.localPosition = CS.UnityEngine.Vector3(-140, 8, 0);
    if data:GetExpUpCost().list[1] == nil then
        return
    end
    if data:GetExpUpCost().list[1].list[1] == nil then
        return
    end
    self.Desc2.text = "剩余练功点 " .. gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(data:GetExpUpCost().list[1].list[1])
end

---显示类型2(消耗资源，消耗时间)
---@param data TABLE.cfg_practice_room
function UIPracticeRoomCountDownPanel:ShowType2(data)
    self.Desc1.gameObject:SetActive(true)
    self.Desc2.gameObject.transform.localPosition = CS.UnityEngine.Vector3(-140, 0, 0);
    if data:GetExpUpCost().list[1] == nil then
        return
    end
    if data:GetExpUpCost().list[1].list[1] == nil then
        return
    end
    self.Desc2.text = "剩余钻石 " .. CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(data:GetExpUpCost().list[1].list[1])--(data:GetExpUpCost().list[1])

end

---关闭面板
function UIPracticeRoomCountDownPanel:ClosePanel()
    uimanager:ClosePanel("UIPracticeRoomCountDownPanel")
end

return UIPracticeRoomCountDownPanel