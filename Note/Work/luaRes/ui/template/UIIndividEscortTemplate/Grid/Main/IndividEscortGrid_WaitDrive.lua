local IndividEscortGrid_WaitDrive = {}
setmetatable(IndividEscortGrid_WaitDrive,luaComponentTemplates.IndividEscortGrid_Base)
--region 刷新
function IndividEscortGrid_WaitDrive:RefreshPanel(commonData)
    self.refreshIsEnd = false
    self:RunBaseFunction("RefreshPanel",commonData)
    if self.analysisIsOk == nil or self.analysisIsOk == false then
        return
    end
    if self:AnalysisParams() == false then
        return
    end
    self.CarType = LuaEnumPersonDartCarStateType.WITEDRIVING
    self:RefreshCurPanel()
end

---解析数据
---@return 解析数据是否成功
function IndividEscortGrid_WaitDrive:AnalysisParams()
    ---下拉列表数据
    self.dropDwonList = CS.Cfg_PersonDartCarTableManager.Instance:GetYaBiaoList()
    self.dropDwonNameList = CS.Cfg_PersonDartCarTableManager.Instance:GetYaBiaoArray()
    ---下拉列表默认选择
    self.curChooseIndex = 0
    if self.dropDwonList ~= nil and self.dropDwonList.Count > 0 then
        self.curChooseIndex = self.dropDwonList.Count - 1
    end
    ---解析下拉列表参数
    self:AnalysisChooseDartCarParams(self.curChooseIndex + 1)
    if self.dropDwonList.Count ~= self.dropDwonNameList.Length then
        return false
    end
    return true
end

---解析镖车数据
function IndividEscortGrid_WaitDrive:AnalysisChooseDartCarParams(id)
    if self.dropDwonList ~= nil and self.dropDwonList.Count > 0 and id <= self.dropDwonList.Count then
        self.personDartCarInfo = self.dropDwonList[id - 1]
    else
        local personDartCarInfoIsFind,personDartCarInfo = CS.Cfg_PersonDartCarTableManager.Instance:TryGetValue(id)
        self.personDartCarInfo = personDartCarInfo
    end
    self:AnalysisDartCarParams(self.personDartCarInfo)
end

---刷新面板
function IndividEscortGrid_WaitDrive:RefreshCurPanel()
    ---头像
    self:RefreshSprite(self:GetHead_UISprite(),ternary(self.monsterInfo == nil,"",self.monsterInfo.head),true)
    ---下拉列表
    self:SetDropDown(self:GetDartCar_DropDown(),self.dropDwonNameList,true)
    self:SetDropDownOnClick(self:GetDartCar_DropDown(),function(params) self:DropDownOnClick(params) end)
    self:SetDropDownShowName(self:GetDartCar_DropDown(),self.yaBiaoTable.name)
    ---奖励
    self:RefreshSprite(self:GetReward_UISprite(),ternary(self.rewardItemInfo == nil,"",self.rewardItemInfo.icon))
    self:RefreshLabel(self:GetReward_UILabel(),ternary(self.rewardNum == nil,"",self.rewardNum),true)
    ---消耗
    self:RefreshSprite(self:GetCost_UISprite(),ternary(self.consumeItemInfo == nil,"",self.consumeItemInfo.icon))
    self:RefreshLabel(self:GetCost_UILabel(),ternary(self.consumeNum == nil,"",self.consumeNum),true)
    ---按钮
    self:RefreshLabel(self:GetBtn_Hire_UILabel(),"出发",true)
    self:SetBtnOnClick(self:GetBtn_Hire_GameObject(),function(go)self:GoBtnOnClick(go) end)
    self.refreshIsEnd = true
end

---下拉列表刷新面板数据
function IndividEscortGrid_WaitDrive:DropDownClickRefreshPanel()
    ---头像
    self:RefreshSprite(self:GetHead_UISprite(),ternary(self.monsterInfo == nil,"",self.monsterInfo.head),true)
    ---奖励
    self:RefreshSprite(self:GetReward_UISprite(),ternary(self.rewardItemInfo == nil,"",self.rewardItemInfo.icon))
    self:RefreshLabel(self:GetReward_UILabel(),ternary(self.rewardNum == nil,"",self.rewardNum),true)
    ---消耗
    self:RefreshSprite(self:GetCost_UISprite(),ternary(self.consumeItemInfo == nil,"",self.consumeItemInfo.icon))
    self:RefreshLabel(self:GetCost_UILabel(),ternary(self.consumeNum == nil,"",self.consumeNum),true)
end
--endregion

--region 点击事件
---下拉列表点击事件
function IndividEscortGrid_WaitDrive:DropDownOnClick(params)
    if self.refreshIsEnd == true then
        local yaBiaoId = params.index + 1
        local personDartCarInfoIsFind,personDartCarInfo = CS.Cfg_PersonDartCarTableManager.Instance:TryGetValue(yaBiaoId)
        if personDartCarInfoIsFind then
            self.personDartCarInfo = personDartCarInfo
            self:AnalysisDartCarParams(self.personDartCarInfo)
            self:DropDownClickRefreshPanel()
        end
    end
end

---出发按钮点击事件
function IndividEscortGrid_WaitDrive:GoBtnOnClick(go)
    if self.consumeItemInfo ~= nil then
        local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.consumeItemId)
        if self.consumeNum > bagItemNum then
            Utility.ShowPopoTips(go,nil,219)
        else
            networkRequest.ReqEscortCart(self.personDartCarInfo.id)
        end
    end
end
--endregion
return IndividEscortGrid_WaitDrive