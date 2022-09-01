local UIPageViewTemplate = {};

UIPageViewTemplate.mUnitComponentDic = nil;

UIPageViewTemplate.mSelectIndex = 0;

UIPageViewTemplate.mMaxPageCount = 0;

UIPageViewTemplate.mOnePageUnitCount = 0;

---起始索引(mUnitComponentDic)
UIPageViewTemplate.mFirstIndex = 0;

---末尾索引(mUnitComponentDic)
UIPageViewTemplate.mSecondIndex = 0;

UIPageViewTemplate.mScrollViewOriginPosition = nil;

UIPageViewTemplate.mIsScrollViewMoving = false;

--region Components

function UIPageViewTemplate:GetScrollView()
    if (self.mScrollView == nil) then
        self.mScrollView = self:Get("Scroll View", "UIScrollView");
    end
    return self.mScrollView;
end

function UIPageViewTemplate:GetScrollViewPanel()
    if (self.mScrollViewPanel == nil) then
        self.mScrollViewPanel = self:Get("Scroll View", "UIPanel");
    end
    return self.mScrollViewPanel;
end

function UIPageViewTemplate:GetUnitGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Scroll View", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UIPageViewTemplate:GetSpringPanel()
    if (self.mSpringPanel == nil) then
        self.mSpringPanel = self:Get("Scroll View", "SpringPanel");
    end
    return self.mSpringPanel;
end

function UIPageViewTemplate:GetPageUIGridContainer()
    if (self.mPageUIGridContainer == nil) then
        self.mPageUIGridContainer = self:Get("page", "UIGridContainer");
    end
    return self.mPageUIGridContainer;
end

function UIPageViewTemplate:GetScrollViewIsMoving()
    return self.mIsScrollViewMoving;
end

--endregion

--region Method

--region CallFunction

function UIPageViewTemplate:OnScrollViewDragStart()
    if (not self.mIsScrollViewMoving) then
        self.mDragStartPosition = self:GetScrollView().gameObject.transform.localPosition;
        self.mLastPosition = self:GetScrollView().gameObject.transform.localPosition;
        self.mLastOffset = self:GetScrollViewPanel().clipOffset;
    end
end

function UIPageViewTemplate:OnScrollViewDragProgress()
    self:OnMoveXProgress();
end

function UIPageViewTemplate:OnScrollViewDragEnd()
    if (self:GetScrollView().movement == CS.UIScrollView.Movement.Horizontal) then
        self:OnMoveXEnd();
    elseif (self:GetScrollView().movement == CS.UIScrollView.Movement.Vertical) then
    end
    self:UpdatePageSprite();
end

--endregion

--region Public

function UIPageViewTemplate:ClearUnit()
    self:GetUnitGridContainer().MaxCount = 0;
end

function UIPageViewTemplate:Initialize(onePageUnitCount, dataCount, listData, pageUintTemplateClass)
    if (pageUintTemplateClass == nil) then
        pageUintTemplateClass = luaComponentTemplates.UIPageUnitTemplate;
    end
    if (self.mUnitComponentDic == nil) then
        self.mUnitComponentDic = {};
    end
    --self:GetScrollView():ResetPosition();
    self.mOnePageUnitCount = onePageUnitCount;
    self.mListData = listData;
    self.mMaxPageCount = dataCount > onePageUnitCount and math.ceil(dataCount / onePageUnitCount) or 1;
    --local poolCount = self.mMaxPageCount > 3 and 3 or self.mMaxPageCount;
    self:GetUnitGridContainer().MaxCount = self.mMaxPageCount;
    local gridContainer = self:GetUnitGridContainer();
    for i = 0, gridContainer.MaxCount - 1 do
        local gobj = gridContainer.controlList[i];
        if (self.mUnitComponentDic[gobj] == nil) then
            self.mUnitComponentDic[gobj] = templatemanager.GetNewTemplate(gobj, pageUintTemplateClass, self.mOwnerPanel);
        end
        --self.mUnitComponentDic[i]:Initialize();
        self:UpdateUnit(self.mUnitComponentDic[gobj], i);
    end

    --self.mFirstIndex = 0;
    --self.mSecondIndex = gridContainer.MaxCount - 1;

    --region 页切按钮
    self:GetPageUIGridContainer().MaxCount = self.mMaxPageCount;
    for i = 0, self:GetPageUIGridContainer().controlList.Count - 1 do
        local v = self:GetPageUIGridContainer().controlList[i];
        CS.UIEventListener.Get(v).onClick = function()
            self:MoveXToIndex(i);
        end
    end
    --endregion

    --local x = self.mScrollViewOriginPosition.x;
    --local y = self.mScrollViewOriginPosition.y;
    --local z = self.mScrollViewOriginPosition.z;
    --self.mDragStartPosition = CS.UnityEngine.Vector3(x, y, z);
    --self.mLastPosition = self:GetScrollView().gameObject.transform.localPosition;
    --self.mLastOffset = self:GetScrollView().panel.clipOffset;
    self:OnScrollViewDragStart();
    self:MoveXToIndex(0);
    --self:OnMoveXProgress();
end

--endregion

--region Private

function UIPageViewTemplate:MoveXToIndex(index)
    index = index < 0 and 0 or index;
    index = index > self.mMaxPageCount - 1 and self.mMaxPageCount - 1 or index;
    local springPanel = self:GetSpringPanel();
    local gridContainer = self:GetUnitGridContainer();
    local targetPos = self.mDragStartPosition;
    targetPos.x = self.mDragStartPosition.x + (self.mSelectIndex - index) * gridContainer.CellWidth;
    springPanel.target = targetPos
    springPanel.enabled = true;
    self.mSelectIndex = index;

    self:UpdatePageSprite();
end

