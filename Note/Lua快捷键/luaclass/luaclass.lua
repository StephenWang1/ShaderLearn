---@class classCtrl
local classCtrl = {}

---@class luaclass
luaclass = {}

---初始化
---@public
function classCtrl:Initialize()
    ---@type luaobject
    classCtrl.luaobject = require "luaRes.luaclass.luaobject"
    self:LoadAllClassFiles()
    self:BindAllMetatables()
end

---加载所有类文件
---@private
function classCtrl:LoadAllClassFiles()
    luaclass.UIComponentController = require "luaRes.luaclass.UIComponentController"
    luaclass.luacopyobject = require "luaRes.luaclass.luacopyobject"

    --region Boss界面
    luaclass.UIGoMapBtnUnit = require "luaRes.luaclass.UIBossPanelDir.UIGoMapBtnUnit"
    luaclass.UIGoMapBtnView = require "luaRes.luaclass.UIBossPanelDir.UIGoMapBtnView"
    luaclass.UIBossUnit = require "luaRes.luaclass.UIBossPanelDir.UIBossUnit"
    luaclass.UIBossView = require "luaRes.luaclass.UIBossPanelDir.UIBossView"
    --endregion

    --region 拍卖行
    luaclass.UIAuctionPanel_BagPanel = require "luaRes.luaclass.UIAuctionPanel.UIAuctionPanel_BagPanel.UIAuctionPanel_BagPanel"
    --endregion

    --region 排行榜
    gameMgr:GetRankClassLoader():LoadAllRankClasses(luaclass)
    --endregion

    --region 场景类加载
    gameMgr:GetSceneClassLoader():LoadSceneClasses(luaclass)
    --endregion

    --region 武道会
    luaclass.BuDouKaiLuaDataClass = require "luaRes.luaclass.BuDouKai.Data.BuDouKaiLuaDataClass"
    luaclass.BuDouKaiBetDataClass = require "luaRes.luaclass.BuDouKai.Data.BuDouKaiBetDataClass"
    --endregion

    --region 物品推送
    luaclass.BetterItemHint_Control = require "luaRes.luaclass.UIMainHint.BetterItemHint.BetterItemHint_Control"
    luaclass.BetterItemHint_Data = require "luaRes.luaclass.UIMainHint.BetterItemHint.BetterItemHint_Data"
    --endregion

    --region 商会
    luaclass.MonthCardTableData = require "luaRes.luaclass.Commerce.MonthCardTableData"
    --endregion

    --region 行会
    luaclass.UnionDataInfo = require "luaRes.luaclass.Union.UnionDataInfo"
    ---行会熔炼
    luaclass.UnionSmeltDataInfo = require "luaRes.luaclass.Union.UnionSmeltDataInfo"
    --endregion

    --region 聊天
    luaclass.ChatData = require "luaRes.luaclass.Chat.Data.ChatData"
    --endregion

    --region 魔之boss
    luaclass.MagicBossDataInfo = require "luaRes.luaclass.MagicBoss.MagicBossDataInfo"
    luaclass.MagicBossTypeDataInfo = require "luaRes.luaclass.MagicBoss.MagicBossTypeDataInfo"
    --endregion

    --region 封印塔
    luaclass.SealTowerDataInfo = require "luaRes.luaclass.SealTower.SealTowerDataInfo"
    --endregion

    --region 跨服
    ---跨服基础数据处理
    luaclass.RemoteHostDataClass = require "luaRes.luaclass.KuaFu.Base.RemoteHostDataClass"
    ---跨服开始提醒
    luaclass.KuaFuStartHint = require "luaRes.luaclass.KuaFu.Main.KuaFuStartHint"
    --endregion

    --region 组队
    luaclass.LuaGroupManager = require "luaRes.luaclass.Group.LuaGroupManager"

    --endregion

    --region 主界面左侧任务栏
    luaclass.LeftMainMissionPart = require "luaRes.luaclass.MainPanelLeftMission.LeftMainMissionPart"
    luaclass.LeftMainMissionData = require "luaRes.luaclass.MainPanelLeftMission.LeftMainMissionData"
    luaclass.LeftMainMissionData_GuaJi = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_GuaJi"
    luaclass.LeftMainMissionData_WoYaoJingYan = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_WoYaoJingYan"
    luaclass.LeftMainMissionData_WoYaoYuanBao = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_WoYaoYuanBao"
    luaclass.LeftMainMissionData_ChallengeBoss = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_ChallengeBoss"
    luaclass.LeftMainMissionData_ChallengeBossFinish = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_ChallengeBossFinish"
    luaclass.LeftMainMissionData_ChallengeBossReceive = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_ChallengeBossReceive"
    luaclass.LeftMainMissionData_MonsterArrest = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_MonsterArrest"
    luaclass.LeftMainMissionData_LingHunRenWu = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_LingHunRenWu"
    luaclass.LeftMainMissionData_WeaponBookMission = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_WeaponBookMission"
    luaclass.LeftMainMissionData_Composition = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_Composition"
    luaclass.LeftMainMissionData_Cavalry = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_Cavalry"
    luaclass.LeftMainMissionData_WeaponSoul = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_WeaponSoul"
    luaclass.LeftMainMissionData_GodRoad = require "luaRes.luaclass.MainPanelLeftMission.Datas.LeftMainMissionData_GodRoad"
    --endregion

    --region 物品信息面板数据
    ---物品信息面板基础数据类
    luaclass.ItemInfoPanelBase = require "luaRes.luaclass.ItemInfo.Base.ItemInfoPanelBase"
    ---物品信息面板单个物品信息类
    luaclass.ItemDataInfo = require "luaRes.luaclass.ItemInfo.Data.ItemDataInfo"
    --endregion

    --region 镖车数据
    ---配置镖车数据类
    luaclass.ConfigDartCar = require "luaRes.luaclass.DartCar.ConfigDartCar"
    ---运行镖车数据类
    luaclass.OperationDartCar = require "luaRes.luaclass.DartCar.OperationDartCar"

    --endregion

    --region 魂装
    luaclass.LuaSoulEquipDataClass = require "luaRes.luaclass.SoulEquip.LuaSoulEquipDataClass"
    luaclass.LuaSoulEquipVo = require "luaRes.luaclass.SoulEquip.LuaSoulEquipVo"
    --endregion

    --region 推送类加载
    gameMgr:GetItemHintClassLoader():LoadAllClasses(luaclass)
    --endregion

    --region 倒计时
    luaclass.ActivityEndCountDownData = require "luaRes.luaclass.CountDown.ActivityEndCountDownData"
    luaclass.CountDownEndPackage = require "luaRes.luaclass.CountDown.CountDownEndPackage"
    --endregion

    --region 沙巴克数据类
    luaclass.LuaShaBaKDataMgr = require "luaRes.game.data.ShaBaKe.LuaShaBaKDataMgr"
    --endregion

    --region 转生类
    luaclass.LuaReinDataManager = require "luaRes.game.data.Rein.LuaReinDataManager"
    --endregion

    --region Boss类
    luaclass.LuaBossDataManager = require "luaRes.game.data.Boss.LuaBossDataManager"
    --endregion

    --region 地宫挖宝
    luaclass.LuaDigTreasureManager = require "luaRes.game.data.DigTreasure.LuaDigTreasureDataManager"
    --endregion

    --region 系统预告
    luaclass.LuaSystemPreviewInfoMgr = require "luaRes.game.data.System.LuaSystemPreviewInfoMgr"
    --endregion

    --region 鉴定
    luaclass.LuaForgeIdentifyMgr = require "luaRes.game.data.ForgeIdentify.LuaForgeIdentifyMgr"
    --endregion

    --region 怪物攻城
    luaclass.LuaMonsterAttackMgr = require "luaRes.game.data.MonsterAttack.LuaMonsterAttackMgr"
    --endregion

    --region 幽灵船
    luaclass.LuaGhostShipMgr = require "luaRes.game.data.GhostShip.LuaGhostShipMgr"
    --endregion

    --region 联盟
    luaclass.LuaLeagueMgr = require "luaRes.game.data.League.LuaLeagueMgr"
    --endregion

    --region 联盟战旗
    luaclass.LuaLeagueFlagMgr = require "luaRes.game.data.LeagueFlag.LuaLeagueFlagMgr"
    --endregion

    --region 坐骑
    gameMgr:GetHorseClassLoader():LoadAllHorseClasses(luaclass)
    --endregion

    --region HMAC_SHA256
    luaclass.bit = require("luaRes.game.data.HMACSHA.bit")
    require "luaRes.game.data.HMACSHA.HMAC_SHA256"
    --endregion

    --region 战灵复苏
    luaclass.LuaBattleSoulAwakeMgr = require "luaRes.game.data.BattleSoulAwake.LuaBattleSoulAwakeMgr"
    --endregion

    ---加载其他
    self:LoadOtherClass()

