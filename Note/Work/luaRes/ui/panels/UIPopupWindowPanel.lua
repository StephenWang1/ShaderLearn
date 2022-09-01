---点击icon弹出按钮集合
local UIPopupWindowPanel = {}

--region 局部变量
UIPopupWindowPanel.btnBackGroundHeight = 20
UIPopupWindowPanel.btnSpaceHeight = 5
UIPopupWindowPanel.type = 1
UIPopupWindowPanel.btnType = 1
UIPopupWindowPanel.data = nil
--endregion

--region 初始化

function UIPopupWindowPanel:Init()
    self:InitComponents()
    UIPopupWindowPanel.BindUIEvents()
    UIPopupWindowPanel.BindNetEvents()
    UIPopupWindowPanel.InitParameters()
    UIPopupWindowPanel:AddCollider()
end

--- 初始化组件
function UIPopupWindowPanel:InitComponents()
    ---@type Top_UIGridContainer 按钮合集
    UIPopupWindowPanel.Grid = self:GetCurComp("WidgetRoot/Grid", "Top_UIGridContainer")
    ---@type Top_UISprite 背景
    UIPopupWindowPanel.bg = self:GetCurComp("WidgetRoot/bg", "Top_UISprite")
end

function UIPopupWindowPanel.InitParameters()
    UIPopupWindowPanel.btnSpaceHeight = UIPopupWindowPanel.Grid.CellHeight
    local go = UIPopupWindowPanel.Grid.controlTemplate
    if go then
        local sprite = CS.Utility_Lua.GetComponent(UIPopupWindowPanel.Grid.controlTemplate.transform:Find('chakan/ditiao'), 'Top_UISprite')
        UIPopupWindowPanel.btnBackGroundHeight = sprite.height
        UIPopupWindowPanel.btnSpaceHeight = UIPopupWindowPanel.btnSpaceHeight - UIPopupWindowPanel.btnBackGroundHeight
    end
    _, UIPopupWindowPanel.mSendFlowerTipsInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(16)
end

function UIPopupWindowPanel.BindUIEvents()

end

function UIPopupWindowPanel.BindNetEvents()
    UIPopupWindowPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResOtherRoleInfoMessage, UIPopupWindowPanel.OnResOtherRoleInfoMessageReceived)
end


--endregion

--region 函数监听

function UIPopupWindowPanel.OnBtnTypeClick(go)
    if UIPopupWindowPanel.btnType == 0 then
        local id = UIPopupWindowPanel.data.id == nil and UIPopupWindowPanel.data.rid or UIPopupWindowPanel.data.id
        networkRequest.ReqOtherRoleInfo(id)
        --送花
    elseif UIPopupWindowPanel.btnType == 101 then
        UIPopupWindowPanel.OnClickFlowers()
        --追踪
    elseif UIPopupWindowPanel.btnType == 102 then
        networkRequest.ReqLastEnemyPosition(UIPopupWindowPanel.data.id)
    end
end

--endregion

