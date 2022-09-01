---GM工具分面板-组件管理面板
---分为3块:
---1.左侧检索
---2.左侧列表
---3.右侧组件详情(增加组件控制功能-当前控制坐标,旋转,缩放)
local UIGMPanel_ComponentManager = {}
UIGMPanel_ComponentManager.DataList = {}

function UIGMPanel_ComponentManager:InitComponents()
    --region 左侧列表
    self.MainList = self:Get("LeftPanel/FrameGroup/PanelFrame/MainList", "Top_UIGridContainer")
    self.ItemMold = self:Get("LeftPanel/FrameGroup/PanelFrame/Item", "GameObject")
    --endregion
    --region Transform组件
    self.headline = self:Get("RightPanel/Transform/headline", "Top_UILabel")
    self.btn_Active = self:Get("RightPanel/Transform/headline/Active", "GameObject")
    self.btn_Active_sign = self:Get("RightPanel/Transform/headline/Active/sign", "GameObject")
    ---位置
    self.P_X_Label = self:Get("RightPanel/Transform/P/Chat Input", "Top_UIInput")
    self.P_Y_Label = self:Get("RightPanel/Transform/P/Chat InputY", "Top_UIInput")
    self.P_Z_Label = self:Get("RightPanel/Transform/P/Chat InputZ", "Top_UIInput")
    ---旋转
    self.R_X_Label = self:Get("RightPanel/Transform/R/Chat Input", "Top_UIInput")
    self.R_Y_Label = self:Get("RightPanel/Transform/R/Chat InputY", "Top_UIInput")
    self.R_Z_Label = self:Get("RightPanel/Transform/R/Chat InputZ", "Top_UIInput")
    ---缩放
    self.S_X_Label = self:Get("RightPanel/Transform/S/Chat Input", "Top_UIInput")
    self.S_Y_Label = self:Get("RightPanel/Transform/S/Chat InputY", "Top_UIInput")
    self.S_Z_Label = self:Get("RightPanel/Transform/S/Chat InputZ", "Top_UIInput")

    ---设置选中物体transform按钮
    self.confirm = self:Get("RightPanel/Transform/confirm", "GameObject")
    --endregion
    --region 搜索S
    ---搜索框
    self.S_SelectInput = self:Get("RightPanel/Seek/Input/Chat Input", "Top_UIInput")
    --下拉按键
    self.S_btn_shrink = self:Get("RightPanel/Seek/Input/shrink", "GameObject")
    --view面板
    self.S_view = self:Get("RightPanel/Seek/view", "GameObject")
    ---检索对象列表
    self.S_MainList = self:Get("RightPanel/Seek/view/ScrollView/MainList", "Top_UIGridContainer")
    ---搜索
    self.S_Select = self:Get("RightPanel/Seek/Input/Select", "GameObject")

    ---获取widjet
    self.widjetNumber = self:Get("RightPanel/Widjet/widjetNumber", "Top_UILabel")
    --endregion
end
--region 初始化
function UIGMPanel_ComponentManager:Init(panel)
    self:InitComponents();
    self:ChildShowConterial();

    CS.UIEventListener.Get(self.confirm).LuaEventTable = self
    CS.UIEventListener.Get(self.confirm).OnClickLuaDelegate = self.SetSelectTransform
    CS.UIEventListener.Get(self.btn_Active).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_Active).OnClickLuaDelegate = self.SetSelectActive
    CS.UIEventListener.Get(self.S_Select).LuaEventTable = self
    CS.UIEventListener.Get(self.S_Select).OnClickLuaDelegate = self.S_SelectInputItem
    CS.UIEventListener.Get(self.S_btn_shrink).LuaEventTable = self
    CS.UIEventListener.Get(self.S_btn_shrink).OnClickLuaDelegate = self.S_SetShrink
end

function UIGMPanel_ComponentManager:ChildShowConterial()
    self:LeftPanelInit()
end

--region LetPanel
function UIGMPanel_ComponentManager:LeftPanelInit()
    ---模板宽度
    self.modeWide = 28 * 0.0027
    local gos = CS.UnityEngine.GameObject.FindObjectsOfType(typeof(CS.UnityEngine.GameObject));
    self.DataList = {}
    self.TempList = {}
    self.Lenght = 0
    self.startPosition_Y = 0
    self.SelectItem = nil
    self:ShowTopData(gos)
    self:BindTopPanel()
end

