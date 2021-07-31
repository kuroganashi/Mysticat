-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
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
    state.OffenseMode:options('Normal', 'Acc', 'Special', 'Hizamaru', 'Mod')
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
		head="Hizamaru Somen +1",neck="Faith Torque",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Hes. Gloves +1",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Melee Cape",legs="Samnuha Tights",feet="Rawhide Boots"}

	sets.precast.JA['Footwork'] = {feet="Bhikku Gaiters"}--Segomo's Mantle

	sets.precast.JA['Perfect Counter'] = {head="Bhikku Crown"}
	
	sets.precast.JA['Formless Strikes'] = {body="Melee Cyclas +2"}

	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chakra'] = {ammo="Tantra Tathlum",
		head="Lilitu Headpiece",neck="Unmoving Collar +1",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Anch. Cyclas +1",hands="Hes. Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}

	sets.precast.JA['Provoke'] = sets.enmity
    
	-- Waltz set (chr and vit)
 sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Khepri Bonnet",neck="Unmoving Collar +1",ear1="Soil Pearl",ear2="Soil Pearl",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"} --head="Lilitu Headpiece"
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {head="Alhazen Hat",ear2="Cessance Earring",waist="Hurch'lan Sash",back="Letalis Mantle",ammo="Honed Tathlum",ring1="Varar Ring",ring2="Varar Ring",
	hands="Hizamaru Kote +1",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1",body="Hiza. Haramaki +1",neck="Subtlety Spectacles",ear1="Digni. Earring"}
    
	sets.precast.Flourish1 = {head="Dampening Tam",ear2="Cessance Earring",waist="Hurch'lan Sash",back="Letalis Mantle",ammo="Honed Tathlum",ring1="Varar Ring",ring2="Varar Ring",
	hands="Hes. Gloves +1",feet="Herculean Boots",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},neck="Subtlety Spectacles",ear1="Digni. Earring"}

	

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",head="Herculean Helm",neck="Voltsurge Torque",body="Taeon Tabard",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Rawhide Trousers",
	hands="Leyline Gloves",back="Mujin Mantle"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Knobkierrie",
		head="Hizamaru Somen +1",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Ifrit Ring",
		back="Buquwik Cape",waist="Fotia Belt",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1"}--Anch. Cyclas +1
    sets.precast.WSAcc = {ammo="Honed Tathlum",body="Hiza. Haramaki +1",back="Letalis Mantle",waist="Hurch'lan Sash",head="Hizamaru Somen +1"}
    sets.precast.WSMod = {ammo="Tantra Tathlum"}
    sets.precast.MaxTP = {ear1="Sherida Earring",ear2="Moonshade Earring"}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.
    
    -- legs={name="Samnuha Tights", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%','STR+8'}}}

    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {legs="Samnuha Tights"})
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {ear1="Sherida Earring",ear2="Moonshade Earring",ring2="Varar Ring",back="Vespid Mantle",waist="Moonbow Belt"})
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",ring1="Petrov Ring",back="Buquwik Cape"})
    
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {
	ammo="Knobkierrie",
	neck="Fotia Gorget",
	waist="Moonbow Belt",
	ear1="Sherida Earring",
	ear2="Moonshade Earring",
	ring1="Begrudging Ring",
	ring2="Epona's Ring",
	back="Rancorous Mantle",
	head="Rao Kabuto",
	body="Hiza. Haramaki +1",
	hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
	legs="Rao Haidate",
	feet={ name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}}})
	
	--Rancorous Mantle/Justiciar's Torque})--neck="Rancor Collar/Rufescent Ring/Ifrit Ring
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {neck="Fotia Gorget",back="Vespid Mantle",waist="Moonbow Belt",ring2="Epona's Ring",ring1="Ramuh Ring",
	body="Naga Samue",hands="Rawhide Gloves",head="Hizamaru Somen +1",ammo="Falcon Eye",legs="Samnuha Tights",feet="Rawhide Boots"})
	--body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}}
    sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {ammo="Tantra Tathlum"})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {ear1="Sherida Earring",ear2="Moonshade Earring"})

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
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Fenrir Ring",ring2="Epona's Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Herculean Helm",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",back="Mujin Mantle",legs="Rawhide Trousers",
		waist="Moonbow Belt",feet="Rawhide Boots"}
        
    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Impatiens",
		head="Herculean Helm",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Magoraga Beads",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",back="Mujin Mantle",
		waist="Moonbow Belt",legs="Rawhide Trousers",feet="Rawhide Boots"}

    
    -- Sets to return to when not performing an action.
    
	--legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}}
	
	--Hizamaru Somen +1
	--Hizamaru Haramaki
	--Hizamaru Kote +1
	--Hiza. Hizayoroi +1 
	--Hiza. Sune-ate +1
	
	--body="Adhemar Jacket"
	--body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}}
	
    -- Resting sets
    sets.resting = {head="Rao Kabuto",neck="Sanctity Necklace",back="Melee cape",ear1="Infused Earring",
		body="Hiza. Haramaki +1",hands="Rao Kote",legs="Rao Haidate",feet="Rao Sune-ate",ring1="Chirich Ring",ring2="Chirich Ring"}

    -- Idle sets
    sets.idle = {ammo="Ginsen",
		head="Rao Kabuto",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Rao Kote",ring1="Matrimony Band",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Rao Haidate",feet="Hermes' Sandals"}--Infused Earring

    sets.idle.Town = {main="Denouements",ammo="Ginsen",
		head="Rao Kabuto",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Rao Kote",ring1="Matrimony Band",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Rao Haidate",feet="Hermes' Sandals"}
    
    sets.idle.Weak = {ammo="Ginsen",
		head="Rao Kabuto",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Rao Kote",ring1="Matrimony Band",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Rao Haidate",feet="Hermes' Sandals"}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Herculean Helm",neck="Twilight Torque",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}

    sets.defense.HP = {ammo="Tantra Tathlum",
		head="Herculean Helm",neck="Twilight Torque",
		body="Emet Harness +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Bleating Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	sets.defense.EVASION = {ammo="Tantra Tathlum",
		head="Hizamaru Somen +1",neck="Asperity Necklace",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Moonbow Belt",legs="Hizamaru Hizayoroi +1",feet="Hizamaru Sune-Ate +1"}		
		
    sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Skormoth Mask",neck="Twilight Torque",
		body="Emet Harness +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Ta'lab Trousers",feet="Herculean Boots"}

    sets.Kiting = {feet="Hermes' Sandals"}

    sets.ExtraRegen = {head="Rao Kabuto",body="Hiza. Haramaki +1",hands="Rao Kote",legs="Rao Haidate",feet="Rao Sune-ate",neck="Sanctity Necklace",ring1="Chirich Ring",ring2="Chirich Ring",ear1="Infused Earring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {ammo="Ginsen",
		head="Skormoth Mask",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}
    sets.engaged.SomeAcc = {ammo="Amar Cluster",
		head="Adhemar Bonnet",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Anch. Cyclas +1",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Varar Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Herculean Boots"}
    sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Hizamaru Somen +1",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Cacoethic Ring +1",ring2="Varar Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1"}
		--Alhazen Hat
		--Amar Cluster
	sets.engaged.Special = {ammo="Ginsen",
		head="Skormoth Mask",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Bhikku Cyclas",hands="Bhikku Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Moonbow Belt",legs="Bhikku Hose",feet="Herculean Boots"}
	sets.engaged.Hizamaru = {ammo="Ginsen",
		head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Moonbow Belt",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}
    sets.engaged.Mod = {ammo="Ginsen",
		head="Adhemar Bonnet",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Ginsen",
		head="Herculean Helm",neck="Twilight Torque",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}
    sets.engaged.SomeAcc.PDT = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Herculean Boots"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Herculean Boots"}
    sets.engaged.EVASION = {ammo="Ginsen",
		head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Moonbow Belt",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1"}
	sets.engaged.SomeAcc.EVASION = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Petrov Ring",ring2="Varar Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Acc.EVASION = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Varar Ring",ring2="Varar Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Counter = {ammo="Amar Cluster",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Otro. Harness +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back={ name="Anchoret's Mantle", augments={'STR+1','DEX+3','"Subtle Blow"+4','"Counter"+5',}},
		waist="Moonbow Belt",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}
    sets.engaged.Acc.Counter = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Otro. Harness +1",hands="Hes. Gloves +1",ring1="Varar Ring",ring2="Varar Ring",
		back={ name="Anchoret's Mantle", augments={'STR+1','DEX+3','"Subtle Blow"+4','"Counter"+5',}},
		waist="Hurch'lan Sash",legs="Ta'lab Trousers",feet="Herculean Boots"}


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas"})


    -- Footwork combat form
    sets.engaged.Footwork = {ammo="Ginsen",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Moonbow Belt",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}--Segomo's Mantle
    sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Alhazen Hat",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Varar Ring",ring2="Varar Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Ta'lab Trousers",feet="Soku. Sune-Ate"}--Segomo's Mantle
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas"}
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