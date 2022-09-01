---@class UIguessPanel:UIBase 猜拳界面
local UIguessPanel = {}

--region 局部变量
--我方信息
UIguessPanel.OurInfo = {}
--敌方信息
UIguessPanel.EnemyInfo = {}
--倒计时协程
UIguessPanel.IEnumRefreshTime = nil
--自己是否下注
UIguessPanel.isOurBet = false
-- 敌方是否下注
UIguessPanel.isEnemyBet = false
--每次最少下注
UIguessPanel.needBetCount = 1
UIguessPanel.guessItemID = 8130002
--是否需要等待
UIguessPanel.needWait = false
UIguessPanel.GuessFistType = luaEnumGuessFistType.None

UIguessPanel.storeItemid = 3017001

UIguessPanel.dealerId = 0

UIguessPanel.conditionLevel = 80
--endregion

--region 初始化

function UIguessPanel:Init()
    --UIguessPanel:AddCollider()
    self:InitComponents()
    UIguessPanel.BindUIEvents()
    UIguessPanel.BindNetMessage()
    UIguessPanel.InitData()
    UIguessPanel.InitUI()

end

function UIguessPanel:Show(id)
    UIguessPanel.dealerId = id
end

--- 初始化组件
function UIguessPanel:InitComponents()

    --region Ourside 我方阵营
    ---@type Top_UISprite 头像
    UIguessPanel.meheadIcon = self:GetCurComp("WidgetRoot/guess/view/our/ourheadIcon", "Top_UISprite")
    ---@type Top_UILabel 名字
    UIguessPanel.mename = self:GetCurComp("WidgetRoot/guess/view/our/ourname", "Top_UILabel")
    ---@type Top_UILabel 排行
    UIguessPanel.ourrank = self:GetCurComp("WidgetRoot/guess/view/our/ourrank", "Top_UILabel")
    ---@type UnityEngine.GameObject  我方押宝
    UIguessPanel.OriginEquip = self:GetCurComp("WidgetRoot/guess/view/our/OriginEquip", "GameObject")
    ---@type Top_UISprite  我方押宝
    UIguessPanel.icon = self:GetCurComp("WidgetRoot/guess/view/our/OriginEquip/icon", "Top_UISprite")
    ---@type Top_UISprite  未押宝显示
    UIguessPanel.NeedAddicon = self:GetCurComp("WidgetRoot/guess/view/our/OriginEquip/NeedAddicon", "Top_UISprite")
    ---@type UnityEngine.GameObject  撤回押宝
    UIguessPanel.del = self:GetCurComp("WidgetRoot/guess/view/our/OriginEquip/del", "GameObject")
    ---@type UnityEngine.GameObject  已出拳提醒
    UIguessPanel.ourStart = self:GetCurComp("WidgetRoot/guess/view/our/start", "GameObject")
    --endregion

    --region Enemy 敌方阵营
    ---@type Top_UISprite 头像
    UIguessPanel.youheadIcon = self:GetCurComp("WidgetRoot/guess/view/enemy/enemyheadIcon", "Top_UISprite")
    ---@type Top_UILabel  名称
    UIguessPanel.youname = self:GetCurComp("WidgetRoot/guess/view/enemy/enemyname", "Top_UILabel")
    ---@type Top_UILabel  排行
    UIguessPanel.enemyrank = self:GetCurComp("WidgetRoot/guess/view/enemy/enemyrank", "Top_UILabel")
    ---@type UnityEngine.GameObject 敌方押宝
    UIguessPanel.AimEquip = self:GetCurComp("WidgetRoot/guess/view/enemy/AimEquip", "GameObject")
    ---@type Top_UISprite 敌方押宝
    UIguessPanel.enemyIcon = self:GetCurComp("WidgetRoot/guess/view/enemy/AimEquip/icon", "Top_UISprite")
    ---@type Top_UISprite  未押宝显示
    UIguessPanel.NeedIcon = self:GetCurComp("WidgetRoot/guess/view/enemy/AimEquip/NeedIcon", "Top_UISprite")
    ---@type UnityEngine.GameObject 已出拳提醒
    UIguessPanel.enemyStart = self:GetCurComp("WidgetRoot/guess/view/enemy/start", "GameObject")
    --endregion

    ---@type Top_UISprite  石头
    UIguessPanel.stone = self:GetCurComp("WidgetRoot/guess/events/stone", "Top_UISprite")
    ---@type Top_UISprite  剪刀
    UIguessPanel.scissors = self:GetCurComp("WidgetRoot/guess/events/scissors", "Top_UISprite")
    ---@type Top_UISprite  布
    UIguessPanel.fabric = self:GetCurComp("WidgetRoot/guess/events/fabric", "Top_UISprite")
    ---@type Top_UISprite 等待tips 敌方押宝
    UIguessPanel.WaitTips = self:GetCurComp("WidgetRoot/guess/view/WaitTips", "Top_UISprite")

    ---@type UnityEngine.GameObject 帮助按钮
    UIguessPanel.btn_help = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIguessPanel.btn_close = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    ---@type UnityEngine.GameObject 猜拳按钮
    UIguessPanel.btn_chu = self:GetCurComp("WidgetRoot/guess/events/btn_chu", "GameObject")

    ---@type Top_UILabel 猜拳奖励
    UIguessPanel.lb01 = self:GetCurComp("WidgetRoot/guess/view/Current/lb01", "Top_UILabel")
    ---@type Top_UILabel 猜拳筹码
    UIguessPanel.lb11 = self:GetCurComp("WidgetRoot/guess/view/Current/lb11", "Top_UILabel")
    ---@type Top_UILabel 倒计时
    UIguessPanel.time = self:GetCurComp("WidgetRoot/guess/view/time", "Top_UILabel")

    ---@type UnityEngine.GameObject 获胜奖励
    UIguessPanel.rewardLb = self:GetCurComp("WidgetRoot/guess/view/lb", "GameObject")

