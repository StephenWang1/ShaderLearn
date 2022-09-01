local UIBuDouKaiPanel_Base = {}
--region 组件
---淘汰赛阶段标题文本
function UIBuDouKaiPanel_Base:GetFirstStage_UILabel()
    if self.FirstStage_UILabel == nil then
        self.FirstStage_UILabel = self:Get("WidgetRoot/Tween/competitionProgress/first/Label","UILabel")
    end
    return self.FirstStage_UILabel
end

---淘汰赛阶段图片(底图)
function UIBuDouKaiPanel_Base:GetFirstStage_UISprite()
    if self.FirstStage_UISprite == nil then
        self.FirstStage_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/first/sprite","UISprite")
    end
    return self.FirstStage_UISprite
end

---淘汰赛阶段图片(高亮图)
function UIBuDouKaiPanel_Base:GetFirstStageHighLight_UISprite()
    if self.FirstStageHighLight_UISprite == nil then
        self.FirstStageHighLight_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/first/highLight","UISprite")
    end
    return self.FirstStageHighLight_UISprite
end

---淘汰赛阶段动画
function UIBuDouKaiPanel_Base:GetFirstStage_TweenAlpha()
    if self.FirstStage_TweenAlpha == nil then
        self.FirstStage_TweenAlpha = self:Get("WidgetRoot/Tween/competitionProgress/first/highLight","TweenAlpha")
    end
    return self.FirstStage_TweenAlpha
end

---晋级赛阶段标题文本
function UIBuDouKaiPanel_Base:GetSecondStage_UILabel()
    if self.SecondStage_UILabel == nil then
        self.SecondStage_UILabel = self:Get("WidgetRoot/Tween/competitionProgress/second/Label","UILabel")
    end
    return self.SecondStage_UILabel
end

---晋级赛阶段图片（底图）
function UIBuDouKaiPanel_Base:GetSecondStage_UISprite()
    if self.SecondStage_UISprite == nil then
        self.SecondStage_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/second/sprite","UISprite")
    end
    return self.SecondStage_UISprite
end

---晋级赛阶段图片（高亮图）
function UIBuDouKaiPanel_Base:GetSecondStageHighLight_UISprite()
    if self.SecondStageHighLight_UISprite == nil then
        self.SecondStageHighLight_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/second/highLight","UISprite")
    end
    return self.SecondStageHighLight_UISprite
end

---晋级赛极端动画
function UIBuDouKaiPanel_Base:GetSecondStage_TweenAlpha()
    if self.SecondStage_TweenAlpha == nil then
        self.SecondStage_TweenAlpha = self:Get("WidgetRoot/Tween/competitionProgress/second/highLight","TweenAlpha")
    end
    return self.SecondStage_TweenAlpha
end

---决赛阶段段标题文本
function UIBuDouKaiPanel_Base:GetThirdStage_UILabel()
    if self.ThirdStage_UILabel == nil then
        self.ThirdStage_UILabel = self:Get("WidgetRoot/Tween/competitionProgress/third/Label","UILabel")
    end
    return self.ThirdStage_UILabel
end

---决赛阶段段图片(底图)
function UIBuDouKaiPanel_Base:GetThirdStage_UISprite()
    if self.ThirdStage_UISprite == nil then
        self.ThirdStage_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/third/sprite","UISprite")
    end
    return self.ThirdStage_UISprite
end

---决赛阶段段图片(高亮图)
function UIBuDouKaiPanel_Base:GetThirdStageHighLight_UISprite()
    if self.ThirdStageHighLight_UISprite == nil then
        self.ThirdStageHighLight_UISprite = self:Get("WidgetRoot/Tween/competitionProgress/third/highLight","UISprite")
    end
    return self.ThirdStageHighLight_UISprite
end

---决赛阶段段动画
function UIBuDouKaiPanel_Base:GetThirdStage_TweenAlpha()
    if self.ThirdStage_TweenAlpha == nil then
        self.ThirdStage_TweenAlpha = self:Get("WidgetRoot/Tween/competitionProgress/third/highLight","TweenAlpha")
    end
    return self.ThirdStage_TweenAlpha
end

---押注按钮
function UIBuDouKaiPanel_Base:GetBetBtn_GameObject()
    if self.BetBtn_GameObject == nil then
        self.BetBtn_GameObject = self:Get("WidgetRoot/Tween/btn_betting","GameObject")
    end
    return self.BetBtn_GameObject
end

---押注按钮TweenPosition
function UIBuDouKaiPanel_Base:GetBetBtn_TweenPosition()
    if self.BetBtn_TweenPosition == nil then
        self.BetBtn_TweenPosition = self:Get("WidgetRoot/Tween/btn_betting","TweenPosition")
    end
    return self.BetBtn_TweenPosition
