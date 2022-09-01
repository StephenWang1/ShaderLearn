--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_buff
local cfg_buff = {}

cfg_buff.__index = cfg_buff

function cfg_buff:UUID()
    return self.id
end

---@return number buffid#客户端#C  1、角色技能buff：技能id+同技能分类+编号；2、怪物技能buff：技能id+同技能分类+编号；4、心法技能buff：技能id+同技能分类+编号；3、其他buff：一级分类+二级分类+编号；
function cfg_buff:GetId()
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

---@return string buff名称#客户端#C  名称
function cfg_buff:GetName()
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

---@return number buff对应的技能#客户端#C  buff对应的技能ID（用于技能自动释放判断）
function cfg_buff:GetSkills()
    if self.skills ~= nil then
        return self.skills
    else
        if self:CsTABLE() ~= nil then
            self.skills = self:CsTABLE().skills
            return self.skills
        else
            return nil
        end
    end
end

---@return number 是否屏蔽buff#客户端#C  不填为不屏蔽 填了为屏蔽
function cfg_buff:GetDisplayType()
    if self.displayType ~= nil then
        return self.displayType
    else
        if self:CsTABLE() ~= nil then
            self.displayType = self:CsTABLE().displayType
            return self.displayType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao buff参数#客户端#C  buff效果值（特殊配置：1、施毒术：减物魔防百分比；2元素套装：等级;3经验丹：经验加成倍数；3、回血回蓝：回血值4、暴风雪：技能神圣伤害5、群毒术增伤：增伤万分比6、嗜血：单体触发概率#嗜血群体触发概率7、禁锢：单体技能触发概率#群体技能触发概率）8、自由触发：控制技能globalId#控制buffglobalId 9、自由：自由buff限制的bufftype（位移效果服务器写死）10、type70：灵兽血量万分比 11、type73：额外恢复血量万分比 12、强化只有辅助buff：治愈buffid 13、治愈术：攻击加血系数#固定值加血值 57、辅印守护血量维持参数（万分位比例） 113、护身戒指魔法抵扣伤害的比例，战士#法师#道士（万分位比例，如填20000，表示2点魔法抵扣1点伤害;）
function cfg_buff:GetParameter()
    if self.parameter ~= nil then
        return self.parameter
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().parameter
        else
            return nil
        end
    end
end

---@return string 场景展示文字#客户端#C
function cfg_buff:GetShow()
    if self.show ~= nil then
        return self.show
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().show
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 额外参数配置（即时战斗用)#客户端#C  buff的特殊参数配置，每个buff单独定义效果（1、施毒术：附加神圣伤害值。2、持续治疗：立即回复攻击百分比的生命；3、回血回蓝：回蓝值；4、油：配置触发的buffid；5魔法盾：受击特效id）6.元素套装保护期 7.秘能爆发、爆裂火符：技能id#等级（取伤害用)8.暴风雪：减速buffid 9.暴风雪定身：暴风雪bufferType 10、旋风斩：伤害技能id 11、暴风雪减速：玩家减速万分比 12群毒术增伤：火墙、毒、XP群攻增伤万分比 13嗜血：目标血量万分比要求#伤害万分比14自由buff：延迟生效时间（毫秒）15雷电（紫电）：辅助伤害技能id 16强化召唤：召唤物附加buff 17强化火墙地面buff：对自己灼烧#对他人灼烧
function cfg_buff:GetExtraParam()
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

---@return number 持续时间（即时战斗用)#客户端#C  毫秒（不填代表无时间限制）
function cfg_buff:GetTotalTime()
    if self.totalTime ~= nil then
        return self.totalTime
    else
        if self:CsTABLE() ~= nil then
            self.totalTime = self:CsTABLE().totalTime
            return self.totalTime
        else
            return nil
        end
    end
end

---@return number 间隔时间（即时战斗用）#客户端#C#不存在共同参与合并的字段  毫秒（触发效果的间隔时间，不填代表持续生效）
function cfg_buff:GetCdTime()
    if self.cdTime ~= nil then
        return self.cdTime
    else
        if self:CsTABLE() ~= nil then
            self.cdTime = self:CsTABLE().cdTime
            return self.cdTime
        else
            return nil
        end
    end
