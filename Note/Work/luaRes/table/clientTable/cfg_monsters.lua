--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_monsters
local cfg_monsters = {}

cfg_monsters.__index = cfg_monsters

function cfg_monsters:UUID()
    return self.id
end

---@return number 怪物id#客户端#C#不存在共同参与合并的字段  前3位对应地图id前三位，第四位区分1小怪/2精英怪/3boss，后2位对应怪物编号，四位数的为灵兽id
function cfg_monsters:GetId()
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

---@return string 怪物名称#客户端#C
function cfg_monsters:GetName()
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

---@return string 怪物等级显示#客户端#C  客户端显示等级
function cfg_monsters:GetShowLevel()
    if self.showLevel ~= nil then
        return self.showLevel
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().showLevel
        else
            return nil
        end
    end
end

---@return number 脚底光圈#客户端#C  0不显示选中框 非0显示 默认非0
function cfg_monsters:GetCircle()
    if self.circle ~= nil then
        return self.circle
    else
        if self:CsTABLE() ~= nil then
            self.circle = self:CsTABLE().circle
            return self.circle
        else
            return nil
        end
    end
end

---@return string 怪物战斗力#客户端#C  战斗力（暂时没有用）
function cfg_monsters:GetNbvalue()
    if self.nbvalue ~= nil then
        return self.nbvalue
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().nbvalue
        else
            return nil
        end
    end
end

---@return number 怪物头像#客户端#C#不存在共同参与合并的字段  怪物头像名称
function cfg_monsters:GetHead()
    if self.head ~= nil then
        return self.head
    else
        if self:CsTABLE() ~= nil then
            self.head = self:CsTABLE().head
            return self.head
        else
            return nil
        end
    end
end

---@return number 怪物模型#客户端#C  怪物模型
function cfg_monsters:GetModel()
    if self.model ~= nil then
        return self.model
    else
        if self:CsTABLE() ~= nil then
            self.model = self:CsTABLE().model
            return self.model
        else
            return nil
        end
    end
end

---@return number 怪物头盔模型#客户端#C  怪物头盔模型，不填不显示
function cfg_monsters:GetHeadModel()
    if self.headModel ~= nil then
        return self.headModel
    else
        if self:CsTABLE() ~= nil then
            self.headModel = self:CsTABLE().headModel
            return self.headModel
        else
            return nil
        end
    end
end

---@return number 怪物武器模型#客户端#C  怪物武器模型，不填不显示
function cfg_monsters:GetWeapModel()
    if self.weapModel ~= nil then
        return self.weapModel
    else
        if self:CsTABLE() ~= nil then
            self.weapModel = self:CsTABLE().weapModel
            return self.weapModel
        else
            return nil
        end
    end
end

---@return number 生命值#客户端#C  属性 生命
function cfg_monsters:GetMaxHp()
    if self.maxHp ~= nil then
        return self.maxHp
    else
        if self:CsTABLE() ~= nil then
            self.maxHp = self:CsTABLE().maxHp
            return self.maxHp
        else
            return nil
        end
    end
end

---@return number 最大物理攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetPhyAttackMax()
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

---@return number 最小物理攻击#客户端#合并#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetPhyAttackMin()
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

---@return number 最大物理防御#客户端#合并#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetPhyDefenceMax()
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

---@return number 最小物理防御#客户端#合并#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetPhyDefenceMin()
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

---@return number 最大魔法防御#客户端#合并#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetMagicDefenceMax()
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

---@return number 最小神圣攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetHolyAttackMin()
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

---@return number 最大神圣攻击#客户端#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetHolyAttackMax()
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

---@return number 最小神圣防御#客户端#C#不存在共同参与合并的字段  属性
function cfg_monsters:GetHolyDefenceMin()
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

---@return TABLE.IntListJingHao 头顶层级#客户端#C  不填默认系统层级，若填写，则按填写值来（默认-1000）
function cfg_monsters:GetActorpos()
    if self.actorpos ~= nil then
        return self.actorpos
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().actorpos
        else
            return nil
        end
    end
end

