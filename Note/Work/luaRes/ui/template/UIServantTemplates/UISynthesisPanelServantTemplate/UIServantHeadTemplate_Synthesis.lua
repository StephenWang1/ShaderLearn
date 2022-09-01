local UIServantHeadTemplate_Synthesis = {};

setmetatable(UIServantHeadTemplate_Synthesis, luaComponentTemplates.UIServantInfoTemplate)

function UIServantHeadTemplate_Synthesis:OnPlayerClickHead()
    self:RunBaseFunction("OnPlayerClickHead");
    if(self.info ~= nil and self.info.servantEgg ~= nil) then
        --gameMgr:GetPlayerDataMgr():GetSynthesisMgr():AddToShieldSynthesisRedList(self.info.servantEgg.itemId)
        --gameMgr:GetLuaRedPointManager():AddRemoveRedItem(self.info.servantEgg.itemId);
        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnServantHeadClicked, self.info.servantEgg)
        --self:CallRedPoint();
    else
        luaEventManager.DoCallback(LuaCEvent.Synthesis_OnServantHeadClicked, nil)
    end
end

function UIServantHeadTemplate_Synthesis:CallRedPoint()
    --local callKeyName1 = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantRedPointName(self.index);
    --if(callKeyName1 ~= nil) then
    --    local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(callKeyName1);
    --    if(key ~= nil) then
    --        gameMgr:GetLuaRedPointManager():CallRedPoint(key);
    --    end
    --end
    --local callKeyName2 = gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantMagicWeaponSynthesisRedPointName(self.index);
    --if(callKeyName2 ~= nil) then
    --    local key = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(callKeyName2);
    --    if(key ~= nil) then
    --        gameMgr:GetLuaRedPointManager():CallRedPoint(key);
    --    end
    --end
end

function UIServantHeadTemplate_Synthesis:OnEnable()
    self:RunBaseFunction("OnEnable");
    self:CallRedPoint();
end

return UIServantHeadTemplate_Synthesis;