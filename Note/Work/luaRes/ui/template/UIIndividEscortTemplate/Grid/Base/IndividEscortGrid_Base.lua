local IndividEscortGrid_Base = {}
--region  组件
---头像
function IndividEscortGrid_Base:GetHead_UISprite()
    if self.mHead_UISprite == nil or CS.StaticUtility.IsNull(self.mHead_UISprite) then
        self.mHead_UISprite = self:Get("head/headIcon", "UISprite")
    end
    return self.mHead_UISprite
end

---镖车名字
function IndividEscortGrid_Base:GetName_UILabel()
    if self.mName_UILabel == nil or CS.StaticUtility.IsNull(self.mName_UILabel) then
        self.mName_UILabel = self:Get("Name/name", "UILabel")
    end
    return self.mName_UILabel
end

---按钮
function IndividEscortGrid_Base:GetBtn_Hire_GameObject()
    if self.mBtn_Hire_GameObject == nil or CS.StaticUtility.IsNull(self.mBtn_Hire_GameObject) then
        self.mBtn_Hire_GameObject = self:Get("btn_hire", "GameObject")
    end
    return self.mBtn_Hire_GameObject
end

---按钮文本内容
function IndividEscortGrid_Base:GetBtn_Hire_UILabel()
    if self.mBtn_Hire_UILabel == nil or CS.StaticUtility.IsNull(self.mBtn_Hire_UILabel) then
        self.mBtn_Hire_UILabel = self:Get("btn_hire/Label", "UILabel")
    end
    return self.mBtn_Hire_UILabel
end

---时间文本
function IndividEscortGrid_Base:GetLb_Time_UILabel()
    if self.mLb_Time_UILabel == nil or CS.StaticUtility.IsNull(self.mLb_Time_UILabel) then
        self.mLb_Time_UILabel = self:Get("lb_time", "UILabel")
    end
    return self.mLb_Time_UILabel
end

---镖车选项列表
function IndividEscortGrid_Base:GetDartCar_DropDown()
    if self.mDartCar_DropDown == nil or CS.StaticUtility.IsNull(self.mDartCar_DropDown) then
        self.mDartCar_DropDown = self:Get("Name/DropDown", "Top_UIDropDown")
    end
    return self.mDartCar_DropDown
end

---收益文本
function IndividEscortGrid_Base:GetReward_UILabel()
    if self.mReward_UILabel == nil or CS.StaticUtility.IsNull(self.mReward_UILabel) then
        self.mReward_UILabel = self:Get("reward", "UILabel")
    end
    return self.mReward_UILabel
end

---收益图片
function IndividEscortGrid_Base:GetReward_UISprite()
    if self.mReward_UISprite == nil or CS.StaticUtility.IsNull(self.mReward_UISprite) then
        self.mReward_UISprite = self:Get("reward/Sprite", "UISprite")
    end
    return self.mReward_UISprite
end

---花费文本
function IndividEscortGrid_Base:GetCost_UILabel()
    if self.mCost_UILabel == nil or CS.StaticUtility.IsNull(self.mCost_UILabel) then
        self.mCost_UILabel = self:Get("cost", "UILabel")
    end
    return self.mCost_UILabel
end

---花费图片
function IndividEscortGrid_Base:GetCost_UISprite()
    if self.mCost_UISprite == nil or CS.StaticUtility.IsNull(self.mCost_UISprite) then
        self.mCost_UISprite = self:Get("cost/Sprite", "UISprite")
    end
    return self.mCost_UISprite
end

---被劫镖标识
function IndividEscortGrid_Base:GetBeAttack_GameObject()
    if self.mBeAttack_GameObject == nil or CS.StaticUtility.IsNull(self.mBeAttack_GameObject) then
        self.mBeAttack_GameObject = self:Get("Hijack", "GameObject")
    end
    return self.mBeAttack_GameObject
end

---背景
function IndividEscortGrid_Base:GetBg_GameObject()
    if self.mBg_GameObject == nil or CS.StaticUtility.IsNull(self.mBg_GameObject) then
        self.mBg_GameObject = self:Get("bg", "GameObject")
    end
    return self.mBg_GameObject
