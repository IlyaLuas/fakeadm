--==========================================================Info
script_author('IlyaLua')
script_name('FakeAdmin')
script_version('v1.0')
script_version_number(1.0)
script_moonloader('0.26')
--==========================================================Lib
require "lib.moonloader"
require 'lib.vkeys'
local on = require "lib.samp.events"

local broadcaster = import('lib/broadcaster.lua')

local inicfg = require 'inicfg'
local imgui = require 'imgui'

local encoding = require 'encoding' 
encoding.default = 'CP1251' 
u8 = encoding.UTF8
--==========================================================inicfg







--==========================================================imgui
