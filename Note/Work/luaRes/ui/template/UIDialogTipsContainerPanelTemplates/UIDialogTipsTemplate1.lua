---对话框提示模板
local UIDialogTipsTemplate1 = {  }

function UIDialogTipsTemplate1:Init()
    self:InitComponents()
    self:InitOther()
    self:InitInfo()
end
--通过工具生成 控件变量
function UIDialogTipsTemplate1:InitComponents()
    --提示面板Transform
    self.mTipsPanel_Transform = self:Get("tipPanel", "Transform")
    --背景图片
    self.mBg_UISprite = self:Get("tipPanel/bg", "UISprite")
    --文字lb_tips
    self.mTips_UILabel = self:Get("tipPanel/lb_tips", "UILabel")
    --文字Transform
    self.mTips_Transform = self:Get("tipPanel/lb_tips", "Transform")
    --文字GameObject
    self.mTips_GameObject = self:Get("tipPanel/lb_tips", "GameObject")
    --文字Transform
    self.mTips_BoxCollider = self:Get("tipPanel/lb_tips", "BoxCollider")
    --关闭按钮UIAnchor
    self.mCloseBtn_UIAnchor = self:Get("tipPanel/btn_close", "UIAnchor")
    --关闭按钮
    self.mCloseBtn_GameObject = self:Get("tipPanel/btn_close", "GameObject")
end

--初始化 变量 按钮点击 服务器消息事件等
function UIDialogTipsTemplate1:InitOther()
    --内容
    self.mContent = ""
    --高亮内容
    self.mHighLightContent = ""
    --类型
    self.mDialogType = nil
    --所有的图片信息
    self.mSpriteInfoList = nil
    --所需的图片信息
    self.mSpriteInfo = nil
    --容器面板
    self.mContainerPanel = nil
    --关闭事件
    self.mCloseAction = nil
    --高亮区域事件
    self.mHighLightContentAction = nil
    --需要点击的内容的回调
    self.mContentAction = nil
    --倒计时协程
    self.IenumRefreshTime = nil
    --初始位置
    self.originWidth = self.mBg_UISprite.width;
    self.originPosition = self.mBg_UISprite.gameObject.transform.localPosition;

    if CS.StaticUtility.IsNull(self.mCloseBtn_GameObject) == false then
        CS.UIEventListener.Get(self.mCloseBtn_GameObject).LuaEventTable = self
        CS.UIEventListener.Get(self.mCloseBtn_GameObject).OnClickLuaDelegate = self.OnClickCloseBtn
    end
    if CS.StaticUtility.IsNull(self.mTips_GameObject) == false then
        CS.UIEventListener.Get(self.mTips_GameObject).LuaEventTable = self
        CS.UIEventListener.Get(self.mTips_GameObject).OnClickLuaDelegate = self.OnClickContentBtn
    end
    --CS.UIEventListener.Get(self.mHighLightContentBtn_GameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.mHighLightContentBtn_GameObject).OnClickLuaDelegate = self.OnClickHighLightContentBtn
end

---点击关闭按钮
function UIDialogTipsTemplate1:OnClickCloseBtn()
    if self.mCloseAction then
        self.mCloseAction(self)
    end
    self:Hide()
end
---点击高亮区域按钮(弃用)
function UIDialogTipsTemplate1:OnClickHighLightContentBtn()
    if self.mHighLightContentAction then
        self.mHighLightContentAction(self)
    end
    self:Hide()
end
---点击文字区域按钮
function UIDialogTipsTemplate1:OnClickContentBtn()
    if self.mContentAction then
        self.mContentAction(self)
    end
    self:Hide()
end
---显示
function UIDialogTipsTemplate1:Show(panel, content, closeAction, highLightContent, contentAction, time, dialogType)
    self.originPosition = self.go.transform.localPosition;
    self.mContainerPanel = panel
    self.mCloseAction = closeAction
    self.mContentAction = contentAction
    if contentAction then
        self.mTips_BoxCollider.enabled = true
    else
        self.mTips_BoxCollider.enabled = false
    end
    --获取图片信息
    self.mDialogType = dialogType
    for k, v in pairs(self.mSpriteInfoList) do
        if v["DialogType"] == self.mDialogType then
            self.mSpriteInfo = v
        end
    end
    --if self.mSpriteInfo == nil then
    --    luaDebug.Log("没有这个图片信息，请补充")
    --    return
    --end
    --设置图片信息
    --self.mTipsPanel_Transform.localPosition = self.mSpriteInfo["RelativePos"]
    if self.mSpriteInfo then
        self.mBg_UISprite.spriteName = self.mSpriteInfo["Name"]
        self.mBg_UISprite.pivot = self.mSpriteInfo["Pivot"]
    end
    --self.mCloseBtn_UIAnchor.pixelOffset = self.mSpriteInfo["CloseBtnRelativePos"]
    --设置文字的宽度
    self.mTips_UILabel.width = 189
    self:ResetContents(content, highLightContent)
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if time ~= nil and time ~= 0 then
        self.IenumRefreshTime = StartCoroutine(UIDialogTipsTemplate1.IEnumRefreshTime, self, time)
    end
