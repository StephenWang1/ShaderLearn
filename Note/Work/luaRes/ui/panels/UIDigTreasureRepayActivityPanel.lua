---@class UIDigTreasureRepayActivityPanel:UIBase 挖宝回馈
local UIDigTreasureRepayActivityPanel = {}

UIDigTreasureRepayActivityPanel.dig_info = {} --服务器返回的该活动数据
UIDigTreasureRepayActivityPanel.rewards_Info = {} --奖励信息
UIDigTreasureRepayActivityPanel.other_Info = {} -- 从表中获取的有用数据
UIDigTreasureRepayActivityPanel.child_obj = {} -- 从表中获取的有用数据

---@type number 活动开始时间戳
UIDigTreasureRepayActivityPanel.startTimeStamp=0
---@type number 活动结束时间戳
UIDigTreasureRepayActivityPanel.endTimeStamp=0

--gameMgr:GetPlayerDataMgr():GetDigTreasureManager():GetDigCount()  返回当前挖宝次数
--luaclass.LuaDigTreasureRepayActivityManager
--CS.Utility_Lua.CopyGO(,)
--clientTableManager.cfg_special_activityManager:TryGetValue(configId)  根据活动ID获取表格中该条所有数据
--local icon = self:GetComp(itemGo.transform, "icon", "Top_UISprite")
--region Init
function UIDigTreasureRepayActivityPanel:Init(panel)
    self.rootPanel = panel
    self.other_Info.goal = 0   --活动条件最大值
    self.other_Info.goal_list = {} --活动条件列表
    self.other_Info.awards = {}  --活动奖励列表
    self.slider_length = 0  --当前slider长度
    self:RefParam()
    self:InitComponents()
    self:BindMessage()
end

function UIDigTreasureRepayActivityPanel:InitComponents()
    -----@type UnityEngine.GameObject
    self.go_btn_leaveFor = self:GetCurComp("WidgetRoot/view/MainView/btn_leaveFor", "GameObject")
    -----@type Top_UISlider
    self.go_slider = self:GetCurComp("WidgetRoot/view/MainView/DigNum/slider", "Top_UISlider")
    ----@type UILabel
    self.go_dig_num = self:GetCurComp("WidgetRoot/view/MainView/DigItemNum", "UILabel")
    ----@type Top_UILabel
    self.go_time_count = self:GetCurComp("WidgetRoot/view/MainView/TimeCount", "Top_UILabel")
    ----@type UnityEngine.GameObject
    self.go_reward = self:GetCurComp("WidgetRoot/view/MainView/DigNum/Reward", "GameObject")
    ----@type UnityEngine.GameObject
    self.go_reward_l = self:GetCurComp("WidgetRoot/view/MainView/DigNum/Reward/l", "GameObject")
    ----@type UnityEngine.GameObject
    self.go_reward_r = self:GetCurComp("WidgetRoot/view/MainView/DigNum/Reward/r", "GameObject")
    ----@type UnityEngine.GameObject
    self.go_rewards_group = self:GetCurComp("WidgetRoot/view/MainView/DigNum/Reward/rewards", "GameObject")
    ----@type UnityEngine.GameObject
    self.go_rewards_temp = self:GetCurComp("WidgetRoot/view/MainView/DigNum/Reward/rewards/temp", "GameObject")
    ----@type UICountdownLabel
    self.mTimeCountLabel=self:GetCurComp("WidgetRoot/view/MainView/TimeCount", "UICountdownLabel")

    self.slider_length = self.go_reward_r.transform.localPosition.x - self.go_reward_l.transform.localPosition.x

    for i = 1, #self.rewards_Info do
        --根据当前奖励数量  生成对应数量的奖励格子
        local obj = CS.Utility_Lua.CopyGO(self.go_rewards_temp,self.go_rewards_group.transform)
        obj:SetActive(true)
        table.insert(self.child_obj,obj)

        local self_Text = self:GetComp(obj.transform, "num", "Top_UILabel")
        self_Text.text = self.other_Info.goal_list[i]
        --根据奖励条件中的最大值 计算克隆的实际X轴位置
        self:RefreshRewardGid(obj,self.other_Info.goal_list[i],self.other_Info.goal)
    end
end


--endregion

--region bind event
function UIDigTreasureRepayActivityPanel:BindMessage()
    luaclass.UIRefresh:BindClickCallBack(self.go_btn_leaveFor, function()
        self:OnTransfer()
    end)
end
--endregion

--region
function UIDigTreasureRepayActivityPanel:RefParam()
    self.dig_info = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetSingleActivityData(19)
    self.rewards_Info = self.dig_info.oneActivitiesInfo
    table.sort(self.rewards_Info, function(x,y)
        return x.configId < y.configId
    end)
    self:GetOtherData()
end

function UIDigTreasureRepayActivityPanel:Show(data)
    self.startTimeStamp=data.mStartTime * 1000
    self.endTimeStamp=data.mFinishTime * 1000
    self:RefParam()
    self:RefreshPanel()
