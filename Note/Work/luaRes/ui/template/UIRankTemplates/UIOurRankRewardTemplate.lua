---有奖励我方排行模板
local UIOurRankRewardTemplate = {}

--region 初始化

function UIOurRankRewardTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIOurRankRewardTemplate:InitParameters()
    self.callBack = nil
    self.timeEndCallBack = nil
    self.isGetReward = false
    self.rankID = 0
    self.type = 0
    self.IEnumTime = nil
    self.waitTime = 0
end

function UIOurRankRewardTemplate:InitComponents()

    ---@type Top_UILabel
    self.MyRankNumber = self:Get("MyRankReward/MyRankNum", "Top_UILabel")
    ---@type Top_UILabel
    self.MyRankTime = self:Get("MyRankTime", "Top_UILabel")
    ---@type Top_UIGridContainer
    self.rewardList = self:Get("rewardList", "Top_UIGridContainer")
    ---@type Top_UISprite
    self.btn_get = self:Get("MyRankReward/btn_get", "Top_UISprite")
    ---@type Top_UILabel
    self.btn_getlabel = self:Get("MyRankReward/btn_get/label", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.btn_getEffect = self:Get("MyRankReward/btn_get/effect", "GameObject")
    ---@type UnityEngine.GameObject
    self.btn_getBox = self:Get("MyRankReward/btn_get/box", "Top_UISprite")
    ---@type Top_UILabel
    self.MyRankName = self:Get("MyRankReward/MyRankName", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.MyRankReward = self:Get("MyRankReward", "GameObject")

end

function UIOurRankRewardTemplate:BindUIMessage()
    --CS.UIEventListener.Get(self.btn_get.gameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.btn_get.gameObject).OnClickLuaDelegate = self.OnGetBtnClick
end

function UIOurRankRewardTemplate:BindNetMessage()

end

--endregion

--region Show
---@param data.rankID          number 排行id
---@param data.type          number 排行类型
---@param data.rankinfo       string 第一个数值 （一般为排行）
---@param data.time            number 时间
---@param data.receive         boolean 是否领取
---@param data.rewardCallBack      function 点击回调
---@param data.timeEndCallBack     function 倒计时结束回调
function UIOurRankRewardTemplate:SetTemplate(data)
    if data then
        --self.rankID = data.rankID
        --self.type = data.type
        --self.isGetReward = data.receive
        --self.callBack = data.rewardCallBack
        self.timeEndCallBack = data.timeEndCallBack
        --self.MyRankNumber.text = data.rankinfo
        --self.MyRankName.text = CS.CSScene.MainPlayerInfo.Name
        --self:SetBtnStatu()
        --self:ShowReward()
        --if self.MyRankTime ~= nil and not CS.StaticUtility.IsNull(self.MyRankTime.gameObject) then
        --    if self.IEnumTime ~= nil then
        --        StopCoroutine(self.IEnumTime)
        --        self.IEnumTime = nil
        --    end
        --    self.IEnumTime = StartCoroutine(self.IEnumtimeCount, self)
        --end
    end
end

function UIOurRankRewardTemplate:SetBtnStatu()
    --self.btn_get.gameObject:SetActive(self.isGetReward)--self.rankID ~= 0
    --self.btn_getEffect:SetActive(self.isGetReward)
    --self.btn_getBox.spriteName = (self.isGetReward) and 'mybox_close' or 'mybox_open'
end

--endregion

--region UI函数监听
function UIOurRankRewardTemplate:OnGetBtnClick(go)
    --if not self.isGetReward or self.rankID == 0 then
    --    return
    --end
    --if self.callBack ~= nil then
    --    self.callBack()
    --    self.isGetReward = false
    --    self:SetBtnStatu()
    --end
    local panel = uimanager:GetPanel("UIRankPanel")
    if panel == nil then
        return
    end
    panel.GetRewardCallBack(self.type, self.rankID)

end

function UIOurRankRewardTemplate:ShowReward()
    if self.callBack ~= nil then
        self.callBack()
    end
end

--endregion

--region otherFunction

function UIOurRankRewardTemplate:IEnumtimeCount()
    local isRefresh = true
    local remainTime = self.waitTime
    if remainTime == nil or remainTime == 0 then
        StopCoroutine(self.IEnumTime)
        self.IEnumTime = nil
        self.MyRankTime.gameObject:SetActive(false)
        if isOpenLog then
            luaDebug.Log("剩余时间为0或空")
        end
        return
    end
    while isRefresh do
        if remainTime <= 0 then
            isRefresh = false
            self.MyRankTime.text = "00:00:00"
            self.timeEndCallBack()
            StopCoroutine(self.IEnumTime)
            self.IEnumTime = nil
        else
            local hour, minute, second = Utility.MillisecondToFormatTime(remainTime)
            local str = string.format("%02.0f:%02.0f:%02.0f", hour, minute, second)
            self.MyRankTime.text = str
        end
        remainTime = remainTime - 1000
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIOurRankRewardTemplate:OnRefreshRankTimeState(time, isOpen)
    if self.MyRankTime == nil or CS.StaticUtility.IsNull(self.MyRankTime.gameObject) then
        return
    end
    if isOpen then
        self.waitTime = time
        if self.IEnumTime ~= nil then
            StopCoroutine(self.IEnumTime)
        end
        self.IEnumTime = StartCoroutine(self.IEnumtimeCount, self)
    else
        if self.IEnumTime ~= nil then
            StopCoroutine(self.IEnumTime)
            self.IEnumTime = nil
        end
    end
    self.MyRankTime.gameObject:SetActive(time ~= nil and time ~= 0 and isOpen)
end

function UIOurRankRewardTemplate:SetRankRewardState(isOpen)
    if self.MyRankReward ~= nil and not CS.StaticUtility.IsNull(self.MyRankReward) then
        self.MyRankReward:SetActive(isOpen)
    end
end

--endregion

function UIOurRankRewardTemplate:OnDestroy()
    if self.IEnumTime ~= nil then
        StopCoroutine(self.IEnumTime)
        self.IEnumTime = nil
    end
end

return UIOurRankRewardTemplate