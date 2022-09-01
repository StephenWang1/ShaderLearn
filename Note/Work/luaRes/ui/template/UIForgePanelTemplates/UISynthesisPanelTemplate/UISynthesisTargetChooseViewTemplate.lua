---@class UISynthesisTargetChooseViewTemplate:TemplateBase
local UISynthesisTargetChooseViewTemplate = {};

---@type table<CS.UnityEngine.GameObject, UISynthesisTargetChooseUnitTemplate>
UISynthesisTargetChooseViewTemplate.mUnitDic = nil;

---@type UISynthesisTargetChoosePanel
UISynthesisTargetChooseViewTemplate.mOwnerPanel = nil;

--region Method

function UISynthesisTargetChooseViewTemplate:GetViewRoot_GameObject()
    if(self.mViewRoot_GameObject == nil) then
        self.mViewRoot_GameObject = self:Get("viewRoot", "GameObject");
    end
    return self.mViewRoot_GameObject;
end

function UISynthesisTargetChooseViewTemplate:GetBackGround_UISprite()
    if(self.mBackGround_UISprite == nil) then
        self.mBackGround_UISprite = self:Get("viewRoot/bg","UISprite");
    end
    return self.mBackGround_UISprite;
end

function UISynthesisTargetChooseViewTemplate:GetGridContainer()
    if(self.mGridContainer == nil) then
        self.mGridContainer = self:Get("viewRoot/SelectTargetView/SelectTargetGrid","UIGridContainer");
    end
    return self.mGridContainer;
end

function UISynthesisTargetChooseViewTemplate:GetScrollView()
    if(self.mScrollView == nil) then
        self.mScrollView = self:Get("viewRoot/SelectTargetView", "UIScrollView");
    end
    return self.mScrollView;
end

function UISynthesisTargetChooseViewTemplate:GetDownArrow_GameObject()
    if(self.mDownArrow_GameObject == nil) then
        self.mDownArrow_GameObject = self:Get("arrowPanel/Down","GameObject");
    end
    return self.mDownArrow_GameObject;
end

--endregion

--region Method

--region Public

---@public
function UISynthesisTargetChooseViewTemplate:UpdateView(synthesisTables)
    if(self.mUnitDic == nil) then
        self.mUnitDic = {};
    end
    local gridContainer = self:GetGridContainer();
    if(synthesisTables ~= nil and #synthesisTables > 0) then
        gridContainer.MaxCount = #synthesisTables;
        local index = 0;
        for k,v in pairs(synthesisTables) do
            local gobj = gridContainer.controlList[index];
            if(self.mUnitDic[gobj] == nil) then
                self.mUnitDic[gobj] = templatemanager.GetNewTemplate(gobj, luaComponentTemplates.UISynthesisTargetChooseUnitTemplate, self.mOwnerPanel);
            end
            self.mUnitDic[gobj]:UpdateUnit(v);
            index = index + 1;
        end
    end

    local maxLine = math.ceil(gridContainer.MaxCount / gridContainer.MaxPerLine);
    local offsetY = 60;
    local gridHeight = maxLine * gridContainer.CellHeight + offsetY;
    local pos = self:GetBackGround_UISprite().transform.localPosition;
    local worldPos = self:GetBackGround_UISprite().transform.parent:TransformPoint(CS.UnityEngine.Vector3(pos.x, pos.y - gridHeight, pos.z))
    self:GetDownArrow_GameObject().transform.position = CS.UnityEngine.Vector3(self:GetDownArrow_GameObject().transform.position.x, worldPos.y, self:GetDownArrow_GameObject().transform.position.z);
    self:GetDownArrow_GameObject():SetActive(maxLine > 3);
    self:GetBackGround_UISprite().height = gridHeight;
    --local originHeight = 340;
    --local originPos = self:GetViewRoot_GameObject().transform.localPosition
    --self:GetViewRoot_GameObject().transform.localPosition = CS.UnityEngine.Vector3(originPos.x, -(originPos.y + (originHeight/2-gridHeight/2)) - offsetY, originPos.z);
    --local synthesisPanel = uimanager:GetPanel("UISynthesisPanel");
    --if(synthesisPanel ~= nil) then
    --    if(synthesisPanel:GetSynthesisViewTemplate() ~= nil and synthesisPanel:GetSynthesisViewTemplate():GetBtnChangeMaterial_GameObject() ~= nil) then
    --        local targetPosition = synthesisPanel:GetSynthesisViewTemplate():GetBtnChangeMaterial_GameObject().transform.position;
    --        local position = self.go.transform.position;
    --        self.go.transform.position = CS.UnityEngine.Vector3(position.x, targetPosition.y, position.z);
    --    end
    --end
end

--endregion

--endregion

function UISynthesisTargetChooseViewTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

return UISynthesisTargetChooseViewTemplate;