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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')
	
    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Buremte Hat",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Umbani Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
		head="Nahtirah Hat",neck="Jeweled Collar",ear2="Loquacious Earring",ear1="Estq. Earring",
		body="Duelist's Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Chelona Boots"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Jukukik Feather",
		head="Nahtirah Hat",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Emet Harness +1",hands="Leyline Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Fotia Belt",legs="Lengo Pants",feet="Umbani Boots"}--Thereoid Greaves

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {ammo="Aqua Satchet",ear1="Brutal Earring",ear2="Moonshade Earring",
		head="Gende. Caubeen",body="Emet Harness +1",hands="Leyline Gloves",neck="Fotia Gorget",ring1="Levia. Ring",ring2="Levia. Ring",
		waist="Fotia Belt"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, 
        {ammo="Jukukik Feather",ear1="Brutal Earring",ear2="Moonshade Earring",
		head="Gende. Caubeen",body="Emet Harness +1",hands="Leyline Gloves",neck="Fotia Gorget",ring1="Rajas Ring",ring2="Ramuh Ring",
		back="Rancorous Maniacus",waist="Fotia Belt",legs="Taeon Tights",feet="Thereoid Greaves"})
		
    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",ear1="Brutal Earring",
		ear2="Moonshade Earring",
		head="Gende. Caubeen",neck="Fotia Gorget",body="Gendewitha Bliaut",hands="Leyline Gloves",
		back="Rancorous Mantle",feet="Umbani Boots",ring2="Acumen Ring"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Nahtirah Hat",neck="Jeweled Collar",ear2="Loquacious Earring",ear1="Estq. Earring",
		body="Duelist's Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Chelona Boots"}

    sets.midcast.Cure = {ammo="Impatiens",
		head="Gendewitha Caubeen",neck="Jeweled Collar",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Nefer Kalasiris",hands="Bokwus Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Pahtli Cape",waist="Chuq'aba Belt",legs="Nares Trews",feet="Chelona Boots"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {ammo="Impatiens",
		head="Estq. Chappel +2",neck="Jeweled Collar",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Estq. Sayon +2",hands="Estq. Ganthrt. +2",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Estoqueur's Cape",waist="Siegel Sash",legs="Estqr. Fuseau +2",feet="Estq. Houseaux +2"}

    sets.midcast.Refresh = {body="Hagondes Coat",back="Estoqueur's Cape",legs="Estoqueur's Fuseau +2"}

    sets.midcast.Stoneskin = {waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose",head="Umuthi Hat"}
    
	sets.midcast.Protect = {head="Umuthi Hat",ring1="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect
 
    sets.midcast.Shell = {head="Umuthi Hat",ring1="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell
	
    sets.midcast['Enfeebling Magic'] = {ammo="Kalboron Stone",
		head="Estq. Chappel +2",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Estq. Sayon +2",hands="Estq. Ganthrt. +2",ring1="Weatherspoon Ring",ring2="Sangoma Ring",
		back="Swith Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Bokwus Boots"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Duelist's Chapeau +2"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Duelist's Chapeau +2"})
    
    sets.midcast['Elemental Magic'] = {ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Eddy Necklace",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Hagondes Coat",hands="Loagaeth Cuffs",ring2="Prolix Ring",ring1="Weatherspoon Ring",
		back="Ghostfyre Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}
    
	sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring"}
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {ammo="Kalboron Stone",
		head="Nahtirah Hat",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hagondes Coat",hands="Leyline Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
		back="Ghostfyre Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Umbani Boots"}

		sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {hands="Leyline Gloves",back="Swith Cape",waist="Witful Belt"})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Appetence Crown",waist="Fucho-No-Obi",ring1="Excelsis Ring"})--main="Rubicundity"

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {hands="Atrophy Gloves +1",back="Estoqueur's Cape",feet="Estoqueur's Houseaux +2",head="Umuthi Hat"}
        
    sets.buff.ComposureOther = {head="Estoqueur's Chappel +2",
		body="Estoqueur's Sayon +2",hands="Estoqueur's Gantherots +2",
		legs="Estoqueur's Fuseau +2",feet="Estoqueur's Houseaux +2"}

    sets.buff.Saboteur = {hands="Estoqueur's Gantherots +2"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Homiliary",
		head="Duelist's Chapeau",neck="Lissome Necklace",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Shadow Mantle",waist="Fucho-No-Obi",legs="Nares Trews",feet="Serpentes Sabots"}
    

    -- Idle sets
    sets.idle = {ammo="Homiliary",
		head="Duelist's Chapeau",neck="Lissome Necklace",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Blood Cuisses",feet="Serpentes Sabots"}

    sets.idle.Town = {main="Bolelabunga",sub="Beatific Shield",ammo="Homiliary",
		head="Duelist's Chapeau",neck="Lissome Necklace",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Blood Cuisses",feet="Serpentes Sabots"}
    
    sets.idle.Weak = {ammo="Homiliary",
		head="Duelist's Chapeau",neck="Lissome Necklace",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Emet Harness +1",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Prolix Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Blood Cuisses",feet="Serpentes Sabots"}

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Emet Harness +1",hands="Gendewitha Gages +1",ring2="Defending Ring",ring1="Dark Ring",
        back="Umbra Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Emet Harness +1",hands="Bokwus Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets
    sets.defense.PDT = {
		head="Hagondes Hat",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Umbani Boots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Emet Harness +1",hands="Bokwus Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Blood Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Jukukik Feather",
		head="Taeon Chapeau",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Taeon Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}

    sets.engaged.Defense = {ammo="Jukukik Feather",
		head="Buremte Hat",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Cetl Belt",legs="Lengo Pants",feet="Umbani Boots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)

	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 9)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 9)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 9)
	else
		set_macro_page(1, 9)
	end
end