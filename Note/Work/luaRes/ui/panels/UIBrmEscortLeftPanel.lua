---@class UIBrmEscortLeftPanel:UIBase 白日门押镖左侧面板
local UIBrmEscortLeftPanel = {}

--region 数据
---@type OperationDartCar
UIBrmEscortLeftPanel.operationDartCar = nil
--endregion

--region 初始化
function UIBrmEscortLeftPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
    self:BindClientEvents()
end

---刷新组件
function UIBrmEscortLeftPanel:InitComponent()
    ---@type TweenPosition
    self.panelTween = self:GetCurComp("WidgetRoot/Tween","TweenPosition")
    ---@type TweenRotation
    self.arrowTween = self:GetCurComp("WidgetRoot/Tween/btn_hide","TweenRotation")

    ---@type UILabel
    self.dartCarName_UILabel = self:GetCurComp("WidgetRoot/Tween/title","UILabel")
    ---@type UILabel
    self.dartCarState_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_state","UILabel")
    ---@type UILabel
    self.dartCarHp_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_escortHp","UILabel")
    ---@type UILabel
    self.yaBiaoNum_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_transportCount","UILabel")
    ---@type UILabel
    self.plunderDartCarNum_UILabel = self:GetCurComp("WidgetRoot/Tween/lb_group/lb_hijackCount","UILabel")
    ---@type UILabel
    self.followBtn_UILabel = self:GetCurComp("WidgetRoot/Tween/btn_following/label","UILabel")

    ---@type UnityEngine.GameObject
    self.helpBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_help","GameObject")
    ---@type UnityEngine.GameObject
    self.arrowBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_hide","GameObject")
    ---@type UnityEngine.GameObject
    self.giveUpBtn_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_giveUp","GameObject")
    ---@type UnityEngine.GameObject
    self.follow_GameObject = self:GetCurComp("WidgetRoot/Tween/btn_following","GameObject")
end

function UIBrmEscortLeftPanel:InitParams()
    self.IsOpen = true
end

---绑定事件
function UIBrmEscortLeftPanel:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.helpBtn_GameObject,function(go)
        local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(182)
        if isFind then
            uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
        end
    end)
    luaclass.UIRefresh:BindClickCallBack(self.arrowBtn_GameObject,function(go)
        self.IsOpen = self.IsOpen == false
        self:PlayPanelTween(self.IsOpen)
    end)
    luaclass.UIRefresh:BindClickCallBack(self.giveUpBtn_GameObject,function(go)
        self:GiveUpDartCar(go)
    end)
    luaclass.UIRefresh:BindClickCallBack(self.follow_GameObject,function(go)
        self:ReqFollowDartCar()
    end)
end

---放弃镖车按钮点击
function UIBrmEscortLeftPanel:GiveUpDartCar()
    Utility.ShowSecondConfirmPanel({PromptWordId = 146,ComfireAucion = function()
        networkRequest.ReqGiveUpFreightCar()
    end})
end

---请求跟随镖车
function UIBrmEscortLeftPanel:ReqFollowDartCar()
    gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():OpenBaiRiMenDartCarFindPath(self.operationDartCar.Position.mapId,self.operationDartCar.Position.x,self.operationDartCar.Position.y,self.operationDartCar.lid)
end

---绑定客户端事件
function UIBrmEscortLeftPanel:BindClientEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.BaiRiMenDartCarDataChange,function(eventId,commonData)
        if commonData == nil or commonData.dataChangeType == nil then
            return
        end
        if commonData.operationDartCar ~= nil then
            self.operationDartCar = commonData.operationDartCar
        end
        if commonData.dataChangeType == LuaEnumBaiRiMenDartCarDataChangeType.All and commonData.operationDartCar ~= nil then
            self:RefreshAllPanel()
        elseif commonData.dataChangeType == LuaEnumBaiRiMenDartCarDataChangeType.Hp and commonData.operationDartCar ~= nil then
            self:RefreshDartCarHp()
        elseif commonData.dataChangeType == LuaEnumBaiRiMenDartCarDataChangeType.MainPlayerInfo then
            self:RefreshYaBiaoNum()
            self:RefreshPlunderNum()
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.BaiRiMenFindPathState,function(id,state)
        self:RefreshFollowBtnName(state)
    end)
end
--endregion

