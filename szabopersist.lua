local szaboautotheft = {}

local texttimer = 0
local texttoshow = ""
local function showtext5(str)
	texttimer = 300
	texttoshow = str
end

local function drawtext5()
	UI.SET_TEXT_FONT(0)
	UI.SET_TEXT_SCALE(0.5, 0.6)
	UI.SET_TEXT_COLOUR(255, 0, 0, 255)
	UI.SET_TEXT_WRAP(0, 1)
	UI.SET_TEXT_CENTRE(true)
	UI.SET_TEXT_DROPSHADOW(15, 15, 0, 0, 0)
	UI.SET_TEXT_EDGE(5, 0, 0, 0, 255)
	UI._SET_TEXT_ENTRY("STRING")
	UI._ADD_TEXT_COMPONENT_STRING(texttoshow)
	UI._DRAW_TEXT(0.5, 0.1)
	texttimer = texttimer-1
end

local function szclamp(val, xmin, xmax)
	if (val < xmin) then
		return xmin
	elseif (val > xmax) then
		return xmax
	else
		return val
	end
end

local function addmoneytoplayer(val)

	mhash = GAMEPLAY.GET_HASH_KEY("SP0_TOTAL_CASH")
	if (PED.IS_PED_MODEL(PLAYER.PLAYER_PED_ID(), GAMEPLAY.GET_HASH_KEY("player_one"))) then                                
		mhash = GAMEPLAY.GET_HASH_KEY("SP1_TOTAL_CASH")                                     
	elseif (PED.IS_PED_MODEL(PLAYER.PLAYER_PED_ID(), GAMEPLAY.GET_HASH_KEY("player_two"))) then
		mhash = GAMEPLAY.GET_HASH_KEY("SP2_TOTAL_CASH")  
	end
	
	local _, curval = STATS.STAT_GET_INT(mhash, 0, -1)
	STATS.STAT_SET_INT(mhash, curval+val, true)
		
end

local carslist = {
--expensive cars
{0xB779A091,	600000	},--adder
{0x9AE6DDA1,	93000	},--bullet
{0x7B8AB45F,	117000	},--carboniz
{0xB1D95DA0,	390000	},--cheetah
{0x13B57D8A,	111000	},--cogcabri
{0xB2FE5CF9,	477000	},--entityxf
{0xFFB15B5E,	123000	},--exemplar
{0xDCBCBE48,	111000	},--f620
{0x8911B9F5,	87000	},--feltzer?
{0xBC32A33B,	99000	},--fq2?
{0x18F25AC7,	264000	},--infernus
{0x3EAB5555,	285000	},--jb700
{0xE62B361B,	294000	},--monroe
{0x3D8FA25C,	72000	},--ninef
{0xA8E38B01,	72000	},--ninef2
{0x8CB29A14,	79000	},--rapidgt
{0x679450AF,	84000	},--rapidgt2
{0x5C23AF9B,	600000	},--stinger
{0x82E499FA,	660000	},--stingergt
{0x42F2ED16,	150000	},--superd
{0x142E0DC3,	144000	},--vacca
{0x9F4B77BE,	90000	},--voltic
{0x2D3BD401,	2000000	}--ztype
}

local cargo1list = {
--cargo lvl 1 50k - 300k
0xAFBB2CA4,
0xC9E8FF76,
0x98171BD3,
0x353B561D,
0xF8DE29A8,
0x38408341,
0x4543B74D,
0x961AFEF7,
0xCFB3870C,
0x2B6DC64A,
0x03E5F6B8
}

local cargo2list = {
--cargo lvl 2 300k-2m
0x7DE35E7D,
0x7A61B330,
0xF21B33BE,
0x07405E08,
0x35ED670B,
0xC1632BEB
}

local cargo3list = {
--stockade (lvl 3) 2-5m
0x6827CF72
}

