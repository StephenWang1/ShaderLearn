--[[本文件为工具自动生成,禁止手动修改]]
---加载所有相关proto
local LoadAllRelatedProto = {}

---@param protobufMgr protobufMgr
function LoadAllRelatedProto:LoadAll(protobufMgr)
    ---luaTable->C#数据结构转换
    protobufMgr.DecodeTable = {}
    ---调整luaTable
    protobufMgr.AdjustTable = {}

    protobufMgr.RegisterPb("active.proto")
    protobufMgr.DecodeTable.active = require("luaRes.protobufLua.decode.active")
    protobufMgr.AdjustTable.active_adj = require("luaRes.protobufLua.adjust.active_adj")

    protobufMgr.RegisterPb("activities.proto")
    ---未生成 activities.proto 的lua=>C#文件

    protobufMgr.RegisterPb("activity.proto")
    protobufMgr.DecodeTable.activity = require("luaRes.protobufLua.decode.activity")
    protobufMgr.AdjustTable.activity_adj = require("luaRes.protobufLua.adjust.activity_adj")

    protobufMgr.RegisterPb("bag.proto")
    protobufMgr.DecodeTable.bag = require("luaRes.protobufLua.decode.bag")
    protobufMgr.AdjustTable.bag_adj = require("luaRes.protobufLua.adjust.bag_adj")

    protobufMgr.RegisterPb("appearance.proto")
    protobufMgr.DecodeTable.appearance = require("luaRes.protobufLua.decode.appearance")
    protobufMgr.AdjustTable.appearance_adj = require("luaRes.protobufLua.adjust.appearance_adj")

    protobufMgr.RegisterPb("auction.proto")
    protobufMgr.DecodeTable.auction = require("luaRes.protobufLua.decode.auction")
    protobufMgr.AdjustTable.auction_adj = require("luaRes.protobufLua.adjust.auction_adj")

    protobufMgr.RegisterPb("biqi.proto")
    protobufMgr.DecodeTable.biqi = require("luaRes.protobufLua.decode.biqi")
    protobufMgr.AdjustTable.biqi_adj = require("luaRes.protobufLua.adjust.biqi_adj")

    protobufMgr.RegisterPb("booth.proto")
    protobufMgr.DecodeTable.booth = require("luaRes.protobufLua.decode.booth")
    protobufMgr.AdjustTable.booth_adj = require("luaRes.protobufLua.adjust.booth_adj")

    protobufMgr.RegisterPb("fight.proto")
    protobufMgr.DecodeTable.fight = require("luaRes.protobufLua.decode.fight")
    protobufMgr.AdjustTable.fight_adj = require("luaRes.protobufLua.adjust.fight_adj")

    protobufMgr.RegisterPb("chat.proto")
    protobufMgr.DecodeTable.chat = require("luaRes.protobufLua.decode.chat")
    protobufMgr.AdjustTable.chat_adj = require("luaRes.protobufLua.adjust.chat_adj")

    protobufMgr.RegisterPb("union.proto")
    protobufMgr.DecodeTable.union = require("luaRes.protobufLua.decode.union")
    protobufMgr.AdjustTable.union_adj = require("luaRes.protobufLua.adjust.union_adj")

    protobufMgr.RegisterPb("marry.proto")
    protobufMgr.DecodeTable.marry = require("luaRes.protobufLua.decode.marry")
    protobufMgr.AdjustTable.marry_adj = require("luaRes.protobufLua.adjust.marry_adj")

    protobufMgr.RegisterPb("element.proto")
    protobufMgr.DecodeTable.element = require("luaRes.protobufLua.decode.element")
    protobufMgr.AdjustTable.element_adj = require("luaRes.protobufLua.adjust.element_adj")

    protobufMgr.RegisterPb("imprint.proto")
    protobufMgr.DecodeTable.imprint = require("luaRes.protobufLua.decode.imprint")
    protobufMgr.AdjustTable.imprint_adj = require("luaRes.protobufLua.adjust.imprint_adj")

    protobufMgr.RegisterPb("equip.proto")
    protobufMgr.DecodeTable.equip = require("luaRes.protobufLua.decode.equip")
    protobufMgr.AdjustTable.equip_adj = require("luaRes.protobufLua.adjust.equip_adj")

    protobufMgr.RegisterPb("collect.proto")
    protobufMgr.DecodeTable.collect = require("luaRes.protobufLua.decode.collect")
    protobufMgr.AdjustTable.collect_adj = require("luaRes.protobufLua.adjust.collect_adj")

    protobufMgr.RegisterPb("zhenfa.proto")
    protobufMgr.DecodeTable.zhenfa = require("luaRes.protobufLua.decode.zhenfa")
    protobufMgr.AdjustTable.zhenfa_adj = require("luaRes.protobufLua.adjust.zhenfa_adj")

    protobufMgr.RegisterPb("role.proto")
    protobufMgr.DecodeTable.role = require("luaRes.protobufLua.decode.role")
    protobufMgr.AdjustTable.role_adj = require("luaRes.protobufLua.adjust.role_adj")

    protobufMgr.RegisterPb("common.proto")
    protobufMgr.DecodeTable.common = require("luaRes.protobufLua.decode.common")
    protobufMgr.AdjustTable.common_adj = require("luaRes.protobufLua.adjust.common_adj")

    protobufMgr.RegisterPb("duplicate.proto")
    protobufMgr.DecodeTable.duplicate = require("luaRes.protobufLua.decode.duplicate")
    protobufMgr.AdjustTable.duplicate_adj = require("luaRes.protobufLua.adjust.duplicate_adj")

    protobufMgr.RegisterPb("map.proto")
    protobufMgr.DecodeTable.map = require("luaRes.protobufLua.decode.map")
    protobufMgr.AdjustTable.map_adj = require("luaRes.protobufLua.adjust.map_adj")

    protobufMgr.RegisterPb("boss.proto")
    protobufMgr.DecodeTable.boss = require("luaRes.protobufLua.decode.boss")
    protobufMgr.AdjustTable.boss_adj = require("luaRes.protobufLua.adjust.boss_adj")

    protobufMgr.RegisterPb("buffer.proto")
    protobufMgr.DecodeTable.buffer = require("luaRes.protobufLua.decode.buffer")
    protobufMgr.AdjustTable.buffer_adj = require("luaRes.protobufLua.adjust.buffer_adj")

    protobufMgr.RegisterPb("cart.proto")
    protobufMgr.DecodeTable.cart = require("luaRes.protobufLua.decode.cart")
    protobufMgr.AdjustTable.cart_adj = require("luaRes.protobufLua.adjust.cart_adj")

    protobufMgr.RegisterPb("count.proto")
    protobufMgr.DecodeTable.count = require("luaRes.protobufLua.decode.count")
    protobufMgr.AdjustTable.count_adj = require("luaRes.protobufLua.adjust.count_adj")

    protobufMgr.RegisterPb("deliver.proto")
    protobufMgr.DecodeTable.deliver = require("luaRes.protobufLua.decode.deliver")
    protobufMgr.AdjustTable.deliver_adj = require("luaRes.protobufLua.adjust.deliver_adj")

    protobufMgr.RegisterPb("fcm.proto")
    protobufMgr.DecodeTable.fcm = require("luaRes.protobufLua.decode.fcm")
    protobufMgr.AdjustTable.fcm_adj = require("luaRes.protobufLua.adjust.fcm_adj")

    protobufMgr.RegisterPb("finger.proto")
    protobufMgr.DecodeTable.finger = require("luaRes.protobufLua.decode.finger")
    protobufMgr.AdjustTable.finger_adj = require("luaRes.protobufLua.adjust.finger_adj")

    protobufMgr.RegisterPb("friend.proto")
    protobufMgr.DecodeTable.friend = require("luaRes.protobufLua.decode.friend")
    protobufMgr.AdjustTable.friend_adj = require("luaRes.protobufLua.adjust.friend_adj")

    protobufMgr.RegisterPb("ghostship.proto")
    ---未生成 ghostship.proto 的lua=>C#文件

    protobufMgr.RegisterPb("group.proto")
    protobufMgr.DecodeTable.group = require("luaRes.protobufLua.decode.group")
    protobufMgr.AdjustTable.group_adj = require("luaRes.protobufLua.adjust.group_adj")

    protobufMgr.RegisterPb("junxian.proto")
    protobufMgr.DecodeTable.junxian = require("luaRes.protobufLua.decode.junxian")
    protobufMgr.AdjustTable.junxian_adj = require("luaRes.protobufLua.adjust.junxian_adj")

    protobufMgr.RegisterPb("task.proto")
    protobufMgr.DecodeTable.task = require("luaRes.protobufLua.decode.task")
    protobufMgr.AdjustTable.task_adj = require("luaRes.protobufLua.adjust.task_adj")

    protobufMgr.RegisterPb("lingshou.proto")
    protobufMgr.DecodeTable.lingshou = require("luaRes.protobufLua.decode.lingshou")
    protobufMgr.AdjustTable.lingshou_adj = require("luaRes.protobufLua.adjust.lingshou_adj")

    protobufMgr.RegisterPb("mail.proto")
    protobufMgr.DecodeTable.mail = require("luaRes.protobufLua.decode.mail")
    protobufMgr.AdjustTable.mail_adj = require("luaRes.protobufLua.adjust.mail_adj")

    protobufMgr.RegisterPb("merit.proto")
    protobufMgr.DecodeTable.merit = require("luaRes.protobufLua.decode.merit")
    protobufMgr.AdjustTable.merit_adj = require("luaRes.protobufLua.adjust.merit_adj")

    protobufMgr.RegisterPb("move.proto")
    protobufMgr.DecodeTable.move = require("luaRes.protobufLua.decode.move")
    protobufMgr.AdjustTable.move_adj = require("luaRes.protobufLua.adjust.move_adj")

    protobufMgr.RegisterPb("npcstore.proto")
    protobufMgr.DecodeTable.npcstore = require("luaRes.protobufLua.decode.npcstore")
    protobufMgr.AdjustTable.npcstore_adj = require("luaRes.protobufLua.adjust.npcstore_adj")

    protobufMgr.RegisterPb("official.proto")
    protobufMgr.DecodeTable.official = require("luaRes.protobufLua.decode.official")
    protobufMgr.AdjustTable.official_adj = require("luaRes.protobufLua.adjust.official_adj")

    protobufMgr.RegisterPb("play.proto")
    protobufMgr.DecodeTable.play = require("luaRes.protobufLua.decode.play")
    protobufMgr.AdjustTable.play_adj = require("luaRes.protobufLua.adjust.play_adj")

    protobufMgr.RegisterPb("rage.proto")
    ---未生成 rage.proto 的lua=>C#文件

    protobufMgr.RegisterPb("rank.proto")
    protobufMgr.DecodeTable.rank = require("luaRes.protobufLua.decode.rank")
    protobufMgr.AdjustTable.rank_adj = require("luaRes.protobufLua.adjust.rank_adj")

    protobufMgr.RegisterPb("recharge.proto")
    protobufMgr.DecodeTable.recharge = require("luaRes.protobufLua.decode.recharge")
    protobufMgr.AdjustTable.recharge_adj = require("luaRes.protobufLua.adjust.recharge_adj")

    protobufMgr.RegisterPb("rechargegiftbox.proto")
    protobufMgr.DecodeTable.rechargegiftbox = require("luaRes.protobufLua.decode.rechargegiftbox")
    protobufMgr.AdjustTable.rechargegiftbox_adj = require("luaRes.protobufLua.adjust.rechargegiftbox_adj")

    protobufMgr.RegisterPb("redbag.proto")
    protobufMgr.DecodeTable.redbag = require("luaRes.protobufLua.decode.redbag")
    protobufMgr.AdjustTable.redbag_adj = require("luaRes.protobufLua.adjust.redbag_adj")

    protobufMgr.RegisterPb("sabac.proto")
    ---未生成 sabac.proto 的lua=>C#文件

    protobufMgr.RegisterPb("sealmark.proto")
    ---未生成 sealmark.proto 的lua=>C#文件

    protobufMgr.RegisterPb("servant.proto")
    protobufMgr.DecodeTable.servant = require("luaRes.protobufLua.decode.servant")
    protobufMgr.AdjustTable.servant_adj = require("luaRes.protobufLua.adjust.servant_adj")

    protobufMgr.RegisterPb("servantcultivate.proto")
    protobufMgr.DecodeTable.servantcultivate = require("luaRes.protobufLua.decode.servantcultivate")
    protobufMgr.AdjustTable.servantcultivate_adj = require("luaRes.protobufLua.adjust.servantcultivate_adj")

    protobufMgr.RegisterPb("share.proto")
    ---未生成 share.proto 的lua=>C#文件

    protobufMgr.RegisterPb("sharegroup.proto")
    ---未生成 sharegroup.proto 的lua=>C#文件

    protobufMgr.RegisterPb("socialcontact.proto")
    protobufMgr.DecodeTable.socialcontact = require("luaRes.protobufLua.decode.socialcontact")
    protobufMgr.AdjustTable.socialcontact_adj = require("luaRes.protobufLua.adjust.socialcontact_adj")

    protobufMgr.RegisterPb("skill.proto")
    protobufMgr.DecodeTable.skill = require("luaRes.protobufLua.decode.skill")
    protobufMgr.AdjustTable.skill_adj = require("luaRes.protobufLua.adjust.skill_adj")

    protobufMgr.RegisterPb("store.proto")
    protobufMgr.DecodeTable.store = require("luaRes.protobufLua.decode.store")
    protobufMgr.AdjustTable.store_adj = require("luaRes.protobufLua.adjust.store_adj")

    protobufMgr.RegisterPb("sworn.proto")
    protobufMgr.DecodeTable.sworn = require("luaRes.protobufLua.decode.sworn")
    protobufMgr.AdjustTable.sworn_adj = require("luaRes.protobufLua.adjust.sworn_adj")

    protobufMgr.RegisterPb("tip.proto")
    protobufMgr.DecodeTable.tip = require("luaRes.protobufLua.decode.tip")
    protobufMgr.AdjustTable.tip_adj = require("luaRes.protobufLua.adjust.tip_adj")

    protobufMgr.RegisterPb("title.proto")
    protobufMgr.DecodeTable.title = require("luaRes.protobufLua.decode.title")
    protobufMgr.AdjustTable.title_adj = require("luaRes.protobufLua.adjust.title_adj")

    protobufMgr.RegisterPb("tower.proto")
    protobufMgr.DecodeTable.tower = require("luaRes.protobufLua.decode.tower")
    protobufMgr.AdjustTable.tower_adj = require("luaRes.protobufLua.adjust.tower_adj")

    protobufMgr.RegisterPb("trade.proto")
    protobufMgr.DecodeTable.trade = require("luaRes.protobufLua.decode.trade")
    protobufMgr.AdjustTable.trade_adj = require("luaRes.protobufLua.adjust.trade_adj")

    protobufMgr.RegisterPb("treasurehunt.proto")
    protobufMgr.DecodeTable.treasurehunt = require("luaRes.protobufLua.decode.treasurehunt")
    protobufMgr.AdjustTable.treasurehunt_adj = require("luaRes.protobufLua.adjust.treasurehunt_adj")

    protobufMgr.RegisterPb("uniteunion.proto")
    protobufMgr.DecodeTable.uniteunion = require("luaRes.protobufLua.decode.uniteunion")
    protobufMgr.AdjustTable.uniteunion_adj = require("luaRes.protobufLua.adjust.uniteunion_adj")

    protobufMgr.RegisterPb("user.proto")
    protobufMgr.DecodeTable.user = require("luaRes.protobufLua.decode.user")
    protobufMgr.AdjustTable.user_adj = require("luaRes.protobufLua.adjust.user_adj")

    protobufMgr.RegisterPb("vip.proto")
    protobufMgr.DecodeTable.vip = require("luaRes.protobufLua.decode.vip")
    protobufMgr.AdjustTable.vip_adj = require("luaRes.protobufLua.adjust.vip_adj")

    protobufMgr.RegisterPb("welfare.proto")
    protobufMgr.DecodeTable.welfare = require("luaRes.protobufLua.decode.welfare")
    protobufMgr.AdjustTable.welfare_adj = require("luaRes.protobufLua.adjust.welfare_adj")

    protobufMgr.RegisterPb("wing.proto")
    protobufMgr.DecodeTable.wing = require("luaRes.protobufLua.decode.wing")
    protobufMgr.AdjustTable.wing_adj = require("luaRes.protobufLua.adjust.wing_adj")

end

return LoadAllRelatedProto