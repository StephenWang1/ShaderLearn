---采集提示目标
---@class UIGatherHintTarget:TemplateBase
local UIGatherHintTarget = {}

---@return UnityEngine.GameObject
function UIGatherHintTarget:GetDigBtn()
    if self.mTrainingBtn == nil then
        self.mTrainingBtn = self:Get("dig", "GameObject")
    end
    return self.mTrainingBtn
end

---@param ownerPanel UIFlyShoesPanel
function UIGatherHintTarget:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    self.mOwnerPanel:GetClientEventHandler():AddEvent(CS.CEvent.GatherHintTargetRefreshed, function()
        self:OnGatherHintTargetRefreshed()
    end)
    CS.UIEventListener.Get(self:GetDigBtn()).onClick = function()
        self:OnButtonClicked()
    end
end

function UIGatherHintTarget:IsShowing()
    return self.mIsShowHint and self.mIsTargetExist
end

function UIGatherHintTarget:Initialize()
    self.go:SetActive(false)
    self:RefreshHintTargetLid()
    self:Refresh()
end

---绑定状态变化回调
---@param callback fun
function UIGatherHintTarget:BindStateChangedCallBack(callback)
    self.mStateChangedCallBack = callback
end

---@private
function UIGatherHintTarget:OnGatherHintTargetRefreshed()
    self:RefreshHintTargetLid()
    self:Refresh()
end

---@private
function UIGatherHintTarget:RefreshUI()
    if self.mIsTargetExist and self.mIsShowHint then
        ---显示按钮
        self.go:SetActive(true)
    else
        ---隐藏按钮
        self.go:SetActive(false)
    end
    if self.mStateChangedCallBack ~= nil then
        self.mStateChangedCallBack()
    end
end

---@private
function UIGatherHintTarget:OnUpdate()
    local currentTime = CS.UnityEngine.Time.time
    if self.mTimer ~= nil and currentTime < self.mTimer then
        return
    end
    self.mTimer = currentTime + 0.1
    ---每0.1s刷新一次
    self:Refresh()
end

---@private
function UIGatherHintTarget:RefreshHintTargetLid()
    if CS.CSSceneExt.Sington == nil or CS.CSSceneExt.Sington.GatherHint == nil then
        self.hintTargetLid = nil
    else
        self.hintTargetLid = CS.CSSceneExt.Sington.GatherHint.CurrentHintTarget
    end
end

---@private
---@return boolean 是否有变化
function UIGatherHintTarget:RefreshData()
    ---@type CSSceneExt
    local scene = CS.CSSceneExt.Sington
    if scene:getAvatar(self.hintTargetLid) == nil then
        self.hintTargetLid = nil
    end
    local isTargetExist = scene ~= nil and self.hintTargetLid ~= nil and self.hintTargetLid ~= 0
    local isChanged = false
    if self.mIsTargetExist ~= isTargetExist then
        ---目标是否存在
        self.mIsTargetExist = isTargetExist
        isChanged = true
    end
    ---在玩家处于采集或正在前往采集时才显示提示
    local isShowHint = scene ~= nil and scene.GatherController.IsGatheringOrAboutToGathering == false
    if self.mIsShowHint ~= isShowHint then
        ---是否显示提示
        self.mIsShowHint = isShowHint
        isChanged = true
    end
    return isChanged
end

---刷新全部
---@public
function UIGatherHintTarget:Refresh()
    if self:RefreshData() then
        self:RefreshUI()
    end
end

---@private
function UIGatherHintTarget:OnButtonClicked()
    ---@tyep CSSceneExt
    local scene = CS.CSSceneExt.Sington
    if scene == nil then
        return
    end
    if self.hintTargetLid == nil or self.hintTargetLid == 0 then
        self:Refresh()
        return
    end
    local avatar = scene:getAvatar(self.hintTargetLid)
    if avatar == nil then
        self:Refresh()
        return
    end
    ---尝试前往采集目标
    if scene.GatherController:RunForGather(avatar) then
        ---尝试进入自动暂停状态
        CS.CSAutoPauseMgr.Instance:TryEnterPausedState()
    end
end

return UIGatherHintTarget