local carspeds = {
0xBE086EFD,	--	A_F_M_BevHills_01
0xA039335F,	--	A_F_M_BevHills_02
-- 0x3BD99114,	--	A_F_M_BodyBuild_01
-- 0x1FC37DBC,	--	A_F_M_Business_02
0x654AD86E,	--	A_F_M_Downtown_01
0x445AC854,	--	A_F_Y_BevHills_01
0x5C2CF7F8,	--	A_F_Y_BevHills_02
-- 0x20C8012F,	--	A_F_Y_BevHills_03
-- 0x36DF2D5D,	--	A_F_Y_BevHills_04
-- 0x2799EFD8,	--	A_F_Y_Business_01
-- 0x31430342,	--	A_F_Y_Business_02
0xAE86FDB4,	--	A_F_Y_Business_03
0xB7C61032,	--	A_F_Y_Business_04
-- 0x563B8570,	--	A_F_Y_Tourist_01
-- 0x9123FB40,	--	A_F_Y_Tourist_02
0x19F41F65,	--	A_F_Y_Vinewood_01
0xDAB6A0EB,	--	A_F_Y_Vinewood_02
0x379DDAB8,	--	A_F_Y_Vinewood_03
0xFAE46146,	--	A_F_Y_Vinewood_04
0xC99F21C4,	--	A_M_Y_Business_01
0xB3B3F5E6,	--	A_M_Y_Business_02
0xA1435105,	--	A_M_Y_Business_03
0x4B64199D,	--	A_M_Y_Vinewood_01
0x5D15BD00,	--	A_M_Y_Vinewood_02
0x1FDF4294,	--	A_M_Y_Vinewood_03
0x31C9E669,	--	A_M_Y_Vinewood_04
0x54DBEE1F,	--	A_M_M_BevHills_01
0x3FB5C3D3,	--	A_M_M_BevHills_02
0x7E6A64B7,	--	A_M_M_Business_01
}

local cargospeds = {
0x59511A6C,	--	S_M_M_Trucker_01
-- 0xF5B0079D,	--	A_F_Y_EastSA_01
-- 0x0438A4AE,	--	A_F_Y_EastSA_02
-- 0x51C03FA4,	--	A_F_Y_EastSA_03
0xF9A6F53F,	--	A_M_M_EastSA_01
0x07DD91AC,	--	A_M_M_EastSA_02
0xA4471173,	--	A_M_Y_EastSA_01
0x168775F6	--	A_M_Y_EastSA_02
}

local cargo3peds = {
0xD768B228,	--	S_M_M_Security_01
0x95C76ECD,	--	S_M_M_Armoured_01
0x63858A4A	--	S_M_M_Armoured_02
}

local weapons = {
"WEAPON_PISTOL",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_ASSAULTSMG",
"WEAPON_ASSAULTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_STUNGUN",
-- "WEAPON_GRENADELAUNCHER",
-- "WEAPON_RPG",
"WEAPON_MINIGUN",
-- "WEAPON_GRENADE"
}

local modcols = {
{255,0,0},
{0,255,0},
{0,0,255},
{255,255,0},
{0,255,255},
{255,0,255},
{255,100,0},
{153, 255, 51},
{0, 255, 204},
{102, 0, 255},
{102, 0, 204},
{255, 51, 153},
{0, 204, 0}
}

local target = 0
local payment = 0
local pedslist = {}
local lscblip = 0
local waittime = 0
local stealtrigger = false
-- local jacktrigger = false

local function deletev()
	for _,v in ipairs(pedslist) do
		ENTITY.DELETE_ENTITY(v)
	end
	pedslist = {}
	
	VEHICLE.DELETE_VEHICLE(target)
	print('SZAT - deleted')
	target = 0;
	
end

