---@class UIBookMarkBaseTempate 页签
local UIBookMarkBaseTempate = {}

function UIBookMarkBaseTempate:Init()
    self:InitComponents()
    self:BindUIMessage()
end
--初始化变量
function UIBookMarkBaseTempate:InitParameters()
    self.id = 0
    self.tblInfo = nil
    self.goClickCallBack = nil
end

function UIBookMarkBaseTempate:InitComponents()
    ---@type Top_UILabel
    self.Label = self:Get("background/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.checkMarkLabel = self:Get("checkmark/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.checkmark = self:Get("checkmark", "GameObject")
    ---@type UnityEngine.GameObject
    self.background = self:Get("background", "Top_UISprite")
    ---@type UnityEngine.GameObject
    self.hot = self:Get("hot", "GameObject")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
    ---@type Top_UISprite icon
    self.icon = self:Get("background/icon", "Top_UISprite")
    ---@type Top_UISprite icon
    self.checkMarkIcon = self:Get("checkmark/icon", "Top_UISprite")
end

function UIBookMarkBaseTempate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnTemplatBtnClick
end

---@param data table
---@field data.pageData RankPageInfo
---@field data.callBack function
function UIBookMarkBaseTempate:SetTemplate(data)
    if data then
        self.pageData = data.pageData
        self.goClickCallBack = data.callBack
        self:InitUI()
    end
end

function UIBookMarkBaseTempate:InitUI()
    if self.pageData == nil then
        return
    end
    self.Label.text = self.pageData.str
    self.checkMarkLabel.text = self.pageData.str
    self:SetRedPoint()
end

function UIBookMarkBaseTempate:SetRedPoint()
    if self.redPoint ~= nil then
        self.redPoint:RemoveRedPointKey()
        if self.pageData.redEnum ~= nil then
            if type(self.pageData.redEnum) == "number" then
                self.redPoint:AddRedPointKey(self.pageData.redEnum)
            else
                local luaRedPoint = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(self.pageData.redEnum);
                self.redPoint:AddRedPointKey(luaRedPoint)
            end
        end
    end
end


--region UI函数监听

function UIBookMarkBaseTempate:OnTemplatBtnClick(go)
    if self.goClickCallBack ~= nil then
        self.goClickCallBack(self)
    end
end

--endregion


--region otherFunction

--刷新显示状态
function UIBookMarkBaseTempate:RefreshToggleStatu(id)
    if self.pageData then
        local isOpen = id == self.pageData.id
        if CS.StaticUtility.IsNull(self.checkmark) == false and CS.StaticUtility.IsNull(self.checkmark.gameObject) == false and self.checkmark.gameObject.activeSelf ~= isOpen then
            self.checkmark.gameObject:SetActive(isOpen)
        end
    end
end

--endregion

--region ondestroy

function UIBookMarkBaseTempate:onDestroy()

end

--endregion


return UIBookMarkBaseTempate