end
---隐藏（公开方法,外部调用）
function UIDialogTipsTemplate1:Hide()
    if self.mContainerPanel and self.mContainerPanel.RemoveDialogTips and self.go and CS.StaticUtility.IsNull(self.go) == false then
        self.mContainerPanel.RemoveDialogTips(self.go, self.mDialogType)
    end
    self.mCloseAction = nil
    self.mHighLightContentAction = nil
    self.mContentAction = nil
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

---重置内容（公开方法）
---如果在外部有需要的情况下，比如有倒计时，需要改变文本的内容，调用此方法
---@field content string 内容
---@field highLightContent string 高亮内容
function UIDialogTipsTemplate1:ResetContents(content, highLightContent)
    if content == nil then
        return
    end
    self.mContent = content
    self.mHighLightContent = highLightContent
    --设置文字的内容
    local contentTemp = content;
    if highLightContent ~= nil then
        local highLightContentTemp = "[00ff00]" .. highLightContent .. "[-]"
        contentTemp = string.gsub(contentTemp, highLightContent, highLightContentTemp)
    end
    self.mTips_UILabel.text = contentTemp
    --根据对话框的类型设置文字的相对位置,根据文字设置图片的高度宽度
    self.mBg_UISprite.width = self.mTips_UILabel.printedSize.x + 20
    self.mBg_UISprite.height = self.mTips_UILabel.printedSize.y

    if self.mDialogType == LuaEnumDialogTipsShapeType.RightBottomArrow_One then
        self.go.transform.localPosition = CS.UnityEngine.Vector3(self.originPosition.x + (self.mBg_UISprite.width - self.originWidth) / 4, self.originPosition.y + 10, self.originPosition.z);
    end
end

---初始化信息（写死,需要添加再加）
function UIDialogTipsTemplate1:InitInfo()
    self.mSpriteInfoList = {}
    local sprite1 = self:SetSprite(LuaEnumDialogTipsShapeType.RightBottomArrow_One, "fly", CS.UnityEngine.Vector3(-42.1, 43.7, 0), CS.UnityEngine.Vector2(6.9, -21.8), 8)
    local sprite2 = self:SetSprite(LuaEnumDialogTipsShapeType.RightArrow_Two, "heng", CS.UnityEngine.Vector3(-88.4, 31, 0), CS.UnityEngine.Vector2(-0.04, -0.32), 8)
    local sprite3 = self:SetSprite(LuaEnumDialogTipsShapeType.Three, "tis", CS.UnityEngine.Vector3(-88.2, -19.1, 0), CS.UnityEngine.Vector2(-0.04, -0.32), 2)
    table.insert(self.mSpriteInfoList, sprite1)
    table.insert(self.mSpriteInfoList, sprite2)
    table.insert(self.mSpriteInfoList, sprite3)
end

---设置图片
function UIDialogTipsTemplate1:SetSprite(dialogType, name, relativePos, closeBtnRelativePos, pivot)
    local sprite = {}
    --对话框类型
    sprite["DialogType"] = dialogType
    --圖片名字
    sprite["Name"] = name
    --總體相对位置
    sprite["RelativePos"] = relativePos
    --关闭按钮的相对坐标
    sprite["CloseBtnRelativePos"] = closeBtnRelativePos
    --背景圖片中心点
    sprite["Pivot"] = pivot
    return sprite
end

---倒计时消失
function UIDialogTipsTemplate1:IEnumRefreshTime(time)
    local isRefresh = true
    local refreshTime = time
    while isRefresh do
        if refreshTime <= 0 then
            isRefresh = false
            self:Hide()
        end
        refreshTime = refreshTime - 1
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    end
end

function UIDialogTipsTemplate1:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIDialogTipsTemplate1