local UIBubbleGuildTipsPanel = {}

function UIBubbleGuildTipsPanel:InitComponents()

end
function UIBubbleGuildTipsPanel:InitOther()

end

function UIBubbleGuildTipsPanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIBubbleGuildTipsPanel:Show(data)
    UIBubbleGuildTipsPanel.go.transform.position = data.transform.position
    local posX = UIBubbleGuildTipsPanel.go.transform.localPosition.x
    local posY = UIBubbleGuildTipsPanel.go.transform.localPosition.y
    UIBubbleGuildTipsPanel.go.transform.localPosition = CS.UnityEngine.Vector3(posX+15 , posY+25 , 1);
end



return UIBubbleGuildTipsPanel