---@return number 复活时间间隔#客户端#C  类型1.毫秒 2.小时（必须把24整除）5.秒6.秒
function cfg_monsters:GetReliveDelay()
    if self.reliveDelay ~= nil then
        return self.reliveDelay
    else
        if self:CsTABLE() ~= nil then
            self.reliveDelay = self:CsTABLE().reliveDelay
            return self.reliveDelay
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 刷新时间根据开服天数变化#客户端#C  天数#时间&天数#时间
function cfg_monsters:GetReliveDelayNew()
    if self.reliveDelayNew ~= nil then
        return self.reliveDelayNew
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reliveDelayNew
        else
            return nil
        end
    end
end

---@return string 怪物说话#客户端#C  怪物说话内容，不填表示没有
function cfg_monsters:GetTalk()
    if self.talk ~= nil then
        return self.talk
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().talk
        else
            return nil
        end
    end
end

---@return number 经验#客户端#C  人物经验
function cfg_monsters:GetExp()
    if self.exp ~= nil then
        return self.exp
    else
        if self:CsTABLE() ~= nil then
            self.exp = self:CsTABLE().exp
            return self.exp
        else
            return nil
        end
    end
end

---@return number 元灵经验#客户端#C  元灵经验
function cfg_monsters:GetHsexp()
    if self.hsexp ~= nil then
        return self.hsexp
    else
        if self:CsTABLE() ~= nil then
            self.hsexp = self:CsTABLE().hsexp
            return self.hsexp
        else
            return nil
        end
    end
end

---@return number 内功经验#客户端#C#不存在共同参与合并的字段  内功经验
function cfg_monsters:GetInternalExp()
    if self.internalExp ~= nil then
        return self.internalExp
    else
        if self:CsTABLE() ~= nil then
            self.internalExp = self:CsTABLE().internalExp
            return self.internalExp
        else
            return nil
        end
    end
end

---@return TABLE.IntList 死亡特效#客户端#C  （死亡触发）第一位：0.没有，9.闪光，10.溶解，8.石化,12.呼吸光。第二位：附属类型（例如石化有效果1和效果2；溶解也有效果1和2）；第三-五位：RGBA。第六位：对应特效ID
function cfg_monsters:GetDeathstate()
    if self.deathstate ~= nil then
        return self.deathstate
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().deathstate
        else
            return nil
        end
    end
end

---@return TABLE.IntList 尸体溶解#客户端#C  （移除视野触发，会导致延迟消失）第一位：0.没有，9.闪光，10.溶解，8.石化,12.呼吸光。第二位：时间；第三位：附属类型（例如石化有效果1和效果2；溶解也有效果1和2）；第四-七位：RGBA。第六位：对应特效ID
function cfg_monsters:GetCollecteffect()
    if self.collecteffect ~= nil then
        return self.collecteffect
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().collecteffect
        else
            return nil
        end
    end
end

---@return TABLE.IntList 碰撞盒尺寸#客户端#C  没有指定碰撞盒使用默认碰撞盒宽高50, 140, 50 只有正常的碰撞x/y/z 3参数 死亡的时候碰撞盒大小不变，仅仅做偏差x/y/z/px/pz 5参数 死亡的时候碰撞大小改变没有偏差x/y/z/dx/dy/dz 6参数 死亡的时候碰撞大小改变也有偏差x/y/z/dx/dy/dz/px/pz 8参数 3参数5参数6参数8参数
function cfg_monsters:GetSizeHeight()
    if self.sizeHeight ~= nil then
        return self.sizeHeight
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().sizeHeight
        else
            return nil
        end
    end
end

---@return number 模型动作移动表现速度#客户端#C  模型动作移动表现速度
function cfg_monsters:GetMoveBaseMultiply()
    if self.MoveBaseMultiply ~= nil then
        return self.MoveBaseMultiply
    else
        if self:CsTABLE() ~= nil then
            self.MoveBaseMultiply = self:CsTABLE().MoveBaseMultiply
            return self.MoveBaseMultiply
        else
            return nil
        end
    end
end

