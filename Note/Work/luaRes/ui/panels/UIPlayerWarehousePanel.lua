---@class UIPlayerWarehousePanel:UIBase
local UIPlayerWarehousePanel = {}

--region 组件
---关闭按钮
function UIPlayerWarehousePanel.GetCloseButton_GameObject()
    if UIPlayerWarehousePanel.mCloseButton == nil then
        UIPlayerWarehousePanel.mCloseButton = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/event/Btn_Close", "GameObject")
    end
    return UIPlayerWarehousePanel.mCloseButton
end

---空格子数目
function UIPlayerWarehousePanel.GetEmptyStorageGrid_UILabel()
    if UIPlayerWarehousePanel.mEmptyStorageGridLabel == nil then
        UIPlayerWarehousePanel.mEmptyStorageGridLabel = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/Nombers", "UILabel")
    end
    return UIPlayerWarehousePanel.mEmptyStorageGridLabel
end

---升级仓库格子花费道具图片
function UIPlayerWarehousePanel.GetAddSpaceCostItem_UISprite()
    if UIPlayerWarehousePanel.mAddSpaceCostItem_UISprite == nil then
        UIPlayerWarehousePanel.mAddSpaceCostItem_UISprite = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/addCost", "UISprite")
    end
    return UIPlayerWarehousePanel.mAddSpaceCostItem_UISprite
end

---整理按钮
function UIPlayerWarehousePanel.GetSortButton_GameObject()
    if UIPlayerWarehousePanel.mSortButton == nil then
        UIPlayerWarehousePanel.mSortButton = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/event/Btn_Trim", "GameObject")
    end
    return UIPlayerWarehousePanel.mSortButton
end

---扩容按钮
function UIPlayerWarehousePanel.GetAddSpaceButton_GameObject()
    if UIPlayerWarehousePanel.mAddSpaceButton == nil then
        UIPlayerWarehousePanel.mAddSpaceButton = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/event/Btn_Add", "GameObject")
    end
    return UIPlayerWarehousePanel.mAddSpaceButton
end

---循环页容器
---@return UIPageRecyclingContainerForGameObject
function UIPlayerWarehousePanel.GetPageRecyclingContainer()
    if UIPlayerWarehousePanel.mPageRecyclingContainer == nil then
        UIPlayerWarehousePanel.mPageRecyclingContainer = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/Scroll View", "UIPageRecyclingContainerForGameObject")
    end
    return UIPlayerWarehousePanel.mPageRecyclingContainer
end

---中心页索引容器
---@return UIGridContainer
function UIPlayerWarehousePanel.GetCenterPageIndexContainer()
    if UIPlayerWarehousePanel.mCenterPageIndexContainer == nil then
        UIPlayerWarehousePanel.mCenterPageIndexContainer = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/grid", "UIGridContainer")
    end
    return UIPlayerWarehousePanel.mCenterPageIndexContainer
end

---交互
---@return UIWareHousePanel_Interaction
function UIPlayerWarehousePanel.GetInteraction()
    if UIPlayerWarehousePanel.mInteraction == nil then
        UIPlayerWarehousePanel.mInteraction = templatemanager.GetNewTemplate(UIPlayerWarehousePanel.go, luaComponentTemplates.UIWareHousePanel_Interaction, UIPlayerWarehousePanel, UIPlayerWarehousePanel.GetDraggableItem(), UIPlayerWarehousePanel.GetScrollView())
    end
    return UIPlayerWarehousePanel.mInteraction
end

---获取界面对应的UIScrollView
---@return UIScrollView
function UIPlayerWarehousePanel.GetScrollView()
    if UIPlayerWarehousePanel.mScrollView == nil then
        UIPlayerWarehousePanel.mScrollView = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/Scroll View", "UIScrollView")
    end
    return UIPlayerWarehousePanel.mScrollView
end

---@return UIBagTypeDraggableItem
function UIPlayerWarehousePanel.GetDraggableItem()
    if UIPlayerWarehousePanel.mDraggableItem == nil then
        local go = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/dragItem", "GameObject")
        UIPlayerWarehousePanel.mDraggableItem = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIBagType_DraggableItem, UIPlayerWarehousePanel)
    end
    return UIPlayerWarehousePanel.mDraggableItem
