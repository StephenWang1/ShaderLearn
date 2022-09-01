---@class UIBagPanel:UIBase
local UIBagPanel = {}

local luaComponentTemplates = luaComponentTemplates
local LuaEnumBagType = LuaEnumBagType
local CSUnityEngineTime = CS.UnityEngine.Time

UIBagPanel.IsNeedActiveDuringInitialize = true

--region 属性
---获取当前游戏运行的时长,每帧刷新一次
---@return number
function UIBagPanel:GetTime()
    if self.mTime == nil then
        self.mTime = CS.UnityEngine.Time.time
    end
    return self.mTime
end

---该界面对应的背包信息
---@public
---@return CSBagInfoV2
function UIBagPanel:GetBagInfo()
    if self.mBagInfo == nil then
        if CS.CSScene.MainPlayerInfo then
            self.mBagInfo = CS.CSScene.MainPlayerInfo.BagInfo
        end
    end
    return self.mBagInfo
end

---背包每页格子数量
---@return number
function UIBagPanel:GetBagGridCountPerPage()
    return uiStaticParameter.UIBagPanel_BAGGRIDMAXCOUNT
end

---获取页根物体对应的页控制模板
---@param pageGO UnityEngine.GameObject
---@return UIBagPageCtrl
function UIBagPanel:GetPageControlTemplate(pageGO)
    if self.mPageControlTemplates == nil then
        self.mPageControlTemplates = {}
    end
    local template = self.mPageControlTemplates[pageGO]
    if template == nil then
        template = templatemanager.GetNewTemplate(pageGO, luaComponentTemplates.UIBagPageCtrl, self, self:GetBagGridCountPerPage())
        self.mPageControlTemplates[pageGO] = template
    end
    return template
end

---背包交互
---@return UIBagInteraction
function UIBagPanel:GetBagInteraction()
    if self.mBagInteraction == nil then
        self.mBagInteraction = templatemanager.GetNewTemplate(self.go, luaComponentTemplates.UIBagInteraction, self, self:GetBagDraggedItem(), self:GetScrollView())
    end
    return self.mBagInteraction
end

---被拖拽的物品
---@return UIBagDraggedItem
function UIBagPanel:GetBagDraggedItem()
    if self.mBagDraggedItem == nil then
        local mBagDraggedItemGO = self:GetCurComp("WidgetRoot/view/dragItem", "GameObject")
        if CS.StaticUtility.IsNull(mBagDraggedItemGO) == false then
            self.mBagDraggedItem = templatemanager.GetNewTemplate(mBagDraggedItemGO, luaComponentTemplates.UIBagDraggedItem, self)
        end
    end
    return self.mBagDraggedItem
end

---获取界面打开来源类型
---@return LuaEnumPanelOpenSourceType
function UIBagPanel:GetPanelOpenSourceType()
    return self.mPanelOpenSourceType
end
--endregion

--region 主控制器
--*********************************主控制器*********************************
---获取主控制器
---@public
---@return UIBagMainBasic
function UIBagPanel:GetBagMainController()
    return self.mBagMainController
end

--*********************************背包类型*********************************
---获取背包类型
---@public
---@return LuaEnumBagType
function UIBagPanel:GetBagType()
    return self.mBagType
end

---设置背包类型
---@protected
---@param mBagType LuaEnumBagType
---@param mCustomData UIBagPanelInputParam
---@param isChangeData boolean 是否更改数据
---@return LuaEnumBagType
function UIBagPanel:SetBagType(mBagType, mCustomData, isChangeData)
    if mBagType == nil then
        return
    end
    if self:GetBagType() == mBagType and self:GetBagMainController() ~= nil then
        self:GetBagMainController():OnDisable()
        if isChangeData then
            self:GetBagMainController().mCustomData = mCustomData
        end
        self:GetBagMainController():OnEnable()
        return
    end
    ---将前一个背包类型和背包控制器压入缓存池中
    local previousBagType = self.mBagType
    local previousBagMainController = self:GetBagMainController()
    if previousBagType and previousBagMainController then
        ---将前一个背包主控制器对应的背包类型压入对应的队列中
        self:AddBagTypeToQueue(previousBagType, previousBagMainController:IsExpandBagPanel())
        self:PushBagMainControllerToPool(previousBagType, previousBagMainController)
    end
    ---背包类型切换
    self.mBagType = mBagType
    ---从对象池中获取或创建一个控制器
    self.mBagMainController = self:PopBagMainControllerFromPool(mBagType)
    if self.mBagMainController == nil or CS.StaticUtility.IsNull(self.mBagMainController.go) then
        self:CreateAndSetBagMainController(mBagType, mCustomData)
    else
        if isChangeData then
            self.mBagMainController.mCustomData = mCustomData
        end
        self.mBagMainController.go:SetActive(true)
    end
    ---切换事件
    self:OnBagTypeSwitched(previousBagMainController, self.mBagMainController)
end

--*********************************对象池***********************************
---从对象池中弹出一个主控制器
---@protected
---@param mBagType LuaEnumBagType
---@return UIBagMainBasic
function UIBagPanel:PopBagMainControllerFromPool(mBagType)
    if self.mMainControllerPool == nil then
        return nil
    end
    local tbl = self.mMainControllerPool[mBagType]
    if tbl then
        self.mMainControllerPool[mBagType] = nil
    end
    return tbl
end

---向对象池中压入一个主控制器
---@protected
---@param mBagType LuaEnumBagType
---@param mBagMainController UIBagMainBasic
function UIBagPanel:PushBagMainControllerToPool(mBagType, mBagMainController)
    if mBagType and mBagMainController then
        if self.mMainControllerPool == nil then
            self.mMainControllerPool = {}
        end
        self.mMainControllerPool[mBagType] = mBagMainController
        if CS.StaticUtility.IsNull(mBagMainController.go) == false then
            mBagMainController.go:SetActive(false)
        end
    end
end

--*********************************实例化***********************************
---创建一个新的背包主控制器
---@protected
---@param mBagType LuaEnumBagType
---@param mCustomData UIBagPanelInputParam 输入的参数
function UIBagPanel:CreateAndSetBagMainController(mBagType, mCustomData)
    local template = self.mBagTypeToTemplate[mBagType]
    if template then
        local bagTypeStr = tostring(template.chunkName)
        if self.go and CS.StaticUtility.IsNull(self.go) == false then
            ---@type UnityEngine.GameObject
            local newGO = CS.Utility_Lua.CopyGO(self:GetControllerCopyTemplate(), self:GetStaticRootTrans())
            newGO.name = bagTypeStr
            newGO.transform:SetParent(self:GetStaticRoot_GameObject().transform)
            newGO:SetActive(false)
            ---必须要在此处对self.mBagMainController赋值,因为UIBagMainBasic的OnEnable方法中有引用了GetBagMainController方法的内容,需要在其调用之前就将主控制器进行赋值
            self.mBagMainController = templatemanager.GetNewTemplate(newGO, template, self, mBagType, self:GetBagGridCountPerPage(), mCustomData)
            newGO:SetActive(true)
        end
    else
        if isOpenLog then
            luaDebug.LogError("设置背包类型错误,未找到对应的主控制器 " .. tostring(previousBagType) .. " => " .. tostring(mBagType))
        end
    end
end

---获取静态Root的Transform
---@return UnityEngine.Transform
function UIBagPanel:GetStaticRootTrans()
    if self.mStaticRootTrans == nil then
        self.mStaticRootTrans = self:GetCurComp("StaticRoot", "Transform")
    end
    return self.mStaticRootTrans
