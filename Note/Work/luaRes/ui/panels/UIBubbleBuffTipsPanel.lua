---@class UIBubbleBuffTipsPanel:UIBase
local UIBubbleBuffTipsPanel = {}

--function

function UIBubbleBuffTipsPanel:Show(str)


end

---设置位置
function UIBubbleBuffTipsPanel:SetPos(pos)
    if pos == nil then
        return
    end
    self.go.transform.localPosition = pos
end

return UIBubbleBuffTipsPanel