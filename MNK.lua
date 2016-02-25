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
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT', 'EVASION', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'EVASION')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose"}

	sets.precast.JA['Boost'] = {hands="Anch. Gloves +1"}

	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters"}

	sets.precast.JA['Focus'] = {head="Temple Crown"}

	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chi Blast'] = {
		head="Melee Crown +2",neck="Faith Torque",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Hes. Gloves +1",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Melee Cape",legs="Samnuha Tights",feet="Rawhide Boots"}

	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}

	sets.precast.JA['Perfect Counter'] = {head="Tantra Crown +2"}
	
	sets.precast.JA['Formless Strikes'] = {body="Melee Cyclas +2"}

	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chakra'] = {ammo="Tantra Tathlum",
		head="Lilitu Headpiece",neck="Tjukurrpa Medal",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Anch. Cyclas +1",hands="Hes. Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}

    -- Waltz set (chr and vit)
 sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Khepri Bonnet",neck="Tjukurrpa Medal",ear1="Soil Pearl",ear2="Soil Pearl",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"} --head="Lilitu Headpiece"
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {head="Alhazen Hat",ear2="Choreia Earring",waist="Anguinus Belt",back="Letalis Mantle",ammo="Honed Tathlum",
	hands="Leyline Gloves",legs="Samnuha Tights",feet="Taeon Boots",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},neck="Subtlety Spectacles",ear1="Steelflash Earring"}
    sets.precast.Flourish1 = {head="Dampening Tam",ear2="Choreia Earring",waist="Anguinus Belt",back="Letalis Mantle",ammo="Honed Tathlum",
	hands="Hes. Gloves +1",feet="Taeon Boots",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},neck="Subtlety Spectacles",ear1="Steelflash Earring"}


    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",head="Anwig Salade",neck="Jeweled Collar",body="Mirke Wardecors",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	hands="Leyline Gloves",back="Mujin Mantle"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Potestas Bomblet",
		head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Anch. Gloves +1",ring1="Rajas Ring",ring2="Ifrit Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Rawhide Boots"}--Anch. Cyclas +1
    sets.precast.WSAcc = {ammo="Honed Tathlum",body="Anch. Cyclas +1",back="Letalis Mantle",waist="Anguinus Belt",head="Dampening Tam"}
    sets.precast.WSMod = {ammo="Tantra Tathlum"}
    sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.
    
    -- legs={name="Samnuha Tights", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8'}}}

    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {legs="Samnuha Tights"})
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {
        ear1="Brutal Earring",ear2="Moonshade Earring",ring2="Mars's Ring",back="Vespid Mantle"})
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",ring1="Rajas Ring",back="Buquwik Cape"})
    sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {neck="Fotia Gorget",
	ear1="Brutal Earring",ear2="Moonshade Earring",waist="Fotia Belt",hands="Anch. Gloves +1",ring1="Rufescent Ring",ring2="Epona's Ring",
	body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},back="Buquwik Cape",head="Uk'uxkaj Cap",feet="Rawhide Boots"})--Rancorous Mantle/Justiciar's Torque})--neck="Rancor Collar/Rufescent Ring/Ifrit Ring
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {neck="Fotia Gorget",back="Vespid Mantle",waist="Fotia Belt",ring2="Epona's Ring",ring1="Ramuh Ring",
	body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Rawhide Gloves",head="Uk'uxkaj Cap",ammo="Honed Tathlum",feet="Rawhide Boots"})
    sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {ammo="Tantra Tathlum"})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {ear1="Bladeborn Earring",ear2="Steelflash Earring"})

    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    sets.precast.WS["Raging Fists"].Mod = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    sets.precast.WS["Howling Fist"].Mod = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    sets.precast.WS["Asuran Fists"].Mod = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    sets.precast.WS["Shijin Spiral"].Mod = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    sets.precast.WS["Dragon Kick"].Mod = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    sets.precast.WS["Tornado Kick"].Mod = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)


    sets.precast.WS['Cataclysm'] = {
        head="Dampening Tam",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Otronif Gloves +1",ring1="Fenrir Ring",ring2="Epona's Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Taeon Boots"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Anwig Salade",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Jeweled Collar",
		body="Mirke Wardecors",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",back="Mujin Mantle",
		waist="Black Belt",feet="Rawhide Boots"}
        
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Impatiens",
		head="Anwig Salade",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Magoraga Beads",
		body="Mirke Wardecors",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",back="Mujin Mantle",
		waist="Black Belt",legs="Otronif Brais +1",feet="Rawhide Boots"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Uk'uxkaj Cap",neck="Lissome Necklace",back="Melee cape",
		body="Melee Cyclas +2",hands="Hes. Gloves +1",ring1="Matrimony Band",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {ammo="Ginsen",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Hes. Gloves +1",ring1="Matrimony Band",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Hermes' Sandals"}--Steelflash Earring / Bladeborn Earring

    sets.idle.Town = {main="Denouements",ammo="Ginsen",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Hes. Gloves +1",ring1="Matrimony Band",ring2="Paguroidea Ring",
		back="Bleating Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Hermes' Sandals"}
    
    sets.idle.Weak = {ammo="Ginsen",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Matrimony Band",ring2="Paguroidea Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Hermes' Sandals"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Tantra Tathlum",
		head="Otronif Mask +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais",feet="Otronif Boots +1"}

    sets.defense.HP = {ammo="Tantra Tathlum",
		head="Otronif Mask +1",neck="Twilight Torque",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.defense.EVASION = {ammo="Tantra Tathlum",
		head="Taeon Chapeau",neck="Asperity Necklace",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Hippomenes Socks"}		
		
    sets.defense.MDT = {ammo="Tantra Tathlum",
		head="Taeon Chapeau",neck="Twilight Torque",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Ta'lab Trousers",feet="Taeon Boost"}

    sets.Kiting = {feet="Hermes' Sandals"}

    sets.ExtraRegen = {head="Ocelomeh Headpiece +1",neck="Lissome Necklace"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Ginsen",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
    sets.engaged.SomeAcc = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Anch. Cyclas +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Taeon Boots"}
    sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Anch. Cyclas +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Taeon Boots"}
    sets.engaged.Mod = {ammo="Ginsen",
		head="Otronif Mask +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Ginsen",
		head="Otronif Mask +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}
    sets.engaged.SomeAcc.PDT = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}
    sets.engaged.EVASION = {ammo="Ginsen",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Hippomenes Socks"}
	sets.engaged.SomeAcc.EVASION = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Hippomenes Socks"}
	sets.engaged.Acc.EVASION = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet="Hippomenes Socks"}
	sets.engaged.Counter = {ammo="Ginsen",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Otro. Harness +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back={ name="Anchoret's Mantle", augments={'STR+1','DEX+3','"Subtle Blow"+4','"Counter"+5',}},
		waist="Windbuffet Belt",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}
    sets.engaged.Acc.Counter = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Otro. Harness +1",hands="Hes. Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back={ name="Anchoret's Mantle", augments={'STR+1','DEX+3','"Subtle Blow"+4','"Counter"+5',}},
		waist="Anguinus Belt",legs="Ta'lab Trousers",feet="Otronif Boots +1"}


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Tantra Cyclas +2"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Tantra Cyclas +2"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Tantra Cyclas +2"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Tantra Cyclas +2"})


    -- Footwork combat form
    sets.engaged.Footwork = {ammo="Ginsen",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}
    sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Tantra Cyclas +2"}
    sets.footwork_kick_feet = {feet="Anchorite's Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Fodder' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 1)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(8, 1)
    else
        set_macro_page(3, 1)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end