---@class UIGhostShipLeftMainPanel : UIBase 通用副本面板
local UIGhostShipLeftMainPanel = {}

--region  组件

---@return UILabel
function UIGhostShipLeftMainPanel:GetMonsterName()
    if (self.mGetMonsterName == nil) then
        self.mGetMonsterName = self:GetCurComp("WidgetRoot/Tween/view/lb_name", "Top_UILabel");
    end
    return self.mGetMonsterName;
end

---@return UILabel
function UIGhostShipLeftMainPanel:GetKillNum()
    if (self.mGetKillNum == nil) then
        self.mGetKillNum = self:GetCurComp("WidgetRoot/Tween/view/Killnum", "Top_UILabel");
    end
    return self.mGetKillNum;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetAdd_GameObject()
    if (self.mGetAdd_GameObject == nil) then
        self.mGetAdd_GameObject = self:GetCurComp("WidgetRoot/Tween/view/add", "GameObject");
    end
    return self.mGetAdd_GameObject;
end

---@return UILabel
function UIGhostShipLeftMainPanel:GetHelpNum()
    if (self.mGetHelpNum == nil) then
        self.mGetHelpNum = self:GetCurComp("WidgetRoot/Tween/view/helpnum", "Top_UILabel");
    end
    return self.mGetHelpNum;
end

---@return Top_UIGridContainer
function UIGhostShipLeftMainPanel:GetKillGrid()
    if (self.mGetKillGrid == nil) then
        self.mGetKillGrid = self:GetCurComp("WidgetRoot/Tween/view/down/KillReward/ScrollView/Awards", "Top_UIGridContainer");
    end
    return self.mGetKillGrid;
end

---@return Top_UIGridContainer
function UIGhostShipLeftMainPanel:GetHelpGrid()
    if (self.mGetHelpGrid == nil) then
        self.mGetHelpGrid = self:GetCurComp("WidgetRoot/Tween/view/down/HelpReward/Awards", "Top_UIGridContainer");
    end
    return self.mGetHelpGrid;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetBtnClose_GameObject()
    if (self.mBtnClose_GameObject == nil) then
        self.mBtnClose_GameObject = self:GetCurComp("WidgetRoot/Tween/events/btn_exit", "GameObject");
    end
    return self.mBtnClose_GameObject;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetBtnHelp_GameObject()
    if (self.mGetBtnHelp_GameObject == nil) then
        self.mGetBtnHelp_GameObject = self:GetCurComp("WidgetRoot/Tween/events/helpBtn", "GameObject");
    end
    return self.mGetBtnHelp_GameObject;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetBtnHide_GameObject()
    if (self.mGetBtnHide_GameObject == nil) then
        self.mGetBtnHide_GameObject = self:GetCurComp("WidgetRoot/Tween/events/BtnHide", "GameObject");
    end
    return self.mGetBtnHide_GameObject;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetBtnCenter_GameObject()
    if (self.mGetBtnCenter_GameObject == nil) then
        self.mGetBtnCenter_GameObject = self:GetCurComp("WidgetRoot/Tween/events/btn_center", "GameObject");
    end
    return self.mGetBtnCenter_GameObject;
end

---@return Top_TweenPosition
function UIGhostShipLeftMainPanel:Gettween()
    if (self.mGettween == nil) then
        self.mGettween = self:GetCurComp("WidgetRoot/Tween", "Top_TweenPosition");
    end
    return self.mGettween;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetHelp_GameObject()
    if (self.mGetHelp_GameObject == nil) then
        self.mGetHelp_GameObject = self:GetCurComp("WidgetRoot/Tween/view/down/HelpReward", "GameObject");
    end
    return self.mGetHelp_GameObject;
end

---@return UnityEngine.GameObject
function UIGhostShipLeftMainPanel:GetCountFinal_GameObject()
    if (self.mGetCountFinal_GameObject == nil) then
        self.mGetCountFinal_GameObject = self:GetCurComp("WidgetRoot/CountFinal", "GameObject");
    end
    return self.mGetCountFinal_GameObject;
end

