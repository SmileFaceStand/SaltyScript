--[[
Script created by (=#1000

Credits:
Nowiry for the Tall Cage
Lua Retards for helping me
Lua Masters for helping me
]]
util.require_natives(1651208000)
util.keep_running()
util.toast("Welcome to SmileScript. Hope you'll enjoy! :)")

--########################################################

  ---------------------| Variables |---------------------

--########################################################

local my_player_id = players.user()

local local_settings = {
    forcefield = false,
    forcefield_range = 20,
    forcefield_range_blur = true,
    forcefield_multiplier = 0.5,
    forcefield_type = 0,
    forcefield_ign_vehs = false,
    forcefield_ign_peds = false,
    forcefield_ign_objs = false,
    forcefield_ign_pickups = true,
    forcefield_ign_personal_vehs = true,
    forcefield_ign_players = true,
    clr_world_vehs = true,
    clr_world_peds = true,
    clr_world_objs = true,
    clr_world_pickups = true,
    clr_world_ign_personal_vehs = true
}

local forcefield_types = {
    [0] = {"Push"},
    [1] = {"Pull"}
}

local net_settings = {}

local exp_types = {
    [0] = {"Grenade"},
    [1] = {"Grenade Launcher"},
    [2] = {"Stickybomb"},
    [3] = {"Molotov"},
    [4] = {"Rocket"},
    [5] = {"Tankshell"},
    [6] = {"Hi Octane"},
    [7] = {"Car"},
    [8] = {"Plane"},
    [9] = {"Petrol Pump"},
    [10] = {"Bike"},
    [11] = {"Steam"},
    [12] = {"Flame"},
    [13] = {"Water Hydrant"},
    [14] = {"Gas Canister"},
    [15] = {"Boat"},
    [16] = {"Ship"},
    [17] = {"Truck"},
    [18] = {"Bullet"},
    [19] = {"Smoke Grenade Launcher"},
    [20] = {"Smoke Grenade"},
    [21] = {"BZ Gas"},
    [22] = {"Flare"},
    [23] = {"Gas Canister"},
    [24] = {"Extinguisher"},
    [25] = {"Programmable AR"},
    [26] = {"Train"},
    [27] = {"Barrel"},
    [28] = {"Propane"},
    [29] = {"Blimp"},
    [30] = {"Flame Explode"},
    [31] = {"Tanker"},
    [32] = {"Plane Rocket"},
    [33] = {"Vehicle Bullet"},
    [34] = {"Gas Tank"},
    [36] = {"Railgun"},
    [37] = {"Blimp 2"},
    [38] = {"Firework"},
    [39] = {"Snowball"},
    [40] = {"Proximity Mine"},
    [41] = {"Valkyrie Cannon"},
    [42] = {"Air Defence"},
    [43] = {"Pipe Bomb"},
    [44] = {"Vehicle Mine"},
    [45] = {"Explosive Ammo"},
    [46] = {"APC Shell"},
    [47] = {"Cluster Bomb"},
    [48] = {"Gas Bomb"},
    [49] = {"Incendiary Bomb"},
    [50] = {"Standard Bomb"},
    [51] = {"Torpedo"},
    [52] = {"Underwater Torpedo"},
    [53] = {"Bombushka Cannon"},
    [54] = {"Cluster Bomb 2"},
    [55] = {"Hunter Barrage"},
    [56] = {"Hunter Cannon"},
    [57] = {"Rogue Cannon"},
    [58] = {"Underwater Mine"},
    [59] = {"Orbital Cannon"},
    [60] = {"Bomb Standard Wide"},
    [61] = {"Explosive Shotgun Ammo"},
    [62] = {"Oppressor MKII Cannon"},
    [63] = {"Mortar Kinetic"},
    [64] = {"Kinetic Mine"},
    [65] = {"EMP Mine"},
    [66] = {"Spike Mine"},
    [67] = {"Slick Mine"},
    [68] = {"Tar Mine"},
    [69] = {"Drone"},
    [70] = {"Up-n-Atomizer"},
    [71] = {"Buried Mine"},
    [72] = {"Missile"},
    [73] = {"RC Tank Rocket"},
    [74] = {"Water Bomb"},
    [75] = {"Water Bomb 2"},
    [78] = {"Flash Grenade"},
    [79] = {"Stun Grenade"},
    [81] = {"Large Missile"},
    [82] = {"Big Submarine"},
    [83] = {"EMP Launcher"}
}

local cage_types = {
    [0] = {
        "Standard Cage",
        objs = {
            {
                name = "prop_gold_cont_01",
                ofst = v3.new(0, 0, 0),
                rot = v3.new(0, 0, 0)
            }
        },
        max_dist = 2
    },
    [1] = {
        "Tall Cage",
        objs = {
            {
                name = "prop_rub_cage01a",
                ofst = v3.new(0, 0, -1),
                rot = v3.new(0, 0, 0)
            },
            {
                name = "prop_rub_cage01a",
                ofst = v3.new(0, 0, 1.2),
                rot = v3.new(-180, 0, 90)
            }
        },
        max_dist = 1.5
    },
    [2] = {
        "Box Cage",
        objs = {
            {
                name = "prop_ld_crate_01",
                ofst = v3.new(0, 0, 0),
                rot = v3.new(-180, 90, 0)
            },
            {
                name = "prop_ld_crate_01",
                ofst = v3.new(0, 0, 0),
                rot = v3.new(0, 90, 0)
            }
        },
        max_dist = 1.5
    },
    [3] = {
        "Pipe Cage",
        objs = {
            {
                name = "prop_pipes_conc_01",
                ofst = v3.new(0, 0, 0),
                rot = v3.new(90, 0, 0)
            }
        },
        max_dist = 1.5
    },
    [4] = {
        "Stunt Tube Cage",
        objs = {
            {
                name = "stt_prop_stunt_tube_end",
                ofst = v3.new(0, 0, 0),
                rot = v3.new(0, -90, 0)
            }
        },
        max_dist = 13
    }
}

local ent_types = {
    --Spent 1 fucking day scrolling and spawning objects, if someone uses this, give credits pls
    [0] = {"Cone", name = "prop_mp_cone_01"},
    [1] = {"Pole", name = "prop_roadpole_01b"},
    [2] = {"Barrier", name = "prop_barrier_work06a"},
    [4] = {"Water Barrier", name = "prop_barrier_wat_03b"},
    [5] = {"Log", name = "prop_log_01"},
    [8] = {"Pipe", name = "prop_pipes_conc_01"},
    [9] = {"Pizza", name = "prop_pizza_box_02"},
    [10] = {"Burger", name = "prop_cs_burger_01"},
    [11] = {"Fries", name = "prop_food_chips"},
    [12] = {"Coke", name = "ng_proc_sodacan_01a"},
    [13] = {"Beer", name = "prop_amb_beer_bottle"},
    [14] = {"Glass", name = "prop_cs_shot_glass"},
    [15] = {"Coffee", name = "p_amb_cofeecup_01"},
    [16] = {"Panties", name = "p_cs_panties_03_s"},
    [17] = {"Dildo", name = "prop_cs_dildo_01"},
    [18] = {"Teddy Bear", name = "prop_mr_rasberryclean"},
    [19] = {"Fridge", name = "prop_fridge_01"},
    [20] = {"Washer", name = "prop_washer_02"},
    [21] = {"Television", name = "prop_tv_04"},
    [22] = {"Laptop", name = "bkr_prop_clubhouse_laptop_01a"},
    [23] = {"Tablet", name = "hei_prop_dlc_tablet"},
    [24] = {"Phone", name = "prop_phone_ing"},
    [25] = {"Money", name = "bkr_prop_money_wrapped_01"},
    [26] = {"Gold Bar", name = "ch_prop_gold_bar_01a"},
    [27] = {"Security Case", name = "prop_security_case_01"},
    [28] = {"Bomb", name = "w_smug_bomb_01"},
    [29] = {"Dummy", name = "prop_dummy_01"},
    [30] = {"Coffin", name = "prop_coffin_02b"},
    [31] = {"Death Body", name = "prop_water_corpse_02"},
    [32] = {"Umbrella", name = "p_amb_brolly_01_s"},
    [33] = {"Guitar", name = "prop_acc_guitar_01"},
    [34] = {"Ferris Wheel", name = "prop_ld_ferris_wheel"},
    [35] = {"Asteroid", name = "prop_asteroid_01"},
    [36] = {"Trash Bag", name = "p_binbag_01_s"},
    [37] = {"Bin", name = "prop_bin_08a"},
    [38] = {"Wheelchair", name = "prop_wheelchair_01"},
    [39] = {"Alien Egg", name = "prop_alien_egg_01"},
    [40] = {"Beachball", name = "prop_beachball_01"},
    [41] = {"Golfball", name = "prop_golf_ball"},
    [42] = {"Big Soccerball", name = "stt_prop_stunt_soccer_ball"}
}

--#################################################

  ------------------| Functions |------------------

--#################################################

local alarm = false

local function start_alarm(alarm_time)
    local time = 0
    alarm = false
    util.create_tick_handler(function()
        if time >= alarm_time then
            alarm = true
            return false
        else
            time += MISC.GET_FRAME_TIME()
        end
    end)
end

local function get_alarm()
    return alarm
end

local function get_hud_colour()
    local red = menu.get_value(menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Red"))
    local green = menu.get_value(menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Green"))
    local blue = menu.get_value(menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Blue"))
    local alpha = menu.get_value(menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Opacity"))
    return red, green, blue, alpha
end

local function request_model(model)
    STREAMING.REQUEST_MODEL(model)
    while not STREAMING.HAS_MODEL_LOADED(model) do
        util.yield(1)
    end
end

local function request_ptfx_asset(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield(1)
    end
end

local function wait_session_transition()
    while not util.is_session_transition_active() do
        util.yield(250)
    end
end

local function wait_player_revive(player_id)
    while PLAYER.IS_PLAYER_DEAD(player_id) do
        util.yield(100)
    end
end

local function kick_player_out_of_veh(player_id)
    local ped_id = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
    local failed = false
    if PED.IS_PED_IN_ANY_VEHICLE(ped_id, false) then
        menu.trigger_commands("vehkick" .. players.get_name(player_id))
        start_alarm(2.5)
        while PED.IS_PED_IN_ANY_VEHICLE(ped_id, false) do
            if get_alarm() then
                failed = true
                break
            end
            util.yield(10)
        end
    end
    return failed
end

local function set_ent_toward_ent(ent, tgt)
	local ent_pos = ENTITY.GET_ENTITY_COORDS(ent, false)
	local tgt_pos = ENTITY.GET_ENTITY_COORDS(tgt, false)
	local ent_rot = v3.toRot(v3.sub(ent_pos, tgt_pos))
	ENTITY.SET_ENTITY_HEADING(ent, ent_rot.z)
end

local function get_vehs_in_range(pos, range, exclude_personal_vehs)
    local vehs = {}
    for i, veh in pairs(entities.get_all_vehicles_as_handles()) do
        if exclude_personal_vehs then
            if not entities.get_vehicle_has_been_owned_by_player(entities.handle_to_pointer(veh)) then
                if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(veh, false)) <= range then
                    table.insert(vehs, veh)
                end
            end
        else
            if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(veh, false)) <= range then
                table.insert(vehs, veh)
            end
        end
    end
    return vehs
end

local function get_peds_in_range(pos, range, exclude_player_peds)
    local peds = {}
    for i, ped in pairs(entities.get_all_peds_as_handles()) do
        if exclude_player_peds then
            if not PED.IS_PED_A_PLAYER(ped) then
                if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(ped, false)) <= range then
                    table.insert(peds, ped)
                end
            end
        else
            if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(ped, false)) <= range then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

local function get_objs_in_range(pos, range)
    local objs = {}
    for i, obj in pairs(entities.get_all_objects_as_handles()) do
        if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(obj, false)) <= range then
            table.insert(objs, obj)
        end
    end
    return objs
end

local function get_pickups_in_range(pos, range)
    local pickups = {}
    for i, pickup in pairs(entities.get_all_objects_as_handles()) do
        if v3.distance(pos, ENTITY.GET_ENTITY_COORDS(pickup, false)) <= range then
            table.insert(pickups, pickup)
        end
    end
    return pickups
end

--########################################################

  --------------| Local Features Generator |--------------

--########################################################

local self_local_root = menu.list(menu.my_root(), "Self")
menu.divider(self_local_root, "Self")
local world_local_root = menu.list(menu.my_root(), "World")
menu.divider(world_local_root, "World")

------------------------------
-- Self Section
------------------------------

------------------------------
-- Weapons Menu
------------------------------

local wpns_local_root = menu.list(self_local_root, "Weapons")
menu.divider(wpns_local_root, "Weapons")

menu.toggle(
    wpns_local_root,
    "Autoload Weapons",
    {"autoloadweapons"},
    "Autoload all the weapons everytime you join a new session.",
    function(state)
        if state then
            players.on_join(
                function(player_id)
                    if player_id == my_player_id then
                        wait_session_transition()
                        menu.trigger_commands("allweapons")
                        util.toast("Weapons loaded successfully. :)")
                    end
                end
            )
        end
    end
)

------------------------------
-- Forcefield Menu
------------------------------

local forcefield_local_root = menu.list(self_local_root, "Forcefield")
menu.divider(forcefield_local_root, "Forcefield")

menu.toggle(
    forcefield_local_root,
    "Forcefield",
    {"selfforcefield"},
    "",
    function(state)
        local_settings.forcefield = state
        if state then
            util.toast("Forcefield enabled successfully. :)")
            while local_settings.forcefield do
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(my_player_id)
                local player_pos = players.get_position(my_player_id)
                local entities = {}
                if not local_settings.forcefield_ign_vehs then
                    local vehs = get_vehs_in_range(
                        player_pos,
                        local_settings.forcefield_range,
                        local_settings.forcefield_ign_personal_vehs
                    )
                    for i = 1, #vehs do
                        table.insert(entities, vehs[i])
                    end
                end
                if not local_settings.forcefield_ign_peds then
                    local peds = get_peds_in_range(
                        player_pos,
                        local_settings.forcefield_range,
                        local_settings.forcefield_ign_players
                    )
                    for i = 1, #peds do
                        table.insert(entities, peds[i])
                    end
                end
                if not local_settings.forcefield_ign_objs then
                    local objs = get_objs_in_range(
                        player_pos,
                        local_settings.forcefield_range
                    )
                    for i = 1, #objs do
                        table.insert(entities, objs[i])
                    end
                end
                if not local_settings.forcefield_ign_pickups then
                    local pickups = get_pickups_in_range(
                        player_pos,
                        local_settings.forcefield_range
                    )
                    for i = 1, #pickups do
                        table.insert(entities, pickups[i])
                    end
                end
                for i, ent in pairs(entities) do
                    if PED.GET_VEHICLE_PED_IS_IN(player_ped, false) ~= ent and
                    player_ped ~= ent and
                    not OBJECT.HAS_OBJECT_BEEN_BROKEN(ent) and
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent) then
                        local force = ENTITY.GET_ENTITY_COORDS(ent)
                        v3.sub(force, player_pos)
                        v3.mul(force, local_settings.forcefield_multiplier)
                        v3.normalise(force)
                        if local_settings.forcefield_type == 1 then
                            v3.mul(force, -1)
                        end
                        if ENTITY.IS_ENTITY_A_PED(ent) then
                            PED.SET_PED_TO_RAGDOLL(
                                ent,
                                500,
                                0,
                                0,
                                false,
                                false,
                                false
                            )
                        end
                        ENTITY.APPLY_FORCE_TO_ENTITY(
                            ent,
                            3,
                            force.x,
                            force.y,
                            force.z,
                            0,
                            0,
                            0.5,
                            0,
                            false,
                            false,
                            true
                        )
                    end
                end
                util.yield(10)
            end
        else
            util.toast("Forcefield disabled successfully. :)")
        end
    end
)

