--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--skill.xml

--region ID:9002 ResSkillMessage 返回角色技能数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ResSkill lua table类型消息数据
---@param csData skillV2.ResSkill C# class类型消息数据
netMsgPreprocessing[9002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.SkillInfoV2:InitSkillInfo(csData)
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_PARTICULARS);
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_SECRETSKILL);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_ALL);
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():RefreshAllSkill(tblData)
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():CallSpecialRed()
end
--endregion

--region ID:9005 ResOneSkillChangeMessage 返回单个技能变化数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ResOneSkillChange lua table类型消息数据
---@param csData skillV2.ResOneSkillChange C# class类型消息数据
netMsgPreprocessing[9005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateSkillDic(tblData.skillBean.skillId, csData.skillBean)
        CS.CSScene.MainPlayerInfo.SkillInfoV2:SkillRefresh(csData);
    end
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_PARTICULARS);
    --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_SECRETSKILL);
    CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.SKILL_ALL);
    local uiBagPanel = uimanager:GetPanel("UIBagPanel")
    if uiBagPanel ~= nil then
        uiBagPanel:RefreshGrids()
    end
    if tblData ~= nil and gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():RefreshOneSkillChange(tblData.skillBean)
        gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():CallSpecialRed()
    end
end
--endregion

--region ID:9006 ResMultiSkillChangeMessage 返回多个技能变化数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ResMultiSkillChange lua table类型消息数据
---@param csData skillV2.ResMultiSkillChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[9006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:9007 ResSkillBookUseMessage 使用技能书
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.SkillBean lua table类型消息数据
---@param csData skillV2.SkillBean C# class类型消息数据
netMsgPreprocessing[9007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateSkillDic(tblData.skillId, csData)
    CS.CSScene.MainPlayerInfo.SkillInfoV2:SetSkillDetailedInfoDic(csData);
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():RefreshOneSkillChange(tblData)
    gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():SetCareerSkill()
    ---使用技能书时触发一次合成红点计算
    gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint()
end
--endregion

--region ID:9010 ResSecretSkillInfoMessage 秘技面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.SecretSkillInfo lua table类型消息数据
---@param csData skillV2.SecretSkillInfo C# class类型消息数据
netMsgPreprocessing[9010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData.secretSkill ~= nil) then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateHeartSkillUseState(csData.secretSkill);
    else
        CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateHeartSkillUseState();
    end

    if (csData.form ~= nil) then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateCurUsedFormation(csData.form);
    end

    if (csData.oldForms ~= nil) then
        CS.CSScene.MainPlayerInfo.SkillInfoV2:UpdateOldFormation(csData.oldForms);
    end

    if (csData.level ~= nil) then
        CS.CSScene.MainPlayerInfo.SkillInfoV2.SkillFormationLevel = csData.level;
    end
end
--endregion

--region ID:9015 ResSecretBackMessage 上下阵心法回调
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ResSecretBack lua table类型消息数据
---@param csData skillV2.ResSecretBack C# class类型消息数据
netMsgPreprocessing[9015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:9016 ResSwitchFormationMessage 切换心阵
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ReqSwitchFormation lua table类型消息数据
---@param csData skillV2.ReqSwitchFormation C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[9016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:9017 ResXpSkillEnergyChangeMessage xp 能量改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.ResXpSkillEnergyChange lua table类型消息数据
---@param csData skillV2.ResXpSkillEnergyChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[9017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:9019 ResAllEquipProficientInfoMessage 全部的装备专精信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.AllEquipProficientInfo lua table类型消息数据
---@param csData skillV2.AllEquipProficientInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[9019] = function(msgID, tblData, csData)
    --在此处填入预处理代码

    gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():ResProficientInfo(tblData)
end
--endregion

--region ID:9020 ResEquipProficientInfoMessage 单个装备专精信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData skillV2.EquipProficientInfo lua table类型消息数据
---@param csData skillV2.EquipProficientInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[9020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():ResEquipProficientInfoMessage(tblData)
    gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():CallRed()
end
--endregion
