local UIAppearancePanelAppellationUnitTemplate = {}

--region 初始化

function UIAppearancePanelAppellationUnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end
--初始化变量
function UIAppearancePanelAppellationUnitTemplate:InitParameters()
    self.id = 0
    self.callBack = nil
end

function UIAppearancePanelAppellationUnitTemplate:InitComponents()
    ---@type Top_UILabel
    self.CallName = self:Get("CallName", "Top_UILabel")
    ---@type Top_UISprite
    self.Sprite = self:Get("CallName/Sprite", "Top_UISprite")
    ---@type UnityEngine.GameObject bg
    self.bg = self:Get("bg", "GameObject")
    ---@type UnityEngine.GameObject 更改名称按钮
    self.btn_RenameBtn = self:Get("btn_rename", "GameObject")
    ---@type Top_UISprite btn图片
    self.btn_rename = self:Get("btn_rename", "Top_UISprite")
    ---@type UnityEngine.GameObject 选中特效
    self.SelectedEffect = self:Get("SelectedEffect", "GameObject")
    ---@type UnityEngine.GameObject 使用中标识
    self.mUsedSign = self:Get("use", "GameObject")
end

function UIAppearancePanelAppellationUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn_RenameBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_RenameBtn).OnClickLuaDelegate = self.OnReNameBtnClick

    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoClick
end

--endregion

--region Show
---{
---@field data table
---@param data.spriteName string  图片名称
---@param data.id         number  id
---@param data.text       string  文本
---@param data.isShowBtn  boolean 是否显示btn（默认显示）
---@param data.index      number  index
---@param data.isUsed   boolean 是否使用中
---@param data.callBack   function 回调
---}
function UIAppearancePanelAppellationUnitTemplate:SetTemplate(data)
    self.data = data
    self.id = data.id
    self.callBack = data.CallBack
    self.Sprite.spriteName = data.spriteName ~= nil and data.spriteName or ''
    self.CallName.text = data.text ~= nil and data.text or ''
    self.btn_RenameBtn:SetActive(data.isShowBtn)
    self.SelectedEffect:SetActive(false)
    self.mUsedSign:SetActive(data.isUsed)
end

function UIAppearancePanelAppellationUnitTemplate:RefreshUsedState(isUsed)
    self.mUsedSign:SetActive(isUsed)
end

--endregion


function UIAppearancePanelAppellationUnitTemplate:RefreshEffectShow(isOpen)
    self.SelectedEffect:SetActive(isOpen)
end

--region UI函数监听
function UIAppearancePanelAppellationUnitTemplate:OnReNameBtnClick(go)
    uimanager:CreatePanel("UIReCallnamePanel", nil, self.id)
end

function UIAppearancePanelAppellationUnitTemplate:OnGoClick(go)
    if self.callBack ~= nil then
        self.callBack()
    end
end

--endregion

return UIAppearancePanelAppellationUnitTemplate