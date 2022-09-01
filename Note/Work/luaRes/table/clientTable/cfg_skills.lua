--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_skills
local cfg_skills = {}

cfg_skills.__index = cfg_skills

function cfg_skills:UUID()
    return self.id
end

---@return number 技能id#客户端#C#不存在共同参与合并的字段  第1位：类别(1角色2怪物3装备4心法5魂继)。第3位：子类（角色：0通用1战士2法师3道士。怪物：0通用1暂无划分。装备：0通用1暂无划分。秘籍：1生命类2防御类3元素攻击4元素防御5抵御职业6抵御技能。魂继1魂继技能2通灵技能）。第456位：编号
function cfg_skills:GetId()
    if self.id ~= nil then
        return self.id
    else
        if self:CsTABLE() ~= nil then
            self.id = self:CsTABLE().id
            return self.id
        else
            return nil
        end
    end
end

---@return string 技能名称#客户端#C
function cfg_skills:GetName()
    if self.name ~= nil then
        return self.name
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().name
        else
            return nil
        end
    end
end

---@return string 图标#客户端#C  icon的id
function cfg_skills:GetIcon()
    if self.icon ~= nil then
        return self.icon
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon
        else
            return nil
        end
    end
end

---@return number 技能学习条件#客户端#C#不存在共同参与合并的字段  关联sfg_conditions表中ID；&与 |或
function cfg_skills:GetCondition()
    if self.condition ~= nil then
        return self.condition
    else
        if self:CsTABLE() ~= nil then
            self.condition = self:CsTABLE().condition
            return self.condition
        else
            return nil
        end
    end
end

---@return number buff目标类型#客户端#C  1:对敌；2:对己；3:对宠物；4:对友方；5:召唤；6.对玩家；7.对神兽骷髅；100.有选中的人就对目标，没有，就对自己
function cfg_skills:GetTargetTypeClient()
    if self.targetTypeClient ~= nil then
        return self.targetTypeClient
    else
        if self:CsTABLE() ~= nil then
            self.targetTypeClient = self:CsTABLE().targetTypeClient
            return self.targetTypeClient
        else
            return nil
        end
    end
end

---@return number 目标模式拓展#客户端#C  1.前方点技能强制寻怪
function cfg_skills:GetTargetTypeExtend()
    if self.targetTypeExtend ~= nil then
        return self.targetTypeExtend
    else
        if self:CsTABLE() ~= nil then
            self.targetTypeExtend = self:CsTABLE().targetTypeExtend
            return self.targetTypeExtend
        else
            return nil
        end
    end
end

---@return number 技能释放动作（客户端）#客户端#C#不存在共同参与合并的字段  0无动作31普通下劈攻击  32举手施法  33斜劈 34冲撞 35跳斩 36旋风斩 37秘能爆发38暴风雪 39爆裂火符 40召唤群兽
function cfg_skills:GetAction()
    if self.action ~= nil then
        return self.action
    else
        if self:CsTABLE() ~= nil then
            self.action = self:CsTABLE().action
            return self.action
        else
            return nil
        end
    end
end

---@return number 伤害显示延迟（客户端）#客户端#C#不存在共同参与合并的字段  单位为毫秒（有受击按受击开始计时，无受击按攻击动作开始计时）
function cfg_skills:GetHurtDelay()
    if self.hurtDelay ~= nil then
        return self.hurtDelay
    else
        if self:CsTABLE() ~= nil then
            self.hurtDelay = self:CsTABLE().hurtDelay
            return self.hurtDelay
        else
            return nil
        end
    end
end

---@return number 选怪目标类型#客户端#C  1、对目标；2、对点（客户端发过来的点）；3、自己所在的点；4、前方点；5、目标所在点；6、目标前方点
function cfg_skills:GetReleaseTypeClient()
    if self.releaseTypeClient ~= nil then
        return self.releaseTypeClient
    else
        if self:CsTABLE() ~= nil then
            self.releaseTypeClient = self:CsTABLE().releaseTypeClient
            return self.releaseTypeClient
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 技能参数#客户端#C  特殊技能有不同用处（疾光电影：每个格子的伤害增幅比例，万分比；召唤神兽/骷髅：职业1物理2魔法；秘能爆发：辅助技能id）
function cfg_skills:GetExtraParam()
    if self.extraParam ~= nil then
        return self.extraParam
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().extraParam
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 特效ID#客户端#C  cfg_effects表对应
function cfg_skills:GetEffects()
    if self.effects ~= nil then
        return self.effects
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effects
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 受击者特效ID#客户端#C  配置cfg_effects表中的受击者特效
function cfg_skills:GetEffects2()
    if self.effects2 ~= nil then
        return self.effects2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effects2
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 技能自动设置键位#客户端#C  技能学习后自动设置的键位配置（键位编号#类型#优先级，类型：0非强制1强制）（强制时优先级高的会覆盖低的）
function cfg_skills:GetSkillLattice()
    if self.skillLattice ~= nil then
        return self.skillLattice
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().skillLattice
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 技能对应元素属性#客户端#C  1.电；2.火；3.冰；4.黑暗；5.穿刺
function cfg_skills:GetElement()
    if self.element ~= nil then
        return self.element
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().element
        else
            return nil
        end
    end
