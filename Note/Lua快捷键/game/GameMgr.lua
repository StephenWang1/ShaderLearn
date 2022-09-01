---游戏管理器
---@class GameMgr
local GameMgr = {}

local luaclass = luaclass
local csTime = CS.UnityEngine.Time

--region 数据组件
---游戏数据管理
---@return GameDataManager
function GameMgr:GetGameDataManager()
    if self.mGameDataManager == nil then
        self.mGameDataManager = require "luaRes.game.data.GameDataManager"
        self.mGameDataManager.__index = self.mGameDataManager
    end
    return self.mGameDataManager
end

---获取场景class加载器
---@return SceneClassLoader
function GameMgr:GetSceneClassLoader()
    if self.mSceneClassLoader == nil then
        self.mSceneClassLoader = require "luaRes.game.assist.SceneClassLoader"
    end
    return self.mSceneClassLoader
end
--endregion

---获取排行榜class加载器
---@return LuaRankClassLoader
function GameMgr:GetRankClassLoader()
    if self.mRankClassLoader == nil then
        self.mRankClassLoader = require "luaRes.luaclass.RankClass.LuaRankClassLoader"
    end
    return self.mRankClassLoader
end
--endregion

---获取推送class加载器
---@return LuaItemHintClassLoader
function GameMgr:GetItemHintClassLoader()
    if self.mItemHintClassLoader == nil then
        self.mItemHintClassLoader = require "luaRes.game.data.betterItemHint.Base.LuaItemHintClassLoader"
    end
    return self.mItemHintClassLoader
end
--endregion

---获取坐骑class加载器
---@return LuaHorseClassLoader
function GameMgr:GetHorseClassLoader()
    if self.mHorseClassLoader == nil then
        self.mHorseClassLoader = require "luaRes.game.data.Horse.LuaHorseClassLoader"
    end
    return self.mHorseClassLoader
end
--endregion

--region 辅助组件
---游戏事件监听
---@return GameEventMonitor
function GameMgr:GetGameEventMonitor()
    if self.mGameEventMonitor == nil then
        self.mGameEventMonitor = require "luaRes.game.assist.GameEventMonitor"
        self.mGameEventMonitor.__index = self.mGameEventMonitor
    end
    return self.mGameEventMonitor
end

---获取面板的客户端消息Handler
---@return EventHandlerManager
function GameMgr:GetClientEventHandler()
    if self == nil then
        return
    end
    if self.mClient == nil then
        self.mClient = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)--客户端事件
    end
    return self.mClient
end
--endregion

--region 场景组件
---主场景
---@return LuaMainScene
function GameMgr:GetMainScene()
    return self.mMainScene
end
--endregion

--region 时间管理器
---时间管理器
---@return LuaTimeMgr
function GameMgr:GetLuaTimeMgr()
    if (self.mLuaTimeMgr == nil) then
        self.mLuaTimeMgr = luaclass.LuaTimeMgr:New()
    end
    return self.mLuaTimeMgr
end
--endregion

---@return LuaActivityMgr
function GameMgr:GetLuaActivityMgr()
    if (self.mLuaActivityMgr == nil) then
        self.mLuaActivityMgr = luaclass.LuaActivityMgr:New()
    end
    return self.mLuaActivityMgr
end

--region 主角数据
---@return LuaMainPlayer
function GameMgr:GetLuaMainPlayer()
    return self.mLuaMainPlayer
end

---初始化主角信息管理类,生命周期与CSMainPlayerInfo一致
---@private
function GameMgr:InitializePlayerDataMgr()
    if self.mPlayerDataMgr == nil then
        self.mPlayerDataMgr = luaclass.LuaPlayerDataManager:New()
    end
    if self.mOtherPlayerDataMgr == nil then
        self.mOtherPlayerDataMgr = luaclass.LuaOtherPlayerDataManager:New()
    end
end

---获取主角数据管理器
---@return PlayerDataManager
function GameMgr:GetPlayerDataMgr()
    return self.mPlayerDataMgr
end

---获取其他玩家的数据管理器
---@return OtherPlayerDataManager
function GameMgr:GetOtherPlayerDataMgr()
    return self.mOtherPlayerDataMgr
end
--endregion

