---拍卖行背板模板
---@class UIAuctionPanel_BagPanel:luaobject
local UIAuctionPanel_BagPanel = {}

UIAuctionPanel_BagPanel.lineNum = 5

UIAuctionPanel_BagPanel.pageLine = 5

---@type table<number,boolean> lid对应选选中
UIAuctionPanel_BagPanel.LidToChoose = nil

---@type table<number,table<number,bagV2.BagItemInfo>> 每一行数据
UIAuctionPanel_BagPanel.LineToInfo = {}

---@param panel UIAuctionPanel
function UIAuctionPanel_BagPanel:Init(panel)
    self.AuctionPanel = panel
    self:InitComponent()
    self:InitData()
    self:InitLoopScrollViewPlus()
    self:AutoChooseItem()
end

function UIAuctionPanel_BagPanel:InitComponent()
    ---@type UILoopScrollViewPlus
    self.LoopScrollViewPlus = self:Get("ScrollView/bagController", "UILoopScrollViewPlus")
end

function UIAuctionPanel_BagPanel:InitData()
    ---开服天数
    self.OpenDays = self.AuctionPanel:GetPlayerInfo().ActualOpenDays
    ---@type table<number,UIBagPanel_GridTemplateBase> lid对应格子
    self.LidToTemplate = {}
end

---刷新背包显示
function UIAuctionPanel_BagPanel:RefreshList(type)
    if type then
        self.type = type
    end
    if CS.StaticUtility.IsNull(self.LoopScrollViewPlus) then
        return
    end
    self.LidToTemplate = {}
    self:GetLineInfo()
    self.LoopScrollViewPlus:RefreshCurrentPage()
end

---获取单行数据
function UIAuctionPanel_BagPanel:GetLineInfo()
    self.LineToInfo = {}
    local bagItemList = self:GetShowBagItemList(self.type)
    if bagItemList then
        local bagItemIndex = 0
        for i = 0, #bagItemList - 1 do
            local v = bagItemList[i + 1]
            local line = math.floor(bagItemIndex / self.lineNum)
            if self.LineToInfo[line] == nil then
                self.LineToInfo[line] = {}
            end
            table.insert(self.LineToInfo[line], v)
            bagItemIndex = bagItemIndex + 1
        end
    end
    return self.LineToInfo
end

function UIAuctionPanel_BagPanel:GetShowBagItemList(type)
    if self.AuctionPanel then
        local allBagItemList = self.AuctionPanel:GetBagInfoV2():GetBagItemList()
        if allBagItemList then
            local canShow = {}
            for i = 0, allBagItemList.Count - 1 do
                ---@type bagV2.BagItemInfo
                local bagItemInfo = allBagItemList[i]
                local id = bagItemInfo.itemId
                if id then
                    local isBind = self.AuctionPanel:GetPlayerInfo().ServerItemInfo:IsBindItem(bagItemInfo)
                    if not isBind then
                        if type == luaEnumAuctionPanelType.SelfSell then
                            if CS.CSServerItemInfo.CanYuanBaoDeal(id) or CS.CSServerItemInfo.CanDiamondDeal(id) then
                                table.insert(canShow, bagItemInfo)
                            end
                        elseif type == luaEnumAuctionPanelType.SelfAuction then
                            local canAuction = CS.CSServerItemInfo.CanAuctionDeal(id)
                            local canYuanBaoAuction = CS.CSServerItemInfo.CanYuanBaoAuctionDeal(id)
                            if canAuction or canYuanBaoAuction then
                                table.insert(canShow, bagItemInfo)
                            end
                        end
                    end
                end
            end
            return canShow
        end
    end
end

---判断物品是否可交易
function UIAuctionPanel_BagPanel:IsCanDeal(itemInfo)
    if self.type == luaEnumAuctionPanelType.SelfSell then
        if itemInfo.canDeal and self.OpenDays then
            for i = 0, itemInfo.canDeal.list.Count - 1 do
                local days = itemInfo.canDeal.list[i]
                if days.list[0] and days.list[1] and self.OpenDays >= days.list[0] and self.OpenDays <= days.list[1] then
                    return true
                end
            end
        end
    end
    return false
end

---判断物品是否可竞拍
function UIAuctionPanel_BagPanel:IsCanAuction(itemInfo)
    if self.type == luaEnumAuctionPanelType.SelfAuction and itemInfo.canAuction and itemInfo.canAuction == 1 then
        return true
    end
    return false