end

---@return number 技能释放后移动等待时间#客户端#C#不存在共同参与合并的字段  从施法动作开始播放时开始计时（毫秒）
function cfg_skills:GetStayTime()
    if self.stayTime ~= nil then
        return self.stayTime
    else
        if self:CsTABLE() ~= nil then
            self.stayTime = self:CsTABLE().stayTime
            return self.stayTime
        else
            return nil
        end
    end
end

---@return number 释放技能后强制位移的等待时间#客户端#C  单位毫秒
function cfg_skills:GetDelayForceMove()
    if self.delayForceMove ~= nil then
        return self.delayForceMove
    else
        if self:CsTABLE() ~= nil then
            self.delayForceMove = self:CsTABLE().delayForceMove
            return self.delayForceMove
        else
            return nil
        end
    end
end

---@return number 技能CD施法受攻速影响#客户端#C  技能CD施法受攻速影响 默认值不填  为不受影响 填1   为受影响
function cfg_skills:GetAttackIsFnfluenceCD()
    if self.AttackIsFnfluenceCD ~= nil then
        return self.AttackIsFnfluenceCD
    else
        if self:CsTABLE() ~= nil then
            self.AttackIsFnfluenceCD = self:CsTABLE().AttackIsFnfluenceCD
            return self.AttackIsFnfluenceCD
        else
            return nil
        end
    end
end

---@return number 技能cd偏差值#客户端#C  技能cd和公共cd可允许的偏差值 单位 毫秒
function cfg_skills:GetRongcuoCd()
    if self.rongcuoCd ~= nil then
        return self.rongcuoCd
    else
        if self:CsTABLE() ~= nil then
            self.rongcuoCd = self:CsTABLE().rongcuoCd
            return self.rongcuoCd
        else
            return nil
        end
    end
end

---@return number 类别_C
function cfg_skills:GetCls()
    if self.cls ~= nil then
        return self.cls
    else
        if self:CsTABLE() ~= nil then
            self.cls = self:CsTABLE().cls
            return self.cls
        else
            return nil
        end
    end
end
---@return number 技能界面是否显示_C
function cfg_skills:GetIsShow()
    if self.isShow ~= nil then
        return self.isShow
    else
        if self:CsTABLE() ~= nil then
            self.isShow = self:CsTABLE().isShow
            return self.isShow
        else
            return nil
        end
    end
end
---@return number 用于在界面中的排序_C
function cfg_skills:GetIndex()
    if self.index ~= nil then
        return self.index
    else
        if self:CsTABLE() ~= nil then
            self.index = self:CsTABLE().index
            return self.index
        else
            return nil
        end
    end
end

---@return number 技能处理器类型（服务器端用）_C
function cfg_skills:GetHandlerType()
    if self.handlerType ~= nil then
        return self.handlerType
    else
        if self:CsTABLE() ~= nil then
            self.handlerType = self:CsTABLE().handlerType
            return self.handlerType
        else
            return nil
        end
    end
end
---@return number 技能所属职业（计算伤害看物理还是魔法防御用）_C
function cfg_skills:GetCareer()
    if self.career ~= nil then
        return self.career
    else
        if self:CsTABLE() ~= nil then
            self.career = self:CsTABLE().career
            return self.career
        else
            return nil
        end
    end
end
---@return number 最多作用目标_C
function cfg_skills:GetMaxTarget()
    if self.maxTarget ~= nil then
        return self.maxTarget
    else
        if self:CsTABLE() ~= nil then
            self.maxTarget = self:CsTABLE().maxTarget
            return self.maxTarget
        else
            return nil
        end
    end
end
---@return number 是否可以升级_C
function cfg_skills:GetCanUp()
    if self.canUp ~= nil then
        return self.canUp
    else
        if self:CsTABLE() ~= nil then
            self.canUp = self:CsTABLE().canUp
            return self.canUp
        else
            return nil
        end
    end
end

