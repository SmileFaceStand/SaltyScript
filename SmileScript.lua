--[[
Script created by (=#1000
Special thanks to all Lua Retards that helped me on Discord
Credits to nowiry for the Tall Cage
--]]
util.require_natives(1651208000)
util.keep_running()

--> General Variables <--
local self = {
    playerId = players.user(),
    playerPos = players.get_position(players.user()),
    pedId = players.user_ped()
}

local localSettings = {
    clearWorldPeds = true,
    clearWorldObjects = true,
    clearWorldVehicles = true,
    clearWorldExclPersVeh = false
}

local playerSettings = {}

local explosionTypes = {
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

local cageTypes = {
    [0] = {
        "Standard Cage",
        settings = {
            {name = "prop_gold_cont_01", offset = {x = 0, y = 0, z = 0}, rot = {x = 0, y = 0, z = 0}}
        },
        maxDist = 2
    },
    [1] = {
        "Tall Cage",
        settings = {
            {name = "prop_rub_cage01a", offset = {x = 0, y = 0, z = -1}, rot = {x = 0, y = 0, z = 0}},
            {name = "prop_rub_cage01a", offset = {x = 0, y = 0, z = 1.2}, rot = {x = -180, y = 0, z = 90}}
        },
        maxDist = 1.5
    },
    [2] = {
        "Box Cage",
        settings = {
            {name = "prop_ld_crate_01", offset = {x = 0, y = 0, z = 0}, rot = {x = -180, y = 90, z = 0}},
            {name = "prop_ld_crate_01", offset = {x = 0, y = 0, z = 0}, rot = {x = 0, y = 90, z = 0}}
        },
        maxDist = 1.5
    },
    [3] = {
        "Pipe Cage",
        settings = {
            {name = "prop_pipes_conc_01", offset = {x = 0, y = 0, z = 0}, rot = {x = 90, y = 0, z = 0}}
        },
        maxDist = 1.5
    },
    [4] = {
        "Stunt Tube Cage",
        settings = {
            {name = "stt_prop_stunt_tube_end", offset = {x = 0, y = 0, z = 0}, rot = {x = 0, y = -90, z = 0}}
        },
        maxDist = 13
    }
}

local entityTypes = {
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
 --

--[[
#################################################
 ----------------Local Functions----------------
#################################################
]] --> World Functions <--
local function clearWorld(clearWorldPeds, clearWorldObjects, clearWorldVehicles, clearWorldExclPersVeh)
    local count = 0

    if clearWorldPeds then
        for i, pedEntity in pairs(entities.get_all_peds_as_handles()) do
            if not PED.IS_PED_A_PLAYER(pedEntity) then
                entities.delete_by_handle(pedEntity)
            end

            count = count + 1
        end
    end

    if clearWorldObjects then
        for i, objEntity in pairs(entities.get_all_objects_as_handles()) do
            entities.delete_by_handle(objEntity)

            count = count + 1
        end
    end

    if clearWorldVehicles then
        for i, vehEntity in pairs(entities.get_all_vehicles_as_handles()) do
            if clearWorldExclPersVeh then
                if not entities.get_vehicle_has_been_owned_by_player(entities.handle_to_pointer(vehEntity)) then
                    entities.delete_by_handle(vehEntity)

                    count = count + 1
                end
            else
                entities.delete_by_handle(vehEntity)

                count = count + 1
            end
        end
    end

    return count
end
 --

--[[
#################################################
 ---------------Players Functions---------------
#################################################
]] --> Trolling Functions <--
local function setWantedLevel(playerId, wantedLevel)
    local playerInfo =
        memory.read_long(entities.handle_to_pointer(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)) + 0x10C8)

    while memory.read_uint(playerInfo + 0x0888) < wantedLevel do
        for i = 1, 46, 1 do
            PLAYER.REPORT_CRIME(playerId, i, wantedLevel)
        end
        util.yield(100)
    end
end

--> Explosions Functions <--
local function addExplosion(playerId, expType, expShake, expBlamed, expAudible, expVisible, expDamage)
    local playerX, playerY, playerZ = v3.get(players.get_position(playerId))
    local expInvisible = not expVisible
    local expNoDamage = not expDamage

    if expBlamed then
        FIRE.ADD_OWNED_EXPLOSION(
            self.pedId,
            playerX,
            playerY,
            playerZ,
            expType,
            1,
            expAudible,
            expInvisible,
            expShake,
            expNoDamage
        )
    else
        FIRE.ADD_EXPLOSION(playerX, playerY, playerZ, expType, 1, expAudible, expInvisible, expShake, expNoDamage)
    end
end

--> Particles Functions <--
local function startPtfx(playerId, ptfxIds, ptfxPower, ptfxSize, ptfxDict, ptfxName, ptfxLoop)
    local pedId = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)

    STREAMING.REQUEST_NAMED_PTFX_ASSET(ptfxDict)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(ptfxDict) do
        util.yield()
    end

    for i = 1, ptfxPower, 1 do
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxDict)
        local ptfxId =
            GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
            ptfxName,
            pedId,
            0,
            0,
            0,
            0,
            0,
            0,
            ptfxSize,
            false,
            false,
            false
        )
        table.insert(ptfxIds, ptfxId)
    end

    while (ptfxLoop) do
        if PLAYER.IS_PLAYER_DEAD(playerId) then
            while (PLAYER.IS_PLAYER_DEAD(playerId)) do
                util.yield(100)
            end
            for i, id in pairs(ptfxIds) do
                GRAPHICS.STOP_PARTICLE_FX_LOOPED(id, false)
            end
            for i = 1, ptfxPower, 1 do
                GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxDict)
                local ptfxId =
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
                    ptfxName,
                    pedId,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    ptfxSize,
                    false,
                    false,
                    false
                )
                table.insert(ptfxIds, ptfxId)
            end
        else
            util.yield(250)
        end
    end
