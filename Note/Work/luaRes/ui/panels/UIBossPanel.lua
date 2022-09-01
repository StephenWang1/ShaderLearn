---@class UIBossPanel:UIBase Boss面板
local UIBossPanel = {}

--region 局部变量

--endregion

--region 初始化

function UIBossPanel:Init()
    self:InitComponents()
    UIBossPanel.InitParameters()
    UIBossPanel.BindUIEvents()
    UIBossPanel.BindNetMessage()
    UIBossPanel.BindLuaClientMessage()
    UIBossPanel.RegisterBossRedPoint()
    UIBossPanel.RegisterBossTemplates()
end

--- 初始化变量
function UIBossPanel.InitParameters()
    ---当前选中页签类型
    ---@type number
    UIBossPanel.mSelectType = nil

    UIBossPanel.selectData = nil

    ---@type number
    ---需要选中的怪物id
    UIBossPanel.mTargetMonsterId = nil

    UIBossPanel.HasInitBossScore = false
    UIBossPanel.mInitialized = false
    ---所有boss视图模板字典 <number,class>
    UIBossPanel.allBossViewTemplateDic = {}
    ---所有主页签高亮集合 <number,gameObject>
    UIBossPanel.allPageCheckMarkDic = {}
    ---@type table <UnityEngine.GameObject,TemplateBase> <go,TemplateBase>
    UIBossPanel.allBossUnitTempateDic = {}
end

--- 初始化组件
function UIBossPanel:InitComponents()
    ---@type UnityEngine.GameObject 关闭按钮
    UIBossPanel.mCloseBtn_GameObject = self:GetCurComp("WidgetRoot/window2/btn_close", "GameObject")
    ---@type UIGridContainer 主页签
    UIBossPanel.MainBookMarkList = self:GetCurComp("WidgetRoot/events/ScrollView/MainBookMarkList", "UIGridContainer")
    ---@type UnityEngine.GameObject 左侧视图
    UIBossPanel.leftAll = self:GetCurComp("WidgetRoot/window2/leftAll", "GameObject")
    ---@type TweenAlpha  alpha的tween组件
    UIBossPanel.mScrollTweenAlpha = self:GetCurComp("WidgetRoot/view/scroll", "TweenAlpha")
    ---@type UnityEngine.GameObject boss积分
    UIBossPanel.mBossScoreRoot = self:GetCurComp("WidgetRoot/view/view_bossIntegral", "GameObject")
    ---@type UnityEngine.GameObject normal节点
    UIBossPanel.mBossNormalRoot = self:GetCurComp("WidgetRoot/view/Normal", "GameObject")
    ---@type UnityEngine.GameObject 魔之boss节点
    UIBossPanel.mBossMZRoot = self:GetCurComp("WidgetRoot/view/Mz", "GameObject")
    ---@type UnityEngine.GameObject 终极boss节点
    UIBossPanel.mBossFinalRoot = self:GetCurComp("WidgetRoot/view/FinalBoss", "GameObject")
    ---@type UnityEngine.GameObject 个人boss节点
    UIBossPanel.mBossMineRoot = self:GetCurComp("WidgetRoot/view/MineBoss", "GameObject")
    ---@type UnityEngine.GameObject 生肖boss节点
    UIBossPanel.mBossSxRoot = self:GetCurComp("WidgetRoot/view/SxBoss", "GameObject")
end

function UIBossPanel.BindUIEvents()
    CS.UIEventListener.Get(UIBossPanel.mCloseBtn_GameObject).onClick = UIBossPanel.OnClickCloseBtnCallBack
end

function UIBossPanel.BindNetMessage()
    UIBossPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBossScoreMessage, UIBossPanel.OnResBossScoreMessage)
    UIBossPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResFieldBossOpenMessage, UIBossPanel.OnResBossInfoMessage)
    UIBossPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIBossPanel.OnResBagItemChanged)
    UIBossPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.FinalBossTimesChange, function()
        if UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.FinalBoss] ~= nil then
            UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.FinalBoss]:RefreshKillDes()
        end
    end)
end

function UIBossPanel.BindLuaClientMessage()
    UIBossPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.RefreshMagicBossTime, function()
        if UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DemonBoss] ~= nil then
            UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DemonBoss]:RefreshMagicBossView()
        end
    end)
    UIBossPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        local magicBossTemplate = UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DemonBoss]
        if magicBossTemplate ~= nil and magicBossTemplate.RefreshAddBtn ~= nil then
            magicBossTemplate:RefreshAddBtn()
        end
    end)