---@return number 技能释放距离_C
function cfg_skills:GetReleaseDis()
    if self.releaseDis ~= nil then
        return self.releaseDis
    else
        if self:CsTABLE() ~= nil then
            self.releaseDis = self:CsTABLE().releaseDis
            return self.releaseDis
        else
            return nil
        end
    end
end
---@return number 是否参与公共CD_C
function cfg_skills:GetCommonCd()
    if self.commonCd ~= nil then
        return self.commonCd
    else
        if self:CsTABLE() ~= nil then
            self.commonCd = self:CsTABLE().commonCd
            return self.commonCd
        else
            return nil
        end
    end
end
---@return number 释放目标类型_C
function cfg_skills:GetReleaseType()
    if self.releaseType ~= nil then
        return self.releaseType
    else
        if self:CsTABLE() ~= nil then
            self.releaseType = self:CsTABLE().releaseType
            return self.releaseType
        else
            return nil
        end
    end
end
---@return number 作用区域范围大小_C
function cfg_skills:GetAreaDis()
    if self.areaDis ~= nil then
        return self.areaDis
    else
        if self:CsTABLE() ~= nil then
            self.areaDis = self:CsTABLE().areaDis
            return self.areaDis
        else
            return nil
        end
    end
end

---@return number 攻击类型_C
function cfg_skills:GetAreaType()
    if self.areaType ~= nil then
        return self.areaType
    else
        if self:CsTABLE() ~= nil then
            self.areaType = self:CsTABLE().areaType
            return self.areaType
        else
            return nil
        end
    end
end
---@return number 是否必中_C
function cfg_skills:GetHit()
    if self.hit ~= nil then
        return self.hit
    else
        if self:CsTABLE() ~= nil then
            self.hit = self:CsTABLE().hit
            return self.hit
        else
            return nil
        end
    end
end
---@return number 主界面快捷技能栏的位置_C
function cfg_skills:GetPut()
    if self.put ~= nil then
        return self.put
    else
        if self:CsTABLE() ~= nil then
            self.put = self:CsTABLE().put
            return self.put
        else
            return nil
        end
    end
end
---@return number 释放可自动释放_C
function cfg_skills:GetAutomaticRelease()
    if self.automaticRelease ~= nil then
        return self.automaticRelease
    else
        if self:CsTABLE() ~= nil then
            self.automaticRelease = self:CsTABLE().automaticRelease
            return self.automaticRelease
        else
            return nil
        end
    end
end

---@return number 对应技能书_C
function cfg_skills:GetSkillBook()
    if self.skillBook ~= nil then
        return self.skillBook
    else
        if self:CsTABLE() ~= nil then
            self.skillBook = self:CsTABLE().skillBook
            return self.skillBook
        else
            return nil
        end
    end
end
---@return number 秘籍技能类型划分_C
function cfg_skills:GetSecretSkillType()
    if self.secretSkillType ~= nil then
        return self.secretSkillType
    else
        if self:CsTABLE() ~= nil then
            self.secretSkillType = self:CsTABLE().secretSkillType
            return self.secretSkillType
        else
            return nil
        end
    end
end

---@return number 攻击音效_C
function cfg_skills:GetSoundID()
    if self.soundID ~= nil then
        return self.soundID
    else
        if self:CsTABLE() ~= nil then
            self.soundID = self:CsTABLE().soundID
            return self.soundID
        else
            return nil
        end
    end
end
---@return number 命中音效_C
function cfg_skills:GetGoal()
    if self.goal ~= nil then
        return self.goal
    else
        if self:CsTABLE() ~= nil then
            self.goal = self:CsTABLE().goal
            return self.goal
        else
            return nil
        end
    end
end

---@return string 图标2#客户端  icon的id
function cfg_skills:GetIcon2()
    if self.icon2 ~= nil then
        return self.icon2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().icon2
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 强化技能#客户端  强化技能id#强化技能id
function cfg_skills:GetIntensifySkill()
    if self.intensifySkill ~= nil then
        return self.intensifySkill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().intensifySkill
        else
            return nil
        end
    end
end

---@return number 视频展示#客户端  视频id，关联cfg_video的ID
function cfg_skills:GetVideoId()
    if self.videoId ~= nil then
        return self.videoId
    else
        if self:CsTABLE() ~= nil then
            self.videoId = self:CsTABLE().videoId
            return self.videoId
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_SKILLS C#中的数据结构
function cfg_skills:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_SkillTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_skills lua中的数据结构
function cfg_skills:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.icon2 = decodedData.icon2
    
    ---@private
    self.intensifySkill = decodedData.intensifySkill
    
    ---@private
    self.videoId = decodedData.videoId
end

return cfg_skills