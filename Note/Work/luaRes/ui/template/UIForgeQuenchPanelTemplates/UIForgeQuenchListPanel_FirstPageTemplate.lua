---@class UIForgeQuenchListPanel_FirstPageTemplate:TemplateBase
local UIForgeQuenchListPanel_FirstPageTemplate = {}

---@return LuaForgeQuenchDataManager
function UIForgeQuenchListPanel_FirstPageTemplate:GetForgeQuenchMgr()
    if self.mForgeQuenchMgr == nil then
        self.mForgeQuenchMgr = gameMgr:GetPlayerDataMgr():GetForgeQuenchDataMgr()
    end
    return self.mForgeQuenchMgr
end

--region 初始化

function UIForgeQuenchListPanel_FirstPageTemplate:Init()
    self:InitComponents()
    self:InitParameters()
    self:BindUIMessage()
end
--初始化变量
function UIForgeQuenchListPanel_FirstPageTemplate:InitParameters()
    ---@type ForgeQuenchPageData
    self.pageData = nil
    self.goClickCallBack = nil
    self.isOpen = false
    self.isInitialzedGrid = false
    ---@type table<UnityEngine.GameObject,UIForgeQuenchListPanel_SecondPageTemplate>
    self.GoAndTemplateDic = {}
    self.curCuiLianId = -1
end

function UIForgeQuenchListPanel_FirstPageTemplate:InitComponents()
    ---@type UnityEngine.GameObject
    self.chekMarkGo = self:Get("backgroud/checkMark", "GameObject")
    ---@type Top_UILabel
    self.chekMarkLabel = self:Get("backgroud/checkMark/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.label = self:Get("backgroud/backgroud/Label", "Top_UILabel")
    ---@type Top_UIGridContainer
    self.pageGrid = self:Get("ScrollView/SecondLayer", "Top_UIGridContainer")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
end

function UIForgeQuenchListPanel_FirstPageTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickGoCallback
end

function UIForgeQuenchListPanel_FirstPageTemplate:BindRedPoint()
    if self.redPoint == nil or CS.StaticUtility.IsNull(self.redPoint.gameObject) or self.pageData == nil then
        return
    end
    self.redPoint:RemoveRedPointKey()
    self.redPoint:AddRedPointKey(self.pageData.redPoint)
end

--endregion

--region Show

---@param data
---@field data.pageInfo ForgeQuenchPageData
---@field data.callBack
---@field data.clickSecondPageCallBack
function UIForgeQuenchListPanel_FirstPageTemplate:SetTemplate(data)
    self.pageData = data.pageInfo
    self.goClickCallBack = data.callBack
    self.clickSecondPageCallBack = data.clickSecondPageCallBack
    self:BindRedPoint()
    self:InitView()
end

function UIForgeQuenchListPanel_FirstPageTemplate:InitView()
    if self.pageData == nil then
        return
    end
    self.chekMarkLabel.text = self.pageData.str
    self.label.text = self.pageData.str
end

---@return boolean
function UIForgeQuenchListPanel_FirstPageTemplate:InitShowListView()
    local tbl = self:GetForgeQuenchMgr():GetNeedShowForgetQuenchIdList(self.pageData.type)
    if #tbl > 0 then
        self:ChangeState(self.pageData.type)
        return true
    end
    return false
end

---刷新淬炼列表视图
function UIForgeQuenchListPanel_FirstPageTemplate:RefreshFoegeQuenchListView()
    if not self.isInitialzedGrid and self.isOpen then
        self.isInitialzedGrid = true
        local tbl = self:GetForgeQuenchMgr():GetNeedShowForgetQuenchIdList(self.pageData.type)
        local count = #tbl
        self.pageGrid.MaxCount = count
        for i = 1, count do
            local go = self.pageGrid.controlList[i - 1]
            if go then
                local template
                if self.GoAndTemplateDic[go] == nil then
                    template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIForgeQuenchListPanel_SecondPageTemplate)
                    self.GoAndTemplateDic[go] = template
                else
                    template = self.GoAndTemplateDic[go]
                end
                template:SetTemplate({
                    cuiLianId = tbl[i].Id,
                    clickCallBack = function(id)
                        self:OnClickPageItemCallBack(id)
                    end
                })
            end
        end
    end
    self.pageGrid.gameObject:SetActive(self.isOpen)
end

--endregion

--region UI函数监听

function UIForgeQuenchListPanel_FirstPageTemplate:OnClickGoCallback()
    if self.goClickCallBack ~= nil then
        self.goClickCallBack(self.pageData.type)
    end
end

---@param id number 淬炼id
function UIForgeQuenchListPanel_FirstPageTemplate:OnClickPageItemCallBack(id)
    if id == self.curCuiLianId then
        return
    end
    self.curCuiLianId = id
    for i, v in pairs(self.GoAndTemplateDic) do
        v:ChangeState(id)
    end
    if self.pageData and self.clickSecondPageCallBack then
        self.clickSecondPageCallBack(self.pageData.type)
    end
end

--endregion


--region otherFunction
function UIForgeQuenchListPanel_FirstPageTemplate:ChangeState(type)
    local isOpen = self.pageData ~= nil and type == self.pageData.type
    if isOpen then
        if self.isOpen then
            self.isOpen = false
        else
            self.isOpen = true
        end
    else
        self.isOpen = false
    end

    if self.isOpen ~= self.chekMarkGo.activeSelf then
        self.chekMarkGo:SetActive(self.isOpen)
    end

    self:RefreshFoegeQuenchListView()
end

function UIForgeQuenchListPanel_FirstPageTemplate:ChangeGridState(type)
    local isOpen = self.pageData ~= nil and type == self.pageData.type
    if not isOpen then
        self:ResetGridView()
    end
end

---重置视图
function UIForgeQuenchListPanel_FirstPageTemplate:ResetView()
    self.isInitialzedGrid = false
    self:ChangeState(nil)
    self:ResetGridView()
end

function UIForgeQuenchListPanel_FirstPageTemplate:ResetGridView()
    self.curCuiLianId = 0
    for i, v in pairs(self.GoAndTemplateDic) do
        v:ChangeState(0)
    end
end

--endregion

--region ondestroy

function UIForgeQuenchListPanel_FirstPageTemplate:onDestroy()

end

--endregion

return UIForgeQuenchListPanel_FirstPageTemplate