end
---注册boss视图模板
---@private
function UIBossPanel.RegisterBossTemplates()
    ----左侧页签视图
    UIBossPanel.leftPageViewTemplate = templatemanager.GetNewTemplate(UIBossPanel.leftAll, luaComponentTemplates.UIBossPanel_LeftPageTemplate)
    --- 野外boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.WorldBoss] = templatemanager.GetNewTemplate(UIBossPanel.mBossNormalRoot, luaComponentTemplates.UIBossPanel_NormalViewTemplate)
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.WorldBoss]:InitTemplate({ bossType = LuaEnumBossType.WorldBoss })
    --- 暗之boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DarkBoss] = templatemanager.GetNewTemplate(UIBossPanel.mBossNormalRoot, luaComponentTemplates.UIBossPanel_NormalViewTemplate)
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DarkBoss]:InitTemplate({ bossType = LuaEnumBossType.DarkBoss })
    --- 生肖boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.ZodiacBOSS] = templatemanager.GetNewTemplate(UIBossPanel.mBossSxRoot, luaComponentTemplates.UIBossPanel_ShengXiaoViewTemplate)
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.ZodiacBOSS]:InitTemplate({ bossType = LuaEnumBossType.ZodiacBOSS })
    --- 魔之boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DemonBoss] = templatemanager.GetNewTemplate(UIBossPanel.mBossMZRoot, luaComponentTemplates.UIBossPanel_MagicBossViewTemplate)
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.DemonBoss]:InitTemplate({ bossType = LuaEnumBossType.DemonBoss })
    --- 终极boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.FinalBoss] = templatemanager.GetNewTemplate(UIBossPanel.mBossFinalRoot, luaComponentTemplates.UIBossPanel_NewFinalViewTemplate)
    if UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.FinalBoss] ~= nil then
        UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.FinalBoss]:InitTemplate({ bossType = LuaEnumBossType.FinalBoss })
    end
    --- boss积分
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.BossScore] = templatemanager.GetNewTemplate(UIBossPanel.mBossScoreRoot, luaComponentTemplates.UIBossPanel_BossScoreViewTemplate)
    --- 个人boss
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.PersonalBoss] = templatemanager.GetNewTemplate(UIBossPanel.mBossMineRoot, luaComponentTemplates.UIBossPanel_PersonalViewTemplate)
    UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.PersonalBoss]:InitTemplate({ bossType = LuaEnumBossType.PersonalBoss })
end

---注册boss页签红点
---@private
function UIBossPanel.RegisterBossRedPoint()
    UIBossPanel.allPageRedPointDic = {
        --[LuaEnumBossType.FinalBoss] = {gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_God),Utility.EnumToInt(CS.RedPointKey.BOSS_ANCIENT)},
        --[LuaEnumBossType.FinalBoss] = {Utility.EnumToInt(CS.RedPointKey.BOSS_ANCIENT)},
        [LuaEnumBossType.BossScore] = Utility.EnumToInt(CS.RedPointKey.BOSS_SCORE),
        [LuaEnumBossType.DemonBoss] = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.BOSS_Demon),
        [LuaEnumBossType.PersonalBoss] = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_Persional),
        [LuaEnumBossType.ZodiacBOSS] = gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Boss_ShengXiao),
    }
end

---@param customData BossPanelData
---targetMonsterId:需要选中怪物id，会自动跳转并选中该行怪物
---type 打开界面默认类型
---mTaskMonsterId 任务怪物id （没研究过不知道怎么用）
---@alias BossPanelData{targetMonsterId:number,type:LuaEnumBossType,mTaskMonsterId:number,subType:number}
function UIBossPanel:Show(customData)
    if (customData == nil) then
        customData = {}
    end

    ---需要默认选中的页签类型
    if customData.type ~= nil and UIBossPanel.IsShowMainCheckMark(customData.type) then
        if customData.type == 3 or customData.type == 6 then
            --策划说的特殊处理，类型为3/6的按2处理
            customData.type = 2
        end
        self.mSelectType = customData.type
    end

    self.defaultChooseSubType = customData.subType

    ---如果传了targetMonsterId可以不传上面的页签类型
    if (customData.targetMonsterId ~= nil) then
        self.mTargetMonsterId = customData.targetMonsterId
        ---获取主类型
        local monsterInfo = self:CacheMonsterData(self.mTargetMonsterId)
        if monsterInfo then
            local type = self:GetBossPos(1, monsterInfo.bossPosition)
            if type == 3 or type == 6 then
                --策划说的特殊处理，类型为3/6的按2处理
                type = 2
            end
            if type then
                self.mSelectType = type
            end
        end
    end

    if (customData.taskMonsterId ~= nil) then
        UIBossPanel.mTaskMonsterId = customData.taskMonsterId

    end

    UIBossPanel.InitUI()
end

--endregion

--region 函数监听

---点击关闭按钮
---@private
function UIBossPanel.OnClickCloseBtnCallBack(go)
    uimanager:ClosePanel("UIBossPanel")
end

