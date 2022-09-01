--1 热更函数，替换原来函数
util.hotfix_ex(CS.CSNetwork, "Connect", function(self, _host, _port, type)
    self:Connect(_host, _port, type);
    local debugInfo = 'this is a test.the localtest file isRunning successed     _host'..tostring(_host)

    CS.UnityEngine.Debug.Log(debugInfo)

end)
--xlua.private_accessible(CS.XLuaTest)
--xlua.hotfix(CS.XLuaTest, 'Update', function(self)
--                    self:Update()
--					self.tick = self.tick+1;
--					CS.XLuaTest.StaticTest();
--                    print('<<<<<<<<Update localtest in lua, tick private = ',self.tick)
--					print('<<<<<<<<Update localtest in lua, tick public = ',self.tickLua)
--                    if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.T))
--                    then
--                    local TestBag = {key=100};
--                    protobufMgr.SendMsg(135110,"TestBag",TestBag);
--                    end
--                end)

--util.hotfix_ex(CS.XLuaTest, 'Update', function(self)
--                    print('热更补丁+私有变量访问测试',self.tick)
--					self:Update();
--					self.tick = self.tick+1;
--					--CS.XLuaTest.StaticTest();
--                    print('<<<<<<<<Update localtest in lua, tick private = ',self.tick)
--					--print('<<<<<<<<Update localtest in lua, tick public = ',self.tickLua)
--                end)
--xlua.private_accessible(CS.StatefullTest)
--xlua.hotfix(CS.StatefullTest, 'Update', function(self)
--                    print('<<<<<<<<Update localtest in lua, tick private = ',self.privateTestValue)
--					print('<<<<<<<<Update localtest in lua, tick public = ',self.publickTestValue)
--                end)
--xlua.hotfix(CS.StatefullTest, {
--                ['.ctor'] = function(csobj)
--				print('ctor')
--                    return {evt = {}, start = 2}
--                end;
--                set_AProp = function(self, v)
--                    print('set_AProp', v)
--                    self.AProp = v
--                end;
--                get_AProp = function(self)
--                    return self.AProp
--                end;
--                get_Item = function(self, k)
--                    print('get_Item', k)
--                    return 1024
--                end;
--                set_Item = function(self, k, v)
--                    print('set_Item', k, v)
--                end;
--                add_AEvent = function(self, cb)
--                    print('add_AEvent', cb)
--                    table.insert(self.evt, cb)
--                end;
--                remove_AEvent = function(self, cb)
--                   print('remove_AEvent', cb)
--                   for i, v in ipairs(self.evt) do
--                       if v == cb then
--                           table.remove(self.evt, i)
--                           break
--                       end
--                   end
--                end;
--                Start = function(self)
--				    self.Update()
--                    print('Start private',self.privateTestValue)
--					print('Start public',self.publickTestValue)
--                    for _, cb in ipairs(self.evt) do
--                        cb(self.start, 2)
--                    end
--                    self.start = self.start + 1
--                end;
--                StaticFunc = function(a, b, c)
--                   print(a, b, c)
--                end;
--                GenericTest = function(self, a)
--                   print(self, a)
--                end;
--                Finalize = function(self)
--                   print('Finalize', self)
--                end
--           })
--2 热更函数测试（可保留原来函数逻辑）
--[[util.hotfix_ex(CS.UILogin, 'OnButtonClick', function(self,param)
                print("UI点击测试：OnButtonClick"..param.name);
                self:OnButtonClick(param);
                local panel = uimanager.CreatePanel("UIBagPanel");
                --UIEventListener.Get(this.transform.Find("loginview/btn_login").gameObject).onClick = OnButtonClick;
                local box = panel:AddComponent(typeof(CS.UnityEngine.BoxCollider));
                box.size = CS.UnityEngine.Vector3(1000,1000,1);
                CS.UnityEngine.Debug.Log("UnityEngine Log");
                -- CS.UIEventListener.Get(self.transform:Find("loginview/btn_login").gameObject).onClick =
                CS.UIEventListener.Get(panel).onClick = 
                function(p)
                print("clicked",p.name);
                end
                
                end)--]]
--3 中文编码格式：vs 高级设置中 UTF8 65001
--[[local co = coroutine.create(function()
    print('协程测试：coroutine start!')
    local s = os.time()
    yield_return(CS.NGUIAssist.GetWaitForSeconds(3))
    print('wait interval:', os.time() - s)
end)
assert(coroutine.resume(co))--]]

--4 System vluaeType Test
--local v = "1";
--CS.System.IntT
--4
--[[local lst = CS.System.Collections.Generic["List`1[System.String]"]()
misc.AddDynamicValue(1,1);--]]

--5 文件读取+LuaBehaviour
--[[local go = CS.UnityEngine.GameObject.Find("GameState");
            local  lb = go:AddComponent(typeof(CS.LuaBehaviour));
            local luaScript;
            if(isLocalTest)
            then
                local  path = CS.UnityEngine.Application.streamingAssetsPath.."/luaRes/common/luaBehaviour.lua";
                print(path);
                luaScript = file_util.Read(path);
                print(luaScript);
            else
                local  path = CS.UnityEngine.Application.persistentDataPath.."/luaRes/common/luaBehaviour.lua";
                print(path);
                luaScript = file_util.Read(path);
                print(luaScript);
            end

            lb:Init(luaScript);--]]
