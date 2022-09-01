local UIDisposeOrePanel = {}

--region 局部变量
--确定按钮点击回调
UIDisposeOrePanel.rightBtnCallBack = nil
--取消按钮点击回调
UIDisposeOrePanel.leftBtnCallBack = nil
UIDisposeOrePanel.disposeaBtnCallBack = nil
--当前数字
UIDisposeOrePanel.num = 0

UIDisposeOrePanel.min = 0
UIDisposeOrePanel.max = 99
UIDisposeOrePanel.price = 0
UIDisposeOrePanel.isDesprice = false
--endregion

--region 初始化

function UIDisposeOrePanel:Init()
    self:InitComponents()
    UIDisposeOrePanel.BindUIEvents()
    UIDisposeOrePanel.BindNetMessage()
end

---@field info
---@param info.itemid             number    物品id
---@param info.price              number    价格
---@param info.priceSprite        string    货币icon
---@param info.rightBtnLabel      string    右按钮文本
---@param info.curValue           number    当前值
---@param info.minValue           number    最小值
---@param info.maxValue           number    最大值
---@param info.rightBtnCallBack   function  右按钮回调
---@param info.leftBtnCallBack    function  左按钮回调
---@param info.disposeaBtnCallBack function 调整数量按钮回调
---@param info.isDesprice          boolean 是否不显示货币
---@param info.IsShowItemTips      boolean 是否点击显示itemtips
---@end
function UIDisposeOrePanel:Show(info)
    if info == nil then
        return
    end
    UIDisposeOrePanel.min = info.minValue == nil and UIDisposeOrePanel.min or info.minValue
    UIDisposeOrePanel.max = info.maxValue == nil and UIDisposeOrePanel.max or info.maxValue
    UIDisposeOrePanel.num = info.curValue == 0 or info.curValue == nil and UIDisposeOrePanel.min or info.curValue
    UIDisposeOrePanel.rightBtnCallBack = info.rightBtnCallBack
    UIDisposeOrePanel.leftBtnCallBack = info.leftBtnCallBack
    UIDisposeOrePanel.disposeaBtnCallBack = info.disposeaBtnCallBack
    UIDisposeOrePanel.isDesprice = info.isDesprice == nil and false or info.isDesprice
    UIDisposeOrePanel.Tips.gameObject:SetActive(false)

    local isFind, Info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.itemid)
    if isFind then
        UIDisposeOrePanel.icon.spriteName = Info.icon
        UIDisposeOrePanel.name.text = Info.name
        if info.IsShowItemTips ~= nil and info.IsShowItemTips then
            CS.UIEventListener.Get(UIDisposeOrePanel.item).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = Info })
            end
        end

    end

    UIDisposeOrePanel.itemgold.gameObject:SetActive(not UIDisposeOrePanel.isDesprice)
    UIDisposeOrePanel.price = tostring(info.price)
    UIDisposeOrePanel.itemgold.text = string.format("%0.0f", UIDisposeOrePanel.price * UIDisposeOrePanel.num)
    UIDisposeOrePanel.inputcount.value = tostring(UIDisposeOrePanel.num)
    if info.priceSprite ~= nil then
        local goldicon = CS.Utility_Lua.GetComponent(UIDisposeOrePanel.itemgold.transform:Find('Sprite'), "Top_UISprite")
        if goldicon then
            goldicon.spriteName = info.priceSprite
        end
    end

    if info.rightBtnLabel ~= nil then
        local btnLabel = CS.Utility_Lua.GetComponent(UIDisposeOrePanel.dispose.transform:Find('Label'), "Top_UILabel")
        if btnLabel then
            btnLabel.text = info.rightBtnLabel
        end
    end
    UIDisposeOrePanel.Tips.gameObject:SetActive(false)
    --if UIDisposeOrePanel.num == 0 then
    --    UIDisposeOrePanel.ShowTips()
    --end
end

--- 初始化组件
function UIDisposeOrePanel:InitComponents()

    ---@type Top_UISprite icon
    UIDisposeOrePanel.icon = self:GetCurComp("view/UIItem/icon", "Top_UISprite")
    ---@type UnityEngine.GameObject
    UIDisposeOrePanel.item = self:GetCurComp("view/UIItem", "GameObject")
    ---@type Top_UILabel 名称
    UIDisposeOrePanel.name = self:GetCurComp("view/UIItem/name", "Top_UILabel")
    ---@type Top_UILabel 数量
    UIDisposeOrePanel.countLabel = self:GetCurComp("view/inputcount/Label", "Top_UILabel")
    ---@type Top_UILabel 价格
    UIDisposeOrePanel.itemgold = self:GetCurComp("view/itemgold", "Top_UILabel")
    ---@type Top_UILabel
    UIDisposeOrePanel.Tips = self:GetCurComp("view/Tips", "Top_UILabel")
    ---@type UnityEngine.GameObject 按钮减
    UIDisposeOrePanel.reduce = self:GetCurComp("view/reduce", "GameObject")
    ---@type UnityEngine.GameObject 按钮加
    UIDisposeOrePanel.add = self:GetCurComp("view/add", "GameObject")
    ---@type UnityEngine.GameObject 取消按钮
    UIDisposeOrePanel.btn_cancel = self:GetCurComp("view/btn_cancel", "GameObject")
    ---@type UnityEngine.GameObject 购买按钮
    UIDisposeOrePanel.dispose = self:GetCurComp("view/dispose", "GameObject")
    ---@type Top_UIInput
    UIDisposeOrePanel.inputcount = self:GetCurComp("view/inputcount", "Top_UIInput")
    ---@type Top_TweenAlpha
    UIDisposeOrePanel.Tipstween = self:GetCurComp("view/Tips", "Top_TweenAlpha")