end
--endregion

--region 初始化
function UIPlayerWarehousePanel:Init()
    networkRequest.ReqStorageInfo()
    UIPlayerWarehousePanel.BindEvents()
    UIPlayerWarehousePanel.BindMessage()
    UIPlayerWarehousePanel.mFreeStoragePageCount, UIPlayerWarehousePanel.mPayStoragePageCount, UIPlayerWarehousePanel.mGridCountPerPage = CS.Cfg_GlobalTableManager.Instance:GetStorageGridInfo()
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.PlayerWarehouse })
    if CS.StaticUtility.IsNull(UIPlayerWarehousePanel.GetGridComponentsPrefabRootGO()) == false then
        UIPlayerWarehousePanel.GetGridComponentsPrefabRootGO():SetActive(false)
    end
end

function UIPlayerWarehousePanel:Show(customData)
    UIPlayerWarehousePanel.RefreshStorageContent()
    --UIPlayerWarehousePanel.RefreshStorageEmptyGridLabel()
    UIPlayerWarehousePanel.RefreshAddSpaceCost()
end

function UIPlayerWarehousePanel.BindEvents()
    CS.UIEventListener.Get(UIPlayerWarehousePanel.GetCloseButton_GameObject()).onClick = UIPlayerWarehousePanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIPlayerWarehousePanel.GetSortButton_GameObject()).onClick = UIPlayerWarehousePanel.OnSortStorageItemButtonClicked
    CS.UIEventListener.Get(UIPlayerWarehousePanel.GetAddSpaceButton_GameObject()).onClick = UIPlayerWarehousePanel.OnAddSpaceButtonClicked
end

function UIPlayerWarehousePanel.BindMessage()
    UIPlayerWarehousePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.Storage_DropItemOnStoragePanel, UIPlayerWarehousePanel.OnBagItemDropOnStoragePanel)
    UIPlayerWarehousePanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseStorage, UIPlayerWarehousePanel.OnCloseButtonClicked)
    UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StorageAddItem, UIPlayerWarehousePanel.OnStorageAddItem)
    UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StorageGridNumChange, UIPlayerWarehousePanel.OnStorageEmptyGridMessageReceived)
    UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StorageSort, UIPlayerWarehousePanel.OnSortStorageMessageReceived)
    UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_StorageTakeOutItem, UIPlayerWarehousePanel.OnStorageTakeOutItem)
    --UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIPlayerWarehousePanel.MainPlayerBeginWalk)
    UIPlayerWarehousePanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIPlayerWarehousePanel.OnBagItemChangedReceived)
    UIPlayerWarehousePanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResAddStorageMaxCountMessage, UIPlayerWarehousePanel.OnResAddStorageMaxCountMessageReceived)
end
--endregion

--region 服务器消息
---格子扩容
function UIPlayerWarehousePanel.OnResAddStorageMaxCountMessageReceived()
    UIPlayerWarehousePanel.RefreshStorageContent()
    UIPlayerWarehousePanel.RefreshCenterPageIndexSign()
end
--endregion

--region 客户端事件
---仓库增加道具（刷新并跳转当前页）
function UIPlayerWarehousePanel.OnStorageAddItem()
    UIPlayerWarehousePanel.RefreshStorageContent()
end

---仓库取出道具（刷新并跳转背包）
function UIPlayerWarehousePanel.OnStorageTakeOutItem()
    UIPlayerWarehousePanel.RefreshStorageContent()
end

---收到仓库整理信息（只刷新不跳转）
function UIPlayerWarehousePanel.OnSortStorageMessageReceived()
    UIPlayerWarehousePanel.RefreshStorageContent()
end

---仓库剩余容量变化消息
function UIPlayerWarehousePanel.OnStorageEmptyGridMessageReceived()
    --UIPlayerWarehousePanel.RefreshStorageEmptyGridLabel()
end

