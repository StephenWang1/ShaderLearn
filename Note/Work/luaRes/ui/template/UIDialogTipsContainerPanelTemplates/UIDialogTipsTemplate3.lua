---对话框提示模板
local UIDialogTipsTemplate3 = {  }

function UIDialogTipsTemplate3:Init()
    self:InitComponents()
    self:InitOther()
end
--通过工具生成 控件变量
function UIDialogTipsTemplate3:InitComponents()
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
function UIDialogTipsTemplate3:InitOther()
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
    self.originPosition = nil;
    --间距
    self.space = 8

    CS.UIEventListener.Get(self.mCloseBtn_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.mCloseBtn_GameObject).OnClickLuaDelegate = self.OnClickCloseBtn
    CS.UIEventListener.Get(self.mTips_GameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.mTips_GameObject).OnClickLuaDelegate = self.OnClickContentBtn
    --CS.UIEventListener.Get(self.mHighLightContentBtn_GameObject).LuaEventTable = self
    --CS.UIEventListener.Get(self.mHighLightContentBtn_GameObject).OnClickLuaDelegate = self.OnClickHighLightContentBtn
end

---点击关闭按钮
function UIDialogTipsTemplate3:OnClickCloseBtn()
    if self.mCloseAction then
        self.mCloseAction(self)
    end
    self:Hide()
end
---点击高亮区域按钮(弃用)
function UIDialogTipsTemplate3:OnClickHighLightContentBtn()
    if self.mHighLightContentAction then
        self.mHighLightContentAction(self)
    end
    self:Hide()
end
---点击文字区域按钮
function UIDialogTipsTemplate3:OnClickContentBtn()
    if self.mContentAction then
        self.mContentAction(self)
    end
    self:Hide()
end

---显示
function UIDialogTipsTemplate3:Show(panel, content, closeAction, highLightContent, contentAction,time,dialogType)
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

    self:ResetContents(content, highLightContent)
    self:BgAdaptive()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
    if time ~= nil and time ~= 0 then

        self.IenumRefreshTime = StartCoroutine(UIDialogTipsTemplate3.IEnumRefreshTime, self, time)
    end
end
---隐藏（公开方法,外部调用）
function UIDialogTipsTemplate3:Hide()
    self.mContainerPanel.RemoveDialogTips(self.go, self.mDialogType)
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
function UIDialogTipsTemplate3:ResetContents(content, highLightContent)
    if content == nil then
        return
    end
    self.mContent = content
    self.mHighLightContent = highLightContent
    --设置文字的内容
    local contentTemp = content
    if highLightContent ~= nil then
        local highLightContentTemp = "[39ce1b]" .. highLightContent .. "[-]"
        contentTemp = string.gsub(contentTemp, highLightContent, highLightContentTemp)
    end
    self.mTips_UILabel.text = contentTemp
    self:SetPosition(self.go.transform.position)
end

function UIDialogTipsTemplate3:SetPosition(pos)
    self.go.transform.position = pos;
    self.originPosition = self.go.transform.localPosition;
    self.go.transform.localPosition = CS.UnityEngine.Vector3(self.originPosition.x + 160, self.originPosition.y, self.originPosition.z);
end

--背景自适应
function UIDialogTipsTemplate3:BgAdaptive()
    local tipsHeight = self.mTips_UILabel.height
    local labelspace = self.mTips_UILabel.spacingY
    --上层字体间隔
    self.mBg_UISprite.height = tipsHeight + self.space * 2 + labelspace
end


---倒计时消失
function UIDialogTipsTemplate3:IEnumRefreshTime(time)
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

function UIDialogTipsTemplate3:OnDestroy()
    if self.IenumRefreshTime ~= nil then
        StopCoroutine(self.IenumRefreshTime)
        self.IenumRefreshTime = nil
    end
end

return UIDialogTipsTemplate3