end

---获取控制器的拷贝模板
---@return UnityEngine.GameObject
function UIBagPanel:GetControllerCopyTemplate()
    if self.mControllerCopyTemplate == nil then
        self.mControllerCopyTemplate = self:GetCurComp("StaticRoot/Controller", "GameObject")
    end
    return self.mControllerCopyTemplate
end
--endregion

--region 扩展/非扩展记录
--切换扩展状态时从对应历史记录中找到最近一次的背包类型
---将背包类型加入到队列
---@private
---@param bagType LuaEnumBagType 目标背包类型
---@param isExpand boolean 是否是扩展队列
function UIBagPanel:AddBagTypeToQueue(bagType, isExpand)
    if bagType then
        local bagTypeQueue = self:GetBagTypeQueue(isExpand)
        self:RemoveBagTypeFromQueue(bagType, isExpand)
        table.insert(bagTypeQueue, 1, bagType)
    end
end

---从队列中移除背包类型
---@private
---@param bagType LuaEnumBagType 目标背包类型
---@param isExpand boolean 是否是扩展队列
function UIBagPanel:RemoveBagTypeFromQueue(bagType, isExpand)
    if bagType then
        local bagTypeQueue = self:GetBagTypeQueue(isExpand)
        for i = 1, #bagTypeQueue do
            if bagTypeQueue[i] == bagType then
                table.remove(bagTypeQueue, i)
                break
            end
        end
    end
end

---获取一个最近的背包类型
---@private
---@param isExpand boolean
---@return LuaEnumBagType
function UIBagPanel:GetLatestBagType(isExpand)
    local bagType
    if isExpand then
        bagType = LuaEnumBagType.Recycle
    else
        bagType = self:PopBagTypeFromQueue(isExpand)
        if bagType == nil then
            bagType = LuaEnumBagType.Normal
        end
    end
    return bagType
end

---从队列中获取一个背包类型
---@private
---@param isExpand boolean
---@return LuaEnumBagType
function UIBagPanel:PopBagTypeFromQueue(isExpand)
    local bagTypeQueue = self:GetBagTypeQueue(isExpand)
    if #bagTypeQueue > 0 then
        local res = bagTypeQueue[1]
        table.remove(bagTypeQueue, 1)
        return res
    end
    return nil
end

---获取背包类型队列,表示在扩展状态或非扩展状态下背包类型的变化队列,索引越小说明切换时间越靠近当前时间
---@private
---@param isExpand boolean 是否是扩展队列
---@return table<number,LuaEnumBagType>
function UIBagPanel:GetBagTypeQueue(isExpand)
    if isExpand then
        if self.mExpandBagTypeQueue == nil then
            self.mExpandBagTypeQueue = {}
        end
        return self.mExpandBagTypeQueue
    else
        if self.mNonExpandBagTypeQueue == nil then
            self.mNonExpandBagTypeQueue = {}
        end
        return self.mNonExpandBagTypeQueue
    end
end
--endregion

--region 组件
---背包格子所在的主ScrollView所在的UIPanel
---@return UIPanel
function UIBagPanel:GetScrollView_UIPanel()
    if self.mScrollView_UIPanel == nil then
        self.mScrollView_UIPanel = self:GetCurComp("WidgetRoot/bagitems/Scroll View", "UIPanel")
    end
    return self.mScrollView_UIPanel
end

---获取背包格子的ScrollView组件
---@return UIScrollView
function UIBagPanel:GetScrollView()
    if self.mScrollView == nil then
        self.mScrollView = self:GetCurComp("WidgetRoot/bagitems/Scroll View", "UIScrollView")
    end
    return self.mScrollView
end

---页循环容器
---@public
---@return UIPageRecyclingContainer1T
function UIBagPanel:GetPageRecycleContainer()
    if self.mPageRecycleContainer == nil then
        self.mPageRecycleContainer = self:GetCurComp("WidgetRoot/bagitems/Scroll View", "UIPageRecyclingContainerForGameObject")
    end
    return self.mPageRecycleContainer
end

---页索引标识容器
---@return UIGridContainer
function UIBagPanel:GetPageIndexGridContainer()
    if self.mPageIndexGridContainer == nil then
        self.mPageIndexGridContainer = self:GetCurComp("WidgetRoot/view/grid", "UIGridContainer")
    end
    return self.mPageIndexGridContainer
end

---静态节点
---@return UnityEngine.GameObject
function UIBagPanel:GetStaticRoot_GameObject()
    if self.mStaticRoot_GO == nil then
        self.mStaticRoot_GO = self:GetCurComp("StaticRoot", "GameObject")
    end
    return self.mStaticRoot_GO
end

---获取格子物体组件的根节点
---@return UnityEngine.GameObject
function UIBagPanel:GetGridItemComponentsRootGO()
    if self.mGridItemComponentsRootGO == nil then
        self.mGridItemComponentsRootGO = self:GetCurComp("WidgetRoot/view/itemTemplateComponents", "GameObject")
    end
    return self.mGridItemComponentsRootGO
end

--region 左货币预设
---左货币展示游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetCoinLeft_GameObject()
    if self.mCoinLeft_GameObject == nil then
        self.mCoinLeft_GameObject = self:GetCurComp("WidgetRoot/view/coininfo/gold", "GameObject")
    end
    return self.mCoinLeft_GameObject
end

---左货币文本
---@return UILabel
function UIBagPanel:GetCoinLeft_UILabel()
    if self.mCoinLeft_UILabel == nil then
        self.mCoinLeft_UILabel = self:GetCurComp("WidgetRoot/view/coininfo/gold", "UILabel")
    end
    return self.mCoinLeft_UILabel
end

---左货币tween
---@return UILabel
function UIBagPanel:GetCoinLeft_TweenValue()
    if self.mCoinLeft_TweenValue == nil then
        self.mCoinLeft_TweenValue = self:GetCurComp("WidgetRoot/view/coininfo/gold", "Top_TweenValue")
    end
    return self.mCoinLeft_TweenValue
end

---左侧货币增加提醒的Label
---@return UILabel
function UIBagPanel:GetCoinLeftAddSign_Label()
    if self.mCoinLeftAddSign_Label == nil then
        self.mCoinLeftAddSign_Label = self:GetCurComp("WidgetRoot/view/coininfo/gold/addsign", "UILabel")
    end
    return self.mCoinLeftAddSign_Label
end

---左侧货币增加提醒的alpha tween
---@return Top_TweenAlpha
function UIBagPanel:GetCoinLeftAddSign_TweenAlpha()
    if self.mCoinLeftAddSign_TweenAlpha == nil then
        self.mCoinLeftAddSign_TweenAlpha = self:GetCurComp("WidgetRoot/view/coininfo/gold/addsign", "Top_TweenAlpha")
    end
    return self.mCoinLeftAddSign_TweenAlpha
end

---左侧货币增加提醒的position tween
---@return Top_TweenPosition
function UIBagPanel:GetCoinLeftAddSign_TweenPosition()
    if self.mCoinLeftAddSign_TweenPosition == nil then
        self.mCoinLeftAddSign_TweenPosition = self:GetCurComp("WidgetRoot/view/coininfo/gold/addsign", "Top_TweenPosition")
    end
    return self.mCoinLeftAddSign_TweenPosition
end

---左货币ICON
---@return UISprite
function UIBagPanel:GetCoinLeftIcon_UISprite()
    if self.mCoinLeftIcon_UISprite == nil then
        self.mCoinLeftIcon_UISprite = self:GetCurComp("WidgetRoot/view/coininfo/gold/img", "UISprite")
    end
    return self.mCoinLeftIcon_UISprite