---@return string 是否挖肉#客户端#C  采集后显示骨头1
function cfg_monsters:GetGatherShowId()
    if self.gatherShowId ~= nil then
        return self.gatherShowId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().gatherShowId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 死亡特效#客户端#C  死亡特效id#播放特殊时是否隐藏模型（1隐藏，0不隐藏）
function cfg_monsters:GetEffectId()
    if self.effectId ~= nil then
        return self.effectId
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().effectId
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 掉落展示#客户端#C  跳转cfg_boss_drop_show
function cfg_monsters:GetDropShow()
    if self.dropShow ~= nil then
        return self.dropShow
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().dropShow
        else
            return nil
        end
    end
end

---@return TABLE.IntList 出生特效#客户端#C  第一位：出生动画（0.没有，其他状态机的值）第二位：0没有，9.闪光，10.溶解，8.石化。第三-六位：RGBA。第7位：对应特效ID
function cfg_monsters:GetBornState()
    if self.bornState ~= nil then
        return self.bornState
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bornState
        else
            return nil
        end
    end
end

---@return number 尸体消失是否下沉#客户端#C#不存在共同参与合并的字段  尸体消失是否下沉，填下沉需要的时间。默认不下沉
function cfg_monsters:GetSink()
    if self.sink ~= nil then
        return self.sink
    else
        if self:CsTABLE() ~= nil then
            self.sink = self:CsTABLE().sink
            return self.sink
        else
            return nil
        end
    end
end

---@return TABLE.IntListList 怪物百分比扣血#客户端#C  对怪造成伤害百分比扣血，人物对怪造成&灵兽对怪造成&神兽骷髅对怪造成 #分割上限下限伤害（万分比）#火墙毒持续伤害的上下限（万分比）
function cfg_monsters:GetPercentageDamage()
    if self.percentageDamage ~= nil then
        return self.percentageDamage
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().percentageDamage
        else
            return nil
        end
    end
end

---@return number 功能类型#客户端#C  目前仅塔罗神庙用 0正常怪1塔罗神庙石化2塔罗神庙正常 3水晶类型 4抓马类型
function cfg_monsters:GetFunctionType()
    if self.functionType ~= nil then
        return self.functionType
    else
        if self:CsTABLE() ~= nil then
            self.functionType = self:CsTABLE().functionType
            return self.functionType
        else
            return nil
        end
    end
end

---@return number 是否有归属#客户端#C  怪物是否有归属 0有归属，1无归属 默认有归属
function cfg_monsters:GetAscription()
    if self.ascription ~= nil then
        return self.ascription
    else
        if self:CsTABLE() ~= nil then
            self.ascription = self:CsTABLE().ascription
            return self.ascription
        else
            return nil
        end
    end
end

---@return number 挖掘消耗腕力#客户端#C  不填代表挖掘时不消耗腕力且不计算耐久消耗
function cfg_monsters:GetPowerConsume()
    if self.powerConsume ~= nil then
        return self.powerConsume
    else
        if self:CsTABLE() ~= nil then
            self.powerConsume = self:CsTABLE().powerConsume
            return self.powerConsume
        else
            return nil
        end
    end
end

---@return number 击杀消耗精力#客户端#C  不填代表击杀时不消耗精力且不计算耐久消耗
function cfg_monsters:GetEnergyConsume()
    if self.energyConsume ~= nil then
        return self.energyConsume
    else
        if self:CsTABLE() ~= nil then
            self.energyConsume = self:CsTABLE().energyConsume
            return self.energyConsume
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 清除复活cd花费#客户端#C  目前仅塔罗神庙用，怪物死亡复活cd花费清除，itemID#num
function cfg_monsters:GetReviveTimeClearCost()
    if self.reviveTimeClearCost ~= nil then
        return self.reviveTimeClearCost
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().reviveTimeClearCost
        else
            return nil
        end
    end
end

