local UIGMModelTemplates = {}

function UIGMModelTemplates:InitComponents()
    self.Btn = self:Get("Exhibition/Btn", "Top_UIGridContainer")
    self.root = self:Get("Exhibition/root", "Transform")
    self.modelName = self:Get("Exhibition/ModelName", "UILabel")

    self.localScale = self:Get("Exhibition/Select/localScale", "Top_UISlider")
    self.localEulerAngles = self:Get("Exhibition/Select/localEulerAngles", "Top_UISlider")

    self.List = self:Get("FindList/ScroolView/List", "Top_UIGridContainer")

    self.ID_Input = self:Get("IDFind/ID_Input", "Top_UIInput")
    self.btn_find = self:Get("IDFind/btn_find", "GameObject")
    self.btn_loadallab = self:Get("LoadAllAbParent/btn_loadallab", "GameObject")
    self.btn_openWriteAb = self:Get("LoadAllAbParent/btn_openWriteAb", "GameObject")
    UIGMModelTemplates.btn_openWriteAbLabel = self:Get("LoadAllAbParent/btn_openWriteAb/Label", "Top_UILabel")
    UIGMModelTemplates.btn_find_label = self:Get("LoadAllAbParent/btn_loadallab/lababdesc", "Top_UILabel")
    UIGMModelTemplates.LoadAllAbParent = self:Get("LoadAllAbParent","Transform")
    ---@type Top_UITexture
    UIGMModelTemplates.AbTexture = self:Get("LoadAllAbParent/AbTexture","Top_UITexture")
    ---@type Top_UISprite
    UIGMModelTemplates.AbSprite = self:Get("LoadAllAbParent/AbSprite","Top_UISprite")
    --btn_resLoadCount
    self.btn_resLoadCount = self:Get("LoadAllAbParent/btn_resLoadCount", "GameObject")
    UIGMModelTemplates.btn_resLoadCountLabel = self:Get("LoadAllAbParent/btn_resLoadCount/Label", "Top_UILabel")
end
function UIGMModelTemplates:InitOther()
    self.NowSelectName = 0
    UIGMModelTemplates.Self = self
    self.ModelObj = nil
    CS.UIEventListener.Get(self.btn_find.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_find.gameObject).OnClickLuaDelegate = self.FindModel
    CS.UIEventListener.Get(self.btn_loadallab.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_loadallab.gameObject).OnClickLuaDelegate = self.LoadAllAb
    CS.UIEventListener.Get(self.btn_openWriteAb.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_openWriteAb.gameObject).OnClickLuaDelegate = self.OpenWriteAb
    CS.UIEventListener.Get(self.btn_resLoadCount.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_resLoadCount.gameObject).OnClickLuaDelegate = self.ResLoadCount
    --btn_openWriteAb
    CS.UIEventListener.Get(self.localScale.gameObject).onDragStart = self.OnDragStart
    CS.UIEventListener.Get(self.localScale.gameObject).onDrag = self.OnDrag

    CS.UIEventListener.Get(self.localEulerAngles.gameObject).onDragStart = self.OnDragStart
    CS.UIEventListener.Get(self.localEulerAngles.gameObject).onDrag = self.OnDrag
end

function UIGMModelTemplates:Show(pos)
    self.go:SetActive(true)
    self:RefreshFindList()
    self:RefreshAnimList()
end

function UIGMModelTemplates:Hide()
    self.go:SetActive(false)
end

function UIGMModelTemplates:Init()
    self:InitComponents()
    self:InitOther()
end

function UIGMModelTemplates:RefreshFindList()
    local modelInfoDic = CS.CSModelExhibition.Instance.ModelInfoDic
    self.List.MaxCount = modelInfoDic.Count
    local index = 0
    for i, v in pairs(modelInfoDic) do
        local item = self.List.controlList[index].gameObject
        CS.Utility_Lua.GetComponent(item.transform:Find("Label").gameObject, "UILabel").text = i
        CS.UIEventListener.Get(item.gameObject).onClick = function()
            UIGMModelTemplates.Self.modelName.text = v.Name
            UIGMModelTemplates.Self.localScale.value = 1
            UIGMModelTemplates.Self.localEulerAngles.value = 0.5
            self.NowSelectName = i
            self:ShowModel()
        end
        index = index + 1
    end
end
function UIGMModelTemplates:RefreshAnimList()
    local ModelTypeInfoList = CS.CSModelExhibition.Instance.ModelTypeInfoList
    self.Btn.MaxCount = ModelTypeInfoList.Count
    local index = 0
    for i = 0, ModelTypeInfoList.Count - 1 do
        local v = ModelTypeInfoList[i]
        local item = self.Btn.controlList[index].gameObject
        CS.Utility_Lua.GetComponent(item.transform:Find("Label").gameObject, "UILabel").text = v.Name
        CS.UIEventListener.Get(item.gameObject).onClick = function()
            self:SetAnim(v.Mo)
        end
        index = index + 1
    end
