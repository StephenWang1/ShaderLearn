local UIAttributeChangeUnitTweenTemplate = {};

UIAttributeChangeUnitTweenTemplate.mFinishedCallBack = nil;

UIAttributeChangeUnitTweenTemplate.mOriginPosition = nil;

--region Components

function UIAttributeChangeUnitTweenTemplate:GetTweenAlpha()
    if (self.mTweenAlpha == nil) then
        self.mTweenAlpha = CS.Utility_Lua.GetComponent(self.go,"TweenAlpha");
    end
    return self.mTweenAlpha;
end

function UIAttributeChangeUnitTweenTemplate:GetTweenPosition()
    if (self.mTweenPosition == nil) then
        self.mTweenPosition = CS.Utility_Lua.GetComponent(self.go,"TweenPosition");
    end
    return self.mTweenPosition;
end

function UIAttributeChangeUnitTweenTemplate:GetTweenScale()
    if (self.mTweenScale == nil) then
        self.mTweenScale = CS.Utility_Lua.GetComponent(self.go,"TweenScale");
    end
    return self.mTweenScale;
end

--endregion

--region Method

--region Public

function UIAttributeChangeUnitTweenTemplate:ResetPosition(position)
    self.mOriginPosition = position;
end

function UIAttributeChangeUnitTweenTemplate:PlayTweenAction(endCallBack)
    self.mFinishedCallBack = endCallBack;
    self:PlayFadeIn(function()
        if (self.mCoroutineDelayFadeOut ~= nil) then
            StopCoroutine(self.mCoroutineDelayFadeOut);
            self.mCoroutineDelayFadeOut = nil;
        end
        self.mCoroutineDelayFadeOut = StartCoroutine(self.IEnumDelayFadeOut, self, 1);
    end);
end

function UIAttributeChangeUnitTweenTemplate:PlayFadeIn(CallBack)

    self:GetTweenPosition():SetOnFinished(CallBack);

    self:GetTweenPosition().from = self.mOriginPosition;
    self:GetTweenPosition().to = CS.UnityEngine.Vector3(self.mOriginPosition.x - 180, self.mOriginPosition.y, self.mOriginPosition.z);
    self:GetTweenPosition():PlayTween();

    self:GetTweenAlpha().from = 0;
    self:GetTweenAlpha().to = 1;
    self:GetTweenAlpha():PlayTween();

    --self:GetTweenScale().from = 1;
    --self:GetTweenScale().to = 1;
    --self:GetTweenScale():PlayTween();
end

function UIAttributeChangeUnitTweenTemplate:PlayFadeOut(CallBack)

    if(CS.StaticUtility.IsNull(self.go)) then
        return;
    end

    self:GetTweenPosition():SetOnFinished(function()
        if (CallBack ~= nil) then
            CallBack();
        end
    end);

    self:GetTweenPosition().from = self.go.transform.localPosition;
    self:GetTweenPosition().to = CS.UnityEngine.Vector3(self.mOriginPosition.x, self.mOriginPosition.y + 25, self.mOriginPosition.z);
    self:GetTweenPosition():PlayTween();

    self:GetTweenAlpha().from = 1;
    self:GetTweenAlpha().to = 0;
    self:GetTweenAlpha():PlayTween();

    --self:GetTweenScale().from = 1;
    --self:GetTweenScale().to = 0;
    --self:GetTweenScale():PlayTween();
end

--endregion

--region Private

function UIAttributeChangeUnitTweenTemplate:IEnumDelayFadeOut(delayTime)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(delayTime));
    self:PlayFadeOut(self.mFinishedCallBack);
end

function UIAttributeChangeUnitTweenTemplate:Initialize()
    self.mOriginPosition = self.go.transform.localPosition;
end

--endregion

--endregion

function UIAttributeChangeUnitTweenTemplate:OnDestroy()
    if (self.mCoroutineDelayFadeOut ~= nil) then
        StopCoroutine(self.mCoroutineDelayFadeOut);
        self.mCoroutineDelayFadeOut = nil;
    end
end

return UIAttributeChangeUnitTweenTemplate;