end
--endregion

--region 右货币
---右货币展示游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetCoinRight_GameObject()
    if self.mCoinRight_GameObject == nil then
        self.mCoinRight_GameObject = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao", "GameObject")
    end
    return self.mCoinRight_GameObject
end

---右货币文本
---@return UILabel
function UIBagPanel:GetCoinRight_UILabel()
    if self.mCoinRight_UILabel == nil then
        self.mCoinRight_UILabel = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao", "UILabel")
    end
    return self.mCoinRight_UILabel
end

---右货币文本
---@return UILabel
function UIBagPanel:GetCoinRight_TweenValue()
    if self.mCoinRight_TweenValue == nil then
        self.mCoinRight_TweenValue = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao", "Top_TweenValue")
    end
    return self.mCoinRight_TweenValue
end

---右侧货币增加提醒的Label
---@return UILabel
function UIBagPanel:GetCoinRightAddSign_Label()
    if self.mCoinRightAddSign_Label == nil then
        self.mCoinRightAddSign_Label = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao/addsign", "UILabel")
    end
    return self.mCoinRightAddSign_Label
end

---右侧货币增加提醒的alpha tween
---@return Top_TweenAlpha
function UIBagPanel:GetCoinRightAddSign_TweenAlpha()
    if self.mCoinRightAddSign_TweenAlpha == nil then
        self.mCoinRightAddSign_TweenAlpha = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao/addsign", "Top_TweenAlpha")
    end
    return self.mCoinRightAddSign_TweenAlpha
end

---右侧货币增加提醒的position tween
---@return Top_TweenPosition
function UIBagPanel:GetCoinRightAddSign_TweenPosition()
    if self.mCoinRightAddSign_TweenPosition == nil then
        self.mCoinRightAddSign_TweenPosition = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao/addsign", "Top_TweenPosition")
    end
    return self.mCoinRightAddSign_TweenPosition
end

---右货币ICON
---@return UISprite
function UIBagPanel:GetCoinRightIcon_UISprite()
    if self.mCoinRightIcon_UISprite == nil then
        self.mCoinRightIcon_UISprite = self:GetCurComp("WidgetRoot/view/coininfo/yuanbao/img", "UISprite")
    end
    return self.mCoinRightIcon_UISprite
end
--endregion

--region 左下货币
---左下货币展示游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetCoinLeftDown_GameObject()
    if self.mCoinLeftDown_GameObject == nil then
        self.mCoinLeftDown_GameObject = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin", "GameObject")
    end
    return self.mCoinLeftDown_GameObject
end

---左下货币文本
---@return UILabel
function UIBagPanel:GetCoinLeftDown_UILabel()
    if self.mCoinLeftDown_UILabel == nil then
        self.mCoinLeftDown_UILabel = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin", "UILabel")
    end
    return self.mCoinLeftDown_UILabel
end

---左下货币文本
---@return UILabel
function UIBagPanel:GetCoinLeftDown_TweenValue()
    if self.mCoinLeftDown_TweenValue == nil then
        self.mCoinLeftDown_TweenValue = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin", "Top_TweenValue")
    end
    return self.mCoinLeftDown_TweenValue
end

---左下侧货币增加提醒的Label
---@return UILabel
function UIBagPanel:GetCoinLeftDownAddSign_Label()
    if self.mCoinLeftDownAddSign_Label == nil then
        self.mCoinLeftDownAddSign_Label = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin/addsign", "UILabel")
    end
    return self.mCoinLeftDownAddSign_Label
end

---左下侧货币增加提醒的alpha tween
---@return Top_TweenAlpha
function UIBagPanel:GetCoinLeftDownAddSign_TweenAlpha()
    if self.mCoinLeftDownAddSign_TweenAlpha == nil then
        self.mCoinLeftDownAddSign_TweenAlpha = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin/addsign", "Top_TweenAlpha")
    end
    return self.mCoinLeftDownAddSign_TweenAlpha
end

---左下侧货币增加提醒的position tween
---@return Top_TweenPosition
function UIBagPanel:GetCoinLeftDownAddSign_TweenPosition()
    if self.mCoinLeftDownAddSign_TweenPosition == nil then
        self.mCoinLeftDownAddSign_TweenPosition = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin/addsign", "Top_TweenPosition")
    end
    return self.mCoinLeftDownAddSign_TweenPosition
end

---左下货币ICON
---@return UISprite
function UIBagPanel:GetCoinLeftDownIcon_UISprite()
    if self.mCoinLeftDownIcon_UISprite == nil then
        self.mCoinLeftDownIcon_UISprite = self:GetCurComp("WidgetRoot/view/coininfo/equipCoin/img", "UISprite")
    end
    return self.mCoinLeftDownIcon_UISprite
end
--endregion

--region 右下货币
---右下货币展示游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetCoinRightDown_GameObject()
    if self.mCoinRightDown_GameObject == nil then
        self.mCoinRightDown_GameObject = self:GetCurComp("WidgetRoot/view/coininfo/diamond", "GameObject")
    end
    return self.mCoinRightDown_GameObject
end

---右下货币文本
---@return UILabel
function UIBagPanel:GetCoinRightDown_UILabel()
    if self.mCoinRightDown_UILabel == nil then
        self.mCoinRightDown_UILabel = self:GetCurComp("WidgetRoot/view/coininfo/diamond", "UILabel")
    end
    return self.mCoinRightDown_UILabel
end

---右下货币文本
---@return UILabel
function UIBagPanel:GetCoinRightDown_TweenValue()
    if self.mCoinRightDown_TweenValue == nil then
        self.mCoinRightDown_TweenValue = self:GetCurComp("WidgetRoot/view/coininfo/diamond", "Top_TweenValue")
    end
    return self.mCoinRightDown_TweenValue
end

---右下侧货币增加提醒的Label
---@return UILabel
function UIBagPanel:GetCoinRightDownAddSign_Label()
    if self.mCoinRightDownAddSign_Label == nil then
        self.mCoinRightDownAddSign_Label = self:GetCurComp("WidgetRoot/view/coininfo/diamond/addsign", "UILabel")
    end
    return self.mCoinRightDownAddSign_Label
end

---右下侧货币增加提醒的alpha tween
---@return Top_TweenAlpha
function UIBagPanel:GetCoinRightDownAddSign_TweenAlpha()
    if self.mCoinRightDownAddSign_TweenAlpha == nil then
        self.mCoinRightDownAddSign_TweenAlpha = self:GetCurComp("WidgetRoot/view/coininfo/diamond/addsign", "Top_TweenAlpha")
    end
    return self.mCoinRightDownAddSign_TweenAlpha
end

---右下侧货币增加提醒的position tween
---@return Top_TweenPosition
function UIBagPanel:GetCoinRightDownAddSign_TweenPosition()
    if self.mCoinRightDownAddSign_TweenPosition == nil then
        self.mCoinRightDownAddSign_TweenPosition = self:GetCurComp("WidgetRoot/view/coininfo/diamond/addsign", "Top_TweenPosition")
    end
    return self.mCoinRightDownAddSign_TweenPosition
end

---右下货币ICON
---@return UISprite
function UIBagPanel:GetCoinRightDownIcon_UISprite()
    if self.mCoinRightDownIcon_UISprite == nil then
        self.mCoinRightDownIcon_UISprite = self:GetCurComp("WidgetRoot/view/coininfo/diamond/img", "UISprite")
    end
    return self.mCoinRightDownIcon_UISprite
