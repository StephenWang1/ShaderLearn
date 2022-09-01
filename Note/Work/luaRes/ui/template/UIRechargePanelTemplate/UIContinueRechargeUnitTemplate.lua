---@class UIContinueRechargeUnitTemplate:UI模板
local UIContinueRechargeUnitTemplate = {};

function UIContinueRechargeUnitTemplate:Init(panel)
    ---@type UIRechargePanel
    self.panel = panel
    self:InitTemplate()
    self:BindUIEvents()
end

function UIContinueRechargeUnitTemplate:InitTemplate()
    self.Title = self:Get("Title", "UILabel")
    self.backGround = self:Get("di", "Top_UISprite")
    self.Award = self:Get("Award", "GameObject")
    self.AwardIcon = self:Get("Award/icon", "Top_UISprite")
    self.AwardCount = self:Get("Award/count", "Top_UILabel")
    self.AwardGrid = self:Get("AwardGrid", "Top_UIGridContainer")
    self.ReceiveText = self:Get("btn_go/Label", "UILabel")
    self.btn_get = self:Get("btn_get", "GameObject")
    self.geted = self:Get("geted", "GameObject")
    self.getedUISprite = self:Get("geted", "UISprite")
    self.effect = self:Get("btn_go/Effect", "CSUIEffectLoad")
    self.ReceiveBtnSprite = self:Get("btn_go", "UISprite")
    self.btn_go = self:Get("btn_go", "GameObject")
    self.isCanReceive = false
end

function UIContinueRechargeUnitTemplate:GetAwardGridIcon(index)
    return self.AwardGrid.controlList[index]
end
function UIContinueRechargeUnitTemplate:GetAwardGridText(index)
    return self.AwardGrid.controlList[index]
end

function UIContinueRechargeUnitTemplate:GetCarrerAndSexItem()
    local _index = 0
    local go
    local icon
    local count

    if (self.info.rewardShow ~= nil and self.info.rewardShow.list ~= nil) then
        for i = 0, self.info.rewardShow.list.Count - 1 do
            local str = self.info.rewardShow.list[i].list
            local carrer = 0
            local sex = 0

            if (str.Count >= 4) then
                carrer = str[2]
                sex = str[3]
            end
            if (carrer == 0 and sex == 0)  or (Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career) == carrer and sex == 0) or (carrer == 0 and Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex) == sex) then
                local itemId = str[0]
                local res, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                self.itemTable = Info
                if (res) then
                    _index = _index +1
                    self.AwardGrid.MaxCount = _index
                    go = self.AwardGrid.controlList[_index - 1]  --CS.Utility_Lua.Get(go.transform, "lb_location", "UILabel")
                    icon = CS.Utility_Lua.Get(go.transform, 'icon', "Top_UISprite")
                    count = CS.Utility_Lua.Get(go.transform, 'count', "UILabel")
                    icon.spriteName = Info.icon
                    count.text = str[1] == 1 and " " or tostring(str[1])
                    CS.UIEventListener.Get(go).onClick = function(go)
                        self:AwardOnClick(go)
                    end
                end
            end
        end
    end
    return _index
end

