---@class UIBrmHuntingRewardTemplate
local UIBrmHuntingRewardTemplate = {}

function UIBrmHuntingRewardTemplate:InitComponents()
    ---boss名称
    self.name = self:Get("name", "UILabel")
    ---点击操作按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---点击操作按钮名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---点击操作按钮数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---点击操作按钮背景
    self.backGround = self:Get("btn_go/backGround", "UISprite")
    ---道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "Top_UIGridContainer")
    ---UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---模型根节点
    self.ModelRoot = self:Get("modelScroll/Model", "GameObject")
end

function UIBrmHuntingRewardTemplate:InitOther()
    ---@type BaiRiMenActController_HuntingRewar
    self.HuntingRewaController = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_HuntingRewar()

    CS.UIEventListener.Get(self.btn_go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go.gameObject).OnClickLuaDelegate = self.OnClickbtn_go
end

---初始化数据
function UIBrmHuntingRewardTemplate:Init()
    self:InitComponents()
    self:InitOther()
end

---刷新UI
---@param data activitiesV2.SunActivitiesGoalInfo
---@param ClipShader Top_OptimizeClipShaderScript
function UIBrmHuntingRewardTemplate:RefreshUI(data, ClipShader)
    self.OptimizeClipShaderScript = ClipShader
    if self.HuntingRewaController == nil then
        return
    end
    if data == nil then
        return
    end
    self:InitData(data)
    self:ShowModel(self.brmActivityTable, self.monsterTable, self.ModelRoot)
    self:ShowModelInfo(self.monsterTable)
    self:SetItemGrid()
    --  self:RefreshBtnDes()
    self:RefreshBtnInfo()
end

---数据刷新
---@param data activitiesV2.SunActivitiesGoalInfo
function UIBrmHuntingRewardTemplate:InitData(data)
    if data == nil then
        return
    end
    self.data = data
    ---@type TABLE.cfg_bairimen_activity
    self.brmActivityTable = self.HuntingRewaController:GetMonsterIDbyTable(data.targetId) --self.HuntingRewaController:GetActivityTable()
    if self.brmActivityTable == nil then
        return
    end
    self.monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(self.brmActivityTable:GetMonsterId())
end

--region 模型信息刷新
---模型名词显示刷新
function UIBrmHuntingRewardTemplate:ShowModelInfo(monsterTable)
    if monsterTable == nil then
        return
    end
    local nameColor = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTable:GetType()))
    self.name.text = nameColor .. monsterTable:GetName()
end

---显示模型
---@param brmTable TABLE.cfg_bairimen_activity
---@param monsterTable TABLE.cfg_monsters
function UIBrmHuntingRewardTemplate:ShowModel(brmTable, monsterTable, RootGO)
    if brmTable == nil or monsterTable == nil then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    self.ObservationModel:ClearModel()
    self.ObservationModel.DefalutShaderType = 1
    self.ObservationModel:SetShowMotion(CS.CSMotion.Stand)
    self.ObservationModel:SetBindRenderQueue()
    self.ObservationModel:SetDragRoot(RootGO)
    local Scale = monsterTable:GetScale() * brmTable:GetModelScale() / 10000
    ---设置旋转
    self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(27, 132, -27))
    self.ObservationModel:ResetCurScale()
    ---设置缩放
    self.ObservationModel:SetScaleSizeforRatio(Scale)
    ---设置位置
    self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(brmTable:GetOffsetX(), brmTable:GetOffsetY(), 1500))
    ---创建模型
    self.ObservationModel:CreateModel(monsterTable:GetModel(), CS.EAvatarType.Monster, RootGO.transform, function()
        if self.OptimizeClipShaderScript ~= nil and self.ObservationModel ~= nil then
            self.OptimizeClipShaderScript:AddRenderList(self.ObservationModel.ModelRoot, true, false, true);
        end
    end)

end

--endregion

--region掉落展示

---设置掉落道具展示
function UIBrmHuntingRewardTemplate:SetItemGrid()
    if self.monsterTable == nil then
        return
    end
    local monsterID = self.monsterTable:GetId()
    local dropList = clientTableManager.cfg_monstersManager:GetDropShowList(monsterID)
    if dropList == nil then
        return
    end
    self.dropItemGrid.MaxCount = #dropList
    for i = 1, #dropList do
        if dropList[i]:GetItemId() ~= nil then
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(dropList[i]:GetItemId())
            local go = self.dropItemGrid.controlList[i - 1]
            if infobool then
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, 1)
                temp:RefreshOtherUI({ tag = dropList[i]:GetTag() })
                CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                    if temp.ItemInfo ~= nil then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                    end
                end
            end
        end
    end
    self.UIScrollView:ResetPosition()
end

--endregion

--region 操作按钮

-----刷新按钮描述
--function UIBrmHuntingRewardTemplate:RefreshBtnDes()
--    self.lab_name.text = "白日门 70级"
--    local number = 0;
--    if self.data ~= nil then
--        number = self.data.remindId
--    end
--    self.lab_num.text = "[00ff00]" .. number .. "只"
--end

