local UIBrotherSeverUnitTemplate = {}

--region 初始化

function UIBrotherSeverUnitTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIBrotherSeverUnitTemplate:InitParameters()
    --self.callBack = nil
    self.IenumRefreshTime = nil
    self.data = nil
end

function UIBrotherSeverUnitTemplate:InitComponents()
    ---@type UnityEngine.GameObject bg
    self.background = self:Get("background", "GameObject")
    ---@type Top_UISprite icon
    self.headicon = self:Get("headicon", "Top_UISprite")
    ---@type Top_UILabel 昵称
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel
    self.level = self:Get("level", "Top_UILabel")
    ---@type Top_UILabel 亲密度
    self.value = self:Get("intimacy/value", "Top_UILabel")
    ---@type Top_UISprite 亲密度图片
    self.intimacy = self:Get("intimacy", "Top_UISprite")
    ---@type Top_UILabel 时间
    self.time = self:Get("time", "Top_UILabel")
    ---@type UnityEngine.GameObject 断义按钮
    self.btn_sever = self:Get("btn_sever", "GameObject")
    ---@type UnityEngine.GameObject 考虑按钮
    self.btn_consider = self:Get("btn_consider", "GameObject")
end

function UIBrotherSeverUnitTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn_sever).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_sever).OnClickLuaDelegate = self.OnBtnClick
    CS.UIEventListener.Get(self.btn_consider).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_consider).OnClickLuaDelegate = self.OnConsiderBtnClick
end

--endregion

--region Show

---@param data table
---{
---@field data.id         number id
---@field data.spriteName string icon
---@field data.status      number 状态 1:正在解散 2:未解散
---@field data.name       string 昵称
---@field data.level      number 等级
---@field data.index      number 顺序
---@field data.time       number  时间 ms
---@field data.qmd        number  亲密度
---@field data.callBack   function 点击回调
---}
function UIBrotherSeverUnitTemplate:SetTemplate(data)
    if data then
        self.data = data
        self.background:SetActive(data.index % 2 == 0)
        self.headicon.spriteName = data.spriteName
        self.name.text = data.name
        self.value.text = data.qmd
        self.level.text = data.level
        self.btn_consider:SetActive(data.status == 1)
        self.btn_sever:SetActive(data.status == 2)
        self.time.gameObject:SetActive(data.time ~= 0 and data.status == 1)
        if self.IenumRefreshTime ~= nil then
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        end
        self.IenumRefreshTime = StartCoroutine(UIBrotherSeverUnitTemplate.IEnumRefreshTime, self, data.time)
    end
end

function UIBrotherSeverUnitTemplate:RrfreshStatus(status, time)
    self.btn_consider:SetActive(status == 1)
    self.btn_sever:SetActive(status == 2)
    self.time.gameObject:SetActive(time ~= 0 and status == 1)
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if self.data.time ~= 0 and status == 1 then
        self.IenumRefreshTime = StartCoroutine(UIBrotherSeverUnitTemplate.IenumRefreshTime, self, time)
    end
end

function UIBrotherSeverUnitTemplate:ShowBubbleTips(go, itenName)
    local isFind, info = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(92)
    if isFind then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = info.id
        TipsInfo[LuaEnumTipConfigType.Describe] = string.format(info.content, itenName)
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
    end
end

--endregion


--region UI函数监听

---点击断义函数
function UIBrotherSeverUnitTemplate:OnBtnClick(go)

    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(27)
    if isFind then
        local temp = {}
        temp.Content = string.format(info.des, self.data.name)
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 27
        temp.CallBack = function()
            networkRequest.ReqDissolutionBrother(self.data.id)
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end

end

---点击取消断义函数
function UIBrotherSeverUnitTemplate:OnConsiderBtnClick(go)
    --判断所需物品是否拥有
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
        return
    end
    local itemInfo = CS.CSScene.MainPlayerInfo.FriendInfoV2.NeedGlodInfo
    local itemNeedCount = CS.CSScene.MainPlayerInfo.FriendInfoV2.NeedGlodCount
    if itemInfo ~= nil then
        if itemInfo.type == luaEnumItemType.Coin then
            local count = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(itemInfo.id)
            --if isFind then
            if count < itemNeedCount then
                self:ShowBubbleTips(go, CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo.id))
                return
            end
            --end
        else
            local itemCount = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCount(itemInfo.id)
            if itemCount < itemNeedCount then
                self:ShowBubbleTips(go, CS.Cfg_ItemsTableManager.Instance:GetItemName(itemInfo.id))
                return
            end
        end
    end

    --二次确认
    local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(28)
    if isFind then
        local temp = {}
        temp.Content = info.des
        temp.LeftDescription = info.leftButton
        temp.RightDescription = info.rightButton
        temp.ID = 28
        temp.CallBack = function()
            networkRequest.ReqRegretsDissolution(self.data.id)
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end

--endregion


--region otherFunction

function UIBrotherSeverUnitTemplate:IEnumRefreshTime(time)
    local isRefresh = true
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    local refreshTime = time - serverNowTime
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            self.time.text = "00:00:00"
            StopCoroutine(self.IenumRefreshTime)
            self.IenumRefreshTime = nil
        else
            local hour, minute, second = Utility.MillisecondToFormatTime(refreshTime)
            local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
            self.time.text = str
            refreshTime = refreshTime - 1000
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

--endregion

function UIBrotherSeverUnitTemplate:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIBrotherSeverUnitTemplate