local UISkillTemplate_UISkillPanel = {}

function UISkillTemplate_UISkillPanel:GetSkillIcon_TweenAlpha()
    if (self.mSkillIcon_TweenAlpha == nil) then
        self.mSkillIcon_TweenAlpha = self:Get("skillIcon", "TweenAlpha");
    end
    return self.mSkillIcon_TweenAlpha;
end

function UISkillTemplate_UISkillPanel:InitComponents()
    ---背景图片
    self.frame = self:Get("background/frame", "GameObject")
    ---Icon背景图片Tween组件
    ---@type TweenScale
    self.frameTween = self:Get("frame", "TweenScale")
    ---技能图片
    self.skillIcon = self:Get("skillIcon", "Top_UISprite")
    ---技能特效节点
    self.skillIconEffectNode = self:Get("skillIcon/effect", "Transform")
    self.skillIcon_GameObject = self:Get("skillIcon", "GameObject")
    ---名称
    self.skillName = self:Get("skillName", "Top_UILabel")
    ---等级
    self.skillLevel = self:Get("skillLevel", "Top_UILabel")
    ---经验条
    self.skillExpStripe = self:Get("skillExpStripe", "GameObject")
    ---UITable
    self.skillExpSprite_UITable = self:Get("skillExpStripe", "Top_UITable")
    ---经验数值
    self.Label = self:Get("skillExpStripe/Label", "Top_UILabel")
    ---高级技能花费图
    self.highSkillCost_UISprite = self:Get("skillExpStripe/skillBook", "UISprite")
    ---选择特效
    self.chooseEffect = self:Get("chooseEffect", "GameObject")
    ---使用技能书
    self.UseSkillBookBtn = self:Get("UseSkillBookBtn", "GameObject")
    -----自动释放
    --self.AutoState = self:Get("AutoState", "Top_UILabel")
    ---自动释放光圈
    self.AutoObj = self:Get("auto", "GameObject")
    ---技能升级
    self.Btn_Upgrade = self:Get("Btn_Upgrade", "Top_UISprite")
    ---学习技能
    self.Btn_Learn = self:Get("Btn_Learn", "GameObject")
    --- 提示文本
    self.Tips = self:Get("Tips", "Top_UILabel")
    ---放入按钮
    self.putInBtn = self:Get("Btn_PutIn", "GameObject")
    ---升级呼吸文本
    self.mLevelLightTxt = self:Get("HighlightEffect", "UILabel");
    ---升级呼吸动画
    self.mLevelLightTweenAlpha = self:Get("HighlightEffect", "TweenAlpha")
    ---熟练度文本
    self.ShuLianDu_UILabel = self:Get("skillExpStripe/lb", "UILabel")
    ---强化技能Icon
    self.intensifySkillIcon = self:Get("intensifySkillIcon", "UISprite")

    if self.putInBtn ~= nil then
        self.putInBtn:SetActive(false)
    end
    if not CS.StaticUtility.IsNull(self.AutoObj) and (self.AutoObj ~= nil) then
        self.AutoObj:SetActive(false);
    end
end

function UISkillTemplate_UISkillPanel:InitOther()
    self.skillinfo = nil
    self.SkillInfoTemplate = nil
    ---当前经验
    self.nowExp = 0;
    ---需要经验
    self.maxExp = 0;
    ---是否学习
    self.IsStudy = false;
    ---经验是否满级
    self.IsExpMax = false
    ---技能是否满级
    self.IsSkillMax = false
    ---是否达到学习等级
    self.IsReachStudyLevel = false

    ---技能升级圆圈特效
    self.skillUpEffect = nil
    ---技能升级按键特效
    self.Upgrade_Effect = nil
    ---技能学习特效
    self.skillStudyEffect = nil;

    self.mIsShowStudyEffect = false;
    ---是否是高级技能
    self.isHighSkill = false

    CS.UIEventListener.Get(self.UseSkillBookBtn).LuaEventTable = self
    CS.UIEventListener.Get(self.UseSkillBookBtn).OnClickLuaDelegate = self.OnUseSkillBookBtn
    CS.UIEventListener.Get(self.skillIcon.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.skillIcon.gameObject).OnClickLuaDelegate = self.OnSelectSelf
    CS.UIEventListener.Get(self.Btn_Upgrade.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn_Upgrade.gameObject).OnClickLuaDelegate = self.OnBtn_Upgrade
    CS.UIEventListener.Get(self.Btn_Learn.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.Btn_Learn.gameObject).OnClickLuaDelegate = self.OnStudySkillBookBtn
    if CS.StaticUtility.IsNull(self.highSkillCost_UISprite) == false then
        CS.UIEventListener.Get(self.highSkillCost_UISprite.gameObject).onClick = function()
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.costBookItemInfo, showRight = false })
        end
    end
