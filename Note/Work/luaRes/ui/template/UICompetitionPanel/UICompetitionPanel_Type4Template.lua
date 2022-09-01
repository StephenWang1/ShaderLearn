---@class UICompetitionPanel_Type4Template:TemplateBase 战勋模板
local UICompetitionPanel_Type4Template = {}

---@param panel UICompetitionPanel
function UICompetitionPanel_Type4Template:Init(panel)
    self.rootPanel = panel
    self:InitComponent()
    self:BindEvent()
end

function UICompetitionPanel_Type4Template:InitComponent()
    ---@type UISprite
    ---背景
    self.mBg_UISprite = self:Get("backGround", "UISprite")
    ---@type UISprite
    ---子节点背景
    self.mChildBg_UISprite = self:Get("templateSmall/backGround", "UISprite")
    ---小目标
    ---@type UnityEngine.GameObject
    self.mChild_Go = self:Get("templateSmall", "GameObject")

    ---icon1 图片
    ---@type UISprite
    self.mIcon1_Sprite = self:Get("icon1", "UISprite")

    ---icon2 背景
    ---@type UISprite
    self.mIcon2_Sprite = self:Get("icon2", "UISprite")

    ---icon3 标签
    ---@type UISprite
    self.mIcon3_Sprite = self:Get("icon3", "UISprite")

    ---描述
    ---@type UILabel
    self.mDescription = self:Get("description", "UILabel")

    ---进度
    ---@type UILabel
    self.progress_UILabel = self:Get("progress", "UILabel")

    ---@type UIGridContainer
    ---奖励列表
    self.rewardList_UIGridContainer = self:Get("rewardList", "UIGridContainer")

    ---@type UIGridContainer
    ---二级目标
    self.mSmallAim_UIGridContainer = self:Get("templateSmall/smalAim", "UIGridContainer")

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.mGetBtn_Go = self:Get("btn_get", "GameObject")

    ---@type UnityEngine.GameObject
    ---前往按钮
    self.mGetBtn_GoTo = self:Get("btn_goto", "GameObject")

    ---@type UnityEngine.GameObject
    ---红点
    self.mRedPointGo = self:Get("redPoint", "GameObject")

    ---@type UnityEngine.GameObject
    ---领完文字
    self.finish_GameObject = self:Get("finish", "GameObject")

    ---未完成GO
    ---@type UnityEngine.GameObject
    self.UnFinish_GO = self:Get("unFinish", "GameObject")

    ---已领完(指自己未领,其他人已经领完了)
    ---@type UnityEngine.GameObject
    self.nullToGet = self:Get("remainNull", "GameObject")

    ---剩余数量
    ---@type UILabel
    self.mRemainLabel = self:Get("remain", "UILabel")
end

function UICompetitionPanel_Type4Template:BindEvent()
    CS.UIEventListener.Get(self.mBg_UISprite.gameObject).onClick = function()
        self:ChooseItem()
    end
    CS.UIEventListener.Get(self.mGetBtn_Go).onClick = function()
        self:OnRewardBtnClicked()
    end
    CS.UIEventListener.Get(self.mGetBtn_GoTo).onClick = function()
        self:OnRewardBtnGoToClicked()
    end
end

UICompetitionPanel_Type4Template.mNeedShowChild = false

---刷新
---@param data activityV2.ActivityDataInfo 活动数据
---@param tableData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type4Template:Refresh(data, tableData, registerNum, line)
    --self.mNeedShowChild = false
    self.mCanReward = false
    ---@type table<number,activityV2.ActivityDataInfo>
    self.childData = {}
    self.data = data
    self.tblData = tableData
    ---@type boolean 是否完成
    self.isFinish = false
    ---@type boolean 是否已经领取
    self.hasGet = false
    ---@type boolean 子目标是否有可领
    self.isFinishChild = false
    ---@type boolean 子目标是否有可领
    self.isAllChildRewarded = true
    ---@type number 子节点高度
    self.mSmallChildHeight = 0
    ---@type boolean 是否可点小目标
    self.mCanShowSmallChild = false

    self.mCurrentState = nil
    if tableData and data then
        --必须先刷子节点后两个方法数据需要
        self:RefreshChildShow(data, tableData)
        self:RefreshBtnShow(data, tableData)--这里存储了状态，必须在RefreshBasicShow方法前执行
        self:RefreshBasicShow(data, tableData)
        self:RefreshColorEct()
    end
    self:SetChildShow()
    if line then
        self.line = line
    end
