---弹窗界面
---@class UIPromptPanel
local UIPromptPanel = {}

--region 变量
UIPromptPanel.PanelLayerType = CS.UILayerType.TopPlane
UIPromptPanel.mEnterCallBack = nil
UIPromptPanel.mCancelCallBack = nil
UIPromptPanel.mOptionBtnCallBack = nil
UIPromptPanel.mCloseBtnCallBack = nil
UIPromptPanel.mTimeEndCallBack = nil
UIPromptPanel.IEnumRefreshTime = nil
UIPromptPanel.mDestroyCallBack = nil
---确认按钮点击后是否关闭面板
UIPromptPanel.mIsClose = nil;
UIPromptPanel.isListenArrestCode = false
--endregion

--region 组件
---标题组件
function UIPromptPanel.GetTitleLabel_UILabel()
    if UIPromptPanel.mTitleLabel_UILabel == nil then
        UIPromptPanel.mTitleLabel_UILabel = UIPromptPanel:GetCurComp("view/Title", "UILabel")
    end
    return UIPromptPanel.mTitleLabel_UILabel
end

---内容组件
function UIPromptPanel.GetContentLabel_UILabel()
    if UIPromptPanel.mContentLabel_UILabel == nil then
        UIPromptPanel.mContentLabel_UILabel = UIPromptPanel:GetCurComp("view/Content", "UILabel")
    end
    return UIPromptPanel.mContentLabel_UILabel
end

---副内容组件-字体大小与主内容不一致
function UIPromptPanel.GetSubContentLabel_UILabel()
    if UIPromptPanel.mSubContentLabel_UILabel == nil then
        UIPromptPanel.mSubContentLabel_UILabel = UIPromptPanel:GetCurComp("view/SubContent", "UILabel")
    end
    return UIPromptPanel.mSubContentLabel_UILabel
end

---花费物品
function UIPromptPanel.GetGold_UISprite()
    if UIPromptPanel.mGold_UISprite == nil then
        UIPromptPanel.mGold_UISprite = UIPromptPanel:GetCurComp("view/itemgold/Sprite", "Top_UISprite")
    end
    return UIPromptPanel.mGold_UISprite
end

---花费数量
function UIPromptPanel.GetGoldCount_UILabel()
    if UIPromptPanel.mGoldCount_UILabel == nil then
        UIPromptPanel.mGoldCount_UILabel = UIPromptPanel:GetCurComp("view/itemgold", "UILabel")
    end
    return UIPromptPanel.mGoldCount_UILabel
end

---选项框
function UIPromptPanel.GetValueToggle_GameObject()
    if UIPromptPanel.mValueToggle_GameObject == nil then
        UIPromptPanel.mValueToggle_GameObject = UIPromptPanel:GetCurComp("view/toggle_value", "GameObject")
    end
    return UIPromptPanel.mValueToggle_GameObject
end

---@return UIToggle 是否选中
function UIPromptPanel.GetValueToggle_UIToggle()
    if UIPromptPanel.mValueToggle_UIToggle == nil then
        UIPromptPanel.mValueToggle_UIToggle = UIPromptPanel:GetCurComp("view/toggle_value", "UIToggle")
    end
    return UIPromptPanel.mValueToggle_UIToggle
end

---@return UIToggle 选中框文本
function UIPromptPanel.GetValueToggleText_Label()
    if UIPromptPanel.mValueToggleText_Label == nil then
        UIPromptPanel.mValueToggleText_Label = UIPromptPanel:GetCurComp("view/toggle_value/Label", "UILabel")
    end
    return UIPromptPanel.mValueToggleText_Label
end

---左按钮
function UIPromptPanel.GetLeftButton_GameObject()
    if UIPromptPanel.mLeftButton_GameObject == nil then
        UIPromptPanel.mLeftButton_GameObject = UIPromptPanel:GetCurComp("events/LeftBtn", "GameObject")
    end
    return UIPromptPanel.mLeftButton_GameObject
end

---左按钮文字
function UIPromptPanel.GetLeftButtonLabel_UILabel()
    if UIPromptPanel.mLeftButtonLabel_UILabel == nil then
        UIPromptPanel.mLeftButtonLabel_UILabel = UIPromptPanel:GetCurComp("events/LeftBtn/Label", "UILabel")
    end
    return UIPromptPanel.mLeftButtonLabel_UILabel
