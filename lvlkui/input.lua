LvLKUI = LvLKUI or {}

local function inrange(x, min, max)
    return (x >= min) and (x <= max)
end

local function inrange2D(pos, minPos, maxPos)
    return inrange(pos[1], minPos[1], maxPos[1]) and inrange(pos[2], minPos[2], maxPos[2])
end

local function getBounds(elm)
    return {elm.pos[1], elm.pos[2]}, {elm.pos[1] + elm.size[1], elm.pos[2] + elm.size[2]}
end

local function getHoveredElement(sortedList, mx, my)
    local highestPrio = -1256789000
    local clickedElement = nil

    local posMouse = {mx, my}
    for i = 1, #sortedList do
        local elm = sortedList[i]

        local elmMin, elmMax = getBounds(elm)
        if inrange2D(posMouse, elmMin, elmMax) and elm.priority > highestPrio then
            highestPrio = elm.priority
            clickedElement = elm
        end
    end

    if not clickedElement then
        return
    end

    local clickedPos = clickedElement.pos
    local relativePos = {mx - clickedPos[1], my - clickedPos[2]}

    if clickedElement._childCount > 0 then
        local hit, relaPos = getHoveredElement(clickedElement._sortedChildren, mx - clickedPos[1], my - clickedPos[2])
        if hit then
            clickedElement = hit
            relativePos = relaPos
        end
    end

    return clickedElement, relativePos
end

local function triggerExternalClick(elmlist, mx, my, button)
    for i = 1, #elmlist do
        local elm = elmlist[i]
        local elmPos = elm.pos
        local relativePos = {mx - elmPos[1], my - elmPos[2]}

        if elm.MOUSE_CLICK_EXTERNAL then
            elm.onClick(elm, relativePos[1], relativePos[2], button, false)
        end

        if elm._childCount > 0 then
            triggerExternalClick(elm._sortedChildren, relativePos[1], relativePos[2], button)
        end
    end
end


function LvLKUI.TriggerClick(mx, my, button)
    -- trigger always elements first
    triggerExternalClick(LvLKUI.SortedElements, mx, my)

    local elm, posRela = getHoveredElement(LvLKUI.SortedElements, mx, my)

    if not elm then
        return
    end

    elm.onClick(elm, posRela[1], posRela[2], button, true)
end


local function triggerExternalHover(elmlist, mx, my)
    for i = 1, #elmlist do
        local elm = elmlist[i]
        local elmPos = elm.pos
        local relativePos = {mx - elmPos[1], my - elmPos[2]}

        if elm.MOUSE_HOVER_EXTERNAL then
            elm.onHover(elm, relativePos[1], relativePos[2], false)
        end

        if elm._childCount > 0 then
            triggerExternalHover(elm._sortedChildren, relativePos[1], relativePos[2])
        end
    end
end

function LvLKUI.TriggerHover(mx, my)
    -- trigger always elements first
    triggerExternalHover(LvLKUI.SortedElements, mx, my)

    local elm, posRela = getHoveredElement(LvLKUI.SortedElements, mx, my)

    if not elm then
        return
    end

    elm.onHover(elm, posRela[1], posRela[2], true)
end


local function triggerThink(elmlist, dt)
    for i = 1, #elmlist do
        local elm = elmlist[i]

        elm.onThink(elm, dt)

        if elm._childCount > 0 then
            triggerThink(elm._sortedChildren, dt)
        end
    end
end

function LvLKUI.TriggerThink(dt)
    triggerThink(LvLKUI.SortedElements, dt)
end