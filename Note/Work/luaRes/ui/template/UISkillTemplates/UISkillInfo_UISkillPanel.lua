---@class UISkillInfo_UISkillPanel
local UISkillInfo_UISkillPanel = {}

function UISkillInfo_UISkillPanel:InitComponents()

    self.infoPanel_UIPanel = self:Get("infoPanel", "UIPanel")
    self.infoPanelGameObject = self:Get("infoPanel", "GameObject")
    ---技能信息列表
    self.skills = self:Get("UISkillColumn/Scroll View/skills", "Top_UIGridContainer")
    self.SkillPanel = uimanager:GetPanel('UISkillPanel')
    ---特效裁剪
    self.ClipArea = self:Get("UISkillColumn/Scroll View", "Top_OptimizeClipShaderScript")
    ---滑动框面板
    self.ScrollViewPanel = self:Get("UISkillColumn/Scroll View", "UIPanel")
    ---SpringPanel
    self.SpringPanel = self:Get("UISkillColumn/Scroll View", "SpringPanel")
    ---SpringPanel
    self.bg = self:Get("window/window2/bg", "Top_UISprite")
    ---mask
    self.infoPanelmask = self:Get("UISkillColumn/mask", "GameObject")
end

---@return UISkillInfoTemplate
function UISkillInfo_UISkillPanel:GetInfoPanel()
    if self.InfoPanel == nil then
        ---@type UISkillInfoTemplate
        self.InfoPanel = templatemanager.GetNewTemplate(self.infoPanelGameObject, luaComponentTemplates.UISkillInfoTemplate, self)
    end
    return self.InfoPanel
end

function UISkillInfo_UISkillPanel:InitOther()
    ---技能模板列表
    self.SkillTemplateList = {}
    ---技能模板有序列表
    self.SkillTemplate_orderList = {}
    ---技能是否学习
    self.IsStudy = false
    ---是否为第一次进入面板
    self.isInit = true;

    CS.UIEventListener.Get(self.infoPanelmask.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.infoPanelmask.gameObject).OnClickLuaDelegate = self.CloseSkillInfoPanel
    self.mOriginScrollPosition = self.ScrollViewPanel.gameObject.transform.localPosition;
end

function UISkillInfo_UISkillPanel:Init(ownerPanel)
    ---@type UISkillPanel
    self.mOwnerPanel = ownerPanel
    self:InitComponents()
    self:InitOther()
end

function UISkillInfo_UISkillPanel:RefreshUI(skillTemp)
    self:RefreshLeftSkillTemplate(skillTemp)
    self:SelectWithType()
end
function UISkillInfo_UISkillPanel:RefreshInfoPanel()
    if self.infoPanelGameObject.activeInHierarchy == true then
        self:GetInfoPanel():RefreshUI()
    end
end

