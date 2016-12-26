-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	state.MagicBurst = M(false, 'Magic Burst')

    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    send_command('bind ^` input /ma Stun <t>')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}


    -- Fast cast sets for spells

	sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Gendewitha Briault",hands="Bokwus Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
	
    sets.precast.FC = {ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Savant's Gown +2",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ring1="Weatherspoon Ring",ring2="Prolix Ring",body="Nefer Kalasiris",ear1="Mendi. Earring",ear2="Loquacious Earring",back="Pahtli Cape",
	hands="Bokwus Gloves",head="Gende. Caubeen",legs="Nares Trews"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Umbani Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {
		head="Kaabanax Hat",neck="Eddy Necklace",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Fucho-No-Obi",legs="Nares Trews",feet="Regal Pumps +1"}


    -- Midcast Sets

    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Vanir Cotehardie",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Serenity",ammo="Impatiens",
		head="Gende. Caubeen",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Nares Trews",feet="Regal Pumps +1"}

    sets.midcast.CureWithLightWeather = {main="Serenity",sub="Achaq Grip",ammo="Impatiens",
		head="Gende. Caubeen",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Nares Trews",feet="Regal Pumps +1"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Regen = {main="Bolelabunga",head="Umuthi Hat"}

    sets.midcast.Cursna = {ammo="Impatiens",
		head="Nahtirah Hat",neck="Malison Medallion",ear1="Mendi. Earring",ear2="Loquacious Earring",
		hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		feet="Gendewitha Galoshes"}

    sets.midcast['Enhancing Magic'] = {ammo="Impatiens",
		head="Umuthi Hat",neck="Voltsurge Torque",ear2="Loquacious Earring",
		body="Savant's Gown +2",hands="Svnt. Bracers +2",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		waist="Siegel Sash",legs="Savant's Pants +2",feet="Svnt. Loafers +2"}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat",waist="Siegel Sash"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers"})

    sets.midcast.Protect = {head="Umuthi Hat",ring1="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {head="Umuthi Hat",ring1="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Keraunos",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Bokwus Boots"}

    sets.midcast.IntEnfeebles = {main="Keraunos",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Bokwus Boots"}

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {main="Keraunos",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast.Kaustra = {main="Keraunos",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast.Drain = {main="Keraunos",sub="Mephitis Grip",ammo="Kalboron Stone",
		head="Appetence Crown",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Fucho-No-Obi",legs="Lengo Pants",feet="Bokwus Boots"}

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Keraunos",sub="Mephitis Grip",ammo="Impatients",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Keraunos"})


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Othila Sash",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast['Elemental Magic'].Resistant = {main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Othila Sash",legs="Lengo Pants",feet="Umbani Boots"}

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Othila Sash",legs="Lengo Pants",feet="Umbani Boots"})

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Othila Sash",legs="Lengo Pants",feet="Umbani Boots"})

	sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring"}	
		
    sets.midcast.Impact = {main="Lehbrailg +2",sub="Mephitis Grip",ammo="Dosis Tathlum",
        head=empty,neck="Eddy Necklace",ear2="Psystorm Earring",ear1="Lifestorm Earring",
        body="Twilight Cloak",hands="Bokwus Gloves",ring1="Fenrir Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Demonry Sash",legs="Lengo Pants",feet="Bokwus Boots"}

	sets.midcast.Helix = {main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Fenrir Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

	sets.midcast.Helix.Resistant = {main="Keraunos",sub="Mephitis Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Fenrir Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Mephitis Grip",ammo="Homiliary",
		head="Wivre Hairpin",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquac. Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots",back="Umbra Cape"}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = {main="Keraunos",sub="Mephitis Grip",ammo="Homiliary",
		head="Acad. Mortarboard",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquac. Earring",
		body="Savant's Gown +2",hands="Svnt. Bracers +2",ring1="Matrimony Band",ring2="Prolix Ring",
		waist="Fucho-No-Obi",legs="Savant's Pants +2",feet="Herald's Gaiters",back="Umbra Cape"}--Zuuxowu Grip

    sets.idle.Field = {main="Keraunos",sub="Mephitis Grip",ammo="Homiliary",
		head="Wivre Hairpin",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquac. Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters",back="Umbra Cape"}

    sets.idle.Field.PDT = {main="Keraunos",sub="Mephitis Grip",ammo="Homiliary",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		waist="Fucho-No-Obi",legs="Nares Trews",feet="Serpentes Sabots",back="Umbra Cape"}

    sets.idle.Field.Stun = {main="Keraunos",sub="Mephitis Grip",ammo="Impatients",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Gende. Gages +1",ring1="Stendu Ring",ring2="Sangoma Ring",
		back="Swith Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

    sets.idle.Weak = {main="Keraunos",sub="Mephitis Grip",ammo="Homiliary",
		head="Wivre Hairpin",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquac. Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters",back="Umbra Cape"}

    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}
	
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {ammo="Impatients",
		head="Buremte Hat",ear1="Steelflash Earring",ear2="Bladeborn Earring",neck="Asperity Necklace",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Toro Cape",waist="Cetl Belt",legs="Lengo Pants",feet="Umbani Boots"}



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Ebullience'] = {head="Savant's Bonnet +2"}
	sets.buff['Rapture'] = {head="Savant's Bonnet +2"}
	sets.buff['Perpetuance'] = {hands="Savant's Bracers +2"}
	sets.buff['Immanence'] = {hands="Savant's Bracers +2"}
	sets.buff['Penury'] = {legs="Savant's Pants +2"}
	sets.buff['Parsimony'] = {legs="Savant's Pants +2"}
	sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
	sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}

	sets.buff['Klimaform'] = {feet="Savant's Loafers +2"}

	sets.buff.FullSublimation = {head="Scholar's M.Board",ear1="Savant's Earring",body="Argute Gown"}
	sets.buff.PDTSublimation = {head="Scholar's M.Board",ear1="Savant's Earring"}

    sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
end