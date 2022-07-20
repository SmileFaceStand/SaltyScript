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

local script_dir <const> = filesystem.scripts_dir() .. "/lib/smilescript"

if not filesystem.exists(script_dir .. "/functions.lua") then
    error("Required file not found: /lib/smilescript/functions.lua")
end

require("lib.smilescript.functions")

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

local entity_types <const> = {
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

local cage_types <const> = {
    [0] = {
        "Standard Cage",
        objects = {
            {
                name = "prop_gold_cont_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(0, 0, 0)
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
                rot = v3.new(0, 0, 0)
            },
            {
                name = "prop_rub_cage01a",
                offset = v3.new(0, 0, 1.2),
                rot = v3.new(-180, 0, 90)
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
                rot = v3.new(-180, 90, 0)
            },
            {
                name = "prop_ld_crate_01",
                offset = v3.new(0, 0, 0),
                rot = v3.new(0, 90, 0)
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
                rot = v3.new(90, 0, 0)
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
                rot = v3.new(0, -90, 0)
            }
        },
        max_distance = 13
    }
}

local vehicle_types <const> = {
    [0] = {"Faggio", name = "faggio"},
    [1] = {"Go Kart", name = "veto"},
    [2] = {"Zhaba", name = "zhaba"},
    [3] = {"Buzzard", name = "buzzard2"},
    [4] = {"Insurgent", name = "insurgent"},
    [5] = {"Khanjali", name = "Khanjali"},
    [6] = {"Phantom Wedge", name = "phantom2"},
    [7] = {"Armored Boxville", name = "boxville5"},
    [8] = {"Bus", name = "bus"},
    [9] = {"Blimp", name = "blimp"},
}

local aura_vehicle_types <const> = {
    [0] = {"Explode"},
    [1] = {"Burn"},
    [2] = {"EMP"},
    [3] = {"Delete"}
}

local aura_ped_types <const> = {
    [0] = {"Explode"},
    [1] = {"Burn"},
    [2] = {"Taze"},
    [3] = {"Delete"}
}

local forcefield_types <const> = {
    [0] = {"Push"},
    [1] = {"Pull"}
}

local fake_pickup_types <const> = {
    [0] = {
        "Money Bag",
        objects = {
            "p_poly_bag_01_s"
        }
    },
    [1] = {
        "Action Figure",
        objects = {
            "vw_prop_vw_colle_alien",
            "vw_prop_vw_colle_beast",
            "vw_prop_vw_colle_imporage",
            "vw_prop_vw_colle_pogo",
            "vw_prop_vw_colle_prbubble",
            "vw_prop_vw_colle_rsrcomm",
            "vw_prop_vw_colle_rsrgeneric",
            "vw_prop_vw_colle_sasquatch"
        }
    },
    [2] = {
        "P's & Q's",
        objects = {
            "prop_choc_pq"
        }
    },
}

--########################################################

  --------------| Local Features Generator |--------------

--########################################################

local local_lists <const> = {
    ["Self"] = menu.list(menu.my_root(), "Self"),
    ["World"] = menu.list(menu.my_root(), "World")
}

menu.divider(local_lists["Self"], "Self")
menu.divider(local_lists["World"], "World")

local local_sub_lists <const> = {
    ["Weapons"] = menu.list(local_lists["Self"], "Weapons"),
    ["Aura"] = menu.list(local_lists["Self"], "Aura"),
    ["Forcefield"] = menu.list(local_lists["Self"], "Forcefield"),
    ["Clear World"] = menu.list(local_lists["World"], "Clear World")
}

------------------------------
-- Self Section
------------------------------

------------------------------
-- Weapons Menu
------------------------------

menu.divider(local_sub_lists["Weapons"], "Weapons")

menu.toggle(local_sub_lists["Weapons"], "Autoload Weapons", {"autoloadweapons"},
"Autoload all the weapons everytime you join a new session.", function(state)
    if state then
        players.on_join(function(player_id)
            local my_player_id <const> = players.user()

            if player_id == my_player_id then
                local all_weapons_command_ref <const> = menu.ref_by_path("Self>Weapons>Get Weapons>All Weapons")

                wait_session_transition()
                menu.trigger_command(all_weapons_command_ref)
                util.toast("Weapons loaded successfully. :)")
            end
        end)
    end
end)

------------------------------
-- Aura Menu
------------------------------

local aura = {
    is_enabled = false,
    range = 20,
    range_command_on_focus = false,
    vehicle_type = 0,
    ped_type = 0,
    ignore_vehicles = false,
    ignore_peds = false,
    ignore_player_vehicles = true
}

menu.divider(local_sub_lists["Aura"], "Aura")

menu.toggle(local_sub_lists["Aura"], "Aura", {"aura"}, "", function(state)
    aura.is_enabled = state

    while aura.is_enabled do
        local targets = {}
        local player_pos <const> = players.get_position(players.user())

        if not aura.ignore_vehicles then
            local vehicles <const> = get_vehicles_in_range(player_pos, aura.range, aura.ignore_player_vehicles)

            for i = 1, #vehicles do
                table.insert(targets, vehicles[i])
            end
        end

        if not aura.ignore_peds then
            local peds <const> = get_peds_in_range(player_pos, aura.range, true)

            for i = 1, #peds do
                table.insert(targets, peds[i])
            end
        end

        for i, target in pairs(targets) do
            target = entities.pointer_to_handle(target)
            local entity_type <const> = ENTITY.GET_ENTITY_TYPE(target)
            local player_ped <const> = players.user_ped()
            local player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
            local is_entity_dead <const> = ENTITY.IS_ENTITY_DEAD(target, false)
            local target_pos <const> = ENTITY.GET_ENTITY_COORDS(target, false)
            local is_ped_in_vehicle <const> = PED.IS_PED_IN_ANY_VEHICLE(target, false)

            if (entity_type == 2) and not (player_vehicle == target) then
                local vehicle_health <const> = VEHICLE.GET_VEHICLE_ENGINE_HEALTH(target)
                local is_vehicle_engine_running <const> = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(target)

                pluto_switch aura.vehicle_type do
                    case 0:
                        if not is_entity_dead then
                            FIRE.ADD_EXPLOSION(
                                target_pos.x, target_pos.y, target_pos.z,
                                0, 1, true, false, 1, false
                            )
                        end
                        break
                    case 1:
                        if not is_entity_dead and not (vehicle_health <= 0) then
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(target, -80)
                        end
                        break
                    case 2:
                        if is_vehicle_engine_running then
                            FIRE.ADD_EXPLOSION(
                                target_pos.x, target_pos.y, target_pos.z,
                                65, 1, false, true, 0, false
                            )
                        end
                        break
                    case 3:
                        entities.delete_by_handle(target)
                        break
                    pluto_default:
                        break
                end
            end

            if (entity_type == 1) and not is_ped_in_vehicle and not (player_ped == target) then
                local is_ped_burning <const> = FIRE.IS_ENTITY_ON_FIRE(target)
                local is_ped_stunned <const> = PED.IS_PED_BEING_STUNNED(target, false)
                local stungun_hash <const> = util.joaat("weapon_stungun")

                pluto_switch aura.ped_type do
                    case 0:
                        if not is_entity_dead then
                            FIRE.ADD_EXPLOSION(
                                target_pos.x, target_pos.y, target_pos.z,
                                0, 1, true, false, 1, false
                            )
                        end
                        break
                    case 1:
                        if not is_entity_dead and not is_ped_burning then
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                            FIRE.START_ENTITY_FIRE(target)
                        end
                        break
                    case 2:
                        if not is_entity_dead and not is_ped_stunned then
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                                target_pos.x, target_pos.y, target_pos.z + 1,
                                target_pos.x, target_pos.y, target_pos.z,
                                0, 0, stungun_hash, players.user(), false, true, 1
                            )
                        end
                        break
                    case 3:
                        entities.delete_by_handle(target)
                        break
                    pluto_default:
                        break
                end
            end
        end
        util.yield(10)
    end
end)

