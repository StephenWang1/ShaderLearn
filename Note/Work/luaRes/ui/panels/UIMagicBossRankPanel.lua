local UIMagicBossRankPanel = {}

--region 组件
---@return  UILabel rankTop1
function UIMagicBossRankPanel:GetRankTop01_UILabel()
    if self.mRankTop01_UILabel == nil then
        self.mRankTop01_UILabel = self:GetCurComp("WidgetRoot/Tween/Panel/rankTop01", "UILabel")
    end
    return self.mRankTop01_UILabel
end

---@return  UILabel rankTop11
function UIMagicBossRankPanel:GetRankTop02_UILabel()
    if self.mRankTop02_UILabel == nil then
        self.mRankTop02_UILabel = self:GetCurComp("WidgetRoot/Tween/Panel/rankTop11", "UILabel")
    end
    return self.mRankTop02_UILabel
end

---@return  UILabel rankTop21
function UIMagicBossRankPanel:GetRankTop03_UILabel()
    if self.mRankTop03_UILabel == nil then
        self.mRankTop03_UILabel = self:GetCurComp("WidgetRoot/Tween/Panel/rankTop21", "UILabel")
    end
    return self.mRankTop03_UILabel
end
--endregion

---region 初始化
function UIMagicBossRankPanel:Init()
    self:InitComponent()
    self:BindEvents()
    self:InitParams()
end

function UIMagicBossRankPanel:InitComponent()
    self.title_UILabel = self:GetCurComp("WidgetRoot/Tween/title","UILabel")
    self.panel_TweenPosition = self:GetCurComp("WidgetRoot/Tween","TweenPosition")
    self.arrow_TweenRotation = self:GetCurComp("WidgetRoot/Tween/events/BtnHide","TweenRotation")
    self.rewardlist_GameObject = self:GetCurComp("WidgetRoot/Tween/Panel/rewardlist","GameObject")
    self.rankList_UIPanel = self:GetCurComp("WidgetRoot/Tween/Panel/ScrollView","UIPanel")
    self.rankList_UILoopScrollViewPlus = self:GetCurComp("WidgetRoot/Tween/Panel/ScrollView/SecondList","UILoopScrollViewPlus")
    self.secondOurRankItem_GameObject = self:GetCurComp("WidgetRoot/Tween/Panel/secondOurRankItem","GameObject")
    self.helpBtn_UISprite = self:GetCurComp("WidgetRoot/Tween/events/btn_help","UISprite")
end

function UIMagicBossRankPanel:BindEvents()
    CS.UIEventListener.Get(self.arrow_TweenRotation.gameObject).onClick = function(go)
        self:PlayTween()
    end
    CS.UIEventListener.Get(self.rewardlist_GameObject).onClick = function(go)
        if self.rewardListBtnOnClick ~= nil then
            self.rewardListBtnOnClick(go)
        end
    end
    CS.UIEventListener.Get(self.helpBtn_UISprite.gameObject).onClick = function(go)
        if self.helpBtnOnClick ~= nil then
            self.helpBtnOnClick(go)
        end
    end
end

function UIMagicBossRankPanel:InitParams()
    self.isShow = true
    self.init = false
end
--endregion

--region 刷新
---@param commonData.title string 标题
---@param commonData.rankTable table 排行榜列表
---@param commonData.titleTable table 标头文本列表
---@param commonData.rewardListBtnOnClick function  奖励列表按钮点击
---@param commonData.helpBtnOnClick function 帮助按钮点击
function UIMagicBossRankPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshTitle()
    self:RefreshTitleList()
    self:RefreshRankList()
    self:RefreshMainPlayerRank()
    self:RefreshHelpBtnAnchor()
end

function UIMagicBossRankPanel:AnalysisParams(commonData)
    if commonData == nil or commonData.rankTable == nil or type(commonData.rankTable) ~= "table" then
        return false
    end
    self.title = commonData.title
    self.rankTable = commonData.rankTable
    self.titleTable = commonData.titleTable
    self.rewardListBtnOnClick = commonData.rewardListBtnOnClick
    self.helpBtnOnClick = commonData.helpBtnOnClick
    return true
end

function UIMagicBossRankPanel:RefreshTitle()
    if self.title ~= nil and CS.StaticUtility.IsNull(self.title_UILabel) == false then
        self.title_UILabel.text = self.title
    end
end

function UIMagicBossRankPanel:RefreshTitleList()
    if self.titleTable ~= nil and type(self.titleTable) == "table" and #self.titleTable >= 3 then
        self:GetRankTop01_UILabel().text = self.titleTable[1]
        self:GetRankTop02_UILabel().text = self.titleTable[2]
        self:GetRankTop03_UILabel().text = self.titleTable[3]
    end
end

function UIMagicBossRankPanel:RefreshRankList()
    if CS.StaticUtility.IsNull(self.rankList_UILoopScrollViewPlus) == false and self.rankTable ~= nil and type(self.rankTable) == "table"  then
        if self.init == false then
            self.rankList_UILoopScrollViewPlus:Init(function(go, line)
                local info = self.rankTable[line + 1]
                if info then
                    local rankTemplate = templatemanager.GetNewTemplate(go,luaComponentTemplates.UIMagicBossRankPanel_SingleRankTemplate)
                    rankTemplate:RefreshPanel({rankInfo = info})
                    return true
                else
                    return false
                end
            end)
            self.init = true
        else
            self.rankList_UILoopScrollViewPlus:RefreshCurrentPage()
        end
    end
end

function UIMagicBossRankPanel:RefreshMainPlayerRank()
    local mainPlayerSettleVo = CS.CSScene.MainPlayerInfo.ActivityInfo.MagicCircleMainPlayerSettleVo
    self.secondOurRankItem_GameObject:SetActive(mainPlayerSettleVo ~= nil)
    if mainPlayerSettleVo ~= nil then
        local rankTemplate = templatemanager.GetNewTemplate(self.secondOurRankItem_GameObject,luaComponentTemplates.UIMagicBossRankPanel_SingleRankTemplate)
        rankTemplate:RefreshPanel({rankInfo = mainPlayerSettleVo})
    end
end

function UIMagicBossRankPanel:RefreshHelpBtnAnchor()
    if CS.StaticUtility.IsNull(self.helpBtn_UISprite) == false then
        self.helpBtn_UISprite:UpdateAnchors()
    end
end
--endregion

--region 面板动画
function UIMagicBossRankPanel:PlayTween()
    self.isShow = self.isShow == false
    if self.isShow then
        self.panel_TweenPosition:PlayForward()
        self.arrow_TweenRotation:PlayForward()
    else
        self.panel_TweenPosition:PlayReverse()
        self.arrow_TweenRotation:PlayReverse()
        uimanager:ClosePanel("UIMagicBossRankRewardPanel")
    end
end
--endregion

return UIMagicBossRankPanel