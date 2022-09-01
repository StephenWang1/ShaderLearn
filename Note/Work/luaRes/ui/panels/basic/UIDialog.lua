---2级菜单及对话框基类
local UIDialog = {}

---遮罩纹理
function UIDialog:MaskTex()
    if self.mMaskTex == nil then
        self.mMaskTex = CS.UnityEngine.Texture2D(2, 2)
    end
    return self.mMaskTex
end

function UIDialog:Init()
    self:AddCollider(self.go)
    self.go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, -1000)
    self.go.transform.localScale = CS.UnityEngine.Vector3.one
end

---为对话框添加遮罩
function UIDialog:AddMask()
    local go = CS.UnityEngine.GameObject("box_mask")
    go.layer = self.go.layer
    CS.NGUITools.SetParent(self.go.transform, go)
    local tex = go:AddComponent(CS.UITexture)
    tex.mainTexture = self:MaskTex()
    tex.color = CS.UnityEngine.Color32(0, 0, 0, 255)
    tex.width = 2000
    tex.height = 2000
    tex.depth = -10
    tex.alpha = 0
    CS.TweenAlpha.Begin(tex.gameObject, 0.15, 0.85)
end

return UIDialog