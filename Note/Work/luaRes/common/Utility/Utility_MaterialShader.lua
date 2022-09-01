---@type Utility
local Utility = Utility

--region 用来处理神力的特效材质
Utility.MaterialBlock = nil
--MaterialPropertyBlock block = new CS.UnityEngine.MaterialPropertyBlock();
---@param obj GameObject 特效的物体
---@param index LuaEquipmentItemType 道具的穿戴下标,注意,这个下标同时只能存在一个,不然可能会出现效果混乱的情况
---@param level number 套装的等级
function Utility.LoadSLMaterial(obj, type, index, level, textureName)
    if(Utility.MaterialBlock == nil) then
        Utility.MaterialBlock = CS.UnityEngine.MaterialPropertyBlock();
    end
    ---@type CS.Top_CSMatCollect
    local matCollect = CS.Utility_Lua.GetComponent(obj.transform, "Top_CSMatCollect")
    if(matCollect == nil) then
        return;
    end
    --local factor = Mathf.Pow(2,intensity);  math.p
    local factor = 1
    for i = 0, matCollect.matList.Count-1 do
        if (i >= matCollect.renderList.Count) then
            return
        end
        local renderer = matCollect.renderList[i];
        local material = matCollect.matList[i];
        --Material mat = null;
        local mat = CS.CSScene.getShareMaterial(material, CS.EShareMatType.ObservationModel, material, index);
        renderer.sharedMaterial = mat
        --renderer:GetPropertyBlock(Utility.MaterialBlock)
        --Utility.MaterialBlock:SetColor("_TintColor", CS.UnityEngine.Color(255, 0, 100, 255));
        --renderer:SetPropertyBlock(Utility.MaterialBlock)
        if(level == 1) then
            -- 164 206 246
            mat:SetColor("_TintColor", CS.UnityEngine.Color( 164*factor / 255, 206*factor / 255, 246*factor / 255, factor));
        elseif(level == 2) then
            mat:SetColor("_TintColor", CS.UnityEngine.Color( 1*factor, 1*factor, 0, 1));
        elseif(level == 3) then
            mat:SetColor("_TintColor", CS.UnityEngine.Color( 0, 1*factor, 0, 1));
        elseif(level == 4) then
            mat:SetColor("_TintColor", CS.UnityEngine.Color( 1*factor, 0, 1*factor, 1));
        elseif(level == 5) then
            mat:SetColor("_TintColor", CS.UnityEngine.Color( 1*factor, 0, 0, 1));
        end

        mat.renderQueue = 3070

        local r = CS.CSResourceManager.Singleton:AddQueue(textureName, CS.ResourceType.Texture, function(res)
            if (mat == nil or res == nil) then
                return
            end
            local tex = res.MirrorObj
            if (tex == nil) then
                return;
            end
            mat:SetTexture("_MaskTex", tex)
            obj:SetActive(true)
        end, CS.ResourceAssistType.UI);
    end
end

--endregion

---设置特效颜色
---@param obj Top_CSMatCollect
---@param color UnityEngine.Color
function Utility.SetParticleColor(obj,color)
    if CS.StaticUtility.IsNull(obj) or color == nil then
        return
    end
    if CS.Utility_Lua.IsTypeEqual(color:GetType(), typeof(CS.UnityEngine.Color)) == false then
        return
    end
    local CSMatCollect = obj
    if CS.Utility_Lua.IsTypeEqual(obj:GetType(), typeof(CS.Top_CSMatCollect)) == false then
        CSMatCollect = luaclass.UIRefresh:GetCurComp(obj, "", "Top_CSMatCollect")
    end
    CSMatCollect:SetParticleSystemColor(color);
    --local renderList = CSMatCollect.renderList
    --local length = renderList.Count
    --for k = 0,length - 1 do
    --    ---@type UnityEngine.ParticleSystem
    --    local particleSystem = luaclass.UIRefresh:GetCurComp(renderList[k], "", "ParticleSystem")
    --    particleSystem.startColor = color
    --end
end

return