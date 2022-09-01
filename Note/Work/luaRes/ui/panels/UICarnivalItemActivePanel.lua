---@class UICarnivalItemActivePanel:UIBase 狂欢派对充值解锁
local UICarnivalItemActivePanel = {}

UICarnivalItemActivePanel.cardID = 139

--region 组件
---@return UIGridContainer 奖励列表
function UICarnivalItemActivePanel:GetRewardContainer_UIGridContainer()
    if self.mRewardContainer == nil then
        self.mRewardContainer = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/active/Scroll/rewardlist", "UIGridContainer")
    end
    return self.mRewardContainer
end

---@return UnityEngine.GameObject 关闭按钮
function UICarnivalItemActivePanel:GetCloseBtn_Go()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 充值按钮
function UICarnivalItemActivePanel:GetRechargeBtn()
    if self.mRechargeBtn == nil then
        self.mRechargeBtn = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn", "GameObject")
    end
    return self.mRechargeBtn
end

---@return UILabel
function UICarnivalItemActivePanel:GetRechargeBtn_Lb()
    if self.mRechargeBtnLb == nil then
        self.mRechargeBtnLb = self:GetCurComp("WidgetRoot/view/ActiveHunterPanel/Btn/Label", "UILabel")
    end
    return self.mRechargeBtnLb
end

---@return  TABLE.CFG_RECHARGE 充值信息
function UICarnivalItemActivePanel:GetChargeInfo()
    if self.mChargeInfo == nil then
        ___, self.mChargeInfo = CS.Cfg_RechargeTableManager.Instance.dic:TryGetValue(self.cardID)
    end
    return self.mChargeInfo
end
--endregion

--region 初始化
function UICarnivalItemActivePanel:Init()
    self:BindEvents()
    if self:GetChargeInfo() then
        self:GetRechargeBtn_Lb().text = "￥" .. math.ceil(self:GetChargeInfo().rmb / 100)
    end
end

function UICarnivalItemActivePanel:Show(rewardList)
    self:ShowAllReward(rewardList)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.Carnival
end

function UICarnivalItemActivePanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_Go()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetRechargeBtn()).onClick = function()
        if (self:GetChargeInfo() ~= nil) then
            --[[            if (CS.CSVersionMgr.Instance.ServerVersion.OpenRecharge) then
                            if CS.CSGameState.RunPlatform == CS.ERunPlatform.Editor or CS.CSGameState.RunPlatform == CS.ERunPlatform.AndroidEditor then
                                networkRequest.ReqGM("@43 " .. tostring(self:GetChargeInfo().id))
                            else
                                local data = Utility:GetPayData(self:GetChargeInfo())
                                if (data ~= nil) then
                                    uiStaticParameter.RechargePoint = LuaEnumRechargePointType.CarnivalToRecharge
                                    CS.SDKManager.GameInterface:Pay(data:GetPayParams())
                                end
                            end
                        end]]
            local luaRechargeInfo = clientTableManager.cfg_rechargeManager:TryGetValue(self.cardID)
            if luaRechargeInfo then
                Utility.PayRechargeItem(luaRechargeInfo)
            end
        end
        self:ClosePanel()
    end
end

function UICarnivalItemActivePanel:ShowAllReward(rewardList)
    if rewardList == nil or #rewardList < 0 then
        return
    end
    self:GetRewardContainer_UIGridContainer().MaxCount = #rewardList
    for i = 0, self:GetRewardContainer_UIGridContainer().controlList.Count - 1 do
        local go = self:GetRewardContainer_UIGridContainer().controlList[i]
        ---@type UISprite
        local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
        ---@type UILabel
        local num = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
        ---@type CarnivalRewardInfo
        local data = rewardList[i + 1]
        if data then
            local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(data.itemId)
            if res then
                icon.spriteName = itemInfo.icon
                CS.UIEventListener.Get(icon.gameObject).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                end
            end
            num.text = data.num
        end
    end
end
--endregion

return UICarnivalItemActivePanel