---刷新按钮信息（目前策划没要求需求保留）
function UIBrmHuntingRewardTemplate:RefreshBtnInfo()
    local number = 0;
    local color = "[00ff00]"
    local desColor = "[FFFFFF]"
    local bgtexture = "bo1"
    local levelColor = "[6B99A2]"
    if self.data ~= nil then
        number = self.data.remindNum
    end
    -- local isopenactive = self.HuntingRewaController:IsActiveOpen()
    if self.HuntingRewaController:IsMeetLimitLevel() == false then
        levelColor = "[e85038]"
    end
    if number == 0 then
        color = "[878787]"
        desColor = "[727272]"
        bgtexture = "bo2"
        levelColor = "[727272]"
    end
    self.lab_num.text = color .. number .. "只"
    self.lab_name.text = desColor .. "白日门 " .. levelColor .. "70级"
    self.backGround.spriteName = bgtexture
end
---点击操作
function UIBrmHuntingRewardTemplate:OnClickbtn_go(go)
    self:ClickOperation(self.brmActivityTable, go)
end

--endregion

--region 点击操作

---点击操作
---@param brmTable TABLE.cfg_bairimen_activity
function UIBrmHuntingRewardTemplate:ClickOperation(brmTable, go)
    if self.HuntingRewaController:IsMeetLimitLevel() == false then
        Utility.ShowPopoTips(go.transform, "等级不足", tonumber(261))
        return
    end

    ---活动是否开启
    if self.data.remindNum == 0 and self.HuntingRewaController:IsActiveOpen() == false  then
        Utility.ShowPopoTips(go.transform, "活动未开启", tonumber(261))
        return
    end
    Utility.TryTransfer(tonumber(121012), false)
    --networkRequest.ReqDeliverByConfig(tonumber(121012))
    uimanager:ClosePanel("UIWhiteSunGatePanel")

    --if brmTable == nil then
    --    return
    --end
    --local isMeetCondition = self:IsMeetCondition(brmTable)
    --local EventParameDic = self:AnalysisEventParameters(brmTable)
    --if EventParameDic == nil then
    --    return
    --end
    --local number = 1
    --if isMeetCondition == false then
    --    number = 2
    --end
    --self:ConditionOperation(EventParameDic[number], go, brmTable)
end

---解析条件类型参数
---@param  brmTable TABLE.cfg_bairimen_activity
---@return table<number,BrmHuntingRewardOperationParame>
function UIBrmHuntingRewardTemplate:AnalysisEventParameters(brmTable)
    if brmTable == nil then
        return nil
    end
    local eventParameters = brmTable:GetEventParameters()
    if eventParameters == nil or eventParameters == "" then
        return nil
    end
    local temp1 = _fSplit(eventParameters, "&")
    local EventParameDic = {}
    local temp2 = _fSplit(tostring(temp1[1]), "#")
    ---@class BrmHuntingRewardOperationParame
    local Meet = {
        OperationType = tonumber(temp2[1]),
        OperationParame = tostring(temp2[2]),
    }
    EventParameDic[1] = Meet
    if #temp1 == 1 then
        return EventParameDic
    end

    local temp3 = _fSplit(tostring(temp1[2]), "#")
    local NotMeet = {
        OperationType = tonumber(temp3[1]),
        OperationParame = tostring(temp3[2]),
    }
    EventParameDic[2] = NotMeet
    return EventParameDic
end

---条件操作
---@param OperationParame table<number,BrmHuntingRewardOperationParame>
function UIBrmHuntingRewardTemplate:ConditionOperation(OperationParame, go, brmTable)
    if OperationParame == nil then
        return
    end
    if OperationParame.OperationType == 2 then
        self:Bubble(OperationParame.OperationParame, go)
    elseif OperationParame.OperationType == 4 then
        self:Deliver(OperationParame.OperationParame)
    end
end

---弹出气泡
function UIBrmHuntingRewardTemplate:Bubble(OperationParame, go)
    Utility.ShowPopoTips(go.transform, nil, tonumber(OperationParame))
end
---Deliver传送
function UIBrmHuntingRewardTemplate:Deliver(OperationParame)
    if OperationParame == nil then
        return
    end
    networkRequest.ReqDeliverByConfig(tonumber(OperationParame))
    uimanager:ClosePanel("UIWhiteSunGatePanel")
end

-----是否满足条件
---@param brmTable TABLE.cfg_bairimen_activity
function UIBrmHuntingRewardTemplate:IsMeetCondition(brmTable)
    if brmTable == nil then
        return false
    end
    local isMeet = true

    if brmTable:GetActivityCondition() ~= nil then
        for i = 1, #brmTable:GetActivityCondition().list do
            local conditionID = brmTable:GetActivityCondition().list[i]
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
                isMeet = false
                break
            end
        end
    end
    return isMeet
end

--endregion

return UIBrmHuntingRewardTemplate