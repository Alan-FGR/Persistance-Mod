--	
--	####################################################################
--	SZABO'S PERSISTANCE MOD
--	0.0.1.07bWIP	NOTE: 'b' stands for BETA VERSION! Use at your own risk!!!
--	####################################################################
--
-- CONFIGURE THE KEYS BELOW. Further down you find a list of the codes
local savekey = 96
local reloadkey = 110
local disablemodkey = 109
local enablegamepad = true
local modenabled = true -- SET TO false if you don't want the persistence to be enabled by default - does not affect saved
						--vehicles, this only applies to the 'persistent' ones you drove, which can cause problems in missions
-- Controller: 	Save: D-pad Right + Right Stick Click		Reset Vehicles: D-pad Right + Left Stick Click
--						Enable/Disable: D-pad Right + Left Bumper + Left Stick Click

-- CONFIGURE THE PATH WHERE THE FILE WILL BE SAVED. NOTE: Make sure Windows allows writing there.
-- 99.9% of the problems will be due bad data on the line below OR Windows permissions nonsense.
-- IMPORTANT!: Double-check the slashes (/) (they're NOT backslashes (\) ) and the LAST SLASH too!
-- IMPORTANT!: The path must be between quotation marks ("). Use the default value for reference.
local savepath = "C:/Users/Alan/Documents/Rockstar Games/"

-- CHOOSE A COOL TEXT TO APPEAR IN THE LICENSE PLATES OF YOUR SAVED VEHICLES! (Max. 8 dig.)
-- IMPORTANT!: The text must be between quotation marks ("). Use the default value for reference.
local platetext = "MYPLATE"
local useplates = true --change to false if you don't want the plates to change

--	####################################################################
--		KEY CODES
--	####################################################################
--
--	Space = 32            D4 = 52       O = 79             NumPad4 = 100         F9 = 120
--  PageUp = 33           D5 = 53       P = 80             NumPad5 = 101         F10 = 121
--	Next = 34             D6 = 54       Q = 81             NumPad6 = 102         F11 = 122
--  End = 35              D7 = 55       R = 82             NumPad7 = 103         F12 = 123
--	Home = 36             D8 = 56       S = 83             NumPad8 = 104         F13 = 124
--  Left = 37             D9 = 57       T = 84             NumPad9 = 105         F14 = 125
--	Up = 38               A = 65        U = 85             Multiply = 106        F15 = 126
--  Right = 39            B = 66        V = 86             Add = 107             F16 = 127
--	Down = 40             C = 67        W = 87             Separator = 108       F17 = 128
--  Select = 41           D = 68        X = 88             Subtract = 109        F18 = 129
--  Print = 42            E = 69        Y = 89             Decimal = 110         F19 = 130
--	Execute = 43          F = 70        Z = 90             Divide = 111          F20 = 131
--  PrintScreen = 44      G = 71        LWin = 91          F1 = 112              F21 = 132
--	Insert = 45           H = 72        RWin = 92          F2 = 113              F22 = 133
--  Delete = 46           I = 73        Apps = 93          F3 = 114              F23 = 134
--	Help = 47             J = 74        Sleep = 95         F4 = 115              F24 = 135
--  D0 = 48               K = 75        NumPad0 = 96       F5 = 116            
--	D1 = 49               L = 76        NumPad1 = 97       F6 = 117            
--  D2 = 50               M = 77        NumPad2 = 98       F7 = 118            
--	D3 = 51               N = 78        NumPad3 = 99       F8 = 119            
--
--	####################################################################
--		ABOUT THE MOD
--	####################################################################
--
--	What this mod does: It makes the last vehicles you've entered never disappear AND it allows you
--	to save as many vehicles as you want on the map, so they always stay there no matter what.
--	This allows you to effectively create 'garages' anywhere.
--
--	How to save vehicles: 
--	When driving a vehicle, park it and press the 'savekey', the plate will change to the one you configured, meaning that
--	the vehicle will be saved AT THE POSITION IT WAS WHEN YOU PRESSED THE KEY. The map marker of the vehicle will change
-- 	from ORANGE (meaning it was one of the 3 'persistent' vehicles), to GREEN, meaning it is a SAVED vehicle.
--	Saved vehicles will never despawn, and you can revert all the saved vehicles to their saved positions by pressing
--	the 'reloadkey'. 
--	If you want to 'unsave' a vehicle, simply press the 'savekey' again when driving it, the plate will change to
--	NOTSAVED and the vehicle will despawn as soon as the engine sees fit.
--
--	How it works:
--	It manages the vehicles in three ways:
--		1- The saved vehicles that are spawned on the map will be marked in green on the radar and will despawn when you get far.
--				This only affect the vehicles that you didn't drive (see below).
--		2- The saved vehicles that you drive will blink their marks, and after you have 3 of them, the former ones will revert
--				back to their saved positions. This is necessary to avoid over-usage of VRAM.
--		3- The random vehicles you entered are marked in orange and won't despawn, but just as the above, after there are 3 of
--				them on the map the former ones will be allowed to 'despawn'.
--	
--	The saved vehicles are saved to a file in the disk and will be there after you exit and relaunch the game.
--
-- 	KNOWN ISSUES:
--	THE FOLLOWING WON'T BE SAVED: Neon lights, Plate style
--	If you don't change the paint type in LSC and browse other paints, the saved paint type is going to be the
--	one that was highlighted when you cancelled. This doesn't apply to colours, only paint types are affected 
--	e.g.: matte, metallic, etc.. Please note that if you do change the paint type, no matter which painting was
--	highlighted when you cancelled the purchase, it will work correctly. This problem will only happen on the
--	rare occasions in which you enter the LSC with a paint 'x' in you car, then browse another category, say, 
--	'chrome', and hit 'cancel' (Esc or B) until you leave LSC AND don't change the original paint 'x'.
--	This shouldn't affect most people, but it's a bug that unfortunately I'm not able to fix. The bug is on the
--	following native function: VEHICLE::GET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)	
--
--	####################################################################
--
-- ADVANCED CONFIGURATION (Don't change this if unsure):

local persistentqty = 3 	--number of cars to never despawn, both from saveds and random
local spawndistance = 70	-- distance the vehicles will appear
local loopspeed = 5			-- increase ONLY if vehicles are taking too long to appear

--	####################################################################
--
--	Copyright (c) 2015 Szabo on http://gtaforums.com
--
--	This file is licensed under a restrictive authorial license that can be enforced in most countries.
--	You need my permission to redistribute this file or to modify it (except for personal usage).
--	The non-compliance of the terms above will result in legal proceedings.
--	Thieves will be sued. Trespassers will be shot. Beware of the dog.
--
--	By using this you agree that I take ABSOLUTELY NO responsibility for the usage of this mod.
--	If it causes your roomba to go terminator and nuke our planet, it's your responsibility.
--
--	####################################################################
--	CHANGELOG
--	####################################################################
--	
--	0.0.1.07b - Added Controller Support.
--
--	0.0.1.06b - Custom tyres works now. (Thanks to unknown modder @ gtaforums.com)
--				Paint shader works now. (See Known Issues)
--
--	0.0.1.02b - Improved backwards compatibility.
--
--	0.0.1b - Small code revamp and fixes, and now the following data will also be saved:
--			Bulletproof tyres; metallic paint; rims paint; tyre smoke colour; livery (very few vehicles use this)
--		-> Fixed my inttobool function_ which was the culprit of the Xenon Headlamps problems :)
--
--	0.0.0.07b - minor fixes
--
--	PREVIOUS - no changelog for previous versions - see forum thread if curious
--	
--	####################################################################
--	CREDITS: (to be ordered)
--	####################################################################
--	
--	Alexander Blade for Script Hook
--	headscript @ gtaforums.com for LUA Plugin for Script Hook
--	
--	####################################################################
--	THANKS:
--	####################################################################
--	
--	I would like to thank everyone who encouraged me in some way, either by voting,
--	commenting, making a video, sharing a snippet, etc.
--	
--	And want to thank these guys specially:
--	-> janimal @ gtaforums.com	for helping me test and debug the mod extensively
--	(TODO add more | please contact me if you think you should be here!)
--	
--	
--	
--	
--	####################################################################
--	WARNING: THE LINES BELOW CONTAIN DEVELOPMENT DATA (IT'S MESSY)
--	####################################################################
--	
-- Plate styles: VEHICLE::GET_VEHICLE_PLATE_TYPE (not sure how to set, possibly SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX)
--			(None of the above seems to work correctly)
--	
--	####################################################################
--
--	OTHER INFOS TO SAVE, TODO & DEV TESTING/NOTES: 
--		## MOVED TO THE BOTTOM OF THIS DOCUMENT ##
--
--	####################################################################
--
--	TODO: Reveal all saved vehicles on the map when the game is paused.

--	TODO: If VEHICLE::IS_VEHICLE_IN_GARAGE_AREA then don't save it
--				### UPDATE: Need to check every garage :(

--	TODO: LOOP ALL VEHICLES AND IF THERE ARE PASSENGERS AND PLAYER IS NOT ONE OF THEM, ALLOW DESPAWN
--			^(Remove persistence of vehicle if it's being driven and player is not on it to prevent problems.)

--	TODO:	SAVE DIRT LEVEL JUST FOR FUN :P
--				### UPDATE: Need to save it automatically

--	TODO:	DISABLE SAVING STOLEN CARS (YOU FILTHY THIEVES >:( ... :P)
--				### UPDATE: VEHICLE.IS_VEHICLE_STOLEN always returns false :(

--	TODO:	learn how to use lua properly
--	TODO:	a function_ to deal with the repetitive loops


local szabopersist = {}

local unvid = 0

local lastPlayerState = false
local persistentVehicles = {}
local savedVehicles = {}
local spawnedSavedVehicles = {}
local drivenSavedVehicles = {}

local function booltoint(bool)
	if bool then
		return 1
	else
		return 0
	end
end

local function inttobool(int)
	
	if (tonumber(int) == 0 or int == false) then
		--print('inttobool - in, out: ', int, "false")
		return false
	else
		--print('inttobool - in, out: ', int, "true")
		return true
	end
end

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function getdictlen(d)
	local c = 0
	for x in pairs(d) do
		c = c + 1 -- C++ :B
	end
	return c
end

local function table_insertmultiple(xtable, ...)
  for _, v in ipairs({...}) do
    table.insert(xtable, v)
  end
end

local function disablepersistent()
	for i, v in ipairs(persistentVehicles) do
		ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(v)
		UI.REMOVE_BLIP(UI.GET_BLIP_FROM_ENTITY(v))
	end
	
	persistentVehicles = {}
end

local function getindexofvidinarray(vid, array)
	for i, vdata in ipairs(array) do
		if(vid == vdata[1]) then
			return i
		end
	end
	return -1
end

local function isvehiclespawnedordriven(v)
	for _, spawneddata in ipairs(spawnedSavedVehicles) do	
		if (v == spawneddata[2]) then						
			return true
		end
	end
	for _, drivendata in ipairs(drivenSavedVehicles) do		
		if (v == drivendata[2]) then						
			return true
		end
	end
	return false
end

local function cleardriven()
	if (#drivenSavedVehicles > persistentqty) then						
		print('resetting old saved vehicle to its position')			
		local oldvehicle = drivenSavedVehicles[1][2]
		ENTITY.SET_ENTITY_AS_MISSION_ENTITY(oldvehicle, true, true)
		VEHICLE.DELETE_VEHICLE(oldvehicle)								
		table.remove(drivenSavedVehicles, 1)							
	end
end

function szabopersist.unload()
	--NOTE: this is only used for development
	-- print('unloading szabopersist')
	-- unloadspawnedsavedcars()
	-- disablepersistent()
end

local texttimer = 50 --this var is used for heatup too
local texttoshow = "SZABO'S PERSISTANCE MOD"
local function showtext(str)
	texttimer = 50
	texttoshow = str
end

local function drawtext()
	UI.SET_TEXT_FONT(0)
	UI.SET_TEXT_SCALE(0.6, 0.8)
	UI.SET_TEXT_COLOUR(255, 255, 255, 255)
	UI.SET_TEXT_WRAP(0, 1)
	UI.SET_TEXT_CENTRE(true)
	UI.SET_TEXT_DROPSHADOW(15, 15, 0, 0, 0)
	UI.SET_TEXT_EDGE(5, 0, 0, 0, 255)
	UI._SET_TEXT_ENTRY("STRING")
	UI._ADD_TEXT_COMPONENT_STRING(texttoshow)
	UI._DRAW_TEXT(0.5, 0)
	texttimer = texttimer-1
end

local function removevehiclemarker(v)
	while (UI.GET_BLIP_FROM_ENTITY(v) ~= 0) do
		UI.REMOVE_BLIP(UI.GET_BLIP_FROM_ENTITY(v))
		wait(0)
	end
end

local function setvehiclemarker(v, mtype)

	local blink = false
	local col = 16742399 --green-blue		spawned
	if(mtype == 1) then
		--col = 2013200639 --green-yellow		driven
		col = 16742399 --green-blue
		blink = true
	elseif (mtype == 2) then
		--col = 4294902015 --yellow	persist
		col = 0xFF9900FF --orange	persist
	end

	if (useplates and mtype ~= 2) then
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(v, string.sub(platetext, 1, 8));
	end
	
	removevehiclemarker(v)
	
	local blip = UI.ADD_BLIP_FOR_ENTITY(v)
	UI.SET_BLIP_SCALE(blip, 0.6)
	UI.SET_BLIP_COLOUR(blip, col)
	
	if (blink) then
		UI.SET_BLIP_FLASHES(blip, true)
	end
	
end

local function addvehicletosavedarray(v)
	
	local coords = ENTITY.GET_ENTITY_COORDS(v, true)
	
	local colr, colg, colb = VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v,0,0,0)
	local col2r, col2g, col2b = VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v,0,0,0)

	local vals = {ENTITY.GET_ENTITY_MODEL(v), coords.x, coords.y, coords.z, ENTITY.GET_ENTITY_HEADING(v), colr, colg, colb, col2r, col2g, col2b}

	--using table.insert for easier debugging, 'final' version won't be like this
	table.insert(	vals,	VEHICLE.GET_VEHICLE_WHEEL_TYPE(v)  	 	)	--Wheels
	table.insert(	vals,	VEHICLE.GET_VEHICLE_WINDOW_TINT(v) 	 	)	--Film
					
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 0)   	 	)	--Spoilers
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 1)   	 	)	--Front Bumper
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 2)   	 	)	--Rear Bumper
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 3)   	 	)	--Side Skirt
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 4)   	 	)	--Exhaust
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 5)   	 	)	--Frame
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 6)   	 	)	--Grille
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 7)   	 	)	--Hood
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 8)   	 	)	--Fender
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 9)   	 	)	--Right Fender
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 10)  	 	)	--Roof
	
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 11)  	 	)	--Engine
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 12)  	 	)	--Brakes
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 13)  	 	)	--Transmission
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 14) 	 		)	--Horns
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 15)  	 	)	--Suspension
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 16)  	 	)	--Armor
				 
	table.insert(	vals,	VEHICLE.IS_TOGGLE_MOD_ON(v, 18)			)	--Turbo
	table.insert(	vals,	VEHICLE.IS_TOGGLE_MOD_ON(v, 22)			)	--Xenon
				 
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 23)	  		)	--Front Wheels
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD(v, 24)	  		)	--Back Wheels (BIKES ONLY)

	
	--## UPDATE 0.0.1b changes below

	table.insert(	vals,	VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(v))	-- bulletproof tyres -- OK
	table_insertmultiple(	vals,	VEHICLE.GET_VEHICLE_EXTRA_COLOURS(v, 0, 0))	--metallic/pearlscent highlight colour AND rims colour
	table.insert(	vals,	VEHICLE.GET_VEHICLE_LIVERY(v))	-- LIVERY FOR SOME MODELS (STOCK CARS)
	table_insertmultiple(	vals,	VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(v, 0, 0, 0)) -- OK	-- tire smoke colour -- OK
	
	--## UPDATE 0.0.1.05b changes below
	
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD_VARIATION(v, 23)) --custom tyres
	table.insert(	vals,	VEHICLE.GET_VEHICLE_MOD_VARIATION(v, 24)) --custom tyres
	
	--## UPDATE 0.0.1.06b below
	local paintshaderid = VEHICLE.GET_VEHICLE_MOD_COLOR_1(v, 0, 0, 0) --this is kinda buggy
	table.insert( vals, paintshaderid)
	local paintshaderid2 = VEHICLE.GET_VEHICLE_MOD_COLOR_2(v, 0, 0)
	table.insert( vals, paintshaderid2)
	
	
	
	unvid = unvid+1
	table.insert(savedVehicles, {unvid, vals})
	table.insert(drivenSavedVehicles, {unvid, v})
	
	ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
	
	setvehiclemarker(v, 1)
	cleardriven()
	
	showtext("THIS VEHICLE WAS SAVED AT THIS POSITION")
	
