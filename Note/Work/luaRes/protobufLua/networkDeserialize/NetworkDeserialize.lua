--[[本文件为工具自动生成,禁止手动修改]]
---网络消息解析
networkDeserialize = {}

---客户端链接服务器成功
---msgID: 101
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnConnectSuccessMessageReceived(msgID, buffer)
end

---客户端链接服务器失败
---msgID: 102
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnConnectFailedMessageReceived(msgID, buffer)
end

--user.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_User'
--activity.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Activity'
--chat.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Chat'
--tip.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Tip'
--role.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Role'
--skill.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Skill'
--bag.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Bag'
--treasurehunt.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Treasurehunt'
--equip.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Equip'
--store.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Store'
--wing.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Wing'
--count.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Count'
--union.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Union'
--rank.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Rank'
--welfare.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Welfare'
--vip.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Vip'
--boss.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Boss'
--title.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Title'
--fcm.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Fcm'
--mail.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Mail'
--recharge.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Recharge'
--lingshou.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Lingshou'
--tower.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Tower'
--official.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Official'
--junxian.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Junxian'
--map.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Map'
--fight.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Fight'
--duplicate.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Duplicate'
--deliver.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Deliver'
--play.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Play'
--biqi.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Biqi'
--sealmark.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Sealmark'
--friend.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Friend'
--group.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Group'
--task.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Task'
--servant.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Servant'
--trade.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Trade'
--cart.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Cart'
--active.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Active'
--redbag.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Redbag'
--element.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Element'
--auction.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Auction'
--collect.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Collect'
--finger.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Finger'
--sworn.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Sworn'
--marry.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Marry'
--imprint.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Imprint'
--appearance.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Appearance'
--merit.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Merit'
--booth.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Booth'
--npcstore.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Npcstore'
--rechargegiftbox.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Rechargegiftbox'
--activities.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Activities'
--sabac.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Sabac'
--rage.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Rage'
--zhenfa.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Zhenfa'
--ghostship.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Ghostship'
--socialcontact.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Socialcontact'
--servantcultivate.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Servantcultivate'
--sharegroup.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Sharegroup'
--uniteunion.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Uniteunion'
--share.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Share'
--sharesocialcontact.xml
require 'luaRes.protobufLua.networkDeserialize.NetworkDeserialize_Sharesocialcontact'