function UIPageViewTemplate:UpdateUnit(unitTemplate, index)
    --print(index);
    self.mLastPosition = self:GetScrollView().gameObject.transform.localPosition;
    unitTemplate.go.transform.localPosition = CS.UnityEngine.Vector3((index) * self:GetUnitGridContainer().CellWidth, 0, 0);
    if (self.mListData ~= nil) then
        unitTemplate:UpdateUnit(self.mListData[index + 1]);
    else
        unitTemplate:UpdateUnit(nil);
    end
end

function UIPageViewTemplate:UpdatePageSprite()
    self:GetPageUIGridContainer().gameObject:SetActive(self:GetPageUIGridContainer().MaxCount > 1);

    for i = 0, self:GetPageUIGridContainer().controlList.Count - 1 do
        local v = self:GetPageUIGridContainer().controlList[i];
        local spriteName = i == self.mSelectIndex and "scrlight" or "scrbg";
        CS.Utility_Lua.GetComponent(v, "UISprite").spriteName = spriteName;
    end
end

--function UIPageViewTemplate:OnMoveXProgress()
--    local gridContainer = self:GetUnitGridContainer();
--    local deltaPositionX = self:GetScrollView().gameObject.transform.localPosition.x - self.mLastPosition.x;
--    local dir = deltaPositionX > 0 and -1 or 1;
--    local value = math.abs(deltaPositionX) / gridContainer.CellWidth;
--    if(value >= 1) then
--        for i = 0, value - 1 do
--            local unit = nil;
--            if(dir > 0) then
--                unit = self.mUnitComponentDic[self.mFirstIndex];
--                if(unit ~= nil and not CS.StaticUtility.IsNull(unit.go)) then
--                    if(self.mSecondIndex < gridContainer.MaxCount - 1) then
--                        local curIndex = self.mSecondIndex + 1;
--                        self.mUnitComponentDic[self.mFirstIndex] = nil;
--                        self.mUnitComponentDic[curIndex] = unit;
--                        self:UpdateUnit(unit, curIndex - 1);
--                        self.mFirstIndex = self.mFirstIndex + 1;
--                        self.mSecondIndex = curIndex;
--                    end
--                end
--            else
--                unit = self.mUnitComponentDic[self.mSecondIndex];
--                if(unit ~= nil and not CS.StaticUtility.IsNull(unit.go)) then
--                    if(self.mFirstIndex > 1) then
--                        local curIndex = self.mFirstIndex - 1;
--                        self.mUnitComponentDic[self.mSecondIndex] = nil;
--                        self.mUnitComponentDic[curIndex] = unit;
--                        self:UpdateUnit(unit, curIndex - 1);
--                        self.mSecondIndex = self.mSecondIndex - 1;
--                        self.mFirstIndex = curIndex;
--                    end
--                end
--            end
--        end
--
--    end
--end

function UIPageViewTemplate:OnMoveXEnd()
    local gridContainer = self:GetUnitGridContainer();
    local deltaPositionX = self:GetScrollView().gameObject.transform.localPosition.x - self.mDragStartPosition.x;
    local dir = deltaPositionX > 0 and -1 or 1;
    local intervalScale = 0.1;
    print("OnMoveXEnd");
    if (math.abs(deltaPositionX) >= gridContainer.CellWidth * intervalScale) then
        local value = math.abs(deltaPositionX) / gridContainer.CellWidth;
        local tempValue = math.floor(value);
        local interval = (value - tempValue) > intervalScale and tempValue + 1 or tempValue;
        local targetIndex = self.mSelectIndex + dir * interval;
        self:MoveXToIndex(targetIndex);
    else
        self:MoveXToIndex(self.mSelectIndex);
    end
end

function UIPageViewTemplate:InitEvents()
    if self:GetScrollView().onDragStarted ~= nil then
        self:GetScrollView().onDragStarted('+', function()
            self:OnScrollViewDragStart();
            self.mIsScrollViewMoving = true;
        end)
    else
        self:GetScrollView().onDragStarted = function()
            self:OnScrollViewDragStart();
            self.mIsScrollViewMoving = true;
        end
    end
    --self:GetScrollView().onDragProgress = function()
    --    self:OnScrollViewDragProgress();
    --end
    --
    --self:GetScrollView().onMomentumMove = function()
    --    self:OnScrollViewDragProgress();
    --end

    self:GetScrollView().onDragFinished = function()
        self:OnScrollViewDragEnd();
    end

    --self:GetSpringPanel().onMovement = function()
    --    self:OnScrollViewDragProgress();
    --end
    self:GetScrollView().onStoppedMoving = function()
        self:OnScrollViewDragEnd();
        self.mIsScrollViewMoving = false;
    end
end

function UIPageViewTemplate:Clear()

    self.mUnitComponentDic = nil;

    self.mSelectIndex = nil;

    self.mMaxPageCount = nil;

    ---起始索引(mUnitComponentDic)
    self.mFirstIndex = nil;

    ---末尾索引(mUnitComponentDic)
    self.mSecondIndex = nil;

    self.mScrollViewOriginPosition = nil;

    self.mPageUIGridContainer = nil;
    self.mSpringPanel = nil;
    self.mUnitGridContainer = nil;
    self.mScrollView = nil;
end
--endregion

--endregion

function UIPageViewTemplate:Init(panel)
    ---@type UIBase
    self.mOwnerPanel = panel
    self:InitEvents();
    self.mScrollViewOriginPosition = self:GetScrollView().gameObject.transform.localPosition;
    --if(not CS.StaticUtility.IsNull(self:GetScrollViewMask_GameObject())) then
    --    self:GetScrollViewMask_GameObject():SetActive(false);
    --end
end

function UIPageViewTemplate:OnDestroy()
    self:Clear();
end

return UIPageViewTemplate;