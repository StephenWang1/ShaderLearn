---@class UIPurchasePromptPanel:UIBase 腕力精力药水推送面板
local UIPurchasePromptPanel = {}

--region 初始化

function UIPurchasePromptPanel:Init()
    self:InitComponents()
    UIPurchasePromptPanel.InitParameters()
    UIPurchasePromptPanel.BindUIEvents()
end

--- 初始化变量
function UIPurchasePromptPanel.InitParameters()
    UIPurchasePromptPanel.closeCallBack = nil
    UIPurchasePromptPanel.CenterBtnClick = nil
end

--- 初始化组件
function UIPurchasePromptPanel:InitComponents()
    ---@type Top_UILabel  文本显示
    UIPurchasePromptPanel.FirstContent = self:GetCurComp("view/FirstContent", "Top_UILabel")
    ---@type Top_UILabel  文本显示
    UIPurchasePromptPanel.SecondContent = self:GetCurComp("view/SecondContent", "Top_UILabel")
    ---@type UnityEngine.GameObject  道具
    UIPurchasePromptPanel.uiItem = self:GetCurComp("view/UIItem", "GameObject")
    ---@type Top_UISprite  道具icon
    UIPurchasePromptPanel.uiItemIcon = self:GetCurComp("view/UIItem/icon", "Top_UISprite")
    ---@type Top_UILabel  道具数量
    UIPurchasePromptPanel.uiItemCount = self:GetCurComp("view/UIItem/count", "Top_UILabel")
    ---@type Top_UILabel  花费数量
    UIPurchasePromptPanel.itemgold = self:GetCurComp("view/itemgold", "Top_UILabel")
    ---@type Top_UISprite  花费道具
    UIPurchasePromptPanel.itemGoldSprite = self:GetCurComp("view/itemgold/Sprite", "Top_UISprite")
    ---@type UnityEngine.GameObject  关闭按钮
    UIPurchasePromptPanel.closeBtn = self:GetCurComp("events/close", "GameObject")
    ---@type UnityEngine.GameObject  中间按钮
    UIPurchasePromptPanel.centerBtn = self:GetCurComp("events/CenterBtn", "GameObject")
    ---@type Top_UISprite  中间按钮bg
    UIPurchasePromptPanel.centerBtnBG = self:GetCurComp("events/CenterBtn/Background", "Top_UISprite")
    ---@type Top_UILabel  中间按钮label
    UIPurchasePromptPanel.centerBtnLabel = self:GetCurComp("events/CenterBtn/Label", "Top_UILabel")
end

function UIPurchasePromptPanel.BindUIEvents()
    --点击关闭事件
    CS.UIEventListener.Get(UIPurchasePromptPanel.closeBtn).onClick = UIPurchasePromptPanel.OnClickCloseBtn
    --点击中间按钮
    CS.UIEventListener.Get(UIPurchasePromptPanel.centerBtn).onClick = UIPurchasePromptPanel.OnClickCenterBtn
end

function UIPurchasePromptPanel.BindNetMessage()
    --commonNetMsgDeal.BindCallback(LuaEnumNetDef.xx, MessageCallback)
end
--endregion

--region 函数监听

---点击关闭函数
---@param go UnityEngine.GameObject
function UIPurchasePromptPanel.OnClickCloseBtn(go)
    uimanager:ClosePanel("UIPurchasePromptPanel")
end

---点击中间按钮
---@param go UnityEngine.GameObject
function UIPurchasePromptPanel.OnClickCenterBtn(go)
    if UIPurchasePromptPanel.CenterBtnClick ~= nil then
        UIPurchasePromptPanel.CenterBtnClick(go)
    end
end

--endregion

--region Show

---@private
---@alias customData {promptWordID:number,itemId:number,itemGoldID:number,itemGoldNumber:number,
---closeCallBack:function,centerBtnClick:function}
function UIPurchasePromptPanel:Show(customData)
    if customData == nil then
        UIPurchasePromptPanel.OnClickCloseBtn()
        return
    end
    if customData.closeCallBack ~= nil then
        UIPurchasePromptPanel.CloseCallBack = customData.closeCallBack
    end
    if customData.centerBtnClick ~= nil then
        UIPurchasePromptPanel.CenterBtnClick = customData.centerBtnClick
    end

    UIPurchasePromptPanel.InitItemGoldView(customData.itemGoldID, customData.itemGoldNumber)
    UIPurchasePromptPanel.InitItemView(customData.itemId)
    UIPurchasePromptPanel.InitOtherView(customData.promptWordID)
end

---初始化道具
---@private
function UIPurchasePromptPanel.InitItemView(itemId)
    if UIPurchasePromptPanel.uiItem == nil or CS.StaticUtility.IsNull(UIPurchasePromptPanel.uiItem) then
        return
    end
    if itemId == nil then
        UIPurchasePromptPanel.uiItem:SetActive(false)
        return
    end
    local isFind, itemTableInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
    if isFind then
        UIPurchasePromptPanel.uiItemIcon.spriteName = itemTableInfo.icon
        UIPurchasePromptPanel.uiItemCount.text = ''
        CS.UIEventListener.Get(UIPurchasePromptPanel.uiItemIcon.gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTableInfo, showRight = false })
        end
    end
end

---初始化花费
---@private
function UIPurchasePromptPanel.InitItemGoldView(itemGoldID, itemGoldNumber)
    if UIPurchasePromptPanel.itemgold == nil or CS.StaticUtility.IsNull(UIPurchasePromptPanel.itemgold.gameObject) then
        return
    end
    if itemGoldID == nil or itemGoldNumber == nil then
        UIPurchasePromptPanel.itemgold:SetActive(false)
        return
    end
    UIPurchasePromptPanel.itemgold.text = tostring(itemGoldNumber)
    local isFind, iteminfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemGoldID)
    if isFind then
        UIPurchasePromptPanel.itemGoldSprite.spriteName = iteminfo.icon
    end
end

---初始化其他（按钮，按钮颜色 及其他扩展）
---@private
function UIPurchasePromptPanel.InitOtherView(promptWordID)
    if promptWordID == nil then
        return
    end
    local isFind, PromptWordInfo = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(promptWordID)
    if not isFind then
        return
    end
    UIPurchasePromptPanel.centerBtnLabel.text = PromptWordInfo.leftButton
    UIPurchasePromptPanel.centerBtnBG.spriteName = PromptWordInfo.leftButtonSprite
    local Desinfo = string.Split(PromptWordInfo.des, '#')
    UIPurchasePromptPanel.FirstContent.text = #Desinfo > 0 and string.gsub(Desinfo[1], '\\n', '\n') or ''
    UIPurchasePromptPanel.SecondContent.text = #Desinfo > 1 and string.gsub(Desinfo[2], '\\n', '\n') or ''
end

--endregion

--region ondestroy

function ondestroy()
    if UIPurchasePromptPanel.CloseCallBack ~= nil then
        UIPurchasePromptPanel.CloseCallBack()
    end
end

--endregion

return UIPurchasePromptPanel