end

function UISkillTemplate_UISkillPanel:Init(clipShaderComponent)
    self.mClipShaderComponent = clipShaderComponent;
    self:InitComponents()
    self:InitOther()
end

---刷新UI
---data:技能基础信息 serversData:服务器技能信息 Template:UISkillInfo_UISkillPanel模板
---@param skillinfo TABLE.cfg_skills
---@param serversData LuaSkillDetailedInfo
function UISkillTemplate_UISkillPanel:RefreshUI(skillinfo, serversData, Template, index)
    if not CS.StaticUtility.IsNull(self.frame) and self.frame.gameObject ~= nil then
        self.frame.gameObject:SetActive(index % 2 == 0)
    end

    ---@type  TABLE.cfg_skills 技能基础信息
    self.skillinfo = skillinfo
    ---UISkillInfo_UISkillPanel模板
    self.SkillInfoTemplate = Template
    self.detailedInfo = serversData

    self.SkillInfoDic = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr().SkillInfoDic
    if self.SkillInfoDic ~= nil then
        ---@type LuaSkillDetailedInfo
        self.NowSkillInfo = self.SkillInfoDic[self.skillinfo:GetId()]
    end
    ---得到技能数据
    self:GetData(skillinfo:GetId())
    ---当前经验
    local nowexp = 0
    ---最大经验
    local maxExp = 0
    ---进度条数值
    local fillAmount = 0
    ---进度条经验显示
    local ExpLabel = ''
    ---技能等级
    local level = 0
    -----自动释放
    --local AutoState = ''
    ---Icon颜色
    local IconColor = CS.UnityEngine.Color.black
    ---字体颜色
    local color = '[878787]';
    ---额外描述
    local additionalDescription = '';

    if self.detailedInfo ~= nil then
        self.IsStudy = true
        maxExp = self.detailedInfo:GetSkillExpMax()
        nowexp = self.detailedInfo.exp

        local skillDetailedInfoIsFind, skillDetailedInfo = CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillDetailedInfoDic:TryGetValue(self.skillinfo:GetId())
        self.skillDetailedInfo = skillDetailedInfo
        if skillDetailedInfoIsFind == true then
            self.isHighSkill = self.skillDetailedInfo.IsHighSkill
        end
        if self.skillDetailedInfo ~= nil and self.skillDetailedInfo.SkillcNow ~= nil and self.skillDetailedInfo.SkillcNow.costBook ~= nil and self.skillDetailedInfo.SkillcNow.costBook.list ~= nil and self.skillDetailedInfo.SkillcNow.costBook.list.Count > 0 then
            local costItemInfoIsFind, costItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.skillDetailedInfo.SkillcNow.costBook.list[0])
            self.costBookItemInfo = costItemInfo
        end

        if nowexp >= maxExp then
            -- nowexp = maxExp
            color = "[ffffff]"
            additionalDescription = luaEnumColorType.Green .. " (满)" .. '[-]'
        else
            color = "[878787]"
            additionalDescription = "";
        end
        ExpLabel = Utility.SetScheduleColor(math.ceil(nowexp), math.ceil(maxExp)) .. additionalDescription
        fillAmount = nowexp / maxExp
        if fillAmount >= 1 then
            self.IsExpMax = true
        else
            self.IsExpMax = false
        end
        level = self.detailedInfo.level
        IconColor = CS.UnityEngine.Color.white
        if self.skillinfo:GetAutomaticRelease() == 1 then
            local isOpen = CS.CSScene.MainPlayerInfo.SkillInfoV2:IsAutoSkillOpen(self.skillinfo:GetId());
            if not CS.StaticUtility.IsNull(self.AutoObj) and (self.AutoObj ~= isOpen) then
                self.AutoObj:SetActive(isOpen)
            end
        end
    end
    self.nowExp = nowexp
    self.maxExp = maxExp
    self.skillIcon.spriteName = self.skillinfo:GetIcon()
    self.skillName.text = '[dde6eb]' .. self.skillinfo:GetName()
    self.skillIcon.color = self.mIsShowStudyEffect and CS.UnityEngine.Color.black or IconColor;
    --self.AutoState.text = AutoState
    ---XP技能/装备技能默认等级不会去-1
    local isSpecialSkill = self.skillinfo:GetCls() == 4 or self.skillinfo:GetCls() == 10
    local addLevel = isSpecialSkill and 0 or -1
    self.skillLevel.text = self.IsStudy and self.IsSkillMax and color .. "已满级" or color .. tostring(math.max(tonumber(level) + addLevel, 0)) .. '级'
    --self.skillExpStripe.fillAmount = fillAmount
    local showExpLabel = self.IsStudy and not self.IsSkillMax
    if self.Label ~= nil and CS.StaticUtility.IsNull(self.Label) == false then
        self.Label.gameObject:SetActive(showExpLabel);
        self.Label.text = ExpLabel
    end
    if CS.StaticUtility.IsNull(self.ShuLianDu_UILabel) == false then
        self.ShuLianDu_UILabel.gameObject:SetActive(showExpLabel and self.isHighSkill == false)
    end
    if CS.StaticUtility.IsNull(self.highSkillCost_UISprite) == false then
        self.highSkillCost_UISprite.gameObject:SetActive(showExpLabel and self.isHighSkill)
        if self.costBookItemInfo ~= nil then
            self.highSkillCost_UISprite.spriteName = self.costBookItemInfo.icon
        end
    end

    if CS.StaticUtility.IsNull(self.Btn_Upgrade) == false then
        self.Btn_Upgrade.gameObject:SetActive(self.IsExpMax and not self.IsSkillMax and self.IsReachStudyLevel);
    end

    local IsHaveSkillBook = self:HasSkillBook();
    local IsCanUseSkillBook = self:IsCanUse()
    self.Btn_Learn:SetActive(false)
    if IsHaveSkillBook and not self.IsStudy and self:IsCanUse() then
        self.UseSkillBookBtn:SetActive(false)
        self.Btn_Learn:SetActive(true)
    else
        self.UseSkillBookBtn:SetActive(IsHaveSkillBook and self.IsExpMax == false and not self.IsSkillMax and IsCanUseSkillBook)
        local IsMeetLimitOpenSkill = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsMeetLimitOpenSkill(self.skillinfo:GetId())
        if IsMeetLimitOpenSkill and not self.IsStudy and self.skillinfo ~= nil then
            local isMeet = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(self.skillinfo:GetCondition())
            self.Btn_Learn:SetActive(isMeet)
        end

    end
    if self.IsExpMax and not self.IsSkillMax and not self.IsReachStudyLevel then
        self.Tips.text = luaEnumColorType.Gray .. self.needLevel .. '级 可升级[-]'
    end

    self.Tips.gameObject:SetActive(self.IsExpMax and not self.IsSkillMax and not self.IsReachStudyLevel)
    if self.continueAdjustPosition then
        StopCoroutine(self.continueAdjustPosition)
        self.continueAdjustPosition = nil
    end
    self.continueAdjustPosition = StartCoroutine(function()
        self:AdjustPosition()
    end)
    self:RefreshIntensifySkillIcon()
    self.skillExpStripe.gameObject:SetActive(skillinfo ~= nil and skillinfo:GetCls() ~= 10)
end

function UISkillTemplate_UISkillPanel:RefreshIntensifySkillIcon()
    if self.NowSkillInfo == nil then
        self.intensifySkillIcon.gameObject:SetActive(false)
        return
    end
    local IntensifySkillInfo = self.NowSkillInfo:GetIntensifySkillInfo()
    self.intensifySkillIcon.gameObject:SetActive(IntensifySkillInfo ~= nil)
    if IntensifySkillInfo ~= nil and IntensifySkillInfo:GetSkillTable() ~= nil then
        self.intensifySkillIcon.spriteName = IntensifySkillInfo:GetSkillTable():GetIcon2()
    end
end

function UISkillTemplate_UISkillPanel:AdjustPosition()
    coroutine.yield(0)
    if CS.StaticUtility.IsNull(self.skillLevel) == false then
        self.skillLevel:UpdateAnchors()
    end
    if CS.StaticUtility.IsNull(self.skillExpSprite_UITable) == false then
        self.skillExpSprite_UITable:Reposition()
    end
    if CS.StaticUtility.IsNull(self.mLevelLightTxt) == false then
        self.mLevelLightTxt:UpdateAnchors()
    end
end

---得到技能数据
function UISkillTemplate_UISkillPanel:GetData(skillID)
    ---当前技能条件信息
    ---@type TABLE.cfg_skills_condition
    self.SkillsCondition_Now = nil
    ---下一级技能条件信息
    ---@type TABLE.cfg_skills_condition
    self.SkillsCondition_Next = nil
    ---技能是否满级
    ---@type boolean
    self.IsSkillMax = false
    if self.NowSkillInfo ~= nil then
        self.SkillsCondition_Now = self.NowSkillInfo:GetNowSkillsConditionTable()
        self.SkillsCondition_Next = self.NowSkillInfo:GetNextSkillsConditionTable()
        self.IsSkillMax = self.NowSkillInfo:IsSkillMax()
    end

    self.SkillList = CS.Cfg_SkillTableManager.Instance.SkillList

    if self.IsSkillMax or self.SkillsCondition_Next == nil then
        self.IsReachStudyLevel = false
    else
        self.needLevel = CS.Cfg_ConditionManager.Instance:GetCanLearnSkillLevel(self.SkillsCondition_Next.id)
        self.IsReachStudyLevel = CS.CSScene.MainPlayerInfo.Level >= self.needLevel
    end

    --region 升级完成的文字呼吸特效
    if (self.mIsPlayUpLevelEffect) then
        self.mIsPlayUpLevelEffect = false;
        self:SetAutofightEffects()
    end

    if (self.mIsPlayStudyEffect) then
        self.mIsPlayStudyEffect = false;
        self:SetStudyEffects();
    end
    --endregion