end

---右按钮
function UIPromptPanel.GetRightButton_GameObject()
    if UIPromptPanel.mRightButton_GameObject == nil then
        UIPromptPanel.mRightButton_GameObject = UIPromptPanel:GetCurComp("events/RightBtn", "GameObject")
    end
    return UIPromptPanel.mRightButton_GameObject
end

---右按钮文字
function UIPromptPanel.GetRightButtonLabel_UILabel()
    if UIPromptPanel.mRightButtonLabel_UILabel == nil then
        UIPromptPanel.mRightButtonLabel_UILabel = UIPromptPanel:GetCurComp("events/RightBtn/Label", "UILabel")
    end
    return UIPromptPanel.mRightButtonLabel_UILabel
end

---关闭按钮
function UIPromptPanel.GetCloseButton_GameObject()
    if UIPromptPanel.mCloseButton_GameObject == nil then
        UIPromptPanel.mCloseButton_GameObject = UIPromptPanel:GetCurComp("events/close", "GameObject")
    end
    return UIPromptPanel.mCloseButton_GameObject
end
---中间按钮
function UIPromptPanel.GetCenterButton_GameObject()
    if UIPromptPanel.mCenterButton == nil then
        UIPromptPanel.mCenterButton = UIPromptPanel:GetCurComp("events/CenterBtn", "GameObject")
    end
    return UIPromptPanel.mCenterButton
end
---中间按钮描述文本
function UIPromptPanel.GetCenterButtonLabel_UILabel()
    if UIPromptPanel.mCenterButtonLabel == nil then
        UIPromptPanel.mCenterButtonLabel = UIPromptPanel:GetCurComp("events/CenterBtn/Label", "UILabel")
    end
    return UIPromptPanel.mCenterButtonLabel
end
---倒计时
function UIPromptPanel.GetTimeLabel_UILabel()
    if UIPromptPanel.mTimeLabel == nil then
        UIPromptPanel.mTimeLabel = UIPromptPanel:GetCurComp("view/time", "UILabel")
    end
    return UIPromptPanel.mTimeLabel
end

---@return UICountdownLabel 倒计时
function UIPromptPanel.GetTimeLabel_UICountdownLabel()
    if UIPromptPanel.mCountdownTimeLabel == nil then
        UIPromptPanel.mCountdownTimeLabel = UIPromptPanel:GetCurComp("view/time", "UICountdownLabel")
    end
    return UIPromptPanel.mCountdownTimeLabel
end

function UIPromptPanel.GetPanel()
    if UIPromptPanel.panel == nil then
        UIPromptPanel.panel = CS.Utility_Lua.GetComponent(UIPromptPanel.go, "UIPanel")
    end
    return UIPromptPanel.panel
end

---@return UnityEngine.GameObject 中间按钮背景图
function UIPromptPanel:GetConfirmBtn_UISprite()
    if self.mConfirmBtn_UISprite == nil then
        self.mConfirmBtn_UISprite = self:GetCurComp("events/CenterBtn/Background", "UISprite")
    end
    return self.mConfirmBtn_UISprite
end

---@return UnityEngine.GameObject 右边按钮背景图
function UIPromptPanel:GetRightBtn_UISprite()
    if self.mRightBtn_UISprite == nil then
        self.mRightBtn_UISprite = self:GetCurComp("events/RightBtn/Background", "UISprite")
    end
    return self.mRightBtn_UISprite
end

---@return UnityEngine.GameObject 左边按钮背景图
function UIPromptPanel:GetLeftBtn_UISprite()
    if self.mLeftBtn_UISprite == nil then
        self.mLeftBtn_UISprite = self:GetCurComp("events/LeftBtn/Background", "UISprite")
    end
    return self.mLeftBtn_UISprite
end

---@return UISprite icon图片
function UIPromptPanel:GetIcon_UISprite()
    if self.mIcon_UISprite == nil then
        self.mIcon_UISprite = self:GetCurComp("view/icon", "UISprite")
    end
    return self.mIcon_UISprite
end

