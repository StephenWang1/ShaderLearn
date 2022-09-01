--[[本文件为工具自动生成,禁止手动修改]]
---网络消息响应
networkRespond = {}

---客户端链接服务器成功
---msgID: 101
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnConnectSuccessMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---客户端链接服务器失败
---msgID: 102
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnConnectFailedMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

--user.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_User'
--activity.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Activity'
--chat.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Chat'
--tip.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Tip'
--role.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Role'
--skill.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Skill'
--bag.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Bag'
--treasurehunt.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Treasurehunt'
--equip.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Equip'
--store.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Store'
--wing.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Wing'
--count.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Count'
--union.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Union'
--rank.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Rank'
--welfare.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Welfare'
--vip.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Vip'
--boss.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Boss'
--title.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Title'
--fcm.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Fcm'
--mail.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Mail'
--recharge.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Recharge'
--lingshou.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Lingshou'
--tower.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Tower'
--official.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Official'
--junxian.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Junxian'
--map.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Map'
--fight.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Fight'
--duplicate.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Duplicate'
--deliver.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Deliver'
--play.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Play'
--biqi.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Biqi'
--sealmark.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Sealmark'
--friend.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Friend'
--group.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Group'
--task.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Task'
--servant.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Servant'
--trade.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Trade'
--cart.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Cart'
--active.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Active'
--redbag.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Redbag'
--element.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Element'
--auction.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Auction'
--collect.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Collect'
--finger.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Finger'
--sworn.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Sworn'
--marry.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Marry'
--imprint.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Imprint'
--appearance.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Appearance'
--merit.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Merit'
--booth.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Booth'
--npcstore.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Npcstore'
--rechargegiftbox.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Rechargegiftbox'
--activities.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Activities'
--sabac.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Sabac'
--rage.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Rage'
--zhenfa.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Zhenfa'
--ghostship.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Ghostship'
--socialcontact.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Socialcontact'
--servantcultivate.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Servantcultivate'
--sharegroup.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Sharegroup'
--uniteunion.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Uniteunion'
--share.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Share'
--sharesocialcontact.xml
require 'luaRes.protobufLua.networkRespond.NetworkRespond_Sharesocialcontact'
