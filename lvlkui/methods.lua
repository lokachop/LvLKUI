LvLKUI = LvLKUI or {}

function LvLKUI.SetPriority(elm, prio)
	if not elm then
		return
	end


	elm.priority = prio or 0
	LvLKUI.RecalculateSortedElementList()
end

function LvLKUI.SetPos(elm, pos)
	if not elm then
		return
	end

	if not pos then
		return
	end

	elm.pos = {pos[1] or 0, pos[2] or 0}
end

function LvLKUI.GetPos(elm)
	if not elm then
		return
	end

	return elm.pos
end

function LvLKUI.SetSize(elm, size)
	if not elm then
		return
	end

	if not size then
		return
	end

	elm.size = {size[1] or 0, size[2] or 0}

	if elm.onSizeChange then
		elm.onSizeChange(elm)
	end
end

function LvLKUI.GetSize(elm)
	if not elm then
		return
	end

	return elm.size
end

function LvLKUI.SetOnClick(elm, func)
	if not elm then
		return
	end

	if not func then
		return
	end

	elm.onClick = func
end

function LvLKUI.SetOnPaint(elm, func)
	if not elm then
		return
	end

	if not func then
		return
	end

	elm.onPaint = func
end

function LvLKUI.SetLabel(elm, label)
	if not elm then
		return
	end

	if not label then
		return
	end

	elm.label = label

	if elm.onLabelChange then
		elm.onLabelChange(elm)
	end
end

function LvLKUI.SetColourOverride(elm, primary, secondary, highlight)
	if not elm then
		return
	end

	if not primary then
		return
	end

	if not secondary then
		return
	end

	if not highlight then
		return
	end

	elm.doColourOverride = true
	elm.colOverridePrimary = primary
	elm.colOverrideSecondary = secondary
	elm.colOverrideHighlight = highlight
end

function LvLKUI.ReInit(elm)
	if not elm then
		return
	end

	if elm.onInit then
		elm.onInit(elm)
	end
end