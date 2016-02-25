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
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
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
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

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

    -- Fast cast sets for spells
    sets.precast.FC = {head="Haruspex Hat",body="Taeon Tabard",neck="Jeweled Collar",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	ear2="Loquacious Earring",hands="Thaumas Gloves",back="Swith Cape",waist="Witful Belt",
	legs="Rawhide Trousers",
	feet="Regal Pumps"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Mujin Mantle",neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Karagoz Scarpe"}
    
    sets.precast.JA['Repair'] = {feet="Foire Babouches +1",ear1="Guignol Earring",ear2="Pratik Earring",legs="Desultor Tassets"}

    sets.precast.JA.Maneuver = {neck="Buffoon's Collar +1",body="Karagoz Farsetto",hands="Foire Dastanas +1",back="Dispersal Mantle",ear2="Burana Earring"}



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Taeon Chapeau",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Otro. Harness +1",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Rawhide Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Rawhide Boots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
	neck="Fotia Gorget",back="Rancorous Mantle",legs="Samnuha Tights",feet="Rawhide Boots"})
	
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Samnuha Tights"})

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},waist="Fotia Belt",
	legs="Samnuha Tights",feet="Rawhide Boots",back="Rancorous Mantle",head="Lilitu Headpiece"})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {body="Naga Samue",hands="Rawhide Gloves",neck="Light Gorget",waist="Light Belt"})

    
    -- Midcast Sets

    sets.midcast.FastRecast = {head="Haruspex Hat",body="Taeon Tabard",neck="Jeweled Collar",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	ear1="Mendi. Earring",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Swith Cape",waist="Witful Belt",
	legs={ name="Taeon Tights", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+2',}},
	feet="Regal Pumps"}
        

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {legs="Foire Churidars"}

    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches"}

    sets.midcast.Pet.WeaponSkill = {neck="Empath Necklace",head="Karagoz Capello",body="Karagoz Farsetto",hands="Karagoz Guanti",legs="Karagoz Pantaloni",feet="Naga Kyahan",back="Dispersal Mantle",ear2="Burana Earring",ear1="Cirque Earring",waist="Hurch'lan Sash",ring1="Overbearing Ring"}

    
    -- Sets to return to when not performing an action.
    
	--Burana Earring (PUP) Maneuver effects +1 Automaton: Attack+15 Ranged Attack+15 "Magic Atk. Bonus"+10 "Regen"+2

	--Cirque Earring (PUP) Automaton: Attack+2 Ranged Attack+2 "Magic Atk. Bonus"+2
	
    -- Resting sets
    sets.resting = {head="Pitre Taj",neck="Sanctity Necklace",
		ring1="Dark Ring",ring2="Paguroidea Ring",back="Contriver's Cape",ear2="Burana Earring"}
    
    -- Idle sets

    sets.idle = {ammo="Automat. Oil +3",
		head="Pitre Taj",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Regimen Mittens",ring1="Matrimony Band",ring2="Paguroidea Ring",
		back="Contriver's Cape",waist="Hurch'lan Sash",legs="Karagoz Pantaloni",feet="Hermes' Sandals"}--Burana Earring/Shepherd's Chain

    sets.idle.Town = set_combine(sets.idle, {range="Divinator",main="Denouements"})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {range="Divinator",ammo="Automat. Oil +3",
		head="Pitre Taj",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
		body="Karagoz Farsetto",hands="Regimen Mittens",ring1="Overbearing Ring",ring2="Paguroidea Ring",
		back="Contriver's Cape",waist="Hurch'lan Sash",legs="Karagoz Pantaloni",feet="Naga Kyahan"}--Burana Earring

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",neck="Empath Necklace",
	hands="Regimen Mittens",legs="Karagoz Pantaloni",ear2="Burana Earring",ear1="Cirque Earring",
	waist="Hurch'lan Sash"})

    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",
	legs="Karagoz Pantaloni",feet="Naga Kyahan",ear2="Burana Earring",ear1="Cirque Earring",
	waist="Hurch'lan Sash"})

    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",
	legs="Karagoz Pantaloni",feet="Naga Kyahan",ear2="Burana Earring",ear1="Cirque Earring",
	waist="Hurch'lan Sash"})


    -- Defense sets

    sets.defense.Evasion = {
        head="Dampening Tam",neck="Subtlety Spec.",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Paguroidea Ring",
        back="Dispersal Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Otronif Boots +1"}

    sets.defense.PDT = {
        head="Otronif Mask +1",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Hurch'lan Sash",legs="Otronif Brais +1",feet="Otronif Boots +1"}

    sets.defense.MDT = {
        head="Dampening Tam",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Paguroidea Ring",
        back="Mollusca Mantle",waist="Hurch'lan Sash",legs="Ta'lab Trousers",feet="Otronif Boots +1"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Automat. Oil +3",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Taeon Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Hurch'lan Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Herculean Boots"}--Karagoz Guanti/Karagoz Capello
    sets.engaged.Acc = {ammo="Automat. Oil +3",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Taeon Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Dispersal Mantle",waist="Hurch'lan Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Herculean Boots"}
    sets.engaged.DT = {ammo="Automat. Oil +3",
		head="Taeon Chapeau",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Taeon Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hurch'lan Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Herculean Boots"}
    sets.engaged.Acc.DT = {ammo="Automat. Oil +3",
		head="Dampening Tam",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Taeon Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hurch'lan Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Herculean Boots"}
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
		set_macro_page(1, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 7)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 7)
	else
		set_macro_page(1, 7)
	end
end