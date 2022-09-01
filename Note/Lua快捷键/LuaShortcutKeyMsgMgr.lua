---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by admin.
--- DateTime: 2021/8/4 15:17
---
---@class LuaShortcutKeyMsgMgr:luaclass
local LuaShortcutKeyMsgMgr = {}
function LuaShortcutKeyMsgMgr:Init()
    self:AddShortcutKeysInTbl()
    self:BindMsg()

    local a =luaclass. LuaShortcutKeyMgr.shortCutKeysInfoDic
end

function LuaShortcutKeyMsgMgr:BindMsg()
--[[    --region sample
    luaEventManager.BindCallback(LuaCEvent.Shortcut_CAG, function()
        print("CSG")
    end)
    luaEventManager.BindCallback(LuaCEvent.Shortcut_CloseGame, function()
        print("退游")
    end)
    luaEventManager.BindCallback(LuaCEvent.Shortcut_CSA, function()
        print("CSA")
        print(LuaShortcutKeyMgr.GetShortcutById(LuaCEvent.Shortcut_CSA))
    end)
    --endregion]]
    luaEventManager.BindCallback(LuaCEvent.Shortcut_Bag, LuaShortcutKeyMsgMgr.OnShortcut_Bag)
    luaEventManager.BindCallback(LuaCEvent.Shortcut_Map, LuaShortcutKeyMsgMgr.OnShortcut_Map)
end

function LuaShortcutKeyMsgMgr:AddShortcutKeysInTbl()
--[[    --region sample
    --region 详细配置
    ---@type LuaShortcutKeyItem
    local item = luaclass.LuaShortcutKeyItem:New()
    item. inputTypeEnum = LuaInputTypeEnum.None
    item.keyCodes = { CS.UnityEngine.KeyCode.RightControl, CS.UnityEngine.KeyCode.LeftControl }
    ---@type LuaShortcutKeyItem
    local item1 = luaclass.LuaShortcutKeyItem:New()
    item1. inputTypeEnum = LuaInputTypeEnum.None
    item1. keyCodes = { CS.UnityEngine.KeyCode.RightAlt, CS.UnityEngine.KeyCode.LeftAlt }
    ---@type LuaShortcutKeyItem
    local item2 = luaclass.LuaShortcutKeyItem:New()
    item2. inputTypeEnum = LuaInputTypeEnum.None
    item2. keyCodes = { CS.UnityEngine.KeyCode.G }
    ---@type LuaShortcutKeyInfo
    local info1 = luaclass.LuaShortcutKeyInfo:New()
    info1.id = LuaCEvent.Shortcut_CAG
    info1.currKeyCodes = { item, item1, item2 }
    info1.Name = "Ctrl + Shift + G"
    --endregion
    --region 简易配置
    ---@type table<number,LuaShortcutKeyInfo>
    gameMgr:GetShortcutMgr().AddShortcut(info1)

    local a = { { CS.UnityEngine.KeyCode.RightControl, CS.UnityEngine.KeyCode.LeftControl },
                { CS.UnityEngine.KeyCode.RightShift, CS.UnityEngine.KeyCode.LeftShift },
                { CS.UnityEngine.KeyCode.F1 }
    }
    gameMgr:GetShortcutMgr().AddShortcutSimple(a, LuaCEvent.Shortcut_CSA, "Ctrl +Shift+A")
    --endregion
    --endregion]]
    ---@type table<number,TABLE.cfg_shortcutkey>
    local shortcutsTbl = clientTableManager.cfg_shortcutkeyManager.dic
    if (not Utility.IsNullTable(shortcutsTbl)) then
        for i, v in pairs(shortcutsTbl) do
            local keyStr = v:GetParameter()
            if (not Utility.IsNullTable(v) and not Utility.IsNilOrEmptyString(keyStr)) then
                ---@type LuaShortcutKeyInfo
                local shortcutKeys = luaclass.LuaShortcutKeyInfo:New()
                shortcutKeys.currKeyCodes = {}
                local keyStrSplitArr = string.Split(keyStr, '&')
                for i = 1, #keyStrSplitArr do

                    local keyItemStrSplitArr = string.Split(keyStrSplitArr[i], '#')
                    local keyItem = luaclass.LuaShortcutKeyItem:New()
                    keyItem.keyCodes = {}
                    keyItem.inputTypeEnum = LuaInputTypeEnum.None
                    for j = 1, #keyItemStrSplitArr do
                        ---@type LuaShortcutKeyItem
                        table.insert(keyItem.keyCodes, keyItemStrSplitArr[j])
                    end
                    table.insert(shortcutKeys.currKeyCodes, keyItem)
                end
                shortcutKeys.name = v:GetName()
                ---280000 是LuaCEvent快捷键信息开头
                shortcutKeys.id = 280000 + v:GetId()

                local result= gameMgr:GetShortcutMgr().AddShortcut(shortcutKeys)
                if(not result.isSuccess) then
                    print("Error:" .. result.result)
                end
            end
        end
    end
end

function LuaShortcutKeyMsgMgr:AddShortcutKeyDynamic()

end
--region bind msg
function LuaShortcutKeyMsgMgr.OnShortcut_Bag()
    local UIMainChatPanel= uimanager:GetPanel("UIMainChatPanel")
    if(UIMainChatPanel== nil) then
        return
    end
    ---UIMainChatPanel.OnBagButtonClicked() 原方法
    if luaEventManager.HasCallback(LuaCEvent.MainChatPanel_BtnBag) then
        luaEventManager.DoCallback(LuaCEvent.MainChatPanel_BtnBag)
    else
        if CS.CSMissionManager.Instance:IsCompletedAssignMainTask(Utility.GetOpenBagPanelShowRecycleBtnTaskId()) then
            --uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.Normal)
            uiTransferManager:TransferToPanel(LuaEnumTransferType.Bag_Base);
        else
            uimanager:CreatePanel("UIBagPanel", nil, LuaEnumBagType.UnFinishFirstMission)
        end
        uimanager:ClosePanel("UIDailyMissionAwardPanel")
    end
    --先暂时用这个字段判定是否开启GM
    if (CS.SDKManager.PlatformData.IsOpenTranslate or CS.Constant.IsWhiteIp) then
        local UIMainChatPanel= uimanager:GetPanel("UIMainChatPanel")
        --GM命令
        if (UIMainChatPanel.GMCount == 0) then
            local co = coroutine.create(UIMainChatPanel.ResetGMCount)
            coroutine.resume(co)
        end
        UIMainChatPanel.GMCount = UIMainChatPanel.GMCount + 1
        if (UIMainChatPanel.GMCount == 3) then
            uimanager:CreatePanel("UIGMToolPanel")
            return
        end
    end
end

function LuaShortcutKeyMsgMgr.OnShortcut_Map()
    local UIMainChatPanel= uimanager:GetPanel("UIMainChatPanel")
    if(UIMainChatPanel== nil) then
        return
    end
    --UIActivitiesPanel.OnMapBtnClick
    uimanager:CreatePanel("UIMapPanel")
end
--endregion
return LuaShortcutKeyMsgMgr