---@return UITable 勾选
function UIPromptPanel:GetChooseState_UITable()
    if self.mChooseState_UITable == nil then
        self.mChooseState_UITable = self:GetCurComp("view/ChooseState", "UITable")
    end
    return self.mChooseState_UITable
end

---@return UIToggle 勾选
function UIPromptPanel:GetChooseState_UIToggle()
    if self.mChooseState_UIToggle == nil then
        self.mChooseState_UIToggle = self:GetCurComp("view/ChooseState/chooseState", "UIToggle")
    end
    return self.mChooseState_UIToggle
end

---@return UILabel 勾选描述文本内容
function UIPromptPanel:GetChooseState_UILabel()
    if self.mChooseState_UILabel == nil then
        self.mChooseState_UILabel = self:GetCurComp("view/ChooseState/Label", "UILabel")
    end
    return self.mChooseState_UILabel
end
--endregion

--region 初始化
function UIPromptPanel:Init()
    UIPromptPanel.BindUIEvents()
end

---显示弹窗界面
---在调用uimanager:CreatePanel("UIPromptPanel", table)时传入data,不要单独调用

---@class PromptPanelInfo
---@field Title string 标题
---@field Content string 内容
---@field CallBack function 确认回调
---@field CancelCallBack function 取消回调
---@field TimeEndCallBack function 时间结束回调
---@field CloseCallBack   function 点击关闭回调
---@field LeftDescription string 左按钮描述文字
---@field RightDescription string 右按钮描述文字
---@field CenterDescription string 中间按钮描述文字
---@field IsToggleVisable boolean 选项框是否可见
---@field isOpenToggleVisabel boolean 选项框是否选中
---@field OptionBtnCallBack function 选项框按钮回调
---@field visabelText       string    选项框文本
---@field Time              number   时间 单位毫秒
---@field IsShowCloseBtn    boolean  是否显示右上角关闭按钮
---@field InitCallBack      function 首次进入回调
---@field DestroyCallBack XLua.Cast.Int32 层级
---@field IsClose           boolean  点击确定是否关闭面板（默认关闭）
---@field IsShowGoldLabel   boolean  是否显示花费(默认不显示)
---@field GoldIcon          string   花费图片
---@field GoldCount         string   花费数量
---@field TimeText         string  倒计时文本格式
---@field listenArrestCode boolean 是否监听错误码
---@field timeLittleChangeColor boolean 时间过少是否修改颜色
---@field ID number 表数据id
---@field TimeType LuaEnumSecondComfirmTimeType 二次确认时间类型
---@field iconSpriteName string icon名字
---@field IconClickCallBack function 点击icon事件
---@field ToggleStartState boolean 选择状态默认状态
---@field ToggleOnClick function 选择状态变更回调
---@field TimeColor string 倒计时颜色，默认红色
---@field itemGoldClickCallBack function 点击itemGold事件