end

function UISkillTemplate_UISkillPanel:HasSkillBook()
    return CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(self.skillinfo:GetId()) ~= nil;
end

--function UISkillTemplate_UISkillPanel:CanStudy()
--    return self:IsCanUse() and self:HasSkillBook() and self.IsStudy
--end
--
--
--function UISkillTemplate_UISkillPanel:CanUseSkillBook()
--    return self.UseSkillBookBtn.activeSelf;
--end
function UISkillTemplate_UISkillPanel:GetBagSkillBookItemInfo()
    return CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(self.skillinfo:GetId())
end

function UISkillTemplate_UISkillPanel:IsCanUse(bagItemInfo)
    local bagItemInfo = self:GetBagSkillBookItemInfo()
    if bagItemInfo ~= nil then
        local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(bagItemInfo.itemId)
        if itemInfoIsFind and CS.Utility_Lua.IsBagItemCanShowRedPoint(itemInfo) then
            return true
        end
    end
    return false
end

---使用技能书
function UISkillTemplate_UISkillPanel:OnUseSkillBookBtn()
    local itemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetBagSkillBookItemInfo(self.skillinfo:GetId())
    if itemInfo ~= nil then
        networkRequest.ReqUseItem(1, itemInfo.lid, 1)
    end
end

---学习技能
function UISkillTemplate_UISkillPanel:OnStudySkillBookBtn()
    local IsMeetLimitOpenSkill = gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():IsMeetLimitOpenSkill(self.skillinfo:GetId())
    if IsMeetLimitOpenSkill then
        networkRequest.ReqStudySpecialSkill(self.skillinfo:GetId())
    else
        self:OnUseSkillBookBtn()
    end
    self:OnUseSkillBookBtn()
    self:SetStudyEffects();
    self.mIsPlayStudyEffect = true;
end

function UISkillTemplate_UISkillPanel:OnSelectSelf()
    self.SkillInfoTemplate:FindSelectSkill(self.skillinfo:GetId(), self.go.gameObject)
    --self.SkillInfoTemplate.infoPanel:SetActive(true)
