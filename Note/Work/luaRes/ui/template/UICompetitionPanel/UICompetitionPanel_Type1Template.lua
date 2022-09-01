---@class UICompetitionPanel_Type1Template:TemplateBase 类型1模板
local UICompetitionPanel_Type1Template = {}

---@param rootPanel UICompetitionPanel
function UICompetitionPanel_Type1Template:Init(rootPanel)
    self.mRootPanel = rootPanel
    self:InitComponent()
    self:BindEvent()
end

function UICompetitionPanel_Type1Template:InitComponent()
    ---@type UILabel
    ---标题文字
    --  self.title_UILabel = self:Get("Root1/title", "UILabel")

    ---@type UILabel
    ---进度文字
    self.sliderDes_UILabel = self:Get("Root1/description", "UILabel")

    ---@type UIGridContainer
    ---奖励列表
    self.rewardList_UIGridContainer = self:Get("Root1/rewardList", "UIGridContainer")

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.getBtn_GameObject = self:Get("Root1/btn_get", "GameObject")

    ---@type UILabel
    ---领奖按钮文字
    self.getBtn_UILabel = self:Get("Root1/btn_get/Label", "UILabel")

    ---@type UISprite
    ---领奖按钮背景
    self.getBtn_UISprite = self:Get("Root1/btn_get", "UISprite")

    ---@type UnityEngine.GameObject
    ---领完文字
    self.finish_GameObject = self:Get("Root1/finish", "GameObject")

    ---@type UILabel
    ---剩余数目
    self.remain_UILabel = self:Get("Root1/remain", "UILabel")

    ---@type UISprite
    ---背景图片
    self.Bg_UISprite = self:Get("backGround", "UISprite")

    ---已领完Go
    ---@type UnityEngine.GameObject
    self.HasFinish = self:Get("Root1/remainNull", "GameObject")

    ---节点1
    ---@type UnityEngine.GameObject
    self.mRoot1_Go = self:Get("Root1", "GameObject")

    ---节点2
    ---@type UnityEngine.GameObject
    self.mRoot2_Go = self:Get("Root2", "GameObject")

    ---@type UILabel
    ---完成描述文本
    self.mRoot2Description_UILabel = self:Get("Root2/description", "UILabel")

    ---icon1 图片
    ---@type UISprite
    self.mIcon1_Sprite = self:Get("icon1", "UISprite")

    ---icon2 背景
    ---@type UISprite
    self.mIcon2_Sprite = self:Get("icon2", "UISprite")

    ---icon3 标签
    ---@type UISprite
    self.mIcon3_Sprite = self:Get("icon3", "UISprite")

    ---领取特效
    ---@type UnityEngine.GameObject
    self.mEffect_Go = self:Get("Root1/btn_get/effect", "GameObject")

    ---未完成GO
    ---@type UnityEngine.GameObject
    self.UnFinish_GO = self:Get("Root1/unFinish", "GameObject")
end

function UICompetitionPanel_Type1Template:BindEvent()
    CS.UIEventListener.Get(self.getBtn_GameObject).onClick = function(go)
        self:OnGetBtnClicked(go)
    end
end

---@param data activityV2.ActivityDataInfo
---@param tableData TABLE.CFG_ACTIVITY_COMMON
---@param registerNum number 注册人数
function UICompetitionPanel_Type1Template:Refresh(data, tableData, registerNum)
    self.data = data
    self.tblData = tableData

    ---@type boolean
    ---当前任务是否完成
    self.isFinish = false
    ---@type boolean 已领完为true
    self.hasRemain = false

    if tableData and data then
        local leaveNum = data.leftCount
        self.hasRemain = leaveNum <= 0
        local color = self.hasRemain and "[e85038]" or "[00ff00]"
        if CS.StaticUtility.IsNull(self.remain_UILabel) == false then
            self.remain_UILabel.text = luaEnumColorType.Gray .. "剩余奖励" .. color .. leaveNum
        end

        self:RefreshBtnState(data)
        self:ShowReward(tableData)
        self:RefreshMainIcon(tableData)
    end
end

---点击领奖按钮
function UICompetitionPanel_Type1Template:OnGetBtnClicked(go)
    if self.isFinish then
        if self.data and self.tblData then
            if self.tblData.goalIds and self.tblData.goalIds.list and self.tblData.goalIds.list.Count > 0 then
                local listId = self.tblData.goalIds.list
                self.goalId = listId[0]
            end
            networkRequest.ReqGetActivityReward(self.data.activityId, self.tblData.activityType, self.goalId, 1)
            networkRequest.ReqOpenPanel(self.tblData.clientType)
        end
    else
        self:TransferToAimPanel()
        --Utility.ShowPopoTips(go, nil, 192)
    end
end

