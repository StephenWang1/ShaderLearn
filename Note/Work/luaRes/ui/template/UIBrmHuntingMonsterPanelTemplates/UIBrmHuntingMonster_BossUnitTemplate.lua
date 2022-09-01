---@class UIBrmHuntingMonster_BossUnitTemplate
local UIBrmHuntingMonster_BossUnitTemplate = {}

---获得白日门猎魔数据管理
---@return BaiRiMenActController_Hunt
function UIBrmHuntingMonster_BossUnitTemplate:GetActController_Hunt()
    return gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_Hunt()
end

function UIBrmHuntingMonster_BossUnitTemplate:IsMeetLevel()
    return CS.CSScene.MainPlayerInfo.Level >= 70
end

--region 初始化

---初始化
function UIBrmHuntingMonster_BossUnitTemplate:Init()
    self:InitComponents()
    self:BindUIEvent()
end

function UIBrmHuntingMonster_BossUnitTemplate:InitComponents()
    ---@type UILabel boss名称
    self.name = self:Get("name", "UILabel")
    ---@type UnityEngine.GameObject 点击操作按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---@type UILabel 点击操作按钮名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---@type UILabel 点击操作按钮数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---@type UISprite 点击操作按钮背景
    self.backGround = self:Get("btn_go/backGround", "UISprite")
    ---@type Top_UIGridContainer 道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "Top_UIGridContainer")
    ---@type UIScrollView UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---@type UnityEngine.GameObject 模型根节点
    self.ModelRoot = self:Get("modelScroll/Model", "GameObject")
end

function UIBrmHuntingMonster_BossUnitTemplate:BindUIEvent()
    CS.UIEventListener.Get(self.btn_go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go.gameObject).OnClickLuaDelegate = self.OnClickbtn_go
end

--endregion

--region 函数监听

---点击地图按钮回调
---@param go UnityEngine.GameObject
function UIBrmHuntingMonster_BossUnitTemplate:OnClickbtn_go(go)

    if not self:IsMeetLevel() then
        Utility.ShowPopoTips(go.transform, '等级不足', 261, 'UIBrmHuntingMonsterPanel')
        return
    end
    if self.data.remindNum == 0 and not self:GetActController_Hunt():IsActivityOpenedNow() then
        Utility.ShowPopoTips(go.transform, "活动未启动", tonumber(261))
        return
    end
    Utility.TryTransfer(tonumber(121012), false)
    --networkRequest.ReqDeliverByConfig(tonumber(121012))
    uimanager:ClosePanel("UIWhiteSunGatePanel")


    --[[    if self.brmActTbl == nil or self.eventParameDic == nil then
            return
        end
            local type, param = 0, 0

            if not self.isMeetCondition then
                if self.eventParameDic[2] ~= nil then
                    type = self.eventParameDic[2].OperationType
                    param = self.eventParameDic[2].OperationParame
                end
            elseif self.eventParameDic[1] ~= nil then
                type = self.eventParameDic[1].OperationType
                param = self.eventParameDic[1].OperationParame
            end

            if type == 2 then
                Utility.ShowPopoTips(go.transform, nil, tonumber(param), 'UIBrmHuntingMonsterPanel')
            elseif type == 4 then
                networkRequest.ReqDeliverByConfig(tonumber(param))
                uimanager:ClosePanel("UIWhiteSunGatePanel")
            end]]

end

--endregion

--region 视图

---@param data  activitiesV2.SunActivitiesGoalInfo
---@param customData table
---@field customData.ClipShader Top_OptimizeClipShaderScript 特效裁剪
function UIBrmHuntingMonster_BossUnitTemplate:SetTemplate(data, customData)
    if self:GetActController_Hunt() == nil or data == nil then
        return
    end
    self.OptimizeClipShaderScript = customData.ClipShader
    self:RefreshData(data)
    self:RefreshAllView()
end

function UIBrmHuntingMonster_BossUnitTemplate:RefreshAllView()
    self:RefreshTopView()
    self:RefreshModelView()
    self:RefreshDropView()
    self:RefrshDownView()
end

---刷新顶部视图
function UIBrmHuntingMonster_BossUnitTemplate:RefreshTopView()
    if self.monsterTbl == nil then
        return
    end
    --local level = self.monsterTbl:GetLevel() .. '级 '
    local nameColor = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(self.monsterTbl:GetType()))
    self.name.text = nameColor .. self.monsterTbl:GetName()
end