end

local function getcsvfromarrayentry(e)

	local valscsv = e[1]
		
	for i, val in ipairs(e) do
		if (i>1) then
			if (type(val) == type(true)) then
				valscsv = valscsv .. "," .. booltoint(val)
			else
				valscsv = valscsv .. "," .. val
			end
		end
	end
	
	return valscsv
end

local function getarrayentryfromstringdata(csvstr)
	local vals = {}
	for val in string.gmatch(csvstr, '[^,]+') do
		table.insert(vals, val)
	end
	table.insert(savedVehicles, {unvid, vals})
	print(#savedVehicles)
end

local function loadsaveddata()
	
	local sfile = savepath .. "szabopersist"
	
	if (not file_exists(sfile)) then
		io.close(io.open(sfile, "w")) --kinda touch
	end
	
	for line in io.lines(sfile) do
		getarrayentryfromstringdata(line)
		unvid=unvid+1
	end
	
end

-- function indieloop()
	-- while (true) do
		-- print(UI.IS_PAUSE_MENU_ACTIVE(), UI.GET_PAUSE_MENU_STATE())
	-- end
-- end

function szabopersist.init()
    -- coroutine.resume(coroutine.create(indieloop))
	loadsaveddata()
end

local function setvehicledata(v, dtype, parslist)
	
	if (parslist == nil) then
		return 2
	elseif( type(parslist) ~= type({}) or #parslist < 1) then
		if (dtype == 'extracols') then
			print('resetting unsaved colours to neutral colour (backwards compatibility)')
			VEHICLE.SET_VEHICLE_EXTRA_COLOURS(v, 0, 0)
		end
		return 3
	elseif (dtype == 'mod') then
		VEHICLE.SET_VEHICLE_MOD(v, parslist[1], parslist[2], false)
	elseif (dtype == 'togglemod') then
		VEHICLE.TOGGLE_VEHICLE_MOD(v, parslist[1], inttobool(parslist[2]))
	elseif (dtype == 'tyres') then
		VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(v, inttobool(parslist[1]))
	elseif (dtype == 'extracols') then
		VEHICLE.SET_VEHICLE_EXTRA_COLOURS(v, parslist[1], parslist[2])
	elseif (dtype == 'livery') then
		VEHICLE.SET_VEHICLE_LIVERY(v, parslist[1])
	elseif (dtype == 'tsmoke') then
		VEHICLE.TOGGLE_VEHICLE_MOD(v, 20, true)
		VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(v, parslist[1], parslist[2], parslist[3])
	elseif (dtype == 'ctyres') then
		if (parslist[1] == 'back') then
			VEHICLE.SET_VEHICLE_MOD(v, 24, VEHICLE.GET_VEHICLE_MOD(v, 24), inttobool(parslist[2]))
		else
			VEHICLE.SET_VEHICLE_MOD(v, 23, VEHICLE.GET_VEHICLE_MOD(v, 23), inttobool(parslist[2]))
		end
	elseif (dtype == 'paint') then
		if (parslist[2] ~= nil) then
			if (parslist[1] == 1) then
				VEHICLE.SET_VEHICLE_MOD_COLOR_1(v, parslist[2], 0, 0)
			else
				VEHICLE.SET_VEHICLE_MOD_COLOR_2(v, parslist[2], 0)
			end
		end
	end
	
end

local function spawnvehiclefromdata(vals)
		
		local enthash = vals[1]
		
		STREAMING.REQUEST_MODEL(enthash)
		
		while (not STREAMING.HAS_MODEL_LOADED(enthash)) do
			wait(0)
		end
		
		local nearv = VEHICLE.GET_CLOSEST_VEHICLE(vals[2],vals[3],vals[4], 3, 0, 70)
		--print(nearv)
		if (nearv ~= 0 and not isvehiclespawnedordriven(nearv)) then
			print('delete')
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(nearv, true, true)
			VEHICLE.DELETE_VEHICLE(nearv)
		end
		
		local v = VEHICLE.CREATE_VEHICLE(enthash, vals[2],vals[3],vals[4], vals[5], true, true)
		VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(v);
		
		--cloning vehicle
		VEHICLE.SET_VEHICLE_MOD_KIT(v, 0);
		
		--## 0.0.1.06b changes below
		setvehicledata(v, 'paint', {1,vals[44]})   --paint shader TODO:move up
		setvehicledata(v, 'paint', {2,vals[45]})
				
				
				
		VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v,vals[6],vals[7],vals[8])
		VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v,vals[9],vals[10],vals[11])
		
		
		
		VEHICLE.SET_VEHICLE_WHEEL_TYPE(v, 	vals[12]);   		--Wheels
		VEHICLE.SET_VEHICLE_WINDOW_TINT(v, 	vals[13]);  		--Film
		setvehicledata(v, 'mod', {0,	vals[14]}) -- VEHICLE.SET_VEHICLE_MOD(v, 0,	vals[14], false);   --Spoilers
		setvehicledata(v, 'mod', {1,	vals[15]})   --Front Bumper
		setvehicledata(v, 'mod', {2,	vals[16]})   --Rear Bumper
		setvehicledata(v, 'mod', {3,	vals[17]})   --Side Skirt
		setvehicledata(v, 'mod', {4,	vals[18]})   --Exhaust
		setvehicledata(v, 'mod', {5,	vals[19]})   --Frame
		setvehicledata(v, 'mod', {6,	vals[20]})   --Grille
		setvehicledata(v, 'mod', {7,	vals[21]})   --Hood
		setvehicledata(v, 'mod', {8,	vals[22]})   --Fender
		setvehicledata(v, 'mod', {9,	vals[23]})   --Right Fender
		setvehicledata(v, 'mod', {10,	vals[24]})   --Roof
		setvehicledata(v, 'mod', {11,	vals[25]})   --Engine
		setvehicledata(v, 'mod', {12,	vals[26]})   --Brakes
		setvehicledata(v, 'mod', {13,	vals[27]})   --Transmission
		setvehicledata(v, 'mod', {14,	vals[28]})  --Horns
		setvehicledata(v, 'mod', {15,	vals[29]})   --Suspension
		setvehicledata(v, 'mod', {16,	vals[30]})   --Armor
		setvehicledata(v, 'togglemod', {18, vals[31]})	--VEHICLE.TOGGLE_VEHICLE_MOD(v, 18, inttobool(vals[31]));	--Turbo
		setvehicledata(v, 'togglemod', {22, vals[32]})	--Xenon
		setvehicledata(v, 'mod', {23, 	vals[33]}) 	--Front Wheels
		setvehicledata(v, 'mod', {24, 	vals[34]}) 	--Back Wheels (BIKE ONLY)  --check if is bike?
		
		--## UPDATE 0.0.1b changes below
		setvehicledata(v, 'tyres', { vals[35] })	-- bulletproof tyres
		setvehicledata(v, 'extracols', {vals[36], vals[37]})	--metallic/pearlscent highlight colour AND rims colour
		setvehicledata(v, 'livery', {vals[38]})	--livery
		setvehicledata(v, 'tsmoke', {vals[39], vals[40], vals[41]})	-- tire smoke colour
		
		--## UPDATE 0.0.1.05b changes below
		setvehicledata(v, 'ctyres', {0, vals[42] })
		setvehicledata(v, 'ctyres', {'back', vals[43] })  --check if is bike?
		
		
		
		--end cloning dolly
		
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(enthash)
		ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
		-- 

		setvehiclemarker(v)
		
		return v
	