end

function UIguessPanel.BindUIEvents()
    --点击石头事件
    CS.UIEventListener.Get(UIguessPanel.stone.gameObject).onClick = function()
        UIguessPanel.GuessFistType = luaEnumGuessFistType.Stone
        UIguessPanel.SetGuessFiteBtns()
    end
    --点击剪刀事件
    CS.UIEventListener.Get(UIguessPanel.scissors.gameObject).onClick = function()
        UIguessPanel.GuessFistType = luaEnumGuessFistType.Scissors
        UIguessPanel.SetGuessFiteBtns()
    end
    --点击布事件
    CS.UIEventListener.Get(UIguessPanel.fabric.gameObject).onClick = function()
        UIguessPanel.GuessFistType = luaEnumGuessFistType.Fabric
        UIguessPanel.SetGuessFiteBtns()
    end
    --点击我方押宝事件
    CS.UIEventListener.Get(UIguessPanel.NeedAddicon.gameObject).onClick = UIguessPanel.OnClickNeedAddicon
    --点击帮助按钮事件
    CS.UIEventListener.Get(UIguessPanel.btn_help).onClick = UIguessPanel.OnClickbtn_help
    --点击关闭按钮事件
    CS.UIEventListener.Get(UIguessPanel.btn_close).onClick = UIguessPanel.OnClickbtn_close
    --点击猜拳按钮事件
    CS.UIEventListener.Get(UIguessPanel.btn_chu).onClick = UIguessPanel.OnClickbtn_chu
    --点击撤回押宝事件
    CS.UIEventListener.Get(UIguessPanel.del).onClick = UIguessPanel.OnClickdel
end

function UIguessPanel.BindNetMessage()
    UIguessPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFingerRewardInfoMessage, UIguessPanel.onResFingerRewardInfoMessageCallback)
    UIguessPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAllChosedMessage, UIguessPanel.onResAllChosedMessageCallback)
    UIguessPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResChoseFingerMessage, UIguessPanel.onResChoseFingerMessageCallback)

    UIguessPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIguessPanel.CallUpdateBagItemChange);

end

