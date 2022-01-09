--==========================================================Info
script_author('IlyaLua')
script_name('FakeAdmin')
script_moonloader('0.26')
--==========================================================Lib
require "lib.moonloader"
require 'lib.vkeys'
local on = require "lib.samp.events"

local dlstatus = require('moonloader').download_status
local broadcaster = import('lib/broadcaster.lua')

local inicfg = require 'inicfg'
local imgui = require 'imgui'

local encoding = require 'encoding' 
encoding.default = 'CP1251' 
u8 = encoding.UTF8--script:reload()
--==========================================================xyna


--==========================================================inicfg
local iniupd = inicfg.load(nil, 'version')
if iniupd == nil then
	iniupd = inicfg.load({['info'] = {vers = 1, versText = '1.0'}})
	inicfg.save(iniupd, 'version')
	script:reload()
end

--==========================================================obnova 
local obnova = false -- xyi

local script_vers = iniupd.info.vers
local script_versText = iniupd.info.versText

local ini_url = 'https://raw.githubusercontent.com/IlyaLuas/fakeadm/main/version.ini'
local ini_path = getWorkingDirectory() .. "/version.ini"

local script_url = "https://raw.githubusercontent.com/IlyaLuas/fakeadm/main/fakeadm.lua"
local script_path = thisScript().path

--==========================================================imgui
local ocn = imgui.ImBool(false)

local tems = imgui.ImInt(1) 

