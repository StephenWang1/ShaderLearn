local IndividEscortList2Template = {}
--region 初始化
function IndividEscortList2Template:Init()
    self:InitComponent()
    self:BindNetEvents()
    self:InitListUpdate()
end

function IndividEscortList2Template:InitComponent()
    self.DartCarList_UIGridContainer = self:Get("EscortList/EscortList/Grid","UIGridContainer")
    self.LastEscort_GameObject = self:Get("LastEscort","GameObject")
    self.RecommendDartCar_GameObject = self:Get("LastEscort/RecommendEscort","GameObject")
    self.LastEscort_RecommendGrid_UIGridContainer = self:Get("LastEscort/EscortList/Grid","UIGridContainer")
    self.HijackValue_UILabel = self:Get("HijackValue","UILabel")
    self.AddDartCarBtn = self:Get("AddEscortBtn","GameObject")
    self.EscortList_GameObject = self:Get("EscortList","GameObject")
    self.EscortList_UIPanel = self:Get("EscortList/EscortList","UIPanel")
    self.EscortList_ScrollView = self:Get("EscortList/EscortList","UIScrollView")
end

function IndividEscortList2Template:BindNetEvents()
    CS.UIEventListener.Get(self.AddDartCarBtn).onClick = function()
        if self.dartCarList ~= nil then
            local recommendDartCarInfo = nil
            if self.dartCarList ~= nil and self.dartCarList.Count > 0 then
                recommendDartCarInfo = self.dartCarList[0]
            end
            self:RefreshToReceiveList()
            uimanager:CreatePanel("UIIndividEscortChoosePanel",nil,{recommendDartCarInfo = recommendDartCarInfo,personDartCarSourceType = self.personDartCarSourceType})
        end
    end
end

function IndividEscortList2Template:InitListUpdate()
    if self.initListUpdate ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.initListUpdate)
        self.initListUpdate = nil
    end
    self.initListUpdate = CS.CSListUpdateMgr.Add(200,nil,function()
        if self.personCarTable ~= nil then
            for k,v in pairs(self.personCarTable) do
                local dartCarTemplate = v
                if dartCarTemplate ~= nil and CS.StaticUtility.IsNull(dartCarTemplate.go) == false and dartCarTemplate.UpdateRefresh then
                    dartCarTemplate:UpdateRefresh()
                end
            end
        end
    end,true)
end
--endregion

--region 刷新
---刷新面板
function IndividEscortList2Template:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self.EscortList_GameObject:SetActive(self.HaveRecommendDartCar == nil or self.HaveRecommendDartCar == false)
    self.LastEscort_GameObject:SetActive(self.HaveRecommendDartCar == true)
    self.AddDartCarBtn:SetActive(self:ShowAddDartCarBtn())
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end
    if self.personDartCarListType == LuaEnumPersonDartCarListType.RecommendDartCarList then
        ---针对推荐押镖没有的情况下，且有可领取列表，则使用正常的刷新
        if self.dartCarList.Count > 0 and self.dartCarList[0].PersonalCartInfo ~= nil then
            self:RefreshList()
        else
            self:RefreshRecommendList()
        end
    else
        self:RefreshList()
    end
    self:RefreshListState()
    self:RefreshHelpBtn()
    self:RefreshRemainPlunderCarNum()
end

---解析数据
---@return 解析数据是否成功
function IndividEscortList2Template:AnalysisParams(commonData)
    self.dartCarList = commonData.dartCarList
    if self.dartCarList == nil then
        return false
    end
    self.personDartCarListType = commonData.personDartCarListType
    self.HaveRecommendDartCar = false
    if self.personDartCarListType == LuaEnumPersonDartCarListType.NONE then
        return false
    elseif self.personDartCarListType == LuaEnumPersonDartCarListType.RecommendDartCarList then
        if self.dartCarList.Count > 0 and self.dartCarList[0].PersonalCartInfo == nil then
            self.HaveRecommendDartCar = true
        end
    end
    self.personDartCarSourceType = commonData.personDartCarSourceType
    self.dartCarListCount = self.dartCarList.Count
    self.rectParams = self:GetPersonDartCarPanelClipRangeParams(ternary(self:ShowAddDartCarBtn() == true,1,2))
    self.parentCalss = commonData.parentCalss
    return true
end

---刷新推荐列表
function IndividEscortList2Template:RefreshRecommendList()
    --刷新推荐镖车
    self.personCarTable = {}
    local grid_Template = templatemanager.GetNewTemplate(self.RecommendDartCar_GameObject,luaComponentTemplates.IndividEscortGrid_WaitDrive2)
    local dartCarInfo = nil
    if self.dartCarList ~= nil and self.dartCarList.Count > 0 then
        dartCarInfo = self.dartCarList[0]
    end
    grid_Template:RefreshPanel({dartCarInfo = dartCarInfo,index = 0})
    table.insert(self.personCarTable,grid_Template)
    --刷新领取镖车
    if self.dartCarList ~= nil and self.dartCarList.Count > 1 then
        self.LastEscort_RecommendGrid_UIGridContainer.MaxCount = self.dartCarListCount - 1
        self.index = 0
        self.dartCarListCount = self.dartCarListCount - 1
        self.delayRefresh = CS.CSListUpdateMgr.Add(100,nil,function()
            if self.dartCarListCount ~= nil and self.index < self.dartCarListCount then
                local grid_GameObject = self.LastEscort_RecommendGrid_UIGridContainer.controlList[self.index]
                local dartCarInfo = self.dartCarList[self.index + 1]
                local grid_Template = templatemanager.GetNewTemplate(grid_GameObject, self:GetPersonDartCarTemplateByCarState(self:GetPersonDartCarState(dartCarInfo)))
                grid_Template:RefreshPanel({dartCarInfo = dartCarInfo,index = self.index + 1})
                table.insert(self.personCarTable,grid_Template)
            else
                if self.delayRefresh ~= nil then
                    CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
                    self.delayRefresh = nil
                end
            end
            self.index = self.index + 1
        end,true)
    end
