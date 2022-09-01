---全服悬赏单元模板
local UIArrestPlayerWordUnitTemplate = {}

--region 初始化

function UIArrestPlayerWordUnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
    -- self:BindNetMessage()
end
--初始化变量
function UIArrestPlayerWordUnitTemplate:InitParameters()
    self.id = 0
    self.IenumRefreshTime = nil
    self.temp = {}
    self.callBack = nil
    self.btnTemp = nil
end

function UIArrestPlayerWordUnitTemplate:InitComponents()
    ---@type Top_UISprite  头像
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel   名称
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel   悬赏金文本 （暂不做处理）
    self.Label = self:Get("Label", "Top_UILabel")
    ---@type Top_UISprite  悬赏金图片
    self.hatred = self:Get("hatred", "Top_UISprite")
    ---@type Top_UILabel   悬赏金
    self.value = self:Get("hatred/value", "Top_UILabel")
    ---@type Top_UILabel   状态
    self.state = self:Get("state", "Top_UILabel")
    ---@type Top_UILabel   悬赏倒计时
    self.time = self:Get("time", "Top_UILabel")
    ---@type UnityEngine.GameObject    背景
    self.background = self:Get("background", "GameObject")
    ---@type UnityEngine.GameObject   通缉标识
    self.wanted = self:Get("wanted", "GameObject")
    ---@type UnityEngine.GameObject   按钮列表
    self.btnGridGo = self:Get("btnTemplat", "GameObject")
end

function UIArrestPlayerWordUnitTemplate:BindUIMessage()
    -- CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    -- CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
    --点击go事件
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoBtnClick
end

function UIArrestPlayerWordUnitTemplate:BindNetMessage()

end

--endregion

--region Show

---@param data table
---{
---@field data.spriteName    string icon
---@field data.name          string 昵称
---@field data.level         number 等级
---@field data.state         number 状态
---@field data.index         number 顺序
---@field data.coinCount     number 悬赏金
---@field data.time          number 进行倒计时
---@field data.offerType     number 悬赏类型
---@field data.clickCallBack function 点击回调
---}
function UIArrestPlayerWordUnitTemplate:SetTemplate(data)
    if data then
        self.id = data.id
        self:SetUI(data)
        self.temp.data = data
        self.temp.panelType = 2
        self.btnGridGo:SetActive(false)
        self.callBack = data.clickCallBack
        if self.btnTemp == nil then
            self.btnTemp = templatemanager.GetNewTemplate(self.btnGridGo, luaComponentTemplates.UIArrestAllBtnTemplate)
        end
        self.btnTemp:SetTemplate(self.temp)
    end
end
--endregion

--region UI

function UIArrestPlayerWordUnitTemplate:SetUI(info)

    self.name.text = info.name
    self.headicon.spriteName = info.spriteName
    self.state.text = info.state == 2 and '已完成' or info.state == 1 and luaEnumColorType.Red .. '进行中' or luaEnumColorType.Gray .. '已过期'
    self.value.text = info.coinCount
    self.background:SetActive(info.index % 2 == 0)
    self.wanted:SetActive(info.offerType ~= nil and info.offerType == 2)
    if info.time ~= 0 then
        if self.IenumRefreshTime ~= nil then
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        end
        self.IenumRefreshTime = StartCoroutine(UIArrestPlayerWordUnitTemplate.IEnumRefreshTime, self, info.time)
    else
        self.time.text = ''
    end

end

--endregion


--region UI函数监听

function UIArrestPlayerWordUnitTemplate:OnGoBtnClick(go)
    --弹出按钮列表
    if self.callBack then
        self.callBack()
    end
end
--endregion


--region otherFunction

function UIArrestPlayerWordUnitTemplate:IEnumRefreshTime(time)
    local isRefresh = true
    local refreshTime = time
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            self.time.text = "00:00:00"
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
        self.time.text = str
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIArrestPlayerWordUnitTemplate:SetShowTemplate(isOpen)
    if isOpen then
        self.btnGridGo:SetActive(not self.btnGridGo.activeSelf)
    else
        self.btnGridGo:SetActive(isOpen)
    end
end

--endregion

function UIArrestPlayerWordUnitTemplate:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIArrestPlayerWordUnitTemplate