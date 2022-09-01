local UIGuildTipsUnitTemplate = {}

--region 局部变量

--endregion

--region 初始化

function UIGuildTipsUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIEvents()
end

--- 初始化变量
function UIGuildTipsUnitTemplate:InitParameters()
    self.btnCallBack = nil
end

--- 初始化组件
function UIGuildTipsUnitTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.btn = self:Get("btn", "GameObject")
    ---@type Top_UILabel
    self.Label = self:Get("btn/Label", "Top_UILabel")
    ---@type Top_UISprite
    self.Sprite = self:Get("btn/Sprite", "Top_UISprite")
end

function UIGuildTipsUnitTemplate:BindUIEvents()
    CS.UIEventListener.Get(self.btn).LuaEventTable = self
    CS.UIEventListener.Get(self.btn).OnClickLuaDelegate = self.OnBtnClickCallBack
end
--endregion

--region 函数监听

function UIGuildTipsUnitTemplate:OnBtnClickCallBack(go)
    if self.btnCallBack ~= nil then
        self.btnCallBack(go)
    end
end

--endregion

--region UI

---@param data table
---{
---@field data.txt              string
---@field data.spriteName       string
---@field data.btnClickCallBack function
---}
function UIGuildTipsUnitTemplate:SetTemplate(data)
    if data then
        if self.Label then
            self.Label.text = data.txt
        end
        if self.Sprite then
            self.Sprite.spriteName = data.spriteName
        end
        self.btnCallBack = data.btnClickCallBack
    end
end

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.UIGuildTipsUnitTemplate, MessageCallback)
end

--endregion

return UIGuildTipsUnitTemplate