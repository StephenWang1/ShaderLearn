---@class UIHighRecycleGrid:UIBagTypeGrid
local UIHighRecycleGrid = {}

setmetatable(UIHighRecycleGrid, luaComponentTemplates.UIBagType_Grid)

---是否是服务器物品,服务器物品有不同的数据结构
UIHighRecycleGrid.mIsServerItem = false

---重写组件
UIHighRecycleGrid.Components = {}
UIHighRecycleGrid.Components.BackGround = "bg"
UIHighRecycleGrid.Components.Icon = "icon"
UIHighRecycleGrid.Components.Count = "count"
UIHighRecycleGrid.Components.TimeCount = "timecount"
UIHighRecycleGrid.Components.RedeemSign = "redeemsign"

function UIHighRecycleGrid:RefreshSingleGrid(bagItemInfo, itemTbl)
    self.mIsServerItem = false
    self:SetCompSpriteName(self.Components.Icon, itemTbl.icon)
    if bagItemInfo.leftUseNum > 1 then
        self:SetCompLabelContent(self.Components.Count, bagItemInfo.leftUseNum)
    else
        self:SetCompLabelContent(self.Components.Count, (bagItemInfo.count <= 1) and "" or bagItemInfo.count)
    end
end

---使用服务器物品刷新
---@param serverItem table 服务器物品数据结构
---@param isLocked boolean 是否锁住
function UIHighRecycleGrid:RefreshServerItem(serverItem, isLocked)
    self.mIsRefreshing = true
    self.mIsServerItem = true
    self.mBagItemInfo = nil
    self.mItemTbl = nil
    self.mIsLocked = isLocked
    if isLocked then
        self:BindInteractionEvents(false)
        self:Clear(true)
    else
        self:Clear(false)
        self:BindInteractionEvents(true)
        ---此处写根据服务器数据绘制icon的行动
        self.mBagItemInfo = serverItem
        self.mItemTbl = serverItem.ItemTABLE
        if serverItem.ItemTABLE ~= nil then
            self:SetCompSpriteName(self.Components.Icon, serverItem.ItemTABLE.icon)
        end
        self:SetCompActive(self.Components.RedeemSign, true)
        self:SetCompLabelContent(self.Components.Count, (serverItem.count <= 1) and "" or serverItem.count)
        self:SetCompActive(self.Components.TimeCount, true)
        if serverItem.FinishRedeemTimeStamp ~= nil then
            local data = self:GetCompTbl(self.Components.TimeCount, false)
            if data ~= nil then
                ---@type UICountdownLabel
                local uiCountdownLabel = self:GetCurComp(data.go, "", "UICountdownLabel")
                if uiCountdownLabel ~= nil then
                    if serverItem.time ~= 0 then
                        uiCountdownLabel:StartCountDown(0.25, 4, serverItem.FinishRedeemTimeStamp, "[bb3520]", "[-]", self, self.OnCountDownFinished)
                    else
                        uiCountdownLabel:StopCountDown()
                        uiCountdownLabel._Label.text = ""
                    end
                end
            end
        end
        ---到此处结束
        self:ApplyAllPropertyChanges()
    end
    self.mIsRefreshing = false
end

function UIHighRecycleGrid:OnCountDownFinished(countDownLabel)
    if CS.StaticUtility.IsNull(self.go) ~= nil and self:GetRelyPanel() ~= nil then
        self:GetRelyPanel():OnCountDownFinished()
    end
end

return UIHighRecycleGrid