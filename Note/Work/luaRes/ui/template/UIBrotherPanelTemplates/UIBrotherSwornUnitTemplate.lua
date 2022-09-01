local UIBrotherSwornUnitTemplate = {}

--region 初始化

function UIBrotherSwornUnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIBrotherSwornUnitTemplate:InitParameters()

end

function UIBrotherSwornUnitTemplate:InitComponents()
    ---@type UnityEngine.GameObject bg
    self.background = self:Get("background", "GameObject")
    ---@type Top_UISprite icon
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel 昵称
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel 等级
    self.level = self:Get("level", "Top_UILabel")
    ---@type Top_UILabel 状态
    self.state = self:Get("state", "Top_UILabel")
    ---@type UnityEngine.GameObject 同意
    self.btn_yes = self:Get("btn_yes", "GameObject")
    ---@type UnityEngine.GameObject 拒绝
    self.btn_no = self:Get("btn_no", "GameObject")
end

function UIBrotherSwornUnitTemplate:BindUIMessage()
    --点击同意事件
    CS.UIEventListener.Get(self.btn_yes).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_yes).OnClickLuaDelegate = self.OnYesBtnClick
    --点击拒绝事件
    CS.UIEventListener.Get(self.btn_no).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_no).OnClickLuaDelegate = self.OnNoBtnClick
end

function UIBrotherSwornUnitTemplate:BindNetMessage()

end

--endregion

--region Show

---@param data table
---{
---@field data.spriteName   string icon
---@field data.isMainPlayer boolean 是否为主角
---@field data.statu        number 状态
---@field data.name         string 昵称
---@field data.level        number 等级
---@field data.index        number 顺序
---}
function UIBrotherSwornUnitTemplate:SetTemplate(data)
    if data then
        self.background:SetActive(data.index % 2 == 0)
        self.headicon.spriteName = data.spriteName
        self.name.text = data.name
        self.level.text = data.levle
        self.state.text = data.status == 1 and luaEnumColorType.Green .. '已同意' or luaEnumColorType.Red .. '等待中'
        if data.isMainPlayer then
            self.state.gameObject:SetActive(data.status == 1)
        else
            self.state.gameObject:SetActive(true)
        end
        self.btn_yes:SetActive(data.isMainPlayer and data.status ~= 1)
        self.btn_no:SetActive(data.isMainPlayer and data.status ~= 1)
    end
end

function UIBrotherSwornUnitTemplate:RefreshStatu(status)
    self.state.text = status == 1 and luaEnumColorType.Green .. '已同意' or luaEnumColorType.Red .. '等待中'
    self.state.gameObject:SetActive(status == 1)
    self.btn_yes:SetActive(status == 0)
    self.btn_no:SetActive(status == 0)
end

--endregion


--region UI函数监听

--点击同意按钮函数
function UIBrotherSwornUnitTemplate:OnYesBtnClick(go)
    networkRequest.ReqAgreeSworn(1)
end

--点击拒绝按钮函数
function UIBrotherSwornUnitTemplate:OnNoBtnClick(go)
    networkRequest.ReqAgreeSworn(2)
end
--endregion


--region otherFunction



--endregion


return UIBrotherSwornUnitTemplate