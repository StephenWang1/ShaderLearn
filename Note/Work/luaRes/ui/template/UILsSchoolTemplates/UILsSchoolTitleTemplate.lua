---模板
local UILsSchoolTitleTemplate = {}

--region 初始化

function UILsSchoolTitleTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()

end
--初始化变量
function UILsSchoolTitleTemplate:InitParameters()
    self.data = nil
    self. blueLabel = CS.UnityEngine.Color(195 / 255, 244 / 255, 1, 1)
    self. whiteLabel = CS.UnityEngine.Color.white
end

function UILsSchoolTitleTemplate:InitComponents()
    ---@type Top_UISprite
    self.bg = self:Get("bg", "Top_UISprite")
    ---@type Top_UILabel 章节
    self.StageLabel = self:Get("StageLabel", "Top_UILabel")
    ---@type Top_UILabel 章节描述
    self.StageLabel1 = self:Get("StageLabel1", "Top_UILabel")
    ---@type UnityEngine.GameObject 选中状态高亮
    self.chackmark = self:Get("chackmark", "GameObject")

    self.go_Toggle = CS.Utility_Lua.GetComponent(self.go.transform,"op_UIToggle")
    self.bg_GameObject = self:Get("bg", "GameObject")

end

function UILsSchoolTitleTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnTemplatBtnClick
end

function UILsSchoolTitleTemplate:BindNetMessage()

end

--endregion

--region Show

---@param data.isOpen      boolean  是否开启
---@param data.isCur       boolean  是否为当前
---@param data.callBack    function 模板点击回调
---@param data.title       string   title内容
function UILsSchoolTitleTemplate:SetTemplate(data)
    if data then
        self.data = data
        local stagetetxt = string.Split(data.title, '&')
        self.StageLabel.text = stagetetxt[1]
        self.StageLabel1.text = stagetetxt[2]
        self:SetToggle(data.isCur)
    end
end

--endregion


--region UI函数监听
function UILsSchoolTitleTemplate:OnTemplatBtnClick(go)
    if self.data == nil then
        return
    end
    --if self.data.isOpen then
    if self.data.callBack ~= nil then
        self.data.callBack()
    end
    self:SetToggle(true)
    --end
end

--endregion

--region otherFunction

function UILsSchoolTitleTemplate:SetToggle(isOpen)
    local toggle = self.go_Toggle
    toggle.enabled = isOpen
    self.StageLabel.color = isOpen and CS.UnityEngine.Color.white or CS.UnityEngine.Color(195 / 255, 244 / 255, 1, 1)
    self.StageLabel1.color = isOpen and CS.UnityEngine.Color.white or CS.UnityEngine.Color(195 / 255, 244 / 255, 1, 1)
    self.StageLabel.effectStyle = isOpen and 2 or 0
    self.StageLabel1.effectStyle = isOpen and 2 or 0
    self.bg_GameObject:SetActive(not isOpen)
    self.chackmark:SetActive(isOpen)
    toggle:Set(isOpen)
end

--endregion


return UILsSchoolTitleTemplate