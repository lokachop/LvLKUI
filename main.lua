function love.load()
	love.filesystem.load("/lvlkui/lvlkui.lua")()
	CurTime = 0


	local frame_main = LvLKUI.NewElement("frame_main", "frame")
	LvLKUI.SetPriority(frame_main, 20)
	LvLKUI.SetPos(frame_main, {32, 32})
	LvLKUI.SetSize(frame_main, {256, 256})

	local button_test_child = LvLKUI.NewElement("button_test_child", "button")
	LvLKUI.SetPriority(button_test_child, 40)
	LvLKUI.SetPos(button_test_child, {128 - 64, 128 - 16})
	LvLKUI.SetSize(button_test_child, {128, 32})
	LvLKUI.SetLabel(button_test_child, "Print shit")
	LvLKUI.SetOnClick(button_test_child, function(elm, mx, my)
		print("you pressed This!")
	end)

	LvLKUI.PushElement(button_test_child, frame_main)
	LvLKUI.PushElement(frame_main)


	local button_base2 = LvLKUI.NewElement("button_base2", "button")
	LvLKUI.SetPriority(button_base2, 10)
	LvLKUI.SetPos(button_base2, {256, 256})
	LvLKUI.SetSize(button_base2, {512, 64})
	LvLKUI.SetLabel(button_base2, "Another button for some reason")
	LvLKUI.SetOnClick(button_base2, function(elm, mx, my)
		print("you pressed this too!")
	end)

	LvLKUI.PushElement(button_base2)


	--[[
	local panel_test2 = LvLKUI.NewElement("panel_test2", "panel")
	LvLKUI.SetPriority(panel_test2, 40)
	LvLKUI.SetPos(panel_test2, {64, 64})
	LvLKUI.SetSize(panel_test2, {256, 256})
	LvLKUI.PushElement(panel_test2)


	local panel_test3 = LvLKUI.NewElement("panel_test3", "panel")
	LvLKUI.SetPriority(panel_test3, -40)
	LvLKUI.SetPos(panel_test3, {128, 128})
	LvLKUI.SetSize(panel_test3, {256, 256})
	LvLKUI.PushElement(panel_test3)
	]]--
end

function love.update(dt)
	CurTime = CurTime + dt

	LvLKUI.TriggerThink(dt)
end

function love.keypressed(key)
end

function love.mousepressed(x, y, button)
	LvLKUI.TriggerClick(x, y, button)
end

function love.mousemoved(x, y)
	LvLKUI.TriggerHover(x, y)
end


function love.draw()
	LvLKUI.DrawAll()
end