---灵兽任务模板
local UILsSchoolItemTemplate = {}

--region 初始化

function UILsSchoolItemTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UILsSchoolItemTemplate:InitParameters()

    self.itemData = nil
    self.itemInfo = nil
    self.rewardList = {}
    self.delayRefresh = nil

end

function UILsSchoolItemTemplate:InitComponents()

    ---@type Top_UISprite 物品icon
    self.award = self:Get("Award", "GameObject")
    ---@type Top_UISprite 物品icon
    self.icon = self:Get("Award/icon", "Top_UISprite")
    ---@type Top_UISprite 物品数量
    self.count = self:Get("Award/count", "Top_UILabel")
    ---@type Top_UISprite 物品icon
    self.di = self:Get("di", "Top_UISprite")
    ---@type Top_UILabel  物品数量
    self.count = self:Get("Award/count", "Top_UILabel")
    ---@type Top_UILabel 任务介绍
    self.Title = self:Get("Title", "Top_UILabel")
    ---@type Top_UILabel 任务描述
    self.Description = self:Get("Description", "Top_UILabel")
    ---@type UnityEngine.GameObject  已获取图片
    self.geted = self:Get("geted", "GameObject")
    ---@type UnityEngine.GameObject 获取按钮
    self.btn_get = self:Get("btn_get", "GameObject")
    ---@type UnityEngine.GameObject 获取按钮特效
    self.getEffect = self:Get("btn_get/Effect", "GameObject")
    ---@type UnityEngine.GameObject 前往按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---@type Top_UISlider
    self.lv_TaskFill = self:Get("lv_TaskFill", "Top_UISlider")
    ---@type GameObject
    self.fillThumb = self:Get("lv_TaskFill/thumb", "GameObject")
    ---@type Top_UILabel
    self.taskexpvalue = self:Get("taskexpvalue", "Top_UILabel")
    ---@type UnityEngine.GameObject 特效
    self.effect = self:Get("Award/icon/Effect", "GameObject")
    ---@type UnityEngine.GameObject 特效
    self.strategyBtn = self:Get("strategy", "GameObject")
end

function UILsSchoolItemTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.btn_get).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_get).OnClickLuaDelegate = self.OnGetBtnClick
    CS.UIEventListener.Get(self.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = self.OnGOBtnClick
    CS.UIEventListener.Get(self.award).LuaEventTable = self
    CS.UIEventListener.Get(self.award).OnClickLuaDelegate = self.OnIconBtnClick
    CS.UIEventListener.Get(self.strategyBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.strategyBtn).OnClickLuaDelegate = self.OnStrategyBtnClick
end

function UILsSchoolItemTemplate:BindNetMessage()

end

--endregion

--region Show

---@param info   CS.CSLsMission    灵兽试炼任务单元
function UILsSchoolItemTemplate:SetTemplate(info, index)
    if info then
        self.itemData = info
        self:SetTaskofStatu(info.statu)
        self:SetReWard(info)
        self.effect.gameObject:SetActive(false)
    end
end

function UILsSchoolItemTemplate:SetTaskofStatu(statu)

    local fill = ''
    local color = luaEnumColorType.Red
    if self.itemData.fillMaxValue == 0 then
        fill = ''
        self.lv_TaskFill.value = 0
        self.fillThumb:SetActive(false)
    else
        color = self.itemData.curFillValue >= self.itemData.fillMaxValue and luaEnumColorType.Green or luaEnumColorType.Red
        fill = self.itemData.targetDes .. color .. self.itemData.curFillValue .. '[-]/' .. self.itemData.fillMaxValue
        self.lv_TaskFill.value = self.itemData.curFillValue / self.itemData.fillMaxValue
        self.fillThumb:SetActive(self.itemData.curFillValue ~= 0)
    end

    local meetGet = self.itemData.statu == CS.LsMissionStatu.Get
    local meetGeted = self.itemData.statu == CS.LsMissionStatu.Geted
    local meetNotGet = self.itemData.statu == CS.LsMissionStatu.NotGet
    --local meetValue = self.itemData.curFillValue > self.itemData.fillMaxValue

    self.btn_get:SetActive(meetGet)
    self.btn_go:SetActive(meetNotGet)
    self.geted:SetActive(meetGeted)

    self.Title.text = self.itemData.taskTitle
    --.."(" .. fill .. ")"
    self.taskexpvalue.text = fill
    --meetValue and self.itemData.taskTitle .. ' [00ffff00]' .. fill .. '[-]' or self.itemData.taskTitle .. ' ' .. fill
    --self.Description.text = self.itemData.taskDes
end

function UILsSchoolItemTemplate:SetReWard(info)
    self.rewardList = {}
    local temp = {}
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.rewardID)
    if isFind then
        self.icon.spriteName = itemInfo.icon
        self.itemInfo = itemInfo
        temp.itemId = itemInfo.id
    end
    self.count.gameObject:SetActive(true)
    self.count.text = (info.rewardCount == 1 or info.rewardCount == 0) and "" or info.rewardCount
    temp.count = info.rewardCount
    table.insert(self.rewardList, temp)
end

--endregion


--region UI函数监听

--点击领取
function UILsSchoolItemTemplate:OnGetBtnClick(go)
    --self.effect.gameObject:SetActive(true)
    networkRequest.ReqGetRewards(self.itemData.taskID)
    uimanager:CreatePanel("UIRewardTipsPanel", nil, { rewards = self.rewardList })
    --self.delayRefresh = CS.CSListUpdateMgr.Add(1500, nil, function()
    --
    --    if self.delayRefresh ~= nil then
    --        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
    --        self.delayRefresh = nil
    --    end
    --end)
end

function update()

end

--点击前往
function UILsSchoolItemTemplate:OnGOBtnClick(go)
    --进行跳转
    local isFind, info = CS.Cfg_LingShouTaskTableManager.Instance.dic:TryGetValue(self.itemData.taskID)
    if isFind then
        if info.conditions ~= nil and info.conditions ~= 0 then
            if not self:isTrans(info.conditions) then
                Utility.ShowPopoTips(go, nil, info.bubbleID)
                return
            end
        end
        uiTransferManager:TransferToPanel(tonumber(info.uipanel))
        uimanager:ClosePanel('UILsSchoolPanel')
    end
end

function UILsSchoolItemTemplate:OnIconBtnClick()
    if self.itemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.itemInfo })
    end
end

function UILsSchoolItemTemplate:OnStrategyBtnClick()
    if self.itemData and self.itemData.secretBookKeyword then
        uimanager:CreatePanel("UISecretBookPanel", nil, self.itemData.secretBookKeyword)
    end
end

--endregion


--region otherFunction

---是否可跳转
---@private
function UILsSchoolItemTemplate:isTrans(conditionId)
    return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionId);
end

--endregion

function UILsSchoolItemTemplate:OnDestroy()
    if CS.CSObjectPoolMgr.Instance ~= nil then
        CS.CSObjectPoolMgr.Instance:RemoveUIPoolItem(self.getEffectPool)
    end
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end

    --if CS.CSResourceManager.Instance ~= nil and self ~= nil then
    --    if self.getEffect_Path ~= nil or self.getEffect_Path ~= '' then
    --        CS.CSResourceManager.Instance:ForceDestroyResource(self.getEffect_Path)
    --    end
    --end
end
return UILsSchoolItemTemplate