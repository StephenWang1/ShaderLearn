---@class UIBrmEscortDartCarTemplate:TemplateBase 白日门单个镖车模板
local UIBrmEscortDartCarTemplate = {}

--region 数据
UIBrmEscortDartCarTemplate.analysisState = nil
--endregion

--region 初始化
function UIBrmEscortDartCarTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

---初始化模板
function UIBrmEscortDartCarTemplate:InitComponent()
    ---@type UISprite
    self.name_UISprite = self:Get("name","UISprite")
    ---@type UISprite
    self.model_UISprite = self:Get("Model","UISprite")
    ---@type CSUIEffectLoad
    self.backGround_CSUIEffectLoad = self:Get("backGround","CSUIEffectLoad")
    ---@type UIGridContainer
    self.award_UIGridContainer = self:Get("dropScroll/DropItem","UIGridContainer")
    ---@type UnityEngine.GameObject
    self.goBtn_GameObject = self:Get("btn_go","GameObject")
    ---@type UILabel
    self.goBtnName_UILabel = self:Get("btn_go/lab_name","UILabel")
    ---@type UISprite
    self.goBtnBackGround_UISprite = self:Get("btn_go/backGround","UISprite")
    ---@type UITable
    self.cost_UITable = self:Get("ConsumeTable","UITable")
    ---@type UIGridContainer
    self.cost_UIGridContainer = self:Get("ConsumeTable/Consume","UIGridContainer")
    ---@type UIScrollView
    self.dropList_UIScrollView = self:Get("dropScroll","UIScrollView")
end

---绑定事件
function UIBrmEscortDartCarTemplate:BindEvents()
    luaclass.UIRefresh:BindClickCallBack(self.goBtn_GameObject,function(go)
        local popoId = 0
        --local activityIsOpen = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():IsActivityOpenedNow()
        --if activityIsOpen == false then
        --    popoId = 445
        if gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():YaBiaoNumIsEnough() == false then
            popoId = 446
        elseif clientTableManager.cfg_deliverManager:CheckMainPlayerCanEnterMap(40017) == false then
            popoId = 447
        elseif self.haveOperationDartCar then
            if self.operationDartCar ~= nil then
                popoId = 437
            else
                popoId = 438
            end
        else
            local npcInMainPlayerAround = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():AroundHaveYaBiaoNpc()
            if npcInMainPlayerAround == false then
                uimanager:ClosePanel("UIWhiteSunGatePanel")
                Utility.TryTransfer(40017,false)
                return
            end
            if self.configDartCarClass:CheckMainPlayerCanBuyDartCar() == false then
                popoId = 439
            end
        end
        if popoId ~= 0 then
            Utility.ShowPopoTips(go,nil,popoId)
            return
        end
        networkRequest.ReqStartFreightCar(self.configDartCarClass.YaBiaoConfigTbl:GetId())
        uimanager:ClosePanel("UIWhiteSunGatePanel")
    end)
end
--endregion

--region 刷新
---刷新面板
---@param commonData table 通用数据
function UIBrmEscortDartCarTemplate:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        return
    end
    self:RefreshDartCarName()
    self:RefreshModel()
    self:RefreshBackGround()
    self:RefreshAwardList()
    self:RefreshGoBtnName()
    self:RefreshCostList()
    self:RefreshBtnBackGround()
end

---解析数据
---@param commonData table 通用数据
function UIBrmEscortDartCarTemplate:AnalysisParams(commonData)
    if commonData == nil or commonData.configDartCarClass == nil then
        return false
    end
    ---@type ConfigDartCar
    self.configDartCarClass = commonData.configDartCarClass
    ---@type boolean
    self.haveOperationDartCar = ternary(commonData.haveOperationDartCar == nil,false,commonData.haveOperationDartCar)
    ---@type OperationDartCar
    self.operationDartCar = commonData.operationDartCar
    return true
end

---刷新镖车等级
function UIBrmEscortDartCarTemplate:RefreshDartCarName()
    if self.configDartCarClass ~= nil and self.configDartCarClass:GetBaiRiMenTbl() ~= nil then
        luaclass.UIRefresh:RefreshSprite(self.name_UISprite,self.configDartCarClass:GetBaiRiMenTbl():GetTitle())
    end
end

---刷新镖车模型
function UIBrmEscortDartCarTemplate:RefreshModel()
    if self.configDartCarClass ~= nil and self.configDartCarClass:GetBaiRiMenTbl() ~= nil then
        luaclass.UIRefresh:RefreshSprite(self.model_UISprite,self.configDartCarClass:GetBaiRiMenTbl():GetModelPicture())
    end
