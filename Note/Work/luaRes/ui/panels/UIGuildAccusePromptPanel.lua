---帮主弹劾提示
---@class UIGuildAccusePromptPanel:UIBase
local UIGuildAccusePromptPanel = {}

UIGuildAccusePromptPanel.leftCallBack = nil

UIGuildAccusePromptPanel.rightCallBack = nil

UIGuildAccusePromptPanel.centerCallBack = nil

--region 组件
---@return UILabel 描述文本
function UIGuildAccusePromptPanel:GetDescription_UILabel()
    if self.mDesLabel == nil then
        self.mDesLabel = self:GetCurComp("view/Content", "UILabel")
    end
    return self.mDesLabel
end

---@return UnityEngine.GameObject 关闭按钮
function UIGuildAccusePromptPanel:GetCloseBtn_GameObject()
    if self.mCloseBtn == nil then
        self.mCloseBtn = self:GetCurComp("events/close", "GameObject")
    end
    return self.mCloseBtn
end

---@return UnityEngine.GameObject 左边按钮
function UIGuildAccusePromptPanel:GetCancelBtn_GameObject()
    if self.mCancelBtn == nil then
        self.mCancelBtn = self:GetCurComp("events/LeftBtn", "GameObject")
    end
    return self.mCancelBtn
end

---@return UnityEngine.GameObject 左边按钮背景图
function UIGuildAccusePromptPanel:GetLeftBtn_UISprite()
    if self.mLeftBtn_UISprite == nil then
        self.mLeftBtn_UISprite = self:GetCurComp("events/LeftBtn/Background", "UISprite")
    end
    return self.mLeftBtn_UISprite
end

---@return UILabel 左边按钮文字
function UIGuildAccusePromptPanel:GetLeftBtnLabel_UILabel()
    if self.mLeftBtnLabel == nil then
        self.mLeftBtnLabel = self:GetCurComp("events/LeftBtn/Label", "UILabel")
    end
    return self.mLeftBtnLabel
end

---@return UnityEngine.GameObject 中间按钮
function UIGuildAccusePromptPanel:GetConfirmBtn_GameObject()
    if self.mConfirmBtn == nil then
        self.mConfirmBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    end
    return self.mConfirmBtn
end

---@return UnityEngine.GameObject 中间按钮背景图
function UIGuildAccusePromptPanel:GetConfirmBtn_UISprite()
    if self.mConfirmBtn_UISprite == nil then
        self.mConfirmBtn_UISprite = self:GetCurComp("events/CenterBtn/Background", "UISprite")
    end
    return self.mConfirmBtn_UISprite
end

---@return UILabel 中间按钮文字
function UIGuildAccusePromptPanel:GetCenterBtnLabel_UILabel()
    if self.mCenterBtnLabel == nil then
        self.mCenterBtnLabel = self:GetCurComp("events/CenterBtn/Label", "UILabel")
    end
    return self.mCenterBtnLabel
end

---@return UnityEngine.GameObject 右边按钮
function UIGuildAccusePromptPanel:GetRightBtn_GameObject()
    if self.mRightBtn == nil then
        self.mRightBtn = self:GetCurComp("events/RightBtn", "GameObject")
    end
    return self.mRightBtn
end

---@return UnityEngine.GameObject 右边按钮背景图
function UIGuildAccusePromptPanel:GetRightBtn_UISprite()
    if self.mRightBtn_UISprite == nil then
        self.mRightBtn_UISprite = self:GetCurComp("events/RightBtn/Background", "UISprite")
    end
    return self.mRightBtn_UISprite
end

---@return UILabel 右边按钮文字
function UIGuildAccusePromptPanel:GetRightBtnLabel_UILabel()
    if self.mRightBtnLabel == nil then
        self.mRightBtnLabel = self:GetCurComp("events/RightBtn/Label", "UILabel")
    end
    return self.mRightBtnLabel
end

---@return UILabel 左边花费消耗
function UIGuildAccusePromptPanel:LeftCost_UILabel()
    if self.mConfirmCost == nil then
        self.mConfirmCost = self:GetCurComp("events/LeftCost", "UILabel")
    end
    return self.mConfirmCost
end

---@return UISprite 左边花费图片
function UIGuildAccusePromptPanel:GetLeftCostSp_UISprite()
    if self.mCostSp == nil then
        self.mCostSp = self:GetCurComp("events/LeftCost/icon", "UISprite")
    end
    return self.mCostSp
end

---@return UILabel 右边花费消耗
function UIGuildAccusePromptPanel:RightCost_UILabel()
    if self.mConfirmCost == nil then
        self.mConfirmCost = self:GetCurComp("events/RightCost", "UILabel")
    end
    return self.mConfirmCost
end

---@return UISprite 右边花费图片
function UIGuildAccusePromptPanel:GetRightCostSp_UISprite()
    if self.mCostSp == nil then
        self.mCostSp = self:GetCurComp("events/RightCost/icon", "UISprite")
    end
    return self.mCostSp
end

---@return UILabel 中间花费消耗
function UIGuildAccusePromptPanel:CenterCost_UILabel()
    if self.mConfirmCost == nil then
        self.mConfirmCost = self:GetCurComp("events/CenterCost", "UILabel")
    end
    return self.mConfirmCost
end

---@return UISprite 中间花费图片
function UIGuildAccusePromptPanel:GetCenterCostSp_UISprite()
    if self.mCostSp == nil then
        self.mCostSp = self:GetCurComp("events/CenterCost/icon", "UISprite")
    end
    return self.mCostSp
end

