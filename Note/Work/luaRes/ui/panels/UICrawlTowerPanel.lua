local UICrawlTowerPanel = {}

--region 组件
function UICrawlTowerPanel:GetPlayerTowerInfo()
    return gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo()
end

function UICrawlTowerPanel:GetPlayerTowerData()
    return self:GetPlayerTowerInfo():GetPlayerTowerData()
end

function UICrawlTowerPanel:GetSingleTowerInfoTemplate(go, data)
    if (self.mTemplateDic[go] == nil) then
        self.mTemplateDic[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICrawlTowerInfoTemplate, self)
    end
    return self.mTemplateDic[go]
end

---关闭界面按钮
---@return GameObject
function UICrawlTowerPanel:GetCloseBtn_GameObject()
    if (self.mCloseBtn == nil) then
        self.mCloseBtn = self:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return self.mCloseBtn
end

---当前闯关层数
---@return Top_UILabel
function UICrawlTowerPanel:GetCurTowerLevel_UILabel()
    if (self.mTowerLevel == nil) then
        self.mTowerLevel = self:GetCurComp("WidgetRoot/introduce/labelGroup/details1", "Top_UILabel")
    end
    return self.mTowerLevel
end

---增加次数按钮
---@return GameObject
function UICrawlTowerPanel:GetCheckRewardBtn_GameObject()
    if (self.mCheckRewardBtn == nil) then
        self.mCheckRewardBtn = self:GetCurComp("WidgetRoot/introduce/labelGroup/details2/btn_reward", "GameObject")
    end
    return self.mCheckRewardBtn
end

---爬塔信息scroll
---@return Top_UIScrollView
function UICrawlTowerPanel:GetTowerInfo_LoopScrollView()
    if (self.mTowerInfoLoopScrollView == nil) then
        self.mTowerInfoLoopScrollView = self:GetCurComp("WidgetRoot/Scroll View/SafeArea", "UILoopScrollViewPlus")
    end
    return self.mTowerInfoLoopScrollView
end

--region 局部变量
---当前选择关卡
UICrawlTowerPanel.mCurChooseTem = nil
---切换页签后用，换页的第一关
UICrawlTowerPanel.mOtherPageFirstChooseTem = nil
---当前选择关卡层数
UICrawlTowerPanel.mCurChooseStorey = 0
---当前所选章节
UICrawlTowerPanel.mCurChapterType = 1
---是否开启下一章节
UICrawlTowerPanel.isNextChapter = false
---当前选择左侧大关
UICrawlTowerPanel.mCurChooseLeftGo = nil
---当前手动滑动ScrollView
UICrawlTowerPanel.mAutoScrollViewMove = true
--endregion

--region 初始化
function UICrawlTowerPanel:Init()
    if self:GetPlayerTowerInfo():GetCurTowerTblData() ~= nil then
        self.mCurChooseStorey = self:GetPlayerTowerInfo():GetCurTowerTblData():GetStorey()
    else
        self.mCurChooseStorey = 0
    end
    self:BindMessage()
    self:BindUIEvent()
    self.mTemplateDic = {}
end

function UICrawlTowerPanel:BindMessage()

end

function UICrawlTowerPanel:BindUIEvent()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:CloseBtnOnClick()
    end
    CS.UIEventListener.Get(self:GetCheckRewardBtn_GameObject()).onClick = function(go)
        self:CheckRewardBtnOnClick(go)
    end
end

function UICrawlTowerPanel:Show()
    self:CheckRewardBtnOnClick()
    self:RefreshUIPanel()
end
--endregion

--region 客户端事件处理
---关闭按钮点击事件
function UICrawlTowerPanel:CloseBtnOnClick()
    uimanager:ClosePanel("UICrawlTowerPanel")
    uimanager:ClosePanel("UICrawlTowerRewardPanel")

end

---帮助按钮点击事件
function UICrawlTowerPanel:HelpBtnOnClick()
    Utility.ShowHelpPanel({ id = 176 })
end

---增加次数按钮点击事件
function UICrawlTowerPanel:CheckRewardBtnOnClick(go)
    uimanager:CreatePanel("UICrawlTowerRewardPanel")
end

--endregion

--region 刷新界面

function UICrawlTowerPanel:RefreshUIPanel()
    self:RefreshPanelView()
    self:RefreshTowerPanel()
end

---刷新界面视图(模板中go的onclick调用)
function UICrawlTowerPanel:RefreshPanelView()
    local level = self:GetPlayerTowerData().level
    local color = level >0 and luaEnumColorType.Green or luaEnumColorType.Red
    self:GetCurTowerLevel_UILabel().text = "当前成功挑战 "..color .. level .. "[-] 层"
end

function UICrawlTowerPanel:RefreshTowerPanel()
    local info = clientTableManager.cfg_towerManager.dic
    self:GetTowerInfo_LoopScrollView():Init(function(go, line)
        if line < #info then
            local tem = self:GetSingleTowerInfoTemplate(go, info[line])
            tem:Refresh(info[line + 1])
            return true
        else
            return false
        end
    end)
end

---@param go UnityEngine.GameObject
---@return UIRechargeRewardTemplate
function UICrawlTowerPanel:GetRewardTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICrawlTowerInfoTemplate, self)
    end
    return template
end
--endregion

return UICrawlTowerPanel