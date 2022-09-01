---@class UISkillVideoPanel:UIBase
local UISkillVideoPanel = {};
local IsItLoading = false

function UISkillVideoPanel:GetUIVideoPlayerTemplate()
    if (self.mUIVideoPlayerTemplate == nil) then
        self.mUIVideoPlayerTemplate = templatemanager.GetNewTemplate(self:GetCurComp("WidgetRoot/videoTexture", "GameObject"), luaComponentTemplates.UIVideoPlayerTemplate);
    end
    return self.mUIVideoPlayerTemplate;
end

function UISkillVideoPanel:Get_SkillName_Lb()
    if (self.mGet_SkillName_Lb == nil) then
        self.mGet_SkillName_Lb = self:GetCurComp("WidgetRoot/videoTexture/skillName", "Top_UILabel");
    end
    return self.mGet_SkillName_Lb;
end

function UISkillVideoPanel:Get_loadValue_Lb()
    if (self.mGet_loadValue_Lb == nil) then
        self.mGet_loadValue_Lb = self:GetCurComp("WidgetRoot/videoTexture/load/loadValue", "Top_UILabel");
    end
    return self.mGet_loadValue_Lb;
end

function UISkillVideoPanel:Get_Laod_Slider()
    if (self.mGet_Laod_Slider == nil) then
        self.mGet_Laod_Slider = self:GetCurComp("WidgetRoot/videoTexture/load", "Top_UISlider");
    end
    return self.mGet_Laod_Slider;
end

function UISkillVideoPanel:TryGetSkillVideoClip(resName, callBack)
    local path = CS.CSResource.GetPath(resName, CS.ResourceType.Video, false)
    if (string.find(path, 'file://')) then
        path = string.sub(path, 8)
    end
    CS.Utility_Lua.PlayVideoPlayer(path, self:GetUIVideoPlayerTemplate():GetVideoPlayerComponent(), callBack)
end

function update()
    if (not IsItLoading) then
        return
    end
    UISkillVideoPanel:RefreshLoadingProgress(CS.UnityEngine.Time.deltaTime / 3)
end

---刷新加载进度条
function UISkillVideoPanel:RefreshLoadingProgress(loadValue)
    if (self:Get_Laod_Slider() == nil) then
        return
    end
    local curLoadValue = self:Get_Laod_Slider().value
    curLoadValue = curLoadValue + loadValue > 0.95 and 0.95 or curLoadValue + loadValue
    self:Get_Laod_Slider().value = curLoadValue
    if (self:Get_loadValue_Lb()) then
        self:Get_loadValue_Lb().text = "加载中..." .. tostring(math.floor(curLoadValue * 100)) .. '%'
    end
end

---刷新加载完成时进度条
function UISkillVideoPanel:RefreshMaxLoadingProgress()
    IsItLoading = false
    if (self:Get_loadValue_Lb()) then
        self:Get_loadValue_Lb().text = '加载完成..100%'
    end
    if (self:Get_Laod_Slider()) then
        self:Get_Laod_Slider().value = 1
        self:Get_Laod_Slider().gameObject:SetActive(false)
    end
    if (self:Get_SkillName_Lb()) then
        self:Get_SkillName_Lb().gameObject:SetActive(true)
    end
end

---计算面板位置，策划要求与UIItemInfoPnael等高！！！！！
---@param PanelBackGroundSize UnityEngine.Vector2 UIItemInfoPnael背景图尺寸
function UISkillVideoPanel:RefreshPanelPos(PanelBackGroundSize)
    if (PanelBackGroundSize == nil) then
        return
    end
    local newX = 131 + (PanelBackGroundSize.y - 200) / 2

    if (self:GetUIVideoPlayerTemplate()) then
        self:GetUIVideoPlayerTemplate():SetTextureLocalSize(CS.UnityEngine.Vector2(PanelBackGroundSize.y, PanelBackGroundSize.y))
        self:GetUIVideoPlayerTemplate():SetLocalPos(CS.UnityEngine.Vector3(math.floor(newX), 0, 0))
    end
end

function UISkillVideoPanel:InitEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ClosePanel, function(msgId, panelName)
        if (panelName == "UIItemInfoPanel") then
            uimanager:ClosePanel("UISkillVideoPanel");
        end
    end)
end

function UISkillVideoPanel:Init()
    self:InitEvents();
end

---@class SkillVideoPanelParams
---@field videoId number
---@field skillName string
---@param customData SkillVideoPanelParams
function UISkillVideoPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end

    IsItLoading = true

    if (customData.videoId == nil) then
        uimanager:ClosePanel("UISkillVideoPanel");
        return ;
    end

    ---@type TABLE.cfg_video
    local videoTbl = clientTableManager.cfg_videoManager:TryGetValue(customData.videoId)
    if (videoTbl == nil) then
        uimanager:ClosePanel("UISkillVideoPanel");
        return ;
    end

    if (self:Get_SkillName_Lb()) then
        self:Get_SkillName_Lb().text = customData.skillName
    end

    self:GetUIVideoPlayerTemplate():Stop();
    local isLoop = videoTbl:GetLoop() == 1;
    self:TryGetSkillVideoClip(videoTbl:GetParameter(), function(ab, videoClip)
        self:RefreshMaxLoadingProgress()
        self:GetUIVideoPlayerTemplate():PlayVideo(videoClip, isLoop);
    end)
end

return UISkillVideoPanel;