---@return number 怪物死亡墓碑是否需要展示2D贴图#客户端#C  0否1是，默认0.目前仅塔罗神庙用，随机怪死亡后复活的墓碑需要展示2d贴图
function cfg_monsters:GetIsGraveMapping()
    if self.isGraveMapping ~= nil then
        return self.isGraveMapping
    else
        if self:CsTABLE() ~= nil then
            self.isGraveMapping = self:CsTABLE().isGraveMapping
            return self.isGraveMapping
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 死亡动作#客户端#C  动作#释放为持续动作（3NPC暂时；10跑步；11走路；12挖矿；13死亡；14展示；15采集；16待机；31普通攻击；32斜砍；33冲撞）（0持续1不持续）
function cfg_monsters:GetDeadAction()
    if self.deadAction ~= nil then
        return self.deadAction
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().deadAction
        else
            return nil
        end
    end
end

---@return number 触发可采集概率#客户端#C  配置触发采集的概率（万分比）
function cfg_monsters:GetCollectionQuantity()
    if self.collectionQuantity ~= nil then
        return self.collectionQuantity
    else
        if self:CsTABLE() ~= nil then
            self.collectionQuantity = self:CsTABLE().collectionQuantity
            return self.collectionQuantity
        else
            return nil
        end
    end
end

---@return number 怪物类型_C
function cfg_monsters:GetType()
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
---@return number 怪物等级_C
function cfg_monsters:GetLevel()
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

---@return number 怪物转生等级_C
function cfg_monsters:GetReinLv()
    if self.reinLv ~= nil then
        return self.reinLv
    else
        if self:CsTABLE() ~= nil then
            self.reinLv = self:CsTABLE().reinLv
            return self.reinLv
        else
            return nil
        end
    end
end
---@return number 怪物血条数量_C
function cfg_monsters:GetHpshow()
    if self.hpshow ~= nil then
        return self.hpshow
    else
        if self:CsTABLE() ~= nil then
            self.hpshow = self:CsTABLE().hpshow
            return self.hpshow
        else
            return nil
        end
    end
end
---@return number _C
function cfg_monsters:GetCircleScale()
    if self.circleScale ~= nil then
        return self.circleScale
    else
        if self:CsTABLE() ~= nil then
            self.circleScale = self:CsTABLE().circleScale
            return self.circleScale
        else
            return nil
        end
    end
end

---@return number 怪物死亡模型引用_C
function cfg_monsters:GetDeathmodel()
    if self.deathmodel ~= nil then
        return self.deathmodel
    else
        if self:CsTABLE() ~= nil then
            self.deathmodel = self:CsTABLE().deathmodel
            return self.deathmodel
        else
            return nil
        end
    end
end
---@return number 怪物朝向_C
function cfg_monsters:GetInitDirection()
    if self.initDirection ~= nil then
        return self.initDirection
    else
        if self:CsTABLE() ~= nil then
            self.initDirection = self:CsTABLE().initDirection
            return self.initDirection
        else
            return nil
        end
    end
end

---@return number 最小魔法防御_C
function cfg_monsters:GetMagicDefenceMin()
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
---@return number 准确_C
function cfg_monsters:GetAccurate()
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
---@return number 闪避_C
function cfg_monsters:GetDodge()
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

---@return number 最大神圣防御_C
function cfg_monsters:GetHolyDefenceMax()
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
---@return number 血条位置_C
function cfg_monsters:GetBloodY()
    if self.bloodY ~= nil then
        return self.bloodY
    else
        if self:CsTABLE() ~= nil then
            self.bloodY = self:CsTABLE().bloodY
            return self.bloodY
        else
            return nil
        end
    end
end
---@return number 怪物是否能转向_C
function cfg_monsters:GetIsrotate()
    if self.isrotate ~= nil then
        return self.isrotate
    else
        if self:CsTABLE() ~= nil then
            self.isrotate = self:CsTABLE().isrotate
            return self.isrotate
        else
            return nil
        end
    end
end

---@return number 模型百分比_C
function cfg_monsters:GetScale()
    if self.scale ~= nil then
        return self.scale
    else
        if self:CsTABLE() ~= nil then
            self.scale = self:CsTABLE().scale
            return self.scale
        else
            return nil
        end
    end
