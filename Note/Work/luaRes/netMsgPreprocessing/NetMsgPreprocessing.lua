--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
---网络消息预处理
netMsgPreprocessing = {}

netMsgPreprocessing.__index = netMsgPreprocessing

--region ID:101 ConnectSuccessMessage 客户端链接服务器成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[101] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:102 ConnectFailedMessage 客户端链接服务器失败
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[102] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--[[
--region ID:48258 ResUnlockEffectMessage 解锁灵兽
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[48258] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:70007 ResRageStateMessage 狂暴之力状态响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[70007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--user.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_User"

--activity.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Activity"

--chat.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Chat"

--tip.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Tip"

--role.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Role"

--skill.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Skill"

--bag.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Bag"

--treasurehunt.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Treasurehunt"

--equip.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Equip"

--store.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Store"

--wing.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Wing"

--count.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Count"

--union.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Union"

--rank.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Rank"

--welfare.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Welfare"

--vip.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Vip"

--boss.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Boss"

--title.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Title"

--fcm.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Fcm"

--mail.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Mail"

--recharge.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Recharge"

--lingshou.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Lingshou"

--tower.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Tower"

--official.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Official"

--junxian.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Junxian"

--map.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Map"

--fight.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Fight"

--duplicate.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Duplicate"

--deliver.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Deliver"

--play.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Play"

--biqi.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Biqi"

--sealmark.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Sealmark"

--friend.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Friend"

--group.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Group"

--task.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Task"

--servant.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Servant"

--trade.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Trade"

--cart.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Cart"

--active.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Active"

--redbag.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Redbag"

--element.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Element"

--auction.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Auction"

--collect.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Collect"

--finger.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Finger"

--sworn.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Sworn"

--marry.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Marry"

--imprint.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Imprint"

--appearance.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Appearance"

--merit.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Merit"

--booth.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Booth"

--npcstore.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Npcstore"

--rechargegiftbox.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Rechargegiftbox"

--activities.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Activities"

--sabac.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Sabac"

--rage.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Rage"

--zhenfa.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Zhenfa"

--ghostship.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Ghostship"

--socialcontact.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Socialcontact"

--servantcultivate.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Servantcultivate"

--sharegroup.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Sharegroup"

--uniteunion.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Uniteunion"

--share.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Share"

--sharesocialcontact.xml
require "luaRes.netMsgPreprocessing.NetMsgPreprocessing_Sharesocialcontact"
