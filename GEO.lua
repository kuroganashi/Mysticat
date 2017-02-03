-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Crits')--'Resistant',
    state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')
	
    gear.default.weaponskill_waist = "Fotia Belt"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
	sets.precast.JA['Cardinal Chant'] = {head="Geomancy Galero +1"}
	sets.precast.JA['Collimated Fervor'] = {head="Bagua Galero +1"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back="Nantosuelta's Cape"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
	sets.precast.JA['Full Cycle'] = {hands="Bagua Mitaines +1",head="Azimuth Hood +1"}
	sets.precast.JA['Bolster'] = {body="Bagua Tunic +1"}
	
    -- Fast cast sets for spells
	
	sets.precast.Waltz = {head="Geo. Galero +1",body="Bagua Tunic +1",hands="Geo. Mitaines +1",legs="Bagua Pants +1",feet="Geo. Sandals +1",neck="Unmoving Collar +1",ring1="Titan Ring",ring2="Titan Ring",
	ear1="Soil Pearl",ear2="Soil Pearl",back="Iximulew Cape"}
	
    sets.precast.FC = {main="Solstice",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Azimuth Coat",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Ogapepo Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}

	sets.precast.FC.Cure = {main="Tamaxchi",sub="Sors Shield",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Nefer Kalasiris",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {head="Jhakri Coronal +1",neck="Fotia Gorget",ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Rufescent Ring",
		back="Lifestream Cape",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--Bagua Pants +1/Bagua Tunic +1/Geomancy Galero +1/Bagua Tunic +1
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Flash Nova'] = {
		head="Merlinic Hood",neck="Eddy Necklace",ear2="Friomisi Earring",ear1="Barkarole Earring",
		body="Jhakri Robe +1",hands="Amalric Gages",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--"Witching Robe"
    
	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Exudation'] = {head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Jhakri Robe +1",hands="Amalric Gages",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--Bagua Pants +1/Buremte Hat

	sets.precast.WS['Realmrazer'] = {head="Buremte Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Jhakri Robe +1",hands="Amalric Gages",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--Bagua Pants +1/Buremte Hat

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {main="Solstice",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Azimuth Coat",hands="Amalric Gages",ring1="Weatherspoon Ring",ring2="Prolix Ring",neck="Voltsurge Torque",
		back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps +1"}

    sets.midcast.Geomancy = {main="Idris",range="Dunna",
		head="Azimuth Hood +1",body="Bagua Tunic +1",hands="Geo. Mitaines +1",
		legs="Bagua Pants +1",feet="Medium's Sabots",
		ear1="Gifted Earring",ear2="Magnetic Earring",neck="Incanter's Torque",
		back="Lifestream Cape",waist="Austerity Belt",ring1="Stikini Ring",ring2="Stikini Ring"}--"Stikini Ring"
		
    sets.midcast.Geomancy.Indi = {main="Idris",range="Dunna",
		head="Azimuth Hood +1",body="Bagua Tunic +1",hands="Geo. Mitaines +1",
		legs="Bagua Pants +1",feet="Azimuth Gaiters +1",
		ear1="Gifted Earring",ear2="Magnetic Earring",neck="Incanter's Torque",
		back="Lifestream Cape",waist="Austerity Belt",ring1="Stikini Ring",ring2="Stikini Ring"}--"Stikini Ring"

    sets.midcast.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Sors Shield",ear1="Mendi. Earring",ear2="Loquacious Earring",body="Nefer Kalasiris",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Prolix ring",back="Pahtli Cape",feet="Regal Pumps +1"})--Nares Trews
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = set_combine(sets.precast.FC, {main="Solstice",head="Umuthi Hat",ring1="Sheltered Ring",ring2="Stikini Ring"})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.precast.FC, {main="Solstice",head="Umuthi Hat",ring1="Sheltered Ring",ring2="Stikini Ring"})
	sets.midcast.Shell = sets.midcast.Shellra

	sets.midcast.Stoneskin = set_combine(sets.precast.FC, {main="Solstice",head="Umuthi Hat",waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose",neck="Nodens Gorget",ring1="Stikini Ring",ring2="Stikini Ring"})

	sets.midcast.Cursna = set_combine(sets.precast.FC, {main="Solstice",ring1="Ephedra Ring",ring2="Ephedra Ring",neck="Malison Medallion"})
	
	sets.midcast.Regen = set_combine(sets.precast.FC, {main="Bolelabunga",head="Umuthi Hat",body="Telchine Chas.",ring1="Stikini Ring",ring2="Stikini Ring"})

	sets.midcast['Elemental Magic'] = {main="Idris",sub="Culminus",
		head="Merlinic Hood",neck="Mizukage-no-Kubikazari",ear2="Friomisi Earring",ear1="Barkarole Earring",
		body="Jhakri Robe +1",hands="Amalric Gages",ring2="Locus Ring",ring1="Mujin Band",
		back="Toro Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--Buremte Hat/Azimuth Coat/Lengo Pants/Loagaeth Cuffs/Welkin Crown/Azimuth Coat/Jhakri Robe +1/Witching Robe/Wretched Coat/Count's Garb
	
	sets.midcast['Elemental Magic'].Crits = {main="Idris",sub="Culminus",
		head="Merlinic Hood",neck="Mizukage-no-Kubikazari",ear2="Friomisi Earring",ear1="Barkarole Earring",
		body="Count's Garb",hands="Amalric Gages",ring2="Locus Ring",ring1="Mujin Band",
		back="Toro Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--Buremte Hat/Azimuth Coat/Lengo Pants/Loagaeth Cuffs/Welkin Crown/Azimuth Coat/Jhakri Robe +1/Witching Robe/Wretched Coat/Count's Garb
	
	sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring2="Locus Ring",ring1="Mujin Band",hands="Amalric Gages"}--Count's Garb
	
	sets.midcast['Enfeebling Magic'] = {main="Idris",sub="Culminus",
		head="Merlinic Hood",neck="Eddy Necklace",ear2="Lifestorm Earring",ear1="Psystorm Earring",
		body="Ischemia Chasu.",hands="Azimuth Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet="Merlinic Crackows"}--Nahtirah Hat
	
	sets.midcast.Drain = {main="Rubicundity",sub="Culminus",
		head="Bagua Galero +1",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Jhakri Robe +1",hands="Amalric Gages",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Fucho-No-Obi",legs="Azimuth Tights",feet="Merlinic Crackows"}--Jhakri Robe +1 / Geo. Tunic +1

	sets.midcast.Aspir = sets.midcast.Drain
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {main="Bolelabunga",head="Azimuth Hood +1",neck="Lissome Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}--Refresh Head soon.

		
																	-- EMPERYAN ARMOR :

--Azimuth Hood = DEF:72 HP+15 MP+46 STR+10 DEX+10 VIT+10 AGI+2 INT+21 MND+13 CHR+13 Evasion+15 Magic Evasion+58 "Magic Def. Bonus"+3 Haste+5% Geomancy skill +10 "Full Circle"+1 Luopan: "Regen"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Coat = DEF:92 HP+23 MP+56 STR+12 DEX+12 VIT+12 AGI+12 INT+22 MND+17 CHR+17 Evasion+17 Magic Evasion+62 Magic Accuracy+13 "Magic Atk. Bonus"+13 "Magic Def. Bonus"+3 Haste+2% Elemental magic skill +13 Enmity-7 "Refresh"+2 Set: MP occasionally not depleted when using geomancy spells
--Azimuth Coat = DEF:92 HP+23 MP+56 STR+12 DEX+12 VIT+12 AGI+12 INT+22 MND+17 CHR+17 Evasion+17 Magic Evasion+62 Magic Accuracy+13 "Magic Atk. Bonus"+13 "Magic Def. Bonus"+3 Haste+2% Elemental magic skill +13 Enmity-7 "Refresh"+2 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gloves = DEF:62 HP+8 MP+57 STR+4 DEX+16 VIT+14 AGI+3 INT+13 MND+20 CHR+11 Magic Accuracy+17 Evasion+8 Magic Evasion+32 "Magic Def. Bonus"+1 Enfeebling magic skill +13 Haste+3% Enmity-10 Set: MP occasionally not depleted when using geomancy spells


--Azimuth Tights = DEF:80 HP+18 MP+36 STR+13 VIT+5 AGI+10 INT+31 MND+14 CHR+11 Magic Accuracy+10 "Magic Atk. Bonus"+10 Evasion+11 Magic Evasion+80 "Magic Def. Bonus"+3 Dark magic skill +15 Haste+4% Set: MP occasionally not depleted when using geomancy spells


--Azimuth Gaiters = DEF:49 HP+34 MP+47 STR+5 DEX+5 VIT+5 AGI+18 INT+12 MND+11 CHR+20 Evasion+28 Magic Evasion+80"Magic Def. Bonus"+3 Haste+3% "Indicolure" spell duration +15 Physical damage taken -3% Set: MP occasionally not depleted when using geomancy spells

--Solstice = Handbell Skill+5 Conserve MP+6 Indi Spell +15

--Lifestream Cape (DEF:13 HP+50 MP+50 Enfeebling Magic Skill +10 Fast Cast+10% GEOMANCY SKILL +15 Indi. Duration+15 DT-2% PET: DT-4%)

--Nantosuelta's Cape (DEF:15 Indicolure effect duration +20 "Life Cycle"+10)

    -- Idle sets

    sets.idle = {main="Bolelabunga",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Lissome Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Geo. Sandals +1"}--Arciela's Grace +1,Lifestream Cape

    sets.idle.PDT = {main="Bolelabunga",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Refoccilation Stone",legs="Assiduity Pants +1",feet="Geo. Sandals +1"}

	sets.idle.MDT = {main="Bolelabunga",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Loquacious Earring",
		body="Jhakri Robe +1",hands="Telchine Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Isa Belt",legs="Assiduity Pants +1",feet="Merlinic Crackows"}	
		
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Geo. Mitaines +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Lifestream Cape",waist="Isa Belt",legs="Bagua Pants +1",feet="Bagua Sandals +1"}

    sets.idle.PDT.Pet = {main="Idris",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Geo. Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Isa Belt",legs="Assiduity Pants +1",feet="Bagua Sandals +1"}
	
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Nantosuelta's Cape",ring1="Stikini Ring",ring2="Stikini Ring"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Nantosuelta's Cape",ring1="Stikini Ring",ring2="Stikini Ring"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Nantosuelta's Cape",ring1="Stikini Ring",ring2="Stikini Ring"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {main="Idris",legs="Bagua Pants +1",feet="Azimuth Gaiters +1",back="Lifestream Cape"})

    sets.idle.Town = {main="Idris",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Lissome Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Matrimony Band",ring2="Defending Ring",
		back="Lifestream Cape",waist="Fucho-No-Obi",legs="Azimuth Tights",feet="Geo. Sandals +1"} --Bolelabunga/Paguroidea Ring

    sets.idle.Weak = {main="Bolelabunga",sub="Culminus",range="Dunna",
		head="Azimuth Hood +1",neck="Lissome Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Jhakri Robe +1",hands="Bagua Mitaines +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Geo. Sandals +1"}

    -- Defense sets

    sets.defense.PDT = {main="Idris",sub="Culminus",range="Dunna",
		head="Jhakri Coronal +1",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Loquacious Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuff +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Isa Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    sets.defense.MDT = {main="Idris",sub="Culminus",range="Dunna",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Handler's Earring +1",ear2="Loquacious Earring",
		body="Jhakri Robe +1",hands="Telchine Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Isa Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    sets.Kiting = {feet="Geo. Sandals +1"}

    sets.latent_refresh = {waist="Fucho-No-Obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {main="Idris",range="Dunna",
		head="Jhakri Coronal +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Count's Garb",hands="Geo. Mitaines +1",ring1="Petrov Ring",ring2="Varar Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Geo. Pants +1",feet="Geo. Sandals +1"}--K'ayres Ring

	sets.engaged.Acc = {main="Idris",range="Dunna",
		head="Jhakri Coronal +1",neck="Subtley Spec.",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Varar Ring",ring2="Varar Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Elemental Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
	end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 11)
end
