--[[本文件为工具自动生成,禁止手动修改]]
---@class TABLE.cfg_notice
local cfg_notice = {}

cfg_notice.__index = cfg_notice

function cfg_notice:UUID()
    return self.id
end

---@return number id#客户端#C  固定id，不可修改
function cfg_notice:GetId()
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

---@return number icon的id#客户端#C  icon的id
function cfg_notice:GetIconId()
    if self.iconId ~= nil then
        return self.iconId
    else
        if self:CsTABLE() ~= nil then
            self.iconId = self:CsTABLE().iconId
            return self.iconId
        else
            return nil
        end
    end
end

---@return number 未开启时隐藏#客户端#C  1隐藏0不隐藏
function cfg_notice:GetConceal()
    if self.conceal ~= nil then
        return self.conceal
    else
        if self:CsTABLE() ~= nil then
            self.conceal = self:CsTABLE().conceal
            return self.conceal
        else
            return nil
        end
    end
end

---@return number 系统预告#客户端#C  1显示预告2不显示预告
function cfg_notice:GetNotice()
    if self.notice ~= nil then
        return self.notice
    else
        if self:CsTABLE() ~= nil then
            self.notice = self:CsTABLE().notice
            return self.notice
        else
            return nil
        end
    end
end

---@return number 邮件提醒#客户端#C  1邮件提醒2不需要邮件提醒
function cfg_notice:GetMail()
    if self.mail ~= nil then
        return self.mail
    else
        if self:CsTABLE() ~= nil then
            self.mail = self:CsTABLE().mail
            return self.mail
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 邮件#客户端#C  对应cfg_mail
function cfg_notice:GetSendmail()
    if self.sendmail ~= nil then
        return self.sendmail
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().sendmail
        else
            return nil
        end
    end
end

---@return number 总开关#客户端#C  0关，1开，如果改成0则会在服务器数据更新之后将已开启的系统强行关闭
function cfg_notice:GetMasterSwitch()
    if self.masterSwitch ~= nil then
        return self.masterSwitch
    else
        if self:CsTABLE() ~= nil then
            self.masterSwitch = self:CsTABLE().masterSwitch
            return self.masterSwitch
        else
            return nil
        end
    end
end

---@return number 开启方式#客户端#C  0条件开启（右侧条件一旦不满足，关闭），1永久开启（条件满足一次后永久开启）；【填1的情况下，如果单纯进行不重启的线上热更表，需先将1条件改成0，热更线一次表后，再改回1热更一次表，修改的openCondition字段才会生效】
function cfg_notice:GetOpenType()
    if self.openType ~= nil then
        return self.openType
    else
        if self:CsTABLE() ~= nil then
            self.openType = self:CsTABLE().openType
            return self.openType
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 开放条件#客户端#C  读取conditions表 多条件用#分隔
function cfg_notice:GetOpenCondition()
    if self.openCondition ~= nil then
        return self.openCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().openCondition
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 同等条件#客户端#C  和openCondition字段填写形式，意义相同，两个字段为或逻辑
function cfg_notice:GetEquallyCondition()
    if self.equallyCondition ~= nil then
        return self.equallyCondition
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().equallyCondition
        else
            return nil
        end
    end
end

---@return number 开放条件是否开启#客户端#C  0是不开启,1是开启,默认0
function cfg_notice:GetStartUp()
    if self.startUp ~= nil then
        return self.startUp
    else
        if self:CsTABLE() ~= nil then
            self.startUp = self:CsTABLE().startUp
            return self.startUp
        else
            return nil
        end
    end
end

---@return string 具体时间#客户端#C  具体时间参数:2001#08#01
function cfg_notice:GetTime()
    if self.time ~= nil then
        return self.time
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().time
        else
            return nil
        end
    end
end

---@return string 预设名字#客户端#C  对应的面板预设名字（程序管理用）后期补上
function cfg_notice:GetYushe()
    if self.yushe ~= nil then
        return self.yushe
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().yushe
        else
            return nil
        end
    end
end

