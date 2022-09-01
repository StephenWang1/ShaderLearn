local UIUnrealMazeDeliverChooseTemplate = {}

--region 初始化
function UIUnrealMazeDeliverChooseTemplate:Init(panel)
    ---@type UIHuanJingPanel
    self.panel = panel
    self:InitComponents()
    self:BindMessage()
    self:BindUIEvents()
    self.index = 0
    self.canDeiliver = true
end

function UIUnrealMazeDeliverChooseTemplate:InitComponents()
    self.checkSprite = self:Get("check", "UISprite")
    self.TitleName = self:Get("check/TitleName", "Top_UILabel")
    self.CostIcon = self:Get("CostTitle/icon", "Top_UISprite")
    self.CostCount = self:Get("CostTitle/value", "Top_UILabel")
end

function UIUnrealMazeDeliverChooseTemplate:BindMessage()

end

function UIUnrealMazeDeliverChooseTemplate:InitData()
    local isFind, CostInfo = CS.Cfg_GlobalTableManager.Instance.DeliverFloorCostDic:TryGetValue(self.index)
    if (isFind) then
        self.CostInfo = CostInfo
    end
end

function UIUnrealMazeDeliverChooseTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.GoOnClick
end
--endregion

--region 刷新界面
function UIUnrealMazeDeliverChooseTemplate:RefreshUIPanel()
    self.TitleName.text = "幻境" .. self.index .. "层"
    if (self.CostInfo ~= nil) then
        self.CostIcon.spriteName = tostring(self.CostInfo[0])
        self.CostCount.text = tostring(self.CostInfo[1])
    end
    if (self.canDeiliver) then
        self.checkSprite.spriteName = "c3"
    else
        self.checkSprite.spriteName = "c5"
    end
end
--endregion

--region 客户端事件
function UIUnrealMazeDeliverChooseTemplate:GoOnClick(go)
    if (self.canDeiliver) then
        ---新需求 不需要判断联服
        --gameMgr:GetPlayerDataMgr():GetShareMapInfo():IsOpenShareMap()
        local MazeID = CS.Cfg_MiGongTableManager.Instance:GetMazeIDByFloor(self.index, false)
        if (MazeID ~= 0) then
            networkRequest.ReqDeliveryDuplicate(MazeID)
            uimanager:ClosePanel("UIHuanJingPanel")
        end
    else
        self.panel:ShowTips(go.transform, 274)
    end
end
--endregion

return UIUnrealMazeDeliverChooseTemplate