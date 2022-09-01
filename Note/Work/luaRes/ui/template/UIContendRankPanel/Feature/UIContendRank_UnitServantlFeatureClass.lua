---@class  UIContendRank_UnitServantlFeatureClass:UIContendRank_UnitFeatureClass 夺榜 灵兽榜
local UIContendRank_UnitServantlFeatureClass = {}
setmetatable(UIContendRank_UnitServantlFeatureClass, luaclass.UIContendRank_UnitFeatureClass)

function UIContendRank_UnitServantlFeatureClass:SetTemplate()
    self:RunBaseFunction("SetTemplate")
    if self.unitTbl:GetServantGrid() ~= nil and self.unitTbl.servantRankInfo ~= nil then
        self:SetServantList()
        self.unitTbl:GetServantGrid().gameObject:SetActive(self:IsShowServantList())
    end
end

function UIContendRank_UnitServantlFeatureClass:SetServantList()
    local list = self.unitTbl.servantRankInfo.servants
    self.unitTbl:GetServantGrid().MaxCount = #list
    local id = self.unitTbl.servantRankInfo.roleId
    for i = 0, #list - 1 do
        local info = list[i + 1]
        if info ~= nil then
            local go = CS.Utility_Lua.GetComponent(self.unitTbl.servantGrid.controlList[i], "GameObject")
            if go then
                local icon = CS.Utility_Lua.GetComponent(go.transform:Find("Servant/head"), "UISprite")
                local lv = CS.Utility_Lua.GetComponent(go.transform:Find("Servant/lv"), "UILabel")
                if lv ~= nil and not CS.StaticUtility.IsNull(lv) then
                    lv.text = tostring(info.level)
                end
                if icon ~= nil and not CS.StaticUtility.IsNull(icon) then
                    local isFind, monsterInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(info.servantCfgId)
                    if isFind then
                        icon.spriteName = monsterInfo.head
                    end
                end
                local otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_HANMANG
                if info.type == luaEnumServantType.LX then
                    otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_LUOXING
                elseif info.type == luaEnumServantType.TC then
                    otherServantBtnSubType = LuaEnumOtherPlayerBtnSubtype.SERVANT_TIANCHENG
                end
                CS.UIEventListener.Get(go).onClick = nil
                CS.UIEventListener.Get(go).onClick = function(go)
                    CS.CSScene.MainPlayerInfo.OtherPlayerInfo:ReqOtherPlayerMsg(id, LuaEnumOtherPlayerBtnType.SERVANT, otherServantBtnSubType)
                end
            end
        end
    end
end

function UIContendRank_UnitServantlFeatureClass:TrySetPos()
    self:RunBaseFunction("TrySetPos")

    if self.unitTbl:GetServantGrid() ~= nil then
        local origionPos = self.unitTbl:GetServantGrid().transform.localPosition
        local posx = CS.Cfg_ContendRankTableManager.Instance:GetComponentPos(self.unitTbl.rankConfigId, LuaRankComponentSystem.servant, self.unitTbl.isMain)
        self.unitTbl:GetServantGrid().transform.localPosition = CS.UnityEngine.Vector3(posx, origionPos.y, 0)
    end
end

--region overrid

--是否需要显示灵兽列表5
function UIContendRank_UnitServantlFeatureClass:IsShowServantList()
    self.unitTbl:SetActiveState(LuaRankComponentSystem.servant, self.unitTbl:GetServantGrid().gameObject)
    return true
end

--endregion

return UIContendRank_UnitServantlFeatureClass