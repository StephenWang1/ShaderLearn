---对话提示容器面板
---@class UIDialogTipsContainerPanel:UIBase
local UIDialogTipsContainerPanel = {}

UIDialogTipsContainerPanel.PanelLayerType = CS.UILayerType.BasicPlane

UIDialogTipsContainerPanel.IsInitialLoad=true

function UIDialogTipsContainerPanel:GetRightArrowWithTweenPositionTips()
    if self.RightTweenTips == nil then
        self.RightTweenTips = templatemanager.GetNewTemplate(UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.RightArrowWithTweenPosition],UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.RightArrowWithTweenPosition])
    end
    return self.RightTweenTips
end

function UIDialogTipsContainerPanel:Init()
    UIDialogTipsContainerPanel.InitComponents()
    --region 测试代码
    --[[    local dataTipsData = {}
        dataTipsData.position = CS.UnityEngine.Vector3(116, 0, 0)
        dataTipsData.dialogType = LuaEnumDialogTipsShapeType.RightBottomArrow_One
        dataTipsData.contents = "路途遥远，免费传送，" .. "1秒后后自动点击"
        dataTipsData.highLightContent = "免费传送"
        dataTipsData.contentsWidth = 300
        UIDialogTipsContainerPanel.CreateDialogTips(dataTipsData)

        dataTipsData.position = CS.UnityEngine.Vector3(116, 300, 0)
        dataTipsData.dialogType = LuaEnumDialogTipsShapeType.Two
        dataTipsData.contents = "路途遥远，免费传送，" .. "1秒后后自动点击"
        dataTipsData.highLightContent = "免费传送"
        dataTipsData.contentsWidth = 200
        UIDialogTipsContainerPanel.CreateDialogTips(dataTipsData)

        dataTipsData.position = CS.UnityEngine.Vector3(116, 150, 0)
        dataTipsData.dialogType = LuaEnumDialogTipsShapeType.Four
        dataTipsData.contents = "路途遥远，免费传送，" .. "1秒后后自动点击"
        dataTipsData.highLightContent = "免费传送"
        dataTipsData.contentsWidth = 200
        UIDialogTipsContainerPanel.CreateDialogTips(dataTipsData)

        dataTipsData.position = CS.UnityEngine.Vector3(116, -150, 0)
        dataTipsData.dialogType = LuaEnumDialogTipsShapeType.Three
        dataTipsData.contents = "路途遥远，免费传送，" .. "1秒后后自动点击"
        dataTipsData.highLightContent = "免费传送"
        dataTipsData.contentsWidth = 200
        UIDialogTipsContainerPanel.CreateDialogTips(dataTipsData)
        dataTipsData.position = CS.UnityEngine.Vector3(0, 0, 0)
        dataTipsData.dialogType = LuaEnumDialogTipsShapeType.NoArrow
        dataTipsData.contents = "[dde6eb]路途遥远，免费传送，" .. "1秒后后自动点击[-]"
        dataTipsData.contentsWidth = 200
        UIDialogTipsContainerPanel.CreateDialogTips(dataTipsData)]]
    --endregion
end

--通过工具生成 控件变量
function UIDialogTipsContainerPanel.InitComponents()
    --对话框对象池
    UIDialogTipsContainerPanel.mDialogPool = {};
    for i, v in pairs(LuaEnumDialogTipsShapeType) do
        UIDialogTipsContainerPanel.mDialogPool[v] = {}
    end
    --模板
    UIDialogTipsContainerPanel.mLuaComponentDic = {};
    UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.RightBottomArrow_One] = luaComponentTemplates.UIDialogTipsTemplate1;
    UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.RightArrow_Two] = luaComponentTemplates.UIDialogTipsTemplate2;
    UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.BottomSquare_Three] = luaComponentTemplates.UIDialogTipsTemplate3;
    UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.NoArrow] = luaComponentTemplates.UIDialogTipsTemplate4
    UIDialogTipsContainerPanel.mLuaComponentDic[LuaEnumDialogTipsShapeType.RightArrowWithTweenPosition] =  luaComponentTemplates.UIDialogTipsTemplate5
    --预设
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic = {};
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.RightBottomArrow_One] = UIDialogTipsContainerPanel:GetCurComp("DialogTips1", "GameObject");
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.RightArrow_Two] = UIDialogTipsContainerPanel:GetCurComp("DialogTips2", "GameObject")
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.BottomSquare_Three] = UIDialogTipsContainerPanel:GetCurComp("DialogTips3", "GameObject")
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.NoArrow] = UIDialogTipsContainerPanel:GetCurComp("DialogTips4", "GameObject")
    UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[LuaEnumDialogTipsShapeType.RightArrowWithTweenPosition] = UIDialogTipsContainerPanel:GetCurComp("DialogTips5", "GameObject")
    --预设隐藏
    for k, v in pairs(UIDialogTipsContainerPanel.mDialogTipsGameObjectDic) do
        v:SetActive(false);
    end
end

function  UIDialogTipsContainerPanel.BindClientEvent()
    --luaEventManager.BindCallback(LuaCEvent.RecycleTipsIsOpenWithBagBtnClick, UIDialogTipsContainerPanel.BagPanelIsOpen)
    --luaEventManager.BindCallback(LuaCEvent.Bag_BagPanelIsClose, UIDialogTipsContainerPanel.BagPanelIsClose)
    --luaEventManager.BindCallback(LuaCEvent.Bag_ArrowBtnClicked, UIDialogTipsContainerPanel.BagPanelIsClose)
