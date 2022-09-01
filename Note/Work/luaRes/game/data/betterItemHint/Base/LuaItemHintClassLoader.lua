---@class LuaItemHintClassLoader 推送类加载器
local LuaItemHintClassLoader = {}

---@param luaclass luaclass
function LuaItemHintClassLoader:LoadAllClasses(luaclass)
    --region 推送基类
    ---更好物品推送数据管理类
    luaclass.BetterItemHintDataMgr = require "luaRes.game.data.betterItemHint.Base.BetterItemHintDataMgr"
    ---更好物品服务器数据解析包
    luaclass.BetterItemBagItemChangePackage = require "luaRes.game.data.betterItemHint.Base.BetterItemBagItemChangePackage"
    ---更好物品推送物品列表数据基类
    luaclass.BetterItemHintItem_Base = require "luaRes.game.data.betterItemHint.Base.BetterItemHintItem_Base"
    ---更好物品推送物品数据基类
    luaclass.BetterItemHintItemList_Base = require "luaRes.game.data.betterItemHint.Base.BetterItemHintItemList_Base"
    ---推送缓存队列
    luaclass.BetterItemHintCacheQueue = require "luaRes.game.data.betterItemHint.Base.BetterItemHintCacheQueue"
    --endregion

    --region 血继
    ---血继推送物品列表
    luaclass.BetterItemHintItemList_BloodEquip = require "luaRes.game.data.betterItemHint.BloodEquip.BetterItemHintItemList_BloodEquip"
    ---血继推送物品
    luaclass.BetterItemHintItem_BloodEquip = require "luaRes.game.data.betterItemHint.BloodEquip.BetterItemHintItem_BloodEquip"
    --endregion

    --region 单物品推送
    ---单物品推送物品列表
    luaclass.BetterItemHintItemList_SingleItem = require "luaRes.game.data.betterItemHint.SingleItemHint.BetterItemHintItemList_SingleItem"
    ---单物品推送的物品
    luaclass.BetterItemHintItem_SingleItem = require "luaRes.game.data.betterItemHint.SingleItemHint.BetterItemHintItem_SingleItem"
    --endregion

    --region 宝箱推送
    ---宝箱推送物品列表
    --luaclass.BetterItemHintItemList_EquipBox = require "luaRes.game.data.betterItemHint.EquipBox.BetterItemHintItemList_EquipBox"
    ---宝箱推送的物品
    --luaclass.BetterItemHintItem_EquipBox = require "luaRes.game.data.betterItemHint.EquipBox.BetterItemHintItem_EquipBox"
    --endregion

    --region 人物装备推送
    ---人物装备推送物品列表
    luaclass.BetterItemHintItemList_PlayerNormalEquip = require "luaRes.game.data.betterItemHint.PlayerNormalEquip.BetterItemHintItemList_PlayerNormalEquip"
    ---人物装备推送的物品
    luaclass.BetterItemHintItem_PlayerNormalEquip = require "luaRes.game.data.betterItemHint.PlayerNormalEquip.BetterItemHintItem_PlayerNormalEquip"
    --endregion

    --region 熔炼推送
    ---熔炼推送物品列表
    --luaclass.BetterItemHintItemList_EquipMelte = require "luaRes.game.data.betterItemHint.EquipMelte.BetterItemHintItemList_EquipMelte"
    ---熔炼推送的物品
    --luaclass.BetterItemHintItem_EquipMelte = require "luaRes.game.data.betterItemHint.EquipMelte.BetterItemHintItem_EquipMelte"
    --endregion

    --region 魂装推送
    luaclass.BetterItemHintItem_SoulEquip = require "luaRes.game.data.betterItemHint.SoulEquip.BetterItemHintItem_SoulEquip"
    luaclass.BetterItemHintItemList_SoulEquip = require "luaRes.game.data.betterItemHint.SoulEquip.BetterItemHintItemList_SoulEquip"
    --endregion

    --region 法宝推送
    ---法宝推送物品列表
    luaclass.BetterItemHintItemList_RoleMagicEquip = require "luaRes.game.data.betterItemHint.RoleMagicEquip.BetterItemHintItemList_RoleMagicEquip"
    ---法宝推送的物品
    luaclass.BetterItemHintItem_RoleMagicEquip = require "luaRes.game.data.betterItemHint.RoleMagicEquip.BetterItemHintItem_RoleMagicEquip"
    --endregion

    --region 时装外观推送
    ---时装外观推送物品列表
    luaclass.BetterItemHintItemList_Appearance = require "luaRes.game.data.betterItemHint.Appearance.BetterItemHintItemList_Appearance"
    ---时装外观推送的物品
    luaclass.BetterItemHintItem_Appearance = require "luaRes.game.data.betterItemHint.Appearance.BetterItemHintItem_Appearance"
    --endregion
end

return LuaItemHintClassLoader