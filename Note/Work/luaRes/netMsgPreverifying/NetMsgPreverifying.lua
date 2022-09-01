--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
---网络消息预校验
netMsgPreverifying = {}

netMsgPreverifying.__index = netMsgPreverifying

--activity.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Activity"

--role.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Role"

--skill.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Skill"

--bag.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Bag"

--treasurehunt.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Treasurehunt"

--equip.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Equip"

--store.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Store"

--union.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Union"

--boss.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Boss"

--fcm.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Fcm"

--recharge.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Recharge"

--official.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Official"

--map.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Map"

--duplicate.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Duplicate"

--deliver.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Deliver"

--play.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Play"

--friend.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Friend"

--group.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Group"

--task.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Task"

--servant.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Servant"

--trade.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Trade"

--active.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Active"

--auction.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Auction"

--collect.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Collect"

--imprint.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Imprint"

--appearance.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Appearance"

--rechargegiftbox.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Rechargegiftbox"

--sabac.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Sabac"

--rage.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Rage"

--ghostship.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Ghostship"

--socialcontact.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Socialcontact"

--servantcultivate.xml
require "luaRes.netMsgPreverifying.NetMsgPreverifying_Servantcultivate"