end

---刷新基础显示
---@param data activityV2.ActivityDataInfo 活动数据
---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type4Template:RefreshBasicShow(data, tblData)
    local careerIcon = string.Split(tblData.icon, '#')
    local career = self.rootPanel:GetMainPlayerInfo().Career
    local index = Utility.EnumToInt(career)
    if index <= #careerIcon then
        self.mIcon1_Sprite.spriteName = careerIcon[index]
    else
        self.mIcon1_Sprite.spriteName = careerIcon[1]
    end

    self.mIcon2_Sprite.spriteName = tblData.icon2
    self.mIcon3_Sprite.spriteName = tblData.icon3

    --领完/领取
    local allFinish = (self.mCurrentState == 2 or self.mCurrentState == 4)

    --local remainText = ""
    if tblData.awardtype == 2 or tblData.awardtype == 5 then
        self.mRemainLabel.gameObject:SetActive(not allFinish)
        self.mRemainLabel.text = "[878787]剩余可领[" .. (data.leftCount > 0 and "00ff00" or "e85038") .. "]" .. tostring(data.leftCount) .. "[-][-]"
        local pos = self.mDescription.transform.localPosition
        pos.y = allFinish and 0 or 10
        self.mDescription.transform.localPosition = pos
    else
        self.mRemainLabel.gameObject:SetActive(false)
        local pos = self.mDescription.transform.localPosition
        pos.y = 0
        self.mDescription.transform.localPosition = pos
    end

    local lbColor = allFinish and luaEnumColorType.Gray or ""
    self.mDescription.text = lbColor .. tblData.smallname
    if self.rootPanel then
        local progress = ""

        local goalId = tblData.goalIds.list[0]
        local finish, aim = clientTableManager.cfg_activity_goalsManager:GetActivityProgress(goalId)
        if finish and aim then
            local finishColor = finish >= aim and luaEnumColorType.Green or luaEnumColorType.Red
            local aimColor = luaEnumColorType.White
            if allFinish then
                finishColor = luaEnumColorType.Gray
                aimColor = luaEnumColorType.Gray
            end
            progress = finishColor .. finish .. aimColor .. "/" .. aim
        end

        local res, goalInfo = CS.Cfg_ActivityGoalsTableManager.Instance.dic:TryGetValue(goalId)
        if res then
            if goalInfo.goalType == 1008 then
                local parms = goalInfo.goalParam;
                local prefixId = math.ceil((math.floor((parms - 1) / 10) + 1) * 1000 + ((parms - 1) % 10) + 1)
                local res, prefixInfo = CS.Cfg_PrefixTableManager.Instance.dic:TryGetValue(prefixId)
                if res then
                    ---@type string
                    local names = string.Split(prefixInfo.name, '#')
                    if #names >= 3 then
                        local career = CS.CSScene.MainPlayerInfo.Career
                        local careerNum = Utility.EnumToInt(career)
                        progress = names[careerNum] .. "(" .. progress .. ")"
                    end
                end
            end
        end

        self.mDescription.text = lbColor .. string.format(tblData.smallname, progress)
    end
    self:ShowReward(tblData)
end

---刷新奖励显示
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type4Template:ShowReward(tableData)
    if tableData.award then
        self.rewardList_UIGridContainer.MaxCount = tableData.award.list.Count
        local effect
        if self.data and self.rootPanel then
            effect = self.rootPanel:GetActivityEffect(self.data.activityId)
        end

        for i = 0, self.rewardList_UIGridContainer.controlList.Count - 1 do
            if tableData.award.list[i].list.Count >= 2 then

                local effectId = 0
                if effect and effect[i + 2] then
                    effectId = tonumber(effect[i + 2])
                end

                local itemId = tableData.award.list[i].list[0]
                ---@type UnityEngine.GameObject
                local go = self.rewardList_UIGridContainer.controlList[i]
                ---@type bagV2.CoinInfo
                local boxInfo = CS.Cfg_BoxTableManager.Instance:GetBoxInfo(itemId)
                if boxInfo then
                    ---替换宝箱
                    local res, boxItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(boxInfo.itemId)
                    if res then
                        self:ShowItemInfo(boxItemInfo, boxInfo.count, go, effectId)
                    end
                else
                    ---普通道具
                    local res, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
                    if res then
                        local num = tableData.award.list[i].list[1]
                        self:ShowItemInfo(itemInfo, num, go, effectId)
                    end
                end
            end
        end
    end