---@return LuaRedPointManager
function GameMgr:GetLuaRedPointManager()
    if (self.mLuaRedPointManager == nil) then
        self.mLuaRedPointManager = require "luaRes.game.data.LuaRedPointManager"
    end
    return self.mLuaRedPointManager;
end

---@return LuaMissionManager
function GameMgr:GetLuaMissionManager()
    if (self.mLuaMissionManager == nil) then
        self.mLuaMissionManager = require "luaRes.game.data.LuaMissionManager"
    end
    return self.mLuaMissionManager;
end

---@return PlatformMgr
function GameMgr:GetPlatformMgr()
    if self.mPlatformMgr == nil then
        self.mPlatformMgr = luaclass.PlatformMgr:New()
    end
    return self.mPlatformMgr
end

---@return LuaShortcutKeyMgr
function GameMgr:GetShortcutMgr()
    if self.mShortcutMgr == nil then
        print(self.mShortcutMgr)
        self.mShortcutMgr = luaclass.LuaShortcutKeyMgr:New()
    end
    return self.mShortcutMgr
end

--region 初始化
---初始化
---@private
function GameMgr:Initialize()
    ---游戏时间监听初始化
    self:GetGameEventMonitor():Initialize()
    ---游戏数据初始化
    self:GetGameDataManager():Initialize()
    ---红点管理器初始化
    self:GetLuaRedPointManager():Initialize();
    ---任务管理初始化
    self:GetLuaMissionManager():Initialize();
    ---lua场景事件绑定
    self:BindSceneEvent()
    ---Lua消息绑定
    self:BindMessage()
    ---Update事件绑定
    self:BindUpdate()
end

---在CSGame中绑定Update回调
---@private
function GameMgr:BindUpdate()
    if CS.Top_CSGame.Sington ~= nil then
        CS.Top_CSGame.Sington.luaGameMgrUpdate = function()
            self:Update()
        end
    end
end

---消息监听
---@private
function GameMgr:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerInfoInit, function()
        self:InitializePlayerDataMgr()
    end)
end

---场景初始化事件和销毁事件绑定
---@private
function GameMgr:BindSceneEvent()
    CS.CSSceneExt.onSceneInitializedEvent = function(scene)
        self:OnSceneInitialized(scene)
    end
    CS.CSSceneExt.onSceneDestroyEvent = function(scene)
        self:OnSceneDestroyed(scene)
    end

    CS.CSAvatarLuaEvent.onSceneUnitDeadAnalyEvent = function(CSAvatar)
        return self:onSceneUnitDeadAnalyEvent(CSAvatar)
    end

    ---Avatar初始化事件
    CS.CSAvatarLuaEvent.OnAvatarInit = function(avatar, data, paramData)
        if self:GetMainScene() == nil then
            return true
        end
        self:GetMainScene():OnSceneUnitEnter(avatar, data, paramData)
        return true
    end
    ---CSAvatar初始化事件
    CS.CSAvatarLuaEvent.OnAvatarInfoInit = function(csAvatarInfo, data)
        if self:GetMainScene() == nil then
            return true
        end
        self:GetMainScene():OnAvatarInfoInit(csAvatarInfo, data)
        return true
    end
    ---CSHead初始化事件
    CS.CSAvatarLuaEvent.OnAvatarHeadInit = function(csHead)
        if self:GetMainScene() == nil then
            return true
        end
        self:GetMainScene():OnAvatarHeadInit(csHead)
        return true
    end
    ---CSModelBase初始化事件
    CS.CSAvatarLuaEvent.OnAvatarModelInit = function(csAvatar)
        if self:GetMainScene() == nil then
            return true
        end
        self:GetMainScene():OnAvatarModelInit(csAvatar)
        return true
    end

    ---场景单位模型组件初始化事件
    CS.CSAvatarLuaEvent.OnAvatarModelStructInitEvent = function(csAvatar)
        return self:OnAvatarModelStructInitEvent(csAvatar)
    end

    ---场景单位换装事件
    CS.CSAvatarLuaEvent.OnAvatarModelAnalysisEvent = function(csAvatar)
        local luaAvatar = self:GetLuaAvatar(csAvatar)
        if (luaAvatar ~= nil and luaAvatar.LuaAvatarModel ~= nil) then
            return luaAvatar.LuaAvatarModel:OnAvatarModelAnalysisEvent()
        end
        return true
    end

    CS.CSAvatarLuaEvent.onSceneUnitDestroyedEvent = function(id, type)
        self:OnSceneUnitDestroyed(id, type)
    end