end

---是否可以升级
function UISkillTemplate_UISkillPanel:IsCanUpSkill()
    if self.IsStudy == false or self.IsSkillMax or self.IsExpMax == false or self.IsReachStudyLevel == false then
        return false
    else
        return true
    end
end

---技能升级
function UISkillTemplate_UISkillPanel:OnBtn_Upgrade()
    if self:IsCanUpSkill() then
        networkRequest.ReqLevelUpSkill(self.skillinfo:GetId())
        self.mIsPlayUpLevelEffect = true;
    else
        self:ShowTextTips()
    end

end

---显示提示
function UISkillTemplate_UISkillPanel:ShowTextTips()
    if not self.IsExpMax then
        CS.Utility.ShowTips("熟练度未满，无法升级!", 1.5, CS.ColorType.Red)
    elseif self.IsSkillMax then
        CS.Utility.ShowTips("技能已满级!", 1.5, CS.ColorType.Red)
    elseif not self.IsReachStudyLevel then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = self.Btn_Upgrade.gameObject.transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 3
        uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
    else
        CS.Utility.ShowTips("未满足升级条件", 1.5, CS.ColorType.Red)
    end
end

function UISkillTemplate_UISkillPanel:SetEffectInfo()
    if (self.skillStudyEffect ~= nil) then
        self.skillStudyEffect:SetActive(false);
        self.mIsShowStudyEffect = false;
    end

    if (self.Upgrade_Effect ~= nil) then
        self.Upgrade_Effect:SetActive(false);
    end
end

