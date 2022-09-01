---@class UIRegisterGiftPanelUnitTemplate :TemplateBase
local UIRegisterGiftPanelUnitTemplate = {}

--region 初始化

function UIRegisterGiftPanelUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIRegisterGiftPanelUnitTemplate:InitParameters()
    self.specialActivityId = 0
    ---@type TABLE.cfg_special_activity
    self.specialActivityTbl = nil
    ---@type LuaSpecailActivityRewardState
    self.rewardState = 0
    self.allTemplateByRewardGoTbl = {}
end

function UIRegisterGiftPanelUnitTemplate:InitComponents()
    ---@type Top_UISprite 背景
    self.bg = self:Get("backGround", "Top_UISprite")
    ---@type Top_UISprite 天数底图
    self.toBackGround = self:Get("toBackGround", "Top_UISprite")
    ---@type Top_UILabel 天数
    self.day = self:Get("Daily/day", "Top_UILabel")
    ---@type Top_UIGridContainer 奖励
    self.rewardGrid = self:Get("ScrollView/reward", "Top_UIGridContainer")
    ---@type Top_UILabel 已领取
    self.getedLabel = self:Get("has_got", "Top_UILabel")
    ---@type UnityEngine.GameObject 领取/未领取 背景
    self.getBtn = self:Get("btn_get", "GameObject")
    ---@type UnityEngine.GameObject 按钮特效
    self.getBtnEffect = self:Get("btn_get/effect", "GameObject")
    ---@type Top_UILabel 领取/未领取 文本
    --self.btnLabel = self:Get("btn_get", "Top_UILabel")
end

function UIRegisterGiftPanelUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.getBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.getBtn).OnClickLuaDelegate = self.OnGetBtnClick
end

--endregion

--region Show

---@param data  activitiesV2.OneActivitiesInfo
function UIRegisterGiftPanelUnitTemplate:SetTemplate(data)
    if data == nil then
        return
    end
    self.specialActivityId = data.configId
    self.rewardState = data.finish
    self:RefreshData()
    self:RefreshView()
end

--endregion


--region UI函数监听

function UIRegisterGiftPanelUnitTemplate:OnGetBtnClick(go)
    if self.rewardState ~= LuaSpecailActivityRewardState.Get then
        return
    end

    if self.specialActivityTbl and self.specialActivityTbl:GetSupply() then
        local supplyTbl = self.specialActivityTbl:GetSupply()
        if supplyTbl.list and #supplyTbl.list > 0 then
            for i = 1, #supplyTbl.list do
                if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(supplyTbl.list[i]) then
                    Utility.ShowPopoTips(go, nil, 466, "UIRegisterGiftPanel")
                    return
                end
            end
        end
    end

    networkRequest.ReqGetOneActivitiesAward(self.specialActivityId)
end

--endregion

--region View

function UIRegisterGiftPanelUnitTemplate:RefreshView()
    if self.specialActivityTbl == nil then
        return
    end
    if self.specialActivityTbl:GetSmallName() then
        self.day.text = self.specialActivityTbl:GetSmallName()
    end
    self.bg.color = self.rewardState == LuaSpecailActivityRewardState.Geted and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
    self.toBackGround.color = self.rewardState == LuaSpecailActivityRewardState.Geted and LuaEnumUnityColorType.Gray or LuaEnumUnityColorType.Normal
    self:RefreshBtnView()
    self:RefreshRewardView()
end

function UIRegisterGiftPanelUnitTemplate:RefreshRewardView()
    local boxID = (self.specialActivityTbl:GetAward() ~= nil and #self.specialActivityTbl:GetAward().list > 0) and self.specialActivityTbl:GetAward().list[1] or 0
    ---@type <number,bagV2.CoinInfo>
    self.rewardInfo = CS.Cfg_BoxTableManager.Instance:GetBoxRewardList(boxID)
    if self.rewardInfo == nil or self.rewardInfo.Count == 0 then
        return
    end
    self.rewardGrid.MaxCount = self.rewardInfo.Count
    for i = 0, self.rewardInfo.Count - 1 do
        local go = self.rewardGrid.controlList[i]
        ---@type UIItem
        local template = self.allTemplateByRewardGoTbl[go]
        local rewardInfo = self.rewardInfo[i]
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

function UIRegisterGiftPanelUnitTemplate:RefreshBtnView()
    self.getedLabel.gameObject:SetActive(self.rewardState ~= LuaSpecailActivityRewardState.Get)
    self.getBtn:SetActive(self.rewardState == LuaSpecailActivityRewardState.Get)
    self.getedLabel.text = self.rewardState == LuaSpecailActivityRewardState.Geted and "[878787]已领取[-]" or "[878787]未达成[-]"
end


--endregion


--region otherFunction

function UIRegisterGiftPanelUnitTemplate:RefreshData()
    self.specialActivityTbl = clientTableManager.cfg_special_activityManager:TryGetValue(self.specialActivityId)
end


--endregion

--region ondestroy

function UIRegisterGiftPanelUnitTemplate:onDestroy()

end

--endregion

return UIRegisterGiftPanelUnitTemplate