--region 消息监听
function UIPopupWindowPanel.OnResOtherRoleInfoMessageReceived(msgID, data, csData)
    local customData = {}
    if data then
        local player = CS.CSScene.Sington:getAvatar(data.roleId)

        ---region 特殊装备列表
        if (data.extraEquipList ~= nil) then
            customData.ExtraEquipList = data.extraEquipList;
        end
        --endregion

        if player ~= nil then
            customData.avatarInfo = player.BaseInfo
        else
            if data.roleId then
                --如果是离线玩家
                local ESex = {};
                ESex[LuaEnumSex.WoMan] = CS.ESex.WoMan
                ESex[LuaEnumSex.Man] = CS.ESex.Man
                ESex[LuaEnumSex.Common] = CS.ESex.Common;

                local ECareer = {};
                ECareer[LuaEnumCareer.Common] = CS.ECareer.Common;
                ECareer[LuaEnumCareer.Taoist] = CS.ECareer.Taoist;
                ECareer[LuaEnumCareer.Master] = CS.ECareer.Master;
                ECareer[LuaEnumCareer.Warrior] = CS.ECareer.Warrior;
                ECareer[LuaEnumCareer.Assassin] = CS.ECareer.Assassin;
                ECareer[LuaEnumCareer.CunMin] = CS.ECareer.CunMin;
                local avatarInfo = {};
                avatarInfo.Name = data.roleName;
                avatarInfo.UIUnionName = data.unionName
                avatarInfo.Sex = ESex[data.sex];
                avatarInfo.Career = ECareer[data.career];
                if data.armor and data.armor ~= 0 then
                    avatarInfo.BodyModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.armor).model.list[0]
                else
                    avatarInfo.BodyModel = data.armor
                end
                if data.weapon and data.weapon ~= 0 then
                    avatarInfo.Weapon = CS.Cfg_ItemsTableManager.Instance:GetItems(data.weapon).model.list[0]
                else
                    avatarInfo.Weapon = data.weapon
                end
                if data.helmet and data.helmet ~= 0 then
                    avatarInfo.Hair = 301000
                    local hairModel = CS.Cfg_ItemsTableManager.Instance:GetItems(data.helmet).model
                    if hairModel.list ~= nil and hairModel.list.Count == 1 then
                        avatarInfo.Hair = hairModel.list[0]
                    elseif hairModel.list ~= nil and hairModel.list.Count == 2 then
                        avatarInfo.Hair = hairModel.list[data.sex - 1]
                    end
                else
                    avatarInfo.Hair = data.helmet
                end
                if data.face and data.face ~= 0 then
                    avatarInfo.Face = data.face
                else
                    avatarInfo.Face = 0
                end
                avatarInfo.GetWeaponModelID = function(info)
                    if info == nil or info.Weapon == nil then
                        return 0
                    end
                    return info.Weapon
                end
                avatarInfo.GetBodyModelID = function(info)
                    if info == nil or info.BodyModel == nil then
                        return 0
                    end
                    return info.BodyModel
                end
                avatarInfo.GetHairModelID = function(info)
                    if info == nil or info.Hair == nil then
                        return 0
                    end
                    return info.Hair
                end
                avatarInfo.GetFaceModelID = function(info)
                    if info == nil or info.Face == nil then
                        return 0
                    end
                    return info.Face
                end
                customData.avatarInfo = avatarInfo;
            else
                customData.avatarInfo = nil
            end
        end
    else
        customData.avatarInfo = nil
    end
    local equipInfo = {}
    if csData.equipList and csData.equipList.Count > 0 then
        for i = 0, csData.equipList.Count - 1 do
            equipInfo[csData.equipList[i].index] = csData.equipList[i]
        end
    end
    customData.equipInfo = equipInfo;
    customData.equipShowTemplate = luaComponentTemplates.UIRolePanel_EquipTemplateOtherPlayer
    customData.equipItemTemplate = luaComponentTemplates.UIRolePanel_GridTemplateOtherPlayer
    if customData.avatarInfo then
        uimanager:CreatePanel("UIRolePanel", nil, customData)
    end
    uimanager:ClosePanel('UIPopupWindowPanel')
end
--endregion

--region UI

function UIPopupWindowPanel:Show(info)
    if info then
        UIPopupWindowPanel.type = info.panelType
        UIPopupWindowPanel.data = info.data
    end
    UIPopupWindowPanel.InitGrid()
end

