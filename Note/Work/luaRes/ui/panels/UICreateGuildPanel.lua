---@class UICreateGuildPanel:UIBase 创建帮会界面
local UICreateGuildPanel = {}

local Utility = Utility

--region 局部变量定义
---当前帮会数目
---@type number
UICreateGuildPanel.mGuildNum = 0

---创建帮会战勋
---@type number
UICreateGuildPanel.mCreatePrefix = nil

---创建帮会战勋描述
---@type string
UICreateGuildPanel.mCreatePrefixDes = nil

---创建帮会货币名字
---@type string
UICreateGuildPanel.mCreatePanelCoinName = nil

---创建帮会货币id
---@type number
UICreateGuildPanel.mCreatePanelCoinItemId = nil

---创建帮会货币数目
---@type number
UICreateGuildPanel.mCreatePanelCoinNum = nil
--endregion

--region 属性
---@return CSMainPlayerInfo 玩家信息
function UICreateGuildPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

---战勋不足提示
function UICreateGuildPanel:GetPrefixDes()
    if self.mPrefixDes == nil then
        local res, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(161)
        if res and self.mCreatePrefixDes then
            self.mPrefixDes = string.format(bubbleInfo.content, self.mCreatePrefixDes)
        end
    end
    return self.mPrefixDes
end

---@return CSBagInfoV2 背包信息
function UICreateGuildPanel:GetPlayerBagInfoV2()
    if self.mBagInfoV2 == nil then
        if self:GetPlayerInfo() then
            self.mBagInfoV2 = self:GetPlayerInfo().BagInfo
        end
    end
    return self.mBagInfoV2
end

---@return CSUnionInfoV2
function UICreateGuildPanel:GetUnionInfoV2()
    if self.mUnionInfoV2 == nil and self:GetPlayerInfo() then
        self.mUnionInfoV2 = self:GetPlayerInfo().UnionInfoV2
    end
    return self.mUnionInfoV2
end

---货币不足提示
function UICreateGuildPanel:GetMoneyDes()
    if self.mMoneyDes == nil then
        local res, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(162)
        if res and self.mCreatePrefix then
            self.mMoneyDes = string.format(bubbleInfo.content, self.mCreatePanelCoinName)
        end
    end
    return self.mMoneyDes
end
--endregion

--region 组件
---@return UnityEngine.GameObject 关闭界面按钮
function UICreateGuildPanel:GetCloseButton_GameObject()
    if self.mCloseButton == nil then
        self.mCloseButton = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return self.mCloseButton
end

---创建帮会按钮
function UICreateGuildPanel:GetCreateButton_GameObject()
    if self.mCreateButton == nil then
        self.mCreateButton = self:GetCurComp("WidgetRoot/event/btn_create", "GameObject")
    end
    return self.mCreateButton
end

---@return UIInput 公会名输入框
function UICreateGuildPanel:GetInputText_UILabel()
    if self.mInputText == nil then
        self.mInputText = self:GetCurComp("WidgetRoot/event/input", "UIInput")
    end
    return self.mInputText
end

---@return UILabel 需要战勋限制
function UICreateGuildPanel:GetPrefixLimit_UILabel()
    if self.mPrefixLabel == nil then
        self.mPrefixLabel = self:GetCurComp("WidgetRoot/view/exploits/price", "UILabel")
    end
    return self.mPrefixLabel
end
--endregion

--region 初始化
function UICreateGuildPanel:Init()
    self:BindUIEvents()
    self:BindMessage()
end

---@param currentGuildNum number 当前帮会数目
function UICreateGuildPanel:Show(currentGuildNum)
    if currentGuildNum then
        self.mGuildNum = currentGuildNum
    end
    self:RefreshPanel()
end

function UICreateGuildPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetCreateButton_GameObject()).onClick = function(go)
        self:OnCreateButtonClicked(go)
    end
end

function UICreateGuildPanel:BindMessage()
end

--endregion

--region服务器消息
--endregion

--region UI事件
---申请创建
function UICreateGuildPanel:OnCreateButtonClicked(go)
    if self:GetUnionInfoV2().UnionID ~= 0 then
        Utility.ShowPopoTips(go, nil, 236)
        return
    end

    if Utility.IsSabacActivityNotOpen(go) then
        local cd = self:GetUnionInfoV2():GetCancelCD()
        if not CS.StaticUtility.IsNullOrEmpty(cd) then
            if self:GetCancelUnionCDDes() then
                Utility.ShowPopoTips(go, string.format(self:GetCancelUnionCDDes(), cd), 211)
            end
            return
        end
    end

    local unionName = self:GetInputText_UILabel().text
    if CS.StaticUtility.IsNullOrEmpty(unionName) then
        Utility.ShowPopoTips(go, nil, 167)
        return
    end
    --[[    if not self:IsPrefixEnough() then
            local des = self:GetPrefixDes()
            Utility.ShowPopoTips(go, des, 161)
            return
        end]]
    networkRequest.ReqCreateUnion(unionName, 101)
end

---刷新界面显示
function UICreateGuildPanel:RefreshPanel()
    if self.mGuildNum == nil then
        self.mGuildNum = 1
    end
    local condition = CS.Cfg_GlobalTableManager.Instance:GetCreateGuildCondition(self.mGuildNum)
    if condition then
        if self:GetPlayerInfo() and condition.Count >= 5 then
            --战勋
            local prefixId = condition[2]
            self.mCreatePrefix = prefixId
            local career = self:GetPlayerInfo().Career
            if prefixId then
                --[[                local prefix = CS.Cfg_PrefixTableManager.Instance:GetPrefixName(prefixId, career)
                                self.mCreatePrefixDes = prefix
                                local colorPrefix = ternary(self:IsPrefixEnough(), luaEnumColorType.Green, luaEnumColorType.Red)
                                self:GetPrefixLimit_UILabel().text = colorPrefix .. prefix]]
            end
            --self:GetPrefixLimit_UILabel().gameObject:SetActive(false)
        end
    end
end

---@return boolean 判断战勋是否足够
function UICreateGuildPanel:IsPrefixEnough()
    local playerPrefix = self:GetPlayerInfo().PrefixId
    if playerPrefix and self.mCreatePrefix and playerPrefix >= self.mCreatePrefix then
        return true
    end
    return false
end

---@return string 退会CD提示
function UICreateGuildPanel:GetCancelUnionCDDes()
    if self.mCancelUnionCD == nil then
        local res, desInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(211)
        if res then
            self.mCancelUnionCD = desInfo.content
        end
    end
    return self.mCancelUnionCD
end


--endregion

--region onDestroy
function ondestroy()
end
--endregion

return UICreateGuildPanel