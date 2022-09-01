local UIGMPanel_Component_Item = {}

---绑定基础组件
function UIGMPanel_Component_Item:InitComponents()
    self.lb_name = self:Get("name", "Top_UILabel")
    self.nameBox = self:Get("name/nameBox", "GameObject")
    self.btn_arrows = self:Get("arrows", "GameObject")
    self.btn_Pitch = self:Get("Pitch", "GameObject")
    self.ChildList_GridContainer = self:Get("ChildList", "Top_UIGridContainer")
    --  self.child = templatemanager.GetNewTemplate(self.childObj, luaComponentTemplates.UIGMPanel_Component_Item)
end

---定义基础属性
function UIGMPanel_Component_Item:InitOther()
    ---父物体
    self.parent = nil
    ---自己
    self.own = self.go.transform
    ---子物体列表
    self.childList = {}
    ---展开状态
    self.IsUnfold = false
    ---索引物体
    self.indexesObj = nil
    ---子物体模板
    self.childModelObj = nil
    ---模板宽度
    self.modeWide = 28
    ---ComponentManager
    self.ComponentManager = nil
    ---模板列表
    self.childTemplateItemList = {}
    ---选中状态
    self.IsSelect=false

    CS.UIEventListener.Get(self.btn_arrows).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_arrows).OnClickLuaDelegate = self.SetUnfold

    CS.UIEventListener.Get(self.nameBox.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.nameBox.gameObject).OnClickLuaDelegate = self.SetSelect
end

function UIGMPanel_Component_Item:Init()
    self:InitComponents()
    self:InitOther()
end

---刷新UI
function UIGMPanel_Component_Item:RefreshUI(parent, indexesObj, childModelObj, ComponentManager)
    self.parent = parent
    self.lb_name.text = indexesObj.name
    self.IsUnfold = false
    self.indexesObj = indexesObj
    self.childModelObj = childModelObj
    self.ChildList_GridContainer.controlTemplate = childModelObj
    self.ComponentManager = ComponentManager
    self:AddChildList()
    self.ChildList_GridContainer.gameObject:SetActive(self.IsUnfold)
    self.btn_Pitch.gameObject:SetActive(self.IsSelect)
end

---添加子物体列表
function UIGMPanel_Component_Item:AddChildList()
    if self.indexesObj.transform.childCount - 1 < 0 then
        self.btn_arrows:SetActive(false)
        return
    else
        self.btn_arrows:SetActive(true)
    end
    if self.indexesObj.transform.childCount - 1 == 0 then
        self.childList[1] = self.indexesObj.transform:GetChild(0)
        return
    end
    for i = 0, self.indexesObj.transform.childCount - 1 do
        self.childList[i + 1] = self.indexesObj.transform:GetChild(i)
    end

end

---设置展开状态
function UIGMPanel_Component_Item:SetUnfold()
    self:AddChildList()
    if self.IsUnfold == true then
        self.IsUnfold = false
    else
        self.IsUnfold = true
    end

    ---设置箭头旋转
    if self.IsUnfold then
        self.btn_arrows.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
    else
        self.btn_arrows.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 90)
    end
    if self.IsUnfold then
        self.ChildList_GridContainer.MaxCount = #self.childList
        for i = 0, #self.childList - 1 do
            local item = self.ChildList_GridContainer.controlList[i].gameObject
            local template = templatemanager.GetNewTemplate(item, luaComponentTemplates.UIGMPanel_Component_Item)
            template:RefreshUI(self, self.childList[i + 1], self.childModelObj, self.ComponentManager)
            self.childTemplateItemList[i + 1] = template
        end
    else
        self.ChildList_GridContainer.MaxCount = 0
    end

    if self.ComponentManager ~= nil then
        self.ComponentManager:SetItemlocation()
    end
    self.ChildList_GridContainer.gameObject:SetActive(self.IsUnfold)

end

---设置选中状态
function UIGMPanel_Component_Item:SetSelect()
    self.IsSelect=true
    self.btn_Pitch.gameObject:SetActive(self.IsSelect)
    if self.ComponentManager ~= nil then
        self.ComponentManager:SelectTempItem(self.indexesObj,self)
    end
end

---选择状态刷新
function UIGMPanel_Component_Item:SetSelectRefresh(IsSelect)
    self.btn_Pitch.gameObject:SetActive(IsSelect)
end

return UIGMPanel_Component_Item