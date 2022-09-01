---导航栏一级菜单
---@class UINavigationFirstMenuViewTemplate:TemplateBase
local UINavigationFirstMenuViewTemplate = {};

UINavigationFirstMenuViewTemplate.mLayerTableList = nil;

UINavigationFirstMenuViewTemplate.mUnitListDic = nil;

UINavigationFirstMenuViewTemplate.mUnitListFadeInCallBack = nil;

UINavigationFirstMenuViewTemplate.mBgOriginWidth = 0;

UINavigationFirstMenuViewTemplate.mGridOriginPos = nil;

UINavigationFirstMenuViewTemplate.mIsCallBacked = false;

UINavigationFirstMenuViewTemplate.mmTargetId = nil;

--region Component
function UINavigationFirstMenuViewTemplate:GetUnitListGridContainer()
    if (self.mUnitGridContainer == nil) then
        self.mUnitGridContainer = self:Get("Grid", "UIGridContainer");
    end
    return self.mUnitGridContainer;
end

function UINavigationFirstMenuViewTemplate:GetBackGround_UISprite()
    if (self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("bg", "UISprite")
    end
    return self.mBackGround_UISprite;
end
--endregion

--region Method

--region Public

function UINavigationFirstMenuViewTemplate:SelectTarget()
    if (self.mUnitListDic ~= nil) then
        for k, v in pairs(self.mUnitListDic) do
            if (v:TrySelect(self.mTargetId)) then
                break ;
            end
        end
    end
    self.mTargetId = nil;
end

function UINavigationFirstMenuViewTemplate:GetButtonByNavId(navId)
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

function UINavigationFirstMenuViewTemplate:OnFadeInFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:OnFadeInFinished();
        end
    end
    if (luaEventManager.HasCallback(LuaCEvent.Navigation_OnFirstMenuFadeInFished)) then
        luaEventManager.DoCallback(LuaCEvent.Navigation_OnFirstMenuFadeInFished);
    end
end

function UINavigationFirstMenuViewTemplate:OnFadeOutFinished()
    if (self.mLayerTableList == nil) then
        return ;
    end

    for i = 0, self.mLayerTableList.Count - 1, 1 do
        local gobj = self.mGobjList[i + 1];
        local temp = self.mUnitListDic[gobj];
        if(temp ~= nil) then
            temp:OnFadeOutFinished();
        end
    end
end

function UINavigationFirstMenuViewTemplate:PlayUnitListFadeIn(mTargetId, callBack)
    self.mTargetId = mTargetId;
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

--region Public

--endregion

--region Private

function UINavigationFirstMenuViewTemplate:Initialize()
    if(self.mUnitListDic == nil) then
        self.mUnitListDic = {};
    end
    self.mGobjList = {};
    local lineCount = 0;
    self.mLayerTableList, lineCount = CS.Cfg_NavigationTableManager.Instance:GetFirstMenuTableList();
    if (lineCount == 2) then
        self:GetUnitListGridContainer().gameObject.transform.localPosition = CS.UnityEngine.Vector3(self.mGridOriginPos.x, self.mGridOriginPos.y, self.mGridOriginPos.z)
    elseif (lineCount == 1) then
        self:GetUnitListGridContainer().gameObject.transform.localPosition = CS.UnityEngine.Vector3(self.mGridOriginPos.x + 85, self.mGridOriginPos.y, self.mGridOriginPos.z)
        self:GetBackGround_UISprite().width = self.mBgOriginWidth - 85;
    end
    local gridContainer = self:GetUnitListGridContainer();
    gridContainer.MaxCount = self.mLayerTableList.Count;
    --for k,v in pairs(gridContainer.controlList) do

    for i = 0, self.mLayerTableList.Count - 1 do
        local gobj = gridContainer.controlList[i];
        table.insert(self.mGobjList, gobj);
        if (self.mUnitListDic[gobj] == nil) then
            self.mUnitListDic[gobj] =  self:GetUnitListTemplate(gobj)
        end
        self.mUnitListDic[gobj]:ShowButtons(self.mLayerTableList[i]);
    end

    self:GetBackGround_UISprite().height = gridContainer.MaxCount * gridContainer.CellHeight + 20;
end

function UINavigationFirstMenuViewTemplate:GetUnitListTemplate(go)
    if CS.StaticUtility.IsNull(go) == true then
        return nil
    end
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    if self.mGoToTemplate[go] ~= nil then
        return self.mGoToTemplate[go]
    end
    self.mGoToTemplate[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UINavigationUnitListTemplate)
    return self.mGoToTemplate[go]
end

function UINavigationFirstMenuViewTemplate:IEnumUnitListFadeIn()
    local callBackCount = 0;
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
        --coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(0.05));
    end

    if (self.mTargetId ~= nil) then
        self:SelectTarget();
    end

    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1));

    if (not self.mIsCallBacked) then
        self.mIsCallBacked = true;
        if (self.mUnitListFadeInCallBack ~= nil) then
            self.mUnitListFadeInCallBack();
        end
    end
end

function UINavigationFirstMenuViewTemplate:InitEvents()

end

function UINavigationFirstMenuViewTemplate:RemoveEvents()

end

--endregion

--endregion

function UINavigationFirstMenuViewTemplate:Init()
    self:InitEvents();
    self.mBgOriginWidth = self:GetBackGround_UISprite().width;
    self.mGridOriginPos = self:GetUnitListGridContainer().gameObject.transform.localPosition;
end

function UINavigationFirstMenuViewTemplate:OnDestroy()
    self:RemoveEvents();

    if (self.mCoroutineFadeIn ~= nil) then
        StopCoroutine(self.mCoroutineFadeIn);
        self.mCoroutineFadeIn = nil;
    end
end

return UINavigationFirstMenuViewTemplate;