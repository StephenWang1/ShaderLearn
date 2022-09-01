---模板管理
local TemplateManager = {}

---lua组件模板列表,用于Lua中的继承
---@type table<string,TemplateBase>
luaComponentTemplates = {}
---@type fun(UnityEngine.GameObject,string):LuaStateBehaviour 获取GameObject上一个LuaStateBehaviour组件的方法
local GetLuaStateBehaviourFunction = CS.LuaStateBehaviour.Get
---@type fun(UnityEngine.Object):boolean 检查是否是Unity中的空对象
local CheckIsUnityNullFunction = CS.StaticUtility.IsNull

---初始化模板管理
function TemplateManager:Initialize()
    luaComponentTemplates = {}
    TemplateManager.RegisterLuaComponents()
    TemplateManager.SetAllLuaComponentMetaTable()
end

---所有需要作为组件模板的lua文件均需在此注册并加以注释,以便后续调用
function TemplateManager.RegisterLuaComponents()
    ---@type copytemplatebase
    luaComponentTemplates.copytemplatebase = require "luaRes.ui.copytemplatebase"

    --region 类背包容器模板
    ---类背包容器交互基类
    luaComponentTemplates.UIBagType_Interaction = require "luaRes.ui.template.UIBagTypeContainerTemplate.UIBagTypeContainerInteraction"
    ---类背包容器可拖拽物品基类
    luaComponentTemplates.UIBagType_DraggableItem = require "luaRes.ui.template.UIBagTypeContainerTemplate.UIBagTypeDraggableItem"
    ---类背包容器格子基类
    luaComponentTemplates.UIBagType_Grid = require "luaRes.ui.template.UIBagTypeContainerTemplate.UIBagTypeGrid"
    --endregion

    --region 背包
    ---拖拽物体
    luaComponentTemplates.UIBagItemDrag = require "luaRes.ui.template.UIBagPanelTemplates.UIBagItemDrag"

    ---背包主控制器基类
    luaComponentTemplates.UIBagMainBasic = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMainBasic"
    ---背包界面被拖拽的物品
    luaComponentTemplates.UIBagDraggedItem = require "luaRes.ui.template.UIBagPanelTemplates.DragRelated.UIBagDraggedItem"
    ---背包正常打开的主控制器
    luaComponentTemplates.UIBagMainNormal = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Normal"
    ---背包正常回收的主控制器
    luaComponentTemplates.UIBagMainRecycle = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Recycle"
    ---背包与技能界面组合时的主控制器
    luaComponentTemplates.UIBagMainSkill = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Skill"
    ---背包与角色界面组合时的主控制器
    luaComponentTemplates.UIBagMainRole = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Role"
    ---背包与灵兽界面组合时的主控制器
    luaComponentTemplates.UIBagMainServant = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Servant"
    ---背包与个人仓库界面组合时的主控制器
    luaComponentTemplates.UIBagMainPlayerWarehouse = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_PlayerWarehouse"
    ---背包与材料界面组合时的主控制器
    luaComponentTemplates.UIBagMainMaterial = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Material"
    ---背包与升星界面组合时的主控制器
    luaComponentTemplates.UIBagMainStrengthen = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Strengthen"
    ---背包与转移界面组合时的主控制器
    luaComponentTemplates.UIBagMain_Transfer = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Transfer"
    ---背包与维修界面组合时的主控制器
    luaComponentTemplates.UIBagMain_Repair = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Repair"
    ---背包与灵兽维修界面组合时的主控制器
    luaComponentTemplates.UIBagMain_ServantRepair = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_ServantRepair"
    ---背包与打捆界面组合时的主控制器
    luaComponentTemplates.UIBagMain_WarehouseBundle = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_WarehouseBundle"
    ---背包与技能设置界面组合时的主控制器
    luaComponentTemplates.UIBagMain_SkillConfig = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_SkillConfig"
    ---背包与进化
    luaComponentTemplates.UIBagMain_Evolution = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Evolution"
    ---背包与合成
    luaComponentTemplates.UIBagMain_Synthesis = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Synthesis"
    ---背包与融合界面组合时的主控制器
    luaComponentTemplates.UIBagMain_Mosaic = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Mosaic"
    ---元素提示背包
    luaComponentTemplates.UIBagMain_ElementHint = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_ElementHint"
    ---印记提示背包
    luaComponentTemplates.UIBagMain_SignetHint = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_SignetHint"
    ---摊位提示背包
    luaComponentTemplates.UIBagMain_Stall = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Stall"
    ---第一个任务未完成背包
    luaComponentTemplates.UIBagMain_UnFinishFirstMission = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_UnFinishFirstMission"
    ---行会召唤令提示背包
    luaComponentTemplates.UIBagMain_UnionSummonToken = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_UnionSummonToken"
    ---高等级灵兽背包
    luaComponentTemplates.UIBagMain_ServantHighLv = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_ServantHighLv"
    ---背包页控制
    luaComponentTemplates.UIBagPageCtrl = require "luaRes.ui.template.UIBagPanelTemplates.Page.UIBagPageCtrl"
    ---背包格子
    luaComponentTemplates.UIBagGrid = require "luaRes.ui.template.UIBagPanelTemplates.Grid.UIBagGrid"
    ---背包交互
    luaComponentTemplates.UIBagInteraction = require "luaRes.ui.template.UIBagPanelTemplates.Interaction.UIBagInteraction"
    ---背包回收选项
    luaComponentTemplates.UIBagRecycleOptionGO = require "luaRes.ui.template.UIBagPanelTemplates.RecycleRelated.UIBagRecycle_OptionGO"
    ---背包回收收益
    luaComponentTemplates.UIBagRecycleEarning = require "luaRes.ui.template.UIBagPanelTemplates.RecycleRelated.UIBagRecycle_Earning"
    ---背包回收设置选项
    luaComponentTemplates.UIBagRecycle_Setting = require "luaRes.ui.template.UIBagPanelTemplates.RecycleRelated.UIBagRecycle_Setting"
    ---背包回收设置按钮
    luaComponentTemplates.UIBagRecycle_SettingOption = require "luaRes.ui.template.UIBagPanelTemplates.RecycleRelated.UIBagRecycle_SettingOption"
    ---背包与交易界面组合时的主控制器
    luaComponentTemplates.UIBagMain_Trade = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Trade"
    ---背包与心法技能界面组合时的主控制器
    luaComponentTemplates.UIBagMain_HeartSkill = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_HeartSkill"
    ---背包与收藏家界面组合时的主控制器
    luaComponentTemplates.UIBagMain_HighRecycle = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_HighRecycle"
    ---炼化背包
    luaComponentTemplates.UIBagMain_Refine = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Refine"
    ---熔炼背包
    luaComponentTemplates.UIBagMain_Smelt = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Smelt"
    ---血继熔炼背包
    luaComponentTemplates.UIBagMain_BloodSuitSmelt = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_BloodSuitSmelt"
    ---血继背包
    luaComponentTemplates.UIBagMain_BloodSuit = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_BloodSuit"
    ---神炼背包
    luaComponentTemplates.UIBagMain_ForgeGodPowerSmelt = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_ForgeGodPowerSmelt"
    ---洗炼背包
    luaComponentTemplates.UIBagMain_AgainRefine = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_AgainRefine"
    ---藏品背包
    luaComponentTemplates.UIBagMain_Collection = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_Collection"
    ---藏品回收背包
    luaComponentTemplates.UIBagMain_CollectionRecycle = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_CollectionRecycle"
    ---鉴定背包
    luaComponentTemplates.UIBagMain_JianDing = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_JianDing"
    ---淬炼背包
    luaComponentTemplates.UIBagMain_ForgeQuench = require "luaRes.ui.template.UIBagPanelTemplates.Main.UIBagMain_ForgeQuench"
    --endregion

    --region 物品信息,在界面中控制物品的icon,name,rank,quality,strength等属性的显示
    ---物品信息(基类)
    luaComponentTemplates.UIItem = require "luaRes.ui.template.UIItemTemplates.UIItem"
    ---物品信息界面的物品信息
    luaComponentTemplates.UIItem_UIItemInfoPanel = require "luaRes.ui.template.UIItemTemplates.UIItem_UIItemInfoPanel"
    --endregion

    --region 物品信息界面单个界面模板,旨在区分物品信息界面在不同情况下打开时,对左右两个界面的单独处理
    --region 物品信息
    ---灵兽信息界面子界面基类
    luaComponentTemplates.UIPetInfoPanel_PartBasic = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIPetInfoPanel_PartBasic"
    ---物品信息界面子界面基类
    luaComponentTemplates.UIItemInfoPanel_PartBasic = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_PartBasic"
    ---物品信息界面主子界面
    luaComponentTemplates.UIItemInfoPanel_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_MainPart"
    ---物品信息界面主子界面(不包含底部操作按钮)
    luaComponentTemplates.UIItemInfoPanel_MainPart_WithoutOperate = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_MainPart_WithoutOperate"
    ---物品信息界面辅助子界面
    luaComponentTemplates.UIItemInfoPanel_AssistPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_AssistPart"
    ---物品信息界面辅助子界面隐藏(需要强制隐藏辅助界面时传入该table)
    luaComponentTemplates.UIItemInfoPanel_AssistPart_Hiden = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_AssistPart_Hiden"
    ---物品信息界面信息
    luaComponentTemplates.UIItemInfoPanel_Info_Basic = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_Basic"
    ---物品信息界面UI物品信息
    luaComponentTemplates.UIItemInfoPanel_Info_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_UIItem"
    ---物品信息界面强化信息
    luaComponentTemplates.UIItemInfoPanel_Info_Strengthen = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_Strengthen"
    ---物品信息界面操作按钮信息
    luaComponentTemplates.UIItemInfoPanel_Info_OperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_OperateButtons"
    ---物品信息界面单线信息(只有文字上方有线)
    luaComponentTemplates.UIItemInfoPanel_Info_SingleLine = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_SingleLine"
    ---倒计时显示（使用物品信息界面单线信息）
    luaComponentTemplates.UIItemInfoPanel_Info_TimeCount = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_TimeCount"
    ---兵鉴tips显示
    luaComponentTemplates.UIItemInfoPanel_Info_BingJian = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_BingJian"
    ---物品信息界面单线信息(文字上方无线)
    luaComponentTemplates.UIItemInfoPanel_Info_PureSingleLine = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_PureSingleLine"
    ---物品信息界面基础属性
    luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_BaseAttribute"
    ---物品信息界面额外属性
    luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_ExtraAttribute"
    ---物品信息界面强化属性
    luaComponentTemplates.UIItemInfoPanel_Info_StrengthenAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_StrengthenAttribute"
    ---物品信息界面双线信息(文字上方和下方都有线)
    luaComponentTemplates.UIItemInfoPanel_Info_DoubleLine = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_DoubleLine"
    ---物品在下方的固定显示技能信息
    luaComponentTemplates.UIItemInfoPanel_Info_FixLowerSkill = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_FixLowerSkill"
    ---物品信息界面右上角操作按钮信息
    luaComponentTemplates. UIItemInfoPanel_Info_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_RightUpOperateButtons"
    ---物品信息界面右下角操作按钮信息
    luaComponentTemplates. UIItemInfoPanel_Info_RightDownOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_RightDownOperateButtons"
    ---物品信息界面左上角操作按钮信息
    luaComponentTemplates. UIItemInfoPanel_Info_LeftTopOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_LeftTopOperateButtons"
    ---物品信息界面左上角单个操作按钮模板
    luaComponentTemplates. UIItemInfoPanel_Info_LeftTopButtonTemplate = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_LeftTopButtonTemplate"
    ---物品信息界面使用等级信息
    luaComponentTemplates.UIItemInfoPanel_Info_UseLv = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_UseLv"
    ---按钮列表展开收起
    luaComponentTemplates.UIItemInfoPanel_Info_OpenCloseBtnList = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_OpenCloseBtnList"
    ---物品信息界面印记属性
    luaComponentTemplates.UIItemInfoPanel_Info_Signet = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_Signet"
    ---物品信息界面获取途径
    luaComponentTemplates.UIItemInfoPanel_Info_WaygetSignetLine = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_WaygetSignetLine"
    ---物品列表模板（可兑换，可获取）
    luaComponentTemplates.UIItemInfoPanel_Info_ItemList = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForInfoShowing.UIItemInfoPanel_Info_ItemList"
    ---魂继技能模板
    luaComponentTemplates.UIItemInfoPanel_Info_HunJiSkillTemplate = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForHunji.UIItemInfoPanel_Info_HunJiSkillTemplate"
    ---血继额外属性模板
    luaComponentTemplates.UIItemInfoPanel_Info_BloodSuitExtraAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForBloodSuits.BloodSuitItemInfoComp_ExtraAttribute"

    --region 日常信息界面
    luaComponentTemplates.UISpecialMissionPanel_ItemPartRightUpOperate = require "luaRes.ui.template.UISpecialMissionPanelItemTemp.UISpecialMissionPanel_ItemPartRightUpOperate"
    luaComponentTemplates.UISpecialMissionPanel_ItemPart = require "luaRes.ui.template.UISpecialMissionPanelItemTemp.UISpecialMissionPanel_ItemPart"
    luaComponentTemplates.UISpecialMissionPanel_Item = require "luaRes.ui.template.UISpecialMissionPanelItemTemp.UISpecialMissionPanel_Item"
    --endregion

    --region 灵兽信息界面
    ---灵兽信息界面
    luaComponentTemplates.UIItemInfoPanel_ServentMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentMainPart"
    ---灵兽界面信息无按钮
    luaComponentTemplates.UIItemInfoPanel_ServentMainPartNoButton = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentMainPartNoButton"
    ---灵兽副界面信息
    luaComponentTemplates.UIItemInfoPanel_ServentAssistPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentAssistPart"
    ---灵兽信息界面_上部信息
    luaComponentTemplates.UIItemInfoPanel_ServentUpInfo = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentUpInfo"
    ---灵兽信息界面_基础属性信息
    luaComponentTemplates.UIItemInfoPanel_ServentAttributeInfo = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentAttributeInfo"

    ---灵兽装备信息界面-主界面
    luaComponentTemplates.UIItemInfoPanel_ServantEquipMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantEquipMainPart"
    ---灵兽装备信息界面-辅助界面
    luaComponentTemplates.UIItemInfoPanel_ServantEquipAssistPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantEquipAssistPart"
    ---灵兽装备信息界面-上部分基础信息刷新
    luaComponentTemplates.UIItemInfoPanel_ServantEquip_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantEquip_UIItem"
    ---灵兽装备信息界面-主界面右上按钮模板
    luaComponentTemplates.UIITemPanel_Info_ServantEquipRightUpOperate = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIITemPanel_Info_ServantEquipRightUpOperate"
    ---灵兽装备信息界面-中间部分基础信息模板
    luaComponentTemplates.UIItemInfoPanel_Info_ServantEquipBaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_Info_ServantEquipBaseAttribute"

    ---灵兽肉身信息界面-主界面
    luaComponentTemplates.UIItemInfoPanel_ServantBodyMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantBodyMainPart"
    ---灵兽肉身信息界面-辅助界面
    luaComponentTemplates.UIItemInfoPanel_ServantBodyAssistPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantBodyAssistPart"
    ---灵兽肉身信息界面-中间部分基础信息模板
    luaComponentTemplates.UIItemInfoPanel_Info_ServantBodyBaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_Info_ServantBodyBaseAttribute"
    ---灵兽肉身信息界面-上部分基础信息模板
    luaComponentTemplates.UIItemInfoPanel_ServantBody_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServantBody_UIItem"

    ---灵兽碎片信息模板
    luaComponentTemplates.UIItemInfoPanel_ServentFragmentMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentFragmentMainPart"
    ---灵兽碎片数量信息
    luaComponentTemplates.UIItemInfoPanel_ServentFragmentNum = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.UIItemInfoPanel_ServentFragmentNum"
    ---灵兽蛋物品信息模板
    luaComponentTemplates.UIPetInfoPanel_ItemInfo = require "luaRes.ui.template.UIPetInfoPanelTemplates.UIPetInfoPanel_ItemInfo"
    ---灵兽蛋物品属性信息模板
    luaComponentTemplates.UIPetInfoPanel_ItemInfo_ServantAttributeInfo = require "luaRes.ui.template.UIPetInfoPanelTemplates.UIPetInfoPanel_ItemInfo_ServantAttributeInfo"

    ---灵兽身上的灵兽法宝右上角按钮模板
    luaComponentTemplates.UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForServent.MagicEquip.UIItemInfoPanel_ServantBodyMagicEquip_RightUpOperateButtons"
    --endregion

    --region 勋章信息界面
    ---勋章信息界面的物品信息
    luaComponentTemplates.UIItem_UIItemInfoPanel_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItem_UIItemInfoPanel_Medal"
    ---勋章信息界面UI物品信息
    luaComponentTemplates.UIItemInfoPanel_Info_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_Info_Medal"
    ---勋章信息界面子界面信息
    luaComponentTemplates.UIItemInfoPanel_PartBasic_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_PartBasic_Medal"
    ---勋章信息界面子界面
    luaComponentTemplates.UIItemInfoPanel_MainPart_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_MainPart_Medal"
    ---勋章信息界面子界面(无按钮)
    luaComponentTemplates.UIItemInfoPanel_MainPart_MedalNoBtn = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_MainPart_MedalNoBtn"
    ---勋章信息界面子界面(额外属性)
    luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_Info_ExtraAttribute_Medal"
    ---勋章信息界面辅子界面信息
    luaComponentTemplates.UIItemInfoPanel_AssistPart_Medal = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_AssistPart_Medal"
    ---勋章信息主界面右上按钮模板
    luaComponentTemplates.UIItemInfoPanel_Info_MedalRightUpOperateBtns = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMedal.UIItemInfoPanel_Info_MedalRightUpOperateBtns"


    --region 婚戒信息界面
    ---角色婚戒信息界面的物品信息
    luaComponentTemplates.RoleMarryRingItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.RoleMarryRing.RoleMarryRingItemInfo_MainPart"
    luaComponentTemplates.RoleMarryRingItemInfo_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.RoleMarryRing.RoleMarryRingItemInfo_UIItem"
    luaComponentTemplates.RoleMarryRingItemInfo_BaseInfo = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.RoleMarryRing.RoleMarryRingItemInfo_BaseInfo"
    luaComponentTemplates.RoleMarryRingItemInfo_ExtraAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.RoleMarryRing.RoleMarryRingItemInfo_ExtraAttribute"
    luaComponentTemplates.RoleMarryRingItemInfo_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.RoleMarryRing.RoleMarryRingItemInfo_RightUpOperateButtons"
    ---背包婚戒信息界面的物品信息
    luaComponentTemplates.BagMarryRingItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.BagMarryRing.BagMarryRingItemInfo_MainPart"
    luaComponentTemplates.BagMarryRingItemInfo_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.BagMarryRing.BagMarryRingItemInfo_UIItem"
    luaComponentTemplates.BagMarryRingItemInfo_BaseInfo = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.BagMarryRing.BagMarryRingItemInfo_BaseInfo"
    luaComponentTemplates.BagMarryRingItemInfo_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMarry.BagMarryRing.BagMarryRingItemInfo_RightUpOperateButtons"
    --endregion

    ---region 物品信息升级VIP
    luaComponentTemplates.UpgradeMembershipItemInfo_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForUpUpgradeMembership.UpgradeMembershipItemInfo_RightUpOperateButtons"
    luaComponentTemplates.UpgradeMembershipItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForUpUpgradeMembership.UpgradeMembershipItemInfo_MainPart"
    ---endregion

    --region 帮会信息界面
    luaComponentTemplates.UIItemInfoPanel_Union_RightUpOperate = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForUnion.UIItemInfoPanel_Union_RightUpOperate"
    ---帮会仓库兑换右上角模板
    luaComponentTemplates.UIItemInfoPanel_UnionBag_RightUpOperate = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForUnion.UIItemInfoPanel_UnionBag_RightUpOperate"
    --endregion

    --region 宝物信息界面
    luaComponentTemplates.UIItemInfoPanel_GemExtraItemMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGemExtraItem.UIItemInfoPanel_GemExtraItemMainPart"
    luaComponentTemplates.UIItemInfoPanel_GemExtraItem_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGemExtraItem.UIItemInfoPanel_GemExtraItem_UIItem"
    luaComponentTemplates.UIItemInfoPanel_GemExtraItem_BaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGemExtraItem.UIItemInfoPanel_GemExtraItem_BaseAttribute"
    luaComponentTemplates.UIItemInfoPanel_GemExtraItem_ExtraAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGemExtraItem.UIItemInfoPanel_GemExtraItem_ExtraAttribute"
    --endregion

    --region 魂继信息界面
    luaComponentTemplates.UIItemInfoPanel_HunJiMainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForHunji.UIItemInfoPanel_MainPart_HunJi"
    --endregion

    --region 法宝
    luaComponentTemplates.MagicEquipItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMagicEquip.MagicEquipItemInfo_MainPart"
    luaComponentTemplates.MagicEquipItemInfo_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMagicEquip.MagicEquipItemInfo_UIItem"
    luaComponentTemplates.MagicEquipItemInfo_ExtraAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForMagicEquip.MagicEquipItemInfo_ExtraAttribute"
    --endregion

    --region 血继套装
    luaComponentTemplates.BloodSuitItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForBloodSuits.BloodSuitItemInfo_MainPart"
    --endregion

    --region 阵法装备
    luaComponentTemplates.ZhenFaEquipItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForZhenFaEquip.FaZhenEquipItemInfo_MainPart"
    luaComponentTemplates.FaZhenEquipItemInfo_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForZhenFaEquip.FaZhenEquipItemInfo_UIItem"
    luaComponentTemplates.FaZhenEquipItemInfo_BaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForZhenFaEquip.FaZhenEquipItemInfo_BaseAttribute"
    --endregion

    --region 兵鉴神力装备
    luaComponentTemplates.BingJianEquipItemInfo_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForBingJianSL.BingJianEquipItemInfo_MainPart"
    --endregion

    --region 元素
    ---元素属性
    luaComponentTemplates.UIItemInfoPanel_ElementBaseAttribute = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForElement.UIItemInfoPanel_ElementBaseAttribute"
    ---元素镶嵌位置
    luaComponentTemplates.UIItemInfoPanel_ElementInsertPlace = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForElement.UIItemInfoPanel_ElementInsertPlace"
    --endregion

    --region 聚灵珠
    ---聚灵珠主要部分模板
    luaComponentTemplates.UIItemInfoPanel_GatheringBeads_MainPart = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGatheringBeads.UIItemInfoPanel_GatheringBeads_MainPart"
    ---聚灵珠上部分刷新模板
    luaComponentTemplates.UIItemInfoPanel_GatheringBeads_UIItem = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGatheringBeads.UIItemInfoPanel_GatheringBeads_UIItem"
    ---聚灵珠右上部分按钮模板
    luaComponentTemplates.UIItemInfoPanel_GatheringBeads_RightUpOperateButtons = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplateForGatheringBeads.UIItemInfoPanel_GatheringBeads_RightUpOperateButtons"
    --endregion

    --region 藏品
    ---藏品tips主模板
    luaComponentTemplates.UIItemInfoPanel_MainPart_Collection = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForCollection.UIItemInfoPanel_MainPart_Collection"
    ---藏品tips辅助模板
    luaComponentTemplates.UIItemInfoPanel_AssistPart_Collection = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForCollection.UIItemInfoPanel_AssistPart_Collection"
    ---藏品基础属性组件模板
    luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute_Collection = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForCollection.UIItemInfoPanel_Info_BaseAttribute_Collection"
    --endregion

    --region 潜能武器
    ---潜能武器tips主模板
    luaComponentTemplates.UIItemInfoPanel_MainPart_Potential = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForPotentialEquip.UIItemInfoPanel_MainPart_Potential"
    ---潜能武器上部分视图模板
    luaComponentTemplates.UIItemInfoPanel_Info_Potential = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForPotentialEquip.UIItemInfoPanel_Info_Potential"
    ---潜能武器额外属性模板
    luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_Potential = require "luaRes.ui.template.UIItemInfoPanelTemplates.TemplatesForPotentialEquip.UIItemInfoPanel_Info_ExtraAttribute_Potential"
    --endregion

    --endregion

    --endregion

    --region 技能面板
    ---技能信息面板
    luaComponentTemplates.UISkillInfo_UISkillPanel = require "luaRes.ui.template.UISkillTemplates.UISkillInfo_UISkillPanel"
    luaComponentTemplates.UISkillTemplate_UISkillPanel = require "luaRes.ui.template.UISkillTemplates.UISkillTemplate_UISkillPanel"
    luaComponentTemplates.UISkillConfigTemplate = require "luaRes.ui.template.UISkillTemplates.UISkillConfigTemplate"
    ---配置面板
    luaComponentTemplates.UISkillConfigPanel = require "luaRes.ui.template.UISkillTemplates.UISkillConfigPanel"
    luaComponentTemplates.UISkillShortcutConfigTemplate = require "luaRes.ui.template.UISkillTemplates.UISkillShortcutConfigTemplate"

    luaComponentTemplates.UISkillIconUnitTemplate = require "luaRes.ui.template.UISkillTemplates.UISkillIconUnitTemplate"
    --region 秘籍技能（心法）
    --luaComponentTemplates.UISecretSkillBtnViewTemplate = require "luaRes.ui.template.UISecretSkillPanelTemplates.UISecretSkillBtnViewTemplate";
    --luaComponentTemplates.UISecretSkillBtnUnitTemplate = require "luaRes.ui.template.UISecretSkillPanelTemplates.UISecretSkillBtnUnitTemplate";
    --luaComponentTemplates.UISecretSkillUseBtnUnitTemplate = require "luaRes.ui.template.UISecretSkillPanelTemplates.UISecretSkillUseBtnUnitTemplate";
    --luaComponentTemplates.UISecretSkillTemplate = require "luaRes.ui.template.UISecretSkillPanelTemplates.UISecretSkillTemplate";

    luaComponentTemplates.UIHeartSkillViewTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartSkillViewTemplate";
    luaComponentTemplates.UIHeartSkillUnitTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartSkillUnitTemplate";
    luaComponentTemplates.UIHeartSkillInfoViewTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartSkillInfoViewTemplate";

    luaComponentTemplates.UIHeartSkillFormationInfoViewTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartSkillFormationInfoViewTemplate";

    luaComponentTemplates.UIHeartSkillFormationTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartSkillFormationTemplate";
    luaComponentTemplates.UIHeartFormationUnitShowTextTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartFormationUnitShowTextTemplate";

    luaComponentTemplates.UIHeartFormationChooseUnitTemplate = require "luaRes.ui.template.UISkillTemplates.UIHeartFormationChooseUnitTemplate";

    luaComponentTemplates.UISkillInfoTemplate = require "luaRes.ui.template.UISkillTemplates.UISkillInfoTemplate"
    --endregion

    --endregion

    --region 专精
    ---专精界面的列表中每个专精信息
    luaComponentTemplates.UIProficientPanel_ProficientItemTemplate = require "luaRes.ui.template.UIProficientPanel.UIProficientItemTemplate"
    ---专精界面的个体模板下的消耗材料
    luaComponentTemplates.UIProficientCostMaterialTemplate = require "luaRes.ui.template.UIProficientPanel.UIProficientCostMaterialTemplate"
    --endregion

    --region 角色面板相关
    luaComponentTemplates.RolePanel_DataDelta = require "luaRes.ui.template.UIRolePanelTemplates.RolePanel_DataDelta"
    ---角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplate = require "luaRes.ui.template.UIRolePanelTemplates.UIRolePanel_EquipTemplate"
    ---默认刷新角色模板
    luaComponentTemplates.UIRolePanel_GridTemplateBase = require "luaRes.ui.template.UIRolePanelTemplates.UIRolePanel_GridTemplateBase"
    ---锻造重写刷新角色模板
    luaComponentTemplates.UIRolePanel_GridTemplateStrength = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForStrengthen.UIRolePanel_GridTemplateStrength"
    ---锻造重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplateStrengthen = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForStrengthen.UIRolePanel_EquipTemplateStrengthen"
    ---宝物重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplateFurnace = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForFurnace.UIRolePanel_EquipTemplateFurnace"
    ---宝物重写角色装备模板
    luaComponentTemplates.UIRolePanel_GridTemplateFurnace = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForFurnace.UIRolePanel_GridTemplateFurnace"
    ---元素重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplatesElement = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForElement.UIRolePanel_EquipTemplatesElement"
    ---元素重写刷新角色模板
    luaComponentTemplates.UIRolePanel_GridTemplatesElement = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForElement.UIRolePanel_GridTemplatesElement"
    ---其他角色重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplateOtherPlayer = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForOtherPlayer.UIRolePanel_EquipTemplateOtherPlayer"
    ---其他角色重写角色装备刷新模板
    luaComponentTemplates.UIRolePanel_GridTemplateOtherPlayer = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForOtherPlayer.UIRolePanel_GridTemplateOtherPlayer"
    ---印记重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplateSignet = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSignet.UIRolePanel_EquipTemplateSignet"
    ---印记重写角色装备刷新模板
    luaComponentTemplates.UIRolePanel_GridTemplateSignet = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSignet.UIRolePanel_GridTemplateSignet"
    ---维修重写角色装备总模板
    luaComponentTemplates.UIRolePanel_EquipTemplateRepair = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRepair.UIRolePanel_EquipTemplateRepair"
    ---维修重写角色装备刷新模板
    luaComponentTemplates.UIRolePanel_GridTemplateRepair = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRepair.UIRolePanel_GridTemplateRepair"
    ---进化重写角色装备视图模板
    luaComponentTemplates.UIRolePanel_EquipTemplateEvolution = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForEvolution.UIRolePanel_EquipTemplateEvolution"
    ---进化重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateEvolution = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForEvolution.UIRolePanel_GridTemplateEvolution"
    ---融合重写角色装备视图模板
    luaComponentTemplates.UIRolePanel_EquipTemplatesMosaic = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForMosaic.UIRolePanel_EquipTemplatesMosaic"
    ---融合重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateMosaic = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForMosaic.UIRolePanel_GridTemplateMosaic"

    ---炼化重写角色装备视图模板
    luaComponentTemplates.UIRolePanel_EquipTemplateRefine = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRefine.UIRolePanel_EquipTemplateRefine"
    ---炼化重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateRefine = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRefine.UIRolePanel_GridTemplateRefine"

    ---合成重写角色装备视图模板
    luaComponentTemplates.UIRolePanel_EquipTemplateSynthesis = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSynthesis.UIRolePanel_EquipTemplateSynthesis"
    ---合成重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateSynthesis = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSynthesis.UIRolePanel_GridTemplateSynthesis"

    ---鉴定重写角色装备视图模板
    luaComponentTemplates.UIRolePanel_EquipTemplateJianDing = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForJianDing.UIRolePanel_EquipTemplateJianDing"
    ---鉴定重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateJianDing = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForJianDing.UIRolePanel_GridTemplateJianDing"

    ---阵法重写角色装备单元模板
    luaComponentTemplates.UIRolePanel_GridTemplateZhenFa = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForZhenFa.UIRolePanel_GridTemplateZhenFa"

    ---神力装备面板模板定义
    luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.UIRolePanel_SLSuitPanelTemplate"
    ---神力装备格子模板定义
    luaComponentTemplates.UIRolePanel_SLEquipGridTemp = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.UIRolePanel_SLEquipGridTemp"
    ---角色界面神力页签按钮的模板
    luaComponentTemplates.UIRolePanel_SLPageBtnTemp = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.UIRolePanel_SLPageBtnTemp"

    ---神力装备面板模板定义(维修继承)
    luaComponentTemplates.UIRolePanel_SLSuitPanel_RepairTemplate = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.Repair.UIRolePanel_SLSuitPanel_RepairTemplate"
    ---神力装备格子模板定义（维修继承）
    luaComponentTemplates.UIRolePanel_SLEquipGrid_RepairTemplate = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.Repair.UIRolePanel_SLEquipGrid_RepairTemplate"

    ---神力装备面板模板定义(神炼继承)
    luaComponentTemplates.UIRolePanel_SLSuitPanel_DivineSmeltTemplate = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.DivineSmelt.UIRolePanel_SLSuitPanel_DivineSmeltTemplate"
    ---神力装备格子模板定义（神炼继承）
    luaComponentTemplates.UIRolePanel_SLEquipGrid_DivineSmeltTemplate = require "luaRes.ui.template.UIRolePanelTemplates.ForSLSuit.DivineSmelt.UIRolePanel_SLEquipGrid_DivineSmeltTemplate"
    ---神炼目标的模板
    luaComponentTemplates.ForgeGodPowerSmeltTargetItemTemp = require "luaRes.ui.template.UIForgeGodPowerSmeltPanel.ForgeGodPowerSmeltTargetItemTemp"
    ---神练消耗品的模板
    luaComponentTemplates.ForgeGodPowerSmeltCostItemTemp = require "luaRes.ui.template.UIForgeGodPowerSmeltPanel.ForgeGodPowerSmeltCostItemTemp"

    --region 魂装镶嵌重写角色面板
    luaComponentTemplates.UIRolePanel_EquipTemplateSoulEquipSet = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSoulEquipSet.UIRolePanel_EquipTemplateSoulEquipSet"
    luaComponentTemplates.UIRolePanel_GridTemplateSoulEquipSet = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForSoulEquipSet.UIRolePanel_GridTemplateSoulEquipSet"
    --endregion

    --region 洗炼（继承魂装镶嵌界面）
    luaComponentTemplates.UIRolePanel_EquipTemplate_AgainSoulEquip = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForAgainSoulEquip.UIRolePanel_EquipTemplate_AgainSoulEquip"
    --endregion

    --region 仙器镶嵌重写角色面板
    luaComponentTemplates.UIRolePanel_EquipTemplateXianZhuang = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForXianZhuang.UIRolePanel_EquipTemplateXianZhuang"
    luaComponentTemplates.UIRolePanel_GridTemplateXianZhuang = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForXianZhuang.UIRolePanel_GridTemplateXianZhuang"
    --endregion

    --region 神装镶嵌重写角色面板
    luaComponentTemplates.UIRolePanel_EquipTemplateShenQi = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForShenQi.UIRolePanel_EquipTemplateShenQi"
    luaComponentTemplates.UIRolePanel_GridTemplateShenQi = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForShenQi.UIRolePanel_GridTemplateShenQi"
    --endregion

    --region 淬炼重写角色面板
    luaComponentTemplates.UIRolePanel_EquipTemplateForgeQuench = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForForgeQuench.UIRolePanel_EquipTemplateForgeQuench"
    luaComponentTemplates.UIRolePanel_GridTemplateForgeQuench = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForForgeQuench.UIRolePanel_GridTemplateForgeQuench"
    --endregion

    --region 重铸重写角色面板
    luaComponentTemplates.UIRolePanel_EquipTemplateRecast = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRecast.UIRolePanel_EquipTemplateRecast"
    luaComponentTemplates.UIRolePanel_GridTemplateRecast = require "luaRes.ui.template.UIRolePanelTemplates.TemplatesForRecast.UIRolePanel_GridTemplateRecast"
    --endregion

    --region 沙城争霸
    luaComponentTemplates.CityWar_RoleShow = require "luaRes.ui.template.UICityWarTemplates.CityWar_RoleShow"
    ---第一次沙城争霸界面模板
    luaComponentTemplates.UICityWarPanel_FirstWarPanel = require "luaRes.ui.template.UICityWarTemplates.UICityWarPanel_FirstWarPanel"
    ---沙城争霸规则模板
    luaComponentTemplates.UICityWarPanel_RulePanel = require "luaRes.ui.template.UICityWarTemplates.UICityWarPanel_RulePanel"
    --endregion

    --region 主界面_技能界面
    luaComponentTemplates.UIShotcutConfigTemplate = require "luaRes.ui.template.UIShotcutConfigTemplats.UIShotcutConfigTemplate"
    luaComponentTemplates.UIMainSkillXPSkills = require "luaRes.ui.template.UIMainSkillPanelTemplates.UIMainSkillXPSkills"
    luaComponentTemplates.UIMainSkillXPSlider = require "luaRes.ui.template.UIMainSkillPanelTemplates.UIMainSkillXPSlider"
    luaComponentTemplates.UIMainSkillXPSkillTemplate = require "luaRes.ui.template.UIMainSkillPanelTemplates.UIMainSkillXPSkillTemplate"
    luaComponentTemplates.UIGatherHintTarget = require "luaRes.ui.template.UIMainSkillPanelTemplates.UIGatherHintTarget"
    luaComponentTemplates.UITrainingHorseHintTarget = require "luaRes.ui.template.UIMainSkillPanelTemplates.UITrainingHorseHintTarget"
    --endregion

    --region 邮件
    ---邮件格子物品
    luaComponentTemplates.UIGridItem = require "luaRes.ui.template.UIMailTemplates.UIGridItem"
    --endregion

    --region 组队
    luaComponentTemplates.UITeamViewTemplate = require "luaRes.ui.template.UITeamTemplates.UITeamViewTemplate";
    luaComponentTemplates.UITeamUnitTemplate = require "luaRes.ui.template.UITeamTemplates.UITeamUnitTemplate";
    luaComponentTemplates.UICurrentTeamViewTemplate = require "luaRes.ui.template.UITeamTemplates.UICurrentTeamViewTemplate";
    luaComponentTemplates.UICurrentTeamUnitTemplate = require "luaRes.ui.template.UITeamTemplates.UICurrentTeamUnitTemplate";

    luaComponentTemplates.UIJoinTeamViewTemplate = require "luaRes.ui.template.UITeamTemplates.UIJoinTeamViewTemplate";
    luaComponentTemplates.UIJoinTeamUnitTemplate = require "luaRes.ui.template.UITeamTemplates.UIJoinTeamUnitTemplate";
    luaComponentTemplates.UIJoinOtherTeamUnitTemplate = require "luaRes.ui.template.UITeamTemplates.UIJoinOtherTeamUnitTemplate";
    --endregion

    --region 快捷组队
    luaComponentTemplates.UIShortcutTeamTemplates = require "luaRes.ui.template.UIMissionPanelTemplates.UIShortcutTeamTemplates"
    luaComponentTemplates.UIQuickTeamTemplate = require "luaRes.ui.template.UIMissionPanelTemplates.UIQuickTeamTemplate"
    luaComponentTemplates.UITeamTipTemplate = require "luaRes.ui.template.UIMissionPanelTemplates.UITeamTipTemplate"
    --endregion

    --region 每日目标
    ---每日目标界面每日活动
    ---luaComponentTemplates.UIDayToDayPanel_DailyActivity = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_DailyActivity"
    ---每日目标界面 任务活动
    luaComponentTemplates.UIDayToDayPanel_MissionActivity = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_MissionActivity"
    ---每日目标界面 任务活动奖励
    luaComponentTemplates.UIDayToDayPanel_MissionRewardTemplate = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_MissionRewardTemplate"
    ---每日目标界面活跃度奖励宝箱
    luaComponentTemplates.UIDayToDayPanel_ActiveRewardBox = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_ActiveRewardBox"
    -----每日目标界面周历
    --luaComponentTemplates.UIDayToDayPanel_WeeklyActivity = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_WeeklyAcitvity"
    -----每日目标界面周历格子
    --luaComponentTemplates.UIDayToDayPanel_WeeklyActivity_Cell = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_WeeklyActivity_Cell"
    -----每日目标界面周历列视图
    --luaComponentTemplates.UIDayToDayPanel_WeeklyAcitvity_Cell_View = require "luaRes.ui.template.UIDayToDayPanelTemplates.UIDayToDayPanel_WeeklyAcitvity_Cell_View"
    ---左侧活跃显示单元模板
    luaComponentTemplates.UILeftAcitvityUnitTemplates = require "luaRes.ui.template.UIDayToDayPanelTemplates.UILeftAcitvityUnitTemplates"
    --endregion

    --region 任务
    luaComponentTemplates.UIMissionPanel_Mission = require "luaRes.ui.template.UIMissionPanelTemplates.UIMissionPanel_Mission"
    luaComponentTemplates.UIMissionInfoTemplates = require "luaRes.ui.template.UIMissionPanelTemplates.UIMissionInfoTemplates"
    ---精英任务
    luaComponentTemplates.UIEliteMissionTemplates = require "luaRes.ui.template.UIMissionPanelTemplates.UIEliteMissionTemplates"
    ---任务奖励
    luaComponentTemplates.UIMissionRewardTemplates = require "luaRes.ui.template.UIMissionPanelTemplates.UIMissionRewardTemplates"

    ---挑战BOSS任务（sf日活）
    luaComponentTemplates.UIBossChallengePanel_MissionTemplate = require "luaRes.ui.template.UIBossChallengePanelTemplate.UIBossChallengePanel_MissionTemplate"
    --endregion

    --region 好友子界面
    luaComponentTemplates.UISocial_LastChatPanel = require "luaRes.ui.template.UISocialContactTemplates.UISocial_LastChatPanel"
    luaComponentTemplates.UISocial_AddFriendPanel = require "luaRes.ui.template.UISocialContactTemplates.UISocial_AddFriendPanel"
    luaComponentTemplates.UISocial_FriendInfoPanel = require "luaRes.ui.template.UISocialContactTemplates.UISocial_FriendInfoPanel"
    luaComponentTemplates.UISocial_FriendCirclePanel = require "luaRes.ui.template.UISocialContactTemplates.UISocial_FriendCirclePanel"

    ----region 朋友圈
    luaComponentTemplates.UICircleOfFriendsViewTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsViewTemplate"
    luaComponentTemplates.UICircleOfFriendsLeftViewTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsLeftViewTemplate"
    luaComponentTemplates.UICircleOfFriendsLeftUnitTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsLeftUnitTemplate"
    luaComponentTemplates.UICircleOfFriendsRightViewTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsRightViewTemplate"
    luaComponentTemplates.UICircleOfFriendsSystemMessageViewTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsSystemMessageViewTemplate"
    luaComponentTemplates.UICircleOfFriendsSystemMessageUnitTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendsSystemMessageUnitTemplate"
    --luaComponentTemplates.UICircleOfFriendMyNewViewTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendMyNewViewTemplate"
    --luaComponentTemplates.UICircleOfFriendMyNewUnitTemplate = require "luaRes.ui.template.UISocialContactTemplates.UICircleOfFriendsTemplates.UICircleOfFriendMyNewUnitTemplate"
    ----endregion

    --endregion

    --region 好友信息
    luaComponentTemplates.UISocialFriendInfoTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.UISocialFriendInfoTemplates"
    luaComponentTemplates.UISocialLastChatFriendTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.UISocialLastChatFriendTemplates"

    --小秘书
    luaComponentTemplates.UILeftSecretaryHeadTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UILeftSecretaryHeadTemplates"
    ---小秘书面板
    luaComponentTemplates.UISecretaryTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryTemplates"
    ---对话信息面板
    luaComponentTemplates.UISecretaryDialogueTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryDialogueTemplates"
    ---问题反馈面板
    luaComponentTemplates.UISecretaryFeedbackTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryFeedbackTemplates"
    ---回答面板
    luaComponentTemplates.UISecretaryAnswerTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryAnswerTemplates"
    ---玩家提问面板
    luaComponentTemplates.UISecretaryPlayerChatTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryPlayerChatTemplates"
    ---对话信息页签
    luaComponentTemplates.UISecretaryAnswerNavigationTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UISecretaryAnswerNavigationTemplates"
    ---道具获取方式
    luaComponentTemplates.UIItemGetWay_ItemPartRightUpOperate = require "luaRes.ui.template.UIFriendInfoTemplates.Secretary.UIItemGetWay_ItemPartRightUpOperate"

    --endregion

    --region 好友类别对应功能
    luaComponentTemplates.UIFriendRelationFunctionTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.UIFriendRelationFunctionTemplates"
    --endregion

    --region 好友申请列表
    luaComponentTemplates.UIAddFriendInfoTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.UIAddFriendInfoTemplates"
    luaComponentTemplates.UIApproveFriendInfoTemplates = require "luaRes.ui.template.UIFriendInfoTemplates.UIApproveFriendInfoTemplates"
    --endregion

    --region 灵兽

    ---左上角灵兽头像
    luaComponentTemplates.UIServantHeadTemplate = require "luaRes.ui.template.UIServantTemplates.UIServantHeadTemplate"
    ---面板中灵兽列表单个模板
    luaComponentTemplates.UIServantInfoTemplate = require "luaRes.ui.template.UIServantTemplates.UIServantInfoTemplate"
    ---灵兽装备格子模板
    luaComponentTemplates.UIServantEquipGridTemplate = require "luaRes.ui.template.UIServantTemplates.UIServantEquipGridTemplate"
    ---灵兽魂继装备格子模板
    luaComponentTemplates.UIServantHunJiEquipGridTemplate = require "luaRes.ui.template.UIServantTemplates.UIServantHunJiEquipGridTemplate"
    ---灵兽合成装备格子模板
    luaComponentTemplates.UIServantEquipGridTemplate_Synthesis = require "luaRes.ui.template.UIServantTemplates.UISynthesisPanelServantTemplate.UIServantEquipGridTemplate_Synthesis"
    ---炼制大师灵兽头像
    luaComponentTemplates.UIServantHeadInfoInRefineMasterTemplate = require "luaRes.ui.template.UIServantTemplates.UIServantHeadInfoInRefineMasterTemplate"

    luaComponentTemplates.UIServantBasicPanel = require "luaRes.ui.template.UIServantTemplates.UIServantBasicPanel"
    luaComponentTemplates.UIServantPanel_Base = require "luaRes.ui.template.UIServantTemplates.UIServantPanel_Base"
    luaComponentTemplates.UIServantPanel_Level = require "luaRes.ui.template.UIServantTemplates.UIServantPanel_Level"
    luaComponentTemplates.UIServantPanel_Rein = require "luaRes.ui.template.UIServantTemplates.UIServantPanel_Rein"
    luaComponentTemplates.UIServantPanel_HunJi = require "luaRes.ui.template.UIServantTemplates.UIServantPanel_HunJi"

    ---维修重写灵兽头像模板
    luaComponentTemplates.UIServantHeadTemplate_Repair = require "luaRes.ui.template.UIServantTemplates.UIRepairPanelServantTemplates.UIServantHeadTemplate_Repair"
    ---维修重写灵兽装备模板
    luaComponentTemplates.UIServantPanel_Base_Repair = require "luaRes.ui.template.UIServantTemplates.UIRepairPanelServantTemplates.UIServantPanel_Base_Repair"
    ---灵兽修炼地图模板
    luaComponentTemplates.UIServantPracticeMapTemplate = require "luaRes.ui.template.UIServantPracticeMap.UIServantPracticeMapTemplate"
    ---合成重写灵兽装备模板
    luaComponentTemplates.UIServantPanel_Base_Synthesis = require "luaRes.ui.template.UIServantTemplates.UISynthesisPanelServantTemplate.UIServantPanel_Base_Synthesis"
    ---合成重写灵兽头像模板
    luaComponentTemplates.UIServantHeadTemplate_Synthesis = require "luaRes.ui.template.UIServantTemplates.UISynthesisPanelServantTemplate.UIServantHeadTemplate_Synthesis"
    ---炼化重写灵兽装备模板
    luaComponentTemplates.UIServantPanel_Base_Refine = require "luaRes.ui.template.UIServantTemplates.UIRefinePanelServantTemplate.UIServantPanel_Base_Refine"
    --endregion

    --endregion

    --region 神炉
    luaComponentTemplates.UIFurnaceViewTemplate = require "luaRes.ui.template.UIFurnacePanelTemplates.UIFurnaceViewTemplate"
    luaComponentTemplates.UIFurnaceOtherAttributeUnitTemplate = require "luaRes.ui.template.UIFurnacePanelTemplates.UIFurnaceOtherAttributeUnitTemplate"
    luaComponentTemplates.UIFurnaceSpecialAttributesViewTemplate = require "luaRes.ui.template.UIFurnacePanelTemplates.UIFurnaceSpecialAttributesViewTemplate"
    luaComponentTemplates.UIFurnaceSpecialAttributesUnitTemplate = require "luaRes.ui.template.UIFurnacePanelTemplates.UIFurnaceSpecialAttributesUnitTemplate"
    --endregion

    --region 激情夜战
    luaComponentTemplates.UINightCityItemTemplate = require "luaRes.ui.template.UINightCityTemplates.UINightCityItemTemplate"
    luaComponentTemplates.UINightCityRankItemTemplate = require "luaRes.ui.template.UINightCityTemplates.UINightCityRankItemTemplate"
    --endregion

    --region 寻宝
    luaComponentTemplates.UITreasurePanel_SeekTreasure = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_SeekTreasure"
    luaComponentTemplates.UITreasurePanel_Warehouse = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_Warehouse"
    luaComponentTemplates.UITreasurePanel_RecordItem = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_RecordItem"
    luaComponentTemplates.UITreasurePanel_Record = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_Record"
    luaComponentTemplates.UITreasurePanel_SeekTreasureItem = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_SeekTreasureItem"
    luaComponentTemplates.UITreasurePanel_SeekTreasureRiffleItem = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_SeekTreasureRiffleItem"
    luaComponentTemplates.UITreasurePanel_Item = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_Item"
    luaComponentTemplates.UITreasurePanel_ItemPartRightUpOperate = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_ItemPartRightUpOperate"
    luaComponentTemplates.UITreasurePanel_ItemPart = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_ItemPart"
    luaComponentTemplates.UITreasurePanel_ItemPart_Pet = require "luaRes.ui.template.UITreasurePanelTemplates.UITreasurePanel_ItemPart_Pet"
    --endregion

    --region 商城
    luaComponentTemplates.UICoinsShowViewTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UICoinsShowViewTemplate";
    luaComponentTemplates.UICoinsShowUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UICoinsShowUnitTemplate";
    luaComponentTemplates.UIFurnaceQuickShopViewTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIFurnaceQuickShopViewTemplate";
    luaComponentTemplates.UIShopOtherCurrencyUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopOtherCurrencyUnitTemplate";
    --endregion

    --region View
    luaComponentTemplates.UIShopViewTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopViewTemplates.UIShopViewTemplate";
    luaComponentTemplates.UIGroceryStoreViewTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopViewTemplates.UIGroceryStoreViewTemplate";
    luaComponentTemplates.UICommerceShopViewTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopViewTemplates.UICommerceShopViewTemplate";
    --endregion

    --region Unit
    luaComponentTemplates.UIShopUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopUnitTemplate.UIShopUnitTemplate";
    luaComponentTemplates.UICommerceShopUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopUnitTemplate.UICommerceShopUnitTemplate";
    luaComponentTemplates.UIWayGetShopUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIShopUnitTemplate.UIWayGetShopUnitTemplate";
    --endregion

    --region ShopPageUnitTemplate
    luaComponentTemplates.UIShopPageUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIPageUnitTemplate.UIShopPageUnitTemplate";
    luaComponentTemplates.UICommerceShopPageUnitTemplate = require "luaRes.ui.template.UIShopPanelTemplates.UIPageUnitTemplate.UICommerceShopPageUnitTemplate";
    --endregion

    --region Vip
    luaComponentTemplates.UIVipToggleTemplate = require "luaRes.ui.template.UIMonthCardTemplates.UIVipToggleTemplate"
    --endregion

    --region 称号
    luaComponentTemplates.UITitleTemplate = require "luaRes.ui.template.UITitleTemplates.UITitleTemplate"
    --endregion

    --region 活动
    --luaComponentTemplates.UIActivityBtnUnitTemplate = require "luaRes.ui.template.UIActivityTemplates.UIActivityBtnUnitTemplate"
    --luaComponentTemplates.UIAwardHallBtnViewTemplate = require "luaRes.ui.template.UIActivityTemplates.UIAwardHallBtnViewTemplate"
    --luaComponentTemplates.UIAwardHallBtnUnitTemplate = require "luaRes.ui.template.UIActivityTemplates.UIAwardHallBtnUnitTemplate"
    --luaComponentTemplates.UIActivityRewardUnitTemplate = require "luaRes.ui.template.UIActivityTemplates.UIActivityRewardUnitTemplate"
    --luaComponentTemplates.UIActivityRewardViewTemplate = require "luaRes.ui.template.UIActivityTemplates.UIActivityRewardViewTemplate"
    --luaComponentTemplates.UIOnLineRewardUnitTemplate = require "luaRes.ui.template.UIActivityTemplates.UIOnLineRewardUnitTemplate"
    --luaComponentTemplates.UIOnLineRewardViewTemplate = require "luaRes.ui.template.UIActivityTemplates.UIOnLineRewardViewTemplate"
    --luaComponentTemplates.UITimingRewardUnitTemplate = require "luaRes.ui.template.UIActivityTemplates.UITimingRewardUnitTemplate"
    --luaComponentTemplates.UITimingRewardViewTemplate = require "luaRes.ui.template.UIActivityTemplates.UITimingRewardViewTemplate"


    --endregion

    --region 传送
    luaComponentTemplates.UITeleportBtnTemplate = require "luaRes.ui.template.UITeleportTemplates.UITeleportBtnTemplate"
    --endregion

    --region UIItem展示列表
    luaComponentTemplates.UIItemShowListTemplate = require "luaRes.ui.template.UIItemTemplates.UIItemShowListTemplate";
    --endregion

    --region 战力变动
    luaComponentTemplates.UIAttributeChangeViewTemplate = require "luaRes.ui.template.UIAttributeChangeTemplates.UIAttributeChangeViewTemplate"
    luaComponentTemplates.UIAttributeChangeUnitTemplate = require "luaRes.ui.template.UIAttributeChangeTemplates.UIAttributeChangeUnitTemplate"
    luaComponentTemplates.UIAttributeChangeUnitTweenTemplate = require "luaRes.ui.template.UIAttributeChangeTemplates.UIAttributeChangeUnitTweenTemplate"
    --endregion

    --region 文字弹窗提示
    luaComponentTemplates.UITipsTemplate = require "luaRes.ui.template.UITipsTemplates.UITipsTemplate"
    luaComponentTemplates.UITipsSecondTemplate = require "luaRes.ui.template.UITipsTemplates.UITipsSecondTemplate"
    luaComponentTemplates.UITextTipsContainerTemplate = require "luaRes.ui.template.UITipsTemplates.UITextTipsContainerTemplate"
    luaComponentTemplates.UITipsMiddleTopTemplate = require "luaRes.ui.template.UITipsTemplates.UITipsMiddleTopTemplate"
    --endregion

    --region 对话提示框
    luaComponentTemplates.UIDialogTipsTemplate1 = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.UIDialogTipsTemplate1"
    luaComponentTemplates.UIDialogTipsTemplate2 = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.UIDialogTipsTemplate2"
    luaComponentTemplates.UIDialogTipsTemplate3 = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.UIDialogTipsTemplate3"
    luaComponentTemplates.UIDialogTipsTemplate4 = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.UIDialogTipsTemplate4"
    luaComponentTemplates.UIDialogTipsTemplate5 = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.UIDialogTipsTemplate5"
    luaComponentTemplates.HintClickTipsTemplate = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.HintClickTipsTemplate"
    luaComponentTemplates.HintClickTipTemplate = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.Main.HintClickTipTemplate"
    --endregion

    --region Boss面板
    --luaComponentTemplates.UIGoMapBtnViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIGoMapBtnViewTemplate"
    --luaComponentTemplates.UIGoMapBtnUnitTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIGoMapBtnUnitTemplate"
    --luaComponentTemplates.UIBossViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossViewTemplate"
    --luaComponentTemplates.UIBossUnitTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossUnitTemplate"
    --luaComponentTemplates.UIBossPreviewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossPreviewTemplate"

    luaComponentTemplates.UIBossDamageRankViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossDamageRankViewTemplate"
    luaComponentTemplates.UIBossDamageRankUnitTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossDamageRankUnitTemplate"

    ---boss伤害排行奖励
    luaComponentTemplates.UIBossRankRewardUnitTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossRankRewardUnitTemplate"

    ---Boss积分面板
    --luaComponentTemplates.UIBossScorePanelTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossScorePanelTemplate"    ---Boss积分格子模板
    luaComponentTemplates.UIBossScoreGridTemplate = require "luaRes.ui.template.UIBossPanelTemplates.UIBossScoreGridTemplate"
    ---Boss左侧页签
    luaComponentTemplates.UIBossPanel_LeftPageTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_LeftPageTemplate"
    ---Boss视图基类模板
    luaComponentTemplates.UIBossPanel_BaseViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_BaseViewTemplate"
    ---Boss视图模板
    luaComponentTemplates.UIBossPanel_NormalViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_NormalViewTemplate"
    ---Boss视图模板——boss积分
    luaComponentTemplates.UIBossPanel_BossScoreViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_BossScoreViewTemplate"
    ---魔之Boss视图模板
    luaComponentTemplates.UIBossPanel_MagicBossViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_MagicBossViewTemplate"
    ---终极Boss视图模板
    luaComponentTemplates.UIBossPanel_FinalViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_FinalViewTemplate"
    ---私服终极Boss视图模板
    luaComponentTemplates.UIBossPanel_NewFinalViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_NewFinalViewTemplate"
    ---个人Boss视图模板
    luaComponentTemplates.UIBossPanel_PersonalViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_PersonalViewTemplate"
    ---生效Boss视图模板
    luaComponentTemplates.UIBossPanel_ShengXiaoViewTemplate = require "luaRes.ui.template.UIBossPanelTemplates.View.UIBossPanel_ShengXiaoViewTemplate"
    --endregion

    --region 各种slider
    luaComponentTemplates.UISliderBasic = require "luaRes.ui.template.UISliderTemplates.UISliderBasic"
    luaComponentTemplates.UIExpSlider = require "luaRes.ui.template.UISliderTemplates.UIExpSlider"
    --endregion

    --region 获取途径组件
    luaComponentTemplates.UIBtnListTemplate = require "luaRes.ui.template.UIBtnListTemplates.UIBtnListTemplate"

    --endregion

    --region 锻造
    luaComponentTemplates.UIForgePanel_ForgeType = require "luaRes.ui.template.UIForgePanelTemplates.UIForgeTypeTemplate"
    luaComponentTemplates.UIForgePanel_EquipownerType = require "luaRes.ui.template.UIForgePanelTemplates.UIEquipownerTypeTemplate"
    ---强化材料模板
    luaComponentTemplates.UIForgeStrengthenPanel_CostItemTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIForgeStrengthenPanel_CostItemTemplate"

    ---进化
    luaComponentTemplates.UIEvolutionViewTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIEvolutionTemplate.UIEvolutionViewTemplate"
    luaComponentTemplates.UIForgeTargetItemViewTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIForgeTargetItemViewTemplate"

    luaComponentTemplates.UIEvolutionCostChooseViewTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIEvolutionTemplate.UIEvolutionCostChooseViewTemplate"
    luaComponentTemplates.UIEvolutionCostChooseUnitTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIEvolutionTemplate.UIEvolutionCostChooseUnitTemplate"
    luaComponentTemplates.UIEvolutionCostButtonTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UIEvolutionTemplate.UIEvolutionCostButtonTemplate"
    --endregion

    --region 合成
    luaComponentTemplates.UISynthesisViewTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisViewTemplate"
    luaComponentTemplates.UISynthesisTargetUnitTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisTargetUnitTemplate"
    luaComponentTemplates.UISynthesisMaterialUnitTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisMaterialUnitTemplate"
    ---合成列表按钮模板1
    luaComponentTemplates.UISynthesisMainCategoryPage = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisMainCategoryPage"
    ---合成列表分类页签
    luaComponentTemplates.UISynthesisSubCategoryPage = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisSubCategoryPage"
    ---合成列表目标模板
    luaComponentTemplates.UISynthesisPageTargetItem = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisPageTargetItem"

    luaComponentTemplates.UISynthesisTargetChooseViewTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisTargetChooseViewTemplate"

    luaComponentTemplates.UISynthesisTargetChooseUnitTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisTargetChooseUnitTemplate"
    luaComponentTemplates.UISynthesisView_BoxItemTemplate = require "luaRes.ui.template.UIForgePanelTemplates.UISynthesisPanelTemplate.UISynthesisView_BoxItemTemplate"
    --endregion

    --region 升星
    ---升星重写灵兽基础模板
    luaComponentTemplates.UIForgeStrengthPanel_ServantBase = require "luaRes.ui.template.UIForgeStrengthPanelTemplates.UIForgeStrengthPanel_ServantBase"
    --endregion

    --region 转移
    ---转移重写灵兽头像模板
    luaComponentTemplates.UIForgeTransferPanel_ServantHead = require "luaRes.ui.template.UIForgeTransferPanelTemplates.UIForgeTransferPanel_ServantHead"
    ---转移重写灵兽装备模板
    luaComponentTemplates.UIForgeTransferPanel_ServantBase = require "luaRes.ui.template.UIForgeTransferPanelTemplates.UIForgeTransferPanel_ServantBase"
    ---转移重写角色装备视图模板
    luaComponentTemplates.UIForgeTransferPanel_RoleEquipTemplate = require "luaRes.ui.template.UIForgeTransferPanelTemplates.UIForgeTransferPanel_RoleEquipTemplate"
    ---转移重写角色装备单元模板
    luaComponentTemplates.UIForgeTransferPanel_RoleGridTemplateBase = require "luaRes.ui.template.UIForgeTransferPanelTemplates.UIForgeTransferPanel_RoleGridTemplateBase"
    ---转移格子模板
    luaComponentTemplates.UIForgeTransferPanel_TransferGrid = require "luaRes.ui.template.UIForgeTransferPanelTemplates.UIForgeTransferPanel_TransferGrid"
    --endregion

    --region 头像面板
    ---头像下buff面板
    luaComponentTemplates.UIHeadPanel_Buff = require "luaRes.ui.template.UIHeadPanelTemplates.UIBuffTemplate"
    ---头像下单个buff
    luaComponentTemplates.UIHeadPanel_SingleBuff = require "luaRes.ui.template.UIHeadPanelTemplates.UISingleBuffTemplate"
    ---buff详情信息列表
    luaComponentTemplates.UIHeadPanel_BuffInfo = require "luaRes.ui.template.UIHeadPanelTemplates.UIBuffInfoTemplate"
    ---单个buff详情信息模板
    luaComponentTemplates.UISingleBuffInfoTemplate = require "luaRes.ui.template.UIHeadPanelTemplates.UISingleBuffInfoTemplate"
    --endregion

    --region 活动副本通用面板
    luaComponentTemplates.UIActivityDuplicateRewardItemTemplate = require "luaRes.ui.template.UIActivityDuplicatePanelTemplates.UIActivityDuplicateRewardItemTemplate"
    luaComponentTemplates.UIActivityDuplicateRankItemTemplate = require "luaRes.ui.template.UIActivityDuplicatePanelTemplates.UIActivityDuplicateRankItemTemplate"
    luaComponentTemplates.UIActivityDuplicateTitleTeamplate = require "luaRes.ui.template.UIActivityDuplicatePanelTemplates.UIActivityDuplicateTitleTeamplate"
    --endregion

    --region 商业化-竞技
    ---类型1格子模板
    luaComponentTemplates.UICompetitionPanel_Type1Template = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type1Template"
    ---类型2格子模板
    luaComponentTemplates.UICompetitionPanel_Type2Template = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type2Template"
    ---类型3格子模板
    luaComponentTemplates.UICompetitionPanel_Type3Template = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type3Template"
    ---类型4格子模板
    luaComponentTemplates.UICompetitionPanel_Type4Template = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type4Template"
    ---类型5回收格子模板
    luaComponentTemplates.UICompetitionPanel_Type5Template = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type5Template"
    ---类型4（战勋小目标模板）
    luaComponentTemplates.UICompetitionPanel_Type4SmallAimTemplate = require "luaRes.ui.template.UICompetitionPanel.UICompetitionPanel_Type4SmallAimTemplate"
    --endregion

    --region 洞窟试炼
    luaComponentTemplates.UICavernTrialInfoRankInfoTemplate = require "luaRes.ui.template.UICavernTrialInfoPanelTemplates.UICavernTrialInfoRankInfoTemplate"
    --endregion

    --region GM命令
    luaComponentTemplates.UIGMDirectiveTemplate = require "luaRes.ui.template.UIGMTools.UIGMDirectiveTemplates.UIGMDirectiveTemplate"
    luaComponentTemplates.UIGMItemTemplate = require "luaRes.ui.template.UIGMTools.UIGMDirectiveTemplates.UIGMItemTemplate"
    luaComponentTemplates.UIGMMonsterTemplate = require "luaRes.ui.template.UIGMTools.UIGMDirectiveTemplates.UIGMMonsterTemplate"
    luaComponentTemplates.UIGMModelController = require "luaRes.ui.template.UIGMTools.UIGMModelCtrl.UIGMModelControllerTemplate"
    luaComponentTemplates.UIGMItemTemplate_BagItemLid = require "luaRes.ui.template.UIGMTools.UIGMDirectiveTemplates.UIGMItemTemplate_BagItemLid"
    luaComponentTemplates.UIGMPanel_HotDetection = require "luaRes.ui.template.UIGMTools.UIGMHotDetection.UIGMPanel_HotDetection"

    luaComponentTemplates.UIGMPanel_ClientLog = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_ClientLog"
    luaComponentTemplates.UIGMPanel_ComponentManager = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_ComponentManager"
    luaComponentTemplates.UIGMPanel_Component_Item = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_Component_Item"
    luaComponentTemplates.UIGMPanel_Generate = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_Generate"
    luaComponentTemplates.UIGMPanel_Monster = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_Monster"
    luaComponentTemplates.UIGMPanel_NetLog = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_NetLog"
    luaComponentTemplates.UIGMPanel_Order = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_Order"
    luaComponentTemplates.UIGMPanel_Tool = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_Tool"
    luaComponentTemplates.UIGMPanel_SceneInfo = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_SceneInfo"
    luaComponentTemplates.UIGMPanel_PortInfo = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_PortInfo"
    luaComponentTemplates.UIGMPanelLogViewer = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogViewer"
    luaComponentTemplates.UIGMPanelLogViewer_LogDetail = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogViewer_LogDetail"
    luaComponentTemplates.UIGMPanelLogViewer_LogList = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogViewer_LogList"
    luaComponentTemplates.UIGMPanelLogViewer_LogType = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogViewer_LogType"
    luaComponentTemplates.UIGMPanelLogViewer_BriefLog = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogView_BriefLog"
    luaComponentTemplates.UIGMPanelLogViewer_SingleBriefLog = require "luaRes.ui.template.UIGMTools.UILogViewer.UIGMPanelLogView_SingleBriefLog"
    luaComponentTemplates.UIGMPanelLogView_IndividualFilterBase = require "luaRes.ui.template.UIGMTools.UILogViewer.IndividualFilter.UIGMPanelLogView_IndividualFilterBase"
    luaComponentTemplates.UIGMPanelLogView_IndividualFilter_NetworkMsg = require "luaRes.ui.template.UIGMTools.UILogViewer.IndividualFilter.UIGMPanelLogView_IndividualFilter_NetworkMsg"
    luaComponentTemplates.UIGMPanel_BagItemLid = require "luaRes.ui.template.UIGMTools.UIGMExtend.UIGMPanel_BagItemLid"
    luaComponentTemplates.UIGMPanelLogView_ClientRobot = require "luaRes.ui.template.UIGMTools.UIClientRobot.UIGMPanelLogView_ClientRobot"
    luaComponentTemplates.UIGMModelTemplates = require "luaRes.ui.template.UIGMTools.UIGMModelTemplates.UIGMModelTemplates"
    luaComponentTemplates.UIGMModel_ExhibitionTemplates = require "luaRes.ui.template.UIGMTools.UIGMModelTemplates.UIGMModel_ExhibitionTemplates"
    luaComponentTemplates.UIGMEventStateViewer = require "luaRes.ui.template.UIGMTools.UIEventStateView.UIGMEventStateViewer"
    luaComponentTemplates.UILoadServerResources = require "luaRes.ui.template.UIGMTools.UILoadServerResources.UILoadServerResources"

    --endregion

    --region 导航栏
    luaComponentTemplates.UINavigationFirstMenuViewTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationFirstMenuViewTemplate"
    luaComponentTemplates.UINavigationSecondMenuViewTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationSecondMenuViewTemplate"
    luaComponentTemplates.UINavigationThirdMenuViewTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationThirdMenuViewTemplate"
    luaComponentTemplates.UINavigationViewTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationViewTemplate"
    luaComponentTemplates.UINavigationUnitTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationUnitTemplate"
    luaComponentTemplates.UINavigationUnitListTemplate = require "luaRes.ui.template.UINavigationPanelTemplates.UINavigationUnitListTemplate"
    --endregion

    --region 快捷物品
    luaComponentTemplates.UIFastItemSettingViewTemplate = require "luaRes.ui.template.UIFastItemTemplate.UIFastItemSettingViewTemplate"
    luaComponentTemplates.UIFastItemSettingUnitTemplate = require "luaRes.ui.template.UIFastItemTemplate.UIFastItemSettingUnitTemplate"
    luaComponentTemplates.UIFastItemUseViewTemplate = require "luaRes.ui.template.UIFastItemTemplate.UIFastItemUseViewTemplate"
    luaComponentTemplates.UIFastItemUseUnitTemplate = require "luaRes.ui.template.UIFastItemTemplate.UIFastItemUseUnitTemplate"
    --endregion

    --region  维修
    ---维修装备格子模板
    luaComponentTemplates.UIRepairGridItem = require "luaRes.ui.template.UIRepairPanelTemplates.UIRepairGridItem"
    --endregion

    --region 拍卖行
    --region 基础模板
    ---交易行中的背包格子模板
    luaComponentTemplates.UIBagPanel_GridTemplateBase = require "luaRes.ui.template.UIBagPanelTemplates.UIBagPanel_GridTemplateBase"
    ---拍卖行筛选列表模板(总模板)
    luaComponentTemplates.UIAuctionFiltrateList = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionFiltrateList"
    ---求购类型模板
    luaComponentTemplates.UIAuctionBuying_Base = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionBuying_Base"
    --endregion

    --region 交易行目录
    ---目录模板Base
    luaComponentTemplates.UIAuctionMenuPanelTemplateBase = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionMenuPanelTemplates.UIAuctionMenuPanelTemplateBase"
    ---熔炼行目录模板
    luaComponentTemplates.UIAuctionSmeltPanel_MenuTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionMenuPanelTemplates.UIAuctionSmeltPanel_MenuTemplate"
    ---行会竞拍目录模板
    luaComponentTemplates.UIAuctionUnionPanel_MenuTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionMenuPanelTemplates.UIAuctionUnionPanel_MenuTemplate"
    --endregion

    --region 交易行下拉框模板
    ---下拉框模板总
    luaComponentTemplates.UIAuctionDropDownTemplateBase = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionDropDownTemplates.UIAuctionDropDownTemplateBase"
    ---熔炼下拉框模板
    luaComponentTemplates.UIAuctionDropDown_SmeltSortTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionDropDownTemplates.UIAuctionDropDown_SmeltSortTemplate"
    ---竞拍排序模板
    luaComponentTemplates.UIAuctionPanel_AuctionDropDownBase = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionDropDownTemplates.UIAuctionPanel_AuctionDropDownBase"
    --endregion

    --region 交易Trade
    ---拍卖行交易界面模板
    luaComponentTemplates.UIAuctionPanel_TradePanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_TradePanel.UIAuctionPanel_TradePanel"
    ---拍卖行购买格子模板
    luaComponentTemplates.UIAuctionGridItem = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_TradePanel.UIAuctionGridItem"
    ---拍卖行元宝交易筛选列表模板
    luaComponentTemplates.UIAuctionPanel_TradePanel_Menu = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_TradePanel.UIAuctionPanel_TradePanel_Menu"
    ---拍卖行切换购买右上角按钮模板
    luaComponentTemplates.UIItemInfoPanel_AuctionTrade_RightUpOperate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_TradePanel.UIItemInfoPanel_AuctionTrade_RightUpOperate"
    --endregion

    --region 个人交易SelfSell
    ---拍賣行個人出售界面模板
    luaComponentTemplates.UIAuctionPanel_SelfSellPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfSell.UIAuctionPanel_SelfSellPanel"
    ---拍卖行出售格子模板1
    luaComponentTemplates.UIAuctionPanel_SelfSellGridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfSell.UIAuctionPanel_SelfSellGridTemplate"
    --endregion

    --region 竞拍Auction
    ---拍卖行竞拍界面模板
    luaComponentTemplates.UIAuctionPanel_AuctionPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionPanel.UIAuctionPanel_AuctionPanel"
    ---拍卖行竞拍界面格子模板
    luaComponentTemplates.UIAuctionPanel_AuctionGrid = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionPanel.UIAuctionPanel_AuctionGrid"
    ---拍卖行竞拍筛选列表模板
    luaComponentTemplates.UIAuctionPanel_AuctionPanel_Menu = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionPanel.UIAuctionPanel_AuctionPanel_Menu"
    ---竞价右上角模板
    luaComponentTemplates.UIItemInfoPanel_AuctionBid_RightUpOperate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionPanel.UIItemInfoPanel_AuctionBid_RightUpOperate"
    ---仅购买右上角模板
    luaComponentTemplates.UIItemInfoPanel_AuctionBid_BuyRightUpOperate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionPanel.UIItemInfoPanel_AuctionBid_BuyRightUpOperate"
    --endregion

    --region 个人竞拍SelfAuction
    ---拍卖行个人竞拍界面
    luaComponentTemplates.UIAuctionPanel_SelfAuctionPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfAuction.UIAuctionPanel_SelfAuctionPanel"
    ---个人竞拍出售总列表格子模板
    luaComponentTemplates.UIAuctionPanel_SelfAuctionGridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfAuction.UIAuctionPanel_SelfAuctionGridTemplate"
    ---个人竞拍上架TIps模板
    luaComponentTemplates.UIAuctionPanel_AuctionTipsTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfAuction.UIAuctionPanel_AuctionTipsTemplate"
    --endregion

    --region 求购BuyingPanel
    ---求购界面模板
    luaComponentTemplates.UIAuctionPanel_BuyingPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIAuctionPanel_BuyingPanel"
    ---求购物品格子模板
    luaComponentTemplates.UIAuctionPanel_BuyingGrid = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIAuctionPanel_BuyingGrid"
    ---求购背包格子模板
    luaComponentTemplates.UIByingPanel_GridItem = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIByingPanel_GridItem"
    ---求购目录
    luaComponentTemplates.UIAuctionPanel_BuyingPanel_Menu = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIAuctionPanel_BuyingPanel_Menu"
    ---求购背包交互层模板
    luaComponentTemplates.UIAuctionPanel_BuyingPanel_BagItemInteraction = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIAuctionPanel_BuyingPanel_BagItemInteraction"
    ---求购背包格子模板
    luaComponentTemplates.UIAuctionPanel_BuyingPanel_BagItemTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_BuyingPanel.UIAuctionPanel_BuyingPanel_BagItemTemplate"
    --endregion

    --region 个人求购
    ---个人求购模板
    luaComponentTemplates.UIAuctionPanel_SelfBuyingPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionPanel_SelfBuyingPanel"
    ---个人求购选择模板
    luaComponentTemplates.UIAuctionPanel_SelfBuying_BagPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionPanel_SelfBuying_BagPanel"
    ---个人求购列表模板
    luaComponentTemplates.UIAuctionPanel_SelfBuyingListTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionPanel_SelfBuyingListTemplate"
    ---个人求购列表格子模板
    luaComponentTemplates.UIAuctionPanel_SelfBuyingListGridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionPanel_SelfBuyingListGridTemplate"
    ---个人发布求购模板
    luaComponentTemplates.UIAuctionBuyingTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionBuyingTemplate"
    ---个人重新求购模板（已过期）
    luaComponentTemplates.UIAuctionBuyingReAddTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionBuyingReAddTemplate"
    ---个人重新求购模板（未过期）
    luaComponentTemplates.UIAuctionDialog_BuyingRemoveDidNotExpire = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_SelfBuying.UIAuctionDialog_BuyingRemoveDidNotExpire"
    --endregion

    --region 摊位模板
    ---摊位界面模板
    luaComponentTemplates.UIAuctionPanel_StallPanel = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_StallPanel.UIAuctionPanel_StallPanel"
    ---摊位信息模板
    luaComponentTemplates.UIAuctionPanel_StallInfo = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_StallPanel.UIAuctionPanel_StallInfo"
    ---多项选择模板
    luaComponentTemplates.MultitermChooseTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_StallPanel.MultitermChooseTemplate"
    ---多项选择按钮模板
    luaComponentTemplates.MultitermChooseBtnTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_StallPanel.MultitermChooseBtnTemplate"
    --endregion

    --region 拍卖行推送
    ---拍卖行推送总模板
    luaComponentTemplates.UIAuctionPushPanel_RootTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPushPanel.UIAuctionPushPanel_RootTemplate"
    ---上架推送模板
    luaComponentTemplates.UIAuctionPushPanel_ShelvesPushTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPushPanel.UIAuctionPushPanel_ShelvesPushTemplate"
    ---购买推送模板
    luaComponentTemplates.UIAuctionPushPanel_BuyingPushTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPushPanel.UIAuctionPushPanel_BuyingPushTemplate"
    ---玩家上架购买推送
    luaComponentTemplates.UIAuctionPushPanel_PlayerTradePushTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPushPanel.UIAuctionPushPanel_PlayerTradePushTemplate"
    --endregion

    --region 上架模板
    ---上架模板
    ---*价格已修改*
    luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItemTemplateBase"

    ---竞拍上架模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionAddShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionAddShelf"
    ---竞拍下架模板（过期）
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionRemoveShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionRemoveShelf"
    ---竞拍下架模板（未过期）
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire"
    ---竞拍重新上架模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionReAddShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionReAddShelf"
    ---竞拍竞价模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBid = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionBid"
    ---竞拍购买模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBuy = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_AuctionBuy"
    ---竞拍钻石购买模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_DiamondOnePrice = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.AuctionUnion.UIAuctionPanel_AuctionItem_UnionAuction_DiamondOnePrice"
    ---元宝交易行购买模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeBuy = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradeBuy"
    ---元宝交易行上架模板
    ---*本版本废弃*
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeAddShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradeAddShelf"
    ---元宝交易行下架模板（已过期）
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradeRemoveShelf"
    ---元宝交易行下架模板(未到期)
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire"
    ---交易上架模板（元宝&钻石）‘
    ---*价格已修改*
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradAddShelfMix = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradAddShelfMix"
    ---元宝交易重新上架模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeReAddShelf = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_TradeReAddShelf"

    ---求购购买模板
    luaComponentTemplates.UIAuctionPanel_AuctionItem_BuyingBuy = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_BuyingBuy"

    ---帮会投票模板
    luaComponentTemplates.UIGuildelEctionsPanel_Vote = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIGuildelEctionsPanel_Vote"
    ---帮会仓库兑换模板
    luaComponentTemplates.UIGuildStoragePanel_Exchange = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIGuildStoragePanel_Exchange"

    ---商会积分商城购买面板
    luaComponentTemplates.UICommerceShopPanel_Conversion = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UICommerceShopPanel_Conversion"

    ---面对面交易购买面板
    luaComponentTemplates.UIFaceToFaceTrade_AuctionItem = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_AuctionItem_FaceToFaceTrade"

    ---熔炼行购买道具模板
    luaComponentTemplates.UIAuctionPanel_SmeltItem = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_SmeltItem"

    ---行会熔炼购买道具模板
    luaComponentTemplates.UIAuctionPanel_GuildSmeltWareItem = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.UIAuctionPanel_GuildSmeltWareItem"

    ---行会竞拍模板（钻石）
    luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_Diamond = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.AuctionUnion.UIAuctionPanel_AuctionItem_UnionAuction_Diamond"
    ---行会竞拍模板(元宝)
    luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_YuanBao = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.AuctionUnion.UIAuctionPanel_AuctionItem_UnionAuction_YuanBao"
    ---行会竞拍模板钻石
    luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.AuctionUnion.UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi"

    ---行会一口价(元宝）
    luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionItemTemplate.AuctionUnion.UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice"
    --endregion

    --region交易记录
    ---交易记录格子模板
    luaComponentTemplates.UIAuctionTransactionRecordPanel_GridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionTransactionRecordPanel.UIAuctionTransactionRecordPanel_GridTemplate"
    --endregion

    --region 熔炼行
    ---熔炼行购买格子模板
    luaComponentTemplates.UIAuctionSmeltPanel_BuyGridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionSmeltPanelTemplates.UIAuctionSmeltPanel_BuyGridTemplate"
    ---直接购买一个道具模板
    luaComponentTemplates.UIItemInfoPanel_AuctionSmelt_RightUpOperate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionSmeltPanelTemplates.UIItemInfoPanel_AuctionSmelt_RightUpOperate"
    --endregion

    --region 行会竞拍
    luaComponentTemplates.UIAuctionPanel_AuctionUnionGridTemplate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionUnionPanel.UIAuctionPanel_AuctionUnionGridTemplate"
    ---点击竞价右上角模板
    luaComponentTemplates.UIItemInfoPanel_AuctionUnionBid_RightUpOperate = require "luaRes.ui.template.UIAuctionPanelTemplates.UIAuctionPanel_AuctionUnionPanel.UIItemInfoPanel_AuctionUnionBid_RightUpOperate"


    --endregion

    --endregion

    --region 拍卖行物品价格控制器
    luaComponentTemplates.AuctionItemPartBase = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPartsBase"
    luaComponentTemplates.AuctionItemController = require "luaRes.ui.template.UIAuctionItemControls.UIAuctionItemController"

    luaComponentTemplates.AuctionItemPart_BigButton = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_BigButton"
    luaComponentTemplates.AuctionItemPart_CoinInput = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_CoinInput"
    luaComponentTemplates.AuctionItemPart_DoubleButtons = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_DoubleButtons"
    luaComponentTemplates.AuctionItemPart_DoubleTitleBtns = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_DoubleTitleBtns"
    luaComponentTemplates.AuctionItemPart_NumberAddMinus = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_NumberAddMinus"
    luaComponentTemplates.AuctionItemPart_Slider = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_Slider"
    luaComponentTemplates.AuctionItemPart_Toggle = require "luaRes.ui.template.UIAuctionItemControls.Parts.UIAuctionItemPart_Toggle"

    luaComponentTemplates.AuctionItemAddShelfController = require "luaRes.ui.template.UIAuctionItemControls.UIAuctionItemAddShelfController"
    luaComponentTemplates.AuctionItemReaddShelfController = require "luaRes.ui.template.UIAuctionItemControls.UIAuctionItemReaddShelfController"
    --endregion

    --region 灵兽试炼
    ---灵兽试炼任务模板
    luaComponentTemplates.UILsSchoolItemTemplate = require "luaRes.ui.template.UILsSchoolTemplates.UILsSchoolItemTemplate"
    ---灵兽试炼页签模板
    luaComponentTemplates.UILsSchoolTitleTemplate = require "luaRes.ui.template.UILsSchoolTemplates.UILsSchoolTitleTemplate"
    ---灵兽试炼奖励展示模板
    luaComponentTemplates.UILsSchoolRewardViewTemplate = require "luaRes.ui.template.UILsSchoolTemplates.UILsSchoolRewardViewTemplate"
    --endregion

    --region 印记格子模板
    luaComponentTemplates.UISignetPanel_ItemTemplates = require "luaRes.ui.template.UISignetPanelTemplates.UISignetPanel_ItemTemplates"
    --endregion

    --region 小地图
    ---小地图传送按钮模板
    luaComponentTemplates.UIMapPanel_DeliverBtnTemplates = require "luaRes.ui.template.UIMapPanelTemplates.UIMapPanelDeliverBtn"
    --endregion

    --region 充值
    luaComponentTemplates.UIRechargeViewTemplate = require "luaRes.ui.template.UIRechargePanelTemplate.UIRechargeViewTemplate"
    luaComponentTemplates.UIRechargeUnitTemplate = require "luaRes.ui.template.UIRechargePanelTemplate.UIRechargeUnitTemplate"
    luaComponentTemplates.UIContinueRechargeUnitTemplate = require "luaRes.ui.template.UIRechargePanelTemplate.UIContinueRechargeUnitTemplate"
    luaComponentTemplates.UINormalRechargeUnitTemplate = require "luaRes.ui.template.UIRechargePanelTemplate.UINormalRechargeUnitTemplate"

    ---充值奖励格子模板
    luaComponentTemplates.UIRechargeRewardTemplate = require "luaRes.ui.template.UIRechargePanelTemplate.UIRechargeRewardTemplate"
    ---充值面板--特惠礼包
    luaComponentTemplates.UIRechargeMain_PreferenceGift = require "luaRes.ui.template.UIRechargeMainPanelTemplates.UIRechargeMain_PreferenceGift"
    ---充值面板--潜能投资
    luaComponentTemplates.UIRechargeMain_PotentialInvest = require "luaRes.ui.template.UIRechargeMainPanelTemplates.UIRechargeMain_PotentialInvest"
    --endregion

    --region 闯天关
    ---闯天关单个信息模板
    luaComponentTemplates.UICrawlTowerInfoTemplate = require "luaRes.ui.template.UICrawlTowerTemplates.UICrawlTowerInfoTemplate"
    ---闯天关左侧面板单个星级信息模板
    luaComponentTemplates.UICrawlTowerLeftPanelStarInfoTemplate = require "luaRes.ui.template.UICrawlTowerTemplates.UICrawlTowerLeftPanelStarInfoTemplate"
    ---闯天关极品奖励面板
    luaComponentTemplates.UICrawlTowerBestRewardTemplate = require "luaRes.ui.template.UICrawlTowerTemplates.UICrawlTowerBestRewardTemplate"
    --endregion

    --region 页浏览组件
    luaComponentTemplates.UIPageViewTemplate = require "luaRes.ui.template.UIPageViewTemplate.UIPageViewTemplate"
    luaComponentTemplates.UIPageUnitTemplate = require "luaRes.ui.template.UIPageViewTemplate.UIPageUnitTemplate"
    --endregion

    --region 语音
    luaComponentTemplates.UIVoice_Mgr = require "luaRes.ui.template.UIVoiceTemplates.UIVoice_Mgr"
    luaComponentTemplates.UIVoiceBaseTemplate = require "luaRes.ui.template.UIVoiceTemplates.UIVoiceBaseTemplate"
    --endregion

    --region 帮会
    --region 帮会仇人模板
    luaComponentTemplates.UIGuildEnemytemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildInfoPanel.UIGuildEnemyTemplate"
    --endregion

    --region 帮会信息
    ---帮会聊天模板
    luaComponentTemplates.UIGuildChatWindowTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildInfoPanel.UIGuildChatWindowTemplate"
    ---帮会语音模板 继承 luaComponentTemplates.UIVoiceBaseTemplate
    luaComponentTemplates.UIGuildVoiceBaseTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildInfoPanel.UIGuildVoiceBaseTemplate"
    --endregion

    --region 帮会仓库
    --- 帮会背包交互控制
    luaComponentTemplates. UIGuildBagPanel_Interaction = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBagPanel.UIGuildBagPanel_Interaction"
    ---帮会背包格子模板
    luaComponentTemplates.UIGuildBagPanel_BagGridTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBagPanel.UIGuildBagPanel_BagGridTemplate"
    --- 帮会仓库格子模板
    luaComponentTemplates. UIGuildBagPanel_StorageGridTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBagPanel.UIGuildBagPanel_StorageGridTemplate"
    ---物品信息界面捐献按钮信息
    luaComponentTemplates.UIGuildBagPane_UIItemInfoRightUpOperate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBagPanel.UIGuildBagPane_UIItemInfoRightUpOperate"
    --endregion

    --region 帮会竞选
    ---帮会竞选格子模板
    luaComponentTemplates.UIGuildelEctionsGridTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildelEctionsGridTemplate"
    --endregion

    --region 帮会福利
    luaComponentTemplates.UIGuildBenefitsPanel_SpoilsTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIGuildBenefitsPanel_SpoilsTemplate"
    luaComponentTemplates.UIGuildBenefitsPanel_SpoilsGridTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIGuildBenefitsPanel_SpoilsGridTemplate"
    ---帮会红包模板（方便重写）
    luaComponentTemplates.UIGuildSendRedPanelTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIGuildSendRedPanelTemplate"
    ---帮会红包券模板
    luaComponentTemplates.UIGuildSendRedPackCouponPanelTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIGuildSendRedPackCouponPanelTemplate"
    ---个人红包券模板
    luaComponentTemplates.UIPersonSendRedPackCouponPanelTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIPersonSendRedPackCouponPanelTemplate"
    ---帮会贡献格子模板
    luaComponentTemplates.UIGuildBenefitsPanel_ActiveDetailsGridTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIGuildBenefitsPanel_ActiveDetailsGridTemplate"
    ---个人红包模板
    luaComponentTemplates.UIPersonSendDiamondRedPackTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildBenefitsPanel.UIPersonSendDiamondRedPackTemplate"
    --endregion

    --region帮会列表
    luaComponentTemplates.UIGuildListPanel_GirdTemplate = require "luaRes.ui.template.UIGuildPanelTemplates.UIGuildListPanel.UIGuildListPanel_GirdTemplate"
    --endregion

    --region 帮会熔炼
    ---帮会熔炼背包格子交互
    luaComponentTemplates.UIGuildSmeltBagPanel_Interaction = require "luaRes.ui.template.UIGuildSmeltPanelTemplates.Bag.UIGuildSmeltBagPanel_Interaction"
    ---物品信息界面熔炼按钮信息
    luaComponentTemplates.UIGuildSmeltBagPane_UIItemInfoRightUpOperate = require "luaRes.ui.template.UIGuildSmeltPanelTemplates.Bag.UIGuildSmeltBagPane_UIItemInfoRightUpOperate"
    ---帮会熔炼仓库格子模板
    luaComponentTemplates.UIGuildSmeltBagPanel_StorageGridTemplate = require "luaRes.ui.template.UIGuildSmeltPanelTemplates.Grid.UIGuildSmeltBagPanel_StorageGridTemplate"
    --endregion
    --endregion

    --region 排行榜
    ---页签
    luaComponentTemplates.UIBookMarkTemplate = require "luaRes.ui.template.UIRankTemplates.UIBookMarkTemplate"
    ---自己排行信息
    luaComponentTemplates.UIOurRankTemplate = require "luaRes.ui.template.UIRankTemplates.UIOurRankTemplate"
    ---自己排行信息（无奖励）
    luaComponentTemplates.UIOurRankRewardTemplate = require "luaRes.ui.template.UIRankTemplates.UIOurRankRewardTemplate"
    ---单个排行
    luaComponentTemplates.UIRankItemTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankItemTemplate"
    ---模型模板
    luaComponentTemplates.UIRankModelTemplate = require "luaRes.ui.template.UIRankTemplates.UIRankModelTemplate"
    --endregion

    --region 送花
    luaComponentTemplates.UISendFlowerPanelGridTemplate = require "luaRes.ui.template.UISendFlowerPanelTemplates.UISendFlowerPanelGridTemplate"
    --endregion

    --region 设置
    ---设置面板部分基础功能
    luaComponentTemplates.UIConfigPanel_PartBasic = require "luaRes.ui.template.UIConfigTemplates.Base.UIConfigPanel_PartBasic"
    ---基础面板
    luaComponentTemplates.UIConfigPanel_Base = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Base"
    ---反馈面板
    luaComponentTemplates.UIConfigPanel_Feedback = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Feedback"
    ---拾取面板
    luaComponentTemplates.UIConfigPanel_Pickup = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Pickup"
    ---拾取目录面板
    luaComponentTemplates.UIConfigPanel_Pickup_Menu = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Pickup_Menu"
    ---显示面板
    luaComponentTemplates.UIConfigPanel_Show = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Show"
    ---技能面板
    luaComponentTemplates.UIConfigPanel_Skill = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_Skill"
    --region 技能设置面板
    luaComponentTemplates.UISkillConfigPanel_Base = require "luaRes.ui.template.UIConfigTemplates.ConfigSkillTemplate.UISkillConfigPanel_Base"
    luaComponentTemplates.UISkillConfigPanel_Model1 = require "luaRes.ui.template.UIConfigTemplates.ConfigSkillTemplate.UISkillConfigPanel_Model1"
    luaComponentTemplates.UISkillConfigPanel_Model2 = require "luaRes.ui.template.UIConfigTemplates.ConfigSkillTemplate.UISkillConfigPanel_Model2"
    luaComponentTemplates.UISkillPanel_ConfigGridTemplate = require "luaRes.ui.template.UIConfigTemplates.ConfigSkillTemplate.UISkillPanel_ConfigGridTemplate"
    --endregion
    ---保护面板
    luaComponentTemplates.UIConfigPanel_ProtectPanel = require "luaRes.ui.template.UIConfigTemplates.Main.UIConfigPanel_ProtectPanel"
    --endregion

    --region 日常Npc买卖
    ---购买面板模板
    luaComponentTemplates.UISaleOrePanel_BuyPanelTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_BuyPanelTemplate"
    ---出售面板模板
    luaComponentTemplates.UISaleOrePanel_SalePanelTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_SalePanelTemplate"
    ---买卖通用格子模板
    luaComponentTemplates.UISaleOrePanel_UnitTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_UnitTemplate"
    ---购买模板
    luaComponentTemplates.UISaleOrePanel_BuyItemTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_BuyItemTemplate"
    ---回购模板
    luaComponentTemplates.UISaleOrePanel_SaleItemTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_SaleItemTemplate"
    ---帮会仓库背包模板
    luaComponentTemplates.UISaleOrePanel_GuildBagPanelInteractionTemplate = require "luaRes.ui.template.UISaleOrePanelTemplates.UISaleOrePanel_GuildBagPanelInteractionTemplate"
    --endregion

    --region 属性比对模板
    luaComponentTemplates.UIAttributeCompareViewTemplate = require "luaRes.ui.template.UIAttributeCompareTemplates.UIAttributeCompareViewTemplate"
    luaComponentTemplates.UIAttributeCompareUnitTemplate = require "luaRes.ui.template.UIAttributeCompareTemplates.UIAttributeCompareUnitTemplate"
    --endregion

    --region 外观
    luaComponentTemplates.UIAppearancePanelInfoTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelInfoTemplate"
    luaComponentTemplates.UIAppearancePanelPagesCtrlTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelPagesCtrlTemplate"
    luaComponentTemplates.UIAppearancePanelGridTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelGridTemplate"
    luaComponentTemplates.UIAppearancePanelTitleTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelTitleTemplate"
    --外观 称谓 视图
    luaComponentTemplates.UIAppellationViewTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelAppellationViewTemplate"
    --外观 称谓 单元
    luaComponentTemplates.UIAppellationUnitTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelAppellationUnitTemplate"
    --外观 称谓 信息
    luaComponentTemplates.UIAppellationInfoTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelAppellationInfoTemplate"
    ---外观 称号 信息
    luaComponentTemplates.UIAppearance_TitleInfoTemplate = require "luaRes.ui.template.UIAppearancePanelTemplates.UIAppearancePanelTitleInfoTemplate"
    --endregion

    --region 门票(通行证)
    luaComponentTemplates.UIUsePassCheckViewTemplate = require "luaRes.ui.template.UIUsePassCheckPanelTemplates.UIUsePassCheckViewTemplate";
    luaComponentTemplates.UIUsePassCheckUnitTemplate = require "luaRes.ui.template.UIUsePassCheckPanelTemplates.UIUsePassCheckUnitTemplate";
    --endregion

    --region 仓库
    ---仓库重写背包点击灵兽装备（存入）
    luaComponentTemplates.UIWarehousePanel_UIItemInfoServantEquipMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_UIItemInfoServantEquipMainPart"
    ---仓库重写背包点击灵兽装备（取出）
    luaComponentTemplates.UIWarehousePanel_TakeOutServantEquipMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_TakeOutServantEquipMainPart"
    ---仓库重写背包点击灵兽肉身（存入）
    luaComponentTemplates.UIWarehousePanel_UIItemInfoServantBodyMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_UIItemInfoServantBodyMainPart"
    ---仓库重写背包点击灵兽肉身（取出）
    luaComponentTemplates.UIWarehousePanel_TakeOutServantBodyMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_TakeOutServantBodyMainPart"
    ---仓库重写背包点击普通装备（存入）
    luaComponentTemplates.UIWarehousePanel_UIItemInfoMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_UIItemInfoMainPart"
    ---仓库重写背包点击普通装备(取出)
    luaComponentTemplates.UIWarehousePanel_TakeOutUIItemInfoMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_TakeOutUIItemInfoMainPart"
    ---仓库重写背包点击灵兽蛋（存入）
    luaComponentTemplates.UIWarehousePanel_ServantEggMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_ServantEggMainPart"
    ---仓库重写背包点击灵兽蛋（取出）
    luaComponentTemplates.UIWarehousePanel_TakeOutServantEggMainPart = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_TakeOutServantEggMainPart"
    ---仓库重写背包点击灵兽装备右上按钮（存入）
    luaComponentTemplates.UIWarehousePanel_UIItemInfoServantEquipRightUpOperate = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_UIItemInfoServantEquipRightUpOperate"
    ---仓库重写背包点击灵兽装备右上按钮（取出）
    luaComponentTemplates.UIWarehousePanel_TakeOutServantEquipRightUpOperate = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_TakeOutServantEquipRightUpOperate"
    ---打捆格子模板
    luaComponentTemplates.UIWarehouseBundleUpPanel_GridTemplate = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehouseBundleUpPanel_GridTemplate"
    ---仓库页模板
    luaComponentTemplates.UIWareHousePanel_PageControllerTemplate = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_PageController"
    ---仓库交互
    luaComponentTemplates.UIWareHousePanel_Interaction = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_Interaction"
    ---仓库格子
    luaComponentTemplates.UIWareHousePanel_Grid = require "luaRes.ui.template.UIWarehouseTemplates.UIWarehousePanel_Grid"
    --endregion

    --region 物品信息无按钮模板（避免继承模板失败放在最后）
    ---物品信息界面属性（隐藏所有按钮，仅显示信息）普通道具
    luaComponentTemplates.UIItemInfoPanel_HideButtons_Normal = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_HideButtons_Normal"
    ---物品信息界面属性（隐藏所有按钮，仅显示信息）灵兽肉身
    luaComponentTemplates.UIItemInfoPanel_HideButtons_ServantBody = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_HideButtons_ServantBody"
    ---物品信息界面属性（隐藏所有按钮，仅显示信息）灵兽装备
    luaComponentTemplates.UIItemInfoPanel_HideButtons_ServantEquip = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_HideButtons_ServantEquip"
    ---物品信息界面属性（隐藏所有按钮，仅显示信息）灵兽蛋
    luaComponentTemplates.UIItemInfoPanel_HideButtons_ServantEgg = require "luaRes.ui.template.UIItemInfoPanelTemplates.UIItemInfoPanel_HideButtons_ServantEgg"
    --endregion

    --region 结义模板
    ---断义面板 断义单元模板
    luaComponentTemplates.UIBrotherSeverUnitTemplate = require "luaRes.ui.template.UIBrotherPanelTemplates.UIBrotherSeverUnitTemplate"
    ---结义面板 结义单元模板
    luaComponentTemplates.UIBrotherSwornUnitTemplate = require "luaRes.ui.template.UIBrotherPanelTemplates.UIBrotherSwornUnitTemplate"
    --endregion

    --region 主场景提示
    ---主场景提示基类
    luaComponentTemplates.UIBasicHint = require "luaRes.ui.template.UIMainHintTemplates.UIBasicHint"
    ---主场景更好的背包物品提示(配置等级前)
    luaComponentTemplates.UIMainHint_BetterBagItem = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_BetterBagItem"
    ---主场景回收背包提示
    luaComponentTemplates.UIMainHint_RecycleBagItemTips = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_RecycleBagItemTips"
    ---主场景技能可学提示
    luaComponentTemplates.UIMainHint_SkillLearningAvailableTips = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_SkillLearningAvailableTips"
    ---主场景更好的背包物品提示（高等级）
    luaComponentTemplates.UIMainHint_BetterBagItem_HighLv = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_BetterBagItem_HighLv"
    ---主场景大聚灵珠推荐购买提示
    luaComponentTemplates.UIMainHint_BigJuLingZhuRecommendBug = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_BigJuLingZhuRecommendBug"
    ---宝箱使用提示
    luaComponentTemplates.UIMainHint_SpecialBoxUseHint = require "luaRes.ui.template.UIMainHintTemplates.UIMainHint_SpecialBoxUseHint"
    --endregion

    --region 百晓生模板
    ---悬赏面板视图模板
    luaComponentTemplates.UIArrestPanelViewTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPanelViewTemplate"
    ---仇人面板视图模板
    luaComponentTemplates.UIHatredPanelViewTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIHatredPanelViewTemplate"
    ---仇人面板 仇人单元模板
    luaComponentTemplates.UIHatredPlayerUnitTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIHatredPlayerUnitTemplate"
    ---悬赏面板 个人悬赏单元模板
    luaComponentTemplates.UIArrestPlayerPersonalUnitTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPlayerPersonalUnitTemplate"
    ---悬赏面板 全服悬赏单元模板
    luaComponentTemplates.UIArrestPlayerWordUnitTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPlayerWordUnitTemplate"
    ---悬赏按钮集合模板
    luaComponentTemplates.UIArrestAllBtnTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPanelAllPopUpBtnTemplate"
    ---悬赏通用单元模板
    luaComponentTemplates.UIArrestUniversalUnitTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPanelUniversalUnitTemplate"
    ---发布悬赏搜索单元模板
    luaComponentTemplates.UIArrestPromptUnitTemplate = require "luaRes.ui.template.UIArrestPanelTemplates.UIArrestPromptUnitTemplate"
    --endregion

    --region 挖矿面板
    ---挖矿格子面板
    luaComponentTemplates.UIMiningPanelGridTemplate = require "luaRes.ui.template.UIMiningPanel.UIMiningPanelGridTemplate"
    --endregion

    --region 摊位模板
    luaComponentTemplates.UIStallPanel_GridTemplate = require "luaRes.ui.template.UIStallPanelTemplates.UIStallPanel_GridTemplate"
    luaComponentTemplates.UIAuctionItemPanel_StallPanel = require "luaRes.ui.template.UIStallPanelTemplates.UIAuctionItemPanel_StallPanel"
    luaComponentTemplates.UIItemInfoPanel_Stall_RightUpUperate = require "luaRes.ui.template.UIStallPanelTemplates.UIItemInfoPanel_Stall_RightUpUperate"
    luaComponentTemplates.UIStallPanel_ShareGridTemplate = require "luaRes.ui.template.UIStallPanelTemplates.UIStallPanel_ShareGridTemplate"
    luaComponentTemplates.UIAuctionItemPanel_ShareStallPanel = require "luaRes.ui.template.UIStallPanelTemplates.UIAuctionItemPanel_ShareStallPanel"
    --endregion

    --region 元素模板
    luaComponentTemplates.UIElementPanelTemplate = require "luaRes.ui.template.UIElementTemplates.UIElementPanelTemplate"
    luaComponentTemplates.UIElement_StoneListTemplate = require "luaRes.ui.template.UIElementTemplates.UIElement_StoneListTemplate"
    luaComponentTemplates.UIElement_StoneListGrid = require "luaRes.ui.template.UIElementTemplates.UIElement_StoneListGrid"
    --endregion
    --region 镶嵌（勋章封印）模板
    ---镶嵌位
    luaComponentTemplates.UIMosaicUnitTemplate = require "luaRes.ui.template.UIMedalInlayPanelTemplates.UIMedalInlayPanelMosaicUnitTemplate"
    ---消耗位
    luaComponentTemplates.UIConsumableUnitTemplate = require "luaRes.ui.template.UIMedalInlayPanelTemplates.UIMedalInlayPanelConsumablesUnitTemplate"

    --endregion

    --region 赎回模板
    luaComponentTemplates.UIArbitratorPanelTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Base.UIArbitratorPanelTemplate"
    luaComponentTemplates.UIArbitratorPanel_BaseGridTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Base.UIArbitratorPanel_BaseGridTemplate"
    luaComponentTemplates.UIArbitratorPanel_DropPanelTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Main.UIArbitratorPanel_DropPanelTemplate"
    luaComponentTemplates.UIArbitratorPanel_PickPanelTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Main.UIArbitratorPanel_PickPanelTemplate"
    luaComponentTemplates.UIArbitratorPanel_ItemGrid = require "luaRes.ui.template.UIArbitratorPanelTemplates.Grid.UIArbitratorPanel_ItemGrid"
    luaComponentTemplates.UIArbitratorPanel_DropGridTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Grid.UIArbitratorPanel_DropGridTemplate"
    luaComponentTemplates.UIArbitratorPanel_PickGridTemplate = require "luaRes.ui.template.UIArbitratorPanelTemplates.Grid.UIArbitratorPanel_PickGridTemplate"
    --endregion

    --region 历法
    luaComponentTemplates.UICalendarViewTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UICalendarViewTemplate";
    luaComponentTemplates.UICalendarUnitTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UICalendarUnitTemplate";
    luaComponentTemplates.UICalendarDateViewTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UICalendarDateViewTemplate";
    luaComponentTemplates.UICalendarDateUnitTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UICalendarDateUnitTemplate";
    ---历法活动开启提示
    luaComponentTemplates.UICalendarTipsTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UICalendarTipsTemplate";

    ---历法活动规则
    luaComponentTemplates.UIActivitiesDesViewTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UIActivitiesDesTemplate.UIActivitiesDesViewTemplate";
    luaComponentTemplates.UIActivitiesDesUnitTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UIActivitiesDesTemplate.UIActivitiesDesUnitTemplate";
    luaComponentTemplates.UIActivitiesDesContentUnitTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UIActivitiesDesTemplate.UIActivitiesDesContentUnitTemplate";
    luaComponentTemplates.UIActivitiesShaBaKDesViewTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UIActivitiesDesTemplate.UIActivitiesShaBaKDesViewTemplate";
    luaComponentTemplates.UIActivitiesDesShaBaKAwardsShowUnitTemplate = require "luaRes.ui.template.UICalendarPanelTemplates.UIActivitiesDesTemplate.UIActivitiesDesShaBaKAwardsShowUnitTemplate";
    --endregion

    --region 婚戒面板界面
    luaComponentTemplates.UIWeddingRingPanelTemplates = require "luaRes.ui.template.UIWeddingRingTemplates.UIWeddingRingPanelTemplates";
    luaComponentTemplates.UIWeddingMoreInfoPanelTemplates = require "luaRes.ui.template.UIWeddingRingTemplates.UIWeddingMoreInfoPanelTemplates";
    --endregion

    --region 商会
    luaComponentTemplates.UICommercePanel_Base = require "luaRes.ui.template.UICommercePanel.Base.UICommercePanel_Base";
    luaComponentTemplates.UICommercePanel_MengZhong = require "luaRes.ui.template.UICommercePanel.Main.UICommercePanel_MengZhong";
    luaComponentTemplates.UICommercePanel_BiQi = require "luaRes.ui.template.UICommercePanel.Main.UICommercePanel_BiQi";
    luaComponentTemplates.UICommercePanel_RithBtn = require "luaRes.ui.template.UICommercePanel.Main.UICommercePanel_RithBtn";

    luaComponentTemplates.UICommerceRewardDesUnitTemplate = require "luaRes.ui.template.UICommercePanel.UICommerceRewardDesUnitTemplate"
    luaComponentTemplates.UICommercePanel_AdministratorDescription = require "luaRes.ui.template.UICommercePanel.UICommercePanel_Administrator.UICommercePanel_AdministratorDescription"
    --endregion

    --region 保卫国王
    ---排行榜视图一
    luaComponentTemplates.UIDefKingRankFirstView = require "luaRes.ui.template.UIDefendKingRankTemplates.UIDefKingRankFirstView";
    ---排行榜视图二
    luaComponentTemplates.UIDefKingRankSecondView = require "luaRes.ui.template.UIDefendKingRankTemplates.UIDefKingRankSecondView";
    ---排行榜单元一
    luaComponentTemplates.UIDefKingRankFirstUnit = require "luaRes.ui.template.UIDefendKingRankTemplates.UIDefKingRankFirstUnit";
    ---排行榜单元二
    luaComponentTemplates.UIDefKingRankSecondUnit = require "luaRes.ui.template.UIDefendKingRankTemplates.UIDefKingRankSecondUnit";
    --endregion

    --region 幻境迷宫
    luaComponentTemplates.UIUnrealMazeDeliverChoose = require "luaRes.ui.template.UnrealMazeTemplates.UIUnrealMazeDeliverChooseTemplate";
    --endregion

    --region 获取途径
    luaComponentTemplates.UIWayGetAndBuyViewTemplate = require "luaRes.ui.template.UIWayGetAndBuyViewTemplate.UIWayGetAndBuyViewTemplate";
    luaComponentTemplates.UIWayGetUnitTemplate = require "luaRes.ui.template.UIWayGetAndBuyViewTemplate.UIWayGetUnitTemplate";
    luaComponentTemplates.UIWayGetGiftUnitTemplate = require "luaRes.ui.template.UIWayGetAndBuyViewTemplate.UIWayGetGiftUnitTemplate"
    luaComponentTemplates.UIWayGetQuickAuctionBuyTemplate = require "luaRes.ui.template.UIWayGetAndBuyViewTemplate.UIWayGetQuickAuctionBuyTemplate"
    ---增加boss击杀次数模板
    luaComponentTemplates.UIWayGetAddBossTimeTemplate = require "luaRes.ui.template.UIWayGetAndBuyViewTemplate.UIWayGetAddBossTimeTemplate"
    --endregion

    --region 矿工雇佣
    luaComponentTemplates.UIHireMiners_MinerTemplate = require "luaRes.ui.template.UIHireMinersPanelTemplates.UIHireMiners_MinerTemplate";
    --endregion

    --region 沙巴克
    luaComponentTemplates.UICityWarMiDaoSkillDesUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.MiDaoFaZhen.UICityWarMiDaoSkillDesUnitTemplate";
    luaComponentTemplates.UICityWarMiDaoFaZhenTipsUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.MiDaoFaZhen.UICityWarMiDaoFaZhenTipsUnitTemplate";
    ---商店传送员传送单元
    luaComponentTemplates.UIShaBaKShopDeliveryUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.NPC.UIShaBaKShopDeliveryUnitTemplate";
    ---神秘掮客
    luaComponentTemplates.UICityWarMysterySpiesUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.NPC.UICityWarMysterySpiesUnitTemplate";

    ---沙城争霸排行榜视图
    luaComponentTemplates.UICityWarRankingViewTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarRankingViewTemplate";
    luaComponentTemplates.UICityWarRankingUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarRankingUnitTemplate";
    luaComponentTemplates.UICityWarLossRankingViewTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarLossRankingViewTemplate";
    luaComponentTemplates.UICityWarLossRankingUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarLossRankingUnitTemplate";
    luaComponentTemplates.UICityWarSelfRankingUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarSelfRankingUnitTemplate";

    ---沙巴克积分奖励单元模板
    luaComponentTemplates.UICityWarRankRewardTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarRankRewardTemplate";
    ---捐沙排行奖励单元
    luaComponentTemplates.UICityWarContributeRankRewardUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarContributeRankRewardUnitTemplate";
    ---捐沙排行单元
    luaComponentTemplates.UICityWarContributeRankUnitTemplate = require "luaRes.ui.template.UICityWarTemplates.UICityWarContributeRankUnitTemplate";
    --endregion

    --region 战利品
    ---战利品玩家列表
    luaComponentTemplates.UIGuildSendBenefitsPanel_Base = require "luaRes.ui.template.UIGuildSendBenefitsPanelTemplates.Base.UIGuildSendBenefitsPanel_Base"
    luaComponentTemplates.UIGuildSendBenefitsPanel_OnePlayerList = require "luaRes.ui.template.UIGuildSendBenefitsPanelTemplates.Main.UIGuildSendBenefitsPanel_OnePlayerList"
    luaComponentTemplates.UIGuildSendBenefitsPanel_AllPlayerList = require "luaRes.ui.template.UIGuildSendBenefitsPanelTemplates.Main.UIGuildSendBenefitsPanel_AllPlayerList"
    luaComponentTemplates.UIGuildSendBenefitsPanel_Grid = require "luaRes.ui.template.UIGuildSendBenefitsPanelTemplates.Main.UIGuildSendBenefitsPanel_Grid"
    --endregion

    --region 武道会
    ---活动信息面板
    luaComponentTemplates.UIBuDouKaiPanel_Base = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Base.UIBuDouKaiPanel_Base"
    luaComponentTemplates.UIBuDouKaiPanel_Wait = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_Wait"
    luaComponentTemplates.UIBuDouKaiPanel_Trials = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_Trials"
    luaComponentTemplates.UIBuDouKaiPanel_FristRest = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_FristRest"
    luaComponentTemplates.UIBuDouKaiPanel_Promotion = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_Promotion"
    luaComponentTemplates.UIBuDouKaiPanel_SecondRest = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_SecondRest"
    luaComponentTemplates.UIBuDouKaiPanel_ContentheGemony = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_ContentheGemony"
    luaComponentTemplates.UIBuDouKaiPanel_FinalOver = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.Main.UIBuDouKaiPanel_FinalOver"

    --region 押注师
    luaComponentTemplates.UIBettingDivisionUnitTemplate = require "luaRes.ui.template.UIBuDouKaiPanelTemplates.UIBettingDivisionUnitTemplate"
    --endregion
    --endregion

    --region 圣域空间
    luaComponentTemplates.UISanctuaryPanel_DuplicateList = require "luaRes.ui.template.UISanctuaryPanelTemplates.UISanctuaryPanel_DuplicateList"
    luaComponentTemplates.UISanctuaryPanel_Grid = require "luaRes.ui.template.UISanctuaryPanelTemplates.UISanctuaryPanel_Grid"
    --endregion

    --region 变强秘籍
    luaComponentTemplates.UISecretBookPageTemplate = require "luaRes.ui.template.UISecretBookPageTemplates.UISecretBookPageTemplate"
    luaComponentTemplates.UISecretBookContentTemplate = require "luaRes.ui.template.UISecretBookPageTemplates.UISecretBookContentTemplate"
    luaComponentTemplates.UISecretBookCatalogTemplate = require "luaRes.ui.template.UISecretBookPageTemplates.UISecretBookCatalogTemplate"

    --endregion

    --region 个人押镖
    luaComponentTemplates.IndividEscortList2Template = require "luaRes.ui.template.UIIndividEscortTemplate.Panel.IndividEscortList2Template"
    luaComponentTemplates.IndividEscortGrid_Base = require "luaRes.ui.template.UIIndividEscortTemplate.Grid.Base.IndividEscortGrid_Base"
    luaComponentTemplates.IndividEscortGrid_WaitDrive = require "luaRes.ui.template.UIIndividEscortTemplate.Grid.Main.IndividEscortGrid_WaitDrive"
    luaComponentTemplates.IndividEscortGrid_WaitDrive2 = require "luaRes.ui.template.UIIndividEscortTemplate.Grid.Main.IndividEscortGrid_WaitDrive2"
    luaComponentTemplates.IndividEscortGrid_Driving = require "luaRes.ui.template.UIIndividEscortTemplate.Grid.Main.IndividEscortGrid_Driving"
    luaComponentTemplates.IndividEscortGrid_EndDrive = require "luaRes.ui.template.UIIndividEscortTemplate.Grid.Main.IndividEscortGrid_EndDrive"
    --endregion

    --region 个人押镖选择镖车
    luaComponentTemplates.UIIndividEscortChoosePanel_Base = require "luaRes.ui.template.UIIndividEscortChoosePanelTemplates.Base.UIIndividEscortChoosePanel_Base"
    luaComponentTemplates.UIIndividEscortChoosePanel_PlayerExp = require "luaRes.ui.template.UIIndividEscortChoosePanelTemplates.Main.UIIndividEscortChoosePanel_PlayerExp"
    luaComponentTemplates.UIIndividEscortChoosePanel_ServantExp = require "luaRes.ui.template.UIIndividEscortChoosePanelTemplates.Main.UIIndividEscortChoosePanel_ServantExp"
    luaComponentTemplates.UIIndividEscortChoosePanel_Ingot = require "luaRes.ui.template.UIIndividEscortChoosePanelTemplates.Main.UIIndividEscortChoosePanel_Ingot"
    luaComponentTemplates.UIIndividEscortChoosePanel_DartCarGrid = require "luaRes.ui.template.UIIndividEscortChoosePanelTemplates.Grid.UIIndividEscortChoosePanel_DartCarGrid"
    --endregion

    --region 物品页浏览

    luaComponentTemplates.UIItemPageViewTemplate = require "luaRes.ui.template.UIItemPageViewTemplates.UIItemPageViewTemplate";
    luaComponentTemplates.UIItemPageUnitTemplate = require "luaRes.ui.template.UIItemPageViewTemplates.UIItemPageUnitTemplate";
    luaComponentTemplates.UIItemPageUnitToItemViewVoTemplate = require "luaRes.ui.template.UIItemPageViewTemplates.UIItemPageUnitToItemViewVoTemplate";
    --endregion

    --region 人物信息预览
    luaComponentTemplates.UIGuildTipsUnitTemplate = require "luaRes.ui.template.UIGuildTipsPanelTemplates.UIGuildTipsUnitTemplate"

    --endregion

    --region 聊天
    luaComponentTemplates.UIChatPanel_Setting = require "luaRes.ui.template.UIChatPanelTemplates.UIChatPanel_Setting"
    ---聊天背包界面模板
    luaComponentTemplates.UIChatPanel_BagPanel = require "luaRes.ui.template.UIChatPanelTemplates.UIChatPanel_BagPanel"
    ---聊天背包单个格子模板
    luaComponentTemplates.UIChatPanel_BagPanelGridTemplate = require "luaRes.ui.template.UIChatPanelTemplates.UIChatPanel_BagPanelGridTemplate"
    ---聊天背包交互模板
    luaComponentTemplates.UIChatPanel_BagPanel_Interaction = require "luaRes.ui.template.UIChatPanelTemplates.UIChatPanel_BagPanel_Interaction"
    ---帮会聊天背包单个格子模板
    luaComponentTemplates.UIGuildInfoPanel_ChatPanel_BagPanel = require "luaRes.ui.template.UIChatPanelTemplates.UIGuildInfoPanel_ChatPanel_BagPanel"
    ---帮会聊天背包交互模板
    luaComponentTemplates.UIGuildInfoPanel_ChatPanel_BagPanel_Interaction = require "luaRes.ui.template.UIChatPanelTemplates.UIGuildInfoPanel_ChatPanel_BagPanel_Interaction"
    ---朋友圈背包
    luaComponentTemplates.UIFriendCircle_BagPanel = require "luaRes.ui.template.UIChatPanelTemplates.UIFriendCircle_BagPanel"
    ---朋友圈背包交互
    luaComponentTemplates.UIFriendCircle_BagPanel_Interaction = require "luaRes.ui.template.UIChatPanelTemplates.UIFriendCircle_BagPanel_Interaction"
    --endregion

    --region 闪烁提示
    luaComponentTemplates.UIFlashTipsViewTemplate = require "luaRes.ui.template.UIMainChatPanel_FlashTemplates.UIFlashTipsViewTemplate"
    luaComponentTemplates.UIFlashTipsUnitTemplate = require "luaRes.ui.template.UIMainChatPanel_FlashTemplates.UIFlashTipsUnitTemplate"
    --endregion

    --region 活动大使
    luaComponentTemplates.UIActivitiesManViewTemplate = require "luaRes.ui.template.UIActivtiesManPanelTemplates.UIActivitiesManViewTemplate"
    luaComponentTemplates.UIActivitiesManUnitTemplate = require "luaRes.ui.template.UIActivtiesManPanelTemplates.UIActivitiesManUnitTemplate"
    --endregion

    --region 等级奖励
    luaComponentTemplates.UILvPackPanel_LeftIconTemplate = require "luaRes.ui.template.UILvPackPanelTemplates.UILvPackPanel_LeftIconTemplate"
    --endregion

    --region 面对面交易
    luaComponentTemplates.UIFaceToFaceDeal_BagItemPartRightUpOperate = require "luaRes.ui.template.UIFaceToFaceDealTemplates.UIFaceToFaceDeal_BagItemPartRightUpOperate"
    luaComponentTemplates.UIFaceToFaceDealTemplates_TrdaeItemInfo = require "luaRes.ui.template.UIFaceToFaceDealTemplates.UIFaceToFaceDealTemplates_TrdaeItemInfo"
    luaComponentTemplates.UIFaceToFaceDeal_TrdaeItemPartRightUpOperate = require "luaRes.ui.template.UIFaceToFaceDealTemplates.UIFaceToFaceDeal_TrdaeItemPartRightUpOperate"


    --endregion

    --region 临时物品使用栏
    luaComponentTemplates.UISnapItemViewTemplate = require "luaRes.ui.template.UIMainSkillPanelTemplates.UISnapItemViewTemplate"
    luaComponentTemplates.UISnapItemUnitTemplate = require "luaRes.ui.template.UIMainSkillPanelTemplates.UISnapItemUnitTemplate"
    --endregion

    --region 行会活动
    luaComponentTemplates.GuildActivity_Base = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Base.GuildActivity_Base"
    luaComponentTemplates.GuildActivity_MagicCircle = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Main.GuildActivity_MagicCircle"
    luaComponentTemplates.GuildActivity_UnOpen = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Main.GuildActivity_UnOpen"
    luaComponentTemplates.GuildActivity_GuildForbiddenArea = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Main.GuildActivity_GuildForbiddenArea"
    luaComponentTemplates.GuildActivity_HangHuiMiJing = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Main.GuildActivity_GuildForHangHuiMiJingArea"
    luaComponentTemplates.GuildActivity_HangHuiShouLing = require "luaRes.ui.template.UIGuildActivitiesPanelTemplates.Main.GuildActivity_GuildForHangHuiShouLin"

    ---公会首领信息排行个体信息
    luaComponentTemplates.GuildBossRankInfoItemTemp = require "luaRes.ui.template.UIGuildBossRankPanel.UIGuildBossRankInfoItemTemp"
    ---公会首领奖励个体信息
    luaComponentTemplates.GuildBossRankRewardItemTemp = require "luaRes.ui.template.UIGuildBossRankRewardPanel.GuildBossRankRewardItemTemp"
    --endregion

    --region 物品使用面板
    luaComponentTemplates.ItemUsePanelTemplate_Base = require "luaRes.ui.template.ItemUsePanelTemplates.Base.ItemUsePanelTemplate_Base"
    luaComponentTemplates.ItemUsePanelTemplate_Normal = require "luaRes.ui.template.ItemUsePanelTemplates.Main.ItemUsePanelTemplate_Normal"
    --endregion

    --region 自选宝箱面板
    luaComponentTemplates.UIOptionalBoxPanelGrid_Base = require "luaRes.ui.template.UIOptionalBoxPanelTemplates.Base.UIOptionalBoxPanelGrid_Base"
    luaComponentTemplates.UIOptionalBoxPanelGrid_Normal = require "luaRes.ui.template.UIOptionalBoxPanelTemplates.Main.UIOptionalBoxPanelGrid_Normal"
    --endregion

    --region 通用
    ---通用缓存池
    luaComponentTemplates.CachePoolTemplate = require "luaRes.ui.template.UIDialogTipsContainerPanelTemplates.Base.CachePoolTemplate"
    --endregion

    --region 高级回收
    ---高级回收页控制器
    luaComponentTemplates.UIHighRecyclePageCtrl = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecyclePageCtrl"
    ---高级回收交互器
    luaComponentTemplates.UIHighRecycleContainerInteraction = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecycleContainerInteraction"
    ---高级回收格子
    luaComponentTemplates.UIHighRecycleGrid = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecycleGrid"
    ---高级回收可拖拽物品
    luaComponentTemplates.UIHighRecycleDraggableItem = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecycleDraggableItem"
    ---高级回收界面取出右上角按钮
    luaComponentTemplates.UIHighRecyclePanel_TakeOutRightUpOperate = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecyclePanel_TakeOutRightUpOperate"
    ---高级回收界面放入右上角按钮
    luaComponentTemplates.UIHighRecyclePanel_PutInRightUpOperate = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecyclePanel_PutInRightUpOperate"
    ---高级回收界面赎回右上角按钮
    luaComponentTemplates.UIHighRecyclePanel_RedeemRightUpOperate = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecyclePanel_RedeemRightUpOperate"
    ---高级回收界面赎回的货币数量调整面板
    luaComponentTemplates.UIHighRecyclePanel_RedeemItemTemplate = require "luaRes.ui.template.HighRecycleTemplates.UIHighRecyclePanel_RedeemItemTemplate"
    --endregion

    --region 夺榜
    ---页签
    luaComponentTemplates.UIContendRank_BookMarkTemplate = require "luaRes.ui.template.UIContendRankPanel.UIContendRank_BookMarkTemplate"
    ---主视图
    luaComponentTemplates.UIContendRank_MainViewTemplate = require "luaRes.ui.template.UIContendRankPanel.UIContendRank_MainViewTemplate"
    ---排行视图
    luaComponentTemplates.UIContendRank_RankViewTemplate = require "luaRes.ui.template.UIContendRankPanel.UIContendRank_RankViewTemplate"
    ---排行单元
    luaComponentTemplates.UIContendRank_UnitTemplate = require "luaRes.ui.template.UIContendRankPanel.UIContendRank_UnitTemplate"
    --endregion

    --region 炼化
    luaComponentTemplates.UIRefineItemAttributeUnitTemplate = require "luaRes.ui.template.UIRefinePanelTemplates.UIRefineItemAttributeUnitTemplate"
    --endregion

    --region 传送员
    luaComponentTemplates.UIDeliverUnitTemplate = require "luaRes.ui.template.UINewTeleportPanelTemplates.UIDeliverUnitTemplate"
    --endregion

    --region 霸业
    ---页签
    luaComponentTemplates.UIOverlordRank_BookMarkTemplate = require "luaRes.ui.template.UIOverlordRankPanelTemplates.UIOverlordRank_BookMarkTemplate"
    ---主视图
    luaComponentTemplates.UIOverlordRank_MainViewTemplate = require "luaRes.ui.template.UIOverlordRankPanelTemplates.UIOverlordRank_MainViewTemplate"
    ---单元
    luaComponentTemplates.UIOverlordRank_UnitTemplate = require "luaRes.ui.template.UIOverlordRankPanelTemplates.UIOverlordRank_UnitTemplate"
    ---迷你视图
    luaComponentTemplates.UIOverlordRank_MiniRankTemplate = require "luaRes.ui.template.UIOverlordRankPanelTemplates.UIOverlordRank_MiniRankTemplate"

    --endregion

    --region 侧边栏排行榜
    luaComponentTemplates.UIRefreshTemplate = require "luaRes.ui.template.UIMagicBossRankPanelTemplates.Base.UIRefreshTemplate"
    luaComponentTemplates.UIMagicBossRankPanel_SingleRankTemplate = require "luaRes.ui.template.UIMagicBossRankPanelTemplates.UIMagicBossRankPanel_SingleRankTemplate"
    --endregion

    --region 奖励通用排行榜
    luaComponentTemplates.UIMagicBossRankRewardPanel_SingleRankTemplate = require "luaRes.ui.template.UIMagicBossRankRewardPanel_Templates.UIMagicBossRankRewardPanel_SingleRankTemplate"
    --endregion

    --region 灵兽地图模板
    luaComponentTemplates.UIServantPracticeMapPanelTemplate = require "luaRes.ui.template.UIServantPracticeMapPanelTemplates.UIServantPracticeMapPanelTemplate"
    --endregion   

    --region 活动排行榜
    ---活动排行榜单元
    luaComponentTemplates.UIActivityRankUnitTemplate = require "luaRes.ui.template.UIActivityRankPanelTemplate.UIActivityRankUnitTemplate"
    ---武道会活动排行榜单元
    luaComponentTemplates.UIActivityBudowillRankUnitTemplate = require "luaRes.ui.template.UIActivityRankPanelTemplate.UIActivityBudowillRankUnitTemplate"
    --endregion

    --region 怪物悬赏界面
    luaComponentTemplates.UIMonsterArrestPanelTemplate = require "luaRes.ui.template.UIMonsterArrestPanelTemplates.UIMonsterArrestPanelTemplate"
    --endregion

    --region 恶魔广场界面
    luaComponentTemplates.UIDevilSquare_DeviItemTemplate = require "luaRes.ui.template.UIDevilSquarePanelTemplates.UIDevilSquare_DeviItemTemplate"
    --endregion

    --region 变强界面
    luaComponentTemplates.UIStrongerMainBtnGrid = require "luaRes.ui.template.UIStrongerPanel.UIStrongerMainBtnGrid"
    luaComponentTemplates.UIStrongerMainInfoGrid = require "luaRes.ui.template.UIStrongerPanel.UIStrongerMainInfoGrid"
    --endregion

    --region 天宫神剪
    luaComponentTemplates.UIGodShearsPanel_Button = require "luaRes.ui.template.UIGodShearsPanelTemplates.UIGodShearsPanel_Button"
    --endregion

    --region 挑战BOSS（新）
    ---Boss模板基类
    luaComponentTemplates.UIChallengeBossBaseTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBossBaseTemplates"
    ---boss展示
    luaComponentTemplates.UIChallengeBoss_BossTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_BossTemplates"
    ---魔之Boss
    luaComponentTemplates.UIChallengeBoss_DemonBossTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_DemonBossTemplates"
    ---野外Boss
    luaComponentTemplates.UIChallengeBoss_WildBossTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_WildBossTemplates"
    ---终极Boss基础模板
    luaComponentTemplates.UIChallengeBoss_FinalBossBaseTemplate = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_FinalBossBaseTemplate"
    ---终极Boss物品模板
    luaComponentTemplates.UIChallengeBossFinalBossItem = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBossFinalBossItem"
    ---远古Boss
    luaComponentTemplates.UIChallengeBoss_AncientBossTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_AncientBossTemplates"
    ---神级Boss
    luaComponentTemplates.UIChallengeBoss_MythBossTemplates = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_MythBossTemplates"
    ---个人Boss
    luaComponentTemplates.UIChallengeBoss_PersonalBossTemplate = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_PersonalBossTemplate"
    ---生肖Boss
    luaComponentTemplates.UIChallengeBoss_ShengXiaoBossTemplate = require "luaRes.ui.template.UIChallengeBossTemplates.UIChallengeBoss_ShengXiaoBossTemplate"
    --endregion

    --region UI拓展组件

    --region 球
    ---球基础模板
    luaComponentTemplates.CircleRateBaseTemplate = require "luaRes.ui.template.CircleRateTemplate.CircleRateBaseTemplate"
    ---灵兽聚灵球
    luaComponentTemplates.UIServantGatherSoulCircleTemplate = require "luaRes.ui.template.CircleRateTemplate.UIServantGatherSoulCircleTemplate"
    ---灵兽经验球
    luaComponentTemplates.UIServantPracticeLevelCircleTemplate = require "luaRes.ui.template.CircleRateTemplate.UIServantPracticeLevelCircleTemplate"
    --endregion

    ---圆圈的Grid模板类
    luaComponentTemplates.Lua_UICircleGridContainer = require "luaRes.ui.template.Utility.Lua_UICircleGridContainer"

    --endregion

    --region闯天关排行榜
    luaComponentTemplates.UICrawlTowerRankPanel_RankTemplate = require "luaRes.ui.template.UICrawlTowerRankPanelTemplates.UICrawlTowerRankPanel_RankTemplate"
    --endregion

    --region 魔之boss左侧面板
    luaComponentTemplates.MagicBossLeftPanel_Base = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Base.MagicBossLeftPanel_Base"

    luaComponentTemplates.MagicBossLeftPanel_Normal = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Main.MagicBossLeftPanel_Normal"
    luaComponentTemplates.MagicBossLeftPanel_AttackOwner = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Main.MagicBossLeftPanel_AttackOwner"
    luaComponentTemplates.MagicBossLeftPanel_AttackOther = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Main.MagicBossLeftPanel_AttackOther"
    luaComponentTemplates.MagicBossLeftPanel_DeadOwner = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Main.MagicBossLeftPanel_DeadOwner"
    luaComponentTemplates.MagicBossLeftPanel_DeadSameUnion = require "luaRes.ui.template.MagicBossLeftPanelTemplates.Main.MagicBossLeftPanel_DeadSameUnion"
    --endregion
    --region 封印塔
    luaComponentTemplates.UISealTowerPanel_LeagueInfo_Base = require "luaRes.ui.template.UISealTowerPanelTemplates.Base.UISealTowerPanel_LeagueInfo_Base"
    luaComponentTemplates.UISealTowerPanel_LeagueInfo_Normal = require "luaRes.ui.template.UISealTowerPanelTemplates.Main.UISealTowerPanel_LeagueInfo_Normal"
    luaComponentTemplates.UISealTowerPanel_LeagueInfo_MySacrifice = require "luaRes.ui.template.UISealTowerPanelTemplates.Main.UISealTowerPanel_LeagueInfo_MySacrifice"
    --endregion

    --region 跨服联盟Npc模板
    ---联盟会长模板
    luaComponentTemplates.UILeagueNpcPanel_LeaderTemplate = require "luaRes.ui.template.UILeagueNpcPanelTemplates.UILeagueNpcPanel_LeaderTemplate"
    --endregion

    --region 跨服投票
    ---联盟单元模板
    luaComponentTemplates.UIUnionPreselectedPanel_UnitTemplate = require "luaRes.ui.template.UIUnionPreselectedTemplates.UIUnionPreselectedPanel_UnitTemplate"
    ---投票详情单元模板
    luaComponentTemplates.UIUnionPreselectedVotePanel_UnitTemplate = require "luaRes.ui.template.UIUnionPreselectedTemplates.UIUnionPreselectedVotePanel_UnitTemplate"
    --endregion

    --region 节日/跨服/etc活动
    luaComponentTemplates.UICommonBookMarkTemplate = require "luaRes.ui.template.UIActivityCurrentBaseTemplates.UICommonBookMarkTemplate"

    --region 热血狂欢
    ---热血狂欢任务模板
    luaComponentTemplates.UICarnivalPanel_MissionTemplate = require "luaRes.ui.template.UICarnivalPanelTemplates.UICarnivalPanel_MissionTemplate"
    ---狂欢点模板
    luaComponentTemplates.UICarnivalPanel_CountTemplate = require "luaRes.ui.template.UICarnivalPanelTemplates.UICarnivalPanel_CountTemplate"
    ---狂欢点奖励模板
    luaComponentTemplates.UICarnivalPanel_CountRewardTemplate = require "luaRes.ui.template.UICarnivalPanelTemplates.UICarnivalPanel_CountRewardTemplate"
    --endregion

    --region 狂欢商店
    luaComponentTemplates.UICarnivalShop_ItemTemplate = require "luaRes.ui.template.UISpecialMission_CarnivalShop.UICarnivalShop_ItemTemplate"
    --endregion

    --region 合服攻沙
    luaComponentTemplates.UICombineServerShabakeUnitTemplate = require "luaRes.ui.template.UICombineServerShabakePanelTemplates.UICombineServerShabakeUnitTemplate";
    --endregion
    --endregion

    --region 血继
    ---血继普通装备模板基类
    luaComponentTemplates.UIRoleBloodSuitItemBase = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuitItemBase"
    ---血继普通装备模板
    luaComponentTemplates.UIRoleBloodSuitItemTemplate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuitItemTemplate"
    ---血继肉身装备模板
    luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuitBodyItemTemplate"
    ---血继套装页签模板
    luaComponentTemplates.UIRoleBloodSuitTblTemplate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuitTblTemplate"
    ---查看其他玩家血继套装页签按钮模板
    luaComponentTemplates.UIRolePanel_BloodSuitTblTemplateOtherPlayer = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRolePanel_GridTemplateOtherPlayer"
    ---血继背包道具左侧显示模板
    luaComponentTemplates.UIRoleBloodSuit_BagRightUpOperate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.ItemLeftTemp.UIRoleBloodSuit_BagRightUpOperate"
    ---血继面板道具左侧显示模板
    luaComponentTemplates.UIRoleBloodSuit_PanelRightUpOperate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.ItemLeftTemp.UIRoleBloodSuit_PanelRightUpOperate"
    ---血炼重写肉身单个格子模板
    luaComponentTemplates.UIRoleBloodSuit_SmeltBodyItemTemplate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuit_SmeltBodyItemTemplate"
    ---血炼重写普通装备单个格子模板
    luaComponentTemplates.UIRoleBloodSuit_SmeltItemTemplate = require "luaRes.ui.template.UIRoleBloodSuitTemplate.UIRoleBloodSuit_SmeltItemTemplate"
    --endregion

    --region 血继装备熔炼
    ---血继装备模板
    luaComponentTemplates.BloodSuitSmeltItemTemplate = require "luaRes.ui.template.UIForgeBloodSmeltPanelTemplates.BloodSuitSmeltItemTemplate"
    --endregion

    --region 法宝
    ---单个页签模板
    luaComponentTemplates.UIRoleArtifactPanel_SinglePage = require "luaRes.ui.template.UIRoleArtifactPanelTemplates.Grid.UIRoleArtifactPanel_SinglePage"
    ---单个物品模板
    luaComponentTemplates.UIRoleArtifactPanel_SingleItem = require "luaRes.ui.template.UIRoleArtifactPanelTemplates.Grid.UIRoleArtifactPanel_SingleItem"
    ---其他玩家单个页签模板
    luaComponentTemplates.UIOtherRoleArtifactPanel_SinglePage = require "luaRes.ui.template.UIOtherRoleArtifactPanelTemplates.UIOtherRoleArtifactPanel_SinglePage"
    ---其他玩家单个物品模板
    luaComponentTemplates.UIOtherRoleArtifactPanel_SingleItem = require "luaRes.ui.template.UIOtherRoleArtifactPanelTemplates.UIOtherRoleArtifactPanel_SingleItem"
    --endregion

    --region 限购礼包
    ---限购礼包格子模板
    luaComponentTemplates.UIPurchaseLimitGiftBoxUnitTemplate = require "luaRes.ui.template.UISpeciallyPreferentialPanel.UIPurchaseLimitGiftBoxUnitTemplate"
    --endregion

    --region 灵兽任务
    ---页签视图模板
    luaComponentTemplates.UILsMissionPanel_PageViewTemplate = require "luaRes.ui.template.UILsMissionPanelTemplates.UILsMissionPanel_PageViewTemplate"
    ---页签单元模板
    luaComponentTemplates.UILsMissionPanel_PageUnitTemplate = require "luaRes.ui.template.UILsMissionPanelTemplates.UILsMissionPanel_PageUnitTemplate"
    ---任务视图模板
    luaComponentTemplates.UILsMissionPanel_TaskViewTemplate = require "luaRes.ui.template.UILsMissionPanelTemplates.UILsMissionPanel_TaskViewTemplate"
    ---任务单元模板
    luaComponentTemplates.UILsMissionPanel_UnitTemplate = require "luaRes.ui.template.UILsMissionPanelTemplates.UILsMissionPanel_UnitTemplate"
    --endregion

    --region 白日门活动UI
    ---白日门活动界面书签
    luaComponentTemplates.WhiteSunGatePanelBookMark = require "luaRes.ui.template.UIWhiteSunGatePanelTemplates.UIWhiteSunGatePanelBookMark"
    --endregion

    --region 白日门猎魔
    ---猎魔boss单元模板
    luaComponentTemplates.UIBrmHuntingMonster_BossUnitTemplate = require "luaRes.ui.template.UIBrmHuntingMonsterPanelTemplates.UIBrmHuntingMonster_BossUnitTemplate"
    --endregion

    --region 白日门封赏
    luaComponentTemplates.UIBrmHuntingRewardTemplate = require "luaRes.ui.template.UIBrmHuntingRewardTemplates.UIBrmHuntingRewardTemplate"
    --region 白日门押镖
    ---押镖单个镖车模板
    luaComponentTemplates.UIBrmEscortDartCarTemplate = require "luaRes.ui.template.UIBrmEscortPanelTemplates.UIBrmEscortDartCarTemplate"
    --endregion

    --region 白日门圣物
    ---白日门圣物UI单元
    luaComponentTemplates.UIBrmCrystalTemplate_Cell = require "luaRes.ui.template.UIBrmCrystalPanelTemplates.UIBrmCrystalTemplate_Cell"
    --endregion
    --endregion

    --region 白日门联服活动
    ---白日门联服活动模板
    luaComponentTemplates.UIBrmCrossServerActivityTemplate = require "luaRes.ui.template.UIBrmCrossServerActivityTemplates.UIBrmCrossServerActivityTemplate"
    --endregion

    --region 消费排行
    ---消费排行单元面板
    luaComponentTemplates.UIConsumeRankPanel_UnitTemplate = require "luaRes.ui.template.UIConsumeRankPanelTemplates.UIConsumeRankPanel_UnitTemplate"
    --endregion

    --region boss技能
    ---boss技能格子模板
    luaComponentTemplates.UIBossSkillGridTemplate = require "luaRes.ui.template.UIBossSKillPanelTemplates.UIBossSkillGridTemplate"
    --endregion

    --region 投资模板
    ---投资模板
    luaComponentTemplates.UIInvestmentTemplate = require "luaRes.ui.template.UIInvestmentTemplates.UIInvestmentTemplate"
    --endregion

    --region 虎符模板
    luaComponentTemplates.SingleHuFuTemplate = require "luaRes.ui.template.HuFuTemplates.SingleHuFuTemplate"
    --endregion

    --region 藏品界面模板
    ---藏品物品控制器
    luaComponentTemplates.UICollectionItemsController = require "luaRes.ui.template.UICollectionTemplates.UICollectionItemsController"
    ---藏品物品格子
    luaComponentTemplates.UICollectionItemGrid = require "luaRes.ui.template.UICollectionTemplates.UICollectionItemGrid"
    ---藏品容器交互
    luaComponentTemplates.UICollectionTypeContainerInteraction = require "luaRes.ui.template.UICollectionTemplates.UICollectionTypeContainerInteraction"
    ---藏品界面可拖拽物品
    luaComponentTemplates.UICollectionItemDraggableItem = require "luaRes.ui.template.UICollectionTemplates.UICollectionItemDraggableItem"
    ---藏品页模板
    luaComponentTemplates.UICollectionPageTemplate = require "luaRes.ui.template.UICollectionTemplates.UICollectionPageTemplate"
    ---藏品页每页的图片绘制器
    luaComponentTemplates.UICollectionPagePictureDrawer = require "luaRes.ui.template.UICollectionTemplates.UICollectionPagePictureDrawer"
    ---藏品页单页的图片
    luaComponentTemplates.UICollectionPictureTemplate = require "luaRes.ui.template.UICollectionTemplates.UICollectionPictureTemplate"
    ---藏品界面右侧部分
    luaComponentTemplates.UICollectionRightPart = require "luaRes.ui.template.UICollectionTemplates.UICollectionRightPart"
    ---藏品界面右侧连锁属性单元
    luaComponentTemplates.UICollectionRightPart_LinkEffectCell = require "luaRes.ui.template.UICollectionTemplates.UICollectionRightPart_LinkEffectCell"
    ---其他玩家的藏品阁控制器
    luaComponentTemplates.UICollectionItemsController_OtherPlayer = require "luaRes.ui.template.UICollectionTemplates.UICollectionItemsController_OtherPlayer"
    ---其他玩家的藏品阁交互控制
    luaComponentTemplates.UICollectionTypeContainerInteraction_OtherPlayer = require "luaRes.ui.template.UICollectionTemplates.UICollectionTypeContainerInteraction_OtherPlayer"
    --endregion

    --region 登录有礼
    ---登录有礼格子模板
    luaComponentTemplates.UIRegisterGiftPanelUnitTemplate = require "luaRes.ui.template.UIRegisterGiftPanelTemplates.UIRegisterGiftPanelUnitTemplate"
    --endregion

    --region 倒计时
    ---单条倒计时模板
    luaComponentTemplates.UIRelifeCountDownTemplate = require "luaRes.ui.template.UIRelifeCountDown.UIRelifeCountDownTemplate"
    --endregion

    --region 累计充值
    ---累计充值单元
    luaComponentTemplates.UIHeapRechargeUnitTemplate = require "luaRes.ui.template.UIHeapRechargeGiftPanelTemplates.UIHeapRechargeUnitTemplate"
    --endregion

    --region 累计充值（领奖）
    ---累计充值单元
    luaComponentTemplates.UIAccumulatedRechargeUnitTemplate = require "luaRes.ui.template.UIAccumulatedRechargePanelTemplates.UIAccumulatedRechargeUnitTemplate"
    --endregion

    --region 视频播放
    luaComponentTemplates.UIVideoPlayerTemplate = require "luaRes.ui.template.UIVideoPlayerTemplates.UIVideoPlayerTemplate"
    --endregion

    --region 封号天赋
    -- 属性模板
    luaComponentTemplates.UIMilitaryRankTitleFlairTemplate = require "luaRes.ui.template.UIMilitaryRankTitleFlairTemplates.UIMilitaryRankTitleFlairTemplate"
    --endregion

    --region 会员
    ---会员面板左侧页签
    luaComponentTemplates.UIMemberPageTemplate = require "luaRes.ui.template.UIMemberTemplates.UIMemberPageTemplate"
    ---会员面板任务进度页签
    luaComponentTemplates.UIMemberTaskTemplate = require "luaRes.ui.template.UIMemberTemplates.UIMemberTaskTemplate"
    --endregion

    --region 潜能投资
    -- 投资类别模板
    luaComponentTemplates.UIPotentialInvestTypeTemplate = require "luaRes.ui.template.UIPotentialInvestTemplate.UIPotentialInvestTypeTemplate"
    -- 达成条件模板
    luaComponentTemplates.UIPotentialInvestConditionTemplate = require "luaRes.ui.template.UIPotentialInvestTemplate.UIPotentialInvestConditionTemplate"
    --endregion

    --region 新副本
    --- 副本格子模板
    luaComponentTemplates.UIDevilSquarePanel_UnitTemplate = require "luaRes.ui.template.UIDevilSquarePanelTemplate.UIDevilSquarePanel_UnitTemplate"
    --endregion

    --region 灵魂任务
    luaComponentTemplates.UILingHunRenWu_TaskItemTemplate = require "luaRes.ui.template.UILingHunRenWuTemplate.UILingHunRenWu_TaskItemTemplate"
    --endregion

    --region 扫荡模板
    ---扫荡模板
    luaComponentTemplates.CompleteTemplate = require "luaRes.ui.template.CompleteTemplates.CompleteTemplate"
    --endregion

    --region 花费模板
    ---花费模板
    luaComponentTemplates.CostTemplate = require "luaRes.ui.template.CompleteTemplates.CostTemplate"
    --endregion

    --region 领取奖励
    ---扫荡模板
    luaComponentTemplates.RewardTemplate = require "luaRes.ui.template.CompleteTemplates.RewardTemplate"
    --endregion

    --region 新夺榜
    ---夺榜新页签
    luaComponentTemplates.UIContendRankMain_BookMarkTemplate = require "luaRes.ui.template.UIContendRankMainPanel.UIContendRankMain_BookMarkTemplate"
    --endregion

    --region 系统预告
    ---通用页签
    luaComponentTemplates.UIBookMarkBaseTempate = require "luaRes.ui.template.UISystemOpenPanelTemplates.UIBookMarkBaseTempate"
    ---系统预告页签
    luaComponentTemplates.UISystemOpenPanel_BookMarkTemplate = require "luaRes.ui.template.UISystemOpenPanelTemplates.UISystemOpenPanel_BookMarkTemplate"
    --endregion

    --region 鉴定模板
    ---鉴定模板
    luaComponentTemplates.UIForgeIdentifyTemplate = require "luaRes.ui.template.UIForgeIdentifyTemplates.UIForgeIdentifyTemplate"
    --endregion

    --region 兑换经验
    luaComponentTemplates.UIExpExchangeCostOption = require "luaRes.ui.template.UIExpExchange.UIExpExchangeCostOption"
    --endregion

    --region 经验丹
    luaComponentTemplates.UIExpItemExchangeOption = require "luaRes.ui.template.UIExpItemTemplates.UIExpItemExchangeOption"
    --endregion

    --region 淬炼
    ---主页签
    luaComponentTemplates.UIForgeQuenchListPanel_FirstPageTemplate = require "luaRes.ui.template.UIForgeQuenchPanelTemplates.UIForgeQuenchListPanel_FirstPageTemplate"
    ---次页签
    luaComponentTemplates.UIForgeQuenchListPanel_SecondPageTemplate = require "luaRes.ui.template.UIForgeQuenchPanelTemplates.UIForgeQuenchListPanel_SecondPageTemplate"
    ---材料
    luaComponentTemplates.UIForgeQuenchPanel_MaterialTemplate = require "luaRes.ui.template.UIForgeQuenchPanelTemplates.UIForgeQuenchPanel_MaterialTemplate"
    ---淬炼物
    luaComponentTemplates.UIForgeQuenchPanel_OutputTemplate = require "luaRes.ui.template.UIForgeQuenchPanelTemplates.UIForgeQuenchPanel_OutputTemplate"
    --endregion

    --region 八荒恶谷
    luaComponentTemplates.UIBaHuangEGuTemplate = require "luaRes.ui.template.UIBaHuangEGuTemplates.UIBaHuangEGuTemplate"
    --endregion

    --region 幽灵船
    ---主页签
    luaComponentTemplates.UIGhostShipTemplate = require "luaRes.ui.template.UIGhostShipTemplates.UIGhostShipTemplate"
    ---左页签
    luaComponentTemplates.UIGhostShipLeftMainTemplate = require "luaRes.ui.template.UIGhostShipTemplates.UIGhostShipLeftMainTemplate"
    --endregion

    --region 仙装镶嵌
    luaComponentTemplates.UISoulEquipInlayHole = require "luaRes.ui.template.UISoulEquipInlayHoleTemplate.UISoulEquipInlayHole"
    --endregion

    --region 跨服摆摊
    ---跨服摆摊出售单元模板
    luaComponentTemplates.UIServerSelfSellPanel_UnitTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_UnitTemplate"
    ---跨服摆摊摆摊视图模板
    luaComponentTemplates.UIServerSelfSellPanel_StallViewTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_StallViewTemplate"
    ---跨服摆摊信息模板
    luaComponentTemplates.UIServerSelfSellPanel_StallInfoTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_StallInfoTemplate"
    ---跨服摆摊上架混合模板元宝/钻石
    luaComponentTemplates.UIServerSelfSellPanel_TradAddShelfMixTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_TradAddShelfMixTemplate"
    ---跨服摆摊重新上架模板
    luaComponentTemplates.UIServerSelfSellPanel_TradeReAddShelfTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_TradeReAddShelfTemplate"
    ---跨服摆摊下架模板（已过期）
    luaComponentTemplates.UIServerSelfSellPanel_TradeRemoveShelfTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_TradeRemoveShelfTemplate"
    ---跨服摆摊下架模板(未到期)
    luaComponentTemplates.UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate = require "luaRes.ui.template.UIServerSelfSellPanel.UIServerSelfSellPanel_TradeRemoveShelfDidNotExpireTemplate"
    --endregion

    --region 重铸
    luaComponentTemplates.UIReforgedPanelTemplates_AttributeTemplate = require "luaRes.ui.template.UIReforgedPanelTemplates.UIReforgedPanelTemplates_AttributeTemplate"
    luaComponentTemplates.UIReforgedPanelTemplates_MaterialTemplate = require "luaRes.ui.template.UIReforgedPanelTemplates.UIReforgedPanelTemplates_MaterialTemplate"
    luaComponentTemplates.UIReforgedPanelTemplates_LevelEffect = require "luaRes.ui.template.UIReforgedPanelTemplates.UIReforgedPanelTemplates_LevelEffect"
    --endregion

    --region 副本
    luaComponentTemplates.UIBossDuplicateTemplate = require "luaRes.ui.template.UIBossDuplicateTemplates.UIBossDuplicateTemplate"
    --endregion

    --region 投保
    luaComponentTemplates.UIInsureItemTemplate = require "luaRes.ui.template.UIInsureTemplates.UIInsureItemTemplate"
    --endregion

    --region 兵鉴神力
    ---突破
    luaComponentTemplates.UISLequip_ClassTemplate = require "luaRes.ui.template.UISLequipLevelTemplates.UISLequip_ClassTemplate"
    ---升级
    luaComponentTemplates.UISLequip_LevelTemplate = require "luaRes.ui.template.UISLequipLevelTemplates.UISLequip_LevelTemplate"
    ---tips
    luaComponentTemplates.UISLequip_InfoTemplate = require "luaRes.ui.template.UISLequipLevelTemplates.UISLequip_InfoTemplate"
    ---info_ExtraAttr
    luaComponentTemplates.UIItemInfoPanel_Info_ExtraAttribute_BingJian = require "luaRes.ui.template.UISLequipLevelTemplates.UIItemInfoPanel_Info_ExtraAttribute_BingJian"
    --endregion

    --region 累充豪礼
    ---累充豪礼单元面板
    luaComponentTemplates.UIHeapRechargeBestGiftTemplate = require "luaRes.ui.template.UIHeapRechargeBestGiftTemplate.UIHeapRechargeBestGiftTemplate"
    ---累充豪礼奖励单元面板
    luaComponentTemplates.UIHeapRechargeBestGiftAwardTemplate = require "luaRes.ui.template.UIHeapRechargeBestGiftTemplate.UIHeapRechargeBestGiftAwardTemplate"
    --endregion
end

---统一设置所有模板lua的元表,__index以及模块名
function TemplateManager.SetAllLuaComponentMetaTable()
    for k, v in pairs(luaComponentTemplates) do
        if getmetatable(v) == nil then
            --设置模板的元表为模板
            setmetatable(v, templatebase)
        end
        --设置模板的__index为自身
        v.__index = v
        v.chunkName = k
        v.__gc = TemplateManager.OnTemplateGetGCed
    end
    ---重新设置Unity方法是否存在的变量
    for k, v in pairs(luaComponentTemplates) do
        v.__UnityFunctionExist = v.Start ~= nil or v.OnEnable ~= nil or v.OnDisable ~= nil or v.OnDestroy ~= nil
        --if luaDebugTool ~= nil then
        --    luaDebugTool.RecordTable(luaDebugTool.TableType.Template, v)
        --end
    end
end

---获取模板在某Unity GameObject上的实例,并执行Init函数.
---go表示模板所指向的游戏物体.
---生命周期对应的函数为:
---  Init 初始化函数,Table定义时执行;
---  Start 与MonoBehaviour的Start函数运行位置一致;
---  OnEnable 使能函数,Table对应的游戏物体使能时执行;
---  OnDisable 禁用函数,Table对应的游戏物体被禁用时执行;
---  OnDestroy 销毁函数,Table对应的游戏物体被销毁时执行;
---@generic T:TemplateBase
---@param go UnityEngine.Object
---@param templateTable T luaComponentTemplate中的模板
---@return T 模板的新实例
function TemplateManager.GetNewTemplate(go, templateTable, ...)
    if go ~= nil then
        go = go.gameObject
    end

    if go == nil or CheckIsUnityNullFunction(go) or templateTable == nil then
        return nil
    end
    ---是否有unity周期函数
    local hasUnityFunction = templateTable.__UnityFunctionExist
    --hasUnityFunction = true
    ---@type TemplateBase
    local newTable
    local stateBehaviour
    if hasUnityFunction then
        local isCreateNewComp = false
        stateBehaviour, isCreateNewComp = GetLuaStateBehaviourFunction(go, templateTable.chunkName)
        if isCreateNewComp == false and stateBehaviour ~= nil then
            ---若LuaStateBehaviour之前已经有绑定过组件,则将其销毁
            stateBehaviour:Dispose()
        end
        newTable = stateBehaviour.ChunkTable;
    else
        newTable = {}
    end
    setmetatable(newTable, templateTable)

    if hasUnityFunction and stateBehaviour ~= nil then
        if newTable.Start then
            if stateBehaviour.isStartHasDone == false then
                stateBehaviour.onStart = function()
                    if newTable then
                        newTable:Start()
                    end
                end
            end
        end
        if newTable.OnEnable then
            stateBehaviour.onEnabled = function()
                if newTable then
                    newTable:OnEnable()
                end
            end
        end
        if newTable.OnDisable then
            stateBehaviour.onDisabled = function()
                if newTable then
                    newTable:OnDisable()
                end
            end
        end
        if newTable.OnDestroy then
            stateBehaviour.onDestroyed = function()
                if newTable then
                    newTable:OnDestroy()
                    newTable.go = nil
                    newTable = nil
                end
            end
        end
    end
    newTable.go = go
    if newTable.Init then
        newTable:Init(...)
    end
    if newTable.Start then
        if stateBehaviour.isStartHasDone == true then
            newTable:Start()
        end
    end
    stateBehaviour = nil
    --print(TemplateManager.GetGameObjectFullPath(go, '--------------'..templateTable.chunkName))
    --if luaDebugTool ~= nil then
    --    luaDebugTool.RecordTable(luaDebugTool.TableType.TemplateInstance, newTable)
    --end
    return newTable
end

function TemplateManager.GetGameObjectFullPath(go, path)
    if (go == nil) then
        return path
    end
    return TemplateManager.GetGameObjectFullPath(go.transform.parent, go.gameObject.name .. '/' .. path)
end

---@private
---@param template TemplateBase
function TemplateManager.OnTemplateGetGCed(template)
    if template == nil then
        return
    end
    if template.OnDestruct ~= nil then
        template:OnDestruct()
    end
    for i, v in pairs(template) do
        template[i] = nil
    end
end

return TemplateManager