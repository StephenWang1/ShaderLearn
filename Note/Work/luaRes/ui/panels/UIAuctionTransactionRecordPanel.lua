---@class UIAuctionTransactionRecordPanel:UIBase 交易记录界面
local UIAuctionTransactionRecordPanel = {}

UIAuctionTransactionRecordPanel.mChooseType = {
    [LuaEnumAuctionTransactionRecordType.All] = "全部",
    [LuaEnumAuctionTransactionRecordType.Sale] = "出售",
    [LuaEnumAuctionTransactionRecordType.Buy] = "购买",
    [LuaEnumAuctionTransactionRecordType.ShareSell] = "跨服出售",
    [LuaEnumAuctionTransactionRecordType.ShareBuy] = "跨服购买",
}

UIAuctionTransactionRecordPanel.mReqType = {
    [LuaEnumAuctionTransactionRecordType.All] = Utility.EnumToInt(CS.auctionV2.RecordType.ENTIRE),
    [LuaEnumAuctionTransactionRecordType.Sale] = Utility.EnumToInt(CS.auctionV2.RecordType.SELL),
    [LuaEnumAuctionTransactionRecordType.Buy] = Utility.EnumToInt(CS.auctionV2.RecordType.BUY),
    [LuaEnumAuctionTransactionRecordType.ShareSell] = Utility.EnumToInt(CS.auctionV2.RecordType.MOON_SELL),
    [LuaEnumAuctionTransactionRecordType.ShareBuy] = Utility.EnumToInt(CS.auctionV2.RecordType.MOON_BUY),
}

UIAuctionTransactionRecordPanel.mPerPage = 7

UIAuctionTransactionRecordPanel.mIsFirst = true;

--region 组件
---@return UnityEngine.GameObject 没有数据
function UIAuctionTransactionRecordPanel:GetNothingShow_GO()
    if self.mNothingShow == nil then
        self.mNothingShow = self:GetCurComp("ItemsArea/NoneTips", "GameObject")
    end
    return self.mNothingShow
end

---@return UILoopScrollViewPlus 数据loop
function UIAuctionTransactionRecordPanel:GetTransactionRecord_LoopScrollViewPlus()
    if self.mTransactionRecordLoop == nil then
        self.mTransactionRecordLoop = self:GetCurComp("ItemsArea/Scroll View/LoopScroll", "UILoopScrollViewPlus")
    end
    return self.mTransactionRecordLoop
end

---@return UnityEngine.GameObject 页签按钮
function UIAuctionTransactionRecordPanel:GetBookMarkBtn_Go()
    if self.mBookMarkBtn == nil then
        self.mBookMarkBtn = self:GetCurComp("Title/Details", "GameObject")
    end
    return self.mBookMarkBtn
end

---@return UIGridContainer 页签container
function UIAuctionTransactionRecordPanel:GetBookMark_GridContainer()
    if self.mBookMarkContainer == nil then
        self.mBookMarkContainer = self:GetCurComp("Title/Grid", "UIGridContainer")
    end
    return self.mBookMarkContainer
end

---@return UnityEngine.GameObject 关闭页签按钮
function UIAuctionTransactionRecordPanel:GetCloseBookMarkGo_Go()
    if self.mCloseBookMarkGo == nil then
        self.mCloseBookMarkGo = self:GetCurComp("Title/Grid/blackbox", "GameObject")
    end
    return self.mCloseBookMarkGo
end

function UIAuctionTransactionRecordPanel:GetDetailBookMark_UILabel()
    if self.mDetailLb == nil then
        self.mDetailLb = self:GetCurComp("Title/Details/CaptionLabel", "UILabel")
    end
    return self.mDetailLb
end
--endregion

--region 初始化
function UIAuctionTransactionRecordPanel:Init()
    self:BindEvents()
    self:BindMessage()
end

function UIAuctionTransactionRecordPanel:Show()
    self.mNeedJumpLine = true
    self:InitLoopScrollViewDatas()
    self:ShowBookMark(true, LuaEnumAuctionTransactionRecordType.All, true)
end

---初始化/重新刷新数据组件
function UIAuctionTransactionRecordPanel:InitLoopScrollViewDatas()
    self.mTransactionData = {}
    if self.mTransactionData == nil or #self.mTransactionData < 1 then
        self:GetNothingShow_GO():SetActive(true)
    end
    self.mMaxPage = 1
    self:ReqData(1)
    self:InitLoopScrollView()
end

function UIAuctionTransactionRecordPanel:InitLoopScrollView()
    if (self.mIsFirst) then
        self.mIsFirst = false;
        self:GetTransactionRecord_LoopScrollViewPlus():Init(function(go, line)
            return self:RefreshSingleItem(go, line)
        end, function(page)
            self:DataManage(page)
        end)
    else
        self:GetTransactionRecord_LoopScrollViewPlus():ResetPage();
    end
end

function UIAuctionTransactionRecordPanel:BindEvents()
    CS.UIEventListener.Get(self:GetBookMarkBtn_Go()).onClick = function()
        self:ShowBookMark(true)
    end
    CS.UIEventListener.Get(self:GetCloseBookMarkGo_Go()).onClick = function()
        self:ShowBookMark(false)
    end
end

