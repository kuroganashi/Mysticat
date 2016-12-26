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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

	sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Assiduity Pants +1",feet="Regal Pumps +1"}
	
    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
        body="Vanir Cotehardie",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendi. Earring",body="Nefer Kalasiris", back="Pahtli Cape",legs="Nares Trews"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hagondes Hat",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Rajas Ring",ring2="Acumen Ring",
        back="Bane Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Umbani Boots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="Acumen Ring",
        back="Bane Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Umbani Boots"}
    
		sets.precast.WS['Myrkr'] = {ammo="Dosis Tathlum",
		head="Kaabanax Hat",neck="Eddy Necklace",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Fucho-No-Obi",legs="Nares Trews",feet="Regal Pumps +1"}

    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {ammo="Impatiens",
        head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Serenity",ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Nares Trews",feet="Regal Pumps +1"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
		neck="Colossus's Torque",head="Umuthi Hat",
		body="Manasa Chasuble",hands="Ayao's Gages",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		legs="Portent Pants"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose",head="Umuthi Hat"})

    sets.midcast['Enfeebling Magic'] = {main="Keraunos",sub="Zuuxowu Grip",ammo="Kalboron Stone",
		head="Welkin Crown",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Keraunos",sub="Zuuxowu Grip",ammo="Kalboron Stone",
		head="Welkin Crown",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast.Drain = {main="Keraunos",sub="Zuuxowu Grip",ammo="Kalboron Stone",
		head="Appetence Crown",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Fucho-No-Obi",legs="Lengo Pants",feet="Umbani Boots"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Keraunos",sub="Zuuxowu Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast.BardSong = {main="Keraunos",sub="Zuuxowu Grip",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Keraunos",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Welkin Crown",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast['Elemental Magic'].Resistant = {main="Keraunos",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Welkin Crown",neck="Eddy Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Acumen Ring",
		back="Bane Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Keraunos", sub="Zuuxowu Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Weatherspoon Ring",ring2="Prolix Ring",
        back="Swith Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Regal Pumps +1"}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Wivre Hairpin",neck="Lissome Necklace",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Keraunos", sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Welkin Crown",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Hagondes Pants",feet="Serpentes Sabots"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Keraunos",ammo="Impatiens",
        head="Hagondes Hat",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Bokwus Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    -- Town gear.
    sets.idle.Town = {main="Keraunos", sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Welkin Crown",neck="Lissome Necklace",ear1="Barkarole Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",sub="Zuuxowu Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Hagondes Coat",hands="Bokwus Gloves",ring2="Defending Ring",ring1="Dark Ring",
        back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Umbani Boots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring2="Defending Ring",ring1="Dark Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Umbani Boots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}
	sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
    sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Dosis Tathlum",
		head="Welkin Crown",neck="Arciela's Grace +1",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Lengo Pants",feet="Umbani Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
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
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end