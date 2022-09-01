---白日门界面书签页
---@class UIWhiteSunGatePanelBookMark:TemplateBase
local UIWhiteSunGatePanelBookMark = {}

---@return UIWhiteSunGatePanel
function UIWhiteSunGatePanelBookMark:GetOwnerPanel()
    return self.mOwner
end

---@return TABLE.cfg_bairimen_activity
function UIWhiteSunGatePanelBookMark:GetBaiRiMenActivityTbl()
    return self.mBaiRiMenActivityTbl
end

---书签背景图
---@return UISprite
function UIWhiteSunGatePanelBookMark:GetBookMarkSprite()
    if self.mBookMarkSprite == nil then
        self.mBookMarkSprite = self:Get("background", "UISprite")
    end
    return self.mBookMarkSprite
end

---书签文字
---@return UILabel
function UIWhiteSunGatePanelBookMark:GetBookMarkLabel()
    if self.mBookMarkLabel == nil then
        self.mBookMarkLabel = self:Get("background/Label", "UILabel")
    end
    return self.mBookMarkLabel
end

---书签高亮文字
---@return UILabel
function UIWhiteSunGatePanelBookMark:GetCheckMarkLabel()
    if self.mCheckMarkLabel == nil then
        self.mCheckMarkLabel = self:Get("checkmark/Label", "UILabel")
    end
    return self.mCheckMarkLabel
end

---红点
---@return UIRedPoint
function UIWhiteSunGatePanelBookMark:GetRedPoint_UIRedPoint()
    if self.mRedPoint_UIRedPoint == nil then
        self.mRedPoint_UIRedPoint = self:Get("redPoint", "Top_UIRedPoint")
    end
    return self.mRedPoint_UIRedPoint
end

---@return UnityEngine.GameObject
function UIWhiteSunGatePanelBookMark:GetCheckMarkGO()
    if self.mCheckMarkGO == nil then
        self.mCheckMarkGO = self:Get("checkmark", "GameObject")
    end
    return self.mCheckMarkGO
end

function UIWhiteSunGatePanelBookMark:Init(owner)
    self.mOwner = owner
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnBookMarkClicked()
    end
end

---注册点击事件回调
---@param clickCallBack fun(go, bairimenActivityTbl)
function UIWhiteSunGatePanelBookMark:RegisterClickCallBack(clickCallBack)
    ---@type fun(go, bairimenActivityTbl)
    self.mClickCallBack = clickCallBack
end

---刷新状态
---@param bairimenActivityTbl TABLE.cfg_bairimen_activity
---@param isSelected boolean
---@param isActivityOpened boolean
---@param actActivity BaiRiMenActControllerBase
function UIWhiteSunGatePanelBookMark:RefreshState(bairimenActivityTbl, isSelected, isActivityOpened,actActivity)
    self.mBaiRiMenActivityTbl = bairimenActivityTbl
    self.mIsSelected = isSelected
    self.mIsActivityOpened = isActivityOpened
    if self.mBaiRiMenActivityTbl then
        self.textStr = self.mBaiRiMenActivityTbl:GetTabName()
    else
        self.textStr = ""
    end
    ---@type BaiRiMenActControllerBase
    self.mActActivity = actActivity
    self:RefreshUI()
    self:BindRedPoint()
end

---设置选中状态
---@param isSelected boolean
function UIWhiteSunGatePanelBookMark:SetSelectedState(isSelected)
    self.mIsSelected = isSelected
    self:RefreshUI()
    self:SetRedPointClick()
    self:RedPointCallBack()
end

---刷新UI,每次状态变化时调用
---@private
function UIWhiteSunGatePanelBookMark:RefreshUI()
    if self.textStr == nil then
        self.textStr = ""
    end
    local textTemp = self.textStr
    if self.mIsSelected then
        ---已选中页签
        textTemp = Utility.CombineStringQuickly("[ffffff]", textTemp, "[-]")
    elseif self.mIsActivityOpened then
        ---未选中页签
        textTemp = Utility.CombineStringQuickly("[878787]", textTemp, "[-]")
    else
        ---未开启页签
        textTemp = Utility.CombineStringQuickly("[454545]", textTemp, "[-]")
    end
    self:GetCheckMarkGO():SetActive(self.mIsSelected)
    if self.mIsActivityOpened then
        self:GetBookMarkSprite().spriteName = "tab_type1"
    else
        self:GetBookMarkSprite().spriteName = "tab_type3"
    end
    self:GetBookMarkLabel().text = textTemp
    self:GetCheckMarkLabel().text = textTemp
end

---书签点击事件
---@private
function UIWhiteSunGatePanelBookMark:OnBookMarkClicked()
    if self.mClickCallBack ~= nil then
        self.mClickCallBack(self.go, self:GetBaiRiMenActivityTbl())
    end
end

---绑定红点
---@private
function UIWhiteSunGatePanelBookMark:BindRedPoint()
    if self.isBindRedPoint == true or self.mActActivity == nil or self.mActActivity:BindRedPoint() ~= true then
        return
    end
    self.isBindRedPoint = true
    luaclass.UIRefresh:AddRedPointKey(self:GetRedPoint_UIRedPoint(),self.mActActivity:GetBaiRiMenRedPointKey())
end

---设置红点点击
function UIWhiteSunGatePanelBookMark:SetRedPointClick()
    if self.mActActivity ~= nil and self:GetRedPointState() == true then
        self.mActActivity:SetRedPointClickState(true)
    end
end

---红点触发刷新
function UIWhiteSunGatePanelBookMark:RedPointCallBack()
    if self.mActActivity ~= nil then
        self.mActActivity:CallRedPoint()
    end
end

---获取红点状态
---@return boolean
function UIWhiteSunGatePanelBookMark:GetRedPointState()
    if self.mActActivity ~= nil then
        return gameMgr:GetLuaRedPointManager():GetRedPointState(self.mActActivity:GetBaiRiMenRedPointKey())
    end
end

return UIWhiteSunGatePanelBookMark