end
---@return number 免伤穿透_C
function cfg_monsters:GetReliefPenetrate()
    if self.reliefPenetrate ~= nil then
        return self.reliefPenetrate
    else
        if self:CsTABLE() ~= nil then
            self.reliefPenetrate = self:CsTABLE().reliefPenetrate
            return self.reliefPenetrate
        else
            return nil
        end
    end
end
---@return number 免伤_C
function cfg_monsters:GetRelief()
    if self.relief ~= nil then
        return self.relief
    else
        if self:CsTABLE() ~= nil then
            self.relief = self:CsTABLE().relief
            return self.relief
        else
            return nil
        end
    end
end
---@return number 对战士伤害加成_C
function cfg_monsters:GetZsHurtAdd()
    if self.zsHurtAdd ~= nil then
        return self.zsHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.zsHurtAdd = self:CsTABLE().zsHurtAdd
            return self.zsHurtAdd
        else
            return nil
        end
    end
end
---@return number 对法师伤害加成_C
function cfg_monsters:GetFsHurtAdd()
    if self.fsHurtAdd ~= nil then
        return self.fsHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.fsHurtAdd = self:CsTABLE().fsHurtAdd
            return self.fsHurtAdd
        else
            return nil
        end
    end
end
---@return number 对道士伤害加成_C
function cfg_monsters:GetDsHurtAdd()
    if self.dsHurtAdd ~= nil then
        return self.dsHurtAdd
    else
        if self:CsTABLE() ~= nil then
            self.dsHurtAdd = self:CsTABLE().dsHurtAdd
            return self.dsHurtAdd
        else
            return nil
        end
    end
end
---@return number 受战士伤害减免_C
function cfg_monsters:GetZsHurtedRelief()
    if self.zsHurtedRelief ~= nil then
        return self.zsHurtedRelief
    else
        if self:CsTABLE() ~= nil then
            self.zsHurtedRelief = self:CsTABLE().zsHurtedRelief
            return self.zsHurtedRelief
        else
            return nil
        end
    end
end
---@return number 受法师伤害减免_C
function cfg_monsters:GetFsHurtedRelief()
    if self.fsHurtedRelief ~= nil then
        return self.fsHurtedRelief
    else
        if self:CsTABLE() ~= nil then
            self.fsHurtedRelief = self:CsTABLE().fsHurtedRelief
            return self.fsHurtedRelief
        else
            return nil
        end
    end
end
---@return number 受道士伤害减免_C
function cfg_monsters:GetDsHurtedRelief()
    if self.dsHurtedRelief ~= nil then
        return self.dsHurtedRelief
    else
        if self:CsTABLE() ~= nil then
            self.dsHurtedRelief = self:CsTABLE().dsHurtedRelief
            return self.dsHurtedRelief
        else
            return nil
        end
    end
end
---@return number 攻速_C
function cfg_monsters:GetAttackSpeed()
    if self.attackSpeed ~= nil then
        return self.attackSpeed
    else
        if self:CsTABLE() ~= nil then
            self.attackSpeed = self:CsTABLE().attackSpeed
            return self.attackSpeed
        else
            return nil
        end
    end
end
---@return number 移动动作_C
function cfg_monsters:GetMoveAction()
    if self.moveAction ~= nil then
        return self.moveAction
    else
        if self:CsTABLE() ~= nil then
            self.moveAction = self:CsTABLE().moveAction
            return self.moveAction
        else
            return nil
        end
    end
end

---@return number 每次移动的时间间隔_C
function cfg_monsters:GetMoveInterval()
    if self.moveInterval ~= nil then
        return self.moveInterval
    else
        if self:CsTABLE() ~= nil then
            self.moveInterval = self:CsTABLE().moveInterval
            return self.moveInterval
        else
            return nil
        end
    end
end
---@return number 能否被击退_C
function cfg_monsters:GetCanRepel()
    if self.canRepel ~= nil then
        return self.canRepel
    else
        if self:CsTABLE() ~= nil then
            self.canRepel = self:CsTABLE().canRepel
            return self.canRepel
        else
            return nil
        end
    end