---@return UILabel
function UIGhostShipLeftMainPanel:GetCountFinalLabel()
    if (self.mGetCountFinalLabel == nil) then
        self.mGetCountFinalLabel = self:GetCurComp("WidgetRoot/CountFinal", "UILabel");
    end
    return self.mGetCountFinalLabel;
end

--endregion

--region 初始化

function UIGhostShipLeftMainPanel:Init()
    self:BindUIEvents()
    self:BindNetMessage()
end

function UIGhostShipLeftMainPanel:Show(mapId)
    self:GetCountFinal_GameObject():SetActive(false)
    gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetIsTarget(false)
    self.mapId = CS.CSScene.MainPlayerInfo.MapID
    self.showTips_bool = true
    self:CheckTime()
    self:RefreshText()
    self:RefreshGrid()
    self:RefreshCount()
end

--- 初始化组件
function UIGhostShipLeftMainPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetBtnClose_GameObject()).onClick = function()
        self:OnClickBtnClose()
    end
    CS.UIEventListener.Get(self:GetBtnHelp_GameObject()).onClick = function()
        self:ShowHelp()
    end
    CS.UIEventListener.Get(self:GetBtnHide_GameObject()).onClick = function()
        self:OnClickBtnHide()
    end
    CS.UIEventListener.Get(self:GetAdd_GameObject()).onClick = function()
        self:ShowGetWay()
    end
    CS.UIEventListener.Get(self:GetBtnCenter_GameObject()).onClick = function()
        self:SendHelpMsg()
    end
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.TargetStateChange, function(id)
        self:RefreshTarget()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MonsterKillRemain, function(id)
        self:RefreshCount()
    end)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.GhostShipTime, function(id, time)
        self:RefreshTimeCount(time)
    end)
end

function UIGhostShipLeftMainPanel:BindNetMessage()

end
--endregion

--region 消息接收
function UIGhostShipLeftMainPanel:OnMonsterDead(id, data)

end

function UIGhostShipLeftMainPanel:CheckTime()
    local time = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetCount()
    if time == nil then
        return
    end
    self:RefreshTimeCount(time)
end

---endregion

--region 点击事件

function UIGhostShipLeftMainPanel:OnClickBtnClose()
    local globalTbl = self:GetGlobalTable(23057)
    local list = string.Split(globalTbl, "#")
    local temp = {}
    temp.ID = tonumber(list[1])
    temp.CallBack = function()
        Utility.TryTransfer(tonumber(list[2]))
    end
    uimanager:CreatePanel("UIPromptPanel",nil,temp)
end

function UIGhostShipLeftMainPanel:OnClickBtnHide()
    self:Gettween():SetOnFinished(function()
        self:ClickHideBtnCallBack()
    end)
    if self.showTips_bool then
        self:Gettween():PlayForward()
        self.showTips_bool = false
    else
        self:Gettween():PlayReverse()
        self.showTips_bool = true
    end
end

function UIGhostShipLeftMainPanel:ClickHideBtnCallBack()
    local v3 = CS.UnityEngine.Vector3.zero
    if not self.showTips_bool then
        v3.z = 180
    end
    self:GetBtnHide_GameObject().transform.localEulerAngles = v3
end

function UIGhostShipLeftMainPanel:ShowHelp()
    local data = {}
    data.id = 245
    Utility.ShowHelpPanel(data)
end

function UIGhostShipLeftMainPanel:ShowGetWay()
    Utility.ShowItemGetWay(6770001, self:GetAdd_GameObject())
end

function UIGhostShipLeftMainPanel:SendHelpMsg()
    local canGo ,remainTime = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetTimer()
    if canGo then
        gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():SetTime()
        local monsterId = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetMonsterId()
        networkRequest.ReqAssist(monsterId)
    else
        local str = remainTime.."秒后可发起协助"
        Utility.ShowPopoTips(self:GetBtnCenter_GameObject(), str, 1)
    end
end

--endregion

--region View