end

---刷新单行数据显示
function UIAuctionPanel_BagPanel:InitLine(item, data)
    local myData = data
    local rootTrans = item.transform
    if rootTrans then
        local container = CS.Utility_Lua.GetComponent(rootTrans:Find("GridContainer"), "UIGridContainer")
        if container then
            container.MaxCount = UIAuctionPanel_BagPanel.lineNum
            for i = 1, UIAuctionPanel_BagPanel.lineNum do
                local go = container.controlList[i - 1]
                if CS.StaticUtility.IsNull(go) == false then
                    ---@type UIBagPanel_GridTemplateBase
                    local template = self:GetBagGridTemplate(go)
                    if template then
                        if myData then
                            if i <= #myData then
                                template:RefreshUI(myData[i])
                                CS.UIEventListener.Get(go).onClick = function(go)
                                    self:ClickGrid(go)
                                end
                                local lid = myData[i].lid
                                self.LidToTemplate[lid] = template
                                if self.LidToChoose and self.type == luaEnumAuctionPanelType.SelfSell then
                                    template:SetItemChoose(self.LidToChoose[lid])
                                else
                                    template:SetItemChoose(false)
                                end
                            else
                                template:ResetUI()
                                CS.UIEventListener.Get(go).onClick = function(go)
                                end
                            end
                        else
                            template:ResetUI()
                            CS.UIEventListener.Get(go).onClick = function(go)
                            end
                        end
                    end
                end
            end
        end
    end
end

---@return UIBagPanel_GridTemplateBase
function UIAuctionPanel_BagPanel:GetBagGridTemplate(go)
    if not CS.StaticUtility.IsNull(go) then
        if self.mGoToTemplate == nil then
            self.mGoToTemplate = {}
        end
        local template = self.mGoToTemplate[go]
        if template == nil then
            template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBagPanel_GridTemplateBase, self)
            self.mGoToTemplate[go] = template
        end
        return template
    end
end

---点击格子
function UIAuctionPanel_BagPanel:ClickGrid(go)
    if self.mCurrentTime and CS.UnityEngine.Time.time - self.mCurrentTime < 1 then
        return
    end
    self.mCurrentTime = CS.UnityEngine.Time.time
    local template = self:GetBagGridTemplate(go)
    self:ClickItemByTemplate(template)
end

---根据模板选中格子
function UIAuctionPanel_BagPanel:ClickItemByTemplate(template)
    if template == nil then
        return
    end
    local bagItemInfo = template.BagItemInfo
    self:ClickItemByBagItemInfo(bagItemInfo)
end

---根据道具选中格子
function UIAuctionPanel_BagPanel:ClickItemByBagItemInfo(bagItemInfo)
    if bagItemInfo then
        luaEventManager.DoCallback(LuaCEvent.AuctionBagItemClicked, bagItemInfo)
        --如果点击的是当前推送道具则关闭选中
        if self.LidToChoose and self.LidToChoose[bagItemInfo.lid] then
            self:SetItemChoose(bagItemInfo.lid, false)
        end
    end
end

---设置格子选中
function UIAuctionPanel_BagPanel:SetItemChoose(lid, isChoose)
    if lid then
        local template = self.LidToTemplate[lid]
        if template then
            template:SetItemChoose(isChoose)
            if self.LidToChoose == nil then
                self.LidToChoose = {}
                self.LidToChoose[lid] = isChoose
            end
        end
    end
end

---初始化数据
function UIAuctionPanel_BagPanel:InitLoopScrollViewPlus()
    self.LoopScrollViewPlus:Init(function(go, line)
        local data = self.LineToInfo[line]
        if line < 6 or data ~= nil then
            self:InitLine(go, data)
            return true
        else
            return false
        end
    end)
end

function UIAuctionPanel_BagPanel:GetPreLineData(line)

end

--region 自动选中背包道具
function UIAuctionPanel_BagPanel:AutoChooseItem()
    if self.AuctionPanel == nil then
        return
    end
    local chooseInfo = self.AuctionPanel.mNeedChooseBagItem
    if chooseInfo == nil then
        return
    end
    self:ClickItemByBagItemInfo(chooseInfo)
    self.AuctionPanel.mNeedChooseBagItem = nil
end

--endregion

return UIAuctionPanel_BagPanel