end
--endregion

---基础关闭按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetBaseCloseButton_GameObject()
    if self.mBaseCloseButton_GO == nil then
        self.mBaseCloseButton_GO = self:GetCurComp("WidgetRoot/window/windowBase/event/Btn_Close", "GameObject")
    end
    return self.mBaseCloseButton_GO
end

---扩展关闭按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandCloseButton_GameObject()
    if self.mExpandCloseButton_GO == nil then
        self.mExpandCloseButton_GO = self:GetCurComp("WidgetRoot/window/windowExpanded/event/Btn_Close", "GameObject")
    end
    return self.mExpandCloseButton_GO
end

---扩展关闭按钮2
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandCloseButto2_GameObject()
    if self.mExpandCloseButton2_GO == nil then
        self.mExpandCloseButton2_GO = self:GetCurComp("WidgetRoot/window/windowExpanded/event/Btn_Close2", "GameObject")
    end
    return self.mExpandCloseButton2_GO
end

---整理按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetTrimButton_GameObject()
    if self.mTrimButton_GO == nil then
        self.mTrimButton_GO = self:GetCurComp("WidgetRoot/event/Btn_Trim", "GameObject")
    end
    return self.mTrimButton_GO
end

---整理按钮文字
---@return UILabel
function UIBagPanel:GetTrimButtonLabel_UILabel()
    if self.mTrimButtonLabel_UILabel == nil then
        self.mTrimButtonLabel_UILabel = self:GetCurComp("WidgetRoot/event/Btn_Trim/Label", "UILabel")
    end
    return self.mTrimButtonLabel_UILabel
end

---展开按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandButton_GameObject()
    if self.mExpandButton_GO == nil then
        self.mExpandButton_GO = self:GetCurComp("WidgetRoot/event/Btn_Recycle", "GameObject")
    end
    return self.mExpandButton_GO
end

---展开按钮2
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandButton2_GameObject()
    if self.mExpandButton2_GameObject == nil then
        self.mExpandButton2_GameObject = self:GetCurComp("WidgetRoot/event/Btn_Recycle2", "GameObject")
    end
    return self.mExpandButton2_GameObject
end

---扩展部分根节点
---@return UnityEngine.GameObject
function UIBagPanel:GetRecyclePart_RootGO()
    if self.mRecyclePart_GO == nil then
        self.mRecyclePart_GO = self:GetCurComp("WidgetRoot/expandRoot", "GameObject")
    end
    return self.mRecyclePart_GO
end

---获取扩展按钮的图片
---@return UISprite
function UIBagPanel:GetExpandButtonSprite_UISprite()
    if self.mExpandButtonSprite_UISprite == nil then
        self.mExpandButtonSprite_UISprite = self:GetCurComp("WidgetRoot/event/Btn_Recycle/arrow", "UISprite")
    end
    return self.mExpandButtonSprite_UISprite
end

---扩展按钮的线
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandButtonLine_GO()
    if self.mExpandButtonLine_GO == nil then
        self.mExpandButtonLine_GO = self:GetCurComp("WidgetRoot/event/Btn_Recycle/line", "GameObject")
    end
    return self.mExpandButtonLine_GO
end

---扩展窗口游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetExpandWindow_GameObject()
    if self.mExpandWindow_GO == nil then
        self.mExpandWindow_GO = self:GetCurComp("WidgetRoot/window/windowExpanded", "GameObject")
    end
    return self.mExpandWindow_GO
end

---基础窗口游戏物体
---@return UnityEngine.GameObject
function UIBagPanel:GetBaseWindow_GameObject()
    if self.mBaseWindow_GO == nil then
        self.mBaseWindow_GO = self:GetCurComp("WidgetRoot/window/windowBase", "GameObject")
    end
    return self.mBaseWindow_GO
end

---气泡面板
---@return UIDialogTipsContainerPanel
function UIBagPanel:GetUIDialogTipsPanel()
    local uiDialogTipsPanel = uimanager:GetPanel("UIDialogTipsContainerPanel")
    return uiDialogTipsPanel
end

---Link
---@return UILinkerCollector
function UIBagPanel:GetUILinkerCollector()
    if self.mUILinkerCollector == nil then
        self.mUILinkerCollector = self:GetCurComp("", "UILinkerCollector")
    end
    return self.mUILinkerCollector
end

---回收toggl按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetRecycleToggle_GameObject()
    if self.mRecycleToggle_GO == nil then
        self.mRecycleToggle_GO = self:GetCurComp("WidgetRoot/expandRoot/events/RecycleToggle", "GameObject")
    end
    return self.mRecycleToggle_GO
end

---熔炼toggl按钮
---@return UnityEngine.GameObject
function UIBagPanel:GetSmeltToggle_GameObject()
    if self.mSmeltToggle_GO == nil then
        self.mSmeltToggle_GO = self:GetCurComp("WidgetRoot/expandRoot/events/SmeltToggle", "GameObject")
    end
    return self.mSmeltToggle_GO
end

--endregion

--region 初始化
--*********************************初始化***********************************
---初始化
---@protected
function UIBagPanel:Init()
    self:BindAllBagTypeAndTemplate()
    self:InitAllExpandGos()
    self:BindButtonEvents()
    self:InitializeCoins()
    self:BindClientEvents()
    self:BindLuaEvents()
    self:GetBagDraggedItem():SetActive(false)
end

---初始化
---type 表示传入的背包类型,默认为Normal类型;
---openSourceType 表示打开背包的类型,默认是Other
---chosenBagItemIDs 表示打开时选中的物品lid列表
---focusedBagItemInfo 表示打开时锁定的物品,若锁定的物品出现在背包中,则背包立刻翻到那一页
---@alias UIBagPanelInputParam {type:LuaEnumBagType,openSourceType:LuaEnumPanelOpenSourceType,chosenBagItemIDs:table<number,number>,focusedBagItemInfo:bagV2.BagItemInfo}
---@overload fun(customData:LuaEnumBagType)
---@protected
---@param customData UIBagPanelInputParam
function UIBagPanel:Show(customData)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.BagPanel
    local isTable, data = self:PreprocessCustomData(customData)
    if isTable then
        self:SetBagType(data.type, data, true)
    else
        self:SetBagType(data, nil, true)
    end
    if self:GetUIDialogTipsPanel() ~= nil then
        self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ tipsContent = uiStaticParameter.RecycleBubbleContent, point = self:GetExpandButtonSprite_UISprite().gameObject, state = true, clickFunc = function()
            uiStaticParameter.RecycleBubbleOnClick = true
            self:OnExpandButtonClicked()
        end })
    end
    --self:ShowClickArrowHint()
end

---预处理输入参数
---@private
---@param customData UIBagPanelInputParam
---@return boolean 是否为table
---@return UIBagPanelInputParam
function UIBagPanel:PreprocessCustomData(customData)
    if customData == nil then
        self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
        return false, LuaEnumBagType.Normal
    end
    local customDataType = type(customData)
    if customDataType == "number" then
        self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
        return false, customData
    end
    if customData.type == nil then
        customData.type = LuaEnumBagType.Normal
    elseif customData.type == LuaEnumBagType.Smelt then
        if not LuaGlobalTableDeal.IsOpenSmeltBag() then
            ---熔炼按钮不显示 改为打开回收
            customData.type = LuaEnumBagType.Recycle
        else
            ---如果熔炼未开启 则弹出气泡 并打开回收
            if not self:CheckOpenSmelt() then
                customData.type = LuaEnumBagType.Recycle
            end
        end
    end
    if customDataType == "table" and customData.openSourceType ~= nil then
        self.mPanelOpenSourceType = customData.openSourceType
    else
        if self.mPanelOpenSourceType == nil then
            self.mPanelOpenSourceType = LuaEnumPanelOpenSourceType.Other
        end
    end
    return true, customData