end

---@return string bufficon#客户端#C  头像下方的buff图标显示
function cfg_buff:GetIcon()
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

---@return string buff说明#客户端#C  buff列表中显示用描述
function cfg_buff:GetTxt()
    if self.txt ~= nil then
        return self.txt
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().txt
        else
            return nil
        end
    end
end

---@return number buff效果类型#客户端#C  1buff存在时持续生效；2普通攻击施法附加效果
function cfg_buff:GetBuffEffectType()
    if self.buffEffectType ~= nil then
        return self.buffEffectType
    else
        if self:CsTABLE() ~= nil then
            self.buffEffectType = self:CsTABLE().buffEffectType
            return self.buffEffectType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao buff特效#客户端#C  配effect表ID
function cfg_buff:GetBuffEffect()
    if self.buffEffect ~= nil then
        return self.buffEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().buffEffect
        else
            return nil
        end
    end
end

---@return number 最小物理攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetPhyAttackMin()
    if self.phyAttackMin ~= nil then
        return self.phyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMin = self:CsTABLE().phyAttackMin
            return self.phyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大物理攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetPhyAttackMax()
    if self.phyAttackMax ~= nil then
        return self.phyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.phyAttackMax = self:CsTABLE().phyAttackMax
            return self.phyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小魔法攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetMagicAttackMin()
    if self.magicAttackMin ~= nil then
        return self.magicAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMin = self:CsTABLE().magicAttackMin
            return self.magicAttackMin
        else
            return nil
        end
    end
end

---@return number 最大魔法攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetMagicAttackMax()
    if self.magicAttackMax ~= nil then
        return self.magicAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.magicAttackMax = self:CsTABLE().magicAttackMax
            return self.magicAttackMax
        else
            return nil
        end
    end
end

---@return number 最小道术攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetTaoAttackMin()
    if self.taoAttackMin ~= nil then
        return self.taoAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMin = self:CsTABLE().taoAttackMin
            return self.taoAttackMin
        else
            return nil
        end
    end
end

---@return number 最大道术攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetTaoAttackMax()
    if self.taoAttackMax ~= nil then
        return self.taoAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.taoAttackMax = self:CsTABLE().taoAttackMax
            return self.taoAttackMax
        else
            return nil
        end
    end
end

---@return number 最小物理防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetPhyDefenceMin()
    if self.phyDefenceMin ~= nil then
        return self.phyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMin = self:CsTABLE().phyDefenceMin
            return self.phyDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大物理防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetPhyDefenceMax()
    if self.phyDefenceMax ~= nil then
        return self.phyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.phyDefenceMax = self:CsTABLE().phyDefenceMax
            return self.phyDefenceMax
        else
            return nil
        end
    end
end

---@return number 最小魔法防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetMagicDefenceMin()
    if self.magicDefenceMin ~= nil then
        return self.magicDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMin = self:CsTABLE().magicDefenceMin
            return self.magicDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大魔法防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetMagicDefenceMax()
    if self.magicDefenceMax ~= nil then
        return self.magicDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.magicDefenceMax = self:CsTABLE().magicDefenceMax
            return self.magicDefenceMax
        else
            return nil
        end
    end
end

---@return number 火攻击上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetFireAttackMax()
    if self.fireAttackMax ~= nil then
        return self.fireAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.fireAttackMax = self:CsTABLE().fireAttackMax
            return self.fireAttackMax
        else
            return nil
        end
    end
end

---@return number 冰攻击上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetIceAttackMax()
    if self.iceAttackMax ~= nil then
        return self.iceAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.iceAttackMax = self:CsTABLE().iceAttackMax
            return self.iceAttackMax
        else
            return nil
        end
    end
end

---@return number 电攻击上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetElectricAttackMax()
    if self.electricAttackMax ~= nil then
        return self.electricAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.electricAttackMax = self:CsTABLE().electricAttackMax
            return self.electricAttackMax
        else
            return nil
        end
    end
end