local col = imgui.ImFloat3(1.0, 1.0, 1.0)
local pole = 0
--==========================================================code
--[[imgui.PushItemWidth(çíà÷åíèå) imgui.InputText(u8"Input some text", textBuffer) imgui.PopItemWidth()]]
function imgui.OnDrawFrame()
	tema()
	sx, sy = getScreenResolution()
	if ocn.v then
		imgui.SetNextWindowPos( imgui.ImVec2(sx/4.5, sy/4.5), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowSize(imgui.ImVec2(sx/1.7, sy/1.7), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Íàçâàíèå îêíà', ocn, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)   
			imgui.BeginChild("x1", imgui.ImVec2(sx/8,sy/1.9), true)
				if imgui.Button(u8'Îñíîâíîå',imgui.ImVec2(sx/8.8, 20)) then
					pole = 0
				end
				if imgui.Button(u8'Èíôîðìàöèÿ',imgui.ImVec2(sx/8.8, 20)) then
					pole = 1
				end
				if imgui.Button(u8'da',imgui.ImVec2(sx/8.8, 20)) then
					pole = 2
				end
				if imgui.Button(u8'da',imgui.ImVec2(sx/8.8, 20)) then
					pole = 3
				end
				if imgui.Button(u8'da',imgui.ImVec2(sx/8.8, 20)) then
					pole = 4
				end
				if imgui.Button(u8'da',imgui.ImVec2(sx/8.8, 20)) then
					pole = 5
				end
				
			imgui.EndChild()
				imgui.SameLine()
			imgui.BeginChild("x2", imgui.ImVec2(sx/2.25,sy/1.9), true)
				


			imgui.EndChild()
		imgui.End()
	end
    --[[imgui.Begin('test')
    imgui.ColorEdit3('test', color)

    imgui.End()]]
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end 
    wait(100) 
	sampRegisterChatCommand('fsett', function() ocn.v = not ocn.v end)
    --[[broadcaster.registerHandler('myhndl', Test)
    sampRegisterChatCommand('a', function(arg)
        broadcaster.sendMessage(u8(arg), 'myhndl')
    end)]]
	downloadUrlToFile(ini_url, ini_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			iniup = inicfg.load(nil, ini_path)
			if tonumber(iniup.info.vers) > script_vers then
				obnova = true
			else
				sampAddChatMessage('xyi',-1)
			end
		end
	end)
    while true do wait(0)
		imgui.Process = ocn.v
		imgui.ShowCursor = ocn.v
		if obnova then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage('xz',-1)
					thisScript():reload()	
				end
			end)
		end

	end
end




--[[function Test(message)
    sampAddChatMessage('New message: ' .. u8:decode(message), 0x00FF00)
end

function onScriptTerminate(scr)
    if scr == thisScript() then
        broadcaster.unregisterHandler('myhndl')
    end
end]]



function tema()
	if tems.v == 0 then
		return
	elseif tems.v == 1 then--ñèíÿÿ
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowRounding = 2.0
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.ChildWindowRounding = 2.0
		style.FrameRounding = 2.0
		style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
		style.ScrollbarSize = 13.0
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8.0
		style.GrabRounding = 1.0

		colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
		colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
		colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	elseif tems.v == 2 then--êðàñíàÿ
	    imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowRounding = 2.0
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.ChildWindowRounding = 2.0
		style.FrameRounding = 2.0
		style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
		style.ScrollbarSize = 13.0
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8.0
		style.GrabRounding = 1.0

		colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
		colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
		colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	elseif tems.v == 3 then--ãîëóáàÿ
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		style.WindowRounding = 2.0
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
		style.ChildWindowRounding = 2.0
		style.FrameRounding = 2.0
		style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
		style.ScrollbarSize = 13.0
		style.ScrollbarRounding = 0
		style.GrabMinSize = 8.0
		style.GrabRounding = 1.0

		colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
		colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
		colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
		colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
		colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
		colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
		colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
		colors[clr.Separator]              = colors[clr.Border]
		colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
		colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
		colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
		colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
		colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
		colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
		colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]                = colors[clr.PopupBg]
		colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
		colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	elseif tems.v == 4 then--òåìíûé äåçàéí ñàéòà
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4

		colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
		colors[clr.WindowBg] = ImVec4(0.11, 0.10, 0.11, 1.00)
		colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.PopupBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.Border] = ImVec4(0.86, 0.86, 0.86, 1.00)
		colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg] = ImVec4(0.21, 0.20, 0.21, 0.60)
		colors[clr.FrameBgHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.FrameBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.TitleBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.TitleBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.MenuBarBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.ScrollbarBg] = ImVec4(0.00, 0.46, 0.65, 0.00)
		colors[clr.ScrollbarGrab] = ImVec4(0.00, 0.46, 0.65, 0.44)
		colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 0.46, 0.65, 0.74)
		colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.ComboBg] = ImVec4(0.15, 0.14, 0.15, 1.00)
		colors[clr.CheckMark] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.SliderGrab] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.SliderGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.Button] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.ButtonHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.ButtonActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.Header] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.HeaderHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.HeaderActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
		colors[clr.ResizeGrip] = ImVec4(1.00, 1.00, 1.00, 0.30)
		colors[clr.ResizeGripHovered] = ImVec4(1.00, 1.00, 1.00, 0.60)
		colors[clr.ResizeGripActive] = ImVec4(1.00, 1.00, 1.00, 0.90)
		colors[clr.CloseButton] = ImVec4(1.00, 0.10, 0.24, 0.00)
		colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.10, 0.24, 0.00)
		colors[clr.CloseButtonActive] = ImVec4(1.00, 0.10, 0.24, 0.00)
		colors[clr.PlotLines] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.PlotLinesHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.PlotHistogram] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.PlotHistogramHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.TextSelectedBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.00)
	elseif tems.v == 5 then--CSGOsimple
		imgui.SwitchContext()
        local style = imgui.GetStyle()
        local colors = style.Colors
        local clr = imgui.Col
        local ImVec4 = imgui.ImVec4
        local ImVec2 = imgui.ImVec2
        -- StyleColorsDark
        colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00);
        colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94);
        colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
        colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50);
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00);
        colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54);
        colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40);
        colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67);
        colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
        colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00);
        colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53);
        colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00);
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00);
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00);
        colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00);
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00);
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00);
        colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40);
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00);
        colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00);
        colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31);
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80);
        colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00);
        colors[clr.Separator]              = colors[clr.Border];
        colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.40, 0.75, 0.78);
        colors[clr.SeparatorActive]        = ImVec4(0.10, 0.40, 0.75, 1.00);
        colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25);
        colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67);
        colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95);
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
        colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
        colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35);

        imgui.SetColorEditOptions(imgui.ColorEditFlags.HEX)

        style.FrameRounding = 0.0
        style.WindowRounding = 0.0
        style.ChildWindowRounding = 0.0

        colors[clr.TitleBgActive] = ImVec4(0.000, 0.009, 0.120, 0.940);
        colors[clr.TitleBg] = ImVec4(0.20, 0.25, 0.30, 1.0);
        colors[clr.Button] = ImVec4(0.260, 0.590, 0.980, 0.670);
        colors[clr.Header] = ImVec4(0.260, 0.590, 0.980, 0.670);
        colors[clr.HeaderHovered] = ImVec4(0.260, 0.590, 0.980, 1.000);
        colors[clr.ButtonHovered] = ImVec4(0.000, 0.545, 1.000, 1.000);
        colors[clr.ButtonActive] = ImVec4(0.060, 0.416, 0.980, 1.000);
        colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.30, 1.0);
        colors[clr.WindowBg] = ImVec4(0.000, 0.009, 0.120, 0.940);
        colors[clr.PopupBg] = ImVec4(0.076, 0.143, 0.209, 1.000);
	end
end