---@return number 跳转id#客户端#C  cfg_jump表id，如果填了此列则跳转
function cfg_notice:GetJumpId()
    if self.jumpId ~= nil then
        return self.jumpId
    else
        if self:CsTABLE() ~= nil then
            self.jumpId = self:CsTABLE().jumpId
            return self.jumpId
        else
            return nil
        end
    end
end

---@return string 策划备注#客户端#C  系统
function cfg_notice:GetRemarks()
    if self.remarks ~= nil then
        return self.remarks
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().remarks
        else
            return nil
        end
    end
end

---@return number 位置#客户端#C  数字1即为第一排，2为第二排以此类推（程序按照顺序读取，要按顺序填写，第一排填完再填第二排）（归属配置为2，则此字段无用）
function cfg_notice:GetPosition()
    if self.position ~= nil then
        return self.position
    else
        if self:CsTABLE() ~= nil then
            self.position = self:CsTABLE().position
            return self.position
        else
            return nil
        end
    end
end

---@return number 归属#客户端#C  1.右上活动栏内功能2.为导航栏内功能
function cfg_notice:GetAscription()
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

---@return number 排序#客户端#C  不填默认为0，为最右侧
function cfg_notice:GetOrder()
    if self.order ~= nil then
        return self.order
    else
        if self:CsTABLE() ~= nil then
            self.order = self:CsTABLE().order
            return self.order
        else
            return nil
        end
    end
end

---@return number 是否需要感叹号提醒#客户端#C  1是、不填或填0否；填1代表每次登陆，对应的系统都会有感叹号提示，必须点击一次后才会消失 2：背包里有塔罗牌时出现感叹号 3：默认有感叹号，点击一次后消失不会再次出现
function cfg_notice:GetIsReminder()
    if self.isReminder ~= nil then
        return self.isReminder
    else
        if self:CsTABLE() ~= nil then
            self.isReminder = self:CsTABLE().isReminder
            return self.isReminder
        else
            return nil
        end
    end
end

---@return number 是否在外部常显#客户端#C  右上栏图标是否在外部进行常显，1常显，不填则不常显
function cfg_notice:GetOutShow()
    if self.outShow ~= nil then
        return self.outShow
    else
        if self:CsTABLE() ~= nil then
            self.outShow = self:CsTABLE().outShow
            return self.outShow
        else
            return nil
        end
    end
end

---@return TABLE.IntListJingHao 参数#客户端  活动入口填写用于对应activity_current的不同group
function cfg_notice:GetParam()
    if self.param ~= nil then
        return self.param
    else
        if self:CsTABLE() ~= nil then
            return self:CsTABLE().param
        else
            return nil
        end
    end
end

---@return number 外部图标位置#客户端  数字1即为第一排，2为第二排以此类推（程序按照顺序读取，要按顺序填写，第一排填完再填第二排）（归属配置为2，则此字段无用）
function cfg_notice:GetOutPosition()
    if self.outPosition ~= nil then
        return self.outPosition
    else
        if self:CsTABLE() ~= nil then
            self.outPosition = self:CsTABLE().outPosition
            return self.outPosition
        else
            return nil
        end
    end
end

---@return number 外部图标排序#客户端  不填默认为0，为最右侧
function cfg_notice:GetOutOrder()
    if self.outOrder ~= nil then
        return self.outOrder
    else
        if self:CsTABLE() ~= nil then
            self.outOrder = self:CsTABLE().outOrder
            return self.outOrder
        else
            return nil
        end
    end
end

--@return  TABLE.CFG_NOTICE C#中的数据结构
function cfg_notice:CsTABLE()
    if self.csTABLE == nil then
        local isfind,data=CS.Cfg_NoticeTableManager.Instance:TryGetValue(self:UUID())
        self.csTABLE = data
    end
    return self.csTABLE 
end

---@param decodedData TABLE.cfg_notice lua中的数据结构
function cfg_notice:Init(decodedData)
    if (decodedData == nil) then
        return
    end
    
    ---@private
    self.id = decodedData.id
    
    ---@private
    self.param = decodedData.param
    
    ---@private
    self.outPosition = decodedData.outPosition
    
    ---@private
    self.outOrder = decodedData.outOrder
end

return cfg_notice