---@return number 黑暗攻击上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetDarkAttackMax()
    if self.darkAttackMax ~= nil then
        return self.darkAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.darkAttackMax = self:CsTABLE().darkAttackMax
            return self.darkAttackMax
        else
            return nil
        end
    end
end

---@return number 穿刺攻击上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetPunctureAttackMax()
    if self.punctureAttackMax ~= nil then
        return self.punctureAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.punctureAttackMax = self:CsTABLE().punctureAttackMax
            return self.punctureAttackMax
        else
            return nil
        end
    end
end

---@return number 火元素防御上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetFireDefenceMax()
    if self.fireDefenceMax ~= nil then
        return self.fireDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.fireDefenceMax = self:CsTABLE().fireDefenceMax
            return self.fireDefenceMax
        else
            return nil
        end
    end
end

---@return number 冰元素防御上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetIceDefenceMax()
    if self.iceDefenceMax ~= nil then
        return self.iceDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.iceDefenceMax = self:CsTABLE().iceDefenceMax
            return self.iceDefenceMax
        else
            return nil
        end
    end
end

---@return number 雷元素防御上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetElectricDefenceMax()
    if self.electricDefenceMax ~= nil then
        return self.electricDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.electricDefenceMax = self:CsTABLE().electricDefenceMax
            return self.electricDefenceMax
        else
            return nil
        end
    end
end

---@return number 暗元素防御上限#客户端#C#不存在共同参与合并的字段  属性
function cfg_buff:GetDarkDefenceMax()
    if self.darkDefenceMax ~= nil then
        return self.darkDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.darkDefenceMax = self:CsTABLE().darkDefenceMax
            return self.darkDefenceMax
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 秘籍增加生命#客户端#C  属性（1战士#数值&2法师#数值&3道士#数值）
function cfg_buff:GetSecretSkillAddHp()
    if self.secretSkillAddHp ~= nil then
        return self.secretSkillAddHp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().secretSkillAddHp
        else
            return nil
        end
    end
end

---@return number icon显示分类#客户端#C#不存在共同参与合并的字段  同类型的buff，统一显示一个icon、描述、名称
function cfg_buff:GetIconType()
    if self.iconType ~= nil then
        return self.iconType
    else
        if self:CsTABLE() ~= nil then
            self.iconType = self:CsTABLE().iconType
            return self.iconType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao buff存在时的受击特效#客户端#C  buff存在时的受击特效
function cfg_buff:GetHitEffect()
    if self.hitEffect ~= nil then
        return self.hitEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().hitEffect
        else
            return nil
        end
    end
end

---@return number 最小神圣攻击#客户端#C  属性
function cfg_buff:GetHolyAttackMin()
    if self.holyAttackMin ~= nil then
        return self.holyAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMin = self:CsTABLE().holyAttackMin
            return self.holyAttackMin
        else
            return nil
        end
    end
end

---@return number 最大神圣攻击#客户端#C  属性
function cfg_buff:GetHolyAttackMax()
    if self.holyAttackMax ~= nil then
        return self.holyAttackMax
    else
        if self:CsTABLE() ~= nil then
            self.holyAttackMax = self:CsTABLE().holyAttackMax
            return self.holyAttackMax
        else
            return nil
        end
    end
end

---@return number 最小神圣防御#客户端#C  属性
function cfg_buff:GetHolyDefenceMin()
    if self.holyDefenceMin ~= nil then
        return self.holyDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMin = self:CsTABLE().holyDefenceMin
            return self.holyDefenceMin
        else
            return nil
        end
    end
end

---@return number 最大神圣防御#客户端#C  属性
function cfg_buff:GetHolyDefenceMax()
    if self.holyDefenceMax ~= nil then
        return self.holyDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.holyDefenceMax = self:CsTABLE().holyDefenceMax
            return self.holyDefenceMax
        else
            return nil
        end
    end
end

---@return number 战斗回血#客户端#C  属性
function cfg_buff:GetFightRec()
    if self.fightRec ~= nil then
        return self.fightRec
    else
        if self:CsTABLE() ~= nil then
            self.fightRec = self:CsTABLE().fightRec
            return self.fightRec
        else
            return nil
        end
    end