---刷新奖励显示
---@param tableData TABLE.CFG_ACTIVITY_COMMON
function UICompetitionPanel_Type1Template:ShowReward(tableData)
    if tableData.award then
        self.rewardList_UIGridContainer.MaxCount = tableData.award.list.Count
        local effect
        if self.data and self.mRootPanel then
            effect = self.mRootPanel:GetActivityEffect(self.data.activityId)
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
function UICompetitionPanel_Type1Template:ShowItemInfo(info, num, go, effectId)
    ---@type UISprite
    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    if not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = info.icon
        icon.color = (self.hasGet or self.hasRemain) and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
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
    if effectId ~= 0 and not self.hasRemain and not self.hasGet then
        effectLoad.effectId = effectId
        effectLoad.gameObject:SetActive(true)
    end

    CS.UIEventListener.Get(go).onClick = function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
    end
end

--[[
---刷新剩余可领奖励数目
---@param data activityV2.ActivityDataInfo
---@param tableData TABLE.CFG_ACTIVITY_COMMON
---@param registerNum number 注册人数
function UICompetitionPanel_Type1Template:ShowCanGetNum(data, tableData, registerNum)
    if tableData.num then
        local num = tableData.num
        local rate = tableData.numControl

        if tableData.awardtype == 5 and rate then
            if rate.list.Count > 0 then
                if registerNum == nil then
                    registerNum = 0
                end
                local maxNum = math.max((rate.list[0]) * 0.01 * registerNum, num)
                if isOpenLog then
                    luaDebug.Log("当前注册人数:" .. tostring(registerNum) .. "计算后数目:" .. tostring((rate.list[0]) * 0.01 * registerNum) .. "取最大值:" .. tostring(maxNum))
                end
                num = math.floor(maxNum) - data.leftCount
            end
        else
            num = num - data.leftCount
        end
    end
end
--]]

---@param data activityV2.ActivityDataInfo
---刷新按钮和完成状态
function UICompetitionPanel_Type1Template:RefreshBtnState(data)
    if self.mRootPanel == nil then
        return
    end
    --是否领取
    self.hasGet = self.mRootPanel:GetActivityFinishState(data) == 2
    --是否完成
    self.isFinish = self.mRootPanel:GetActivityFinishState(data) == 1

    self.getBtn_UILabel.text = ternary(self.isFinish, "可领取", "提升")
    self.getBtn_UISprite.spriteName = ternary(self.isFinish, "anniu11", "anniu1")

    self.getBtn_GameObject:SetActive(not self.hasGet and not self.hasRemain and self.isFinish)
    self.mEffect_Go:SetActive(not self.hasGet and not self.hasRemain and self.isFinish)

    self.finish_GameObject:SetActive(self.hasGet)
    self.remain_UILabel.gameObject:SetActive(not self.hasGet and not self.hasRemain)
    self.HasFinish:SetActive(not self.hasGet and self.hasRemain)

    local posY = (self.hasGet or self.hasRemain) and -15 or -1
    local pos = self.sliderDes_UILabel.gameObject .transform.localPosition
    self.sliderDes_UILabel.gameObject .transform.localPosition = CS.UnityEngine.Vector3(pos.x, posY, pos.z)

    self.UnFinish_GO:SetActive(not self.isFinish and not self.hasGet and not self.hasRemain)
end

---刷新目标icon
function UICompetitionPanel_Type1Template:RefreshMainIcon(tableData)
    self.mIcon1_Sprite.spriteName = tableData.icon
    self.mIcon2_Sprite.spriteName = tableData.icon2
    self.mIcon3_Sprite.spriteName = tableData.icon3
    self.mRoot2Description_UILabel.text = tableData.completeText
    local isDark = self.hasRemain or self.hasGet
    local color = isDark and LuaEnumUnityColorType.DarkGray or LuaEnumUnityColorType.Normal
    self.mIcon1_Sprite.color = color
    self.mIcon2_Sprite.color = color
    self.mIcon3_Sprite.color = color
    local color1 = isDark and luaEnumColorType.Gray or ""
    self.sliderDes_UILabel.text = color1 .. tableData.smallname
end

---设置背景颜色
function UICompetitionPanel_Type1Template:SetBGColor(isShow)
    local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self.Bg_UISprite.color = color
end

---跳转目标界面并关闭当前界面
function UICompetitionPanel_Type1Template:TransferToAimPanel()
    if self.tblData then
        local aim = self.tblData.param
        if aim then
            local AimsList = string.Split(aim, '#')
            if #AimsList == 2 and tonumber(AimsList[1]) == 1 then
                --直接打开面板
                local transferId = tonumber(AimsList[2])
                uiTransferManager:TransferToPanel(transferId, nil, function()
                    self:CloseCompetitionPanel()
                end)
            elseif #AimsList >= 3 and tonumber(AimsList[1]) == 2 then
                --寻路后打开面板
                local aim = {}
                for i = 2, #AimsList - 1 do
                    local npcId = tonumber(AimsList[i])
                    table.insert(aim, npcId)
                end
                local PanelName = AimsList[#AimsList]
                CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(aim, PanelName, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, aim)
                self:CloseCompetitionPanel()
            end
        end
    end
end

function UICompetitionPanel_Type1Template:CloseCompetitionPanel()
    uimanager:ClosePanel("UICompetitionPanel")
end

return UICompetitionPanel_Type1Template