local forcefield_range_cmd_local = menu.slider(
    forcefield_local_root,
    "Forcefield Range",
    {"forcefieldrange"},
    "",
    5,
    100,
    20,
    5,
    function(value)
        local_settings.forcefield_range = value
    end
)

menu.on_focus(forcefield_range_cmd_local, function()
    local_settings.forcefield_range_blur = false
    local red, green, blue = get_hud_colour()
    util.create_tick_handler(function()
        if local_settings.forcefield_range_blur then
            return false
        end
        local player_pos = players.get_position(my_player_id)
        GRAPHICS._DRAW_SPHERE(
            player_pos.x,
            player_pos.y,
            player_pos.z,
            local_settings.forcefield_range,
            red,
            green,
            blue,
            0.25
        )
    end)
end)

menu.on_blur(forcefield_range_cmd_local, function()
    local_settings.forcefield_range_blur = true
end)

menu.slider(
    forcefield_local_root,
    "Forcefield Multiplier",
    {"forcefieldmultiplier"},
    "",
    1,
    10,
    1,
    1,
    function(value)
        local_settings.forcefield_multiplier = value * 0.5
    end
)

menu.list_select(
    forcefield_local_root,
    "Forcefield Type",
    {"forcefieldtype"},
    "",
    forcefield_types,
    0,
    function(value)
        local_settings.forcefield_type = value
    end
)