local aura_range_command_local = menu.slider(local_sub_lists["Aura"], "Aura Range", {"aurarange"}, "", 5, 100, 20, 5, function(value)
    aura.range = value
end)

menu.on_focus(aura_range_command_local, function()
    aura.range_command_on_focus = true

    util.create_tick_handler(function()
        local player_pos <const> = players.get_position(players.user())
        local red <const>, green <const>, blue <const> = get_hud_colour()

        if not aura.range_command_on_focus then
            return false
        end

        GRAPHICS._DRAW_SPHERE(
            player_pos.x, player_pos.y, player_pos.z,
            aura.range,
            red, green, blue, 0.5
        )
    end)
end)

menu.on_blur(aura_range_command_local, function()
    aura.range_command_on_focus = false
end)

menu.list_select(local_sub_lists["Aura"], "Aura Vehicle Type", {"auravehicletype"}, "", aura_vehicle_types, 0, function(value)
    aura.vehicle_type = value
end)

menu.list_select( local_sub_lists["Aura"], "Aura Ped Type", {"aurapedtype"}, "", aura_ped_types, 0, function(value)
    aura.ped_type = value
end)

local aura_ignores_local_list <const> = menu.list(local_sub_lists["Aura"], "Aura Ignores")

menu.toggle(aura_ignores_local_list, "Ignore Vehicles", {"auranovehicles"}, "", function(state)
    aura.ignore_vehicles = state
end)

menu.toggle(aura_ignores_local_list, "Ignore Peds", {"auranopeds"}, "", function(state)
    aura.ignore_peds = state
end)

menu.toggle(aura_ignores_local_list, "Ignore Player Vehicles", {"auranoplayervehicles"}, "", function(state)
    aura.ignore_player_vehicles = state
end, true)

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
    ignore_player_vehicles = true
}

menu.divider(local_sub_lists["Forcefield"], "Forcefield")