function UISkillInfo_UISkillPanel:SelectWithType()
    local index = 0;
    if (self.isInit) then
        --region 检查是否有可学习的
        local isStudy = false;
        for k, v in pairs(self.SkillTemplate_orderList) do
            if (v.Btn_Learn ~= nil and v.UseSkillBookBtn ~= nil and v.Btn_Upgrade ~= nil) and
                    (not CS.StaticUtility.IsNull(v.Btn_Learn) and
                            not CS.StaticUtility.IsNull(v.UseSkillBookBtn) and
                            not CS.StaticUtility.IsNull(v.Btn_Upgrade.gameObject))
            then

                if (v.Btn_Learn.activeSelf) then
                    isStudy = true;
                    index = k - 1;
                    index = index > 0 and index or 0;
                    break ;
                end
            end
        end
        --endregion
        --region 如果没有可学习的就查找可操作的
        if (not isStudy) then
            for k, v in pairs(self.SkillTemplate_orderList) do
                if (v.Btn_Learn ~= nil and v.UseSkillBookBtn ~= nil and v.Btn_Upgrade ~= nil) and
                        (not CS.StaticUtility.IsNull(v.Btn_Learn) and
                                not CS.StaticUtility.IsNull(v.UseSkillBookBtn) and
                                not CS.StaticUtility.IsNull(v.Btn_Upgrade.gameObject))
                then

                    if (v.UseSkillBookBtn.activeSelf or v.Btn_Upgrade.gameObject.activeSelf) then
                        index = k - 1;
                        index = index > 0 and index or 0;
                        break ;
                    end
                end
            end
        end
        --endregion
        self.isInit = false
        local viewHeight = self.ScrollViewPanel:GetViewSize().y
        local viewCount = math.floor(viewHeight / self.skills.CellHeight);
        local intervalHeight = (math.floor(viewHeight / self.skills.CellHeight) - viewCount) * self.skills.CellHeight;
        if (viewCount < index) then
            local distance = (index - viewCount) * self.skills.CellHeight + intervalHeight + 12;
            local maxHeight = self.skills.MaxCount * self.skills.CellHeight;
            local interval = maxHeight - self.ScrollViewPanel.height;
            distance = distance > math.abs(interval) and interval or distance;

            self.SpringPanel.target = CS.UnityEngine.Vector3(self.mOriginScrollPosition.x, self.mOriginScrollPosition.y + distance, self.mOriginScrollPosition.z);
            self.SpringPanel.enabled = true;
        end
    end
end

---刷新左侧技能信息模板
function UISkillInfo_UISkillPanel:RefreshLeftSkillTemplate(skillTemp)
    if CS.StaticUtility.IsNull(self.skills) then
        return
    end
    local skill_List = self:GetShowInfo()
    self.skills.MaxCount = #skill_List
    for i = 1, #skill_List do
        local item = self.skills.controlList[i - 1].gameObject
        local template
        if self.SkillTemplateList[item] == nil then
            template = templatemanager.GetNewTemplate(item, skillTemp, self.ClipArea)
            self.SkillTemplateList[item] = template
        else
            template = self.SkillTemplateList[item]
        end
        self.SkillTemplate_orderList[i] = template
        if template.RefreshUI ~= nil then
            template:RefreshUI(skill_List[i], self.SkillInfoDic[skill_List[i]:GetId()], self, i - 1)
        end
    end
end

---得到显示需要的数据
function UISkillInfo_UISkillPanel:GetShowInfo()
    ---@type  table<number,TABLE.cfg_skills>
    self.skillList = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():GetCareerSkill()
    ---@type  table<number,LuaSkillDetailedInfo>
    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.skillList == nil then
        return
    end
    local skill_List = {};

    for i, v in pairs(self.skillList) do
        if v:GetCls() == 4 then
            if self.SkillInfoDic ~= nil then
                local nowskillInfo = self.SkillInfoDic[v:GetId()]
                if nowskillInfo then
                    table.insert(skill_List, v);
                elseif CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(v:GetId()) ~= nil then
                    table.insert(skill_List, v);
                end
            end
        else
            table.insert(skill_List, v);
        end
    end
    return skill_List
end

function UISkillInfo_UISkillPanel:GetBagPanel()
    local UIBagPanel = uimanager:GetPanel("UIBagPanel")
    if UIBagPanel ~= nil then
        self.bagPanel = CS.Utility_Lua.GetComponent(UIBagPanel.go, "Top_UIPanel")
    end
    return self.bagPanel
end

function UISkillInfo_UISkillPanel:SetInfoPanelDepth()
    local bagPanel = self:GetBagPanel()
    if bagPanel ~= nil then
        self.infoPanel_UIPanel.depth = bagPanel.depth + 10;
    end
end

---选择的技能
function UISkillInfo_UISkillPanel:FindSelectSkill(id, go)
    self:SetInfoPanelDepth()
    self:GetInfoPanel():OpenPanel(id, go)
end

---关闭技能信息面板
function UISkillInfo_UISkillPanel:CloseSkillInfoPanel()
    self:GetInfoPanel():ClosePanel()
end

return UISkillInfo_UISkillPanel