local forcefield_igns_local_root = menu.list(forcefield_local_root, "Forcefield Ignores")
menu.divider(forcefield_igns_local_root, "Forcefield Ignores")

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Vehicles",
    {"forcefieldnovehicles"},
    "",
    function(state)
        local_settings.forcefield_ign_vehs = state
    end
)

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Peds",
    {"forcefieldnopeds"},
    "",
    function(state)
        local_settings.forcefield_ign_peds = state
    end
)

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Objects",
    {"forcefieldnoobjects"},
    "",
    function(state)
        local_settings.forcefield_ign_objs = state
    end
)

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Pickups",
    {"forcefieldnopickups"},
    "",
    function(state)
        local_settings.forcefield_ign_pickups = state
    end,
    true
)

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Personal Vehicles",
    {"forcefieldnopersonalvehicles"},
    "",
    function(state)
        local_settings.forcefield_ign_personal_vehs = state
    end,
    true
)

menu.toggle(
    forcefield_igns_local_root,
    "Ignore Players",
    {"forcefieldnoplayers"},
    "",
    function(state)
        local_settings.forcefield_ign_players = state
    end,
    true
)

------------------------------
-- World Section
------------------------------

local clr_world_local_root = menu.list(world_local_root, "Clear World")
menu.divider(clr_world_local_root, "Clear World")