end

---绑定所有背包类型和模板,所有的背包的类型以及其对应的模板都需要在这里注册
---@private
function UIBagPanel:BindAllBagTypeAndTemplate()
    if CS.StaticUtility.IsNull(self:GetGridItemComponentsRootGO()) == false then
        self:GetGridItemComponentsRootGO():SetActive(false)
    end
    ---@type table<LuaEnumBagType,UIBagMainBasic>
    self.mBagTypeToTemplate = {}
    self.mBagTypeToTemplate[LuaEnumBagType.Normal] = luaComponentTemplates.UIBagMainNormal
    self.mBagTypeToTemplate[LuaEnumBagType.Recycle] = luaComponentTemplates.UIBagMainRecycle
    self.mBagTypeToTemplate[LuaEnumBagType.Skill] = luaComponentTemplates.UIBagMainSkill
    self.mBagTypeToTemplate[LuaEnumBagType.Role] = luaComponentTemplates.UIBagMainRole
    self.mBagTypeToTemplate[LuaEnumBagType.Servant] = luaComponentTemplates.UIBagMainServant
    self.mBagTypeToTemplate[LuaEnumBagType.PlayerWarehouse] = luaComponentTemplates.UIBagMainPlayerWarehouse
    self.mBagTypeToTemplate[LuaEnumBagType.Material] = luaComponentTemplates.UIBagMainMaterial
    self.mBagTypeToTemplate[LuaEnumBagType.Strength] = luaComponentTemplates.UIBagMainStrengthen
    self.mBagTypeToTemplate[LuaEnumBagType.Transfer] = luaComponentTemplates.UIBagMain_Transfer
    self.mBagTypeToTemplate[LuaEnumBagType.Repair] = luaComponentTemplates.UIBagMain_Repair
    self.mBagTypeToTemplate[LuaEnumBagType.ServantRepairBag] = luaComponentTemplates.UIBagMain_ServantRepair
    self.mBagTypeToTemplate[LuaEnumBagType.SkillConfig] = luaComponentTemplates.UIBagMain_SkillConfig
    self.mBagTypeToTemplate[LuaEnumBagType.Bundle] = luaComponentTemplates.UIBagMain_WarehouseBundle
    self.mBagTypeToTemplate[LuaEnumBagType.Evolution] = luaComponentTemplates.UIBagMain_Evolution
    self.mBagTypeToTemplate[LuaEnumBagType.Synthesis] = luaComponentTemplates.UIBagMain_Synthesis
    self.mBagTypeToTemplate[LuaEnumBagType.Mosaic] = luaComponentTemplates.UIBagMain_Mosaic
    self.mBagTypeToTemplate[LuaEnumBagType.ElementHint] = luaComponentTemplates.UIBagMain_ElementHint
    self.mBagTypeToTemplate[LuaEnumBagType.SignetHint] = luaComponentTemplates.UIBagMain_SignetHint
    self.mBagTypeToTemplate[LuaEnumBagType.Stall] = luaComponentTemplates.UIBagMain_Stall
    self.mBagTypeToTemplate[LuaEnumBagType.UnFinishFirstMission] = luaComponentTemplates.UIBagMain_UnFinishFirstMission
    self.mBagTypeToTemplate[LuaEnumBagType.UnionSummonTokenHint] = luaComponentTemplates.UIBagMain_UnionSummonToken
    self.mBagTypeToTemplate[LuaEnumBagType.Servant_HighLv] = luaComponentTemplates.UIBagMain_ServantHighLv
    self.mBagTypeToTemplate[LuaEnumBagType.Trade] = luaComponentTemplates.UIBagMain_Trade
    self.mBagTypeToTemplate[LuaEnumBagType.HeartSkill] = luaComponentTemplates.UIBagMain_HeartSkill
    self.mBagTypeToTemplate[LuaEnumBagType.HighRecycle] = luaComponentTemplates.UIBagMain_HighRecycle
    self.mBagTypeToTemplate[LuaEnumBagType.Refine] = luaComponentTemplates.UIBagMain_Refine
    self.mBagTypeToTemplate[LuaEnumBagType.Smelt] = luaComponentTemplates.UIBagMain_Smelt
    self.mBagTypeToTemplate[LuaEnumBagType.BloodSuitSmelt] = luaComponentTemplates.UIBagMain_BloodSuitSmelt
    self.mBagTypeToTemplate[LuaEnumBagType.BloodSuit] = luaComponentTemplates.UIBagMain_BloodSuit
    self.mBagTypeToTemplate[LuaEnumBagType.ForgeBloodSmelt] = luaComponentTemplates.UIBagMain_ForgeGodPowerSmelt
    self.mBagTypeToTemplate[LuaEnumBagType.AgainRefine] = luaComponentTemplates.UIBagMain_AgainRefine
    self.mBagTypeToTemplate[LuaEnumBagType.Collection] = luaComponentTemplates.UIBagMain_Collection
    self.mBagTypeToTemplate[LuaEnumBagType.CollectionRecycle] = luaComponentTemplates.UIBagMain_CollectionRecycle
    self.mBagTypeToTemplate[LuaEnumBagType.JianDing] = luaComponentTemplates.UIBagMain_JianDing
    self.mBagTypeToTemplate[LuaEnumBagType.ForgeQuench] = luaComponentTemplates.UIBagMain_ForgeQuench
end

---绑定UI事件
---@private
function UIBagPanel:BindButtonEvents()
    CS.UIEventListener.Get(self:GetBaseCloseButton_GameObject()).onClick = function()
        self:OnCloseButtonClicked()
    end
    CS.UIEventListener.Get(self:GetExpandCloseButton_GameObject()).onClick = function()
        self:OnExpandCloseButtonOnClicked()
    end
    CS.UIEventListener.Get(self:GetExpandCloseButto2_GameObject()).onClick = function()
        self:OnCloseButtonClicked()
    end
    CS.UIEventListener.Get(self:GetTrimButton_GameObject()).onClick = function()
        self:OnTrimButtonClicked()
    end
    CS.UIEventListener.Get(self:GetExpandButton_GameObject()).onClick = function()
        self:OnExpandButtonClicked()
    end
    CS.UIEventListener.Get(self:GetExpandButton2_GameObject()).onClick = function()
        self:RecycleBtnOnClicked()
    end
    CS.UIEventListener.Get(self:GetRecycleToggle_GameObject()).onClick = function(go)
        self:OnChangeToggleCallBack(go, LuaEnumBagType.Recycle)
    end
    CS.UIEventListener.Get(self:GetSmeltToggle_GameObject()).onClick = function(go)
        self:OnChangeToggleCallBack(go, LuaEnumBagType.Smelt)
    end
end