end
--endregion

--region 初始化
function IndividEscortGrid_Base:Init()
    self:InitComponent()
    self:InitParams()
    self:BindEvents()
end

---初始化默认隐藏组件
function IndividEscortGrid_Base:InitComponent()
    self:RefreshActive(self:GetBtn_Hire_GameObject(), false)
    self:RefreshActive(self:GetLb_Time_UILabel(), false)
    self:RefreshActive(self:GetCost_UILabel(), false)
    self:RefreshActive(self:GetDartCar_DropDown(), false)
    self:RefreshActive(self:GetBeAttack_GameObject(), false)
end

function IndividEscortGrid_Base:InitParams()
    self.dropDwonList = nil
    self.dropDwonNameList = nil

end

function IndividEscortGrid_Base:BindEvents()
    self:SetBtnOnClick(self:GetReward_UISprite(), function(go)
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.rewardItemInfo })
    end)
    self:SetBtnOnClick(self:GetCost_UISprite(), function(go)
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.consumeItemInfo })
    end)
end
--endregion

--region 刷新
function IndividEscortGrid_Base:RefreshPanel(commonData)
    self.analysisIsOk = self:AnalysisParams(commonData)
    self:DefaultRefreshPanel()
end

---解析参数
---@return 解析参数是否成功
function IndividEscortGrid_Base:AnalysisParams(commonData)
    if commonData == nil or commonData.dartCarInfo == nil then
        return false
    end
    self.dartCarInfo = commonData.dartCarInfo
    self.index = commonData.index
    self.lid = self.dartCarInfo.CarLid
    self.yaBiaoTable = self.dartCarInfo.YaBiaoTable
    if self.yaBiaoTable == nil then
        return false
    end
    self.CarType = Utility.EnumToInt(self.dartCarInfo.DartCarType)
    self:AnalysisDartCarParams(self.yaBiaoTable)
    return true
end

function IndividEscortGrid_Base:DefaultRefreshPanel()
    if self.index ~= nil then
        self:RefreshActive(self:GetBg_GameObject(), self.index % 2 == 0)
    end
end

---解析镖车相关参数
function IndividEscortGrid_Base:AnalysisDartCarParams(dartCarInfo)
    if dartCarInfo ~= nil then
        ---镖车消耗
        if dartCarInfo.consume ~= nil and dartCarInfo.consume.list ~= nil and dartCarInfo.consume.list.Count > 1 then
            self.consumeItemId = dartCarInfo.consume.list[0]
            self.consumeNum = dartCarInfo.consume.list[1]
            local consumeItemInfoIsFind, consumeItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.consumeItemId)
            if consumeItemInfoIsFind then
                self.consumeItemInfo = consumeItemInfo
            end
        end
        ---镖车奖励
        if self.dartCarInfo ~= nil and Utility.EnumToInt(self.dartCarInfo.EndDartCarState) == LuaEnumPersonCarEndType.DEFEAT then
            ---失败奖励
            if dartCarInfo.failReward ~= nil and dartCarInfo.failReward.list ~= nil and dartCarInfo.failReward.list.Count > 1 then
                self.rewardItemId = dartCarInfo.failReward.list[0]
                self.rewardNum = dartCarInfo.failReward.list[1]
                local rewardItemInfoIsFind, rewardItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.rewardItemId)
                if rewardItemInfoIsFind then
                    self.rewardItemInfo = rewardItemInfo
                end
            end
        else
            ---成功奖励
            if dartCarInfo.reward ~= nil and dartCarInfo.reward.list ~= nil and dartCarInfo.reward.list.Count > 1 then
                self.rewardItemId = dartCarInfo.reward.list[0]
                self.rewardNum = dartCarInfo.reward.list[1]
                local rewardItemInfoIsFind, rewardItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.rewardItemId)
                if rewardItemInfoIsFind then
                    self.rewardItemInfo = rewardItemInfo
                end
            end
        end

        ---镖车怪物表
        local monsterInfoIsFind, monsterInfo = CS.Cfg_MonsterTableManager.Instance:TryGetValue(dartCarInfo.mid)
        self.monsterInfo = monsterInfo
        if self.monsterInfo ~= nil then
            self.dartName = self.monsterInfo.name
        end
    end
