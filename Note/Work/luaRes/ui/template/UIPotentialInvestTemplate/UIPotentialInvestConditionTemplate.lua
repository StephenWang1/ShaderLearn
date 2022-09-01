---@class UIPotentialInvestConditionTemplate:TemplateBase
local UIPotentialInvestConditionTemplate = {}

function UIPotentialInvestConditionTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end

function UIPotentialInvestConditionTemplate:InitComponents()
    ---@type Top_UISprite 长背景
    self.longbg = self:Get("bg", "Top_UISprite")
    ---@type Top_UISprite 短背景
    self.shortbg = self:Get("shortbg", "Top_UISprite")
    ---@type Top_UILabel 描述
    self.desc = self:Get("desc", "Top_UILabel")
    ---@type Top_UIGridContainer 奖励
    self.rewardGrid = self:Get("AwardScroll/AwardGrid", "Top_UIGridContainer")
    ---@type UnityEngine.GameObject 已领取
    self.geted = self:Get("geted", "GameObject")
    ---@type UnityEngine.GameObject 未达成
    self.notGet = self:Get("Notgeted", "GameObject")
    ---@type UnityEngine.GameObject 领取按钮
    self.getBtn = self:Get("btn_get", "GameObject")
    ---@type UnityEngine.GameObject 激活按钮
    self.activeBtn = self:Get("btn_active", "GameObject")
    ---@type UnityEngine.GameObject
    self.cost_obj = self:Get("cost", "GameObject")
    ---@type UILabel 需要花费的钻石
    self.cost_num = self:Get("cost/num", "UILabel")
    ---@type UnityEngine.GameObject 激活按钮过期
    self.pastedBtn = self:Get("Notime", "GameObject")
end

function UIPotentialInvestConditionTemplate:InitParameters()
    self.potentialInvestId = 0
    ---@type LuaSpecailActivityRewardState
    self.rewardState = 0
    ---@type TABLE.cfg_potential_invest
    self.potentialInvestTbl = nil
    ---@type TABLE.cfg_conditions
    self.conditionTbl = nil

    self.RewardItemTemplateDic = {}
    self.isOpen = false
    self.type = nil
    self.index = nil
    self.potentialInvestTypeDic = { "石化", "诅咒", "急速" }
end

function UIPotentialInvestConditionTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.getBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.getBtn).OnClickLuaDelegate = self.OnGetBtnClick

    CS.UIEventListener.Get(self.activeBtn).onClick = function(go)
        self:OnActiveBtnClick()
    end
end

function UIPotentialInvestConditionTemplate:OnGetBtnClick(go)
    if self.rewardState == LuaSpecailActivityRewardState.Get then
        networkRequest.ReqReceiveFashionInvest(self.potentialInvestId)
    end
end

-- 激活按钮事件
function UIPotentialInvestConditionTemplate:OnActiveBtnClick()
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.PotentialInvest
    -- 钻石不足时 跳转充值界面
    local coincount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(1000001)
    if coincount < self:GetActiveNeedCoin() then
        ---@type UIRechargePanel
        Utility.TryShowFirstRechargePanel()
    else
        networkRequest.ReqActiveFashionInvest(self.type)
    end
end

-- 激活需要的钻石数值
function UIPotentialInvestConditionTemplate:GetActiveNeedCoin()
    local isFind, tbl = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(22884)
    if not isFind then
        return 0
    end

    local infoArray = string.Split(tbl.value, '&')
    for i = 1, #infoArray do
        local data = string.Split(infoArray[i], '#')
        if self.type == tonumber(data[1]) then
            return tonumber(data[2])
        end
    end
    return 0
end

-- @param data table
function UIPotentialInvestConditionTemplate:RefreshUI(data)
    self.potentialInvestId = data.info.id
    self.rewardState = data.info.state
    self.isOpen = data.isOpen
    self.type = data.potentialInvestType
    self.index = data.line
    self:RefreshData()
    self:RefreshView()
end

function UIPotentialInvestConditionTemplate:RefreshData()
    self.potentialInvestTbl = clientTableManager.cfg_potential_investManager:TryGetValue(self.potentialInvestId)
    self.conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(self.potentialInvestTbl:GetCondition())

end

