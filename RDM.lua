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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Defense')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Salire Belt"
    
	state.MagicBurst = M(false, 'Magic Burst')
	
	 send_command('bind @` gs c activate MagicBurst')
	
    --select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard"}
    
	sets.precast.JA['Provoke'] = sets.enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Brigantia Pebble",
		head="Vitivation Chapeau",neck="Unmoving Collar +1",ear1="Roundel Earring",ear2="Soil Pearl",
		body="Vitivation Tabard",hands="Vitivation Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Chuq'aba Belt",legs="Vitivation Tights",feet="Vitivation Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
		head="Atrophy Chapeau",neck="Jeweled Collar",ear2="Loquacious Earring",ear1="Estq. Earring",
		body="Vitivation Tabard",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Chelona Boots +1"}--Psycloth Lappas

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",neck="Subtlety Spectacles",ear1="Sherida Earring",ear2="Moonshade Earring",ring1="Enlivened Ring",ring2="Ramuh Ring +1",waist="Caudata Belt",back="Atheling Mantle",head="Aya. Zucchetto +1",body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Ginsen",ear1="Sherida Earring",ear2="Moonshade Earring",
		head="Atrophy Chapeau",body="Lethargy Sayon",hands="Lurid Mitts",neck="Imbodla Necklace",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",legs="Psycloth Lappas",
		waist="Ovate Rope",back="Refraction Cape"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Kalboron Stone",ear1="Friomisi Earring",
		ear2="Hecate's Earring",
		head="Merlinic Hood",neck="Quanpur Necklace",body="Hagondes Coat",hands="Amalric Gages",
		back="Ghostfyre Cape",legs="Merlinic Shalwar",feet="Merlinic Crackows",ring1="Fenrir Ring",ring2="Fenrir Ring"}

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,  {ammo="Brigantia Pebble",neck="Subtlety Spectacles",ear1="Ishvara Earring",ear2="Moonshade Earring",ring1="Enlivened Ring",ring2="Ramuh Ring +1",waist="Caudata Belt",back="Atheling Mantle",
	})
    
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS,  {ammo="Brigantia Pebble",neck="Subtlety Spectacles",ear1="Sherida Earring",ear2="Moonshade Earring",ring1="Enlivened Ring",ring2="Ramuh Ring +1",waist="Caudata Belt",back="Kayapa Cape",
	})
	
	sets.precast.WS['Knights of Round'] = set_combine(sets.precast.WS,  {ammo="Brigantia Pebble",neck="Subtlety Spectacles",ear1="Ishvara Earring",ear2="Moonshade Earring",ring1="Enlivened Ring",ring2="Ramuh Ring +1",waist="Caudata Belt",back="Kayapa Cape",
	})

	--Aya. Zucchetto +1
	--Ayanmo Corazza +1
	--Aya. Manopolas +1
	--Aya. Cosciales +1
	--Aya. Gambieras +1
	
    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Atrophy Chapeau",neck="Jeweled Collar",ear2="Loquacious Earring",ear1="Estq. Earring",
		body="Vitivation Tabard",hands="Gende. Gages +1",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Chelona Boots +1"}

    sets.midcast.Cure = set_combine(sets.precast.FC ,   {ammo="Impatiens",
		head="Gendewitha Caubeen",neck="Weike Torque",ear1="Estoqueur's Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Ghostfyre Cape",waist="Chuq'aba Belt",legs="Atrophy Tights +1",feet="Chelona Boots +1"})--Pahtli/Roundel Earring/Mendi. Earring/Sors Shield
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {waist="Chuq'aba Belt"}--ring1="Kunaji Ring",ring2="Asklepian Ring"

    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FC , {ammo="Impatiens",
		head="Umuthi Hat",neck="Enhancing Torque",ear1="Estq. Earring",ear2="Loquacious Earring",body="Lethargy Sayon",hands="Atrophy Gloves +1",ring1="Weatherspoon Ring",ring2="Kishar Ring",back="Sucellos's Cape",waist="Witful Belt",legs="Lethargy Fuseau",feet="Lethargy Houseaux"})--Siegel Sash

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {body="Vitivation Tabard",back="Sucellos's Cape",legs="Lethargy Fuseau"})

	sets.midcast['Phalanx II'] = set_combine(sets.midcast['Enhancing Magic'], {hands="Vitivation Gloves"})
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat"})--waist="Siegel Sash",ear1="Earthcry Earring",legs="Haven Hose"
    
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],  {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
 
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],  {ring1="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell
	
    sets.midcast['Enfeebling Magic'] = {ammo="Kalboron Stone",
		head="Lethargy Chappel",neck="Imbodla Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Atrophy Tabard +1",hands="Lurid Mitts",ring1="Weatherspoon Ring",ring2="Leviathan Ring +1",
		back="Ghostfyre Cape",waist="Ovate Rope",legs="Psycloth Lappas",feet="Merlinic Crackows"}--Vitivation Boots +1

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})

	sets.midcast['Bio III'] =  set_combine(sets.midcast['Enfeebling Magic'], {legs="Vitivation Tights"})
	
	sets.midcast['Paralyze II'] =  set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation Boots"})
	
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {legs="Vitivation Tights"})
	
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau"})
    
    sets.midcast['Elemental Magic'] = {ammo="Dosis Tathlum",
		head="Merlinic Hood",neck="Mizukage-no-Kubikazari",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Amalric Gages",ring2="Mujin Band",ring1="Locus Ring",
		back="Ghostfyre Cape",waist="Salire Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}
        
	sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring",ring2="Mujin Band"}	
		
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {ammo="Dosis Tathlum",
		head="Lethargy Chappel",neck="Quanpur Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Atrophy Tabard +1",hands="Amalric Gages",ring1="Weatherspoon Ring",ring2="Fenrir Ring",
		back="Ghostfyre Cape",waist="Salire Belt",legs="Merlinic Shalwar",feet="Merlinic Crackows"}

		sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {hands="Gende. Gages +1",back="Swith Cape",waist="Witful Belt"})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {ammo="Kalboron Stone",ring1="Weatherspoon Ring",ring2="Fenrir Ring"})--head="Merlinic Hood",waist="Fucho-No-Obi",ring1="Excelsis Ring"

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {hands="Atrophy Gloves +1",back="Sucellos's Cape",feet="Lethargy Houseaux"}
        
    sets.buff.ComposureOther = {head="Lethargy Chappel",
		body="Lethargy Sayon",hands="Lethargy Gantherots",
		legs="Lethargy Fuseau",feet="Lethargy Houseaux"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Ginsen",
		head="Befouled Crown",neck="Arciela's Grace +1",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Vitivation Tabard",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Kishar Ring",
		back="Shadow Mantle",waist="Fucho-No-Obi",legs="Nares Trews",feet="Serpentes Sabots"}
    

    -- Idle sets
    sets.idle = {ammo="Ginsen",
		head="Befouled Crown",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Vitivation Tabard",hands="Vitivation Gloves",ring2="Defending Ring",ring1="Kishar Ring",
		back="Repulse Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Vitivation Boots"}--Homiliary/Fucho-No-Obi

    sets.idle.Town = {main="Excalibur",sub="Beatific Shield",ammo="Ginsen",
		head="Befouled Crown",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Vitivation Tabard",hands="Vitivation Gloves",ring2="Defending Ring",ring1="Kishar Ring",
		back="Repulse Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Vitivation Boots"}
    
    sets.idle.Weak = {ammo="Ginsen",
		head="Befouled Crown",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Vitivation Tabard",hands="Vitivation Gloves",ring2="Defending Ring",ring1="Kishar Ring",
		back="Repulse Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Vitivation Boots"}

    sets.idle.PDT = {ammo="Demonry Stone",
        head="Aya. Zucchetto +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Flume Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

    sets.idle.MDT = {ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Repulse Mantle",waist="Flume Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}
    
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +1",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Repulse Mantle",waist="Flume Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

    sets.defense.MDT = {ammo="Staunch Tathlum",
        head="Atrophy Chapeau",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring2="Defending Ring",ring1="Shadow Ring",
        back="Repulse Mantle",waist="Flume Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
	--Aya. Zucchetto +1
	--Ayanmo Corazza +1
	--Aya. Manopolas +1
	--Aya. Cosciales +1
	--Aya. Gambieras +1
	
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
		head="Aya. Zucchetto +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Rajas Ring",ring2="Ramuh Ring +1",
		back="Atheling Mantle",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}--Pya'ekue Belt

	sets.engaged.Acc = {ammo="Ginsen",
		head="Aya. Zucchetto +1",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Rajas Ring",ring2="Ramuh Ring +1",
		back="Atheling Mantle",waist="Kentarch Belt",legs="Carmine Cuisses +1",feet="Aya. Gambieras +1"}

		
    sets.engaged.Defense = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +1",neck="Twilight Torque",ear1="Estq. Earring",ear2="Loquacious Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring2="Defending Ring",ring1="Dark Ring",
		back="Repulse Mantle",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Hachirin-no-Obi"
    elseif spell.skill == 'Elemental Magic' then
        --gear.default.obi_waist = "Refoccilation Stone"
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

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

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        --spell.skill == 'Elemental Magic' then
          --  state.MagicBurst:reset()
        --end
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
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
	elseif player.sub_job == 'WHM' then
        set_macro_page(1, 3)
	elseif player.sub_job == 'BLM' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 3)
	elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end
end