function UIGhostShipLeftMainPanel:RefreshText()
    if self.mapId == nil then
        return
    end
    local mapTbl = self:GetMapTable(self.mapId)
    self:GetMonsterName().text = mapTbl:GetName()
end

function UIGhostShipLeftMainPanel:RefreshTimeCount(time)
    self.time = time
    self.untilTime = gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp() + time
    self:GetCountFinal_GameObject():SetActive(true)
end

function UIGhostShipLeftMainPanel:RefreshTarget()
    local isHaveTarget = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetIsTarget()
    self:GetBtnCenter_GameObject():SetActive(isHaveTarget)
    self:GetHelp_GameObject():SetActive(not isHaveTarget)
end

function UIGhostShipLeftMainPanel:RefreshCount()
    local killAmount, helpAmount = gameMgr:GetPlayerDataMgr():GetLuaGhostShipMgr():GetRemainNum()
    local killTotal = tonumber(self:GetGlobalTable(23049))
    local helpTotal = tonumber(self:GetGlobalTable(23050))
    self:GetKillNum().text = (killAmount == 0 and luaEnumColorType.Red..killAmount or luaEnumColorType.Green3.. killAmount).."[-]/"..killTotal
    self:GetHelpNum().text = (helpAmount == 0 and luaEnumColorType.Red..helpAmount or luaEnumColorType.Green3.. helpAmount).."[-]/"..helpTotal
end

function UIGhostShipLeftMainPanel:RefreshGrid()
    local mapInfo = self:GetGlobalTable(23051)
    local mapData = string.Split(mapInfo, "&")
    local globaltbl
    for i = 1, #mapData do
        local map = string.Split(mapData[i], "#")
        if self.mapId == tonumber(map[1]) then
            globaltbl = tonumber(map[2])
        end
    end
    if globaltbl == nil then
        return
    end
    local itemInfo = self:GetGlobalTable(globaltbl)
    local itemData = string.Split(itemInfo, "&")
    self:RefreshMonsterShow(itemData[1])
    self:RefreshHelpShow(itemData[2])

end

function UIGhostShipLeftMainPanel:RefreshMonsterShow(data)
    if data == nil then
        return
    end
    local item = string.Split(data, "#")
    self.allGoAndTemplateDic = {}
    self:GetKillGrid().MaxCount = #item
    for i = 1, #item do
        local go = self:GetKillGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGhostShipLeftMainTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(item[i])
        end
    end
end

function UIGhostShipLeftMainPanel:RefreshHelpShow(data)
    if data == nil then
        return
    end
    local item = string.Split(data, "#")
    self.allGoAndTemplateDic = {}
    self:GetHelpGrid().MaxCount = #item
    for i = 1, #item do
        local go = self:GetHelpGrid().controlList[i - 1]
        if go then
            if self.allGoAndTemplateDic[go] == nil then
                self.allGoAndTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGhostShipLeftMainTemplate)
            end
            self.allGoAndTemplateDic[go]:SetTemplate(item[i])
        end
    end
end

--endregion

--region 获取table

function UIGhostShipLeftMainPanel:GetDropShowTable(id)
    if clientTableManager.cfg_monstersManager.GetDropShowList ~= nil then
        local dropList = clientTableManager.cfg_monstersManager:GetDropShowList(id)
        return dropList
    end
end

function UIGhostShipLeftMainPanel:GetGlobalTable(id)
    local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(id)
    return Lua_GlobalTABLE.value
end

function UIGhostShipLeftMainPanel:GetMapTable(id)
    local MapTbl = clientTableManager.cfg_mapManager:TryGetValue(id)
    return MapTbl
end

--endregion

--region Update

function update()
    UIGhostShipLeftMainPanel:OnUpdate()
end

function UIGhostShipLeftMainPanel:OnUpdate()
    if self.time then
        self:GetCountFinalLabel().text = math.ceil((self.untilTime - gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp()) / 1000)
        if self.untilTime - gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp() <= 0 then
            self.time = nil
            self:GetCountFinal_GameObject():SetActive(false)
        end
    end
end

--region ondestroy

function ondestroy()

end

--endregion

return UIGhostShipLeftMainPanel