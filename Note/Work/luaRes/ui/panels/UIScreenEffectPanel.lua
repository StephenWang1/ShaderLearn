---@class UIScreenEffectPanel:UIBase 全屏特效
local UIScreenEffectPanel = {}

--region 局部变量定义
UIScreenEffectPanel.UIFullScreenEffectLoad = nil
UIScreenEffectPanel.effectDefaultHigh = 740
UIScreenEffectPanel.effectDefaultWidth = 1330
--endregion

--region组件
---特效节点
function UIScreenEffectPanel.GetEffectRoot_GameObject()
    if UIScreenEffectPanel.mEffectRoot == nil then
        UIScreenEffectPanel.mEffectRoot = UIScreenEffectPanel:GetCurComp("WidgetRoot/root", "GameObject")
    end
    return UIScreenEffectPanel.mEffectRoot
end
--endregion

--region初始化
function UIScreenEffectPanel:Init()
    UIScreenEffectPanel.UIFullScreenEffectLoad = UIScreenEffectPanel.GetEffectRoot_GameObject():AddComponent(typeof(CS.UIFullScreenEffectLoad))
    self:SetEffectPointScale()
end

function UIScreenEffectPanel:Show(effectId, size, pos)
    if effectId == nil then
        return
    end
    if size == nil then
        size = CS.UnityEngine.Vector3.one
    end
    if pos == nil then
        pos = CS.UnityEngine.Vector3.zero
    end
    if UIScreenEffectPanel.UIFullScreenEffectLoad and effectId and CS.StaticUtility.IsNull(UIScreenEffectPanel.GetEffectRoot_GameObject()) == false then
        UIScreenEffectPanel.UIFullScreenEffectLoad:ShowEffect(effectId, UIScreenEffectPanel.GetEffectRoot_GameObject(), size, pos)
    end
end

---根据分辨率适配面板特效
function UIScreenEffectPanel:SetEffectPointScale()
    local effectScale_x = CS.CSGame.Sington.ContentSize.x / self.effectDefaultWidth
    local effectScale_y = CS.CSGame.Sington.ContentSize.y / self.effectDefaultHigh
    if UIScreenEffectPanel.GetEffectRoot_GameObject() ~= nil then
        UIScreenEffectPanel.GetEffectRoot_GameObject().transform.localScale = { x = effectScale_x, y = effectScale_y, z = 1 }
    end
end

--endregion

return UIScreenEffectPanel