end

function UIGMModelTemplates:FindModel()
    self.NowSelectName = self.ID_Input.value
    self:ShowModel()
end

function UIGMModelTemplates:ResLoadCount()
    if CS.CSInterfaceSingleton.Unity_Editor.CSResourceManager_maxSyncLoadingNum <= -1 then
        CS.CSInterfaceSingleton.Unity_Editor.CSResourceManager_maxSyncLoadingNum = 10
    end
    CS.CSInterfaceSingleton.Unity_Editor.CSResourceManager_maxSyncLoadingNum = CS.CSInterfaceSingleton.Unity_Editor.CSResourceManager_maxSyncLoadingNum - 1
    UIGMModelTemplates.btn_resLoadCountLabel.text = tostring(CS.CSInterfaceSingleton.Unity_Editor.CSResourceManager_maxSyncLoadingNum)
end

function UIGMModelTemplates:OpenWriteAb()
    if CS.CSResourceWWW.WriteResLoad == false then
        CS.CSResourceWWW.WriteResLoad = true
        CS.CSResourceWWW.DeleteABDebugInfo()
        UIGMModelTemplates.btn_openWriteAbLabel.text = 'true'
    else
        CS.CSResourceWWW.WriteResLoad = false
        UIGMModelTemplates.btn_openWriteAbLabel.text = 'false'
    end
end
function UIGMModelTemplates:LoadAllAb()
    self:LoadAllABToShow()
end
local fileList
function UIGMModelTemplates:LoadAllABToShow()
    CS.UnityEngine.Debug.Log("LoadAllABToShow")
    CS.UnityEngine.Debug.Log("persistentDataPath="..CS.BuildPath._Instance.FilePrePath)

    --local path = CS.BuildPath._Instance.FilePrePath..'/Model'
    local path = CS.BuildPath._Instance.FilePrePath

    if CS.System.IO.Directory.Exists(path) == true then
        CS.UnityEngine.Debug.Log("persistentDataPath Exists="..CS.BuildPath._Instance.FilePrePath)
    else
        CS.UnityEngine.Debug.Log("persistentDataPath not exists="..CS.BuildPath._Instance.FilePrePath)
    end
    fileList = CS.System.Collections.Generic["List`1[System.String]"]()
    local excludeDirList = CS.System.Collections.Generic["List`1[System.String]"]()
    excludeDirList:Add('/Map')
    excludeDirList:Add('/luaRes')
    excludeDirList:Add('/Android')
    excludeDirList:Add('/Table')
    excludeDirList:Add('/Audio')
    excludeDirList:Add('/ResourceRes')
    UIGMModelTemplates.DeleteABDebugInfo()
    --CS.FileUtility.GetDeepAssetPaths(path,fileList,'',true, false, false, "",excludeDirList)
    Utility.GetDeepAssetPaths(path,fileList,'',excludeDirList)
    UIGMModelTemplates.btn_find_label.text = "0/"..fileList.Count

    local co = coroutine.create(UIGMModelTemplates.SyncLoad)
    coroutine.resume(co)
end

