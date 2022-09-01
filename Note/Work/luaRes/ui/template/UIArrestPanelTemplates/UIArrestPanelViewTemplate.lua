---悬赏面板视图模板
local UIArrestPanelViewTemplate = {}

--region 初始化

function UIArrestPanelViewTemplate:Init()
    self:InitComponents()
    self:BindUIMessage()
    self:InitParameters()
end
--初始化变量
function UIArrestPanelViewTemplate:InitParameters()
    self.isWordArrestState = true
    self.id = 0
    self.promptInfo = {}
    self.allArrestTemplateDic = {}
    self.allArrestGODic = {}
    self.wordArrestTemplateDic = {}
    self.presonalArrestTemplateDic = {}
    self.origionScrollPos = self.arrestScrollView.transform.localPosition
    self.ClipParams = {
        --有按钮
        [true] = { center_x = 0, center_y = 0, size_x = 434, size_y = 466, posY = 32 },
        --无按钮
        [false] = { center_x = 0, center_y = 0, size_x = 434, size_y = 565, posY = -20 }
    }
    self.isInitLoop = true
    --self.oriegionV3 = self.ArrestInfoMiddle.transform.localPosition
end

function UIArrestPanelViewTemplate:InitComponents()
    ---@type UnityEngine.GameObject  发布悬赏
    self.btn_arrest = self:Get("events/btn_arrest", "GameObject")
    ---@type UnityEngine.GameObject  切换按钮
    self.btn_switch = self:Get("events/btn_switch", "GameObject")
    ---@type Top_UILabel  切换文本
    self.Label = self:Get("events/btn_switch/Label", "Top_UILabel")
    ---@type UnityEngine.GameObject  个人悬赏
    self.personal = self:Get("personal", "GameObject")
    ---@type UnityEngine.GameObject  全服悬赏
    self.world = self:Get("World", "GameObject")
    ---@type Top_UIGridContainer  个人悬赏列表
    --self.presonalPlayer = self:Get("personal/Scroll View/player", "Top_UIGridContainer")
    ---@type Top_UIGridContainer  全服悬赏列表
    --self.wordPlayer = self:Get("World/Scroll View/player", "Top_UIGridContainer")
    ---@type UILoopScrollViewPlus 所有悬赏
    self.ArrestInfoMiddle = self:Get("Scroll View/ArrestInfo", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject 全服
    self.Btn_mode1 = self:Get("events/btn_switch/Btn_mode1", "GameObject")
    ---@type UnityEngine.GameObject 全服高光
    self.Label1 = self:Get("events/btn_switch/Btn_mode1/Label2", "GameObject")
    ---@type UnityEngine.GameObject 个人
    self.Btn_mode2 = self:Get("events/btn_switch/Btn_mode2", "GameObject")
    ---@type UnityEngine.GameObject 个人高光
    self.Label2 = self:Get("events/btn_switch/Btn_mode2/Label2", "GameObject")
    ---@type UnityEngine.GameObject 无悬赏背景
    self.wards2 = self:Get("wards2", "GameObject")
    ---@type UIScrollView
    self.arrestScrollView = self:Get("Scroll View", "UIScrollView")
    ---@type SpringPanel
    self.arrestScrollSpring = self:Get("Scroll View", "SpringPanel")
    ---@type UIPanel
    self.arrestPanel = self:Get("Scroll View", "UIPanel")
end

function UIArrestPanelViewTemplate:BindUIMessage()
    --点击发布悬赏事件
    CS.UIEventListener.Get(self.btn_arrest).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_arrest).OnClickLuaDelegate = self.OnArrestBtnClick
    --[[    点击切换事件
        CS.UIEventListener.Get(self.btn_switch).LuaEventTable = self
        CS.UIEventListener.Get(self.btn_switch).OnClickLuaDelegate = self.OnSwitchBtnClick

        --点击个人切换事件
        CS.UIEventListener.Get(self.Btn_mode2).LuaEventTable = self
        CS.UIEventListener.Get(self.Btn_mode2).OnClickLuaDelegate = self.OnSwitchPresionBtnClick
        --点击全服切换事件
        CS.UIEventListener.Get(self.Btn_mode1).LuaEventTable = self
        CS.UIEventListener.Get(self.Btn_mode1).OnClickLuaDelegate = self.OnSwitchWordBtnClick]]
end

function UIArrestPanelViewTemplate:SetTemplate(customData)
    if customData then
        self.mapNpcId = customData.mapNpcId == nil and 0 or customData.mapNpcId
        self.promptInfo = {}
        self.promptInfo.mapNpcId = self.mapNpcId
        self.promptInfo.closeCallBack = function()
            if not CS.StaticUtility.IsNull(self.go) and not CS.StaticUtility.IsNull(self.btn_arrest) then
                self.btn_arrest:SetActive(true)
                self:RefreshPanelClip()
            end
        end
        self:RefreshPanelClip()
    end