function UIContinueRechargeUnitTemplate:Refresh(info)
    self.info = info
    self.Title.text = "[f6dc97]连充" .. info.smallId .. "天[-]"
    local days = self.panel:GetPlayerInfo().RechargeInfo.CurrentRechargeGiftBoxInfo.continuousGiftBoxInfo.totalDay
    local nowDays = CS.Utility_Lua.GetReaminTimeInDays(self.panel.mContinousGiftBoxInfo.lastCompleteTime, CS.CSServerTime.Instance.TotalMillisecond)
    self.panel:GetContinueRepay_UILabel().text = "已累计充值[f6dc97] " .. days .. "[-] 天"
    local isSexItem = 0
    if (self.info ~= nil and self.info.rewardShow ~= nil) then
        isSexItem = self:GetCarrerAndSexItem()
    end
    if (isSexItem == 0 and self.info ~= nil and self.info.reward ~= nil and self.info.reward.list.Count > 0 ~= nil and self.info.reward.list[0].list ~= nil) then
        local go
        local icon
        local count
        local str
        for i = 0, self.info.reward.list.Count - 1 do
            str = self.info.reward.list[i].list
            local res, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(tonumber(str[0]))
            if (res) then
                self.itemTable = Info
                isSexItem = isSexItem +1
                self.AwardGrid.MaxCount = isSexItem
                go = self.AwardGrid.controlList[isSexItem - 1]  --CS.Utility_Lua.Get(go.transform, "lb_location", "UILabel")
                icon = CS.Utility_Lua.Get(go.transform, 'icon', "Top_UISprite")
                count = CS.Utility_Lua.Get(go.transform, 'count', "UILabel")
                icon.spriteName = Info.icon
                self.AwardIcon:MakePixelPerfect()
                count.text = str[1] == 1 and " " or tostring(str[1])
                CS.UIEventListener.Get(go).onClick = function(go)
                    self:AwardOnClick(go)
                end
            end
        end
    end

    local ReceiveList = self.panel.mContinueCanReceiveList
    local isshowReceiveBtnSprite = true
    local isshowChongzhi = false
    local getedIsActive = false
    if (ReceiveList.Count >= info.index) then
        self.rewardinfo = ReceiveList[info.index - 1]
        if (self.rewardinfo ~= nil and self.rewardinfo.receive == 1) then
            self.btn_get:SetActive(true)
            self.geted:SetActive(false)
            isshowReceiveBtnSprite = false
            self.Title.color = CS.UnityEngine.Color.white
            self.backGround.color = CS.UnityEngine.Color.white
            self.isCanReceive = true
        else
            self.btn_get:SetActive(false)
            self.geted:SetActive(true)
            getedIsActive = true
            isshowReceiveBtnSprite = false
            self.Title.color = CS.UnityEngine.Color.black
            self.backGround.color = CS.UnityEngine.Color.black
            self.isCanReceive = false
        end
    else
        self.btn_get:SetActive(false)
        self.geted:SetActive(false)
        self.Title.color = CS.UnityEngine.Color.white
        self.backGround.color = CS.UnityEngine.Color.white
        self.isCanReceive = false

        if (nowDays >= 1) then
            local index = gameMgr:GetPlayerDataMgr():GetRechargeInfo():Cfg_ContinueRechargeTableManager_GetRewardSmallID(self.panel.mContinueNowGroup, self.panel.mContinousGiftBoxInfo.lastCompleteCfgId) + 1
            if (info.smallId == index) then
                isshowChongzhi = true
            end
        end
    end
    self:SetReceiveBtnSprite(isshowReceiveBtnSprite, isshowChongzhi, getedIsActive)
end

function UIContinueRechargeUnitTemplate:SetReceiveBtnSprite(isshow, isshowChongzhi, getedIsActive)
    self.getedUISprite.gameObject:SetActive((isshow or getedIsActive) and not isshowChongzhi)
    self.ReceiveBtnSprite.gameObject:SetActive(isshow and isshowChongzhi)
    if isshow == true then
        if isshowChongzhi then
            self.ReceiveBtnSprite.spriteName = "anniu8"
            self.ReceiveText.text = "充 值"
            self.ReceiveBtnSprite:MakePixelPerfect()
        end
        if getedIsActive then
            self.getedUISprite.spriteName = "Complete"
        else
            self.getedUISprite.spriteName = "noComplete"
        end
    end
end

function UIContinueRechargeUnitTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.btn_get).onClick = function(go)
        self:ReceiveBtnOnClick(go)
    end

    CS.UIEventListener.Get(self.btn_go).onClick = function(go)
        self:btn_goOnClick(go)
    end
end

function UIContinueRechargeUnitTemplate:ReceiveBtnOnClick(go)
    if (self.isCanReceive) then
        networkRequest.ReqReceiveContinuousGiftBox(self.info.id)
    end
end

function UIContinueRechargeUnitTemplate:btn_goOnClick(go)
    Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.ContinueRecharge)
end

function UIContinueRechargeUnitTemplate:AwardOnClick(go)
    if go ~= nil and CS.StaticUtility.IsNull(go) == false and self.itemTable ~= nil then
        --打开物品信息界面
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemTable, showRight = false })
    end
end

function UIContinueRechargeUnitTemplate:OnDestroy()

end

return UIContinueRechargeUnitTemplate