end

--endregion

--region 场景事件
---场景初始化事件
---@param scene CSSceneExt
function GameMgr:OnSceneInitialized(scene)
    if self.mMainScene ~= nil then
        self.mMainScene:OnDestroy()
        self.mMainScene = nil
    end
    ---初始化lua场景
    ---@type LuaMainScene
    self.mMainScene = luaclass.LuaMainScene:New(scene)
    if self.mLuaMainPlayer ~= nil then
        self.mMainScene.mLuaMainPlayer = self.mLuaMainPlayer
    end
end

---获取LuaAvatar工厂,不过不负责MainPlayer和None类型
---@return LuaAvatarFactory
function GameMgr:GetLuaAvatarFactory()
    if self.mLuaAvatarFactory == nil then
        self.mLuaAvatarFactory = luaclass.LuaAvatarFactory:New()
    end
    return self.mLuaAvatarFactory
end

---场景销毁事件
---@param scene CSSceneExt
function GameMgr:OnSceneDestroyed(scene)
    if self.mMainScene ~= nil and self.mMainScene:GetCSScene() == scene then
        self.mMainScene:OnDestroy()
        self.mMainScene = nil
    end
end

---场景单位创建事件
---@param id number
---@param type number
---@param avatar CSAvater|CSItem
function GameMgr:OnSceneUnitCreated(id, type, avatar)
    self:GetMainScene():OnSceneUnitCreated(id, type, avatar)
end

---@return LuaAvatar
function GameMgr:GetLuaAvatar(csAvatar)
    if (csAvatar == nil) then
        return nil
    end
    return csAvatar.LuaAvatar
end

---场景单位销毁事件
---@param id number
---@param type number
function GameMgr:OnSceneUnitDestroyed(id, type)
    if (self:GetMainScene() ~= nil) then
        self:GetMainScene():OnSceneUnitDestroyed(id, type)
    end
end

---场景单位初始化头顶事件
---@param avatar CSAvater
function GameMgr:onSceneUnitInitHeadEvent(avatar)
    if avatar == nil or self.mMainScene == nil then
        return
    end
    local luaAvatar = self.mMainScene:GetLuaAvatar(avatar)
    if luaAvatar then
        luaAvatar:BindLuaHead()
    end
end

---场景单位模型组件初始化事件
---@param avatar CSAvater
---@return boolean 是否继续C#模型初始
function GameMgr:OnAvatarModelStructInitEvent(avatar)
    if avatar == nil or avatar.LuaAvatar == nil or avatar.LuaAvatar.LuaAvatarModel == nil then
        return true
    end
    return avatar.LuaAvatar.LuaAvatarModel:OnAvatarStructInitEvent()
end

---场景单位死亡事件
---@param avatar CSAvater
function GameMgr:onSceneUnitDeadAnalyEvent(avatar)
    if avatar == nil then
        return
    end

    if avatar.AvatarType == CS.EAvatarType.Monster then
        self:onSceneMonsterDeadAnalyEvent(avatar)
    end
end

---monster死亡事件
---@param avatar CSAvater
function GameMgr:onSceneMonsterDeadAnalyEvent(avatar)
    if self:GetMainScene() == nil then
        return
    end
    local monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(avatar.MonsterTable.id)
    if monsterTable ~= nil and monsterTable:GetHalo() ~= nil then
        if avatar.Model ~= nil and avatar.Model.EffectPlayer ~= nil then
            --移除脚下光圈
            avatar.Model.EffectPlayer:RemoveModelEffect(monsterTable:GetHalo())
        end
    end
    local luaAvatar = gameMgr:GetMainScene():GetLuaAvatarByID(avatar.ID)
    if luaAvatar ~= nil and luaAvatar:GetLuaAvatarHead() ~= nil then
        luaAvatar:GetLuaAvatarHead():AvatarDeadCallBack()
    end
end