end

local function removePtfx(ptfxIds)
    for i, id in pairs(ptfxIds) do
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(id, false)
    end
end

--> Cages Functions <--
local function createCage(
    playerId,
    cageName,
    cageIds,
    cageVisible,
    cageOfstX,
    cageOfstY,
    cageOfstZ,
    cageRotX,
    cageRotY,
    cageRotZ)
    local pedId = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)
    local cageHash = util.joaat(cageName)

    if PED.IS_PED_IN_ANY_VEHICLE(pedId, false) then
        menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(playerId))
        util.yield(250)

        if PED.IS_PED_IN_ANY_VEHICLE(pedId, false) then
            util.toast("Failed to kick the player from the vehicle. :/")
            return
        end
    end

    local pos = players.get_position(playerId)
    pos.x, pos.y, pos.z = pos.x + cageOfstX, pos.y + cageOfstY, pos.z + cageOfstZ

    STREAMING.REQUEST_MODEL(cageHash)
    while not STREAMING.HAS_MODEL_LOADED(cageHash) do
        util.yield()
    end

    local cageObject = entities.create_object(cageHash, pos)
    table.insert(cageIds, cageObject)
    ENTITY.SET_ENTITY_ROTATION(cageObject, cageRotX, cageRotY, cageRotZ, 1, true)
    ENTITY.FREEZE_ENTITY_POSITION(cageObject, true)
    ENTITY.SET_ENTITY_VISIBLE(cageObject, cageVisible, false)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cageHash)
end

local function removeCage(cageIds)
    for i, id in pairs(cageIds) do
        entities.delete_by_handle(id)
    end

    for id in pairs(cageIds) do
        cageIds[id] = nil
    end
end

local function automaticCage(playerId, cageIds, cageTypes, cageType, cageAutomatic, cageVisible)
    if cageAutomatic then
        local firstPlayerPos = players.get_position(playerId)

        for i, data in ipairs(cageTypes["settings"]) do
            createCage(
                playerId,
                data.name,
                cageIds,
                cageVisible,
                data.offset.x,
                data.offset.y,
                data.offset.z,
                data.rot.x,
                data.rot.y,
                data.rot.z
            )
        end

        while (cageAutomatic) do
            local secondPlayerPos = players.get_position(playerId)

            if v3.distance(firstPlayerPos, secondPlayerPos) >= cageTypes["maxDist"] then
                firstPlayerPos = players.get_position(playerId)

                removeCage(cageIds)

                for i, data in ipairs(cageTypes["settings"]) do
                    createCage(
                        playerId,
                        data.name,
                        cageIds,
                        cageVisible,
                        data.offset.x,
                        data.offset.y,
                        data.offset.z,
                        data.rot.x,
                        data.rot.y,
                        data.rot.z
                    )
                end
                util.toast("Player re-caged successfully. :)")
            end

            util.yield(500)
        end
    else
        removeCage(cageIds)
    end
end