---得到顶部数据
function UIGMPanel_ComponentManager:ShowTopData(gos)
    if gos == nil then
        return
    end
    local indxe = 0
    for i = 0, gos.Length - 1 do
        if gos[i] ~= nil then
            if gos[i].transform.parent == nil then
                self.DataList[indxe + 1] = gos[i].transform
                indxe = indxe + 1
            end
        end
    end
end

---绑定顶部模板
function UIGMPanel_ComponentManager:BindTopPanel()
    self.MainList.MaxCount = #self.DataList
    for i = 0, #self.DataList - 1 do
        local item = self.MainList.controlList[i].gameObject
        item.name = self.MainList.controlList[i].gameObject.name
        local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIGMPanel_Component_Item)
        template:RefreshUI(nil, self.DataList[i + 1], self.ItemMold, self)
        self.TempList[i + 1] = template
    end
end

---设置模板位置
function UIGMPanel_ComponentManager:SetItemlocation()
    self.Lenght = 0
    self.startPosition_Y = self.TempList[1].go.transform.position.y
    self:SetItemChildPosition(self.TempList)

end

function UIGMPanel_ComponentManager:SetItemChildPosition(List)
    for i = 1, #List do
        local y = self.Lenght * self.modeWide
        local Vector3 = List[i].own.position
        Vector3.y = self.startPosition_Y - y
        List[i].own.position = Vector3
        self.Lenght = self.Lenght + 1
        if List[i].IsUnfold == true then
            self:SetItemChildPosition(List[i].childTemplateItemList)
        end
    end
end

---选择道具
function UIGMPanel_ComponentManager:SelectTempItem(SelectItem, SelectTemp)
    self:SelectTempChildItem(self.TempList)
    SelectTemp:SetSelectRefresh(true)
    self.SelectItem = SelectItem
    self:SetTransform(SelectItem)
    self.widjetNumber.text=self:SetWidjet(SelectItem)
    if SelectItem ~= nil then
        self.btn_Active_sign.gameObject:SetActive(SelectItem.gameObject.activeInHierarchy)
    end
end

function UIGMPanel_ComponentManager:SelectTempChildItem(List)
    for i = 1, #List do
        List[i]:SetSelectRefresh(false)
        if List[i].IsUnfold == true then
            self:SelectTempChildItem(List[i].childTemplateItemList)
        end
    end
end

--endregion
--region RgihtPanel
--region 设置Transform
function UIGMPanel_ComponentManager:SetTransform(SelectItem)
    if SelectItem == nil then
        self.headline.text = ""
        self:TransformInit(0, 0, 0, 0, 0, 0, 0, 0, 0)
    else
        self.headline.text = SelectItem.transform.name
        local Px = SelectItem.transform.localPosition.x
        local Py = SelectItem.transform.localPosition.y
        local Pz = SelectItem.transform.localPosition.z

        local Rx = SelectItem.transform.localEulerAngles.x
        local Ry = SelectItem.transform.localEulerAngles.y
        local Rz = SelectItem.transform.localEulerAngles.z

        local Sx = SelectItem.transform.localScale.x
        local Sy = SelectItem.transform.localScale.y
        local Sz = SelectItem.transform.localScale.z
        self:TransformInit(Px, Py, Pz, Rx, Ry, Rz, Sx, Sy, Sz)
    end
end

function UIGMPanel_ComponentManager:TransformInit(Px, Py, Pz, Rx, Ry, Rz, Sx, Sy, Sz)
    ---位置
    self.P_X_Label.value = Px
    self.P_Y_Label.value = Py
    self.P_Z_Label.value = Pz
    ---旋转
    self.R_X_Label.value = Rx
    self.R_Y_Label.value = Ry
    self.R_Z_Label.value = Rz
    ---缩放
    self.S_X_Label.value = Sx
    self.S_Y_Label.value = Sy
    self.S_Z_Label.value = Sz
