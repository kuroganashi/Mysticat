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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	
	state.MagicBurst = M(false, 'Magic Burst')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Ogapepo Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"} --Nahtirah Hat
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash",feet="Regal Pumps +1"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {neck="Nodens Gorget",feet="Regal Pumps +1"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons",feet="Regal Pumps +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Tamaxchi",sub="Sors Shield",ammo="Impatiens",hands="Bokwus Gloves",
	body="Nefer Kalasiris",ear2="Glorious Earring",ear1="Mendi. Earring",back="Pahtli Cape",neck="Aceso's Choker +1",feet="Hygieia Clogs +1"}) --body="Heka's Kalasris",ear2="Glorious Earring",feet="Hygieia Clogs +1"
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Ebers Bliaud",hands="Loagaeth Cuffs",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
		head="Ebers Cap",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Ebers Bliaud",hands="Loagaeth Cuffs",ring1="Rajas Ring",ring2="Rufescent Ring",
		back="Searing Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Medium's Sabots"}--Fanatic Gloves
    
    sets.precast.WS['Flash Nova'] = {ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Ebers Bliaud",hands="Loagaeth Cuffs",ring1="Fenrir Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"}--Fanatic Gloves
		
	sets.precast.WS['Realmrazer'] = {
		head="Ebers Cap",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Ebers Bliaud",hands="Loagaeth Cuffs",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Searing Cape",waist="Fotia Belt",legs="Lengo Pants",feet="Medium's Sabots"}--Fanatic Gloves
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Ogapepo Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}
    
    -- Cure sets
    gear.default.obi_waist = "Witful Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Tamaxchi",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Hygieia Clogs +1"} --body="Heka's Kalasris"/Glorious Earring/Hygieia Clogs +1

    sets.midcast.Cure = {main="Tamaxchi",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Hygieia Clogs +1"}--Hygieia Clogs +1

    sets.midcast.Curaga = {main="Tamaxchi",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Hygieia Clogs +1"}--Hygieia Clogs +1

    sets.midcast.CureMelee = {main="Tamaxchi",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Hygieia Clogs +1"}--Hygieia Clogs +1

    sets.midcast.Cursna = {main="Beneficus",ammo="Impatiens",
		head="Ebers Cap",neck="Malison Medallion",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ebers Bliaud",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Prolix Ring",
		back="Mending Cape",waist="Witful Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

    sets.midcast.StatusRemoval = {ammo="Impatiens",back="Mending Cape",neck="Orison Locket",hands="Gende. Gages +1",feet="Regal Pumps +1",
		head="Ebers Cap",legs="Ebers Pantaloons",waist="Witful Belt",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Beneficus",ammo="Impatiens",
		body="Manasa Chasuble",hands="Gende. Gages +1",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",head="Umuthi Hat",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Piety Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Stoneskin = {ammo="Impatiens",
		head="Umuthi Hat",neck="Nodens Gorget",ear2="Loquacious Earring",ear1="Earthcry Earring",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring2="Prolix Ring",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Haven Hose",feet="Regal Pumps +1"}

    sets.midcast.Auspice = {ammo="Impatiens",hands="Gende. Gages +1",ear1="Mendi. Earring",ear2="Loquacious Earring",feet="Ebers Duckbills",
	waist="Siegel Sash",ring1="Weatherspoon Ring",ring2="Prolix Ring"}

    sets.midcast.BarElement = {main="Beneficus",ammo="Impatiens",
		head="Ebers Cap",neck="Colossus's Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ebers Bliaud",hands="Ebers Mitts",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Ebers Pantaloons",feet="Ebers Duckbills"}

    sets.midcast.Regen = {main="Bolelabunga",ammo="Impatiens",
		body="Piety Briault",hands="Ebers Mitts",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",head="Umuthi Hat",feet="Regal Pumps +1",
		legs="Theophany Pantaloons",waist="Witful Belt"}

    sets.midcast.Protectra = {ammo="Impatiens",ring1="Sheltered Ring",feet="Piety Duckbills",waist="Witful Belt",ring2="Prolix Ring",head="Umuthi Hat",
	ear2="Loquacious Earring"}
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = {ammo="Impatiens",ring1="Sheltered Ring",legs="Piety Pantaloons",waist="Witful Belt",ring2="Prolix Ring",head="Umuthi Hat",
	ear2="Loquacious Earring"}
	sets.midcast.Shell = sets.midcast.Shellra

    sets.midcast['Divine Magic'] = {main="Rubicundity",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ebers Bliaud",hands="Fanatic Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"}

    sets.midcast['Dark Magic'] = {main="Rubicundity",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ischemia Chasu.",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Gende. Galoshes"}

	sets.midcast.Drain = {main="Rubicundity",ammo="Kalboron Stone",
		head="Appetence Crown",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ischemia Chasu.",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Fucho-No-Obi",legs="Lengo Pants",feet="Gende. Galoshes"}
		
	sets.midcast.Aspir = sets.midcast.Drain
		
		
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Rubicundity",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ischemia Chasu.",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"}

	sets.midcast.IntEnfeebles = {main="Rubicundity",ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Ischemia Chasu.",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"}
    
	sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring",ring2="Mujin Band"}
	
    -- Sets to return to when not performing an action.
    
	--Nourishing Earring +1 (Cure Spellcasting -4%)*
	
	--Hygieia Clogs +1 (Cure Spellcasting -18%)
	--Mendi. Earring (Cure Spellcasting -5%)
	--Pahtli Cape (Cure Spellcasting -8%)
	--Nefer Kalasiris (Cure Spellcasting -10%)
	--Aceso's Choker +1 (Cure Spellcasting -13%)
	--Sors Shield (Cure Spellcasting -5%)
	
	--Total (Cure Spellcasting -63%) (w/o Earring = -59%)

	--------------------------------------------------------------------------------

	--Nourishing Earring +1 (Cure Potency +6-7%) *
	
	--Mendi. Earring (Cure Potency +5%)
	--Ebers Cap (Cure Potency +13%)
	--Nefer Kalasiris (Cure Potency +10%)
	--Tamaxchi (Cure Potency +22%)
	
	--Bokwus Gloves (Cure Potency +13%)
	--Sors Shield (Cure Potency +3%)
	
	--Total  (Cure Potency +72-73%)  (W/o Earring = +66%)
	
	-------------------------------------------------------------------------------
	
	--Glorious Earring (Cure Potency II +2%)
	
	
    -- Resting sets
    sets.resting = {ammo="Homiliary",
		head="Ebers Cap",neck="Twilight Torque",body="Ebers Bliaud",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		waist="Fucho-No-Obi",legs="Nares Trews",feet="Serpentes Sabots"}--refresh head soon.
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Bolelabunga",ammo="Homiliary",
		head="Ebers Cap",neck="Lissome Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaud",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Rubicundity",ammo="Homiliary",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaud",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Serpentes Sabots"}

    sets.idle.Town = {main="Bolelabunga",sub="Sors Shield",ammo="Homiliary",
		head="Ebers Cap",neck="Lissome Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaud",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    sets.idle.Weak = {main="Bolelabunga",ammo="Homiliary",
		head="Wivre Hairpin",neck="Lissome Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaud",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {
		head="Ebers Cap",neck="Twilight Torque",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {
		head="Nahtirah Hat",neck="Twilight Torque",
		body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",legs="Assiduity Pants +1",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Herald's Gaiters"}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {main="Rubicundity",ammo="Impatiens",
		head="Umuthi Hat",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Lengo Pants",feet="Medium's Sabots"}--Alhazen Hat

	sets.engaged.Acc = {main="Rubicundity",ammo="Impatiens",
		head="Alhazen Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Ebers Bliaud",hands="Gende. Gages +1",ring1="Varar Ring",ring2="Varar Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Lengo Pants",feet="Medium's Sabots"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
	sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
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
    -- Default macro set/book
    set_macro_page(1, 2)
end
