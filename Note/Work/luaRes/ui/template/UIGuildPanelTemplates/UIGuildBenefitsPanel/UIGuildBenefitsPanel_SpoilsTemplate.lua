---@class UIGuildBenefitsPanel_SpoilsTemplate 帮会战利品页面模板
local UIGuildBenefitsPanel_SpoilsTemplate = {}
--region 参数
---单页物品最大数量
UIGuildBenefitsPanel_SpoilsTemplate.singlePageNum = 2
---当前页
UIGuildBenefitsPanel_SpoilsTemplate.curPage = 1

UIGuildBenefitsPanel_SpoilsTemplate.mPageSprite = {
    [true] = "scrlight",
    [false] = "scrbg",
}
--endregion

--region 组件
function UIGuildBenefitsPanel_SpoilsTemplate:GetMainPlayerInfo()
    if self.mRootPanel then
        return self.mRootPanel:GetPlayerInfo()
    else
        if self.mainPlayerInfo == nil then
            self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
        end
        return self.mainPlayerInfo
    end
end

---物品循环组件
function UIGuildBenefitsPanel_SpoilsTemplate:GetUIPageRecyclingContainerForGameObject()
    if self.mUIPageRecyclingContainerForGameObject == nil or CS.StaticUtility.IsNull(self.mUIPageRecyclingContainerForGameObject) then
        self.mUIPageRecyclingContainerForGameObject = self:Get("Scroll View/WarehouseContent", "UIPageRecyclingContainerForGameObject")
    end
    return self.mUIPageRecyclingContainerForGameObject
end

---@return UIGridContainer
function UIGuildBenefitsPanel_SpoilsTemplate:GetPageBookMark_UIGridContainer()
    if self.mBookMarkContainer == nil then
        self.mBookMarkContainer = self:Get("grid", "UIGridContainer")
    end
    return self.mBookMarkContainer
end

---物品循环组件
---@return UILoopScrollViewPlus 循环
function UIGuildBenefitsPanel_SpoilsTemplate:GetLoop_UILoopScrollViewPlus()
    if self.mLoopGo == nil then
        self.mLoopGo = self:Get("Scroll View/Content", "UILoopScrollViewPlus")
    end
    return self.mLoopGo
end

---@return UIScrollView
function UIGuildBenefitsPanel_SpoilsTemplate:GetLoopScrollView()
    if self.mSV == nil then
        self.mSV = self:Get("Scroll View", "UIScrollView")
    end
    return self.mSV
end

---@return UnityEngine.GameObject 提示箭头
function UIGuildBenefitsPanel_SpoilsTemplate:GetArrow_GameObject()
    if self.mArrowObj == nil then
        self.mArrowObj = self:Get("arrowPanel/RightArrow", "GameObject")
    end
    return self.mArrowObj
end

---@return TweenAlpha 提示箭头动画
function UIGuildBenefitsPanel_SpoilsTemplate:GetDownArrowTween()
    if self.mDownArrowTween == nil then
        self.mDownArrowTween = self:Get("arrowPanel/RightArrow", "TweenAlpha")
    end
    return self.mDownArrowTween
end

---@return UnityEngine.GameObject 提示箭头
function UIGuildBenefitsPanel_SpoilsTemplate:GetUpArrow_GameObject()
    if self.mUpArrowObj == nil then
        self.mUpArrowObj = self:Get("arrowPanel/LeftArrow", "GameObject")
    end
    return self.mUpArrowObj
end

---@return TweenAlpha 提示箭头动画
function UIGuildBenefitsPanel_SpoilsTemplate:GetUpArrowTween()
    if self.mUpArrowTween == nil then
        self.mUpArrowTween = self:Get("arrowPanel/LeftArrow", "TweenAlpha")
    end
    return self.mUpArrowTween
end

--endregion