--region 刷新
---@param commonData table 通用参数
function UIBrmEscortLeftPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshAllPanel()
end

---刷新所有的面板
function UIBrmEscortLeftPanel:RefreshAllPanel()
    self:RefreshDartCarName()
    self:RefreshDartCarState()
    self:RefreshDartCarHp()
    self:RefreshYaBiaoNum()
    self:RefreshPlunderNum()
    self:RefreshFollowBtnName()
end

---解析数据
---@param commonData table 通用参数
function UIBrmEscortLeftPanel:AnalysisParams(commonData)
    if commonData == nil or commonData.operationDartCar == nil then
        return false
    end
    self.operationDartCar = commonData.operationDartCar
    if self.operationDartCar.AnalysisState == false then
        return false
    end
    return true
end

---刷新镖车名字
function UIBrmEscortLeftPanel:RefreshDartCarName()
    local dartCarName = self.operationDartCar:GetDartCarName()
    if dartCarName == nil then
        luaclass.UIRefresh:RefreshActive(self.dartCarName_UILabel,false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self.dartCarName_UILabel,true)
    luaclass.UIRefresh:RefreshLabel(self.dartCarName_UILabel,dartCarName)
end

---刷新镖车状态
function UIBrmEscortLeftPanel:RefreshDartCarState()
    luaclass.UIRefresh:RefreshActive(self.dartCarState_UILabel,false)
end

---刷新镖车血量
function UIBrmEscortLeftPanel:RefreshDartCarHp()
    local dartCarNowHp = self.operationDartCar:GetDartCarNowHp()
    if dartCarNowHp == nil then
        luaclass.UIRefresh:RefreshActive(self.dartCarHp_UILabel,false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self.dartCarHp_UILabel,true)
    local dartCarMaxHp = self.operationDartCar:GetDartCarMaxHp()
    local des = tostring(dartCarNowHp) .. "/" .. tostring(dartCarMaxHp)
    luaclass.UIRefresh:RefreshLabel(self.dartCarHp_UILabel,des)
end

---刷新押镖次数
function UIBrmEscortLeftPanel:RefreshYaBiaoNum()
    local nowYaBiaoNum = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().YaBiaoNum
    local nowYaBiaoNumColor = ternary(nowYaBiaoNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    if nowYaBiaoNum == nil then
        luaclass.UIRefresh:RefreshActive(self.yaBiaoNum_UILabel,false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self.yaBiaoNum_UILabel,true)
    local yaBiaoMaxNum = LuaGlobalTableDeal.GetYaBiaoNumMax()
    local des = nowYaBiaoNumColor .. tostring(nowYaBiaoNum) .. "[-]/" .. tostring(yaBiaoMaxNum)
    luaclass.UIRefresh:RefreshLabel(self.yaBiaoNum_UILabel,des)
end

---刷新押镖次数
function UIBrmEscortLeftPanel:RefreshPlunderNum()
    local nowPlunderNum = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar().PlunderDartNum
    local nowPlunderNumColor = ternary(nowPlunderNum <= 0,luaEnumColorType.Red,luaEnumColorType.Green)
    if nowPlunderNum == nil then
        luaclass.UIRefresh:RefreshActive(self.plunderDartCarNum_UILabel,false)
        return
    end
    luaclass.UIRefresh:RefreshActive(self.plunderDartCarNum_UILabel,true)
    local plunderMaxNum = LuaGlobalTableDeal.GetPlunderNumMax()
    local des = nowPlunderNumColor .. tostring(nowPlunderNum) .. "[-]/" .. tostring(plunderMaxNum)
    luaclass.UIRefresh:RefreshLabel(self.plunderDartCarNum_UILabel,des)
end

---刷新跟随镖车按钮名字
function UIBrmEscortLeftPanel:RefreshFollowBtnName(state)
    local des = ternary(state,"跟随中...","自动押镖")
    luaclass.UIRefresh:RefreshLabel(self.followBtn_UILabel,des)
end
--endregion

--region Tween
---播放面板tween
---@param open boolean
function UIBrmEscortLeftPanel:PlayPanelTween(open)
    luaclass.UIRefresh:PlayTween(self.panelTween,not open)
    luaclass.UIRefresh:PlayTween(self.arrowTween,not open)
end
--endregion

return UIBrmEscortLeftPanel