menu.toggle(local_sub_lists["Forcefield"], "Forcefield", {"forcefield"}, "", function(state)
    forcefield.is_enabled = state

    while forcefield.is_enabled do
        local player_id <const> = players.user()
        local player_pos <const> = players.get_position(player_id)
        local targets = {}

        if not forcefield.ignore_vehicles then
            local vehicles <const> = get_vehicles_in_range(player_pos, forcefield.range, forcefield.ignore_player_vehicles)

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
            local is_control_given <const> = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
            local player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type <const> = ENTITY.GET_ENTITY_TYPE(target)

            if is_control_given and not (player_vehicle == target)  then
                local force = ENTITY.GET_ENTITY_COORDS(target)

                v3.sub(force, player_pos)
                v3.normalise(force)
                v3.mul(force, forcefield.multiplier)

                if (forcefield.type == 1) then
                    v3.mul(force, -1)
                end

                if (entity_type == 1) then
                    PED.SET_PED_TO_RAGDOLL(
                        target, 500, 0, 0,
                        false, false, false
                    )
                end

                ENTITY.APPLY_FORCE_TO_ENTITY(
                    target, 3,
                    force.x, force.y, force.z,
                    0, 0, 0.5, 0,
                    false, false, true, false, false
                )
            end
        end
        util.yield(10)
    end
end)

local forcefield_range_command_local = menu.slider(local_sub_lists["Forcefield"], "Forcefield Range", {"forcefieldrange"}, "", 5, 100, 20, 5, function(value)
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
            player_pos.x, player_pos.y, player_pos.z,
            forcefield.range,
            red, green, blue, 0.5
        )
    end)
end)

menu.on_blur(forcefield_range_command_local, function()
    forcefield.range_command_on_focus = false
end)

menu.slider_float(local_sub_lists["Forcefield"], "Forcefield Multiplier", {"forcefieldmultiplier"}, "", 10, 1000, 100, 10, function(value)
    forcefield.multiplier = value * 0.01
end)

menu.list_select(local_sub_lists["Forcefield"], "Forcefield Type", {"forcefieldtype"}, "", forcefield_types, 0, function(value)
    forcefield.type = value
end)

local forcefield_ignores_local_list <const> = menu.list(local_sub_lists["Forcefield"], "Forcefield Ignores")
menu.divider(forcefield_ignores_local_list, "Forcefield Ignores")

menu.toggle(forcefield_ignores_local_list, "Ignore Vehicles", {"forcefieldnovehicles"}, "", function(state)
    forcefield.ignore_vehicles = state
end)

menu.toggle(forcefield_ignores_local_list, "Ignore Peds", {"forcefieldnopeds"}, "", function(state)
    forcefield.ignore_peds = state
end)

menu.toggle(forcefield_ignores_local_list, "Ignore Player Vehicles", {"forcefieldnoplayervehicles"}, "", function(state)
    forcefield.ignore_player_vehicles = state
end, true)

------------------------------
-- World Section
------------------------------

------------------------------
-- Clear World Menu
------------------------------

local clear_world = {
    vehicles = true,
    peds = true,
    objects = true,
    pickups = true,
    ignore_player_vehicles = true
}

menu.divider(local_sub_lists["Clear World"], "Clear World")

menu.action(local_sub_lists["Clear World"], "Clear World", {"clearworld"}, "", function()
    local is_in_session <const> = NETWORK.NETWORK_IS_IN_SESSION()

    if is_in_session then
        local count = 0

        if clear_world.vehicles then
            local vehicles <const> = entities.get_all_vehicles_as_handles()

            for i, vehicle in pairs(vehicles) do
                local my_player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
                local is_mission_entity <const> = ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle)

                if not (my_player_vehicle == vehicle) then
                    if not (clear_world.ignore_player_vehicles and is_mission_entity) then
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, false, false)
                    else
                        pluto_continue
                    end

                    entities.delete_by_handle(vehicle)

                    count += 1

                    util.yield()
                end
            end
        end

        if clear_world.peds then
            local peds <const> = entities.get_all_peds_as_handles()

            for i, ped in pairs(peds) do
                local is_ped_player <const> = PED.IS_PED_A_PLAYER(ped)

                if not is_ped_player then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, false, false)
                    entities.delete_by_handle(ped)

                    count += 1

                    util.yield()
                end
            end
        end

        if clear_world.objects then
            local objects <const> = entities.get_all_objects_as_handles()

            for i, object in pairs(objects) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
                entities.delete_by_handle(object)

                count += 1

                util.yield()
            end
        end

        if clear_world.pickups then
            local pickups <const> = entities.get_all_pickups_as_handles()

            for i, pickup in pairs(pickups) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pickup, false, false)
                entities.delete_by_handle(pickup)

                count += 1

                util.yield()
            end
        end

        util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
    else
        util.toast("This command is only available in GTA Online.")
    end
end)

menu.toggle(local_sub_lists["Clear World"], "Clear Vehicles", {"clearvehicles"}, "", function(state)
    clear_world.vehicles = state
end, true)

menu.toggle(local_sub_lists["Clear World"], "Clear Peds", {"clearpeds"}, "", function(state)
    clear_world.peds = state
end, true)

menu.toggle(local_sub_lists["Clear World"], "Clear Objects", {"clearobjects"}, "", function(state)
clear_world.objects = state
end, true)

