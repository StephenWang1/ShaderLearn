---页签模板
local UIBookMarkTemplate = {}

--region 初始化

function UIBookMarkTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:BindNetMessage()
end
--初始化变量
function UIBookMarkTemplate:InitParameters()
    self.dataID = 0
    self.index = 0
    self.cfgId = 0
    self.goClickCallBack = nil
end

function UIBookMarkTemplate:InitComponents()
    ---@type Top_UILabel
    self.Label = self:Get("background/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.checkMarkLabel = self:Get("checkmark/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.checkmark = self:Get("checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    self.background = self:Get("background", "Top_UISprite")
    ---@type UIRedPoint
    self.redPoint = self:Get("redPoint", "UIRedPoint")
end

function UIBookMarkTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnTemplatBtnClick
end

function UIBookMarkTemplate:BindNetMessage()

end

--endregion

--region Show

---@param data.page      number  当前页签id
---@param data.name      number  当前页签name
---@param data.index     number  当前页签索引
---@param data.callBack  function 点击回调
function UIBookMarkTemplate:SetTemplate(data)
    if data then
        self.dataID = data.dataID
        self.goClickCallBack = data.callBack
        self.index = data.index
        self.cfgId = data.type
        self.Label.text = data.name
        self.checkMarkLabel.text = data.name
        self:SetRedPoint()
    end
end

function UIBookMarkTemplate:SetRedPoint()
    if self.redPoint ~= nil then
        self.redPoint:RemoveRedPointKey()
        if self.cfgId == 0 or self.cfgId == nil then
            -- 规则 普通榜：(21000+id) top榜：(21000+index*100)
            self.redPoint:AddRedPointKey(21000 + (self.index + 1) * 100)
        else
            self.redPoint:AddRedPointKey(21000 + self.cfgId)
        end
    end
end

--endregion


--region UI函数监听
function UIBookMarkTemplate:OnTemplatBtnClick(go)
    if self.goClickCallBack ~= nil then
        self.goClickCallBack(go)
    end
end

--endregion


--region otherFunction

--刷新显示状态
function UIBookMarkTemplate:RefreshToggleStatu(index)
    if index ~= nil then
        self.checkmark.gameObject:SetActive(index == self.index)
    end
end


--endregion


return UIBookMarkTemplate