end

---刷新单个格子显示
---@param info TABLE.CFG_ITEMS 道具信息
---@param num number 数目
---@param go UnityEngine.GameObject 格子
function UICompetitionPanel_Type4Template:ShowItemInfo(info, num, go, effectId)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = info.icon
        icon.color = self:IsAllChildRewarded() and LuaEnumUnityColorType.HalfTransparent or LuaEnumUnityColorType.Normal
    end

    ---@type UILabel
    local count = CS.Utility_Lua.Get(go.transform, "count", "UILabel")
    if not CS.StaticUtility.IsNull(count) then
        local showNum = ternary(num == 1, "", num)
        count.text = showNum
    end

    ---@type CSUIEffectLoad
    local effectLoad = CS.Utility_Lua.Get(go.transform, "icon/effect", "CSUIEffectLoad")

    effectLoad.gameObject:SetActive(false)
    if effectId ~= 0 then
        effectLoad.effectId = effectId
        effectLoad.gameObject:SetActive(true)
    end

    ---@type UnityEngine.GameObject
    local show = CS.Utility_Lua.Get(go.transform, "Sprite", "GameObject")
    show:SetActive(false)

    CS.UIEventListener.Get(go).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
    end
end

---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type4Template:RefreshChildShow(data, tblData)
    local clientGroup = tblData.clientGroup
    local res, groupData = CS.Cfg_Activity_CommonTableManager.Instance.ActivityGroup:TryGetValue(clientGroup)
    if res then
        for i = 0, groupData.Count - 1 do
            local tblData = self.rootPanel:TemporaryCacheTableData(groupData[i])
            if tblData.smallid ~= 1 then
                local data = self.rootPanel.PrefixIdToData[tblData.id]
                if data then
                    table.insert(self.childData, data)
                end
            end
        end
    end
    if self.childData then
        self.mSmallAim_UIGridContainer.MaxCount = #self.childData
        for i = 0, self.mSmallAim_UIGridContainer.controlList.Count - 1 do
            local go = self.mSmallAim_UIGridContainer.controlList[i]
            local template = self:GetSmallAimTemplate(go)
            local info = self.childData[i + 1]
            local tblData = self.rootPanel:TemporaryCacheTableData(info.activityId)
            local isFinalLine = i == self.mSmallAim_UIGridContainer.controlList.Count - 1
            if (template:Refresh(info, tblData, i, isFinalLine)) then
                self.isFinishChild = true
            end
            if not template.hasGet then
                self.isAllChildRewarded = false
            end
        end
        self.mSmallChildHeight = self.mSmallAim_UIGridContainer.CellHeight * #self.childData
        self.mChildBg_UISprite.height = self.mSmallChildHeight
    end
end

---设置子节点显示
function UICompetitionPanel_Type4Template:SetChildShow()
    if self.childData and #self.childData > 0 then
        self.mChild_Go:SetActive(self.mNeedShowChild)
        return
    end
    self.mChild_Go:SetActive(false)
end

---@return UICompetitionPanel_Type4SmallAimTemplate
---获取小目标模板
function UICompetitionPanel_Type4Template:GetSmallAimTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICompetitionPanel_Type4SmallAimTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end