menu.toggle(local_sub_lists["Clear World"], "Clear Pickups", {"clearpickups"}, "", function(state)
    clear_world.pickups = state
end, true)

menu.toggle(local_sub_lists["Clear World"], "Ignore Player Vehicles", {"clearnoplayervehicles"}, "", function(state)
    clear_world.ignore_player_vehicles = state
end, true)

--########################################################

  ---------------| Net Features Generator |---------------

--########################################################

players.on_join(function(player_id)
    menu.divider(menu.player_root(player_id), "SmileScript")

    local trolling_net_list <const> = menu.list(menu.player_root(player_id), "Trolling")
    menu.divider(trolling_net_list, "Trolling")

    ------------------------------
    -- Trolling Section
    ------------------------------

    local net_lists <const> = {
        ["Explosions"] = menu.list(trolling_net_list, "Explosions"),
        ["Particles"] = menu.list(trolling_net_list, "Particles"),
        ["Objects"] = menu.list(trolling_net_list, "Objects"),
        ["Cages"] = menu.list(trolling_net_list, "Cages"),
        ["Crush"] = menu.list(trolling_net_list, "Crush"),
        ["Ram"] = menu.list(trolling_net_list, "Ram"),
        ["Aura"] = menu.list(trolling_net_list, "Aura"),
        ["Forcefield"] = menu.list(trolling_net_list, "Forcefield"),
        ["Fake Pickup"] = menu.list(trolling_net_list, "Fake Pickup")
    }

    menu.click_slider(trolling_net_list, "Increase Wanted Level", {"wantedlevel"}, "It may take a few seconds.", 1, 5, 1, 1, function(value)
            local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local player_info <const> = memory.read_long(entities.handle_to_pointer(player_ped) + 0x10C8)
            local wanted_level = memory.read_uint(player_info + 0x0888)
            local failed = false

            if wanted_level <= value then
                util.toast("Wanted level is already " .. wanted_level .. ". :)")
                return
            end

            start_alarm(10000)

            while not (wanted_level >= value) and players.exists(player_id) do
                wanted_level = memory.read_uint(player_info + 0x0888)

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
        end
    )

    ------------------------------
    -- Explosions Menu
    ------------------------------

    local explosion = {
        loop = false,
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
                my_player_ped, player_pos.x, player_pos.y, player_pos.z,
                explosion.type, 1, explosion.audible, not explosion.visible, explosion.shake
            )
        else
            FIRE.ADD_EXPLOSION(
                player_pos.x, player_pos.y, player_pos.z,
                explosion.type, 1, explosion.audible, not explosion.visible, explosion.shake, not explosion.damage
            )
        end
    end

    menu.divider(net_lists["Explosions"], "Explosions")

    menu.action(net_lists["Explosions"], "Explode", {"ssexplode"}, "", function()
        add_explosion()
    end)

    menu.toggle(net_lists["Explosions"], "Explode Loop", {"explodeloop"}, "", function(state)
        explosion.loop = state

        while explosion.loop and players.exists(player_id) do
            add_explosion()
            util.yield(explosion.delay)
        end
    end)

    menu.list_select(net_lists["Explosions"], "Explosion Type", {"explosiontype"}, "", explosion_types, 0, function(value)
            explosion.type = value
    end)

    local explosion_other_net_list <const> = menu.list(net_lists["Explosions"], "Other Settings")
    menu.divider(explosion_other_net_list, "Other Settings")

    menu.slider(explosion_other_net_list, "Explosion Delay", {"explosiondelay"}, "", 50, 1000, 250, 50, function(value)
        explosion.delay = value
    end)

    menu.slider(explosion_other_net_list, "Explosion Shake", {"explosionshake"}, "", 0, 10, 1, 1, function(value)
        explosion.shake = value
    end)

    menu.toggle(explosion_other_net_list, "Explosion Blamed", {"explosionblamed"}, "", function(state)
        explosion.blamed = state
    end)

    menu.toggle(explosion_other_net_list, "Explosion Audible", {"explosionaudible"}, "", function(state)
        explosion.audible = state
    end, true)

    menu.toggle(explosion_other_net_list, "Explosion Visible", {"explosionvisible"}, "", function(state)
        explosion.visible = state
    end, true)

    menu.toggle(explosion_other_net_list, "Explosion Damage", {"explosiondamage"}, "If Explosion Blamed is on, turning this off won't have any effect.", function(state)
        explosion.damage = state
    end, true)

    ------------------------------
    -- Particles Menu
    ------------------------------

    local ptfx = {
        ids = {},
        amount = 1,
        size = 5,
        asset = "core",
        name = "exp_grd_grenade_smoke"
    }

    local function start_ptfx()
        local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)

        request_ptfx_asset(ptfx.asset)

        for i = 1, ptfx.amount do
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx.asset)

            local ptfx_id <const> = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                ptfx.name, player_ped,
                0, 0, 0,
                0, 0, 0,
                ptfx.size,
                false, false, false
            )

            table.insert(ptfx.ids, ptfx_id)
        end
    end

    local function remove_ptfx()
        for i, ptfx_id in pairs(ptfx.ids) do
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
        end
    end

    menu.divider(net_lists["Particles"], "Particles")

    menu.toggle(net_lists["Particles"], "Start PTFX", {"ptfx"}, "", function(state)
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
    end)

    menu.slider(net_lists["Particles"], "PTFX Amount", {"ptfxamount"}, "", 1, 250, 1, 1, function(value)
        ptfx.amount = value
    end)

    menu.slider(net_lists["Particles"], "PTFX Size", {"ptfxsize"}, "", 1, 10, 5, 1, function(value)
        ptfx.size = value
    end)

    local particles_other_net_list <const> = menu.list(net_lists["Particles"], "Other Settings")
    menu.divider(particles_other_net_list, "Other Settings")

    menu.text_input(particles_other_net_list, "PTFX Asset", {"ptfxasset"}, "", function(value)
        ptfx.offset = value
    end, "core")

    menu.text_input(particles_other_net_list, "PTFX Name", {"ptfxname"}, "",function(value)
        ptfx.name = value
    end, "exp_grd_grenade_smoke")

    menu.hyperlink(particles_other_net_list, "PTFX List", "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270", "List of all PTFX and assets.")

    ------------------------------
    -- Entities Menu
    ------------------------------

    local entity = {
        type = 0,
        amount = 1
    }

    menu.divider(net_lists["Objects"], "Objects")

    menu.action(net_lists["Objects"], "Spawn Objects", {"spawnobjects"}, "", function()
        local entity_name <const> = entity_types[entity.type].name
        local entity_hash <const> = util.joaat(entity_name)
        local player_pos <const> = players.get_position(player_id)

        request_model(entity_hash)

        for i = 1, entity.amount, 1 do
            local entity_pos <const> = player_pos
            local offset <const> = v3.new(
                math.random(-1, 1) * 0.25,
                math.random(-1, 1) * 0.25,
                math.random(-1, 1) * 0.25
            )

            v3.add(entity_pos, offset)

            OBJECT.CREATE_OBJECT_NO_OFFSET(
                entity_hash, entity_pos.x, entity_pos.y, entity_pos.z,
                true, false, false
            )
        end

        FIRE.ADD_EXPLOSION(
            player_pos.x, player_pos.y, player_pos.z,
            18, 1, false, true, 0, true
        )
    end)

    menu.slider(net_lists["Objects"], "Object Amount", {"objectamount"}, "", 1, 50, 1, 1, function(value)
        entity.amount = value
    end)

    menu.list_select(net_lists["Objects"], "Object Type", {"objecttype"}, "", entity_types, 0, function(value)
        entity.type = value
    end)

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
            local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local cage_hash <const> = util.joaat(object.name)
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
            ENTITY.SET_ENTITY_ROTATION(cage_object, object.rot.x, object.rot.y, object.rot.z, 1, true)
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

    menu.divider(net_lists["Cages"], "Cages")

    menu.toggle(net_lists["Cages"], "Cage", {"cage"}, "", function(state)
        if state then
            add_cage()
        else
            if not cage.failed then
                remove_cage()
            end
        end
    end)

    menu.toggle(net_lists["Cages"], "Automatic Cage", {"automaticcage"}, "Automatically re-cage the player if he leaves the cage.", function(state)
        cage.automatic = state

        if state then
            add_cage()

            local player_pos = players.get_position(player_id)
            local first_player_pos = player_pos

            while cage.automatic and players.exists(player_id) do
                player_pos = players.get_position(player_id)
                local distance <const> = v3.distance(first_player_pos, player_pos)
                local max_distance <const> = cage_types[cage.type].max_distance

                if (distance >= max_distance) then
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
    end)

    menu.list_select(net_lists["Cages"], "Cage Type", {"cagetype"}, "", cage_types, 0, function(value)
        cage.type = value
    end)

    menu.toggle(net_lists["Cages"], "Cage Visible", {"cagevisible"}, "", function(state)
        cage.visible = state
    end, true)

    ------------------------------
    -- Crush Menu
    ------------------------------

    local crush = {
        loop = false,
        speed = 270,
        vehicle_type = 0,
        delay = 250,
        height = 10,
        visible = true
    }

    local function _crush()
        local vehicle_type <const> = vehicle_types[crush.vehicle_type]
        local vehicle_name <const> = vehicle_type.name
        local player_pos <const> = players.get_position(player_id)
        local vehicle_hash <const> = util.joaat(vehicle_name)
        local vehicle_pos <const> = v3.new(player_pos.x, player_pos.y, player_pos.z + crush.height)

        request_model(vehicle_hash)

        local vehicle <const> = entities.create_vehicle(vehicle_hash, vehicle_pos, 0)

        if not crush.visible then
            ENTITY.SET_ENTITY_VISIBLE(vehicle, false, false)
        end

        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -crush.speed * 3.6)
    end

    menu.divider(net_lists["Crush"], "Crush")

    menu.action(net_lists["Crush"], "Crush", {"crush"}, "", function()
        _crush()
    end)

    menu.toggle(net_lists["Crush"], "Crush Loop", {"crushloop"}, "", function(state)
        crush.loop = state

        while crush.loop and players.exists(player_id) do
            _crush()
            util.yield(crush.delay)
        end
    end)

    menu.slider(net_lists["Crush"], "Crush Speed", {"crushspeed"}, "", 1, 540, 270, 20, function(value)
        crush.speed = value
    end)

    menu.list_select(net_lists["Crush"], "Crush Vehicle", {"vehicletype"}, "", vehicle_types, 0, function(value)
        crush.vehicle_type = value
    end)

    local crush_other_net_list <const> = menu.list(net_lists["Crush"], "Other Settings")

    menu.slider(crush_other_net_list, "Crush Delay", {"crushdelay"}, "", 50, 1000, 250, 50, function(value)
        crush.delay = value
    end)

    menu.slider(crush_other_net_list, "Crush Height", {"crushheight"}, "", 5, 50, 10, 1, function(value)
        crush.height = value
    end)

    menu.toggle(crush_other_net_list, "Crush Visible", {"crushvisible"}, "", function(state)
        crush.visible = state
    end, true)

    ------------------------------
    -- Ram Menu
    ------------------------------

    local ram = {
        loop = false,
        speed = 540,
        vehicle_type = 0,
        delay = 250,
        distance = 5,
        visible = true
    }

    local function _ram()
        local vehicle_type <const> = vehicle_types[ram.vehicle_type]
        local vehicle_name <const> = vehicle_type.name
        local player_pos <const> = players.get_position(player_id)
        local vehicle_pos <const> = get_random_pos_on_radius(player_pos, ram.distance)
        local vehicle_hash <const> = util.joaat(vehicle_name)
        local heading <const> = v3.lookAt(vehicle_pos, player_pos).z

        request_model(vehicle_hash)

        local vehicle <const> = entities.create_vehicle(vehicle_hash, vehicle_pos, heading)

        if not ram.visible then
            ENTITY.SET_ENTITY_VISIBLE(vehicle, false, false)
        end

        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ram.speed / 3.6)
    end

    menu.divider(net_lists["Ram"], "Ram")

    menu.action(net_lists["Ram"], "Ram", {"ram"}, "", function()
        _ram()
    end)

    menu.toggle(net_lists["Ram"], "Ram Loop", {"ramloop"}, "", function(state)
        ram.loop = state

        while ram.loop and players.exists(player_id) do
            _ram()
            util.yield(ram.delay)
        end
    end)

    menu.slider(net_lists["Ram"], "Ram Speed", {"ramspeed"}, "", 1, 540, 270, 20, function(value)
        ram.speed = value
    end)

    menu.list_select(net_lists["Ram"], "Ram Vehicle", {"ramtype"}, "", vehicle_types, 0, function(value)
        ram.vehicle_type = value
    end)

    local ram_other_net_list <const> = menu.list(net_lists["Ram"], "Other Settings")

    menu.slider(ram_other_net_list, "Ram Delay", {"ramdelay"}, "", 50, 1000, 250, 50, function(value)
        crush.delay = value
    end)

    menu.slider(ram_other_net_list, "Ram Distance", {"ramdistance"}, "", 5, 50, 10, 1, function(value)
        ram.distance = value
    end)

    menu.toggle(ram_other_net_list, "Ram Visible", {"ramvisible"}, "", function(state)
        ram.visible = state
    end, true)

    ------------------------------
    -- Net Aura Menu
    ------------------------------

    local net_aura = {
        is_enabled = false,
        range = 20,
        range_command_on_focus = false,
        vehicle_type = 0,
        ped_type = 0,
        ignore_vehicles = false,
        ignore_peds = false,
        ignore_player_vehicles = true
    }

    menu.divider(net_lists["Aura"], "Aura")

    menu.toggle(net_lists["Aura"], "Aura", {"netaura"}, "", function(state)
        net_aura.is_enabled = state

        while net_aura.is_enabled and players.exists(player_id) do
            local targets = {}
            local player_pos <const> = players.get_position(player_id)

            if not net_aura.ignore_vehicles then
                local vehicles <const> = get_vehicles_in_range(player_pos, net_aura.range, net_aura.ignore_player_vehicles)

                for i = 1, #vehicles do
                    table.insert(targets, vehicles[i])
                end
            end

            if not net_aura.ignore_peds then
                local peds <const> = get_peds_in_range(player_pos, net_aura.range, true)

                for i = 1, #peds do
                    table.insert(targets, peds[i])
                end
            end

            for i, target in pairs(targets) do
                target = entities.pointer_to_handle(target)
                local entity_type <const> = ENTITY.GET_ENTITY_TYPE(target)
                local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
                local is_entity_dead <const> = ENTITY.IS_ENTITY_DEAD(target, false)
                local target_pos <const> = ENTITY.GET_ENTITY_COORDS(target, false)
                local is_ped_in_vehicle <const> = PED.IS_PED_IN_ANY_VEHICLE(target, false)

                if (entity_type == 2) and not (player_vehicle == target) then
                    local vehicle_health <const> = VEHICLE.GET_VEHICLE_ENGINE_HEALTH(target)
                    local is_vehicle_engine_running <const> = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(target)

                    pluto_switch net_aura.vehicle_type do
                        case 0:
                            if not is_entity_dead then
                                FIRE.ADD_EXPLOSION(
                                    target_pos.x, target_pos.y, target_pos.z,
                                    0, 1, true, false, 1, false
                                )
                            end
                            break
                        case 1:
                            if not is_entity_dead and not (vehicle_health <= 0) then
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(target, -80)
                            end
                            break
                        case 2:
                            if is_vehicle_engine_running then
                                FIRE.ADD_EXPLOSION(
                                    target_pos.x, target_pos.y, target_pos.z,
                                    65, 1, false, true, 0, false
                                )
                            end
                            break
                        case 3:
                            entities.delete_by_handle(target)
                            break
                        pluto_default:
                            break
                    end
                end

                if (entity_type == 1) and not (player_ped == target) and not is_ped_in_vehicle then
                    local is_ped_burning <const> = FIRE.IS_ENTITY_ON_FIRE(target)
                    local is_ped_stunned <const> = PED.IS_PED_BEING_STUNNED(target, false)
                    local stungun_hash <const> = util.joaat("weapon_stungun")

                    pluto_switch net_aura.ped_type do
                        case 0:
                            if not is_entity_dead then
                                FIRE.ADD_EXPLOSION(
                                    target_pos.x, target_pos.y, target_pos.z,
                                    0, 1, true, false, 1, false
                                )
                            end
                            break
                        case 1:
                            if not is_entity_dead and not is_ped_burning then
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                                FIRE.START_ENTITY_FIRE(target)
                            end
                            break
                        case 2:
                            if not is_entity_dead and not is_ped_stunned then
                                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                                    target_pos.x, target_pos.y, target_pos.z + 1,
                                    target_pos.x, target_pos.y, target_pos.z,
                                    0, 0, stungun_hash, player_id, false, true, 1
                                )
                            end
                            break
                        case 3:
                            entities.delete_by_handle(target)
                            break
                        pluto_default:
                            break
                    end
                end
            end
            util.yield(10)
        end
    end)

    local aura_range_command_net = menu.slider(net_lists["Aura"], "Aura Range", {"netaurarange"}, "", 5, 100, 20, 5, function(value)
        net_aura.range = value
    end)

    menu.on_focus(aura_range_command_net, function()
        net_aura.range_command_on_focus = true

        util.create_tick_handler(function()
            local player_pos <const> = players.get_position(player_id)
            local red <const>, green <const>, blue <const> = get_hud_colour()

            if not net_aura.range_command_on_focus then
                return false
            end

            GRAPHICS._DRAW_SPHERE(
                player_pos.x, player_pos.y, player_pos.z,
                net_aura.range,
                red, green, blue, 0.5
            )
        end)
    end)

    menu.on_blur(aura_range_command_net, function()
        net_aura.range_command_on_focus = false
    end)

    menu.list_select(net_lists["Aura"], "Aura Vehicle Type", {"netauravehicletype"}, "", aura_vehicle_types, 0, function(value)
        net_aura.vehicle_type = value
    end)

    menu.list_select(net_lists["Aura"], "Aura Ped Type", {"netaurapedtype"}, "", aura_ped_types, 0, function(value)
        net_aura.ped_type = value
    end)

    local aura_ignores_net_list <const> = menu.list(net_lists["Aura"], "Aura Ignores")

    menu.toggle(aura_ignores_net_list, "Ignore Vehicles", {"netauranovehicles"}, "", function(state)
        net_aura.ignore_vehicles = state
    end)

    menu.toggle(aura_ignores_net_list, "Ignore Peds", {"netauranopeds"}, "", function(state)
        net_aura.ignore_peds = state
    end)

    menu.toggle(aura_ignores_net_list, "Ignore Player Vehicles", {"netauranoplayervehicles"}, "", function(state)
        net_aura.ignore_player_vehicles = state
    end, true)

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
        ignore_player_vehicles = true
    }

    menu.divider(net_lists["Forcefield"], "Forcefield")

    menu.toggle( net_lists["Forcefield"], "Forcefield", {"forcefield"}, "", function(state)
        net_forcefield.is_enabled = state

        while net_forcefield.is_enabled and players.exists(player_id) do
            local player_pos <const> = players.get_position(player_id)
            local targets = {}

            if not net_forcefield.ignore_vehicles then
                local vehicles <const> = get_vehicles_in_range(player_pos, net_forcefield.range, net_forcefield.ignore_player_vehicles)

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
                local player_ped <const> = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local is_control_given <const> = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(target)
                local player_vehicle <const> = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
                local entity_type <const> = ENTITY.GET_ENTITY_TYPE(target)

                if is_control_given and not (player_vehicle == target)  then
                    local force = ENTITY.GET_ENTITY_COORDS(target)

                    v3.sub(force, player_pos)
                    v3.normalise(force)
                    v3.mul(force, net_forcefield.multiplier)

                    if (net_forcefield.type == 1) then
                        v3.mul(force, -1)
                    end

                    if (entity_type == 1) then
                        PED.SET_PED_TO_RAGDOLL(
                            target, 500, 0, 0,
                            false, false, false
                        )
                    end

                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        target, 3,
                        force.x, force.y, force.z,
                        0, 0, 0.5, 0,
                        false, false, true, false, false
                    )
                end
            end
            util.yield(10)
        end
    end)

    local forcefield_range_command_net = menu.slider(net_lists["Forcefield"], "Forcefield Range", {"netforcefieldrange"}, "", 5, 100, 20, 5, function(value)
        net_forcefield.range = value
    end)

    menu.on_focus(forcefield_range_command_net, function()
        net_forcefield.range_command_on_focus = true

        util.create_tick_handler(function()
            local player_pos <const> = players.get_position(player_id)
            local red <const>, green <const>, blue <const> = get_hud_colour()

            if not net_forcefield.range_command_on_focus then
                return false
            end

            GRAPHICS._DRAW_SPHERE(
                player_pos.x, player_pos.y, player_pos.z,
                net_forcefield.range,
                red, green, blue, 0.5
            )
        end)
    end)

    menu.on_blur(forcefield_range_command_net, function()
        net_forcefield.range_command_on_focus = false
    end)

    menu.slider_float(net_lists["Forcefield"], "Forcefield Multiplier", {"netforcefieldmultiplier"}, "", 10, 1000, 100, 10, function(value)
        net_forcefield.multiplier = value * 0.01
    end)

    menu.list_select(net_lists["Forcefield"], "Forcefield Type", {"netforcefieldtype"}, "", forcefield_types, 0, function(value)
        net_forcefield.type = value
    end)

    local forcefield_ignores_net_list <const> = menu.list(net_lists["Forcefield"], "Forcefield Ignores")
    menu.divider(forcefield_ignores_net_list, "Forcefield Ignores")

    menu.toggle(forcefield_ignores_net_list, "Ignore Vehicles", {"netforcefieldnovehicles"}, "", function(state)
        net_forcefield.ignore_vehicles = state
    end)

    menu.toggle(forcefield_ignores_net_list, "Ignore Peds", {"netforcefieldnopeds"}, "", function(state)
        net_forcefield.ignore_peds = state
    end)

    menu.toggle(forcefield_ignores_net_list, "Ignore Player Vehicles", {"netforcefieldnoplayervehicles"}, "", function(state)
        net_forcefield.ignore_player_vehicles = state
    end, true)

    ------------------------------
    -- Fake Pickup Menu
    ------------------------------

    local fake_pickup = {
        loop = false,
        type = 0,
        delay = 100
    }

    local function spawn_fake_pickup()
        util.create_thread(function()
            local objects <const> = fake_pickup_types[fake_pickup.type].objects
            local pickup_hash <const> = util.joaat(objects[math.random(1, #objects)])
            local player_pos = players.get_position(player_id)
            local pickup_pos = v3.new(player_pos.x, player_pos.y, player_pos.z + 2.25)
            local pickup_sound <const> = "Bus_Schedule_Pickup"
            local pickup_sound_ref <const> = "DLC_PRISON_BREAK_HEIST_SOUNDS"

            request_model(pickup_hash)

            local pickup <const> = entities.create_object(pickup_hash, pickup_pos)

            ENTITY.SET_ENTITY_COLLISION(pickup, false, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
                pickup, 1, 0, 0, 0,
                true, false, true, true
            )

            repeat
                player_pos = players.get_position(player_id)
                pickup_pos = ENTITY.GET_ENTITY_COORDS(pickup, false)
                local is_height_reached = pickup_pos.z <= player_pos.z + 1.25

                util.yield(10)
            until is_height_reached

            AUDIO.PLAY_SOUND_FROM_COORD(
                -1, pickup_sound,
                player_pos.x, player_pos.y, player_pos.z,
                pickup_sound_ref, true, 1, false
            )
            entities.delete_by_handle(pickup)

            util.stop_thread()
        end)
    end

    menu.divider(net_lists["Fake Pickup"], "Fake Pickup")

    menu.action(net_lists["Fake Pickup"], "Drop Fake Pickup", {"dropfakepickup"}, "", function()
        spawn_fake_pickup()
    end)

    menu.toggle(net_lists["Fake Pickup"], "Drop Fake Pickup Loop", {"dropfakepickuploop"}, "", function(state)
        fake_pickup.loop = state

        while fake_pickup.loop and players.exists(player_id) do
            spawn_fake_pickup()

            util.yield(fake_pickup.delay)
        end
    end)

    menu.list_select(net_lists["Fake Pickup"], "Fake Pickup Type", {"fakepickuptype"}, "", fake_pickup_types, 0, function(value)
        fake_pickup.type = value
    end)

    local fake_pickup_other_net_list <const> = menu.list(net_lists["Fake Pickup"], "Other Settings")

    menu.slider(fake_pickup_other_net_list, "Fake Pickup Delay", {"fakepickupdelay"}, "", 50, 1000, 100, 50, function(value)
        fake_pickup.delay = value
    end)
end)

players.dispatch_on_join()