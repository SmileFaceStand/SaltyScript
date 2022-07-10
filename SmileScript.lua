--[[
Script created by (=#1000
Credits to aaron that helped me with PTFX
Credits to lance's LanceScript where i got Clear World
Credits to nowiry's WiriScript where i got Tall Cage
--]]

util.require_natives(1651208000)
util.keep_running()

--> General Variables <--
local self = {
playerId = players.user(),
pedId = players.user_ped(),
x = v3.getX(players.get_position(players.user())),
y = v3.getY(players.get_position(players.user())),
z = v3.getZ(players.get_position(players.user()))
}

--> Explosions Functions <--
local explosion = {
types = {
[0] = {'Grenade'},
[1] = {'Grenade Launcher'},
[2] = {'Stickybomb'},
[3] = {'Molotov'},
[4] = {'Rocket'},
[5] = {'Tankshell'},
[6] = {'Hi Octane'},
[7] = {'Car'},
[8] = {'Plane'},
[9] = {'Petrol Pump'},
[10] = {'Bike'},
[11] = {'Steam'},
[12] = {'Flame'},
[13] = {'Water Hydrant'},
[14] = {'Gas Canister'},
[15] = {'Boat'},
[16] = {'Ship'},
[17] = {'Truck'},
[18] = {'Bullet'},
[19] = {'Smoke Grenade Launcher'},
[20] = {'Smoke Grenade'},
[21] = {'BZ Gas'},
[22] = {'Flare'},
[23] = {'Gas Canister'},
[24] = {'Extinguisher'},
[25] = {'Programmable AR'},
[26] = {'Train'},
[27] = {'Barrel'},
[28] = {'Propane'},
[29] = {'Blimp'},
[30] = {'Flame Explode'},
[31] = {'Tanker'},
[32] = {'Plane Rocket'},
[33] = {'Vehicle Bullet'},
[34] = {'Gas Tank'},
[35] = {'Bird Crap'},
[36] = {'Railgun'},
[37] = {'Blimp 2'},
[38] = {'Firework'},
[39] = {'Snowball'},
[40] = {'Proximity Mine'},
[41] = {'Valkyrie Cannon'},
[42] = {'Air Defence'},
[43] = {'Pipe Bomb'},
[44] = {'Vehicle Mine'},
[45] = {'Explosive Ammo'},
[46] = {'APC Shell'},
[47] = {'Cluster Bomb'},
[48] = {'Gas Bomb'},
[49] = {'Incendiary Bomb'},
[50] = {'Standard Bomb'},
[51] = {'Torpedo'},
[52] = {'Underwater Torpedo'},
[53] = {'Bombushka Cannon'},
[54] = {'Cluster Bomb 2'},
[55] = {'Hunter Barrage'},
[56] = {'Hunter Cannon'},
[57] = {'Rogue Cannon'},
[58] = {'Underwater Mine'},
[59] = {'Orbital Cannon'},
[60] = {'Bomb Standard Wide'},
[61] = {'Explosive Shotgun Ammo'},
[62] = {'Oppressor MKII Cannon'},
[63] = {'Mortar Kinetic'},
[64] = {'Kinetic Mine'},
[65] = {'EMP Mine'},
[66] = {'Spike Mine'},
[67] = {'Slick Mine'},
[68] = {'Tar Mine'},
[69] = {'Drone'},
[70] = {'Up-n-Atomizer'},
[71] = {'Buried Mine'},
[72] = {'Missile'},
[73] = {'RC Tank Rocket'},
[74] = {'Water Bomb'},
[75] = {'Water Bomb 2'},
[76] = {'Unknown 1'},
[77] = {'Unknown 2'},
[78] = {'Flash Grenade'},
[79] = {'Stun Grenade'},
[80] = {'Unknown 3'},
[81] = {'Large Missile'},
[82] = {'Big Submarine'},
[83] = {'EMP Launcher'},
},
delay = 100,
type = 0,
shake = 1,
blamed = false,
audible = true,
visible = true,
damage = true
}

local function addExplosion(playerId, expType, expShake, expBlamed, expAudible, expVisible, expDamage)
    local playerX, playerY, playerZ = v3.get(players.get_position(playerId))
    local expInvisible = not expVisible
    local expNoDamage = not expDamage

    if expBlamed then
        FIRE.ADD_OWNED_EXPLOSION(self.pedId, playerX, playerY, playerZ, expType, 1, expAudible, expInvisible, expShake, expNoDamage)
    else
        FIRE.ADD_EXPLOSION(playerX, playerY, playerZ, expType, 1, expAudible, expInvisible, expShake, expNoDamage)
    end
end

--> Particles Functions <--
local ptfx = {
ids = {},
power = 1,
size = 5,
dict = "core",
name = "exp_grd_grenade_smoke"
}

local function startPtfx(pedId, ptfxIds, ptfxPower, ptfxSize, ptfxDict, ptfxName)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(ptfxDict)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(ptfxDict) do
        util.yield()
    end

    for i = 1, ptfxPower, 1 do
        GRAPHICS.USE_PARTICLE_FX_ASSET(ptfxDict)
        local ptfxId = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(ptfxName, pedId, 0, 0, 0, 0, 0, 0, ptfxSize, false, false, false)
        table.insert(ptfxIds, ptfxId)
    end
end

local function removePtfx(ptfxIds)
    for i, id in pairs(ptfxIds) do
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(id, false)
    end
end

--> Cages Functions <--
local cage = {
    ids = {},
    visible = true
}

local function createCage(playerId, pedId, cageName, cageIds, cageVisible)
    if PED.IS_PED_IN_ANY_VEHICLE(pedId, false) then
        menu.trigger_commands("vehkick" .. PLAYER.GET_PLAYER_NAME(playerId))
        util.yield(200)
    end
    local pos = players.get_position(playerId)
    local cageHash = util.joaat(cageName)
    STREAMING.REQUEST_MODEL(cageHash)
    while not STREAMING.HAS_MODEL_LOADED(cageHash) do
        util.yield()
    end

    local cageObject = entities.create_object(cageHash, pos)
    table.insert(cageIds[playerId], cageObject)
    ENTITY.SET_ENTITY_VISIBLE(cageObject, cageVisible, false)
    return cageObject, cageHash
end

local function removeCage(playerId, cageIds)

    for i, id in pairs(cageIds[playerId]) do
        entities.delete_by_handle(id)
    end

    for id in pairs(cageIds[playerId]) do
        cageIds[playerId][id] = nil
    end
    util.toast("Player uncaged successfully. :)")
end

--> Script Start <--
util.toast("Welcome to SmileScript. Hope you'll enjoy! :)")

--> Main Features Generator <--
local selfMainRoot = menu.list(menu.my_root(), "Self")
local worldMainRoot = menu.list(menu.my_root(), "World")

--> Self Buttons <--
local selfWeaponsMainRoot = menu.list(selfMainRoot, "Weapons")

menu.toggle(selfWeaponsMainRoot, "Autoload Weapons", {"autoloadweapons"}, "Autoload all the weapons everytime you join a new session.", function(toggle)
    if toggle then
        players.on_join(function(playerId)
            if playerId == players.user() then
                while(util.is_session_transition_active() == true) do
                        util.yield(250)
                end
                menu.trigger_commands("allweapons")
                util.toast("Weapons loaded successfully. :)")
            end
        end)
    end
end)

--> World Buttons <--
menu.action(worldMainRoot, "Clear World", {"clearworld"}, "Deletes any entity in the world.", function()
    local count = 0
    for i, entity in pairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(entity)
        count = count + 1
    end
    for i, entity in pairs(entities.get_all_peds_as_handles()) do
        if not ENTITY.IS_PED_A_PLAYER(entity) then
            entities.delete_by_handle(entity)
        end
        count = count + 1
    end
    for i, entity in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(entity)
        count = count + 1
    end
    util.toast("World cleaned successfully, " .. count .. " entities removed. :)")
end)

--> Player Features Generator <--
players.on_join(function(playerId)
    local pedId = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)
    cage.ids[playerId] = {}

    menu.divider(menu.player_root(playerId), "SmileScript")

    --> Player Root Variables <--
    local trollingRoot = menu.list(menu.player_root(playerId), "Trolling")
    local explosionsRoot = menu.list(trollingRoot, "Explosions", {}, "", function(); end)
    local particlesRoot = menu.list(trollingRoot, "Particles", {}, "", function(); end)
    local cagesRoot = menu.list(trollingRoot, "Cages", {}, "", function(); end)

    --> Explosions Buttons <--
    menu.action(explosionsRoot, "Explode", {"customexplode", "custexp"}, "Explode the player.", function()
        addExplosion(playerId, explosion.type, explosion.shake, explosion.blamed, explosion.audible, explosion.visible, explosion.damage)
    end)

    menu.toggle_loop(explosionsRoot, "Explode Loop", {"explodeloop", "exploop"}, "Explode Loop the player.", function()
        addExplosion(playerId, explosion.type, explosion.shake, explosion.blamed, explosion.audible, explosion.visible, explosion.damage)
        util.yield(explosion.delay)
    end)

    menu.list_select(explosionsRoot, "Explosion Type", {"explosiontype", "exptype"}, "Change Explosion type.", explosion.types, 1, function(change)
        explosion.type = change
    end)

    local explosionsSettingsRoot = menu.list(explosionsRoot, "Advanced Settings", {}, "", function(); end)

    menu.slider(explosionsSettingsRoot, "Explosion Delay", {"explosiondelay", "expdelay"}, "Change Explosion delay.", 50, 1000, 100, 10, function(change)
        explosion.delay = change
    end)

    menu.slider(explosionsSettingsRoot, "Explosion Shake", {"explosionshake", "expshake"}, "Change Shake strength.", 1, 100, 1, 1, function(change)
        explosion.shake = change
    end)

    menu.toggle(explosionsSettingsRoot, "Explosion Blamed", {"explosionaudible", "expaudible"}, "Blames you for the explosion.", function(toggle)
        explosion.blamed = toggle
    end)

    menu.toggle(explosionsSettingsRoot, "Explosion Audible", {"explosionblamed", "expblamed"}, "Toggle explosion audibility.", function(toggle)
        explosion.audible = toggle
    end, true)

    menu.toggle(explosionsSettingsRoot, "Explosion Visible", {"explosionvisible", "expvisible"}, "Toggle explosion visibility.", function(toggle)
        explosion.visible = toggle
    end, true)

    menu.toggle(explosionsSettingsRoot, "Explosion Damage", {"explosiondamage", "expdamage"}, "Toggle explosion damage.", function(toggle)
        explosion.damage = toggle
    end, true)

    --> Particles Buttons <--
    menu.toggle(particlesRoot, "PTFX Player", {"ptfx"}, "Loop a PTFX on the player.", function(toggle)
        if toggle then
            startPtfx(pedId, ptfx.ids, ptfx.power, ptfx.size, ptfx.dict, ptfx.name)

            while(true) do
                if PLAYER.IS_PLAYER_DEAD(playerId) then
                    while(PLAYER.IS_PLAYER_DEAD(playerId)) do
                        util.yield(100)
                    end
                    break
                else
                    util.yield(250)
                end
            end
            pedId = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerId)
            removePtfx(ptfx.ids)
            startPtfx(pedId, ptfx.ids, ptfx.power, ptfx.size, ptfx.dict, ptfx.name)
        else
            removePtfx(ptfx.ids)
        end
    end)

    menu.slider(particlesRoot, "PTFX Amount", {"ptfxamount"}, "Change PTFX amount.", 1, 300, 1, 1, function(change)
        ptfx.power = change
    end)

    menu.slider(particlesRoot, "PTFX Size", {"ptfxsize"}, "Change PTFX size.", 1, 10, 5, 1, function(change)
        ptfx.size = change
    end)

    local particlesSettingsRoot = menu.list(particlesRoot, "Advanced Settings", {}, "", function(); end)

    menu.text_input(particlesSettingsRoot, "PTFX Dictionary", {"ptfxdictionary"}, "Select PTFX dictionary.", function(change)
        ptfx.dict = change
    end, "core")

    menu.text_input(particlesSettingsRoot, "PTFX Name", {"ptfxname"}, "Select PTFX name.", function(change)
        ptfx.name = change
    end, "exp_grd_grenade_smoke")

	menu.hyperlink(particlesSettingsRoot, "PTFX List", "https://github.com/DurtyFree/gta-v-data-dumps/blob/master/particleEffectsCompact.json#L270", "List of all GTAV PTFX and Dictionaries.")

    --> Cages Buttons <--
    menu.action(cagesRoot, "Standard Cage", {"cage"}, "Cage the player.", function()
        local cageObject, cageHash = createCage(playerId, pedId, "prop_gold_cont_01", cage.ids, cage.visible)
        ENTITY.FREEZE_ENTITY_POSITION(cageObject, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cageHash)
    end)

    menu.action(cagesRoot, "Tall Cage", {"tallcage"}, "Cage the player with a taller cage.", function()
        local cageObject1, cageHash1 = createCage(playerId, pedId, "prop_rub_cage01a", cage.ids, cage.visible)
        local cageObject2, cageHash2 = createCage(playerId, pedId, "prop_rub_cage01a", cage.ids, cage.visible)
        local cagePos1 = ENTITY.GET_ENTITY_COORDS(cageObject1)
        local cagePos2 = ENTITY.GET_ENTITY_COORDS(cageObject2)
        local cageRot2 = ENTITY.GET_ENTITY_ROTATION(cageObject2)
        ENTITY.SET_ENTITY_COORDS(cageObject1, cagePos1.x, cagePos1.y, cagePos1.z - 1)
        ENTITY.SET_ENTITY_COORDS(cageObject2, cagePos2.x, cagePos2.y, cagePos2.z + 1.2)
        ENTITY.SET_ENTITY_ROTATION(cageObject2, -180.0, cageRot2.y, 90.0, 1, true)
        ENTITY.FREEZE_ENTITY_POSITION(cageObject1, true)
        ENTITY.FREEZE_ENTITY_POSITION(cageObject2, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cageHash1)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cageHash2)
    end)

    menu.action(cagesRoot, "Stunt Tube Cage", {"stunttubecage"}, "Cage the player with a stunt tube.", function()
        local cageObject, cageHash = createCage(playerId, pedId, "stt_prop_stunt_tube_end", cage.ids, cage.visible)
        local cageRot = ENTITY.GET_ENTITY_ROTATION(cageObject)
        ENTITY.SET_ENTITY_ROTATION(cageObject, cageRot.x, -90.0, cageRot.z, 1, true)
        ENTITY.FREEZE_ENTITY_POSITION(cageObject, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cageHash)
    end)

    menu.action(cagesRoot, "Uncage Player", {"uncage"}, "Uncage the player (Only works with cages spawned by you).", function()
        removeCage(playerId, cage.ids)
    end)

    menu.toggle(cagesRoot, "Cage Visible", {"cagevisible"}, "Toggle cage visibility.", function(toggle)
        cage.visible = toggle
    end, true)
end)

players.on_leave(function(playerId)
    cage.ids[playerId] = nil
end)

players.dispatch_on_join()