end
--endregion

--region
function UIDigTreasureRepayActivityPanel:RefreshPanel()
    local num = self.rewards_Info[1].dataParam
    self.go_dig_num.text = '黄金鹤嘴锄挖掘次数  '  .. num .. ' 次'
    self.go_slider.value = num / self.other_Info.goal
    self:RefreshFinishTimeCount()
    self:RefreshRewardItem()
end

---刷新活动倒计时
function UIDigTreasureRepayActivityPanel:RefreshFinishTimeCount()
    --测试倒计时
    if self.endTimeStamp == nil or self.endTimeStamp == 0 then
        self.mTimeCountLabel:StopCountDown()
        if CS.StaticUtility.IsNull(self.mTimeCountLabel._Label) == false then
            self.mTimeCountLabel._Label.text=""
        end
        return
    end
    self.mTimeCountLabel:StartCountDown(100, 8, self.endTimeStamp, "活动倒计时  ", "", nil, nil)
end

---刷新奖励展示
---@param go UnityEngine.GameObject
---@param reward CommonShowRewards
function UIDigTreasureRepayActivityPanel:RefreshRewardItem()
    for i = 1, #self.other_Info.awards do
        local itemId = self.other_Info.awards[i][1]
        local itemGo = self.child_obj[i]
        --根据领奖状态 控制领取图标开关
        local self_get = self:GetComp(itemGo.transform, "get", "GameObject")
        local self_completeEffect = self:GetComp(itemGo.transform, "completeEffect", "GameObject")
        self_get:SetActive(self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.RECEIVE)
        self_completeEffect:SetActive(self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.CAN_RECEIVE)
        local res2, itemTable = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        if (res2) then
            local uiItem = templatemanager.GetNewTemplate(itemGo, luaComponentTemplates.UIItem)
            if uiItem then
                uiItem:RefreshUIWithItemInfo(itemTable, num)
                --判断当前物品领取状态 分别添加事件
                if self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.NOT_RECEIVE then
                    CS.UIEventListener.Get(itemGo).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = uiItem.ItemInfo, showRight = false })
                    end
                elseif self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.RECEIVE then
                    CS.UIEventListener.Get(itemGo).onClick = function()
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = uiItem.ItemInfo, showRight = false })
                    end
                elseif self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.CAN_RECEIVE then
                    --点击后领奖  开启红点
                    CS.UIEventListener.Get(itemGo).onClick = function()
                        networkRequest.ReqGetOneActivitiesAward(self.rewards_Info[i].configId)
                        self.rewards_Info[i].finish = LuaDigTreasureRepayActivityState.RECEIVE
                        self_completeEffect:SetActive(self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.CAN_RECEIVE)
                        self_get:SetActive(self.rewards_Info[i].finish == LuaDigTreasureRepayActivityState.RECEIVE)
                        self:RefreshRewardItem()
                    end
                end
            end
        end
    end
end
--endregion

---初始化物品格子位置  当前slider宽度self.slider_length
---@param obj UnityEngine.GameObject
---@param cur number
---@param max number
function UIDigTreasureRepayActivityPanel:RefreshRewardGid(obj,cur,max)
    local ratio = cur/max
    obj.transform.localPosition = CS.UnityEngine.Vector3(obj.transform.localPosition.x + ratio* self.slider_length,0,0)
end

---通过rewards_Info中的活动ID  获取最大的奖励条件 以及奖励物品信息
function UIDigTreasureRepayActivityPanel:GetOtherData()
    for k,v in pairs(self.rewards_Info) do
        local configData = gameMgr:GetPlayerDataMgr():GetSpecialActivityData():GetDigTreasureRepayActivityData(v.configId)

        if configData ~= nil then
            -- 添加到other_Info中  最大数量需要比较 物品信息直接插入
            if self.other_Info.goal < configData.goal then
                self.other_Info.goal = configData.goal
            end
            if self.other_Info.awards ~= nil then
                self.other_Info.awards[k] = configData.award
            else
                table.insert(self.other_Info.awards,configData.award)
            end
            if self.other_Info.goal_list ~= nil then
                self.other_Info.goal_list[k] = configData.goal
            else
                table.insert(self.other_Info.goal_list,configData.goal)
            end
        end
    end
end

function UIDigTreasureRepayActivityPanel:OnTransfer()
    local sds = luaclass.LuaSpecialActivityData:GetSingleActivityData(19)
    local transferId = self:GetTransferID()
    if (transferId ~= nil and type(transferId) == 'number') then
        Utility.TryTransfer(transferId, false)
    end
end

function UIDigTreasureRepayActivityPanel:GetTransferID()
    --if (self.transferID == nil) then
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23066)
        if isFind and not Utility.IsNilOrEmptyString(tbl_global.value) then
            local transferID = tonumber(tbl_global.value)
            return transferID
        end
    --end
end


return UIDigTreasureRepayActivityPanel