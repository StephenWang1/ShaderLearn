---结婚证
local UIMarryCardPanel = {}

--region 局部变量
UIMarryCardPanel.isShowShareBtn = true
UIMarryCardPanel.cardInfo = nil
UIMarryCardPanel.marryDay = 1
--endregion

--region 初始化

function UIMarryCardPanel:Init()
    self:InitComponents()
    UIMarryCardPanel.BindUIEvents()
    UIMarryCardPanel.BindNetMessage()
end

---@param data marryV2.MarryCard  结婚证显示需要信息
---{
---@field data.man        marryV2.MarriedPeople     男方信息
---@field data.woman      marryV2.MarriedPeople     女方信息
---@field data.marryTime  number                    结婚日期
---@field data.pair       number                    夫妻编号
---@field data.serverId   number                    服务器id
---@field data.isShowShareBtn boolean               是否显示分享按钮
---}
function UIMarryCardPanel:Show(data)
    if data then
        UIMarryCardPanel.cardInfo = data
        --UIMarryCardPanel.marryDay = data.marryDay == nil and 0 or data.marryDay
        UIMarryCardPanel.isShowShareBtn = data.isShowShare == nil and true or data.isShowShare
    end
    UIMarryCardPanel.InitUI()
end

--- 初始化组件
function UIMarryCardPanel:InitComponents()
    ---@type Top_UISprite 我方icon
    UIMarryCardPanel.ourheadIcon = self:GetCurComp("WidgetRoot/marryCard/view/our/ourheadIcon", "Top_UISprite")
    ---@type Top_UILabel  我方名字
    UIMarryCardPanel.ourname = self:GetCurComp("WidgetRoot/marryCard/view/our/ourname", "Top_UILabel")
    ---@type Top_UISprite 爱人icon
    UIMarryCardPanel.loverheadIcon = self:GetCurComp("WidgetRoot/marryCard/view/lover/loverheadIcon", "Top_UISprite")
    ---@type Top_UILabel  爱人名字
    UIMarryCardPanel.lovername = self:GetCurComp("WidgetRoot/marryCard/view/lover/lovername", "Top_UILabel")
    ---@type Top_UILabel  结婚天数
    UIMarryCardPanel.lb_guide = self:GetCurComp("WidgetRoot/marryCard/view/lb_guide", "Top_UILabel")
    ---@type Top_UILabel  成亲时间
    UIMarryCardPanel.marryTime = self:GetCurComp("WidgetRoot/marryCard/view/marryTime", "Top_UILabel")
    ---@type Top_UILabel  夫妻编号
    UIMarryCardPanel.marryOrder = self:GetCurComp("WidgetRoot/marryCard/view/marryOrder", "Top_UILabel")
    ---@type UnityEngine.GameObject 分享按钮
    UIMarryCardPanel.share = self:GetCurComp("WidgetRoot/marryCard/events/share", "GameObject")
    ---@type UnityEngine.GameObject 关闭按钮
    UIMarryCardPanel.btn_close = self:GetCurComp("WidgetRoot/marryCard/events/btn_close", "GameObject")
end

function UIMarryCardPanel.BindUIEvents()

    --点击分享事件
    CS.UIEventListener.Get(UIMarryCardPanel.share).onClick = UIMarryCardPanel.OnClickshare
    --点击关闭事件
    CS.UIEventListener.Get(UIMarryCardPanel.btn_close).onClick = UIMarryCardPanel.OnClickbtn_close

end

function UIMarryCardPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听

--点击分享函数
---@param go UnityEngine.GameObject
function UIMarryCardPanel.OnClickshare(go)

end

--点击关闭函数
---@param go UnityEngine.GameObject
function UIMarryCardPanel.OnClickbtn_close(go)
    uimanager:ClosePanel('UIMarryCardPanel')
end

--endregion


--region 网络消息处理

--endregion

--region UI
function UIMarryCardPanel.InitUI()
    if UIMarryCardPanel.cardInfo == nil then
        return
    end
    UIMarryCardPanel.ourheadIcon.spriteName = 'headicon' .. tostring(UIMarryCardPanel.cardInfo.man.sex) .. tostring(UIMarryCardPanel.cardInfo.man.career)
    UIMarryCardPanel.ourname.text = UIMarryCardPanel.cardInfo.man.name
    UIMarryCardPanel.loverheadIcon.spriteName = 'headicon' .. tostring(UIMarryCardPanel.cardInfo.woman.sex) .. tostring(UIMarryCardPanel.cardInfo.woman.career)
    UIMarryCardPanel.lovername.text = UIMarryCardPanel.cardInfo.woman.name
    local dayTime = UIMarryCardPanel.cardInfo.marryTime / 1000
    dayTime = dayTime - dayTime % 1
    local dataInfo = os.date("成亲时间 %Y年%m月%d日", tonumber(dayTime))
    UIMarryCardPanel.marryTime.text = dataInfo
    local serverInfo = CS.HttpRequest.Instance.ServerFile:GetServerItem(UIMarryCardPanel.cardInfo.serverId)
    if serverInfo then
        UIMarryCardPanel.marryOrder.text = serverInfo.ServerName .. '的第' .. UIMarryCardPanel.cardInfo.pair .. '对夫妻'
    else
        UIMarryCardPanel.marryOrder.text = tostring(UIMarryCardPanel.cardInfo.serverId) .. '的第' .. UIMarryCardPanel.cardInfo.pair .. '对夫妻'
    end
    UIMarryCardPanel.share:SetActive(UIMarryCardPanel.isShowShareBtn)
    UIMarryCardPanel.CalculatMarryTime()
    UIMarryCardPanel.lb_guide.text = '我们在一起' .. tostring(UIMarryCardPanel.marryDay) .. '天了'
    UIMarryCardPanel.lb_guide.gameObject:SetActive(UIMarryCardPanel.marryDay ~= 0)
end

--endregion

--region otherFunction
--计算结婚天数
function UIMarryCardPanel.CalculatMarryTime()
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    local day = serverNowTime - UIMarryCardPanel.cardInfo.marryTime
    day = os.date("%d", day)
    UIMarryCardPanel.marryDay = string.format("%01.0f", tostring(day))
end

--endregion

--region ondestroy


--endregion

return UIMarryCardPanel