--> Spam Entities Functions <--
local function spamEntities(playerId, entityName, entitiesAmount)
    local entityHash = util.joaat(entityName)
    local playerPos = players.get_position(playerId)

    for i = 1, entitiesAmount, 1 do
        local entityPos =
            v3.new(
            playerPos.x + math.random(-1, 1) * 0.25,
            playerPos.y + math.random(-1, 1) * 0.25,
            playerPos.z + math.random(-1, 1) * 0.25
        )
        local entity =
            OBJECT.CREATE_OBJECT_NO_OFFSET(entityHash, entityPos.x, entityPos.y, entityPos.z, true, false, false)
    end

    FIRE.ADD_EXPLOSION(playerPos.x, playerPos.y, playerPos.z, 18, 1, false, true, 0, true)
end

--> Script Start <--
util.toast("Welcome to SmileScript. Hope you'll enjoy! :)")
 --

--[[
#################################################
 ------------Local Features Generator------------
#################################################
]]
local selfLocalRoot = menu.list(menu.my_root(), "Self")
menu.divider(selfLocalRoot, "Self")
local worldLocalRoot = menu.list(menu.my_root(), "World")
menu.divider(worldLocalRoot, "World")

--> Self Buttons <--
local selfWeaponsLocalRoot = menu.list(selfLocalRoot, "Weapons")
menu.divider(selfWeaponsLocalRoot, "Weapons")

menu.toggle(
    selfWeaponsLocalRoot,
    "Autoload Weapons",
    {"autoloadweapons"},
    "Autoload all the weapons everytime you join a new session.",
    function(toggle)
        if toggle then
            players.on_join(
                function(playerId)
                    if playerId == self.playerId then
                        while (util.is_session_transition_active() == true) do
                            util.yield(250)
                        end

                        menu.trigger_commands("allweapons")
                        util.toast("Weapons loaded successfully. :)")
                    end
                end
            )
        end
    end
)

--> World Buttons <--
local worldClearWorldLocalRoot = menu.list(worldLocalRoot, "Clear World")

menu.action(
    worldClearWorldLocalRoot,
    "Clear World",
    {"clearworld"},
    "Deletes the selected in the world.",
    function()
        local count =
            clearWorld(
            localSettings.clearWorldPeds,
            localSettings.clearWorldObjects,
            localSettings.clearWorldVehicles,
            localSettings.clearWorldExclPersVeh
        )

        util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
    end
)

menu.toggle(
    worldClearWorldLocalRoot,
    "Clear Peds",
    {"clearpeds"},
    "Toggle clear peds for clear world.",
    function(toggle)
        localSettings.clearWorldPeds = toggle
    end,
    true
)

menu.toggle(
    worldClearWorldLocalRoot,
    "Clear Objects",
    {"clearobjects"},
    "Toggle clear objects for clear world.",
    function(toggle)
        localSettings.clearWorldObjects = toggle
    end,
    true
)

menu.toggle(
    worldClearWorldLocalRoot,
    "Clear Vehicles",
    {"clearpeds"},
    "Toggle clear vehicles for clear world.",
    function(toggle)
        localSettings.clearWorldVehicles = toggle
    end,
    true
)

menu.toggle(
    worldClearWorldLocalRoot,
    "Exclude Personal Vehicles",
    {"excludepersonalvehicles", "exclpersveh"},
    "Toggle exclude personal vehicles for clear world.",
    function(toggle)
        localSettings.clearWorldExclPersVeh = toggle
    end
)
 --

