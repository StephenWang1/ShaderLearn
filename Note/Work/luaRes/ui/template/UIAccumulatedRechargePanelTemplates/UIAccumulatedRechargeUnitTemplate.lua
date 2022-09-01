---@class UIAccumulatedRechargeUnitTemplate:TemplateBase 累计充值活动单元
local UIAccumulatedRechargeUnitTemplate = {}

--region 组件
---@return UILabel
function UIAccumulatedRechargeUnitTemplate:GetRefresh_Lb1()
    if self.mRefreshLb1 == nil then
        self.mRefreshLb1 = self:Get("rechargeNum/lb_recharge", "UILabel")
    end
    return self.mRefreshLb1
end

---@return UILabel
function UIAccumulatedRechargeUnitTemplate:GetRefresh_Lb2()
    if self.mRefreshLb2 == nil then
        self.mRefreshLb2 = self:Get("rechargeNum/lb_yuan", "UILabel")
    end
    return self.mRefreshLb2
end
--endregion


--region 初始化

function UIAccumulatedRechargeUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIAccumulatedRechargeUnitTemplate:InitParameters()
    self.cumActivityId = 0
    ---@type TABLE.cfg_cum_recharge
    self.cumActivityTbl = nil
    ---@type LuaSpecailActivityRewardState
    self.rewardState = 0
    self.allTemplateByRewardGoTbl = {}
    self.strFormat = "累充%d元"
end

function UIAccumulatedRechargeUnitTemplate:InitComponents()
    ---@type Top_UISprite 背景
    self.bg = self:Get("di", "Top_UISprite")
    ---@type Top_UILabel 描述
    self.des = self:Get("rechargeNum/num", "Top_UILabel")
    ---@type UnityEngine.GameObject 额外奖励
    self.otherReward = self:Get("otherReward", "GameObject")
    ---@type Top_UIGridContainer 奖励
    self.rewardGrid = self:Get("AwardScroll/AwardGrid", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 已领取
    self.geted = self:Get("geted", "GameObject")
    ---@type UnityEngine.GameObject 未达成
    self.notGet = self:Get("Notgeted", "GameObject")
    ---@type UnityEngine.GameObject 按钮
    self.getBtn = self:Get("btn_get", "GameObject")
end

function UIAccumulatedRechargeUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.getBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.getBtn).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region Show

---@param data table
---@alias{missionData:rechargeV2.Reward ,amount:number }
function UIAccumulatedRechargeUnitTemplate:SetTemplate(data)
    if data == nil or data.missionData == nil then
        return
    end
    self.cumActivityId = data.missionData.id
    self.rewardState = data.missionData.state
    self.amount = data.amount
    self:RefreshData()
    self:RefreshView()
end

--endregion


--region UI函数监听

function UIAccumulatedRechargeUnitTemplate:OnGetBtnClick(go)
    if self.rewardState == LuaSpecailActivityRewardState.Get then
        networkRequest.ReqReceiveCumRecharge(self.cumActivityId)
    end
end
--endregion

--region View

---刷新视图
function UIAccumulatedRechargeUnitTemplate:RefreshView()
    if self.cumActivityTbl == nil then
        return
    end
    self:RefrshMainView()
    self:RefreshBtnView()
    self:RefreshRewardView()
end

function UIAccumulatedRechargeUnitTemplate:RefrshMainView()
    if self.cumActivityTbl:GetRechargePoint() and self.des then
        self.des.text = LuaGlobalTableDeal:GetRMBToRechargeDiamondRate(self.cumActivityTbl:GetRechargePoint())
        self:GetRefresh_Lb1():UpdateAnchors()
        self:GetRefresh_Lb2():UpdateAnchors()
    end
end

---刷新奖励视图UIAccumulatedRechargePanel
function UIAccumulatedRechargeUnitTemplate:RefreshRewardView()
    local rewardList = clientTableManager.cfg_cum_rechargeManager:GetReward(self.cumActivityId)
    self.rewardGrid.MaxCount = #rewardList
    for i = 1, #rewardList do
        local go = self.rewardGrid.controlList[i - 1]
        ---@type UIItem
        local template = self.allTemplateByRewardGoTbl[go]
        if rewardList[i] ~= ni then
            local rewardInfo = rewardList[i]
            if template == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                self.allTemplateByRewardGoTbl[go] = template
            end
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
            if isFind then
                template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
                template:RefreshOtherUI({ showItemInfo = itemInfo })
            end

            if template:GetResSprite_UISprite() ~= nil and not CS.StaticUtility.IsNull(template:GetResSprite_UISprite()) then
                template:GetResSprite_UISprite().gameObject:SetActive(i == 1 and self.rewardState ~= LuaSpecailActivityRewardState.Geted)
            end
        end
    end
end

---刷新按钮视图
function UIAccumulatedRechargeUnitTemplate:RefreshBtnView()
    self.getBtn:SetActive(self.rewardState == LuaSpecailActivityRewardState.Get)
    self.geted:SetActive(self.rewardState == LuaSpecailActivityRewardState.Geted)
    self.notGet:SetActive(self.rewardState == LuaSpecailActivityRewardState.NotGet)
end


--endregion


--region otherFunction
function UIAccumulatedRechargeUnitTemplate:RefreshData()
    self.cumActivityTbl = clientTableManager.cfg_cum_rechargeManager:TryGetValue(self.cumActivityId)
end

--endregion

--region ondestroy

function UIAccumulatedRechargeUnitTemplate:onDestroy()

end

--endregion

return UIAccumulatedRechargeUnitTemplate