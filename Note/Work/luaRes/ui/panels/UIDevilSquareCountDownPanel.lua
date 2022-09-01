---@class UIDevilSquareCountDownPanel:UIBase
local UIDevilSquareCountDownPanel = {}

---@return Top_UILabel 地图名字
function UIDevilSquareCountDownPanel:GetLb_MapName()
    if self.mLb_MapName == nil then
        self.mLb_MapName = self:GetCurComp("WidgetRoot/Desc", "Top_UILabel")
    end
    return self.mLb_MapName
end

--region 组件
---@return UnityEngine.GameObject 剩余时间
function UIDevilSquareCountDownPanel:GetCountDownTimeLabel()
    if self.mGetCountDownTimeLabel == nil then
        self.mGetCountDownTimeLabel = self:GetCurComp("WidgetRoot/CountDownLabel", "UICountdownLabel")
    end
    return self.mGetCountDownTimeLabel
end

---@return UnityEngine.GameObject 剩余时间
function UIDevilSquareCountDownPanel:GetBtn_AddTime()
    if self.mBtn_Add == nil then
        self.mBtn_Add = self:GetCurComp("WidgetRoot/add", "GameObject")
    end
    return self.mBtn_Add
end

--region  初始化
function UIDevilSquareCountDownPanel:Init()
    self:InitData()
    UIDevilSquareCountDownPanel.OnCallBackUpdateDevilEndTime();
    CS.UIEventListener.Get(self:GetBtn_AddTime()).onClick = UIDevilSquareCountDownPanel.OnClickBtn_AddTime
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.UpdateDevilEndTime, UIDevilSquareCountDownPanel.OnCallBackUpdateDevilEndTime)
end

function UIDevilSquareCountDownPanel:InitData()
    local id = CS.CSScene:getMapID()
    local isfind, dupinfo = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(id)
    self.dupinfo = dupinfo
end

function UIDevilSquareCountDownPanel:Show()
    if (self:GetLb_MapName() ~= nil and self.dupinfo ~= nil) then
        self:GetLb_MapName().text = self.dupinfo.name
    end
end

function ondestroy()
    uimanager:ClosePanel('UIDisposeOrePanel')
    uimanager:ClosePanel('UIFurnaceWayAndBuyPanel')
end
--endregion

function UIDevilSquareCountDownPanel.OnCallBackUpdateDevilEndTime()
    local DevilEndTime = 0;
    if (UIDevilSquareCountDownPanel.dupinfo) then
        DevilEndTime = Utility.GetCopyEndTimestamp(UIDevilSquareCountDownPanel.dupinfo.type)
    end
    ---倒计时开始  1s执行一次UIDevilSquareCountDownPanel.OnCallBackCountDownTimeLabel方法
    UIDevilSquareCountDownPanel:GetCountDownTimeLabel():StartCountDownUpdate(1000, 3, DevilEndTime, "[e85038]", "", nil, nil, UIDevilSquareCountDownPanel.OnCallBackCountDownTimeLabel)
end

---倒计时每秒执行1次
function UIDevilSquareCountDownPanel.OnCallBackCountDownTimeLabel(parm, componet)
    if (UIDevilSquareCountDownPanel:GetBtn_AddTime() == nil) then
        return ;
    end
    local isFliker = LuaGlobalTableDeal.IsTimeNeedFlickerAddSign(componet.LastingTimeSecond)
    if isFliker then
        if (UIDevilSquareCountDownPanel:GetBtn_AddTime().activeSelf == false) then
            UIDevilSquareCountDownPanel:GetBtn_AddTime():SetActive(true)
        end
    else
        if (UIDevilSquareCountDownPanel:GetBtn_AddTime().activeSelf == true) then
            UIDevilSquareCountDownPanel:GetBtn_AddTime():SetActive(false)
        end
    end
end

---恶魔广场门票ID
UIDevilSquareCountDownPanel.MenPiao = 6200001

---当时间小于10分钟的时候,显示+号  这个时候的点击事件
function UIDevilSquareCountDownPanel.OnClickBtn_AddTime()
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIDevilSquareCountDownPanel.MenPiao)
    if count == 0 then
        Utility.ShowItemGetWay(UIDevilSquareCountDownPanel.MenPiao, UIDevilSquareCountDownPanel:GetBtn_AddTime(), LuaEnumWayGetPanelArrowDirType.Left);
    else
        UIDevilSquareCountDownPanel.ShowDisposeOrePanel(count)
    end
end

---显示使用道具面板
function UIDevilSquareCountDownPanel.ShowDisposeOrePanel(count)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local maxCount = count
    local info = {}
    info.itemid = UIDevilSquareCountDownPanel.MenPiao
    info.price = 0
    info.minValue = 1
    info.maxValue = maxCount == 0 and 1 or maxCount
    info.curValue = maxCount == 0 and 1 or maxCount
    info.isDesprice = true
    info.IsShowItemTips = true
    info.rightBtnLabel = '使用'
    info.rightBtnCallBack = function(panel)
        if panel then
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(UIDevilSquareCountDownPanel.MenPiao)
            local type = UIDevilSquareCountDownPanel.dupinfo == nil and 0 or UIDevilSquareCountDownPanel.dupinfo.type
            networkRequest.ReqUseItem(panel.num, itemInfo.lid, type)
            local Numnber = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIDevilSquareCountDownPanel.MenPiao)
            if Numnber <= panel.num then
                uimanager:ClosePanel('UIDisposeOrePanel')
            end
        end
    end
    uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end

return UIDevilSquareCountDownPanel