end

--endregion

--region UI函数监听

--点击发布悬赏函数
function UIArrestPanelViewTemplate:OnArrestBtnClick(go)
    --弹出悬赏面板函数
    self.btn_arrest:SetActive(false)
    self:RefreshPanelClip()
    uimanager:CreatePanel("UIArrestPublishPromptPanel", nil, self.promptInfo)
    local dic = self.isWordArrestState and self.wordArrestTemplateDic or self.presonalArrestTemplateDic
    self:SetAllBtnShowState(dic)
end

--点击全服按钮函数
function UIArrestPanelViewTemplate:OnSwitchWordBtnClick(go)
    self.isWordArrestState = true
    self:ChangeState()
    --发送请求列表消息
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqOfferShareList(0, self.mapNpcId)
    else
        networkRequest.ReqOfferList(0, self.mapNpcId)
    end
end

--点击个人按钮函数
function UIArrestPanelViewTemplate:OnSwitchPresionBtnClick(go)
    self.isWordArrestState = false
    self:ChangeState()
    --发送请求列表消息
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        networkRequest.ReqOfferShareList(1, self.mapNpcId)
    else
        networkRequest.ReqOfferList(1, self.mapNpcId)
    end
end

--endregion

--region UI

---刷新悬赏列表（服务器响应）
function UIArrestPanelViewTemplate:RefreshGrid()
    --self.personal:SetActive(not self.isWordArrestState)
    --self.world:SetActive(self.isWordArrestState)
    self:RefreshAllArrestGrid()
    --self:RefreshPersonalGrid()
    --self:RefreshWordGrid()
end

---刷新个人悬赏
function UIArrestPanelViewTemplate:RefreshPersonalGrid()
    if self.isWordArrestState or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or self.presonalPlayer == nil then
        return
    end
    local presonalList = CS.CSScene.MainPlayerInfo.FriendInfoV2.ArrestDic[1]
    local length = presonalList.Count
    if length == 0 then
        self.presonalPlayer.MaxCount = 0
        return
    end
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    self.presonalPlayer.MaxCount = length
    local arrestTime = CS.CSScene.MainPlayerInfo.FriendInfoV2.ArrestTime
    for i = 0, length - 1 do
        local go = self.presonalPlayer.controlList[i].gameObject
        local template = self.presonalArrestTemplateDic[go] ~= nil and self.presonalArrestTemplateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIArrestPlayerPersonalUnitTemplate)
        local info = {}
        info.id = presonalList[i].prisoner
        info.spriteName = 'headicon' .. tostring(presonalList[i].prisonerSex) .. tostring(presonalList[i].prisonerCareer)
        info.name = presonalList[i].prisonerName
        info.compName = presonalList[i].finisherName
        info.level = presonalList[i].prisonerLevel
        info.index = i + 1
        info.day = presonalList[i].finishTime
        info.coinCount = presonalList[i].reward
        local remainTime = (arrestTime + presonalList[i].offerTime) - serverNowTime
        info.time = remainTime > 0 and remainTime or 0
        info.state = presonalList[i].state
        info.mapNpcId = self.mapNpcId
        info.clickCallBack = function()
            self:SetBtnShowState(self.presonalArrestTemplateDic, go)
        end
        template:SetTemplate(info)
        if self.presonalArrestTemplateDic[go] == nil then
            self.presonalArrestTemplateDic[go] = template
        end
    end
end

---刷新全服悬赏
function UIArrestPanelViewTemplate:RefreshWordGrid()
    if not self.isWordArrestState or CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or self.wordPlayer == nil then
        return
    end
    local wordList = CS.CSScene.MainPlayerInfo.FriendInfoV2.ArrestDic[0]
    local length = wordList.Count
    if length == 0 then
        self.presonalPlayer.MaxCount = 0
        return
    end
    local serverNowTime = CS.CSServerTime.Instance.TotalMillisecond
    local arrestTime = CS.CSScene.MainPlayerInfo.FriendInfoV2.ArrestTime
    self.wordPlayer.MaxCount = length
    for i = 0, length - 1 do
        local go = self.wordPlayer.controlList[i].gameObject
        local template = self.wordArrestTemplateDic[go] ~= nil and self.wordArrestTemplateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIArrestPlayerWordUnitTemplate)
        local info = {}
        info.id = wordList[i].prisoner
        info.spriteName = 'headicon' .. tostring(wordList[i].prisonerSex) .. tostring(wordList[i].prisonerCareer)
        info.name = wordList[i].prisonerName
        info.level = wordList[i].prisonerLevel
        info.index = i + 1
        info.coinCount = wordList[i].reward
        local remainTime = (arrestTime + wordList[i].offerTime) - serverNowTime
        info.time = remainTime ~= nil and remainTime > 0 and remainTime or 0
        info.state = wordList[i].state
        info.offerType = wordList[i].offerType
        info.clickCallBack = function()
            self:SetBtnShowState(self.wordArrestTemplateDic, go)
        end
        template:SetTemplate(info)
        if self.wordArrestTemplateDic[go] == nil then
            self.wordArrestTemplateDic[go] = template
        end
    end
