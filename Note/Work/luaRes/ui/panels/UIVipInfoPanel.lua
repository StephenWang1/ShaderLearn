local UIVipInfoPanel = {}

--region 组件
function UIVipInfoPanel:GetNoVip_GameObject()
    if (self.mNoVipGo == nil) then
        self.mNoVipGo = self:GetCurComp("WidgetRoot/panel/NoVip", "GameObject")
    end
    return self.mNoVipGo
end

function UIVipInfoPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn
end

function UIVipInfoPanel:GetVip2Level_UILabel()
    if (self.mVip2Level == nil) then
        self.mVip2Level = self:GetCurComp("WidgetRoot/panel/vipLv/num", "Top_UILabel")
    end
    return self.mVip2Level
end

function UIVipInfoPanel:GetVip2Level_UISprite()
    if (self.mVip2LevelSprite == nil) then
        self.mVip2LevelSprite = self:GetCurComp("WidgetRoot/panel/vipLv/sign", "Top_UISprite")
    end
    return self.mVip2LevelSprite
end

function UIVipInfoPanel:GetVip2BG_UISprite()
    if (self.mVip2LevelBGSprite == nil) then
        self.mVip2LevelBGSprite = self:GetCurComp("WidgetRoot/window/vip_bg", "Top_UISprite")
    end
    return self.mVip2LevelBGSprite
end

function UIVipInfoPanel:GetVip2Exp_UILabel()
    if (self.mVip2Exp == nil) then
        self.mVip2Exp = self:GetCurComp("WidgetRoot/panel/vipExp/num", "Top_UILabel")
    end
    return self.mVip2Exp
end

function UIVipInfoPanel:GetVip2ExpBG_UISprite()
    if (self.mVip2ExpBG == nil) then
        self.mVip2ExpBG = self:GetCurComp("WidgetRoot/panel/vipExp/bg", "Top_UISprite")
    end
    return self.mVip2ExpBG
end

function UIVipInfoPanel:GetVip2Exp_UISprite()
    if (self.mVip2ExpUISprite == nil) then
        self.mVip2ExpUISprite = self:GetCurComp("WidgetRoot/panel/vipSlider/slider", "Top_UISprite")
    end
    return self.mVip2ExpUISprite
end

function UIVipInfoPanel:GetVip2ExpPoint_UISprite()
    if (self.mVip2ExpPointUISprite == nil) then
        self.mVip2ExpPointUISprite = self:GetCurComp("WidgetRoot/panel/vipSlider/point", "Top_UISprite")
    end
    return self.mVip2ExpPointUISprite
end

function UIVipInfoPanel:GetVip2ExpSliderBG_UISprite()
    if (self.mVip2ExpSliderBGSprite == nil) then
        self.mVip2ExpSliderBGSprite = self:GetCurComp("WidgetRoot/panel/vipSlider/bg", "Top_UISprite")
    end
    return self.mVip2ExpSliderBGSprite
end

function UIVipInfoPanel:GetNeedCostCount_UILabel()
    if (self.mNeedCostCount == nil) then
        self.mNeedCostCount = self:GetCurComp("WidgetRoot/panel/vipExp/needDiamond", "Top_UILabel")
    end
    return self.mNeedCostCount
end

function UIVipInfoPanel:GetCurLvBtn_GameObject()
    if (self.mCurLvBtn == nil) then
        self.mCurLvBtn = self:GetCurComp("WidgetRoot/events/btn_currentLv", "GameObject")
    end
    return self.mCurLvBtn
end

function UIVipInfoPanel:GetNextLvBtn_GameObject()
    if (self.mNextLvBtn == nil) then
        self.mNextLvBtn = self:GetCurComp("WidgetRoot/events/btn_nextLv", "GameObject")
    end
    return self.mNextLvBtn
end

---@return Top_UIGridContainer
function UIVipInfoPanel:GetVip2Des_UIGridContainer()
    if (self.mvip2DesUIGridContainer == nil) then
        self.mvip2DesUIGridContainer = self:GetCurComp("WidgetRoot/panel/vipDescription", "Top_UIGridContainer")
    end
    return self.mvip2DesUIGridContainer
end

function UIVipInfoPanel:GetVip2SpecialDes_GameObject()
    if (self.mvip2MaxDesGo == nil) then
        self.mvip2MaxDesGo = self:GetCurComp("WidgetRoot/panel/specialdes", "GameObject")
    end
    return self.mvip2MaxDesGo
end

function UIVipInfoPanel:GetVip2SpecialDes_UILabel()
    if (self.mvip2MaxDes == nil) then
        self.mvip2MaxDes = self:GetCurComp("WidgetRoot/panel/specialdes/rewardLabel", "UILabel")
    end
    return self.mvip2MaxDes
end
---@return vipV2.ResRoleVip2Info
function UIVipInfoPanel:GetPlayerVip2Data()
    return gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPlayerVip2Data()
end

