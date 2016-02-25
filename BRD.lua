-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Terpander song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Terpander, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Terpander/Terpander
    info.ExtraSongs = 1
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

	sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Gendewitha Briault",hands="Bokwus Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
	
    -- Fast cast sets for spells
    sets.precast.FC = {range="Linos",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquac. Earring",
		hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",neck="Jeweled Collar",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Chelona Boots"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendi. Earring",body="Nefer Kalasiris",legs="Nares Trews"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat",waist="Siegel Sash"})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.BardSong = {main="Felibre's Dague",range="Linos",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear1="Aoidos' Earring",ear2="Loquac. Earring",
		body="Sha'ir Manteel",hands="Schellenband",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Aoidos' Belt",legs="Gendewitha Spats",feet="Bokwus Boots"}

	sets.precast.FC.Terpander = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bard's Justaucorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bard's Cannions +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Linos",
		head="Nahtirah Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Gendewitha Briault",hands="Bokwus Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {range="Linos",
		head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
   sets.precast.WS['Evisceration'] = {range="Linos",
		head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Ramuh Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}

	sets.precast.WS["Rudra's Storm"] = {range="Linos",
		head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Ramuh Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}	
		
	sets.precast.WS['Exenterator'] = {range="Linos",
		head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}

	sets.precast.WS['Mordant Rime'] = {range="Linos",
		head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
 
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {range="Linos",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {main="Legato Dagger",range="Linos",legs="Aoidos' Rhing. +2"}
	sets.midcast.Lullaby = {main="Malevolence",range="Linos",hands="Brioso Cuffs"}
	sets.midcast.Madrigal = {main="Legato Dagger",range="Linos",head="Aoidos' Calot +2"}
	sets.midcast.March = {main="Legato Dagger",range="Linos",hands="Aoidos' Manchettes +2"}
	sets.midcast.Minuet = {main="Legato Dagger",range="Linos",body="Aoidos' Hongreline +2"}
	sets.midcast.Minne = {main="Legato Dagger",range="Linos"}
	sets.midcast.Paeon = {main="Legato Dagger",range="Linos",head="Brioso Roundlet"}
	sets.midcast.Carol = {main="Felibre's Dague",range="Terpander",
		head="Aoidos' Calot +2",ear2="Loaquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		body="Sha'ir Manteel",hands="Leyline Gloves",waist="Aoidos' Belt",
		legs="Gendewitha Spats",feet="Bokwus Boots",neck="Aoidos' Matinee"}
	sets.midcast["Sentinel's Scherzo"] = {main="Legato Dagger",range="Linos",feet="Aoidos' Cothrn. +2"}
	sets.midcast['Magic Finale'] = {main="Malevolence",range="Linos",legs="Aoidos' Rhing. +2"}

	sets.midcast.Mazurka = {main="Felibre's Dague",range="Terpander"}


    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {main="Legato Dagger",range="Linos",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear2="Loquacious Earring",
		body="Aoidos' Hongreline +2",hands="Aoidos' Manchettes +2",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Rhapsode's Cape",waist="Aoidos' Belt",legs="Aoidos' Rhing. +2",feet="Brioso Slippers"}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {main="Malevolence",range="Linos",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring2="Prolix Ring",ring1="Weatherspoon Ring",
		back="Rhapsode's Cape",waist="Refoccilation Stone",legs="Aoidos' Rhing. +2",feet="Bokwus Boots"}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main="Malevolence",range="Linos",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Brioso Justaucorps",hands="Leyline Gloves",ring2="Prolix Ring",ring1="Weatherspoon Ring",
		back="Rhapsode's Cape",waist="Refoccilation Stone",legs="Aoidos' Rhing. +2",feet="Bokwus Boots"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
		body="Sha'ir Manteel",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Rhapsode's Cape",waist="Aoidos' Belt",legs="Aoidos' Rhing. +2"}

    sets.midcast.Terpander = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Terpander instead
    sets.midcast.Terpander = {range=info.ExtraSongInstrument}

    -- Dummy song with Terpander; minimize duration to make it easy to overwrite.
    sets.midcast.TerpanderDummy = {main="Felibre's Dague",range="Terpander",
		head="Aoidos' Calot +2",neck="Aoidos' Matinee",ear1="Lifestorm Earring",ear2="Loaquacious Earring",
		body="Sha'ir Manteel",hands="Leyline Gloves",ring2="Prolix Ring",ring1="Weatherspoon Ring",
		back="Swith Cape",waist="Aoidos' Belt",legs="Gendewitha Spats",feet="Bokwus Boots"}

    -- Other general spells and classes.
    sets.midcast.Cure = {range="Linos",
		head="Gendewitha Caubeen",back="Pahtli Cape",waist="Witful Belt",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		legs="Nares Trews",feet="Chelona Boots",neck="Jeweled Collar"}
        
    sets.midcast.Curaga = sets.midcast.Cure
        
    sets.midcast.Stoneskin = {range="Linos",
		head="Nahtirah Hat",neck="Jeweled Collar",ear2="Loquacious Earring",ear1="Earthcry Earring",waist="Siegel Sash",back="Swith Cape",
		body="Gendewitha Bliaut",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		legs="Haven Hose",feet="Chelona Boots"}
        
    sets.midcast.Cursna = {range="Linos",
		head="Nahtirah Hat",neck="Malison Medallion",neck="Jeweled Collar",ear2="Loquacious Earring",back="Swith Cape",Waist="Witful Belt",
		hands="Leyline Gloves",ring1="Ephedra Ring",ring2="Prolix ring",feet="Gende. Galoshes"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Legato Dagger", sub="Legion Scutum",range="Linos", 
		body="Gendewitha Bliaut",head="Nahtirah Hat",neck="Lissome Necklace",ring1="Matrimony Band",ring2="Prolix Ring",
		hands="Serpentes Cuffs",legs="Assiduity Pants +1",feet="Serpentes Sabots",waist="Fucho-No-Obi"}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Legato Dagger", sub="Legion Scutum",range="Linos",
		head="Nahtirah Hat",neck="Lissome Necklace",ear1="Aoidos' Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Aoidos' Cothurnes +2"}

    sets.idle.PDT = {main=gear.Staff.PDT, sub="Mephitis Grip",range="Oneiros Harp",
        head="Gendewitha Caubeen",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Sangoma Ring",
        back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Aoidos' Cothurnes +2"}

    sets.idle.Town = {main="Legato Dagger", sub="Legion Scutum",range="Linos",
		head="Nahtirah Hat",neck="Lissome Necklace",ear1="Aoidos' Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Aoidos' Cothurnes +2"}
    
    sets.idle.Weak = {main="Legato Dagger", sub="Legion Scutum",range="Linos",
		head="Nahtirah Hat",neck="Lissome Necklace",ear1="Aoidos' Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Aoidos' Cothurnes +2"}
    
    
    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Gendewitha Caubeen",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Flume Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bihu Cannions",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Aoidos' Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {range="Linos",
		head="Buremte Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Gendewitha Bliaut",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Witful Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {range="Angel Lyre",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Bihu Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Witful Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}

    -- Set if dual-wielding
    sets.engaged.DW = {range="Angel Lyre",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Bihu Justaucorps",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Witful Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Terpander)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'TerpanderDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Terpander' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(2, 18)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)