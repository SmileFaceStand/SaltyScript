--[[
Script created by (=#1000

Credits:
Lua Retards and Lua Masters for helping me
Nullity for helping a lot with the Forcefield
Nowiry for the Tall Cage
]]
util.require_natives(1651208000)
util.keep_running()
util.toast("Welcome to SmileScript. Hope you'll enjoy! :)")

--########################################################

  ---------------------| Variables |---------------------

--########################################################

local explosion_types <const> = {
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

local cage_types <const> = {
    [0] = {
        "Standard Cage",
        objects = {
            {
                name = "prop_gold_cont_01",
                offset = v3.new(0, 0, 0),
                rotation = v3.new(0, 0, 0)
            }
        },
        max_distance = 2
    },
    [1] = {
        "Tall Cage",
        objects = {
            {
                name = "prop_rub_cage01a",
                offset = v3.new(0, 0, -1),
                rotation = v3.new(0, 0, 0)
            },
            {
                name = "prop_rub_cage01a",
                offset = v3.new(0, 0, 1.2),
                rotation = v3.new(-180, 0, 90)
            }
        },
        max_distance = 1.5
    },
    [2] = {
        "Box Cage",
        objects = {
            {
                name = "prop_ld_crate_01",
                offset = v3.new(0, 0, 0),
                rotation = v3.new(-180, 90, 0)
            },
            {
                name = "prop_ld_crate_01",
                offset = v3.new(0, 0, 0),
                rotation = v3.new(0, 90, 0)
            }
        },
        max_distance = 1.5
    },
    [3] = {
        "Pipe Cage",
        objects = {
            {
                name = "prop_pipes_conc_01",
                offset = v3.new(0, 0, 0),
                rotation = v3.new(90, 0, 0)
            }
        },
        max_distance = 1.5
    },
    [4] = {
        "Stunt Tube Cage",
        objects = {
            {
                name = "stt_prop_stunt_tube_end",
                offset = v3.new(0, 0, 0),
                rotation = v3.new(0, -90, 0)
            }
        },
        max_distance = 13
    }
}

local entity_types <const> = {
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

local forcefield_types <const> = {
    [0] = {"Push"},
    [1] = {"Pull"}
}

--#################################################

  ------------------| Functions |------------------

--#################################################

local alarm = false

local function start_alarm(alarm_time)
    alarm = false
    local time = 0

    util.create_tick_handler(function()
        local time_elapsed = MISC.GET_FRAME_TIME() * 1000

        if time >= alarm_time then
            alarm = true
            return false
        else
            time += time_elapsed
        end
    end)
end

local function get_alarm()
    return alarm
end

local function get_hud_colour()
    local red_command_ref <const> = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Red")
    local green_command_ref <const> = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Green")
    local blue_command_ref <const> = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Blue")
    local alpha_command_ref <const> = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Opacity")
    local red <const> = menu.get_value(red_command_ref)
    local green <const> = menu.get_value(green_command_ref)
    local blue <const> = menu.get_value(blue_command_ref)
    local alpha <const> = menu.get_value(alpha_command_ref)

    return red, green, blue, alpha
end

local function request_model(model)
    STREAMING.REQUEST_MODEL(model)

    while not STREAMING.HAS_MODEL_LOADED(model) do
        util.yield()
    end
end

local function request_ptfx_asset(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield()
    end
end

local function wait_session_transition(yield_time)
    yield_time = yield_time or 1000

    while util.is_session_transition_active() do
        util.yield(yield_time)
    end
end

local function wait_player_revive(player_id, yield_time)
    yield_time = yield_time or 250

    while PLAYER.IS_PLAYER_DEAD(player_id) do
        util.yield(yield_time)
    end
end

local function kick_player_out_of_veh(player_id, yield_time, max_time)
    yield_time = yield_time or 50
    max_time = max_time or 1000

    local ped_id <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
    local is_player_in_vehicle <const> = PED.IS_PED_IN_ANY_VEHICLE(ped_id)
    local player_root_ref <const> = menu.player_root(player_id)
    local kick_vehicle_command_ref <const> = menu.ref_by_rel_path(player_root_ref, "Trolling>Kick From Vehicle")

    menu.trigger_command(kick_vehicle_command_ref)
    start_alarm(max_time)

    while is_player_in_vehicle do
        local is_alarm_finished <const> = get_alarm()

        if is_alarm_finished then
            break
        end

        util.yield(yield_time)
    end
end

local function set_entity_toward_target(entity, target)
	local entity_pos <const> = ENTITY.GET_ENTITY_COORDS(entity, false)
	local target_pos <const> = ENTITY.GET_ENTITY_COORDS(target, false)
	local entity_rot = v3.lookAt(entity_pos, target_pos)
    
	ENTITY.SET_ENTITY_HEADING(entity, entity_rot.z)
end

local function get_vehicles_in_range(pos, range, exclude_personal_vehicles)
    pos = pos or v3.new(0, 0, 0)
    range = range or 16000
    exclude_personal_vehicles = exclude_personal_vehicles or false

    local all_vehicles <const> = entities.get_all_vehicles_as_pointers()
    local vehicles = {}

    for i, vehicle in pairs(all_vehicles) do
        local vehicle_pos <const> = entities.get_position(vehicle)
        local is_vehicle_in_range <const> = v3.distance(pos, vehicle_pos) <= range
        local is_vehicle_personal <const> = entities.get_vehicle_has_been_owned_by_player(vehicle)

        if is_vehicle_in_range and not (exclude_personal_vehicles and is_vehicle_personal) then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

local function get_peds_in_range(pos, range, exclude_players)
    pos = pos or v3.new(0, 0, 0)
    range = range or 16000
    exclude_players = exclude_players or false

    local all_peds <const> = entities.get_all_peds_as_pointers()
    local peds = {}

    for i, ped in pairs(all_peds) do
        local ped_pos <const> = entities.get_position(ped)
        local is_ped_in_range <const> = v3.distance(pos, ped_pos) <= range
        local is_ped_a_player <const> = entities.get_player_info(ped) ~= 0

        if is_ped_in_range and not (exclude_players and is_ped_a_player) then
            table.insert(peds, ped)
        end
    end
    return peds
end

local function get_objects_in_range(pos, range)
    pos = pos or v3.new(0, 0, 0)
    range = range or 16000

    local all_objects <const> = entities.get_all_objects_as_pointers()
    local objects = {}

    for i, object in pairs(all_objects) do
        local object_pos <const> = entities.get_position(object)
        local is_object_in_range <const> = v3.distance(pos, object_pos) <= range

        if is_object_in_range then
            table.insert(objects, object)
        end
    end
    return objects
end


local function get_pickups_in_range(pos, range)
    pos = pos or v3.new(0, 0, 0)
    range = range or 16000

    local all_pickups <const> = entities.get_all_pickups_as_pointers()
    local pickups = {}

    for i, pickup in pairs(all_pickups) do
        local pickup_pos <const> = entities.get_position(pickup)
        local is_pickup_in_range <const> = v3.distance(pos, pickup_pos) <= range

        if is_pickup_in_range then
            table.insert(pickups, pickup)
        end
    end
    return pickups
end

--########################################################

  --------------| Local Features Generator |--------------

--########################################################

------------------------------
-- Self Section
------------------------------

local self_local_list = menu.list(menu.my_root(), "Self")
menu.divider(self_local_list, "Self")

------------------------------
-- Weapons Menu
------------------------------

local wpns_local_list = menu.list(self_local_list, "Weapons")
menu.divider(wpns_local_list, "Weapons")

menu.toggle(
    wpns_local_list,
    "Autoload Weapons",
    {"autoloadweapons"},
    "Autoload all the weapons everytime you join a new session.",
    function(state)
        if state then
            players.on_join(
                function(player_id)
                    local my_player_id <const> = players.user()

                    if player_id == my_player_id then
                        local all_weapons_command_ref <const> = menu.ref_by_path("Self>Weapons>Get Weapons>All Weapons")

                        wait_session_transition()
                        menu.trigger_command(all_weapons_command_ref)
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

local forcefield = {
    is_enabled = false,
    range = 20,
    range_command_on_focus = true,
    multiplier = 0.5,
    type = 0,
    ignore_vehicles = false,
    ignore_peds = false,
    ignore_personal_vehicles = true
}

local forcefield_local_list = menu.list(self_local_list, "Forcefield")
menu.divider(forcefield_local_list, "Forcefield")

menu.toggle(
    forcefield_local_list,
    "Forcefield",
    {"forcefield"},
    "",
    function(state)
        forcefield.is_enabled = state
        if state then
            while forcefield.is_enabled do
                local targets = {}
                local player_id <const> = players.user()
                local player_pos <const> = players.get_position(player_id)
                local player_ped <const> = players.user_ped()

                if not forcefield.ignore_vehicles then
                    local vehicles <const> = get_vehicles_in_range(player_pos, forcefield.range, forcefield.ignore_personal_vehicles)

                    for i = 1, #vehicles do
                        table.insert(targets, vehicles[i])
                    end
                end

                if not forcefield.ignore_peds then
                    local peds <const> = get_peds_in_range(player_pos, forcefield.range, true)

                    for i = 1, #peds do
                        table.insert(targets, peds[i])
                    end
                end

                for i, target in pairs(targets) do
                    target = entities.pointer_to_handle(target)
                    local is_target_my_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(player_ped, false) == target
                    local is_control_given <const> = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                    local is_forcefield_negative <const> = forcefield.type == 1
                    local is_entity_a_ped <const> = ENTITY.GET_ENTITY_TYPE(target) == 1

                    if not is_target_my_vehicle and is_control_given then
                        local force = ENTITY.GET_ENTITY_COORDS(target)

                        v3.sub(force, player_pos)
                        v3.normalise(force)
                        v3.mul(force, forcefield.multiplier)

                        if is_forcefield_negative then
                            v3.mul(force, -1)
                        end

                        if is_entity_a_ped then
                            PED.SET_PED_TO_RAGDOLL(
                                target,
                                500,
                                0,
                                0,
                                false,
                                false,
                                false
                            )
                        end

                        ENTITY.APPLY_FORCE_TO_ENTITY(
                            target,
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
        end
    end
)

local forcefield_range_command_local = menu.slider(
    forcefield_local_list,
    "Forcefield Range",
    {"forcefieldrange"},
    "",
    5,
    100,
    20,
    5,
    function(value)
        forcefield.range = value
    end
)

menu.on_focus(forcefield_range_command_local, function()
    forcefield.range_command_on_focus = true

    util.create_tick_handler(function()
        local player_id <const> = players.user()
        local player_pos <const> = players.get_position(player_id)
        local red <const>, green <const>, blue <const> = get_hud_colour()

        if not forcefield.range_command_on_focus then
            return false
        end

        GRAPHICS._DRAW_SPHERE(
            player_pos.x,
            player_pos.y,
            player_pos.z,
            forcefield.range,
            red,
            green,
            blue,
            0.5
        )
    end)
end)

menu.on_blur(forcefield_range_command_local, function()
    forcefield.range_command_on_focus = false
end)

menu.slider(
    forcefield_local_list,
    "Forcefield Multiplier",
    {"forcefieldmultiplier"},
    "",
    1,
    10,
    1,
    1,
    function(value)
        forcefield.multiplier = value * 0.5
    end
)

menu.list_select(
    forcefield_local_list,
    "Forcefield Type",
    {"forcefieldtype"},
    "",
    forcefield_types,
    0,
    function(value)
        forcefield.type = value
    end
)

local forcefield_ignores_local_list = menu.list(forcefield_local_list, "Forcefield Ignores")
menu.divider(forcefield_ignores_local_list, "Forcefield Ignores")

menu.toggle(
    forcefield_ignores_local_list,
    "Ignore Vehicles",
    {"forcefieldnovehicles"},
    "",
    function(state)
        forcefield.ignore_vehicles = state
    end
)

menu.toggle(
    forcefield_ignores_local_list,
    "Ignore Peds",
    {"forcefieldnopeds"},
    "",
    function(state)
        forcefield.ignore_peds = state
    end
)

menu.toggle(
    forcefield_ignores_local_list,
    "Ignore Personal Vehicles",
    {"forcefieldnopersonalvehicles"},
    "",
    function(state)
        forcefield.ignore_personal_vehicles = state
    end,
    true
)

------------------------------
-- World Section
------------------------------

local world_local_list = menu.list(menu.my_root(), "World")
menu.divider(world_local_list, "World")

------------------------------
-- Clear World Menu
------------------------------

local clear_world = {
    vehicles = true,
    peds = true,
    objects = true,
    pickups = true,
    ignore_personal_vehicles = true
}

local clr_world_local_list = menu.list(world_local_list, "Clear World")
menu.divider(clr_world_local_list, "Clear World")

menu.action(
    clr_world_local_list,
    "Clear World",
    {"clearworld"},
    "",
    function()
        local is_in_session <const> = NETWORK.NETWORK_IS_IN_SESSION()

        if is_in_session then
            local count = 0
            if clear_world.vehicles then
                local vehicles <const> = get_vehicles_in_range(nil, nil, clear_world.exclude_personal_vehicles)

                for i, vehicle in pairs(vehicles) do
                    entities.delete_by_pointer(vehicle)
                    count += 1
                end
            end
            if clear_world.peds then
                local peds <const> = get_peds_in_range(nil, nil, true)

                for i, ped in pairs(peds) do
                    entities.delete_by_pointer(ped)
                    count += 1
                end
            end
            if clear_world.objects then
                local objects <const> = get_objects_in_range()

                for i, object in pairs(objects) do
                    entities.delete_by_pointer(object)
                    count += 1
                end
            end
            if clear_world.pickups then
                local pickups <const> = get_pickups_in_range()

                for i, pickup in pairs(pickups) do
                    entities.delete_by_pointer(pickup)
                    count += 1
                end
            end
            util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
        else
            util.toast("You can't use clear world in singleplayer. :/")
        end
end)

menu.toggle(
    clr_world_local_list,
    "Clear Vehicles",
    {"clearvehicles"},
    "",
    function(state)
        clear_world.vehicles = state
    end,
    true
)

menu.toggle(
    clr_world_local_list,
    "Clear Peds",
    {"clearpeds"},
    "",
    function(state)
        clear_world.peds = state
    end,
    true
)

menu.toggle(
    clr_world_local_list,
    "Clear Objects",
    {"clearobjects"},
    "",
    function(state)
        clear_world.objects = state
    end,
    true
)

menu.toggle(
    clr_world_local_list,
    "Clear Pickups",
    {"clearpickups"},
    "",
    function(state)
        clear_world.pickups = state
    end,
    true
)

menu.toggle(
    clr_world_local_list,
    "Ignore Personal Vehicles",
    {"clearnopersonalvehicles"},
    "",
    function(state)
        clear_world.ignore_personal_vehicles = state
    end,
    true
)

--########################################################

  ---------------| Net Features Generator |---------------

--########################################################

players.on_join(
    function(player_id)
        menu.divider(menu.player_root(player_id), "SmileScript")

        ------------------------------
        -- Trolling Section
        ------------------------------

        local trolling_net_list = menu.list(menu.player_root(player_id), "Trolling")
        menu.divider(trolling_net_list, "Trolling")
        local explosions_net_list = menu.list(trolling_net_list, "Explosions")
        menu.divider(explosions_net_list, "Explosions")
        local particles_net_list = menu.list(trolling_net_list, "Particles")
        menu.divider(particles_net_list, "Particles")
        local entities_net_list = menu.list(trolling_net_list, "Entities")
        menu.divider(entities_net_list, "Entities")
        local cages_net_list = menu.list(trolling_net_list, "Cages")
        menu.divider(cages_net_list, "Cages")
        local forcefield_net_list = menu.list(trolling_net_list, "Forcefield")
        menu.divider(forcefield_net_list, "Forcefield")

        menu.click_slider(
            trolling_net_list,
            "Increase Wanted Level",
            {"wantedlevel"},
            "It may take a few seconds.",
            1,
            5,
            1,
            1,
            function(value)
                local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local player_info <const> = memory.read_long(entities.handle_to_pointer(player_ped) + 0x10C8)
                local wanted_level = memory.read_uint(player_info + 0x0888)
                local is_wanted_level_reached = wanted_level >= value
                local failed = false

                start_alarm(10000)

                if not is_wanted_level_reached then
                    while not is_wanted_level_reached do
                        wanted_level = memory.read_uint(player_info + 0x0888)
                        is_wanted_level_reached = wanted_level >= value

                        if get_alarm() then
                            failed = true
                            break
                        end

                        for i = 1, 46 do
                            PLAYER.REPORT_CRIME(player_id, i, value)
                        end

                        util.yield(10)
                    end

                    if failed then
                        util.toast("Failed to increase wanted Level. :/")
                    else
                        util.toast("Wanted level increased successfully. :)")
                    end
                else
                    util.toast("Wanted level is already " .. wanted_level .. ". :)")
                end
            end
        )

        ------------------------------
        -- Explosions Menu
        ------------------------------

        local explosion = {
            delay = 100,
            shake = 1,
            blamed = false,
            audible = true,
            visible = true,
            damage = true
        }

        local function add_explosion()
            local my_player_ped <const> = players.user_ped()
            local player_pos <const> = players.get_position(player_id)

            if explosion.blamed then
                FIRE.ADD_OWNED_EXPLOSION(
                    my_player_ped,
                    player_pos.x,
                    player_pos.y,
                    player_pos.z,
                    explosion.type,
                    1,
                    explosion.audible,
                    not explosion.visible,
                    explosion.shake
                )
            else
                FIRE.ADD_EXPLOSION(
                    player_pos.x,
                    player_pos.y,
                    player_pos.z,
                    explosion.type,
                    1,
                    explosion.audible,
                    not explosion.visible,
                    explosion.shake,
                    not explosion.damage
                )
            end
        end

        menu.action(
            explosions_net_list,
            "Explode",
            {"ssexplode"},
            "",
            function()
                add_explosion()
            end
        )

        menu.toggle_loop(
            explosions_net_list,
            "Explode Loop",
            {"explodeloop"},
            "",
            function()
                add_explosion()
                util.yield(explosion.delay)
            end
        )

        menu.list_select(
            explosions_net_list,
            "Explosion Type",
            {"explosiontype"},
            "",
            explosion_types,
            0,
            function(value)
                explosion.type = value
            end
        )

        local explosion_other_net_list = menu.list(explosions_net_list, "Other Settings")
        menu.divider(explosion_other_net_list, "Other Settings")

        menu.slider(
            explosion_other_net_list,
            "Explosion Delay",
            {"explosiondelay"},
            "",
            50,
            1000,
            250,
            50,
            function(value)
                explosion.delay = value
            end
        )

        menu.slider(
            explosion_other_net_list,
            "Explosion Shake",
            {"explosionshake"},
            "",
            0,
            100,
            1,
            1,
            function(value)
                explosion.shake = value
            end
        )

        menu.toggle(
            explosion_other_net_list,
            "Explosion Blamed",
            {"explosionblamed"},
            "",
            function(state)
                explosion.blamed = state
            end
        )

        menu.toggle(
            explosion_other_net_list,
            "Explosion Audible",
            {"explosionaudible"},
            "",
            function(state)
                explosion.audible = state
            end,
            true
        )

        menu.toggle(
            explosion_other_net_list,
            "Explosion Visible",
            {"explosionvisible"},
            "",
            function(state)
                explosion.visible = state
            end,
            true
        )

        menu.toggle(
            explosion_other_net_list,
            "Explosion Damage",
            {"explosiondamage"},
            "If Explosion Blamed is on, turning this off won't have any effect.",
            function(state)
                explosion.damage = state
            end,
            true
        )

        ------------------------------
        -- Particles Menu
        ------------------------------

        local ptfx = {
            ids = {},
            power = 1,
            size = 5,
            asset = "core",
            name = "exp_grd_grenade_smoke"
        }

        local function start_ptfx()
            local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)

            request_ptfx_asset(ptfx.asset)
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx.asset)

            for i = 1, ptfx.power, 1 do
                local ptfx_id <const> = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                    ptfx.name,
                    player_ped,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    ptfx.size,
                    false,
                    false,
                    false

                )

                table.insert(ptfx.ids, ptfx_id)
            end
        end

        local function remove_ptfx()
            for i, ptfx_id in pairs(ptfx.ids) do
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
            end
        end

        menu.toggle(
            particles_net_list,
            "Start PTFX",
            {"ptfx"},
            "",
            function(state)
                if state then
                    start_ptfx()
                    while state do
                        local is_player_dead <const> = PLAYER.IS_PLAYER_DEAD(player_id)

                        if is_player_dead then
                            wait_player_revive(player_id)
                            remove_ptfx()
                            start_ptfx()
                        else
                            util.yield(1000)
                        end
                    end
                else
                    remove_ptfx()
                end
            end
        )

        menu.slider(
            particles_net_list,
            "PTFX Amount",
            {"ptfxamount"},
            "",
            1,
            250,
            1,
            1,
            function(value)
                ptfx.power = value
            end
        )

        menu.slider(
            particles_net_list,
            "PTFX Size",
            {"ptfxsize"},
            "",
            1,
            10,
            5,
            1,
            function(value)
                ptfx.size = value
            end
        )

        local particles_other_net_list = menu.list(particles_net_list, "Other Settings")
        menu.divider(particles_other_net_list, "Other Settings")

        menu.text_input(
            particles_other_net_list,
            "PTFX Asset",
            {"ptfxasset"},
            "",
            function(value)
                ptfx.offset = value
            end,
            "core"
        )

        menu.text_input(
            particles_other_net_list,
            "PTFX Name",
            {"ptfxname"},
            "",
            function(value)
                ptfx.name = value
            end,
            "exp_grd_grenade_smoke"
        )

        menu.hyperlink(
            particles_other_net_list,
            "PTFX List",
            "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270",
            "List of all PTFX and assets."
        )

        ------------------------------
        -- Entities Menu
        ------------------------------

        local entity = {
            type = 0,
            amount = 1
        }

        menu.action(
            entities_net_list,
            "Spawn Entities",
            {"spamentities"},
            "",
            function()
                local entity_name <const> = entity_types[entity.type].name
                local entity_hash <const> = util.joaat(entity_name)
                local player_pos <const> = players.get_position(player_id)

                request_model(entity_hash)

                for i = 1, entity.amount, 1 do
                    local offset <const> = v3.new(math.random(-1, 1) * 0.25, math.random(-1, 1) * 0.25, math.random(-1, 1) * 0.25)
                    local entity_pos <const> = player_pos

                    v3.add(entity_pos, offset)

                    OBJECT.CREATE_OBJECT_NO_OFFSET(
                        entity_hash,
                        entity_pos.x,
                        entity_pos.y,
                        entity_pos.z,
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
            end
        )

        menu.slider(
            entities_net_list,
            "Entity Amount",
            {"entitiesamount"},
            "",
            1,
            50,
            1,
            1,
            function(value)
                entity.amount = value
            end
        )

        menu.list_select(
            entities_net_list,
            "Entity Type",
            {"entitytype"},
            "",
            entity_types,
            0,
            function(value)
                entity.type = value
            end
        )

        ------------------------------
        -- Cages Menu
        ------------------------------

        local cage = {
            ids = {},
            failed = false,
            automatic = false,
            type = 0,
            visible = true,
        }

        local function add_cage()
            local objects <const> = cage_types[cage.type].objects
            cage.failed = false

            for i, object in ipairs(objects) do
                local cage_hash <const> = util.joaat(object.name)
                local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local is_player_in_vehicle = PED.IS_PED_IN_ANY_VEHICLE(player_ped, false)

                request_model(cage_hash)

                if is_player_in_vehicle then
                    kick_player_out_of_veh(player_id)

                    is_player_in_vehicle = PED.IS_PED_IN_ANY_VEHICLE(player_ped, false)

                    if is_player_in_vehicle then
                        cage.failed = true
                        break
                    end
                end

                local player_pos <const> = players.get_position(player_id)
                local entity_pos = player_pos
                v3.add(entity_pos, object.offset)

                local cage_object <const> = entities.create_object(cage_hash, entity_pos)

                table.insert(cage.ids, cage_object)
                ENTITY.SET_ENTITY_ROTATION(cage_object, object.rotation.x, object.rotation.y, object.rotation.z, 1, true)
                ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
                ENTITY.SET_ENTITY_VISIBLE(cage_object, cage.visible, false)
                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_hash)
            end

            if cage.failed then
                util.toast("Failed to cage the player. :/")
            end
        end

        local function remove_cage()
            if not cage.failed then
                for i, cage_id in pairs(cage.ids) do
                    entities.delete_by_handle(cage_id)
                end

                for cage_id in pairs(cage.ids) do
                    cage.ids[cage_id] = nil
                end
            end
        end

        menu.toggle(
            cages_net_list,
            "Cage",
            {"cage"},
            "",
            function(state)
                if state then
                    add_cage()
                else
                    if not cage.failed then
                        remove_cage()
                    end
                end
            end
        )

        menu.toggle(
            cages_net_list,
            "Automatic Cage",
            {"automaticcage"},
            "Automatically re-cage the player if he leaves the cage.",
            function(state)
                cage.automatic = state
                if state then
                    add_cage()

                    local player_pos = players.get_position(player_id)
                    local first_player_pos = player_pos

                    while cage.automatic do
                        player_pos = players.get_position(player_id)
                        local distance <const> = v3.distance(first_player_pos, player_pos)
                        local max_distance <const> = cage_types[cage.type].max_distance
                        local is_distance_greater_than_max <const> = distance >= max_distance

                        if is_distance_greater_than_max then
                            first_player_pos = player_pos

                            remove_cage()
                            add_cage()
                            util.toast("Player re-caged successfully. :)")
                        end

                        util.yield(250)
                    end
                else
                    remove_cage()
                end
            end
        )

        menu.list_select(
            cages_net_list,
            "Cage Type",
            {"cagetype"},
            "",
            cage_types,
            0,
            function(value)
                cage.type = value
            end
        )

        menu.toggle(
            cages_net_list,
            "Cage Visible",
            {"cagevisible"},
            "",
            function(state)
                cage.visible = state
            end,
            true
        )

        ------------------------------
        -- Forcefield Menu
        ------------------------------

        local net_forcefield = {
            is_enabled = false,
            range = 20,
            range_command_on_focus = true,
            multiplier = 0.5,
            type = 0,
            ignore_vehicles = false,
            ignore_peds = false,
            ignore_personal_vehicles = true
        }

        menu.toggle(
            forcefield_net_list,
            "Forcefield",
            {"forcefield"},
            "",
            function(state)
                net_forcefield.is_enabled = state
                if state then
                    while net_forcefield.is_enabled do
                        local targets = {}
                        local player_pos <const> = players.get_position(player_id)
                        local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)

                        if not net_forcefield.ignore_vehicles then
                            local vehicles <const> = get_vehicles_in_range(player_pos, net_forcefield.range, net_forcefield.ignore_personal_vehicles)

                            for i = 1, #vehicles do
                                table.insert(targets, vehicles[i])
                            end
                        end

                        if not net_forcefield.ignore_peds then
                            local peds <const> = get_peds_in_range(player_pos, net_forcefield.range, true)

                            for i = 1, #peds do
                                table.insert(targets, peds[i])
                            end
                        end

                        for i, target in pairs(targets) do
                            target = entities.pointer_to_handle(target)
                            local is_target_my_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(player_ped, false) == target
                            local is_control_given <const> = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                            local is_forcefield_negative <const> = net_forcefield.type == 1
                            local is_entity_a_ped <const> = ENTITY.GET_ENTITY_TYPE(target) == 1

                            if not is_target_my_vehicle and is_control_given then
                                local force = ENTITY.GET_ENTITY_COORDS(target)

                                v3.sub(force, player_pos)
                                v3.normalise(force)
                                v3.mul(force, net_forcefield.multiplier)

                                if is_forcefield_negative then
                                    v3.mul(force, -1)
                                end

                                if is_entity_a_ped then
                                    PED.SET_PED_TO_RAGDOLL(
                                        target,
                                        500,
                                        0,
                                        0,
                                        false,
                                        false,
                                        false
                                    )
                                end

                                ENTITY.APPLY_FORCE_TO_ENTITY(
                                    target,
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
                end
            end
        )

        local forcefield_range_command_net = menu.slider(
            forcefield_net_list,
            "Forcefield Range",
            {"forcefieldrange"},
            "",
            5,
            100,
            20,
            5,
            function(value)
                net_forcefield.range = value
            end
        )

        menu.on_focus(forcefield_range_command_net, function()
            net_forcefield.range_command_on_focus = true

            util.create_tick_handler(function()
                local player_pos <const> = players.get_position(player_id)
                local red <const>, green <const>, blue <const> = get_hud_colour()

                if not net_forcefield.range_command_on_focus then
                    return false
                end

                GRAPHICS._DRAW_SPHERE(
                    player_pos.x,
                    player_pos.y,
                    player_pos.z,
                    net_forcefield.range,
                    red,
                    green,
                    blue,
                    0.5
                )
            end)
        end)

        menu.on_blur(forcefield_range_command_net, function()
            net_forcefield.range_command_on_focus = false
        end)

        menu.slider(
            forcefield_net_list,
            "Forcefield Multiplier",
            {"forcefieldmultiplier"},
            "",
            1,
            10,
            1,
            1,
            function(value)
                net_forcefield.multiplier = value * 0.5
            end
        )

        menu.list_select(
            forcefield_net_list,
            "Forcefield Type",
            {"forcefieldtype"},
            "",
            forcefield_types,
            0,
            function(value)
                net_forcefield.type = value
            end
        )

        local forcefield_ignores_net_list = menu.list(forcefield_net_list, "Forcefield Ignores")
        menu.divider(forcefield_ignores_net_list, "Forcefield Ignores")

        menu.toggle(
            forcefield_ignores_net_list,
            "Ignore Vehicles",
            {"forcefieldnovehicles"},
            "",
            function(state)
                net_forcefield.ignore_vehicles = state
            end
        )

        menu.toggle(
            forcefield_ignores_net_list,
            "Ignore Peds",
            {"forcefieldnopeds"},
            "",
            function(state)
                net_forcefield.ignore_peds = state
            end
        )

        menu.toggle(
            forcefield_ignores_net_list,
            "Ignore Personal Vehicles",
            {"forcefieldnopersonalvehicles"},
            "",
            function(state)
                net_forcefield.ignore_personal_vehicles = state
            end,
            true
        )
    end
)

players.dispatch_on_join()