util.require_natives(1660775568)
util.keep_running()

local script_version = 0.1
util.toast("Welcome To SaltyScript!\n" .. "Hope you'll enjoy. :)")
async_http.init("raw.githubusercontent.com", "/SmileFaceStand/SaltyScript/main/version.txt", function(output)
    local latest_version = tonumber(output)
    if script_version ~= latest_version then
        util.toast("SaltyScript is outdated. Version " .. output .. " is available.")
    end
end)

local function random_float(min, max)
	return min + math.random() * (max - min)
end

local function get_hud_colour()
    local red_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Red")
    local green_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Green")
    local blue_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Blue")
    local alpha_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Opacity")
    local red = menu.get_value(red_colour_ref)
    local green = menu.get_value(green_colour_ref)
    local blue = menu.get_value(blue_colour_ref)
    local alpha = menu.get_value(alpha_colour_ref)
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

local function kick_player_out_of_veh(player_id)
    local max_time = os.millis() + 1000
    local player_ped  = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
    local kick_vehicle_ref = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Kick From Vehicle")
    menu.trigger_command(kick_vehicle_ref)

    while PED.IS_PED_IN_ANY_VEHICLE(player_ped) do
        if os.millis() >= max_time then
            break
        end

        util.yield()
    end
end

local function get_random_pos_on_radius(pos, radius)
    local angle = random_float(0, 2 * math.pi)
    pos = v3.new(pos.x + math.cos(angle) * radius, pos.y + math.sin(angle) * radius, pos.z)
    return pos
end

local self = menu.list(menu.my_root(), "Self")
local appearance = menu.list(menu.my_root(), "Appearance")
local weapons = menu.list(menu.my_root(), "Weapons")
local world = menu.list(menu.my_root(), "World")

--##############################################################
--                             Self
--##############################################################

----------------
-- Health
----------------

-- Buttons
menu.divider(self, "Health")

menu.slider(self, "Max Health", {"maxhealth"}, "The max health of a player with a level greater than 100 is 328.", 1, 5000, 328, 1, function(value)
    PED.SET_PED_MAX_HEALTH(players.user_ped(), value)
end)

menu.action(self, "Refill Health", {"refillhealth"}, "", function()
    local max_health = PED.GET_PED_MAX_HEALTH(players.user_ped())
    ENTITY.SET_ENTITY_HEALTH(players.user_ped(), max_health)
end)

menu.action(self, "Refill Armour", {"refillarmour"}, "", function()
    PED.SET_PED_ARMOUR(players.user_ped(), 50)
end)

--##############################################################
--                          Appearance
--##############################################################

----------------
-- Disguise
----------------

-- Variables
local disguise_object = 0
local disguise_objects = {
    [0] = "prop_bush_med_03",
    [1] = "prop_tree_lficus_06",
    [2] = "prop_palm_fan_03_b",
    [3] = "prop_streetlight_01",
    [4] = "prop_recyclebin_04_b" -- Good to clip the player under the terrain
}
local disguise_names = {
    [0] = "Bush",
    [1] = "Tree",
    [2] = "Palm Tree",
    [3] = "Street Light",
    [4] = "Recycle Bin"
}

-- Buttons
menu.divider(appearance, "Disguise")

local disguise_state
menu.toggle(appearance, "Disguise", {"disguise"}, "", function(state)
    disguise_state = state

    if disguise_state then
        local invisibility_select = menu.ref_by_path("Self>Appearance>Invisibility")
        local object_hash = util.joaat(disguise_objects[disguise_object])
        local player_pos = players.get_position(players.user())
        request_model(object_hash)
        local object = entities.create_object(object_hash, player_pos)
        menu.set_value(invisibility_select, 2)
        ENTITY.SET_ENTITY_COLLISION(object, false, false)

        while disguise_state and players.exists(players.user()) do
            player_pos = players.get_position(players.user())
            local player_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 5)
            ENTITY.SET_ENTITY_COORDS(object, player_pos.x, player_pos.y, player_pos.z - 1, false, false, false, false)
            ENTITY.SET_ENTITY_ROTATION(object, 0, 0, player_rot.z, false, false, false, false)
            util.yield()
        end

        entities.delete_by_handle(object)
        menu.set_value(invisibility_select, 0)
    end
end)