---@param data PromptPanelInfo
function UIPromptPanel:Show(data)
    --UIPromptPanel:RunBaseFunction("Show")
    if data then
        self.mData = data
        if data.ID then
            self.ID = data.ID
        end
        local tableInfo = self:GetTableData()

        if isOpenLog then
            luaDebug.Log("  creatSuccess   ==== 》 UIPromptPanel" .. debug.traceback())
        end
        --标题
        UIPromptPanel.GetTitleLabel_UILabel().gameObject:SetActive(data.Title ~= nil);
        UIPromptPanel.GetTitleLabel_UILabel().text = ternary(data.Title == nil, "", data.Title)
        --内容
        local ShowInfo = ""
        if data.Content then
            ShowInfo = data.Content
        else
            if tableInfo then
                ShowInfo = tableInfo.des
            end
        end
        UIPromptPanel.GetContentLabel_UILabel().text = string.gsub(ShowInfo, '\\n', '\n')
        if (data.SubContent ~= nil) then
            --副内容
            UIPromptPanel.GetSubContentLabel_UILabel().text = ternary(data.SubContent == nil, "", string.gsub(data.SubContent, '\\n', '\n'))
        end
        --确认回调
        UIPromptPanel.mEnterCallBack = data.CallBack
        --取消回调
        UIPromptPanel.mCancelCallBack = data.CancelCallBack
        --关闭回调
        UIPromptPanel.mCloseBtnCallBack = data.CloseCallBack
        --选项回调
        UIPromptPanel.mOptionBtnCallBack = data.OptionBtnCallBack
        --倒计时结束回调
        UIPromptPanel.mTimeEndCallBack = data.TimeEndCallBack
        --确认按钮点击后是否关闭面板
        UIPromptPanel.mIsClose = data.IsClose == nil or data.IsClose;
        --时间类型
        UIPromptPanel.mTimeType = ternary(data.TimeType == nil, LuaEnumSecondComfirmTimeType.Second, data.TimeType)

        --Flashing表格ID
        UIPromptPanel.mtabFlashingID = data.TabFlashingID
        UIPromptPanel.isListenArrestCode = data.listenArrestCode ~= nil and data.listenArrestCode
        UIPromptPanel.timeLittleChangeColor = ternary(data.timeLittleChangeColor == nil, false, data.timeLittleChangeColor)

        local isCenter = false;
        local centerBtnText = "确 定"
        --增加获取表格数据判断按钮
        if tableInfo then
            if tableInfo.rightButton and tableInfo.rightButton ~= "" then
                isCenter = false
            else
                isCenter = true
            end
            centerBtnText = tableInfo.leftButton
        else
            -- 判断是否为中间按钮
            if (data.CenterDescription ~= nil and data.CenterDescription ~= "") then
                isCenter = true;
            else
                if (data.LeftDescription == nil or data.RightDescription == nil or data.LeftDescription == "" or data.RightDescription == "") then
                    if (data.LeftDescription ~= nil and data.LeftDescription ~= "") then
                        centerBtnText = data.LeftDescription;
                    elseif (data.RightDescription ~= nil and data.RightDescription ~= "") then
                        centerBtnText = data.RightDescription;
                    end
                    isCenter = true;
                else
                    isCenter = false;
                end
            end

            if (centerBtnText == nil) then
                centerBtnText = "确定";
            end
        end
        if data.CenterDescription then
            centerBtnText = data.CenterDescription
        end

        --endregion
        local leftDes = "取 消"
        local rightDes = "确 定"
        if tableInfo then
            leftDes = tableInfo.leftButton
            rightDes = tableInfo.rightButton
        end
        if data.LeftDescription then
            leftDes = data.LeftDescription
        end
        if data.RightDescription then
            rightDes = data.RightDescription
        end

        --左按钮文字,默认为 "取 消"
        UIPromptPanel.GetLeftButtonLabel_UILabel().text = leftDes
        --右按钮文字,默认为 "确 定"
        UIPromptPanel.GetRightButtonLabel_UILabel().text = rightDes
        --中间按钮文字，默认为"确 定"
        UIPromptPanel.GetCenterButtonLabel_UILabel().text = centerBtnText
        --选项框
        UIPromptPanel.GetValueToggle_GameObject():SetActive(ternary(data.IsToggleVisable == nil, false, data.IsToggleVisable))
        UIPromptPanel.GetValueToggle_UIToggle().value = data.isOpenToggleVisabel ~= nil and data.isOpenToggleVisabel
        if data.visabelText ~= nil and data.visabelText ~= "" then
            UIPromptPanel.GetValueToggleText_Label().text = data.visabelText
        end
        ----按钮显示
        UIPromptPanel.SetButton(not isCenter);
        --关闭按钮
        local isShowCloseBtn = ternary(data.IsShowCloseBtn == nil, true, data.IsShowCloseBtn)
        UIPromptPanel.GetCloseButton_GameObject():SetActive(isShowCloseBtn)
        --倒计时文本
        UIPromptPanel.TimeText = ternary(data.TimeText == nil, ternary(UIPromptPanel.mTimeType == LuaEnumSecondComfirmTimeType.Second, "倒计时：%02.0f", "倒计时 %02.0f:%02.0f"), data.TimeText)
        --倒计时
        UIPromptPanel.GetTimeLabel_UILabel().gameObject:SetActive(data.Time ~= nil and data.Time ~= 0)
        if data.TimeCallBack then
            data.TimeCallBack(UIPromptPanel.GetTimeLabel_UICountdownLabel())
        else
            if data.Time ~= nil then
                if UIPromptPanel.IEnumRefreshTime ~= nil then
                    StopCoroutine(UIPromptPanel.IEnumRefreshTime)
                    UIPromptPanel.IEnumRefreshTime = nil
                end
                UIPromptPanel.IEnumRefreshTime = StartCoroutine(UIPromptPanel.IEnumTimeCount, data.Time)
            end
        end
        UIPromptPanel.mDestroyCallBack = data.DestroyCallBack

        --region 设置花费
        if (UIPromptPanel.GetGold_UISprite()) then
            UIPromptPanel.GetGold_UISprite().gameObject:SetActive(data.IsShowGoldLabel ~= nil and data.IsShowGoldLabel)
            UIPromptPanel.GetGold_UISprite().spriteName = data.GoldIcon == nil and '' or data.GoldIcon
            UIPromptPanel.GetGoldCount_UILabel().text = data.GoldCount == nil and '' or data.GoldCount
            if data.itemGoldClickCallBack ~= nil then
                luaclass.UIRefresh:BindClickCallBack(self:GetGold_UISprite(), data.itemGoldClickCallBack)
            end
        end
        --endregion

        --region 设置icon
        UIPromptPanel.iconSpriteName = data.iconSpriteName
        if CS.StaticUtility.IsNullOrEmpty(UIPromptPanel.iconSpriteName) == false then
            luaclass.UIRefresh:RefreshSprite(self:GetIcon_UISprite(), UIPromptPanel.iconSpriteName)
            luaclass.UIRefresh:RefreshActive(self:GetIcon_UISprite(), true)
            if data.IconClickCallBack ~= nil then
                luaclass.UIRefresh:BindClickCallBack(self:GetIcon_UISprite(), data.IconClickCallBack)
            end
        end
        --endregion
        self:RefreshNormalData()
        --region 刷新选择
        self:RefreshToggle(data)
        --endregion
    end