function UIPlayerWarehousePanel.MainPlayerBeginWalk()
    UIPlayerWarehousePanel.OnCloseButtonClicked()
end

---背包物品变化信息
function UIPlayerWarehousePanel.OnBagItemChangedReceived()
    UIPlayerWarehousePanel.RefreshAddSpaceCost()
end

---拖拽背包物品到仓库界面
---@param msgID number 消息ID
---@param data table 拖拽传递的参数
function UIPlayerWarehousePanel.OnBagItemDropOnStoragePanel(msgID, data)
    if data == nil then
        return
    end
    local position = data.position
    local bagItemInfo = data.bagItemInfo
    if position ~= nil and bagItemInfo ~= nil and CS.StaticUtility.IsNull(UIPlayerWarehousePanel.go) == false and UIPlayerWarehousePanel.go.activeInHierarchy and CS.Utility_Lua.IsPointInUIRange(position, UIPlayerWarehousePanel.go) then
        networkRequest.ReqStorageInItem(bagItemInfo.lid)
    end
end
--endregion

--region UI事件
---关闭界面
function UIPlayerWarehousePanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIPlayerWarehousePanel")
end

---整理按钮点击事件
function UIPlayerWarehousePanel.OnSortStorageItemButtonClicked()
    networkRequest.ReqTidyStorage()
end

---扩容按钮点击事件
function UIPlayerWarehousePanel.OnAddSpaceButtonClicked(go)
    local mainPlayerCanAddWarehouseSpace = Utility.MainPlayerCanAddWarehouseSpace()
    if mainPlayerCanAddWarehouseSpace == false then
        local costParams = LuaGlobalTableDeal:GetWarehouseAddSpaceConfigParams()
        if costParams == nil or costParams.costItemId == nil then
            return
        end
        local costItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(costParams.costItemId)
        if costItemInfo == nil then
            return
        end
        local promptFrameTblId = 469
        local des = clientTableManager.cfg_promptframeManager:GetPopContent(promptFrameTblId,costItemInfo:GetName())
        Utility.ShowPopoTips(go.transform,des,promptFrameTblId)
        return
    end
    networkRequest.ReqAddStorageMaxCount()
end

---页进入视野
---@param pageObj UnityEngine.GameObject
---@param pageIndex number
function UIPlayerWarehousePanel.OnPageEnterView(pageObj, pageIndex)
    UIPlayerWarehousePanel.RefreshPage(pageObj, pageIndex)
end

---中心页索引变化事件
---@param pageIndex number
function UIPlayerWarehousePanel.OnCenterPageChanged(pageIndex)
    UIPlayerWarehousePanel.SetCenterIndex(pageIndex)
    UIPlayerWarehousePanel.RefreshCenterPageIndexSign()
end
--endregion

--region 刷新
---刷新仓库内容
function UIPlayerWarehousePanel.RefreshStorageContent()
    UIPlayerWarehousePanel.GetPageRecyclingContainer():Initialize(UIPlayerWarehousePanel.GetAllPageCount(), UIPlayerWarehousePanel.OnPageEnterView, nil, UIPlayerWarehousePanel.OnCenterPageChanged, UIPlayerWarehousePanel.GetCenterIndex())
end

---刷新仓库空格子文字
function UIPlayerWarehousePanel.RefreshStorageEmptyGridLabel()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.Storage == nil then
        return
    end
    UIPlayerWarehousePanel.GetEmptyStorageGrid_UILabel().text = tostring(CS.CSScene.MainPlayerInfo.Storage.StorageEmptyGrid)
end