end

---刷新所有悬赏
function UIArrestPanelViewTemplate:RefreshAllArrestGrid()

    if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.FriendInfoV2 == nil or self.ArrestInfoMiddle == nil or CS.StaticUtility.IsNull(self.ArrestInfoMiddle) then
        self.wards2:SetActive(true)
        return
    end
    self.allArrestGODic = {}
    self.allArrestList = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVOList
    if not self.isInitLoop then
        self:InitArrestMidele()
    else
        self.ArrestInfoMiddle:RefreshCurrentPage()
    end
    self.wards2:SetActive(self.allArrestList.Count == 0)
end

---刷新单个悬赏根据id
function UIArrestPanelViewTemplate:RefreshTemplateOfID(id)
    local arrestDic = CS.CSScene.MainPlayerInfo.FriendInfoV2.AllArrestVODic
    if self.allArrestGODic[id] ~= nil and (arrestDic ~= nil and arrestDic[id] ~= nil) and self.allArrestTemplateDic[self.allArrestGODic[id]] ~= nil then
        local go = self.allArrestGODic[id]
        local info = {}
        info.mapNpcId = self.mapNpcId
        info.data = arrestDic[id]
        info.clickCallBack = function()
            self:SetBtnShowState(self.allArrestTemplateDic, go)
        end
        self.allArrestTemplateDic[self.allArrestGODic[id]]:SetTemplate(info)
    end
end

function UIArrestPanelViewTemplate:RefreshAllArrestTemplate(go, line)
    if self.allArrestList == nil or go == nil or self.allArrestList.Count <= line then
        return false
    end
    local template = self.allArrestTemplateDic[go] ~= nil and self.allArrestTemplateDic[go] or templatemanager.GetNewTemplate(go, luaComponentTemplates.UIArrestUniversalUnitTemplate)
    local info = {}
    info.index = line + 1
    info.mapNpcId = self.mapNpcId
    info.data = self.allArrestList[line]
    info.clickCallBack = function()
        self:SetBtnShowState(self.allArrestTemplateDic, go)
    end
    template:SetTemplate(info)
    if self.allArrestTemplateDic[go] == nil then
        self.allArrestTemplateDic[go] = template
    end
    self.allArrestGODic[info.data.id] = go
    return true
end

function UIArrestPanelViewTemplate:SetPanelState(isOpen)
    self.go:SetActive(isOpen)
    if isOpen then
        if luaclass.RemoteHostDataClass:IsKuaFuMap() then
            networkRequest.ReqOfferShareList(nil, self.mapNpcId)
        else
            networkRequest.ReqOfferList(nil, self.mapNpcId)--self.isWordArrestState and 0 or 1
        end
    end
    self:ChangeState()
end

function UIArrestPanelViewTemplate:ChangeState()
    --self.Label2:SetActive(not self.isWordArrestState)
    --self.Label1:SetActive(self.isWordArrestState)
end

--endregion

--region otherFunction
--刷新按钮列表
function UIArrestPanelViewTemplate:SetBtnShowState(dic, go)
    if dic == nil then
        return
    end
    for i, v in pairs(dic) do
        v:SetShowTemplate(i == go)
    end
end

function UIArrestPanelViewTemplate:SetAllBtnShowState(dic)
    for i, v in pairs(dic) do
        v:SetShowTemplate(false)
    end
end

function UIArrestPanelViewTemplate:RefreshPanelClip()
    local key = self.btn_arrest ~= nil and not CS.StaticUtility.IsNull(self.btn_arrest) and self.btn_arrest.gameObject.activeSelf
    self.arrestScrollSpring.enabled = false
    self.arrestPanel:SetRect(self.ClipParams[key].center_x, self.ClipParams[key].center_y, self.ClipParams[key].size_x, self.ClipParams[key].size_y)
    self:InitArrestMidele()
    self.arrestScrollView.transform.localPosition = { x = self.origionScrollPos.x, y = self.ClipParams[key].posY, z = 0 }
    --self.arrestScrollView:ResetPosition()
    --if self.ArrestInfoMiddle ~= nil and not CS.StaticUtility.IsNull(self.ArrestInfoMiddle) and self.oriegionV3 ~= nil then
    --    self.ArrestInfoMiddle.transform.localPosition = CS.UnityEngine.Vector3(self.oriegionV3.x, self.ClipParams[key].center_y, self.oriegionV3.z)
    --end

end

function UIArrestPanelViewTemplate:InitArrestMidele()
    self.isInitLoop = true
    self.ArrestInfoMiddle:Init(function(go, line)
        return self:RefreshAllArrestTemplate(go, line)
    end)
end

--endregion

return UIArrestPanelViewTemplate