end

---@return number AI类型_C
function cfg_monsters:GetAitype()
    if self.aitype ~= nil then
        return self.aitype
    else
        if self:CsTABLE() ~= nil then
            self.aitype = self:CsTABLE().aitype
            return self.aitype
        else
            return nil
        end
    end
end
---@return number 追击范围_C
function cfg_monsters:GetToattackarea()
    if self.toattackarea ~= nil then
        return self.toattackarea
    else
        if self:CsTABLE() ~= nil then
            self.toattackarea = self:CsTABLE().toattackarea
            return self.toattackarea
        else
            return nil
        end
    end
end

---@return number 巡逻范围_C
function cfg_monsters:GetBornDistance()
    if self.bornDistance ~= nil then
        return self.bornDistance
    else
        if self:CsTABLE() ~= nil then
            self.bornDistance = self:CsTABLE().bornDistance
            return self.bornDistance
        else
            return nil
        end
    end
end
---@return number 警戒范围_C
function cfg_monsters:GetViewRange()
    if self.viewRange ~= nil then
        return self.viewRange
    else
        if self:CsTABLE() ~= nil then
            self.viewRange = self:CsTABLE().viewRange
            return self.viewRange
        else
            return nil
        end
    end
end
---@return number 心跳_C
function cfg_monsters:GetHeart()
    if self.heart ~= nil then
        return self.heart
    else
        if self:CsTABLE() ~= nil then
            self.heart = self:CsTABLE().heart
            return self.heart
        else
            return nil
        end
    end
end

---@return number 尸体清除时间_C
function cfg_monsters:GetDieDelay()
    if self.dieDelay ~= nil then
        return self.dieDelay
    else
        if self:CsTABLE() ~= nil then
            self.dieDelay = self:CsTABLE().dieDelay
            return self.dieDelay
        else
            return nil
        end
    end
end
---@return number 复活类型_C
function cfg_monsters:GetReliveType()
    if self.reliveType ~= nil then
        return self.reliveType
    else
        if self:CsTABLE() ~= nil then
            self.reliveType = self:CsTABLE().reliveType
            return self.reliveType
        else
            return nil
        end
    end
end
---@return number 是否全地图随机刷新_C
function cfg_monsters:GetRandomRefresh()
    if self.randomRefresh ~= nil then
        return self.randomRefresh
    else
        if self:CsTABLE() ~= nil then
            self.randomRefresh = self:CsTABLE().randomRefresh
            return self.randomRefresh
        else
            return nil
        end
    end
end
---@return number 怪物说话类型_C
function cfg_monsters:GetTalkType()
    if self.talkType ~= nil then
        return self.talkType
    else
        if self:CsTABLE() ~= nil then
            self.talkType = self:CsTABLE().talkType
            return self.talkType
        else
            return nil
        end
    end
end
---@return number 说话显示时间_C
function cfg_monsters:GetTalkTime()
    if self.talkTime ~= nil then
        return self.talkTime
    else
        if self:CsTABLE() ~= nil then
            self.talkTime = self:CsTABLE().talkTime
            return self.talkTime
        else
            return nil
        end
    end
end

---@return number 战斗回血_C
function cfg_monsters:GetFightRec()
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
---@return number 地元素攻击_C
function cfg_monsters:GetDAtk()
    if self.dAtk ~= nil then
        return self.dAtk
    else
        if self:CsTABLE() ~= nil then
            self.dAtk = self:CsTABLE().dAtk
            return self.dAtk
        else
            return nil
        end
    end
end
---@return number 风元素攻击_C
function cfg_monsters:GetFAtk()
    if self.fAtk ~= nil then
        return self.fAtk
    else
        if self:CsTABLE() ~= nil then
            self.fAtk = self:CsTABLE().fAtk
            return self.fAtk
        else
            return nil
        end
    end
end
---@return number 水元素攻击_C
function cfg_monsters:GetSAtk()
    if self.sAtk ~= nil then
        return self.sAtk
    else
        if self:CsTABLE() ~= nil then
            self.sAtk = self:CsTABLE().sAtk
            return self.sAtk
        else
            return nil
        end
    end