---点击页签切换
---@private
function UIBossPanel.OnClickMainCheckMarkCallBack(type)
    if not UIBossPanel.mInitialized then
        UIBossPanel.mInitialized = true
    else
        if type == UIBossPanel.mSelectType then
            return
        end
    end
    ---页签处理
    local checkMarkGo = UIBossPanel.allPageCheckMarkDic[UIBossPanel.mSelectType]
    if checkMarkGo ~= nil and not CS.StaticUtility.IsNull(checkMarkGo) then
        checkMarkGo:SetActive(false)
    end
    checkMarkGo = UIBossPanel.allPageCheckMarkDic[type]
    if checkMarkGo ~= nil and not CS.StaticUtility.IsNull(checkMarkGo) then
        checkMarkGo:SetActive(true)
    end

    ---视图处理
    local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
    if viewTemplate then
        viewTemplate:SetViewState(false)
    end

    viewTemplate = UIBossPanel.allBossViewTemplateDic[type]
    if viewTemplate then
        viewTemplate:SetViewState(true)
        if UIBossPanel.leftAll ~= nil and not CS.StaticUtility.IsNull(UIBossPanel.leftAll.gameObject) then
            local showLeftPage = viewTemplate:IsShowLeftPageView()
            UIBossPanel.leftAll.gameObject:SetActive(showLeftPage)
            if showLeftPage == false then
                UIBossPanel.leftPageViewTemplate:ResetData()
            end
        end
    else
        if UIBossPanel.leftAll ~= nil and not CS.StaticUtility.IsNull(UIBossPanel.leftAll.gameObject) then
            UIBossPanel.leftAll.gameObject:SetActive(false)
        end
    end
    UIBossPanel.mSelectType = type

    networkRequest.ReqFieldBossOpen(type)
end


function UIBossPanel.WenHaoClick()
    local data = {}
    data.id = 249
    Utility.ShowHelpPanel(data)
end
--endregion

--region 网络消息处理

---请求boss列表信息响应
function UIBossPanel.OnResBossInfoMessage(id, data)
    if UIBossPanel.mSelectType == nil or UIBossPanel.mSelectType == LuaEnumBossType.BossScore then
        return
    end
    local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
    if viewTemplate then
        viewTemplate:OnResBossInfoMessageCallBack(data, UIBossPanel.mTargetMonsterId)
    end
    UIBossPanel:ChooseAimBookMark()
end

---boss积分消息回调
function UIBossPanel.OnResBossScoreMessage(id, data)
    if UIBossPanel.mSelectType ~= LuaEnumBossType.BossScore then
        return
    end
    if UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.BossScore] ~= nil then
        UIBossPanel.allBossViewTemplateDic[LuaEnumBossType.BossScore]:OnResBossScore()
    end
end
---背包变动
function UIBossPanel.OnResBagItemChanged()
    if UIBossPanel.mSelectType == nil or UIBossPanel.mSelectType == LuaEnumBossType.BossScore then
        return
    end
    local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
    if viewTemplate then
        viewTemplate:RefreshView()
    end
end

--endregion

--region UI
function UIBossPanel.InitUI()
    UIBossPanel.InitMainCheckMark()
end

---初始化页签
function UIBossPanel.InitMainCheckMark()
    local pages = LuaGlobalTableDeal.GetBossAllPageInfoList()
    local count = 0
    UIBossPanel.MainBookMarkList.MaxCount = 0
    for i = 1, #pages do
        if UIBossPanel.IsShowMainCheckMark(tonumber(pages[i][1])) then
            count = count + 1
            UIBossPanel.MainBookMarkList.MaxCount = count
            if count == 1 then
                if UIBossPanel.mSelectType == nil then
                    UIBossPanel.mSelectType = tonumber(pages[i][1])
                end
            end
            local go = UIBossPanel.MainBookMarkList.controlList[count - 1]
            if go then

                local checkMark = CS.Utility_Lua.GetComponent(go.transform:Find("Checkmark"), "GameObject")
                local checkMarkLabel = CS.Utility_Lua.GetComponent(go.transform:Find("Checkmark/label"), "Top_UILabel")
                local originLabel = CS.Utility_Lua.GetComponent(go.transform:Find("bg/label"), "Top_UILabel")
                local redPoint = CS.Utility_Lua.GetComponent(go.transform:Find("redPoint"), "Top_UIRedPoint")

                originLabel.text = pages[i][2]
                checkMarkLabel.text = pages[i][2]

                checkMark:SetActive(tonumber(pages[i][1]) == UIBossPanel.mSelectType)
                UIBossPanel.allPageCheckMarkDic[tonumber(pages[i][1])] = checkMark
                if redPoint then
                    redPoint:RemoveRedPointKey()
                    local redPointKey = UIBossPanel.allPageRedPointDic[tonumber(pages[i][1])]
                    if redPointKey ~= nil then
                        if type(redPointKey) == 'number' then
                            redPoint:AddRedPointKey(redPointKey)
                        elseif type(redPointKey) == 'table' then
                            for k, v in pairs(redPointKey) do
                                redPoint:AddRedPointKey(v)
                            end
                        end
                    end
                end
                CS.UIEventListener.Get(go).onClick = function(go)
                    local pageType = tonumber(pages[i][1])
                    --if pageType == LuaEnumBossType.DemonBoss then
                    --    gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(false)
                    --end
                    UIBossPanel.OnClickMainCheckMarkCallBack(tonumber(pages[i][1]))
                end
            end
        end
    end

    UIBossPanel.OnClickMainCheckMarkCallBack(UIBossPanel.mSelectType)