------------------------------
-- Clear World Menu
------------------------------

menu.action(
    clr_world_local_root,
    "Clear World",
    {"clearworld"},
    "",
    function()
        local count = 0
        if local_settings.clr_world_vehs then
            local exclude_personal_vehs = local_settings.clr_world_exclude_personal_vehs
            for i, veh in pairs(get_vehs_in_range(v3.new(0, 0, 0), 16000, exclude_personal_vehs)) do
                entities.delete_by_handle(veh)
                count += 1
            end
        end
        if local_settings.clr_world_peds then
            for i, ped in pairs(get_peds_in_range(v3.new(0, 0, 0), 16000, false)) do
                entities.delete_by_handle(ped)
                count += 1
            end
        end
        if local_settings.clr_world_objs then
            for i, obj in pairs(get_objs_in_range(v3.new(0, 0, 0), 16000)) do
                entities.delete_by_handle(obj)
                count += 1
            end
        end
        if local_settings.clr_world_pickups then
            for i, pickup in pairs(get_pickups_in_range(v3.new(0, 0, 0), 16000)) do
                entities.delete_by_handle(pickup)
                count += 1
            end
        end
        util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
    end
)

menu.toggle(
    clr_world_local_root,
    "Clear Vehicles",
    {"clearvehicles"},
    "",
    function(state)
        local_settings.clr_world_vehs = state
    end,
    true
)

menu.toggle(
    clr_world_local_root,
    "Clear Peds",
    {"clearpeds"},
    "",
    function(state)
        local_settings.clr_world_peds = state
    end,
    true
)

menu.toggle(
    clr_world_local_root,
    "Clear Objects",
    {"clearobjects"},
    "",
    function(state)
        local_settings.clr_world_objs = state
    end,
    true
)

menu.toggle(
    clr_world_local_root,
    "Clear Pickups",
    {"clearpickups"},
    "",
    function(state)
        local_settings.clr_world_pickups = state
    end,
    true
)

menu.toggle(
    clr_world_local_root,
    "Ignore Personal Vehicles",
    {"clearnopersonalvehicles"},
    "",
    function(state)
        local_settings.clr_world_ignore_personal_vehs = state
    end,
    true
)

--########################################################

  ---------------| Net Features Generator |---------------

--########################################################