local disguise_object_slider = menu.slider_text(
    appearance, "Disguise Object", {"disguiseobject"}, "", disguise_names, function()end
)

util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    disguise_object = menu.get_value(disguise_object_slider)
end)

----------------
-- Others
----------------

-- Buttons
menu.divider(appearance, "Others")

menu.slider(appearance, "Transparency", {"transparency"}, "", 0, 100, 100, 20, function(value)
    if value > 80 then
        ENTITY.RESET_ENTITY_ALPHA(players.user_ped())
    else
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), value * 2.55, false)
    end
end)

menu.toggle(appearance, "Disable Footsteps", {"disablefootsteps"}, "", function(state)
    AUDIO._SET_PED_AUDIO_FOOTSTEP_LOUD(players.user_ped(), not state)
end)

--##############################################################
--                            Weapons
--##############################################################

----------------
-- Actions (IN DEVELOPMENT)
----------------

-- Variables
local action = 0
local actions = {
    [0] = "Waypoint",
    [1] = "Freeze",
    [2] = "Cage",
    [3] = "Kick",
    [4] = "Crash"
}

----------------
-- Others
----------------

-- Buttons
menu.divider(weapons, "Others")

menu.toggle_loop(weapons, "Autoload Weapons", {"autoloadweapons"}, "Autoload all the weapons everytime you join a new session.", function()
    players.on_join(function(player_id)
        local my_player_id = players.user()

        if player_id == my_player_id then
            local all_weapons_ref = menu.ref_by_path("Self>Weapons>Get Weapons>All Weapons")

            while util.is_session_transition_active() do
                util.yield()
            end

            menu.trigger_command(all_weapons_ref)
            util.toast("Weapons loaded successfully. :)")
        end
    end)
end)

--##############################################################
--                            World
--##############################################################

----------------
-- Forcefield
----------------

-- Variables
local s_forcefield_range = 20
local s_forcefield = 0
local s_forcefield_names = {
    [0] = "Push",
    [1] = "Launch",
    [2] = "Pull"
}

--Buttons
menu.divider(world, "Forcefield")

menu.toggle_loop(world, "Forcefield", {"sforcefield"}, "", function()
    if players.exists(players.user()) then
        local _entities = {}
        local player_pos = players.get_position(players.user())

        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                table.insert(_entities, ped)
            end
        end
        for _, entity in pairs(_entities) do
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

            if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
                if entity_type == 1 then
                    PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                end
                if s_forcefield == 1 then
                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                else
                    local force = ENTITY.GET_ENTITY_COORDS(entity)
                    v3.sub(force, player_pos)
                    v3.normalise(force)

                    if s_forcefield == 2 then
                        v3.mul(force, -1)
                    end

                    ENTITY.APPLY_FORCE_TO_ENTITY(
                        entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                    )
                end
            end
        end
    end
end)

local s_forcefield_direction_slider = menu.slider_text(
    world, "Forcefield Direction", {"sforcefieldirection"}, "", s_forcefield_names, function()end
)

util.create_tick_handler(function()
    if not players.exists(players.user()) then
        return false
    end

    s_forcefield = menu.get_value(s_forcefield_direction_slider)
end)

local s_forcefield_range_slider = menu.slider_float(
    world, "Forcefield Range", {"sforcefieldrange"}, "", 100, 10000, 2000, 10, function(value)
        s_forcefield_range = value/100
end)

local s_forcefield_range_on_focus
menu.on_focus(s_forcefield_range_slider, function()
    s_forcefield_range_on_focus = true

    util.create_tick_handler(function()
        local player_pos = players.get_position(players.user())
        local red, green, blue = get_hud_colour()

        if not s_forcefield_range_on_focus then
            return false
        end

        GRAPHICS._DRAW_SPHERE(player_pos.x, player_pos.y, player_pos.z, s_forcefield_range, red, green, blue, 0.5)
    end)
end)

menu.on_blur(s_forcefield_range_slider, function()
    s_forcefield_range_on_focus = false
end)

--##############################################################
--                             Misc
--##############################################################

----------------
-- Misc
----------------

-- Buttons
menu.divider(menu.my_root(), "Misc")

menu.hyperlink(menu.my_root(), "GitHub", "", "https://github.com/SmileFaceStand/SaltyScript", "")
menu.hyperlink(menu.my_root(), "Discord", "", "https://discord.gg/rejQB9jHQf", "")
menu.readonly(menu.my_root(), "Developer", "SmileFace")