end

---选择默认子页签
---@return number 获取默认选择的子页签id
function UIBossPanel:GetDefaultChooseSubtype()
    local defaultChooseSubType = self.defaultChooseSubType
    self.defaultChooseSubType = nil
    return defaultChooseSubType
end
--endregion

--region otherFunction

---主页签是否显示
---@private
function UIBossPanel.IsShowMainCheckMark(type)
    if type == LuaEnumBossType.FinalBoss then
        return CS.CSSystemController.Sington:CheckSystem(33)
    elseif type == LuaEnumBossType.WorldBoss then
        return CS.CSSystemController.Sington:CheckSystem(32)
    elseif type == LuaEnumBossType.EliteBoss then
        return CS.CSSystemController.Sington:CheckSystem(31)
    elseif type == LuaEnumBossType.DarkBoss then
        return CS.CSSystemController.Sington:CheckSystem(48)
    elseif type == LuaEnumBossType.DemonBoss then
        return CS.CSSystemController.Sington:CheckSystem(47)
    elseif type == LuaEnumBossType.ZodiacBOSS then
        return CS.CSSystemController.Sington:CheckSystem(49)
    elseif type == LuaEnumBossType.BossScore then
        return CS.Cfg_GlobalTableManager.Instance:IsCanShowBossScorePage()
    elseif type == LuaEnumBossType.PersonalBoss then
        return CS.CSSystemController.Sington:CheckSystem(78)
    end
    return true
end

--endregion

--region ondestroy

function ondestroy()

end

--endregion

--region 设置页签选中
function UIBossPanel:ChooseAimBookMark()
    if self.mTargetMonsterId then
        local monsterInfo = self:CacheMonsterData(self.mTargetMonsterId)
        if monsterInfo then
            local subType = self:GetBossPos(2, monsterInfo.bossPosition)
            ---@type UIBossPanel_NormalViewTemplate
            local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
            if viewTemplate:GetLeftPageTemplate() then
                viewTemplate:GetLeftPageTemplate():ChooseSubTypeBookMark(subType)
                viewTemplate:ChooseItem(self.mTargetMonsterId)
                self.mTargetMonsterId = nil
            end
        end
    end
end

---设置子页签
---@param selectType number 选择的子页签
---@param selectMonsterId number 选择的怪物id
function UIBossPanel:ChooseSubtypePageOrMonster(selectType, selectMonsterId)
    ---@type UIBossPanel_NormalViewTemplate
    local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
    if viewTemplate:GetLeftPageTemplate() then
        if selectType ~= nil then
            viewTemplate:GetLeftPageTemplate():ChooseSubTypeBookMark(selectType)
        end
        if selectMonsterId ~= nil then
            viewTemplate:ChooseItem(selectMonsterId)
        end
    end
end
--endregion

--region 缓存数据
---@return TABLE.CFG_MONSTERS 怪物表
function UIBossPanel:CacheMonsterData(id)
    if self.mMonsterIdToInfo == nil then
        self.mMonsterIdToInfo = {}
    end
    local info = self.mMonsterIdToInfo[id]
    if info == nil then
        info = clientTableManager.cfg_monstersManager:TryGetValue(id)
        self.mMonsterIdToInfo[id] = info
    end
    return info
end

---@param type number 主页签类型1/副页签类型2
---@param bossPosition TABLE.IntListJingHao CFG_MONSTERS/bossPosition
---@return number 页签类型
function UIBossPanel:GetBossPos(type, bossPosition)
    if type and bossPosition then
        if bossPosition.list and #bossPosition.list >= 2 then
            if type == 1 then
                return bossPosition.list[1]
            elseif type == 2 then
                return bossPosition.list[2]
            end
        end
    end
end

--endregion

--region 扫荡
---刷新boss列表扫荡信息
function UIBossPanel:RefreshBossListClear()
    ---@type UIBossPanel_BaseViewTemplate
    local viewTemplate = UIBossPanel.allBossViewTemplateDic[UIBossPanel.mSelectType]
    if viewTemplate ~= nil then
        viewTemplate:RefreshBossListClear()
    end
end
--endregion

return UIBossPanel