end


---创建对话提示
---@param data table
---@field data.position UnityEngine.Vector3 位置，以屏幕中心为原点
---@field data.dialogType Lua对话框形状类型 对话框形状类型
---@field data.logicType Lua对话框提示逻辑类型 对话框逻辑类型
---@field data.contents string 内容
---@field data.time     number 隐藏倒计时 （可空）单位s
---@field data.contentsWidth number 内容宽度
---@field data.closeAction function 关闭回调
---@field data.highLightContent string 高亮内容
----@field data.contentAction function 需要点击的内容回调
---@return table 返回你创建的模板
function UIDialogTipsContainerPanel.CreateDialogTips(data)
    if data == nil or data.dialogType == nil or data.contents == nil then
        return
    end
    local poolCount = #UIDialogTipsContainerPanel.mDialogPool[data.dialogType];
    local goTemp
    if poolCount >= 1 then
        goTemp = UIDialogTipsContainerPanel.mDialogPool[data.dialogType][poolCount]
        table.remove(UIDialogTipsContainerPanel.mDialogPool[data.dialogType])
    else
        local gobj = CS.UnityEngine.GameObject.Instantiate(UIDialogTipsContainerPanel.mDialogTipsGameObjectDic[data.dialogType])
        table.insert(UIDialogTipsContainerPanel.mDialogPool[data.dialogType], gobj);
        return UIDialogTipsContainerPanel.CreateDialogTips(data);
    end
    goTemp:SetActive(true)
    goTemp.transform:SetParent(UIDialogTipsContainerPanel.go.transform)
    local pos = ternary(data.position == nil, CS.UnityEngine.Vector3(0, 0, 0), data.position)
    goTemp.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    goTemp.transform.position = pos
    local template = templatemanager.GetNewTemplate(goTemp, UIDialogTipsContainerPanel.mLuaComponentDic[data.dialogType])
    template:Show(UIDialogTipsContainerPanel, data.contents, data.closeAction, data.highLightContent, data.contentAction, data.time, data.dialogType)
    return template
end

---显示右侧气泡
---@param commonData.tipsContent 文本内容
---@param commonData.point 节点
---@param commonData.clickFunc 点击方法
---@param commonData.state 显示状态
function UIDialogTipsContainerPanel.ShowRightTweenTips(commonData)
    if commonData == nil then
        return
    end
    if UIDialogTipsContainerPanel:GetRightArrowWithTweenPositionTips() ~= nil then
        UIDialogTipsContainerPanel:GetRightArrowWithTweenPositionTips():RefreshTips(commonData)
    end
end

---移除对话框(外部不准调用，请使用UIDialogTipsTemplate:Hide())
function UIDialogTipsContainerPanel.RemoveDialogTips(panelGo, type)
    if Utility.IsContainsValue(UIDialogTipsContainerPanel.mDialogPool[type], panelGo) == false then
        panelGo:SetActive(false)
        table.insert(UIDialogTipsContainerPanel.mDialogPool[type], panelGo)
    end
end

--region 气泡显示相关逻辑
--region 回收气泡
---尝试显示回收气泡
function UIDialogTipsContainerPanel.TryShowRecycleTipsAndChangeContent(commonData)
    if uiStaticParameter.MainHintPanel == nil then
        return
    end
    local mUIBagPanel = uimanager:GetPanel("UIBagPanel")
    local recycleBagItemTipsTemplate = uiStaticParameter.MainHintPanel:GetTableTemplate(LuaEnumMainHintType.RecycleBagItemTips)
    if mUIBagPanel ~= nil and recycleBagItemTipsTemplate ~= nil and recycleBagItemTipsTemplate:GetIsOn() and CS.Cfg_GlobalTableManager.Instance:ShowRecycleTips(mUIBagPanel:GetBagType()) and not UIDialogTipsContainerPanel:HavePanels(CS.Cfg_GlobalTableManager.Instance:GetHideRecycleTipsCreatePanelNameList()) then
        UIDialogTipsContainerPanel.recycleHintIsOpen = true
        UIDialogTipsContainerPanel.ShowRightTweenTips(commonData)
    else
        UIDialogTipsContainerPanel.recycleHintIsOpen = false
        UIDialogTipsContainerPanel.ShowRightTweenTips({state = false})
    end
end

---尝试关闭回收气泡
function UIDialogTipsContainerPanel.TryCloseRecycleTipsAndChangeContent(panelName)
    if CS.Cfg_GlobalTableManager.Instance:HideRecycleTips(panelName) then
        UIDialogTipsContainerPanel.ShowRightTweenTips({state = false})
    end
end

---查询是否包含相关的面板
---@param 面板名字列表
function UIDialogTipsContainerPanel:HavePanels(panelNameList)
    if panelNameList == nil or panelNameList.Count == 0 then
        return
    end
    local length = panelNameList.Count - 1
    for k = 0,length do
        if uimanager:GetPanel(panelNameList[k]) ~= nil then
            return true
        end
    end
    return false
end
--endregion
--endregion
return UIDialogTipsContainerPanel