---绑定客户端事件
---@private
function UIBagPanel:BindClientEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshCoins()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        if self:GetBagMainController() then
            self:GetBagMainController():SetBagInfoIsDirty()
        end
        self:RefreshGrids()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        if self:GetBagMainController() then
            self:GetBagMainController():RefreshTrimLabel()
            self:GetBagMainController():SetBagInfoIsDirty()
            self:RefreshGrids()
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateReincarnation, function()
        if self:GetBagMainController() then
            self:GetBagMainController():SetBagInfoIsDirty()
            self:GetBagMainController():RefreshGrids()
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemIntensified, function()
        if self:GetBagMainController() then
            self:GetBagMainController():SetBagInfoIsDirty()
        end
        self:RefreshGrids()
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.OpenPanel, function(id, panelName)
        if self:GetUIDialogTipsPanel() ~= nil then
            self:GetUIDialogTipsPanel().TryCloseRecycleTipsAndChangeContent(panelName)
        end
        if self:GetBagMainController() ~= nil then
            self:GetBagMainController():OnPanelOpened(panelName)
        end
    end)
    self:GetClientEventHandler():AddEvent(CS.CEvent.ClosePanel, function(id, panelName)
        if UIBagPanel:GetBagMainController() ~= nil then
            UIBagPanel:GetBagMainController():PanelClose(panelName)
        end
    end)
    self:GetUILinkerCollector().onMovingFinished = function()
        self:ShowClickArrowHint()
        if self:GetUIDialogTipsPanel() ~= nil then
            self:GetUIDialogTipsPanel():GetRightArrowWithTweenPositionTips():RefreshPositionParams()
        end
    end
end

---绑定lua事件
---@private
function UIBagPanel:BindLuaEvents()
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Role_ArrowBtnClicked, UIBagPanel.RoleArrowBtnClicked)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.ServantArrowClicked, UIBagPanel.ServantArrowBtnClicked)
    --luaEventManager.BindCallback(LuaCEvent.Role_ArrowBtnClicked, UIBagPanel.RoleArrowBtnClicked)
    --luaEventManager.BindCallback(LuaCEvent.ServantArrowClicked, UIBagPanel.ServantArrowBtnClicked)
    self:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Bag_AutoRecycleUse, function()
        self:RecycleBtnOnClicked()
    end)
end
--endregion

--region 扩展界面
---初始化所有扩展界面物体
---@private
function UIBagPanel:InitAllExpandGos()
    ---@type table<LuaEnumBagPanelExpandType, UnityEngine.GameObject>
    self.mExpandBagTypeToGameObject = {}
    self.mExpandBagTypeToGameObject[LuaEnumBagPanelExpandType.Recycle] = self:GetCurComp("WidgetRoot/expandRoot", "GameObject")
    self.mExpandBagTypeToGameObject[LuaEnumBagPanelExpandType.Collection] = self:GetCurComp("WidgetRoot/expandRoot_collection", "GameObject")
end

---显示扩展部分的界面
---@param isExpandPanel boolean
---@param expandType LuaEnumBagPanelExpandType
function UIBagPanel:ShowExpandByExpandType(isExpandPanel, expandType)
    ---扩展时才显示回收等扩展部分
    for i, v in pairs(self.mExpandBagTypeToGameObject) do
        if i == expandType and isExpandPanel then
            v:SetActive(true)
        else
            v:SetActive(false)
        end
    end
    ---扩展时才显示展开按钮旁边的线
    self:GetExpandButtonLine_GO():SetActive(isExpandPanel)
    ---扩展时才显示扩展窗口
    self:GetExpandWindow_GameObject():SetActive(isExpandPanel)
    ---扩展时不显示基础窗口
    self:GetBaseWindow_GameObject():SetActive(not isExpandPanel)
    ---切换扩展按钮的图片
    self:GetExpandButtonSprite_UISprite().spriteName = isExpandPanel and "open2" or "open1"
end
--endregion

--region 事件
--*********************************lua事件***********************************
---背包类型变化事件
---@protected
---@param previousBagMainController UIBagMainBasic 变化前的控制器
---@param currentBagMainController UIBagMainBasic 变化后的控制器
function UIBagPanel:OnBagTypeSwitched(previousBagMainController, currentBagMainController)
    ---背包类型变化时,若扩展属性变化,则刷新一次UILinker组件,防止扩展界面和普通界面切换导致的位置不匹配
    if previousBagMainController == nil or currentBagMainController == nil or (previousBagMainController:IsExpandBagPanel() ~= currentBagMainController:IsExpandBagPanel()) then
        self:RefreshLinksImmediately()
    end
    ---背包交互中背包类型变化响应
    if self:GetBagInteraction() ~= nil then
        self:GetBagInteraction():OnBagTypeChanged()
    end
end

---角色箭头按钮点击事件
function UIBagPanel.RoleArrowBtnClicked(id, data)
    if data.OpendataDelta == luaEnumRolePanelType.Base and (UIBagPanel:GetBagType() == LuaEnumBagType.Recycle or UIBagPanel:GetBagType() == LuaEnumBagType.Smelt) then
        UIBagPanel:OnExpandButtonClicked()
    end
end

---灵兽箭头按钮点击事件
function UIBagPanel.ServantArrowBtnClicked(id, data)
    if data == LuaEnumServantEquipType.Show and (UIBagPanel:GetBagType() == LuaEnumBagType.Recycle or UIBagPanel:GetBagType() == LuaEnumBagType.Smelt) then
        UIBagPanel:OnExpandButtonClicked()
    end
end

--*********************************UI事件**********************************
---关闭按钮点击事件
---@private
function UIBagPanel:OnCloseButtonClicked()
    if self:GetBagMainController() ~= nil then
        if self:GetBagMainController():OnBagCloseButtonClicked() then
            uimanager:ClosePanel(self)
        end
    else
        uimanager:ClosePanel(self)
    end
end

---扩展关闭按钮点击事件
---@private
function UIBagPanel:OnExpandCloseButtonOnClicked()
    if self:GetBagMainController() ~= nil then
        if self:GetBagMainController():GetBagType() == LuaEnumBagType.Recycle then
            self:OnExpandButtonClicked()
        elseif self:GetBagMainController():OnBagCloseButtonClicked() then
            uimanager:ClosePanel(self)
        end
    else
        uimanager:ClosePanel(self)
    end
end

---整理按钮点击事件
---@private
function UIBagPanel:OnTrimButtonClicked()
    if self:GetBagMainController() then
        self:GetBagMainController():DoTrim()
    end
end

---回收按钮点击事件
---@private
function UIBagPanel:RecycleBtnOnClicked()
    if LuaGlobalTableDeal:IsShowQuickRecycle() == false then
        Utility.OpenRecycleHint()
        return
    end
    self:OnExpandButtonClicked()
end

---扩展按钮点击事件
---@private
function UIBagPanel:OnExpandButtonClicked()
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():ClearRecycleItemDefaultStateDic()
    if self:GetBagMainController() then
        local isExpand = self:GetBagMainController():IsExpandBagPanel() == false
        local reversedBagType = self:GetBagMainController():GetReversedExpandBagType()
        ---设置背包类型时不更改数据
        if reversedBagType == nil then
            self:SetBagType(self:GetLatestBagType(isExpand))
        else
            self:SetBagType(reversedBagType)
        end
        self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
    end
    if luaEventManager.HasCallback(LuaCEvent.Bag_ArrowBtnClicked) then
        luaEventManager.DoCallback(LuaCEvent.Bag_ArrowBtnClicked, self)
    end
    self:GetBagInfo():ClearRecycleRemainNumDic()
    self:RemoveArrowHint(true)
end

function UIBagPanel:OnChangeToggleCallBack(go, type)
    ---设置背包类型时不更改数据
    self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
    self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
    if type == LuaEnumBagType.Recycle then
        ---设置背包类型时不更改数据
        self:SetBagType(type)
        self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
    elseif type == LuaEnumBagType.Smelt then
        if self:CheckOpenSmelt() then
            self:SetBagType(type)
        end
    end
    --self:SetBagType(type)
    --self:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