---技能升级Icon特效
function UISkillTemplate_UISkillPanel:SetAutofightEffects()
    if self.skillUpEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("700010", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj and self ~= nil and CS.StaticUtility.IsNull(self.go) == false then
                if self.skillUpEffect == nil then
                    if self.skillIcon ~= nil then
                        local poolItem = res:GetUIPoolItem()
                        if poolItem then
                            self.skillUpEffect = poolItem.go
                            if self.skillUpEffect then
                                self.skillUpEffect.transform.parent = self.skillIcon.transform
                                self.skillUpEffect.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
                                self.skillUpEffect.transform.localScale = CS.UnityEngine.Vector3.one
                            end
                        end
                    end
                else
                    self.skillUpEffect:SetActive(false)
                    self.skillUpEffect:SetActive(true)
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        self.skillUpEffect:SetActive(false)
        self.skillUpEffect:SetActive(true)
    end

    local showText;
    if (self.IsSkillMax) then
        showText = "已满级";
    else
        if self.skillinfo then
            local level = self.SkillsCondition_Now:GetLevel()
            if self.skillinfo:GetCls() == 4 then
                level = level + 1
            end
            showText = level .. "级";
        end
    end
    self.mLevelLightTxt.text = showText;
    self.skillLevel.gameObject:SetActive(false);
    self.mLevelLightTxt.gameObject:SetActive(true);
    self.mLevelLightTweenAlpha:SetOnFinished(function()
        self.mLevelLightTxt.gameObject:SetActive(false);
        self.skillLevel.gameObject:SetActive(true);
    end)
    self.mLevelLightTweenAlpha:PlayTween();
end

---技能升级Icon特效
function UISkillTemplate_UISkillPanel:SetStudyEffects()
    self.mIsShowStudyEffect = true;
    if CS.StaticUtility.IsNull(self:GetSkillIcon_TweenAlpha()) == false then
        self:GetSkillIcon_TweenAlpha():PlayTween();
    end
    if self.skillStudyEffect == nil then
        CS.CSResourceManager.Singleton:AddQueueCannotDelete("700037", CS.ResourceType.UIEffect, function(res)
            if res and res.MirrorObj then
                if self.skillStudyEffect == nil and not CS.StaticUtility.IsNull(self.skillIconEffectNode) then
                    if self.skillIconEffectNode ~= nil then
                        if self.skillIcon ~= nil and not CS.StaticUtility.IsNull(self.skillIcon) then
                            local poolItem = res:GetUIPoolItem()
                            self.skillStudyEffect = poolItem.go
                            if self.skillStudyEffect then
                                if (self.mClipShaderComponent ~= nil) then
                                    self.mClipShaderComponent:AddRenderList(self.skillStudyEffect, true);
                                end
                                self.skillStudyEffect.transform.parent = self.skillIconEffectNode;
                                self.skillStudyEffect.transform.localPosition = CS.UnityEngine.Vector3(-0.0045, 0, 0)
                                self.skillStudyEffect.transform.localScale = CS.UnityEngine.Vector3.one
                                if (self:TryChangeEffectIcon()) then
                                    self:OnStudyEffectPlayed();
                                end
                            end
                        end
                    end
                else
                    if (self:TryChangeEffectIcon()) then
                        self:OnStudyEffectPlayed();
                    end
                    if self.skillStudyEffect then
                        self.skillStudyEffect:SetActive(false)
                        self.skillStudyEffect:SetActive(true)
                    end
                end
            end
        end
        , CS.ResourceAssistType.UI)
    else
        if (self.skillUpEffect ~= nil and not CS.StaticUtility.IsNull(self.skillUpEffect)) then
            if (self:TryChangeEffectIcon()) then
                self:OnStudyEffectPlayed();
            end
            self.skillUpEffect:SetActive(false)
            self.skillUpEffect:SetActive(true)
        end
    end

    local level = 0
    if self.skillinfo then
        if self.skillinfo:GetCls() == 4 then
            level = level + 1
        end
    end
    local showText = level .. "级";
    self.mLevelLightTxt.text = showText;
    self.mLevelLightTxt.gameObject:SetActive(true);
    self.skillLevel.gameObject:SetActive(false);
    self.mLevelLightTweenAlpha:SetOnFinished(function()
        self.mLevelLightTxt.gameObject:SetActive(false);
        self.skillLevel.gameObject:SetActive(true);
    end)
    self.mLevelLightTweenAlpha:PlayTween();
end

function UISkillTemplate_UISkillPanel:TryChangeEffectIcon()
    if (self.skillStudyEffect == nil) then
        return false;
    end
    local studyTrans = self.skillStudyEffect.transform:Find("icon/icon")
    if studyTrans ~= nil then
        local meshRenderer = CS.Utility_Lua.GetComponent(studyTrans, "MeshRenderer")
        if meshRenderer ~= nil and not CS.StaticUtility.IsNull(meshRenderer) and meshRenderer.material ~= nil then
            --meshRenderer.material.renderQueue = 3100;
            local skillIcon = self.skillIcon;
            local spriteData = skillIcon.atlas:GetSprite(self.skillinfo:GetIcon());
            local width = spriteData.width;
            local height = spriteData.height;
            local sumWidth = skillIcon.atlas.texture.width;
            local sumHeight = skillIcon.atlas.texture.height;

            meshRenderer.material:SetTexture("_MainTex", skillIcon.mainTexture);
            if meshRenderer.material:HasProperty("_AlphaTex") then
                if skillIcon.material:IsKeywordEnabled("_AlphaTexOn") then
                    meshRenderer.material:EnableKeyword("_AlphaTexOn")
                    meshRenderer.material:SetInt("_AlphaTexOn", 1)
                    meshRenderer.material:SetTexture("_AlphaTex", skillIcon.material:GetTexture("_AlphaTex"))
                else
                    meshRenderer.material:DisableKeyword("_AlphaTexOn")
                    meshRenderer.material:SetInt("_AlphaTexOn", 0)
                    meshRenderer.material:SetTexture("_AlphaTex", nil)
                end
            end
            local offset = CS.UnityEngine.Vector2((spriteData.x) / sumWidth, 1 - (spriteData.y + height) / sumHeight);
            meshRenderer.sharedMaterial:SetTextureOffset("_MainTex", offset);
            local tiling = CS.UnityEngine.Vector2(width / sumWidth, height / sumHeight);
            meshRenderer.material:SetTextureScale("_MainTex", tiling);
            if skillIcon ~= nil and not CS.StaticUtility.IsNull(skillIcon) and skillIcon.drawCall ~= nil and not CS.StaticUtility.IsNull(skillIcon.drawCall) then
                meshRenderer.material.renderQueue = skillIcon.drawCall.renderQueue + 1;
            end
            return true;
        end
    end
    return false;
end

function UISkillTemplate_UISkillPanel:OnStudyEffectPlayed()
    if (self.mCoroutineStudyEffectDelay ~= nil) then
        StopCoroutine(self.mCoroutineStudyEffectDelay);
        self.mCoroutineStudyEffectDelay = nil;
    end
    self.mCoroutineStudyEffectDelay = StartCoroutine(self.IEnumStudyEffectDelay, self, 1);
end

function UISkillTemplate_UISkillPanel:IEnumStudyEffectDelay(delayTime)
    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(delayTime));
    self.mIsShowStudyEffect = false;
    if CS.StaticUtility.IsNull(self:GetSkillIcon_TweenAlpha()) == true then
        return
    end
    self:GetSkillIcon_TweenAlpha().enabled = false;
    if CS.StaticUtility.IsNull(self.skillIcon) == false then
        self.skillIcon.alpha = 1;
        self.skillIcon.color = CS.UnityEngine.Color.white;
    end
    local studyEffect = self.skillStudyEffect;
    if (studyEffect ~= nil and CS.StaticUtility.IsNull(studyEffect) == false) then
        studyEffect:SetActive(false);
    end
