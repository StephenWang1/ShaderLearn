local UILeftAcitvityUnitTemplates = {}

--region 初始化

function UILeftAcitvityUnitTemplates:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
end
--初始化变量
function UILeftAcitvityUnitTemplates:InitParameters()
    self.isAcitivity = false
    self.bgSize_Y_Min = 20;
end

function UILeftAcitvityUnitTemplates:InitComponents()
    ---@type Top_UISprite icon
    self.task_type = self:Get("mission/task_type", "Top_UISprite")
    ---@type Top_UILabel  标题
   -- self.lb_tilte = self:Get("mission/lb_tilte", "Top_UILabel")
    ---@type Top_UILabel 内容
    self.lb_content = self:Get("mission/lb_content", "Top_UILabel")
    self.lb_content2 = self:Get("mission/lb_content2", "Top_UILabel")

    self.lb_content_target = self:Get("mission/lb_content_target", "Top_UILabel")
    self.lb_content_target2 = self:Get("mission/lb_content_target2", "Top_UILabel")
    ---@type Top_UILabel 任务状态
    self.lb_state = self:Get("mission/lb_state", "Top_UILabel")
    ---@type Top_UISprite 背景图片
    self.bg = self:Get("mission/bg", "Top_UISprite")
    ---@type Top_UISprite 任务类型底板图片
    self.bg2 = self:Get("mission/bg2", "Top_UISprite")
end

function UILeftAcitvityUnitTemplates:InitState()
    --self.lb_tilte.gameObject:SetActive(false)
    self.lb_content2.gameObject:SetActive(false)
    self.lb_content_target2.gameObject:SetActive(false)
    self.lb_content_target.gameObject:SetActive(false)
    self.bg2.spriteName = 'richangdise'
    self.task_type.spriteName = 'richang'
    self.lb_content.fontSize = 18


end

function UILeftAcitvityUnitTemplates:BindUIMessage()
    CS.UIEventListener.Get(self.bg.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.bg.gameObject).OnClickLuaDelegate = self.OnGetGoClick
end

function UILeftAcitvityUnitTemplates:InitPos()
    local content1Position = self.lb_content.transform.localPosition
    self.lb_content.fontSize = 18
    content1Position.y = -(self.bgSize_Y_Min)-2
    self.lb_content.transform.localPosition = content1Position

    local statePosition = self.lb_state.transform.localPosition
    statePosition.y = content1Position.y
    self.lb_state.transform.localPosition = statePosition

    local typePosition = self.task_type.transform.localPosition
    typePosition.y = content1Position.y+2
    self.task_type.transform.localPosition = typePosition

end

--endregion

--region Show

function UILeftAcitvityUnitTemplates:SetTemplate()
   -- self:InitPos()
    self:InitState()
    self.lb_content.text = luaEnumColorType.White .. '每日活跃度'
    self:RefreshAmount()
end

--endregion

function UILeftAcitvityUnitTemplates:RefreshAmount()
    self.lb_state.text = CS.CSScene.MainPlayerInfo.ActiveInfo:GetActiveNumber() .. '/' .. CS.Cfg_Active_RewardTableManager.Instance.MaxActiveNumber
end

--region UI函数监听

function UILeftAcitvityUnitTemplates:OnGetGoClick()
    --跳转活跃界面
    uimanager:CreatePanel("UIDayToDayPanel")
end

--endregion


--region otherFunction

---设置面板位置
function UILeftAcitvityUnitTemplates:SetPosition(position_Y)
    local newPosition = self.go.transform.localPosition
    newPosition.y = position_Y
    self.go.transform.localPosition = newPosition
end

--endregion


return UILeftAcitvityUnitTemplates