---刷新模型视图
function UIBrmHuntingMonster_BossUnitTemplate:RefreshModelView()
    if self.brmActTbl == nil or self.monsterTbl == nil then
        return
    end
    if self.ModelRoot == nil or CS.StaticUtility.IsNull(self.ModelRoot) then
        return
    end
    if self.ObservationModel == nil then
        self.ObservationModel = CS.ObservationModel()
    end
    self.ObservationModel:ClearModel()
    self.ObservationModel.DefalutShaderType = 1
    self.ObservationModel:SetShowMotion(CS.CSMotion.Stand)
    self.ObservationModel:SetBindRenderQueue()
    self.ObservationModel:SetDragRoot(self.ModelRoot)
    local Scale = self.monsterTbl:GetScale() * self.brmActTbl:GetModelScale() / 10000
    ---设置旋转
    self.ObservationModel:SetRotation(CS.UnityEngine.Vector3(27, 132, -27))
    self.ObservationModel:ResetCurScale()
    ---设置缩放
    self.ObservationModel:SetScaleSizeforRatio(Scale)
    ---设置位置
    self.ObservationModel:SetPosition(CS.UnityEngine.Vector3(self.brmActTbl:GetOffsetX(), self.brmActTbl:GetOffsetY(), 1500))
    ---创建模型
    self.ObservationModel:CreateModel(self.monsterTbl:GetModel(), CS.EAvatarType.Monster, self.ModelRoot.transform,
            function()
                if self.OptimizeClipShaderScript ~= nil and self.ObservationModel ~= nil then
                    self.OptimizeClipShaderScript:AddRenderList(self.ObservationModel.ModelRoot, true, false, true);
                end
            end)
end

---刷新掉落视图
function UIBrmHuntingMonster_BossUnitTemplate:RefreshDropView()
    if self.monsterTbl == nil then
        return
    end
    local dropList = clientTableManager.cfg_monstersManager:GetDropShowList(self.monsterTbl:GetId())
    if dropList == nil then
        return
    end
    self.dropItemGrid.MaxCount = #dropList
    for i = 1, #dropList do
        if dropList[i]:GetItemId() ~= nil then
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(dropList[i]:GetItemId())
            local go = self.dropItemGrid.controlList[i - 1]
            if infobool then
                ---@type UIItem
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, 1)
                temp:RefreshOtherUI({ showItemInfo = temp.ItemInfo })
                --tag = dropList[i]:GetTag(),
            end
        end
    end
    self.UIScrollView:ResetPosition()
end

---刷新下方视图
--function UIBrmHuntingMonster_BossUnitTemplate:RefrshDownView()
--
--    local number = self.data ~= nil and self.data.remindNum or 0;
--
--    local isCanKill = number > 0
--    --self:GetActController_Hunt():IsActive()
--
--    local countColor = isCanKill and luaEnumColorType.Green or luaEnumColorType.Gray
--    local nameColor = isCanKill and "[FFFFFF]" or '[727272]'
--    local levelColor = not self:IsMeetLevel() and luaEnumColorType.Red or ''
--    if self.mapTbl then
--        self.lab_name.text = nameColor .. self.mapTbl:GetName() .. levelColor .. " 70级"
--    end
--
--    self.lab_num.text = countColor .. number .. "只"
--
--    self.backGround.spriteName = isCanKill and "bo1" or 'bo2'
--end

function UIBrmHuntingMonster_BossUnitTemplate:RefrshDownView()
    local table_mapName=self.mapTbl:GetName()
    if self.realMapTbl~=nil then
        table_mapName=self.realMapTbl:GetName()
    end
    local number = 0;
    local color = "[00ff00]"
    local desColor = "[FFFFFF]"
    local bgtexture = "bo1"
    local levelColor = "[6B99A2]"
    if self.data ~= nil then
        number = self.data.remindNum
    end
    -- local isopenactive = self.HuntingRewaController:IsActiveOpen()
    if self:IsMeetLevel() == false then
        levelColor = "[e85038]"
    end
    if number == 0 then
        color = "[878787]"
        desColor = "[727272]"
        bgtexture = "bo2"
        levelColor = "[727272]"
    end
    self.lab_num.text = color .. number .. "只"
    self.lab_name.text = desColor .. table_mapName .. levelColor .. "70级"
    self.backGround.spriteName = bgtexture
end

--endregion

--region otherFunc

---刷新表数据
---@data activitiesV2.SunActivitiesGoalInfo
function UIBrmHuntingMonster_BossUnitTemplate:RefreshData(data)
    ---@type activitiesV2.SunActivitiesGoalInfo
    self.data = data
    ---@type TABLE.cfg_bairimen_activity
    self.brmActTbl = clientTableManager.cfg_bairimen_activityManager:GetMonsterIDbyTable(data.targetId, 3)
    if self.brmActTbl ~= nil then

    end
    self.monsterTbl = clientTableManager.cfg_monstersManager:TryGetValue(data.targetId)
    self.mapTbl = clientTableManager.cfg_mapManager:TryGetValue(data.mapId)
    if self.mapTbl~=nil then
        self.realMapTbl = clientTableManager.cfg_mapManager:TryGetValue(self.mapTbl:GetRealMapId())
    end


    self.isMeetCondition = self.brmActTbl == nil and false or
            clientTableManager.cfg_bairimen_activityManager:IsMeetConditionByTbl(self.brmActTbl)
    self.eventParameDic = self:AnalysisEventParameters(self.brmActTbl)
end

---解析条件类型参数
---@param  brmTable TABLE.cfg_bairimen_activity
---@return table<number,BrmHuntingOperationParame>
function UIBrmHuntingMonster_BossUnitTemplate:AnalysisEventParameters(brmTable)
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
    ---@class BrmHuntingOperationParame
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

--endregion

return UIBrmHuntingMonster_BossUnitTemplate