local IndividEscortListTemplate = {}
--region 初始化
function IndividEscortListTemplate:Init()
    self:InitComponent()
end

function IndividEscortListTemplate:InitComponent()
    self.DartCarList_UIGridContainer = self:Get("EscortList/Grid","UIGridContainer")
    self.LastEscort_GameObject = self:Get("LastEscort","GameObject")
    self.HijackValue_UILabel = self:Get("HijackValue","UILabel")
    self.EscortList_UIPanel = self:Get("EscortList","UIPanel")
end
--endregion

--region 刷新
---刷新面板
function IndividEscortListTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshListState()
    self:RefreshList()
    self:RefreshSpecial1Btn()
    self:RefreshRemainPlunderCarNum()
end

---解析数据
---@return 解析数据是否成功
function IndividEscortListTemplate:AnalysisParams(commonData)
    self.dartCarList = commonData.dartCarList
    if self.dartCarList == nil then
        return false
    end
    self.gridTable = {}
    self.panelState = self:GetPersonDartCarPanelStateType()
    self.rectParams = self:GetPersonDartCarPanelClipRangeParams(self.panelState)
    self.dartCarListCount = ternary( self.panelState == LuaEnumPersonDartCarPanelStateType.NORMAL,self.dartCarList.Count,self.dartCarList.Count - 1)
    return true
end

---刷新下拉列表状态类型（主要用于LastEscort_GameObject的显示后影响滑动显示范围）
function IndividEscortListTemplate:RefreshListState()
    self.EscortList_UIPanel:SetRect(self.rectParams.center_x,self.rectParams.center_y,self.rectParams.softness_x,self.rectParams.softness_y)
    self.LastEscort_GameObject:SetActive(self.panelState == LuaEnumPersonDartCarPanelStateType.SPECIAL1)
end

---刷新列表
function IndividEscortListTemplate:RefreshList()
    self.DartCarList_UIGridContainer.MaxCount = self.dartCarListCount
    self.index = 0
    self.personCarTable = {}
    self.delayRefresh = CS.CSListUpdateMgr.Add(100,nil,function()
        if self.dartCarListCount ~= nil and self.index < self.dartCarListCount then
            local grid_GameObject = self.DartCarList_UIGridContainer.controlList[self.index]
            local dartCarInfo = self.dartCarList[self.index]
            local grid_Template = templatemanager.GetNewTemplate(grid_GameObject, self:GetPersonDartCarTemplateByCarState(self:GetPersonDartCarState(dartCarInfo)))
            grid_Template:RefreshPanel({dartCarInfo = dartCarInfo})
            self.gridTable[dartCarInfo.CarLid] = grid_Template
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

---刷新特殊按钮
function IndividEscortListTemplate:RefreshSpecial1Btn()
    if self.dartCarList.Count <= 4 then
        return
    end
    local dartCarInfo = self.dartCarList[self.dartCarList.Count - 1]
    local grid_Template = templatemanager.GetNewTemplate(self.LastEscort_GameObject, self:GetPersonDartCarTemplateByCarState(self:GetPersonDartCarState(dartCarInfo)))
    grid_Template:RefreshPanel({dartCarInfo = dartCarInfo})
    self.gridTable[dartCarInfo.CarLid] = grid_Template
    table.insert(self.personCarTable,grid_Template)
end

---刷新剩余劫镖次数
function IndividEscortListTemplate:RefreshRemainPlunderCarNum()
    if self.HijackValue_UILabel ~= nil then
        self.HijackValue_UILabel.text = ""
        --self.HijackValue_UILabel.text = CS.CSScene.MainPlayerInfo.PersonDartcarInfo.BeBobbedCount
    end
end
--endregion

--region 获取
---获取个人镖车状态
function IndividEscortListTemplate:GetPersonDartCarState(personDartCarInfo)
    if personDartCarInfo ~= nil then
        return Utility.EnumToInt(personDartCarInfo.DartCarType)
    end
end

---通过镖车状态获取镖车模板
function IndividEscortListTemplate:GetPersonDartCarTemplateByCarState(carState)
    if carState == LuaEnumPersonDartCarStateType.WITEDRIVING then
        return luaComponentTemplates.IndividEscortGrid_WaitDrive
    elseif carState == LuaEnumPersonDartCarStateType.DRIVING then
        return luaComponentTemplates.IndividEscortGrid_Driving
    elseif carState == LuaEnumPersonDartCarStateType.ENDDRIVING then
        return luaComponentTemplates.IndividEscortGrid_EndDrive
    else
        return nil
    end
end

---获取个人押镖面板状态类型
function IndividEscortListTemplate:GetPersonDartCarPanelStateType()
    if self.dartCarList ~= nil then
        local isOpenStartYaBiaoBtn = CS.CSScene.MainPlayerInfo.PersonDartcarInfo:CheckIsOpenStartYaBiaoBtn(self.dartCarList)
        if isOpenStartYaBiaoBtn == false then
            return LuaEnumPersonDartCarPanelStateType.NORMAL
        elseif isOpenStartYaBiaoBtn == true then
            return LuaEnumPersonDartCarPanelStateType.SPECIAL1
        end
    end
    return LuaEnumPersonDartCarPanelStateType.NORMAL
end

---通过面板状态获取面板裁剪参数
function IndividEscortListTemplate:GetPersonDartCarPanelClipRangeParams(panelState)
    local params = {center_x = -118,center_y = -237,softness_x = 442,softness_y = 532}
    if panelState ~= nil and panelState == LuaEnumPersonDartCarPanelStateType.SPECIAL1 then
        params = {center_x = -118,center_y = -182,softness_x = 442,softness_y = 422}
    end
    return params
end

function IndividEscortListTemplate:OnDestroy()
    if self.delayRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayRefresh)
        self.delayRefresh = nil
    end
end
--endregion
return IndividEscortListTemplate