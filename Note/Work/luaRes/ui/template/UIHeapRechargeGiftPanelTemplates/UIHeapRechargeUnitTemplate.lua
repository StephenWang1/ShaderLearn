---@class UIHeapRechargeUnitTemplate:TemplateBase 累充活动单元
local UIHeapRechargeUnitTemplate = {}

--region 初始化

function UIHeapRechargeUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIHeapRechargeUnitTemplate:InitParameters()
    self.specialActivityId = 0
    ---@type TABLE.cfg_special_activity
    self.specialActivityTbl = nil
    ---@type LuaSpecailActivityRewardState
    self.rewardState = 0
    self.allTemplateByRewardGoTbl = {}
    ---@type <number,bagV2.CoinInfo>
    self.rewardItemTbl = {}
end

function UIHeapRechargeUnitTemplate:InitComponents()
    ---@type Top_UISprite 背景
    self.bg = self:Get("backGround", "Top_UISprite")
    ---@type Top_UISprite 天数底图
    self.toBackGround = self:Get("toBackGround", "Top_UISprite")
    ---@type UnityEngine.GameObject 天数
    self.dayTitle = self:Get("Daily", "GameObject")
    ---@type Top_UILabel 天数
    self.day = self:Get("Daily/day", "Top_UILabel")
    ---@type UnityEngine.GameObject 额外奖励
    self.otherReward = self:Get("otherReward", "GameObject")
    ---@type Top_UIGridContainer 奖励
    self.rewardGrid = self:Get("ScrollView/reward", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 已领取
    self.geted = self:Get("has_got", "GameObject")
    ---@type UnityEngine.GameObject 按钮
    self.getBtn = self:Get("btn_get", "GameObject")
    ---@type Top_UISprite 按钮背景
    self.getBtnBg = self:Get("btn_get", "Top_UISprite")
    ---@type Top_UILabel 按钮 文本
    self.btnLabel = self:Get("btn_get/Label", "Top_UILabel")
    ---@type Top_UILabel 描述
    self.des = self:Get("label", "Top_UILabel")
end

function UIHeapRechargeUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.getBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.getBtn).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region Show
---@param data activitiesV2.TheRecharge
function UIHeapRechargeUnitTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.specialActivityId = data.id
    self.rewardState = data.rewardType
    self:RefreshData()
    self:RefreshView()
end

--endregion


--region UI函数监听

function UIHeapRechargeUnitTemplate:OnGetBtnClick(go)
    if self.rewardState == LuaSpecailActivityRewardState.NotGet then
        ---跳转充值
        uiTransferManager:TransferToPanel(LuaEnumTransferType.Recharge)
    elseif self.rewardState == LuaSpecailActivityRewardState.Get then
        networkRequest.ReqGetOneActivitiesAward(self.specialActivityId)
    end
end

--endregion

--region View

---刷新视图
function UIHeapRechargeUnitTemplate:RefreshView()
    if self.specialActivityTbl == nil then
        return
    end
    self:RefrshMainView()
    self:RefreshBtnView()
    self:RefreshRewardView()
end

function UIHeapRechargeUnitTemplate:RefrshMainView()
    if self.specialActivityTbl:GetSmallName() then
        local str = self.specialActivityTbl:GetSmallName()
        self.otherReward:SetActive(str == "额外奖励")
        self.dayTitle:SetActive(str ~= "额外奖励")
        self.day.text = self.specialActivityTbl:GetSmallName()
        self.des.gameObject:SetActive(str == "额外奖励")
    end

    self.bg.color = self.rewardState == LuaSpecailActivityRewardState.Geted and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
    self.toBackGround.color = self.rewardState == LuaSpecailActivityRewardState.Geted and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
end

---刷新奖励视图
function UIHeapRechargeUnitTemplate:RefreshRewardView()
    if self.rewardItemTbl == nil or #self.rewardItemTbl == 0 then
        return
    end
    self.rewardGrid.MaxCount = #self.rewardItemTbl
    for i = 1, #self.rewardItemTbl do
        local go = self.rewardGrid.controlList[i - 1]
        ---@type UIItem
        local template = self.allTemplateByRewardGoTbl[go]
        local rewardInfo = self.rewardItemTbl[i]
        if template == nil then
            template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
            self.allTemplateByRewardGoTbl[go] = template
        end
        local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(rewardInfo.itemId)
        if isFind then
            template:RefreshUIWithItemInfo(itemInfo, rewardInfo.count)
            template:RefreshOtherUI({ showItemInfo = itemInfo })
        end

        if template:GetItemIcon_UISprite() ~= nil and not CS.StaticUtility.IsNull(template:GetItemIcon_UISprite()) then
            template:GetItemIcon_UISprite().color = self.rewardState == LuaSpecailActivityRewardState.Geted and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
        end

        if template:GetResSprite_UISprite() ~= nil and not CS.StaticUtility.IsNull(template:GetResSprite_UISprite()) then
            template:GetResSprite_UISprite().gameObject:SetActive(i == 1 and self.rewardState ~= LuaSpecailActivityRewardState.Geted)
        end
    end
end

---刷新按钮视图
function UIHeapRechargeUnitTemplate:RefreshBtnView()
    if (self.specialActivityTbl:GetSmallId() ~= 999) then
        self.getBtn:SetActive(self.rewardState ~= LuaSpecailActivityRewardState.Geted)
        self.btnLabel.text = self.rewardState == LuaSpecailActivityRewardState.Get and luaEnumColorType.SimpleYellow1 .. "领取" or
                self.rewardState == LuaSpecailActivityRewardState.NotGet and luaEnumColorType.Red3 .. "充值" or
                self.rewardState == 3 and luaEnumColorType.Gray .. "未达成" or ""
        self.getBtnBg.spriteName = self.rewardState == LuaSpecailActivityRewardState.Get and "anniu10" or
                self.rewardState == LuaSpecailActivityRewardState.NotGet and "anniu2" or ""
        self.getBtnBg.color = self.rewardState == 3 and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
        self.geted:SetActive(self.rewardState == LuaSpecailActivityRewardState.Geted)
    else
        self.getBtn:SetActive(self.rewardState ~= LuaSpecailActivityRewardState.Geted)
        self.getBtnBg.spriteName = self.rewardState == LuaSpecailActivityRewardState.Get and "anniu10" or ""
        self.getBtnBg.color = self.rewardState ~= 2 and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
        self.btnLabel.text = self.rewardState == LuaSpecailActivityRewardState.Get and luaEnumColorType.SimpleYellow1 .. "领取" or
                luaEnumColorType.Gray .. "未达成"
    end

end


--endregion


--region otherFunction

function UIHeapRechargeUnitTemplate:RefreshData()
    self.specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.specialActivityId)
    self.rewardItemTbl = clientTableManager.cfg_special_activityManager:GetReward(self.specialActivityId)
end

--endregion

--region ondestroy

function UIHeapRechargeUnitTemplate:onDestroy()

end

--endregion

return UIHeapRechargeUnitTemplate