function UIPotentialInvestConditionTemplate:RefreshView()
    if self.potentialInvestTbl == nil then
        return
    end
    if self.conditionTbl ~= nil then
        self.desc.text = self.conditionTbl:GetShow()
    else
        local str = "[fbd053]投资可以立即领取%s装备\n更有超多达标奖励[-]"
        self.desc.text = string.format(str, self.potentialInvestTypeDic[self.type])
    end
    self:RefreshState()
    self:RefreshRewardView()
end

function UIPotentialInvestConditionTemplate:RefreshState()
    -- 第一条数据 红色背景图
    self.longbg.spriteName = self.index == 0 and "PotentialInvest_listbg" or "PotentialInvest_listbg2"
    if self.isOpen then
        self.getBtn:SetActive(self.rewardState == LuaSpecailActivityRewardState.Get)
        self.geted:SetActive(self.rewardState == LuaSpecailActivityRewardState.Geted)
        self.notGet:SetActive(self.rewardState == LuaSpecailActivityRewardState.NotGet)
        self.activeBtn:SetActive(false)
        self.cost_obj:SetActive(false)
        self.pastedBtn:SetActive(false)
    else
        local isFind, tbl_global = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(23070)
        --是否在限制时间范围中 wxs
        local isOnTime = false
        if isFind then
            local strs = string.Split(tbl_global.value, '#')
            for i = 1, #strs do
                if not CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(tonumber(strs[i])) then
                    isOnTime = true
                    break
                end
            end
        end
        --isOnTime = true
        if self.index == 0 and not isOnTime then
            self.activeBtn:SetActive(false)
            self.cost_obj:SetActive(false)
            self.pastedBtn:SetActive(true)
        else
            self.activeBtn:SetActive(self.index == 0)
            self.cost_obj:SetActive(self.index == 0)
            self.pastedBtn:SetActive(false)
        end
        self.getBtn:SetActive(false)
        self.geted:SetActive(false)
        self.notGet:SetActive(false)
        self.cost_num.text = self:GetActiveNeedCoin()
    end

end

function UIPotentialInvestConditionTemplate:RefreshRewardView()
    if self.potentialInvestTbl == nil then
        return
    end
    local rewardlist = self:GetRewardList()
    if rewardlist == nil then
        return
    end
    self.rewardGrid.MaxCount = #rewardlist
    for i = 1, #rewardlist do
        local go = self.rewardGrid.controlList[i - 1]
        ---@type UIItem
        local template = self.RewardItemTemplateDic[go]
        if rewardlist[i] ~= nil then
            local info = string.Split(rewardlist[i], '#')
            if template == nil then
                template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                self.RewardItemTemplateDic[go] = template
            end
            local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tonumber(info[1]))
            if isFind then
                template:RefreshUIWithItemInfo(itemInfo, tonumber(info[2]))
                template:RefreshOtherUI({ showItemInfo = itemInfo })
            end

            if template:GetResSprite_UISprite() ~= nil and not CS.StaticUtility.IsNull(template:GetResSprite_UISprite()) then
                template:GetResSprite_UISprite().gameObject:SetActive(i == 1 and self.rewardState ~= LuaSpecailActivityRewardState.Geted)
            end
        end
    end
end

-- 根据性别和职业处理奖励数据
function UIPotentialInvestConditionTemplate:GetRewardList()
    if self.potentialInvestTbl == nil then
        return nil
    end
    local str = self.potentialInvestTbl:GetReward()
    if str == nil or str == "" then
        return nil
    end
    local RewardDataDic = {}
    local playerCareer = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Career)
    local playerSex = Utility.EnumToInt(CS.CSScene.MainPlayerInfo.Sex)
    local itemList = string.Split(str, "&")
    for i, v in pairs(itemList) do
        local tempList = string.Split(v, "#")
        local _career = 0
        local _sex = 0
        local careerMatch = false
        local sexMatch = false
        if #tempList >= 2 then
            if #tempList == 3 then
                _career = tonumber(tempList[3])
            end
            if #tempList == 4 then
                _sex = tonumber(tempList[4])
            end
            if (_career == 0 or _career == playerCareer) then
                careerMatch = true
            end
            if (_sex == 0 or _sex == playerSex) then
                sexMatch = true
            end
            if (careerMatch and sexMatch) then
                table.insert(RewardDataDic, v)
            end
        end
    end
    return RewardDataDic
end

return UIPotentialInvestConditionTemplate