end

---@return number buff存在期间的持续动作#客户端#C  0无动作31普通下劈攻击  32举手施法  33斜劈 34冲撞 35跳斩 36旋风斩 37秘能爆发38暴风雪 39爆裂火符 40召唤群兽
function cfg_buff:GetEffectAction()
    if self.effectAction ~= nil then
        return self.effectAction
    else
        if self:CsTABLE() ~= nil then
            self.effectAction = self:CsTABLE().effectAction
            return self.effectAction
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 存在buff时隐藏特效模型#客户端#C  关联特效的模型id
function cfg_buff:GetExitBuffHideEffect()
    if self.exitBuffHideEffect ~= nil then
        return self.exitBuffHideEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().exitBuffHideEffect
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 特效互斥#客户端#C  拥有指定buffid时，不再添加此buff的特效
function cfg_buff:GetIntensifyBuffEffect()
    if self.intensifyBuffEffect ~= nil then
        return self.intensifyBuffEffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().intensifyBuffEffect
        else
            return nil
        end
    end
end

---@return number 原技能id#客户端#C  填对应原技能ID
function cfg_buff:GetOriginalSkill()
    if self.originalSkill ~= nil then
        return self.originalSkill
    else
        if self:CsTABLE() ~= nil then
            self.originalSkill = self:CsTABLE().originalSkill
            return self.originalSkill
        else
            return nil
        end
    end
end

---@return number 人物攻速#客户端#C  (仅客户端用)
function cfg_buff:GetRoleattackSpeed()
    if self.roleattackSpeed ~= nil then
        return self.roleattackSpeed
    else
        if self:CsTABLE() ~= nil then
            self.roleattackSpeed = self:CsTABLE().roleattackSpeed
            return self.roleattackSpeed
        else
            return nil
        end
    end
end

---@return number 人物移速#客户端#C  (仅客户端用)
function cfg_buff:GetMovingSpeed()
    if self.movingSpeed ~= nil then
        return self.movingSpeed
    else
        if self:CsTABLE() ~= nil then
            self.movingSpeed = self:CsTABLE().movingSpeed
            return self.movingSpeed
        else
            return nil
        end
    end
end

---@return number 怪物攻速#客户端#C  (仅客户端用)神兽骷髅灵兽怪物都用该字段
function cfg_buff:GetMonattackSpeed()
    if self.monattackSpeed ~= nil then
        return self.monattackSpeed
    else
        if self:CsTABLE() ~= nil then
            self.monattackSpeed = self:CsTABLE().monattackSpeed
            return self.monattackSpeed
        else
            return nil
        end
    end
end

---@return number 怪物移速#客户端#C  (仅客户端用)神兽骷髅灵兽怪物都用该字段
function cfg_buff:GetMonmovingSpeed()
    if self.monmovingSpeed ~= nil then
        return self.monmovingSpeed
    else
        if self:CsTABLE() ~= nil then
            self.monmovingSpeed = self:CsTABLE().monmovingSpeed
            return self.monmovingSpeed
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 特效互顶#客户端#C  添加此buff时，移除指定buffid的特效
function cfg_buff:GetIntensifyBuffEffect2()
    if self.intensifyBuffEffect2 ~= nil then
        return self.intensifyBuffEffect2
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().intensifyBuffEffect2
        else
            return nil
        end
    end
end

---@return number 骑马#客户端#C  骑马buff填1   默认为0
function cfg_buff:GetAvatarActionState()
    if self.avatarActionState ~= nil then
        return self.avatarActionState
    else
        if self:CsTABLE() ~= nil then
            self.avatarActionState = self:CsTABLE().avatarActionState
            return self.avatarActionState
        else
            return nil
        end
    end
end

---@return number 固定攻速加成#客户端#C  固定攻速类型，填写固定值，系数最高120
function cfg_buff:GetAttackSpeedRatio()
    if self.attackSpeedRatio ~= nil then
        return self.attackSpeedRatio
    else
        if self:CsTABLE() ~= nil then
            self.attackSpeedRatio = self:CsTABLE().attackSpeedRatio
            return self.attackSpeedRatio
        else
            return nil
        end
    end