end

---刷新列表
function IndividEscortList2Template:RefreshList()
    self.DartCarList_UIGridContainer.MaxCount = self.dartCarListCount
    self.index = 0
    self.personCarTable = {}
    self.delayRefresh = CS.CSListUpdateMgr.Add(100,nil,function()
        if self.dartCarListCount ~= nil and self.index < self.dartCarListCount then
            local grid_GameObject = self.DartCarList_UIGridContainer.controlList[self.index]
            local dartCarInfo = self.dartCarList[self.index]
            local grid_Template = templatemanager.GetNewTemplate(grid_GameObject, self:GetPersonDartCarTemplateByCarState(self:GetPersonDartCarState(dartCarInfo)))
            grid_Template:RefreshPanel({dartCarInfo = dartCarInfo,index = self.index})
            table.insert(self.personCarTable,grid_Template)
        else
            if self.delayRefresh ~= nil then
                CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
                self.delayRefresh = nil
            end
        end
        self.index = self.index + 1
    end,true)
end

---刷新剩余劫镖次数
function IndividEscortList2Template:RefreshRemainPlunderCarNum()
    if self.HijackValue_UILabel ~= nil then
        self.HijackValue_UILabel.text = ""
        --self.HijackValue_UILabel.text = CS.CSScene.MainPlayerInfo.PersonDartcarInfo.BeBobbedCount
    end
end

---刷新前往领取列表
function IndividEscortList2Template:RefreshToReceiveList()
    local dartCarList = CS.CSScene.MainPlayerInfo.PersonDartcarInfo:GetReceiveCarList(self.personDartCarSourceType)
    self:RefreshPanel({dartCarList = dartCarList,personDartCarListType =LuaEnumPersonDartCarListType.ToReceiveDartCarList,personDartCarSourceType = self.personDartCarSourceType,parentCalss = self.parentCalss})
end

---刷新单个镖车
function IndividEscortList2Template:RefreshSigleDartCar(dartCarInfo)
    if self.personCarTable ~= nil then
        for k,v in pairs(self.personCarTable) do
            if v.lid == dartCarInfo.CarLid then
                v:RefreshPanel({dartCarInfo = dartCarInfo})
            end
        end
    end
end

---刷新下拉列表裁剪范围
function IndividEscortList2Template:RefreshListState()
    self.EscortList_UIPanel:SetRect(self.rectParams.center_x,self.rectParams.center_y,self.rectParams.softness_x,self.rectParams.softness_y)
    self.EscortList_ScrollView:ResetPosition()
end

---刷新帮助按钮
function IndividEscortList2Template:RefreshHelpBtn()
    if self.parentCalss ~= nil and self.parentCalss.HelpBtn_GameObject ~= nil then
        self.parentCalss.HelpBtn_GameObject:SetActive(self:ShowAddDartCarBtn())
    end
end
--endregion

--region 查询
function IndividEscortList2Template:ShowAddDartCarBtn()
    return self.personDartCarListType == LuaEnumPersonDartCarListType.RecommendDartCarList and uimanager:GetPanel("UIIndividEscortChoosePanel") == nil
end
--endregion

--region 获取
---获取个人镖车状态
function IndividEscortList2Template:GetPersonDartCarState(personDartCarInfo)
    if personDartCarInfo ~= nil then
        return Utility.EnumToInt(personDartCarInfo.DartCarType)
    end
end

---通过镖车状态获取镖车模板
function IndividEscortList2Template:GetPersonDartCarTemplateByCarState(carState)
    if carState == LuaEnumPersonDartCarStateType.WITEDRIVING then
        return luaComponentTemplates.IndividEscortGrid_WaitDrive2
    elseif carState == LuaEnumPersonDartCarStateType.DRIVING then
        return luaComponentTemplates.IndividEscortGrid_Driving
    elseif carState == LuaEnumPersonDartCarStateType.ENDDRIVING then
        return luaComponentTemplates.IndividEscortGrid_EndDrive
    else
        return nil
    end
end

function IndividEscortList2Template:OnDestroy()
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end
    if self.initListUpdate ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.initListUpdate)
        self.initListUpdate = nil
    end
end

---通过面板状态获取面板裁剪参数
---clipType (1.有按钮的裁剪范围   2.没有按钮的裁剪范围)
function IndividEscortList2Template:GetPersonDartCarPanelClipRangeParams(clipType)
    local params = {center_x = -118,center_y = -158,softness_x = 442,softness_y = 374}
    if clipType == 2 then
        params = {center_x = -118,center_y = -194,softness_x = 442,softness_y = 446}
    end
    return params
end
--endregion
return IndividEscortList2Template