end

---刷新背景
function UIBrmEscortDartCarTemplate:RefreshBackGround()
    if self.configDartCarClass ~= nil and self.configDartCarClass:GetBaiRiMenTbl() ~= nil then
        luaclass.UIRefresh:RefreshEffect(self.backGround_CSUIEffectLoad,self.configDartCarClass:GetBaiRiMenTbl():GetBackground())
    end
end

---刷新奖励列表
function UIBrmEscortDartCarTemplate:RefreshAwardList()
    if self.configDartCarClass ~= nil and self.configDartCarClass:GetYaBiaoConfTbl() ~= nil then
        ---@type table<table<number,number>> 奖励列表
        local rewardList = clientTableManager.cfg_yabiaoManager:GetBaiRiMenRewardList(self.configDartCarClass:GetYaBiaoConfTbl():GetId())
        if type(rewardList) == 'table' then
            luaclass.UIRefresh:RefreshGridContainer(self.award_UIGridContainer,rewardList,function(grid,info)
                if CS.StaticUtility.IsNull(grid) == false and info.itemId ~= nil and info.count ~= nil then
                    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.itemId)
                    if itemInfo  == nil then
                        return
                    end
                    local temp = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIItem)
                    temp:RefreshUIWithItemInfo(itemInfo, info.count)
                    temp.showItemInfo = itemInfo
                end
            end)
            CS.CSListUpdateMgr.Add(100, nil, function()
                luaclass.UIRefresh:UIScrollviewReposition(self.dropList_UIScrollView)
            end, false)
        end
    end
end

---刷新前往按钮名字
function UIBrmEscortDartCarTemplate:RefreshGoBtnName()
    local npcInMainPlayerAround = gameMgr:GetPlayerDataMgr():GetBaiRiMenActivityMgr():GetActController_DartCar():AroundHaveYaBiaoNpc()
    local btnDes = ""
    if self.haveOperationDartCar then
        if self.operationDartCar ~= nil then
            ---有镖车同类型
            btnDes = luaEnumColorType.Gray ..  "镖车已生成"
        else
            ---有镖车不同类型
            btnDes = luaEnumColorType.Gray .. "其他镖车已生成"
        end
    else
        if npcInMainPlayerAround then
            ---无镖车靠近NPC
            btnDes = luaEnumColorType.Blue .. "生成镖车"
        else
            ---镖车没靠近NPC
            btnDes = luaEnumColorType.Blue .. "立即前往"
        end
    end
    luaclass.UIRefresh:RefreshLabel(self.goBtnName_UILabel,btnDes)
end

---刷新按钮背景图
function UIBrmEscortDartCarTemplate:RefreshBtnBackGround()
    local btnSpriteName = "anniu1"
    if self.haveOperationDartCar then
        btnSpriteName = "anniu26"
    end
    luaclass.UIRefresh:RefreshSprite(self.goBtnBackGround_UISprite,btnSpriteName)
end

---刷新花费列表
function UIBrmEscortDartCarTemplate:RefreshCostList()
    if self.configDartCarClass ~= nil and self.configDartCarClass:GetYaBiaoConfTbl() ~= nil then
        ---@type table<table<number,number>> 奖励列表
        local costList = clientTableManager.cfg_yabiaoManager:GetBaiRiMenCostList(self.configDartCarClass:GetYaBiaoConfTbl():GetId())
        if type(costList) == 'table' then
            luaclass.UIRefresh:RefreshGridContainer(self.cost_UIGridContainer, costList,function(grid, info)
                if CS.StaticUtility.IsNull(grid) == false and info.itemId ~= nil and info.count ~= nil then
                    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(info.itemId)
                    if itemInfo  == nil then
                        return
                    end
                    ---@type UIItem
                    local temp = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UIItem)
                    temp:RefreshUIWithItemInfo(itemInfo, info.count,nil,nil,true)
                    local numberColor = ternary(Utility.GetMaterialData(info.itemId):CheckMaterialIsEnough(info.itemId,info.count),luaEnumColorType.White,luaEnumColorType.Red)
                    luaclass.UIRefresh:RefreshLabel(temp:GetItemCount_UILabel(),numberColor .. tostring(info.count))
                    temp.showItemInfo = itemInfo
                end
            end)
            luaclass.UIRefresh:RefreshUITable(self.cost_UITable)
        end
    end
end
--endregion

return UIBrmEscortDartCarTemplate