end

---@return number 触发类型_C
function cfg_buff:GetTrigger()
    if self.trigger ~= nil then
        return self.trigger
    else
        if self:CsTABLE() ~= nil then
            self.trigger = self:CsTABLE().trigger
            return self.trigger
        else
            return nil
        end
    end
end
---@return number buff消失时机_C
function cfg_buff:GetDispelType()
    if self.dispelType ~= nil then
        return self.dispelType
    else
        if self:CsTABLE() ~= nil then
            self.dispelType = self:CsTABLE().dispelType
            return self.dispelType
        else
            return nil
        end
    end
end
---@return number buff类型_C
function cfg_buff:GetType()
    if self.type ~= nil then
        return self.type
    else
        if self:CsTABLE() ~= nil then
            self.type = self:CsTABLE().type
            return self.type
        else
            return nil
        end
    end
end

---@return number 子类型_C
function cfg_buff:GetSubType()
    if self.subType ~= nil then
        return self.subType
    else
        if self:CsTABLE() ~= nil then
            self.subType = self:CsTABLE().subType
            return self.subType
        else
            return nil
        end
    end
end
---@return number 等级_C
function cfg_buff:GetLevel()
    if self.level ~= nil then
        return self.level
    else
        if self:CsTABLE() ~= nil then
            self.level = self:CsTABLE().level
            return self.level
        else
            return nil
        end
    end
end
---@return number 是不是增益BUFF_C
function cfg_buff:GetIsGood()
    if self.isGood ~= nil then
        return self.isGood
    else
        if self:CsTABLE() ~= nil then
            self.isGood = self:CsTABLE().isGood
            return self.isGood
        else
            return nil
        end
    end
end
---@return number 目标_C
function cfg_buff:GetTarget()
    if self.target ~= nil then
        return self.target
    else
        if self:CsTABLE() ~= nil then
            self.target = self:CsTABLE().target
            return self.target
        else
            return nil
        end
    end
end

---@return number buff参数类型_C
function cfg_buff:GetParameterType()
    if self.parameterType ~= nil then
        return self.parameterType
    else
        if self:CsTABLE() ~= nil then
            self.parameterType = self:CsTABLE().parameterType
            return self.parameterType
        else
            return nil
        end
    end
end
---@return number 替代规则（即时战斗用)_C
function cfg_buff:GetReplace()
    if self.replace ~= nil then
        return self.replace
    else
        if self:CsTABLE() ~= nil then
            self.replace = self:CsTABLE().replace
            return self.replace
        else
            return nil
        end
    end
end
---@return number 特效显示优先级（即时战斗用)_C
function cfg_buff:GetShowPriority()
    if self.showPriority ~= nil then
        return self.showPriority
    else
        if self:CsTABLE() ~= nil then
            self.showPriority = self:CsTABLE().showPriority
            return self.showPriority
        else
            return nil
        end
    end
end

---@return number pk伤害加成（万分比）_C
function cfg_buff:GetPkAtt()
    if self.pkAtt ~= nil then
        return self.pkAtt
    else
        if self:CsTABLE() ~= nil then
            self.pkAtt = self:CsTABLE().pkAtt
            return self.pkAtt
        else
            return nil
        end
    end
end
---@return number pk防御加成（万分比）_C
function cfg_buff:GetPkDef()
    if self.pkDef ~= nil then
        return self.pkDef
    else
        if self:CsTABLE() ~= nil then
            self.pkDef = self:CsTABLE().pkDef
            return self.pkDef
        else
            return nil
        end
    end
end

---@return number 暴击伤害_C
function cfg_buff:GetCriticalDamage()
    if self.criticalDamage ~= nil then
        return self.criticalDamage
    else
        if self:CsTABLE() ~= nil then
            self.criticalDamage = self:CsTABLE().criticalDamage
            return self.criticalDamage
        else
            return nil
        end
    end