end

---加载其他类
function classCtrl:LoadOtherClass()

    --region 月卡
    luaclass.MonthCardInfo = require "luaRes.luaclass.MonthCard.MonthCardInfo"
    --endregion

    --region 法宝
    ---法宝更好装备缓存统计
    luaclass.BagBetterMagicEquip = require "luaRes.luaclass.MagicEquip.BagBetterMagicEquip"
    ---法宝页签状态数据
    luaclass.MagicEquipPage = require "luaRes.luaclass.MagicEquip.MagicEquipPage"
    --endregion

    --region 终极boss
    ---@type FinalBossDataInfo 终极boss基础数据类
    luaclass.FinalBossDataInfo = require "luaRes.luaclass.FinalBoss.FinalBossDataInfo"
    ---@type MythBossDataInfo 神级boss基础数据类
    luaclass.MythBossDataInfo = require "luaRes.luaclass.FinalBoss.MythBossDataInfo"
    --endregion

    ---野外boss额外处理
    luaclass.FieldBossExtraDeal = require "luaRes.luaclass.FieldBoss.FieldBossExtraDeal"

    --region UI刷新
    ---@type UIRefresh
    luaclass.UIRefresh = require "luaRes.luaclass.UIRefresh.UIRefresh"
    --endregion

    --region 寻路
    ---@type FindPath
    luaclass.FindPath = require "luaRes.luaclass.FindPath.FindPath"
    --endregion

    --region 淬炼
    ---@type LuaForgeQuenchDataManager
    luaclass.LuaForgeQuenchDataManager = require "luaRes.game.data.ForgeQuench.LuaForgeQuenchDataManager"
    ---@type LuaForgeQuenchItemData
    luaclass.LuaForgeQuenchItemData = require "luaRes.game.data.ForgeQuench.LuaForgeQuenchItemData"
    --endregion

    --region 淬炼
    ---@type LuaForgeQuenchSecondDataManager
    luaclass.LuaForgeQuenchSecondDataManager = require "luaRes.game.data.ForgeQuenchSecond.LuaForgeQuenchSecondDataManager"
    ---@type LuaForgeQuenchSecondItemData
    luaclass.LuaForgeQuenchSecondItemData = require "luaRes.game.data.ForgeQuenchSecond.LuaForgeQuenchSecondItemData"
    --endregion

    --region 铭文
    luaclass.LuaEquipRunesInfoMgr = require "luaRes.game.data.Runes.LuaEquipRunesInfoMgr"
    --endregion

    --region 兵魂
    luaclass.LuaWeaponSoulMgr = require "luaRes.game.data.WeaponSoul.LuaWeaponSoulMgr"
    --endregion

    --region 坐骑
    luaclass.LuaHorseItemData= require"luaRes.game.data.Horse.Maps.LuaHorseItemData"
    luaclass.HorseMapsDataManager = require "luaRes.game.data.Horse.Maps.LuaHorseMapsDataManager"
    luaclass.LuaHorseEquipDataMgr= require"luaRes.game.data.Horse.Equip.LuaHorseEquipDataMgr"
    luaclass. LuaHorseEquipItemData=require"luaRes.game.data.Horse.Equip.LuaHorseEquipItemData"
    --endregion

    --region 扶持礼包
    luaclass.LuaSupportAwardMgr = require "luaRes.game.data.SupportAward.LuaSupportAwardMgr"
    --endregion

    --region 巨龙宝藏
    luaclass.DragonTreasureActivityData = require "luaRes.game.data.CommonActivity.DragonTreasureActivityData"
    luaclass.DragonTreasureWarehouseData = require "luaRes.game.data.CommonActivity.DragonTreasureWarehouseData"
    --endregion

    --region 封神之路
    luaclass.FengShenZhiLuDataMgr= require "luaRes.game.data.FengShenZhiLu.LuaFengShenZhiLuDataMgr"
    luaclass.FengShenZhiLuDuplicateDataItem= require "luaRes.game.data.FengShenZhiLu.LuaFengShenDuplicateDataItem"
    luaclass.FengShenTaskDataItem= require "luaRes.game.data.FengShenZhiLu.LuaFengShenTaskDataItem"
    --endregion

    --region 快捷键
    luaclass.LuaShortcutKeyInfo= require "luaRes.LuaShortcutKeyInfo"
    luaclass.LuaShortcutKeyMgr= require "luaRes.LuaShortcutKeyMgr"
    luaclass.LuaShortcutKeyItem= require "luaRes.LuaShortcutKeyItem"
    luaclass.LuaShortcutKeyMsgMgr= require "luaRes.LuaShortcutKeyMsgMgr"
    --endregion
