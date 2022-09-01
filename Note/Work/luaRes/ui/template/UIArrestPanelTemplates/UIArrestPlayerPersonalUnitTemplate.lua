---个人悬赏单元模板
local UIArrestPlayerPersonalUnitTemplate = {}

--region 初始化

function UIArrestPlayerPersonalUnitTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
    self:InitParameters()
end
--初始化变量
function UIArrestPlayerPersonalUnitTemplate:InitParameters()
    self.id = 0
    self.IenumRefreshTime = nil
    self.temp = {}
    self.callBack = nil
    self.btnTemp = nil
    self.mapNpcId = 0
end

function UIArrestPlayerPersonalUnitTemplate:InitComponents()
    ---@type UnityEngine.GameObject    背景
    self.background = self:Get("background", "GameObject")
    ---@type Top_UISprite              icon
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel               名称
    self.name = self:Get("name", "Top_UILabel")
    ---@type UnityEngine.GameObject    撤销悬赏
    self.btn_unarrest = self:Get("btn_unarrest", "GameObject")
    ---@type UnityEngine.GameObject    进行中倒计时
    self.time = self:Get("time", "Top_UILabel")
    ---@type Top_UILabel               日期
    self.day = self:Get("day", "Top_UILabel")
    ---@type Top_UILabel               完成者
    self.completeplayer = self:Get("completeplayer", "Top_UILabel")
    ---@type UnityEngine.GameObject   按钮列表
    self.btnGridGo = self:Get("btnTemplat", "GameObject")
end

function UIArrestPlayerPersonalUnitTemplate:BindUIMessage()
    --点击go事件
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnGoBtnClick
    --点击撤销
    CS.UIEventListener.Get(self.btn_unarrest).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_unarrest).OnClickLuaDelegate = self.OnUnarrestBtnClick
end

function UIArrestPlayerPersonalUnitTemplate:BindNetMessage()

end

--endregion

--region Show

---@param info table
---{
---@field data.spriteName   string icon
---@field data.name         string 昵称
---@field data.level        number 等级
---@field data.state        number 状态
---@field data.index        number 顺序
---@field data.day          number 完成日期
---@field data.compName     string 完成者
---@field data.mapNpcId     number mapnpcid
---@field data.time         number 进行倒计时
---}
function UIArrestPlayerPersonalUnitTemplate:SetTemplate(data)
    if data then
        self.id = data.id
        self:SetUI(data)
        self.temp.data = data
        self.temp.panelType = 2
        self.mapNpcId = data.mapNpcId
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

function UIArrestPlayerPersonalUnitTemplate:SetUI(info)
    self.name.text = info.name
    self.headicon.spriteName = info.spriteName
    local dataInfo = ''
    if info.state == 2 and info.day >= 0 then
        local dayTime = info.day / 1000
        dayTime = dayTime - dayTime % 1
        dataInfo = os.date("%Y/%m/%d", tonumber(dayTime))
    end
    self.day.text = info.state ~= 2 and '' or '日    期  ' .. dataInfo
    self.completeplayer.text = info.state == 2 and '完成者  ' .. info.compName or ''
    self.background:SetActive(info.index % 2 == 0)
    self.btn_unarrest.gameObject:SetActive(info.state == 1)
    if info.time ~= 0 and info.state ~= 2 then
        if self.IenumRefreshTime ~= nil then
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        end
        self.IenumRefreshTime = StartCoroutine(UIArrestPlayerPersonalUnitTemplate.IEnumRefreshTime, self, info.time)
    else
        self.time.text = ''
    end

end

--endregion

--region UI函数监听

function UIArrestPlayerPersonalUnitTemplate:OnGoBtnClick(go)
    --弹出按钮列表
    if self.callBack then
        self.callBack()
    end
end

---点击撤销函数
function UIArrestPlayerPersonalUnitTemplate:OnUnarrestBtnClick(go)
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqWithdrawOfferShare(self.rid, self.mapNpcId)
    else
        networkRequest.ReqWithdrawOffer(self.rid, self.mapNpcId)
    end
end

--endregion

--region otherFunction

function UIArrestPlayerPersonalUnitTemplate:IEnumRefreshTime(time)
    local isRefresh = true
    local refreshTime = time
    local defaultStr = luaEnumColorType.Red .. '进行中 '
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            self.time.text = defaultStr .. "00:00:00"
        end
        local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
        local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
        self.time.text = defaultStr .. str
        refreshTime = refreshTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIArrestPlayerPersonalUnitTemplate:SetShowTemplate(isOpen)
    if isOpen then
        self.btnGridGo:SetActive(not self.btnGridGo.activeSelf)
    else
        self.btnGridGo:SetActive(isOpen)
    end
end

--endregion

function UIArrestPlayerPersonalUnitTemplate:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIArrestPlayerPersonalUnitTemplate