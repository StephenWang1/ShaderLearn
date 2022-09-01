--- 帮助面板
local UIHelpTipsPanel = {}

--region 属性
--endregion 属性
--region 组件
---Grid
function UIHelpTipsPanel.GetSpriteGrid_UIGrid()
    if UIHelpTipsPanel.mSpriteGrid_UIGrid == nil then
        UIHelpTipsPanel.mSpriteGrid_UIGrid = UIHelpTipsPanel:GetCurComp('WidgetRoot/view/SpriteGrid', 'Top_UIGridContainer')
    end
    return UIHelpTipsPanel.mSpriteGrid_UIGrid
end
---内容
function UIHelpTipsPanel.GetContent_UILabel()
    if UIHelpTipsPanel.mContent_UILabel == nil then
        UIHelpTipsPanel.mContent_UILabel = UIHelpTipsPanel:GetCurComp('WidgetRoot/view/lb_text', 'UILabel')
    end
    return UIHelpTipsPanel.mContent_UILabel
end
---内容大小
function UIHelpTipsPanel.GetContent_UILabelDes()
    if UIHelpTipsPanel.mContent_UILabelDes == nil then
        UIHelpTipsPanel.mContent_UILabelDes = UIHelpTipsPanel:GetCurComp('WidgetRoot/view/lb_textdes', 'UILabel')
    end
    return UIHelpTipsPanel.mContent_UILabelDes
end

---描述new
function UIHelpTipsPanel.GetDesSpriteGrid()
    if UIHelpTipsPanel.mDesSpriteGrid == nil then
        UIHelpTipsPanel.mDesSpriteGrid = UIHelpTipsPanel:GetCurComp('WidgetRoot/view/Describe/grid', 'Top_UIGridContainer')
    end
    return UIHelpTipsPanel.mDesSpriteGrid
end



---外边框
function UIHelpTipsPanel.GetOutFrame_UISprite()
    if UIHelpTipsPanel.mOutFrame_UISprite == nil then
        UIHelpTipsPanel.mOutFrame_UISprite = UIHelpTipsPanel:GetCurComp('WidgetRoot/window/outframe', 'UISprite')
    end
    return UIHelpTipsPanel.mOutFrame_UISprite
end
---背景框
function UIHelpTipsPanel.GetBackGround_UISprite()
    if UIHelpTipsPanel.mBackGround_UISprite == nil then
        UIHelpTipsPanel.mBackGround_UISprite = UIHelpTipsPanel:GetCurComp('WidgetRoot/window/background', 'UISprite')
    end
    return UIHelpTipsPanel.mBackGround_UISprite
end

---标题
function UIHelpTipsPanel.GetTitle()
    if UIHelpTipsPanel.mTitle == nil then
        UIHelpTipsPanel.mTitle = UIHelpTipsPanel:GetCurComp('WidgetRoot/window/title', 'UILabel')
    end
    return UIHelpTipsPanel.mTitle
end


---窗口
function UIHelpTipsPanel.GetWindow_Transform()
    if UIHelpTipsPanel.mWindow_Transform == nil then
        UIHelpTipsPanel.mWindow_Transform = UIHelpTipsPanel:GetCurComp('WidgetRoot/window', 'Transform')
    end
    return UIHelpTipsPanel.mWindow_Transform
end

---视图
function UIHelpTipsPanel.GetView_Transform()
    if UIHelpTipsPanel.mView_Transform == nil then
        UIHelpTipsPanel.mView_Transform = UIHelpTipsPanel:GetCurComp('WidgetRoot/view', 'Transform')
    end
    return UIHelpTipsPanel.mView_Transform
end
---Mask
function UIHelpTipsPanel.GetMask_GameObject()
    if UIHelpTipsPanel.mMask_GameObject == nil then
        UIHelpTipsPanel.mMask_GameObject = UIHelpTipsPanel:GetCurComp('WidgetRoot/mask', 'GameObject')
    end
    return UIHelpTipsPanel.mMask_GameObject
end
--endregion 组件
--region 初始化
function UIHelpTipsPanel:Init()
    CS.UIEventListener.Get(self.go).onClick = function(go)
        uimanager:ClosePanel("UIHelpTipsPanel")
    end

end
---显示
function UIHelpTipsPanel:Show(...)
    UIHelpTipsPanel:RunBaseFunction("Show")

    --设置内容
    local contentTable = { ... }
    local data=contentTable[1]
    if data==nil or data.value==nil or data.remarks==nil then
        print("提示框传入数据错误，请检查数据格式----UIHelpTipsPanel:Show")
        return
    end
    local contentArray = string.Split(data.value, "#")
    local title = data.remarks
    local length = #contentArray
    local content = ""
    local rowOfEveryOne = {} --每一个内容的行数
    local totalRow = 0  --总行数
    --UTF8编码一个中文3字节
    local rowLength = UIHelpTipsPanel.GetContent_UILabel().lineWidth / UIHelpTipsPanel.GetContent_UILabel().fontSize * 3
    for i = 1, length do
        if i == length then
            content = content .. contentArray[i]
        else
            content = content .. contentArray[i] .. "\n"
        end
        local strLength = string.len(contentArray[i])
        local row = (strLength - strLength % rowLength) / rowLength + 1
        if strLength % rowLength == 0 then
            row = strLength / rowLength
        end
        rowOfEveryOne[i] = row
        totalRow = row + totalRow
    end
    --设置
    if title~=nil then
        UIHelpTipsPanel.GetTitle().text=title
    end
    local y = UIHelpTipsPanel:SetDes(contentArray, 15)
    if y ~= nil then
        self:GetBackGround_UISprite().height = math.abs(y) + 30
    end
end

--endregion 初始化
function UIHelpTipsPanel:SetDes(contentArray, interval)

    UIHelpTipsPanel.GetDesSpriteGrid().MaxCount = #contentArray
    UIHelpTipsPanel.GetDesSpriteGrid().transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    local position = CS.UnityEngine.Vector3(0, 0, 0)
    for i = 0, #contentArray - 1 do
        local item = UIHelpTipsPanel.GetDesSpriteGrid().controlList[i]
        if i == 0 then
            position = item.transform.localPosition
        end
        item.transform.localPosition = position
        local itemlabel = CS.Utility_Lua.GetComponent(item.transform:Find("desText"),"UILabel")
        if itemlabel ~= nil then
            itemlabel.text = contentArray[i + 1];
            itemlabel.trueTypeFont:RequestCharactersInTexture(itemlabel.text,itemlabel.fontSize,itemlabel.fontStyle)
        end
        position.y = position.y - itemlabel.height - interval
    end
    return position.y
end

return UIHelpTipsPanel