function UIguessPanel.InitData()
    if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo then
        UIguessPanel.OurInfo.playerInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo.OurFistInfo
        UIguessPanel.EnemyInfo.playerInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo.EnemyFistInfo

        UIguessPanel.OurInfo.GuessType = CS.CSScene.MainPlayerInfo.GuessFistInfo.ourGuessType
    end
    UIguessPanel.conditionLevel = CS.Cfg_GlobalTableManager.Instance.fistConditionLevel
    --随机猜拳
    local num = CS.Utility_Lua.UnityEngineRandom_Int32(1, 10)
    UIguessPanel.GuessFistType = num > 6 and luaEnumGuessFistType.Stone or num > 3 and luaEnumGuessFistType.Scissors or luaEnumGuessFistType.Fabric
end
--endregion

--region 函数监听

--点击我方押宝函数
---@param go UnityEngine.GameObject
function UIguessPanel.OnClickNeedAddicon(go)
    if UIguessPanel.CheckNeedNotBuy() then
        networkRequest.ReqUseChip(UIguessPanel.needBetCount)
    else
        UIguessPanel.ShowShopTips()
    end
    --UIguessPanel.RefreshOurBit()
end

--点击帮助按钮函数
---@param go UnityEngine.GameObject
function UIguessPanel.OnClickbtn_help(go)
    local isFind, itemInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(44)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, itemInfo)
    end
end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIguessPanel.OnClickbtn_close(go)
    --请求终止划拳
    uimanager:ClosePanel('UIguessPanel')
end

--点击猜拳函数
---@param go UnityEngine.GameObject
function UIguessPanel.OnClickbtn_chu(go)

    if UIguessPanel.OurInfo == nil then
        return
    end
    if UIguessPanel.GuessFistType == luaEnumGuessFistType.None then
        CS.Utility.ShowTips('请选择猜拳类型', 1.5, CS.ColorType.Red)
        return
    end
    --发送请求猜拳
    UIguessPanel.needWait = true
    UIguessPanel.RefreshWaitTips()
    UIguessPanel.SetGuessFiteBtnsStatu()
    networkRequest.ReqChoseFinger(UIguessPanel.GuessFistType)
end

--点击撤回押宝函数
---@param go UnityEngine.GameObject
function UIguessPanel.OnClickdel(go)
    networkRequest.ReqUseChip(0)
    -- UIguessPanel.RefreshOurBit()
end

--endregion


--region 网络消息处理

--筹码改变
function UIguessPanel.onResFingerRewardInfoMessageCallback(id, data)
    UIguessPanel.OurInfo.RewardInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo.OurRewardInfo
    UIguessPanel.EnemyInfo.RewardInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo.EnemyRewardInfo
    UIguessPanel.isOurBet = UIguessPanel.OurInfo.RewardInfo.chip >= UIguessPanel.needBetCount
    UIguessPanel.isEnemyBet = UIguessPanel.EnemyInfo.RewardInfo.chip >= UIguessPanel.needBetCount
    UIguessPanel.RefreshOurBit()
    UIguessPanel.RefreshEnemyBit()
    UIguessPanel.RrfreshRewarInfo()
end

--双方已经出拳
function UIguessPanel.onResAllChosedMessageCallback(id, data)
    if data then
        if data.dealerId == nil or data.playerId == nil then
            networkRequest.ReqFingerResult()
        end
        uimanager:ClosePanel('UIguessPanel')
    end
end

--对方出拳
function UIguessPanel.onResChoseFingerMessageCallback(id, data)
    UIguessPanel.enemyStart:SetActive(true)
end


--背包筹码改变
function UIguessPanel.CallUpdateBagItemChange(id, data)
    if UIguessPanel.CheckNeedNotBuy() then
        networkRequest.ReqUseChip(UIguessPanel.needBetCount)
        -- UIguessPanel.RefreshOurBit()
    end
end

--endregion

--region UI