end

---检测打开或关闭放入按钮
function UISkillTemplate_UISkillPanel:CheckOpenPutInBtn()
    if self.IsStudy then
        self.putInBtn:SetActive(true)
    else
        self.putInBtn:SetActive(false)
    end
end

--region 技能设置初始化
function UISkillTemplate_UISkillPanel:SkillConfigPanelResetUI(ID)
    self:CheckOpenPutInBtn()
    self:InitSetting(ID)
end

---技能图标拖拽
function UISkillTemplate_UISkillPanel:InitSetting(ID)
    CS.UIEventListener.Get(self.skillIcon_GameObject).LuaEventTable = function()
    end
    CS.UIEventListener.Get(self.skillIcon_GameObject).OnClickLuaDelegate = function()
    end
    if CS.CSScene.MainPlayerInfo.SkillInfoV2:IsSkillLearning(ID) then
        CS.UIEventListener.Get(self.skillIcon_GameObject).onDragStart = self.SkillInfoTemplate.OnDragStartSkill;
        CS.UIEventListener.Get(self.skillIcon_GameObject).onDrag = self.SkillInfoTemplate.OnDragSkill;
        CS.UIEventListener.Get(self.skillIcon_GameObject).onDragEnd = self.SkillInfoTemplate.OnDragEndSkill;
        CS.UIEventListener.Get(self.skillIcon_GameObject).onPress = function(go, state)
            self.SkillInfoTemplate.OnPress(go, state)
            if state then
                self.frameTween:PlayForward()
            else
                self.frameTween:PlayReverse()
            end
        end
        CS.UIEventListener.Get(self.putInBtn).OnClickLuaDelegate = function()
            self.SkillInfoTemplate:SaveSkillConfig(self.SkillInfoTemplate.lastChoose, self.id, self.skillinfo:GetIcon())
        end
    end
    self.id = ID
    if self.Btn_Upgrade ~= nil then
        self.Btn_Upgrade.gameObject:SetActive(false)
    end
    if self.Btn_Learn ~= nil then
        self.Btn_Learn.gameObject:SetActive(false)
    end
    if self.Tips ~= nil then
        self.Tips.gameObject:SetActive(false)
    end
    if self.Tips ~= nil then
        self.Tips.gameObject:SetActive(false)
    end
    if self.UseSkillBookBtn ~= nil then
        self.UseSkillBookBtn.gameObject:SetActive(false)
    end
end

function UISkillTemplate_UISkillPanel:ID()
    return self.id
end

function UISkillTemplate_UISkillPanel:OnDestroy()
    if (self.mCoroutineStudyEffectDelay ~= nil) then
        StopCoroutine(self.mCoroutineStudyEffectDelay);
        self.mCoroutineStudyEffectDelay = nil;
    end
    if self.continueAdjustPosition then
        StopCoroutine(self.continueAdjustPosition)
        self.continueAdjustPosition = nil
    end
end
--endregion
return UISkillTemplate_UISkillPanel