end

function UIPromptPanel.SetButton(isShowTwoButton)
    --左按钮
    UIPromptPanel.GetLeftButton_GameObject():SetActive(isShowTwoButton)
    --右按钮
    UIPromptPanel.GetRightButton_GameObject():SetActive(isShowTwoButton)
    --中间按钮
    UIPromptPanel.GetCenterButton_GameObject():SetActive(not isShowTwoButton)
end

function UIPromptPanel.BindUIEvents()
    CS.UIEventListener.Get(UIPromptPanel.GetCloseButton_GameObject()).onClick = UIPromptPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIPromptPanel.GetLeftButton_GameObject()).onClick = UIPromptPanel.OnLeftButtonClicked
    CS.UIEventListener.Get(UIPromptPanel.GetRightButton_GameObject()).onClick = UIPromptPanel.OnRightButtonClicked
    CS.UIEventListener.Get(UIPromptPanel.GetValueToggle_GameObject()).onClick = UIPromptPanel.OnOptionBtnClicked
    CS.UIEventListener.Get(UIPromptPanel.GetCenterButton_GameObject()).onClick = UIPromptPanel.OnRightButtonClicked

end

--endregion

--region UI事件
---关闭按钮点击事件
function UIPromptPanel.OnCloseButtonClicked()
    if UIPromptPanel.mCloseBtnCallBack then
        UIPromptPanel.mCloseBtnCallBack()
    end
    uimanager:ClosePanel("UIPromptPanel")
end

---左按钮点击事件
function UIPromptPanel.OnLeftButtonClicked(go)
    local closePanel = true
    if UIPromptPanel.mCancelCallBack then
        closePanel = UIPromptPanel.mCancelCallBack(go)
    end
    if closePanel ~= false then
        uimanager:ClosePanel("UIPromptPanel")
    end
end

---右按钮点击事件
function UIPromptPanel.OnRightButtonClicked()
    if UIPromptPanel.mEnterCallBack then
        UIPromptPanel.mEnterCallBack(UIPromptPanel)
    end

    if (UIPromptPanel.mIsClose) then
        UIPromptPanel.ClosePanel()
    end
end

function UIPromptPanel.ClosePanel()
    uimanager:ClosePanel("UIPromptPanel")
end

