local IndividEscortGrid_WaitDrive2 = {}
setmetatable(IndividEscortGrid_WaitDrive2,luaComponentTemplates.IndividEscortGrid_Base)
--region 刷新
function IndividEscortGrid_WaitDrive2:RefreshPanel(commonData)
    self.refreshIsEnd = false
    self:RunBaseFunction("RefreshPanel",commonData)
    self.CarType = LuaEnumPersonDartCarStateType.WITEDRIVING
    if self.analysisIsOk == false then
        self:RefreshActive(self.go,false)
        return
    end
    self:RefreshCurPanel()
end

---刷新面板
function IndividEscortGrid_WaitDrive2:RefreshCurPanel()
    if self.monsterInfo == nil then
        return
    end
    ---头像
    self:RefreshSprite(self:GetHead_UISprite(),ternary(self.monsterInfo == nil,"",self.monsterInfo.head),true)
    ---名字
    self:RefreshLabel(self:GetName_UILabel(),ternary(self.yaBiaoTable == nil,"",self.yaBiaoTable.name) ,true)
    ---奖励
    self:RefreshSprite(self:GetReward_UISprite(),ternary(self.rewardItemInfo == nil,"",self.rewardItemInfo.icon))
    self:RefreshLabel(self:GetReward_UILabel(),ternary(self.rewardNum == nil,"",self.rewardNum),true)
    ---消耗
    self:RefreshSprite(self:GetCost_UISprite(),ternary(self.consumeItemInfo == nil,"",self.consumeItemInfo.icon))
    self:RefreshLabel(self:GetCost_UILabel(),ternary(self.consumeNum == nil,"",self.consumeNum),true)
    ---按钮
    self:RefreshLabel(self:GetBtn_Hire_UILabel(),"快捷押镖",true)
    self:SetBtnOnClick(self:GetBtn_Hire_GameObject(),function(go)self:GoBtnOnClick(go) end)
    self.refreshIsEnd = true
end
--endregion

--region 点击事件
---出发按钮点击事件
function IndividEscortGrid_WaitDrive2:GoBtnOnClick(go)
    if self.consumeItemInfo ~= nil then
        local bagItemNum = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(self.consumeItemId)
        if self.consumeNum > bagItemNum then
            Utility.ShowPopoTips(go,nil,219)
        else
            networkRequest.ReqEscortCart(self.yaBiaoTable.id)
        end
    end
end
--endregion
return IndividEscortGrid_WaitDrive2