function UIAuctionTransactionRecordPanel:BindMessage()
    ---@param csData auctionV2.TeadeRecordRes
    ---@param tblData auctionV2.TeadeRecordRes
    UIAuctionTransactionRecordPanel.OnResTradeRecordInfoMessageReceived = function(msgId, tblData, csData)
        self.mMaxPage = tblData.toatlPageCount
        self:GetNothingShow_GO():SetActive(self.mMaxPage <= 0)
        if csData.records then
            self.mTransactionData[tblData.page] = csData.records.record
        end
        local jumpLine = tblData.firstCanReceive
        if jumpLine ~= -1 and self.mNeedJumpLine and tblData.totalCount > self.mPerPage then
            self.mNeedJumpLine = false
            self:InitLoopScrollView()
            self:GetTransactionRecord_LoopScrollViewPlus():JumpToLine(jumpLine)
            self.mCurrentPage = math.ceil(jumpLine / self.mPerPage) + 1
        else
            self:GetTransactionRecord_LoopScrollViewPlus():RefreshCurrentPage()
        end
        if tblData.totalCount >= self.mPerPage then
            self:SuitLinePos(-1)
        else
            self:SuitLinePos(tblData.totalCount)
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResTradeRecordInfoMessage, UIAuctionTransactionRecordPanel.OnResTradeRecordInfoMessageReceived)

    UIAuctionTransactionRecordPanel.OnResReceiveTradeRecordMessageReceived = function()
        if self.mCurrentPage then
            self:ReqData(self.mCurrentPage + 1)
            self:ReqData(self.mCurrentPage)
            self:ReqData(self.mCurrentPage - 1)
        end
    end
    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResReceiveTradeRecordMessage, UIAuctionTransactionRecordPanel.OnResReceiveTradeRecordMessageReceived)
end

UIAuctionTransactionRecordPanel.NormalPos = CS.UnityEngine.Vector3.zero
function UIAuctionTransactionRecordPanel:SuitLinePos(num)
    if num == -1 then
        self:GetTransactionRecord_LoopScrollViewPlus().gameObject.transform.localPosition = self.NormalPos
    else
        local totalHeight = 462
        local singleLine = 68
        local pos = self.NormalPos
        pos.y = totalHeight - singleLine * num
        self:GetTransactionRecord_LoopScrollViewPlus().gameObject.transform.localPosition = pos
    end
end

--endregion

function UIAuctionTransactionRecordPanel:RefreshSingleItem(go, line)
    if self.mTransactionData then
        local info = self:GetLineData(line)
        if info then
            local template = self:GetGridTemplate(go)
            if template then
                template:RefreshGrid(info)
            end
            return true
        else
            return false
        end
    end
end

---@param line number
function UIAuctionTransactionRecordPanel:GetLineData(line)
    if self.mTransactionData then
        local page = math.floor(line / self.mPerPage) + 1
        local all = self.mTransactionData[page]
        local index = line % self.mPerPage
        if all and index < all.Count and index >= 0 then
            local info = all[index]
            return info
        end
    end
end

---@return UIAuctionTransactionRecordPanel_GridTemplate
function UIAuctionTransactionRecordPanel:GetGridTemplate(go)
    if CS.StaticUtility.IsNull(go) then
        return
    end
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionTransactionRecordPanel_GridTemplate, self)
        self.mGoToTemplate[go] = template
    end
    return template
end

---@return TABLE.CFG_ITEMS 缓存道具信息
function UIAuctionTransactionRecordPanel:GetItemInfo(id)
    if id == nil then
        return
    end
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[id]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mItemIdToInfo[id] = info
    end
    return info
end

function UIAuctionTransactionRecordPanel:ShowBookMark(isShow, chooseType, needClose)
    if self.mBookMarkBtnGo == nil then
        self.mBookMarkBtnGo = {}

        local count = Utility.IsOpenShareStall() and #self.mChooseType or #self.mChooseType - 1
        self:GetBookMark_GridContainer().MaxCount = count
        for i = 0, count - 1 do
            local type = i + 1
            local grid = self:GetBookMark_GridContainer().controlList[i]
            local lb = CS.Utility_Lua.Get(grid.transform, "CaptionLabel", "UILabel")
            local bookmark = self.mChooseType[type]
            lb.text = bookmark
            --            lb:UpdateAnchors()
            local toggle = CS.Utility_Lua.GetComponent(grid.transform, "UIToggle")
            self.mBookMarkBtnGo[type] = toggle
            CS.EventDelegate.Add(toggle.onChange, function()
                if toggle.value then
                    self:GetDetailBookMark_UILabel().text = bookmark
                    self.mCurrentChooseType = type
                end
            end)
            CS.UIEventListener.Get(grid).onClick = function()
                self:GetBookMark_GridContainer().gameObject:SetActive(false)
                self:InitLoopScrollViewDatas()
            end
        end
    end
    if chooseType ~= nil then
        ---@type UIToggle
        local toggle = self.mBookMarkBtnGo[chooseType]
        if toggle then
            toggle:Set(true)
        end
    end
    self:GetBookMark_GridContainer().gameObject:SetActive(isShow)
    if needClose then
        self:GetBookMark_GridContainer().gameObject:SetActive(false)
    end
end

---请求数据控制，缓存五页
function UIAuctionTransactionRecordPanel:DataManage(page)
    local realPage = page + 1
    local lineToPage = math.ceil(page / self.mPerPage) + 1
    self.mCurrentPage = lineToPage
    if self.mTransactionData == nil then
        self.mTransactionData = {}
    end
    if self.mTransactionData[realPage] == nil then
        self:ReqData(realPage)
    end
    if self.mTransactionData[realPage + 1] == nil then
        self:ReqData(realPage + 1)
    end
end

function UIAuctionTransactionRecordPanel:ReqData(page)
    local type = self.mReqType[self.mCurrentChooseType]
    if page > 0 and page <= self.mMaxPage then
        networkRequest.ReqTradeRecordInfo(type, page, self.mPerPage, 1)
    end
end

return UIAuctionTransactionRecordPanel
