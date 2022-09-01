---@class UIDialogTipsTemplate5
local UIDialogTipsTemplate5 = {}
setmetatable(UIDialogTipsTemplate5, luaComponentTemplates.UIDialogTipsTemplate2)

--region 引用
function UIDialogTipsTemplate5:GetUIBagPanel()
    if self .mUIBagPanel == nil then
        self.mUIBagPanel = uimanager:GetPanel("UIBagPanel")
    end
    return self.mUIBagPanel
end

function UIDialogTipsTemplate5:GetGlobalTableManager()
    if self.mGlobalTableManager == nil then
        self.mGlobalTableManager = CS.Cfg_GlobalTableManager.Instance
    end
    return self.mGlobalTableManager
end
--endregion

--region 组件
function UIDialogTipsTemplate5:GetLbtips_UILabel()
    if self .mLbtips_UILabel == nil then
        self.mLbtips_UILabel = self:Get("tipPanel/lb_tips", "UILabel")
    end
    return self.mLbtips_UILabel
end

function UIDialogTipsTemplate5:GetGo_FollowPoint()
    if self.mGo_FollowPoint == nil then
        self.mGo_FollowPoint = self:Get("", "Top_FollowPoint")
    end
    return self.mGo_FollowPoint
end
--endregion

--region 初始化显示
---初始化参数
---@param commonData.hintType 提示气泡类型
---@param commonData.tipsContent 文本内容
---@param commonData.point 节点
---@param commonData.clickFunc 点击方法
---@param commonData.state 显示状态
function UIDialogTipsTemplate5:RefreshTips(commonData)
    self.tipsContent = ternary(commonData.tipsContent == nil,"",commonData.tipsContent)
    self.point = commonData.point
    self.clickFunc = commonData.clickFunc
    self.state = ternary(commonData.state == nil,false,commonData.state)
    self.hintType = commonData.hintType
    self:RefreshContent()
    self.tipsCoroutine = StartCoroutine(function() self:DelayRefresh() end )
end

function UIDialogTipsTemplate5:RefreshContent()
    if self:GetLbtips_UILabel() ~= nil then
        self:GetLbtips_UILabel().text = self.tipsContent
    end
end

function UIDialogTipsTemplate5:DelayRefresh()
    if self.state == true then
        coroutine.yield(nil)
    end
    self:RefreshPositionParams()
    self:RefreshTipState()
    if self.tipsCoroutine ~= nil then
        StopCoroutine(self.tipsCoroutine)
        self.tipsCoroutine = nil
    end
end

function UIDialogTipsTemplate5:RefreshPositionParams()
    if self:GetGo_FollowPoint() ~= nil and self.point ~= nil then
        self:GetGo_FollowPoint().startIntervalPosition = CS.UnityEngine.Vector3.right * 10
        self:GetGo_FollowPoint().tweenIntervalPosition = CS.UnityEngine.Vector3.right * 15
        self:GetGo_FollowPoint():SetParams(self.point.transform)
    else
        self:GetGo_FollowPoint():SetParams(nil)
    end
end

function UIDialogTipsTemplate5:RefreshTipState()
    if self.go ~= nil then
        self.go:SetActive(self.state)
    end
end
--endregion

--region UI回调
function UIDialogTipsTemplate5:OnClickContentBtn()
    if self.clickFunc ~= nil then
        self:clickFunc()
    end
end
--endregion

function UIDialogTipsTemplate5:OnDisable()
    self.tipsContent = nil
    self.point = nil
    self.clickFunc = nil
    self.state = nil
    if self.tipsCoroutine ~= nil then
        StopCoroutine(self.tipsCoroutine)
        self.tipsCoroutine = nil
    end
end

function ondestroy()
    if self.tipsCoroutine ~= nil then
        StopCoroutine(self.tipsCoroutine)
        self.tipsCoroutine = nil
    end
end
return UIDialogTipsTemplate5