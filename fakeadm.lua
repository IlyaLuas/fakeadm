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
local fa = require 'fAwesome5'
local imgui = require 'imgui'

local encoding = require 'encoding' 
encoding.default = 'CP1251' 
u8 = encoding.UTF8--script:reload()--хуй
--==========================================================xyna
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

lang = {
	['ru'] = {
		bw = ' Основное окно',
		basic = ' Основное',
		info = ' Информация',
		fo = ' Друзья онлайн',
		sett = ' Настройки',
		serv = ' Сервера'
	},
	['eng'] = {
		bw = ' Basic window',
		basic = ' Basic',
		info = ' Information',
		fo = ' Friends online',
		sett = ' Settings',
		serv = ' Servers'
	},
}

--==========================================================inicfg
local iniupd = inicfg.load(nil, 'version')
if iniupd == nil then
	iniupd = inicfg.load({['info'] = {vers = 1, versText = '1.0'}})
	inicfg.save(iniupd, 'version')
	script:reload()
end
local fsett = inicfg.load(nil, 'fsettings')
if fsett == nil then
	fsett = inicfg.load({
		['sett'] = {
			lang = 'eng', 
			num = 2, 
			tems = 1
		}
	})
	inicfg.save(fsett, 'fsettings')
	script:reload()
end
--==========================================================obnova 
local obnova = false -- xyi

local script_vers = iniupd.info.vers
local script_versText = iniupd.info.versText

local ini_url = 'https://raw.githubusercontent.com/IlyaLuas/fakeadm/main/config/version.ini'
local ini_path = getWorkingDirectory() .. "/moonloader/config/version.ini"

local script_url = "https://github.com/IlyaLuas/fakeadm/blob/main/fakeadm.lua?raw=true" -- Лох
local script_path = thisScript().path

--==========================================================imgui
local ocn = imgui.ImBool(false)