---@return UILabel 标题文本
function UIGuildAccusePromptPanel:GetTitle_UILabel()
    if self.mTitleLabel == nil then
        self.mTitleLabel = self:GetCurComp("view/title", "UILabel")
    end
    return self.mTitleLabel
end
--endregion

--region初始化
function UIGuildAccusePromptPanel:Init()
    self:BindEvents()
end

---@alias needInfo{ID:number,LeftCostID:number,LeftCostNum:number,RightCostID:number,RightCostNum:number,CenterCostID:number,CenterCostNum:number,LeftCallBack:function,RightCallBack:function,CenterCallBack:function}
---@param customData table
---{
---@field customData.ID number 表数据
---
---}
function UIGuildAccusePromptPanel:Show(customData, ...)
    if customData.ID then
        self:RefreshPanel(customData.ID, ...)
    end

    if customData.LeftCostID then
        self:LeftCost_UILabel().gameObject:SetActive(true)
        local data = self:GetItemInfo(customData.LeftCostID)
        if data then
            self:GetLeftCostSp_UISprite().spriteName = data.icon
        end
        self:LeftCost_UILabel().text = customData.LeftCostNum
    end

    if customData.RightCostID then
        self:RightCost_UILabel().gameObject:SetActive(true)
        local data = self:GetItemInfo(customData.RightCostID)
        if data then
            self:GetRightCostSp_UISprite().spriteName = data.icon
        end
        self:RightCost_UILabel().text = customData.RightCostNum
    end

    if customData.CenterCostID then
        self:CenterCost_UILabel().gameObject:SetActive(true)
        local data = self:GetItemInfo(customData.CenterCostID)
        if data then
            self:GetCenterCostSp_UISprite().spriteName = data.icon
        end
        self:CenterCost_UILabel().text = customData.CenterCostNum
    end

    if customData.LeftCallBack then
        self.leftCallBack = customData.LeftCallBack
    else
        self.leftCallBack = function()
            self:ClosePanel()
        end
    end
    if customData.RightCallBack then
        self.rightCallBack = customData.RightCallBack
    end
    if customData.CenterCallBack then
        self.centerCallBack = customData.CenterCallBack
    end
end

function UIGuildAccusePromptPanel:BindEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:ClosePanel()
    end
    CS.UIEventListener.Get(self:GetCancelBtn_GameObject()).onClick = function(go)
        if self.leftCallBack then
            self.leftCallBack(go)
        end
    end
    CS.UIEventListener.Get(self:GetConfirmBtn_GameObject()).onClick = function(go)
        if self.centerCallBack then
            self.centerCallBack(go)
        end
    end
    CS.UIEventListener.Get(self:GetRightBtn_GameObject()).onClick = function(go)
        if self.rightCallBack then
            self.rightCallBack(go)
        end
    end
end

--endregion

--region UI事件
function UIGuildAccusePromptPanel:OnConfirmBtnClicked(go)
    if self.mConfirmCallBack then
        self.mConfirmCallBack(go)
    end
end

---刷新花费
function UIGuildAccusePromptPanel:RefreshCost(id, num)
    if id and num then
        local res, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        if res then
            self:GetConfirmCostSp_UISprite().spriteName = info.icon
        end
        self:GetConfirmCost_UILabel().text = num
    end
end

---刷新界面显示
function UIGuildAccusePromptPanel:RefreshPanel(id, ...)
    local res, desInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(id)
    if res then
        local showInfo
        if ... then
            showInfo = string.gsub(string.format(desInfo.des, ...), '\\n', '\n')
        else
            showInfo = string.gsub(desInfo.des, '\\n', '\n')
        end
        self:GetDescription_UILabel().text = showInfo

        if not CS.StaticUtility.IsNullOrEmpty(desInfo.title) then
            self:GetTitle_UILabel().text = desInfo.title
        end

        self.notShowCenterBtn = not CS.StaticUtility.IsNullOrEmpty(desInfo.leftButton) and not CS.StaticUtility.IsNullOrEmpty(desInfo.rightButton)
        self:GetCancelBtn_GameObject():SetActive(self.notShowCenterBtn)
        self:GetRightBtn_GameObject():SetActive(self.notShowCenterBtn)
        self:GetConfirmBtn_GameObject():SetActive(not self.notShowCenterBtn)
        if self.notShowCenterBtn then
            self:GetLeftBtnLabel_UILabel().text = desInfo.leftButton
            self:GetRightBtnLabel_UILabel().text = desInfo.rightButton
        else
            self:GetCenterBtnLabel_UILabel().text = desInfo.leftButton
        end

        local leftBtn = desInfo.leftButtonSprite
        local rightBtn = desInfo.rightButtonSprite
        if leftBtn then
            if not CS.StaticUtility.IsNull(self:GetConfirmBtn_UISprite()) then
                self:GetConfirmBtn_UISprite().spriteName = leftBtn
            end
            if not CS.StaticUtility.IsNull(self:GetLeftBtn_UISprite()) then
                self:GetLeftBtn_UISprite().spriteName = leftBtn
            end
        end
        if not CS.StaticUtility.IsNull(self:GetRightBtn_UISprite()) and rightBtn then
            self:GetRightBtn_UISprite().spriteName = rightBtn
        end
    end
end

---@return TABLE.CFG_ITEMS 获取item表数据
function UIGuildAccusePromptPanel:GetItemInfo(id)
    if self.mIdToInfo == nil then
        self.mIdToInfo = {}
    end
    local data = self.mIdToInfo[id]
    if data == nil then
        ___, data = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mIdToInfo[id] = data
    end
    return data
end

--endregion

return UIGuildAccusePromptPanel