end
--endregion

--region UI控制
---控制显示
function IndividEscortGrid_Base:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) and state ~= nil then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function IndividEscortGrid_Base:RefreshSprite(obj, spriteName, show)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) and spriteName ~= nil then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true and show == true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function IndividEscortGrid_Base:RefreshLabel(obj, text, show)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) and text ~= nil then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true and show == true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置下拉列表数据
function IndividEscortGrid_Base:SetDropDown(obj, dropDownList, show)
    if obj ~= nil and CS.StaticUtility.IsNull(obj) == false and dropDownList ~= nil then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UIDropDown)) then
            obj:SetOptions(dropDownList)
        else
            local curDropDown = self:GetCurComp(obj, "", "Top_UIDropDown")
            if curDropDown ~= nil then
                curDropDown:SetOptions(dropDownList)
            end
        end
        if obj.gameObject.activeSelf ~= true and show == true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置下拉列表点击回调
function IndividEscortGrid_Base:SetDropDownOnClick(obj, action, show)
    if obj ~= nil and CS.StaticUtility.IsNull(obj) == false and action ~= nil then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UIDropDown)) then
            obj.OnValueChange:Add(action)
        else
            local curDropDown = self:GetCurComp(obj, "", "Top_UIDropDown")
            if curDropDown ~= nil then
                curDropDown.OnValueChange:Add(action)
            end
        end
        if obj.gameObject.activeSelf ~= true and show == true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置下拉列表显示的选择内容
function IndividEscortGrid_Base:SetDropDownShowName(obj, name)
    if obj ~= nil and CS.StaticUtility.IsNull(obj) == false and name ~= nil then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UIDropDown)) then
            obj:SetCaptionLabel(name)
        else
            local curDropDown = self:GetCurComp(obj, "", "Top_UIDropDown")
            if curDropDown ~= nil then
                curDropDown:SetCaptionLabel(name)
            end
        end
    end
end

---设置按钮点击
function IndividEscortGrid_Base:SetBtnOnClick(obj, action)
    if obj ~= nil and CS.StaticUtility.IsNull(obj) == false and action ~= nil then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---启动刷新
---@params 刷新回调
function IndividEscortGrid_Base:StartUpdataRefresh(action)
    self.action = action
    --if self.updateRefresh ~= nil then
    --    CS.CSListUpdateMgr.Instance:Remove(self.updateRefresh)
    --    self.updateRefresh = nil
    --end
    --self.updateRefresh = CS.CSListUpdateMgr.Add(200, nil, action, true)
end
--endregion

--region 检测
---检测是否在冷却中并弹气泡
function IndividEscortGrid_Base:CheckAndOpenPop(tablData)
    if self.CarType == LuaEnumPersonDartCarStateType.WITEDRIVING then
        local second = 0
        if tablData ~= nil and tablData.time ~= nil then
            second = tablData.time * 0.001
        end
        local str = CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(223, second)
        Utility.ShowPopoTips(self:GetBtn_Hire_GameObject(), str, 223)
    end
end
--endregion

--region Update
function IndividEscortGrid_Base:UpdateRefresh()
    if self.action ~= nil then
        self.action()
    end
end
--endregion

--region Disable
function IndividEscortGrid_Base:OnDisable()
    --if self.updateRefresh ~= nil then
    --    CS.CSListUpdateMgr.Instance:Remove(self.updateRefresh)
    --    self.updateRefresh = nil
    --end
end
--endregion

--region 销毁
function IndividEscortGrid_Base:OnDestroy()
    --if self.updateRefresh ~= nil then
    --    CS.CSListUpdateMgr.Instance:Remove(self.updateRefresh)
    --    self.updateRefresh = nil
    --end
end
--endregion
return IndividEscortGrid_Base