end

--endregion

--region 刷新
---刷新全部
---@public
function UIBagPanel:RefreshGrids()
    UIBagPanel.mNeedRefreshAllGrids = true
end

---刷新某个背包物品
---@public
---@param bagItemID number 需要刷新的背包物品的lid
function UIBagPanel:RefreshBagItem(bagItemID)
    local grid = self:GetBagGrid(bagItemID)
    if grid then
        grid:Refresh()
    end
end

function update()
    UIBagPanel.mTime = CSUnityEngineTime.time
    ---刷新
    if UIBagPanel.mNeedRefreshAllGrids then
        UIBagPanel.mNeedRefreshAllGrids = false
        if UIBagPanel:GetBagMainController() then
            if UIBagPanel:GetBagMainController():IsBagInfoDirty() then
                ---若背包信息过时,则当前帧只负责排序,并安排下一帧进行刷新格子
                UIBagPanel:GetBagMainController():GetBagItemList()
                UIBagPanel:RefreshGrids()
            else
                ---若背包信息不过时,则当前帧刷新格子
                UIBagPanel:GetBagMainController():RefreshGrids()
            end
        end
    end
    ---帧Update
    UIBagPanel:OnUpdate(UIBagPanel.mTime)
end

---逐帧刷新
---@param time number
function UIBagPanel:OnUpdate(time)
    ---刷新主控制器
    if self:GetBagMainController() ~= nil then
        self:GetBagMainController():OnUpdate(time)
    end
    ---刷新交互
    if self:GetBagInteraction() ~= nil then
        self:GetBagInteraction():OnUpdate(time)
    end
end
--endregion

--region 工具方法
---获取背包物品ID对应的背包格子
---@public
---@param bagItemID number
function UIBagPanel:GetBagGrid(bagItemID)
    local mainController = UIBagPanel:GetBagMainController()
    if mainController then
        return mainController:GetBagGridByBagItemlid(bagItemID)
    end
    return nil
end

---获取中心页索引(从0开始)
---@return number
function UIBagPanel:GetCenterPageIndex()
    if self:GetBagMainController() ~= nil then
        return self:GetBagMainController():GetCenterPageIndex()
    end
    return 0
end

---切到包含某物品的那一页
---@param bagItemInfo bagV2.BagItemInfo
---@param withAnimation boolean
function UIBagPanel:SwitchToPageContainsBagItem(bagItemInfo, withAnimation)
    local mainController = self:GetBagMainController()
    if mainController ~= nil then
        local pageIndex = mainController:GetPageIndexOfBagItem(bagItemInfo)
        if pageIndex ~= nil and pageIndex >= 0 then
            mainController:SwitchToPage(pageIndex, withAnimation)
        end
    end
end

---切到某一页,默认不使用动画
---@overload fun(pageIndex:number)
---@param pageIndex number 需要切到的目标页
---@param withAnimation boolean 是否需要切页动画
function UIBagPanel:SwitchToPage(pageIndex, withAnimation)
    if self:GetBagMainController() ~= nil then
        self:GetBagMainController():SwitchToPage(pageIndex, withAnimation)
    end
end
--endregion

--region 页标识
---刷新页标识
---@param centerPageIndex number 当前的中心页索引,从0开始
---@param pageSummaryCount number 总页数
function UIBagPanel:RefreshPageSign(centerPageIndex, pageSummaryCount)
    self:GetPageIndexGridContainer().MaxCount = pageSummaryCount
    local controlList = self:GetPageIndexGridContainer().controlList
    for i = 0, controlList.Count - 1 do
        local sprite = self:GetPageSignSpriteByGO(controlList[i])
        if sprite then
            sprite.spriteName = centerPageIndex == i and "scrlight" or "scrbg"
            sprite:MakePixelPerfect()
        end
    end
    ---调整中心位置
    local pos = self:GetPageIndexGridContainer().transform.localPosition
    pos.x = -0.5 * pageSummaryCount * self:GetPageIndexGridContainer().CellWidth + self:GetScrollView_UIPanel().transform.position.x + self:GetScrollView_UIPanel().baseClipRegion.x - 7
    self:GetPageIndexGridContainer().transform.localPosition = pos
end

---根据页标识的GameObject获取对应的UISprite组件
---@param go UnityEngine.GameObject
---@return UISprite
function UIBagPanel:GetPageSignSpriteByGO(go)
    if CS.StaticUtility.IsNull(go) == false then
        if self.mPageGOToSprite == nil then
            self.mPageGOToSprite = {}
        end
        local sprite = self.mPageGOToSprite[go]
        if sprite == nil then
            sprite = self:GetComp(go.transform, "", "UISprite")
            self.mPageGOToSprite[go] = sprite
        end
        return sprite
    end
    return nil
end
--endregion

--region 货币
---初始化货币
function UIBagPanel:InitializeCoins()
    CS.UIEventListener.Get(self:GetCoinLeft_GameObject()).onClick = function()
        self:OnCoinLeftClicked()
    end
    CS.UIEventListener.Get(self:GetCoinRight_GameObject()).onClick = function()
        self:OnCoinRightClicked()
    end
    CS.UIEventListener.Get(self:GetCoinLeftDown_GameObject()).onClick = function()
        self:OnCoinLeftDownClicked()
    end
    CS.UIEventListener.Get(self:GetCoinRightDown_GameObject()).onClick = function()
        self:OnCoinRightDownClicked()
    end
end

---刷新货币
function UIBagPanel:RefreshCoins()
    if self:GetBagMainController() then
        self:GetBagMainController():RefreshCoins()
    end
end

---左货币点击事件
function UIBagPanel:OnCoinLeftClicked()
    if self:GetBagMainController() then
        self:GetBagMainController():OnLeftCoinClicked()
    end
end

---右货币点击事件
function UIBagPanel:OnCoinRightClicked()
    if self:GetBagMainController() then
        self:GetBagMainController():OnRightCoinClicked()
    end
end

---左下货币点击事件
function UIBagPanel:OnCoinLeftDownClicked()
    if self:GetBagMainController() then
        self:GetBagMainController():OnLeftDownCoinClicked()
    end
end

---右下货币点击事件
function UIBagPanel:OnCoinRightDownClicked()
    if self:GetBagMainController() then
        self:GetBagMainController():OnRightDownCoinClicked()
    end
end
--endregion

--region 获取格子内组件
---获取格子组件预设
---@param compName string 组件名
---@return UnityEngine.GameObject
function UIBagPanel:GetGridComponentPrefab(compName)
    if self.mGridComponentPrefabTbl == nil then
        self.mGridComponentPrefabTbl = {}
    end
    local comp = self.mGridComponentPrefabTbl[compName]
    if comp == nil then
        local isNullFunc = CS.StaticUtility.IsNull
        if isNullFunc(self:GetGridItemComponentsRootGO()) == false then
            comp = self:GetComp(self:GetGridItemComponentsRootGO().transform, compName, "GameObject")
            self.mGridComponentPrefabTbl[compName] = comp
        end
    end
    return comp
end
--endregion

--region 气泡回收按钮点击提醒
function UIBagPanel:ShowClickArrowHint()
    local uidialogTipsPanel = uimanager:GetPanel("UIDialogTipsContainerPanel")
    if self.tipsTemplate ~= nil then
        Utility.RemoveHintTips(self.tipsTemplate)
    end
    if self:GetBagType() ~= nil and self:GetBagType() ~= LuaEnumBagType.Recycle and self:GetBagType() ~= LuaEnumBagType.UnFinishFirstMission and uidialogTipsPanel ~= nil and uidialogTipsPanel.recycleHintIsOpen ~= true then
        self.tipsTemplate = Utility.TryCreateHintTips({ point = self:GetExpandButton_GameObject(), id = 2 })
    end
