
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()

		state.Buff.Doomed = buffactive.doomed or false
        state.Buff.Battuta = buffactive.battuta or false

    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Triple', 'Store_TP', 'Acc', 'PDT')--'PDT', 'MDT', 'Resist', 'MP_Back'
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'MP_Back')
	state.MagicalDefenseMode:options('MDT', 'Resist')
    state.IdleMode:options('Regen', 'Refresh')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = {ammo="Aqreqaq Bomblet",ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",feet="Erilaz Greaves",back="Evasionist's Cape",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
	--Current Enmity :
	
	--ammo="Aqreqaq Bomblet" 					(+2)
	--neck="Unmoving Collar +1" 				(+10)
	--ear1="Friomisi Earring"					(+2)
	--body="Emet Harness +1"					(+10)
	--hands="Kurys Gloves"						(+9)
	--ring1="Petrov Ring"						(+4)
	--back="Evasionist's Cape"					(+1~7)
	--waist="Warwolf Belt"						(+3)
	--legs="Erilaz Leg Guards"					(+10)
	--feet="Erilaz Greaves"						(+5)
	
	--TOTAL:									(+62)
	
	
	---------------------------------------------------------
	
	--Enmity + Gear
	
	--ammo="Sapience Orb" 						(+2)
	--ammo="Aqreqaq Bomblet" 					(+2)
	
	--head="Halitus Helm"               		(+8)
	--neck="Unmoving Collar +1" 				(+10)
	
	--ear1="Cryptic Earring"					(+4)
	--ear1="Friomisi Earring"					(+2)
	
	--ear2="Trux Earring"						(+5)
	--body="Emet Harness +1"					(+10)
	--hands="Kurys Gloves"						(+9)
	
	--ring1="Petrov Ring"						(+4)
	--ring1="Supershear Ring"					(+5)
	
	--ring2="Begrudging Ring"					(+5)
	--back="Evasionist's Cape"					(+1~7)
	--waist="Warwolf Belt"						(+3)
	--legs="Erilaz Leg Guards"					(+10)
	--feet="Rager Ledel. +1"					(+7)
	--feet="Erilaz Greaves"						(+5)
	

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist Coat +1",legs="Futhark Trousers",back="Ogma's Cape"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist Bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau"}
    sets.precast.JA['Liement'] = {body="Futhark Coat"}
    sets.precast.JA['Lunge'] = {ammo="Dosis Tathlum",head="Herculean Helm",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",body="Samnuha Coat",hands="Leyline Gloves",ring1="Acumen Ring",ring2="Fenrir Ring",back="Toro Cape",waist="Salire Belt",legs="Meg. Chausses +1",feet="Herculean Boots"}--Argocham. Mantle,
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea",ear1="Beatific Earring",legs="Rune. Trousers +1"}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


    -- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Khepri Bonnet",neck="Unmoving Collar +1",ear1="Soil Pearl",ear2="Roundel Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"} --head="Lilitu Headpiece"
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {head="Meghanada Visor +1",ear2="Cessance Earring",waist="Ioskeha Belt",back="Letalis Mantle",ammo="Honed Tathlum",ring1="Varar Ring",ring2="Varar Ring",
	hands="Meg. Gloves +1",legs="Meg. Chausses +1",feet="Meg. Jam. +1",body="Meg. Cuirie +1",neck="Subtlety Spectacles",ear1="Steelflash Earring"}
    
	sets.precast.Flourish1 = {head="Dampening Tam",ear2="Cessance Earring",waist="Ioskeha Belt",back="Letalis Mantle",ammo="Honed Tathlum",ring1="Varar Ring",ring2="Varar Ring",
	hands="Meg. Gloves +1",feet="Meg. Jam. +1",legs="Meg. Chausses +1",body="Meg. Cuirie +1",neck="Subtlety Spectacles",ear1="Steelflash Earring"}
	
	
	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
	head="Carmine Mask",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Rawhide Trousers",feet="Carmine Greaves"}--Runeist Bandeau
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers",head="Carmine Mask"})-- Manasa Chasuble / Erilaz Galea / Carmine Mask
    
	sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck="Magoraga Beads", back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
	sets.precast.WS = {ammo="Aqreqaq Bomblet",
	head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Petrov Ring",ring2="Epona's Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Meg. Jam. +1"}--Dampening Tam
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum",head="Dampening Tam",back="Letalis Mantle"})
	
	
	---			Special  Weapon Skills
    
	--Great Sword 			Weapon Skills
	sets.precast.WS['Resolution'] = {ammo="Aqreqaq Bomblet",
		head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ifrit Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Lustratio Leggings"}--Despair Helm / Despair Mail / Despair Fin. Gaunt. / Despair Cuisses / Ogma's Cape
   
   sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, 
        {ammo="Honed Tathlum",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",back="Evasionist's Cape",legs="Meg. Chausses +1"})--Futhark Mitons
		
    sets.precast.WS['Dimidiation'] = {ammo="Ginsen",
		head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ramuh Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Lustratio Subligar",feet="Lustratio Leggings"}-- Futhark Mitons / Rawhide Mask / "Adhemar Bonnet"
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, 
        {ammo="Honed Tathlum",back="Evasionist's Cape"})
    
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Leyline Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})

	sets.precast.WS['Ground Strike'] = {ammo="Aqreqaq Bomblet",
		head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ifrit Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Lustratio Leggings"}

	--Sword 			Weapon Skills
	sets.precast.WS['Savage Blade'] = {ammo="Aqreqaq Bomblet",
		head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ifrit Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Lustratio Leggings"}

	sets.precast.WS['Requiescat'] = {ammo="Aqreqaq Bomblet",
		head="Herculean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Herculean Gloves",ring1="Levia. Ring",ring2="Rufescent Ring",back="Ogma's Cape",waist="Fotia Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	--Axe 				Weapon Skills
	sets.precast.WS['Ruinator'] = {ammo="Aqreqaq Bomblet",
		head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ifrit Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Lustratio Leggings"}

	--Great Axe 		Weapon Skills
	sets.precast.WS['Upheaval'] = {ammo="Aqreqaq Bomblet",
		head="Herculean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Herculean Gloves",ring2="Titan Ring",ring1="Titan Ring",back="Ogma's Cape",waist="Fotia Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	--Club 				Weapon Skills
	sets.precast.WS['Realmrazer'] = {ammo="Aqreqaq Bomblet",
		head="Herculean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Herculean Gloves",ring1="Levia. Ring",ring2="Rufescent Ring",back="Ogma's Cape",waist="Fotia Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	sets.precast.WS['True Strike'] = {ammo="Aqreqaq Bomblet",
		head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Meg. Gloves +1",ring2="Epona's Ring",ring1="Ifrit Ring",back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Lustratio Leggings"}

	sets.precast.WS['Judgement'] = {ammo="Aqreqaq Bomblet",
		head="Herculean Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Herculean Gloves",ring2="Epona's Ring",ring1="Ifrit Ring",back="Ogma's Cape",waist="Fotia Belt",legs="Herculean Trousers",feet="Herculean Boots"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {ammo="Impatiens",
	head="Carmine Mask",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Rawhide Trousers",feet="Carmine Greaves"}--Carmine Mask
	
    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FC, {neck="Incanter's Torque",ear1="Andoaa Earring",hands="Runeist Mitons +1",waist="Siegel Sash",legs="Futhark Trousers",head="Erilaz Galea",ring1="Stikini Ring",ring2="Stikini Ring"})--Manasa Chasuble
    
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau",ring1="Stikini Ring",ring2="Stikini Ring"})
    
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Rune. Bandeau +1",legs="Futhark Trousers",ring1="Stikini Ring",ring2="Stikini Ring"})
    
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {body="Runeist Coat +1",legs="Futhark Trousers",head="Erilaz Galea",ring1="Stikini Ring",ring2="Stikini Ring"})
	
	sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",legs="Futhark Trousers",head="Erilaz Galea",ring1="Stikini Ring",ring2="Stikini Ring"})
    
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring",ring2="Stikini Ring",legs="Futhark Trousers",head="Erilaz Galea"})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring",ring2="Stikini Ring",legs="Futhark Trousers",head="Erilaz Galea"})
	sets.midcast.Shell = sets.midcast.Shellra
	
	sets.midcast.Cure =set_combine(sets.precast.FC, {neck="Incanter's Torque",hands="Buremte Gloves",ring1="Stikini Ring",feet="Futhark Boots",ear1="Mendi. Earring",ear2="Roundel Earring",ring2="Stikini Ring"})

	sets.midcast['Flash'] = sets.enmity
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	--Rune. Bandeau +1
	--Runeist Coat +1
	--Runeist Mitons +1
	--Rune. Trousers +1
	--Runeist Bottes +1
	
    sets.idle = {ammo="Homiliary",
	head="Rawhide Mask",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",body="Futhark Coat",hands="Herculean Gloves",ring1="Matrimony Band",ring2="Defending Ring",back="Evasionist's Cape",waist="Fucho-No-Obi",legs="Rawhide Trousers",feet="Skadi's Jambeaux +1"}--Paguroidea Ring
    
	sets.idle.Town = {main="Montante +1",sub="Duplus Grip",ammo="Homiliary",
	head="Rawhide Mask",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",body="Futhark Coat",hands="Herculean Gloves",ring1="Matrimony Band",ring2="Defending Ring",back="Evasionist's Cape",waist="Fucho-No-Obi",legs="Rawhide Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1"})
	
	---------------------------------------
	-- Defensive Sets
	---------------------------------------
	
	--Meghanada Visor +1	(PDT-4%)
	--Futhark Coat 			(DT-6%)
	--Meg. Cuirie +1		(PDT-7%)
	--Meg. Gloves +1		(PDT-3%)
	--Erilaz Leg Guards		(PDT-6%)
	--Erilaz Greaves        (PDT-4%)
	
	--Mollusca Mantle		(DT-5%)
	--Flume Belt			(PDT-4%)
	--Defending Ring		(DT-10%)
	--Dark Ring				(DT-5%)
	--Twilight Torque		(DT-5%)
	--Evasionist's Cape		(DT-5% / PDT-8%)
	--Staunch Tathlum		(DT-2%)
	
	sets.defense.PDT = {ammo="Staunch Tathlum",head="Meghanada Visor +1",body="Meg. Cuirie +1",hands="Meg. Gloves +1",legs="Erilaz Leg Guards",feet="Erilaz Greaves",ring1="Dark Ring",ring2="Defending Ring",waist="Flume Belt",neck="Twilight Torque",back="Evasionist's Cape"}--PDT-58% DT-33%

	sets.defense.MDT =  set_combine(sets.defense.PDT,  {ammo="Staunch Tathlum",ring1="Dark Ring",ring2="Defending Ring",waist="Engraved Belt",neck="Twilight Torque",ear2="Hearty Earring",head="Dampening Tam",body="Futhark Coat"})--DT-33% MDT-37%

	sets.defense.Resist = set_combine(sets.defense.PDT, {ammo="Staunch Tathlum",waist="Engraved Belt",neck="Warder's Charm +1",hands="Erilaz Gauntlets",legs="Rune. Trousers +1",feet="Erilaz Greaves",ear2="Hearty Earring"})
	
	sets.defense.MP_Back = set_combine(sets.defense.PDT, {body="Erilaz Surcoat"})
	
	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	sets.latent_refresh = {waist="Fucho-No-Obi"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Ginsen",
	head="Skormoth Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",back="Ogma's Cape",waist="Ioskeha Belt",legs="Meg. Chausses +1",feet="Herculean Boots"}
    
	sets.engaged.Triple = {ammo="Ginsen",
	head="Skormoth Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Herculean Boots"}
	
	sets.engaged.Store_TP = set_combine(sets.engaged,  {ammo="Ginsen",
	head="Carmine Mask",neck="Lissome Necklace",ring1="Petrov Ring",ring2="Epona's Ring",
	legs="Samnuha Tights",waist="Kentarch Belt",feet="Carmine Greaves"})
	
    sets.engaged.Acc = set_combine(sets.engaged, {ammo="Honed Tathlum",head="Meghanada Visor +1",neck="Subtlety Spec.",hands="Meg. Gloves +1",waist="Ioskeha Belt",legs="Meg. Chausses +1",feet="Meg. Jam. +1",back="Ogma's Cape",ring1="Varar Ring",ring2="Varar Ring",ear1="Steelflash Earring",ear2="Cessance Earring"})
    
	sets.engaged.PDT = {ammo="Staunch Tathlum",head="Meghanada Visor +1",body="Meg. Cuirie +1",hands="Meg. Gloves +1",legs="Erilaz Leg Guards",feet="Erilaz Greaves",ring1="Dark Ring",ring2="Defending Ring",waist="Flume Belt",neck="Twilight Torque",back="Evasionist's Cape"}
    
	sets.engaged.MDT = set_combine(sets.engaged.PDT, {ammo="Staunch Tathlum",ring1="Dark Ring",ring2="Defending Ring",waist="Engraved Belt",neck="Twilight Torque",ear2="Hearty Earring",head="Dampening Tam",body="Futhark Coat"})
    
	sets.engaged.Resist = set_combine(sets.engaged.PDT, {ammo="Staunch Tathlum",waist="Engraved Belt",neck="Warder's Charm +1",hands="Erilaz Gauntlets",legs="Rune. Trousers +1",feet="Erilaz Greaves",ear2="Hearty Earring"})
	
	sets.engaged.MP_Back = set_combine(sets.engaged.PDT, {body="Erilaz Surcoat"})
	
	sets.engaged.Repulse = set_combine(sets.engaged.PDT,  {back="Repulse Mantle"})

	
	sets.buff.Battuta = {legs="Rawhide Trousers",feet="Futhark Boots"}
	sets.buff.Doomed = {ring2="Saida Ring"}
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)  
    if state.Buff.Battuta then
                meleeSet = set_combine(meleeSet, sets.buff.Battuta)
        end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
		return meleeSet
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist="Hachirin-No-Obi"})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Blue Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	--if spell.skill == 'Blue Magic' then
      --  if state.MagicBurst.value then
        --equip(sets.magic_burst)
        --end
	--end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 14)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 14)
	else
		set_macro_page(1, 14)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    --add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)