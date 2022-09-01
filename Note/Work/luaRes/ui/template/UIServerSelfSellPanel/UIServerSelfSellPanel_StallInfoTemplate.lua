---@class UIServerSelfSellPanel_StallInfoTemplate:UIAuctionPanel_StallInfo 跨服摆摊信息模板
local UIServerSelfSellPanel_StallInfoTemplate = {}

setmetatable(UIServerSelfSellPanel_StallInfoTemplate, luaComponentTemplates.UIAuctionPanel_StallInfo)

function UIServerSelfSellPanel_StallInfoTemplate:InitCompoment()
    self:RunBaseFunction('InitCompoment')
    ---@type UnityEngine.GameObject
    self.addBtn = self:Get("Time/addBtn", "GameObject")

    self.addBtn:SetActive(true)
end

function UIServerSelfSellPanel_StallInfoTemplate:BindEvent()
    self:RunBaseFunction('BindEvent')
    self.ClickAddCallBack = function(go)
        self:OnClickAddBtnCallBack(go)
    end

    CS.UIEventListener.Get(self.addBtn).onClick = self.ClickAddCallBack
end

function UIServerSelfSellPanel_StallInfoTemplate:OnClickStallBtnCallBack(go)
    local boothInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.BoothInfo
    if boothInfo == nil then
        self:GetChooseListTable()
        if self:IsCanCreateBooth(self.chooseTable.stallCost) then
            if CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId == 0 then
                Utility.ShowPopoTips(go.transform, nil, 264)
                return
            end
            networkRequest.ReqCreateMoonBooth(self.chooseTable.name, self.chooseTable.stallCost, CS.CSScene.MainPlayerInfo.AuctionInfo.NoBoothPositionInfo.boothCoordinateId)
        end
    else
        networkRequest.ReqCancelBooth(1)
    end
end

function UIServerSelfSellPanel_StallInfoTemplate:OnBoothPositionChangeCallBack()
    local position = CS.CSScene.MainPlayerInfo.AuctionInfo.newBoothPosition
    if CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo == nil or CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo.boothCoordinateId == 0 then
        Utility.ShowPopoTips(self.RefreshPositionBtn.transform, nil, 264)
        return
    end
    Utility.ShowSecondConfirmPanel({ PromptWordId = 66, des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(66, Utility.GetIntPart(position.x), Utility.GetIntPart(position.y)), ComfireAucion = function()
        networkRequest.ReqUpdateBoothPoint(CS.CSScene.MainPlayerInfo.AuctionInfo.HaveBoothPositionInfo.boothCoordinateId, 1)
    end })
end

function UIServerSelfSellPanel_StallInfoTemplate:OnClickAddBtnCallBack(go)
    local targetId = 6750001
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(targetId)
    if count == 0 then
        Utility.ShowItemGetWay(targetId, go, LuaEnumWayGetPanelArrowDirType.Down);
    else
        self:ShowDisposeOrePanel(count, targetId)
    end
end

function UIServerSelfSellPanel_StallInfoTemplate:RefreshStallInfoTemplate(hasStall, chooseTable)
    self:RunBaseFunction('RefreshStallInfoTemplate', hasStall, chooseTable)
    self.itemgold_UILabel.gameObject:SetActive(false)
    if hasStall then
        return
    end
    ---未摆摊时显示摊位时间
    local endTime = CS.CSScene.MainPlayerInfo.AuctionInfo.ShareMoonBoothEndTime * 1000
    local remainTime = endTime - CS.CSServerTime.Instance.TotalMillisecond

    if remainTime <= 0 and self.Time_MultitermChooseTemplate then
        self.Time_MultitermChooseTemplate:SetTitleName("剩余时间不足（需使用摆摊令）")
    else
        self:RreshEndTime()
        --[[        local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
                local str = Utility.GetIntPart(hour) .. "小时" .. Utility.GetIntPart(minute) .. "分" .. Utility.GetIntPart(second) .. "秒"
                self.Time_MultitermChooseTemplate:SetTitleName(str)]]
    end
    self.Time_MultitermChooseTemplate:SetBtnsState(false)
    self.Time_MultitermChooseTemplate:SetTitleState(true)
end

---刷新时间
function UIServerSelfSellPanel_StallInfoTemplate:RreshTitleInfoTime()
    self:StopRefreshEndTime()
    self:RunBaseFunction('RreshTitleInfoTime')
end

--region 摆摊令时间
function UIServerSelfSellPanel_StallInfoTemplate:RreshEndTime()
    local refreshEndTime = function()
        local endTime = CS.CSScene.MainPlayerInfo.AuctionInfo.ShareMoonBoothEndTime * 1000
        local remainTime = endTime - CS.CSServerTime.Instance.TotalMillisecond
        while remainTime > 0 do
            local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
            local str = Utility.GetIntPart(hour) .. "小时" .. Utility.GetIntPart(minute) .. "分" .. Utility.GetIntPart(second) .. "秒"
            self.Time_MultitermChooseTemplate:SetTitleName(str)
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
            remainTime = endTime - CS.CSServerTime.Instance.TotalMillisecond
        end
    end
    self:StopRefreshEndTime()
    self:StopRefreshTitleInfoTime()
    UIServerSelfSellPanel_StallInfoTemplate.RefreshEndTime = StartCoroutine(refreshEndTime)
end

function UIServerSelfSellPanel_StallInfoTemplate:StopRefreshEndTime()
    if UIServerSelfSellPanel_StallInfoTemplate.RefreshEndTime ~= nil then
        StopCoroutine(UIServerSelfSellPanel_StallInfoTemplate.RefreshEndTime)
        UIServerSelfSellPanel_StallInfoTemplate.RefreshEndTime = nil
    end
end

--endregion

---显示使用道具面板
function UIServerSelfSellPanel_StallInfoTemplate:ShowDisposeOrePanel(count, targetId)
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.DuplicateV2 == nil then
        return
    end
    local maxCount = count
    local info = {}
    info.itemid = targetId
    info.price = 0
    info.minValue = 1
    info.maxValue = maxCount == 0 and 1 or maxCount
    info.curValue = maxCount == 0 and 1 or maxCount
    info.isDesprice = true
    info.IsShowItemTips = true
    info.rightBtnLabel = '使用'
    info.rightBtnCallBack = function(panel)
        if panel then
            local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(targetId)
            networkRequest.ReqUseItem(panel.num, itemInfo.lid, 1)
            --local Numnber = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(targetId)
            --if Numnber <= panel.num then
            uimanager:ClosePanel('UIDisposeOrePanel')
            --end
        end
    end
    uimanager:CreatePanel("UIDisposeOrePanel", nil, info)
end

function UIServerSelfSellPanel_StallInfoTemplate:OnDestroy()
    self:StopRefreshTitleInfoTime()
    networkRequest.ReqChangeBoothName(self:GetNameList(), 1)
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_RefreshBoothPosition, self.RefreshBoothPosition)
    self:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BoothPositionChange, self.BoothPositionChange)
end

return UIServerSelfSellPanel_StallInfoTemplate