end

---@param needCount boolean 是否计算数量（超过一定数量，则不提示）
function UIBagPanel:RemoveArrowHint(needCount)
    if needCount == true and self.tipsTemplate ~= nil then
        self.tipsTemplate:addClickNum()
    end
    Utility.RemoveHintTips(self.tipsTemplate)
end
--endregion

--region 货币增益提醒
---记录货币增益提醒起始数量
---@public
function UIBagPanel:RecordCoinAddTipOriginAmount()
    local mainController = self:GetBagMainController()
    local bagInfo = self:GetBagInfo()
    if mainController and bagInfo then
        self.mLeftCoinAmountCache = bagInfo:GetCoinAmount(mainController:GetLeftCoinItemID())
        self.mRightCoinAmountCache = bagInfo:GetCoinAmount(mainController:GetRightCoinItemID())
        self.mLeftDownCoinAmountCache = bagInfo:GetCoinAmount(mainController:GetLeftDownCoinItemID())
        self.mRightDownCoinAmountCache = bagInfo:GetCoinAmount(mainController:GetRightDownCoinItemID())
    else
        self.mLeftCoinAmountCache = nil
        self.mRightCoinAmountCache = nil
        self.mLeftDownCoinAmountCache = nil
        self.mRightDownCoinAmountCache = nil
    end
end

---触发货币增益提醒,与前面的记录货币增益数量配合使用,提醒两个方法调用时间内货币的增益值,若增益值小于等于0则进行提醒
---@public
function UIBagPanel:TriggleCoinAddTip()
    if self.mLeftCoinAmountCache == nil and self.mRightCoinAmountCache == nil and self.mLeftDownCoinAmountCache == nil and self.mRightDownCoinAmountCache == nil then
        return
    end
    local mainController = self:GetBagMainController()
    local bagInfo = self:GetBagInfo()
    if mainController and bagInfo then
        local currentLeftAmount = bagInfo:GetCoinAmount(mainController:GetLeftCoinItemID())
        local currentRightAmount = bagInfo:GetCoinAmount(mainController:GetRightCoinItemID())
        local currentLeftDownAmount = bagInfo:GetCoinAmount(mainController:GetLeftDownCoinItemID())
        local currentRightDownAmount = bagInfo:GetCoinAmount(mainController:GetRightDownCoinItemID())
        if self.mLeftCoinAmountCache ~= nil and currentLeftAmount > self.mLeftCoinAmountCache then
            self:GetCoinLeftAddSign_Label().gameObject:SetActive(true)
            self:GetCoinLeftAddSign_Label().text = "+" .. tostring(currentLeftAmount - self.mLeftCoinAmountCache)
            self:GetCoinLeftAddSign_TweenAlpha():ResetToBeginning()
            self:GetCoinLeftAddSign_TweenAlpha():Play()
            self:GetCoinLeftAddSign_TweenPosition():ResetToBeginning()
            self:GetCoinLeftAddSign_TweenPosition():Play()
        end
        if self.mRightCoinAmountCache ~= nil and currentRightAmount > self.mRightCoinAmountCache then
            self:GetCoinRightAddSign_Label().gameObject:SetActive(true)
            self:GetCoinRightAddSign_Label().text = "+" .. tostring(currentRightAmount - self.mRightCoinAmountCache)
            self:GetCoinRightAddSign_TweenAlpha():ResetToBeginning()
            self:GetCoinRightAddSign_TweenAlpha():Play()
            self:GetCoinRightAddSign_TweenPosition():ResetToBeginning()
            self:GetCoinRightAddSign_TweenPosition():Play()
        end
        if self.mLeftDownCoinAmountCache ~= nil and currentLeftDownAmount > self.mLeftDownCoinAmountCache then
            self:GetCoinLeftDownAddSign_Label().gameObject:SetActive(true)
            self:GetCoinLeftDownAddSign_Label().text = "+" .. tostring(currentLeftDownAmount - self.mLeftDownCoinAmountCache)
            self:GetCoinLeftDownAddSign_TweenAlpha():ResetToBeginning()
            self:GetCoinLeftDownAddSign_TweenAlpha():Play()
            self:GetCoinLeftDownAddSign_TweenPosition():ResetToBeginning()
            self:GetCoinLeftDownAddSign_TweenPosition():Play()
        end
        if self.mRightDownCoinAmountCache ~= nil and currentRightDownAmount > self.mRightDownCoinAmountCache then
            self:GetCoinRightDownAddSign_Label().gameObject:SetActive(true)
            self:GetCoinRightDownAddSign_Label().text = "+" .. tostring(currentRightDownAmount - self.mRightDownCoinAmountCache)
            self:GetCoinRightDownAddSign_TweenAlpha():ResetToBeginning()
            self:GetCoinRightDownAddSign_TweenAlpha():Play()
            self:GetCoinRightDownAddSign_TweenPosition():ResetToBeginning()
            self:GetCoinRightDownAddSign_TweenPosition():Play()
        end
    end
    self.mLeftCoinAmountCache = nil
    self.mRightCoinAmountCache = nil
    self.mLeftDownCoinAmountCache = nil
    self.mRightDownCoinAmountCache = nil
end

---重置增益提醒
---@public
function UIBagPanel:ResetTriggleCoinAddTip()
    self.mLeftCoinAmountCache = nil
    self.mRightCoinAmountCache = nil
    self.mLeftDownCoinAmountCache = nil
    self.mRightDownCoinAmountCache = nil
end
--endregion

--region 检测是否开启熔炼
---@private
function UIBagPanel:CheckOpenSmelt()
    if LuaGlobalTableDeal.OpenBagSmeltMarkCondition() ~= nil then
        local condition = LuaGlobalTableDeal.OpenBagSmeltMarkCondition()
        if condition and #condition > 0 then
            local count = #condition
            for i = 1, count do
                local result =  Utility.IsMainPlayerMatchCondition_LuaAndCS(tonumber(condition[i]))
                if result==nil or not result.success then
                    if self:GetSmeltToggle_GameObject() ~= nil and not CS.StaticUtility.IsNull(self:GetSmeltToggle_GameObject()) then
                        Utility.ShowPopoTips(self:GetSmeltToggle_GameObject(), nil, 389, 'UIBagPanel')
                    end
                    return false
                end
            end
        end
    end
    return true
end
--endregion

function ondestroy()
    if luaEventManager.HasCallback(LuaCEvent.Bag_BagPanelIsClose) then
        luaEventManager.DoCallback(LuaCEvent.Bag_BagPanelIsClose)
    end
    if UIBagPanel:GetUIDialogTipsPanel() ~= nil then
        UIBagPanel:GetUIDialogTipsPanel().TryShowRecycleTipsAndChangeContent({ state = false })
    end
    if UIBagPanel:GetBagInfo() ~= nil then
        UIBagPanel:GetBagInfo():ClearRecycleRemainNumDic()
        if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr() ~= nil then
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetMainPlayerBagRecycleMgr():ClearRecycleItemDefaultStateDic()
        end
    end
    UIBagPanel:RemoveArrowHint(false)
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetConfigManager() ~= nil then
        gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData():ReqSavePlayerData()
    end
end

return UIBagPanel