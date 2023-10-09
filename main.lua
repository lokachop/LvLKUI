function love.load()
	love.filesystem.load("/lvlkui/lvlkui.lua")()
	love.keyboard.setKeyRepeat(true)
	CurTime = 0


	local frame_main = LvLKUI.NewElement("frame_main", "frame")
	frame_main:SetPriority(20)
	frame_main:SetPos({32, 32})
	frame_main:SetSize({256, 256})

	local button_test_child = LvLKUI.NewElement("button_test_child", "button")
	button_test_child:SetPriority(40)
	button_test_child:SetPos({128 - 64, 128 - 16})
	button_test_child:SetSize({128, 32})
	button_test_child:SetLabel("Print shit")
	button_test_child:SetOnClick(function(elm, mx, my)
		print("you pressed This!")
	end)
	LvLKUI.PushElement(button_test_child, frame_main)

	local label_test_child = LvLKUI.NewElement("label_test_child", "label")
	label_test_child:SetPriority(30)
	label_test_child:SetPos({128, 180})
	label_test_child:SetSize({128, 32})
	label_test_child:SetLabel("Hellooo!")
	label_test_child:SetAlignMode({1, 1})
	LvLKUI.PushElement(label_test_child, frame_main)

	local entry_test_child = LvLKUI.NewElement("entry_test_child", "textentry")
	entry_test_child:SetPriority(30)
	entry_test_child:SetPos({128 - 64, 232 - 12})
	entry_test_child:SetSize({128, 24})
	--entry_test_child:SetLabel("Hellooo!")
	LvLKUI.PushElement(entry_test_child, frame_main)


	LvLKUI.PushElement(frame_main)





	local button_base2 = LvLKUI.NewElement("button_base2", "button")
	button_base2:SetPriority(10)
	button_base2:SetPos({256, 256})
	button_base2:SetSize({512, 64})
	button_base2:SetLabel("Another button for some reason")
	button_base2:SetOnClick(function(elm, mx, my)
		print("you pressed this too!")
	end)

	LvLKUI.PushElement(button_base2)






	local frame_main2 = LvLKUI.NewElement("frame_main2", "frame")
	frame_main2:SetPriority(20)
	frame_main2:SetPos({256, 256})
	frame_main2:SetSize({256, 256})
	frame_main2:SetLabel("The other frame")
	frame_main2:SetColourOverride({0.3, 0.4, 0.3}, {0.1, 0.125, 0.1}, {0.95, 1, 0.95})
	frame_main2:SetCloseDisabled(true)
	frame_main2:ReInit()


	local button_test_child2 = LvLKUI.NewElement("button_test_child2", "button")
	button_test_child2:SetPriority(40)
	button_test_child2:SetPos({128 - (240 * .5), 128 - 16})
	button_test_child2:SetSize({240, 32})
	button_test_child2:SetLabel("Wow this one is another colour!")
	button_test_child2:SetOnClick(function(elm, mx, my)
		print("hello")
	end)

	button_test_child2:SetColourOverride({0.4, 0.3, 0.3}, {0.125, 0.1, 0.1}, {1, 0.5, 0.5})

	LvLKUI.PushElement(button_test_child2, frame_main2)
	LvLKUI.PushElement(frame_main2)




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

function love.textinput(key)
	LvLKUI.TriggerKeypress(key, false)
end

function love.keypressed(key)
	LvLKUI.TriggerKeypress(key, true)
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