function UIguessPanel.InitUI()
    UIguessPanel.InitGuessIcon()
    UIguessPanel.InitOurInfo()
    UIguessPanel.InitEnemyInfo()
    UIguessPanel.SetGuessFiteBtns()
    UIguessPanel.RefreshWaitTips()
    UIguessPanel.RrfreshRewarInfo()
    if UIguessPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIguessPanel.IEnumRefreshTime)
    end
    UIguessPanel.IEnumRefreshTime = StartCoroutine(UIguessPanel.IEnumTimeCount, 60)
end

function UIguessPanel.InitGuessIcon()
    local isFind, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(8130002)
    if isFind then
        UIguessPanel.icon.spriteName = info.icon
        UIguessPanel.enemyIcon.spriteName = info.icon
    end

end

--我方UI信息
function UIguessPanel.InitOurInfo()
    if UIguessPanel.OurInfo == nil then
        return
    end
    if UIguessPanel.OurInfo.playerInfo == nil then
        return
    end
    local sex = tostring(UIguessPanel.OurInfo.playerInfo.sex)
    local career = tostring(UIguessPanel.OurInfo.playerInfo.career)
    --头像
    UIguessPanel.meheadIcon.spriteName = "headicon" .. sex .. career
    --名称
    UIguessPanel.mename.text = UIguessPanel.OurInfo.playerInfo.name
    --排行
    UIguessPanel.ourrank.text = UIguessPanel.OurInfo.playerInfo.rank == 0 and "" or "拳榜第" .. UIguessPanel.OurInfo.playerInfo.rank
    --筹码
    UIguessPanel.RefreshOurBit()
end

--敌方UI信息
function UIguessPanel.InitEnemyInfo()
    if UIguessPanel.EnemyInfo == nil then
        return
    end
    if UIguessPanel.EnemyInfo.playerInfo == nil then
        return
    end
    local sex = tostring(UIguessPanel.EnemyInfo.playerInfo.sex)
    local career = tostring(UIguessPanel.EnemyInfo.playerInfo.career)
    --头像
    UIguessPanel.youheadIcon.spriteName = "headicon" .. sex .. career
    --名称
    UIguessPanel.youname.text = UIguessPanel.EnemyInfo.playerInfo.name
    --排行
    UIguessPanel.enemyrank.text = UIguessPanel.EnemyInfo.playerInfo.rank == 0 and "" or "拳榜第" .. UIguessPanel.EnemyInfo.playerInfo.rank
    --筹码
    UIguessPanel.RefreshEnemyBit()
end

--刷新我方筹码
function UIguessPanel.RefreshOurBit()
    if UIguessPanel.OriginEquip == nil then
        return
    end
    UIguessPanel.OriginEquip:SetActive(UIguessPanel.OurInfo.playerInfo.level >= UIguessPanel.conditionLevel)
    UIguessPanel.NeedAddicon.gameObject:SetActive(not UIguessPanel.isOurBet)
    UIguessPanel.icon.color = UIguessPanel.isOurBet and LuaEnumUnityColorType.White or LuaEnumUnityColorType.DarkGray
    UIguessPanel.del.gameObject:SetActive(UIguessPanel.isOurBet)
end

--刷新敌方筹码
function UIguessPanel.RefreshEnemyBit()
    if UIguessPanel.AimEquip == nil then
        return
    end
    UIguessPanel.AimEquip:SetActive(UIguessPanel.EnemyInfo.playerInfo.level >= UIguessPanel.conditionLevel)
    UIguessPanel.enemyIcon.color = UIguessPanel.isEnemyBet and LuaEnumUnityColorType.White or LuaEnumUnityColorType.DarkGray
end

--刷新等待
function UIguessPanel.RefreshWaitTips()
    UIguessPanel.WaitTips.gameObject:SetActive(UIguessPanel.needWait)
    UIguessPanel.btn_chu.gameObject:SetActive(not UIguessPanel.needWait)
    UIguessPanel.time.gameObject:SetActive(not UIguessPanel.needWait)
    UIguessPanel.ourStart:SetActive(UIguessPanel.needWait)
end