end
---@return number 攻击加成百分比_C
function cfg_buff:GetAtkPer()
    if self.atkPer ~= nil then
        return self.atkPer
    else
        if self:CsTABLE() ~= nil then
            self.atkPer = self:CsTABLE().atkPer
            return self.atkPer
        else
            return nil
        end
    end
end

---@return number 防御加成百分比_C
function cfg_buff:GetDefPer()
    if self.defPer ~= nil then
        return self.defPer
    else
        if self:CsTABLE() ~= nil then
            self.defPer = self:CsTABLE().defPer
            return self.defPer
        else
            return nil
        end
    end
end
---@return number 延迟显示_C
function cfg_buff:GetShowDelay()
    if self.showDelay ~= nil then
        return self.showDelay
    else
        if self:CsTABLE() ~= nil then
            self.showDelay = self:CsTABLE().showDelay
            return self.showDelay
        else
            return nil
        end
    end
end
---@return number 元灵生命上限_C
function cfg_buff:GetPhantomHp()
    if self.phantomHp ~= nil then
        return self.phantomHp
    else
        if self:CsTABLE() ~= nil then
            self.phantomHp = self:CsTABLE().phantomHp
            return self.phantomHp
        else
            return nil
        end
    end
end

---@return number 穿刺元素防御上限_C
function cfg_buff:GetPunctureDefenceMax()
    if self.punctureDefenceMax ~= nil then
        return self.punctureDefenceMax
    else
        if self:CsTABLE() ~= nil then
            self.punctureDefenceMax = self:CsTABLE().punctureDefenceMax
            return self.punctureDefenceMax
        else
            return nil
        end
    end
end
---@return number 是否飘血_C
function cfg_buff:GetIsBloodWord()
    if self.isBloodWord ~= nil then
        return self.isBloodWord
    else
        if self:CsTABLE() ~= nil then
            self.isBloodWord = self:CsTABLE().isBloodWord
            return self.isBloodWord
        else
            return nil
        end
    end
end

---@return string tips中的buff说明#客户端  道具tips中需要显示的效果描述，分三职业显示时，用#分隔，默认顺序战士#法师#道士
function cfg_buff:GetTipsTxt()
    if self.tipsTxt ~= nil then
        return self.tipsTxt
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tipsTxt
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 血量#客户端  战士#法师#道士
function cfg_buff:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().maxHp
        else
            return nil
        end
    end
end

---@return number 闪避#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetDodge()
    if self.dodge ~= nil then
        return self.dodge
    else
        if self:CsTABLE() ~= nil then
            self.dodge = self:CsTABLE().dodge
            return self.dodge
        else
            return nil
        end
    end
end

---@return number 准确#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetAccurate()
    if self.accurate ~= nil then
        return self.accurate
    else
        if self:CsTABLE() ~= nil then
            self.accurate = self:CsTABLE().accurate
            return self.accurate
        else
            return nil
        end
    end
end

---@return number 内力#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetInnerPowerMax()
    if self.innerPowerMax ~= nil then
        return self.innerPowerMax
    else
        if self:CsTABLE() ~= nil then
            self.innerPowerMax = self:CsTABLE().innerPowerMax
            return self.innerPowerMax
        else
            return nil
        end
    end
end

---@return number 暴击率（万分比）#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetCritical()
    if self.critical ~= nil then
        return self.critical
    else
        if self:CsTABLE() ~= nil then
            self.critical = self:CsTABLE().critical
            return self.critical
        else
            return nil
        end
    end
end

---@return number 火攻击下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetFireAttackMin()
    if self.fireAttackMin ~= nil then
        return self.fireAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.fireAttackMin = self:CsTABLE().fireAttackMin
            return self.fireAttackMin
        else
            return nil
        end
    end
end

---@return number 冰攻击下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetIceAttackMin()
    if self.iceAttackMin ~= nil then
        return self.iceAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.iceAttackMin = self:CsTABLE().iceAttackMin
            return self.iceAttackMin
        else
            return nil
        end
    end
end

