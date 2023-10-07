LvLKUI = LvLKUI or {}

LvLKUI.DeclareComponent("frame", {
	["MOUSE_HOVER_EXTERNAL"] = true,
	["MOUSE_CLICK_EXTERNAL"] = false,
	["_isDragging"] = false,
	["_relativePickup"] = {0, 0},

	["label"] = "A frame",
	["_textLabelObj"] = nil,

	["_childrenStash"] = {},
	["_isMinimized"] = false,
	["_formerSize"] = {0, 0},

	-- what to do when we're initialized
	["onInit"] = function(elm)
		local bClose = LvLKUI.NewElement("bClose_Frame", "button")
		LvLKUI.SetPriority(bClose, 30)
		LvLKUI.SetPos(bClose, {0, 0})
		LvLKUI.SetSize(bClose, {16, 16})
		LvLKUI.SetLabel(bClose, "X")
		LvLKUI.SetOnClick(bClose, function()
			LvLKUI.RemoveElement(elm.name)
		end)

		LvLKUI.PushElement(bClose, elm)

		local bMinimize = LvLKUI.NewElement("bMinimize_Frame", "button")
		LvLKUI.SetPriority(bMinimize, 30)
		LvLKUI.SetPos(bMinimize, {0, 0})
		LvLKUI.SetSize(bMinimize, {16, 16})
		LvLKUI.SetLabel(bMinimize, "-")
		LvLKUI.SetOnClick(bMinimize, function()

			local _blacklistNames = {
				["bClose_Frame"] = true,
				["bMinimize_Frame"] = true
			}

			if not elm._isMinimized then
				-- move everything but the GUI buttons to the stash
				for k, v in pairs(elm.children) do
					if not _blacklistNames[k] then
						elm._childrenStash[k] = v
						elm.children[k] = nil
					end
				end

				-- change height so we can click thru
				elm._formerSize = elm.size
				elm.size = {elm._formerSize[1], 18}

				LvLKUI.RecalculateElementSortedChildren(elm)
				elm._isMinimized = true
			else
				-- move everything back
				for k, v in pairs(elm._childrenStash) do
					elm.children[k] = v
				end
				elm._childrenStash = {}

				-- bring back the height
				elm.size = elm._formerSize

				LvLKUI.RecalculateElementSortedChildren(elm)
				elm._isMinimized = false
			end
		end)

		LvLKUI.PushElement(bMinimize, elm)


		-- setup the label, same as button
		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj = love.graphics.newText(theme._fontObj, elm.label)
	end,

	["onSizeChange"] = function(elm)
		local elmSize = elm.size

		local bClose = LvLKUI.GetElement("bClose_Frame", elm)
		LvLKUI.SetPos(bClose, {elmSize[1] - 16, 0})

		local bMinimize = LvLKUI.GetElement("bMinimize_Frame", elm)
		LvLKUI.SetPos(bMinimize, {elmSize[1] - 16 - 20, 0})
	end,

	-- what to do each tick?
	["onThink"] = function(elm)
	end,

	-- what to do when clicked?
	["onClick"] = function(elm, mx, my, button, hit)
	end,

	-- what to do when hovering?
	["onHover"] = function(elm, mx, my, hit)
		--if not hit then
		--	return
		--end

		if not elm._isDragging then
			if not hit then
				return
			end

			if not love.mouse.isDown(1) then
				return
			end

			local elmSize = elm.size

			if not LvLKUI.Inrange2D({mx, my}, {0, 0}, {elmSize[1], 18}) then
				return
			end

			elm._isDragging = true
			elm._relativePickup = {mx, my}
		else
			if not love.mouse.isDown(1) then
				elm._isDragging = false
				return
			end


			local rmx, rmy = love.mouse.getPosition()
			local rela = elm._relativePickup
			LvLKUI.SetPos(elm, {-rela[1] + rmx, -rela[2] + rmy})
		end
	end,

	-- what to do when the label changes
	["onLabelChange"] = function(elm)
		elm._textLabelObj:set(elm.label)

		local theme = LvLKUI.Themes[elm.theme]
		elm._textLabelObj:setFont(theme._fontObj)
	end,


	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function(elm, w, h, colPrimary, colSecondary, colHighlight, font)
		love.graphics.setColor(colSecondary[1], colSecondary[2], colSecondary[3])
		love.graphics.rectangle("fill", 0, 0, w, h)

		love.graphics.setColor(colPrimary[1], colPrimary[2], colPrimary[3])
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", 0, 0, w, h)

		-- top bar
		love.graphics.rectangle("fill", 0, 0, w, 18)


		love.graphics.setColor(colHighlight[1], colHighlight[2], colHighlight[3])
		love.graphics.draw(elm._textLabelObj, 0, 0)
	end,

	-- what to do when we're removed?
	["onRemove"] = function()
	end,
})