end

function UIDisposeOrePanel.BindUIEvents()
    --点击加事件
    CS.UIEventListener.Get(UIDisposeOrePanel.add).onClick = UIDisposeOrePanel.OnClickadd
    --点击减事件
    CS.UIEventListener.Get(UIDisposeOrePanel.reduce).onClick = UIDisposeOrePanel.OnClickreduce
    --点击购买事件
    CS.UIEventListener.Get(UIDisposeOrePanel.dispose).onClick = UIDisposeOrePanel.OnClickdispose
    --点击取消事件
    CS.UIEventListener.Get(UIDisposeOrePanel.btn_cancel).onClick = UIDisposeOrePanel.OnClickbtn_cancel

    CS.EventDelegate.Add(UIDisposeOrePanel.inputcount.onChange, UIDisposeOrePanel.OnUIInputValueChanged);
end

function UIDisposeOrePanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

--region 函数监听

--点击加函数
---@param go UnityEngine.GameObject
function UIDisposeOrePanel.OnClickadd(go)
    UIDisposeOrePanel.num = tonumber(UIDisposeOrePanel.countLabel.text)
    if UIDisposeOrePanel.num >= UIDisposeOrePanel.max then
        if UIDisposeOrePanel.disposeaBtnCallBack ~= nil then
            UIDisposeOrePanel.disposeaBtnCallBack(UIDisposeOrePanel)
        end
        return
    end
    UIDisposeOrePanel.num = UIDisposeOrePanel.num + 1
    -- UIDisposeOrePanel.countLabel.text
    UIDisposeOrePanel.inputcount.value = tostring(UIDisposeOrePanel.num)
    if not UIDisposeOrePanel.isDesprice then
        UIDisposeOrePanel.itemgold.text = string.format("%0.0f", UIDisposeOrePanel.price * UIDisposeOrePanel.num)
    end
    UIDisposeOrePanel.num = tonumber(UIDisposeOrePanel.countLabel.text)
    if UIDisposeOrePanel.disposeaBtnCallBack ~= nil then
        UIDisposeOrePanel.disposeaBtnCallBack(UIDisposeOrePanel)
    end
end

--点击减函数
---@param go UnityEngine.GameObject
function UIDisposeOrePanel.OnClickreduce(go)
    UIDisposeOrePanel.num = tonumber(UIDisposeOrePanel.countLabel.text)
    if UIDisposeOrePanel.num <= UIDisposeOrePanel.min then
        return
    end
    UIDisposeOrePanel.num = UIDisposeOrePanel.num - 1
    -- UIDisposeOrePanel.countLabel.text
    UIDisposeOrePanel.inputcount.value = tostring(UIDisposeOrePanel.num)
    if not UIDisposeOrePanel.isDesprice then
        UIDisposeOrePanel.itemgold.text = string.format("%0.0f", UIDisposeOrePanel.price * UIDisposeOrePanel.num)
    end
    if UIDisposeOrePanel.disposeaBtnCallBack ~= nil then
        UIDisposeOrePanel.disposeaBtnCallBack(UIDisposeOrePanel)
    end
end

--点击购买函数
---@param go UnityEngine.GameObject
function UIDisposeOrePanel.OnClickdispose(go)
    UIDisposeOrePanel.num = tonumber(UIDisposeOrePanel.countLabel.text)
    if UIDisposeOrePanel.rightBtnCallBack ~= nil then
        UIDisposeOrePanel.rightBtnCallBack(UIDisposeOrePanel)
    end
end

--点击取消函数
---@param go UnityEngine.GameObject
function UIDisposeOrePanel.OnClickbtn_cancel(go)
    if UIDisposeOrePanel.leftBtnCallBack ~= nil then
        UIDisposeOrePanel.rightBtnCallBack()
    end
    uimanager:ClosePanel('UIDisposeOrePanel')
end

function UIDisposeOrePanel.OnUIInputValueChanged()
    if UIDisposeOrePanel.countLabel.text == "" then
        UIDisposeOrePanel.itemgold.text = ""
        return
    end
    UIDisposeOrePanel.num = tonumber(UIDisposeOrePanel.countLabel.text)
    if UIDisposeOrePanel.num > UIDisposeOrePanel.max then
        UIDisposeOrePanel.num = UIDisposeOrePanel.max
    end
    UIDisposeOrePanel.inputcount.value = tostring(UIDisposeOrePanel.num)
    UIDisposeOrePanel.itemgold.text = string.format("%0.0f", UIDisposeOrePanel.price * UIDisposeOrePanel.num)
end

--endregion


--region 网络消息处理

--endregion

--region UI
function UIDisposeOrePanel.ShowTips(str)
    if str ~= nil then
        UIDisposeOrePanel.Tips.text = str
    end
    UIDisposeOrePanel.Tips.gameObject:SetActive(false)
    UIDisposeOrePanel.Tips.gameObject:SetActive(true)
    UIDisposeOrePanel.Tipstween:PlayTween()
end
--endregion

--region otherFunction

--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.xx, MessageCallback)
end

--endregion

return UIDisposeOrePanel