---刷新增加仓库空间花费描述
function UIPlayerWarehousePanel.RefreshAddSpaceCost()
    luaclass.UIRefresh:RefreshActive(UIPlayerWarehousePanel.GetEmptyStorageGrid_UILabel(),false)
    luaclass.UIRefresh:RefreshActive(UIPlayerWarehousePanel.GetAddSpaceCostItem_UISprite(),false)
    local costParams = LuaGlobalTableDeal:GetWarehouseAddSpaceConfigParams()
    if costParams == nil or costParams.costItemId == nil or costParams.costNum == nil then
        return
    end
    local costItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(costParams.costItemId)
    if costItemInfo == nil then
        return
    end
    local bagCostItemNum = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(costParams.costItemId)
    if bagCostItemNum == nil then
        return
    end
    local mainPlayerCanAddWarehouseSpace = Utility.MainPlayerCanAddWarehouseSpace()
    local nowCostItemColor = ternary(mainPlayerCanAddWarehouseSpace == true,luaEnumColorType.Green,luaEnumColorType.Red)
    local costDes = nowCostItemColor .. tostring(bagCostItemNum) .. "[-]/" .. costParams.costNum
    luaclass.UIRefresh:RefreshActive(UIPlayerWarehousePanel.GetEmptyStorageGrid_UILabel(),true)
    luaclass.UIRefresh:RefreshActive(UIPlayerWarehousePanel.GetAddSpaceCostItem_UISprite(),true)
    luaclass.UIRefresh:RefreshLabel(UIPlayerWarehousePanel.GetEmptyStorageGrid_UILabel(),costDes)
    luaclass.UIRefresh:RefreshSprite(UIPlayerWarehousePanel.GetAddSpaceCostItem_UISprite(),costItemInfo:GetIcon())
    luaclass.UIRefresh:BindClickCallBack(UIPlayerWarehousePanel.GetAddSpaceCostItem_UISprite(),function()
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = costItemInfo.csTABLE, showRight = false })
    end)
    UIPlayerWarehousePanel.GetAddSpaceButton_GameObject().transform:Find("effect").gameObject:SetActive(bagCostItemNum > 0)
end

function update()
    UIPlayerWarehousePanel.GetInteraction():OnUpdate(CS.UnityEngine.Time.time)
end
--endregion

--region 数据
---获取仓库存储物品列表
function UIPlayerWarehousePanel.GetStorageItemList()
    return CS.CSScene.MainPlayerInfo.Storage.StorageItemList
end

---获取最大格子数量
---@return number
function UIPlayerWarehousePanel.GetMaxGridCount()
    return CS.CSScene.MainPlayerInfo.Storage.MaxStorageGrid
end

---获取中心页索引
---@return number
function UIPlayerWarehousePanel.GetCenterIndex()
    if UIPlayerWarehousePanel.mCenterIndex == nil then
        UIPlayerWarehousePanel.mCenterIndex = 0
    end
    return UIPlayerWarehousePanel.mCenterIndex
end

---设置中心页索引
function UIPlayerWarehousePanel.SetCenterIndex(centerIndex)
    UIPlayerWarehousePanel.mCenterIndex = centerIndex
end

---获取总页数
---@return number
function UIPlayerWarehousePanel.GetAllPageCount()
    local pageCount = UIPlayerWarehousePanel.GetPageCount()
    if pageCount < UIPlayerWarehousePanel.GetMaxPageCount() then
        return pageCount + 1
    end
    return pageCount
end

---获取最大页数
---@return number
function UIPlayerWarehousePanel.GetMaxPageCount()
    return UIPlayerWarehousePanel.mFreeStoragePageCount + UIPlayerWarehousePanel.mPayStoragePageCount
end

---获取页数
---@return number
function UIPlayerWarehousePanel.GetPageCount()
    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.Storage == nil or UIPlayerWarehousePanel.GetGridCountPerPage() <= 0 then
        return 0
    end
    local pageCount = math.ceil(CS.CSScene.MainPlayerInfo.Storage.MaxStorageGrid / UIPlayerWarehousePanel.GetGridCountPerPage())
    if pageCount <= 0 then
        return 1
    end
    return pageCount
end

---获取每页的格子数量
---@return number
function UIPlayerWarehousePanel.GetGridCountPerPage()
    if UIPlayerWarehousePanel.mGridCountPerPage then
        return UIPlayerWarehousePanel.mGridCountPerPage
    end
    return uiStaticParameter.UIBagPanel_BAGGRIDMAXCOUNT
end