function UIGMModelTemplates.SyncLoad()
    local index = 0
    local debugInfo = ''
    UIGMModelTemplates.AbTexture.gameObject:SetActive(false)
    UIGMModelTemplates.AbTexture.gameObject:SetActive(true)
    for i=0,fileList.Count-1 do
        UIGMModelTemplates.btn_find_label.text = index.."/"..fileList.Count
        index=index+1
        ---@type System.String
        local fPath = fileList[i]
        debugInfo = debugInfo..index..'.'..fPath..' begin\r\n'
        UIGMModelTemplates.WriteABDebugInfo(debugInfo)
        --CS.UnityEngine.Debug.Log('fPath begin = '..fPath)
        local obj,asestbundle,strs = UIGMModelTemplates.LoadAB(fPath)
        local instGO = nil
        if obj ~= nil then
            try {
            main = function()
            if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.UnityEngine.Texture) )
                    or CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.UnityEngine.Texture2D)) then
            UIGMModelTemplates.AbTexture.mainTexture = obj
            UIGMModelTemplates.AbTexture:MakePixelPerfect()
            --UIGMModelTemplates.AbTexture.gameObject:SetActive(false)
            --UIGMModelTemplates.AbTexture.gameObject:SetActive(true)


            --UIGMModelTemplates.AbTexture:UpdateInit()
            --CS.UnityEngine.Debug.Break()
            elseif CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.UnityEngine.GameObject)) then

            ---@type UnityEngine.GameObject
            local go = obj
            local atlas =go:GetComponent(typeof(CS.Top_UIAtlas))
            if atlas ~= nil then

            if atlas.spriteList.Count >0 then
            UIGMModelTemplates.AbSprite.atlas = atlas
            UIGMModelTemplates.AbSprite.spriteName =atlas.spriteList[0]
            UIGMModelTemplates.AbSprite:MakePixelPerfect()
            UIGMModelTemplates.AbSprite.gameObject:SetActive(false)
            UIGMModelTemplates.AbSprite.gameObject:SetActive(true)

                local comps = go:GetComponents(typeof(CS.UnityEngine.Component))
                for i=0,comps.Length - 1 do
                    if CS.StaticUtility.IsNull(comps[i]) == true then
                        CS.UnityEngine.Debug.LogError('有脚本丢失 = '..fPath)
                    end
                end
            --CS.UnityEngine.Debug.Break()
            end
            --if atlas.name == 'tc' then
            --    CS.UnityEngine.Debug.Break()
            --end
            else
            ---@type UnityEngine.GameObject
            instGO = CS.UnityEngine.Object.Instantiate(obj)
            CS.NGUITools.SetLayer(instGO,5)
            ---@type CSMatCollect
            local matCollect = instGO:GetComponent(typeof(CS.CSMatCollect))
            if matCollect ~= nil then
            matCollect:InitAwake()
            end
            instGO.transform.parent = UIGMModelTemplates.LoadAllAbParent
            instGO.transform.localPosition = CS.UnityEngine.Vector3.zero
            instGO.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0,180,0)
            instGO.transform.localScale = CS.UnityEngine.Vector3(100,100,100)
                if strs ~= nil and strs.Length == 1 then
                    local meshColect = instGO:GetComponent(typeof(CS.CSMeshCollect))
                    if CS.StaticUtility.IsNull(meshColect) == false then
                            if meshColect.skinnedMeshInfos ~= nil and meshColect.skinnedMeshInfos.Length == 1 then
                                CS.UnityEngine.Debug.LogError('模型Mesh没有优化 = '..fPath)
                            end
                            if meshColect.meshFilterMeshInfos ~= nil and meshColect.meshFilterMeshInfos.Length ==1 then
                                CS.UnityEngine.Debug.LogError('模型Mesh没有优化 = '..fPath)
                            end
                        --CS.UnityEngine.Debug.LogError('模型Mesh没有优化 = '..fPath)
                    end
                end
                --local meshColect = instGO:GetComponent(typeof(CS.CSMeshCollect))
                --if meshColect ~= nil then
                --    if meshColect.skinnedMeshInfos ~= nil and meshColect.skinnedMeshInfos.Length == 1 then
                --        if meshColect.skinnedMeshInfos[0].meshes[0] ~= nil then
                --            CS.UnityEngine.Debug.LogError('模型Mesh没有优化 = '..fPath)
                --        end
                --    end
                --    if meshColect.meshFilterMeshInfos ~= nil and meshColect.meshFilterMeshInfos.Length == 1 then
                --        if meshColect.meshFilterMeshInfos[0].meshes[0] ~= nil then
                --            CS.UnityEngine.Debug.LogError('模型Mesh没有优化 = '..fPath)
                --        end
                --    end
                --end
                local bip001 = instGO.transform:Find("Bip001")
                if CS.StaticUtility.IsNull(bip001) == false then
                    CS.UnityEngine.Debug.LogError('模型骨骼点没有优化 = '..fPath)
                end
                local comps = instGO:GetComponents(typeof(CS.UnityEngine.Component))
                for i=0,comps.Length - 1 do
                    if CS.StaticUtility.IsNull(comps[i]) == true then
                        CS.UnityEngine.Debug.LogError('有脚本丢失 = '..fPath)
                    end
                end
            end
            else
            CS.UnityEngine.Debug.LogWarning('没有找到处理的类型 = '..fPath..' '..obj:GetType():ToString())
            end
            end,
            catch = function(errors)
            CS.UnityEngine.Debug.LogError("catch : " .. errors)
            end
            }


            yield_return(CS.NGUIAssist.GetWaitForSeconds(0.02))
            if instGO ~= nil then
            CS.UnityEngine.Object.Destroy(instGO)
            end
            instGO = nil
            if asestbundle ~= ni1 then
            asestbundle:Unload(true)
            end
            --UIGMModelTemplates.AbTexture.gameObject:SetActive(false)
            --UIGMModelTemplates.AbSprite.gameObject:SetActive(false)
            debugInfo = debugInfo..index..'.'..fPath..' end\r\n'
            UIGMModelTemplates.WriteABDebugInfo(debugInfo)
            --CS.UnityEngine.Debug.Log('fPath end = '..fPath)
            end
        --if fPath:Contains('/Map/')  == false or  fPath:Contains('/Android/') == false
        --        or  fPath:Contains('/luaRes/') == false
        --then
        --
        --end
    end
    --UIGMModelTemplates.WriteABDebugInfo(debugInfo)
    CS.UnityEngine.Debug.Log(debugInfo)