local function spawnv(vtr)
		
		local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vtr,-1)
		
		local chance = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,101)
		if (driver == 0) then
			local chance = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,60)
		end
		
		
		local hash = 0
		local pedlist = {}
		
		local spawnpos = ENTITY.GET_ENTITY_COORDS(vtr, true)
		local lscdist = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(spawnpos.x,spawnpos.y,spawnpos.z, -374.5, -122.5, 38.5, true)
		
		local rich = false
		
		if (chance < 70) then --TODO ADJUST
			cdata = carslist[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#carslist+1)]
			hash = cdata[1]
			payment = cdata[2]
			if(chance > 40) then
				pedlist = carspeds
				rich = true
			else
				pedlist = cargospeds
			end
		elseif (chance < 85) then
			hash = cargo1list[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#cargo1list+1)]
			payment = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(50000,300000) + (lscdist*10)
			pedlist = cargospeds
		elseif (chance < 95) then
			hash = cargo2list[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#cargo2list+1)]
			payment = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(300000,2000000) + (lscdist*50)
			pedlist = cargospeds
		else
			hash = cargo3list[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#cargo3list+1)]
			payment = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(2000000,5000000) + (lscdist*100)
			pedlist = cargo3peds
		end
		
		payment = math.floor(payment)
		
		
		if (STREAMING.IS_MODEL_IN_CDIMAGE(hash) and STREAMING.IS_MODEL_A_VEHICLE(hash)) then
		
			STREAMING.REQUEST_MODEL(hash)
			
			stealtrigger = true;
			-- jacktrigger = true
			
			while (not STREAMING.HAS_MODEL_LOADED(hash)) do
				wait(0)
			end
			
			local vheading = ENTITY.GET_ENTITY_HEADING(vtr)
			
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vtr, true, true)
			VEHICLE.DELETE_VEHICLE(vtr)
			
			newv = VEHICLE.CREATE_VEHICLE(hash, spawnpos.x,spawnpos.y,spawnpos.z, vheading, true, true)
			
			if (chance < 60) then
				--mod the v
				local cols = modcols[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#modcols+1)]
				VEHICLE.SET_VEHICLE_MOD_KIT(newv, 0)
				
				local pc = GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,100)
				
				local paint = 0
				if (pc < 5) then
					paint = 5
				elseif (pc < 30) then
					paint = 3
				end
				
				VEHICLE.SET_VEHICLE_MOD_COLOR_1(newv, paint, 0, 0)
				VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(newv,cols[1],cols[2],cols[3])
				VEHICLE.SET_VEHICLE_EXTRA_COLOURS(newv, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,75), GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,41))
				VEHICLE.TOGGLE_VEHICLE_MOD(newv, 18, true)
				VEHICLE.SET_VEHICLE_WHEEL_TYPE(newv, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,7))
				VEHICLE.SET_VEHICLE_WINDOW_TINT(newv, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,6))
				VEHICLE.SET_VEHICLE_MOD(newv, 0, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 1, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 2, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 3, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 4, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 5, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 6, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 7, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 8, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 9, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 10, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,2), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 11, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,4), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 12, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,3), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 13, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,3), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 14, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,15), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 15, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,4), false)
				VEHICLE.SET_VEHICLE_MOD(newv, 23, GAMEPLAY.GET_RANDOM_INT_IN_RANGE(0,20), true)
			end
			
			if (driver ~= 0) then
				local numtogen = 1 --TODO set to 1 and make peds attack when v is hijacked
				if (rich) then
					numtogen = 0
				end
				
				-- PED.CREATE_GROUP(167)
				for i = 0, numtogen, 1 do
					pedhash = pedlist[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#pedlist+1)]
					
					STREAMING.REQUEST_MODEL(pedhash)
					while(not STREAMING.HAS_MODEL_LOADED(pedhash)) do
						wait(0)
					end
					local newped = PED.CREATE_PED( 0,pedhash,spawnpos.x,spawnpos.y,spawnpos.z,1,false,true)
					table.insert(pedslist, newped)
					-- PED.SET_PED_COMBAT_ATTRIBUTES(newped, 100, true)
					-- PED.SET_PED_COMBAT_ABILITY(newped, 100)
					-- AI.TASK_COMBAT_PED(newped, PLAYER.PLAYER_PED_ID(), 1, 1)
					-- PED.SET_PED_AS_ENEMY(newped, true)
					-- PED.SET_PED_STAY_IN_VEHICLE_WHEN_JACKED(newped, false)
					PED.SET_PED_AS_COP(newped, true)
					PED.SET_PED_CAN_SWITCH_WEAPON(newped,true)
					if (not rich) then
						WEAPON.GIVE_WEAPON_TO_PED(newped, GAMEPLAY.GET_HASH_KEY(weapons[GAMEPLAY.GET_RANDOM_INT_IN_RANGE(1,#weapons+1)]),1000,true,true)
					end
					-- PED.SET_PED_DIES_WHEN_INJURED(newped, false)
					-- PED.SET_PED_MAX_HEALTH(newped, 1000)
					-- PED.SET_PED_ARMOUR(newped, 1000)
					
					PED.SET_PED_INTO_VEHICLE(newped, newv, i-1)
					if (i==0) then
						--AI.TASK_VEHICLE_DRIVE_WANDER(newped, newv, 3, 2)
						AI.TASK_VEHICLE_DRIVE_WANDER(newped, newv, 30, 3)
					end
					
					-- PED.SET_PED_AS_GROUP_MEMBER(newped, 167)
					-- PED.SET_PED_RELATIONSHIP_GROUP_HASH(newped, GAMEPLAY.GET_HASH_KEY(""))
					
					STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedhash)
				end
			else
				VEHICLE.SET_VEHICLE_NEEDS_TO_BE_HOTWIRED(newv, true)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(newv,0)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(newv,1)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(newv,true)
				VEHICLE.SET_VEHICLE_ALARM(newv, true)
			end
			
			
			VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(newv)
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(newv, true, true)
			
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			
			ENTITY.SET_ENTITY_AS_MISSION_ENTITY(newv, true, true)
			local blip = UI.ADD_BLIP_FOR_ENTITY(newv)
			--UI.SET_BLIP_SCALE(blip, 1.6)
			UI.SET_BLIP_COLOUR(blip, 0xFF00DDFF)
			
			if (chance < 70) then
				showtext5("There's a VALUABLE CAR nearby you can sell. It's marked on your GPS.\nPayment: $"..tostring(payment))
			else
				showtext5("There's a CARGO VEHICLE nearby you can sell. It's marked on your GPS.\nPayment: $"..tostring(payment))
			end
			
			return newv
		
		end

end

function szaboautotheft.unload() end
function szaboautotheft.init()

end

local lastplayerinv = false
local routerefresh = 0
local searchangle = 0

function szaboautotheft.tick()
	-- dump pos = -374.5, -122.5, 38.5
	
	if (texttimer > 0) then
		drawtext5()
	end
	
	local playerPed = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(playerPed)
	-- local playerID = PLAYER.PLAYER_ID()
	local playerPos = ENTITY.GET_ENTITY_COORDS(playerPed, true)
	
	local stars = PLAYER.GET_PLAYER_WANTED_LEVEL(player)
	
	-- print(stars)
	
	if (target == 0) then
	
		if (lscblip ~= 0) then
			UI.REMOVE_BLIP(lscblip)
		end
		
		
		local disttolsc = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(playerPos.x, playerPos.y, playerPos.z, -374.5, -122.5, 38.5, true)
		local searchradius = szclamp((disttolsc*0.003), 4, 20) --TODO FINE-TUNE THIS SH*T
		
		-- print (disttolsc,searchradius)
		
		searchangle = searchangle + 0.01
		if (searchangle > 2) then
			searchangle = 0
		end
		local searchdist = 180
		local searchpos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(playerPed, math.sin(searchangle*math.pi)*searchdist, math.cos(searchangle*math.pi)*searchdist, math.sin(searchangle*4*math.pi)*(searchdist*0.6))
		local rv = VEHICLE.GET_RANDOM_VEHICLE_IN_SPHERE(searchpos.x, searchpos.y, searchpos.z, searchradius, 0, 0)
	
		-- rv = VEHICLE.GET_CLOSEST_VEHICLE(playerPos.x, playerPos.y, playerPos.z, 5, 0, 70)
		
		--																				800
		if (not VEHICLE.IS_THIS_MODEL_A_CAR(ENTITY.GET_ENTITY_MODEL(rv)) or disttolsc < 500) then
			rv = 0
		end
		
		if (rv ~= 0 and stars == 0) then
		
			-- local t = ENTITY.GET_ENTITY_COORDS(rv, true)
			-- local disttolsc = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(t.x, t.y, t.z, -374.5, -122.5, 38.5, true)
			
			-- print('CAR FOUND, dtlsc',disttolsc)
			
			local rvpos = ENTITY.GET_ENTITY_COORDS(rv, true)
			-- local dist = GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(playerPos.x, playerPos.y, playerPos.z, rvpos.x, rvpos.y, rvpos.z, true)
			
			-- print('dtp',dist)
			
			-- if (dist > 150 and dist < 250) then
			--if (dist > 1 and dist < 20) then
				
			if (UI.GET_BLIP_FROM_ENTITY(rv) == 0) then
				
				target = spawnv(rv)
				waittime = 1500

			end
			-- end

		end
	
	else
		local t = ENTITY.GET_ENTITY_COORDS(target, true)
		
		local playerinv = PED.IS_PED_IN_VEHICLE(playerPed, target, true)
		
		if (playerinv and not lastplayerinv) then
			nblip = UI.ADD_BLIP_FOR_COORD(-374.5, -122.5, 38.5)
			UI.SET_BLIP_COLOUR(nblip, 0x00FF00FF)
			lscblip = nblip
			print('added route blip')
		end
		lastplayerinv = playerinv
		
		if (playerinv and routerefresh > 100) then
			UI.SET_BLIP_ROUTE(lscblip, true)
			UI.SET_BLIP_ROUTE_COLOUR(lscblip, 0x00FF00FF)
			routerefresh = 0
			-- print('refreshing route')
		end
		routerefresh = routerefresh+1
		
		if (playerinv and stealtrigger) then
			stealtrigger = false
			playerID = PLAYER.PLAYER_ID()
			if (stars < 2) then
				PLAYER.SET_PLAYER_WANTED_LEVEL(playerID, 2, false)
				PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(playerID, false)
			end
		end
		
		-- NO WAY TO MAKE THIS WORK
		-- if (jacktrigger and not playerinv) then
			-- jacktrigger = false
			-- local ped1 = VEHICLE.GET_PED_IN_VEHICLE_SEAT(target, -1)
			-- local ped2 = VEHICLE.GET_PED_IN_VEHICLE_SEAT(target, -1)
			-- if(PED.IS_PED_BEING_JACKED(ped1) or PED.IS_PED_BEING_JACKED(ped2)) then
				-- AI.TASK_LEAVE_VEHICLE(ped1, target, 4096) --4096
				-- AI.TASK_COMBAT_PED(ped1, PLAYER.PLAYER_PED_ID(), 1, 1)
				-- AI.TASK_LEAVE_VEHICLE(ped2, target, 4096)
				-- AI.TASK_COMBAT_PED(ped2, PLAYER.PLAYER_PED_ID(), 1, 1)
			-- end
		-- end
		
		-- print(VEHICLE.GET_VEHICLE_ENGINE_HEALTH(target))
		
		if(VEHICLE.GET_VEHICLE_ENGINE_HEALTH(target) < 600) then
			target = 0
			payment = 0
			while (UI.GET_BLIP_FROM_ENTITY(target) ~= 0) do
				UI.REMOVE_BLIP(UI.GET_BLIP_FROM_ENTITY(target))
				wait(0)
			end
			ENTITY.SET_VEHICLE_AS_NO_LONGER_NEEDED(target)
			showtext5("This vehicle is too damaged to sell")
		end
		
		if (waittime > 0) then
			waittime = waittime-1
		end
		print(waittime)
		
		--																										300	or not ENTITY.DOES_ENTITY_EXIST(target)
		if (GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(playerPos.x, playerPos.y, playerPos.z, t.x, t.y, t.z, true	) > 300 and waittime<=0) then
			deletev()
			showtext5("The vehicle was lost")
		elseif (GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS(t.x, t.y, t.z, -374.5, -122.5, 38.5, true) < 30 and stars == 0) then
			if (playerinv) then
				texttoshow = "Leave the vehicle"
				drawtext5()
			else
				deletev()
				addmoneytoplayer(payment)
				payment = 0
				showtext5("Thanks for your business")
			end
		end
	end
	
end

return szaboautotheft




