end

---绑定所有元表
---@private
function classCtrl:BindAllMetatables()
    for i, v in pairs(luaclass) do
        self:BindMetatable(v, i)
        --if luaDebugTool ~= nil then
        --    luaDebugTool.RecordTable(luaDebugTool.TableType.LuaClass, v)
        --end
    end
    luaclass.__index = luaclass
end

---为单个表绑定元表
---@private
---@param tbl luaobject 需要绑定元表的表
---@param classname string 表对应的类名
function classCtrl:BindMetatable(tbl, classname)
    if tbl and type(tbl) == "table" then
        local metatable = getmetatable(tbl)
        ---当元表为空或元表等与自身且自身不为luaobject时,设置元表为luaobject(自身的元表为自身时,索引其对象将出现死循环)
        if (metatable == nil or tbl == metatable) and tbl ~= classCtrl.luaobject then
            setmetatable(tbl, classCtrl.luaobject)
        end
        tbl.__index = tbl
        tbl.__className = classname
    end
end

---表析构方法
---@public
---@param tbl luaobject
function classCtrl.OnTableDestroyed(tbl)
    if tbl == nil then
        return
    end
    if tbl.OnDestruct then
        tbl:OnDestruct()
    end
    for i, v in pairs(tbl) do
        tbl[i] = nil
    end
end

---游戏场景退回到登录/选角界面时触发
---@public
function classCtrl:OnExitDestroy()
    for k, v in pairs(luaclass) do
        if v ~= nil and type(v) == 'table' and v.OnExitDestroy ~= nil then
            v:OnExitDestroy()
        end
    end
end

return classCtrl