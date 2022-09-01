local UIVideoPlayerTemplate = {};

---@type UIBase
UIVideoPlayerTemplate.mOwnerPanel = nil;

---@return UnityEngine.Video.VideoPlayer
function UIVideoPlayerTemplate:GetVideoPlayerComponent()
    if (self.mVideoPlayerComponent == nil) then
        self.mVideoPlayerComponent = CS.Utility_Lua.GetComponent(self.go, "VideoPlayer")
    end
    return self.mVideoPlayerComponent;
end

---@return Top_UITexture
function UIVideoPlayerTemplate:GetTextureComponent()
    if (self.mTextureComponent == nil) then
        self.mTextureComponent = CS.Utility_Lua.GetComponent(self.go, "Top_UITexture")
    end
    return self.mTextureComponent;
end

--function UIVideoPlayerTemplate:GetRenderComponent()
--    if(self.mRenderComponent == nil) then
--        self.mRenderComponent = CS.Utility_Lua.GetComponent(self.go, "Render")
--    end
--    return self.mRenderComponent;
--end

function UIVideoPlayerTemplate:Init(panel)
    self.mOwnerPanel = panel;
end

function UIVideoPlayerTemplate:Stop()
    if (self:GetVideoPlayerComponent() ~= nil) then
        CS.Utility_Lua.VideoPlayerStop(self:GetVideoPlayerComponent())
    end
end

function UIVideoPlayerTemplate:PlayVideo(videoClip, isLoop)
    isLoop = isLoop == nil and false or isLoop;
    if (self:GetVideoPlayerComponent() ~= nil) then
        CS.Utility_Lua.SetVideoPlayerIsLooping(self:GetVideoPlayerComponent(),isLoop)
    end
end

---@param size UnityEngine.Vector2
function UIVideoPlayerTemplate:SetTextureLocalSize(size)
    if (self:GetTextureComponent()) then
        self:GetTextureComponent().width = size.x
        self:GetTextureComponent().height = size.y
    end
end

---@param pos UnityEngine.Vector3
function UIVideoPlayerTemplate:SetLocalPos(pos)
    if(self.go)then
        self.go.transform.localPosition = pos
    end
end

return UIVideoPlayerTemplate;