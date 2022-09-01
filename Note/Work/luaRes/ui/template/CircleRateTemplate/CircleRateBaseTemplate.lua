---@class CircleRateBaseTemplate:TemplateBase 圆形比例显示
local CircleRateBaseTemplate = {}

local CheckNullFunction = CS.StaticUtility.IsNull

function CircleRateBaseTemplate:Init()
end

--region 用于重写
---@return boolean 默认该组件球和波浪的图片在同一节点下且不存在父子级别关系
---如果波浪是球子节点，重写此方法且返回false
function CircleRateBaseTemplate:IsSameRoot()
    return true
end

---@return UISprite 球图片
function CircleRateBaseTemplate:GetCircle_UISprite()
end

---@return UIWidget 波浪图片
function CircleRateBaseTemplate:GetWave_UISprite()
end

function CircleRateBaseTemplate:GetWaveRoot_GO()

end
--endregion

CircleRateBaseTemplate.nowRate = 0
CircleRateBaseTemplate.targetRate = 0

---此方法用于设置比例
---@public
---@param rate number 小于等于1且大于等于0的比列，超出此范围不做考虑
---@param isTween boolean 是否指向Tween动画,缓慢变动
function CircleRateBaseTemplate:SetRate(rate, isTween, speed)
    if rate > 1 then
        rate = 1
    end
    if rate < 0 then
        rate = 0
    end
    --isTween = true
    self.nowRate = self:GetCircle_UISprite().fillAmount;
    self.targetRate = rate;

    if(speed == nil) then
        speed = 0.01
    end

    if(isTween == true) then
        if self.IenumRefreshWave == nil then
            self.IenumRefreshWave = StartCoroutine(self.IFuncEnumRefreshWave, self, self.nowRate, self.targetRate, speed)
        else
            if self.IenumRefreshWave ~= nil then
                StopCoroutine(self.IenumRefreshWave)
            end
            self.IenumRefreshWave = StartCoroutine(self.IFuncEnumRefreshWave, self, self.nowRate, self.targetRate, speed)
        end
    else
        self:SetWaveAllData(self.targetRate)
    end
end

function CircleRateBaseTemplate:SetWaveAllData(target)
    if CheckNullFunction(self:GetCircle_UISprite()) == false and CheckNullFunction(self:GetWave_UISprite()) == false then
        local h = self:SetWavePosition(target)
        self:SetWaveScale(h, target)
    end
    self:GetCircle_UISprite().fillAmount = target
end

function CircleRateBaseTemplate:IFuncEnumRefreshWave(now, target, speed)
    --now = 1;
    --target = 0
    while now ~= target do
        if(now < target) then
            now = now + speed;
            if(now > 1) then
                now = 1
            end
            if(now > target) then
                now = target
            end
        elseif(now > target) then
            now = now - speed;
            if(now < 0) then
                now = 0
            end
            if(now < target) then
                now = target
            end
        end
        self:SetWaveAllData(now)
        coroutine.yield(CS.NGUIAssist.waitForEndOfFrame)
    end

    StopCoroutine(self.IenumRefreshWave)
end

---设置波浪位置
---@return number 波浪位置到中心点的距离
function CircleRateBaseTemplate:SetWavePosition(rate)
    local centerPos = self:GetCircle_UISprite().gameObject.transform.localPosition
    local height = self:GetCircle_UISprite().height
    local aimHeight = height * rate
    local centerHeight = height / 2
    local offset = aimHeight - centerHeight
    local aimPos = self:IsSameRoot() and centerPos.y + offset or offset
    centerPos.y = aimPos
    centerPos.x = self:IsSameRoot() and centerPos.x or 0
    self:GetWave_UISprite().gameObject.transform.localPosition = centerPos
    return math.abs(offset)
end

---设置波浪缩放
function CircleRateBaseTemplate:SetWaveScale(h)
    if h then
        local width = self:GetCircle_UISprite().width
        local r = width / 2
        if h == 0 then
            self:GetWave_UISprite().transform.localScale = CS.UnityEngine.Vector3.one
        else
            local Length = (r * r) - (h * h)
            local currentLength = math.sqrt(Length)
            if currentLength and r > 0 then
                local scaleRate = currentLength / r
                self:GetWave_UISprite().transform.localScale = CS.UnityEngine.Vector3(scaleRate, scaleRate, scaleRate)
            end
        end
    end
end

return CircleRateBaseTemplate