--6 热更XLuaMgr.cs 和 XLuaProtobuf.cs
--[[xlua.private_accessible(CS.XLuaMgr)
xlua.hotfix(CS.XLuaMgr, 'Update', function(self)
                    print('<<<<<<<<Update localtest in lua')
                end)--]]
--7 不配置使用反射测试
-- CS.UnityEngine.Debug.Log("Debug is not d config");

--8 list的遍历
--[[
local lst = CS.System.Collections.Generic["List`1[System.String]"]()
lst:Add("Test0");
local count = lst.Count - 1;
for i=0,count,1 
do 
   print(lst[i])
end
--]]

--9 字典序

--local dic = CS.System.Activator.CreateInstance(CS.System.Type.GetType('System.Collections.Generic.Dictionary`2[[System.String, mscorlib],[UnityEngine.Vector3, UnityEngine]],mscorlib'))
--[[dic:Add('a', CS.UnityEngine.Vector3(1, 2, 3))
print(dic:TryGetValue('a'))
local  cur = dic:GetEnumerator();
while cur:MoveNext() do
        local  v =  cur.Current.Value;
        print(v.x);
end--]]

--10 out ref
--C#    public void OutRefTest(out int a,ref int b)
--    {
--        a = 1;
--    }
--[[xlua.hotfix(CS.XLuaTest, 'OutRefTest', function(self,a,b)
                    a = 3;
                    b = 4;
					print('OutRefTest in lua'..a..b);
                    return a,b;
                end)]]--
--11 枚举值 和 整数转换
--print(CS.CEvent.__CastFrom(1));
--print(CS.CEvent.__CastFrom('Update_Serverlist'));

--12 CSReourceManager onLoad
--xlua.hotfix(CS.XLuaTest, 'OutRefTest', function(self,a,b)
--                    a = 3;
--                    b = 4;
--					print('OutRefTest in lua'..a..b);
--                    local res = CS.CSResourceManager.Singleton:AddQueue("800023", CS.ResourceType.Effect, function(res)
--                            local paoEffect = res:GetObjInst();
--                            --cast(paoEffect, typeof(CS.UnityEngine.GameObject));
--                            --paoEffect:AddComponent(typeof(CS.YeManFlagItem));
--                            end, CS.ResourceAssistType.UI);
--                    return a,b;
--                end)
--13 lua中调用delegate
--xlua.private_accessible(CS.XLuaTest);
--xlua.hotfix(CS.XLuaTest, 'CallLuaDelegate', function(self)
--                    --self['&DelegateCallBack'](1);
--                    self.onCallBack(1);--直接调用，和文档里面说的有点出入
--                end)

--12 UnityEngine.Object 判空逻辑 IsNull():用来判断UnityEngine.Object是否被删除。
--[[xlua.hotfix(CS.XLuaTest, 'OutRefTest', function(self,a,b)
                    a = 3;
                    b = 4;
                    CS.StaticUtility.IsNull(print(self:GetComponent('XLuaMgr')))
                end)--]]
--[[               
local v = CS.CSMisc.GetDepth(nil,0,CS.EAvatarType.__CastFrom(10000));
print(v);
--]] 

-- function ResBagItemChangedMessage(buffer)
--     local resData = protobuf.decode('bag.BagItemChangeList', buffer)
--     print('ResBagItemChangedMessage', resData.changeList[1].configId)
-- end

-- local list = CS.System.Collections.Generic["List`1[UnityEngine.GameObject]"]()
-- print(list)

-- require('avater.LuaHeroSpiritInfo')
-- print('localtest')
--]]


--print("XLuaTest 热更去掉,XLuaConfig中不解析XLuaTest所在的程序集")
--[[
xlua.hotfix(CS.XLuaTest, 'Start', function(self)
    self.enabled = false
end)
--]]

--region 测试打包补丁
--util.hotfix_ex(CS.CSEquipInfoV2, 'OnEquipChangeMessageReceived', function(self,ResEquipChange)
--    self:OnEquipChangeMessageReceived(ResEquipChange)
--    local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
--    if mainChatPanel ~= nil and mainChatPanel.btn_bag ~= nil then
--        Utility.ShowPopoTips(mainChatPanel.btn_bag.transform,"人物装备变化===>调用原函数测试补丁",57)
--    end
--end)
--
--xlua.hotfix(CS.CSBagInfoV2, 'UpdateNewItemInfo', function(self,itemList)
--    local mainChatPanel = uimanager:GetPanel("UIMainChatPanel")
--    if mainChatPanel ~= nil and mainChatPanel.btn_bag ~= nil then
--        Utility.ShowPopoTips(mainChatPanel.btn_bag.transform,"新物品===>不调用原函数测试补丁",57)
--    end
--end)
--endregion

--local temp = CS.servantV2.ResServantInfo()
--if temp.expPoolSpecified then
--    local t = CS.Utility_Lua.RefectionGetProperty(temp,typeof(CS.servantV2.ResServantInfo),'expPoolSpecified')
--    print("expPoolSpecified0 = "..tostring(t))
--else
--    local t = CS.Utility_Lua.RefectionGetProperty(temp,typeof(CS.servantV2.ResServantInfo),'expPoolSpecified')
--    print("expPoolSpecified1 = "..tostring(t))
--    CS.Utility_Lua.RefectionSetProperty(temp,typeof(CS.servantV2.ResServantInfo),'expPoolSpecified',true)
--    local t2 = CS.Utility_Lua.RefectionGetProperty(temp,typeof(CS.servantV2.ResServantInfo),'expPoolSpecified')
--    print("expPoolSpecified2 = "..tostring(t2))
--end