---@return number 电攻击下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetElectricAttackMin()
    if self.electricAttackMin ~= nil then
        return self.electricAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.electricAttackMin = self:CsTABLE().electricAttackMin
            return self.electricAttackMin
        else
            return nil
        end
    end
end

---@return number 黑暗攻击下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetDarkAttackMin()
    if self.darkAttackMin ~= nil then
        return self.darkAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.darkAttackMin = self:CsTABLE().darkAttackMin
            return self.darkAttackMin
        else
            return nil
        end
    end
end

---@return number 穿刺攻击下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetPunctureAttackMin()
    if self.punctureAttackMin ~= nil then
        return self.punctureAttackMin
    else
        if self:CsTABLE() ~= nil then
            self.punctureAttackMin = self:CsTABLE().punctureAttackMin
            return self.punctureAttackMin
        else
            return nil
        end
    end
end

---@return number 火元素防御下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetFireDefenceMin()
    if self.fireDefenceMin ~= nil then
        return self.fireDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.fireDefenceMin = self:CsTABLE().fireDefenceMin
            return self.fireDefenceMin
        else
            return nil
        end
    end
end

---@return number 冰元素防御下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetIceDefenceMin()
    if self.iceDefenceMin ~= nil then
        return self.iceDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.iceDefenceMin = self:CsTABLE().iceDefenceMin
            return self.iceDefenceMin
        else
            return nil
        end
    end
end

---@return number 雷元素防御下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetElectricDefenceMin()
    if self.electricDefenceMin ~= nil then
        return self.electricDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.electricDefenceMin = self:CsTABLE().electricDefenceMin
            return self.electricDefenceMin
        else
            return nil
        end
    end
end

---@return number 暗元素防御下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetDarkDefenceMin()
    if self.darkDefenceMin ~= nil then
        return self.darkDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.darkDefenceMin = self:CsTABLE().darkDefenceMin
            return self.darkDefenceMin
        else
            return nil
        end
    end
end

---@return number 穿刺元素防御下限#客户端#不存在共同参与合并的字段  属性
function cfg_buff:GetPunctureDefenceMin()
    if self.punctureDefenceMin ~= nil then
        return self.punctureDefenceMin
    else
        if self:CsTABLE() ~= nil then
            self.punctureDefenceMin = self:CsTABLE().punctureDefenceMin
            return self.punctureDefenceMin
        else
            return nil
        end
    end
end

---@return number 掉宝概率#客户端  掉宝概率(十万分比)
function cfg_buff:GetAddDropTreasure()
    if self.addDropTreasure ~= nil then
        return self.addDropTreasure
    else
        if self:CsTABLE() ~= nil then
            self.addDropTreasure = self:CsTABLE().addDropTreasure
            return self.addDropTreasure
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_BUFF C#中的数据结构
function cfg_buff:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_BuffTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_buff lua中的数据结构
function cfg_buff:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.tipsTxt = decodedData.tipsTxt
    
    ---@private
    self.maxHp = decodedData.maxHp
    
    ---@private
    self.dodge = decodedData.dodge
    
    ---@private
    self.accurate = decodedData.accurate
    
    ---@private
    self.innerPowerMax = decodedData.innerPowerMax
    
    ---@private
    self.critical = decodedData.critical
    
    ---@private
    self.fireAttackMin = decodedData.fireAttackMin
    
    ---@private
    self.iceAttackMin = decodedData.iceAttackMin
    
    ---@private
    self.electricAttackMin = decodedData.electricAttackMin
    
    ---@private
    self.darkAttackMin = decodedData.darkAttackMin
    
    ---@private
    self.punctureAttackMin = decodedData.punctureAttackMin
    
    ---@private
    self.fireDefenceMin = decodedData.fireDefenceMin
    
    ---@private
    self.iceDefenceMin = decodedData.iceDefenceMin
    
    ---@private
    self.electricDefenceMin = decodedData.electricDefenceMin
    
    ---@private
    self.darkDefenceMin = decodedData.darkDefenceMin
    
    ---@private
    self.punctureDefenceMin = decodedData.punctureDefenceMin
    
    ---@private
    self.addDropTreasure = decodedData.addDropTreasure
end

return cfg_buff