--region 初始化
---@param panel UIGuildActivitiesPanel
function UIGuildBenefitsPanel_SpoilsTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitParams()
    self:GetLoopScrollView().onDragFinished = function()
        self:RefreshArrow()
    end
end

---初始化参数
function UIGuildBenefitsPanel_SpoilsTemplate:InitParams()
    self.curPage = 1
end
--endregion

--region 刷新
---@param spoilsDic table<number,bagV2.BagItemInfo> 帮会战利品列表
function UIGuildBenefitsPanel_SpoilsTemplate:RefreshInfo(spoilsDic)
    self:InitItemList()
end

---region 刷新物品列表数据
function UIGuildBenefitsPanel_SpoilsTemplate:InitItemList()
    -- local totalPage = self:GetMainPlayerInfo().UnionInfoV2:GetSpoilsListMaxPage(self.singlePageNum)
    local targetPage = self.curPage == nil and 1 or self.curPage;
    local totalPage = self:GetPageNum()
    --[[
    if self:GetUIPageRecyclingContainerForGameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetUIPageRecyclingContainerForGameObject()) then
        self:GetUIPageRecyclingContainerForGameObject():Initialize(totalPage,
                function(obj, page)
                    self:OnPageEnterViewRange(obj, page)
                end,
                function(obj, page)
                    self:OnPageExitViewRange(obj, page)
                end,
                function(page)
                    self:OnCenterPageIndexChanged(page)
                end, targetPage - 1)
    end
    self:InitPage(totalPage, targetPage)
    --]]
    if CS.StaticUtility.IsNull(self:GetLoop_UILoopScrollViewPlus()) == false then
        self:GetLoop_UILoopScrollViewPlus():Init(function(go, line)
            if line < self:GetBagMaxGridCount() / 2 then
                self:RefreshSingleLine(go, line)
                return true
            else
                return false
            end
        end, nil)
    end
    self:RefreshArrow()
end

function UIGuildBenefitsPanel_SpoilsTemplate:GetPageNum()
    return math.ceil(self:GetBagMaxGridCount() / self:GetPerPageGridNum())
end

function UIGuildBenefitsPanel_SpoilsTemplate:GetMaxPageCount()
    local pageCount = 0
    if self:GetPerPageGridNum() ~= 0 then
        pageCount = self:GetPageNum()
    end
    if pageCount <= 0 then
        pageCount = 1
    end
    return pageCount
end

---@return number 每页格子数
function UIGuildBenefitsPanel_SpoilsTemplate:GetPerPageGridNum()
    return 30
end

---@return number 背包最大格子数
function UIGuildBenefitsPanel_SpoilsTemplate:GetBagMaxGridCount()
    if self.mMaxCount == nil then
        self.mMaxCount = CS.Cfg_GlobalTableManager.Instance:GetSpoilsGridMaxCount()
    end
    return self.mMaxCount
end

---初始化页签
function UIGuildBenefitsPanel_SpoilsTemplate:InitPage(page, targetPage)
    targetPage = targetPage == nil and 0 or targetPage;
    self:GetPageBookMark_UIGridContainer().MaxCount = page
    self:RefreshWarehousePage(targetPage);
end

---刷新仓库页签显示
function UIGuildBenefitsPanel_SpoilsTemplate:RefreshWarehousePage(page)
    if self.curPage then
        self:SetPageSprite(self:GetPageBookMark_UIGridContainer(), self.curPage, false)
    end
    self:SetPageSprite(self:GetPageBookMark_UIGridContainer(), page, true)
    self.curPage = page
end

---设置仓库和背包页签
function UIGuildBenefitsPanel_SpoilsTemplate:SetPageSprite(container, page, isChoose)
    if page > container .controlList.Count then
        return
    end
    local go = container.controlList[page - 1]
    if self.mPageGoToSprite == nil then
        self.mPageGoToSprite = {}
    end
    ---@type UISprite
    local sprite = self.mPageGoToSprite[go]
    if sprite == nil then
        sprite = CS.Utility_Lua.GetComponent(go.transform, "UISprite")
        self.mPageGoToSprite[go] = sprite
    end
    sprite.spriteName = self.mPageSprite[isChoose]
