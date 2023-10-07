LvLKUI = LvLKUI or {}

local baseParameteri = {
	["pos"] = {0, 0},
	["size"] = {16, 16},
	["children"] = {},
	["priority"] = 0,
	-- what to do when we're initialized
	["onInit"] = function() end,
	-- what to do each tick?
	["onThink"] = function() end,
	-- what to do when clicked?
	["onClick"] = function() end,
	-- what to do when hovering?
	["onHover"] = function() end,
	-- what to draw when drawing? (children are handled automatically)
	["onPaint"] = function() end,
	-- what to do when we're removed?
	["onRemove"] = function() end,
	["theme"] = "base",


	["_childCount"] = 0,
	["_sortedChildren"] = {},

	["doColourOverride"] = false,
	["colOverridePrimary"] = {0.3, 0.3, 0.4},
	["colOverrideSecondary"] = {0.1, 0.1, 0.125},
	["colOverrideHighlight"] = {0.95, 0.95, 1},
}

local function copyTable(tbl)
	local new = {}

	for k, v in pairs(tbl) do
		if type(v) == "table" then
			new[k] = copyTable(v)
		else
			new[k] = v
		end
	end

	return new
end


local function copy(obj)
	if type(obj) == "table" then
		return copyTable(obj)
	else
		return obj
	end
end

LvLKUI.Components = LvLKUI.Components or {}
function LvLKUI.DeclareComponent(name, data)
	LvLKUI.Components[name] = {}
	local ptr = LvLKUI.Components[name]

	for k, v in pairs(baseParameteri) do
		ptr[k] = copy(v)
	end

	-- now we copy the component's parameteri (so they can override)
	for k, v in pairs(data) do
		ptr[k] = copy(v)
	end

	print("[\"" .. name .. "\"]")
	LvLKUI.PrintTable(ptr, "|  ")
end

function LvLKUI.GetNewComponentCopy(name)
	if not LvLKUI.Components[name] then
		return
	end

	return copy(LvLKUI.Components[name])
end

LvLKUI.LoadFile("components.panel")
LvLKUI.LoadFile("components.button")

LvLKUI.LoadFile("components.frame")

LvLKUI.LoadFile("components.testpanel")
LvLKUI.LoadFile("components.mousetest")