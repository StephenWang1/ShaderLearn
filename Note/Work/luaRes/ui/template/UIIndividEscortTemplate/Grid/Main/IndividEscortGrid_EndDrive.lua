local IndividEscortGrid_EndDrive = {}
setmetatable(IndividEscortGrid_EndDrive,luaComponentTemplates.IndividEscortGrid_Base)

--region 刷新
function IndividEscortGrid_EndDrive:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel",commonData)
    if self.analysisIsOk == nil or self.analysisIsOk == false or self.dartCarInfo == nil then
        return
    end
    self:RefreshCurPanel()
end

function IndividEscortGrid_EndDrive:RefreshCurPanel()
    ---头像
    self:RefreshSprite(self:GetHead_UISprite(),ternary(self.monsterInfo == nil,"",self.monsterInfo.head),true)
    ---名字
    self:RefreshLabel(self:GetName_UILabel(),ternary(self.yaBiaoTable == nil,"",self.yaBiaoTable.name) .. "(血量" ..self.dartCarInfo.PercentumHp .. "%)" ,true)
    ---奖励
    self:RefreshSprite(self:GetReward_UISprite(),ternary(self.rewardItemInfo == nil,"",self.rewardItemInfo.icon))
    self:RefreshLabel(self:GetReward_UILabel(),ternary(self.rewardNum == nil,"",self.rewardNum),true)
    ---按钮
    local text = "前往领取"
    if self:IsCanReceive() == true then
        text = "[fff0c2]领取"
    end
    self:RefreshLabel(self:GetBtn_Hire_UILabel(),text,true)
    self:SetBtnOnClick(self:GetBtn_Hire_GameObject(),function(go)self:GetRewardBtnOnClick(go) end)
end
--endregion

--region 事件
function IndividEscortGrid_EndDrive:GetRewardBtnOnClick(go)
    --uimanager:CreatePanel("UIPromptEscortDoubleRewardPanel",nil,{dartCarInfo = self.dartCarInfo})
    if self:IsCanReceive() then
        networkRequest.ReqReceivePersonalCartReward(self.dartCarInfo.CarLid, 1)
    else
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({self.dartCarInfo.ReceiveNpcId},"UIIndividEscortPanel",CS.EAutoPathFindSourceSystemType.Normal,CS.EAutoPathFindType.Normal_TowardNPC,self.dartCarInfo.ReceiveNpcId)
        uimanager:ClosePanel("UIIndividEscortPanel")
    end
end
--endregion

--region 查询
function IndividEscortGrid_EndDrive:IsCanReceive()
    local mapId = CS.CSScene.MainPlayerInfo.MapID
    return mapId == 1011
end
--endregion
return IndividEscortGrid_EndDrive