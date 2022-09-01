---@class LuaBonfireInfo:luaobject 篝火信息
local LuaBonfireInfo = {}

--region 篝火喝酒推送
---正常应该在篝火移除时删除对应数据，但是不想监听视野包，篝火存在时间也不会太长，直接按超出最大数目时进行删除
LuaBonfireInfo.pushDataMax = 50
LuaBonfireInfo.allPushLid = nil
LuaBonfireInfo.WineItemId = 8330001

function LuaBonfireInfo:TryAddPromptPushWine(lid)
    if self:GetBonfirePushState(lid) then
        return
    end
    local pushState = self:PushBonfireWine()
    if pushState == false then
        return
    end
    self:AddBonfirePushWine(lid)
end

---获得篝火推送状态（同一个篝火只推送一次）
function LuaBonfireInfo:GetBonfirePushState(lid)
    if self.mLidToBonfirePushState == nil then
        self.mLidToBonfirePushState = {}
    end
    local state = self.mLidToBonfirePushState[lid]
    if state == nil then
        state = false
        self.mLidToBonfirePushState[lid] = state
    end
    return state
end

---改变推送状态
function LuaBonfireInfo:AddBonfirePushWine(lid)
    if self.mLidToBonfirePushState == nil then
        self.mLidToBonfirePushState = {}
    end
    if self.allPushLid == nil then
        self.allPushLid = {}
    end
    self.mLidToBonfirePushState[lid] = true
    table.insert(self.allPushLid, lid)
    if #self.allPushLid > self.pushDataMax then
        local firstLid = self.allPushLid[1]
        self.mLidToBonfirePushState[firstLid] = nil
        table.remove(self.allPushLid, 1)
    end
end

---推送篝火喝酒
---@return boolean 推送状态
function LuaBonfireInfo:PushBonfireWine()
    local wineBagItemInfo = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetBagItemInfoByItemId(self.WineItemId)
    if wineBagItemInfo == nil then
        return false
    end

    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.WineItemId)
    if itemInfo == nil then
        return false
    end

    local conditionState = Utility.IsMainPlayerMatchConditionList_OR(LuaGlobalTableDeal.DrinkWineHintConditionIdList()).success
    if conditionState == true then
        return false
    end

    local tbl = {}
    tbl.PromptWordId = 152
    tbl.iconSpriteName = itemInfo.icon
    tbl.ComfireAucion = function()
        local uiBonfirePanel = uimanager:GetPanel("UIBonfirePanel")
        if uiBonfirePanel ~= nil then
            uiBonfirePanel.mCurrentTime = CS.UnityEngine.Time.time
        end
        networkRequest.ReqUseItem(1, wineBagItemInfo.lid)
    end
    tbl.IconClickCallBack = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
    end

    Utility.ShowSecondConfirmPanel(tbl)
    return true
end
--endregion

function LuaBonfireInfo:OnDestroy()
    self.mLidToBonfirePushState = nil
end

return LuaBonfireInfo