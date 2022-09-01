---@class UIContendRank_BookMarkTemplate 夺榜页签
local UIContendRank_BookMarkTemplate = {}

function UIContendRank_BookMarkTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
end
--初始化变量
function UIContendRank_BookMarkTemplate:InitParameters()
    self.id = 0
    self.goClickCallBack = nil
end

function UIContendRank_BookMarkTemplate:InitComponents()
    ---@type Top_UILabel
    self.Label = self:Get("background/Label", "Top_UILabel")
    ---@type Top_UILabel
    self.checkMarkLabel = self:Get("checkmark/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject
    self.checkmark = self:Get("checkmark", "Top_UISprite")
    ---@type UnityEngine.GameObject
    self.background = self:Get("background", "Top_UISprite")
    ---@type UIRedPoint
    self.hot = self:Get("hot", "GameObject")
end

function UIContendRank_BookMarkTemplate:BindUIMessage()
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnTemplatBtnClick
end

---@param data.id      number  当前页签id
---@param data.callBack  function 点击回调
function UIContendRank_BookMarkTemplate:SetTemplate(data)
    if data then
        self.id = data.id
        self.goClickCallBack = data.callBack
        self:GetTblInfo()
        self:InitUI()
    end
end

function UIContendRank_BookMarkTemplate:InitUI()
    if self.tblInfo ~= nil then
        self.Label.text = self.tblInfo.title
        self.checkMarkLabel.text = self.tblInfo.title
        self.hot:SetActive(self.tblInfo.hotFlag == 1)
    end
end

function UIContendRank_BookMarkTemplate:GetTblInfo()
    _, self.tblInfo = CS.Cfg_ContendRankTableManager.Instance.dic:TryGetValue(self.id)
end

--region UI函数监听

--endregion


--region otherFunction

--刷新显示状态
function UIContendRank_BookMarkTemplate:RefreshToggleStatu(id)
    local isOpen = id == self.id
    if self.checkmark.gameObject.activeSelf ~= isOpen then
        self.checkmark.gameObject:SetActive(isOpen)
    end
end

function UIContendRank_BookMarkTemplate:OnTemplatBtnClick(go)
    if self.goClickCallBack ~= nil then
        self.goClickCallBack(go, self.tblInfo)
    end
end

--endregion

--region ondestroy

function UIContendRank_BookMarkTemplate:onDestroy()

end

--endregion


return UIContendRank_BookMarkTemplate