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
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Frame'] = 'Magic',
        ['Stormwaker Frame'] = 'Heal',
        ['Stormwaker Frame'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Martial_Arts', 'Hizamaru')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion', 'PetDT')
	state.IdleMode:options('Normal', 'PetDT')
	
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    update_pet_mode()
    select_default_macro_book()
end


-- Define sets used by this job file.
function init_gear_sets()
    	
    -- Precast Sets

    sets.precast.Step = {head="Alhazen Hat",ear2="Cessance Earring",waist="Incarnation Sash",back="Dispersal Mantle",ring1="Varar Ring",ring2="Varar Ring",
	hands="Hizamaru Kote +1",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1",body="Hiza. Haramaki +1",neck="Subtlety Spectacles",ear1="Digni. Earring"}
    
	sets.precast.Flourish1 = {head="Hizamaru Somen +1",ear2="Cessance Earring",waist="Incarnation Sash",back="Dispersal Mantle",ring1="Varar Ring",ring2="Varar Ring",
	hands="Hizamaru Kote +1",feet="Herculean Boots",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},neck="Subtlety Spectacles",ear1="Digni. Earring"}	
	
	
    -- Fast cast sets for spells
    sets.precast.FC = {head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	ear2="Loquacious Earring",hands="Thaumas Gloves",back="Ogapepo Cape",waist="Witful Belt",
	legs="Rawhide Trousers",
	feet="Regal Pumps +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Mujin Mantle",neck="Magoraga Beads"})

    -- Precast sets to enhance JAs
	sets.precast.JA['Overdrive'] = {body="Pitre Tobe +1"}
	
    sets.precast.JA['Tactical Switch'] = {feet="Karagoz Scarpe"}
    
    sets.precast.JA['Repair'] = {feet="Foire Babouches +1",ear1="Guignol Earring",ear2="Pratik Earring",legs="Desultor Tassets"}

    sets.precast.JA.Maneuver = {main="Midnights",neck="Buffoon's Collar +1",body="Karagoz Farsetto",hands="Foire Dastanas +1",back="Visucius's Mantle",ear1="Burana Earring"}

	sets.precast.JA['Provoke'] = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Herculean Helm",neck="Unmoving Collar +1",ear2="Roundel Earring",ear1="Soil Pearl",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Hizamaru Somen +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Fotia Belt",legs="Rao Haidate",feet="Hiza. Sune-ate +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
	neck="Fotia Gorget",waist="Fotia Belt",back="Rancorous Mantle",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"})
	
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Hiza. Hizayoroi +1"})

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
	neck="Fotia Gorget",
	body="Hiza. Haramaki +1",
	waist="Moonbow Belt",
	ear1="Brutal Earring",
	ring1="Begrudging Ring",
	ring2="Epona's Ring",
	legs="Rao Haidate",
	hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
	feet={ name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}},
	back="Dispersal Mantle",
	head="Rao Kabuto"})--Rao Haidate / Hiza. Hizayoroi +1

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",body="Naga Samue",hands="Rawhide Gloves",legs="Samnuha Tights",neck="Fotia Gorget",waist="Moonbow Belt"})
    
    -- Midcast Sets

    sets.midcast.FastRecast = {head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	ear1="Mendi. Earring",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Swith Cape",waist="Witful Belt",
	legs="Rawhide Trousers",
	feet="Regal Pumps +1"}
        

    -- Midcast sets for pet actions
        sets.midcast.Pet.Cure = {range="Animator P II",ear2="Enmerkar Earring",back="Visucius's Mantle",legs="Foire Churidars +1",waist="Ukko Sash"}

		sets.midcast.Pet['Elemental Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash"}

		sets.midcast.Pet['Enfeebling Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash"}
	
		sets.midcast.Pet['Dark Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash"}
	
		sets.midcast.Pet['Divine Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash"}
	
		sets.midcast.Pet['Enhancing Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash"}
    
	--Set for Pet Weapon Skill DMG MAX
	
	sets.midcast.Pet.Weaponskill = {neck="Empath Necklace",head="Karagoz Capello",body="Tali'ah Manteel +1",hands="Karagoz Guanti",legs="Karagoz Pantaloni",feet="Naga Kyahan",back="Dispersal Mantle",ear1="Burana Earring",ear2="Enmerkar Earring",waist="Incarnation Sash",ring1="Overbearing Ring",ring2="Varar Ring"}

	--legs="Kara. Pantaloni +1"
    
    -- Sets to return to when not performing an action.
    
	--Burana Earring (PUP) Maneuver effects +1 Automaton: Attack+15 Ranged Attack+15 "Magic Atk. Bonus"+10 "Regen"+2

	--Cirque Earring (PUP) Automaton: Attack+2 Ranged Attack+2 "Magic Atk. Bonus"+2
	
	
	--Hizamaru Somen +1
	--Hiza. Haramaki +1
	--Hizamaru Kote +1
	--Hiza. Hizayoroi +1 
	--Hiza. Sune-ate +1
	
	----body="Foire Tobe +1"
	
    -- Resting sets
    sets.resting = {head="Pitre Taj +1",neck="Sanctity Necklace",
        ring1="Chirich Ring",ring2="Chirich Ring",back="Contriver's Cape",ear1="Infused Earring",waist="Isa Belt",feet="Rao Sune-Ate",legs="Rao Haidate",hands="Rao Kote"}
    
    -- Idle sets

    sets.idle = {ammo="Automat. Oil +3",
		head="Pitre Taj +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Burana Earring",
		body="Hiza. Haramaki +1",hands="Rao Kote",ring1="Matrimony Band",ring2="Defending Ring",
		back="Contriver's Cape",waist="Isa Belt",legs="Rao Haidate",feet="Hermes' Sandals"}--Sanctity Necklace/Burana Earring/Shepherd's Chain/Infused Earring

    sets.idle.Town = set_combine(sets.idle, {range="Animator P +1",main="Ohtas"})
	--Denouements
	--Ohtas
	--Midnights
	
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {range="Animator P +1",ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Domes. Earring",
		body="Pitre Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Naga Kyahan"}--Handler's Earring/Burana Earring

		--Pet: Damage Taken set
	sets.idle.Pet.PetDT = set_combine(sets.idle.Pet.Engaged,  {range="Animator P +1",ammo="Automat. Oil +3",
		head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
		body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"})--PDT-26% 
		
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {range="Animator P +1",neck="Empath Necklace",
	hands="Tali'ah Gages +1",legs="Tali'ah Sera. +1",ear1="Burana Earring",ear2="Enmerkar Earring",back="Visucius's Mantle",
	waist="Incarnation Sash"})

    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",
	legs="Tali'ah Sera. +1",feet="Naga Kyahan",hands="Naga Tekko",
	ear1="Burana Earring",ear2="Enmerkar Earring",back="Argochampsa Mantle",
	waist="Incarnation Sash"})

	sets.idle.Pet.Engaged.Heal = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",
	legs="Tali'ah Sera. +1",feet="Naga Kyahan",hands="Tali'ah Gages +1",ear1="Burana Earring",ear2="Enmerkar Earring",back="Visucius's Mantle",
	waist="Incarnation Sash"})
	
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",
	legs="Tali'ah Sera. +1",feet="Naga Kyahan",hands="Naga Tekko",
	ear1="Burana Earring",ear2="Enmerkar Earring",back="Argochampsa Mantle",
	waist="Incarnation Sash"})


    -- Defense sets

    sets.defense.Evasion = {
        head="Herculean Helm",neck="Subtlety Spectacles",ear1="Infused Earring",
        body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Varar Ring",ring2="Defending Ring",
        back="Dispersal Mantle",waist="Incarnation Sash",legs="Herculean Trousers",feet="Herculean Boots"}

    sets.defense.PDT = {
        head="Herculean Helm",neck="Twilight Torque",
        body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Incarnation Sash",legs="Herculean Trousers",feet="Herculean Boots"}

	sets.defense.PetDT = {range="Animator P +1",ammo="Automat. Oil +3",
		head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
		body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"}
		
    sets.defense.MDT = {head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
		body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"}

	--head="Herculean Helm",neck="Twilight Torque",
    --body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
    --back="Solemnity Cape",waist="Incarnation Sash",legs="Ta'lab Trousers",feet="Herculean Boots"	
		
    sets.Kiting = {head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
		body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"}
	--feet="Hermes' Sandals"
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Automat. Oil +3",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"}--Karagoz Guanti/Karagoz Capello/Hurch'lan Sash/Clotharius Torque/Dispersal Mantle
    sets.engaged.Acc = {ammo="Automat. Oil +3",
		head="Hizamaru Somen +1",neck="Subtlety Spectacles",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Incarnation Sash",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}
	sets.engaged.Martial_Arts = {ammo="Automat. Oil +3",
		head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Incarnation Sash",legs="Karagoz Pantaloni",feet="Herculean Boots"}
	sets.engaged.Hizamaru = {ammo="Automat. Oil +3",
		head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Incarnation Sash",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}
	sets.engaged.DT = {ammo="Automat. Oil +3",
		head="Herculean Helm",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Incarnation Sash",legs="Herculean Trousers",feet="Herculean Boots"}
    sets.engaged.Acc.DT = {ammo="Automat. Oil +3",
		head="Dampening Tam",neck="Twilight Torque",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Incarnation Sash",legs="Herculean Trousers",feet="Herculean Boots"}
	------------------------------------------------------------------------------
	-- When Pet is Engaged this what will be Equiped for armor while your weapons are Drawn.
	------------------------------------------------------------------------------
	sets.engaged.PetEngaged = {range="Animator P +1",ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Domes. Earring",
		body="Pitre Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Naga Kyahan"}
		
	sets.engaged.PetEngaged.PetDT = set_combine(sets.idle.Pet.Engaged,  {range="Animator P +1",ammo="Automat. Oil +3",
		head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
		body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
		back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"})--Pet: Damage Taken set
		
    sets.engaged.PetEngaged.Ranged = set_combine(sets.idle.Pet.Engaged, {range="Animator P +1",neck="Empath Necklace",
	hands="Tali'ah Gages +1",legs="Tali'ah Sera. +1",ear1="Domes. Earring",ear2="Enmerkar Earring",back="Visucius's Mantle",
	waist="Incarnation Sash"})

    sets.engaged.PetEngaged.Nuke = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",ammo="Automat. Oil +3",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"})

	sets.engaged.PetEngaged.Heal = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",ammo="Automat. Oil +3",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"})
	
    sets.engaged.PetEngaged.Magic = set_combine(sets.idle.Pet.Engaged, {range="Animator P II",ammo="Automat. Oil +3",
		head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Moonbow Belt",legs="Herculean Trousers",feet="Herculean Boots"})
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Engage updates

function job_handle_equipping_gear(playerStatus, eventArgs)
    classes.CustomMeleeGroups:clear()
    if pet.status=="Engaged" then
        classes.CustomMeleeGroups:append('PetEngaged')
        classes.CustomMeleeGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
        
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
        add_to_chat(122,petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 13)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 13)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 13)
	else
		set_macro_page(1, 13)
	end
end