---选项框按钮事件
function UIPromptPanel.OnOptionBtnClicked()
    if UIPromptPanel.mOptionBtnCallBack then
        UIPromptPanel.mOptionBtnCallBack(UIPromptPanel.GetValueToggle_UIToggle().value)
    end
end

function UIPromptPanel.GetLayer()
    local layer = UIPromptPanel.GetPanel().depth
    return layer
end
--endregion

--region 倒计时协程
---@param time number 倒计时 单位毫秒
function UIPromptPanel.IEnumTimeCount(time)
    local meetTime = true
    local totalTime = time * 0.001
    local color = luaEnumColorType.TimeCountRed
    if UIPromptPanel.mData and UIPromptPanel.mData.TimeColor then
        color = UIPromptPanel.mData.TimeColor
    end

    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            UIPromptPanel.GetTimeLabel_UILabel().text = color .. '倒计时：00'
            --发送终止
            StopCoroutine(UIPromptPanel.IEnumRefreshTime)
            UIPromptPanel.IEnumRefreshTime = nil
            if UIPromptPanel.mTimeEndCallBack ~= nil then
                UIPromptPanel.mTimeEndCallBack()
            end
        elseif totalTime <= 10 and UIPromptPanel.timeLittleChangeColor == true then
            color = luaEnumColorType.Red
        end
        local str = UIPromptPanel.TimeText
        if UIPromptPanel.mTimeType == LuaEnumSecondComfirmTimeType.Second then
            str = string.format(UIPromptPanel.TimeText, totalTime)
        elseif UIPromptPanel.mTimeType == LuaEnumSecondComfirmTimeType.MinuteAndSecond then
            local hour, minute, second = Utility.MillisecondToFormatTime(totalTime * 1000)
            str = string.format(UIPromptPanel.TimeText, minute, second)
        end
        if UIPromptPanel.GetTimeLabel_UILabel ~= nil then
            UIPromptPanel.GetTimeLabel_UILabel().text = color .. str
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1
    end
end

---刷新通用读表数据
function UIPromptPanel:RefreshNormalData()
    local desInfo = self:GetTableData()
    if desInfo then
        --刷新按钮
        local leftBtn = desInfo.leftButtonSprite
        local rightBtn = desInfo.rightButtonSprite
        if leftBtn then
            if not CS.StaticUtility.IsNull(self:GetConfirmBtn_UISprite()) then
                self:GetConfirmBtn_UISprite().spriteName = leftBtn
            end
            if not CS.StaticUtility.IsNull(self:GetLeftBtn_UISprite()) then
                self:GetLeftBtn_UISprite().spriteName = leftBtn
            end
        end
        if not CS.StaticUtility.IsNull(self:GetRightBtn_UISprite()) and rightBtn then
            self:GetRightBtn_UISprite().spriteName = rightBtn
        end
    end
end

---@return TABLE.CFG_PROMPTWORD
function UIPromptPanel:GetTableData()
    if self.mTableData == nil and self.ID then
        ___, self.mTableData = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(self.ID)
    end
    return self.mTableData
end

---刷新选择状态
---@param data PromptPanelInfo
function UIPromptPanel:RefreshToggle(data)
    if data == nil then
        return
    end
    local promptWorldTbl = clientTableManager.cfg_promptwordManager:TryGetValue(self.ID)
    if promptWorldTbl == nil or CS.StaticUtility.IsNullOrEmpty(promptWorldTbl:GetNote()) then
        return
    end
    luaclass.UIRefresh:RefreshActive(self:GetChooseState_UITable(), true)
    luaclass.UIRefresh:RefreshLabel(self:GetChooseState_UILabel(), promptWorldTbl:GetNote())
    luaclass.UIRefresh:BindToggle(self:GetChooseState_UIToggle(), data.ToggleOnClick, nil, data.ToggleStartState)
    luaclass.UIRefresh:RefreshUITable(self:GetChooseState_UITable())
end

--endregion

function ondestroy()
    if UIPromptPanel.IEnumRefreshTime ~= nil then
        StopCoroutine(UIPromptPanel.IEnumRefreshTime)
        UIPromptPanel.IEnumRefreshTime = nil
    end
    if UIPromptPanel.mDestroyCallBack then
        UIPromptPanel.mDestroyCallBack()
    end
end

return UIPromptPanel