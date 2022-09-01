---@class UIGuildBossResultPanel 行会首领的结果面板
local UIGuildBossResultPanel = {}

--region 组件
---@return Top_UIGridContainer
function UIGuildBossResultPanel:GetRewardList()
    if self.mGetRewardList == nil then
        self.mGetRewardList = self:GetCurComp("WidgetRoot/view/win/Scroll/rewardList", "Top_UIGridContainer")
    end
    return self.mGetRewardList
end

---@return GameObject
function UIGuildBossResultPanel:GetBtn_Auction()
    if self.mGetBtn_Auction == nil then
        self.mGetBtn_Auction = self:GetCurComp("WidgetRoot/view/win/btn_Auction", "GameObject")
    end
    return self.mGetBtn_Auction
end

---胜利界面组件
function UIGuildBossResultPanel:GetWinRoot()
    if self.mGetWinRoot == nil then
        self.mGetWinRoot = self:GetCurComp("WidgetRoot/view/win", "GameObject")
    end
    return self.mGetWinRoot
end

---失败界面组件
function UIGuildBossResultPanel:GetLoseRoot()
    if self.mGetLoseRoot == nil then
        self.mGetLoseRoot = self:GetCurComp("WidgetRoot/view/lose", "GameObject")
    end
    return self.mGetLoseRoot
end

---失败界面组件
function UIGuildBossResultPanel:GetBtnExit()
    if self.mGetBtnExit == nil then
        self.mGetBtnExit = self:GetCurComp("WidgetRoot/view/lose/btn_exit", "GameObject")
    end
    return self.mGetBtnExit
end

--endregion

function UIGuildBossResultPanel:Init()

    CS.UIEventListener.Get(self:GetBtn_Auction()).onClick = function()
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Auction_Union, nil, nil)
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetBtnExit()).onClick = function()
        self:ClosePanel()
    end
end

---@param tblData activityV2.TheActivityHasRewarded 奖励列表table类型
function UIGuildBossResultPanel:Show(tblData)
    if(tblData.success) then
        self:GetWinRoot():SetActive(true);
        self:GetLoseRoot():SetActive(false);
        self:RefreshRewardList(tblData.rewards)
    else
        self:GetWinRoot():SetActive(false);
        self:GetLoseRoot():SetActive(true);
    end
end

---@param data table<number, activityV2.ActivityRewards> 奖励列表table类型
function UIGuildBossResultPanel:RefreshRewardList(data)
    local rewardItemIdList = self:PastData(data)
    if not CS.StaticUtility.IsNull(self:GetRewardList()) and rewardItemIdList then
        self:GetRewardList().MaxCount = #rewardItemIdList

        for i = 0, self:GetRewardList().controlList.Count - 1 do
            local go = self:GetRewardList().controlList[i]
            self:RefreshSingleGrid(go, rewardItemIdList[i + 1])
        end
    end
end


function UIGuildBossResultPanel:PastData(rewardItemIdList)
    if rewardItemIdList == nil then
        return {}
    end
    local tbl = {}
    if rewardItemIdList.Count == nil then
        for k, v in pairs(rewardItemIdList) do
            if v.count ~= nil and v.count ~= 0 then
                self:InsertAutoUseBoxItem(tbl, v)
            end
        end
    else
        for i = 0, rewardItemIdList.Count - 1 do
            if rewardItemIdList[i].count ~= nil and rewardItemIdList[i].count ~= 0 then
                self:InsertAutoUseBoxItem(tbl, rewardItemIdList[i])
            end
        end
    end

    table.sort(tbl, self.Sort)
    return tbl
end


---插入自动使用宝箱的里面的内容道具
function UIGuildBossResultPanel:InsertAutoUseBoxItem(tbl, item)
    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(item.itemId)
    if res then
        if itemInfo.autouse and itemInfo.autouse == 1 then
            local rewardList = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(item.itemId);
            if rewardList then
                for i = 0, rewardList.Count - 1 do
                    table.insert(tbl, rewardList[i])
                end
            end
        else
            table.insert(tbl, item)
        end
    end
end


function UIGuildBossResultPanel.Sort(a, b)
    if a == nil or b == nil then
        return false
    end

    local aCount = 0
    local bCount = 0
    local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(a.itemId)
    if boxInfo then
        aCount = boxInfo.count
    else
        ---普通道具
        aCount = a.count
    end
    boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(b.itemId)
    if boxInfo then
        bCount = boxInfo.count
    else
        ---普通道具
        bCount = b.count
    end
    local isAFind, aItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(a.itemId)
    local isBFind, bItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(b.itemId)
    if isAFind and isBFind then
        if aItemInfo.type ~= bItemInfo.type then
            return aItemInfo.type < bItemInfo.type
        elseif aItemInfo.subType ~= bItemInfo.subType then
            return aItemInfo.subType < bItemInfo.subType
        end
    end
    return aCount < bCount
end

---刷新单个格子(仅显示图片)
---@param go UnityEngine.GameObject 单个格子
---@param item activityV2.ActivityRewards itemId
function UIGuildBossResultPanel:RefreshSingleGrid(go, item)
    if item then
        local itemId = item.itemId
        local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(item.itemId)
        if res then
            if itemInfo.autouse and itemInfo.autouse == 1 then
                local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(item.itemId)
                if boxInfo then
                    itemId = boxInfo.itemId
                    ---替换宝箱
                    local res, boxItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(boxInfo.itemId)
                    if res then
                        self:ShowItemInfo(boxItemInfo, boxInfo.count, go)
                    end
                else
                    ---普通道具
                    local num = item.count
                    self:ShowItemInfo(itemInfo, num, go)
                end
            else
                ---普通道具
                local num = item.count
                self:ShowItemInfo(itemInfo, num, go)
            end
        end
        if (UIGuildBossResultPanel.mItemToGoTempDic == nil) then
            UIGuildBossResultPanel.mItemToGoTempDic = {};
        end
        UIGuildBossResultPanel.mItemToGoTempDic[go] = itemId;
    end
end

---刷新单个格子显示
---@param info TABLE.CFG_ITEMS 道具信息
---@param num number 数目
---@param go UnityEngine.GameObject 格子
function UIGuildBossResultPanel:ShowItemInfo(info, num, go)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = info.icon
    end

    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(count) then
        local showNum = ternary(num <= 1, "", num)
        count.text = showNum
    end

    CS.UIEventListener.Get(icon.gameObject).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
    end
end

return UIGuildBossResultPanel