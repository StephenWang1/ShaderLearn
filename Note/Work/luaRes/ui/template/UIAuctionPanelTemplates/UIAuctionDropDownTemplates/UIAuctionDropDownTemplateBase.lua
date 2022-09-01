---@class UIAuctionDropDownTemplateBase:TemplateBase 交易行下拉框模板
local UIAuctionDropDownTemplateBase = {}

--region 组件
---@return UIGridContainer 排序container
function UIAuctionDropDownTemplateBase:GetSortContainer()
    if self.mCloseSortGo == nil then
        self.mCloseSortGo = self:Get("DropDown/BgContainer", "UIGridContainer")
    end
    return self.mCloseSortGo
end

---@return UnityEngine.BoxCollider
function UIAuctionDropDownTemplateBase:GetCollider()
    if self.mCollider == nil then
        self.mCollider = self:Get("DropDown/BgContainer/close", "BoxCollider")
    end
    return self.mCollider
end

---@return TweenRotation 箭头旋转
function UIAuctionDropDownTemplateBase:GetArrow_TweenRotation()
    if self.mArrowTween == nil then
        self.mArrowTween = self:Get("DropDown/Caption/Btn_program", "TweenRotation")
    end
    return self.mArrowTween
end

---@return UILabel
function UIAuctionDropDownTemplateBase:GetCaption_Lb()
    if self.mCaptionLb == nil then
        self.mCaptionLb = self:Get("DropDown/Caption/CaptionLabel", "UILabel")
    end
    return self.mCaptionLb
end

---@return UnityEngine.GameObject 排序go
function UIAuctionDropDownTemplateBase:GetSortGo()
    if self.mSortGo == nil then
        self.mSortGo = self:Get("DropDown/Caption", "GameObject")
    end
    return self.mSortGo
end

---@return UnityEngine.GameObject
function UIAuctionDropDownTemplateBase:GetChoose_Go()
    if self.mChooseGo == nil then
        self.mChooseGo = self:Get("DropDown/Caption/checkMark", "GameObject")
    end
    return self.mChooseGo
end

--endregion

---@param panel UIAuctionMenuPanelTemplateBase
function UIAuctionDropDownTemplateBase:Init(panel)
    self.mRootPanel = panel
    self:GetCollider().enabled = self:NeedCollider()
    self:BindEvent()
end

function UIAuctionDropDownTemplateBase:BindEvent()
    CS.UIEventListener.Get(self:GetCollider().gameObject).onClick = function()
        self:CloseChooseSort()
    end
    CS.UIEventListener.Get(self:GetSortGo()).onClick = function()
        self:ShowChooseSort()
    end
end

---@param rootId number 该大类id（比如14（10，11,12））
---@param idList table<number,number> 选项id 如上（10，11,12）
---@param chooseId number 需要默认选中的id
function UIAuctionDropDownTemplateBase:RefreshDropDown(idList, rootId, chooseId)
    self.mCurrentSortType = -1
    self.ChooseSort = false
    self.rootId = rootId
    self:SetArrowShow()
    self:ChooseSortType(rootId, chooseId)
    self:CloseChooseSort()
    self.mTypeToToggle = {}
    self.mTypeToLb = {}
    self:GetSortContainer().MaxCount = #idList
    for i = 0, self:GetSortContainer().controlList.Count - 1 do
        local type = idList[i + 1]
        local go = self:GetSortContainer().controlList[i]
        local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
        ---@type UILabel
        local typeLabel = CS.Utility_Lua.Get(go.transform, "LabelValue", "UILabel")
        typeLabel.text = "[878787]" .. self:GetIdText(type)
        typeLabel.effectStyle = CS.UILabel.Effect.None
        CS.UIEventListener.Get(go).onClick = function()
            if self.mCurrentSortType then
                self:ChooseItem(self.mCurrentSortType, false)
            end
            self:ChooseItem(type, true)
            self:CloseChooseSort()
        end
        self.mTypeToToggle[type] = go
        self.mTypeToLb[type] = typeLabel
    end
end

function UIAuctionDropDownTemplateBase:ChooseItem(type, choose)
    local lb = self.mTypeToLb[type]
    if lb then
        local color = choose and "" or luaEnumColorType.Gray
        lb.text = color .. self:GetIdText(type)
        lb.effectStyle = choose and CS.UILabel.Effect.Outline or CS.UILabel.Effect.None
        if choose then
            self:ChooseSortType(self.rootId, type)
        end
    end
    if self.mRootPanel then
        self.mRootPanel:RefreshFourthMenu(self.rootId,type)
    end
end

---打开选中
function UIAuctionDropDownTemplateBase:ShowChooseSort()
    self.ChooseSort = true
    self:SetArrowShow()
    self:GetSortContainer().gameObject:SetActive(true)
    --[[    local toggle = self.mTypeToToggle[self.mCurrentSortType]
        if toggle then
            toggle:Set(true)
        end]]
    self:ChooseItem(self.mCurrentSortType, true)
end

---关闭选中
function UIAuctionDropDownTemplateBase:CloseChooseSort()
    self.ChooseSort = false
    self:SetArrowShow()
    self:GetSortContainer().gameObject:SetActive(false)
end

---设置箭头选中
function UIAuctionDropDownTemplateBase:SetArrowShow()
    if self.ChooseSort then
        self:GetArrow_TweenRotation():PlayForward()
    else
        self:GetArrow_TweenRotation():PlayReverse()
    end
end

---设置初始选中
function UIAuctionDropDownTemplateBase:ChooseSortType(rootId, type)
    if type ~= nil then
        self.mCurrentSortType = type
        self:SetMainShow(type, "")
        ---@type UIAuctionMenuPanelTemplateBase
        local rootPanel = self.mRootPanel
        if rootPanel then
            rootPanel:ChooseMenuChange()
        end
    else
        self:SetMainShow(rootId, luaEnumColorType.Gray)
    end
    self:GetChoose_Go():SetActive(type ~= nil)
end

---设置选中显示
function UIAuctionDropDownTemplateBase:SetMainShow(type, color)
    self:GetCaption_Lb().text = color .. self:GetIdText(type)
end

--region 用于重写
---@return string 传入id 对应文本
function UIAuctionDropDownTemplateBase:GetIdText(id)
    return ""
end

function UIAuctionDropDownTemplateBase:NeedCollider()
    return true
end
--endregion

--region 获取数据
---获取下拉框开启状态
function UIAuctionDropDownTemplateBase:GetOpenState()
    return self.ChooseSort
end
--endregion

return UIAuctionDropDownTemplateBase