end
---@return number 火元素攻击_C
function cfg_monsters:GetHAtk()
    if self.hAtk ~= nil then
        return self.hAtk
    else
        if self:CsTABLE() ~= nil then
            self.hAtk = self:CsTABLE().hAtk
            return self.hAtk
        else
            return nil
        end
    end
end
---@return number 地元素抵抗_C
function cfg_monsters:GetDDef()
    if self.dDef ~= nil then
        return self.dDef
    else
        if self:CsTABLE() ~= nil then
            self.dDef = self:CsTABLE().dDef
            return self.dDef
        else
            return nil
        end
    end
end
---@return number 风元素抵抗_C
function cfg_monsters:GetFDef()
    if self.fDef ~= nil then
        return self.fDef
    else
        if self:CsTABLE() ~= nil then
            self.fDef = self:CsTABLE().fDef
            return self.fDef
        else
            return nil
        end
    end
end
---@return number 水元素抵抗_C
function cfg_monsters:GetSDef()
    if self.sDef ~= nil then
        return self.sDef
    else
        if self:CsTABLE() ~= nil then
            self.sDef = self:CsTABLE().sDef
            return self.sDef
        else
            return nil
        end
    end
end
---@return number 火元素抵抗_C
function cfg_monsters:GetHDef()
    if self.hDef ~= nil then
        return self.hDef
    else
        if self:CsTABLE() ~= nil then
            self.hDef = self:CsTABLE().hDef
            return self.hDef
        else
            return nil
        end
    end
end

---@return number 是否可采集_C
function cfg_monsters:GetDig()
    if self.dig ~= nil then
        return self.dig
    else
        if self:CsTABLE() ~= nil then
            self.dig = self:CsTABLE().dig
            return self.dig
        else
            return nil
        end
    end
end
---@return number 出生动画播放时长_C
function cfg_monsters:GetAnimationDuration()
    if self.animationDuration ~= nil then
        return self.animationDuration
    else
        if self:CsTABLE() ~= nil then
            self.animationDuration = self:CsTABLE().animationDuration
            return self.animationDuration
        else
            return nil
        end
    end
end
---@return number 怪物死亡倒地方向_C
function cfg_monsters:GetDeathD()
    if self.deathD ~= nil then
        return self.deathD
    else
        if self:CsTABLE() ~= nil then
            self.deathD = self:CsTABLE().deathD
            return self.deathD
        else
            return nil
        end
    end
end

---@return number 怪物移动速度_C
function cfg_monsters:GetSpeed()
    if self.speed ~= nil then
        return self.speed
    else
        if self:CsTABLE() ~= nil then
            self.speed = self:CsTABLE().speed
            return self.speed
        else
            return nil
        end
    end
end
---@return number 移动音效_C
function cfg_monsters:GetMovsd()
    if self.movsd ~= nil then
        return self.movsd
    else
        if self:CsTABLE() ~= nil then
            self.movsd = self:CsTABLE().movsd
            return self.movsd
        else
            return nil
        end
    end
end

---@return number 攻击音效_C
function cfg_monsters:GetAtksd()
    if self.atksd ~= nil then
        return self.atksd
    else
        if self:CsTABLE() ~= nil then
            self.atksd = self:CsTABLE().atksd
            return self.atksd
        else
            return nil
        end
    end
end
---@return number 受击音效_C
function cfg_monsters:GetBeatksd()
    if self.beatksd ~= nil then
        return self.beatksd
    else
        if self:CsTABLE() ~= nil then
            self.beatksd = self:CsTABLE().beatksd
            return self.beatksd
        else
            return nil
        end
    end
end

---@return number 死亡音效_C
function cfg_monsters:GetDeathsd()
    if self.deathsd ~= nil then
        return self.deathsd
    else
        if self:CsTABLE() ~= nil then
            self.deathsd = self:CsTABLE().deathsd
            return self.deathsd
        else
            return nil
        end
    end
