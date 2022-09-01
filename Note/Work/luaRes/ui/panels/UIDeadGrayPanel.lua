local UIDeadGrayPanel = {}
--- UIDeadGrayPanel是死亡后,界面灰色效果界面,在效果播放完成后,进行死亡面板的打开

--region parameters
UIDeadGrayPanel.PanelLayerType = CS.UILayerType.TopPlane

UIDeadGrayPanel.mGrayScaleAmount = 0;

--endregion

--region components

function UIDeadGrayPanel:GetScreenGrayComponent()
    if (self.mScreenGray == nil) then
        if (CS.CSScene.Sington ~= nil and CS.CSScene.Sington.Camera ~= nil) then
            self.mScreenGray = CS.CSScene.Sington.Camera.gameObject:GetComponent("ScreenGrayEffect");
            if (self.mScreenGray == nil) then
                self.mScreenGray = CS.CSScene.Sington.Camera.gameObject:AddComponent(typeof(CS.ScreenGrayEffect));
            end
        end
    end
    return self.mScreenGray;
end

--endregion

--region Method

function UIDeadGrayPanel:UpdateScreenGray(isGray, isFade)
    if (self.mCoroutineFadeGray ~= nil) then
        StopCoroutine(self.mCoroutineFadeGray);
        self.mCoroutineFadeGray = nil;
    end
    if (isFade) then
        if (isGray) then
            self.mCoroutineFadeGray = StartCoroutine(self.CFadeGrayIn, self, 1, 1);
        else
            self.mCoroutineFadeGray = StartCoroutine(self.CFadeGrayOut, self, 0, 1);
        end
    else
        local screenGrayEffect = UIDeadGrayPanel:GetScreenGrayComponent();
        if (screenGrayEffect ~= nil) then
            if (isGray) then
                self.mGrayScaleAmount = 1;
            else
                self.mGrayScaleAmount = 0;
            end
            screenGrayEffect.grayScaleAmount = self.mGrayScaleAmount;
        end
    end
end

--region Private

---逐渐变灰
function UIDeadGrayPanel:CFadeGrayIn(to, speed)
    local screenGrayEffect = UIDeadGrayPanel:GetScreenGrayComponent();
    if (screenGrayEffect ~= nil) then
        while (self.mGrayScaleAmount < to) do
            coroutine.yield(0);
            self.mGrayScaleAmount = self.mGrayScaleAmount + CS.UnityEngine.Time.deltaTime * speed;
            screenGrayEffect.grayScaleAmount = self.mGrayScaleAmount;
        end
        self.mGrayScaleAmount = to;
        screenGrayEffect.grayScaleAmount = self.mGrayScaleAmount;
    end
end

---逐渐还原
function UIDeadGrayPanel:CFadeGrayOut(to, speed)
    local screenGrayEffect = UIDeadGrayPanel:GetScreenGrayComponent();
    if (screenGrayEffect ~= nil) then
        while (self.mGrayScaleAmount > to) do
            coroutine.yield(0);
            self.mGrayScaleAmount = self.mGrayScaleAmount - CS.UnityEngine.Time.deltaTime * speed;
            screenGrayEffect.grayScaleAmount = self.mGrayScaleAmount;
        end
        self.mGrayScaleAmount = to;
        screenGrayEffect.grayScaleAmount = self.mGrayScaleAmount;
    end
end

function UIDeadGrayPanel:OnInitDeadPanel()
    local deadPanel = uimanager:GetPanel("UIDeadPanel")
    if (deadPanel == nil) then
        uimanager:CreatePanel("UIDeadPanel", function(panel)
            if panel ~= nil then
                uimanager:ClosePanel('UISmallHpWarning')
            end
        end)
    else
    end
end

function UIDeadGrayPanel:RemoveEvents()
    if (self.mCoroutineFadeGray ~= nil) then
        StopCoroutine(self.mCoroutineFadeGray);
        self.mCoroutineFadeGray = nil;
    end
end

--endregion

--endregion

function UIDeadGrayPanel:Init()
    --local camera = CS.UnityEngine.Camera.main.gameObject;
    self:OnInitDeadPanel();
end

function UIDeadGrayPanel:Show()
    self:UpdateScreenGray(true, true);
end

function ondestroy()
    UIDeadGrayPanel:UpdateScreenGray(false, false);
    UIDeadGrayPanel:RemoveEvents();
end

return UIDeadGrayPanel