end

---排行榜按钮
function UIBuDouKaiPanel_Base:GetRankBtn_GameObject()
    if self.RankBtn_GameObject == nil then
        self.RankBtn_GameObject = self:Get("WidgetRoot/Tween/btn_rank","GameObject")
    end
    return self.RankBtn_GameObject
end

---排行榜按钮TweenPosition
function UIBuDouKaiPanel_Base:GetRankBtn_TweenPosition()
    if self.RankBtn_TweenPosition == nil then
        self.RankBtn_TweenPosition = self:Get("WidgetRoot/Tween/btn_rank","TweenPosition")
    end
    return self.RankBtn_TweenPosition
end

---阶段描述信息
function UIBuDouKaiPanel_Base:GetStageDescribe_UILabel()
    if self.StageDescribe_UILabel == nil then
        self.StageDescribe_UILabel = self:Get("WidgetRoot/Tween/competitionState","UILabel")
    end
    return self.StageDescribe_UILabel
end

---主角阶段描述信息
function UIBuDouKaiPanel_Base:GetMainPlayerStageDescribe_UILabel()
    if self.MainPlayerStageDescribe_UILabel == nil then
        self.MainPlayerStageDescribe_UILabel = self:Get("WidgetRoot/Tween/competitionPlayer_state","UILabel")
    end
    return self.MainPlayerStageDescribe_UILabel
end

---剩余时间文本
function UIBuDouKaiPanel_Base:GetCountDown_UILabel()
    if self.CountDown_UILabel == nil then
        self.CountDown_UILabel = self:Get("WidgetRoot/Tween/countdown","UILabel")
    end
    return self.CountDown_UILabel
end

---倒计时特效
function UIBuDouKaiPanel_Base:GetCountDownEffect_CSUIEffectLoad()
    if self.CountDownEffect_CSUIEffectLoad == nil then
        self.CountDownEffect_CSUIEffectLoad = self:Get("WidgetRoot/GameBeginEffect/CountDownEffect","CSUIEffectLoad")
    end
    return self.CountDownEffect_CSUIEffectLoad
end

---倒计时阶段图片
function UIBuDouKaiPanel_Base:GetCountDownStage_UISprite()
    if self.CountDownStage_UISprite == nil then
        self.CountDownStage_UISprite = self:Get("WidgetRoot/GameBeginEffect/stageSprite","UISprite")
    end
    return self.CountDownStage_UISprite
end

---倒计时阶段动画
function UIBuDouKaiPanel_Base:GetCountDownStage_TweenAlpha()
    if self.CountDownStage_TweenAlpha == nil then
        self.CountDownStage_TweenAlpha = self:Get("WidgetRoot/GameBeginEffect/stageSprite","TweenAlpha")
    end
    return self.CountDownStage_TweenAlpha
end
--endregion

--region 数据
---tween状态
UIBuDouKaiPanel_Base.TweenState = {
    StopTween = 0,
    TweenForward = 1,
    TweenReverse = 2,
    PlayTween = 3,
}
--endregion

function UIBuDouKaiPanel_Base:Init()
    self:AddUpdate()
    self:BindEvents()
end

function UIBuDouKaiPanel_Base:BindEvents()
    self:BindClickCallBack(self:GetBetBtn_GameObject(),function()
        CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation({ 329 }, "UIBettingDivisionPanel", CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC, { 329 })
    end)
    self:BindClickCallBack(self:GetRankBtn_GameObject(),function()
        --print("打开详细排行界面")
        CS.CSScene.MainPlayerInfo.ActivityInfo.ShowRank = true
        networkRequest.ReqLookDuboRank(1)
    end)
end
--region 面板刷新
function UIBuDouKaiPanel_Base:RefreshPanel()
    self:InitParams()
    self:InitPanel()
    self:RefreshBaseTableParams()
end

function UIBuDouKaiPanel_Base:InitParams()
    self.buDouKaiInfo = CS.CSScene.MainPlayerInfo.BudowillInfo
    self.buDouKaiContentParams = CS.CSScene.MainPlayerInfo.BuDouKaiContentParams
    if self.buDouKaiInfo ~= nil then
        self.buDouKaiTableInfo = CS.Cfg_WuDaoHuiTableManager.Instance:GetBuDouKaiStageTableData(self.buDouKaiInfo.mBuDouKaiStage)
    end
    self.OpenStartCountDownTime = CS.Cfg_GlobalTableManager.Instance.BuDouKaiStartCountDown
    self.buDouKaiStage = Utility.EnumToInt(self.buDouKaiInfo.mBuDouKaiStage)
    self.playCountDownReduceValue = 1
    self.needPlayCountDownEffect = false
end