--更新奖励信息
function UIguessPanel.RrfreshRewarInfo()
    local chip = 0
    local score = 1
    if UIguessPanel.OurInfo ~= nil then
        if UIguessPanel.OurInfo.RewardInfo ~= nil then
            chip = UIguessPanel.OurInfo.RewardInfo.winChip
            score = UIguessPanel.OurInfo.RewardInfo.winScore
        end
    end

    UIguessPanel.lb01.text = '筹码 +' .. chip
    UIguessPanel.lb11.text = '积分 +' .. score
    UIguessPanel.lb01.gameObject:SetActive(chip ~= 0)
end

--设置出拳类型按钮
function UIguessPanel.SetGuessFiteBtns()
    local meetStone = UIguessPanel.GuessFistType == luaEnumGuessFistType.Stone
    local meetScissors = UIguessPanel.GuessFistType == luaEnumGuessFistType.Scissors
    local meetFabric = UIguessPanel.GuessFistType == luaEnumGuessFistType.Fabric
    UIguessPanel.stone.spriteName = meetStone and 'stone2' or 'stone1'
    UIguessPanel.scissors.spriteName = meetScissors and 'scissors2' or 'scissors1'
    UIguessPanel.fabric.spriteName = meetFabric and 'fabric2' or 'fabric1'

end

---显示进入商店tips
-----@private
function UIguessPanel.ShowShopTips()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.StoreInfoV2 == nil then
        return
    end
    local isFind, info = CS.Cfg_StoreTableManager.Instance.dic:TryGetValue(UIguessPanel.storeItemid)
    if isFind then
        CS.CSScene.MainPlayerInfo.StoreInfoV2:TryGetStoreInfo(info, function()
            local storeInfo = CS.CSScene.MainPlayerInfo.StoreInfoV2:GetStoreInfo(UIguessPanel.storeItemid)
            if storeInfo and storeInfo.itemTable then
                uimanager:CreatePanel("UIDisposeItemPanel", nil, storeInfo);
            end
        end)
    end
end

---设置猜拳按钮状态
---@private
function UIguessPanel.SetGuessFiteBtnsStatu()
    local meetStone = UIguessPanel.GuessFistType == luaEnumGuessFistType.Stone
    local meetScissors = UIguessPanel.GuessFistType == luaEnumGuessFistType.Scissors
    local meetFabric = UIguessPanel.GuessFistType == luaEnumGuessFistType.Fabric
    UIguessPanel.stone.gameObject:SetActive(meetStone)
    UIguessPanel.scissors.gameObject:SetActive(meetScissors)
    UIguessPanel.fabric.gameObject:SetActive(meetFabric)
end

--endregion

--region otherFunction

function UIguessPanel.CheckNeedNotBuy()
    --查看背包个数
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(UIguessPanel.guessItemID)
    if count >= UIguessPanel.needBetCount then
        return true
    end
    return false
end

--endregion

--region 倒计时协程
---@param time number 单位秒
function UIguessPanel.IEnumTimeCount(time)
    local meetTime = true
    local totalTime = time
    --local color = luaEnumColorType.White
    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            UIguessPanel.time.text = color .. '0'
            coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
            UIguessPanel.time.gameObject:SetActive(false)
            --发送终止
            StopCoroutine(UIguessPanel.IEnumRefreshTime)
            UIguessPanel.IEnumRefreshTime = nil
            uimanager:ClosePanel('UIDisposeItemPanel')
        elseif totalTime <= 10 then
            -- color = luaEnumColorType.Red
        end

        if UIguessPanel.time ~= nil then
            UIguessPanel.time.text = string.format("%02.0f", totalTime)
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1

    end
end
--endregion

--region ondestroy

function UIguessPanel.onDestroy()
    uimanager:ClosePanel("UIDisposeItemPanel")
    networkRequest.ReqTerminateFinger()
    if UIguessPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIguessPanel.IEnumRefreshTime)
        UIguessPanel.IEnumRefreshTime = nil
    end
    UIguessPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_BagItemChanged, UIguessPanel.CallUpdateBagItemChange)
end

function ondestroy()
    UIguessPanel.onDestroy()
end

--endregion

return UIguessPanel