end
local index = -1
function UIGMPanel_ComponentManager:SetSelectTransform()
    if self.SelectItem == nil then
        return
    end

    local Px = tonumber(self.P_X_Label.value)
    local Py = tonumber(self.P_Y_Label.value)
    local Pz = tonumber(self.P_Z_Label.value)

    local Rx = tonumber(self.R_X_Label.value)
    local Ry = tonumber(self.R_Y_Label.value)
    local Rz = tonumber(self.R_Z_Label.value)

    local Sx = tonumber(self.S_X_Label.value)
    local Sy = tonumber(self.S_Y_Label.value)
    local Sz = tonumber(self.S_Z_Label.value)

    self.SelectItem.transform.localPosition = CS.UnityEngine.Vector3(Px, Py, Pz)
    self.SelectItem.transform.localEulerAngles = CS.UnityEngine.Vector3(Rx, Ry, Rz)
    self.SelectItem.transform.localScale = CS.UnityEngine.Vector3(Sx, Sy, Sz)
    print(self.confirm.name)
    local label = CS.Utility_Lua.GetComponent(self.confirm.transform:Find("Label"),'Top_UILabel')
    ---@type CSMatCollect
    local matcollect = CS.Utility_Lua.GetComponent(self.SelectItem.transform,'CSMatCollect')
    index = index+1
    index = math.fmod( index, 18 )
    if index == 0 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
    elseif index == 1 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(5,1,2,0));
    elseif index == 2 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 3 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 4 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 5 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterDiffuseEx")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 6 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
    elseif index == 7 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(5,1,2,0));
    elseif index == 8 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 9 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 10 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 11 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterPBR")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 12 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
    elseif index == 13 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(5,1,2,0));
    elseif index == 14 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1.5);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 15 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,0,0,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 16 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:EnableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    elseif index == 17 then
        matcollect.matList[0].shader = CS.CSShareMaterialStaitc.GetAndAddShader("Fantasy/Character/CharacterSpecularEx")
        matcollect.matList[0]:DisableKeyword('_RIMEFFECT_ON')
        matcollect.matList[0]:SetColor("_RimColor", CS.UnityEngine.Color(255,255,255,255));
        matcollect.matList[0]:SetFloat("_RimPower", 1);
        matcollect.matList[0]:SetVector("_RimParam", CS.UnityEngine.Vector4(0,0,0,0));
    end


    label.text = tostring(index)
end

function UIGMPanel_ComponentManager:SetSelectActive()
    if self.SelectItem == nil then
        return
    end
    if self.SelectItem.gameObject.activeInHierarchy == true then
        self.SelectItem.gameObject:SetActive(false)
    else
        self.SelectItem.gameObject:SetActive(true)
    end
    self.btn_Active_sign.gameObject:SetActive(self.SelectItem.gameObject.activeInHierarchy)

end
--endregion
--region 搜索
---搜索物体
function UIGMPanel_ComponentManager:S_SelectInputItem()
    local gos = CS.UnityEngine.GameObject.FindObjectsOfType(typeof(CS.UnityEngine.GameObject));
    local targetName = self.S_SelectInput.value
    local searchList = {}
    local indxe = 1
    for i = 0, gos.Length - 1 do
        if gos[i].gameObject.name == targetName then
            searchList[indxe] = gos[i].gameObject
            indxe = indxe + 1
        end
    end

    self.S_MainList.MaxCount = #searchList
    for i = 0, #searchList - 1 do
        local item = self.S_MainList.controlList[i].gameObject
        self.S_ItemFullPath = searchList[i + 1].gameObject.name
        self:S_GetFullPath(searchList[i + 1].gameObject)
        print(self.S_ItemFullPath)
        CS.Utility_Lua.GetComponent(item.transform:Find("name"),"Top_UILabel").text = string.gsub(self.S_ItemFullPath, '/r/n', '')
    end
end

---得到完整路径
function UIGMPanel_ComponentManager:S_GetFullPath(item)
    if item == nil then
        return self.S_ItemFullPath
    end
    if item.transform.parent == nil then
        return self.S_ItemFullPath
    else
        self.S_ItemFullPath = item.transform.parent.name .. "/" .. self.S_ItemFullPath
        self:S_GetFullPath(item.transform.parent.gameObject)
    end
end

---设置下拉
function UIGMPanel_ComponentManager:S_SetShrink()
    if self.S_view.gameObject.activeInHierarchy then
        self.S_btn_shrink.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
        self.S_view.gameObject:SetActive(false)
    else
        self.S_btn_shrink.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, -90)
        self.S_view.gameObject:SetActive(true)
    end
end


--endregion

--region 设置widjet
function UIGMPanel_ComponentManager:SetWidjet(SelectItem)
    if SelectItem == nil then
        return "未选择物体"
    end
     local widget=CS.Utility_Lua.GetComponent(SelectItem.transform,"UIWidget");
     if widget==nil then
         return "无widjet"
     end
     if  widget.drawCall==nil  then
        return "widget.drawCall==nil"
     end
     return  widget.drawCall.renderQueue
end

--endregion

--endregion
function UIGMPanel_ComponentManager:Show(pos)
    self.go:SetActive(true)
end

function UIGMPanel_ComponentManager:Hide()
    self.go:SetActive(false)
end

return UIGMPanel_ComponentManager