function UIBuDouKaiPanel_Base:InitPanel()
    self:RefreshActive(self:GetBetBtn_GameObject(),false)
    self:RefreshActive(self:GetRankBtn_GameObject(),false)
    self:RefreshActive(self:GetMainPlayerStageDescribe_UILabel(),false)
end

function UIBuDouKaiPanel_Base:RefreshBaseTableParams()
    ---没有配表的情况下，以默认的刷新规则
    if self.buDouKaiTableInfo == nil then
        self:RefreshLabel(self:GetStageDescribe_UILabel(),"没有阶段" .. self.buDouKaiInfo.mBuDouKaiStage .. "的描述信息")
        self:RefreshLabel(self:GetMainPlayerStageDescribe_UILabel(),"")
        self:SetBtnShow(nil)
        return
    else
        ---淘汰赛
        self:RefreshLabel(self:GetFirstStage_UILabel(),self.buDouKaiTableInfo.firstLabel)
        self:RefreshSprite(self:GetFirstStage_UISprite(),self.buDouKaiTableInfo.firstSprite)
        self:RefreshSprite(self:GetFirstStageHighLight_UISprite(),self.buDouKaiTableInfo.firstHighLight)
        self:RefreshTween(self:GetFirstStage_TweenAlpha(), ternary(CS.System.String.IsNullOrEmpty(self.buDouKaiTableInfo.firstHighLight) == false,self.TweenState.PlayTween,self.TweenState.StopTween))
        ---晋级赛
        self:RefreshLabel(self:GetSecondStage_UILabel(),self.buDouKaiTableInfo.secondLabel)
        self:RefreshSprite(self:GetSecondStage_UISprite(),self.buDouKaiTableInfo.secondSprite)
        self:RefreshSprite(self:GetSecondStageHighLight_UISprite(),self.buDouKaiTableInfo.secondHighLight)
        self:RefreshTween(self:GetSecondStage_TweenAlpha(), ternary(CS.System.String.IsNullOrEmpty(self.buDouKaiTableInfo.secondHighLight) == false,self.TweenState.PlayTween,self.TweenState.StopTween))
        ---决赛
        self:RefreshLabel(self:GetThirdStage_UILabel(),self.buDouKaiTableInfo.thirdLabel)
        self:RefreshSprite(self:GetThirdStage_UISprite(),self.buDouKaiTableInfo.thirdSprite)
        self:RefreshSprite(self:GetThirdStageHighLight_UISprite(),self.buDouKaiTableInfo.thirdHighLight)
        self:RefreshTween(self:GetThirdStage_TweenAlpha(), ternary(CS.System.String.IsNullOrEmpty(self.buDouKaiTableInfo.thirdHighLight) == false,self.TweenState.PlayTween,self.TweenState.StopTween))
        ---按钮显示
        self:SetBtnShow(CS.Cfg_WuDaoHuiTableManager.Instance:GetBtnList(self.buDouKaiInfo.mBuDouKaiStage))
        ---阶段描述信息
        self:RefreshLabel(self:GetStageDescribe_UILabel(),self.buDouKaiTableInfo.state)
    end
end
--endregion