---刷新按钮显示
---@param data activityV2.ActivityDataInfo 活动数据
---@param tblData TABLE.CFG_ACTIVITY_COMMON 活动表数据
function UICompetitionPanel_Type4Template:RefreshBtnShow(data, tblData)
    self.isFinish = self.rootPanel:GetActivityFinishState(data) == 1
    self.hasGet = self.rootPanel:GetActivityFinishState(data) == 2
    ---当前状态,1未达成,2已领取,3可领取,4已领完,5首个未完成前往
    local currentState = 1
    if self.hasGet then
        ---已领取
        currentState = 2
    else
        if self.isFinish then
            ---未领取但已完成
            currentState = 3
        else
            ---未领取且未完成
            currentState = 1
        end
        if tblData.awardtype == 2 or tblData.awardtype == 5 then
            ---有总领取限制的,考虑下已领完的情况
            if data.leftCount <= 0 then
                currentState = 4
            end
        end
    end
    if (self.rootPanel.mFirstUnfinsh == false and currentState == 1 and tblData.param ~= nil and tblData.param ~= '') then
        self.rootPanel.mFirstUnfinsh = true
        currentState = 5
    end
    ---未达成
    ---首个
    self.mGetBtn_GoTo:SetActive(currentState == 5)
    self.UnFinish_GO:SetActive(currentState == 1)
    --self.UnFinish_GO:SetActive(not self.hasGet and not self.isFinish)
    ---已完成
    self.finish_GameObject:SetActive(currentState == 2)
    --self.finish_GameObject:SetActive(self:IsAllChildRewarded())
    ---可领取
    self.mGetBtn_Go:SetActive(currentState == 3)
    --self.mGetBtn_Go:SetActive(not self.hasGet and self.isFinish)
    ---已领完
    self.nullToGet:SetActive(currentState == 4)
    ---@type number
    self.mCurrentState = currentState
end

---领奖
function UICompetitionPanel_Type4Template:OnRewardBtnClicked()
    if self.data and self.tblData then
        local goalId = self.tblData.goalIds.list[0]
        networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, goalId, 1)
        networkRequest.ReqOpenPanel(self.tblData.clientType)
    end
end
---前往
function UICompetitionPanel_Type4Template:OnRewardBtnGoToClicked()
    if self.tblData and self.tblData.param ~= nil then
        local tab = string.Split(self.tblData.param, '#')
        if (#tab > 1) then
            local type = tonumber(tab[1])
            local param = tonumber(tab[2])
            if (type == 1) then
                uiTransferManager:TransferToPanel(param)
            end
        end
    end
end
---刷新红点显示
function UICompetitionPanel_Type4Template:RefreshRedPoint(isShow)
    self.mRedPointGo:SetActive(self:IsShowRedPoint() and isShow)
end

---@return boolean 是否显示红点
function UICompetitionPanel_Type4Template:IsShowRedPoint()
    return false
    --return (self.isFinish and not self.hasGet) or self.isFinishChild
end

---@return boolean 是否所有子节点已经领取
function UICompetitionPanel_Type4Template:IsAllChildRewarded()
    local notLeft = self.mCurrentState == 4--领完
    return (self.isAllChildRewarded and self.hasGet) or notLeft
end

---@return boolean 是否大目标完成
function UICompetitionPanel_Type4Template:IsBigAimFinish()
    return self.isFinish or self.hasGet
end
---获取自己节点显示高度
function UICompetitionPanel_Type4Template:GetSelfHeight()
    return self.mNeedShowChild and self.mBg_UISprite.height + self.mSmallChildHeight or self.mBg_UISprite.height
end

---设置背景颜色
function UICompetitionPanel_Type4Template:SetBGColor(isShow)
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self.mBg_UISprite.color = color
end

---设置选中
function UICompetitionPanel_Type4Template:ChooseItem(isChoose)
    if self.mCanShowSmallChild then
        self.mNeedShowChild = not self.mNeedShowChild
        if isChoose ~= nil then
            if self.mNeedShowChild ~= isChoose then
            end
            self.mNeedShowChild = isChoose
        end
        self:SetChildShow()
        if self.rootPanel then
            self.rootPanel:SuitScrollView(self.line, true)
        end
    end
end

---刷新显示子节点状态
function UICompetitionPanel_Type4Template:RefreshNeedShowChild(state)
    if self.mNeedShowChild then
        self.mNeedShowChild = state
        self:SetChildShow()
    end
end

function UICompetitionPanel_Type4Template:RefreshColorEct()

    local color = self:IsAllChildRewarded() and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
    self.mIcon1_Sprite.color = color
    self.mIcon2_Sprite.color = color
    self.mIcon3_Sprite.color = color
end

return UICompetitionPanel_Type4Template