---@return UnityEngine.GameObject
function UIVipInfoPanel:GetLevelUpBtn_Go()
    if self.mLevelUpGo == nil then
        self.mLevelUpGo = self:GetCurComp("WidgetRoot/events/btn_levelUp", "GameObject")
    end
    return self.mLevelUpGo
end

---@return UISprite 我要升级选中图片
function UIVipInfoPanel:GetLevelCheck_UISprite()
    if self.mLevelCheckSp == nil then
        self.mLevelCheckSp = self:GetCurComp("WidgetRoot/events/btn_levelUp/checkmark", "UISprite")
    end
    return self.mLevelCheckSp
end

---@return UISprite 特权按钮图片
function UIVipInfoPanel:GetCurLevelCheck_UISprite()
    if self.mCurLevelCheckSp == nil then
        self.mCurLevelCheckSp = self:GetCurComp("WidgetRoot/events/btn_currentLv/checkmark", "UISprite")
    end
    return self.mCurLevelCheckSp
end

---@return UISprite 背景图片
function UIVipInfoPanel:GetBG_UISprite()
    if self.mBGSp == nil then
        self.mBGSp = self:GetCurComp("WidgetRoot/window/bg", "UISprite")
    end
    return self.mBGSp
end

---@return UnityEngine.GameObject  最高级艺术字
function UIVipInfoPanel:GetMaxVip_GameObject()
    if self.mMaxVip_GameObject == nil then
        self.mMaxVip_GameObject = self:GetCurComp("WidgetRoot/panel/MaxVip", "GameObject")
    end
    return self.mMaxVip_GameObject
end

--endregion

--region 初始化
function UIVipInfoPanel:Init()
    self:BindMessage()
    self:BindUIEvent()
end

function UIVipInfoPanel:BindMessage()

end

function UIVipInfoPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:CloseBtnOnClick()
    end
    CS.UIEventListener.Get(self:GetCurLvBtn_GameObject()).onClick = function()
        self:RefreshCurPrivilege()
    end
    CS.UIEventListener.Get(self:GetNextLvBtn_GameObject()).onClick = function()
        self:RefreshNextprivilege()
    end
    CS.UIEventListener.Get(self:GetLevelUpBtn_Go()).onClick = function()
        uimanager:CreatePanel("UIShopPanel", nil, {
            type = LuaEnumStoreType.CommerceDiamond,
        })
    end
end

function UIVipInfoPanel:Show()
    self:RefreshUI()
end

--endregion

--region 刷新界面
function UIVipInfoPanel:RefreshUI()
    local tableinfo = clientTableManager.cfg_vip_levelManager:TryGetValue(self:GetPlayerVip2Data().level)
    if (tableinfo ~= nil) then
        self:RefreshVipIcon()
        local maxlevel = clientTableManager.cfg_vip_levelManager:TryGetValue(self:GetPlayerVip2Data().level + 1) == nil and true or false
        if (maxlevel) then
            self:GetVip2Exp_UILabel().text = "已满级"
            self:GetVip2Exp_UISprite().fillAmount = 1
            self:GetVip2Level_UILabel().text = "[d8f6e7]" .. self:GetPlayerVip2Data().level
            --  self:GetNeedCostCount_UILabel().gameObject:SetActive(false)
        else
            self:GetVip2Exp_UILabel().text = tostring(self:GetPlayerVip2Data().exp) .. "/" .. tableinfo:GetNeedExp()
            self:GetVip2Level_UILabel().text = self:GetPlayerVip2Data().level >= 13 and "[d8f6e7]" .. self:GetPlayerVip2Data().level - 12 or self:GetPlayerVip2Data().level
            self:GetVip2Exp_UISprite().fillAmount = 0.11 + (self:GetPlayerVip2Data().exp / tableinfo:GetNeedExp() * (0.89 - 0.11))
            --self:GetNeedCostCount_UILabel().gameObject:SetActive(true)
            local offset = tableinfo:GetNeedExp() - self:GetPlayerVip2Data().exp
            if offset < 1 then
                offset = 0
            end
            self:GetNeedCostCount_UILabel().text = "再消费" .. tostring(offset) .. "钻石升级"
        end
        self.maxlevel = maxlevel
        self:RefreshCurPrivilege()
    end
end

function UIVipInfoPanel:RefreshVipIcon()
    self:GetVip2BG_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[2]
    self:GetVip2BG_UISprite():MakePixelPerfect()
    self:GetVip2ExpBG_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[3]
    self:GetVip2ExpBG_UISprite():MakePixelPerfect()
    self:GetVip2Level_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[4]
    self:GetVip2Level_UISprite():MakePixelPerfect()
    self:GetVip2ExpSliderBG_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[5]
    self:GetVip2ExpSliderBG_UISprite():MakePixelPerfect()
    self:GetVip2Exp_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[6]
    self:GetVip2Exp_UISprite():MakePixelPerfect()
    self:GetVip2ExpPoint_UISprite().spriteName = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetVipIconId()[7]
    self:GetVip2ExpPoint_UISprite():MakePixelPerfect()
end
--endregion