---由登录场景进入游戏场景事件,在Scene_EnterSceneAfter客户端事件中执行
---@private
function GameMgr:OnEnterGameScene()
    if self.mIsInGameScene then
        return
    end
    self.mIsInGameScene = true
    self:GetGameDataManager():OnEnterGameScene()

    if self.mLuaMainPlayer == nil and CS.CSScene.Sington.MainPlayer ~= nil then
        self.mLuaMainPlayer = luaclass.LuaMainPlayer:New(CS.CSScene.Sington.MainPlayer)
        if self:GetMainScene() ~= nil then
            self:GetMainScene().mLuaMainPlayer = self.mLuaMainPlayer
        end
    end
    uiStaticParameter.MagicBossRedPointLock = true
    luaclass.MonthCardInfo:TryTipRenewMonthCard()
    ---请求跨服信息
    networkRequest.ReqCommon(luaEnumReqServerCommonType.ShareBasicInfo)
    --luaclass.KuaFuStartHint:StartLianFuCountDown(CS.CSScene.MainPlayerInfo.serverTime + 660000)
    luaclass.BagBetterMagicEquip:RefreshBagBetterMagicEquip()
    clientTableManager.cfg_mapManager:RefreshOpenKuaFuMapTable()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():RefreShRedData()
    gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():CallAllRed()
    self:GetPlayerDataMgr():GetMainPlayerBetterItemHintDataMgr():TryHintAllItem(LuaEnumBetterItemHintReason.GameStart)
    Utility.EnterGameRegisterCombatHitListener()
    ---红点管理器初始化
    self:GetLuaRedPointManager():EnterGameInitialize();
    ---红点管理器刷新红点
    self:GetLuaRedPointManager():EnterGameCallRedPoint();
end

---由游戏场景退回到登录/选角界面事件
---@private
function GameMgr:OnExitGameScene()
    Utility.mLastPushGiftTime = 0
    self.mIsInGameScene = false

    if (self:GetPlayerDataMgr() ~= nil and self:GetPlayerDataMgr():GetMainPlayerEquipMgr() ~= nil) then
        self:GetPlayerDataMgr():GetMainPlayerEquipMgr():ResetParams()
    end

    if self:GetPlayerDataMgr() ~= nil and self:GetPlayerDataMgr():GetSynthesisMgr() ~= nil and self:GetPlayerDataMgr():GetSynthesisMgr():DelayRefresh() ~= nil then
        self:GetPlayerDataMgr():GetSynthesisMgr():DelayRefresh():OnDestroy()
    end

    self:GetGameDataManager():OnExitGameScene()
    ---销毁主角
    if self:GetLuaMainPlayer() ~= nil then
        self:GetLuaMainPlayer():Destroy()
        self.mLuaMainPlayer = nil
    end
    ---清空主角数据
    if self:GetPlayerDataMgr() ~= nil then
        self:GetPlayerDataMgr():Destroy()
        self.mPlayerDataMgr = nil
    end
    ---调用luaclass的数据清理方法
    if classCtrl.OnExitDestroy ~= nil then
        classCtrl:OnExitDestroy()
    end
    --if (self:GetLuaRedPointManager() ~= nil) then
    --    self:GetLuaRedPointManager():OnDestroy();
    --    self.mLuaRedPointManager = nil;
    --end
    Utility.ExitGameRemoveCombatHitListener()
    self:ResetLoginSigns()
end
--endregion

function GameMgr:BindChangeAccountAutoEvent()
    CS.SDKManager.GameInterface.OnAndroidLoginSuc = GameMgr.LoginSuccess
end

function GameMgr:LoginSuccess(data)
    uiStaticParameter.LoginData = data
end

--region 帧Update
---Update更新,在CSGame中调用
---@private
function GameMgr:Update()
    if self:GetLuaTimeMgr() ~= nil then
        self:GetLuaTimeMgr():Update()
    end
    if self:GetMainScene() ~= nil then
        self:GetMainScene():Update()
    end
    if self:GetPlayerDataMgr() ~= nil then
        self:GetPlayerDataMgr():Update()
    end
    if self:GetLuaMainPlayer() ~= nil then
        self:GetLuaMainPlayer():Update()
    end
    if luaEventManager ~= nil then
        luaEventManager.OnUpdate()
    end
    if self:SFTPOperation() ~= nil then
        self:SFTPOperation():Update()
    end
    if(self:GetShortcutMgr() ~= nil) then
        self:GetShortcutMgr().Update()
    end
    self:UpdateLuaGC()