end

---刷新页签显示
function UIGuildBenefitsPanel_SpoilsTemplate:RefreshPage(page)
    if self.curPage then
        self:SetPageSprite(self:GetPageBookMark_UIGridContainer(), self.curPage, false)
    end
    self:SetPageSprite(self:GetPageBookMark_UIGridContainer(), page, true)
    self.curPage = page
end

--endregion

--region 翻页
---当前页进入视野
function UIGuildBenefitsPanel_SpoilsTemplate:OnPageEnterViewRange(obj, page)
    if obj ~= nil then
        local bagItemInfoList = self:GetMainPlayerInfo().UnionInfoV2:GetSpoilsListByPage(self.singlePageNum, page)
        local mUIGridContainer = self:GetCurComp(obj.transform, "Content", "UIGridContainer")
        if mUIGridContainer ~= nil then
            mUIGridContainer.MaxCount = self.singlePageNum
            for k = 0, mUIGridContainer.controlList.Count - 1 do
                local grid_Go = mUIGridContainer.controlList[k]
                local bagItemInfo = nil
                if k < bagItemInfoList.Count then
                    bagItemInfo = bagItemInfoList[k]
                end
                if grid_Go ~= nil then
                    ---@type UIGuildBenefitsPanel_SpoilsGridTemplate
                    local grid_Template = templatemanager.GetNewTemplate(grid_Go, luaComponentTemplates.UIGuildBenefitsPanel_SpoilsGridTemplate)
                    grid_Template:RefreshGrid(bagItemInfo)
                end
            end
        end
    end
end

---当前页离开视野
function UIGuildBenefitsPanel_SpoilsTemplate:OnPageExitViewRange(obj, page)
end

---中心页变化
function UIGuildBenefitsPanel_SpoilsTemplate:OnCenterPageIndexChanged(page)
    --self.curPage = page + 1
    self:RefreshPage(page + 1)
end
--endregion

--region 新版循环刷新
function UIGuildBenefitsPanel_SpoilsTemplate:RefreshSingleLine(go, line)
    if CS.StaticUtility.IsNull(go) == false and line then
        local bagItemInfoList = self:GetMainPlayerInfo().UnionInfoV2:GetSpoilsListByPage(2, line)
        local mUIGridContainer = CS.Utility_Lua.Get(go.transform, "Content", "UIGridContainer")
        if mUIGridContainer ~= nil then
            mUIGridContainer.MaxCount = self.singlePageNum
            for k = 0, mUIGridContainer.controlList.Count - 1 do
                local grid_Go = mUIGridContainer.controlList[k]
                local bagItemInfo = nil
                if k < bagItemInfoList.Count then
                    bagItemInfo = bagItemInfoList[k]
                end
                if grid_Go ~= nil then
                    ---@type UIGuildBenefitsPanel_SpoilsGridTemplate
                    local grid_Template = self:GetGOTemplate(grid_Go)
                    grid_Template:RefreshGrid(bagItemInfo)
                end
            end
        end
    end
end

function UIGuildBenefitsPanel_SpoilsTemplate:GetGOTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIGuildBenefitsPanel_SpoilsGridTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end
--endregion

--region 箭头显示

function UIGuildBenefitsPanel_SpoilsTemplate:RefreshArrow()
    local state = self:GetLoopScrollView():GetScrollViewSoftState(false)
    local numState = Utility.EnumToInt(state)
    self:GetUpArrow_GameObject():SetActive(numState ~= 1)
    self:GetArrow_GameObject():SetActive(numState ~= 3)
    self:GetUpArrowTween():PlayTween()
    self:GetDownArrowTween():PlayTween()
end
--endregion

return UIGuildBenefitsPanel_SpoilsTemplate