--[[
#################################################
 -----------Player Features Generator-----------
#################################################
]]
players.on_join(
    function(playerId)
        local pedId = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)
        playerSettings[playerId] = {
            wantedLevel = 0,
            explosionDelay = 100,
            explosionType = 0,
            explosionShake = 1,
            explosionBlamed = false,
            explosionAudible = true,
            explosionVisible = true,
            explosionDamage = true,
            ptfxIds = {},
            ptfxPower = 1,
            ptfxSize = 1,
            ptfxDict = "core",
            ptfxName = "exp_grd_grenade_smoke",
            ptfxLoop = false,
            cageIds = {},
            cageType = 0,
            cageAutomatic = false,
            cageVisible = true,
            entityType = 0,
            entityAmount = 1
        }

        menu.divider(menu.player_root(playerId), "SmileScript")

        --> Player Root Variables <--
        local trollingRoot = menu.list(menu.player_root(playerId), "Trolling")
        menu.divider(trollingRoot, "Trolling")
        local explosionsRoot = menu.list(trollingRoot, "Explosions")
        menu.divider(explosionsRoot, "Explosions")
        local particlesRoot = menu.list(trollingRoot, "Particles")
        menu.divider(particlesRoot, "Particles")
        local spamEntitiesRoot = menu.list(trollingRoot, "Entities")
        menu.divider(spamEntitiesRoot, "Entities")
        local cagesRoot = menu.list(trollingRoot, "Cages")
        menu.divider(cagesRoot, "Cages")

        --> Trolling Buttons <--
        menu.click_slider(
            trollingRoot,
            "Increase Wanted Level",
            {"wantedlevel"},
            "Increase wanted level.",
            1,
            5,
            5,
            1,
            function(change)
                setWantedLevel(playerId, change)
                util.toast("Wanted level increased successfully. :)")
            end
        )

        --> Explosions Buttons <--
        menu.action(
            explosionsRoot,
            "Explode Player",
            {"customexplode", "custexp"},
            "Explode the player.",
            function()
                addExplosion(
                    playerId,
                    playerSettings[playerId].explosionType,
                    playerSettings[playerId].explosionShake,
                    playerSettings[playerId].explosionBlamed,
                    playerSettings[playerId].explosionAudible,
                    playerSettings[playerId].explosionVisible,
                    playerSettings[playerId].explosionDamage
                )
            end
        )

        menu.toggle_loop(
            explosionsRoot,
            "Explode Loop Player",
            {"explodeloop", "exploop"},
            "Explode Loop the player.",
            function()
                addExplosion(
                    playerId,
                    playerSettings[playerId].explosionType,
                    playerSettings[playerId].explosionShake,
                    playerSettings[playerId].explosionBlamed,
                    playerSettings[playerId].explosionAudible,
                    playerSettings[playerId].explosionVisible,
                    playerSettings[playerId].explosionDamage
                )

                util.yield(playerSettings[playerId].explosionDelay)
            end
        )

        menu.list_select(
            explosionsRoot,
            "Explosion Type",
            {"explosiontype", "exptype"},
            "Change Explosion type.",
            explosionTypes,
            0,
            function(change)
                playerSettings[playerId].explosionType = change
            end
        )

        local explosionsSettingsRoot =
            menu.list(
            explosionsRoot,
            "Advanced Settings",
            {},
            "",
            function()
            end
        )

        menu.slider(
            explosionsSettingsRoot,
            "Explosion Delay",
            {"explosiondelay", "expdelay"},
            "Change Explosion delay.",
            50,
            1000,
            100,
            10,
            function(change)
                playerSettings[playerId].explosionDelay = change
            end
        )

        menu.slider(
            explosionsSettingsRoot,
            "Explosion Shake",
            {"explosionshake", "expshake"},
            "Change Shake strength.",
            0,
            100,
            1,
            1,
            function(change)
                playerSettings[playerId].explosionShake = change
            end
        )

        menu.toggle(
            explosionsSettingsRoot,
            "Explosion Blamed",
            {"explosionaudible", "expaudible"},
            "Blames you for the explosion.",
            function(toggle)
                playerSettings[playerId].explosionBlamed = toggle
            end
        )

        menu.toggle(
            explosionsSettingsRoot,
            "Explosion Audible",
            {"explosionblamed", "expblamed"},
            "Toggle explosion audibility.",
            function(toggle)
                playerSettings[playerId].explosionAudible = toggle
            end,
            true
        )

        menu.toggle(
            explosionsSettingsRoot,
            "Explosion Visible",
            {"explosionvisible", "expvisible"},
            "Toggle explosion visibility.",
            function(toggle)
                playerSettings[playerId].explosionVisible = toggle
            end,
            true
        )

        menu.toggle(
            explosionsSettingsRoot,
            "Explosion Damage",
            {"explosiondamage", "expdamage"},
            "Toggle explosion damage.",
            function(toggle)
                playerSettings[playerId].explosionDamage = toggle
            end,
            true
        )

        --> Particles Buttons <--
        menu.toggle(
            particlesRoot,
            "Spawn PTFX",
            {"ptfx"},
            "Spawn a looped PTFX on the player.",
            function(toggle)
                playerSettings[playerId].ptfxLoop = toggle

                if toggle then
                    startPtfx(
                        playerId,
                        playerSettings[playerId].ptfxIds,
                        playerSettings[playerId].ptfxPower,
                        playerSettings[playerId].ptfxSize,
                        playerSettings[playerId].ptfxDict,
                        playerSettings[playerId].ptfxName,
                        playerSettings[playerId].ptfxLoop
                    )
                else
                    removePtfx(playerSettings[playerId].ptfxIds)
                end
            end
        )

        menu.slider(
            particlesRoot,
            "PTFX Amount",
            {"ptfxamount"},
            "Change PTFX amount.",
            1,
            250,
            1,
            1,
            function(change)
                playerSettings[playerId].ptfxPower = change
            end
        )

        menu.slider(
            particlesRoot,
            "PTFX Size",
            {"ptfxsize"},
            "Change PTFX size.",
            1,
            10,
            5,
            1,
            function(change)
                playerSettings[playerId].ptfxSize = change
            end
        )

        local particlesSettingsRoot =
            menu.list(
            particlesRoot,
            "Advanced Settings",
            {},
            "",
            function()
            end
        )

        menu.text_input(
            particlesSettingsRoot,
            "PTFX Dictionary",
            {"ptfxdictionary"},
            "Select PTFX dictionary.",
            function(change)
                playerSettings[playerId].ptfxDict = change
            end,
            "core"
        )

        menu.text_input(
            particlesSettingsRoot,
            "PTFX Name",
            {"ptfxname"},
            "Select PTFX name.",
            function(change)
                playerSettings[playerId].ptfxName = change
            end,
            "exp_grd_grenade_smoke"
        )

        menu.hyperlink(
            particlesSettingsRoot,
            "PTFX List",
            "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270",
            "List of all GTAV PTFX and Dictionaries."
        )

        --> Cages Buttons <--
        menu.toggle(
            cagesRoot,
            "Cage",
            {"cage"},
            "Cage the player.",
            function(toggle)
                if toggle then
                    for i, data in ipairs(cageTypes[playerSettings[playerId].cageType]["settings"]) do
                        createCage(
                            playerId,
                            data.name,
                            playerSettings[playerId].cageIds,
                            playerSettings[playerId].cageVisible,
                            data.offset.x,
                            data.offset.y,
                            data.offset.z,
                            data.rot.x,
                            data.rot.y,
                            data.rot.z
                        )
                    end
                else
                    removeCage(playerSettings[playerId].cageIds)
                end
            end
        )

        menu.toggle(
            cagesRoot,
            "Automatic Cage",
            {"automaticcage", "autocage"},
            "Automatically cage the player if he leave the cage.",
            function(toggle)
                playerSettings[playerId].cageAutomatic = toggle

                automaticCage(
                    playerId,
                    playerSettings[playerId].cageIds,
                    playerSettings[playerId].cageTypes,
                    playerSettings[playerId].cageType,
                    playerSettings[playerId].cageAutomatic,
                    playerSettings[playerId].cageVisible
                )
            end
        )

        menu.list_select(
            cagesRoot,
            "Cage Type",
            {"cagetype"},
            "Change cage type.",
            cageTypes,
            0,
            function(change)
                playerSettings[playerId].cageType = change
            end
        )

        menu.toggle(
            cagesRoot,
            "Cage Visible",
            {"cagevisible"},
            "Toggle cage visibility.",
            function(toggle)
                playerSettings[playerId].cageVisible = toggle
            end,
            true
        )

        --> Spam Entities Buttons <--
        menu.action(
            spamEntitiesRoot,
            "Spawn Entities",
            {"spamentities"},
            "Spam entities on the player.",
            function()
                spamEntities(
                    playerId,
                    entityTypes[playerSettings[playerId].entityType]["name"],
                    playerSettings[playerId].entityAmount
                )
                util.toast("Entities spawned successfully. :)")
            end
        )

        menu.slider(
            spamEntitiesRoot,
            "Entity Amount",
            {"entitiesamount"},
            "Change entities amount.",
            1,
            50,
            1,
            1,
            function(change)
                playerSettings[playerId].entityAmount = change
            end
        )

        menu.list_select(
            spamEntitiesRoot,
            "Entity Type",
            {"entitytype"},
            "Change entity type.",
            entityTypes,
            0,
            function(change)
                playerSettings[playerId].entityType = change
            end
        )
    end
)

players.on_leave(
    function(playerId)
        playerSettings[playerId].cageIds = nil
        playerSettings[playerId].cageType = nil
    end
)

players.dispatch_on_join()
