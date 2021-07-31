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
		body="Chironic Doublet",hands="Fanatic Gloves",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Ogapepo Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1",
	} --TEST
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash",feet="Regal Pumps +1"})

	----------------------------------------------------------------
	----------------------------------------------------------------
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {neck="Nodens Gorget",feet="Regal Pumps +1",legs="Doyen Pants"})
	
	----------------------------------------------------------------
	----------------------------------------------------------------

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons",feet="Regal Pumps +1"})--Ebers Pantaloons

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Queller Rod",sub="Sors Shield",ammo="Impatiens",hands="Fanatic Gloves",
	body="Nefer Kalasiris",ear2="Glorious Earring",ear1="Mendi. Earring",back="Pahtli Cape",neck="Aceso's Choker +1",feet="Hygieia Clogs +1",legs="Doyen Pants"}) --body="Heka's Kalasris",ear2="Glorious Earring",feet="Hygieia Clogs +1",legs="Ebers Pantaloons"
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Bliault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Unmoving Collar +1",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Ebers Bliaut",hands="Fanatic Gloves",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Lengo Pants",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {ammo="Floestone",
		head="Aya. Zucchetto +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="Rufescent Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}--Fanatic Gloves
    
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS,  {ammo="Pemphredo Tathlum",
		head="Aya. Zucchetto +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Chironic Doublet",hands="Fanatic Gloves",ring1="Fenrir Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"})--Fanatic Gloves
		
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,   {
		head="Aya. Zucchetto +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Levia. Ring",ring2="Rufescent Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"})--Fanatic Gloves
    
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {Ammo="Floestone",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Levia. Ring",ring2="Rufescent Ring",waist="Fotia Belt",back="Rancorous Mantle",head="Aya. Zucchetto +1",body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"})

    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Nahtirah Hat",ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Chironic Doublet",hands="Fanatic Gloves",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Swith Cape",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}
    
    -- Cure sets
    gear.default.obi_waist = "Witful Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = set_combine(sets.precast.FastRecast,   {main="Queller Rod",sub="Sors Shield",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Kaykaus Bliaut",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Alaunus's Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Medium's Sabots"}) --body="Heka's Kalasris"/Glorious Earring/Hygieia Clogs +1/Telchine Gloves

		--Cure Pot / Spellcast down / Cure Pot II
		--main		(Pot+10 Pot II+2 Spellcast-7)
		--sub		(Pot+3 Spellcast-5)
		
		--head 		(Pot+13%)
		--body		(Pot+5 Pot II +3)
		--hands		(Pot+10 FC+5)
		--legs		(Spellcast-12 FC+10)
		--feet		(Pot+10)
		
		--ammo		(QM+2)
		--ear1		(Pot+5 Spellcast-5)
		--ear2		(Pot II +2%)
		--neck		(Spellcast-13)
		--ring1		(FC+10 QM+5)
		--ring2		(FC+5)
		--waist		(FC+5 QM+3)
		--back		(Spellcast-8)
		
		--Total:	Pot+51 Pot II+7 Spellcast-50 FC+35 QM+10
    sets.midcast.Cure = set_combine(sets.precast.FastRecast,    {main="Queller Rod",sub="Sors Shield",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Kaykaus Bliaut",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Medium's Sabots"})--Queller Rod / Kaykaus Bliaut / Medium's Sabots / Telchine Gloves

    sets.midcast.Curaga = set_combine(sets.precast.FastRecast,    {main="Queller Rod",sub="Sors Shield",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Kaykaus Bliaut",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Medium's Sabots"})--Hygieia Clogs +1

    sets.midcast.CureMelee = set_combine(sets.precast.FastRecast,    {main="Queller Rod",sub="Sors Shield",ammo="Impatiens",
		head="Ebers Cap",neck="Aceso's Choker +1",ear2="Glorious Earring",ear1="Mendi. Earring",
		body="Kaykaus Bliaut",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Ebers Pantaloons",feet="Medium's Sabots"})--Hygieia Clogs +1

    sets.midcast.Cursna = set_combine(sets.precast.FastRecast,    {main="Beneficus",ammo="Impatiens",
		head="Ebers Cap",neck="Malison Medallion",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ebers Bliaut",hands="Fanatic Gloves",ring1="Ephedra Ring",ring2="Ephedra Ring",
		back="Alaunus's Cape",waist="Witful Belt",legs="Theo. Pant. +1",feet="Gendewitha Galoshes"})--Theo. Pant. +1 / 	Theo. Pantaloons

    sets.midcast.StatusRemoval = set_combine(sets.precast.FastRecast,    {ammo="Impatiens",back="Mending Cape",neck="Voltsurge Torque",hands="Fanatic Gloves",feet="Regal Pumps +1",
		head="Ebers Cap",legs="Ebers Pantaloons",waist="Witful Belt",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Kishar Ring"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FastRecast,    {main="Beneficus",ammo="Impatiens",neck="Incanter's Torque",
		body="Manasa Chasuble",hands="Fanatic Gloves",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Weatherspoon Ring",ring2="Kishar Ring",head="Umuthi Hat",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Piety Pantaloons",feet="Ebers Duckbills"})

    sets.midcast.Stoneskin = set_combine(sets.precast.FastRecast,   {ammo="Impatiens",
		head="Umuthi Hat",neck="Nodens Gorget",ear2="Loquacious Earring",ear1="Earthcry Earring",
		body="Ebers Bliaut",hands="Fanatic Gloves",ring2="Kishar Ring",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Haven Hose",feet="Regal Pumps +1"})

    sets.midcast.Auspice = set_combine(sets.precast.FastRecast,   {ammo="Impatiens",hands="Fanatic Gloves",ear1="Mendi. Earring",ear2="Loquacious Earring",feet="Ebers Duckbills",
	waist="Siegel Sash",ring1="Weatherspoon Ring",ring2="Kishar Ring"})

    sets.midcast.BarElement = set_combine(sets.precast.FastRecast,    {main="Beneficus",ammo="Impatiens",
		head="Ebers Cap",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Ebers Bliaut",hands="Ebers Mitts",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Ogapepo Cape",waist="Siegel Sash",legs="Ebers Pantaloons",feet="Ebers Duckbills"})

    sets.midcast.Regen = set_combine(sets.precast.Cure,    {main="Bolelabunga",ammo="Impatiens",
		body={ name="Telchine Chas.", augments={'Pet: Evasion+10','Pet: "Regen"+3','Pet: Damage taken -3%',}},hands="Ebers Mitts",ear1="Mendi. Earring",ear2="Loquacious Earring",ring1="Stikini Ring",ring2="Stikini Ring",head="Umuthi Hat",feet="Regal Pumps +1",neck="Incanter's Torque",
		legs="Theo. Pant. +1",waist="Witful Belt"})
	
	sets.midcast.Refresh = set_combine(sets.precast.FC['Enhancing Magic'], {feet="Inspirited Boots"})

    sets.midcast.Protectra = set_combine(sets.precast.FastRecast,   {ammo="Impatiens",ring1="Sheltered Ring",feet="Piety Duckbills",waist="Witful Belt",ring2="Stikini Ring",head="Umuthi Hat",neck="Incanter's Torque",
	ear2="Loquacious Earring"})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.precast.FastRecast,   {ammo="Impatiens",ring1="Sheltered Ring",legs="Piety Pantaloons",waist="Witful Belt",ring2="Stikini Ring",head="Umuthi Hat",neck="Incanter's Torque",
	ear2="Loquacious Earring"})
	sets.midcast.Shell = sets.midcast.Shellra

    sets.midcast['Divine Magic'] = set_combine(sets.precast.FastRecast,   {main="Rubicundity",ammo="Ombre Tathlum +1",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear2="Gwati Earring",ear1="Digni. Earring",
		body="Chironic Doublet",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Medium's Sabots"})

    sets.midcast['Dark Magic'] = set_combine(sets.precast.FastRecast,    {main="Rubicundity",ammo="Ombre Tathlum +1",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear2="Gwati Earring",ear1="Digni. Earring",
		body="Ischemia Chasu.",hands="Fanatic Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Refoccilation Stone",legs="Lengo Pants",feet="Gende. Galoshes"})

	sets.midcast.Drain = set_combine(sets.precast.FastRecast,    {main="Rubicundity",ammo="Ombre Tathlum +1",
		head="Appetence Crown",neck="Sanctity Necklace",ear2="Gwati Earring",ear1="Digni. Earring",
		body="Ischemia Chasu.",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Fucho-No-Obi",legs="Lengo Pants",feet="Gende. Galoshes"})
		
	sets.midcast.Aspir = sets.midcast.Drain
		
		
    -- Custom spell classes
    sets.midcast.MndEnfeebles = set_combine(sets.precast.FastRecast,   {main="Rubicundity",ammo="Ombre Tathlum +1",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear2="Gwati Earring",ear1="Digni. Earring",
		body="Ischemia Chasu.",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Medium's Sabots"})

	sets.midcast.IntEnfeebles = set_combine(sets.precast.FastRecast,   {main="Rubicundity",ammo="Ombre Tathlum +1",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear2="Gwati Earring",ear1="Digni. Earring",
		body="Ischemia Chasu.",hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}},ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Eschan Stone",legs="Lengo Pants",feet="Medium's Sabots"})
    
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
	
	--Kaykaus Bliaut	(Cure Potency+5% / Cure Potency II +3%)
	--Mendi. Earring (Cure Potency +5%)
	--Ebers Cap (Cure Potency +13%)
	--Nefer Kalasiris (Cure Potency +10%)
	--Tamaxchi (Cure Potency +22%)
	
	--Bokwus Gloves (Cure Potency +13%)
	--Sors Shield (Cure Potency +3%)
	
	--Total  (Cure Potency +72-73%)  (W/o Earring = +66%)
	
	-------------------------------------------------------------------------------
	
	--Glorious Earring (Cure Potency II +2%)
	--Kaykaus Bliaut	(Cure Potency+5% / Cure Potency II +3%)
	--Kaykaus Tights
	
    -- Resting sets
    sets.resting = {ammo="Homiliary",
		head="Befouled Crown",neck="Twilight Torque",body="Ebers Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		waist="Fucho-No-Obi",legs="Nares Trews",feet="Serpentes Sabots"}--refresh head soon.
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Bolelabunga",sub="Culminus",ammo="Homiliary",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Rubicundity",ammo="Homiliary",
		head="Wivre Hairpin",neck="Twilight Torque",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Assiduity Pants +1",feet="Serpentes Sabots"}

    sets.idle.Town = {main="Bolelabunga",sub="Culminus",ammo="Homiliary",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}--Sors Shield
    
    sets.idle.Weak = {main="Bolelabunga",sub="Culminus",ammo="Homiliary",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Mendi. Earring",ear2="Glorious Earring",
		body="Ebers Bliaut",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}

    sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Aya. Zucchetto +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}--Solemnity Cape

    sets.Kiting = {feet="Herald's Gaiters"}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {main="Rubicundity",ammo="Amar Cluster",
		head="Aya. Zucchetto +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Petrov Ring",ring2="Varar Ring",
		back="Umbra Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"}--Amar Cluster

	sets.engaged.Acc = set_combine(sets.precast.engaged,    {main="Rubicundity",ammo="Amar Cluster",
		head="Aya. Zucchetto +1",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",ring1="Cacoethic Ring +1",ring2="Varar Ring",
		back="Umbra Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Aya. Gambieras +1"})--Amar Cluster

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
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


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	
	if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
	
end


---------------------------------------------------------------------------------------------------------------------Auto Sublimation-----------------------------------
------------------------------------------------------------------------------------
--If MP is below 45% will auto-activate uppon using any spell 
--and 
--when it becomes "Complete" if MP is still Below 75% it will auto-activate uppon using any spell.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' then
        auto_sublimation()
    end
end
 
function auto_sublimation()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
        if not (buffactive['Invisible'] or buffactive['Weakness']) then
            if abil_recasts[234] == 0 then
                send_command('@wait 2;input /ja "Sublimation" <me>')
            end
        end
    elseif buffactive['Sublimation: Complete'] then
        if player.mpp < 45 and abil_recasts[234] == 0 then
            send_command('@wait 2;input /ja "Sublimation" <me>')
        end
    end         
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




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