end

local function unloadspawnedsavedcars()
	for k, v in pairs(spawnedSavedVehicles) do
		VEHICLE.DELETE_VEHICLE(v[2])
	end
	for i, dd in ipairs(drivenSavedVehicles) do
		ENTITY.SET_ENTITY_AS_MISSION_ENTITY(dd[2], true, true)
		VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(dd[2],255,0,255) --for debug
		VEHICLE.DELETE_VEHICLE(dd[2])
	end
	
	spawnedSavedVehicles = {}
	drivenSavedVehicles = {}
end

-- woof! woof! ... grrrrr WOOF!

local lastkeystate = false
local lastreloadkeystate = false
local lastdisablekeystate = false

local lazycounter = 0;
local function lazyload(pped)

	if(lazycounter >= #savedVehicles) then	
		lazycounter = 0
	end
	lazycounter = lazycounter+1

	local vid = savedVehicles[lazycounter][1]	
	local vdata = savedVehicles[lazycounter][2]	
	
	local playerCoords = ENTITY.GET_ENTITY_COORDS(pped, true)
	
	local spawned = false
	for _, spawneddata in ipairs(spawnedSavedVehicles) do	
		if (vid == spawneddata[1]) then						
			spawned = true									
			break
		end
	end
	
	local driven = false
	for _, drivendata in ipairs(drivenSavedVehicles) do		
		if (vid == drivendata[1]) then						
			driven = true									
			break
		end
	end
	
	if (GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(playerCoords.x, playerCoords.y, playerCoords.z, vdata[2], vdata[3], vdata[4], true	) < spawndistance) then
		if (not spawned and not driven) then	
			spv = spawnvehiclefromdata(vdata)	
			table.insert(spawnedSavedVehicles, {vid, spv})				
			print('vehicle near')
		end
	else
		if (spawned and not driven) then		
			local spawnedindex = getindexofvidinarray(vid,spawnedSavedVehicles)
			VEHICLE.DELETE_VEHICLE(spawnedSavedVehicles[spawnedindex][2])	
			table.remove(spawnedSavedVehicles, spawnedindex)		
			print('vehicle far')
		end
	end
end

local hot = false;
function szabopersist.tick()

	local playerPed = PLAYER.PLAYER_PED_ID()
	local playerState = PED.IS_PED_IN_ANY_VEHICLE(playerPed, false)
	
	if(not hot) then
		print('heating up', texttimer)
		
		if (texttimer > 1) then
			if (not CAM.IS_SCREEN_FADED_OUT()) then
				texttimer = texttimer-1
			end
			drawtext()
			return 0
		else
			hot = true
		end
		
	end
	
	local loadpass = 0
	while loadpass < loopspeed and #savedVehicles > 0 do
		lazyload(playerPed)
		loadpass = loadpass + 1
	end
	
	local issavepressed = (get_key_pressed(savekey) or (enablegamepad and CONTROLS.IS_CONTROL_PRESSED(2, 190) and CONTROLS.IS_CONTROL_JUST_PRESSED(2, 210)))
	local isreloadpressed = (get_key_pressed(reloadkey) or (enablegamepad and CONTROLS.IS_CONTROL_PRESSED(2, 190) and CONTROLS.IS_CONTROL_JUST_PRESSED(2, 209)))
	local isdisablepressed = (get_key_pressed(disablemodkey) or (enablegamepad and CONTROLS.IS_CONTROL_PRESSED(2, 190) and CONTROLS.IS_CONTROL_PRESSED(2, 205)  and CONTROLS.IS_CONTROL_JUST_PRESSED(2, 209)))
	
	if(issavepressed and not lastkeystate) then					
		
		local currentVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
		
		if (currentVehicle ~= 0) then										
			
			local vehicleSaved = false											
														
			for i, dvd in ipairs(drivenSavedVehicles) do					
				if (dvd[2] == currentVehicle) then							
					vehicleSaved = true
					
					print("vehicle is saved, unsaving it")
					table.remove(savedVehicles, getindexofvidinarray(dvd[1], savedVehicles))	
					table.remove(drivenSavedVehicles, i)							
					ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(currentVehicle)			
					removevehiclemarker(currentVehicle)
					
					if (useplates) then
						VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(currentVehicle, "NOTSAVED");
					end
					
					showtext("THIS VEHICLE WAS UNSAVED")
					
					break
					
				end
			end
			
			
			if (not vehicleSaved) then				
				
				for i, v in ipairs(persistentVehicles) do
					if (v == currentVehicle) then
						table.remove(persistentVehicles, i)
						print("turning persistent vehicle into saved vehicle")
						break
					end
				end
				
				print('saving vehicle')
				addvehicletosavedarray(currentVehicle)			
			end
			
			
			local file = io.open(savepath .. "szabopersist", "w")		
			io.output(file)
			
			for i, v in ipairs(savedVehicles) do
				local vdata = getcsvfromarrayentry(v[2])
				io.write(vdata .. "\n")
			end
			
			io.close(file)							
			
		
		end
	
	elseif(isreloadpressed and not lastreloadkeystate and not isdisablepressed) then
		unloadspawnedsavedcars()
		
	elseif(isdisablepressed and not lastdisablekeystate) then
		disablepersistent()
		modenabled = not modenabled
		
		if modenabled then
			showtext("Szabo's Persistance Mod ENABLED")
		else
			showtext("Szabo's Persistance Mod DISABLED")
		end
	end
	
	if (playerState and (not lastPlayerState)) then								
	
		local currentVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
		local vehiclePersistent = false
		
		print("entered vehicle")
		
		for i, svdata in ipairs(spawnedSavedVehicles) do						
			if (svdata[2] == currentVehicle) then								
				table.insert(drivenSavedVehicles, {svdata[1], currentVehicle})
				table.remove(spawnedSavedVehicles, i)							
				vehiclePersistent = true			
				setvehiclemarker(currentVehicle, 1)
				print("vehicle is saved, thus it's persistent, returning")
				cleardriven()
				break
			end
		end
		
		-- TODO: OPTIMIZE BELOW (check vehiclePersistent?)
		for i, svdata in ipairs(drivenSavedVehicles) do						
			if (svdata[2] == currentVehicle) then										
				vehiclePersistent = true
				print("vehicle is saved and in use, thus it's persistent, returning")
				break
			end
		end
		
		for _, v in ipairs(persistentVehicles) do
			if (v == currentVehicle) then
				vehiclePersistent = true
				print("vehicle already persistent, returning")
				break
			end
		end
		
		if (not vehiclePersistent and modenabled) then
			
			if (#persistentVehicles > persistentqty-1) then 
				removevehiclemarker(persistentVehicles[1])
				ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(persistentVehicles[1])
				table.remove(persistentVehicles, 1)
				print("allowing old vehicle to despawn")
			end
			
			table.insert(persistentVehicles, currentVehicle)
			
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(currentVehicle, true, true)
			
			setvehiclemarker(currentVehicle, 2)
			
			print("current vehicle won't despawn")
		end
		

		
	end
	
	lastkeystate = issavepressed
	lastreloadkeystate = isreloadpressed
	lastdisablekeystate = isdisablepressed
	lastPlayerState = playerState;
	
	if (texttimer > 0) then
		drawtext()
	end
	
	--szabopersist.debug()
	
end

function szabopersist.debug()



--	GAMEPLAY.SET_GAME_PAUSED(false)


	-- controller support test

	
	-- dpup=188		a=201	lstk=209
	-- dpdn=187		b=202	rstk=210
	-- dplt=189		x=203	
	-- dprt=190		y=204	

	
	
	--print(CONTROLS.IS_CONTROL_JUST_PRESSED(2, 210))
	

	

	




	--end controller support





	local playerPed = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(playerPed)
	local playerID = PLAYER.PLAYER_ID()
	local playerPos = ENTITY.GET_ENTITY_COORDS(playerPed, true)
	
	local currentVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)	

	if(get_key_pressed(107)) then
		local playerPed = PLAYER.PLAYER_PED_ID()
		local currentVehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed, false)
		
		
		VEHICLE.SET_VEHICLE_MOD_KIT(currentVehicle, 0)
		
		local platestyle = (VEHICLE._0xF11BC2DD9A3E7195(currentVehicle))
		
		print(platestyle)
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(currentVehicle, 2)
		

		
		
	end
	
	
	-- THESE DO NOTHING
	-- VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(currentVehicle, 3)
	-- VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(v, 1)
	-- print('plate set')
	
	
	
	
	local lastv = PLAYER.GET_PLAYERS_LAST_VEHICLE()
	
	-- ENTITY.SET_ENTITY_AS_MISSION_ENTITY(lastv, true, true)
	-- VEHICLE.SET_VEHICLE_EXTRA_COLOURS(lastv, 0, 0)
	-- VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(lastv)
	
	
	-- local paint, color, pearl = VEHICLE.GET_VEHICLE_MOD_COLOR_1(lastv, 0, 0, 0)
	--print(VEHICLE.GET_VEHICLE_MOD_COLOR_1(currentVehicle, 0, 0, 0))
	-- print(paint, color, pearl)
	
	
	
	local paintshaderid = VEHICLE.GET_VEHICLE_MOD_COLOR_1(lastv, 0, 0, 0) --this is kinda buggy
	-- print(paintshaderid)
	
	--SHADERS:	0=metallic	1=classic	2=?			3=matte			4=metal		5=chrome
	
	
	
	
	
	
	
	-- VEHICLE.SET_VEHICLE_MOD_COLOR_1(lastv, 5, 0, 0)
	-- VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(lastv,255,0,0)
	-- print(VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(lastv,0,0,0))
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	--knowing if it's paused/ing
	--print(UI.IS_PAUSE_MENU_ACTIVE(), UI.GET_PAUSE_MENU_STATE(), CAM.IS_SCREEN_FADING_OUT(), CAM.IS_SCREEN_FADED_OUT())
	
	
	
	
	
	
	
	-- print(VEHICLE.GET_VEHICLE_MOD_VARIATION(currentVehicle, 23)) --returns true if front tyres are custom(or all tyres for cars. 24 is rear bike tyres
	-- print(VEHICLE.GET_VEHICLE_MOD_VARIATION(currentVehicle, 23))
	-- VEHICLE.SET_VEHICLE_MOD(currentVehicle, 23, VEHICLE.GET_VEHICLE_MOD(currentVehicle, 23), false) --as before 24 for rear bike tyres

	--VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(currentVehicle)
	
	
	
	
	
	
	
	
	-- VEHICLE.SET_VEHICLE_MOD_KIT(currentVehicle, 1)
	
	-- VEHICLE.SET_CAN_RESPRAY_VEHICLE(currentVehicle, false)
	
	-- VEHICLE.GET_VEHICLE_COLOUR_COMBINATION(currentVehicle)
	-- VEHICLE.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER(currentVehicle, true)
	-- VEHICLE.GET_VEHICLE_EXTRA_COLOURS(currentVehicle, 0,0)
	
	
	--print(VEHICLE.GET_VEHICLE_MOD_KIT(currentVehicle))
	
	-- VEHICLE.SET_VEHICLE_MOD_COLOR_1(currentVehicle, 5, 0, 0)
	
	-- VEHICLE.SET_VEHICLE_DIRT_LEVEL(currentVehicle, 10)
	

	
	
	-- print(VEHICLE.GET_VEHICLE_COLOR(currentVehicle, 0,0,0))
	
	-- VEHICLE.SET_CAN_RESPRAY_VEHICLE(currentVehicle, true)
	
	
	
	
	
	
	
--	VEHICLE.SET_VEHICLE_MOD_KIT(currentVehicle, 0)
	

	-- bulletproof tyres -- OK
	--VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(currentVehicle) -- OK
	--VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(currentVehicle, false) -- OK
	
	--metallic/pearlscent highlight colour AND rims colour
	--VEHICLE.SET_VEHICLE_EXTRA_COLOURS(currentVehicle, 28, 81) -- OK
	--VEHICLE.GET_VEHICLE_EXTRA_COLOURS(currentVehicle, 0, 0)) -- OK - returns 2 values used for metallic paint shader and rims colour
	
	--VEHICLE.GET_VEHICLE_LIVERY(currentVehicle)) -- LIVERY FOR SOME MODELS (STOCK CARS)
	--VEHICLE.SET_VEHICLE_LIVERY(Vehicle vehicle, int LiveryIndex) // 0x7AD87059
	
	-- tire smoke colour -- OK
	--VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(currentVehicle, 0, 0, 0) -- OK
	-- VEHICLE.TOGGLE_VEHICLE_MOD(currentVehicle, 20, true)
	-- VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(currentVehicle, 255, 0, 0) -- OK
	-- AND/OR ?? toggle mod 20 -- Not used??
	
	
	--NOT USED (IN THE MOD) STUFF BELOW #####################################################
	
	--needed???
	--print(VEHICLE.GET_VEHICLE_COLOUR_COMBINATION(currentVehicle)) -- ALWAYS RETURNS THE SAME?
	-- SET_VEHICLE_COLOUR_COMBINATION(Any p0, Any p1) // 0xA557AEAD
	
	-- dirt lvl
	-- GET_VEHICLE_DIRT_LEVEL(Vehicle vehicle) // 0xFD15C065
	-- SET_VEHICLE_DIRT_LEVEL(Vehicle Vehicle, float DirtLVL) // 0x2B39128B -- OK
	
	
	--BUGGED STUFF BELOW #####################################################################
	
	-- plate style -- NW
	--VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(currentVehicle) -- RETURNS AN ERROR
	--VEHICLE::GET_VEHICLE_PLATE_TYPE -- ALWAYS RETURNS 2
	--SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX -- DOES NOTHING
	
	-- the below doesn't work properly and I don't think is needed
	--(VEHICLE.GET_VEHICLE_MOD_COLOR_1(currentVehicle, 0, 0, 0)) -- 1st COLOR ID IN LSC
	--VEHICLE.GET_VEHICLE_MOD_COLOR_2(currentVehicle, 0, 0) -- 2nd COLOR ID IN LSC
	
	--the below works, but it's buggy and I couldn't find a way to get it when not in LSC
	-- VEHICLE.SET_VEHICLE_MOD_KIT(currentVehicle, 0)
	-- VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(currentVehicle)
	-- VEHICLE.SET_VEHICLE_MOD_COLOR_1(currentVehicle, 5,0,0) 
	-- VEHICLE.SET_VEHICLE_MOD_KIT(currentVehicle, 0)
	
	--VEHICLE.SET_VEHICLE_MOD_COLOR_2(currentVehicle, 5,0)

	
	
	--##TESTS / random dev data #####################################################
	
	-- if(get_key_pressed(107)) then
		-- szabopersist.unload()
	-- end
	
	
	
	-- print(	
	-- VEHICLE.GET_VEHICLE_MOD(currentVehicle, 17),
	-- VEHICLE.GET_VEHICLE_MOD(currentVehicle, 25),
	-- VEHICLE.GET_VEHICLE_MOD(currentVehicle, 26),
	-- VEHICLE.GET_VEHICLE_MOD(currentVehicle, 27)
	-- )
	
	
	-- print(	
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 17),
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 19),
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 20), --tyre smoke 
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 21), 
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 23),
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 24),
			-- VEHICLE.IS_TOGGLE_MOD_ON(currentVehicle, 25)
			-- )
			
	-- print(VEHICLE.GET_VEHICLE_WHEEL_TYPE(currentVehicle), VEHICLE.GET_VEHICLE_MOD(currentVehicle, 23))
	
	
	
end
















return szabopersist