end
UIGMModelTemplates.HasLoadedTable = {}
function UIGMModelTemplates.LoadAB(abPath)
    ---@type CSResourceWWW
    local resPath = abPath
    resPath = string.gsub(resPath,CS.BuildPath._Instance.FilePrePath,CS.BuildPath._Instance.FilePrePath..'/')
    resPath = "file://"..resPath
    --CS.UnityEngine.Debug.LogError(resPath)
    local hasExsitRes = CS.CSResourceManager.Instance:GetRes(resPath)

    if hasExsitRes ~= nil then
        return hasExsitRes.MirrorObj
    end
    ---@type UnityEngine.AssetBundle
    local asestbundle = CS.UnityEngine.AssetBundle.LoadFromFile(abPath);
    if asestbundle == nil then
        return nil
    end
    local strs = asestbundle:GetAllAssetNames();

    try {
        main = function()
            if string.find(strs[0],'.') == nil then
                CS.UnityEngine.Debug.LogError(resPath..' assetname is not corret = '..strs[0])
            else
                local fileName = string.lower(CS.FileUtility.GetABFileName(resPath))
                local fileNameInAb = CS.FileUtility.GetFileName(strs[0])
                --if fileName ~= fileNameInAb then
                --    CS.UnityEngine.Debug.LogError(resPath..' 文件名不匹配不要直接修改ab文件名 = '..strs[0])
                --end
                if UIGMModelTemplates.HasLoadedTable[fileNameInAb] == nil then
                    UIGMModelTemplates.HasLoadedTable[fileNameInAb] = resPath
                else
                    CS.UnityEngine.Debug.LogError(resPath..' '..UIGMModelTemplates.HasLoadedTable[fileNameInAb]..' assetname重名 = '..fileNameInAb)
                end
            end

        end,
        catch = function(error)
            if strs[0]~= 'assetbundlemanifest' then
                CS.UnityEngine.Debug.LogError(error..' '..resPath..' '..strs[0]);
            end
        end
    }

    local obj =  asestbundle:LoadAsset(strs[0])
    --asestbundle:Unload(false)
    return obj,asestbundle,strs
end

function UIGMModelTemplates.DeleteABDebugInfo()
    local path = CS.BuildPath._Instance.FilePrePath..'/AbCrashDebug.txt'
    if CS.System.IO.File.Exists(path) then
        CS.System.IO.File.Delete(path)
    end
end

function UIGMModelTemplates.WriteABDebugInfo(debugInfo)
    local path = CS.BuildPath._Instance.FilePrePath..'/AbCrashDebug.txt'
    CS.FileUtility.DetectCreateDirectory(path)
    CS.FileUtility.Write(path,debugInfo,false)
end

function UIGMModelTemplates:ShowModel()
    CS.CSModelExhibition.Instance:LoadModel(self.NowSelectName, self.root);
end
function UIGMModelTemplates:SetAnim(anim)
    CS.CSModelExhibition.Instance:PlayAnim(anim);
end

function UIGMModelTemplates:OnDragStart()
    UIGMModelTemplates.Self.ModelObj = CS.CSModelExhibition.Instance:GetModelObj()
end

function UIGMModelTemplates:OnDrag()
    UIGMModelTemplates.Self.SlideMove()
end

function UIGMModelTemplates.SlideMove()
    if UIGMModelTemplates.Self.ModelObj == nil then
        return
    end
    local scaleValue = UIGMModelTemplates.Self.localScale.value
    local eulerAnglesValue = UIGMModelTemplates.Self.localEulerAngles.value
    UIGMModelTemplates.Self.ModelObj.localScale = CS.UnityEngine.Vector3(200 * scaleValue, 200 * scaleValue, 200 * scaleValue)
    UIGMModelTemplates.Self.ModelObj.localEulerAngles = CS.UnityEngine.Vector3(0, 360 * eulerAnglesValue, 0)
end

function UIGMModelTemplates:OnDestroy()
    UIGMModelTemplates.Self = nil
end

return UIGMModelTemplates