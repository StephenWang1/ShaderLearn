---@class LuaHead_Character:LuaHead_Avatar 人物头顶
local LuaHead_Character = {}
setmetatable(LuaHead_Character, luaclass.LuaHead_Avatar)
--GetSceneUIAtlas

---排序Head组件
---@protected
function LuaHead_Character:SortHead()
    self:RunBaseFunction("SortHead")

end



--region 联盟icon

function LuaHead_Character:RefresgLeagueIcon()
    if self:IsShowLeagueIcon() then
        if self.leagueIcon ~= nil and not CS.StaticUtility.IsNull(self.leagueIcon.gameObject) then
            self:SetLeagueIcon()
        else
            self:LoadLeagueIconAtlas()
        end
    else
        if self.leagueIcon ~= nil and not CS.StaticUtility.IsNull(self.leagueIcon.gameObject) then
            self.leagueIcon.gameObject:SetActive(false)
        end
    end

    self:SortHead()
end

function LuaHead_Character:LoadLeagueIconAtlas()
    local csRes = CS.CSResourceManager.Singleton:AddQueue('10222', CS.ResourceType.UIEffect, nil, CS.ResourceAssistType.UI)
    local leagueIconLoadedCallBack = function(res)
        self:CreatLeagueIcon(res)
    end
    if csRes.IsDone then
        leagueIconLoadedCallBack(csRes)
    else
        csRes.onLoaded:AddFrontCallBack(leagueIconLoadedCallBack)
    end
end

function LuaHead_Character:CreatLeagueIcon(res)
    if self:GetCSAvatar() == nil or self:GetCSHead().Top == nil then
        return
    end

    local go = res:GetObjInst()
    local atlas = CS.Utility_Lua.GetComponent(go.transform, "Top_UIAtlas")
    if atlas == nil then
        atlas = go:AddComponent('Top_UIAtlas')
    end

    go.transform.parent = self:GetCSAvatar().Top
    go.transform.localPosition = CS.UnityEngine.Vector3.zero
    go.transform.localScale = CS.UnityEngine.Vector3(100, 100, 100)
    self.leagueIcon = go:AddComponent('CSSprite')

    self.leagueIcon.Atlas = atlas
    CS.CSGameManager.Instance:SetAtlasRenderQueue(atlas)
    self.leagueIcon.MainMaterial = atlas.spriteMaterial

    self:SetLeagueIcon()
end

function LuaHead_Character:SetLeagueIcon()
    --self.leagueIcon.SpriteName = ''
end

function LuaHead_Character:ClearLeagueIcon()
    if self.leagueIcon ~= nil then
        CS.UnityEngine.Object.Destroy(self.leagueIcon.gameObject)
        self.leagueIcon = nil
    end
end

--endregion

--region switchController

---是否显示联盟icon
function LuaHead_Character:IsShowLeagueIcon()
    if self:GetLuaAvatar() ~= nil then
        return self:GetLuaAvatar().ServantAvaterType == CS.EServantAvaterType.Cultivate
    end
    return true
end

--endregion

function LuaHead_Character:Destroy()
    self:RunBaseFunction('Destroy')
    self:ClearLeagueIcon()
end

return LuaHead_Character