local UICityWarRankingViewTemplate = {};

---当前排行榜类型
UICityWarRankingViewTemplate.mRankType = 1;

UICityWarRankingViewTemplate.mRankVoList = nil;
---初始scrollView的位置
UICityWarRankingViewTemplate.mOriginScrollViewPosition = nil;
---初始scrollView的偏移
UICityWarRankingViewTemplate.mOriginScrollViewOffset = nil;
---拖动开始时scrollView的位置
UICityWarRankingViewTemplate.mScrollViewBeginPosition = nil;

UICityWarRankingViewTemplate.mLoopScrollViewResetCallBack = nil;

---@type table<CS.UnityEngine.GameObject, UICityWarRankingUnitTemplate>
UICityWarRankingViewTemplate.mRankUnitDic = nil;

--region Components

function UICityWarRankingViewTemplate:GetScrollViewPanel_UIPanel()
    if (self.mScrollViewPanel_UIPanel == nil) then
        self.mScrollViewPanel_UIPanel = self:Get("", "UIPanel");
    end
    return self.mScrollViewPanel_UIPanel;
end

function UICityWarRankingViewTemplate:GetLoopScrollViewParentWidget_UIWidget()
    if (self.mLoopScrollViewParentWidget_UIWidget == nil) then
        self.mLoopScrollViewParentWidget_UIWidget = self:Get("Grid", "UIWidget");
    end
    return self.mLoopScrollViewParentWidget_UIWidget;
end

function UICityWarRankingViewTemplate:GetLoopScrollView()
    if (self.mLoopScrollView == nil) then
        self.mLoopScrollView = self:Get("Grid", "LoopScrollView");
    end
    return self.mLoopScrollView;
end

function UICityWarRankingViewTemplate:GetUnitTemplateClass()
    return luaComponentTemplates.UICityWarRankingUnitTemplate;
end

--endregion

--region Method

--region CallFunction

--endregion

--region Public

function UICityWarRankingViewTemplate:UpdateView(type)
    self.mRankType = type;
    self:UpdateUI();
end

function UICityWarRankingViewTemplate:UpdateUI()
    if (self.mRankUnitDic == nil) then
        self.mRankUnitDic = {};
    end

    self.mRankVoList = gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():GetShaBaRankData();
    if (self.mRankVoList ~= nil and self.mRankVoList.Count > 0) then
        self:GetLoopScrollViewParentWidget_UIWidget().gameObject:SetActive(true);
        self:GetLoopScrollView():Init(self.mRankVoList, function(item, ranVo)
            local gobj = item.widget.gameObject;
            if (self.mRankUnitDic[gobj] == nil) then
                self.mRankUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, self:GetUnitTemplateClass());
            end
            self.mRankUnitDic[gobj]:UpdateUnit(ranVo, self.mRankType);
        end);
    end
end

---重置LoopScrollView
function UICityWarRankingViewTemplate:ResetLoopScrollView()
    if (self:GetLoopScrollViewParentWidget_UIWidget().gameObject.activeSelf) then
        self:GetLoopScrollView():ResetToBegining();
        self:GetLoopScrollViewParentWidget_UIWidget().gameObject:SetActive(false);
    end
end

--endregion

--region Private

function UICityWarRankingViewTemplate:InitEvents()
    local scrollView = self:GetLoopScrollView().scrollView;
    self.mOriginScrollViewPosition = scrollView.transform.localPosition;
    self.mOriginScrollViewOffset = self:GetScrollViewPanel_UIPanel().clipOffset;

    --if scrollView.onDragStarted ~= nil then
    --    scrollView.onDragStarted('+', function()
    --        self.mScrollViewBeginPosition = scrollView.transform.localPosition;
    --    end)
    --else
    --    scrollView.onDragStarted = function()
    --        self.mScrollViewBeginPosition = scrollView.transform.localPosition;
    --    end;
    --end
    --scrollView.onDragFinished = function()
    --    local widget = self:GetLoopScrollViewParentWidget_UIWidget();
    --    if (self.mScrollViewBeginPosition.y - scrollView.transform.localPosition.y < 0) then
    --        if (scrollView.transform.localPosition.y + (widget.transform.localPosition.y - widget.localSize.y) > -250) then
    --            if (self.mRankVoList ~= nil) then
    --                --networkRequest.ReqGetSabacRankInfo(self.mRankType, (math.floor(self.mRankVoList.Count / uiStaticParameter.mShaBaKRankOnePageCount) + 1), uiStaticParameter.mShaBaKRankOnePageCount);
    --                print("准备请求数据 沙巴克积分排行榜")
    --            end
    --        end
    --    end
    --end;
end

function UICityWarRankingViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UICityWarRankingViewTemplate:Init()
    self:InitEvents();
end

--function UICityWarRankingViewTemplate:OnDestroy()
--    self:RemoveEvents();
--end

return UICityWarRankingViewTemplate;