players.on_join(
    function(player_id)
        net_settings[player_id] = {
            wanted_level = 0,
            exp_type = 0,
            exp_delay = 100,
            exp_shake = 1,
            exp_blamed = false,
            exp_audible = true,
            exp_visible = true,
            exp_damage = true,
            ptfx_ids = {},
            ptfx_power = 1,
            ptfx_size = 5,
            ptfx_asset = "core",
            ptfx_name = "exp_grd_grenade_smoke",
            ent_type = 0,
            ent_amount = 1,
            cage_ids = {},
            cage_failed = false,
            cage_automatic = false,
            cage_type = 0,
            cage_visible = true,
            forcefield = false,
            forcefield_range = 20,
            forcefield_range_blur = true,
            forcefield_multiplier = 0.5,
            forcefield_type = 0,
            forcefield_ign_vehs = false,
            forcefield_ign_peds = false,
            forcefield_ign_objs = false,
            forcefield_ign_pickups = true,
            forcefield_ign_personal_vehs = true,
            forcefield_ign_players = true,
        }

        if player_id == players.user() then
            my_player_id = player_id
        end

        menu.divider(menu.player_root(player_id), "SmileScript")
        local trolling_net_root = menu.list(menu.player_root(player_id), "Trolling")
        menu.divider(trolling_net_root, "Trolling")

        ------------------------------
        -- Trolling Section
        ------------------------------

        local explosions_net_root = menu.list(trolling_net_root, "Explosions")
        menu.divider(explosions_net_root, "Explosions")
        local particles_net_root = menu.list(trolling_net_root, "Particles")
        menu.divider(particles_net_root, "Particles")
        local entities_net_root = menu.list(trolling_net_root, "Entities")
        menu.divider(entities_net_root, "Entities")
        local cages_net_root = menu.list(trolling_net_root, "Cages")
        menu.divider(cages_net_root, "Cages")
        local forcefield_net_root = menu.list(trolling_net_root, "Forcefield")
        menu.divider(forcefield_net_root, "Forcefield")

        menu.click_slider(
            trolling_net_root,
            "Increase Wanted Level",
            {"wantedlevel"},
            "It may take a few seconds.",
            1,
            5,
            1,
            1,
            function(value)
                local player_info = memory.read_long(entities.handle_to_pointer(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)) + 0x10C8)
                if memory.read_uint(player_info + 0x0888) < value then
                    local failed = false
                    start_alarm(10)
                    while memory.read_uint(player_info + 0x0888) < value do
                        if get_alarm() then
                            failed = true
                            break
                        end
                        for i = 1, 46 do
                            PLAYER.REPORT_CRIME(player_id, i, value)
                        end
                        util.yield(50)
                    end
                    if failed then
                        util.toast("Failed to increase Wanted Level. :/")
                    else
                        util.toast("Wanted Level increased successfully. :)")
                    end
                else
                    util.toast("Wanted Level is already " .. memory.read_uint(player_info + 0x0888) .. ". :)")
                end
            end
        )

        ------------------------------
        -- Explosions Menu
        ------------------------------

        menu.action(
            explosions_net_root,
            "Explode",
            {"ssexplode"},
            "",
            function()
                local player_pos = players.get_position(player_id)
                if net_settings.exp_blamed then
                    FIRE.ADD_OWNED_EXPLOSION(
                        PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(my_player_id),
                        player_pos.x,
                        player_pos.y,
                        player_pos.z,
                        net_settings[player_id].exp_type,
                        1,
                        net_settings[player_id].exp_audible,
                        not net_settings[player_id].exp_visible,
                        net_settings[player_id].exp_shake
                    )
                else
                    FIRE.ADD_EXPLOSION(
                        player_pos.x,
                        player_pos.y,
                        player_pos.z,
                        net_settings[player_id].exp_type,
                        1,
                        net_settings[player_id].exp_audible,
                        not net_settings[player_id].exp_visible,
                        net_settings[player_id].exp_shake,
                        not net_settings[player_id].exp_damage
                    )
                end
            end
        )

        menu.toggle_loop(
            explosions_net_root,
            "Explode Loop",
            {"explodeloop"},
            "",
            function()
                local player_pos = players.get_position(player_id)
                if net_settings.exp_blamed then
                    FIRE.ADD_OWNED_EXPLOSION(
                        PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(my_player_id),
                        player_pos.x,
                        player_pos.y,
                        player_pos.z,
                        net_settings[player_id].exp_type,
                        1,
                        net_settings[player_id].exp_audible,
                        not net_settings[player_id].exp_visible,
                        net_settings[player_id].exp_shake
                    )
                else
                    FIRE.ADD_EXPLOSION(
                        player_pos.x,
                        player_pos.y,
                        player_pos.z,
                        net_settings[player_id].exp_type,
                        1,
                        net_settings[player_id].exp_audible,
                        not net_settings[player_id].exp_visible,
                        net_settings[player_id].exp_shake,
                        not net_settings[player_id].exp_damage
                    )
                end

                util.yield(net_settings[player_id].exp_delay)
            end
        )

        menu.list_select(
            explosions_net_root,
            "Explosion Type",
            {"explosiontype"},
            "",
            exp_types,
            0,
            function(value)
                net_settings[player_id].exp_type = value
            end
        )

        local explosion_other_net_root = menu.list(explosions_net_root, "Other Settings")
        menu.divider(explosion_other_net_root, "Other Settings")

        menu.slider(
            explosion_other_net_root,
            "Explosion Delay",
            {"explosiondelay"},
            "",
            50,
            1000,
            250,
            10,
            function(value)
                net_settings[player_id].exp_delay = value
            end
        )

        menu.slider(
            explosion_other_net_root,
            "Explosion Shake",
            {"explosionshake"},
            "",
            0,
            100,
            1,
            1,
            function(value)
                net_settings[player_id].exp_shake = value
            end
        )

        menu.toggle(
            explosion_other_net_root,
            "Explosion Blamed",
            {"explosionblamed"},
            "",
            function(state)
                net_settings[player_id].exp_blamed = state
            end
        )

        menu.toggle(
            explosion_other_net_root,
            "Explosion Audible",
            {"explosionaudible"},
            "",
            function(state)
                net_settings[player_id].exp_audible = state
            end,
            true
        )

        menu.toggle(
            explosion_other_net_root,
            "Explosion Visible",
            {"explosionvisible"},
            "",
            function(state)
                net_settings[player_id].exp_visible = state
            end,
            true
        )

        menu.toggle(
            explosion_other_net_root,
            "Explosion Damage",
            {"explosiondamage"},
            "If Explosion Blamed is on, turning this off won't have any effect.",
            function(state)
                net_settings[player_id].exp_damage = state
            end,
            true
        )

        ------------------------------
        -- Particles Menu
        ------------------------------

        menu.toggle(
            particles_net_root,
            "Start PTFX",
            {"ptfx"},
            "",
            function(state)
                if state then
                    request_ptfx_asset(net_settings[player_id].ptfx_asset)
                    for i = 1, net_settings[player_id].ptfx_power, 1 do
                        GRAPHICS.USE_PARTICLE_FX_ASSET(net_settings[player_id].ptfx_asset)
                        table.insert(
                            net_settings[player_id].ptfx_ids,
                            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                                net_settings[player_id].ptfx_name,
                                PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id),
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                net_settings[player_id].ptfx_size,
                                false,
                                false,
                                false
                            )
                        )
                    end
                    util.toast("PTFX started successfully. :)")
                    while state do
                        if PLAYER.IS_PLAYER_DEAD(net_settings[player_id].ptfx_power) then
                            wait_player_revive(player_id)
                            for i, ptfx_id in pairs(net_settings[player_id].ptfx_ids) do
                                GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
                            end
                            for i = 1, net_settings[player_id].ptfx_power, 1 do
                                GRAPHICS.USE_PARTICLE_FX_ASSET(net_settings[player_id].ptfx_asset)
                                table.insert(
                                    net_settings[player_id].ptfx_ids,
                                    GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                                        net_settings[player_id].ptfx_name,
                                        PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id),
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        net_settings[player_id].ptfx_size,
                                        false,
                                        false,
                                        false
                                    )
                                )
                            end
                        else
                            util.yield(250)
                        end
                    end
                else
                    for i, ptfx_id in pairs(net_settings[player_id].ptfx_ids) do
                        GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
                    end
                    util.toast("PTFX stopped successfully. :)")
                end
            end
        )

        menu.slider(
            particles_net_root,
            "PTFX Amount",
            {"ptfxamount"},
            "",
            1,
            250,
            1,
            1,
            function(value)
                net_settings[player_id].ptfx_power = value
            end
        )

        menu.slider(
            particles_net_root,
            "PTFX Size",
            {"ptfxsize"},
            "",
            1,
            10,
            5,
            1,
            function(value)
                net_settings[player_id].ptfx_size = value
            end
        )

        local particles_other_player_root = menu.list(particles_net_root, "Other Settings")
        menu.divider(particles_other_player_root, "Other Settings")

        menu.text_input(
            particles_other_player_root,
            "PTFX Asset",
            {"ptfxasset"},
            "",
            function(value)
                net_settings[player_id].ptfx_asset = value
            end,
            "core"
        )

        menu.text_input(
            particles_other_player_root,
            "PTFX Name",
            {"ptfxname"},
            "",
            function(value)
                net_settings[player_id].ptfx_name = value
            end,
            "exp_grd_grenade_smoke"
        )

        menu.hyperlink(
            particles_other_player_root,
            "PTFX List",
            "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270",
            "List of all PTFX and assets."
        )

        ------------------------------
        -- Entities Menu
        ------------------------------

        menu.action(
            entities_net_root,
            "Spawn Entities",
            {"spamentities"},
            "",
            function()
                local ent_hash = util.joaat(ent_types[net_settings[player_id].ent_type].name)
                request_model(ent_hash)
                local player_pos = players.get_position(player_id)
                for i = 1, net_settings[player_id].ent_amount, 1 do
                    local random_ofst = v3.new(
                        math.random(-1, 1) * 0.25,
                        math.random(-1, 1) * 0.25,
                        math.random(-1, 1) * 0.25
                    )
                    local ent_pos = player_pos
                    v3.add(ent_pos, random_ofst)
                    OBJECT.CREATE_OBJECT_NO_OFFSET(
                        ent_hash,
                        ent_pos.x,
                        ent_pos.y,
                        ent_pos.z,
                        true,
                        false,
                        false
                    )
                end
                FIRE.ADD_EXPLOSION(
                    player_pos.x,
                    player_pos.y,
                    player_pos.z,
                    18,
                    1,
                    false,
                    true,
                    0,
                    true
                )
                util.toast("Entities spawned successfully. :)")
            end
        )

        menu.slider(
            entities_net_root,
            "Entity Amount",
            {"entitiesamount"},
            "",
            1,
            50,
            1,
            1,
            function(value)
                net_settings[player_id].ent_amount = value
            end
        )

        menu.list_select(
            entities_net_root,
            "Entity Type",
            {"entitytype"},
            "",
            ent_types,
            0,
            function(value)
                net_settings[player_id].ent_type = value
            end
        )

        ------------------------------
        -- Cages Menu
        ------------------------------

        menu.toggle(
            cages_net_root,
            "Cage",
            {"cage"},
            "",
            function(state)
                if state then
                    net_settings[player_id].cage_failed = false
                    for i, cage_object in ipairs(cage_types[net_settings[player_id].cage_type].objs) do
                        local cage_hash = util.joaat(cage_object.name)
                        request_model(cage_hash)
                        if kick_player_out_of_veh(player_id) then
                            net_settings[player_id].cage_failed = true
                            break
                        end
                        local ent_pos = players.get_position(player_id)
                        v3.add(ent_pos, cage_object.ofst)
                        local cage_obj = entities.create_object(cage_hash, ent_pos)
                        table.insert(net_settings[player_id].cage_ids, cage_obj)
                        ENTITY.SET_ENTITY_ROTATION(cage_obj, cage_object.rot.x, cage_object.rot.y, cage_object.rot.z, 1, true)
                        ENTITY.FREEZE_ENTITY_POSITION(cage_obj, true)
                        ENTITY.SET_ENTITY_VISIBLE(cage_obj, net_settings[player_id].cage_visible, false)
                        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_hash)
                    end
                    if net_settings[player_id].cage_failed then
                        util.toast("Failed to cage the player. :/")
                        return
                    else
                        util.toast("Player caged successfully. :)")
                    end
                else
                    if not net_settings[player_id].cage_failed then
                        for i, cage_id in pairs(net_settings[player_id].cage_ids) do
                            entities.delete_by_handle(cage_id)
                        end

                        for cage_id in pairs(net_settings[player_id].cage_ids) do
                            net_settings[player_id].cage_ids[cage_id] = nil
                        end
                        util.toast("Player uncaged successfully. :)")
                    end
                end
            end
        )

        menu.toggle(
            cages_net_root,
            "Automatic Cage",
            {"automaticcage"},
            "Automatically re-cage the player if he leaves the cage.",
            function(state)
                net_settings[player_id].cage_automatic = state
                if state then
                    local first_player_pos
                    net_settings[player_id].cage_failed = false
                    for i, cage_object in ipairs(cage_types[net_settings[player_id].cage_type].objs) do
                        local cage_hash = util.joaat(cage_object.name)
                        request_model(cage_hash)
                        if kick_player_out_of_veh(player_id) then
                            net_settings[player_id].cage_failed = true
                            break
                        end
                        first_player_pos = players.get_position(player_id)
                        local ent_pos = players.get_position(player_id)
                        v3.add(ent_pos, cage_object.ofst)
                        local cage_obj = entities.create_object(cage_hash, ent_pos)
                        table.insert(net_settings[player_id].cage_ids, cage_obj)
                        ENTITY.SET_ENTITY_ROTATION(cage_obj, cage_object.rot.x, cage_object.rot.y, cage_object.rot.z, 1, true)
                        ENTITY.FREEZE_ENTITY_POSITION(cage_obj, true)
                        ENTITY.SET_ENTITY_VISIBLE(cage_obj, net_settings[player_id].cage_visible, false)
                        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_hash)
                    end
                    if net_settings[player_id].cage_failed then
                        util.toast("Failed to cage the player. :/")
                        return
                    else
                        util.toast("Player caged successfully. :)")
                    end
                    while net_settings[player_id].cage_automatic do
                        if v3.distance(first_player_pos, players.get_position(player_id)) >= cage_types[net_settings[player_id].cage_type].max_dist then
                            first_player_pos = players.get_position(player_id)
                            for i, cage_id in pairs(net_settings[player_id].cage_ids) do
                                entities.delete_by_handle(cage_id)
                            end
                            for cage_id in pairs(net_settings[player_id].cage_ids) do
                                net_settings[player_id].cage_ids[cage_id] = nil
                            end
                            for i, cage_object in ipairs(cage_types[net_settings[player_id].cage_type].objs) do
                                local cage_hash = util.joaat(cage_object.name)
                                request_model(cage_hash)
                                if kick_player_out_of_veh(player_id) then
                                    net_settings[player_id].cage_failed = true
                                    break
                                end
                                first_player_pos = players.get_position(player_id)
                                local ent_pos = players.get_position(player_id)
                                v3.add(ent_pos, cage_object.ofst)
                                local cage_obj = entities.create_object(cage_hash, ent_pos)
                                table.insert(net_settings[player_id].cage_ids, cage_obj)
                                ENTITY.SET_ENTITY_ROTATION(cage_obj, cage_object.rot.x, cage_object.rot.y, cage_object.rot.z, 1, true)
                                ENTITY.FREEZE_ENTITY_POSITION(cage_obj, true)
                                ENTITY.SET_ENTITY_VISIBLE(cage_obj, net_settings[player_id].cage_visible, false)
                                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_hash)
                            end
                            if net_settings[player_id].cage_failed then
                                util.toast("Failed to re-cage the player. :/")
                                return
                            else
                                util.toast("Player re-caged successfully. :)")
                            end
                        end
                        util.yield(250)
                    end
                else
                    if not net_settings[player_id].cage_failed then
                        for i, cage_id in pairs(net_settings[player_id].cage_ids) do
                            entities.delete_by_handle(cage_id)
                        end
                        for cage_id in pairs(net_settings[player_id].cage_ids) do
                            net_settings[player_id].cage_ids[cage_id] = nil
                        end
                        util.toast("Player uncaged successfully. :)")
                    end
                end
            end
        )

        menu.list_select(
            cages_net_root,
            "Cage Type",
            {"cagetype"},
            "",
            cage_types,
            0,
            function(value)
                net_settings[player_id].cage_type = value
            end
        )

        menu.toggle(
            cages_net_root,
            "Cage Visible",
            {"cagevisible"},
            "",
            function(state)
                net_settings[player_id].cage_visible = state
            end,
            true
        )

        ------------------------------
        -- Forcefield Menu
        ------------------------------

        menu.toggle(
            forcefield_net_root,
            "Forcefield",
            {"netforcefield"},
            "",
            function(state)
                net_settings[player_id].forcefield = state
                if state then
                    util.toast("Forcefield enabled successfully. :)")
                    while net_settings[player_id].forcefield do
                        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                        local player_pos = players.get_position(player_id)
                        local entities = {}
                        if not net_settings[player_id].forcefield_ign_vehs then
                            local vehs = get_vehs_in_range(
                                player_pos,
                                net_settings[player_id].forcefield_range,
                                net_settings[player_id].forcefield_ign_personal_vehs
                            )
                            for i = 1, #vehs do
                                table.insert(entities, vehs[i])
                            end
                        end
                        if not net_settings[player_id].forcefield_ign_peds then
                            local peds = get_peds_in_range(
                                player_pos,
                                net_settings[player_id].forcefield_range,
                                net_settings[player_id].forcefield_ign_players
                            )
                            for i = 1, #peds do
                                table.insert(entities, peds[i])
                            end
                        end
                        if not net_settings[player_id].forcefield_ign_objs then
                            local objs = get_objs_in_range(
                                player_pos,
                                net_settings[player_id].forcefield_range
                            )
                            for i = 1, #objs do
                                table.insert(entities, objs[i])
                            end
                        end
                        if not net_settings[player_id].forcefield_ign_pickups then
                            local pickups = get_pickups_in_range(
                                player_pos,
                                net_settings[player_id].forcefield_range
                            )
                            for i = 1, #pickups do
                                table.insert(entities, pickups[i])
                            end
                        end
                        for i, ent in pairs(entities) do
                            if PED.GET_VEHICLE_PED_IS_IN(player_ped, false) ~= ent and
                            player_ped ~= ent and
                            OBJECT.HAS_OBJECT_BEEN_BROKEN(ent) and
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent) then
                                local force = ENTITY.GET_ENTITY_COORDS(ent)
                                v3.sub(force, player_pos)
                                v3.mul(force, net_settings[player_id].forcefield_multiplier)
                                v3.normalise(force)
                                if net_settings[player_id].forcefield_type == 1 then
                                    v3.mul(force, -1)
                                end
                                if ENTITY.IS_ENTITY_A_PED(ent) then
                                    PED.SET_PED_TO_RAGDOLL(
                                        ent,
                                        500,
                                        0,
                                        0,
                                        false,
                                        false,
                                        false
                                    )
                                end
                                ENTITY.APPLY_FORCE_TO_ENTITY(
                                    ent,
                                    3,
                                    force.x,
                                    force.y,
                                    force.z,
                                    0,
                                    0,
                                    0.5,
                                    0,
                                    false,
                                    false,
                                    true
                                )
                            end
                        end
                        util.yield(10)
                    end
                else
                    util.toast("Forcefield disabled successfully. :)")
                end
            end
        )

        local forcefield_range_cmd_players = menu.slider(
            forcefield_net_root,
            "Forcefield Range",
            {"netforcefieldrange"},
            "",
            5,
            100,
            20,
            5,
            function(value)
                net_settings[player_id].forcefield_range = value
            end
        )

        menu.on_focus(forcefield_range_cmd_players, function()
            net_settings[player_id].forcefield_range_blur = false
            local red, green, blue = get_hud_colour()
            util.create_tick_handler(function()
                if net_settings[player_id].forcefield_range_blur then
                    return false
                end
                local player_pos = players.get_position(player_id)
                GRAPHICS._DRAW_SPHERE(
                    player_pos.x,
                    player_pos.y,
                    player_pos.z,
                    net_settings[player_id].forcefield_range,
                    red,
                    green,
                    blue,
                    0.25
                )
            end)
        end)

        menu.on_blur(forcefield_range_cmd_players, function()
            net_settings[player_id].forcefield_range_blur = true
        end)

        menu.slider(
            forcefield_net_root,
            "Forcefield Multiplier",
            {"netforcefieldmultiplier"},
            "",
            1,
            10,
            1,
            1,
            function(value)
                net_settings[player_id].forcefield_multiplier = value * 0.5
            end
        )

        menu.list_select(
            forcefield_net_root,
            "Forcefield Type",
            {"netforcefieldtype"},
            "",
            forcefield_types,
            0,
            function(value)
                net_settings[player_id].forcefield_type = value
            end
        )

        local forcefield_igns_net_root = menu.list(forcefield_net_root, "Forcefield Ignores")
        menu.divider(forcefield_igns_net_root, "Forcefield Ignores")

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Vehicles",
            {"netforcefieldnovehicles"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_vehs = state
            end
        )

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Peds",
            {"netforcefieldnopeds"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_peds = state
            end
        )

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Objects",
            {"netforcefieldnoobjects"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_objs = state
            end
        )

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Pickups",
            {"netforcefieldnopickups"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_pickups = state
            end,
            true
        )

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Personal Vehicles",
            {"netforcefieldnopersonalvehicles"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_personal_vehs = state
            end,
            true
        )

        menu.toggle(
            forcefield_igns_net_root,
            "Ignore Players",
            {"netforcefieldnoplayers"},
            "",
            function(state)
                net_settings[player_id].forcefield_ign_players = state
            end,
            true
        )
    end
)

players.on_leave(
    function(player_id)
        net_settings[player_id] = nil
    end
)

players.dispatch_on_join()