---刷新中心页索引标识
function UIPlayerWarehousePanel.RefreshCenterPageIndexSign()
    UIPlayerWarehousePanel.GetCenterPageIndexContainer().MaxCount = UIPlayerWarehousePanel.GetAllPageCount()
    local centerIndex = UIPlayerWarehousePanel.GetCenterIndex()
    local controllerList = UIPlayerWarehousePanel.GetCenterPageIndexContainer().controlList
    for i = 0, controllerList.Count - 1 do
        local sign = UIPlayerWarehousePanel.GetPageSignSprite(controllerList[i])
        if sign then
            sign.spriteName = (i == centerIndex) and "scrlight" or "scrbg"
            sign:MakePixelPerfect()
        end
    end
end

---获取页图片
---@param go UnityEngine.GameObject
---@return UISprite
function UIPlayerWarehousePanel.GetPageSignSprite(go)
    if UIPlayerWarehousePanel.mPageSignSprites == nil then
        UIPlayerWarehousePanel.mPageSignSprites = {}
    end
    local signSprite = UIPlayerWarehousePanel.mPageSignSprites[go]
    if signSprite == nil then
        signSprite = UIPlayerWarehousePanel:GetComp(go.transform, "", "UISprite")
        UIPlayerWarehousePanel.mPageSignSprites[go] = signSprite
    end
    return signSprite
end
--endregion

--region 页
---刷新页
---@param pageObj UnityEngine.GameObject 待刷新的页物体
---@param pageIndex number 页索引
function UIPlayerWarehousePanel.RefreshPage(pageObj, pageIndex)
    local pageController = UIPlayerWarehousePanel.GetPageController(pageObj)
    if pageController then
        pageController:RefreshPage(UIPlayerWarehousePanel.GetStorageItemList(), pageIndex, UIPlayerWarehousePanel.GetGridCountPerPage(), UIPlayerWarehousePanel.GetMaxGridCount())
    end
end

---获取页对应的控制器
---@param pageObj UnityEngine.GameObject
---@return UIWareHousePanel_PageController
function UIPlayerWarehousePanel.GetPageController(pageObj)
    if CS.StaticUtility.IsNull(pageObj) then
        return nil
    end
    if UIPlayerWarehousePanel.mPageControllers == nil then
        UIPlayerWarehousePanel.mPageControllers = {}
    end
    local pageController = UIPlayerWarehousePanel.mPageControllers[pageObj]
    if pageController == nil then
        pageController = templatemanager.GetNewTemplate(pageObj, luaComponentTemplates.UIWareHousePanel_PageControllerTemplate, UIPlayerWarehousePanel)
        UIPlayerWarehousePanel.mPageControllers[pageObj] = pageController
    end
    return pageController
end
--endregion

--region 获取格子组件预设
---获取格子组件预设根节点
---@return UnityEngine.GameObject
function UIPlayerWarehousePanel.GetGridComponentsPrefabRootGO()
    if UIPlayerWarehousePanel.mGridComponentsPrefabRootGo == nil then
        UIPlayerWarehousePanel.mGridComponentsPrefabRootGo = UIPlayerWarehousePanel:GetCurComp("WidgetRoot/view/componentPrefabs", "GameObject")
    end
    return UIPlayerWarehousePanel.mGridComponentsPrefabRootGo
end

---获取组件预设
---@param compName string
---@return UnityEngine.GameObject
function UIPlayerWarehousePanel.FetchComponentPrefab(compName)
    if UIPlayerWarehousePanel.mComponentPrefabTbl == nil then
        UIPlayerWarehousePanel.mComponentPrefabTbl = {}
    end
    local go = UIPlayerWarehousePanel.mComponentPrefabTbl[compName]
    if (go == nil or CS.StaticUtility.IsNull(go)) and CS.StaticUtility.IsNull(UIPlayerWarehousePanel.GetGridComponentsPrefabRootGO()) == false then
        go = UIPlayerWarehousePanel:GetComp(UIPlayerWarehousePanel.GetGridComponentsPrefabRootGO().transform, compName, "GameObject")
        UIPlayerWarehousePanel.mComponentPrefabTbl[compName] = go
    end
    return go
end
--endregion

return UIPlayerWarehousePanel