function UIPopupWindowPanel.InitGrid()
    local btnDic = CS.Cfg_GlobalTableManager.CfgInstance.ArrestTrackDic
    if btnDic.Count == 0 then
        return
    end
    local btnsInfo = btnDic[UIPopupWindowPanel.type]
    if btnsInfo == nil or btnsInfo.Length == 0 then
        return
    end
    UIPopupWindowPanel.Grid.MaxCount = btnsInfo.Length
    UIPopupWindowPanel.BgAdaptiveOfItemCount(btnsInfo.Length)
    for i = 0, btnsInfo.Length - 1 do
        local go = UIPopupWindowPanel.Grid.controlList[i].gameObject
        if go then
            local strs = string.Split(btnsInfo[i], '#')
            local label = CS.Utility_Lua.GetComponent(go.transform:Find('chakan'), "Top_UILabel")
            if label then
                label.text = strs[2]
            end
            CS.UIEventListener.Get(go).onClick = nil
            CS.UIEventListener.Get(go).onClick = function(go)
                UIPopupWindowPanel.btnType = tonumber(strs[3])
                UIPopupWindowPanel.OnBtnTypeClick(go)
            end
        end
    end
end

---背景自适应
function UIPopupWindowPanel.BgAdaptiveOfItemCount(count)
    local titleSpace = 10
    local totalHeight = titleSpace * 2 + UIPopupWindowPanel.btnSpaceHeight * (count - 1) + UIPopupWindowPanel.btnBackGroundHeight * count
    UIPopupWindowPanel.bg.height = totalHeight
end
--endregion

--region送花
---点击送花
function UIPopupWindowPanel.OnClickFlowers()
    local mainPlayerInfoSex = CS.CSScene.MainPlayerInfo.Sex
    local hasFlower = UIPopupWindowPanel.GetHasFlower(mainPlayerInfoSex == UIPopupWindowPanel.data.roleSex)
    if hasFlower then
        UIPopupWindowPanel.SendFlower(UIPopupWindowPanel.data.sex, UIPopupWindowPanel.data.rid, UIPopupWindowPanel.data.name)
    else
        UIPopupWindowPanel.FlowerNotEnough()
    end
    uimanager:ClosePanel('UIPopupWindowPanel')
end

---创建送花界面
function UIPopupWindowPanel.SendFlower(sex, rid, name)
    local customData = {}
    customData.sex = sex
    customData.rid = rid
    customData.name = name
    uimanager:CreatePanel("UISendFlowerPanel", nil, customData)
end

---花朵不足二次弹窗
function UIPopupWindowPanel.FlowerNotEnough()
    if UIPopupWindowPanel.mSendFlowerTipsInfo then
        local TipsInfo = {
            Title = UIPopupWindowPanel.mSendFlowerTipsInfo.title,
            LeftDescription = UIPopupWindowPanel.mSendFlowerTipsInfo.leftButton,
            RightDescription = UIPopupWindowPanel.mSendFlowerTipsInfo.rightButton,
            Content = UIPopupWindowPanel.mSendFlowerTipsInfo.des,
            ID = UIPopupWindowPanel.mSendFlowerTipsInfo.id,
            CallBack = function()
                uimanager:ClosePanel("UIPopupWindowPanel")
                uimanager:CreatePanel("UIShopPanel")
            end
        }
        uimanager:CreatePanel("UIPromptPanel", nil, TipsInfo)
    else
        --读表失败直接关闭Tips
        uimanager:ClosePanel("UIPopupWindowPanel")
    end
end

---获取背包是否有花
function UIPopupWindowPanel.GetHasFlower(sameSex)
    local hasFlower1 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.FirstGoldOrchid, LuaEnumFlowerType.FirstRose))
    if hasFlower1 then
        return true
    end
    local hasFlower2 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.SecondGoldOrchid, LuaEnumFlowerType.SecondRose))
    if hasFlower2 then
        return true
    end
    local hasFlower3 = CS.CSScene.MainPlayerInfo.BagInfo:IsContainByItemId(ternary(sameSex, LuaEnumFlowerType.ThirdGoldOrchid, LuaEnumFlowerType.ThirdRose))
    if hasFlower3 then
        return true
    end
    return false
end
--endregion

--region ondestroy

function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResOtherRoleInfoMessage, UIPopupWindowPanel.OnResOtherRoleInfoMessageReceived)
end

--endregion

return UIPopupWindowPanel