--region UI刷新
---控制显示
function UIBuDouKaiPanel_Base:RefreshActive(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---播放特效
function UIBuDouKaiPanel_Base:PlayEffect(obj)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(false)
        obj.gameObject:SetActive(true)
    end
end

---设置Sprite
function UIBuDouKaiPanel_Base:RefreshSprite(obj,spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj,"","UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---设置Label
function UIBuDouKaiPanel_Base:RefreshLabel(obj,text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj,"","UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj,true)
        end
    end
end

---刷新动画
function UIBuDouKaiPanel_Base:RefreshTween(obj,state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        local tween = obj
        if  CS.Utility_Lua.IsTypeEqual(obj:GetType(),typeof(CS.UITweener))== false then
            tween = self:GetCurComp(obj,"","UITweener")
        end
        if tween ~= nil then
            if state == self.TweenState.StopTween then
                tween:ResetToBeginning()
            elseif state == self.TweenState.PlayTween then
                tween:PlayTween()
            elseif state == self.TweenState.TweenForward then
                tween:PlayForward()
            elseif state == self.TweenState.TweenReverse then
                tween:PlayReverse()
            end
        end
    end
end

---设置颜色
function UIBuDouKaiPanel_Base:RefreshColor(obj,color)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.color = color
        else
            local curLabel = self:GetCurComp(obj,"","UILabel")
            if curLabel ~= nil then
                curLabel.color = color
            end
        end
    end
end

---绑定点击事件
function UIBuDouKaiPanel_Base:BindClickCallBack(obj,action)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        CS.UIEventListener.Get(obj.gameObject).onClick = action
    end
end

---移除update
function UIBuDouKaiPanel_Base:CloseUpdate()
    if self.listUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.listUpdateItem)
        self.listUpdateItem = nil
    end
end

---设置按钮显示状态
function UIBuDouKaiPanel_Base:SetBtnShow(btnList)
    self:RefreshActive(self:GetBetBtn_GameObject(),false)
    self:RefreshActive(self:GetRankBtn_GameObject(),false)
    if btnList == nil or btnList.Count == 0 or (btnList.Count > 0 and btnList[0] == LuaEnumBuDouKaiBtnType.NONE) then
    elseif btnList.Count == 1 then
        local curBtnType = btnList[0]
        if curBtnType == LuaEnumBuDouKaiBtnType.SHOWBETBUTTON then
            self:RefreshActive(self:GetBetBtn_GameObject(),true)
            self:RefreshTween(self:GetBetBtn_TweenPosition(),self.TweenState.TweenReverse)
        elseif curBtnType == LuaEnumBuDouKaiBtnType.SHOWRANKBUTTON then
            self:RefreshActive(self:GetRankBtn_GameObject(),true)
            self:RefreshTween(self:GetRankBtn_TweenPosition(),self.TweenState.TweenReverse)
        end
    elseif btnList.Count == 2 then
        self:RefreshActive(self:GetBetBtn_GameObject(),true)
        self:RefreshTween(self:GetBetBtn_TweenPosition(),self.TweenState.TweenForward)
        self:RefreshActive(self:GetRankBtn_GameObject(),true)
        self:RefreshTween(self:GetRankBtn_TweenPosition(),self.TweenState.TweenForward)
    end
end

---添加update
function UIBuDouKaiPanel_Base:AddUpdate()
    self:CloseUpdate()
    if self.listUpdateItem ~= nil then
        if self.listUpdateItem ~= nil and CS.CSListUpdateMgr.Instance ~= nil then
            CS.CSListUpdateMgr.Instance:Remove(self.listUpdateItem)
            self.listUpdateItem = nil
        end
    end
    self.listUpdateItem = CS.CSListUpdateMgr.Add(100, nil, function()
        self:RefreshTime()
    end,true)
end

---刷新时间
function UIBuDouKaiPanel_Base:RefreshTime()
    local remainTime = CS.CSScene.MainPlayerInfo.BudowillInfo:GetRemainSecondTime()
    ---中途未在倒计时开始的时候进入游戏，则不开启倒计时，默认10秒
    if (self.remainTenTime == nil or self.remainTenTime == false) and remainTime <= 10 and 10 - remainTime <= self.playCountDownReduceValue then
        self.remainTenTime = true
        self.needPlayCountDownEffect = true
        self:RefreshTenTime()
    end
    if (self.remainConfigTime == nil or self.remainConfigTime == false) and self.needPlayCountDownEffect == true and remainTime <= self.OpenStartCountDownTime then
        self.remainConfigTime = true
        self:RefreshConfigTime()
    end
end

--region 倒计时特效相关
---开启时间倒计时特效
function UIBuDouKaiPanel_Base:OpenStartCountDownTimeEffect()
    self:RefreshSprite(self:GetCountDownStage_UISprite(),CS.Cfg_GlobalTableManager.Instance:GetStageSpriteName(self.buDouKaiStage))
    self:RefreshTween(self:GetCountDownStage_TweenAlpha(),self.TweenState.PlayTween)
    self:PlayEffect(self:GetCountDownEffect_CSUIEffectLoad())
    self:RefreshActive(self:GetCountDownEffect_CSUIEffectLoad().EffectObject,true)
end

---开启时间倒计时特效背景
function UIBuDouKaiPanel_Base:OpenStartCountDownBackGround()
    CS.CSScene.MainPlayerInfo.BudowillInfo:ChangeBackGroundState(true)
end

---关闭倒计时特效
function UIBuDouKaiPanel_Base:CloseCountDown()
    CS.CSScene.MainPlayerInfo.BudowillInfo:ChangeBackGroundState(false)
    self:RefreshActive(self:GetCountDownEffect_CSUIEffectLoad(),false)
end
--endregion

---最后剩余时间在10秒内触发（触发一次）
function UIBuDouKaiPanel_Base:RefreshTenTime()

end

---最后剩余时间在配置的时间内（触发一次）
function UIBuDouKaiPanel_Base:RefreshConfigTime()

end
--endregion

--region 获取
---获取剩余时间显示文本
function UIBuDouKaiPanel_Base:GetRemainTimeText()
    return CS.CSScene.MainPlayerInfo.BudowillInfo:GetRemainTime()
end
--endregion

function UIBuDouKaiPanel_Base:OnDestroy()
    self:CloseUpdate()
end
return UIBuDouKaiPanel_Base