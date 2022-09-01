---@class UIChallengeBoss_BossTemplates boss模型展示
local UIChallengeBoss_BossTemplates = {}

function UIChallengeBoss_BossTemplates:InitComponents()

end
function UIChallengeBoss_BossTemplates:InitOther()

end

function UIChallengeBoss_BossTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

---显示模型
function UIChallengeBoss_BossTemplates:ShowModel(ModelId,RootGO)
    local ObservationModel = UIServantPracticePanel.ObservationModel()
    ObservationModel:ClearModel()
    ObservationModel:SetShowMotion(CS.CSMotion.ShowStand)

    ObservationModel:SetBindRenderQueue()
    ObservationModel:SetDragRoot(RootGO)
    --ObservationModel:SetPosition(CS.UnityEngine.Vector3(0 - servant.offsetX, -150 + servant.y, 300))
    --ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    --ObservationModel:SetPositionDeviation(servant.offsetX)
    ObservationModel:CreateModel(ModelId, CS.EAvatarType.Monster, RootGO.transform, function()

    end)
end

return UIChallengeBoss_BossTemplates