local tems = imgui.ImInt(fsett.sett.tems) 
local langv = imgui.ImInt(fsett.sett.num) 
local col = imgui.ImFloat3(1.0, 1.0, 1.0)
local pole = 0
--==========================================================code
--[[imgui.PushItemWidth(Г§Г­Г Г·ГҐГ­ГЁГҐ) imgui.InputText(u8"Input some text", textBuffer) imgui.PopItemWidth()]]
function imgui.OnDrawFrame()
	tema()
	sx, sy = getScreenResolution()
	if ocn.v then
		imgui.SetNextWindowPos( imgui.ImVec2(sx/4.5, sy/4.5), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowSize(imgui.ImVec2(sx/1.7, sy/1.7), imgui.Cond.FirstUseEver)

		imgui.Begin(u8(fsett.sett.lang == 'eng' and lang.eng.bw or lang.ru.bw), ocn, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)   
			imgui.BeginChild("x1", imgui.ImVec2(sx/8,sy/1.9), true)
					if imgui.Button(fa.ICON_FA_LAPTOP..u8(fsett.sett.lang == 'eng' and lang.eng.basic or lang.ru.basic),imgui.ImVec2(sx/8.8, 20)) then pole = 0 end
					if imgui.Button(fa.ICON_FA_INFO_CIRCLE..u8(fsett.sett.lang == 'eng' and lang.eng.info or lang.ru.info),imgui.ImVec2(sx/8.8, 20)) then pole = 1 end
					if imgui.Button(fa.ICON_FA_HANDSHAKE..u8(fsett.sett.lang == 'eng' and lang.eng.fo or lang.ru.fo),imgui.ImVec2(sx/8.8, 20)) then pole = 2 end
					if imgui.Button(fa.ICON_FA_PEN..u8(fsett.sett.lang == 'eng' and lang.eng.sett or lang.ru.sett),imgui.ImVec2(sx/8.8, 20)) then pole = 3 end
					if imgui.Button(fa.ICON_FA_LIST..u8(fsett.sett.lang == 'eng' and lang.eng.serv or lang.ru.serv),imgui.ImVec2(sx/8.8, 20)) then pole = 4 end
			imgui.EndChild()
				imgui.SameLine()
			imgui.BeginChild("x2", imgui.ImVec2(sx/2.25,sy/1.9), true)
					if pole == 0 then  
					elseif pole == 1 then
					elseif pole == 2 then
					elseif pole == 3 then
					imgui.SetCursorPosX(7)
					imgui.BeginChild("lang", imgui.ImVec2(sx/4.65,sy/14), true)
						imgui.Text('LANGUAGE:')
						imgui.RadioButton(u8"Русский", langv, 1) imgui.SameLine()
						imgui.RadioButton(u8"English", langv, 2) 
					imgui.EndChild()
						imgui.SameLine()
					imgui.BeginChild("tema", imgui.ImVec2(sx/4.65,sy/14), true)
						imgui.PushItemWidth(200)
							imgui.SetCursorPosX(38)
							if imgui.Combo(u8' ', tems, {'1 ', u8(fsett.sett.lang == 'eng' and '2 - Blue' or '2 - Синия'), u8(fsett.sett.lang == 'eng' and '3 - Оранжевая' or '3 - Оранжевая'), u8(fsett.sett.lang == 'eng' and'4 - Diamond' or '4 - Алмазная'), u8(fsett.sett.lang == 'eng' and '5wd - Blue' or '5 - Голубая'), '6 - CSGOsimple'}, 6) then
								if tems.v == 0 then fsett.sett.tems = 0 end
								if tems.v == 1 then fsett.sett.tems = 1 end
								if tems.v == 2 then fsett.sett.tems = 2 end
								if tems.v == 3 then fsett.sett.tems = 3 end
								if tems.v == 4 then fsett.sett.tems = 4 end
								if tems.v == 5 then fsett.sett.tems = 5 end
							end
						imgui.PopItemWidth()
					imgui.EndChild()
					elseif pole == 4 then
						
					end			
						

				
	

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
			iniup = inicfg.load(nil, 'version')
			if tonumber(iniup.info.vers) > script_vers then
				obnova = true
			end
		end
	end)
    while true do wait(0)
		if langv.v == 1 then fsett.sett.lang = 'ru' fsett.sett.num = 1 inicfg.save(fsett, 'fsettings')
		elseif langv.v == 2 then fsett.sett.lang = 'eng' fsett.sett.num = 2 inicfg.save(fsett, 'fsettings')end
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
		
	elseif tems.v == 1 then--Г±ГЁГ­ГїГї
		imgui.SwitchContext()
		local style  = imgui.GetStyle()
		local colors = style.Colors
		local clr    = imgui.Col
		local ImVec4 = imgui.ImVec4
		local ImVec2 = imgui.ImVec2

		style.WindowPadding       = ImVec2(10, 10)
		style.WindowRounding      = 10
		style.ChildWindowRounding = 2
		style.FramePadding        = ImVec2(5, 4)
		style.FrameRounding       = 11
		style.ItemSpacing         = ImVec2(4, 4)
		style.TouchExtraPadding   = ImVec2(0, 0)
		style.IndentSpacing       = 21
		style.ScrollbarSize       = 16
		style.ScrollbarRounding   = 16
		style.GrabMinSize         = 11
		style.GrabRounding        = 16
		style.WindowTitleAlign    = ImVec2(0.5, 0.5)
		style.ButtonTextAlign     = ImVec2(0.5, 0.5)

		colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
		colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
		colors[clr.ChildWindowBg]        = ImVec4(10.00, 10.00, 10.00, 0.01)
		colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
		colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]              = ImVec4(0.00, 0.39, 1.00, 0.65)
		colors[clr.FrameBgHovered]       = ImVec4(0.11, 0.40, 0.69, 1.00)
		colors[clr.FrameBgActive]        = ImVec4(0.11, 0.40, 0.69, 1.00)
		colors[clr.TitleBg]              = ImVec4(0.00, 0.00, 0.00, 1.00)
		colors[clr.TitleBgActive]        = ImVec4(0.00, 0.24, 0.54, 1.00)
		colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.22, 1.00, 0.67)
		colors[clr.MenuBarBg]            = ImVec4(0.08, 0.44, 1.00, 1.00)
		colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
		colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
		colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
		colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
		colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
		colors[clr.SliderGrab]           = ImVec4(0.34, 0.67, 1.00, 1.00)
		colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)
		colors[clr.Button]               = ImVec4(0.00, 0.39, 1.00, 0.65)
		colors[clr.ButtonHovered]        = ImVec4(0.00, 0.64, 1.00, 0.65)
		colors[clr.ButtonActive]         = ImVec4(0.00, 0.53, 1.00, 0.50)
		colors[clr.Header]               = ImVec4(0.00, 0.62, 1.00, 0.54)
		colors[clr.HeaderHovered]        = ImVec4(0.00, 0.36, 1.00, 0.65)
		colors[clr.HeaderActive]         = ImVec4(0.00, 0.53, 1.00, 0.00)
		colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
		colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
		colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
		colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)
		colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)
		colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)
		colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
		colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
		colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)

	elseif tems.v == 2 then--ГЄГ°Г Г±Г­Г Гї
	    imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		local ImVec2 = imgui.ImVec2
		style.WindowPadding                = ImVec2(4.0, 4.0)
		style.WindowRounding               = 7
		style.WindowTitleAlign             = ImVec2(0.5, 0.5)
		style.FramePadding                 = ImVec2(4.0, 3.0)
		style.ItemSpacing                  = ImVec2(8.0, 4.0)
		style.ItemInnerSpacing             = ImVec2(4.0, 4.0)
		style.ChildWindowRounding          = 7
		style.FrameRounding                = 7
		style.ScrollbarRounding            = 7
		style.GrabRounding                 = 7
		style.IndentSpacing                = 21.0
		style.ScrollbarSize                = 13.0
		style.GrabMinSize                  = 10.0
		style.ButtonTextAlign              = ImVec2(0.5, 0.5)
		colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 1.00)
		colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.96)
		colors[clr.Border]                 = ImVec4(0.73, 0.36, 0.00, 0.00)
		colors[clr.FrameBg]                = ImVec4(0.49, 0.24, 0.00, 1.00)
		colors[clr.FrameBgHovered]         = ImVec4(0.65, 0.32, 0.00, 1.00)
		colors[clr.FrameBgActive]          = ImVec4(0.73, 0.36, 0.00, 1.00)
		colors[clr.ChildWindowBg]        = ImVec4(1.00, 1.00, 1.00, 0.02)
		colors[clr.TitleBg]                = ImVec4(0.15, 0.11, 0.09, 1.00)
		colors[clr.TitleBgActive]          = ImVec4(0.73, 0.36, 0.00, 1.00)
		colors[clr.TitleBgCollapsed]       = ImVec4(0.15, 0.11, 0.09, 0.51)
		colors[clr.MenuBarBg]              = ImVec4(0.62, 0.31, 0.00, 1.00)
		colors[clr.CheckMark]              = ImVec4(1.00, 0.49, 0.00, 1.00)
		colors[clr.SliderGrab]             = ImVec4(0.84, 0.41, 0.00, 1.00)
		colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.49, 0.00, 1.00)
		colors[clr.Button]                 = ImVec4(0.73, 0.36, 0.00, 0.40)
		colors[clr.ButtonHovered]          = ImVec4(0.73, 0.36, 0.00, 1.00)
		colors[clr.ButtonActive]           = ImVec4(1.00, 0.50, 0.00, 1.00)
		colors[clr.Header]                 = ImVec4(0.49, 0.24, 0.00, 1.00)
		colors[clr.HeaderHovered]          = ImVec4(0.70, 0.35, 0.01, 1.00)
		colors[clr.HeaderActive]           = ImVec4(1.00, 0.49, 0.00, 1.00)
		colors[clr.SeparatorHovered]       = ImVec4(0.49, 0.24, 0.00, 0.78)
		colors[clr.SeparatorActive]        = ImVec4(0.49, 0.24, 0.00, 1.00)
		colors[clr.ResizeGrip]             = ImVec4(0.48, 0.23, 0.00, 1.00)
		colors[clr.ResizeGripHovered]      = ImVec4(0.78, 0.38, 0.00, 1.00)
		colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.49, 0.00, 1.00)
		colors[clr.PlotLines]              = ImVec4(0.83, 0.41, 0.00, 1.00)
		colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.99, 0.00, 1.00)
		colors[clr.PlotHistogram]          = ImVec4(0.93, 0.46, 0.00, 1.00)
		colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.00)
		colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.53)
		colors[clr.ScrollbarGrab]          = ImVec4(0.33, 0.33, 0.33, 1.00)
		colors[clr.ScrollbarGrabHovered]   = ImVec4(0.39, 0.39, 0.39, 1.00)
		colors[clr.ScrollbarGrabActive]    = ImVec4(0.48, 0.48, 0.48, 1.00)
		colors[clr.CloseButton]            = colors[clr.FrameBg]
		colors[clr.CloseButtonHovered]     = colors[clr.FrameBgHovered]
		colors[clr.CloseButtonActive]      = colors[clr.FrameBgActive]
	elseif tems.v == 3 then--ГЈГ®Г«ГіГЎГ Гї
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
	elseif tems.v == 4 then--ГІГҐГ¬Г­Г»Г© Г¤ГҐГ§Г Г©Г­ Г±Г Г©ГІГ 
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
	elseif tems.v == 6 then
		imgui.SwitchContext()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local clr = imgui.Col
		local ImVec4 = imgui.ImVec4
		local ImVec2 = imgui.ImVec2

		style.WindowRounding         = 4.0
		style.WindowTitleAlign       = ImVec2(0.5, 0.5)
		style.ChildWindowRounding    = 2.0
		style.FrameRounding          = 2.0
		style.ItemSpacing            = ImVec2(10, 5)
		style.ScrollbarSize          = 15
		style.ScrollbarRounding      = 0
		style.GrabMinSize            = 9.6
		style.GrabRounding           = 1.0
		style.WindowPadding          = ImVec2(10, 10)
		style.AntiAliasedLines       = true
		style.AntiAliasedShapes      = true
		style.FramePadding           = ImVec2(5, 4)
		style.DisplayWindowPadding   = ImVec2(27, 27)
		style.DisplaySafeAreaPadding = ImVec2(5, 5)
		style.ButtonTextAlign        = ImVec2(0.5, 0.5)

		colors[clr.Text]                 = ImVec4(0.92, 0.92, 0.92, 1.00)
		colors[clr.TextDisabled]         = ImVec4(0.44, 0.44, 0.44, 1.00)
		colors[clr.WindowBg]             = ImVec4(0.06, 0.06, 0.06, 1.00)
		colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.ComboBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
		colors[clr.Border]               = ImVec4(0.51, 0.36, 0.15, 1.00)
		colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
		colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
		colors[clr.FrameBgHovered]       = ImVec4(0.51, 0.36, 0.15, 1.00)
		colors[clr.FrameBgActive]        = ImVec4(0.78, 0.55, 0.21, 1.00)
		colors[clr.TitleBg]              = ImVec4(0.51, 0.36, 0.15, 1.00)
		colors[clr.TitleBgActive]        = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
		colors[clr.MenuBarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00)
		colors[clr.ScrollbarBg]          = ImVec4(0.06, 0.06, 0.06, 0.53)
		colors[clr.ScrollbarGrab]        = ImVec4(0.21, 0.21, 0.21, 1.00)
		colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
		colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
		colors[clr.CheckMark]            = ImVec4(0.78, 0.55, 0.21, 1.00)
		colors[clr.SliderGrab]           = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.SliderGrabActive]     = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.Button]               = ImVec4(0.51, 0.36, 0.15, 1.00)
		colors[clr.ButtonHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.ButtonActive]         = ImVec4(0.78, 0.55, 0.21, 1.00)
		colors[clr.Header]               = ImVec4(0.51, 0.36, 0.15, 1.00)
		colors[clr.HeaderHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.HeaderActive]         = ImVec4(0.93, 0.65, 0.14, 1.00)
		colors[clr.Separator]            = ImVec4(0.21, 0.21, 0.21, 1.00)
		colors[clr.SeparatorHovered]     = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.SeparatorActive]      = ImVec4(0.78, 0.55, 0.21, 1.00)
		colors[clr.ResizeGrip]           = ImVec4(0.21, 0.21, 0.21, 1.00)
		colors[clr.ResizeGripHovered]    = ImVec4(0.91, 0.64, 0.13, 1.00)
		colors[clr.ResizeGripActive]     = ImVec4(0.78, 0.55, 0.21, 1.00)
		colors[clr.CloseButton]          = ImVec4(0.47, 0.47, 0.47, 1.00)
		colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
		colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
		colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
		colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
		colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
		colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
		colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
	end
end