end
--endregion

--region 定时执行LuaGC
---触发一次Lua的GC
---@public
function GameMgr:TriggleLuaGC()
    ---默认主动触发luagc的延迟时间间隔
    local defaultTriggleLuaGCDelayTimeInterval = 0.5
    local currentTime = csTime.time
    self.mNextGCTime = currentTime + defaultTriggleLuaGCDelayTimeInterval
end

---更新Lua的GC
---@private
function GameMgr:UpdateLuaGC()
    local currentTime = csTime.time
    ---默认luagc的时间间隔(s)
    local defaultLuaGCTimeIntervalSecond = 60
    if self.mNextGCTime == nil or self.mNextGCTime < currentTime then
        ---设置默认的下一次gc时间
        self.mNextGCTime = currentTime + defaultLuaGCTimeIntervalSecond
        ---执行gc
        --local forwardMemory = collectgarbage("count")
        collectgarbage("collect")
        --local afterMemory = collectgarbage("count")
        --print("lua gc", self.mNextGCTime, currentTime, "memory:", (forwardMemory - afterMemory) * 1024, 'B')
    end
end
--endregion

--region 登录地图
---设置服务器准备完毕
---@public
function GameMgr:SetServerPrepareFinished()
    --print("SetServerPrepareFinished")
    self.mServerPrepareFinished = true
    self:TryRequestLoginMap()
end

---设置客户端登录结束
---@public
function GameMgr:SetClientPrepareFinished()
    --print("SetClientPrepareFinished")
    self.mClientPrepareFinished = true
    self:TryRequestLoginMap()
end

---重置登录标志
---@public
function GameMgr:ResetLoginSigns()
    self.mIsSendedThisLogin = false
    self.mServerPrepareFinished = false
    self.mClientPrepareFinished = false
end

---尝试请求登录地图
---@private
function GameMgr:TryRequestLoginMap()
    if self.mServerPrepareFinished and self.mClientPrepareFinished and self.mIsSendedThisLogin == true then
        --print("CS.CSInterfaceSingleton.NetReq:ReqLoginMapMessage()")
        CS.CSInterfaceSingleton.NetReq:ReqLoginMapMessage()
        self.mIsSendedThisLogin = true
    end
end
--endregion

--region 游戏生命周期相关
---退出游戏
function GameMgr:QuitGame()
    if CS.SDKManager.GameInterface ~= nil then
        CS.SDKManager.GameInterface:QuitGame()
    end
end

---重启游戏
function GameMgr:RestartGame()
    if CS.SDKManager.GameInterface ~= nil then
        CS.SDKManager.GameInterface:RestartApplication()
    end
end

---返回选择角色场景
function GameMgr:ReturnChooseRoleScene()
    networkRequest.ReqCommon(3)
    clientMessageDeal.OnReturnLogin(true)
    uimanager:CloseAllPanel()
    if uiStaticParameter.voiceMgr ~= nil then
        uiStaticParameter.voiceMgr:LogOutGame()
    end
    uiStaticParameter.InCarAcitivity = false
    uiStaticParameter.firstEnterScene = true
end

---返回登录场景
function GameMgr:ReturnLoginScene()
    clientMessageDeal.OnReturnLogin(false)
    uimanager:CloseAllPanel()
    if uiStaticParameter.voiceMgr ~= nil then
        uiStaticParameter.voiceMgr:LogOutGame()
    end
    uiStaticParameter.InCarAcitivity = false
    uiStaticParameter.firstEnterScene = true
end
--endregion

--region
---@return LuaSFTPOperation
function GameMgr:SFTPOperation()
    if (CS.CSGameState.RunPlatform ~= CS.ERunPlatform.IOS) then
        if self.mSFTPOperation == nil then
            self.mSFTPOperation = require "luaRes.common.LuaSFTPOperation"
            self.mSFTPOperation:Init()
        end
    end
    return self.mSFTPOperation
end
--endregion

return GameMgr