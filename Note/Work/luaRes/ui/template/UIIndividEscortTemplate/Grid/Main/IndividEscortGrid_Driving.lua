local IndividEscortGrid_Driving = {}
setmetatable(IndividEscortGrid_Driving,luaComponentTemplates.IndividEscortGrid_Base)

--region 刷新
function IndividEscortGrid_Driving:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel",commonData)
    if self.analysisIsOk == nil or self.analysisIsOk == false or self.dartCarInfo == nil then
        return
    end
    self:RefreshCurPanel()
end

function IndividEscortGrid_Driving:RefreshCurPanel()
    ---头像
    self:RefreshSprite(self:GetHead_UISprite(),ternary(self.monsterInfo == nil,"",self.monsterInfo.head),true)
    ---名字
    self:RefreshLabel(self:GetName_UILabel(),ternary(self.yaBiaoTable == nil,"",self.yaBiaoTable.name) .. "(血量" ..self.dartCarInfo.PercentumHp .. "%)" ,true)
    ---奖励
    self:RefreshSprite(self:GetReward_UISprite(),ternary(self.rewardItemInfo == nil,"",self.rewardItemInfo.icon))
    self:RefreshLabel(self:GetReward_UILabel(),ternary(self.rewardNum == nil,"",self.rewardNum),true)
    ---时间刷新
    self:RefreshActive(self:GetLb_Time_UILabel(),true)
    self:StartUpdataRefresh(function()
        self:RefreshTime()
    end)
    ---劫镖标识
    self:RefreshActive(self:GetBeAttack_GameObject(),self.dartCarInfo ~= nil and self.dartCarInfo.IsBeAttack == true)
end
--endregion

--region 事件
function IndividEscortGrid_Driving:RefreshTime()
    self:RefreshLabel(self:GetLb_Time_UILabel(),ternary(self.dartCarInfo == nil,"",self.dartCarInfo:GetRemainTime()))
end
--endregion

return IndividEscortGrid_Driving