--region UIEvent
function UIVipInfoPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UIVipInfoPanel")
end

function UIVipInfoPanel:RefreshCurPrivilege()
    if (self:GetPlayerVip2Data().level == 0) then
        self:GetVip2Des_UIGridContainer().MaxCount = 0
        --self:GetVip2SpecialDes_GameObject():SetActive(true)
        self:GetNoVip_GameObject():SetActive(true)
        --self:GetVip2SpecialDes_UILabel().gameObject:SetActive(false)
    else
        self:GetNoVip_GameObject():SetActive(false)
        --self:GetVip2SpecialDes_GameObject():SetActive(false)
        local privilegetable = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPrivilege(self:GetPlayerVip2Data().level)
        self:GetVip2Des_UIGridContainer().MaxCount = Utility.GetLuaTableCount(privilegetable)
        for i = 1, #privilegetable do
            local go = self:GetVip2Des_UIGridContainer().controlList[i - 1]
            local label = CS.Utility_Lua.GetComponent(go.transform:Find("rewardLabel"), "Top_UILabel")
            label.text = privilegetable[i]
        end
    end

    ---vip最高级艺术字
    if self:GetMaxVip_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetMaxVip_GameObject()) then
        self:GetMaxVip_GameObject():SetActive(false)
    end

    self:RefreshBtnShow(self.maxlevel)
end

function UIVipInfoPanel:RefreshNextprivilege()
    self:GetNoVip_GameObject():SetActive(false)
    --self:GetVip2SpecialDes_UILabel().gameObject:SetActive(true)
    local privilegetable = gameMgr:GetPlayerDataMgr():GetPlayerVip2Info():GetPrivilege(self:GetPlayerVip2Data().level + 1)
    if (#privilegetable == 0) then
        self:GetVip2Des_UIGridContainer().MaxCount = 0
        --self:GetVip2SpecialDes_GameObject():SetActive(true)
        --self:GetVip2SpecialDes_UILabel().text = "已达到最高级VIP"
    else
        --self:GetVip2SpecialDes_GameObject():SetActive(false)
        self:GetVip2Des_UIGridContainer().MaxCount = Utility.GetLuaTableCount(privilegetable)
        for i = 1, #privilegetable do
            local go = self:GetVip2Des_UIGridContainer().controlList[i - 1]
            local label = CS.Utility_Lua.GetComponent(go.transform:Find("rewardLabel"), "Top_UILabel")
            label.text = privilegetable[i]
        end
    end

    ---vip最高级艺术字
    if self:GetMaxVip_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetMaxVip_GameObject()) then
        self:GetMaxVip_GameObject():SetActive(#privilegetable == 0)
    end
    self:RefreshBtnShow(self.maxlevel)
end
--endregion
---@param maxlevel boolean 是否满级
function UIVipInfoPanel:RefreshBtnShow(maxlevel)
    self:GetLevelUpBtn_Go():SetActive(not maxlevel)
    local pos = self:GetNeedCostCount_UILabel().gameObject.transform.localPosition
    pos.x = maxlevel and 0 or -29
    self:GetNeedCostCount_UILabel().gameObject.transform.localPosition = pos
    --[[
    local center = 34
    local bgHeight = 217
    if not maxlevel then
        local pos1 = self:GetLevelUpBtn_Go().transform.localPosition
        local goHeight = self:GetLevelCheck_UISprite().height
        center = center - goHeight / 2 - 10
        pos1.y = center
        self:GetLevelUpBtn_Go().transform.localPosition = pos1
        center = center - goHeight / 2
        bgHeight = bgHeight + goHeight + 10
    end

    local pos2 = self:GetCurLvBtn_GameObject().transform.localPosition
    local goHeight = self:GetCurLevelCheck_UISprite().height
    local des = maxlevel and 10 or 20
    local bgAdd = maxlevel and 10 or 20
    bgHeight = bgHeight + bgAdd + goHeight
    center = center - goHeight / 2 - des
    pos2.y = center
    self:GetCurLvBtn_GameObject().transform.localPosition = pos2
    local pos3 = self:GetNextLvBtn_GameObject().transform.localPosition
    pos3.y = center
    self:GetNextLvBtn_GameObject().transform.localPosition = pos3
    local pos4 = self:GetVip2Des_UIGridContainer().gameObject.transform.localPosition
    local goHeight = (self:GetVip2Des_UIGridContainer().MaxCount * self:GetVip2Des_UIGridContainer().CellHeight) / 2 - self:GetVip2Des_UIGridContainer().CellHeight
    center = center - goHeight - 10
    pos4.y = center
    self:GetVip2Des_UIGridContainer().gameObject.transform.localPosition = pos4
    local bgAddContainer = self:GetVip2Des_UIGridContainer().MaxCount * self:GetVip2Des_UIGridContainer().CellHeight
    bgHeight = bgHeight + bgAddContainer + 10 + 30
    self:GetBG_UISprite().height = maxlevel and 470 or 522
    --]]
end

function ondestroy()

end
return UIVipInfoPanel