players.on_join(function(player_id)
    menu.divider(menu.player_root(player_id), "SaltyScript")
    local malicious = menu.list(menu.player_root(player_id), "Malicious")
    local trolling = menu.list(menu.player_root(player_id), "Trolling")

    --##############################################################
    --                          Malicious
    --##############################################################

    ----------------
    -- Explosions
    ----------------

    -- Variables
    local explosion = 18
    local explosions = {
        [0] = 18,
        [1] = 0,
        [2] = 34,
        [3] = 82
    }
    local explosion_names = {
        [0] = "Small",
        [1] = "Medium",
        [2] = "Big",
        [3] = "Huge"
    }

    -- Buttons
    menu.divider(malicious, "Explosions")

    local explode_slider = menu.slider_text(malicious, "Explode", {"customexplode"}, "", explosion_names, function()
        local player_pos = players.get_position(player_id)
        FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z, explosion, 1, true, false, 1, false)
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        explosion = explosions[menu.get_value(explode_slider)]
    end)

    menu.toggle_loop(malicious, "Explode Loop", {"customexplodeloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z, explosion, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    menu.toggle_loop(malicious, "Atomize Loop", {"atomizeloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 70, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    menu.toggle_loop(malicious, "Firework Loop", {"fireworkloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 38, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    ----------------
    -- Flushes
    ----------------

    -- Buttons
    menu.divider(malicious, "Flushes")

    menu.toggle_loop(malicious, "Flame Loop", {"flameloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 12, 1, true, false, 1, false)
            util.yield()
        end
    end)

    menu.toggle_loop(malicious, "Water Loop", {"waterloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 13, 1, true, false, 1, false)
            util.yield()
        end
    end)

    ----------------
    -- Earrape
    ----------------

    -- Variables
    local sound = 0
    local sound_names = {
        [0] = "Wasted",
        [1] = "Low Pitched",
        [2] = "High Pitched",
        [3] = "Anxious",
        [4] = "Alien",
    }
    local sounds = {
        [0] = {
            sound = "Bed",
            sound_ref = "WastedSounds"
        },
        [1] = {
            sound = "Short_Transition_In",
            sound_ref = "PLAYER_SWITCH_CUSTOM_SOUNDSET"
        },
        [2] = {
            sound = "TIMER_STOP",
            sound_ref = "HUD_MINI_GAME_SOUNDSET",
        },
        [3] = {
            sound = "CHECKPOINT_MISSED",
            sound_ref = "HUD_MINI_GAME_SOUNDSET"
        },
        [4] = {
            sound = "Goal",
            sound_ref = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
        },
        [5] = {
            sound = "Air_Defences_Activated",
            sound_ref = "DLC_sum20_Business_Battle_AC_Sounds"
        }
    }

    -- Functions
    local function earrape()
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, sounds[sound].sound, player_ped, sounds[sound].sound_ref, true, true)
    end

    -- Buttons
    menu.divider(malicious, "Earrape")

    local earrape_slider = menu.slider_text(malicious, "Earrape", {"earrape"}, "", sound_names, function()
        earrape()
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        sound = menu.get_value(earrape_slider)
    end)

    menu.toggle_loop(malicious, "Earrape Loop", {"earrapeloop"}, "", function()
        if players.exists(player_id) then
            earrape()
        end
    end)

    ----------------
    -- Damage
    ----------------

    -- Buttons
    menu.divider(malicious, "Damage")

    menu.action(malicious, "Shoot", {"shoot"}, "Only works when you are close to the player.", function()
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x796e)
        local bone_pos = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(player_ped, bone_index)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            bone_pos.x, bone_pos.y, bone_pos.z + 0.5, bone_pos.x, bone_pos.y, bone_pos.z,
            100, true, 453432689, players.user_ped(), false, true, 1
        )
    end)

    menu.toggle_loop(malicious, "Shoot Loop", {"shootloop"}, "Only works when you are close to the player.", function()
        if players.exists(player_id) then
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x796e)
            local bone_pos = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(player_ped, bone_index)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                bone_pos.x, bone_pos.y, bone_pos.z + 0.5, bone_pos.x, bone_pos.y, bone_pos.z,
                100, true, 453432689, players.user_ped(), false, true, 1
            )
        end
    end)

    menu.toggle_loop(malicious, "Molotov Loop", {"molotovloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 3, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    ----------------
    -- Others
    ----------------

    -- Buttons
    menu.divider(malicious, "Others")

    menu.toggle_loop(malicious, "Lag", {"lag"}, "Automatically freezes the player to make it work properly.", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_respray_smoke", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end)

    --##############################################################
    --                           Trolling
    --##############################################################

    ----------------
    -- Cages
    ----------------

    -- Variables
    local cage = 0
    local cage_invisible = false
    local cage_failed
    local cage_ids = {}
    local cage_names = {
        [0] = "Standard",
        [1] = "Tall",
        [2] = "Box",
        [3] = "Pipe",
        [4] = "Stunt Tube"
    }
    local cages = {
        [0] = {
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

    -- Functions
    local function add_cage()
        cage_failed = false
        local objects = cages[cage].objects

        for i, object in ipairs(objects) do
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local cage_hash = util.joaat(object.name)
            request_model(cage_hash)

            if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
                kick_player_out_of_veh(player_id)
                if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
                    cage_failed = true
                    break
                end
            end

            local player_pos = players.get_position(player_id)
            local entity_pos = player_pos
            v3.add(entity_pos, object.offset)
            local cage_object = entities.create_object(cage_hash, entity_pos)
            table.insert(cage_ids, cage_object)
            ENTITY.SET_ENTITY_ROTATION(cage_object, object.rot.x, object.rot.y, object.rot.z, 1, true)
            ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)

            if cage_invisible then
                ENTITY.SET_ENTITY_VISIBLE(cage_object, false, false)
            end
        end

        if cage_failed then
            util.toast("Failed to cage the player. :/")
        end
    end

    local function remove_cage()
        if not cage_failed then
            for i, cage_id in pairs(cage_ids) do
                entities.delete_by_handle(cage_id)
            end
            for cage_id in pairs(cage_ids) do
                cage_ids[cage_id] = nil
            end
        end
    end

    -- Buttons
    menu.divider(trolling, "Cages")

    local cage_slider = menu.slider_text(trolling, "Cage", {"cage"}, "", cage_names, function()
        add_cage()
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        cage = menu.get_value(cage_slider)
    end)

    local auto_cage_state
    menu.toggle(trolling, "Auto Cage", {"autocage"}, "", function(state)
        auto_cage_state = state

        while auto_cage_state and players.exists(player_id) do
            add_cage()
            local player_pos = players.get_position(player_id)
            local first_player_pos = player_pos

            while auto_cage_state and players.exists(player_id) do
                player_pos = players.get_position(player_id)
                local distance = v3.distance(first_player_pos, player_pos)
                local max_distance = cages[cage].max_distance

                if distance >= max_distance then
                    remove_cage()
                    util.toast("Player re-caged successfully. :)")
                    break
                end

                util.yield()
            end
        end
    end)

    menu.toggle(trolling, "Cage Invisible", {"cageinvisible"}, "", function(state)
        cage_invisible = state
    end)

    menu.action(trolling, "Uncage", {"uncage"}, "", function()
        remove_cage()
        util.toast("Player uncaged successfully. :)")
    end)

    ----------------
    -- Ram
    ----------------

    -- Variables
    local ram_direction = 0
    local ram_directions = {
        [0] = "Horizontal",
        [1] = "Vertical"
    }
    local vehicle_invisible = false
    local vehicle = "faggio"
    local vehicles = {
        [0] = "faggio",
        [1] = "adder",
        [2] = "insurgent",
        [3] = "rallytruck",
        [4] = "phantom2",
        [5] = "howard",
        [6] = "buzzard2",
        [7] = "bus"
    }
    local vehicle_names = {
        [0] = "Faggio",
        [1] = "Adder",
        [2] = "Insurgent",
        [3] = "Rally Truck",
        [4] = "Phantom Wedge",
        [5] = "Howard",
        [6] = "Buzzard",
        [7] = "Bus"
    }

    -- Buttons
    menu.divider(trolling, "Ram")

    local ram_slider = menu.slider_text(trolling, "Ram", {"ram"}, "Howard and Buzzard explode on impact.", vehicle_names, function()
        local player_pos = players.get_position(player_id)
        local vehicle_hash = util.joaat(vehicle)
        request_model(vehicle_hash)

        if ram_direction == 0 then
            local vehicle_pos = get_random_pos_on_radius(player_pos, 5)
            local heading = v3.lookAt(vehicle_pos, player_pos).z
            local vehicle = entities.create_vehicle(vehicle_hash, vehicle_pos, heading)
            ENTITY.SET_ENTITY_VISIBLE(vehicle, not vehicle_invisible, false)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 150)
        else
            local vehicle_pos = v3.new(player_pos.x, player_pos.y, player_pos.z + 5)
            local vehicle = entities.create_vehicle(vehicle_hash, vehicle_pos, 0)
            ENTITY.SET_ENTITY_VISIBLE(vehicle, not vehicle_invisible, false)
            ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -150)
        end
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        vehicle = vehicles[menu.get_value(ram_slider)]
    end)

    local ram_direction_slider = menu.slider_text(
        trolling, "Ram Direction", {"ramdirection"}, "", ram_directions, function()end
    )

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        ram_direction = menu.get_value(ram_direction_slider)
    end)

    menu.toggle(trolling, "Ram Invisible", {"raminvisible"}, "", function(state)
        vehicle_invisible = state
    end)

    ----------------
    -- Forcefield
    ----------------

    -- Variables
    local forcefield_range = 20
    local forcefield = 0
    local forcefield_names = {
        [0] = "Push",
        [1] = "Launch",
        [2] = "Pull"
    }

    --Buttons
    menu.divider(trolling, "Forcefield")

    menu.toggle_loop(trolling, "Forcefield", {"forcefield"}, "", function()
        if players.exists(player_id) then
            local _entities = {}
            local player_pos = players.get_position(player_id)

            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
                if v3.distance(player_pos, vehicle_pos) <= forcefield_range then
                    table.insert(_entities, vehicle)
                end
            end
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
                if (v3.distance(player_pos, ped_pos) <= forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                    table.insert(_entities, ped)
                end
            end
            for _, entity in pairs(_entities) do
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, true)
                local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

                if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and player_vehicle ~= entity then
                    if entity_type == 1 then
                        PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                    end
                    if forcefield == 1 then
                        ENTITY.APPLY_FORCE_TO_ENTITY(
                            entity, 3, 0, 0, 1, 0, 0, 0.5, 0, false, false, true, false, false
                        )
                    else
                        local force = ENTITY.GET_ENTITY_COORDS(entity)
                        v3.sub(force, player_pos)
                        v3.normalise(force)

                        if forcefield == 2 then
                            v3.mul(force, -1)
                        end

                        ENTITY.APPLY_FORCE_TO_ENTITY(
                            entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                        )
                    end
                end
            end
        end
    end)

    local forcefield_direction_slider = menu.slider_text(
        trolling, "Forcefield Direction", {"forcefieldirection"}, "", forcefield_names, function()end
    )

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        forcefield = menu.get_value(forcefield_direction_slider)
    end)

    local forcefield_range_slider = menu.slider_float(
        trolling, "Forcefield Range", {"forcefieldrange"}, "", 100, 10000, 2000, 10, function(value)
            forcefield_range = value/100
    end)

    local forcefield_range_on_focus
    menu.on_focus(forcefield_range_slider, function()
        forcefield_range_on_focus = true

        util.create_tick_handler(function()
            local player_pos = players.get_position(player_id)
            local red, green, blue = get_hud_colour()

            if not forcefield_range_on_focus then
                return false
            end

            GRAPHICS._DRAW_SPHERE(player_pos.x, player_pos.y, player_pos.z, forcefield_range, red, green, blue, 0.5)
        end)
    end)

    menu.on_blur(forcefield_range_slider, function()
        forcefield_range_on_focus = false
    end)

    ----------------
    -- Fake Pickup
    ----------------

    -- Variables
    local fake_pickup = 0
    local fake_pickup_names = {
        [0] = "Money Bag",
        [1] = "Action Figure",
        [2] = "P's & Q's"
    }
    local fake_pickups = {
        [0] = {
            "p_poly_bag_01_s"
        },
        [1] = {
            "vw_prop_vw_colle_alien",
            "vw_prop_vw_colle_beast",
            "vw_prop_vw_colle_imporage",
            "vw_prop_vw_colle_pogo",
            "vw_prop_vw_colle_prbubble",
            "vw_prop_vw_colle_rsrcomm",
            "vw_prop_vw_colle_rsrgeneric",
            "vw_prop_vw_colle_sasquatch"
        },
        [2] = {
            "prop_choc_pq"
        },
    }

    -- Functions
    local function _fake_pickup()
        util.create_tick_handler(function()
            local objects = fake_pickups[fake_pickup]
            local pickup_hash = util.joaat(objects[math.random(1, #objects)])
            local player_pos = players.get_position(player_id)
            local pickup_pos = v3.new(player_pos.x, player_pos.y, player_pos.z + 2.25)
            local pickup_sound = "Bus_Schedule_Pickup"
            local pickup_sound_ref = "DLC_PRISON_BREAK_HEIST_SOUNDS"
            request_model(pickup_hash)
            local pickup = entities.create_object(pickup_hash, pickup_pos)
            ENTITY.SET_ENTITY_COLLISION(pickup, false, true)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
                pickup, 1, 0, 0, 0,
                true, false, true, true
            )

            repeat
                player_pos = players.get_position(player_id)
                pickup_pos = ENTITY.GET_ENTITY_COORDS(pickup, false)
                local is_height_reached = pickup_pos.z <= player_pos.z + 1.25

                util.yield()
            until is_height_reached

            AUDIO.PLAY_SOUND_FROM_COORD(
                -1, pickup_sound, player_pos.x, player_pos.y, player_pos.z, pickup_sound_ref, true, 1, false
            )
            entities.delete_by_handle(pickup)
            return false
        end)
    end

    -- Buttons
    menu.divider(trolling, "Fake Pickup")

    local fake_pickup_slider = menu.slider_text(trolling, "Fake Pickup", {"fakepickup"}, "", fake_pickup_names, function()
        _fake_pickup()
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        fake_pickup = menu.get_value(fake_pickup_slider)
    end)

    menu.toggle_loop(trolling, "Fake Pickup Loop", {"fakepickuploop"}, "", function()
        if players.exists(player_id) then
            _fake_pickup()
            util.yield(100)
        end
    end)

    ----------------
    -- Others
    ----------------

    -- Variables
    local ptfx_id

    -- Buttons
    menu.divider(trolling, "Others")

    menu.action(trolling, "Launch", {"launch"}, "", function()
        local player_pos = players.get_position(player_id)
        local vehicle_hash = util.joaat("adder")
        request_model(vehicle_hash)
        local vehicle = entities.create_vehicle(vehicle_hash, v3.new(player_pos.x, player_pos.y, player_pos.z - 10), 0)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, false, false)
        util.yield(250)
        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 150)
        util.yield(250)
        entities.delete_by_handle(vehicle)
    end)

    menu.toggle_loop(trolling, "Taser Loop", {"taserloop"}, "Only works when you are close to the player.", function()
        if players.exists(player_id) then
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x796e)
            local bone_pos = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(player_ped, bone_index)
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                bone_pos.x, bone_pos.y, bone_pos.z + 0.5, bone_pos.x, bone_pos.y, bone_pos.z,
                0, true, 911657153, players.user_ped(), false, true, 1
            )
            util.yield(1000)
        end
    end)

    menu.toggle(trolling, "Pee Loop", {"peeloop"}, "Works better when the player is frozen or still.", function(state)
        if state then
            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(
                "ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false
            )
        else
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)
        end
    end)

    menu.click_slider(trolling, "Increase Wanted Level", {"wantedlevel"}, "It may take a few seconds.", 1, 5, 1, 1, function(value)
        local max_time = os.millis() + 10000
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local player_info = memory.read_long(entities.handle_to_pointer(player_ped) + 0x10C8)
        local failed = false

        if memory.read_uint(player_info + 0x0888) >= value then
            util.toast("Wanted level is already " .. memory.read_uint(player_info + 0x0888) .. ". :)")
            return
        end

        while not (memory.read_uint(player_info + 0x0888) >= value) and players.exists(player_id) do
            local crime

            if os.millis() >= max_time then
                failed = true
                break
            end
            if value == 1 then
                crime = 28
            else
                crime = 14
            end

            PLAYER.REPORT_CRIME(player_id, crime, value)
            util.yield()
        end

        if failed then
            util.toast("Failed to increase wanted Level. :/")
        else
            util.toast("Wanted level increased successfully. :)")
        end
    end)
end)

players.dispatch_on_join()