end
---@return number 怪物血量系数类型_C
function cfg_monsters:GetCoefficient()
    if self.coefficient ~= nil then
        return self.coefficient
    else
        if self:CsTABLE() ~= nil then
            self.coefficient = self:CsTABLE().coefficient
            return self.coefficient
        else
            return nil
        end
    end
end
---@return number 是否播放shader动画_C
function cfg_monsters:GetIfBorn()
    if self.ifBorn ~= nil then
        return self.ifBorn
    else
        if self:CsTABLE() ~= nil then
            self.ifBorn = self:CsTABLE().ifBorn
            return self.ifBorn
        else
            return nil
        end
    end
end

---@return number shader动画播放时长_C
function cfg_monsters:GetBornTime()
    if self.bornTime ~= nil then
        return self.bornTime
    else
        if self:CsTABLE() ~= nil then
            self.bornTime = self:CsTABLE().bornTime
            return self.bornTime
        else
            return nil
        end
    end
end
---@return number Boss积分_C
function cfg_monsters:GetIntegral()
    if self.integral ~= nil then
        return self.integral
    else
        if self:CsTABLE() ~= nil then
            self.integral = self:CsTABLE().integral
            return self.integral
        else
            return nil
        end
    end
end
---@return number 是否作为boss刷新公告_C
function cfg_monsters:GetIsAnnounce()
    if self.isAnnounce ~= nil then
        return self.isAnnounce
    else
        if self:CsTABLE() ~= nil then
            self.isAnnounce = self:CsTABLE().isAnnounce
            return self.isAnnounce
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao BOSS列表位置#客户端  对应怪物在boss列表里的位置，关联cfg_boss表的type#subtype
function cfg_monsters:GetBossPosition()
    if self.bossPosition ~= nil then
        return self.bossPosition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bossPosition
        else
            return nil
        end
    end
end

---@return string 光环#客户端  脚底光环，配置的话出生脚底即显示光环
function cfg_monsters:GetHalo()
    if self.halo ~= nil then
        return self.halo
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().halo
        else
            return nil
        end
    end
end

---@return number 光环缩放#客户端  光环缩放，配置缩放比例 不填默认为100
function cfg_monsters:GetHaloScale()
    if self.haloScale ~= nil then
        return self.haloScale
    else
        if self:CsTABLE() ~= nil then
            self.haloScale = self:CsTABLE().haloScale
            return self.haloScale
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao boss技能显示#客户端  boss技能显示（关联boss_skill_describe表）
function cfg_monsters:GetBossSkill()
    if self.bossSkill ~= nil then
        return self.bossSkill
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().bossSkill
        else
            return nil
        end
    end
end

---@return number 狂暴buff描述#客户端  狂暴buff描述中的伤害参数显示
function cfg_monsters:GetRageHurtTips()
    if self.rageHurtTips ~= nil then
        return self.rageHurtTips
    else
        if self:CsTABLE() ~= nil then
            self.rageHurtTips = self:CsTABLE().rageHurtTips
            return self.rageHurtTips
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 怪物死亡是否出现马#客户端  填写怪物死亡后判定是否出现马匹，0不出现 1出现
function cfg_monsters:GetTame()
    if self.tame ~= nil then
        return self.tame
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().tame
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_MONSTERS C#中的数据结构
function cfg_monsters:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_MonsterTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_monsters lua中的数据结构
function cfg_monsters:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.phyAttackMin = decodedData.phyAttackMin
    
    ---@private
    self.phyDefenceMax = decodedData.phyDefenceMax
    
    ---@private
    self.phyDefenceMin = decodedData.phyDefenceMin
    
    ---@private
    self.magicDefenceMax = decodedData.magicDefenceMax
    
    ---@private
    self.bossPosition = decodedData.bossPosition
    
    ---@private
    self.halo = decodedData.halo
    
    ---@private
    self.haloScale = decodedData.haloScale
    
    ---@private
    self.bossSkill = decodedData.bossSkill
    
    ---@private
    self.rageHurtTips = decodedData.rageHurtTips
    
    ---@private
    self.tame = decodedData.tame
end

return cfg_monsters