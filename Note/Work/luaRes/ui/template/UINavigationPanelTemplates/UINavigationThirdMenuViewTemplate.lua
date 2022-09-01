---导航栏三级菜单
---@class UINavigationThirdMenuViewTemplate:TemplateBase
local UINavigationThirdMenuViewTemplate = {};

UINavigationThirdMenuViewTemplate.mLayerTableList = nil;

UINavigationThirdMenuViewTemplate.mUnitListDic = nil;

UINavigationThirdMenuViewTemplate.mUnitListFadeInCallBack = nil;

UINavigationThirdMenuViewTemplate.mIsCallBacked = false;

UINavigationThirdMenuViewTemplate.mOwnerId = 0;

---是否有跳转对象
UINavigationThirdMenuViewTemplate.mTargetId = nil;

--region Component

function UINavigationThirdMenuViewTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg2", "UISprite");
    end
    return self.mBackGround_UISprite;
end

function UINavigationThirdMenuViewTemplate:GetUnitListGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Grid", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end
--endregion

--region Method

--region Public

function UINavigationThirdMenuViewTemplate:SelectDefault()
    local gobj = self.mGobjList[1];
    if (self.mUnitListDic[gobj] ~= nil) then
        self.mUnitListDic[gobj]:SelectDefault();
    end
end

function UINavigationThirdMenuViewTemplate:SelectTarget()
    if (self.mUnitListDic ~= nil) then
        for k, v in pairs(self.mUnitListDic) do
            if (v:TrySelect(self.mTargetId)) then
                break ;
            end
        end
    end
    self.mTargetId = nil;
end

function UINavigationThirdMenuViewTemplate:GetButtonByNavId(navId)
    if (self.mUnitListDic ~= nil) then
        for k0, v0 in pairs(self.mUnitListDic) do
            for k1, v1 in pairs(v0.mUnitDic) do
                if (v1.mTableInfo.ID == navId) then
                    return v1;
                end
            end
        end
    end
    return nil;
end

function UINavigationThirdMenuViewTemplate:OnFadeInFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        if(self.mUnitListDic[gobj] ~= nil) then
            self.mUnitListDic[gobj]:OnFadeInFinished();
        end
    end
end

function UINavigationThirdMenuViewTemplate:OnFadeOutFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        if(self.mUnitListDic[gobj] ~= nil) then
            self.mUnitListDic[gobj]:OnFadeOutFinished();
        end
    end
end

function UINavigationThirdMenuViewTemplate:PlayUnitListFadeIn(targetId, callBack)
    self.mTargetId = targetId;
    if (callBack ~= nil) then
        self.mUnitListFadeInCallBack = callBack;
    end

    if (self.mCoroutineFadeIn ~= nil) then
        StopCoroutine(self.mCoroutineFadeIn);
        self.mCoroutineFadeIn = nil;
    end
    self.mCoroutineFadeIn = StartCoroutine(self.IEnumUnitListFadeIn, self);
end

--endregion

--region Private

function UINavigationThirdMenuViewTemplate:Initialize(tableList, ownerId)
    if(self.mUnitListDic == nil) then
        self.mUnitListDic = {}
    end
    self.mGobjList = {};
    self.mOwnerId = ownerId;
    self.mLayerTableList = CS.Cfg_NavigationTableManager.Instance:SplitList(tableList, 1);
    local gridContainer = self:GetUnitListGridContainer();
    gridContainer.MaxCount = self.mLayerTableList.Count;
    local gridIndex = 0
    for i = 0, self.mLayerTableList.Count - 1 do
        local gobj = gridContainer.controlList[gridIndex];
        table.insert(self.mGobjList, gobj);
        if (self.mUnitListDic[gobj] == nil) then
            self.mUnitListDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UINavigationUnitListTemplate);
        end
        ---@type UINavigationUnitListTemplate
        local temp = self.mUnitListDic[gobj]

        ---3级页签按钮所属是否存在4级页签/或者说是否能打开面板
        if(temp:ShowButtons(self.mLayerTableList[i]) == false) then
            gridContainer.MaxCount = gridContainer.MaxCount - 1
        else
            gridIndex = gridIndex + 1
        end
    end
    self:GetBackGround_UISprite().height = gridContainer.MaxCount * gridContainer.CellHeight + 10 - 4;--- 4 为二级菜单和三级菜单的图片像素差异
end

function UINavigationThirdMenuViewTemplate:IEnumUnitListFadeIn()

    local callBackCount = 0
    self.mIsCallBacked = false;
    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:PlayUnitListFadeIn(function()
                callBackCount = callBackCount + 1;
                if (callBackCount >= self.mLayerTableList.Count) then
                    if (not self.mIsCallBacked) then
                        self.mIsCallBacked = true;
                        if (self.mUnitListFadeInCallBack ~= nil) then
                            self.mUnitListFadeInCallBack();
                        end
                    end
                end
            end);
        end
    end

    if (self.mTargetId ~= nil) then
        self:SelectTarget();
    else
        self:SelectDefault();
    end

    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));

    if (not self.mIsCallBacked) then
        self.mIsCallBacked = true;
        if (self.mUnitListFadeInCallBack ~= nil) then
            self.mUnitListFadeInCallBack();
        end
    end
end

function UINavigationThirdMenuViewTemplate:InitEvents()

end

function UINavigationThirdMenuViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UINavigationThirdMenuViewTemplate:Init()
    self:InitEvents();
end

function UINavigationThirdMenuViewTemplate:OnDestroy()
    self:RemoveEvents();

    if (self.mCoroutineFadeIn ~= nil) then
        StopCoroutine(self.mCoroutineFadeIn);
        self.mCoroutineFadeIn = nil;
    end
end

return UINavigationThirdMenuViewTemplate;